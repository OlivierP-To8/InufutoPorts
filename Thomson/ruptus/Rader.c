#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 12 + 24 * VramStep;

void PrintRader()
{
    word vram;
    vram= LeftTop;
    repeat(12) {
        repeat(8) {
            vram = Put(vram, Char_Map);
        }
        vram += VramRowSize - 8 * VramStep;
    }
}


void DrawFortRader(byte x, byte y, bool visible)
{
    word w;
    w = ((word)(y & 0xf8) << 7) + ((x & 0xf8) >> 1);
    Put(LeftTop + w, visible ? Char_Map + 1 : Char_Map);
}


// void DrawFighterOnRader()
// {
//     // static const byte[] Bits = {
//     //     0xc0, 0x30, 0x0c, 0x03
//     // };
//     // byte x, y, b;
//     // word vram;
//     // x = (FighterX - 1) >> 1;
//     // y = (FighterY - 1) & 0xfe;

//     // b = Bits[x & 3];

//     // pVram = VramPointerToRader(x >> 2, y);
//     // pVram[0] ^= b;
//     // pVram[VramWidth] ^= b;
// }
