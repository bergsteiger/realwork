PLATFORM:=none

include makefile.inc

depend: $(hs_c_objs:.o=.c) $(hs_cc_objs:.o=.cc)
	$(MKDEP) $(MKDEPFLAGS) $(DIRECT_INCLUDES) $(hs_c_objs:.o=.c) $(hs_cc_objs:.o=.cc) > makefile.dep


clean:
distclean:
# DO NOT DELETE
