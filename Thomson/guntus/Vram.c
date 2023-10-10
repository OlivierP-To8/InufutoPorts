#include "Vram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    ClearScreen();
    MakeMono(Char_Logo - Char_Space, ColorRam, 0x0f);
    MakeMono(Char_Star - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(Char_FighterBullet - Char_Star, ColorRam + Char_Star * CharHeight, 0x0f);
    MakeMono(Char_EnemyBullet - Char_FighterBullet, ColorRam + Char_FighterBullet * CharHeight, 0x0f);
    MakeMono(Char_EnemyA - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, 0x0e);
    //MakeMono(Char_EnemyB - Char_EnemyA, ColorRam + Char_EnemyA * CharHeight, 0x0b);
    MakeColor(Char_EnemyB - Char_EnemyA, ColorRam + Char_EnemyA * CharHeight);
    MakeMono(Char_EnemyC - Char_EnemyB, ColorRam + Char_EnemyB * CharHeight, 0x0e);
    MakeMono(Char_Fighter - Char_EnemyC, ColorRam + Char_EnemyC * CharHeight, 0x0a);
    MakeMono(Char_Bang - Char_Fighter, ColorRam + Char_Fighter * CharHeight, 0x0f);
    MakeMono(Char_Item - Char_Bang, ColorRam + Char_Bang * CharHeight, 0x0a);
    MakeMono(Char_End - Char_Item, ColorRam + Char_Item * CharHeight, 0x0c);
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
