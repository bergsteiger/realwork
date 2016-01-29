PLATFORM:=freebsd

# for gdm_serv
# DEFS=__x86__  __OSVERSION__=5 _NO_DOS_SCREEN _USE_CORBA_CONVERTS __USE_HOARD__
# SYSLIBS=omniORB3 omnithread omniGK_stub omniDynamic3

# for gdm
DEFS=__x86__  __OSVERSION__=5 _NO_DOS_SCREEN __USE_HOARD__ VERSION56

include ../src/common.mk
LDFLAGS_LIBS+=-lstdc++ -lm
LDFLAGS += -L/usr/local/lib/
LDFLAGS += -pthread
