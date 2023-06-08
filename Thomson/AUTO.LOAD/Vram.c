#include "Vram.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource;

byte[PatternSize * Char_End] PatternRam;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, MonoPatternSource, Char_End, 0x0f);
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = Put(vram, c - ' ');
        ++p;
    }
    return vram;
}
