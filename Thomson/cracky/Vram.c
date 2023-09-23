#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,  ColorRam, 0x0f);
    MakeMono(Char_Ladder - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(Char_Item - Char_Ladder, ColorRam + Char_Ladder * CharHeight, 0x07);
    MakeMono(Char_Man - Char_Item,    ColorRam + Char_Item * CharHeight, 0x0e);
    MakeColor(Char_End - Char_Man,    ColorRam + Char_Man * CharHeight);
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
