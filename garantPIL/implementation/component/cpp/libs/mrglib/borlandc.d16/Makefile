PLATFORM=borlandc.d16
CC=bcc
CXX=bcc
ASM=tasm
SHELL=sh
LIB=tlib
VPATH=../src
ASMFLAGS = /ml

CFLAGS= -I../src\;../../gkdb/src\;../../resfile/src \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x-

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=mrg.lib util.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

mrg.lib: $(mrglib_o) mrg.crf
	-rm -f $@
	$(LIB) @mrg.crf

mrg.crf: Makefile ../src/makefile.inc
	echo mrg.lib /C \& > $@
	for o in $(mrglib_o) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

util.lib: $(util_o) util.crf
	-rm -f $@
	$(LIB) @util.crf

util.crf: Makefile ../src/makefile.inc
	echo util.lib /C \& > $@
	for o in $(util_o) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(all_o)	mrg.pdb mrg.crf util.pdb util.crf

distclean: clean
	@-rm -f $(targets)

