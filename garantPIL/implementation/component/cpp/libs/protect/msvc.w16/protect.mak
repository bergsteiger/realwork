# Microsoft Visual C++ generated build script - Do not modify

PROJ = PROTECT
DEBUG = 0
PROGTYPE = 4
CALLER = 
ARGS = 
DLLS = 
D_RCDEFINES = -d_DEBUG
R_RCDEFINES = -dNDEBUG
ORIGIN = MSVC
ORIGIN_VER = 1.00
PROJPATH = H:\WORK\GARANT\LIBS\PROTECT\
USEMFC = 0
CC = cl
CPP = cl
CXX = cl
CCREATEPCHFLAG = 
CPPCREATEPCHFLAG = 
CUSEPCHFLAG = 
CPPUSEPCHFLAG = 
FIRSTC = PROT401.C   
FIRSTCPP =             
RC = rc
CFLAGS_D_LIB = /nologo /f /G2 /Zp1 /W3 /Gf /Zi /AL /Od /D "_DEBUG" /D "_WINDOWS" /Fd"PROTECT.PDB" /J
CFLAGS_R_LIB = /nologo /f- /G3 /Zp1 /W3 /Gf /AL /Od /D "NDEBUG" /D "_WINDOWS" /J
RCFLAGS = /nologo
RESFLAGS = /nologo
RUNFLAGS = 
OBJS_EXT = 
LIBS_EXT = 
!if "$(DEBUG)" == "1"
CFLAGS = $(CFLAGS_D_LIB)
LFLAGS = 
LIBS = 
MAPFILE = nul
RCDEFINES = $(D_RCDEFINES)
!else
CFLAGS = $(CFLAGS_R_LIB)
LFLAGS = 
LIBS = 
MAPFILE = nul
RCDEFINES = $(R_RCDEFINES)
!endif
!if [if exist MSVC.BND del MSVC.BND]
!endif
SBRS = PROT401.SBR \
		MEDIATE.SBR


PROT401_DEP = h:\work\garant\libs\protect\prot401.h


MEDIATE_DEP = h:\work\garant\libs\protect\prot401.h


all:	$(PROJ).LIB

PROT401.OBJ:	PROT401.C $(PROT401_DEP)
	$(CC) $(CFLAGS) $(CCREATEPCHFLAG) /c PROT401.C

MEDIATE.OBJ:	MEDIATE.C $(MEDIATE_DEP)
	$(CC) $(CFLAGS) $(CUSEPCHFLAG) /c MEDIATE.C

$(PROJ).LIB::	PROT401.OBJ MEDIATE.OBJ $(OBJS_EXT)
	echo >NUL @<<$(PROJ).CRF
$@ /PAGESIZE:64
y
+PROT401.OBJ &
+MEDIATE.OBJ &
;
<<
	if exist $@ del $@
	lib @$(PROJ).CRF

$(PROJ).BSC: $(SBRS)
	bscmake @<<
/o$@ $(SBRS)
<<
