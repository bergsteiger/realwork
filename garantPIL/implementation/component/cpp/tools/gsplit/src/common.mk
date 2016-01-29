ROOT:=../../..
INCLUDES=$(ROOT)/include ../src

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM_DIR)
endif

INCLUDES+=$(ROOT)/libs/gkdb/src
INCLUDES+=$(ROOT)/libs/gsscreen/src
INCLUDES+=$(ROOT)/libs/mrglib/src
INCLUDES+=$(ROOT)/libs/cchlp/src
INCLUDES+=$(ROOT)/libs/gc/src
INCLUDES+=$(ROOT)/libs/GPersn/src

LIBS=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/cchlp:cchlp

targets:=gsplit
ifeq ($(PLATFORM),msvc32)
targets:=mk_echo
endif

gsplit_o=attr_index.o aux_index.o cmdline.o doc_index.o doclist.o \
	main.o split_index.o segfile.o subname.o usage.o indhlp.o hier_index.o \
	progress.o msg_tbl.o hc_index.o hind_collect.o blob_index.o cr_index.o \
	ready.o
all_o=$(gsplit_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
