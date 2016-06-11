#############################################################################
#                                                                           #
# The make process relies on the creation of DLL and library response file  #
# creation.  To control the location of object modules the following should #
# be defined:                                                               #
#                                                                           #
#     IMPOBJS - A list of object modules that should appear in the DLL      #
#               import library.                                             #
#                                                                           #
#        OBJS - If a DLL is build, this is a list of the object modules     #
#               that are linked into the DLL.  If building a library, this  #
#               is the list of object modules that goes into the library.   #
#                                                                           #
# The building of miscellaneous object modules and libraries is controlled  #
# by the list of files in the MISC variable.                                #
#                                                                           #
# $Revision: 34095 $                                                       #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS =               \
	bigctype$(OBJ) \
	cconv$(OBJ)    \
	convt$(OBJ)    \
        clower$(OBJ)   \
        ctype$(OBJ)    \
        cupper$(OBJ)   \
        getinfo$(OBJ)  \
        getinfo1$(OBJ) \
        getinfo2$(OBJ) \
        getinfo3$(OBJ) \
        is$(OBJ)       \
        wis$(OBJ)      \
        isctype$(OBJ)  \
        iswctype$(OBJ) \
        locale$(OBJ)   \
        clocale$(OBJ)  \
        initcat$(OBJ)  \
	lconv$(OBJ)    \
	lstrcoll$(OBJ) \
	lwcscoll$(OBJ) \
        lstricol$(OBJ) \
        lwcsicol$(OBJ) \
        lstrncol$(OBJ) \
        lwcsncol$(OBJ) \
        lstrnico$(OBJ) \
        lwcsnico$(OBJ) \
        lstrlwr$(OBJ)  \
        lwcslwr$(OBJ)  \
        lstrupr$(OBJ)  \
        lwcsupr$(OBJ)  \
        lstrxfrm$(OBJ) \
        lwcsxfrm$(OBJ) \
        ltolower$(OBJ) \
        ltowlwr$(OBJ)  \
        ltoupper$(OBJ) \
        ltowupr$(OBJ)  \
        mbyte1$(OBJ)   \
        mbrtowc$(OBJ)  \
        setlocal$(OBJ) \
        wsetlocl$(OBJ) \
        lsetlocl$(OBJ) \
	lwsetlcl$(OBJ) \
	strcoll$(OBJ)  \
        wcscoll$(OBJ)  \
        stricoll$(OBJ) \
        wcsicoll$(OBJ) \
        strncoll$(OBJ) \
        wcsncoll$(OBJ) \
        strnicol$(OBJ) \
        wcsnicol$(OBJ) \
        strftime$(OBJ) \
        strptime$(OBJ) \
        wcsftime$(OBJ) \
        strlwr$(OBJ)   \
        wcslwr$(OBJ)   \
        strupr$(OBJ)   \
        wcsupr$(OBJ)   \
        strxfrm$(OBJ)  \
        wcsxfrm$(OBJ)  \
        tolower$(OBJ)  \
        towlower$(OBJ) \
        toupper$(OBJ)  \
        towupper$(OBJ)

#!if $d(MT)
#    OBJS = $(OBJS)     \
#           locales$(OBJ)
#!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

CC = $(CC) -U_MBCS

toupper$(OBJ) : towupper.c
tolower$(OBJ) : towlower.c
strupr$(OBJ)  : wcsupr.c
strlwr$(OBJ)  : wcslwr.c
wis$(OBJ)     : is.c
wsetlocl$(OBJ): setlocal.c
wcscoll$(OBJ) : strcoll.c
wcsicoll$(OBJ): stricoll.c
wcsncoll$(OBJ): strncoll.c
wcsnicol$(OBJ): strnicol.c
lwcscoll$(OBJ): lstrcoll.c
wcsxfrm$(OBJ) : strxfrm.c

