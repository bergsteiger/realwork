unit TB97Cmn;

{
  Toolbar97
  Copyright (C) 1998 - 2001 by Jordan Russell
  For conditions of distribution and use, see LICENSE.TXT.

  Internal common functions
}
{ $Id: TB97CMN.PAS,v 1.20 2015/04/16 13:17:01 morozov Exp $ }

interface

{$I TB97Ver.inc}

uses
  Windows, Classes, Messages, Controls,
  tb97List,

  l3Base,
  l3ObjectRefList,
  l3ObjectList,
  l3LongintList,
  l3ProtoObject,
  l3Interfaces
  ;

type
  THookProcCode = (hpSendActivateApp, hpTabStop, hpSendWindowPosChanged, hpPreDestroy,
    hpPostMouseMove);
  THookProcCodes = set of THookProcCode;
  THookProc = procedure(Code: THookProcCode; Wnd: HWND; WParam: WPARAM; LParam: LPARAM);
  TListSortExCompare = function(const Item1, Item2, ExtraData: Pointer): Integer;
  THandleWMPrintNCPaintProc = procedure(Wnd: HWND; DC: HDC; AppData: Longint);
  TGetToolbarDockPosType = (gtpTop, gtpBottom, gtpLeft, gtpRight, gtpNone);

 Ttb97HooksManager = class(Tl3ProtoObject,
                           Il3GetMessageListener,
                           Il3WndProcListener,
                           Il3CBTListener)
 protected
   procedure GetMessageListenerNotify(Code: Integer;
     aWParam: WPARAM;
     Msg: PMsg;
     var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
     var theResult: Tl3HookProcResult);
   procedure CBTListenerNotify(Code: Integer;
     WParam: WPARAM;
     LParam: LPARAM;
     var theResult: Tl3HookProcResult);
 protected
   procedure Cleanup; override;
   procedure InitFields; override;
 public
   class function Instance: Ttb97HooksManager;
 end;
                   
var
  GetToolbarDockPosProc: function(Ctl: TControl): TGetToolbarDockPosType = nil;

function ApplicationIsActive: Boolean;
procedure InstallHookProc(AProc: THookProc; ACodes: THookProcCodes;
  OnlyIncrementCount: Boolean);
procedure UninstallHookProc(AProc: THookProc);
procedure ListSortEx(const List: Tl3ObjectList; const Compare: TListSortExCompare;
  const ExtraData: Pointer; const aExtraList: Ttb97List = nil); overload;
procedure ListSortEx(const List: Tl3LongintList; const Compare: TListSortExCompare;
  const ExtraData: Pointer; const aExtraList: Ttb97List = nil); overload;
procedure SelectNCUpdateRgn(Wnd: HWND; DC: HDC; Rgn: HRGN);
procedure HandleWMPrint(const Wnd: HWND; var Message: TMessage;
  const NCPaintFunc: THandleWMPrintNCPaintProc; const AppData: Longint);
procedure HandleWMPrintClient(const Control: TWinControl;
  var Message: TMessage);

{$IFNDEF TB97D3}
type
  PMaxLogPalette = ^TMaxLogPalette;
  TMaxLogPalette = packed record
    palVersion: Word;
    palNumEntries: Word;
    palPalEntry: array[Byte] of TPaletteEntry;
  end;
function CopyPalette(Palette: HPALETTE): HPALETTE;
{$ENDIF}

implementation

uses
 l3ListenersManager,

 SysUtils,
 Forms;

type
  PHookProcData = ^THookProcData;
  THookProcData = record
    Proc: THookProc;
    RefCount: Longint;
    Codes: THookProcCodes;
  end;
  THookType = (htCallWndProc, htCBT, htGetMessage);
  THookTypes = set of THookType;

var
  HookProcList: Ttb97List = nil;
  HookCounts: array[THookType] of Longint;

{ Ttb97HooksManager }

procedure Ttb97HooksManager.Cleanup;
begin
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveGetMessageListener(Self);
 Tl3ListenersManager.RemoveCBTListener(Self);
 inherited;
end;

procedure Ttb97HooksManager.InitFields;
begin
 inherited;
 //
end;

var g_Ttb97HooksManager : Ttb97HooksManager = nil;

procedure Ttb97HooksManagerFree;
begin
 l3Free(g_Ttb97HooksManager);
end;

class function Ttb97HooksManager.Instance: Ttb97HooksManager;
begin
 if (g_Ttb97HooksManager = nil) then
 begin
  l3System.AddExitProc(Ttb97HooksManagerFree);
  g_Ttb97HooksManager := Create;
 end;
 Result := g_Ttb97HooksManager;
end;

procedure Ttb97HooksManager.WndProcListenerNotify(Msg: PCWPStruct;
  var theResult: Tl3HookProcResult);
type
  THookProcCodeMsgs = hpSendActivateApp..hpSendWindowPosChanged;
const
  MsgMap: array[THookProcCodeMsgs] of UINT =
    (WM_ACTIVATEAPP, CM_TABSTOPCHANGED, WM_WINDOWPOSCHANGED);
var
  J: THookProcCodeMsgs;
  I: Integer;
begin
 if Assigned(HookProcList) then
  for J := Low(J) to High(J) do
   if Msg.Message = MsgMap[J] then
   begin
    for I := 0 to HookProcList.Count - 1 do
     try
      with PHookProcData(HookProcList[I])^ do
       if J in Codes then
        Proc(J, Msg.hwnd, Msg.WParam, Msg.LParam);
     except
     end;
    Break;
   end;
end;

procedure Ttb97HooksManager.GetMessageListenerNotify(Code: Integer;
  aWParam: WPARAM; Msg: PMsg; var theResult: Tl3HookProcResult);
var
  I: Integer;
begin
 if Assigned(HookProcList) and (Code = HC_ACTION) and
   (Msg.message = WM_MOUSEMOVE) then
  for I := 0 to HookProcList.Count - 1 do
   try
    with PHookProcData(HookProcList[I])^, Msg^ do
     if hpPostMouseMove in Codes then
      Proc(hpPostMouseMove, hwnd, wParam, lParam);
   except
   end;
end;

procedure Ttb97HooksManager.CBTListenerNotify(Code: Integer;
  WParam: WPARAM; LParam: LPARAM; var theResult: Tl3HookProcResult);
var
  I: Integer;
begin
 if Assigned(HookProcList) and (Code = HCBT_DESTROYWND) then
  for I := 0 to HookProcList.Count - 1 do
   try
    with PHookProcData(HookProcList[I])^ do
     if hpPreDestroy in Codes then
       Proc(hpPreDestroy, HWND(WParam), 0, 0);
   except
   end;
end;

function HookCodesToTypes(Codes: THookProcCodes): THookTypes;
const
  HookCodeToType: array[THookProcCode] of THookType =
    (htCallWndProc, htCallWndProc, htCallWndProc, htCBT, htGetMessage);
var
  J: THookProcCode;
begin
  Result := [];
  for J := Low(J) to High(J) do
    if J in Codes then
      Include(Result, HookCodeToType[J]);
end;

procedure InstallHooks(ATypes: THookTypes);
var
 T: THookType;
begin
 if htGetMessage in Atypes then
  Tl3ListenersManager.AddGetMessageListener(Ttb97HooksManager.Instance);
 if htCallWndProc in Atypes then
  Tl3ListenersManager.AddWndProcListener(Ttb97HooksManager.Instance);
 if htCBT in Atypes then
  Tl3ListenersManager.AddCBTListener(Ttb97HooksManager.Instance);

 for T := Low(THookType) to High(THookType) do
  if (T in ATypes) then
   Inc(HookCounts[T]);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=597332402
end;

procedure UninstallHooks(const ATypes: THookTypes; const Force: Boolean);
var
  T: THookType;
begin
 for T := Low(T) to High(T) do
  if T in ATypes then
  begin
   if HookCounts[T] > 0 then
    Dec(HookCounts[T]);
   if (Force or (HookCounts[T] = 0)) then
    case T of
     htGetMessage: Tl3ListenersManager.RemoveGetMessageListener(Ttb97HooksManager.Instance);
     htCallWndProc: Tl3ListenersManager.RemoveWndProcListener(Ttb97HooksManager.Instance);
     htCBT: Tl3ListenersManager.RemoveCBTListener(Ttb97HooksManager.Instance);
    else
     Assert(False);
    end;
  end;
end;

procedure InstallHookProc(AProc: THookProc; ACodes: THookProcCodes;
  OnlyIncrementCount: Boolean);
var
  Found: Boolean;
  I: Integer;
  Data: PHookProcData;
begin
  if HookProcList = nil then
    HookProcList := Ttb97List.Make;
  Found := False;
  for I := 0 to HookProcList.Count - 1 do
    with PHookProcData(HookProcList[I])^ do
      if @Proc = @AProc then
      begin
        Inc(RefCount);
        Found := True;
        Break;
      end;
  if not Found then
  begin
    New(Data);
    with Data^ do begin
      Proc := AProc;
      RefCount := 1;
      Codes := ACodes;
    end;
    HookProcList.Add(Data);
  end;
  if not OnlyIncrementCount then
    InstallHooks(HookCodesToTypes(ACodes));
end;

procedure UninstallHookProc(AProc: THookProc);
var
  I: Integer;
  Data: PHookProcData;
  T: THookTypes;
begin
  if HookProcList = nil then Exit;
  for I := 0 to HookProcList.Count - 1 do begin
    Data := PHookProcData(HookProcList[I]);
    if @Data.Proc = @AProc then
    begin
      T := HookCodesToTypes(Data.Codes);
      Dec(Data.RefCount);
      if Data.RefCount = 0 then
      begin
        HookProcList.Delete(I);
        Dispose(Data);
      end;
      UninstallHooks(T, False);
      Break;
    end;
  end;
  if HookProcList.Count = 0 then
  begin
    tb97Free(HookProcList);
    HookProcList := nil;
  end;
end;

function ApplicationIsActive: Boolean;
{ Returns True if the application is in the foreground }
begin
  Result := GetActiveWindow <> 0;
end;

{$IFNDEF TB97D3}
function CopyPalette(Palette: HPALETTE): HPALETTE;
var
  PaletteSize: Integer;
  LogPal: TMaxLogPalette;
begin
  Result := 0;
  if Palette = 0 then Exit;
  PaletteSize := 0;
  if GetObject(Palette, SizeOf(PaletteSize), @PaletteSize) = 0 then Exit;
  if PaletteSize = 0 then Exit;
  with LogPal do begin
    palVersion := $0300;
    palNumEntries := PaletteSize;
    GetPaletteEntries(Palette, 0, PaletteSize, palPalEntry);
  end;
  Result := CreatePalette(PLogPalette(@LogPal)^);
end;
{$ENDIF}

procedure ListSortEx(const List: Tl3ObjectList; const Compare: TListSortExCompare;
  const ExtraData: Pointer; const aExtraList: Ttb97List);
{ Similar to TList.Sort, but lets you pass a user - defined ExtraData pointer }
  procedure QuickSortEx(L: Integer; const R: Integer);
  var
    I, J: Integer;
    P: Pointer;
  begin
    repeat
      I := L;
      J := R;
      P := List.Items[(L + R) shr 1];
      repeat
        while Compare(List.Items[I], P, ExtraData) < 0 do Inc(I);
        while Compare(List.Items[J], P, ExtraData) > 0 do Dec(J);
        if I <= J then
        begin
          List.Exchange(I, J);
          if aExtraList <> nil then
            aExtraList.Exchange(I, J);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then
       QuickSortEx(L, J);
      L := I;
    until I >= R;
  end;
begin
  if List.Count > 1 then
    QuickSortEx(0, List.Count - 1);
end;

procedure ListSortEx(const List: Tl3LongintList; const Compare: TListSortExCompare;
  const ExtraData: Pointer; const aExtraList: Ttb97List);
{ Similar to TList.Sort, but lets you pass a user - defined ExtraData pointer }
  procedure QuickSortEx(L: Integer; const R: Integer);
  var
    I, J: Integer;
    P: Pointer;
  begin
    repeat
      I := L;
      J := R;
      P := Pointer(List.Items[(L + R) shr 1]);
      repeat
        while Compare(Pointer(List.Items[I]), P, ExtraData) < 0 do Inc(I);
        while Compare(Pointer(List.Items[J]), P, ExtraData) > 0 do Dec(J);
        if I <= J then
        begin
          List.Exchange(I, J);
          if aExtraList <> nil then
            aExtraList.Exchange(I, J);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSortEx(L, J);
      L := I;
    until I >= R;
  end;
begin
  if List.Count > 1 then
    QuickSortEx(0, List.Count - 1);
end;

procedure SelectNCUpdateRgn(Wnd: HWND; DC: HDC; Rgn: HRGN);
var
  R: TRect;
  NewClipRgn: HRGN;
begin
  if (Rgn <> 0) and (Rgn <> 1) then
  begin
    GetWindowRect(Wnd, R);
    if SelectClipRgn(DC, Rgn) = ERROR then
    begin
      NewClipRgn := CreateRectRgnIndirect(R);
      SelectClipRgn(DC, NewClipRgn);
      DeleteObject(NewClipRgn);
    end;
    OffsetClipRgn(DC, - R.Left, - R.Top);
  end;
end;

type
  PPrintEnumProcData = ^TPrintEnumProcData;
  TPrintEnumProcData = record
    PrintChildren: Boolean;
    ParentWnd: HWND;
    DC: HDC;
    PrintFlags: LPARAM;
  end;

function PrintEnumProc(Wnd: HWND; LParam: LPARAM): BOOL; stdcall;
var
  R: TRect;
  SaveIndex: Integer;
begin
  Result := True;  { continue enumerating }
  with PPrintEnumProcData(LParam)^ do begin
    { Skip window if it isn't a child/owned window of ParentWnd or isn't visible }
    if (HWND(GetWindowLong(Wnd, GWL_HWNDPARENT)) <> ParentWnd) or
       (GetWindowLong(Wnd, GWL_STYLE) and WS_VISIBLE = 0) then
         { ^ don't use IsWindowVisible since it returns False if the window's
           parent window is not visible }
      Exit;
    GetWindowRect(Wnd, R);
    MapWindowPoints(0, ParentWnd, R, 2);
    SaveIndex := SaveDC(DC);
    { Like Windows, offset the window origin to the top - left coordinates of
      the child/owned window }
    MoveWindowOrg(DC, R.Left, R.Top);
    { Like Windows, intersect the clipping region with the entire rectangle of
      the child/owned window }
    OffsetRect(R, - R.Left, - R.Top);
    IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    { Send a WM_PRINT message to the child/owned window }
    SendMessage(Wnd, WM_PRINT, WPARAM(DC), PrintFlags);
    { Restore the DC's state, in case the WM_PRINT handler didn't put things
      back the way it found them }
    RestoreDC(DC, SaveIndex);
  end;
end;

procedure HandleWMPrint(const Wnd: HWND; var Message: TMessage;
  const NCPaintFunc: THandleWMPrintNCPaintProc; const AppData: Longint);
{ note: AppData is an application - defined value which is passed to NCPaintFunc }
var
  DC: HDC;
  SaveIndex, SaveIndex2: Integer;
  R: TRect;
  P: TPoint;
  Data: TPrintEnumProcData;
begin
  if (Message.LParam and PRF_CHECKVISIBLE = 0) or IsWindowVisible(Wnd) then
  begin
    DC := HDC(Message.WParam);
    SaveIndex2 := SaveDC(DC);
    try
      if Message.LParam and PRF_NONCLIENT <> 0 then
      begin
        SaveIndex := SaveDC(DC);
        if Assigned(NCPaintFunc) then
          NCPaintFunc(Wnd, DC, AppData);
        RestoreDC(DC, SaveIndex);
      end;
      { Calculate the difference between the top - left corner of the window
        and the top - left corner of its client area }
      GetWindowRect(Wnd, R);
      P.X := 0;  P.Y := 0;
      ClientToScreen(Wnd, P);
      Dec(P.X, R.Left);
      Dec(P.Y, R.Top);
      if Message.LParam and PRF_CLIENT <> 0 then
      begin
        { Like Windows, the flags PRF_ERASEBKGND, PRF_CHILDREN, and PRF_OWNED
          are ignored if PRF_CLIENT isn't also specified }
        if Message.LParam and PRF_ERASEBKGND <> 0 then
        begin
          { Send WM_ERASEBKGND }
          SaveIndex := SaveDC(DC);
          if Message.LParam and PRF_NONCLIENT <> 0 then
            MoveWindowOrg(DC, P.X, P.Y);
          SendMessage(Wnd, WM_ERASEBKGND, Message.WParam, 0);
          RestoreDC(DC, SaveIndex);
        end;
        { Send WM_PRINTCLIENT }
        SaveIndex := SaveDC(DC);
        if Message.LParam and PRF_NONCLIENT <> 0 then
          MoveWindowOrg(DC, P.X, P.Y);
        SendMessage(Wnd, WM_PRINTCLIENT, Message.WParam, 0);
        RestoreDC(DC, SaveIndex);
        { Like Windows, always offset child/owned windows by the size of the
          client area even if PRF_NONCLIENT isn't specified (a bug?) }
        MoveWindowOrg(DC, P.X, P.Y);
        Data.ParentWnd := Wnd;
        Data.DC := DC;
        { Send WM_PRINT to child/owned windows }
        if Message.LParam and PRF_CHILDREN <> 0 then
        begin
          Data.PrintChildren := True;
          Data.PrintFlags := PRF_NONCLIENT or PRF_CLIENT or PRF_ERASEBKGND or
            PRF_CHILDREN;  { same flags as Windows passes to children }
          EnumChildWindows(Wnd, @PrintEnumProc, LPARAM(@Data));
        end;
        if Message.LParam and PRF_OWNED <> 0 then
        begin
          Data.PrintChildren := False;
          Data.PrintFlags := Message.LParam;
          EnumWindows(@PrintEnumProc, LPARAM(@Data));
        end;
      end;
    finally
      RestoreDC(DC, SaveIndex2);
    end;
  end;
  { Windows' WM_PRINT returns 1. I'm not sure why. }
  Message.Result := 1;
end;

type
  TWinControlAccess = class(TWinControl);

procedure HandleWMPrintClient(const Control: TWinControl; var Message: TMessage);
var
  Msg: TWMPaint;
  SaveIndex: Integer;
begin
  Msg.Msg := WM_PAINT;
  Msg.DC := HDC(Message.WParam);
  Msg.Unused := 0;
  Msg.Result := 0;
  SaveIndex := SaveDC(HDC(Message.WParam));
  try
    TWinControlAccess(Control).PaintHandler(Msg);
  finally
    RestoreDC(HDC(Message.WParam), SaveIndex);
  end;
end;

initialization
finalization
  UninstallHooks([Low(THookType)..High(THookType)], True);
  tb97Free(HookProcList);
  { Following line needed because, under certain circumstances, HookProcList
    may be referenced after the 'finalization' section is processed. (This
    can happen if a 'Halt' call is placed in the main form's OnCreate
    handler, for example.) }
  HookProcList := nil;
end.
