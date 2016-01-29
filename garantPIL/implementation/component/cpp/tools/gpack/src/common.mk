ROOT:=../../..
INCLUDES=$(ROOT)/include

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM_DIR)
endif

INCLUDES+=../src $(ROOT)/libs/gsscreen/src
INCLUDES+=$(ROOT)/libs/cchlp/src
INCLUDES+=$(ROOT)/libs/gkdb/src

LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/cchlp:cchlp
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gkdb:osdep

gpack_o=gpack.o

all_o=$(gpack_o)
targets=gpack

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
