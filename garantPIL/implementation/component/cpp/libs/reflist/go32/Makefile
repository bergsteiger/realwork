PLATFORM=go32

ifneq ($(shell echo lala),lala)
first:
	@echo You have very strange make or shell.
	@echo Type \"(g)make all\" to continue anyway
endif

include ../src/makefile.inc
CFLAGS+=-nostdincs

targets = libreflist.a

VPATH=../src

all: $(targets)

libreflist.a: $(objs)
	-rm -f $@
	$(AR) rcs $@ $(objs)

clean:
	-rm -f $(objs)

distclean: clean
	-rm -f $(targets)

include ../src/makefile.dep
