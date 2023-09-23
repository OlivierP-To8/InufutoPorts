name=aerial

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

Main.asm: Main.c Main.h ../Init.h Vram.h Stage.h ../ScanKeys.h Sprite.h Sound.h \
	MyFighter.h MyBullet.h EnemyFighter.h EnemyBullet.h GroundEnemy.h Fort.h \
	Bang.h Item.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h
Stage.h: VVram.h
Stage.asm: Stage.c Stage.h Main.h Chars.h CopyMemory.h \
	Math.h Status.h Movable.h Sprite.h MyBullet.h EnemyFighter.h EnemyBullet.h \
	GroundEnemy.h Fort.h Bang.h Item.h Stages.h
Status.asm: Status.c Status.h Vram.h Sprite.h Main.h Movable.h Movable.h Sprite.h \
	Chars.h Print.h CopyMemory.h

Movable.asm: Movable.c Movable.h
Fighter.h: Movable.h
Fighter.asm: Fighter.c Fighter.h
MyFighter.h: Fighter.h
MyFighter.asm: MyFighter.c MyFighter.h Stage.h Chars.h Sprite.h ../ScanKeys.h Sprite.h \
	MyBullet.h Sound.h Bang.h Status.h Main.h Fort.h
Bullet.h: Movable.h
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h
MyBullet.h: Bullet.h
MyBullet.asm: MyBullet.c MyBullet.h Sprite.h Chars.h Sound.h MyFighter.h EnemyFighter.h \
	GroundEnemy.h Fort.h
EnemyFighter.h: Fighter.h
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Sprite.h Stage.h Chars.h Math.h Bullet.h \
	Sound.h Bang.h Main.h EnemyBullet.h MyFighter.h MyBullet.h
EnemyBullet.h: Bullet.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Chars.h
GroundEnemy.h: Movable.h
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Sprite.h Chars.h Stage.h MyBullet.h \
	Sound.h Bang.h Main.h Math.h MyFighter.h EnemyBullet.h
Fort.asm: Fort.c Fort.h Chars.h VVram.h Main.h Stage.h Movable.h Sound.h Bang.h \
	Math.h EnemyBullet.h MyFighter.h
Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h
Item.h: Movable.h
Item.asm: Item.c Item.h Sprite.h VVram.h MyFighter.h Status.h Main.h Sound.h Chars.h


Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h
VramA.obj: VramA.asm Vram.inc 
Print.asm: Print.c Print.h Vram.h
Sprite.h: Movable.h
Sprite.asm: Sprite.c Sprite.h VVram.h Bullet.h
Sound.obj: Sound.asm
VVram.h: Vram.h
VVram.asm: VVram.c VVram.h Vram.h

objects = Startup.obj \
	Main.obj Chars.obj Stages.obj Stage.obj Status.obj  \
	Fighter.obj MyFighter.obj Bullet.obj MyBullet.obj EnemyFighter.obj Bang.obj \
	EnemyBullet.obj GroundEnemy.obj Fort.obj Item.obj \
	../Init.obj ../ScanKeys.obj Sound.obj Vram.obj VramA.obj Print.obj   \
	Movable.obj Sprite.obj VVram.obj VVramA.obj \
	Math.obj CopyMemory.obj \
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
