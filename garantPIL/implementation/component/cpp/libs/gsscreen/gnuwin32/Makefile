PLATFORM=gnuwin32

include ../src/makefile.inc

OPTFLAGS:=$(shell test -f .optflags && grep -v \\\# .optflags  )
CFLAGS+= $(DEFS) $(OPTFLAGS) -D__CYGWIN32__
CXXFLAGS+=  $(CXXINCS) $(DEFS) -pipe $(OPTFLAGS) -D__CYGWIN32__

VPATH=../src

.PHONY: clean

targets = libgsscreen.a

all: $(targets) 

libgsscreen.a: $(lib_o)
	-rm -f $@
	$(AR) rcs $@ $(lib_o)

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.rules
include ../src/makefile.dep
