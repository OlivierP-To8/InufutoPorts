#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Wall - Char_Ascii,  ColorRam, 0x0f);
    MakeMono(Char_Card - Char_Wall,   ColorRam + Char_Wall * CharHeight, 0x09);
    MakeMono(Char_N      - Char_Card, ColorRam + Char_Card * CharHeight, 0x0f);
    MakeMono(Char_E      - Char_N,    ColorRam + Char_N * CharHeight, 0x0f);
    MakeMono(Char_U      - Char_E,    ColorRam + Char_E * CharHeight, 0x0d);
    MakeMono(Char_R      - Char_U,    ColorRam + Char_U * CharHeight, 0x0e);
    MakeMono(Char_A      - Char_R,    ColorRam + Char_R * CharHeight, 0x0b);
    MakeMono(Char_S      - Char_A,    ColorRam + Char_A * CharHeight, 0x05);
    MakeMono(Char_Solver - Char_S,    ColorRam + Char_S * CharHeight, 0x06);
    MakeColor(Char_Monster - Char_Solver, ColorRam + Char_Solver * CharHeight);
    MakeMono(Char_End - Char_Monster, ColorRam + Char_Monster * CharHeight, 0x0b);
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
