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
# $Revision: 35459 $                                                         #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS =               \
        __access$(OBJ) \
        __close$(OBJ)  \
        __dup$(OBJ)    \
        __dup2$(OBJ)   \
        __eof$(OBJ)    \
        __ftrunc$(OBJ) \
        __isatty$(OBJ) \
        __lseek$(OBJ)  \
        __open$(OBJ)   \
        __read$(OBJ)   \
        __wopen$(OBJ)  \
        __wread$(OBJ)  \
        __write$(OBJ)  \
        _cfinfo$(OBJ)  \
        _chmod$(OBJ)   \
        _close$(OBJ)   \
        _commit$(OBJ)  \
        _creat$(OBJ)   \
        _fdopen$(OBJ)  \
        _flshall$(OBJ) \
        _fputc$(OBJ)   \
        _fputwc$(OBJ)  \
        _fsopen$(OBJ)  \
        _fstat$(OBJ)   \
        _lseeki64$(OBJ) \
        _open$(OBJ)    \
        _pipe$(OBJ)    \
        _popen$(OBJ)   \
        _read$(OBJ)    \
        _umask$(OBJ)   \
        _waccess$(OBJ) \
        _wchmod$(OBJ)  \
        _wcreat$(OBJ)  \
        _wfdopen$(OBJ) \
        _wfsopen$(OBJ) \
        _wopen$(OBJ)   \
        _wpopen$(OBJ)  \
        _write$(OBJ)   \
        allocbuf$(OBJ) \
        cfinfo$(OBJ)   \
        chdir$(OBJ)    \
        chdrive$(OBJ)  \
        chmod$(OBJ)    \
        clearerr$(OBJ) \
        closeall$(OBJ) \
        creat$(OBJ)    \
        createmp$(OBJ) \
        creatnew$(OBJ) \
        direct$(OBJ)   \
        dosclose$(OBJ) \
        doscreat$(OBJ) \
        dosdfree$(OBJ) \
        dosfattr$(OBJ) \
        dosfind$(OBJ)  \
        dosgdriv$(OBJ) \
        dosgftim$(OBJ) \
        dosopen$(OBJ)  \
        dosread$(OBJ)  \
        dossftim$(OBJ) \
        doswrite$(OBJ) \
        fclose$(OBJ)   \
        ffile$(OBJ)    \
        ffile64$(OBJ)  \
        fflush$(OBJ)   \
        fgetchar$(OBJ) \
        fgetpos$(OBJ)  \
        fgets$(OBJ)    \
        fgetwchr$(OBJ) \
        fgetws$(OBJ)   \
        files$(OBJ)    \
        files2$(OBJ)   \
        findfrst$(OBJ) \
        flength$(OBJ)  \
        flushout$(OBJ) \
        fmode$(OBJ)    \
        fmodeptr$(OBJ) \
        fnmerge$(OBJ)  \
        fopen$(OBJ)    \
        fopen_s$(OBJ)  \
        fprintf$(OBJ)  \
        fprintfw$(OBJ) \
        fprintf_s$(OBJ)  \
        fprintfw_s$(OBJ) \
        fputchar$(OBJ) \
        fputn$(OBJ)    \
        fputnw$(OBJ)   \
        fputs$(OBJ)    \
        fputwchr$(OBJ) \
        fputws$(OBJ)   \
        fread$(OBJ)    \
        freopen$(OBJ)  \
        freopen_s$(OBJ)\
        fscanf$(OBJ)   \
        fscanfw$(OBJ)  \
        fscanf_s$(OBJ) \
        fscanfw_s$(OBJ)\
        fseek$(OBJ)    \
        fseeki64$(OBJ) \
        fseeko$(OBJ)    \
        fsetpos$(OBJ)  \
        fstati64$(OBJ) \
        fullpath$(OBJ) \
        fwrite$(OBJ)   \
        getcurdi$(OBJ) \
        getcwd$(OBJ)   \
        getdcwd$(OBJ)  \
        getdfree$(OBJ) \
        getdisk$(OBJ)  \
        getdrive$(OBJ) \
        getftime$(OBJ) \
        gets$(OBJ)     \
        gets_s$(OBJ)   \
        getw$(OBJ)     \
        getws$(OBJ)    \
        handles$(OBJ)  \
        ioerror$(OBJ)  \
        iomacro$(OBJ)  \
        lgetc$(OBJ)    \
        lgetwc$(OBJ)   \
        lock$(OBJ)     \
        locking$(OBJ)  \
        lputc$(OBJ)    \
        lputwc$(OBJ)   \
        makepath$(OBJ) \
        mkdir$(OBJ)    \
        mkname$(OBJ)   \
        mktemp$(OBJ)   \
        oshandle$(OBJ) \
        perror$(OBJ)   \
        printf$(OBJ)   \
        printf_s$(OBJ) \
        printfw$(OBJ)  \
        printfw_s$(OBJ)\
        puts$(OBJ)     \
        putw$(OBJ)     \
        putws$(OBJ)    \
        rename$(OBJ)   \
        rewind$(OBJ)   \
        rmdir$(OBJ)    \
        rmtmp$(OBJ)    \
        scanf$(OBJ)    \
        scanfw$(OBJ)   \
        scanf_s$(OBJ)  \
        scanfw_s$(OBJ) \
        scanner$(OBJ)  \
        scannerw$(OBJ) \
        scanner_s$(OBJ)\
        scannerw_s$(OBJ)\
        scantol$(OBJ)  \
        scanwtol$(OBJ) \
        scn2i64$(OBJ)  \
        scn2i64w$(OBJ) \
        setbuf$(OBJ)   \
        setftime$(OBJ) \
        setmode$(OBJ)  \
        setvbuf$(OBJ)  \
        snprntf$(OBJ)  \
        snprntfw$(OBJ) \
        snprintf_s$(OBJ)\
        snprintfw_s$(OBJ)\
        sopen$(OBJ)    \
        splitpth$(OBJ) \
        sprintf$(OBJ)  \
        sprintf_s$(OBJ)\
        sprintfw$(OBJ) \
        sprintfw_s$(OBJ)\
        sscanf$(OBJ)   \
        sscanfw$(OBJ)  \
        sscanf_s$(OBJ) \
        sscanfw_s$(OBJ)\
        stat$(OBJ)     \
        stati64$(OBJ)  \
        streams$(OBJ)  \
        swprintf_$(OBJ)\
        tell$(OBJ)     \
        telli64$(OBJ)  \
        tempnam$(OBJ)  \
        tmpfile$(OBJ)  \
        tmpfile_s$(OBJ)\
        tmpnam$(OBJ)   \
        tmpnam_s$(OBJ) \
        ungetc$(OBJ)   \
        ungetwc$(OBJ)  \
        unlink$(OBJ)   \
        utime$(OBJ)    \
        vfprintf$(OBJ) \
        vfprntfw$(OBJ) \
        vfprintf_s$(OBJ)\
        vfprintfw_s$(OBJ)\
        vfscanf$(OBJ)  \
        vfscanfw$(OBJ) \
        vfscanf_s$(OBJ)\
        vfscanfw_s$(OBJ)\
        vprinter$(OBJ) \
        vprintf$(OBJ)  \
        vprintfw$(OBJ) \
        vprintf_s$(OBJ)\
        vprintfw_s$(OBJ)\
        vprintrw$(OBJ) \
        vscanf$(OBJ)   \
        vscanfw$(OBJ)  \
        vscanf_s$(OBJ) \
        vscanfw_s$(OBJ)\
        wchdir$(OBJ)   \
        wchmod$(OBJ)   \
        wcreat$(OBJ)   \
        wdirect$(OBJ)  \
        wdscreat$(OBJ) \
        wffile$(OBJ)   \
        wffile64$(OBJ) \
        wfndfrst$(OBJ) \
        wfnmerge$(OBJ) \
        wfopen$(OBJ)   \
        wfopen_s$(OBJ) \
        wfreopen$(OBJ) \
        wfreopen_s$(OBJ) \
        wfullpth$(OBJ) \
        wgetcurd$(OBJ) \
        wgetcwd$(OBJ)  \
        wgetdcwd$(OBJ) \
        wiomacro$(OBJ) \
        wmakepth$(OBJ) \
        wmkdir$(OBJ)   \
        wmkname$(OBJ)  \
        wmktemp$(OBJ)  \
        wperror$(OBJ)  \
        wrename$(OBJ)  \
        wrmdir$(OBJ)   \
        wsopen$(OBJ)   \
        wspltpth$(OBJ) \
        wstat$(OBJ)    \
        wstati64$(OBJ) \
        wtempnam$(OBJ) \
        wtmpnam$(OBJ)  \
        wtmpnam_s$(OBJ)\
        wunlink$(OBJ)  \
        wutime$(OBJ)   \
        xfclose$(OBJ)  \
        xfflush$(OBJ)

!if !$d(WIN64)
    # ASM files
    OBJS = $(OBJS)      \
	_fclosal$(OBJ) \
	_fgetchr$(OBJ) \
	_fileno$(OBJ) \
	_fputchr$(OBJ) \
	_getw$(OBJ) \
	_mkdir$(OBJ) \
	_mktemp$(OBJ) \
	_putw$(OBJ) \
	_rmdir$(OBJ) \
	_rmtmp$(OBJ) \
	_sopen$(OBJ) \
	_stat$(OBJ) \
	_tempnam$(OBJ) \
	_unlink$(OBJ) \
	_utime$(OBJ) \
	access$(OBJ) \
	chsize$(OBJ) \
	close$(OBJ) \
	dup$(OBJ) \
	dup2$(OBJ) \
	eof$(OBJ) \
	fdopen$(OBJ) \
	flushall$(OBJ) \
	fnsplit$(OBJ) \
	fstat$(OBJ) \
	ftruncat$(OBJ) \
	isatty$(OBJ) \
	lseek$(OBJ) \
	open$(OBJ) \
	read$(OBJ) \
	remove$(OBJ) \
	umask$(OBJ) \
	wopen$(OBJ) \
	write$(OBJ)
!else
    # NASM files
    NASMOBJS = \
	_stat$(OBJ) \
	_unlink$(OBJ) \
	close$(OBJ) \
	dup$(OBJ) \
	dup2$(OBJ) \
	fstat$(OBJ) \
	isatty$(OBJ) \
	open$(OBJ) \
	read$(OBJ) \
	remove$(OBJ) \
	_wremove$(OBJ) \
	write$(OBJ)

    OBJS = $(OBJS) $(NASMOBJS)

    IMPOBJS = $(NASMOBJS)

!if $d(DLLX)
    IMPOBJS = $(IMPOBJS) \
	imp_remove$(OBJ) \
	imp_stat$(OBJ)
!endif

    # C stubs
    OBJS = $(OBJS)      \
	io_stub64$(OBJ) \
	c_eof$(OBJ)     \
	$(EMPTY)
!endif

!if $d(MT)
    OBJS = $(OBJS)      \
           fgetc$(OBJ)    \
           fgetwc$(OBJ)   \
           fputc$(OBJ)    \
           fputwc$(OBJ)
!endif

!if $d(DLL)
    IMPOBJS = $(IMPOBJS)     \
              fmode$(OBJ)    \
              cfinfo$(OBJ)
!else
    MISC    = $(LIBDIR)\fileinfo$(OBJ)
!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
$(LIBDIR)\fileinfo$(OBJ) : fileinfo$(OBJ)
    copy $** $(LIBDIR)\$.

# Special rules for wide-char versions so that they depend on the dual-mode
# source code in the non-w files

__wopen$(OBJ)  : __open.c
__wread$(OBJ)  : __read.c
_waccess$(OBJ) : __access.c
_wchmod$(OBJ)  : _chmod.c
_wcreat$(OBJ)  : _creat.c
_wfdopen$(OBJ) : _fdopen.c
_wfsopen$(OBJ) : _fsopen.c
_wopen$(OBJ)   : _open.c
_wpopen$(OBJ)  : _popen.c
_wunlnk$(OBJ)  : unlink.c
fgetwc$(OBJ)   : fgetc.c
fgetwchr$(OBJ) : fgetchar.c
fgetws$(OBJ)   : fgets.c
fprintfw$(OBJ) : fprintf.c
fprintfw_s$(OBJ) : fprintf_s.c
fputnw$(OBJ)   : fputn.c
fputwc$(OBJ)   : fputc.c
fputwchr$(OBJ) : fputchar.c
fputws$(OBJ)   : fputs.c
fscanfw$(OBJ)  : fscanf.c
fscanfw_s$(OBJ): fscanf_s.c
getws$(OBJ)    : gets.c
getws_s$(OBJ)  : gets_s.c
lgetwc$(OBJ)   : lgetc.c
lputwc$(OBJ)   : lputc.c
printfw$(OBJ)  : printf.c
printfw_s$(OBJ): printf_s.c
putws$(OBJ)    : puts.c
scanfw$(OBJ)   : scanf.c
scanfw_s$(OBJ) : scanf_s.c
scannerw$(OBJ) : scanner.c
scannerw_s$(OBJ): scanner.c
scanner_s$(OBJ) : scanner.c
scannerw_s$(OBJ): scanner.c
scanwtol$(OBJ) : scantol.c
scn2i64w$(OBJ) : scn2i64.c
sprintfw$(OBJ) : sprintf.c
sprintfw_s$(OBJ): sprintf_s.c
snprntfw$(OBJ) : snprntf.c
snprintfw_s$(OBJ): snprintf_s.c
sscanfw$(OBJ)  : sscanf.c
sscanfw_s$(OBJ): sscanf_s.c
ungetwc$(OBJ)  : ungetc.c
vfprntfw$(OBJ) : vfprintf.c
vfprintfw_s$(OBJ): vfprintf_s.c
vfscanfw$(OBJ) : vfscanf.c
vfscanfw_s$(OBJ): vfscanf_s.c
vprintfw$(OBJ) : vprintf.c
vprintfw_s$(OBJ): vprintf_s.c
vprintrw$(OBJ) : vprinter.c
vscanfw$(OBJ)  : vscanf.c
vscanfw_s$(OBJ): vscanf_s.c
wchdir$(OBJ)   : chdir.c
wchmod$(OBJ)   : chmod.c
wcreat$(OBJ)   : creat.c
wdscreat$(OBJ) : doscreat.c
wfndfrst$(OBJ) : findfrst.c
wfnmerge$(OBJ) : fnmerge.c
wfopen$(OBJ)   : fopen.c
wfopen_s$(OBJ) : fopen_s.c
wfreopen$(OBJ) : freopen.c
wfreopen_s$(OBJ) : freopen_s.c
wfullpth$(OBJ) : fullpath.c
wgetcurd$(OBJ) : getcurdi.c
wgetcwd$(OBJ)  : getcwd.c
wgetdcwd$(OBJ) : getdcwd.c
wiomacro$(OBJ) : iomacro.c
wmakepth$(OBJ) : makepath.c
wmkdir$(OBJ)   : mkdir.c
wmkname$(OBJ)  : mkname.c
wmktemp$(OBJ)  : mktemp.c
wperror$(OBJ)  : perror.c
wrename$(OBJ)  : rename.c
wrmdir$(OBJ)   : rmdir.c
wspltpth$(OBJ) : splitpth.c
wstat$(OBJ)    : stat.c
wtempnam$(OBJ) : tempnam.c
wtmpnam$(OBJ)  : tmpnam.c
wtmpnam_s$(OBJ): tmpnam_s.c
wutime$(OBJ)   : utime.c
wffile$(OBJ)   : ffile.c
ffile64$(OBJ)  : ffile.c
wffile64$(OBJ) : ffile.c

fseeki64$(OBJ) : fseek.c
fseeko$(OBJ)   : fseek.c
