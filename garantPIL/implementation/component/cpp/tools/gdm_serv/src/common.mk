ROOT:=../../..
INCLUDES:=../src $(ROOT)/include

ifdef PLATFORM
INCLUDES+=$(ROOT)/include/$(PLATFORM)
endif

INCLUDES+=$(ROOT)/libs/cchlp/src $(ROOT)/libs/gkdb/src
INCLUDES+=$(ROOT)/libs/delta/src $(ROOT)/libs/gsscreen/src
INCLUDES+=/usr/local/include/
#INCLUDES+=/export/home/andrew/omni3/include

LIBS=$(ROOT)/libs/delta:dhr
LIBS+=$(ROOT)/libs/cchlp:cchlp
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/gkdb:osdep

targets:=gdm
#gdm_serv 
gdm_o = deltamerger.o gdltmrg.o
#gdm_serv_o = gdm_serv.o killerSK.o OrbServer.o mergerSK.o merger_i.o strings_structSK.o deltamerger.o strings_structDynSK.o
#all_o = $(gdm_serv_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
