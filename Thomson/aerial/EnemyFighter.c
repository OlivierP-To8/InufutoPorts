#include "EnemyFighter.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"
#include "Math.h"
#include "Bullet.h"
#include "Sound.h"
#include "Bang.h"
#include "Main.h"
#include "EnemyBullet.h"
#include "MyFighter.h"
#include "MyBullet.h"

constexpr byte Count = Sprite_GroundEnemy - Sprite_EnemyFighter;
constexpr byte InvalidY = 0xff;
constexpr byte RangeX = (StageWidth - 1);

constexpr byte FireMask = (1 << 2) - 1;

struct Type {
    byte x;
    sbyte dx;
    sbyte bulletOffset;
    byte pattern;
    byte point;
};

static const Type[] types = {
    { RangeX, -1, 0, Char_EnemyFighter_Left, 10 },
    { 0, 1, 1, Char_EnemyFighter_Right, 15 },
};

EnemyFighter[Count] EnemyFighters;


void InitEnemyFighters()
{
    byte sprite;
    ptr<EnemyFighter> pFighter;
    sprite = Sprite_EnemyFighter;
    for (pFighter : EnemyFighters) {
        pFighter->_.sprite = sprite;
        pFighter->_.y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<EnemyFighter> pFighter)
{
    ptr<Type> pType;
    pType = types + pFighter->type;
    ShowFighter(&pFighter->_, pType->pattern);
}


static void End(ptr<EnemyFighter> pFighter)
{
    pFighter->_.y = InvalidY;
    HideSprite(pFighter->_.sprite);
}


void StartEnemyFighter(byte type)
{
    byte y;
    ptr<EnemyFighter> pFighter;
    y = Rnd() & 0x0f;
    if (y >= MinGroundY) return;
    for (pFighter : EnemyFighters) {
        ptr<Type> pType;
        if (pFighter->_.y != InvalidY) continue;
        pType = types + type;
        pFighter->type = type;
        pFighter->_.x = pType->x;
        pFighter->_.y = y;
        pFighter->_.clock = 0;
        Show(pFighter);
        return;
    }
}


void MoveEnemyFighters()
{
    ptr<EnemyFighter> pFighter;
    byte bottom;
    bottom = (MinGroundY - 4);
    for (pFighter : EnemyFighters) {
        ptr<Type> pType;
        if (pFighter->_.y == InvalidY) continue;
        if ((pFighter->_.clock & 3) == 0) {
            pType = types + pFighter->type;
            pFighter->_.x += pType->dx;
            if (pFighter->_.y > bottom) {
                --pFighter->_.y;
            }
            if (
                pFighter->_.x >= RangeX ||
                HitMovableMyFighter(pFighter->_.x, pFighter->_.y)
            ) {
                End(pFighter);
                continue;
            }
            if (
                (pFighter->_.clock & FireMask) == 0 &&
                pFighter->_.y >= 4 &&
                (Rnd()) < CurrentStage + 1 &&
                Sign(pFighter->_.x, MyFighter.x) == pType->dx
            ) {
                ptr<Bullet> pBullet;
                pBullet = StartEnemyBullet(
                    (pFighter->_.x + pType->bulletOffset) << BulletShift, 
                    (pFighter->_.y + 1) << BulletShift
                );
                if (pBullet != nullptr) {
                    pBullet->dx = pType->dx;
                    if (Abs(pFighter->_.y, MyFighter.y) < 1) {
                        pBullet->dy = 0;
                        pBullet->numeratorX = HiVelocity * 4 / 3;
                        pBullet->numeratorY = HiVelocity * 4 / 3;
                    }
                    else {
                        pBullet->dy = Sign(pFighter->_.y, MyFighter.y);
                        pBullet->numeratorX = LongVelocity * 4 / 3;
                        pBullet->numeratorY = ShortVelocity * 4 / 3;
                    }
                }
            }
        }
        Show(pFighter);
        ++pFighter->_.clock;
    }
}


bool HitBulletEnemyFighter(byte x, byte y)
{
    ptr<EnemyFighter> pFighter;
    for (pFighter : EnemyFighters) {
        if (pFighter->_.y == InvalidY) continue;
            if (HitMyBullet(&pFighter->_, x, y)) {
            ptr<Type> pType;
            pType = types + pFighter->type;
            // Sound_SmallBang();
            Sound_Hit();
            StartSmallBang(pFighter->_.x + 1, pFighter->_.y + 1);
            End(pFighter);
            AddScore(pType->point);
            return true;    
        }
    }
    return false;
}
