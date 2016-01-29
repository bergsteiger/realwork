
include makefile.inc

MKDEPEND=$(shell test -x ../../../mkdepend/mkdepend && echo ../../../mkdepend/mkdepend)

ifeq ($(MKDEPEND),)
MKDEPEND=makedepend
endif

depend:  makefile.dep

makefile.dep: $(c_o:.o=.c) $(cc_o:.o=.cc)
	touch makefile.dep
	$(MKDEPEND) -Y. -fmakefile.dep $(c_o:.o=.c) $(cc_o:.o=.cc)


clean:

distclean: clean

