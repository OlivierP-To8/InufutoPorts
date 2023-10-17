#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,      ColorRam, FormeBlanc);
    MakeMono(Char_Floor - Char_Logo,      ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_LiftBottom - Char_Floor, ColorRam + Char_Floor * CharHeight, FormeJaune);
    MakeMono(Char_Roof - Char_LiftBottom, ColorRam + Char_LiftBottom * CharHeight, FormeBlanc);
    MakeMono(Char_Man - Char_Roof,        ColorRam + Char_Roof * CharHeight, FormeRouge);
    MakeColor(Char_Monster - Char_Man,    ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Lift - Char_Monster,    ColorRam + Char_Monster * CharHeight, FormeMagenta);
    MakeMono(Char_Point - Char_Lift,      ColorRam + Char_Lift * CharHeight, FormeCyan);
    MakeMono(Char_End - Char_Point,       ColorRam + Char_Point * CharHeight, FormeBlanc);
    // Item flag color
    MakeMono(1, ColorRam + Char_Item_A_Flag * CharHeight, FormeJaune);
    MakeMono(1, ColorRam + Char_Item_B_Flag * CharHeight, FormeRouge);
    MakeMono(1, ColorRam + Char_Item_C_Flag * CharHeight, FormeVert);
    MakeMono(1, ColorRam + Char_Item_D_Flag * CharHeight, FormeBleu);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
