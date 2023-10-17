#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,       ColorRam, FormeBlanc);
    MakeMono(Char_Ladder - Char_Logo,      ColorRam + Char_Logo * CharHeight, FormeJaune);
    MakeMono(Char_Floor - Char_Ladder,     ColorRam + Char_Ladder * CharHeight, FormeJaune);
    MakeMono(Char_Man - Char_Floor,        ColorRam + Char_Floor * CharHeight, FormeBleu);
    MakeColor(Char_Fire - Char_Man,        ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Monster - Char_Fire,     ColorRam + Char_Fire * CharHeight, FormeRouge);
    MakeMono(Char_Item_1Up - Char_Monster, ColorRam + Char_Monster * CharHeight, FormeMagenta);
    MakeMono(Char_Block - Char_Item_1Up,   ColorRam + Char_Item_1Up * CharHeight, FormeVert);
    MakeMono(Char_End - Char_Block,        ColorRam + Char_Block * CharHeight, FormeCyan);
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
