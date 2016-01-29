PLATFORM=gnuwin32

include ../../../platforms/$(PLATFORM).inc
include ../src/makefile.inc

VPATH=../src


.PHONY: clean

targets = gpack.exe

all: $(targets) 

gpack.exe: $(all_objs) 
	$(CC) $(all_objs) $(LDFLAGS) -o $@

copy: $(targets)
	for i in $(targets); do \
		cp $$i $(PLACE); \
	done

clean:
	-rm -f $(all_objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
