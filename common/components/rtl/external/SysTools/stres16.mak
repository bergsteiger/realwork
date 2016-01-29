#-------------------------------------------------------------------------
#  STRES.MAK
#-------------------------------------------------------------------------
#  Make file used to build resource file portions of SysTools
#
#  This make file is designed to be used only with Delphi's MAKE utility.
#
#      MAKE -fSTRES16.MAK
#
#  at the DOS command line or in response to Window's File|Run dialog.
#
#-------------------------------------------------------------------------
#  Macros
#-------------------------------------------------------------------------

#  Specify the location of the resource compiler

brc=c:\borland\delphi\bin\brcc.exe -31 -dwin16 -fo$&.r16
srmc=d:\srmgr\srmc.exe -16 -fo$&.s16

#-------------------------------------------------------------------------
#  Implicit rules
#-------------------------------------------------------------------------

.str.s16:
         $(srmc) $<
.rc.r16:
         $(brc) $<


#-------------------------------------------------------------------------
#  Explicit rules
#-------------------------------------------------------------------------

res16: stconst.s16 stconst.r16 streg.r16 stregdb.r16