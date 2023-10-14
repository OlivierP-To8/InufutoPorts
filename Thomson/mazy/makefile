name=mazy

all: $(name).d88

cseg=0800
zseg=3800
dseg=3820

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Knife.asm: Knife.c Knife.h Map.h Math.h VVram.h Chars.h \
	Man.h Status.h Sound.h Monster.h Main.h 
Main.asm: Main.c Main.h ScanKeys.h Man.h Knife.h Monster.h \
	Status.h Vram.h Sound.h Init.h VVram.h Map.h 
Man.asm: Man.c Man.h Map.h ScanKeys.h Chars.h Vram.h \
	VVram.h Main.h Knife.h Sound.h 
Map.asm: Map.c Map.h CopyMemory.h Main.h Stages.h Man.h \
	Knife.h Monster.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Map.h Chars.h VVram.h Man.h \
	Main.h Sound.h 
Status.asm: Status.c Status.h Vram.h Main.h Chars.h Print.h \
	Knife.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Map.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm 
Loader.obj: Loader.asm BinSize.inc 
LoaderInt.obj: LoaderInt.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
stages.obj: stages.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = \
	Main.obj \
	Knife.obj Man.obj Map.obj Monster.obj Print.obj \
	Status.obj Vram.obj VVram.obj Chars.obj Init.obj \
	ScanKeys.obj Sound.obj Stages.obj VramA.obj VVramA.obj \
	Math.obj CopyMemory.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin bin.csx
	dotnet script bin.csx $(name) $(cseg)

Loader.obj: Loader.asm BinSize.inc

Loader.bin: Loader.obj LoaderInt.obj
	LinkBE.exe Loader.bin 01d1-01ff,0100 0200 LoaderInt.obj Loader.obj

$(name).d88: $(name).bin Loader.bin disk.csx
	dotnet script disk.csx $(name)
