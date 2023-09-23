#include "Stage.h"
#include "GroundEnemy.h"
#include "Sprite.h"
#include "VVram.h"
#include "Math.h"
#include "Main.h"
#include "EnemyBullet.h"
#include "Bang.h"
#include "Main.h"
#include "Sound.h"
#include "Chars.h"

// constexpr byte Size = 1 * CoordRate;
constexpr byte Count = Sprite_Fighter - Sprite_GroundEnemy;
constexpr byte RangeX = VVramWidth - 2 + 1;
constexpr byte RangeY = VVramHeight - 2 + 1;
constexpr byte InvalidY = 0xff;
// constexpr byte HitMask = CoordMask >> 1;

constexpr byte Color = 0xb8;
constexpr byte Type_Fixed = 0;
constexpr byte Type_Movable = 1;

static const word[] Points = { 3, 5 };
GroundEnemy[Count] GroundEnemies;


void InitGroundEnemies()
{
    byte sprite;
    ptr<GroundEnemy> pEnemy;
    sprite = Sprite_GroundEnemy;
    for (pEnemy : GroundEnemies) {
        pEnemy->sprite = sprite;
        pEnemy->y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<GroundEnemy> pEnemy)
{
    ShowSprite(
        pEnemy->sprite, pEnemy->x, pEnemy->y, 
        (pEnemy->type << 2 ) + Char_GroundEnemy
    );
}


static void End(ptr<GroundEnemy> pEnemy)
{
    pEnemy->y = InvalidY;
    HideSprite(pEnemy->sprite);
}


void StartGroundEnemy()
{
    // byte y;
    // y = topRow + TileSize;
    while (groundElementCount > 0 && pGroundElement->y == topRow) {
        ptr<GroundEnemy> pEnemy;
        for (pEnemy : GroundEnemies) {
            if (pEnemy->y >= RangeY) {
                pEnemy->x = pGroundElement->x;
                pEnemy->y = (pGroundElement->y - topRow);
                if (pGroundElement->routeCount > 0) {
                    ptr<Route> pRoute;
                    pEnemy->type = Type_Movable;
                    pEnemy->routeCount = pGroundElement->routeCount;
                    pRoute = pGroundElement->pRoute;
                    pEnemy->pRoute = pRoute;
                    pEnemy->dx = pRoute->dx;
                    pEnemy->dy = pRoute->dy;
                    pEnemy->moveCount = pRoute->count;
                }
                else {
                    pEnemy->type = Type_Fixed;
                }
                pEnemy->clock = 0;
                Show(pEnemy);
                break;
            }
        }
        ++pGroundElement;
        --groundElementCount;
    }
}


void ScrollGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;
        ++pEnemy->y;
        if (pEnemy->y >= RangeY) {
            End(pEnemy);
        }
        else {
            Show(pEnemy);
        }
    }
}


void MoveGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;

        ++pEnemy->clock;
        if (
            Rnd() < CurrentStage + 1
        ) {
            StartEnemyBullet(pEnemy->x, pEnemy->y);
        }
        if (pEnemy->type == Type_Fixed) continue;

        pEnemy->x += pEnemy->dx;
        pEnemy->y += pEnemy->dy;
        if (pEnemy->x >= RangeX || pEnemy->y >= RangeY) {
            End(pEnemy);
            continue;
        }
        else {
            Show(pEnemy);
        }

        --pEnemy->moveCount;
        if (pEnemy->moveCount == 0) {
            if (pEnemy->routeCount > 0) {
                ptr<Route> pRoute;
                ++pEnemy->pRoute;
                pEnemy->routeCount;
                pRoute = pEnemy->pRoute;
                pEnemy->dx = pRoute->dx;
                pEnemy->dy = pRoute->dy;
                pEnemy->moveCount = pRoute->count;
            }
        }
    }
}


static void Destroy(ptr<GroundEnemy> pEnemy)
{
    // Sound_SmallBang();
    Sound_Hit();
    StartBang(pEnemy->x + 1, pEnemy->y + 1, false);
    End(pEnemy);
    AddScore(Points[pEnemy->type]);
}


bool HitBulletGroundEnemy(byte x, byte y)
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;
        if (
            x + 1 >= pEnemy->x && x < pEnemy->x + 2 &&
            y + 1 >= pEnemy->y && y < pEnemy->y + 2
        ) {
            Destroy(pEnemy);
            return true;    
        }
    }
    return false;
}
