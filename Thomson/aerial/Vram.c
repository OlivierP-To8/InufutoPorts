#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] MonoPatternSource, ColorPatternSource, BulletPatternSource;

byte[PatternSize * Char_End] PatternRam;

void InitVram()
{
    MakePatternMono(Char_Ascii, MonoPatternSource, 0x40, 0x0f);
    MakePatternMono(Char_Logo, MonoPatternSource + Char_Logo * CharHeight, 16 + 3, 0x03);
    MakePatternMono(Char_MyBulet, BulletPatternSource, 4, 0x0f);
    MakePatternMono(Char_EnemyBullet, BulletPatternSource, 4, 0x0e);
    MakePatternColor(Char_MyFighter, ColorPatternSource, Char_End - Char_MyFighter);
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
