#include "Movable.h"
#include "Stage.h"

constexpr byte GoalX = StageWidth - 4 + 1;
constexpr byte GoalY = StageTop + FloorHeight * (FloorCount - 1) + 1;

extern void DrawGoal();
