#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Man.h"
#include "Stage.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "Fire.h"
#include "Status.h"
#include "VVram.h"

static const byte[] JumpHeights = {
    1, 3, 4, 5, 6, 7, 8, 8, 8, 8, 7, 6, 5, 4, 3, 1,    
};

Actor Man;
byte JumpSeq;
byte PowerTime;
static byte MinY;
static byte oldKeyX, oldKeyY;

extern void _deb();
void ShowMan()
{
    byte pattern;
    if (Man.pattern != Char_Man_Climb) {
        if (Man.dx == 0) {
            pattern = Man.pattern;
        }
        else {
            constexpr byte Horizontal = Char_Man_Left0 - Char_Man_Left;
            byte seq;
            seq = Man.status & Actor_SeqMask;
            if (seq == 3) {
                seq = 1;
            }
            pattern = Man.pattern + Horizontal + (seq << 2);
        }
    }
    else {
        byte seq;
        seq = Man.status & 1;
        pattern = Man.pattern + (seq << 2);
    }
    if (PowerTime == 0 || (PowerTime & 0x02) == 0) {
        if ((Man.status & Man_Jump) == 0) {
            ShowSprite(&Man._, pattern);
        }
        else {
            --Man._.y;
            ShowSprite(&Man._, pattern);
            ++Man._.y;
        }
    }
    else {
        HideSprite(Man._.sprite);
    }
}


void InitMan()
{
    byte height;
    height = pStage->height;
    Man._.x = 0;
    Man._.y = (height << 2) + Overhead;
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live;
    Man.dx = 0;
    Man.dy = 0;
    Man.pattern = Char_Man_Right;
    PowerTime = 0;
    MinY = Man._.y;
    oldKeyX = 0;
    oldKeyY = 0;
    ShowMan();
}


static bool TestMoveX(byte key)
{
    sbyte dx;
    dx = 0;
    if (
        IsOnFloor(Man._.y) ||
        GetCellType(Man._.x, Man._.y + 2) != CellType_Ladder
    ) {
        if (
            (key & Keys_Left) != 0 &&
            CanMove(&Man, -1)
        ) {
            dx = -1;
            Man.pattern = Char_Man_Left;
        }
        else if (
            (key & Keys_Right) != 0 &&
            CanMove(&Man, 1)
        ) {
            dx = 1;
            Man.pattern = Char_Man_Right;
        }
    }
    Man.dx = dx;
    return Man.dx != 0;
}

static bool TestMoveY(byte key)
{
    if ((Man.status & (Man_Fall | Man_Jump)) == 0) {
        sbyte dy;
        dy = 0;
        if ((Man.status & Man_Jump) == 0) {
            if ((Man._.x & 1) == 0) {
                if ((key & Keys_Up) != 0) {
                    if (IsOnFloor(Man._.y)) {
                        if (GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder) {
                            up:
                            dy = -1;
                            Man.dx = 0;
                            Man.pattern = Char_Man_Climb;
                        }
                    }
                    else {
                        if (
                            GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder ||
                            GetCellType(Man._.x, Man._.y + FloorHeight) == CellType_Ladder
                        )
                        goto up;
                    }
                }
                else if ((key & Keys_Down) != 0) {
                    if (IsOnFloor(Man._.y)) {
                        if (GetCellType(Man._.x, Man._.y + FloorHeight) == CellType_Ladder) {
                            down:
                            dy = 1;
                            Man.dx = 0;
                            Man.pattern = Char_Man_Climb;
                        }
                    }
                    else {
                        if (
                            GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder // ||
                        )
                        goto down;
                    }
                }
            }
        }
        Man.dy = dy;
    }
    return Man.dy != 0;
}

void MoveMan()
{
    byte key, keyX, keyY;
    if ((Man.status & Actor_Live) == 0) return;
    key = ScanKeys();
    keyX = key & Keys_DirX;
    if ((key & Keys_Dir) != 0) {
        if (TestMoveX(keyX)) {
            oldKeyX = keyX;
            oldKeyY = 0;
            goto moved;
        }
        else {
            if (oldKeyX != 0) {
                if (TestMoveX(oldKeyX)) {
                    oldKeyY = 0;
                }
            }
        }
        keyY = key & Keys_DirY;
        if (TestMoveY(keyY)) {
            oldKeyY = keyY;
            oldKeyX = 0;
        }
        else {
            if (oldKeyY != 0) {
                if (TestMoveY(oldKeyY)) {
                    oldKeyX = 0;
                }
            }
        }
    }
    else {
        Man.dx = 0;
        Man.dy = 0;
        // oldKeyX = 0;
        // oldKeyY = 0;
    }
    moved:
    if ((Man.status & (Man_Fall | Man_Jump)) == 0) {
        if (
            (key & Keys_Button0) != 0 &&
            IsOnFloor(Man._.y) &&
            Man.dy == 0
        ) {
            Man.status |= Man_Jump;
            JumpSeq = 0;
        }
    }
    MoveActor(&Man);
    if (Man.dy != 0) {
        Scroll();
    } 
    else if ((Man.status & Man_Jump) != 0) {
        ++JumpSeq;
        if (JumpSeq < CoordRate * 2 + 1) {
            HitUnderBlock();
        }
        else {
            HitOverBlock();
            Man.status &= ~Man_Jump;
        }
    }
    while (MinY > Man._.y) {
        AddScore(1);
        --MinY;
    }
    exit:
    ShowMan();
}


void FallMan()
{
    if ((Man.status & Man_Jump) == 0) {
        if (IsOnFloor(Man._.y)) {
            if (
                (Man._.x & 1) == 0 && 
                GetCellType(Man._.x, Man._.y) == CellType_Hole
            ) goto fall;
            goto stop;
        }
        else if (
            GetCellType(Man._.x, Man._.y + 2) != CellType_Ladder
        ) {
            fall:
            Man.status |= Man_Fall;
            Man.dy = 1;
        }
        else {
            stop:
            Man.status &= ~Man_Fall;
            Man.dy = 0;
        }
    }
    if ((Man.status & Man_Fall) != 0) {
        MoveActorY(&Man);
    }
}


void Scroll()
{
    byte y, newTopY, newOffset, t;
    y = Man._.y;
    newTopY = y - (WindowHeight / 2) - FloorHeight;
    if (newTopY != topY && newTopY < topYRange) {
        topY = newTopY;
        DrawBackground();
        return;
    }
}


void HitMan(ptr<Actor> pActor)
{
    if (IsNearXY(&pActor->_, &Man._)) {
        if ((pActor->status & Item_1Up) != 0) {
            if (RemainCount < 10) {
                ++RemainCount;
                PrintStatus();
                Sound_Item();
                goto get;
            }
        }
        else if ((pActor->status & Item_Power) != 0) {
            PowerTime = 100 - CurrentStage;
            AddScore(10);
            Sound_Item();
            get:
            pActor->status &= ~Actor_Live;
            HideSprite(pActor->_.sprite);
        } 
        else if (PowerTime == 0) {
            Man.status &= ~Actor_Live;
        }
    }
}


void LooseMan()
{
    static const byte[] patterns = {
        Char_Man_Left_Stop,
        Char_Man_Loose0,
        Char_Man_Loose1,
        Char_Man_Loose2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, patterns[i & 3]);
        // UpdateSprites();
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
    Man.status &= ~Actor_Live;
}
