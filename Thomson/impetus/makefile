name=impetus

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

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Math.h Main.h VVram.h \
	Chars.h VVram.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h VVram.h Fighter.h Math.h \
	Chars.h 
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ../ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h VVram.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Stage.h Barrier.h Fort.h Sound.h \
	Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Chars.h VVram.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Stage.h Sprite.h VVram.h \
	Math.h Main.h EnemyBullet.h Bang.h Main.h Sound.h \
	Chars.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h VVram.h Chars.h 
Main.asm: Main.c Main.h ../Init.h Stage.h ../ScanKeys.h VVram.h \
	Sprite.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h \
	Bang.h Barrier.h GroundEnemy.h Stage.h Fort.h Sound.h \
	Item.h Vram.h 
Math.asm: Math.c Math.h 
Print.asm: Print.c Print.h Vram.h Status.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h VVram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h Chars.h 
Sprite.asm: Sprite.c Sprite.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h VVram.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h \
	Bang.h Math.h Status.h Barrier.h GroundEnemy.h Stage.h \
	Fort.h Sprite.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h VVram.h \
	Chars.h Print.h CopyMemory.h 
Tile.asm: Tile.c Tile.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h Fort.h \
	Barrier.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 


objects = Startup.obj \
	Main.obj Stages.obj Stage.obj Fighter.obj FighterBullet.obj SkyEnemy.obj \
	Barrier.obj GroundEnemy.obj Fort.obj EnemyBullet.obj Bang.obj Item.obj \
	Status.obj VVram.obj VVramA.obj  Print.obj \
	../Init.obj ../ScanKeys.obj Sound.obj Vram.obj VramA.obj Sprite.obj Chars.obj \
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
