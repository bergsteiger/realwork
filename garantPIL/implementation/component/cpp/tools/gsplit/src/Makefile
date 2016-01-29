PLATFORM:=none

.SUFFIXES:	.c .flex .o

include makefile.inc


all: segfile.c depend 


depend: $(gsb_objs:.o=.c) $(gsb_cc_objs:.o=.cc)
	$(MKDEP) $(MKDEP_FLAGS) $(DIRECT_INCLUDES) $(gsb_objs:.o=.c) $(gsb_cc_objs:.o=.cc) > makefile.dep

.flex.c:
	flex -f -o$@ $^

clean:
distclean:
