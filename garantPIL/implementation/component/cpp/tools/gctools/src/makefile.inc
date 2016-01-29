ifeq ($(PLATFORM),solaris)
PLATFORM_DIR=solaris.x86
else
PLATFORM_DIR=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES= -I../src -I../../../libs/cchlp/src -I../../../libs/gkdb/src
DIRECT_INCLUDES+= -I../../../libs/gsscreen/src
DIRECT_INCLUDES+= -I../../../libs/VControl/src
DIRECT_INCLUDES+= -I../../../include -I../../../include/$(PLATFORM)
CXXFLAGS+= $(DIRECT_INCLUDES) -fno-for-scope
# CXXFLAGS+=-Wall -funsigned-char 

LDFLAGS+=-L. -L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS+= -L../../../libs/cchlp/$(PLATFORM_DIR)
LDFLAGS+= -L../../../libs/VControl/$(PLATFORM_DIR)
LDFLAGS+= -L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS+= -lgkdb -lgc -lgsscreen -lgkdb -lcchlp -lVControl

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a \
		../../../libs/cchlp/$(PLATFORM_DIR)/libcchlp.a \
		../../../libs/VControl/$(PLATFORM_DIR)/libVControl.a \
		../../../libs/gsscreen/$(PLATFORM_DIR)/libgsscreen.a


lib_o = dbproc.o dbproc.m-reader.o dbproc.m-writer.o dbproc.mf.o \
	gclog.o unixdummies.o dbproc.m-to-gkdb.o cacheIndex.o 

ifeq ($(HAS_WORKING_THREADS),1)
lib_o+= dbproc.mh-mt.o dbproc.mh-mt-srw.o
endif

gc_o = garcomp.o fstringer.o gcini.o classes.o sources.o belongs.o \
	   complect.o nsrcparser.o gcpass1.o kwfile.o sttop.o loadStringMap.o \
		blobtable.o normfile.o publish.o

dumpClassEq_o = dumpClassEq.o classes.o

gl_o = glproc.o glmain.o

mf2gardb_o = mf2gardb.o 

mfcheck_o  = mfcheck.o

gkcorr_o = gkcorr.o

cc_o = $(lib_o) $(gc_o) $(gl_o) $(mfcheck_o) $(mf2gardb_o) $(gkcorr_o)

all_o = $(cc_o)

