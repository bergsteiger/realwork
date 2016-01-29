ROOT:=../../..
INCLUDES:=../../gkdb/src ../../../include ../../mrglib/src ../../gctx/src ../../cchlp/src

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=VControl

VControl_o = vapi.o

all_o = $(VControl_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
