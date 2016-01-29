PLATFORM=solaris
include ../../../platforms/$(PLATFORM).inc
include ../src/makefile.inc

CXXFLAGS += -fno-for-scope
CFLAGS += -fno-for-scope

targets = libreflist.a

VPATH=../src

all: $(targets)

libreflist.a: $(objs)
	-rm -f $@
	$(AR) rc $@ $(objs)
	$(RANLIB) $@

clean:
	-rm -f $(objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
