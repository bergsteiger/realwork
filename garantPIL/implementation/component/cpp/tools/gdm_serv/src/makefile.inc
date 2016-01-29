ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
ifndef PLATFORM_DIR
PLATFORM_DIR:=$(PLATFORM)
endif
endif

DIRECT_INCLUDES= -I../../../libs/cchlp/src -I../../../libs/gkdb/src -I/export/home/andrew/omni3/include
DIRECT_INCLUDES+= -I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+= -I../src
DIRECT_INCLUDES+= -I../../../libs/delta/src
CXXFLAGS+= $(DIRECT_INCLUDES)

LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/cchlp/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/delta/$(PLATFORM_DIR)
LDFLAGS += -L.
LDFLAGS += -L/export/home/andrew/omni3/lib/sun4_sosV_5.7 -ldhr -lgkdb -lcchlp -losdep -lomniORB3 -lomnithread -lomniLC -lomniGK_stub -lomniDynamic3 -lxnet -lnsl -lmalloc

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a \
		../../../libs/cchlp/$(PLATFORM_DIR)/libcchlp.a \
		../../../libs/delta/$(PLATFORM_DIR)/libdhr.a 

gdm_serv_o = gdm_serv.o killer.o OrbServer.o mergerSK.o merger_i.o strings_structSK.o deltamerger.o strings_structDynSK.o

cc_o = $(gdm_serv_o)

all_o = $(cc_o)
