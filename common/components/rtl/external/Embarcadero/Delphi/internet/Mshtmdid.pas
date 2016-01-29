unit Mshtmdid;

interface

uses Winapi.Windows, Winapi.ActiveX, Winapi.CommCtrl, idispids;

{ ********************************************************************* }
{ *                  Microsoft Windows                               ** }
{ *            Copyright(c) Microsoft Corp., 1996-1997               ** }
{ ********************************************************************* }

{ ;begin_internal }
{ **********************************************************************************************

  This is a distributed SDK component - do not put any #includes or other directives that rely
  upon files not dropped. If in doubt - build iedev

  If you add comments please enclose in a ;begin_internal, ;end_internal block - such as this one!

 ********************************************************************************************** }
{ ;end_internal }

{ ;begin_internal }
{$IFNDEF __COREDISP_H__}
{$DEFINE __COREDISP_H__}
{ ;end_internal }

{ ;begin_internal }

{ The following dispid must be the smallest possible dispid so that it }
{ always ends up first in our attr array. }
{ It does not need to be exposed to the outside world }
const
  DISPID_AAHEADER                     = MINLONG;           { DISPID is 0x80000000 }
  DISPID_RECALC_INFO                  = MINLONG+1; 
{ ;end_internal }


  DISPID_XOBJ_MIN                     = $80010000; 
  DISPID_XOBJ_MAX                     = $8001FFFF; 
  DISPID_XOBJ_BASE                    = DISPID_XOBJ_MIN; 
  DISPID_HTMLOBJECT                   = DISPID_XOBJ_BASE   + 500; 
  DISPID_ELEMENT                      = DISPID_HTMLOBJECT  + 500; 
  DISPID_SITE                         = DISPID_ELEMENT     + 1000; 
  DISPID_OBJECT                       = DISPID_SITE        + 1000; 
  DISPID_STYLE                        = DISPID_OBJECT      + 1000; 
  DISPID_ATTRS                        = DISPID_STYLE       + 1000; 
  DISPID_EVENTS                       = DISPID_ATTRS       + 1000; 
  DISPID_XOBJ_EXPANDO                 = DISPID_EVENTS      + 1000; 
  DISPID_XOBJ_ORDINAL                 = DISPID_XOBJ_EXPANDO+ 1000; 

{ ;begin_internal }
{ Expandos for ActiveX controls, note these are very limited compared to }
{ normal expandos on an element. }

  DISPID_ACTIVEX_EXPANDO_BASE          = DISPID_XOBJ_EXPANDO; 
  DISPID_ACTIVEX_EXPANDO_MAX           = DISPID_ACTIVEX_EXPANDO_BASE + 999; 

  DISPID_OBJECT_ORDINAL_BASE           = DISPID_XOBJ_ORDINAL; 
  DISPID_OBJECT_ORDINAL_MAX           = DISPID_OBJECT_ORDINAL_BASE + 999; 

  DISPID_COLLECTION_MIN               = 1000000; 
  DISPID_COLLECTION_MAX               = 2999999; 

{ Divide collection dispid space into "named member" half and "ordinal access" half }
{ for stylesheets collection. }
  DISPID_STYLESHEETSCOLLECTION_NAMED_BASE            = DISPID_COLLECTION_MIN; 
  DISPID_STYLESHEETSCOLLECTION_NAMED_MAX             = DISPID_COLLECTION_MIN+((DISPID_COLLECTION_MAX-DISPID_COLLECTION_MIN) div 2); 
  DISPID_STYLESHEETSCOLLECTION_ORDINAL_BASE          = DISPID_STYLESHEETSCOLLECTION_NAMED_MAX+1; 
  DISPID_STYLESHEETSCOLLECTION_ORDINAL_MAX           = DISPID_COLLECTION_MAX; 

{ DISPID range for expandos not associated with an ActiveX control }
  DISPID_EXPANDO_BASE                 = 3000000; 
  DISPID_EXPANDO_MAX                  = 3999999; 

(* H2PAS - Parameterized Macro Definition: 
#define IsStandardDispid(dispid)        (dispid <= 0) *)
(* H2PAS - Parameterized Macro Definition: 
#define IsExpandoDispid(dispid)         (DISPID_EXPANDO_BASE <= dispid && dispid <= DISPID_EXPANDO_MAX) *)

  DISPID_EVENTHOOK_SENSITIVE_BASE       = 4000000; 
  DISPID_EVENTHOOK_SENSITIVE_MAX        = 4499999; 
  DISPID_EVENTHOOK_INSENSITIVE_BASE     = 4500000; 
  DISPID_EVENTHOOK_INSENSITIVE_MAX      = 4999999; 

  DISPID_PEER_HOLDER_BASE             = 5000000;

(* H2PAS - Parameterized Macro Definition: 
#define IsPeerDispid(dispid)            (DISPID_PEER_HOLDER_BASE <= dispid) *)

{ ;end_internal }

{ ;begin_internal }

{ IE 4 dispids that no longer exist }

{ ;end_internal }

//!!  DISPID_HTMLOPTIONBUTTONELEMENTEVENTS_ONCHANGE           = DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONCHANGE;

{ ;begin_internal }

{ Standard control properties }

{ ;end_internal }

{ ;begin_internal }
{ ;QUESTION: rgardner - why do we use these names ??? }
{ ;end_internal }
  DISPID_CommonCtrl_FONTNAME            = 1; 
  DISPID_CommonCtrl_FONTSIZE            = 2; 
  DISPID_CommonCtrl_FONTBOLD            = 3; 
  DISPID_CommonCtrl_FONTITAL            = 4; 
  DISPID_CommonCtrl_FONTUNDER           = 5; 
  DISPID_CommonCtrl_FONTSTRIKE          = 6; 
  DISPID_CommonCtrl_FONTWEIGHT          = 7; 
  DISPID_CommonCtrl_FONTCHARSET         = 8; 
  DISPID_CommonCtrl_FONTSUPERSCRIPT     = 9; 
  DISPID_CommonCtrl_FONTSUBSCRIPT       = 10; 

{ Data Binding DISPID's }
  DISPID_MSDATASRCINTERFACE           = -3900; 
  DISPID_ADVISEDATASRCCHANGEEVENT     = -3901; 


{ ;begin_internal }
{ DISPID values for HTML Dialogs files per interface }
{ ;end_internal }

  DISPID_HTMLDLG                              = 25000; 
  DISPID_HTMLDLGMODEL                         = 26000; 

{ ;begin_internal }
{ DISPID values for HTML Popup files per interface }
{ ;end_internal }

  DISPID_HTMLPOPUP                            = 27000; 

{ ;begin_internal }
{ DISPID values for HTML Application files per interface }
{ ;end_internal }

  DISPID_HTMLAPP                              = 5000; 

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  Semi-standard x-object properties. }

{  These values match those used by VB and are for the benefit of controls }
{  with hard coded knowledge of VB. }

{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  STDPROPID_XOBJ_NAME                     = DISPID_XOBJ_BASE + $0; 
  STDPROPID_XOBJ_INDEX                    = DISPID_XOBJ_BASE + $1; 
{ ;begin_internal }
{ for IE3 compatibility }

  STDPROPID_IE3XOBJ_OBJECTALIGN         = DISPID_XOBJ_BASE + $1; 

{ STDPROPID_XOBJ_BASEHREF is a constant used by IE3 }
{ ;end_internal }
  STDPROPID_XOBJ_BASEHREF                 = DISPID_XOBJ_BASE + $2; 
  STDPROPID_XOBJ_LEFT                     = DISPID_XOBJ_BASE + $3; 
  STDPROPID_XOBJ_TOP                      = DISPID_XOBJ_BASE + $4; 
  STDPROPID_XOBJ_WIDTH                    = DISPID_XOBJ_BASE + $5; 
  STDPROPID_XOBJ_HEIGHT                   = DISPID_XOBJ_BASE + $6; 
  STDPROPID_XOBJ_VISIBLE                  = DISPID_XOBJ_BASE + $7; 
  STDPROPID_XOBJ_PARENT                   = DISPID_XOBJ_BASE + $8; 
  STDPROPID_XOBJ_DRAGMODE                 = DISPID_XOBJ_BASE + $9; 
  STDPROPID_XOBJ_DRAGICON                 = DISPID_XOBJ_BASE + $A; 
  STDPROPID_XOBJ_TAG                      = DISPID_XOBJ_BASE + $B; 
  STDPROPID_XOBJ_TABSTOP                  = DISPID_XOBJ_BASE + $E; 
  STDPROPID_XOBJ_TABINDEX                 = DISPID_XOBJ_BASE + $F; 
  STDPROPID_XOBJ_HELPCONTEXTID            = DISPID_XOBJ_BASE + $32; 
  STDPROPID_XOBJ_DEFAULT                  = DISPID_XOBJ_BASE + $37; 
  STDPROPID_XOBJ_CANCEL                   = DISPID_XOBJ_BASE + $38; 
  STDPROPID_XOBJ_LEFTNORUN                = DISPID_XOBJ_BASE + $39; 
  STDPROPID_XOBJ_TOPNORUN                 = DISPID_XOBJ_BASE + $3A; 
  STDPROPID_XOBJ_ALIGNPERSIST             = DISPID_XOBJ_BASE + $3C; 
  STDPROPID_XOBJ_LINKTIMEOUT              = DISPID_XOBJ_BASE + $3D; 
  STDPROPID_XOBJ_LINKTOPIC                = DISPID_XOBJ_BASE + $3E; 
  STDPROPID_XOBJ_LINKITEM                 = DISPID_XOBJ_BASE + $3F; 
  STDPROPID_XOBJ_LINKMODE                 = DISPID_XOBJ_BASE + $40; 
  STDPROPID_XOBJ_DATACHANGED              = DISPID_XOBJ_BASE + $41; 
  STDPROPID_XOBJ_DATAFIELD                = DISPID_XOBJ_BASE + $42; 
  STDPROPID_XOBJ_DATASOURCE               = DISPID_XOBJ_BASE + $43; 
  STDPROPID_XOBJ_WHATSTHISHELPID          = DISPID_XOBJ_BASE + $44; 
  STDPROPID_XOBJ_CONTROLTIPTEXT           = DISPID_XOBJ_BASE + $45; 
  STDPROPID_XOBJ_STATUSBARTEXT            = DISPID_XOBJ_BASE + $46; 
  STDPROPID_XOBJ_APPLICATION              = DISPID_XOBJ_BASE + $47; 
  STDPROPID_XOBJ_BLOCKALIGN               = DISPID_XOBJ_BASE + $48; 
  STDPROPID_XOBJ_CONTROLALIGN             = DISPID_XOBJ_BASE + $49; 
  STDPROPID_XOBJ_STYLE                    = DISPID_XOBJ_BASE + $4A; 
  STDPROPID_XOBJ_COUNT                    = DISPID_XOBJ_BASE + $4B; 
  STDPROPID_XOBJ_DISABLED                 = DISPID_XOBJ_BASE + $4C; 
  STDPROPID_XOBJ_RIGHT                    = DISPID_XOBJ_BASE + $4D; 
  STDPROPID_XOBJ_BOTTOM                   = DISPID_XOBJ_BASE + $4E; 

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  Semi-standard x-object properties. }

{  These are events that are fired for all sites }
{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  STDDISPID_XOBJ_ONBLUR                               = DISPID_XOBJ_BASE; 
  STDDISPID_XOBJ_ONFOCUS                              = DISPID_XOBJ_BASE + 1; 
  STDDISPID_XOBJ_BEFOREUPDATE                         = DISPID_XOBJ_BASE + 4; 
  STDDISPID_XOBJ_AFTERUPDATE                          = DISPID_XOBJ_BASE + 5; 
  STDDISPID_XOBJ_ONROWEXIT                            = DISPID_XOBJ_BASE + 6; 
  STDDISPID_XOBJ_ONROWENTER                           = DISPID_XOBJ_BASE + 7; 
  STDDISPID_XOBJ_ONMOUSEOVER                          = DISPID_XOBJ_BASE + 8; 
  STDDISPID_XOBJ_ONMOUSEOUT                           = DISPID_XOBJ_BASE + 9; 
  STDDISPID_XOBJ_ONHELP                               = DISPID_XOBJ_BASE + 10; 
  STDDISPID_XOBJ_ONDRAGSTART                          = DISPID_XOBJ_BASE + 11; 
  STDDISPID_XOBJ_ONSELECTSTART                        = DISPID_XOBJ_BASE + 12; 
  STDDISPID_XOBJ_ERRORUPDATE                          = DISPID_XOBJ_BASE + 13; 
  STDDISPID_XOBJ_ONDATASETCHANGED                     = DISPID_XOBJ_BASE + 14; 
  STDDISPID_XOBJ_ONDATAAVAILABLE                      = DISPID_XOBJ_BASE + 15; 
  STDDISPID_XOBJ_ONDATASETCOMPLETE                    = DISPID_XOBJ_BASE + 16; 
  STDDISPID_XOBJ_ONFILTER                             = DISPID_XOBJ_BASE + 17; 
  STDDISPID_XOBJ_ONLOSECAPTURE                        = DISPID_XOBJ_BASE + 18; 
  STDDISPID_XOBJ_ONPROPERTYCHANGE                     = DISPID_XOBJ_BASE + 19; 
  STDDISPID_XOBJ_ONDRAG                               = DISPID_XOBJ_BASE + 20; 
  STDDISPID_XOBJ_ONDRAGEND                            = DISPID_XOBJ_BASE + 21; 
  STDDISPID_XOBJ_ONDRAGENTER                          = DISPID_XOBJ_BASE + 22; 
  STDDISPID_XOBJ_ONDRAGOVER                           = DISPID_XOBJ_BASE + 23; 
  STDDISPID_XOBJ_ONDRAGLEAVE                          = DISPID_XOBJ_BASE + 24; 
  STDDISPID_XOBJ_ONDROP                               = DISPID_XOBJ_BASE + 25; 
  STDDISPID_XOBJ_ONCUT                                = DISPID_XOBJ_BASE + 26; 
  STDDISPID_XOBJ_ONCOPY                               = DISPID_XOBJ_BASE + 27; 
  STDDISPID_XOBJ_ONPASTE                              = DISPID_XOBJ_BASE + 28; 
  STDDISPID_XOBJ_ONBEFORECUT                          = DISPID_XOBJ_BASE + 29;
  STDDISPID_XOBJ_ONBEFORECOPY                         = DISPID_XOBJ_BASE + 30;
  STDDISPID_XOBJ_ONBEFOREPASTE                        = DISPID_XOBJ_BASE + 31;
  STDDISPID_XOBJ_ONROWSDELETE                         = DISPID_XOBJ_BASE + 32;
  STDDISPID_XOBJ_ONROWSINSERTED                       = DISPID_XOBJ_BASE + 33;
  STDDISPID_XOBJ_ONCELLCHANGE                         = DISPID_XOBJ_BASE + 34;

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  Base DISPIDs for each class. }

{  Object and its base classes must use ids in the reserved x-object range. }

{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  DISPID_NORMAL_FIRST                         = 1000;
  DISPID_TEXTSITE                             = DISPID_NORMAL_FIRST;
  DISPID_ANCHOR                               = DISPID_NORMAL_FIRST; 
  DISPID_BLOCK                                = DISPID_NORMAL_FIRST; 
  DISPID_BODY                                 = DISPID_TEXTSITE + 1000;
  DISPID_BR                                   = DISPID_NORMAL_FIRST; 
  DISPID_BGSOUND                              = DISPID_NORMAL_FIRST; 
  DISPID_DD                                   = DISPID_NORMAL_FIRST; 
  DISPID_DIR                                  = DISPID_NORMAL_FIRST; 
  DISPID_DIV                                  = DISPID_NORMAL_FIRST; 
  DISPID_DL                                   = DISPID_NORMAL_FIRST; 
  DISPID_DT                                   = DISPID_NORMAL_FIRST; 
  DISPID_EFONT                                = DISPID_NORMAL_FIRST; 
  DISPID_FORM                                 = DISPID_NORMAL_FIRST; 
  DISPID_HEADER                               = DISPID_NORMAL_FIRST; 
  DISPID_HEDELEMS                             = DISPID_NORMAL_FIRST; 
  DISPID_HR                                   = DISPID_NORMAL_FIRST; 
  DISPID_LABEL                                = DISPID_NORMAL_FIRST; 
  DISPID_LI                                   = DISPID_NORMAL_FIRST; 
  DISPID_IMGBASE                              = DISPID_NORMAL_FIRST; 
  DISPID_IMG                                  = DISPID_IMGBASE + 1000; 
  DISPID_INPUTIMAGE                           = DISPID_IMGBASE + 1000; 
  DISPID_INPUT                                = DISPID_TEXTSITE + 1000; 
  DISPID_INPUTTEXTBASE                        = DISPID_INPUT+1000; 
  DISPID_INPUTTEXT                            = DISPID_INPUTTEXTBASE+1000; 
  DISPID_MENU                                 = DISPID_NORMAL_FIRST; 
  DISPID_OL                                   = DISPID_NORMAL_FIRST; 
  DISPID_PARA                                 = DISPID_NORMAL_FIRST; 
  DISPID_SELECT                               = DISPID_NORMAL_FIRST; 
  DISPID_SELECTOBJ                            = DISPID_NORMAL_FIRST; 
  DISPID_TABLE                                = DISPID_NORMAL_FIRST; 

  DISPID_TEXTAREA                             = DISPID_INPUTTEXT + 1000;
  DISPID_MARQUEE                              = DISPID_TEXTAREA + 1000; 
  DISPID_RICHTEXT                             = DISPID_MARQUEE + 1000; 
  DISPID_BUTTON                               = DISPID_RICHTEXT + 1000; 
  DISPID_UL                                   = DISPID_NORMAL_FIRST; 
  DISPID_PHRASE                               = DISPID_NORMAL_FIRST; 
  DISPID_UNKNOWNPDL                           = DISPID_NORMAL_FIRST; 
  DISPID_COMMENTPDL                           = DISPID_NORMAL_FIRST; 
  DISPID_TABLECELL                            = DISPID_TEXTSITE + 1000; 
  DISPID_RANGE                                = DISPID_NORMAL_FIRST; 
  DISPID_SELECTION                            = DISPID_NORMAL_FIRST; 
  DISPID_OPTION                               = DISPID_NORMAL_FIRST; 
  DISPID_1D                                   = DISPID_TEXTSITE + 1000; 
  DISPID_MAP                                  = DISPID_NORMAL_FIRST; 
  DISPID_AREA                                 = DISPID_NORMAL_FIRST; 
  DISPID_PARAM                                = DISPID_NORMAL_FIRST; 
  DISPID_TABLESECTION                         = DISPID_NORMAL_FIRST; 
  DISPID_TABLEROW                             = DISPID_NORMAL_FIRST; 
  DISPID_TABLECOL                             = DISPID_NORMAL_FIRST; 
  DISPID_SCRIPT                               = DISPID_NORMAL_FIRST; 
  DISPID_STYLESHEET                           = DISPID_NORMAL_FIRST; 
  DISPID_STYLERULE                            = DISPID_NORMAL_FIRST; 
  DISPID_STYLEPAGE                            = DISPID_NORMAL_FIRST; 
  DISPID_STYLESHEETS_COL                      = DISPID_NORMAL_FIRST; 
  DISPID_STYLERULES_COL                       = DISPID_NORMAL_FIRST; 
  DISPID_STYLEPAGES_COL                       = DISPID_NORMAL_FIRST; 
  DISPID_MIMETYPES_COL                        = DISPID_NORMAL_FIRST; 
  DISPID_PLUGINS_COL                          = DISPID_NORMAL_FIRST; 
  DISPID_2D                                   = DISPID_NORMAL_FIRST; 
  DISPID_OMWINDOW                             = DISPID_NORMAL_FIRST; 
  DISPID_EVENTOBJ                             = DISPID_NORMAL_FIRST; 
  DISPID_PERSISTDATA                          = DISPID_NORMAL_FIRST; 
  DISPID_OLESITE                              = DISPID_NORMAL_FIRST; 
  DISPID_FRAMESET                             = DISPID_NORMAL_FIRST; 
  DISPID_LINK                                 = DISPID_NORMAL_FIRST; 
  DISPID_STYLEELEMENT                         = DISPID_NORMAL_FIRST; 
  DISPID_FILTERS                              = DISPID_NORMAL_FIRST; 
//!!  DISPID_TABLESECTION                         = DISPID_NORMAL_FIRST;
  DISPID_OMRECT                               = DISPID_NORMAL_FIRST; 
  DISPID_DOMATTRIBUTE                         = DISPID_NORMAL_FIRST; 
  DISPID_DOMTEXTNODE                          = DISPID_NORMAL_FIRST; 
  DISPID_GENERIC                              = DISPID_NORMAL_FIRST; 
  DISPID_URN_COLL                             = DISPID_NORMAL_FIRST; 
  DISPID_NAMESPACE_COLLECTION                 = DISPID_NORMAL_FIRST; 
  DISPID_NAMESPACE                            = DISPID_NORMAL_FIRST; 
  DISPID_TAGNAMES_COLLECTION                  = DISPID_NORMAL_FIRST; 

  DISPID_HTMLDOCUMENT                         = DISPID_NORMAL_FIRST; 
  DISPID_OMDOCUMENT                           = DISPID_NORMAL_FIRST; 
  DISPID_DATATRANSFER                         = DISPID_NORMAL_FIRST; 
  DISPID_XMLDECL                              = DISPID_NORMAL_FIRST; 
  DISPID_DOCFRAG                              = DISPID_NORMAL_FIRST; 
  DISPID_ILINEINFO                            = DISPID_NORMAL_FIRST; 
  DISPID_IHTMLCOMPUTEDSTYLE                   = DISPID_NORMAL_FIRST; 
{ ;begin_internal }
   { Special case for compatability with IE4 -> therefore the 1: }
{ ;end_internal }
  DISPID_WINDOW                               = 1; 
  DISPID_SCREEN                               = DISPID_NORMAL_FIRST; 
  DISPID_FRAMESCOLLECTION                     = DISPID_NORMAL_FIRST; 
  DISPID_HISTORY                              = 1; 
  DISPID_LOCATION                             = 1; 
  DISPID_NAVIGATOR                            = 1; 
  DISPID_COLLECTION                           = DISPID_NORMAL_FIRST+500; 
  DISPID_OPTIONS_COL                          = DISPID_NORMAL_FIRST+500; 

  DISPID_CHECKBOX                             = DISPID_NORMAL_FIRST; 
  DISPID_RADIO                                = DISPID_CHECKBOX + 1000; 

  DISPID_FRAMESITE                            = DISPID_SITE        + 1000; 
  DISPID_FRAME                                = DISPID_FRAMESITE   + 1000; 
  DISPID_IFRAME                               = DISPID_FRAMESITE   + 1000; 

  WEBOC_DISPIDBASE                            = DISPID_FRAMESITE   + 2000; 
  WEBOC_DISPIDMAX                             = WEBOC_DISPIDBASE   +  100; 

  DISPID_PROTECTEDELEMENT                     = DISPID_NORMAL_FIRST; 
  DISPID_DEFAULTS                             = DISPID_NORMAL_FIRST; 
  DISPID_MARKUP                               = DISPID_NORMAL_FIRST; 
  DISPID_DOMIMPLEMENTATION                    = DISPID_NORMAL_FIRST; 

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  Reserved negative DISPIDs }

{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  DISPID_WINDOWOBJECT                         = -5500; 
  DISPID_LOCATIONOBJECT                       = -5506; 
  DISPID_HISTORYOBJECT                        = -5507; 
  DISPID_NAVIGATOROBJECT                      = -5508; 
  DISPID_SECURITYCTX                          = -5511; 
  DISPID_AMBIENT_DLCONTROL                    = -5512; 
  DISPID_AMBIENT_USERAGENT                    = -5513; 
  DISPID_SECURITYDOMAIN                       = -5514; 
  DLCTL_DLIMAGES                              = $00000010; 
  DLCTL_VIDEOS                                = $00000020; 
  DLCTL_BGSOUNDS                              = $00000040; 
  DLCTL_NO_SCRIPTS                            = $00000080; 
  DLCTL_NO_JAVA                               = $00000100; 
  DLCTL_NO_RUNACTIVEXCTLS                     = $00000200; 
  DLCTL_NO_DLACTIVEXCTLS                      = $00000400; 
  DLCTL_DOWNLOADONLY                          = $00000800; 
  DLCTL_NO_FRAMEDOWNLOAD                      = $00001000; 
  DLCTL_RESYNCHRONIZE                         = $00002000; 
  DLCTL_PRAGMA_NO_CACHE                       = $00004000; 
  DLCTL_NO_BEHAVIORS                          = $00008000; 
  DLCTL_NO_METACHARSET                        = $00010000; 
  DLCTL_URL_ENCODING_DISABLE_UTF8             = $00020000; 
  DLCTL_URL_ENCODING_ENABLE_UTF8              = $00040000; 
  DLCTL_FORCEOFFLINE                          = $10000000; 
  DLCTL_NO_CLIENTPULL                         = $20000000; 
  DLCTL_SILENT                                = $40000000; 
  DLCTL_OFFLINEIFNOTCONNECTED                 = $80000000; 
  DLCTL_OFFLINE                               = DLCTL_OFFLINEIFNOTCONNECTED; 

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  DISPID for each non xobject event }

{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  DISPID_ONABORT                              = DISPID_NORMAL_FIRST; 
  DISPID_ONCHANGE                             = DISPID_NORMAL_FIRST + 1; 
  DISPID_ONERROR                              = DISPID_NORMAL_FIRST + 2; 
  DISPID_ONLOAD                               = DISPID_NORMAL_FIRST + 3; 
  DISPID_ONSELECT                             = DISPID_NORMAL_FIRST + 6; 
  DISPID_ONSUBMIT                             = DISPID_NORMAL_FIRST + 7; 
  DISPID_ONUNLOAD                             = DISPID_NORMAL_FIRST + 8; 
  DISPID_ONBOUNCE                             = DISPID_NORMAL_FIRST + 9; 
  DISPID_ONFINISH                             = DISPID_NORMAL_FIRST + 10; 
  DISPID_ONSTART                              = DISPID_NORMAL_FIRST + 11; 
  DISPID_ONLAYOUT                             = DISPID_NORMAL_FIRST + 13; 
  DISPID_ONSCROLL                             = DISPID_NORMAL_FIRST + 14; 
  DISPID_ONRESET                              = DISPID_NORMAL_FIRST + 15; 
  DISPID_ONRESIZE                             = DISPID_NORMAL_FIRST + 16; 
  DISPID_ONBEFOREUNLOAD                       = DISPID_NORMAL_FIRST + 17; 
  DISPID_ONCHANGEFOCUS                        = DISPID_NORMAL_FIRST + 18; 
  DISPID_ONCHANGEBLUR                         = DISPID_NORMAL_FIRST + 19; 
  DISPID_ONPERSIST                            = DISPID_NORMAL_FIRST + 20; 
  DISPID_ONPERSISTSAVE                        = DISPID_NORMAL_FIRST + 21; 
  DISPID_ONPERSISTLOAD                        = DISPID_NORMAL_FIRST + 22; 
  DISPID_ONCONTEXTMENU                        = DISPID_NORMAL_FIRST + 23; 
  DISPID_ONBEFOREPRINT                        = DISPID_NORMAL_FIRST + 24; 
  DISPID_ONAFTERPRINT                         = DISPID_NORMAL_FIRST + 25; 
  DISPID_ONSTOP                               = DISPID_NORMAL_FIRST + 26; 
  DISPID_ONBEFOREEDITFOCUS                    = DISPID_NORMAL_FIRST + 27; 
  DISPID_ONMOUSEHOVER                         = DISPID_NORMAL_FIRST + 28; 
  DISPID_ONCONTENTREADY                       = DISPID_NORMAL_FIRST + 29; 
  DISPID_ONLAYOUTCOMPLETE                     = DISPID_NORMAL_FIRST + 30; 
  DISPID_ONPAGE                               = DISPID_NORMAL_FIRST + 31; 
  DISPID_ONLINKEDOVERFLOW                     = DISPID_NORMAL_FIRST + 32; 
  DISPID_ONMOUSEWHEEL                         = DISPID_NORMAL_FIRST + 33; 
  DISPID_ONBEFOREDEACTIVATE                   = DISPID_NORMAL_FIRST + 34; 
  DISPID_ONMOVE                               = DISPID_NORMAL_FIRST + 35; 
  DISPID_ONCONTROLSELECT                      = DISPID_NORMAL_FIRST + 36; 
  DISPID_ONSELECTIONCHANGE                    = DISPID_NORMAL_FIRST + 37; 
  DISPID_ONMOVESTART                          = DISPID_NORMAL_FIRST + 38; 
  DISPID_ONMOVEEND                            = DISPID_NORMAL_FIRST + 39; 
  DISPID_ONRESIZESTART                        = DISPID_NORMAL_FIRST + 40; 
  DISPID_ONRESIZEEND                          = DISPID_NORMAL_FIRST + 41; 
  DISPID_ONMOUSEENTER                         = DISPID_NORMAL_FIRST + 42; 
  DISPID_ONMOUSELEAVE                         = DISPID_NORMAL_FIRST + 43; 
  DISPID_ONACTIVATE                           = DISPID_NORMAL_FIRST + 44; 
  DISPID_ONDEACTIVATE                         = DISPID_NORMAL_FIRST + 45; 
  DISPID_ONMULTILAYOUTCLEANUP                 = DISPID_NORMAL_FIRST + 46; 
  DISPID_ONBEFOREACTIVATE                     = DISPID_NORMAL_FIRST + 47; 
  DISPID_ONFOCUSIN                            = DISPID_NORMAL_FIRST + 48; 
  DISPID_ONFOCUSOUT                           = DISPID_NORMAL_FIRST + 49; 

{ ;begin_internal }
{ ---------------------------------------------------------------------------- }

{  DISPID for each unique HtmlAttribute/CssAttribute }

{ ---------------------------------------------------------------------------- }
{ ;end_internal }

  DISPID_A_FIRST                              = DISPID_ATTRS; 
  DISPID_A_MIN                                = DISPID_ATTRS; 
  DISPID_A_MAX                                = DISPID_ATTRS+999; 

  DISPID_A_BACKGROUNDIMAGE                    = DISPID_A_FIRST+1; 
  DISPID_A_COLOR                              = DISPID_A_FIRST+2; 
  DISPID_A_TEXTTRANSFORM                      = DISPID_A_FIRST+4; 
  DISPID_A_NOWRAP                             = DISPID_A_FIRST+5; 
  DISPID_A_LINEHEIGHT                         = DISPID_A_FIRST+6; 
  DISPID_A_TEXTINDENT                         = DISPID_A_FIRST+7; 
  DISPID_A_LETTERSPACING                      = DISPID_A_FIRST+8; 
  DISPID_A_LANG                               = DISPID_A_FIRST+9; 
  DISPID_A_OVERFLOW                           = DISPID_A_FIRST+10; 

  DISPID_A_PADDING                            = DISPID_A_FIRST+11; 
  DISPID_A_PADDINGTOP                         = DISPID_A_FIRST+12; 
  DISPID_A_PADDINGRIGHT                       = DISPID_A_FIRST+13; 
  DISPID_A_PADDINGBOTTOM                      = DISPID_A_FIRST+14; 
  DISPID_A_PADDINGLEFT                        = DISPID_A_FIRST+15; 

  DISPID_A_CLEAR                              = DISPID_A_FIRST+16; 
  DISPID_A_LISTTYPE                           = DISPID_A_FIRST+17; 
  DISPID_A_FONTFACE                           = DISPID_A_FIRST+18; 
  DISPID_A_FONTSIZE                           = DISPID_A_FIRST+19; 

  DISPID_A_TEXTDECORATIONLINETHROUGH          = DISPID_A_FIRST+20; 
  DISPID_A_TEXTDECORATIONUNDERLINE            = DISPID_A_FIRST+21; 
  DISPID_A_TEXTDECORATIONBLINK                = DISPID_A_FIRST+22; 
  DISPID_A_TEXTDECORATIONNONE                 = DISPID_A_FIRST+23; 


  DISPID_A_FONTSTYLE                          = DISPID_A_FIRST+24; 
  DISPID_A_FONTVARIANT                        = DISPID_A_FIRST+25; 
  DISPID_A_BASEFONT                           = DISPID_A_FIRST+26; 
  DISPID_A_FONTWEIGHT                         = DISPID_A_FIRST+27; 

  DISPID_A_TABLEBORDERCOLOR                   = DISPID_A_FIRST+28; 
  DISPID_A_TABLEBORDERCOLORLIGHT              = DISPID_A_FIRST+29; 
  DISPID_A_TABLEBORDERCOLORDARK               = DISPID_A_FIRST+30; 
  DISPID_A_TABLEVALIGN                        = DISPID_A_FIRST+31; 

  DISPID_A_BACKGROUND                         = DISPID_A_FIRST+32; 
  DISPID_A_BACKGROUNDPOSX                     = DISPID_A_FIRST+33; 
  DISPID_A_BACKGROUNDPOSY                     = DISPID_A_FIRST+34; 

  DISPID_A_TEXTDECORATION                     = DISPID_A_FIRST+35; 

  DISPID_A_MARGIN                             = DISPID_A_FIRST+36; 
  DISPID_A_MARGINTOP                          = DISPID_A_FIRST+37; 
  DISPID_A_MARGINRIGHT                        = DISPID_A_FIRST+38; 
  DISPID_A_MARGINBOTTOM                       = DISPID_A_FIRST+39; 
  DISPID_A_MARGINLEFT                         = DISPID_A_FIRST+40; 

  DISPID_A_FONT                               = DISPID_A_FIRST+41; 
  DISPID_A_FONTSIZEKEYWORD                    = DISPID_A_FIRST+42; 
  DISPID_A_FONTSIZECOMBINE                    = DISPID_A_FIRST+43; 

  DISPID_A_BACKGROUNDREPEAT                   = DISPID_A_FIRST+44; 
  DISPID_A_BACKGROUNDATTACHMENT               = DISPID_A_FIRST+45; 
  DISPID_A_BACKGROUNDPOSITION                 = DISPID_A_FIRST+46; 
  DISPID_A_WORDSPACING                        = DISPID_A_FIRST+47; 
  DISPID_A_VERTICALALIGN                      = DISPID_A_FIRST+48; 
  DISPID_A_BORDER                             = DISPID_A_FIRST+49; 
  DISPID_A_BORDERTOP                          = DISPID_A_FIRST+50; 
  DISPID_A_BORDERRIGHT                        = DISPID_A_FIRST+51; 
  DISPID_A_BORDERBOTTOM                       = DISPID_A_FIRST+52; 
  DISPID_A_BORDERLEFT                         = DISPID_A_FIRST+53; 
  DISPID_A_BORDERCOLOR                        = DISPID_A_FIRST+54; 
  DISPID_A_BORDERTOPCOLOR                     = DISPID_A_FIRST+55; 
  DISPID_A_BORDERRIGHTCOLOR                   = DISPID_A_FIRST+56; 
  DISPID_A_BORDERBOTTOMCOLOR                  = DISPID_A_FIRST+57; 
  DISPID_A_BORDERLEFTCOLOR                    = DISPID_A_FIRST+58; 
  DISPID_A_BORDERWIDTH                        = DISPID_A_FIRST+59; 
  DISPID_A_BORDERTOPWIDTH                     = DISPID_A_FIRST+60; 
  DISPID_A_BORDERRIGHTWIDTH                   = DISPID_A_FIRST+61; 
  DISPID_A_BORDERBOTTOMWIDTH                  = DISPID_A_FIRST+62; 
  DISPID_A_BORDERLEFTWIDTH                    = DISPID_A_FIRST+63; 
  DISPID_A_BORDERSTYLE                        = DISPID_A_FIRST+64; 
  DISPID_A_BORDERTOPSTYLE                     = DISPID_A_FIRST+65; 
  DISPID_A_BORDERRIGHTSTYLE                   = DISPID_A_FIRST+66; 
  DISPID_A_BORDERBOTTOMSTYLE                  = DISPID_A_FIRST+67; 
  DISPID_A_BORDERLEFTSTYLE                    = DISPID_A_FIRST+68; 
  DISPID_A_TEXTDECORATIONOVERLINE             = DISPID_A_FIRST+69; 
  DISPID_A_FLOAT                              = DISPID_A_FIRST+70; 
  DISPID_A_DISPLAY                            = DISPID_A_FIRST+71; 
  DISPID_A_LISTSTYLETYPE                      = DISPID_A_FIRST+72; 
  DISPID_A_LISTSTYLEPOSITION                  = DISPID_A_FIRST+73; 
  DISPID_A_LISTSTYLEIMAGE                     = DISPID_A_FIRST+74; 
  DISPID_A_LISTSTYLE                          = DISPID_A_FIRST+75; 
  DISPID_A_WHITESPACE                         = DISPID_A_FIRST+76; 
  DISPID_A_PAGEBREAKBEFORE                    = DISPID_A_FIRST+77; 
  DISPID_A_PAGEBREAKAFTER                     = DISPID_A_FIRST+78; 
  DISPID_A_SCROLL                             = DISPID_A_FIRST+79; 
  DISPID_A_VISIBILITY                         = DISPID_A_FIRST+80; 
{ ;begin_internal }
{ This dispid is available }
  DISPID_A_HIDDEN                             = DISPID_A_FIRST+81; 
{ ;end_internal }
  DISPID_A_FILTER                             = DISPID_A_FIRST+82; 

  DISPID_DEFAULTVALUE                         = DISPID_A_FIRST+83; 

  DISPID_A_BORDERCOLLAPSE                     = DISPID_A_FIRST+84; 

  DISPID_A_POSITION                           = DISPID_A_FIRST+90; 
  DISPID_A_ZINDEX                             = DISPID_A_FIRST+91; 
  DISPID_A_CLIP                               = DISPID_A_FIRST+92; 
  DISPID_A_CLIPRECTTOP                        = DISPID_A_FIRST+93; 
  DISPID_A_CLIPRECTRIGHT                      = DISPID_A_FIRST+94; 
  DISPID_A_CLIPRECTBOTTOM                     = DISPID_A_FIRST+95; 
  DISPID_A_CLIPRECTLEFT                       = DISPID_A_FIRST+96; 

  DISPID_A_FONTFACESRC                        = DISPID_A_FIRST+97; 
  DISPID_A_TABLELAYOUT                        = DISPID_A_FIRST+98; 

{ ;begin_internal }
{ The style as a text string }
{ ;end_internal }
  DISPID_A_STYLETEXT                          = DISPID_A_FIRST+99; 

{ ;begin_internal }
{ Known attributes that have special meaning }
{ ;end_internal }
  DISPID_A_LANGUAGE                           = DISPID_A_FIRST+100; 

  DISPID_A_VALUE                              = DISPID_A_FIRST+101; 
  DISPID_A_CURSOR                             = DISPID_A_FIRST+102; 


{ ;begin_internal }
{ +----------------------------------------------------------------------- }
{  A couple of dispids that are used internally for firing }
{  events and prop notifies. }
{ Keep all the internal dispid's together, otherwise we'll trip up }

  DISPID_A_EVENTSINK                          = DISPID_A_FIRST+103; 
  DISPID_A_PROPNOTIFYSINK                     = DISPID_A_FIRST+104; 
  DISPID_A_ROWSETNOTIFYSINK                   = DISPID_A_FIRST+105; 
  DISPID_INTERNAL_INLINESTYLEAA               = DISPID_A_FIRST+106; { In line style Attr Array }
  DISPID_INTERNAL_CSTYLEPTRCACHE              = DISPID_A_FIRST+107; { Cached CStyle Ptr }
  DISPID_INTERNAL_CRUNTIMESTYLEPTRCACHE       = DISPID_A_FIRST+108; { runtime style ptr obj }
  DISPID_INTERNAL_INVOKECONTEXT               = DISPID_A_FIRST+109; { Cached Invoke context }

  DISPID_A_BGURLIMGCTXCACHEINDEX              = DISPID_A_FIRST+110; 
  DISPID_A_LIURLIMGCTXCACHEINDEX              = DISPID_A_FIRST+111; 
  DISPID_A_ROWSETASYNCHNOTIFYSINK             = DISPID_A_FIRST+112; 
  DISPID_INTERNAL_FILTERPTRCACHE              = DISPID_A_FIRST+113; { FilterCollection in AttrArray }
  DISPID_A_ROWPOSITIONCHANGESINK              = DISPID_A_FIRST+114; 
{ ;end_internal }

  DISPID_A_BEHAVIOR                           = DISPID_A_FIRST+115; { xtags }
  DISPID_A_READYSTATE                         = DISPID_A_FIRST+116; { ready state }

  DISPID_A_DIR                                = DISPID_A_FIRST+117; { Complex Text support for bidi }
  DISPID_A_UNICODEBIDI                        = DISPID_A_FIRST+118; { Complex Text support for CSS2 unicode-bidi }
  DISPID_A_DIRECTION                          = DISPID_A_FIRST+119; { Complex Text support for CSS2 direction }

  DISPID_A_IMEMODE                            = DISPID_A_FIRST+120; 

  DISPID_A_RUBYALIGN                          = DISPID_A_FIRST+121; 
  DISPID_A_RUBYPOSITION                       = DISPID_A_FIRST+122; 
  DISPID_A_RUBYOVERHANG                       = DISPID_A_FIRST+123; 

{ ;begin_internal }
  DISPID_INTERNAL_ONBEHAVIOR_CONTENTREADY      = DISPID_A_FIRST+124; 
  DISPID_INTERNAL_ONBEHAVIOR_DOCUMENTREADY     = DISPID_A_FIRST+125; 
  DISPID_INTERNAL_CDOMCHILDRENPTRCACHE         = DISPID_A_FIRST+126; 
{ ;end_internal }

  DISPID_A_LAYOUTGRIDCHAR                     = DISPID_A_FIRST+127; 
  DISPID_A_LAYOUTGRIDLINE                     = DISPID_A_FIRST+128; 
  DISPID_A_LAYOUTGRIDMODE                     = DISPID_A_FIRST+129; 
  DISPID_A_LAYOUTGRIDTYPE                     = DISPID_A_FIRST+130; 
  DISPID_A_LAYOUTGRID                         = DISPID_A_FIRST+131; 

  DISPID_A_TEXTAUTOSPACE                      = DISPID_A_FIRST+132; 

  DISPID_A_LINEBREAK                          = DISPID_A_FIRST+133; 
  DISPID_A_WORDBREAK                          = DISPID_A_FIRST+134; 

  DISPID_A_TEXTJUSTIFY                        = DISPID_A_FIRST+135; 
  DISPID_A_TEXTJUSTIFYTRIM                    = DISPID_A_FIRST+136; 
  DISPID_A_TEXTKASHIDA                        = DISPID_A_FIRST+137; 

  DISPID_A_OVERFLOWX                          = DISPID_A_FIRST+139; 
  DISPID_A_OVERFLOWY                          = DISPID_A_FIRST+140; 

  DISPID_A_HTCDISPATCHITEM_VALUE              = DISPID_A_FIRST+141; 
  DISPID_A_DOCFRAGMENT                        = DISPID_A_FIRST+142; 

  DISPID_A_HTCDD_ELEMENT                      = DISPID_A_FIRST+143; 
  DISPID_A_HTCDD_CREATEEVENTOBJECT            = DISPID_A_FIRST+144; 

  DISPID_A_URNATOM                            = DISPID_A_FIRST+145; 
  DISPID_A_UNIQUEPEERNUMBER                   = DISPID_A_FIRST+146; 

  DISPID_A_ACCELERATOR                        = DISPID_A_FIRST+147; 

{ ;begin_internal }
  DISPID_INTERNAL_ONBEHAVIOR_APPLYSTYLE           = DISPID_A_FIRST+148; 
  DISPID_INTERNAL_RUNTIMESTYLEAA                  = DISPID_A_FIRST+149; 
  DISPID_A_HTCDISPATCHITEM_VALUE_SCRIPTSONLY      = DISPID_A_FIRST+150; 
{ ;end_internal }

  DISPID_A_EXTENDEDTAGDESC                    = DISPID_A_FIRST+151; 

  DISPID_A_ROTATE                             = DISPID_A_FIRST+152; 
  DISPID_A_ZOOM                               = DISPID_A_FIRST+153; 

  DISPID_A_HTCDD_PROTECTEDELEMENT             = DISPID_A_FIRST+154; 
  DISPID_A_LAYOUTFLOW                         = DISPID_A_FIRST+155; 
{ DISPID_A_FIRST+156 unused -- removing 'rectangular' }
{ #define DISPID_A_RECTANGULAR                    (DISPID_A_FIRST+156) }

  DISPID_A_HTCDD_ISMARKUPSHARED               = DISPID_A_FIRST+157; 
  DISPID_A_WORDWRAP                           = DISPID_A_FIRST+158; 
  DISPID_A_TEXTUNDERLINEPOSITION              = DISPID_A_FIRST+159; 
  DISPID_A_HASLAYOUT                          = DISPID_A_FIRST+160; 
  DISPID_A_MEDIA                              = DISPID_A_FIRST+161; 
  DISPID_A_EDITABLE                           = DISPID_A_FIRST+162; 
  DISPID_A_HIDEFOCUS                          = DISPID_A_FIRST+163; 

{ ;begin_internal }
  DISPID_INTERNAL_LAYOUTRECTREGISTRYPTRCACHE      = DISPID_A_FIRST+164; 
{ ;end_internal }

  DISPID_A_HTCDD_DEFAULTS                     = DISPID_A_FIRST+165; 

  DISPID_A_TEXTLINETHROUGHSTYLE               = DISPID_A_FIRST+166; 
  DISPID_A_TEXTUNDERLINESTYLE                 = DISPID_A_FIRST+167; 
  DISPID_A_TEXTEFFECT                         = DISPID_A_FIRST+168; 
  DISPID_A_TEXTBACKGROUNDCOLOR                = DISPID_A_FIRST+169; 
  DISPID_A_RENDERINGPRIORITY                  = DISPID_A_FIRST+170; 

{ ;begin_internal }
  DISPID_INTERNAL_DWNPOSTPTRCACHE                 = DISPID_A_FIRST+171; 
  DISPID_INTERNAL_CODEPAGESETTINGSPTRCACHE        = DISPID_A_FIRST+172; 
  DISPID_INTERNAL_DWNDOCPTRCACHE                  = DISPID_A_FIRST+173; 
  DISPID_INTERNAL_DATABINDTASKPTRCACHE            = DISPID_A_FIRST+174; 
  DISPID_INTERNAL_URLLOCATIONCACHE                = DISPID_A_FIRST+175; 
  DISPID_INTERNAL_ARYELEMENTRELEASENOTIFYPTRCACHE     = DISPID_A_FIRST+176; 
  DISPID_INTERNAL_PEERFACTORYURLMAPPTRCACHE       = DISPID_A_FIRST+177; 
  DISPID_INTERNAL_STMDIRTYPTRCACHE                = DISPID_A_FIRST+178; 
{ ;end_internal }

{ ;begin_internal }
  DISPID_INTERNAL_COMPUTEFORMATSTATECACHE         = DISPID_A_FIRST+179; 
{ ;end_internal }


  DISPID_A_SCROLLBARBASECOLOR                 = DISPID_A_FIRST+180; 
  DISPID_A_SCROLLBARFACECOLOR                 = DISPID_A_FIRST+181; 
  DISPID_A_SCROLLBAR3DLIGHTCOLOR              = DISPID_A_FIRST+182; 
  DISPID_A_SCROLLBARSHADOWCOLOR               = DISPID_A_FIRST+183; 
  DISPID_A_SCROLLBARHIGHLIGHTCOLOR            = DISPID_A_FIRST+184; 
  DISPID_A_SCROLLBARDARKSHADOWCOLOR           = DISPID_A_FIRST+185; 
  DISPID_A_SCROLLBARARROWCOLOR                = DISPID_A_FIRST+186; 

{ ;begin_internal }
  DISPID_INTERNAL_ONBEHAVIOR_CONTENTSAVE      = DISPID_A_FIRST+187; 
{ ;end_internal }

  DISPID_A_DEFAULTTEXTSELECTION               = DISPID_A_FIRST+188; 
  DISPID_A_TEXTDECORATIONCOLOR                = DISPID_A_FIRST+189; 
  DISPID_A_TEXTCOLOR                          = DISPID_A_FIRST+190; 
  DISPID_A_STYLETEXTDECORATION                = DISPID_A_FIRST+191; 

  DISPID_A_WRITINGMODE                        = DISPID_A_FIRST+192; 

{ ;begin_internal }
  DISPID_INTERNAL_MEDIA_REFERENCE             = DISPID_A_FIRST+193; 
  DISPID_INTERNAL_GENERICCOMPLUSREF           = DISPID_A_FIRST+194; 
{ ;end_internal }

{ ;begin_internal }
  DISPID_INTERNAL_FOCUSITEMS                  = DISPID_A_FIRST+195; 
{ ;end_internal }

  DISPID_A_SCROLLBARTRACKCOLOR                = DISPID_A_FIRST+196; 

{ ;begin_internal }
  DISPID_INTERNAL_DWNHEADERCACHE              = DISPID_A_FIRST+197; 
{ ;end_internal }

  DISPID_A_FROZEN                             = DISPID_A_FIRST+198; 
  DISPID_A_VIEWINHERITSTYLE                   = DISPID_A_FIRST+199; 

{ ;begin_internal }
  DISPID_INTERNAL_FRAMESCOLLECTION            = DISPID_A_FIRST+200; 
{ ;end_internal }

{ ;begin_internal }
  DISPID_A_BGURLIMGCTXCACHEINDEX_FLINE        = DISPID_A_FIRST+201; 
  DISPID_A_BGURLIMGCTXCACHEINDEX_FLETTER      = DISPID_A_FIRST+202; 
{ ;end_internal }

  DISPID_A_TEXTALIGNLAST                      = DISPID_A_FIRST+203; 
  DISPID_A_TEXTKASHIDASPACE                   = DISPID_A_FIRST+204; 

{ ;begin_internal }
  DISPID_INTERNAL_FONTHISTORYINDEX            = DISPID_A_FIRST+205; 
{ ;end_internal }

  DISPID_A_ALLOWTRANSPARENCY                  = DISPID_A_FIRST+206; 

  DISPID_INTERNAL_URLSEARCHCACHE              = DISPID_A_FIRST+207; 

  DISPID_A_ISBLOCK                            = DISPID_A_FIRST+208; 

  DISPID_A_TEXTOVERFLOW                       = DISPID_A_FIRST+209; 

{ ;begin_internal }
  DISPID_INTERNAL_CATTRIBUTECOLLPTRCACHE      = DISPID_A_FIRST+210; 
{ ;end_internal }

  DISPID_A_MINHEIGHT                          = DISPID_A_FIRST+211; 

{ ;begin_internal }
{ ------------------------------------------------------------------------ }

{  Event property and method dispids }

{ ------------------------------------------------------------------------ }
{ ;end_internal }

  DISPID_EVPROP_ONMOUSEOVER               = DISPID_EVENTS +  0; 
  DISPID_EVMETH_ONMOUSEOVER                = STDDISPID_XOBJ_ONMOUSEOVER; 
  DISPID_EVPROP_ONMOUSEOUT                = DISPID_EVENTS +  1; 
  DISPID_EVMETH_ONMOUSEOUT                 = STDDISPID_XOBJ_ONMOUSEOUT; 
  DISPID_EVPROP_ONMOUSEDOWN               = DISPID_EVENTS +  2; 
  DISPID_EVMETH_ONMOUSEDOWN                = DISPID_MOUSEDOWN; 
  DISPID_EVPROP_ONMOUSEUP                 = DISPID_EVENTS +  3; 
  DISPID_EVMETH_ONMOUSEUP                  = DISPID_MOUSEUP; 
  DISPID_EVPROP_ONMOUSEMOVE               = DISPID_EVENTS +  4; 
  DISPID_EVMETH_ONMOUSEMOVE                = DISPID_MOUSEMOVE; 
  DISPID_EVPROP_ONKEYDOWN                 = DISPID_EVENTS +  5; 
  DISPID_EVMETH_ONKEYDOWN                  = DISPID_KEYDOWN; 
  DISPID_EVPROP_ONKEYUP                   = DISPID_EVENTS +  6; 
  DISPID_EVMETH_ONKEYUP                    = DISPID_KEYUP; 
  DISPID_EVPROP_ONKEYPRESS                = DISPID_EVENTS +  7; 
  DISPID_EVMETH_ONKEYPRESS                 = DISPID_KEYPRESS; 
  DISPID_EVPROP_ONCLICK                   = DISPID_EVENTS +  8; 
  DISPID_EVMETH_ONCLICK                    = DISPID_CLICK; 
  DISPID_EVPROP_ONDBLCLICK                = DISPID_EVENTS +  9; 
  DISPID_EVMETH_ONDBLCLICK                 = DISPID_DBLCLICK; 
  DISPID_EVPROP_ONSELECT                  = DISPID_EVENTS + 10; 
  DISPID_EVMETH_ONSELECT                   = DISPID_ONSELECT; 
  DISPID_EVPROP_ONSUBMIT                  = DISPID_EVENTS + 11; 
  DISPID_EVMETH_ONSUBMIT                   = DISPID_ONSUBMIT; 
  DISPID_EVPROP_ONRESET                   = DISPID_EVENTS + 12; 
  DISPID_EVMETH_ONRESET                    = DISPID_ONRESET; 
  DISPID_EVPROP_ONHELP                    = DISPID_EVENTS + 13; 
  DISPID_EVMETH_ONHELP                     = STDDISPID_XOBJ_ONHELP; 
  DISPID_EVPROP_ONFOCUS                   = DISPID_EVENTS + 14; 
  DISPID_EVMETH_ONFOCUS                    = STDDISPID_XOBJ_ONFOCUS;
  DISPID_EVPROP_ONBLUR                    = DISPID_EVENTS + 15; 
  DISPID_EVMETH_ONBLUR                     = STDDISPID_XOBJ_ONBLUR; 
  DISPID_EVPROP_ONROWEXIT                 = DISPID_EVENTS + 18; 
  DISPID_EVMETH_ONROWEXIT                  = STDDISPID_XOBJ_ONROWEXIT; 
  DISPID_EVPROP_ONROWENTER                = DISPID_EVENTS + 19; 
  DISPID_EVMETH_ONROWENTER                 = STDDISPID_XOBJ_ONROWENTER; 
  DISPID_EVPROP_ONBOUNCE                  = DISPID_EVENTS + 20; 
  DISPID_EVMETH_ONBOUNCE                   = DISPID_ONBOUNCE; 
  DISPID_EVPROP_ONBEFOREUPDATE            = DISPID_EVENTS + 21; 
  DISPID_EVMETH_ONBEFOREUPDATE             = STDDISPID_XOBJ_BEFOREUPDATE; 
  DISPID_EVPROP_ONAFTERUPDATE             = DISPID_EVENTS + 22; 
  DISPID_EVMETH_ONAFTERUPDATE              = STDDISPID_XOBJ_AFTERUPDATE; 
  DISPID_EVPROP_ONBEFOREDRAGOVER          = DISPID_EVENTS + 23; 
//!!  DISPID_EVMETH_ONBEFOREDRAGOVER           = EVENTID_CommonCtrlEvent_BeforeDragOver;
  DISPID_EVPROP_ONBEFOREDROPORPASTE       = DISPID_EVENTS + 24;
//!!  DISPID_EVMETH_ONBEFOREDROPORPASTE        = EVENTID_CommonCtrlEvent_BeforeDropOrPaste;
  DISPID_EVPROP_ONREADYSTATECHANGE        = DISPID_EVENTS + 25; 
  DISPID_EVMETH_ONREADYSTATECHANGE         = DISPID_READYSTATECHANGE;
  DISPID_EVPROP_ONFINISH                  = DISPID_EVENTS + 26; 
  DISPID_EVMETH_ONFINISH                   = DISPID_ONFINISH; 
  DISPID_EVPROP_ONSTART                   = DISPID_EVENTS + 27; 
  DISPID_EVMETH_ONSTART                    = DISPID_ONSTART; 
  DISPID_EVPROP_ONABORT                   = DISPID_EVENTS + 28; 
  DISPID_EVMETH_ONABORT                    = DISPID_ONABORT; 
  DISPID_EVPROP_ONERROR                   = DISPID_EVENTS + 29; 
  DISPID_EVMETH_ONERROR                    = DISPID_ONERROR; 
  DISPID_EVPROP_ONCHANGE                  = DISPID_EVENTS + 30; 
  DISPID_EVMETH_ONCHANGE                   = DISPID_ONCHANGE;
  DISPID_EVPROP_ONSCROLL                  = DISPID_EVENTS + 31; 
  DISPID_EVMETH_ONSCROLL                   = DISPID_ONSCROLL; 
  DISPID_EVPROP_ONLOAD                    = DISPID_EVENTS + 32; 
  DISPID_EVMETH_ONLOAD                     = DISPID_ONLOAD; 
  DISPID_EVPROP_ONUNLOAD                  = DISPID_EVENTS + 33; 
  DISPID_EVMETH_ONUNLOAD                   = DISPID_ONUNLOAD; 
  DISPID_EVPROP_ONLAYOUT                  = DISPID_EVENTS + 34; 
  DISPID_EVMETH_ONLAYOUT                   = DISPID_ONLAYOUT; 
  DISPID_EVPROP_ONDRAGSTART               = DISPID_EVENTS + 35; 
  DISPID_EVMETH_ONDRAGSTART                = STDDISPID_XOBJ_ONDRAGSTART; 
  DISPID_EVPROP_ONRESIZE                  = DISPID_EVENTS + 36; 
  DISPID_EVMETH_ONRESIZE                   = DISPID_ONRESIZE; 
  DISPID_EVPROP_ONSELECTSTART             = DISPID_EVENTS + 37; 
  DISPID_EVMETH_ONSELECTSTART              = STDDISPID_XOBJ_ONSELECTSTART; 
  DISPID_EVPROP_ONERRORUPDATE             = DISPID_EVENTS + 38; 
  DISPID_EVMETH_ONERRORUPDATE              = STDDISPID_XOBJ_ERRORUPDATE; 
  DISPID_EVPROP_ONBEFOREUNLOAD            = DISPID_EVENTS + 39; 
  DISPID_EVMETH_ONBEFOREUNLOAD             = DISPID_ONBEFOREUNLOAD; 
  DISPID_EVPROP_ONDATASETCHANGED          = DISPID_EVENTS + 40; 
  DISPID_EVMETH_ONDATASETCHANGED           = STDDISPID_XOBJ_ONDATASETCHANGED; 
  DISPID_EVPROP_ONDATAAVAILABLE           = DISPID_EVENTS + 41; 
  DISPID_EVMETH_ONDATAAVAILABLE            = STDDISPID_XOBJ_ONDATAAVAILABLE; 
  DISPID_EVPROP_ONDATASETCOMPLETE         = DISPID_EVENTS + 42; 
  DISPID_EVMETH_ONDATASETCOMPLETE          = STDDISPID_XOBJ_ONDATASETCOMPLETE; 
  DISPID_EVPROP_ONFILTER                  = DISPID_EVENTS + 43; 
  DISPID_EVMETH_ONFILTER                   = STDDISPID_XOBJ_ONFILTER; 
  DISPID_EVPROP_ONCHANGEFOCUS             = DISPID_EVENTS + 44; 
  DISPID_EVMETH_ONCHANGEFOCUS              = DISPID_ONCHANGEFOCUS;
  DISPID_EVPROP_ONCHANGEBLUR              = DISPID_EVENTS + 45; 
  DISPID_EVMETH_ONCHANGEBLUR               = DISPID_ONCHANGEBLUR; 
  DISPID_EVPROP_ONLOSECAPTURE             = DISPID_EVENTS + 46; 
  DISPID_EVMETH_ONLOSECAPTURE              = STDDISPID_XOBJ_ONLOSECAPTURE; 
  DISPID_EVPROP_ONPROPERTYCHANGE          = DISPID_EVENTS + 47; 
  DISPID_EVMETH_ONPROPERTYCHANGE           = STDDISPID_XOBJ_ONPROPERTYCHANGE; 
  DISPID_EVPROP_ONPERSISTSAVE             = DISPID_EVENTS + 48; 
  DISPID_EVMETH_ONPERSISTSAVE              = DISPID_ONPERSISTSAVE; 
  DISPID_EVPROP_ONDRAG                    = DISPID_EVENTS + 49; 
  DISPID_EVMETH_ONDRAG                     = STDDISPID_XOBJ_ONDRAG; 
  DISPID_EVPROP_ONDRAGEND                 = DISPID_EVENTS + 50; 
  DISPID_EVMETH_ONDRAGEND                  = STDDISPID_XOBJ_ONDRAGEND; 
  DISPID_EVPROP_ONDRAGENTER               = DISPID_EVENTS + 51; 
  DISPID_EVMETH_ONDRAGENTER                = STDDISPID_XOBJ_ONDRAGENTER; 
  DISPID_EVPROP_ONDRAGOVER                = DISPID_EVENTS + 52; 
  DISPID_EVMETH_ONDRAGOVER                 = STDDISPID_XOBJ_ONDRAGOVER; 
  DISPID_EVPROP_ONDRAGLEAVE               = DISPID_EVENTS + 53; 
  DISPID_EVMETH_ONDRAGLEAVE                = STDDISPID_XOBJ_ONDRAGLEAVE; 
  DISPID_EVPROP_ONDROP                    = DISPID_EVENTS + 54; 
  DISPID_EVMETH_ONDROP                     = STDDISPID_XOBJ_ONDROP; 
  DISPID_EVPROP_ONCUT                     = DISPID_EVENTS + 55; 
  DISPID_EVMETH_ONCUT                      = STDDISPID_XOBJ_ONCUT; 
  DISPID_EVPROP_ONCOPY                    = DISPID_EVENTS + 56; 
  DISPID_EVMETH_ONCOPY                     = STDDISPID_XOBJ_ONCOPY; 
  DISPID_EVPROP_ONPASTE                   = DISPID_EVENTS + 57; 
  DISPID_EVMETH_ONPASTE                    = STDDISPID_XOBJ_ONPASTE; 
  DISPID_EVPROP_ONBEFORECUT               = DISPID_EVENTS + 58; 
  DISPID_EVMETH_ONBEFORECUT                = STDDISPID_XOBJ_ONBEFORECUT; 
  DISPID_EVPROP_ONBEFORECOPY              = DISPID_EVENTS + 59; 
  DISPID_EVMETH_ONBEFORECOPY               = STDDISPID_XOBJ_ONBEFORECOPY; 
  DISPID_EVPROP_ONBEFOREPASTE             = DISPID_EVENTS + 60; 
  DISPID_EVMETH_ONBEFOREPASTE              = STDDISPID_XOBJ_ONBEFOREPASTE; 
  DISPID_EVPROP_ONPERSISTLOAD             = DISPID_EVENTS + 61; 
  DISPID_EVMETH_ONPERSISTLOAD              = DISPID_ONPERSISTLOAD; 
  DISPID_EVPROP_ONROWSDELETE              = DISPID_EVENTS + 62; 
  DISPID_EVMETH_ONROWSDELETE               = STDDISPID_XOBJ_ONROWSDELETE; 
  DISPID_EVPROP_ONROWSINSERTED            = DISPID_EVENTS + 63; 
  DISPID_EVMETH_ONROWSINSERTED             = STDDISPID_XOBJ_ONROWSINSERTED; 
  DISPID_EVPROP_ONCELLCHANGE              = DISPID_EVENTS + 64; 
  DISPID_EVMETH_ONCELLCHANGE               = STDDISPID_XOBJ_ONCELLCHANGE; 
  DISPID_EVPROP_ONCONTEXTMENU             = DISPID_EVENTS + 65; 
  DISPID_EVMETH_ONCONTEXTMENU              = DISPID_ONCONTEXTMENU; 
  DISPID_EVPROP_ONBEFOREPRINT             = DISPID_EVENTS + 66; 
  DISPID_EVMETH_ONBEFOREPRINT              = DISPID_ONBEFOREPRINT; 
  DISPID_EVPROP_ONAFTERPRINT              = DISPID_EVENTS + 67; 
  DISPID_EVMETH_ONAFTERPRINT               = DISPID_ONAFTERPRINT; 
  DISPID_EVPROP_ONSTOP                    = DISPID_EVENTS + 68; 
  DISPID_EVMETH_ONSTOP                    = DISPID_ONSTOP; 
  DISPID_EVPROP_ONBEFOREEDITFOCUS         = DISPID_EVENTS + 69; 
  DISPID_EVMETH_ONBEFOREEDITFOCUS          = DISPID_ONBEFOREEDITFOCUS; 
  DISPID_EVPROP_ONATTACHEVENT             = DISPID_EVENTS + 70; 
  DISPID_EVPROP_ONMOUSEHOVER              = DISPID_EVENTS + 71; 
  DISPID_EVMETH_ONMOUSEHOVER               = DISPID_ONMOUSEHOVER; 
  DISPID_EVPROP_ONCONTENTREADY            = DISPID_EVENTS + 72; 
  DISPID_EVMETH_ONCONTENTREADY             = DISPID_ONCONTENTREADY; 
  DISPID_EVPROP_ONLAYOUTCOMPLETE          = DISPID_EVENTS + 73; 
  DISPID_EVMETH_ONLAYOUTCOMPLETE           = DISPID_ONLAYOUTCOMPLETE; 
  DISPID_EVPROP_ONPAGE                    = DISPID_EVENTS + 74; 
  DISPID_EVMETH_ONPAGE                     = DISPID_ONPAGE; 
  DISPID_EVPROP_ONLINKEDOVERFLOW          = DISPID_EVENTS + 75; 
  DISPID_EVMETH_ONLINKEDOVERFLOW           = DISPID_ONLINKEDOVERFLOW; 
  DISPID_EVPROP_ONMOUSEWHEEL              = DISPID_EVENTS + 76; 
  DISPID_EVMETH_ONMOUSEWHEEL               = DISPID_ONMOUSEWHEEL; 
  DISPID_EVPROP_ONBEFOREDEACTIVATE        = DISPID_EVENTS + 77; 
  DISPID_EVMETH_ONBEFOREDEACTIVATE         = DISPID_ONBEFOREDEACTIVATE; 
  DISPID_EVPROP_ONMOVE                    = DISPID_EVENTS + 78; 
  DISPID_EVMETH_ONMOVE                     = DISPID_ONMOVE; 
  DISPID_EVPROP_ONCONTROLSELECT           = DISPID_EVENTS + 79; 
  DISPID_EVMETH_ONCONTROLSELECT            = DISPID_ONCONTROLSELECT; 
  DISPID_EVPROP_ONSELECTIONCHANGE         = DISPID_EVENTS + 80; 
  DISPID_EVMETH_ONSELECTIONCHANGE          = DISPID_ONSELECTIONCHANGE; 
  DISPID_EVPROP_ONMOVESTART               = DISPID_EVENTS + 81; 
  DISPID_EVMETH_ONMOVESTART                = DISPID_ONMOVESTART; 
  DISPID_EVPROP_ONMOVEEND                 = DISPID_EVENTS + 82; 
  DISPID_EVMETH_ONMOVEEND                  = DISPID_ONMOVEEND; 
  DISPID_EVPROP_ONRESIZESTART             = DISPID_EVENTS + 83; 
  DISPID_EVMETH_ONRESIZESTART              = DISPID_ONRESIZESTART; 
  DISPID_EVPROP_ONRESIZEEND               = DISPID_EVENTS + 84; 
  DISPID_EVMETH_ONRESIZEEND                = DISPID_ONRESIZEEND; 
  DISPID_EVPROP_ONMOUSEENTER              = DISPID_EVENTS + 85; 
  DISPID_EVMETH_ONMOUSEENTER               = DISPID_ONMOUSEENTER; 
  DISPID_EVPROP_ONMOUSELEAVE              = DISPID_EVENTS + 86; 
  DISPID_EVMETH_ONMOUSELEAVE               = DISPID_ONMOUSELEAVE; 
  DISPID_EVPROP_ONACTIVATE                = DISPID_EVENTS + 87; 
  DISPID_EVMETH_ONACTIVATE                 = DISPID_ONACTIVATE; 
  DISPID_EVPROP_ONDEACTIVATE              = DISPID_EVENTS + 88; 
  DISPID_EVMETH_ONDEACTIVATE               = DISPID_ONDEACTIVATE; 
  DISPID_EVPROP_ONMULTILAYOUTCLEANUP      = DISPID_EVENTS + 89; 
  DISPID_EVMETH_ONMULTILAYOUTCLEANUP       = DISPID_ONMULTILAYOUTCLEANUP; 
  DISPID_EVPROP_ONBEFOREACTIVATE          = DISPID_EVENTS + 90; 
  DISPID_EVMETH_ONBEFOREACTIVATE           = DISPID_ONBEFOREACTIVATE; 
  DISPID_EVPROP_ONFOCUSIN                 = DISPID_EVENTS + 91; 
  DISPID_EVMETH_ONFOCUSIN                  = DISPID_ONFOCUSIN;
  DISPID_EVPROP_ONFOCUSOUT                = DISPID_EVENTS + 92;
  DISPID_EVMETH_ONFOCUSOUT                 = DISPID_ONFOCUSOUT;
  DISPID_EVPROPS_COUNT                    =                 93;


{ ;begin_internal }
{$ENDIF // __COREDISP_H__}
{ ;end_internal }

{    DISPIDs for interface IHTMLFiltersCollection }

  DISPID_NEWENUM                                                = -4;
  {$EXTERNALSYM DISPID_NEWENUM}

  DISPID_VALUE                                                  = 0;
  {$EXTERNALSYM DISPID_VALUE}

  DISPID_IHTMLFILTERSCOLLECTION_LENGTH                          = DISPID_FILTERS+1;
  DISPID_IHTMLFILTERSCOLLECTION__NEWENUM                        = DISPID_NEWENUM;
  DISPID_IHTMLFILTERSCOLLECTION_ITEM                            = DISPID_VALUE;

{    DISPIDs for interface IDispatchEx }

{$DEFINE DISPID_IDISPATCHEX_GETDISPID}
{$DEFINE DISPID_IDISPATCHEX_INVOKEEX}
{$DEFINE DISPID_IDISPATCHEX_DELETEMEMBERBYNAME}
{$DEFINE DISPID_IDISPATCHEX_DELETEMEMBERBYDISPID}
{$DEFINE DISPID_IDISPATCHEX_GETMEMBERPROPERTIES}
{$DEFINE DISPID_IDISPATCHEX_GETMEMBERNAME}
{$DEFINE DISPID_IDISPATCHEX_GETNEXTDISPID}
{$DEFINE DISPID_IDISPATCHEX_GETNAMESPACEPARENT}

{    DISPIDs for interface IObjectIdentity }

{$DEFINE DISPID_IOBJECTIDENTITY_ISEQUALOBJECT}

{    DISPIDs for interface IPerPropertyBrowsing }

{$DEFINE DISPID_IPERPROPERTYBROWSING_GETDISPLAYSTRING}
{$DEFINE DISPID_IPERPROPERTYBROWSING_MAPPROPERTYTOPAGE}
{$DEFINE DISPID_IPERPROPERTYBROWSING_GETPREDEFINEDSTRINGS}
{$DEFINE DISPID_IPERPROPERTYBROWSING_GETPREDEFINEDVALUE}

{    DISPIDs for interface IHTMLStyle }

  DISPID_IHTMLSTYLE_FONTFAMILY                                  = DISPID_A_FONTFACE; 
  DISPID_IHTMLSTYLE_FONTSTYLE                                   = DISPID_A_FONTSTYLE; 
  DISPID_IHTMLSTYLE_FONTVARIANT                                 = DISPID_A_FONTVARIANT; 
  DISPID_IHTMLSTYLE_FONTWEIGHT                                  = DISPID_A_FONTWEIGHT; 
  DISPID_IHTMLSTYLE_FONTSIZE                                    = DISPID_A_FONTSIZE; 
  DISPID_IHTMLSTYLE_FONT                                        = DISPID_A_FONT; 
  DISPID_IHTMLSTYLE_COLOR                                       = DISPID_A_COLOR; 
  DISPID_IHTMLSTYLE_BACKGROUND                                  = DISPID_A_BACKGROUND; 
  DISPID_IHTMLSTYLE_BACKGROUNDCOLOR                             = DISPID_BACKCOLOR; 
  DISPID_IHTMLSTYLE_BACKGROUNDIMAGE                             = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLSTYLE_BACKGROUNDREPEAT                            = DISPID_A_BACKGROUNDREPEAT; 
  DISPID_IHTMLSTYLE_BACKGROUNDATTACHMENT                        = DISPID_A_BACKGROUNDATTACHMENT; 
  DISPID_IHTMLSTYLE_BACKGROUNDPOSITION                          = DISPID_A_BACKGROUNDPOSITION; 
  DISPID_IHTMLSTYLE_BACKGROUNDPOSITIONX                         = DISPID_A_BACKGROUNDPOSX; 
  DISPID_IHTMLSTYLE_BACKGROUNDPOSITIONY                         = DISPID_A_BACKGROUNDPOSY; 
  DISPID_IHTMLSTYLE_WORDSPACING                                 = DISPID_A_WORDSPACING; 
  DISPID_IHTMLSTYLE_LETTERSPACING                               = DISPID_A_LETTERSPACING; 
  DISPID_IHTMLSTYLE_TEXTDECORATION                              = DISPID_A_TEXTDECORATION; 
  DISPID_IHTMLSTYLE_TEXTDECORATIONNONE                          = DISPID_A_TEXTDECORATIONNONE; 
  DISPID_IHTMLSTYLE_TEXTDECORATIONUNDERLINE                     = DISPID_A_TEXTDECORATIONUNDERLINE; 
  DISPID_IHTMLSTYLE_TEXTDECORATIONOVERLINE                      = DISPID_A_TEXTDECORATIONOVERLINE; 
  DISPID_IHTMLSTYLE_TEXTDECORATIONLINETHROUGH                   = DISPID_A_TEXTDECORATIONLINETHROUGH; 
  DISPID_IHTMLSTYLE_TEXTDECORATIONBLINK                         = DISPID_A_TEXTDECORATIONBLINK; 
  DISPID_IHTMLSTYLE_VERTICALALIGN                               = DISPID_A_VERTICALALIGN; 
  DISPID_IHTMLSTYLE_TEXTTRANSFORM                               = DISPID_A_TEXTTRANSFORM; 
  DISPID_IHTMLSTYLE_TEXTALIGN                                   = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLSTYLE_TEXTINDENT                                  = DISPID_A_TEXTINDENT; 
  DISPID_IHTMLSTYLE_LINEHEIGHT                                  = DISPID_A_LINEHEIGHT; 
  DISPID_IHTMLSTYLE_MARGINTOP                                   = DISPID_A_MARGINTOP; 
  DISPID_IHTMLSTYLE_MARGINRIGHT                                 = DISPID_A_MARGINRIGHT; 
  DISPID_IHTMLSTYLE_MARGINBOTTOM                                = DISPID_A_MARGINBOTTOM; 
  DISPID_IHTMLSTYLE_MARGINLEFT                                  = DISPID_A_MARGINLEFT; 
  DISPID_IHTMLSTYLE_MARGIN                                      = DISPID_A_MARGIN; 
  DISPID_IHTMLSTYLE_PADDINGTOP                                  = DISPID_A_PADDINGTOP; 
  DISPID_IHTMLSTYLE_PADDINGRIGHT                                = DISPID_A_PADDINGRIGHT; 
  DISPID_IHTMLSTYLE_PADDINGBOTTOM                               = DISPID_A_PADDINGBOTTOM; 
  DISPID_IHTMLSTYLE_PADDINGLEFT                                 = DISPID_A_PADDINGLEFT; 
  DISPID_IHTMLSTYLE_PADDING                                     = DISPID_A_PADDING; 
  DISPID_IHTMLSTYLE_BORDER                                      = DISPID_A_BORDER; 
  DISPID_IHTMLSTYLE_BORDERTOP                                   = DISPID_A_BORDERTOP; 
  DISPID_IHTMLSTYLE_BORDERRIGHT                                 = DISPID_A_BORDERRIGHT; 
  DISPID_IHTMLSTYLE_BORDERBOTTOM                                = DISPID_A_BORDERBOTTOM; 
  DISPID_IHTMLSTYLE_BORDERLEFT                                  = DISPID_A_BORDERLEFT; 
  DISPID_IHTMLSTYLE_BORDERCOLOR                                 = DISPID_A_BORDERCOLOR; 
  DISPID_IHTMLSTYLE_BORDERTOPCOLOR                              = DISPID_A_BORDERTOPCOLOR; 
  DISPID_IHTMLSTYLE_BORDERRIGHTCOLOR                            = DISPID_A_BORDERRIGHTCOLOR; 
  DISPID_IHTMLSTYLE_BORDERBOTTOMCOLOR                           = DISPID_A_BORDERBOTTOMCOLOR; 
  DISPID_IHTMLSTYLE_BORDERLEFTCOLOR                             = DISPID_A_BORDERLEFTCOLOR; 
  DISPID_IHTMLSTYLE_BORDERWIDTH                                 = DISPID_A_BORDERWIDTH; 
  DISPID_IHTMLSTYLE_BORDERTOPWIDTH                              = DISPID_A_BORDERTOPWIDTH; 
  DISPID_IHTMLSTYLE_BORDERRIGHTWIDTH                            = DISPID_A_BORDERRIGHTWIDTH; 
  DISPID_IHTMLSTYLE_BORDERBOTTOMWIDTH                           = DISPID_A_BORDERBOTTOMWIDTH; 
  DISPID_IHTMLSTYLE_BORDERLEFTWIDTH                             = DISPID_A_BORDERLEFTWIDTH; 
  DISPID_IHTMLSTYLE_BORDERSTYLE                                 = DISPID_A_BORDERSTYLE; 
  DISPID_IHTMLSTYLE_BORDERTOPSTYLE                              = DISPID_A_BORDERTOPSTYLE; 
  DISPID_IHTMLSTYLE_BORDERRIGHTSTYLE                            = DISPID_A_BORDERRIGHTSTYLE; 
  DISPID_IHTMLSTYLE_BORDERBOTTOMSTYLE                           = DISPID_A_BORDERBOTTOMSTYLE; 
  DISPID_IHTMLSTYLE_BORDERLEFTSTYLE                             = DISPID_A_BORDERLEFTSTYLE; 
  DISPID_IHTMLSTYLE_WIDTH                                       = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLSTYLE_HEIGHT                                      = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLSTYLE_STYLEFLOAT                                  = DISPID_A_FLOAT; 
  DISPID_IHTMLSTYLE_CLEAR                                       = DISPID_A_CLEAR; 
  DISPID_IHTMLSTYLE_DISPLAY                                     = DISPID_A_DISPLAY; 
  DISPID_IHTMLSTYLE_VISIBILITY                                  = DISPID_A_VISIBILITY; 
  DISPID_IHTMLSTYLE_LISTSTYLETYPE                               = DISPID_A_LISTSTYLETYPE; 
  DISPID_IHTMLSTYLE_LISTSTYLEPOSITION                           = DISPID_A_LISTSTYLEPOSITION; 
  DISPID_IHTMLSTYLE_LISTSTYLEIMAGE                              = DISPID_A_LISTSTYLEIMAGE; 
  DISPID_IHTMLSTYLE_LISTSTYLE                                   = DISPID_A_LISTSTYLE; 
  DISPID_IHTMLSTYLE_WHITESPACE                                  = DISPID_A_WHITESPACE; 
  DISPID_IHTMLSTYLE_TOP                                         = STDPROPID_XOBJ_TOP; 
  DISPID_IHTMLSTYLE_LEFT                                        = STDPROPID_XOBJ_LEFT; 
  DISPID_IHTMLSTYLE_POSITION                                    = DISPID_A_POSITION; 
  DISPID_IHTMLSTYLE_ZINDEX                                      = DISPID_A_ZINDEX; 
  DISPID_IHTMLSTYLE_OVERFLOW                                    = DISPID_A_OVERFLOW; 
  DISPID_IHTMLSTYLE_PAGEBREAKBEFORE                             = DISPID_A_PAGEBREAKBEFORE; 
  DISPID_IHTMLSTYLE_PAGEBREAKAFTER                              = DISPID_A_PAGEBREAKAFTER; 
  DISPID_IHTMLSTYLE_CSSTEXT                                     = DISPID_A_STYLETEXT; 
  DISPID_IHTMLSTYLE_PIXELTOP                                    = DISPID_STYLE+0; 
  DISPID_IHTMLSTYLE_PIXELLEFT                                   = DISPID_STYLE+1; 
  DISPID_IHTMLSTYLE_PIXELWIDTH                                  = DISPID_STYLE+2; 
  DISPID_IHTMLSTYLE_PIXELHEIGHT                                 = DISPID_STYLE+3; 
  DISPID_IHTMLSTYLE_POSTOP                                      = DISPID_STYLE+4; 
  DISPID_IHTMLSTYLE_POSLEFT                                     = DISPID_STYLE+5; 
  DISPID_IHTMLSTYLE_POSWIDTH                                    = DISPID_STYLE+6; 
  DISPID_IHTMLSTYLE_POSHEIGHT                                   = DISPID_STYLE+7; 
  DISPID_IHTMLSTYLE_CURSOR                                      = DISPID_A_CURSOR; 
  DISPID_IHTMLSTYLE_CLIP                                        = DISPID_A_CLIP; 
  DISPID_IHTMLSTYLE_FILTER                                      = DISPID_A_FILTER; 
  DISPID_IHTMLSTYLE_SETATTRIBUTE                                = DISPID_HTMLOBJECT+1; 
  DISPID_IHTMLSTYLE_GETATTRIBUTE                                = DISPID_HTMLOBJECT+2; 
  DISPID_IHTMLSTYLE_REMOVEATTRIBUTE                             = DISPID_HTMLOBJECT+3; 
  DISPID_IHTMLSTYLE_TOSTRING                                    = DISPID_STYLE+8; 

{    DISPIDs for interface IHTMLStyle2 }

  DISPID_IHTMLSTYLE2_TABLELAYOUT                                = DISPID_A_TABLELAYOUT; 
  DISPID_IHTMLSTYLE2_BORDERCOLLAPSE                             = DISPID_A_BORDERCOLLAPSE; 
  DISPID_IHTMLSTYLE2_DIRECTION                                  = DISPID_A_DIRECTION; 
  DISPID_IHTMLSTYLE2_BEHAVIOR                                   = DISPID_A_BEHAVIOR; 
  DISPID_IHTMLSTYLE2_SETEXPRESSION                              = DISPID_HTMLOBJECT+4; 
  DISPID_IHTMLSTYLE2_GETEXPRESSION                              = DISPID_HTMLOBJECT+5; 
  DISPID_IHTMLSTYLE2_REMOVEEXPRESSION                           = DISPID_HTMLOBJECT+6; 
  DISPID_IHTMLSTYLE2_POSITION                                   = DISPID_A_POSITION; 
  DISPID_IHTMLSTYLE2_UNICODEBIDI                                = DISPID_A_UNICODEBIDI; 
  DISPID_IHTMLSTYLE2_BOTTOM                                     = STDPROPID_XOBJ_BOTTOM; 
  DISPID_IHTMLSTYLE2_RIGHT                                      = STDPROPID_XOBJ_RIGHT; 
  DISPID_IHTMLSTYLE2_PIXELBOTTOM                                = DISPID_STYLE+9; 
  DISPID_IHTMLSTYLE2_PIXELRIGHT                                 = DISPID_STYLE+10; 
  DISPID_IHTMLSTYLE2_POSBOTTOM                                  = DISPID_STYLE+11; 
  DISPID_IHTMLSTYLE2_POSRIGHT                                   = DISPID_STYLE+12; 
  DISPID_IHTMLSTYLE2_IMEMODE                                    = DISPID_A_IMEMODE; 
  DISPID_IHTMLSTYLE2_RUBYALIGN                                  = DISPID_A_RUBYALIGN; 
  DISPID_IHTMLSTYLE2_RUBYPOSITION                               = DISPID_A_RUBYPOSITION; 
  DISPID_IHTMLSTYLE2_RUBYOVERHANG                               = DISPID_A_RUBYOVERHANG; 
  DISPID_IHTMLSTYLE2_LAYOUTGRIDCHAR                             = DISPID_A_LAYOUTGRIDCHAR; 
  DISPID_IHTMLSTYLE2_LAYOUTGRIDLINE                             = DISPID_A_LAYOUTGRIDLINE; 
  DISPID_IHTMLSTYLE2_LAYOUTGRIDMODE                             = DISPID_A_LAYOUTGRIDMODE; 
  DISPID_IHTMLSTYLE2_LAYOUTGRIDTYPE                             = DISPID_A_LAYOUTGRIDTYPE; 
  DISPID_IHTMLSTYLE2_LAYOUTGRID                                 = DISPID_A_LAYOUTGRID; 
  DISPID_IHTMLSTYLE2_WORDBREAK                                  = DISPID_A_WORDBREAK; 
  DISPID_IHTMLSTYLE2_LINEBREAK                                  = DISPID_A_LINEBREAK; 
  DISPID_IHTMLSTYLE2_TEXTJUSTIFY                                = DISPID_A_TEXTJUSTIFY; 
  DISPID_IHTMLSTYLE2_TEXTJUSTIFYTRIM                            = DISPID_A_TEXTJUSTIFYTRIM; 
  DISPID_IHTMLSTYLE2_TEXTKASHIDA                                = DISPID_A_TEXTKASHIDA; 
  DISPID_IHTMLSTYLE2_TEXTAUTOSPACE                              = DISPID_A_TEXTAUTOSPACE; 
  DISPID_IHTMLSTYLE2_OVERFLOWX                                  = DISPID_A_OVERFLOWX; 
  DISPID_IHTMLSTYLE2_OVERFLOWY                                  = DISPID_A_OVERFLOWY; 
  DISPID_IHTMLSTYLE2_ACCELERATOR                                = DISPID_A_ACCELERATOR; 

{    DISPIDs for interface IHTMLStyle3 }

  DISPID_IHTMLSTYLE3_LAYOUTFLOW                                 = DISPID_A_LAYOUTFLOW; 
  DISPID_IHTMLSTYLE3_ZOOM                                       = DISPID_A_ZOOM; 
  DISPID_IHTMLSTYLE3_WORDWRAP                                   = DISPID_A_WORDWRAP; 
  DISPID_IHTMLSTYLE3_TEXTUNDERLINEPOSITION                      = DISPID_A_TEXTUNDERLINEPOSITION; 
  DISPID_IHTMLSTYLE3_SCROLLBARBASECOLOR                         = DISPID_A_SCROLLBARBASECOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARFACECOLOR                         = DISPID_A_SCROLLBARFACECOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBAR3DLIGHTCOLOR                      = DISPID_A_SCROLLBAR3DLIGHTCOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARSHADOWCOLOR                       = DISPID_A_SCROLLBARSHADOWCOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARHIGHLIGHTCOLOR                    = DISPID_A_SCROLLBARHIGHLIGHTCOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARDARKSHADOWCOLOR                   = DISPID_A_SCROLLBARDARKSHADOWCOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARARROWCOLOR                        = DISPID_A_SCROLLBARARROWCOLOR; 
  DISPID_IHTMLSTYLE3_SCROLLBARTRACKCOLOR                        = DISPID_A_SCROLLBARTRACKCOLOR; 
  DISPID_IHTMLSTYLE3_WRITINGMODE                                = DISPID_A_WRITINGMODE; 
  DISPID_IHTMLSTYLE3_TEXTALIGNLAST                              = DISPID_A_TEXTALIGNLAST; 
  DISPID_IHTMLSTYLE3_TEXTKASHIDASPACE                           = DISPID_A_TEXTKASHIDASPACE; 

{    DISPIDs for interface IHTMLStyle4 }

  DISPID_IHTMLSTYLE4_TEXTOVERFLOW                               = DISPID_A_TEXTOVERFLOW; 
  DISPID_IHTMLSTYLE4_MINHEIGHT                                  = DISPID_A_MINHEIGHT; 

{    DISPIDs for interface IHTMLRuleStyle }

  DISPID_IHTMLRULESTYLE_FONTFAMILY                              = DISPID_A_FONTFACE; 
  DISPID_IHTMLRULESTYLE_FONTSTYLE                               = DISPID_A_FONTSTYLE; 
  DISPID_IHTMLRULESTYLE_FONTVARIANT                             = DISPID_A_FONTVARIANT; 
  DISPID_IHTMLRULESTYLE_FONTWEIGHT                              = DISPID_A_FONTWEIGHT; 
  DISPID_IHTMLRULESTYLE_FONTSIZE                                = DISPID_A_FONTSIZE; 
  DISPID_IHTMLRULESTYLE_FONT                                    = DISPID_A_FONT; 
  DISPID_IHTMLRULESTYLE_COLOR                                   = DISPID_A_COLOR; 
  DISPID_IHTMLRULESTYLE_BACKGROUND                              = DISPID_A_BACKGROUND; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDCOLOR                         = DISPID_BACKCOLOR; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDIMAGE                         = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDREPEAT                        = DISPID_A_BACKGROUNDREPEAT; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDATTACHMENT                    = DISPID_A_BACKGROUNDATTACHMENT; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITION                      = DISPID_A_BACKGROUNDPOSITION; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITIONX                     = DISPID_A_BACKGROUNDPOSX; 
  DISPID_IHTMLRULESTYLE_BACKGROUNDPOSITIONY                     = DISPID_A_BACKGROUNDPOSY; 
  DISPID_IHTMLRULESTYLE_WORDSPACING                             = DISPID_A_WORDSPACING; 
  DISPID_IHTMLRULESTYLE_LETTERSPACING                           = DISPID_A_LETTERSPACING; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATION                          = DISPID_A_TEXTDECORATION; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATIONNONE                      = DISPID_A_TEXTDECORATIONNONE; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATIONUNDERLINE                 = DISPID_A_TEXTDECORATIONUNDERLINE; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATIONOVERLINE                  = DISPID_A_TEXTDECORATIONOVERLINE; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATIONLINETHROUGH               = DISPID_A_TEXTDECORATIONLINETHROUGH; 
  DISPID_IHTMLRULESTYLE_TEXTDECORATIONBLINK                     = DISPID_A_TEXTDECORATIONBLINK; 
  DISPID_IHTMLRULESTYLE_VERTICALALIGN                           = DISPID_A_VERTICALALIGN; 
  DISPID_IHTMLRULESTYLE_TEXTTRANSFORM                           = DISPID_A_TEXTTRANSFORM; 
  DISPID_IHTMLRULESTYLE_TEXTALIGN                               = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLRULESTYLE_TEXTINDENT                              = DISPID_A_TEXTINDENT; 
  DISPID_IHTMLRULESTYLE_LINEHEIGHT                              = DISPID_A_LINEHEIGHT; 
  DISPID_IHTMLRULESTYLE_MARGINTOP                               = DISPID_A_MARGINTOP; 
  DISPID_IHTMLRULESTYLE_MARGINRIGHT                             = DISPID_A_MARGINRIGHT; 
  DISPID_IHTMLRULESTYLE_MARGINBOTTOM                            = DISPID_A_MARGINBOTTOM; 
  DISPID_IHTMLRULESTYLE_MARGINLEFT                              = DISPID_A_MARGINLEFT; 
  DISPID_IHTMLRULESTYLE_MARGIN                                  = DISPID_A_MARGIN; 
  DISPID_IHTMLRULESTYLE_PADDINGTOP                              = DISPID_A_PADDINGTOP; 
  DISPID_IHTMLRULESTYLE_PADDINGRIGHT                            = DISPID_A_PADDINGRIGHT; 
  DISPID_IHTMLRULESTYLE_PADDINGBOTTOM                           = DISPID_A_PADDINGBOTTOM; 
  DISPID_IHTMLRULESTYLE_PADDINGLEFT                             = DISPID_A_PADDINGLEFT; 
  DISPID_IHTMLRULESTYLE_PADDING                                 = DISPID_A_PADDING; 
  DISPID_IHTMLRULESTYLE_BORDER                                  = DISPID_A_BORDER; 
  DISPID_IHTMLRULESTYLE_BORDERTOP                               = DISPID_A_BORDERTOP; 
  DISPID_IHTMLRULESTYLE_BORDERRIGHT                             = DISPID_A_BORDERRIGHT; 
  DISPID_IHTMLRULESTYLE_BORDERBOTTOM                            = DISPID_A_BORDERBOTTOM; 
  DISPID_IHTMLRULESTYLE_BORDERLEFT                              = DISPID_A_BORDERLEFT; 
  DISPID_IHTMLRULESTYLE_BORDERCOLOR                             = DISPID_A_BORDERCOLOR; 
  DISPID_IHTMLRULESTYLE_BORDERTOPCOLOR                          = DISPID_A_BORDERTOPCOLOR; 
  DISPID_IHTMLRULESTYLE_BORDERRIGHTCOLOR                        = DISPID_A_BORDERRIGHTCOLOR; 
  DISPID_IHTMLRULESTYLE_BORDERBOTTOMCOLOR                       = DISPID_A_BORDERBOTTOMCOLOR; 
  DISPID_IHTMLRULESTYLE_BORDERLEFTCOLOR                         = DISPID_A_BORDERLEFTCOLOR; 
  DISPID_IHTMLRULESTYLE_BORDERWIDTH                             = DISPID_A_BORDERWIDTH; 
  DISPID_IHTMLRULESTYLE_BORDERTOPWIDTH                          = DISPID_A_BORDERTOPWIDTH; 
  DISPID_IHTMLRULESTYLE_BORDERRIGHTWIDTH                        = DISPID_A_BORDERRIGHTWIDTH; 
  DISPID_IHTMLRULESTYLE_BORDERBOTTOMWIDTH                       = DISPID_A_BORDERBOTTOMWIDTH; 
  DISPID_IHTMLRULESTYLE_BORDERLEFTWIDTH                         = DISPID_A_BORDERLEFTWIDTH; 
  DISPID_IHTMLRULESTYLE_BORDERSTYLE                             = DISPID_A_BORDERSTYLE; 
  DISPID_IHTMLRULESTYLE_BORDERTOPSTYLE                          = DISPID_A_BORDERTOPSTYLE; 
  DISPID_IHTMLRULESTYLE_BORDERRIGHTSTYLE                        = DISPID_A_BORDERRIGHTSTYLE; 
  DISPID_IHTMLRULESTYLE_BORDERBOTTOMSTYLE                       = DISPID_A_BORDERBOTTOMSTYLE; 
  DISPID_IHTMLRULESTYLE_BORDERLEFTSTYLE                         = DISPID_A_BORDERLEFTSTYLE; 
  DISPID_IHTMLRULESTYLE_WIDTH                                   = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLRULESTYLE_HEIGHT                                  = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLRULESTYLE_STYLEFLOAT                              = DISPID_A_FLOAT; 
  DISPID_IHTMLRULESTYLE_CLEAR                                   = DISPID_A_CLEAR; 
  DISPID_IHTMLRULESTYLE_DISPLAY                                 = DISPID_A_DISPLAY; 
  DISPID_IHTMLRULESTYLE_VISIBILITY                              = DISPID_A_VISIBILITY; 
  DISPID_IHTMLRULESTYLE_LISTSTYLETYPE                           = DISPID_A_LISTSTYLETYPE; 
  DISPID_IHTMLRULESTYLE_LISTSTYLEPOSITION                       = DISPID_A_LISTSTYLEPOSITION; 
  DISPID_IHTMLRULESTYLE_LISTSTYLEIMAGE                          = DISPID_A_LISTSTYLEIMAGE; 
  DISPID_IHTMLRULESTYLE_LISTSTYLE                               = DISPID_A_LISTSTYLE; 
  DISPID_IHTMLRULESTYLE_WHITESPACE                              = DISPID_A_WHITESPACE; 
  DISPID_IHTMLRULESTYLE_TOP                                     = STDPROPID_XOBJ_TOP; 
  DISPID_IHTMLRULESTYLE_LEFT                                    = STDPROPID_XOBJ_LEFT; 
  DISPID_IHTMLRULESTYLE_POSITION                                = DISPID_A_POSITION; 
  DISPID_IHTMLRULESTYLE_ZINDEX                                  = DISPID_A_ZINDEX; 
  DISPID_IHTMLRULESTYLE_OVERFLOW                                = DISPID_A_OVERFLOW; 
  DISPID_IHTMLRULESTYLE_PAGEBREAKBEFORE                         = DISPID_A_PAGEBREAKBEFORE; 
  DISPID_IHTMLRULESTYLE_PAGEBREAKAFTER                          = DISPID_A_PAGEBREAKAFTER; 
  DISPID_IHTMLRULESTYLE_CSSTEXT                                 = DISPID_A_STYLETEXT; 
  DISPID_IHTMLRULESTYLE_CURSOR                                  = DISPID_A_CURSOR; 
  DISPID_IHTMLRULESTYLE_CLIP                                    = DISPID_A_CLIP; 
  DISPID_IHTMLRULESTYLE_FILTER                                  = DISPID_A_FILTER; 
  DISPID_IHTMLRULESTYLE_SETATTRIBUTE                            = DISPID_HTMLOBJECT+1; 
  DISPID_IHTMLRULESTYLE_GETATTRIBUTE                            = DISPID_HTMLOBJECT+2; 
  DISPID_IHTMLRULESTYLE_REMOVEATTRIBUTE                         = DISPID_HTMLOBJECT+3; 

{    DISPIDs for interface IHTMLRuleStyle2 }

  DISPID_IHTMLRULESTYLE2_TABLELAYOUT                            = DISPID_A_TABLELAYOUT; 
  DISPID_IHTMLRULESTYLE2_BORDERCOLLAPSE                         = DISPID_A_BORDERCOLLAPSE; 
  DISPID_IHTMLRULESTYLE2_DIRECTION                              = DISPID_A_DIRECTION; 
  DISPID_IHTMLRULESTYLE2_BEHAVIOR                               = DISPID_A_BEHAVIOR; 
  DISPID_IHTMLRULESTYLE2_POSITION                               = DISPID_A_POSITION; 
  DISPID_IHTMLRULESTYLE2_UNICODEBIDI                            = DISPID_A_UNICODEBIDI; 
  DISPID_IHTMLRULESTYLE2_BOTTOM                                 = STDPROPID_XOBJ_BOTTOM; 
  DISPID_IHTMLRULESTYLE2_RIGHT                                  = STDPROPID_XOBJ_RIGHT; 
  DISPID_IHTMLRULESTYLE2_PIXELBOTTOM                            = DISPID_STYLE+9; 
  DISPID_IHTMLRULESTYLE2_PIXELRIGHT                             = DISPID_STYLE+10; 
  DISPID_IHTMLRULESTYLE2_POSBOTTOM                              = DISPID_STYLE+11; 
  DISPID_IHTMLRULESTYLE2_POSRIGHT                               = DISPID_STYLE+12; 
  DISPID_IHTMLRULESTYLE2_IMEMODE                                = DISPID_A_IMEMODE; 
  DISPID_IHTMLRULESTYLE2_RUBYALIGN                              = DISPID_A_RUBYALIGN; 
  DISPID_IHTMLRULESTYLE2_RUBYPOSITION                           = DISPID_A_RUBYPOSITION; 
  DISPID_IHTMLRULESTYLE2_RUBYOVERHANG                           = DISPID_A_RUBYOVERHANG; 
  DISPID_IHTMLRULESTYLE2_LAYOUTGRIDCHAR                         = DISPID_A_LAYOUTGRIDCHAR; 
  DISPID_IHTMLRULESTYLE2_LAYOUTGRIDLINE                         = DISPID_A_LAYOUTGRIDLINE; 
  DISPID_IHTMLRULESTYLE2_LAYOUTGRIDMODE                         = DISPID_A_LAYOUTGRIDMODE; 
  DISPID_IHTMLRULESTYLE2_LAYOUTGRIDTYPE                         = DISPID_A_LAYOUTGRIDTYPE; 
  DISPID_IHTMLRULESTYLE2_LAYOUTGRID                             = DISPID_A_LAYOUTGRID; 
  DISPID_IHTMLRULESTYLE2_TEXTAUTOSPACE                          = DISPID_A_TEXTAUTOSPACE; 
  DISPID_IHTMLRULESTYLE2_WORDBREAK                              = DISPID_A_WORDBREAK; 
  DISPID_IHTMLRULESTYLE2_LINEBREAK                              = DISPID_A_LINEBREAK; 
  DISPID_IHTMLRULESTYLE2_TEXTJUSTIFY                            = DISPID_A_TEXTJUSTIFY; 
  DISPID_IHTMLRULESTYLE2_TEXTJUSTIFYTRIM                        = DISPID_A_TEXTJUSTIFYTRIM; 
  DISPID_IHTMLRULESTYLE2_TEXTKASHIDA                            = DISPID_A_TEXTKASHIDA; 
  DISPID_IHTMLRULESTYLE2_OVERFLOWX                              = DISPID_A_OVERFLOWX; 
  DISPID_IHTMLRULESTYLE2_OVERFLOWY                              = DISPID_A_OVERFLOWY; 
  DISPID_IHTMLRULESTYLE2_ACCELERATOR                            = DISPID_A_ACCELERATOR; 

{    DISPIDs for interface IHTMLRuleStyle3 }

  DISPID_IHTMLRULESTYLE3_LAYOUTFLOW                             = DISPID_A_LAYOUTFLOW; 
  DISPID_IHTMLRULESTYLE3_ZOOM                                   = DISPID_A_ZOOM; 
  DISPID_IHTMLRULESTYLE3_WORDWRAP                               = DISPID_A_WORDWRAP; 
  DISPID_IHTMLRULESTYLE3_TEXTUNDERLINEPOSITION                  = DISPID_A_TEXTUNDERLINEPOSITION; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARBASECOLOR                     = DISPID_A_SCROLLBARBASECOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARFACECOLOR                     = DISPID_A_SCROLLBARFACECOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBAR3DLIGHTCOLOR                  = DISPID_A_SCROLLBAR3DLIGHTCOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARSHADOWCOLOR                   = DISPID_A_SCROLLBARSHADOWCOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARHIGHLIGHTCOLOR                = DISPID_A_SCROLLBARHIGHLIGHTCOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARDARKSHADOWCOLOR               = DISPID_A_SCROLLBARDARKSHADOWCOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARARROWCOLOR                    = DISPID_A_SCROLLBARARROWCOLOR; 
  DISPID_IHTMLRULESTYLE3_SCROLLBARTRACKCOLOR                    = DISPID_A_SCROLLBARTRACKCOLOR; 
  DISPID_IHTMLRULESTYLE3_WRITINGMODE                            = DISPID_A_WRITINGMODE; 
  DISPID_IHTMLRULESTYLE3_TEXTALIGNLAST                          = DISPID_A_TEXTALIGNLAST; 
  DISPID_IHTMLRULESTYLE3_TEXTKASHIDASPACE                       = DISPID_A_TEXTKASHIDASPACE; 

{    DISPIDs for interface IHTMLRuleStyle4 }

  DISPID_IHTMLRULESTYLE4_TEXTOVERFLOW                           = DISPID_A_TEXTOVERFLOW; 
  DISPID_IHTMLRULESTYLE4_MINHEIGHT                              = DISPID_A_MINHEIGHT; 

{    DISPIDs for interface IHTMLRenderStyle }

  DISPID_IHTMLRENDERSTYLE_TEXTLINETHROUGHSTYLE                  = DISPID_A_TEXTLINETHROUGHSTYLE; 
  DISPID_IHTMLRENDERSTYLE_TEXTUNDERLINESTYLE                    = DISPID_A_TEXTUNDERLINESTYLE; 
  DISPID_IHTMLRENDERSTYLE_TEXTEFFECT                            = DISPID_A_TEXTEFFECT; 
  DISPID_IHTMLRENDERSTYLE_TEXTCOLOR                             = DISPID_A_TEXTCOLOR; 
  DISPID_IHTMLRENDERSTYLE_TEXTBACKGROUNDCOLOR                   = DISPID_A_TEXTBACKGROUNDCOLOR; 
  DISPID_IHTMLRENDERSTYLE_TEXTDECORATIONCOLOR                   = DISPID_A_TEXTDECORATIONCOLOR; 
  DISPID_IHTMLRENDERSTYLE_RENDERINGPRIORITY                     = DISPID_A_RENDERINGPRIORITY; 
  DISPID_IHTMLRENDERSTYLE_DEFAULTTEXTSELECTION                  = DISPID_A_DEFAULTTEXTSELECTION; 
  DISPID_IHTMLRENDERSTYLE_TEXTDECORATION                        = DISPID_A_STYLETEXTDECORATION; 

{    DISPIDs for interface IHTMLCurrentStyle }

  DISPID_IHTMLCURRENTSTYLE_POSITION                             = DISPID_A_POSITION; 
  DISPID_IHTMLCURRENTSTYLE_STYLEFLOAT                           = DISPID_A_FLOAT; 
  DISPID_IHTMLCURRENTSTYLE_COLOR                                = DISPID_A_COLOR; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDCOLOR                      = DISPID_BACKCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_FONTFAMILY                           = DISPID_A_FONTFACE; 
  DISPID_IHTMLCURRENTSTYLE_FONTSTYLE                            = DISPID_A_FONTSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_FONTVARIANT                          = DISPID_A_FONTVARIANT; 
  DISPID_IHTMLCURRENTSTYLE_FONTWEIGHT                           = DISPID_A_FONTWEIGHT; 
  DISPID_IHTMLCURRENTSTYLE_FONTSIZE                             = DISPID_A_FONTSIZE; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDIMAGE                      = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDPOSITIONX                  = DISPID_A_BACKGROUNDPOSX; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDPOSITIONY                  = DISPID_A_BACKGROUNDPOSY; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDREPEAT                     = DISPID_A_BACKGROUNDREPEAT; 
  DISPID_IHTMLCURRENTSTYLE_BORDERLEFTCOLOR                      = DISPID_A_BORDERLEFTCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_BORDERTOPCOLOR                       = DISPID_A_BORDERTOPCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTCOLOR                     = DISPID_A_BORDERRIGHTCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMCOLOR                    = DISPID_A_BORDERBOTTOMCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_BORDERTOPSTYLE                       = DISPID_A_BORDERTOPSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTSTYLE                     = DISPID_A_BORDERRIGHTSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMSTYLE                    = DISPID_A_BORDERBOTTOMSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERLEFTSTYLE                      = DISPID_A_BORDERLEFTSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERTOPWIDTH                       = DISPID_A_BORDERTOPWIDTH; 
  DISPID_IHTMLCURRENTSTYLE_BORDERRIGHTWIDTH                     = DISPID_A_BORDERRIGHTWIDTH; 
  DISPID_IHTMLCURRENTSTYLE_BORDERBOTTOMWIDTH                    = DISPID_A_BORDERBOTTOMWIDTH; 
  DISPID_IHTMLCURRENTSTYLE_BORDERLEFTWIDTH                      = DISPID_A_BORDERLEFTWIDTH; 
  DISPID_IHTMLCURRENTSTYLE_LEFT                                 = STDPROPID_XOBJ_LEFT; 
  DISPID_IHTMLCURRENTSTYLE_TOP                                  = STDPROPID_XOBJ_TOP; 
  DISPID_IHTMLCURRENTSTYLE_WIDTH                                = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLCURRENTSTYLE_HEIGHT                               = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLCURRENTSTYLE_PADDINGLEFT                          = DISPID_A_PADDINGLEFT; 
  DISPID_IHTMLCURRENTSTYLE_PADDINGTOP                           = DISPID_A_PADDINGTOP; 
  DISPID_IHTMLCURRENTSTYLE_PADDINGRIGHT                         = DISPID_A_PADDINGRIGHT; 
  DISPID_IHTMLCURRENTSTYLE_PADDINGBOTTOM                        = DISPID_A_PADDINGBOTTOM; 
  DISPID_IHTMLCURRENTSTYLE_TEXTALIGN                            = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLCURRENTSTYLE_TEXTDECORATION                       = DISPID_A_TEXTDECORATION; 
  DISPID_IHTMLCURRENTSTYLE_DISPLAY                              = DISPID_A_DISPLAY; 
  DISPID_IHTMLCURRENTSTYLE_VISIBILITY                           = DISPID_A_VISIBILITY; 
  DISPID_IHTMLCURRENTSTYLE_ZINDEX                               = DISPID_A_ZINDEX; 
  DISPID_IHTMLCURRENTSTYLE_LETTERSPACING                        = DISPID_A_LETTERSPACING; 
  DISPID_IHTMLCURRENTSTYLE_LINEHEIGHT                           = DISPID_A_LINEHEIGHT; 
  DISPID_IHTMLCURRENTSTYLE_TEXTINDENT                           = DISPID_A_TEXTINDENT; 
  DISPID_IHTMLCURRENTSTYLE_VERTICALALIGN                        = DISPID_A_VERTICALALIGN; 
  DISPID_IHTMLCURRENTSTYLE_BACKGROUNDATTACHMENT                 = DISPID_A_BACKGROUNDATTACHMENT; 
  DISPID_IHTMLCURRENTSTYLE_MARGINTOP                            = DISPID_A_MARGINTOP; 
  DISPID_IHTMLCURRENTSTYLE_MARGINRIGHT                          = DISPID_A_MARGINRIGHT; 
  DISPID_IHTMLCURRENTSTYLE_MARGINBOTTOM                         = DISPID_A_MARGINBOTTOM; 
  DISPID_IHTMLCURRENTSTYLE_MARGINLEFT                           = DISPID_A_MARGINLEFT; 
  DISPID_IHTMLCURRENTSTYLE_CLEAR                                = DISPID_A_CLEAR; 
  DISPID_IHTMLCURRENTSTYLE_LISTSTYLETYPE                        = DISPID_A_LISTSTYLETYPE; 
  DISPID_IHTMLCURRENTSTYLE_LISTSTYLEPOSITION                    = DISPID_A_LISTSTYLEPOSITION; 
  DISPID_IHTMLCURRENTSTYLE_LISTSTYLEIMAGE                       = DISPID_A_LISTSTYLEIMAGE; 
  DISPID_IHTMLCURRENTSTYLE_CLIPTOP                              = DISPID_A_CLIPRECTTOP; 
  DISPID_IHTMLCURRENTSTYLE_CLIPRIGHT                            = DISPID_A_CLIPRECTRIGHT; 
  DISPID_IHTMLCURRENTSTYLE_CLIPBOTTOM                           = DISPID_A_CLIPRECTBOTTOM; 
  DISPID_IHTMLCURRENTSTYLE_CLIPLEFT                             = DISPID_A_CLIPRECTLEFT; 
  DISPID_IHTMLCURRENTSTYLE_OVERFLOW                             = DISPID_A_OVERFLOW; 
  DISPID_IHTMLCURRENTSTYLE_PAGEBREAKBEFORE                      = DISPID_A_PAGEBREAKBEFORE; 
  DISPID_IHTMLCURRENTSTYLE_PAGEBREAKAFTER                       = DISPID_A_PAGEBREAKAFTER; 
  DISPID_IHTMLCURRENTSTYLE_CURSOR                               = DISPID_A_CURSOR; 
  DISPID_IHTMLCURRENTSTYLE_TABLELAYOUT                          = DISPID_A_TABLELAYOUT; 
  DISPID_IHTMLCURRENTSTYLE_BORDERCOLLAPSE                       = DISPID_A_BORDERCOLLAPSE; 
  DISPID_IHTMLCURRENTSTYLE_DIRECTION                            = DISPID_A_DIRECTION; 
  DISPID_IHTMLCURRENTSTYLE_BEHAVIOR                             = DISPID_A_BEHAVIOR; 
  DISPID_IHTMLCURRENTSTYLE_GETATTRIBUTE                         = DISPID_HTMLOBJECT+2; 
  DISPID_IHTMLCURRENTSTYLE_UNICODEBIDI                          = DISPID_A_UNICODEBIDI; 
  DISPID_IHTMLCURRENTSTYLE_RIGHT                                = STDPROPID_XOBJ_RIGHT; 
  DISPID_IHTMLCURRENTSTYLE_BOTTOM                               = STDPROPID_XOBJ_BOTTOM; 
  DISPID_IHTMLCURRENTSTYLE_IMEMODE                              = DISPID_A_IMEMODE; 
  DISPID_IHTMLCURRENTSTYLE_RUBYALIGN                            = DISPID_A_RUBYALIGN; 
  DISPID_IHTMLCURRENTSTYLE_RUBYPOSITION                         = DISPID_A_RUBYPOSITION; 
  DISPID_IHTMLCURRENTSTYLE_RUBYOVERHANG                         = DISPID_A_RUBYOVERHANG; 
  DISPID_IHTMLCURRENTSTYLE_TEXTAUTOSPACE                        = DISPID_A_TEXTAUTOSPACE; 
  DISPID_IHTMLCURRENTSTYLE_LINEBREAK                            = DISPID_A_LINEBREAK; 
  DISPID_IHTMLCURRENTSTYLE_WORDBREAK                            = DISPID_A_WORDBREAK; 
  DISPID_IHTMLCURRENTSTYLE_TEXTJUSTIFY                          = DISPID_A_TEXTJUSTIFY; 
  DISPID_IHTMLCURRENTSTYLE_TEXTJUSTIFYTRIM                      = DISPID_A_TEXTJUSTIFYTRIM; 
  DISPID_IHTMLCURRENTSTYLE_TEXTKASHIDA                          = DISPID_A_TEXTKASHIDA; 
  DISPID_IHTMLCURRENTSTYLE_BLOCKDIRECTION                       = DISPID_A_DIR; 
  DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDCHAR                       = DISPID_A_LAYOUTGRIDCHAR; 
  DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDLINE                       = DISPID_A_LAYOUTGRIDLINE; 
  DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDMODE                       = DISPID_A_LAYOUTGRIDMODE; 
  DISPID_IHTMLCURRENTSTYLE_LAYOUTGRIDTYPE                       = DISPID_A_LAYOUTGRIDTYPE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERSTYLE                          = DISPID_A_BORDERSTYLE; 
  DISPID_IHTMLCURRENTSTYLE_BORDERCOLOR                          = DISPID_A_BORDERCOLOR; 
  DISPID_IHTMLCURRENTSTYLE_BORDERWIDTH                          = DISPID_A_BORDERWIDTH; 
  DISPID_IHTMLCURRENTSTYLE_PADDING                              = DISPID_A_PADDING; 
  DISPID_IHTMLCURRENTSTYLE_MARGIN                               = DISPID_A_MARGIN; 
  DISPID_IHTMLCURRENTSTYLE_ACCELERATOR                          = DISPID_A_ACCELERATOR; 
  DISPID_IHTMLCURRENTSTYLE_OVERFLOWX                            = DISPID_A_OVERFLOWX; 
  DISPID_IHTMLCURRENTSTYLE_OVERFLOWY                            = DISPID_A_OVERFLOWY; 
  DISPID_IHTMLCURRENTSTYLE_TEXTTRANSFORM                        = DISPID_A_TEXTTRANSFORM; 

{    DISPIDs for interface IHTMLCurrentStyle2 }

  DISPID_IHTMLCURRENTSTYLE2_LAYOUTFLOW                          = DISPID_A_LAYOUTFLOW; 
  DISPID_IHTMLCURRENTSTYLE2_WORDWRAP                            = DISPID_A_WORDWRAP; 
  DISPID_IHTMLCURRENTSTYLE2_TEXTUNDERLINEPOSITION               = DISPID_A_TEXTUNDERLINEPOSITION; 
  DISPID_IHTMLCURRENTSTYLE2_HASLAYOUT                           = DISPID_A_HASLAYOUT; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARBASECOLOR                  = DISPID_A_SCROLLBARBASECOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARFACECOLOR                  = DISPID_A_SCROLLBARFACECOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBAR3DLIGHTCOLOR               = DISPID_A_SCROLLBAR3DLIGHTCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARSHADOWCOLOR                = DISPID_A_SCROLLBARSHADOWCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARHIGHLIGHTCOLOR             = DISPID_A_SCROLLBARHIGHLIGHTCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARDARKSHADOWCOLOR            = DISPID_A_SCROLLBARDARKSHADOWCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARARROWCOLOR                 = DISPID_A_SCROLLBARARROWCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_SCROLLBARTRACKCOLOR                 = DISPID_A_SCROLLBARTRACKCOLOR; 
  DISPID_IHTMLCURRENTSTYLE2_WRITINGMODE                         = DISPID_A_WRITINGMODE; 
  DISPID_IHTMLCURRENTSTYLE2_ZOOM                                = DISPID_A_ZOOM; 
  DISPID_IHTMLCURRENTSTYLE2_FILTER                              = DISPID_A_FILTER; 
  DISPID_IHTMLCURRENTSTYLE2_TEXTALIGNLAST                       = DISPID_A_TEXTALIGNLAST; 
  DISPID_IHTMLCURRENTSTYLE2_TEXTKASHIDASPACE                    = DISPID_A_TEXTKASHIDASPACE; 
  DISPID_IHTMLCURRENTSTYLE2_ISBLOCK                             = DISPID_A_ISBLOCK; 

{    DISPIDs for interface IHTMLCurrentStyle3 }

  DISPID_IHTMLCURRENTSTYLE3_TEXTOVERFLOW                        = DISPID_A_TEXTOVERFLOW; 
  DISPID_IHTMLCURRENTSTYLE3_MINHEIGHT                           = DISPID_A_MINHEIGHT; 
  DISPID_IHTMLCURRENTSTYLE3_WORDSPACING                         = DISPID_A_WORDSPACING; 
  DISPID_IHTMLCURRENTSTYLE3_WHITESPACE                          = DISPID_A_WHITESPACE; 

{    DISPIDs for interface IHTMLRect }

  DISPID_IHTMLRECT_LEFT                                         = DISPID_OMRECT+1; 
  DISPID_IHTMLRECT_TOP                                          = DISPID_OMRECT+2; 
  DISPID_IHTMLRECT_RIGHT                                        = DISPID_OMRECT+3; 
  DISPID_IHTMLRECT_BOTTOM                                       = DISPID_OMRECT+4; 

{    DISPIDs for interface IHTMLRectCollection }

  DISPID_IHTMLRECTCOLLECTION_LENGTH                             = DISPID_COLLECTION; 
  DISPID_IHTMLRECTCOLLECTION__NEWENUM                           = DISPID_NEWENUM; 
  DISPID_IHTMLRECTCOLLECTION_ITEM                               = DISPID_VALUE; 

{    DISPIDs for interface IHTMLDOMNode }

  DISPID_IHTMLDOMNODE_NODETYPE                                  = DISPID_ELEMENT+46; 
  DISPID_IHTMLDOMNODE_PARENTNODE                                = DISPID_ELEMENT+47; 
  DISPID_IHTMLDOMNODE_HASCHILDNODES                             = DISPID_ELEMENT+48; 
  DISPID_IHTMLDOMNODE_CHILDNODES                                = DISPID_ELEMENT+49; 
  DISPID_IHTMLDOMNODE_ATTRIBUTES                                = DISPID_ELEMENT+50; 
  DISPID_IHTMLDOMNODE_INSERTBEFORE                              = DISPID_ELEMENT+51; 
  DISPID_IHTMLDOMNODE_REMOVECHILD                               = DISPID_ELEMENT+52; 
  DISPID_IHTMLDOMNODE_REPLACECHILD                              = DISPID_ELEMENT+53; 
  DISPID_IHTMLDOMNODE_CLONENODE                                 = DISPID_ELEMENT+61; 
  DISPID_IHTMLDOMNODE_REMOVENODE                                = DISPID_ELEMENT+66; 
  DISPID_IHTMLDOMNODE_SWAPNODE                                  = DISPID_ELEMENT+68; 
  DISPID_IHTMLDOMNODE_REPLACENODE                               = DISPID_ELEMENT+67; 
  DISPID_IHTMLDOMNODE_APPENDCHILD                               = DISPID_ELEMENT+73; 
  DISPID_IHTMLDOMNODE_NODENAME                                  = DISPID_ELEMENT+74; 
  DISPID_IHTMLDOMNODE_NODEVALUE                                 = DISPID_ELEMENT+75; 
  DISPID_IHTMLDOMNODE_FIRSTCHILD                                = DISPID_ELEMENT+76; 
  DISPID_IHTMLDOMNODE_LASTCHILD                                 = DISPID_ELEMENT+77; 
  DISPID_IHTMLDOMNODE_PREVIOUSSIBLING                           = DISPID_ELEMENT+78; 
  DISPID_IHTMLDOMNODE_NEXTSIBLING                               = DISPID_ELEMENT+79; 

{    DISPIDs for interface IHTMLDOMNode2 }

  DISPID_IHTMLDOMNODE2_OWNERDOCUMENT                            = DISPID_ELEMENT+113; 

{    DISPIDs for interface IHTMLDOMAttribute }

  DISPID_IHTMLDOMATTRIBUTE_NODENAME                             = DISPID_DOMATTRIBUTE; 
  DISPID_IHTMLDOMATTRIBUTE_NODEVALUE                            = DISPID_DOMATTRIBUTE+2; 
  DISPID_IHTMLDOMATTRIBUTE_SPECIFIED                            = DISPID_DOMATTRIBUTE+1; 

{    DISPIDs for interface IHTMLDOMAttribute2 }

  DISPID_IHTMLDOMATTRIBUTE2_NAME                                = DISPID_DOMATTRIBUTE+3; 
  DISPID_IHTMLDOMATTRIBUTE2_VALUE                               = DISPID_DOMATTRIBUTE+4; 
  DISPID_IHTMLDOMATTRIBUTE2_EXPANDO                             = DISPID_DOMATTRIBUTE+5; 
  DISPID_IHTMLDOMATTRIBUTE2_NODETYPE                            = DISPID_DOMATTRIBUTE+6; 
  DISPID_IHTMLDOMATTRIBUTE2_PARENTNODE                          = DISPID_DOMATTRIBUTE+7; 
  DISPID_IHTMLDOMATTRIBUTE2_CHILDNODES                          = DISPID_DOMATTRIBUTE+8; 
  DISPID_IHTMLDOMATTRIBUTE2_FIRSTCHILD                          = DISPID_DOMATTRIBUTE+9; 
  DISPID_IHTMLDOMATTRIBUTE2_LASTCHILD                           = DISPID_DOMATTRIBUTE+10; 
  DISPID_IHTMLDOMATTRIBUTE2_PREVIOUSSIBLING                     = DISPID_DOMATTRIBUTE+11; 
  DISPID_IHTMLDOMATTRIBUTE2_NEXTSIBLING                         = DISPID_DOMATTRIBUTE+12; 
  DISPID_IHTMLDOMATTRIBUTE2_ATTRIBUTES                          = DISPID_DOMATTRIBUTE+13; 
  DISPID_IHTMLDOMATTRIBUTE2_OWNERDOCUMENT                       = DISPID_DOMATTRIBUTE+14; 
  DISPID_IHTMLDOMATTRIBUTE2_INSERTBEFORE                        = DISPID_DOMATTRIBUTE+15; 
  DISPID_IHTMLDOMATTRIBUTE2_REPLACECHILD                        = DISPID_DOMATTRIBUTE+16; 
  DISPID_IHTMLDOMATTRIBUTE2_REMOVECHILD                         = DISPID_DOMATTRIBUTE+17; 
  DISPID_IHTMLDOMATTRIBUTE2_APPENDCHILD                         = DISPID_DOMATTRIBUTE+18; 
  DISPID_IHTMLDOMATTRIBUTE2_HASCHILDNODES                       = DISPID_DOMATTRIBUTE+19; 
  DISPID_IHTMLDOMATTRIBUTE2_CLONENODE                           = DISPID_DOMATTRIBUTE+20; 

{    DISPIDs for interface IHTMLDOMTextNode }

  DISPID_IHTMLDOMTEXTNODE_DATA                                  = DISPID_DOMTEXTNODE; 
  DISPID_IHTMLDOMTEXTNODE_TOSTRING                              = DISPID_DOMTEXTNODE+1; 
  DISPID_IHTMLDOMTEXTNODE_LENGTH                                = DISPID_DOMTEXTNODE+2; 
  DISPID_IHTMLDOMTEXTNODE_SPLITTEXT                             = DISPID_DOMTEXTNODE+3; 

{    DISPIDs for interface IHTMLDOMTextNode2 }

  DISPID_IHTMLDOMTEXTNODE2_SUBSTRINGDATA                        = DISPID_DOMTEXTNODE+4; 
  DISPID_IHTMLDOMTEXTNODE2_APPENDDATA                           = DISPID_DOMTEXTNODE+5; 
  DISPID_IHTMLDOMTEXTNODE2_INSERTDATA                           = DISPID_DOMTEXTNODE+6; 
  DISPID_IHTMLDOMTEXTNODE2_DELETEDATA                           = DISPID_DOMTEXTNODE+7; 
  DISPID_IHTMLDOMTEXTNODE2_REPLACEDATA                          = DISPID_DOMTEXTNODE+8; 

{    DISPIDs for interface IHTMLDOMImplementation }

  DISPID_IHTMLDOMIMPLEMENTATION_HASFEATURE                      = DISPID_DOMIMPLEMENTATION; 

{    DISPIDs for interface IHTMLAttributeCollection }

  DISPID_IHTMLATTRIBUTECOLLECTION_LENGTH                        = DISPID_COLLECTION; 
  DISPID_IHTMLATTRIBUTECOLLECTION__NEWENUM                      = DISPID_NEWENUM; 
  DISPID_IHTMLATTRIBUTECOLLECTION_ITEM                          = DISPID_VALUE; 

{    DISPIDs for interface IHTMLAttributeCollection2 }

  DISPID_IHTMLATTRIBUTECOLLECTION2_GETNAMEDITEM                 = DISPID_COLLECTION+1; 
  DISPID_IHTMLATTRIBUTECOLLECTION2_SETNAMEDITEM                 = DISPID_COLLECTION+2; 
  DISPID_IHTMLATTRIBUTECOLLECTION2_REMOVENAMEDITEM              = DISPID_COLLECTION+3; 

{    DISPIDs for interface IHTMLDOMChildrenCollection }

  DISPID_IHTMLDOMCHILDRENCOLLECTION_LENGTH                      = DISPID_COLLECTION; 
  DISPID_IHTMLDOMCHILDRENCOLLECTION__NEWENUM                    = DISPID_NEWENUM; 
  DISPID_IHTMLDOMCHILDRENCOLLECTION_ITEM                        = DISPID_VALUE; 

{    DISPIDs for interface IHTMLElement }

  DISPID_IHTMLELEMENT_SETATTRIBUTE                              = DISPID_HTMLOBJECT+1; 
  DISPID_IHTMLELEMENT_GETATTRIBUTE                              = DISPID_HTMLOBJECT+2; 
  DISPID_IHTMLELEMENT_REMOVEATTRIBUTE                           = DISPID_HTMLOBJECT+3; 
  DISPID_IHTMLELEMENT_CLASSNAME                                 = DISPID_ELEMENT+1; 
  DISPID_IHTMLELEMENT_ID                                        = DISPID_ELEMENT+2; 
  DISPID_IHTMLELEMENT_TAGNAME                                   = DISPID_ELEMENT+4; 
  DISPID_IHTMLELEMENT_PARENTELEMENT                             = STDPROPID_XOBJ_PARENT; 
  DISPID_IHTMLELEMENT_STYLE                                     = STDPROPID_XOBJ_STYLE; 
  DISPID_IHTMLELEMENT_ONHELP                                    = DISPID_EVPROP_ONHELP; 
  DISPID_IHTMLELEMENT_ONCLICK                                   = DISPID_EVPROP_ONCLICK; 
  DISPID_IHTMLELEMENT_ONDBLCLICK                                = DISPID_EVPROP_ONDBLCLICK; 
  DISPID_IHTMLELEMENT_ONKEYDOWN                                 = DISPID_EVPROP_ONKEYDOWN; 
  DISPID_IHTMLELEMENT_ONKEYUP                                   = DISPID_EVPROP_ONKEYUP; 
  DISPID_IHTMLELEMENT_ONKEYPRESS                                = DISPID_EVPROP_ONKEYPRESS; 
  DISPID_IHTMLELEMENT_ONMOUSEOUT                                = DISPID_EVPROP_ONMOUSEOUT; 
  DISPID_IHTMLELEMENT_ONMOUSEOVER                               = DISPID_EVPROP_ONMOUSEOVER; 
  DISPID_IHTMLELEMENT_ONMOUSEMOVE                               = DISPID_EVPROP_ONMOUSEMOVE; 
  DISPID_IHTMLELEMENT_ONMOUSEDOWN                               = DISPID_EVPROP_ONMOUSEDOWN; 
  DISPID_IHTMLELEMENT_ONMOUSEUP                                 = DISPID_EVPROP_ONMOUSEUP; 
  DISPID_IHTMLELEMENT_DOCUMENT                                  = DISPID_ELEMENT+18; 
  DISPID_IHTMLELEMENT_TITLE                                     = STDPROPID_XOBJ_CONTROLTIPTEXT; 
  DISPID_IHTMLELEMENT_LANGUAGE                                  = DISPID_A_LANGUAGE; 
  DISPID_IHTMLELEMENT_ONSELECTSTART                             = DISPID_EVPROP_ONSELECTSTART; 
  DISPID_IHTMLELEMENT_SCROLLINTOVIEW                            = DISPID_ELEMENT+19; 
  DISPID_IHTMLELEMENT_CONTAINS                                  = DISPID_ELEMENT+20; 
  DISPID_IHTMLELEMENT_SOURCEINDEX                               = DISPID_ELEMENT+24; 
  DISPID_IHTMLELEMENT_RECORDNUMBER                              = DISPID_ELEMENT+25; 
  DISPID_IHTMLELEMENT_LANG                                      = DISPID_A_LANG; 
  DISPID_IHTMLELEMENT_OFFSETLEFT                                = DISPID_ELEMENT+8; 
  DISPID_IHTMLELEMENT_OFFSETTOP                                 = DISPID_ELEMENT+9; 
  DISPID_IHTMLELEMENT_OFFSETWIDTH                               = DISPID_ELEMENT+10; 
  DISPID_IHTMLELEMENT_OFFSETHEIGHT                              = DISPID_ELEMENT+11; 
  DISPID_IHTMLELEMENT_OFFSETPARENT                              = DISPID_ELEMENT+12; 
  DISPID_IHTMLELEMENT_INNERHTML                                 = DISPID_ELEMENT+26; 
  DISPID_IHTMLELEMENT_INNERTEXT                                 = DISPID_ELEMENT+27; 
  DISPID_IHTMLELEMENT_OUTERHTML                                 = DISPID_ELEMENT+28; 
  DISPID_IHTMLELEMENT_OUTERTEXT                                 = DISPID_ELEMENT+29; 
  DISPID_IHTMLELEMENT_INSERTADJACENTHTML                        = DISPID_ELEMENT+30; 
  DISPID_IHTMLELEMENT_INSERTADJACENTTEXT                        = DISPID_ELEMENT+31; 
  DISPID_IHTMLELEMENT_PARENTTEXTEDIT                            = DISPID_ELEMENT+32; 
  DISPID_IHTMLELEMENT_ISTEXTEDIT                                = DISPID_ELEMENT+34; 
  DISPID_IHTMLELEMENT_CLICK                                     = DISPID_ELEMENT+33; 
  DISPID_IHTMLELEMENT_FILTERS                                   = DISPID_ELEMENT+35; 
  DISPID_IHTMLELEMENT_ONDRAGSTART                               = DISPID_EVPROP_ONDRAGSTART; 
  DISPID_IHTMLELEMENT_TOSTRING                                  = DISPID_ELEMENT+36; 
  DISPID_IHTMLELEMENT_ONBEFOREUPDATE                            = DISPID_EVPROP_ONBEFOREUPDATE; 
  DISPID_IHTMLELEMENT_ONAFTERUPDATE                             = DISPID_EVPROP_ONAFTERUPDATE; 
  DISPID_IHTMLELEMENT_ONERRORUPDATE                             = DISPID_EVPROP_ONERRORUPDATE; 
  DISPID_IHTMLELEMENT_ONROWEXIT                                 = DISPID_EVPROP_ONROWEXIT; 
  DISPID_IHTMLELEMENT_ONROWENTER                                = DISPID_EVPROP_ONROWENTER; 
  DISPID_IHTMLELEMENT_ONDATASETCHANGED                          = DISPID_EVPROP_ONDATASETCHANGED; 
  DISPID_IHTMLELEMENT_ONDATAAVAILABLE                           = DISPID_EVPROP_ONDATAAVAILABLE; 
  DISPID_IHTMLELEMENT_ONDATASETCOMPLETE                         = DISPID_EVPROP_ONDATASETCOMPLETE; 
  DISPID_IHTMLELEMENT_ONFILTERCHANGE                            = DISPID_EVPROP_ONFILTER; 
  DISPID_IHTMLELEMENT_CHILDREN                                  = DISPID_ELEMENT+37; 
  DISPID_IHTMLELEMENT_ALL                                       = DISPID_ELEMENT+38; 

{    DISPIDs for interface IHTMLElement2 }

  DISPID_IHTMLELEMENT2_SCOPENAME                                = DISPID_ELEMENT+39; 
  DISPID_IHTMLELEMENT2_SETCAPTURE                               = DISPID_ELEMENT+40; 
  DISPID_IHTMLELEMENT2_RELEASECAPTURE                           = DISPID_ELEMENT+41; 
  DISPID_IHTMLELEMENT2_ONLOSECAPTURE                            = DISPID_EVPROP_ONLOSECAPTURE; 
  DISPID_IHTMLELEMENT2_COMPONENTFROMPOINT                       = DISPID_ELEMENT+42; 
  DISPID_IHTMLELEMENT2_DOSCROLL                                 = DISPID_ELEMENT+43; 
  DISPID_IHTMLELEMENT2_ONSCROLL                                 = DISPID_EVPROP_ONSCROLL; 
  DISPID_IHTMLELEMENT2_ONDRAG                                   = DISPID_EVPROP_ONDRAG; 
  DISPID_IHTMLELEMENT2_ONDRAGEND                                = DISPID_EVPROP_ONDRAGEND; 
  DISPID_IHTMLELEMENT2_ONDRAGENTER                              = DISPID_EVPROP_ONDRAGENTER; 
  DISPID_IHTMLELEMENT2_ONDRAGOVER                               = DISPID_EVPROP_ONDRAGOVER; 
  DISPID_IHTMLELEMENT2_ONDRAGLEAVE                              = DISPID_EVPROP_ONDRAGLEAVE; 
  DISPID_IHTMLELEMENT2_ONDROP                                   = DISPID_EVPROP_ONDROP; 
  DISPID_IHTMLELEMENT2_ONBEFORECUT                              = DISPID_EVPROP_ONBEFORECUT; 
  DISPID_IHTMLELEMENT2_ONCUT                                    = DISPID_EVPROP_ONCUT; 
  DISPID_IHTMLELEMENT2_ONBEFORECOPY                             = DISPID_EVPROP_ONBEFORECOPY; 
  DISPID_IHTMLELEMENT2_ONCOPY                                   = DISPID_EVPROP_ONCOPY; 
  DISPID_IHTMLELEMENT2_ONBEFOREPASTE                            = DISPID_EVPROP_ONBEFOREPASTE; 
  DISPID_IHTMLELEMENT2_ONPASTE                                  = DISPID_EVPROP_ONPASTE; 
  DISPID_IHTMLELEMENT2_CURRENTSTYLE                             = DISPID_ELEMENT+7; 
  DISPID_IHTMLELEMENT2_ONPROPERTYCHANGE                         = DISPID_EVPROP_ONPROPERTYCHANGE; 
  DISPID_IHTMLELEMENT2_GETCLIENTRECTS                           = DISPID_ELEMENT+44; 
  DISPID_IHTMLELEMENT2_GETBOUNDINGCLIENTRECT                    = DISPID_ELEMENT+45; 
  DISPID_IHTMLELEMENT2_SETEXPRESSION                            = DISPID_HTMLOBJECT+4; 
  DISPID_IHTMLELEMENT2_GETEXPRESSION                            = DISPID_HTMLOBJECT+5; 
  DISPID_IHTMLELEMENT2_REMOVEEXPRESSION                         = DISPID_HTMLOBJECT+6; 
  DISPID_IHTMLELEMENT2_TABINDEX                                 = STDPROPID_XOBJ_TABINDEX; 
  DISPID_IHTMLELEMENT2_FOCUS                                    = DISPID_SITE+0; 
  DISPID_IHTMLELEMENT2_ACCESSKEY                                = DISPID_SITE+5; 
  DISPID_IHTMLELEMENT2_ONBLUR                                   = DISPID_EVPROP_ONBLUR; 
  DISPID_IHTMLELEMENT2_ONFOCUS                                  = DISPID_EVPROP_ONFOCUS; 
  DISPID_IHTMLELEMENT2_ONRESIZE                                 = DISPID_EVPROP_ONRESIZE; 
  DISPID_IHTMLELEMENT2_BLUR                                     = DISPID_SITE+2; 
  DISPID_IHTMLELEMENT2_ADDFILTER                                = DISPID_SITE+17; 
  DISPID_IHTMLELEMENT2_REMOVEFILTER                             = DISPID_SITE+18; 
  DISPID_IHTMLELEMENT2_CLIENTHEIGHT                             = DISPID_SITE+19; 
  DISPID_IHTMLELEMENT2_CLIENTWIDTH                              = DISPID_SITE+20; 
  DISPID_IHTMLELEMENT2_CLIENTTOP                                = DISPID_SITE+21; 
  DISPID_IHTMLELEMENT2_CLIENTLEFT                               = DISPID_SITE+22; 
  DISPID_IHTMLELEMENT2_ATTACHEVENT                              = DISPID_HTMLOBJECT+7; 
  DISPID_IHTMLELEMENT2_DETACHEVENT                              = DISPID_HTMLOBJECT+8; 
  DISPID_IHTMLELEMENT2_READYSTATE                               = DISPID_A_READYSTATE; 
  DISPID_IHTMLELEMENT2_ONREADYSTATECHANGE                       = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLELEMENT2_ONROWSDELETE                             = DISPID_EVPROP_ONROWSDELETE; 
  DISPID_IHTMLELEMENT2_ONROWSINSERTED                           = DISPID_EVPROP_ONROWSINSERTED; 
  DISPID_IHTMLELEMENT2_ONCELLCHANGE                             = DISPID_EVPROP_ONCELLCHANGE; 
  DISPID_IHTMLELEMENT2_DIR                                      = DISPID_A_DIR; 
  DISPID_IHTMLELEMENT2_CREATECONTROLRANGE                       = DISPID_ELEMENT+56; 
  DISPID_IHTMLELEMENT2_SCROLLHEIGHT                             = DISPID_ELEMENT+57; 
  DISPID_IHTMLELEMENT2_SCROLLWIDTH                              = DISPID_ELEMENT+58; 
  DISPID_IHTMLELEMENT2_SCROLLTOP                                = DISPID_ELEMENT+59; 
  DISPID_IHTMLELEMENT2_SCROLLLEFT                               = DISPID_ELEMENT+60; 
  DISPID_IHTMLELEMENT2_CLEARATTRIBUTES                          = DISPID_ELEMENT+62; 
  DISPID_IHTMLELEMENT2_MERGEATTRIBUTES                          = DISPID_ELEMENT+63; 
  DISPID_IHTMLELEMENT2_ONCONTEXTMENU                            = DISPID_EVPROP_ONCONTEXTMENU; 
  DISPID_IHTMLELEMENT2_INSERTADJACENTELEMENT                    = DISPID_ELEMENT+69; 
  DISPID_IHTMLELEMENT2_APPLYELEMENT                             = DISPID_ELEMENT+65; 
  DISPID_IHTMLELEMENT2_GETADJACENTTEXT                          = DISPID_ELEMENT+70; 
  DISPID_IHTMLELEMENT2_REPLACEADJACENTTEXT                      = DISPID_ELEMENT+71; 
  DISPID_IHTMLELEMENT2_CANHAVECHILDREN                          = DISPID_ELEMENT+72; 
  DISPID_IHTMLELEMENT2_ADDBEHAVIOR                              = DISPID_ELEMENT+80; 
  DISPID_IHTMLELEMENT2_REMOVEBEHAVIOR                           = DISPID_ELEMENT+81; 
  DISPID_IHTMLELEMENT2_RUNTIMESTYLE                             = DISPID_ELEMENT+64; 
  DISPID_IHTMLELEMENT2_BEHAVIORURNS                             = DISPID_ELEMENT+82; 
  DISPID_IHTMLELEMENT2_TAGURN                                   = DISPID_ELEMENT+83; 
  DISPID_IHTMLELEMENT2_ONBEFOREEDITFOCUS                        = DISPID_EVPROP_ONBEFOREEDITFOCUS; 
  DISPID_IHTMLELEMENT2_READYSTATEVALUE                          = DISPID_ELEMENT+84; 
  DISPID_IHTMLELEMENT2_GETELEMENTSBYTAGNAME                     = DISPID_ELEMENT+85; 

{    DISPIDs for interface IHTMLElement3 }

  DISPID_IHTMLELEMENT3_MERGEATTRIBUTES                          = DISPID_ELEMENT+96; 
  DISPID_IHTMLELEMENT3_ISMULTILINE                              = DISPID_ELEMENT+97; 
  DISPID_IHTMLELEMENT3_CANHAVEHTML                              = DISPID_ELEMENT+98; 
  DISPID_IHTMLELEMENT3_ONLAYOUTCOMPLETE                         = DISPID_EVPROP_ONLAYOUTCOMPLETE; 
  DISPID_IHTMLELEMENT3_ONPAGE                                   = DISPID_EVPROP_ONPAGE; 
  DISPID_IHTMLELEMENT3_INFLATEBLOCK                             = DISPID_ELEMENT+100; 
  DISPID_IHTMLELEMENT3_ONBEFOREDEACTIVATE                       = DISPID_EVPROP_ONBEFOREDEACTIVATE; 
  DISPID_IHTMLELEMENT3_SETACTIVE                                = DISPID_ELEMENT+101; 
  DISPID_IHTMLELEMENT3_CONTENTEDITABLE                          = DISPID_A_EDITABLE; 
  DISPID_IHTMLELEMENT3_ISCONTENTEDITABLE                        = DISPID_ELEMENT+102; 
  DISPID_IHTMLELEMENT3_HIDEFOCUS                                = DISPID_A_HIDEFOCUS; 
  DISPID_IHTMLELEMENT3_DISABLED                                 = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLELEMENT3_ISDISABLED                               = DISPID_ELEMENT+105; 
  DISPID_IHTMLELEMENT3_ONMOVE                                   = DISPID_EVPROP_ONMOVE; 
  DISPID_IHTMLELEMENT3_ONCONTROLSELECT                          = DISPID_EVPROP_ONCONTROLSELECT; 
  DISPID_IHTMLELEMENT3_FIREEVENT                                = DISPID_ELEMENT+106; 
  DISPID_IHTMLELEMENT3_ONRESIZESTART                            = DISPID_EVPROP_ONRESIZESTART; 
  DISPID_IHTMLELEMENT3_ONRESIZEEND                              = DISPID_EVPROP_ONRESIZEEND; 
  DISPID_IHTMLELEMENT3_ONMOVESTART                              = DISPID_EVPROP_ONMOVESTART; 
  DISPID_IHTMLELEMENT3_ONMOVEEND                                = DISPID_EVPROP_ONMOVEEND; 
  DISPID_IHTMLELEMENT3_ONMOUSEENTER                             = DISPID_EVPROP_ONMOUSEENTER; 
  DISPID_IHTMLELEMENT3_ONMOUSELEAVE                             = DISPID_EVPROP_ONMOUSELEAVE; 
  DISPID_IHTMLELEMENT3_ONACTIVATE                               = DISPID_EVPROP_ONACTIVATE; 
  DISPID_IHTMLELEMENT3_ONDEACTIVATE                             = DISPID_EVPROP_ONDEACTIVATE; 
  DISPID_IHTMLELEMENT3_DRAGDROP                                 = DISPID_ELEMENT+107; 
  DISPID_IHTMLELEMENT3_GLYPHMODE                                = DISPID_ELEMENT+108; 

{    DISPIDs for interface IHTMLElement4 }

  DISPID_IHTMLELEMENT4_ONMOUSEWHEEL                             = DISPID_EVPROP_ONMOUSEWHEEL; 
  DISPID_IHTMLELEMENT4_NORMALIZE                                = DISPID_ELEMENT+112; 
  DISPID_IHTMLELEMENT4_GETATTRIBUTENODE                         = DISPID_ELEMENT+109; 
  DISPID_IHTMLELEMENT4_SETATTRIBUTENODE                         = DISPID_ELEMENT+110; 
  DISPID_IHTMLELEMENT4_REMOVEATTRIBUTENODE                      = DISPID_ELEMENT+111; 
  DISPID_IHTMLELEMENT4_ONBEFOREACTIVATE                         = DISPID_EVPROP_ONBEFOREACTIVATE; 
  DISPID_IHTMLELEMENT4_ONFOCUSIN                                = DISPID_EVPROP_ONFOCUSIN; 
  DISPID_IHTMLELEMENT4_ONFOCUSOUT                               = DISPID_EVPROP_ONFOCUSOUT; 

{    DISPIDs for interface IHTMLElementRender }

{$DEFINE DISPID_IHTMLELEMENTRENDER_DRAWTODC}
{$DEFINE DISPID_IHTMLELEMENTRENDER_SETDOCUMENTPRINTER}

{    DISPIDs for interface IHTMLUniqueName }

  DISPID_IHTMLUNIQUENAME_UNIQUENUMBER                           = DISPID_ELEMENT+54; 
  DISPID_IHTMLUNIQUENAME_UNIQUEID                               = DISPID_ELEMENT+55; 

{    DISPIDs for interface IHTMLDatabinding }

  DISPID_IHTMLDATABINDING_DATAFLD                               = DISPID_ELEMENT+21; 
  DISPID_IHTMLDATABINDING_DATASRC                               = DISPID_ELEMENT+22; 
  DISPID_IHTMLDATABINDING_DATAFORMATAS                          = DISPID_ELEMENT+23; 

{    DISPIDs for event set HTMLElementEvents2 }

  DISPID_HTMLELEMENTEVENTS2_ONHELP                              = DISPID_EVMETH_ONHELP; 
  DISPID_HTMLELEMENTEVENTS2_ONCLICK                             = DISPID_EVMETH_ONCLICK; 
  DISPID_HTMLELEMENTEVENTS2_ONDBLCLICK                          = DISPID_EVMETH_ONDBLCLICK; 
  DISPID_HTMLELEMENTEVENTS2_ONKEYPRESS                          = DISPID_EVMETH_ONKEYPRESS; 
  DISPID_HTMLELEMENTEVENTS2_ONKEYDOWN                           = DISPID_EVMETH_ONKEYDOWN; 
  DISPID_HTMLELEMENTEVENTS2_ONKEYUP                             = DISPID_EVMETH_ONKEYUP; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEOUT                          = DISPID_EVMETH_ONMOUSEOUT; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEOVER                         = DISPID_EVMETH_ONMOUSEOVER; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEMOVE                         = DISPID_EVMETH_ONMOUSEMOVE; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEDOWN                         = DISPID_EVMETH_ONMOUSEDOWN; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEUP                           = DISPID_EVMETH_ONMOUSEUP; 
  DISPID_HTMLELEMENTEVENTS2_ONSELECTSTART                       = DISPID_EVMETH_ONSELECTSTART; 
  DISPID_HTMLELEMENTEVENTS2_ONFILTERCHANGE                      = DISPID_EVMETH_ONFILTER; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAGSTART                         = DISPID_EVMETH_ONDRAGSTART; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREUPDATE                      = DISPID_EVMETH_ONBEFOREUPDATE; 
  DISPID_HTMLELEMENTEVENTS2_ONAFTERUPDATE                       = DISPID_EVMETH_ONAFTERUPDATE; 
  DISPID_HTMLELEMENTEVENTS2_ONERRORUPDATE                       = DISPID_EVMETH_ONERRORUPDATE; 
  DISPID_HTMLELEMENTEVENTS2_ONROWEXIT                           = DISPID_EVMETH_ONROWEXIT; 
  DISPID_HTMLELEMENTEVENTS2_ONROWENTER                          = DISPID_EVMETH_ONROWENTER; 
  DISPID_HTMLELEMENTEVENTS2_ONDATASETCHANGED                    = DISPID_EVMETH_ONDATASETCHANGED; 
  DISPID_HTMLELEMENTEVENTS2_ONDATAAVAILABLE                     = DISPID_EVMETH_ONDATAAVAILABLE; 
  DISPID_HTMLELEMENTEVENTS2_ONDATASETCOMPLETE                   = DISPID_EVMETH_ONDATASETCOMPLETE; 
  DISPID_HTMLELEMENTEVENTS2_ONLOSECAPTURE                       = DISPID_EVMETH_ONLOSECAPTURE; 
  DISPID_HTMLELEMENTEVENTS2_ONPROPERTYCHANGE                    = DISPID_EVMETH_ONPROPERTYCHANGE; 
  DISPID_HTMLELEMENTEVENTS2_ONSCROLL                            = DISPID_EVMETH_ONSCROLL; 
  DISPID_HTMLELEMENTEVENTS2_ONFOCUS                             = DISPID_EVMETH_ONFOCUS; 
  DISPID_HTMLELEMENTEVENTS2_ONBLUR                              = DISPID_EVMETH_ONBLUR; 
  DISPID_HTMLELEMENTEVENTS2_ONRESIZE                            = DISPID_EVMETH_ONRESIZE; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAG                              = DISPID_EVMETH_ONDRAG; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAGEND                           = DISPID_EVMETH_ONDRAGEND; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAGENTER                         = DISPID_EVMETH_ONDRAGENTER; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAGOVER                          = DISPID_EVMETH_ONDRAGOVER; 
  DISPID_HTMLELEMENTEVENTS2_ONDRAGLEAVE                         = DISPID_EVMETH_ONDRAGLEAVE; 
  DISPID_HTMLELEMENTEVENTS2_ONDROP                              = DISPID_EVMETH_ONDROP; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFORECUT                         = DISPID_EVMETH_ONBEFORECUT; 
  DISPID_HTMLELEMENTEVENTS2_ONCUT                               = DISPID_EVMETH_ONCUT; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFORECOPY                        = DISPID_EVMETH_ONBEFORECOPY; 
  DISPID_HTMLELEMENTEVENTS2_ONCOPY                              = DISPID_EVMETH_ONCOPY; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREPASTE                       = DISPID_EVMETH_ONBEFOREPASTE; 
  DISPID_HTMLELEMENTEVENTS2_ONPASTE                             = DISPID_EVMETH_ONPASTE; 
  DISPID_HTMLELEMENTEVENTS2_ONCONTEXTMENU                       = DISPID_EVMETH_ONCONTEXTMENU; 
  DISPID_HTMLELEMENTEVENTS2_ONROWSDELETE                        = DISPID_EVMETH_ONROWSDELETE; 
  DISPID_HTMLELEMENTEVENTS2_ONROWSINSERTED                      = DISPID_EVMETH_ONROWSINSERTED; 
  DISPID_HTMLELEMENTEVENTS2_ONCELLCHANGE                        = DISPID_EVMETH_ONCELLCHANGE; 
  DISPID_HTMLELEMENTEVENTS2_ONREADYSTATECHANGE                  = DISPID_EVMETH_ONREADYSTATECHANGE; 
  DISPID_HTMLELEMENTEVENTS2_ONLAYOUTCOMPLETE                    = DISPID_EVMETH_ONLAYOUTCOMPLETE; 
  DISPID_HTMLELEMENTEVENTS2_ONPAGE                              = DISPID_EVMETH_ONPAGE; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEENTER                        = DISPID_EVMETH_ONMOUSEENTER; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSELEAVE                        = DISPID_EVMETH_ONMOUSELEAVE; 
  DISPID_HTMLELEMENTEVENTS2_ONACTIVATE                          = DISPID_EVMETH_ONACTIVATE; 
  DISPID_HTMLELEMENTEVENTS2_ONDEACTIVATE                        = DISPID_EVMETH_ONDEACTIVATE; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREDEACTIVATE                  = DISPID_EVMETH_ONBEFOREDEACTIVATE; 
  DISPID_HTMLELEMENTEVENTS2_ONBEFOREACTIVATE                    = DISPID_EVMETH_ONBEFOREACTIVATE; 
  DISPID_HTMLELEMENTEVENTS2_ONFOCUSIN                           = DISPID_EVMETH_ONFOCUSIN; 
  DISPID_HTMLELEMENTEVENTS2_ONFOCUSOUT                          = DISPID_EVMETH_ONFOCUSOUT; 
  DISPID_HTMLELEMENTEVENTS2_ONMOVE                              = DISPID_EVMETH_ONMOVE; 
  DISPID_HTMLELEMENTEVENTS2_ONCONTROLSELECT                     = DISPID_EVMETH_ONCONTROLSELECT; 
  DISPID_HTMLELEMENTEVENTS2_ONMOVESTART                         = DISPID_EVMETH_ONMOVESTART; 
  DISPID_HTMLELEMENTEVENTS2_ONMOVEEND                           = DISPID_EVMETH_ONMOVEEND; 
  DISPID_HTMLELEMENTEVENTS2_ONRESIZESTART                       = DISPID_EVMETH_ONRESIZESTART; 
  DISPID_HTMLELEMENTEVENTS2_ONRESIZEEND                         = DISPID_EVMETH_ONRESIZEEND; 
  DISPID_HTMLELEMENTEVENTS2_ONMOUSEWHEEL                        = DISPID_EVMETH_ONMOUSEWHEEL; 

{    DISPIDs for event set HTMLElementEvents }

  DISPID_HTMLELEMENTEVENTS_ONHELP                               = Integer(DISPID_EVMETH_ONHELP);
  DISPID_HTMLELEMENTEVENTS_ONCLICK                              = Integer(DISPID_EVMETH_ONCLICK);
  DISPID_HTMLELEMENTEVENTS_ONDBLCLICK                           = Integer(DISPID_EVMETH_ONDBLCLICK);
  DISPID_HTMLELEMENTEVENTS_ONKEYPRESS                           = Integer(DISPID_EVMETH_ONKEYPRESS);
  DISPID_HTMLELEMENTEVENTS_ONKEYDOWN                            = Integer(DISPID_EVMETH_ONKEYDOWN);
  DISPID_HTMLELEMENTEVENTS_ONKEYUP                              = Integer(DISPID_EVMETH_ONKEYUP);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEOUT                           = Integer(DISPID_EVMETH_ONMOUSEOUT);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEOVER                          = Integer(DISPID_EVMETH_ONMOUSEOVER);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEMOVE                          = Integer(DISPID_EVMETH_ONMOUSEMOVE);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEDOWN                          = Integer(DISPID_EVMETH_ONMOUSEDOWN);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEUP                            = Integer(DISPID_EVMETH_ONMOUSEUP);
  DISPID_HTMLELEMENTEVENTS_ONSELECTSTART                        = Integer(DISPID_EVMETH_ONSELECTSTART);
  DISPID_HTMLELEMENTEVENTS_ONFILTERCHANGE                       = Integer(DISPID_EVMETH_ONFILTER);
  DISPID_HTMLELEMENTEVENTS_ONDRAGSTART                          = Integer(DISPID_EVMETH_ONDRAGSTART);
  DISPID_HTMLELEMENTEVENTS_ONBEFOREUPDATE                       = Integer(DISPID_EVMETH_ONBEFOREUPDATE);
  DISPID_HTMLELEMENTEVENTS_ONAFTERUPDATE                        = Integer(DISPID_EVMETH_ONAFTERUPDATE);
  DISPID_HTMLELEMENTEVENTS_ONERRORUPDATE                        = Integer(DISPID_EVMETH_ONERRORUPDATE);
  DISPID_HTMLELEMENTEVENTS_ONROWEXIT                            = Integer(DISPID_EVMETH_ONROWEXIT);
  DISPID_HTMLELEMENTEVENTS_ONROWENTER                           = Integer(DISPID_EVMETH_ONROWENTER);
  DISPID_HTMLELEMENTEVENTS_ONDATASETCHANGED                     = Integer(DISPID_EVMETH_ONDATASETCHANGED);
  DISPID_HTMLELEMENTEVENTS_ONDATAAVAILABLE                      = Integer(DISPID_EVMETH_ONDATAAVAILABLE);
  DISPID_HTMLELEMENTEVENTS_ONDATASETCOMPLETE                    = Integer(DISPID_EVMETH_ONDATASETCOMPLETE);
  DISPID_HTMLELEMENTEVENTS_ONLOSECAPTURE                        = Integer(DISPID_EVMETH_ONLOSECAPTURE);
  DISPID_HTMLELEMENTEVENTS_ONPROPERTYCHANGE                     = Integer(DISPID_EVMETH_ONPROPERTYCHANGE);
  DISPID_HTMLELEMENTEVENTS_ONSCROLL                             = Integer(DISPID_EVMETH_ONSCROLL);
  DISPID_HTMLELEMENTEVENTS_ONFOCUS                              = Integer(DISPID_EVMETH_ONFOCUS);
  DISPID_HTMLELEMENTEVENTS_ONBLUR                               = Integer(DISPID_EVMETH_ONBLUR);
  DISPID_HTMLELEMENTEVENTS_ONRESIZE                             = Integer(DISPID_EVMETH_ONRESIZE);
  DISPID_HTMLELEMENTEVENTS_ONDRAG                               = Integer(DISPID_EVMETH_ONDRAG);
  DISPID_HTMLELEMENTEVENTS_ONDRAGEND                            = Integer(DISPID_EVMETH_ONDRAGEND);
  DISPID_HTMLELEMENTEVENTS_ONDRAGENTER                          = Integer(DISPID_EVMETH_ONDRAGENTER);
  DISPID_HTMLELEMENTEVENTS_ONDRAGOVER                           = Integer(DISPID_EVMETH_ONDRAGOVER);
  DISPID_HTMLELEMENTEVENTS_ONDRAGLEAVE                          = Integer(DISPID_EVMETH_ONDRAGLEAVE);
  DISPID_HTMLELEMENTEVENTS_ONDROP                               = Integer(DISPID_EVMETH_ONDROP);
  DISPID_HTMLELEMENTEVENTS_ONBEFORECUT                          = Integer(DISPID_EVMETH_ONBEFORECUT);
  DISPID_HTMLELEMENTEVENTS_ONCUT                                = Integer(DISPID_EVMETH_ONCUT);
  DISPID_HTMLELEMENTEVENTS_ONBEFORECOPY                         = Integer(DISPID_EVMETH_ONBEFORECOPY);
  DISPID_HTMLELEMENTEVENTS_ONCOPY                               = Integer(DISPID_EVMETH_ONCOPY);
  DISPID_HTMLELEMENTEVENTS_ONBEFOREPASTE                        = Integer(DISPID_EVMETH_ONBEFOREPASTE);
  DISPID_HTMLELEMENTEVENTS_ONPASTE                              = Integer(DISPID_EVMETH_ONPASTE);
  DISPID_HTMLELEMENTEVENTS_ONCONTEXTMENU                        = Integer(DISPID_EVMETH_ONCONTEXTMENU);
  DISPID_HTMLELEMENTEVENTS_ONROWSDELETE                         = Integer(DISPID_EVMETH_ONROWSDELETE);
  DISPID_HTMLELEMENTEVENTS_ONROWSINSERTED                       = Integer(DISPID_EVMETH_ONROWSINSERTED);
  DISPID_HTMLELEMENTEVENTS_ONCELLCHANGE                         = Integer(DISPID_EVMETH_ONCELLCHANGE);
  DISPID_HTMLELEMENTEVENTS_ONREADYSTATECHANGE                   = Integer(DISPID_EVMETH_ONREADYSTATECHANGE);
  DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS                    = Integer(DISPID_EVMETH_ONBEFOREEDITFOCUS);
  DISPID_HTMLELEMENTEVENTS_ONLAYOUTCOMPLETE                     = Integer(DISPID_EVMETH_ONLAYOUTCOMPLETE);
  DISPID_HTMLELEMENTEVENTS_ONPAGE                               = Integer(DISPID_EVMETH_ONPAGE);
  DISPID_HTMLELEMENTEVENTS_ONBEFOREDEACTIVATE                   = Integer(DISPID_EVMETH_ONBEFOREDEACTIVATE);
  DISPID_HTMLELEMENTEVENTS_ONBEFOREACTIVATE                     = Integer(DISPID_EVMETH_ONBEFOREACTIVATE);
  DISPID_HTMLELEMENTEVENTS_ONMOVE                               = Integer(DISPID_EVMETH_ONMOVE);
  DISPID_HTMLELEMENTEVENTS_ONCONTROLSELECT                      = Integer(DISPID_EVMETH_ONCONTROLSELECT);
  DISPID_HTMLELEMENTEVENTS_ONMOVESTART                          = Integer(DISPID_EVMETH_ONMOVESTART);
  DISPID_HTMLELEMENTEVENTS_ONMOVEEND                            = Integer(DISPID_EVMETH_ONMOVEEND);
  DISPID_HTMLELEMENTEVENTS_ONRESIZESTART                        = Integer(DISPID_EVMETH_ONRESIZESTART);
  DISPID_HTMLELEMENTEVENTS_ONRESIZEEND                          = Integer(DISPID_EVMETH_ONRESIZEEND);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEENTER                         = Integer(DISPID_EVMETH_ONMOUSEENTER);
  DISPID_HTMLELEMENTEVENTS_ONMOUSELEAVE                         = Integer(DISPID_EVMETH_ONMOUSELEAVE);
  DISPID_HTMLELEMENTEVENTS_ONMOUSEWHEEL                         = Integer(DISPID_EVMETH_ONMOUSEWHEEL);
  DISPID_HTMLELEMENTEVENTS_ONACTIVATE                           = Integer(DISPID_EVMETH_ONACTIVATE);
  DISPID_HTMLELEMENTEVENTS_ONDEACTIVATE                         = Integer(DISPID_EVMETH_ONDEACTIVATE);
  DISPID_HTMLELEMENTEVENTS_ONFOCUSIN                            = Integer(DISPID_EVMETH_ONFOCUSIN);
  DISPID_HTMLELEMENTEVENTS_ONFOCUSOUT                           = Integer(DISPID_EVMETH_ONFOCUSOUT);

{    DISPIDs for interface IHTMLElementDefaults }

  DISPID_IHTMLELEMENTDEFAULTS_STYLE                             = DISPID_DEFAULTS+1; 
  DISPID_IHTMLELEMENTDEFAULTS_TABSTOP                           = DISPID_DEFAULTS+2; 
  DISPID_IHTMLELEMENTDEFAULTS_VIEWINHERITSTYLE                  = DISPID_A_VIEWINHERITSTYLE; 
  DISPID_IHTMLELEMENTDEFAULTS_VIEWMASTERTAB                     = DISPID_DEFAULTS+6; 
  DISPID_IHTMLELEMENTDEFAULTS_SCROLLSEGMENTX                    = DISPID_DEFAULTS+3; 
  DISPID_IHTMLELEMENTDEFAULTS_SCROLLSEGMENTY                    = DISPID_DEFAULTS+4; 
  DISPID_IHTMLELEMENTDEFAULTS_ISMULTILINE                       = DISPID_DEFAULTS+8; 
  DISPID_IHTMLELEMENTDEFAULTS_CONTENTEDITABLE                   = DISPID_A_EDITABLE; 
  DISPID_IHTMLELEMENTDEFAULTS_CANHAVEHTML                       = DISPID_DEFAULTS+9; 
  DISPID_IHTMLELEMENTDEFAULTS_VIEWLINK                          = DISPID_DEFAULTS+11; 
  DISPID_IHTMLELEMENTDEFAULTS_FROZEN                            = DISPID_A_FROZEN; 

{    DISPIDs for interface IHTCDefaultDispatch }

  DISPID_IHTCDEFAULTDISPATCH_ELEMENT                            = DISPID_A_HTCDD_ELEMENT; 
  DISPID_IHTCDEFAULTDISPATCH_CREATEEVENTOBJECT                  = DISPID_A_HTCDD_CREATEEVENTOBJECT; 
  DISPID_IHTCDEFAULTDISPATCH_DEFAULTS                           = DISPID_A_HTCDD_DEFAULTS; 
  DISPID_IHTCDEFAULTDISPATCH_DOCUMENT                           = DISPID_A_DOCFRAGMENT; 

{    DISPIDs for interface IHTCPropertyBehavior }

  DISPID_IHTCPROPERTYBEHAVIOR_FIRECHANGE                        = DISPID_HTMLOBJECT+0; 
  DISPID_IHTCPROPERTYBEHAVIOR_VALUE                             = DISPID_A_HTCDISPATCHITEM_VALUE; 

{    DISPIDs for interface IHTCEventBehavior }

  DISPID_IHTCEVENTBEHAVIOR_FIRE                                 = DISPID_HTMLOBJECT+0; 

{    DISPIDs for interface IHTCAttachBehavior }

  DISPID_IHTCATTACHBEHAVIOR_FIREEVENT                           = DISPID_VALUE; 
  DISPID_IHTCATTACHBEHAVIOR_DETACHEVENT                         = DISPID_HTMLOBJECT+0; 

{    DISPIDs for interface IHTCAttachBehavior2 }

  DISPID_IHTCATTACHBEHAVIOR2_FIREEVENT                          = DISPID_VALUE; 

{    DISPIDs for interface IHTCDescBehavior }

  DISPID_IHTCDESCBEHAVIOR_URN                                   = DISPID_HTMLOBJECT+0; 
  DISPID_IHTCDESCBEHAVIOR_NAME                                  = DISPID_HTMLOBJECT+1; 

{    DISPIDs for interface IHTMLUrnCollection }

  DISPID_IHTMLURNCOLLECTION_LENGTH                              = DISPID_URN_COLL+1; 
  DISPID_IHTMLURNCOLLECTION_ITEM                                = DISPID_VALUE; 

{    DISPIDs for interface IHTMLGenericElement }

  DISPID_IHTMLGENERICELEMENT_RECORDSET                          = DISPID_GENERIC+1; 
  DISPID_IHTMLGENERICELEMENT_NAMEDRECORDSET                     = DISPID_GENERIC+2; 

{    DISPIDs for interface IHTMLStyleSheetRule }

  DISPID_IHTMLSTYLESHEETRULE_SELECTORTEXT                       = DISPID_STYLERULE+1; 
  DISPID_IHTMLSTYLESHEETRULE_STYLE                              = STDPROPID_XOBJ_STYLE; 
  DISPID_IHTMLSTYLESHEETRULE_READONLY                           = DISPID_STYLERULE+2; 

{    DISPIDs for interface IHTMLStyleSheetRulesCollection }

  DISPID_IHTMLSTYLESHEETRULESCOLLECTION_LENGTH                  = DISPID_STYLERULES_COL+1; 
  DISPID_IHTMLSTYLESHEETRULESCOLLECTION_ITEM                    = DISPID_VALUE; 

{    DISPIDs for interface IHTMLStyleSheetPage }

  DISPID_IHTMLSTYLESHEETPAGE_SELECTOR                           = DISPID_STYLEPAGE+1; 
  DISPID_IHTMLSTYLESHEETPAGE_PSEUDOCLASS                        = DISPID_STYLEPAGE+2; 

{    DISPIDs for interface IHTMLStyleSheetPagesCollection }

  DISPID_IHTMLSTYLESHEETPAGESCOLLECTION_LENGTH                  = DISPID_STYLEPAGES_COL+1; 
  DISPID_IHTMLSTYLESHEETPAGESCOLLECTION_ITEM                    = DISPID_VALUE; 

{    DISPIDs for interface IHTMLStyleSheet }

  DISPID_IHTMLSTYLESHEET_TITLE                                  = DISPID_STYLESHEET+1; 
  DISPID_IHTMLSTYLESHEET_PARENTSTYLESHEET                       = DISPID_STYLESHEET+2; 
  DISPID_IHTMLSTYLESHEET_OWNINGELEMENT                          = DISPID_STYLESHEET+3; 
  DISPID_IHTMLSTYLESHEET_DISABLED                               = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLSTYLESHEET_READONLY                               = DISPID_STYLESHEET+4; 
  DISPID_IHTMLSTYLESHEET_IMPORTS                                = DISPID_STYLESHEET+5; 
  DISPID_IHTMLSTYLESHEET_HREF                                   = DISPID_STYLESHEET+6; 
  DISPID_IHTMLSTYLESHEET_TYPE                                   = DISPID_STYLESHEET+7; 
  DISPID_IHTMLSTYLESHEET_ID                                     = DISPID_STYLESHEET+8; 
  DISPID_IHTMLSTYLESHEET_ADDIMPORT                              = DISPID_STYLESHEET+9; 
  DISPID_IHTMLSTYLESHEET_ADDRULE                                = DISPID_STYLESHEET+10; 
  DISPID_IHTMLSTYLESHEET_REMOVEIMPORT                           = DISPID_STYLESHEET+11; 
  DISPID_IHTMLSTYLESHEET_REMOVERULE                             = DISPID_STYLESHEET+12; 
  DISPID_IHTMLSTYLESHEET_MEDIA                                  = DISPID_STYLESHEET+13; 
  DISPID_IHTMLSTYLESHEET_CSSTEXT                                = DISPID_STYLESHEET+14; 
  DISPID_IHTMLSTYLESHEET_RULES                                  = DISPID_STYLESHEET+15; 

{    DISPIDs for interface IHTMLStyleSheet2 }

  DISPID_IHTMLSTYLESHEET2_PAGES                                 = DISPID_STYLESHEET+16; 
  DISPID_IHTMLSTYLESHEET2_ADDPAGERULE                           = DISPID_STYLESHEET+17; 

{    DISPIDs for interface IHTMLStyleSheetsCollection }

  DISPID_IHTMLSTYLESHEETSCOLLECTION_LENGTH                      = DISPID_STYLESHEETS_COL+1; 
  DISPID_IHTMLSTYLESHEETSCOLLECTION__NEWENUM                    = DISPID_NEWENUM; 
  DISPID_IHTMLSTYLESHEETSCOLLECTION_ITEM                        = DISPID_VALUE; 

{    DISPIDs for interface IHTMLLinkElement }

  DISPID_IHTMLLINKELEMENT_HREF                                  = DISPID_HEDELEMS+5; 
  DISPID_IHTMLLINKELEMENT_REL                                   = DISPID_HEDELEMS+6; 
  DISPID_IHTMLLINKELEMENT_REV                                   = DISPID_HEDELEMS+7; 
  DISPID_IHTMLLINKELEMENT_TYPE                                  = DISPID_HEDELEMS+8; 
  DISPID_IHTMLLINKELEMENT_READYSTATE                            = DISPID_A_READYSTATE; 
  DISPID_IHTMLLINKELEMENT_ONREADYSTATECHANGE                    = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLLINKELEMENT_ONLOAD                                = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLLINKELEMENT_ONERROR                               = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLLINKELEMENT_STYLESHEET                            = DISPID_HEDELEMS+14; 
  DISPID_IHTMLLINKELEMENT_DISABLED                              = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLLINKELEMENT_MEDIA                                 = DISPID_HEDELEMS+16; 

{    DISPIDs for interface IHTMLLinkElement2 }

  DISPID_IHTMLLINKELEMENT2_TARGET                               = DISPID_HEDELEMS+17; 

{    DISPIDs for interface IHTMLLinkElement3 }

  DISPID_IHTMLLINKELEMENT3_CHARSET                              = DISPID_HEDELEMS+18; 
  DISPID_IHTMLLINKELEMENT3_HREFLANG                             = DISPID_HEDELEMS+19; 

{    DISPIDs for event set HTMLLinkElementEvents2 }

  DISPID_HTMLLINKELEMENTEVENTS2_ONLOAD                          = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLLINKELEMENTEVENTS2_ONERROR                         = DISPID_EVMETH_ONERROR; 

{    DISPIDs for event set HTMLLinkElementEvents }

//  DISPID_HTMLLINKELEMENTEVENTS_ONREADYSTATECHANGE               = DISPID_EVMETH_ONREADYSTATECHANGE;
  DISPID_HTMLLINKELEMENTEVENTS_ONLOAD                           = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLLINKELEMENTEVENTS_ONERROR                          = DISPID_EVMETH_ONERROR; 

{    DISPIDs for interface IHTMLTxtRange }

  DISPID_IHTMLTXTRANGE_HTMLTEXT                                 = DISPID_RANGE+3; 
  DISPID_IHTMLTXTRANGE_TEXT                                     = DISPID_RANGE+4; 
  DISPID_IHTMLTXTRANGE_PARENTELEMENT                            = DISPID_RANGE+6; 
  DISPID_IHTMLTXTRANGE_DUPLICATE                                = DISPID_RANGE+8; 
  DISPID_IHTMLTXTRANGE_INRANGE                                  = DISPID_RANGE+10; 
  DISPID_IHTMLTXTRANGE_ISEQUAL                                  = DISPID_RANGE+11; 
  DISPID_IHTMLTXTRANGE_SCROLLINTOVIEW                           = DISPID_RANGE+12; 
  DISPID_IHTMLTXTRANGE_COLLAPSE                                 = DISPID_RANGE+13; 
  DISPID_IHTMLTXTRANGE_EXPAND                                   = DISPID_RANGE+14; 
  DISPID_IHTMLTXTRANGE_MOVE                                     = DISPID_RANGE+15; 
  DISPID_IHTMLTXTRANGE_MOVESTART                                = DISPID_RANGE+16; 
  DISPID_IHTMLTXTRANGE_MOVEEND                                  = DISPID_RANGE+17; 
  DISPID_IHTMLTXTRANGE_SELECT                                   = DISPID_RANGE+24; 
  DISPID_IHTMLTXTRANGE_PASTEHTML                                = DISPID_RANGE+26; 
  DISPID_IHTMLTXTRANGE_MOVETOELEMENTTEXT                        = DISPID_RANGE+1; 
  DISPID_IHTMLTXTRANGE_SETENDPOINT                              = DISPID_RANGE+25; 
  DISPID_IHTMLTXTRANGE_COMPAREENDPOINTS                         = DISPID_RANGE+18; 
  DISPID_IHTMLTXTRANGE_FINDTEXT                                 = DISPID_RANGE+19; 
  DISPID_IHTMLTXTRANGE_MOVETOPOINT                              = DISPID_RANGE+20; 
  DISPID_IHTMLTXTRANGE_GETBOOKMARK                              = DISPID_RANGE+21; 
  DISPID_IHTMLTXTRANGE_MOVETOBOOKMARK                           = DISPID_RANGE+9; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDSUPPORTED                    = DISPID_RANGE+27; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDENABLED                      = DISPID_RANGE+28; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDSTATE                        = DISPID_RANGE+29; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDINDETERM                     = DISPID_RANGE+30; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDTEXT                         = DISPID_RANGE+31; 
  DISPID_IHTMLTXTRANGE_QUERYCOMMANDVALUE                        = DISPID_RANGE+32; 
  DISPID_IHTMLTXTRANGE_EXECCOMMAND                              = DISPID_RANGE+33; 
  DISPID_IHTMLTXTRANGE_EXECCOMMANDSHOWHELP                      = DISPID_RANGE+34; 

{    DISPIDs for interface IHTMLTextRangeMetrics }

  DISPID_IHTMLTEXTRANGEMETRICS_OFFSETTOP                        = DISPID_RANGE+35; 
  DISPID_IHTMLTEXTRANGEMETRICS_OFFSETLEFT                       = DISPID_RANGE+36; 
  DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGTOP                      = DISPID_RANGE+37; 
  DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGLEFT                     = DISPID_RANGE+38; 
  DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGWIDTH                    = DISPID_RANGE+39; 
  DISPID_IHTMLTEXTRANGEMETRICS_BOUNDINGHEIGHT                   = DISPID_RANGE+40; 

{    DISPIDs for interface IHTMLTextRangeMetrics2 }

  DISPID_IHTMLTEXTRANGEMETRICS2_GETCLIENTRECTS                  = DISPID_RANGE+41; 
  DISPID_IHTMLTEXTRANGEMETRICS2_GETBOUNDINGCLIENTRECT           = DISPID_RANGE+42; 

{    DISPIDs for interface IHTMLTxtRangeCollection }

  DISPID_IHTMLTXTRANGECOLLECTION_LENGTH                         = DISPID_COLLECTION; 
  DISPID_IHTMLTXTRANGECOLLECTION__NEWENUM                       = DISPID_NEWENUM; 
  DISPID_IHTMLTXTRANGECOLLECTION_ITEM                           = DISPID_VALUE; 

{    DISPIDs for interface IHTMLFormElement }

  DISPID_IHTMLFORMELEMENT_ACTION                                = DISPID_FORM+1; 
  DISPID_IHTMLFORMELEMENT_DIR                                   = DISPID_A_DIR; 
  DISPID_IHTMLFORMELEMENT_ENCODING                              = DISPID_FORM+3; 
  DISPID_IHTMLFORMELEMENT_METHOD                                = DISPID_FORM+4; 
  DISPID_IHTMLFORMELEMENT_ELEMENTS                              = DISPID_FORM+5; 
  DISPID_IHTMLFORMELEMENT_TARGET                                = DISPID_FORM+6; 
  DISPID_IHTMLFORMELEMENT_NAME                                  = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLFORMELEMENT_ONSUBMIT                              = DISPID_EVPROP_ONSUBMIT; 
  DISPID_IHTMLFORMELEMENT_ONRESET                               = DISPID_EVPROP_ONRESET; 
  DISPID_IHTMLFORMELEMENT_SUBMIT                                = DISPID_FORM+9; 
  DISPID_IHTMLFORMELEMENT_RESET                                 = DISPID_FORM+10; 
  DISPID_IHTMLFORMELEMENT_LENGTH                                = DISPID_COLLECTION; 
  DISPID_IHTMLFORMELEMENT__NEWENUM                              = DISPID_NEWENUM; 
  DISPID_IHTMLFORMELEMENT_ITEM                                  = DISPID_VALUE; 
  DISPID_IHTMLFORMELEMENT_TAGS                                  = DISPID_COLLECTION+2; 

{    DISPIDs for interface IHTMLFormElement2 }

  DISPID_IHTMLFORMELEMENT2_ACCEPTCHARSET                        = DISPID_FORM+11; 
  DISPID_IHTMLFORMELEMENT2_URNS                                 = DISPID_COLLECTION+5; 

{    DISPIDs for interface IHTMLFormElement3 }

  DISPID_IHTMLFORMELEMENT3_NAMEDITEM                            = DISPID_COLLECTION+6; 

{    DISPIDs for interface IHTMLSubmitData }

  DISPID_IHTMLSUBMITDATA_APPENDNAMEVALUEPAIR                    = DISPID_FORM+12; 
  DISPID_IHTMLSUBMITDATA_APPENDNAMEFILEPAIR                     = DISPID_FORM+13; 
  DISPID_IHTMLSUBMITDATA_APPENDITEMSEPARATOR                    = DISPID_FORM+14; 

{    DISPIDs for event set HTMLFormElementEvents2 }

  DISPID_HTMLFORMELEMENTEVENTS2_ONSUBMIT                        = DISPID_EVMETH_ONSUBMIT; 
  DISPID_HTMLFORMELEMENTEVENTS2_ONRESET                         = DISPID_EVMETH_ONRESET; 

{    DISPIDs for event set HTMLFormElementEvents }

  DISPID_HTMLFORMELEMENTEVENTS_ONSUBMIT                         = DISPID_EVMETH_ONSUBMIT; 
  DISPID_HTMLFORMELEMENTEVENTS_ONRESET                          = DISPID_EVMETH_ONRESET; 

{    DISPIDs for interface IHTMLControlElement }

  DISPID_IHTMLCONTROLELEMENT_TABINDEX                           = STDPROPID_XOBJ_TABINDEX; 
  DISPID_IHTMLCONTROLELEMENT_FOCUS                              = DISPID_SITE+0; 
  DISPID_IHTMLCONTROLELEMENT_ACCESSKEY                          = DISPID_SITE+5; 
  DISPID_IHTMLCONTROLELEMENT_ONBLUR                             = DISPID_EVPROP_ONBLUR; 
  DISPID_IHTMLCONTROLELEMENT_ONFOCUS                            = DISPID_EVPROP_ONFOCUS; 
  DISPID_IHTMLCONTROLELEMENT_ONRESIZE                           = DISPID_EVPROP_ONRESIZE; 
  DISPID_IHTMLCONTROLELEMENT_BLUR                               = DISPID_SITE+2; 
  DISPID_IHTMLCONTROLELEMENT_ADDFILTER                          = DISPID_SITE+17; 
  DISPID_IHTMLCONTROLELEMENT_REMOVEFILTER                       = DISPID_SITE+18; 
  DISPID_IHTMLCONTROLELEMENT_CLIENTHEIGHT                       = DISPID_SITE+19; 
  DISPID_IHTMLCONTROLELEMENT_CLIENTWIDTH                        = DISPID_SITE+20; 
  DISPID_IHTMLCONTROLELEMENT_CLIENTTOP                          = DISPID_SITE+21; 
  DISPID_IHTMLCONTROLELEMENT_CLIENTLEFT                         = DISPID_SITE+22; 

{    DISPIDs for interface IHTMLTextContainer }

  DISPID_IHTMLTEXTCONTAINER_CREATECONTROLRANGE                  = DISPID_TEXTSITE+1; 
  DISPID_IHTMLTEXTCONTAINER_SCROLLHEIGHT                        = DISPID_TEXTSITE+2; 
  DISPID_IHTMLTEXTCONTAINER_SCROLLWIDTH                         = DISPID_TEXTSITE+3; 
  DISPID_IHTMLTEXTCONTAINER_SCROLLTOP                           = DISPID_TEXTSITE+4; 
  DISPID_IHTMLTEXTCONTAINER_SCROLLLEFT                          = DISPID_TEXTSITE+5; 
  DISPID_IHTMLTEXTCONTAINER_ONSCROLL                            = DISPID_EVPROP_ONSCROLL; 

{    DISPIDs for event set HTMLTextContainerEvents2 }

  DISPID_HTMLTEXTCONTAINEREVENTS2_ONCHANGE                      = DISPID_EVMETH_ONCHANGE; 
  DISPID_HTMLTEXTCONTAINEREVENTS2_ONSELECT                      = DISPID_EVMETH_ONSELECT; 

{    DISPIDs for event set HTMLTextContainerEvents }

  DISPID_HTMLTEXTCONTAINEREVENTS_ONCHANGE                       = DISPID_EVMETH_ONCHANGE; 
//  DISPID_HTMLTEXTCONTAINEREVENTS_ONSCROLL                       = DISPID_EVMETH_ONSCROLL; 
  DISPID_HTMLTEXTCONTAINEREVENTS_ONSELECT                       = DISPID_EVMETH_ONSELECT; 

{    DISPIDs for interface IHTMLControlRange }

  DISPID_IHTMLCONTROLRANGE_SELECT                               = DISPID_RANGE+2; 
  DISPID_IHTMLCONTROLRANGE_ADD                                  = DISPID_RANGE+3; 
  DISPID_IHTMLCONTROLRANGE_REMOVE                               = DISPID_RANGE+4; 
  DISPID_IHTMLCONTROLRANGE_ITEM                                 = DISPID_VALUE; 
  DISPID_IHTMLCONTROLRANGE_SCROLLINTOVIEW                       = DISPID_RANGE+6; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDSUPPORTED                = DISPID_RANGE+7; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDENABLED                  = DISPID_RANGE+8; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDSTATE                    = DISPID_RANGE+9; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDINDETERM                 = DISPID_RANGE+10; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDTEXT                     = DISPID_RANGE+11; 
  DISPID_IHTMLCONTROLRANGE_QUERYCOMMANDVALUE                    = DISPID_RANGE+12; 
  DISPID_IHTMLCONTROLRANGE_EXECCOMMAND                          = DISPID_RANGE+13; 
  DISPID_IHTMLCONTROLRANGE_EXECCOMMANDSHOWHELP                  = DISPID_RANGE+14; 
  DISPID_IHTMLCONTROLRANGE_COMMONPARENTELEMENT                  = DISPID_RANGE+15; 
  DISPID_IHTMLCONTROLRANGE_LENGTH                               = DISPID_RANGE+5; 

{    DISPIDs for interface IHTMLControlRange2 }

  DISPID_IHTMLCONTROLRANGE2_ADDELEMENT                          = DISPID_RANGE+16; 

{    DISPIDs for interface IHTMLImgElement }

  DISPID_IHTMLIMGELEMENT_ISMAP                                  = DISPID_IMG+2; 
  DISPID_IHTMLIMGELEMENT_USEMAP                                 = DISPID_IMG+8; 
  DISPID_IHTMLIMGELEMENT_MIMETYPE                               = DISPID_IMG+10; 
  DISPID_IHTMLIMGELEMENT_FILESIZE                               = DISPID_IMG+11; 
  DISPID_IHTMLIMGELEMENT_FILECREATEDDATE                        = DISPID_IMG+12; 
  DISPID_IHTMLIMGELEMENT_FILEMODIFIEDDATE                       = DISPID_IMG+13; 
  DISPID_IHTMLIMGELEMENT_FILEUPDATEDDATE                        = DISPID_IMG+14; 
  DISPID_IHTMLIMGELEMENT_PROTOCOL                               = DISPID_IMG+15; 
  DISPID_IHTMLIMGELEMENT_HREF                                   = DISPID_IMG+16; 
  DISPID_IHTMLIMGELEMENT_NAMEPROP                               = DISPID_IMG+17; 
  DISPID_IHTMLIMGELEMENT_BORDER                                 = DISPID_IMGBASE+4; 
  DISPID_IHTMLIMGELEMENT_VSPACE                                 = DISPID_IMGBASE+5; 
  DISPID_IHTMLIMGELEMENT_HSPACE                                 = DISPID_IMGBASE+6; 
  DISPID_IHTMLIMGELEMENT_ALT                                    = DISPID_IMGBASE+2; 
  DISPID_IHTMLIMGELEMENT_SRC                                    = DISPID_IMGBASE+3; 
  DISPID_IHTMLIMGELEMENT_LOWSRC                                 = DISPID_IMGBASE+7; 
  DISPID_IHTMLIMGELEMENT_VRML                                   = DISPID_IMGBASE+8; 
  DISPID_IHTMLIMGELEMENT_DYNSRC                                 = DISPID_IMGBASE+9; 
  DISPID_IHTMLIMGELEMENT_READYSTATE                             = DISPID_A_READYSTATE; 
  DISPID_IHTMLIMGELEMENT_COMPLETE                               = DISPID_IMGBASE+10; 
  DISPID_IHTMLIMGELEMENT_LOOP                                   = DISPID_IMGBASE+11; 
  DISPID_IHTMLIMGELEMENT_ALIGN                                  = STDPROPID_XOBJ_CONTROLALIGN; 
  DISPID_IHTMLIMGELEMENT_ONLOAD                                 = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLIMGELEMENT_ONERROR                                = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLIMGELEMENT_ONABORT                                = DISPID_EVPROP_ONABORT; 
  DISPID_IHTMLIMGELEMENT_NAME                                   = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLIMGELEMENT_WIDTH                                  = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLIMGELEMENT_HEIGHT                                 = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLIMGELEMENT_START                                  = DISPID_IMGBASE+13; 

{    DISPIDs for interface IHTMLImgElement2 }

  DISPID_IHTMLIMGELEMENT2_LONGDESC                              = DISPID_IMG+19; 

{    DISPIDs for interface IHTMLImageElementFactory }

  DISPID_IHTMLIMAGEELEMENTFACTORY_CREATE                        = DISPID_VALUE; 

{    DISPIDs for event set HTMLImgEvents2 }

  DISPID_HTMLIMGEVENTS2_ONLOAD                                  = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLIMGEVENTS2_ONERROR                                 = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLIMGEVENTS2_ONABORT                                 = DISPID_EVMETH_ONABORT; 

{    DISPIDs for event set HTMLImgEvents }

  DISPID_HTMLIMGEVENTS_ONLOAD                                   = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLIMGEVENTS_ONERROR                                  = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLIMGEVENTS_ONABORT                                  = DISPID_EVMETH_ONABORT; 

{    DISPIDs for interface IHTMLBodyElement }

  DISPID_IHTMLBODYELEMENT_BACKGROUND                            = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLBODYELEMENT_BGPROPERTIES                          = DISPID_A_BACKGROUNDATTACHMENT; 
  DISPID_IHTMLBODYELEMENT_LEFTMARGIN                            = DISPID_A_MARGINLEFT; 
  DISPID_IHTMLBODYELEMENT_TOPMARGIN                             = DISPID_A_MARGINTOP; 
  DISPID_IHTMLBODYELEMENT_RIGHTMARGIN                           = DISPID_A_MARGINRIGHT; 
  DISPID_IHTMLBODYELEMENT_BOTTOMMARGIN                          = DISPID_A_MARGINBOTTOM; 
  DISPID_IHTMLBODYELEMENT_NOWRAP                                = DISPID_A_NOWRAP; 
  DISPID_IHTMLBODYELEMENT_BGCOLOR                               = DISPID_BACKCOLOR; 
  DISPID_IHTMLBODYELEMENT_TEXT                                  = DISPID_A_COLOR; 
  DISPID_IHTMLBODYELEMENT_LINK                                  = DISPID_BODY+10; 
  DISPID_IHTMLBODYELEMENT_VLINK                                 = DISPID_BODY+12; 
  DISPID_IHTMLBODYELEMENT_ALINK                                 = DISPID_BODY+11; 
  DISPID_IHTMLBODYELEMENT_ONLOAD                                = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLBODYELEMENT_ONUNLOAD                              = DISPID_EVPROP_ONUNLOAD; 
  DISPID_IHTMLBODYELEMENT_SCROLL                                = DISPID_A_SCROLL; 
  DISPID_IHTMLBODYELEMENT_ONSELECT                              = DISPID_EVPROP_ONSELECT; 
  DISPID_IHTMLBODYELEMENT_ONBEFOREUNLOAD                        = DISPID_EVPROP_ONBEFOREUNLOAD; 
  DISPID_IHTMLBODYELEMENT_CREATETEXTRANGE                       = DISPID_BODY+13; 

{    DISPIDs for interface IHTMLBodyElement2 }

  DISPID_IHTMLBODYELEMENT2_ONBEFOREPRINT                        = DISPID_EVPROP_ONBEFOREPRINT; 
  DISPID_IHTMLBODYELEMENT2_ONAFTERPRINT                         = DISPID_EVPROP_ONAFTERPRINT; 

{    DISPIDs for interface IHTMLFontElement }

  DISPID_IHTMLFONTELEMENT_COLOR                                 = DISPID_A_COLOR; 
  DISPID_IHTMLFONTELEMENT_FACE                                  = DISPID_A_FONTFACE; 
  DISPID_IHTMLFONTELEMENT_SIZE                                  = DISPID_A_FONTSIZE; 

{    DISPIDs for interface IHTMLAnchorElement }

  DISPID_IHTMLANCHORELEMENT_HREF                                = DISPID_VALUE; 
  DISPID_IHTMLANCHORELEMENT_TARGET                              = DISPID_ANCHOR+3; 
  DISPID_IHTMLANCHORELEMENT_REL                                 = DISPID_ANCHOR+5; 
  DISPID_IHTMLANCHORELEMENT_REV                                 = DISPID_ANCHOR+6; 
  DISPID_IHTMLANCHORELEMENT_URN                                 = DISPID_ANCHOR+7; 
  DISPID_IHTMLANCHORELEMENT_METHODS                             = DISPID_ANCHOR+8; 
  DISPID_IHTMLANCHORELEMENT_NAME                                = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLANCHORELEMENT_HOST                                = DISPID_ANCHOR+12; 
  DISPID_IHTMLANCHORELEMENT_HOSTNAME                            = DISPID_ANCHOR+13; 
  DISPID_IHTMLANCHORELEMENT_PATHNAME                            = DISPID_ANCHOR+14; 
  DISPID_IHTMLANCHORELEMENT_PORT                                = DISPID_ANCHOR+15; 
  DISPID_IHTMLANCHORELEMENT_PROTOCOL                            = DISPID_ANCHOR+16; 
  DISPID_IHTMLANCHORELEMENT_SEARCH                              = DISPID_ANCHOR+17; 
  DISPID_IHTMLANCHORELEMENT_HASH                                = DISPID_ANCHOR+18; 
  DISPID_IHTMLANCHORELEMENT_ONBLUR                              = DISPID_EVPROP_ONBLUR; 
  DISPID_IHTMLANCHORELEMENT_ONFOCUS                             = DISPID_EVPROP_ONFOCUS; 
  DISPID_IHTMLANCHORELEMENT_ACCESSKEY                           = DISPID_SITE+5; 
  DISPID_IHTMLANCHORELEMENT_PROTOCOLLONG                        = DISPID_ANCHOR+31; 
  DISPID_IHTMLANCHORELEMENT_MIMETYPE                            = DISPID_ANCHOR+30; 
  DISPID_IHTMLANCHORELEMENT_NAMEPROP                            = DISPID_ANCHOR+32; 
  DISPID_IHTMLANCHORELEMENT_TABINDEX                            = STDPROPID_XOBJ_TABINDEX; 
  DISPID_IHTMLANCHORELEMENT_FOCUS                               = DISPID_SITE+0; 
  DISPID_IHTMLANCHORELEMENT_BLUR                                = DISPID_SITE+2; 

{    DISPIDs for interface IHTMLAnchorElement2 }

  DISPID_IHTMLANCHORELEMENT2_CHARSET                            = DISPID_ANCHOR+23; 
  DISPID_IHTMLANCHORELEMENT2_COORDS                             = DISPID_ANCHOR+24; 
  DISPID_IHTMLANCHORELEMENT2_HREFLANG                           = DISPID_ANCHOR+25; 
  DISPID_IHTMLANCHORELEMENT2_SHAPE                              = DISPID_ANCHOR+26; 
  DISPID_IHTMLANCHORELEMENT2_TYPE                               = DISPID_ANCHOR+27; 

{    DISPIDs for interface IHTMLLabelElement }

  DISPID_IHTMLLABELELEMENT_HTMLFOR                              = DISPID_LABEL; 
  DISPID_IHTMLLABELELEMENT_ACCESSKEY                            = DISPID_SITE+5; 

{    DISPIDs for interface IHTMLLabelElement2 }

  DISPID_IHTMLLABELELEMENT2_FORM                                = DISPID_LABEL+2; 

{    DISPIDs for interface IHTMLListElement2 }

  DISPID_IHTMLLISTELEMENT2_COMPACT                              = DISPID_DIR+1; 

{    DISPIDs for interface IHTMLUListElement }

  DISPID_IHTMLULISTELEMENT_COMPACT                              = DISPID_DIR+1; 
  DISPID_IHTMLULISTELEMENT_TYPE                                 = DISPID_A_LISTTYPE; 

{    DISPIDs for interface IHTMLOListElement }

  DISPID_IHTMLOLISTELEMENT_COMPACT                              = DISPID_DIR+1; 
  DISPID_IHTMLOLISTELEMENT_START                                = DISPID_OL+3; 
  DISPID_IHTMLOLISTELEMENT_TYPE                                 = DISPID_A_LISTTYPE; 

{    DISPIDs for interface IHTMLLIElement }

  DISPID_IHTMLLIELEMENT_TYPE                                    = DISPID_A_LISTTYPE; 
  DISPID_IHTMLLIELEMENT_VALUE                                   = DISPID_LI+1; 

{    DISPIDs for interface IHTMLBlockElement }

  DISPID_IHTMLBLOCKELEMENT_CLEAR                                = DISPID_A_CLEAR; 

{    DISPIDs for interface IHTMLBlockElement2 }

  DISPID_IHTMLBLOCKELEMENT2_CITE                                = DISPID_BLOCK+1; 
  DISPID_IHTMLBLOCKELEMENT2_WIDTH                               = DISPID_BLOCK+2; 

{    DISPIDs for interface IHTMLDivElement }

  DISPID_IHTMLDIVELEMENT_ALIGN                                  = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLDIVELEMENT_NOWRAP                                 = DISPID_A_NOWRAP; 

{    DISPIDs for interface IHTMLDDElement }

  DISPID_IHTMLDDELEMENT_NOWRAP                                  = DISPID_A_NOWRAP; 

{    DISPIDs for interface IHTMLDTElement }

  DISPID_IHTMLDTELEMENT_NOWRAP                                  = DISPID_A_NOWRAP; 

{    DISPIDs for interface IHTMLBRElement }

  DISPID_IHTMLBRELEMENT_CLEAR                                   = DISPID_A_CLEAR; 

{    DISPIDs for interface IHTMLDListElement }

  DISPID_IHTMLDLISTELEMENT_COMPACT                              = DISPID_DIR+1; 

{    DISPIDs for interface IHTMLHRElement }

  DISPID_IHTMLHRELEMENT_ALIGN                                   = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLHRELEMENT_COLOR                                   = DISPID_A_COLOR; 
  DISPID_IHTMLHRELEMENT_NOSHADE                                 = DISPID_HR+1; 
  DISPID_IHTMLHRELEMENT_WIDTH                                   = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLHRELEMENT_SIZE                                    = STDPROPID_XOBJ_HEIGHT; 

{    DISPIDs for interface IHTMLParaElement }

  DISPID_IHTMLPARAELEMENT_ALIGN                                 = STDPROPID_XOBJ_BLOCKALIGN; 

{    DISPIDs for interface IHTMLElementCollection }

  DISPID_IHTMLELEMENTCOLLECTION_TOSTRING                        = DISPID_COLLECTION+1; 
  DISPID_IHTMLELEMENTCOLLECTION_LENGTH                          = DISPID_COLLECTION; 
  DISPID_IHTMLELEMENTCOLLECTION__NEWENUM                        = DISPID_NEWENUM; 
  DISPID_IHTMLELEMENTCOLLECTION_ITEM                            = DISPID_VALUE; 
  DISPID_IHTMLELEMENTCOLLECTION_TAGS                            = DISPID_COLLECTION+2; 

{    DISPIDs for interface IHTMLElementCollection2 }

  DISPID_IHTMLELEMENTCOLLECTION2_URNS                           = DISPID_COLLECTION+5; 

{    DISPIDs for interface IHTMLElementCollection3 }

  DISPID_IHTMLELEMENTCOLLECTION3_NAMEDITEM                      = DISPID_COLLECTION+6; 

{    DISPIDs for interface IHTMLHeaderElement }

  DISPID_IHTMLHEADERELEMENT_ALIGN                               = STDPROPID_XOBJ_BLOCKALIGN; 

{    DISPIDs for interface IHTMLSelectElement }

  DISPID_IHTMLSELECTELEMENT_SIZE                                = DISPID_SELECT+2; 
  DISPID_IHTMLSELECTELEMENT_MULTIPLE                            = DISPID_SELECT+3; 
  DISPID_IHTMLSELECTELEMENT_NAME                                = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLSELECTELEMENT_OPTIONS                             = DISPID_SELECT+5; 
  DISPID_IHTMLSELECTELEMENT_ONCHANGE                            = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLSELECTELEMENT_SELECTEDINDEX                       = DISPID_SELECT+10; 
  DISPID_IHTMLSELECTELEMENT_TYPE                                = DISPID_SELECT+12; 
  DISPID_IHTMLSELECTELEMENT_VALUE                               = DISPID_SELECT+11; 
  DISPID_IHTMLSELECTELEMENT_DISABLED                            = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLSELECTELEMENT_FORM                                = DISPID_SITE+4; 
  DISPID_IHTMLSELECTELEMENT_ADD                                 = DISPID_COLLECTION+3; 
  DISPID_IHTMLSELECTELEMENT_REMOVE                              = DISPID_COLLECTION+4; 
  DISPID_IHTMLSELECTELEMENT_LENGTH                              = DISPID_COLLECTION; 
  DISPID_IHTMLSELECTELEMENT__NEWENUM                            = DISPID_NEWENUM; 
  DISPID_IHTMLSELECTELEMENT_ITEM                                = DISPID_VALUE; 
  DISPID_IHTMLSELECTELEMENT_TAGS                                = DISPID_COLLECTION+2; 

{    DISPIDs for interface IHTMLSelectElement2 }

  DISPID_IHTMLSELECTELEMENT2_URNS                               = DISPID_COLLECTION+5; 

{    DISPIDs for interface IHTMLSelectElement4 }

  DISPID_IHTMLSELECTELEMENT4_NAMEDITEM                          = DISPID_COLLECTION+6; 

{    DISPIDs for event set HTMLSelectElementEvents2 }

  DISPID_HTMLSELECTELEMENTEVENTS2_ONCHANGE                      = DISPID_EVMETH_ONCHANGE; 

{    DISPIDs for event set HTMLSelectElementEvents }

  DISPID_HTMLSELECTELEMENTEVENTS_ONCHANGE                       = DISPID_EVMETH_ONCHANGE; 

{    DISPIDs for interface IHTMLSelectionObject }

  DISPID_IHTMLSELECTIONOBJECT_CREATERANGE                       = DISPID_SELECTOBJ+1; 
  DISPID_IHTMLSELECTIONOBJECT_EMPTY                             = DISPID_SELECTOBJ+2; 
  DISPID_IHTMLSELECTIONOBJECT_CLEAR                             = DISPID_SELECTOBJ+3; 
  DISPID_IHTMLSELECTIONOBJECT_TYPE                              = DISPID_SELECTOBJ+4; 

{    DISPIDs for interface IHTMLSelectionObject2 }

  DISPID_IHTMLSELECTIONOBJECT2_CREATERANGECOLLECTION            = DISPID_SELECTOBJ+5; 
  DISPID_IHTMLSELECTIONOBJECT2_TYPEDETAIL                       = DISPID_SELECTOBJ+6; 

{    DISPIDs for interface IHTMLOptionElement }

  DISPID_IHTMLOPTIONELEMENT_SELECTED                            = DISPID_OPTION+1; 
  DISPID_IHTMLOPTIONELEMENT_VALUE                               = DISPID_OPTION+2; 
  DISPID_IHTMLOPTIONELEMENT_DEFAULTSELECTED                     = DISPID_OPTION+3; 
  DISPID_IHTMLOPTIONELEMENT_INDEX                               = DISPID_OPTION+5; 
  DISPID_IHTMLOPTIONELEMENT_TEXT                                = DISPID_OPTION+4; 
  DISPID_IHTMLOPTIONELEMENT_FORM                                = DISPID_OPTION+6; 

{    DISPIDs for interface IHTMLOptionElement3 }

  DISPID_IHTMLOPTIONELEMENT3_LABEL                              = DISPID_OPTION+7; 

{    DISPIDs for interface IHTMLOptionElementFactory }

  DISPID_IHTMLOPTIONELEMENTFACTORY_CREATE                       = DISPID_VALUE; 

{    DISPIDs for interface IHTMLInputElement }

  DISPID_IHTMLINPUTELEMENT_TYPE                                 = DISPID_INPUT; 
  DISPID_IHTMLINPUTELEMENT_VALUE                                = DISPID_A_VALUE; 
  DISPID_IHTMLINPUTELEMENT_NAME                                 = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTELEMENT_STATUS                               = DISPID_INPUT+1; 
  DISPID_IHTMLINPUTELEMENT_DISABLED                             = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTELEMENT_FORM                                 = DISPID_SITE+4; 
  DISPID_IHTMLINPUTELEMENT_SIZE                                 = DISPID_INPUT+2; 
  DISPID_IHTMLINPUTELEMENT_MAXLENGTH                            = DISPID_INPUT+3; 
  DISPID_IHTMLINPUTELEMENT_SELECT                               = DISPID_INPUT+4; 
  DISPID_IHTMLINPUTELEMENT_ONCHANGE                             = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLINPUTELEMENT_ONSELECT                             = DISPID_EVPROP_ONSELECT; 
  DISPID_IHTMLINPUTELEMENT_DEFAULTVALUE                         = DISPID_DEFAULTVALUE; 
  DISPID_IHTMLINPUTELEMENT_READONLY                             = DISPID_INPUT+5; 
  DISPID_IHTMLINPUTELEMENT_CREATETEXTRANGE                      = DISPID_INPUT+6; 
  DISPID_IHTMLINPUTELEMENT_INDETERMINATE                        = DISPID_INPUT+7; 
  DISPID_IHTMLINPUTELEMENT_DEFAULTCHECKED                       = DISPID_INPUT+8; 
  DISPID_IHTMLINPUTELEMENT_CHECKED                              = DISPID_INPUT+9; 
  DISPID_IHTMLINPUTELEMENT_BORDER                               = DISPID_INPUT+12; 
  DISPID_IHTMLINPUTELEMENT_VSPACE                               = DISPID_INPUT+13; 
  DISPID_IHTMLINPUTELEMENT_HSPACE                               = DISPID_INPUT+14; 
  DISPID_IHTMLINPUTELEMENT_ALT                                  = DISPID_INPUT+10; 
  DISPID_IHTMLINPUTELEMENT_SRC                                  = DISPID_INPUT+11; 
  DISPID_IHTMLINPUTELEMENT_LOWSRC                               = DISPID_INPUT+15; 
  DISPID_IHTMLINPUTELEMENT_VRML                                 = DISPID_INPUT+16; 
  DISPID_IHTMLINPUTELEMENT_DYNSRC                               = DISPID_INPUT+17; 
  DISPID_IHTMLINPUTELEMENT_READYSTATE                           = DISPID_A_READYSTATE; 
  DISPID_IHTMLINPUTELEMENT_COMPLETE                             = DISPID_INPUT+18; 
  DISPID_IHTMLINPUTELEMENT_LOOP                                 = DISPID_INPUT+19; 
  DISPID_IHTMLINPUTELEMENT_ALIGN                                = STDPROPID_XOBJ_CONTROLALIGN; 
  DISPID_IHTMLINPUTELEMENT_ONLOAD                               = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLINPUTELEMENT_ONERROR                              = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLINPUTELEMENT_ONABORT                              = DISPID_EVPROP_ONABORT; 
  DISPID_IHTMLINPUTELEMENT_WIDTH                                = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLINPUTELEMENT_HEIGHT                               = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLINPUTELEMENT_START                                = DISPID_INPUT+20; 

{    DISPIDs for interface IHTMLInputElement2 }

  DISPID_IHTMLINPUTELEMENT2_ACCEPT                              = DISPID_INPUT+22; 
  DISPID_IHTMLINPUTELEMENT2_USEMAP                              = DISPID_INPUT+23; 

{    DISPIDs for interface IHTMLInputButtonElement }

  DISPID_IHTMLINPUTBUTTONELEMENT_TYPE                           = DISPID_INPUT; 
  DISPID_IHTMLINPUTBUTTONELEMENT_VALUE                          = DISPID_A_VALUE; 
  DISPID_IHTMLINPUTBUTTONELEMENT_NAME                           = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTBUTTONELEMENT_STATUS                         = DISPID_INPUT+21; 
  DISPID_IHTMLINPUTBUTTONELEMENT_DISABLED                       = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTBUTTONELEMENT_FORM                           = DISPID_SITE+4; 
  DISPID_IHTMLINPUTBUTTONELEMENT_CREATETEXTRANGE                = DISPID_INPUT+6; 

{    DISPIDs for interface IHTMLInputHiddenElement }

  DISPID_IHTMLINPUTHIDDENELEMENT_TYPE                           = DISPID_INPUT; 
  DISPID_IHTMLINPUTHIDDENELEMENT_VALUE                          = DISPID_A_VALUE; 
  DISPID_IHTMLINPUTHIDDENELEMENT_NAME                           = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTHIDDENELEMENT_STATUS                         = DISPID_INPUT+21; 
  DISPID_IHTMLINPUTHIDDENELEMENT_DISABLED                       = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTHIDDENELEMENT_FORM                           = DISPID_SITE+4; 
  DISPID_IHTMLINPUTHIDDENELEMENT_CREATETEXTRANGE                = DISPID_INPUT+6; 

{    DISPIDs for interface IHTMLInputTextElement }

  DISPID_IHTMLINPUTTEXTELEMENT_TYPE                             = DISPID_INPUT; 
  DISPID_IHTMLINPUTTEXTELEMENT_VALUE                            = DISPID_A_VALUE; 
  DISPID_IHTMLINPUTTEXTELEMENT_NAME                             = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTTEXTELEMENT_STATUS                           = DISPID_INPUT+21; 
  DISPID_IHTMLINPUTTEXTELEMENT_DISABLED                         = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTTEXTELEMENT_FORM                             = DISPID_SITE+4; 
  DISPID_IHTMLINPUTTEXTELEMENT_DEFAULTVALUE                     = DISPID_DEFAULTVALUE; 
  DISPID_IHTMLINPUTTEXTELEMENT_SIZE                             = DISPID_INPUT+2; 
  DISPID_IHTMLINPUTTEXTELEMENT_MAXLENGTH                        = DISPID_INPUT+3; 
  DISPID_IHTMLINPUTTEXTELEMENT_SELECT                           = DISPID_INPUT+4; 
  DISPID_IHTMLINPUTTEXTELEMENT_ONCHANGE                         = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLINPUTTEXTELEMENT_ONSELECT                         = DISPID_EVPROP_ONSELECT; 
  DISPID_IHTMLINPUTTEXTELEMENT_READONLY                         = DISPID_INPUT+5; 
  DISPID_IHTMLINPUTTEXTELEMENT_CREATETEXTRANGE                  = DISPID_INPUT+6; 

{    DISPIDs for interface IHTMLInputFileElement }

  DISPID_IHTMLINPUTFILEELEMENT_TYPE                             = DISPID_INPUT; 
  DISPID_IHTMLINPUTFILEELEMENT_NAME                             = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTFILEELEMENT_STATUS                           = DISPID_INPUT+21; 
  DISPID_IHTMLINPUTFILEELEMENT_DISABLED                         = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTFILEELEMENT_FORM                             = DISPID_SITE+4; 
  DISPID_IHTMLINPUTFILEELEMENT_SIZE                             = DISPID_INPUT+2; 
  DISPID_IHTMLINPUTFILEELEMENT_MAXLENGTH                        = DISPID_INPUT+3; 
  DISPID_IHTMLINPUTFILEELEMENT_SELECT                           = DISPID_INPUT+4; 
  DISPID_IHTMLINPUTFILEELEMENT_ONCHANGE                         = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLINPUTFILEELEMENT_ONSELECT                         = DISPID_EVPROP_ONSELECT; 
  DISPID_IHTMLINPUTFILEELEMENT_VALUE                            = DISPID_A_VALUE; 

{    DISPIDs for interface IHTMLOptionButtonElement }

  DISPID_IHTMLOPTIONBUTTONELEMENT_VALUE                         = DISPID_A_VALUE; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_TYPE                          = DISPID_INPUT; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_NAME                          = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_CHECKED                       = DISPID_INPUT+9; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_DEFAULTCHECKED                = DISPID_INPUT+8; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_ONCHANGE                      = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_DISABLED                      = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_STATUS                        = DISPID_INPUT+1; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_INDETERMINATE                 = DISPID_INPUT+7; 
  DISPID_IHTMLOPTIONBUTTONELEMENT_FORM                          = DISPID_SITE+4; 

{    DISPIDs for interface IHTMLInputImage }

  DISPID_IHTMLINPUTIMAGE_TYPE                                   = DISPID_INPUT; 
  DISPID_IHTMLINPUTIMAGE_DISABLED                               = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLINPUTIMAGE_BORDER                                 = DISPID_INPUT+12; 
  DISPID_IHTMLINPUTIMAGE_VSPACE                                 = DISPID_INPUT+13; 
  DISPID_IHTMLINPUTIMAGE_HSPACE                                 = DISPID_INPUT+14; 
  DISPID_IHTMLINPUTIMAGE_ALT                                    = DISPID_INPUT+10; 
  DISPID_IHTMLINPUTIMAGE_SRC                                    = DISPID_INPUT+11; 
  DISPID_IHTMLINPUTIMAGE_LOWSRC                                 = DISPID_INPUT+15; 
  DISPID_IHTMLINPUTIMAGE_VRML                                   = DISPID_INPUT+16; 
  DISPID_IHTMLINPUTIMAGE_DYNSRC                                 = DISPID_INPUT+17; 
  DISPID_IHTMLINPUTIMAGE_READYSTATE                             = DISPID_A_READYSTATE; 
  DISPID_IHTMLINPUTIMAGE_COMPLETE                               = DISPID_INPUT+18; 
  DISPID_IHTMLINPUTIMAGE_LOOP                                   = DISPID_INPUT+19; 
  DISPID_IHTMLINPUTIMAGE_ALIGN                                  = STDPROPID_XOBJ_CONTROLALIGN; 
  DISPID_IHTMLINPUTIMAGE_ONLOAD                                 = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLINPUTIMAGE_ONERROR                                = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLINPUTIMAGE_ONABORT                                = DISPID_EVPROP_ONABORT; 
  DISPID_IHTMLINPUTIMAGE_NAME                                   = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLINPUTIMAGE_WIDTH                                  = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLINPUTIMAGE_HEIGHT                                 = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLINPUTIMAGE_START                                  = DISPID_INPUT+20; 

{    DISPIDs for event set HTMLInputTextElementEvents2 }

  DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONCHANGE                   = DISPID_EVMETH_ONCHANGE; 
  DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONSELECT                   = DISPID_EVMETH_ONSELECT; 
  DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONLOAD                     = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONERROR                    = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLINPUTTEXTELEMENTEVENTS2_ONABORT                    = DISPID_EVMETH_ONABORT; 

{    DISPIDs for event set HTMLInputImageEvents2 }

  DISPID_HTMLINPUTIMAGEEVENTS2_ONLOAD                           = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLINPUTIMAGEEVENTS2_ONERROR                          = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLINPUTIMAGEEVENTS2_ONABORT                          = DISPID_EVMETH_ONABORT; 

{    DISPIDs for event set HTMLInputTextElementEvents }

  DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONCHANGE                    = DISPID_EVMETH_ONCHANGE;
  DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONSELECT                    = DISPID_EVMETH_ONSELECT;
  DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONLOAD                      = DISPID_EVMETH_ONLOAD;
  DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONERROR                     = DISPID_EVMETH_ONERROR;
  DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONABORT                     = DISPID_EVMETH_ONABORT;

  DISPID_HTMLOPTIONBUTTONELEMENTEVENTS_ONCHANGE           = DISPID_HTMLINPUTTEXTELEMENTEVENTS_ONCHANGE;

{    DISPIDs for event set HTMLInputImageEvents }

  DISPID_HTMLINPUTIMAGEEVENTS_ONLOAD                            = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLINPUTIMAGEEVENTS_ONERROR                           = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLINPUTIMAGEEVENTS_ONABORT                           = DISPID_EVMETH_ONABORT; 

{    DISPIDs for interface IHTMLTextAreaElement }

  DISPID_IHTMLTEXTAREAELEMENT_TYPE                              = DISPID_INPUT; 
  DISPID_IHTMLTEXTAREAELEMENT_VALUE                             = DISPID_A_VALUE; 
  DISPID_IHTMLTEXTAREAELEMENT_NAME                              = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLTEXTAREAELEMENT_STATUS                            = DISPID_INPUT+1; 
  DISPID_IHTMLTEXTAREAELEMENT_DISABLED                          = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLTEXTAREAELEMENT_FORM                              = DISPID_SITE+4; 
  DISPID_IHTMLTEXTAREAELEMENT_DEFAULTVALUE                      = DISPID_DEFAULTVALUE; 
  DISPID_IHTMLTEXTAREAELEMENT_SELECT                            = DISPID_RICHTEXT+5; 
  DISPID_IHTMLTEXTAREAELEMENT_ONCHANGE                          = DISPID_EVPROP_ONCHANGE; 
  DISPID_IHTMLTEXTAREAELEMENT_ONSELECT                          = DISPID_EVPROP_ONSELECT; 
  DISPID_IHTMLTEXTAREAELEMENT_READONLY                          = DISPID_RICHTEXT+4; 
  DISPID_IHTMLTEXTAREAELEMENT_ROWS                              = DISPID_RICHTEXT+1; 
  DISPID_IHTMLTEXTAREAELEMENT_COLS                              = DISPID_RICHTEXT+2; 
  DISPID_IHTMLTEXTAREAELEMENT_WRAP                              = DISPID_RICHTEXT+3; 
  DISPID_IHTMLTEXTAREAELEMENT_CREATETEXTRANGE                   = DISPID_RICHTEXT+6; 

{    DISPIDs for interface IHTMLButtonElement }

  DISPID_IHTMLBUTTONELEMENT_TYPE                                = DISPID_INPUT; 
  DISPID_IHTMLBUTTONELEMENT_VALUE                               = DISPID_A_VALUE; 
  DISPID_IHTMLBUTTONELEMENT_NAME                                = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLBUTTONELEMENT_STATUS                              = DISPID_BUTTON+1; 
  DISPID_IHTMLBUTTONELEMENT_DISABLED                            = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLBUTTONELEMENT_FORM                                = DISPID_SITE+4; 
  DISPID_IHTMLBUTTONELEMENT_CREATETEXTRANGE                     = DISPID_BUTTON+2; 

{    DISPIDs for interface IHTMLMarqueeElement }

  DISPID_IHTMLMARQUEEELEMENT_BGCOLOR                            = DISPID_BACKCOLOR; 
  DISPID_IHTMLMARQUEEELEMENT_SCROLLDELAY                        = DISPID_MARQUEE; 
  DISPID_IHTMLMARQUEEELEMENT_DIRECTION                          = DISPID_MARQUEE+1; 
  DISPID_IHTMLMARQUEEELEMENT_BEHAVIOR                           = DISPID_MARQUEE+2; 
  DISPID_IHTMLMARQUEEELEMENT_SCROLLAMOUNT                       = DISPID_MARQUEE+3; 
  DISPID_IHTMLMARQUEEELEMENT_LOOP                               = DISPID_MARQUEE+4; 
  DISPID_IHTMLMARQUEEELEMENT_VSPACE                             = DISPID_MARQUEE+5; 
  DISPID_IHTMLMARQUEEELEMENT_HSPACE                             = DISPID_MARQUEE+6; 
  DISPID_IHTMLMARQUEEELEMENT_ONFINISH                           = DISPID_EVPROP_ONFINISH; 
  DISPID_IHTMLMARQUEEELEMENT_ONSTART                            = DISPID_EVPROP_ONSTART; 
  DISPID_IHTMLMARQUEEELEMENT_ONBOUNCE                           = DISPID_EVPROP_ONBOUNCE; 
  DISPID_IHTMLMARQUEEELEMENT_WIDTH                              = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLMARQUEEELEMENT_HEIGHT                             = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLMARQUEEELEMENT_TRUESPEED                          = DISPID_MARQUEE+7; 
  DISPID_IHTMLMARQUEEELEMENT_START                              = DISPID_MARQUEE+10; 
  DISPID_IHTMLMARQUEEELEMENT_STOP                               = DISPID_MARQUEE+11; 

{    DISPIDs for event set HTMLMarqueeElementEvents2 }

  DISPID_HTMLMARQUEEELEMENTEVENTS2_ONBOUNCE                     = DISPID_EVMETH_ONBOUNCE; 
  DISPID_HTMLMARQUEEELEMENTEVENTS2_ONFINISH                     = DISPID_EVMETH_ONFINISH; 
  DISPID_HTMLMARQUEEELEMENTEVENTS2_ONSTART                      = DISPID_EVMETH_ONSTART; 

{    DISPIDs for event set HTMLMarqueeElementEvents }

  DISPID_HTMLMARQUEEELEMENTEVENTS_ONBOUNCE                      = DISPID_EVMETH_ONBOUNCE; 
  DISPID_HTMLMARQUEEELEMENTEVENTS_ONFINISH                      = DISPID_EVMETH_ONFINISH; 
  DISPID_HTMLMARQUEEELEMENTEVENTS_ONSTART                       = DISPID_EVMETH_ONSTART; 

{    DISPIDs for interface IHTMLHtmlElement }

  DISPID_IHTMLHTMLELEMENT_VERSION                               = DISPID_HEDELEMS+1; 

{    DISPIDs for interface IHTMLHeadElement }

  DISPID_IHTMLHEADELEMENT_PROFILE                               = DISPID_HEDELEMS+1; 

{    DISPIDs for interface IHTMLTitleElement }

  DISPID_IHTMLTITLEELEMENT_TEXT                                 = DISPID_A_VALUE; 

{    DISPIDs for interface IHTMLMetaElement }

  DISPID_IHTMLMETAELEMENT_HTTPEQUIV                             = DISPID_HEDELEMS+1; 
  DISPID_IHTMLMETAELEMENT_CONTENT                               = DISPID_HEDELEMS+2; 
  DISPID_IHTMLMETAELEMENT_NAME                                  = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLMETAELEMENT_URL                                   = DISPID_HEDELEMS+3; 
  DISPID_IHTMLMETAELEMENT_CHARSET                               = DISPID_HEDELEMS+13; 

{    DISPIDs for interface IHTMLMetaElement2 }

  DISPID_IHTMLMETAELEMENT2_SCHEME                               = DISPID_HEDELEMS+20; 

{    DISPIDs for interface IHTMLBaseElement }

  DISPID_IHTMLBASEELEMENT_HREF                                  = DISPID_HEDELEMS+3; 
  DISPID_IHTMLBASEELEMENT_TARGET                                = DISPID_HEDELEMS+4; 

{    DISPIDs for interface IHTMLIsIndexElement }

  DISPID_IHTMLISINDEXELEMENT_PROMPT                             = DISPID_HEDELEMS+10; 
  DISPID_IHTMLISINDEXELEMENT_ACTION                             = DISPID_HEDELEMS+11; 

{    DISPIDs for interface IHTMLIsIndexElement2 }

  DISPID_IHTMLISINDEXELEMENT2_FORM                              = DISPID_HEDELEMS+12; 

{    DISPIDs for interface IHTMLNextIdElement }

  DISPID_IHTMLNEXTIDELEMENT_N                                   = DISPID_HEDELEMS+12; 

{    DISPIDs for interface IHTMLBaseFontElement }

  DISPID_IHTMLBASEFONTELEMENT_COLOR                             = DISPID_A_COLOR; 
  DISPID_IHTMLBASEFONTELEMENT_FACE                              = DISPID_A_FONTFACE; 
  DISPID_IHTMLBASEFONTELEMENT_SIZE                              = DISPID_A_BASEFONT; 

{    DISPIDs for interface IOmHistory }

  DISPID_IOMHISTORY_LENGTH                                      = DISPID_HISTORY; 
  DISPID_IOMHISTORY_BACK                                        = DISPID_HISTORY+1; 
  DISPID_IOMHISTORY_FORWARD                                     = DISPID_HISTORY+2; 
  DISPID_IOMHISTORY_GO                                          = DISPID_HISTORY+3; 

{    DISPIDs for interface IHTMLMimeTypesCollection }

  DISPID_IHTMLMIMETYPESCOLLECTION_LENGTH                        = 1; 

{    DISPIDs for interface IHTMLPluginsCollection }

  DISPID_IHTMLPLUGINSCOLLECTION_LENGTH                          = 1; 
  DISPID_IHTMLPLUGINSCOLLECTION_REFRESH                         = 2; 

{    DISPIDs for interface IHTMLOpsProfile }

  DISPID_IHTMLOPSPROFILE_ADDREQUEST                             = 1; 
  DISPID_IHTMLOPSPROFILE_CLEARREQUEST                           = 2; 
  DISPID_IHTMLOPSPROFILE_DOREQUEST                              = 3; 
  DISPID_IHTMLOPSPROFILE_GETATTRIBUTE                           = 4; 
  DISPID_IHTMLOPSPROFILE_SETATTRIBUTE                           = 5; 
  DISPID_IHTMLOPSPROFILE_COMMITCHANGES                          = 6; 
  DISPID_IHTMLOPSPROFILE_ADDREADREQUEST                         = 7; 
  DISPID_IHTMLOPSPROFILE_DOREADREQUEST                          = 8; 
  DISPID_IHTMLOPSPROFILE_DOWRITEREQUEST                         = 9; 

{    DISPIDs for interface IOmNavigator }

  DISPID_IOMNAVIGATOR_APPCODENAME                               = DISPID_NAVIGATOR; 
  DISPID_IOMNAVIGATOR_APPNAME                                   = DISPID_NAVIGATOR+1; 
  DISPID_IOMNAVIGATOR_APPVERSION                                = DISPID_NAVIGATOR+2; 
  DISPID_IOMNAVIGATOR_USERAGENT                                 = DISPID_NAVIGATOR+3; 
  DISPID_IOMNAVIGATOR_JAVAENABLED                               = DISPID_NAVIGATOR+4; 
  DISPID_IOMNAVIGATOR_TAINTENABLED                              = DISPID_NAVIGATOR+5; 
  DISPID_IOMNAVIGATOR_MIMETYPES                                 = DISPID_NAVIGATOR+6; 
  DISPID_IOMNAVIGATOR_PLUGINS                                   = DISPID_NAVIGATOR+7; 
  DISPID_IOMNAVIGATOR_COOKIEENABLED                             = DISPID_NAVIGATOR+8; 
  DISPID_IOMNAVIGATOR_OPSPROFILE                                = DISPID_NAVIGATOR+9; 
  DISPID_IOMNAVIGATOR_TOSTRING                                  = DISPID_NAVIGATOR+10; 
  DISPID_IOMNAVIGATOR_CPUCLASS                                  = DISPID_NAVIGATOR+11; 
  DISPID_IOMNAVIGATOR_SYSTEMLANGUAGE                            = DISPID_NAVIGATOR+12; 
  DISPID_IOMNAVIGATOR_BROWSERLANGUAGE                           = DISPID_NAVIGATOR+13; 
  DISPID_IOMNAVIGATOR_USERLANGUAGE                              = DISPID_NAVIGATOR+14; 
  DISPID_IOMNAVIGATOR_PLATFORM                                  = DISPID_NAVIGATOR+15; 
  DISPID_IOMNAVIGATOR_APPMINORVERSION                           = DISPID_NAVIGATOR+16; 
  DISPID_IOMNAVIGATOR_CONNECTIONSPEED                           = DISPID_NAVIGATOR+17; 
  DISPID_IOMNAVIGATOR_ONLINE                                    = DISPID_NAVIGATOR+18; 
  DISPID_IOMNAVIGATOR_USERPROFILE                               = DISPID_NAVIGATOR+19; 

{    DISPIDs for interface IHTMLLocation }

  DISPID_IHTMLLOCATION_HREF                                     = DISPID_VALUE; 
  DISPID_IHTMLLOCATION_PROTOCOL                                 = DISPID_LOCATION; 
  DISPID_IHTMLLOCATION_HOST                                     = DISPID_LOCATION+1; 
  DISPID_IHTMLLOCATION_HOSTNAME                                 = DISPID_LOCATION+2; 
  DISPID_IHTMLLOCATION_PORT                                     = DISPID_LOCATION+3; 
  DISPID_IHTMLLOCATION_PATHNAME                                 = DISPID_LOCATION+4; 
  DISPID_IHTMLLOCATION_SEARCH                                   = DISPID_LOCATION+5; 
  DISPID_IHTMLLOCATION_HASH                                     = DISPID_LOCATION+6; 
  DISPID_IHTMLLOCATION_RELOAD                                   = DISPID_LOCATION+7; 
  DISPID_IHTMLLOCATION_REPLACE                                  = DISPID_LOCATION+8; 
  DISPID_IHTMLLOCATION_ASSIGN                                   = DISPID_LOCATION+9; 
  DISPID_IHTMLLOCATION_TOSTRING                                 = DISPID_LOCATION+10; 

{    DISPIDs for interface IHTMLBookmarkCollection }

  DISPID_IHTMLBOOKMARKCOLLECTION_LENGTH                         = DISPID_OPTIONS_COL+1; 
  DISPID_IHTMLBOOKMARKCOLLECTION__NEWENUM                       = DISPID_NEWENUM; 
  DISPID_IHTMLBOOKMARKCOLLECTION_ITEM                           = DISPID_VALUE; 

{    DISPIDs for interface IHTMLDataTransfer }

  DISPID_IHTMLDATATRANSFER_SETDATA                              = DISPID_DATATRANSFER+1; 
  DISPID_IHTMLDATATRANSFER_GETDATA                              = DISPID_DATATRANSFER+2; 
  DISPID_IHTMLDATATRANSFER_CLEARDATA                            = DISPID_DATATRANSFER+3; 
  DISPID_IHTMLDATATRANSFER_DROPEFFECT                           = DISPID_DATATRANSFER+4; 
  DISPID_IHTMLDATATRANSFER_EFFECTALLOWED                        = DISPID_DATATRANSFER+5; 

{    DISPIDs for interface IHTMLEventObj }

  DISPID_IHTMLEVENTOBJ_SRCELEMENT                               = DISPID_EVENTOBJ+1; 
  DISPID_IHTMLEVENTOBJ_ALTKEY                                   = DISPID_EVENTOBJ+2; 
  DISPID_IHTMLEVENTOBJ_CTRLKEY                                  = DISPID_EVENTOBJ+3; 
  DISPID_IHTMLEVENTOBJ_SHIFTKEY                                 = DISPID_EVENTOBJ+4; 
  DISPID_IHTMLEVENTOBJ_RETURNVALUE                              = DISPID_EVENTOBJ+7; 
  DISPID_IHTMLEVENTOBJ_CANCELBUBBLE                             = DISPID_EVENTOBJ+8; 
  DISPID_IHTMLEVENTOBJ_FROMELEMENT                              = DISPID_EVENTOBJ+9; 
  DISPID_IHTMLEVENTOBJ_TOELEMENT                                = DISPID_EVENTOBJ+10; 
  DISPID_IHTMLEVENTOBJ_KEYCODE                                  = DISPID_EVENTOBJ+11; 
  DISPID_IHTMLEVENTOBJ_BUTTON                                   = DISPID_EVENTOBJ+12; 
  DISPID_IHTMLEVENTOBJ_TYPE                                     = DISPID_EVENTOBJ+13; 
  DISPID_IHTMLEVENTOBJ_QUALIFIER                                = DISPID_EVENTOBJ+14; 
  DISPID_IHTMLEVENTOBJ_REASON                                   = DISPID_EVENTOBJ+15; 
  DISPID_IHTMLEVENTOBJ_X                                        = DISPID_EVENTOBJ+5; 
  DISPID_IHTMLEVENTOBJ_Y                                        = DISPID_EVENTOBJ+6; 
  DISPID_IHTMLEVENTOBJ_CLIENTX                                  = DISPID_EVENTOBJ+20; 
  DISPID_IHTMLEVENTOBJ_CLIENTY                                  = DISPID_EVENTOBJ+21; 
  DISPID_IHTMLEVENTOBJ_OFFSETX                                  = DISPID_EVENTOBJ+22; 
  DISPID_IHTMLEVENTOBJ_OFFSETY                                  = DISPID_EVENTOBJ+23; 
  DISPID_IHTMLEVENTOBJ_SCREENX                                  = DISPID_EVENTOBJ+24; 
  DISPID_IHTMLEVENTOBJ_SCREENY                                  = DISPID_EVENTOBJ+25; 
  DISPID_IHTMLEVENTOBJ_SRCFILTER                                = DISPID_EVENTOBJ+26; 

{    DISPIDs for interface IHTMLEventObj2 }

  DISPID_IHTMLEVENTOBJ2_SETATTRIBUTE                            = DISPID_HTMLOBJECT+1; 
  DISPID_IHTMLEVENTOBJ2_GETATTRIBUTE                            = DISPID_HTMLOBJECT+2; 
  DISPID_IHTMLEVENTOBJ2_REMOVEATTRIBUTE                         = DISPID_HTMLOBJECT+3; 
  DISPID_IHTMLEVENTOBJ2_PROPERTYNAME                            = DISPID_EVENTOBJ+27; 
  DISPID_IHTMLEVENTOBJ2_BOOKMARKS                               = DISPID_EVENTOBJ+31; 
  DISPID_IHTMLEVENTOBJ2_RECORDSET                               = DISPID_EVENTOBJ+32; 
  DISPID_IHTMLEVENTOBJ2_DATAFLD                                 = DISPID_EVENTOBJ+33; 
  DISPID_IHTMLEVENTOBJ2_BOUNDELEMENTS                           = DISPID_EVENTOBJ+34; 
  DISPID_IHTMLEVENTOBJ2_REPEAT                                  = DISPID_EVENTOBJ+35; 
  DISPID_IHTMLEVENTOBJ2_SRCURN                                  = DISPID_EVENTOBJ+36; 
  DISPID_IHTMLEVENTOBJ2_SRCELEMENT                              = DISPID_EVENTOBJ+1; 
  DISPID_IHTMLEVENTOBJ2_ALTKEY                                  = DISPID_EVENTOBJ+2; 
  DISPID_IHTMLEVENTOBJ2_CTRLKEY                                 = DISPID_EVENTOBJ+3; 
  DISPID_IHTMLEVENTOBJ2_SHIFTKEY                                = DISPID_EVENTOBJ+4; 
  DISPID_IHTMLEVENTOBJ2_FROMELEMENT                             = DISPID_EVENTOBJ+9; 
  DISPID_IHTMLEVENTOBJ2_TOELEMENT                               = DISPID_EVENTOBJ+10; 
  DISPID_IHTMLEVENTOBJ2_BUTTON                                  = DISPID_EVENTOBJ+12; 
  DISPID_IHTMLEVENTOBJ2_TYPE                                    = DISPID_EVENTOBJ+13; 
  DISPID_IHTMLEVENTOBJ2_QUALIFIER                               = DISPID_EVENTOBJ+14; 
  DISPID_IHTMLEVENTOBJ2_REASON                                  = DISPID_EVENTOBJ+15; 
  DISPID_IHTMLEVENTOBJ2_X                                       = DISPID_EVENTOBJ+5; 
  DISPID_IHTMLEVENTOBJ2_Y                                       = DISPID_EVENTOBJ+6; 
  DISPID_IHTMLEVENTOBJ2_CLIENTX                                 = DISPID_EVENTOBJ+20; 
  DISPID_IHTMLEVENTOBJ2_CLIENTY                                 = DISPID_EVENTOBJ+21; 
  DISPID_IHTMLEVENTOBJ2_OFFSETX                                 = DISPID_EVENTOBJ+22; 
  DISPID_IHTMLEVENTOBJ2_OFFSETY                                 = DISPID_EVENTOBJ+23; 
  DISPID_IHTMLEVENTOBJ2_SCREENX                                 = DISPID_EVENTOBJ+24; 
  DISPID_IHTMLEVENTOBJ2_SCREENY                                 = DISPID_EVENTOBJ+25; 
  DISPID_IHTMLEVENTOBJ2_SRCFILTER                               = DISPID_EVENTOBJ+26; 
  DISPID_IHTMLEVENTOBJ2_DATATRANSFER                            = DISPID_EVENTOBJ+37; 

{    DISPIDs for interface IHTMLEventObj3 }

  DISPID_IHTMLEVENTOBJ3_CONTENTOVERFLOW                         = DISPID_EVENTOBJ+38; 
  DISPID_IHTMLEVENTOBJ3_SHIFTLEFT                               = DISPID_EVENTOBJ+39; 
  DISPID_IHTMLEVENTOBJ3_ALTLEFT                                 = DISPID_EVENTOBJ+40; 
  DISPID_IHTMLEVENTOBJ3_CTRLLEFT                                = DISPID_EVENTOBJ+41; 
  DISPID_IHTMLEVENTOBJ3_IMECOMPOSITIONCHANGE                    = DISPID_EVENTOBJ+42; 
  DISPID_IHTMLEVENTOBJ3_IMENOTIFYCOMMAND                        = DISPID_EVENTOBJ+43; 
  DISPID_IHTMLEVENTOBJ3_IMENOTIFYDATA                           = DISPID_EVENTOBJ+44; 
  DISPID_IHTMLEVENTOBJ3_IMEREQUEST                              = DISPID_EVENTOBJ+46; 
  DISPID_IHTMLEVENTOBJ3_IMEREQUESTDATA                          = DISPID_EVENTOBJ+47; 
  DISPID_IHTMLEVENTOBJ3_KEYBOARDLAYOUT                          = DISPID_EVENTOBJ+45; 
  DISPID_IHTMLEVENTOBJ3_BEHAVIORCOOKIE                          = DISPID_EVENTOBJ+48; 
  DISPID_IHTMLEVENTOBJ3_BEHAVIORPART                            = DISPID_EVENTOBJ+49; 
  DISPID_IHTMLEVENTOBJ3_NEXTPAGE                                = DISPID_EVENTOBJ+50; 

{    DISPIDs for interface IHTMLEventObj4 }

  DISPID_IHTMLEVENTOBJ4_WHEELDELTA                              = DISPID_EVENTOBJ+51; 

{    DISPIDs for interface IHTMLFramesCollection2 }

  DISPID_IHTMLFRAMESCOLLECTION2_ITEM                            = 0; 
  DISPID_IHTMLFRAMESCOLLECTION2_LENGTH                          = 1001; 

{    DISPIDs for interface IHTMLScreen }

  DISPID_IHTMLSCREEN_COLORDEPTH                                 = DISPID_SCREEN+1; 
  DISPID_IHTMLSCREEN_BUFFERDEPTH                                = DISPID_SCREEN+2; 
  DISPID_IHTMLSCREEN_WIDTH                                      = DISPID_SCREEN+3; 
  DISPID_IHTMLSCREEN_HEIGHT                                     = DISPID_SCREEN+4; 
  DISPID_IHTMLSCREEN_UPDATEINTERVAL                             = DISPID_SCREEN+5; 
  DISPID_IHTMLSCREEN_AVAILHEIGHT                                = DISPID_SCREEN+6; 
  DISPID_IHTMLSCREEN_AVAILWIDTH                                 = DISPID_SCREEN+7; 
  DISPID_IHTMLSCREEN_FONTSMOOTHINGENABLED                       = DISPID_SCREEN+8; 

{    DISPIDs for interface IHTMLScreen2 }

  DISPID_IHTMLSCREEN2_LOGICALXDPI                               = DISPID_SCREEN+9; 
  DISPID_IHTMLSCREEN2_LOGICALYDPI                               = DISPID_SCREEN+10; 
  DISPID_IHTMLSCREEN2_DEVICEXDPI                                = DISPID_SCREEN+11; 
  DISPID_IHTMLSCREEN2_DEVICEYDPI                                = DISPID_SCREEN+12; 

{    DISPIDs for interface IHTMLWindow2 }

  DISPID_IHTMLWINDOW2_FRAMES                                    = 1100; 
  DISPID_IHTMLWINDOW2_DEFAULTSTATUS                             = 1101; 
  DISPID_IHTMLWINDOW2_STATUS                                    = 1102; 
  DISPID_IHTMLWINDOW2_SETTIMEOUT                                = 1172; 
  DISPID_IHTMLWINDOW2_CLEARTIMEOUT                              = 1104; 
  DISPID_IHTMLWINDOW2_ALERT                                     = 1105; 
  DISPID_IHTMLWINDOW2_CONFIRM                                   = 1110; 
  DISPID_IHTMLWINDOW2_PROMPT                                    = 1111; 
  DISPID_IHTMLWINDOW2_IMAGE                                     = 1125; 
  DISPID_IHTMLWINDOW2_LOCATION                                  = 14; 
  DISPID_IHTMLWINDOW2_HISTORY                                   = 2; 
  DISPID_IHTMLWINDOW2_CLOSE                                     = 3; 
  DISPID_IHTMLWINDOW2_OPENER                                    = 4; 
  DISPID_IHTMLWINDOW2_NAVIGATOR                                 = 5; 
  DISPID_IHTMLWINDOW2_NAME                                      = 11; 
  DISPID_IHTMLWINDOW2_PARENT                                    = 12; 
  DISPID_IHTMLWINDOW2_OPEN                                      = 13; 
  DISPID_IHTMLWINDOW2_SELF                                      = 20; 
  DISPID_IHTMLWINDOW2_TOP                                       = 21; 
  DISPID_IHTMLWINDOW2_WINDOW                                    = 22; 
  DISPID_IHTMLWINDOW2_NAVIGATE                                  = 25; 
  DISPID_IHTMLWINDOW2_ONFOCUS                                   = DISPID_EVPROP_ONFOCUS; 
  DISPID_IHTMLWINDOW2_ONBLUR                                    = DISPID_EVPROP_ONBLUR; 
  DISPID_IHTMLWINDOW2_ONLOAD                                    = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLWINDOW2_ONBEFOREUNLOAD                            = DISPID_EVPROP_ONBEFOREUNLOAD; 
  DISPID_IHTMLWINDOW2_ONUNLOAD                                  = DISPID_EVPROP_ONUNLOAD; 
  DISPID_IHTMLWINDOW2_ONHELP                                    = DISPID_EVPROP_ONHELP; 
  DISPID_IHTMLWINDOW2_ONERROR                                   = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLWINDOW2_ONRESIZE                                  = DISPID_EVPROP_ONRESIZE; 
  DISPID_IHTMLWINDOW2_ONSCROLL                                  = DISPID_EVPROP_ONSCROLL; 
  DISPID_IHTMLWINDOW2_DOCUMENT                                  = 1151; 
  DISPID_IHTMLWINDOW2_EVENT                                     = 1152; 
  DISPID_IHTMLWINDOW2__NEWENUM                                  = 1153; 
  DISPID_IHTMLWINDOW2_SHOWMODALDIALOG                           = 1154; 
  DISPID_IHTMLWINDOW2_SHOWHELP                                  = 1155; 
  DISPID_IHTMLWINDOW2_SCREEN                                    = 1156; 
  DISPID_IHTMLWINDOW2_OPTION                                    = 1157; 
  DISPID_IHTMLWINDOW2_FOCUS                                     = 1158; 
  DISPID_IHTMLWINDOW2_CLOSED                                    = 23; 
  DISPID_IHTMLWINDOW2_BLUR                                      = 1159; 
  DISPID_IHTMLWINDOW2_SCROLL                                    = 1160; 
  DISPID_IHTMLWINDOW2_CLIENTINFORMATION                         = 1161; 
  DISPID_IHTMLWINDOW2_SETINTERVAL                               = 1173; 
  DISPID_IHTMLWINDOW2_CLEARINTERVAL                             = 1163; 
  DISPID_IHTMLWINDOW2_OFFSCREENBUFFERING                        = 1164; 
  DISPID_IHTMLWINDOW2_EXECSCRIPT                                = 1165; 
  DISPID_IHTMLWINDOW2_TOSTRING                                  = 1166; 
  DISPID_IHTMLWINDOW2_SCROLLBY                                  = 1167; 
  DISPID_IHTMLWINDOW2_SCROLLTO                                  = 1168; 
  DISPID_IHTMLWINDOW2_MOVETO                                    = 6; 
  DISPID_IHTMLWINDOW2_MOVEBY                                    = 7; 
  DISPID_IHTMLWINDOW2_RESIZETO                                  = 9; 
  DISPID_IHTMLWINDOW2_RESIZEBY                                  = 8; 
  DISPID_IHTMLWINDOW2_EXTERNAL                                  = 1169; 

{    DISPIDs for interface IHTMLWindow3 }

  DISPID_IHTMLWINDOW3_SCREENLEFT                                = 1170; 
  DISPID_IHTMLWINDOW3_SCREENTOP                                 = 1171; 
  DISPID_IHTMLWINDOW3_ATTACHEVENT                               = DISPID_HTMLOBJECT+7; 
  DISPID_IHTMLWINDOW3_DETACHEVENT                               = DISPID_HTMLOBJECT+8; 
  DISPID_IHTMLWINDOW3_SETTIMEOUT                                = 1103; 
  DISPID_IHTMLWINDOW3_SETINTERVAL                               = 1162; 
  DISPID_IHTMLWINDOW3_PRINT                                     = 1174; 
  DISPID_IHTMLWINDOW3_ONBEFOREPRINT                             = DISPID_EVPROP_ONBEFOREPRINT; 
  DISPID_IHTMLWINDOW3_ONAFTERPRINT                              = DISPID_EVPROP_ONAFTERPRINT; 
  DISPID_IHTMLWINDOW3_CLIPBOARDDATA                             = 1175; 
  DISPID_IHTMLWINDOW3_SHOWMODELESSDIALOG                        = 1176; 

{    DISPIDs for interface IHTMLWindow4 }

  DISPID_IHTMLWINDOW4_CREATEPOPUP                               = 1180; 
  DISPID_IHTMLWINDOW4_FRAMEELEMENT                              = 1181; 

{    DISPIDs for event set HTMLWindowEvents2 }

  DISPID_HTMLWINDOWEVENTS2_ONLOAD                               = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLWINDOWEVENTS2_ONUNLOAD                             = DISPID_EVMETH_ONUNLOAD; 
  DISPID_HTMLWINDOWEVENTS2_ONHELP                               = DISPID_EVMETH_ONHELP; 
  DISPID_HTMLWINDOWEVENTS2_ONFOCUS                              = DISPID_EVMETH_ONFOCUS; 
  DISPID_HTMLWINDOWEVENTS2_ONBLUR                               = DISPID_EVMETH_ONBLUR; 
  DISPID_HTMLWINDOWEVENTS2_ONERROR                              = DISPID_EVMETH_ONERROR; 
  DISPID_HTMLWINDOWEVENTS2_ONRESIZE                             = DISPID_EVMETH_ONRESIZE; 
  DISPID_HTMLWINDOWEVENTS2_ONSCROLL                             = DISPID_EVMETH_ONSCROLL; 
  DISPID_HTMLWINDOWEVENTS2_ONBEFOREUNLOAD                       = DISPID_EVMETH_ONBEFOREUNLOAD; 
  DISPID_HTMLWINDOWEVENTS2_ONBEFOREPRINT                        = DISPID_EVMETH_ONBEFOREPRINT; 
  DISPID_HTMLWINDOWEVENTS2_ONAFTERPRINT                         = DISPID_EVMETH_ONAFTERPRINT; 

{    DISPIDs for event set HTMLWindowEvents }

  DISPID_HTMLWINDOWEVENTS_ONLOAD                                = Integer(DISPID_EVMETH_ONLOAD);
  DISPID_HTMLWINDOWEVENTS_ONUNLOAD                              = Integer(DISPID_EVMETH_ONUNLOAD);
  DISPID_HTMLWINDOWEVENTS_ONHELP                                = Integer(DISPID_EVMETH_ONHELP);
  DISPID_HTMLWINDOWEVENTS_ONFOCUS                               = Integer(DISPID_EVMETH_ONFOCUS);
  DISPID_HTMLWINDOWEVENTS_ONBLUR                                = Integer(DISPID_EVMETH_ONBLUR);
  DISPID_HTMLWINDOWEVENTS_ONERROR                               = Integer(DISPID_EVMETH_ONERROR);
  DISPID_HTMLWINDOWEVENTS_ONRESIZE                              = Integer(DISPID_EVMETH_ONRESIZE);
  DISPID_HTMLWINDOWEVENTS_ONSCROLL                              = Integer(DISPID_EVMETH_ONSCROLL);
  DISPID_HTMLWINDOWEVENTS_ONBEFOREUNLOAD                        = Integer(DISPID_EVMETH_ONBEFOREUNLOAD);
  DISPID_HTMLWINDOWEVENTS_ONBEFOREPRINT                         = Integer(DISPID_EVMETH_ONBEFOREPRINT);
  DISPID_HTMLWINDOWEVENTS_ONAFTERPRINT                          = Integer(DISPID_EVMETH_ONAFTERPRINT);

{    DISPIDs for interface IHTMLDocument }

  DISPID_IHTMLDOCUMENT_SCRIPT                                   = DISPID_OMDOCUMENT+1; 

{    DISPIDs for interface IHTMLDocument2 }

  DISPID_IHTMLDOCUMENT2_ALL                                     = DISPID_OMDOCUMENT+3; 
  DISPID_IHTMLDOCUMENT2_BODY                                    = DISPID_OMDOCUMENT+4; 
  DISPID_IHTMLDOCUMENT2_ACTIVEELEMENT                           = DISPID_OMDOCUMENT+5; 
  DISPID_IHTMLDOCUMENT2_IMAGES                                  = DISPID_OMDOCUMENT+11; 
  DISPID_IHTMLDOCUMENT2_APPLETS                                 = DISPID_OMDOCUMENT+8; 
  DISPID_IHTMLDOCUMENT2_LINKS                                   = DISPID_OMDOCUMENT+9; 
  DISPID_IHTMLDOCUMENT2_FORMS                                   = DISPID_OMDOCUMENT+10; 
  DISPID_IHTMLDOCUMENT2_ANCHORS                                 = DISPID_OMDOCUMENT+7; 
  DISPID_IHTMLDOCUMENT2_TITLE                                   = DISPID_OMDOCUMENT+12; 
  DISPID_IHTMLDOCUMENT2_SCRIPTS                                 = DISPID_OMDOCUMENT+13; 
  DISPID_IHTMLDOCUMENT2_DESIGNMODE                              = DISPID_OMDOCUMENT+14; 
  DISPID_IHTMLDOCUMENT2_SELECTION                               = DISPID_OMDOCUMENT+17; 
  DISPID_IHTMLDOCUMENT2_READYSTATE                              = DISPID_OMDOCUMENT+18; 
  DISPID_IHTMLDOCUMENT2_FRAMES                                  = DISPID_OMDOCUMENT+19; 
  DISPID_IHTMLDOCUMENT2_EMBEDS                                  = DISPID_OMDOCUMENT+15; 
  DISPID_IHTMLDOCUMENT2_PLUGINS                                 = DISPID_OMDOCUMENT+21; 
  DISPID_IHTMLDOCUMENT2_ALINKCOLOR                              = DISPID_OMDOCUMENT+22; 
  DISPID_IHTMLDOCUMENT2_BGCOLOR                                 = DISPID_BACKCOLOR; 
  DISPID_IHTMLDOCUMENT2_FGCOLOR                                 = DISPID_A_COLOR; 
  DISPID_IHTMLDOCUMENT2_LINKCOLOR                               = DISPID_OMDOCUMENT+24; 
  DISPID_IHTMLDOCUMENT2_VLINKCOLOR                              = DISPID_OMDOCUMENT+23; 
  DISPID_IHTMLDOCUMENT2_REFERRER                                = DISPID_OMDOCUMENT+27; 
  DISPID_IHTMLDOCUMENT2_LOCATION                                = DISPID_OMDOCUMENT+26; 
  DISPID_IHTMLDOCUMENT2_LASTMODIFIED                            = DISPID_OMDOCUMENT+28; 
  DISPID_IHTMLDOCUMENT2_URL                                     = DISPID_OMDOCUMENT+25; 
  DISPID_IHTMLDOCUMENT2_DOMAIN                                  = DISPID_OMDOCUMENT+29; 
  DISPID_IHTMLDOCUMENT2_COOKIE                                  = DISPID_OMDOCUMENT+30; 
  DISPID_IHTMLDOCUMENT2_EXPANDO                                 = DISPID_OMDOCUMENT+31; 
  DISPID_IHTMLDOCUMENT2_CHARSET                                 = DISPID_OMDOCUMENT+32; 
  DISPID_IHTMLDOCUMENT2_DEFAULTCHARSET                          = DISPID_OMDOCUMENT+33; 
  DISPID_IHTMLDOCUMENT2_MIMETYPE                                = DISPID_OMDOCUMENT+41; 
  DISPID_IHTMLDOCUMENT2_FILESIZE                                = DISPID_OMDOCUMENT+42; 
  DISPID_IHTMLDOCUMENT2_FILECREATEDDATE                         = DISPID_OMDOCUMENT+43; 
  DISPID_IHTMLDOCUMENT2_FILEMODIFIEDDATE                        = DISPID_OMDOCUMENT+44; 
  DISPID_IHTMLDOCUMENT2_FILEUPDATEDDATE                         = DISPID_OMDOCUMENT+45; 
  DISPID_IHTMLDOCUMENT2_SECURITY                                = DISPID_OMDOCUMENT+46; 
  DISPID_IHTMLDOCUMENT2_PROTOCOL                                = DISPID_OMDOCUMENT+47; 
  DISPID_IHTMLDOCUMENT2_NAMEPROP                                = DISPID_OMDOCUMENT+48; 
  DISPID_IHTMLDOCUMENT2_WRITE                                   = DISPID_OMDOCUMENT+54; 
  DISPID_IHTMLDOCUMENT2_WRITELN                                 = DISPID_OMDOCUMENT+55; 
  DISPID_IHTMLDOCUMENT2_OPEN                                    = DISPID_OMDOCUMENT+56; 
  DISPID_IHTMLDOCUMENT2_CLOSE                                   = DISPID_OMDOCUMENT+57; 
  DISPID_IHTMLDOCUMENT2_CLEAR                                   = DISPID_OMDOCUMENT+58; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDSUPPORTED                   = DISPID_OMDOCUMENT+59; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDENABLED                     = DISPID_OMDOCUMENT+60; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDSTATE                       = DISPID_OMDOCUMENT+61; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDINDETERM                    = DISPID_OMDOCUMENT+62; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDTEXT                        = DISPID_OMDOCUMENT+63; 
  DISPID_IHTMLDOCUMENT2_QUERYCOMMANDVALUE                       = DISPID_OMDOCUMENT+64; 
  DISPID_IHTMLDOCUMENT2_EXECCOMMAND                             = DISPID_OMDOCUMENT+65; 
  DISPID_IHTMLDOCUMENT2_EXECCOMMANDSHOWHELP                     = DISPID_OMDOCUMENT+66; 
  DISPID_IHTMLDOCUMENT2_CREATEELEMENT                           = DISPID_OMDOCUMENT+67; 
  DISPID_IHTMLDOCUMENT2_ONHELP                                  = DISPID_EVPROP_ONHELP; 
  DISPID_IHTMLDOCUMENT2_ONCLICK                                 = DISPID_EVPROP_ONCLICK; 
  DISPID_IHTMLDOCUMENT2_ONDBLCLICK                              = DISPID_EVPROP_ONDBLCLICK; 
  DISPID_IHTMLDOCUMENT2_ONKEYUP                                 = DISPID_EVPROP_ONKEYUP; 
  DISPID_IHTMLDOCUMENT2_ONKEYDOWN                               = DISPID_EVPROP_ONKEYDOWN; 
  DISPID_IHTMLDOCUMENT2_ONKEYPRESS                              = DISPID_EVPROP_ONKEYPRESS; 
  DISPID_IHTMLDOCUMENT2_ONMOUSEUP                               = DISPID_EVPROP_ONMOUSEUP; 
  DISPID_IHTMLDOCUMENT2_ONMOUSEDOWN                             = DISPID_EVPROP_ONMOUSEDOWN; 
  DISPID_IHTMLDOCUMENT2_ONMOUSEMOVE                             = DISPID_EVPROP_ONMOUSEMOVE; 
  DISPID_IHTMLDOCUMENT2_ONMOUSEOUT                              = DISPID_EVPROP_ONMOUSEOUT; 
  DISPID_IHTMLDOCUMENT2_ONMOUSEOVER                             = DISPID_EVPROP_ONMOUSEOVER; 
  DISPID_IHTMLDOCUMENT2_ONREADYSTATECHANGE                      = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLDOCUMENT2_ONAFTERUPDATE                           = DISPID_EVPROP_ONAFTERUPDATE; 
  DISPID_IHTMLDOCUMENT2_ONROWEXIT                               = DISPID_EVPROP_ONROWEXIT; 
  DISPID_IHTMLDOCUMENT2_ONROWENTER                              = DISPID_EVPROP_ONROWENTER; 
  DISPID_IHTMLDOCUMENT2_ONDRAGSTART                             = DISPID_EVPROP_ONDRAGSTART; 
  DISPID_IHTMLDOCUMENT2_ONSELECTSTART                           = DISPID_EVPROP_ONSELECTSTART; 
  DISPID_IHTMLDOCUMENT2_ELEMENTFROMPOINT                        = DISPID_OMDOCUMENT+68; 
  DISPID_IHTMLDOCUMENT2_PARENTWINDOW                            = DISPID_OMDOCUMENT+34; 
  DISPID_IHTMLDOCUMENT2_STYLESHEETS                             = DISPID_OMDOCUMENT+69; 
  DISPID_IHTMLDOCUMENT2_ONBEFOREUPDATE                          = DISPID_EVPROP_ONBEFOREUPDATE; 
  DISPID_IHTMLDOCUMENT2_ONERRORUPDATE                           = DISPID_EVPROP_ONERRORUPDATE; 
  DISPID_IHTMLDOCUMENT2_TOSTRING                                = DISPID_OMDOCUMENT+70; 
  DISPID_IHTMLDOCUMENT2_CREATESTYLESHEET                        = DISPID_OMDOCUMENT+71; 

{    DISPIDs for interface IHTMLDocument3 }

  DISPID_IHTMLDOCUMENT3_RELEASECAPTURE                          = DISPID_OMDOCUMENT+72; 
  DISPID_IHTMLDOCUMENT3_RECALC                                  = DISPID_OMDOCUMENT+73; 
  DISPID_IHTMLDOCUMENT3_CREATETEXTNODE                          = DISPID_OMDOCUMENT+74; 
  DISPID_IHTMLDOCUMENT3_DOCUMENTELEMENT                         = DISPID_OMDOCUMENT+75; 
  DISPID_IHTMLDOCUMENT3_UNIQUEID                                = DISPID_OMDOCUMENT+77; 
  DISPID_IHTMLDOCUMENT3_ATTACHEVENT                             = DISPID_HTMLOBJECT+7; 
  DISPID_IHTMLDOCUMENT3_DETACHEVENT                             = DISPID_HTMLOBJECT+8; 
  DISPID_IHTMLDOCUMENT3_ONROWSDELETE                            = DISPID_EVPROP_ONROWSDELETE; 
  DISPID_IHTMLDOCUMENT3_ONROWSINSERTED                          = DISPID_EVPROP_ONROWSINSERTED; 
  DISPID_IHTMLDOCUMENT3_ONCELLCHANGE                            = DISPID_EVPROP_ONCELLCHANGE; 
  DISPID_IHTMLDOCUMENT3_ONDATASETCHANGED                        = DISPID_EVPROP_ONDATASETCHANGED; 
  DISPID_IHTMLDOCUMENT3_ONDATAAVAILABLE                         = DISPID_EVPROP_ONDATAAVAILABLE; 
  DISPID_IHTMLDOCUMENT3_ONDATASETCOMPLETE                       = DISPID_EVPROP_ONDATASETCOMPLETE; 
  DISPID_IHTMLDOCUMENT3_ONPROPERTYCHANGE                        = DISPID_EVPROP_ONPROPERTYCHANGE; 
  DISPID_IHTMLDOCUMENT3_DIR                                     = DISPID_A_DIR; 
  DISPID_IHTMLDOCUMENT3_ONCONTEXTMENU                           = DISPID_EVPROP_ONCONTEXTMENU; 
  DISPID_IHTMLDOCUMENT3_ONSTOP                                  = DISPID_EVPROP_ONSTOP; 
  DISPID_IHTMLDOCUMENT3_CREATEDOCUMENTFRAGMENT                  = DISPID_OMDOCUMENT+76; 
  DISPID_IHTMLDOCUMENT3_PARENTDOCUMENT                          = DISPID_OMDOCUMENT+78; 
  DISPID_IHTMLDOCUMENT3_ENABLEDOWNLOAD                          = DISPID_OMDOCUMENT+79; 
  DISPID_IHTMLDOCUMENT3_BASEURL                                 = DISPID_OMDOCUMENT+80; 
  DISPID_IHTMLDOCUMENT3_CHILDNODES                              = DISPID_ELEMENT+49; 
  DISPID_IHTMLDOCUMENT3_INHERITSTYLESHEETS                      = DISPID_OMDOCUMENT+82; 
  DISPID_IHTMLDOCUMENT3_ONBEFOREEDITFOCUS                       = DISPID_EVPROP_ONBEFOREEDITFOCUS; 
  DISPID_IHTMLDOCUMENT3_GETELEMENTSBYNAME                       = DISPID_OMDOCUMENT+86; 
  DISPID_IHTMLDOCUMENT3_GETELEMENTBYID                          = DISPID_OMDOCUMENT+88; 
  DISPID_IHTMLDOCUMENT3_GETELEMENTSBYTAGNAME                    = DISPID_OMDOCUMENT+87; 

{    DISPIDs for interface IHTMLDocument4 }

  DISPID_IHTMLDOCUMENT4_FOCUS                                   = DISPID_OMDOCUMENT+89; 
  DISPID_IHTMLDOCUMENT4_HASFOCUS                                = DISPID_OMDOCUMENT+90; 
  DISPID_IHTMLDOCUMENT4_ONSELECTIONCHANGE                       = DISPID_EVPROP_ONSELECTIONCHANGE; 
  DISPID_IHTMLDOCUMENT4_NAMESPACES                              = DISPID_OMDOCUMENT+91; 
  DISPID_IHTMLDOCUMENT4_CREATEDOCUMENTFROMURL                   = DISPID_OMDOCUMENT+92; 
  DISPID_IHTMLDOCUMENT4_MEDIA                                   = DISPID_OMDOCUMENT+93; 
  DISPID_IHTMLDOCUMENT4_CREATEEVENTOBJECT                       = DISPID_OMDOCUMENT+94; 
  DISPID_IHTMLDOCUMENT4_FIREEVENT                               = DISPID_OMDOCUMENT+95; 
  DISPID_IHTMLDOCUMENT4_CREATERENDERSTYLE                       = DISPID_OMDOCUMENT+96; 
  DISPID_IHTMLDOCUMENT4_ONCONTROLSELECT                         = DISPID_EVPROP_ONCONTROLSELECT; 
  DISPID_IHTMLDOCUMENT4_URLUNENCODED                            = DISPID_OMDOCUMENT+97; 

{    DISPIDs for interface IHTMLDocument5 }

  DISPID_IHTMLDOCUMENT5_ONMOUSEWHEEL                            = DISPID_EVPROP_ONMOUSEWHEEL; 
  DISPID_IHTMLDOCUMENT5_DOCTYPE                                 = DISPID_OMDOCUMENT+98; 
  DISPID_IHTMLDOCUMENT5_IMPLEMENTATION                          = DISPID_OMDOCUMENT+99; 
  DISPID_IHTMLDOCUMENT5_CREATEATTRIBUTE                         = DISPID_OMDOCUMENT+100; 
  DISPID_IHTMLDOCUMENT5_CREATECOMMENT                           = DISPID_OMDOCUMENT+101; 
  DISPID_IHTMLDOCUMENT5_ONFOCUSIN                               = DISPID_EVPROP_ONFOCUSIN; 
  DISPID_IHTMLDOCUMENT5_ONFOCUSOUT                              = DISPID_EVPROP_ONFOCUSOUT; 
  DISPID_IHTMLDOCUMENT5_ONACTIVATE                              = DISPID_EVPROP_ONACTIVATE; 
  DISPID_IHTMLDOCUMENT5_ONDEACTIVATE                            = DISPID_EVPROP_ONDEACTIVATE; 
  DISPID_IHTMLDOCUMENT5_ONBEFOREACTIVATE                        = DISPID_EVPROP_ONBEFOREACTIVATE; 
  DISPID_IHTMLDOCUMENT5_ONBEFOREDEACTIVATE                      = DISPID_EVPROP_ONBEFOREDEACTIVATE; 
  DISPID_IHTMLDOCUMENT5_COMPATMODE                              = DISPID_OMDOCUMENT+102; 

{    DISPIDs for event set HTMLDocumentEvents2 }

  DISPID_HTMLDOCUMENTEVENTS2_ONHELP                             = Integer(DISPID_EVMETH_ONHELP);
  DISPID_HTMLDOCUMENTEVENTS2_ONCLICK                            = Integer(DISPID_EVMETH_ONCLICK);
  DISPID_HTMLDOCUMENTEVENTS2_ONDBLCLICK                         = Integer(DISPID_EVMETH_ONDBLCLICK);
  DISPID_HTMLDOCUMENTEVENTS2_ONKEYDOWN                          = Integer(DISPID_EVMETH_ONKEYDOWN);
  DISPID_HTMLDOCUMENTEVENTS2_ONKEYUP                            = Integer(DISPID_EVMETH_ONKEYUP);
  DISPID_HTMLDOCUMENTEVENTS2_ONKEYPRESS                         = Integer(DISPID_EVMETH_ONKEYPRESS);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEDOWN                        = Integer(DISPID_EVMETH_ONMOUSEDOWN);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEMOVE                        = Integer(DISPID_EVMETH_ONMOUSEMOVE);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEUP                          = Integer(DISPID_EVMETH_ONMOUSEUP);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOUT                         = Integer(DISPID_EVMETH_ONMOUSEOUT);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEOVER                        = Integer(DISPID_EVMETH_ONMOUSEOVER);
  DISPID_HTMLDOCUMENTEVENTS2_ONREADYSTATECHANGE                 = Integer(DISPID_EVMETH_ONREADYSTATECHANGE);
  DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREUPDATE                     = Integer(DISPID_EVMETH_ONBEFOREUPDATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONAFTERUPDATE                      = Integer(DISPID_EVMETH_ONAFTERUPDATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONROWEXIT                          = Integer(DISPID_EVMETH_ONROWEXIT);
  DISPID_HTMLDOCUMENTEVENTS2_ONROWENTER                         = Integer(DISPID_EVMETH_ONROWENTER);
  DISPID_HTMLDOCUMENTEVENTS2_ONDRAGSTART                        = Integer(DISPID_EVMETH_ONDRAGSTART);
  DISPID_HTMLDOCUMENTEVENTS2_ONSELECTSTART                      = Integer(DISPID_EVMETH_ONSELECTSTART);
  DISPID_HTMLDOCUMENTEVENTS2_ONERRORUPDATE                      = Integer(DISPID_EVMETH_ONERRORUPDATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONCONTEXTMENU                      = Integer(DISPID_EVMETH_ONCONTEXTMENU);
  DISPID_HTMLDOCUMENTEVENTS2_ONSTOP                             = Integer(DISPID_EVMETH_ONSTOP);
  DISPID_HTMLDOCUMENTEVENTS2_ONROWSDELETE                       = Integer(DISPID_EVMETH_ONROWSDELETE);
  DISPID_HTMLDOCUMENTEVENTS2_ONROWSINSERTED                     = Integer(DISPID_EVMETH_ONROWSINSERTED);
  DISPID_HTMLDOCUMENTEVENTS2_ONCELLCHANGE                       = Integer(DISPID_EVMETH_ONCELLCHANGE);
  DISPID_HTMLDOCUMENTEVENTS2_ONPROPERTYCHANGE                   = Integer(DISPID_EVMETH_ONPROPERTYCHANGE);
  DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCHANGED                   = Integer(DISPID_EVMETH_ONDATASETCHANGED);
  DISPID_HTMLDOCUMENTEVENTS2_ONDATAAVAILABLE                    = Integer(DISPID_EVMETH_ONDATAAVAILABLE);
  DISPID_HTMLDOCUMENTEVENTS2_ONDATASETCOMPLETE                  = Integer(DISPID_EVMETH_ONDATASETCOMPLETE);
  DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREEDITFOCUS                  = Integer(DISPID_EVMETH_ONBEFOREEDITFOCUS);
  DISPID_HTMLDOCUMENTEVENTS2_ONSELECTIONCHANGE                  = Integer(DISPID_EVMETH_ONSELECTIONCHANGE);
  DISPID_HTMLDOCUMENTEVENTS2_ONCONTROLSELECT                    = Integer(DISPID_EVMETH_ONCONTROLSELECT);
  DISPID_HTMLDOCUMENTEVENTS2_ONMOUSEWHEEL                       = Integer(DISPID_EVMETH_ONMOUSEWHEEL);
  DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSIN                          = Integer(DISPID_EVMETH_ONFOCUSIN);
  DISPID_HTMLDOCUMENTEVENTS2_ONFOCUSOUT                         = Integer(DISPID_EVMETH_ONFOCUSOUT);
  DISPID_HTMLDOCUMENTEVENTS2_ONACTIVATE                         = Integer(DISPID_EVMETH_ONACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONDEACTIVATE                       = Integer(DISPID_EVMETH_ONDEACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREACTIVATE                   = Integer(DISPID_EVMETH_ONBEFOREACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS2_ONBEFOREDEACTIVATE                 = Integer(DISPID_EVMETH_ONBEFOREDEACTIVATE);

{    DISPIDs for event set HTMLDocumentEvents }

  DISPID_HTMLDOCUMENTEVENTS_ONHELP                              = Integer(DISPID_EVMETH_ONHELP);
  DISPID_HTMLDOCUMENTEVENTS_ONCLICK                             = Integer(DISPID_EVMETH_ONCLICK);
  DISPID_HTMLDOCUMENTEVENTS_ONDBLCLICK                          = Integer(DISPID_EVMETH_ONDBLCLICK);
  DISPID_HTMLDOCUMENTEVENTS_ONKEYDOWN                           = Integer(DISPID_EVMETH_ONKEYDOWN);
  DISPID_HTMLDOCUMENTEVENTS_ONKEYUP                             = Integer(DISPID_EVMETH_ONKEYUP);
  DISPID_HTMLDOCUMENTEVENTS_ONKEYPRESS                          = Integer(DISPID_EVMETH_ONKEYPRESS);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEDOWN                         = Integer(DISPID_EVMETH_ONMOUSEDOWN);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEMOVE                         = Integer(DISPID_EVMETH_ONMOUSEMOVE);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEUP                           = Integer(DISPID_EVMETH_ONMOUSEUP);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEOUT                          = Integer(DISPID_EVMETH_ONMOUSEOUT);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEOVER                         = Integer(DISPID_EVMETH_ONMOUSEOVER);
  DISPID_HTMLDOCUMENTEVENTS_ONREADYSTATECHANGE                  = Integer(DISPID_EVMETH_ONREADYSTATECHANGE);
  DISPID_HTMLDOCUMENTEVENTS_ONBEFOREUPDATE                      = Integer(DISPID_EVMETH_ONBEFOREUPDATE);
  DISPID_HTMLDOCUMENTEVENTS_ONAFTERUPDATE                       = Integer(DISPID_EVMETH_ONAFTERUPDATE);
  DISPID_HTMLDOCUMENTEVENTS_ONROWEXIT                           = Integer(DISPID_EVMETH_ONROWEXIT);
  DISPID_HTMLDOCUMENTEVENTS_ONROWENTER                          = Integer(DISPID_EVMETH_ONROWENTER);
  DISPID_HTMLDOCUMENTEVENTS_ONDRAGSTART                         = Integer(DISPID_EVMETH_ONDRAGSTART);
  DISPID_HTMLDOCUMENTEVENTS_ONSELECTSTART                       = Integer(DISPID_EVMETH_ONSELECTSTART);
  DISPID_HTMLDOCUMENTEVENTS_ONERRORUPDATE                       = Integer(DISPID_EVMETH_ONERRORUPDATE);
  DISPID_HTMLDOCUMENTEVENTS_ONCONTEXTMENU                       = Integer(DISPID_EVMETH_ONCONTEXTMENU);
  DISPID_HTMLDOCUMENTEVENTS_ONSTOP                              = Integer(DISPID_EVMETH_ONSTOP);
  DISPID_HTMLDOCUMENTEVENTS_ONROWSDELETE                        = Integer(DISPID_EVMETH_ONROWSDELETE);
  DISPID_HTMLDOCUMENTEVENTS_ONROWSINSERTED                      = Integer(DISPID_EVMETH_ONROWSINSERTED);
  DISPID_HTMLDOCUMENTEVENTS_ONCELLCHANGE                        = Integer(DISPID_EVMETH_ONCELLCHANGE);
  DISPID_HTMLDOCUMENTEVENTS_ONPROPERTYCHANGE                    = Integer(DISPID_EVMETH_ONPROPERTYCHANGE);
  DISPID_HTMLDOCUMENTEVENTS_ONDATASETCHANGED                    = Integer(DISPID_EVMETH_ONDATASETCHANGED);
  DISPID_HTMLDOCUMENTEVENTS_ONDATAAVAILABLE                     = Integer(DISPID_EVMETH_ONDATAAVAILABLE);
  DISPID_HTMLDOCUMENTEVENTS_ONDATASETCOMPLETE                   = Integer(DISPID_EVMETH_ONDATASETCOMPLETE);
  DISPID_HTMLDOCUMENTEVENTS_ONBEFOREEDITFOCUS                   = Integer(DISPID_EVMETH_ONBEFOREEDITFOCUS);
  DISPID_HTMLDOCUMENTEVENTS_ONSELECTIONCHANGE                   = Integer(DISPID_EVMETH_ONSELECTIONCHANGE);
  DISPID_HTMLDOCUMENTEVENTS_ONCONTROLSELECT                     = Integer(DISPID_EVMETH_ONCONTROLSELECT);
  DISPID_HTMLDOCUMENTEVENTS_ONMOUSEWHEEL                        = Integer(DISPID_EVMETH_ONMOUSEWHEEL);
  DISPID_HTMLDOCUMENTEVENTS_ONFOCUSIN                           = Integer(DISPID_EVMETH_ONFOCUSIN);
  DISPID_HTMLDOCUMENTEVENTS_ONFOCUSOUT                          = Integer(DISPID_EVMETH_ONFOCUSOUT);
  DISPID_HTMLDOCUMENTEVENTS_ONACTIVATE                          = Integer(DISPID_EVMETH_ONACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS_ONDEACTIVATE                        = Integer(DISPID_EVMETH_ONDEACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS_ONBEFOREACTIVATE                    = Integer(DISPID_EVMETH_ONBEFOREACTIVATE);
  DISPID_HTMLDOCUMENTEVENTS_ONBEFOREDEACTIVATE                  = Integer(DISPID_EVMETH_ONBEFOREDEACTIVATE);

{    DISPIDs for interface IWebBridge }

  DISPID_IWEBBRIDGE_URL                                         = 1; 
  DISPID_IWEBBRIDGE_SCROLLBAR                                   = 2; 
  DISPID_IWEBBRIDGE_EMBED                                       = 3; 
  DISPID_IWEBBRIDGE_EVENT                                       = DISPID_IHTMLWINDOW2_EVENT; 
  DISPID_IWEBBRIDGE_READYSTATE                                  = DISPID_READYSTATE; 
  DISPID_IWEBBRIDGE_ABOUTBOX                                    = DISPID_ABOUTBOX; 

{    DISPIDs for interface IWBScriptControl }

  DISPID_IWBSCRIPTCONTROL_RAISEEVENT                            = 1; 
  DISPID_IWBSCRIPTCONTROL_BUBBLEEVENT                           = 2; 
  DISPID_IWBSCRIPTCONTROL_SETCONTEXTMENU                        = 3; 
  DISPID_IWBSCRIPTCONTROL_SELECTABLECONTENT                     = 4; 
  DISPID_IWBSCRIPTCONTROL_FROZEN                                = 5; 
  DISPID_IWBSCRIPTCONTROL_SCROLLBAR                             = 7; 
  DISPID_IWBSCRIPTCONTROL_VERSION                               = 8; 
  DISPID_IWBSCRIPTCONTROL_VISIBILITY                            = 9; 
  DISPID_IWBSCRIPTCONTROL_ONVISIBILITYCHANGE                    = 10; 

{    DISPIDs for event set DWebBridgeEvents }

  DISPID_DWEBBRIDGEEVENTS_ONSCRIPTLETEVENT                      = 1; 
  DISPID_DWEBBRIDGEEVENTS_ONREADYSTATECHANGE                    = DISPID_HTMLDOCUMENTEVENTS_ONREADYSTATECHANGE; 
  DISPID_DWEBBRIDGEEVENTS_ONCLICK                               = DISPID_HTMLDOCUMENTEVENTS_ONCLICK; 
  DISPID_DWEBBRIDGEEVENTS_ONDBLCLICK                            = DISPID_HTMLDOCUMENTEVENTS_ONDBLCLICK; 
  DISPID_DWEBBRIDGEEVENTS_ONKEYDOWN                             = DISPID_HTMLDOCUMENTEVENTS_ONKEYDOWN; 
  DISPID_DWEBBRIDGEEVENTS_ONKEYUP                               = DISPID_HTMLDOCUMENTEVENTS_ONKEYUP; 
  DISPID_DWEBBRIDGEEVENTS_ONKEYPRESS                            = DISPID_HTMLDOCUMENTEVENTS_ONKEYPRESS; 
  DISPID_DWEBBRIDGEEVENTS_ONMOUSEDOWN                           = DISPID_HTMLDOCUMENTEVENTS_ONMOUSEDOWN; 
  DISPID_DWEBBRIDGEEVENTS_ONMOUSEMOVE                           = DISPID_HTMLDOCUMENTEVENTS_ONMOUSEMOVE; 
  DISPID_DWEBBRIDGEEVENTS_ONMOUSEUP                             = DISPID_HTMLDOCUMENTEVENTS_ONMOUSEUP; 

{    DISPIDs for interface IHTMLEmbedElement }

  DISPID_IHTMLEMBEDELEMENT_HIDDEN                               = DISPID_OBJECT+10; 
  DISPID_IHTMLEMBEDELEMENT_PALETTE                              = DISPID_OBJECT+4; 
  DISPID_IHTMLEMBEDELEMENT_PLUGINSPAGE                          = DISPID_OBJECT+5; 
  DISPID_IHTMLEMBEDELEMENT_SRC                                  = DISPID_OBJECT+6; 
  DISPID_IHTMLEMBEDELEMENT_UNITS                                = DISPID_OBJECT+8; 
  DISPID_IHTMLEMBEDELEMENT_NAME                                 = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLEMBEDELEMENT_WIDTH                                = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLEMBEDELEMENT_HEIGHT                               = STDPROPID_XOBJ_HEIGHT; 

{    DISPIDs for interface IHTMLAreasCollection }

  DISPID_IHTMLAREASCOLLECTION_LENGTH                            = DISPID_COLLECTION; 
  DISPID_IHTMLAREASCOLLECTION__NEWENUM                          = DISPID_NEWENUM; 
  DISPID_IHTMLAREASCOLLECTION_ITEM                              = DISPID_VALUE; 
  DISPID_IHTMLAREASCOLLECTION_TAGS                              = DISPID_COLLECTION+2; 
  DISPID_IHTMLAREASCOLLECTION_ADD                               = DISPID_COLLECTION+3; 
  DISPID_IHTMLAREASCOLLECTION_REMOVE                            = DISPID_COLLECTION+4; 

{    DISPIDs for interface IHTMLAreasCollection2 }

  DISPID_IHTMLAREASCOLLECTION2_URNS                             = DISPID_COLLECTION+5; 

{    DISPIDs for interface IHTMLAreasCollection3 }

  DISPID_IHTMLAREASCOLLECTION3_NAMEDITEM                        = DISPID_COLLECTION+6; 

{    DISPIDs for interface IHTMLMapElement }

  DISPID_IHTMLMAPELEMENT_AREAS                                  = DISPID_MAP+2; 
  DISPID_IHTMLMAPELEMENT_NAME                                   = STDPROPID_XOBJ_NAME; 

{    DISPIDs for interface IHTMLAreaElement }

  DISPID_IHTMLAREAELEMENT_SHAPE                                 = DISPID_AREA+1; 
  DISPID_IHTMLAREAELEMENT_COORDS                                = DISPID_AREA+2; 
  DISPID_IHTMLAREAELEMENT_HREF                                  = DISPID_VALUE; 
  DISPID_IHTMLAREAELEMENT_TARGET                                = DISPID_AREA+4; 
  DISPID_IHTMLAREAELEMENT_ALT                                   = DISPID_AREA+5; 
  DISPID_IHTMLAREAELEMENT_NOHREF                                = DISPID_AREA+6; 
  DISPID_IHTMLAREAELEMENT_HOST                                  = DISPID_AREA+7; 
  DISPID_IHTMLAREAELEMENT_HOSTNAME                              = DISPID_AREA+8; 
  DISPID_IHTMLAREAELEMENT_PATHNAME                              = DISPID_AREA+9; 
  DISPID_IHTMLAREAELEMENT_PORT                                  = DISPID_AREA+10; 
  DISPID_IHTMLAREAELEMENT_PROTOCOL                              = DISPID_AREA+11; 
  DISPID_IHTMLAREAELEMENT_SEARCH                                = DISPID_AREA+12; 
  DISPID_IHTMLAREAELEMENT_HASH                                  = DISPID_AREA+13; 
  DISPID_IHTMLAREAELEMENT_ONBLUR                                = DISPID_EVPROP_ONBLUR; 
  DISPID_IHTMLAREAELEMENT_ONFOCUS                               = DISPID_EVPROP_ONFOCUS; 
  DISPID_IHTMLAREAELEMENT_TABINDEX                              = STDPROPID_XOBJ_TABINDEX; 
  DISPID_IHTMLAREAELEMENT_FOCUS                                 = DISPID_SITE+0; 
  DISPID_IHTMLAREAELEMENT_BLUR                                  = DISPID_SITE+2; 

{    DISPIDs for interface IHTMLTableCaption }

  DISPID_IHTMLTABLECAPTION_ALIGN                                = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLTABLECAPTION_VALIGN                               = DISPID_A_TABLEVALIGN; 

{    DISPIDs for interface IHTMLCommentElement }

  DISPID_IHTMLCOMMENTELEMENT_TEXT                               = DISPID_COMMENTPDL+1; 
  DISPID_IHTMLCOMMENTELEMENT_ATOMIC                             = DISPID_COMMENTPDL+2; 

{    DISPIDs for interface IHTMLCommentElement2 }

  DISPID_IHTMLCOMMENTELEMENT2_DATA                              = DISPID_COMMENTPDL+3; 
  DISPID_IHTMLCOMMENTELEMENT2_LENGTH                            = DISPID_COMMENTPDL+4; 
  DISPID_IHTMLCOMMENTELEMENT2_SUBSTRINGDATA                     = DISPID_COMMENTPDL+5; 
  DISPID_IHTMLCOMMENTELEMENT2_APPENDDATA                        = DISPID_COMMENTPDL+6; 
  DISPID_IHTMLCOMMENTELEMENT2_INSERTDATA                        = DISPID_COMMENTPDL+7; 
  DISPID_IHTMLCOMMENTELEMENT2_DELETEDATA                        = DISPID_COMMENTPDL+8; 
  DISPID_IHTMLCOMMENTELEMENT2_REPLACEDATA                       = DISPID_COMMENTPDL+9; 

{    DISPIDs for interface IHTMLPhraseElement2 }

  DISPID_IHTMLPHRASEELEMENT2_CITE                               = DISPID_PHRASE+1; 
  DISPID_IHTMLPHRASEELEMENT2_DATETIME                           = DISPID_PHRASE+2; 

{    DISPIDs for interface IHTMLTable }

  DISPID_IHTMLTABLE_COLS                                        = DISPID_TABLE+1; 
  DISPID_IHTMLTABLE_BORDER                                      = DISPID_TABLE+2; 
  DISPID_IHTMLTABLE_FRAME                                       = DISPID_TABLE+4; 
  DISPID_IHTMLTABLE_RULES                                       = DISPID_TABLE+3; 
  DISPID_IHTMLTABLE_CELLSPACING                                 = DISPID_TABLE+5; 
  DISPID_IHTMLTABLE_CELLPADDING                                 = DISPID_TABLE+6; 
  DISPID_IHTMLTABLE_BACKGROUND                                  = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLTABLE_BGCOLOR                                     = DISPID_BACKCOLOR; 
  DISPID_IHTMLTABLE_BORDERCOLOR                                 = DISPID_A_TABLEBORDERCOLOR; 
  DISPID_IHTMLTABLE_BORDERCOLORLIGHT                            = DISPID_A_TABLEBORDERCOLORLIGHT; 
  DISPID_IHTMLTABLE_BORDERCOLORDARK                             = DISPID_A_TABLEBORDERCOLORDARK; 
  DISPID_IHTMLTABLE_ALIGN                                       = STDPROPID_XOBJ_CONTROLALIGN; 
  DISPID_IHTMLTABLE_REFRESH                                     = DISPID_TABLE+15; 
  DISPID_IHTMLTABLE_ROWS                                        = DISPID_TABLE+16; 
  DISPID_IHTMLTABLE_WIDTH                                       = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLTABLE_HEIGHT                                      = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLTABLE_DATAPAGESIZE                                = DISPID_TABLE+17; 
  DISPID_IHTMLTABLE_NEXTPAGE                                    = DISPID_TABLE+18; 
  DISPID_IHTMLTABLE_PREVIOUSPAGE                                = DISPID_TABLE+19; 
  DISPID_IHTMLTABLE_THEAD                                       = DISPID_TABLE+20; 
  DISPID_IHTMLTABLE_TFOOT                                       = DISPID_TABLE+21; 
  DISPID_IHTMLTABLE_TBODIES                                     = DISPID_TABLE+24; 
  DISPID_IHTMLTABLE_CAPTION                                     = DISPID_TABLE+25; 
  DISPID_IHTMLTABLE_CREATETHEAD                                 = DISPID_TABLE+26; 
  DISPID_IHTMLTABLE_DELETETHEAD                                 = DISPID_TABLE+27; 
  DISPID_IHTMLTABLE_CREATETFOOT                                 = DISPID_TABLE+28; 
  DISPID_IHTMLTABLE_DELETETFOOT                                 = DISPID_TABLE+29; 
  DISPID_IHTMLTABLE_CREATECAPTION                               = DISPID_TABLE+30; 
  DISPID_IHTMLTABLE_DELETECAPTION                               = DISPID_TABLE+31; 
  DISPID_IHTMLTABLE_INSERTROW                                   = DISPID_TABLE+32; 
  DISPID_IHTMLTABLE_DELETEROW                                   = DISPID_TABLE+33; 
  DISPID_IHTMLTABLE_READYSTATE                                  = DISPID_A_READYSTATE; 
  DISPID_IHTMLTABLE_ONREADYSTATECHANGE                          = DISPID_EVPROP_ONREADYSTATECHANGE; 

{    DISPIDs for interface IHTMLTable2 }

  DISPID_IHTMLTABLE2_FIRSTPAGE                                  = DISPID_TABLE+35; 
  DISPID_IHTMLTABLE2_LASTPAGE                                   = DISPID_TABLE+36; 
  DISPID_IHTMLTABLE2_CELLS                                      = DISPID_TABLE+37; 
  DISPID_IHTMLTABLE2_MOVEROW                                    = DISPID_TABLE+38; 

{    DISPIDs for interface IHTMLTable3 }

  DISPID_IHTMLTABLE3_SUMMARY                                    = DISPID_TABLE+39; 

{    DISPIDs for interface IHTMLTableCol }

  DISPID_IHTMLTABLECOL_SPAN                                     = DISPID_TABLECOL+1; 
  DISPID_IHTMLTABLECOL_WIDTH                                    = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLTABLECOL_ALIGN                                    = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLTABLECOL_VALIGN                                   = DISPID_A_TABLEVALIGN; 

{    DISPIDs for interface IHTMLTableCol2 }

  DISPID_IHTMLTABLECOL2_CH                                      = DISPID_TABLECOL+2; 
  DISPID_IHTMLTABLECOL2_CHOFF                                   = DISPID_TABLECOL+3; 

{    DISPIDs for interface IHTMLTableSection }

  DISPID_IHTMLTABLESECTION_ALIGN                                = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLTABLESECTION_VALIGN                               = DISPID_A_TABLEVALIGN; 
  DISPID_IHTMLTABLESECTION_BGCOLOR                              = DISPID_BACKCOLOR; 
  DISPID_IHTMLTABLESECTION_ROWS                                 = DISPID_TABLESECTION; 
  DISPID_IHTMLTABLESECTION_INSERTROW                            = DISPID_TABLESECTION+1; 
  DISPID_IHTMLTABLESECTION_DELETEROW                            = DISPID_TABLESECTION+2; 

{    DISPIDs for interface IHTMLTableSection2 }

  DISPID_IHTMLTABLESECTION2_MOVEROW                             = DISPID_TABLESECTION+3; 

{    DISPIDs for interface IHTMLTableSection3 }

  DISPID_IHTMLTABLESECTION3_CH                                  = DISPID_TABLESECTION+4; 
  DISPID_IHTMLTABLESECTION3_CHOFF                               = DISPID_TABLESECTION+5; 

{    DISPIDs for interface IHTMLTableRow }

  DISPID_IHTMLTABLEROW_ALIGN                                    = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLTABLEROW_VALIGN                                   = DISPID_A_TABLEVALIGN; 
  DISPID_IHTMLTABLEROW_BGCOLOR                                  = DISPID_BACKCOLOR; 
  DISPID_IHTMLTABLEROW_BORDERCOLOR                              = DISPID_A_TABLEBORDERCOLOR; 
  DISPID_IHTMLTABLEROW_BORDERCOLORLIGHT                         = DISPID_A_TABLEBORDERCOLORLIGHT; 
  DISPID_IHTMLTABLEROW_BORDERCOLORDARK                          = DISPID_A_TABLEBORDERCOLORDARK; 
  DISPID_IHTMLTABLEROW_ROWINDEX                                 = DISPID_TABLEROW; 
  DISPID_IHTMLTABLEROW_SECTIONROWINDEX                          = DISPID_TABLEROW+1; 
  DISPID_IHTMLTABLEROW_CELLS                                    = DISPID_TABLEROW+2; 
  DISPID_IHTMLTABLEROW_INSERTCELL                               = DISPID_TABLEROW+3; 
  DISPID_IHTMLTABLEROW_DELETECELL                               = DISPID_TABLEROW+4; 

{    DISPIDs for interface IHTMLTableRow2 }

  DISPID_IHTMLTABLEROW2_HEIGHT                                  = STDPROPID_XOBJ_HEIGHT; 

{    DISPIDs for interface IHTMLTableRow3 }

  DISPID_IHTMLTABLEROW3_CH                                      = DISPID_TABLEROW+9; 
  DISPID_IHTMLTABLEROW3_CHOFF                                   = DISPID_TABLEROW+10; 

{    DISPIDs for interface IHTMLTableRowMetrics }

  DISPID_IHTMLTABLEROWMETRICS_CLIENTHEIGHT                      = DISPID_SITE+19; 
  DISPID_IHTMLTABLEROWMETRICS_CLIENTWIDTH                       = DISPID_SITE+20; 
  DISPID_IHTMLTABLEROWMETRICS_CLIENTTOP                         = DISPID_SITE+21; 
  DISPID_IHTMLTABLEROWMETRICS_CLIENTLEFT                        = DISPID_SITE+22; 

{    DISPIDs for interface IHTMLTableCell }

  DISPID_IHTMLTABLECELL_ROWSPAN                                 = DISPID_TABLECELL+1; 
  DISPID_IHTMLTABLECELL_COLSPAN                                 = DISPID_TABLECELL+2; 
  DISPID_IHTMLTABLECELL_ALIGN                                   = STDPROPID_XOBJ_BLOCKALIGN; 
  DISPID_IHTMLTABLECELL_VALIGN                                  = DISPID_A_TABLEVALIGN; 
  DISPID_IHTMLTABLECELL_BGCOLOR                                 = DISPID_BACKCOLOR; 
  DISPID_IHTMLTABLECELL_NOWRAP                                  = DISPID_A_NOWRAP; 
  DISPID_IHTMLTABLECELL_BACKGROUND                              = DISPID_A_BACKGROUNDIMAGE; 
  DISPID_IHTMLTABLECELL_BORDERCOLOR                             = DISPID_A_TABLEBORDERCOLOR; 
  DISPID_IHTMLTABLECELL_BORDERCOLORLIGHT                        = DISPID_A_TABLEBORDERCOLORLIGHT; 
  DISPID_IHTMLTABLECELL_BORDERCOLORDARK                         = DISPID_A_TABLEBORDERCOLORDARK; 
  DISPID_IHTMLTABLECELL_WIDTH                                   = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLTABLECELL_HEIGHT                                  = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLTABLECELL_CELLINDEX                               = DISPID_TABLECELL+3; 

{    DISPIDs for interface IHTMLTableCell2 }

  DISPID_IHTMLTABLECELL2_ABBR                                   = DISPID_TABLECELL+4; 
  DISPID_IHTMLTABLECELL2_AXIS                                   = DISPID_TABLECELL+5; 
  DISPID_IHTMLTABLECELL2_CH                                     = DISPID_TABLECELL+6; 
  DISPID_IHTMLTABLECELL2_CHOFF                                  = DISPID_TABLECELL+7; 
  DISPID_IHTMLTABLECELL2_HEADERS                                = DISPID_TABLECELL+8; 
  DISPID_IHTMLTABLECELL2_SCOPE                                  = DISPID_TABLECELL+9; 

{    DISPIDs for interface IHTMLScriptElement }

  DISPID_IHTMLSCRIPTELEMENT_SRC                                 = DISPID_SCRIPT+1; 
  DISPID_IHTMLSCRIPTELEMENT_HTMLFOR                             = DISPID_SCRIPT+4; 
  DISPID_IHTMLSCRIPTELEMENT_EVENT                               = DISPID_SCRIPT+5; 
  DISPID_IHTMLSCRIPTELEMENT_TEXT                                = DISPID_SCRIPT+6; 
  DISPID_IHTMLSCRIPTELEMENT_DEFER                               = DISPID_SCRIPT+7; 
  DISPID_IHTMLSCRIPTELEMENT_READYSTATE                          = DISPID_A_READYSTATE; 
  DISPID_IHTMLSCRIPTELEMENT_ONERROR                             = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLSCRIPTELEMENT_TYPE                                = DISPID_SCRIPT+9; 

{    DISPIDs for interface IHTMLScriptElement2 }

  DISPID_IHTMLSCRIPTELEMENT2_CHARSET                            = DISPID_SCRIPT+10; 

{    DISPIDs for event set HTMLScriptEvents2 }

  DISPID_HTMLSCRIPTEVENTS2_ONERROR                              = DISPID_EVMETH_ONERROR; 

{    DISPIDs for event set HTMLScriptEvents }

//!!  DISPID_HTMLSCRIPTEVENTS_ONREADYSTATECHANGE                    = DISPID_EVMETH_ONREADYSTATECHANGE;
  DISPID_HTMLSCRIPTEVENTS_ONERROR                               = DISPID_EVMETH_ONERROR; 

{    DISPIDs for interface IHTMLObjectElement }

  DISPID_IHTMLOBJECTELEMENT_OBJECT                              = DISPID_OBJECT+1; 
  DISPID_IHTMLOBJECTELEMENT_CLASSID                             = DISPID_OBJECT+2; 
  DISPID_IHTMLOBJECTELEMENT_DATA                                = DISPID_OBJECT+3; 
  DISPID_IHTMLOBJECTELEMENT_RECORDSET                           = DISPID_OBJECT+5; 
  DISPID_IHTMLOBJECTELEMENT_ALIGN                               = STDPROPID_XOBJ_CONTROLALIGN; 
  DISPID_IHTMLOBJECTELEMENT_NAME                                = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLOBJECTELEMENT_CODEBASE                            = DISPID_OBJECT+6; 
  DISPID_IHTMLOBJECTELEMENT_CODETYPE                            = DISPID_OBJECT+7; 
  DISPID_IHTMLOBJECTELEMENT_CODE                                = DISPID_OBJECT+8; 
  DISPID_IHTMLOBJECTELEMENT_BASEHREF                            = STDPROPID_XOBJ_BASEHREF; 
  DISPID_IHTMLOBJECTELEMENT_TYPE                                = DISPID_OBJECT+9; 
  DISPID_IHTMLOBJECTELEMENT_FORM                                = DISPID_SITE+4; 
  DISPID_IHTMLOBJECTELEMENT_WIDTH                               = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLOBJECTELEMENT_HEIGHT                              = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLOBJECTELEMENT_READYSTATE                          = DISPID_OBJECT+10; 
  DISPID_IHTMLOBJECTELEMENT_ONREADYSTATECHANGE                  = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLOBJECTELEMENT_ONERROR                             = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLOBJECTELEMENT_ALTHTML                             = DISPID_OBJECT+11; 
  DISPID_IHTMLOBJECTELEMENT_VSPACE                              = DISPID_OBJECT+12; 
  DISPID_IHTMLOBJECTELEMENT_HSPACE                              = DISPID_OBJECT+13; 

{    DISPIDs for interface IHTMLObjectElement2 }

  DISPID_IHTMLOBJECTELEMENT2_NAMEDRECORDSET                     = DISPID_OBJECT+14; 
  DISPID_IHTMLOBJECTELEMENT2_CLASSID                            = DISPID_OBJECT+2; 
  DISPID_IHTMLOBJECTELEMENT2_DATA                               = DISPID_OBJECT+3; 

{    DISPIDs for interface IHTMLObjectElement3 }

  DISPID_IHTMLOBJECTELEMENT3_ARCHIVE                            = DISPID_OBJECT+15; 
  DISPID_IHTMLOBJECTELEMENT3_ALT                                = DISPID_OBJECT+16; 
  DISPID_IHTMLOBJECTELEMENT3_DECLARE                            = DISPID_OBJECT+17; 
  DISPID_IHTMLOBJECTELEMENT3_STANDBY                            = DISPID_OBJECT+18; 
  DISPID_IHTMLOBJECTELEMENT3_BORDER                             = DISPID_OBJECT+19; 
  DISPID_IHTMLOBJECTELEMENT3_USEMAP                             = DISPID_OBJECT+20; 

{    DISPIDs for interface IHTMLParamElement }

  DISPID_IHTMLPARAMELEMENT_NAME                                 = DISPID_PARAM+1; 
  DISPID_IHTMLPARAMELEMENT_VALUE                                = DISPID_PARAM+2; 
  DISPID_IHTMLPARAMELEMENT_TYPE                                 = DISPID_PARAM+3; 
  DISPID_IHTMLPARAMELEMENT_VALUETYPE                            = DISPID_PARAM+4; 

{    DISPIDs for event set HTMLObjectElementEvents2 }

  DISPID_HTMLOBJECTELEMENTEVENTS2_ONBEFOREUPDATE                = DISPID_EVMETH_ONBEFOREUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONAFTERUPDATE                 = DISPID_EVMETH_ONAFTERUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONERRORUPDATE                 = DISPID_EVMETH_ONERRORUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWEXIT                     = DISPID_EVMETH_ONROWEXIT; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWENTER                    = DISPID_EVMETH_ONROWENTER; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATASETCHANGED              = DISPID_EVMETH_ONDATASETCHANGED; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATAAVAILABLE               = DISPID_EVMETH_ONDATAAVAILABLE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONDATASETCOMPLETE             = DISPID_EVMETH_ONDATASETCOMPLETE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONERROR                       = DISPID_XOBJ_BASE+19; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWSDELETE                  = DISPID_EVMETH_ONROWSDELETE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONROWSINSERTED                = DISPID_EVMETH_ONROWSINSERTED; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONCELLCHANGE                  = DISPID_EVMETH_ONCELLCHANGE; 
  DISPID_HTMLOBJECTELEMENTEVENTS2_ONREADYSTATECHANGE            = DISPID_XOBJ_BASE+20; 

{    DISPIDs for event set HTMLObjectElementEvents }

  DISPID_HTMLOBJECTELEMENTEVENTS_ONBEFOREUPDATE                 = DISPID_EVMETH_ONBEFOREUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONAFTERUPDATE                  = DISPID_EVMETH_ONAFTERUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONERRORUPDATE                  = DISPID_EVMETH_ONERRORUPDATE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONROWEXIT                      = DISPID_EVMETH_ONROWEXIT; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONROWENTER                     = DISPID_EVMETH_ONROWENTER; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONDATASETCHANGED               = DISPID_EVMETH_ONDATASETCHANGED; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONDATAAVAILABLE                = DISPID_EVMETH_ONDATAAVAILABLE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONDATASETCOMPLETE              = DISPID_EVMETH_ONDATASETCOMPLETE; 
//!!  DISPID_HTMLOBJECTELEMENTEVENTS_ONREADYSTATECHANGE             = DISPID_XOBJ_BASE+18; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONERROR                        = DISPID_XOBJ_BASE+19; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONROWSDELETE                   = DISPID_EVMETH_ONROWSDELETE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONROWSINSERTED                 = DISPID_EVMETH_ONROWSINSERTED; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONCELLCHANGE                   = DISPID_EVMETH_ONCELLCHANGE; 
  DISPID_HTMLOBJECTELEMENTEVENTS_ONREADYSTATECHANGE             = DISPID_XOBJ_BASE+20; 

{    DISPIDs for interface IHTMLFrameBase }

  DISPID_IHTMLFRAMEBASE_SRC                                     = DISPID_FRAMESITE+0; 
  DISPID_IHTMLFRAMEBASE_NAME                                    = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLFRAMEBASE_BORDER                                  = DISPID_FRAMESITE+2; 
  DISPID_IHTMLFRAMEBASE_FRAMEBORDER                             = DISPID_FRAMESITE+3; 
  DISPID_IHTMLFRAMEBASE_FRAMESPACING                            = DISPID_FRAMESITE+4; 
  DISPID_IHTMLFRAMEBASE_MARGINWIDTH                             = DISPID_FRAMESITE+5; 
  DISPID_IHTMLFRAMEBASE_MARGINHEIGHT                            = DISPID_FRAMESITE+6; 
  DISPID_IHTMLFRAMEBASE_NORESIZE                                = DISPID_FRAMESITE+7; 
  DISPID_IHTMLFRAMEBASE_SCROLLING                               = DISPID_FRAMESITE+8; 

{    DISPIDs for interface IHTMLFrameBase2 }

  DISPID_IHTMLFRAMEBASE2_CONTENTWINDOW                          = DISPID_FRAMESITE+9; 
  DISPID_IHTMLFRAMEBASE2_ONLOAD                                 = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLFRAMEBASE2_ONREADYSTATECHANGE                     = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLFRAMEBASE2_READYSTATE                             = DISPID_A_READYSTATE; 
  DISPID_IHTMLFRAMEBASE2_ALLOWTRANSPARENCY                      = DISPID_A_ALLOWTRANSPARENCY; 

{    DISPIDs for interface IHTMLFrameBase3 }

  DISPID_IHTMLFRAMEBASE3_LONGDESC                               = DISPID_FRAMESITE+10; 

{    DISPIDs for event set HTMLFrameSiteEvents2 }

  DISPID_HTMLFRAMESITEEVENTS2_ONLOAD                            = DISPID_EVMETH_ONLOAD; 

{    DISPIDs for event set HTMLFrameSiteEvents }

  DISPID_HTMLFRAMESITEEVENTS_ONLOAD                             = DISPID_EVMETH_ONLOAD; 

{    DISPIDs for interface IHTMLFrameElement }

  DISPID_IHTMLFRAMEELEMENT_BORDERCOLOR                          = DISPID_FRAME+1; 

{    DISPIDs for interface IHTMLFrameElement2 }

  DISPID_IHTMLFRAMEELEMENT2_HEIGHT                              = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLFRAMEELEMENT2_WIDTH                               = STDPROPID_XOBJ_WIDTH; 

{    DISPIDs for interface IHTMLIFrameElement }

//!!  DISPID_IHTMLIFRAMEELEMENT_HEIGHT                              = STDPROPID_XOBJ_HEIGHT; 
//!!  DISPID_IHTMLIFRAMEELEMENT_WIDTH                               = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLIFRAMEELEMENT_VSPACE                              = DISPID_IFRAME+1; 
  DISPID_IHTMLIFRAMEELEMENT_HSPACE                              = DISPID_IFRAME+2; 
  DISPID_IHTMLIFRAMEELEMENT_ALIGN                               = STDPROPID_XOBJ_CONTROLALIGN; 

{    DISPIDs for interface IHTMLIFrameElement2 }

  DISPID_IHTMLIFRAMEELEMENT2_HEIGHT                             = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLIFRAMEELEMENT2_WIDTH                              = STDPROPID_XOBJ_WIDTH; 

{    DISPIDs for interface IHTMLDivPosition }

  DISPID_IHTMLDIVPOSITION_ALIGN                                 = STDPROPID_XOBJ_CONTROLALIGN; 

{    DISPIDs for interface IHTMLFieldSetElement }

  DISPID_IHTMLFIELDSETELEMENT_ALIGN                             = STDPROPID_XOBJ_CONTROLALIGN; 

{    DISPIDs for interface IHTMLFieldSetElement2 }

  DISPID_IHTMLFIELDSETELEMENT2_FORM                             = DISPID_SITE+4; 

{    DISPIDs for interface IHTMLLegendElement }

  DISPID_IHTMLLEGENDELEMENT_ALIGN                               = STDPROPID_XOBJ_CONTROLALIGN; 

{    DISPIDs for interface IHTMLLegendElement2 }

  DISPID_IHTMLLEGENDELEMENT2_FORM                               = DISPID_SITE+4; 

{    DISPIDs for interface IHTMLSpanFlow }

  DISPID_IHTMLSPANFLOW_ALIGN                                    = STDPROPID_XOBJ_CONTROLALIGN; 

{    DISPIDs for interface IHTMLFrameSetElement }

  DISPID_IHTMLFRAMESETELEMENT_ROWS                              = DISPID_FRAMESET; 
  DISPID_IHTMLFRAMESETELEMENT_COLS                              = DISPID_FRAMESET+1; 
  DISPID_IHTMLFRAMESETELEMENT_BORDER                            = DISPID_FRAMESET+2; 
  DISPID_IHTMLFRAMESETELEMENT_BORDERCOLOR                       = DISPID_FRAMESET+3; 
  DISPID_IHTMLFRAMESETELEMENT_FRAMEBORDER                       = DISPID_FRAMESET+4; 
  DISPID_IHTMLFRAMESETELEMENT_FRAMESPACING                      = DISPID_FRAMESET+5; 
  DISPID_IHTMLFRAMESETELEMENT_NAME                              = STDPROPID_XOBJ_NAME; 
  DISPID_IHTMLFRAMESETELEMENT_ONLOAD                            = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLFRAMESETELEMENT_ONUNLOAD                          = DISPID_EVPROP_ONUNLOAD; 
  DISPID_IHTMLFRAMESETELEMENT_ONBEFOREUNLOAD                    = DISPID_EVPROP_ONBEFOREUNLOAD; 

{    DISPIDs for interface IHTMLFrameSetElement2 }

  DISPID_IHTMLFRAMESETELEMENT2_ONBEFOREPRINT                    = DISPID_EVPROP_ONBEFOREPRINT; 
  DISPID_IHTMLFRAMESETELEMENT2_ONAFTERPRINT                     = DISPID_EVPROP_ONAFTERPRINT; 

{    DISPIDs for interface IHTMLBGsound }

  DISPID_IHTMLBGSOUND_SRC                                       = DISPID_BGSOUND+1; 
  DISPID_IHTMLBGSOUND_LOOP                                      = DISPID_BGSOUND+2; 
  DISPID_IHTMLBGSOUND_VOLUME                                    = DISPID_BGSOUND+3; 
  DISPID_IHTMLBGSOUND_BALANCE                                   = DISPID_BGSOUND+4; 

{    DISPIDs for interface IHTMLFontNamesCollection }

  DISPID_IHTMLFONTNAMESCOLLECTION_LENGTH                        = DISPID_OPTIONS_COL+1; 
  DISPID_IHTMLFONTNAMESCOLLECTION__NEWENUM                      = DISPID_NEWENUM; 
  DISPID_IHTMLFONTNAMESCOLLECTION_ITEM                          = DISPID_VALUE; 

{    DISPIDs for interface IHTMLFontSizesCollection }

  DISPID_IHTMLFONTSIZESCOLLECTION_LENGTH                        = DISPID_OPTIONS_COL+2; 
  DISPID_IHTMLFONTSIZESCOLLECTION__NEWENUM                      = DISPID_NEWENUM; 
  DISPID_IHTMLFONTSIZESCOLLECTION_FORFONT                       = DISPID_OPTIONS_COL+3; 
  DISPID_IHTMLFONTSIZESCOLLECTION_ITEM                          = DISPID_VALUE; 

{    DISPIDs for interface IHTMLOptionsHolder }

  DISPID_IHTMLOPTIONSHOLDER_DOCUMENT                            = DISPID_OPTIONS_COL+3; 
  DISPID_IHTMLOPTIONSHOLDER_FONTS                               = DISPID_OPTIONS_COL+4; 
  DISPID_IHTMLOPTIONSHOLDER_EXECARG                             = DISPID_OPTIONS_COL+5; 
  DISPID_IHTMLOPTIONSHOLDER_ERRORLINE                           = DISPID_OPTIONS_COL+6; 
  DISPID_IHTMLOPTIONSHOLDER_ERRORCHARACTER                      = DISPID_OPTIONS_COL+7; 
  DISPID_IHTMLOPTIONSHOLDER_ERRORCODE                           = DISPID_OPTIONS_COL+8; 
  DISPID_IHTMLOPTIONSHOLDER_ERRORMESSAGE                        = DISPID_OPTIONS_COL+9; 
  DISPID_IHTMLOPTIONSHOLDER_ERRORDEBUG                          = DISPID_OPTIONS_COL+10; 
  DISPID_IHTMLOPTIONSHOLDER_UNSECUREDWINDOWOFDOCUMENT           = DISPID_OPTIONS_COL+11; 
  DISPID_IHTMLOPTIONSHOLDER_FINDTEXT                            = DISPID_OPTIONS_COL+12; 
  DISPID_IHTMLOPTIONSHOLDER_ANYTHINGAFTERFRAMESET               = DISPID_OPTIONS_COL+13; 
  DISPID_IHTMLOPTIONSHOLDER_SIZES                               = DISPID_OPTIONS_COL+14; 
  DISPID_IHTMLOPTIONSHOLDER_OPENFILEDLG                         = DISPID_OPTIONS_COL+15; 
  DISPID_IHTMLOPTIONSHOLDER_SAVEFILEDLG                         = DISPID_OPTIONS_COL+16; 
  DISPID_IHTMLOPTIONSHOLDER_CHOOSECOLORDLG                      = DISPID_OPTIONS_COL+17; 
  DISPID_IHTMLOPTIONSHOLDER_SHOWSECURITYINFO                    = DISPID_OPTIONS_COL+18; 
  DISPID_IHTMLOPTIONSHOLDER_ISAPARTMENTMODEL                    = DISPID_OPTIONS_COL+19; 
  DISPID_IHTMLOPTIONSHOLDER_GETCHARSET                          = DISPID_OPTIONS_COL+20; 
  DISPID_IHTMLOPTIONSHOLDER_SECURECONNECTIONINFO                = DISPID_OPTIONS_COL+21; 

{    DISPIDs for interface IHTMLStyleElement }

  DISPID_IHTMLSTYLEELEMENT_TYPE                                 = DISPID_STYLEELEMENT+2; 
  DISPID_IHTMLSTYLEELEMENT_READYSTATE                           = DISPID_A_READYSTATE; 
  DISPID_IHTMLSTYLEELEMENT_ONREADYSTATECHANGE                   = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLSTYLEELEMENT_ONLOAD                               = DISPID_EVPROP_ONLOAD; 
  DISPID_IHTMLSTYLEELEMENT_ONERROR                              = DISPID_EVPROP_ONERROR; 
  DISPID_IHTMLSTYLEELEMENT_STYLESHEET                           = DISPID_STYLEELEMENT+4; 
  DISPID_IHTMLSTYLEELEMENT_DISABLED                             = STDPROPID_XOBJ_DISABLED; 
  DISPID_IHTMLSTYLEELEMENT_MEDIA                                = DISPID_STYLEELEMENT+6; 

{    DISPIDs for event set HTMLStyleElementEvents2 }

  DISPID_HTMLSTYLEELEMENTEVENTS2_ONLOAD                         = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLSTYLEELEMENTEVENTS2_ONERROR                        = DISPID_EVMETH_ONERROR; 

{    DISPIDs for event set HTMLStyleElementEvents }

//!!  DISPID_HTMLSTYLEELEMENTEVENTS_ONREADYSTATECHANGE              = DISPID_EVMETH_ONREADYSTATECHANGE; 
  DISPID_HTMLSTYLEELEMENTEVENTS_ONLOAD                          = DISPID_EVMETH_ONLOAD; 
  DISPID_HTMLSTYLEELEMENTEVENTS_ONERROR                         = DISPID_EVMETH_ONERROR; 

{    DISPIDs for interface IHTMLStyleFontFace }

  DISPID_IHTMLSTYLEFONTFACE_FONTSRC                             = DISPID_A_FONTFACESRC; 

{    DISPIDs for interface ICSSFilterSite }

{$DEFINE DISPID_ICSSFILTERSITE_GETELEMENT}
{$DEFINE DISPID_ICSSFILTERSITE_FIREONFILTERCHANGEEVENT}

{    DISPIDs for interface ICSSFilter }

{$DEFINE DISPID_ICSSFILTER_SETSITE}
{$DEFINE DISPID_ICSSFILTER_ONAMBIENTPROPERTYCHANGE}

{    DISPIDs for interface ISecureUrlHost }

{$DEFINE DISPID_ISECUREURLHOST_VALIDATESECUREURL}

{    DISPIDs for interface IMarkupServices }

{$DEFINE DISPID_IMARKUPSERVICES_CREATEMARKUPPOINTER}
{$DEFINE DISPID_IMARKUPSERVICES_CREATEMARKUPCONTAINER}
{$DEFINE DISPID_IMARKUPSERVICES_CREATEELEMENT}
{$DEFINE DISPID_IMARKUPSERVICES_CLONEELEMENT}
{$DEFINE DISPID_IMARKUPSERVICES_INSERTELEMENT}
{$DEFINE DISPID_IMARKUPSERVICES_REMOVEELEMENT}
{$DEFINE DISPID_IMARKUPSERVICES_REMOVE}
{$DEFINE DISPID_IMARKUPSERVICES_COPY}
{$DEFINE DISPID_IMARKUPSERVICES_MOVE}
{$DEFINE DISPID_IMARKUPSERVICES_INSERTTEXT}
{$DEFINE DISPID_IMARKUPSERVICES_PARSESTRING}
{$DEFINE DISPID_IMARKUPSERVICES_PARSEGLOBAL}
{$DEFINE DISPID_IMARKUPSERVICES_ISSCOPEDELEMENT}
{$DEFINE DISPID_IMARKUPSERVICES_GETELEMENTTAGID}
{$DEFINE DISPID_IMARKUPSERVICES_GETTAGIDFORNAME}
{$DEFINE DISPID_IMARKUPSERVICES_GETNAMEFORTAGID}
{$DEFINE DISPID_IMARKUPSERVICES_MOVEPOINTERSTORANGE}
{$DEFINE DISPID_IMARKUPSERVICES_MOVERANGETOPOINTERS}
{$DEFINE DISPID_IMARKUPSERVICES_BEGINUNDOUNIT}
{$DEFINE DISPID_IMARKUPSERVICES_ENDUNDOUNIT}

{    DISPIDs for interface IMarkupServices2 }

{$DEFINE DISPID_IMARKUPSERVICES2_PARSEGLOBALEX}
{$DEFINE DISPID_IMARKUPSERVICES2_VALIDATEELEMENTS}
{$DEFINE DISPID_IMARKUPSERVICES2_SAVESEGMENTSTOCLIPBOARD}

{    DISPIDs for interface IMarkupContainer }

{$DEFINE DISPID_IMARKUPCONTAINER_OWNINGDOC}

{    DISPIDs for interface IMarkupContainer2 }

{$DEFINE DISPID_IMARKUPCONTAINER2_CREATECHANGELOG}
{$DEFINE DISPID_IMARKUPCONTAINER2_REGISTERFORDIRTYRANGE}
{$DEFINE DISPID_IMARKUPCONTAINER2_UNREGISTERFORDIRTYRANGE}
{$DEFINE DISPID_IMARKUPCONTAINER2_GETANDCLEARDIRTYRANGE}
{$DEFINE DISPID_IMARKUPCONTAINER2_GETVERSIONNUMBER}
{$DEFINE DISPID_IMARKUPCONTAINER2_GETMASTERELEMENT}

{    DISPIDs for interface IHTMLChangePlayback }

{$DEFINE DISPID_IHTMLCHANGEPLAYBACK_EXECCHANGE}

{    DISPIDs for interface IMarkupPointer }

{$DEFINE DISPID_IMARKUPPOINTER_OWNINGDOC}
{$DEFINE DISPID_IMARKUPPOINTER_GRAVITY}
{$DEFINE DISPID_IMARKUPPOINTER_SETGRAVITY}
{$DEFINE DISPID_IMARKUPPOINTER_CLING}
{$DEFINE DISPID_IMARKUPPOINTER_SETCLING}
{$DEFINE DISPID_IMARKUPPOINTER_UNPOSITION}
{$DEFINE DISPID_IMARKUPPOINTER_ISPOSITIONED}
{$DEFINE DISPID_IMARKUPPOINTER_GETCONTAINER}
{$DEFINE DISPID_IMARKUPPOINTER_MOVEADJACENTTOELEMENT}
{$DEFINE DISPID_IMARKUPPOINTER_MOVETOPOINTER}
{$DEFINE DISPID_IMARKUPPOINTER_MOVETOCONTAINER}
{$DEFINE DISPID_IMARKUPPOINTER_LEFT}
{$DEFINE DISPID_IMARKUPPOINTER_RIGHT}
{$DEFINE DISPID_IMARKUPPOINTER_CURRENTSCOPE}
{$DEFINE DISPID_IMARKUPPOINTER_ISLEFTOF}
{$DEFINE DISPID_IMARKUPPOINTER_ISLEFTOFOREQUALTO}
{$DEFINE DISPID_IMARKUPPOINTER_ISRIGHTOF}
{$DEFINE DISPID_IMARKUPPOINTER_ISRIGHTOFOREQUALTO}
{$DEFINE DISPID_IMARKUPPOINTER_ISEQUALTO}
{$DEFINE DISPID_IMARKUPPOINTER_MOVEUNIT}
{$DEFINE DISPID_IMARKUPPOINTER_FINDTEXT}

{    DISPIDs for interface IMarkupPointer2 }

{$DEFINE DISPID_IMARKUPPOINTER2_ISATWORDBREAK}
{$DEFINE DISPID_IMARKUPPOINTER2_GETMARKUPPOSITION}
{$DEFINE DISPID_IMARKUPPOINTER2_MOVETOMARKUPPOSITION}
{$DEFINE DISPID_IMARKUPPOINTER2_MOVEUNITBOUNDED}
{$DEFINE DISPID_IMARKUPPOINTER2_ISINSIDEURL}
{$DEFINE DISPID_IMARKUPPOINTER2_MOVETOCONTENT}

{    DISPIDs for interface IMarkupTextFrags }

{$DEFINE DISPID_IMARKUPTEXTFRAGS_GETTEXTFRAGCOUNT}
{$DEFINE DISPID_IMARKUPTEXTFRAGS_GETTEXTFRAG}
{$DEFINE DISPID_IMARKUPTEXTFRAGS_REMOVETEXTFRAG}
{$DEFINE DISPID_IMARKUPTEXTFRAGS_INSERTTEXTFRAG}
{$DEFINE DISPID_IMARKUPTEXTFRAGS_FINDTEXTFRAGFROMMARKUPPOINTER}

{    DISPIDs for interface IHTMLChangeLog }

{$DEFINE DISPID_IHTMLCHANGELOG_GETNEXTCHANGE}

{    DISPIDs for interface IHTMLChangeSink }

{$DEFINE DISPID_IHTMLCHANGESINK_NOTIFY}

{    DISPIDs for interface IXMLGenericParse }

{$DEFINE DISPID_IXMLGENERICPARSE_SETGENERICPARSE}

{    DISPIDs for interface IHTMLEditHost }

{$DEFINE DISPID_IHTMLEDITHOST_SNAPRECT}

{    DISPIDs for interface IHTMLEditHost2 }

{$DEFINE DISPID_IHTMLEDITHOST2_PREDRAG}

{    DISPIDs for interface ISegment }

{$DEFINE DISPID_ISEGMENT_GETPOINTERS}

{    DISPIDs for interface ISegmentListIterator }

{$DEFINE DISPID_ISEGMENTLISTITERATOR_CURRENT}
{$DEFINE DISPID_ISEGMENTLISTITERATOR_FIRST}
{$DEFINE DISPID_ISEGMENTLISTITERATOR_ISDONE}
{$DEFINE DISPID_ISEGMENTLISTITERATOR_ADVANCE}

{    DISPIDs for interface ISegmentList }

{$DEFINE DISPID_ISEGMENTLIST_CREATEITERATOR}
{$DEFINE DISPID_ISEGMENTLIST_GETTYPE}
{$DEFINE DISPID_ISEGMENTLIST_ISEMPTY}

{    DISPIDs for interface ISequenceNumber }

{$DEFINE DISPID_ISEQUENCENUMBER_GETSEQUENCENUMBER}

{    DISPIDs for interface IIMEServices }

{$DEFINE DISPID_IIMESERVICES_GETACTIVEIMM}

{    DISPIDs for interface IHTMLCaret }

{$DEFINE DISPID_IHTMLCARET_MOVECARETTOPOINTER}
{$DEFINE DISPID_IHTMLCARET_MOVECARETTOPOINTEREX}
{$DEFINE DISPID_IHTMLCARET_MOVEMARKUPPOINTERTOCARET}
{$DEFINE DISPID_IHTMLCARET_MOVEDISPLAYPOINTERTOCARET}
{$DEFINE DISPID_IHTMLCARET_ISVISIBLE}
{$DEFINE DISPID_IHTMLCARET_SHOW}
{$DEFINE DISPID_IHTMLCARET_HIDE}
{$DEFINE DISPID_IHTMLCARET_INSERTTEXT}
{$DEFINE DISPID_IHTMLCARET_SCROLLINTOVIEW}
{$DEFINE DISPID_IHTMLCARET_GETLOCATION}
{$DEFINE DISPID_IHTMLCARET_GETCARETDIRECTION}
{$DEFINE DISPID_IHTMLCARET_SETCARETDIRECTION}

{    DISPIDs for interface IHighlightRenderingServices }

{$DEFINE DISPID_IHIGHLIGHTRENDERINGSERVICES_ADDSEGMENT}
{$DEFINE DISPID_IHIGHLIGHTRENDERINGSERVICES_MOVESEGMENTTOPOINTERS}
{$DEFINE DISPID_IHIGHLIGHTRENDERINGSERVICES_REMOVESEGMENT}

{    DISPIDs for interface ISelectionServicesListener }

{$DEFINE DISPID_ISELECTIONSERVICESLISTENER_BEGINSELECTIONUNDO}
{$DEFINE DISPID_ISELECTIONSERVICESLISTENER_ENDSELECTIONUNDO}
{$DEFINE DISPID_ISELECTIONSERVICESLISTENER_ONSELECTEDELEMENTEXIT}
{$DEFINE DISPID_ISELECTIONSERVICESLISTENER_ONCHANGETYPE}
{$DEFINE DISPID_ISELECTIONSERVICESLISTENER_GETTYPEDETAIL}

{    DISPIDs for interface ISelectionServices }

{$DEFINE DISPID_ISELECTIONSERVICES_SETSELECTIONTYPE}
{$DEFINE DISPID_ISELECTIONSERVICES_GETMARKUPCONTAINER}
{$DEFINE DISPID_ISELECTIONSERVICES_ADDSEGMENT}
{$DEFINE DISPID_ISELECTIONSERVICES_ADDELEMENTSEGMENT}
{$DEFINE DISPID_ISELECTIONSERVICES_REMOVESEGMENT}
{$DEFINE DISPID_ISELECTIONSERVICES_GETSELECTIONSERVICESLISTENER}

{    DISPIDs for interface IElementSegment }

{$DEFINE DISPID_IELEMENTSEGMENT_GETELEMENT}
{$DEFINE DISPID_IELEMENTSEGMENT_SETPRIMARY}
{$DEFINE DISPID_IELEMENTSEGMENT_ISPRIMARY}

{    DISPIDs for interface IHTMLEditDesigner }

{$DEFINE DISPID_IHTMLEDITDESIGNER_PREHANDLEEVENT}
{$DEFINE DISPID_IHTMLEDITDESIGNER_POSTHANDLEEVENT}
{$DEFINE DISPID_IHTMLEDITDESIGNER_TRANSLATEACCELERATOR}
{$DEFINE DISPID_IHTMLEDITDESIGNER_POSTEDITOREVENTNOTIFY}

{    DISPIDs for interface IHTMLEditServices }

{$DEFINE DISPID_IHTMLEDITSERVICES_ADDDESIGNER}
{$DEFINE DISPID_IHTMLEDITSERVICES_REMOVEDESIGNER}
{$DEFINE DISPID_IHTMLEDITSERVICES_GETSELECTIONSERVICES}
{$DEFINE DISPID_IHTMLEDITSERVICES_MOVETOSELECTIONANCHOR}
{$DEFINE DISPID_IHTMLEDITSERVICES_MOVETOSELECTIONEND}
{$DEFINE DISPID_IHTMLEDITSERVICES_SELECTRANGE}

{    DISPIDs for interface IHTMLEditServices2 }

{$DEFINE DISPID_IHTMLEDITSERVICES2_MOVETOSELECTIONANCHOREX}
{$DEFINE DISPID_IHTMLEDITSERVICES2_MOVETOSELECTIONENDEX}
{$DEFINE DISPID_IHTMLEDITSERVICES2_FREEZEVIRTUALCARETPOS}
{$DEFINE DISPID_IHTMLEDITSERVICES2_UNFREEZEVIRTUALCARETPOS}

{    DISPIDs for interface ILineInfo }

  DISPID_ILINEINFO_X                                            = DISPID_ILINEINFO+1; 
  DISPID_ILINEINFO_BASELINE                                     = DISPID_ILINEINFO+2; 
  DISPID_ILINEINFO_TEXTDESCENT                                  = DISPID_ILINEINFO+3; 
  DISPID_ILINEINFO_TEXTHEIGHT                                   = DISPID_ILINEINFO+4; 
  DISPID_ILINEINFO_LINEDIRECTION                                = DISPID_ILINEINFO+5; 

{    DISPIDs for interface IHTMLComputedStyle }

  DISPID_IHTMLCOMPUTEDSTYLE_BOLD                                = DISPID_IHTMLCOMPUTEDSTYLE+1; 
  DISPID_IHTMLCOMPUTEDSTYLE_ITALIC                              = DISPID_IHTMLCOMPUTEDSTYLE+2; 
  DISPID_IHTMLCOMPUTEDSTYLE_UNDERLINE                           = DISPID_IHTMLCOMPUTEDSTYLE+3; 
  DISPID_IHTMLCOMPUTEDSTYLE_OVERLINE                            = DISPID_IHTMLCOMPUTEDSTYLE+4; 
  DISPID_IHTMLCOMPUTEDSTYLE_STRIKEOUT                           = DISPID_IHTMLCOMPUTEDSTYLE+5; 
  DISPID_IHTMLCOMPUTEDSTYLE_SUBSCRIPT                           = DISPID_IHTMLCOMPUTEDSTYLE+6; 
  DISPID_IHTMLCOMPUTEDSTYLE_SUPERSCRIPT                         = DISPID_IHTMLCOMPUTEDSTYLE+7; 
  DISPID_IHTMLCOMPUTEDSTYLE_EXPLICITFACE                        = DISPID_IHTMLCOMPUTEDSTYLE+8; 
  DISPID_IHTMLCOMPUTEDSTYLE_FONTWEIGHT                          = DISPID_IHTMLCOMPUTEDSTYLE+9; 
  DISPID_IHTMLCOMPUTEDSTYLE_FONTSIZE                            = DISPID_IHTMLCOMPUTEDSTYLE+10; 
  DISPID_IHTMLCOMPUTEDSTYLE_FONTNAME                            = DISPID_IHTMLCOMPUTEDSTYLE+11; 
  DISPID_IHTMLCOMPUTEDSTYLE_HASBGCOLOR                          = DISPID_IHTMLCOMPUTEDSTYLE+12; 
  DISPID_IHTMLCOMPUTEDSTYLE_TEXTCOLOR                           = DISPID_IHTMLCOMPUTEDSTYLE+13; 
  DISPID_IHTMLCOMPUTEDSTYLE_BACKGROUNDCOLOR                     = DISPID_IHTMLCOMPUTEDSTYLE+14; 
  DISPID_IHTMLCOMPUTEDSTYLE_PREFORMATTED                        = DISPID_IHTMLCOMPUTEDSTYLE+15; 
  DISPID_IHTMLCOMPUTEDSTYLE_DIRECTION                           = DISPID_IHTMLCOMPUTEDSTYLE+16; 
  DISPID_IHTMLCOMPUTEDSTYLE_BLOCKDIRECTION                      = DISPID_IHTMLCOMPUTEDSTYLE+17; 
  DISPID_IHTMLCOMPUTEDSTYLE_OL                                  = DISPID_IHTMLCOMPUTEDSTYLE+18; 
{$DEFINE DISPID_IHTMLCOMPUTEDSTYLE_ISEQUAL}

{    DISPIDs for interface IDisplayPointer }

{$DEFINE DISPID_IDISPLAYPOINTER_MOVETOPOINT}
{$DEFINE DISPID_IDISPLAYPOINTER_MOVEUNIT}
{$DEFINE DISPID_IDISPLAYPOINTER_POSITIONMARKUPPOINTER}
{$DEFINE DISPID_IDISPLAYPOINTER_MOVETOPOINTER}
{$DEFINE DISPID_IDISPLAYPOINTER_SETPOINTERGRAVITY}
{$DEFINE DISPID_IDISPLAYPOINTER_GETPOINTERGRAVITY}
{$DEFINE DISPID_IDISPLAYPOINTER_SETDISPLAYGRAVITY}
{$DEFINE DISPID_IDISPLAYPOINTER_GETDISPLAYGRAVITY}
{$DEFINE DISPID_IDISPLAYPOINTER_ISPOSITIONED}
{$DEFINE DISPID_IDISPLAYPOINTER_UNPOSITION}
{$DEFINE DISPID_IDISPLAYPOINTER_ISEQUALTO}
{$DEFINE DISPID_IDISPLAYPOINTER_ISLEFTOF}
{$DEFINE DISPID_IDISPLAYPOINTER_ISRIGHTOF}
{$DEFINE DISPID_IDISPLAYPOINTER_ISATBOL}
{$DEFINE DISPID_IDISPLAYPOINTER_MOVETOMARKUPPOINTER}
{$DEFINE DISPID_IDISPLAYPOINTER_SCROLLINTOVIEW}
{$DEFINE DISPID_IDISPLAYPOINTER_GETLINEINFO}
{$DEFINE DISPID_IDISPLAYPOINTER_GETFLOWELEMENT}
{$DEFINE DISPID_IDISPLAYPOINTER_QUERYBREAKS}

{    DISPIDs for interface IDisplayServices }

{$DEFINE DISPID_IDISPLAYSERVICES_CREATEDISPLAYPOINTER}
{$DEFINE DISPID_IDISPLAYSERVICES_TRANSFORMRECT}
{$DEFINE DISPID_IDISPLAYSERVICES_TRANSFORMPOINT}
{$DEFINE DISPID_IDISPLAYSERVICES_GETCARET}
{$DEFINE DISPID_IDISPLAYSERVICES_GETCOMPUTEDSTYLE}
{$DEFINE DISPID_IDISPLAYSERVICES_SCROLLRECTINTOVIEW}
{$DEFINE DISPID_IDISPLAYSERVICES_HASFLOWLAYOUT}

{    DISPIDs for interface IHtmlDlgSafeHelper }

  DISPID_IHTMLDLGSAFEHELPER_CHOOSECOLORDLG                      = 1; 
  DISPID_IHTMLDLGSAFEHELPER_GETCHARSET                          = 2; 
  DISPID_IHTMLDLGSAFEHELPER_FONTS                               = 3; 
  DISPID_IHTMLDLGSAFEHELPER_BLOCKFORMATS                        = 4; 

{    DISPIDs for interface IBlockFormats }

  DISPID_IBLOCKFORMATS__NEWENUM                                 = DISPID_NEWENUM; 
  DISPID_IBLOCKFORMATS_COUNT                                    = 1; 
  DISPID_IBLOCKFORMATS_ITEM                                     = DISPID_VALUE; 

{    DISPIDs for interface IFontNames }

  DISPID_IFONTNAMES__NEWENUM                                    = DISPID_NEWENUM; 
  DISPID_IFONTNAMES_COUNT                                       = 1; 
  DISPID_IFONTNAMES_ITEM                                        = DISPID_VALUE; 

{    DISPIDs for interface IHTMLNamespace }

  DISPID_IHTMLNAMESPACE_NAME                                    = DISPID_NAMESPACE+0; 
  DISPID_IHTMLNAMESPACE_URN                                     = DISPID_NAMESPACE+1; 
  DISPID_IHTMLNAMESPACE_TAGNAMES                                = DISPID_NAMESPACE+2; 
  DISPID_IHTMLNAMESPACE_READYSTATE                              = DISPID_A_READYSTATE; 
  DISPID_IHTMLNAMESPACE_ONREADYSTATECHANGE                      = DISPID_EVPROP_ONREADYSTATECHANGE; 
  DISPID_IHTMLNAMESPACE_DOIMPORT                                = DISPID_NAMESPACE+3; 
  DISPID_IHTMLNAMESPACE_ATTACHEVENT                             = DISPID_HTMLOBJECT+7; 
  DISPID_IHTMLNAMESPACE_DETACHEVENT                             = DISPID_HTMLOBJECT+8; 

{    DISPIDs for interface IHTMLNamespaceCollection }

  DISPID_IHTMLNAMESPACECOLLECTION_LENGTH                        = DISPID_NAMESPACE_COLLECTION+0; 
  DISPID_IHTMLNAMESPACECOLLECTION_ITEM                          = DISPID_VALUE; 
  DISPID_IHTMLNAMESPACECOLLECTION_ADD                           = DISPID_NAMESPACE_COLLECTION+1; 

{    DISPIDs for event set HTMLNamespaceEvents }

  DISPID_HTMLNAMESPACEEVENTS_ONREADYSTATECHANGE                 = DISPID_EVMETH_ONREADYSTATECHANGE; 

{    DISPIDs for interface IHTMLPainter }

{$DEFINE DISPID_IHTMLPAINTER_DRAW}
{$DEFINE DISPID_IHTMLPAINTER_ONRESIZE}
{$DEFINE DISPID_IHTMLPAINTER_GETPAINTERINFO}
{$DEFINE DISPID_IHTMLPAINTER_HITTESTPOINT}

{    DISPIDs for interface IHTMLPainterEventInfo }

{$DEFINE DISPID_IHTMLPAINTEREVENTINFO_GETEVENTINFOFLAGS}
{$DEFINE DISPID_IHTMLPAINTEREVENTINFO_GETEVENTTARGET}
{$DEFINE DISPID_IHTMLPAINTEREVENTINFO_SETCURSOR}
{$DEFINE DISPID_IHTMLPAINTEREVENTINFO_STRINGFROMPARTID}

{    DISPIDs for interface IHTMLPainterOverlay }

{$DEFINE DISPID_IHTMLPAINTEROVERLAY_ONMOVE}

{    DISPIDs for interface IHTMLPaintSite }

{$DEFINE DISPID_IHTMLPAINTSITE_INVALIDATEPAINTERINFO}
{$DEFINE DISPID_IHTMLPAINTSITE_INVALIDATERECT}
{$DEFINE DISPID_IHTMLPAINTSITE_INVALIDATEREGION}
{$DEFINE DISPID_IHTMLPAINTSITE_GETDRAWINFO}
{$DEFINE DISPID_IHTMLPAINTSITE_TRANSFORMGLOBALTOLOCAL}
{$DEFINE DISPID_IHTMLPAINTSITE_TRANSFORMLOCALTOGLOBAL}
{$DEFINE DISPID_IHTMLPAINTSITE_GETHITTESTCOOKIE}

{    DISPIDs for interface IHTMLIPrintCollection }

  DISPID_IHTMLIPRINTCOLLECTION_LENGTH                           = DISPID_OPTIONS_COL+1; 
  DISPID_IHTMLIPRINTCOLLECTION__NEWENUM                         = DISPID_NEWENUM; 
  DISPID_IHTMLIPRINTCOLLECTION_ITEM                             = DISPID_VALUE; 

{    DISPIDs for interface IEnumPrivacyRecords }

{$DEFINE DISPID_IENUMPRIVACYRECORDS_RESET}
{$DEFINE DISPID_IENUMPRIVACYRECORDS_GETSIZE}
{$DEFINE DISPID_IENUMPRIVACYRECORDS_GETPRIVACYIMPACTED}
{$DEFINE DISPID_IENUMPRIVACYRECORDS_NEXT}

{    DISPIDs for interface IHTMLDialog }

  DISPID_IHTMLDIALOG_DIALOGTOP                                  = STDPROPID_XOBJ_TOP; 
  DISPID_IHTMLDIALOG_DIALOGLEFT                                 = STDPROPID_XOBJ_LEFT; 
  DISPID_IHTMLDIALOG_DIALOGWIDTH                                = STDPROPID_XOBJ_WIDTH; 
  DISPID_IHTMLDIALOG_DIALOGHEIGHT                               = STDPROPID_XOBJ_HEIGHT; 
  DISPID_IHTMLDIALOG_DIALOGARGUMENTS                            = DISPID_HTMLDLG+0; 
  DISPID_IHTMLDIALOG_MENUARGUMENTS                              = DISPID_HTMLDLG+13; 
  DISPID_IHTMLDIALOG_RETURNVALUE                                = DISPID_HTMLDLG+1; 
  DISPID_IHTMLDIALOG_CLOSE                                      = DISPID_HTMLDLG+11; 
  DISPID_IHTMLDIALOG_TOSTRING                                   = DISPID_HTMLDLG+12; 

{    DISPIDs for interface IHTMLDialog2 }

  DISPID_IHTMLDIALOG2_STATUS                                    = DISPID_HTMLDLG+14; 
  DISPID_IHTMLDIALOG2_RESIZABLE                                 = DISPID_HTMLDLG+15; 

{    DISPIDs for interface IHTMLDialog3 }

  DISPID_IHTMLDIALOG3_UNADORNED                                 = DISPID_HTMLDLG+16; 
  DISPID_IHTMLDIALOG3_DIALOGHIDE                                = DISPID_HTMLDLG+7; 

{    DISPIDs for interface IHTMLModelessInit }

  DISPID_IHTMLMODELESSINIT_PARAMETERS                           = DISPID_HTMLDLG+0; 
  DISPID_IHTMLMODELESSINIT_OPTIONSTRING                         = DISPID_HTMLDLG+1; 
  DISPID_IHTMLMODELESSINIT_MONIKER                              = DISPID_HTMLDLG+6; 
  DISPID_IHTMLMODELESSINIT_DOCUMENT                             = DISPID_HTMLDLG+7; 

{    DISPIDs for interface IHTMLPopup }

  DISPID_IHTMLPOPUP_SHOW                                        = DISPID_HTMLPOPUP+1; 
  DISPID_IHTMLPOPUP_HIDE                                        = DISPID_HTMLPOPUP+2; 
  DISPID_IHTMLPOPUP_DOCUMENT                                    = DISPID_HTMLPOPUP+3; 
  DISPID_IHTMLPOPUP_ISOPEN                                      = DISPID_HTMLPOPUP+4; 

{    DISPIDs for interface IHTMLAppBehavior }

  DISPID_IHTMLAPPBEHAVIOR_APPLICATIONNAME                       = DISPID_HTMLAPP+0; 
  DISPID_IHTMLAPPBEHAVIOR_VERSION                               = DISPID_HTMLAPP+1; 
  DISPID_IHTMLAPPBEHAVIOR_ICON                                  = DISPID_HTMLAPP+2; 
  DISPID_IHTMLAPPBEHAVIOR_SINGLEINSTANCE                        = DISPID_HTMLAPP+3; 
  DISPID_IHTMLAPPBEHAVIOR_MINIMIZEBUTTON                        = DISPID_HTMLAPP+5; 
  DISPID_IHTMLAPPBEHAVIOR_MAXIMIZEBUTTON                        = DISPID_HTMLAPP+6; 
  DISPID_IHTMLAPPBEHAVIOR_BORDER                                = DISPID_HTMLAPP+7; 
  DISPID_IHTMLAPPBEHAVIOR_BORDERSTYLE                           = DISPID_HTMLAPP+8; 
  DISPID_IHTMLAPPBEHAVIOR_SYSMENU                               = DISPID_HTMLAPP+9; 
  DISPID_IHTMLAPPBEHAVIOR_CAPTION                               = DISPID_HTMLAPP+10; 
  DISPID_IHTMLAPPBEHAVIOR_WINDOWSTATE                           = DISPID_HTMLAPP+11; 
  DISPID_IHTMLAPPBEHAVIOR_SHOWINTASKBAR                         = DISPID_HTMLAPP+12; 
  DISPID_IHTMLAPPBEHAVIOR_COMMANDLINE                           = DISPID_HTMLAPP+13; 

{    DISPIDs for interface IHTMLAppBehavior2 }

  DISPID_IHTMLAPPBEHAVIOR2_CONTEXTMENU                          = DISPID_HTMLAPP+14; 
  DISPID_IHTMLAPPBEHAVIOR2_INNERBORDER                          = DISPID_HTMLAPP+15; 
  DISPID_IHTMLAPPBEHAVIOR2_SCROLL                               = DISPID_HTMLAPP+16; 
  DISPID_IHTMLAPPBEHAVIOR2_SCROLLFLAT                           = DISPID_HTMLAPP+17; 
  DISPID_IHTMLAPPBEHAVIOR2_SELECTION                            = DISPID_HTMLAPP+18; 

{    DISPIDs for interface IHTMLAppBehavior3 }

  DISPID_IHTMLAPPBEHAVIOR3_NAVIGABLE                            = DISPID_HTMLAPP+19; 

{    DISPIDs for interface IHTMLPrivateWindow }

{$DEFINE DISPID_IHTMLPRIVATEWINDOW_SUPERNAVIGATE}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW_GETPENDINGURL}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW_SETPICSTARGET}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW_PICSCOMPLETE}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW_FINDWINDOWBYNAME}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW_GETADDRESSBARURL}

{    DISPIDs for interface IHTMLPrivateWindow2 }

{$DEFINE DISPID_IHTMLPRIVATEWINDOW2_NAVIGATEEX}
{$DEFINE DISPID_IHTMLPRIVATEWINDOW2_GETINNERWINDOWUNKNOWN}

{    DISPIDs for interface IHTMLPrivateWindow3 }

{$DEFINE DISPID_IHTMLPRIVATEWINDOW3_OPENEX}

{    DISPIDs for interface ISubDivisionProvider }

{$DEFINE DISPID_ISUBDIVISIONPROVIDER_GETSUBDIVISIONCOUNT}
{$DEFINE DISPID_ISUBDIVISIONPROVIDER_GETSUBDIVISIONTABS}
{$DEFINE DISPID_ISUBDIVISIONPROVIDER_SUBDIVISIONFROMPT}

{    DISPIDs for interface IElementBehaviorUI }

{$DEFINE DISPID_IELEMENTBEHAVIORUI_ONRECEIVEFOCUS}
{$DEFINE DISPID_IELEMENTBEHAVIORUI_GETSUBDIVISIONPROVIDER}
{$DEFINE DISPID_IELEMENTBEHAVIORUI_CANTAKEFOCUS}

{    DISPIDs for interface IElementAdorner }

{$DEFINE DISPID_IELEMENTADORNER_DRAW}
{$DEFINE DISPID_IELEMENTADORNER_HITTESTPOINT}
{$DEFINE DISPID_IELEMENTADORNER_GETSIZE}
{$DEFINE DISPID_IELEMENTADORNER_GETPOSITION}
{$DEFINE DISPID_IELEMENTADORNER_ONPOSITIONSET}

{    DISPIDs for interface IHTMLEditor }

{$DEFINE DISPID_IHTMLEDITOR_PREHANDLEEVENT}
{$DEFINE DISPID_IHTMLEDITOR_POSTHANDLEEVENT}
{$DEFINE DISPID_IHTMLEDITOR_TRANSLATEACCELERATOR}
{$DEFINE DISPID_IHTMLEDITOR_INITIALIZE}
{$DEFINE DISPID_IHTMLEDITOR_NOTIFY}
{$DEFINE DISPID_IHTMLEDITOR_GETCOMMANDTARGET}
{$DEFINE DISPID_IHTMLEDITOR_GETELEMENTTOTABFROM}
{$DEFINE DISPID_IHTMLEDITOR_ISEDITCONTEXTUIACTIVE}
{$DEFINE DISPID_IHTMLEDITOR_TERMINATEIMECOMPOSITION}
{$DEFINE DISPID_IHTMLEDITOR_ENABLEMODELESS}

{    DISPIDs for interface IHTMLEditingServices }

{$DEFINE DISPID_IHTMLEDITINGSERVICES_DELETE}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_PASTE}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_PASTEFROMCLIPBOARD}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_LAUNDERSPACES}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_INSERTSANITIZEDTEXT}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_URLAUTODETECTCURRENTWORD}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_URLAUTODETECTRANGE}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_SHOULDUPDATEANCHORTEXT}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_ADJUSTPOINTERFORINSERT}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_FINDSITESELECTABLEELEMENT}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_ISELEMENTSITESELECTABLE}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_ISELEMENTUIACTIVATABLE}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_ISELEMENTATOMIC}
{$DEFINE DISPID_IHTMLEDITINGSERVICES_POSITIONPOINTERSINMASTER}

{    DISPIDs for interface ISelectionObject2 }

{$DEFINE DISPID_ISELECTIONOBJECT2_SELECT}
{$DEFINE DISPID_ISELECTIONOBJECT2_ISPOINTERINSELECTION}
{$DEFINE DISPID_ISELECTIONOBJECT2_EMPTYSELECTION}
{$DEFINE DISPID_ISELECTIONOBJECT2_DESTROYSELECTION}
{$DEFINE DISPID_ISELECTIONOBJECT2_DESTROYALLSELECTION}

{    DISPIDs for interface IEditDebugServices }

{$DEFINE DISPID_IEDITDEBUGSERVICES_GETCP}
{$DEFINE DISPID_IEDITDEBUGSERVICES_SETDEBUGNAME}
{$DEFINE DISPID_IEDITDEBUGSERVICES_SETDISPLAYPOINTERDEBUGNAME}
{$DEFINE DISPID_IEDITDEBUGSERVICES_DUMPTREE}
{$DEFINE DISPID_IEDITDEBUGSERVICES_LINESINELEMENT}
{$DEFINE DISPID_IEDITDEBUGSERVICES_FONTSONLINE}
{$DEFINE DISPID_IEDITDEBUGSERVICES_GETPIXEL}
{$DEFINE DISPID_IEDITDEBUGSERVICES_ISUSINGBCKGRNRECALC}
{$DEFINE DISPID_IEDITDEBUGSERVICES_ISENCODINGAUTOSELECT}
{$DEFINE DISPID_IEDITDEBUGSERVICES_ENABLEENCODINGAUTOSELECT}
{$DEFINE DISPID_IEDITDEBUGSERVICES_ISUSINGTABLEINCRECALC}

{    DISPIDs for interface IPrivacyServices }

{$DEFINE DISPID_IPRIVACYSERVICES_ADDPRIVACYINFOTOLIST}

{    DISPIDs for interface IHTMLOMWindowServices }

{$DEFINE DISPID_IHTMLOMWINDOWSERVICES_MOVETO}
{$DEFINE DISPID_IHTMLOMWINDOWSERVICES_MOVEBY}
{$DEFINE DISPID_IHTMLOMWINDOWSERVICES_RESIZETO}
{$DEFINE DISPID_IHTMLOMWINDOWSERVICES_RESIZEBY}

{    DISPIDs for interface IHTMLFilterPainter }

{$DEFINE DISPID_IHTMLFILTERPAINTER_INVALIDATERECTUNFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTER_INVALIDATERGNUNFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTER_CHANGEELEMENTVISIBILITY}

{    DISPIDs for interface IHTMLFilterPaintSite }

{$DEFINE DISPID_IHTMLFILTERPAINTSITE_DRAWUNFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_HITTESTPOINTUNFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_INVALIDATERECTFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_INVALIDATERGNFILTERED}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_CHANGEFILTERVISIBILITY}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_ENSUREVIEWFORFILTERSITE}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_GETDIRECTDRAW}
{$DEFINE DISPID_IHTMLFILTERPAINTSITE_GETFILTERFLAGS}

{    DISPIDs for interface IElementNamespacePrivate }

{$DEFINE DISPID_IELEMENTNAMESPACEPRIVATE_ADDTAGPRIVATE}

{    DISPIDs for interface IElementBehaviorFactory }

{$DEFINE DISPID_IELEMENTBEHAVIORFACTORY_FINDBEHAVIOR}

{    DISPIDs for interface IElementNamespace }

{$DEFINE DISPID_IELEMENTNAMESPACE_ADDTAG}

{    DISPIDs for interface IElementNamespaceTable }

{$DEFINE DISPID_IELEMENTNAMESPACETABLE_ADDNAMESPACE}

{    DISPIDs for interface IElementNamespaceFactory }

{$DEFINE DISPID_IELEMENTNAMESPACEFACTORY_CREATE}

{    DISPIDs for interface IElementNamespaceFactory2 }

{$DEFINE DISPID_IELEMENTNAMESPACEFACTORY2_CREATEWITHIMPLEMENTATION}

{    DISPIDs for interface IElementNamespaceFactoryCallback }

{$DEFINE DISPID_IELEMENTNAMESPACEFACTORYCALLBACK_RESOLVE}

{    DISPIDs for interface IElementBehavior }

{$DEFINE DISPID_IELEMENTBEHAVIOR_INIT}
{$DEFINE DISPID_IELEMENTBEHAVIOR_NOTIFY}
{$DEFINE DISPID_IELEMENTBEHAVIOR_DETACH}

{    DISPIDs for interface IElementBehaviorSite }

{$DEFINE DISPID_IELEMENTBEHAVIORSITE_GETELEMENT}
{$DEFINE DISPID_IELEMENTBEHAVIORSITE_REGISTERNOTIFICATION}

{    DISPIDs for interface IElementBehaviorSiteOM }

{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_REGISTEREVENT}
{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_GETEVENTCOOKIE}
{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_FIREEVENT}
{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_CREATEEVENTOBJECT}
{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_REGISTERNAME}
{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM_REGISTERURN}

{    DISPIDs for interface IElementBehaviorSiteOM2 }

{$DEFINE DISPID_IELEMENTBEHAVIORSITEOM2_GETDEFAULTS}

{    DISPIDs for interface IElementBehaviorRender }

{$DEFINE DISPID_IELEMENTBEHAVIORRENDER_DRAW}
{$DEFINE DISPID_IELEMENTBEHAVIORRENDER_GETRENDERINFO}
{$DEFINE DISPID_IELEMENTBEHAVIORRENDER_HITTESTPOINT}

{    DISPIDs for interface IElementBehaviorSiteRender }

{$DEFINE DISPID_IELEMENTBEHAVIORSITERENDER_INVALIDATE}
{$DEFINE DISPID_IELEMENTBEHAVIORSITERENDER_INVALIDATERENDERINFO}
{$DEFINE DISPID_IELEMENTBEHAVIORSITERENDER_INVALIDATESTYLE}

{    DISPIDs for interface IElementBehaviorCategory }

{$DEFINE DISPID_IELEMENTBEHAVIORCATEGORY_GETCATEGORY}

{    DISPIDs for interface IElementBehaviorSiteCategory }

{$DEFINE DISPID_IELEMENTBEHAVIORSITECATEGORY_GETRELATEDBEHAVIORS}

{    DISPIDs for interface IElementBehaviorSubmit }

{$DEFINE DISPID_IELEMENTBEHAVIORSUBMIT_GETSUBMITINFO}
{$DEFINE DISPID_IELEMENTBEHAVIORSUBMIT_RESET}

{    DISPIDs for interface IElementBehaviorFocus }

{$DEFINE DISPID_IELEMENTBEHAVIORFOCUS_GETFOCUSRECT}

{    DISPIDs for interface IElementBehaviorLayout }

{$DEFINE DISPID_IELEMENTBEHAVIORLAYOUT_GETSIZE}
{$DEFINE DISPID_IELEMENTBEHAVIORLAYOUT_GETLAYOUTINFO}
{$DEFINE DISPID_IELEMENTBEHAVIORLAYOUT_GETPOSITION}
{$DEFINE DISPID_IELEMENTBEHAVIORLAYOUT_MAPSIZE}

{    DISPIDs for interface IElementBehaviorLayout2 }

{$DEFINE DISPID_IELEMENTBEHAVIORLAYOUT2_GETTEXTDESCENT}

{    DISPIDs for interface IElementBehaviorSiteLayout }

{$DEFINE DISPID_IELEMENTBEHAVIORSITELAYOUT_INVALIDATELAYOUTINFO}
{$DEFINE DISPID_IELEMENTBEHAVIORSITELAYOUT_INVALIDATESIZE}
{$DEFINE DISPID_IELEMENTBEHAVIORSITELAYOUT_GETMEDIARESOLUTION}

{    DISPIDs for interface IElementBehaviorSiteLayout2 }

{$DEFINE DISPID_IELEMENTBEHAVIORSITELAYOUT2_GETFONTINFO}

{    DISPIDs for interface IHostBehaviorInit }

{$DEFINE DISPID_IHOSTBEHAVIORINIT_POPULATENAMESPACETABLE}


implementation


end.
