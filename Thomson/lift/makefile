name=lift

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=AD00
dseg=AD20
cseg=7900
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6D00
drom=6D20
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h Sound.h Status.h Stage.h \
	Actor.h Monster.h Lift.h Man.h Item.h Point.h Movable.h VVram.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h Vram.h Movable.h \
	VVram.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Chars.h Vram.h Status.h Man.h Item.h \
	Lift.h Actor.h Monster.h Point.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h
Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h Chars.h ScanKeys.h Item.h \
	Sound.h VVram.h
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h Main.h Movable.h Actor.h \
	Point.h Sound.h Sprite.h VVram.h
Lift.asm: Lift.c Lift.h Movable.h Stages.h Vram.h Chars.h Sprite.h Actor.h Man.h \
	Monster.h Stage.h
Monster.asm: Monster.c Actor.h Monster.h Sprite.h Stage.h Man.h Main.h \
	Lift.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h Chars.h

Vram.asm: Vram.c Vram.h Chars.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.asm: VVram.h Chars.h Vram.h Sprite.h Sound.h
VVramA.obj: VVramA.asm VVram.inc Chars.inc
Print.asm: Print.c Print.h Vram.h

objects = Startup.obj \
	Main.obj Status.obj Stage.obj Movable.obj Actor.obj \
	Stages.obj Chars.obj Man.obj Item.obj Lift.obj Monster.obj Point.obj \
	Init.obj ScanKeys.obj Vram.obj VramA.obj Print.obj VVram.obj VVramA.obj \
	Sprite.obj Sound.obj CopyMemory.obj \
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
