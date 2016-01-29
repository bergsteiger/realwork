ROOT:=../../..
INCLUDES=../src $(ROOT)/include

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
INCLUDES+=$(ROOT)/include/$(PLATFORM_DIR)
endif

INCLUDES+=../../cchlp/src ../../gkdb/src ../../gsscreen/src ../../gctx/src

targets=delta dhr

dhr_o=dhreader.o
delta_o=adds.o wordcol.o elems.o hendlers.o tempdoc.o

all_o=$(dhr_o) $(delta_o)

ifdef USE_N_MALLOC
delta_o+=n_malloc.o
DEFS+=N_MALLOC
endif

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

