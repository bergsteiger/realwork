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
# $Revision: 35783 $                                                                #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
!if $d(MINIRTL)
OBJS =           \
    abort$(OBJ)    \
    atexit$(OBJ)   \
    exit$(OBJ)     \
    __exit$(OBJ)   \
    exparg$(OBJ)   \
    getenv$(OBJ)   \
    hsargv$(OBJ)   \
    initargv$(OBJ) \
    initwild$(OBJ) \
    loadprog$(OBJ) \
    putenv$(OBJ)   \
    saptr$(OBJ)    \
    setargv$(OBJ)  \
    setargv0$(OBJ) \
    setenvp$(OBJ)  \
    srchenv$(OBJ)  \
    srchpath$(OBJ) \
    srchstr$(OBJ)  \
    system$(OBJ)   \
    wildptr$(OBJ)

    #setjmp$(OBJ)   \
    #signal$(OBJ)   \

!else
OBJS =           \
    cwait$(OBJ)    \
    abort$(OBJ)    \
    __atexit$(OBJ) \
    atexit$(OBJ)   \
    execl$(OBJ)    \
    wexecl$(OBJ)   \
    execle$(OBJ)   \
    wexecle$(OBJ)  \
    execlp$(OBJ)   \
    wexeclp$(OBJ)  \
    execlpe$(OBJ)  \
    wexeclpe$(OBJ) \
    execv$(OBJ)    \
    wexecv$(OBJ)   \
    execve$(OBJ)   \
    wexecve$(OBJ)  \
    execvp$(OBJ)   \
    wexecvp$(OBJ)  \
    execvpe$(OBJ)  \
    wexecvpe$(OBJ) \
    __exit$(OBJ)   \
    exit$(OBJ)     \
    getenv$(OBJ)   \
    wgetenv$(OBJ)  \
    getenv_s$(OBJ) \
    wgetenv_s$(OBJ)\
    initwild$(OBJ) \
    exparg$(OBJ)   \
    wexparg$(OBJ)  \
    putenv$(OBJ)   \
    wputenv$(OBJ)  \
    initargv$(OBJ) \
    saptr$(OBJ)    \
    wsaptr$(OBJ)   \
    setargv$(OBJ)  \
    hsargv$(OBJ)   \
    whsargv$(OBJ)  \
    wsetargv$(OBJ) \
    spawnl$(OBJ)   \
    wspawnl$(OBJ)  \
    spawnle$(OBJ)  \
    wspawnle$(OBJ) \
    spawnlp$(OBJ)  \
    wspawnlp$(OBJ) \
    spawnlpe$(OBJ) \
    wspwnlpe$(OBJ) \
    spawnv$(OBJ)   \
    wspawnv$(OBJ)  \
    spawnve$(OBJ)  \
    wspawnve$(OBJ) \
    spawnvp$(OBJ)  \
    wspawnvp$(OBJ) \
    spawnvpe$(OBJ) \
    wspwnvpe$(OBJ) \
    srchenv$(OBJ)  \
    wsrchenv$(OBJ) \
    srchpath$(OBJ) \
    wsrchpth$(OBJ) \
    srchstr$(OBJ)  \
    wsrchstr$(OBJ) \
    wait$(OBJ)     \
    wild$(OBJ)     \
    wwild$(OBJ)    \
    wildptr$(OBJ)  \
    wwildptr$(OBJ) \
    setargv0$(OBJ) \
    wsetarg0$(OBJ) \
    loadprog$(OBJ) \
    wloadprg$(OBJ) \
    setenv$(OBJ)   \
    wsetenv$(OBJ)  \
    setenvp$(OBJ)  \
    wsetenvp$(OBJ) \
    sleep$(OBJ)    \
    system$(OBJ)   \
    wsystem$(OBJ)  \
    _cwait$(OBJ)   \
    _getpid$(OBJ)  \
    signal$(OBJ)   \
    lonedll$(OBJ)  \
    $(EMPTY)

!if !$d(WIN64)
OBJS = $(OBJS)     \
    getpid$(OBJ)   \
    setjmp$(OBJ)   \
    $(EMPTY)
!else
OBJS = $(OBJS)     \
    setjmp64$(OBJ) \
    longjmp64$(OBJ)\
    make_arglist$(OBJ) \
    wmake_arglist$(OBJ) \
    c_getpid$(OBJ) \
    $(EMPTY)
!endif

!endif

!if $d(DLL)
    IMPOBJS =    \
    atexit$(OBJ)   \
    exit$(OBJ)     \
    setargv2$(OBJ) \
    wildptr$(OBJ)  \
    wwildptr$(OBJ) \
    wsetarg2$(OBJ) \
    xsetenvp$(OBJ) \
    wxsetenp$(OBJ)
!if $d(WIN64)
    IMPOBJS = $(IMPOBJS) \
    setjmp64$(OBJ)
!endif

!else
!if !$d(MINIRTL_EDG)
    MISC =               \
    $(LIBDIR)\wildargs$(OBJ)
!endif

!endif

!if !$d(MINIRTL_EDG) && !$d(MINIRTL) && !$d(WIN64)
MISC=$(MISC) setjmpnx$(OBJ)
!endif
#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
setjmpnx$(OBJ) : setjmp.asm
    $(ASM) -DNOXX $?, $(OBJDIR)\$&

!if $d(MINIRTL_EDG)
setjmp$(OBJ) : setjmp.nasm
    $(ASM) $(AFLAGS) $? -o $(OBJDIR)\$&.o
!endif

!if $d(WIN64)
$(LIBDIR)\wildargs.o : wildargs.o
!else
$(LIBDIR)\wildargs$(OBJ) : wildargs$(OBJ)
!endif
    copy $** $(LIBDIR)\$.

wsetenv$(OBJ)  : setenv.c
wsetenvp$(OBJ) : setenvp.c
wloadprg$(OBJ) : loadprog.c
wsystem$(OBJ)  : system.c

wgetenv$(OBJ)  : getenv.c
wgetenv_s$(OBJ): getenv_s.c
wputenv$(OBJ)  : putenv.c
wsrchenv$(OBJ) : srchenv.c
wsrchpth$(OBJ) : srchpath.c
wsrchstr$(OBJ) : srchstr.c
wspawnl$(OBJ)  : spawnl.c
wspawnle$(OBJ) : spawnle.c
wspawnlp$(OBJ) : spawnlp.c
wspwnlpe$(OBJ) : spawnlpe.c
wspawnv$(OBJ)  : spawnv.c
wspawnve$(OBJ) : spawnve.c
wspawnvp$(OBJ) : spawnvp.c
wspwnvpe$(OBJ) : spawnvpe.c
wexecl$(OBJ)   : execl.c
wexecle$(OBJ)  : execle.c
wexeclp$(OBJ)  : execlp.c
wexeclpe$(OBJ) : execlpe.c
wexecv$(OBJ)   : execv.c
wexecve$(OBJ)  : execve.c
wexecvp$(OBJ)  : execvp.c
wexecvpe$(OBJ) : execvpe.c
wsaptr$(OBJ)   : saptr.c
whsargv$(OBJ)  : hsargv.c
wsetargv$(OBJ) : setargv.c
wsetarg0$(OBJ) : setargv0.c
wsetarg2$(OBJ) : setargv2.c
wwild$(OBJ)    : wild.c
wwildptr$(OBJ) : wildptr.c
wexparg$(OBJ)  : exparg.c
wmake_arglist$(OBJ): make_arglist.cpp

