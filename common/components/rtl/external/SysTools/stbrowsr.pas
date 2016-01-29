{*********************************************************}
{*                  STBROWSR.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StBrowsr;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  Windows, Forms, Classes, Controls, Messages, ShellApi, ShlObj,
  {$IFDEF VERSION3} ActiveX, ComObj, {$ELSE} Ole2, {$ENDIF}
  StBase, StShBase, StConst, StVInfo;

{$Z+}
type
  TStBrowseOptions = (boBrowseForComputer, boBrowseForPrinter,
                      boDontGoBelowDomain, boReturnOnlyAncestors,
                      boReturnOnlyDirs, boShowFiles, boEditBox);

  TStBrowseOptionsSet = set of TStBrowseOptions;

  TStBrowsePosition = (bpDefault, bpScreenCenter);

type
  TStCustomBrowser = class(TStShellComponent)
  protected {private}
    FAdditionalText      : string;
    FCaption             : string;
    FDisplayName         : string;
    FHandle              : Integer;
    FIDList              : PItemIDList;
    FImageIndex          : Integer;
    FOKEnabled           : Boolean;
    FOptions             : TStBrowseOptionsSet;
    FPath                : string;
    FPosition            : TStBrowsePosition;
    FRootFolder          : string;
    FSelectedFolder      : string;
    FSpecialRootFolder   : TStSpecialRootFolder;
    FSpecialRootFolderID : Integer;
    FStatusText          : string;

    FOnShow              : TNotifyEvent;
    FOnSelChanged        : TNotifyEvent;

    procedure SetOKEnabled(Value : Boolean);
    procedure SetSpecialRootFolder(Value : TStSpecialRootFolder);
    procedure SetStatusText(const Value : string);
    procedure SetSelectedFolder(const Value : string);

    procedure FreeIDList;
    function  GetPathFromIDList : string;

  protected

    procedure DoShow;
    procedure DoSelChanged;

{$Z-}
    {properties}
    property AdditionalText : string
      read FAdditionalText
      write FAdditionalText;

    property Caption : string
      read FCaption
      write FCaption;

    property DisplayName : string
      read FDisplayName;

    property Handle : Integer
      read FHandle;

    property IDList : PItemIDList
      read FIDList;

    property ImageIndex : Integer
      read FImageIndex;

    property OKEnabled : Boolean
      read FOKEnabled
      write SetOKEnabled;

    property Options : TStBrowseOptionsSet
      read FOptions
      write FOptions
      default [boReturnOnlyDirs];

    property Path : string
      read FPath;

    property Position : TStBrowsePosition
      read FPosition
      write FPosition
      default bpScreenCenter;

    property RootFolder : string
      read FRootFolder
      write FRootFolder;

    property SelectedFolder : string
      read FSelectedFolder
      write SetSelectedFolder;

    property SpecialRootFolder : TStSpecialRootFolder
      read FSpecialRootFolder
      write SetSpecialRootFolder
      default sfDesktop;

    property SpecialRootFolderID : Integer
      read FSpecialRootFolderID
      write FSpecialRootFolderID
      default 0;

    property StatusText : string
      read FStatusText
      write SetStatusText;

    {events}
    property OnShow : TNotifyEvent
      read FOnShow
      write FOnShow;

    property OnSelChanged : TNotifyEvent
      read FOnSelChanged
      write FOnSelChanged;

  public
    { Public declarations }
{$Z+}
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
{$Z-}
    function Execute : Boolean;
  end;

  TStBrowser = class(TStCustomBrowser)
  public
    {properties}
    property DisplayName;
    property Handle;
    property IDList;
    property ImageIndex;
    property OKEnabled;
    property Path;
    property ShellVersion;

  published
    {properties}
    property AdditionalText;
    property Caption;
    property Options;
    property Position;
    property RootFolder;
    property SelectedFolder;
    property SpecialRootFolder;
    property SpecialRootFolderID;
    property StatusText;
    property Version;

    {events}
    property OnShow;
    property OnSelChanged;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  SysUtils,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

{ The BrowseCallbackProc. This function is called at various times }
{ when the Browse For Folder dialog is being used. }
function BrowseCallbackProc(hWnd : HWND; Msg : UINT; lParam : LPARAM;
                            Data : LPARAM): Integer; stdcall;
var
  X, Y : Integer;
  R    : TRect;
begin
  Result := 0;
  with TStCustomBrowser(Data) do begin
    case Msg of
      { The dialog has been initialized. }
      BFFM_INITIALIZED :
        begin
          FHandle := hWnd;
          if FCaption <> '' then
            SendMessage(hWnd, WM_SETTEXT, 0, Integer(PChar(FCaption)));
          SendMessage(hWnd, BFFM_SETSELECTION,
                      1, Integer(PChar(SelectedFolder)));
          if StatusText <> '' then
            SendMessage(hWnd, BFFM_SETSTATUSTEXT,
                        0, Integer(PChar(StatusText)));
          if FPosition = bpScreenCenter then begin
            GetWindowRect(hWnd, R);
            X := (Screen.Width div 2) - ((R.Right - R.Left) div 2);
            Y := (Screen.Height div 2) - ((R.Bottom - R.Top) div 2);
            SetWindowPos(hWnd, 0, X, Y, 0, 0, SWP_NOSIZE or SWP_NOZORDER);
          end;
          DoShow;
        end;
      { The currently selected item in the dialog has changed. }
      BFFM_SELCHANGED :
        if FHandle <> 0 then begin
          FIDList := PItemIDList(lParam);
          SelectedFolder := GetPathFromIDList;
          DoSelChanged;
        end;
    end;
  end;
end;

constructor TStCustomBrowser.Create(AOwner : TComponent);
var
  VI     : TStVersionInfo;
  WinDir : array [0..MAX_PATH - 1] of Char;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FOptions             := [boReturnOnlyDirs];
  FSpecialRootFolder   := sfNone;
  FSpecialRootFolderID := 0;
  FPosition            := bpScreenCenter;
  VI := TStVersionInfo.Create(AOwner);
  try
    GetSystemDirectory(WinDir, MAX_PATH);
    VI.FileName := WinDir + '\shell32.dll';
    FShellVersion := VI.FileVersionFloat;
  finally
    VI.Free;
  end;
end;

destructor TStCustomBrowser.Destroy;
begin
  inherited Destroy;
  if FIDList <> nil then
    FreeIDList;
end;

procedure TStCustomBrowser.DoShow;
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TStCustomBrowser.DoSelChanged;
begin
  if Assigned(FOnSelChanged) then
    FOnSelChanged(Self);
end;

function TStCustomBrowser.Execute : Boolean;
var
  ParentHandle : HWND;
  BrowseInfo   : TBrowseInfo;
  RootDir      : PItemIDList;
  {$IFDEF VERSION4}
  Eaten        : Cardinal;
  Attr         : Cardinal;
  {$ELSE}
  {$IFDEF CBuilder}
  Eaten        : Cardinal;
  Attr         : Cardinal;
  {$ELSE}
  Eaten        : LongInt;
  Attr         : LongInt;
  {$ENDIF}
  {$ENDIF}
  DispName     : array [0..MAX_PATH - 1] of WideChar;
  Folder       : IShellFolder;
  DisplayName  : array[0..MAX_PATH-1] of AnsiChar;
  Flags        : Word;
begin

  Result := False;

  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  if ((boShowFiles in FOptions) or (boEditBox in FOptions)) and
     (ShellVersion < 4.7) then
    RaiseStError(EStShellError, stscShellVersionError);

  Flags := 0;
  if boBrowseForComputer in FOptions then
    Flags := Flags or BIF_BROWSEFORCOMPUTER;
  if boBrowseForPrinter in FOptions then
    Flags := Flags or BIF_BROWSEFORPRINTER;
  if boDontGoBelowDomain in FOptions then
    Flags := Flags or BIF_DONTGOBELOWDOMAIN;
  if boReturnOnlyAncestors in FOptions then
    Flags := Flags or BIF_RETURNFSANCESTORS;
  if boReturnOnlyDirs in FOptions then
    Flags := Flags or BIF_RETURNONLYFSDIRS;
  if boShowFiles in FOptions then
    Flags := Flags or BIF_BROWSEINCLUDEFILES;
  if boEditBox in FOptions then
    Flags := Flags or BIF_EDITBOX;
  if Length(StatusText) <> 0 then
    Flags := Flags or BIF_STATUSTEXT;

  if (FRootFolder <> '') and (FSpecialRootFolder = sfNone) then begin
    SHGetDesktopFolder(Folder);
    StringToWideChar(FRootFolder, DispName, MAX_PATH);
    Folder.ParseDisplayName(ParentHandle, nil,
                            DispName,
                            Eaten,
                            RootDir,
                            Attr);
  end else if FSpecialRootFolder <> sfNone then
    SHGetSpecialFolderLocation(ParentHandle, FSpecialRootFolderID, RootDir)
  else
    RootDir := nil;

  if FIDList <> nil then
    FreeIDList;

  with BrowseInfo do begin
    hwndOwner := ParentHandle;
    pidlRoot := RootDir;
    pszDisplayName := DisplayName;
    lpszTitle := PChar(FAdditionalText);
    ulFlags := Flags;
    lpfn := Pointer(@BrowseCallbackProc);                              {!!.01}
    lParam := Integer(Self);
    iImage := 0;
  end;
  FIDList := SHBrowseForFolder(BrowseInfo);

  FHandle := 0;

  if FIDList <> nil then begin
    FPath  := GetPathFromIDList;
    FDisplayName := BrowseInfo.pszDisplayName;
    FImageIndex := BrowseInfo.iImage;
    Result := True;
  end else begin
    FDisplayName := '';
    FImageIndex := 0;
  end;
end;

procedure TStCustomBrowser.FreeIDList;
var
  Malloc : IMalloc;
begin
  if coGetMalloc(MEMCTX_TASK, Malloc) = NOERROR then begin
    Malloc.Free(FIDList);
    FIDList := nil;
  end;
end;

function TStCustomBrowser.GetPathFromIDList : string;
var
  Buf    : array[0..MAX_PATH-1] of Char;
  Res : Boolean;
begin
  Result := '';
  if IDList <> nil then begin
    Res := SHGetPathFromIDList(IDList, Buf);
    if Res then
      Result := Buf
    else
      Exit;
  end;
end;

procedure TStCustomBrowser.SetOKEnabled(Value : Boolean);
begin
  FOKEnabled := Value;
  if FHandle <> 0 then
    PostMessage(Handle, BFFM_ENABLEOK, 0, lParam(FOKEnabled));
end;

procedure TStCustomBrowser.SetSpecialRootFolder(Value : TStSpecialRootFolder);
begin
  if not (csDesigning in ComponentState) then
    if ((ShellFolders[Value] = CSIDL_INTERNET) or
       (ShellFolders[Value] = CSIDL_ALTSTARTUP) or
       (ShellFolders[Value] = CSIDL_COMMON_ALTSTARTUP) or
       (ShellFolders[Value] = CSIDL_COMMON_FAVORITES) or
       (ShellFolders[Value] = CSIDL_INTERNET_CACHE) or
       (ShellFolders[Value] = CSIDL_COOKIES) or
       (ShellFolders[Value] = CSIDL_HISTORY)) and
       (ShellVersion < 4.7) then
      RaiseStError(EStShellError, stscShellVersionError);
  FSpecialRootFolder   := Value;
  FSpecialRootFolderID := ShellFolders[Value];
end;

procedure TStCustomBrowser.SetStatusText(const Value : string);
begin
  FStatusText := Value;
  if FHandle <> 0 then
    PostMessage(FHandle, BFFM_SETSTATUSTEXT, 0, lParam(PChar(Value)));
end;

procedure TStCustomBrowser.SetSelectedFolder(const Value : string);
begin
  { Trim off a trailing backslash if it is present, but }
  { only if SelectedFolder is not a root directory.     }
  { SHBrowseForFolder won't start with the selected     }
  { folder if the backslash is present. }
  FSelectedFolder := Value;
  if FSelectedFolder <> '' then
    if FSelectedFolder[Length(FSelectedFolder)] = '\' then
      Delete(FSelectedFolder, Length(FSelectedFolder), 1);
  { Add the backslash back on if SelectedFolder is a    }
  { root directory (ala 'c:'). }
  if (Length(FSelectedFolder) = 2) then
    FSelectedFolder := FSelectedFolder + '\';
end;

end.