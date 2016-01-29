PLATFORM=solaris.x86.sunspro

include ../src/makefile.inc

VPATH=../src

.PHONY: clean

targets = libcchlp.a

all: $(targets) 

libcchlp.a: $(lib_o)
	-rm -f $@
	$(AR) rc $@ $(lib_o)
	$(RANLIB) $@

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

#include ../src/makefile.rules
#include ../src/makefile.dep
