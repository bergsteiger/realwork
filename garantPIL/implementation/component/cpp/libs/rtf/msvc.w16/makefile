PLATFORM=win16
CC = cl
CXX = cl
SHELL=sh
LIB=lib
VPATH=../src/

CFLAGS+= /nologo /AL /J /I$(subst /,\\,$(VPATH)) /I"..\\..\\gkdb\\src" /I"..\\..\\..\\include" /I"..\\..\\..\\include\\win16" /D"_WINDOWS"

ifeq ($(DEBUG),1)
CFLAGS+= /f /G2 /Zp1 /W3 /Gf /Zi /Od /D"_DEBUG" /Fd"librtf.PDB"
else
CFLAGS+= /f- /G3 /Zp1 /W3 /Gf /O2 /Ox /Ob2 /OV1 /D"NDEBUG"
endif

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=librtf.lib

all: $(targets)	

include ../src/makefile.dep


$(targets): $(objs) librtf.crf
	@-rm -f $@
	$(LIB) /NOLOGO @librtf.crf

librtf.crf: Makefile ../src/makefile.inc
	@echo $(targets) /PAGESIZE:64 > $@
	@echo y >> $@ 
	@for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	@echo "" >> $@
	@echo NUL >> $@
	@echo NUL >> $@

clean:
	@-rm -f $(objs)	librtf.pdb

purge: clean
	@-rm -f $(targets) librtf.crf

