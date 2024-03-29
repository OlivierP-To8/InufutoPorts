constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 24;
constexpr word VVramSize = VVramWidth * VVramHeight;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;
extern byte[] RowFlags;

extern void ClearVVram();
extern void VVramBackToFront();
extern void SetRowFlag(byte y);
extern void SetRowFlag2(byte y);
extern word VVramOffset(byte x, byte y);
extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);