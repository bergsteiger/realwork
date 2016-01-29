PLATFORM:=none

.SUFFIXES:	.cc .o

include makefile.inc

all: depend 

depend: $(pack_cc_objs:.o=.cc)
	$(MKDEP) $(MKDEPFLAGS) $(DIRECT_INCLUDES) $(pack_cc_objs:.o=.cc) > makefile.dep

clean:
distclean:

