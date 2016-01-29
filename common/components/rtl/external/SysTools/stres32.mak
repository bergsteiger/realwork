#-------------------------------------------------------------------------
#  STRES.MAK
#-------------------------------------------------------------------------
#  Make file used to build resource file portions of SysTools
#
#  This make file is designed to be used only with Delphi's MAKE utility.
#
#      MAKE -fSTRES32.MAK
#
#  at the DOS command line or in response to Window's File|Run dialog.
#
#-------------------------------------------------------------------------
#  Macros
#-------------------------------------------------------------------------

#  Specify the location of the resource compiler

brc="c:\borland\delphi 3\bin\brcc32.exe" -w32 -fo$&.r32
srmc=d:\srmgr\srmc.exe -32 -fo$&.s32

#-------------------------------------------------------------------------
#  Implicit rules
#-------------------------------------------------------------------------

.str.s32:
         $(srmc) $<
.rc.r32:
         $(brc) $<


#-------------------------------------------------------------------------
#  Explicit rules
#-------------------------------------------------------------------------

res32: stconst.s32 stconst.r32 streg.r32 stregdb.r32