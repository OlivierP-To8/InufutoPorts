constexpr byte VramWidth = 128;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 32;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr word Vram = 0x8000;

constexpr byte WindowWidth = 26;
constexpr byte WindowHeight = VramHeight;

extern void InitAsciiPattern();
extern void InitMonoPattern();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void InitVram();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
