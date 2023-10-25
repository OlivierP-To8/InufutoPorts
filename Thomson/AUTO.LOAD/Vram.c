#include "Vram.h"


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = Put(vram, c - ' ');
        ++p;
    }
    return vram;
}
