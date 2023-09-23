#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,     ColorRam, 0x0f);
    MakeMono(Char_Wall - Char_Logo,      ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(Char_HardWall - Char_Wall,  ColorRam + Char_Wall * CharHeight, 0x02);
    MakeMono(Char_Meter - Char_HardWall, ColorRam + Char_HardWall * CharHeight, 0x07);
    MakeMono(Char_MyFort - Char_Meter,   ColorRam + Char_Meter * CharHeight, 0x0e);
    MakeColor(Char_End - Char_MyFort,    ColorRam + Char_MyFort * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
