ROOT:=../../..

ifdef PLATFORM
INCLUDES+=../../../include ../../../include/$(PLATFORM) ../../../libs/gkdb/src
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=rtf

.SUFFIXES:  .c .cpp .o .a

rtf_o:=rtffile.o rtfgar.o rtfwrite.o 
all_o:=$(rtf_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
