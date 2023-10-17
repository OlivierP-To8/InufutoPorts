#include "Vram.h"
#include "../VramColor.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,            ColorRam, FormeBlanc);
    MakeMono(Char_Ground - Char_Logo,           ColorRam + Char_Logo * CharHeight, FormeJaune);
    MakeMono(Char_MyBulet - Char_Ground,        ColorRam + Char_Ground * CharHeight, FormeJaune);
    MakeMono(Char_EnemyBullet - Char_MyBulet,   ColorRam + Char_MyBulet * CharHeight, FormeBlanc);
    MakeMono(Char_MyFighter - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, FormeJaune);
    MakeMono(Char_EnemyFighter_Left - Char_MyFighter, ColorRam + Char_MyFighter * CharHeight, FormeBlanc);
    MakeMono(Char_EnemyFighter_Right - Char_EnemyFighter_Left, ColorRam + Char_EnemyFighter_Left * CharHeight, FormeRouge);
    MakeMono(Char_Track - Char_EnemyFighter_Right, ColorRam + Char_EnemyFighter_Right * CharHeight, FormeMagenta);
    MakeMono(Char_Rocket - Char_Track,          ColorRam + Char_Track * CharHeight, FormeVert);
    MakeMono(Char_SmallBang - Char_Rocket,      ColorRam + Char_Rocket * CharHeight, FormeBlanc);
    MakeMono(Char_Item - Char_SmallBang,        ColorRam + Char_SmallBang * CharHeight, FormeRouge);
    MakeMono(Char_Fort - Char_Item,             ColorRam + Char_Item * CharHeight, FormeVert);
    MakeColor(Char_End - Char_Fort,             ColorRam + Char_Fort * CharHeight);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}