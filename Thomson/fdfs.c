/*******************************************************************************
 * Rapide programme pour mettre des fichiers dans une image disquette
 * Auteur : OlivierP-To8
 * Mai 2023
 * https://github.com/OlivierP-To8/
*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <time.h>
#include <ctype.h>

#define sectorSize 256 // 256 octets par secteur (255 octets utiles)
#define trackSize 16*sectorSize // 16 secteurs par piste (numérotés à partir de 1)
#define diskSize  80*trackSize // 80 pistes (numérotées à partir de 0)
#define blockSize 8*sectorSize // 8 secteurs par bloc

#define FAT 20*trackSize+sectorSize+1 // Le secteur 2 de la piste 20 contient la table d'allocation mémoire
#define REP 20*trackSize+2*sectorSize // Le secteur 3 de la piste 20 contient le répertoire

#define sectorBytes 255 // 256 octets par secteur (255 octets utiles)
#define blockBytes 8*sectorBytes // 8 secteurs par bloc

#define freeBlock 0xff
#define reservedBlock 0xfe

#define byte unsigned char

typedef enum
{
	BASIC_PRG = 0,
	BASIC_DAT = 1,
	ASM_PRG = 2,
	TEXT = 3
} ThomsonFileType;

byte *floppyDisk = NULL;

void formatDisk()
{
	byte filler = 0xe5;

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

int contains(byte value, byte *data, int size)
{
	for (int i=0; i<size; i++)
	{
		if (data[i] == value)
		{
			return 1;
		}
	}
	return 0;
}

byte findFreeBlock(byte *blocks, int blocksnb)
{
	// Le répertoire est situé sur la piste 20 de la disquette.
	// Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
	// on récupére les 1er blocs utilisés par les fichiers
	byte inuse[112];
	int inusenb=0;
	for (int entry=13; entry<14*sectorSize; entry+=32)
	{
		byte block = floppyDisk[REP+entry];
		if (block != freeBlock)
		{
			inuse[inusenb++] = block;
		}
	}
	// Chaque fichier ne se compte pas en secteurs mais en blocs de 8 secteurs (2 Ko).
	// on commence de la piste 40 vers 0
	for (byte i=80; i>0; i--)
	{
		if ((floppyDisk[FAT+i] == freeBlock) && (!contains(i, inuse, inusenb)) && (!contains(i, blocks, blocksnb)))
			return i;
	}
	// puis de la piste 41 vers 79
	for (byte i=81; i<2*80; i++)
	{
		if ((floppyDisk[FAT+i] == freeBlock) && (!contains(i, inuse, inusenb)) && (!contains(i, blocks, blocksnb)))
			return i;
	}

	return 0xff;
}

int findFreeEntry()
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

void addFileEntry(char *filename, byte block, int sizeLeft)
{
	/* Le répertoire est situé sur la piste 20 de la disquette.
	Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
	Chaque fichier inscrit au répertoire à une zone réservée fixe de 32 octets :*/
	int entry = REP + findFreeEntry();

	/*  8: Nom du fichier, cadré à gauche, complété au besoin par des blanc à droite.
			Si le fichier a été supprimé par KILL, le premier octet contient 0.
			Si la zone du répertoire n'a pas encore été utilisée, le premier octet contient FF.*/
	char basename[10];
	sscanf(filename,"%[^.]",basename);
	for (int i=0; i<strlen(basename); i++)
	{
		floppyDisk[entry+i] = (byte)basename[i];
	}
	for (int i=strlen(basename); i<8; i++)
	{
		floppyDisk[entry+i] = 0x20;
	}

	//  3: Suffixe du nom de fichier (BAS,DAT,BIN,...) cadré à gauche, complété par des blanc à droite si nécessaire.
	char *extension = strrchr(filename,'.');
	for (int i=1; i<strlen(extension); i++)
	{
		floppyDisk[entry+7+i] = (byte)extension[i];
	}
	for (int i=strlen(extension); i<4; i++)
	{
		floppyDisk[entry+7+i] = 0x20;
	}

	/*  1: Type du fichier
			0: programme BASIC
			1: fichier de données BASIC
			2: programme en langage machine
			3: fichier de texte*/
	ThomsonFileType fileType = BASIC_PRG;
	if (strcmp(extension, ".BIN") == 0)
	{
		fileType = ASM_PRG;
	}
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
	time_t t = time(NULL);
	struct tm *tm = localtime(&t);
	floppyDisk[entry+24] = (byte)(tm->tm_mday);
	floppyDisk[entry+25] = (byte)(tm->tm_mon+1);
	floppyDisk[entry+26] = (byte)(tm->tm_year-100);
	for (int i=3; i<8; i++)
	{
		floppyDisk[entry+24+i] = 0x00;
	}
}

void addFileBlock(byte block, byte *bytes, int size, int offset)
{
	for (int b=0; b<8; b++)
	{
		int src = offset+b*sectorBytes;
		int dst = block*blockSize+b*sectorSize;
		int nb = sectorBytes;
		if (src+sectorBytes > size)
		{
			nb = size - src;
		}
		if (nb > 0)
		{
			memcpy(&floppyDisk[dst], &bytes[src], nb);
			for (int j=nb; j<sectorSize; j++)
			{
				floppyDisk[dst+j] = 0x00;
			}
		}
	}
}

void addFile(char *filename, byte *bytes, int size)
{
	byte blocks[112];
	int blocksnb=0;
	int offset = 0;
	int sizeLeft = size;
	while (sizeLeft > 0)
	{
		byte block = findFreeBlock(blocks, blocksnb);
		addFileBlock(block, bytes, size, offset);
		offset += blockBytes;
		if (blocksnb > 0)
		{
			floppyDisk[FAT+blocks[blocksnb-1]] = block;
		}
		blocks[blocksnb++] = block;
		if (sizeLeft < blockBytes)
		{
			byte nbSectors = 0xc0;
			while (sizeLeft > 0)
			{
				nbSectors++;
				sizeLeft -= sectorBytes;
			}
			floppyDisk[FAT+blocks[blocksnb-1]] = nbSectors;
			addFileEntry(filename, blocks[0], sizeLeft+sectorBytes);
		}
		sizeLeft -= blockBytes;
	}
}

void addBootLoader(char *bootsector, char *bootloader)
{
	FILE *fi=fopen(bootsector, "rb");
	if (fi==NULL)
	{
		printf("impossible d'ouvrir %s\n", bootsector);
	}
	else
	{
		fseek(fi, 0, SEEK_END);
		int size = ftell(fi);
		byte *fileData = malloc(size);
		memset(fileData, 0, size);
		fseek(fi, 0, SEEK_SET);

		int nbr = fread(fileData, 1, size, fi);
		fclose(fi);
		printf("lecture de %s (%d octets) %s\n", bootsector, size, size==nbr?"OK":"KO");

		// test du binaire
		if (size > 130)
		{
			printf("erreur, le boot secteur doit faire un maximum de 120 octets\n");
		}
		else if ((fileData[0] != 0x00) || (fileData[3] != 0x62) || (fileData[4] != 0x00))
		{
			printf("erreur, le boot secteur doit commencer à l'adresse $6200\n");
		}
		else
		{
			memset(floppyDisk, 0, sectorSize);
			byte checksum = 0x55;
			for (int i=0; i<size-10; i++)
			{
				floppyDisk[i] = 256 - fileData[i+5];
				checksum += fileData[i+5];
			}
			memcpy(&floppyDisk[120], "BASIC2", 6);
			checksum += 0x6c;
			floppyDisk[127] = checksum;
		}

		FILE *fb=fopen(bootloader, "rb");
		if (fb==NULL)
		{
			printf("impossible d'ouvrir %s\n", bootloader);
		}
		else
		{
			fseek(fb, 0, SEEK_END);
			int size = ftell(fb);
			byte *fileData = malloc(size);
			memset(fileData, 0, size);
			fseek(fb, 0, SEEK_SET);

			int nbr = fread(fileData, 1, size, fb);
			fclose(fb);
			printf("lecture de %s (%d octets) %s\n", bootloader, size, size==nbr?"OK":"KO");

			// l'entête du BIN (5 octets) est sur le secteur de boot 0
			// le binaire hors entête commence sur le secteur 1
			memcpy(&floppyDisk[251], fileData, size-5);
			floppyDisk[FAT] = reservedBlock;
			if (size-10 > 8*sectorSize)
			{
				floppyDisk[FAT+1] = reservedBlock;
			}
		}
	}
}

void extFile(char *filename, FILE *f)
{
	char basename[13];
	sscanf(filename,"%[^.]",basename);
	for (int i=strlen(basename); i<8; i++)
	{
		basename[i] = 0x20;
	}
	char *extension = strrchr(filename,'.');
	for (int i=1; i<strlen(extension); i++)
	{
		basename[7+i] = (byte)extension[i];
	}
	for (int i=strlen(extension); i<4; i++)
	{
		basename[7+i] = 0x20;
	}

	// Le répertoire est situé sur la piste 20 de la disquette.
	// Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
	for (int entry=0; entry<14*sectorSize; entry+=32)
	{
		if (strncmp(basename, (char *)(&floppyDisk[REP+entry]), 11) == 0)
		{
			byte block = floppyDisk[REP+entry+13];
			printf("extraction de %s\n", filename);
			while (block != freeBlock)
			{
				int nbBytes = sectorBytes;
				byte nextBlock = floppyDisk[FAT+block];
				int nbSectors = 8;
				if (nextBlock > 0xc0)
				{
					nbSectors = nextBlock - 0xc0;
					nextBlock = freeBlock;
				}
				for (int b=0; b<nbSectors; b++)
				{
					int src = block*blockSize+b*sectorSize;
					if ((nextBlock == freeBlock) && (b+1==nbSectors))
					{
						nbBytes = (floppyDisk[REP+entry+14] << 8) | floppyDisk[REP+entry+15];
					}
					//printf("ext block %x depuis [%x-%x]\n", block, src, src+nbBytes);
					fwrite(&floppyDisk[src], 1, nbBytes, f);
				}
				block = nextBlock;
			}
			break;
		}
	}
}

void list(FILE *f)
{
	// Le répertoire est situé sur la piste 20 de la disquette.
	// Le répertoire commence au secteur 3 et occupe une place de 14 secteurs.
	for (int entry=0; entry<14*sectorSize; entry+=32)
	{
		if ((floppyDisk[REP+entry] > 0x20) && (floppyDisk[REP+entry] < reservedBlock))
		{
			char basename[13] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
			int c=0;
			for (int i=0; i<8; i++)
			{
				byte b = floppyDisk[REP+entry+i];
				if (b != 0x20)
				{
					basename[c++] = b;
				}
			}
			basename[c++] = '.';
			for (int j=8; j<11; j++)
			{
				byte b = floppyDisk[REP+entry+j];
				if (b != 0x20)
				{
					basename[c++] = b;
				}
			}
			printf("%s ", basename);
		}
	}
}

int main(int argc, char **argv)
{
	floppyDisk = malloc(diskSize);
	formatDisk();

	if ((argc==3) && (strcmp(argv[1], "-format") == 0))
	{
		FILE *fd=fopen(argv[2], "wb");
		if (fd==NULL)
		{
			printf("impossible d'ouvrir %s\n", argv[2]);
		}
		else
		{
			fwrite(floppyDisk, 1, diskSize, fd);
			fclose(fd);
		}
	}
	else if ((argc>=4) && (strcmp(argv[1], "-add") == 0))
	{
		FILE *fd=fopen(argv[2], "wb");
		if (fd==NULL)
		{
			printf("impossible d'ouvrir %s\n", argv[2]);
		}
		else
		{
			for (int i=3; i<argc; i++)
			{
				FILE *fi=fopen(argv[i], "rb");
				if (fi==NULL)
				{
					printf("impossible d'ouvrir %s\n", argv[i]);
				}
				else
				{
					fseek(fi, 0, SEEK_END);
					int size = ftell(fi);
					byte *fileData = malloc(size);
					memset(fileData, 0, size);
					fseek(fi, 0, SEEK_SET);

					int nbr = fread(fileData, 1, size, fi);
					fclose(fi);
					printf("lecture de %s (%d octets) %s\n", argv[i], size, size==nbr?"OK":"KO");

					addFile(argv[i], fileData, size);
				}
			}
			fwrite(floppyDisk, 1, diskSize, fd);
			fclose(fd);
		}
	}
	else if ((argc>=6) && (strcmp(argv[1], "-addBL") == 0))
	{
		FILE *fd=fopen(argv[2], "wb");
		if (fd==NULL)
		{
			printf("impossible d'ouvrir %s\n", argv[2]);
		}
		else
		{
			addBootLoader(argv[3], argv[4]);
			for (int i=5; i<argc; i++)
			{
				FILE *fi=fopen(argv[i], "rb");
				if (fi==NULL)
				{
					printf("impossible d'ouvrir %s\n", argv[i]);
				}
				else
				{
					fseek(fi, 0, SEEK_END);
					int size = ftell(fi);
					byte *fileData = malloc(size);
					memset(fileData, 0, size);
					fseek(fi, 0, SEEK_SET);

					int nbr = fread(fileData, 1, size, fi);
					fclose(fi);
					printf("lecture de %s (%d octets) %s\n", argv[i], size, size==nbr?"OK":"KO");

					addFile(argv[i], fileData, size);
				}
			}
			fwrite(floppyDisk, 1, diskSize, fd);
			fclose(fd);
		}
	}
	else if ((argc>=4) && (strcmp(argv[1], "-ext") == 0))
	{
		FILE *fd=fopen(argv[2], "rb");
		if (fd==NULL)
		{
			printf("impossible d'ouvrir %s\n", argv[2]);
		}
		else
		{
			int size = diskSize;
			int nbr = fread(floppyDisk, 1, size, fd);
			fclose(fd);
			printf("lecture de %s (%d octets) %s\n", argv[2], size, size==nbr?"OK":"KO");

			for (int i=3; i<argc; i++)
			{
				char filename[13] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
				for (int c=0; c<strlen(argv[i]); c++)
				{
					filename[c] = toupper(argv[i][c]);
				}
				FILE *fi=fopen(filename, "wb");
				if (fi==NULL)
				{
					printf("impossible d'ouvrir %s\n", filename);
				}
				else
				{
					extFile(filename, fi);
					fclose(fi);
				}
			}
		}
	}
	else if ((argc==3) && (strcmp(argv[1], "-list") == 0))
	{
		FILE *fd=fopen(argv[2], "rb");
		if (fd==NULL)
		{
			printf("impossible d'ouvrir %s\n", argv[2]);
		}
		else
		{
			int nbr = fread(floppyDisk, 1, diskSize, fd);
			list(fd);
			fclose(fd);
		}
	}
	else
	{
		printf("usage : %s -format filename.fd\n", argv[0]);
		printf("usage : %s -add filename.fd filename1 filename2 ...\n", argv[0]);
		printf("usage : %s -addBL filename.fd BOOT.BIN LOAD.BIN filename1 filename2 ...\n", argv[0]);
		printf("usage : %s -ext filename.fd filename1 filename2 ...\n", argv[0]);
		printf("usage : %s -list filename.fd\n", argv[0]);
	}

	return 0;
}
