constexpr byte CoordShift = 0;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte MapShift = CoordShift + 1;
constexpr byte MapRate = CoordRate * 2;
constexpr byte MapMask = MapRate - 1;

struct Movable
{
    byte x, y;
    byte sprite;
};

extern void LocateMovable(ptr<Movable> pMovable, byte b);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);
