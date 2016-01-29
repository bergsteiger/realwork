PLATFORM=borlandc
CC = bcc
CXX = bcc
SHELL=sh
LIB=tlib
VPATH=../src


CFLAGS= -I$(VPATH) -IC:/bc45/include -I../../../include\;../../../include/borlandc \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -V0

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=inifile.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

inifile.lib: $(objs) inifile.crf
	-rm -f $@
	$(LIB) @inifile.crf

inifile.crf: Makefile ../src/makefile.inc
	echo inifile.lib /C \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	inifile.pdb

purge: clean
	@-rm -f $(targets) inifile.crf

