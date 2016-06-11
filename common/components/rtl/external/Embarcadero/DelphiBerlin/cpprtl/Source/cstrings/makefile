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
# $Revision: 34726 $                                                                #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS = \
	blocksoverlap$(OBJ)\
        memccpy$(OBJ)  \
        memcpy_s$(OBJ) \
        memicmp$(OBJ)  \
        memmove_s$(OBJ)\
        strcat_s$(OBJ) \
        strcpy_s$(OBJ) \
        strcspn$(OBJ)  \
        strdup$(OBJ)   \
        strerror$(OBJ) \
        strerror_s$(OBJ)\
        stricmp$(OBJ)  \
        strncat_s$(OBJ)\
        strncpy$(OBJ)  \
        strncpy_s$(OBJ)\
        strnicmp$(OBJ) \
        strnlen_s$(OBJ)\
        strnset$(OBJ)  \
        strpbrk$(OBJ)  \
        strrchr$(OBJ)  \
        strrev$(OBJ)   \
        strset$(OBJ)   \
        strspn$(OBJ)   \
        strstr$(OBJ)   \
        strtok$(OBJ)   \
        strtok_s$(OBJ) \
        wcscat$(OBJ)   \
        wcscat_s$(OBJ) \
        wcscpy$(OBJ)   \
        wcscpy_s$(OBJ) \
        wcscspn$(OBJ)  \
        wcsdup$(OBJ)   \
        wcserror$(OBJ) \
        wcserror_s$(OBJ)\
        wcsicmp$(OBJ)  \
        wcslen$(OBJ)   \
        wcsncat_s$(OBJ)\
        wcsncpy$(OBJ)  \
        wcsncpy_s$(OBJ)\
        wcsnicmp$(OBJ) \
        wcsnlen_s$(OBJ)\
        wcsnset$(OBJ)  \
        wcspbrk$(OBJ)  \
        wcspcpy$(OBJ)  \
        wcsrchr$(OBJ)  \
        wcsrev$(OBJ)   \
        wcsset$(OBJ)   \
        wcsspn$(OBJ)   \
        wcsstr$(OBJ)   \
        wcstok$(OBJ)   \
        wcstok_s$(OBJ) \
        wmemcpy_s$(OBJ)\
        wmemmove_s$(OBJ)\
	$(EMPTY)

!if $d(WIN64)
OBJS = $(OBJS) \
	_wmemset$(OBJ)    \
	c_memcpy$(OBJ)    \
	c_memmove$(OBJ)   \
	c_memset$(OBJ)    \
	c_strncat$(OBJ)   \
	c_strncmp$(OBJ)   \
	c_wmemcpy$(OBJ)   \
	c_wmemmove$(OBJ)  \
	c_wmemset$(OBJ)   \
	c_wstrncat$(OBJ)  \
	c_wstrncmp$(OBJ)  \
	cpp_memchr$(OBJ)  \
	cpp_strchr$(OBJ)  \
	cpp_strpbrk$(OBJ) \
	cpp_strrchr$(OBJ) \
	cpp_strstr$(OBJ)  \
	cpp_wmemchr$(OBJ) \
	cpp_wstrchr$(OBJ) \
	stub64$(OBJ)      \
	wstub64$(OBJ)     \
	$(EMPTY)
!else
OBJS = $(OBJS) \
        __memchr$(OBJ) \
        __strchr$(OBJ) \
        __strpbr$(OBJ) \
        __strrch$(OBJ) \
        __strstr$(OBJ) \
        _stpcpy$(OBJ)  \
	c_wmemcmp$(OBJ)\
        memchr$(OBJ)   \
        memcmp$(OBJ)   \
        memcpy$(OBJ)   \
        memmove$(OBJ)  \
        memset$(OBJ)   \
        qstpcpy$(OBJ)  \
        qstrcat$(OBJ)  \
        qstrchr$(OBJ)  \
        qstrcmp$(OBJ)  \
        qstrcpy$(OBJ)  \
        stpcpy$(OBJ)   \
        strcat$(OBJ)   \
        strchr$(OBJ)   \
        strcmp$(OBJ)   \
        strcpy$(OBJ)   \
        strlen$(OBJ)   \
        strncat$(OBJ)  \
        strncmp$(OBJ)  \
        wcschr$(OBJ)   \
        wcscmp$(OBJ)   \
        wcsncat$(OBJ)  \
        wcsncmp$(OBJ)  \
        wmemchr$(OBJ)  \
        wmemcpy$(OBJ)  \
        wmemmove$(OBJ) \
        wmemset$(OBJ)  \
	$(EMPTY)

!if $d(DLL)
IMPOBJS = \
	__memchr$(OBJ) \
	__strchr$(OBJ) \
	__strpbr$(OBJ) \
	__strrch$(OBJ) \
	__strstr$(OBJ) \
	$(EMPTY)
!endif

!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

CC = $(CC) -U_MBCS

!if $d(WIN64)
c_wmemcpy$(OBJ) : c_memcpy.c
c_wmemmove$(OBJ) : c_memmove.c
c_wmemset$(OBJ) : c_memset.c
c_wstrncat$(OBJ) : c_strncat.c
c_wstrncmp$(OBJ) : c_strncmp.c
cpp_wmemchr$(OBJ) : cpp_memchr.cpp
cpp_wstrchr$(OBJ) : cpp_strchr.cpp
wstub64$(OBJ): stub64$(OBJ)
!endif

wcscat_s$(OBJ) : strcat_s.c
wcschr$(OBJ) : strchr.asm
wcscmp$(OBJ) : strcmp.asm
wcscpy_s$(OBJ) : strcpy_s.c
wcscspn$(OBJ) : strcspn.c
wcscspn$(OBJ) : strcspn.c
wcsdup$(OBJ) : strdup.c
wcserror$(OBJ): strerror.c
wcserror_s$(OBJ): strerror_s.c
wcsicmp$(OBJ) : stricmp.c
wcsicmp$(OBJ) : stricmp.c
wcsncat$(OBJ) : strncat.asm
wcsncat_s$(OBJ) : strncat_s.c
wcsncmp$(OBJ) : strncmp.asm
wcsncpy$(OBJ) : strncpy.c
wcsncpy_s$(OBJ) : strncpy_s.c
wcsnicmp$(OBJ) : strnicmp.c
wcsnlen_s$(OBJ): strnlen_s.c
wcsnset$(OBJ) : strnset.c
wcspbrk$(OBJ) : strpbrk.c
wcsrchr$(OBJ) : strrchr.c
wcsrev$(OBJ) : strrev.c
wcsset$(OBJ) : strset.c
wcsspn$(OBJ) : strspn.c
wcsstr$(OBJ) : strstr.c
wcstok$(OBJ) : strtok.c
wcstok_s$(OBJ) : strtok_s.c
wmemchr$(OBJ): memchr.asm
wmemcpy_s$(OBJ): memcpy_s.c
wmemmove_s$(OBJ): memmove_s.c
