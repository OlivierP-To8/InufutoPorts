#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    static const byte[] ColorBytes = {
        64, 0x0f,
        16, 0x05,
        2, 0x02, // Char_Wall
        1, 0x07, // Char_HardWall
        4, 0x0e, // Char_Meter
        0
    };
    ptr<byte> pColor, pPattern;
    byte c, count, color;

    pColor = ColorBytes;
    pPattern = MonoPatternSource;
    c = Char_Ascii;
    while ((count = *pColor) != 0) {
        ++pColor;
        color = *pColor;
        ++pColor;
        MakePatternMono(c, pPattern, count, color);
        c += count;
        pPattern += ((word)count << 3);
    }
    MakePatternColor(Char_MyFort, ColorPatternSource, Char_End - Char_MyFort);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
