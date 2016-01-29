NATIVE:=
include ../../Mk/host.mk

.PHONY: all go32 msvc32 cygwin32 linux freebsd solaris

all: $(NATIVE)

go32 msvc32 cygwin32 linux freebsd solaris:
	$(MAKE) -C $(TARGET_PLATFORM_DIR)

