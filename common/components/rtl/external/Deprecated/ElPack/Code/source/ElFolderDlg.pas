{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

06/11/2003

  Extra taskbar button appeared when the dialog was shown. Fixed.

05/30/2003

  Added Position property to position the dialog

04/19/2002

  Added StatusText property

09/06/2001

  Some problems with virtual and "dual" folders fixed

08/11/2001

  the problem with initial selection was fixed

*)


unit ElFolderDlg;

interface

uses Windows, Forms, Controls, SysUtils, Classes, Messages, ActiveX,
{$ifdef VCL_6_USED}
Types,
{$endif}
{$ifdef VCL_5_USED}
  MultiMon,
{$endif}
     ShlObj, ElShellUtils, StdCtrls, Dialogs, Menus;

type

    TBrowseForFolderOption = (bfoFileSysDirsOnly, bfoDontGoBelowDomain,
       bfoStatusText, bfoFileSysAncestors, bfoBrowseForComputer,
       bfBrowseForPrinter, bfoBrowseIncludeFiles, bfoShowPath{, bfoNoNewFolderButton});

    TBrowseForFolderOptions = set of TBrowseForFolderOption;

    TFolderDialogPosition = (fdpDefault, fdpScreenCenter, fdpDesktopCenter, fdpMainFormCenter, fdpOwnerFormCenter); 

{$ifndef VCL_3_USED}
{$HPPEMIT 'typedef int (CALLBACK* BFFCALLBACK)(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData);'}
{$HPPEMIT 'typedef struct _browseinfoA {'}
{$HPPEMIT '    HWND hwndOwner;'}
{$HPPEMIT '    PItemIDList pidlRoot;'}
{$HPPEMIT '    LPTSTR pszDisplayName;'}
{$HPPEMIT '    LPCTSTR lpszTitle;'}
{$HPPEMIT '    UINT ulFlags;'}
{$HPPEMIT '    BFFCALLBACK lpfn;'}
{$HPPEMIT '    LPARAM lParam;'}
{$HPPEMIT '    int iImage;'}
(*$HPPEMIT '} BROWSEINFO, *PBROWSEINFO, *LPBROWSEINFO;'*)
{$endif}

  TElFolderDialog = class (TCommonDialog)
  private
    FXDefWndProc,
    ObjInstance : Pointer;
    FBrowseInfo: TBrowseInfo;
    FCustBtn: TButton;
    FCustomButtonCaption: String;
    FDialogTitle: String;
    FDisplayName: array[0..MAX_PATH] of char;
    FFolder: String;
    FFolderPIDL: PItemIDList;
    FHandle: Integer;
    FOnChange: TNotifyEvent;
    FOnCustomButtonClick: TNotifyEvent;
    FOptions: TBrowseForFolderOptions;
    FParent: TWinControl;
    FRootFolder: TShellFolders;
    FShowCustomButton: Boolean;
    JustInit : boolean;
    OriginalSelect : boolean;
    FVisible: Boolean;
    function GetFolder: String;
    function GetParent: TWinControl;
    procedure SetFolder(const Value: String);
    procedure SetParent(Value: TWinControl);
    procedure SetRootFolder(Value: TShellFolders);
    {$ifdef VCL_5_USED}
    procedure SetWindowToMonitor(Handle : HWND);
    {$endif}
  protected
    FCustomRootFolder: string;
    FStatusText: string;
    FPrompt: string;
    FPosition: TFolderDialogPosition;
    function  Perform(Msg: Cardinal; WParam, LParam: Longint): LongInt;
    procedure SetStatusText(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    function Execute: Boolean; override;

    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    procedure SetSelectionPIDL(PIDL : PItemIDList);
    procedure WinInitialized(Param : Integer);
    procedure WinSelChanged(Param : Integer);
    property Handle: Integer read FHandle;

    property SelectionPIDL : PItemIDList read FFolderPIDL;
  published
    property Parent: TWinControl read GetParent write SetParent stored false;
    property DialogTitle: String read FDialogTitle write FDialogTitle;
    property CustomButtonCaption: String read FCustomButtonCaption write
        FCustomButtonCaption;
    property Folder: String read GetFolder write SetFolder;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCustomButtonClick: TNotifyEvent read FOnCustomButtonClick write
        FOnCustomButtonClick;
    property Options: TBrowseForFolderOptions read FOptions write FOptions;
    property RootFolder: TShellFolders read FRootFolder write SetRootFolder;
    property ShowCustomButton: Boolean read FShowCustomButton write
        FShowCustomButton;
    property CustomRootFolder: string read FCustomRootFolder write
        FCustomRootFolder;
    property StatusText: string read FStatusText write SetStatusText;
    property Prompt: string read FPrompt write FPrompt;
    property Position: TFolderDialogPosition read FPosition write FPosition;
  end;


implementation

var DialogBaseUnits: packed record
      X,
      Y: word
    end;

function BrowseCallback(wnd : HWND; msg : integer; LParam, lpData : Integer):
    Integer; stdcall;
begin
  with TObject(lpData) as TElFolderDialog do
  case msg of
    BFFM_INITIALIZED:
      begin
        FHandle := Wnd;
        FXDefWndProc := pointer(SetWindowLong(
          FHandle, GWL_WNDPROC, integer(ObjInstance)));
        WinInitialized(wnd);
      end;
    BFFM_SELCHANGED:
      if not JustInit then
         WinSelChanged(lParam);
    end;
  result := 0;
end;

{:
}
{
******************************* TElFolderDialog ********************************
}

constructor TElFolderDialog.Create(AOwner : TComponent);
begin
  inherited;
  ObjInstance := MakeObjectInstance(WndProc);
end;

destructor TElFolderDialog.Destroy;
begin
  if Handle <> 0 then
     Perform(WM_SYSCOMMAND, SC_CLOSE, 0); { just to be sure }
  if ObjInstance <> nil then FreeObjectInstance(ObjInstance);
  if FFolderPIDL <> nil then
     FreeIDList(FFolderPIDL);
  inherited Destroy;
end;

function TElFolderDialog.Execute: Boolean;
var
  P: PItemIDList;
  I: Integer;
  SaveFolder : string;

  const
    BROWSEFLAGS: array[TBrowseForFolderOption] of Cardinal =
      (BIF_RETURNONLYFSDIRS, BIF_DONTGOBELOWDOMAIN, BIF_STATUSTEXT,
       BIF_RETURNFSANCESTORS, BIF_BROWSEFORCOMPUTER, BIF_BROWSEFORPRINTER,
       BIF_BROWSEINCLUDEFILES, 0{, BIF_NONEWFOLDERBUTTON});

begin
  SaveFolder := Folder;
  FillChar(FBrowseInfo, sizeof(FBrowseInfo), 0);
  //if Parent <> nil then
  FBrowseInfo.hwndOwner := Application.Handle;//GetDesktopWindow; //Parent.Handle;
  FBrowseInfo.pszDisplayName := FDisplayName;
  FBrowseInfo.lpszTitle := PChar(FPrompt);
  FBrowseInfo.LParam := LongInt(Self);
  FBrowseInfo.lpfn := @BrowseCallback;
  FBrowseInfo.pidlRoot := GetFolderPIDL2(FRootFolder, CustomRootFolder);
  FBrowseInfo.ulFlags := 0;
  for i := 0 to Ord(bfoBrowseIncludeFiles) do
    if TBrowseForFolderOption(i) in FOptions then
       FBrowseInfo.ulFlags := FBrowseInfo.ulFlags or
           BROWSEFLAGS[TBrowseForFolderOption(i)];
  JustInit := true;
  OriginalSelect := true;
  FVisible := true;
  P := SHBrowseForFolder(FBrowseInfo);
  FVisible := false;
  FHandle := 0;
  result := P <> nil;
  if FCustBtn <> nil then
  begin
    FCustBtn.Free;
    FCustBtn := nil;
  end;
  if Result then
  begin
    if (bfoBrowseForComputer in Options) then
    begin
      Folder := StrPas(FDisplayName);
      if P <> nil then
       FreeIDList(P);
    end
    else
    begin
      SetSelectionPIDL(P);
    end;
  end
  else
  begin
    {
    FFolder := '';
    if FFolderPIDL <> nil then
      FreeIDList(FFolderPIDL);
    FFolderPIDL := nil;
    }
    Folder := SaveFolder;
  end;
end;

function TElFolderDialog.GetFolder: String;
begin
  if Assigned(FFolderPIDL) then
    GetPathFromPIDL(FFolderPIDL, Result)
  else
    Result:= FFolder;
end;

function TElFolderDialog.GetParent: TWinControl;
begin
  {
  if FParent = nil then
  begin
    if Assigned(Owner) and (Owner is TWinControl) then
       Parent := Owner as TWinControl
    else
       if Assigned(Application.MainForm) then
          Parent := Application.MainForm;
  end;
  }
  result := nil;
end;

procedure TElFolderDialog.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  if (AComponent = FParent) and (Operation = opRemove) then
    Parent := nil;
end;

procedure TElFolderDialog.SetFolder(const Value: String);
begin
  FFolder := Value;
  SetSelectionPIDL(GETPIDLFromPath(Value));
end;

procedure TElFolderDialog.SetParent(Value: TWinControl);
begin
  (*
  if FParent <> Value then
  begin
    {$ifdef VCL_5_USED}
    if FParent <> nil then
      if not (csDestroying in FParent.ComponentState) then
        FParent.RemoveFreeNotification(Self);
    {$endif}
    FParent := Value;
    if FParent <> nil then
      FParent.FreeNotification(Self);
  end;
  *)
end;

procedure TElFolderDialog.SetRootFolder(Value: TShellFolders);
begin
  FRootFolder := Value;
end;

procedure TElFolderDialog.SetSelectionPIDL(PIDL : PItemIDList);
begin
  WinSelChanged(Integer(PIDL));
  if PIDL <> nil then
    FreeIDList(PIDL);
  //if Handle <> 0 then
    //Perform(BFFM_SETSELECTION, integer(FALSE), integer(PIDL));
end;

procedure TElFolderDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FXDefWndProc, FHandle, Msg, WParam, LParam)
  else
    inherited DefaultHandler(Message);
end;

function TElFolderDialog.Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
var
  Message: TMessage;
begin
  Message.Msg := Msg;
  Message.WParam := WParam;
  Message.LParam := LParam;
  Message.Result := 0;
  if Self <> nil then WndProc(Message);
  Result := Message.Result;
end;

procedure TElFolderDialog.WinInitialized(Param : Integer);
var
  //s: String;
  R: TRect;
  P1, P2: TPoint;
  TreeRect, OkBtnRect, DlgRect: TRect;
  FClientWidth, FClientHeight: Integer;
  APIDL : PItemIDList;
  X, Y, Width, Height : integer;
  CenterForm: TCustomForm;

  procedure RecalcRect(var R : TRect);
  begin
    with R do
    begin
      Right := ((Right + Left) * DialogBaseUnits.X) div 4;
      Bottom:= ((Bottom + Top) * DialogBaseUnits.Y) div 8;
      Left  := (Left * DialogBaseUnits.X) div 4;
      Top   := (Top * DialogBaseUnits.Y) div 8;
    end;
  end;

  function ScaledX(X : integer): Integer;
  begin
    result := 1 + ((X * FClientWidth) div (DlgRect.Right - DlgRect.Left));
  end;

  function ScaledY(Y : integer): Integer;
  begin
    Result:= 1 + ((Y * FClientHeight) div (DlgRect.Bottom - DlgRect.Top));
  end;

begin
  (*
  if FFolder <> '' then
  begin
    if not GetPathFromPIDL(FFolderPIDL, S) then S:= '';
    if FFolder = S then
    begin
      FreeIDList(FFolderPIDL);
      FFolderPIDL := nil;
      SetSelectionPIDL(FFolderPIDL);
    end
    else
       Folder := FFolder;
  end;
  *)
  JustInit := false;

  SetWindowText(Param, PChar(FDialogTitle));
  SetStatusText(FStatusText);

  if ShowCustomButton then
  begin
    Windows.GetClientRect(Param, R);
    FClientWidth := R.Right;
    FClientHeight:= R.Bottom;
    DlgRect := Rect(46, 21, 212, 188);
    RecalcRect(DlgRect);
    TreeRect := Rect(7,42,197,112);
    RecalcRect(TreeRect);
    OkBtnRect := Rect(100, 166, 50, 14);
    RecalcRect(OkBtnRect);
    FCustBtn := TButton.Create(nil);
    FCustBtn.ParentWindow := Param;
    FCustBtn.Caption := CustomButtonCaption;
    FCustBtn.OnClick := OnCustomButtonClick;
    FCustBtn.ControlStyle := FCustBtn.ControlStyle + [csClickEvents];
    P1.X := ScaledX(TreeRect.Left)+1;
    P1.Y := ScaledY(OkBtnRect.Top)-1;
    P2.X := ScaledX(OkBtnRect.Right - OkBtnRect.Left)+1;
    P2.Y := ScaledY(OkBtnRect.Bottom - OkBtnRect.Top)-1;
    FCustBtn.SetBounds(P1.X, P1.Y, P2.X, P2.Y);
  end;
  APIDL := ClonePIDL(FFolderPIDL);
  SetSelectionPIDL(APIDL);
  // FreeIDList(APIDL);
  GetWindowRect(Param, R);
  Width := R.Right - R.Left;
  Height := R.Bottom - R.Top;
  case Position of
    {$ifndef VCL_5_USED}
	fdpDesktopCenter,
	{$endif}
    fdpScreenCenter:
      begin
        X := (Screen.Width - Width) div 2;
        Y := (Screen.Height - Height) div 2;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
        {$ifdef VCL_5_USED}
        SetWindowToMonitor(Param);
        {$endif}
      end;
    {$ifdef VCL_5_USED}
    fdpDesktopCenter:
      begin
        X := (Screen.DesktopWidth - Width) div 2;
        Y := (Screen.DesktopHeight - Height) div 2;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
      end;
    {$endif}
    fdpMainFormCenter,
    fdpOwnerFormCenter:
      begin
        CenterForm := Application.MainForm;
        if (Position = fdpOwnerFormCenter) and (Owner is TCustomForm) then
          CenterForm := TCustomForm(Owner);
        if Assigned(CenterForm) then
        begin
          X := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
          Y := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
        end else
        begin
          X := (Screen.Width - Width) div 2;
          Y := (Screen.Height - Height) div 2;
        end;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
        {$ifdef VCL_5_USED}
        SetWindowToMonitor(Param);
        {$endif}
      end;
  end;
end;

procedure TElFolderDialog.WinSelChanged(Param : Integer);
var
  S: String;
begin
  FreeIDList(FFolderPIDL);
  FFolderPIDL := nil;
  if Param <> 0 then
  begin
    FFolderPIDL := ClonePIDL(PItemIDList(Param));

    GetPathFromPIDL(FFolderPIDL, S);
    if (S = '') and (bfoBrowseForComputer in Options) then
       S := StrPas(FDisplayName);
    FFolder := S;
    (*
    if Length(S) > 0 then
      SendMessage(Handle, BFFM_SETSELECTION, Ord(true), Integer(PChar(S)))
    else
    *)
    if OriginalSelect then
    begin
      SendMessage(Handle, BFFM_SETSELECTION, Ord(false), Integer(FFolderPIDL));
      OriginalSelect := false;
    end;
    if bfoShowPath in Options then
    begin
      SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, DWORD(PChar(FFolder)));
    end;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TElFolderDialog.SetStatusText(const Value: string);
begin
  FStatusText := Value;
  if FVisible and (FHandle <> 0) then
    SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, DWORD(PChar(Value)));
end;

{$ifdef VCL_5_USED}
procedure TElFolderDialog.SetWindowToMonitor(Handle : HWND);
(*
var
  AppMon, WinMon: HMONITOR;
  I, J: Integer;
  ALeft, ATop: Integer;
  Width, Height : integer;
  R : TRect;
*)
begin
(*
  GetWindowRect(Handle, R);
  Width := R.Right - R.Left;
  Height := R.Bottom - R.Top;
  if (Application.MainForm <> nil) then
  begin
    AppMon := Application.MainForm.Monitor.Handle;
    WinMon := Monitor.Handle;
    for I := 0 to Screen.MonitorCount - 1 do
      if (Screen.Monitors[I].Handle = AppMon) then
        if (AppMon <> WinMon) then
          for J := 0 to Screen.MonitorCount - 1 do
            if (Screen.Monitors[J].Handle = WinMon) then
            begin
              if FPosition = poScreenCenter then
                 SetWindowPos(Handle, 0,
                  Screen.Monitors[I].Left + ((Screen.Monitors[I].Width - Width) div 2),
                  Screen.Monitors[I].Top + ((Screen.Monitors[I].Height - Height) div 2),
                   Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
              else
              if FPosition = poMainFormCenter then
              begin
                SetWindowPos(Handle, 0,
                  Screen.Monitors[I].Left + ((Screen.Monitors[I].Width - Width) div 2),
                  Screen.Monitors[I].Top + ((Screen.Monitors[I].Height - Height) div 2),
                   Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
              end
              else
              begin
                ALeft := Screen.Monitors[I].Left + Left - Screen.Monitors[J].Left;
                if ALeft + Width > Screen.Monitors[I].Left + Screen.Monitors[I].Width then
                  ALeft := Screen.Monitors[I].Left + Screen.Monitors[I].Width - Width;
                ATop := Screen.Monitors[I].Top + Top - Screen.Monitors[J].Top;
                if ATop + Height > Screen.Monitors[I].Top + Screen.Monitors[I].Height then
                  ATop := Screen.Monitors[I].Top + Screen.Monitors[I].Height - Height;
                SetWindowPos(Handle, 0, ALeft, ATop, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
              end;
            end;
  end;
*)
end;
{$endif}

initialization
  longint(DialogBaseUnits) := GetDialogBaseUnits;

end.
