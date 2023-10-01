#include "Main.h"
#include "../ScanKeys.h"
#include "Stage.h"
#include "Vram.h"
#include "Sprite.h"
#include "VVram.h"
#include "Fort.h"
#include "Fighter.h"
#include "Barrier.h"
#include "Star.h"
#include "Enemy.h"
#include "FighterBullet.h"
#include "EnemyBullet.h"
#include "Status.h"
#include "Bang.h"
#include "Item.h"
#include "Sound.h"

extern void Init();
// extern void Fin();
extern void WaitTimer(byte t);
// extern void WaitSync();
extern void DrawAll();

word Score;
word HiScore;
byte RemainFighterCount;
byte Clock;

void Main()
{
    byte key;

    Init();
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainFighterCount = 3;
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
    }
    RemainFighterCount = 3;
    stage:
    InitStage();
    try:
    InitSound();
    InitTrying();
    ClearScreen();
    PrintStatus();
    DrawFortsOnRader();
    DrawAll();
    DrawFighterOnRader();
    Sound_Start();
    // StartBGM();
    Clock = 0;
    do {
        // if (ScanStop()) goto exit;
        ControlFighter();
        if ((Clock & 3) == 0) {
            MoveFighter();
            MoveEnemy();
            StartEnemy();
        }
        MoveFighterBullets();
        MoveEnemyBullets();
        DrawItem();
        if (FighterDyingCount == 0) {
            // StopBGM();
            lose:
            --RemainFighterCount;
            if (RemainFighterCount != 0)  goto try;
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
        UpdateBangs();
        // WaitSync();
        if ((Clock & 3) == 0) {
            WaitTimer(1);
            DrawAll();
            CallSound();
        }
        ++Clock;
    } while (FortCount > 0);
    // StopBGM();
    Sound_Clear();
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}

void DrawAll()
{
    if (VVramChanged) {
        ClearVVram();
        DrawStars();
        DrawForts();
        DrawBarriers();
        VVramBackToFront();
                                        // EraseSprites();
        DrawSprites();
                                        // VVramToVramChanged();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
}

void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
