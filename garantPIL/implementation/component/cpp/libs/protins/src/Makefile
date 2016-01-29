
include makefile.inc

makefile.dep: $(cxx_objs:.o=.cpp) $(c_objs:.o=.c)
	touch makefile.dep
	makedepend -Y. -fmakefile.dep $(cxx_objs:.o=.cpp) $(c_objs:.o=.c)

depend: makefile.dep

clean:
distclean:
