#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man_Left_Stop;

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
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	K
        0x4c, 0x43, 0x48, 0x47, 
        0x4c, 0x4b, 0x47, 0x40, 
        0x4c, 0x43, 0x4d, 0x42, 
        0x44, 0x41, 0x40, 0x45, 
        //	Y
        0x4c, 0x43, 0x4c, 0x43, 
        0x44, 0x4b, 0x4e, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
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
    //PrintS(Vram + VramRowSize * 20 + 7 * VramStep, "OR TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 19 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2023");
    /* to test sprite colors
    {
        word vram;
        vram = Vram + VramRowSize * 3 + 3 * VramStep;
        Put2C(vram, Char_Man_Left_Stop);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Left0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Left1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Left2);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right_Stop);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Right2);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_UpDown0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_UpDown1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Loose0);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Loose1);
        vram = vram + 2 * VramStep;
        Put2C(vram, Char_Man_Loose2);
    }*/
}
