{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engineering, and distribution of all or any portion of  *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxCore;

interface
uses Windows, SysUtils, Messages;

type


  TadxRegionState = (rsNormal, rsHidden, rsMinimized);

  TadxAllowedDropPosition = (dpTop, dpBottom, dpRight, dpLeft);

  TadxAllowedDropPositions = set of TadxAllowedDropPosition;

  TadxRegionBorderStyle = (rbsNone, rbsSingle);

  procedure MakeProcAddress(MakeAddress: pointer; Instance: TObject; ProcAddress: Pointer);
  function  WndMesssageToString(Msg: cardinal): string;

implementation
uses TLHelp32;

const
  THREAD_SUSPEND_RESUME = $0002;

function OpenThread(dwDesiredAccess: dword; bInheritHandle: bool; dwThreadId: dword):dword; stdcall; external 'kernel32.dll';

procedure RunThreads;
var
  h, CurrTh, ThrHandle, CurrPr: dword;
  Thread: TThreadEntry32;
begin
  CurrTh := GetCurrentThreadId;
  CurrPr := GetCurrentProcessId;
  h := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if h <> INVALID_HANDLE_VALUE then begin
    Thread.dwSize := SizeOf(TThreadEntry32);
    if Thread32First(h, Thread) then
    repeat
      if (Thread.th32ThreadID <> CurrTh) and (Thread.th32OwnerProcessID = CurrPr) then begin
        ThrHandle := OpenThread(THREAD_SUSPEND_RESUME, false, Thread.th32ThreadID);
        if ThrHandle > 0 then begin
          ResumeThread(ThrHandle);
          CloseHandle(ThrHandle);
        end;
      end;
    until not Thread32Next(h, Thread);
    CloseHandle(h);
  end;
end;

procedure StopThreads;
var
  h, CurrTh, ThrHandle, CurrPr: dword;
  Thread: TThreadEntry32;
begin
  CurrTh := GetCurrentThreadId;
  CurrPr := GetCurrentProcessId;
  h := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if h <> INVALID_HANDLE_VALUE then begin
    Thread.dwSize := SizeOf(TThreadEntry32);
    if Thread32First(h, Thread) then
    repeat
      if (Thread.th32ThreadID <> CurrTh) and (Thread.th32OwnerProcessID = CurrPr) then begin
        ThrHandle := OpenThread(THREAD_SUSPEND_RESUME, false, Thread.th32ThreadID);
        if ThrHandle > 0 then begin
           SuspendThread(ThrHandle);
           CloseHandle(ThrHandle);
        end;
      end;
    until not Thread32Next(h, Thread);
    CloseHandle(h);
  end;
end;

procedure MakeProcAddress(MakeAddress: pointer; Instance: TObject; ProcAddress: Pointer);
begin
  asm
    mov  EAX, Instance
    mov  ECX, MakeAddress
    mov  word  ptr [ECX+0], $6858
    mov  dword ptr [ECX+2], EAX
    mov  word  ptr [ECX+6], $E950
    mov  EAX, ProcAddress
    sub  EAX, ECX
    sub  EAX, 12
    mov  dword ptr [ECX+8], EAX
  end;
end;

function WndMesssageToString(Msg: cardinal): string;
begin
  case Msg of
        WM_NULL                    : Result := 'WM_NULL                  ';
        WM_CREATE                  : Result := 'WM_CREATE                ';
        WM_DESTROY                 : Result := 'WM_DESTROY               ';
        WM_MOVE                    : Result := 'WM_MOVE                  ';
        WM_SIZE                    : Result := 'WM_SIZE                  ';
        WM_ACTIVATE                : Result := 'WM_ACTIVATE              ';
        WM_SETFOCUS                : Result := 'WM_SETFOCUS              ';
        WM_KILLFOCUS               : Result := 'WM_KILLFOCUS             ';
        WM_ENABLE                  : Result := 'WM_ENABLE                ';
        WM_SETREDRAW               : Result := 'WM_SETREDRAW             ';
        WM_SETTEXT                 : Result := 'WM_SETTEXT               ';
        WM_GETTEXT                 : Result := 'WM_GETTEXT               ';
        WM_GETTEXTLENGTH           : Result := 'WM_GETTEXTLENGTH         ';
        WM_PAINT                   : Result := 'WM_PAINT                 ';
        WM_CLOSE                   : Result := 'WM_CLOSE                 ';
        WM_QUERYENDSESSION         : Result := 'WM_QUERYENDSESSION       ';
        WM_QUIT                    : Result := 'WM_QUIT                  ';
        WM_QUERYOPEN               : Result := 'WM_QUERYOPEN             ';
        WM_ERASEBKGND              : Result := 'WM_ERASEBKGND            ';
        WM_SYSCOLORCHANGE          : Result := 'WM_SYSCOLORCHANGE        ';
        WM_ENDSESSION              : Result := 'WM_ENDSESSION            ';
        WM_SYSTEMERROR             : Result := 'WM_SYSTEMERROR           ';
        WM_SHOWWINDOW              : Result := 'WM_SHOWWINDOW            ';
        WM_CTLCOLOR                : Result := 'WM_CTLCOLOR              ';
        WM_SETTINGCHANGE           : Result := 'WM_SETTINGCHANGE         ';
        WM_DEVMODECHANGE           : Result := 'WM_DEVMODECHANGE         ';
        WM_ACTIVATEAPP             : Result := 'WM_ACTIVATEAPP           ';
        WM_FONTCHANGE              : Result := 'WM_FONTCHANGE            ';
        WM_TIMECHANGE              : Result := 'WM_TIMECHANGE            ';
        WM_CANCELMODE              : Result := 'WM_CANCELMODE            ';
        WM_SETCURSOR               : Result := 'WM_SETCURSOR             ';
        WM_MOUSEACTIVATE           : Result := 'WM_MOUSEACTIVATE         ';
        WM_CHILDACTIVATE           : Result := 'WM_CHILDACTIVATE         ';
        WM_QUEUESYNC               : Result := 'WM_QUEUESYNC             ';
        WM_GETMINMAXINFO           : Result := 'WM_GETMINMAXINFO         ';
        WM_PAINTICON               : Result := 'WM_PAINTICON             ';
        WM_ICONERASEBKGND          : Result := 'WM_ICONERASEBKGND        ';
        WM_NEXTDLGCTL              : Result := 'WM_NEXTDLGCTL            ';
        WM_SPOOLERSTATUS           : Result := 'WM_SPOOLERSTATUS         ';
        WM_DRAWITEM                : Result := 'WM_DRAWITEM              ';
        WM_MEASUREITEM             : Result := 'WM_MEASUREITEM           ';
        WM_DELETEITEM              : Result := 'WM_DELETEITEM            ';
        WM_VKEYTOITEM              : Result := 'WM_VKEYTOITEM            ';
        WM_CHARTOITEM              : Result := 'WM_CHARTOITEM            ';
        WM_SETFONT                 : Result := 'WM_SETFONT               ';
        WM_GETFONT                 : Result := 'WM_GETFONT               ';
        WM_SETHOTKEY               : Result := 'WM_SETHOTKEY             ';
        WM_GETHOTKEY               : Result := 'WM_GETHOTKEY             ';
        WM_QUERYDRAGICON           : Result := 'WM_QUERYDRAGICON         ';
        WM_COMPAREITEM             : Result := 'WM_COMPAREITEM           ';
        WM_GETOBJECT               : Result := 'WM_GETOBJECT             ';
        WM_COMPACTING              : Result := 'WM_COMPACTING            ';
        WM_COMMNOTIFY              : Result := 'WM_COMMNOTIFY            ';
        WM_WINDOWPOSCHANGING       : Result := 'WM_WINDOWPOSCHANGING     ';
        WM_WINDOWPOSCHANGED        : Result := 'WM_WINDOWPOSCHANGED      ';
        WM_POWER                   : Result := 'WM_POWER                 ';
        WM_COPYDATA                : Result := 'WM_COPYDATA              ';
        WM_CANCELJOURNAL           : Result := 'WM_CANCELJOURNAL         ';
        WM_NOTIFY                  : Result := 'WM_NOTIFY                ';
        WM_INPUTLANGCHANGEREQUEST  : Result := 'WM_INPUTLANGCHANGEREQUEST';
        WM_INPUTLANGCHANGE         : Result := 'WM_INPUTLANGCHANGE       ';
        WM_TCARD                   : Result := 'WM_TCARD                 ';
        WM_HELP                    : Result := 'WM_HELP                  ';
        WM_USERCHANGED             : Result := 'WM_USERCHANGED           ';
        WM_NOTIFYFORMAT            : Result := 'WM_NOTIFYFORMAT          ';
        WM_CONTEXTMENU             : Result := 'WM_CONTEXTMENU           ';
        WM_STYLECHANGING           : Result := 'WM_STYLECHANGING         ';
        WM_STYLECHANGED            : Result := 'WM_STYLECHANGED          ';
        WM_DISPLAYCHANGE           : Result := 'WM_DISPLAYCHANGE         ';
        WM_GETICON                 : Result := 'WM_GETICON               ';
        WM_SETICON                 : Result := 'WM_SETICON               ';
        WM_NCCREATE                : Result := 'WM_NCCREATE              ';
        WM_NCDESTROY               : Result := 'WM_NCDESTROY             ';
        WM_NCCALCSIZE              : Result := 'WM_NCCALCSIZE            ';
        WM_NCHITTEST               : Result := 'WM_NCHITTEST             ';
        WM_NCPAINT                 : Result := 'WM_NCPAINT               ';
        WM_NCACTIVATE              : Result := 'WM_NCACTIVATE            ';
        WM_GETDLGCODE              : Result := 'WM_GETDLGCODE            ';
        WM_NCMOUSEMOVE             : Result := 'WM_NCMOUSEMOVE           ';
        WM_NCLBUTTONDOWN           : Result := 'WM_NCLBUTTONDOWN         ';
        WM_NCLBUTTONUP             : Result := 'WM_NCLBUTTONUP           ';
        WM_NCLBUTTONDBLCLK         : Result := 'WM_NCLBUTTONDBLCLK       ';
        WM_NCRBUTTONDOWN           : Result := 'WM_NCRBUTTONDOWN         ';
        WM_NCRBUTTONUP             : Result := 'WM_NCRBUTTONUP           ';
        WM_NCRBUTTONDBLCLK         : Result := 'WM_NCRBUTTONDBLCLK       ';
        WM_NCMBUTTONDOWN           : Result := 'WM_NCMBUTTONDOWN         ';
        WM_NCMBUTTONUP             : Result := 'WM_NCMBUTTONUP           ';
        WM_NCMBUTTONDBLCLK         : Result := 'WM_NCMBUTTONDBLCLK       ';
        //WM_KEYFIRST                : Result := 'WM_KEYFIRST              ';
        WM_KEYDOWN                 : Result := 'WM_KEYDOWN               ';
        WM_KEYUP                   : Result := 'WM_KEYUP                 ';
        WM_CHAR                    : Result := 'WM_CHAR                  ';
        WM_DEADCHAR                : Result := 'WM_DEADCHAR              ';
        WM_SYSKEYDOWN              : Result := 'WM_SYSKEYDOWN            ';
        WM_SYSKEYUP                : Result := 'WM_SYSKEYUP              ';
        WM_SYSCHAR                 : Result := 'WM_SYSCHAR               ';
        WM_SYSDEADCHAR             : Result := 'WM_SYSDEADCHAR           ';
        WM_KEYLAST                 : Result := 'WM_KEYLAST               ';
        WM_INITDIALOG              : Result := 'WM_INITDIALOG            ';
        WM_COMMAND                 : Result := 'WM_COMMAND               ';
        WM_SYSCOMMAND              : Result := 'WM_SYSCOMMAND            ';
        WM_TIMER                   : Result := 'WM_TIMER                 ';
        WM_HSCROLL                 : Result := 'WM_HSCROLL               ';
        WM_VSCROLL                 : Result := 'WM_VSCROLL               ';
        WM_INITMENU                : Result := 'WM_INITMENU              ';
        WM_INITMENUPOPUP           : Result := 'WM_INITMENUPOPUP         ';
        WM_MENUSELECT              : Result := 'WM_MENUSELECT            ';
        WM_MENUCHAR                : Result := 'WM_MENUCHAR              ';
        WM_ENTERIDLE               : Result := 'WM_ENTERIDLE             ';
        WM_MENURBUTTONUP           : Result := 'WM_MENURBUTTONUP         ';
        WM_MENUDRAG                : Result := 'WM_MENUDRAG              ';
        WM_MENUGETOBJECT           : Result := 'WM_MENUGETOBJECT         ';
        WM_UNINITMENUPOPUP         : Result := 'WM_UNINITMENUPOPUP       ';
        WM_MENUCOMMAND             : Result := 'WM_MENUCOMMAND           ';
        WM_CHANGEUISTATE           : Result := 'WM_CHANGEUISTATE         ';
        WM_UPDATEUISTATE           : Result := 'WM_UPDATEUISTATE         ';
        WM_QUERYUISTATE            : Result := 'WM_QUERYUISTATE          ';
        WM_CTLCOLORMSGBOX          : Result := 'WM_CTLCOLORMSGBOX        ';
        WM_CTLCOLOREDIT            : Result := 'WM_CTLCOLOREDIT          ';
        WM_CTLCOLORLISTBOX         : Result := 'WM_CTLCOLORLISTBOX       ';
        WM_CTLCOLORBTN             : Result := 'WM_CTLCOLORBTN           ';
        WM_CTLCOLORDLG             : Result := 'WM_CTLCOLORDLG           ';
        WM_CTLCOLORSCROLLBAR       : Result := 'WM_CTLCOLORSCROLLBAR     ';
        WM_CTLCOLORSTATIC          : Result := 'WM_CTLCOLORSTATIC        ';
        //WM_MOUSEFIRST              : Result := 'WM_MOUSEFIRST            ';
        WM_MOUSEMOVE               : Result := 'WM_MOUSEMOVE             ';
        WM_LBUTTONDOWN             : Result := 'WM_LBUTTONDOWN           ';
        WM_LBUTTONUP               : Result := 'WM_LBUTTONUP             ';
        WM_LBUTTONDBLCLK           : Result := 'WM_LBUTTONDBLCLK         ';
        WM_RBUTTONDOWN             : Result := 'WM_RBUTTONDOWN           ';
        WM_RBUTTONUP               : Result := 'WM_RBUTTONUP             ';
        WM_RBUTTONDBLCLK           : Result := 'WM_RBUTTONDBLCLK         ';
        WM_MBUTTONDOWN             : Result := 'WM_MBUTTONDOWN           ';
        WM_MBUTTONUP               : Result := 'WM_MBUTTONUP             ';
        WM_MBUTTONDBLCLK           : Result := 'WM_MBUTTONDBLCLK         ';
        //WM_MOUSEWHEEL              : Result := 'WM_MOUSEWHEEL            ';
        WM_MOUSELAST               : Result := 'WM_MOUSELAST             ';
        WM_PARENTNOTIFY            : Result := 'WM_PARENTNOTIFY          ';
        WM_ENTERMENULOOP           : Result := 'WM_ENTERMENULOOP         ';
        WM_EXITMENULOOP            : Result := 'WM_EXITMENULOOP          ';
        WM_NEXTMENU                : Result := 'WM_NEXTMENU              ';
        WM_SIZING                  : Result := 'WM_SIZING                ';
        WM_CAPTURECHANGED          : Result := 'WM_CAPTURECHANGED        ';
        WM_MOVING                  : Result := 'WM_MOVING                ';
        WM_POWERBROADCAST          : Result := 'WM_POWERBROADCAST        ';
        WM_DEVICECHANGE            : Result := 'WM_DEVICECHANGE          ';
        WM_IME_STARTCOMPOSITION    : Result := 'WM_IME_STARTCOMPOSITION  ';
        WM_IME_ENDCOMPOSITION      : Result := 'WM_IME_ENDCOMPOSITION    ';
        //WM_IME_COMPOSITION         : Result := 'WM_IME_COMPOSITION       ';
        WM_IME_KEYLAST             : Result := 'WM_IME_KEYLAST           ';
        WM_IME_SETCONTEXT          : Result := 'WM_IME_SETCONTEXT        ';
        WM_IME_NOTIFY              : Result := 'WM_IME_NOTIFY            ';
        WM_IME_CONTROL             : Result := 'WM_IME_CONTROL           ';
        WM_IME_COMPOSITIONFULL     : Result := 'WM_IME_COMPOSITIONFULL   ';
        WM_IME_SELECT              : Result := 'WM_IME_SELECT            ';
        WM_IME_CHAR                : Result := 'WM_IME_CHAR              ';
        WM_IME_REQUEST             : Result := 'WM_IME_REQUEST           ';
        WM_IME_KEYDOWN             : Result := 'WM_IME_KEYDOWN           ';
        WM_IME_KEYUP               : Result := 'WM_IME_KEYUP             ';
        WM_MDICREATE               : Result := 'WM_MDICREATE             ';
        WM_MDIDESTROY              : Result := 'WM_MDIDESTROY            ';
        WM_MDIACTIVATE             : Result := 'WM_MDIACTIVATE           ';
        WM_MDIRESTORE              : Result := 'WM_MDIRESTORE            ';
        WM_MDINEXT                 : Result := 'WM_MDINEXT               ';
        WM_MDIMAXIMIZE             : Result := 'WM_MDIMAXIMIZE           ';
        WM_MDITILE                 : Result := 'WM_MDITILE               ';
        WM_MDICASCADE              : Result := 'WM_MDICASCADE            ';
        WM_MDIICONARRANGE          : Result := 'WM_MDIICONARRANGE        ';
        WM_MDIGETACTIVE            : Result := 'WM_MDIGETACTIVE          ';
        WM_MDISETMENU              : Result := 'WM_MDISETMENU            ';
        WM_ENTERSIZEMOVE           : Result := 'WM_ENTERSIZEMOVE         ';
        WM_EXITSIZEMOVE            : Result := 'WM_EXITSIZEMOVE          ';
        WM_DROPFILES               : Result := 'WM_DROPFILES             ';
        WM_MDIREFRESHMENU          : Result := 'WM_MDIREFRESHMENU        ';
        WM_MOUSEHOVER              : Result := 'WM_MOUSEHOVER            ';
        WM_MOUSELEAVE              : Result := 'WM_MOUSELEAVE            ';
        WM_CUT                     : Result := 'WM_CUT                   ';
        WM_COPY                    : Result := 'WM_COPY                  ';
        WM_PASTE                   : Result := 'WM_PASTE                 ';
        WM_CLEAR                   : Result := 'WM_CLEAR                 ';
        WM_UNDO                    : Result := 'WM_UNDO                  ';
        WM_RENDERFORMAT            : Result := 'WM_RENDERFORMAT          ';
        WM_RENDERALLFORMATS        : Result := 'WM_RENDERALLFORMATS      ';
        WM_DESTROYCLIPBOARD        : Result := 'WM_DESTROYCLIPBOARD      ';
        WM_DRAWCLIPBOARD           : Result := 'WM_DRAWCLIPBOARD         ';
        WM_PAINTCLIPBOARD          : Result := 'WM_PAINTCLIPBOARD        ';
        WM_VSCROLLCLIPBOARD        : Result := 'WM_VSCROLLCLIPBOARD      ';
        WM_SIZECLIPBOARD           : Result := 'WM_SIZECLIPBOARD         ';
        WM_ASKCBFORMATNAME         : Result := 'WM_ASKCBFORMATNAME       ';
        WM_CHANGECBCHAIN           : Result := 'WM_CHANGECBCHAIN         ';
        WM_HSCROLLCLIPBOARD        : Result := 'WM_HSCROLLCLIPBOARD      ';
        WM_QUERYNEWPALETTE         : Result := 'WM_QUERYNEWPALETTE       ';
        WM_PALETTEISCHANGING       : Result := 'WM_PALETTEISCHANGING     ';
        WM_PALETTECHANGED          : Result := 'WM_PALETTECHANGED        ';
        WM_HOTKEY                  : Result := 'WM_HOTKEY                ';
        WM_PRINT                   : Result := 'WM_PRINT                 ';
        WM_PRINTCLIENT             : Result := 'WM_PRINTCLIENT           ';
        //WM_THEMECHANGED            : Result := 'WM_THEMECHANGED          ';
        WM_HANDHELDFIRST           : Result := 'WM_HANDHELDFIRST         ';
        WM_HANDHELDLAST            : Result := 'WM_HANDHELDLAST          ';
        WM_PENWINFIRST             : Result := 'WM_PENWINFIRST           ';
        WM_PENWINLAST              : Result := 'WM_PENWINLAST            ';
        WM_COALESCE_FIRST          : Result := 'WM_COALESCE_FIRST        ';
        WM_COALESCE_LAST           : Result := 'WM_COALESCE_LAST         ';
        {$IFNDEF ADX_VCL5}
        //WM_NCXBUTTONDOWN           : Result := 'WM_NCXBUTTONDOWN         ';
        //WM_NCXBUTTONUP             : Result := 'WM_NCXBUTTONUP           ';
        //WM_INPUT                   : Result := 'WM_INPUT                 ';
        //WM_NCXBUTTONDBLCLK         : Result := 'WM_NCXBUTTONDBLCLK       ';
        //WM_NCMOUSELEAVE            : Result := 'WM_NCMOUSELEAVE          ';
        //WM_TABLET_FIRST            : Result := 'WM_TABLET_FIRST          ';
        //WM_NCMOUSEHOVER            : Result := 'WM_NCMOUSEHOVER          ';
        //WM_WTSSESSION_CHANGE       : Result := 'WM_WTSSESSION_CHANGE     ';
        //WM_TABLET_LAST             : Result := 'WM_TABLET_LAST           ';
        //WM_APPCOMMAND              : Result := 'WM_APPCOMMAND            ';
       {$ENDIF}
    else
      Result := 'Message 0x' + IntToHex(Msg, 8);
  end;
  Result := Trim(Result);
end;

end.
