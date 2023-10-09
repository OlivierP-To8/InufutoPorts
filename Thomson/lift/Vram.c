#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,      ColorRam, 0x0f);
    MakeMono(Char_LiftBottom - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x0e);
    MakeMono(Char_Roof - Char_LiftBottom, ColorRam + Char_LiftBottom * CharHeight, 0x05);
    MakeMono(Char_Man - Char_Roof,        ColorRam + Char_Roof * CharHeight, 0x01);
    MakeColor(Char_Monster - Char_Man,    ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Lift - Char_Monster,    ColorRam + Char_Monster * CharHeight, 0x06);
    MakeMono(Char_Point - Char_Lift,      ColorRam + Char_Lift * CharHeight, 0x02);
    MakeMono(Char_End - Char_Point,       ColorRam + Char_Point * CharHeight, 0x0f);
    // Item flag color
    MakeMono(1, ColorRam + Char_Item_A_Flag * CharHeight, 0x04);
    MakeMono(1, ColorRam + Char_Item_B_Flag * CharHeight, 0x0a);
    MakeMono(1, ColorRam + Char_Item_C_Flag * CharHeight, 0x0c);
    MakeMono(1, ColorRam + Char_Item_D_Flag * CharHeight, 0x0d);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
