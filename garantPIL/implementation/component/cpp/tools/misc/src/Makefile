PLATFORM:=none

all: depend

include makefile.inc


depend: $(c_o:.o=.c) $(cc_o:.o=.cc)
	touch makefile.dep
	$(MKDEP) $(MKDEPFLAGS) $(DIRECT_INCLUDES) $(c_o:.o=.c) $(cc_o:.o=.cc) > makefile.dep


clean:
distclean: clean
	rm -f makefile.dep
