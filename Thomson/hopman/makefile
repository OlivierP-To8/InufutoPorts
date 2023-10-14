name=hopman

all: $(name).m7 $(name).k7 $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG must end before 9FFF or start at A000
zseg=8000
dseg=8020
cseg=A000
#	DROM must end before 7FFF for TO7 without RAM expansion
zrom=7300
drom=7320
crom=0022

%.obj: %.c
	../../tools/Cate09 $*.c
	../../tools/Asm09 $*.asm

%.obj: %.asm
	../../tools/Asm09 $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ../Init.h ../ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Math.h Man.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ../ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h Vram.h Main.h Lift.h Movable.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h \
	Math.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h \
	Stage.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Math.h Sprite.h Movable.h Status.h \
	CopyMemory.h Man.h Movable.h Goal.h Movable.h Stage.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Goal.h Movable.h Stage.h Movable.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc
VVramA.obj: VVramA.asm Vram.inc VVram.inc

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ../Init.obj ../ScanKeys.obj Sound.obj \
	StageA.obj  VramA.obj VVramA.obj \
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
