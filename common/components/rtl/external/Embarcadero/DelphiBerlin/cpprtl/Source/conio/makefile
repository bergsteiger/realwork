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
# $Revision: 34039 $                                                                #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
!if $d(MINIRTL) && !defined(WIN64)
OBJS =               \
        _wherexy$(OBJ) \
        cgets$(OBJ)    \
        clreol$(OBJ)   \
        clrscr$(OBJ)   \
        color$(OBJ)    \
        cprintf$(OBJ)  \
        cvprintf$(OBJ) \
        cputn$(OBJ)    \
        cputs$(OBJ)    \
        crtinit$(OBJ)  \
        cscanf$(OBJ)   \
        cvscanf$(OBJ)  \
        cursor$(OBJ)   \
        getch$(OBJ)    \
        getche$(OBJ)   \
        getpass$(OBJ)  \
        gotoxy$(OBJ)   \
        gptext$(OBJ)   \
        insline$(OBJ)  \
        kbhit$(OBJ)    \
        movecurs$(OBJ) \
        movetext$(OBJ) \
        putch$(OBJ)    \
        scroll$(OBJ)   \
        textmode$(OBJ) \
        validxy$(OBJ)  \
        vidinfo$(OBJ)  \
        vram$(OBJ)     \
        wherexy$(OBJ)  \
        window$(OBJ)   \
        wscroll$(OBJ)
!elif $d(DINKUMWARE)
OBJS =               \
        _wherexy$(OBJ) \
        cgets$(OBJ)    \
        clreol$(OBJ)   \
        clrscr$(OBJ)   \
        color$(OBJ)    \
        constrea$(OBJ) \
        cprintf$(OBJ)  \
        cvprintf$(OBJ) \
        cputn$(OBJ)    \
        cputs$(OBJ)    \
        crtinit$(OBJ)  \
        cscanf$(OBJ)   \
        cvscanf$(OBJ)  \
        cursor$(OBJ)   \
        getch$(OBJ)    \
        getche$(OBJ)   \
        getpass$(OBJ)  \
        gotoxy$(OBJ)   \
        gptext$(OBJ)   \
        insline$(OBJ)  \
        kbhit$(OBJ)    \
        movecurs$(OBJ) \
        movetext$(OBJ) \
        putch$(OBJ)    \
        scroll$(OBJ)   \
        textmode$(OBJ) \
        validxy$(OBJ)  \
        vidinfo$(OBJ)  \
        vram$(OBJ)     \
        wherexy$(OBJ)  \
        window$(OBJ)   \
        wscroll$(OBJ)
!else
OBJS =               \
        _wherexy$(OBJ) \
        cgets$(OBJ)    \
        clreol$(OBJ)   \
        clrscr$(OBJ)   \
        color$(OBJ)    \
        constrea$(OBJ) \
        cprintf$(OBJ)  \
        cvprintf$(OBJ) \
        cputn$(OBJ)    \
        cputs$(OBJ)    \
        crtinit$(OBJ)  \
        cscanf$(OBJ)   \
        cvscanf$(OBJ)  \
        cursor$(OBJ)   \
        getch$(OBJ)    \
        getche$(OBJ)   \
        getpass$(OBJ)  \
        gotoxy$(OBJ)   \
        gptext$(OBJ)   \
        insline$(OBJ)  \
        kbhit$(OBJ)    \
        movecurs$(OBJ) \
        movetext$(OBJ) \
        putch$(OBJ)    \
        scroll$(OBJ)   \
        textmode$(OBJ) \
        validxy$(OBJ)  \
        vidinfo$(OBJ)  \
        vram$(OBJ)     \
        wherexy$(OBJ)  \
        window$(OBJ)   \
        wscroll$(OBJ)
!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
!include rules.mak

