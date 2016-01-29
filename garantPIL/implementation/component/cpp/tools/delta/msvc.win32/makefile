PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\tools\delta\src

DEBUG=NO

MYCFLAGS = \
	-I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gkdb\src \
	-I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\libs\inifile\src \
	-I$(PROJECT)\libs\delta\src -I$(PROJECT)\libs\gctx\src -I$(PROJECT)\include\win32 \
	-I$(PROJECT)\include -DCODETYPE_DOS

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS) libgkdb.lib libcchlp.lib libinif.lib libgsscreen.lib libgctx.lib libdelta.lib
LIB=$(PROJECT)\libs\gkdb\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\cchlp\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\inifile\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\gsscreen\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\gctx\$(PLATFORM);$(LIB)
LIB=$(PROJECT)\libs\delta\$(PLATFORM);$(LIB)

GGU_OBJS = update.obj unfull.obj clcache.obj cntxtcol.obj
GGDLT_OBJS = fulldiff.obj diffhldr.obj delta.obj
GGREV_OBJS = reviser.obj setrev.obj

all: server 

server: $(GGU_OBJS) $(GGDLT_OBJS) $(GGREV_OBJS)
	$(LINK) $(LINK_FLAGS) $(GGU_OBJS) /OUT:guw32.exe $(LIBS)
	$(LINK) $(LINK_FLAGS) $(GGREV_OBJS) /OUT:ggrev.exe $(LIBS)
	$(LINK) $(LINK_FLAGS) $(GGDLT_OBJS) /OUT:ggdlt.exe $(LIBS)


clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb

deleteall: clean
	del *.idl
        del *.hh

C_FLAGS = $(CC_FLAGS)
CPP_FLAGS = $(CC_FLAGS) /Tp

unfull.obj: $(SUBPROJECT)\unfull.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\unfull.cpp
update.obj: $(SUBPROJECT)\update.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\update.cpp
clcache.obj: $(SUBPROJECT)\clcache.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\clcache.cpp
delta.obj: $(SUBPROJECT)\delta.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\delta.cpp
fulldiff.obj: $(SUBPROJECT)\fulldiff.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\fulldiff.cpp
diffhldr.obj: $(SUBPROJECT)\diffhldr.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\diffhldr.cpp
reviser.obj: $(SUBPROJECT)\reviser.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\reviser.cpp
setrev.obj: $(SUBPROJECT)\setrev.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\setrev.cpp
cntxtcol.obj: $(SUBPROJECT)\cntxtcol.cpp
	$(CC) $(CPP_FLAGS) $(SUBPROJECT)\cntxtcol.cpp
