constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr word Vram = 0x4000;

extern void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
extern void ClearScreen();
extern word Put(word vram, byte c);

extern void InitVram();
extern word PrintC(word vram, byte c);
extern word PrintS(word vram, ptr<byte> p);
