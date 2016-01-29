ROOT:=../../..
INCLUDES:=../src $(ROOT)/include

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM)
endif

INCLUDES+=$(ROOT)/libs/gctx/src $(ROOT)/libs/mrglib/src $(ROOT)/libs/cchlp/src
INCLUDES+=$(ROOT)/libs/lex/include $(ROOT)/libs/gkdb/src $(ROOT)/libs/gchange/include
INCLUDES+=../include $(ROOT)/libs/gsscreen/src

LIBS=$(ROOT)/libs/gchange:gchange
LIBS+=$(ROOT)/libs/lex:lex
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/cchlp:cchlp

targets:=gchange
gchange_o = gchange.o
all_o = $(gchange_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

LDFLAGS_LIBS+=-lstdc++

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

