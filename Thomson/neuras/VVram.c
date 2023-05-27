#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;
byte[4] RowFlags;


void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
}


void VErase2(byte x, byte y)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    pVVram[0] = 0;
    pVVram[1] = 0;
    pVVram[32] = 0;
    pVVram[32 + 1] = 0;
    SetRowFlags(y, 3);
}

void VPut2(byte x, byte y, byte pattern)
{
    ptr<byte> pVVram;
    byte c;
    pVVram = VVramBack + VVramOffset(x, y);
    c = (pattern << 2) + Char_Sprite;
    pVVram[0] = c++;
    pVVram[1] = c++;
    pVVram[32] = c++;
    pVVram[32 + 1] = c++;
    SetRowFlags(y, 3);
}
