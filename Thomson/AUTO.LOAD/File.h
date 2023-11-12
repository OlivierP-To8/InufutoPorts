constexpr byte maxFiles = 20;
constexpr byte nameSize = 9;

constexpr byte sectorSize = 256; // 256 octets par secteur (255 octets utiles)
constexpr byte trackSize = 16*sectorSize; // 16 secteurs par piste (numérotés à partir de 1)
constexpr byte diskSize = 80*trackSize; // 80 pistes (numérotées à partir de 0)
constexpr byte blockSize = 8*sectorSize; // 8 secteurs par bloc

constexpr byte sectorBytes = 255; // 256 octets par secteur (255 octets utiles)
constexpr word blockBytes = 8*sectorBytes; // 8 secteurs par bloc

constexpr byte freeBlock = 0xff;
constexpr byte reservedBlock = 0xfe;

extern byte ReadSector(byte track, byte sector, ptr<byte> pDest);
extern void LoadFile(byte nb, byte bank);

extern byte listBinFiles();
extern void loadBinFile(byte nb);
