{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: winuser.h                              }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{             Windows Messages and Types                }
{*******************************************************}

unit Winapi.Messages;

{$ALIGN ON}
{$WEAKPACKAGEUNIT}

interface
{$HPPEMIT LEGACYHPP}

uses Winapi.Windows;

{ Window Messages }

const
  {$EXTERNALSYM WM_NULL}
  WM_NULL             = $0000;
  {$EXTERNALSYM WM_CREATE}
  WM_CREATE           = $0001;
  {$EXTERNALSYM WM_DESTROY}
  WM_DESTROY          = $0002;
  {$EXTERNALSYM WM_MOVE}
  WM_MOVE             = $0003;
  {$EXTERNALSYM WM_SIZE}
  WM_SIZE             = $0005;
  {$EXTERNALSYM WM_ACTIVATE}
  WM_ACTIVATE         = $0006;
  {$EXTERNALSYM WM_SETFOCUS}
  WM_SETFOCUS         = $0007;
  {$EXTERNALSYM WM_KILLFOCUS}
  WM_KILLFOCUS        = $0008;
  {$EXTERNALSYM WM_ENABLE}
  WM_ENABLE           = $000A;
  {$EXTERNALSYM WM_SETREDRAW}
  WM_SETREDRAW        = $000B;
  {$EXTERNALSYM WM_SETTEXT}
  WM_SETTEXT          = $000C;
  {$EXTERNALSYM WM_GETTEXT}
  WM_GETTEXT          = $000D;
  {$EXTERNALSYM WM_GETTEXTLENGTH}
  WM_GETTEXTLENGTH    = $000E;
  {$EXTERNALSYM WM_PAINT}
  WM_PAINT            = $000F;
  {$EXTERNALSYM WM_CLOSE}
  WM_CLOSE            = $0010;
  {$EXTERNALSYM WM_QUERYENDSESSION}
  WM_QUERYENDSESSION  = $0011;
  {$EXTERNALSYM WM_QUIT}
  WM_QUIT             = $0012;
  {$EXTERNALSYM WM_QUERYOPEN}
  WM_QUERYOPEN        = $0013;
  {$EXTERNALSYM WM_ERASEBKGND}
  WM_ERASEBKGND       = $0014;
  {$EXTERNALSYM WM_SYSCOLORCHANGE}
  WM_SYSCOLORCHANGE   = $0015;
  {$EXTERNALSYM WM_ENDSESSION}
  WM_ENDSESSION       = $0016;
  {$EXTERNALSYM WM_SYSTEMERROR}
  WM_SYSTEMERROR      = $0017;
  {$EXTERNALSYM WM_SHOWWINDOW}
  WM_SHOWWINDOW       = $0018;
  {$EXTERNALSYM WM_CTLCOLOR}
  WM_CTLCOLOR         = $0019;
  {$EXTERNALSYM WM_WININICHANGE}
  WM_WININICHANGE     = $001A;
  {$EXTERNALSYM WM_SETTINGCHANGE}
  WM_SETTINGCHANGE = WM_WININICHANGE;
  {$EXTERNALSYM WM_DEVMODECHANGE}
  WM_DEVMODECHANGE    = $001B;
  {$EXTERNALSYM WM_ACTIVATEAPP}
  WM_ACTIVATEAPP      = $001C;
  {$EXTERNALSYM WM_FONTCHANGE}
  WM_FONTCHANGE       = $001D;
  {$EXTERNALSYM WM_TIMECHANGE}
  WM_TIMECHANGE       = $001E;
  {$EXTERNALSYM WM_CANCELMODE}
  WM_CANCELMODE       = $001F;
  {$EXTERNALSYM WM_SETCURSOR}
  WM_SETCURSOR        = $0020;
  {$EXTERNALSYM WM_MOUSEACTIVATE}
  WM_MOUSEACTIVATE    = $0021;
  {$EXTERNALSYM WM_CHILDACTIVATE}
  WM_CHILDACTIVATE    = $0022;
  {$EXTERNALSYM WM_QUEUESYNC}
  WM_QUEUESYNC        = $0023;
  {$EXTERNALSYM WM_GETMINMAXINFO}
  WM_GETMINMAXINFO    = $0024;
  {$EXTERNALSYM WM_PAINTICON}
  WM_PAINTICON        = $0026;
  {$EXTERNALSYM WM_ICONERASEBKGND}
  WM_ICONERASEBKGND   = $0027;
  {$EXTERNALSYM WM_NEXTDLGCTL}
  WM_NEXTDLGCTL       = $0028;
  {$EXTERNALSYM WM_SPOOLERSTATUS}
  WM_SPOOLERSTATUS    = $002A;
  {$EXTERNALSYM WM_DRAWITEM}
  WM_DRAWITEM         = $002B;
  {$EXTERNALSYM WM_MEASUREITEM}
  WM_MEASUREITEM      = $002C;
  {$EXTERNALSYM WM_DELETEITEM}
  WM_DELETEITEM       = $002D;
  {$EXTERNALSYM WM_VKEYTOITEM}
  WM_VKEYTOITEM       = $002E;
  {$EXTERNALSYM WM_CHARTOITEM}
  WM_CHARTOITEM       = $002F;
  {$EXTERNALSYM WM_SETFONT}
  WM_SETFONT          = $0030;
  {$EXTERNALSYM WM_GETFONT}
  WM_GETFONT          = $0031;
  {$EXTERNALSYM WM_SETHOTKEY}
  WM_SETHOTKEY        = $0032;
  {$EXTERNALSYM WM_GETHOTKEY}
  WM_GETHOTKEY        = $0033;
  {$EXTERNALSYM WM_QUERYDRAGICON}
  WM_QUERYDRAGICON    = $0037;
  {$EXTERNALSYM WM_COMPAREITEM}
  WM_COMPAREITEM      = $0039;
  {$EXTERNALSYM WM_GETOBJECT}
  WM_GETOBJECT        = $003D;
  {$EXTERNALSYM WM_COMPACTING}
  WM_COMPACTING       = $0041;

  {$EXTERNALSYM WM_COMMNOTIFY}
  WM_COMMNOTIFY       = $0044;    { obsolete in Win32}

  {$EXTERNALSYM WM_WINDOWPOSCHANGING}
  WM_WINDOWPOSCHANGING = $0046;
  {$EXTERNALSYM WM_WINDOWPOSCHANGED}
  WM_WINDOWPOSCHANGED = $0047;
  {$EXTERNALSYM WM_POWER}
  WM_POWER            = $0048;
  {$EXTERNALSYM WM_COPYGLOBALDATA}
  WM_COPYGLOBALDATA   = $0049;
  {$EXTERNALSYM WM_COPYDATA}
  WM_COPYDATA         = $004A;
  {$EXTERNALSYM WM_CANCELJOURNAL}
  WM_CANCELJOURNAL    = $004B;
  {$EXTERNALSYM WM_NOTIFY}
  WM_NOTIFY           = $004E;
  {$EXTERNALSYM WM_INPUTLANGCHANGEREQUEST}
  WM_INPUTLANGCHANGEREQUEST = $0050;
  {$EXTERNALSYM WM_INPUTLANGCHANGE}
  WM_INPUTLANGCHANGE  = $0051;
  {$EXTERNALSYM WM_TCARD}
  WM_TCARD            = $0052;
  {$EXTERNALSYM WM_HELP}
  WM_HELP             = $0053;
  {$EXTERNALSYM WM_USERCHANGED}
  WM_USERCHANGED      = $0054;
  {$EXTERNALSYM WM_NOTIFYFORMAT}
  WM_NOTIFYFORMAT     = $0055;

  {$EXTERNALSYM WM_CONTEXTMENU}
  WM_CONTEXTMENU      = $007B;
  {$EXTERNALSYM WM_STYLECHANGING}
  WM_STYLECHANGING    = $007C;
  {$EXTERNALSYM WM_STYLECHANGED}
  WM_STYLECHANGED     = $007D;
  {$EXTERNALSYM WM_DISPLAYCHANGE}
  WM_DISPLAYCHANGE    = $007E;
  {$EXTERNALSYM WM_GETICON}
  WM_GETICON          = $007F;
  {$EXTERNALSYM WM_SETICON}
  WM_SETICON          = $0080;

  {$EXTERNALSYM WM_NCCREATE}
  WM_NCCREATE         = $0081;
  {$EXTERNALSYM WM_NCDESTROY}
  WM_NCDESTROY        = $0082;
  {$EXTERNALSYM WM_NCCALCSIZE}
  WM_NCCALCSIZE       = $0083;
  {$EXTERNALSYM WM_NCHITTEST}
  WM_NCHITTEST        = $0084;
  {$EXTERNALSYM WM_NCPAINT}
  WM_NCPAINT          = $0085;
  {$EXTERNALSYM WM_NCACTIVATE}
  WM_NCACTIVATE       = $0086;
  {$EXTERNALSYM WM_GETDLGCODE}
  WM_GETDLGCODE       = $0087;
  {$EXTERNALSYM WM_NCMOUSEMOVE}
  WM_NCMOUSEMOVE      = $00A0;
  {$EXTERNALSYM WM_NCLBUTTONDOWN}
  WM_NCLBUTTONDOWN    = $00A1;
  {$EXTERNALSYM WM_NCLBUTTONUP}
  WM_NCLBUTTONUP      = $00A2;
  {$EXTERNALSYM WM_NCLBUTTONDBLCLK}
  WM_NCLBUTTONDBLCLK  = $00A3;
  {$EXTERNALSYM WM_NCRBUTTONDOWN}
  WM_NCRBUTTONDOWN    = $00A4;
  {$EXTERNALSYM WM_NCRBUTTONUP}
  WM_NCRBUTTONUP      = $00A5;
  {$EXTERNALSYM WM_NCRBUTTONDBLCLK}
  WM_NCRBUTTONDBLCLK  = $00A6;
  {$EXTERNALSYM WM_NCMBUTTONDOWN}
  WM_NCMBUTTONDOWN    = $00A7;
  {$EXTERNALSYM WM_NCMBUTTONUP}
  WM_NCMBUTTONUP      = $00A8;
  {$EXTERNALSYM WM_NCMBUTTONDBLCLK}
  WM_NCMBUTTONDBLCLK  = $00A9;

  {$EXTERNALSYM WM_NCXBUTTONDOWN}
  WM_NCXBUTTONDOWN = $00AB;
  {$EXTERNALSYM WM_NCXBUTTONUP}
  WM_NCXBUTTONUP = $00AC;
  {$EXTERNALSYM WM_NCXBUTTONDBLCLK}
  WM_NCXBUTTONDBLCLK = $00AD;
  {$EXTERNALSYM WM_INPUT_DEVICE_CHANGE}
  WM_INPUT_DEVICE_CHANGE = $00FE;
  {$EXTERNALSYM WM_INPUT}
  WM_INPUT = $00FF;

  {$EXTERNALSYM WM_KEYFIRST}
  WM_KEYFIRST         = $0100;
  {$EXTERNALSYM WM_KEYDOWN}
  WM_KEYDOWN          = $0100;
  {$EXTERNALSYM WM_KEYUP}
  WM_KEYUP            = $0101;
  {$EXTERNALSYM WM_CHAR}
  WM_CHAR             = $0102;
  {$EXTERNALSYM WM_DEADCHAR}
  WM_DEADCHAR         = $0103;
  {$EXTERNALSYM WM_SYSKEYDOWN}
  WM_SYSKEYDOWN       = $0104;
  {$EXTERNALSYM WM_SYSKEYUP}
  WM_SYSKEYUP         = $0105;
  {$EXTERNALSYM WM_SYSCHAR}
  WM_SYSCHAR          = $0106;
  {$EXTERNALSYM WM_SYSDEADCHAR}
  WM_SYSDEADCHAR      = $0107;
  {$EXTERNALSYM WM_UNICHAR}
  WM_UNICHAR          = $0109;
  {$EXTERNALSYM WM_KEYLAST}
  WM_KEYLAST          = $0109;

  {$EXTERNALSYM WM_INITDIALOG}
  WM_INITDIALOG       = $0110;
  {$EXTERNALSYM WM_COMMAND}
  WM_COMMAND          = $0111;
  {$EXTERNALSYM WM_SYSCOMMAND}
  WM_SYSCOMMAND       = $0112;
  {$EXTERNALSYM WM_TIMER}
  WM_TIMER            = $0113;
  {$EXTERNALSYM WM_HSCROLL}
  WM_HSCROLL          = $0114;
  {$EXTERNALSYM WM_VSCROLL}
  WM_VSCROLL          = $0115;
  {$EXTERNALSYM WM_INITMENU}
  WM_INITMENU         = $0116;
  {$EXTERNALSYM WM_INITMENUPOPUP}
  WM_INITMENUPOPUP    = $0117;

  WM_GESTURE = $0119;
  {$EXTERNALSYM WM_GESTURE}
  WM_GESTURENOTIFY = $011A;
  {$EXTERNALSYM WM_GESTURENOTIFY}

  {$EXTERNALSYM WM_MENUSELECT}
  WM_MENUSELECT       = $011F;
  {$EXTERNALSYM WM_MENUCHAR}
  WM_MENUCHAR         = $0120;
  {$EXTERNALSYM WM_ENTERIDLE}
  WM_ENTERIDLE        = $0121;

  {$EXTERNALSYM WM_MENURBUTTONUP}
  WM_MENURBUTTONUP    = $0122;
  {$EXTERNALSYM WM_MENUDRAG}
  WM_MENUDRAG         = $0123;
  {$EXTERNALSYM WM_MENUGETOBJECT}
  WM_MENUGETOBJECT    = $0124;
  {$EXTERNALSYM WM_UNINITMENUPOPUP}
  WM_UNINITMENUPOPUP  = $0125;
  {$EXTERNALSYM WM_MENUCOMMAND}
  WM_MENUCOMMAND      = $0126;

  {$EXTERNALSYM WM_CHANGEUISTATE}
  WM_CHANGEUISTATE    = $0127;
  {$EXTERNALSYM WM_UPDATEUISTATE}
  WM_UPDATEUISTATE    = $0128;
  {$EXTERNALSYM WM_QUERYUISTATE}
  WM_QUERYUISTATE     = $0129;

  {$EXTERNALSYM WM_CTLCOLORMSGBOX}
  WM_CTLCOLORMSGBOX   = $0132;
  {$EXTERNALSYM WM_CTLCOLOREDIT}
  WM_CTLCOLOREDIT     = $0133;
  {$EXTERNALSYM WM_CTLCOLORLISTBOX}
  WM_CTLCOLORLISTBOX  = $0134;
  {$EXTERNALSYM WM_CTLCOLORBTN}
  WM_CTLCOLORBTN      = $0135;
  {$EXTERNALSYM WM_CTLCOLORDLG}
  WM_CTLCOLORDLG      = $0136;
  {$EXTERNALSYM WM_CTLCOLORSCROLLBAR}
  WM_CTLCOLORSCROLLBAR= $0137;
  {$EXTERNALSYM WM_CTLCOLORSTATIC}
  WM_CTLCOLORSTATIC   = $0138;

  {$EXTERNALSYM WM_MOUSEFIRST}
  WM_MOUSEFIRST       = $0200;
  {$EXTERNALSYM WM_MOUSEMOVE}
  WM_MOUSEMOVE        = $0200;
  {$EXTERNALSYM WM_LBUTTONDOWN}
  WM_LBUTTONDOWN      = $0201;
  {$EXTERNALSYM WM_LBUTTONUP}
  WM_LBUTTONUP        = $0202;
  {$EXTERNALSYM WM_LBUTTONDBLCLK}
  WM_LBUTTONDBLCLK    = $0203;
  {$EXTERNALSYM WM_RBUTTONDOWN}
  WM_RBUTTONDOWN      = $0204;
  {$EXTERNALSYM WM_RBUTTONUP}
  WM_RBUTTONUP        = $0205;
  {$EXTERNALSYM WM_RBUTTONDBLCLK}
  WM_RBUTTONDBLCLK    = $0206;
  {$EXTERNALSYM WM_MBUTTONDOWN}
  WM_MBUTTONDOWN      = $0207;
  {$EXTERNALSYM WM_MBUTTONUP}
  WM_MBUTTONUP        = $0208;
  {$EXTERNALSYM WM_MBUTTONDBLCLK}
  WM_MBUTTONDBLCLK    = $0209;
  {$EXTERNALSYM WM_MOUSEWHEEL}
  WM_MOUSEWHEEL       = $020A;

  WM_XBUTTONDOWN = $020B; 
  {$EXTERNALSYM WM_XBUTTONDOWN}
  WM_XBUTTONUP = $020C; 
  {$EXTERNALSYM WM_XBUTTONUP}
  WM_XBUTTONDBLCLK = $020D; 
  {$EXTERNALSYM WM_XBUTTONDBLCLK}
  WM_MOUSEHWHEEL = $020E; 
  {$EXTERNALSYM WM_MOUSEHWHEEL}

  WM_MOUSELAST = $020E; 
  {$EXTERNALSYM WM_MOUSELAST}

  {$EXTERNALSYM WM_PARENTNOTIFY}
  WM_PARENTNOTIFY     = $0210;
  {$EXTERNALSYM WM_ENTERMENULOOP}
  WM_ENTERMENULOOP    = $0211;
  {$EXTERNALSYM WM_EXITMENULOOP}
  WM_EXITMENULOOP     = $0212;
  {$EXTERNALSYM WM_NEXTMENU}
  WM_NEXTMENU         = $0213;

  {$EXTERNALSYM WM_SIZING}
  WM_SIZING           = 532;
  {$EXTERNALSYM WM_CAPTURECHANGED}
  WM_CAPTURECHANGED   = 533;
  {$EXTERNALSYM WM_MOVING}
  WM_MOVING           = 534;
  {$EXTERNALSYM WM_POWERBROADCAST}
  WM_POWERBROADCAST   = 536;
  {$EXTERNALSYM WM_DEVICECHANGE}
  WM_DEVICECHANGE     = 537;

  {$EXTERNALSYM WM_IME_STARTCOMPOSITION}
  WM_IME_STARTCOMPOSITION        = $010D;
  {$EXTERNALSYM WM_IME_ENDCOMPOSITION}
  WM_IME_ENDCOMPOSITION          = $010E;
  {$EXTERNALSYM WM_IME_COMPOSITION}
  WM_IME_COMPOSITION             = $010F;
  {$EXTERNALSYM WM_IME_KEYLAST}
  WM_IME_KEYLAST                 = $010F;

  {$EXTERNALSYM WM_IME_SETCONTEXT}
  WM_IME_SETCONTEXT              = $0281;
  {$EXTERNALSYM WM_IME_NOTIFY}
  WM_IME_NOTIFY                  = $0282;
  {$EXTERNALSYM WM_IME_CONTROL}
  WM_IME_CONTROL                 = $0283;
  {$EXTERNALSYM WM_IME_COMPOSITIONFULL}
  WM_IME_COMPOSITIONFULL         = $0284;
  {$EXTERNALSYM WM_IME_SELECT}
  WM_IME_SELECT                  = $0285;
  {$EXTERNALSYM WM_IME_CHAR}
  WM_IME_CHAR                    = $0286;
  {$EXTERNALSYM WM_IME_REQUEST}
  WM_IME_REQUEST                 = $0288;

  {$EXTERNALSYM WM_IME_KEYDOWN}
  WM_IME_KEYDOWN                 = $0290;
  {$EXTERNALSYM WM_IME_KEYUP}
  WM_IME_KEYUP                   = $0291;

  {$EXTERNALSYM WM_MDICREATE}
  WM_MDICREATE        = $0220;
  {$EXTERNALSYM WM_MDIDESTROY}
  WM_MDIDESTROY       = $0221;
  {$EXTERNALSYM WM_MDIACTIVATE}
  WM_MDIACTIVATE      = $0222;
  {$EXTERNALSYM WM_MDIRESTORE}
  WM_MDIRESTORE       = $0223;
  {$EXTERNALSYM WM_MDINEXT}
  WM_MDINEXT          = $0224;
  {$EXTERNALSYM WM_MDIMAXIMIZE}
  WM_MDIMAXIMIZE      = $0225;
  {$EXTERNALSYM WM_MDITILE}
  WM_MDITILE          = $0226;
  {$EXTERNALSYM WM_MDICASCADE}
  WM_MDICASCADE       = $0227;
  {$EXTERNALSYM WM_MDIICONARRANGE}
  WM_MDIICONARRANGE   = $0228;
  {$EXTERNALSYM WM_MDIGETACTIVE}
  WM_MDIGETACTIVE     = $0229;
  {$EXTERNALSYM WM_MDISETMENU}
  WM_MDISETMENU       = $0230;

  {$EXTERNALSYM WM_ENTERSIZEMOVE}
  WM_ENTERSIZEMOVE    = $0231;
  {$EXTERNALSYM WM_EXITSIZEMOVE}
  WM_EXITSIZEMOVE     = $0232;
  {$EXTERNALSYM WM_DROPFILES}
  WM_DROPFILES        = $0233;
  {$EXTERNALSYM WM_MDIREFRESHMENU}
  WM_MDIREFRESHMENU   = $0234;

  WM_TOUCH            = $0240;
  {$EXTERNALSYM WM_TOUCH}

  {$EXTERNALSYM WM_MOUSEHOVER}
  WM_MOUSEHOVER       = $02A1;
  {$EXTERNALSYM WM_MOUSELEAVE}
  WM_MOUSELEAVE       = $02A3;

  {$EXTERNALSYM WM_NCMOUSEHOVER}
  WM_NCMOUSEHOVER     = $02A0;
  {$EXTERNALSYM WM_NCMOUSELEAVE}
  WM_NCMOUSELEAVE     = $02A2;
  {$EXTERNALSYM WM_WTSSESSION_CHANGE}
  WM_WTSSESSION_CHANGE = $02B1;

  {$EXTERNALSYM WM_TABLET_FIRST}
  WM_TABLET_FIRST     = $02C0;
  {$EXTERNALSYM WM_TABLET_LAST}
  WM_TABLET_LAST      = $02DF;

  {$EXTERNALSYM WM_DPICHANGED}
  WM_DPICHANGED       = $02E0;

  {$EXTERNALSYM WM_CUT}
  WM_CUT              = $0300;
  {$EXTERNALSYM WM_COPY}
  WM_COPY             = $0301;
  {$EXTERNALSYM WM_PASTE}
  WM_PASTE            = $0302;
  {$EXTERNALSYM WM_CLEAR}
  WM_CLEAR            = $0303;
  {$EXTERNALSYM WM_UNDO}
  WM_UNDO             = $0304;
  {$EXTERNALSYM WM_RENDERFORMAT}
  WM_RENDERFORMAT     = $0305;
  {$EXTERNALSYM WM_RENDERALLFORMATS}
  WM_RENDERALLFORMATS = $0306;
  {$EXTERNALSYM WM_DESTROYCLIPBOARD}
  WM_DESTROYCLIPBOARD = $0307;
  {$EXTERNALSYM WM_DRAWCLIPBOARD}
  WM_DRAWCLIPBOARD    = $0308;
  {$EXTERNALSYM WM_PAINTCLIPBOARD}
  WM_PAINTCLIPBOARD   = $0309;
  {$EXTERNALSYM WM_VSCROLLCLIPBOARD}
  WM_VSCROLLCLIPBOARD = $030A;
  {$EXTERNALSYM WM_SIZECLIPBOARD}
  WM_SIZECLIPBOARD    = $030B;
  {$EXTERNALSYM WM_ASKCBFORMATNAME}
  WM_ASKCBFORMATNAME  = $030C;
  {$EXTERNALSYM WM_CHANGECBCHAIN}
  WM_CHANGECBCHAIN    = $030D;
  {$EXTERNALSYM WM_HSCROLLCLIPBOARD}
  WM_HSCROLLCLIPBOARD = $030E;
  {$EXTERNALSYM WM_QUERYNEWPALETTE}
  WM_QUERYNEWPALETTE  = $030F;
  {$EXTERNALSYM WM_PALETTEISCHANGING}
  WM_PALETTEISCHANGING= $0310;
  {$EXTERNALSYM WM_PALETTECHANGED}
  WM_PALETTECHANGED   = $0311;
  {$EXTERNALSYM WM_HOTKEY}
  WM_HOTKEY           = $0312;

  {$EXTERNALSYM WM_PRINT}
  WM_PRINT            = 791;
  {$EXTERNALSYM WM_PRINTCLIENT}
  WM_PRINTCLIENT      = 792;
  {$EXTERNALSYM WM_APPCOMMAND}
  WM_APPCOMMAND       = $0319;
  {$EXTERNALSYM WM_THEMECHANGED}
  WM_THEMECHANGED     = $031A;

  {$EXTERNALSYM WM_CLIPBOARDUPDATE}
  WM_CLIPBOARDUPDATE  = $031D;

  {$EXTERNALSYM WM_HANDHELDFIRST}
  WM_HANDHELDFIRST    = 856;
  {$EXTERNALSYM WM_HANDHELDLAST}
  WM_HANDHELDLAST     = 863;

  {$EXTERNALSYM WM_PENWINFIRST}
  WM_PENWINFIRST      = $0380;
  {$EXTERNALSYM WM_PENWINLAST}
  WM_PENWINLAST       = $038F;

  {$EXTERNALSYM WM_COALESCE_FIRST}
  WM_COALESCE_FIRST   = $0390;
  {$EXTERNALSYM WM_COALESCE_LAST}
  WM_COALESCE_LAST    = $039F;

  {$EXTERNALSYM WM_DDE_FIRST}
  WM_DDE_FIRST        = $03E0;
  {$EXTERNALSYM WM_DDE_INITIATE}
  WM_DDE_INITIATE     = WM_DDE_FIRST + 0;
  {$EXTERNALSYM WM_DDE_TERMINATE}
  WM_DDE_TERMINATE    = WM_DDE_FIRST + 1;
  {$EXTERNALSYM WM_DDE_ADVISE}
  WM_DDE_ADVISE       = WM_DDE_FIRST + 2;
  {$EXTERNALSYM WM_DDE_UNADVISE}
  WM_DDE_UNADVISE     = WM_DDE_FIRST + 3;
  {$EXTERNALSYM WM_DDE_ACK}
  WM_DDE_ACK          = WM_DDE_FIRST + 4;
  {$EXTERNALSYM WM_DDE_DATA}
  WM_DDE_DATA         = WM_DDE_FIRST + 5;
  {$EXTERNALSYM WM_DDE_REQUEST}
  WM_DDE_REQUEST      = WM_DDE_FIRST + 6;
  {$EXTERNALSYM WM_DDE_POKE}
  WM_DDE_POKE         = WM_DDE_FIRST + 7;
  {$EXTERNALSYM WM_DDE_EXECUTE}
  WM_DDE_EXECUTE      = WM_DDE_FIRST + 8;
  {$EXTERNALSYM WM_DDE_LAST}
  WM_DDE_LAST         = WM_DDE_FIRST + 8;

  {$EXTERNALSYM WM_DWMCOMPOSITIONCHANGED}
  WM_DWMCOMPOSITIONCHANGED        = $031E; 
  {$EXTERNALSYM WM_DWMNCRENDERINGCHANGED}
  WM_DWMNCRENDERINGCHANGED        = $031F;
  {$EXTERNALSYM WM_DWMCOLORIZATIONCOLORCHANGED}
  WM_DWMCOLORIZATIONCOLORCHANGED  = $0320;
  {$EXTERNALSYM WM_DWMWINDOWMAXIMIZEDCHANGE}
  WM_DWMWINDOWMAXIMIZEDCHANGE     = $0321;

  {$EXTERNALSYM WM_DWMSENDICONICTHUMBNAIL}
  WM_DWMSENDICONICTHUMBNAIL       = $0323;
  {$EXTERNALSYM WM_DWMSENDICONICLIVEPREVIEWBITMAP}
  WM_DWMSENDICONICLIVEPREVIEWBITMAP = $0326;

  {$EXTERNALSYM WM_GETTITLEBARINFOEX}
  WM_GETTITLEBARINFOEX = $033F;

  WM_TABLET_DEFBASE = $02C0;
  {$EXTERNALSYM WM_TABLET_DEFBASE}
  WM_TABLET_MAXOFFSET = $20;
  {$EXTERNALSYM WM_TABLET_MAXOFFSET}
  WM_TABLET_ADDED = WM_TABLET_DEFBASE + 8;
  {$EXTERNALSYM WM_TABLET_ADDED}
  WM_TABLET_DELETED = WM_TABLET_DEFBASE + 9;
  {$EXTERNALSYM WM_TABLET_DELETED}
  WM_TABLET_FLICK = WM_TABLET_DEFBASE + 11;
  {$EXTERNALSYM WM_TABLET_FLICK}
  WM_TABLET_QUERYSYSTEMGESTURESTATUS = WM_TABLET_DEFBASE + 12;
  {$EXTERNALSYM WM_TABLET_QUERYSYSTEMGESTURESTATUS}

  {$EXTERNALSYM WM_APP}
  WM_APP = $8000;

{ NOTE: All Message Numbers below 0x0400 are RESERVED }

{ Private Window Messages Start Here }

  {$EXTERNALSYM WM_USER}
  WM_USER             = $0400;

{ Button Notification Codes }

const
  {$EXTERNALSYM BN_CLICKED}
  BN_CLICKED       = 0;
  {$EXTERNALSYM BN_PAINT}
  BN_PAINT         = 1;
  {$EXTERNALSYM BN_HILITE}
  BN_HILITE        = 2;
  {$EXTERNALSYM BN_UNHILITE}
  BN_UNHILITE      = 3;
  {$EXTERNALSYM BN_DISABLE}
  BN_DISABLE       = 4;
  {$EXTERNALSYM BN_DOUBLECLICKED}
  BN_DOUBLECLICKED = 5;
  {$EXTERNALSYM BN_PUSHED}
  BN_PUSHED = BN_HILITE;
  {$EXTERNALSYM BN_UNPUSHED}
  BN_UNPUSHED = BN_UNHILITE;
  {$EXTERNALSYM BN_DBLCLK}
  BN_DBLCLK = BN_DOUBLECLICKED;
  {$EXTERNALSYM BN_SETFOCUS}
  BN_SETFOCUS = 6;
  {$EXTERNALSYM BN_KILLFOCUS}
  BN_KILLFOCUS = 7;

{ Button Control Messages }
const
  {$EXTERNALSYM BM_GETCHECK}
  BM_GETCHECK = $00F0;
  {$EXTERNALSYM BM_SETCHECK}
  BM_SETCHECK = $00F1;
  {$EXTERNALSYM BM_GETSTATE}
  BM_GETSTATE = $00F2;
  {$EXTERNALSYM BM_SETSTATE}
  BM_SETSTATE = $00F3;
  {$EXTERNALSYM BM_SETSTYLE}
  BM_SETSTYLE = $00F4;
  {$EXTERNALSYM BM_CLICK}
  BM_CLICK    = $00F5;
  {$EXTERNALSYM BM_GETIMAGE}
  BM_GETIMAGE = $00F6;
  {$EXTERNALSYM BM_SETIMAGE}
  BM_SETIMAGE = $00F7;
  {$EXTERNALSYM BM_SETDONTCLICK}
  BM_SETDONTCLICK = $00F8;

{ Listbox Notification Codes }

const
  {$EXTERNALSYM LBN_ERRSPACE}
  LBN_ERRSPACE  = (-2);
  {$EXTERNALSYM LBN_SELCHANGE}
  LBN_SELCHANGE = 1;
  {$EXTERNALSYM LBN_DBLCLK}
  LBN_DBLCLK    = 2;
  {$EXTERNALSYM LBN_SELCANCEL}
  LBN_SELCANCEL = 3;
  {$EXTERNALSYM LBN_SETFOCUS}
  LBN_SETFOCUS  = 4;
  {$EXTERNALSYM LBN_KILLFOCUS}
  LBN_KILLFOCUS = 5;

{ Listbox messages }

const
  {$EXTERNALSYM LB_ADDSTRING}
  LB_ADDSTRING            = $0180;
  {$EXTERNALSYM LB_INSERTSTRING}
  LB_INSERTSTRING         = $0181;
  {$EXTERNALSYM LB_DELETESTRING}
  LB_DELETESTRING         = $0182;
  {$EXTERNALSYM LB_SELITEMRANGEEX}
  LB_SELITEMRANGEEX       = $0183;
  {$EXTERNALSYM LB_RESETCONTENT}
  LB_RESETCONTENT         = $0184;
  {$EXTERNALSYM LB_SETSEL}
  LB_SETSEL               = $0185;
  {$EXTERNALSYM LB_SETCURSEL}
  LB_SETCURSEL            = $0186;
  {$EXTERNALSYM LB_GETSEL}
  LB_GETSEL               = $0187;
  {$EXTERNALSYM LB_GETCURSEL}
  LB_GETCURSEL            = $0188;
  {$EXTERNALSYM LB_GETTEXT}
  LB_GETTEXT              = $0189;
  {$EXTERNALSYM LB_GETTEXTLEN}
  LB_GETTEXTLEN           = $018A;
  {$EXTERNALSYM LB_GETCOUNT}
  LB_GETCOUNT             = $018B;
  {$EXTERNALSYM LB_SELECTSTRING}
  LB_SELECTSTRING         = $018C;
  {$EXTERNALSYM LB_DIR}
  LB_DIR                  = $018D;
  {$EXTERNALSYM LB_GETTOPINDEX}
  LB_GETTOPINDEX          = $018E;
  {$EXTERNALSYM LB_FINDSTRING}
  LB_FINDSTRING           = $018F;
  {$EXTERNALSYM LB_GETSELCOUNT}
  LB_GETSELCOUNT          = $0190;
  {$EXTERNALSYM LB_GETSELITEMS}
  LB_GETSELITEMS          = $0191;
  {$EXTERNALSYM LB_SETTABSTOPS}
  LB_SETTABSTOPS          = $0192;
  {$EXTERNALSYM LB_GETHORIZONTALEXTENT}
  LB_GETHORIZONTALEXTENT  = $0193;
  {$EXTERNALSYM LB_SETHORIZONTALEXTENT}
  LB_SETHORIZONTALEXTENT  = $0194;
  {$EXTERNALSYM LB_SETCOLUMNWIDTH}
  LB_SETCOLUMNWIDTH       = $0195;
  {$EXTERNALSYM LB_ADDFILE}
  LB_ADDFILE              = $0196;
  {$EXTERNALSYM LB_SETTOPINDEX}
  LB_SETTOPINDEX          = $0197;
  {$EXTERNALSYM LB_GETITEMRECT}
  LB_GETITEMRECT          = $0198;
  {$EXTERNALSYM LB_GETITEMDATA}
  LB_GETITEMDATA          = $0199;
  {$EXTERNALSYM LB_SETITEMDATA}
  LB_SETITEMDATA          = $019A;
  {$EXTERNALSYM LB_SELITEMRANGE}
  LB_SELITEMRANGE         = $019B;
  {$EXTERNALSYM LB_SETANCHORINDEX}
  LB_SETANCHORINDEX       = $019C;
  {$EXTERNALSYM LB_GETANCHORINDEX}
  LB_GETANCHORINDEX       = $019D;
  {$EXTERNALSYM LB_SETCARETINDEX}
  LB_SETCARETINDEX        = $019E;
  {$EXTERNALSYM LB_GETCARETINDEX}
  LB_GETCARETINDEX        = $019F;
  {$EXTERNALSYM LB_SETITEMHEIGHT}
  LB_SETITEMHEIGHT        = $01A0;
  {$EXTERNALSYM LB_GETITEMHEIGHT}
  LB_GETITEMHEIGHT        = $01A1;
  {$EXTERNALSYM LB_FINDSTRINGEXACT}
  LB_FINDSTRINGEXACT      = $01A2;
  {$EXTERNALSYM LB_SETLOCALE}
  LB_SETLOCALE            = $01A5;
  {$EXTERNALSYM LB_GETLOCALE}
  LB_GETLOCALE            = $01A6;
  {$EXTERNALSYM LB_SETCOUNT}
  LB_SETCOUNT             = $01A7;
  {$EXTERNALSYM LB_INITSTORAGE}
  LB_INITSTORAGE          = $01A8;
  {$EXTERNALSYM LB_ITEMFROMPOINT}
  LB_ITEMFROMPOINT        = $01A9;
  {$EXTERNALSYM LB_MSGMAX}
  LB_MSGMAX               = $01B3; { if _WIN32_WINNT >= 0x0501 }
  //LB_MSGMAX             = $01B1; { else if _WIN32_WCE >= 0x0400 }
  //LB_MSGMAX             = $01B0; { else if WINVER >= 0x0400 }
  //LB_MSGMAX             = $01A8] { else }

{ Combo Box Notification Codes }

const
  {$EXTERNALSYM CBN_ERRSPACE}
  CBN_ERRSPACE   = (-1);
  {$EXTERNALSYM CBN_SELCHANGE}
  CBN_SELCHANGE  = 1;
  {$EXTERNALSYM CBN_DBLCLK}
  CBN_DBLCLK     = 2;
  {$EXTERNALSYM CBN_SETFOCUS}
  CBN_SETFOCUS   = 3;
  {$EXTERNALSYM CBN_KILLFOCUS}
  CBN_KILLFOCUS  = 4;
  {$EXTERNALSYM CBN_EDITCHANGE}
  CBN_EDITCHANGE = 5;
  {$EXTERNALSYM CBN_EDITUPDATE}
  CBN_EDITUPDATE = 6;
  {$EXTERNALSYM CBN_DROPDOWN}
  CBN_DROPDOWN   = 7;
  {$EXTERNALSYM CBN_CLOSEUP}
  CBN_CLOSEUP    = 8;
  {$EXTERNALSYM CBN_SELENDOK}
  CBN_SELENDOK   = 9;
  {$EXTERNALSYM CBN_SELENDCANCEL}
  CBN_SELENDCANCEL = 10;

{ Combo Box messages }

  {$EXTERNALSYM CB_GETEDITSEL}
  CB_GETEDITSEL            = $0140;
  {$EXTERNALSYM CB_LIMITTEXT}
  CB_LIMITTEXT             = $0141;
  {$EXTERNALSYM CB_SETEDITSEL}
  CB_SETEDITSEL            = $0142;
  {$EXTERNALSYM CB_ADDSTRING}
  CB_ADDSTRING             = $0143;
  {$EXTERNALSYM CB_DELETESTRING}
  CB_DELETESTRING          = $0144;
  {$EXTERNALSYM CB_DIR}
  CB_DIR                   = $0145;
  {$EXTERNALSYM CB_GETCOUNT}
  CB_GETCOUNT              = $0146;
  {$EXTERNALSYM CB_GETCURSEL}
  CB_GETCURSEL             = $0147;
  {$EXTERNALSYM CB_GETLBTEXT}
  CB_GETLBTEXT             = $0148;
  {$EXTERNALSYM CB_GETLBTEXTLEN}
  CB_GETLBTEXTLEN          = $0149;
  {$EXTERNALSYM CB_INSERTSTRING}
  CB_INSERTSTRING          = $014A;
  {$EXTERNALSYM CB_RESETCONTENT}
  CB_RESETCONTENT          = $014B;
  {$EXTERNALSYM CB_FINDSTRING}
  CB_FINDSTRING            = $014C;
  {$EXTERNALSYM CB_SELECTSTRING}
  CB_SELECTSTRING          = $014D;
  {$EXTERNALSYM CB_SETCURSEL}
  CB_SETCURSEL             = $014E;
  {$EXTERNALSYM CB_SHOWDROPDOWN}
  CB_SHOWDROPDOWN          = $014F;
  {$EXTERNALSYM CB_GETITEMDATA}
  CB_GETITEMDATA           = $0150;
  {$EXTERNALSYM CB_SETITEMDATA}
  CB_SETITEMDATA           = $0151;
  {$EXTERNALSYM CB_GETDROPPEDCONTROLRECT}
  CB_GETDROPPEDCONTROLRECT = $0152;
  {$EXTERNALSYM CB_SETITEMHEIGHT}
  CB_SETITEMHEIGHT         = $0153;
  {$EXTERNALSYM CB_GETITEMHEIGHT}
  CB_GETITEMHEIGHT         = $0154;
  {$EXTERNALSYM CB_SETEXTENDEDUI}
  CB_SETEXTENDEDUI         = $0155;
  {$EXTERNALSYM CB_GETEXTENDEDUI}
  CB_GETEXTENDEDUI         = $0156;
  {$EXTERNALSYM CB_GETDROPPEDSTATE}
  CB_GETDROPPEDSTATE       = $0157;
  {$EXTERNALSYM CB_FINDSTRINGEXACT}
  CB_FINDSTRINGEXACT       = $0158;
  {$EXTERNALSYM CB_SETLOCALE}
  CB_SETLOCALE             = 345;
  {$EXTERNALSYM CB_GETLOCALE}
  CB_GETLOCALE             = 346;
  {$EXTERNALSYM CB_GETTOPINDEX}
  CB_GETTOPINDEX           = 347;
  {$EXTERNALSYM CB_SETTOPINDEX}
  CB_SETTOPINDEX           = 348;
  {$EXTERNALSYM CB_GETHORIZONTALEXTENT}
  CB_GETHORIZONTALEXTENT   = 349;
  {$EXTERNALSYM CB_SETHORIZONTALEXTENT}
  CB_SETHORIZONTALEXTENT   = 350;
  {$EXTERNALSYM CB_GETDROPPEDWIDTH}
  CB_GETDROPPEDWIDTH       = 351;
  {$EXTERNALSYM CB_SETDROPPEDWIDTH}
  CB_SETDROPPEDWIDTH       = 352;
  {$EXTERNALSYM CB_INITSTORAGE}
  CB_INITSTORAGE           = 353;
  {$EXTERNALSYM CB_MSGMAX}
  CB_MSGMAX                = $165; { if _WIN32_WINNT >= 0x0501 }
  //CB_MSGMAX                = $163; { else if _WIN32_WCE >= 0x0400 }
  //CB_MSGMAX                = $162; { else if _WIN32_VER >= 0x0400 }
  //CB_MSGMAX                = $15B; { else }

{ Edit Control Notification Codes }

const
  {$EXTERNALSYM EN_SETFOCUS}
  EN_SETFOCUS  = $0100;
  {$EXTERNALSYM EN_KILLFOCUS}
  EN_KILLFOCUS = $0200;
  {$EXTERNALSYM EN_CHANGE}
  EN_CHANGE    = $0300;
  {$EXTERNALSYM EN_UPDATE}
  EN_UPDATE    = $0400;
  {$EXTERNALSYM EN_ERRSPACE}
  EN_ERRSPACE  = $0500;
  {$EXTERNALSYM EN_MAXTEXT}
  EN_MAXTEXT   = $0501;
  {$EXTERNALSYM EN_HSCROLL}
  EN_HSCROLL   = $0601;
  {$EXTERNALSYM EN_VSCROLL}
  EN_VSCROLL   = $0602;

{ Edit Control Messages }

const
  {$EXTERNALSYM EM_GETSEL}
  EM_GETSEL              = $00B0;
  {$EXTERNALSYM EM_SETSEL}
  EM_SETSEL              = $00B1;
  {$EXTERNALSYM EM_GETRECT}
  EM_GETRECT             = $00B2;
  {$EXTERNALSYM EM_SETRECT}
  EM_SETRECT             = $00B3;
  {$EXTERNALSYM EM_SETRECTNP}
  EM_SETRECTNP           = $00B4;
  {$EXTERNALSYM EM_SCROLL}
  EM_SCROLL              = $00B5;
  {$EXTERNALSYM EM_LINESCROLL}
  EM_LINESCROLL          = $00B6;
  {$EXTERNALSYM EM_SCROLLCARET}
  EM_SCROLLCARET         = $00B7;
  {$EXTERNALSYM EM_GETMODIFY}
  EM_GETMODIFY           = $00B8;
  {$EXTERNALSYM EM_SETMODIFY}
  EM_SETMODIFY           = $00B9;
  {$EXTERNALSYM EM_GETLINECOUNT}
  EM_GETLINECOUNT        = $00BA;
  {$EXTERNALSYM EM_LINEINDEX}
  EM_LINEINDEX           = $00BB;
  {$EXTERNALSYM EM_SETHANDLE}
  EM_SETHANDLE           = $00BC;
  {$EXTERNALSYM EM_GETHANDLE}
  EM_GETHANDLE           = $00BD;
  {$EXTERNALSYM EM_GETTHUMB}
  EM_GETTHUMB            = $00BE;
  {$EXTERNALSYM EM_LINELENGTH}
  EM_LINELENGTH          = $00C1;
  {$EXTERNALSYM EM_REPLACESEL}
  EM_REPLACESEL          = $00C2;
  {$EXTERNALSYM EM_GETLINE}
  EM_GETLINE             = $00C4;
  {$EXTERNALSYM EM_LIMITTEXT}
  EM_LIMITTEXT           = $00C5;
  {$EXTERNALSYM EM_CANUNDO}
  EM_CANUNDO             = $00C6;
  {$EXTERNALSYM EM_UNDO}
  EM_UNDO                = $00C7;
  {$EXTERNALSYM EM_FMTLINES}
  EM_FMTLINES            = $00C8;
  {$EXTERNALSYM EM_LINEFROMCHAR}
  EM_LINEFROMCHAR        = $00C9;
  {$EXTERNALSYM EM_SETTABSTOPS}
  EM_SETTABSTOPS         = $00CB;
  {$EXTERNALSYM EM_SETPASSWORDCHAR}
  EM_SETPASSWORDCHAR     = $00CC;
  {$EXTERNALSYM EM_EMPTYUNDOBUFFER}
  EM_EMPTYUNDOBUFFER     = $00CD;
  {$EXTERNALSYM EM_GETFIRSTVISIBLELINE}
  EM_GETFIRSTVISIBLELINE = $00CE;
  {$EXTERNALSYM EM_SETREADONLY}
  EM_SETREADONLY         = $00CF;
  {$EXTERNALSYM EM_SETWORDBREAKPROC}
  EM_SETWORDBREAKPROC    = $00D0;
  {$EXTERNALSYM EM_GETWORDBREAKPROC}
  EM_GETWORDBREAKPROC    = $00D1;
  {$EXTERNALSYM EM_GETPASSWORDCHAR}
  EM_GETPASSWORDCHAR     = $00D2;
  {$EXTERNALSYM EM_SETMARGINS}
  EM_SETMARGINS          = 211;
  {$EXTERNALSYM EM_GETMARGINS}
  EM_GETMARGINS          = 212;
  {$EXTERNALSYM EM_SETLIMITTEXT}
  EM_SETLIMITTEXT        = EM_LIMITTEXT;    //win40 Name change
  {$EXTERNALSYM EM_GETLIMITTEXT}
  EM_GETLIMITTEXT        = 213;
  {$EXTERNALSYM EM_POSFROMCHAR}
  EM_POSFROMCHAR         = 214;
  {$EXTERNALSYM EM_CHARFROMPOS}
  EM_CHARFROMPOS         = 215;
  {$EXTERNALSYM EM_SETIMESTATUS}
  EM_SETIMESTATUS        = 216;
  {$EXTERNALSYM EM_GETIMESTATUS}
  EM_GETIMESTATUS        = 217;

const
  { Scroll bar messages }
  {$EXTERNALSYM SBM_SETPOS}
  SBM_SETPOS = 224;             { not in win3.1  }
  {$EXTERNALSYM SBM_GETPOS}
  SBM_GETPOS = 225;             { not in win3.1  }
  {$EXTERNALSYM SBM_SETRANGE}
  SBM_SETRANGE = 226;           { not in win3.1  }
  {$EXTERNALSYM SBM_SETRANGEREDRAW}
  SBM_SETRANGEREDRAW = 230;     { not in win3.1  }
  {$EXTERNALSYM SBM_GETRANGE}
  SBM_GETRANGE = 227;           { not in win3.1  }
  {$EXTERNALSYM SBM_ENABLE_ARROWS}
  SBM_ENABLE_ARROWS = 228;      { not in win3.1  }
  {$EXTERNALSYM SBM_SETSCROLLINFO}
  SBM_SETSCROLLINFO = 233;
  {$EXTERNALSYM SBM_GETSCROLLINFO}
  SBM_GETSCROLLINFO = 234;
  {$EXTERNALSYM SBM_GETSCROLLBARINFO}
  SBM_GETSCROLLBARINFO = 235;   { Win XP or later }

{ Dialog messages }

  {$EXTERNALSYM DM_GETDEFID}
  DM_GETDEFID = (WM_USER+0);
  {$EXTERNALSYM DM_SETDEFID}
  DM_SETDEFID = (WM_USER+1);
  {$EXTERNALSYM DM_REPOSITION}
  DM_REPOSITION = (WM_USER+2);

  {$EXTERNALSYM PSM_PAGEINFO}
  PSM_PAGEINFO = (WM_USER+100);
  {$EXTERNALSYM PSM_SHEETINFO}
  PSM_SHEETINFO = (WM_USER+101);

type

  { Generic 64 bits Filler record }

(*  T4Byte64Filler = record
  {$IFDEF CPUX64}
    Filler: array[0..3] of Byte;
  {$ENDIF}
  end;*)

  TWordFiller = record
  {$IFDEF CPUX86}
    Filler: array[1..2] of Byte; // Pad word make it 4 Bytes (2+2)
  {$ENDIF}
  {$IFDEF CPUX64}
    Filler: array[1..6] of Byte; // Pad word to make it 8 Bytes (2+6)
  {$ENDIF}
  end;

  TDWordFiller = record
  {$IFDEF CPUX64}
    Filler: array[1..4] of Byte; // Pad DWORD to make it 8 bytes (4+4) [x64 only]
  {$ENDIF}
  end;

{ Generic window message record }

  PMessage = ^TMessage;
  TMessage = record
    Msg: Cardinal;
    case Integer of
      0: (
        WParam: WPARAM;
        LParam: LPARAM;
        Result: LRESULT);
      1: (
        WParamLo: Word;
        WParamHi: Word;
        WParamFiller: TDWordFiller;
        LParamLo: Word;
        LParamHi: Word;
        LParamFiller: TDWordFiller;
        ResultLo: Word;
        ResultHi: Word;
        ResultFiller: TDWordFiller);
  end;

{ Common message format records }

  TWMNoParams = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: array[0..3] of Word;
    UnusedFiller: TDWordFiller;
    UnusedFiller2: TDWordFiller;
    Result: LRESULT;
  end;

  TWMKey = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CharCode: Word;
    Unused: Word;
	  CharCodeUnusedFiller: TDWordFiller;
    KeyData: Longint;
    KeyDataFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMMouse = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Keys: Longint;
    KeysFiller: TDWordFiller;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller;);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMMouseWheel = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Keys: SmallInt;
    WheelDelta: SmallInt;
    KeysWhellFiller: TDWordFiller;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TMSHMouseWheel = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    WheelDelta: Integer;
    WheelDeltaFiller: TDWordFiller;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMWindowPosMsg = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: Integer;
    UnusedFiller: TDWordFiller;
    WindowPos: PWindowPos;
    Result: LRESULT;
  end;

  TWMScroll = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    ScrollCode: Smallint; { SB_xxxx }
    Pos: Smallint;
    ScrollCodePosFiller: TDWordFiller;
    ScrollBar: HWND;
    Result: LRESULT;
  end;

  TWMDpi = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    YDpi: Word;
    XDpi: Word;
    WParamFiller: TDWordFiller;
    ScaledRect: PRECT;
    Result: LRESULT;
  end;

{ Message records }

  TWMActivate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Active: Word; { WA_INACTIVE, WA_ACTIVE, WA_CLICKACTIVE }
    Minimized: WordBool;
    ActiveMinimizedFiller: TDWordFiller;
    ActiveWindow: HWND;
    Result: LRESULT;
  end;

  TWMActivateApp = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Active: BOOL;
    ActiveFiller: TDWordFiller;
    ThreadId: Longint;
    TheadIdFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMAskCBFormatName = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    NameLen: Word;
    NameLenFiller: TWordFiller;
    FormatName: PChar;
    Result: LRESULT;
  end;

  TWMCancelMode = TWMNoParams;

  TWMChangeCBChain = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Remove: HWND;
    Next: HWND;
    Result: LRESULT;
  end;

  TWMChar = TWMKey;

  TWMCharToItem = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Key: Word;
    CaretPos: Word;
    keyCaretPosFiller: TDWordFiller;
    ListBox: HWND;
    Result: LRESULT;
  end;

  TWMChildActivate = TWMNoParams;

  TWMChooseFont_GetLogFont = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: Longint;
    UnusedFiller: TDWordFiller;
    LogFont: PLogFont;
    Result: LRESULT;
  end;

  TWMClear = TWMNoParams;
  TWMClose = TWMNoParams;

  TWMCommand = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    ItemID: Word;
    NotifyCode: Word;
    ItemIDNotifyCodeFiller: TDWordFiller;
    Ctl: HWND;
    Result: LRESULT;
  end;

  TWMCompacting = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CompactRatio: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMCompareItem = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Ctl: HWnd;
    CompareItemStruct: PCompareItemStruct;
    Result: LRESULT;
  end;

  TWMCopy = TWMNoParams;

  TWMCopyData = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    From: HWND;
    CopyDataStruct: PCopyDataStruct;
    Result: LRESULT;
  end;

  { ?? WM_CLP_LAUNCH, WM_CPL_LAUNCHED }

  TWMCreate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    CreateStruct: PCreateStruct;
    Result: LRESULT;
  end;

  TWMCtlColor = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    ChildDC: HDC;
    ChildWnd: HWND;
    Result: LRESULT;
  end;

  TWMCtlColorBtn = TWMCtlColor;
  TWMCtlColorDlg = TWMCtlColor;
  TWMCtlColorEdit = TWMCtlColor;
  TWMCtlColorListbox = TWMCtlColor;
  TWMCtlColorMsgbox = TWMCtlColor;
  TWMCtlColorScrollbar = TWMCtlColor;
  TWMCtlColorStatic = TWMCtlColor;

  TWMCut = TWMNoParams;

  TWMDDE_Ack = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    case Word of
      WM_DDE_INITIATE: (
        App: Word;
        Topic: Word;
        AppTopicFiller: TDWordFiller;
        Result: LRESULT);
      WM_DDE_EXECUTE {and all others}: (
        PackedVal: Longint;
        PackedValFiller: TDWordFiller;);
  end;

  TWMDDE_Advise = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    PackedVal: Longint;
    PackedValFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDDE_Data = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    PackedVal: Longint;
    PackedValFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDDE_Execute = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    Commands: THandle;
    Result: LRESULT;
  end;

  TWMDDE_Initiate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    App: Word;
    Topic: Word;
    AppTopicFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDDE_Poke = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    PackedVal: Longint;
    PackedValFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDDE_Request = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    Format: Word;
    Item: Word;
    FormatItemFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDDE_Terminate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMDDE_Unadvise = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PostingApp: HWND;
    Format: Word;
    Item: Word;
    FormatItemFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMDeadChar = TWMChar;

  TWMDeleteItem = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Ctl: HWND;
    DeleteItemStruct: PDeleteItemStruct;
    Result: LRESULT;
  end;

  TWMDestroy = TWMNoParams;
  TWMDestroyClipboard = TWMNoParams;

  TWMDevModeChange = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    Device: PChar;
    Result: LRESULT;
  end;

  TWMDrawClipboard = TWMNoParams;

  TWMDrawItem = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Ctl: HWND;
    DrawItemStruct: PDrawItemStruct;
    Result: LRESULT;
  end;

  TWMDropFiles = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Drop: THANDLE;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMEnable = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Enabled: LongBool;
    EnabledFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMEndSession = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    EndSession: LongBool;
    EndSessionFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMEnterIdle = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Source: WPARAM; { MSGF_DIALOGBOX, MSGF_MENU }
    IdleWnd: HWND;
    Result: LRESULT;
  end;

  TWMEnterMenuLoop = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IsTrackPopupMenu: LongBool;
    IsTrackPopupMenuFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMExitMenuLoop = TWMEnterMenuLoop;

  TWMEraseBkgnd = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    DC: HDC;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMFontChange = TWMNoParams;
  TWMGetDlgCode = TWMNoParams;
  TWMGetFont = TWMNoParams;

  TWMGetIcon = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    BigIcon: Longbool;
    BigIconFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMGetHotKey = TWMNoParams;

  TWMGetMinMaxInfo = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    MinMaxInfo: PMinMaxInfo;
    Result: LRESULT;
  end;

  TWMGetText = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    TextMax: WPARAM;
    Text: PChar;
    Result: LRESULT;
  end;

  TWMGetTextLength = TWMNoParams;

  TWMHotKey = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    HotKey: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMHScroll = TWMScroll;

  TWMHScrollClipboard = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Viewer: HWND;
    ScrollCode: Word; {SB_BOTTOM, SB_ENDSCROLL, SB_LINEDOWN, SB_LINEUP,
                       SB_PAGEDOWN, SB_PAGEUP, SB_THUMBPOSITION,
                       SB_THUMBTRACK, SB_TOP }
    Pos: Word;
    ScrollCodePosFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMIconEraseBkgnd = TWMEraseBkgnd;

  TWMInitDialog = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Focus: HWND;
    InitParam: LPARAM;
    Result: LRESULT;
  end;

  TWMInitMenu = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Menu: HMENU;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMInitMenuPopup = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    MenuPopup: HMENU;
    Pos: Smallint;
    SystemMenu: WordBool;
    PosSystemMenuFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMKeyDown = TWMKey;
  TWMKeyUp = TWMKey;

  TWMKillFocus = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    FocusedWnd: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMLButtonDblClk = TWMMouse;
  TWMLButtonDown   = TWMMouse;
  TWMLButtonUp     = TWMMouse;
  TWMMButtonDblClk = TWMMouse;
  TWMMButtonDown   = TWMMouse;
  TWMMButtonUp     = TWMMouse;

  TWMMDIActivate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    case Integer of
      0: (
        ChildWnd: HWND);
      1: (
        DeactiveWnd: HWND;
        ActiveWnd: HWND;
        Result: LRESULT);
  end;

  TWMMDICascade = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Cascade: WPARAM; { 0, MDITILE_SKIPDISABLED }
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMMDICreate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    MDICreateStruct: PMDICreateStruct;
    Result: LRESULT;
  end;

  TWMMDIDestroy = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Child: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMMDIGetActive = TWMNoParams;
  TWMMDIIconArrange = TWMNoParams;

  TWMMDIMaximize = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Maximize: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMMDINext = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Child: HWND;
    Next: LPARAM;
    Result: LRESULT;
  end;

  TWMMDIRefreshMenu = TWMNoParams;

  TWMMDIRestore = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDChild: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMMDISetMenu = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    MenuFrame: HMENU;
    MenuWindow: HMENU;
    Result: LRESULT;
  end;

  TWMMDITile = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Tile: WPARAM;  { MDITILE_HORIZONTAL, MDITILE_SKIPDISABLE,
                     MDITILE_VERTICAL }
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMMeasureItem = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtl: HWnd;
    MeasureItemStruct: PMeasureItemStruct;
    Result: LRESULT;
  end;

  TWMMenuChar = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    User:Char;
{$IF NOT DEFINED(UNICODE)}
    Unused: Byte;
{$ENDIF}
    MenuFlag: Word; { MF_POPUP, MF_SYSMENU }
    UserMenuFlagFiller: TDWordFiller;
    Menu: HMENU;
    Result: LRESULT;
  end;

  TWMMenuSelect = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDItem: Word;
    MenuFlag: Word; { MF_BITMAP, MF_CHECKED, MF_DISABLED, MF_GRAYED,
                      MF_MOUSESELECT, MF_OWNERDRAW, MF_POPUP, MF_SEPARATOR,
                      MF_SYSMENU }
    IDItemMenuFlagFiller: TDWordFiller;
    Menu: HMENU;
    Result: LRESULT;
  end;

  TWMMouseActivate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    TopLevel: HWND;
    HitTestCode: Word;
    MouseMsg: Word;
    HitTestCodeMouseMsg: TDWordFiller;
    Result: LRESULT;
  end;

  TWMMouseMove = TWMMouse;

  TWMMove = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMMoving = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Edge: WPARAM;
    DragRect: PRect;
  end;

  TWMNCActivate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Active: BOOL;
    ActiveFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMNCCalcSize = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CalcValidRects: BOOL;
    CalcValidRectsFiller: TDWordFiller;
    CalcSize_Params: PNCCalcSizeParams;
    Result: LRESULT;
  end;

  TWMNCCreate = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    CreateStruct: PCreateStruct;
    Result: LRESULT;
  end;

  TWMNCDestroy = TWMNoParams;

  TWMNCHitTest = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMNCHitMessage = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    HitTest: Longint;
    HitTestFiller: TDWordFiller;
    XCursor: Smallint;
    YCursor: Smallint;
    XYCursorFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMNCLButtonDblClk = TWMNCHitMessage;
  TWMNCLButtonDown   = TWMNCHitMessage;
  TWMNCLButtonUp     = TWMNCHitMessage;
  TWMNCMButtonDblClk = TWMNCHitMessage;
  TWMNCMButtonDown   = TWMNCHitMessage;
  TWMNCMButtonUp     = TWMNCHitMessage;
  TWMNCMouseMove     = TWMNCHitMessage;

  TWMNCPaint = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    RGN: HRGN;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMNCRButtonDblClk = TWMNCHitMessage;
  TWMNCRButtonDown   = TWMNCHitMessage;
  TWMNCRButtonUp     = TWMNCHitMessage;

  TWMNextDlgCtl = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CtlFocus: WPARAM;
    Handle: WordBool;
    HandleFiller: TWordFiller;
    Result: LRESULT;
  end;

  TWMNotify = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    IDCtrl: WPARAM;
    NMHdr: PNMHdr;
    Result: LRESULT;
  end;

  TWMNotifyFormat = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    From: HWND;
    Command: LPARAM;
    Result: LRESULT;
  end;

  TWMPaint = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    DC: HDC;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMPaintClipboard = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Viewer: HWND;
    PaintStruct: THandle;
    Result: LRESULT;
  end;

  TWMPaintIcon = TWMNoParams;

  TWMPaletteChanged = record
    Msg: Cardinal;
    MsgFiller:TDWordFiller;
    PalChg: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMPaletteIsChanging = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Realize: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMParentNotify = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    case Word of
      WM_CREATE, WM_DESTROY: (
        Unused1: Word;
        ChildID: Word;
        EventChildIDFiller: TDWordFiller;
        ChildWnd: HWnd);
      WM_LBUTTONDOWN, WM_MBUTTONDOWN, WM_RBUTTONDOWN: (
        Unused2: Word;
        Value: Word;
        EventValueFiller: TDWordFiller;
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      0: (
        Event: Word;
        Value1: Word;
        EventValue1Filler: TDWordFiller;
        Value2: LPARAM;
        Result: LRESULT);
  end;

  TWMPaste = TWMNoParams;

  TWMPower = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    PowerEvt: WPARAM;  { PWR_SUSPENDREQUEST, PWR_SUSPENDRESUME,
                         PWR_CRITICALRESUME }
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMQueryDragIcon = TWMNoParams;

  TWMQueryEndSession = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Source: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMQueryNewPalette = TWMNoParams;
  TWMQueryOpen = TWMNoParams;
  TWMQueueSync = TWMNoParams;

  TWMQuit = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    ExitCode: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMRButtonDblClk = TWMMouse;
  TWMRButtonDown = TWMMouse;
  TWMRButtonUp = TWMMouse;

  TWMRenderAllFormats = TWMNoParams;

  TWMRenderFormat = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Format: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMSetCursor = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CursorWnd: HWND;
    HitTest: SmallInt;
    MouseMsg: Word;
    HitTestMouseMsgFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMSetFocus = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    FocusedWnd: HWND;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMSetFont = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Font: HFONT;
    Redraw: WordBool;
    RedrawFiller: TWordFiller;
    Result: LRESULT;
  end;

  TWMSetHotKey = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Key: Longint;
    KeyFiller: TDWordFiller;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMSetIcon = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    BigIcon: Longbool;
    BigIconFiller: TDWordFiller;
    Icon: HICON;
    Result: LRESULT;
  end;

  TWMSetRedraw = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Redraw: WPARAM;
    Unused: LPARAM;
    Result: LRESULT;
  end;

  TWMSetText = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    Text: PChar;
    Result: LRESULT;
  end;

  TWMShowWindow = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Show: BOOL;
    ShowFiller: TDWordFiller;
    Status: LPARAM;
    Result: LRESULT;
  end;

  TWMSize = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    SizeType: WPARAM;  { SIZE_MAXIMIZED, SIZE_MINIMIZED, SIZE_RESTORED,
                         SIZE_MAXHIDE, SIZE_MAXSHOW }
    Width: Word;
    Height: Word;
    WidthHeightFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMSizeClipboard = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Viewer: HWND;
    RC: THandle;
    Result: LRESULT;
  end;

  TWMSpoolerStatus = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    JobStatus: WPARAM;
    JobsLeft: Word;
    JobsLeftFiller: TWordFiller;
    Result: LRESULT;
  end;

  TWMStyleChange = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    StyleType: WPARAM;
    StyleStruct: PStyleStruct;
    Result: LRESULT;
  end;

  TWMStyleChanged = TWMStyleChange;
  TWMStyleChanging = TWMStyleChange;

  TWMSysChar = TWMKey;
  TWMSysColorChange = TWMNoParams;

  TWMSysCommand = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CmdType: WPARAM;
    case WPARAM of
      SC_HOTKEY: (
        ActivateWnd: HWND);
      SC_KEYMENU: (
        Key: Word);
      SC_CLOSE, SC_HSCROLL, SC_MAXIMIZE, SC_MINIMIZE, SC_MOUSEMENU, SC_MOVE,
      SC_NEXTWINDOW, SC_PREVWINDOW, SC_RESTORE, SC_SCREENSAVE, SC_SIZE,
      SC_TASKLIST, SC_VSCROLL: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMSysDeadChar = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    CharCode: Word;
    CharCodeFiller: TWordFiller;
    KeyData: Longint;
    KeyDataFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMSysKeyDown = TWMKey;
  TWMSysKeyUp = TWMKey;

  TWMSystemError = record
    Msg: Cardinal;
    ErrSpec: Word;
    Unused: Longint;
    Result: Longint;
  end;

  TWMTimeChange = TWMNoParams;

  TWMTimer = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    TimerID: WPARAM;
    TimerProc: TFarProc;
    Result: LRESULT;
  end;

  TWMUIState = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Action: Word;
    Flags: Word;
    ActionFlagsFiller: TDWordFiller;
    Unused: LPARAM;
  end;

  TWMChangeUIState = TWMUIState;
  TWMUpdateUIState = TWMUIState;
  TWMQueryUIState = TWMNoParams;

  TWMUndo = TWMNoParams;

  TWMVKeyToItem = TWMCharToItem;

  TWMVScroll = TWMScroll;

  TWMVScrollClipboard = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Viewer: HWND;
    ScollCode: Word;
    ThumbPos: Word;
    ScrollCodeThumbPosFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMWindowPosChanged = TWMWindowPosMsg;
  TWMWindowPosChanging = TWMWindowPosMsg;

  TWMWinIniChange = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    Section: PChar;
    Result: LRESULT;
  end;

  TWMSettingChange = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Flag: WPARAM;
    Section: PChar;
    Result: LRESULT;
  end;

  TWMHelp = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    HelpInfo: PHelpInfo;
    Result: LRESULT;
  end;

  TWMDisplayChange = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    BitsPerPixel: WPARAM;
    Width: Word;
    Height: Word;
    WidthHeightFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMContextMenu = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    hWnd: HWND;
    case Integer of
      0: (
        XPos: Smallint;
        YPos: Smallint;
        XYPosFiller: TDWordFiller);
      1: (
        Pos: TSmallPoint;
        PosFiller: TDWordFiller;
        Result: LRESULT);
  end;

  TWMPrint = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    DC: HDC;
    Flags: Cardinal;
    FlagsFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TWMPrintClient = TWMPrint;

  TWMGestureNotify = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    NotifyStruct: PGestureNotifyStruct;
    Result: LRESULT;
  end;

// Utility functions to simplify .NET/Win32 single code source

{$IFNDEF UNICODE}
function SendTextMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; LParam: AnsiString): LRESULT; overload;
{$ENDIF}
function SendTextMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; LParam: UnicodeString): LRESULT; overload;
function SendStructMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; const LParam): LRESULT;
function SendGetStructMessage(Handle: HWND; Msg: UINT; WParam: WPARAM;
  var LParam; Unused: Boolean = False): LRESULT;
function SendGetIntMessage(Handle: HWND; Msg: UINT; var WParam: Integer;
  var LParam: Integer): LRESULT;

implementation

{$IFNDEF UNICODE}
function SendTextMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; LParam: AnsiString): LRESULT;
begin
  Result := SendMessage(Handle, Msg, WParam, Winapi.Windows.LPARAM(PAnsiChar(LParam)));
end;
{$ENDIF}

function SendTextMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; LParam: UnicodeString): LRESULT;
begin
  Result := SendMessage(Handle, Msg, WParam, Winapi.Windows.LPARAM(PWideChar(LParam)));
end;

function SendStructMessage(Handle: HWND; Msg: UINT; WParam: WPARAM; const LParam): LRESULT;
begin
  Result := SendMessage(Handle, Msg, WParam, Winapi.Windows.LPARAM(@LParam));
end;

function SendGetStructMessage(Handle: HWND; Msg: UINT; WParam: WPARAM;
  var LParam; Unused: Boolean = False): LRESULT;
begin
  Result := SendMessage(Handle, Msg, WParam, Winapi.Windows.LPARAM(@LParam));
end;

function SendGetIntMessage(Handle: HWND; Msg: UINT; var WParam: Integer;
  var LParam: Integer): LRESULT;
begin
  Result := SendMessage(Handle, Msg, Winapi.Windows.WPARAM(@WParam), Winapi.Windows.LPARAM(@LParam));
end;

end.
