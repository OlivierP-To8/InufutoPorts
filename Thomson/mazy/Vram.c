#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Wall - Char_Space,       ColorRam, FormeBlanc);
    MakeMono(Char_Man - Char_Wall,         ColorRam + Char_Wall * CharHeight, FormeCyan);
    //MakeMono(Char_Chaser - Char_Man,       ColorRam + Char_Man * CharHeight, FormeBlanc);
    //MakeMono(Char_Disturber - Char_Chaser, ColorRam + Char_Chaser * CharHeight, FormeMagenta);
    MakeColor(Char_Disturber - Char_Man,   ColorRam + Char_Man * CharHeight);
    MakeMono(Char_Goal - Char_Disturber,   ColorRam + Char_Disturber * CharHeight, FormeRouge);
    MakeMono(Char_Bang - Char_Goal,        ColorRam + Char_Goal * CharHeight, FormeBlanc);
    MakeMono(Char_Title - Char_Bang,       ColorRam + Char_Bang * CharHeight, FormeJaune);
    // Title colors
    MakeMono(4, ColorRam + Char_Title * CharHeight, FormeBlanc);
    MakeMono(4, ColorRam + (Char_Title + 4) * CharHeight, FormeMagenta);
    MakeMono(4, ColorRam + (Char_Title + 8) * CharHeight, FormeJaune);
    MakeMono(4, ColorRam + (Char_Title + 12) * CharHeight, FormeRouge);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word Put2(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
