PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\tools\gopt\src

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\mrglib\src -I$(PROJECT)\include -I$(PROJECT)\include\win32

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS) libgkdb.lib libmrg.lib libcchlp.lib
LIB=$(PROJECT)\libs\gkdb\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\mrglib\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\cchlp\$(PLATFORM);$(LIB)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
        optmain.obj     \
        optndt.obj      \
        opttree.obj     \
        ready.obj       \
$(SERVER_OBJS_0)

GOPT_MAIN= main.obj

SERVER_OBJS=$(SERVER_OBJS_0)

C_FLAGS = $(CC_FLAGS)
CPP_FLAGS = $(CC_FLAGS) /Tp

all: server 

server: $(SERVER_OBJS) $(GOPT_MAIN)
        $(LINK) $(LINK_FLAGS) $(SERVER_OBJS) $(GOPT_MAIN) /OUT:gopt.exe $(LIBS)

lib:    $(SERVER_OBJS_0)
        $(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libgopt.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb

deleteall: clean
        del *.idl
        del *.hh


optmain.obj:
        $(CC) $(C_FLAGS) $(SUBPROJECT)\optmain.c
optndt.obj:
        $(CC) $(C_FLAGS) $(SUBPROJECT)\optndt.c
opttree.obj:
        $(CC) $(C_FLAGS) $(SUBPROJECT)\opttree.c
main.obj:
        $(CC) $(C_FLAGS) $(SUBPROJECT)\main.c
ready.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\ready.cc


