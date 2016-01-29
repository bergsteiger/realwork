PLATFORM=gnuwin32
DEFS+= -I../src
VPATH=../src

include ../src/makefile.inc

targets = libgkdb.a libosdep.a

all: $(targets)

libgkdb.a: $(objs)
	-rm -f $@
	$(AR) rcs $@ $(objs)

libosdep.a:
	-rm -f $@
	$(AR) rcs $@ $(osdep_objs)

clean:
	-rm -f $(objs) $(osdep_objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
