#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Man;

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
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2 * VramStep;
                    --i;
                } while (i > 0);
            }
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
		0x48, 0x47, 0x4d, 0x42, 
		0x4f, 0x40, 0x40, 0x40, 
		0x4d, 0x42, 0x48, 0x42, 
		0x40, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x44, 0x4d, 0x42, 0x4e, 
		0x4e, 0x4d, 0x43, 0x4f, 
		0x44, 0x45, 0x41, 0x44, 
		0x40, 0x40, 0x40, 0x40, 
		0x4d, 0x42, 0x4e, 0x4d, 
		0x48, 0x42, 0x4f, 0x4c, 
		0x45, 0x40, 0x44, 0x45, 
		0x40, 0x40, 0x40, 0x40, 
		0x42, 0x4f, 0x46, 0x41, 
		0x43, 0x4f, 0x40, 0x40, 
		0x40, 0x45, 0x40, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4f, 0x4d, 0x4d, 0x42, 
		0x4f, 0x4c, 0x4c, 0x43, 
		0x45, 0x44, 0x44, 0x41, 
   };

    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 5 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (5) {
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
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2022");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     for (c = 32; c < 0xc0; ) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16;
    //         }
    //     }
    // }
    /* to test sprite colors
    {
        word vram;
        vram = Vram + VramRowSize * 3 + VramStep;
        Put2C(vram, Char_Man_Left0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Left1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Up0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Up1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Down0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Down1);

        Put2C(vram, Char_Monster_Left0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Left1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Right0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Right1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Up0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Up1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Down0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Monster_Down1);

        vram = Vram + VramRowSize * 12 + 9 * VramStep;
        Put2C(vram, Char_Point);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Point+4);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Point+8);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Point+12);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Increaser);
    }*/
}
