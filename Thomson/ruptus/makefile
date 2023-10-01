name=ruptus

all: $(name).cas

cseg=2000
zseg=5700
dseg=5720

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Fighter.h Fort.h Star.h Barrier.h \
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
	ScanKeys.h FighterBullet.h Bang.h Barrier.h Fort.h Mover.h Item.h Main.h Status.h \
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

Status.asm: Status.c Status.h Stage.h Chars.h  Vram.h Print.h Main.h VVram.h Rader.h
Rader.asm: Rader.c Rader.h Vram.h Fighter.h
Init.obj: Init.asm 
ScanKeys.obj: ScanKeys.asm
Sprite.asm: Sprite.c Sprite.h VVram.h Chars.h Vram.h
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h
VramA.obj: VramA.asm Vram.inc
Print.obj: Print.asm Vram.inc
Sound.obj: Sound.asm

objects = Startup.obj \
	Main.obj Init.obj ScanKeys.obj Vram.obj VramA.obj Sprite.obj VVram.obj \
	Chars.obj Status.obj Print.obj Sound.obj \
	Stages.obj Stage.obj Direction.obj Mover.obj Fighter.obj Fort.obj Barrier.obj \
	Enemy.obj Star.obj FighterBullet.obj EnemyBullet.obj Bang.obj Item.obj \
	Rader.obj CopyMemory.obj \
	..\..\cate\cate09.lib

$(name).c10: $(objects)
	LinkBE.exe $(name).c10 $(cseg) $(dseg) $(zseg) $(objects)

$(name).cas: $(name).c10
	copy $(name).c10 $(name).cas /y
