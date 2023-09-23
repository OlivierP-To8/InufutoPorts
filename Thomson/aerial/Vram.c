#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,            ColorRam, 0x0f);
    MakeMono(Char_MyBulet - Char_Logo,          ColorRam + Char_Logo * CharHeight, 0x03);
    MakeMono(Char_EnemyBullet - Char_MyBulet,   ColorRam + Char_MyBulet * CharHeight, 0x0f);
    MakeMono(Char_MyFighter - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, 0x0e);
    MakeColor(Char_End - Char_MyFighter,        ColorRam + Char_MyFighter * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}