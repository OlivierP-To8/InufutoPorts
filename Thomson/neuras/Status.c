#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"


word PrintS(word vram, ptr<byte> p)
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

    if (RemainSolverCount > 1) {
        Print2x2(Vram + 27 * VramStep, Pattern_Solver_Left);
        PrintC(Vram + VramRowSize + 29 * VramStep, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2x2(Vram + 27 * VramStep);
        PrintC(Vram + VramRowSize + 29 * VramStep, ' ');
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
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
    PrintNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Pattern_Card + (pHeldCard->status & 0xf);
        Print2x2(Vram + 30 * VramStep, pattern);
    }
    else {
        Erase2x2(Vram + 30 * VramStep);
    }
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
    ClearScreen(); 
    // HideAllSprites();

    {
        word vram;
        byte pattern;
        
        pattern = Pattern_Title;
        vram = Vram + VramRowSize * 4 + 10 * VramStep;
        repeat(6) {
            Print2x2(vram, pattern);
            ++pattern;
            vram += 2 * VramStep;
        }
    }

    Print2x2(Vram + VramRowSize * 9 + 9 * VramStep, Pattern_Solver_Left);
    Print2x2(Vram + VramRowSize * 12 + 9 * VramStep, Pattern_Monster_Left);
    Print2x2(Vram + VramRowSize * 15 + 9 * VramStep, Pattern_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 7 + 7 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 10 + 12 * VramStep, "SOLVER");
    PrintS(Vram + VramRowSize * 13 + 12 * VramStep, "MONSTER");
    PrintS(Vram + VramRowSize * 16 + 12 * VramStep, "CARD");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 22 + 9 * VramStep, "OR SHIFT KEY");
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
}
