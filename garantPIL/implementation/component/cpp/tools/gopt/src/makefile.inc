ifeq ($(PLATFORM),solaris)
PLATFORM_DIR:=solaris.x86
else
PLATFORM_DIR:=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES=-I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+=-I../../../libs/mrglib/src
DIRECT_INCLUDES+=-I../../../libs/gkdb/src

CFLAGS+=$(DIRECT_INCLUDES) -Wall -funsigned-char
CXXFLAGS+=$(DIRECT_INCLUDES) -Wall -funsigned-char

LDFLAGS += -L../../../libs/mrglib/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/gsscreen/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS += -lmrglib -lgsscreen -lgkdb -losdep

EXTRA_LIB=../../../libs/mrglib/$(PLATFORM_DIR)/libmrglib.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libosdep.a 

c_objs = optmain.o optndt.o opttree.o main.o
cxx_objs = ready.o

all_objs = $(c_objs) $(cxx_objs)
