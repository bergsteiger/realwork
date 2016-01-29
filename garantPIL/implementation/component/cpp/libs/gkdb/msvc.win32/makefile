PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\gkdb\src
BLDPROJECT=$(PROJECT)\libs\gkdb\msvc.win32

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gsscreen\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\include -I$(PROJECT)\include\win32

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
	garutils.obj	\
	dummies.obj	\
	collect.obj	\
	newdoc.obj	\
	base.obj	\
	document.obj	\
	doccol.obj	\
	dociter.obj	\
	pagefile.obj	\
	index.obj	\
	hindex.obj	\
	indices.obj	\
	refcol.obj	\
	privbase.obj	\
	streams.obj	\
	btree.obj	\
	btiter.obj	\
	basemask.obj	\
	ncpf.obj	\
	stdbase.obj	\
	store.obj	\
	rev.obj		\
	maps.obj	\
	fltiter.obj	\
	unzip.obj	\
	inflate.obj	\
	deflate.obj	\
	infblock.obj	\
	zutil.obj	\
	infutil.obj	\
	infcodes.obj	\
	inftrees.obj	\
	inffast.obj	\
	adler32.obj	\
	trees.obj	\
	pack.obj	\
	crc32.obj	\
	osdummy.obj	\
$(SERVER_OBJS_0)

SERVER_MAIN=

SERVER_OBJS=$(SERVER_OBJS_0) $(SERVER_MAIN)

all: lib

lib: 	$(SERVER_OBJS_0)
	$(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libgkdb.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb
        del *.lib

deleteall: clean
	del *.idl
        del *.hh


garutils.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\garutils.cpp
collect.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\collect.cpp
newdoc.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\newdoc.cpp
base.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\base.cpp
document.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\document.cpp
doccol.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\doccol.cpp
dociter.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\dociter.cpp
pagefile.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\pagefile.cpp
index.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\index.cpp
hindex.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\hindex.cpp
indices.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\indices.cpp
refcol.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\refcol.cpp
privbase.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\privbase.cpp
streams.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\streams.cpp
btree.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\btree.cpp
btiter.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\btiter.cpp
gk.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\gk.cpp
basemask.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\basemask.cpp
ncpf.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\ncpf.cpp
stdbase.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\stdbase.cpp
store.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\store.cpp
rev.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\rev.cpp
maps.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\maps.cpp
fltiter.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\fltiter.cpp
dummies.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\dummies.cpp
unzip.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\unzip.c
inflate.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\inflate.c
deflate.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\deflate.c
infblock.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\infblock.c
zutil.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\zutil.c
infutil.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\infutil.c
infcodes.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\infcodes.c
inftrees.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\inftrees.c
inffast.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\inffast.c
adler32.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\adler32.c
trees.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\trees.c
pack.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\pack.c
crc32.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\crc32.c
osdummy.obj:
	$(CC) $(CC_FLAGS) $(SUBPROJECT)\osdummy.c
