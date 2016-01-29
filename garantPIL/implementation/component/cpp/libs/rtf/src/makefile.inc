ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	CFLAGS+=-fno-for-scope -funsigned-char
	CXXFLAGS+=-fno-for-scope -funsigned-char
endif

.SUFFIXES:  .c .o .a .cc .cpp

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<
endif

ifeq ($(CC),cl)
.cpp.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

.cc.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

.c.o:
	$(CC) -c $(CFLAGS) $(subst /,\\,$<) 
	-mv -f $@bj $@

endif
ifeq ($(CC),gcc)
.cc.o:
	$(CXX) -c $(CXXFLAGS) $<

endif

ifeq ($(CC),bcc)
.cc.o:
	$(CXX) -c $(CXXFLAGS) $< 
	mv $@bj $@
.c.o:
	$(CC) -c $(CFLAGS) $< 
	mv $@bj $@
endif

cxx_objs=rtfwrite.o rtffile.o rtfgar.o

objs = $(cxx_objs)
