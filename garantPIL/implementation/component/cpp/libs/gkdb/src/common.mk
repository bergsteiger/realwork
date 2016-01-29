ROOT:=../../..
INCLUDES:=../../../include
INCLUDES+=../../../libs/gsscreen/src
INCLUDES+=../../../libs/cchlp/src
INCLUDES+=../../../libs/gkdb/src
INCLUDES+=../../../libs/mrglib/src
INCLUDES+=../../../libs/GPersn/src

ifeq ($(3ON1),1)
DEFS+=WITH_DBL_THREAD OPT_PACK
endif

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=gkdb osdep

.SUFFIXES:  .c .cpp .o .a 

cxx_objs=garutils.o  collect.o newdoc.o \
	base.o  document.o doccol.o dociter.o \
	pagefile.o index.o hindex.o indices.o \
	refcol.o privbase.o \
	streams.o btree.o btiter.o \
	basemask.o dummies.o docblock.o \
	ncpf.o stdbase.o store.o rev.o fltiter.o paracol.o

c_objs = unzip.o inflate.o deflate.o infblock.o \
	zutil.o infutil.o infcodes.o inftrees.o \
	inffast.o adler32.o trees.o pack.o \
	crc32.o pl_crypt.o

osdep_o:=osdummy.o

gkdb_o:=$(c_objs) $(cxx_objs)

all_o:=$(gkdb_o) $(osdep_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

