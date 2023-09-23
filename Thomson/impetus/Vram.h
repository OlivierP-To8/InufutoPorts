constexpr byte VramWidth = 128;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 32;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr word Vram = 0x8000;

extern void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
// extern void MakePatternColor(byte c, ptr<byte> pSource, byte count);
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern void StatusToVram();

extern void InitVram();
extern word PrintC(word vram, byte c);
