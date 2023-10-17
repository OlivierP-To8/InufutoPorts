#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,     ColorRam, FormeBlanc);
    MakeMono(Char_Wall - Char_Logo,      ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_HardWall - Char_Wall,  ColorRam + Char_Wall * CharHeight, FormeRouge);
    MakeMono(Char_Meter - Char_HardWall, ColorRam + Char_HardWall * CharHeight, FormeBlanc);
    MakeMono(Char_MyFort - Char_Meter,   ColorRam + Char_Meter * CharHeight, FormeJaune);
    MakeColor(Char_MyRobo - Char_MyFort, ColorRam + Char_MyFort * CharHeight);
    MakeMono(Char_EnemyRobo - Char_MyRobo, ColorRam + Char_MyRobo * CharHeight, FormeBlanc);
    MakeMono(Char_SmallBang - Char_EnemyRobo, ColorRam + Char_EnemyRobo * CharHeight, FormeVert);
    MakeMono(Char_End - Char_SmallBang, ColorRam + Char_SmallBang * CharHeight, FormeRouge);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
