PLATFORM=none
.SUFFIXES:	.c .flex .o

include makefile.inc

all: depend 

depend: $(gm_objs:.o=.c) $(gm_cc_objs:.o=.cc)
	$(MKDEP) $(MKDEPFLAGS) $(DIRECT_INCLUDES) $(gm_objs:.o=.c) $(gm_cc_objs:.o=.cc) > makefile.dep

clean:
distclean:

test: 
	for f in $(gklib_objs:.o=.c) ; do \
		mv $$f ../../../libs/mrglib/src ; \
	done
