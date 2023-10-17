#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii, ColorRam, FormeBlanc);
    MakeMono(Char_Wall - Char_Logo,  ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_Block - Char_Wall, ColorRam + Char_Wall * CharHeight, FormeBlanc);
    MakeMono(Char_Man - Char_Block,  ColorRam + Char_Block * CharHeight, FormeCyan);
    MakeColor(Char_Monster - Char_Man, ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Point - Char_Monster, ColorRam + Char_Monster * CharHeight, FormeMagenta);
    MakeMono(Char_End - Char_Point,  ColorRam + Char_Point * CharHeight, FormeBlanc);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
