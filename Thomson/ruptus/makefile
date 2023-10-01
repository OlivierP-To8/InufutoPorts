name=ruptus

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=6E00
drom=6E20
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Main.asm: Main.c Main.h ../ScanKeys.h Stage.h Vram.h Fighter.h Fort.h Star.h Barrier.h \
	VVram.h Enemy.h FighterBullet.h EnemyBullet.h Bang.h Item.h \
	Status.h Sprite.h Sound.h
Stages.asm: Stages.c Stages.h
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h Barrier.h Enemy.h \
	FighterBullet.h Bang.h Sprite.h EnemyBullet.h Item.h
VVram.asm: VVram.h Chars.h
Direction.asm: Direction.c Direction.h
Star.asm: Star.c Star.h VVram.h Chars.h
Mover.asm: Mover.c Mover.h
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h Direction.h \
	../ScanKeys.h FighterBullet.h Bang.h Barrier.h Fort.h Mover.h Item.h Main.h Status.h \
	Sound.h   Vram.h
Fort.asm: Fort.c Fort.h Stages.h VVram.h Chars.h Bang.h Main.h Mover.h Status.h Sound.h \
	Vram.h Fighter.h Sprite.h Rader.h
Fort.h: Stage.h
Barrier.asm: Barrier.c Barrier.h Stage.h VVram.h Chars.h Sprite.h Bang.h Main.h Sound.h \
	Vram.h
Barrier.h: Stage.h
Enemy.asm: Enemy.c Enemy.h Stage.h VVram.h Sprite.h Chars.h Direction.h Main.h \
	Bang.h Barrier.h Fort.h Mover.h Item.h Sound.h Vram.h
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Fort.h Sound.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Stage.h VVram.h \
	Chars.h Direction.h Fighter.h Barrier.h Fort.h Main.h
EnemyBullet.h:  Enemy.h
Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h
Item.asm: Item.c Item.h Chars.h
Print.asm: Print.c Print.h Vram.h

Status.asm: Status.c Status.h Stage.h Chars.h  Vram.h Print.h Main.h VVram.h Rader.h
Rader.asm: Rader.c Rader.h Vram.h Fighter.h
Sprite.asm: Sprite.c Sprite.h VVram.h Chars.h Vram.h
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h
VramA.obj: VramA.asm Vram.inc
Print.obj: Print.asm Vram.inc
Sound.obj: Sound.asm

objects = Startup.obj \
	Main.obj ../Init.obj ../ScanKeys.obj Vram.obj VramA.obj Sprite.obj VVram.obj \
	Chars.obj Status.obj Print.obj Sound.obj \
	Stages.obj Stage.obj Direction.obj Mover.obj Fighter.obj Fort.obj Barrier.obj \
	Enemy.obj Star.obj FighterBullet.obj EnemyBullet.obj Bang.obj Item.obj \
	Rader.obj CopyMemory.obj \
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
