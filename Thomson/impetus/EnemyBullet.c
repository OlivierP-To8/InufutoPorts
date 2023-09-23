#include "EnemyBullet.h"
#include "Sprite.h"
#include "VVram.h"
#include "Fighter.h"
#include "Math.h"
#include "Chars.h"

constexpr byte Count = Sprite_Item - Sprite_EnemyBullet;
constexpr byte Color = 0xd8;
constexpr byte RangeX = VVramWidth;
constexpr byte RangeY = VVramHeight;

constexpr byte HiVelocity = 100;
constexpr byte LoVelocity = HiVelocity * 70 / 100; // sin 45
constexpr byte LongVelocity = HiVelocity * 92 / 100; // cos 22.5
constexpr byte ShortVelocity = HiVelocity * 38 / 100; // sin 22.5
constexpr byte InvalidY = 0xff;

EnemyBullet[Count] EnemyBullets;

void InitEnemyBullets() 
{
    byte sprite;
    ptr<EnemyBullet> pBullet;
    sprite = Sprite_EnemyBullet;
    for (pBullet : EnemyBullets) {
        pBullet->sprite = sprite;
        pBullet->y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<EnemyBullet> pBullet)
{
    ShowSprite(pBullet->sprite, pBullet->x, pBullet->y, Char_EnemyBullet);
}


bool StartEnemyBullet(byte x, byte y)
{
    byte sprite;
    ptr<EnemyBullet> pBullet;

    sprite = Sprite_EnemyBullet;
    for (pBullet : EnemyBullets) {
        // byte rnd;
        if (pBullet->y < RangeY) continue;

        // rnd = Rnd() & 3;
        // if (rnd == 3) rnd = 0;

        pBullet->dx = Sign(x, FighterX); 
        pBullet->dy = Sign(y, FighterY); 
        if (pBullet->dx != 0 && pBullet->dy != 0) {
            byte lx, ly;
            lx = Abs(x, FighterX);
            ly = Abs(y, FighterY);
            if (lx < ly) {
                pBullet->numeratorX = ShortVelocity;
                pBullet->numeratorY = LongVelocity;
            }
            else if (lx > ly) {
                pBullet->numeratorX = LongVelocity;
                pBullet->numeratorY = ShortVelocity;
            }
            else {
                pBullet->numeratorX = LoVelocity;
                pBullet->numeratorY = LoVelocity;
            }
        }
        else {
            pBullet->numeratorX = HiVelocity;
            pBullet->numeratorY = HiVelocity;
        }
        pBullet->x = x;
        pBullet->y = y;
        pBullet->clock = 0;
        pBullet->denominatorX = 0;
        pBullet->denominatorY = 0;
        Show(pBullet);
        return true;
    }
    return false;
}


void MoveEnemyBullets()
{
    ptr<EnemyBullet> pBullet;
    for (pBullet : EnemyBullets) {
        if (pBullet->y >= RangeY) continue;

        pBullet->denominatorX -= pBullet->numeratorX;
        if (pBullet->denominatorX < 0) {
            pBullet->x += pBullet->dx;
            pBullet->denominatorX += HiVelocity;
        }
        pBullet->denominatorY -= pBullet->numeratorY;
        if (pBullet->denominatorY < 0) {
            pBullet->y += pBullet->dy;
            pBullet->denominatorY += HiVelocity;
        }
        if (
            pBullet->x >= RangeX || pBullet->y >= RangeY ||
            (
                HitBulletFighter(pBullet->x, pBullet->y)
            )
        ) {
            HideSprite(pBullet->sprite);
            pBullet->y = InvalidY;
        }
        else {
            Show(pBullet);
            ++pBullet->clock;
        }
    }
}
