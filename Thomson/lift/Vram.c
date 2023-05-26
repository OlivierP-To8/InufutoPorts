#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;

void InitVram()
{
    MakePatternMono(Char_Ascii, MonoPatternSource, 0x40, 0x0f);
    MakePatternMono(Char_Logo, MonoPatternSource + Char_Logo * CharHeight, 16 + 1, 0x0e);
    // {
    //     byte c;
    //     c = Char_Logo;
    //     do {
    //         MakePatternMono(c, MonoPatternSource + (Char_Logo + 15) * CharHeight, 1, c & 15);
    //         ++c;
    //     } while (c < Char_Logo + 16);
    // }
    MakePatternMono(Char_LiftBottom, MonoPatternSource + Char_LiftBottom * CharHeight, 1, 0x39);
    MakePatternMono(Char_Roof, MonoPatternSource + Char_Roof * CharHeight, 3, 0x01);
    MakePatternColor(Char_Man, ColorPatternSource, Char_End - Char_Man);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
