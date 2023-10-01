#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;

static const byte[] ColorBytes = {
    64, 0x0f,
    16, 0x05,
    3, 0x0e,
    2, 0x9d,
    5, 0x0f,
    0
};


void InitVram()
{
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
    MakePatternColor(Char_BarrierHead, ColorPatternSource, Char_End - Char_BarrierHead);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void VPut2(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void VErase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void VPut4(word vram, ptr<byte> pBytes)
{
    repeat (4) {
        repeat (4) {
            vram = Put(vram, *pBytes);
            ++pBytes;
        }
        vram += VramRowSize - 4 * VramStep;
    }
}
