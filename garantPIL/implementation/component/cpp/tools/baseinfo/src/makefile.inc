ifeq ($(PLATFORM),solaris.x86)
PLATFORM_NAME:=solaris
else
PLATFORM_NAME:=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM_NAME).inc

DIRECT_INCLUDES= -I../../../libs/gkdb/src
DIRECT_INCLUDES+= -I../../../libs/inifile/src 
DIRECT_INCLUDES+= -I../../../libs/VControl/src 
DIRECT_INCLUDES+= -I../../../libs/gsscreen/src 
DIRECT_INCLUDES+= -I../src
DIRECT_INCLUDES+= -I../../../include/
CXXFLAGS+= $(DIRECT_INCLUDES)
CXXFLAGS+=-Wall -funsigned-char 
LDFLAGS+=-L../../../libs/inifile/$(PLATFORM) -linifile
LDFLAGS+=-L../../../libs/gkdb/$(PLATFORM) -lgkdb
LDFLAGS+=-L../../../libs/VControl/$(PLATFORM) -lVControl
LDFLAGS+=-L../../../libs/gsscreen/$(PLATFORM) -lgsscreen
LDFLAGS+=-L../../../libs/gkdb/$(PLATFORM) -losdep

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM)/libgkdb.a \
	../../../libs/inifile/$(PLATFORM)/libinifile.a \
	../../../libs/VControl/$(PLATFORM)/libVControl.a \
	../../../libs/gsscreen/$(PLATFORM)/libgsscreen.a \
	../../../libs/gkdb/$(PLATFORM)/libosdep.a

baseinfo_o = baseinfo.o 

cc_o = $(baseinfo_o)

all_o = $(cc_o)

