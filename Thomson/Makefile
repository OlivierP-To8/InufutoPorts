SUBDIRS = $(filter-out $(wildcard AUTO*), $(patsubst %/,%,$(wildcard */)))
BINNAMES = CRACKY.BIN CAVIT.BIN LIFT.BIN CACORM.BIN NEURAS.BIN BOOTSKELL.BIN BATTLOT.BIN AERIAL.BIN IMPETUS.BIN RUPTUS.BIN GUNTUS.BIN ASCEND.BIN HOPMAN.BIN MAZY.BIN
CHGNAMES = $(patsubst %.BIN,%.CHG,$(BINNAMES))

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) InufuTO.zip

clean:
	-rm -f $(BINNAMES) $(CHGNAMES) BOOT.BIN LOAD.BIN fdfs InufuTO*.fd InufuTO.zip *.lst *.obj
	-$(MAKE) -C AUTO.BOOT $@
	-$(MAKE) -C AUTO.LOAD $@
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done

%.obj: %.asm
	../tools/Asm09 $*.asm

Init.obj: Init.asm
ScanKeys.obj: ScanKeys.asm
VramColor.obj: VramColor.asm

fdfs:
	gcc -O2 -o fdfs fdfs.c

$(SUBDIRS): fdfs Init.obj ScanKeys.obj VramColor.obj
	$(MAKE) -C $@
	./fdfs -ext $@/$@.fd $@.bin
	cp $@/$@.m7 $(shell echo $@ | tr  '[:lower:]' '[:upper:]').CHG

# Boot sector for custom BIN loader
BOOT.BIN: fdfs
	$(MAKE) -C AUTO.BOOT
	./fdfs -ext AUTO.BOOT/BOOT.fd BOOT.BIN
	-rm AUTO.BOOT/BOOT.fd

# Custom BIN loader, to use the floppy disk even without DOS in BASIC ROM
# the loader has CSEG at $9500-$9FFF and DSEG at $7400-$77FF
# all BINs to be loaded from disk have CSEG at $A000-$D8FF and DSEG at $8000-$9300
# the system stack is below $8000, down to $7800 (2 Kbytes) without conflict
LOAD.BIN: fdfs ScanKeys.obj
	$(MAKE) -C AUTO.LOAD
	./fdfs -ext AUTO.LOAD/LOAD.fd LOAD.BIN
	-rm AUTO.LOAD/LOAD.fd

InufuTO.zip: fdfs $(SUBDIRS) BOOT.BIN LOAD.BIN
# The DOS is not in the BASIC 1 ROM, but only in BASIC 128 and 512.
# It (BASIC.DOS) can be added in the floppy boot sector but it takes too much RAM.
#	./fdfs -addDOS InufuTO.fd BASIC.DOS AUTO.BAT $(BINNAMES)

# Custom BIN loader from floppy, without using DOS.
	./fdfs -addBL InufuTO.fd BOOT.BIN LOAD.BIN $(BINNAMES)

# Floppy of MEMO7 (ROM cartridge) binaries, to use on TO8 from the "4 Appel de programme" boot menu.
	./fdfs -add InufuTO_chg.fd $(CHGNAMES)

# ZIP file of all the binaries.
	find . -mindepth 2 -regex ".*\.\(m7\|k7\|fd\)" -print | zip $@ InufuTO.fd InufuTO_chg.fd -@
