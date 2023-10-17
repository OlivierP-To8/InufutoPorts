name=mazy

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=7100
drom=7120
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Knife.asm: Knife.c Knife.h Map.h Math.h VVram.h Chars.h \
	Man.h Status.h Sound.h Monster.h Main.h 
Main.asm: Main.c Main.h ../ScanKeys.h Man.h Knife.h Monster.h \
	Status.h Vram.h Sound.h ../Init.h VVram.h Map.h 
Man.asm: Man.c Man.h Map.h ../ScanKeys.h Chars.h Vram.h \
	VVram.h Main.h Knife.h Sound.h 
Map.asm: Map.c Map.h CopyMemory.h Main.h Stages.h Man.h \
	Knife.h Monster.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Map.h Chars.h VVram.h Man.h \
	Main.h Sound.h 
Status.asm: Status.c Status.h Vram.h Main.h Chars.h Print.h \
	Knife.h 
Vram.asm: Vram.c Vram.h Chars.h ../VramColor.h
VVram.asm: VVram.c VVram.h Chars.h Map.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
Sound.obj: Sound.asm 
Stages.obj: Stages.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj Main.obj \
	Knife.obj Man.obj Map.obj Monster.obj Print.obj \
	Status.obj Vram.obj VVram.obj Chars.obj \
	Sound.obj Stages.obj VramA.obj VVramA.obj \
	Math.obj CopyMemory.obj \
	../Init.obj ../ScanKeys.obj ../VramColor.obj \
	../../tools/cate09.lib

$(name).fd: $(objects) makefile
	../../tools/LinkBE $(name).fd $(cseg) $(dseg) $(zseg) $(objects)
	-@tail -n3 $(name).symbols.txt
	-@mv -f $(name).symbols.txt $(name).fd.symbols.txt

$(name).k7: $(objects) makefile
	../../tools/LinkBE $(name).k7 $(cseg) $(dseg) $(zseg) $(objects)
	-@tail -n3 $(name).symbols.txt
	-@mv -f $(name).symbols.txt $(name).k7.symbols.txt

$(name).m7: $(objects) makefile
	../../tools/LinkBE $(name).m7 $(crom) $(drom) $(zrom) $(objects)
	-@tail -n3 $(name).symbols.txt
	-@mv -f $(name).symbols.txt $(name).m7.symbols.txt

clean:
	-rm *.lst *.obj $(name).fd $(name).k7 $(name).m7 $(name).*.symbols.txt
	@for c in $(shell ls *.c); do rm $${c%.*}.asm; done
