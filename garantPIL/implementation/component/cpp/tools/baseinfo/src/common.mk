ROOT:=../../..
INCLUDES:=../src ../../../include

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM)
endif

INCLUDES+=$(ROOT)/libs/cchlp/src $(ROOT)/libs/gkdb/src $(ROOT)/libs/inifile/src $(ROOT)/libs/gsscreen/src
INCLUDES+=$(ROOT)/libs/gctx/src $(ROOT)/libs/mrglib/src $(ROOT)/libs/VControl/src 

LIBS+=../../../libs/gkdb:gkdb
LIBS+=../../../libs/inifile:inifile
LIBS+=../../../libs/gkdb:osdep
LIBS+=../../../libs/mrglib:mrglib
LIBS+=../../../libs/gctx:gctx
LIBS+=../../../libs/gsscreen:gsscreen
LIBS+=../../../libs/VControl:VControl
LIBS+=../../../libs/cchlp:cchlp

targets=baseinfo
baseinfo_o = baseinfo.o 
all_o = $(baseinfo_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
