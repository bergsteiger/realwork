PLATFORM=borlandc
CC = bcc
CXX = bcc
SHELL=sh
LIB=tlib
VPATH=../src

include ../src/makefile.inc

CFLAGS= -I../src\;../../../include\;../../../libs/gkdb/src\;../../../libs/basemask/src \
	-ml -R -v -vi -i32 -K -d -WXDE \
 	-y -3 -f- -Ff -Od -Oi -x- -V0 -P

CXXFLAGS = $(CFLAGS)

ifeq ($(CC),bcc)
.cc.o:
	echo -c > src.rsp
	echo $(CFLAGS) >> src.rsp
	echo $< >> src.rsp
	$(CXX) @src.rsp 
	mv $@bj $@
	rm src.rsp
endif

targets=dhreader.lib

all: $(targets)	

include ../src/makefile.dep

# .SILENT:

dhreader.lib: $(dhr_o) dhreader.crf
	-rm -f $@
	$(LIB) @dhreader.crf

dhreader.crf: Makefile ../src/makefile.inc
	echo dhreader.lib /C \& > $@
	for o in $(dhr_o) ; do \
		echo + $$o \&>> $@ ; \
	done
	echo ,nul >> $@

clean:
	@-rm -f $(dhr_o) dhreader.pdb

distclean: clean
	@-rm -f $(targets) dhreader.crf

