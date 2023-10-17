#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,       ColorRam, FormeBlanc);
    MakeMono(Char_Barrier - Char_Logo,     ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(Char_Map - Char_Barrier,      ColorRam + Char_Barrier * CharHeight, FormeJaune);
    MakeMono(Char_Star - Char_Map,         ColorRam + Char_Map * CharHeight, FormeCyan | FondBleu);
    MakeMono(Char_BarrierHead - Char_Star, ColorRam + Char_Star * CharHeight, FormeBlanc);
    MakeMono(Char_Fighter - Char_BarrierHead, ColorRam + Char_BarrierHead * CharHeight, FormeMagenta);
    MakeMono(Char_Enemy - Char_Fighter,    ColorRam + Char_Fighter * CharHeight, FormeBlanc);
    MakeMono(Char_Item - Char_Enemy,       ColorRam + Char_Enemy * CharHeight, FormeMagenta);
    MakeMono(Char_SmallBang - Char_Item,   ColorRam + Char_Item * CharHeight, FormeVert);
    MakeMono(Char_Fort - Char_SmallBang,   ColorRam + Char_SmallBang * CharHeight, FormeRouge);
    MakeColor(Char_End - Char_Fort,        ColorRam + Char_Fort * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void VPut2(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void VErase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void VPut4(word vram, ptr<byte> pBytes)
{
    repeat (4) {
        repeat (4) {
            vram = Put(vram, *pBytes);
            ++pBytes;
        }
        vram += VramRowSize - 4 * VramStep;
    }
}
