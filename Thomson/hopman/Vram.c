#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,   ColorRam, 0x0f);
    MakeMono(Char_Floor - Char_Logo,   ColorRam + Char_Logo * CharHeight, 0x07);
    MakeMono(Char_Needle - Char_Floor, ColorRam + Char_Floor * CharHeight, 0x05);
    MakeMono(Char_Man - Char_Needle,   ColorRam + Char_Needle * CharHeight, 0x0f);
    MakeColor(Char_Item - Char_Man,    ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Monster - Char_Item, ColorRam + Char_Item * CharHeight, 0x0f);
    MakeMono(Char_Lift - Char_Monster, ColorRam + Char_Monster * CharHeight, 0x06);
    MakeMono(Char_End - Char_Lift,     ColorRam + Char_Lift * CharHeight, 0x02);
    // Item flag color
    MakeMono(1, ColorRam + (Char_Item + 1) * CharHeight, 0x0d);
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
