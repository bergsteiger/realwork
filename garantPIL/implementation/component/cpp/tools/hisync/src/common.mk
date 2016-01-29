ROOT:=../../..
INCLUDES=$(ROOT)/include ../src

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM_DIR)
endif

INCLUDES+=$(ROOT)/libs/cchlp/src
INCLUDES+=$(ROOT)/libs/gctx/src
INCLUDES+=$(ROOT)/libs/gkdb/src
INCLUDES+=$(ROOT)/libs/mrglib/src

LIBS=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/cchlp:cchlp

targets:=hisync
ifneq ($(findstring $(PLATFORM),go32 msvc32),)
targets:=mk_echo
endif

hisync_o=main.o hisync.o synchind.o cmdline.o ready.o
all_o=$(hisync_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
