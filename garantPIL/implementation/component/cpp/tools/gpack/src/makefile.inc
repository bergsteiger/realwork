ifeq ($(PLATFORM),solaris)
PLATFORM_DIR:=solaris.x86
else
PLATFORM_DIR:=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES=-I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+=-I../../../libs/gsscreen/src
DIRECT_INCLUDES+=-I../../../libs/gkdb/src
DIRECT_INCLUDES+=-I../../../libs/cchlp/src

CFLAGS+=$(DIRECT_INCLUDES) -Wall -funsigned-char 
CXXFLAGS+=$(DIRECT_INCLUDES) -Wall -funsigned-char 

LDFLAGS+=-L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/cchlp/$(PLATFORM_DIR)
LDFLAGS+=-lgsscreen -lgkdb -losdep -lcchlp

EXTRA_LIB=../../../libs/gsscreen/$(PLATFORM_DIR)/libgsscreen.a
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libosdep.a

pack_cc_objs=gpack.o

all_objs = $(pack_cc_objs)

