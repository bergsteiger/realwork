DIRECT_INCLUDES+= -I../../../include -I../../../libs/gsscreen/src -I../../../libs/cchlp/src -I../../../libs/GPersn/src -I../../../include/$(PLATFORM)

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


cxx_objs=garutils.o  collect.o newdoc.o \
	base.o  document.o doccol.o dociter.o \
	pagefile.o index.o hindex.o indices.o \
	refcol.o privbase.o \
	streams.o btree.o btiter.o \
	basemask.o docblock.o \
	ncpf.o stdbase.o store.o rev.o fltiter.o

c_objs = unzip.o inflate.o deflate.o infblock.o \
	zutil.o infutil.o infcodes.o inftrees.o \
	inffast.o adler32.o trees.o pack.o \
	crc32.o pl_crypt.o

osdep_objs = osdummy.o

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	cxx_objs+=dummies.o
endif

objs = $(c_objs) $(cxx_objs)
