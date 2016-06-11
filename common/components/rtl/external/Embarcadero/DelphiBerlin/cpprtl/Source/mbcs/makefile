#############################################################################
#
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
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
    OBJS =               \
            mbbis$(OBJ)    \
            mbbtype$(OBJ)  \
            mbccmp$(OBJ)   \
            mbccpy$(OBJ)   \
            mbclen$(OBJ)   \
            mbctype$(OBJ)  \
            mbisalp$(OBJ)  \
            mbisblank$(OBJ)  \
            mbisdgt$(OBJ)  \
            mbishira$(OBJ) \
            mbiskata$(OBJ) \
            mbisl0$(OBJ)   \
            mbisl1$(OBJ)   \
            mbisl2$(OBJ)   \
            mbislgl$(OBJ)  \
            mbislwr$(OBJ)  \
            mbisprn$(OBJ)  \
            mbisspc$(OBJ)  \
            mbissym$(OBJ)  \
            mbisupr$(OBJ)  \
            mbjisjms$(OBJ) \
            mbjmsjis$(OBJ) \
            mbsbtype$(OBJ) \
            mbschr$(OBJ)   \
            mbscmp$(OBJ)   \
            mbscspn$(OBJ)  \
            mbsdec$(OBJ)   \
            mbsicmp$(OBJ)  \
            mbsinc$(OBJ)   \
            mbsisle$(OBJ)  \
            mbsistr$(OBJ)  \
            mbslen$(OBJ)   \
            mbslwr$(OBJ)   \
            mbsnbcat$(OBJ) \
            mbsnbcmp$(OBJ) \
            mbsnbcnt$(OBJ) \
            mbsnbcpy$(OBJ) \
            mbsnbicm$(OBJ) \
            mbsnbset$(OBJ) \
            mbsncat$(OBJ)  \
            mbsnccnt$(OBJ) \
            mbsncmp$(OBJ)  \
            mbsncpy$(OBJ)  \
            mbsnextc$(OBJ) \
            mbsnicmp$(OBJ) \
            mbsninc$(OBJ)  \
            mbsnset$(OBJ)  \
            mbspbrk$(OBJ)  \
            mbsrchr$(OBJ)  \
            mbsrev$(OBJ)   \
            mbsset$(OBJ)   \
            mbsspn$(OBJ)   \
            mbsspnp$(OBJ)  \
            mbsstr$(OBJ)   \
            mbstok$(OBJ)   \
	    mbstrlen$(OBJ) \
            mbsupr$(OBJ)   \
            mbtohira$(OBJ) \
            mbtokata$(OBJ) \
            mbtolwr$(OBJ)  \
            mbtomb$(OBJ)   \
            mbtoupr$(OBJ)  \
            mbscoll$(OBJ)  \
            mbsnicol$(OBJ) \
            mbsncoll$(OBJ) \
            mbsicoll$(OBJ) \
            mbsnbcol$(OBJ) \
            mbsnbico$(OBJ) \
            ismbalnm$(OBJ) \
            ismbgrph$(OBJ) \
            ismbpunc$(OBJ) \
            mbscat$(OBJ)   \
            mbscpy$(OBJ)   \
            mbsdup$(OBJ)   \
            tthunks$(OBJ)

#############################################################################
# Configure the environment apprpriately.                                   #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

