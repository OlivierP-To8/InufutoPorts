#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"
#include "VVram.h"

constexpr byte RangeY = 32;
constexpr byte CharCount = 2;

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
static byte oldYOffset;
static byte CharOffset;

void InitStarts()
{
    CharOffset = 0;
    YOffset = 0;
}

void MoveStars()
{
    ++CharOffset;
    if (CharOffset >= CharCount) {
        // BackgroundChanged = true;
        CharOffset -= CharCount;
        oldYOffset = YOffset;
        ++YOffset;
    }
}


void EraseStars()
{
    ptr<Star> pStar;
    for (pStar : Stars) {
        byte y;
        y = (pStar->y + oldYOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            SetRowFlags(y, 1);
        }
    }
}


void DrawStars()
{
    // byte c, old;
    ptr<Star> pStar;
    for (pStar : Stars) {
        byte y, c;
        ptr<byte> pv;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            SetRowFlags(y, 1);
            pv = VVramPtr(pStar->x, y);
            *pv = Char_Star + CharOffset;
            ++pv;
            *pv = 0;
        }
    }
}
