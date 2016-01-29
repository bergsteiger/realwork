{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxWDialogs;

{$I adxDefs.inc}

interface

uses
  ImgList, ShlObj, Windows, Messages, SysUtils, Dialogs, Forms,
  Classes, Controls, ActiveX, Graphics, {$IFNDEF ADX_VCL14} FileCtrl, {$ENDIF}
  StdCtrls, ExtCtrls;

type
  TaxpwCustomDlg = class(TComponent)
  private
    FCaption: string;
    FIcon: TIcon;
    FImageList: TImageList;
    FImageIndex: TImageIndex;
    FText: string;
    procedure UpdateIcon;
  protected
    function GetOwnerHandle: THandle;
    // Properties Get/Set
    procedure SetIcon(const A: TIcon); virtual;
    procedure SetImageList(const A: TImageList); virtual;
    procedure SetImageIndex(A: TImageIndex); virtual;
    // Properties
    property Caption: string read FCaption write FCaption;
    property Icon: TIcon read FIcon write SetIcon;
    property ImageList: TImageList read FImageList write SetImageList;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex
      default 0;
    property Text: string read FText write FText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; virtual;
  end;

{ TaxpwBrowseFolderDlg }

  EaxpwBrowseFolderDlg = class(Exception);
  TaxpwBrowseFolderDlg = class;

  TaxpwBrowseFolderDlgRootDir = (sdrNone, sdrRecycleBin, sdrControlPanel,
    sdrDesktop, sdrDesktopDir, sdrDrives, sdrFonts, sdrNetHood, sdrNetwork,
    sdrPersonal, sdrPrinters, sdrPrograms, sdrRecent, sdrSendTo, sdrStartMenu,
    sdrStartUp, sdrTemplates, sdrDesktopExpanded);

  TaxpwBrowseFolderDlgOption = (sdoComputers, sdoPrinters, sdoOnlyDomains,
    sdoReturnAncest, sdoOnlyDirs, sdoShowStatus, sdoIncludeFiles,
    sdoIncludeUrls, sdoShowEditBox, sdoNewDialogStyle, sdoShareable);
  TaxpwBrowseFolderDlgOptions = set of TaxpwBrowseFolderDlgOption;

  TaxpwBFDlgInitEvent = procedure(Sender: TaxpwBrowseFolderDlg;
    DialogHandle: THandle) of object;

  TaxpwBrowseFolderDlg = class(TaxpwCustomDlg)
  private
    FRestart: Boolean; // Used to prevent dialog closing when new folder were created
    FCreateButtonVisible: Boolean;
    FCreateButtonEnabled: Boolean;
    FOptions: TaxpwBrowseFolderDlgOptions;
    FOwnerHandle: THandle;
    FRootDir: TaxpwBrowseFolderDlgRootDir;
    FPosition: TRect; // Used for saving and restoring a position of dialog.
    FStatusTextAsPath: Boolean;
    FStatusText: string;
    function GetOptions: Integer;
    function GetRootID: PItemIDList;
    procedure ResetPosition;
    procedure SavePosition;
    procedure UpdatePosition;
    function OldStyleDialog: Boolean;
    { Properties Get/Set }
    procedure SetCreateButtonEnabled(A: Boolean);
    procedure SetCreateButtonVisible(A: Boolean);
    function GetItem: string;
    procedure SetItem(const A: string);
    procedure SetSelectedFolder(const A: string);
    procedure SetStatusText(const A: string);
    function IsStatusTextStored: Boolean;
  protected
    FHandle: THandle;
    FDisplayName, FFolder, FSelectedFolder: string;
    FValidPath: Boolean;
    FTreeViewHandle, FBtnOKHandle, FBtnCancelHandle, FBtnCreateHandle: THandle;
    procedure Loaded; override;
    procedure ResetHandles; virtual;
    procedure CreateCreateButton; virtual;
    procedure DestroyCreateButton; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    // Properties
    property DisplayName: string read FDisplayName;
    property Handle: THandle read FHandle;
    {$WARNINGS OFF}
    property ImageIndex: TImageIndex read FImageIndex;
    {$WARNINGS ON}
    property OwnerHandle: THandle read FOwnerHandle write FOwnerHandle;
    property SelectedFolder: string read FSelectedFolder write SetSelectedFolder;
    // for backward capability
    property Item: string read GetItem write SetItem stored False;
  published
    // Properties
    property Caption;
    property CreateButtonVisible: Boolean read FCreateButtonVisible
      write SetCreateButtonVisible default True;
    property CreateButtonEnabled: Boolean read FCreateButtonEnabled
      write SetCreateButtonEnabled default True;
    property Folder: string read FFolder write FFolder;
    property Options: TaxpwBrowseFolderDlgOptions read FOptions write FOptions
      default [sdoOnlyDirs, sdoShowStatus, sdoNewDialogStyle];
    property RootDir: TaxpwBrowseFolderDlgRootDir read FRootDir write FRootDir
      default sdrNone;
    property Text;
    property StatusText: string read FStatusText write SetStatusText
      stored IsStatusTextStored;
    property StatusTextAsPath: Boolean read FStatusTextAsPath
      write FStatusTextAsPath default True;
  end;


implementation

var
  _ShellVersion: Integer = 0;

function axpwGetShellVersion: Integer;
const
  SShellFileName = 'shell32.dll';
var
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  if _ShellVersion = 0 then
  begin
    InfoSize := GetFileVersionInfoSize(SShellFileName, Wnd);
    if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(SShellFileName, Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            _ShellVersion := FI.dwFileVersionMS;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
  Result := _ShellVersion;
end;

function axpwGetWorkAreaRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

Type
  TaxpwHorzAlign = (haLeft, haCenter, haRight);
  TaxpwVertAlign = (vaTop, vaCenter, vaBottom);

function axpwAlignRectInRect(const InnerRect, OuterRect: TRect;
  HorzAlign: TaxpwHorzAlign; VertAlign: TaxpwVertAlign): TRect;
var
  InnerWidth, InnerHeight: Integer;
begin
  InnerWidth  := InnerRect.Right - InnerRect.Left;
  InnerHeight := InnerRect.Bottom - InnerRect.Top;
  case HorzAlign of
    haLeft  : Result.Left := OuterRect.Left;
    haCenter: Result.Left := OuterRect.Left +
      (OuterRect.Right - OuterRect.Left - InnerHeight) div 2;
    haRight : Result.Left := (OuterRect.Right - OuterRect.Left) - InnerHeight;
  end;
  case VertAlign of
    vaTop   : Result.Top := OuterRect.Top;
    vaCenter: Result.Top := OuterRect.Top +
      (OuterRect.Bottom - OuterRect.Top - InnerHeight) div 2;
    vaBottom: Result.Top := (OuterRect.Bottom - OuterRect.Top) - InnerHeight;
  end;
  Result.Right  := Result.Left + InnerWidth;
  Result.Bottom := Result.Top + InnerHeight;
end;

{ TaxpwCustomDlg }

constructor TaxpwCustomDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIcon := TIcon.Create;
  FImageIndex := 0;
end;

destructor TaxpwCustomDlg.Destroy;
begin
  FIcon.Free;
  inherited Destroy;
end;

function TaxpwCustomDlg.Execute: Boolean;
begin
  Result := True;
end;

function TaxpwCustomDlg.GetOwnerHandle: THandle;
begin
  Result := 0;
  if Assigned(Owner) then
  begin
    if (Owner is TWinControl) then Result := TWinControl(Owner).Handle else
    if (Owner is TApplication) then Result := TApplication(Owner).Handle;
  end;
end;

procedure TaxpwCustomDlg.SetIcon(const A: TIcon);
begin
  FIcon.Assign(A);
end;

procedure TaxpwCustomDlg.SetImageList(const A: TImageList);
begin
  FImageList := A;
  UpdateIcon;
end;

procedure TaxpwCustomDlg.SetImageIndex(A: TImageIndex);
begin
  if FImageIndex = A then Exit;
  FImageIndex := A;
  UpdateIcon;
end;

procedure TaxpwCustomDlg.UpdateIcon;
begin
  if not Assigned(FImageList) then Exit;
  FIcon.Assign(nil);
  FImageList.GetIcon(FImageIndex, FIcon);
end;

{ TaxpwBrowseFolderDlg }

const
  BIF_BROWSEINCLUDEURLS  = $0080;
  BIF_BROWSEINCLUDEFILES = $4000;
  BIF_NEWDIALOGSTYLE     = $0040;
  BIF_SHAREABLE          = $8000;

const
  CaxpwSelectDirDlgCSIDL: array[TaxpwBrowseFolderDlgRootDir] of Integer = (
    0, CSIDL_BITBUCKET, CSIDL_CONTROLS, CSIDL_DESKTOP, CSIDL_DESKTOPDIRECTORY,
    CSIDL_DRIVES, CSIDL_FONTS, CSIDL_NETHOOD, CSIDL_NETWORK, CSIDL_PERSONAL,
    CSIDL_PRINTERS, CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU,
    CSIDL_STARTUP, CSIDL_TEMPLATES, -1);
  CaxpwSelectDirDlgBIF: array[TaxpwBrowseFolderDlgOption] of Integer = (
    BIF_BROWSEFORCOMPUTER, BIF_BROWSEFORPRINTER, BIF_DONTGOBELOWDOMAIN,
    BIF_RETURNFSANCESTORS, BIF_RETURNONLYFSDIRS, BIF_STATUSTEXT,
    BIF_BROWSEINCLUDEFILES, BIF_BROWSEINCLUDEURLS, BIF_EDITBOX,
    BIF_NEWDIALOGSTYLE, BIF_SHAREABLE);

  BTN_CREATE_ID = 255;
  cMaxPathDisplayLength = 50;

//------------------------------------------------------------------------------

function _CreateButtonWndProc(Wnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; stdcall;
var
  Dialog: TaxpwBrowseFolderDlg;
        S: string;
begin
        if (Msg = WM_COMMAND) and (Lo(wParam) = BTN_CREATE_ID) then
        begin
        Dialog := TaxpwBrowseFolderDlg(GetWindowLong(Wnd, GWL_USERDATA));
    S := '';
    if InputQuery('Create Folder',
      'Folder Name', S) then
    begin
      if S <> '' then
      begin
        Dialog.FRestart := True;
        Dialog.SavePosition;
        if Dialog.SelectedFolder[Length(Dialog.SelectedFolder)] <> '\' then
          Dialog.FSelectedFolder := Dialog.SelectedFolder + '\' + S
        else
          Dialog.FSelectedFolder := Dialog.SelectedFolder + S;
        ForceDirectories(Dialog.SelectedFolder);
      // Click button to select
        SendMessage(Dialog.FBtnOkHandle, BM_CLICK, 0, 0);
      end;
    end;
                Result := 0;
        end else
    Result := DefDlgProc(Wnd, Msg, wParam, lParam);
end;{function _CreateButtonWndProc}

//------------------------------------------------------------------------------

function _BrowseFolderDlgCallBack(Wnd: HWND; Msg: UINT; Param,
  Data: LPARAM):Integer; stdcall;
var
  Dialog: TaxpwBrowseFolderDlg;

  //-------------------------------------

  function _EnumChildProc(ChildWnd: HWND; EnumParam: LPARAM): Boolean; stdcall;
  var
    ClsName: array[0..255] of Char;
  begin
    with TaxpwBrowseFolderDlg(EnumParam) do
    begin
      {$IFDEF UNICODE}
      GetClassName(ChildWnd, ClsName, Length(ClsName));
      {$ELSE}
      GetClassName(ChildWnd, ClsName, SizeOf(ClsName));
      {$ENDIF}
      if StrIComp(ClsName, 'SYSTREEVIEW32') = 0 then
        FTreeViewHandle := ChildWnd
      else
      if StrIComp(ClsName, 'BUTTON') = 0 then
        if FBtnOKHandle = INVALID_HANDLE_VALUE then FBtnOKHandle := ChildWnd else
        if FBtnCancelHandle = INVALID_HANDLE_VALUE then FBtnCancelHandle := ChildWnd
    end;
    Result := True;
  end;{Internal function _EnumChildProc}

  //-------------------------------------

  procedure _CheckIsFolderValid;
  begin
    with Dialog do
    begin
      FValidPath := DirectoryExists(SelectedFolder);
      if (sdoReturnAncest in Options) then
        EnableWindow(FBtnOkHandle, FValidPath)
      else
        EnableWindow(FBtnOkHandle, True);
      if IsWindow(FBtnCreateHandle) then
        EnableWindow(FBtnCreateHandle, FValidPath and CreateButtonEnabled);
    end;
  end;{Internal _CheckIsFolderValid}

  //-------------------------------------

var
        TempPath: array[0..MAX_PATH] of Char;
        Path: string;
        SHFolder: IShellFolder;
  Display: TStrRet;
begin
  Result := 0;
  Dialog := TaxpwBrowseFolderDlg(Data);
  with Dialog do
    case Msg of

      BFFM_INITIALIZED:
        begin
          FHandle := Wnd;
          UpdatePosition;

        // Change caption and status text if specified
          if Caption <> '' then SetWindowText(Handle, PChar(Caption));
          StatusText := StatusText;

        // Create "CreateButton" id needed
          if OldStyleDialog then
          begin
                        SetWindowLong(Handle, GWL_USERDATA, Data);
            EnumChildWindows(Handle, @_EnumChildProc, Data);
            CreateCreateButton;
                SetWindowLong(Handle, GWL_WNDPROC, LongInt(@_CreateButtonWndProc));
          end;

        // Set selection
        if DirectoryExists(Folder) then SelectedFolder := Folder;

        // Check the path and enable/disable buttons
          _CheckIsFolderValid;

        end;

      BFFM_SELCHANGED:
        begin

        // Update Item property
          SHGetPathFromIDList(PItemIDList(Param), TempPath);
          FSelectedFolder := StrPas(TempPath);

        // Update staus text, set current path if path should be shown
          if StatusTextAsPath then
          begin
            Path := FSelectedFolder;
            if Path = '' then
              if SHGetDeskTopFolder(SHFolder) = NOERROR then
              begin
                SHFolder.GetDisplayNameOf(PItemIDList(Param), SHGDN_FORPARSING, Display);
                {$IFDEF UNICODE}
                if Display.uType = STRRET_CSTR then Path := string(Display.cStr);
                {$ELSE}
                if Display.uType = STRRET_CSTR then Path := StrPas(Display.cStr);
                {$ENDIF}
              end;
            StatusText := Path;
          end else
            StatusText := StatusText;

        // Check the path and enable/disable buttons
          _CheckIsFolderValid;

        end;{case of BFFM_SELCHANGED}

    end;{case Msg of}
end;{function _BrowseFolderDlgCallBack}

//------------------------------------------------------------------------------

constructor TaxpwBrowseFolderDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetLength(FDisplayName, MAX_PATH);
  SetLength(FFolder, MAX_PATH);
  FFolder := '';
  FCreateButtonVisible := True;
  FCreateButtonEnabled := True;
  FStatusTextAsPath := True;
  Options := [sdoOnlyDirs, sdoShowStatus, sdoNewDialogStyle];
  RootDir := sdrNone;
  ResetPosition;
  ResetHandles;
end;

//------------------------------------------------------------------------------

function TaxpwBrowseFolderDlg.Execute: Boolean;
var
  iList: PItemIDList;
  BrowseInfo: TBrowseInfo;
  TempPath: array[0..MAX_PATH] of Char;

  //-------------------------------------

  procedure _InitBrowseInfo;
  var
    S: string;
  begin
    S := Text;
    FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
    with BrowseInfo do
    begin
      pszDisplayName := PChar(FDisplayName);
      lpszTitle := PChar(S);
      ulFlags := GetOptions;
      lpfn := @_BrowseFolderDlgCallBack;
      lParam := Integer(Self);
      if IsWindow(OwnerHandle) then
        hwndOwner := OwnerHandle
      else
        hwndOwner := GetOwnerHandle;
      pidlRoot := GetRootID;
    end;
  end;{Internal procedure _InitBrowseInfo}

  //-------------------------------------

begin
  Result := False;

  if axpwGetShellVersion < $00040000 then
    raise EaxpwBrowseFolderDlg.
      Create('Shell of current version is not compatible with BrowseForFolder');

        iList := nil;
        try
    _InitBrowseInfo;

  // Start dialog "loop"
                FSelectedFolder := FFolder;
                repeat
                        FRestart := False;
                        FFolder := FSelectedFolder;
      try
          iList := SHBrowseForFolder(BrowseInfo);
      finally
        DestroyCreateButton; // Destroy a "Create button"
        ResetHandles; // Reset all handles to prevent wrong window catching
      end;
      if FRestart and not (csDesigning in ComponentState) then
                until not FRestart;

  // Analyse the result
    if iList <> nil then
    begin
      Result := True;
      SHGetPathFromIDList(iList, TempPath);
      FFolder := StrPas(TempPath);
      FSelectedFolder := FFolder;
                        FImageIndex := BrowseInfo.iImage;
    end;

        finally
    ResetPosition; // Drop saved position
                CoTaskMemFree(iList);
                CoTaskMemFree(BrowseInfo.pidlRoot);
        end;
end;{function TaxpwBrowseFolderDlg.Execute}

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.Loaded;
begin
  inherited Loaded;
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.ResetHandles;
begin
  FHandle          := INVALID_HANDLE_VALUE;
  FTreeViewHandle  := INVALID_HANDLE_VALUE;
  FBtnOKHandle     := INVALID_HANDLE_VALUE;
  FBtnCancelHandle := INVALID_HANDLE_VALUE;
  FBtnCreateHandle := INVALID_HANDLE_VALUE;
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.CreateCreateButton;
var
  Left, hFont: Integer;
  R: TRect;
begin
// Check is the button can be created
  if not (IsWindow(Handle) and IsWindow(FTreeViewHandle) and
    IsWindow(FBtnOKHandle)) then Exit;

// Check is button needed or already exists
  if (not OldStyleDialog) or IsWindow(FBtnCreateHandle) then Exit;

// Get left side of TreeView
  GetWindowRect(FTreeViewHandle, R);
  Left := R.Left;

// Get rect of OK button and move it to the left side of the TreeView
  GetWindowRect(FBtnOKHandle, R);
  OffsetRect(R, -(R.Left - Left), 0);
  ScreenToClient(Handle, R.TopLeft);
  ScreenToClient(Handle, R.BottomRight);

// Create button
  with R do
    FBtnCreateHandle := CreateWindow('BUTTON',
      PChar('Create...'), WS_CHILD or
      WS_CLIPSIBLINGS or WS_VISIBLE or WS_TABSTOP or BS_PUSHBUTTON, Left, Top,
      Right - Left, Bottom - Top, Handle, BTN_CREATE_ID, HInstance, nil);

// Apply OK button font to new button
  hFont := SendMessage(FBtnOKHandle, WM_GETFONT, 0, 0);
  SendMessage(FBtnCreateHandle, WM_SETFONT, hFont, 0);

// Update Enabled and Visible states
  CreateButtonEnabled := CreateButtonEnabled;
  CreateButtonVisible := CreateButtonVisible;

// Change Z-Order of controls inside the dialog
  SetWindowPos(FBtnOkHandle, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOACTIVATE or
    SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(FBtnCancelHandle, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOACTIVATE or
    SWP_NOSIZE or SWP_NOMOVE);
end;{procedure TaxpwBrowseFolderDlg.CreateCreateButton}

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.DestroyCreateButton;
begin
  if IsWindow(FBtnCreateHandle) then DestroyWindow(FBtnCreateHandle);
  FBtnCreateHandle := INVALID_HANDLE_VALUE;
end;

//------------------------------------------------------------------------------

function TaxpwBrowseFolderDlg.GetOptions: Integer;
var
  Opt: TaxpwBrowseFolderDlgOption;
  ShellVersion: Integer;
begin
  Result := 0;
  ShellVersion := axpwGetShellVersion;
  for Opt := Low(Opt) to High(Opt) do
    if Opt in Options then
    begin
    // Skip unsupported options
      if (ShellVersion < $00040071) and
        (Opt in [sdoShowEditBox, sdoIncludeFiles]) then Continue;
      if (ShellVersion < $00050000) and
        (Opt in [sdoIncludeUrls, sdoNewDialogStyle, sdoShareable]) then Continue;
    // Add option flag
      Result := Result or CaxpwSelectDirDlgBIF[Opt];
    end;
end;

//------------------------------------------------------------------------------

function TaxpwBrowseFolderDlg.GetRootID: PItemIDList;
begin
  Result := nil;
  if FRootDir = sdrDesktopExpanded then Exit;
  SHGetSpecialFolderLocation(Application.Handle,
    CaxpwSelectDirDlgCSIDL[FRootDir], Result);
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.ResetPosition;
begin
  FillChar(FPosition, SizeOf(FPosition), 0);
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.SavePosition;
begin
  if IsWindow(Handle) then GetWindowRect(Handle, FPosition);
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.UpdatePosition;
var
  R: TRect;
begin
  if not IsWindow(Handle) then Exit;
  with FPosition do
    if (Top = 0) and (Left = 0) and (Right = 0) and (Bottom = 0) then
    begin
    // If poosition is empty, center the dialog.
      GetWindowRect(Handle, R);
      R := axpwAlignRectInRect(R, axpwGetWorkAreaRect, haCenter, vaCenter);
    end else
      R := FPosition;
// Set new position only for dilog of old style
  if OldStyleDialog then
    SetWindowPos(Handle, 0, R.Left, R.Top, 0, 0, SWP_NOACTIVATE or
      SWP_NOSIZE or SWP_NOZORDER);
end;

//------------------------------------------------------------------------------

function TaxpwBrowseFolderDlg.OldStyleDialog: Boolean;
begin
  Result := not ((axpwGetShellVersion >= $00050000) and
    (sdoNewDialogStyle in Options));
end;

//==============================================================================
//  Properties Get/Set

procedure TaxpwBrowseFolderDlg.SetCreateButtonEnabled(A: Boolean);
begin
  FCreateButtonEnabled := A;
  if IsWindow(FBtnCreateHandle) then
    EnableWindow(FBtnCreateHandle, CreateButtonEnabled);
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.SetCreateButtonVisible(A: Boolean);
const
  cFlags: array[Boolean] of DWORD = (SW_HIDE, SW_SHOW);
begin
  FCreateButtonVisible := A;
  if IsWindow(FBtnCreateHandle) then
    ShowWindow(FBtnCreateHandle, cFlags[CreateButtonVisible]);
end;

//------------------------------------------------------------------------------
// For backward capability

function TaxpwBrowseFolderDlg.GetItem: string;
begin
  Result := Folder;
end;

//------------------------------------------------------------------------------
// For backward capability

procedure TaxpwBrowseFolderDlg.SetItem(const A: string);
begin
  Folder := A;
end;

//------------------------------------------------------------------------------

procedure TaxpwBrowseFolderDlg.SetSelectedFolder(const A: string);
begin
  if IsWindow(Handle) then
    SendMessage(Handle, BFFM_SETSELECTION, Integer(LongBool(True)),
      LongInt(PChar(A)));
end;

procedure TaxpwBrowseFolderDlg.SetStatusText(const A: string);
begin
  FStatusText := A;
  if IsWindow(Handle) then
    SendMessage(Handle, BFFM_SETSTATUSTEXT, 0, LongInt(PChar(FStatusText)));
end;

function TaxpwBrowseFolderDlg.IsStatusTextStored: Boolean;
begin
  Result := not StatusTextAsPath;
end;

end.
