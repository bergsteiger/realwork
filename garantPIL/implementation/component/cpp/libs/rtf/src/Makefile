
include makefile.inc

makefile.dep: $(cxx_objs:.o=.cc)
	touch makefile.dep
	makedepend -Y. -fmakefile.dep $(cxx_objs:.o=.cpp)

depend: makefile.dep

clean:
distclean:

