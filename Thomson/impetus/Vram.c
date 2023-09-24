#include "Vram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii, ColorRam, 0x0f);
    MakeMono(Char_Terrain - Char_Logo, ColorRam + Char_Logo * CharHeight, 0x05);
    MakeMono(4, ColorRam + Char_Terrain * CharHeight, 0x07);
    MakeMono(1, ColorRam + (Char_Terrain + 4) * CharHeight, 0x04);
    MakeMono(1, ColorRam + (Char_Terrain + 5) * CharHeight, 0x09);
    MakeMono(4, ColorRam + (Char_Terrain + 6) * CharHeight, 0x07);
    MakeMono(Char_EnemyBullet - Char_FighterBullet, ColorRam + Char_FighterBullet * CharHeight, 0x0f);
    MakeMono(Char_BarrierHead - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, 0x0e);
    MakeMono(Char_Fighter - Char_BarrierHead, ColorRam + Char_BarrierHead * CharHeight, 0x0b);
    MakeMono(Char_SkyEnemyA - Char_Fighter, ColorRam + Char_Fighter * CharHeight, 0x0f);
    MakeMono(Char_SkyEnemyB - Char_SkyEnemyA, ColorRam + Char_SkyEnemyA * CharHeight, 0x0a);
    MakeMono(Char_SkyEnemyC - Char_SkyEnemyB, ColorRam + Char_SkyEnemyB * CharHeight, 0x05);
    MakeMono(Char_GroundEnemy - Char_SkyEnemyC, ColorRam + Char_SkyEnemyC * CharHeight, 0x0e);
    MakeMono(Char_Bang - Char_GroundEnemy, ColorRam + Char_GroundEnemy * CharHeight, 0x0f);
    MakeMono(Char_Item - Char_Bang, ColorRam + Char_Bang * CharHeight, 0x0a);
    MakeMono(Char_Fort - Char_Item, ColorRam + Char_Item * CharHeight, 0x0c);
    MakeColor(Char_End - Char_Fort, ColorRam + Char_Fort * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
