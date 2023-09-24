#include "Main.h"
#include "../Init.h"
#include "Stage.h"
#include "../ScanKeys.h"
#include "VVram.h"
#include "Sprite.h"
#include "Fighter.h"
#include "FighterBullet.h"
#include "SkyEnemy.h"
#include "EnemyBullet.h"
#include "Status.h"
#include "Bang.h"
#include "Barrier.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Sound.h"
#include "Item.h"
#include "Vram.h"

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
                            // CurrentStage = 4;
    }
    RemainCount = 3;
    InitStage();
    InitTrying();
    PrintStatus();
    DrawAll();
    VVramToVramAll();
    Sound_Start();
    // StartBGM();
    Clock = 0;
    WaitTimer(1);
    ScanKeys();
loop:
    // if (ScanStop()) goto exit;
    if ((Clock & 0x01) == 0) {
        MoveFighter();
        MoveEnemyBullets();
    }
    //PollVSync();
    if ((Clock & 0x03) == 0) {
        MoveSkyEnemies();
        MoveBarriers();
        MoveItem();
    }
    //PollVSync();
    if ((Clock & 0x07) == 0) {
        MoveFort();
    }
    //PollVSync();
    MoveFighterBullets();
    if ((Clock & 0x0f) == 0) {
        ScrollGround();
        MoveGroundEnemy();
    }
    // else {
    //     Wait();
    // }
    //PollVSync();

    if ((Clock & 0x01) == 0) {
        UpdateBangs();
        WaitTimer(5);
        DrawAll();
        CallSound();
        ScanKeys();
    }

    if (RemainCount == 0) {
        // StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }

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
