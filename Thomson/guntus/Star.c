#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"
#include "VVram.h"

constexpr byte RangeY = 32;

struct Star {
    byte x, y;
};

static const Star[] Stars = {
	{ 60, 23 },
	{ 0, 10 },
	{ 3, 16 },
	{ 13, 25 },
	{ 24, 4 },
	{ 33, 15 },
	{ 12, 10 },
	{ 59, 22 },
	{ 32, 9 },
	{ 19, 16 },
	{ 8, 22 },
	{ 42, 0 },
	{ 38, 21 },
	{ 24, 7 },
	{ 63, 7 },
	{ 5, 17 },
};

static byte YOffset;

void MoveStars()
{
    ++YOffset;
    BackgroundChanged = true;
}


void DrawStars()
{
    ptr<Star> pStar;
    for (pStar : Stars) {
        byte y;
        ptr<byte> pv;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            pv = VVramBack + VVramOffset(pStar->x, y);
            *pv = Char_Star;
        }
    }
}
