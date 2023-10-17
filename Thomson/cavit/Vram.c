#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,   ColorRam, FormeBlanc);
    MakeMono(Char_Bedrock - Char_Logo, ColorRam + Char_Logo * CharHeight, FormeJaune);
    MakeMono(Char_Man - Char_Bedrock,  ColorRam + Char_Bedrock * CharHeight, FormeBlanc);
    MakeColor(Char_Ghost - Char_Man,   ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Ghost2 - Char_Ghost, ColorRam + Char_Ghost * CharHeight, FormeMagenta);
    MakeMono(Char_Chaser - Char_Ghost2, ColorRam + Char_Ghost2 * CharHeight, FormeBleu | FondJaune);
    MakeMono(Char_Chaser2 - Char_Chaser, ColorRam + Char_Chaser * CharHeight, FormeBlanc);
    MakeMono(Char_Rock - Char_Chaser2, ColorRam + Char_Chaser2 * CharHeight, FormeMagenta);
    MakeMono(Char_Point - Char_Rock,   ColorRam + Char_Rock * CharHeight, FormeBlanc);
    MakeMono(Char_Box - Char_Point,    ColorRam + Char_Point * CharHeight, FormeBlanc);
    MakeMono(Char_End - Char_Box,      ColorRam + Char_Box * CharHeight, FormeRouge | FondJaune);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
