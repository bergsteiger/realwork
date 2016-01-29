ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	CFLAGS+=-fno-for-scope -funsigned-char
	CXXFLAGS+=-fno-for-scope -funsigned-char
endif

.SUFFIXES:  .c .o .a .cpp .asm

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
	$(CXX) -c $(CXXFLAGS) $< 
	mv $@bj $@
.c.o:
	$(CC) -c $(CFLAGS) $< 
	mv $@bj $@
.asm.o:
	$(ASM) $(ASMFLAGS) $(subst /,\\,$<)
	mv $@bj $@
endif

asm_objs=

c_objs=checklab.o common.o dellab.o getcode.o labels.o pfunc.o qcrc.o hasp.o

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32))
	cxx_objs+=dummies.o
endif

ifneq (,$(findstring $(PLATFORM),win16))
cxx_objs+= reflist.o
endif

objs = $(c_objs) $(cxx_objs) $(asm_objs)
