#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "VVram.h"
#include "Chars.h"

constexpr byte InvalidCode = 0xff;

Sprite[SpriteCount] Sprites;

void ShowSprite(byte index, byte x, byte y, sbyte pattern) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = (x + 4) >> 3;
    p->y = (y + 4) >> 3;
    p->pattern = pattern;
}

void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = InvalidCode;
}

void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (
            p->oldPattern != InvalidCode && (
                p->oldX != p->x || 
                p->oldY != p->y ||
                p->pattern == InvalidCode
            )
        ) {
            word offset;
            ptr<byte> pFront, pBack;
            offset = VVramOffset(p->oldX, p->oldY);
            pBack = VVramBack + offset;
            pFront = VVramFront + offset;
            pFront[0] = pBack[0];
            pFront[1] = pBack[1];
            pFront[32] = pBack[32];
            pFront[32 + 1] = pBack[32 + 1];
            SetRowFlags(p->oldY, 3);
        }
    }
}

void DrawSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidCode) {
            bool changed;
            ptr<byte> pFront;
            byte c;

            changed = p->oldX != p->x || p->oldY != p->y || p->oldPattern != p->pattern;
            pFront = VVramFront + VVramOffset(p->x, p->y);
            c = (p->pattern << 2) + Char_Sprite;
            pFront[0] = c++;
            pFront[1] = c++;
            pFront[32] = c++;
            pFront[32 + 1] = c++;
            if (changed) {
                SetRowFlags(p->y, 3);
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}

void InitSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = -1;
        p->oldPattern = -1;
    }
}
