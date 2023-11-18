// Thomson Floppy Disk BIN Loader by OlivierP-To8
// https://github.com/OlivierP-To8

#include "../ScanKeys.h"
#include "Vram.h"
#include "File.h"

extern byte[maxFiles*nameSize] filename;
byte[maxFiles] filebank;  // mem bank where the game is loaded
byte nbbanks;
constexpr byte startLine = 6;

void InitMemBank()
{
    byte n, b;
    n = 0;
    while (n < maxFiles)
    {
        b = n + 2;        // bank 0 and 1 are unavailable
        if (b >= nbbanks) // last bank is always from floppy
        {
            b = 0;
        }
        filebank[n++] = b;
    }
}

void Main()
{
    byte nbFiles;

    PrintS(Vram, "Thomson adaptation of the Inufuto games");
    PrintS(Vram + 3*VramRowSize + 12*VramStep, "by OlivierP-To8");
    PrintS(Vram + 22*VramRowSize + 3*VramStep, "A joystick is highly recommended.");

    nbFiles = listBinFiles();
    if (nbFiles > 0)
    {
        word vram;
        ptr<byte> p;
        byte sel, key;

        vram = Vram + startLine*VramRowSize + 17*VramStep;
        sel = 0;
        p = filename;
        while (sel < nbFiles)
        {
            PrintS(vram, p);
            vram += VramRowSize;
            p += nameSize;
            sel++;
        }

        sel = 0;
        vram = Vram + startLine*VramRowSize + 16*VramStep;
        Put(vram, 30);
        do
        {
            key = ScanKeys();
            if ((key == Keys_Down) && (sel < nbFiles-1))
            {
                sel++;
                Put(vram, 0);
                vram += VramRowSize;
                Put(vram, 30);
            }
            else if ((key == Keys_Up) && (sel > 0))
            {
                sel--;
                Put(vram, 0);
                vram -= VramRowSize;
                Put(vram, 30);
            }
            else if ((key == Keys_Right) && (sel < nbFiles-4))
            {
                sel += 4;
                Put(vram, 0);
                vram += 4*VramRowSize;
                Put(vram, 30);
            }
            else if ((key == Keys_Left) && (sel >= 4))
            {
                sel -= 4;
                Put(vram, 0);
                vram -= 4*VramRowSize;
                Put(vram, 30);
            }
            else if ((key & Keys_Buttons) != 0)
            {
                PrintS(Vram + 22*VramRowSize + 1*VramStep, "Press STOP key to return to this menu.");
                LoadFile(sel, filebank[sel]);
            }
            if ((key & Keys_Dir) != 0)
            {
                do {
                    key = ScanKeys();
                } while ((key & Keys_Dir) != 0);
            }
        } while (true);
    }
}
