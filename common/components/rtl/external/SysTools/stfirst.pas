{*********************************************************}
{*                  STFIRST.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StFirst;
  {-limit instance routines}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, Forms, SysUtils, Dialogs,

  StBase;

function IsFirstInstance: Boolean;
 {- check if previous instance is running}
procedure ActivateFirst(AString : PChar);
 {- Activate previous instance, passing a string}
procedure ActivateFirstCommandLine;
 {- Activate previous instance, passing the command line}


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  Classes,
  ShellApi,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

const
{$IFDEF WIN32}
  MAX_CMDLEN = 1024;
{$ELSE}
  MAX_CMDLEN = 255;
{$ENDIF}


var
  CmdLine : array[0..MAX_CMDLEN] of char;

{$IFDEF Win32}
var
  FirstInstance : Boolean;
  InstanceMutex : THandle;
{$ENDIF}

{limit instances routines}
function IsFirstInstance : Boolean;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  {$IFDEF Win32}
  Result := FirstInstance;
  {$ELSE}
  Result := HPrevInst = 0;
  {$ENDIF}
end;

{$IFDEF Win32}
procedure ActivateFirstCommandLine;
var
  S : String;
  I : Longint;
begin
  S := '';
  for I := 0 to ParamCount-1 do
    S := S + ParamStr(I) + ' ';
  S := S + ParamStr(ParamCount);
  StrPCopy(CmdLine, Copy(S, 1, MAX_CMDLEN));
  ActivateFirst(CmdLine);
end;


procedure ActivateFirst(AString : PChar);
var
  ClassBuf,
  WindowBuf : array [0..255] of AnsiChar;
  Wnd,
  TopWnd    : hWnd;
  ThreadID  : DWord;
  CDS       : TCopyDataStruct;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  if (strlen(AString) > 0) then begin
    CDS.dwData := WMCOPYID;
    CDS.cbData := StrLen(AString) + 1;
    CDS.lpData := AString;
  end else begin
    CDS.dwData := WMCOPYID;
    CDS.cbData := 0;
    CDS.lpData := nil;
  end;

  if IsFirstInstance then begin
    if IsIconic(Application.Handle) then
      Application.Restore
    else
      Application.BringToFront;
  end else begin
    GetClassName(Application.Handle, ClassBuf, SizeOf(ClassBuf));
    GetWindowText(Application.Handle, WindowBuf, SizeOf(WindowBuf));
    Wnd := FindWindow(ClassBuf, WindowBuf);
    if (Wnd <> 0) then begin
      GetWindowThreadProcessId(Wnd, @ThreadID);
      if (ThreadID = GetCurrentProcessId) then begin
        Wnd := FindWindowEx(0, Wnd, ClassBuf, WindowBuf);
        if (Wnd <> 0) then begin
          if IsIconic(Wnd) then
            ShowWindow(Wnd, SW_RESTORE);

          SetForegroundWindow(Wnd);
          TopWnd := GetLastActivePopup(Wnd);
          if (TopWnd <> 0) and (TopWnd <> Wnd) and
              IsWindowVisible(TopWnd) and IsWindowEnabled(TopWnd) then begin
            BringWindowToTop(TopWnd);
            SendMessage(TopWnd, WM_COPYDATA, 0, lparam(@CDS));
          end else begin
            BringWindowToTop(Wnd);
            SendMessage(Wnd, WM_COPYDATA, 0, lparam(@CDS));
          end;
        end;
      end;
    end;
  end;
end;
{$ELSE}

type
  PHWND = ^hWnd;

function EnumWndFunc(Wnd : hWnd; Target : PHWND) : Boolean; export;
var
  Buf : array[0..255] of Char;
begin
  Result := True;
  if GetWindowWord(Wnd, GWW_HINSTANCE) = HPrevInst then begin
    GetClassName(Wnd, Buf, SizeOf(Buf)-1);
    {find our application window}
    if StrIComp(Buf, 'TApplication') = 0 then begin
      Target^ := Wnd;
      Result := False;
    end;
  end;
end;


procedure ActivateFirstCommandLine;
var
  S : ShortString;
  I : Longint;
begin
  S := '';
  for I := 0 to ParamCount-1 do
    S := S + ParamStr(I) + ' ';
  S := S + ParamStr(ParamCount);
  StrPCopy(CmdLine, Copy(S, 1, MAX_CMDLEN));
  ActivateFirst(CmdLine);
end;


procedure ActivateFirst(AString : PChar);
var
  Wnd      : hWnd;
  TopWnd   : hWnd;
  CDS      : TCopyDataStruct;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  if (strlen(AString) > 0) then begin
    CDS.dwData := WMCOPYID;
    CDS.cbData := StrLen(AString) + 1;
    CDS.lpData := AString;
  end else begin
    CDS.dwData := WMCOPYID;
    CDS.cbData := 0;
    CDS.lpData := nil;
  end;

  if IsFirstInstance then begin
    if IsIconic(Application.Handle) then
      Application.Restore
    else
      Application.BringToFront;
  end else begin
    Wnd := 0;
    EnumWindows(@EnumWndFunc, LongInt(@Wnd));
    if Wnd <> 0 then begin
      if IsIconic(Wnd) then
        ShowWindow(Wnd, SW_RESTORE)
      else begin
        TopWnd := GetLastActivePopup(Wnd);
        if (TopWnd <> 0) and (TopWnd <> Wnd) and
           IsWindowVisible(TopWnd) and
           IsWindowEnabled(TopWnd) then begin
          ShowWindow(TopWnd, SW_SHOWNORMAL);
          SetFocus(TopWnd);
          SendMessage(TopWnd, WM_COPYDATA, 0, Longint(@CDS));
        end else begin
          ShowWindow(Wnd, SW_SHOWNORMAL);
          BringWindowToTop(Wnd);
          ShowOwnedPopups(Wnd, True);
          SetFocus(Wnd);
          SendMessage(Wnd, WM_COPYDATA, 0, Longint(@CDS));
        end;
      end;
    end;
  end;
end;
{$ENDIF}

{$IFDEF Win32}
function GetMutexName : string;
var
  WindowBuf : array [0..512] of AnsiChar;
begin
  GetWindowText(Application.Handle, WindowBuf, SizeOf(WindowBuf));
  Result := 'PREVINST:' + WindowBuf;
end;

initialization
  InstanceMutex := CreateMutex(nil, True, PAnsiChar(GetMutexName));
  if (InstanceMutex <> 0) and (GetLastError = 0) then
    FirstInstance := True
  else
    FirstInstance := False;

finalization
  if (InstanceMutex <> 0) then
    CloseHandle(InstanceMutex);
{$ENDIF}

end.
