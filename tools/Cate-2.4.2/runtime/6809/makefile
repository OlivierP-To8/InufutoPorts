name=cate09

all: $(name).lib

%.obj: %.asm
	../../../Asm09 $*.asm

objects = Direct.obj \
	ShiftLeftA.obj ShiftRightA.obj ShiftRightSignedA.obj \
	ShiftLeftWord.obj ShiftRightWord.obj ShiftRightSignedWord.obj

$(name).lib: $(objects)
	../../../Lib8 $(name).lib $(objects)
	mv -f $(name).lib ../../../

