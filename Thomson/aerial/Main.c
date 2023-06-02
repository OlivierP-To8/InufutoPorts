#include "Main.h"
#include "Init.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Status.h"
#include "Sound.h"
#include "MyFighter.h"
#include "MyBullet.h"
#include "EnemyFighter.h"
#include "EnemyBullet.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Bang.h"
#include "Item.h"
#include "VVram.h"

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
static byte Clock;

void Main()
{
    byte key;
    
    Init();
    InitSprites();
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;

    title:
    Title();
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

    play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
                            // CurrentStage = 8;
    }
    RemainCount = 3;

    ClearScreen();
    InitGame();
    PrintStatus();
    GroundToVVram();
    VVramChanged = true;
    DrawAll();
    Sound_Start();
    // StartBGM();
    Clock = 0;
    //ResetTimer();
loop:
    // if (ScanStop()) goto exit;
    MoveMyBullets();
    //PollVSync();
    if ((Clock & 0x01) == 0) {
        MoveMyFighter();
        //PollVSync();
        MoveEnemyFighters();
        //PollVSync();
        MoveEnemyBullets();
        //PollVSync();
    }
    if ((Clock & 0x03) == 0) {
        MoveGroundEnemies();
        //PollVSync();
    }
    if ((Clock & 0x07) == 0) {
        UpdateBangs();
        //PollVSync();
        MoveItem();
        //PollVSync();
    }
    if ((Clock & 0x0f) == 0) {
        MoveForts();
        //PollVSync();
        ScrollBackground();
        //PollVSync();
        if (GroundChanged) {
            GroundToVVram();
            //PollVSync();
            GroundChanged = false;
            VVramChanged = true;
        }
    }
    if ((Clock & 0x01) == 0) {
        // WaitTimer();
        //ResetTimer();
        WaitTimer(4);
        DrawAll();
        //PollVSync();
        CallSound();
    }
    if (RemainCount == 0) {
        // StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }
    // UpdateSprites();
    ++Clock;
    goto loop;
// exit:
//     Fin();
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
    // StatusToVVram();
}
