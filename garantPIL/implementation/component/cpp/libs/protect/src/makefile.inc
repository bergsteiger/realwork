ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	CFLAGS+=-fno-for-scope -funsigned-char
	CXXFLAGS+=-fno-for-scope -funsigned-char
endif

.SUFFIXES:  .c .o .a .cpp

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
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
ifeq ($(CC),gcc)
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<

endif

ifeq ($(CC),bcc)
.cpp.o:
	echo $(CFLAGS) > $(patsubst %.cpp,%.bcc,$<)
	$(CC) -c +$(patsubst %.cpp,%.bcc,$<) $(subst /,\\,$<) 
	-rm $(patsubst %.cpp,%.bcc,$<)
	-mv -f $@bj $@
.c.o:
	echo $(CFLAGS) > $(patsubst %.c,%.bcc,$<)
	$(CC) -c +$(patsubst %.c,%.bcc,$<) $(subst /,\\,$<) 
	-rm $(patsubst %.c,%.bcc,$<)
	-mv -f $@bj $@
endif

c_objs = prot401.o mediate.o

objs = $(c_objs)
