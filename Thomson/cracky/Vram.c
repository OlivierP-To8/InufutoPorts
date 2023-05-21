#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakePatternMono(Char_Ascii, MonoPatternSource, 0x40, 0x0f);
    MakePatternMono(Char_Logo, MonoPatternSource + Char_Logo * CharHeight, 16 + 8 + 1, 0x05);
    MakePatternMono(Char_Ladder, MonoPatternSource + Char_Ladder * CharHeight, 2, 0x07);
    MakePatternMono(Char_Item, MonoPatternSource + Char_Item * CharHeight, 4, 0x0e);
    MakePatternColor(Char_Man, ColorPatternSource, Char_End - Char_Man);
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
