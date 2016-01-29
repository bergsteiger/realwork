PLATFORM=msvc.w16
CC = cl
CXX = cl
SHELL=sh
LIB=lib
VPATH=../src/

CFLAGS+= /nologo /AL /J /I$(subst /,\\,$(VPATH)) /D"_WINDOWS"

ifeq ($(DEBUG),1)
CFLAGS+= /f /G2 /Zp1 /W3 /Gf /Zi /Od /D"_DEBUG" /Fd"GKDB.PDB"
else
CFLAGS+= /f- /G3 /Zp1 /W3 /Gf /O2 /Ox /Ob2 /OV1 /D"NDEBUG"
endif

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=mrg.lib util.lib

all: $(targets)	

include ../src/makefile.dep


mrg.lib: $(mrglib_o) mrg.crf
	@-rm -f $@
	$(LIB) /NOLOGO @mrg.crf

mrg.crf: Makefile ../src/makefile.inc
	@echo mrg.lib /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(mrglib_o) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

util.lib: $(util_o) util.crf
	@-rm -f $@
	$(LIB) /NOLOGO @util.crf

util.crf: Makefile ../src/makefile.inc
	@echo util.lib /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(util_o) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

clean:
	@-rm -f $(all_o)	mrg.pdb util.pdb

distclean: purge

purge: clean
	@-rm -f $(targets) mrg.crf util.crf

