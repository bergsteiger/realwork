// Delphi interface unit for UnRAR.dll
// Translated from unrar.h
// Use Delphi 2.0 and higher to compile this module
//
// Ported to Delphi by Eugene Kotlyarov, fidonet: 2:5058/26.9 ek@oris.ru
// Fixed version by Alexey Torgashin <alextp@mail.ru>, 2:5020/604.24@fidonet
//
// Revisions:
// Aug 2001 - changed call convention for TChangeVolProc and TProcessDataProc
//          - added RARGetDllVersion function, see comment below
//
// Jan 2002 - Added RARSetCallback  // eugene
//
// Oct 2002 - Added RARHeaderDataEx, RAROpenArchiveDataEx // eugene

unit UnRAR;

interface

uses Windows;

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
  ERAR_UNKNOWN        = 21;

  RAR_OM_LIST         =  0;
  RAR_OM_EXTRACT      =  1;

  RAR_SKIP            =  0;
  RAR_TEST            =  1;
  RAR_EXTRACT         =  2;

  RAR_VOL_ASK         =  0;
  RAR_VOL_NOTIFY      =  1;

  RAR_DLL_VERSION     =  3;

  UCM_CHANGEVOLUME    =  0;
  UCM_PROCESSDATA     =  1;
  UCM_NEEDPASSWORD    =  2;

type
  RARHeaderData = record
    ArcName: array[0..Pred(260)] of AnsiChar;
    FileName: array[0..Pred(260)] of AnsiChar;
    Flags: UINT;
    PackSize: UINT;
    UnpSize: UINT;
    HostOS: UINT;
    FileCRC: UINT;
    FileTime: UINT;
    UnpVer: UINT;
    Method: UINT;
    FileAttr: UINT;
    CmtBuf: PAnsiChar;
    CmtBufSize: UINT;
    CmtSize: UINT;
    CmtState: UINT;
  end;

  RARHeaderDataEx = record
    ArcName: array [0..1023] of AnsiChar;
    ArcNameW: array [0..1023] of WideChar;
    FileName: array [0..1023] of AnsiChar;
    FileNameW: array [0..1023] of WideChar;
    Flags: UINT;
    PackSize: UINT;
    PackSizeHigh: UINT;
    UnpSize: UINT;
    UnpSizeHigh: UINT;
    HostOS: UINT;
    FileCRC: UINT;
    FileTime: UINT;
    UnpVer: UINT;
    Method: UINT;
    FileAttr: UINT;
    CmtBuf: PAnsiChar;
    CmtBufSize: UINT;
    CmtSize: UINT;
    CmtState: UINT;
    Reserved: array [0..1023] of UINT;
  end;

  RAROpenArchiveData = record
    ArcName: PAnsiChar;
    OpenMode: UINT;
    OpenResult: UINT;
    CmtBuf: PAnsiChar;
    CmtBufSize: UINT;
    CmtSize: UINT;
    CmtState: UINT;
  end;

  RAROpenArchiveDataEx = record
    ArcName: PAnsiChar;
    ArcNameW: PWideChar;
    OpenMode: UINT;
    OpenResult: UINT;
    CmtBuf: PAnsiChar;
    CmtBufSize: UINT;
    CmtSize: UINT;
    CmtState: UINT;
    Flags: UINT;
    Reserved: array [0..31] of UINT;
  end;

  TUnrarCallback = function (Msg: UINT; UserData, P1, P2: Integer) :Integer; stdcall;

const
  _unrar = 'unrar.dll';

{$IFDEF RARSTATIC}
function RAROpenArchive(var ArchiveData: RAROpenArchiveData): THandle;
  stdcall; external _unrar;
function RAROpenArchiveEx(var ArchiveData: RAROpenArchiveDataEx): THandle;
  stdcall; external _unrar;
function RARCloseArchive(hArcData: THandle): Integer;
  stdcall; external _unrar;
function RARReadHeader(hArcData: THandle; var HeaderData: RARHeaderData): Integer;
  stdcall; external _unrar;
function RARReadHeaderEx(hArcData: THandle; var HeaderData: RARHeaderDataEx): Integer;
  stdcall; external _unrar;
function RARProcessFile(hArcData: THandle; Operation: Integer; DestPath, DestName: PAnsiChar): Integer;
  stdcall; external _unrar;
procedure RARSetCallback(hArcData: THandle; UnrarCallback: TUnrarCallback; UserData: Integer);
  stdcall; external _unrar;
procedure RARSetPassword(hArcData: THandle; Password: PAnsiChar);
  stdcall; external _unrar;
{$ELSE}
 // Переведены не все функции !!!
const
 csRAROpenArchiveEx = 'RAROpenArchiveEx';
 csRARSetCallback = 'RARSetCallback';
 csRARCloseArchive = 'RARCloseArchive';
 csRARReadHeader = 'RARReadHeader';
 csRARProcessFile = 'RARProcessFile';

type
 TRAROpenArchiveExProc = function (var ArchiveData: RAROpenArchiveDataEx): THandle; stdcall;
 TRARSetCallbackProc = procedure (hArcData: THandle; UnrarCallback: TUnrarCallback; UserData: Integer); stdcall;
 TRARCloseArchiveProc = function (hArcData: THandle): Integer; stdcall;
 TRARReadHeaderProc = function (hArcData: THandle; var HeaderData: RARHeaderData): Integer; stdcall;
 TRARProcessFileProc = function (hArcData: THandle; Operation: Integer; DestPath, DestName: PAnsiChar): Integer; stdcall;

 TUnRarLibrary = class
 private
  f_DllH                 : THandle;
  f_RAROpenArchiveExProc : TRAROpenArchiveExProc;
  f_RARSetCallbackProc   : TRARSetCallbackProc;
  f_RARCloseArchiveProc  : TRARCloseArchiveProc;
  f_RARReadHeaderProc    : TRARReadHeaderProc;
  f_RARProcessFileProc   : TRARProcessFileProc;
 public
  constructor Create;
  function OpenRarArchiveEx(var ArchiveData: RAROpenArchiveDataEx): THandle;
  procedure SetRARCallback(hArcData: THandle; UnrarCallback: TUnrarCallback; UserData: Integer);
  function CloseRarArchive(hArcData: THandle): Integer;
  function ReadRARHeader (hArcData: THandle; var HeaderData: RARHeaderData): Integer;
  function ProcessRARFile(hArcData: THandle; Operation: Integer; DestPath, DestName: PAnsiChar): Integer;
  function InitDll: Boolean;
  procedure DeInitDll;
  destructor Destroy; override;
 end;
{$ENDIF RARSTATIC}

// Wrapper for DLL's function - old unrar.dll doesn't export RARGetDllVersion
// Returns: -1 = DLL not found; 0 = old ver. (C-style callbacks); >0 = new ver.
function RARGetDllVersion: integer;

// obsolete functions
type
  TChangeVolProc = function(ArcName: PAnsiChar; Mode: Integer): Integer; stdcall;
  TProcessDataProc = function(Addr: PUChar; Size: Integer): Integer; stdcall;

 // Заглушка для WinRar'а. Если понадобится обработка сообщений, то лучше написать свою!
function CallbackProc(msg: UINT; UserData, P1, P2: integer) :integer; stdcall;

function OutOpenArchiveError(Error: Integer; ArcName: AnsiString): AnsiString;

function OutProcessFileError(Error: Integer): AnsiString;

{$IFDEF RARSTATIC}
procedure RARSetChangeVolProc(hArcData: THandle; ChangeVolProc: TChangeVolProc);
  stdcall; external _unrar;
procedure RARSetProcessDataProc(hArcData: THandle; ProcessDataProc: TProcessDataProc);
  stdcall; external _unrar;
{$ENDIF RARSTATIC}

implementation

type
  TRARGetDllVersion = function: integer; stdcall;

function RARGetDllVersion: integer;
var
  h: THandle;
  f: TRARGetDllVersion;
begin
  h := LoadLibrary(_unrar);
  if h = 0 then begin 
    Result := -1; 
    Exit 
  end;
  f := GetProcAddress(h, 'RARGetDllVersion');
  if @f = nil then
    Result := 0
  else
    Result := f;
  FreeLibrary(h);
end;

{$IFNDEF RARSTATIC}
 function TUnRarLibrary.OpenRARArchiveEx(var ArchiveData: RAROpenArchiveDataEx): THandle;
 begin
  Result := f_RAROpenArchiveExProc(ArchiveData);
 end;

 procedure TUnRarLibrary.SetRARCallback(hArcData: THandle; UnrarCallback: TUnrarCallback; UserData: Integer);
 begin
  f_RARSetCallbackProc(hArcData, UnrarCallback, UserData);
 end;

 function TUnRarLibrary.CloseRarArchive(hArcData: THandle): Integer;
 begin
  Result := f_RARCloseArchiveProc(hArcData);
 end;

 function TUnRarLibrary.ReadRARHeader (hArcData: THandle; var HeaderData: RARHeaderData): Integer;
 begin
  Result := f_RARReadHeaderProc(hArcData, HeaderData);
 end;

 function TUnRarLibrary.ProcessRARFile(hArcData: THandle; Operation: Integer; DestPath, DestName: PAnsiChar): Integer;
 begin
  Result := f_RARProcessFileProc(hArcData, Operation, DestPath, DestName);
 end;

 function TUnRarLibrary.InitDll: Boolean;
 begin
  f_DllH := LoadLibrary(_unrar);
  if f_DllH = 0 then
  begin
   Result := False;
   Exit;
  end // if f_DllH = 0 then
  else
   Result := True;
  
  f_RAROpenArchiveExProc := GetProcAddress(f_DllH, csRAROpenArchiveEx);
  if @f_RAROpenArchiveExProc = nil then
  begin
   Result := False;
   DeInitDll;
   Exit;
  end; // if @f_RAROpenArchiveEx4Proc = nil then

  f_RARSetCallbackProc := GetProcAddress(f_DllH, csRARSetCallback);
  if @f_RARSetCallbackProc = nil then
  begin
   Result := False;
   DeInitDll;
   Exit;
  end; // if @f_RARSetCallbackProc = nil then

  f_RARCloseArchiveProc := GetProcAddress(f_DllH, csRARCloseArchive);
  if @f_RARCloseArchiveProc = nil then
  begin
   Result := False;
   DeInitDll;
   Exit;
  end; // if @f_RARCloseArchiveProc = nil then

  f_RARReadHeaderProc := GetProcAddress(f_DllH, csRARReadHeader);
  if @f_RARReadHeaderProc = nil then
  begin
   Result := False;
   DeInitDll;
   Exit;
  end; // if @f_RARReadHeaderProc = nil then

  f_RARProcessFileProc := GetProcAddress(f_DllH, csRARProcessFile);
  if @f_RARProcessFileProc = nil then
  begin
   Result := False;
   DeInitDll;
  end; // if @f_RARProcessFileProc = nil then
 end;

 procedure TUnRarLibrary.DeInitDll;
 begin
  if f_DllH <> 0 then
  begin
   FreeLibrary(f_DllH);
   f_DllH := 0;
  end; // if f_DllH <> 0 then
  f_RAROpenArchiveExProc := nil;
  f_RARSetCallbackProc := nil;
  f_RARCloseArchiveProc := nil;
  f_RARReadHeaderProc   := nil;
  f_RARProcessFileProc  := nil;
 end;

 constructor TUnRarLibrary.Create;
 begin
  inherited Create;
  f_DllH := 0;
 end;

 destructor TUnRarLibrary.Destroy;
 begin
  DeInitDll;
  inherited;
 end;
{$ENDIF RARSTATIC}

 function CallbackProc(msg: UINT; UserData, P1, P2: integer) :integer; stdcall;
 (*var
  Ch: Char;
  I: Integer;
  C: PAnsiChar;
  S: String;*)
 begin
  Result := 0;
  case msg of
    UCM_CHANGEVOLUME:
      (*if (P2 = RAR_VOL_ASK) then begin
        Write(CR, 'Insert disk with ', PAnsiChar(P1), ' and press ''Enter'' or enter ''Q'' to exit ');
        Readln(Ch);
        if (UpCase (Ch) = 'Q') then
          Result := -1;
      end;*)
      begin
       // Нет никаой обработки...
       Result := -1;
      end;
    UCM_NEEDPASSWORD:
      begin
        (*Write(CR, 'Please enter the password for this archive: ');
        Readln(S);
        C := PAnsiChar(S);
        Move(pointer(C)^, pointer(p1)^, StrLen(C) + 1);
          //+1 to copy the zero*)
        Result := -1;
      end;
    UCM_PROCESSDATA: begin
      (*if (UserData <> 0) and (PINT (UserData)^ = PRINT) then begin
        Flush (Output);
        // Windows.WriteFile fails on big data
        for I := 0 to P2 - 1 do
          Write(PAnsiChar(P1 + I)^);
        Flush (Output);
      end;*)
    end;
  end;
 end;

 function OutOpenArchiveError(Error: Integer; ArcName: AnsiString): AnsiString;
 begin
  case Error of
   ERAR_NO_MEMORY:   Result := 'Not enough memory';
   ERAR_EOPEN:       Result := 'Cannot open ' + ArcName;
   ERAR_BAD_ARCHIVE: Result := ArcName  + ' is not RAR archive';
   ERAR_BAD_DATA:    Result := ArcName + ': archive header broken';
   ERAR_UNKNOWN:     Result := 'Unknown error';
  end;
 end;

 function OutProcessFileError(Error: Integer): AnsiString;
 begin
  case Error of
   ERAR_UNKNOWN_FORMAT: Result := 'Unknown archive format';
   ERAR_BAD_ARCHIVE:    Result := 'Bad volume';
   ERAR_ECREATE:        Result := 'File create error';
   ERAR_EOPEN:          Result := 'Volume open error';
   ERAR_ECLOSE:         Result := 'File close error';
   ERAR_EREAD:          Result := 'Read error';
   ERAR_EWRITE:         Result := 'Write error';
   ERAR_BAD_DATA:       Result := 'CRC error';
   ERAR_UNKNOWN:        Result := 'Unknown error';
  end;
 end;

end.
