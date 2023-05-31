#include "Bang.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte MaxCount = SpriteCount - Sprite_Bang;
constexpr byte Size = 2;
constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte InvalidSprite = 0x80;

Bang[MaxCount] Bangs;
static const byte[4] Colors = { 8, 11, 10, 9 };

void InitBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->status = Status_None;
    }
}


void StartBang(byte x, byte y, bool large)
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if ((pBang->status & 0xf0) != Status_None) continue;

        pBang->x = x;
        pBang->y = y;
        pBang->status = large ? Status_Large_Small : Status_Small;
        return;
    }
}


void UpdateBangs()
{
    byte x, y, sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        byte mode, count, color;
        mode = pBang->status & 0xf0;
        if (mode == Status_None) continue;
        count = pBang->status & 0x0f;

        x = pBang->x;
        y = pBang->y;
        if (mode == Status_Large_Large) {
            byte pattern;
            x -= Size / 2;
            y -= Size / 2;
            pattern = Char_LargeBang;
            repeat (2) {
                repeat (2) {
                    ShowSprite(sprite, x, y, pattern);
                    ++sprite;
                    pattern += 4;
                    x += Size;
                }
                x -= Size * 2;
                y += Size;
            }
        }
        else {
            ShowSprite(sprite, x, y, Char_SmallBang);
            ++sprite;
        }

        ++count;
        if (count >= 8) {
            if (mode == Status_Large_Small) {
                pBang->status = Status_Large_Large;
            }
            else {
                pBang->status = Status_None;
            }
        }
        else {
            pBang->status = mode | count;
        }
    }
    while (sprite < SpriteCount) {
        HideSprite(sprite);
        ++sprite;
    }
}