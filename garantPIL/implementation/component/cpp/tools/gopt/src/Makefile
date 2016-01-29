PLATFORM:=none

include makefile.inc

depend: $(c_objs:.o=.c) $(cxx_objs:.o=.cc)
	$(MKDEP) $(MKDEPFLAGS) $(DIRECT_INCLUDES) $(c_objs:.o=.c) $(cxx_objs:.o=.cc) > makefile.dep


clean:
distclean:
