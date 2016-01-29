{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit vclimp;

interface
{$I dc.inc}

{
  Files 
    *_D6.pas
    *_D5.pas
    *_D4.pas
    *_D3.pas
    *_C3.pas
    *_C4.pas
    *_C5.pas
  weren't included in registered version of Dream Scripter. You can get them
  automatically with \UTILS\UNITIMPORTER program or download any of the trial
  versions and extract these files from there. Alternatively you can comment
  out impreg from uses of main form of Instant Report, so Instant will be
  compiled without these "import" files.
}

{$IFNDEF SKIPVCLREG}

uses
win_imp,

{$IFDEF D7}
inifiles_D7,
types_D7,
variants_D7,
actnlist_D7,
buttons_D7,
checklst_D7,
classes_D7,
clipbrd_D7,
comctrls_D7,
//comobj_D7,
controls_D7,
{$IFDEF PRODELPHI}
db_D7,
dbactns_D7,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
adodb_D7,
dbclient_D7,
mconnect_D7,
miditems_D7,
midprod_D7,
sconnect_D7,
provider_D7,
ObjBrkr_D7,
MIDASCon_D7,
{$ENDIF}
dbcommon_D7,
dbctrls_D7,
dbgrids_D7,
dblookup_D7,
dbtables_D7,
{$ENDIF}
dialogs_D7,
extctrls_D7,
extdlgs_D7,
filectrl_D7,
forms_D7,
//ctlpanel_D7,
graphics_D7,
grids_D7,
imglist_D7,
mask_D7,
{$IFDEF PRODELPHI}
math_D7,
{$ENDIF}
menus_D7,
messages_D7,
mplayer_D7,
{$IFDEF USEOLECTNRS}
olectnrs_D7,
{$ENDIF}
olectrls_D7,
outline_D7,
printers_D7,
registry_D7,
//richedit_D7,
stdactns_D7,
stdctrls_D7,
system_D7,
sysutils_D7,
tabnotbk_D7,
tabs_D7,
toolwin_D7;

{$ELSE}


{------------------------------}

{$IFDEF CPB6}
inifiles_c6,
actnlist_c6,
buttons_c6,
checklst_c6,
classes_c6,
clipbrd_c6,
comctrls_c6,
//comobj_c6,
controls_c6,
{$IFDEF PRODELPHI}
db_c6,
dbactns_c6,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
adodb_c6,
dbclient_c6,
mconnect_c6,
miditems_c6,
midprod_c6,
sconnect_c6,
provider_c6,
ObjBrkr_c6,
MIDASCon_c6,
{$ENDIF}
dbcommon_c6,
dbctrls_c6,
dbgrids_c6,
dblookup_c6,
dbtables_c6,
{$ENDIF}
dialogs_c6,
extctrls_c6,
extdlgs_c6,
filectrl_c6,
forms_c6,
//ctlpanel_c6,
graphics_c6,
grids_c6,
imglist_c6,
mask_c6,
{$IFDEF PRODELPHI}
math_c6,
{$ENDIF}
menus_c6,
messages_c6,
mplayer_c6,
{$IFDEF USEOLECTNRS}
olectnrs_c6,
{$ENDIF}
olectrls_c6,
outline_c6,
printers_c6,
registry_c6,
//richedit_c6,
stdactns_c6,
stdctrls_c6,
system_c6,
sysutils_c6,
tabnotbk_c6,
tabs_c6,
toolwin_c6;

{$ELSE}
{------------------------------}

{$IFDEF D6}
inifiles_d6,
types_d6,
variants_d6,
actnlist_D6,
buttons_D6,
checklst_D6,
classes_D6,
clipbrd_D6,
comctrls_D6,
//comobj_D6,
controls_D6,
{$IFDEF PRODELPHI}
db_D6,
dbactns_D6,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
adodb_D6,
dbclient_D6,
mconnect_D6,
miditems_D6,
midprod_D6,
sconnect_D6,
provider_D6,
ObjBrkr_D6,
MIDASCon_D6,
{$ENDIF}
dbcommon_D6,
dbctrls_D6,
dbgrids_D6,
dblookup_D6,
dbtables_D6,
{$ENDIF}
dialogs_D6,
extctrls_D6,
extdlgs_D6,
filectrl_D6,
forms_D6,
//ctlpanel_D6,
graphics_D6,
grids_D6,
imglist_D6,
mask_D6,
{$IFDEF PRODELPHI}
math_D6,
{$ENDIF}
menus_D6,
messages_D6,
mplayer_D6,
{$IFDEF USEOLECTNRS}
olectnrs_D6,
{$ENDIF}
olectrls_D6,
outline_D6,
printers_D6,
registry_D6,
//richedit_D6,
stdactns_D6,
stdctrls_D6,
system_D6,
sysutils_D6,
tabnotbk_D6,
tabs_D6,
toolwin_D6;

{$ELSE}

{------------------------------}

{$IFDEF CPB5}

inifiles_c5,
actnlist_c5,
buttons_c5,
checklst_c5,
classes_c5,
clipbrd_c5,
comctrls_c5,
//comobj_c5,
controls_c5,
{$IFDEF PRODELPHI}
db_c5,
dbactns_c5,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
adodb_c5,
dbclient_c5,
mconnect_c5,
miditems_c5,
midprod_c5,
sconnect_c5,
provider_c5,
ObjBrkr_c5,
MIDASCon_c5,
{$ENDIF}
dbcommon_c5,
dbctrls_c5,
dbgrids_c5,
dblookup_c5,
dbtables_c5,
{$ENDIF}
dialogs_c5,
extctrls_c5,
extdlgs_c5,
filectrl_c5,
forms_c5,
//ctlpanel_c5,
graphics_c5,
grids_c5,
imglist_c5,
mask_c5,
{$IFDEF PRODELPHI}
math_c5,
{$ENDIF}
menus_c5,
messages_c5,
mplayer_c5,
{$IFDEF USEOLECTNRS}
olectnrs_c5,
{$ENDIF}
olectrls_c5,
outline_c5,
printers_c5,
registry_c5,
//richedit_c5,
stdactns_c5,
stdctrls_c5,
system_c5,
sysutils_c5,
tabnotbk_c5,
tabs_c5,
toolwin_c5;

{$ELSE}

{------------------------------}

{$IFDEF D5}

inifiles_d5,
actnlist_d5,
buttons_d5,
checklst_d5,
classes_d5,
clipbrd_d5,
comctrls_d5,
comobj_d5,
controls_d5,
{$IFDEF PRODELPHI}
db_d5,
dbactns_d5,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
adodb_d5,
dbclient_d5,
mconnect_d5,
miditems_d5,
midprod_d5,
sconnect_d5,
provider_d5,
ObjBrkr_d5,
MIDASCon_d5,
{$ENDIF}
dbcommon_d5,
dbctrls_d5,
dbgrids_d5,
dblookup_d5,
dbtables_d5,
{$ENDIF}
dialogs_d5,
extctrls_d5,
extdlgs_d5,
filectrl_d5,
forms_d5,
//ctlpanel_d5,
graphics_d5,
grids_d5,
imglist_d5,
mask_d5,
{$IFDEF PRODELPHI}
math_d5,
{$ENDIF}
menus_d5,
messages_d5,
mplayer_d5,
{$IFDEF USEOLECTNRS}
olectnrs_d5,
{$ENDIF}
olectrls_d5,
outline_d5,
printers_d5,
registry_d5,
richedit_d5,
stdactns_d5,
stdctrls_d5,
system_d5,
sysutils_d5,
tabnotbk_d5,
tabs_d5,
toolwin_d5;

{$ELSE}

{------------------------------}

{$IFDEF CPB4}
inifiles_c4,
actnlist_c4,
buttons_c4,
checklst_c4,
classes_c4,
clipbrd_c4,
comctrls_c4,
//comobj_c4,
controls_c4,
{$IFDEF PRODELPHI}
db_c4,
dbactns_c4,
//dbcgrids_c4,
{$IFDEF CSDELPHI}
dbclient_c4,
bdeprov_c4,
mconnect_c4,
sconnect_c4,
provider_c4,
ObjBrkr_c4,
MIDASCon_c4,
{$ENDIF}
dbcommon_c4,
dbctrls_c4,
dbgrids_c4,
dblookup_c4,
dbtables_c4,
{$ENDIF}
dialogs_c4,
extctrls_c4,
extdlgs_c4,
filectrl_c4,
forms_c4,
graphics_c4,
grids_c4,
imglist_c4,
mask_c4,
{$IFDEF PRODELPHI}
math_c4,
{$ENDIF}
menus_c4,
messages_c4,
mplayer_c4,
{$IFDEF USEOLECTNRS}
olectnrs_c4,
{$ENDIF}
olectrls_c4,
outline_c4,
printers_c4,
registry_c4,
richedit_c4,
stdactns_c4,
stdctrls_c4,
system_c4,
sysutils_c4,
tabnotbk_c4,
tabs_c4,
toolwin_c4;

{$ELSE}

{------------------------------}

{$IFDEF D4}
inifiles_d4,
actnlist_d4,
buttons_d4,
checklst_d4,
classes_d4,
clipbrd_d4,
comctrls_d4,
comobj_d4,
controls_d4,
{$IFDEF PRODELPHI}
db_d4,
dbactns_d4,
//dbcgrids_d4,
{$IFDEF CSDELPHI}
dbclient_d4,
bdeprov_d4,
mconnect_d4,
sconnect_d4,
provider_d4,
ObjBrkr_d4,
MIDASCon_d4,
{$ENDIF}
dbcommon_d4,
dbctrls_d4,
dbgrids_d4,
dblookup_d4,
dbtables_d4,
{$ENDIF}
dialogs_d4,
extctrls_d4,
extdlgs_d4,
filectrl_d4,
forms_d4,
graphics_d4,
grids_d4,
imglist_d4,
mask_d4,
{$IFDEF PRODELPHI}
math_d4,
{$ENDIF}
menus_d4,
messages_d4,
mplayer_d4,
{$IFDEF USEOLECTNRS}
olectnrs_d4,
{$ENDIF}
olectrls_d4,
outline_d4,
printers_d4,
registry_d4,
richedit_d4,
stdactns_d4,
stdctrls_d4,
system_d4,
sysutils_d4,
tabnotbk_d4,
tabs_d4,
toolwin_d4;

{$ELSE}

{------------------------------}

{$IFDEF CPB3}
inifiles_c3,
buttons_c3,
checklst_c3,
classes_c3,
clipbrd_c3,
comctrls_c3,
//comobj_c3,
controls_c3,
{$IFDEF PRODELPHI}
db_c3,
//dbcgrids_c3,
{$IFDEF CSDELPHI}
dbclient_c3,
bdeprov_c3,
{$ENDIF}
dbcommon_c3,
dbctrls_c3,
dbgrids_c3,
dblookup_c3,
dbtables_c3,
{$ENDIF}
dialogs_c3,
extctrls_c3,
extdlgs_c3,
filectrl_c3,
forms_c3,
graphics_c3,
grids_c3,
mask_c3,
{$IFDEF PRODELPHI}
math_c3,
{$ENDIF}
menus_c3,
messages_c3,
mplayer_c3,
{$IFDEF USEOLECTNRS}
olectnrs_c3,
{$ENDIF}
olectrls_c3,
outline_c3,
printers_c3,
registry_c3,
richedit_c3,
stdctrls_c3,
system_c3,
sysutils_c3,
tabnotbk_c3,
tabs_c3,
toolwin_c3;

{$ELSE}

{------------------------------}

{$IFDEF D3}
inifiles_d3,
buttons_d3,
checklst_d3,
classes_d3,
clipbrd_d3,
comctrls_d3,
comobj_d3,
controls_d3,
{$IFDEF PRODELPHI}
db_d3,
//dbcgrids_d3,
{$IFDEF CSDELPHI}
DBCLIENT_d3,
bdeprov_d3,
{$ENDIF}
dbcommon_d3,
dbctrls_d3,
dbgrids_d3,
dblookup_d3,
dbtables_d3,
{$ENDIF}
dialogs_d3,
extctrls_d3,
extdlgs_d3,
filectrl_d3,
forms_d3,
graphics_d3,
grids_d3,
mask_d3,
{$IFDEF PRODELPHI}
math_d3,
{$ENDIF}
menus_d3,
messages_d3,
mplayer_d3,
{$IFDEF USEOLECTNRS}
olectnrs_d3,
{$ENDIF}
olectrls_d3,
outline_d3,
printers_d3,
registry_d3,
richedit_d3,
stdctrls_d3,
system_d3,
sysutils_d3,
tabnotbk_d3,
tabs_d3;
{$ELSE}

{------------------------------}

{$IFDEF CPB1}
inifiles_c1,
BUTTONS_c1,
CLASSES_c1,
CLIPBRD_c1,
COMCTRLS_c1,
CONTROLS_c1,
{$IFDEF PRODELPHI}
DB_c1,
//DBCGRIDS_c1,
DBCTRLS_c1,
DBGRIDS_c1,
DBLOOKUP_c1,
DBTABLES_c1,
{$ENDIF}
messages_c1,
mplayer_c1,
DIALOGS_c1,
EXTCTRLS_c1,
FILECTRL_c1,
FORMS_c1,
GRAPHICS_c1,
GRIDS_c1,
MASK_c1,
//MATH_c1,
MENUS_c1,
OLEAUTO_c1,
{$IFDEF USEOLECTNRS}
OLECTNRS_c1,
{$ENDIF}
OLECTRLS_c1,
OUTLINE_c1,
PRINTERS_c1,
RICHEDIT_c1,
STDCTRLS_c1,
SYSTEM_c1,
SYSUTILS_c1,
TABNOTBK_c1,
TABS_c1;

{$ELSE}

{------------------------------}

inifiles_d2,
buttons_d2,
classes_d2,
clipbrd_d2,
comctrls_d2,
controls_d2,
{$IFDEF PRODELPHI}
db_d2,
//dbcgrids_d2,
dbctrls_d2,
dbgrids_d2,
dblookup_d2,
dbtables_d2,
{$ENDIF}
dialogs_d2,
extctrls_d2,
filectrl_d2,
forms_d2,
graphics_d2,
grids_d2,
mask_d2,
//math_d2,
menus_d2,
messages_d2,
mplayer_d2,
oleauto_d2,
{$IFDEF USEOLECTNRS}
olectnrs_d2,
{$ENDIF}
olectrls_d2,
outline_d2,
printers_d2,
registry_d2,
richedit_d2,
stdctrls_d2,
system_d2,
sysutils_d2,
tabnotbk_d2,
tabs_d2;

{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$ENDIF}
{$ENDIF}
{$ENDIF}

implementation

end.
