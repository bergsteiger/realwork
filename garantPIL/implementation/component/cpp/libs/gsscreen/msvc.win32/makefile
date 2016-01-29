PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\gsscreen\src
BLDPROJECT=$(PROJECT)\libs\gsscreen\msvc.win32

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gl\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\include\win32 -I$(PROJECT)\include

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
	face.obj	\
	screen.obj	\
	pscreen.obj	\
	gsscreen.obj	\
$(SERVER_OBJS_0)

SERVER_MAIN=

SERVER_OBJS=$(SERVER_OBJS_0) $(SERVER_MAIN)

all: lib

lib: 	$(SERVER_OBJS_0)
	$(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libgsscreen.lib

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


face.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\face.c
screen.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\screen.c
pscreen.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\pscreen.cpp
gsscreen.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\gsscreen.cpp
