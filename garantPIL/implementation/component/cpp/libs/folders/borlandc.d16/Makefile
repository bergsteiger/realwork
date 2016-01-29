PLATFORM=borlandc.d16
CC=bcc
CXX=bcc
ASM=tasm
SHELL=sh
LIB=tlib
VPATH=../src
ASMFLAGS = /ml /zi

CFLAGS= -I../src\;../../gkdb/src\;../../reflist/src\;../../instutil/src\;../../../include \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x-

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=folders.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

folders.lib: $(objs) folders.crf
	-rm -f $@
	$(LIB) @folders.crf

folders.crf: Makefile ../src/makefile.inc
	echo folders.lib /C \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	folders.pdb

distclean: clean
	@-rm -f $(targets) folders.crf

