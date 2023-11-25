SUBDIRS = $(filter-out $(wildcard AUTO*), $(patsubst %/,%,$(wildcard */)))
BINNAMES = HOPMAN.BIN CRACKY.BIN GUNTUS.BIN CACORM.BIN ASCEND.BIN LIFT.BIN AERIAL.BIN BOOTSKELL.BIN IMPETUS.BIN CAVIT.BIN BATTLOT.BIN RUPTUS.BIN NEURAS.BIN MAZY.BIN
CHGNAMES = $(patsubst %.BIN,%.CHG,$(BINNAMES))

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) InufuTO.zip InufuTO_sd.zip InufuTO_hfe.zip

clean:
	-rm -f $(BINNAMES) $(CHGNAMES) BOOT.BIN LOAD.BIN *.lst *.obj
	-rm -f fdfs InufuTO.fd InufuTO_chg.fd InufuTO.zip 
	-rm -f fdtosd InufuTO.sd InufuTO_sd.zip
	-rm -f fdtohfe InufuTO.hfe InufuTO_hfe.zip
	-$(MAKE) -C AUTO.BOOT $@
	-$(MAKE) -C AUTO.LOAD $@
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done

%.obj: %.asm
	../tools/Asm09 $*.asm

Init.obj: Init.asm
ScanKeys.obj: ScanKeys.asm
VramColor.obj: VramColor.asm

fdfs:
	gcc -O2 -o $@ $@.c

fdtosd:
	gcc -O2 -o $@ $@.c

fdtohfe:
	gcc -o $@ $@.c

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
# +---------------------------+ $D8FF
# |                           |
# |                           |
# |         CSEG Game         |
# |                           |
# |                           |
# +---------------------------+ $A000
# |        CSEG Loader        |
# +---------------------------+ $9500
# +---------------------------+ $9300
# |                           |
# |         DSEG Game         |
# |                           |
# +---------------------------+ $8000
# |      Stack Game (2K)      |
# +---------------------------+ $7800
# |        DSEG Loader        |
# +---------------------------+ $7400
LOAD.BIN: fdfs ScanKeys.obj
	$(MAKE) -C AUTO.LOAD
	./fdfs -ext AUTO.LOAD/LOAD.fd LOAD.BIN
	-rm AUTO.LOAD/LOAD.fd

InufuTO.fd: fdfs $(SUBDIRS) BOOT.BIN LOAD.BIN
# The DOS is not in the BASIC 1 ROM, but only in BASIC 128 and 512.
# It (BASIC.DOS) can be added in the floppy boot sector but it takes too much RAM.
#	./fdfs -addDOS InufuTO.fd BASIC.DOS AUTO.BAT $(BINNAMES)

# Custom BIN loader from floppy, without using DOS.
	./fdfs -addBL InufuTO.fd BOOT.BIN LOAD.BIN $(BINNAMES)

InufuTO_chg.fd: fdfs $(SUBDIRS)
# Floppy of MEMO7 (ROM cartridge) binaries, to use on TO8 from the "4 Appel de programme" boot menu.
	./fdfs -add InufuTO_chg.fd $(CHGNAMES)

InufuTO.zip: InufuTO.fd InufuTO_chg.fd
# ZIP file of all the binaries.
	find . -mindepth 2 -regex ".*\.\(m7\|k7\|fd\)" -print | zip $@ InufuTO.fd InufuTO_chg.fd -@

# See HARDWARE.md for SD file usage.
InufuTO.sd: InufuTO.fd
	./fdtosd -conv InufuTO.fd InufuTO.sd

InufuTO_sd.zip: fdtosd InufuTO.sd
	zip $@ InufuTO.sd

# See HARDWARE.md for HFE file usage.
InufuTO.hfe: InufuTO.fd
# Interleave factor 2 is the fastest with LOAD.BIN
	./fdtohfe -conv InufuTO.fd InufuTO.hfe 2

InufuTO_hfe.zip: fdtohfe InufuTO.hfe
	zip $@ InufuTO.hfe
