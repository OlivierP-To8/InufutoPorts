name=cacorm

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=7200
drom=7220
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ../ScanKeys.h Vram.h Sound.h Status.h Stage.h \
	Movable.h Sprite.h Man.h Monster.h Item.h Point.h Actor.h \
	VVram.h
Status.asm: Status.c Status.h Main.h Print.h Chars.h Vram.h \
	Movable.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h Vram.h Status.h \
	Movable.h Math.h Man.h Item.h Monster.h Point.h \
	VVram.h Line.h
Stages.asm: Stages.c Stage.h Stages.h
Movable.asm: Movable.c Movable.h
Actor.asm: Actor.c Movable.h Actor.h
Man.asm: Man.c Movable.h Man.h Sprite.h Stage.h Movable.h ../ScanKeys.h \
	Sound.h Main.h Chars.h Line.h Item.h Vram.h Status.h Actor.h Increaser.h \
	VVram.h
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h Line.h Main.h \
	Sound.h Movable.h Point.h Sprite.h Main.h Increaser.h \
	VVram.h
Line.asm: Line.c Line.h Chars.h Stage.h Vram.h Movable.h Sound.h Sprite.h \
	Item.h Monster.h Actor.h \
	VVram.h
Monster.asm: Monster.c Monster.h Sprite.h Stage.h Chars.h Math.h Man.h \
	Line.h Actor.h
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h Chars.h
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Chars.h

Vram.asm: Vram.c Vram.h Chars.h ../VramColor.h
VramA.obj: VramA.asm Vram.inc VVram.inc
VVram.asm: VVram.h Chars.h Vram.h Sound.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVramA.obj: VVramA.asm Vram.inc VVram.inc Chars.inc
Print.asm: Print.c Print.h Vram.h

objects = Startup.obj Main.obj \
	Status.obj Chars.obj Stage.obj Stages.obj \
	Vram.obj VramA.obj Print.obj \
	Movable.obj Actor.obj Man.obj Item.obj Line.obj \
	Monster.obj Point.obj Increaser.obj \
	Sprite.obj Sound.obj Math.obj VVram.obj VVramA.obj \
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
