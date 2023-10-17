name=cavit

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6D00
drom=6D20
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ../ScanKeys.h Sound.h Status.h Stage.h Sprite.h \
	Man.h Chaser.h Ghost.h Rock.h Point.h Box.h VVram.h
Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h
Stages.asm: Stages.c Stages.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h Sprite.h Chars.h \
	Man.h Box.h Rock.h Chaser.h Ghost.h Direction.h Point.h VVram.h
Fixed.asm: Fixed.c Fixed.h
Box.h: Fixed.h
Box.asm: Box.c Box.h Stage.h Stages.h VVram.h Chars.h Sprite.h Point.h Man.h Sound.h
Rock.h: Fixed.h Movable.h
Rock.asm: Rock.c Rock.h Stage.h Stages.h VVram.h Chars.h Sprite.h Direction.h \
	Man.h Point.h Chaser.h Ghost.h Sound.h Main.h
Direction.asm: Direction.c Direction.h
Movable.asm: Movable.c Movable.h Sprite.h Stage.h Direction.h 
Man.h: Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Stage.h ../ScanKeys.h Direction.h Chars.h VVram.h \
	Rock.h Sound.h
Monster.h: Movable.h
Monster.asm: Monster.c Monster.h Stage.h Rock.h Sprite.h Chaser.h Ghost.h Man.h
Chaser.h: Monster.h
Chaser.asm: Chaser.c Chaser.h Sprite.h Stage.h Man.h Direction.h Chars.h
Ghost.h: Monster.h
Ghost.asm: Ghost.c Ghost.h Sprite.h Stage.h Man.h Direction.h Main.h Chars.h
Point.h: Movable.h
Point.asm: Point.c Point.h Sprite.h Main.h Chars.h

Vram.asm: Vram.c Vram.h Chars.h ../VramColor.h
VramA.obj: VramA.asm Vram.inc 
Print.asm: Print.c Print.h Vram.h
Sprite.h: Movable.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.h: Vram.h
VVram.asm: VVram.h Chars.h Vram.h

objects = Startup.obj Main.obj \
	Status.obj Stages.obj Stage.obj Fixed.obj Box.obj Rock.obj \
	Direction.obj Movable.obj Man.obj Monster.obj Chaser.obj Ghost.obj Point.obj \
	Chars.obj Print.obj VVram.obj VVramA.obj \
	Vram.obj VramA.obj Sprite.obj Sound.obj \
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
