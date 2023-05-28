#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;

void InitVram()
{
    MakePatternMono(Char_Ascii, MonoPatternSource, 0x40, 0x0f);
    MakePatternMono(Char_Logo, MonoPatternSource + Char_Logo * CharHeight, 16 + 1, 0x05);
    MakePatternColor(Char_Wall, ColorPatternSource, Char_End - Char_Wall);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
