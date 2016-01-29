PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\gctx\src

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\include\win32 -I$(PROJECT)\include

!include "make.inc"

LIB_MAKER=lib

SERVER_OBJS_0= 
SERVER_OBJS_0= \
	ctxwords.obj				\
	u_int64_t.CtxLongSet.Map.obj		\
	u_int64_t.CtxLongSet.SplayMap.obj	\
$(SERVER_OBJS_0)

SERVER_OBJS=$(SERVER_OBJS_0)

C_FLAGS = $(CC_FLAGS)
CPP_FLAGS = $(CC_FLAGS) /Tp

all: lib

lib: 	$(SERVER_OBJS_0)
	$(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libgctx.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb

deleteall: clean
	del *.idl
        del *.hh



ctxwords.obj:
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\ctxwords.cpp
u_int64_t.CtxLongSet.Map.obj:
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.CtxLongSet.Map.cpp
u_int64_t.CtxLongSet.SplayMap.obj:
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.CtxLongSet.SplayMap.cpp
unixdummies.obj:
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\unixdummies.cpp
gctx.obj:
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\gctx.cc
