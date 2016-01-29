
include ../../platforms/host.inc
include ../../platforms/cross.inc

.PHONY: clean distclean freebsd linux go32 cygwin32 solaris
.IGNORE: clean distclean

all: native

native: $(NATIVE_HOST)

export: native $(AVAILABLE_CROSS)

freebsd linux go32 cygwin32:
	cd $@; $(MAKE)

solaris:
	cd $@.x86; $(MAKE)

clean:
	cd freebsd; $(MAKE) $@
	cd linux; $(MAKE) $@
	cd go32; $(MAKE) $@
	cd cygwin32; $(MAKE) $@
	cd solaris.x86; $(MAKE) $@

distclean:
	cd freebsd; $(MAKE) $@
	cd linux; $(MAKE) $@
	cd go32; $(MAKE) $@
	cd cygwin32; $(MAKE) $@
	cd solaris.x86; $(MAKE) $@

