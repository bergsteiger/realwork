ROOT:=../../..
INCLUDES:=../../gkdb/src ../../../include ../../cchlp/src

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=gsscreen

gsscreen_o = screen.o face.o pscreen.o gsscreen.o

lib_o = $(gsscreen_o) 

all_o = $(gsscreen_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
