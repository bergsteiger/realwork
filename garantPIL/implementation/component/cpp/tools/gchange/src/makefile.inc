ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
ifndef PLATFORM_DIR
PLATFORM_DIR:=$(PLATFORM)
endif
endif

DIRECT_INCLUDES= -I../../../libs/lex/include -I../../../libs/gkdb/src
DIRECT_INCLUDES+= -I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+= -I../include
DIRECT_INCLUDES+= -I../../../lib/gchange/include
CXXFLAGS+= $(DIRECT_INCLUDES)

LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR) 
LDFLAGS += -L../../../libs/lex/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/gchange/$(PLATFORM_DIR)
LDFLAGS += -L.
LDFLAGS += -lgchange -llex -lgkdb -losdep -lgsscreen

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a \
        ../../../libs/lex/$(PLATFORM_DIR)/liblex.a \
        ../../../libs/gchange/$(PLATFORM_DIR)/libgchange.a \
        ../../../libs/delta/$(PLATFORM_DIR)/libgsscreen.a

gchange_o = gchange.o

cxx_o = $(gchange_o)

all_o = $(cxx_o)

