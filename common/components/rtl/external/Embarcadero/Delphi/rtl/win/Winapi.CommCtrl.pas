{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: CommCtrl.h                             }
{          Copyright (c) Microsoft Corporation.         }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{         Win32 Common Controls Interface Unit          }
{*******************************************************}

unit Winapi.CommCtrl;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

         { _WIN32_IE >= 0x0300 }
         { _WIN32_IE >= 0x0400 }
         { _WIN32_IE >= 0x0500 }
         { _WIN32_IE >= 0x0600 }
    { _WIN32_WINNT >= 0x0501 }
      { _WIN32_WINNT >= 0x0600 }
  { NTDDI_VERSION >= NTDDI_WIN7 }

interface

(*$HPPEMIT '' *)
(*$HPPEMIT '#include <CommCtrl.h>' *)
(*$HPPEMIT '' *)

{ Although the COMMCTRL unit requires the ActiveX unit, COMMCTRL.HPP does }
{ not require Winapi.ActiveX.hpp to compile. Hence the $NOINCLUDE directive.     }
(*$NOINCLUDE Winapi.ActiveX *)

uses Winapi.Messages, Winapi.Windows, Winapi.ActiveX;

{ From prsht.h -- Interface for the Windows Property Sheet Pages }

const
  {$EXTERNALSYM MAXPROPPAGES}
  MAXPROPPAGES = 100;

  {$EXTERNALSYM PSP_DEFAULT}
  PSP_DEFAULT             = $00000000;
  {$EXTERNALSYM PSP_DLGINDIRECT}
  PSP_DLGINDIRECT         = $00000001;
  {$EXTERNALSYM PSP_USEHICON}
  PSP_USEHICON            = $00000002;
  {$EXTERNALSYM PSP_USEICONID}
  PSP_USEICONID           = $00000004;
  {$EXTERNALSYM PSP_USETITLE}
  PSP_USETITLE            = $00000008;
  {$EXTERNALSYM PSP_RTLREADING}
  PSP_RTLREADING          = $00000010;
  {$EXTERNALSYM PSP_HASHELP}
  PSP_HASHELP             = $00000020;
  {$EXTERNALSYM PSP_USEREFPARENT}
  PSP_USEREFPARENT        = $00000040;
  {$EXTERNALSYM PSP_USECALLBACK}
  PSP_USECALLBACK         = $00000080;
  {$EXTERNALSYM PSP_PREMATURE}
  PSP_PREMATURE           = $00000400;
  {$EXTERNALSYM PSP_HIDEHEADER}
  PSP_HIDEHEADER          = $00000800;
  {$EXTERNALSYM PSP_USEHEADERTITLE}
  PSP_USEHEADERTITLE      = $00001000;
  {$EXTERNALSYM PSP_USEHEADERSUBTITLE}
  PSP_USEHEADERSUBTITLE   = $00002000;
  {$EXTERNALSYM PSP_USEFUSIONCONTEXT}
  PSP_USEFUSIONCONTEXT    = $00004000;

  {$EXTERNALSYM PSPCB_ADDREF}
  PSPCB_ADDREF            = 0;
  {$EXTERNALSYM PSPCB_RELEASE}
  PSPCB_RELEASE           = 1;
  {$EXTERNALSYM PSPCB_CREATE}
  PSPCB_CREATE            = 2;

  {$EXTERNALSYM PSH_DEFAULT}
  PSH_DEFAULT             = $00000000;
  {$EXTERNALSYM PSH_PROPTITLE}
  PSH_PROPTITLE           = $00000001;
  {$EXTERNALSYM PSH_USEHICON}
  PSH_USEHICON            = $00000002;
  {$EXTERNALSYM PSH_USEICONID}
  PSH_USEICONID           = $00000004;
  {$EXTERNALSYM PSH_PROPSHEETPAGE}
  PSH_PROPSHEETPAGE       = $00000008;
  {$EXTERNALSYM PSH_WIZARDHASFINISH}
  PSH_WIZARDHASFINISH     = $00000010;
  {$EXTERNALSYM PSH_MULTILINETABS}
  PSH_MULTILINETABS       = $00000010;
  {$EXTERNALSYM PSH_WIZARD}
  PSH_WIZARD              = $00000020;
  {$EXTERNALSYM PSH_USEPSTARTPAGE}
  PSH_USEPSTARTPAGE       = $00000040;
  {$EXTERNALSYM PSH_NOAPPLYNOW}
  PSH_NOAPPLYNOW          = $00000080;
  {$EXTERNALSYM PSH_USECALLBACK}
  PSH_USECALLBACK         = $00000100;
  {$EXTERNALSYM PSH_HASHELP}
  PSH_HASHELP             = $00000200;
  {$EXTERNALSYM PSH_MODELESS}
  PSH_MODELESS            = $00000400;
  {$EXTERNALSYM PSH_RTLREADING}
  PSH_RTLREADING          = $00000800;
  {$EXTERNALSYM PSH_WIZARDCONTEXTHELP}
  PSH_WIZARDCONTEXTHELP   = $00001000;
  {$EXTERNALSYM PSH_WIZARD97}
  // PSH_WIZARD97            = $00002000; { IExplorer 4.x only}
  PSH_WIZARD97            = $01000000;
  {$EXTERNALSYM PSH_WATERMARK}
  PSH_WATERMARK           = $00008000;
  {$EXTERNALSYM PSH_USEHBMWATERMARK}
  PSH_USEHBMWATERMARK     = $00010000;  // user pass in a hbmWatermark instead of pszbmWatermark
  {$EXTERNALSYM PSH_USEHPLWATERMARK}
  PSH_USEHPLWATERMARK     = $00020000;  //
  {$EXTERNALSYM PSH_STRETCHWATERMARK}
  PSH_STRETCHWATERMARK    = $00040000;  // stretchwatermark also applies for the header
  {$EXTERNALSYM PSH_HEADER}
  PSH_HEADER              = $00080000;
  {$EXTERNALSYM PSH_USEHBMHEADER}
  PSH_USEHBMHEADER        = $00100000;
  {$EXTERNALSYM PSH_USEPAGELANG}
  PSH_USEPAGELANG         = $00200000;  // use frame dialog template matched to page

  { new flags for wizard-lite _WIN32_IE >= 0x0500 - IExplorer 5.0+ }
  {$EXTERNALSYM PSH_WIZARD_LITE}
  PSH_WIZARD_LITE         = $00400000;
  {$EXTERNALSYM PSH_NOCONTEXTHELP}
  PSH_NOCONTEXTHELP       = $02000000;

  {$EXTERNALSYM PSCB_INITIALIZED}
  PSCB_INITIALIZED  = 1;
  {$EXTERNALSYM PSCB_PRECREATE}
  PSCB_PRECREATE    = 2;

  {$EXTERNALSYM PSN_FIRST}
  PSN_FIRST               = 0 - 200;
  {$EXTERNALSYM PSN_LAST}
  PSN_LAST                = 0 - 299;

  {$EXTERNALSYM PSN_SETACTIVE}
  PSN_SETACTIVE           = PSN_FIRST - 0;
  {$EXTERNALSYM PSN_KILLACTIVE}
  PSN_KILLACTIVE          = PSN_FIRST - 1;
  {$EXTERNALSYM PSN_APPLY}
  PSN_APPLY               = PSN_FIRST - 2;
  {$EXTERNALSYM PSN_RESET}
  PSN_RESET               = PSN_FIRST - 3;
  {$EXTERNALSYM PSN_HELP}
  PSN_HELP                = PSN_FIRST - 5;
  {$EXTERNALSYM PSN_WIZBACK}
  PSN_WIZBACK             = PSN_FIRST - 6;
  {$EXTERNALSYM PSN_WIZNEXT}
  PSN_WIZNEXT             = PSN_FIRST - 7;
  {$EXTERNALSYM PSN_WIZFINISH}
  PSN_WIZFINISH           = PSN_FIRST - 8;
  {$EXTERNALSYM PSN_QUERYCANCEL}
  PSN_QUERYCANCEL         = PSN_FIRST - 9;
  {$EXTERNALSYM PSN_GETOBJECT}
  PSN_GETOBJECT           = PSN_FIRST - 10;

  { _WIN32_IE >= 0x0500 - IExplorer 5.0+ }
  {$EXTERNALSYM PSN_TRANSLATEACCELERATOR}
  PSN_TRANSLATEACCELERATOR= PSN_FIRST - 12;
  {$EXTERNALSYM PSN_QUERYINITIALFOCUS}
  PSN_QUERYINITIALFOCUS   = PSN_FIRST - 13;

  {$EXTERNALSYM PSNRET_NOERROR}
  PSNRET_NOERROR              = 0;
  {$EXTERNALSYM PSNRET_INVALID}
  PSNRET_INVALID              = 1;
  {$EXTERNALSYM PSNRET_INVALID_NOCHANGEPAGE}
  PSNRET_INVALID_NOCHANGEPAGE = 2;
  {$EXTERNALSYM PSNRET_MESSAGEHANDLED}
  PSNRET_MESSAGEHANDLED       = 3;

  {$EXTERNALSYM PSM_SETCURSEL}
  PSM_SETCURSEL           = WM_USER + 101;
  {$EXTERNALSYM PSM_REMOVEPAGE}
  PSM_REMOVEPAGE          = WM_USER + 102;
  {$EXTERNALSYM PSM_ADDPAGE}
  PSM_ADDPAGE             = WM_USER + 103;
  {$EXTERNALSYM PSM_CHANGED}
  PSM_CHANGED             = WM_USER + 104;
  {$EXTERNALSYM PSM_RESTARTWINDOWS}
  PSM_RESTARTWINDOWS      = WM_USER + 105;
  {$EXTERNALSYM PSM_REBOOTSYSTEM}
  PSM_REBOOTSYSTEM        = WM_USER + 106;
  {$EXTERNALSYM PSM_CANCELTOCLOSE}
  PSM_CANCELTOCLOSE       = WM_USER + 107;
  {$EXTERNALSYM PSM_QUERYSIBLINGS}
  PSM_QUERYSIBLINGS       = WM_USER + 108;
  {$EXTERNALSYM PSM_UNCHANGED}
  PSM_UNCHANGED           = WM_USER + 109;
  {$EXTERNALSYM PSM_APPLY}
  PSM_APPLY               = WM_USER + 110;
  {$EXTERNALSYM PSM_SETTITLEA}
  PSM_SETTITLEA           = WM_USER + 111;
  {$EXTERNALSYM PSM_SETTITLEW}
  PSM_SETTITLEW           = WM_USER + 120;
{$IFDEF UNICODE}
  {$EXTERNALSYM PSM_SETTITLE}
  PSM_SETTITLE            = PSM_SETTITLEW;
{$ELSE}
  {$EXTERNALSYM PSM_SETTITLE}
  PSM_SETTITLE            = PSM_SETTITLEA;
{$ENDIF}
  {$EXTERNALSYM PSM_SETWIZBUTTONS}
  PSM_SETWIZBUTTONS       = WM_USER + 112;

  {$EXTERNALSYM PSM_PRESSBUTTON}
  PSM_PRESSBUTTON         = WM_USER + 113;
  {$EXTERNALSYM PSM_SETCURSELID}
  PSM_SETCURSELID         = WM_USER + 114;
  {$EXTERNALSYM PSM_SETFINISHTEXTA}
  PSM_SETFINISHTEXTA      = WM_USER + 115;
  {$EXTERNALSYM PSM_SETFINISHTEXTW}
  PSM_SETFINISHTEXTW      = WM_USER + 121;
{$IFDEF UNICODE}
  {$EXTERNALSYM PSM_SETFINISHTEXT}
  PSM_SETFINISHTEXT       = PSM_SETFINISHTEXTW;
{$ELSE}
  {$EXTERNALSYM PSM_SETFINISHTEXT}
  PSM_SETFINISHTEXT       = PSM_SETFINISHTEXTA;
{$ENDIF}
  {$EXTERNALSYM PSM_GETTABCONTROL}
  PSM_GETTABCONTROL       = WM_USER + 116;
  {$EXTERNALSYM PSM_ISDIALOGMESSAGE}
  PSM_ISDIALOGMESSAGE     = WM_USER + 117;
  {$EXTERNALSYM PSM_GETCURRENTPAGEHWND}
  PSM_GETCURRENTPAGEHWND  = WM_USER + 118;
  {$EXTERNALSYM PSM_INSERTPAGE}
  PSM_INSERTPAGE          = WM_USER + 119;

  { _WIN32_IE >= 0x0500 IExplorer 5.0+ }
  {$EXTERNALSYM PSM_SETHEADERTITLEA}
  PSM_SETHEADERTITLEA     = WM_USER + 125;
  {$EXTERNALSYM PSM_SETHEADERTITLEW}
  PSM_SETHEADERTITLEW     = WM_USER + 126;
{$IFDEF UNICODE}
  {$EXTERNALSYM PSM_SETHEADERTITLE}
  PSM_SETHEADERTITLE      = PSM_SETHEADERTITLEW;
{$ELSE}
  {$EXTERNALSYM PSM_SETHEADERTITLE}
  PSM_SETHEADERTITLE      = PSM_SETHEADERTITLEA;
{$ENDIF}
  {$EXTERNALSYM PSM_SETHEADERSUBTITLEA}
  PSM_SETHEADERSUBTITLEA  = WM_USER + 127;
  {$EXTERNALSYM PSM_SETHEADERSUBTITLEW}
  PSM_SETHEADERSUBTITLEW  = WM_USER + 128;
{$IFDEF UNICODE}
  {$EXTERNALSYM PSM_SETHEADERSUBTITLE}
  PSM_SETHEADERSUBTITLE   = PSM_SETHEADERSUBTITLEW;
{$ELSE}
  {$EXTERNALSYM PSM_SETHEADERSUBTITLE}
  PSM_SETHEADERSUBTITLE   = PSM_SETHEADERSUBTITLEA;
{$ENDIF}
  {$EXTERNALSYM PSM_HWNDTOINDEX}
  PSM_HWNDTOINDEX         = WM_USER + 129;
  {$EXTERNALSYM PSM_INDEXTOHWND}
  PSM_INDEXTOHWND         = WM_USER + 130;
  {$EXTERNALSYM PSM_PAGETOINDEX}
  PSM_PAGETOINDEX         = WM_USER + 131;
  {$EXTERNALSYM PSM_INDEXTOPAGE}
  PSM_INDEXTOPAGE         = WM_USER + 132;
  {$EXTERNALSYM PSM_IDTOINDEX}
  PSM_IDTOINDEX           = WM_USER + 133;
  {$EXTERNALSYM PSM_INDEXTOID}
  PSM_INDEXTOID           = WM_USER + 134;
  {$EXTERNALSYM PSM_GETRESULT}
  PSM_GETRESULT           = WM_USER + 135;
  {$EXTERNALSYM PSM_RECALCPAGESIZES}
  PSM_RECALCPAGESIZES     = WM_USER + 136;

  { _WIN32_WINNT >= 0x0600 Windows Vista+ }
  { Only UNICODE }
  {$EXTERNALSYM PSM_SETNEXTTEXTW}
  PSM_SETNEXTTEXTW        = WM_USER + 137;
  {$EXTERNALSYM PSM_SETNEXTTEXT}
  PSM_SETNEXTTEXT         = PSM_SETNEXTTEXTW;
  {$EXTERNALSYM PSWIZB_SHOW}
  PSWIZB_SHOW             = 0;
  {$EXTERNALSYM PSWIZB_RESTORE}
  PSWIZB_RESTORE          = 1;
  {$EXTERNALSYM PSM_SHOWWIZBUTTONS}
  PSM_SHOWWIZBUTTONS      = WM_USER + 138;
  {$EXTERNALSYM PSM_ENABLEWIZBUTTONS}
  PSM_ENABLEWIZBUTTONS    = WM_USER + 139;
  {$EXTERNALSYM PSM_SETBUTTONTEXTW}
  PSM_SETBUTTONTEXTW      = WM_USER + 140;
  {$EXTERNALSYM PSM_SETBUTTONTEXT}
  PSM_SETBUTTONTEXT       = PSM_SETBUTTONTEXTW;

  {$EXTERNALSYM PSWIZB_BACK}
  PSWIZB_BACK             = $00000001;
  {$EXTERNALSYM PSWIZB_NEXT}
  PSWIZB_NEXT             = $00000002;
  {$EXTERNALSYM PSWIZB_FINISH}
  PSWIZB_FINISH           = $00000004;
  {$EXTERNALSYM PSWIZB_DISABLEDFINISH}
  PSWIZB_DISABLEDFINISH   = $00000008;

  {$EXTERNALSYM PSBTN_BACK}
  PSBTN_BACK              = 0;
  {$EXTERNALSYM PSBTN_NEXT}
  PSBTN_NEXT              = 1;
  {$EXTERNALSYM PSBTN_FINISH}
  PSBTN_FINISH            = 2;
  {$EXTERNALSYM PSBTN_OK}
  PSBTN_OK                = 3;
  {$EXTERNALSYM PSBTN_APPLYNOW}
  PSBTN_APPLYNOW          = 4;
  {$EXTERNALSYM PSBTN_CANCEL}
  PSBTN_CANCEL            = 5;
  {$EXTERNALSYM PSBTN_HELP}
  PSBTN_HELP              = 6;
  {$EXTERNALSYM PSBTN_MAX}
  PSBTN_MAX               = 6;

  {$EXTERNALSYM ID_PSRESTARTWINDOWS}
  ID_PSRESTARTWINDOWS     = 2;
  {$EXTERNALSYM ID_PSREBOOTSYSTEM}
  ID_PSREBOOTSYSTEM       = ID_PSRESTARTWINDOWS or 1;

  {$EXTERNALSYM WIZ_CXDLG}
  WIZ_CXDLG               = 276;
  {$EXTERNALSYM WIZ_CYDLG}
  WIZ_CYDLG               = 140;

  {$EXTERNALSYM WIZ_CXBMP}
  WIZ_CXBMP               = 80;

  {$EXTERNALSYM WIZ_BODYX}
  WIZ_BODYX               = 92;
  {$EXTERNALSYM WIZ_BODYCX}
  WIZ_BODYCX              = 184;

  {$EXTERNALSYM PROP_SM_CXDLG}
  PROP_SM_CXDLG           = 212;
  {$EXTERNALSYM PROP_SM_CYDLG}
  PROP_SM_CYDLG           = 188;

  {$EXTERNALSYM PROP_MED_CXDLG}
  PROP_MED_CXDLG          = 227;
  {$EXTERNALSYM PROP_MED_CYDLG}
  PROP_MED_CYDLG          = 215;

  {$EXTERNALSYM PROP_LG_CXDLG}
  PROP_LG_CXDLG           = 252;
  {$EXTERNALSYM PROP_LG_CYDLG}
  PROP_LG_CYDLG           = 218;

{$POINTERMATH ON}
type
  HPropSheetPage = Pointer;

  PPropSheetPageA = ^TPropSheetPageA;
  PPropSheetPageW = ^TPropSheetPageW;
  PPropSheetPage = PPropSheetPageW;

  {$EXTERNALSYM LPFNPSPCALLBACKA}
  LPFNPSPCALLBACKA = function(Wnd: HWND; Msg: Integer {UINT};
    PPSP: PPropSheetPageA): Integer {UINT} stdcall;
  {$EXTERNALSYM LPFNPSPCALLBACKW}
  LPFNPSPCALLBACKW = function(Wnd: HWND; Msg: Integer {UINT};
    PPSP: PPropSheetPageW): Integer {UINT} stdcall;
  {$EXTERNALSYM LPFNPSPCALLBACK}
  LPFNPSPCALLBACK = LPFNPSPCALLBACKW;
  TFNPSPCallbackA = LPFNPSPCALLBACKA;
  TFNPSPCallbackW = LPFNPSPCALLBACKW;
  TFNPSPCallback = TFNPSPCallbackW;

  {$EXTERNALSYM _PROPSHEETPAGEA}
  _PROPSHEETPAGEA = record
    dwSize: DWORD;
    dwFlags: DWORD;
    hInstance: HINST;
    case Integer of
      0: (
        pszTemplate: LPCSTR);
      1: (
        pResource: PDlgTemplate;
        case Integer of
          0: (
            hIcon: HICON);
          1: (
            pszIcon: LPCSTR;
            pszTitle: LPCSTR;
            pfnDlgProc: TFNDlgProc;
            lParam: LPARAM;
            pfnCallback: TFNPSPCallbackA;
            pcRefParent: PInteger; // PUINT
            pszHeaderTitle: LPCSTR;      // this is displayed in the header
            pszHeaderSubTitle: LPCSTR;   //
            hActCtx: THandle;             // Windows 5.1 or newer
            case Integer of               // Windows 6.0 or newer
              0: (
                hbmHeader: HBITMAP);
              1: (
                pszbmHeader: LPCSTR);
             )
         );
  end;
  {$EXTERNALSYM _PROPSHEETPAGEW}
  _PROPSHEETPAGEW = record
    dwSize: DWORD;
    dwFlags: DWORD;
    hInstance: HINST;
    case Integer of
      0: (
        pszTemplate: LPCWSTR);
      1: (
        pResource: PDlgTemplate;
        case Integer of
          0: (
            hIcon: HICON);
          1: (
            pszIcon: LPCWSTR;
            pszTitle: LPCWSTR;
            pfnDlgProc: TFNDlgProc;
            lParam: LPARAM;
            pfnCallback: TFNPSPCallbackW;
            pcRefParent: PInteger; // PUINT
            pszHeaderTitle: LPCWSTR;      // this is displayed in the header
            pszHeaderSubTitle: LPCWSTR;   //
            hActCtx: THandle;             // Windows 5.1 or newer
            case Integer of               // Windows 6.0 or newer
              0: (
                hbmHeader: HBITMAP);
              1: (
                pszbmHeader: LPCSTR);
             )
         );
  end;
  {$EXTERNALSYM _PROPSHEETPAGE}
  _PROPSHEETPAGE = _PROPSHEETPAGEW;
  TPropSheetPageA = _PROPSHEETPAGEA;
  TPropSheetPageW = _PROPSHEETPAGEW;
  TPropSheetPage = TPropSheetPageW;
  {$EXTERNALSYM PROPSHEETPAGEA}
  PROPSHEETPAGEA = _PROPSHEETPAGEA;
  {$EXTERNALSYM PROPSHEETPAGEW}
  PROPSHEETPAGEW = _PROPSHEETPAGEW;
  {$EXTERNALSYM PROPSHEETPAGE}
  PROPSHEETPAGE = PROPSHEETPAGEW;


  {$EXTERNALSYM PFNPROPSHEETCALLBACK}
  PFNPROPSHEETCALLBACK = function(Wnd: HWND; Msg: Integer {UINT};
    LParam: LPARAM): Integer {UINT} stdcall;
  TFNPropSheetCallback = PFNPROPSHEETCALLBACK;

  PPropSheetHeaderA = ^TPropSheetHeaderA;
  PPropSheetHeaderW = ^TPropSheetHeaderW;
  PPropSheetHeader = PPropSheetHeaderW;
  {$EXTERNALSYM _PROPSHEETHEADERA}
  _PROPSHEETHEADERA = record
    dwSize: DWORD;
    dwFlags: DWORD;
    hwndParent: HWND;
    hInstance: HINST;
    case Integer of
      0: (
        hIcon: HICON);
      1: (
        pszIcon: LPCSTR;
        pszCaption: LPCSTR;
        nPages: Integer; // UINT
        case Integer of
          0: (
            nStartPage: Integer);
          1: (
            pStartPage: LPCSTR;
            case Integer of
              0: (
                ppsp: PPropSheetPageA);
              1: (
                phpage: HPROPSHEETPAGE;
                pfnCallback: TFNPropSheetCallback;
                case Integer of
                  0: (
                    hbmWatermark: HBITMAP);
                  1: (
                    pszbmWatermark: LPCSTR;
                    hplWatermark: HPALETTE;
                    // Header bitmap shares the palette with watermark
                    case Integer of
                      0: (
                        hbmHeader: HBITMAP);
                      1: (
                        pszbmHeader: LPCSTR)))));
  end;
  {$EXTERNALSYM _PROPSHEETHEADERW}
  _PROPSHEETHEADERW = record
    dwSize: DWORD;
    dwFlags: DWORD;
    hwndParent: HWND;
    hInstance: HINST;
    case Integer of
      0: (
        hIcon: HICON);
      1: (
        pszIcon: LPCWSTR;
        pszCaption: LPCWSTR;
        nPages: Integer; // UINT
        case Integer of
          0: (
            nStartPage: Integer);
          1: (
            pStartPage: LPCWSTR;
            case Integer of
              0: (
                ppsp: PPropSheetPageW);
              1: (
                phpage: HPROPSHEETPAGE;
                pfnCallback: TFNPropSheetCallback;
                case Integer of
                  0: (
                    hbmWatermark: HBITMAP);
                  1: (
                    pszbmWatermark: LPCWSTR;
                    hplWatermark: HPALETTE;
                    // Header bitmap shares the palette with watermark
                    case Integer of
                      0: (
                        hbmHeader: HBITMAP);
                      1: (
                        pszbmHeader: LPCWSTR)))));
  end;
  {$EXTERNALSYM _PROPSHEETHEADER}
  _PROPSHEETHEADER = _PROPSHEETHEADERW;
  TPropSheetHeaderA = _PROPSHEETHEADERA;
  TPropSheetHeaderW = _PROPSHEETHEADERW;
  TPropSheetHeader = TPropSheetHeaderW;

  {$EXTERNALSYM LPFNADDPROPSHEETPAGE}
  LPFNADDPROPSHEETPAGE = function(hPSP: HPropSheetPage;
    lParam: LPARAM): BOOL stdcall;
  TFNAddPropSheetPage = LPFNADDPROPSHEETPAGE;

  {$EXTERNALSYM LPFNADDPROPSHEETPAGES}
  LPFNADDPROPSHEETPAGES = function(lpvoid: Pointer; pfn: TFNAddPropSheetPage;
    lParam: LPARAM): BOOL stdcall;
  TFNAddPropSheetPages = LPFNADDPROPSHEETPAGES;

{$EXTERNALSYM CreatePropertySheetPage}
function CreatePropertySheetPage(var PSP: TPropSheetPage): HPropSheetPage; stdcall;
{$EXTERNALSYM CreatePropertySheetPageA}
function CreatePropertySheetPageA(var PSP: TPropSheetPageA): HPropSheetPage; stdcall;
{$EXTERNALSYM CreatePropertySheetPageW}
function CreatePropertySheetPageW(var PSP: TPropSheetPageW): HPropSheetPage; stdcall;
{$EXTERNALSYM DestroyPropertySheetPage}
function DestroyPropertySheetPage(hPSP: HPropSheetPage): BOOL; stdcall;
{$EXTERNALSYM PropertySheet}
function PropertySheet(var PSH: TPropSheetHeader): Integer; stdcall;
{$EXTERNALSYM PropertySheetA}
function PropertySheetA(var PSH: TPropSheetHeaderA): Integer; stdcall;
{$EXTERNALSYM PropertySheetW}
function PropertySheetW(var PSH: TPropSheetHeaderW): Integer; stdcall;

{ From commctrl.h }

type
  {$EXTERNALSYM tagINITCOMMONCONTROLSEX}
  tagINITCOMMONCONTROLSEX = record
    dwSize: DWORD;             // size of this structure
    dwICC: DWORD;              // flags indicating which classes to be initialized
  end;
  PInitCommonControlsEx = ^TInitCommonControlsEx;
  TInitCommonControlsEx = tagINITCOMMONCONTROLSEX;
  
const
  {$EXTERNALSYM ICC_LISTVIEW_CLASSES}
  ICC_LISTVIEW_CLASSES   = $00000001; // listview, header
  {$EXTERNALSYM ICC_TREEVIEW_CLASSES}
  ICC_TREEVIEW_CLASSES   = $00000002; // treeview, tooltips
  {$EXTERNALSYM ICC_BAR_CLASSES}
  ICC_BAR_CLASSES        = $00000004; // toolbar, statusbar, trackbar, tooltips
  {$EXTERNALSYM ICC_TAB_CLASSES}
  ICC_TAB_CLASSES        = $00000008; // tab, tooltips
  {$EXTERNALSYM ICC_UPDOWN_CLASS}
  ICC_UPDOWN_CLASS       = $00000010; // updown
  {$EXTERNALSYM ICC_PROGRESS_CLASS}
  ICC_PROGRESS_CLASS     = $00000020; // progress
  {$EXTERNALSYM ICC_HOTKEY_CLASS}
  ICC_HOTKEY_CLASS       = $00000040; // hotkey
  {$EXTERNALSYM ICC_ANIMATE_CLASS}
  ICC_ANIMATE_CLASS      = $00000080; // animate
  {$EXTERNALSYM ICC_WIN95_CLASSES}
  ICC_WIN95_CLASSES      = $000000FF;
  {$EXTERNALSYM ICC_DATE_CLASSES}
  ICC_DATE_CLASSES       = $00000100; // month picker, date picker, time picker, updown
  {$EXTERNALSYM ICC_USEREX_CLASSES}
  ICC_USEREX_CLASSES     = $00000200; // comboex
  {$EXTERNALSYM ICC_COOL_CLASSES}
  ICC_COOL_CLASSES       = $00000400; // rebar (coolbar) control
  {$EXTERNALSYM ICC_INTERNET_CLASSES}
  ICC_INTERNET_CLASSES   = $00000800;
  {$EXTERNALSYM ICC_PAGESCROLLER_CLASS}
  ICC_PAGESCROLLER_CLASS = $00001000; // page scroller
  {$EXTERNALSYM ICC_NATIVEFNTCTL_CLASS}
  ICC_NATIVEFNTCTL_CLASS = $00002000; // native font control
  { For Windows >= XP }
  {$EXTERNALSYM ICC_STANDARD_CLASSES}
  ICC_STANDARD_CLASSES   = $00004000;
  {$EXTERNALSYM ICC_LINK_CLASS}
  ICC_LINK_CLASS         = $00008000;

{$EXTERNALSYM InitCommonControls}
procedure InitCommonControls; stdcall;
{$EXTERNALSYM InitCommonControlsEx}
function InitCommonControlsEx(var ICC: TInitCommonControlsEx): Bool; { Re-defined below }

const
  {$EXTERNALSYM IMAGE_BITMAP}
  IMAGE_BITMAP = 0;

const
  {$EXTERNALSYM ODT_HEADER}
  ODT_HEADER              = 100;
  {$EXTERNALSYM ODT_TAB}
  ODT_TAB                 = 101;
  {$EXTERNALSYM ODT_LISTVIEW}
  ODT_LISTVIEW            = 102;


{ ====== Ranges for control message IDs ======================= }

const
  {$EXTERNALSYM LVM_FIRST}
  LVM_FIRST               = $1000;      { ListView messages }
  {$EXTERNALSYM TV_FIRST}
  TV_FIRST                = $1100;      { TreeView messages }
  {$EXTERNALSYM HDM_FIRST}
  HDM_FIRST               = $1200;      { Header messages }
  {$EXTERNALSYM TCM_FIRST}
  TCM_FIRST               = $1300;      { Tab control messages }
  {$EXTERNALSYM PGM_FIRST}
  PGM_FIRST               = $1400;      { Pager control messages }
  { For Windows >= XP }
  {$EXTERNALSYM ECM_FIRST}
  ECM_FIRST               = $1500;      { Edit control messages }
  {$EXTERNALSYM BCM_FIRST}
  BCM_FIRST               = $1600;      { Button control messages }
  {$EXTERNALSYM CBM_FIRST}
  CBM_FIRST               = $1700;      { Combobox control messages }

  {$EXTERNALSYM CCM_FIRST}
  CCM_FIRST               = $2000;      { Common control shared messages }
  {$EXTERNALSYM CCM_LAST}
  CCM_LAST                = CCM_FIRST + $200;

  {$EXTERNALSYM CCM_SETBKCOLOR}
  CCM_SETBKCOLOR          = CCM_FIRST + 1; // lParam is bkColor

type
  {$EXTERNALSYM tagCOLORSCHEME}
  tagCOLORSCHEME = record
    dwSize: DWORD;
    clrBtnHighlight: COLORREF;    // highlight color
    clrBtnShadow: COLORREF;       // shadow color
  end;
  PColorScheme = ^TColorScheme;
  TColorScheme = tagCOLORSCHEME;

const
  {$EXTERNALSYM CCM_SETCOLORSCHEME}
  CCM_SETCOLORSCHEME      = CCM_FIRST + 2; // lParam is color scheme
  {$EXTERNALSYM CCM_GETCOLORSCHEME}
  CCM_GETCOLORSCHEME      = CCM_FIRST + 3; // fills in COLORSCHEME pointed to by lParam
  {$EXTERNALSYM CCM_GETDROPTARGET}
  CCM_GETDROPTARGET       = CCM_FIRST + 4;
  {$EXTERNALSYM CCM_SETUNICODEFORMAT}
  CCM_SETUNICODEFORMAT    = CCM_FIRST + 5;
  {$EXTERNALSYM CCM_GETUNICODEFORMAT}
  CCM_GETUNICODEFORMAT    = CCM_FIRST + 6;
  {$EXTERNALSYM CCM_SETVERSION}
  CCM_SETVERSION          = CCM_FIRST + $7;
  {$EXTERNALSYM CCM_GETVERSION}
  CCM_GETVERSION          = CCM_FIRST + $8;
  {$EXTERNALSYM CCM_SETNOTIFYWINDOW}
  CCM_SETNOTIFYWINDOW     = CCM_FIRST + $9;   { wParam == hwndParent. }
  { For Windows >= XP }
  {$EXTERNALSYM CCM_SETWINDOWTHEME}
  CCM_SETWINDOWTHEME      = CCM_FIRST + $B;
  {$EXTERNALSYM CCM_DPISCALE}
  CCM_DPISCALE            = CCM_FIRST + $C;   { wParam == Awareness }

  {$EXTERNALSYM INFOTIPSIZE}
  INFOTIPSIZE = 1024;  // for tooltips

{ ====== WM_NOTIFY codes (NMHDR.code values) ================== }

const
  {$EXTERNALSYM NM_FIRST}
  NM_FIRST                 = 0-  0;       { generic to all controls }
  {$EXTERNALSYM NM_LAST}
  NM_LAST                  = 0- 99;

  {$EXTERNALSYM LVN_FIRST}
  LVN_FIRST                = 0-100;       { listview }
  {$EXTERNALSYM LVN_LAST}
  LVN_LAST                 = 0-199;

  {$EXTERNALSYM HDN_FIRST}
  HDN_FIRST                = 0-300;       { header }
  {$EXTERNALSYM HDN_LAST}
  HDN_LAST                 = 0-399;

  {$EXTERNALSYM TVN_FIRST}
  TVN_FIRST                = 0-400;       { treeview }
  {$EXTERNALSYM TVN_LAST}
  TVN_LAST                 = 0-499;

  {$EXTERNALSYM TTN_FIRST}
  TTN_FIRST                = 0-520;       { tooltips }
  {$EXTERNALSYM TTN_LAST}
  TTN_LAST                 = 0-549;

  {$EXTERNALSYM TCN_FIRST}
  TCN_FIRST                = 0-550;       { tab control }
  {$EXTERNALSYM TCN_LAST}
  TCN_LAST                 = 0-580;

{ Shell reserved           (0-580) -  (0-589) }

  {$EXTERNALSYM CDN_FIRST}
  CDN_FIRST                = 0-601;       { common dialog (new) }
  {$EXTERNALSYM CDN_LAST}
  CDN_LAST                 = 0-699;

  {$EXTERNALSYM TBN_FIRST}
  TBN_FIRST                = 0-700;       { toolbar }
  {$EXTERNALSYM TBN_LAST}
  TBN_LAST                 = 0-720;

  {$EXTERNALSYM UDN_FIRST}
  UDN_FIRST                = 0-721;       { updown }
  {$EXTERNALSYM UDN_LAST}
  UDN_LAST                 = 0-729;

  { _WIN32_IE >= 0x0300 - IExplorer 3.0+ }
  {$EXTERNALSYM DTN_FIRST}
  DTN_FIRST                = 0-740;       { datetimepick }
  {$EXTERNALSYM DTN_LAST}
  DTN_LAST                 = 0-745;       { DTN_FIRST - 5 }
  {$EXTERNALSYM MCN_FIRST}
  MCN_FIRST     	           = 0-746;       { monthcal }
  {$EXTERNALSYM MCN_LAST}
  MCN_LAST                 = 0-752;       { MCN_FIRST - 6 }
  {$EXTERNALSYM DTN_FIRST2}
  DTN_FIRST2                = 0-753;       { datetimepick2 }
  {$EXTERNALSYM DTN_LAST2}
  DTN_LAST2                 = 0-799;
  {$EXTERNALSYM CBEN_FIRST}
  CBEN_FIRST               = 0-800;       { combo box ex }
  {$EXTERNALSYM CBEN_LAST}
  CBEN_LAST                = 0-830;
  {$EXTERNALSYM RBN_FIRST}
  RBN_FIRST                = 0-831;       { coolbar }
  {$EXTERNALSYM RBN_LAST}
  RBN_LAST                 = 0-859;

  { _WIN32_IE >= 0x0400 - IExplorer 4.0+ }
  {$EXTERNALSYM IPN_FIRST}
  IPN_FIRST               = 0-860;       { internet address }
  {$EXTERNALSYM IPN_LAST}
  IPN_LAST                = 0-879;       { internet address }
  {$EXTERNALSYM SBN_FIRST}
  SBN_FIRST               = 0-880;       { status bar }
  {$EXTERNALSYM SBN_LAST}
  SBN_LAST                = 0-899;
  {$EXTERNALSYM PGN_FIRST}
  PGN_FIRST               = 0-900;       { Pager Control }
  {$EXTERNALSYM PGN_LAST}
  PGN_LAST                = 0-950;

  { _WIN32_IE >= 0x0500 - IExplorer 5.0+ }
  {$EXTERNALSYM WMN_FIRST}
  WMN_FIRST               = 0-1000;
  {$EXTERNALSYM WMN_LAST}
  WMN_LAST                = 0-1200;

  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM BCN_FIRST}
  BCN_FIRST               = 0-1250;
  {$EXTERNALSYM BCN_LAST}
  BCN_LAST                = 0-1350;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM TRBN_FIRST}
  TRBN_FIRST              = 0-1501;          { trackbar }
  {$EXTERNALSYM TRBN_LAST}
  TRBN_LAST               = 0-1519;

  {$EXTERNALSYM MSGF_COMMCTRL_BEGINDRAG}
  MSGF_COMMCTRL_BEGINDRAG     = $4200;
  {$EXTERNALSYM MSGF_COMMCTRL_SIZEHEADER}
  MSGF_COMMCTRL_SIZEHEADER    = $4201;
  {$EXTERNALSYM MSGF_COMMCTRL_DRAGSELECT}
  MSGF_COMMCTRL_DRAGSELECT    = $4202;
  {$EXTERNALSYM MSGF_COMMCTRL_TOOLBARCUST}
  MSGF_COMMCTRL_TOOLBARCUST   = $4203;


{ ====== Generic WM_NOTIFY notification codes ================= }

const
  {$EXTERNALSYM NM_OUTOFMEMORY}
  NM_OUTOFMEMORY           = NM_FIRST-1;
  {$EXTERNALSYM NM_CLICK}
  NM_CLICK                 = NM_FIRST-2;
  {$EXTERNALSYM NM_DBLCLK}
  NM_DBLCLK                = NM_FIRST-3;
  {$EXTERNALSYM NM_RETURN}
  NM_RETURN                = NM_FIRST-4;
  {$EXTERNALSYM NM_RCLICK}
  NM_RCLICK                = NM_FIRST-5;
  {$EXTERNALSYM NM_RDBLCLK}
  NM_RDBLCLK               = NM_FIRST-6;
  {$EXTERNALSYM NM_SETFOCUS}
  NM_SETFOCUS              = NM_FIRST-7;
  {$EXTERNALSYM NM_KILLFOCUS}
  NM_KILLFOCUS             = NM_FIRST-8;
  
{ _WIN32_IE >= 0x0300 IExplorer 3.0+ }
  {$EXTERNALSYM NM_CUSTOMDRAW}
  NM_CUSTOMDRAW            = NM_FIRST-12;
  {$EXTERNALSYM NM_HOVER}
  NM_HOVER                 = NM_FIRST-13;

  { _WIN32_IE >= 0x0400 IExplorer 4.0+ }
  {$EXTERNALSYM NM_NCHITTEST}
  NM_NCHITTEST             = NM_FIRST-14;   // uses NMMOUSE struct
  {$EXTERNALSYM NM_KEYDOWN}
  NM_KEYDOWN               = NM_FIRST-15;   // uses NMKEY struct
  {$EXTERNALSYM NM_RELEASEDCAPTURE}
  NM_RELEASEDCAPTURE       = NM_FIRST-16;
  {$EXTERNALSYM NM_SETCURSOR}
  NM_SETCURSOR             = NM_FIRST-17;   // uses NMMOUSE struct
  {$EXTERNALSYM NM_CHAR}
  NM_CHAR                  = NM_FIRST-18;   // uses NMCHAR struct

  { _WIN32_IE >= 0x0401 IExplorer 4.01+ }
  {$EXTERNALSYM NM_TOOLTIPSCREATED}
  NM_TOOLTIPSCREATED       = NM_FIRST-19;    { notify of when the tooltips window is create }

  { _WIN32_IE >= 0x0500 IExplorer 5.0+ }
  {$EXTERNALSYM NM_LDOWN}
  NM_LDOWN                 = NM_FIRST-20;
  {$EXTERNALSYM NM_RDOWN}
  NM_RDOWN                 = NM_FIRST-21;
  {$EXTERNALSYM NM_THEMECHANGED}
  NM_THEMECHANGED          = NM_FIRST-22;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM NM_FONTCHANGED}
  NM_FONTCHANGED          = NM_FIRST-23;
  {$EXTERNALSYM NM_CUSTOMTEXT}
  NM_CUSTOMTEXT           = NM_FIRST-24;    { uses NMCUSTOMTEXT struct }
  {$EXTERNALSYM NM_TVSTATEIMAGECHANGING}
  NM_TVSTATEIMAGECHANGING = NM_FIRST-24;    { uses NMTVSTATEIMAGECHANGING struct, defined after HTREEITEM }

type
  {$EXTERNALSYM tagNMMOUSE}
  tagNMMOUSE = record
    hdr: TNMHdr;
    dwItemSpec: DWORD_PTR;
    dwItemData: DWORD_PTR;
    pt: TPoint;
    dwHitInfo: LPARAM; // any specifics about where on the item or control the mouse is
  end;
  PNMMouse = ^TNMMouse;
  TNMMouse = tagNMMOUSE;

  PNMClick = ^TNMClick;
  TNMClick = tagNMMOUSE;

  // Generic structure to request an object of a specific type.
  {$EXTERNALSYM tagNMOBJECTNOTIFY}
  tagNMOBJECTNOTIFY = record
    hdr: TNMHdr;
    iItem: Integer;
    piid: PGUID;
    pObject: Pointer; // IUnknown
    hResult: HRESULT;
    dwFlags: DWORD;    // control specific flags (hints as to where in iItem it hit)
  end;
  PNMObjectNotify = ^TNMObjectNotify;
  TNMObjectNotify = tagNMOBJECTNOTIFY;

  // Generic structure for a key
  {$EXTERNALSYM tagNMKEY}
  tagNMKEY = record
    hdr: TNMHdr;
    nVKey: UINT;
    uFlags: UINT;
  end;
  PNMKey = ^TNMKey;
  TNMKey = tagNMKEY;

  // Generic structure for a character
  {$EXTERNALSYM tagNMCHAR}
  tagNMCHAR = record
    hdr: TNMHdr;
    ch: UINT;
    dwItemPrev: DWORD;     // Item previously selected
    dwItemNext: DWORD;     // Item to be selected
  end;
  PNMChar = ^TNMChar;
  TNMChar = tagNMCHAR;

  { For IE >= 0x0600 }
  { $EXTERNALSYM tagNMCUSTOMTEXT}
  tagNMCUSTOMTEXT = record
    hdr: NMHDR;
    hDC: HDC;
    lpString: LPCWSTR;
    nCount: Integer;
    lpRect: PRect;
    uFormat: UINT;
    fLink: BOOL;
  end;
  PNMCustomText = ^TNMCustomText;
  TNMCustomText = tagNMCUSTOMTEXT;

{ ==================== CUSTOM DRAW ========================================== }

const
  // custom draw return flags
  // values under 0x00010000 are reserved for global custom draw values.
  // above that are for specific controls
  {$EXTERNALSYM CDRF_DODEFAULT}
  CDRF_DODEFAULT          = $00000000;
  {$EXTERNALSYM CDRF_NEWFONT}
  CDRF_NEWFONT            = $00000002;
  {$EXTERNALSYM CDRF_SKIPDEFAULT}
  CDRF_SKIPDEFAULT        = $00000004;
  {$EXTERNALSYM CDRF_DOERASE}
  CDRF_DOERASE            = $00000008; { draw the background }
  {$EXTERNALSYM CDRF_SKIPPOSTPAINT}
  CDRF_SKIPPOSTPAINT      = $00000100; { don't draw the focus rect }

  {$EXTERNALSYM CDRF_NOTIFYPOSTPAINT}
  CDRF_NOTIFYPOSTPAINT    = $00000010;
  {$EXTERNALSYM CDRF_NOTIFYITEMDRAW}
  CDRF_NOTIFYITEMDRAW     = $00000020;

  { _WIN32_IE >= 0x0400 IExplorer 4.0+ }
  {$EXTERNALSYM CDRF_NOTIFYSUBITEMDRAW}
  CDRF_NOTIFYSUBITEMDRAW  = $00000020;  // flags are the same, we can distinguish by context
  {$EXTERNALSYM CDRF_NOTIFYPOSTERASE}
  CDRF_NOTIFYPOSTERASE    = $00000040;

  // drawstage flags
  // values under = $00010000 are reserved for global custom draw values.
  // above that are for specific controls
  {$EXTERNALSYM CDDS_PREPAINT}
  CDDS_PREPAINT           = $00000001;
  {$EXTERNALSYM CDDS_POSTPAINT}
  CDDS_POSTPAINT          = $00000002;
  {$EXTERNALSYM CDDS_PREERASE}
  CDDS_PREERASE           = $00000003;
  {$EXTERNALSYM CDDS_POSTERASE}
  CDDS_POSTERASE          = $00000004;
  // the = $000010000 bit means it's individual item specific
  {$EXTERNALSYM CDDS_ITEM}
  CDDS_ITEM               = $00010000;
  {$EXTERNALSYM CDDS_ITEMPREPAINT}
  CDDS_ITEMPREPAINT       = CDDS_ITEM or CDDS_PREPAINT;
  {$EXTERNALSYM CDDS_ITEMPOSTPAINT}
  CDDS_ITEMPOSTPAINT      = CDDS_ITEM or CDDS_POSTPAINT;
  {$EXTERNALSYM CDDS_ITEMPREERASE}
  CDDS_ITEMPREERASE       = CDDS_ITEM or CDDS_PREERASE;
  {$EXTERNALSYM CDDS_ITEMPOSTERASE}
  CDDS_ITEMPOSTERASE      = CDDS_ITEM or CDDS_POSTERASE;
  {$EXTERNALSYM CDDS_SUBITEM}
  CDDS_SUBITEM            = $00020000;

  // itemState flags
  {$EXTERNALSYM CDIS_SELECTED}
  CDIS_SELECTED       = $0001;
  {$EXTERNALSYM CDIS_GRAYED}
  CDIS_GRAYED         = $0002;
  {$EXTERNALSYM CDIS_DISABLED}
  CDIS_DISABLED       = $0004;
  {$EXTERNALSYM CDIS_CHECKED}
  CDIS_CHECKED        = $0008;
  {$EXTERNALSYM CDIS_FOCUS}
  CDIS_FOCUS          = $0010;
  {$EXTERNALSYM CDIS_DEFAULT}
  CDIS_DEFAULT        = $0020;
  {$EXTERNALSYM CDIS_HOT}
  CDIS_HOT            = $0040;
  {$EXTERNALSYM CDIS_MARKED}
  CDIS_MARKED         = $0080;
  {$EXTERNALSYM CDIS_INDETERMINATE}
  CDIS_INDETERMINATE  = $0100;
  { For Windows >= XP }
  {$EXTERNALSYM CDIS_SHOWKEYBOARDCUES}
  CDIS_SHOWKEYBOARDCUES = $0200;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM CDIS_NEARHOT}
  CDIS_NEARHOT          = $0400;
  {$EXTERNALSYM CDIS_OTHERSIDEHOT}
  CDIS_OTHERSIDEHOT     = $0800;
  {$EXTERNALSYM CDIS_DROPHILITED}
  CDIS_DROPHILITED      = $1000;

type
  {$EXTERNALSYM tagNMCUSTOMDRAWINFO}
  tagNMCUSTOMDRAWINFO = record
    hdr: TNMHdr;
    dwDrawStage: DWORD;
    hdc: HDC;
    rc: TRect;
    dwItemSpec: DWORD_PTR;  // this is control specific, but it's how to specify an item.  valid only with CDDS_ITEM bit set
    uItemState: UINT;
    lItemlParam: LPARAM;
  end;
  PNMCustomDraw = ^TNMCustomDraw;
  TNMCustomDraw = tagNMCUSTOMDRAWINFO;

  {$EXTERNALSYM tagNMTTCUSTOMDRAW}
  tagNMTTCUSTOMDRAW = record
    nmcd: TNMCustomDraw;
    uDrawFlags: UINT;
  end;
  PNMTTCustomDraw = ^TNMTTCustomDraw;
  TNMTTCustomDraw = tagNMTTCUSTOMDRAW;

  {$EXTERNALSYM tagNMCUSTOMSPLITRECTINFO}
  tagNMCUSTOMSPLITRECTINFO = record
    hdr: TNMHdr;
    rcClient: TRect;
    rcButton: TRect;
    rcSplit: TRect;
  end;
  PNMCustomSplitRectInfo = ^TNMCustomSplitRectInfo;
  TNMCustomSplitRectInfo = tagNMCUSTOMSPLITRECTINFO;

const
  {$EXTERNALSYM NM_GETCUSTOMSPLITRECT}
  NM_GETCUSTOMSPLITRECT = BCN_FIRST + $0003;

{ ====== IMAGE LIST =========================================== }

const
  {$EXTERNALSYM CLR_NONE}
  CLR_NONE                = $FFFFFFFF;
  {$EXTERNALSYM CLR_DEFAULT}
  CLR_DEFAULT             = $FF000000;

type
  {$EXTERNALSYM HIMAGELIST}
  HIMAGELIST = THandle;

  {$EXTERNALSYM _IMAGELISTDRAWPARAMS}
  _IMAGELISTDRAWPARAMS = record
    cbSize: DWORD;
    himl: HIMAGELIST;
    i: Integer;
    hdcDst: HDC;
    x: Integer;
    y: Integer;
    cx: Integer;
    cy: Integer;
    xBitmap: Integer;        // x offest from the upperleft of bitmap
    yBitmap: Integer;        // y offset from the upperleft of bitmap
    rgbBk: COLORREF;
    rgbFg: COLORREF;
    fStyle: UINT;
    dwRop: DWORD;
    { For IE >= 0x0501 }
    fState: DWORD;
    Frame: DWORD;
    crEffect: COLORREF;
  end;
  PImageListDrawParams = ^TImageListDrawParams;
  TImageListDrawParams = _IMAGELISTDRAWPARAMS;

const
  {$EXTERNALSYM ILC_MASK}
  ILC_MASK                = $0001;
  {$EXTERNALSYM ILC_COLOR}
  ILC_COLOR               = $0000;
  {$EXTERNALSYM ILC_COLORDDB}
  ILC_COLORDDB            = $00FE;
  {$EXTERNALSYM ILC_COLOR4}
  ILC_COLOR4              = $0004;
  {$EXTERNALSYM ILC_COLOR8}
  ILC_COLOR8              = $0008;
  {$EXTERNALSYM ILC_COLOR16}
  ILC_COLOR16             = $0010;
  {$EXTERNALSYM ILC_COLOR24}
  ILC_COLOR24             = $0018;
  {$EXTERNALSYM ILC_COLOR32}
  ILC_COLOR32             = $0020;
  {$EXTERNALSYM ILC_PALETTE}
  ILC_PALETTE             = $0800;

  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM ILC_MIRROR}
  ILC_MIRROR              = $00002000;      { Mirror the icons contained, if the process is mirrored }
  {$EXTERNALSYM ILC_PERITEMMIRROR}
  ILC_PERITEMMIRROR       = $00008000;      { Causes the mirroring code to mirror each item when inserting a set of images, verses the whole strip }

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM ILC_ORIGINALSIZE}
  ILC_ORIGINALSIZE        = $00010000;      { Imagelist should accept smaller than set images and apply OriginalSize based on image added }
  {$EXTERNALSYM ILC_HIGHQUALITYSCALE}
  ILC_HIGHQUALITYSCALE    = $00020000;      { Imagelist should enable use of the high quality scaler. }

{$EXTERNALSYM ImageList_Create}
function ImageList_Create(CX, CY: Integer; Flags: UINT;
  Initial, Grow: Integer): HIMAGELIST; stdcall;
{$EXTERNALSYM ImageList_Destroy}
function ImageList_Destroy(ImageList: HIMAGELIST): Bool; stdcall;
{$EXTERNALSYM ImageList_GetImageCount}
function ImageList_GetImageCount(ImageList: HIMAGELIST): Integer; stdcall;
{$EXTERNALSYM ImageList_SetImageCount}
function ImageList_SetImageCount(himl: HIMAGELIST; uNewCount: UINT): Integer; stdcall;
{$EXTERNALSYM ImageList_Add}
function ImageList_Add(ImageList: HIMAGELIST; Image, Mask: HBitmap): Integer; stdcall;
{$EXTERNALSYM ImageList_ReplaceIcon}
function ImageList_ReplaceIcon(ImageList: HIMAGELIST; Index: Integer;
  Icon: HIcon): Integer; stdcall;
{$EXTERNALSYM ImageList_SetBkColor}
function ImageList_SetBkColor(ImageList: HIMAGELIST; ClrBk: TColorRef): TColorRef; stdcall;
{$EXTERNALSYM ImageList_GetBkColor}
function ImageList_GetBkColor(ImageList: HIMAGELIST): TColorRef; stdcall;
{$EXTERNALSYM ImageList_SetOverlayImage}
function ImageList_SetOverlayImage(ImageList: HIMAGELIST; Image: Integer;
  Overlay: Integer): Bool; stdcall;

{$EXTERNALSYM ImageList_AddIcon}
function ImageList_AddIcon(ImageList: HIMAGELIST; Icon: HIcon): Integer; inline;

const
  {$EXTERNALSYM ILD_NORMAL}
  ILD_NORMAL              = $0000;
  {$EXTERNALSYM ILD_TRANSPARENT}
  ILD_TRANSPARENT         = $0001;
  {$EXTERNALSYM ILD_MASK}
  ILD_MASK                = $0010;
  {$EXTERNALSYM ILD_IMAGE}
  ILD_IMAGE               = $0020;
  {$EXTERNALSYM ILD_ROP}
  ILD_ROP                 = $0040;
  {$EXTERNALSYM ILD_BLEND25}
  ILD_BLEND25             = $0002;
  {$EXTERNALSYM ILD_BLEND50}
  ILD_BLEND50             = $0004;
  {$EXTERNALSYM ILD_OVERLAYMASK}
  ILD_OVERLAYMASK         = $0F00;
  {$EXTERNALSYM ILD_PRESERVEALPHA}
  ILD_PRESERVEALPHA       = $00001000;  // This preserves the alpha channel in dest
  {$EXTERNALSYM ILD_SCALE}
  ILD_SCALE               = $00002000;  // Causes the image to be scaled to cx, cy instead of clipped
  {$EXTERNALSYM ILD_DPISCALE}
  ILD_DPISCALE            = $00004000;
  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM ILD_ASYNC}
  ILD_ASYNC               = $00008000;

{$EXTERNALSYM IndexToOverlayMask}
function IndexToOverlayMask(Index: Integer): Integer; inline;

const
  {$EXTERNALSYM ILD_SELECTED}
  ILD_SELECTED            = ILD_BLEND50;
  {$EXTERNALSYM ILD_FOCUS}
  ILD_FOCUS               = ILD_BLEND25;
  {$EXTERNALSYM ILD_BLEND}
  ILD_BLEND               = ILD_BLEND50;
  {$EXTERNALSYM CLR_HILIGHT}
  CLR_HILIGHT             = CLR_DEFAULT;

  {$EXTERNALSYM ILS_NORMAL}
  ILS_NORMAL              = $00000000;
  {$EXTERNALSYM ILS_GLOW}
  ILS_GLOW                = $00000001;
  {$EXTERNALSYM ILS_SHADOW}
  ILS_SHADOW              = $00000002;
  {$EXTERNALSYM ILS_SATURATE}
  ILS_SATURATE            = $00000004;
  {$EXTERNALSYM ILS_ALPHA}
  ILS_ALPHA               = $00000008;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM ILGT_NORMAL}
  ILGT_NORMAL             = $00000000;
  {$EXTERNALSYM ILGT_ASYNC}
  ILGT_ASYNC              = $00000001;

{$EXTERNALSYM ImageList_Draw}
function ImageList_Draw(ImageList: HIMAGELIST; Index: Integer;
  Dest: HDC; X, Y: Integer; Style: UINT): Bool; stdcall;

const
  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HBITMAP_CALLBACK}
  HBITMAP_CALLBACK               = HBITMAP(-1);     // only for SparseImageList

{$EXTERNALSYM ImageList_Replace}
function ImageList_Replace(ImageList: HIMAGELIST; Index: Integer;
  Image, Mask: HBitmap): Bool; stdcall;
{$EXTERNALSYM ImageList_AddMasked}
function ImageList_AddMasked(ImageList: HIMAGELIST; Image: HBitmap;
  Mask: TColorRef): Integer; stdcall;
{$EXTERNALSYM ImageList_DrawEx}
function ImageList_DrawEx(ImageList: HIMAGELIST; Index: Integer;
  Dest: HDC; X, Y, DX, DY: Integer; Bk, Fg: TColorRef; Style: UINT): Bool; stdcall;
{$EXTERNALSYM ImageList_DrawIndirect}
function ImageList_DrawIndirect(pimldp: PImageListDrawParams): Bool; stdcall;
{$EXTERNALSYM ImageList_Remove}
function ImageList_Remove(ImageList: HIMAGELIST; Index: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_GetIcon}
function ImageList_GetIcon(ImageList: HIMAGELIST; Index: Integer;
  Flags: UINT): HIcon; stdcall;
{$EXTERNALSYM ImageList_LoadImage}
function ImageList_LoadImage(Instance: HINST; Bmp: LPCWSTR; CX, Grow: Integer;
  Mask: TColorRef; pType, Flags: UINT): HIMAGELIST; stdcall;
{$EXTERNALSYM ImageList_LoadImageA}
function ImageList_LoadImageA(Instance: HINST; Bmp: LPCSTR; CX, Grow: Integer;
  Mask: TColorRef; pType, Flags: UINT): HIMAGELIST; stdcall;
{$EXTERNALSYM ImageList_LoadImageW}
function ImageList_LoadImageW(Instance: HINST; Bmp: LPCWSTR; CX, Grow: Integer;
  Mask: TColorRef; pType, Flags: UINT): HIMAGELIST; stdcall;

const
  { _WIN32_IE >= 0x0300 IExplorer 3.0+ }
  {$EXTERNALSYM ILCF_MOVE}
  ILCF_MOVE   = $00000000;
  {$EXTERNALSYM ILCF_SWAP}
  ILCF_SWAP   = $00000001;
{$EXTERNALSYM ImageList_Copy}
function ImageList_Copy(himlDst: HIMAGELIST; iDst: Integer; himlSrc: HIMAGELIST;
  Src: Integer; uFlags: UINT): Bool; stdcall;

{$EXTERNALSYM ImageList_BeginDrag}
function ImageList_BeginDrag(ImageList: HIMAGELIST; Track: Integer;
  XHotSpot, YHotSpot: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_EndDrag}
function ImageList_EndDrag: Bool; stdcall;
{$EXTERNALSYM ImageList_DragEnter}
function ImageList_DragEnter(LockWnd: HWnd; X, Y: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_DragLeave}
function ImageList_DragLeave(LockWnd: HWnd): Bool; stdcall;
{$EXTERNALSYM ImageList_DragMove}
function ImageList_DragMove(X, Y: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_SetDragCursorImage}
function ImageList_SetDragCursorImage(ImageList: HIMAGELIST; Drag: Integer;
  XHotSpot, YHotSpot: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_DragShowNolock}
function ImageList_DragShowNolock(Show: Bool): Bool; stdcall;
{$EXTERNALSYM ImageList_GetDragImage}
function ImageList_GetDragImage(Point, HotSpot: PPoint): HIMAGELIST; overload; stdcall;
{$EXTERNALSYM ImageList_GetDragImage}
function ImageList_GetDragImage(Point: PPoint; out HotSpot: TPoint): HIMAGELIST; overload; stdcall;

{ macros }
{$EXTERNALSYM ImageList_RemoveAll}
procedure ImageList_RemoveAll(ImageList: HIMAGELIST); inline;
{$EXTERNALSYM ImageList_ExtractIcon}
function ImageList_ExtractIcon(Instance: HINST; ImageList: HIMAGELIST;
  Image: Integer): HIcon; inline;
{$EXTERNALSYM ImageList_LoadBitmap}
function ImageList_LoadBitmap(Instance: HINST; Bmp: LPCWSTR;
  CX, Grow: Integer; MasK: TColorRef): HIMAGELIST;
{$EXTERNALSYM ImageList_LoadBitmapA}
function ImageList_LoadBitmapA(Instance: HINST; Bmp: LPCSTR;
  CX, Grow: Integer; MasK: TColorRef): HIMAGELIST;
{$EXTERNALSYM ImageList_LoadBitmapW}
function ImageList_LoadBitmapW(Instance: HINST; Bmp: LPCWSTR;
  CX, Grow: Integer; MasK: TColorRef): HIMAGELIST;

{$EXTERNALSYM ImageList_Read}
function ImageList_Read(Stream: IStream): HIMAGELIST; stdcall;
{$EXTERNALSYM ImageList_Write}
function ImageList_Write(ImageList: HIMAGELIST; Stream: IStream): BOOL; stdcall;

const
  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM ILP_NORMAL}
  ILP_NORMAL          = 0;          { Writes or reads the stream using new sematics for this version of comctl32 }
  {$EXTERNALSYM ILP_DOWNLEVEL}
  ILP_DOWNLEVEL       = 1;          { Write or reads the stream using downlevel sematics. }

{ For Windows >= XP }
{$EXTERNALSYM ImageList_ReadEx}
function ImageList_ReadEx(dwFlags: DWORD; pstm: IStream; const riid: TIID;
  var ppv: Pointer): HResult;
{$EXTERNALSYM ImageList_WriteEx}
function ImageList_WriteEx(himl: HIMAGELIST; dwFlags: DWORD;
  pstm: IStream): HResult;


type
  PImageInfo = ^TImageInfo;
  {$EXTERNALSYM _IMAGEINFO}
  _IMAGEINFO = record
    hbmImage: HBitmap;
    hbmMask: HBitmap;
    Unused1: Integer;
    Unused2: Integer;
    rcImage: TRect;
  end;
  TImageInfo = _IMAGEINFO;
  {$EXTERNALSYM IMAGEINFO}
  IMAGEINFO = _IMAGEINFO;

{$EXTERNALSYM ImageList_GetIconSize}
function ImageList_GetIconSize(ImageList: HIMAGELIST; var CX, CY: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_SetIconSize}
function ImageList_SetIconSize(ImageList: HIMAGELIST; CX, CY: Integer): Bool; stdcall;
{$EXTERNALSYM ImageList_GetImageInfo}
function ImageList_GetImageInfo(ImageList: HIMAGELIST; Index: Integer;
  var ImageInfo: TImageInfo): Bool; stdcall;
{$EXTERNALSYM ImageList_Merge}
function ImageList_Merge(ImageList1: HIMAGELIST; Index1: Integer;
  ImageList2: HIMAGELIST; Index2: Integer; DX, DY: Integer): HIMAGELIST; stdcall;
{$EXTERNALSYM ImageList_Duplicate}
function ImageList_Duplicate(himl: HIMAGELIST): HIMAGELIST; stdcall;

{$EXTERNALSYM HIMAGELIST_QueryInterface}
function HIMAGELIST_QueryInterface(himl: HIMAGELIST; const riid: TIID;
  var ppv: Pointer): HResult;

{ ====== HEADER CONTROL ========================== }

const
  {$EXTERNALSYM WC_HEADER}
  WC_HEADER = 'SysHeader32';

  {$EXTERNALSYM HDS_HORZ}
  HDS_HORZ                = $0000;
  {$EXTERNALSYM HDS_BUTTONS}
  HDS_BUTTONS             = $0002;
  {$EXTERNALSYM HDS_HOTTRACK}
  HDS_HOTTRACK            = $0004;
  {$EXTERNALSYM HDS_HIDDEN}
  HDS_HIDDEN              = $0008;
  {$EXTERNALSYM HDS_DRAGDROP}
  HDS_DRAGDROP            = $0040;
  {$EXTERNALSYM HDS_FULLDRAG}
  HDS_FULLDRAG            = $0080;
  {$EXTERNALSYM HDS_FILTERBAR}
  HDS_FILTERBAR           = $0100;

  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM HDS_FLAT}
  HDS_FLAT                = $0200;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HDS_CHECKBOXES}
  HDS_CHECKBOXES          = $0400;
  {$EXTERNALSYM HDS_NOSIZING}
  HDS_NOSIZING            = $0800;
  {$EXTERNALSYM HDS_OVERFLOW}
  HDS_OVERFLOW            = $1000;

  { _WIN32_IE >= 0x0500 IExplorer 5.0+ }
  {$EXTERNALSYM HDFT_ISSTRING}
  HDFT_ISSTRING           = $0000;     // HD_ITEM.pvFilter points to a HD_TEXTFILTER
  {$EXTERNALSYM HDFT_ISNUMBER}
  HDFT_ISNUMBER           = $0001;     // HD_ITEM.pvFilter points to a INT
  {$EXTERNALSYM HDFT_ISDATE}
  HDFT_ISDATE             = $0002;     // HD_ITEM.pvFilter points to a DWORD (dos date)

  {$EXTERNALSYM HDFT_HASNOVALUE}
  HDFT_HASNOVALUE         = $8000;     // clear the filter, by setting this bit

type
  PHDTextFilterA = ^THDTextFilterA;
  PHDTextFilterW = ^THDTextFilterW;
  PHDTextFilter = PHDTextFilterW;
  {$EXTERNALSYM _HD_TEXTFILTERA}
  _HD_TEXTFILTERA = record
    pszText: LPSTR;                   // [in] pointer to the buffer containing the filter (ANSI/UNICODE)
    cchTextMax: Integer;               // [in] max size of buffer/edit control buffer
  end;
  {$EXTERNALSYM _HD_TEXTFILTERW}
  _HD_TEXTFILTERW = record
    pszText: LPWSTR;                   // [in] pointer to the buffer containing the filter (ANSI/UNICODE)
    cchTextMax: Integer;               // [in] max size of buffer/edit control buffer
  end;
  {$EXTERNALSYM _HD_TEXTFILTER}
  _HD_TEXTFILTER = _HD_TEXTFILTERW;
  THDTextFilterA = _HD_TEXTFILTERA;
  THDTextFilterW = _HD_TEXTFILTERW;
  THDTextFilter = THDTextFilterW;
  {$EXTERNALSYM HD_TEXTFILTERA}
  HD_TEXTFILTERA = _HD_TEXTFILTERA;
  {$EXTERNALSYM HD_TEXTFILTERW}
  HD_TEXTFILTERW = _HD_TEXTFILTERW;
  {$EXTERNALSYM HD_TEXTFILTER}
  HD_TEXTFILTER = HD_TEXTFILTERW;

  PHDItemA = ^THDItemA;
  PHDItemW = ^THDItemW;
  PHDItem = PHDItemW;
  {$EXTERNALSYM _HD_ITEMA}
  _HD_ITEMA = record
    Mask: UINT;
    cxy: Integer;
    pszText: LPSTR;
    hbm: HBITMAP;
    cchTextMax: Integer;
    fmt: Integer;
    lParam: LPARAM;
  
    iImage: Integer;        // index of bitmap in ImageList
    iOrder: Integer;        // where to draw this item
  
	   { For IE >= 0x0500 }
    &type: UINT;             // [in] filter type (defined what pvFilter is a pointer to)
    pvFilter: Pointer;       // [in] filter data see above
  
    { For Windows >= Vista }
    state: UINT;
  
  end;
  {$EXTERNALSYM _HD_ITEMW}
  _HD_ITEMW = record
    Mask: UINT;
    cxy: Integer;
    pszText: LPWSTR;
    hbm: HBITMAP;
    cchTextMax: Integer;
    fmt: Integer;
    lParam: LPARAM;
  
    iImage: Integer;        // index of bitmap in ImageList
    iOrder: Integer;        // where to draw this item
  
	   { For IE >= 0x0500 }
    &type: UINT;             // [in] filter type (defined what pvFilter is a pointer to)
    pvFilter: Pointer;       // [in] filter data see above
  
    { For Windows >= Vista }
    state: UINT;
  
  end;
  {$EXTERNALSYM _HD_ITEM}
  _HD_ITEM = _HD_ITEMW;
  THDItemA = _HD_ITEMA;
  THDItemW = _HD_ITEMW;
  THDItem = THDItemW;
  {$EXTERNALSYM HD_ITEMA}
  HD_ITEMA = _HD_ITEMA;
  {$EXTERNALSYM HD_ITEMW}
  HD_ITEMW = _HD_ITEMW;
  {$EXTERNALSYM HD_ITEM}
  HD_ITEM = HD_ITEMW;

const
  {$EXTERNALSYM HDI_WIDTH}
  HDI_WIDTH               = $0001;
  {$EXTERNALSYM HDI_HEIGHT}
  HDI_HEIGHT              = HDI_WIDTH;
  {$EXTERNALSYM HDI_TEXT}
  HDI_TEXT                = $0002;
  {$EXTERNALSYM HDI_FORMAT}
  HDI_FORMAT              = $0004;
  {$EXTERNALSYM HDI_LPARAM}
  HDI_LPARAM              = $0008;
  {$EXTERNALSYM HDI_BITMAP}
  HDI_BITMAP              = $0010;
  {$EXTERNALSYM HDI_IMAGE}
  HDI_IMAGE               = $0020;
  {$EXTERNALSYM HDI_DI_SETITEM}
  HDI_DI_SETITEM          = $0040;
  {$EXTERNALSYM HDI_ORDER}
  HDI_ORDER               = $0080;

  { _WIN32_IE >= 0x0500 IE >= 0x0500 }
  {$EXTERNALSYM HDI_FILTER}
  HDI_FILTER              = $0100;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HDI_STATE}
  HDI_STATE               = $0200;

  { HDF_ flags are shared with the listview control (LVCFMT_ flags) }
  {$EXTERNALSYM HDF_LEFT}
  HDF_LEFT                = $0000; { Same as LVCFMT_LEFT }
  {$EXTERNALSYM HDF_RIGHT}
  HDF_RIGHT               = $0001; { Same as LVCFMT_RIGHT }
  {$EXTERNALSYM HDF_CENTER}
  HDF_CENTER              = $0002; { Same as LVCFMT_CENTER }
  {$EXTERNALSYM HDF_JUSTIFYMASK}
  HDF_JUSTIFYMASK         = $0003; { Same as LVCFMT_JUSTIFYMASK }
  {$EXTERNALSYM HDF_RTLREADING}
  HDF_RTLREADING          = $0004; { Same as LVCFMT_LEFT }

  {$EXTERNALSYM HDF_BITMAP}
  HDF_BITMAP              = $2000; 
  {$EXTERNALSYM HDF_STRING}
  HDF_STRING              = $4000;
  {$EXTERNALSYM HDF_OWNERDRAW}
  HDF_OWNERDRAW           = $8000; { Same as LVCFMT_COL_HAS_IMAGES }

  {$EXTERNALSYM HDF_IMAGE}
  HDF_IMAGE               = $0800; { Same as LVCFMT_IMAGE }
  {$EXTERNALSYM HDF_BITMAP_ON_RIGHT}
  HDF_BITMAP_ON_RIGHT     = $1000; { Same as LVCFMT_BITMAP_ON_RIGHT }

  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM HDF_SORTUP}
  HDF_SORTUP              = $0400;
  {$EXTERNALSYM HDF_SORTDOWN}
  HDF_SORTDOWN            = $0200;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HDF_CHECKBOX}
  HDF_CHECKBOX            = $0040;
  {$EXTERNALSYM HDF_CHECKED}
  HDF_CHECKED             = $0080;
  {$EXTERNALSYM HDF_FIXEDWIDTH}
  HDF_FIXEDWIDTH          = $0100; { Can't resize the column; same as LVCFMT_FIXED_WIDTH }
  {$EXTERNALSYM HDF_SPLITBUTTON}
  HDF_SPLITBUTTON         = $1000000; { Column is a split button; same as LVCFMT_SPLITBUTTON }

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HDIS_FOCUSED}
  HDIS_FOCUSED            = $00000001; 

  {$EXTERNALSYM HDM_GETITEMCOUNT}
  HDM_GETITEMCOUNT        = HDM_FIRST + 0;

{$EXTERNALSYM Header_GetItemCount}
function Header_GetItemCount(Header: HWnd): Integer; inline;

const
  {$EXTERNALSYM HDM_INSERTITEMW}
  HDM_INSERTITEMW          = HDM_FIRST + 10;
  {$EXTERNALSYM HDM_INSERTITEMA}
  HDM_INSERTITEMA          = HDM_FIRST + 1;
{$IFDEF UNICODE}
  {$EXTERNALSYM HDM_INSERTITEM}
  HDM_INSERTITEM           = HDM_INSERTITEMW;
{$ELSE}
  {$EXTERNALSYM HDM_INSERTITEM}
  HDM_INSERTITEM           = HDM_INSERTITEMA;
{$ENDIF}

{$EXTERNALSYM Header_InsertItem}
function Header_InsertItem(Header: HWnd; Index: Integer;
  const Item: THDItem): Integer; inline;
{$EXTERNALSYM Header_InsertItemA}
function Header_InsertItemA(Header: HWnd; Index: Integer;
  const Item: THDItemA): Integer; inline;
{$EXTERNALSYM Header_InsertItemW}
function Header_InsertItemW(Header: HWnd; Index: Integer;
  const Item: THDItemW): Integer; inline;

const
  {$EXTERNALSYM HDM_DELETEITEM}
  HDM_DELETEITEM          = HDM_FIRST + 2;

{$EXTERNALSYM Header_DeleteItem}
function Header_DeleteItem(Header: HWnd; Index: Integer): Bool; inline;

const
  {$EXTERNALSYM HDM_GETITEMW}
  HDM_GETITEMW             = HDM_FIRST + 11;
  {$EXTERNALSYM HDM_GETITEMA}
  HDM_GETITEMA             = HDM_FIRST + 3;
{$IFDEF UNICODE}
  {$EXTERNALSYM HDM_GETITEM}
  HDM_GETITEM              = HDM_GETITEMW;
{$ELSE}
  {$EXTERNALSYM HDM_GETITEM}
  HDM_GETITEM              = HDM_GETITEMA;
{$ENDIF}

{$EXTERNALSYM Header_GetItem}
function Header_GetItem(Header: HWnd; Index: Integer;
  var Item: THDItem): Bool; inline;
{$EXTERNALSYM Header_GetItemA}
function Header_GetItemA(Header: HWnd; Index: Integer;
  var Item: THDItemA): Bool; inline;
{$EXTERNALSYM Header_GetItemW}
function Header_GetItemW(Header: HWnd; Index: Integer;
  var Item: THDItemW): Bool; inline;

const
  {$EXTERNALSYM HDM_SETITEMA}
  HDM_SETITEMA            = HDM_FIRST + 4;
  {$EXTERNALSYM HDM_SETITEMW}
  HDM_SETITEMW            = HDM_FIRST + 12;
{$IFDEF UNICODE}
  {$EXTERNALSYM HDM_SETITEM}
  HDM_SETITEM             = HDM_SETITEMW;
{$ELSE}
  {$EXTERNALSYM HDM_SETITEM}
  HDM_SETITEM             = HDM_SETITEMA;
{$ENDIF}

{$EXTERNALSYM Header_SetItem}
function Header_SetItem(Header: HWnd; Index: Integer; const Item: THDItem): Bool; inline;
{$EXTERNALSYM Header_SetItemA}
function Header_SetItemA(Header: HWnd; Index: Integer; const Item: THDItemA): Bool; inline;
{$EXTERNALSYM Header_SetItemW}
function Header_SetItemW(Header: HWnd; Index: Integer; const Item: THDItemW): Bool; inline;

type
  PHDLayout = ^THDLayout;
  {$EXTERNALSYM _HD_LAYOUT}
  _HD_LAYOUT = record
    Rect: ^TRect;
    WindowPos: PWindowPos;
  end;
  THDLayout = _HD_LAYOUT;
  {$EXTERNALSYM HD_LAYOUT}
  HD_LAYOUT = _HD_LAYOUT;

const
  {$EXTERNALSYM HDM_LAYOUT}
  HDM_LAYOUT              = HDM_FIRST + 5;

{$EXTERNALSYM Header_Layout}
function Header_Layout(Header: HWnd; Layout: PHDLayout): Bool; inline;

const
  {$EXTERNALSYM HHT_NOWHERE}
  HHT_NOWHERE             = $0001;
  {$EXTERNALSYM HHT_ONHEADER}
  HHT_ONHEADER            = $0002;
  {$EXTERNALSYM HHT_ONDIVIDER}
  HHT_ONDIVIDER           = $0004;
  {$EXTERNALSYM HHT_ONDIVOPEN}
  HHT_ONDIVOPEN           = $0008;
  {$EXTERNALSYM HHT_ABOVE}
  HHT_ABOVE               = $0100;
  {$EXTERNALSYM HHT_BELOW}
  HHT_BELOW               = $0200;
  {$EXTERNALSYM HHT_TORIGHT}
  HHT_TORIGHT             = $0400;
  {$EXTERNALSYM HHT_TOLEFT}
  HHT_TOLEFT              = $0800;

  { _WIN32_WINNT >= 0x0600 Windows >= Vista }
  {$EXTERNALSYM HHT_ONITEMSTATEICON}
  HHT_ONITEMSTATEICON     = $1000;
  {$EXTERNALSYM HHT_ONDROPDOWN}
  HHT_ONDROPDOWN          = $2000;
  {$EXTERNALSYM HHT_ONOVERFLOW}
  HHT_ONOVERFLOW          = $4000;

type
  PHDHitTestInfo = ^THDHitTestInfo;
  {$EXTERNALSYM _HD_HITTESTINFO}
  _HD_HITTESTINFO = record
    Point: TPoint;
    Flags: UINT;
    Item: Integer;
  end;
  THDHitTestInfo = _HD_HITTESTINFO;
  {$EXTERNALSYM HD_HITTESTINFO}
  HD_HITTESTINFO = _HD_HITTESTINFO;

const
  HDSIL_NORMAL            = 0;
  {$EXTERNALSYM HDSIL_NORMAL}
  HDSIL_STATE             = 1;
  {$EXTERNALSYM HDSIL_STATE}

  {$EXTERNALSYM HDM_HITTEST}
  HDM_HITTEST             = HDM_FIRST + 6;
  {$EXTERNALSYM HDM_GETITEMRECT}
  HDM_GETITEMRECT         = HDM_FIRST + 7;
  {$EXTERNALSYM HDM_SETIMAGELIST}
  HDM_SETIMAGELIST        = HDM_FIRST + 8;
  {$EXTERNALSYM HDM_GETIMAGELIST}
  HDM_GETIMAGELIST        = HDM_FIRST + 9;
  {$EXTERNALSYM HDM_ORDERTOINDEX}
  HDM_ORDERTOINDEX        = HDM_FIRST + 15;
  {$EXTERNALSYM HDM_CREATEDRAGIMAGE}
  HDM_CREATEDRAGIMAGE     = HDM_FIRST + 16;  // wparam = which item = by index;
  {$EXTERNALSYM HDM_GETORDERARRAY}
  HDM_GETORDERARRAY       = HDM_FIRST + 17;
  {$EXTERNALSYM HDM_SETORDERARRAY}
  HDM_SETORDERARRAY       = HDM_FIRST + 18;
  {$EXTERNALSYM HDM_SETHOTDIVIDER}
  HDM_SETHOTDIVIDER       = HDM_FIRST + 19;
  {$EXTERNALSYM HDM_SETUNICODEFORMAT}
  HDM_SETUNICODEFORMAT    = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM HDM_GETUNICODEFORMAT}
  HDM_GETUNICODEFORMAT    = CCM_GETUNICODEFORMAT;

  { For IE >= 0x0500 }
  {$EXTERNALSYM HDM_SETBITMAPMARGIN}
  HDM_SETBITMAPMARGIN          = HDM_FIRST + 20;
  {$EXTERNALSYM HDM_GETBITMAPMARGIN}
  HDM_GETBITMAPMARGIN          = HDM_FIRST + 21;
  {$EXTERNALSYM HDM_SETFILTERCHANGETIMEOUT}
  HDM_SETFILTERCHANGETIMEOUT   = HDM_FIRST + 22;
  {$EXTERNALSYM HDM_EDITFILTER}
  HDM_EDITFILTER               = HDM_FIRST + 23;
  {$EXTERNALSYM HDM_CLEARFILTER}
  HDM_CLEARFILTER              = HDM_FIRST + 24;

  { For Windows >= 0x0600 }
  // Not currently implemented
  //{$EXTERNALSYM HDM_TRANSLATEACCELERATOR}
  //HDM_TRANSLATEACCELERATOR    = CCM_TRANSLATEACCELERATOR;

  { For Windows >= Vista}
  {$EXTERNALSYM HDM_GETITEMDROPDOWNRECT}
  HDM_GETITEMDROPDOWNRECT     = HDM_FIRST + 25;   // rect of item's drop down button
  {$EXTERNALSYM HDM_GETOVERFLOWRECT}
  HDM_GETOVERFLOWRECT         = HDM_FIRST + 26;   // rect of overflow button
  {$EXTERNALSYM HDM_GETFOCUSEDITEM}
  HDM_GETFOCUSEDITEM          = HDM_FIRST + 27;
  {$EXTERNALSYM HDM_SETFOCUSEDITEM}
  HDM_SETFOCUSEDITEM          = HDM_FIRST + 28;

{$EXTERNALSYM Header_GetItemRect}
function Header_GetItemRect(hwnd: HWND; iItem: Integer; lprc: PRect): BOOL; inline;
{$EXTERNALSYM Header_SetImageList}
function Header_SetImageList(hwnd: HWND; himl: HIMAGELIST): HIMAGELIST; inline;
{$EXTERNALSYM Header_GetImageList}
function Header_GetImageList(hwnd: HWND): HIMAGELIST; inline;
{$EXTERNALSYM Header_OrderToIndex}
function Header_OrderToIndex(hwnd: HWND; i: Integer): Integer; inline
{$EXTERNALSYM Header_CreateDragImage}
function Header_CreateDragImage(hwnd: HWND; i: Integer): HIMAGELIST; inline;
{$EXTERNALSYM Header_GetOrderArray}
function Header_GetOrderArray(hwnd: HWND; iCount: Integer; lpi: PInteger): BOOL; inline;
{$EXTERNALSYM Header_SetOrderArray}
function Header_SetOrderArray(hwnd: HWND; iCount: Integer; lpi: PInteger): BOOL; inline;

// lparam = int array of size HDM_GETITEMCOUNT
// the array specifies the order that all items should be displayed.
// e.g.  { 2, 0, 1}
// says the index 2 item should be shown in the 0ths position
//      index 0 should be shown in the 1st position
//      index 1 should be shown in the 2nd position

{$EXTERNALSYM Header_SetHotDivider}
function Header_SetHotDivider(hwnd: HWND; fPos: BOOL; dw: DWORD): Integer; inline;

// convenience message for external dragdrop
// wParam = BOOL  specifying whether the lParam is a dwPos of the cursor
//              position or the index of which divider to hotlight
// lParam = depends on wParam  (-1 and wParm = FALSE turns off hotlight)

{$EXTERNALSYM Header_SetUnicodeFormat}
function Header_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL; inline;
{$EXTERNALSYM Header_GetUnicodeFormat}
function Header_GetUnicodeFormat(hwnd: HWND): BOOL; inline;

{ For IE >= 0x0500 }
{$EXTERNALSYM Header_SetBitmapMargin}
function Header_SetBitmapMargin(hwnd: HWND; iWidth: Integer): Integer; inline;
{$EXTERNALSYM Header_GetBitmapMargin}
function Header_GetBitmapMargin(hwnd: HWND): Integer; inline;
{$EXTERNALSYM Header_SetFilterChangeTimeout}
function Header_SetFilterChangeTimeout(hwnd: HWND; i: Integer): Integer; inline;
{$EXTERNALSYM Header_EditFilter}
function Header_EditFilter(hwnd: HWND; i: Integer; fDiscardChanges: BOOL): Integer; inline;
{$EXTERNALSYM Header_ClearFilter}
function Header_ClearFilter(hwnd: HWND; i: Integer): Integer; inline;
{$EXTERNALSYM Header_ClearAllFilters}
function Header_ClearAllFilters(hwnd: HWND): Integer; inline;

{ For Windows >= Vista}
{$EXTERNALSYM Header_GetItemDropDownRect}
function Header_GetItemDropDownRect(hwnd: HWND; iItem: Integer; var lprc: TRect): BOOL; inline;
{$EXTERNALSYM Header_GetOverflowRect}
function Header_GetOverflowRect(hwnd: HWND; var lprc: TRect): BOOL; inline;
{$EXTERNALSYM Header_GetFocusedItem}
function Header_GetFocusedItem(hwnd: HWND): Integer; inline;
{$EXTERNALSYM Header_SetFocusedItem}
function Header_SetFocusedItem(hwnd: HWND; iItem: Integer): BOOL; inline;

const
  {$EXTERNALSYM HDN_ITEMCHANGINGA}
  HDN_ITEMCHANGINGA        = HDN_FIRST-0;
  {$EXTERNALSYM HDN_ITEMCHANGEDA}
  HDN_ITEMCHANGEDA         = HDN_FIRST-1;
  {$EXTERNALSYM HDN_ITEMCLICKA}
  HDN_ITEMCLICKA           = HDN_FIRST-2;
  {$EXTERNALSYM HDN_ITEMDBLCLICKA}
  HDN_ITEMDBLCLICKA        = HDN_FIRST-3;
  {$EXTERNALSYM HDN_DIVIDERDBLCLICKA}
  HDN_DIVIDERDBLCLICKA     = HDN_FIRST-5;
  {$EXTERNALSYM HDN_BEGINTRACKA}
  HDN_BEGINTRACKA          = HDN_FIRST-6;
  {$EXTERNALSYM HDN_ENDTRACKA}
  HDN_ENDTRACKA            = HDN_FIRST-7;
  {$EXTERNALSYM HDN_TRACKA}
  HDN_TRACKA               = HDN_FIRST-8;
  {$EXTERNALSYM HDN_GETDISPINFOA}
  HDN_GETDISPINFOA         = HDN_FIRST-9;
  {$EXTERNALSYM HDN_BEGINDRAG}
  HDN_BEGINDRAG            = HDN_FIRST-10;
  {$EXTERNALSYM HDN_ENDDRAG}
  HDN_ENDDRAG              = HDN_FIRST-11;

  { For IE >= 0x0500 }
  {$EXTERNALSYM HDN_FILTERCHANGE}
  HDN_FILTERCHANGE         = HDN_FIRST-12;
  {$EXTERNALSYM HDN_FILTERBTNCLICK}
  HDN_FILTERBTNCLICK       = HDN_FIRST-13;

  { For IE >= 0x0600 }
  {$EXTERNALSYM HDN_BEGINFILTEREDIT}
  HDN_BEGINFILTEREDIT      = HDN_FIRST-14;
  {$EXTERNALSYM HDN_ENDFILTEREDIT}
  HDN_ENDFILTEREDIT        = HDN_FIRST-15;

  { For Windows >= Vista }
  {$EXTERNALSYM HDN_ITEMSTATEICONCLICK}
  HDN_ITEMSTATEICONCLICK   = HDN_FIRST-16;
  {$EXTERNALSYM HDN_ITEMKEYDOWN}
  HDN_ITEMKEYDOWN          = HDN_FIRST-17;
  {$EXTERNALSYM HDN_DROPDOWN}
  HDN_DROPDOWN             = HDN_FIRST-18;
  {$EXTERNALSYM HDN_OVERFLOWCLICK}
  HDN_OVERFLOWCLICK        = HDN_FIRST-19;

  {$EXTERNALSYM HDN_ITEMCHANGINGW}
  HDN_ITEMCHANGINGW        = HDN_FIRST-20;
  {$EXTERNALSYM HDN_ITEMCHANGEDW}
  HDN_ITEMCHANGEDW         = HDN_FIRST-21;
  {$EXTERNALSYM HDN_ITEMCLICKW}
  HDN_ITEMCLICKW           = HDN_FIRST-22;
  {$EXTERNALSYM HDN_ITEMDBLCLICKW}
  HDN_ITEMDBLCLICKW        = HDN_FIRST-23;
  {$EXTERNALSYM HDN_DIVIDERDBLCLICKW}
  HDN_DIVIDERDBLCLICKW     = HDN_FIRST-25;
  {$EXTERNALSYM HDN_BEGINTRACKW}
  HDN_BEGINTRACKW          = HDN_FIRST-26;
  {$EXTERNALSYM HDN_ENDTRACKW}
  HDN_ENDTRACKW            = HDN_FIRST-27;
  {$EXTERNALSYM HDN_TRACKW}
  HDN_TRACKW               = HDN_FIRST-28;
  {$EXTERNALSYM HDN_GETDISPINFOW}
  HDN_GETDISPINFOW         = HDN_FIRST-29;

{$IFDEF UNICODE}
  {$EXTERNALSYM HDN_ITEMCHANGING}
  HDN_ITEMCHANGING        = HDN_ITEMCHANGINGW;
  {$EXTERNALSYM HDN_ITEMCHANGED}
  HDN_ITEMCHANGED         = HDN_ITEMCHANGEDW;
  {$EXTERNALSYM HDN_ITEMCLICK}
  HDN_ITEMCLICK           = HDN_ITEMCLICKW;
  {$EXTERNALSYM HDN_ITEMDBLCLICK}
  HDN_ITEMDBLCLICK        = HDN_ITEMDBLCLICKW;
  {$EXTERNALSYM HDN_DIVIDERDBLCLICK}
  HDN_DIVIDERDBLCLICK     = HDN_DIVIDERDBLCLICKW;
  {$EXTERNALSYM HDN_BEGINTRACK}
  HDN_BEGINTRACK          = HDN_BEGINTRACKW;
  {$EXTERNALSYM HDN_ENDTRACK}
  HDN_ENDTRACK            = HDN_ENDTRACKW;
  {$EXTERNALSYM HDN_TRACK}
  HDN_TRACK               = HDN_TRACKW;
  {$EXTERNALSYM HDN_GETDISPINFO}
  HDN_GETDISPINFO         = HDN_GETDISPINFOW;
{$ELSE}
  {$EXTERNALSYM HDN_ITEMCHANGING}
  HDN_ITEMCHANGING        = HDN_ITEMCHANGINGA;
  {$EXTERNALSYM HDN_ITEMCHANGED}
  HDN_ITEMCHANGED         = HDN_ITEMCHANGEDA;
  {$EXTERNALSYM HDN_ITEMCLICK}
  HDN_ITEMCLICK           = HDN_ITEMCLICKA;
  {$EXTERNALSYM HDN_ITEMDBLCLICK}
  HDN_ITEMDBLCLICK        = HDN_ITEMDBLCLICKA;
  {$EXTERNALSYM HDN_DIVIDERDBLCLICK}
  HDN_DIVIDERDBLCLICK     = HDN_DIVIDERDBLCLICKA;
  {$EXTERNALSYM HDN_BEGINTRACK}
  HDN_BEGINTRACK          = HDN_BEGINTRACKA;
  {$EXTERNALSYM HDN_ENDTRACK}
  HDN_ENDTRACK            = HDN_ENDTRACKA;
  {$EXTERNALSYM HDN_TRACK}
  HDN_TRACK               = HDN_TRACKA;
  {$EXTERNALSYM HDN_GETDISPINFO}
  HDN_GETDISPINFO         = HDN_GETDISPINFOA;
{$ENDIF}

type
  {$EXTERNALSYM tagNMHEADERA}
  tagNMHEADERA = record
    Hdr: TNMHdr;
    Item: Integer;
    Button: Integer;
    PItem: PHDItemA;
  end;
  {$EXTERNALSYM tagNMHEADERW}
  tagNMHEADERW = record
    Hdr: TNMHdr;
    Item: Integer;
    Button: Integer;
    PItem: PHDItemW;
  end;
  {$EXTERNALSYM tagNMHEADER}
  tagNMHEADER = tagNMHEADERW;
  {$EXTERNALSYM HD_NOTIFYA}
  HD_NOTIFYA = tagNMHEADERA;
  {$EXTERNALSYM HD_NOTIFYW}
  HD_NOTIFYW = tagNMHEADERW;
  {$EXTERNALSYM HD_NOTIFY}
  HD_NOTIFY = HD_NOTIFYW;
  PHDNotifyA = ^THDNotifyA;
  PHDNotifyW = ^THDNotifyW;
  PHDNotify = PHDNotifyW;
  THDNotifyA = tagNMHEADERA;
  THDNotifyW = tagNMHEADERW;
  THDNotify = THDNotifyW;

  {$EXTERNALSYM tagNMHDDISPINFOA}
  tagNMHDDISPINFOA = record
    hdr: TNMHdr;
    iItem: Integer;
    mask: UINT;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMHDDISPINFOW}
  tagNMHDDISPINFOW = record
    hdr: TNMHdr;
    iItem: Integer;
    mask: UINT;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMHDDISPINFO}
  tagNMHDDISPINFO = tagNMHDDISPINFOW;
  PNMHDispInfoA = ^TNMHDispInfoA;
  PNMHDispInfoW = ^TNMHDispInfoW;
  PNMHDispInfo = PNMHDispInfoW;
  TNMHDispInfoA = tagNMHDDISPINFOA;
  TNMHDispInfoW = tagNMHDDISPINFOW;
  TNMHDispInfo = TNMHDispInfoW;

  {$EXTERNALSYM tagNMHDFILTERBTNCLICK}
  tagNMHDFILTERBTNCLICK = record
    hdr: NMHDR;
    iItem: Integer;
    rc: TRect;
  end;
  PNMHDFilterBtnClick = ^TNMHDFilterBtnClick;
  TNMHDFilterBtnClick = tagNMHDFILTERBTNCLICK;

 
{ ====== TOOLBAR CONTROL =================== }

const
  {$EXTERNALSYM TOOLBARCLASSNAME}
  TOOLBARCLASSNAME = 'ToolbarWindow32';

type
  PTBButton = ^TTBButton;
  {$EXTERNALSYM _TBBUTTON}
  _TBBUTTON = record
    iBitmap: Integer;
    idCommand: Integer;
    fsState: Byte;
    fsStyle: Byte;
    {$IFDEF CPUX64}
    bReserved: array[1..6] of Byte; // padding for alignment
    {$ELSE}
    bReserved: array[1..2] of Byte; // padding for alignment
    {$ENDIF}
    dwData: DWORD_PTR;
    iString: INT_PTR;
  end;
  TTBButton = _TBBUTTON;

  PColorMap = ^TColorMap;
  {$EXTERNALSYM _COLORMAP}
  _COLORMAP = record
    cFrom: TColorRef;
    cTo: TColorRef;
  end;
  TColorMap = _COLORMAP;
  {$EXTERNALSYM COLORMAP}
  COLORMAP = _COLORMAP;

{$EXTERNALSYM CreateToolBarEx}
function CreateToolBarEx(Wnd: HWnd; ws: DWORD; ID: UINT;
  Bitmaps: Integer; BMInst: HINST; BMID: UIntPtr; Buttons: PTBButton;
  NumButtons: Integer; dxButton, dyButton: Integer;
  dxBitmap, dyBitmap: Integer; StructSize: UINT): HWnd; stdcall;

{$EXTERNALSYM CreateMappedBitmap}
function CreateMappedBitmap(Instance: HINST; Bitmap: IntPtr;
  Flags: UINT; ColorMap: PColorMap; NumMaps: Integer): HBitmap; stdcall;

const

  {$EXTERNALSYM CMB_MASKED}
  CMB_MASKED              = $02;

  {$EXTERNALSYM TBSTATE_CHECKED}
  TBSTATE_CHECKED         = $01;
  {$EXTERNALSYM TBSTATE_PRESSED}
  TBSTATE_PRESSED         = $02;
  {$EXTERNALSYM TBSTATE_ENABLED}
  TBSTATE_ENABLED         = $04;
  {$EXTERNALSYM TBSTATE_HIDDEN}
  TBSTATE_HIDDEN          = $08;
  {$EXTERNALSYM TBSTATE_INDETERMINATE}
  TBSTATE_INDETERMINATE   = $10;
  {$EXTERNALSYM TBSTATE_WRAP}
  TBSTATE_WRAP            = $20;
  {$EXTERNALSYM TBSTATE_ELLIPSES}
  TBSTATE_ELLIPSES        = $40;
  {$EXTERNALSYM TBSTATE_MARKED}
  TBSTATE_MARKED          = $80;

  {$EXTERNALSYM TBSTYLE_BUTTON}
  TBSTYLE_BUTTON          = $00;
  {$EXTERNALSYM TBSTYLE_SEP}
  TBSTYLE_SEP             = $01;
  {$EXTERNALSYM TBSTYLE_CHECK}
  TBSTYLE_CHECK           = $02;
  {$EXTERNALSYM TBSTYLE_GROUP}
  TBSTYLE_GROUP           = $04;
  {$EXTERNALSYM TBSTYLE_CHECKGROUP}
  TBSTYLE_CHECKGROUP      = TBSTYLE_GROUP or TBSTYLE_CHECK;
  {$EXTERNALSYM TBSTYLE_DROPDOWN}
  TBSTYLE_DROPDOWN        = $08;
  {$EXTERNALSYM TBSTYLE_AUTOSIZE}
  TBSTYLE_AUTOSIZE        = $0010; // automatically calculate the cx of the button
  {$EXTERNALSYM TBSTYLE_NOPREFIX}
  TBSTYLE_NOPREFIX        = $0020; // if this button should not have accel prefix

  {$EXTERNALSYM TBSTYLE_TOOLTIPS}
  TBSTYLE_TOOLTIPS        = $0100;
  {$EXTERNALSYM TBSTYLE_WRAPABLE}
  TBSTYLE_WRAPABLE        = $0200;
  {$EXTERNALSYM TBSTYLE_ALTDRAG}
  TBSTYLE_ALTDRAG         = $0400;
  {$EXTERNALSYM TBSTYLE_FLAT}
  TBSTYLE_FLAT            = $0800;
  {$EXTERNALSYM TBSTYLE_LIST}
  TBSTYLE_LIST            = $1000;
  {$EXTERNALSYM TBSTYLE_CUSTOMERASE}
  TBSTYLE_CUSTOMERASE     = $2000;
  {$EXTERNALSYM TBSTYLE_REGISTERDROP}
  TBSTYLE_REGISTERDROP    = $4000;
  {$EXTERNALSYM TBSTYLE_TRANSPARENT}
  TBSTYLE_TRANSPARENT     = $8000;
  {$EXTERNALSYM TBSTYLE_EX_DRAWDDARROWS}
  TBSTYLE_EX_DRAWDDARROWS = $00000001;

  { For IE >= 0x0500 }
  {$EXTERNALSYM BTNS_BUTTON}
  BTNS_BUTTON             = TBSTYLE_BUTTON;
  {$EXTERNALSYM BTNS_SEP}
  BTNS_SEP                = TBSTYLE_SEP;
  {$EXTERNALSYM BTNS_CHECK}
  BTNS_CHECK              = TBSTYLE_CHECK;
  {$EXTERNALSYM BTNS_GROUP}
  BTNS_GROUP              = TBSTYLE_GROUP;
  {$EXTERNALSYM BTNS_CHECKGROUP}
  BTNS_CHECKGROUP         = TBSTYLE_CHECKGROUP;
  {$EXTERNALSYM BTNS_DROPDOWN}
  BTNS_DROPDOWN           = TBSTYLE_DROPDOWN;
  {$EXTERNALSYM BTNS_AUTOSIZE}
  BTNS_AUTOSIZE           = TBSTYLE_AUTOSIZE;
  {$EXTERNALSYM BTNS_NOPREFIX}
  BTNS_NOPREFIX           = TBSTYLE_NOPREFIX;
  { For IE >= 0x0501 }
  {$EXTERNALSYM BTNS_SHOWTEXT}
  BTNS_SHOWTEXT           = $0040;  // ignored unless TBSTYLE_EX_MIXEDBUTTONS is set

  { For IE >= 0x0500 }
  {$EXTERNALSYM BTNS_WHOLEDROPDOWN}
  BTNS_WHOLEDROPDOWN      = $0080;  // draw drop-down arrow, but without split arrow section

  { For IE >= 0x0501 }
  {$EXTERNALSYM TBSTYLE_EX_MIXEDBUTTONS}
  TBSTYLE_EX_MIXEDBUTTONS = $00000008;
  {$EXTERNALSYM TBSTYLE_EX_HIDECLIPPEDBUTTONS}
  TBSTYLE_EX_HIDECLIPPEDBUTTONS = $00000010;  // don't show partially obscured buttons

  { For Windows >= XP }
  {$EXTERNALSYM TBSTYLE_EX_DOUBLEBUFFER}
  TBSTYLE_EX_DOUBLEBUFFER = $00000080; // Double Buffer the toolbar

type
  // Custom Draw Structure
  {$EXTERNALSYM _NMTBCUSTOMDRAW}
  _NMTBCUSTOMDRAW = record
    nmcd: TNMCustomDraw;
    hbrMonoDither: HBRUSH;
    hbrLines: HBRUSH;                // For drawing lines on buttons
    hpenLines: HPEN;                 // For drawing lines on buttons
    clrText: COLORREF;               // Color of text
    clrMark: COLORREF;               // Color of text bk when marked. (only if TBSTATE_MARKED)
    clrTextHighlight: COLORREF;      // Color of text when highlighted
    clrBtnFace: COLORREF;            // Background of the button
    clrBtnHighlight: COLORREF;       // 3D highlight
    clrHighlightHotTrack: COLORREF;  // In conjunction with fHighlightHotTrack
                                     // will cause button to highlight like a menu
    rcText: TRect;                   // Rect for text
    nStringBkMode: Integer;
    nHLStringBkMode: Integer;
                                                
    iListGap: Integer;
    
  end;
  PNMTBCustomDraw = ^TNMTBCustomDraw;
  TNMTBCustomDraw = _NMTBCUSTOMDRAW;

const
  // Toolbar custom draw return flags
  {$EXTERNALSYM TBCDRF_NOEDGES}
  TBCDRF_NOEDGES              = $00010000;  // Don't draw button edges
  {$EXTERNALSYM TBCDRF_HILITEHOTTRACK}
  TBCDRF_HILITEHOTTRACK       = $00020000;  // Use color of the button bk when hottracked
  {$EXTERNALSYM TBCDRF_NOOFFSET}
  TBCDRF_NOOFFSET             = $00040000;  // Don't offset button if pressed
  {$EXTERNALSYM TBCDRF_NOMARK}
  TBCDRF_NOMARK               = $00080000;  // Don't draw default highlight of image/text for TBSTATE_MARKED
  {$EXTERNALSYM TBCDRF_NOETCHEDEFFECT}
  TBCDRF_NOETCHEDEFFECT       = $00100000;  // Don't draw etched effect for disabled items

  { For IE >= 0x0500 }
  {$EXTERNALSYM TBCDRF_BLENDICON}
  TBCDRF_BLENDICON            = $00200000;  // Use ILD_BLEND50 on the icon image
  {$EXTERNALSYM TBCDRF_NOBACKGROUND}
  TBCDRF_NOBACKGROUND         = $00400000;  // Use ILD_BLEND50 on the icon image

  { For Windows >= Vista }
  {$EXTERNALSYM TBCDRF_USECDCOLORS}
  TBCDRF_USECDCOLORS          = $00800000;  // Use CustomDrawColors to RenderText regardless of VisualStyle

  {$EXTERNALSYM TB_ENABLEBUTTON}
  TB_ENABLEBUTTON         = WM_USER + 1;
  {$EXTERNALSYM TB_CHECKBUTTON}
  TB_CHECKBUTTON          = WM_USER + 2;
  {$EXTERNALSYM TB_PRESSBUTTON}
  TB_PRESSBUTTON          = WM_USER + 3;
  {$EXTERNALSYM TB_HIDEBUTTON}
  TB_HIDEBUTTON           = WM_USER + 4;
  {$EXTERNALSYM TB_INDETERMINATE}
  TB_INDETERMINATE        = WM_USER + 5;
  {$EXTERNALSYM TB_MARKBUTTON}
  TB_MARKBUTTON           = WM_USER + 6;
  {$EXTERNALSYM TB_ISBUTTONENABLED}
  TB_ISBUTTONENABLED      = WM_USER + 9;
  {$EXTERNALSYM TB_ISBUTTONCHECKED}
  TB_ISBUTTONCHECKED      = WM_USER + 10;
  {$EXTERNALSYM TB_ISBUTTONPRESSED}
  TB_ISBUTTONPRESSED      = WM_USER + 11;
  {$EXTERNALSYM TB_ISBUTTONHIDDEN}
  TB_ISBUTTONHIDDEN       = WM_USER + 12;
  {$EXTERNALSYM TB_ISBUTTONINDETERMINATE}
  TB_ISBUTTONINDETERMINATE = WM_USER + 13;
  {$EXTERNALSYM TB_ISBUTTONHIGHLIGHTED}
  TB_ISBUTTONHIGHLIGHTED   = WM_USER + 14;
  {$EXTERNALSYM TB_SETSTATE}
  TB_SETSTATE             = WM_USER + 17;
  {$EXTERNALSYM TB_GETSTATE}
  TB_GETSTATE             = WM_USER + 18;
  {$EXTERNALSYM TB_ADDBITMAP}
  TB_ADDBITMAP            = WM_USER + 19;

type
  PTBAddBitmap = ^TTBAddBitmap;
  {$EXTERNALSYM tagTBADDBITMAP}
  tagTBADDBITMAP = record
    hInst: HINST;
    nID: UIntPtr;
  end;
  TTBAddBitmap = tagTBADDBITMAP;
  {$EXTERNALSYM TBADDBITMAP}
  TBADDBITMAP = tagTBADDBITMAP;

const
  {$EXTERNALSYM HINST_COMMCTRL}
  HINST_COMMCTRL = THandle(-1);

  {$EXTERNALSYM IDB_STD_SMALL_COLOR}
  IDB_STD_SMALL_COLOR     = 0;
  {$EXTERNALSYM IDB_STD_LARGE_COLOR}
  IDB_STD_LARGE_COLOR     = 1;
  {$EXTERNALSYM IDB_VIEW_SMALL_COLOR}
  IDB_VIEW_SMALL_COLOR    = 4;
  {$EXTERNALSYM IDB_VIEW_LARGE_COLOR}
  IDB_VIEW_LARGE_COLOR    = 5;
  {$EXTERNALSYM IDB_HIST_SMALL_COLOR}
  IDB_HIST_SMALL_COLOR    = 8;
  {$EXTERNALSYM IDB_HIST_LARGE_COLOR}
  IDB_HIST_LARGE_COLOR    = 9;
  {$EXTERNALSYM IDB_HIST_NORMAL}
  IDB_HIST_NORMAL         = 12;
  {$EXTERNALSYM IDB_HIST_HOT}
  IDB_HIST_HOT            = 13;
  {$EXTERNALSYM IDB_HIST_DISABLED}
  IDB_HIST_DISABLED       = 14;
  {$EXTERNALSYM IDB_HIST_PRESSED}
  IDB_HIST_PRESSED       = 15;

{ icon indexes for standard bitmap }
  {$EXTERNALSYM STD_CUT}
  STD_CUT                 = 0;
  {$EXTERNALSYM STD_COPY}
  STD_COPY                = 1;
  {$EXTERNALSYM STD_PASTE}
  STD_PASTE               = 2;
  {$EXTERNALSYM STD_UNDO}
  STD_UNDO                = 3;
  {$EXTERNALSYM STD_REDOW}
  STD_REDOW               = 4;
  {$EXTERNALSYM STD_DELETE}
  STD_DELETE              = 5;
  {$EXTERNALSYM STD_FILENEW}
  STD_FILENEW             = 6;
  {$EXTERNALSYM STD_FILEOPEN}
  STD_FILEOPEN            = 7;
  {$EXTERNALSYM STD_FILESAVE}
  STD_FILESAVE            = 8;
  {$EXTERNALSYM STD_PRINTPRE}
  STD_PRINTPRE            = 9;
  {$EXTERNALSYM STD_PROPERTIES}
  STD_PROPERTIES          = 10;
  {$EXTERNALSYM STD_HELP}
  STD_HELP                = 11;
  {$EXTERNALSYM STD_FIND}
  STD_FIND                = 12;
  {$EXTERNALSYM STD_REPLACE}
  STD_REPLACE             = 13;
  {$EXTERNALSYM STD_PRINT}
  STD_PRINT               = 14;

{ icon indexes for standard view bitmap }

  {$EXTERNALSYM VIEW_LARGEICONS}
  VIEW_LARGEICONS         = 0;
  {$EXTERNALSYM VIEW_SMALLICONS}
  VIEW_SMALLICONS         = 1;
  {$EXTERNALSYM VIEW_LIST}
  VIEW_LIST               = 2;
  {$EXTERNALSYM VIEW_DETAILS}
  VIEW_DETAILS            = 3;
  {$EXTERNALSYM VIEW_SORTNAME}
  VIEW_SORTNAME           = 4;
  {$EXTERNALSYM VIEW_SORTSIZE}
  VIEW_SORTSIZE           = 5;
  {$EXTERNALSYM VIEW_SORTDATE}
  VIEW_SORTDATE           = 6;
  {$EXTERNALSYM VIEW_SORTTYPE}
  VIEW_SORTTYPE           = 7;
  {$EXTERNALSYM VIEW_PARENTFOLDER}
  VIEW_PARENTFOLDER       = 8;
  {$EXTERNALSYM VIEW_NETCONNECT}
  VIEW_NETCONNECT         = 9;
  {$EXTERNALSYM VIEW_NETDISCONNECT}
  VIEW_NETDISCONNECT      = 10;
  {$EXTERNALSYM VIEW_NEWFOLDER}
  VIEW_NEWFOLDER          = 11;
  {$EXTERNALSYM VIEW_VIEWMENU}
  VIEW_VIEWMENU           = 12;

{ icon indexes for history bitmap }

  {$EXTERNALSYM HIST_BACK}
  HIST_BACK               = 0;
  {$EXTERNALSYM HIST_FORWARD}
  HIST_FORWARD            = 1;
  {$EXTERNALSYM HIST_FAVORITES}
  HIST_FAVORITES          = 2;
  {$EXTERNALSYM HIST_ADDTOFAVORITES}
  HIST_ADDTOFAVORITES     = 3;
  {$EXTERNALSYM HIST_VIEWTREE}
  HIST_VIEWTREE           = 4;

  {$EXTERNALSYM TB_ADDBUTTONSA}
  TB_ADDBUTTONSA          = WM_USER + 20;
  {$EXTERNALSYM TB_INSERTBUTTONA}
  TB_INSERTBUTTONA        = WM_USER + 21;
  {$EXTERNALSYM TB_DELETEBUTTON}
  TB_DELETEBUTTON         = WM_USER + 22;
  {$EXTERNALSYM TB_GETBUTTON}
  TB_GETBUTTON            = WM_USER + 23;
  {$EXTERNALSYM TB_BUTTONCOUNT}
  TB_BUTTONCOUNT          = WM_USER + 24;
  {$EXTERNALSYM TB_COMMANDTOINDEX}
  TB_COMMANDTOINDEX       = WM_USER + 25;

type
  PTBSaveParamsA = ^TTBSaveParamsA;
  PTBSaveParamsW = ^TTBSaveParamsW;
  PTBSaveParams = PTBSaveParamsW;
  {$EXTERNALSYM tagTBSAVEPARAMSA}
  tagTBSAVEPARAMSA = record
    hkr: HKEY;
    pszSubKey: LPCSTR;
    pszValueName: LPCSTR;
  end;
  {$EXTERNALSYM tagTBSAVEPARAMSW}
  tagTBSAVEPARAMSW = record
    hkr: HKEY;
    pszSubKey: LPCWSTR;
    pszValueName: LPCWSTR;
  end;
  {$EXTERNALSYM tagTBSAVEPARAMS}
  tagTBSAVEPARAMS = tagTBSAVEPARAMSW;
  TTBSaveParamsA = tagTBSAVEPARAMSA;
  TTBSaveParamsW = tagTBSAVEPARAMSW;
  TTBSaveParams = TTBSaveParamsW;
  {$EXTERNALSYM TBSAVEPARAMSA}
  TBSAVEPARAMSA = tagTBSAVEPARAMSA;
  {$EXTERNALSYM TBSAVEPARAMSW}
  TBSAVEPARAMSW = tagTBSAVEPARAMSW;
  {$EXTERNALSYM TBSAVEPARAMS}
  TBSAVEPARAMS = TBSAVEPARAMSW;

const
  {$EXTERNALSYM TB_SAVERESTOREA}
  TB_SAVERESTOREA          = WM_USER + 26;
  {$EXTERNALSYM TB_ADDSTRINGA}
  TB_ADDSTRINGA            = WM_USER + 28;
  {$EXTERNALSYM TB_GETBUTTONTEXTA}
  TB_GETBUTTONTEXTA        = WM_USER + 45;
  {$EXTERNALSYM TBN_GETBUTTONINFOA}
  TBN_GETBUTTONINFOA       = TBN_FIRST-0;

  {$EXTERNALSYM TB_SAVERESTOREW}
  TB_SAVERESTOREW          = WM_USER + 76;
  {$EXTERNALSYM TB_ADDSTRINGW}
  TB_ADDSTRINGW            = WM_USER + 77;
  {$EXTERNALSYM TB_GETBUTTONTEXTW}
  TB_GETBUTTONTEXTW        = WM_USER + 75;
  {$EXTERNALSYM TBN_GETBUTTONINFOW}
  TBN_GETBUTTONINFOW       = TBN_FIRST-20;

{$IFDEF UNICODE}
  {$EXTERNALSYM TB_SAVERESTORE}
  TB_SAVERESTORE          = TB_SAVERESTOREW;
  {$EXTERNALSYM TB_ADDSTRING}
  TB_ADDSTRING            = TB_ADDSTRINGW;
  {$EXTERNALSYM TB_GETBUTTONTEXT}
  TB_GETBUTTONTEXT        = TB_GETBUTTONTEXTW;
  {$EXTERNALSYM TBN_GETBUTTONINFO}
  TBN_GETBUTTONINFO       = TBN_GETBUTTONINFOW;
{$ELSE}
  {$EXTERNALSYM TB_SAVERESTORE}
  TB_SAVERESTORE          = TB_SAVERESTOREA;
  {$EXTERNALSYM TB_ADDSTRING}
  TB_ADDSTRING            = TB_ADDSTRINGA;
  {$EXTERNALSYM TB_GETBUTTONTEXT}
  TB_GETBUTTONTEXT        = TB_GETBUTTONTEXTA;
  {$EXTERNALSYM TBN_GETBUTTONINFO}
  TBN_GETBUTTONINFO       = TBN_GETBUTTONINFOA;
{$ENDIF}

  {$EXTERNALSYM TB_CUSTOMIZE}
  TB_CUSTOMIZE            = WM_USER + 27;
  {$EXTERNALSYM TB_GETITEMRECT}
  TB_GETITEMRECT          = WM_USER + 29;
  {$EXTERNALSYM TB_BUTTONSTRUCTSIZE}
  TB_BUTTONSTRUCTSIZE     = WM_USER + 30;
  {$EXTERNALSYM TB_SETBUTTONSIZE}
  TB_SETBUTTONSIZE        = WM_USER + 31;
  {$EXTERNALSYM TB_SETBITMAPSIZE}
  TB_SETBITMAPSIZE        = WM_USER + 32;
  {$EXTERNALSYM TB_AUTOSIZE}
  TB_AUTOSIZE             = WM_USER + 33;
  {$EXTERNALSYM TB_GETTOOLTIPS}
  TB_GETTOOLTIPS          = WM_USER + 35;
  {$EXTERNALSYM TB_SETTOOLTIPS}
  TB_SETTOOLTIPS          = WM_USER + 36;
  {$EXTERNALSYM TB_SETPARENT}
  TB_SETPARENT            = WM_USER + 37;
  {$EXTERNALSYM TB_SETROWS}
  TB_SETROWS              = WM_USER + 39;
  {$EXTERNALSYM TB_GETROWS}
  TB_GETROWS              = WM_USER + 40;
  {$EXTERNALSYM TB_SETCMDID}
  TB_SETCMDID             = WM_USER + 42;
  {$EXTERNALSYM TB_CHANGEBITMAP}
  TB_CHANGEBITMAP         = WM_USER + 43;
  {$EXTERNALSYM TB_GETBITMAP}
  TB_GETBITMAP            = WM_USER + 44;
  {$EXTERNALSYM TB_REPLACEBITMAP}
  TB_REPLACEBITMAP        = WM_USER + 46;
  {$EXTERNALSYM TB_SETINDENT}
  TB_SETINDENT            = WM_USER + 47;
  {$EXTERNALSYM TB_SETIMAGELIST}
  TB_SETIMAGELIST         = WM_USER + 48;
  {$EXTERNALSYM TB_GETIMAGELIST}
  TB_GETIMAGELIST         = WM_USER + 49;
  {$EXTERNALSYM TB_LOADIMAGES}
  TB_LOADIMAGES           = WM_USER + 50;
  {$EXTERNALSYM TB_GETRECT}
  TB_GETRECT              = WM_USER + 51; { wParam is the Cmd instead of index }
  {$EXTERNALSYM TB_SETHOTIMAGELIST}
  TB_SETHOTIMAGELIST      = WM_USER + 52;
  {$EXTERNALSYM TB_GETHOTIMAGELIST}
  TB_GETHOTIMAGELIST      = WM_USER + 53;
  {$EXTERNALSYM TB_SETDISABLEDIMAGELIST}
  TB_SETDISABLEDIMAGELIST = WM_USER + 54;
  {$EXTERNALSYM TB_GETDISABLEDIMAGELIST}
  TB_GETDISABLEDIMAGELIST = WM_USER + 55;
  {$EXTERNALSYM TB_SETSTYLE}
  TB_SETSTYLE             = WM_USER + 56;
  {$EXTERNALSYM TB_GETSTYLE}
  TB_GETSTYLE             = WM_USER + 57;
  {$EXTERNALSYM TB_GETBUTTONSIZE}
  TB_GETBUTTONSIZE        = WM_USER + 58;
  {$EXTERNALSYM TB_SETBUTTONWIDTH}
  TB_SETBUTTONWIDTH       = WM_USER + 59;
  {$EXTERNALSYM TB_SETMAXTEXTROWS}
  TB_SETMAXTEXTROWS       = WM_USER + 60;
  {$EXTERNALSYM TB_GETTEXTROWS}
  TB_GETTEXTROWS          = WM_USER + 61;

  {$EXTERNALSYM TB_GETOBJECT}
  TB_GETOBJECT            = WM_USER + 62;  // wParam == IID, lParam void **ppv
  {$EXTERNALSYM TB_GETHOTITEM}
  TB_GETHOTITEM           = WM_USER + 71;
  {$EXTERNALSYM TB_SETHOTITEM}
  TB_SETHOTITEM           = WM_USER + 72;  // wParam == iHotItem
  {$EXTERNALSYM TB_SETANCHORHIGHLIGHT}
  TB_SETANCHORHIGHLIGHT   = WM_USER + 73;  // wParam == TRUE/FALSE
  {$EXTERNALSYM TB_GETANCHORHIGHLIGHT}
  TB_GETANCHORHIGHLIGHT   = WM_USER + 74;
  {$EXTERNALSYM TB_MAPACCELERATORA}
  TB_MAPACCELERATORA      = WM_USER + 78;  // wParam == ch, lParam int * pidBtn

type
  {$EXTERNALSYM TBINSERTMARK}
  TBINSERTMARK = record
    iButton: Integer;
    dwFlags: DWORD;
  end;
  PTBInsertMark = ^TTBInsertMark;
  TTBInsertMark = TBINSERTMARK;

const
  {$EXTERNALSYM TBIMHT_AFTER}
  TBIMHT_AFTER      = $00000001; // TRUE = insert After iButton, otherwise before
  {$EXTERNALSYM TBIMHT_BACKGROUND}
  TBIMHT_BACKGROUND = $00000002; // TRUE iff missed buttons completely

  {$EXTERNALSYM TB_GETINSERTMARK}
  TB_GETINSERTMARK        = WM_USER + 79;  // lParam == LPTBINSERTMARK
  {$EXTERNALSYM TB_SETINSERTMARK}
  TB_SETINSERTMARK        = WM_USER + 80;  // lParam == LPTBINSERTMARK
  {$EXTERNALSYM TB_INSERTMARKHITTEST}
  TB_INSERTMARKHITTEST    = WM_USER + 81;  // wParam == LPPOINT lParam == LPTBINSERTMARK
  {$EXTERNALSYM TB_MOVEBUTTON}
  TB_MOVEBUTTON           = WM_USER + 82;
  {$EXTERNALSYM TB_GETMAXSIZE}
  TB_GETMAXSIZE           = WM_USER + 83;  // lParam == LPSIZE
  {$EXTERNALSYM TB_SETEXTENDEDSTYLE}
  TB_SETEXTENDEDSTYLE     = WM_USER + 84;  // For TBSTYLE_EX_*
  {$EXTERNALSYM TB_GETEXTENDEDSTYLE}
  TB_GETEXTENDEDSTYLE     = WM_USER + 85;  // For TBSTYLE_EX_*
  {$EXTERNALSYM TB_GETPADDING}
  TB_GETPADDING           = WM_USER + 86;
  {$EXTERNALSYM TB_SETPADDING}
  TB_SETPADDING           = WM_USER + 87;
  {$EXTERNALSYM TB_SETINSERTMARKCOLOR}
  TB_SETINSERTMARKCOLOR   = WM_USER + 88;
  {$EXTERNALSYM TB_GETINSERTMARKCOLOR}
  TB_GETINSERTMARKCOLOR   = WM_USER + 89;

  {$EXTERNALSYM TB_SETCOLORSCHEME}
  TB_SETCOLORSCHEME       = CCM_SETCOLORSCHEME;  // lParam is color scheme
  {$EXTERNALSYM TB_GETCOLORSCHEME}
  TB_GETCOLORSCHEME       = CCM_GETCOLORSCHEME;	// fills in COLORSCHEME pointed to by lParam

  {$EXTERNALSYM TB_SETUNICODEFORMAT}
  TB_SETUNICODEFORMAT     = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM TB_GETUNICODEFORMAT}
  TB_GETUNICODEFORMAT     = CCM_GETUNICODEFORMAT;

  {$EXTERNALSYM TB_MAPACCELERATORW}
  TB_MAPACCELERATORW      = WM_USER + 90;  // wParam == ch, lParam int * pidBtn
{$IFDEF UNICODE}
  {$EXTERNALSYM TB_MAPACCELERATOR}
  TB_MAPACCELERATOR       = TB_MAPACCELERATORW;
{$ELSE}
  {$EXTERNALSYM TB_MAPACCELERATOR}
  TB_MAPACCELERATOR       = TB_MAPACCELERATORA;
{$ENDIF}

type
  {$EXTERNALSYM TBREPLACEBITMAP}
  TBREPLACEBITMAP = record
    hInstOld: HINST;
    nIDOld: UINT_PTR;
    hInstNew: HINST;
    nIDNew: UINT_PTR;
    nButtons: Integer;
  end;
  PTBReplaceBitmap = ^TTBReplaceBitmap;
  TTBReplaceBitmap = TBREPLACEBITMAP;

const
  {$EXTERNALSYM TBBF_LARGE}
  TBBF_LARGE              = $0001;

  {$EXTERNALSYM TB_GETBITMAPFLAGS}
  TB_GETBITMAPFLAGS       = WM_USER + 41;

  {$EXTERNALSYM TBIF_IMAGE}
  TBIF_IMAGE              = $00000001;
  {$EXTERNALSYM TBIF_TEXT}
  TBIF_TEXT               = $00000002;
  {$EXTERNALSYM TBIF_STATE}
  TBIF_STATE              = $00000004;
  {$EXTERNALSYM TBIF_STYLE}
  TBIF_STYLE              = $00000008;
  {$EXTERNALSYM TBIF_LPARAM}
  TBIF_LPARAM             = $00000010;
  {$EXTERNALSYM TBIF_COMMAND}
  TBIF_COMMAND            = $00000020;
  {$EXTERNALSYM TBIF_SIZE}
  TBIF_SIZE               = $00000040;
  {$EXTERNALSYM TBIF_BYINDEX}
  TBIF_BYINDEX            = $80000000;

type
  {$EXTERNALSYM TBBUTTONINFOA}
  TBBUTTONINFOA = record
    cbSize: UINT;
    dwMask: DWORD;
    idCommand: Integer;
    iImage: Integer;
    fsState: Byte;
    fsStyle: Byte;
    cx: Word;
    lParam: DWORD_PTR;
    pszText: LPSTR;
    cchText: Integer;
  end;
  {$EXTERNALSYM TBBUTTONINFOW}
  TBBUTTONINFOW = record
    cbSize: UINT;
    dwMask: DWORD;
    idCommand: Integer;
    iImage: Integer;
    fsState: Byte;
    fsStyle: Byte;
    cx: Word;
    lParam: DWORD_PTR;
    pszText: LPWSTR;
    cchText: Integer;
  end;
  {$EXTERNALSYM TBBUTTONINFO}
  TBBUTTONINFO = TBBUTTONINFOW;
  PTBButtonInfoA = ^TTBButtonInfoA;
  PTBButtonInfoW = ^TTBButtonInfoW;
  PTBButtonInfo = PTBButtonInfoW;
  TTBButtonInfoA = TBBUTTONINFOA;
  TTBButtonInfoW = TBBUTTONINFOW;
  TTBButtonInfo = TTBButtonInfoW;

const
  // BUTTONINFO APIs do NOT support the string pool.
  {$EXTERNALSYM TB_GETBUTTONINFOW}
  TB_GETBUTTONINFOW        = WM_USER + 63;
  {$EXTERNALSYM TB_SETBUTTONINFOW}
  TB_SETBUTTONINFOW        = WM_USER + 64;
  {$EXTERNALSYM TB_GETBUTTONINFOA}
  TB_GETBUTTONINFOA        = WM_USER + 65;
  {$EXTERNALSYM TB_SETBUTTONINFOA}
  TB_SETBUTTONINFOA        = WM_USER + 66;
{$IFDEF UNICODE}
  {$EXTERNALSYM TB_GETBUTTONINFO}
  TB_GETBUTTONINFO         = TB_GETBUTTONINFOW;
  {$EXTERNALSYM TB_SETBUTTONINFO}
  TB_SETBUTTONINFO         = TB_SETBUTTONINFOW;
{$ELSE}
  {$EXTERNALSYM TB_GETBUTTONINFO}
  TB_GETBUTTONINFO         = TB_GETBUTTONINFOA;
  {$EXTERNALSYM TB_SETBUTTONINFO}
  TB_SETBUTTONINFO         = TB_SETBUTTONINFOA;
{$ENDIF}

  {$EXTERNALSYM TB_INSERTBUTTONW}
  TB_INSERTBUTTONW        = WM_USER + 67;
  {$EXTERNALSYM TB_ADDBUTTONSW}
  TB_ADDBUTTONSW          = WM_USER + 68;

  {$EXTERNALSYM TB_HITTEST}
  TB_HITTEST              = WM_USER + 69;

  // New post Win95/NT4 for InsertButton and AddButton.  if iString member
  // is a pointer to a string, it will be handled as a string like listview
  // = although LPSTR_TEXTCALLBACK is not supported;.
{$IFDEF UNICODE}
  {$EXTERNALSYM TB_INSERTBUTTON}
  TB_INSERTBUTTON         = TB_INSERTBUTTONW;
  {$EXTERNALSYM TB_ADDBUTTONS}
  TB_ADDBUTTONS           = TB_ADDBUTTONSW;
{$ELSE}
  {$EXTERNALSYM TB_INSERTBUTTON}
  TB_INSERTBUTTON         = TB_INSERTBUTTONA;
  {$EXTERNALSYM TB_ADDBUTTONS}
  TB_ADDBUTTONS           = TB_ADDBUTTONSA;
{$ENDIF}

  {$EXTERNALSYM TB_SETDRAWTEXTFLAGS}
  TB_SETDRAWTEXTFLAGS     = WM_USER + 70;  // wParam == mask lParam == bit values

  {$EXTERNALSYM TB_GETSTRINGW}
  TB_GETSTRINGW           = WM_USER + 91;
  {$EXTERNALSYM TB_GETSTRINGA}
  TB_GETSTRINGA           = WM_USER + 92;
  {$EXTERNALSYM TB_GETSTRING}
{$IFDEF UNICODE}
  TB_GETSTRING            = TB_GETSTRINGW;
{$ELSE}
  TB_GETSTRING            = TB_GETSTRINGA;
{$ENDIF}

  {$EXTERNALSYM TB_SETHOTITEM2}
  TB_SETHOTITEM2          = WM_USER + 94;  // wParam == iHotItem,  lParam = dwFlags
  {$EXTERNALSYM TB_SETLISTGAP}
  TB_SETLISTGAP           = WM_USER + 96;
  {$EXTERNALSYM TB_GETIMAGELISTCOUNT}
  TB_GETIMAGELISTCOUNT    = WM_USER + 98;
  {$EXTERNALSYM TB_GETIDEALSIZE}
  TB_GETIDEALSIZE         = WM_USER + 99;  // wParam == fHeight, lParam = psize

  { For Windows >= XP }
  {$EXTERNALSYM TBMF_PAD}
  TBMF_PAD                = $00000001;
  {$EXTERNALSYM TBMF_BARPAD}
  TBMF_BARPAD             = $00000002;
  {$EXTERNALSYM TBMF_BUTTONSPACING}
  TBMF_BUTTONSPACING      = $00000004;

type
  { For Windows >= XP }
  { $EXTERNALSYM TBMETRICSA}
  TBMETRICSA = record
    cbSize: UINT;
    dwMask: DWORD;

    cxPad: Integer;   { PAD }
    cyPad: Integer;
    cxBarPad: Integer;{ BARPAD }
    cyBarPad: Integer;
    cxButtonSpacing: Integer;{ BUTTONSPACING }
    cyButtonSpacing: Integer;
  end;
  { $EXTERNALSYM TBMETRICSW}
  TBMETRICSW = record
    cbSize: UINT;
    dwMask: DWORD;

    cxPad: Integer;   { PAD }
    cyPad: Integer;
    cxBarPad: Integer;{ BARPAD }
    cyBarPad: Integer;
    cxButtonSpacing: Integer;{ BUTTONSPACING }
    cyButtonSpacing: Integer;
  end;
  {$EXTERNALSYM TBMETRICS}
  TBMETRICS = TBMETRICSW;
  PTBMetricsA = ^TTBMetricsA;
  PTBMetricsW = ^TTBMetricsW;
  PTBMetrics = PTBMetricsW;
  TTBMetricsA = TBMETRICSA;
  TTBMetricsW = TBMETRICSW;
  TTBMetrics = TTBMetricsW;

const
  { For Windows >= XP }
  {$EXTERNALSYM TB_GETMETRICS}
  TB_GETMETRICS           = WM_USER + 101;
  {$EXTERNALSYM TB_SETMETRICS}
  TB_SETMETRICS           = WM_USER + 102;

  { _WIN32_WINNT >= 0x600 Windows >= Vista }
  {$EXTERNALSYM TB_GETITEMDROPDOWNRECT}
  TB_GETITEMDROPDOWNRECT  = WM_USER + 103; // Rect of item's drop down button
  {$EXTERNALSYM TB_SETPRESSEDIMAGELIST}
  TB_SETPRESSEDIMAGELIST  = WM_USER + 104;
  {$EXTERNALSYM TB_GETPRESSEDIMAGELIST}
  TB_GETPRESSEDIMAGELIST  = WM_USER + 105;

  { _WIN32_WINNT >= 0x0501 Windows >= XP }
  {$EXTERNALSYM TB_SETWINDOWTHEME}
  TB_SETWINDOWTHEME       = CCM_SETWINDOWTHEME;

const
  {$EXTERNALSYM TBN_BEGINDRAG}
  TBN_BEGINDRAG           = TBN_FIRST-1;
  {$EXTERNALSYM TBN_ENDDRAG}
  TBN_ENDDRAG             = TBN_FIRST-2;
  {$EXTERNALSYM TBN_BEGINADJUST}
  TBN_BEGINADJUST         = TBN_FIRST-3;
  {$EXTERNALSYM TBN_ENDADJUST}
  TBN_ENDADJUST           = TBN_FIRST-4;
  {$EXTERNALSYM TBN_RESET}
  TBN_RESET               = TBN_FIRST-5;
  {$EXTERNALSYM TBN_QUERYINSERT}
  TBN_QUERYINSERT         = TBN_FIRST-6;
  {$EXTERNALSYM TBN_QUERYDELETE}
  TBN_QUERYDELETE         = TBN_FIRST-7;
  {$EXTERNALSYM TBN_TOOLBARCHANGE}
  TBN_TOOLBARCHANGE       = TBN_FIRST-8;
  {$EXTERNALSYM TBN_CUSTHELP}
  TBN_CUSTHELP            = TBN_FIRST-9;
  {$EXTERNALSYM TBN_DROPDOWN}
  TBN_DROPDOWN            = TBN_FIRST-10;
  {$EXTERNALSYM TBN_CLOSEUP}
  TBN_CLOSEUP             = TBN_FIRST-11;
  {$EXTERNALSYM TBN_GETOBJECT}
  TBN_GETOBJECT           = TBN_FIRST-12;
  {$EXTERNALSYM TBN_RESTORE}
  TBN_RESTORE             = TBN_FIRST-21;
  {$EXTERNALSYM TBN_SAVE}
  TBN_SAVE                = TBN_FIRST-22;

type
  // Structure for TBN_HOTITEMCHANGE notification
  {$EXTERNALSYM tagNMTBHOTITEM}
  tagNMTBHOTITEM = record
    hdr: TNMHdr;
    idOld: Integer;
    idNew: Integer;
    dwFlags: DWORD;           // HICF_*
  end;
  PNMTBHotItem = ^TNMTBHotItem;
  TNMTBHotItem = tagNMTBHOTITEM;

const
  // Hot item change flags
  {$EXTERNALSYM HICF_OTHER}
  HICF_OTHER          = $00000000;
  {$EXTERNALSYM HICF_MOUSE}
  HICF_MOUSE          = $00000001;          // Triggered by mouse
  {$EXTERNALSYM HICF_ARROWKEYS}
  HICF_ARROWKEYS      = $00000002;          // Triggered by arrow keys
  {$EXTERNALSYM HICF_ACCELERATOR}
  HICF_ACCELERATOR    = $00000004;          // Triggered by accelerator
  {$EXTERNALSYM HICF_DUPACCEL}
  HICF_DUPACCEL       = $00000008;          // This accelerator is not unique
  {$EXTERNALSYM HICF_ENTERING}
  HICF_ENTERING       = $00000010;          // idOld is invalid
  {$EXTERNALSYM HICF_LEAVING}
  HICF_LEAVING        = $00000020;          // idNew is invalid
  {$EXTERNALSYM HICF_RESELECT}
  HICF_RESELECT       = $00000040;          // hot item reselected

  {$EXTERNALSYM TBN_HOTITEMCHANGE}
  TBN_HOTITEMCHANGE       = TBN_FIRST - 13;
  {$EXTERNALSYM TBN_DRAGOUT}
  TBN_DRAGOUT             = TBN_FIRST - 14; // this is sent when the user clicks down on a button then drags off the button
  {$EXTERNALSYM TBN_DELETINGBUTTON}
  TBN_DELETINGBUTTON      = TBN_FIRST - 15; // uses TBNOTIFY
  {$EXTERNALSYM TBN_GETDISPINFOA}
  TBN_GETDISPINFOA        = TBN_FIRST - 16; // This is sent when the  toolbar needs  some display information
  {$EXTERNALSYM TBN_GETDISPINFOW}
  TBN_GETDISPINFOW        = TBN_FIRST - 17; // This is sent when the  toolbar needs  some display information
  {$EXTERNALSYM TBN_GETINFOTIPA}
  TBN_GETINFOTIPA         = TBN_FIRST - 18;
  {$EXTERNALSYM TBN_GETINFOTIPW}
  TBN_GETINFOTIPW         = TBN_FIRST - 19;

  {$EXTERNALSYM TBN_INITCUSTOMIZE}
  TBN_INITCUSTOMIZE       = TBN_FIRST - 23;
  {$EXTERNALSYM TBNRF_HIDEHELP}
  TBNRF_HIDEHELP        = $00000001;
  {$EXTERNALSYM TBNRF_ENDCUSTOMIZE}
  TBNRF_ENDCUSTOMIZE    = $00000002;
  {$EXTERNALSYM TBN_WRAPHOTITEM}
  TBN_WRAPHOTITEM         = TBN_FIRST - 24;
  {$EXTERNALSYM TBN_DUPACCELERATOR}
  TBN_DUPACCELERATOR      = TBN_FIRST - 25;
  {$EXTERNALSYM TBN_WRAPACCELERATOR}
  TBN_WRAPACCELERATOR     = TBN_FIRST - 26;
  {$EXTERNALSYM TBN_DRAGOVER}
  TBN_DRAGOVER            = TBN_FIRST - 27;
  {$EXTERNALSYM TBN_MAPACCELERATOR}
  TBN_MAPACCELERATOR      = TBN_FIRST - 28;

type
  {$EXTERNALSYM tagNMTBSAVE}
  tagNMTBSAVE = record
    hdr: TNMHdr;
    pData: PDWORD;
    pCurrent: PDWORD;
    cbData: UINT;
    iItem: Integer;
    cButtons: Integer;
    tbButton: TTBButton;
  end;
  PNMTBSave = ^TNMTBSave;
  TNMTBSave = tagNMTBSAVE;

  {$EXTERNALSYM tagNMTBRESTORE}
  tagNMTBRESTORE = record
    hdr: TNMHdr;
    pData: PDWORD;
    pCurrent: PDWORD;
    cbData: UINT;
    iItem: Integer;
    cButtons: Integer;
    cbBytesPerRecord: Integer;
    tbButton: TTBButton;
  end;
  PNMTBRestore = ^TNMTBRestore;
  TNMTBRestore = tagNMTBRESTORE;

  {$EXTERNALSYM tagNMTBGETINFOTIPA}
  tagNMTBGETINFOTIPA = record
    hdr: TNMHdr;
    pszText: LPSTR;
    cchTextMax: Integer;
    iItem: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMTBGETINFOTIPW}
  tagNMTBGETINFOTIPW = record
    hdr: TNMHdr;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iItem: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMTBGETINFOTIP}
  tagNMTBGETINFOTIP = tagNMTBGETINFOTIPW;
  PNMTBGetInfoTipA = ^TNMTBGetInfoTipA;
  PNMTBGetInfoTipW = ^TNMTBGetInfoTipW;
  PNMTBGetInfoTip = PNMTBGetInfoTipW;
  TNMTBGetInfoTipA = tagNMTBGETINFOTIPA;
  TNMTBGetInfoTipW = tagNMTBGETINFOTIPW;
  TNMTBGetInfoTip = TNMTBGetInfoTipW;

const
  {$EXTERNALSYM TBNF_IMAGE}
  TBNF_IMAGE              = $00000001;
  {$EXTERNALSYM TBNF_TEXT}
  TBNF_TEXT               = $00000002;
  {$EXTERNALSYM TBNF_DI_SETITEM}
  TBNF_DI_SETITEM         = $10000000;

type
  {$EXTERNALSYM NMTBDISPINFOA}
  NMTBDISPINFOA = record
    hdr: TNMHdr;
    dwMask: DWORD;      // [in] Specifies the values requested .[out] Client ask the data to be set for future use
    idCommand: Integer; // [in] id of button we're requesting info for
    lParam: DWORD_PTR;  // [in] lParam of button
    iImage: Integer;    // [out] image index
    pszText: LPSTR;    // [out] new text for item
    cchText: Integer;   // [in] size of buffer pointed to by pszText
  end;
  {$EXTERNALSYM NMTBDISPINFOW}
  NMTBDISPINFOW = record
    hdr: TNMHdr;
    dwMask: DWORD;      // [in] Specifies the values requested .[out] Client ask the data to be set for future use
    idCommand: Integer; // [in] id of button we're requesting info for
    lParam: DWORD_PTR;  // [in] lParam of button
    iImage: Integer;    // [out] image index
    pszText: LPWSTR;    // [out] new text for item
    cchText: Integer;   // [in] size of buffer pointed to by pszText
  end;
  {$EXTERNALSYM NMTBDISPINFO}
  NMTBDISPINFO = NMTBDISPINFOW;
  PNMTBDispInfoA = ^TNMTBDispInfoA;
  PNMTBDispInfoW = ^TNMTBDispInfoW;
  PNMTBDispInfo = PNMTBDispInfoW;
  TNMTBDispInfoA = NMTBDISPINFOA;
  TNMTBDispInfoW = NMTBDISPINFOW;
  TNMTBDispInfo = TNMTBDispInfoW;

const
  // Return codes for TBN_DROPDOWN
  {$EXTERNALSYM TBDDRET_DEFAULT}
  TBDDRET_DEFAULT         = 0;
  {$EXTERNALSYM TBDDRET_NODEFAULT}
  TBDDRET_NODEFAULT       = 1;
  {$EXTERNALSYM TBDDRET_TREATPRESSED}
  TBDDRET_TREATPRESSED    = 2;       // Treat as a standard press button

type
  {$EXTERNALSYM tagNMTOOLBARA}
  tagNMTOOLBARA = record
    hdr: TNMHdr;
    iItem: Integer;
    tbButton: TTBButton;
    cchText: Integer;
    pszText: LPSTR;
    rcButon: TRect;
  end;
  {$EXTERNALSYM tagNMTOOLBARW}
  tagNMTOOLBARW = record
    hdr: TNMHdr;
    iItem: Integer;
    tbButton: TTBButton;
    cchText: Integer;
    pszText: LPWSTR;
    rcButon: TRect;
  end;
  {$EXTERNALSYM tagNMTOOLBAR}
  tagNMTOOLBAR = tagNMTOOLBARW;
  PNMToolBarA = ^TNMToolBarA;
  PNMToolBarW = ^TNMToolBarW;
  PNMToolBar = PNMToolBarW;
  TNMToolBarA = tagNMTOOLBARA;
  TNMToolBarW = tagNMTOOLBARW;
  TNMToolBar = TNMToolBarW;

{ ====== REBAR CONTROL =================== }

const
  {$EXTERNALSYM REBARCLASSNAME}
  REBARCLASSNAME = 'ReBarWindow32';

type
  {$EXTERNALSYM tagREBARINFO}
  tagREBARINFO = record
    cbSize: UINT;
    fMask: UINT;
    himl: HIMAGELIST;
  end;
  PReBarInfo = ^TReBarInfo;
  TReBarInfo = tagREBARINFO;

const
  {$EXTERNALSYM RBIM_IMAGELIST}
  RBIM_IMAGELIST    = $00000001;

  {$EXTERNALSYM RBS_TOOLTIPS}
  RBS_TOOLTIPS      = $00000100;
  {$EXTERNALSYM RBS_VARHEIGHT}
  RBS_VARHEIGHT     = $00000200;
  {$EXTERNALSYM RBS_BANDBORDERS}
  RBS_BANDBORDERS   = $00000400;
  {$EXTERNALSYM RBS_FIXEDORDER}
  RBS_FIXEDORDER    = $00000800;

  {$EXTERNALSYM RBS_REGISTERDROP}
  RBS_REGISTERDROP  = $00001000;
  {$EXTERNALSYM RBS_AUTOSIZE}
  RBS_AUTOSIZE      = $00002000;
  {$EXTERNALSYM RBS_VERTICALGRIPPER}
  RBS_VERTICALGRIPPER = $00004000;  // this always has the vertical gripper (default for horizontal mode)
  {$EXTERNALSYM RBS_DBLCLKTOGGLE}
  RBS_DBLCLKTOGGLE  = $00008000;

  {$EXTERNALSYM RBBS_BREAK}
  RBBS_BREAK        = $00000001;  // break to new line
  {$EXTERNALSYM RBBS_FIXEDSIZE}
  RBBS_FIXEDSIZE    = $00000002;  // band can't be sized
  {$EXTERNALSYM RBBS_CHILDEDGE}
  RBBS_CHILDEDGE    = $00000004;  // edge around top and bottom of child window
  {$EXTERNALSYM RBBS_HIDDEN}
  RBBS_HIDDEN       = $00000008;  // don't show
  {$EXTERNALSYM RBBS_NOVERT}
  RBBS_NOVERT       = $00000010;  // don't show when vertical
  {$EXTERNALSYM RBBS_FIXEDBMP}
  RBBS_FIXEDBMP     = $00000020;  // bitmap doesn't move during band resize
  {$EXTERNALSYM RBBS_VARIABLEHEIGHT}
  RBBS_VARIABLEHEIGHT = $00000040;  // allow autosizing of this child vertically
  {$EXTERNALSYM RBBS_GRIPPERALWAYS}
  RBBS_GRIPPERALWAYS  = $00000080;  // always show the gripper
  {$EXTERNALSYM RBBS_NOGRIPPER}
  RBBS_NOGRIPPER      = $00000100;  // never show the gripper
  { For IE >= 0x0500 }
  {$EXTERNALSYM RBBS_USECHEVRON}
  RBBS_USECHEVRON     = $00000200;  { display drop-down button for this band if it's sized smaller than ideal width }
  { For IE >= 0x0501 }
  {$EXTERNALSYM RBBS_HIDETITLE}
  RBBS_HIDETITLE      = $00000400;  { keep band title hidden }
  {$EXTERNALSYM RBBS_TOPALIGN}
  RBBS_TOPALIGN       = $00000800;  { keep band in top row }

  {$EXTERNALSYM RBBIM_STYLE}
  RBBIM_STYLE       = $00000001;
  {$EXTERNALSYM RBBIM_COLORS}
  RBBIM_COLORS      = $00000002;
  {$EXTERNALSYM RBBIM_TEXT}
  RBBIM_TEXT        = $00000004;
  {$EXTERNALSYM RBBIM_IMAGE}
  RBBIM_IMAGE       = $00000008;
  {$EXTERNALSYM RBBIM_CHILD}
  RBBIM_CHILD       = $00000010;
  {$EXTERNALSYM RBBIM_CHILDSIZE}
  RBBIM_CHILDSIZE   = $00000020;
  {$EXTERNALSYM RBBIM_SIZE}
  RBBIM_SIZE        = $00000040;
  {$EXTERNALSYM RBBIM_BACKGROUND}
  RBBIM_BACKGROUND  = $00000080;
  {$EXTERNALSYM RBBIM_ID}
  RBBIM_ID          = $00000100;
  {$EXTERNALSYM RBBIM_IDEALSIZE}
  RBBIM_IDEALSIZE     = $00000200;
  {$EXTERNALSYM RBBIM_LPARAM}
  RBBIM_LPARAM        = $00000400;
  {$EXTERNALSYM RBBIM_HEADERSIZE}
  RBBIM_HEADERSIZE    = $00000800;  // control the size of the header
  { For Windows >= Vista }
  {$EXTERNALSYM RBBIM_CHEVRONLOCATION}
  RBBIM_CHEVRONLOCATION = $00001000;
  {$EXTERNALSYM RBBIM_CHEVRONSTATE}
  RBBIM_CHEVRONSTATE    = $00002000;

type
  {$EXTERNALSYM tagREBARBANDINFOA}
  tagREBARBANDINFOA = record
    cbSize: UINT;
    fMask: UINT;
    fStyle: UINT;
    clrFore: TColorRef;
    clrBack: TColorRef;
    lpText: LPSTR;
    cch: UINT;
    iImage: Integer;
    hwndChild: HWnd;
    cxMinChild: UINT;
    cyMinChild: UINT;
    cx: UINT;
    hbmBack: HBitmap;
    wID: UINT;
    
    cyChild: UINT;
    cyMaxChild: UINT;
    cyIntegral: UINT;
    cxIdeal: UINT;
    lParam: LPARAM;
    cxHeader: UINT;
    
                                     
    rcChevronLocation: TRect;       // the rect is in client co-ord wrt hwndChild
    uChevronState: UINT;            // STATE_SYSTEM_*
    
  end;
  {$EXTERNALSYM tagREBARBANDINFOW}
  tagREBARBANDINFOW = record
    cbSize: UINT;
    fMask: UINT;
    fStyle: UINT;
    clrFore: TColorRef;
    clrBack: TColorRef;
    lpText: LPWSTR;
    cch: UINT;
    iImage: Integer;
    hwndChild: HWnd;
    cxMinChild: UINT;
    cyMinChild: UINT;
    cx: UINT;
    hbmBack: HBitmap;
    wID: UINT;
    
    cyChild: UINT;
    cyMaxChild: UINT;
    cyIntegral: UINT;
    cxIdeal: UINT;
    lParam: LPARAM;
    cxHeader: UINT;
    
                                     
    rcChevronLocation: TRect;       // the rect is in client co-ord wrt hwndChild
    uChevronState: UINT;            // STATE_SYSTEM_*
    
  end;
  {$EXTERNALSYM tagREBARBANDINFO}
  tagREBARBANDINFO = tagREBARBANDINFOW;
  PReBarBandInfoA = ^TReBarBandInfoA;
  PReBarBandInfoW = ^TReBarBandInfoW;
  PReBarBandInfo = PReBarBandInfoW;
  TReBarBandInfoA = tagREBARBANDINFOA;
  TReBarBandInfoW = tagREBARBANDINFOW;
  TReBarBandInfo = TReBarBandInfoW;

const
  {$EXTERNALSYM RB_INSERTBANDA}
  RB_INSERTBANDA     = WM_USER +  1;
  {$EXTERNALSYM RB_DELETEBAND}
  RB_DELETEBAND      = WM_USER +  2;
  {$EXTERNALSYM RB_GETBARINFO}
  RB_GETBARINFO      = WM_USER +  3;
  {$EXTERNALSYM RB_SETBARINFO}
  RB_SETBARINFO      = WM_USER +  4;
  RB_GETBANDINFO_PRE_IE4     = WM_USER +  5;
  {$EXTERNALSYM RB_SETBANDINFOA}
  RB_SETBANDINFOA    = WM_USER +  6;
  {$EXTERNALSYM RB_SETPARENT}
  RB_SETPARENT       = WM_USER +  7;
  {$EXTERNALSYM RB_HITTEST}
  RB_HITTEST         = WM_USER +  8;
  {$EXTERNALSYM RB_GETRECT}
  RB_GETRECT         = WM_USER +  9;
  {$EXTERNALSYM RB_INSERTBANDW}
  RB_INSERTBANDW     = WM_USER +  10;
  {$EXTERNALSYM RB_SETBANDINFOW}
  RB_SETBANDINFOW    = WM_USER +  11;
  {$EXTERNALSYM RB_GETBANDCOUNT}
  RB_GETBANDCOUNT    = WM_USER +  12;
  {$EXTERNALSYM RB_GETROWCOUNT}
  RB_GETROWCOUNT     = WM_USER +  13;
  {$EXTERNALSYM RB_GETROWHEIGHT}
  RB_GETROWHEIGHT    = WM_USER +  14;
  {$EXTERNALSYM RB_IDTOINDEX}
  RB_IDTOINDEX       = WM_USER +  16; // wParam == id
  {$EXTERNALSYM RB_GETTOOLTIPS}
  RB_GETTOOLTIPS     = WM_USER +  17;
  {$EXTERNALSYM RB_SETTOOLTIPS}
  RB_SETTOOLTIPS     = WM_USER +  18;
  {$EXTERNALSYM RB_SETBKCOLOR}
  RB_SETBKCOLOR      = WM_USER +  19; // sets the default BK color
  {$EXTERNALSYM RB_GETBKCOLOR}
  RB_GETBKCOLOR      = WM_USER +  20; // defaults to CLR_NONE
  {$EXTERNALSYM RB_SETTEXTCOLOR}
  RB_SETTEXTCOLOR    = WM_USER +  21;
  {$EXTERNALSYM RB_GETTEXTCOLOR}
  RB_GETTEXTCOLOR    = WM_USER +  22; // defaults to 0x00000000
  {$EXTERNALSYM RB_SIZETORECT}
  RB_SIZETORECT      = WM_USER +  23; // resize the rebar/break bands and such to this rect (lparam;

  { For Windows >= XP }
  {$EXTERNALSYM RBSTR_CHANGERECT}
  RBSTR_CHANGERECT            = $0001;   { flags for RB_SIZETORECT }

  {$EXTERNALSYM RB_SETCOLORSCHEME}
  RB_SETCOLORSCHEME   = CCM_SETCOLORSCHEME; { lParam is color scheme }
  {$EXTERNALSYM RB_GETCOLORSCHEME}
  RB_GETCOLORSCHEME   = CCM_GETCOLORSCHEME; { fills in COLORSCHEME pointed to by lParam }

  // for manual drag control
  // lparam == cursor pos
        // -1 means do it yourself.
        // -2 means use what you had saved before
  {$EXTERNALSYM RB_BEGINDRAG}
  RB_BEGINDRAG    = WM_USER + 24;
  {$EXTERNALSYM RB_ENDDRAG}
  RB_ENDDRAG      = WM_USER + 25;
  {$EXTERNALSYM RB_DRAGMOVE}
  RB_DRAGMOVE     = WM_USER + 26;
  {$EXTERNALSYM RB_GETBARHEIGHT}
  RB_GETBARHEIGHT = WM_USER + 27;
  {$EXTERNALSYM RB_GETBANDINFOW}
  RB_GETBANDINFOW = WM_USER + 28;
  {$EXTERNALSYM RB_GETBANDINFOA}
  RB_GETBANDINFOA = WM_USER + 29;

  {$EXTERNALSYM RB_MINIMIZEBAND}
  RB_MINIMIZEBAND = WM_USER + 30;
  {$EXTERNALSYM RB_MAXIMIZEBAND}
  RB_MAXIMIZEBAND = WM_USER + 31;

  {$EXTERNALSYM RB_GETDROPTARGET}
  RB_GETDROPTARGET = CCM_GETDROPTARGET;

  {$EXTERNALSYM RB_GETBANDBORDERS}
  RB_GETBANDBORDERS = WM_USER + 34;  // returns in lparam = lprc the amount of edges added to band wparam

  {$EXTERNALSYM RB_SHOWBAND}
  RB_SHOWBAND     = WM_USER + 35;      // show/hide band

  {$EXTERNALSYM RB_SETPALETTE}
  RB_SETPALETTE   = WM_USER + 37;
  {$EXTERNALSYM RB_GETPALETTE}
  RB_GETPALETTE   = WM_USER + 38;
  {$EXTERNALSYM RB_MOVEBAND}
  RB_MOVEBAND     = WM_USER + 39;

  {$EXTERNALSYM RB_SETUNICODEFORMAT}
  RB_SETUNICODEFORMAT     = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM RB_GETUNICODEFORMAT}
  RB_GETUNICODEFORMAT     = CCM_GETUNICODEFORMAT;

  { For Windows >= XP }
  {$EXTERNALSYM RB_GETBANDMARGINS}
  RB_GETBANDMARGINS   = WM_USER + 40;
  {$EXTERNALSYM RB_SETWINDOWTHEME}
  RB_SETWINDOWTHEME   = CCM_SETWINDOWTHEME;

  { For Windows >= Vista }
  {$EXTERNALSYM RB_SETEXTENDEDSTYLE}
  RB_SETEXTENDEDSTYLE = WM_USER + 41;
  {$EXTERNALSYM RB_GETEXTENDEDSTYLE}
  RB_GETEXTENDEDSTYLE = WM_USER + 42;

  { For IE >= 0x0500 }
  {$EXTERNALSYM RB_PUSHCHEVRON}
  RB_PUSHCHEVRON      = WM_USER + 43;

  { For Windows >= Vista }
  {$EXTERNALSYM RB_SETBANDWIDTH}
  RB_SETBANDWIDTH     = WM_USER + 44;    { set width for docked band }

{$IFDEF UNICODE}
  {$EXTERNALSYM RB_INSERTBAND}
  RB_INSERTBAND      = RB_INSERTBANDW;
  {$EXTERNALSYM RB_SETBANDINFO}
  RB_SETBANDINFO     = RB_SETBANDINFOW;
  {$EXTERNALSYM RB_GETBANDINFO}
  RB_GETBANDINFO     = RB_GETBANDINFOW;
{$ELSE}
  {$EXTERNALSYM RB_INSERTBAND}
  RB_INSERTBAND      = RB_INSERTBANDA;
  {$EXTERNALSYM RB_SETBANDINFO}
  RB_SETBANDINFO     = RB_SETBANDINFOA;
  {$EXTERNALSYM RB_GETBANDINFO}
  RB_GETBANDINFO     = RB_GETBANDINFOA;
{$ENDIF}

  {$EXTERNALSYM RBN_HEIGHTCHANGE}
  RBN_HEIGHTCHANGE   = RBN_FIRST - 0;

  {$EXTERNALSYM RBN_GETOBJECT}
  RBN_GETOBJECT       = RBN_FIRST - 1;
  {$EXTERNALSYM RBN_LAYOUTCHANGED}
  RBN_LAYOUTCHANGED   = RBN_FIRST - 2;
  {$EXTERNALSYM RBN_AUTOSIZE}
  RBN_AUTOSIZE        = RBN_FIRST - 3;
  {$EXTERNALSYM RBN_BEGINDRAG}
  RBN_BEGINDRAG       = RBN_FIRST - 4;
  {$EXTERNALSYM RBN_ENDDRAG}
  RBN_ENDDRAG         = RBN_FIRST - 5;
  {$EXTERNALSYM RBN_DELETINGBAND}
  RBN_DELETINGBAND    = RBN_FIRST - 6;     // Uses NMREBAR
  {$EXTERNALSYM RBN_DELETEDBAND}
  RBN_DELETEDBAND     = RBN_FIRST - 7;     // Uses NMREBAR
  {$EXTERNALSYM RBN_CHILDSIZE}
  RBN_CHILDSIZE       = RBN_FIRST - 8;

  { For IE >= 0x0500 }
  {$EXTERNALSYM RBN_CHEVRONPUSHED}
  RBN_CHEVRONPUSHED   = RBN_FIRST - 10;

  { For IE >= 0x0600 }
  {$EXTERNALSYM RBN_SPLITTERDRAG}
  RBN_SPLITTERDRAG    = RBN_FIRST - 11;

  { For IE >= 0x0500 }
  {$EXTERNALSYM RBN_MINMAX}
  RBN_MINMAX          = RBN_FIRST - 21;

  { For Windows >= XP }
  {$EXTERNALSYM RBN_AUTOBREAK}
  RBN_AUTOBREAK       = RBN_FIRST - 22;

type
  {$EXTERNALSYM tagNMREBARCHILDSIZE}
  tagNMREBARCHILDSIZE = record
    hdr: TNMHdr;
    uBand: UINT;
    wID: UINT;
    rcChild: TRect;
    rcBand: TRect;
  end;
  PNMReBarChildSize = ^TNMReBarChildSize;
  TNMReBarChildSize = tagNMREBARCHILDSIZE;

  {$EXTERNALSYM tagNMREBAR}
  tagNMREBAR = record
    hdr: TNMHdr;
    dwMask: DWORD;           // RBNM_*
    uBand: UINT;
    fStyle: UINT;
    wID: UINT;
    lParam: LPARAM;
  end;
  PNMReBar = ^TNMReBar;
  TNMReBar = tagNMREBAR;

const
  // Mask flags for NMREBAR
  {$EXTERNALSYM RBNM_ID}
  RBNM_ID         = $00000001;
  {$EXTERNALSYM RBNM_STYLE}
  RBNM_STYLE      = $00000002;
  {$EXTERNALSYM RBNM_LPARAM}
  RBNM_LPARAM     = $00000004;

type
  {$EXTERNALSYM tagNMRBAUTOSIZE}
  tagNMRBAUTOSIZE = record
    hdr: TNMHdr;
    fChanged: BOOL;
    rcTarget: TRect;
    rcActual: TRect;
  end;
  PNMRBAutoSize = ^TNMRBAutoSize;
  TNMRBAutoSize = tagNMRBAUTOSIZE;

  { For IE >= 0x0500 }
  {$EXTERNALSYM tagNMREBARCHEVRON}
  tagNMREBARCHEVRON = record
    hdr: NMHDR;
    uBand: UINT;
    wID: UINT;
    lParam: LPARAM;
    rc: TRect;
    lParamNM: LPARAM;
  end;
  PNMReBarChevron = ^TNMReBarChevron;
  TNMReBarChevron = tagNMREBARCHEVRON;

  { For IE >= 0x0600 }
  { $EXTERNALSYM tagNMREBARSPLITTER}
  tagNMREBARSPLITTER = record
    hdr: NMHDR;
    rcSizing: TRect;
  end;
  PNMReBarSplitter = ^TNMReBarSplitter;
  TNMReBarSplitter = tagNMREBARSPLITTER;

const
  { For Windows >= XP }
  {$EXTERNALSYM RBAB_AUTOSIZE}
  RBAB_AUTOSIZE   = $0001;   { These are not flags and are all mutually exclusive }
  {$EXTERNALSYM RBAB_ADDBAND}
  RBAB_ADDBAND    = $0002;

type
  { $EXTERNALSYM tagNMREBARAUTOBREAK}
  tagNMREBARAUTOBREAK = record
    hdr: NMHDR;
    uBand: UINT;
    wID: UINT;
    lParam: LPARAM;
    uMsg: UINT;
    fStyleCurrent: UINT;
    fAutoBreak: BOOL;
  end;
  PNMReBarAutoBreak = ^TNMReBarAutoBreak;
  TNMReBarAutoBreak = tagNMREBARAUTOBREAK;

const
  {$EXTERNALSYM RBHT_NOWHERE}
  RBHT_NOWHERE    = $0001;
  {$EXTERNALSYM RBHT_CAPTION}
  RBHT_CAPTION    = $0002;
  {$EXTERNALSYM RBHT_CLIENT}
  RBHT_CLIENT     = $0003;
  {$EXTERNALSYM RBHT_GRABBER}
  RBHT_GRABBER    = $0004;
  { For IE >= 0x0500 }
  {$EXTERNALSYM RBHT_CHEVRON}
  RBHT_CHEVRON    = $0008;
  { For IE >= 0x0600 }
  {$EXTERNALSYM RBHT_SPLITTER}
  RBHT_SPLITTER   = $0010;

type
  {$EXTERNALSYM _RB_HITTESTINFO}
  _RB_HITTESTINFO = record
    pt: TPoint;
    flags: UINT;
    iBand: Integer;
  end;
  PRBHitTestInfo = ^TRBHitTestInfo;
  TRBHitTestInfo = _RB_HITTESTINFO;

{ ====== TOOLTIPS CONTROL ========================== }

const
  {$EXTERNALSYM TOOLTIPS_CLASS}
  TOOLTIPS_CLASS = 'tooltips_class32';

type
  PToolInfoA = ^TToolInfoA;
  PToolInfoW = ^TToolInfoW;
  PToolInfo = PToolInfoW;
  {$EXTERNALSYM tagTOOLINFOA}
  tagTOOLINFOA = record
    cbSize: UINT;
    uFlags: UINT;
    hwnd: HWND;
    uId: UIntPtr;
    Rect: TRect;
    hInst: HINST;
    lpszText: LPSTR;
    
    lParam: LPARAM;
    
                                 
    lpReserved: Pointer;
    
  end;
  {$EXTERNALSYM tagTOOLINFOW}
  tagTOOLINFOW = record
    cbSize: UINT;
    uFlags: UINT;
    hwnd: HWND;
    uId: UIntPtr;
    Rect: TRect;
    hInst: HINST;
    lpszText: LPWSTR;
    
    lParam: LPARAM;
    
                                 
    lpReserved: Pointer;
    
  end;
  {$EXTERNALSYM tagTOOLINFO}
  tagTOOLINFO = tagTOOLINFOW;
  TToolInfoA = tagTOOLINFOA;
  TToolInfoW = tagTOOLINFOW;
  TToolInfo = TToolInfoW;
  {$EXTERNALSYM TOOLINFOA}
  TOOLINFOA = tagTOOLINFOA;
  {$EXTERNALSYM TOOLINFOW}
  TOOLINFOW = tagTOOLINFOW;
  {$EXTERNALSYM TOOLINFO}
  TOOLINFO = TOOLINFOW;

const
  {$EXTERNALSYM TTS_ALWAYSTIP}
  TTS_ALWAYSTIP           = $01;
  {$EXTERNALSYM TTS_NOPREFIX}
  TTS_NOPREFIX            = $02;
  { For IE >= 0x0500 }
  {$EXTERNALSYM TTS_NOANIMATE}
  TTS_NOANIMATE           = $10;
  {$EXTERNALSYM TTS_NOFADE}
  TTS_NOFADE              = $20;
  {$EXTERNALSYM TTS_BALLOON}
  TTS_BALLOON             = $40;
  {$EXTERNALSYM TTS_CLOSE}
  TTS_CLOSE               = $80;
  { For Windows >= Vista }
  {$EXTERNALSYM TTS_USEVISUALSTYLE}
  TTS_USEVISUALSTYLE      = $100;  // Use themed hyperlinks

  {$EXTERNALSYM TTF_IDISHWND}
  TTF_IDISHWND            = $0001;

  // Use this to center around trackpoint in trackmode
  // -OR- to center around tool in normal mode.
  // Use TTF_ABSOLUTE to place the tip exactly at the track coords when
  // in tracking mode.  TTF_ABSOLUTE can be used in conjunction with TTF_CENTERTIP
  // to center the tip absolutely about the track point.

  {$EXTERNALSYM TTF_CENTERTIP}
  TTF_CENTERTIP           = $0002;
  {$EXTERNALSYM TTF_RTLREADING}
  TTF_RTLREADING          = $0004;
  {$EXTERNALSYM TTF_SUBCLASS}
  TTF_SUBCLASS            = $0010;
  {$EXTERNALSYM TTF_TRACK}
  TTF_TRACK               = $0020;
  {$EXTERNALSYM TTF_ABSOLUTE}
  TTF_ABSOLUTE            = $0080;
  {$EXTERNALSYM TTF_TRANSPARENT}
  TTF_TRANSPARENT         = $0100;
  {$EXTERNALSYM TTF_PARSELINKS}
  TTF_PARSELINKS          = $1000;  // For IE >= 0x0501 
  {$EXTERNALSYM TTF_DI_SETITEM}
  TTF_DI_SETITEM          = $8000;       // valid only on the TTN_NEEDTEXT callback

  {$EXTERNALSYM TTDT_AUTOMATIC}
  TTDT_AUTOMATIC          = 0;
  {$EXTERNALSYM TTDT_RESHOW}
  TTDT_RESHOW             = 1;
  {$EXTERNALSYM TTDT_AUTOPOP}
  TTDT_AUTOPOP            = 2;
  {$EXTERNALSYM TTDT_INITIAL}
  TTDT_INITIAL            = 3;

  // ToolTip Icons (Set with TTM_SETTITLE)
  {$EXTERNALSYM TTI_NONE}
  TTI_NONE                = 0;
  {$EXTERNALSYM TTI_INFO}
  TTI_INFO                = 1;
  {$EXTERNALSYM TTI_WARNING}
  TTI_WARNING             = 2;
  {$EXTERNALSYM TTI_ERROR}
  TTI_ERROR               = 3;
  { For Windows >= Vista }
  {$EXTERNALSYM TTI_INFO_LARGE}
  TTI_INFO_LARGE          = 4;
  {$EXTERNALSYM TTI_WARNING_LARGE}
  TTI_WARNING_LARGE       = 5;
  {$EXTERNALSYM TTI_ERROR_LARGE}
  TTI_ERROR_LARGE         = 6;

  // Tool Tip Messages
  {$EXTERNALSYM TTM_ACTIVATE}
  TTM_ACTIVATE            = WM_USER + 1;
  {$EXTERNALSYM TTM_SETDELAYTIME}
  TTM_SETDELAYTIME        = WM_USER + 3;

  {$EXTERNALSYM TTM_ADDTOOLA}
  TTM_ADDTOOLA             = WM_USER + 4;
  {$EXTERNALSYM TTM_DELTOOLA}
  TTM_DELTOOLA             = WM_USER + 5;
  {$EXTERNALSYM TTM_NEWTOOLRECTA}
  TTM_NEWTOOLRECTA         = WM_USER + 6;
  {$EXTERNALSYM TTM_GETTOOLINFOA}
  TTM_GETTOOLINFOA         = WM_USER + 8;
  {$EXTERNALSYM TTM_SETTOOLINFOA}
  TTM_SETTOOLINFOA         = WM_USER + 9;
  {$EXTERNALSYM TTM_HITTESTA}
  TTM_HITTESTA             = WM_USER + 10;
  {$EXTERNALSYM TTM_GETTEXTA}
  TTM_GETTEXTA             = WM_USER + 11;
  {$EXTERNALSYM TTM_UPDATETIPTEXTA}
  TTM_UPDATETIPTEXTA       = WM_USER + 12;
  {$EXTERNALSYM TTM_ENUMTOOLSA}
  TTM_ENUMTOOLSA           = WM_USER + 14;
  {$EXTERNALSYM TTM_GETCURRENTTOOLA}
  TTM_GETCURRENTTOOLA      = WM_USER + 15;

  {$EXTERNALSYM TTM_ADDTOOLW}
  TTM_ADDTOOLW             = WM_USER + 50;
  {$EXTERNALSYM TTM_DELTOOLW}
  TTM_DELTOOLW             = WM_USER + 51;
  {$EXTERNALSYM TTM_NEWTOOLRECTW}
  TTM_NEWTOOLRECTW         = WM_USER + 52;
  {$EXTERNALSYM TTM_GETTOOLINFOW}
  TTM_GETTOOLINFOW         = WM_USER + 53;
  {$EXTERNALSYM TTM_SETTOOLINFOW}
  TTM_SETTOOLINFOW         = WM_USER + 54;
  {$EXTERNALSYM TTM_HITTESTW}
  TTM_HITTESTW             = WM_USER + 55;
  {$EXTERNALSYM TTM_GETTEXTW}
  TTM_GETTEXTW             = WM_USER + 56;
  {$EXTERNALSYM TTM_UPDATETIPTEXTW}
  TTM_UPDATETIPTEXTW       = WM_USER + 57;
  {$EXTERNALSYM TTM_ENUMTOOLSW}
  TTM_ENUMTOOLSW           = WM_USER + 58;
  {$EXTERNALSYM TTM_GETCURRENTTOOLW}
  TTM_GETCURRENTTOOLW      = WM_USER + 59;
  {$EXTERNALSYM TTM_WINDOWFROMPOINT}
  TTM_WINDOWFROMPOINT      = WM_USER + 16;
  {$EXTERNALSYM TTM_TRACKACTIVATE}
  TTM_TRACKACTIVATE        = WM_USER + 17;  // wParam = TRUE/FALSE start end  lparam = LPTOOLINFO
  {$EXTERNALSYM TTM_TRACKPOSITION}
  TTM_TRACKPOSITION        = WM_USER + 18;  // lParam = dwPos
  {$EXTERNALSYM TTM_SETTIPBKCOLOR}
  TTM_SETTIPBKCOLOR        = WM_USER + 19;
  {$EXTERNALSYM TTM_SETTIPTEXTCOLOR}
  TTM_SETTIPTEXTCOLOR      = WM_USER + 20;
  {$EXTERNALSYM TTM_GETDELAYTIME}
  TTM_GETDELAYTIME         = WM_USER + 21;
  {$EXTERNALSYM TTM_GETTIPBKCOLOR}
  TTM_GETTIPBKCOLOR        = WM_USER + 22;
  {$EXTERNALSYM TTM_GETTIPTEXTCOLOR}
  TTM_GETTIPTEXTCOLOR      = WM_USER + 23;
  {$EXTERNALSYM TTM_SETMAXTIPWIDTH}
  TTM_SETMAXTIPWIDTH       = WM_USER + 24;
  {$EXTERNALSYM TTM_GETMAXTIPWIDTH}
  TTM_GETMAXTIPWIDTH       = WM_USER + 25;
  {$EXTERNALSYM TTM_SETMARGIN}
  TTM_SETMARGIN            = WM_USER + 26;  // lParam = lprc
  {$EXTERNALSYM TTM_GETMARGIN}
  TTM_GETMARGIN            = WM_USER + 27;  // lParam = lprc
  {$EXTERNALSYM TTM_POP}
  TTM_POP                  = WM_USER + 28;
  {$EXTERNALSYM TTM_UPDATE}
  TTM_UPDATE               = WM_USER + 29;

  { For IE >= 0X0500 }
  {$EXTERNALSYM TTM_GETBUBBLESIZE}
  TTM_GETBUBBLESIZE       = WM_USER + 30;
  {$EXTERNALSYM TTM_ADJUSTRECT}
  TTM_ADJUSTRECT          = WM_USER + 31;
  {$EXTERNALSYM TTM_SETTITLEA}
  TTM_SETTITLEA           = WM_USER + 32;   { wParam = TTI_*, lParam = char* szTitle }
  {$EXTERNALSYM TTM_SETTITLEW}
  TTM_SETTITLEW           = WM_USER + 33;   { wParam = TTI_*, lParam = wchar* szTitle }

  { For Windows >= XP }
  {$EXTERNALSYM TTM_POPUP}
  TTM_POPUP               = WM_USER + 34;
  {$EXTERNALSYM TTM_GETTITLE}
  TTM_GETTITLE            = WM_USER + 35;  { wParam = 0, lParam = TTGETTITLE* }

type
  { For Windows >= XP }
  { $EXTERNALSYM _TTGETTITLE}
  _TTGETTITLE = record
    dwSize: DWORD;
    uTitleBitmap: UINT;
    cch: UINT;
    pszTitle: PWCHAR;
  end;
  PTTGetTitle = ^TTTGetTitle;
  TTTGetTitle = _TTGETTITLE;

const  
{$IFDEF UNICODE}
  {$EXTERNALSYM TTM_ADDTOOL}
  TTM_ADDTOOL             = TTM_ADDTOOLW;
  {$EXTERNALSYM TTM_DELTOOL}
  TTM_DELTOOL             = TTM_DELTOOLW;
  {$EXTERNALSYM TTM_NEWTOOLRECT}
  TTM_NEWTOOLRECT         = TTM_NEWTOOLRECTW;
  {$EXTERNALSYM TTM_GETTOOLINFO}
  TTM_GETTOOLINFO         = TTM_GETTOOLINFOW;
  {$EXTERNALSYM TTM_SETTOOLINFO}
  TTM_SETTOOLINFO         = TTM_SETTOOLINFOW;
  {$EXTERNALSYM TTM_HITTEST}
  TTM_HITTEST             = TTM_HITTESTW;
  {$EXTERNALSYM TTM_GETTEXT}
  TTM_GETTEXT             = TTM_GETTEXTW;
  {$EXTERNALSYM TTM_UPDATETIPTEXT}
  TTM_UPDATETIPTEXT       = TTM_UPDATETIPTEXTW;
  {$EXTERNALSYM TTM_ENUMTOOLS}
  TTM_ENUMTOOLS           = TTM_ENUMTOOLSW;
  {$EXTERNALSYM TTM_GETCURRENTTOOL}
  TTM_GETCURRENTTOOL      = TTM_GETCURRENTTOOLW;
{$ELSE}
  {$EXTERNALSYM TTM_ADDTOOL}
  TTM_ADDTOOL             = TTM_ADDTOOLA;
  {$EXTERNALSYM TTM_DELTOOL}
  TTM_DELTOOL             = TTM_DELTOOLA;
  {$EXTERNALSYM TTM_NEWTOOLRECT}
  TTM_NEWTOOLRECT         = TTM_NEWTOOLRECTA;
  {$EXTERNALSYM TTM_GETTOOLINFO}
  TTM_GETTOOLINFO         = TTM_GETTOOLINFOA;
  {$EXTERNALSYM TTM_SETTOOLINFO}
  TTM_SETTOOLINFO         = TTM_SETTOOLINFOA;
  {$EXTERNALSYM TTM_HITTEST}
  TTM_HITTEST             = TTM_HITTESTA;
  {$EXTERNALSYM TTM_GETTEXT}
  TTM_GETTEXT             = TTM_GETTEXTA;
  {$EXTERNALSYM TTM_UPDATETIPTEXT}
  TTM_UPDATETIPTEXT       = TTM_UPDATETIPTEXTA;
  {$EXTERNALSYM TTM_ENUMTOOLS}
  TTM_ENUMTOOLS           = TTM_ENUMTOOLSA;
  {$EXTERNALSYM TTM_GETCURRENTTOOL}
  TTM_GETCURRENTTOOL      = TTM_GETCURRENTTOOLA;
{$ENDIF}

  { For IE >= 0X0500 }
  {$EXTERNALSYM TTM_SETTITLE}
  TTM_SETTITLE            = TTM_SETTITLEW;

  { For Windows >= XP }
  {$EXTERNALSYM TTM_SETWINDOWTHEME}
  TTM_SETWINDOWTHEME      = CCM_SETWINDOWTHEME;

  {$EXTERNALSYM TTM_RELAYEVENT}
  TTM_RELAYEVENT          = WM_USER + 7; // Win7: wParam = GetMessageExtraInfo() when relaying WM_MOUSEMOVE
  {$EXTERNALSYM TTM_GETTOOLCOUNT}
  TTM_GETTOOLCOUNT        = WM_USER +13;


type
  PTTHitTestInfoA = ^TTTHitTestInfoA;
  PTTHitTestInfoW = ^TTTHitTestInfoW;
  PTTHitTestInfo = PTTHitTestInfoW;
  {$EXTERNALSYM _TT_HITTESTINFOA}
  _TT_HITTESTINFOA = record
    hwnd: HWND;
    pt: TPoint;
    ti: TToolInfoA;
  end;
  {$EXTERNALSYM _TT_HITTESTINFOW}
  _TT_HITTESTINFOW = record
    hwnd: HWND;
    pt: TPoint;
    ti: TToolInfoW;
  end;
  {$EXTERNALSYM _TT_HITTESTINFO}
  _TT_HITTESTINFO = _TT_HITTESTINFOW;
  TTTHitTestInfoA = _TT_HITTESTINFOA;
  TTTHitTestInfoW = _TT_HITTESTINFOW;
  TTTHitTestInfo = TTTHitTestInfoW;
  {$EXTERNALSYM TTHITTESTINFOA}
  TTHITTESTINFOA = _TT_HITTESTINFOA;
  {$EXTERNALSYM TTHITTESTINFOW}
  TTHITTESTINFOW = _TT_HITTESTINFOW;
  {$EXTERNALSYM TTHITTESTINFO}
  TTHITTESTINFO = TTHITTESTINFOW;


const
  {$EXTERNALSYM TTN_GETDISPINFOA}
  TTN_GETDISPINFOA         = TTN_FIRST - 0;
  {$EXTERNALSYM TTN_NEEDTEXTA}
  TTN_NEEDTEXTA            = TTN_GETDISPINFOA;
  {$EXTERNALSYM TTN_GETDISPINFOW}
  TTN_GETDISPINFOW         = TTN_FIRST - 10;
  {$EXTERNALSYM TTN_NEEDTEXTW}
  TTN_NEEDTEXTW            = TTN_GETDISPINFOW;

{$IFDEF UNICODE}
  {$EXTERNALSYM TTN_GETDISPINFO}
  TTN_GETDISPINFO         = TTN_GETDISPINFOW;
  {$EXTERNALSYM TTN_NEEDTEXT}
  TTN_NEEDTEXT            = TTN_NEEDTEXTW;
{$ELSE}
  {$EXTERNALSYM TTN_GETDISPINFO}
  TTN_GETDISPINFO         = TTN_GETDISPINFOA;
  {$EXTERNALSYM TTN_NEEDTEXT}
  TTN_NEEDTEXT            = TTN_NEEDTEXTA;
{$ENDIF}

  {$EXTERNALSYM TTN_SHOW}
  TTN_SHOW                = TTN_FIRST - 1;
  {$EXTERNALSYM TTN_POP}
  TTN_POP                 = TTN_FIRST - 2;

type
  tagNMTTDISPINFOA = record
    hdr: TNMHdr;
    lpszText: LPSTR;
    szText: array[0..79] of AnsiChar;
    hinst: HINST;
    uFlags: UINT;
    lParam: LPARAM;
  end;
//  {$EXTERNALSYM tagNMTTDISPINFOA}
  tagNMTTDISPINFOW = record
    hdr: TNMHdr;
    lpszText: LPWSTR;
    szText: array[0..79] of WideChar;
    hinst: HINST;
    uFlags: UINT;
    lParam: LPARAM;
  end;
//  {$EXTERNALSYM tagNMTTDISPINFOW}
  tagNMTTDISPINFO = tagNMTTDISPINFOW;
  PNMTTDispInfoA = ^TNMTTDispInfoA;
  PNMTTDispInfoW = ^TNMTTDispInfoW;
  PNMTTDispInfo = PNMTTDispInfoW;
  TNMTTDispInfoA = tagNMTTDISPINFOA;
  TNMTTDispInfoW = tagNMTTDISPINFOW;
  TNMTTDispInfo = TNMTTDispInfoW;

  {$EXTERNALSYM tagTOOLTIPTEXTA}
  tagTOOLTIPTEXTA = tagNMTTDISPINFOA;
  {$EXTERNALSYM tagTOOLTIPTEXTW}
  tagTOOLTIPTEXTW = tagNMTTDISPINFOW;
  {$EXTERNALSYM tagTOOLTIPTEXT}
  tagTOOLTIPTEXT = tagTOOLTIPTEXTW;
  {$EXTERNALSYM TOOLTIPTEXTA}
  TOOLTIPTEXTA = tagNMTTDISPINFOA;
  {$EXTERNALSYM TOOLTIPTEXTW}
  TOOLTIPTEXTW = tagNMTTDISPINFOW;
  {$EXTERNALSYM TOOLTIPTEXT}
  TOOLTIPTEXT = TOOLTIPTEXTW;
  TToolTipTextA = tagNMTTDISPINFOA;
  TToolTipTextW = tagNMTTDISPINFOW;
  TToolTipText = TToolTipTextW;
  PToolTipTextA = ^TToolTipTextA;
  PToolTipTextW = ^TToolTipTextW;
  PToolTipText = PToolTipTextW;
{ ====== STATUS BAR CONTROL ================= }

const
  {$EXTERNALSYM SBARS_SIZEGRIP}
  SBARS_SIZEGRIP          = $0100;

{$EXTERNALSYM DrawStatusText}
procedure DrawStatusText(hDC: HDC; lprc: PRect; pzsText: LPCWSTR;
  uFlags: UINT); stdcall;
{$EXTERNALSYM DrawStatusTextA}
procedure DrawStatusTextA(hDC: HDC; lprc: PRect; pzsText: LPCSTR;
  uFlags: UINT); stdcall;
{$EXTERNALSYM DrawStatusTextW}
procedure DrawStatusTextW(hDC: HDC; lprc: PRect; pzsText: LPCWSTR;
  uFlags: UINT); stdcall;
{$EXTERNALSYM CreateStatusWindow}
function CreateStatusWindow(Style: Longint; lpszText: LPCWSTR;
  hwndParent: HWND; wID: UINT): HWND; stdcall;
{$EXTERNALSYM CreateStatusWindowA}
function CreateStatusWindowA(Style: Longint; lpszText: LPCSTR;
  hwndParent: HWND; wID: UINT): HWND; stdcall;
{$EXTERNALSYM CreateStatusWindowW}
function CreateStatusWindowW(Style: Longint; lpszText: LPCWSTR;
  hwndParent: HWND; wID: UINT): HWND; stdcall;

const
  {$EXTERNALSYM STATUSCLASSNAME}
  STATUSCLASSNAME = 'msctls_statusbar32';

const
  {$EXTERNALSYM SB_SETTEXTA}
  SB_SETTEXTA             = WM_USER+1;
  {$EXTERNALSYM SB_GETTEXTA}
  SB_GETTEXTA             = WM_USER+2;
  {$EXTERNALSYM SB_GETTEXTLENGTHA}
  SB_GETTEXTLENGTHA       = WM_USER+3;
  {$EXTERNALSYM SB_SETTIPTEXTA}
  SB_SETTIPTEXTA          = WM_USER+16;
  {$EXTERNALSYM SB_GETTIPTEXTA}
  SB_GETTIPTEXTA          = WM_USER+18;

  {$EXTERNALSYM SB_SETTEXTW}
  SB_SETTEXTW             = WM_USER+11;
  {$EXTERNALSYM SB_GETTEXTW}
  SB_GETTEXTW             = WM_USER+13;
  {$EXTERNALSYM SB_GETTEXTLENGTHW}
  SB_GETTEXTLENGTHW       = WM_USER+12;
  {$EXTERNALSYM SB_SETTIPTEXTW}
  SB_SETTIPTEXTW          = WM_USER+17;
  {$EXTERNALSYM SB_GETTIPTEXTW}
  SB_GETTIPTEXTW          = WM_USER+19;

{$IFDEF UNICODE}
  {$EXTERNALSYM SB_SETTEXT}
  SB_SETTEXT             = SB_SETTEXTW;
  {$EXTERNALSYM SB_GETTEXT}
  SB_GETTEXT             = SB_GETTEXTW;
  {$EXTERNALSYM SB_GETTEXTLENGTH}
  SB_GETTEXTLENGTH       = SB_GETTEXTLENGTHW;
  {$EXTERNALSYM SB_SETTIPTEXT}
  SB_SETTIPTEXT          = SB_SETTIPTEXTW;
  {$EXTERNALSYM SB_GETTIPTEXT}
  SB_GETTIPTEXT          = SB_GETTIPTEXTW;
{$ELSE}
  {$EXTERNALSYM SB_SETTEXT}
  SB_SETTEXT             = SB_SETTEXTA;
  {$EXTERNALSYM SB_GETTEXT}
  SB_GETTEXT             = SB_GETTEXTA;
  {$EXTERNALSYM SB_GETTEXTLENGTH}
  SB_GETTEXTLENGTH       = SB_GETTEXTLENGTHA;
  {$EXTERNALSYM SB_SETTIPTEXT}
  SB_SETTIPTEXT          = SB_SETTIPTEXTA;
  {$EXTERNALSYM SB_GETTIPTEXT}
  SB_GETTIPTEXT          = SB_GETTIPTEXTA;
{$ENDIF}

  {$EXTERNALSYM SB_SETPARTS}
  SB_SETPARTS             = WM_USER+4;
  {$EXTERNALSYM SB_GETPARTS}
  SB_GETPARTS             = WM_USER+6;
  {$EXTERNALSYM SB_GETBORDERS}
  SB_GETBORDERS           = WM_USER+7;
  {$EXTERNALSYM SB_SETMINHEIGHT}
  SB_SETMINHEIGHT         = WM_USER+8;
  {$EXTERNALSYM SB_SIMPLE}
  SB_SIMPLE               = WM_USER+9;
  {$EXTERNALSYM SB_GETRECT}
  SB_GETRECT              = WM_USER + 10;
  {$EXTERNALSYM SB_ISSIMPLE}
  SB_ISSIMPLE             = WM_USER+14;
  {$EXTERNALSYM SB_SETICON}
  SB_SETICON              = WM_USER+15;
  {$EXTERNALSYM SB_GETICON}
  SB_GETICON              = WM_USER+20;
  {$EXTERNALSYM SB_SETUNICODEFORMAT}
  SB_SETUNICODEFORMAT     = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM SB_GETUNICODEFORMAT}
  SB_GETUNICODEFORMAT     = CCM_GETUNICODEFORMAT;

  {$EXTERNALSYM SBT_OWNERDRAW}
  SBT_OWNERDRAW            = $1000;
  {$EXTERNALSYM SBT_NOBORDERS}
  SBT_NOBORDERS            = $0100;
  {$EXTERNALSYM SBT_POPOUT}
  SBT_POPOUT               = $0200;
  {$EXTERNALSYM SBT_RTLREADING}
  SBT_RTLREADING           = $0400;
  {$EXTERNALSYM SBT_TOOLTIPS}
  SBT_TOOLTIPS             = $0800;

  {$EXTERNALSYM SB_SETBKCOLOR}
  SB_SETBKCOLOR            = CCM_SETBKCOLOR;      // lParam = bkColor

  // status bar notifications
  {$EXTERNALSYM SBN_SIMPLEMODECHANGE}
  SBN_SIMPLEMODECHANGE     = SBN_FIRST - 0;

{ ====== MENU HELP ========================== }

{$EXTERNALSYM MenuHelp}
procedure MenuHelp(Msg: UINT; wParam: WPARAM; lParam: LPARAM;
  hMainMenu: HMENU; hInst: THandle; hwndStatus: HWND; lpwIDs: PUINT); stdcall;
{$EXTERNALSYM ShowHideMenuCtl}
function ShowHideMenuCtl(hWnd: HWND; uFlags: UIntPtr; lpInfo: PINT): Bool; stdcall;
{$EXTERNALSYM GetEffectiveClientRect}
procedure GetEffectiveClientRect(hWnd: HWND; lprc: PRect; lpInfo: PINT); stdcall;

const
  {$EXTERNALSYM MINSYSCOMMAND}
  MINSYSCOMMAND   = SC_SIZE;


{ ====== TRACKBAR CONTROL =================== }

  {$EXTERNALSYM TRACKBAR_CLASS}
  TRACKBAR_CLASS = 'msctls_trackbar32';

const
  {$EXTERNALSYM TBS_AUTOTICKS}
  TBS_AUTOTICKS           = $0001;
  {$EXTERNALSYM TBS_VERT}
  TBS_VERT                = $0002;
  {$EXTERNALSYM TBS_HORZ}
  TBS_HORZ                = $0000;
  {$EXTERNALSYM TBS_TOP}
  TBS_TOP                 = $0004;
  {$EXTERNALSYM TBS_BOTTOM}
  TBS_BOTTOM              = $0000;
  {$EXTERNALSYM TBS_LEFT}
  TBS_LEFT                = $0004;
  {$EXTERNALSYM TBS_RIGHT}
  TBS_RIGHT               = $0000;
  {$EXTERNALSYM TBS_BOTH}
  TBS_BOTH                = $0008;
  {$EXTERNALSYM TBS_NOTICKS}
  TBS_NOTICKS             = $0010;
  {$EXTERNALSYM TBS_ENABLESELRANGE}
  TBS_ENABLESELRANGE      = $0020;
  {$EXTERNALSYM TBS_FIXEDLENGTH}
  TBS_FIXEDLENGTH         = $0040;
  {$EXTERNALSYM TBS_NOTHUMB}
  TBS_NOTHUMB             = $0080;
  {$EXTERNALSYM TBS_TOOLTIPS}
  TBS_TOOLTIPS            = $0100;

  { For IE >= 0x0500 }
  {$EXTERNALSYM TBS_REVERSED}
  TBS_REVERSED            = $0200;  { Accessibility hint: the smaller number (usually the min value) means "high" and the larger number (usually the max value) means "low" }

  { For IE >= 0x0501 }
  {$EXTERNALSYM TBS_DOWNISLEFT}
  TBS_DOWNISLEFT          = $0400;  { Down=Left and Up=Right (default is Down=Right and Up=Left) }

  { For IE >= 0x0600 }
  {$EXTERNALSYM TBS_NOTIFYBEFOREMOVE}
  TBS_NOTIFYBEFOREMOVE    = $0800;  { Trackbar should notify parent before repositioning the slider due to user action (enables snapping) }

  { For NTDDI_VERSION >= NTDDI_VISTA }
  {$EXTERNALSYM TBS_TRANSPARENTBKGND}
  TBS_TRANSPARENTBKGND    = $1000;  { Background is painted by the parent via WM_PRINTCLIENT }

  {$EXTERNALSYM TBM_GETPOS}
  TBM_GETPOS              = WM_USER;
  {$EXTERNALSYM TBM_GETRANGEMIN}
  TBM_GETRANGEMIN         = WM_USER+1;
  {$EXTERNALSYM TBM_GETRANGEMAX}
  TBM_GETRANGEMAX         = WM_USER+2;
  {$EXTERNALSYM TBM_GETTIC}
  TBM_GETTIC              = WM_USER+3;
  {$EXTERNALSYM TBM_SETTIC}
  TBM_SETTIC              = WM_USER+4;
  {$EXTERNALSYM TBM_SETPOS}
  TBM_SETPOS              = WM_USER+5;
  {$EXTERNALSYM TBM_SETRANGE}
  TBM_SETRANGE            = WM_USER+6;
  {$EXTERNALSYM TBM_SETRANGEMIN}
  TBM_SETRANGEMIN         = WM_USER+7;
  {$EXTERNALSYM TBM_SETRANGEMAX}
  TBM_SETRANGEMAX         = WM_USER+8;
  {$EXTERNALSYM TBM_CLEARTICS}
  TBM_CLEARTICS           = WM_USER+9;
  {$EXTERNALSYM TBM_SETSEL}
  TBM_SETSEL              = WM_USER+10;
  {$EXTERNALSYM TBM_SETSELSTART}
  TBM_SETSELSTART         = WM_USER+11;
  {$EXTERNALSYM TBM_SETSELEND}
  TBM_SETSELEND           = WM_USER+12;
  {$EXTERNALSYM TBM_GETPTICS}
  TBM_GETPTICS            = WM_USER+14;
  {$EXTERNALSYM TBM_GETTICPOS}
  TBM_GETTICPOS           = WM_USER+15;
  {$EXTERNALSYM TBM_GETNUMTICS}
  TBM_GETNUMTICS          = WM_USER+16;
  {$EXTERNALSYM TBM_GETSELSTART}
  TBM_GETSELSTART         = WM_USER+17;
  {$EXTERNALSYM TBM_GETSELEND}
  TBM_GETSELEND           = WM_USER+18;
  {$EXTERNALSYM TBM_CLEARSEL}
  TBM_CLEARSEL            = WM_USER+19;
  {$EXTERNALSYM TBM_SETTICFREQ}
  TBM_SETTICFREQ          = WM_USER+20;
  {$EXTERNALSYM TBM_SETPAGESIZE}
  TBM_SETPAGESIZE         = WM_USER+21;
  {$EXTERNALSYM TBM_GETPAGESIZE}
  TBM_GETPAGESIZE         = WM_USER+22;
  {$EXTERNALSYM TBM_SETLINESIZE}
  TBM_SETLINESIZE         = WM_USER+23;
  {$EXTERNALSYM TBM_GETLINESIZE}
  TBM_GETLINESIZE         = WM_USER+24;
  {$EXTERNALSYM TBM_GETTHUMBRECT}
  TBM_GETTHUMBRECT        = WM_USER+25;
  {$EXTERNALSYM TBM_GETCHANNELRECT}
  TBM_GETCHANNELRECT      = WM_USER+26;
  {$EXTERNALSYM TBM_SETTHUMBLENGTH}
  TBM_SETTHUMBLENGTH      = WM_USER+27;
  {$EXTERNALSYM TBM_GETTHUMBLENGTH}
  TBM_GETTHUMBLENGTH      = WM_USER+28;
  {$EXTERNALSYM TBM_SETTOOLTIPS}
  TBM_SETTOOLTIPS         = WM_USER+29;
  {$EXTERNALSYM TBM_GETTOOLTIPS}
  TBM_GETTOOLTIPS         = WM_USER+30;
  {$EXTERNALSYM TBM_SETTIPSIDE}
  TBM_SETTIPSIDE          = WM_USER+31;

  // TrackBar Tip Side flags
  {$EXTERNALSYM TBTS_TOP}
  TBTS_TOP                = 0;
  {$EXTERNALSYM TBTS_LEFT}
  TBTS_LEFT               = 1;
  {$EXTERNALSYM TBTS_BOTTOM}
  TBTS_BOTTOM             = 2;
  {$EXTERNALSYM TBTS_RIGHT}
  TBTS_RIGHT              = 3;

  {$EXTERNALSYM TBM_SETBUDDY}
  TBM_SETBUDDY            = WM_USER+32; // wparam = BOOL fLeft; (or right)
  {$EXTERNALSYM TBM_GETBUDDY}
  TBM_GETBUDDY            = WM_USER+33; // wparam = BOOL fLeft; (or right)
  {$EXTERNALSYM TBM_SETPOSNOTIFY}
  TBM_SETPOSNOTIFY        = WM_USER+34;
  {$EXTERNALSYM TBM_SETUNICODEFORMAT}
  TBM_SETUNICODEFORMAT    = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM TBM_GETUNICODEFORMAT}
  TBM_GETUNICODEFORMAT    = CCM_GETUNICODEFORMAT;

  {$EXTERNALSYM TB_LINEUP}
  TB_LINEUP               = 0;
  {$EXTERNALSYM TB_LINEDOWN}
  TB_LINEDOWN             = 1;
  {$EXTERNALSYM TB_PAGEUP}
  TB_PAGEUP               = 2;
  {$EXTERNALSYM TB_PAGEDOWN}
  TB_PAGEDOWN             = 3;
  {$EXTERNALSYM TB_THUMBPOSITION}
  TB_THUMBPOSITION        = 4;
  {$EXTERNALSYM TB_THUMBTRACK}
  TB_THUMBTRACK           = 5;
  {$EXTERNALSYM TB_TOP}
  TB_TOP                  = 6;
  {$EXTERNALSYM TB_BOTTOM}
  TB_BOTTOM               = 7;
  {$EXTERNALSYM TB_ENDTRACK}
  TB_ENDTRACK             = 8;

  // custom draw item specs
  {$EXTERNALSYM TBCD_TICS}
  TBCD_TICS    = $0001;
  {$EXTERNALSYM TBCD_THUMB}
  TBCD_THUMB   = $0002;
  {$EXTERNALSYM TBCD_CHANNEL}
  TBCD_CHANNEL = $0003;
  { For Windows >= Vista }
  {$EXTERNALSYM TRBN_THUMBPOSCHANGING}
  TRBN_THUMBPOSCHANGING       = TRBN_FIRST-1;

 type
  // Structure for Trackbar's TRBN_THUMBPOSCHANGING notification
  {$EXTERNALSYM tagTRBTHUMBPOSCHANGING}
  tagTRBTHUMBPOSCHANGING = record
    hdr: TNMHdr;
    dwPos: DWORD;
    nReason: Integer;
  end;
  TNMTRBThumbPosChanging = tagTRBTHUMBPOSCHANGING;

{ ====== DRAG LIST CONTROL ================== }

type
  PDragListInfo = ^TDragListInfo;
  {$EXTERNALSYM tagDRAGLISTINFO}
  tagDRAGLISTINFO = record
    uNotification: UINT;
    hWnd: HWND;
    ptCursor: TPoint;
  end;
  TDragListInfo = tagDRAGLISTINFO;
  {$EXTERNALSYM DRAGLISTINFO}
  DRAGLISTINFO = tagDRAGLISTINFO;

const
  {$EXTERNALSYM DL_BEGINDRAG}
  DL_BEGINDRAG            = WM_USER+133;
  {$EXTERNALSYM DL_DRAGGING}
  DL_DRAGGING             = WM_USER+134;
  {$EXTERNALSYM DL_DROPPED}
  DL_DROPPED              = WM_USER+135;
  {$EXTERNALSYM DL_CANCELDRAG}
  DL_CANCELDRAG           = WM_USER+136;

  {$EXTERNALSYM DL_CURSORSET}
  DL_CURSORSET            = 0;
  {$EXTERNALSYM DL_STOPCURSOR}
  DL_STOPCURSOR           = 1;
  {$EXTERNALSYM DL_COPYCURSOR}
  DL_COPYCURSOR           = 2;
  {$EXTERNALSYM DL_MOVECURSOR}
  DL_MOVECURSOR           = 3;

const
  {$EXTERNALSYM DRAGLISTMSGSTRING}
  DRAGLISTMSGSTRING = 'commctrl_DragListMsg';

{$EXTERNALSYM MakeDragList}
procedure MakeDragList(hLB: HWND); stdcall;
{$EXTERNALSYM DrawInsert}
procedure DrawInsert(hwndParent: HWND; hLB: HWND; nItem: Integer); stdcall;
{$EXTERNALSYM LBItemFromPt}
function LBItemFromPt(hLB: HWND; pt: TPoint; bAutoScroll: Bool): Integer; stdcall;


{ ====== UPDOWN CONTROL ========================== }

const
  {$EXTERNALSYM UPDOWN_CLASS}
  UPDOWN_CLASS = 'msctls_updown32';

type
  PUDAccel = ^TUDAccel;
  {$EXTERNALSYM _UDACCEL}
  _UDACCEL = record
    nSec: UINT;
    nInc: UINT;
  end;
  TUDAccel = _UDACCEL;
  {$EXTERNALSYM UDACCEL}
  UDACCEL = _UDACCEL;

const
  {$EXTERNALSYM UD_MAXVAL}
  UD_MAXVAL               = $7fff;
  {$EXTERNALSYM UD_MINVAL}
  UD_MINVAL               = -UD_MAXVAL;

  {$EXTERNALSYM UDS_WRAP}
  UDS_WRAP                = $0001;
  {$EXTERNALSYM UDS_SETBUDDYINT}
  UDS_SETBUDDYINT         = $0002;
  {$EXTERNALSYM UDS_ALIGNRIGHT}
  UDS_ALIGNRIGHT          = $0004;
  {$EXTERNALSYM UDS_ALIGNLEFT}
  UDS_ALIGNLEFT           = $0008;
  {$EXTERNALSYM UDS_AUTOBUDDY}
  UDS_AUTOBUDDY           = $0010;
  {$EXTERNALSYM UDS_ARROWKEYS}
  UDS_ARROWKEYS           = $0020;
  {$EXTERNALSYM UDS_HORZ}
  UDS_HORZ                = $0040;
  {$EXTERNALSYM UDS_NOTHOUSANDS}
  UDS_NOTHOUSANDS         = $0080;
  {$EXTERNALSYM UDS_HOTTRACK}
  UDS_HOTTRACK            = $0100;


  {$EXTERNALSYM UDM_SETRANGE}
  UDM_SETRANGE            = WM_USER+101;
  {$EXTERNALSYM UDM_GETRANGE}
  UDM_GETRANGE            = WM_USER+102;
  {$EXTERNALSYM UDM_SETPOS}
  UDM_SETPOS              = WM_USER+103;
  {$EXTERNALSYM UDM_GETPOS}
  UDM_GETPOS              = WM_USER+104;
  {$EXTERNALSYM UDM_SETBUDDY}
  UDM_SETBUDDY            = WM_USER+105;
  {$EXTERNALSYM UDM_GETBUDDY}
  UDM_GETBUDDY            = WM_USER+106;
  {$EXTERNALSYM UDM_SETACCEL}
  UDM_SETACCEL            = WM_USER+107;
  {$EXTERNALSYM UDM_GETACCEL}
  UDM_GETACCEL            = WM_USER+108;
  {$EXTERNALSYM UDM_SETBASE}
  UDM_SETBASE             = WM_USER+109;
  {$EXTERNALSYM UDM_GETBASE}
  UDM_GETBASE             = WM_USER+110;
  {$EXTERNALSYM UDM_SETRANGE32}
  UDM_SETRANGE32          = WM_USER+111;
  {$EXTERNALSYM UDM_GETRANGE32}
  UDM_GETRANGE32          = WM_USER+112; // wParam & lParam are LPINT
  {$EXTERNALSYM UDM_SETUNICODEFORMAT}
  UDM_SETUNICODEFORMAT    = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM UDM_GETUNICODEFORMAT}
  UDM_GETUNICODEFORMAT    = CCM_GETUNICODEFORMAT;
  {$EXTERNALSYM UDM_SETPOS32}
  UDM_SETPOS32            = WM_USER+113;
  {$EXTERNALSYM UDM_GETPOS32}
  UDM_GETPOS32            = WM_USER+114;

{$EXTERNALSYM CreateUpDownControl}
function CreateUpDownControl(dwStyle: DWORD; X, Y, CX, CY: Integer;
  hParent: HWND; nID: Integer; hInst: HINST; hBuddy: HWND;
  nUpper, nLower, nPos: Integer): HWND; stdcall;

type
  PNMUpDown = ^TNMUpDown;
  {$EXTERNALSYM _NM_UPDOWN}
  _NM_UPDOWN = record
    hdr: TNMHDR;
    iPos: Integer;
    iDelta: Integer;
  end;
  TNMUpDown = _NM_UPDOWN;
  {$EXTERNALSYM NM_UPDOWN}
  NM_UPDOWN = _NM_UPDOWN;

const
  {$EXTERNALSYM UDN_DELTAPOS}
  UDN_DELTAPOS = UDN_FIRST - 1;


{ ====== PROGRESS CONTROL ========================= }

const
  {$EXTERNALSYM PROGRESS_CLASS}
  PROGRESS_CLASS = 'msctls_progress32';

type
  {$EXTERNALSYM PBRANGE}
  PBRANGE = record
    iLow: Integer;
    iHigh: Integer;
  end;
  PPBRange = ^TPBRange;
  TPBRange = PBRANGE;

const
  {$EXTERNALSYM PBS_SMOOTH}
  PBS_SMOOTH              = 01;
  {$EXTERNALSYM PBS_VERTICAL}
  PBS_VERTICAL            = 04;
  
  {$EXTERNALSYM PBM_SETRANGE}
  PBM_SETRANGE            = WM_USER+1;
  {$EXTERNALSYM PBM_SETPOS}
  PBM_SETPOS              = WM_USER+2;
  {$EXTERNALSYM PBM_DELTAPOS}
  PBM_DELTAPOS            = WM_USER+3;
  {$EXTERNALSYM PBM_SETSTEP}
  PBM_SETSTEP             = WM_USER+4;
  {$EXTERNALSYM PBM_STEPIT}
  PBM_STEPIT              = WM_USER+5;
  {$EXTERNALSYM PBM_SETRANGE32}
  PBM_SETRANGE32          = WM_USER+6;   // lParam = high, wParam = low
  {$EXTERNALSYM PBM_GETRANGE}
  PBM_GETRANGE            = WM_USER+7;   // lParam = PPBRange or Nil
					 // wParam = False: Result = high
					 // wParam = True: Result = low
  {$EXTERNALSYM PBM_GETPOS}
  PBM_GETPOS              = WM_USER+8;
  {$EXTERNALSYM PBM_SETBARCOLOR}
  PBM_SETBARCOLOR         = WM_USER+9;		// lParam = bar color
  {$EXTERNALSYM PBM_SETBKCOLOR}
  PBM_SETBKCOLOR          = CCM_SETBKCOLOR;  // lParam = bkColor

  { For Windows >= XP }
  {$EXTERNALSYM PBS_MARQUEE}
  PBS_MARQUEE             = $08;
  {$EXTERNALSYM PBM_SETMARQUEE}
  PBM_SETMARQUEE          = WM_USER+10;

  { For Windows >= Vista }
  {$EXTERNALSYM PBS_SMOOTHREVERSE}
  PBS_SMOOTHREVERSE       = $10;

  { For Windows >= Vista }
  {$EXTERNALSYM PBM_GETSTEP}
  PBM_GETSTEP             = WM_USER+13;
  {$EXTERNALSYM PBM_GETBKCOLOR}
  PBM_GETBKCOLOR          = WM_USER+14;
  {$EXTERNALSYM PBM_GETBARCOLOR}
  PBM_GETBARCOLOR         = WM_USER+15;
  {$EXTERNALSYM PBM_SETSTATE}
  PBM_SETSTATE            = WM_USER+16;  { wParam = PBST_[State] (NORMAL, ERROR, PAUSED) }
  {$EXTERNALSYM PBM_GETSTATE}
  PBM_GETSTATE            = WM_USER+17;

  { For Windows >= Vista }
  {$EXTERNALSYM PBST_NORMAL}
  PBST_NORMAL             = $0001;
  {$EXTERNALSYM PBST_ERROR}
  PBST_ERROR              = $0002;
  {$EXTERNALSYM PBST_PAUSED}
  PBST_PAUSED             = $0003;


{  ====== HOTKEY CONTROL ========================== }

const
  {$EXTERNALSYM HOTKEYF_SHIFT}
  HOTKEYF_SHIFT           = $01;
  {$EXTERNALSYM HOTKEYF_CONTROL}
  HOTKEYF_CONTROL         = $02;
  {$EXTERNALSYM HOTKEYF_ALT}
  HOTKEYF_ALT             = $04;
  {$EXTERNALSYM HOTKEYF_EXT}
  HOTKEYF_EXT             = $08;

  {$EXTERNALSYM HKCOMB_NONE}
  HKCOMB_NONE             = $0001;
  {$EXTERNALSYM HKCOMB_S}
  HKCOMB_S                = $0002;
  {$EXTERNALSYM HKCOMB_C}
  HKCOMB_C                = $0004;
  {$EXTERNALSYM HKCOMB_A}
  HKCOMB_A                = $0008;
  {$EXTERNALSYM HKCOMB_SC}
  HKCOMB_SC               = $0010;
  {$EXTERNALSYM HKCOMB_SA}
  HKCOMB_SA               = $0020;
  {$EXTERNALSYM HKCOMB_CA}
  HKCOMB_CA               = $0040;
  {$EXTERNALSYM HKCOMB_SCA}
  HKCOMB_SCA              = $0080;


  {$EXTERNALSYM HKM_SETHOTKEY}
  HKM_SETHOTKEY           = WM_USER+1;
  {$EXTERNALSYM HKM_GETHOTKEY}
  HKM_GETHOTKEY           = WM_USER+2;
  {$EXTERNALSYM HKM_SETRULES}
  HKM_SETRULES            = WM_USER+3;

const
  HOTKEYCLASS = 'msctls_hotkey32';


{ ====== COMMON CONTROL STYLES ================ }

const
  {$EXTERNALSYM CCS_TOP}
  CCS_TOP                 = $00000001;
  {$EXTERNALSYM CCS_NOMOVEY}
  CCS_NOMOVEY             = $00000002;
  {$EXTERNALSYM CCS_BOTTOM}
  CCS_BOTTOM              = $00000003;
  {$EXTERNALSYM CCS_NORESIZE}
  CCS_NORESIZE            = $00000004;
  {$EXTERNALSYM CCS_NOPARENTALIGN}
  CCS_NOPARENTALIGN       = $00000008;
  {$EXTERNALSYM CCS_ADJUSTABLE}
  CCS_ADJUSTABLE          = $00000020;
  {$EXTERNALSYM CCS_NODIVIDER}
  CCS_NODIVIDER           = $00000040;
  {$EXTERNALSYM CCS_VERT}
  CCS_VERT                = $00000080;
  {$EXTERNALSYM CCS_LEFT}
  CCS_LEFT                = (CCS_VERT or CCS_TOP);
  {$EXTERNALSYM CCS_RIGHT}
  CCS_RIGHT               = (CCS_VERT or CCS_BOTTOM);
  {$EXTERNALSYM CCS_NOMOVEX}
  CCS_NOMOVEX             = (CCS_VERT or CCS_NOMOVEY);


// ====== SysLink control =========================================


const
  { For Windows >= XP }
  {$EXTERNALSYM INVALID_LINK_INDEX}
  INVALID_LINK_INDEX  = -1;
  {$EXTERNALSYM MAX_LINKID_TEXT}
  MAX_LINKID_TEXT     = 48;
  {$EXTERNALSYM L_MAX_URL_LENGTH}
  L_MAX_URL_LENGTH    = 2048 + 32 + length('://') + 1;

  { For Windows >= XP }
  {$EXTERNALSYM WC_LINK}
  WC_LINK         = 'SysLink';

  { For Windows >= XP }
  {$EXTERNALSYM LWS_TRANSPARENT}
  LWS_TRANSPARENT     = $0001;
  {$EXTERNALSYM LWS_IGNORERETURN}
  LWS_IGNORERETURN    = $0002;
  { For Windows >= Vista }
  {$EXTERNALSYM LWS_NOPREFIX}
  LWS_NOPREFIX        = $0004;
  {$EXTERNALSYM LWS_USEVISUALSTYLE}
  LWS_USEVISUALSTYLE  = $0008;
  {$EXTERNALSYM LWS_USECUSTOMTEXT}
  LWS_USECUSTOMTEXT   = $0010;
  {$EXTERNALSYM LWS_RIGHT}
  LWS_RIGHT           = $0020;

  { For Windows >= XP }
  {$EXTERNALSYM LIF_ITEMINDEX}
  LIF_ITEMINDEX    = $00000001;
  {$EXTERNALSYM LIF_STATE}
  LIF_STATE        = $00000002;
  {$EXTERNALSYM LIF_ITEMID}
  LIF_ITEMID       = $00000004;
  {$EXTERNALSYM LIF_URL}
  LIF_URL          = $00000008;

  { For Windows >= XP }
  {$EXTERNALSYM LIS_FOCUSED}
  LIS_FOCUSED         = $00000001;
  {$EXTERNALSYM LIS_ENABLED}
  LIS_ENABLED         = $00000002;
  {$EXTERNALSYM LIS_VISITED}
  LIS_VISITED         = $00000004;
  { For Windows >= Vista }
  {$EXTERNALSYM LIS_HOTTRACK}
  LIS_HOTTRACK        = $00000008;
  {$EXTERNALSYM LIS_DEFAULTCOLORS}
  LIS_DEFAULTCOLORS   = $00000010; // Don't use any custom text colors

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLITEM}
  tagLITEM = record
    mask: UINT;
    iLink: Integer;
    state: UINT;
    stateMask: UINT;
    szID: packed array[0..MAX_LINKID_TEXT-1] of WCHAR;
    szUrl: packed array[0..L_MAX_URL_LENGTH-1] of WCHAR;
  end;
  PLItem = ^TLItem;
  TLItem = tagLITEM;

  { For Windows >= XP }
  { $EXTERNALSYM tagLHITTESTINFO}
  tagLHITTESTINFO = record
    pt: TPoint;
    item: TLItem;
  end;
  PLHitTestInfo = ^TLHitTestInfo;
  TLHitTestInfo = tagLHITTESTINFO;

  { For Windows >= XP }
  { $EXTERNALSYM tagNMLINK}
  tagNMLINK = record
    hdr: NMHDR;
    item: TLItem;
  end;
  PNMLink = ^TNMLink;
  TNMLink = tagNMLINK;

//  SysLink notifications
//  NM_CLICK   // wParam: control ID, lParam: PNMLINK, ret: ignored.

//  LinkWindow messages
const
  { For Windows >= XP }
  {$EXTERNALSYM LM_HITTEST}
  LM_HITTEST         = WM_USER+$300;    // wParam: n/a, lparam: PLHITTESTINFO, ret: BOOL
  {$EXTERNALSYM LM_GETIDEALHEIGHT}
  LM_GETIDEALHEIGHT  = WM_USER+$301;    // wParam: cxMaxWidth, lparam: n/a, ret: cy
  {$EXTERNALSYM LM_SETITEM}
  LM_SETITEM         = WM_USER+$302;    // wParam: n/a, lparam: LITEM*, ret: BOOL
  {$EXTERNALSYM LM_GETITEM}
  LM_GETITEM         = WM_USER+$303;    // wParam: n/a, lparam: LITEM*, ret: BOOL
  {$EXTERNALSYM LM_GETIDEALSIZE}
  LM_GETIDEALSIZE    = LM_GETIDEALHEIGHT;   // wParam: cxMaxWidth, lparam: SIZE*, ret: cy

  
{ ====== LISTVIEW CONTROL ====================== }


const
  {$EXTERNALSYM WC_LISTVIEW}
  WC_LISTVIEW = 'SysListView32';

const

  { List View Styles }
  {$EXTERNALSYM LVS_ICON}
  LVS_ICON                = $0000;
  {$EXTERNALSYM LVS_REPORT}
  LVS_REPORT              = $0001;
  {$EXTERNALSYM LVS_SMALLICON}
  LVS_SMALLICON           = $0002;
  {$EXTERNALSYM LVS_LIST}
  LVS_LIST                = $0003;
  {$EXTERNALSYM LVS_TYPEMASK}
  LVS_TYPEMASK            = $0003;
  {$EXTERNALSYM LVS_SINGLESEL}
  LVS_SINGLESEL           = $0004;
  {$EXTERNALSYM LVS_SHOWSELALWAYS}
  LVS_SHOWSELALWAYS       = $0008;
  {$EXTERNALSYM LVS_SORTASCENDING}
  LVS_SORTASCENDING       = $0010;
  {$EXTERNALSYM LVS_SORTDESCENDING}
  LVS_SORTDESCENDING      = $0020;
  {$EXTERNALSYM LVS_SHAREIMAGELISTS}
  LVS_SHAREIMAGELISTS     = $0040;
  {$EXTERNALSYM LVS_NOLABELWRAP}
  LVS_NOLABELWRAP         = $0080;
  {$EXTERNALSYM LVS_AUTOARRANGE}
  LVS_AUTOARRANGE         = $0100;
  {$EXTERNALSYM LVS_EDITLABELS}
  LVS_EDITLABELS          = $0200;
  {$EXTERNALSYM LVS_OWNERDATA}
  LVS_OWNERDATA           = $1000; 
  {$EXTERNALSYM LVS_NOSCROLL}
  LVS_NOSCROLL            = $2000;

  {$EXTERNALSYM LVS_TYPESTYLEMASK}
  LVS_TYPESTYLEMASK       = $FC00;

  {$EXTERNALSYM LVS_ALIGNTOP}
  LVS_ALIGNTOP            = $0000;
  {$EXTERNALSYM LVS_ALIGNLEFT}
  LVS_ALIGNLEFT           = $0800;
  {$EXTERNALSYM LVS_ALIGNMASK}
  LVS_ALIGNMASK           = $0c00;

  {$EXTERNALSYM LVS_OWNERDRAWFIXED}
  LVS_OWNERDRAWFIXED      = $0400;
  {$EXTERNALSYM LVS_NOCOLUMNHEADER}
  LVS_NOCOLUMNHEADER      = $4000;
  {$EXTERNALSYM LVS_NOSORTHEADER}
  LVS_NOSORTHEADER        = $8000;

  { List View Extended Styles }
  {$EXTERNALSYM LVS_EX_GRIDLINES}
  LVS_EX_GRIDLINES        = $00000001;
  {$EXTERNALSYM LVS_EX_SUBITEMIMAGES}
  LVS_EX_SUBITEMIMAGES    = $00000002;
  {$EXTERNALSYM LVS_EX_CHECKBOXES}
  LVS_EX_CHECKBOXES       = $00000004;
  {$EXTERNALSYM LVS_EX_TRACKSELECT}
  LVS_EX_TRACKSELECT      = $00000008;
  {$EXTERNALSYM LVS_EX_HEADERDRAGDROP}
  LVS_EX_HEADERDRAGDROP   = $00000010;
  {$EXTERNALSYM LVS_EX_FULLROWSELECT}
  LVS_EX_FULLROWSELECT    = $00000020; // applies to report mode only
  {$EXTERNALSYM LVS_EX_ONECLICKACTIVATE}
  LVS_EX_ONECLICKACTIVATE = $00000040;
  {$EXTERNALSYM LVS_EX_TWOCLICKACTIVATE}
  LVS_EX_TWOCLICKACTIVATE = $00000080;
  {$EXTERNALSYM LVS_EX_FLATSB}
  LVS_EX_FLATSB           = $00000100;
  {$EXTERNALSYM LVS_EX_REGIONAL}
  LVS_EX_REGIONAL         = $00000200;
  {$EXTERNALSYM LVS_EX_INFOTIP}
  LVS_EX_INFOTIP          = $00000400; // listview does InfoTips for you
  {$EXTERNALSYM LVS_EX_UNDERLINEHOT}
  LVS_EX_UNDERLINEHOT     = $00000800;
  {$EXTERNALSYM LVS_EX_UNDERLINECOLD}
  LVS_EX_UNDERLINECOLD    = $00001000;
  {$EXTERNALSYM LVS_EX_MULTIWORKAREAS}
  LVS_EX_MULTIWORKAREAS   = $00002000;

  { For IE >= 0x0500 }
  {$EXTERNALSYM LVS_EX_LABELTIP}
  LVS_EX_LABELTIP         = $00004000; { listview unfolds partly hidden labels if it does not have infotip text }
  {$EXTERNALSYM LVS_EX_BORDERSELECT}
  LVS_EX_BORDERSELECT     = $00008000; { border selection style instead of highlight }

  { For Windows >= XP }
  {$EXTERNALSYM LVS_EX_DOUBLEBUFFER}
  LVS_EX_DOUBLEBUFFER     = $00010000;
  {$EXTERNALSYM LVS_EX_HIDELABELS}
  LVS_EX_HIDELABELS       = $00020000;
  {$EXTERNALSYM LVS_EX_SINGLEROW}
  LVS_EX_SINGLEROW        = $00040000;
  {$EXTERNALSYM LVS_EX_SNAPTOGRID}
  LVS_EX_SNAPTOGRID       = $00080000;  { Icons automatically snap to grid. }
  {$EXTERNALSYM LVS_EX_SIMPLESELECT}
  LVS_EX_SIMPLESELECT     = $00100000;  { Also changes overlay rendering to top right for icon mode. }

  { For Windows >= Vista }
  {$EXTERNALSYM LVS_EX_JUSTIFYCOLUMNS}
  LVS_EX_JUSTIFYCOLUMNS   = $00200000;  { Icons are lined up in columns that use up the whole view area. }
  {$EXTERNALSYM LVS_EX_TRANSPARENTBKGND}
  LVS_EX_TRANSPARENTBKGND = $00400000;  { Background is painted by the parent via WM_PRINTCLIENT }
  {$EXTERNALSYM LVS_EX_TRANSPARENTSHADOWTEXT}
  LVS_EX_TRANSPARENTSHADOWTEXT = $00800000;  { Enable shadow text on transparent backgrounds only (useful with bitmaps) }
  {$EXTERNALSYM LVS_EX_AUTOAUTOARRANGE}
  LVS_EX_AUTOAUTOARRANGE  = $01000000;  { Icons automatically arrange if no icon positions have been set }
  {$EXTERNALSYM LVS_EX_HEADERINALLVIEWS}
  LVS_EX_HEADERINALLVIEWS = $02000000;  { Display column header in all view modes }
  {$EXTERNALSYM LVS_EX_AUTOCHECKSELECT}
  LVS_EX_AUTOCHECKSELECT  = $08000000;
  {$EXTERNALSYM LVS_EX_AUTOSIZECOLUMNS}
  LVS_EX_AUTOSIZECOLUMNS  = $10000000;
  {$EXTERNALSYM LVS_EX_COLUMNSNAPPOINTS}
  LVS_EX_COLUMNSNAPPOINTS = $40000000;
  {$EXTERNALSYM LVS_EX_COLUMNOVERFLOW}
  LVS_EX_COLUMNOVERFLOW   = $80000000; 

const
  {$EXTERNALSYM LVM_SETUNICODEFORMAT}
  LVM_SETUNICODEFORMAT     = CCM_SETUNICODEFORMAT;

{$EXTERNALSYM ListView_SetUnicodeFormat}
function ListView_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL; inline;

const
  {$EXTERNALSYM LVM_GETUNICODEFORMAT}
  LVM_GETUNICODEFORMAT     = CCM_GETUNICODEFORMAT;

{$EXTERNALSYM ListView_GetUnicodeFormat}
function ListView_GetUnicodeFormat(hwnd: HWND): BOOL; inline;

const
  {$EXTERNALSYM LVM_GETBKCOLOR}
  LVM_GETBKCOLOR          = LVM_FIRST + 0;

{$EXTERNALSYM ListView_GetBkColor}
function ListView_GetBkColor(hWnd: HWND): TColorRef; inline;

const
  {$EXTERNALSYM LVM_SETBKCOLOR}
  LVM_SETBKCOLOR          = LVM_FIRST + 1;

{$EXTERNALSYM ListView_SetBkColor}
function ListView_SetBkColor(hWnd: HWND; clrBk: TColorRef): Bool; inline;

const
  {$EXTERNALSYM LVM_GETIMAGELIST}
  LVM_GETIMAGELIST        = LVM_FIRST + 2;

{$EXTERNALSYM ListView_GetImageList}
function ListView_GetImageList(hWnd: HWND; iImageList: Integer): HIMAGELIST; inline;

const
  {$EXTERNALSYM LVSIL_NORMAL}
  LVSIL_NORMAL            = 0;
  {$EXTERNALSYM LVSIL_SMALL}
  LVSIL_SMALL             = 1;
  {$EXTERNALSYM LVSIL_STATE}
  LVSIL_STATE             = 2;
  {$EXTERNALSYM LVSIL_GROUPHEADER}
  LVSIL_GROUPHEADER       = 3; 

const
  {$EXTERNALSYM LVM_SETIMAGELIST}
  LVM_SETIMAGELIST        = LVM_FIRST + 3;

{$EXTERNALSYM ListView_SetImageList}
function ListView_SetImageList(hWnd: HWND; himl: HIMAGELIST;
  iImageList: Integer): HIMAGELIST; inline;

const
  {$EXTERNALSYM LVM_GETITEMCOUNT}
  LVM_GETITEMCOUNT        = LVM_FIRST + 4;

{$EXTERNALSYM ListView_GetItemCount}
function ListView_GetItemCount(hWnd: HWND): Integer; inline;

const
  {$EXTERNALSYM LVIF_TEXT}
  LVIF_TEXT               = $0001;
  {$EXTERNALSYM LVIF_IMAGE}
  LVIF_IMAGE              = $0002;
  {$EXTERNALSYM LVIF_PARAM}
  LVIF_PARAM              = $0004;
  {$EXTERNALSYM LVIF_STATE}
  LVIF_STATE              = $0008;
  {$EXTERNALSYM LVIF_INDENT}
  LVIF_INDENT             = $0010;
  {$EXTERNALSYM LVIF_NORECOMPUTE}
  LVIF_NORECOMPUTE        = $0800;
  { For Windows >= XP }
  {$EXTERNALSYM LVIF_GROUPID}
  LVIF_GROUPID            = $00000100;
  {$EXTERNALSYM LVIF_COLUMNS}
  LVIF_COLUMNS            = $00000200;

  { For Windows >= Vista }
  {$EXTERNALSYM LVIF_COLFMT}
  LVIF_COLFMT             = $00010000; { The piColFmt member is valid in addition to puColumns }

  {$EXTERNALSYM LVIS_FOCUSED}
  LVIS_FOCUSED            = $0001;
  {$EXTERNALSYM LVIS_SELECTED}
  LVIS_SELECTED           = $0002;
  {$EXTERNALSYM LVIS_CUT}
  LVIS_CUT                = $0004;
  {$EXTERNALSYM LVIS_DROPHILITED}
  LVIS_DROPHILITED        = $0008;
  {$EXTERNALSYM LVIS_ACTIVATING}
  LVIS_ACTIVATING         = $0020;

  {$EXTERNALSYM LVIS_OVERLAYMASK}
  LVIS_OVERLAYMASK        = $0F00;
  {$EXTERNALSYM LVIS_STATEIMAGEMASK}
  LVIS_STATEIMAGEMASK     = $F000;

{$EXTERNALSYM IndexToStateImageMask}
function IndexToStateImageMask(I: Longint): Longint; inline;

const
  {$EXTERNALSYM I_INDENTCALLBACK}
  I_INDENTCALLBACK        = -1;
  {$EXTERNALSYM I_IMAGENONE}
  I_IMAGENONE             = -2;
  { For Windows >= XP }
  {$EXTERNALSYM I_COLUMNSCALLBACK}
  I_COLUMNSCALLBACK       = -1;
  {$EXTERNALSYM I_GROUPIDCALLBACK}
  I_GROUPIDCALLBACK   = -1;
  {$EXTERNALSYM I_GROUPIDNONE}
  I_GROUPIDNONE       = -2;

type
  PLVItemA = ^TLVItemA;
  PLVItemW = ^TLVItemW;
  PLVItem = PLVItemW;
  {$EXTERNALSYM tagLVITEMA}
  tagLVITEMA = record
    mask: UINT;
    iItem: Integer;
    iSubItem: Integer;
    state: UINT;
    stateMask: UINT;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
    
    iIndent: Integer;
    
                                      
    iGroupId: Integer;
    cColumns: UINT;  { tile view columns }
    puColumns: PUINT;
    
                                           
    // WILL BE UNUSED DOWNLEVEL, BUT SIZEOF(LVITEMA) MUST BE EQUAL TO SIZEOF(LVITEMW)
    piColFmt: PInteger;
    iGroup: Integer;{ readonly. only valid for owner data. }
    
  end;
  {$EXTERNALSYM tagLVITEMW}
  tagLVITEMW = record
    mask: UINT;
    iItem: Integer;
    iSubItem: Integer;
    state: UINT;
    stateMask: UINT;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
    
    iIndent: Integer;
    
                                      
    iGroupId: Integer;
    cColumns: UINT;  { tile view columns }
    puColumns: PUINT;
    
                                           
    // WILL BE UNUSED DOWNLEVEL, BUT SIZEOF(LVITEMA) MUST BE EQUAL TO SIZEOF(LVITEMW)
    piColFmt: PInteger;
    iGroup: Integer;{ readonly. only valid for owner data. }
    
  end;
  {$EXTERNALSYM tagLVITEM}
  tagLVITEM = tagLVITEMW;
  {$EXTERNALSYM _LV_ITEMA}
  _LV_ITEMA = tagLVITEMA;
  {$EXTERNALSYM _LV_ITEMW}
  _LV_ITEMW = tagLVITEMW;
  {$EXTERNALSYM _LV_ITEM}
  _LV_ITEM = _LV_ITEMW;
  TLVItemA = tagLVITEMA;
  TLVItemW = tagLVITEMW;
  TLVItem = TLVItemW;
  {$EXTERNALSYM LV_ITEMA}
  LV_ITEMA = tagLVITEMA;
  {$EXTERNALSYM LV_ITEMW}
  LV_ITEMW = tagLVITEMW;
  {$EXTERNALSYM LV_ITEM}
  LV_ITEM = LV_ITEMW;

const
  {$EXTERNALSYM LPSTR_TEXTCALLBACKA}
  LPSTR_TEXTCALLBACKA = LPSTR(NativeInt(-1));
  {$EXTERNALSYM LPSTR_TEXTCALLBACKW}
  LPSTR_TEXTCALLBACKW = LPWSTR(NativeInt(-1));

{$IFDEF UNICODE}
  {$EXTERNALSYM LPSTR_TEXTCALLBACK}
  LPSTR_TEXTCALLBACK = LPSTR_TEXTCALLBACKW;
{$ELSE}
  {$EXTERNALSYM LPSTR_TEXTCALLBACK}
  LPSTR_TEXTCALLBACK = LPSTR_TEXTCALLBACKA;
{$ENDIF}

  {$EXTERNALSYM I_IMAGECALLBACK}
  I_IMAGECALLBACK         = -1;

const
  {$EXTERNALSYM LVM_GETITEMA}
  LVM_GETITEMA            = LVM_FIRST + 5;
  {$EXTERNALSYM LVM_SETITEMA}
  LVM_SETITEMA            = LVM_FIRST + 6;
  {$EXTERNALSYM LVM_INSERTITEMA}
  LVM_INSERTITEMA         = LVM_FIRST + 7;

  {$EXTERNALSYM LVM_GETITEMW}
  LVM_GETITEMW            = LVM_FIRST + 75;
  {$EXTERNALSYM LVM_SETITEMW}
  LVM_SETITEMW            = LVM_FIRST + 76;
  {$EXTERNALSYM LVM_INSERTITEMW}
  LVM_INSERTITEMW         = LVM_FIRST + 77;

{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_GETITEM}
  LVM_GETITEM            = LVM_GETITEMW;
  {$EXTERNALSYM LVM_SETITEM}
  LVM_SETITEM            = LVM_SETITEMW;
  {$EXTERNALSYM LVM_INSERTITEM}
  LVM_INSERTITEM         = LVM_INSERTITEMW;
{$ELSE}
  {$EXTERNALSYM LVM_GETITEM}
  LVM_GETITEM            = LVM_GETITEMA;
  {$EXTERNALSYM LVM_SETITEM}
  LVM_SETITEM            = LVM_SETITEMA;
  {$EXTERNALSYM LVM_INSERTITEM}
  LVM_INSERTITEM         = LVM_INSERTITEMA;
{$ENDIF}

  {$EXTERNALSYM LVM_DELETEITEM}
  LVM_DELETEITEM          = LVM_FIRST + 8;
  {$EXTERNALSYM LVM_DELETEALLITEMS}
  LVM_DELETEALLITEMS      = LVM_FIRST + 9;
  {$EXTERNALSYM LVM_GETCALLBACKMASK}
  LVM_GETCALLBACKMASK     = LVM_FIRST + 10;
  {$EXTERNALSYM LVM_SETCALLBACKMASK}
  LVM_SETCALLBACKMASK     = LVM_FIRST + 11;

{$EXTERNALSYM ListView_GetItem}
function ListView_GetItem(hWnd: HWND; var pItem: TLVItem): Bool; inline;
{$EXTERNALSYM ListView_GetItemA}
function ListView_GetItemA(hWnd: HWND; var pItem: TLVItemA): Bool; inline;
{$EXTERNALSYM ListView_GetItemW}
function ListView_GetItemW(hWnd: HWND; var pItem: TLVItemW): Bool; inline;
{$EXTERNALSYM ListView_SetItem}
function ListView_SetItem(hWnd: HWND; const pItem: TLVItem): Bool; inline;
{$EXTERNALSYM ListView_SetItemA}
function ListView_SetItemA(hWnd: HWND; const pItem: TLVItemA): Bool; inline;
{$EXTERNALSYM ListView_SetItemW}
function ListView_SetItemW(hWnd: HWND; const pItem: TLVItemW): Bool; inline;
{$EXTERNALSYM ListView_InsertItem}
function ListView_InsertItem(hWnd: HWND; const pItem: TLVItem): Integer; inline;
{$EXTERNALSYM ListView_InsertItemA}
function ListView_InsertItemA(hWnd: HWND; const pItem: TLVItemA): Integer; inline;
{$EXTERNALSYM ListView_InsertItemW}
function ListView_InsertItemW(hWnd: HWND; const pItem: TLVItemW): Integer; inline;
{$EXTERNALSYM ListView_DeleteItem}
function ListView_DeleteItem(hWnd: HWND; i: Integer): Bool; inline;
{$EXTERNALSYM ListView_DeleteAllItems}
function ListView_DeleteAllItems(hWnd: HWND): Bool; inline;
{$EXTERNALSYM ListView_GetCallbackMask}
function ListView_GetCallbackMask(hWnd: HWND): UINT; inline;
{$EXTERNALSYM ListView_SetCallbackMask}
function ListView_SetCallbackMask(hWnd: HWND; mask: UINT): Bool; inline;

const
  {$EXTERNALSYM LVNI_ALL}
  LVNI_ALL                = $0000;
  {$EXTERNALSYM LVNI_FOCUSED}
  LVNI_FOCUSED            = $0001;
  {$EXTERNALSYM LVNI_SELECTED}
  LVNI_SELECTED           = $0002;
  {$EXTERNALSYM LVNI_CUT}
  LVNI_CUT                = $0004;
  {$EXTERNALSYM LVNI_DROPHILITED}
  LVNI_DROPHILITED        = $0008;

  {$EXTERNALSYM LVNI_ABOVE}
  LVNI_ABOVE              = $0100;
  {$EXTERNALSYM LVNI_BELOW}
  LVNI_BELOW              = $0200;
  {$EXTERNALSYM LVNI_TOLEFT}
  LVNI_TOLEFT             = $0400;
  {$EXTERNALSYM LVNI_TORIGHT}
  LVNI_TORIGHT            = $0800;


const
  {$EXTERNALSYM LVM_GETNEXTITEM}
  LVM_GETNEXTITEM         = LVM_FIRST + 12;

{$EXTERNALSYM ListView_GetNextItem}
function ListView_GetNextItem(hWnd: HWND; iStart: Integer; Flags: UINT): Integer;

const
  {$EXTERNALSYM LVFI_PARAM}
  LVFI_PARAM              = $0001;
  {$EXTERNALSYM LVFI_STRING}
  LVFI_STRING             = $0002;
  {$EXTERNALSYM LVFI_SUBSTRING}
  LVFI_SUBSTRING          = $0004; // Same as LVFI_PARTIAL
  {$EXTERNALSYM LVFI_PARTIAL}
  LVFI_PARTIAL            = $0008;
  {$EXTERNALSYM LVFI_WRAP}
  LVFI_WRAP               = $0020;
  {$EXTERNALSYM LVFI_NEARESTXY}
  LVFI_NEARESTXY          = $0040;


type
  PLVFindInfoA = ^TLVFindInfoA;
  PLVFindInfoW = ^TLVFindInfoW;
  PLVFindInfo = PLVFindInfoW;
  {$EXTERNALSYM tagLVFINDINFOA}
  tagLVFINDINFOA = record
    flags: UINT;
    psz: LPCSTR;
    lParam: LPARAM;
    pt: TPoint;
    vkDirection: UINT;
  end;
  {$EXTERNALSYM tagLVFINDINFOW}
  tagLVFINDINFOW = record
    flags: UINT;
    psz: LPCWSTR;
    lParam: LPARAM;
    pt: TPoint;
    vkDirection: UINT;
  end;
  {$EXTERNALSYM tagLVFINDINFO}
  tagLVFINDINFO = tagLVFINDINFOW;
  {$EXTERNALSYM _LV_FINDINFOA}
  _LV_FINDINFOA = tagLVFINDINFOA;
  {$EXTERNALSYM _LV_FINDINFOW}
  _LV_FINDINFOW = tagLVFINDINFOW;
  {$EXTERNALSYM _LV_FINDINFO}
  _LV_FINDINFO = _LV_FINDINFOW;
  TLVFindInfoA = tagLVFINDINFOA;
  TLVFindInfoW = tagLVFINDINFOW;
  TLVFindInfo = TLVFindInfoW;
  {$EXTERNALSYM LV_FINDINFOA}
  LV_FINDINFOA = tagLVFINDINFOA;
  {$EXTERNALSYM LV_FINDINFOW}
  LV_FINDINFOW = tagLVFINDINFOW;
  {$EXTERNALSYM LV_FINDINFO}
  LV_FINDINFO = LV_FINDINFOW;

const
  {$EXTERNALSYM LVM_FINDITEMA}
  LVM_FINDITEMA            = LVM_FIRST + 13;
  {$EXTERNALSYM LVM_FINDITEMW}
  LVM_FINDITEMW            = LVM_FIRST + 83;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_FINDITEM}
  LVM_FINDITEM            = LVM_FINDITEMW;
{$ELSE}
  {$EXTERNALSYM LVM_FINDITEM}
  LVM_FINDITEM            = LVM_FINDITEMA;
{$ENDIF}

{$EXTERNALSYM ListView_FindItem}
function ListView_FindItem(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfo): Integer; inline;
{$EXTERNALSYM ListView_FindItemA}
function ListView_FindItemA(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfoA): Integer; inline;
{$EXTERNALSYM ListView_FindItemW}
function ListView_FindItemW(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfoW): Integer; inline;

const
  {$EXTERNALSYM LVIR_BOUNDS}
  LVIR_BOUNDS             = 0;
  {$EXTERNALSYM LVIR_ICON}
  LVIR_ICON               = 1;
  {$EXTERNALSYM LVIR_LABEL}
  LVIR_LABEL              = 2;
  {$EXTERNALSYM LVIR_SELECTBOUNDS}
  LVIR_SELECTBOUNDS       = 3;


const
  {$EXTERNALSYM LVM_GETITEMRECT}
  LVM_GETITEMRECT         = LVM_FIRST + 14;

{$EXTERNALSYM ListView_GetItemRect}
function ListView_GetItemRect(hWnd: HWND; i: Integer; var prc: TRect;
  Code: Integer): Bool;

const
  {$EXTERNALSYM LVM_SETITEMPOSITION}
  LVM_SETITEMPOSITION     = LVM_FIRST + 15;

{$EXTERNALSYM ListView_SetItemPosition}
function ListView_SetItemPosition(hWnd: HWND; i, x, y: Integer): Bool;

const
  {$EXTERNALSYM LVM_GETITEMPOSITION}
  LVM_GETITEMPOSITION     = LVM_FIRST + 16;

{$EXTERNALSYM ListView_GetItemPosition}
function ListView_GetItemPosition(hwndLV: HWND; i: Integer; var ppt: TPoint): Bool; inline;

const
  {$EXTERNALSYM LVM_GETSTRINGWIDTHA}
  LVM_GETSTRINGWIDTHA      = LVM_FIRST + 17;
  {$EXTERNALSYM LVM_GETSTRINGWIDTHW}
  LVM_GETSTRINGWIDTHW      = LVM_FIRST + 87;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_GETSTRINGWIDTH}
  LVM_GETSTRINGWIDTH      = LVM_GETSTRINGWIDTHW;
{$ELSE}
  {$EXTERNALSYM LVM_GETSTRINGWIDTH}
  LVM_GETSTRINGWIDTH      = LVM_GETSTRINGWIDTHA;
{$ENDIF}

{$EXTERNALSYM ListView_GetStringWidth}
function ListView_GetStringWidth(hwndLV: HWND; psz: LPCWSTR): Integer; inline;
{$EXTERNALSYM ListView_GetStringWidthA}
function ListView_GetStringWidthA(hwndLV: HWND; psz: LPCSTR): Integer; inline;
{$EXTERNALSYM ListView_GetStringWidthW}
function ListView_GetStringWidthW(hwndLV: HWND; psz: LPCWSTR): Integer; inline;

const
  {$EXTERNALSYM LVHT_NOWHERE}
  LVHT_NOWHERE            = $0001;
  {$EXTERNALSYM LVHT_ONITEMICON}
  LVHT_ONITEMICON         = $0002;
  {$EXTERNALSYM LVHT_ONITEMLABEL}
  LVHT_ONITEMLABEL        = $0004;
  {$EXTERNALSYM LVHT_ONITEMSTATEICON}
  LVHT_ONITEMSTATEICON    = $0008;
  {$EXTERNALSYM LVHT_ONITEM}
  LVHT_ONITEM             = LVHT_ONITEMICON or LVHT_ONITEMLABEL or LVHT_ONITEMSTATEICON;
  {$EXTERNALSYM LVHT_ABOVE}
  LVHT_ABOVE              = $0008;
  {$EXTERNALSYM LVHT_BELOW}
  LVHT_BELOW              = $0010;
  {$EXTERNALSYM LVHT_TORIGHT}
  LVHT_TORIGHT            = $0020;
  {$EXTERNALSYM LVHT_TOLEFT}
  LVHT_TOLEFT             = $0040;

type
  PLVHitTestInfo = ^TLVHitTestInfo;
  {$EXTERNALSYM tagLVHITTESTINFO}
  tagLVHITTESTINFO = record
    pt: TPoint;
    flags: UINT;
    iItem: Integer;
    
    iSubItem: Integer;    // this is was NOT in win95.  valid only for LVM_SUBITEMHITTEST
    
                                       
    iGroup: Integer; // readonly. index of group. only valid for owner data.
                     // supports single item in multiple groups.
    
  end;
  TLVHitTestInfo = tagLVHITTESTINFO;
  {$EXTERNALSYM LV_HITTESTINFO}
  LV_HITTESTINFO = tagLVHITTESTINFO;
  {$EXTERNALSYM _LV_HITTESTINFO}
  _LV_HITTESTINFO = tagLVHITTESTINFO;

const
  {$EXTERNALSYM LVM_HITTEST}
  LVM_HITTEST             = LVM_FIRST + 18;

{$EXTERNALSYM ListView_HitTest}
function ListView_HitTest(hwndLV: HWND; var pinfo: TLVHitTestInfo): Integer; inline;

{$EXTERNALSYM ListView_HitTestEx}
function ListView_HitTestEx(hwndLV: HWND; var pinfo: TLVHitTestInfo): Integer; inline;

const
  {$EXTERNALSYM LVM_ENSUREVISIBLE}
  LVM_ENSUREVISIBLE       = LVM_FIRST + 19;

{$EXTERNALSYM ListView_EnsureVisible}
function ListView_EnsureVisible(hwndLV: HWND; i: Integer; fPartialOK: Bool): Bool;

const
  {$EXTERNALSYM LVM_SCROLL}
  LVM_SCROLL              = LVM_FIRST + 20;

{$EXTERNALSYM ListView_Scroll}
function ListView_Scroll(hwndLV: HWnd; DX, DY: Integer): Bool; inline;

const
  {$EXTERNALSYM LVM_REDRAWITEMS}
  LVM_REDRAWITEMS         = LVM_FIRST + 21;

{$EXTERNALSYM ListView_RedrawItems}
function ListView_RedrawItems(hwndLV: HWND; iFirst, iLast: Integer): Bool; inline;

const
  {$EXTERNALSYM LVA_DEFAULT}
  LVA_DEFAULT             = $0000;
  {$EXTERNALSYM LVA_ALIGNLEFT}
  LVA_ALIGNLEFT           = $0001;
  {$EXTERNALSYM LVA_ALIGNTOP}
  LVA_ALIGNTOP            = $0002;
  LVA_ALIGNRIGHT          = $0003;
  LVA_ALIGNBOTTOM         = $0004;
  {$EXTERNALSYM LVA_SNAPTOGRID}
  LVA_SNAPTOGRID          = $0005;

  LVA_SORTASCENDING       = $0100;
  LVA_SORTDESCENDING      = $0200;

  {$EXTERNALSYM LVM_ARRANGE}
  LVM_ARRANGE             = LVM_FIRST + 22;

{$EXTERNALSYM ListView_Arrange}
function ListView_Arrange(hwndLV: HWND; Code: UINT): Bool; inline;


const
  {$EXTERNALSYM LVM_EDITLABELA}
  LVM_EDITLABELA           = LVM_FIRST + 23;
  {$EXTERNALSYM LVM_EDITLABELW}
  LVM_EDITLABELW           = LVM_FIRST + 118;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_EDITLABEL}
  LVM_EDITLABEL           = LVM_EDITLABELW;
{$ELSE}
  {$EXTERNALSYM LVM_EDITLABEL}
  LVM_EDITLABEL           = LVM_EDITLABELA;
{$ENDIF}

{$EXTERNALSYM ListView_EditLabel}
function ListView_EditLabel(hwndLV: HWND; i: Integer): HWND; inline;
{$EXTERNALSYM ListView_EditLabelA}
function ListView_EditLabelA(hwndLV: HWND; i: Integer): HWND; inline;
{$EXTERNALSYM ListView_EditLabelW}
function ListView_EditLabelW(hwndLV: HWND; i: Integer): HWND; inline;

const
  {$EXTERNALSYM LVM_GETEDITCONTROL}
  LVM_GETEDITCONTROL      = LVM_FIRST + 24;

{$EXTERNALSYM ListView_GetEditControl}
function ListView_GetEditControl(hwndLV: HWND): HWND; inline;

type
  PLVColumnA = ^TLVColumnA;
  PLVColumnW = ^TLVColumnW;
  PLVColumn = PLVColumnW;
  {$EXTERNALSYM tagLVCOLUMNA}
  tagLVCOLUMNA = record
    mask: UINT;
    fmt: Integer;
    cx: Integer;
    pszText: LPSTR;
    cchTextMax: Integer;
    iSubItem: Integer;
    
    iImage: Integer;
    iOrder: Integer;
    
                                       
    cxMin: Integer;     // min snap point
    cxDefault: Integer; // default snap point
    cxIdeal: Integer;   // read only. ideal may not eqaul current width if auto sized (LVS_EX_AUTOSIZECOLUMNS) to a lesser width.
    
  end;
  {$EXTERNALSYM tagLVCOLUMNW}
  tagLVCOLUMNW = record
    mask: UINT;
    fmt: Integer;
    cx: Integer;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iSubItem: Integer;
    
    iImage: Integer;
    iOrder: Integer;
    
                                       
    cxMin: Integer;     // min snap point
    cxDefault: Integer; // default snap point
    cxIdeal: Integer;   // read only. ideal may not eqaul current width if auto sized (LVS_EX_AUTOSIZECOLUMNS) to a lesser width.
    
  end;
  {$EXTERNALSYM tagLVCOLUMN}
  tagLVCOLUMN = tagLVCOLUMNW;
  {$EXTERNALSYM _LV_COLUMNA}
  _LV_COLUMNA = tagLVCOLUMNA;
  {$EXTERNALSYM _LV_COLUMNW}
  _LV_COLUMNW = tagLVCOLUMNW;
  {$EXTERNALSYM _LV_COLUMN}
  _LV_COLUMN = _LV_COLUMNW;
  TLVColumnA = tagLVCOLUMNA;
  TLVColumnW = tagLVCOLUMNW;
  TLVColumn = TLVColumnW;
  {$EXTERNALSYM LV_COLUMNA}
  LV_COLUMNA = tagLVCOLUMNA;
  {$EXTERNALSYM LV_COLUMNW}
  LV_COLUMNW = tagLVCOLUMNW;
  {$EXTERNALSYM LV_COLUMN}
  LV_COLUMN = LV_COLUMNW;

const
  {$EXTERNALSYM LVCF_FMT}
  LVCF_FMT                = $0001;
  {$EXTERNALSYM LVCF_WIDTH}
  LVCF_WIDTH              = $0002;
  {$EXTERNALSYM LVCF_TEXT}
  LVCF_TEXT               = $0004;
  {$EXTERNALSYM LVCF_SUBITEM}
  LVCF_SUBITEM            = $0008;
  {$EXTERNALSYM LVCF_IMAGE}
  LVCF_IMAGE              = $0010;
  {$EXTERNALSYM LVCF_ORDER}
  LVCF_ORDER              = $0020;
  { For Windows >= Vista }
  {$EXTERNALSYM LVCF_MINWIDTH}
  LVCF_MINWIDTH           = $0040;
  {$EXTERNALSYM LVCF_DEFAULTWIDTH}
  LVCF_DEFAULTWIDTH       = $0080;
  {$EXTERNALSYM LVCF_IDEALWIDTH}
  LVCF_IDEALWIDTH         = $0100;

// LVCFMT_ flags up to FFFF are shared with the header control (HDF_ flags).
// Flags above FFFF are listview-specific.

  {$EXTERNALSYM LVCFMT_LEFT}
  LVCFMT_LEFT             = $0000; 
  {$EXTERNALSYM LVCFMT_RIGHT}
  LVCFMT_RIGHT            = $0001;
  {$EXTERNALSYM LVCFMT_CENTER}
  LVCFMT_CENTER           = $0002; 
  {$EXTERNALSYM LVCFMT_JUSTIFYMASK}
  LVCFMT_JUSTIFYMASK      = $0003;
  {$EXTERNALSYM LVCFMT_IMAGE}
  LVCFMT_IMAGE            = $0800;
  {$EXTERNALSYM LVCFMT_BITMAP_ON_RIGHT}
  LVCFMT_BITMAP_ON_RIGHT  = $1000;
  {$EXTERNALSYM LVCFMT_COL_HAS_IMAGES}
  LVCFMT_COL_HAS_IMAGES   = $8000;
  { For Windows >= Vista }
  {$EXTERNALSYM LVCFMT_FIXED_WIDTH}
  LVCFMT_FIXED_WIDTH          = $00100;  // Can't resize the column; same as HDF_FIXEDWIDTH
  {$EXTERNALSYM LVCFMT_NO_DPI_SCALE}
  LVCFMT_NO_DPI_SCALE         = $40000;  // If not set, CCM_DPISCALE will govern scaling up fixed width
  {$EXTERNALSYM LVCFMT_FIXED_RATIO}
  LVCFMT_FIXED_RATIO          = $80000;  // Width will augment with the row height

  { For Windows >= Vista }
  // The following flags
  {$EXTERNALSYM LVCFMT_LINE_BREAK}
  LVCFMT_LINE_BREAK           = $100000; // Move to the top of the next list of columns
  {$EXTERNALSYM LVCFMT_FILL}
  LVCFMT_FILL                 = $200000; // Fill the remainder of the tile area. Might have a title.
  {$EXTERNALSYM LVCFMT_WRAP}
  LVCFMT_WRAP                 = $400000; // This sub-item can be wrapped.
  {$EXTERNALSYM LVCFMT_NO_TITLE}
  LVCFMT_NO_TITLE             = $800000; // This sub-item doesn't have an title.
  {$EXTERNALSYM LVCFMT_TILE_PLACEMENTMASK}
  LVCFMT_TILE_PLACEMENTMASK   = LVCFMT_LINE_BREAK or LVCFMT_FILL;

  { For Windows >= Vista }
  {$EXTERNALSYM LVCFMT_SPLITBUTTON}
  LVCFMT_SPLITBUTTON          = $1000000; // Column is a split button; same as HDF_SPLITBUTTON

  {$EXTERNALSYM LVM_GETCOLUMNA}
  LVM_GETCOLUMNA          = LVM_FIRST + 25;
  {$EXTERNALSYM LVM_GETCOLUMNW}
  LVM_GETCOLUMNW          = LVM_FIRST + 95;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_GETCOLUMN}
  LVM_GETCOLUMN           = LVM_GETCOLUMNW;
{$ELSE}
  {$EXTERNALSYM LVM_GETCOLUMN}
  LVM_GETCOLUMN           = LVM_GETCOLUMNA;
{$ENDIF}

{$EXTERNALSYM ListView_GetColumn}
function ListView_GetColumn(hwnd: HWND; iCol: Integer;
  var pcol: TLVColumn): Bool; inline;
{$EXTERNALSYM ListView_GetColumnA}
function ListView_GetColumnA(hwnd: HWND; iCol: Integer;
  var pcol: TLVColumnA): Bool; inline;
{$EXTERNALSYM ListView_GetColumnW}
function ListView_GetColumnW(hwnd: HWND; iCol: Integer;
  var pcol: TLVColumnW): Bool; inline;

const
  {$EXTERNALSYM LVM_SETCOLUMNA}
  LVM_SETCOLUMNA           = LVM_FIRST + 26;
  {$EXTERNALSYM LVM_SETCOLUMNW}
  LVM_SETCOLUMNW           = LVM_FIRST + 96;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_SETCOLUMN}
  LVM_SETCOLUMN           = LVM_SETCOLUMNW;
{$ELSE}
  {$EXTERNALSYM LVM_SETCOLUMN}
  LVM_SETCOLUMN           = LVM_SETCOLUMNA;
{$ENDIF}

{$EXTERNALSYM ListView_SetColumn}
function ListView_SetColumn(hwnd: HWnd; iCol: Integer; const pcol: TLVColumn): Bool; inline;
{$EXTERNALSYM ListView_SetColumnA}
function ListView_SetColumnA(hwnd: HWnd; iCol: Integer; const pcol: TLVColumnA): Bool; inline;
{$EXTERNALSYM ListView_SetColumnW}
function ListView_SetColumnW(hwnd: HWnd; iCol: Integer; const pcol: TLVColumnW): Bool; inline;

const
  {$EXTERNALSYM LVM_INSERTCOLUMNA}
  LVM_INSERTCOLUMNA        = LVM_FIRST + 27;
  {$EXTERNALSYM LVM_INSERTCOLUMNW}
  LVM_INSERTCOLUMNW        = LVM_FIRST + 97;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_INSERTCOLUMN}
  LVM_INSERTCOLUMN        = LVM_INSERTCOLUMNW;
{$ELSE}
  {$EXTERNALSYM LVM_INSERTCOLUMN}
  LVM_INSERTCOLUMN        = LVM_INSERTCOLUMNA;
{$ENDIF}

{$EXTERNALSYM ListView_InsertColumn}
function ListView_InsertColumn(hwnd: HWND; iCol: Integer;
  const pcol: TLVColumn): Integer; inline;
{$EXTERNALSYM ListView_InsertColumnA}
function ListView_InsertColumnA(hwnd: HWND; iCol: Integer;
  const pcol: TLVColumnA): Integer; inline;
{$EXTERNALSYM ListView_InsertColumnW}
function ListView_InsertColumnW(hwnd: HWND; iCol: Integer;
  const pcol: TLVColumnW): Integer; inline;

const
  {$EXTERNALSYM LVM_DELETECOLUMN}
  LVM_DELETECOLUMN        = LVM_FIRST + 28;

{$EXTERNALSYM ListView_DeleteColumn}
function ListView_DeleteColumn(hwnd: HWND; iCol: Integer): Bool; inline;

const
  {$EXTERNALSYM LVM_GETCOLUMNWIDTH}
  LVM_GETCOLUMNWIDTH      = LVM_FIRST + 29;

{$EXTERNALSYM ListView_GetColumnWidth}
function ListView_GetColumnWidth(hwnd: HWND; iCol: Integer): Integer; inline;

const
  {$EXTERNALSYM LVSCW_AUTOSIZE}
  LVSCW_AUTOSIZE              = -1;
  {$EXTERNALSYM LVSCW_AUTOSIZE_USEHEADER}
  LVSCW_AUTOSIZE_USEHEADER    = -2;
  {$EXTERNALSYM LVM_SETCOLUMNWIDTH}
  LVM_SETCOLUMNWIDTH          = LVM_FIRST + 30;

{$EXTERNALSYM ListView_SetColumnWidth}
function ListView_SetColumnWidth(hwnd: HWnd; iCol: Integer; cx: Integer): Bool;

const
  {$EXTERNALSYM LVM_GETHEADER}
  LVM_GETHEADER               = LVM_FIRST + 31;

{$EXTERNALSYM ListView_GetHeader}
function ListView_GetHeader(hwnd: HWND): HWND;

const
  {$EXTERNALSYM LVM_CREATEDRAGIMAGE}
  LVM_CREATEDRAGIMAGE     = LVM_FIRST + 33;

{$EXTERNALSYM ListView_CreateDragImage}
function ListView_CreateDragImage(hwnd: HWND; i: Integer;
  const lpptUpLeft: TPoint): HIMAGELIST; inline;

const
  {$EXTERNALSYM LVM_GETVIEWRECT}
  LVM_GETVIEWRECT         = LVM_FIRST + 34;

{$EXTERNALSYM ListView_GetViewRect}
function ListView_GetViewRect(hwnd: HWND; var prc: TRect): Bool; inline;

const
  {$EXTERNALSYM LVM_GETTEXTCOLOR}
  LVM_GETTEXTCOLOR        = LVM_FIRST + 35;

{$EXTERNALSYM ListView_GetTextColor}
function ListView_GetTextColor(hwnd: HWND): TColorRef; inline;

const
  {$EXTERNALSYM LVM_SETTEXTCOLOR}
  LVM_SETTEXTCOLOR        = LVM_FIRST + 36;

{$EXTERNALSYM ListView_SetTextColor}
function ListView_SetTextColor(hwnd: HWND; clrText: TColorRef): Bool; inline;

const
  {$EXTERNALSYM LVM_GETTEXTBKCOLOR}
  LVM_GETTEXTBKCOLOR      = LVM_FIRST + 37;

{$EXTERNALSYM ListView_GetTextBkColor}
function ListView_GetTextBkColor(hwnd: HWND): TColorRef; inline;

const
  {$EXTERNALSYM LVM_SETTEXTBKCOLOR}
  LVM_SETTEXTBKCOLOR      = LVM_FIRST + 38;

{$EXTERNALSYM ListView_SetTextBkColor}
function ListView_SetTextBkColor(hwnd: HWND; clrTextBk: TColorRef): Bool; inline;

const
  {$EXTERNALSYM LVM_GETTOPINDEX}
  LVM_GETTOPINDEX         = LVM_FIRST + 39;

{$EXTERNALSYM ListView_GetTopIndex}
function ListView_GetTopIndex(hwndLV: HWND): Integer; inline;

const
  {$EXTERNALSYM LVM_GETCOUNTPERPAGE}
  LVM_GETCOUNTPERPAGE     = LVM_FIRST + 40;

{$EXTERNALSYM ListView_GetCountPerPage}
function ListView_GetCountPerPage(hwndLV: HWND): Integer; inline;

const
  {$EXTERNALSYM LVM_GETORIGIN}
  LVM_GETORIGIN           = LVM_FIRST + 41;

{$EXTERNALSYM ListView_GetOrigin}
function ListView_GetOrigin(hwndLV: HWND; var ppt: TPoint): Bool; inline;

const
  {$EXTERNALSYM LVM_UPDATE}
  LVM_UPDATE              = LVM_FIRST + 42;

{$EXTERNALSYM ListView_Update}
function ListView_Update(hwndLV: HWND; i: Integer): Bool; inline;

const
  {$EXTERNALSYM LVM_SETITEMSTATE}
  LVM_SETITEMSTATE        = LVM_FIRST + 43;

{$EXTERNALSYM ListView_SetItemState}
function ListView_SetItemState(hwndLV: HWND; i: Integer; data, mask: UINT): Bool;

const
  {$EXTERNALSYM LVM_GETITEMSTATE}
  LVM_GETITEMSTATE        = LVM_FIRST + 44;

{$EXTERNALSYM ListView_GetItemState}
function ListView_GetItemState(hwndLV: HWND; i, mask: Integer): Integer; inline;

{$EXTERNALSYM ListView_GetCheckState}
function ListView_GetCheckState(hwndLV: HWND; i: Integer): UINT; inline;
{$EXTERNALSYM ListView_SetCheckState}
procedure ListView_SetCheckState(hwndLV: HWND; i: Integer; Checked: Boolean);

const
  {$EXTERNALSYM LVM_GETITEMTEXTA}
  LVM_GETITEMTEXTA         = LVM_FIRST + 45;
  {$EXTERNALSYM LVM_GETITEMTEXTW}
  LVM_GETITEMTEXTW         = LVM_FIRST + 115;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_GETITEMTEXT}
  LVM_GETITEMTEXT         = LVM_GETITEMTEXTW;
{$ELSE}
  {$EXTERNALSYM LVM_GETITEMTEXT}
  LVM_GETITEMTEXT         = LVM_GETITEMTEXTA;
{$ENDIF}

{$EXTERNALSYM ListView_GetItemText}
function ListView_GetItemText(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR; cchTextMax: Integer): Integer;
{$EXTERNALSYM ListView_GetItemTextA}
function ListView_GetItemTextA(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPSTR; cchTextMax: Integer): Integer;
{$EXTERNALSYM ListView_GetItemTextW}
function ListView_GetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR; cchTextMax: Integer): Integer;

const
  {$EXTERNALSYM LVM_SETITEMTEXTA}
  LVM_SETITEMTEXTA         = LVM_FIRST + 46;
  {$EXTERNALSYM LVM_SETITEMTEXTW}
  LVM_SETITEMTEXTW         = LVM_FIRST + 116;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_SETITEMTEXT}
  LVM_SETITEMTEXT         = LVM_SETITEMTEXTW;
{$ELSE}
  {$EXTERNALSYM LVM_SETITEMTEXT}
  LVM_SETITEMTEXT         = LVM_SETITEMTEXTA;
{$ENDIF}

{$EXTERNALSYM ListView_SetItemText}
function ListView_SetItemText(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR): Bool;
{$EXTERNALSYM ListView_SetItemTextA}
function ListView_SetItemTextA(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPSTR): Bool;
{$EXTERNALSYM ListView_SetItemTextW}
function ListView_SetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR): Bool;

const
  // these flags only apply to LVS_OWNERDATA listviews in report or list mode
  {$EXTERNALSYM LVSICF_NOINVALIDATEALL}
  LVSICF_NOINVALIDATEALL  = $00000001;
  {$EXTERNALSYM LVSICF_NOSCROLL}
  LVSICF_NOSCROLL         = $00000002;

  {$EXTERNALSYM LVM_SETITEMCOUNT}
  LVM_SETITEMCOUNT        = LVM_FIRST + 47;

{$EXTERNALSYM ListView_SetItemCount}
procedure ListView_SetItemCount(hwndLV: HWND; cItems: Integer); inline;

{$EXTERNALSYM ListView_SetItemCountEx}
procedure ListView_SetItemCountEx(hwndLV: HWND; cItems: Integer; dwFlags: DWORD); inline;

type
  {$EXTERNALSYM PFNLVCOMPARE}
  PFNLVCOMPARE = function(lParam1, lParam2, lParamSort: LPARAM): Integer stdcall;
  TLVCompare = PFNLVCOMPARE;

const
  {$EXTERNALSYM LVM_SORTITEMS}
  LVM_SORTITEMS           = LVM_FIRST + 48;

{$EXTERNALSYM ListView_SortItems}
function ListView_SortItems(hwndLV: HWND; pfnCompare: TLVCompare;
  lPrm: LPARAM): Bool; inline;

const
  {$EXTERNALSYM LVM_SETITEMPOSITION32}
  LVM_SETITEMPOSITION32   = LVM_FIRST + 49;

{$EXTERNALSYM ListView_SetItemPosition32}
procedure ListView_SetItemPosition32(hwndLV: HWND; i, x, y: Integer);

const
  {$EXTERNALSYM LVM_GETSELECTEDCOUNT}
  LVM_GETSELECTEDCOUNT    = LVM_FIRST + 50;

{$EXTERNALSYM ListView_GetSelectedCount}
function ListView_GetSelectedCount(hwndLV: HWND): UINT; inline;

const
  {$EXTERNALSYM LVM_GETITEMSPACING}
  LVM_GETITEMSPACING      = LVM_FIRST + 51;

{$EXTERNALSYM ListView_GetItemSpacing}
function ListView_GetItemSpacing(hwndLV: HWND; fSmall: Integer): DWORD; inline;

const
  {$EXTERNALSYM LVM_GETISEARCHSTRINGA}
  LVM_GETISEARCHSTRINGA    = LVM_FIRST + 52;
  {$EXTERNALSYM LVM_GETISEARCHSTRINGW}
  LVM_GETISEARCHSTRINGW    = LVM_FIRST + 117;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_GETISEARCHSTRING}
  LVM_GETISEARCHSTRING    = LVM_GETISEARCHSTRINGW;
{$ELSE}
  {$EXTERNALSYM LVM_GETISEARCHSTRING}
  LVM_GETISEARCHSTRING    = LVM_GETISEARCHSTRINGA;
{$ENDIF}

{$EXTERNALSYM ListView_GetISearchString}
function ListView_GetISearchString(hwndLV: HWND; lpsz: LPWSTR): Bool; inline;
{$EXTERNALSYM ListView_GetISearchStringA}
function ListView_GetISearchStringA(hwndLV: HWND; lpsz: LPSTR): Bool; inline;
{$EXTERNALSYM ListView_GetISearchStringW}
function ListView_GetISearchStringW(hwndLV: HWND; lpsz: LPWSTR): Bool; inline;

const
  {$EXTERNALSYM LVM_SETICONSPACING}
  LVM_SETICONSPACING      = LVM_FIRST + 53;

// -1 for cx and cy means we'll use the default (system settings)
// 0 for cx or cy means use the current setting (allows you to change just one param)
{$EXTERNALSYM ListView_SetIconSpacing}
function ListView_SetIconSpacing(hwndLV: HWND; cx, cy: Word): DWORD;

const
  {$EXTERNALSYM LVM_SETEXTENDEDLISTVIEWSTYLE}
  LVM_SETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 54;

{$EXTERNALSYM ListView_SetExtendedListViewStyle}
function ListView_SetExtendedListViewStyle(hwndLV: HWND; dw: DWORD): BOOL; inline;

{$EXTERNALSYM ListView_SetExtendedListViewStyleEx}
function ListView_SetExtendedListViewStyleEx(hwndLV: HWND; dwMask: DWORD; dw: DWORD): BOOL; inline;

const
  {$EXTERNALSYM LVM_GETEXTENDEDLISTVIEWSTYLE}
  LVM_GETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 55;

{$EXTERNALSYM ListView_GetExtendedListViewStyle}
function ListView_GetExtendedListViewStyle(hwndLV: HWND): DWORD; inline;

const
  {$EXTERNALSYM LVM_GETSUBITEMRECT}
  LVM_GETSUBITEMRECT      = LVM_FIRST + 56;

{$EXTERNALSYM ListView_GetSubItemRect}
function ListView_GetSubItemRect(hwndLV: HWND; iItem, iSubItem: Integer;
  code: DWORD; prc: PRect): BOOL;

const
  {$EXTERNALSYM LVM_SUBITEMHITTEST}
  LVM_SUBITEMHITTEST      = LVM_FIRST + 57;

{$EXTERNALSYM ListView_SubItemHitTest}
function ListView_SubItemHitTest(hwndLV: HWND; plvhti: PLVHitTestInfo): Integer; inline;

{$EXTERNALSYM ListView_SubItemHitTestEx}
function ListView_SubItemHitTestEx(hwndLV: HWND; plvhti: PLVHitTestInfo): Integer; inline;

const
  {$EXTERNALSYM LVM_SETCOLUMNORDERARRAY}
  LVM_SETCOLUMNORDERARRAY = LVM_FIRST + 58;

{$EXTERNALSYM ListView_SetColumnOrderArray}
function ListView_SetColumnOrderArray(hwndLV: HWND; iCount: Integer;
  pi: PInteger): BOOL; inline;

const
  {$EXTERNALSYM LVM_GETCOLUMNORDERARRAY}
  LVM_GETCOLUMNORDERARRAY = LVM_FIRST + 59;

{$EXTERNALSYM ListView_GetColumnOrderArray}
function ListView_GetColumnOrderArray(hwndLV: HWND; iCount: Integer;
  pi: PInteger): BOOL; inline;

const
  {$EXTERNALSYM LVM_SETHOTITEM}
  LVM_SETHOTITEM  = LVM_FIRST + 60;

{$EXTERNALSYM ListView_SetHotItem}
function ListView_SetHotItem(hwndLV: HWND; i: Integer): Integer; inline;

const
  {$EXTERNALSYM LVM_GETHOTITEM}
  LVM_GETHOTITEM  = LVM_FIRST + 61;

{$EXTERNALSYM ListView_GetHotItem}
function ListView_GetHotItem(hwndLV: HWND): Integer; inline;

const
  {$EXTERNALSYM LVM_SETHOTCURSOR}
  LVM_SETHOTCURSOR  = LVM_FIRST + 62;

{$EXTERNALSYM ListView_SetHotCursor}
function ListView_SetHotCursor(hwndLV: HWND; hcur: HCURSOR): HCURSOR; inline;

const
  {$EXTERNALSYM LVM_GETHOTCURSOR}
  LVM_GETHOTCURSOR  = LVM_FIRST + 63;

{$EXTERNALSYM ListView_GetHotCursor}
function ListView_GetHotCursor(hwndLV: HWND): HCURSOR; inline;

const
  {$EXTERNALSYM LVM_APPROXIMATEVIEWRECT}
  LVM_APPROXIMATEVIEWRECT = LVM_FIRST + 64;

{$EXTERNALSYM ListView_ApproximateViewRect}
function ListView_ApproximateViewRect(hwndLV: HWND; iWidth, iHeight: Word;
  iCount: Integer): DWORD;

const
  {$EXTERNALSYM LV_MAX_WORKAREAS}
  LV_MAX_WORKAREAS        = 16;
  {$EXTERNALSYM LVM_SETWORKAREA}
  LVM_SETWORKAREA         = LVM_FIRST + 65;

{$EXTERNALSYM ListView_SetWorkAreas}
function ListView_SetWorkAreas(hwndLV: HWND; nWorkAreas: Integer; prc: PRect): BOOL; inline;

const
  {$EXTERNALSYM LVM_GETSELECTIONMARK}
  LVM_GETSELECTIONMARK    = LVM_FIRST + 66;

{$EXTERNALSYM ListView_GetSelectionMark}
function ListView_GetSelectionMark(hwnd: HWND): Integer; inline;

const
  {$EXTERNALSYM LVM_SETSELECTIONMARK}
  LVM_SETSELECTIONMARK    = LVM_FIRST + 67;

{$EXTERNALSYM ListView_SetSelectionMark}
function ListView_SetSelectionMark(hwnd: HWND; i: Integer): Integer; inline;

const
  {$EXTERNALSYM LVM_GETWORKAREAS}
  LVM_GETWORKAREAS        = LVM_FIRST + 70;

{$EXTERNALSYM ListView_GetWorkAreas}
function ListView_GetWorkAreas(hwnd: HWND; nWorkAreas: Integer; prc: PRect): BOOL; inline;

const
  {$EXTERNALSYM LVM_SETHOVERTIME}
  LVM_SETHOVERTIME        = LVM_FIRST + 71;

{$EXTERNALSYM ListView_SetHoverTime}
function ListView_SetHoverTime(hwndLV: HWND; dwHoverTimeMs: DWORD): DWORD; inline;

const
  {$EXTERNALSYM LVM_GETHOVERTIME}
  LVM_GETHOVERTIME        = LVM_FIRST + 72;

{$EXTERNALSYM ListView_GetHoverTime}
function ListView_GetHoverTime(hwndLV: HWND): Integer; inline;

const
  {$EXTERNALSYM LVM_GETNUMBEROFWORKAREAS}
  LVM_GETNUMBEROFWORKAREAS  = LVM_FIRST + 73;

{$EXTERNALSYM ListView_GetNumberOfWorkAreas}
function ListView_GetNumberOfWorkAreas(hwnd: HWND; pnWorkAreas: PInteger): Integer; inline;

const
  {$EXTERNALSYM LVM_SETTOOLTIPS}
  LVM_SETTOOLTIPS       = LVM_FIRST + 74;

{$EXTERNALSYM ListView_SetToolTips}
function ListView_SetToolTips(hwndLV: HWND; hwndNewHwnd: HWND): HWND; inline;

const
  {$EXTERNALSYM LVM_GETTOOLTIPS}
  LVM_GETTOOLTIPS       = LVM_FIRST + 78;

{$EXTERNALSYM ListView_GetToolTips}
function ListView_GetToolTips(hwndLV: HWND): HWND; inline;

const
  {$EXTERNALSYM LVM_SORTITEMSEX}
  LVM_SORTITEMSEX       = LVM_FIRST + 81;

{$EXTERNALSYM ListView_SortItemsEx}
function ListView_SortItemsEx(hwndLV: HWND; _pfnCompare: TLVCompare; _lPrm: LPARAM): BOOL; inline;

type
{$EXTERNALSYM tagLVBKIMAGEA}
  tagLVBKIMAGEA = record
    ulFlags: ULONG;              // LVBKIF_*
    hbm: HBITMAP;
    pszImage: LPSTR;
    cchImageMax: UINT;
    xOffsetPercent: Integer;
    yOffsetPercent: Integer;
  end;
{$EXTERNALSYM tagLVBKIMAGEW}
  tagLVBKIMAGEW = record
    ulFlags: ULONG;              // LVBKIF_*
    hbm: HBITMAP;
    pszImage: LPWSTR;
    cchImageMax: UINT;
    xOffsetPercent: Integer;
    yOffsetPercent: Integer;
  end;
  {$EXTERNALSYM tagLVBKIMAGE}
  tagLVBKIMAGE = tagLVBKIMAGEW;
  PLVBKImageA = ^TLVBKImageA;
  PLVBKImageW = ^TLVBKImageW;
  PLVBKImage = PLVBKImageW;
  TLVBKImageA = tagLVBKIMAGEA;
  TLVBKImageW = tagLVBKIMAGEW;
  TLVBKImage = TLVBKImageW;

const
  {$EXTERNALSYM LVBKIF_SOURCE_NONE}
  LVBKIF_SOURCE_NONE      = $00000000;
  {$EXTERNALSYM LVBKIF_SOURCE_HBITMAP}
  LVBKIF_SOURCE_HBITMAP   = $00000001;
  {$EXTERNALSYM LVBKIF_SOURCE_URL}
  LVBKIF_SOURCE_URL       = $00000002;
  {$EXTERNALSYM LVBKIF_SOURCE_MASK}
  LVBKIF_SOURCE_MASK      = $00000003;
  {$EXTERNALSYM LVBKIF_STYLE_NORMAL}
  LVBKIF_STYLE_NORMAL     = $00000000;
  {$EXTERNALSYM LVBKIF_STYLE_TILE}
  LVBKIF_STYLE_TILE       = $00000010;
  {$EXTERNALSYM LVBKIF_STYLE_MASK}
  LVBKIF_STYLE_MASK       = $00000010;
  { For Windows >= XP }
  {$EXTERNALSYM LVBKIF_FLAG_TILEOFFSET}
  LVBKIF_FLAG_TILEOFFSET  = $00000100;
  {$EXTERNALSYM LVBKIF_TYPE_WATERMARK}
  LVBKIF_TYPE_WATERMARK   = $10000000;
  {$EXTERNALSYM LVBKIF_FLAG_ALPHABLEND}
  LVBKIF_FLAG_ALPHABLEND  = $20000000;

  {$EXTERNALSYM LVM_SETBKIMAGEA}
  LVM_SETBKIMAGEA         = LVM_FIRST + 68;
  {$EXTERNALSYM LVM_SETBKIMAGEW}
  LVM_SETBKIMAGEW         = LVM_FIRST + 138;
  {$EXTERNALSYM LVM_GETBKIMAGEA}
  LVM_GETBKIMAGEA         = LVM_FIRST + 69;
  {$EXTERNALSYM LVM_GETBKIMAGEW}
  LVM_GETBKIMAGEW         = LVM_FIRST + 139;
  { For Windows >= XP }
  {$EXTERNALSYM LVM_SETSELECTEDCOLUMN}
  LVM_SETSELECTEDCOLUMN   = LVM_FIRST + 140;
  {$EXTERNALSYM LVM_SETVIEW}
  LVM_SETVIEW             = LVM_FIRST + 142;
  {$EXTERNALSYM LVM_GETVIEW}
  LVM_GETVIEW             = LVM_FIRST + 143;

{ For Windows >= XP }
{$EXTERNALSYM ListView_SetSelectedColumn}
function ListView_SetSelectedColumn(hwnd: HWND; iCol: Integer): Integer; inline;
{$EXTERNALSYM ListView_SetView}
function ListView_SetView(hwnd: HWND; iView: Integer): Integer; inline;
{$EXTERNALSYM ListView_GetView}
function ListView_GetView(hwnd: HWND): Integer; inline;

const
  { For Windows >= XP }
  {$EXTERNALSYM LV_VIEW_ICON}
  LV_VIEW_ICON            = $0000;
  {$EXTERNALSYM LV_VIEW_DETAILS}
  LV_VIEW_DETAILS         = $0001;
  {$EXTERNALSYM LV_VIEW_SMALLICON}
  LV_VIEW_SMALLICON       = $0002;
  {$EXTERNALSYM LV_VIEW_LIST}
  LV_VIEW_LIST            = $0003;
  {$EXTERNALSYM LV_VIEW_TILE}
  LV_VIEW_TILE            = $0004;
  {$EXTERNALSYM LV_VIEW_MAX}
  LV_VIEW_MAX             = $0004;

  { For Windows >= XP }
  {$EXTERNALSYM LVGF_NONE}
  LVGF_NONE           = $00000000;
  {$EXTERNALSYM LVGF_HEADER}
  LVGF_HEADER         = $00000001;
  {$EXTERNALSYM LVGF_FOOTER}
  LVGF_FOOTER         = $00000002;
  {$EXTERNALSYM LVGF_STATE}
  LVGF_STATE          = $00000004;
  {$EXTERNALSYM LVGF_ALIGN}
  LVGF_ALIGN          = $00000008;
  {$EXTERNALSYM LVGF_GROUPID}
  LVGF_GROUPID        = $00000010;

  { For Windows >= Vista }
  {$EXTERNALSYM LVGF_SUBTITLE}
  LVGF_SUBTITLE           = $00000100;  { pszSubtitle is valid }
  {$EXTERNALSYM LVGF_TASK}
  LVGF_TASK               = $00000200;  { pszTask is valid }
  {$EXTERNALSYM LVGF_DESCRIPTIONTOP}
  LVGF_DESCRIPTIONTOP     = $00000400;  { pszDescriptionTop is valid }
  {$EXTERNALSYM LVGF_DESCRIPTIONBOTTOM}
  LVGF_DESCRIPTIONBOTTOM  = $00000800;  { pszDescriptionBottom is valid }
  {$EXTERNALSYM LVGF_TITLEIMAGE}
  LVGF_TITLEIMAGE         = $00001000;  { iTitleImage is valid }
  {$EXTERNALSYM LVGF_EXTENDEDIMAGE}
  LVGF_EXTENDEDIMAGE      = $00002000;  { iExtendedImage is valid }
  {$EXTERNALSYM LVGF_ITEMS}
  LVGF_ITEMS              = $00004000;  { iFirstItem and cItems are valid }
  {$EXTERNALSYM LVGF_SUBSET}
  LVGF_SUBSET             = $00008000;  { pszSubsetTitle is valid }
  {$EXTERNALSYM LVGF_SUBSETITEMS}
  LVGF_SUBSETITEMS        = $00010000;  { readonly, cItems holds count of items in visible subset, iFirstItem is valid }

  { For Windows >= XP }
  {$EXTERNALSYM LVGS_NORMAL}
  LVGS_NORMAL             = $00000000;
  {$EXTERNALSYM LVGS_COLLAPSED}
  LVGS_COLLAPSED          = $00000001;
  {$EXTERNALSYM LVGS_HIDDEN}
  LVGS_HIDDEN             = $00000002;
  {$EXTERNALSYM LVGS_NOHEADER}
  LVGS_NOHEADER           = $00000004;
  {$EXTERNALSYM LVGS_COLLAPSIBLE}
  LVGS_COLLAPSIBLE        = $00000008;
  {$EXTERNALSYM LVGS_FOCUSED}
  LVGS_FOCUSED            = $00000010;
  {$EXTERNALSYM LVGS_SELECTED}
  LVGS_SELECTED           = $00000020;
  {$EXTERNALSYM LVGS_SUBSETED}
  LVGS_SUBSETED           = $00000040;
  {$EXTERNALSYM LVGS_SUBSETLINKFOCUSED}
  LVGS_SUBSETLINKFOCUSED  = $00000080;

  { For Windows >= XP }
  {$EXTERNALSYM LVGA_HEADER_LEFT}
  LVGA_HEADER_LEFT    = $00000001;
  {$EXTERNALSYM LVGA_HEADER_CENTER}
  LVGA_HEADER_CENTER  = $00000002;
  {$EXTERNALSYM LVGA_HEADER_RIGHT}
  LVGA_HEADER_RIGHT   = $00000004;  { Don't forget to validate exclusivity }
  {$EXTERNALSYM LVGA_FOOTER_LEFT}
  LVGA_FOOTER_LEFT    = $00000008;
  {$EXTERNALSYM LVGA_FOOTER_CENTER}
  LVGA_FOOTER_CENTER  = $00000010;
  {$EXTERNALSYM LVGA_FOOTER_RIGHT}
  LVGA_FOOTER_RIGHT   = $00000020;  { Don't forget to validate exclusivity }

type
  { $EXTERNALSYM tagLVGROUP}
  tagLVGROUP = record
    cbSize: UINT;
    mask: UINT;
    pszHeader: LPWSTR;
    cchHeader: Integer;

    pszFooter: LPWSTR;
    cchFooter: Integer;

    iGroupId: Integer;

    stateMask: UINT;
    state: UINT;
    uAlign: UINT;
    {For Windows >= Vista}
    pszSubtitle: LPWSTR;
    cchSubtitle: UINT;
    pszTask: LPWSTR;
    cchTask: UINT;
    pszDescriptionTop: LPWSTR;
    cchDescriptionTop: UINT;
    pszDescriptionBottom: LPWSTR;
    cchDescriptionBottom: UINT;
    iTitleImage: Integer;
    iExtendedImage: Integer;
    iFirstItem: Integer;     { Read only }
    cItems: UINT;            { Read only }
    pszSubsetTitle: LPWSTR;  { NULL if group is not subset }
    cchSubsetTitle: UINT; 
  end;
  PLVGroup = ^TLVGroup;
  TLVGroup = tagLVGROUP;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVM_INSERTGROUP}
  LVM_INSERTGROUP         = LVM_FIRST + 145;
  {$EXTERNALSYM LVM_SETGROUPINFO}
  LVM_SETGROUPINFO        = LVM_FIRST + 147;
  {$EXTERNALSYM LVM_GETGROUPINFO}
  LVM_GETGROUPINFO        = LVM_FIRST + 149;
  {$EXTERNALSYM LVM_REMOVEGROUP}
  LVM_REMOVEGROUP         = LVM_FIRST + 150;
  {$EXTERNALSYM LVM_MOVEGROUP}
  LVM_MOVEGROUP           = LVM_FIRST + 151;

  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETGROUPCOUNT}
  LVM_GETGROUPCOUNT       = LVM_FIRST + 152;
  {$EXTERNALSYM LVM_GETGROUPINFOBYINDEX}
  LVM_GETGROUPINFOBYINDEX = LVM_FIRST + 153;
  {$EXTERNALSYM LVM_MOVEITEMTOGROUP}
  LVM_MOVEITEMTOGROUP     = LVM_FIRST + 154;

{ For Windows >= XP }
{$EXTERNALSYM ListView_InsertGroup}
function ListView_InsertGroup(hwnd: HWND; index: Integer; const pgrp: TLVGroup): Integer; inline;
{$EXTERNALSYM ListView_SetGroupInfo}
function ListView_SetGroupInfo(hwnd: HWND; iGroupId: Integer; const pgrp: TLVGroup): Integer; inline;
{$EXTERNALSYM ListView_GetGroupInfo}
function ListView_GetGroupInfo(hwnd: HWND; iGroupId: Integer; var pgrp: TLVGroup): Integer; inline;
{$EXTERNALSYM ListView_RemoveGroup}
function ListView_RemoveGroup(hwnd: HWND; iGroupId: Integer): Integer; inline;
{$EXTERNALSYM ListView_MoveGroup}
function ListView_MoveGroup(hwnd: HWND; iGroupId, toIndex: Integer): Integer; inline;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_GetGroupCount}
function ListView_GetGroupCount(hwnd: HWND): Integer; inline;
{$EXTERNALSYM ListView_GetGroupInfoByIndex}
function ListView_GetGroupInfoByIndex(hwnd: HWND; iIndex: Integer; var pgrp: TLVGroup): Integer; inline;
{$EXTERNALSYM ListView_MoveItemToGroup}
function ListView_MoveItemToGroup(hwnd: HWND; idItemFrom, idGroupTo: Integer): Integer; inline;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVGGR_GROUP}
  LVGGR_GROUP         = 0; // Entire expanded group
  {$EXTERNALSYM LVGGR_HEADER}
  LVGGR_HEADER        = 1; // Header only (collapsed group)
  {$EXTERNALSYM LVGGR_LABEL}
  LVGGR_LABEL         = 2; // Label only
  {$EXTERNALSYM LVGGR_SUBSETLINK}
  LVGGR_SUBSETLINK    = 3; // subset link only

  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETGROUPRECT}
  LVM_GETGROUPRECT               = LVM_FIRST + 98;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_GetGroupRect}
function ListView_GetGroupRect(hwnd: HWND; iGroupId, iType: Integer;
  var prc: TRect): Integer; inline;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVGMF_NONE}
  LVGMF_NONE          = $00000000;
  {$EXTERNALSYM LVGMF_BORDERSIZE}
  LVGMF_BORDERSIZE    = $00000001;
  {$EXTERNALSYM LVGMF_BORDERCOLOR}
  LVGMF_BORDERCOLOR   = $00000002;
  {$EXTERNALSYM LVGMF_TEXTCOLOR}
  LVGMF_TEXTCOLOR     = $00000004;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLVGROUPMETRICS}
  tagLVGROUPMETRICS = record
    cbSize: UINT;
    mask: UINT;
    Left: UINT;
    Top: UINT;
    Right: UINT;
    Bottom: UINT;
    crLeft: COLORREF;
    crTop: COLORREF;
    crRight: COLORREF;
    crBottom: COLORREF;
    crHeader: COLORREF;
    crFooter: COLORREF;
  end;
  PLVGroupMetrics = ^TLVGroupMetrics;
  TLVGroupMetrics = tagLVGROUPMETRICS;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVM_SETGROUPMETRICS}
  LVM_SETGROUPMETRICS         = LVM_FIRST + 155;
  {$EXTERNALSYM LVM_GETGROUPMETRICS}
  LVM_GETGROUPMETRICS         = LVM_FIRST + 156;
  {$EXTERNALSYM LVM_ENABLEGROUPVIEW}
  LVM_ENABLEGROUPVIEW         = LVM_FIRST + 157;
  {$EXTERNALSYM LVM_SORTGROUPS}
  LVM_SORTGROUPS              = LVM_FIRST + 158;

type
  { For Windows >= XP }
  { $EXTERNALSYM PFNLVGROUPCOMPARE}
  PFNLVGROUPCOMPARE = function(Group1_ID: Integer; Group2_ID: Integer;
    pvData: Pointer): Integer; stdcall;
  TFNLVGroupCompare = PFNLVGROUPCOMPARE;

{ For Windows >= XP }
{$EXTERNALSYM ListView_SetGroupMetrics}
function ListView_SetGroupMetrics(hwnd: HWND; const pGroupMetrics: TLVGroupMetrics): Integer; inline;
{$EXTERNALSYM ListView_GetGroupMetrics}
function ListView_GetGroupMetrics(hwnd: HWND; var pGroupMetrics: TLVGroupMetrics): Integer; inline;
{$EXTERNALSYM ListView_EnableGroupView}
function ListView_EnableGroupView(hwnd: HWND; fEnable: BOOL): Integer; inline;
{$EXTERNALSYM ListView_SortGroups}
function ListView_SortGroups(hwnd: HWND; pfnGroupCompare: TFNLVGroupCompare; plv: Pointer): Integer; inline;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLVINSERTGROUPSORTED}
  tagLVINSERTGROUPSORTED = record
    pfnGroupCompare: PFNLVGROUPCOMPARE;
    pvData: Pointer;
    lvGroup: TLVGroup;
  end;
  PLVInsertGroupSorted = ^TLVInsertGroupSorted;
  TLVInsertGroupSorted = tagLVINSERTGROUPSORTED;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVM_INSERTGROUPSORTED}
  LVM_INSERTGROUPSORTED           = LVM_FIRST + 159;
  {$EXTERNALSYM LVM_REMOVEALLGROUPS}
  LVM_REMOVEALLGROUPS             = LVM_FIRST + 160;
  {$EXTERNALSYM LVM_HASGROUP}
  LVM_HASGROUP                    = LVM_FIRST + 161;
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETGROUPSTATE}
  LVM_GETGROUPSTATE               = LVM_FIRST + 92;
  {$EXTERNALSYM LVM_GETFOCUSEDGROUP}
  LVM_GETFOCUSEDGROUP             = LVM_FIRST + 93;

{ For Windows >= XP }
{$EXTERNALSYM ListView_InsertGroupSorted}
function ListView_InsertGroupSorted(hwnd: HWND; const structInsert: TLVInsertGroupSorted): Integer; inline;
{$EXTERNALSYM ListView_RemoveAllGroups}
function ListView_RemoveAllGroups(hwnd: HWND): Integer; inline;
{$EXTERNALSYM ListView_HasGroup}
function ListView_HasGroup(hwnd: HWND; dwGroupId: Integer): Integer; inline;
{ For Windows >= Vista }
{$EXTERNALSYM ListView_SetGroupState}
function ListView_SetGroupState(hwnd: HWND; dwGroupId, dwMask, dwState: UINT): Integer;
{$EXTERNALSYM ListView_GetGroupState}
function ListView_GetGroupState(hwnd: HWND; dwGroupId, dwMask: UINT): Integer; inline;
{$EXTERNALSYM ListView_GetFocusedGroup}
function ListView_GetFocusedGroup(hwnd: HWND): Integer; inline;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVTVIF_AUTOSIZE}
  LVTVIF_AUTOSIZE       = $00000000;
  {$EXTERNALSYM LVTVIF_FIXEDWIDTH}
  LVTVIF_FIXEDWIDTH     = $00000001;
  {$EXTERNALSYM LVTVIF_FIXEDHEIGHT}
  LVTVIF_FIXEDHEIGHT    = $00000002;
  {$EXTERNALSYM LVTVIF_FIXEDSIZE}
  LVTVIF_FIXEDSIZE      = $00000003;
  { For Windows >= Vista }
  {$EXTERNALSYM LVTVIF_EXTENDED}
  LVTVIF_EXTENDED       = $00000004;

  { For Windows >= XP }
  {$EXTERNALSYM LVTVIM_TILESIZE}
  LVTVIM_TILESIZE       = $00000001;
  {$EXTERNALSYM LVTVIM_COLUMNS}
  LVTVIM_COLUMNS        = $00000002;
  {$EXTERNALSYM LVTVIM_LABELMARGIN}
  LVTVIM_LABELMARGIN    = $00000004;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLVTILEVIEWINFO}
  tagLVTILEVIEWINFO = record
    cbSize: UINT;
    dwMask: DWORD;      // LVTVIM_*
    dwFlags: DWORD;     // LVTVIF_*
    sizeTile: SIZE;
    cLines: Integer;
    rcLabelMargin: TRect;
  end;
  PLVTileViewInfo = ^TLVTileViewInfo;
  TLVTileViewInfo = tagLVTILEVIEWINFO;

  { For Windows >= XP }
  { $EXTERNALSYM tagLVTILEINFO}
  tagLVTILEINFO = record
    cbSize: UINT;
    iItem: Integer;
    cColumns: UINT;
    puColumns: PUINT;
                                      
    piColFmt: PInteger;
    
  end;
  PLVTileInfo = ^TLVTileInfo;
  TLVTileInfo = tagLVTILEINFO;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVM_SETTILEVIEWINFO}
  LVM_SETTILEVIEWINFO                 = LVM_FIRST + 162;
  {$EXTERNALSYM LVM_GETTILEVIEWINFO}
  LVM_GETTILEVIEWINFO                 = LVM_FIRST + 163;
  {$EXTERNALSYM LVM_SETTILEINFO}
  LVM_SETTILEINFO                     = LVM_FIRST + 164;
  {$EXTERNALSYM LVM_GETTILEINFO}
  LVM_GETTILEINFO                     = LVM_FIRST + 165;

{ For Windows >= XP }
{$EXTERNALSYM ListView_SetTileViewInfo}
function ListView_SetTileViewInfo(hwnd: HWND; const ptvi: TLVTileViewInfo): Integer; inline;
{$EXTERNALSYM ListView_GetTileViewInfo}
function ListView_GetTileViewInfo(hwnd: HWND; var ptvi: TLVTileViewInfo): Integer; inline;
{$EXTERNALSYM ListView_SetTileInfo}
function ListView_SetTileInfo(hwnd: HWND; const pti: TLVTileInfo): Integer; inline;
{$EXTERNALSYM ListView_GetTileInfo}
function ListView_GetTileInfo(hwnd: HWND; var pti: TLVTileInfo): Integer; inline;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLVINSERTMARK}
  tagLVINSERTMARK = record
    cbSize: UINT;
    dwFlags: DWORD;
    iItem: Integer;
    dwReserved: DWORD;
  end;
  PLVInsertMark = ^TLVInsertMark;
  TLVInsertMark = tagLVINSERTMARK;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVIM_AFTER}
  LVIM_AFTER      = $00000001; // TRUE = insert After iItem, otherwise before

  { For Windows >= XP }
  {$EXTERNALSYM LVM_SETINSERTMARK}
  LVM_SETINSERTMARK                   = LVM_FIRST + 166;
  {$EXTERNALSYM LVM_GETINSERTMARK}
  LVM_GETINSERTMARK                   = LVM_FIRST + 167;
  {$EXTERNALSYM LVM_INSERTMARKHITTEST}
  LVM_INSERTMARKHITTEST               = LVM_FIRST + 168;
  {$EXTERNALSYM LVM_GETINSERTMARKRECT}
  LVM_GETINSERTMARKRECT               = LVM_FIRST + 169;
  {$EXTERNALSYM LVM_SETINSERTMARKCOLOR}
  LVM_SETINSERTMARKCOLOR              = LVM_FIRST + 170;
  {$EXTERNALSYM LVM_GETINSERTMARKCOLOR}
  LVM_GETINSERTMARKCOLOR              = LVM_FIRST + 171;

{ For Windows >= XP }
{$EXTERNALSYM ListView_SetInsertMark}
function ListView_SetInsertMark(hwnd: HWND; const lvim: TLVInsertMark): BOOL; inline;
{$EXTERNALSYM ListView_GetInsertMark}
function ListView_GetInsertMark(hwnd: HWND; var lvim: TLVInsertMark): BOOL; inline;
{$EXTERNALSYM ListView_InsertMarkHitTest}
function ListView_InsertMarkHitTest(hwnd: HWND; const point: TPoint;
  const lvim: TLVInsertMark): Integer; inline;
{$EXTERNALSYM ListView_GetInsertMarkRect}
function ListView_GetInsertMarkRect(hwnd: HWND; var rc: TRect): Integer; inline;
{$EXTERNALSYM ListView_SetInsertMarkColor}
function ListView_SetInsertMarkColor(hwnd: HWND; color: TColorRef): TColorRef; inline;
{$EXTERNALSYM ListView_GetInsertMarkColor}
function ListView_GetInsertMarkColor(hwnd: HWND): TColorRef; inline;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagLVSETINFOTIP}
  tagLVSETINFOTIP = record
    cbSize: UINT;
    dwFlags: DWORD;
    pszText: LPWSTR;
    iItem: Integer;
    iSubItem: Integer;
  end;
  PLVSetInfoTip = ^TLVSetInfoTip;
  TLVSetInfoTip = tagLVSETINFOTIP;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVM_SETINFOTIP}
  LVM_SETINFOTIP          = LVM_FIRST + 173;
  {$EXTERNALSYM LVM_GETSELECTEDCOLUMN}
  LVM_GETSELECTEDCOLUMN   = LVM_FIRST + 174;
  {$EXTERNALSYM LVM_ISGROUPVIEWENABLED}
  LVM_ISGROUPVIEWENABLED  = LVM_FIRST + 175;
  {$EXTERNALSYM LVM_GETOUTLINECOLOR}
  LVM_GETOUTLINECOLOR     = LVM_FIRST + 176;
  {$EXTERNALSYM LVM_SETOUTLINECOLOR}
  LVM_SETOUTLINECOLOR     = LVM_FIRST + 177;
  {$EXTERNALSYM LVM_CANCELEDITLABEL}
  LVM_CANCELEDITLABEL     = LVM_FIRST + 179;
  {$EXTERNALSYM LVM_MAPINDEXTOID}
  LVM_MAPINDEXTOID        = LVM_FIRST + 180;
  {$EXTERNALSYM LVM_MAPIDTOINDEX}
  LVM_MAPIDTOINDEX        = LVM_FIRST + 181;
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_ISITEMVISIBLE}
  LVM_ISITEMVISIBLE       = LVM_FIRST + 182;

{ For Windows >= XP }
{$EXTERNALSYM ListView_SetInfoTip}
function ListView_SetInfoTip(hwndLV: HWND; const plvInfoTip: TLVSetInfoTip): BOOL; inline;
{$EXTERNALSYM ListView_GetSelectedColumn}
function ListView_GetSelectedColumn(hwnd: HWND): UINT; inline;
{$EXTERNALSYM ListView_IsGroupViewEnabled}
function ListView_IsGroupViewEnabled(hwnd: HWND): BOOL; inline;
{$EXTERNALSYM ListView_GetOutlineColor}
function ListView_GetOutlineColor(hwnd: HWND): TColorRef; inline;
{$EXTERNALSYM ListView_SetOutlineColor}
function ListView_SetOutlineColor(hwnd: HWND; color: TColorRef): TColorRef; inline;
{$EXTERNALSYM ListView_CancelEditLabel}
function ListView_CancelEditLabel(hwnd: HWND): Integer; inline;

// These next two methods make it easy to identify an item that can be repositioned
// within listview. For example: Many developers use the lParam to store an identifier that is
// unique. Unfortunatly, in order to find this item, they have to iterate through all of the items
// in the listview. Listview will maintain a unique identifier.  The upper bound is the size of a DWORD.
{$EXTERNALSYM ListView_MapIndexToID}
function ListView_MapIndexToID(hwnd: HWND; index: UINT): UINT; inline;
{$EXTERNALSYM ListView_MapIDToIndex}
function ListView_MapIDToIndex(hwnd: HWND; id: UINT): UINT; inline;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_IsItemVisible}
function ListView_IsItemVisible(hwnd: HWND; index: UINT): UINT; inline;
{$EXTERNALSYM ListView_SetGroupHeaderImageList}
function ListView_SetGroupHeaderImageList(hwnd: HWND; himl: HIMAGELIST): HIMAGELIST; inline;
{$EXTERNALSYM ListView_GetGroupHeaderImageList}
function ListView_GetGroupHeaderImageList(hwnd: HWND): HIMAGELIST; inline;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETEMPTYTEXT}
  LVM_GETEMPTYTEXT  = LVM_FIRST + 204;
  {$EXTERNALSYM LVM_GETFOOTERRECT}
  LVM_GETFOOTERRECT = LVM_FIRST + 205;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_GetEmptyText}
function ListView_GetEmptyText(hwnd: HWND; pszText: LPWSTR; cchText: UINT): BOOL; inline;
{$EXTERNALSYM ListView_GetFooterRect}
function ListView_GetFooterRect(hwnd: HWND; var prc: TRect): BOOL; inline;

const
  // footer flags
  { For Windows >= Vista }
  {$EXTERNALSYM LVFF_ITEMCOUNT}
  LVFF_ITEMCOUNT          = $00000001;

type
  { For Windows >= Vista }
  { $EXTERNALSYM tagLVFOOTERINFO}
  tagLVFOOTERINFO = record
    mask: UINT;         // LVFF_*
    pszText: LPWSTR;
    cchTextMax: Integer;
    cItems: UINT;
  end;
  PLVFooterInfo = ^TLVFooterInfo;
  TLVFooterInfo = tagLVFOOTERINFO;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETFOOTERINFO}
  LVM_GETFOOTERINFO = LVM_FIRST + 206;
  {$EXTERNALSYM LVM_GETFOOTERITEMRECT}
  LVM_GETFOOTERITEMRECT = LVM_FIRST + 207;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_GetFooterInfo}
function ListView_GetFooterInfo(hwnd: HWND; var plvfi: TLVFooterInfo): BOOL; inline;
{$EXTERNALSYM ListView_GetFooterItemRect}
function ListView_GetFooterItemRect(hwnd: HWND; iItem: UINT; var prc: TRect): BOOL; inline;

const
  { For Windows >= Vista }
  // footer item flags
  {$EXTERNALSYM LVFIF_TEXT}
  LVFIF_TEXT               = $00000001;
  {$EXTERNALSYM LVFIF_STATE}
  LVFIF_STATE              = $00000002;

  { For Windows >= Vista }
  // footer item state
  {$EXTERNALSYM LVFIS_FOCUSED}
  LVFIS_FOCUSED            = $0001;

type
  { For Windows >= Vista }
  { $EXTERNALSYM tagLVFOOTERITEM}
  tagLVFOOTERITEM = record
    mask: UINT;         // LVFIF_*
    iItem: Integer;
    pszText: LPWSTR;
    cchTextMax: Integer;
    state: UINT;        // LVFIS_*
    stateMask: UINT;    // LVFIS_*
  end;
  PLVFooterItem = ^TLVFooterItem;
  TLVFooterItem = tagLVFOOTERITEM;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETFOOTERITEM}
  LVM_GETFOOTERITEM = LVM_FIRST + 208;

{$EXTERNALSYM ListView_GetFooterItem}
function ListView_GetFooterItem(hwnd: HWND; iItem: UINT; var pfi: TLVFooterItem): BOOL; inline;

// supports a single item in multiple groups.
type
  { For Windows >= Vista }
  { $EXTERNALSYM tagLVITEMINDEX}
  tagLVITEMINDEX = record
    iItem: Integer;     // listview item index
    iGroup: Integer;    // group index (must be -1 if group view is not enabled)
  end;
  PLVItemIndex = ^TLVItemIndex;
  TLVItemIndex = tagLVITEMINDEX;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVM_GETITEMINDEXRECT}
  LVM_GETITEMINDEXRECT    = LVM_FIRST + 209;
  {$EXTERNALSYM LVM_SETITEMINDEXSTATE}
  LVM_SETITEMINDEXSTATE   = LVM_FIRST + 210;
  {$EXTERNALSYM LVM_GETNEXTITEMINDEX}
  LVM_GETNEXTITEMINDEX    = LVM_FIRST + 211;

{ For Windows >= Vista }
{$EXTERNALSYM ListView_GetItemIndexRect}
function ListView_GetItemIndexRect(hwnd: HWND; const plvii: TLVItemIndex;
  iSubItem, code: Integer; var prc: TRect): BOOL; inline;
{$EXTERNALSYM ListView_SetItemIndexState}
function ListView_SetItemIndexState(hwnd: HWND; const plvii: TLVItemIndex;
  data, mask: UINT): HRESULT;
{$EXTERNALSYM ListView_GetNextItemIndex}
function ListView_GetNextItemIndex(hwnd: HWND; var plvii: TLVItemIndex;
  flags: LPARAM): BOOL; inline;

const  
{$IFDEF UNICODE}
  {$EXTERNALSYM LVM_SETBKIMAGE}
  LVM_SETBKIMAGE = LVM_SETBKIMAGEW;
  {$EXTERNALSYM LVM_GETBKIMAGE}
  LVM_GETBKIMAGE = LVM_GETBKIMAGEW;
{$ELSE}
  {$EXTERNALSYM LVM_SETBKIMAGE}
  LVM_SETBKIMAGE = LVM_SETBKIMAGEA;
  {$EXTERNALSYM LVM_GETBKIMAGE}
  LVM_GETBKIMAGE = LVM_GETBKIMAGEA;
{$ENDIF}

{$EXTERNALSYM ListView_SetBkImage}
function ListView_SetBkImage(hwnd: HWND; plvbki: PLVBKImage): BOOL; inline;
{$EXTERNALSYM ListView_SetBkImage}
function ListView_SetBkImageA(hwnd: HWND; plvbki: PLVBKImageA): BOOL; inline;
{$EXTERNALSYM ListView_SetBkImage}
function ListView_SetBkImageW(hwnd: HWND; plvbki: PLVBKImageW): BOOL; inline;

{$EXTERNALSYM ListView_GetBkImage}
function ListView_GetBkImage(hwnd: HWND; plvbki: PLVBKImage): BOOL; inline;
{$EXTERNALSYM ListView_GetBkImage}
function ListView_GetBkImageA(hwnd: HWND; plvbki: PLVBKImageA): BOOL; inline;
{$EXTERNALSYM ListView_GetBkImage}
function ListView_GetBkImageW(hwnd: HWND; plvbki: PLVBKImageW): BOOL; inline;

type
  {$EXTERNALSYM tagNMLISTVIEW}
  tagNMLISTVIEW = record
    hdr: TNMHDR;
    iItem: Integer;
    iSubItem: Integer;
    uNewState: UINT;
    uOldState: UINT;
    uChanged: UINT;
    ptAction: TPoint;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM _NM_LISTVIEW}
  _NM_LISTVIEW = tagNMLISTVIEW;
  {$EXTERNALSYM NM_LISTVIEW}
  NM_LISTVIEW = tagNMLISTVIEW;
  PNMListView = ^TNMListView;
  TNMListView = tagNMLISTVIEW;

  // NMITEMACTIVATE is used instead of NMLISTVIEW in IE >= 0x400
  // therefore all the fields are the same except for extra uKeyFlags
  // they are used to store key flags at the time of the single click with
  // delayed activation - because by the time the timer goes off a user may
  // not hold the keys (shift, ctrl) any more
  {$EXTERNALSYM tagNMITEMACTIVATE}
  tagNMITEMACTIVATE = record
    hdr: TNMHdr;
    iItem: Integer;
    iSubItem: Integer;
    uNewState: UINT;
    uOldState: UINT;
    uChanged: UINT;
    ptAction: TPoint;
    lParam: LPARAM;
    uKeyFlags: UINT;
  end;
  PNMItemActivate = ^TNMItemActivate;
  TNMItemActivate = tagNMITEMACTIVATE;

const
  // key flags stored in uKeyFlags
  {$EXTERNALSYM LVKF_ALT}
  LVKF_ALT       = $0001;
  {$EXTERNALSYM LVKF_CONTROL}
  LVKF_CONTROL   = $0002;
  {$EXTERNALSYM LVKF_SHIFT}
  LVKF_SHIFT     = $0004;

type
  {$EXTERNALSYM tagNMLVCUSTOMDRAW}
  tagNMLVCUSTOMDRAW = record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iSubItem: Integer;
                                      
    dwItemType: DWORD;
    

    // Item custom draw
    clrFace: COLORREF;
    iIconEffect: Integer;
    iIconPhase: Integer;
    iPartId: Integer;
    iStateId: Integer;

    // Group Custom Draw
    rcText: TRect;
    uAlign: UINT;     // Alignment. Use LVGA_HEADER_CENTER, LVGA_HEADER_RIGHT, LVGA_HEADER_LEFT 
  end;
  PNMLVCustomDraw = ^TNMLVCustomDraw;
  TNMLVCustomDraw = tagNMLVCUSTOMDRAW;

const
  //dwItemType
  LVCDI_ITEM       = $00000000;
  {$EXTERNALSYM LVCDI_ITEM}
  LVCDI_GROUP      = $00000001;
  {$EXTERNALSYM LVCDI_GROUP}
  LVCDI_ITEMSLIST  = $00000002;
  {$EXTERNALSYM LVCDI_ITEMSLIST}

  // ListView custom draw return values
  LVCDRF_NOSELECT     = $00010000;
  {$EXTERNALSYM LVCDRF_NOSELECT}
  LVCDRF_NOGROUPFRAME = $00020000;
  {$EXTERNALSYM LVCDRF_NOGROUPFRAME}
type
  {$EXTERNALSYM tagNMLVCACHEHINT}
  tagNMLVCACHEHINT = record
    hdr: TNMHDR;
    iFrom: Integer;
    iTo: Integer;
  end;
  PNMLVCacheHint = ^TNMLVCacheHint;
  TNMLVCacheHint = tagNMLVCACHEHINT;
  PNMCacheHint = ^TNMCacheHint;
  TNMCacheHint = tagNMLVCACHEHINT;

  {$EXTERNALSYM tagNMLVFINDITEMA}
  tagNMLVFINDITEMA = record // WIN2K
    hdr: TNMHdr;
    iStart: Integer;
    lvfi: TLVFindInfoA;
  end;
  {$EXTERNALSYM tagNMLVFINDITEMW}
  tagNMLVFINDITEMW = record // WIN2K
    hdr: TNMHdr;
    iStart: Integer;
    lvfi: TLVFindInfoW;
  end;
  {$EXTERNALSYM tagNMLVFINDITEM}
  tagNMLVFINDITEM = tagNMLVFINDITEMW;
  PNMLVFinditemA = ^TNMLVFinditemA;
  PNMLVFinditemW = ^TNMLVFinditemW;
  PNMLVFinditem = PNMLVFinditemW;
  TNMLVFinditemA = tagNMLVFINDITEMA; // WIN2K
  TNMLVFinditemW = tagNMLVFINDITEMW; // WIN2K
  TNMLVFinditem = TNMLVFinditemW;

  PNMFinditemA = ^TNMFinditemA;
  PNMFinditemW = ^TNMFinditemW;
  PNMFinditem = PNMFinditemW;
  TNMFinditemA = tagNMLVFINDITEMA; // WIN2K
  TNMFinditemW = tagNMLVFINDITEMW; // WIN2K
  TNMFinditem = TNMFinditemW;

  {$EXTERNALSYM tagNMLVODSTATECHANGE}
  tagNMLVODSTATECHANGE = record
    hdr: TNMHdr;
    iFrom: Integer;
    iTo: Integer;
    uNewState: UINT;
    uOldState: UINT;
  end;
  PNMLVODStateChange = ^TNMLVODStateChange;
  TNMLVODStateChange = tagNMLVODSTATECHANGE;

const
  {$EXTERNALSYM LVN_ITEMCHANGING}
  LVN_ITEMCHANGING        = LVN_FIRST-0;
  {$EXTERNALSYM LVN_ITEMCHANGED}
  LVN_ITEMCHANGED         = LVN_FIRST-1;
  {$EXTERNALSYM LVN_INSERTITEM}
  LVN_INSERTITEM          = LVN_FIRST-2;
  {$EXTERNALSYM LVN_DELETEITEM}
  LVN_DELETEITEM          = LVN_FIRST-3;
  {$EXTERNALSYM LVN_DELETEALLITEMS}
  LVN_DELETEALLITEMS      = LVN_FIRST-4;
  {$EXTERNALSYM LVN_COLUMNCLICK}
  LVN_COLUMNCLICK         = LVN_FIRST-8;
  {$EXTERNALSYM LVN_BEGINDRAG}
  LVN_BEGINDRAG           = LVN_FIRST-9;
  {$EXTERNALSYM LVN_BEGINRDRAG}
  LVN_BEGINRDRAG          = LVN_FIRST-11;

  {$EXTERNALSYM LVN_ODCACHEHINT}
  LVN_ODCACHEHINT         = LVN_FIRST-13;
  {$EXTERNALSYM LVN_ODFINDITEMA}
  LVN_ODFINDITEMA         = LVN_FIRST-52;
  {$EXTERNALSYM LVN_ODFINDITEMW}
  LVN_ODFINDITEMW         = LVN_FIRST-79;

  {$EXTERNALSYM LVN_ITEMACTIVATE}
  LVN_ITEMACTIVATE        = LVN_FIRST-14;
  {$EXTERNALSYM LVN_ODSTATECHANGED}
  LVN_ODSTATECHANGED      = LVN_FIRST-15;

{$IFDEF UNICODE}
  {$EXTERNALSYM LVN_ODFINDITEM}
  LVN_ODFINDITEM          = LVN_ODFINDITEMW; 
{$ELSE}
  {$EXTERNALSYM LVN_ODFINDITEM}
  LVN_ODFINDITEM          = LVN_ODFINDITEMA; 
{$ENDIF}

  {$EXTERNALSYM LVN_BEGINLABELEDITA}
  LVN_BEGINLABELEDITA      = LVN_FIRST-5;
  {$EXTERNALSYM LVN_ENDLABELEDITA}
  LVN_ENDLABELEDITA        = LVN_FIRST-6;
  {$EXTERNALSYM LVN_BEGINLABELEDITW}
  LVN_BEGINLABELEDITW      = LVN_FIRST-75;
  {$EXTERNALSYM LVN_ENDLABELEDITW}
  LVN_ENDLABELEDITW        = LVN_FIRST-76;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVN_BEGINLABELEDIT}
  LVN_BEGINLABELEDIT      = LVN_BEGINLABELEDITW;
  {$EXTERNALSYM LVN_ENDLABELEDIT}
  LVN_ENDLABELEDIT        = LVN_ENDLABELEDITW;
{$ELSE}
  {$EXTERNALSYM LVN_BEGINLABELEDIT}
  LVN_BEGINLABELEDIT      = LVN_BEGINLABELEDITA;
  {$EXTERNALSYM LVN_ENDLABELEDIT}
  LVN_ENDLABELEDIT        = LVN_ENDLABELEDITA;
{$ENDIF}

  {$EXTERNALSYM LVN_HOTTRACK}
  LVN_HOTTRACK            = LVN_FIRST-21;
  
  {$EXTERNALSYM LVN_GETDISPINFOA}
  LVN_GETDISPINFOA        = LVN_FIRST-50;
  {$EXTERNALSYM LVN_SETDISPINFOA}
  LVN_SETDISPINFOA        = LVN_FIRST-51;
  {$EXTERNALSYM LVN_GETDISPINFOW}
  LVN_GETDISPINFOW        = LVN_FIRST-77;
  {$EXTERNALSYM LVN_SETDISPINFOW}
  LVN_SETDISPINFOW        = LVN_FIRST-78;
{$IFDEF UNICODE}
  {$EXTERNALSYM LVN_GETDISPINFO}
  LVN_GETDISPINFO        = LVN_GETDISPINFOW;
  {$EXTERNALSYM LVN_SETDISPINFO}
  LVN_SETDISPINFO        = LVN_SETDISPINFOW;
{$ELSE}
  {$EXTERNALSYM LVN_GETDISPINFO}
  LVN_GETDISPINFO        = LVN_GETDISPINFOA;
  {$EXTERNALSYM LVN_SETDISPINFO}
  LVN_SETDISPINFO        = LVN_SETDISPINFOA;
{$ENDIF}

  {$EXTERNALSYM LVIF_DI_SETITEM}
  LVIF_DI_SETITEM         = $1000;

type
{$IFNDEF UNICODE}
  PLVDispInfoA = ^TLVDispInfoA;
  PLVDispInfoW = ^TLVDispInfoW;
  PLVDispInfo = PLVDispInfoA;
  {$EXTERNALSYM tagLVDISPINFO}
  tagLVDISPINFO = record
    hdr: TNMHDR;
    item: TLVItemA;
  end;
  {$EXTERNALSYM _LV_DISPINFO}
  _LV_DISPINFO = tagLVDISPINFO;
  {$EXTERNALSYM tagLVDISPINFOW}
  tagLVDISPINFOW = record
    hdr: TNMHDR;
    item: TLVItemW;
  end;
  {$EXTERNALSYM _LV_DISPINFOW}
  _LV_DISPINFOW = tagLVDISPINFOW;
  TLVDispInfoA = tagLVDISPINFO;
  TLVDispInfoW = tagLVDISPINFOW;
  TLVDispInfo = TLVDispInfoA;
  {$EXTERNALSYM LV_DISPINFOA}
  LV_DISPINFOA = tagLVDISPINFO;
  {$EXTERNALSYM LV_DISPINFOW}
  LV_DISPINFOW = tagLVDISPINFOW;
  {$EXTERNALSYM LV_DISPINFO}
  LV_DISPINFO = LV_DISPINFOA;
{$ELSE}
  PLVDispInfoA = ^TLVDispInfoA;
  PLVDispInfoW = ^TLVDispInfoW;
  PLVDispInfo = PLVDispInfoW;
  {$EXTERNALSYM tagLVDISPINFOW}
  tagLVDISPINFOW = record
    hdr: TNMHDR;
    item: TLVItemW;
  end;
  {$EXTERNALSYM tagLVDISPINFO}
  tagLVDISPINFO = tagLVDISPINFOW;
  {$EXTERNALSYM _LV_DISPINFO}
  _LV_DISPINFO = tagLVDISPINFOW;
  {$EXTERNALSYM tagLVDISPINFOA}
  tagLVDISPINFOA = record
    hdr: TNMHDR;
    item: TLVItemA;
  end;
  {$EXTERNALSYM _LV_DISPINFOW}
  _LV_DISPINFOW = tagLVDISPINFO;
  TLVDispInfoW = tagLVDISPINFO;
  TLVDispInfoA = tagLVDISPINFO;
  TLVDispInfo = TLVDispInfoW;
  {$EXTERNALSYM LV_DISPINFOW}
  LV_DISPINFOW = tagLVDISPINFOW;
  {$EXTERNALSYM LV_DISPINFOA}
  LV_DISPINFOA = tagLVDISPINFO;
  {$EXTERNALSYM LV_DISPINFO}
  LV_DISPINFO = LV_DISPINFOW;
{$ENDIF}

const
  {$EXTERNALSYM LVN_KEYDOWN}
  LVN_KEYDOWN             = LVN_FIRST-55;

{$ALIGN 1}
type
  PLVKeyDown = ^TLVKeyDown;
  {$EXTERNALSYM tagLVKEYDOWN}
  tagLVKEYDOWN = record
    hdr: TNMHDR;
    wVKey: Word;
    flags: UINT;
  end;
  {$EXTERNALSYM _LV_KEYDOWN}
  _LV_KEYDOWN = tagLVKEYDOWN;
  TLVKeyDown = tagLVKEYDOWN;
  {$EXTERNALSYM LV_KEYDOWN}
  LV_KEYDOWN = tagLVKEYDOWN;
{$ALIGN ON}

const
  {$EXTERNALSYM LVN_MARQUEEBEGIN}
  LVN_MARQUEEBEGIN        = LVN_FIRST-56;

type
  { For Windows >= Vista }
  { $EXTERNALSYM tagNMLVLINK}
  tagNMLVLINK = record
    hdr: NMHDR;
    link: TLItem;
    iItem: Integer;
    iSubItem: Integer;
  end;
  PNMLVLink = ^TNMLVLink;
  TNMLVLink = tagNMLVLINK;

type
  {$EXTERNALSYM tagNMLVGETINFOTIPA}
  tagNMLVGETINFOTIPA = record
    hdr: TNMHdr;
    dwFlags: DWORD;
    pszText: LPSTR;
    cchTextMax: Integer;
    iItem: Integer;
    iSubItem: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMLVGETINFOTIPW}
  tagNMLVGETINFOTIPW = record
    hdr: TNMHdr;
    dwFlags: DWORD;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iItem: Integer;
    iSubItem: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMLVGETINFOTIP}
  tagNMLVGETINFOTIP = tagNMLVGETINFOTIPW;
  PNMLVGetInfoTipA = ^TNMLVGetInfoTipA;
  PNMLVGetInfoTipW = ^TNMLVGetInfoTipW;
  PNMLVGetInfoTip = PNMLVGetInfoTipW;
  TNMLVGetInfoTipA = tagNMLVGETINFOTIPA;
  TNMLVGetInfoTipW = tagNMLVGETINFOTIPW;
  TNMLVGetInfoTip = TNMLVGetInfoTipW;

const
  // NMLVGETINFOTIPA.dwFlag values
  {$EXTERNALSYM LVGIT_UNFOLDED}
  LVGIT_UNFOLDED  = $0001;

  {$EXTERNALSYM LVN_GETINFOTIPA}
  LVN_GETINFOTIPA          = LVN_FIRST-57;
  {$EXTERNALSYM LVN_GETINFOTIPW}
  LVN_GETINFOTIPW          = LVN_FIRST-58;

{$IFDEF UNICODE}
  {$EXTERNALSYM LVN_GETINFOTIP}
  LVN_GETINFOTIP          = LVN_GETINFOTIPW;
{$ELSE}
  {$EXTERNALSYM LVN_GETINFOTIP}
  LVN_GETINFOTIP          = LVN_GETINFOTIPA;
{$ENDIF}


// 
//  LVN_INCREMENTALSEARCH gives the app the opportunity to customize
//  incremental search.  For example, if the items are numeric,
//  the app can do numerical search instead of string search.
// 
//  ListView notifies the app with NMLVFINDITEM.
//  The app sets pnmfi->lvfi.lParam to the result of the incremental search,
//  or to LVNSCH_DEFAULT if ListView should do the default search,
//  or to LVNSCH_ERROR to fail the search and just beep,
//  or to LVNSCH_IGNORE to stop all ListView processing.
// 
//  The return value is not used.

  {$EXTERNALSYM LVNSCH_DEFAULT}
  LVNSCH_DEFAULT  = -1; 
  {$EXTERNALSYM LVNSCH_ERROR}
  LVNSCH_ERROR    = -2; 
  {$EXTERNALSYM LVNSCH_IGNORE}
  LVNSCH_IGNORE   = -3; 

  {$EXTERNALSYM LVN_INCREMENTALSEARCHA}
  LVN_INCREMENTALSEARCHA   = LVN_FIRST-62; 
  {$EXTERNALSYM LVN_INCREMENTALSEARCHW}
  LVN_INCREMENTALSEARCHW   = LVN_FIRST-63; 

  {$IFDEF UNICODE}
  LVN_INCREMENTALSEARCH    = LVN_INCREMENTALSEARCHW;
  {$ELSE}
  LVN_INCREMENTALSEARCH    = LVN_INCREMENTALSEARCHA;
  {$ENDIF}
  {$EXTERNALSYM LVN_INCREMENTALSEARCH}

  { For Windows >= Vista }
  {$EXTERNALSYM LVN_COLUMNDROPDOWN}
  LVN_COLUMNDROPDOWN       = LVN_FIRST-64;

  { For Windows >= Vista }
  {$EXTERNALSYM LVN_COLUMNOVERFLOWCLICK}
  LVN_COLUMNOVERFLOWCLICK  = LVN_FIRST-66;

type
  { For Windows >= XP }
  { $EXTERNALSYM tagNMLVSCROLL}
  tagNMLVSCROLL = record
    hdr: NMHDR;
    dx: Integer;
    dy: Integer;
  end;
  PNMLVScroll = ^TNMLVScroll;
  TNMLVScroll = tagNMLVSCROLL;

const
  { For Windows >= XP }
  {$EXTERNALSYM LVN_BEGINSCROLL}
  LVN_BEGINSCROLL          = LVN_FIRST-80;
  {$EXTERNALSYM LVN_ENDSCROLL}
  LVN_ENDSCROLL            = LVN_FIRST-81;

  { For Windows >= Vista }
  {$EXTERNALSYM LVN_LINKCLICK}
  LVN_LINKCLICK           = LVN_FIRST-84;

  { For Windows >= Vista }
  {$EXTERNALSYM EMF_CENTERED}
  EMF_CENTERED            = $00000001;  // render markup centered in the listview area

type
  { For Windows >= Vista }
  { $EXTERNALSYM tagNMLVEMPTYMARKUP}
  tagNMLVEMPTYMARKUP = record
    hdr: NMHDR;
    // out params from client back to listview
    dwFlags: DWORD;                     // EMF_*
    szMarkup: packed array[0..L_MAX_URL_LENGTH-1] of WCHAR;// markup displayed
  end;
  PNMLVEmptyMarkup = ^TNMLVEmptyMarkup;
  TNMLVEmptyMarkup = tagNMLVEMPTYMARKUP;

const
  { For Windows >= Vista }
  {$EXTERNALSYM LVN_GETEMPTYMARKUP}
  LVN_GETEMPTYMARKUP      = LVN_FIRST-87;


{ ====== TREEVIEW CONTROL =================== }

const
  {$EXTERNALSYM WC_TREEVIEW}
  WC_TREEVIEW = 'SysTreeView32';

const
  {$EXTERNALSYM TVS_HASBUTTONS}
  TVS_HASBUTTONS          = $0001;
  {$EXTERNALSYM TVS_HASLINES}
  TVS_HASLINES            = $0002;
  {$EXTERNALSYM TVS_LINESATROOT}
  TVS_LINESATROOT         = $0004;
  {$EXTERNALSYM TVS_EDITLABELS}
  TVS_EDITLABELS          = $0008;
  {$EXTERNALSYM TVS_DISABLEDRAGDROP}
  TVS_DISABLEDRAGDROP     = $0010;
  {$EXTERNALSYM TVS_SHOWSELALWAYS}
  TVS_SHOWSELALWAYS       = $0020;
  {$EXTERNALSYM TVS_RTLREADING}
  TVS_RTLREADING          = $0040;
  {$EXTERNALSYM TVS_NOTOOLTIPS}
  TVS_NOTOOLTIPS          = $0080;
  {$EXTERNALSYM TVS_CHECKBOXES}
  TVS_CHECKBOXES          = $0100;
  {$EXTERNALSYM TVS_TRACKSELECT}
  TVS_TRACKSELECT         = $0200;
  {$EXTERNALSYM TVS_SINGLEEXPAND}
  TVS_SINGLEEXPAND        = $0400;
  {$EXTERNALSYM TVS_INFOTIP}
  TVS_INFOTIP             = $0800;
  {$EXTERNALSYM TVS_FULLROWSELECT}
  TVS_FULLROWSELECT       = $1000;
  {$EXTERNALSYM TVS_NOSCROLL}
  TVS_NOSCROLL            = $2000;
  {$EXTERNALSYM TVS_NONEVENHEIGHT}
  TVS_NONEVENHEIGHT       = $4000;
  { For IE >= 0x0500 }
  {$EXTERNALSYM TVS_NOHSCROLL}
  TVS_NOHSCROLL           = $8000;  // TVS_NOSCROLL overrides this

  { For Windows >= Vista }
  {$EXTERNALSYM TVS_EX_MULTISELECT}
  TVS_EX_MULTISELECT          = $0002;
  {$EXTERNALSYM TVS_EX_DOUBLEBUFFER}
  TVS_EX_DOUBLEBUFFER         = $0004;
  {$EXTERNALSYM TVS_EX_NOINDENTSTATE}
  TVS_EX_NOINDENTSTATE        = $0008;
  {$EXTERNALSYM TVS_EX_RICHTOOLTIP}
  TVS_EX_RICHTOOLTIP          = $0010;
  {$EXTERNALSYM TVS_EX_AUTOHSCROLL}
  TVS_EX_AUTOHSCROLL          = $0020;
  {$EXTERNALSYM TVS_EX_FADEINOUTEXPANDOS}
  TVS_EX_FADEINOUTEXPANDOS    = $0040;
  {$EXTERNALSYM TVS_EX_PARTIALCHECKBOXES}
  TVS_EX_PARTIALCHECKBOXES    = $0080;
  {$EXTERNALSYM TVS_EX_EXCLUSIONCHECKBOXES}
  TVS_EX_EXCLUSIONCHECKBOXES  = $0100;
  {$EXTERNALSYM TVS_EX_DIMMEDCHECKBOXES}
  TVS_EX_DIMMEDCHECKBOXES     = $0200;
  {$EXTERNALSYM TVS_EX_DRAWIMAGEASYNC}
  TVS_EX_DRAWIMAGEASYNC       = $0400;

type
  {$EXTERNALSYM HTREEITEM}
  HTREEITEM = ^_TREEITEM;
  {$EXTERNALSYM _TREEITEM}
  _TREEITEM = record
  end;

const
  {$EXTERNALSYM TVIF_TEXT}
  TVIF_TEXT               = $0001;
  {$EXTERNALSYM TVIF_IMAGE}
  TVIF_IMAGE              = $0002;
  {$EXTERNALSYM TVIF_PARAM}
  TVIF_PARAM              = $0004;
  {$EXTERNALSYM TVIF_STATE}
  TVIF_STATE              = $0008;
  {$EXTERNALSYM TVIF_HANDLE}
  TVIF_HANDLE             = $0010;
  {$EXTERNALSYM TVIF_SELECTEDIMAGE}
  TVIF_SELECTEDIMAGE      = $0020;
  {$EXTERNALSYM TVIF_CHILDREN}
  TVIF_CHILDREN           = $0040;
  {$EXTERNALSYM TVIF_INTEGRAL}
  TVIF_INTEGRAL           = $0080;
  { For Windows >= Vista }
  {$EXTERNALSYM TVIF_STATEEX}
  TVIF_STATEEX            = $0100;
  {$EXTERNALSYM TVIF_EXPANDEDIMAGE}
  TVIF_EXPANDEDIMAGE      = $0200;

  {$EXTERNALSYM TVIS_FOCUSED}
  TVIS_FOCUSED            = $0001;
  {$EXTERNALSYM TVIS_SELECTED}
  TVIS_SELECTED           = $0002;
  {$EXTERNALSYM TVIS_CUT}
  TVIS_CUT                = $0004;
  {$EXTERNALSYM TVIS_DROPHILITED}
  TVIS_DROPHILITED        = $0008;
  {$EXTERNALSYM TVIS_BOLD}
  TVIS_BOLD               = $0010;
  {$EXTERNALSYM TVIS_EXPANDED}
  TVIS_EXPANDED           = $0020;
  {$EXTERNALSYM TVIS_EXPANDEDONCE}
  TVIS_EXPANDEDONCE       = $0040;
  {$EXTERNALSYM TVIS_EXPANDPARTIAL}
  TVIS_EXPANDPARTIAL      = $0080;

  {$EXTERNALSYM TVIS_OVERLAYMASK}
  TVIS_OVERLAYMASK        = $0F00;
  {$EXTERNALSYM TVIS_STATEIMAGEMASK}
  TVIS_STATEIMAGEMASK     = $F000;
  {$EXTERNALSYM TVIS_USERMASK}
  TVIS_USERMASK           = $F000;

  { For IE >= 0x0600 }
  {$EXTERNALSYM TVIS_EX_FLAT}
  TVIS_EX_FLAT            = $0001;
  {$EXTERNALSYM TVIS_EX_ALL}
  TVIS_EX_ALL             = $0002;
  { For Windows >= Vista }
  {$EXTERNALSYM TVIS_EX_DISABLED}
  TVIS_EX_DISABLED        = $0002;

// Structure for TreeView's NM_TVSTATEIMAGECHANGING notification
type
  { For IE >= 0x0600 }
  { $EXTERNALSYM tagNMTVSTATEIMAGECHANGING}
  tagNMTVSTATEIMAGECHANGING = record
    hdr: NMHDR;
    hti: HTREEITEM;
    iOldStateImageIndex: Integer;
    iNewStateImageIndex: Integer;
  end;
  PNMTVStateImageChanging = ^TNMTVStateImageChanging;
  TNMTVStateImageChanging = tagNMTVSTATEIMAGECHANGING;

const
  {$EXTERNALSYM I_CHILDRENCALLBACK}
  I_CHILDRENCALLBACK  = -1;

type
  PTVItemA = ^TTVItemA;
  PTVItemW = ^TTVItemW;
  PTVItem = PTVItemW;
  {$EXTERNALSYM tagTVITEMA}
  tagTVITEMA = record
    mask: UINT;
    hItem: HTreeItem;
    state: UINT;
    stateMask: UINT;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    cChildren: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagTVITEMW}
  tagTVITEMW = record
    mask: UINT;
    hItem: HTreeItem;
    state: UINT;
    stateMask: UINT;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    cChildren: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagTVITEM}
  tagTVITEM = tagTVITEMW;
  {$EXTERNALSYM _TV_ITEMA}
  _TV_ITEMA = tagTVITEMA;
  {$EXTERNALSYM _TV_ITEMW}
  _TV_ITEMW = tagTVITEMW;
  {$EXTERNALSYM _TV_ITEM}
  _TV_ITEM = _TV_ITEMW;
  TTVItemA = tagTVITEMA;
  TTVItemW = tagTVITEMW;
  TTVItem = TTVItemW;
  {$EXTERNALSYM TV_ITEMA}
  TV_ITEMA = tagTVITEMA;
  {$EXTERNALSYM TV_ITEMW}
  TV_ITEMW = tagTVITEMW;
  {$EXTERNALSYM TV_ITEM}
  TV_ITEM = TV_ITEMW;

  // only used for Get and Set messages.  no notifies
  {$EXTERNALSYM tagTVITEMEXA}
  tagTVITEMEXA = record
    mask: UINT;
    hItem: HTREEITEM;
    state: UINT;
    stateMask: UINT;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    cChildren: Integer;
    lParam: LPARAM;
    iIntegral: Integer;
                                   
    uStateEx: UINT;
    hwnd: HWND;
    iExpandedImage: Integer;
    
    
    iReserved: Integer;
    
  end;
  {$EXTERNALSYM tagTVITEMEXW}
  tagTVITEMEXW = record
    mask: UINT;
    hItem: HTREEITEM;
    state: UINT;
    stateMask: UINT;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    cChildren: Integer;
    lParam: LPARAM;
    iIntegral: Integer;
                                   
    uStateEx: UINT;
    hwnd: HWND;
    iExpandedImage: Integer;
    
    
    iReserved: Integer;
    
  end;
  {$EXTERNALSYM tagTVITEMEX}
  tagTVITEMEX = tagTVITEMEXW;
  PTVItemExA = ^TTVItemExA;
  PTVItemExW = ^TTVItemExW;
  PTVItemEx = PTVItemExW;
  TTVItemExA = tagTVITEMEXA;
  TTVItemExW = tagTVITEMEXW;
  TTVItemEx = TTVItemExW;

const
  {$EXTERNALSYM TVI_ROOT}
  TVI_ROOT                = HTreeItem(ULONG_PTR(-$10000));
  {$EXTERNALSYM TVI_FIRST}
  TVI_FIRST               = HTreeItem(ULONG_PTR(-$0FFFF));
  {$EXTERNALSYM TVI_LAST}
  TVI_LAST                = HTreeItem(ULONG_PTR(-$0FFFE));
  {$EXTERNALSYM TVI_SORT}
  TVI_SORT                = HTreeItem(ULONG_PTR(-$0FFFD));

type
  PTVInsertStructA = ^TTVInsertStructA;
  PTVInsertStructW = ^TTVInsertStructW;
  PTVInsertStruct = PTVInsertStructW;
  {$EXTERNALSYM tagTVINSERTSTRUCTA}
  tagTVINSERTSTRUCTA = record
    hParent: HTreeItem;
    hInsertAfter: HTreeItem;
    case Integer of
      0: (itemex: TTVItemExA);
      1: (item: TTVItemA);
  end;
  {$EXTERNALSYM tagTVINSERTSTRUCTW}
  tagTVINSERTSTRUCTW = record
    hParent: HTreeItem;
    hInsertAfter: HTreeItem;
    case Integer of
      0: (itemex: TTVItemExW);
      1: (item: TTVItemW);
  end;
  {$EXTERNALSYM tagTVINSERTSTRUCT}
  tagTVINSERTSTRUCT = tagTVINSERTSTRUCTW;
  {$EXTERNALSYM _TV_INSERTSTRUCTA}
  _TV_INSERTSTRUCTA = tagTVINSERTSTRUCTA;
  {$EXTERNALSYM _TV_INSERTSTRUCTW}
  _TV_INSERTSTRUCTW = tagTVINSERTSTRUCTW;
  {$EXTERNALSYM _TV_INSERTSTRUCT}
  _TV_INSERTSTRUCT = _TV_INSERTSTRUCTW;
  TTVInsertStructA = tagTVINSERTSTRUCTA;
  TTVInsertStructW = tagTVINSERTSTRUCTW;
  TTVInsertStruct = TTVInsertStructW;
  {$EXTERNALSYM TV_INSERTSTRUCTA}
  TV_INSERTSTRUCTA = tagTVINSERTSTRUCTA;
  {$EXTERNALSYM TV_INSERTSTRUCTW}
  TV_INSERTSTRUCTW = tagTVINSERTSTRUCTW;
  {$EXTERNALSYM TV_INSERTSTRUCT}
  TV_INSERTSTRUCT = TV_INSERTSTRUCTW;

const
  {$EXTERNALSYM TVM_INSERTITEMA}
  TVM_INSERTITEMA          = TV_FIRST + 0;
  {$EXTERNALSYM TVM_INSERTITEMW}
  TVM_INSERTITEMW          = TV_FIRST + 50;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVM_INSERTITEM}
  TVM_INSERTITEM          = TVM_INSERTITEMW;
{$ELSE}
  {$EXTERNALSYM TVM_INSERTITEM}
  TVM_INSERTITEM          = TVM_INSERTITEMA;
{$ENDIF}

{$EXTERNALSYM TreeView_InsertItem}
function TreeView_InsertItem(hwnd: HWND; const lpis: TTVInsertStruct): HTreeItem; inline;
function TreeView_InsertItemA(hwnd: HWND; const lpis: TTVInsertStructA): HTreeItem; inline;
function TreeView_InsertItemW(hwnd: HWND; const lpis: TTVInsertStructW): HTreeItem; inline;

const
  {$EXTERNALSYM TVM_DELETEITEM}
  TVM_DELETEITEM          = TV_FIRST + 1;

{$EXTERNALSYM TreeView_DeleteItem}
function TreeView_DeleteItem(hwnd: HWND; hitem: HTreeItem): Bool; inline;

{$EXTERNALSYM TreeView_DeleteAllItems}
function TreeView_DeleteAllItems(hwnd: HWND): Bool; inline;

const
  {$EXTERNALSYM TVM_EXPAND}
  TVM_EXPAND              = TV_FIRST + 2;

{$EXTERNALSYM TreeView_Expand}
function TreeView_Expand(hwnd: HWND; hitem: HTreeItem; code: Integer): Bool; inline;

const
  {$EXTERNALSYM TVE_COLLAPSE}
  TVE_COLLAPSE            = $0001;
  {$EXTERNALSYM TVE_EXPAND}
  TVE_EXPAND              = $0002;
  {$EXTERNALSYM TVE_TOGGLE}
  TVE_TOGGLE              = $0003;
  {$EXTERNALSYM TVE_EXPANDPARTIAL}
  TVE_EXPANDPARTIAL       = $4000;
  {$EXTERNALSYM TVE_COLLAPSERESET}
  TVE_COLLAPSERESET       = $8000;

const
  {$EXTERNALSYM TVM_GETITEMRECT}
  TVM_GETITEMRECT         = TV_FIRST + 4;

{$EXTERNALSYM TreeView_GetItemRect}
function TreeView_GetItemRect(hwnd: HWND; hitem: HTreeItem;
  var prc: TRect; code: Bool): Bool;

const
  {$EXTERNALSYM TVM_GETCOUNT}
  TVM_GETCOUNT            = TV_FIRST + 5;

{$EXTERNALSYM TreeView_GetCount}
function TreeView_GetCount(hwnd: HWND): UINT; inline;

const
  {$EXTERNALSYM TVM_GETINDENT}
  TVM_GETINDENT           = TV_FIRST + 6;

{$EXTERNALSYM TreeView_GetIndent}
function TreeView_GetIndent(hwnd: HWND): UINT; inline;

const
  {$EXTERNALSYM TVM_SETINDENT}
  TVM_SETINDENT           = TV_FIRST + 7;

{$EXTERNALSYM TreeView_SetIndent}
function TreeView_SetIndent(hwnd: HWND; indent: Integer): Bool; inline;

const
  {$EXTERNALSYM TVM_GETIMAGELIST}
  TVM_GETIMAGELIST        = TV_FIRST + 8;

{$EXTERNALSYM TreeView_GetImageList}
function TreeView_GetImageList(hwnd: HWND; iImage: Integer): HIMAGELIST; inline;

const
  {$EXTERNALSYM TVSIL_NORMAL}
  TVSIL_NORMAL            = 0;
  {$EXTERNALSYM TVSIL_STATE}
  TVSIL_STATE             = 2;


const
  {$EXTERNALSYM TVM_SETIMAGELIST}
  TVM_SETIMAGELIST        = TV_FIRST + 9;

{$EXTERNALSYM TreeView_SetImageList}
function TreeView_SetImageList(hwnd: HWND; himl: HIMAGELIST;
  iImage: Integer): HIMAGELIST; inline;

const
  {$EXTERNALSYM TVM_GETNEXTITEM}
  TVM_GETNEXTITEM         = TV_FIRST + 10;

{$EXTERNALSYM TreeView_GetNextItem}
function TreeView_GetNextItem(hwnd: HWND; hitem: HTreeItem;
  code: Integer): HTreeItem; inline;

const
  {$EXTERNALSYM TVGN_ROOT}
  TVGN_ROOT               = $0000;
  {$EXTERNALSYM TVGN_NEXT}
  TVGN_NEXT               = $0001;
  {$EXTERNALSYM TVGN_PREVIOUS}
  TVGN_PREVIOUS           = $0002;
  {$EXTERNALSYM TVGN_PARENT}
  TVGN_PARENT             = $0003;
  {$EXTERNALSYM TVGN_CHILD}
  TVGN_CHILD              = $0004;
  {$EXTERNALSYM TVGN_FIRSTVISIBLE}
  TVGN_FIRSTVISIBLE       = $0005;
  {$EXTERNALSYM TVGN_NEXTVISIBLE}
  TVGN_NEXTVISIBLE        = $0006;
  {$EXTERNALSYM TVGN_PREVIOUSVISIBLE}
  TVGN_PREVIOUSVISIBLE    = $0007;
  {$EXTERNALSYM TVGN_DROPHILITE}
  TVGN_DROPHILITE         = $0008;
  {$EXTERNALSYM TVGN_CARET}
  TVGN_CARET              = $0009;
  {$EXTERNALSYM TVGN_LASTVISIBLE}
  TVGN_LASTVISIBLE        = $000A;
  { For IE >= 0x0600 }
  {$EXTERNALSYM TVGN_NEXTSELECTED}
  TVGN_NEXTSELECTED       = $000B;

  { For Windows >= XP }
  {$EXTERNALSYM TVSI_NOSINGLEEXPAND}
  TVSI_NOSINGLEEXPAND     = $8000; // Should not conflict with TVGN flags.

{$EXTERNALSYM TreeView_GetChild}
function TreeView_GetChild(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetNextSibling}
function TreeView_GetNextSibling(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetPrevSibling}
function TreeView_GetPrevSibling(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetParent}
function TreeView_GetParent(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetFirstVisible}
function TreeView_GetFirstVisible(hwnd: HWND): HTreeItem;
{$EXTERNALSYM TreeView_GetNextVisible}
function TreeView_GetNextVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetPrevVisible}
function TreeView_GetPrevVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_GetSelection}
function TreeView_GetSelection(hwnd: HWND): HTreeItem;
{$EXTERNALSYM TreeView_GetDropHilite}
function TreeView_GetDropHilite(hwnd: HWND): HTreeItem;
{$EXTERNALSYM TreeView_GetRoot}
function TreeView_GetRoot(hwnd: HWND): HTreeItem;
{$EXTERNALSYM TreeView_GetLastVisible}
function TreeView_GetLastVisible(hwnd: HWND): HTreeItem;
{ For Windows >= Vista }
{$EXTERNALSYM TreeView_GetNextSelected}
function TreeView_GetNextSelected(hwnd: HWND; hitem: HTreeItem): HTreeItem; inline;

const
  {$EXTERNALSYM TVM_SELECTITEM}
  TVM_SELECTITEM          = TV_FIRST + 11;

{$EXTERNALSYM TreeView_Select}
function TreeView_Select(hwnd: HWND; hitem: HTreeItem;
  code: Integer): HTreeItem; inline;

{$EXTERNALSYM TreeView_SelectItem}
function TreeView_SelectItem(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_SelectDropTarget}
function TreeView_SelectDropTarget(hwnd: HWND; hitem: HTreeItem): HTreeItem;
{$EXTERNALSYM TreeView_SelectSetFirstVisible}
function TreeView_SelectSetFirstVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;

const
  {$EXTERNALSYM TVM_GETITEMA}
  TVM_GETITEMA             = TV_FIRST + 12;
  {$EXTERNALSYM TVM_GETITEMW}
  TVM_GETITEMW             = TV_FIRST + 62;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVM_GETITEM}
  TVM_GETITEM             = TVM_GETITEMW;
{$ELSE}
  {$EXTERNALSYM TVM_GETITEM}
  TVM_GETITEM             = TVM_GETITEMA;
{$ENDIF}

{$EXTERNALSYM TreeView_GetItem}
function TreeView_GetItem(hwnd: HWND; var pitem: TTVItem): Bool; inline;
{$EXTERNALSYM TreeView_GetItemA}
function TreeView_GetItemA(hwnd: HWND; var pitem: TTVItemA): Bool; inline;
{$EXTERNALSYM TreeView_GetItemW}
function TreeView_GetItemW(hwnd: HWND; var pitem: TTVItemW): Bool; inline;

const
  {$EXTERNALSYM TVM_SETITEMA}
  TVM_SETITEMA             = TV_FIRST + 13;
  {$EXTERNALSYM TVM_SETITEMW}
  TVM_SETITEMW             = TV_FIRST + 63;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVM_SETITEM}
  TVM_SETITEM             = TVM_SETITEMW;
{$ELSE}
  {$EXTERNALSYM TVM_SETITEM}
  TVM_SETITEM             = TVM_SETITEMA;
{$ENDIF}

{$EXTERNALSYM TreeView_SetItem}
function TreeView_SetItem(hwnd: HWND; const pitem: TTVItem): Bool; inline; overload;
function TreeView_SetItem(hwnd: HWND; const pitem: TTVItemEx): Bool; inline; overload;
{$EXTERNALSYM TreeView_SetItemA}
function TreeView_SetItemA(hwnd: HWND; const pitem: TTVItemA): Bool; inline; overload;
function TreeView_SetItemA(hwnd: HWND; const pitem: TTVItemExA): Bool; inline; overload;
{$EXTERNALSYM TreeView_SetItemW}
function TreeView_SetItemW(hwnd: HWND; const pitem: TTVItemW): Bool; inline; overload;
function TreeView_SetItemW(hwnd: HWND; const pitem: TTVItemExW): Bool; inline; overload;

const
  {$EXTERNALSYM TVM_EDITLABELA}
  TVM_EDITLABELA           = TV_FIRST + 14;
  {$EXTERNALSYM TVM_EDITLABELW}
  TVM_EDITLABELW           = TV_FIRST + 65;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVM_EDITLABEL}
  TVM_EDITLABEL           = TVM_EDITLABELW;
{$ELSE}
  {$EXTERNALSYM TVM_EDITLABEL}
  TVM_EDITLABEL           = TVM_EDITLABELA;
{$ENDIF}

{$EXTERNALSYM TreeView_EditLabel}
function TreeView_EditLabel(hwnd: HWND; hitem: HTreeItem): HWND; inline;
{$EXTERNALSYM TreeView_EditLabelA}
function TreeView_EditLabelA(hwnd: HWND; hitem: HTreeItem): HWND; inline;
{$EXTERNALSYM TreeView_EditLabelW}
function TreeView_EditLabelW(hwnd: HWND; hitem: HTreeItem): HWND; inline;

const
  {$EXTERNALSYM TVM_GETEDITCONTROL}
  TVM_GETEDITCONTROL      = TV_FIRST + 15;

{$EXTERNALSYM TreeView_GetEditControl}
function TreeView_GetEditControl(hwnd: HWND): HWND; inline;


const
  {$EXTERNALSYM TVM_GETVISIBLECOUNT}
  TVM_GETVISIBLECOUNT     = TV_FIRST + 16;

{$EXTERNALSYM TreeView_GetVisibleCount}
function TreeView_GetVisibleCount(hwnd: HWND): UINT; inline;

const
  {$EXTERNALSYM TVM_HITTEST}
  TVM_HITTEST             = TV_FIRST + 17;

type
  PTVHitTestInfo = ^TTVHitTestInfo;
  {$EXTERNALSYM tagTVHITTESTINFO}
  tagTVHITTESTINFO = record
    pt: TPoint;
    flags: UINT;
    hItem: HTreeItem;
  end;
  {$EXTERNALSYM _TV_HITTESTINFO}
  _TV_HITTESTINFO = tagTVHITTESTINFO;
  TTVHitTestInfo = tagTVHITTESTINFO;
  {$EXTERNALSYM TV_HITTESTINFO}
  TV_HITTESTINFO = tagTVHITTESTINFO;

{$EXTERNALSYM TreeView_HitTest}
function TreeView_HitTest(hwnd: HWND; var lpht: TTVHitTestInfo): HTreeItem; inline;

const
  {$EXTERNALSYM TVHT_NOWHERE}
  TVHT_NOWHERE            = $0001;
  {$EXTERNALSYM TVHT_ONITEMICON}
  TVHT_ONITEMICON         = $0002;
  {$EXTERNALSYM TVHT_ONITEMLABEL}
  TVHT_ONITEMLABEL        = $0004;
  {$EXTERNALSYM TVHT_ONITEMINDENT}
  TVHT_ONITEMINDENT       = $0008;
  {$EXTERNALSYM TVHT_ONITEMBUTTON}
  TVHT_ONITEMBUTTON       = $0010;
  {$EXTERNALSYM TVHT_ONITEMRIGHT}
  TVHT_ONITEMRIGHT        = $0020;
  {$EXTERNALSYM TVHT_ONITEMSTATEICON}
  TVHT_ONITEMSTATEICON    = $0040;

  {$EXTERNALSYM TVHT_ONITEM}
  TVHT_ONITEM             = TVHT_ONITEMICON or TVHT_ONITEMLABEL or
			      TVHT_ONITEMSTATEICON;

  {$EXTERNALSYM TVHT_ABOVE}
  TVHT_ABOVE              = $0100;
  {$EXTERNALSYM TVHT_BELOW}
  TVHT_BELOW              = $0200;
  {$EXTERNALSYM TVHT_TORIGHT}
  TVHT_TORIGHT            = $0400;
  {$EXTERNALSYM TVHT_TOLEFT}
  TVHT_TOLEFT             = $0800;

const
  {$EXTERNALSYM TVM_CREATEDRAGIMAGE}
  TVM_CREATEDRAGIMAGE     = TV_FIRST + 18;

{$EXTERNALSYM TreeView_CreateDragImage}
function TreeView_CreateDragImage(hwnd: HWND; hitem: HTreeItem): HIMAGELIST; inline;

const
  {$EXTERNALSYM TVM_SORTCHILDREN}
  TVM_SORTCHILDREN        = TV_FIRST + 19;

{$EXTERNALSYM TreeView_SortChildren}
function TreeView_SortChildren(hwnd: HWND; hitem: HTreeItem; recurse: Bool): Bool; inline;

const
  {$EXTERNALSYM TVM_ENSUREVISIBLE}
  TVM_ENSUREVISIBLE       = TV_FIRST + 20;

{$EXTERNALSYM TreeView_EnsureVisible}
function TreeView_EnsureVisible(hwnd: HWND; hitem: HTreeItem): Bool; inline;

const
  {$EXTERNALSYM TVM_SORTCHILDRENCB}
  TVM_SORTCHILDRENCB      = TV_FIRST + 21;

type
  {$EXTERNALSYM PFNTVCOMPARE}
  PFNTVCOMPARE = function(lParam1, lParam2, lParamSort: LPARAM): Integer stdcall;
  TTVCompare = PFNTVCOMPARE;

type
  {$EXTERNALSYM tagTVSORTCB}
  tagTVSORTCB = record
    hParent: HTreeItem;
    lpfnCompare: TTVCompare;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM _TV_SORTCB}
  _TV_SORTCB = tagTVSORTCB;
  TTVSortCB = tagTVSORTCB;
  {$EXTERNALSYM TV_SORTCB}
  TV_SORTCB = tagTVSORTCB;

{$EXTERNALSYM TreeView_SortChildrenCB}
function TreeView_SortChildrenCB(hwnd: HWND; const psort: TTVSortCB;
  recurse: Integer): Bool; inline;

const
  {$EXTERNALSYM TVM_ENDEDITLABELNOW}
  TVM_ENDEDITLABELNOW     = TV_FIRST + 22;

{$EXTERNALSYM TreeView_EndEditLabelNow}
function TreeView_EndEditLabelNow(hwnd: HWND; fCancel: Bool): Bool; inline;

const
  {$EXTERNALSYM TVM_GETISEARCHSTRINGA}
  TVM_GETISEARCHSTRINGA    = TV_FIRST + 23;
  {$EXTERNALSYM TVM_GETISEARCHSTRINGW}
  TVM_GETISEARCHSTRINGW    = TV_FIRST + 64;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVM_GETISEARCHSTRING}
  TVM_GETISEARCHSTRING    = TVM_GETISEARCHSTRINGW;
{$ELSE}
  {$EXTERNALSYM TVM_GETISEARCHSTRING}
  TVM_GETISEARCHSTRING    = TVM_GETISEARCHSTRINGA;
{$ENDIF}

{$EXTERNALSYM TreeView_GetISearchString}
function TreeView_GetISearchString(hwndTV: HWND; lpsz: LPWSTR): Bool; inline;
{$EXTERNALSYM TreeView_GetISearchStringA}
function TreeView_GetISearchStringA(hwndTV: HWND; lpsz: LPSTR): Bool; inline;
{$EXTERNALSYM TreeView_GetISearchStringW}
function TreeView_GetISearchStringW(hwndTV: HWND; lpsz: LPWSTR): Bool; inline;

const
  {$EXTERNALSYM TVM_SETTOOLTIPS}
  TVM_SETTOOLTIPS         = TV_FIRST + 24;

{$EXTERNALSYM TreeView_SetToolTips}
function TreeView_SetToolTips(wnd: HWND; hwndTT: HWND): HWND; inline;

const
  {$EXTERNALSYM TVM_GETTOOLTIPS}
  TVM_GETTOOLTIPS         = TV_FIRST + 25;

{$EXTERNALSYM TreeView_GetToolTips}
function TreeView_GetToolTips(wnd: HWND): HWND; inline;

const
  {$EXTERNALSYM TVM_SETINSERTMARK}
  TVM_SETINSERTMARK       = TV_FIRST + 26;

{$EXTERNALSYM TreeView_SetInsertMark}
function TreeView_SetInsertMark(hwnd: HWND; hItem: Integer; fAfter: BOOL): BOOL; inline;

const
  {$EXTERNALSYM TVM_SETUNICODEFORMAT}
  TVM_SETUNICODEFORMAT     = CCM_SETUNICODEFORMAT;

{$EXTERNALSYM TreeView_SetUnicodeFormat}
function TreeView_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL; inline;

const
  {$EXTERNALSYM TVM_GETUNICODEFORMAT}
  TVM_GETUNICODEFORMAT     = CCM_GETUNICODEFORMAT;

{$EXTERNALSYM TreeView_GetUnicodeFormat}
function TreeView_GetUnicodeFormat(hwnd: HWND): BOOL; inline;

const
  {$EXTERNALSYM TVM_SETITEMHEIGHT}
  TVM_SETITEMHEIGHT         = TV_FIRST + 27;

{$EXTERNALSYM TreeView_SetItemHeight}
function TreeView_SetItemHeight(hwnd: HWND; iHeight: Integer): Integer; inline;

const
  {$EXTERNALSYM TVM_GETITEMHEIGHT}
  TVM_GETITEMHEIGHT         = TV_FIRST + 28;

{$EXTERNALSYM TreeView_GetItemHeight}
function TreeView_GetItemHeight(hwnd: HWND): Integer; inline;

const
  {$EXTERNALSYM TVM_SETBKCOLOR}
  TVM_SETBKCOLOR              = TV_FIRST + 29;

{$EXTERNALSYM TreeView_SetBkColor}
function TreeView_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF; inline;

const
  {$EXTERNALSYM TVM_SETTEXTCOLOR}
  TVM_SETTEXTCOLOR              = TV_FIRST + 30;

{$EXTERNALSYM TreeView_SetTextColor}
function TreeView_SetTextColor(hwnd: HWND; clr: COLORREF): COLORREF; inline;

const
  {$EXTERNALSYM TVM_GETBKCOLOR}
  TVM_GETBKCOLOR              = TV_FIRST + 31;

{$EXTERNALSYM TreeView_GetBkColor}
function TreeView_GetBkColor(hwnd: HWND): COLORREF; inline;

const
  {$EXTERNALSYM TVM_GETTEXTCOLOR}
  TVM_GETTEXTCOLOR              = TV_FIRST + 32;

{$EXTERNALSYM TreeView_GetTextColor}
function TreeView_GetTextColor(hwnd: HWND): COLORREF; inline;

const
  {$EXTERNALSYM TVM_SETSCROLLTIME}
  TVM_SETSCROLLTIME              = TV_FIRST + 33;

{$EXTERNALSYM TreeView_SetScrollTime}
function TreeView_SetScrollTime(hwnd: HWND; uTime: UINT): UINT; inline;

const
  {$EXTERNALSYM TVM_GETSCROLLTIME}
  TVM_GETSCROLLTIME              = TV_FIRST + 34;

{$EXTERNALSYM TreeView_GetScrollTime}
function TreeView_GetScrollTime(hwnd: HWND): UINT; inline;

const
  {$EXTERNALSYM TVM_SETINSERTMARKCOLOR}
  TVM_SETINSERTMARKCOLOR         = TV_FIRST + 37;

{$EXTERNALSYM TreeView_SetInsertMarkColor}
function TreeView_SetInsertMarkColor(hwnd: HWND; clr: COLORREF): COLORREF; inline;

const
  {$EXTERNALSYM TVM_GETINSERTMARKCOLOR}
  TVM_GETINSERTMARKCOLOR         = TV_FIRST + 38;

{$EXTERNALSYM TreeView_GetInsertMarkColor}
function TreeView_GetInsertMarkColor(hwnd: HWND): COLORREF; inline;

{ For IE >= 0x0500 }
// tvm_?etitemstate only uses mask, state and stateMask.
// so unicode or ansi is irrelevant.
{$EXTERNALSYM TreeView_SetItemState}
function TreeView_SetItemState(hwndTV: HWND; hti: HTreeItem; State, Mask: UINT): UINT;
{$EXTERNALSYM TreeView_SetCheckState}
function TreeView_SetCheckState(hwndTV: HWND; hti: HTreeItem; fCheck: BOOL): UINT; inline;

const
  { For IE >= 0x0500 }
  {$EXTERNALSYM TVM_GETITEMSTATE}
  TVM_GETITEMSTATE        = TV_FIRST + 39;

{ For IE >= 0x0500 }
{$EXTERNALSYM TreeView_GetItemState}
function TreeView_GetItemState(hwndTV: HWND; hti: HTreeItem; mask: UINT): UINT; inline;
{$EXTERNALSYM TreeView_GetCheckState}
function TreeView_GetCheckState(hwndTV: HWND; hti: HTreeItem): UINT; inline;

const
  { For IE >= 0x0500 }
  {$EXTERNALSYM TVM_SETLINECOLOR}
  TVM_SETLINECOLOR            = TV_FIRST + 40;
  {$EXTERNALSYM TVM_GETLINECOLOR}
  TVM_GETLINECOLOR            = TV_FIRST + 41;

  { For Windows >= XP }
  {$EXTERNALSYM TVM_MAPACCIDTOHTREEITEM}
  TVM_MAPACCIDTOHTREEITEM     = TV_FIRST + 42;
  {$EXTERNALSYM TVM_MAPHTREEITEMTOACCID}
  TVM_MAPHTREEITEMTOACCID     = TV_FIRST + 43;
  {$EXTERNALSYM TVM_SETEXTENDEDSTYLE}
  TVM_SETEXTENDEDSTYLE        = TV_FIRST + 44;
  {$EXTERNALSYM TVM_GETEXTENDEDSTYLE}
  TVM_GETEXTENDEDSTYLE        = TV_FIRST + 45;
  {$EXTERNALSYM TVM_SETAUTOSCROLLINFO}
  TVM_SETAUTOSCROLLINFO       = TV_FIRST + 59;

  { For Windows >= Vista }
  {$EXTERNALSYM TVM_GETSELECTEDCOUNT}
  TVM_GETSELECTEDCOUNT        = TV_FIRST + 70;
  {$EXTERNALSYM TVM_SHOWINFOTIP}
  TVM_SHOWINFOTIP             = TV_FIRST + 71;

{ For IE >= 0x0500 }
{$EXTERNALSYM TreeView_SetLineColor}
function TreeView_SetLineColor(hwnd: HWND; clr: TColorRef): TColorRef; inline;
{$EXTERNALSYM TreeView_GetLineColor}
function TreeView_GetLineColor(hwnd: HWND): Integer; inline;

{ For Windows >= XP }
{$EXTERNALSYM TreeView_MapAccIDToHTREEITEM}
function TreeView_MapAccIDToHTREEITEM(hwnd: HWND; id: UINT): HTreeItem; inline;
{$EXTERNALSYM TreeView_MapHTREEITEMToAccID}
function TreeView_MapHTREEITEMToAccID(hwnd: HWND; hti: HTreeItem): UINT; inline;
{$EXTERNALSYM TreeView_SetExtendedStyle}
function TreeView_SetExtendedStyle(hwnd: HWND; dw: DWORD; mask: UINT): UINT; inline;
{$EXTERNALSYM TreeView_GetExtendedStyle}
function TreeView_GetExtendedStyle(hwnd: HWND): DWORD; inline;
{$EXTERNALSYM TreeView_SetAutoScrollInfo}
function TreeView_SetAutoScrollInfo(hwnd: HWND; uPixPerSec, uUpdateTime: UINT): LRESULT; inline;

{ For Windows >= Vista }
{$EXTERNALSYM TreeView_GetSelectedCount}
function TreeView_GetSelectedCount(hwnd: HWND): DWORD; inline;
{$EXTERNALSYM TreeView_ShowInfoTip}
function TreeView_ShowInfoTip(hwnd: HWND; hti: HTreeItem): DWORD; inline;

type
  { For Windows >= Vista }
  { $EXTERNALSYM TVITEMPART}
  TVITEMPART = (TVGIPR_BUTTON = $0001);
  TTVItemPart = TVITEMPART;

type
  { For Windows >= Vista }
  { $EXTERNALSYM tagTVGETITEMPARTRECTINFO}
  tagTVGETITEMPARTRECTINFO = record
    hti: HTREEITEM;
    prc: PRect;
    partID: TVITEMPART;
  end;
  PTVGetItemPartRectInfo = ^TTVGetItemPartRectInfo;
  TTVGetItemPartRectInfo = tagTVGETITEMPARTRECTINFO;

const
  { For Windows >= Vista }
  {$EXTERNALSYM TVM_GETITEMPARTRECT}
  TVM_GETITEMPARTRECT         = TV_FIRST + 72;

{$EXTERNALSYM TreeView_GetItemPartRect}
function TreeView_GetItemPartRect(hwnd: HWND; hitem: HTreeItem; var prc: TRect;
  partid: TTVItemPart): BOOL;

type
  PNMTreeViewA = ^TNMTreeViewA;
  PNMTreeViewW = ^TNMTreeViewW;
  PNMTreeView = PNMTreeViewW;
  {$EXTERNALSYM tagNMTREEVIEWA}
  tagNMTREEVIEWA = record
    hdr: TNMHDR;
    action: UINT;
    itemOld: TTVItemA;
    itemNew: TTVItemA;
    ptDrag: TPoint;
  end;
  {$EXTERNALSYM tagNMTREEVIEWW}
  tagNMTREEVIEWW = record
    hdr: TNMHDR;
    action: UINT;
    itemOld: TTVItemW;
    itemNew: TTVItemW;
    ptDrag: TPoint;
  end;
  {$EXTERNALSYM tagNMTREEVIEW}
  tagNMTREEVIEW = tagNMTREEVIEWW;
  {$EXTERNALSYM _NM_TREEVIEWA}
  _NM_TREEVIEWA = tagNMTREEVIEWA;
  {$EXTERNALSYM _NM_TREEVIEWW}
  _NM_TREEVIEWW = tagNMTREEVIEWW;
  {$EXTERNALSYM _NM_TREEVIEW}
  _NM_TREEVIEW = _NM_TREEVIEWW;
  TNMTreeViewA  = tagNMTREEVIEWA;
  TNMTreeViewW  = tagNMTREEVIEWW;
  TNMTreeView = TNMTreeViewW;
  {$EXTERNALSYM NM_TREEVIEWA}
  NM_TREEVIEWA  = tagNMTREEVIEWA;
  {$EXTERNALSYM NM_TREEVIEWW}
  NM_TREEVIEWW  = tagNMTREEVIEWW;
  {$EXTERNALSYM NM_TREEVIEW}
  NM_TREEVIEW = NM_TREEVIEWW;

const
  {$EXTERNALSYM TVN_SELCHANGINGA}
  TVN_SELCHANGINGA         = TVN_FIRST-1;
  {$EXTERNALSYM TVN_SELCHANGEDA}
  TVN_SELCHANGEDA          = TVN_FIRST-2;
  {$EXTERNALSYM TVN_SELCHANGINGW}
  TVN_SELCHANGINGW         = TVN_FIRST-50;
  {$EXTERNALSYM TVN_SELCHANGEDW}
  TVN_SELCHANGEDW          = TVN_FIRST-51;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVN_SELCHANGING}
  TVN_SELCHANGING         = TVN_SELCHANGINGW;
  {$EXTERNALSYM TVN_SELCHANGED}
  TVN_SELCHANGED          = TVN_SELCHANGEDW;
{$ELSE}
  {$EXTERNALSYM TVN_SELCHANGING}
  TVN_SELCHANGING         = TVN_SELCHANGINGA;
  {$EXTERNALSYM TVN_SELCHANGED}
  TVN_SELCHANGED          = TVN_SELCHANGEDA;
{$ENDIF}

const
  {$EXTERNALSYM TVC_UNKNOWN}
  TVC_UNKNOWN             = $0000;
  {$EXTERNALSYM TVC_BYMOUSE}
  TVC_BYMOUSE             = $0001;
  {$EXTERNALSYM TVC_BYKEYBOARD}
  TVC_BYKEYBOARD          = $0002;

const
  {$EXTERNALSYM TVN_GETDISPINFOA}
  TVN_GETDISPINFOA         = TVN_FIRST-3;
  {$EXTERNALSYM TVN_SETDISPINFOA}
  TVN_SETDISPINFOA         = TVN_FIRST-4;
  {$EXTERNALSYM TVN_GETDISPINFOW}
  TVN_GETDISPINFOW         = TVN_FIRST-52;
  {$EXTERNALSYM TVN_SETDISPINFOW}
  TVN_SETDISPINFOW         = TVN_FIRST-53;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVN_GETDISPINFO}
  TVN_GETDISPINFO         = TVN_GETDISPINFOW;
  {$EXTERNALSYM TVN_SETDISPINFO}
  TVN_SETDISPINFO         = TVN_SETDISPINFOW;
{$ELSE}
  {$EXTERNALSYM TVN_GETDISPINFO}
  TVN_GETDISPINFO         = TVN_GETDISPINFOA;
  {$EXTERNALSYM TVN_SETDISPINFO}
  TVN_SETDISPINFO         = TVN_SETDISPINFOA;
{$ENDIF}

  {$EXTERNALSYM TVIF_DI_SETITEM}
  TVIF_DI_SETITEM         = $1000;

type
  PTVDispInfoA = ^TTVDispInfoA;
  PTVDispInfoW = ^TTVDispInfoW;
  PTVDispInfo = PTVDispInfoW;
  {$EXTERNALSYM tagTVDISPINFOA}
  tagTVDISPINFOA = record
    hdr: TNMHDR;
    item: TTVItemA;
  end;
  {$EXTERNALSYM tagTVDISPINFOW}
  tagTVDISPINFOW = record
    hdr: TNMHDR;
    item: TTVItemW;
  end;
  {$EXTERNALSYM tagTVDISPINFO}
  tagTVDISPINFO = tagTVDISPINFOW;
  {$EXTERNALSYM _TV_DISPINFOA}
  _TV_DISPINFOA = tagTVDISPINFOA;
  {$EXTERNALSYM _TV_DISPINFOW}
  _TV_DISPINFOW = tagTVDISPINFOW;
  {$EXTERNALSYM _TV_DISPINFO}
  _TV_DISPINFO = _TV_DISPINFOW;
  TTVDispInfoA = tagTVDISPINFOA;
  TTVDispInfoW = tagTVDISPINFOW;
  TTVDispInfo = TTVDispInfoW;
  {$EXTERNALSYM TV_DISPINFOA}
  TV_DISPINFOA = tagTVDISPINFOA;
  {$EXTERNALSYM TV_DISPINFOW}
  TV_DISPINFOW = tagTVDISPINFOW;
  {$EXTERNALSYM TV_DISPINFO}
  TV_DISPINFO = TV_DISPINFOW;

type
  { For IE >= 0x0600 }
  PNMTVDispInfoExA = ^TNMTVDispInfoExA;
  PNMTVDispInfoExW = ^TNMTVDispInfoExW;
  PNMTVDispInfoEx = PNMTVDispInfoExW;
  tagTVDISPINFOEXA = record
    hdr: NMHDR;
    item: TTVItemExA;
  end;
  {$EXTERNALSYM tagTVDISPINFOEXA}
  tagTVDISPINFOEXW = record
    hdr: NMHDR;
    item: TTVItemExW;
  end;
  {$EXTERNALSYM tagTVDISPINFOEXW}
  tagTVDISPINFOEX = tagTVDISPINFOEXW;
  tagNMTVDISPINFOEXA = tagTVDISPINFOEXA deprecated 'Use tagTVDISPINFOEXA';
  tagNMTVDISPINFOEXW = tagTVDISPINFOEXW deprecated 'Use tagTVDISPINFOEXW';
  tagNMTVDISPINFOEX = tagTVDISPINFOEX deprecated 'Use tagTVDISPINFOEX';
  {$EXTERNALSYM TV_DISPINFOEXA}
  TV_DISPINFOEXA = tagTVDISPINFOEXA;
  {$EXTERNALSYM TV_DISPINFOEXW}
  TV_DISPINFOEXW = tagTVDISPINFOEXW;
  {$EXTERNALSYM TV_DISPINFOEX}
  TV_DISPINFOEX = TV_DISPINFOEXW;
  TNMTVDispInfoExA = tagTVDISPINFOEXA;
  TNMTVDispInfoExW = tagTVDISPINFOEXW;
  TNMTVDispInfoEx = TNMTVDispInfoExW;

const
  {$EXTERNALSYM TVN_ITEMEXPANDINGA}
  TVN_ITEMEXPANDINGA       = TVN_FIRST-5;
  {$EXTERNALSYM TVN_ITEMEXPANDEDA}
  TVN_ITEMEXPANDEDA        = TVN_FIRST-6;
  {$EXTERNALSYM TVN_BEGINDRAGA}
  TVN_BEGINDRAGA           = TVN_FIRST-7;
  {$EXTERNALSYM TVN_BEGINRDRAGA}
  TVN_BEGINRDRAGA          = TVN_FIRST-8;
  {$EXTERNALSYM TVN_DELETEITEMA}
  TVN_DELETEITEMA          = TVN_FIRST-9;
  {$EXTERNALSYM TVN_BEGINLABELEDITA}
  TVN_BEGINLABELEDITA      = TVN_FIRST-10;
  {$EXTERNALSYM TVN_ENDLABELEDITA}
  TVN_ENDLABELEDITA        = TVN_FIRST-11;
  {$EXTERNALSYM TVN_GETINFOTIPA}
  TVN_GETINFOTIPA          = TVN_FIRST-13;
  {$EXTERNALSYM TVN_ITEMEXPANDINGW}
  TVN_ITEMEXPANDINGW       = TVN_FIRST-54;
  {$EXTERNALSYM TVN_ITEMEXPANDEDW}
  TVN_ITEMEXPANDEDW        = TVN_FIRST-55;
  {$EXTERNALSYM TVN_BEGINDRAGW}
  TVN_BEGINDRAGW           = TVN_FIRST-56;
  {$EXTERNALSYM TVN_BEGINRDRAGW}
  TVN_BEGINRDRAGW          = TVN_FIRST-57;
  {$EXTERNALSYM TVN_DELETEITEMW}
  TVN_DELETEITEMW          = TVN_FIRST-58;
  {$EXTERNALSYM TVN_BEGINLABELEDITW}
  TVN_BEGINLABELEDITW      = TVN_FIRST-59;
  {$EXTERNALSYM TVN_ENDLABELEDITW}
  TVN_ENDLABELEDITW        = TVN_FIRST-60;
  {$EXTERNALSYM TVN_GETINFOTIPW}
  TVN_GETINFOTIPW          = TVN_FIRST-14;
{$IFDEF UNICODE}
  {$EXTERNALSYM TVN_ITEMEXPANDING}
  TVN_ITEMEXPANDING       = TVN_ITEMEXPANDINGW;
  {$EXTERNALSYM TVN_ITEMEXPANDED}
  TVN_ITEMEXPANDED        = TVN_ITEMEXPANDEDW;
  {$EXTERNALSYM TVN_BEGINDRAG}
  TVN_BEGINDRAG           = TVN_BEGINDRAGW;
  {$EXTERNALSYM TVN_BEGINRDRAG}
  TVN_BEGINRDRAG          = TVN_BEGINRDRAGW;
  {$EXTERNALSYM TVN_DELETEITEM}
  TVN_DELETEITEM          = TVN_DELETEITEMW;
  {$EXTERNALSYM TVN_BEGINLABELEDIT}
  TVN_BEGINLABELEDIT      = TVN_BEGINLABELEDITW;
  {$EXTERNALSYM TVN_ENDLABELEDIT}
  TVN_ENDLABELEDIT        = TVN_ENDLABELEDITW;
  {$EXTERNALSYM TVN_GETINFOTIP}
  TVN_GETINFOTIP         = TVN_GETINFOTIPW;
{$ELSE}
  {$EXTERNALSYM TVN_ITEMEXPANDING}
  TVN_ITEMEXPANDING       = TVN_ITEMEXPANDINGA;
  {$EXTERNALSYM TVN_ITEMEXPANDED}
  TVN_ITEMEXPANDED        = TVN_ITEMEXPANDEDA;
  {$EXTERNALSYM TVN_BEGINDRAG}
  TVN_BEGINDRAG           = TVN_BEGINDRAGA;
  {$EXTERNALSYM TVN_BEGINRDRAG}
  TVN_BEGINRDRAG          = TVN_BEGINRDRAGA;
  {$EXTERNALSYM TVN_DELETEITEM}
  TVN_DELETEITEM          = TVN_DELETEITEMA;
  {$EXTERNALSYM TVN_BEGINLABELEDIT}
  TVN_BEGINLABELEDIT      = TVN_BEGINLABELEDITA;
  {$EXTERNALSYM TVN_ENDLABELEDIT}
  TVN_ENDLABELEDIT        = TVN_ENDLABELEDITA;
  {$EXTERNALSYM TVN_GETINFOTIP}
  TVN_GETINFOTIP         = TVN_GETINFOTIPA;
{$ENDIF}

const
  {$EXTERNALSYM TVN_KEYDOWN}
  TVN_KEYDOWN             = TVN_FIRST-12;
  {$EXTERNALSYM TVN_SINGLEEXPAND}
  TVN_SINGLEEXPAND        = TVN_FIRST-15;

  {$EXTERNALSYM TVNRET_DEFAULT}
  TVNRET_DEFAULT          = 0;
  {$EXTERNALSYM TVNRET_SKIPOLD}
  TVNRET_SKIPOLD          = 1;
  {$EXTERNALSYM TVNRET_SKIPNEW}
  TVNRET_SKIPNEW          = 2;

  { For IE >= 0x0600 }
  {$EXTERNALSYM TVN_ITEMCHANGINGA}
  TVN_ITEMCHANGINGA       = TVN_FIRST-16;
  {$EXTERNALSYM TVN_ITEMCHANGINGW}
  TVN_ITEMCHANGINGW       = TVN_FIRST-17;
  {$EXTERNALSYM TVN_ITEMCHANGEDA}
  TVN_ITEMCHANGEDA        = TVN_FIRST-18;
  {$EXTERNALSYM TVN_ITEMCHANGEDW}
  TVN_ITEMCHANGEDW        = TVN_FIRST-19;
  {$EXTERNALSYM TVN_ASYNCDRAW}
  TVN_ASYNCDRAW           = TVN_FIRST-20;

{$IFDEF UNICODE}
  {$EXTERNALSYM TVN_ITEMCHANGING}
  TVN_ITEMCHANGING        = TVN_ITEMCHANGINGW;
  {$EXTERNALSYM TVN_ITEMCHANGED}
  TVN_ITEMCHANGED         = TVN_ITEMCHANGEDW;
{$ELSE}
  {$EXTERNALSYM TVN_ITEMCHANGING}
  TVN_ITEMCHANGING        = TVN_ITEMCHANGINGA;
  {$EXTERNALSYM TVN_ITEMCHANGED}
  TVN_ITEMCHANGED         = TVN_ITEMCHANGEDA;
{$ENDIF}

{$ALIGN 1}
type
  {$EXTERNALSYM tagTVKEYDOWN}
  tagTVKEYDOWN = record
    hdr: TNMHDR;
    wVKey: Word;
    flags: UINT;
  end;
  {$EXTERNALSYM _TV_KEYDOWN}
  _TV_KEYDOWN = tagTVKEYDOWN;
  TTVKeyDown = tagTVKEYDOWN;
  {$EXTERNALSYM TV_KEYDOWN}
  TV_KEYDOWN = tagTVKEYDOWN;
{$ALIGN ON}

  {$EXTERNALSYM tagNMTVCUSTOMDRAW}
  tagNMTVCUSTOMDRAW = record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iLevel: Integer;
  end;
  PNMTVCustomDraw = ^TNMTVCustomDraw;
  TNMTVCustomDraw = tagNMTVCUSTOMDRAW;

  // for tooltips
  {$EXTERNALSYM tagNMTVGETINFOTIPA}
  tagNMTVGETINFOTIPA = record
    hdr: TNMHdr;
    pszText: LPSTR;
    cchTextMax: Integer;
    hItem: HTREEITEM;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMTVGETINFOTIPW}
  tagNMTVGETINFOTIPW = record
    hdr: TNMHdr;
    pszText: LPWSTR;
    cchTextMax: Integer;
    hItem: HTREEITEM;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagNMTVGETINFOTIP}
  tagNMTVGETINFOTIP = tagNMTVGETINFOTIPW;
  PNMTVGetInfoTipA = ^TNMTVGetInfoTipA;
  PNMTVGetInfoTipW = ^TNMTVGetInfoTipW;
  PNMTVGetInfoTip = PNMTVGetInfoTipW;
  TNMTVGetInfoTipA = tagNMTVGETINFOTIPA;
  TNMTVGetInfoTipW = tagNMTVGETINFOTIPW;
  TNMTVGetInfoTip = TNMTVGetInfoTipW;

const
  // treeview's customdraw return meaning don't draw images.  valid on CDRF_NOTIFYITEMPREPAINT
  {$EXTERNALSYM TVCDRF_NOIMAGES}
  TVCDRF_NOIMAGES         = $00010000;

type
  { For IE >= 0x0600 }
  { $EXTERNALSYM tagNMTVITEMCHANGE}
  tagNMTVITEMCHANGE = record
    hdr: NMHDR;
    uChanged: UINT;
    hItem: HTREEITEM;
    uStateNew: UINT;
    uStateOld: UINT;
    lParam: LPARAM;
  end;
  PNMTVItemChange = ^TNMTVItemChange;
  TNMTVItemChange = tagNMTVITEMCHANGE;

  {$EXTERNALSYM tagNMTVASYNCDRAW}
  tagNMTVASYNCDRAW = record
    hdr: NMHDR;
    pimldp: PImageListDrawParams;  // the draw that failed
    hr: HRESULT;                   // why it failed
    hItem: HTREEITEM;              // item that failed to draw icon
    lParam: LPARAM;                // its data
    // Out Params
    dwRetFlags: DWORD;             // What listview should do on return
    iRetImageIndex: Integer;       // used if ADRF_DRAWIMAGE is returned
  end;
  PNMTVAsyncDraw = ^TNMTVAsyncDraw;
  TNMTVAsyncDraw = tagNMTVASYNCDRAW;

{ ====== ComboBoxEx ======================== }

const
  {$EXTERNALSYM WC_COMBOBOXEX}
  WC_COMBOBOXEX = 'ComboBoxEx32';

  {$EXTERNALSYM CBEIF_TEXT}
  CBEIF_TEXT              = $00000001;
  {$EXTERNALSYM CBEIF_IMAGE}
  CBEIF_IMAGE             = $00000002;
  {$EXTERNALSYM CBEIF_SELECTEDIMAGE}
  CBEIF_SELECTEDIMAGE     = $00000004;
  {$EXTERNALSYM CBEIF_OVERLAY}
  CBEIF_OVERLAY           = $00000008;
  {$EXTERNALSYM CBEIF_INDENT}
  CBEIF_INDENT            = $00000010;
  {$EXTERNALSYM CBEIF_LPARAM}
  CBEIF_LPARAM            = $00000020;

  {$EXTERNALSYM CBEIF_DI_SETITEM}
  CBEIF_DI_SETITEM        = $10000000;

type
  {$EXTERNALSYM tagCOMBOBOXEXITEMA}
  tagCOMBOBOXEXITEMA = record
    mask: UINT;
    iItem: IntPtr;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    iOverlay: Integer;
    iIndent: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagCOMBOBOXEXITEMW}
  tagCOMBOBOXEXITEMW = record
    mask: UINT;
    iItem: IntPtr;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    iSelectedImage: Integer;
    iOverlay: Integer;
    iIndent: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagCOMBOBOXEXITEM}
  tagCOMBOBOXEXITEM = tagCOMBOBOXEXITEMW;
  PComboBoxExItemA = ^TComboBoxExItemA;
  PComboBoxExItemW = ^TComboBoxExItemW;
  PComboBoxExItem = PComboBoxExItemW;
  TComboBoxExItemA = tagCOMBOBOXEXITEMA;
  TComboBoxExItemW = tagCOMBOBOXEXITEMW;
  TComboBoxExItem = TComboBoxExItemW;

const
  {$EXTERNALSYM CBEM_INSERTITEMA}
  CBEM_INSERTITEMA        = WM_USER + 1;
  {$EXTERNALSYM CBEM_SETIMAGELIST}
  CBEM_SETIMAGELIST       = WM_USER + 2;
  {$EXTERNALSYM CBEM_GETIMAGELIST}
  CBEM_GETIMAGELIST       = WM_USER + 3;
  {$EXTERNALSYM CBEM_GETITEMA}
  CBEM_GETITEMA           = WM_USER + 4;
  {$EXTERNALSYM CBEM_SETITEMA}
  CBEM_SETITEMA           = WM_USER + 5;
  {$EXTERNALSYM CBEM_DELETEITEM}
  CBEM_DELETEITEM         = CB_DELETESTRING;
  {$EXTERNALSYM CBEM_GETCOMBOCONTROL}
  CBEM_GETCOMBOCONTROL    = WM_USER + 6;
  {$EXTERNALSYM CBEM_GETEDITCONTROL}
  CBEM_GETEDITCONTROL     = WM_USER + 7;
  {$EXTERNALSYM CBEM_SETEXSTYLE}
  CBEM_SETEXSTYLE         = WM_USER + 8;  // use SETEXTENDEDSTYLE instead
  {$EXTERNALSYM CBEM_GETEXSTYLE}
  CBEM_GETEXSTYLE         = WM_USER + 9;  // use GETEXTENDEDSTYLE instead
  {$EXTERNALSYM CBEM_GETEXTENDEDSTYLE}
  CBEM_GETEXTENDEDSTYLE   = WM_USER + 9;
  {$EXTERNALSYM CBEM_HASEDITCHANGED}
  CBEM_HASEDITCHANGED     = WM_USER + 10;
  {$EXTERNALSYM CBEM_INSERTITEMW}
  CBEM_INSERTITEMW        = WM_USER + 11;
  {$EXTERNALSYM CBEM_SETITEMW}
  CBEM_SETITEMW           = WM_USER + 12;
  {$EXTERNALSYM CBEM_GETITEMW}
  CBEM_GETITEMW           = WM_USER + 13;
  {$EXTERNALSYM CBEM_SETEXTENDEDSTYLE}
  CBEM_SETEXTENDEDSTYLE   = WM_USER + 14; // lparam == new style, wParam (optional) == mask
  {$EXTERNALSYM CBEM_SETUNICODEFORMAT}
  CBEM_SETUNICODEFORMAT   = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM CBEM_GETUNICODEFORMAT}
  CBEM_GETUNICODEFORMAT   = CCM_GETUNICODEFORMAT;
  { For Windows >= XP }
  {$EXTERNALSYM CBEM_SETWINDOWTHEME}
  CBEM_SETWINDOWTHEME     = CCM_SETWINDOWTHEME;

{$IFDEF UNICODE}
  {$EXTERNALSYM CBEM_INSERTITEM}
  CBEM_INSERTITEM         = CBEM_INSERTITEMW;
  {$EXTERNALSYM CBEM_SETITEM}
  CBEM_SETITEM            = CBEM_SETITEMW;
  {$EXTERNALSYM CBEM_GETITEM}
  CBEM_GETITEM            = CBEM_GETITEMW;
{$ELSE}
  {$EXTERNALSYM CBEM_INSERTITEM}
  CBEM_INSERTITEM         = CBEM_INSERTITEMA;
  {$EXTERNALSYM CBEM_SETITEM}
  CBEM_SETITEM            = CBEM_SETITEMA;
  {$EXTERNALSYM CBEM_GETITEM}
  CBEM_GETITEM            = CBEM_GETITEMA;
{$ENDIF}

  {$EXTERNALSYM CBES_EX_NOEDITIMAGE}
  CBES_EX_NOEDITIMAGE          = $00000001;
  {$EXTERNALSYM CBES_EX_NOEDITIMAGEINDENT}
  CBES_EX_NOEDITIMAGEINDENT    = $00000002;
  {$EXTERNALSYM CBES_EX_PATHWORDBREAKPROC}
  CBES_EX_PATHWORDBREAKPROC    = $00000004;
  {$EXTERNALSYM CBES_EX_NOSIZELIMIT}
  CBES_EX_NOSIZELIMIT          = $00000008;
  {$EXTERNALSYM CBES_EX_CASESENSITIVE}
  CBES_EX_CASESENSITIVE        = $00000010;
  { For Windows >= Vista }
  {$EXTERNALSYM CBES_EX_TEXTENDELLIPSIS}
  CBES_EX_TEXTENDELLIPSIS      = $00000020;

type
  {$EXTERNALSYM NMCOMBOBOXEXA}
  NMCOMBOBOXEXA = record
    hdr: TNMHdr;
    ceItem: TComboBoxExItemA;
  end;
  {$EXTERNALSYM NMCOMBOBOXEXW}
  NMCOMBOBOXEXW = record
    hdr: TNMHdr;
    ceItem: TComboBoxExItemW;
  end;
  {$EXTERNALSYM NMCOMBOBOXEX}
  NMCOMBOBOXEX = NMCOMBOBOXEXW;
  PNMComboBoxExA = ^TNMComboBoxExA;
  PNMComboBoxExW = ^TNMComboBoxExW;
  PNMComboBoxEx = PNMComboBoxExW;
  TNMComboBoxExA = NMCOMBOBOXEXA;
  TNMComboBoxExW = NMCOMBOBOXEXW;
  TNMComboBoxEx = TNMComboBoxExW;

const
  {$EXTERNALSYM CBEN_GETDISPINFOA}
  CBEN_GETDISPINFOA       = CBEN_FIRST - 0;
  {$EXTERNALSYM CBEN_INSERTITEM}
  CBEN_INSERTITEM         = CBEN_FIRST - 1;
  {$EXTERNALSYM CBEN_DELETEITEM}
  CBEN_DELETEITEM         = CBEN_FIRST - 2;
  {$EXTERNALSYM CBEN_BEGINEDIT}
  CBEN_BEGINEDIT          = CBEN_FIRST - 4;
  {$EXTERNALSYM CBEN_ENDEDITA}
  CBEN_ENDEDITA           = CBEN_FIRST - 5; // lParam specifies why the endedit is happening
  {$EXTERNALSYM CBEN_ENDEDITW}
  CBEN_ENDEDITW           = CBEN_FIRST - 6;
  {$EXTERNALSYM CBEN_GETDISPINFOW}
  CBEN_GETDISPINFOW       = CBEN_FIRST - 7;
  {$EXTERNALSYM CBEN_DRAGBEGINA}
  CBEN_DRAGBEGINA			    = CBEN_FIRST - 8;
  {$EXTERNALSYM CBEN_DRAGBEGINW}
  CBEN_DRAGBEGINW			    = CBEN_FIRST - 9;

{$IFDEF UNICODE}
  {$EXTERNALSYM CBEN_ENDEDIT}
  CBEN_ENDEDIT            = CBEN_ENDEDITW;
  {$EXTERNALSYM CBEN_GETDISPINFO}
  CBEN_GETDISPINFO        = CBEN_GETDISPINFOW;
  {$EXTERNALSYM CBEN_DRAGBEGIN}
  CBEN_DRAGBEGIN          = CBEN_DRAGBEGINW;
{$ELSE}
  {$EXTERNALSYM CBEN_ENDEDIT}
  CBEN_ENDEDIT            = CBEN_ENDEDITA;
  {$EXTERNALSYM CBEN_GETDISPINFO}
  CBEN_GETDISPINFO        = CBEN_GETDISPINFOA;
  {$EXTERNALSYM CBEN_DRAGBEGIN}
  CBEN_DRAGBEGIN          = CBEN_DRAGBEGINA;
{$ENDIF}

  {$EXTERNALSYM CBENF_KILLFOCUS}
  CBENF_KILLFOCUS         = 1;
  {$EXTERNALSYM CBENF_RETURN}
  CBENF_RETURN            = 2;
  {$EXTERNALSYM CBENF_ESCAPE}
  CBENF_ESCAPE            = 3;
  {$EXTERNALSYM CBENF_DROPDOWN}
  CBENF_DROPDOWN          = 4;

  {$EXTERNALSYM CBEMAXSTRLEN}
  CBEMAXSTRLEN = 260;

type
  // CBEN_DRAGBEGIN sends this information ...
  {$EXTERNALSYM NMCBEDRAGBEGINA}
  NMCBEDRAGBEGINA = record
    hdr: TNMHdr;
    iItemid: Integer;
    szText: array[0..CBEMAXSTRLEN - 1] of AnsiChar;
  end;
  {$EXTERNALSYM NMCBEDRAGBEGINW}
  NMCBEDRAGBEGINW = record
    hdr: TNMHdr;
    iItemid: Integer;
    szText: array[0..CBEMAXSTRLEN - 1] of WideChar;
  end;
  {$EXTERNALSYM NMCBEDRAGBEGIN}
  NMCBEDRAGBEGIN = NMCBEDRAGBEGINW;
  PNMCBEDragBeginA = ^TNMCBEDragBeginA;
  PNMCBEDragBeginW = ^TNMCBEDragBeginW;
  PNMCBEDragBegin = PNMCBEDragBeginW;
  TNMCBEDragBeginA = NMCBEDRAGBEGINA;
  TNMCBEDragBeginW = NMCBEDRAGBEGINW;
  TNMCBEDragBegin = TNMCBEDragBeginW;

  // CBEN_ENDEDIT sends this information...
  // fChanged if the user actually did anything
  // iNewSelection gives what would be the new selection unless the notify is failed
  //                      iNewSelection may be CB_ERR if there's no match
  {$EXTERNALSYM NMCBEENDEDITA}
  NMCBEENDEDITA = record
    hdr: TNMHdr;
    fChanged: BOOL;
    iNewSelection: Integer;
    szText: array[0..CBEMAXSTRLEN - 1] of AnsiChar;
    iWhy: Integer;
  end;
  {$EXTERNALSYM NMCBEENDEDITW}
  NMCBEENDEDITW = record
    hdr: TNMHdr;
    fChanged: BOOL;
    iNewSelection: Integer;
    szText: array[0..CBEMAXSTRLEN - 1] of WideChar;
    iWhy: Integer;
  end;
  {$EXTERNALSYM NMCBEENDEDIT}
  NMCBEENDEDIT = NMCBEENDEDITW;
  PNMCBEEndEditA = ^TNMCBEEndEditA;
  PNMCBEEndEditW = ^TNMCBEEndEditW;
  PNMCBEEndEdit = PNMCBEEndEditW;
  TNMCBEEndEditA = NMCBEENDEDITA;
  TNMCBEEndEditW = NMCBEENDEDITW;
  TNMCBEEndEdit = TNMCBEEndEditW;

{ ====== TAB CONTROL ======================== }

const
  {$EXTERNALSYM WC_TABCONTROL}
  WC_TABCONTROL = 'SysTabControl32';

const
  {$EXTERNALSYM TCS_SCROLLOPPOSITE}
  TCS_SCROLLOPPOSITE    = $0001;  // assumes multiline tab
  {$EXTERNALSYM TCS_BOTTOM}
  TCS_BOTTOM            = $0002;
  {$EXTERNALSYM TCS_RIGHT}
  TCS_RIGHT             = $0002;
  {$EXTERNALSYM TCS_MULTISELECT}
  TCS_MULTISELECT       = $0004;  // allow multi-select in button mode
  {$EXTERNALSYM TCS_FLATBUTTONS}
  TCS_FLATBUTTONS       = $0008;
  {$EXTERNALSYM TCS_FORCEICONLEFT}
  TCS_FORCEICONLEFT     = $0010;
  {$EXTERNALSYM TCS_FORCELABELLEFT}
  TCS_FORCELABELLEFT    = $0020;
  {$EXTERNALSYM TCS_HOTTRACK}
  TCS_HOTTRACK          = $0040;
  {$EXTERNALSYM TCS_VERTICAL}
  TCS_VERTICAL          = $0080;
  {$EXTERNALSYM TCS_TABS}
  TCS_TABS              = $0000;
  {$EXTERNALSYM TCS_BUTTONS}
  TCS_BUTTONS           = $0100;
  {$EXTERNALSYM TCS_SINGLELINE}
  TCS_SINGLELINE        = $0000;
  {$EXTERNALSYM TCS_MULTILINE}
  TCS_MULTILINE         = $0200;
  {$EXTERNALSYM TCS_RIGHTJUSTIFY}
  TCS_RIGHTJUSTIFY      = $0000;
  {$EXTERNALSYM TCS_FIXEDWIDTH}
  TCS_FIXEDWIDTH        = $0400;
  {$EXTERNALSYM TCS_RAGGEDRIGHT}
  TCS_RAGGEDRIGHT       = $0800;
  {$EXTERNALSYM TCS_FOCUSONBUTTONDOWN}
  TCS_FOCUSONBUTTONDOWN = $1000;
  {$EXTERNALSYM TCS_OWNERDRAWFIXED}
  TCS_OWNERDRAWFIXED    = $2000;
  {$EXTERNALSYM TCS_TOOLTIPS}
  TCS_TOOLTIPS          = $4000;
  {$EXTERNALSYM TCS_FOCUSNEVER}
  TCS_FOCUSNEVER        = $8000;

  {$EXTERNALSYM TCS_EX_FLATSEPARATORS}
  TCS_EX_FLATSEPARATORS = $00000001;
  {$EXTERNALSYM TCS_EX_REGISTERDROP}
  TCS_EX_REGISTERDROP   = $00000002;

  {$EXTERNALSYM TCM_GETIMAGELIST}
  TCM_GETIMAGELIST       = TCM_FIRST + 2;
  {$EXTERNALSYM TCM_SETIMAGELIST}
  TCM_SETIMAGELIST       = TCM_FIRST + 3;
  {$EXTERNALSYM TCM_GETITEMCOUNT}
  TCM_GETITEMCOUNT       = TCM_FIRST + 4;
  {$EXTERNALSYM TCM_DELETEITEM}
  TCM_DELETEITEM         = TCM_FIRST + 8;
  {$EXTERNALSYM TCM_DELETEALLITEMS}
  TCM_DELETEALLITEMS     = TCM_FIRST + 9;
  {$EXTERNALSYM TCM_GETITEMRECT}
  TCM_GETITEMRECT        = TCM_FIRST + 10;
  {$EXTERNALSYM TCM_GETCURSEL}
  TCM_GETCURSEL          = TCM_FIRST + 11;
  {$EXTERNALSYM TCM_SETCURSEL}
  TCM_SETCURSEL          = TCM_FIRST + 12;
  {$EXTERNALSYM TCM_HITTEST}
  TCM_HITTEST            = TCM_FIRST + 13;
  {$EXTERNALSYM TCM_SETITEMEXTRA}
  TCM_SETITEMEXTRA       = TCM_FIRST + 14;
  {$EXTERNALSYM TCM_ADJUSTRECT}
  TCM_ADJUSTRECT         = TCM_FIRST + 40;
  {$EXTERNALSYM TCM_SETITEMSIZE}
  TCM_SETITEMSIZE        = TCM_FIRST + 41;
  {$EXTERNALSYM TCM_REMOVEIMAGE}
  TCM_REMOVEIMAGE        = TCM_FIRST + 42;
  {$EXTERNALSYM TCM_SETPADDING}
  TCM_SETPADDING         = TCM_FIRST + 43;
  {$EXTERNALSYM TCM_GETROWCOUNT}
  TCM_GETROWCOUNT        = TCM_FIRST + 44;
  {$EXTERNALSYM TCM_GETTOOLTIPS}
  TCM_GETTOOLTIPS        = TCM_FIRST + 45;
  {$EXTERNALSYM TCM_SETTOOLTIPS}
  TCM_SETTOOLTIPS        = TCM_FIRST + 46;
  {$EXTERNALSYM TCM_GETCURFOCUS}
  TCM_GETCURFOCUS        = TCM_FIRST + 47;
  {$EXTERNALSYM TCM_SETCURFOCUS}
  TCM_SETCURFOCUS        = TCM_FIRST + 48;
  {$EXTERNALSYM TCM_SETMINTABWIDTH}
  TCM_SETMINTABWIDTH     = TCM_FIRST + 49;
  {$EXTERNALSYM TCM_DESELECTALL}
  TCM_DESELECTALL        = TCM_FIRST + 50;
  {$EXTERNALSYM TCM_HIGHLIGHTITEM}
  TCM_HIGHLIGHTITEM      = TCM_FIRST + 51;
  {$EXTERNALSYM TCM_SETEXTENDEDSTYLE}
  TCM_SETEXTENDEDSTYLE   = TCM_FIRST + 52;  // optional wParam == mask
  {$EXTERNALSYM TCM_GETEXTENDEDSTYLE}
  TCM_GETEXTENDEDSTYLE   = TCM_FIRST + 53;
  {$EXTERNALSYM TCM_SETUNICODEFORMAT}
  TCM_SETUNICODEFORMAT   = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM TCM_GETUNICODEFORMAT}
  TCM_GETUNICODEFORMAT   = CCM_GETUNICODEFORMAT;

  {$EXTERNALSYM TCIF_TEXT}
  TCIF_TEXT       = $0001;
  {$EXTERNALSYM TCIF_IMAGE}
  TCIF_IMAGE      = $0002;
  {$EXTERNALSYM TCIF_RTLREADING}
  TCIF_RTLREADING = $0004;
  {$EXTERNALSYM TCIF_PARAM}
  TCIF_PARAM      = $0008;
  {$EXTERNALSYM TCIF_STATE}
  TCIF_STATE      = $0010;

  {$EXTERNALSYM TCIS_BUTTONPRESSED}
  TCIS_BUTTONPRESSED      = $0001;
  {$EXTERNALSYM TCIS_HIGHLIGHTED}
  TCIS_HIGHLIGHTED        = $0002;

type
  PTCItemHeaderA = ^TTCItemHeaderA;
  PTCItemHeaderW = ^TTCItemHeaderW;
  PTCItemHeader = PTCItemHeaderW;
  {$EXTERNALSYM tagTCITEMHEADERA}
  tagTCITEMHEADERA = record
    mask: UINT;
    lpReserved1: UINT;
    lpReserved2: UINT;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
  end;
  {$EXTERNALSYM tagTCITEMHEADERW}
  tagTCITEMHEADERW = record
    mask: UINT;
    lpReserved1: UINT;
    lpReserved2: UINT;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
  end;
  {$EXTERNALSYM tagTCITEMHEADER}
  tagTCITEMHEADER = tagTCITEMHEADERW;
  {$EXTERNALSYM _TC_ITEMHEADERA}
  _TC_ITEMHEADERA = tagTCITEMHEADERA;
  {$EXTERNALSYM _TC_ITEMHEADERW}
  _TC_ITEMHEADERW = tagTCITEMHEADERW;
  {$EXTERNALSYM _TC_ITEMHEADER}
  _TC_ITEMHEADER = _TC_ITEMHEADERW;
  TTCItemHeaderA = tagTCITEMHEADERA;
  TTCItemHeaderW = tagTCITEMHEADERW;
  TTCItemHeader = TTCItemHeaderW;
  {$EXTERNALSYM TC_ITEMHEADERA}
  TC_ITEMHEADERA = tagTCITEMHEADERA;
  {$EXTERNALSYM TC_ITEMHEADERW}
  TC_ITEMHEADERW = tagTCITEMHEADERW;
  {$EXTERNALSYM TC_ITEMHEADER}
  TC_ITEMHEADER = TC_ITEMHEADERW;

  PTCItemA = ^TTCItemA;
  PTCItemW = ^TTCItemW;
  PTCItem = PTCItemW;
  {$EXTERNALSYM tagTCITEMA}
  tagTCITEMA = record
    mask: UINT;
    dwState: DWORD;
    dwStateMask: DWORD;
    pszText: LPSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagTCITEMW}
  tagTCITEMW = record
    mask: UINT;
    dwState: DWORD;
    dwStateMask: DWORD;
    pszText: LPWSTR;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
  end;
  {$EXTERNALSYM tagTCITEM}
  tagTCITEM = tagTCITEMW;
  {$EXTERNALSYM _TC_ITEMA}
  _TC_ITEMA = tagTCITEMA;
  {$EXTERNALSYM _TC_ITEMW}
  _TC_ITEMW = tagTCITEMW;
  {$EXTERNALSYM _TC_ITEM}
  _TC_ITEM = _TC_ITEMW;
  TTCItemA = tagTCITEMA;
  TTCItemW = tagTCITEMW;
  TTCItem = TTCItemW;
  {$EXTERNALSYM TC_ITEMA}
  TC_ITEMA = tagTCITEMA;
  {$EXTERNALSYM TC_ITEMW}
  TC_ITEMW = tagTCITEMW;
  {$EXTERNALSYM TC_ITEM}
  TC_ITEM = TC_ITEMW;

const
  {$EXTERNALSYM TCM_GETITEMA}
  TCM_GETITEMA             = TCM_FIRST + 5;
  {$EXTERNALSYM TCM_SETITEMA}
  TCM_SETITEMA             = TCM_FIRST + 6;
  {$EXTERNALSYM TCM_INSERTITEMA}
  TCM_INSERTITEMA          = TCM_FIRST + 7;
  {$EXTERNALSYM TCM_GETITEMW}
  TCM_GETITEMW             = TCM_FIRST + 60;
  {$EXTERNALSYM TCM_SETITEMW}
  TCM_SETITEMW             = TCM_FIRST + 61;
  {$EXTERNALSYM TCM_INSERTITEMW}
  TCM_INSERTITEMW          = TCM_FIRST + 62;
{$IFDEF UNICODE}
  {$EXTERNALSYM TCM_GETITEM}
  TCM_GETITEM             = TCM_GETITEMW;
  {$EXTERNALSYM TCM_SETITEM}
  TCM_SETITEM             = TCM_SETITEMW;
  {$EXTERNALSYM TCM_INSERTITEM}
  TCM_INSERTITEM          = TCM_INSERTITEMW;
{$ELSE}
  {$EXTERNALSYM TCM_GETITEM}
  TCM_GETITEM             = TCM_GETITEMA;
  {$EXTERNALSYM TCM_SETITEM}
  TCM_SETITEM             = TCM_SETITEMA;
  {$EXTERNALSYM TCM_INSERTITEM}
  TCM_INSERTITEM          = TCM_INSERTITEMA;
{$ENDIF}

const
  {$EXTERNALSYM TCHT_NOWHERE}
  TCHT_NOWHERE     = $0001;
  {$EXTERNALSYM TCHT_ONITEMICON}
  TCHT_ONITEMICON  = $0002;
  {$EXTERNALSYM TCHT_ONITEMLABEL}
  TCHT_ONITEMLABEL = $0004;
  {$EXTERNALSYM TCHT_ONITEM}
  TCHT_ONITEM      = TCHT_ONITEMICON or TCHT_ONITEMLABEL;

type
  PTCHitTestInfo = ^TTCHitTestInfo;
  {$EXTERNALSYM tagTCHITTESTINFO}
  tagTCHITTESTINFO = record
    pt: TPoint;
    flags: UINT;
  end;
  {$EXTERNALSYM _TC_HITTESTINFO}
  _TC_HITTESTINFO = tagTCHITTESTINFO;
  TTCHitTestInfo = tagTCHITTESTINFO;
  {$EXTERNALSYM TC_HITTESTINFO}
  TC_HITTESTINFO = tagTCHITTESTINFO;

{$ALIGN 1}
  {$EXTERNALSYM tagTCKEYDOWN}
  tagTCKEYDOWN = record
    hdr: TNMHDR;
    wVKey: Word;
    flags: UINT;
  end;
  {$EXTERNALSYM _TC_KEYDOWN}
  _TC_KEYDOWN = tagTCKEYDOWN;
  TTCKeyDown = tagTCKEYDOWN;
  {$EXTERNALSYM TC_KEYDOWN}
  TC_KEYDOWN = tagTCKEYDOWN;
{$ALIGN ON}

const
  {$EXTERNALSYM TCN_KEYDOWN}
  TCN_KEYDOWN             = TCN_FIRST - 0;
  {$EXTERNALSYM TCN_SELCHANGE}
  TCN_SELCHANGE           = TCN_FIRST - 1;
  {$EXTERNALSYM TCN_SELCHANGING}
  TCN_SELCHANGING         = TCN_FIRST - 2;
  {$EXTERNALSYM TCN_GETOBJECT}
  TCN_GETOBJECT           = TCN_FIRST - 3;
  {$EXTERNALSYM TCN_FOCUSCHANGE}
  TCN_FOCUSCHANGE         = TCN_FIRST - 4;

{$EXTERNALSYM TabCtrl_HitTest}
function TabCtrl_HitTest(hwndTC: HWND; pinfo: PTCHitTestInfo): Integer; overload; inline;
{$EXTERNALSYM TabCtrl_HitTest}
function TabCtrl_HitTest(hwndTC: HWND; const pinfo: TTCHitTestInfo): Integer; overload; inline;
{$EXTERNALSYM TabCtrl_SetItemExtra}
function TabCtrl_SetItemExtra(hwndTC: HWND; cb: Integer): BOOL; inline;
{$EXTERNALSYM TabCtrl_AdjustRect}
function TabCtrl_AdjustRect(hwnd: HWND; bLarger: BOOL; prc: PRect): Integer; inline;
{$EXTERNALSYM TabCtrl_SetItemSize}
function TabCtrl_SetItemSize(hwnd: HWND; x, y: Integer): DWORD;
{$EXTERNALSYM TabCtrl_RemoveImage}
procedure TabCtrl_RemoveImage(hwnd: HWND; i: Integer);
{$EXTERNALSYM TabCtrl_SetPadding}
procedure TabCtrl_SetPadding(hwnd: HWND; cx, cy: Integer);
{$EXTERNALSYM TabCtrl_GetRowCount}
function TabCtrl_GetRowCount(hwnd: HWND): Integer; inline;
{$EXTERNALSYM TabCtrl_GetToolTips}
function TabCtrl_GetToolTips(wnd: HWND): HWND; inline;
{$EXTERNALSYM TabCtrl_SetToolTips}
procedure TabCtrl_SetToolTips(hwnd: HWND; hwndTT: HWND);
{$EXTERNALSYM TabCtrl_GetCurFocus}
function TabCtrl_GetCurFocus(hwnd: HWND): Integer; inline;
{$EXTERNALSYM TabCtrl_SetCurFocus}
procedure TabCtrl_SetCurFocus(hwnd: HWND; i: Integer);
{$EXTERNALSYM TabCtrl_SetMinTabWidth}
function TabCtrl_SetMinTabWidth(hwnd: HWND; x: Integer): Integer; inline;
{$EXTERNALSYM TabCtrl_DeselectAll}
procedure TabCtrl_DeselectAll(hwnd: HWND; fExcludeFocus: BOOL);
{$EXTERNALSYM TabCtrl_HighlightItem}
function TabCtrl_HighlightItem(hwnd: HWND; i: Integer; fHighlight: WordBool): BOOL;
{$EXTERNALSYM TabCtrl_SetExtendedStyle}
function TabCtrl_SetExtendedStyle(hwnd: HWND; dw: DWORD): DWORD; inline;
{$EXTERNALSYM TabCtrl_GetExtendedStyle}
function TabCtrl_GetExtendedStyle(hwnd: HWND): DWORD; inline;
{$EXTERNALSYM TabCtrl_SetUnicodeFormat}
function TabCtrl_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL; inline;
{$EXTERNALSYM TabCtrl_GetUnicodeFormat}
function TabCtrl_GetUnicodeFormat(hwnd: HWND): BOOL; inline;
{$EXTERNALSYM TabCtrl_GetItemRect}
function TabCtrl_GetItemRect(hwnd: HWND; i: Integer; var prc: TRect): BOOL; inline;

{ ====== ANIMATE CONTROL ================= }

const
  {$EXTERNALSYM ANIMATE_CLASS}
  ANIMATE_CLASS = 'SysAnimate32';

const
  {$EXTERNALSYM ACS_CENTER}
  ACS_CENTER              = $0001;
  {$EXTERNALSYM ACS_TRANSPARENT}
  ACS_TRANSPARENT         = $0002;
  {$EXTERNALSYM ACS_AUTOPLAY}
  ACS_AUTOPLAY            = $0004;
  {$EXTERNALSYM ACS_TIMER}
  ACS_TIMER               = $0008;  { don't use threads... use timers }

  {$EXTERNALSYM ACM_OPENA}
  ACM_OPENA                = WM_USER + 100;
  {$EXTERNALSYM ACM_OPENW}
  ACM_OPENW                = WM_USER + 103;
{$IFDEF UNICODE}
  {$EXTERNALSYM ACM_OPEN}
  ACM_OPEN                = ACM_OPENW;
{$ELSE}
  {$EXTERNALSYM ACM_OPEN}
  ACM_OPEN                = ACM_OPENA;
{$ENDIF}

  {$EXTERNALSYM ACM_PLAY}
  ACM_PLAY                = WM_USER + 101;
  {$EXTERNALSYM ACM_STOP}
  ACM_STOP                = WM_USER + 102;

  {$EXTERNALSYM ACN_START}
  ACN_START               = 1;
  {$EXTERNALSYM ACN_STOP}
  ACN_STOP                = 2;

{$EXTERNALSYM Animate_Create}
function Animate_Create(hwndP: HWND; id: HMENU; dwStyle: DWORD; hInstance: HINST): HWND;
{$EXTERNALSYM Animate_Open}
function Animate_Open(hwnd: HWND; szName: PChar): BOOL; inline;
{$EXTERNALSYM Animate_OpenEx}
function Animate_OpenEx(hwnd: HWND; hInst: HINST; szName: PChar): BOOL; inline;
{$EXTERNALSYM Animate_Play}
function Animate_Play(hwnd: HWND; from, _to: Word; rep: UINT): BOOL;
{$EXTERNALSYM Animate_Stop}
function Animate_Stop(hwnd: HWND): BOOL; inline;
{$EXTERNALSYM Animate_Close}
function Animate_Close(hwnd: HWND): BOOL; inline;
{$EXTERNALSYM Animate_Seek}
function Animate_Seek(hwnd: HWND; frame: Word): BOOL; inline;

{ ====== MONTHCAL CONTROL ========= }

const
  {$EXTERNALSYM MONTHCAL_CLASS}
  MONTHCAL_CLASS          = 'SysMonthCal32';

const  
  // Message constants
  {$EXTERNALSYM MCM_FIRST}
  MCM_FIRST             = $1000;
  {$EXTERNALSYM MCM_GETCURSEL}
  MCM_GETCURSEL         = MCM_FIRST + 1;
  {$EXTERNALSYM MCM_SETCURSEL}
  MCM_SETCURSEL         = MCM_FIRST + 2;
  {$EXTERNALSYM MCM_GETMAXSELCOUNT}
  MCM_GETMAXSELCOUNT    = MCM_FIRST + 3;
  {$EXTERNALSYM MCM_SETMAXSELCOUNT}
  MCM_SETMAXSELCOUNT    = MCM_FIRST + 4;
  {$EXTERNALSYM MCM_GETSELRANGE}
  MCM_GETSELRANGE       = MCM_FIRST + 5;
  {$EXTERNALSYM MCM_SETSELRANGE}
  MCM_SETSELRANGE       = MCM_FIRST + 6;
  {$EXTERNALSYM MCM_GETMONTHRANGE}
  MCM_GETMONTHRANGE     = MCM_FIRST + 7;
  {$EXTERNALSYM MCM_SETDAYSTATE}
  MCM_SETDAYSTATE       = MCM_FIRST + 8;
  {$EXTERNALSYM MCM_GETMINREQRECT}
  MCM_GETMINREQRECT     = MCM_FIRST + 9;
  {$EXTERNALSYM MCM_SETCOLOR}
  MCM_SETCOLOR          = MCM_FIRST + 10;
  {$EXTERNALSYM MCM_GETCOLOR}
  MCM_GETCOLOR          = MCM_FIRST + 11;
  {$EXTERNALSYM MCM_SETTODAY}
  MCM_SETTODAY          = MCM_FIRST + 12;
  {$EXTERNALSYM MCM_GETTODAY}
  MCM_GETTODAY          = MCM_FIRST + 13;
  {$EXTERNALSYM MCM_HITTEST}
  MCM_HITTEST           = MCM_FIRST + 14;
  {$EXTERNALSYM MCM_SETFIRSTDAYOFWEEK}
  MCM_SETFIRSTDAYOFWEEK = MCM_FIRST + 15;
  {$EXTERNALSYM MCM_GETFIRSTDAYOFWEEK}
  MCM_GETFIRSTDAYOFWEEK = MCM_FIRST + 16;
  {$EXTERNALSYM MCM_GETRANGE}
  MCM_GETRANGE          = MCM_FIRST + 17;
  {$EXTERNALSYM MCM_SETRANGE}
  MCM_SETRANGE          = MCM_FIRST + 18;
  {$EXTERNALSYM MCM_GETMONTHDELTA}
  MCM_GETMONTHDELTA     = MCM_FIRST + 19;
  {$EXTERNALSYM MCM_SETMONTHDELTA}
  MCM_SETMONTHDELTA     = MCM_FIRST + 20;
  {$EXTERNALSYM MCM_GETMAXTODAYWIDTH}
  MCM_GETMAXTODAYWIDTH  = MCM_FIRST + 21;
  {$EXTERNALSYM MCM_SETUNICODEFORMAT}
  MCM_SETUNICODEFORMAT  = CCM_SETUNICODEFORMAT;
  {$EXTERNALSYM MCM_GETUNICODEFORMAT}
  MCM_GETUNICODEFORMAT  = CCM_GETUNICODEFORMAT;

  // Hit test flags
  {$EXTERNALSYM MCHT_TITLE}
  MCHT_TITLE            = $00010000;
  {$EXTERNALSYM MCHT_CALENDAR}
  MCHT_CALENDAR         = $00020000;
  {$EXTERNALSYM MCHT_TODAYLINK}
  MCHT_TODAYLINK        = $00030000;
  // NTDDI_VERSION >= NTDDI_VISTA
  {$EXTERNALSYM MCHT_CALENDARCONTROL}
  MCHT_CALENDARCONTROL  = $00100000;

  {$EXTERNALSYM MCHT_NEXT}
  MCHT_NEXT             = $01000000;  // these indicate that hitting
  {$EXTERNALSYM MCHT_PREV}
  MCHT_PREV             = $02000000;  // here will go to the next/prev month
  {$EXTERNALSYM MCHT_NOWHERE}
  MCHT_NOWHERE          = $00000000;
  {$EXTERNALSYM MCHT_TITLEBK}
  MCHT_TITLEBK          = MCHT_TITLE;
  {$EXTERNALSYM MCHT_TITLEMONTH}
  MCHT_TITLEMONTH       = MCHT_TITLE or $0001;
  {$EXTERNALSYM MCHT_TITLEYEAR}
  MCHT_TITLEYEAR        = MCHT_TITLE or $0002;
  {$EXTERNALSYM MCHT_TITLEBTNNEXT}
  MCHT_TITLEBTNNEXT     = MCHT_TITLE or MCHT_NEXT or $0003;
  {$EXTERNALSYM MCHT_TITLEBTNPREV}
  MCHT_TITLEBTNPREV     = MCHT_TITLE or MCHT_PREV or $0003;
  {$EXTERNALSYM MCHT_CALENDARBK}
  MCHT_CALENDARBK       = MCHT_CALENDAR;
  {$EXTERNALSYM MCHT_CALENDARDATE}
  MCHT_CALENDARDATE     = MCHT_CALENDAR or $0001;
  {$EXTERNALSYM MCHT_CALENDARDATENEXT}
  MCHT_CALENDARDATENEXT = MCHT_CALENDARDATE or MCHT_NEXT;
  {$EXTERNALSYM MCHT_CALENDARDATEPREV}
  MCHT_CALENDARDATEPREV = MCHT_CALENDARDATE or MCHT_PREV;
  {$EXTERNALSYM MCHT_CALENDARDAY}
  MCHT_CALENDARDAY      = MCHT_CALENDAR or $0002;
  {$EXTERNALSYM MCHT_CALENDARWEEKNUM}
  MCHT_CALENDARWEEKNUM  = MCHT_CALENDAR or $0003;

  // Color codes
  {$EXTERNALSYM MCSC_BACKGROUND}
  MCSC_BACKGROUND       = 0;   // the background color (between months)
  {$EXTERNALSYM MCSC_TEXT}
  MCSC_TEXT             = 1;   // the dates
  {$EXTERNALSYM MCSC_TITLEBK}
  MCSC_TITLEBK          = 2;   // background of the title
  {$EXTERNALSYM MCSC_TITLETEXT}
  MCSC_TITLETEXT        = 3;
  {$EXTERNALSYM MCSC_MONTHBK}
  MCSC_MONTHBK          = 4;   // background within the month cal
  {$EXTERNALSYM MCSC_TRAILINGTEXT}
  MCSC_TRAILINGTEXT     = 5;   // the text color of header & trailing days

  // Notification codes
  {$EXTERNALSYM MCN_SELCHANGE}
  MCN_SELCHANGE         = MCN_FIRST - 3; // -749
  {$EXTERNALSYM MCN_GETDAYSTATE}
  MCN_GETDAYSTATE       = MCN_FIRST - 1; // -747
  {$EXTERNALSYM MCN_SELECT}
  MCN_SELECT            = MCN_FIRST; // -746

  // Style flags
  {$EXTERNALSYM MCS_DAYSTATE}
  MCS_DAYSTATE          = $0001;
  {$EXTERNALSYM MCS_MULTISELECT}
  MCS_MULTISELECT       = $0002;
  {$EXTERNALSYM MCS_WEEKNUMBERS}
  MCS_WEEKNUMBERS       = $0004;
  MCS_NOTODAY_PRE_IE4   = $0008;
  {$EXTERNALSYM MCS_NOTODAYCIRCLE}
  MCS_NOTODAYCIRCLE     = $0008;
  {$EXTERNALSYM MCS_NOTODAY}
  MCS_NOTODAY           = $0010;
  // For NTDDI_VERSION >= NTDDI_VISTA
  {$EXTERNALSYM MCS_NOTRAILINGDATES}
  MCS_NOTRAILINGDATES   = $0040;
  {$EXTERNALSYM MCS_SHORTDAYSOFWEEK}
  MCS_SHORTDAYSOFWEEK   = $0080;
  {$EXTERNALSYM MCS_NOSELCHANGEONNAV}
  MCS_NOSELCHANGEONNAV  = $0100;

  {$EXTERNALSYM GMR_VISIBLE}
  GMR_VISIBLE           = 0;       // visible portion of display
  {$EXTERNALSYM GMR_DAYSTATE}
  GMR_DAYSTATE          = 1;       // above plus the grayed out parts of
                                   // partially displayed months
                                   
type
  // bit-packed array of "bold" info for a month
  // if a bit is on, that day is drawn bold
  {$EXTERNALSYM MONTHDAYSTATE}
  MONTHDAYSTATE = DWORD;
  PMonthDayState = ^TMonthDayState;
  TMonthDayState = MONTHDAYSTATE;

  {$EXTERNALSYM MCHITTESTINFO}
  MCHITTESTINFO = record
    cbSize: UINT;
    pt: TPoint;
    uHit: UINT;      // out param
    st: TSystemTime;
    // For NTDDI_VERSION >= NTDDI_VISTA
    rc: TRect;
    iOffset: Integer;
    iRow: Integer;
    iCol: Integer;
    class function SizeOf: Integer; static;
  end;
  PMCHitTestInfo = ^TMCHitTestInfo;
  TMCHitTestInfo = MCHITTESTINFO;

  // MCN_SELCHANGE is sent whenever the currently displayed date changes
  // via month change, year change, keyboard navigation, prev/next button
  {$EXTERNALSYM tagNMSELCHANGE}
  tagNMSELCHANGE = record
    nmhdr: TNmHdr;  // this must be first, so we don't break WM_NOTIFY
    stSelStart: TSystemTime;
    stSelEnd: TSystemTime;
  end;
  PNMSelChange = ^TNMSelChange;
  TNMSelChange = tagNMSELCHANGE;

  // MCN_GETDAYSTATE is sent for MCS_DAYSTATE controls whenever new daystate
  // information is needed (month or year scroll) to draw bolding information.
  // The app must fill in cDayState months worth of information starting from
  // stStart date. The app may fill in the array at prgDayState or change
  // prgDayState to point to a different array out of which the information
  // will be copied. (similar to tooltips)
  {$EXTERNALSYM tagNMDAYSTATE}
  tagNMDAYSTATE = record
    nmhdr: TNmHdr;  // this must be first, so we don't break WM_NOTIFY
    stStart: TSystemTime;
    cDayState: Integer;
    prgDayState: PMonthDayState; // points to cDayState TMONTHDAYSTATEs
  end;
  PNMDayState = ^TNMDayState;
  TNMDayState = tagNMDAYSTATE;

  // MCN_SELECT is sent whenever a selection has occured (via mouse or keyboard)
  {$EXTERNALSYM NMSELECT}
  NMSELECT = tagNMSELCHANGE;
  PNMSelect = ^TNMSelect;
  TNMSelect = NMSELECT;

  TSystemTimeRangeArray = array[0..1] of TSystemTime;

//   returns FALSE if MCS_MULTISELECT
//   returns TRUE and sets *pst to the currently selected date otherwise
{$EXTERNALSYM MonthCal_GetCurSel}
function MonthCal_GetCurSel(hmc: HWND; var pst: TSystemTime): BOOL; inline;

//   returns FALSE if MCS_MULTISELECT
//   returns TURE and sets the currently selected date to *pst otherwise
{$EXTERNALSYM MonthCal_SetCurSel}
function MonthCal_SetCurSel(hmc: HWND; const pst: TSystemTime): BOOL; inline;

//   returns the maximum number of selectable days allowed
{$EXTERNALSYM MonthCal_GetMaxSelCount}
function MonthCal_GetMaxSelCount(hmc: HWND): DWORD; inline;

//   sets the max number days that can be selected iff MCS_MULTISELECT
{$EXTERNALSYM MonthCal_SetMaxSelCount}
function MonthCal_SetMaxSelCount(hmc: HWND; n: UINT): BOOL; inline;

//   sets rgst[0] to the first day of the selection range
//   sets rgst[1] to the last day of the selection range
{$EXTERNALSYM MonthCal_GetSelRange}
function MonthCal_GetSelRange(hmc: HWND; rgst: PSystemTime): BOOL; inline;

//   selects the range of days from rgst[0] to rgst[1]
{$EXTERNALSYM MonthCal_SetSelRange}
function MonthCal_SetSelRange(hmc: HWND; rgst: PSystemTime): BOOL; inline;

//   if rgst specified, sets rgst[0] to the starting date and
//      and rgst[1] to the ending date of the the selectable (non-grayed)
//      days if GMR_VISIBLE or all the displayed days (including grayed)
//      if GMR_DAYSTATE.
//   returns the number of months spanned by the above range.
{$EXTERNALSYM MonthCal_GetMonthRange}
function MonthCal_GetMonthRange(hmc: HWND; gmr: DWORD; rgst: PSystemTime): DWORD; inline;

//   cbds is the count of DAYSTATE items in rgds and it must be equal
//   to the value returned from MonthCal_GetMonthRange(hmc, GMR_DAYSTATE, NULL)
//   This sets the DAYSTATE bits for each month (grayed and non-grayed
//   days) displayed in the calendar. The first bit in a month's DAYSTATE
//   corresponts to bolding day 1, the second bit affects day 2, etc.
{$EXTERNALSYM MonthCal_SetDayState}
function MonthCal_SetDayState(hmc: HWND; cbds: Integer; const rgds: TNMDayState): BOOL; inline;

//   sets prc the minimal size needed to display one month
{$EXTERNALSYM MonthCal_GetMinReqRect}
function MonthCal_GetMinReqRect(hmc: HWND; var prc: TRect): BOOL; inline;

// set what day is "today"   send NULL to revert back to real date
{$EXTERNALSYM MonthCal_SetToday}
function MonthCal_SetToday(hmc: HWND; const pst: TSystemTime): BOOL; inline;

// get what day is "today"
// returns BOOL for success/failure
{$EXTERNALSYM MonthCal_GetToday}
function MonthCal_GetToday(hmc: HWND; var pst: TSystemTime): BOOL; inline;

// determine what pinfo->pt is over
{$EXTERNALSYM MonthCal_HitTest}
function MonthCal_HitTest(hmc: HWND; var info: TMCHitTestInfo): DWORD; {inline;}

// set colors to draw control with -- see MCSC_ bits below
{$EXTERNALSYM MonthCal_SetColor}
function MonthCal_SetColor(hmc: HWND; iColor: Integer; clr: TColorRef): TColorRef; inline;

{$EXTERNALSYM MonthCal_GetColor}
function MonthCal_GetColor(hmc: HWND; iColor: Integer): TColorRef; inline;

// set first day of week to iDay:
// 0 for Monday, 1 for Tuesday, ..., 6 for Sunday
// -1 for means use locale info
{$EXTERNALSYM MonthCal_SetFirstDayOfWeek}
function MonthCal_SetFirstDayOfWeek(hmc: HWND; iDay: Integer): Integer; inline;

// DWORD result...  low word has the day.  high word is bool if this is app set
// or not (FALSE == using locale info)
{$EXTERNALSYM MonthCal_GetFirstDayOfWeek}
function MonthCal_GetFirstDayOfWeek(hmc: HWND): Integer; inline;

//   modifies rgst[0] to be the minimum ALLOWABLE systemtime (or 0 if no minimum)
//   modifies rgst[1] to be the maximum ALLOWABLE systemtime (or 0 if no maximum)
//   returns GDTR_MIN|GDTR_MAX if there is a minimum|maximum limit
{$EXTERNALSYM MonthCal_GetRange}
function MonthCal_GetRange(hmc: HWND; rgst: PSystemTime): DWORD; inline;

//   if GDTR_MIN, sets the minimum ALLOWABLE systemtime to rgst[0], otherwise removes minimum
//   if GDTR_MAX, sets the maximum ALLOWABLE systemtime to rgst[1], otherwise removes maximum
//   returns TRUE on success, FALSE on error (such as invalid parameters)
{$EXTERNALSYM Monthcal_SetRange}
function Monthcal_SetRange(hmc: HWND; gdtr: DWORD; rgst: PSystemTime): BOOL; inline;

//   returns the number of months one click on a next/prev button moves by
{$EXTERNALSYM MonthCal_GetMonthDelta}
function MonthCal_GetMonthDelta(hmc: HWND): Integer; inline;

//   sets the month delta to n. n = 0 reverts to moving by a page of months
//   returns the previous value of n.
{$EXTERNALSYM MonthCal_SetMonthDelta}
function MonthCal_SetMonthDelta(hmc: HWND; n: Integer): Integer; inline;

//   sets *psz to the maximum width/height of the "Today" string displayed
//   at the bottom of the calendar (as long as MCS_NOTODAY is not specified)
{$EXTERNALSYM MonthCal_GetMaxTodayWidth}
function MonthCal_GetMaxTodayWidth(hmc: HWND): DWORD; inline;

{$EXTERNALSYM MonthCal_SetUnicodeFormat}
function MonthCal_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL; inline;

{$EXTERNALSYM MonthCal_GetUnicodeFormat}
function MonthCal_GetUnicodeFormat(hwnd: HWND): BOOL; inline;

{$REGION 'For NTDDI_VERSION >= NTDDI_VISTA'}
const
  // View
  {$EXTERNALSYM MCMV_MONTH}
  MCMV_MONTH     = 0;
  {$EXTERNALSYM MCMV_YEAR}
  MCMV_YEAR      = 1;
  {$EXTERNALSYM MCMV_DECADE}
  MCMV_DECADE    = 2;
  {$EXTERNALSYM MCMV_CENTURY}
  MCMV_CENTURY   = 3;
  {$EXTERNALSYM MCMV_MAX}
  MCMV_MAX       = MCMV_CENTURY;

  // Part
  {$EXTERNALSYM MCGIP_CALENDARCONTROL}
  MCGIP_CALENDARCONTROL     = 0;
  {$EXTERNALSYM MCGIP_NEXT}
  MCGIP_NEXT                = 1;
  {$EXTERNALSYM MCGIP_PREV}
  MCGIP_PREV                = 2;
  {$EXTERNALSYM MCGIP_FOOTER}
  MCGIP_FOOTER              = 3;
  {$EXTERNALSYM MCGIP_CALENDAR}
  MCGIP_CALENDAR            = 4;
  {$EXTERNALSYM MCGIP_CALENDARHEADER}
  MCGIP_CALENDARHEADER      = 5;
  {$EXTERNALSYM MCGIP_CALENDARBODY}
  MCGIP_CALENDARBODY        = 6;
  {$EXTERNALSYM MCGIP_CALENDARROW}
  MCGIP_CALENDARROW         = 7;
  {$EXTERNALSYM MCGIP_CALENDARCELL}
  MCGIP_CALENDARCELL        = 8;

  {$EXTERNALSYM MCGIF_DATE}
  MCGIF_DATE                = $00000001;
  {$EXTERNALSYM MCGIF_RECT}
  MCGIF_RECT                = $00000002;
  {$EXTERNALSYM MCGIF_NAME}
  MCGIF_NAME                = $00000004;

type
  // Note: iRow of -1 refers to the row header and iCol of -1 refers to the col header.
  {$EXTERNALSYM tagMCGRIDINFO}
  tagMCGRIDINFO = record
    cbSize: UINT;
    dwPart: DWORD;
    dwFlags: DWORD;
    iCalendar: Integer;
    iRow: Integer;
    iCol: Integer;
    bSelected: BOOL;
    stStart: TSystemTime;
    stEnd: TSystemTime;
    rc: TRect;
    pszName: LPWSTR;
    cchName: ULONG_PTR; // size_t
  end;
  PMCGridInfo = ^TMCGridInfo;
  TMCGridInfo = tagMCGRIDINFO;

const
  {$EXTERNALSYM MCM_GETCURRENTVIEW}
  MCM_GETCURRENTVIEW      = MCM_FIRST + 22;
  {$EXTERNALSYM MCM_GETCALENDARCOUNT}
  MCM_GETCALENDARCOUNT    = MCM_FIRST + 23;
  {$EXTERNALSYM MCM_GETCALENDARGRIDINFO}
  MCM_GETCALENDARGRIDINFO = MCM_FIRST + 24;
  {$EXTERNALSYM MCM_GETCALID}
  MCM_GETCALID            = MCM_FIRST + 27;
  {$EXTERNALSYM MCM_SETCALID}
  MCM_SETCALID            = MCM_FIRST + 28;
  {$EXTERNALSYM MCM_SIZERECTTOMIN}
  MCM_SIZERECTTOMIN       = MCM_FIRST + 29;
  {$EXTERNALSYM MCM_SETCALENDARBORDER}
  MCM_SETCALENDARBORDER   = MCM_FIRST + 30;
  {$EXTERNALSYM MCM_GETCALENDARBORDER}
  MCM_GETCALENDARBORDER   = MCM_FIRST + 31;
  {$EXTERNALSYM MCM_SETCURRENTVIEW}
  MCM_SETCURRENTVIEW      = MCM_FIRST + 32;

{$EXTERNALSYM MonthCal_GetCurrentView}
function MonthCal_GetCurrentView(hmc: HWND): DWORD; inline;
{$EXTERNALSYM MonthCal_GetCalendarCount}
function MonthCal_GetCalendarCount(hmc: HWND): DWORD; Inline;
{$EXTERNALSYM MonthCal_GetCalendarGridInfo}
function MonthCal_GetCalendarGridInfo(hmc: HWND; pmcGridInfo: PMCGridInfo): BOOL; inline;
{$EXTERNALSYM MonthCal_GetCALID}
function MonthCal_GetCALID(hmc: HWND): CALID; inline;
{$EXTERNALSYM MonthCal_SetCALID}
procedure MonthCal_SetCALID(hmc: HWND; calid: CALID); inline;
// Returns the min rect that will fit the max number of calendars for the passed in rect.
{$EXTERNALSYM MonthCal_SizeRectToMin}
procedure MonthCal_SizeRectToMin(hmc: HWND; prc: PRect); inline;
{$EXTERNALSYM MonthCal_SetCalendarBorder}
procedure MonthCal_SetCalendarBorder(hmc: HWND; fset: BOOL; xyborder: Integer); inline;
{$EXTERNALSYM MonthCal_GetCalendarBorder}
function MonthCal_GetCalendarBorder(hmc: HWND): Integer; inline;
{$EXTERNALSYM MonthCal_SetCurrentView}
function MonthCal_SetCurrentView(hmc: HWND; dwNewView: DWORD): BOOL; inline;

{$ENDREGION}

{ ====== DATETIMEPICK CONTROL =============== }

const
  {$EXTERNALSYM DATETIMEPICK_CLASS}
  DATETIMEPICK_CLASS = 'SysDateTimePick32';

  // Message constants
  {$EXTERNALSYM DTM_FIRST}
  DTM_FIRST         = $1000;
  {$EXTERNALSYM DTM_GETSYSTEMTIME}
  DTM_GETSYSTEMTIME = DTM_FIRST + 1;
  {$EXTERNALSYM DTM_SETSYSTEMTIME}
  DTM_SETSYSTEMTIME = DTM_FIRST + 2;
  {$EXTERNALSYM DTM_GETRANGE}
  DTM_GETRANGE      = DTM_FIRST + 3;
  {$EXTERNALSYM DTM_SETRANGE}
  DTM_SETRANGE      = DTM_FIRST + 4;
  {$EXTERNALSYM DTM_SETFORMATA}
  DTM_SETFORMATA    = DTM_FIRST + 5;
  {$EXTERNALSYM DTM_SETMCCOLOR}
  DTM_SETMCCOLOR    = DTM_FIRST + 6;
  {$EXTERNALSYM DTM_GETMCCOLOR}
  DTM_GETMCCOLOR    = DTM_FIRST + 7;
  {$EXTERNALSYM DTM_GETMONTHCAL}
  DTM_GETMONTHCAL   = DTM_FIRST + 8;
  {$EXTERNALSYM DTM_SETMCFONT}
  DTM_SETMCFONT     = DTM_FIRST + 9;
  {$EXTERNALSYM DTM_GETMCFONT}
  DTM_GETMCFONT     = DTM_FIRST + 10;
  {$EXTERNALSYM DTM_SETFORMATW}
  DTM_SETFORMATW    = DTM_FIRST + 50;
{$IFDEF UNICODE}
  {$EXTERNALSYM DTM_SETFORMAT}
  DTM_SETFORMAT     = DTM_SETFORMATW;
{$ELSE}
  {$EXTERNALSYM DTM_SETFORMAT}
  DTM_SETFORMAT     = DTM_SETFORMATA;
{$ENDIF}

  // Style Flags
  {$EXTERNALSYM DTS_UPDOWN}
  DTS_UPDOWN          = $0001;  // use UPDOWN instead of MONTHCAL
  {$EXTERNALSYM DTS_SHOWNONE}
  DTS_SHOWNONE        = $0002;  // allow a NONE selection
  {$EXTERNALSYM DTS_SHORTDATEFORMAT}
  DTS_SHORTDATEFORMAT = $0000;  // use the short date format
                                // (app must forward WM_WININICHANGE messages)
  {$EXTERNALSYM DTS_LONGDATEFORMAT}
  DTS_LONGDATEFORMAT  = $0004;  // use the long date format
                                // (app must forward WM_WININICHANGE messages)
  {$EXTERNALSYM DTS_TIMEFORMAT}
  DTS_TIMEFORMAT      = $0009;  // use the time format
                                // (app must forward WM_WININICHANGE messages)
  {$EXTERNALSYM DTS_APPCANPARSE}
  DTS_APPCANPARSE     = $0010;  // allow user entered strings
                                // (app MUST respond to DTN_USERSTRING)
  {$EXTERNALSYM DTS_RIGHTALIGN}
  DTS_RIGHTALIGN      = $0020;  // right-align popup instead of left-align it

  // Notification codes
  {$EXTERNALSYM DTN_DATETIMECHANGE}
  DTN_DATETIMECHANGE = DTN_FIRST2 - 6;  // the systemtime has changed, -759
  {$EXTERNALSYM DTN_USERSTRINGA}
  DTN_USERSTRINGA    = DTN_FIRST2 - 5;  // the user has entered a string, -758
  {$EXTERNALSYM DTN_USERSTRINGW}
  DTN_USERSTRINGW    = DTN_FIRST - 5;   // -745
  {$EXTERNALSYM DTN_WMKEYDOWNA}
  DTN_WMKEYDOWNA     = DTN_FIRST2 - 4;  // modify keydown on app format field (X), -757
  {$EXTERNALSYM DTN_WMKEYDOWNW}
  DTN_WMKEYDOWNW     = DTN_FIRST - 4;   // -744
  {$EXTERNALSYM DTN_FORMATA}
  DTN_FORMATA        = DTN_FIRST2 - 3;  // query display for app format field (X), -756
  {$EXTERNALSYM DTN_FORMATW}
  DTN_FORMATW        = DTN_FIRST - 3;   // -743
  {$EXTERNALSYM DTN_FORMATQUERYA}
  DTN_FORMATQUERYA   = DTN_FIRST2 - 2;  // query formatting info for app format field (X)
  {$EXTERNALSYM DTN_FORMATQUERYW}
  DTN_FORMATQUERYW   = DTN_FIRST - 2;   // -742
  {$EXTERNALSYM DTN_DROPDOWN}
  DTN_DROPDOWN       = DTN_FIRST2 - 1;  // MonthCal has dropped down, -754
  {$EXTERNALSYM DTN_CLOSEUP}
  DTN_CLOSEUP        = DTN_FIRST2;      // MonthCal is popping up, -753
{$IFDEF UNICODE}
  {$EXTERNALSYM DTN_USERSTRING}
  DTN_USERSTRING     = DTN_USERSTRINGW;
  {$EXTERNALSYM DTN_WMKEYDOWN}
  DTN_WMKEYDOWN      = DTN_WMKEYDOWNW;
  {$EXTERNALSYM DTN_FORMAT}
  DTN_FORMAT         = DTN_FORMATW;
  {$EXTERNALSYM DTN_FORMATQUERY}
  DTN_FORMATQUERY    = DTN_FORMATQUERYW;
{$ELSE}
  {$EXTERNALSYM DTN_USERSTRING}
  DTN_USERSTRING     = DTN_USERSTRINGA;
  {$EXTERNALSYM DTN_WMKEYDOWN}
  DTN_WMKEYDOWN      = DTN_WMKEYDOWNA;
  {$EXTERNALSYM DTN_FORMAT}
  DTN_FORMAT         = DTN_FORMATA;
  {$EXTERNALSYM DTN_FORMATQUERY}
  DTN_FORMATQUERY    = DTN_FORMATQUERYA;
{$ENDIF}

  // Ranges
  {$EXTERNALSYM GDTR_MIN}
  GDTR_MIN = $0001;
  {$EXTERNALSYM GDTR_MAX}
  GDTR_MAX = $0002;

  // Return Values
  {$EXTERNALSYM GDT_ERROR}
  GDT_ERROR = -1;
  {$EXTERNALSYM GDT_VALID}
  GDT_VALID = 0;
  {$EXTERNALSYM GDT_NONE}
  GDT_NONE  = 1;

type
  {$EXTERNALSYM tagNMDATETIMECHANGE}
  tagNMDATETIMECHANGE = record
    nmhdr: TNmHdr;
    dwFlags: DWORD;         // GDT_VALID or GDT_NONE
    st: TSystemTime;        // valid if dwFlags = GDT_VALID
  end;
  PNMDateTimeChange = ^TNMDateTimeChange;
  TNMDateTimeChange = tagNMDATETIMECHANGE;

  {$EXTERNALSYM tagNMDATETIMESTRINGA}
  tagNMDATETIMESTRINGA = record
    nmhdr: TNmHdr;
    pszUserString: LPSTR;     // AnsiString user entered
    st: TSystemTime;           // app fills this in
    dwFlags: DWORD;            // GDT_VALID or GDT_NONE
  end;
  {$EXTERNALSYM tagNMDATETIMESTRINGW}
  tagNMDATETIMESTRINGW = record
    nmhdr: TNmHdr;
    pszUserString: LPWSTR;     // UnicodeString user entered
    st: TSystemTime;           // app fills this in
    dwFlags: DWORD;            // GDT_VALID or GDT_NONE
  end;
  {$EXTERNALSYM tagNMDATETIMESTRING}
  tagNMDATETIMESTRING = tagNMDATETIMESTRINGW;
  PNMDateTimeStringA = ^TNMDateTimeStringA;
  PNMDateTimeStringW = ^TNMDateTimeStringW;
  PNMDateTimeString = PNMDateTimeStringW;
  TNMDateTimeStringA = tagNMDATETIMESTRINGA;
  TNMDateTimeStringW = tagNMDATETIMESTRINGW;
  TNMDateTimeString = TNMDateTimeStringW;

  {$EXTERNALSYM tagNMDATETIMEWMKEYDOWNA}
  tagNMDATETIMEWMKEYDOWNA = record
    nmhdr: TNmHdr;
    nVirtKey: Integer; // virtual key code of WM_KEYDOWN which MODIFIES an X field
    pszFormat: LPSTR; // format substring
    st: TSystemTime;   // current systemtime, app should modify based on key
  end;
  {$EXTERNALSYM tagNMDATETIMEWMKEYDOWNW}
  tagNMDATETIMEWMKEYDOWNW = record
    nmhdr: TNmHdr;
    nVirtKey: Integer; // virtual key code of WM_KEYDOWN which MODIFIES an X field
    pszFormat: LPWSTR; // format substring
    st: TSystemTime;   // current systemtime, app should modify based on key
  end;
  {$EXTERNALSYM tagNMDATETIMEWMKEYDOWN}
  tagNMDATETIMEWMKEYDOWN = tagNMDATETIMEWMKEYDOWNW;
  PNMDateTimeWMKeyDownA = ^TNMDateTimeWMKeyDownA;
  PNMDateTimeWMKeyDownW = ^TNMDateTimeWMKeyDownW;
  PNMDateTimeWMKeyDown = PNMDateTimeWMKeyDownW;
  TNMDateTimeWMKeyDownA = tagNMDATETIMEWMKEYDOWNA;
  TNMDateTimeWMKeyDownW = tagNMDATETIMEWMKEYDOWNW;
  TNMDateTimeWMKeyDown = TNMDateTimeWMKeyDownW;

  {$EXTERNALSYM tagNMDATETIMEFORMATA}
  tagNMDATETIMEFORMATA = record
    nmhdr: TNmHdr;
    pszFormat: LPSTR;                // format substring
    st: TSystemTime;                  // current systemtime
    pszDisplay: LPSTR;               // AnsiString to display
    szDisplay: array[0..63] of AnsiChar; // buffer pszDisplay originally points at
  end;
  {$EXTERNALSYM tagNMDATETIMEFORMATW}
  tagNMDATETIMEFORMATW = record
    nmhdr: TNmHdr;
    pszFormat: LPWSTR;                // format substring
    st: TSystemTime;                  // current systemtime
    pszDisplay: LPWSTR;               // UnicodeString to display
    szDisplay: array[0..63] of WideChar; // buffer pszDisplay originally points at
  end;
  {$EXTERNALSYM tagNMDATETIMEFORMAT}
  tagNMDATETIMEFORMAT = tagNMDATETIMEFORMATW;
  PNMDateTimeFormatA = ^TNMDateTimeFormatA;
  PNMDateTimeFormatW = ^TNMDateTimeFormatW;
  PNMDateTimeFormat = PNMDateTimeFormatW;
  TNMDateTimeFormatA = tagNMDATETIMEFORMATA;
  TNMDateTimeFormatW = tagNMDATETIMEFORMATW;
  TNMDateTimeFormat = TNMDateTimeFormatW;

  {$EXTERNALSYM tagNMDATETIMEFORMATQUERYA}
  tagNMDATETIMEFORMATQUERYA = record
    nmhdr: TNmHdr;
    pszFormat: LPSTR; // format substring
    szMax: TSize;      // max bounding rectangle app will use for this format AnsiString
  end;
  {$EXTERNALSYM tagNMDATETIMEFORMATQUERYW}
  tagNMDATETIMEFORMATQUERYW = record
    nmhdr: TNmHdr;
    pszFormat: LPWSTR; // format substring
    szMax: TSize;      // max bounding rectangle app will use for this format UnicodeString
  end;
  {$EXTERNALSYM tagNMDATETIMEFORMATQUERY}
  tagNMDATETIMEFORMATQUERY = tagNMDATETIMEFORMATQUERYW;
  PNMDateTimeFormatQueryA = ^TNMDateTimeFormatQueryA;
  PNMDateTimeFormatQueryW = ^TNMDateTimeFormatQueryW;
  PNMDateTimeFormatQuery = PNMDateTimeFormatQueryW;
  TNMDateTimeFormatQueryA = tagNMDATETIMEFORMATQUERYA;
  TNMDateTimeFormatQueryW = tagNMDATETIMEFORMATQUERYW;
  TNMDateTimeFormatQuery = TNMDateTimeFormatQueryW;

//   returns GDT_NONE if "none" is selected (DTS_SHOWNONE only)
//   returns GDT_VALID and modifies pst to be the currently selected value
{$EXTERNALSYM DateTime_GetSystemTime}
function DateTime_GetSystemTime(hdp: HWND; var pst: TSystemTime): DWORD; inline;

//   if gd = GDT_NONE, sets datetimepick to None (DTS_SHOWNONE only)
//   if gd = GDT_VALID, sets datetimepick to pst
//   returns TRUE on success, FALSE on error (such as bad params)
{$EXTERNALSYM DateTime_SetSystemTime}
function DateTime_SetSystemTime(hdp: HWND; gd: DWORD; const pst: TSystemTime): BOOL; inline;

//   modifies rgst[0] to be the minimum ALLOWABLE systemtime (or 0 if no minimum)
//   modifies rgst[1] to be the maximum ALLOWABLE systemtime (or 0 if no maximum)
//   returns GDTR_MIN or GDTR_MAX if there is a minimum or maximum limit
{$EXTERNALSYM DateTime_GetRange}
function DateTime_GetRange(hdp: HWND; rgst: PSystemTime): DWORD; inline;

//   if GDTR_MIN, sets the minimum ALLOWABLE systemtime to rgst[0], otherwise removes minimum
//   if GDTR_MAX, sets the maximum ALLOWABLE systemtime to rgst[1], otherwise removes maximum
//   returns TRUE on success, FALSE on error (such as invalid parameters)
{$EXTERNALSYM DateTime_SetRange}
function DateTime_SetRange(hdp: HWND; gdtr: DWORD; rgst: PSystemTime): BOOL; inline;

//   sets the display formatting string to sz (see GetDateFormat and GetTimeFormat for valid formatting chars)
//   NOTE: 'X' is a valid formatting character which indicates that the application
//   will determine how to display information. Such apps must support DTN_WMKEYDOWN,
//   DTN_FORMAT, and DTN_FORMATQUERY.
{$EXTERNALSYM DateTime_SetFormat}
function DateTime_SetFormat(hdp: HWND; sz: LPWSTR): BOOL; overload; inline;
{$EXTERNALSYM DateTime_SetFormatA}
function DateTime_SetFormatA(hdp: HWND; sz: LPSTR): BOOL; overload; inline;
{$EXTERNALSYM DateTime_SetFormatW}
function DateTime_SetFormatW(hdp: HWND; sz: LPWSTR): BOOL; overload; inline;
{$EXTERNALSYM DateTime_SetFormat}
function DateTime_SetFormat(hdp: HWND; const sz: UnicodeString): BOOL; overload; inline;
{$EXTERNALSYM DateTime_SetFormatA}
function DateTime_SetFormatA(hdp: HWND; const sz: AnsiString): BOOL; overload; inline;
{$EXTERNALSYM DateTime_SetFormatW}
function DateTime_SetFormatW(hdp: HWND; const sz: UnicodeString): BOOL; overload; inline;

{$EXTERNALSYM DateTime_SetMonthCalColor}
function DateTime_SetMonthCalColor(hdp: HWND; iColor: DWORD; clr: TColorRef): TColorRef; inline;

{$EXTERNALSYM DateTime_GetMonthCalColor}
function DateTime_GetMonthCalColor(hdp: HWND; iColor: DWORD): TColorRef; inline;

// returns the HWND of the MonthCal popup window. Only valid
// between DTN_DROPDOWN and DTN_CLOSEUP notifications.
{$EXTERNALSYM DateTime_GetMonthCal}
function DateTime_GetMonthCal(hdp: HWND): HWND; inline;

{$EXTERNALSYM DateTime_SetMonthCalFont}
procedure DateTime_SetMonthCalFont(hdp: HWND; hfont: HFONT; fRedraw: BOOL); inline;

{$EXTERNALSYM DateTime_GetMonthCalFont}
function DateTime_GetMonthCalFont(hdp: HWND): HFONT; inline;

{$REGION 'For NTDDI_VERSION >= NTDDI_VISTA'}
type
  {$EXTERNALSYM tagDATETIMEPICKERINFO}
  tagDATETIMEPICKERINFO = record
    cbSize: DWORD;

    rcCheck: TRect;
    stateCheck: DWORD;

    rcButton: TRect;
    stateButton: DWORD;

    hwndEdit: HWND;
    hwndUD: HWND;
    hwndDropDown: HWND;
  end;
  PDateTimePickerInfo = ^TDateTimePickerInfo;
  TDateTimePickerInfo = tagDATETIMEPICKERINFO;

const
  {$EXTERNALSYM DTM_SETMCSTYLE}
  DTM_SETMCSTYLE            = DTM_FIRST + 11;
  {$EXTERNALSYM DTM_GETMCSTYLE}
  DTM_GETMCSTYLE            = DTM_FIRST + 12;
  {$EXTERNALSYM DTM_CLOSEMONTHCAL}
  DTM_CLOSEMONTHCAL         = DTM_FIRST + 13;
  {$EXTERNALSYM DTM_GETDATETIMEPICKERINFO}
  DTM_GETDATETIMEPICKERINFO = DTM_FIRST + 14;
  {$EXTERNALSYM DTM_GETIDEALSIZE}
  DTM_GETIDEALSIZE          = DTM_FIRST + 15;

{$EXTERNALSYM DateTime_SetMonthCalStyle}
procedure DateTime_SetMonthCalStyle(hdp: HWND; dwStyle: DWORD); inline;
{$EXTERNALSYM DateTime_GetMonthCalStyle}
function DateTime_GetMonthCalStyle(hdp: HWND): DWORD; inline;
{$EXTERNALSYM DateTime_CloseMonthCal}
procedure DateTime_CloseMonthCal(hdp: HWND); inline;
// DateTime_GetDateTimePickerInfo(HWND hdp, DATETIMEPICKERINFO* pdtpi)
// Retrieves information about the selected date time picker.
{$EXTERNALSYM DateTime_GetDateTimePickerInfo}
procedure DateTime_GetDateTimePickerInfo(hdp: HWND; var pdtpi: TDateTimePickerInfo); inline;
{$EXTERNALSYM DateTime_GetIdealSize}
function DateTime_GetIdealSize(hdp: HWND; var psize: TSize): BOOL; inline;

{$ENDREGION}

{  ====================== IP Address edit control ============================= }

const
  {$EXTERNALSYM WC_IPADDRESS}
  WC_IPADDRESS         = 'SysIPAddress32';

  // Messages sent to IPAddress controls
  {$EXTERNALSYM IPM_CLEARADDRESS}
  IPM_CLEARADDRESS     = WM_USER+100;  { no parameters }
  {$EXTERNALSYM IPM_SETADDRESS}
  IPM_SETADDRESS       = WM_USER+101;  { lparam = TCP/IP address }
  {$EXTERNALSYM IPM_GETADDRESS}
  IPM_GETADDRESS       = WM_USER+102;  { lresult = # of non black fields.  lparam = LPDWORD for TCP/IP address }
  {$EXTERNALSYM IPM_SETRANGE}
  IPM_SETRANGE         = WM_USER+103;  { wparam = field, lparam = range }
  {$EXTERNALSYM IPM_SETFOCUS}
  IPM_SETFOCUS         = WM_USER+104;  { wparam = field }
  {$EXTERNALSYM IPM_ISBLANK}
  IPM_ISBLANK          = WM_USER+105;  { no parameters }

  {$EXTERNALSYM IPN_FIELDCHANGED}
  IPN_FIELDCHANGED     = IPN_FIRST - 0;

type
  {$EXTERNALSYM tagNMIPADDRESS}
  tagNMIPADDRESS = record
    hdr: NMHDR;
    iField: Integer;
    iValue: Integer;
  end;
  PNMIPAddress = ^TNMIPAddress;
  TNMIPAddress = tagNMIPADDRESS;

{ The following is a useful macro for passing the range values in the }
{ IPM_SETRANGE message. }
{$EXTERNALSYM MAKEIPRANGE}
function MAKEIPRANGE(low, high: Byte): LPARAM; inline;

{ And this is a useful macro for making the IP Address to be passed }
{ as a LPARAM. }
{$EXTERNALSYM MAKEIPADDRESS}
function MAKEIPADDRESS(b1, b2, b3, b4: DWORD): LPARAM;

{ Get individual number }
{$EXTERNALSYM FIRST_IPADDRESS}
function FIRST_IPADDRESS(x: DWORD): DWORD; inline;

{$EXTERNALSYM SECOND_IPADDRESS}
function SECOND_IPADDRESS(x: DWORD): DWORD; inline;

{$EXTERNALSYM THIRD_IPADDRESS}
function THIRD_IPADDRESS(x: DWORD): DWORD; inline;

{$EXTERNALSYM FOURTH_IPADDRESS}
function FOURTH_IPADDRESS(x: DWORD): DWORD; inline;

{  ====================== Pager Control ============================= }

const
  { Pager Class Name }
  {$EXTERNALSYM WC_PAGESCROLLER}
  WC_PAGESCROLLER               = 'SysPager';

  { Pager Control Styles }
  {$EXTERNALSYM PGS_VERT}
  PGS_VERT                    = $00000000;
  {$EXTERNALSYM PGS_HORZ}
  PGS_HORZ                    = $00000001;
  {$EXTERNALSYM PGS_AUTOSCROLL}
  PGS_AUTOSCROLL              = $00000002;
  {$EXTERNALSYM PGS_DRAGNDROP}
  PGS_DRAGNDROP               = $00000004;

  { Pager Button State }
  { The scroll can be in one of the following control State }
  {$EXTERNALSYM PGF_INVISIBLE}
  PGF_INVISIBLE        = 0;     { Scroll button is not visible }
  {$EXTERNALSYM PGF_NORMAL}
  PGF_NORMAL           = 1;     { Scroll button is in normal state }
  {$EXTERNALSYM PGF_GRAYED}
  PGF_GRAYED           = 2;     { Scroll button is in grayed state }
  {$EXTERNALSYM PGF_DEPRESSED}
  PGF_DEPRESSED        = 4;     { Scroll button is in depressed state }
  {$EXTERNALSYM PGF_HOT}
  PGF_HOT              = 8;     { Scroll button is in hot state }

  { The following identifiers specifies the button control }
  {$EXTERNALSYM PGB_TOPORLEFT}
  PGB_TOPORLEFT           = 0;
  {$EXTERNALSYM PGB_BOTTOMORRIGHT}
  PGB_BOTTOMORRIGHT       = 1;

  { Pager Control  Messages }
  {$EXTERNALSYM PGM_SETCHILD}
  PGM_SETCHILD                = PGM_FIRST + 1;   { lParam == hwnd }
  {$EXTERNALSYM PGM_RECALCSIZE}
  PGM_RECALCSIZE              = PGM_FIRST + 2;
  {$EXTERNALSYM PGM_FORWARDMOUSE}
  PGM_FORWARDMOUSE            = PGM_FIRST + 3;
  {$EXTERNALSYM PGM_SETBKCOLOR}
  PGM_SETBKCOLOR              = PGM_FIRST + 4;
  {$EXTERNALSYM PGM_GETBKCOLOR}
  PGM_GETBKCOLOR              = PGM_FIRST + 5;
  {$EXTERNALSYM PGM_SETBORDER}
  PGM_SETBORDER              = PGM_FIRST + 6;
  {$EXTERNALSYM PGM_GETBORDER}
  PGM_GETBORDER              = PGM_FIRST + 7;
  {$EXTERNALSYM PGM_SETPOS}
  PGM_SETPOS                  = PGM_FIRST + 8;
  {$EXTERNALSYM PGM_GETPOS}
  PGM_GETPOS                  = PGM_FIRST + 9;
  {$EXTERNALSYM PGM_SETBUTTONSIZE}
  PGM_SETBUTTONSIZE           = PGM_FIRST + 10;
  {$EXTERNALSYM PGM_GETBUTTONSIZE}
  PGM_GETBUTTONSIZE           = PGM_FIRST + 11;
  {$EXTERNALSYM PGM_GETBUTTONSTATE}
  PGM_GETBUTTONSTATE          = PGM_FIRST + 12;
  {$EXTERNALSYM PGM_GETDROPTARGET}
  PGM_GETDROPTARGET           = CCM_GETDROPTARGET;

{$EXTERNALSYM Pager_SetChild}
procedure Pager_SetChild(hwnd: HWND; hwndChild: HWND); inline;
{$EXTERNALSYM Pager_RecalcSize}
procedure Pager_RecalcSize(hwnd: HWND); inline;
{$EXTERNALSYM Pager_ForwardMouse}
procedure Pager_ForwardMouse(hwnd: HWND; bForward: BOOL); inline;
{$EXTERNALSYM Pager_SetBkColor}
function Pager_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF; inline;
{$EXTERNALSYM Pager_GetBkColor}
function Pager_GetBkColor(hwnd: HWND): COLORREF; inline;
{$EXTERNALSYM Pager_SetBorder}
function Pager_SetBorder(hwnd: HWND; iBorder: Integer): Integer; inline;
{$EXTERNALSYM Pager_GetBorder}
function Pager_GetBorder(hwnd: HWND): Integer; inline;
{$EXTERNALSYM Pager_SetPos}
function Pager_SetPos(hwnd: HWND; iPos: Integer): Integer; inline;
{$EXTERNALSYM Pager_GetPos}
function Pager_GetPos(hwnd: HWND): Integer; inline;
{$EXTERNALSYM Pager_SetButtonSize}
function Pager_SetButtonSize(hwnd: HWND; iSize: Integer): Integer; inline;
{$EXTERNALSYM Pager_GetButtonSize}
function Pager_GetButtonSize(hwnd: HWND): Integer; inline;
{$EXTERNALSYM Pager_GetButtonState}
function Pager_GetButtonState(hwnd: HWND; iButton: Integer): DWORD; inline;
{$EXTERNALSYM Pager_GetDropTarget}
procedure Pager_GetDropTarget(hwnd: HWND; ppdt: Pointer{!!}); inline;

const
  { Pager Control Notification Messages }

  { PGN_SCROLL Notification Message }
  {$EXTERNALSYM PGN_SCROLL}
  PGN_SCROLL              = PGN_FIRST-1;

  {$EXTERNALSYM PGF_SCROLLUP}
  PGF_SCROLLUP            = 1;
  {$EXTERNALSYM PGF_SCROLLDOWN}
  PGF_SCROLLDOWN          = 2;
  {$EXTERNALSYM PGF_SCROLLLEFT}
  PGF_SCROLLLEFT          = 4;
  {$EXTERNALSYM PGF_SCROLLRIGHT}
  PGF_SCROLLRIGHT         = 8;

  { Keys down }
  {$EXTERNALSYM PGK_SHIFT}
  PGK_SHIFT               = 1;
  {$EXTERNALSYM PGK_CONTROL}
  PGK_CONTROL             = 2;
  {$EXTERNALSYM PGK_MENU}
  PGK_MENU                = 4;

{$ALIGN 1}
type
  { This structure is sent along with PGN_SCROLL notifications }
  {$EXTERNALSYM NMPGSCROLL}
  NMPGSCROLL = record
    hdr: NMHDR;
    fwKeys: Word;           { Specifies which keys are down when this notification is send }
    rcParent: TRect;        { Contains Parent Window Rect }
    iDir: Integer;          { Scrolling Direction }
    iXpos: Integer;         { Horizontal scroll position }
    iYpos: Integer;         { Vertical scroll position }
    iScroll: Integer;       { [in/out] Amount to scroll }
  end;
  PNMPGScroll = ^TNMPGScroll;
  TNMPGScroll = NMPGSCROLL;
{$ALIGN ON}

const
  { PGN_CALCSIZE Notification Message }
  {$EXTERNALSYM PGN_CALCSIZE}
  PGN_CALCSIZE            = PGN_FIRST-2;

  {$EXTERNALSYM PGF_CALCWIDTH}
  PGF_CALCWIDTH           = 1;
  {$EXTERNALSYM PGF_CALCHEIGHT}
  PGF_CALCHEIGHT          = 2;

type
  {$EXTERNALSYM NMPGCALCSIZE}
  NMPGCALCSIZE = record
    hdr: NMHDR;
    dwFlag: DWORD;
    iWidth: Integer;
    iHeight: Integer;
  end;
  PNMPGCalcSize = ^TNMPGCalcSize;
  TNMPGCalcSize = NMPGCALCSIZE;

{ ======================  Native Font Control ============================== }

const
  {$EXTERNALSYM WC_NATIVEFONTCTL}
  WC_NATIVEFONTCTL            = 'NativeFontCtl';

  { style definition }
  {$EXTERNALSYM NFS_EDIT}
  NFS_EDIT                    = $0001;
  {$EXTERNALSYM NFS_STATIC}
  NFS_STATIC                  = $0002;
  {$EXTERNALSYM NFS_LISTCOMBO}
  NFS_LISTCOMBO               = $0004;
  {$EXTERNALSYM NFS_BUTTON}
  NFS_BUTTON                  = $0008;
  {$EXTERNALSYM NFS_ALL}
  NFS_ALL                     = $0010;
  {$EXTERNALSYM NFS_USEFONTASSOC}
  NFS_USEFONTASSOC            = $0020;

// ====================== Button Control =============================

// Button Class Name
const
  {$EXTERNALSYM WC_BUTTON}
  WC_BUTTON               = 'Button';


// *** The following Button control declarations require Windows >= XP ***


  {$EXTERNALSYM BUTTON_IMAGELIST_ALIGN_LEFT}
  BUTTON_IMAGELIST_ALIGN_LEFT     = 0;
  {$EXTERNALSYM BUTTON_IMAGELIST_ALIGN_RIGHT}
  BUTTON_IMAGELIST_ALIGN_RIGHT    = 1;
  {$EXTERNALSYM BUTTON_IMAGELIST_ALIGN_TOP}
  BUTTON_IMAGELIST_ALIGN_TOP      = 2;
  {$EXTERNALSYM BUTTON_IMAGELIST_ALIGN_BOTTOM}
  BUTTON_IMAGELIST_ALIGN_BOTTOM   = 3;
  {$EXTERNALSYM BUTTON_IMAGELIST_ALIGN_CENTER}
  BUTTON_IMAGELIST_ALIGN_CENTER   = 4;      // Doesn't draw text

type
  { $EXTERNALSYM BUTTON_IMAGELIST}
  BUTTON_IMAGELIST = record
    himl: HIMAGELIST;   // Images: Normal, Hot, Pushed, Disabled. If count is less than 4, we use index 1
    margin: TRect;      // Margin around icon.
    uAlign: UINT;
  end;
  PButtonImageList = ^TButtonImageList;
  TButtonImageList = BUTTON_IMAGELIST;

const
  {$EXTERNALSYM BCM_GETIDEALSIZE}
  BCM_GETIDEALSIZE        = BCM_FIRST + $0001; 
  {$EXTERNALSYM BCM_SETIMAGELIST}
  BCM_SETIMAGELIST        = BCM_FIRST + $0002;
  {$EXTERNALSYM BCM_GETIMAGELIST}
  BCM_GETIMAGELIST        = BCM_FIRST + $0003;
  {$EXTERNALSYM BCM_SETTEXTMARGIN}
  BCM_SETTEXTMARGIN       = BCM_FIRST + $0004;
  {$EXTERNALSYM BCM_GETTEXTMARGIN}
  BCM_GETTEXTMARGIN       = BCM_FIRST + $0005;

{$EXTERNALSYM Button_GetIdealSize}
function Button_GetIdealSize(hwnd: HWND; var psize: TSize): BOOL; inline;
{$EXTERNALSYM Button_SetImageList}
function Button_SetImageList(hwnd: HWND; const pbuttonImagelist: TButtonImageList): BOOL; inline;
{$EXTERNALSYM Button_GetImageList}
function Button_GetImageList(hwnd: HWND; var pbuttonImagelist: TButtonImageList): BOOL; inline;
{$EXTERNALSYM Button_SetTextMargin}
function Button_SetTextMargin(hwnd: HWND; const pmargin: TRect): BOOL; inline;
{$EXTERNALSYM Button_GetTextMargin}
function Button_GetTextMargin(hwnd: HWND; var pmargin: TRect): BOOL; inline;

type
  { $EXTERNALSYM tagNMBCHOTITEM}
  tagNMBCHOTITEM = record
    hdr: NMHDR;
    dwFlags: DWORD;            // HICF_*
  end;
  PNMBCHotItem = ^TNMBCHotItem;
  TNMBCHotItem = tagNMBCHOTITEM;

const
  {$EXTERNALSYM BCN_HOTITEMCHANGE}
  BCN_HOTITEMCHANGE       = BCN_FIRST + $0001;

  {$EXTERNALSYM BST_HOT}
  BST_HOT                 = $0200;


// *** The following Button control declarations require Windows >= Vista ***


// BUTTON STATE FLAGS
  {$EXTERNALSYM BST_DROPDOWNPUSHED}
  BST_DROPDOWNPUSHED      = $0400;

// BUTTON STYLES
  {$EXTERNALSYM BS_SPLITBUTTON}
  BS_SPLITBUTTON          = $0000000C;
  {$EXTERNALSYM BS_DEFSPLITBUTTON}
  BS_DEFSPLITBUTTON       = $0000000D;
  {$EXTERNALSYM BS_COMMANDLINK}
  BS_COMMANDLINK          = $0000000E;
  {$EXTERNALSYM BS_DEFCOMMANDLINK}
  BS_DEFCOMMANDLINK       = $0000000F;

// SPLIT BUTTON INFO mask flags
  {$EXTERNALSYM BCSIF_GLYPH}
  BCSIF_GLYPH             = $0001;
  {$EXTERNALSYM BCSIF_IMAGE}
  BCSIF_IMAGE             = $0002;
  {$EXTERNALSYM BCSIF_STYLE}
  BCSIF_STYLE             = $0004;
  {$EXTERNALSYM BCSIF_SIZE}
  BCSIF_SIZE              = $0008;

// SPLIT BUTTON STYLE flags
  {$EXTERNALSYM BCSS_NOSPLIT}
  BCSS_NOSPLIT            = $0001;
  {$EXTERNALSYM BCSS_STRETCH}
  BCSS_STRETCH            = $0002;
  {$EXTERNALSYM BCSS_ALIGNLEFT}
  BCSS_ALIGNLEFT          = $0004;
  {$EXTERNALSYM BCSS_IMAGE}
  BCSS_IMAGE              = $0008;

// BUTTON STRUCTURES
type
  { $EXTERNALSYM tagBUTTON_SPLITINFO}
  tagBUTTON_SPLITINFO = record
    mask: UINT;
    himlGlyph: HIMAGELIST;         // interpreted as WCHAR if BCSIF_GLYPH is set
    uSplitStyle: UINT;
    size: SIZE;
  end;
  PButtonSplitinfo = ^TButtonSplitinfo;
  TButtonSplitinfo = tagBUTTON_SPLITINFO;

// BUTTON MESSAGES
const
  {$EXTERNALSYM BCM_SETDROPDOWNSTATE}
  BCM_SETDROPDOWNSTATE     = BCM_FIRST + $0006;
  {$EXTERNALSYM BCM_SETSPLITINFO}
  BCM_SETSPLITINFO         = BCM_FIRST + $0007;
  {$EXTERNALSYM BCM_GETSPLITINFO}
  BCM_GETSPLITINFO         = BCM_FIRST + $0008;
  {$EXTERNALSYM BCM_SETNOTE}
  BCM_SETNOTE              = BCM_FIRST + $0009;
  {$EXTERNALSYM BCM_GETNOTE}
  BCM_GETNOTE              = BCM_FIRST + $000A;
  {$EXTERNALSYM BCM_GETNOTELENGTH}
  BCM_GETNOTELENGTH        = BCM_FIRST + $000B;
  {$EXTERNALSYM BCM_SETSHIELD}
  BCM_SETSHIELD            = BCM_FIRST + $000C;

{$EXTERNALSYM Button_SetDropDownState}
function Button_SetDropDownState(hwnd: HWND; fDropDown: BOOL): BOOL; inline;
{$EXTERNALSYM Button_SetSplitInfo}
function Button_SetSplitInfo(hwnd: HWND; const pInfo: TButtonSplitinfo): BOOL; inline;
{$EXTERNALSYM Button_GetSplitInfo}
function Button_GetSplitInfo(hwnd: HWND; var pInfo: TButtonSplitinfo): BOOL; inline;
{$EXTERNALSYM Button_SetNote}
function Button_SetNote(hwnd: HWND; psz: LPCWSTR): BOOL; inline; overload;
{$EXTERNALSYM Button_SetNote}
function Button_SetNote(hwnd: HWND; const psz: UnicodeString): BOOL; inline; overload;
{$EXTERNALSYM Button_GetNote}
function Button_GetNote(hwnd: HWND; psz: LPCWSTR; var pcc: Integer): BOOL; inline;
{$EXTERNALSYM Button_GetNoteLength}
function Button_GetNoteLength(hwnd: HWND): LRESULT; inline;
// Macro to use on a button or command link to display an elevated icon
{$EXTERNALSYM Button_SetElevationRequiredState}
function Button_SetElevationRequiredState(hwnd: HWND; fRequired: BOOL): LRESULT; inline;

// Value to pass to BCM_SETIMAGELIST to indicate that no glyph should be
// displayed
const
  {$EXTERNALSYM BCCL_NOGLYPH}
  BCCL_NOGLYPH  = HIMAGELIST(-1);

// NOTIFICATION MESSAGES
type
  { $EXTERNALSYM tagNMBCDROPDOWN}
  tagNMBCDROPDOWN = record
    hdr: NMHDR;
    rcButton: TRect;
  end;
  PNMBCDropDown = ^TNMBCDropDown;
  TNMBCDropDown = tagNMBCDROPDOWN;

const
  {$EXTERNALSYM BCN_DROPDOWN}
  BCN_DROPDOWN            = BCN_FIRST + $0002;


/// ====================== Edit Control =============================

// Edit Class Name
const
  {$EXTERNALSYM WC_EDIT}
  WC_EDIT                 = 'Edit';


// *** The following Edit control declarations require Windows >= XP ***


const
  {$EXTERNALSYM EM_SETCUEBANNER}
  EM_SETCUEBANNER             = ECM_FIRST + 1;   // Set the cue banner with the lParm = LPCWSTR
  {$EXTERNALSYM EM_GETCUEBANNER}
  EM_GETCUEBANNER             = ECM_FIRST + 2;   // Set the cue banner with the lParm = LPCWSTR

{$EXTERNALSYM Edit_SetCueBannerText}
function Edit_SetCueBannerText(hwnd: HWND; lpwText: LPCWSTR): BOOL; inline;
{$EXTERNALSYM Edit_GetCueBannerText}
function Edit_GetCueBannerText(hwnd: HWND; lpwText: LPCWSTR; cchText: Longint): BOOL; inline;

type
  { $EXTERNALSYM _tagEDITBALLOONTIP}
  _tagEDITBALLOONTIP = record
    cbStruct: DWORD;
    pszTitle: LPCWSTR;
    pszText: LPCWSTR;
    ttiIcon: Integer; // From TTI_*
  end;
  PEditBalloonTip = ^TEditBalloonTip;
  TEditBalloonTip = _tagEDITBALLOONTIP;

const
  {$EXTERNALSYM EM_SHOWBALLOONTIP}
  EM_SHOWBALLOONTIP          = ECM_FIRST + 3;   // Show a balloon tip associated to the edit control
  {$EXTERNALSYM EM_HIDEBALLOONTIP}
  EM_HIDEBALLOONTIP          = ECM_FIRST + 4;   // Hide any balloon tip associated with the edit control

{$EXTERNALSYM Edit_ShowBalloonTip}
function Edit_ShowBalloonTip(hwnd: HWND; const peditballoontip: TEditBalloonTip): BOOL; inline;
{$EXTERNALSYM Edit_HideBalloonTip}
function Edit_HideBalloonTip(hwnd: HWND): BOOL; inline;


// *** The following Edit control declarations require Windows >= Vista ***


const
  {$EXTERNALSYM EM_SETHILITE}
  EM_SETHILITE        = ECM_FIRST + 5;
  {$EXTERNALSYM EM_GETHILITE}
  EM_GETHILITE        = ECM_FIRST + 6;

{$EXTERNALSYM Edit_SetHilite}
procedure Edit_SetHilite(hwndCtl: HWND; ichStart, ichEnd: Integer); inline;
{$EXTERNALSYM Edit_GetHilite}
function Edit_GetHilite(hwndCtl: HWND): LRESULT; inline;


// ====================== Combobox Control =============================


// Combobox Class Name
const
  {$EXTERNALSYM WC_COMBOBOX}
  WC_COMBOBOX             = 'ComboBox';


// *** The following Combobox control declarations require Windows >= Vista ***


// custom combobox control messages
const
  {$EXTERNALSYM CB_SETMINVISIBLE}
  CB_SETMINVISIBLE        = CBM_FIRST + 1;
  {$EXTERNALSYM CB_GETMINVISIBLE}
  CB_GETMINVISIBLE        = CBM_FIRST + 2;
  {$EXTERNALSYM CB_SETCUEBANNER}
  CB_SETCUEBANNER         = CBM_FIRST + 3;
  {$EXTERNALSYM CB_GETCUEBANNER}
  CB_GETCUEBANNER         = CBM_FIRST + 4;

{$EXTERNALSYM ComboBox_SetMinVisible}
function ComboBox_SetMinVisible(hwnd: HWND; iMinVisible: Integer): BOOL; inline;
{$EXTERNALSYM ComboBox_GetMinVisible}
function ComboBox_GetMinVisible(hwnd: HWND): Integer; inline;
{$EXTERNALSYM ComboBox_SetCueBannerText}
function ComboBox_SetCueBannerText(hwnd: HWND; lpcwText: LPCWSTR): BOOL; inline;
{$EXTERNALSYM ComboBox_GetCueBannerText}
function ComboBox_GetCueBannerText(hwnd: HWND; lpwText: LPCWSTR; cchText: Integer): BOOL; inline;


// ===================== Task Dialog =========================


// *** The Task Dialog declarations require Windows >= Vista ***
{$REGION 'For NTDDI_VERSION >= NTDDI_VISTA'}

type
  { $EXTERNALSYM PFTASKDIALOGCALLBACK}
  PFTASKDIALOGCALLBACK = function(hwnd: HWND; msg: UINT; wParam: WPARAM;
    lParam: LPARAM; lpRefData: LONG_PTR): HResult; stdcall;
  TFTaskDialogCallback = PFTASKDIALOGCALLBACK;

const
  { Task Dialog Flags }

  {$EXTERNALSYM TDF_ENABLE_HYPERLINKS}
  TDF_ENABLE_HYPERLINKS               = $0001;
  {$EXTERNALSYM TDF_USE_HICON_MAIN}
  TDF_USE_HICON_MAIN                  = $0002;
  {$EXTERNALSYM TDF_USE_HICON_FOOTER}
  TDF_USE_HICON_FOOTER                = $0004;
  {$EXTERNALSYM TDF_ALLOW_DIALOG_CANCELLATION}
  TDF_ALLOW_DIALOG_CANCELLATION       = $0008;
  {$EXTERNALSYM TDF_USE_COMMAND_LINKS}
  TDF_USE_COMMAND_LINKS               = $0010;
  {$EXTERNALSYM TDF_USE_COMMAND_LINKS_NO_ICON}
  TDF_USE_COMMAND_LINKS_NO_ICON       = $0020;
  {$EXTERNALSYM TDF_EXPAND_FOOTER_AREA}
  TDF_EXPAND_FOOTER_AREA              = $0040;
  {$EXTERNALSYM TDF_EXPANDED_BY_DEFAULT}
  TDF_EXPANDED_BY_DEFAULT             = $0080;
  {$EXTERNALSYM TDF_VERIFICATION_FLAG_CHECKED}
  TDF_VERIFICATION_FLAG_CHECKED       = $0100;
  {$EXTERNALSYM TDF_SHOW_PROGRESS_BAR}
  TDF_SHOW_PROGRESS_BAR               = $0200;
  {$EXTERNALSYM TDF_SHOW_MARQUEE_PROGRESS_BAR}
  TDF_SHOW_MARQUEE_PROGRESS_BAR       = $0400;
  {$EXTERNALSYM TDF_CALLBACK_TIMER}
  TDF_CALLBACK_TIMER                  = $0800;
  {$EXTERNALSYM TDF_POSITION_RELATIVE_TO_WINDOW}
  TDF_POSITION_RELATIVE_TO_WINDOW     = $1000;
  {$EXTERNALSYM TDF_RTL_LAYOUT}
  TDF_RTL_LAYOUT                      = $2000;
  {$EXTERNALSYM TDF_NO_DEFAULT_RADIO_BUTTON}
  TDF_NO_DEFAULT_RADIO_BUTTON         = $4000;
  {$EXTERNALSYM TDF_CAN_BE_MINIMIZED}
  TDF_CAN_BE_MINIMIZED                = $8000;

  { Task Dialog Messages }

  {$EXTERNALSYM TDM_NAVIGATE_PAGE}
  TDM_NAVIGATE_PAGE                   = WM_USER+101;
  {$EXTERNALSYM TDM_CLICK_BUTTON}
  TDM_CLICK_BUTTON                    = WM_USER+102; // wParam = Button ID
  {$EXTERNALSYM TDM_SET_MARQUEE_PROGRESS_BAR}
  TDM_SET_MARQUEE_PROGRESS_BAR        = WM_USER+103; // wParam = 0 (nonMarque) wParam != 0 (Marquee)
  {$EXTERNALSYM TDM_SET_PROGRESS_BAR_STATE}
  TDM_SET_PROGRESS_BAR_STATE          = WM_USER+104; // wParam = new progress state
  {$EXTERNALSYM TDM_SET_PROGRESS_BAR_RANGE}
  TDM_SET_PROGRESS_BAR_RANGE          = WM_USER+105; // lParam = MAKELPARAM(nMinRange, nMaxRange)
  {$EXTERNALSYM TDM_SET_PROGRESS_BAR_POS}
  TDM_SET_PROGRESS_BAR_POS            = WM_USER+106; // wParam = new position
  {$EXTERNALSYM TDM_SET_PROGRESS_BAR_MARQUEE}
  TDM_SET_PROGRESS_BAR_MARQUEE        = WM_USER+107; // wParam = 0 (stop marquee), wParam != 0 (start marquee), lparam = speed (milliseconds between repaints)
  {$EXTERNALSYM TDM_SET_ELEMENT_TEXT}
  TDM_SET_ELEMENT_TEXT                = WM_USER+108; // wParam = element (TASKDIALOG_ELEMENTS), lParam = new element text (LPCWSTR)
  {$EXTERNALSYM TDM_CLICK_RADIO_BUTTON}
  TDM_CLICK_RADIO_BUTTON              = WM_USER+110; // wParam = Radio Button ID
  {$EXTERNALSYM TDM_ENABLE_BUTTON}
  TDM_ENABLE_BUTTON                   = WM_USER+111; // lParam = 0 (disable), lParam != 0 (enable), wParam = Button ID
  {$EXTERNALSYM TDM_ENABLE_RADIO_BUTTON}
  TDM_ENABLE_RADIO_BUTTON             = WM_USER+112; // lParam = 0 (disable), lParam != 0 (enable), wParam = Radio Button ID
  {$EXTERNALSYM TDM_CLICK_VERIFICATION}
  TDM_CLICK_VERIFICATION              = WM_USER+113; // wParam = 0 (unchecked), 1 (checked), lParam = 1 (set key focus)
  {$EXTERNALSYM TDM_UPDATE_ELEMENT_TEXT}
  TDM_UPDATE_ELEMENT_TEXT             = WM_USER+114; // wParam = element (TASKDIALOG_ELEMENTS), lParam = new element text (LPCWSTR)
  {$EXTERNALSYM TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE}
  TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = WM_USER+115; // wParam = Button ID, lParam = 0 (elevation not required), lParam != 0 (elevation required)
  {$EXTERNALSYM TDM_UPDATE_ICON}
  TDM_UPDATE_ICON                     = WM_USER+116; // wParam = icon element (TASKDIALOG_ICON_ELEMENTS), lParam = new icon (hIcon if TDF_USE_HICON_* was set, PCWSTR otherwise)

  { Task Dialog Notifications }

  {$EXTERNALSYM TDN_CREATED}
  TDN_CREATED                = 0;
  {$EXTERNALSYM TDN_NAVIGATED}
  TDN_NAVIGATED              = 1;
  {$EXTERNALSYM TDN_BUTTON_CLICKED}
  TDN_BUTTON_CLICKED         = 2;            // wParam = Button ID
  {$EXTERNALSYM TDN_HYPERLINK_CLICKED}
  TDN_HYPERLINK_CLICKED      = 3;            // lParam = (LPCWSTR)pszHREF
  {$EXTERNALSYM TDN_TIMER}
  TDN_TIMER                  = 4;            // wParam = Milliseconds since dialog created or timer reset
  {$EXTERNALSYM TDN_DESTROYED}
  TDN_DESTROYED              = 5;
  {$EXTERNALSYM TDN_RADIO_BUTTON_CLICKED}
  TDN_RADIO_BUTTON_CLICKED   = 6;            // wParam = Radio Button ID
  {$EXTERNALSYM TDN_DIALOG_CONSTRUCTED}
  TDN_DIALOG_CONSTRUCTED     = 7;
  {$EXTERNALSYM TDN_VERIFICATION_CLICKED}
  TDN_VERIFICATION_CLICKED   = 8;            // wParam = 1 if checkbox checked, 0 if not, lParam is unused and always 0
  {$EXTERNALSYM TDN_HELP}
  TDN_HELP                   = 9;
  {$EXTERNALSYM TDN_EXPANDO_BUTTON_CLICKED}
  TDN_EXPANDO_BUTTON_CLICKED = 10;           // wParam = 0 (dialog is now collapsed), wParam != 0 (dialog is now expanded)

{$ALIGN 1}
type
  { $EXTERNALSYM TASKDIALOG_BUTTON}
  TASKDIALOG_BUTTON = record
    nButtonID: Integer;
    pszButtonText: LPCWSTR;
  end;
  { $EXTERNALSYM _TASKDIALOG_BUTTON}
  _TASKDIALOG_BUTTON = TASKDIALOG_BUTTON;
  PTaskDialogButton = ^TTaskDialogButton;
  TTaskDialogButton = TASKDIALOG_BUTTON;

const
  { Task Dialog Elements }

  {$EXTERNALSYM TDE_CONTENT}
  TDE_CONTENT              = 0;
  {$EXTERNALSYM TDE_EXPANDED_INFORMATION}
  TDE_EXPANDED_INFORMATION = 1;
  {$EXTERNALSYM TDE_FOOTER}
  TDE_FOOTER               = 2;
  {$EXTERNALSYM TDE_MAIN_INSTRUCTION}
  TDE_MAIN_INSTRUCTION     = 3;

  { Task Dialog Icon Elements }

  {$EXTERNALSYM TDIE_ICON_MAIN}
  TDIE_ICON_MAIN           = 0;
  {$EXTERNALSYM TDIE_ICON_FOOTER}
  TDIE_ICON_FOOTER         = 1;

  { Task Dialog Common Icons }

  {$EXTERNALSYM TD_WARNING_ICON}
  TD_WARNING_ICON         = MAKEINTRESOURCEW(Word(-1));
  {$EXTERNALSYM TD_ERROR_ICON}
  TD_ERROR_ICON           = MAKEINTRESOURCEW(Word(-2));
  {$EXTERNALSYM TD_INFORMATION_ICON}
  TD_INFORMATION_ICON     = MAKEINTRESOURCEW(Word(-3));
  {$EXTERNALSYM TD_SHIELD_ICON}
  TD_SHIELD_ICON          = MAKEINTRESOURCEW(Word(-4));

  { Task Dialog Button Flags }

  {$EXTERNALSYM TDCBF_OK_BUTTON}
  TDCBF_OK_BUTTON            = $0001;  // selected control return value IDOK
  {$EXTERNALSYM TDCBF_YES_BUTTON}
  TDCBF_YES_BUTTON           = $0002;  // selected control return value IDYES
  {$EXTERNALSYM TDCBF_NO_BUTTON}
  TDCBF_NO_BUTTON            = $0004;  // selected control return value IDNO
  {$EXTERNALSYM TDCBF_CANCEL_BUTTON}
  TDCBF_CANCEL_BUTTON        = $0008;  // selected control return value IDCANCEL
  {$EXTERNALSYM TDCBF_RETRY_BUTTON}
  TDCBF_RETRY_BUTTON         = $0010;  // selected control return value IDRETRY
  {$EXTERNALSYM TDCBF_CLOSE_BUTTON}
  TDCBF_CLOSE_BUTTON         = $0020;  // selected control return value IDCLOSE

type
  { $EXTERNALSYM TASKDIALOGCONFIG}
  TASKDIALOGCONFIG = record
    cbSize: UINT;
    hwndParent: HWND;
    hInstance: HINST;                     // used for MAKEINTRESOURCE() strings
    dwFlags: DWORD;                       // TASKDIALOG_FLAGS (TDF_XXX) flags
    dwCommonButtons: DWORD;               // TASKDIALOG_COMMON_BUTTON (TDCBF_XXX) flags
    pszWindowTitle: LPCWSTR;              // string or MAKEINTRESOURCE()
    case Integer of
      0: (hMainIcon: HICON);
      1: (pszMainIcon: LPCWSTR;
          pszMainInstruction: LPCWSTR;
          pszContent: LPCWSTR;
          cButtons: UINT;
          pButtons: PTaskDialogButton;
          nDefaultButton: Integer;
          cRadioButtons: UINT;
          pRadioButtons: PTaskDialogButton;
          nDefaultRadioButton: Integer;
          pszVerificationText: LPCWSTR;
          pszExpandedInformation: LPCWSTR;
          pszExpandedControlText: LPCWSTR;
          pszCollapsedControlText: LPCWSTR;
          case Integer of
            0: (hFooterIcon: HICON);
            1: (pszFooterIcon: LPCWSTR;
                pszFooter: LPCWSTR;
                pfCallback: TFTaskDialogCallback;
                lpCallbackData: LONG_PTR;
                cxWidth: UINT  // width of the Task Dialog's client area in DLU's.
                               // If 0, Task Dialog will calculate the ideal width.
              );
          );
  end;
  {$EXTERNALSYM _TASKDIALOGCONFIG}
  _TASKDIALOGCONFIG = TASKDIALOGCONFIG;
  PTaskDialogConfig = ^TTaskDialogConfig;
  TTaskDialogConfig = TASKDIALOGCONFIG;
{$ALIGN ON}

{$EXTERNALSYM TaskDialogIndirect}
function TaskDialogIndirect(const pTaskConfig: TTaskDialogConfig;
  pnButton: PInteger; pnRadioButton: PInteger; pfVerificationFlagChecked: PBOOL): HRESULT;

{$EXTERNALSYM TaskDialog}
function TaskDialog(hwndParent: HWND; hInstance: HINST; pszWindowTitle,
  pszMainInstruction, pszContent: LPCWSTR; dwCommonButtons: DWORD;
  pszIcon: LPCWSTR; pnButton: PInteger): HRESULT;

{$ENDREGION}

{ ====== TrackMouseEvent  ================================================== }

const
  {$EXTERNALSYM WM_MOUSEHOVER}
  WM_MOUSEHOVER                       = $02A1;
  {$EXTERNALSYM WM_MOUSELEAVE}
  WM_MOUSELEAVE                       = $02A3;

  {$EXTERNALSYM TME_HOVER}
  TME_HOVER           = $00000001;
  {$EXTERNALSYM TME_LEAVE}
  TME_LEAVE           = $00000002;
  {$EXTERNALSYM TME_NONCLIENT}
  TME_NONCLIENT       = $00000010;
  {$EXTERNALSYM TME_QUERY}
  TME_QUERY           = $40000000;
  {$EXTERNALSYM TME_CANCEL}
  TME_CANCEL          = $80000000;

  {$EXTERNALSYM HOVER_DEFAULT}
  HOVER_DEFAULT       = $FFFFFFFF;

type
  {$EXTERNALSYM tagTRACKMOUSEEVENT}
  tagTRACKMOUSEEVENT = record
    cbSize: DWORD;
    dwFlags: DWORD;
    hwndTrack: HWND;
    dwHoverTime: DWORD;
  end;
  PTrackMouseEvent = ^TTrackMouseEvent;
  TTrackMouseEvent = tagTRACKMOUSEEVENT;

{ Declare _TrackMouseEvent.  This API tries to use the window manager's }
{ implementation of TrackMouseEvent if it is present, otherwise it emulates. }
{$EXTERNALSYM _TrackMouseEvent}
function _TrackMouseEvent(lpEventTrack: PTrackMouseEvent): BOOL; stdcall;

{ ====== Flat Scrollbar APIs========================================= }

const
  {$EXTERNALSYM WSB_PROP_CYVSCROLL}
  WSB_PROP_CYVSCROLL      = $00000001;
  {$EXTERNALSYM WSB_PROP_CXHSCROLL}
  WSB_PROP_CXHSCROLL      = $00000002;
  {$EXTERNALSYM WSB_PROP_CYHSCROLL}
  WSB_PROP_CYHSCROLL      = $00000004;
  {$EXTERNALSYM WSB_PROP_CXVSCROLL}
  WSB_PROP_CXVSCROLL      = $00000008;
  {$EXTERNALSYM WSB_PROP_CXHTHUMB}
  WSB_PROP_CXHTHUMB       = $00000010;
  {$EXTERNALSYM WSB_PROP_CYVTHUMB}
  WSB_PROP_CYVTHUMB       = $00000020;
  {$EXTERNALSYM WSB_PROP_VBKGCOLOR}
  WSB_PROP_VBKGCOLOR      = $00000040;
  {$EXTERNALSYM WSB_PROP_HBKGCOLOR}
  WSB_PROP_HBKGCOLOR      = $00000080;
  {$EXTERNALSYM WSB_PROP_VSTYLE}
  WSB_PROP_VSTYLE         = $00000100;
  {$EXTERNALSYM WSB_PROP_HSTYLE}
  WSB_PROP_HSTYLE         = $00000200;
  {$EXTERNALSYM WSB_PROP_WINSTYLE}
  WSB_PROP_WINSTYLE       = $00000400;
  {$EXTERNALSYM WSB_PROP_PALETTE}
  WSB_PROP_PALETTE        = $00000800;
  {$EXTERNALSYM WSB_PROP_MASK}
  WSB_PROP_MASK           = $00000FFF;

  {$EXTERNALSYM FSB_FLAT_MODE}
  FSB_FLAT_MODE               = 2;
  {$EXTERNALSYM FSB_ENCARTA_MODE}
  FSB_ENCARTA_MODE            = 1;
  {$EXTERNALSYM FSB_REGULAR_MODE}
  FSB_REGULAR_MODE            = 0;

{$EXTERNALSYM FlatSB_EnableScrollBar}
function FlatSB_EnableScrollBar(hWnd: HWND; wSBflags, wArrows: UINT): BOOL; stdcall;
{$EXTERNALSYM FlatSB_ShowScrollBar}
function FlatSB_ShowScrollBar(hWnd: HWND; wBar: Integer; bShow: BOOL): BOOL; stdcall;

{$EXTERNALSYM FlatSB_GetScrollRange}
function FlatSB_GetScrollRange(hWnd: HWND; nBar: Integer; var lpMinPos,
  lpMaxPos: Integer): BOOL; stdcall;
{$EXTERNALSYM FlatSB_GetScrollInfo}
function FlatSB_GetScrollInfo(hWnd: HWND; BarFlag: Integer;
  var ScrollInfo: TScrollInfo): BOOL; stdcall;
{$EXTERNALSYM FlatSB_GetScrollPos}
function FlatSB_GetScrollPos(hWnd: HWND; nBar: Integer): Integer; stdcall;
{$EXTERNALSYM FlatSB_GetScrollProp}
function FlatSB_GetScrollProp(hWnd: HWND; propIndex: Integer;
  pValue: PInteger): Bool; stdcall;
{$EXTERNALSYM FlatSB_GetScrollPropPtr}
function FlatSB_GetScrollPropPtr(hWnd: HWND; propIndex: Integer;
  pValue: PINT_PTR): Bool; stdcall;

{$EXTERNALSYM FlatSB_SetScrollPos}
function FlatSB_SetScrollPos(hWnd: HWND; nBar, nPos: Integer;
  bRedraw: BOOL): Integer; stdcall;
{$EXTERNALSYM FlatSB_SetScrollInfo}
function FlatSB_SetScrollInfo(hWnd: HWND; BarFlag: Integer;
  const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer; stdcall;
{$EXTERNALSYM FlatSB_SetScrollRange}
function FlatSB_SetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer;
  bRedraw: BOOL): BOOL; stdcall;
{$EXTERNALSYM FlatSB_SetScrollProp}
function FlatSB_SetScrollProp(hWnd: HWND; index: Integer; newValue: IntPtr;
  fRedraw: Bool): Bool; stdcall;
{$EXTERNALSYM FlatSB_SetScrollPropPtr}
function FlatSB_SetScrollPropPtr(hWnd: HWND; index: Integer; newValue: IntPtr;
  fRedraw: Bool): Bool; stdcall;

{$EXTERNALSYM InitializeFlatSB}
function InitializeFlatSB(hWnd: HWND): Bool; stdcall;
{$EXTERNALSYM UninitializeFlatSB}
procedure UninitializeFlatSB(hWnd: HWND); stdcall;

//
// subclassing stuff
//
type
  { For Windows >= XP }
  { $EXTERNALSYM SUBCLASSPROC}
  SUBCLASSPROC = function(hWnd: HWND; uMsg: UINT; wParam: WPARAM;
    lParam: LPARAM; uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): LRESULT; stdcall;
  TSubClassProc = SUBCLASSPROC;

{ For Windows >= XP }
{$EXTERNALSYM SetWindowSubclass}
function SetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): BOOL;
{$EXTERNALSYM GetWindowSubclass}
function GetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR; var pdwRefData: DWORD_PTR): BOOL;
{$EXTERNALSYM RemoveWindowSubclass}
function RemoveWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR): BOOL;
{$EXTERNALSYM DefSubclassProc}
function DefSubclassProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;

{ For NTDDI_VERSION >= NTDDI_VISTA }
const
  {$EXTERNALSYM LIM_SMALL}
  LIM_SMALL = 0; // corresponds to SM_CXSMICON/SM_CYSMICON
  {$EXTERNALSYM LIM_LARGE}
  LIM_LARGE = 1; // corresponds to SM_CXICON/SM_CYICON

{ For NTDDI_VERSION >= NTDDI_VISTA }
{$EXTERNALSYM LoadIconMetric}
function LoadIconMetric(hinst: HINST; pszName: LPCWSTR; lims: Integer;
  var phico: HICON): HResult;
{$EXTERNALSYM LoadIconWithScaleDown}
function LoadIconWithScaleDown(hinst: HINST; pszName: LPCWSTR; cx: Integer;
  cy: Integer; var phico: HICON): HResult;

{ For Windows >= XP }
{$EXTERNALSYM DrawShadowText}
function DrawShadowText(hdc: HDC; pszText: LPCWSTR; cch: UINT; const prc: TRect;
  dwFlags: DWORD; crText, crShadow: COLORREF; ixOffset, iyOffset: Integer): Integer;

const
  { For Windows >= Vista }
  {$EXTERNALSYM DCHF_TOPALIGN}
  DCHF_TOPALIGN       = $00000002;  // default is center-align
  {$EXTERNALSYM DCHF_HORIZONTAL}
  DCHF_HORIZONTAL     = $00000004;  // default is vertical
  {$EXTERNALSYM DCHF_HOT}
  DCHF_HOT            = $00000008;  // default is flat
  {$EXTERNALSYM DCHF_PUSHED}
  DCHF_PUSHED         = $00000010;  // default is flat
  {$EXTERNALSYM DCHF_FLIPPED}
  DCHF_FLIPPED        = $00000020;  // if horiz, default is pointing right
                                        // if vert, default is pointing up
  { For Windows >= Vista }
  {$EXTERNALSYM DCHF_TRANSPARENT}
  DCHF_TRANSPARENT    = $00000040;
  {$EXTERNALSYM DCHF_INACTIVE}
  DCHF_INACTIVE       = $00000080;
  {$EXTERNALSYM DCHF_NOBORDER}
  DCHF_NOBORDER       = $00000100;

{ For Windows >= Vista }
{$EXTERNALSYM DrawScrollArrow}
procedure DrawScrollArrow(hdc: HDC; lprc: PRect; wControlState: UINT;
  rgbOveride: COLORREF);


// Utilities to simplify .NET/Win32 single code base
type
  TWMNotifyHC = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (HDNotify: PHDNotify;
          Result: LRESULT);
    end;

  TWMNotifyTV = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMCustomDraw: PNMCustomDraw);
      2: (NMTreeView: PNMTreeView);
      3: (NMTVCustomDraw: PNMTVCustomDraw);
      4: (ToolTipTextW: PToolTipTextW);
      5: (TVDispInfo: PTVDispInfo;
          Result: LRESULT);
  end;

  TWMNotifyTRB = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMCustomDraw: PNMCustomDraw;
          Result: LRESULT);
  end;

  TWMNotifyUD = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMUpDown: PNMUpDown;
          Result: LRESULT);
  end;

  TWMNotifyLV = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (HDNotify: PHDNotify);
      2: (LVDispInfo: PLVDispInfo);
      3: (NMCustomDraw: PNMCustomDraw);
      4: (NMListView: PNMListView);
      5: (NMLVCacheHint: PNMLVCacheHint);
      6: (NMLVCustomDraw: PNMLVCustomDraw);
      7: (NMLVFindItem: PNMLVFindItem);
      8: (NMLVODStateChange: PNMLVODStateChange;
          Result: LRESULT);
  end;

  TWMNotifyTLB = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMTBCustomDraw: PNMTBCustomDraw);
      2: (NMToolBar: PNMToolBar;
          Result: LRESULT);
  end;

  TWMNotifyMC = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMDayState: PNMDayState);
      2: (NMSelChange: PNMSelChange;
          Result: LRESULT);
  end;

  TWMNotifyDT = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMDateTimeChange: PNMDateTimeChange);
      2: (NMDateTimeString: PNMDateTimeString;
          Result: LRESULT);
  end;

  TWMNotifyPS = record { TWMNotify }
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    case Integer of
      0: (NMHdr: PNMHdr);
      1: (NMPGCalcSize: PNMPGCalcSize);
      2: (NMPGScroll: PNMPGScroll;
          Result: LRESULT);
  end;

  TTCMAdjustRect = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Larger: LongBool;
    LargerFiller: TDWordFiller;
    case Integer of
      0: (lpPrc: PRect);
      1: (Prc: PRect;
          Result: LRESULT);
  end;

{$POINTERMATH OFF}

implementation

const
{$IFDEF MSWINDOWS}
  cctrl = comctl32; { From Winapi.Windows.pas }
{$ENDIF}

var
  ComCtl32DLL: THandle;
  _InitCommonControlsEx: function(var ICC: TInitCommonControlsEx): Bool stdcall;
  Win32MajorVersion: Integer = 0;
  Win32MinorVersion: Integer = 0;
  Win32Platform: Integer = 0;

procedure InitVersionInfo;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    with OSVersionInfo do
    begin
      Win32Platform := dwPlatformId;
      Win32MajorVersion := dwMajorVersion;
      Win32MinorVersion := dwMinorVersion;
    end;
end;

procedure InitCommonControls; external cctrl name 'InitCommonControls';

procedure InitComCtl;
begin
  if ComCtl32DLL = 0 then
  begin
    ComCtl32DLL := GetModuleHandle(cctrl);
    if ComCtl32DLL <> 0 then
      @_InitCommonControlsEx := GetProcAddress(ComCtl32DLL, 'InitCommonControlsEx');
  end;
end;

function InitCommonControlsEx(var ICC: TInitCommonControlsEx): Bool;
begin
  if ComCtl32DLL = 0 then InitComCtl;
  Result := Assigned(_InitCommonControlsEx) and _InitCommonControlsEx(ICC);
end;

{ Property Sheets }
function CreatePropertySheetPage; external cctrl name 'CreatePropertySheetPageW';
function CreatePropertySheetPageA; external cctrl name 'CreatePropertySheetPageA';
function CreatePropertySheetPageW; external cctrl name 'CreatePropertySheetPageW';
function DestroyPropertySheetPage; external cctrl name 'DestroyPropertySheetPage';
function PropertySheet; external cctrl name 'PropertySheetW';
function PropertySheetA; external cctrl name 'PropertySheetA';
function PropertySheetW; external cctrl name 'PropertySheetW';

{ Image List }
function ImageList_Create; external cctrl name 'ImageList_Create';
function ImageList_Destroy; external cctrl name 'ImageList_Destroy';
function ImageList_GetImageCount; external cctrl name 'ImageList_GetImageCount';
function ImageList_SetImageCount; external cctrl name 'ImageList_SetImageCount';
function ImageList_Add; external cctrl name 'ImageList_Add';
function ImageList_ReplaceIcon; external cctrl name 'ImageList_ReplaceIcon';
function ImageList_SetBkColor; external cctrl name 'ImageList_SetBkColor';
function ImageList_GetBkColor; external cctrl name 'ImageList_GetBkColor';
function ImageList_SetOverlayImage; external cctrl name 'ImageList_SetOverlayImage';

function ImageList_AddIcon(ImageList: HIMAGELIST; Icon: HIcon): Integer;
begin
  Result := ImageList_ReplaceIcon(ImageList, -1, Icon);
end;

function IndexToOverlayMask(Index: Integer): Integer;
begin
  Result := Index shl 8;
end;

function ImageList_Draw; external cctrl name 'ImageList_Draw';

function ImageList_Replace; external cctrl name 'ImageList_Replace';
function ImageList_AddMasked; external cctrl name 'ImageList_AddMasked';
function ImageList_DrawEx; external cctrl name 'ImageList_DrawEx';
function ImageList_DrawIndirect; external cctrl name 'ImageList_DrawIndirect';
function ImageList_Remove; external cctrl name 'ImageList_Remove';
function ImageList_GetIcon; external cctrl name 'ImageList_GetIcon';
function ImageList_LoadImage; external cctrl name 'ImageList_LoadImageW';
function ImageList_LoadImageA; external cctrl name 'ImageList_LoadImageA';
function ImageList_LoadImageW; external cctrl name 'ImageList_LoadImageW';
function ImageList_Copy; external cctrl name 'ImageList_Copy';
function ImageList_BeginDrag; external cctrl name 'ImageList_BeginDrag';
function ImageList_EndDrag; external cctrl name 'ImageList_EndDrag';
function ImageList_DragEnter; external cctrl name 'ImageList_DragEnter';
function ImageList_DragLeave; external cctrl name 'ImageList_DragLeave';
function ImageList_DragMove; external cctrl name 'ImageList_DragMove';
function ImageList_SetDragCursorImage; external cctrl name 'ImageList_SetDragCursorImage';
function ImageList_DragShowNolock; external cctrl name 'ImageList_DragShowNolock';
function ImageList_GetDragImage(Point, HotSpot: PPoint): HIMAGELIST; external cctrl name 'ImageList_GetDragImage';
function ImageList_GetDragImage(Point: PPoint; out HotSpot: TPoint): HIMAGELIST; external cctrl name 'ImageList_GetDragImage';

{ macros }
procedure ImageList_RemoveAll(ImageList: HIMAGELIST);
begin
  ImageList_Remove(ImageList, -1);
end;

function ImageList_ExtractIcon(Instance: HINST; ImageList: HIMAGELIST;
  Image: Integer): HIcon;
begin
  Result := ImageList_GetIcon(ImageList, Image, 0);
end;

function ImageList_LoadBitmap(Instance: HINST; Bmp: LPCWSTR;
  CX, Grow: Integer; Mask: TColorRef): HIMAGELIST;
begin
  Result := ImageList_LoadImage(Instance, Bmp, CX, Grow, Mask,
    IMAGE_BITMAP, 0);
end;
function ImageList_LoadBitmapA(Instance: HINST; Bmp: LPCSTR;
  CX, Grow: Integer; Mask: TColorRef): HIMAGELIST;
begin
  Result := ImageList_LoadImageA(Instance, Bmp, CX, Grow, Mask,
    IMAGE_BITMAP, 0);
end;
function ImageList_LoadBitmapW(Instance: HINST; Bmp: LPCWSTR;
  CX, Grow: Integer; Mask: TColorRef): HIMAGELIST;
begin
  Result := ImageList_LoadImageW(Instance, Bmp, CX, Grow, Mask,
    IMAGE_BITMAP, 0);
end;

function ImageList_Read; external cctrl name 'ImageList_Read';
function ImageList_Write; external cctrl name 'ImageList_Write';

var
  _ImageList_ReadEx: function(dwFlags: DWORD; pstm: IStream; const riid: TIID;
    var ppv: Pointer): HResult; stdcall;

function ImageList_ReadEx(dwFlags: DWORD; pstm: IStream; const riid: TIID;
  var ppv: Pointer): HResult;
begin
  if Assigned(_ImageList_ReadEx) then
    Result := _ImageList_ReadEx(dwFlags, pstm, riid, ppv)
  else
  begin
    Result := E_NOTIMPL;
    if ComCtl32DLL > 0 then
    begin
      _ImageList_ReadEx := GetProcAddress(ComCtl32DLL, 'ImageList_ReadEx'); // Do not localize
      if Assigned(_ImageList_ReadEx) then
        Result := _ImageList_ReadEx(dwFlags, pstm, riid, ppv);
    end;
  end;
end;

var
  _ImageList_WriteEx: function(himl: HIMAGELIST; dwFlags: DWORD;
    pstm: IStream): HResult; stdcall;

function ImageList_WriteEx(himl: HIMAGELIST; dwFlags: DWORD; pstm: IStream): HResult;
begin
  if Assigned(_ImageList_WriteEx) then
    Result := _ImageList_WriteEx(himl, dwFlags, pstm)
  else
  begin
    Result := E_NOTIMPL;
    if ComCtl32DLL > 0 then
    begin
      _ImageList_WriteEx := GetProcAddress(ComCtl32DLL, 'ImageList_WriteEx'); // Do not localize
      if Assigned(_ImageList_WriteEx) then
        Result := _ImageList_WriteEx(himl, dwFlags, pstm);
    end;
  end;
end;

function ImageList_GetIconSize; external cctrl name 'ImageList_GetIconSize';
function ImageList_SetIconSize; external cctrl name 'ImageList_SetIconSize';
function ImageList_GetImageInfo; external cctrl name 'ImageList_GetImageInfo';
function ImageList_Merge; external cctrl name 'ImageList_Merge';
function ImageList_Duplicate(himl: HIMAGELIST): HIMAGELIST; stdcall; external cctrl name 'ImageList_Duplicate';

var
  _HIMAGELIST_QueryInterface: function(himl: HIMAGELIST; const riid: TIID;
    var ppv: Pointer): HResult; stdcall;

function HIMAGELIST_QueryInterface(himl: HIMAGELIST; const riid: TIID;
  var ppv: Pointer): HResult;
begin
  if Assigned(_HIMAGELIST_QueryInterface) then
    Result := _HIMAGELIST_QueryInterface(himl, riid, ppv)
  else
  begin
    Result := E_NOTIMPL;
    if ComCtl32DLL > 0 then
    begin
      _HIMAGELIST_QueryInterface := GetProcAddress(ComCtl32DLL,
        'HIMAGELIST_QueryInterface'); // Do not localize
      if Assigned(_HIMAGELIST_QueryInterface) then
        Result := _HIMAGELIST_QueryInterface(himl, riid, ppv);
    end;
  end;
end;

{ Headers }

function Header_GetItemCount(Header: HWnd): Integer;
begin
  Result := Integer(SendMessage(Header, HDM_GETITEMCOUNT, 0, 0));
end;

function Header_InsertItem(Header: HWnd; Index: Integer;
  const Item: THDItem): Integer;
begin
  Result := SendMessage(Header, HDM_INSERTITEM, Index, LPARAM(@Item));
end;
function Header_InsertItemA(Header: HWnd; Index: Integer;
  const Item: THDItemA): Integer;
begin
  Result := SendMessageA(Header, HDM_INSERTITEM, Index, LPARAM(@Item));
end;
function Header_InsertItemW(Header: HWnd; Index: Integer;
  const Item: THDItemW): Integer;
begin
  Result := SendMessageW(Header, HDM_INSERTITEM, Index, LPARAM(@Item));
end;

function Header_DeleteItem(Header: HWnd; Index: Integer): Bool;
begin
  Result := Bool(SendMessage(Header, HDM_DELETEITEM, Index, 0));
end;

function Header_GetItem(Header: HWnd; Index: Integer; var Item: THDItem): Bool;
begin
  Result := Bool(SendMessage(Header, HDM_GETITEM, Index, LPARAM(@Item)));
end;
function Header_GetItemA(Header: HWnd; Index: Integer; var Item: THDItemA): Bool;
begin
  Result := Bool(SendMessageA(Header, HDM_GETITEM, Index, LPARAM(@Item)));
end;
function Header_GetItemW(Header: HWnd; Index: Integer; var Item: THDItemW): Bool;
begin
  Result := Bool(SendMessageW(Header, HDM_GETITEM, Index, LPARAM(@Item)));
end;

function Header_SetItem(Header: HWnd; Index: Integer; const Item: THDItem): Bool;
begin
  Result := Bool(SendMessage(Header, HDM_SETITEM, Index, LPARAM(@Item)));
end;
function Header_SetItemA(Header: HWnd; Index: Integer; const Item: THDItemA): Bool;
begin
  Result := Bool(SendMessageA(Header, HDM_SETITEM, Index, LPARAM(@Item)));
end;
function Header_SetItemW(Header: HWnd; Index: Integer; const Item: THDItemW): Bool;
begin
  Result := Bool(SendMessageW(Header, HDM_SETITEM, Index, LPARAM(@Item)));
end;

function Header_Layout(Header: HWnd; Layout: PHDLayout): Bool;
begin
  Result := Bool(SendMessage(Header, HDM_LAYOUT, 0, LPARAM(Layout)));
end;

function Header_GetItemRect(hwnd: HWND; iItem: Integer; lprc: PRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_GETITEMRECT, iItem, LPARAM(lprc)));
end;

function Header_SetImageList(hwnd: HWND; himl: HIMAGELIST): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, HDM_SETIMAGELIST, 0, LPARAM(himl)));
end;

function Header_GetImageList(hwnd: HWND): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, HDM_GETIMAGELIST, 0, 0));
end;

function Header_OrderToIndex(hwnd: HWND; i: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_ORDERTOINDEX, i, 0));
end;

function Header_CreateDragImage(hwnd: HWND; i: Integer): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, HDM_CREATEDRAGIMAGE, i, 0));
end;

function Header_GetOrderArray(hwnd: HWND; iCount: Integer; lpi: PInteger): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_GETORDERARRAY, iCount, LPARAM(lpi)));
end;

function Header_SetOrderArray(hwnd: HWND; iCount: Integer; lpi: PInteger): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_SETORDERARRAY, iCount, LPARAM(lpi)));
end;

function Header_SetHotDivider(hwnd: HWND; fPos: BOOL; dw: DWORD): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_SETHOTDIVIDER, WPARAM(fPos), dw));
end;

function Header_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_SETUNICODEFORMAT, WPARAM(fUnicode), 0));
end;

function Header_GetUnicodeFormat(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_GETUNICODEFORMAT, 0, 0));
end;

function Header_SetBitmapMargin(hwnd: HWND; iWidth: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_SETBITMAPMARGIN, WPARAM(iWidth), 0));
end;

function Header_GetBitmapMargin(hwnd: HWND): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_GETBITMAPMARGIN, 0, 0));
end;

function Header_SetFilterChangeTimeout(hwnd: HWND; i: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_SETFILTERCHANGETIMEOUT, 0, LPARAM(i)));
end;

function Header_EditFilter(hwnd: HWND; i: Integer; fDiscardChanges: BOOL): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_EDITFILTER, WPARAM(i), MAKELPARAM(Word(fDiscardChanges), 0)));
end;

function Header_ClearFilter(hwnd: HWND; i: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_CLEARFILTER, WPARAM(i), 0));
end;

function Header_ClearAllFilters(hwnd: HWND): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_CLEARFILTER, WPARAM(-1), 0));
end;

function Header_GetItemDropDownRect(hwnd: HWND; iItem: Integer; var lprc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_GETITEMDROPDOWNRECT, WPARAM(iItem), LPARAM(@lprc)));
end;

function Header_GetOverflowRect(hwnd: HWND; var lprc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_GETOVERFLOWRECT, 0, LPARAM(@lprc)));
end;

function Header_GetFocusedItem(hwnd: HWND): Integer;
begin
  Result := Integer(SendMessage(hwnd, HDM_GETFOCUSEDITEM, 0, 0));
end;

function Header_SetFocusedItem(hwnd: HWND; iItem: Integer): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, HDM_SETFOCUSEDITEM, 0, LPARAM(iItem)));
end;


{ Toolbar }

function CreateToolBarEx; external cctrl name 'CreateToolbarEx';
function CreateMappedBitmap; external cctrl name 'CreateMappedBitmap';

{ Status bar }
procedure DrawStatusText; external cctrl name 'DrawStatusTextW';
procedure DrawStatusTextA; external cctrl name 'DrawStatusTextA';
procedure DrawStatusTextW; external cctrl name 'DrawStatusTextW';
function CreateStatusWindow; external cctrl name 'CreateStatusWindowW';
function CreateStatusWindowA; external cctrl name 'CreateStatusWindowA';
function CreateStatusWindowW; external cctrl name 'CreateStatusWindowW';

{ Menu Help }
procedure MenuHelp; external cctrl name 'MenuHelp';
function ShowHideMenuCtl; external cctrl name 'ShowHideMenuCtl';
procedure GetEffectiveClientRect; external cctrl name 'GetEffectiveClientRect';

{ Drag List Box }
procedure MakeDragList; external cctrl name 'MakeDragList';
procedure DrawInsert; external cctrl name 'DrawInsert';
function LBItemFromPt; external cctrl name 'LBItemFromPt';

{ UpDown control }
function CreateUpDownControl; external cctrl name 'CreateUpDownControl';

{ List View }
function ListView_GetUnicodeFormat(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETUNICODEFORMAT, 0, 0));
end;

function ListView_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_SETUNICODEFORMAT, WPARAM(fUnicode), 0));
end;

function ListView_GetBkColor(hWnd: HWND): TColorRef;
begin
  Result := TColorRef(SendMessage(hWnd, LVM_GETBKCOLOR, 0, 0));
end;

function ListView_SetBkColor(hWnd: HWND; clrBk: TColorRef): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_SETBKCOLOR, 0, LPARAM(clrBk)));
end;

function ListView_GetImageList(hWnd: HWND; iImageList: Integer): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hWnd, LVM_GETIMAGELIST, iImageList, 0));
end;

function ListView_SetImageList(hWnd: HWND; himl: HIMAGELIST; iImageList: Integer): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hWnd, LVM_SETIMAGELIST, iImageList, LPARAM(himl)));
end;

function ListView_GetItemCount(hWnd: HWND): Integer;
begin
  Result := Integer(SendMessage(hWnd, LVM_GETITEMCOUNT, 0, 0));
end;

function IndexToStateImageMask(I: Longint): Longint;
begin
  Result := I shl 12;
end;

function ListView_GetItem(hWnd: HWND; var pItem: TLVItem): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_GETITEM, 0, LPARAM(@pItem)));
end;
function ListView_GetItemA(hWnd: HWND; var pItem: TLVItemA): Bool;
begin
  Result := Bool(SendMessageA(hWnd, LVM_GETITEMA, 0, LPARAM(@pItem)));
end;
function ListView_GetItemW(hWnd: HWND; var pItem: TLVItemW): Bool;
begin
  Result := Bool(SendMessageW(hWnd, LVM_GETITEMW, 0, LPARAM(@pItem)));
end;

function ListView_SetItem(hWnd: HWND; const pItem: TLVItem): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_SETITEM, 0, LPARAM(@pItem)));
end;
function ListView_SetItemA(hWnd: HWND; const pItem: TLVItemA): Bool;
begin
  Result := Bool(SendMessageA(hWnd, LVM_SETITEMA, 0, LPARAM(@pItem)));
end;
function ListView_SetItemW(hWnd: HWND; const pItem: TLVItemW): Bool;
begin
  Result := Bool(SendMessageW(hWnd, LVM_SETITEMW, 0, LPARAM(@pItem)));
end;

function ListView_InsertItem(hWnd: HWND; const pItem: TLVItem): Integer;
begin
  Result := Integer(SendMessage(hWnd, LVM_INSERTITEM, 0, LPARAM(@pItem)));
end;
function ListView_InsertItemA(hWnd: HWND; const pItem: TLVItemA): Integer;
begin
  Result := Integer(SendMessageA(hWnd, LVM_INSERTITEMA, 0, LPARAM(@pItem)));
end;
function ListView_InsertItemW(hWnd: HWND; const pItem: TLVItemW): Integer;
begin
  Result := Integer(SendMessageW(hWnd, LVM_INSERTITEMW, 0, LPARAM(@pItem)));
end;

function ListView_DeleteItem(hWnd: HWND; i: Integer): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_DELETEITEM, i, 0));
end;

function ListView_DeleteAllItems(hWnd: HWND): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_DELETEALLITEMS, 0, 0));
end;

function ListView_GetCallbackMask(hWnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hWnd, LVM_GETCALLBACKMASK, 0, 0));
end;

function ListView_SetCallbackMask(hWnd: HWND; mask: UINT): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_SETCALLBACKMASK, mask, 0));
end;

function ListView_GetNextItem(hWnd: HWND; iStart: Integer; Flags: UINT): Integer;
begin
  Result := Integer(SendMessage(hWnd, LVM_GETNEXTITEM, iStart, MakeLong(Word(Flags), 0)));
end;

function ListView_FindItem(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfo): Integer;
begin
  Result := Integer(SendMessage(hWnd, LVM_FINDITEM, iStart, LPARAM(@plvfi)));
end;
function ListView_FindItemA(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfoA): Integer;
begin
  Result := Integer(SendMessageA(hWnd, LVM_FINDITEMA, iStart, LPARAM(@plvfi)));
end;
function ListView_FindItemW(hWnd: HWND; iStart: Integer;
  const plvfi: TLVFindInfoW): Integer;
begin
  Result := Integer(SendMessageW(hWnd, LVM_FINDITEMW, iStart, LPARAM(@plvfi)));
end;

function ListView_GetItemRect(hWnd: HWND; i: Integer; var prc: TRect;
  Code: Integer): Bool;
begin
  if @prc <> nil then
  begin
    prc.left := Code;
    Result := Bool(SendMessage(hWnd, LVM_GETITEMRECT, i, LPARAM(@prc)));
  end
  else
    Result := Bool(SendMessage(hWnd, LVM_GETITEMRECT, i, 0));
end;

function ListView_SetItemPosition(hWnd: HWND; i, x, y: Integer): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_SETITEMPOSITION, i, MakeLong(Word(x), Word(y))));
end;

function ListView_GetItemPosition(hwndLV: HWND; i: Integer;
  var ppt: TPoint): Bool;
begin
  Result := Bool(SendMessage(hWndLV, LVM_GETITEMPOSITION, i, LPARAM(@ppt)));
end;

function ListView_GetStringWidth(hwndLV: HWND; psz: LPCWSTR): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETSTRINGWIDTH, 0, LPARAM(psz)));
end;
function ListView_GetStringWidthA(hwndLV: HWND; psz: LPCSTR): Integer;
begin
  Result := Integer(SendMessageA(hwndLV, LVM_GETSTRINGWIDTHA, 0, LPARAM(psz)));
end;
function ListView_GetStringWidthW(hwndLV: HWND; psz: LPCWSTR): Integer;
begin
  Result := Integer(SendMessageW(hwndLV, LVM_GETSTRINGWIDTHW, 0, LPARAM(psz)));
end;

function ListView_HitTest(hwndLV: HWND; var pinfo: TLVHitTestInfo): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_HITTEST, 0, LPARAM(@pinfo)));
end;

function ListView_HitTestEx(hwndLV: HWND; var pinfo: TLVHitTestInfo): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_HITTEST, WPARAM(-1), LPARAM(@pinfo)));
end;

function ListView_EnsureVisible(hwndLV: HWND; i: Integer; fPartialOK: Bool): Bool;
begin
  Result := 0 <> SendMessage(hwndLV, LVM_ENSUREVISIBLE, i, MakeLong(Word(fPartialOK), 0));
end;

function ListView_Scroll(hwndLV: HWnd; DX, DY: Integer): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_SCROLL, DX, DY));
end;

function ListView_RedrawItems(hwndLV: HWND; iFirst, iLast: Integer): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_REDRAWITEMS, iFirst, iLast));
end;

function ListView_Arrange(hwndLV: HWND; Code: UINT): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_ARRANGE, Code, 0));
end;

function ListView_EditLabel(hwndLV: HWND; i: Integer): HWND;
begin
  Result := HWND(SendMessage(hwndLV, LVM_EDITLABEL, i, 0));
end;
function ListView_EditLabelA(hwndLV: HWND; i: Integer): HWND;
begin
  Result := HWND(SendMessageA(hwndLV, LVM_EDITLABELA, i, 0));
end;
function ListView_EditLabelW(hwndLV: HWND; i: Integer): HWND;
begin
  Result := HWND(SendMessageW(hwndLV, LVM_EDITLABELW, i, 0));
end;

function ListView_GetEditControl(hwndLV: HWND): HWND;
begin
  Result := HWND(SendMessage(hwndLV, LVM_GETEDITCONTROL, 0, 0));
end;

function ListView_GetColumn(hwnd: HWND; iCol: Integer; var pcol: TLVColumn): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_GETCOLUMN, iCol, LPARAM(@pcol)));
end;
function ListView_GetColumnA(hwnd: HWND; iCol: Integer; var pcol: TLVColumnA): Bool;
begin
  Result := Bool(SendMessageA(hwnd, LVM_GETCOLUMNA, iCol, LPARAM(@pcol)));
end;
function ListView_GetColumnW(hwnd: HWND; iCol: Integer; var pcol: TLVColumnW): Bool;
begin
  Result := Bool(SendMessageW(hwnd, LVM_GETCOLUMNW, iCol, LPARAM(@pcol)));
end;

function ListView_SetColumn(hwnd: HWND; iCol: Integer; const pcol: TLVColumn): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_SETCOLUMN, iCol, LPARAM(@pcol)));
end;
function ListView_SetColumnA(hwnd: HWND; iCol: Integer; const pcol: TLVColumnA): Bool;
begin
  Result := Bool(SendMessageA(hwnd, LVM_SETCOLUMNA, iCol, LPARAM(@pcol)));
end;
function ListView_SetColumnW(hwnd: HWND; iCol: Integer; const pcol: TLVColumnW): Bool;
begin
  Result := Bool(SendMessageW(hwnd, LVM_SETCOLUMNW, iCol, LPARAM(@pcol)));
end;

function ListView_InsertColumn(hwnd: HWND; iCol: Integer; const pcol: TLVColumn): Integer;
begin
  Result := Integer(SendMessage(hWnd, LVM_INSERTCOLUMN, iCol, LPARAM(@pcol)));
end;
function ListView_InsertColumnA(hwnd: HWND; iCol: Integer; const pcol: TLVColumnA): Integer;
begin
  Result := Integer(SendMessageA(hWnd, LVM_INSERTCOLUMNA, iCol, LPARAM(@pcol)));
end;
function ListView_InsertColumnW(hwnd: HWND; iCol: Integer; const pcol: TLVColumnW): Integer;
begin
  Result := Integer(SendMessageW(hWnd, LVM_INSERTCOLUMNW, iCol, LPARAM(@pcol)));
end;

function ListView_DeleteColumn(hwnd: HWND; iCol: Integer): Bool;
begin
  Result := Bool(SendMessage(hWnd, LVM_DELETECOLUMN, iCol, 0));
end;

function ListView_GetColumnWidth(hwnd: HWND; iCol: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, LVM_GETCOLUMNWIDTH, iCol, 0));
end;

function ListView_SetColumnWidth(hwnd: HWnd; iCol: Integer; cx: Integer): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_SETCOLUMNWIDTH, iCol, MakeLong(Word(cx), 0)));
end;

function ListView_GetHeader(hwnd: HWND): HWND;
begin
  Result := Winapi.Windows.HWND(SendMessage(hwnd, LVM_GETHEADER, 0, 0));
end;

function ListView_CreateDragImage(hwnd: HWND; i: Integer;
  const lpptUpLeft: TPoint): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, LVM_CREATEDRAGIMAGE, i, LPARAM(@lpptUpLeft)));
end;

function ListView_GetViewRect(hwnd: HWND; var prc: TRect): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_GETVIEWRECT, 0, LPARAM(@prc)));
end;

function ListView_GetTextColor(hwnd: HWND): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_GETTEXTCOLOR, 0, 0));
end;

function ListView_SetTextColor(hwnd: HWND; clrText: TColorRef): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_SETTEXTCOLOR, 0, clrText));
end;

function ListView_GetTextBkColor(hwnd: HWND): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_GETTEXTBKCOLOR, 0, 0));
end;

function ListView_SetTextBkColor(hwnd: HWND; clrTextBk: TColorRef): Bool;
begin
  Result := Bool(SendMessage(hwnd, LVM_SETTEXTBKCOLOR, 0, LPARAM(clrTextBk)));
end;

function ListView_GetTopIndex(hwndLV: HWND): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETTOPINDEX, 0, 0));
end;

function ListView_GetCountPerPage(hwndLV: HWND): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETCOUNTPERPAGE, 0, 0));
end;

function ListView_GetOrigin(hwndLV: HWND; var ppt: TPoint): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_GETORIGIN, 0, LPARAM(@ppt)));
end;

function ListView_Update(hwndLV: HWND; i: Integer): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_UPDATE, i, 0) <> 0);
end;

function ListView_SetItemState(hwndLV: HWND; i: Integer; data, mask: UINT): Bool;
var
  Item: TLVItem;
begin
  Item.stateMask := mask;
  Item.state := data;
  Result := Bool(SendMessage(hwndLV, LVM_SETITEMSTATE, i, LPARAM(@Item)));
end;

function ListView_GetItemState(hwndLV: HWND; i, mask: Integer): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETITEMSTATE, i, LPARAM(mask)));
end;

function ListView_GetCheckState(hwndLV: HWND; i: Integer): UINT;
begin
  Result := UINT((SendMessage(hwndLV, LVM_GETITEMSTATE, i, LPARAM(LVIS_STATEIMAGEMASK)) shr 12) - 1);
end;

procedure ListView_SetCheckState(hwndLV: HWND; i: Integer; Checked: Boolean);
var
  Item: TLVItem;
begin
  Item.statemask := LVIS_STATEIMAGEMASK;
  Item.State := ((Integer(Checked) and 1) + 1) shl 12;
  SendMessage(hwndLV, LVM_SETITEMSTATE, i, LPARAM(@Item));
end;

function ListView_GetItemText(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR; cchTextMax: Integer): Integer;
var
  Item: TLVItem;
begin
  Item.iSubItem := iSubItem;
  Item.cchTextMax := cchTextMax;
  Item.pszText := pszText;
  Result := Integer(SendMessage(hwndLV, LVM_GETITEMTEXT, i, LPARAM(@Item)));
end;
function ListView_GetItemTextA(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPSTR; cchTextMax: Integer): Integer;
var
  Item: TLVItemA;
begin
  Item.iSubItem := iSubItem;
  Item.cchTextMax := cchTextMax;
  Item.pszText := pszText;
  Result := Integer(SendMessageA(hwndLV, LVM_GETITEMTEXTA, i, LPARAM(@Item)));
end;
function ListView_GetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR; cchTextMax: Integer): Integer;
var
  Item: TLVItemW;
begin
  Item.iSubItem := iSubItem;
  Item.cchTextMax := cchTextMax;
  Item.pszText := pszText;
  Result := Integer(SendMessageW(hwndLV, LVM_GETITEMTEXTW, i, LPARAM(@Item)));
end;

function ListView_SetItemText(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR): Bool;
var
  Item: TLVItem;
begin
  Item.iSubItem := iSubItem;
  Item.pszText := pszText;
  Result := Bool(SendMessage(hwndLV, LVM_SETITEMTEXT, i, LPARAM(@Item)));
end;
function ListView_SetItemTextA(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPSTR): Bool;
var
  Item: TLVItemA;
begin
  Item.iSubItem := iSubItem;
  Item.pszText := pszText;
  Result := Bool(SendMessageA(hwndLV, LVM_SETITEMTEXTA, i, LPARAM(@Item)));
end;
function ListView_SetItemTextW(hwndLV: HWND; i, iSubItem: Integer;
  pszText: LPWSTR): Bool;
var
  Item: TLVItemW;
begin
  Item.iSubItem := iSubItem;
  Item.pszText := pszText;
  Result := Bool(SendMessageW(hwndLV, LVM_SETITEMTEXTW, i, LPARAM(@Item)));
end;

procedure ListView_SetItemCount(hwndLV: HWND; cItems: Integer);
begin
  SendMessage(hwndLV, LVM_SETITEMCOUNT, cItems, 0);
end;

procedure ListView_SetItemCountEx(hwndLV: HWND; cItems: Integer; dwFlags: DWORD);
begin
  SendMessage(hwndLV, LVM_SETITEMCOUNT, cItems, dwFlags);
end;

function ListView_SortItems(hwndLV: HWND; pfnCompare: TLVCompare;
  lPrm: LPARAM): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_SORTITEMS, WPARAM(LPARAM(lPrm)), LPARAM(@pfnCompare)));
end;

procedure ListView_SetItemPosition32(hwndLV: HWND; i, x, y: Integer);
var
  ptNewPos: TPoint;
begin
  ptNewPos.x := x;
  ptNewPos.y := y;
  SendMessage(hwndLV, LVM_SETITEMPOSITION32, i, LPARAM(@ptNewPos));
end;

function ListView_GetSelectedCount(hwndLV: HWND): UINT;
begin
  Result := UINT(SendMessage(hwndLV, LVM_GETSELECTEDCOUNT, 0, 0));
end;

function ListView_GetItemSpacing(hwndLV: HWND; fSmall: Integer): DWORD;
begin
  Result := DWORD(SendMessage(hwndLV, LVM_GETITEMSPACING, fSmall, 0));
end;

function ListView_GetISearchString(hwndLV: HWND; lpsz: LPWSTR): Bool;
begin
  Result := Bool(SendMessage(hwndLV, LVM_GETISEARCHSTRING, 0, LPARAM(lpsz)));
end;
function ListView_GetISearchStringA(hwndLV: HWND; lpsz: LPSTR): Bool;
begin
  Result := Bool(SendMessageA(hwndLV, LVM_GETISEARCHSTRINGA, 0, LPARAM(lpsz)));
end;
function ListView_GetISearchStringW(hwndLV: HWND; lpsz: LPWSTR): Bool;
begin
  Result := Bool(SendMessageW(hwndLV, LVM_GETISEARCHSTRINGW, 0, LPARAM(lpsz)));
end;

function ListView_SetIconSpacing(hwndLV: HWND; cx, cy: Word): DWORD;
begin
  Result := DWORD(SendMessage(hwndLV, LVM_SETICONSPACING, 0, MakeLong(cx, cy)));
end;

function ListView_SetExtendedListViewStyle(hwndLV: HWND; dw: DWORD): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, dw));
end;

function ListView_SetExtendedListViewStyleEx(hwndLV: HWND; dwMask: DWORD; dw: DWORD): BOOL; inline;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SETEXTENDEDLISTVIEWSTYLE, dwMask, dw));
end;

function ListView_GetExtendedListViewStyle(hwndLV: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hwndLV, LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0));
end;

function ListView_GetSubItemRect(hwndLV: HWND; iItem, iSubItem: Integer;
  code: DWORD; prc: PRect): BOOL;
begin
  if prc <> nil then
  begin
    prc^.Top := iSubItem;
    prc^.Left := code;
  end;
  Result := BOOL(SendMessage(hwndLV, LVM_GETSUBITEMRECT, iItem, LPARAM(prc)));
end;

function ListView_SubItemHitTest(hwndLV: HWND; plvhti: PLVHitTestInfo): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_SUBITEMHITTEST, 0, LPARAM(plvhti)));
end;

function ListView_SubItemHitTestEx(hwndLV: HWND; plvhti: PLVHitTestInfo): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_SUBITEMHITTEST, WPARAM(-1), LPARAM(plvhti)));
end;

function ListView_SetColumnOrderArray(hwndLV: HWND; iCount: Integer;
  pi: PInteger): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SETCOLUMNORDERARRAY, iCount,
    LPARAM(pi)));
end;

function ListView_GetColumnOrderArray(hwndLV: HWND; iCount: Integer;
  pi: PInteger): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_GETCOLUMNORDERARRAY, iCount,
    LPARAM(pi)));
end;

function ListView_SetHotItem(hwndLV: HWND; i: Integer): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_SETHOTITEM, i, 0));
end;

function ListView_GetHotItem(hwndLV: HWND): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETHOTITEM, 0, 0));
end;

function ListView_SetHotCursor(hwndLV: HWND; hcur: HCURSOR): HCURSOR;
begin
  Result := HCURSOR(SendMessage(hwndLV, LVM_SETHOTCURSOR, 0, hcur));
end;

function ListView_GetHotCursor(hwndLV: HWND): HCURSOR;
begin
  Result := HCURSOR(SendMessage(hwndLV, LVM_GETHOTCURSOR, 0, 0));
end;

function ListView_ApproximateViewRect(hwndLV: HWND; iWidth, iHeight: Word;
  iCount: Integer): DWORD;
begin
  Result := DWORD(SendMessage(hwndLV, LVM_APPROXIMATEVIEWRECT, iCount,
    MakeLParam(iWidth, iHeight)));
end;

function ListView_SetWorkAreas(hwndLV: HWND; nWorkAreas: Integer; prc: PRect): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SETWORKAREA, nWorkAreas, LPARAM(prc)));
end;

function ListView_GetSelectionMark(hwnd: HWND): Integer;
begin
  Result := Integer(SendMessage(hwnd, LVM_GETSELECTIONMARK, 0, 0));
end;

function ListView_SetSelectionMark(hwnd: HWND; i: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, LVM_SETSELECTIONMARK, 0, i));
end;

function ListView_GetWorkAreas(hwnd: HWND; nWorkAreas: Integer; prc: PRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETWORKAREAS, nWorkAreas, LPARAM(prc)));
end;

function ListView_SetHoverTime(hwndLV: HWND; dwHoverTimeMs: DWORD): DWORD;
begin
  Result := DWORD(SendMessage(hwndLV, LVM_SETHOVERTIME, 0, dwHoverTimeMs));
end;

function ListView_GetHoverTime(hwndLV: HWND): Integer;
begin
  Result := Integer(SendMessage(hwndLV, LVM_GETHOVERTIME, 0, 0));
end;

function ListView_GetNumberOfWorkAreas(hwnd: HWND; pnWorkAreas: PInteger): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETNUMBEROFWORKAREAS, 0, LPARAM(pnWorkAreas));
end;

function ListView_SetToolTips(hwndLV: HWND; hwndNewHwnd: HWND): HWND;
begin
  Result := HWND(SendMessage(hwndLV, LVM_SETTOOLTIPS, WPARAM(hwndNewHwnd), 0));
end;

function ListView_GetToolTips(hwndLV: HWND): HWND;
begin
  Result := HWND(SendMessage(hwndLV, LVM_GETTOOLTIPS, 0, 0));
end;

function ListView_SortItemsEx(hwndLV: HWND; _pfnCompare: TLVCompare; _lPrm: LPARAM): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SORTITEMSEX, WPARAM(_lPrm), LPARAM(@_pfnCompare)));
end;

function ListView_SetSelectedColumn(hwnd: HWND; iCol: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETSELECTEDCOLUMN, WPARAM(iCol), 0);
end;

function ListView_SetView(hwnd: HWND; iView: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETVIEW, WPARAM(DWORD(iView)), 0);
end;

function ListView_GetView(hwnd: HWND): Integer;
begin
  Result := DWORD(SendMessage(hwnd, LVM_GETVIEW, 0, 0));
end;

function ListView_InsertGroup(hwnd: HWND; index: Integer; const pgrp: TLVGroup): Integer;
begin
  Result := SendMessage(hwnd, LVM_INSERTGROUP, WPARAM(index), LPARAM(@pgrp));
end;

function ListView_SetGroupInfo(hwnd: HWND; iGroupId: Integer; const pgrp: TLVGroup): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETGROUPINFO, WPARAM(iGroupId), LPARAM(@pgrp));
end;

function ListView_GetGroupInfo(hwnd: HWND; iGroupId: Integer; var pgrp: TLVGroup): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETGROUPINFO, WPARAM(iGroupId), LPARAM(@pgrp));
end;

function ListView_RemoveGroup(hwnd: HWND; iGroupId: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_REMOVEGROUP, WPARAM(iGroupId), 0);
end;

function ListView_MoveGroup(hwnd: HWND; iGroupId, toIndex: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_MOVEGROUP, WPARAM(iGroupId), LPARAM(toIndex));
end;

function ListView_GetGroupCount(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETGROUPCOUNT, 0, 0);
end;

function ListView_GetGroupInfoByIndex(hwnd: HWND; iIndex: Integer; var pgrp: TLVGroup): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETGROUPINFOBYINDEX, WPARAM(iIndex), LPARAM(@pgrp));
end;

function ListView_MoveItemToGroup(hwnd: HWND; idItemFrom, idGroupTo: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_MOVEITEMTOGROUP, WPARAM(idItemFrom), LPARAM(idGroupTo));
end;

function ListView_GetGroupRect(hwnd: HWND; iGroupId, iType: Integer; var prc: TRect): Integer;
begin
  prc.Top := iType;
  Result := SendMessage(hwnd, LVM_GETGROUPRECT, WPARAM(iGroupId), LPARAM(@prc));
end;

function ListView_SetGroupMetrics(hwnd: HWND; const pGroupMetrics: TLVGroupMetrics): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETGROUPMETRICS, 0, LPARAM(@pGroupMetrics));
end;

function ListView_GetGroupMetrics(hwnd: HWND; var pGroupMetrics: TLVGroupMetrics): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETGROUPMETRICS, 0, LPARAM(@pGroupMetrics));
end;

function ListView_EnableGroupView(hwnd: HWND; fEnable: BOOL): Integer;
begin
  Result := SendMessage(hwnd, LVM_ENABLEGROUPVIEW, WPARAM(fEnable), 0);
end;

function ListView_SortGroups(hwnd: HWND; pfnGroupCompare: TFNLVGroupCompare; plv: Pointer): Integer;
begin
  Result := SendMessage(hwnd, LVM_SORTGROUPS, WPARAM(@pfnGroupCompare), LPARAM(plv));
end;

function ListView_InsertGroupSorted(hwnd: HWND; const structInsert: TLVInsertGroupSorted): Integer;
begin
  Result := SendMessage(hwnd, LVM_INSERTGROUPSORTED, WPARAM(@structInsert), 0);
end;

function ListView_RemoveAllGroups(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, LVM_REMOVEALLGROUPS, 0, 0);
end;

function ListView_HasGroup(hwnd: HWND; dwGroupId: Integer): Integer;
begin
  Result := SendMessage(hwnd, LVM_HASGROUP, dwGroupId, 0);
end;

function ListView_SetGroupState(hwnd: HWND; dwGroupId, dwMask, dwState: UINT): Integer;
var
  LGroup: TLVGroup;
begin
  LGroup.cbSize := SizeOf(LGroup);
  LGroup.mask := LVGF_STATE;
  LGroup.stateMask := dwMask;
  LGroup.state := dwState;
  Result := SendMessage(hwnd, LVM_SETGROUPINFO, WPARAM(dwGroupId), LPARAM(@LGroup));
end;

function ListView_GetGroupState(hwnd: HWND; dwGroupId, dwMask: UINT): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETGROUPSTATE, WPARAM(dwGroupId), LPARAM(dwMask));
end;

function ListView_GetFocusedGroup(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETFOCUSEDGROUP, 0, 0);
end;

function ListView_SetTileViewInfo(hwnd: HWND; const ptvi: TLVTileViewInfo): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETTILEVIEWINFO, 0, LPARAM(@ptvi));
end;

function ListView_GetTileViewInfo(hwnd: HWND; var ptvi: TLVTileViewInfo): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETTILEVIEWINFO, 0, LPARAM(@ptvi));
end;

function ListView_SetTileInfo(hwnd: HWND; const pti: TLVTileInfo): Integer;
begin
  Result := SendMessage(hwnd, LVM_SETTILEINFO, 0, LPARAM(@pti));
end;

function ListView_GetTileInfo(hwnd: HWND; var pti: TLVTileInfo): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETTILEINFO, 0, LPARAM(@pti));
end;

function ListView_SetInsertMark(hwnd: HWND; const lvim: TLVInsertMark): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_SETINSERTMARK, 0, LPARAM(@lvim)));
end;

function ListView_GetInsertMark(hwnd: HWND; var lvim: TLVInsertMark): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETINSERTMARK, 0, LPARAM(@lvim)));
end;

function ListView_InsertMarkHitTest(hwnd: HWND; const point: TPoint;
  const lvim: TLVInsertMark): Integer;
begin
  Result := SendMessage(hwnd, LVM_INSERTMARKHITTEST, WPARAM(@point), LPARAM(@lvim));
end;

function ListView_GetInsertMarkRect(hwnd: HWND; var rc: TRect): Integer;
begin
  Result := SendMessage(hwnd, LVM_GETINSERTMARKRECT, 0, LPARAM(@rc));
end;

function ListView_SetInsertMarkColor(hwnd: HWND; color: TColorRef): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_SETINSERTMARKCOLOR, 0, LPARAM(color)));
end;

function ListView_GetInsertMarkColor(hwnd: HWND): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_GETINSERTMARKCOLOR, 0, 0));
end;

function ListView_SetInfoTip(hwndLV: HWND; const plvInfoTip: TLVSetInfoTip): BOOL;
begin
  Result := BOOL(SendMessage(hwndLV, LVM_SETINFOTIP, 0, LPARAM(@plvInfoTip)));
end;

function ListView_GetSelectedColumn(hwnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hwnd, LVM_GETSELECTEDCOLUMN, 0, 0));
end;

function ListView_IsGroupViewEnabled(hwnd: HWND): BOOL;
begin
Result := BOOL(SendMessage(hwnd, LVM_ISGROUPVIEWENABLED, 0, 0));
end;

function ListView_GetOutlineColor(hwnd: HWND): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_GETOUTLINECOLOR, 0, 0));
end;

function ListView_SetOutlineColor(hwnd: HWND; color: TColorRef): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, LVM_SETOUTLINECOLOR, 0, LPARAM(color)));
end;

function ListView_CancelEditLabel(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, LVM_CANCELEDITLABEL, 0, 0);
end;

function ListView_MapIndexToID(hwnd: HWND; index: UINT): UINT;
begin
  Result := UINT(SendMessage(hwnd, LVM_MAPINDEXTOID, WPARAM(index), 0));
end;

function ListView_MapIDToIndex(hwnd: HWND; id: UINT): UINT;
begin
  Result := UINT(SendMessage(hwnd, LVM_MAPIDTOINDEX, WPARAM(id), 0));
end;

function ListView_IsItemVisible(hwnd: HWND; index: UINT): UINT;
begin
  Result := UINT(SendMessage(hwnd, LVM_ISITEMVISIBLE, WPARAM(index), 0));
end;

function ListView_SetGroupHeaderImageList(hwnd: HWND; himl: HIMAGELIST): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, LVM_SETIMAGELIST, LVSIL_GROUPHEADER, LPARAM(himl)));
end;

function ListView_GetGroupHeaderImageList(hwnd: HWND): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, LVM_GETIMAGELIST, LVSIL_GROUPHEADER, 0));
end;

function ListView_GetEmptyText(hwnd: HWND; pszText: LPWSTR; cchText: UINT): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETEMPTYTEXT, WPARAM(cchText), LPARAM(pszText)));
end;

function ListView_GetFooterRect(hwnd: HWND; var prc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETFOOTERRECT, 0, LPARAM(@prc)));
end;

function ListView_GetFooterInfo(hwnd: HWND; var plvfi: TLVFooterInfo): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETFOOTERINFO, 0, LPARAM(@plvfi)));
end;

function ListView_GetFooterItemRect(hwnd: HWND; iItem: UINT; var prc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETFOOTERITEMRECT, iItem, LPARAM(@prc)));
end;

function ListView_GetFooterItem(hwnd: HWND; iItem: UINT; var pfi: TLVFooterItem): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETFOOTERITEM, iItem, LPARAM(@pfi)));
end;

function ListView_GetItemIndexRect(hwnd: HWND; const plvii: TLVItemIndex;
  iSubItem, code: Integer; var prc: TRect): BOOL;
begin
  prc.Top := iSubItem;
  prc.Left := Code;
  Result := BOOL(SendMessage(hwnd, LVM_GETITEMINDEXRECT, WPARAM(@plvii), LPARAM(@prc)));
end;

function ListView_SetItemIndexState(hwnd: HWND; const plvii: TLVItemIndex;
  data, mask: UINT): HRESULT;
var
  LItem: TLVItem;
begin
  LItem.stateMask := mask;
  LItem.state := data;
  Result := HRESULT(SendMessage(hwnd, LVM_SETITEMSTATE, WPARAM(@plvii), LPARAM(@LItem)));
end;

function ListView_GetNextItemIndex(hwnd: HWND; var plvii: TLVItemIndex;
  flags: LPARAM): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETNEXTITEMINDEX, WPARAM(@plvii),
    MakeLParam(flags, 0)));
end;

function ListView_SetBkImage(hwnd: HWND; plvbki: PLVBKImage): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_SETBKIMAGE, 0, LPARAM(plvbki)));
end;
function ListView_SetBkImageA(hwnd: HWND; plvbki: PLVBKImageA): BOOL;
begin
  Result := BOOL(SendMessageA(hwnd, LVM_SETBKIMAGEA, 0, LPARAM(plvbki)));
end;
function ListView_SetBkImageW(hwnd: HWND; plvbki: PLVBKImageW): BOOL;
begin
  Result := BOOL(SendMessageW(hwnd, LVM_SETBKIMAGEW, 0, LPARAM(plvbki)));
end;

function ListView_GetBkImage(hwnd: HWND; plvbki: PLVBKImage): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, LVM_GETBKIMAGE, 0, LPARAM(plvbki)));
end;
function ListView_GetBkImageA(hwnd: HWND; plvbki: PLVBKImageA): BOOL;
begin
  Result := BOOL(SendMessageA(hwnd, LVM_GETBKIMAGEA, 0, LPARAM(plvbki)));
end;
function ListView_GetBkImageW(hwnd: HWND; plvbki: PLVBKImageW): BOOL;
begin
  Result := BOOL(SendMessageW(hwnd, LVM_GETBKIMAGEW, 0, LPARAM(plvbki)));
end;

{ Tree View }

function TreeView_InsertItem(hwnd: HWND; const lpis: TTVInsertStruct): HTreeItem;
begin
  Result := HTreeItem(SendMessage(hwnd, TVM_INSERTITEM, 0, LPARAM(@lpis)));
end;
function TreeView_InsertItemA(hwnd: HWND; const lpis: TTVInsertStructA): HTreeItem;
begin
  Result := HTreeItem(SendMessageA(hwnd, TVM_INSERTITEMA, 0, LPARAM(@lpis)));
end;
function TreeView_InsertItemW(hwnd: HWND; const lpis: TTVInsertStructW): HTreeItem;
begin
  Result := HTreeItem(SendMessageW(hwnd, TVM_INSERTITEMW, 0, LPARAM(@lpis)));
end;

function TreeView_DeleteItem(hwnd: HWND; hitem: HTreeItem): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_DELETEITEM, 0, LPARAM(hitem)));
end;

function TreeView_DeleteAllItems(hwnd: HWND): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_DELETEITEM, 0, LPARAM(TVI_ROOT)));
end;

function TreeView_Expand(hwnd: HWND; hitem: HTreeItem; code: Integer): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_EXPAND, code, LPARAM(hitem)));
end;

function TreeView_GetItemRect(hwnd: HWND; hitem: HTreeItem;
  var prc: TRect; code: Bool): Bool;
begin
  HTreeItem(Pointer(@prc)^) := hitem;
  Result := Bool(SendMessage(hwnd, TVM_GETITEMRECT, WPARAM(code), LPARAM(@prc)));
end;

function TreeView_GetCount(hwnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_GETCOUNT, 0, 0));
end;

function TreeView_GetIndent(hwnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_GETINDENT, 0, 0));
end;

function TreeView_SetIndent(hwnd: HWND; indent: Integer): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_SETINDENT, indent, 0));
end;

function TreeView_GetImageList(hwnd: HWND; iImage: Integer): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, TVM_GETIMAGELIST, iImage, 0));
end;

function TreeView_SetImageList(hwnd: HWND; himl: HIMAGELIST;
  iImage: Integer): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, TVM_SETIMAGELIST, iImage, LPARAM(himl)));
end;

function TreeView_GetNextItem(hwnd: HWND; hitem: HTreeItem; code: Integer): HTreeItem;
begin
  Result := HTreeItem(SendMessage(hwnd, TVM_GETNEXTITEM, code, LPARAM(hitem)));
end;

function TreeView_GetChild(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_CHILD);
end;

function TreeView_GetNextSibling(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_NEXT);
end;

function TreeView_GetPrevSibling(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUS);
end;

function TreeView_GetParent(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_PARENT);
end;

function TreeView_GetFirstVisible(hwnd: HWND): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, nil,  TVGN_FIRSTVISIBLE);
end;

function TreeView_GetNextVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_NEXTVISIBLE);
end;

function TreeView_GetPrevVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_PREVIOUSVISIBLE);
end;

function TreeView_GetSelection(hwnd: HWND): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, nil, TVGN_CARET);
end;

function TreeView_GetDropHilite(hwnd: HWND): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, nil, TVGN_DROPHILITE);
end;

function TreeView_GetRoot(hwnd: HWND): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, nil, TVGN_ROOT);
end;

function TreeView_GetLastVisible(hwnd: HWND): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, nil,  TVGN_LASTVISIBLE);
end;

function TreeView_GetNextSelected(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_GetNextItem(hwnd, hitem, TVGN_NEXTSELECTED);
end;

function TreeView_Select(hwnd: HWND; hitem: HTreeItem;
  code: Integer): HTreeItem;
begin
  Result := HTreeItem(SendMessage(hwnd, TVM_SELECTITEM, code, LPARAM(hitem)));
end;

function TreeView_SelectItem(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_Select(hwnd, hitem, TVGN_CARET);
end;

function TreeView_SelectDropTarget(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_Select(hwnd, hitem, TVGN_DROPHILITE);
end;

function TreeView_SelectSetFirstVisible(hwnd: HWND; hitem: HTreeItem): HTreeItem;
begin
  Result := TreeView_Select(hwnd, hitem, TVGN_FIRSTVISIBLE);
end;

function TreeView_GetItem(hwnd: HWND; var pitem: TTVItem): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_GETITEM, 0, LPARAM(@pitem)));
end;
function TreeView_GetItemA(hwnd: HWND; var pitem: TTVItemA): Bool;
begin
  Result := Bool(SendMessageA(hwnd, TVM_GETITEMA, 0, LPARAM(@pitem)));
end;
function TreeView_GetItemW(hwnd: HWND; var pitem: TTVItemW): Bool;
begin
  Result := Bool(SendMessageW(hwnd, TVM_GETITEMW, 0, LPARAM(@pitem)));
end;

function TreeView_SetItem(hwnd: HWND; const pitem: TTVItem): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_SETITEM, 0, LPARAM(@pitem)));
end;

function TreeView_SetItem(hwnd: HWND; const pitem: TTVItemEx): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_SETITEM, 0, LPARAM(@pitem)));
end;
function TreeView_SetItemA(hwnd: HWND; const pitem: TTVItemA): Bool;
begin
  Result := Bool(SendMessageA(hwnd, TVM_SETITEMA, 0, LPARAM(@pitem)));
end;

function TreeView_SetItemA(hwnd: HWND; const pitem: TTVItemExA): Bool;
begin
  Result := Bool(SendMessageA(hwnd, TVM_SETITEMA, 0, LPARAM(@pitem)));
end;
function TreeView_SetItemW(hwnd: HWND; const pitem: TTVItemW): Bool;
begin
  Result := Bool(SendMessageW(hwnd, TVM_SETITEMW, 0, LPARAM(@pitem)));
end;

function TreeView_SetItemW(hwnd: HWND; const pitem: TTVItemExW): Bool;
begin
  Result := Bool(SendMessageW(hwnd, TVM_SETITEMW, 0, LPARAM(@pitem)));
end;

function TreeView_EditLabel(hwnd: HWND; hitem: HTreeItem): HWND;
begin
  Result := Winapi.Windows.HWND(SendMessage(hwnd, TVM_EDITLABEL, 0, LPARAM(hitem)));
end;
function TreeView_EditLabelA(hwnd: HWND; hitem: HTreeItem): HWND;
begin
  Result := Winapi.Windows.HWND(SendMessageA(hwnd, TVM_EDITLABELA, 0, LPARAM(hitem)));
end;
function TreeView_EditLabelW(hwnd: HWND; hitem: HTreeItem): HWND;
begin
  Result := Winapi.Windows.HWND(SendMessageW(hwnd, TVM_EDITLABELW, 0, LPARAM(hitem)));
end;

function TreeView_GetEditControl(hwnd: HWND): HWND;
begin
  Result := Winapi.Windows.HWND(SendMessage(hwnd, TVM_GETEDITCONTROL, 0, 0));
end;

function TreeView_GetVisibleCount(hwnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_GETVISIBLECOUNT, 0, 0));
end;

function TreeView_HitTest(hwnd: HWND; var lpht: TTVHitTestInfo): HTreeItem;
begin
  Result := HTreeItem(SendMessage(hwnd, TVM_HITTEST, 0, LPARAM(@lpht)));
end;

function TreeView_CreateDragImage(hwnd: HWND; hitem: HTreeItem): HIMAGELIST;
begin
  Result := HIMAGELIST(SendMessage(hwnd, TVM_CREATEDRAGIMAGE, 0, LPARAM(hitem)));
end;

function TreeView_SortChildren(hwnd: HWND; hitem: HTreeItem;
  recurse: Bool): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_SORTCHILDREN, WPARAM(recurse), LPARAM(hitem)));
end;

function TreeView_EnsureVisible(hwnd: HWND; hitem: HTreeItem): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_ENSUREVISIBLE, 0, LPARAM(hitem)));
end;

function TreeView_SortChildrenCB(hwnd: HWND; const psort: TTVSortCB;
  recurse: Integer): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_SORTCHILDRENCB, recurse, LPARAM(@psort)));
end;

function TreeView_EndEditLabelNow(hwnd: HWND; fCancel: Bool): Bool;
begin
  Result := Bool(SendMessage(hwnd, TVM_ENDEDITLABELNOW, WPARAM(fCancel), 0));
end;

function TreeView_GetISearchString(hwndTV: HWND; lpsz: LPWSTR): Bool;
begin
  Result := Bool(SendMessage(hwndTV, TVM_GETISEARCHSTRING, 0, LPARAM(lpsz)));
end;
function TreeView_GetISearchStringA(hwndTV: HWND; lpsz: LPSTR): Bool;
begin
  Result := Bool(SendMessageA(hwndTV, TVM_GETISEARCHSTRINGA, 0, LPARAM(lpsz)));
end;
function TreeView_GetISearchStringW(hwndTV: HWND; lpsz: LPWSTR): Bool;
begin
  Result := Bool(SendMessageW(hwndTV, TVM_GETISEARCHSTRINGW, 0, LPARAM(lpsz)));
end;

function TreeView_SetToolTips(wnd: HWND; hwndTT: HWND): HWND;
begin
  Result := HWND(SendMessage(wnd, TVM_SETTOOLTIPS, WPARAM(hwndTT), 0));
end;

function TreeView_GetToolTips(wnd: HWND): HWND;
begin
  Result := HWND(SendMessage(wnd, TVM_GETTOOLTIPS, 0, 0));
end;

function TreeView_SetInsertMark(hwnd: HWND; hItem: Integer; fAfter: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TVM_SETINSERTMARK, WPARAM(fAfter), LPARAM(hItem)));
end;

function TreeView_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TVM_SETUNICODEFORMAT, WPARAM(fUnicode), 0));
end;

function TreeView_GetUnicodeFormat(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TVM_GETUNICODEFORMAT, 0, 0));
end;

function TreeView_SetItemHeight(hwnd: HWND; iHeight: Integer): Integer;
begin
  Result := SendMessage(hwnd, TVM_SETITEMHEIGHT, iHeight, 0);
end;

function TreeView_GetItemHeight(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, TVM_GETITEMHEIGHT, 0, 0);
end;

function TreeView_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETBKCOLOR, 0, LPARAM(clr)));
end;

function TreeView_SetTextColor(hwnd: HWND; clr: COLORREF): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETTEXTCOLOR, 0, LPARAM(clr)));
end;

function TreeView_GetBkColor(hwnd: HWND): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_GETBKCOLOR, 0, 0));
end;

function TreeView_GetTextColor(hwnd: HWND): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_GETTEXTCOLOR, 0, 0));
end;

function TreeView_SetScrollTime(hwnd: HWND; uTime: UINT): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_SETSCROLLTIME, uTime, 0));
end;

function TreeView_GetScrollTime(hwnd: HWND): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_GETSCROLLTIME, 0, 0));
end;

function TreeView_SetInsertMarkColor(hwnd: HWND; clr: COLORREF): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETINSERTMARKCOLOR, 0, LPARAM(clr)));
end;

function TreeView_GetInsertMarkColor(hwnd: HWND): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_GETINSERTMARKCOLOR, 0, 0));
end;

function TreeView_SetItemState(hwndTV: HWND; hti: HTreeItem; State, Mask: UINT): UINT;
var
  LItem: TTVItem;
begin
  LItem.mask := TVIF_STATE;
  LItem.hItem := hti;
  LItem.stateMask := Mask;
  LItem.state := State;
  Result := UINT(SendMessage(hwndTV, TVM_SETITEM, 0, LPARAM(@LItem)));
end;

function TreeView_SetCheckState(hwndTV: HWND; hti: HTreeItem; fCheck: BOOL): UINT;
var
  LState: UINT;
begin
  if IndexToStateImageMask(Integer(fCheck)) = 0 then
    LState := 1
  else
    LState := 2;
  Result := TreeView_SetItemState(hwndTV, hti, LState, TVIS_STATEIMAGEMASK);
end;

function TreeView_GetItemState(hwndTV: HWND; hti: HTreeItem; mask: UINT): UINT;
begin
  Result := UINT(SendMessage(hwndTV, TVM_GETITEMSTATE, WPARAM(hti), LPARAM(mask)));
end;

function TreeView_GetCheckState(hwndTV: HWND; hti: HTreeItem): UINT;
begin
  Result := (UINT(SendMessage(hwndTV, TVM_GETITEMSTATE, WPARAM(hti), TVIS_STATEIMAGEMASK)) shr 12) - 1; 
end;

function TreeView_SetLineColor(hwnd: HWND; clr: TColorRef): TColorRef;
begin
  Result := TColorRef(SendMessage(hwnd, TVM_SETLINECOLOR, 0, LPARAM(clr)));
end;

function TreeView_GetLineColor(hwnd: HWND): Integer;
begin
  Result := TColorRef(SendMessage(hwnd, TVM_GETLINECOLOR, 0, 0));
end;

function TreeView_MapAccIDToHTREEITEM(hwnd: HWND; id: UINT): HTreeItem;
begin
  Result := HTreeItem(SendMessage(hwnd, TVM_MAPACCIDTOHTREEITEM, id, 0));
end;

function TreeView_MapHTREEITEMToAccID(hwnd: HWND; hti: HTreeItem): UINT;
begin
  Result := UINT(SendMessage(hwnd, TVM_MAPHTREEITEMTOACCID, WPARAM(hti), 0));
end;

function TreeView_SetExtendedStyle(hwnd: HWND; dw: DWORD; mask: UINT): UINT;
begin
  Result := DWORD(SendMessage(hwnd, TVM_SETEXTENDEDSTYLE, mask, dw));
end;

function TreeView_GetExtendedStyle(hwnd: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TVM_GETEXTENDEDSTYLE, 0, 0));
end;

function TreeView_SetAutoScrollInfo(hwnd: HWND; uPixPerSec, uUpdateTime: UINT): LRESULT;
begin
  Result := SendMessage(hwnd, TVM_SETAUTOSCROLLINFO, WPARAM(uPixPerSec), LPARAM(uUpdateTime));
end;

function TreeView_GetSelectedCount(hwnd: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TVM_GETSELECTEDCOUNT, 0, 0));
end;

function TreeView_ShowInfoTip(hwnd: HWND; hti: HTreeItem): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TVM_SHOWINFOTIP, 0, LPARAM(hti)));
end;

function TreeView_GetItemPartRect(hwnd: HWND; hitem: HTreeItem; var prc: TRect;
  partid: TTVItemPart): BOOL;
var
  Info: TTVGetItemPartRectInfo;
begin
  Info.hti := hitem;
  Info.prc := @prc;
  Info.partID := partid;
  Result := BOOL(SendMessage(hwnd, TVM_GETITEMPARTRECT, 0, LPARAM(@Info)));
end;


{ Tab control }

function TabCtrl_HitTest(hwndTC: HWND; pinfo: PTCHitTestInfo): Integer;
begin
  Result := SendMessage(hwndTC, TCM_HITTEST, 0, LPARAM(pinfo));
end;

function TabCtrl_HitTest(hwndTC: HWND; const pinfo: TTCHitTestInfo): Integer;
begin
  Result := SendMessage(hwndTC, TCM_HITTEST, 0, LPARAM(@pinfo));
end;

function TabCtrl_SetItemExtra(hwndTC: HWND; cb: Integer): BOOL;
begin
  Result := BOOL(SendMessage(hwndTC, TCM_SETITEMEXTRA, cb, 0));
end;

function TabCtrl_AdjustRect(hwnd: HWND; bLarger: BOOL; prc: PRect): Integer;
begin
  Result := SendMessage(hwnd, TCM_ADJUSTRECT, WPARAM(bLarger), LPARAM(prc));
end;

function TabCtrl_SetItemSize(hwnd: HWND; x, y: Integer): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TCM_SETITEMSIZE, 0, MAKELPARAM(x, y)));
end;

procedure TabCtrl_RemoveImage(hwnd: HWND; i: Integer);
begin
  SendMessage(hwnd, TCM_REMOVEIMAGE, i, 0);
end;

procedure TabCtrl_SetPadding(hwnd: HWND; cx, cy: Integer);
begin
  SendMessage(hwnd, TCM_SETPADDING, 0, MAKELPARAM(cx, cy));
end;

function TabCtrl_GetRowCount(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, TCM_GETROWCOUNT, 0, 0);
end;

function TabCtrl_GetToolTips(wnd: HWND): HWND;
begin
  Result := HWND(SendMessage(wnd, TCM_GETTOOLTIPS, 0, 0));
end;

procedure TabCtrl_SetToolTips(hwnd: HWND; hwndTT: HWND);
begin
  SendMessage(hwnd, TCM_SETTOOLTIPS, WPARAM(hwndTT), 0);
end;

function TabCtrl_GetCurFocus(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, TCM_GETCURFOCUS, 0, 0);
end;

procedure TabCtrl_SetCurFocus(hwnd: HWND; i: Integer);
begin
  SendMessage(hwnd,TCM_SETCURFOCUS, i, 0);
end;

function TabCtrl_SetMinTabWidth(hwnd: HWND; x: Integer): Integer;
begin
  Result := Integer(SendMessage(hwnd, TCM_SETMINTABWIDTH, 0, x));
end;

procedure TabCtrl_DeselectAll(hwnd: HWND; fExcludeFocus: BOOL);
begin
  SendMessage(hwnd, TCM_DESELECTALL, WPARAM(fExcludeFocus), 0)
end;

function TabCtrl_HighlightItem(hwnd: HWND; i: Integer; fHighlight: WordBool): BOOL;
begin
  Result :=  BOOL(SendMessage(hwnd, TCM_HIGHLIGHTITEM, i, MAKELONG(Word(fHighlight), 0)));
end;

function TabCtrl_SetExtendedStyle(hwnd: HWND; dw: DWORD): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TCM_SETEXTENDEDSTYLE, 0, dw));
end;

function TabCtrl_GetExtendedStyle(hwnd: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, TCM_GETEXTENDEDSTYLE, 0, 0));
end;

function TabCtrl_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TCM_SETUNICODEFORMAT, WPARAM(fUnicode), 0));
end;

function TabCtrl_GetUnicodeFormat(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TCM_GETUNICODEFORMAT, 0, 0));
end;

function TabCtrl_GetItemRect(hwnd: HWND; i: Integer; var prc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TCM_GETITEMRECT, i, LPARAM(@prc)));
end;

{ Animate control }

function Animate_Create(hwndP: HWND; id: HMENU; dwStyle: DWORD; hInstance: HINST): HWND;
begin
  Result := CreateWindow(ANIMATE_CLASS, nil, dwStyle, 0, 0, 0, 0, hwndP, id,
    hInstance, nil);
end;

function Animate_Open(hwnd: HWND; szName: PChar): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, ACM_OPENA, 0, LPARAM(szName)));
end;

function Animate_OpenEx(hwnd: HWND; hInst: HINST; szName: PChar): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, ACM_OPENA, WPARAM(hInst), LPARAM(szName)));
end;

function Animate_Play(hwnd: HWND; from, _to: Word; rep: UINT): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, ACM_PLAY, rep, MAKELONG(from, _to)));
end;

function Animate_Stop(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, ACM_STOP, 0, 0));
end;

function Animate_Close(hwnd: HWND): BOOL;
begin
  Result := Animate_Open(hwnd, nil);
end;

function Animate_Seek(hwnd: HWND; frame: Word): BOOL;
begin
  Result := Animate_Play(hwnd, frame, frame, 1);
end;

{ MonthCal control }

function MonthCal_GetCurSel(hmc: HWND; var pst: TSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_GETCURSEL, 0, LPARAM(@pst)));
end;

function MonthCal_SetCurSel(hmc: HWND; const pst: TSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETCURSEL, 0, LPARAM(@pst)));
end;

function MonthCal_GetMaxSelCount(hmc: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETMAXSELCOUNT, 0, 0));
end;

function MonthCal_SetMaxSelCount(hmc: HWND; n: UINT): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETMAXSELCOUNT, n, 0));
end;

function MonthCal_GetSelRange(hmc: HWND; rgst: PSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_GETSELRANGE, 0, LPARAM(rgst)));
end;

function MonthCal_SetSelRange(hmc: HWND; rgst: PSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETSELRANGE, 0, LPARAM(rgst)));
end;

function MonthCal_GetMonthRange(hmc: HWND; gmr: DWORD; rgst: PSystemTime): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETMONTHRANGE, gmr, LPARAM(rgst)));
end;

function MonthCal_SetDayState(hmc: HWND; cbds: Integer; const rgds: TNMDayState): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETDAYSTATE, cbds, LPARAM(@rgds)));
end;

function MonthCal_GetMinReqRect(hmc: HWND; var prc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_GETMINREQRECT, 0, LPARAM(@prc)));
end;

function MonthCal_SetToday(hmc: HWND; const pst: TSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETTODAY, 0, LPARAM(@pst)));
end;

function MonthCal_GetToday(hmc: HWND; var pst: TSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_GETTODAY, 0, LPARAM(@pst)));
end;

function MonthCal_HitTest(hmc: HWND; var info: TMCHitTestInfo): DWORD;
begin
  // Fallback code to keep "old" code working
  // Windows < Vista can't handle the larger struct
  if (info.cbSize = SizeOf(TMCHitTestInfo)) and (Win32MajorVersion < 6) then
  begin
    if Win32MajorVersion = 0 then
      InitVersionInfo;
    if Win32MajorVersion < 6 then
      info.cbSize := TMCHitTestInfo.SizeOf;
  end;
  Result := DWORD(SendMessage(hmc, MCM_HITTEST, 0, LPARAM(@info)));
end;

function MonthCal_SetColor(hmc: HWND; iColor: Integer; clr: TColorRef): TColorRef;
begin
  Result := TColorRef(SendMessage(hmc, MCM_SETCOLOR, iColor, clr));
end;

function MonthCal_GetColor(hmc: HWND; iColor: Integer): TColorRef;
begin
  Result := TColorRef(SendMessage(hmc, MCM_SETCOLOR, iColor, 0));
end;

function MonthCal_SetFirstDayOfWeek(hmc: HWND; iDay: Integer): Integer;
begin
  Result := Integer(SendMessage(hmc, MCM_SETFIRSTDAYOFWEEK, 0, iDay));
end;

function MonthCal_GetFirstDayOfWeek(hmc: HWND): Integer;
begin
  Result := Integer(SendMessage(hmc, MCM_GETFIRSTDAYOFWEEK, 0, 0));
end;

function MonthCal_GetRange(hmc: HWND; rgst: PSystemTime): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETRANGE, 0, LPARAM(rgst)));
end;

function Monthcal_SetRange(hmc: HWND; gdtr: DWORD; rgst: PSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETRANGE, gdtr, LPARAM(rgst)));
end;

function MonthCal_GetMonthDelta(hmc: HWND): Integer;
begin
  Result := Integer(SendMessage(hmc, MCM_GETMONTHDELTA, 0, 0));
end;

function MonthCal_SetMonthDelta(hmc: HWND; n: Integer): Integer;
begin
  Result := Integer(SendMessage(hmc, MCM_SETMONTHDELTA, n, 0));
end;

function MonthCal_GetMaxTodayWidth(hmc: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETMAXTODAYWIDTH, 0, 0));
end;

function MonthCal_SetUnicodeFormat(hwnd: HWND; fUnicode: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, MCM_SETUNICODEFORMAT, WPARAM(fUnicode), 0));
end;

function MonthCal_GetUnicodeFormat(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, MCM_GETUNICODEFORMAT, 0, 0));
end;

function MonthCal_GetCurrentView(hmc: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETCURRENTVIEW, 0, 0));
end;

function MonthCal_GetCalendarCount(hmc: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hmc, MCM_GETCALENDARCOUNT, 0, 0));
end;

function MonthCal_GetCalendarGridInfo(hmc: HWND; pmcGridInfo: PMCGridInfo): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_GETCALENDARGRIDINFO, 0, LPARAM(pmcGridInfo)));
end;

function MonthCal_GetCALID(hmc: HWND): CALID;
begin
  Result := CALID(SendMessage(hmc, MCM_GETCALID, 0, 0));
end;

procedure MonthCal_SetCALID(hmc: HWND; calid: CALID);
begin
  SendMessage(hmc, MCM_SETCALID, WPARAM(calid), 0);
end;

procedure MonthCal_SizeRectToMin(hmc: HWND; prc: PRect);
begin
  SendMessage(hmc, MCM_SIZERECTTOMIN, 0, LPARAM(prc));
end;

procedure MonthCal_SetCalendarBorder(hmc: HWND; fset: BOOL; xyborder: Integer);
begin
  SendMessage(hmc, MCM_SETCALENDARBORDER, WPARAM(fset), LPARAM(xyborder));
end;

function MonthCal_GetCalendarBorder(hmc: HWND): Integer;
begin
  Result := Integer(SendMessage(hmc, MCM_GETCALENDARBORDER, 0, 0));
end;

function MonthCal_SetCurrentView(hmc: HWND; dwNewView: DWORD): BOOL;
begin
  Result := BOOL(SendMessage(hmc, MCM_SETCURRENTVIEW, 0, LPARAM(dwNewView)));
end;

class function MCHITTESTINFO.SizeOf: Integer;
begin
  if Win32MajorVersion = 0 then
    InitVersionInfo;
  if Win32MajorVersion >= 6 then
    // Size of complete structure
    Result := System.SizeOf(MCHITTESTINFO)
  else
    // Platforms prior to Vista do not recognize the additional fields
    Result := System.SizeOf(MCHITTESTINFO) - (System.SizeOf(TRect) + System.SizeOf(Integer) * 3);
end;

{ Date/Time Picker }

function DateTime_GetSystemTime(hdp: HWND; var pst: TSystemTime): DWORD;
begin
  Result := DWORD(SendMessage(hdp, DTM_GETSYSTEMTIME, 0, LPARAM(@pst)));
end;

function DateTime_SetSystemTime(hdp: HWND; gd: DWORD; const pst: TSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hdp, DTM_SETSYSTEMTIME, gd, LPARAM(@pst)));
end;

function DateTime_GetRange(hdp: HWND; rgst: PSystemTime): DWORD;
begin
  Result := DWORD(SendMessage(hdp, DTM_GETRANGE, 0, LPARAM(rgst)));
end;

function DateTime_SetRange(hdp: HWND; gdtr: DWORD; rgst: PSystemTime): BOOL;
begin
  Result := BOOL(SendMessage(hdp, DTM_SETRANGE, gdtr, LPARAM(rgst)));
end;

function DateTime_SetFormat(hdp: HWND; sz: LPWSTR): BOOL;
begin
  Result := BOOL(SendMessage(hdp, DTM_SETFORMAT, 0, LPARAM(sz)));
end;
function DateTime_SetFormatA(hdp: HWND; sz: LPSTR): BOOL;
begin
  Result := BOOL(SendMessageA(hdp, DTM_SETFORMATA, 0, LPARAM(sz)));
end;
function DateTime_SetFormatW(hdp: HWND; sz: LPWSTR): BOOL;
begin
  Result := BOOL(SendMessageW(hdp, DTM_SETFORMATW, 0, LPARAM(sz)));
end;

function DateTime_SetFormat(hdp: HWND; const sz: UnicodeString): BOOL;
begin
  Result := BOOL(SendMessage(hdp, DTM_SETFORMAT, 0, LPARAM(LPWSTR(sz))));
end;
function DateTime_SetFormatA(hdp: HWND; const sz: AnsiString): BOOL;
begin
  Result := BOOL(SendMessageA(hdp, DTM_SETFORMATA, 0, LPARAM(LPSTR(sz))));
end;
function DateTime_SetFormatW(hdp: HWND; const sz: UnicodeString): BOOL;
begin
  Result := BOOL(SendMessageW(hdp, DTM_SETFORMATW, 0, LPARAM(LPWSTR(sz))));
end;

function DateTime_SetMonthCalColor(hdp: HWND; iColor: DWORD; clr: TColorRef): TColorRef;
begin
  Result := TColorRef(SendMessage(hdp, DTM_SETMCCOLOR, iColor, clr));
end;

function DateTime_GetMonthCalColor(hdp: HWND; iColor: DWORD): TColorRef;
begin
  Result := TColorRef(SendMessage(hdp, DTM_GETMCCOLOR, iColor, 0));
end;

function DateTime_GetMonthCal(hdp: HWND): HWND;
begin
  Result := HWND(SendMessage(hdp, DTM_GETMONTHCAL, 0, 0));
end;

procedure DateTime_SetMonthCalFont(hdp: HWND; hfont: HFONT; fRedraw: BOOL);
begin
  SendMessage(hdp, DTM_SETMCFONT, WPARAM(hfont), LPARAM(fRedraw));
end;

function DateTime_GetMonthCalFont(hdp: HWND): HFONT;
begin
  Result := HFONT(SendMessage(hdp, DTM_GETMCFONT, 0, 0));
end;

procedure DateTime_SetMonthCalStyle(hdp: HWND; dwStyle: DWORD);
begin
  SendMessage(hdp, DTM_SETMCSTYLE, 0, LPARAM(dwStyle));
end;

function DateTime_GetMonthCalStyle(hdp: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hdp, DTM_GETMCSTYLE, 0, 0));
end;

procedure DateTime_CloseMonthCal(hdp: HWND);
begin
  SendMessage(hdp, DTM_CLOSEMONTHCAL, 0, 0);
end;

procedure DateTime_GetDateTimePickerInfo(hdp: HWND; var pdtpi: TDateTimePickerInfo);
begin
  SendMessage(hdp, DTM_GETDATETIMEPICKERINFO, 0, LPARAM(@pdtpi));
end;

function DateTime_GetIdealSize(hdp: HWND; var psize: TSize): BOOL;
begin
  Result := BOOL(SendMessage(hdp, DTM_GETIDEALSIZE, 0, LPARAM(@psize)));
end;

{ IP Address edit control }

function MAKEIPRANGE(low, high: Byte): LPARAM;
begin
  Result := high;
  Result := (Result shl 8) + low;
end;

function MAKEIPADDRESS(b1, b2, b3, b4: DWORD): LPARAM;
begin
  Result := (b1 shl 24) + (b2 shl 16) + (b3 shl 8) + b4;
end;

function FIRST_IPADDRESS(x: DWORD): DWORD;
begin
  Result := (x shr 24) and $FF;
end;

function SECOND_IPADDRESS(x: DWORD): DWORD;
begin
  Result := (x shr 16) and $FF;
end;

function THIRD_IPADDRESS(x: DWORD): DWORD;
begin
  Result := (x shr 8) and $FF;
end;

function FOURTH_IPADDRESS(x: DWORD): DWORD;
begin
  Result := x and $FF;
end;

{ Pager control }

procedure Pager_SetChild(hwnd: HWND; hwndChild: HWND);
begin
  SendMessage(hwnd, PGM_SETCHILD, 0, LPARAM(hwndChild));
end;

procedure Pager_RecalcSize(hwnd: HWND);
begin
  SendMessage(hwnd, PGM_RECALCSIZE, 0, 0);
end;

procedure Pager_ForwardMouse(hwnd: HWND; bForward: BOOL);
begin
  SendMessage(hwnd, PGM_FORWARDMOUSE, WPARAM(bForward), 0);
end;

function Pager_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, PGM_SETBKCOLOR, 0, LPARAM(clr)));
end;

function Pager_GetBkColor(hwnd: HWND): COLORREF;
begin
  Result := COLORREF(SendMessage(hwnd, PGM_GETBKCOLOR, 0, 0));
end;

function Pager_SetBorder(hwnd: HWND; iBorder: Integer): Integer;
begin
  Result := SendMessage(hwnd, PGM_SETBORDER, 0, iBorder);
end;

function Pager_GetBorder(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, PGM_GETBORDER, 0, 0);
end;

function Pager_SetPos(hwnd: HWND; iPos: Integer): Integer;
begin
  Result := SendMessage(hwnd, PGM_SETPOS, 0, iPos);
end;

function Pager_GetPos(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, PGM_GETPOS, 0, 0);
end;

function Pager_SetButtonSize(hwnd: HWND; iSize: Integer): Integer;
begin
  Result := SendMessage(hwnd, PGM_SETBUTTONSIZE, 0, iSize);
end;

function Pager_GetButtonSize(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, PGM_GETBUTTONSIZE, 0,0);
end;

function Pager_GetButtonState(hwnd: HWND; iButton: Integer): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, PGM_GETBUTTONSTATE, 0, iButton));
end;

procedure Pager_GetDropTarget(hwnd: HWND; ppdt: Pointer{!!});
begin
  SendMessage(hwnd, PGM_GETDROPTARGET, 0, LPARAM(ppdt));
end;

{ Button Control Functions }

function Button_GetIdealSize(hwnd: HWND; var psize: TSize): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_GETIDEALSIZE, 0, LPARAM(@psize)));
end;

function Button_SetImageList(hwnd: HWND; const pbuttonImagelist: TButtonImagelist): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETIMAGELIST, 0, LPARAM(@pbuttonImagelist)));
end;

function Button_GetImageList(hwnd: HWND; var pbuttonImagelist: TButtonImageList): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_GETIMAGELIST, 0, LPARAM(@pbuttonImagelist)));
end;

function Button_SetTextMargin(hwnd: HWND; const pmargin: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETTEXTMARGIN, 0, LPARAM(@pmargin)));
end;

function Button_GetTextMargin(hwnd: HWND; var pmargin: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_GETTEXTMARGIN, 0, LPARAM(@pmargin)));
end;

function Button_SetDropDownState(hwnd: HWND; fDropDown: BOOL): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETDROPDOWNSTATE, WPARAM(fDropDown), 0));
end;

function Button_SetSplitInfo(hwnd: HWND; const pInfo: TButtonSplitinfo): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETSPLITINFO, 0, LPARAM(@pInfo)));
end;

function Button_GetSplitInfo(hwnd: HWND; var pInfo: TButtonSplitinfo): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_GETSPLITINFO, 0, LPARAM(@pInfo)));
end;

function Button_SetNote(hwnd: HWND; psz: LPCWSTR): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETNOTE, 0, LPARAM(psz)));
end;

function Button_SetNote(hwnd: HWND; const psz: UnicodeString): BOOL; overload;
begin
  Result := BOOL(SendMessage(hwnd, BCM_SETNOTE, 0, LPARAM(PWideChar(psz))));
end;

function Button_GetNote(hwnd: HWND; psz: LPCWSTR; var pcc: Integer): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, BCM_GETNOTE, WPARAM(@pcc), LPARAM(psz)));
end;

function Button_GetNoteLength(hwnd: HWND): LRESULT;
begin
  Result := SendMessage(hwnd, BCM_GETNOTELENGTH, 0, 0);
end;

function Button_SetElevationRequiredState(hwnd: HWND; fRequired: BOOL): LRESULT;
begin
  Result := SendMessage(hwnd, BCM_SETSHIELD, 0, LPARAM(fRequired));
end;

{ Edit Control Functions }

function Edit_SetCueBannerText(hwnd: HWND; lpwText: LPCWSTR): BOOL; inline;
begin
  Result := BOOL(SendMessage(hwnd, EM_SETCUEBANNER, 0, lParam(lpwText)));
end;

function Edit_GetCueBannerText(hwnd: HWND; lpwText: LPCWSTR; cchText: Longint): BOOL; inline;
begin
  Result := BOOL(SendMessage(hwnd, EM_GETCUEBANNER, wParam(lpwText), lParam(cchText)));
end;

function Edit_ShowBalloonTip(hwnd: HWND; const peditballoontip: TEditBalloonTip): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, EM_SHOWBALLOONTIP, 0, lParam(@peditballoontip)));
end;

function Edit_HideBalloonTip(hwnd: HWND): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, EM_HIDEBALLOONTIP, 0, 0));
end;

procedure Edit_SetHilite(hwndCtl: HWND; ichStart, ichEnd: Integer);
begin
  SendMessage(hwndCtl, EM_SETHILITE, ichStart, ichEnd);
end;

function Edit_GetHilite(hwndCtl: HWND): LRESULT;
begin
  Result := SendMessage(hwndCtl, EM_GETHILITE, 0, 0);
end;

{ ComboBox Control Functions }

function ComboBox_SetMinVisible(hwnd: HWND; iMinVisible: Integer): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, CB_SETMINVISIBLE, WPARAM(iMinVisible), 0));
end;

function ComboBox_GetMinVisible(hwnd: HWND): Integer;
begin
  Result := SendMessage(hwnd, CB_GETMINVISIBLE, 0, 0);
end;

function ComboBox_SetCueBannerText(hwnd: HWND; lpcwText: LPCWSTR): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, CB_SETCUEBANNER, 0, LPARAM(lpcwText)));
end;

function ComboBox_GetCueBannerText(hwnd: HWND; lpwText: LPCWSTR; cchText: Integer): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, CB_GETCUEBANNER, WPARAM(lpwText), LPARAM(@cchText)));
end;

{ TrackMouseEvent }

function _TrackMouseEvent;              external cctrl name '_TrackMouseEvent';

{ Flat Scrollbar APIs }

function FlatSB_EnableScrollBar;        external cctrl name 'FlatSB_EnableScrollBar';
function FlatSB_GetScrollInfo;          external cctrl name 'FlatSB_GetScrollInfo';
function FlatSB_GetScrollPos;           external cctrl name 'FlatSB_GetScrollPos';
function FlatSB_GetScrollProp;          external cctrl name 'FlatSB_GetScrollProp';
function FlatSB_GetScrollRange;         external cctrl name 'FlatSB_GetScrollRange';
function FlatSB_SetScrollInfo;          external cctrl name 'FlatSB_SetScrollInfo';
function FlatSB_SetScrollPos;           external cctrl name 'FlatSB_SetScrollPos';
function FlatSB_SetScrollProp;          external cctrl name 'FlatSB_SetScrollProp';
function FlatSB_SetScrollPropPtr;       external cctrl name 'FlatSB_SetScrollProp';
function FlatSB_SetScrollRange;         external cctrl name 'FlatSB_SetScrollRange';
function FlatSB_ShowScrollBar;          external cctrl name 'FlatSB_ShowScrollBar';
function InitializeFlatSB;              external cctrl name 'InitializeFlatSB';
procedure UninitializeFlatSB;           external cctrl name 'UninitializeFlatSB';

{$IFDEF CPUX64}
function FlatSB_GetScrollPropPtr;       external cctrl name 'FlatSB_GetScrollPropPtr';
{$ELSE}
function FlatSB_GetScrollPropPtr;       external cctrl name 'FlatSB_GetScrollProp';
{$ENDIF}

{ Subclassing }

var
  _SetWindowSubclass: function(hWnd: HWND; pfnSubclass: SUBCLASSPROC; 
    uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): BOOL; stdcall;

  _GetWindowSubclass: function(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
    uIdSubclass: UINT_PTR; var pdwRefData: DWORD_PTR): BOOL; stdcall;

  _RemoveWindowSubclass: function(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
    uIdSubclass: UINT_PTR): BOOL; stdcall;

  _DefSubclassProc: function(hWnd: HWND; uMsg: UINT; wParam: WPARAM;
    lParam: LPARAM): LRESULT; stdcall;

function SetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR; dwRefData: DWORD_PTR): BOOL;
begin
  if Assigned(_SetWindowSubclass) then
    Result := _SetWindowSubclass(hWnd, pfnSubclass, uIdSubclass, dwRefData)
  else
  begin
    Result := False;
    if ComCtl32DLL > 0 then
    begin
      _SetWindowSubclass := GetProcAddress(ComCtl32DLL, 'SetWindowSubclass'); // Do not localize
      if Assigned(_SetWindowSubclass) then
        Result := _SetWindowSubclass(hWnd, pfnSubclass, uIdSubclass, dwRefData);
    end;
  end;
end;

function GetWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR; var pdwRefData: DWORD_PTR): BOOL;
begin
  if Assigned(_GetWindowSubclass) then
    Result := _GetWindowSubclass(hWnd, pfnSubclass, uIdSubclass, pdwRefData)
  else
  begin
    Result := False;
    if ComCtl32DLL > 0 then
    begin
      _GetWindowSubclass := GetProcAddress(ComCtl32DLL, 'GetWindowSubclass'); // Do not localize
      if Assigned(_GetWindowSubclass) then
        Result := _GetWindowSubclass(hWnd, pfnSubclass, uIdSubclass, pdwRefData);
    end;
  end;
end;

function RemoveWindowSubclass(hWnd: HWND; pfnSubclass: SUBCLASSPROC;
  uIdSubclass: UINT_PTR): BOOL;
begin
  if Assigned(_RemoveWindowSubclass) then
    Result := _RemoveWindowSubclass(hWnd, pfnSubclass, uIdSubclass)
  else
  begin
    Result := False;
    if ComCtl32DLL > 0 then
    begin
      _RemoveWindowSubclass := GetProcAddress(ComCtl32DLL, 'RemoveWindowSubclass'); // Do not localize
      if Assigned(_RemoveWindowSubclass) then
        Result := _RemoveWindowSubclass(hWnd, pfnSubclass, uIdSubclass);
    end;
  end;
end;

function DefSubclassProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  if Assigned(_DefSubclassProc) then
    Result := _DefSubclassProc(hWnd, uMsg, wParam, lParam)
  else
  begin
    Result := 0;
    if ComCtl32DLL > 0 then
    begin
      _DefSubclassProc := GetProcAddress(ComCtl32DLL, 'DefSubclassProc'); // Do not localize
      if Assigned(_DefSubclassProc) then
        Result := _DefSubclassProc(hWnd, uMsg, wParam, lParam);
    end;
  end;
end;

var
  _LoadIconMetric: function(hinst: HINST; pszName: LPCWSTR; lims: Integer;
    var phico: HICON): HResult; stdcall;

  _LoadIconWithScaleDown: function(hinst: HINST; pszName: LPCWSTR; cx: Integer;
    cy: Integer; var phico: HICON): HResult; stdcall;

  _DrawShadowText: function(hdc: HDC; pszText: LPCWSTR; cch: UINT; const prc: TRect;
    dwFlags: DWORD; crText: COLORREF; crShadow: COLORREF; ixOffset: Integer;
    iyOffset: Integer): Integer; stdcall;

function LoadIconMetric(hinst: HINST; pszName: LPCWSTR; lims: Integer;
  var phico: HICON): HResult;
begin
  if Assigned(_LoadIconMetric) then
    Result := _LoadIconMetric(hinst, pszName, lims, phico)
  else
  begin
    Result := E_NOTIMPL;
    if ComCtl32DLL > 0 then
    begin
      _LoadIconMetric := GetProcAddress(ComCtl32DLL, 'LoadIconMetric'); // Do not localize
      if Assigned(_LoadIconMetric) then
        Result := _LoadIconMetric(hinst, pszName, lims, phico);
    end;
  end;
end;

function LoadIconWithScaleDown(hinst: HINST; pszName: LPCWSTR; cx: Integer;
  cy: Integer; var phico: HICON): HResult;
begin
  if Assigned(_LoadIconWithScaleDown) then
    Result := _LoadIconWithScaleDown(hinst, pszName, cx, cy, phico)
  else
  begin
    Result := E_NOTIMPL;
    if ComCtl32DLL > 0 then
    begin
      _LoadIconWithScaleDown := GetProcAddress(ComCtl32DLL, 'LoadIconWithScaleDown'); // Do not localize
      if Assigned(_LoadIconWithScaleDown) then
        Result := _LoadIconWithScaleDown(hinst, pszName, cx, cy, phico);
    end;
  end;
end;

function DrawShadowText(hdc: HDC; pszText: LPCWSTR; cch: UINT; const prc: TRect;
  dwFlags: DWORD; crText: COLORREF; crShadow: COLORREF; ixOffset: Integer;
  iyOffset: Integer): Integer;
begin
  if Assigned(_DrawShadowText) then
    Result := _DrawShadowText(hdc, pszText, cch, prc, dwFlags, crText, crShadow,
      ixOffset, iyOffset)
  else
  begin
    Result := 0;
    if ComCtl32DLL > 0 then
    begin
      _DrawShadowText := GetProcAddress(ComCtl32DLL, 'DrawShadowText'); // Do not localize
      if Assigned(_DrawShadowText) then
        Result := _DrawShadowText(hdc, pszText, cch, prc, dwFlags, crText,
          crShadow, ixOffset, iyOffset);
    end;
  end;
end;

var
  _DrawScrollArrow: procedure(hdc: HDC; lprc: PRect; wControlState: UINT;
    rgbOveride: COLORREF); stdcall;

procedure DrawScrollArrow(hdc: HDC; lprc: PRect; wControlState: UINT;
  rgbOveride: COLORREF);
begin
  if Assigned(_DrawScrollArrow) then
    _DrawScrollArrow(hdc, lprc, wControlState, rgbOveride)
  else
  begin
    if ComCtl32DLL > 0 then
    begin
      _DrawScrollArrow := GetProcAddress(ComCtl32DLL, 'DrawScrollArrow'); // Do not localize
      if Assigned(_DrawScrollArrow) then
        _DrawScrollArrow(hdc, lprc, wControlState, rgbOveride);
    end;
  end;
end;


{ Task Dialog }

var
  _TaskDialogIndirect: function(const pTaskConfig: TTaskDialogConfig;
    pnButton: PInteger; pnRadioButton: PInteger;
    pfVerificationFlagChecked: PBOOL): HRESULT; stdcall;

  _TaskDialog: function(hwndParent: HWND; hInstance: HINST;
    pszWindowTitle: LPCWSTR; pszMainInstruction: LPCWSTR; pszContent: LPCWSTR;
    dwCommonButtons: DWORD; pszIcon: LPCWSTR; pnButton: PInteger): HRESULT; stdcall;

function TaskDialogIndirect(const pTaskConfig: TTaskDialogConfig;
  pnButton: PInteger; pnRadioButton: PInteger; pfVerificationFlagChecked: PBOOL): HRESULT;
begin
  if Assigned(_TaskDialogIndirect) then
    Result := _TaskDialogIndirect(pTaskConfig, pnButton, pnRadioButton,
      pfVerificationFlagChecked)
  else
  begin
    InitComCtl;
    Result := E_NOTIMPL;
    if ComCtl32DLL <> 0 then
    begin
      @_TaskDialogIndirect := GetProcAddress(ComCtl32DLL, 'TaskDialogIndirect');
      if Assigned(_TaskDialogIndirect) then
        Result := _TaskDialogIndirect(pTaskConfig, pnButton, pnRadioButton,
          pfVerificationFlagChecked)
    end;
  end;
end;

function TaskDialog(hwndParent: HWND; hInstance: HINST; pszWindowTitle,
  pszMainInstruction, pszContent: LPCWSTR; dwCommonButtons: DWORD;
  pszIcon: LPCWSTR; pnButton: PInteger): HRESULT;
begin
  if Assigned(_TaskDialog) then
    Result := _TaskDialog(hwndParent, hInstance, pszWindowTitle, pszMainInstruction,
      pszContent, dwCommonButtons, pszIcon, pnButton)
  else
  begin
    InitComCtl;
    Result := E_NOTIMPL;
    if ComCtl32DLL <> 0 then
    begin
      @_TaskDialog := GetProcAddress(ComCtl32DLL, 'TaskDialog');
      if Assigned(_TaskDialog) then
        Result := _TaskDialog(hwndParent, hInstance, pszWindowTitle, pszMainInstruction,
          pszContent, dwCommonButtons, pszIcon, pnButton);
    end;
  end;
end;

end.
