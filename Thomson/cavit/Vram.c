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
    MakeColor(Char_End - Char_Man,     ColorRam + Char_Man * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
