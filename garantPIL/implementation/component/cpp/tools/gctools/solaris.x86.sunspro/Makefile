PLATFORM=solaris.x86.sunspro

include ../src/makefile.inc

libs = libgc.a $(EXTRA_LIBS)

LDFLAGS+=-lCrun

VPATH=../src


.PHONY: clean

targets = gc mf2gardb mfcheck gl gkcorr

all: $(targets) 

gc: $(gc_o) $(libs)
	$(CC) -o $@ $(gc_o) $(LDFLAGS)

mf2gardb: $(mf2gardb_o) $(libs)
	$(CC) -o $@ $(mf2gardb_o) $(LDFLAGS)

mfcheck: $(mfcheck_o) $(libs)
	$(CC) -o $@ $(mfcheck_o) $(LDFLAGS)

gkcorr: $(gkcorr_o) $(libs)
	$(CC) -o $@ $(gkcorr_o) $(LDFLAGS)

gl: $(gl_o) $(libs)
	$(CC) -o $@ $(gl_o) $(LDFLAGS) -lgsscreen


libgc.a: $(lib_o)
	rm -f $@
	$(AR) rc $@ $(lib_o)
	$(RANLIB) $@

copy: $(targets)
	for i in $(targets); do \
		cp $$i $(PLACE); \
	done

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

#include ../src/makefile.dep

sources.cc: ../src/sources.flex
	flex -o$@ $<

blobtable.cc: ../src/blobtable.flex
	flex -o$@ $<

loadStringMap.cc: ../src/loadStringMap.flex
	flex -o$@ $<

classes.cc: ../src/classes.flex
	flex -o$@ $<

sttop.cc: ../src/sttop.flex
	flex -o$@ $<

kwfile.cc: ../src/kwfile.flex
	flex -o$@ $<

gcini.cc: ../src/gcini.flex
	flex -o$@ $<

belongs.cc: ../src/belongs.flex
	flex -o$@ $<

complect.cc: ../src/complect.flex
	flex -o$@ $<

normfile.cc: ../src/normfile.flex
	flex -o$@ $<
