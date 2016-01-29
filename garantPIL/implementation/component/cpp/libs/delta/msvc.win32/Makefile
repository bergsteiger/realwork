PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\delta\src

DEBUG=NO

MYCFLAGS = \
	-I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gkdb\src \
	-I$(PROJECT)\libs\inifile\src -I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\libs\gctx\src \
	-I$(PROJECT)\include\win32 -I$(PROJECT)\include -DCODETYPE_DOS

!include "make.inc"

LIB_MAKER=lib

LIB_OBJS= adds.obj wordcol.obj elems.obj hendlers.obj tempdoc.obj dhreader.obj

SERVER_OBJS=$(LIB_OBJS)

all: lib

lib: $(LIB_OBJS)
	$(LIB_MAKER) $(LIB_OBJS) /OUT:libdelta.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb

deleteall: clean
	del *.idl
        del *.hh

dhreader.obj: $(SUBPROJECT)\dhreader.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\dhreader.cpp
adds.obj: $(SUBPROJECT)\adds.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\adds.cpp
wordcol.obj: $(SUBPROJECT)\wordcol.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\wordcol.cpp
elems.obj: $(SUBPROJECT)\elems.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\elems.cpp
hendlers.obj: $(SUBPROJECT)\hendlers.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\hendlers.cpp
tempdoc.obj: $(SUBPROJECT)\tempdoc.cpp
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\tempdoc.cpp
