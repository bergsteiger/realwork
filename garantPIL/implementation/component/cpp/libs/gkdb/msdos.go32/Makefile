PLATFORM=msdos.go32
CC=gcc
CXX=$(CC)

AR=ar
INCS = -I/usr/lang/cxx 
CXXFLAGS= $(INCS) -Wimplicit -O3 -g -DNEED_CADDR_T
CFLAGS= $(INCS) -Wimplicit -O3 -g

targets = libgkdb.a

VPATH=../src

include ../src/makefile.inc

objs += dummies.o

all: $(targets)

libgkdb.a: $(objs)
	-rm -f $@
	$(AR) rcs $@ $(objs)


clean:
	-rm -f $(objs)

distclean: clean
	-rm -f $(targets)


include ../src/makefile.dep
