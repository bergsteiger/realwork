ROOT:=../../..
INCLUDES:=../../../include ../include ../../lex/include ../../../libs/gkdb/src ../../../cchlp/gctx/src ../../../libs/mrglib/src ../../../libs/cchlp/src

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=gchange

.SUFFIXES:  .c .cpp .o .a 

cxx_objs   = context.o parser.o

c_objs     =

osdep_o:=

gchange_o:=$(c_objs) $(cxx_objs)

all_o:=$(gchange_o) $(osdep_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

