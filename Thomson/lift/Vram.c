#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,      ColorRam, 0x0f);
    MakeMono(Char_LiftBottom - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x0e);
    MakeMono(Char_Roof - Char_LiftBottom, ColorRam + Char_LiftBottom * CharHeight, 0x05);
    MakeMono(Char_Man - Char_Roof,        ColorRam + Char_Roof * CharHeight, 0x01);
    MakeColor(Char_End - Char_Man,        ColorRam + Char_Man * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
