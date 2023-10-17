#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,           ColorRam, FormeBlanc);
    MakeMono(Char_Block - Char_Logo,           ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_Item - Char_Block,           ColorRam + Char_Block * CharHeight, FormeBleu);
    MakeMono(Char_Line_Normal - Char_Item,     ColorRam + Char_Item * CharHeight, FormeJaune);
    MakeMono(Char_Line_Red - Char_Line_Normal, ColorRam + Char_Line_Normal * CharHeight, FormeBlanc);
    MakeMono(Char_Man - Char_Line_Red,         ColorRam + Char_Line_Red * CharHeight, FormeRouge);
    MakeColor(Char_Monster - Char_Man,         ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Point - Char_Monster,        ColorRam + Char_Monster * CharHeight, FormeMagenta);
    MakeMono(Char_Increaser - Char_Point,      ColorRam + Char_Point * CharHeight, FormeBlanc);
    MakeMono(Char_End - Char_Increaser,        ColorRam + Char_Increaser * CharHeight, FormeVert);
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
