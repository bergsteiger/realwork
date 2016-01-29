ifeq ($(PLATFORM),solaris)
PLATFORM_DIR:=solaris.x86
else
PLATFORM_DIR:=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES=-I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+=-I../../../libs/mrglib/src
DIRECT_INCLUDES+=-I../../../libs/gsscreen/src
DIRECT_INCLUDES+=-I../../../libs/gkdb/src

CFLAGS+=$(DIRECT_INCLUDES) -Wall -Wunused -funsigned-char -Werror
CXXFLAGS+=$(DIRECT_INCLUDES) -Wall -funsigned-char -Werror

LDFLAGS+=-L../../../libs/mrglib/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS+=-lmrglib -lgsscreen -lgkdb -losdep

EXTRA_LIB=../../../libs/mrglib/$(PLATFORM_DIR)/libmrglib.a
EXTRA_LIB+=../../../libs/gsscreen/$(PLATFORM_DIR)/libgsscreen.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libosdep.a 

gm_objs=attrs_index.o cmdline.o doc_index.o gmmain.o hier_index.o \
	ind_merge.o main.o settings.o idxmhlp.o profile.o aux_index.o \
	progress.o subname_index.o blob_index.o

gm_cc_objs=ready.o

ifneq (,$(findstring $(PLATFORM),freebsd))
#	gm_objs+=malloc.o
endif


all_objs = $(gm_objs) $(gm_cc_objs)

