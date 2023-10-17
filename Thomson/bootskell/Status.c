#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Man;
                repeat (2) {
                    repeat (2) {
                        vram = Put(vram, c);
                        ++c;
                    }
                    vram += VramRowSize - 2 * VramStep;
                }
                vram += 2 * VramStep - VramRowSize * 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 11 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
 		0x4f, 0x45, 0x4d, 0x42, 
		0x4f, 0x4a, 0x4e, 0x41, 
		0x4f, 0x40, 0x4c, 0x43, 
		0x45, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4e, 0x4d, 0x42, 0x4e, 
		0x4f, 0x4c, 0x43, 0x4f, 
		0x44, 0x45, 0x40, 0x44, 
		0x40, 0x40, 0x48, 0x42, 
		0x4d, 0x42, 0x4d, 0x47, 
		0x4c, 0x43, 0x4c, 0x43, 
		0x45, 0x40, 0x40, 0x45, 
		0x40, 0x40, 0x40, 0x4c, 
		0x48, 0x47, 0x45, 0x4c, 
		0x40, 0x45, 0x4b, 0x4c, 
		0x44, 0x45, 0x41, 0x44, 
		0x43, 0x40, 0x40, 0x40, 
		0x4b, 0x47, 0x48, 0x47, 
		0x4f, 0x42, 0x4c, 0x47, 
		0x41, 0x45, 0x40, 0x45, 
		0x40, 0x4c, 0x43, 0x4f, 
		0x4b, 0x4c, 0x43, 0x4f, 
		0x45, 0x4c, 0x43, 0x4f, 
		0x41, 0x44, 0x41, 0x45, 
   };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + 4 * VramStep;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    //PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    //PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 19 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram + VramRowSize * 4;
    //     for (c = Char_Space; c < Char_End; ) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    /* to test sprite colors
    {
        word vram;
        byte c;
        vram = Vram + VramRowSize * 3 + 4 * VramStep;
        for (c = Char_Man; c < Char_End; ) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram = vram - 2 * VramRowSize + 2 * VramStep;
            if (c == Char_Monster) {
                vram += 2 * VramRowSize - 24 * VramStep;
            }
            if (c == Char_Point) {
                vram += 8 * VramRowSize - 20 * VramStep;
            }
        }
    }*/
}
