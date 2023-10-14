constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth*CharHeight;
constexpr byte VramStep = VramWidth / 40;

constexpr word Vram = 0xd000;

extern void InitPalette();

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern word PrintC(word vram, byte c);

extern void InitVram();
extern word Put2(word vram, byte c);
extern word Erase2(word vram);
