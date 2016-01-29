PLATFORM=borlandc
CC=bcc
CXX=bcc
ASM=tasm
SHELL=sh
LIB=tlib
VPATH=../src


CFLAGS= -I../src -DNEED_CADDR_T \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x- -V

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=protins.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

protins.lib: $(objs) protins.crf
	-rm -f $@
	$(LIB) @protins.crf

protins.crf: Makefile ../src/makefile.inc
	echo protins.lib /c /C \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo + ..\\src\\hasp3lnk.obj \& >> $@
	echo + ..\\src\\hasptc.obj \& >> $@
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	protins.pdb

distclean: clean
	@-rm -f $(targets) protins.crf

