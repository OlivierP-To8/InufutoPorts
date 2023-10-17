#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    ClearScreen();
    MakeMono(Char_Logo - Char_Space, ColorRam, FormeBlanc);
    MakeMono(Char_Star - Char_Logo, ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_FighterBullet - Char_Star, ColorRam + Char_Star * CharHeight, FormeBlanc);
    MakeMono(Char_EnemyBullet - Char_FighterBullet, ColorRam + Char_FighterBullet * CharHeight, FormeBlanc);
    MakeMono(Char_EnemyA - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, FormeJaune);
    //MakeMono(Char_EnemyB - Char_EnemyA, ColorRam + Char_EnemyA * CharHeight, FormeMagenta);
    MakeColor(Char_EnemyB - Char_EnemyA, ColorRam + Char_EnemyA * CharHeight);
    MakeMono(Char_EnemyC - Char_EnemyB, ColorRam + Char_EnemyB * CharHeight, FormeJaune);
    MakeMono(Char_Fighter - Char_EnemyC, ColorRam + Char_EnemyC * CharHeight, FormeRouge);
    MakeMono(Char_Bang - Char_Fighter, ColorRam + Char_Fighter * CharHeight, FormeBlanc);
    MakeMono(Char_Item - Char_Bang, ColorRam + Char_Bang * CharHeight, FormeRouge);
    MakeMono(Char_End - Char_Item, ColorRam + Char_Item * CharHeight, FormeVert);
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
