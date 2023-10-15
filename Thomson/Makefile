SUBDIRS = $(filter-out $(wildcard AUTO*), $(patsubst %/,%,$(wildcard */)))
BINNAMES = CRACKY.BIN CAVIT.BIN LIFT.BIN CACORM.BIN NEURAS.BIN BOOTSKELL.BIN BATTLOT.BIN AERIAL.BIN IMPETUS.BIN RUPTUS.BIN GUNTUS.BIN ASCEND.BIN HOPMAN.BIN MAZY.BIN

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) InufuTO.zip

clean:
	-rm -f $(BINNAMES) BOOT.BIN LOAD.BIN fdfs InufuTO.fd InufuTO.zip *.lst *.obj
	-$(MAKE) -C AUTO.BOOT $@
	-$(MAKE) -C AUTO.LOAD $@
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done

%.obj: %.asm
	../tools/Asm09 $*.asm

Init.obj: Init.asm
ScanKeys.obj: ScanKeys.asm

fdfs:
	gcc -O2 -o fdfs fdfs.c

$(SUBDIRS): fdfs Init.obj ScanKeys.obj
	$(MAKE) -C $@
	./fdfs -ext $@/$@.fd $@.bin

BOOT.BIN: fdfs
	$(MAKE) -C AUTO.BOOT
	./fdfs -ext AUTO.BOOT/BOOT.fd BOOT.BIN

LOAD.BIN: fdfs ScanKeys.obj
	$(MAKE) -C AUTO.LOAD
	./fdfs -ext AUTO.LOAD/LOAD.fd LOAD.BIN

InufuTO.zip: fdfs $(SUBDIRS)
	./fdfs -addDOS InufuTO.fd BASIC.DOS AUTO.BAT $(BINNAMES)
	find . -mindepth 2 -regex ".*\.\(m7\|k7\|fd\)" -print | zip $@ InufuTO.fd -@
