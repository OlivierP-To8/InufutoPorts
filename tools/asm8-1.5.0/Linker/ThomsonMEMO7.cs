// Thomson ROM (MEMO7) by OlivierP-To8
// https://github.com/OlivierP-To8

using Inu.Language;
using System.IO;

namespace Inu.Linker
{
    class ThomsonMEMO7 : BinaryTargetFile
    {
        private string name;

        public ThomsonMEMO7(string fileName) : base(fileName)
        {
            name = Path.GetFileNameWithoutExtension(fileName).ToUpper();
        }

        public override void Write(int address, byte[] bytes)
        {
            // ROM size must be a multiple of 4096 with a header of 32 bytes
            int romSize = bytes.Length + address;
            int modulo = romSize % 4096;
            if (modulo > 0)
            {
                romSize += (4096 - modulo);
            }
            byte[] romData = new byte[romSize];

            // filled with null values
            for (int i=0; i<address; i++)
            {
                romData[i] = 0x00;
            }
            for (int i=bytes.Length; i<romSize; i++)
            {
                romData[i] = 0x00;
            }

            // ROM name in boot menu
            romData[0] = 0x20; // starts with 0x20
            for (int i=0; i<name.Length; i++)
            {
                romData[i+1] = (byte)name[i];
            }
            romData[name.Length+1] = 0x04; // ends with 0x04

            // header checksum in $1A
            byte checksum = 0x55;
            for (int i=0; i<0x1A; i++)
            {
                checksum += romData[i];
            }
            romData[0x1A] = checksum;

            // hot boot address in $1C
            romData[0x1C] = (byte)(address >> 8);
            romData[0x1D] = (byte)(address & 0xff);

            // cold boot address in $1E
            romData[0x1E] = (byte)(address >> 8);
            romData[0x1F] = (byte)(address & 0xff);

            // magic value in $0020 for ROM on floppy disk (.CHG)
            if (address >= 0x0022)
            {
                romData[0x20] = 0xA5;
                romData[0x21] = 0x5A;
            }

            for (int i=0; i<bytes.Length; i++)
            {
                romData[i+address] = bytes[i];
            }

            Stream.Write(romData, 0, romData.Length);
        }

        protected override void WriteRecord(int address, byte[] bytes, int offset, int recordSize) { }
    }
}
