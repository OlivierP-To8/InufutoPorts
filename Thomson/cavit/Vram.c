#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,   ColorRam, 0x0f);
    MakeMono(Char_Bedrock - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x03);
    MakeMono(Char_Man - Char_Bedrock,  ColorRam + Char_Bedrock * CharHeight, 0x07);
    MakeColor(Char_Ghost - Char_Man,   ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Ghost2 - Char_Ghost, ColorRam + Char_Ghost * CharHeight, 0x0b);
    MakeMono(Char_Chaser - Char_Ghost2, ColorRam + Char_Ghost2 * CharHeight, 0x01);
    MakeMono(Char_Chaser2 - Char_Chaser, ColorRam + Char_Chaser * CharHeight, 0x0f);
    MakeMono(Char_Rock - Char_Chaser2, ColorRam + Char_Chaser2 * CharHeight, 0x0b);
    MakeMono(Char_Point - Char_Rock,   ColorRam + Char_Rock * CharHeight, 0x0f);
    MakeMono(Char_Box - Char_Point,    ColorRam + Char_Point * CharHeight, 0x0f);
    MakeMono(Char_End - Char_Box,      ColorRam + Char_Box * CharHeight, 0x08);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
