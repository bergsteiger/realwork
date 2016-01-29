ROOT:=../../..
INCLUDES=../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM_DIR)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

INCLUDES+=../../gkdb/src ../../cchlp/src

targets:=gctx

gctx_o:=ctxwords.o u_int64_t.CtxLongSet.Map.o u_int64_t.CtxLongSet.SplayMap.o unixdummies.o
all_o:=$(gctx_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

