constexpr word Vram = 0x40A4;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 32;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern void InitVram();
extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);
