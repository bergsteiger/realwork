DIRECT_INCLUDES+= -I../../../include -I../../../include/$(PLATFORM) -I../include

ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
endif

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris gnuwin32))
	CFLAGS+=-fno-for-scope -funsigned-char
	CXXFLAGS+=-fno-for-scope -funsigned-char
endif

CXXFLAGS+= $(DIRECT_INCLUDES)
CFLAGS+= $(DIRECT_INCLUDES)

EXTRA_LIBS = ../../basemask/$(PLATFORM)/libbasemask.a

.SUFFIXES:  .c .cpp .o .a 

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris solaris.x86.sunspro gnuwin32))
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<
endif

ifeq ($(CC),cl)
.cpp.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

.c.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

endif
#ifeq ($(CC),gcc)
#.cpp.o:
#	$(CXX) -c $(CXXFLAGS) $<
#endif

ifeq ($(CC),bcc)
.cpp.o:
	@echo "-c $(CFLAGS) $<" > flags.bcc
	@$(CXX) @flags.bcc
	mv $@bj $@
.c.o:
	@echo "-c $(CFLAGS) $<" > flags.bcc
	@$(CXX) @flags.bcc
	mv $@bj $@
endif

cxx_objs   = lex_parser.o  lex_basis.o lex_operator.o

c_objs     =

osdep_objs =

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	cxx_objs+=dummies.o
endif

objs = $(c_objs) $(cxx_objs)
