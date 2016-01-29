PLATFORM=solaris.x86.sunspro
include ../../../platforms/$(PLATFORM).inc
include ../src/makefile.inc

objs += dummies.o

targets = libgkdb.a libosdep.a

VPATH=../src

all: $(targets)

libgkdb.a: $(objs)
	-rm -f $@
	$(AR) rc $@ $(objs)
	$(RANLIB) $@

libosdep.a: $(osdep_objs)
	-rm -f $@
	$(AR) rc $@ $(osdep_objs)
	$(RANLIB) $@

clean:
	-rm -f $(objs) $(osdep_objs)

distclean: clean
	-rm -f $(targets)

#include ../src/makefile.dep
