PLATFORM=borlandc
CC = bcc
CXX = bcc
SHELL=sh
LIB=tlib
VPATH=../src


CFLAGS= -I$(VPATH) -DNEED_CADDR_T \
	 -ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x-

CXXFLAGS = $(CFLAGS)

include ../src/makefile.inc

targets=gkdb.lib osdep.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

gkdb.lib: $(objs) gkdb.crf
	-rm -f $@
	$(LIB) @gkdb.crf

osdep.lib: $(osdep_objs) osdep.crf
	-rm -f $@
	$(LIB) @osdep.crf

gkdb.crf: Makefile ../src/makefile.inc
	echo gkdb.lib /C /v \& > $@
	for o in $(objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

osdep.crf: Makefile ../src/makefile.inc
	echo osdep.lib /C /v \& > $@
	for o in $(osdep_objs) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(objs)	$(osdep_objs) gkdb.pdb

purge: clean
	@-rm -f $(targets) gkdb.crf

