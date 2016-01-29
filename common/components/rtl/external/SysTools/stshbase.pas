{*********************************************************}
{*                  STSHBASE.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StShBase;
  {-Base unit for SysTools shell components }

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  Windows, Classes, SysUtils, FileCtrl, ShellApi, ShlObj,
  {$IFDEF VERSION3}
  ActiveX,
  ComObj,
  {$ELSE}
  Ole2,
  {$ENDIF}
  StUtils,
  StSrMgr,
  StConst,
  StBase,
  StVInfo, Dialogs;

{$Z+}
type
  TStSpecialRootFolder = (sfAltStartup, sfAppData, sfBitBucket, sfCommonAltStartup,
                    sfCommonDesktopDir, sfCommonFavorites, sfCommonPrograms,
                    sfCommonStartMenu, sfCommonStartup, sfControls, sfCookies,
                    sfDesktop, sfDesktopDir, sfDrives, sfFavorites, sfFonts,
                    sfHistory, sfInternet, sfInternetCache, sfNetHood,
                    sfNetwork, sfNone, sfPersonal, sfPrinters, sfPrintHood, sfPrograms,
                    sfRecentFiles, sfSendTo, sfStartMenu, sfStartup, sfTemplates);

  TStNotifyRegister = record
    Pidl         : PItemIDList;
    WatchSubTree : LONGBOOL;
  end;

const
  { These the following constants are not defined in ShellObj.PAS. }
  { Their use is not supported on all versions of Windows.         }
  CSIDL_Internet          = $0001;
  CSIDL_AltStartup        = $001d;
  CSIDL_Common_AltStartup = $001e;
  CSIDL_Common_Favorites  = $001f;
  CSIDL_Internet_Cache    = $0020;
  CSIDL_Cookies           = $0021;
  CSIDL_History           = $0022;
  Bif_EditBox             = $0010;
  Bif_Validate            = $0020;
  { The following constants are not defined in Delphi 2's OLE2.PAS. }
  { Their use is not supported on all versions of Windows.          }
  {$IFNDEF VERSION3}
  Fof_NoErrorUI                 = $0400;
  CSIDL_Common_StartMenu        = $0016;
  CSIDL_Common_Programs         = $0017;
  CSIDL_Common_Startup          = $0018;
  CSIDL_Common_DesktopDirectory = $0019;
  CSIDL_AppData                 = $001a;
  CSIDL_PrintHood               = $001b;
  Bif_BrowseIncludeFiles        = $4000;
  IId_IPersistFile : TGUID = (
    D1:$0000010B;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
  IId_IShellLink : TGUID = (
    D1:$000214EE;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
  {$ENDIF}

  ShellFolders : array [TStSpecialRootFolder] of Integer =
    (CSIDL_ALTSTARTUP, CSIDL_APPDATA, CSIDL_BITBUCKET, CSIDL_COMMON_ALTSTARTUP,
     CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_COMMON_FAVORITES, CSIDL_COMMON_PROGRAMS,
     CSIDL_COMMON_STARTMENU, CSIDL_COMMON_STARTUP, CSIDL_CONTROLS, CSIDL_COOKIES,
     CSIDL_DESKTOP, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_FAVORITES,
     CSIDL_FONTS, CSIDL_HISTORY, CSIDL_INTERNET, CSIDL_INTERNET_CACHE,
     CSIDL_NETHOOD, CSIDL_NETWORK, 0, CSIDL_PERSONAL, CSIDL_PRINTERS,
     CSIDL_PRINTHOOD, CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO,
     CSIDL_STARTMENU, CSIDL_STARTUP, CSIDL_TEMPLATES);

type
  {base component for SysTools shell components}
  TStShellComponent = class(TStComponent)
  protected {private}
    FShellVersion : Double;
    FError        : Integer;
    FErrorString  : string;

    FOnError      : TNotifyEvent;

    procedure CheckSystemError(ErrCode : Integer);

    {properties}
    property ShellVersion : Double
      read FShellVersion;

    property Error : Integer
      read FError
      write FError;

    property ErrorString : string
      read FErrorString;

    {events}
    property OnError : TNotifyEvent
      read FOnError
      write FOnError;

    {protected methods}
    procedure DoError;

  public
    constructor Create(AOwner : TComponent);
      override;
  end;

{$Z-}
  { Undocumented PIDL functions that we import. }
  TStILClone = function(Pidl : PItemIDList) : PItemIDList; stdcall;
  TStILCloneFirst = function(Pidl : PItemIDList) : PItemIDList; stdcall;
  TStILCombine = function (Pidl1, Pidl2 : PItemIDList) : PItemIDList; stdcall;
  TStILGetNext = function(Pidl : PItemIDList) : PItemIDList; stdcall;
  TStILFindLastID = function(Pidl : PItemIDList) : PItemIDList; stdcall;
  TStILIsEqual = function(Pidl1, Pidl2 : PItemIDList) : LongBool; stdcall;
  TStILRemoveLastID = function(Pidl : PItemIDList) : LongBool; stdcall;
  TStILGetSize = function(Pidl : PItemIDList) : Word; stdcall;
  TStILFree = procedure(Pidl : PItemIDList); stdcall;

  TStSHChangeNotifyRegister = function(HWnd : THandle; Flags : DWORD;
    EventMask : DWORD; MessageID : UINT; ItemCount : DWORD;
    var Items : TStNotifyRegister) : THandle; stdcall;
  TStSHChangeNotifyDeregister = function(
    HNotificationObject : THandle) : Boolean;  stdcall;

var
  Shell32Inst   : THandle;
  PidlFormat    : Word;
  ILClone       : TStILClone;
  ILCloneFirst  : TStILCloneFirst;
  ILCombine     : TStILCombine;
  ILGetNext     : TStILGetNext;
  ILFindLastID  : TStILFindLastID;
  ILIsEqual     : TStILIsEqual;
  ILRemoveLastID: TStILRemoveLastID;
  ILGetSize     : TStILGetSize;
  ILFree        : TStILFree;
  SHChangeNotifyRegister      : TStSHChangeNotifyRegister;
  SHChangeNotifyDeregister    : TStSHChangeNotifyDeregister;

  function GetSpecialFolderPath(Handle : TStHwnd; Folder : TStSpecialRootFolder) : string;  
  procedure GetSpecialFolderFiles(Handle : TStHwnd;                       
                                  Folder : TStSpecialRootFolder;
                                  Files : TStrings);
  function GetParentPidl(Pidl: PItemIDList) : PItemIDList;
  procedure LoadILFunctions;

implementation


{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

procedure LoadILFunctions;
begin
  Shell32Inst := LoadLibrary('shell32.dll');
  if Shell32Inst <> 0 then begin
    @ILClone        := GetProcAddress(Shell32Inst, PChar(18));
    @ILCloneFirst   := GetProcAddress(Shell32Inst, PChar(19));
    @ILCombine      := GetProcAddress(Shell32Inst, PChar(25));
    @ILGetNext      := GetProcAddress(Shell32Inst, PChar(153));
    @ILFindLastID   := GetProcAddress(Shell32Inst, PChar(16));
    @ILIsEqual      := GetProcAddress(Shell32Inst, PChar(21));
    @ILRemoveLastID := GetProcAddress(Shell32Inst, PChar(17));
    @ILGetSize      := GetProcAddress(Shell32Inst, PChar(152));
    @ILFree         := GetProcAddress(Shell32Inst, PChar(155));
    @SHChangeNotifyRegister   := GetProcAddress(Shell32Inst, PChar(2));
    @SHChangeNotifyDeregister := GetProcAddress(Shell32Inst, PChar(4));
  end;
end;

function GetParentPidl(Pidl: PItemIDList) : PItemIDList;
var
  TempPidl : PItemIDList;
begin
  TempPidl := ILClone(Pidl);
  ILRemoveLastID(TempPidl);
  Result := ILFindLastID(TempPidl);
end;

function GetSpecialFolderPath(Handle : TStHwnd; Folder : TStSpecialRootFolder) : string; 
var
  IDList : PItemIDList;
  Buff : array [0..MAX_PATH - 1] of Char;
begin
  if SHGetSpecialFolderLocation(
      Handle, ShellFolders[Folder], IDList) <> NOERROR then
    RaiseStError(EStShellError, stscShellVersionError);
  if not SHGetPathFromIDList(IDList, Buff) then
    RaiseStError(EStShellError, stscShellVersionError);
  Result := Buff;
end;

function FilterFunc(const SR : TSearchRec; B : Boolean) : Boolean; far;
begin
  if (SR.Attr and faDirectory = faDirectory) then
    Result := False
  else
    Result := True;
end;

procedure GetSpecialFolderFiles(Handle : TStHwnd;
                                Folder : TStSpecialRootFolder;
                                Files : TStrings);
var
  S : string;
begin
  S := GetSpecialFolderPath(Handle, Folder);
  if not DirectoryExists(S) then
    RaiseStError(EStShellError, stscShellVersionError);
  EnumerateFiles(S, Files, False, FilterFunc);
end;

constructor TStShellComponent.Create(AOwner : TComponent);
var
  VI     : TStVersionInfo;
  WinDir : array [0..MAX_PATH - 1] of Char;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  VI := TStVersionInfo.Create(AOwner);
  try
    GetSystemDirectory(WinDir, MAX_PATH);
    VI.FileName := WinDir + '\shell32.dll';
    FShellVersion := VI.FileVersionFloat;
  finally
    VI.Free;
  end;
end;

procedure TStShellComponent.CheckSystemError(ErrCode : Integer);
var
  Buff : array [0..1023] of Char;
begin
  if ErrCode <> 0 then
    FError := ErrCode
  else
    FError := GetLastError;
  if FError <> 0 then begin
    if (FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,                      
        nil, FError, 0, Buff, SizeOf(Buff), nil) <> 0) then            
      FErrorString := Buff
    else                                                               
      FErrorString := '';                                              
  end else
    FErrorString := '';
end;

procedure TStShellComponent.DoError;
begin
  if Assigned(FOnError) then
    FOnError(Self);
end;

{$IFDEF VERSION3}
initialization
  PidlFormat := RegisterClipboardFormat(CFSTR_SHELLIDLIST);
  LoadILFunctions;

finalization
  if Shell32Inst <> 0 then begin
    FreeLibrary(Shell32Inst);
    Shell32Inst := 0;
  end;
{$ENDIF}

end.