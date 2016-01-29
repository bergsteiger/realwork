#-------------------------------------------------------------------------
#  ORPHEUS.MAK
#-------------------------------------------------------------------------
#  Make file used to build Orpheus
#
#  This make file is designed to be used only with Borland's MAKE utility.
#
#      MAKE -fORPHEUS.MAK [optional parameters]
#
#  at the DOS command line or in response to Window's File|Run dialog.
#

#-------------------------------------------------------------------------
#  Compiler choice
#-------------------------------------------------------------------------

# Define only one of the following to by uncommenting the appropriate line
# or undefine all and state the define as part of the make command line

Delphi1=1
#Delphi2=1
#Delphi3=1

#set to the current version (for package naming)
ver=214

#-------------------------------------------------------------------------
#  Macros
#-------------------------------------------------------------------------

# Path to compiler
dcc1=e:\borland\delphi\bin\dcc.exe
dcc2=e:\borland\delphi~1.0\bin\dcc32.exe
dcc3=e:\borland\delphi~1\bin\dcc32.exe
#dcc1=d:\delphi\bin\dcc.exe
#dcc2=d:\progra~1\borland\delphi~1.0\bin\dcc32.exe
#dcc3=d:\progra~1\borland\delphi~1\bin\dcc32.exe

opts=/M /$$D- /$$L- /L

# Path to resource compiler
brc1=e:\borland\delphi\bin\brcc.exe
brc2=e:\borland\delphi~1.0\bin\brcc32.exe
brc3=e:\borland\delphi~1\bin\brcc32.exe
srmgr=d:\srmgr\srmc.exe
#brc1=d:\delphi\bin\brcc.exe
#brc2=d:\progra~1\borland\delphi~1.0\bin\brcc32.exe
#brc3=d:\progra~1\borland\delphi~1\bin\brcc32.exe
#srmgr=d:\srmgr\srmc.exe

!if $d(Delphi1)
  dcc=$(dcc1) $(opts)
  brc=$(brc1) -31 -dwin16 -fo$&.r16
  res=r16
  srmc=$(srmgr) -16 -fo$&.s16
  srm=s16
!endif

!if $d(Delphi2)
  dcc=$(dcc2) $(opts)
  brc=$(brc2) -w32 -fo$&.r32
  res=r32
  srmc=$(srmgr) -32 -fo$&.s32
  srm=s32
!endif

!if $d(Delphi3)
  dcc=$(dcc3) $(opts)
  brc=$(brc3) -w32 -fo$&.r32
  res=r32
  srmc=$(srmgr) -32 -fo$&.s32
  srm=s32
!endif


#-------------------------------------------------------------------------
#  Implicit rules
#-------------------------------------------------------------------------

.pas.exe:
        $(dcc) $<

.dpr.exe:
        $(dcc) $<

.pas.dcu:
        $(dcc) $<

.pas.dll:
        $(dcc) $<

.dpr.dll:
        $(dcc) $<

.dpk.dcp:
        $(dcc) $<

.dpk.dpl:
        $(dcc) $<

.rc.$(res):
        $(brc) $<

.str.$(srm):
        $(srmc) $<

#-------------------------------------------------------------------------
#  Explicit rules
#-------------------------------------------------------------------------

!if $d(Delphi3)
allorph   : orph orphtb orphdb orphres orphex orphdemo orphpacks
!else
allorph   : orph orphtb orphdb orphres orphex orphdemo
!endif

orph      : ovcreg.dcu orphres ovc.inc ovcabtn.dcu ovcae.dcu ovcaepe.dcu \
            ovcbtnhd.dcu ovccal.dcu ovccaret.dcu ovccklb.dcu ovccmd.dcu \
            ovccmdp0.dcu ovccmdp1.dcu ovccolor.dcu ovcconst.dcu ovcdata.dcu \
            ovcdt.dcu ovcedit.dcu ovceditn.dcu ovceditp.dcu ovceditu.dcu \
            ovcef.dcu ovcefpe.dcu ovcexcpt.dcu ovcfnpe.dcu ovcfxfnt.dcu \
            ovcfxfpe.dcu ovchelp.dcu ovcintl.dcu ovciseb.dcu ovcislb.dcu \
            ovcmeter.dcu ovcmisc.dcu ovcnbk.dcu ovcnbkp0.dcu ovcnbkp1.dcu \
            ovcnf.dcu ovcnfpe.dcu ovcpb.dcu ovcpf.dcu ovcpfpe.dcu ovcplb.dcu \
            ovcbase.dcu ovcrlbl.dcu ovcsc.dcu ovcsf.dcu ovcsfpe.dcu \
            ovcsplit.dcu ovcstr.dcu ovctabs.inc ovctimer.dcu ovcuser.dcu \
            ovcvalid.dcu ovcver.dcu ovcviewr.dcu ovcvlb.dcu ovcwebp0.dcu \
            ovcxfer.dcu ovcxfrc0.dcu ovcxfrc1.dcu stdate.dcu

orphtb    : orph ovcregtb.dcu ovcspary.dcu ovctable.dcu ovctbclr.dcu \
            ovctbcls.dcu ovctbpe1.dcu ovctbpe2.dcu ovctbrws.dcu \
            ovctcary.dcu ovctcbef.dcu ovctcbmp.dcu ovctcbox.dcu \
            ovctccbx.dcu ovctcedt.dcu ovctcell.dcu ovctcgly.dcu \
            ovctchdr.dcu ovctcico.dcu ovctcmmn.dcu ovctcnum.dcu \
            ovctcpe.dcu ovctcpic.dcu ovctcsim.dcu ovctcstr.dcu \
            ovctgpns.dcu ovctgres.dcu ovctsell.dcu

orphdb    : orph ovcregdb.dcu ovcdbae.dcu ovcdbae0.dcu ovcdbae1.dcu \
            ovcdbcal.dcu ovcdbcl.dcu ovcdbdlb.dcu ovcdbed.dcu ovcdbidx.dcu \
            ovcdbise.dcu ovcdbnf.dcu ovcdbpf.dcu ovcdbplb.dcu ovcdbsf.dcu \
            ovcdbtb0.dcu ovcdbtb1.dcu ovcdbtbl.dcu ovcdbae3.dcu


!if $d(Delphi3)
orphres   : ovcconst.$(srm) ovcbase.$(res) ovcconst.$(res) ovcreg.$(res) \
            ovcregdb.$(res) ovcregtb.$(res) ovctable.$(res)
!else
orphres   : ovcconst.$(srm) ovcbase.$(res) ovcconst.$(res) ovcreg.$(res) \
            ovcregdb.$(res) ovcregtb.$(res) ovctable.$(res)
!endif

#!!!
orphex    : orph orphtb orphdb

#!!!
orphdemo  : orph orphtb orphdb

!if $d(Delphi3)
orphpacks : orph orphdb orphres \
            tor$(ver)_r.dpl tor$(ver)_r.dcp \
            tor$(ver)_d.dpl tor$(ver)_d.dcp \
            tor$(ver)br.dpl tor$(ver)br.dcp \
            tor$(ver)bd.dpl tor$(ver)bd.dcp
!endif