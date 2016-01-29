all: depend

THATS_MAKEDEPEND=1

include makefile.inc


depend: $(c_o:.o=.c) $(cc_o:.o=.cc)
	touch makefile.dep
	makedepend -Y $(DIRECT_INCLUDES) -fmakefile.dep $(c_o:.o=.c) $(cc_o:.o=.cc)


clean:
distclean: clean
	rm -f makefile.dep
