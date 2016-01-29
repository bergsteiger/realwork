{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcapi;

interface
{$I dc.inc}

uses
  dcdreamlib,sysutils, DCConsts,

  {$IFNDEF CLX}
  windows, activex, messages,

  {$IFDEF SHELLOBJ}shlobj, {$ENDIF}

  {$IFDEF WIN}
  registry, mmsystem,
  {$ENDIF}

  {$ELSE}

  {$UNDEF SHELLOBJ}

  dcActivex,
  {$ENDIF}

  classes
  ;


const
  SErrLoadingUnRAR = 'Can''t load UNRAR.DLL';

  sErrDelphiRunning = 'You have one or more of the following applications running. It is highly recommended that you shut down these '+
                      'applications before you can install %s.'#13#10#13#10+
                      'Borland Delphi'#13#10+
                      'Borland C++ Builder'#13#10;

  sErrPrevVersion = 'Setup has detected that previous version of %s is already installed. '+
                    'It is highly recommended that you uninstall previous version before '+
                    'you can install %s.'#13#10#13#10+
                    'Press the OK button to continue the installation.'+
                    #13#10'Press the Cancel button to abort the installation.';

  sCaptionInstallError = 'Installation Error';
  sCaptionInstallWarning = 'Installation Warning';


{-----------------------------------------------------------}

{$IFNDEF D3}
const
  PBM_SETRANGE32 = WM_USER + 6;
{$ENDIF}

{ Cabinet files support}
const
  FILEOP_ABORT   = 0;
  FILEOP_DOIT    = 1;
  FILEOP_SKIP    = 2;
  FILEOP_RETRY   = FILEOP_DOIT;
  FILEOP_NEWPATH = 4;

  _MAXPATH        = 260;

  SPFILENOTIFY_STARTQUEUE    =$00000001;
  SPFILENOTIFY_ENDQUEUE      =$00000002;
  SPFILENOTIFY_STARTSUBQUEUE =$00000003;
  SPFILENOTIFY_ENDSUBQUEUE   =$00000004;
  SPFILENOTIFY_STARTDELETE   =$00000005;
  SPFILENOTIFY_ENDDELETE     =$00000006;
  SPFILENOTIFY_DELETEERROR   =$00000007;
  SPFILENOTIFY_STARTRENAME   =$00000008;
  SPFILENOTIFY_ENDRENAME     =$00000009;
  SPFILENOTIFY_RENAMEERROR   =$0000000a;
  SPFILENOTIFY_STARTCOPY     =$0000000b;
  SPFILENOTIFY_ENDCOPY       =$0000000c;
  SPFILENOTIFY_COPYERROR     =$0000000d;
  SPFILENOTIFY_NEEDMEDIA     =$0000000e;
  SPFILENOTIFY_QUEUESCAN     =$0000000f;


  SPFILENOTIFY_CABINETINFO     =$00000010;
  SPFILENOTIFY_FILEINCABINET   =$00000011;
  SPFILENOTIFY_NEEDNEWCABINET  =$00000012;
  SPFILENOTIFY_FILEEXTRACTED   =$00000013;

  SPFILENOTIFY_FILEOPDELAYED   =$00000014;

type
  TPSPFileCallBack = function (Context : pointer;  // context used by the default callback routine
             Notification : UINT;                  // queue notification
             Param1, Param2 : UINT) : UINT; stdcall;     // additional notification information

  PFileInCabinetInfo = ^TFileInCabinetInfo;
  TFileInCabinetInfo = packed record
    NameInCabinet           : PChar;
    FileSize                : DWORD;
    Win32Error              : DWORD;
    DosDate                 : WORD;
    DosTime                 : WORD;
    DosAttribs              : WORD;
    FullTargetName : array[0 .. _MAXPATH] of char;
  end;

  PCabinetInfo = ^TCabinetInfo;
  TCabinetInfo = packed record
    CabinetPath : pchar;
    CabinetFile : pchar;
    DiskName    : pchar;
    SetId       : word;
    CabinetNumber : word;
  end;

  PFILEPATHS = ^TFILEPATHS;
  TFILEPATHS = packed record
     Target     : pchar;
     Source     : pchar;
     Win32Error : UINT;
     Flags      : DWORD;
  end;

  TExtractCallBack = function (CabInfo : PFileInCabinetInfo) : UINT;

  {$IFNDEF CLX}
  TResDialog = class
  private
    fDialogWnd : THandle;
    fFinished  : boolean;
    fDlgResult : boolean;

    function  DialogWndProc(uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : integer; stdcall;
  protected
    procedure WMCommand(var Msg : TWMCommand); message WM_COMMAND;
    procedure WMInitDialog(var Msg : TWMCommand); message WM_INITDIALOG;
    procedure InitDialog; virtual;
  public
    constructor Create(DialogID : integer); virtual;
    function    Execute : boolean;
    destructor  Destroy; override;

    property DialogWnd : THandle read fDialogWnd;
  end;
  {$ENDIF}

  TDelphiVer = (dvD2,dvC1,dvD3,dvC3,dvD4,dvC4,dvD5,dvC5,dvd6,dvC6,dvD7);

  TDelphiVers=set of TDelphiVer;

const

 cAllDelphiVers=[dvd2..dvd6];

 cDCNativeVerDefine:Array[TDelphiVer] of String=(
   'VER90',   //D2
   'VER93',   //C1
   'VER100',  //D3
   'VER110',  //C3
   'VER120',  //D4
   'VER125',  //C4
   'VER130',  //D5
   'VER130',  //C5
   'VER140',  //D6
   'VER140',  //C6
   'VER150'   //D7
   );

  cDelphiVers : array[TDelphiVer] of string = ('D2', 'C1', 'D3', 'C3', 'D4', 'C4', 'D5', 'C5','D6', 'C6', 'D7');
  DelphiReqVer:Array[TDelphiVer] Of Integer =(-1{D2},-1{C1},$50053{D3},$30046{C3},$5006C{D4},$E000B{C4},-1{D5},-1{C5},-1{D6},-1{C6},-1{D7});

{-------------------------------------------------------------------------}

{$IFDEF SHELLOBJ}

type
   TDCPathDialogRoot = (pdrNone, pdrBitBucket, pdrControls, pdrDesktop, pdrDesktopDirectory,
                     pdrDrives, pdrFonts, pdrNetHood, pdrNetwork, pdrPersonal,
                     pdrPrinters, pdrPrograms, pdrRecent, pdrSendto, pdrStartmenu,
                     pdrStartup, pdrTemplates);

const


  pdr2csidl : array[TDCPathDialogRoot] of integer =
  (0, CSIDL_BITBUCKET, CSIDL_CONTROLS, CSIDL_DESKTOP, CSIDL_DESKTOPDIRECTORY,
   CSIDL_DRIVES, CSIDL_FONTS, CSIDL_NETHOOD, CSIDL_NETWORK, CSIDL_PERSONAL,
   CSIDL_PRINTERS, CSIDL_PROGRAMS, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_STARTMENU,
   CSIDL_STARTUP, CSIDL_TEMPLATES);

type

  TDCPathDialogFlag = (pdfBrowseForComputer, pdfBrowseForPrinter,
                     pdfDontGoBelowDomain, pdfReturnfsAncestors,
                     pdfReturnOnlyFSDirs);

  TDCPathDialogFlags = set of TDCPathDialogFlag;

const
  pdf2bif : array[TDCPathDialogFlag] of integer= (BIF_BROWSEFORCOMPUTER,
               BIF_BROWSEFORPRINTER,  BIF_DONTGOBELOWDOMAIN,
               BIF_RETURNFSANCESTORS, BIF_RETURNONLYFSDIRS);

type
  TDCPathDialog = class(TComponent)
  private
    fTitle        : string;
    fSelectedItem : string;
    fHandle       : THandle;
    fParentWindow : THandle;
    fRoot         : TDCPathDialogRoot;
    fFlags        : TDCPathDialogFlags;
    //FVersion      : TDCVersion;

    procedure SetSelectedItem(const Item : string);
    function  GetRootpidl : PItemIDList;
    function  GetFlags : integer;

  public
    constructor Create(AOwner : TComponent); override;

    function Execute : boolean;
    property ParentWindow : THandle read fParentWindow write fParentWindow;
  published
    property Flags : TDCPathDialogFlags read fFlags write fFlags;
    property Title : string read fTitle write fTitle;
    property SelectedItem : string read fSelectedItem write SetSelectedItem;
    property Root : TDCPathDialogRoot read fRoot write fRoot;
    //property Version : TDCVersion read FVersion write FVersion stored false;
  end;
{$ENDIF}
{routines}

(*
function  ExtractCAB(const CabFile, DestDir : string) : boolean;
function  ExtractCABFile(const CabFile, DestDir : string; Files, Folders, SysFiles : TStrings; CallBack : TExtractCallBack) : boolean;
*)

{$IFDEF WIN}

Function GetTemporaryPath : String;

{$IFNDEF CLX}

procedure CreateFolders(Folders:TStrings);
function  DirectoryExists(const Name: string) : Boolean;

function  ExecuteDialog(DialogID : integer) : boolean;
procedure AddUnInstaller(const AppName, UninstallApp : string);
procedure RemoveUnInstaller(const DisplayName : string);
function  StringFromGUID(const GUID : TGUID): string;
function  GetUniqueString(const Prefix : string) : string;
procedure AddStringResource(const FileName, ResName : string; const Value : String);
procedure AddRCDataResource(const FileName, ResName : string; Value : pointer; Size : integer);
function  GetResData(const ResName : string; var Data : pointer; var Length : integer) : THandle;
procedure ReleaseResData(Handle : THandle);
function  GetTemporaryFileName(const Prefix : string) : string;
function  LoadStringFromRCData(const ResName : string) : string;

procedure AddUnInstallInfo(const AppName, InfoName, InfoValue : string);
procedure AddUnInstallFilesInfo(const AppName : string; InfoValues : TStringList);
procedure GetUninstallFilesInfo(const AppName : string; Values : TStringList);
procedure RemoveUninstallFilesInfo(const AppName : string);

function  GetUnInstallInfo(const AppName, InfoName : string) : string;
function  SystemDirectory : string;
function  WindowsDirectory : string;
function  ProgramFilesDirectory : string;
function  CreateRegKey(Root : THandle; const KeyName : string) : HKEY;
procedure ChangeRegStrValue(Key : HKEY; const Name, Value : string);

function  InstallCheckDelphiRunning(const AppName : string) : boolean;
function  InstallCheckPrevVersion(const AppName : string) : boolean;
function  IsAppInstalled(const AppName : string) : boolean;
procedure RemoveFile(const FileName : string);

procedure RunBatFile(const FileName:String);
function  RunBatFileEx(const FileName:String;Wait:boolean) : DWORD;
procedure AddHelpToCntFile(const HelpFile, HelpName, CntFile : string);
procedure RemoveHelpFromCntFile(const HelpFile, CntFile : string);
function  GetDelphiHelpCntFile(DelphiVer : TDelphiVer) : string;
procedure AddInstalledPackage(DelphiVer : TDelphiVer; const PName, FileName : string);
function  ProcessFileTemplate(const ATemplate : string) : string;
{$ENDIF}
{$ENDIF}

{$IFDEF SHELLOBJ}
procedure CreateLink(const LinkFile, LinkObject, Description, WorkingFolder : string);
function  StartMenuProgramsFolder : string;
function  QueryDir(const ATitle : string; var ADirectory : string; AParent : THandle) : boolean;
function  QueryComp(const ATitle : string; var Computer : string; AParent : THandle) : boolean;
{$ENDIF}

function  AddSlash(const Path : string) : string;
function DCUpFolder(const Path : string) : string;
function  RemoveSlash(const Path : string) : string;

function GetThisDelphiVer : TDelphiVer;

//EndSkipConst
{
%SYSTEM%
%WINDOWS%
%PROGRAMFILES%
}


{-------------------------------------------------------------------------}
{$IFDEF WIN}
{$IFNDEF CLX}
// UNRAR
const
  ERAR_END_ARCHIVE    = 10;
  ERAR_NO_MEMORY      = 11;
  ERAR_BAD_DATA       = 12;
  ERAR_BAD_ARCHIVE    = 13;
  ERAR_UNKNOWN_FORMAT = 14;
  ERAR_EOPEN          = 15;
  ERAR_ECREATE        = 16;
  ERAR_ECLOSE         = 17;
  ERAR_EREAD          = 18;
  ERAR_EWRITE         = 19;
  ERAR_SMALL_BUF      = 20;

  RAR_OM_LIST         =  0;
  RAR_OM_EXTRACT      =  1;

  RAR_VOL_ASK         =  0;
  RAR_VOL_NOTIFY      =  1;

type
  TRARFileOperation = (opSkip, opTest, opExtract);

  TRARHeaderData = packed record
    ArcName    : array [0..259] of char;
    FileName   : array [0..259] of char;
    Flags      : UINT;
    PackSize   : UINT;
    UnpSize    : UINT;
    HostOS     : UINT;
    FileCRC    : UINT;
    FileTime   : UINT;
    UnpVer     : UINT;
    Method     : UINT;
    FileAttr   : UINT;
    CmtBuf     : PChar;
    CmtBufSize : UINT;
    CmtSize    : UINT;
    CmtState   : UINT;
  end;

  TRAROpenArchiveData = packed record
    ArcName    : PChar;
    OpenMode   : UINT;
    OpenResult : UINT;
    CmtBuf     : PChar;
    CmtBufSize : UINT;
    CmtSize    : UINT;
    CmtState   : UINT;
  end;

TRARChangeVolProc = function (ArcName : PChar; Mode : integer) : integer; cdecl;
TRARProcessDataProc = function (Addr : pointer; Size : integer) : integer; cdecl;

TRARFileExtractCallBack = function(const FileInfo : TRARHeaderData; var DestDir, DestName : string) : TRARFileOperation;

var
  UnRARDLLHandle : THandle = 0;

procedure LoadUnRAR;
procedure UnloadUnRAR;
function  OpenRARFile(const FileName : string) : THandle;
function  RAROpenArchive(var ArchiveData : TRAROpenArchiveData) : THandle;
function  RARCloseArchive(hArcData : THandle): integer;
function  RARReadHeader(hArcData : THandle; var HeaderData : TRARHeaderData) : integer;
function  RARProcessFile(hArcData : THandle; Operation : TRARFileOperation; const DestPath, DestName : string): integer;
procedure RARSetChangeVolProc(hArcData : THandle; ChangeVolProc : TRARChangeVolProc);
procedure RARSetProcessDataProc(hArcData : THandle; ProcessDataProc : TRARProcessDataProc);
procedure RARSetPassword(hArcData : THandle; const Password : string);

function  ExtractRARFile(const RarFile, DestDir : string; CallBack : TRARFileExtractCallBack; Files, Folders, SysFiles : TStrings) : boolean;
procedure LoadUnRARFromFile(const FileName : string);


function GetDelphiDir : string;
function GetDelphiSourceDirs : string;

function GetDelphiIDEFileName(VerType:TDelphiVer):String;
function GetDelphiCMDFileName(VerType:TDelphiVer):String;
function GetDelphiRegKey(VerType:TDelphiVer;const KeyName:String):String;

function GetDelphiHelpFolder(DelphiVer : TDelphiVer) : string;
{$ENDIF CLX}

function GetSpecificDelphiDir(vertype : TDelphiVer) : string;

type
  TDCDelphiSourceDirsOpt=(doAddLibFolder,doExcludeSysUnderD3);
  TDCDelphiSourceDirsOpts=set of TDCDelphiSourceDirsOpt;


function GetDelphiSourceDirsEx2(DelphiVer:TDelphiVer;Opts:TDCDelphiSourceDirsOpts) : string;
function GetDelphiSourceDirsEx(DelphiVer:TDelphiVer) : string;
procedure CreateAllDirectories(Dir : string; CreatedDirs : TStrings);

Function DCGenDPUPath( ADelphiVer : TDelphiVer ) : String;
{$ENDIF WIN}

function ExtractValuePart(const S:String):String;
function ExtractNamePart(const S:String):String;
function ExtractValuePartEx(const S,Separator:String):String;
function ExtractNamePartEx(const S,Separator:String):String;

function IndexOfValue(S : TStrings; const Value : string) : integer;
function GetDelphiVer(const s : string) : TDelphiVer;
function GetDelphiPackagesKey(DelphiVer : TDelphiVer) : string;

function Quote(const s : string; QuoteChar : char) : string;
function QuoteFileName(const S:String):String;

{$IFDEF WIN}
{$IFNDEF CLX}
function GetCDDeviceID : integer;
procedure SetCDAudioVolume(val : integer);
function GetCDAudioVolume : integer;

Function ConvertErrors(const Errors:String):String;
Function VersionCorrect(DelphiVer:TDelphiVer):Boolean;
Function CompileFile(DelphiVer:TDelphiVer;const FullFileName,OutDir:String;
                     var ResultFile : string; Var ErrorMessage:String):Boolean;


Function RunProgram(const CmdLine,WorkDir:String;Var ErrorMessage:String;
                    HookOutput{,CheckErrorCode}:Boolean):Boolean;

{$ENDIF CLX}
{$ENDIF WIN}

function DCGetDelphiVerFromDefines(Defines:TStrings;var DelphiVer:TDelphiVer):boolean;
function DCGetDelphiVerFromName(const DelphiName:String;var DelphiVer:TDelphiVer):boolean;

implementation

{$IFNDEF CLX}
function GetCDDeviceID : integer;
var
  NumDevs : integer;
  dcaps   : TAuxCaps;
begin
  NumDevs := auxGetNumDevs;

  for result := 0 to NumDevs - 1 do
    begin
      auxGetDevCaps(result, @dcaps, sizeof(dcaps));

      if (dcaps.dwSupport and AUXCAPS_VOLUME) <> 0 then
          exit;
    end;

  result := -1;
end;

procedure SetCDAudioVolume(val : integer);
var
  id : integer;
begin
  id := GetCDDeviceID;
  if id <> -1 then
    auxSetVolume(id, val shl 8 + val shl 24);
end;

function GetCDAudioVolume : integer;
var
  id : integer;
begin
  id := GetCDDeviceID;
  if id <> -1 then
    begin
      auxGetVolume(id, @result);
      result := ((result and $FFFF) shr 9) + (result shr 25);
    end
  else
    result := -1;
end;
{$ENDIF}

//BeginSkipConst
function GetDelphiPackagesKey(DelphiVer : TDelphiVer) : string;
begin
  case DelphiVer of
    dvD3 : result := 'Software\Borland\Delphi\3.0\Known Packages';
    dvC3 : result := 'Software\Borland\C++Builder\3.0\Known Packages';
    dvD4 : result := 'Software\Borland\Delphi\4.0\Known Packages';
    dvC4 : result := 'Software\Borland\C++Builder\4.0\Known Packages';
    dvD5 : result := 'Software\Borland\Delphi\5.0\Known Packages';
    dvC5 : result := 'Software\Borland\C++Builder\5.0\Known Packages';
    dvD6 : result := 'Software\Borland\Delphi\6.0\Known Packages';
    dvC6 : result := 'Software\Borland\C++Builder\6.0\Known Packages';
    dvD7 : result := 'Software\Borland\Delphi\7.0\Known Packages';
    else result := '';
  end;
end;

{------------------------------------------------------------------}

function GetDelphiVer(const s : string) : TDelphiVer;
begin
  for result := Low(TDelphiVer) to High(TDelphiVer) do
    if CompareText(cDelphiVers[result], s) = 0 then
      exit;

  result := dvD4;
end;

{------------------------------------------------------------------}

{$IFDEF WIN}

{$IFNDEF CLX}

function GetDelphiCMDFileName(VerType:TDelphiVer):String;
{const
  CMDName : Array[TDelphiVer] of string =
  (
    'dcc32.exe',      //D2
    '',             //C1
    'dcc32.exe',        //D3
    '',             //C3
    'dcc32.exe'         //D4
  );
}
begin
  Result:=AddSlash(ExtractFilePath(GetDelphiIDEFileName(VerType)))+
    'dcc32.exe'{CMDName[VerType]};

end;

{------------------------------------------------------------------}

function GetDelphiIDEFileName(VerType:TDelphiVer):String;
const
  KeyName : Array[TDelphiVer] of string =
  (
    'Delphi 2.0',      //D2
    'App',             //C1
    'Delphi 3',        //D3
    'App',             //C3
    'Delphi 4',        //D4
    'App',             //C4
    'Delphi 5',        //D5
    'App',             //C5
    'Delphi 6',        //D6
    'App',             //C6
    'Delphi 7'         //D7
  );
begin
  Result:=GetDelphiRegKey(VerType,KeyName[VerType]);
end;

{------------------------------------------------------------------}

function GetDelphiRegKey(VerType:TDelphiVer;const KeyName:String):String;
const
  RegPathPrefix = 'Software\Borland\';
  RegPath : Array[TDelphiVer] of string =
  (
    'Delphi\2.0',
    'C++Builder\1.0',
    'Delphi\3.0',
    'C++Builder\3.0',
    'Delphi\4.0',
    'C++Builder\4.0',
    'Delphi\5.0',
    'C++Builder\5.0',
    'Delphi\6.0',
    'C++Builder\6.0',
    'Delphi\7.0'
  );
var
  r      : TRegistry;
  RegKey : string;
begin

  RegKey := RegPathPrefix + RegPath[vertype];
  r:= TRegistry.Create;
  try
    r.RootKey:=HKEY_LOCAL_MACHINE;
    if r.Openkey(RegKey,False) then
      result := r.ReadString(KeyName)
    else
      result  := '';
  finally
    r.Free;
  end;
end;

{------------------------------------------------------------------}

function  GetDelphiDir : string;
begin
  result := GetSpecificDelphiDir(GetThisDelphiVer);
end;

{------------------------------------------------------------------}

function  GetDelphiSourceDirs : string;
begin
  Result:=GetDelphiSourceDirsEx(GetThisDelphiVer);
end;

{-------------------------------------------------------------------------}

function GetDelphiHelpFolder(DelphiVer : TDelphiVer) : string;
begin
  Result:=GetSpecificDelphiDir(DelphiVer) + 'HELP\'; //don't resource
end;

{-------------------------------------------------------------------------}

function GetD4HelpFolder:String;
begin
  result:=GetDelphiHelpFolder(dvD4);
end;

{-------------------------------------------------------------------------}

function GetD3HelpFolder:String;
begin
  result:=GetDelphiHelpFolder(dvD3);
end;

{-------------------------------------------------------------------------}

function GetD2HelpFolder:String;
begin
  result:=GetDelphiHelpFolder(dvD2);
end;

{-------------------------------------------------------------------------}

function GetC1HelpFolder:String;
begin
  result:=GetDelphiHelpFolder(dvC1);
end;

{-------------------------------------------------------------------------}

function GetC3HelpFolder:String;
begin
  result:=GetDelphiHelpFolder(dvC3);
end;

{$ENDIF CLX}

function DCGenDPUPath( ADelphiVer : TDelphiVer ) : String;
begin
  Result := AddSlash( GetTemporaryPath ) + 'DPU_' + cDelphiVers[ ADelphiVer ];//don't resource
  CreateAllDirectories( Result, nil );
end;

{------------------------------------------------------------------}

function GetDelphiSourceDirsEx2(DelphiVer:TDelphiVer;Opts:TDCDelphiSourceDirsOpts) : string;
var
  basedir:string;
  SysFolder:String;
begin
  basedir := GetSpecificDelphiDir(DelphiVer);

  if (doExcludeSysUnderD3 in Opts) and (DelphiVer in [dvd3,dvc3]) then
    SysFolder:=''
  else
    SysFolder:=basedir +'Source\Rtl\Sys;';

  if basedir <> '' then
    begin
      result := basedir +'Doc;' +
                basedir +'Source\Vcl;' +
                SysFolder +
                basedir +'Source\Rtl\Win;' +
                basedir +'Source\Toolsapi;' +
                basedir +'Source\Internet;' +
                basedir +'Source\Samples;' +
                basedir +'Source\Rtl\Corba;';

      If DelphiVer in [dvD7,dvd6,dvd5,dvc5] then
        result := result+
                  basedir +'Source\Decision Cube;' +
                  basedir +'Source\Property Editors;'+
                  basedir +'Source\WebMidas;';

      If DelphiVer in [dvd6, dvd7] then
        result := result+
                  basedir +'Source\Rtl\Common;' +
                  basedir +'Source\Rtl\Corba40;' +
                  basedir +'Source\Clx;' +
                  basedir +'Source\Soap;';

      If doAddLibFolder in Opts then
        result := result+
                  basedir +'Lib;' +
                  basedir +'Lib\Obj;' +
                  basedir +'Lib\Delphi2;';
    end
  else
    result :='';
end;

{------------------------------------------------------------------}

function GetDelphiSourceDirsEx(DelphiVer:TDelphiVer):string;
begin
  Result:=GetDelphiSourceDirsEx2(DelphiVer,[doAddLibFolder]);
end;

{------------------------------------------------------------------}

function GetSpecificDelphiDir(vertype : TDelphiVer) : string;
begin
{$IFDEF CLX}
  result := '';
{$ELSE}
  Result:=AddSlash(GetDelphiRegKey(VerType,'RootDir'));
{$ENDIF}
end;

{------------------------------------------------------------------}


{$ENDIF WIN}

//EndSkipConst
{------------------------------------------------------------------}
{$IFNDEF CLX}
{$IFDEF WIN}

var
  _RAROpenArchive : function(var ArchiveData : TRAROpenArchiveData) : THandle; stdcall = nil;
  _RARCloseArchive : function(hArcData : THandle): integer; stdcall = nil;
  _RARReadHeader : function(hArcData : THandle; var HeaderData : TRARHeaderData) : integer; stdcall = nil;
  _RARProcessFile : function(hArcData : THandle; Operation : integer; const DestPath, DestName : string): integer; stdcall = nil;
  _RARSetChangeVolProc : procedure (hArcData : THandle; ChangeVolProc : TRARChangeVolProc); stdcall = nil;
  _RARSetProcessDataProc : procedure(hArcData : THandle; ProcessDataProc : TRARProcessDataProc); stdcall = nil;
  _RARSetPassword : procedure(hArcData : THandle; const Password : string); stdcall = nil;

{------------------------------------------------------------------}

procedure UnloadUnRAR;
begin
  if UnRARDLLHandle <> 0 then
    begin
      FreeLibrary(UnRARDLLHandle);
      UnRARDLLHandle := 0;
    end;
end;

{------------------------------------------------------------------}

procedure LoadUnRARFromFile(const FileName : string);
begin
  UnRARDLLHandle := LoadLibrary(PChar(FileName));
  if UnRARDLLHandle <> 0 then
    begin
      _RAROpenArchive := GetProcAddress(UnRARDLLHandle, 'RAROpenArchive');
      _RARCloseArchive := GetProcAddress(UnRARDLLHandle, 'RARCloseArchive');
      _RARReadHeader := GetProcAddress(UnRARDLLHandle, 'RARReadHeader');
      _RARProcessFile := GetProcAddress(UnRARDLLHandle, 'RARProcessFile');
      _RARSetChangeVolProc := GetProcAddress(UnRARDLLHandle, 'RARSetChangeVolProc');
      _RARSetProcessDataProc := GetProcAddress(UnRARDLLHandle, 'RARSetProcessDataProc');
      _RARSetPassword := GetProcAddress(UnRARDLLHandle, 'RARSetPassword');
    end
  else
    raise Exception.Create(SErrLoadingUnRAR);
end;

{------------------------------------------------------------------}

procedure LoadUnRAR;
begin
  if UnRARDLLHandle = 0 then
    LoadUnRARFromFile('unrar.dll');
end;

{------------------------------------------------------------------}

function OpenRARFile(const FileName : string) : THandle;
var
  data : TRAROpenArchiveData;
begin
  FillChar(data, sizeof(data), 0);
  data.ArcName := @(FileName[1]);
  data.OpenMode := RAR_OM_EXTRACT;
  result := RAROpenArchive(data);
end;

{------------------------------------------------------------------}

function  RAROpenArchive(var ArchiveData : TRAROpenArchiveData) : THandle;
begin
  LoadUnRAR;
  result := _RarOpenArchive(ArchiveData);
end;

{------------------------------------------------------------------}

function  RARCloseArchive(hArcData : THandle): integer;
begin
  LoadUnRAR;
  result := _RARCloseArchive(hArcData);
end;

{------------------------------------------------------------------}

function  RARReadHeader(hArcData : THandle; var HeaderData : TRARHeaderData) : integer;
begin
  LoadUnRAR;
  result := _RARReadHeader(hArcData, HeaderData);
end;

{------------------------------------------------------------------}

function  RARProcessFile(hArcData : THandle; Operation : TRARFileOperation; const DestPath, DestName : string): integer;
begin
  LoadUnRAR;
  result := _RARProcessFile(hArcData, ord(Operation), DestPath, DestName);
end;

{------------------------------------------------------------------}

procedure RARSetChangeVolProc(hArcData : THandle; ChangeVolProc : TRARChangeVolProc);
begin
  LoadUnRAR;
  RARSetChangeVolProc(hArcData, ChangeVolProc);
end;

{------------------------------------------------------------------}

procedure RARSetProcessDataProc(hArcData : THandle; ProcessDataProc : TRARProcessDataProc);
begin
  LoadUnRAR;
  _RARSetProcessDataProc(hArcData, ProcessDataProc);
end;

{------------------------------------------------------------------}

procedure RARSetPassword(hArcData : THandle; const Password : string);
begin
  LoadUnRAR;
  _RARSetPassword(hArcData, Password);
end;

{------------------------------------------------------------------}

function ExtractRARFile(const RarFile, DestDir : string; CallBack : TRARFileExtractCallBack; Files, Folders, SysFiles : TStrings) : boolean;
var
  sysdir : string;
  h      : THandle;
  hdata  : TRARHeaderData;
  _dir   : string;
  _name  : string;
  Operation : TRARFileOperation;
  isfolder  : boolean;
  issystem  : boolean;
  hFileName : string;
begin
  result := false;
  h := OpenRARFile(RARFile);
  if h = 0 then
    exit;

  try
    sysdir := SystemDirectory;

    while RARReadHeader(h, hdata) = 0 do
      begin
        _name := '';
        hFileName := ExtractFileName(hdata.FileName);
        issystem := Assigned(SysFiles) and (SysFiles.IndexOf(hFileName) >= 0);
        if issystem then
          begin
            _dir := sysdir;
//            _name := ExtractFileName(hdata.FileName);
          end
        else
          _dir := DestDir;

        if Assigned(CallBack) then
          Operation := CallBack(hdata, _dir, _name)
        else
          Operation := opExtract;

        isfolder := (hdata.FileAttr and faDirectory) <> 0;

        if isSystem then
          _name := AddSlash(_dir) + hFileName
        else if not isFolder and (Folders <> nil) then
          CreateAllDirectories(AddSlash(_dir) + ExtractFilePath(hdata.FileName), Folders{CreatedDirs : TStrings});

        RARProcessFile(h, Operation, _dir, _name);

        if not isfolder and Assigned(Files) then
          with Files do
            if _name <> '' then
              Files.Add(_name)
            else
              Files.Add(AddSlash(_dir) + hdata.FileName);
      end;
  finally
    RARCloseArchive(h);
  end;

  result := true;
end;

{$ENDIF} //WIN
{$ENDIF CLX}

{------------------------------------------------------------------}

{$IFDEF SHELLOBJ}

function PathDialogCallBack(Wnd : HWND; uMsg : UINT; lParam, lpData : LPARAM) : integer; stdcall;
begin
  with TDCPathDialog(lpData) do
    if uMsg = BFFM_INITIALIZED then
      begin
        fHandle := Wnd;
        SetSelectedItem(SelectedItem);
      end;

  result := 0;
end;

{-------------------------------------------------------------------------}

constructor TDCPathDialog.Create(AOwner : TComponent);
begin
  inherited;
  Flags := [pdfRETURNONLYFSDIRS];
  Root := pdrNone;
end;

{-------------------------------------------------------------------------}

function TDCPathDialog.GetFlags : integer;
var
  f : TDCPathDialogFlag;
begin
  result := 0;

  for f := pdfBROWSEFORCOMPUTER to pdfRETURNONLYFSDIRS do
    if f in fFlags then
      inc(result, pdf2bif[f]);
end;

{-------------------------------------------------------------------------}

function TDCPathDialog.GetRootpidl : PItemIDList;
begin
  SHGetSpecialFolderLocation(0, pdr2csidl[fRoot], result);
end;

{-------------------------------------------------------------------------}

function TDCPathDialog.Execute:Boolean;
var
  iList : PItemIDList;
  bi : TBrowseInfo;
  DispName : String;
  malloc : IMalloc;
begin
  result := false;
  SHGetMalloc(malloc);
  SetString(DispName, nil, MAX_PATH);
  FillChar(bi, sizeof(bi), 0);
  with bi do
    begin
      pszDisplayName := PChar(DispName);
      lpszTitle := PChar(FTitle);
      ulFlags := GetFlags;
      lpfn := @PathDialogCallBack;
      lParam := integer(self);
      hwndOwner := ParentWindow;
      pidlRoot := GetRootpidl;
    end;

  try
    iList := SHBrowseForFolder(bi);
  finally
    malloc.Free(bi.pidlRoot);
  end;

  fHandle := 0;
  if iList <> nil then
    try
      result := true;
      fSelectedItem := PChar(DispName);
      if SHGetPathFromIDList({$IFDEF D3}iList{$ELSE}iList^{$ENDIF}, PChar(DispName)) then
        fSelectedItem := PChar(DispName);

    finally
      malloc.Free(iList);
    end;
end;

{-------------------------------------------------------------------------}

procedure TDCPathDialog.SetSelectedItem(const Item : string);
begin
  if Item = '' then
    fSelectedItem := GetCurrentDir
  else
    begin
      fSelectedItem := Item;
      if (Item[length(Item)] = '\') then
        Delete(fSelectedItem, length(Item), 1);
    end;

  if (FHandle <> 0) then
    SendMessage(FHandle, BFFM_SETSELECTION, Integer(LongBool(true)), Integer(PChar(fSelectedItem)));
end;

{-------------------------------------------------------------------------}


{$ENDIF}

{$IFDEF WIN}
{$IFNDEF CLX}
var
  ResDialogs : TList;

{-------------------------------------------------------------------------}

function DialogProc(hWnd : THandle; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : integer; stdcall;
var
  i : integer;
begin
  for i := 0 to ResDialogs.Count - 1 do
    with TResDialog(ResDialogs[i]) do
      if DialogWnd = hWnd then
        begin
          DialogWndProc(uMsg, wParam, lParam);
          break;
        end;

  result := 0;
end;

{-------------------------------------------------------------------------}

function TResDialog.DialogWndProc(uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : integer; stdcall;
var
  M : TMessage;
begin
  M.Msg := uMsg;
  M.wParam := wParam;
  M.lParam := lParam;
  Dispatch(M);
  result := M.Result;
end;

{-------------------------------------------------------------------------}

constructor TResDialog.Create(DialogID : integer);
begin
  inherited Create;
  ResDialogs.Add(self);
  fDialogWnd := CreateDialog(hInstance, MakeIntResource(DialogID), 0, @DialogProc);
end;

{-------------------------------------------------------------------------}

destructor TResDialog.Destroy;
begin
  ResDialogs.Remove(self);
  DestroyWindow(DialogWnd);
//  EndDialog(DialogWnd, fDlgResult);
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TResDialog.WMInitDialog(var Msg : TWMCommand);
begin
  InitDialog;
end;

{-------------------------------------------------------------------------}

procedure TResDialog.InitDialog;
begin

end;

{-------------------------------------------------------------------------}

procedure TResDialog.WMCommand(var Msg : TWMCommand);
begin
  with Msg do
    if (NotifyCode = BN_CLICKED) and (ItemID in [ID_OK, ID_CANCEL]) then
      begin
        fFinished := true;
        fDlgResult := ItemID = ID_OK;
      end;
end;

{-------------------------------------------------------------------------}

function TResDialog.Execute : boolean;
var
  Msg : TMsg;
begin
  ShowWindow(DialogWnd, SW_SHOWDEFAULT);
  while GetMessage(msg, 0, 0, 0) and not fFinished do
    if not IsDialogMessage(DialogWnd, msg) then
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;

  result := fDlgResult;
end;

{------------------------------------------------------------}
{$ENDIF CLX}
{$ENDIF WIN}

{------------------------------------------------------------------}

function DCUpFolder(const Path : string) : string;
Var
  SlashPos:Integer;
begin
  Result:=RemoveSlash(Path);
  If Length(Result)=0 then
    exit;
  SlashPos:=BackPosEx(SlashString,Result,Length(Result));
  If SlashPos=0 then
    Result:=Path
  else
    Result:=Copy(Result,1,SlashPos-1);
end;

{------------------------------------------------------------}

function AddSlash(const Path : string) : string;
begin
  result := Path;
  if (Length(result) > 0) and (result[length(result)] <> SlashString) then
    result := result + SlashString;
end;

{------------------------------------------------------------}

function  RemoveSlash(const Path : string) : string;
var
  rlen : integer;
begin
  result := Path;
  rlen := length(result);
  if (rlen > 0) and (result[rlen] = SlashString) then
    Delete(result, rlen, 1);
end;

{------------------------------------------------------------}

{$IFDEF WIN}

{$IFDEF CLX}
{$DEFINE USEFINDFIRST}
{$ENDIF}
(*
{$IFNDEF D4}
{$IFDEF CPB3}
{$DEFINE USEFINDFIRST}
{$ENDIF}
{$ENDIF}
*)
function DirectoryExists(const Name : string) : Boolean;
var
{$IFDEF USEFINDFIRST}
  F : TSearchRec;
{$ELSE}
  Code : integer;
{$ENDIF}
begin
{$IFDEF USEFINDFIRST}
  result := SysUtils.FindFirst(Name, faDirectory, F) = 0;
  SysUtils.FindClose(F);
{$ELSE}
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
{$ENDIF}
end;

{------------------------------------------------------------}

procedure CreateAllDirectories(Dir : string; CreatedDirs : TStrings);
var
  ldir : integer;
  fpath : string;
begin
  ldir := Length(Dir);
  if ldir = 0 then
    exit;

  if (Dir[ldir] = SlashString) then
    Delete(Dir, ldir, 1);

  fpath := ExtractFilePath(Dir);

  if (Length(Dir) < 3) or DirectoryExists(Dir) or (fPath = Dir) then
    Exit;

  CreateAllDirectories(fPath, CreatedDirs);
  CreateDir(Dir);

  if CreatedDirs <> nil then
    CreatedDirs.Add(Dir);
end;

{$ENDIF WIN}
{------------------------------------------------------------}
(*
function SetupIterateCabinet(
  const CabinetFile : string;    // name of the cabinet file
  Reserved : DWORD;                // this parameter is not used
  MsgHandler : TPSPFILECALLBACK;  // callback routine to use
  Context : pointer                  // callback routine context
  ) : BOOL; stdcall; external 'setupapi.dll' name 'SetupIterateCabinetA'; //don't resource
*)
{-------------------------------------------------------------------------}

type
  PCabExtractInfo = ^TCabExtractInfo;
  TCabExtractInfo = record
    DestDir  : string;
    Files    : TStrings;
    Folders  : TStrings;
    SysFiles : TStrings;
    CallBack : TExtractCallBack;
  end;

{-------------------------------------------------------------------------}
(*
function IterateCallBack(Context : pointer; Notification, Param1, Param2 : UINT) : UINT; stdcall;

  function MakeDestName(Source, Dest : PChar) : string;
  var
    fname : string;
  begin
    with PCabExtractInfo(Context)^ do
      begin
        result := StrPas(Source);
        fname := ExtractFileName(result);
        if SysFiles.IndexOf(fname) >= 0 then
          result := SystemDirectory + ExtractFileName(result)
        else
          begin
            result := DestDir + result;
            CreateAllDirectories(ExtractFileDir(result), Folders);
          end;

        if Files <> nil then
          Files.Add(result);

        StrPCopy(Dest, result);
      end;
  end;

begin
  if Notification = SPFILENOTIFY_FILEINCABINET then
    begin
      result := FILEOP_DOIT;

      with PCabExtractInfo(Context)^ do
        if Assigned(CallBack) then
          result := CallBack(PFileInCabinetInfo(Param1));

      if result <> FILEOP_SKIP then
        with PFileInCabinetInfo(Param1)^ do
          MakeDestName(NameInCabinet, FullTargetName);
    end
  else
    result := NO_ERROR;
end;
*)
{-------------------------------------------------------------------------}
(*
function ExtractCAB(const CabFile, DestDir : string) : boolean;
begin
  result := ExtractCABFile(CabFile, DestDir, nil, nil, nil, nil);
end;

{-------------------------------------------------------------------------}

function ExtractCABFile(const CabFile, DestDir : string; Files, Folders, SysFiles : TStrings; CallBack : TExtractCallBack) : boolean;
var
  ExtractInfo : TCabExtractInfo;
//  Queue : THandle;
begin
  ExtractInfo.DestDir := AddSlash(DestDir);
  ExtractInfo.Files := Files;
  ExtractInfo.Folders := Folders;
  ExtractInfo.SysFiles := SysFiles;
  ExtractInfo.CallBack := CallBack;

  result := SetupIterateCabinet(CabFile, 0, IterateCallBack, @ExtractInfo);
end;
*)
{-------------------------------------------------------------------------}
{$IFDEF SHELLOBJ}
function QueryComp(const ATitle : string; var Computer : string; AParent : THandle) : boolean;
begin
  with TDCPathDialog.Create(nil) do
    try
      ParentWindow := AParent;
      Title := ATitle;
      Flags := [pdfBROWSEFORCOMPUTER];
      Root := pdrNETWORK;
      result := Execute;
      if result then
        Computer := SelectedItem;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function QueryDir(const ATitle : string; var ADirectory : string; AParent : THandle) : boolean;
begin
  with TDCPathDialog.Create(nil) do
    try
      SelectedItem := ADirectory;
      ParentWindow := AParent;
      Title := ATitle;
      result := Execute;
      if result then
        ADirectory := SelectedItem;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}
{$ENDIF}

{$IFDEF WIN}

Function GetTemporaryPath:String;
{$IFNDEF CLX}
Var
  PathLen:Integer;
Begin
  SetLength(Result, MAX_PATH);
  PathLen := GetTempPath(MAX_PATH,PChar(Result));
  If PathLen>3 Then //skip for drive:\ (c:\)
    Dec(PathLen);
  SetLength(Result,PathLen);
{$ELSE}
Begin
  result := '\tmp\';
{$ENDIF}
End;

{-------------------------------------------------------------------------}


{$IFNDEF CLX}
function ExecuteDialog(DialogID : integer) : boolean;
begin
  with TResDialog.Create(DialogID) do
    try
      result := Execute;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

function StringFromGUID(const GUID : TGUID): string;
var
  P : PWideChar;
begin
  StringFromCLSID(GUID, P);
  Result := {$IFNDEF D3}WideCharToString(P){$ELSE}P{$ENDIF};
  CoTaskMemFree(P);
end;

{-------------------------------------------------------------------------}

function GetUniqueString(const Prefix : string) : string;
var
  guid : TGUID;
begin
  CoCreateGUID(guid);
  result := Prefix + StringFromGUID(guid);
end;

{-------------------------------------------------------------------------}

//HKEY_LOCAL_MACHINE\'Software\Microsoft\Windows\CurrentVersion\Uninstall\application-name

function CreateRegKey(Root : THandle; const KeyName : string) : HKEY;
var
  res : HKEY;
begin
  if RegCreateKeyEx(Root, PChar(KeyName), 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, result, @res) <> ERROR_SUCCESS then
    result := 0;
end;

{-------------------------------------------------------------------------}

procedure ChangeRegStrValue(Key : HKEY; const Name, Value : string);
begin
  RegSetValueEx(Key, PChar(Name), 0, REG_SZ, PChar(Value), length(Value));
end;

{-------------------------------------------------------------------------}

procedure AddInstalledPackage(DelphiVer : TDelphiVer; const PName, FileName : string);
var
  h : HKEY;
  regpath : string;
begin
  regpath := GetDelphiPackagesKey(DelphiVer);
  h := CreateRegKey(HKEY_CURRENT_USER, regpath);
  if h <> 0 then
    try
      ChangeRegStrValue(h, FileName, pname);
    finally
      RegCloseKey(h);
    end;
end;

{-------------------------------------------------------------------------}

procedure OpenUnInstallKeys(const AppName : string; var key1, key2 : HKEY);
var
  res  : DWORD;
begin
  key1 := 0;
  key2 := 0;

  if RegCreateKeyEx(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall', 0, nil, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, key1, @res) = ERROR_SUCCESS then //don't resource
    key2 := CreateRegKey(key1, AppName);
end;

{-------------------------------------------------------------------------}

procedure RemoveUninstallFilesInfo(const AppName : string);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + AppName, True);
      try
        DeleteKey('Files');
      finally
        CloseKey;
      end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure GetUninstallFilesInfo(const AppName : string; Values : TStringList);
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + AppName + '\Files', True);
      try
        GetValueNames(Values);
      finally
        CloseKey;
      end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure AddUnInstallFilesInfo(const AppName : string; InfoValues : TStringList);
var
  i        : integer;
Begin
  with TRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + AppName + '\Files', True);
      with InfoValues do
        try
          for i := 0 to Count - 1 do
            WriteInteger(Strings[i], 0);
        finally
          CloseKey;
        end;
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure AddUnInstallInfo(const AppName, InfoName, InfoValue : string);
var
  key1 : HKEY;
  key2 : HKEY;
begin
  OpenUnInstallKeys(AppName, key1, key2);
  if key2 <> 0 then
    ChangeRegStrValue(key2, InfoName, InfoValue);

  RegCloseKey(key2);
  RegCloseKey(key1);
end;

{-------------------------------------------------------------------------}

function IsAppInstalled(const AppName : string) : boolean;
var
  key1 : HKEY;
begin
  key1 := 0;
  result := RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + AppName), //don't resource
                         0, KEY_ALL_ACCESS, key1) = ERROR_SUCCESS;
  RegCloseKey(key1);
end;

{-------------------------------------------------------------------------}

function GetUnInstallInfo(const AppName, InfoName : string) : string;
var
  key1 : HKEY;
  key2 : HKEY;
  rt   : DWORD;
  size : DWORD;
begin
  OpenUnInstallKeys(AppName, key1, key2);
  if key2 <> 0 then
    begin
      if RegQueryValueEx(key2, PChar(InfoName), nil, @rt, nil, @Size) = ERROR_SUCCESS then
        begin
          SetLength(result, size);
          RegQueryValueEx(key2, PChar(InfoName), nil, @rt, @(result[1]), @Size);
        end;
    end;

  RegCloseKey(key2);
  RegCloseKey(key1);
end;

{-------------------------------------------------------------------------}

procedure AddUnInstaller(const AppName, UninstallApp : string);
var
  key1 : HKEY;
  key2 : HKEY;
begin
  OpenUnInstallKeys(AppName, key1, key2);
  if key2 <> 0 then
    begin
      RegSetValueEx(key2, 'DisplayName', 0, REG_SZ, PChar(AppName), length(AppName)); //don't resource
      RegSetValueEx(key2, 'UninstallString', 0, REG_SZ, PChar(UninstallApp), length(UninstallApp));  //don't resource
    end;

  RegCloseKey(key2);
  RegCloseKey(key1);
end;

{-------------------------------------------------------------------------}

procedure RemoveUnInstaller(const DisplayName : string);
var
  key : HKEY;
//  recip : dword;
begin
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Uninstall', 0, KEY_ALL_ACCESS, key) <> ERROR_SUCCESS then //don't resource
    exit;

  RegDeleteKey(key, PChar(DisplayName));
  RegFlushKey(key);
  RegCloseKey(key);
//  BroadcastSystemMessage(BSF_IGNORECURRENTTASK, @recip, WM_SETTINGCHANGE, 0, 0);
end;

{-------------------------------------------------------------------------}

function GetResData(const ResName : string; var Data : pointer; var Length : integer) : THandle;
var
  rhandle : THandle;
begin
  rhandle := FindResource(hInstance, PChar(ResName), RT_RCDATA);
  result := LoadResource(hInstance, rhandle);
  Data := LockResource(result);
  Length := SizeOfResource(hInstance, rhandle);
end;

{-------------------------------------------------------------------------}

procedure ReleaseResData(Handle : THandle);
begin
  UnlockResource(Handle);
  FreeResource(Handle);
end;

{-------------------------------------------------------------------------}

procedure AddRCDataResource(const FileName, ResName : string; Value : pointer; Size : integer);
var
  h : THandle;
begin
  h := BeginUpdateResource(PChar(FileName), false);
  if h = 0 then
    exit;

  UpdateResource(h, RT_RCDATA, PChar(ResName), 0, Value, Size);
  EndUpdateResource(h, false);
end;

{-------------------------------------------------------------------------}

procedure AddStringResource(const FileName, ResName : string; const Value : String);
begin
  if Value = '' then
    exit;

  AddRCDataResource(FileName, ResName, PChar(Value), length(Value));
end;


{-------------------------------------------------------------------------}

function GetTemporaryFileName(const Prefix : string) : string;
var
  FileName : array[0..1023] of char;
begin
  GetTempFileName(PChar(GetTemporaryPath),PChar(Prefix), 0, FileName);
  result := FileName;
end;

{-------------------------------------------------------------------------}

function LoadStringFromRCData(const ResName : string) : string;
var
  rhandle : THandle;
  data    : PChar;
  size    : integer;
begin
  rhandle := GetResData(ResName, pointer(data), size);
  try
    SetString(result, data, size);
  finally
    ReleaseResData(rhandle);
  end;
end;

{-------------------------------------------------------------------------}

function  SystemDirectory : string;
var
  buffer : array[0..MAX_PATH] of char;
begin
  GetSystemDirectory(buffer, sizeof(buffer));
  result := AddSlash(StrPas(buffer));
end;

{-------------------------------------------------------------------------}

function  WindowsDirectory : string;
var
  buffer : array[0..MAX_PATH] of char;
begin
  GetWindowsDirectory(buffer, sizeof(buffer));
  result := AddSlash(StrPas(buffer));
end;

{-------------------------------------------------------------------------}

function ProgramFilesDirectory : string;
begin
  result := ExtractFileDrive(WindowsDirectory) + '\Program Files\'; //don't resource
end;

{$ENDIF CLX}
{$ENDIF WIN}

{-------------------------------------------------------------------------}
{$IFDEF SHELLOBJ}
procedure CreateLink(const LinkFile, LinkObject, Description, WorkingFolder : string);
var
 shlink : IShellLink;
 ipfile : IPersistFile;
 ws     : PWideChar;
begin
  CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER or CLSCTX_INPROC_HANDLER, {$IFDEF D3}IShellLink{$ELSE}IID_IShellLink{$ENDIF}, shlink);

  if shlink = nil then
    exit;

  shlink.SetPath(PChar(LinkObject));
  if Description <> '' then
    shlink.SetDescription(PChar(Description));

  if WorkingFolder <> '' then
    shlink.SetWorkingDirectory(PChar(WorkingFolder));

  shlink.QueryInterface({$IFDEF D3}IPersistFile{$ELSE}IID_IPersistFile{$ENDIF}, ipfile);
  ws := DCStringToOleSt(LinkFile);
  try
    ipfile.Save(ws, true);
  finally
    SysFreeString(ws);
  end;

end;

{-------------------------------------------------------------------------}

function StartMenuProgramsFolder : string;
var
 idl    : PItemIDList;
 malloc : IMalloc;
 buffer : array[0..1000] of char;
begin
  SHGetSpecialFolderLocation(0, CSIDL_PROGRAMS, idl);
  SHGetPathFromIDList({$IFDEF D3}idl{$ELSE}idl^{$ENDIF}, @buffer);
  result := AddSlash(StrPas(buffer));
  SHGetMalloc(malloc);
  malloc.Free(idl);
end;

{-------------------------------------------------------------------------}
{$ENDIF}
procedure Replace(var s : string; index : integer; const OldStr, NewStr : string);
begin
  Delete(s, index, length(OldStr));
  Insert(NewStr, s, index);
end;

{-------------------------------------------------------------------------}

type
  TStringFunction = function : string;

  TTemplateInfo = record
    Name : string;
    Func : TStringFunction;
  end;

function ProcessStringTemplates(const Source : string; Templates : array of TTemplateInfo) : string;
var
  i : integer;
  p : integer;
begin
  result := Source;

  for i := Low(Templates) to High(Templates) do
    with Templates[i] do
      repeat
        p := pos(name, result);
        if p > 0 then
          Replace(result, p, name, func);

      until p <= 0;
end;

{-------------------------------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

const
  FileTemplateCount = 8;
  FileTemplates : array[1 .. FileTemplateCount] of TTemplateInfo =
  (
   (name : '%SYSTEM%';       Func : SystemDirectory),      //don't resource
   (name : '%WINDOWS%';      Func : WindowsDirectory),     //don't resource
   (name : '%PROGRAMFILES%'; Func : ProgramFilesDirectory),//don't resource

   (name : '%C1_HELP%';      Func : GetC1HelpFolder),      //don't resource
   (name : '%C3_HELP%';      Func : GetC3HelpFolder),      //don't resource
   (name : '%D2_HELP%';      Func : GetD2HelpFolder),      //don't resource
   (name : '%D3_HELP%';      Func : GetD3HelpFolder),      //don't resource
   (name : '%D4_HELP%';      Func : GetD4HelpFolder)       //don't resource
  );

function ProcessFileTemplate(const ATemplate : string) : string;
begin
  result := ProcessStringTemplates(ATemplate, FileTemplates);
end;

{-----------------------------------------------------------}

const
  A2 = 'TAlignPalette'; //don't resource
  A3 = 'TPropertyInspector'; //don't resource
  A4 = 'TAppBuilder'; //don't resource

function DelphiRunning : boolean;
var
  H2, H3, H4 : Hwnd;
begin
  H2 := FindWindow(A2, nil);
  H3 := FindWindow(A3, nil);
  H4 := FindWindow(A4, nil);
  Result := (H2 <> 0) and (H3 <> 0) and (H4 <> 0);
end;

{-----------------------------------------------------------}

function InstallCheckDelphiRunning(const AppName : string) : boolean;
begin
  result := not DelphiRunning or
    (MessageBox(0, PChar(Format(sErrDelphiRunning, [AppName])), sCaptionInstallWarning, MB_OKCANCEL + MB_ICONERROR) = ID_OK);
end;

{-----------------------------------------------------------}

function  InstallCheckPrevVersion(const AppName : string) : boolean;
begin
  result := not IsAppInstalled(AppName) or
    (MessageBox(0, PChar(Format(sErrPrevVersion, [AppName, AppName])), sCaptionInstallError, MB_OKCANCEL + MB_ICONERROR) = ID_OK);
end;

{-----------------------------------------------------------}

procedure RunBatFile(const FileName:String);
begin
  RunBatFileEx(FileName,False);
end;

{-----------------------------------------------------------}

function RunBatFileEx(const FileName:String;Wait:boolean) : DWORD;
var
  si : TStartupInfo;
  pi : TProcessInformation;
begin
  FillChar(si, sizeof(si), 0);
  si.cb := sizeof(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_HIDE;
  CreateProcess(nil, pchar(FileName), nil, nil, false,
        NORMAL_PRIORITY_CLASS, nil, nil, si, pi);
  If Wait then
    WaitForSingleObject(pi.HProcess,INFINITE);

  GetExitCodeProcess(pi.hProcess, result);
  CloseHandle(pi.hProcess);
end;

{-----------------------------------------------------------}

procedure RemoveFile(const FileName : string);
var
  fname   : string;
  batfile : text;
  QuoteFileName : string;
begin
   if sysutils.DeleteFile(FileName) then
     exit;

   QuoteFileName := Quote(FileName, '"');
   fname := AddSlash(ExtractFileDir(FileName)) + '$delme.bat';
   Assign(batfile, fname);
   rewrite(batfile);
   writeln(batfile, ':Repeat');
   writeln(batfile, 'del ' + QuoteFileName);
   writeln(batfile, 'del ' + QuoteFileName+' /aH');
   writeln(batfile, 'if exist ' + QuoteFileName + ' goto Repeat');
   fname := Quote(fname, '"');
   writeln(batfile, 'del ' + fname);
   close(batfile);

   RunBatFile(FName);
end;

{------------------------------------------------------------}

const
 sIndex = ':Index ';

procedure AddHelpToCntFile(const HelpFile, HelpName, CntFile : string);
var
  s : TStringList;
  i : integer;

  procedure scanindexlines(match : boolean);
  begin
    while (i < s.Count) and (pos(sIndex, s[i]) = ord(match)) do
      inc(i);
  end;

begin
  RemoveHelpFromCntFile(HelpFile, CntFile);
  s := TStringList.Create;
  with s do
    try
      LoadFromFile(CntFile);
      i := 0;
      scanindexlines(false);
      scanindexlines(true);

      s.Insert(i, sIndex + HelpName + ' =' + HelpFile);
      SaveToFile(CntFile);
    finally
      Free;
    end;
end;

{------------------------------------------------------------}

procedure RemoveHelpFromCntFile(const HelpFile, CntFile : string);
var
  s : TStringList;
  i : integer;
begin
  s := TStringList.Create;
  with s do
    try
      LoadFromFile(CntFile);
      i := IndexOfValue(s, HelpFile);
      if i >= 0 then
        begin
          s.Delete(i);
          SaveToFile(CntFile);
        end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------}

{$ENDIF}
{$ENDIF}

function ExtractNamePart(const S:String):String;
begin
  Result:=ExtractNamePartEx(S,'=');//don't resource
end;

{--------------------------------------------------}

function ExtractNamePartEx(const S,Separator:String):String;
Var
  P:Integer;
begin
  P:=Pos(Separator,S);
  If P>0 then
    Result:=Copy(S,1,P-1)
  else
    Result:='';
end;

{--------------------------------------------------}

function ExtractValuePart(const S:String):String;
begin
  Result:=ExtractValuePartEx(S,'=');
end;

{--------------------------------------------------}

function ExtractValuePartEx(const S,Separator:String):String;
Var
  P:Integer;
begin
  P:=Pos(Separator,S);
  If P>0 then
    Result:=Copy(S,P+1,MaxInt)
  else
    Result:='';
end;

{--------------------------------------------------}

function IndexOfValue(S : TStrings; const Value : string) : integer;
begin
  for result := 0 to S.Count - 1 do
    if ExtractValuePart(S[result]) = Value then
      exit;

  result := -1;
end;

{------------------------------------------------------------------}

function QuoteFileName(const S:String):String;
begin
  Result:=Quote(S,'"');
end;

{------------------------------------------------------------------}

function Quote(const s : string; QuoteChar : char) : string;
begin
  result := QuoteChar + s + QuoteChar;
end;

{--------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}

const
  DelphiHelpFiles : array[TDelphiVer] of string =
  ('delphi.cnt', 'bcb.cnt', 'delphi3.cnt', 'bcb3.cnt', 'delphi4.cnt','bcb4.cnt','delphi5.cnt','bcb5.cnt','delphi6.cnt', 'bcb6.cnt', 'd7.cnt');

function  GetDelphiHelpCntFile(DelphiVer : TDelphiVer) : string;
begin
  result := GetDelphiHelpFolder(DelphiVer) + DelphiHelpFiles[DelphiVer];
end;


{-------------------------------------------------------------------------}

procedure CreateFolders(Folders:TStrings);
var
  i:Integer;
begin
  for i:=0 to Folders.Count-1 do
    CreateAllDirectories(Folders[i],nil);
end;

{--------------------------------------------------}

Function RunProgram(const CmdLine,WorkDir:String;Var ErrorMessage:String;
                    HookOutput{,CheckErrorCode}:Boolean):Boolean;
const
  SErrProgramFailed='Program failed with code (%d)';
Var
  ProcessInfo:TProcessInformation;
  StartupInfo:TStartupInfo;
  TempFile:String;
  AExitCode:DWORD;
  ErrorFile:TextFile;
  NextStr:String;
  Handle:THandle;
  SD:TSecurityAttributes;
  ErrorCode:Integer;
  Message:String;
Begin
  FillChar(StartupInfo,SizeOf(StartupInfo),0);
  StartupInfo.cb:=SizeOf(StartupInfo);
  If HookOutput Then
  Begin
    TempFile:=GetTemporaryFileName('tempfile');
    SD.nLength:=SizeOf(SD);
    SD.lpSecurityDescriptor:=Nil;
    SD.bInheritHandle:=True;
    Handle:=CreateFile(PChar(TempFile),GENERIC_WRITE,0,@SD,OPEN_EXISTING,FILE_ATTRIBUTE_ARCHIVE,0);
    StartupInfo.hStdOutput:=Handle;
    StartupInfo.dwFlags:=STARTF_USESTDHANDLES;
    StartupInfo.wShowWindow:=SW_HIDE;
    StartupInfo.dwFlags:=StartupInfo.dwFlags Or STARTF_USESHOWWINDOW;
  End
  Else
    Handle:=0;
  If Not CreateProcess(Nil,PChar(CmdLine),Nil,Nil,True,0,
                           Nil,Pointer(WorkDir),StartupInfo,ProcessInfo) Then
  Begin
    Result:=False;
    ErrorCode:=GetLastError;
    Message:=SysErrorMessage(ErrorCode);
    If Message<>'' Then
      ErrorMessage:=Message+'. ';
    ErrorMessage:=ErrorMessage+'ErrorCode='+IntToStr(ErrorCode);
    Exit;
  End;
  WaitForSingleObject(ProcessInfo.hProcess,INFINITE);
  If HookOutput Then
  Begin
    FileClose(Handle);
    AssignFile(ErrorFile,TempFile);
    Reset(ErrorFile);
    ErrorMessage:='';
    While Not Eof(ErrorFile) Do
    Begin
      Readln(ErrorFile,NextStr);
      ErrorMessage:=ErrorMessage+NextStr+#13#10;
    End;
    CloseFile(ErrorFile);
    DeleteFile(PChar(TempFile));
  End;
  GetExitCodeProcess(ProcessInfo.hProcess,AExitCode);
  WaitForInputIdle(ProcessInfo.hProcess, Infinite);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);
  Result:=AExitCode=0;
  ErrorMessage:=Format(SErrProgramFailed,[AExitCode])+#13#10+ErrorMessage;
End;

{--------------------------------------------------}
{$ENDIF}
{$ENDIF}

const
  PackageExts : array[TDelphiVer] of string =
   ('', '', '.DPL', '.BPL', '.BPL', '.BPL', '.BPL', '.BPL','.BPL', '.BPL', '.BPL');

function GetPackageExt(DelphiVer : TDelphiVer) : string;
begin
  result := PackageExts[DelphiVer];
end;

{--------------------------------------------------}

{$IFDEF WIN}
{$IFNDEF CLX}


Function ConvertErrors(const Errors:String):String;
Const
  StopTokens:Array[0..2] Of String=('Error:','Borland','Fatal:');
Var
  Data,BeginToken:PChar;

  Function FindEndLine(Data:PChar):PChar;
  Begin
    Result:=Data;
    While Not (Result^ In [#0,#10]) Do
      Inc(Result);
  End;

  Function IsStopToken(const Token:String):Boolean;
  Var
    I:Integer;
  Begin
    For I:=Low(StopTokens) To High(StopTokens) Do
      If CompareText(Token,StopTokens[I])=0 Then
      Begin
        Result:=True;
        Exit;
      End;
    Result:=False;
  End;
  Function GetWord:String;
  Var
    BeginToken:PChar;
  Begin
    While (Data^ In [' ']) Do
      Inc(Data);
    BeginToken:=Data;
    While Not (Data^ In [#0,#10,' ']) Do
      Inc(Data);
    If Data^=#0 Then
      Exit;
    SetLength(Result,Data-BeginToken);
    StrLCopy(PChar(Result),BeginToken,Data-BeginToken);
  End;

Var
  EndLine:PChar;
  Token:String;
  SaveLength:Integer;
Begin
  Data:=PChar(Errors);
  Result:='';
  While True Do
  Begin
    While Data^=' ' Do
      Inc(Data);
    If Data^=#0 Then
      Exit;
    BeginToken:=Data;
    EndLine:=FindEndLine(Data);
    Repeat
      Token:=GetWord;
      If IsStopToken(Token) Then
      Begin
        SaveLength:=Length(Result);
        SetLength(Result,Length(Result)+EndLine-BeginToken);
        StrLCopy(PChar(@Result[SaveLength+1]),BeginToken,EndLine-BeginToken);
      End;
      If Data^=#0 Then
        Exit
      Else
        If Data^=#10 Then
        Begin
          Data:=EndLine+1;
          Break;
        End;
    Until False;
  End;
End;

Type
  TVersionInfo=Record
    VerHigh,VerLow:Integer;
  End;

Function GetFileVersion(const FileName:String):TVersionInfo;
Var
  Dummy:DWord;
  Data:Pointer;
  VersionInfo:PVSFixedFileInfo;
  Size:Integer;
Begin
  Size:=GetFileVersionInfoSize(PChar(FileName),Dummy);
  If Size=0 Then
  Begin
    Result.VerHigh:=0;
    Result.VerLow:=0;
  End;
   GetMem(Data,Size);
  Try
    If Not GetFileVersionInfo(PChar(FileName),0,Size,Data) Then
    Begin
      Result.VerHigh:=0;
      Result.VerLow:=0;
      Exit;
    End;
    VerQueryValue(Data,'\',Pointer(VersionInfo),Dummy);
    With Result,VersionInfo^ Do
    Begin
      VerHigh:=dwFileVersionMS;
      VerLow:=dwFileVersionLS;
    End;
  Finally
    FreeMem(Data);
  End;
End;

function DelphiExecutable(const ver : TDelphiVer) : string;
begin
 if ver in [dvD2, dvD3, dvD4, dvD5,dvd6, dvd7] then
   result := 'delphi32'
 else
   result := 'bcb';
end;

Function VersionCorrect(DelphiVer:TDelphiVer):Boolean;
Var
  Executable:String;
  ReqVer:Integer;
  VersionInfo:TVersionInfo;
Begin
  Try
    ReqVer:=DelphiReqVer[DelphiVer];
    Executable:=GetSpecificDelphiDir(DelphiVer)+'Bin\'+DelphiExecutable(DelphiVer)+'.exe';
    VersionInfo:=GetFileVersion(Executable);
    result := (ReqVer = -1) or (ReqVer = VersionInfo.VerLow);
  Except
    Result:=False;
  End;
End;

Function CompileFile(DelphiVer:TDelphiVer;const FullFileName,OutDir:String;
                     var ResultFile : string; Var ErrorMessage:String):Boolean;
Var
  CompilerPath:String;
  Params:String;
  FilePath:String;
  FileName:String;
  FileExt:String;

  Procedure _MoveFile(const FileExt:String);
  Var
    Source,Dest:String;
  Begin
    Source:=ChangeFileExt(FullFileName,FileExt);
    Dest:=OutDir;
    If (Dest<>'') And (Dest[Length(Dest)]<>SlashString) Then
      Dest:=Dest+SlashString;
    Dest:=Dest+ChangeFileExt(FileName,FileExt);
    If FileExists(Dest) Then
      DeleteFile(PChar(Dest));
    If CompareText(ExtractFileDrive(Source),ExtractFileDrive(Dest))<>0 Then
    Begin
      CopyFile(PChar(Source),PChar(Dest),False);
      DeleteFile(PChar(Source));
    End
    Else
      MoveFile(PChar(Source),PChar(Dest));
    ResultFile := Dest;
  End;

  Procedure _DeleteFile(const FileExt:String);
  Begin
    DeleteFile(Pchar(ChangeFileExt(FullFileName,FileExt)));
  End;
Var
  CompFileName:String;
Begin
  CompilerPath:=GetSpecificDelphiDir(DelphiVer)+'Bin\';
  FilePath:=ExtractFilePath(FullFileName);
  FileName:=ExtractFileName(FullFileName);
  FileExt:=ExtractFileExt(FullFileName);
  Case DelphiVer Of
    dvD2,dvD3,dvD4,dvD5,dvd6, dvd7:
      Begin
        CompilerPath:=CompilerPath+'dcc32.exe';
        Params:='-q -b';
      End;
    dvC1,dvC3,dvC4,dvC5:
      Begin
        If CompareText(FileExt,'.pas')=0 Then
        Begin
          CompilerPath:=CompilerPath+'dcc32.exe';
          Params:='-q -b -JPHN';
        End
        Else
        Begin
          CompilerPath:=CompilerPath+'make.exe';
          Params:='-B -f';
        End;
      End;
  End;

  CompFileName:='"'+CompilerPath+'" '+Params+' ' + '"' + FullFileName + '"';
  Result:=RunProgram(CompFileName, FilePath, ErrorMessage, True{, True});
  If Not Result Then
  Begin
    ErrorMessage:=ConvertErrors(ErrorMessage);
    Exit;
  End;

  If CompareText(FileExt,'.pas')=0 Then
    _MoveFile('.dcu')
  Else If CompareText(FileExt,'.dpk')=0 Then
  Begin
    _MoveFile(GetPackageExt(DelphiVer));

    _DeleteFile('.dcu');
    _DeleteFile('.dcp');
  End
  Else If (CompareText(FileExt,'.bpk')=0) Or (CompareText(FileExt,'.mak')=0) Then
  Begin
    _MoveFile(GetPackageExt(DelphiVer));
    _DeleteFile('.tds');
    _DeleteFile('.obj');
  End
  Else If (CompareText(FileExt,'.dpr')=0) Then
    _MoveFile('.exe');
End;

{$ENDIF}
{$ENDIF}

function GetThisDelphiVer:TDelphiVer;
begin
  {$IFDEF D7}
  result := dvD7;
  {$ELSE}
  {$IFDEF D6}
  result := dvD6;
  {$ELSE}
  {$IFDEF CPB5}
  result := dvC5;
  {$ELSE}
  {$IFDEF D5}
  result := dvD5;
  {$ELSE}
  {$IFDEF CPB4}
  result := dvC4;
  {$ELSE}
  {$IFDEF D4}
  result := dvD4;
  {$ELSE}
  {$IFDEF CPB3}
  result := dvC3;
  {$ELSE}
  {$IFDEF D3}
  result := dvD3;
  {$ELSE}
  {$IFDEF CPB1}
  result := dvC1;
  {$ELSE}
  result := dvD2;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

{--------------------------------------}

function DCGetDelphiVerFromDefines(Defines:TStrings;var DelphiVer:TDelphiVer):boolean;
var
  i:Integer;
begin
  for i:=0 to Defines.Count-1 do
    if DCGetDelphiVerFromName(Defines[i],DelphiVer) then
    begin
      Result:=True;
      exit;
    end;
  Result:=False;
end;

{--------------------------------------}

function DCGetDelphiVerFromName(const DelphiName:String;var DelphiVer:TDelphiVer):boolean;
var
  i: TDelphiVer;
begin
  DelphiVer:=dvD5;
  for i := Low(cDCNativeVerDefine) to High(cDCNativeVerDefine) do
   if CompareText(cDCNativeVerDefine[i], DelphiName) = 0 then
   begin
     DelphiVer:=i;
     Result:=True;
     Exit;
   end;
  Result:=False;
end;

{------------------------------------------------------------------}

initialization
{$IFDEF WIN}
{$IFNDEF CLX}

  ResDialogs := TList.Create;
{$ENDIF}
{$ENDIF}

finalization
{$IFDEF WIN}
{$IFNDEF CLX}
  ResDialogs.Free;
  UnloadUnRAR;
{$ENDIF}
{$ENDIF}
end.



