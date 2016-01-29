ROOT:=../../..
INCLUDES:=../../../include ../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=lex

.SUFFIXES:  .c .cpp .o .a 

cxx_objs   = lex_parser.o  lex_basis.o lex_operator.o

c_objs     =

osdep_o:=

lex_o:=$(c_objs) $(cxx_objs)

all_o:=$(lex_o) $(osdep_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

