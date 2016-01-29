{*********************************************************}
{*                  STSHRTCT.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}
    
{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StShrtCt;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  SysUtils, Windows, Forms, Classes, Controls, Messages, ShlObj,
  {$IFDEF VERSION3} ActiveX, ComObj, {$ELSE} Ole2, {$ENDIF}
  StBase, StShBase, StConst;

{$Z+}
type
  TShowState = (ssNormal, ssMinimized, ssMaximized);

  TStLocationType = (
      ltWorkingDir,    { Shortcut will be created in the working directory.  }
      ltSpecialFolder, { Shortcut will be created in SpecialFolder.          }
      ltDirectory      { Shortcut will be created in the specified directory.}
  );

  TStShortcutEvent = procedure(Sender : TObject;
                                Point : TPoint) of object;

  TStCustomShortcut = class(TStShellComponent)
  protected{private}
    {property variables}
    FAutoName         : Boolean;
    FDescription      : string;
    FDestinationDir   : string;
    FFileName         : string;
    FHotKey           : Word;
    FIconIndex        : Integer;                                       
    FIconPath         : string;                                        
    FLocationType     : TStLocationType;
    FParameters       : string;                                        
    FShortcutFileName : string;
    FShowCommand      : TShowState;
    FSpecialFolder    : TStSpecialRootFolder;
    FStartInDir       : string;

    {internal variables}
    {$IFNDEF VERSION3 }
    Initialized : Boolean;
    {$ENDIF}

    procedure SetSpecialFolder(const Value: TStSpecialRootFolder);
    {event variables}

    procedure MakePath(var Path : string);
    function Save(const AFileName : string) : Boolean;

  protected
{$Z-}
    {properties}
    property AutoName : Boolean
      read FAutoName write FAutoName default True;
    property Description : string
      read FDescription write FDescription;
    property DestinationDir : string
      read FDestinationDir write FDestinationDir;
    property FileName : string
      read FFileName write FFileName;
    property HotKey : Word
      read FHotKey write FHotKey default 0;
    property IconIndex : Integer                                       
      read FIconIndex write FIconIndex;
    property IconPath : string                                         
      read FIconPath write FIconPath;
    property LocationType : TStLocationType
      read FLocationType write FLocationType default ltSpecialFolder;
    property Parameters : string                                       
      read FParameters write FParameters;
    property ShortcutFileName : string
      read FShortcutFileName write FShortcutFileName;
    property ShowCommand : TShowState
      read FShowCommand write FShowCommand default ssNormal;
    property SpecialFolder : TStSpecialRootFolder
      read FSpecialFolder write SetSpecialFolder;
    property StartInDir : string
      read FStartInDir write FStartInDir;

{$Z+}
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    {methods}
{$Z-}
    function  CreateShortcut  : Boolean;
    function  ResolveShortcut : Boolean;
  end;

  TStShortcut = class(TStCustomShortcut)
  published
    {properties}
    property AutoName;
    property Description;
    property DestinationDir;
    property FileName;
    property HotKey;
    property IconIndex;                                                
    property IconPath;                                                 
    property LocationType;
    property Parameters;                                               
    property ShortcutFileName;
    property ShowCommand;
    property SpecialFolder;
    property StartInDir;
  end;

implementation


{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

constructor TStCustomShortcut.Create(AOwner: TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FLocationType  := ltSpecialFolder;
  FSpecialFolder := sfDesktop;
  FAutoName      := True;
  FShowCommand   := ssNormal;
end;

function TStCustomShortcut.CreateShortcut: Boolean;
var
  S   : string;
begin
  if not FileExists(FFileName) then
    RaiseStError(EStShortcutError, stscInvalidTargetFile);
  if (FLocationType = ltDirectory) and (FDestinationDir = '') then
    RaiseStError(EStShortcutError, stscNoPathSpecified);
  MakePath(S);
  if (FLocationType = ltSpecialFolder) and (FSpecialFolder = sfRecentFiles) then begin
    SHAddToRecentDocs(SHARD_PATH, Pointer(PChar(S)));
    Result := True;
    Exit;
  end;
  if FAutoName then begin
    S := S + 'Shortcut to ';
    S := S + ExtractFileName(FFileName) + '.lnk';
  end else
    S := S + FDescription + '.lnk';
  Result := Save(S);
end;

destructor TStCustomShortcut.Destroy;
begin
  {$IFNDEF VERSION3}
  if not (csDesigning in ComponentState) and Initialized then
    CoUninitialize;
  {$ENDIF}
  inherited Destroy;
end;

procedure TStCustomShortcut.MakePath(var Path: string);
var
  IDList : PItemIDList;
  Buff   : array [0..MAX_PATH - 1] of Char;
  ParentHandle : Integer;
begin
  IDList := nil;

  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  case FLocationType of
    ltSpecialFolder :
      SHGetSpecialFolderLocation(ParentHandle,
        ShellFolders[FSpecialFolder], IDList);
    ltWorkingDir :
      begin
        GetModuleFileName(0, Buff, SizeOf(Buff));
        Path := ExtractFilePath(Buff) + '\';
      end;
    ltDirectory :
      begin
        Path := FDestinationDir;
        if FDestinationDir <> '' then
          if FDestinationDir[Length(FDestinationDir)] <> '\' then
            Path := FDestinationDir + '\';
      end;
  end;
  if Assigned(IDList) then begin
    SHGetPathFromIDList(IDList, Buff);
    Path := string(Buff) + '\';
  end;
end;

function TStCustomShortcut.ResolveShortcut: Boolean;
var
  Res   : Integer;
  {$IFDEF VERSION3}
  CO    : IUnknown;
  {$ENDIF}
  Link  : IShellLink;
  PFile : IPersistFile;
  WBuff : array [0..MAX_PATH - 1] of WideChar;
  Buff  : array [0..MAX_PATH - 1] of Char;
  FD    : TWin32FindData;
  Cmd   : Integer;
  ParentHandle : Integer;
begin
  if (FShortcutFileName = '') or not FileExists(FShortcutFileName) then
    RaiseStError(EStShortcutError, stscFileOpen);
  if UpperCase(ExtractFileExt(FShortcutFileName)) <> '.LNK' then
    RaiseStError(EStShortcutError, stscNotShortcut);

  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  { Create an IShellLink interface. }
  {$IFDEF VERSION3}
  CO    := CreateComObject(CLSID_ShellLink);
  Link  := CO as IShellLink;
  PFile := CO as IPersistFile;
  Res   := Integer(PFile);
  {$ELSE}
  if not Initialized then begin
    Res := CoInitialize(nil);
    if Res <> S_OK then
      RaiseStError(EStShortcutError, stscIShellLinkError);
    Initialized := True;
  end;
  Res := CoCreateInstance(CLSID_ShellLink,
    nil, CLSCTX_INPROC_SERVER, IID_IShellLink, Link);
  if Res = S_OK then
    Res := Link.QueryInterface(IID_IPersistFile, PFile);
  if Res <> S_OK then
    RaiseStError(EStShortcutError, stscIShellLinkError);
  {$ENDIF}
  if Assigned(Link) and Assigned(PFile) then begin
    MultiByteToWideChar(CP_ACP, 0,
      PChar(FShortcutFileName), -1, WBuff, MAX_PATH);
    Res := PFile.Load(WBuff, STGM_READ);
    if Res = S_OK then begin
      Res := Link.Resolve(ParentHandle, SLR_ANY_MATCH or SLR_UPDATE);
      if Res = S_OK then begin
        Link.GetPath(Buff, MAX_PATH, FD, SLGP_UNCPRIORITY);
        FFileName := Buff;
        Link.GetDescription(Buff, MAX_PATH);
        FDescription := Buff;
        Link.GetArguments(Buff, MAX_PATH);                             
        FParameters := Buff;                                           
        Link.GetWorkingDirectory(Buff, MAX_PATH);
        FStartInDir := Buff;
        Link.GetHotkey(FHotKey);
        Link.GetShowCmd(Cmd);
        case Cmd of
          SW_SHOWNORMAL    : FShowCommand := ssNormal;
          SW_SHOWMAXIMIZED : FShowCommand := ssMaximized;
          SW_SHOWMINIMIZED : FShowCommand := ssMinimized;
        else FShowCommand := ssNormal;
        end;
      end;
    end;
  end;
  Result := not Boolean(Res);
end;

function TStCustomShortcut.Save(const AFileName : string) : Boolean;
var
  Res   : Integer;
  {$IFDEF VERSION3}
  CO    : IUnknown;
  {$ENDIF}
  Link  : IShellLink;
  PFile : IPersistFile;
  WBuff : array [0..MAX_PATH - 1] of WideChar;
begin
  { Create an IShellLink interface. }
  {$IFDEF VERSION3}
  CO    := CreateComObject(CLSID_ShellLink);
  Link  := CO as IShellLink;
  PFile := CO as IPersistFile;
  Res   := Integer(PFile);
  {$ELSE}
  if not Initialized then begin
    Res := CoInitialize(nil);
    if Res <> S_OK then
      RaiseStError(EStShortcutError, stscIShellLinkError);
    Initialized := True;
  end;
  Res := CoCreateInstance(CLSID_ShellLink,
    nil, CLSCTX_INPROC_SERVER, IID_IShellLink, Link);
  if Res = S_OK then
    Res := Link.QueryInterface(IID_IPersistFile, PFile);
  if Res <> S_OK then
    RaiseStError(EStShortcutError, stscIShellLinkError);
  {$ENDIF}

  if Assigned(Link) and Assigned(PFile) then begin
    Link.SetPath(PChar(FFileName));
    Link.SetArguments(PChar(FParameters));
    Link.SetDescription(PChar(FDescription));
    Link.SetHotkey(FHotKey);
    case FShowCommand of
      ssNormal    : Link.SetShowCmd(SW_SHOWNORMAL);
      ssMaximized : Link.SetShowCmd(SW_SHOWMAXIMIZED);
      ssMinimized : Link.SetShowCmd(SW_SHOWMINIMIZED);
    end;
    if FStartInDir <> '' then
      Link.SetWorkingDirectory(PChar(FStartInDir));
    if FIconPath <> '' then                                            
      Link.SetIconLocation(PChar(FIconPath), FIconIndex);
    MultiByteToWideChar(CP_ACP, 0, PChar(AFileName), -1, WBuff, MAX_PATH);
    Res := PFile.Save(WBuff, False);
    if Res = S_OK then
    {$IFDEF VERSION 3}
      FShortcutFileName := WBuff;
    {$ELSE}
      FShortcutFileName := WideCharToString(WBuff);
    {$ENDIF}
  end else
    RaiseStError(EStShortcutError, stscIShellLinkError);
  Result := not Boolean(Res);
end;

procedure TStCustomShortcut.SetSpecialFolder(
  const Value: TStSpecialRootFolder);
begin
  FSpecialFolder := Value;
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
end;


end.