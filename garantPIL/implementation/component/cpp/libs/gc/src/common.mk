ROOT:=../../..
INCLUDES=../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM_DIR)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

INCLUDES+=../../gkdb/src ../../cchlp/src ../../gctx/src ../../../tools/gctools/src

targets:=gc

gc_o:=dbproc.o dbproc.mf.o gclog.o unixdummies.o
all_o:=$(gc_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
