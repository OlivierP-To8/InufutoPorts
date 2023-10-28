// Thomson Floppy Disk BIN Loader by OlivierP-To8
// https://github.com/OlivierP-To8

#include "../ScanKeys.h"
#include "Vram.h"
#include "File.h"

extern byte[maxFiles*nameSize] filename;
constexpr byte startLine = 6;

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
                Put(vram, 0);
                vram += VramRowSize;
                Put(vram, 30);
                sel++;
                do {
                    key = ScanKeys();
                } while (key != 0);
            }
            else if ((key == Keys_Up) && (sel > 0))
            {
                Put(vram, 0);
                vram -= VramRowSize;
                Put(vram, 30);
                sel--;
                do {
                    key = ScanKeys();
                } while (key != 0);
            }
            else if ((key & (Keys_Button0 | Keys_Button1)) != 0)
            {
                PrintS(Vram + 22*VramRowSize + 1*VramStep, "Press STOP key to return to this menu.");
                loadBinFile(sel);
            }
        } while (true);
    }
}
