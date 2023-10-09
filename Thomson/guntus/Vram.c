#include "Vram.h"
#include "VVram.h"
#include "Chars.h"


void InitVram()
{
    ClearScreen();
    InitAsciiPattern();
    InitMonoPattern();
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (4) {
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
        repeat (4) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
