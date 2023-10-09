#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,       ColorRam, 0x0f);
    MakeMono(Char_Barrier - Char_Logo,     ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(Char_Map - Char_Barrier,      ColorRam + Char_Barrier * CharHeight, 0x03);
    MakeMono(Char_Star - Char_Map,         ColorRam + Char_Map * CharHeight, 0x06);
    MakeMono(Char_BarrierHead - Char_Star, ColorRam + Char_Star * CharHeight, 0x03);
    MakeMono(Char_Fighter - Char_BarrierHead, ColorRam + Char_BarrierHead * CharHeight, 0x0d);
    MakeMono(Char_Enemy - Char_Fighter,    ColorRam + Char_Fighter * CharHeight, 0x0f);
    MakeMono(Char_Item - Char_Enemy,       ColorRam + Char_Enemy * CharHeight, 0x0b);
    MakeMono(Char_SmallBang - Char_Item,   ColorRam + Char_Item * CharHeight, 0x0c);
    MakeMono(Char_Fort - Char_SmallBang,   ColorRam + Char_SmallBang * CharHeight, 0x0a);
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
