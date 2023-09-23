name=battlot

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

Main.asm : Main.c Main.h ../ScanKeys.h Status.h Stage.h Vram.h Sprite.h Bullet.h Bang.h \
	Fort.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h Bullet.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h Fort.h Robo.h Bang.h \
	Status.h VVram.h
Status.asm: Status.c Status.h Stage.h Chars.h  Vram.h Sprite.h Print.h Chars.h VVram.h
Fort.asm: Fort.c Fort.h VVram.h Chars.h Stage.h Robo.h Bang.h Sprite.h Sound.h
Direction.asm: Direction.c Direction.h
Robo.h: Bullet.h
Robo.asm: Robo.c Robo.h Direction.h Sprite.h Stage.h Fort.h Bullet.h
MyRobo.asm: MyRobo.c Robo.h Sprite.h Direction.h Stage.h ../ScanKeys.h Fort.h Bang.h \
	Main.h Sound.h Chars.h
EnemyRobo.asm: EnemyRobo.c Robo.h Sprite.h Main.h Fort.h Stage.h Direction.h Bullet.h \
	Bang.h Sound.h Chars.h
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h Robo.h Fort.h Chars.h
Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h

Vram.asm: Vram.c Vram.h
VramA.obj: VramA.asm Vram.inc 
Print.asm: Print.c Print.h Vram.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.h: Vram.h
VVram.asm: VVram.h Chars.h

objects = Startup.obj \
	Main.obj Stages.obj Stage.obj Status.obj Fort.obj Direction.obj  \
	Robo.obj MyRobo.obj EnemyRobo.obj Bullet.obj Bang.obj \
	Print.obj \
	../Init.obj ../ScanKeys.obj Sound.obj Vram.obj VramA.obj VVram.obj VVramA.obj Sprite.obj \
	Chars.obj CopyMemory.obj \
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
