SUBDIRS = $(patsubst %/,%,$(wildcard */))
BINNAMES = CRACKY.BIN CAVIT.BIN LIFT.BIN CACORM.BIN NEURAS.BIN BOOTSKELL.BIN BATTLOT.BIN AERIAL.BIN

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS) dist.zip

clean: 
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done
	rm -f $(BINNAMES) InufuTO.fd dist.zip

$(SUBDIRS):
	$(MAKE) -C $@

fdfs:
	gcc -O2 -o fdfs fdfs.c

dist.zip: fdfs $(SUBDIRS)
	for c in $(SUBDIRS); do ./fdfs -ext $${c}/$${c}.fd $${c}.bin; done
	./fdfs -add InufuTO.fd AUTO.BAT $(BINNAMES)
	find . -regex ".*\.\(m7\|k7\)" -print | zip $@ InufuTO.fd -@

