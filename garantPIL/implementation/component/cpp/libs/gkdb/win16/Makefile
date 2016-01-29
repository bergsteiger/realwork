PLATFORM=win16
CC = cl
CXX = cl
SHELL=sh
LIB=lib
VPATH=../src/

CFLAGS+= /nologo /AL /J /I$(subst /,\\,$(VPATH)) /I"..\\..\\basemask\\src" /D"IGNOREKEYCASE" /D"_WINDOWS" /D"WWWIMAGES"

ifeq ($(DEBUG),1)
CFLAGS+= /f /G2 /Zp1 /W3 /Gf /Zi /Od /D"_DEBUG" /Fd"GKDB.PDB"
else
CFLAGS+= /f- /G3 /Zp1 /W3 /Gf /O2 /Ox /Ob2 /OV1  /D"NDEBUG"
endif

ifeq ($(DEMO),1)
CFLAGS+= /D"DEMO"
endif

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=gkdb.lib osdep.lib

all: $(targets)	

include ../src/makefile.dep


gkdb.lib: $(objs) gkdb.crf
	@-rm -f $@
	$(LIB) /NOLOGO @gkdb.crf

osdep.lib: $(osdep_objs) osdep.crf
	@-rm -f $@
	$(LIB) /NOLOGO @osdep.crf

gkdb.crf: Makefile ../src/makefile.inc
	@echo gkdb.lib /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

osdep.crf: Makefile ../src/makefile.inc
	@echo osdep.lib /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(osdep_objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

clean:
	@-rm -f $(objs)	$(osdep_objs) gkdb.pdb

purge: clean
	@-rm -f $(targets) gkdb.crf

