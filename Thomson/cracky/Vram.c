#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,  ColorRam, FormeBlanc);
    MakeMono(Char_Ladder - Char_Logo, ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_Item - Char_Ladder, ColorRam + Char_Ladder * CharHeight, FormeBlanc);
    MakeMono(Char_Man - Char_Item,    ColorRam + Char_Item * CharHeight, FormeJaune);
    MakeColor(Char_Monster - Char_Man, ColorRam + Char_Man * CharHeight);
    MakeMono(Char_End - Char_Monster, ColorRam + Char_Monster * CharHeight, FormeMagenta);
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
