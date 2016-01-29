DIRECT_INCLUDES+=-I../../gkdb/src -I../../inifile/src -I../../../include

ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
endif

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris))
	CFLAGS+=-fno-for-scope -funsigned-char
	CXXFLAGS+=-fno-for-scope -funsigned-char
endif

CXXFLAGS+= $(DIRECT_INCLUDES)

EXTRA_LIBS = ../../gkdb/$(PLATFORM)/libgkdb.a ../../inifile/$(PLATFORM)/libinifile.a

.SUFFIXES:  .c .cpp .o .a

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 solaris solaris.x86.sunspro))
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


cxx_objs=reflist.o
#($findstring($(PLATFORM),msvc.w16 win16),$(PLATFORM))
ifeq ($(PLATFORM), win16)
cxx_objs+=filters.o
else
cxx_objs+=filters.o
endif

c_objs =
objs=$(c_objs) $(cxx_objs)
