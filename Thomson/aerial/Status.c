#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_MyFighter;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}


static word PrintRemain(word vram)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


static word EraseRemain(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 8 * VramStep, "HI-SCORE");
    PrintS(Vram + 18 * VramStep, "STAGE");
    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = PrintRemain(vram);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    vram = PrintRemain(vram);
                    --i;
                } while (i != 0);
                EraseRemain(vram);
            }
        }
        else {
            EraseRemain(vram);           
        }
    }
    PrintStage();
    PrintScore();
    // PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize + 20 * VramStep, CurrentStage + 1);
}

// void PrintTime()
// {
//     PrintByteNumber3(Vram + VramRowSize + 23, StageTime);
// }

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
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
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
    PrintS(Vram + VramRowSize * 23 + VramWidth - 12 * VramStep, "INUFUTO 2022");
    // {
    //     byte c;
    //     word v;
    //     v = vram+32*10;
    //     c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //     }
    // }
    /* to test sprite colors
    {
        byte c;
        word vram;
        vram = Vram + VramRowSize * 3 + 3 * VramStep;
        Put2C(vram, Char_MyFighter_Right);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_MyFighter_RightDown);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_MyFighter_RightUp);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_EnemyFighter_Left);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_EnemyFighter_Right);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Track);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Rocket);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_SmallBang);
        vram = vram + 3 * VramStep;
        Put2C(vram, Char_Item);

        vram = Vram + VramRowSize * 12 + 9 * VramStep;
        Put2C(vram, Char_LargeBang);
        Put2C(vram + 2*VramStep, Char_LargeBang+4);
        vram = Vram + VramRowSize * 14 + 9 * VramStep;
        Put2C(vram, Char_LargeBang+8);
        Put2C(vram + 2*VramStep, Char_LargeBang+12);

        c = Char_Fort;
        vram = Vram + VramRowSize * 12 + 16 * VramStep;
        repeat (4) {
            repeat (7) {
                vram = Put(vram, c);
                ++c;
            }
            vram += VramRowSize - 7 * VramStep;
        }
    }*/
}
