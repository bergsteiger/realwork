ROOT:=../../..
INCLUDES:=$(ROOT)/include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
endif

INCLUDES+=../src $(ROOT)/libs/mrglib/src
INCLUDES+=$(ROOT)/libs/gsscreen/src
INCLUDES+=$(ROOT)/libs/cchlp/src
INCLUDES+=$(ROOT)/libs/gkdb/src

LIBS=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/cchlp:cchlp

gm_o=attrs_index.o cmdline.o doc_index.o gmmain.o hier_index.o \
	ind_merge.o main.o settings.o idxmhlp.o profile.o aux_index.o \
	progress.o subname_index.o blob_index.o ready.o


all_o=$(gm_o)
targets=gm

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

