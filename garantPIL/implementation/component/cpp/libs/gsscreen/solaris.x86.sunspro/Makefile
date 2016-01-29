PLATFORM=solaris.x86.sunspro

include ../src/makefile.inc

DEFS= -D_USE_STDOUT
CFLAGS+= $(DEFS) $(OPTFLAGS)
CXXFLAGS+=  $(CXXINCS) $(DEFS) $(OPTFLAGS)

VPATH=../src

.PHONY: clean

targets = libgsscreen.a

all: $(targets) 

libgsscreen.a: $(lib_o)
	-rm -f $@
	$(AR) rc $@ $(lib_o)
	$(RANLIB) $@

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

#include ../src/makefile.rules
#include ../src/makefile.dep
