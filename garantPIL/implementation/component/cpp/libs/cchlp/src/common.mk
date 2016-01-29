ROOT:=../../..
INCLUDES:=../../gkdb/src ../../../include ../../../libs/gsscreen/src ../../../libs/cchlp/src

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
include $(ROOT)/Mk/$(PLATFORM).mk
endif

targets:=cchlp

cc_o = fstring.o \
			long.long.Map.o long.long.SplayMap.o long.long.VHMap.o \
			long.caddr_t.Map.o long.caddr_t.SplayMap.o \
			long.Set.o long.SplaySet.o long.VHSet.o long.SplayNode.o \
			long.longSplaySet.Map.o long.longSplaySet.SplayMap.o \
			u_int32_t.caddr_t.Map.o  u_int32_t.caddr_t.SplayMap.o \
			u_int32_t.SplaySet.o u_int32_t.Set.o \
			u_int32_t.SplayNode.o u_int32_t.VHSet.o \
			u_int32_t.FString.Map.o u_int32_t.FString.SplayMap.o \
			u_int32_t.FString.VHMap.o \
			FString.FString.Map.o FString.FString.SplayMap.o \
			FString.Set.o FString.SplayNode.o FString.SplaySet.o \
			FString.VHSet.o FString.caddr_t.Map.o \
			FString.caddr_t.SplayMap.o FString.long.Map.o \
			FString.long.SplayMap.o FString.long.VHMap.o \
			u_int64_t.Set.o u_int64_t.SplayNode.o u_int64_t.SplaySet.o \
			date.Set.o date.SplayNode.o date.SplaySet.o	\
			u_int64_t.u_int16_t.Map.o u_int64_t.u_int16_t.SplayMap.o \
			u_int64_t.VHSet.o Regex.o \
			errhandler.o advlog.o stringz.o \
			hidxhlp.o Logger.o recode.o hnode.o \
			clTreeNode.Set.o clTreeNode.SplayNode.o clTreeNode.SplaySet.o

c_o=rx.o

cchlp_o:=$(cc_o) $(c_o)
all_o:=$(cchlp_o)

include $(ROOT)/Mk/lib.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

