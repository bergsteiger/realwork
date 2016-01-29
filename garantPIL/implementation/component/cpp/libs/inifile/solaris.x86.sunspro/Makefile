PLATFORM=solaris.x86.sunspro

include ../src/makefile.inc

DEFS= 
CXXFLAGS+=  $(CXXINCS) $(DEFS) $(OPTFLAGS)
CFLAGS+=$(DEFS)

VPATH=../src

.PHONY: clean

targets = libinifile.a

all: $(targets) 

libinifile.a: $(lib_o)
	-rm -f $@
	$(AR) rc $@ $(lib_o)
	$(RANLIB) $@

clean:
	-rm -f $(lib_o)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
