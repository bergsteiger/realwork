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
# $Revision: 34040 $                                                                #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
!if $d(MINIRTL)
OBJS =		     \
	time$(OBJ)     \
	timedata$(OBJ) \
	timefunc$(OBJ) \
	tzdata$(OBJ)   \
	tzset$(OBJ)
!else
OBJS =               \
        ctime$(OBJ)    \
        ctime_s$(OBJ)  \
        wctime$(OBJ)   \
        wctime_s$(OBJ) \
        difftime$(OBJ) \
        gmtime$(OBJ)   \
        gmtime_s$(OBJ) \
        mktime$(OBJ)   \
        timecvt$(OBJ)  \
        timedata$(OBJ) \
        wtimedat$(OBJ) \
        timefunc$(OBJ) \
        tzdata$(OBJ)   \
        tzset$(OBJ)    \
        _tzset$(OBJ)   \
        wtzset$(OBJ)   \
        clock$(OBJ)    \
        dosgdate$(OBJ) \
        dossdate$(OBJ) \
        ftime$(OBJ)    \
        getdate$(OBJ)  \
        setdate$(OBJ)  \
        statcvt$(OBJ)  \
        stime$(OBJ)    \
        strdate$(OBJ)  \
        systime$(OBJ)  \
        wstrdate$(OBJ) \
        time$(OBJ)     \
        rtltick$(OBJ)
!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

wctime$(OBJ)   : ctime.c
wctime_s$(OBJ) : ctime_s.c
wtimedat$(OBJ) : timedata.c
wtzset$(OBJ)   : tzset.c
wstrdate$(OBJ) : strdate.c

