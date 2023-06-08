SUBDIRS = $(filter-out $(wildcard AUTO*), $(patsubst %/,%,$(wildcard */)))
BINNAMES = CRACKY.BIN CAVIT.BIN LIFT.BIN CACORM.BIN NEURAS.BIN BOOTSKELL.BIN BATTLOT.BIN AERIAL.BIN

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) dist.zip

clean:
	-rm -f $(BINNAMES) BOOT.BIN LOAD.BIN fdfs InufuTO.fd dist.zip
	-$(MAKE) -C AUTO.BOOT $@
	-$(MAKE) -C AUTO.LOAD $@
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done

fdfs:
	gcc -O2 -o fdfs fdfs.c

$(SUBDIRS): fdfs
	$(MAKE) -C $@
	./fdfs -ext $@/$@.fd $@.bin

BOOT.BIN: fdfs
	$(MAKE) -C AUTO.BOOT
	./fdfs -ext AUTO.BOOT/BOOT.fd BOOT.BIN

LOAD.BIN: fdfs
	$(MAKE) -C AUTO.LOAD
	./fdfs -ext AUTO.LOAD/LOAD.fd LOAD.BIN

dist.zip: fdfs $(SUBDIRS) BOOT.BIN LOAD.BIN
	./fdfs -addBL InufuTO.fd BOOT.BIN LOAD.BIN $(BINNAMES)
	find . -regex ".*\.\(m7\|k7\)" -print | zip $@ InufuTO.fd -@

