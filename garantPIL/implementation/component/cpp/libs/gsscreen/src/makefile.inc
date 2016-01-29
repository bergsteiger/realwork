ifdef PLATFORM
include ../../../platforms/$(PLATFORM).inc
endif

ifeq ($(PLATFORM),solaris.x86.sunspro)
FLCTL=
else
FLCTL=-Wall -funsigned-char -Werror -Wno-unused
endif

DIRECT_INCLUDES= -I../../gkdb/src -I../../../include -I../../../include/$(PLATFORM)
CFLAGS+=  $(DIRECT_INCLUDES)
CFLAGS+= $(FLCTL)
CXXFLAGS+= $(DIRECT_INCLUDES)
CXXFLAGS+=$(FLCTL)

c_o = screen.o face.o

lib_o = $(c_o) 

all_o = $(lib_o)
