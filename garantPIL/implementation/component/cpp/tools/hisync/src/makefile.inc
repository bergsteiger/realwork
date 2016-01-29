ifeq ($(PLATFORM),)
PLATFORM := $(shell uname -s | tr "[A-Z]" "[a-z]")
endif

ifeq ($(PLATFORM),sunos)
PLATFORM=solaris
endif

ifeq ($(PLATFORM),solaris)
PLATFORM_DIR=solaris.x86
else
PLATFORM_DIR=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES = -I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES += -I../../../libs/mrglib/src
DIRECT_INCLUDES += -I../../../libs/gkdb/src

CFLAGS+=-Wall -funsigned-char $(DIRECT_INCLUDES)
CXXFLAGS+=-Wall -funsigned-char $(DIRECT_INCLUDES)

hs_c_objs = main.o hisync.o synchind.o cmdline.o

hs_cc_objs = ready.o

all_objs = $(hs_c_objs) $(hs_cc_objs)

LDFLAGS += -L../../../libs/mrglib/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS += -lgsscreen -lmrglib -lgkdb -losdep

EXTRA_LIB=../../../libs/mrglib/$(PLATFORM_DIR)/libmrglib.a
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libosdep.a
