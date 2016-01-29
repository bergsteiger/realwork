DO_MT=
CC=gcc
CXX=gcc
AR=/usr/bin/ar
INCS = -I/usr/local/lib/g++-include -I../../gkdb/src
DEFS = -DHAS_INT_TYPES -DO_BINARY=0
WARNS = -Wimplicit 
FLOWS = -fno-for-scope -funsigned-char


OPTFLAGS=$(shell test -f .optflags && grep -v \\\# .optflags  )
CXXFLAGS= $(INCS) $(DEFS) $(FLOWS) $(WARNS) -g -ggdb $(OPTFLAGS)
CFLAGS= $(DEFS) $(FLOWS) $(WARNS) -g -ggdb $(OPTFLAGS)

include ../src/makefile.inc

targets = librtf.a

VPATH=../src

all: $(targets)

librtf.a: $(objs)
	-rm -f $@
	$(AR) rcs $@ $(objs)

clean:
	-rm -f $(objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep

