#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii, ColorRam, 0x0f);
    MakeMono(Char_Wall - Char_Logo,  ColorRam + Char_Logo * CharHeight, 0x05);
    MakeColor(Char_End - Char_Wall,  ColorRam + Char_Wall * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}

/*
void Print2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}*/
