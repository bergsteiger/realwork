ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
ifndef PLATFORM_DIR
PLATFORM_DIR:=$(PLATFORM)
endif
endif

DIRECT_INCLUDES= -I../../../libs/cchlp/src -I../../../libs/gkdb/src
DIRECT_INCLUDES+= -I../../../libs/gsscreen/src
DIRECT_INCLUDES+= -I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+= -I../../../libs/gl/src -I../src
DIRECT_INCLUDES+= -I../../../libs/inifile/src
DIRECT_INCLUDES+= -I../../gctx/src
CXXFLAGS+= $(DIRECT_INCLUDES)

LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/cchlp/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/gsscreen/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/inifile/$(PLATFORM_DIR)
LDFLAGS += -L../../gctx/$(PLATFORM_DIR)
LDFLAGS += -L.
LDFLAGS += -ldhr -ldelta -lgctx -lgkdb -lcchlp -lgsscreen -linifile -lgctx -losdep -lVControl

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a \
		../../../libs/cchlp/$(PLATFORM_DIR)/libcchlp.a \
		../../../libs/gsscreen/$(PLATFORM_DIR)/libgsscreen.a \
		../../../libs/inifile/$(PLATFORM_DIR)/libinifile.a \
		 ../../../tools/gctx/$(PLATFORM_DIR)/libgctx.a \
		 ../../../tools/gctx/$(PLATFORM_DIR)/libVControl.a

lib_o = adds.o wordcol.o elems.o hendlers.o

dhr_o = dhreader.o

gctx_o += gctx.o

cc_o = $(lib_o) $(dhr_o) $(gctx_o)

all_o = $(cc_o) $(c_o)

