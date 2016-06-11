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
# $Revision: 35727 $                                                      #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
!if $d(WIN64)
OBJS =               \
        _efcvt$(OBJ)   \
        _fpcls$(OBJ)   \
        _gcvt$(OBJ)    \
        _isinf$(OBJ)   \
        _isnan$(OBJ)   \
        _pow10$(OBJ)   \
        abs$(OBJ)      \
        atof$(OBJ)     \
        atoi64$(OBJ)   \
        atol$(OBJ)     \
        atold$(OBJ)    \
        cvtentry$(OBJ) \
        cvtentyw$(OBJ) \
        cvtfak$(OBJ)   \
        cvtfakw$(OBJ)  \
        div$(OBJ)      \
        efcvt$(OBJ)    \
        _finite$(OBJ)  \
        _finitel$(OBJ) \
        gcvt$(OBJ)     \
	hugeval$(OBJ) \
        initcvt$(OBJ)  \
        ldtrunc$(OBJ)  \
        i64toa$(OBJ)   \
        i64tow$(OBJ)   \
        int64toa$(OBJ) \
        int64tow$(OBJ) \
        labs$(OBJ)    \
        llabs$(OBJ)    \
        lldiv$(OBJ)    \
	longtoa$(OBJ)  \
	longtow$(OBJ)  \
        ltoa$(OBJ)     \
        ltoa1$(OBJ)    \
        ltow1$(OBJ)    \
	matherr$(OBJ)  \
	matherrl$(OBJ) \
	mathptr$(OBJ)  \
	pow10l$(OBJ)   \
        rand$(OBJ)     \
        randomize$(OBJ)\
        realcvt$(OBJ)  \
        realcvtw$(OBJ) \
        scantod$(OBJ)  \
        scanwtod$(OBJ) \
        strtod$(OBJ)   \
        strtol$(OBJ)   \
        strtoll$(OBJ)  \
        strtoul$(OBJ)  \
        strtoull$(OBJ) \
        wcstod$(OBJ)   \
        wcstol$(OBJ)   \
        wcstoll$(OBJ)  \
        wcstoul$(OBJ)  \
        wcstoull$(OBJ) \
        wtof$(OBJ)     \
        wtoi64$(OBJ)   \
        wtol$(OBJ)     \
        wtold$(OBJ)    \
        wtol$(OBJ)     \
        xcvt$(OBJ)     \
        xcvtw$(OBJ)
!else
OBJS =               \
        8087$(OBJ)     \
        _chgsgn$(OBJ)  \
        _cpysgn$(OBJ)  \
        _efcvt$(OBJ)   \
        _finite$(OBJ)  \
        _finitel$(OBJ) \
        _fpcls$(OBJ)   \
        _ftoul$(OBJ)   \
        _gcvt$(OBJ)    \
        _isnan$(OBJ)   \
        _isnanl$(OBJ)  \
        _ltoa1$(OBJ)   \
        _matherl$(OBJ) \
        _matherr$(OBJ) \
        _naftr$(OBJ)   \
        _naftrl$(OBJ)  \
        _pow10$(OBJ)   \
        _scalb$(OBJ)   \
        _scalbl$(OBJ)  \
        abs$(OBJ)      \
        acosasin$(OBJ) \
        acossinl$(OBJ) \
        atan$(OBJ)     \
        atan2$(OBJ)    \
        atan2l$(OBJ)   \
        atanl$(OBJ)    \
        atof$(OBJ)     \
        atoi64$(OBJ)   \
        atol$(OBJ)     \
        atold$(OBJ)    \
        bcd1$(OBJ)     \
        bcd2$(OBJ)     \
        ceil$(OBJ)     \
        ceill$(OBJ)    \
        clear87$(OBJ)  \
        cos$(OBJ)      \
        cosh$(OBJ)     \
        coshl$(OBJ)    \
        cosl$(OBJ)     \
        crotl$(OBJ)    \
        crotr$(OBJ)    \
        ctrl87$(OBJ)   \
        cvtentry$(OBJ) \
        cvtentyw$(OBJ) \
        cvtfak$(OBJ)   \
        cvtfakw$(OBJ)  \
        deflt87$(OBJ)  \
        div$(OBJ)      \
        efcvt$(OBJ)    \
        exp$(OBJ)      \
        expl$(OBJ)     \
        expld$(OBJ)    \
        f87atan$(OBJ)  \
        f87exp$(OBJ)   \
        f87log$(OBJ)   \
        f87sine$(OBJ)  \
        fabs$(OBJ)     \
        fabsl$(OBJ)    \
        fbstp$(OBJ)    \
        fildq$(OBJ)    \
        fistq$(OBJ)    \
        floor$(OBJ)    \
        floorl$(OBJ)   \
        fmod$(OBJ)     \
        fmodl$(OBJ)    \
        fpreset$(OBJ)  \
        frexp$(OBJ)    \
        frexpl$(OBJ)   \
        ftol$(OBJ)     \
        fuildq$(OBJ)   \
        fuistq$(OBJ)   \
        fxam$(OBJ)     \
        gcvt$(OBJ)     \
        hugeval$(OBJ)  \
        hypot$(OBJ)    \
        hypotl$(OBJ)   \
        i64toa$(OBJ)   \
        i64tow$(OBJ)   \
        initcvt$(OBJ)  \
        int64toa$(OBJ) \
        int64tow$(OBJ) \
        labs$(OBJ)     \
        ldexp$(OBJ)    \
        ldexpl$(OBJ)   \
        ldtrunc$(OBJ)  \
        llabs$(OBJ)    \
	lldiv$(OBJ)    \
        log$(OBJ)      \
        log10$(OBJ)    \
        log10l$(OBJ)   \
        logl$(OBJ)     \
        longtoa$(OBJ)  \
        longtow$(OBJ)  \
        lrotl$(OBJ)    \
        lrotr$(OBJ)    \
        ltoa1$(OBJ)    \
        ltow1$(OBJ)    \
        matherr$(OBJ)  \
        matherrl$(OBJ) \
        mathptr$(OBJ)  \
        mathptr2$(OBJ) \
        mathwhy$(OBJ)  \
        modf$(OBJ)     \
        modfl$(OBJ)    \
        poly$(OBJ)     \
        polyl$(OBJ)    \
        pow$(OBJ)      \
        pow10d$(OBJ)   \
        pow10l$(OBJ)   \
        powl$(OBJ)     \
        qdiv10$(OBJ)   \
        qmul10$(OBJ)   \
        rand$(OBJ)     \
        realcvt$(OBJ)  \
        realcvtw$(OBJ) \
        rotl$(OBJ)     \
        rotr$(OBJ)     \
        round$(OBJ)    \
        scantod$(OBJ)  \
        scanwtod$(OBJ) \
        sin$(OBJ)      \
        sinh$(OBJ)     \
        sinhl$(OBJ)    \
        sinl$(OBJ)     \
        sqrt$(OBJ)     \
        sqrtl$(OBJ)    \
        stat87$(OBJ)   \
        strtod$(OBJ)   \
        strtol$(OBJ)   \
        strtoll$(OBJ)  \
        strtoul$(OBJ)  \
        strtoull$(OBJ) \
        tan$(OBJ)      \
        tanh$(OBJ)     \
        tanhl$(OBJ)    \
        tanl$(OBJ)     \
        wcstod$(OBJ)   \
        wcstol$(OBJ)   \
        wcstoll$(OBJ)  \
        wcstoul$(OBJ)  \
        wcstoull$(OBJ) \
        wtof$(OBJ)     \
        wtoi64$(OBJ)   \
        wtol$(OBJ)     \
        wtold$(OBJ)    \
        xcvt$(OBJ)     \
        xcvtw$(OBJ)

!if !$d(CLANG32)
# Inline assembly
OBJS = $(OBJS)         \
        _logb$(OBJ)    \
	$(EMPTY)
!endif

!endif


AUXOBJS =              \

!if !$d(WIN64)
AUXOBJS = $(AUXOBJS)   \
        _ll$(OBJ)      \
        fdiv32$(OBJ)   \
        _strtold$(OBJ) \
	_wcstold$(OBJ) \
	$(EMPTY)

!if !$d(CLANG32)
# Iline assembly
AUXOBJS = $(AUXOBJS)   \
        fastmath$(OBJ)      \
	$(EMPTY)
!endif

!endif

!if $d(DLL)
IMPOBJS =             \
        xinitcvt$(OBJ)\
	$(EMPTY)

!if $d(WIN64)
IMPOBJS = $(IMPOBJS) \
	div$(OBJ)    \
        ltoa$(OBJ)   \
        _efcvt$(OBJ) \
        _gcvt$(OBJ)  \
	$(EMPTY)
!endif
!endif

!if $d(DLL)
    IMPOBJS = $(AUXOBJS) $(IMPOBJS)
    OBJS    = $(AUXOBJS) $(OBJS)
!else
    OBJS    = $(AUXOBJS) $(OBJS)
!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

cvtentyw$(OBJ): cvtentry.asm
cvtfakw$(OBJ) : cvtfak.c
i64tow$(OBJ)  : i64toa.c
int64tow$(OBJ): int64toa.c
longtow$(OBJ) : longtoa.c
ltow1$(OBJ)   : ltoa1.c
realcvtw$(OBJ): realcvt.c
scanwtod$(OBJ): scantod.c
wcstod$(OBJ)  : strtod.c
_wcstold$(OBJ): _strtold.c
wcstol$(OBJ)  : strtol.c
wcstoll$(OBJ) : strtoll.c
wcstoul$(OBJ) : strtoul.c
wcstoull$(OBJ): strtoull.c
wtof$(OBJ)    : atof.c
wtoi64$(OBJ)  : atoi64.c
wtol$(OBJ)    : atol.c
wtold$(OBJ)   : atold.c
xcvtw$(OBJ)   : xcvt.c
