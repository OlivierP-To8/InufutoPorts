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
        16, 0x09,
        14 * 4,0x0f,
        4, 0x0f,
        4, 0x0d,
        4, 0x0e,
        4, 0x0b,
        4, 0x05,
        4, 0x06,
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
    MakePatternColor(Char_Solver, ColorPatternSource, Char_End - Char_Solver);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Print2x2(word vram, byte c) 
{
    c = (c << 2) + Char_Sprite;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}

void Erase2x2(word vram) 
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, 0);
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
