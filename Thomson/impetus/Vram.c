#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

constexpr byte Char_Color = Char_BarrierHead;

byte[PatternSize * Char_Color] PatternRam;

void InitVram()
{
    static const byte[] ColorBytes = {
        64, 0x0f,
        16, 0x05,
        4, 0x07,
        1, 0x04,
        1, 0x09,
        4, 0x07,
        1, 0x0f,
        2, 0x0e,
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
    // MakePatternColor(Char_BarrierHead, ColorPatternSource, Char_End - Char_BarrierHead);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
