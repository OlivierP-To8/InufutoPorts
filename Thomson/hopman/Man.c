#include "Man.h"
#include "Stage.h"
#include "Chars.h"
#include "Sprite.h"
#include "../ScanKeys.h"
#include "Sound.h"
#include "Goal.h"
#include "Vram.h"
#include "Main.h"
#include "Lift.h"
#include "VVram.h"

constexpr byte SpriteColor = 15;
constexpr byte Bottom = FloorCount * FloorHeight + StageTop - 3;

Man Man;

static void Show()
{
    byte pattern;
    pattern = Man.pattern;
    if ((Man.status & Man_Jump) != 0) {
        pattern += 4;
    }
    else if (Man.dx != 0) {
        byte seq;
        seq = Man._.x & 3;
        if (seq == 3) seq = 1;
        pattern += (seq + 1) << 2;
    }
    ShowSprite(&Man._, pattern);
}


void InitMan()
{
    Man._.sprite = Sprite_Man;
    Man._.x = 0;
    Man._.y = Bottom;
    Man.dx = 0;
    Man.dy = 0;
    Man.pattern = Char_Man;
    Man.status = Man_Live;
    Man.clock = 0;
    Show();
}


static bool IsOn()
{
    return IsOnFloor(&Man._) || IsManOnAnyLift();
}


void MoveMan()
{
    struct Direction {
        byte key;
        byte pattern;
        sbyte dx;
    };
    static const Direction[] Directions = {
        { Keys_Left, Char_Man_Left, -1 },
        { Keys_Right, Char_Man_Right, 1 },
    };
    byte oldY;
    oldY = Man._.y;
    {
        byte key;
        ptr<Direction> pDirection;
        sbyte dx;
        byte pattern;
        Man.dx = 0;
        key = ScanKeys();
        if (
            (key & Keys_Button0) != 0 &&
            Man.dy == 0 && IsOn()
        ) {
            // Sound_Jump();
            Man.dy = -3;
            Man.clock = 0;
            Man.status |= Man_Jump;
        }
        for (pDirection: Directions) {
            if ((pDirection->key & key) != 0) {
                dx = pDirection->dx;
                pattern = pDirection->pattern;
                goto keyMatch;
            }
        }
        goto move;
        
        keyMatch:
        if (CanMoveX(&Man._, dx)) {
            Man.dx = dx;
            Man.pattern = pattern;
        }
    }
    move:
    if (Man.dx != 0) {
        MoveX(&Man._, Man.dx);
        Scroll();
    }
    if (Man.dy > 0) {
        byte nextY;
        ptr <Lift> pLift;
        nextY = Man._.y + Man.dy;
        pLift = FindLift(&Man._, nextY);
        if (pLift != nullptr) {
            nextY = pLift->_.y - 2;
            Man.dy = 0;
            Man.status &= ~Man_Jump;
        }
        else {
            byte floor, nextFloor;
            floor = YToFloor(Man._.y + (FloorHeight - Offset_Head));
            nextFloor = YToFloor(nextY + (FloorHeight - Offset_Head));
            if (nextFloor > floor && IsFloor(&Man._, floor)) {
                nextY = FloorToY(floor) + Offset_Head;
                Man.dy = 0;
                Man.status &= ~Man_Jump;
            }
        }
        Man._.y = nextY;
    }
    else if (Man.dy < 0) {
        byte floor, nextY, nextFloor;
        floor = YToFloor(Man._.y + Offset_Head);
        nextY = Man._.y + Man.dy;
        nextFloor = YToFloor(nextY + Offset_Head);
        if (nextFloor < floor && IsFloor(&Man._, nextFloor)) {
            Man.dy = 0;
            Man.status &= ~Man_Jump;
        }
        Man._.y = nextY;
    }
    Show();
    if (
        Man._.y > oldY &&
        (YToFloor(Man._.y) == FloorCount || IsOnNeedle(&Man._))
    ) {
        Man.status &= ~Man_Live;
    }
    ++Man.clock;
    if (
        // ((Man.status & Man_Jump) == 0 || (Man.clock & CoordMask) == 0) &&
        (!IsOn() || Man.dy != 0)
    ) {
        ++Man.dy;
        Man.status |= Man_Jump;
    }
    if ((Man._.x & ColumnMask) == 0) {
        if (GetCellAt(&Man._) == Cell_Item) {
            byte column, floor;
            column = XToColumn(Man._.x);
            floor = YToFloor(Man._.y);
            SetCell(column, floor, Cell_Floor);
            AddScore(10);
            Sound_Hit();
            // MapToVram();
            --ItemCount;
        }
    }
    if (Man._.x == GoalX && Man._.y == GoalY) {
        Cleared = true;
    }
}


void LooseMan()
{
    static const byte[] patterns = {
        Char_Man_Left,
        Char_Man_Loose0,
        Char_Man_Loose1,
        Char_Man_Loose2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}


bool IsManOnLift(byte x, byte y)
{
    if (IsNexrX(Man._.x, x)) {
        byte bottom;
        bottom = Man._.y + 2;
        return bottom == y;
    }
    return false;
}


bool MoveManOnLift(ptr<Movable> pLift, sbyte dx, byte oldY)
{
    if (IsManOnLift(pLift->x, oldY)) {
        Man._.y = pLift->y - 2;
        MoveX(&Man._, dx);
        if (dx != 0) {
            Scroll();
        }
        Show();
        return true;
    }
    return false;
}
