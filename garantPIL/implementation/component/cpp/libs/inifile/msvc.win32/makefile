PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\inifile\src
BLDPROJECT=$(PROJECT)\libs\inifile\msvc.win32

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\include -I$(PROJECT)\include\win32

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
        inifile.obj     \
$(SERVER_OBJS_0)

SERVER_MAIN=

SERVER_OBJS=$(SERVER_OBJS_0) $(SERVER_MAIN)

all: lib

lib:    $(SERVER_OBJS_0)
        $(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libinif.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb
        del *.ih
        del *.ic

deleteall: clean
        del *.idl
        del *.hh


inifile.obj:
        $(CC) $(CC_FLAGS) $(SUBPROJECT)\inifile.cpp
