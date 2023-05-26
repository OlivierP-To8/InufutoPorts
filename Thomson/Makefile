SUBDIRS = $(patsubst %/,%,$(wildcard */))

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS)

clean: 
	for c in $(SUBDIRS); do $(MAKE) -C $$c $@; done

$(SUBDIRS):
	$(MAKE) -C $@

