#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii, ColorRam, FormeBlanc);
    MakeMono(Char_Terrain - Char_Logo, ColorRam + Char_Logo * CharHeight, FormeCyan);
    MakeMono(4, ColorRam + Char_Terrain * CharHeight, FormeRouge);
    MakeMono(1, ColorRam + (Char_Terrain + 4) * CharHeight, FormeVert);
    MakeMono(1, ColorRam + (Char_Terrain + 5) * CharHeight, FormeCyan);
    MakeMono(4, ColorRam + (Char_Terrain + 6) * CharHeight, FormeRouge);
    MakeMono(Char_EnemyBullet - Char_FighterBullet, ColorRam + Char_FighterBullet * CharHeight, FormeBlanc);
    MakeMono(Char_BarrierHead - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, FormeJaune);
    MakeMono(Char_Fighter - Char_BarrierHead, ColorRam + Char_BarrierHead * CharHeight, FormeMagenta);
    MakeMono(Char_SkyEnemyA - Char_Fighter, ColorRam + Char_Fighter * CharHeight, FormeBlanc);
    MakeMono(Char_SkyEnemyB - Char_SkyEnemyA, ColorRam + Char_SkyEnemyA * CharHeight, FormeRouge);
    MakeMono(Char_SkyEnemyC - Char_SkyEnemyB, ColorRam + Char_SkyEnemyB * CharHeight, FormeCyan);
    MakeMono(Char_GroundEnemy - Char_SkyEnemyC, ColorRam + Char_SkyEnemyC * CharHeight, FormeJaune);
    MakeMono(Char_Bang - Char_GroundEnemy, ColorRam + Char_GroundEnemy * CharHeight, FormeBlanc);
    MakeMono(Char_Item - Char_Bang, ColorRam + Char_Bang * CharHeight, FormeRouge);
    MakeMono(Char_Fort - Char_Item, ColorRam + Char_Item * CharHeight, FormeVert);
    MakeColor(Char_End - Char_Fort, ColorRam + Char_Fort * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
