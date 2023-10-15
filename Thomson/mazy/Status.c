#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

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
    PrintS(Vram + VramRowSize * 0 + 32, "SCORE"); 
    PrintS(Vram + VramRowSize * 5 + 32, "HI-SCORE");
    PrintS(Vram + VramRowSize * 10 + 32, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 10 + 38, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 13 + 32, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 22 + 33;
        word vram;
        byte count;
        vram = RemainLeft;
        for (count = 1; count < RemainCount; ++count) {
            vram = Put2(vram, Char_Man);
        }
    }

    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 7 + 34, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 13 + 37, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 20 + 33;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        vram = Put(vram, Char_Kn_Left);
        ++i;
        --count;
    }
    while (i != 4) {
        vram = Put(vram, Char_Space);
        ++i;
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 16, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 17, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        word vram;
        byte c;
        vram = Vram + VramRowSize * 0 + 12;
        c = Char_Title;
        repeat (4) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram += 2 * VramStep - VramRowSize * 2;
        }
    }
    Put2(Vram + VramRowSize * 5 + 9, Char_Man);
    Put2(Vram + VramRowSize * 8 + 9, Char_Chaser);
    Put2(Vram + VramRowSize * 11 + 9, Char_Disturber);
    Put2(Vram + VramRowSize * 14 + 9, Char_Goal);
    
    PrintStatus(); 
    PrintS(Vram + VramRowSize * 3 + 8, "--- CHARACTERS ---");
    PrintS(Vram + VramRowSize * 6 + 14, "MAN");
    PrintS(Vram + VramRowSize * 9 + 14, "CHASER");
    PrintS(Vram + VramRowSize * 12 + 14, "DISTURBER");
    PrintS(Vram + VramRowSize * 15 + 14, "EXIT");

    //PrintS(Vram + VramRowSize * 22 + 9, "PUSH SPACE KEY");
    //PrintS(Vram + VramRowSize * 23 + 9, "OR TAB KEY");
    PrintS(Vram + VramRowSize * 21 + 7, "PUSH TRIGGER BUTTON");
    /*{
        word vram;
        byte c;
        vram = Vram + VramRowSize * 17 + 5 * VramStep;
        for (c = Char_Man; c < Char_Title; ) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram = vram - 2 * VramRowSize + 2 * VramStep;
            if (c == Char_Man_Up) {
                vram += 2 * VramRowSize - 20 * VramStep;
            }
        }
    }*/
}
