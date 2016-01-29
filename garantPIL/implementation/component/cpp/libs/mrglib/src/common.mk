ROOT:=../../..
INCLUDES:=../../gkdb/src ../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=mrglib util

mrglib_o = bfind.o btree_.o cmpfunc.o flog.o gbase.o gberr.o \
				globals.o index_.o iter.o keyfile.o pgfile.o sets.o \
				ssets.o streams_.o strcache.o mlhooks.o

util_o = flog.o unifname.o profile.o

all_o = $(mrglib_o) $(util_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
