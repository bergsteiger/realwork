PLATFORM=borlandc.d16
CC=bcc
CXX=bcc
ASM=tasm
SHELL=sh
LIB=tlib
VPATH=../src
ASMFLAGS = /ml /zi

CFLAGS= -I../src\;../../gkdb/src\;../../../include\;../../screen/src\;../../resfile/src\;../../profile/src\;../../baseinfo/src\;../../instutil/src\;../../../shells/shell.dos/src\;../../folders/src \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x-

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=reflist.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

reflist.lib: $(objs) reflist.crf
	-rm -f $@
	$(LIB) @reflist.crf

reflist.crf: Makefile ../src/makefile.inc
	echo reflist.lib /C \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	reflist.pdb

distclean: clean
	@-rm -f $(targets) reflist.crf

