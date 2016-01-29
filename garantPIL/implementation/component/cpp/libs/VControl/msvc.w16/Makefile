PLATFORM=win16
CC = cl
CXX = cl
SHELL=sh
LIB=lib
VPATH=../src/

CFLAGS+= /nologo /AL /J /I$(subst /,\\,$(VPATH)) /I"..\\..\\gkdb\\src" /D"_WINDOWS"

ifeq ($(DEBUG),1)
CFLAGS+= /f /G2 /Zp1 /W3 /Gf /Zi /Od /D"_DEBUG" /D"NO_CONSOLE" /Fd"VCONTROL.PDB"
else
CFLAGS+= /f- /G3 /Zp1 /W3 /Gf /O2 /Ox /Ob2 /OV1 /D"NO_CONSOLE" /D"NDEBUG"
endif

ifeq ($(DEMO),1)
CFLAGS+= /D"DEMO"
endif

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=VControl.lib

all: $(targets)	

include ../src/makefile.dep


VControl.lib: $(objs) VControl.crf
	@-rm -f $@
	$(LIB) /NOLOGO @VControl.crf

VControl.crf: Makefile ../src/makefile.inc
	@echo VControl.lib /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

clean:
	@-rm -f $(objs)	VControl.pdb

purge: clean
	@-rm -f $(targets) VControl.crf

