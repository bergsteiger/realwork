ROOT:=../../..
INCLUDES=$(ROOT)/include ../src

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM)
endif

INCLUDES+=$(ROOT)/libs/cchlp/src $(ROOT)/libs/gkdb/src
INCLUDES+=$(ROOT)/libs/gsscreen/src
INCLUDES+=$(ROOT)/libs/inifile/src
INCLUDES+=$(ROOT)/libs/gctx/src
INCLUDES+=$(ROOT)/libs/delta/src

LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/cchlp:cchlp

targets:=gctx

gctx_o=gctx.o

all_o = $(gctx_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
