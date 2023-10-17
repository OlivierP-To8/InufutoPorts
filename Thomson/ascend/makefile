name=ascend

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6F00
drom=6F20
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ../ScanKeys.h Vram.h Sound.h Status.h Stage.h \
	Movable.h Actor.h Sprite.h Man.h Fire.h Monster.h VVram.h
Movable.asm: Movable.c Movable.h
Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h Man.h
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Chars.h Stage.h ../ScanKeys.h \
	Block.h Sound.h Main.h Fire.h Status.h VVram.h
Fire.asm: Fire.c Movable.h Actor.h Sprite.h Fire.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h VVram.h
Monster.asm: Monster.c Movable.h Actor.h Sprite.h Monster.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h
Block.asm: Block.c Movable.h Actor.h Sprite.h Block.h Chars.h Stage.h Stages.h \
	Vram.h Man.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Vram.h \
	Movable.h Actor.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h Vram.h Status.h \
	Movable.h Actor.h Man.h Fire.h Monster.h Block.h Math.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h

Vram.asm: Vram.c Vram.h Chars.h ../VramColor.h
VramA.obj: VramA.asm Vram.inc Chars.inc
Sprite.asm: Sprite.c Sprite.h VVram.h Chars.h Movable.h Vram.h Stage.h
VVram.asm: VVram.h Chars.h Vram.h Sprite.h
VVramA.obj: VramA.asm Vram.inc Chars.inc
Print.asm: Print.c Print.h Vram.h

objects = Startup.obj Main.obj \
	Status.obj Stage.obj Stages.obj Chars.obj \
	Vram.obj VramA.obj Print.obj VVram.obj VVramA.obj \
	Sprite.obj Sound.obj Math.obj \
	Actor.obj Movable.obj Man.obj Fire.obj Monster.obj Block.obj \
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
