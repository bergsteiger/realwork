ifneq ($(origin PLATFORM),undefined)
ifeq ($(PLATFORM),solaris)
PLATFORM_DIR=solaris.x86
else
PLATFORM_DIR=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc
endif

DIRECT_INCLUDES=-I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+=-I../../../libs/mrglib/src
DIRECT_INCLUDES+=-I../../../libs/gsscreen/src
DIRECT_INCLUDES+=-I../../../libs/gkdb/src

CFLAGS+=$(INCS) -Wall -funsigned-char 
# -Werror
CXXFLAGS+=$(INCS) -Wall -funsigned-char 
# -Werror

LDFLAGS+=-L../../../libs/mrglib/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS+=-L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS+=-lmrglib -lgsscreen -lgkdb -losdep

EXTRA_LIB=../../../libs/mrglib/$(PLATFORM_DIR)/libmrglib.a
EXTRA_LIB+=../../../libs/gsscreen/$(PLATFORM_DIR)/libgsscreen.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a 
EXTRA_LIB+=../../../libs/gkdb/$(PLATFORM_DIR)/libosdep.a 

CFLAGS+=$(DIRECT_INCLUDES)
CXXFLAGS+=$(DIRECT_INCLUDES)
gsb_objs = attr_index.o aux_index.o cmdline.o doc_index.o doclist.o \
	main.o split_index.o segfile.o subname.o usage.o indhlp.o hier_index.o \
	progress.o msg_tbl.o hc_index.o hind_collect.o blob_index.o cr_index.o

gsb_cc_objs = ready.o

#ifeq ($(PLATFORM),go32)
#	gm_objs+=malloc.o
#endif

				
all_objs = $(gsb_objs) $(gsb_cc_objs)

