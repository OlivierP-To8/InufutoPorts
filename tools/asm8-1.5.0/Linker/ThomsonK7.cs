// Thomson K7 (audio tape) by OlivierP-To8
// https://github.com/OlivierP-To8

using Inu.Language;
using System.IO;
using System.Collections.Generic;

namespace Inu.Linker
{
    class ThomsonK7 : BinaryTargetFile
    {
        private string name;
        private string binName;
        private byte[] SynchroTO = new byte[]{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x3C};
        private List<byte> k7 = new List<byte>();

        public ThomsonK7(string fileName) : base(fileName)
        {
            name = Path.GetFileNameWithoutExtension(fileName).ToUpper();
            binName = name + ".BIN";
            if (name.Length >= 8)
            {
                binName = name.Substring(0, 8) + ".BIN";
            }
        }

        private void addFileEntry(string filename, ThomsonFileType fileType)
        {
            k7.AddRange(SynchroTO);

            k7.Add(0x00); // type de bloc entête

            k7.Add(0x14); // longueur
            byte checksum = 0x14;

            // Nom du fichier complété au besoin par des espaces.
            string basename = Path.GetFileNameWithoutExtension(filename).ToUpper();
            for (int i=0; i<basename.Length; i++)
            {
                k7.Add((byte)basename[i]);
                checksum += (byte)basename[i];
            }
            for (int i=basename.Length; i<8; i++)
            {
                k7.Add(0x20);
                checksum += 0x20;
            }

            //  Suffixe du nom de fichier (BAS,DAT,BIN,...) complété par des espaces si nécessaire.
            string extension = Path.GetExtension(filename).ToUpper();
            for (int i=1; i<extension.Length; i++)
            {
                k7.Add((byte)extension[i]);
                checksum += (byte)extension[i];
            }
            for (int i=extension.Length; i<4; i++)
            {
                k7.Add(0x20);
                checksum += 0x20;
            }

            k7.Add((byte)fileType); // type de fichier
            checksum += (byte)fileType;

            k7.Add(0x00);

            k7.Add(0xff);
            checksum += 0xff;

            for (int i=0; i<6; i++)
            {
                k7.Add(0x00);
            }

            k7.Add(checksum);
        }

        private int addFileData(byte[] bytes, int offset)
        {
            int length = bytes.Length - offset;
            if (length > 0x80)
            {
                length = 0x80;
            }

            k7.AddRange(SynchroTO);

            k7.Add(0x01); // type de bloc fichier
            byte checksum = (byte)0x01;

            k7.Add((byte)length); // longueur
            checksum += (byte)length;

            for (int i=offset; i<offset+length; i++)
            {
                k7.Add(bytes[i]); // données
                checksum += bytes[i];
            }

            k7.Add(checksum);

            return length;
        }

        private void addBinaryFile(int address, byte[] bytes)
        {
            addFileEntry(binName, ThomsonFileType.ASM_PRG);

            byte[] fileData = new byte[bytes.Length + 10];
            fileData[0] = 0x00;
            fileData[1] = (byte)(bytes.Length >> 8);
            fileData[2] = (byte)(bytes.Length & 0xff);
            fileData[3] = (byte)(address >> 8);
            fileData[4] = (byte)(address & 0xff);
            for (int i=0; i<bytes.Length; i++)
            {
                fileData[i+5] = bytes[i];
            }
            fileData[bytes.Length+5] = 0xff;
            fileData[bytes.Length+6] = 0x00;
            fileData[bytes.Length+7] = 0x00;
            fileData[bytes.Length+8] = (byte)(address >> 8);
            fileData[bytes.Length+9] = (byte)(address & 0xff);

            for (int i=0; i<fileData.Length;)
            {
                i += addFileData(fileData, i);
            }

            // end of file
            k7.AddRange(SynchroTO);
            k7.Add(0xff); // type de bloc fin
            k7.Add(0x00); // longueur
            k7.Add(0xff); // checksum
        }

        public override void Write(int address, byte[] bytes)
        {
            addBinaryFile(address, bytes);

            byte[] k7Data = k7.ToArray();
            Stream.Write(k7Data, 0, k7Data.Length);
        }

        protected override void WriteRecord(int address, byte[] bytes, int offset, int recordSize) { }
    }
}
