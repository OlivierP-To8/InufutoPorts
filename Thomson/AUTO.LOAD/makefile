name=LOAD

all: $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG, DSEG and ZSEG mustn't be in the CSEG of the BIN files to load
zseg=7400
dseg=7420
cseg=9500
# /!\ cseg value is used in ScanKeys.asm

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c ../ScanKeys.h Vram.h File.h
Vram.asm: Vram.c Vram.h Chars.h
File.asm: File.c File.h
Chars.obj: Chars.asm
CopyMemory.obj: CopyMemory.asm 
Floppy.obj: Floppy.asm
Print.obj: Print.asm 
Startup.obj: Startup.asm
VramA.obj: VramA.asm Vram.inc

objects = Startup.obj Main.obj Vram.obj VramA.obj Chars.obj \
	Print.obj ../ScanKeys.obj CopyMemory.obj  File.obj Floppy.obj \
	../../tools/cate09.lib

$(name).fd: $(objects) makefile
	../../tools/LinkBE $(name).fd $(cseg) $(dseg) $(zseg) $(objects)
	-@tail -n3 $(name).symbols.txt
	-@mv -f $(name).symbols.txt $(name).fd.symbols.txt

clean:
	-rm *.lst *.obj $(name).fd $(name).*.symbols.txt
	@for c in $(shell ls *.c); do rm $${c%.*}.asm; done
