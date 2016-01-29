ROOT:=../../..
INCLUDES=$(ROOT)/include ../src

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM_DIR)
endif

INCLUDES+=$(ROOT)/libs/gkdb/src
INCLUDES+=$(ROOT)/libs/mrglib/src

LIBS=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/VControl:VControl
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/cchlp:cchlp

targets:=gopt

ifeq ($(PLATFORM),go32)
targets:=mk_echo
endif

gopt_o=optmain.o optndt.o opttree.o main.o ready.o
all_o=$(gopt_o)
ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
