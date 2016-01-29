PLATFORM=msvc.win32
PROJECT=..\..\..
SUBPROJECT=$(PROJECT)\libs\cchlp\src
BLDPROJECT=$(PROJECT)\libs\cchlp\msvc.win32

DEBUG=NO

MYCFLAGS = -I$(SUBPROJECT) -I$(PROJECT)\libs\cchlp\src -I$(PROJECT)\libs\gkdb\src -I$(PROJECT)\include -I$(PROJECT)\include\win32 -DCODETYPE_DOS

!include "make.inc"

LIB_MAKER=lib
LIBS=$(LIBS)

SERVER_OBJS_0= 
SERVER_OBJS_0= \
        fstring.obj                     \
        Logger.obj                      \
        recode.obj                      \
        long.long.Map.obj               \
        long.long.SplayMap.obj          \
        long.long.VHMap.obj             \
        long.caddr_t.Map.obj            \
        long.caddr_t.SplayMap.obj       \
        long.Set.obj                    \
        long.SplaySet.obj               \
        long.VHSet.obj                  \
        long.SplayNode.obj              \
        long.longSplaySet.Map.obj       \
        long.longSplaySet.SplayMap.obj  \
        u_int32_t.caddr_t.Map.obj       \
        u_int32_t.caddr_t.SplayMap.obj  \
        u_int32_t.SplaySet.obj          \
        u_int32_t.Set.obj               \
        u_int32_t.SplayNode.obj         \
        u_int32_t.VHSet.obj             \
        u_int32_t.FString.Map.obj       \
        u_int32_t.FString.SplayMap.obj  \
        u_int32_t.FString.VHMap.obj     \
        FString.FString.Map.obj         \
        FString.FString.SplayMap.obj    \
        FString.Set.obj                 \
        FString.SplayNode.obj           \
        FString.SplaySet.obj            \
#       FString.VHSet.obj               \
        FString.caddr_t.Map.obj         \
        FString.caddr_t.SplayMap.obj    \
        FString.long.Map.obj            \
        FString.long.SplayMap.obj       \
#       FString.long.VHMap.obj          \
        u_int64_t.Set.obj               \
        u_int64_t.SplayNode.obj         \
        u_int64_t.SplaySet.obj          \
        date.Set.obj                    \
        date.SplayNode.obj              \
        date.SplaySet.obj               \
        u_int64_t.u_int16_t.Map.obj     \
        u_int64_t.u_int16_t.SplayMap.obj        \
        u_int64_t.VHSet.obj             \
        errhandler.obj                  \
        advlog.obj                      \
        stringz.obj                     \
        hidxhlp.obj                     \
        hnode.obj                       \
        clTreeNode.Set.obj              \
        clTreeNode.SplayNode.obj        \
        clTreeNode.SplaySet.obj         \
        getopt.obj                      \
$(SERVER_OBJS_0)

SERVER_MAIN=

SERVER_OBJS=$(SERVER_OBJS_0) $(SERVER_MAIN)

C_FLAGS = $(CC_FLAGS)
CPP_FLAGS = $(CC_FLAGS) /Tp

all: lib

lib:    $(SERVER_OBJS_0)
        $(LIB_MAKER) $(SERVER_OBJS_0) /OUT:libcchlp.lib

clean:
        del *.obj
        del *.map
        del *.exe
        del *.pdb
        del *.lib

deleteall: clean
        del *.idl
        del *.hh


fstring.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\fstring.cpp
Logger.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\Logger.cpp
recode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\recode.cpp
hnode.obj: $(SUBPROJECT)\hnode.cpp
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\hnode.cpp
getopt.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\getopt.c
long.long.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.long.Map.cpp
long.long.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.long.SplayMap.cpp
long.long.VHMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.long.VHMap.cpp
long.caddr_t.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.caddr_t.Map.cpp
long.caddr_t.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.caddr_t.SplayMap.cpp
long.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.Set.cpp
long.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.SplaySet.cpp
long.VHSet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.VHSet.cpp
long.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.SplayNode.cpp
long.longSplaySet.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.longSplaySet.Map.cpp
long.longSplaySet.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\long.longSplaySet.SplayMap.cpp
u_int32_t.caddr_t.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.caddr_t.Map.cpp
u_int32_t.caddr_t.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.caddr_t.SplayMap.cpp
u_int32_t.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.SplaySet.cpp
u_int32_t.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.Set.cpp
u_int32_t.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.SplayNode.cpp
u_int32_t.VHSet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.VHSet.cpp
u_int32_t.FString.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.FString.Map.cpp
u_int32_t.FString.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.FString.SplayMap.cpp
u_int32_t.FString.VHMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int32_t.FString.VHMap.cpp
FString.FString.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.FString.Map.cpp
FString.FString.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.FString.SplayMap.cpp
FString.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.Set.cpp
FString.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.SplayNode.cpp
FString.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.SplaySet.cpp
FString.VHSet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.VHSet.cpp
FString.caddr_t.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.caddr_t.Map.cpp
FString.caddr_t.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.caddr_t.SplayMap.cpp
FString.long.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.long.Map.cpp
FString.long.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.long.SplayMap.cpp
FString.long.VHMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\FString.long.VHMap.cpp
u_int64_t.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.Set.cpp
u_int64_t.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.SplayNode.cpp
u_int64_t.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.SplaySet.cpp
date.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\date.Set.cpp
date.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\date.SplayNode.cpp
date.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\date.SplaySet.cpp
u_int64_t.u_int16_t.Map.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.u_int16_t.Map.cpp
u_int64_t.u_int16_t.SplayMap.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.u_int16_t.SplayMap.cpp
u_int64_t.VHSet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\u_int64_t.VHSet.cpp
errhandler.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\errhandler.cpp
advlog.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\advlog.cpp
stringz.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\stringz.cpp
hidxhlp.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\hidxhlp.cpp
clTreeNode.Set.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\clTreeNode.Set.cpp
clTreeNode.SplayNode.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\clTreeNode.SplayNode.cpp
clTreeNode.SplaySet.obj:
        $(CC) $(CPP_FLAGS) $(SUBPROJECT)\clTreeNode.SplaySet.cpp
