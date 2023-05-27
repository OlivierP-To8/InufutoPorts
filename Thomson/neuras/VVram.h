constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;
extern byte[] RowFlags;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void SetRowFlags(byte y, byte b);

extern void DrawAll();
extern void VErase2(byte x, byte y);
extern void VPut2(byte x, byte y, byte pattern);