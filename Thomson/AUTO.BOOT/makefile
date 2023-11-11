name=BOOT

all: $(name).fd

#Check the end of $(name).symbols.txt:
#	CSEG, DSEG and ZSEG must not overlap
#	CSEG, DSEG and ZSEG must be in the DSEG of the BIN files to load
#	CSEG must be 6200
zseg=7300
dseg=7300
cseg=6200

%.obj: %.asm
	../../tools/Asm09 $*.asm

Floppy.obj: Floppy.asm

objects = Floppy.obj ../../tools/cate09.lib

$(name).fd: $(objects) makefile
	../../tools/LinkBE $(name).fd $(cseg) $(dseg) $(zseg) $(objects)
	-@tail -n3 $(name).symbols.txt
	-@mv -f $(name).symbols.txt $(name).fd.symbols.txt

clean:
	-rm *.lst *.obj $(name).fd $(name).*.symbols.txt

