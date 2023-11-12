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

void printError(byte status)
{
    word vram;
    vram = Vram + 24*VramRowSize;
   
    PrintHex(vram + 5, status);
    PrintS(vram, "Error $");
}

byte listBinFiles()
{
    byte nb, sector;
    ptr<byte> psrc, pdst;
    nb = 0;
    sector = 3;
    psrc = Buffer + 32; // skip first file (LOAD.BIN)
    pdst = filename;

    ReadSector(20, sector++, Buffer);
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

    return nb;
}

void loadBinFile(byte nb)
{
    byte status;
    status = ReadSector(20, 2, FATtable);
    if (status == 0x00)
    {
        word vram, vrprg, address;
        byte block;
        bool start;

        address = 0xA000;
        block = filebloc[nb];
        start = true;

        vram = Vram + 23*VramRowSize;
        PrintS(vram, "Block     Track    Sector    [    -    ]");
        vrprg = Vram + 24*VramRowSize;
        //PrintS(vrprg, "                                        ");

        while (block != freeBlock)
        {
            byte track, sector, b, nbSectors, nbBytes, skipBuf;

            track = (block >> 1);
            sector = 1;
            if ((block & 0x01) == 0x01)
            {
                sector = 9;
            }

            PrintByteNumber3(vram + 6, block);
            PrintByteNumber2(vram + 16, track);

            block = FATtable[block+1];
            nbSectors = 8;
            if (block > 0xc0)
            {
                nbSectors = block - 0xc0;
                block = freeBlock;
            }

            b = 0;
            while (b<nbSectors)
            {
                nbBytes = sectorBytes;
                skipBuf = 0;
                if ((block == freeBlock) && (b+1 == nbSectors))
                {
                    nbBytes = filenbls[nb] - 5;
                }

                PrintByteNumber2(vram + 26, sector);
                ReadSector(track, sector, Buffer);
                if (start)
                {
                    if (Buffer[0] == 0x00) // start of binary
                    {
                        word filesize, fileaddr;
                        byte nbSteps;

                        filesize = Buffer[1];
                        filesize = (filesize << 8) + Buffer[2];
                        fileaddr = Buffer[3];
                        fileaddr = (fileaddr << 8) + Buffer[4];

                        // progress bar centered in screen, size of one step every 2 sectors
                        nbSteps = (Buffer[1] >> 1);
                        vrprg += ((36 - nbSteps) >> 1);
                        PrintS(vrprg++, "[");
                        PrintS(vrprg + nbSteps + 2, "]");

                        PrintHex(vram + 30, fileaddr);
                        PrintHex(vram + 35, fileaddr+filesize);

                        start = false;
                        address = fileaddr;
                        nbBytes -= 5;
                        skipBuf = 5;
                    }
                }

                // progress bar increments every 2 sectors
                if ((b & 0x01) == 0)
                {
                    PrintS(vrprg++, "=>");
                }

                CopyToAddress(address, Buffer+skipBuf, nbBytes);
                address += nbBytes;
                sector++;
                b++;
            }
        }
    }
}
