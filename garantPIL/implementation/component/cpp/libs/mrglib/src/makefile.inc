DIRECT_INCLUDES=-I../../gkdb/src -I../../../include

ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
DIRECT_INCLUDES+=-I../../../include/$(PLATFORM)
endif

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris))
	CFLAGS+=-fno-for-scope -funsigned-char $(DIRECT_INCLUDES)
	CXXFLAGS+=-fno-for-scope -funsigned-char $(DIRECT_INCLUDES)
	CFLAGS+=-Wall -funsigned-char -I../../gkdb/src
endif

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris))
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<
endif

ifeq ($(CC),cl)
DIRECT_INCLUDES=$(patsubst -I,/I,$(DIRECT_INCLUDES))
CFLAGS+=$(DIRECT_INCLUDES)
CXXFLAGS+=$(DIRECT_INCLUDES)

.cpp.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

.c.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

endif

ifeq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris))
ifeq ($(CC),gcc)

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<

endif
endif

ifeq ($(CC),bcc)
.cpp.o:
	$(CXX) -c $(CFLAGS) $< 
	mv $@bj $@
.c.o:
	$(CC) -c $(CFLAGS) $< 
	mv $@bj $@
.asm.o:
	$(ASM) $(ASMFLAGS) $(subst /,\\,$<)
	mv $@bj $@
endif

.SUFFIXES:  .c .o .a .cpp .asm


mrglib_o = bfind.o btree_.o cmpfunc.o flog.o gbase.o gberr.o \
				globals.o index_.o iter.o keyfile.o pgfile.o sets.o \
				ssets.o streams_.o strcache.o mlhooks.o

util_o = flog.o unifname.o profile.o

all_o = $(mrglib_o) $(util_o)

objs = $(mrglib_o) $(util_o)

