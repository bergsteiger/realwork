PLATFORM?=none

include makefile.inc

depend:  makefile.dep

makefile.dep: $(all_o:.o=.c) $(cc_o:.o=.cc)
	touch makefile.dep
	makedepend -Y. -fmakefile.dep $(all_o:.o=.c)
#	$(MKDEP) $(MKDEP_CPP_OPTS) $(c_o:.o=.c) $(cc_o:.o=.cc) > makefile.dep


clean:

distclean: clean

