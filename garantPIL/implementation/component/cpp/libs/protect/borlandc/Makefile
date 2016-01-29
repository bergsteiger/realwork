PLATFORM=borlandc
CC = bcc
CXX = bcc
SHELL=sh
LIB=tlib
VPATH=../src


CFLAGS= -I../src\;../../profile/src\;../../../include -Ic:/bc45/include \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x- -V0

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=protect.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

protect.lib: $(objs) protect.crf
	-rm -f $@
	$(LIB) @protect.crf

protect.crf: Makefile ../src/makefile.inc
	echo protect.lib /C \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	protect.pdb

distclean: clean
	@-rm -f $(targets) protect.crf

