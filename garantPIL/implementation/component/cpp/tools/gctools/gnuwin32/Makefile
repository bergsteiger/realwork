PLATFORM=gnuwin32
include ../src/makefile.inc
libs = $(EXTRA_LIBS)
VPATH=../src
LDFLAGS+= -g -gdb
#CXXFLAGS+=  -Wno-non-virtual-dtor

.PHONY: clean

targets = libgc.a gc.exe mf2gardb.exe mfcheck.exe gl.exe gkcorr.exe

all: $(targets) 

gc.exe: $(gc_o) $(libs) 
	$(CC) -o $@ $(gc_o) $(LDFLAGS)

mf2gardb.exe: $(mf2gardb_o) $(libs)
	$(CC) -o $@ $(mf2gardb_o) $(LDFLAGS)

mfcheck.exe: $(mfcheck_o) $(libs)
	$(CC) -o $@ $(mfcheck_o) $(LDFLAGS)

gl.exe: $(gl_o) $(libs)
	$(CC) -o $@ $(gl_o) $(LDFLAGS)

gkcorr.exe: $(gkcorr_o) $(libs)
	$(CC) -o $@ $(gkcorr_o) $(LDFLAGS)

libgc.a: $(lib_o)
	rm -f $@
	$(AR) rcs $@ $(lib_o)

copy: $(targets)
	for i in $(targets); do \
		cp $$i $(PLACE); \
	done

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

#include ../src/makefile.dep
