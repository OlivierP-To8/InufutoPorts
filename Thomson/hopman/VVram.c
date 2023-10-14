#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Goal.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToVVram();
    DrawGoal();
    DrawSprites();
    VVramToVram();
}
