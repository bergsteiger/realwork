
include makefile.inc

makefile.dep: $(c_objs:.o=.c)
	touch makefile.dep
	makedepend -Y. -fmakefile.dep $(c_objs:.o=.c)

depend: makefile.dep

clean:
distclean:

