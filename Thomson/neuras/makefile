name=neuras

all: $(name).cas

cseg=2000
zseg=4900
dseg=4920

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h \
	VVram.h 
Main.asm: Main.c Stage.h ScanKeys.h Solver.h Card.h Stage.h \
	Monster.h Stage.h Status.h Sprite.h Vram.h Sound.h \
	Init.h 
MapToVVram.asm: MapToVVram.c MapToVVram.h Vram.h Stage.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Sound.h 
Print.asm: Print.c Print.h Vram.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h \
	VVram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h VVram.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h MapToVVram.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Main.obj Stage.obj Stages.obj Chars.obj Solver.obj Card.obj Monster.obj \
	Init.obj Vram.obj VramA.obj VVram.obj VVramA.obj MapToVVram.obj Sprite.obj \
	ScanKeys.obj Status.obj Sound.obj CopyMemory.obj Print.obj \
	..\..\cate\cate09.lib

$(name).c10: $(objects)
	LinkBE.exe $(name).c10 $(cseg) $(dseg) $(zseg) $(objects)

$(name).cas: $(name).c10
	copy $(name).c10 $(name).cas /y
