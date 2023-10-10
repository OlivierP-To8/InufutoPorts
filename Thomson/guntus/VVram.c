#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "EnemyRow.h"
#include "Star.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        ClearVVram();
        DrawStars();
        DrawEnemyRows();
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
        BackgroundChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
}


ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2 * VramStep;
    }
    return pVVram + 2 * VramStep - VVramWidth * 2;
}
