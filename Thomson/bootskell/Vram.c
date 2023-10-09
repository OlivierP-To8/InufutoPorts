#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii, ColorRam, 0x0f);
    MakeMono(Char_Wall - Char_Logo,  ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(Char_Block - Char_Wall, ColorRam + Char_Wall * CharHeight, 0x07);
    MakeMono(Char_Man - Char_Block,  ColorRam + Char_Block * CharHeight, 0x05);
    MakeColor(Char_Monster - Char_Man, ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Point - Char_Monster, ColorRam + Char_Monster * CharHeight, 0x0b);
    MakeMono(Char_End - Char_Point,  ColorRam + Char_Point * CharHeight, 0x0f);
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
