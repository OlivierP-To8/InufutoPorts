constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern void DrawAll();

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();
