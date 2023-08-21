name=neuras

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=A800
dseg=A820
cseg=7700
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6800
drom=6820
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h \
	VVram.h 
Main.asm: Main.c Stage.h ../ScanKeys.h Solver.h Card.h Stage.h \
	Monster.h Stage.h Status.h Sprite.h Vram.h Sound.h \
	../Init.h 
MapToVVram.asm: MapToVVram.c MapToVVram.h Vram.h Stage.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Sound.h 
Print.asm: Print.c Print.h Vram.h 
Solver.asm: Solver.c Solver.h ../ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h \
	VVram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h VVram.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h MapToVVram.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Main.obj Stage.obj Stages.obj Chars.obj Solver.obj Card.obj Monster.obj \
	../Init.obj Vram.obj VramA.obj VVram.obj VVramA.obj MapToVVram.obj Sprite.obj \
	../ScanKeys.obj Status.obj Sound.obj CopyMemory.obj Print.obj \
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
