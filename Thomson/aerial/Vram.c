#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[PatternSize * Char_End] PatternRam;
byte[PatternSize * Char_End] ColorRam;

void InitVram()
{
    MakeMono(Char_Logo - Char_Ascii,            ColorRam, 0x0f);
    MakeMono(Char_MyBulet - Char_Logo,          ColorRam + Char_Logo * CharHeight, 0x03);
    MakeMono(Char_EnemyBullet - Char_MyBulet,   ColorRam + Char_MyBulet * CharHeight, 0x0f);
    MakeMono(Char_MyFighter - Char_EnemyBullet, ColorRam + Char_EnemyBullet * CharHeight, 0x0e);
    MakeMono(Char_EnemyFighter_Left - Char_MyFighter, ColorRam + Char_MyFighter * CharHeight, 0x0f);
    MakeMono(Char_EnemyFighter_Right - Char_EnemyFighter_Left, ColorRam + Char_EnemyFighter_Left * CharHeight, 0x0a);
    MakeMono(Char_Track - Char_EnemyFighter_Right, ColorRam + Char_EnemyFighter_Right * CharHeight, 0x0b);
    MakeMono(Char_Rocket - Char_Track,          ColorRam + Char_Track * CharHeight, 0x04);
    MakeMono(Char_SmallBang - Char_Rocket,      ColorRam + Char_Rocket * CharHeight, 0x0f);
    MakeMono(Char_Item - Char_SmallBang,        ColorRam + Char_SmallBang * CharHeight, 0x0a);
    MakeMono(Char_Fort - Char_Item,             ColorRam + Char_Item * CharHeight, 0x0c);
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