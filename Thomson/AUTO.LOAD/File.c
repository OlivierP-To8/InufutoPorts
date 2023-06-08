// Thomson Floppy Disk BIN Loader by OlivierP-To8
// https://github.com/OlivierP-To8

#include "File.h"
#include "CopyMemory.h"
#include "Vram.h"
#include "Print.h"

byte[sectorSize] Buffer;
byte[sectorSize] FATtable;

byte[maxFiles*nameSize] filename;
byte[maxFiles] filebloc; // first bloc
byte[maxFiles] filenbls; // nb bytes in last sector

byte listBinFiles()
{
    byte nb, sector, status;
    ptr<byte> psrc, pdst;

    InitDrive(0);

    nb = 0;
    sector = 3;
    status = ReadSector(20, sector++, Buffer);
    if (status != 0x00)
    {
        word vram;
        vram = Vram + 24*VramRowSize;
        if (status == 0x10)
        {
            PrintS(vram, "Lecteur non pret");
        }
        else if (status == 0x40)
        {
            PrintS(vram, "Controleur non pret");
        }
    }
    else
    {
        psrc = Buffer;
        pdst = filename;
        while ((*psrc > 0x20) && (*psrc < reservedBlock))
        {
            if ((psrc[8]=='B') && (psrc[9]=='I') && (psrc[10]=='N') &&
                (psrc[11]==0x02) && (psrc[12]==0x00))
            {
                // get filename
                CopyMemory(pdst, psrc, 8);
                pdst[8] = 0x00;
                pdst += nameSize;
                // get first bloc
                filebloc[nb] = psrc[13];
                // get nb bytes in last sector
                filenbls[nb] = psrc[15];

                nb++;
            }
            psrc += 32;
            if (psrc >= Buffer+sectorSize)
            {
                ReadSector(20, sector++, Buffer);
                psrc = Buffer;
            }
        }
    }

    return nb;
}

void loadBinFile(byte nb)
{
    word vram;
    byte status;

    vram = Vram + 24*VramRowSize;
    status = ReadSector(20, 2, FATtable);
    if (status != 0x00)
    {
        if (status == 0x10)
        {
            PrintS(vram, "Lecteur non pret");
        }
        else if (status == 0x40)
        {
            PrintS(vram, "Controleur non pret");
        }
    }
    else
    {
        word filesize, fileaddr, address;
        byte block, nbBytes;
        bool start;

        address = 0x6800;
        block = filebloc[nb];
        nbBytes = sectorBytes;
        start = true;

        PrintS(vram, "                                        ");
        while (block != freeBlock)
        {
            byte nextBlock, nbSectors, track, sector, b, skipBuf, skipLen;
            nextBlock = FATtable[block+1];
            nbSectors = 8;
            if (nextBlock > 0xc0)
            {
                nbSectors = nextBlock - 0xc0;
                nextBlock = freeBlock;
            }
            track = (block >> 1);
            sector = 1;
            if ((block & 0x01) == 0x01)
            {
                sector = 9;
            }
            b = 0;
            while (b<nbSectors)
            {
                skipBuf = 0;
                skipLen = 0;
                if ((nextBlock == freeBlock) && (b+1==nbSectors))
                {
                    nbBytes = filenbls[nb];
                    skipLen = 5;
                }

                status = ReadSector(track, sector++, Buffer);
                if (start)
                {
                    if (Buffer[0] == 0x00) // start of binary
                    {
                        filesize = Buffer[1];
                        filesize = (filesize << 8) + Buffer[2];
                        fileaddr = Buffer[3];
                        fileaddr = (fileaddr << 8) + Buffer[4];

                        PrintS(vram + 29, "[");
                        PrintHex(vram + 30, fileaddr);
                        PrintS(vram + 34, "-");
                        PrintHex(vram + 35, fileaddr+filesize);
                        PrintS(vram + 39, "]");

                        start = false;
                        address = fileaddr;
                        skipBuf = 5;
                        skipLen = 5;
                    }
                }

                PrintS(vram, "Block");
                PrintByteNumber3(vram + 6, block);
                PrintS(vram + 10, "Track");
                PrintByteNumber2(vram + 16, track);
                PrintS(vram + 19, "Sector");
                PrintByteNumber2(vram + 26, sector);

                CopyToAddress(address, Buffer+skipBuf, nbBytes-skipLen);
                address += nbBytes-skipLen;
                b++;
            }
            block = nextBlock;
        }

        RunAddress(fileaddr);
    }
}
