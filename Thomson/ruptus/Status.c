#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"

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
    // ClearScreen();

    PrintS(Vram + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 6 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 6 + 30 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize + 26 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 4 + 26 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram + VramRowSize * 9 + 24 * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(vram, Char_Fighter);
            vram += 2 * VramStep;
            ++i;
        }
    }
    else {
        VPut2(vram, Char_Fighter);
        vram += 2 * VramStep;
        VErase2(vram);
        vram += 2 * VramStep;
        PrintByteNumber2(Vram + VramRowSize * 10 + 26 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(vram);
        vram += 2 * VramStep;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 11 + 7 * VramStep;
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
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x4c, 0x47, 0x45, 0x4b, 
    0x4c, 0x43, 0x48, 0x4f, 
    0x4c, 0x47, 0x4f, 0x42, 
    0x44, 0x41, 0x44, 0x45, 
    //	U
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x40, 0x45, 0x45, 0x41, 
    //	P
    0x4c, 0x47, 0x45, 0x4b, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x47, 0x45, 0x41, 
    0x44, 0x41, 0x40, 0x40, 
    //	T
    0x44, 0x4d, 0x47, 0x41, 
    0x40, 0x4c, 0x43, 0x40, 
    0x40, 0x4c, 0x43, 0x40, 
    0x40, 0x44, 0x41, 0x40, 
    //	U
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x40, 0x45, 0x45, 0x41, 
    //	S
    0x48, 0x47, 0x45, 0x4b, 
    0x44, 0x4b, 0x4a, 0x42, 
    0x48, 0x42, 0x40, 0x4f, 
    0x40, 0x45, 0x45, 0x41, 
};

void Title()
{
    ClearScreen();
    HideAllSprites();
    {
        byte RemainFighterCountSauv;
        RemainFighterCountSauv = RemainFighterCount;
        RemainFighterCount = 0;
        PrintStatus();
        RemainFighterCount = RemainFighterCountSauv;
    }

    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8;
        p = TitleBytes;
        repeat (6) {
            VPut4(vram, p);
            vram += 4 * VramStep;
            p += 16;
        }
    }
    //PrintS(Vram + VramRowSize * 17 + 5 * VramStep, "PUSH SPACE KEY");
    //PrintS(Vram + VramRowSize * 18 + 5 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 17 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    /*{
        word vram;
        byte c;
        vram = Vram + VramRowSize * 3;
        for (c = Char_Fighter; c < Char_LargeBang; ) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram = vram - 2 * VramRowSize + 2 * VramStep;
            if (c == 0x9e) {
                vram += 2 * VramRowSize - 4 * VramStep;
            }
        }
        vram = Vram + VramRowSize * 12 + 6 * VramStep;
        for (c = Char_LargeBang; c < Char_Fort; ) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram = vram - 2 * VramRowSize + 2 * VramStep;
            if (c == Char_LargeBang + 8) {
                vram += 2 * VramRowSize - 4 * VramStep;
            }
        }
        vram = Vram + VramRowSize * 12 + 12 * VramStep;
        for (c = Char_Fort; c < Char_End; ) {
            repeat (6) {
                repeat (6) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 6 * VramStep;
            }
            vram = vram - 2 * VramRowSize + 6 * VramStep;
        }
    }*/
}
