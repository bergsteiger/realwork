PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\gc\src

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\include -I$(PROJECT)\include\win32

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS) libgkdb.lib libcchlp.lib libgsscreen.lib
LIB=$(PROJECT)\libs\gkdb\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\cchlp\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\gsscreen\$(PLATFORM);$(LIB)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
        dbproc.obj              \
        dbproc.mf.obj           \
        gclog.obj               \
        unixdummies.obj         \
$(SERVER_OBJS_0)

SERVER_OBJS=$(SERVER_OBJS_0)

LINK_FLAGS = $(LINK_FLAGS) /FIXED:NO

all: lib

lib:    $(SERVER_OBJS_0)
        $(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libgc.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb
        del gcini.cpp
        del classes.cpp
        del sources.cpp
        del belongs.cpp
        del complect.cpp
        del kwfile.cpp
        del publish.cpp
        del sttop.cpp
        del loadStringMap.cpp
        del blobtable.cpp
        del normfile.cpp

deleteall: clean
        del *.idl
        del *.hh

C_FLAGS = $(CC_FLAGS)
CPP_FLAGS = $(CC_FLAGS) /Tp

dbproc.obj: $(SUBPROJECT)\dbproc.cpp
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\dbproc.cpp
dbproc.mf.obj: $(SUBPROJECT)\dbproc.mf.cpp
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\dbproc.mf.cpp
gclog.obj: $(SUBPROJECT)\gclog.cpp
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\gclog.cpp
unixdummies.obj: $(SUBPROJECT)\unixdummies.cpp
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\unixdummies.cpp
