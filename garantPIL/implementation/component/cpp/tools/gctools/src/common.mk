ROOT:=../../..
INCLUDES=../src ../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
endif

INCLUDES+= $(ROOT)/libs/gctx/src
INCLUDES+= $(ROOT)/libs/gkdb/src
INCLUDES+= $(ROOT)/libs/cchlp/src
INCLUDES+= $(ROOT)/libs/gsscreen/src
INCLUDES+= $(ROOT)/libs/gc/src
INCLUDES+= $(ROOT)/libs/gchange/include
INCLUDES+= $(ROOT)/libs/lex/include
INCLUDES+= $(ROOT)/tools/gctools/src

LIBS=$(ROOT)/libs/gc:gc
LIBS+=$(ROOT)/libs/gkdb:gkdb
LIBS+=$(ROOT)/libs/gsscreen:gsscreen
LIBS+=$(ROOT)/libs/cchlp:cchlp
LIBS+=$(ROOT)/libs/mrglib:mrglib
LIBS+=$(ROOT)/libs/gctx:gctx
LIBS+=$(ROOT)/libs/gkdb:osdep
LIBS+=$(ROOT)/libs/VControl:VControl


# lib_o = unixdummies.o  

# ifeq ($(HAS_WORKING_THREADS),1)
# lib_o+= dbproc.mh-mt.o dbproc.mh-mt-srw.o
# endif

targets:=gl
ifdef PLATFORM
ifneq ($(PLATFORM),go32)
targets+=gc_check
endif
endif

# mfcheck

gc_check_o=nsrcheck.o fstringer.o gcini.o classes.o sources.o belongs.o \
           complect.o nsrcparser.o gcpass1.o kwfile.o sttop.o loadStringMap.o \
        blobtable.o normfile.o publish.o dbproc.m-writer.o

dumpClassEq_o = dumpClassEq.o classes.o

gl_o = glproc.o glmain.o

mf2gardb_o = mf2gardb.o dbproc.m-reader.o dbproc.m-to-gkdb.o cacheIndex.o

# mfcheck_o  = mfcheck.o $(lib_o)

# gkcorr_o = gkcorr.o $(lib_o)

cc_o = $(sort $(gc_check_o) $(gl_o))

all_o = $(cc_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
