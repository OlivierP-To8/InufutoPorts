constexpr byte VVramStep = 2;
constexpr byte VVramWidth = WindowWidth * 4;
constexpr byte VVramHeight = WindowHeight;

extern byte[] VVram;
extern bool BackgroundChanged;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);
extern void SetRowFlags(byte y, byte b);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
