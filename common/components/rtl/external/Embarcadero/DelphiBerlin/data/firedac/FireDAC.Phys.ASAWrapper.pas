{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{   FireDAC Sybase SQL Anywhere API wrapping classes    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ASAWrapper;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes,
  FireDAC.Stan.Error, FireDAC.Stan.Util,
  FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper,
  FireDAC.Phys.ASACli;

type
  EASANativeException = class;
  TASAToolLib = class;
{$IFDEF MSWINDOWS}
  TASATool = class;
  TASABackup = class;
  TASAValidate = class;
{$ENDIF}

  EASANativeException = class(EODBCNativeException)
  public
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String; AKind: TFDCommandExceptionKind;
      ACmdOffset, ARowIndex: Integer): TFDDBError; override;
  end;

  TASAToolLib = class(TFDLibrary)
  protected
    procedure LoadEntries; override;
  public
    DBToolsInit: TDBToolsInit;
    DBToolsFini: TDBToolsFini;
    DBToolsVersion: TDBToolsVersion;
    DBBackup: TDBBackup;
    DBValidate: TDBValidate;
    constructor Create(AOwningObj: TObject = nil);
    procedure Load(const AToolLib: String);
  end;

{$IFDEF MSWINDOWS}
  TASAToolMessageKind = (tmMessage, tmError, tmStatus, tmConfirm);
  TASAToolMessageEvent = procedure (ASender: TObject; AMessage: String;
    AKind: TASAToolMessageKind; var AResult: Integer) of object;
  TASATool = class(TObject)
  private
    FLib: TASAToolLib;
    [weak] FOwningObj: TObject;
    FToolInfo: a_dbtools_info;
    FErrorThunk: TFDMethodThunk;
    FOnMessage: TASAToolMessageEvent;
    FError: String;
    FEncoder: TFDEncoder;
    function GetVersion: Integer;
  protected
    procedure Check(ACode: an_exit_code);
    procedure Init;
    procedure Fini;
    function DoMessage(str: Pa_char; AKind: TASAToolMessageKind): ShortInt;
    function DoMessageCallback(str: Pa_char): ShortInt; stdcall;
    function DoConfirmCallback(str: Pa_char): ShortInt; stdcall;
    function DoErrorCallback(str: Pa_char): ShortInt; stdcall;
    function DoStatusCallback(str: Pa_char): ShortInt; stdcall;
    function Strings2P_name(AStrs: TStrings): P_name;
    procedure DeleteP_name(APtr: P_name);
  public
    constructor Create(ALib: TASAToolLib; AOwningObj: TObject = nil);
    destructor Destroy; override;
    property Version: Integer read GetVersion;
    property OnMessage: TASAToolMessageEvent read FOnMessage write FOnMessage;
  end;

  TASABackupCheckpointLogType = (bclCopy, bclNoCopy, bclRecover, bclAuto, bclDefault);
  TASABackupFlags = set of (bfBackupDB, bfBackupLog, bfNoConfirm, bfQuiet, bfRenameLog,
    bfTruncateLog, bfRenameLocalLog, bfServerBackup, bfProgressMessages);
  TASABackup = class (TASATool)
  private
    FConnectParams: String;
    FCheckpointLogType: TASABackupCheckpointLogType;
    FPageBlocksize: Cardinal;
    FHotlogFilename: String;
    FOutputDir: String;
    FFlags: TASABackupFlags;
    FStartLine: String;
  public
    procedure Backup;
    property ConnectParams: String read FConnectParams write FConnectParams;
    property StartLine: String read FStartLine write FStartLine;
    property OutputDir: String read FOutputDir write FOutputDir;
    property HotlogFilename: String read FHotlogFilename write FHotlogFilename;
    property CheckpointLogType: TASABackupCheckpointLogType read FCheckpointLogType
      write FCheckpointLogType;
    property PageBlocksize: Cardinal read FPageBlocksize write FPageBlocksize;
    property Flags: TASABackupFlags read FFlags write FFlags;
  end;

  TASAValidateType = (vtNormal, vtData, vtIndex, vtExpress, vtFull, vtChecksum,
    vtDatabase, vtComplete);
  TASAValidateFlags = set of (vfQuiet, vfIndex);
  TASAValidate = class (TASATool)
  private
    FValidateType: TASAValidateType;
    FConnectParams: String;
    FStartLine: String;
    FTables: TStrings;
    FFlags: TASAValidateFlags;
    procedure SetTables(const AValue: TStrings);
  public
    constructor Create(ALib: TASAToolLib; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Validate;
    property ConnectParams: String read FConnectParams write FConnectParams;
    property StartLine: String read FStartLine write FStartLine;
    property Tables: TStrings read FTables write SetTables;
    property Flags: TASAValidateFlags read FFlags write FFlags;
    property ValidateType: TASAValidateType read FValidateType write FValidateType;
  end;
{$ENDIF}

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Intf;

{-------------------------------------------------------------------------------}
{ EASANativeException                                                           }
{-------------------------------------------------------------------------------}
function EASANativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
const
  C_SyntaxErrMsg1 = 'Syntax error or access violation: near ''';
  C_SyntaxErrMsg2 = 'Syntax error near ''';
var
  sObj: String;

  procedure ExtractObjName(ANum: Integer);
  var
    i1, i2: Integer;
  begin
    i2 := 1;
    repeat
      i1 := Pos('''', ADiagMessage, i2 + 1);
      if i1 <> 0 then begin
        i2 := Pos('''', ADiagMessage, i1 + 1);
        if i2 <> 0 then
          sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
      end;
      Dec(ANum);
    until (ANum = 0) or (i1 = 0);
  end;

  function ExtractCmdOffset1: Boolean;
  var
    sWord, sPhrase: String;
    i1, i2: Integer;
  begin
    Result := False;
    i1 := Pos(C_SyntaxErrMsg1, ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('''', ADiagMessage, i1 + Length(C_SyntaxErrMsg1));
      if i2 <> 0 then begin
        sWord := Copy(ADiagMessage, i1 + Length(C_SyntaxErrMsg1),
          i2 - i1 - Length(C_SyntaxErrMsg1));
        sPhrase := Copy(ADiagMessage, i2 + 5, Length(ADiagMessage));
        i1 := 1;
        while (i1 <= Length(sPhrase)) and (sPhrase[i1] = '.') do
          Inc(i1);
        i2 := Length(sPhrase);
        while (i2 >= 1) and (sPhrase[i2] = '.') do
          Dec(i2);
        sPhrase := Copy(sPhrase, i1, i2 - i1 + 1);
        i1 := 1;
        while i1 <= Length(sPhrase) do
          if (sPhrase[i1] = '[') or (sPhrase[i1] = ']') then
            Delete(sPhrase, i1, 1)
          else
            Inc(i1);
        ACmdOffset := Pos(sPhrase, ACommandText) + Pos(sWord, sPhrase) - 1;
        Result := True;
      end;
    end;
  end;

  function ExtractCmdOffset2: Boolean;
  var
    sWord: String;
    i1, i2: Integer;
  begin
    Result := False;
    i1 := Pos(C_SyntaxErrMsg2, ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('''', ADiagMessage, i1 + Length(C_SyntaxErrMsg2));
      if i2 <> 0 then begin
        sWord := Copy(ADiagMessage, i1 + Length(C_SyntaxErrMsg2),
          i2 - i1 - Length(C_SyntaxErrMsg2));
        ACmdOffset := Pos(sWord, ACommandText);
        Result := True;
      end;
    end;
  end;

begin
  sObj := AObject;
  case ANativeError of
  -299:
    AKind := ekCmdAborted;
  100:
    AKind := ekNoDataFound;
  -210,
  -1281:
    AKind := ekRecordLocked;
  -193:
    begin
      // first 'xxxx' - PK constraint name
      AKind := ekUKViolated;
      ExtractObjName(1);
    end;
  -196:
    begin
      AKind := ekUKViolated;
      // first 'xxxx' - PK table name
      // second 'xxxx' - PK constraint name
      ExtractObjName(2);
    end;
  -194:
    begin
      AKind := ekFKViolated;
      // first 'xxxx' - FK constraint name
      // second 'xxxx' - FK table name
      ExtractObjName(1);
    end;
  -198:
    begin
      AKind := ekFKViolated;
      // first 'xxxx' - PK table name
      // second 'xxxx' - FK constraint name
      // third 'xxxx' - FK table name
      ExtractObjName(2);
    end;
  -138,
  -141,
  -183,
  -265,
  -268,
  -771,
  -929,
  -1041,
  -1359:
    begin
      AKind := ekObjNotExists;
      ExtractObjName(1);
    end;
  -103:
    AKind := ekUserPwdInvalid;
  -1152,
  -1153:
    AKind := ekUserPwdExpired;
  -131:
    if not ExtractCmdOffset1 then
      ExtractCmdOffset2;
  -85,
  -100,
  -101,
  -308:
    AKind := ekServerGone;
  -154:
    AKind := ekInvalidParams;
  end;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, AResultMessage, ACommandText, sObj, AKind, ACmdOffset,
    ARowIndex);
end;

{-------------------------------------------------------------------------------}
{ TASAToolLib                                                                   }
{-------------------------------------------------------------------------------}
constructor TASAToolLib.Create(AOwningObj: TObject = nil);
begin
  inherited Create(S_FD_AsaID, AOwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TASAToolLib.Load(const AToolLib: String);
var
  aTools: array of String;
  i: Integer;
begin
  if AToolLib <> '' then begin
    SetLength(aTools, 1);
    aTools[0] := AToolLib;
  end
  else begin
    SetLength(aTools, 9);
    for i := 12 downto 5 do
      aTools[12 - i + 1] := Format(C_DBTool, [i]);
    aTools[0] := Format(C_DBTool, [16]);
  end;
  inherited Load(aTools, False);
end;

{-------------------------------------------------------------------------------}
procedure TASAToolLib.LoadEntries;
begin
  @DBToolsInit := GetProc('DBToolsInit');
  @DBToolsFini := GetProc('DBToolsFini');
  @DBToolsVersion := GetProc('DBToolsVersion');
  @DBBackup := GetProc('DBBackup');
  @DBValidate := GetProc('DBValidate');
end;

{-------------------------------------------------------------------------------}
{ TASATool                                                                      }
{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
constructor TASATool.Create(ALib: TASAToolLib; AOwningObj: TObject);
begin
  inherited Create;
  FLib := ALib;
  FOwningObj := AOwningObj;
  FErrorThunk := TFDMethodThunk.Create(Self, @TASATool.DoMessageCallback);
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TASATool.Destroy;
begin
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FErrorThunk);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TASATool.Check(ACode: an_exit_code);

  function GetErrorMessage: String;
  begin
    case ACode of
    EXIT_FAIL:                Result := 'General failure.';
    EXIT_BAD_DATA:            Result := 'Invalid file format, etc.';
    EXIT_FILE_ERROR:          Result := 'File not found, unable to open, etc.';
    EXIT_OUT_OF_MEMORY:       Result := 'Out of memory.';
    EXIT_BREAK:               Result := 'Terminated by user.';
    EXIT_COMMUNICATIONS_FAIL: Result := 'Failed communications.';
    EXIT_MISSING_DATABASE:    Result := 'Missing required db name.';
    EXIT_PROTOCOL_MISMATCH:   Result := 'Client/server protocol mismatch.';
    EXIT_UNABLE_TO_CONNECT:   Result := 'Unable to connect to db.';
    EXIT_ENGINE_NOT_RUNNING:  Result := 'Database not running.';
    EXIT_SERVER_NOT_FOUND:    Result := 'Server not running.';
    EXIT_BAD_ENCRYPT_KEY:     Result := 'Missing or bad encryption key.';
    EXIT_DB_VER_NEWER:	      Result := 'Server must be upgraded to run db.';
    EXIT_FILE_INVALID_DB:     Result := 'File is not a database.';
    EXIT_LOG_FILE_ERROR:      Result := 'Log file was missing or other log file error.';
    EXIT_FILE_IN_USE:	        Result := 'File in use.';
    EXIT_FATAL_ERROR:	        Result := 'Fatal error or assertion occurred.';
    EXIT_MISSING_LICENSE_FILE:    Result := 'Missing server license file.';
    EXIT_BACKGROUND_SYNC_ABORTED: Result := 'Background synchronization aborted.';
    EXIT_FILE_ACCESS_DENIED:  Result := 'Access to database file denied.';
    an_exit_code(EXIT_USAGE): Result := 'Invalid parameters on command line.';
    end;
  end;

var
  oExc: EASANativeException;
  sMsg: String;
begin
  if ACode = EXIT_OKAY then
    Exit;
  sMsg := GetErrorMessage;
  if FError <> '' then
    sMsg := sMsg + #13#10 + FError;
  FError := '';
  oExc := EASANativeException.Create(er_FD_ODBCGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_ASAId]) + ' ' + sMsg);
  EFDDBEngineException(oExc).AppendError(1, ACode, sMsg, '', ekOther, -1, -1);
  FDException(FOwningObj, oExc {$IFDEF FireDAC_Monitor}, False {$ENDIF});
end;

{-------------------------------------------------------------------------------}
function TASATool.DoMessage(str: Pa_char; AKind: TASAToolMessageKind): ShortInt;
var
  s: String;
  obj: TObject;
  iRes: Integer;
begin
  if AKind = tmConfirm then
    iRes := 1
  else
    iRes := 0;
  if str <> nil then begin
    s := FEncoder.Decode(str, -1);
    if AKind = tmError then
      FError := s;
    if Assigned(OnMessage) then begin
      if FOwningObj = nil then
        obj := Self
      else
        obj := FOwningObj;
      OnMessage(obj, s, AKind, iRes);
    end;
  end;
  Result := iRes;
end;

{-------------------------------------------------------------------------------}
function TASATool.DoMessageCallback(str: Pa_char): ShortInt; stdcall;
begin
  Result := DoMessage(str, tmMessage);
end;

{-------------------------------------------------------------------------------}
function TASATool.DoConfirmCallback(str: Pa_char): ShortInt; stdcall;
begin
  Result := DoMessage(str, tmConfirm);
end;

{-------------------------------------------------------------------------------}
function TASATool.DoErrorCallback(str: Pa_char): ShortInt; stdcall;
begin
  Result := DoMessage(str, tmError);
end;

{-------------------------------------------------------------------------------}
function TASATool.DoStatusCallback(str: Pa_char): ShortInt; stdcall;
begin
  Result := DoMessage(str, tmStatus);
end;

{-------------------------------------------------------------------------------}
procedure TASATool.Init;
begin
  FError := '';
  if not Assigned(FLib.DBToolsInit) then
    FDException(FOwningObj, [S_FD_LPhys, S_FD_ASAId], er_FD_ASADBToolNotFound, []);
  FillChar(FToolInfo, SizeOf(FToolInfo), 0);
  FToolInfo.errorrtn := FErrorThunk.CallAddress;
  Check(FLib.DBToolsInit(@FToolInfo));
end;

{-------------------------------------------------------------------------------}
procedure TASATool.Fini;
begin
  Check(FLib.DBToolsFini(@FToolInfo));
end;

{-------------------------------------------------------------------------------}
function TASATool.GetVersion: Integer;
begin
  if not Assigned(FLib.DBToolsVersion) then
    Result := -1
  else
    Result := FLib.DBToolsVersion();
end;

{-------------------------------------------------------------------------------}
function TASATool.Strings2P_name(AStrs: TStrings): P_name;
var
  i: Integer;
  pPrev: P_name;
  s: TFDByteString;
begin
  pPrev := nil;
  Result := nil;
  for i := AStrs.Count - 1 downto 0 do begin
    if AStrs[i] <> '' then begin
      s := FEncoder.Encode(AStrs[i]);
      GetMem(Result, SizeOf(P_name) + (Length(s) + 1) * SizeOf(TFDAnsiChar));
      Result^.next := pPrev;
      Move(PFDAnsiString(PByte(s))^, Result^.name[0],
        (Length(s) + 1) * SizeOf(TFDAnsiChar));
      pPrev := Result;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TASATool.DeleteP_name(APtr: P_name);
var
  pNext: P_name;
begin
  while APtr <> nil do begin
    pNext := APtr^.next;
    FreeMem(APtr);
    APtr := pNext;
  end;
end;

{-------------------------------------------------------------------------------}
{ TASABackup                                                                    }
{-------------------------------------------------------------------------------}
procedure TASABackup.Backup;
var
  rBackupInfo12: a_backup_db_v12;
  rBackupInfo11: a_backup_db_v11;
  rBackupInfo10: a_backup_db_v10;
  rBackupInfo9: a_backup_db_v9;
  pBackupInfo: P_backup_db;
  oConfirmThunk: TFDMethodThunk;
  oErrorThunk: TFDMethodThunk;
  oMessageThunk: TFDMethodThunk;
  oStatusThunk: TFDMethodThunk;
  sOutDir, sConPars, sHotName, sStartLine: TFDByteString;

  function FlagsToMask1: a_bit_field;
  begin
    Result := 0;
    if bfBackupDB in Flags then
      Result := Result or CBDB_F1_backup_database;
    if bfBackupLog in Flags then
      Result := Result or CBDB_F1_backup_logfile;
    if bfNoConfirm in Flags then
      Result := Result or CBDB_F1_no_confirm;
    if bfQuiet in Flags then
      Result := Result or CBDB_F1_quiet;
    if bfRenameLog in Flags then
      Result := Result or CBDB_F1_rename_log;
    if bfTruncateLog in Flags then
      Result := Result or CBDB_F1_truncate_log;
    if bfRenameLocalLog in Flags then
      Result := Result or CBDB_F1_rename_local_log;
  end;

  function FlagsToMask2: a_bit_field;
  begin
    Result := 0;
    if bfServerBackup in Flags then
      Result := Result or CBDB_F2_server_backup;
  end;

  function FlagsToMask3: a_bit_short;
  begin
    Result := 0;
    if bfBackupDB in Flags then
      Result := Result or CBDB_F3_backup_database;
    if bfBackupLog in Flags then
      Result := Result or CBDB_F3_backup_logfile;
    if bfNoConfirm in Flags then
      Result := Result or CBDB_F3_no_confirm;
    if bfQuiet in Flags then
      Result := Result or CBDB_F3_quiet;
    if bfRenameLog in Flags then
      Result := Result or CBDB_F3_rename_log;
    if bfTruncateLog in Flags then
      Result := Result or CBDB_F3_truncate_log;
    if bfRenameLocalLog in Flags then
      Result := Result or CBDB_F3_rename_local_log;
    if bfProgressMessages in Flags then
      Result := Result or CBDB_F3_progress_messages;
  end;

begin
  Init;
  oConfirmThunk := TFDMethodThunk.Create(Self, @TASABackup.DoConfirmCallback);
  oErrorThunk := TFDMethodThunk.Create(Self, @TASABackup.DoErrorCallback);
  oMessageThunk := TFDMethodThunk.Create(Self, @TASABackup.DoMessageCallback);
  oStatusThunk := TFDMethodThunk.Create(Self, @TASABackup.DoStatusCallback);
  try
    if FLib.Version >= cvSybaseASA12 then begin
      FillChar(rBackupInfo12, SizeOf(a_backup_db_v12), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rBackupInfo12.version := FLib.Version div 100000;
      rBackupInfo12.errorrtn := oErrorThunk.CallAddress;
      rBackupInfo12.msgrtn := oMessageThunk.CallAddress;
      rBackupInfo12.confirmrtn := oConfirmThunk.CallAddress;
      rBackupInfo12.statusrtn := oStatusThunk.CallAddress;
      sOutDir := FEncoder.Encode(FOutputDir);
      rBackupInfo12.output_dir := Pa_char(PByte(sOutDir));
      sConPars := FEncoder.Encode(FConnectParams);
      rBackupInfo12.connectparms := Pa_char(PByte(sConPars));
      sHotName := FEncoder.Encode(FHotlogFilename);
      rBackupInfo12.hotlog_filename := Pa_char(PByte(sHotName));
      rBackupInfo12.page_blocksize := FPageBlocksize;
      rBackupInfo12.chkpt_log_type := a_char(FCheckpointLogType);
      rBackupInfo12.flags1 := FlagsToMask3();
      pBackupInfo := @rBackupInfo12;
    end
    else if FLib.Version >= cvSybaseASA11 then begin
      FillChar(rBackupInfo11, SizeOf(a_backup_db_v11), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rBackupInfo11.version := FLib.Version div 100000;
      sOutDir := FEncoder.Encode(FOutputDir);
      rBackupInfo11.output_dir := Pa_char(PByte(sOutDir));
      sConPars := FEncoder.Encode(FConnectParams);
      rBackupInfo11.connectparms := Pa_char(PByte(sConPars));
      rBackupInfo11.confirmrtn := oConfirmThunk.CallAddress;
      rBackupInfo11.errorrtn := oErrorThunk.CallAddress;
      rBackupInfo11.msgrtn := oMessageThunk.CallAddress;
      rBackupInfo11.statusrtn := oStatusThunk.CallAddress;
      rBackupInfo11.flags1 := FlagsToMask1();
      rBackupInfo11.flags2 := FlagsToMask2();
      sHotName := FEncoder.Encode(FHotlogFilename);
      rBackupInfo11.hotlog_filename := Pa_char(PByte(sHotName));
      rBackupInfo11.chkpt_log_type := a_chkpt_log_type(FCheckpointLogType);
      rBackupInfo11.page_blocksize := FPageBlocksize;
      pBackupInfo := @rBackupInfo11;
    end
    else if FLib.Version >= cvSybaseASA10 then begin
      FillChar(rBackupInfo10, SizeOf(a_backup_db_v10), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rBackupInfo10.version := FLib.Version div 100000;
      sOutDir := FEncoder.Encode(FOutputDir);
      rBackupInfo10.output_dir := Pa_char(PByte(sOutDir));
      sConPars := FEncoder.Encode(FConnectParams);
      rBackupInfo10.connectparms := Pa_char(PByte(sConPars));
      rBackupInfo10.confirmrtn := oConfirmThunk.CallAddress;
      rBackupInfo10.errorrtn := oErrorThunk.CallAddress;
      rBackupInfo10.msgrtn := oMessageThunk.CallAddress;
      rBackupInfo10.statusrtn := oStatusThunk.CallAddress;
      rBackupInfo10.flags1 := FlagsToMask1();
      rBackupInfo10.flags2 := FlagsToMask2();
      sHotName := FEncoder.Encode(FHotlogFilename);
      rBackupInfo10.hotlog_filename := Pa_char(PByte(sHotName));
      rBackupInfo10.chkpt_log_type := a_chkpt_log_type(FCheckpointLogType);
      rBackupInfo10.page_blocksize := FPageBlocksize;
      pBackupInfo := @rBackupInfo10;
    end
    else begin
      FillChar(rBackupInfo9, SizeOf(a_backup_db_v9), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rBackupInfo9.version := FLib.Version div 100000;
      sOutDir := FEncoder.Encode(FOutputDir);
      rBackupInfo9.output_dir := Pa_char(PByte(sOutDir));
      sConPars := FEncoder.Encode(FConnectParams);
      rBackupInfo9.connectparms := Pa_char(PByte(sConPars));
      sStartLine := FEncoder.Encode(FStartLine);
      rBackupInfo9.startline := Pa_char(PByte(sStartLine));
      rBackupInfo9.confirmrtn := oConfirmThunk.CallAddress;
      rBackupInfo9.errorrtn := oErrorThunk.CallAddress;
      rBackupInfo9.msgrtn := oMessageThunk.CallAddress;
      rBackupInfo9.statusrtn := oStatusThunk.CallAddress;
      rBackupInfo9.flags1 := FlagsToMask1();
      sHotName := FEncoder.Encode(FHotlogFilename);
      rBackupInfo9.hotlog_filename := Pa_char(PByte(sHotName));
      pBackupInfo := @rBackupInfo9;
    end;
    Check(FLib.DBBackup(pBackupInfo));
  finally
    FDFree(oConfirmThunk);
    FDFree(oErrorThunk);
    FDFree(oMessageThunk);
    FDFree(oStatusThunk);
    Fini;
  end;
end;

{-------------------------------------------------------------------------------}
{ TASAValidate                                                                  }
{-------------------------------------------------------------------------------}
constructor TASAValidate.Create(ALib: TASAToolLib; AOwningObj: TObject);
begin
  inherited Create(ALib, AOwningObj);
  FTables := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TASAValidate.Destroy;
begin
  FDFreeAndNil(FTables);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TASAValidate.SetTables(const AValue: TStrings);
begin
  FTables.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TASAValidate.Validate;
var
  rValidateInfo12: a_validate_db_v12;
  rValidateInfo11: a_validate_db_v11;
  rValidateInfo10: a_validate_db_v10;
  rValidateInfo9: a_validate_db_v9;
  rValidateInfo5: a_validate_db_v5;
  pValidateInfo: P_validate_db;
  oErrorThunk: TFDMethodThunk;
  oMessageThunk: TFDMethodThunk;
  oStatusThunk: TFDMethodThunk;
  sConPars, sStartLine: TFDByteString;

  function FlagsToMask1: a_bit_field;
  begin
    Result := 0;
    if vfQuiet in Flags then
      Result := Result or CVDB_F1_quiet;
    if vfIndex in Flags then
      Result := Result or CVDB_F1_index;
  end;

begin
  Init;
  oErrorThunk := TFDMethodThunk.Create(Self, @TASAValidate.DoErrorCallback);
  oMessageThunk := TFDMethodThunk.Create(Self, @TASAValidate.DoMessageCallback);
  oStatusThunk := TFDMethodThunk.Create(Self, @TASAValidate.DoStatusCallback);
  try
    if FLib.Version >= cvSybaseASA12 then begin
      FillChar(rValidateInfo12, SizeOf(a_validate_db_v12), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rValidateInfo12.version := FLib.Version div 100000;
      rValidateInfo12.errorrtn := oErrorThunk.CallAddress;
      rValidateInfo12.msgrtn := oMessageThunk.CallAddress;
      rValidateInfo12.statusrtn := oStatusThunk.CallAddress;
      sConPars := FEncoder.Encode(FConnectParams);
      rValidateInfo12.connectparms := Pa_char(PByte(sConPars));
      rValidateInfo12.tables := Strings2P_name(FTables);
      rValidateInfo12._type := a_validate_type(FValidateType);
      rValidateInfo12.flags1 := FlagsToMask1();
      pValidateInfo := @rValidateInfo12;
    end
    else if FLib.Version >= cvSybaseASA11 then begin
      FillChar(rValidateInfo11, SizeOf(a_validate_db_v11), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rValidateInfo11.version := FLib.Version div 100000;
      sConPars := FEncoder.Encode(FConnectParams);
      rValidateInfo11.connectparms := Pa_char(PByte(sConPars));
      rValidateInfo11.tables := Strings2P_name(FTables);
      rValidateInfo11.errorrtn := oErrorThunk.CallAddress;
      rValidateInfo11.msgrtn := oMessageThunk.CallAddress;
      rValidateInfo11.statusrtn := oStatusThunk.CallAddress;
      rValidateInfo11.flags1 := FlagsToMask1();
      rValidateInfo11._type := a_validate_type(FValidateType);
      pValidateInfo := @rValidateInfo11;
    end
    else if FLib.Version >= cvSybaseASA10 then begin
      FillChar(rValidateInfo10, SizeOf(a_validate_db_v10), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rValidateInfo10.version := FLib.Version div 100000;
      sConPars := FEncoder.Encode(FConnectParams);
      rValidateInfo10.connectparms := Pa_char(PByte(sConPars));
      rValidateInfo10.tables := Strings2P_name(FTables);
      rValidateInfo10.errorrtn := oErrorThunk.CallAddress;
      rValidateInfo10.msgrtn := oMessageThunk.CallAddress;
      rValidateInfo10.statusrtn := oStatusThunk.CallAddress;
      rValidateInfo10.flags1 := FlagsToMask1();
      rValidateInfo10._type := a_validate_type(FValidateType);
      pValidateInfo := @rValidateInfo10;
    end
    else if FLib.Version >= cvSybaseASA6 then begin
      FillChar(rValidateInfo9, SizeOf(a_validate_db_v9), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rValidateInfo9.version := FLib.Version div 100000;
      sConPars := FEncoder.Encode(FConnectParams);
      rValidateInfo9.connectparms := Pa_char(PByte(sConPars));
      sStartLine := FEncoder.Encode(FConnectParams);
      rValidateInfo9.startline := Pa_char(PByte(sStartLine));
      rValidateInfo9.tables := Strings2P_name(FTables);
      rValidateInfo9.errorrtn := oErrorThunk.CallAddress;
      rValidateInfo9.msgrtn := oMessageThunk.CallAddress;
      rValidateInfo9.statusrtn := oStatusThunk.CallAddress;
      rValidateInfo9.flags1 := FlagsToMask1();
      rValidateInfo9._type := a_validate_type(FValidateType);
      pValidateInfo := @rValidateInfo9;
    end
    else begin
      FillChar(rValidateInfo5, SizeOf(a_validate_db_v5), 0);
      // Use the DBTOOL.DLL actual version instead of DB_TOOLS_VERSION_NUMBER
      rValidateInfo5.version := FLib.Version div 100000;
      sConPars := FEncoder.Encode(FConnectParams);
      rValidateInfo5.connectparms := Pa_char(PByte(sConPars));
      sStartLine := FEncoder.Encode(FConnectParams);
      rValidateInfo5.startline := Pa_char(PByte(sStartLine));
      rValidateInfo5.tables := Strings2P_name(FTables);
      rValidateInfo5.errorrtn := oErrorThunk.CallAddress;
      rValidateInfo5.msgrtn := oMessageThunk.CallAddress;
      rValidateInfo5.statusrtn := oStatusThunk.CallAddress;
      rValidateInfo5.flags1 := FlagsToMask1();
      pValidateInfo := @rValidateInfo5;
    end;
    Check(FLib.DBValidate(pValidateInfo));
  finally
    if FLib.Version >= cvSybaseASA12 then
      DeleteP_name(rValidateInfo12.tables)
    else if FLib.Version >= cvSybaseASA11 then
      DeleteP_name(rValidateInfo11.tables)
    else if FLib.Version >= cvSybaseASA10 then
      DeleteP_name(rValidateInfo10.tables)
    else if FLib.Version >= cvSybaseASA6 then
      DeleteP_name(rValidateInfo9.tables)
    else
      DeleteP_name(rValidateInfo5.tables);
    FDFree(oErrorThunk);
    FDFree(oMessageThunk);
    FDFree(oStatusThunk);
    Fini;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function ASANativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EASANativeException.Create;
  EASANativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EASANativeException, 'ASANativeException',
    @ASANativeExceptionLoad, @FDExceptionSave);

end.
