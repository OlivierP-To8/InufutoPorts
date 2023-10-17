constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr word Vram = 0x4000;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern void InitVram();
extern word PrintC(word vram, byte c);
extern word Put2(word vram, byte c);
extern word Erase2(word vram);
