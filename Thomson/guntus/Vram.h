constexpr byte VramWidth = 40;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr word Vram = 0x40A4;

constexpr byte WindowWidth = 26;
constexpr byte WindowHeight = VramHeight;

extern void MakeMono(byte count, ptr<byte> pDest, byte color);
extern void MakeColor(byte count, ptr<byte> pDest);
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void InitVram();
extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
