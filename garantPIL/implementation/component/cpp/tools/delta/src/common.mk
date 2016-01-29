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

LIBS+=$(ROOT)/libs/delta:dhr
LIBS+=$(ROOT)/libs/delta:delta
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/inifile:inifile
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/cchlp:cchlp

ifdef USE_N_MALLOC
DEFS+=N_MALLOC
else
SYSLIBS+=malloc
endif

targets:=ggu
ifneq ($(PLATFORM),go32)
targets+=ggdlt ggrev
endif

ggu_o=cntxtcol.o unfull.o update.o clcache.o
ggdlt_o=delta.o fulldiff.o diffhldr.o
ggrev_o=reviser.o setrev.o

all_o = $(ggu_o) $(ggdlt_o) $(ggrev_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

