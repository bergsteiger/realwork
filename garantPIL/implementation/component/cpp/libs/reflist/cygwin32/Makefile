PLATFORM=cygwin32

include ../src/makefile.inc

#DEFS= -I../src
#CXXFLAGS+= $(DEFS) -Wimplicit -O3 -g -Dunix
#CFLAGS+=  $(DEFS) -Wimplicit -O3 -g -Dunix

targets = libreflist.a

VPATH=../src

all: $(targets)

libreflist.a: $(objs)
	-rm -f $@
	$(AR) rcs $@ $(objs)

clean:
	-rm -f $(objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
