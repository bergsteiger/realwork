unit rxDialogs;

interface

{$Include l3XE.inc}

uses
  Classes
  ;

function BrowseDirectory(var AFolderName: AnsiString; const DlgText: AnsiString;
  AHelpContext: THelpContext): Boolean;

implementation

uses
  Windows,
  Messages,

  ShellAPI,

  Consts,

  SysUtils,

  Controls,
  Forms,
  FileCtrl,

  ComObj,
  ActiveX,
  
  VCLUtils,

  l3FileUtils
  ;

{ TBrowseFolderDlg }

const
{ message from browser }

  BFFM_INITIALIZED       = 1;
  BFFM_SELCHANGED        = 2;

{ messages to browser }

  BFFM_SETSTATUSTEXT      = (WM_USER + 100);
  BFFM_ENABLEOK           = (WM_USER + 101);
  BFFM_SETSELECTION       = (WM_USER + 102);

type
{ TSHItemID -- Item ID }

  PSHItemID = ^TSHItemID;
  TSHItemID = packed record           { mkid }
    cb: Word;                         { Size of the ID (including cb itself) }
    abID: array[0..0] of Byte;        { The item ID (variable length) }
  end;

{ TItemIDList -- List if item IDs (combined with 0-terminator) }

  PItemIDList = ^TItemIDList;
  TItemIDList = packed record         { idl }
     mkid: TSHItemID;
   end;
   
  TFNBFFCallBack = function(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;

  PBrowseInfo = ^TBrowseInfo;
  TBrowseInfo = packed record
    hwndOwner: HWND;
    pidlRoot: PItemIDList;
    pszDisplayName: LPSTR;  { Return display name of item selected. }
    lpszTitle: LPCSTR;      { text to go in the banner over the tree. }
    ulFlags: UINT;          { Flags that control the return stuff }
    lpfn: TFNBFFCallBack;
    lParam: LPARAM;         { extra info that's passed back in callbacks }
    iImage: Integer;        { output var: where to return the Image index. }
  end;

  TBrowseKind = (bfFolders, bfComputers);
  TDialogPosition = (dpDefault, dpScreenCenter);

  TBrowseFolderDlg = class(TComponent)
  private
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FDesktopRoot: Boolean;
    FBrowseKind: TBrowseKind;
    FPosition: TDialogPosition;
    FText: AnsiString;
    FDisplayName: AnsiString;
    FSelectedName: AnsiString;
    FFolderName: AnsiString;
    FImageIndex: Integer;
    FOnInitialized: TNotifyEvent;
    FOnSelChanged: TNotifyEvent;
    procedure SetSelPath(const Path: AnsiString);
    procedure SetOkEnable(Value: Boolean);
    procedure DoInitialized;
    procedure DoSelChanged(Param: PItemIDList);
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure WMCommand(var Message: TMessage); message WM_COMMAND;
  protected
    procedure DefaultHandler(var Message); override;
    procedure WndProc(var Message: TMessage); virtual;
    function TaskModalDialog(var Info: TBrowseInfo): PItemIDList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property Handle: HWnd read FHandle;
    property DisplayName: AnsiString read FDisplayName;
    property SelectedName: AnsiString read FSelectedName write FSelectedName;
    property ImageIndex: Integer read FImageIndex;
  published
    property BrowseKind: TBrowseKind read FBrowseKind write FBrowseKind default bfFolders;
    property DesktopRoot: Boolean read FDesktopRoot write FDesktopRoot default True;
    property DialogText: AnsiString read FText write FText;
    property FolderName: AnsiString read FFolderName write FFolderName;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property Position: TDialogPosition read FPosition write FPosition default dpScreenCenter;
    property OnInitialized: TNotifyEvent read FOnInitialized write FOnInitialized;
    property OnSelChanged: TNotifyEvent read FOnSelChanged write FOnSelChanged;
  end;

function ExplorerHook(Wnd: HWnd; Msg: UINT; LParam: LPARAM; Data: LPARAM): Integer; stdcall;
begin
  Result := 0;
  if Msg = BFFM_INITIALIZED then begin
    if TBrowseFolderDlg(Data).Position = dpScreenCenter then
      CenterWindow(Wnd);
    TBrowseFolderDlg(Data).FHandle := Wnd;
    TBrowseFolderDlg(Data).FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(TBrowseFolderDlg(Data).FObjectInstance)));
    TBrowseFolderDlg(Data).DoInitialized;
  end
  else if Msg = BFFM_SELCHANGED then begin
    TBrowseFolderDlg(Data).FHandle := Wnd;
    TBrowseFolderDlg(Data).DoSelChanged(PItemIDList(LParam));
  end;
end;

const
  HelpButtonId = $FFFF;

constructor TBrowseFolderDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObjectInstance := MakeObjectInstance(WndProc);
  FDesktopRoot := True;
  FBrowseKind := bfFolders;
  FPosition := dpScreenCenter;
  SetLength(FDisplayName, MAX_PATH);
end;

destructor TBrowseFolderDlg.Destroy;
begin
  if FObjectInstance <> nil then FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

procedure TBrowseFolderDlg.DoInitialized;
const
  SBtn = 'BUTTON';
var
  BtnHandle, HelpBtn, BtnFont: THandle;
  BtnSize: TRect;
begin
  if (FBrowseKind = bfComputers) or DirExists(FFolderName) then
    SetSelPath(FFolderName);
  if FHelpContext <> 0 then begin
    BtnHandle := FindWindowEx(FHandle, 0, SBtn, nil);
    if (BtnHandle <> 0) then begin
      GetWindowRect(BtnHandle, BtnSize);
      ScreenToClient(FHandle, BtnSize.TopLeft);
      ScreenToClient(FHandle, BtnSize.BottomRight);
      BtnFont := SendMessage(FHandle, WM_GETFONT, 0, 0);
      HelpBtn := CreateWindowA(SBtn, PAnsiChar(ResStr(SHelpButton)),
        WS_CHILD or WS_CLIPSIBLINGS or WS_VISIBLE or BS_PUSHBUTTON or WS_TABSTOP,
        12, BtnSize.Top, BtnSize.Right - BtnSize.Left, BtnSize.Bottom - BtnSize.Top,
        FHandle, HelpButtonId, HInstance, nil);
      if BtnFont <> 0 then
        SendMessage(HelpBtn, WM_SETFONT, BtnFont, MakeLParam(1, 0));
      UpdateWindow(FHandle);
    end;
  end;
  if Assigned(FOnInitialized) then FOnInitialized(Self);
end;

const

{ Browsing for directory }

  BIF_RETURNONLYFSDIRS   = $0001; { For finding a folder to start document searching }
  BIF_DONTGOBELOWDOMAIN  = $0002; { For starting the Find Computer }
  BIF_STATUSTEXT         = $0004;
  BIF_RETURNFSANCESTORS  = $0008;

  BIF_BROWSEFORCOMPUTER  = $1000; { Browsing for Computers }
  BIF_BROWSEFORPRINTER   = $2000; { Browsing for Printers }
  BIF_BROWSEINCLUDEFILES = $4000; { Browsing for Everything }

const
  CSIDL_DRIVES             = $0011;
  CSIDL_NETWORK            = $0012;

function SHBrowseForFolder(var lpbi: TBrowseInfo): PItemIDList; stdcall;
  far; external Shell32 name 'SHBrowseForFolder';
function SHGetPathFromIDList(pidl: PItemIDList; pszPath: LPSTR): BOOL; stdcall;
  far; external Shell32 name 'SHGetPathFromIDList';
function SHGetSpecialFolderLocation(hwndOwner: HWND; nFolder: Integer;
  var ppidl: PItemIDList): HResult; stdcall; far; external Shell32
  name 'SHGetSpecialFolderLocation';

procedure TBrowseFolderDlg.DoSelChanged(Param: PItemIDList);
var
  Temp: array[0..MAX_PATH] of AnsiChar;
begin
  if (FBrowseKind = bfComputers) then begin
    FSelectedName := DisplayName;
  end
  else begin
    if SHGetPathFromIDList(Param, Temp) then begin
      FSelectedName := StrPas(Temp);
      SetOkEnable(DirExists(FSelectedName));
    end
    else begin
      FSelectedName := '';
      SetOkEnable(False);
    end;
  end;
  if Assigned(FOnSelChanged) then FOnSelChanged(Self);
end;

procedure TBrowseFolderDlg.SetSelPath(const Path: AnsiString);
begin
  if FHandle <> 0 then
    SendMessage(FHandle, BFFM_SETSELECTION, 1, Longint(PAnsiChar(Path)));
end;

procedure TBrowseFolderDlg.SetOkEnable(Value: Boolean);
begin
  if FHandle <> 0 then SendMessage(FHandle, BFFM_ENABLEOK, 0, Ord(Value));
end;

procedure TBrowseFolderDlg.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TBrowseFolderDlg.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TBrowseFolderDlg.WMCommand(var Message: TMessage);
begin
  if (Message.wParam = HelpButtonId) and (LongRec(Message.lParam).Hi =
    BN_CLICKED) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
  end
  else inherited;
end;

procedure TBrowseFolderDlg.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function RemoveBackSlash(const DirName: AnsiString): AnsiString;
begin
  Result := DirName;
  if (Length(Result) > 1) and
    (AnsiLastChar(Result)^ = '\') then
  begin
    if not ((Length(Result) = 3) and (UpCase(Result[1]) in ['A'..'Z']) and
      (Result[2] = ':')) then
      Delete(Result, Length(Result), 1);
  end;
end;

function TBrowseFolderDlg.Execute: Boolean;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  Temp: array[0..MAX_PATH] of AnsiChar;
begin
  if FDesktopRoot and (FBrowseKind = bfFolders) then
    BrowseInfo.pidlRoot := nil
  else begin
    if FBrowseKind = bfComputers then { root - Network }
      OleCheck(SHGetSpecialFolderLocation(0, CSIDL_NETWORK,
        BrowseInfo.pidlRoot))
    else { root - MyComputer }
      OleCheck(SHGetSpecialFolderLocation(0, CSIDL_DRIVES,
        BrowseInfo.pidlRoot));
  end;
  try
    SetLength(FDisplayName, MAX_PATH);
    with BrowseInfo do begin
      pszDisplayName := PAnsiChar(DisplayName);
      if DialogText <> '' then lpszTitle := PAnsiChar(DialogText)
      else lpszTitle := nil;
      if FBrowseKind = bfComputers then
        ulFlags := BIF_BROWSEFORCOMPUTER
      else
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_RETURNFSANCESTORS;
      lpfn := ExplorerHook;
      lParam := Longint(Self);
      hWndOwner := Application.Handle;
      iImage := 0;
    end;
    ItemIDList := TaskModalDialog(BrowseInfo);
    Result := ItemIDList <> nil;
    if Result then
    try
      if FBrowseKind = bfFolders then begin
        Win32Check(SHGetPathFromIDList(ItemIDList, Temp));
        FFolderName := RemoveBackSlash(StrPas(Temp));
      end
      else begin
        FFolderName := DisplayName;
      end;
      FSelectedName := FFolderName;
      FImageIndex := BrowseInfo.iImage;
    finally
      CoTaskMemFree(ItemIDList);
    end;
  finally
    if BrowseInfo.pidlRoot <> nil then CoTaskMemFree(BrowseInfo.pidlRoot);
  end;
end;

function TBrowseFolderDlg.TaskModalDialog(var Info: TBrowseInfo): PItemIDList;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  try
    try
      Result := SHBrowseForFolder(Info);
    finally
      FHandle := 0;
      FDefWndProc := nil;
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
  end;
end;

function BrowseDirectory(var AFolderName: AnsiString; const DlgText: AnsiString;
  AHelpContext: THelpContext): Boolean;
{$IfDef XE}
var
 l_S : String;
{$EndIf XE}
begin
  if NewStyleControls then begin
    with TBrowseFolderDlg.Create(Application) do
    try
      DialogText := DlgText;
      FolderName := AFolderName;
      HelpContext := AHelpContext;
      Result := Execute;
      if Result then AFolderName := FolderName;
    finally
      Free;
    end;
  end
  else
  begin
   {$IfDef XE}
   l_S := AFolderName;
   Result := SelectDirectory(l_S, [], AHelpContext);
   AFolderName := l_S;
   {$Else  XE}
   Result := SelectDirectory(AFolderName, [], AHelpContext);
   {$EndIf XE}
  end;
end;

end.