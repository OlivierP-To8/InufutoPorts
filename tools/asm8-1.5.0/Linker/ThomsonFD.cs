// Thomson Floppy Disk by OlivierP-To8
// https://github.com/OlivierP-To8

using Inu.Language;
using System;
using System.IO;
using System.Text;
using System.Linq;
using System.Collections.Generic;

namespace Inu.Linker
{
    enum FileType
    {
        BASIC_PRG = 0,
        BASIC_DAT = 1,
        ASM_PRG = 2,
        TEXT = 3
    }

    class ThomsonFD : BinaryTargetFile
    {
        private string name;
        private string binName;

        private const int sectorSize = 256; // 256 octets par secteur (255 octets utiles)
        private const int trackSize = 16*sectorSize; // 16 secteurs par piste (numérotés à partir de 1)
        private const int diskSize = 80*trackSize; // 80 pistes (numérotées à partir de 0)
        private const int blockSize = 8*sectorSize; // 8 secteurs par bloc
        private byte[] floppyDisk = new byte[diskSize];

        private const int FAT = 20*trackSize+sectorSize+1; // Le secteur 2 de la piste 20 contient la table d'allocation mémoire
        private const int REP = 20*trackSize+2*sectorSize; // Le secteur 3 de la piste 20 contient le répertoire

        private const int sectorBytes = 255; // 256 octets par secteur (255 octets utiles)
        private const int blockBytes = 8*sectorBytes; // 8 secteurs par bloc

        private const byte freeBlock = 0xff;
        private const byte reservedBlock = 0xfe;

        public ThomsonFD(string fileName) : base(fileName)
        {
            name = Path.GetFileNameWithoutExtension(fileName).ToUpper();
            binName = name + ".BIN";
            formatDisk();
        }

        private void formatDisk()
        {
            const byte filler = 0xe5;

            for (int i=0; i<diskSize; i++)
            {
                floppyDisk[i] = filler;
            }
            // Annexe 1 du guide du TO8, TO8D ou MO6
            /* Le secteur 2 de la piste 20 contient la table d'allocation mémoire,
            c'est à dire des informations sur les blocs de la disquette.
            Chaque fichier ne se compte pas en secteurs mais en blocs de 8 secteurs (2 Ko).
            Dans la table, chaque bloc est représenté par un octet. Attention, le 1er octet du secteur n'est pas utilisé.
            Le 1er bloc est représenté pas le 2e octet, le 2e bloc par le 3e octet, etc.
            La valeur de l'octet donne des indications sur l'occupation de bloc correspondant:
                entre 0 et 4B : Le bloc fait partie d'un fichier, l'octet contient le numéro du prochain bloc du même fichier.
                entre C1 et C8 : Le bloc est le dernier d'un fichier, l'octet contient le nombre de secteurs du bloc occupés par le fichier auquel est ajouté la constante C0.
                FE : Le bloc est réservé et ne peut pas être utilisé pour un fichier.
                FF : Le bloc est libre
            */
            for (int i=20*trackSize; i<21*trackSize; i++)
            {
                floppyDisk[i] = freeBlock;
            }
            // Le 1er octet du secteur n'est pas utilisé
            floppyDisk[FAT-1] = 0x00;
            // La piste 20 est réservée (2 blocs de 8 secteurs par piste)
            floppyDisk[FAT+2*20] = reservedBlock;
            floppyDisk[FAT+2*20+1] = reservedBlock;
            // Les pistes 80 et suivantes ne sont pas utilisées
            for (int i=FAT+80*2; i<REP; i++)
            {
                floppyDisk[i] = 0x00;
            }
        }

        private byte findFreeBlock(List<byte> blocks)
        {
            // Le répertoire est situé sur la piste 20 de la disquette.
            // Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
            // on récupére les 1er blocs utilisés par les fichiers
            List<byte> inuse = new List<byte>();
            for (int entry=13; entry<14*sectorSize; entry+=32)
            {
                byte block = floppyDisk[REP+entry];
                if (block != freeBlock)
                {
                    inuse.Add(block);
                }
            }
            // Chaque fichier ne se compte pas en secteurs mais en blocs de 8 secteurs (2 Ko).
            // on commence de la piste 40 vers 0
            for (byte i=80; i>0; i--)
            {
                if ((floppyDisk[FAT+i] == freeBlock) && (!inuse.Contains(i)) && (!blocks.Contains(i)))
                    return i;
            }
            // puis de la piste 41 vers 79
            for (byte i=81; i<2*80; i++)
            {
                if ((floppyDisk[FAT+i] == freeBlock) && (!inuse.Contains(i)) && (!blocks.Contains(i)))
                    return i;
            }

            return 0xff;
        }

        private int findFreeEntry()
        {
            // Le répertoire est situé sur la piste 20 de la disquette.
            // Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
            for (int i=0; i<14*sectorSize; i+=32)
            {
                if (floppyDisk[REP+i] == freeBlock)
                    return i;
            }

            return -1;
        }

        private void addFileEntry(string filename, FileType fileType, byte block, int sizeLeft)
        {
            /* Le répertoire est situé sur la piste 20 de la disquette.
            Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
            Chaque fichier inscrit au répertoire à une zone réservée fixe de 32 octets :*/
            int entry = REP + findFreeEntry();

            /*  8: Nom du fichier, cadré à gauche, complété au besoin par des blanc à droite.
                   Si le fichier a été supprimé par KILL, le premier octet contient 0.
                   Si la zone du répertoire n'a pas encore été utilisée, le premier octet contient FF.*/
            string basename = Path.GetFileNameWithoutExtension(filename).ToUpper();
            for (int i=0; i<basename.Length; i++)
            {
                floppyDisk[entry+i] = (byte)basename[i];
            }
            for (int i=basename.Length; i<8; i++)
            {
                floppyDisk[entry+i] = 0x20;
            }

            //  3: Suffixe du nom de fichier (BAS,DAT,BIN,...) cadré à gauche, complété par des blanc à droite si nécessaire.
            string extension = Path.GetExtension(filename).ToUpper();
            for (int i=1; i<extension.Length; i++)
            {
                floppyDisk[entry+7+i] = (byte)extension[i];
            }
            for (int i=extension.Length; i<4; i++)
            {
                floppyDisk[entry+7+i] = 0x20;
            }

            /*  1: Type du fichier
                    0: programme BASIC
                    1: fichier de données BASIC
                    2: programme en langage machine
                    3: fichier de texte*/
            floppyDisk[entry+11] = (byte)fileType;

            /*  1: Type des données
                    0: les octets contiennent du binaire
                    FF: les octets contiennent des caractères codés en ASCII*/
            floppyDisk[entry+12] = 0; // les octets contiennent du binaire

            //  1: Le numéro du premier bloc attribué au fichier (à partir de 0)
            floppyDisk[entry+13] = block;

            //  2: Le nombre d'octets occupés dans le dernier secteur du fichier
            floppyDisk[entry+14] = (byte)(sizeLeft >> 8);
            floppyDisk[entry+15] = (byte)(sizeLeft & 0xff);

            //  8: Commentaire associé au fichier (lors du SAVE, COPY, NAME)
            floppyDisk[entry+16] = 0x00;
            for (int i=1; i<8; i++)
            {
                floppyDisk[entry+16+i] = 0x20;
            }

            //  8: Inutilisés
            floppyDisk[entry+24] = (byte)DateTime.Today.Day;
            floppyDisk[entry+25] = (byte)DateTime.Today.Month;
            floppyDisk[entry+26] = (byte)(DateTime.Today.Year-2000);
            for (int i=3; i<8; i++)
            {
                floppyDisk[entry+24+i] = 0x00;
            }
        }

        private void addFileBlock(byte block, byte[] bytes, int offset)
        {
            for (int b=0; b<8; b++)
            {
                int src = offset+b*sectorBytes;
                int dst = block*blockSize+b*sectorSize;
                int nb = sectorBytes;
                if (src+sectorBytes > bytes.Length)
                {
                    nb = bytes.Length - src;
                }
                if (nb > 0)
                {
                    for (int j=0; j<nb; j++)
                    {
                        floppyDisk[dst+j] = bytes[src+j];
                    }
                    for (int j=nb; j<sectorSize; j++)
                    {
                        floppyDisk[dst+j] = 0x00;
                    }
                }
            }
        }

        private void addFile(string filename, byte[] bytes, FileType fileType)
        {
            List<byte> blocks = new List<byte>();
            int offset = 0;
            int sizeLeft = bytes.Length;
            while (sizeLeft > 0)
            {
                byte block = findFreeBlock(blocks);
                addFileBlock(block, bytes, offset);
                offset += blockBytes;
                if (blocks.Count > 0)
                {
                    floppyDisk[FAT+blocks.Last()] = block;
                }
                blocks.Add(block);
                if (sizeLeft < blockBytes)
                {
                    byte nbSectors = 0xc0;
                    while (sizeLeft > 0)
                    {
                        nbSectors++;
                        sizeLeft -= sectorBytes;
                    }
                    floppyDisk[FAT+blocks.Last()] = nbSectors;
                    addFileEntry(filename, fileType, blocks.First(), sizeLeft+sectorBytes);
                }
                sizeLeft -= blockBytes;
            }
        }

        private void addAutoBat()
        {
            List<byte> bytes = new List<byte>();
            // entête
            bytes.Add(0xff);
            bytes.Add(0x00);
            bytes.Add(0x1c);
            bytes.Add(0x00);
            bytes.Add(0x13);
            // numéro de ligne
            bytes.Add(0x00);
            bytes.Add(0x0a); // 10
            // LOADM
            bytes.Add(0xb3); // LOAD
            bytes.Add(0x4d); // M
            // binName
            bytes.Add(0x22); // "
            for (int i=0; i<binName.Length; i++)
            {
                bytes.Add((byte)binName[i]);
            }
            bytes.Add(0x22); // "
            // ?
            bytes.Add(0x00);
            bytes.Add(0x00);
            bytes.Add(0x06);
            // numéro de ligne
            bytes.Add(0x00);
            bytes.Add(0x14); // 20
            // EXEC
            bytes.Add(0xa2); // EXEC
            // ?
            bytes.Add(0x00);
            bytes.Add(0x00);
            bytes.Add(0x00);

            addFile("AUTO.BAT", bytes.ToArray(), FileType.BASIC_PRG);
        }

        private void addBinaryFile(int address, byte[] bytes)
        {
            /* http://dcmoto.free.fr/forum/messages/591147_0.html
            Structure logique des fichiers binaires (images memoire)
            ====================================
            Un fichier binaire est constitue par une suite d'enregistrements.
            Ces enregistrements sont de deux types :

            1) Enregistrement contenant des donnees
            0 type d'enregistrement = 00
            1-2 longueur des donnees
            3-4 adresse de chargement
            5-x donnees

            2) Enregistrement contenant l'adresse d'execution
            0 type d'enregistrement = FF
            1-2 longueur des donnees = 0000
            3-4 adresse d'execution

            Dans un fichier binaire, il peut exister plusieurs enregistrements de type 00.
            Il n'existe qu'un seul enregistrement contenant l'adresse d'execution.
            C'est le dernier enregistrement du fichier. */

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

            addFile(binName, fileData, FileType.ASM_PRG);
        }

        public override void Write(int address, byte[] bytes)
        {
            addBinaryFile(address, bytes);
            addAutoBat(); // to run the program by pressing "B" in the boot menu

            Stream.Write(floppyDisk, 0, diskSize);
        }

        protected override void WriteRecord(int address, byte[] bytes, int offset, int recordSize) { }
    }
}
