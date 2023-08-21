name=bootskell

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=A700
dseg=A720
cseg=6D00
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6700
drom=6720
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ../ScanKeys.h Sprite.h Vram.h Sound.h Status.h Stage.h Man.h \
	Block.h Monster.h Math.h Point.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Chars.h CopyMemory.h Status.h \
	Man.h Block.h Point.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h
Man.asm: Man.c Movable.h Man.h Sprite.h Stage.h Movable.h ../ScanKeys.h Block.h \
	Sound.h Main.h Chars.h VVram.h
Block.asm: Block.c Movable.h Block.h Sprite.h Stage.h Vram.h Chars.h Man.h Monster.h \
	Point.h Math.h Sound.h VVram.h
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Stage.h Movable.h Block.h \
	Math.h Man.h Main.h Chars.h
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h	

Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h
Print.asm: Print.c Print.h Vram.h
VVram.asm: VVram.c VVram.h Chars.h Vram.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h

Chars.obj: Chars.asm
CopyMemory.obj: CopyMemory.asm
Sound.obj: Sound.asm
VramA.obj: VramA.asm Vram.inc VVram.inc
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Main.obj Status.obj Stage.obj Movable.obj \
	Man.obj Block.obj Monster.obj Point.obj \
	Stages.obj Chars.obj VVram.obj VVramA.obj \
	../Init.obj ../ScanKeys.obj Vram.obj VramA.obj Print.obj \
	Sprite.obj Sound.obj CopyMemory.obj Math.obj \
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
