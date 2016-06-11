{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC MySQL wrapper classes             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MySQLWrapper;

interface

uses
  System.SyncObjs,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Stan.Error,
  FireDAC.Phys.MySQLCli;

type
  EMySQLNativeException = class;
  TMySQLLib = class;
  TMySQLSession = class;
  TMySQLResult = class;
  TMySQLField = class;

  TMySQLLib = class(TFDLibrary)
  private
    FLock: TCriticalSection;
    procedure InitEmbedded(const AEmbArgs, AEmbGrps: String);
    procedure EndEmbedded;

  protected
    procedure GetLibraryInfo; override;
    procedure LoadEntries; override;

  public
    FMySQLEmbedded: Boolean;
    FMySQLEmbeddedInit: Boolean;

    mysql_num_fields: TPrcmysql_num_fields;
    mysql_fetch_field_direct: TPrcmysql_fetch_field_direct;
    mysql_affected_rows: TPrcmysql_affected_rows;
    mysql_insert_id: TPrcmysql_insert_id;
    mysql_errno: TPrcmysql_errno;
    mysql_error: TPrcmysql_error;
    mysql_sqlstate: TPrcmysql_sqlstate;
    mysql_warning_count: TPrcmysql_warning_count;
    mysql_info: TPrcmysql_info;
    mysql_character_set_name: TPrcmysql_character_set_name;
    mysql_get_character_set_info: TPrcmysql_get_character_set_info;
    mysql_set_character_set: TPrcmysql_set_character_set;
    mysql_init: TPrcmysql_init;
    mysql_ssl_set: TPrcmysql_ssl_set;
    mysql_get_ssl_cipher: TPrcmysql_get_ssl_cipher;
    mysql_connect: TPrcmysql_connect;
    mysql_real_connect: TPrcmysql_real_connect;
    mysql_close: TPrcmysql_close;
    mysql_select_db: TPrcmysql_select_db;
    mysql_real_query: TPrcmysql_real_query;
    mysql_kill: TPrcmysql_kill;
    mysql_ping: TPrcmysql_ping;
    mysql_stat: TPrcmysql_stat;
    mysql_get_server_info: TPrcmysql_get_server_info;
    mysql_get_client_info: TPrcmysql_get_client_info;
    mysql_get_host_info: TPrcmysql_get_host_info;
    mysql_get_proto_info: TPrcmysql_get_proto_info;
    mysql_list_processes: TPrcmysql_list_processes;
    mysql_store_result: TPrcmysql_store_result;
    mysql_use_result: TPrcmysql_use_result;
    mysql_options_: TPrcmysql_options;
    mysql_free_result: TPrcmysql_free_result;
    mysql_fetch_row: TPrcmysql_fetch_row;
    mysql_fetch_lengths: TPrcmysql_fetch_lengths;
    mysql_escape_string: TPrcmysql_escape_string;
    mysql_real_escape_string: TPrcmysql_real_escape_string;
    mysql_thread_safe: TPrcmysql_thread_safe;
    mysql_more_results: TPrcmysql_more_results;
    mysql_next_result: TPrcmysql_next_result;
    mysql_server_init: TPrcmysql_server_init;
    mysql_server_end: TPrcmysql_server_end;
    mysql_thread_init: TPrcmysql_thread_init;
    mysql_thread_end: TPrcmysql_thread_end;
    mysql_thread_id: TPrcmysql_thread_id;

    constructor Create(AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure Load(const AVendorHome, AVendorLib, AEmbArgs, AEmbGrps: String);
    procedure Unload; override;
  end;

  TFDMySQLError = class(TFDDBError)
  private
    FSQLState: String;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    property SQLState: String read FSQLState;
  end;

  EMySQLNativeException = class(EFDDBEngineException)
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  end;

  TMySQLSession = class(TObject)
  private
    FLib: TMySQLLib;
{$IFDEF FireDAC_MONITOR}
    FTracing: Boolean;
    FMonitor: IFDMoniClient;
{$ENDIF}
    FPMySQL: PMYSQL;
    FOwnPMySQL: Boolean;
    [weak] FOwningObj: TObject;
    FBuffer: TFDBuffer;
    FEncoder: TFDEncoder;
    FCurrDB: String;
    FInfo: EMySQLNativeException;
    FCharsetName: String;
    FServerVersion: TFDVersion;
    FClientVersion: TFDVersion;
    FPwd: String;
    FPort: Cardinal;
    FHost: String;
    FUser: String;
    FFlags: my_ulong;
    function GetAffectedRows: my_ulonglong;
    function GetWarningCount: Cardinal;
    function GetClientInfo: String;
    function GetServerInfo: String;
    procedure SetOptions(AOption: mysql_option; const AValue: PByte);
    function GetDB: String;
    procedure SetDB(const AValue: String);
    procedure ProcessError(AErrNo: Cardinal; AInitiator: TObject);
    procedure Check(ACode: Integer = -1; AInitiator: TObject = nil);
    procedure ClearInfo;
    procedure SetInfo(ApInfo, ApLevel: my_pchar; ACode: Integer);
    function GetCharacterSetName: String;
    function GetHostInfo: String;
    function GetInsert_ID: my_ulonglong;
    procedure SetCharacterSetName(const AValue: String);
    function GetHasMoreResults: Boolean;
    function GetSSLCipher: String;
    function GetClientVersion: TFDVersion;
    function GetServerVersion: TFDVersion;
  public
    constructor Create(ALib: TMySQLLib; AOwningObj: TObject = nil);
    constructor CreateUsingHandle(ALib: TMySQLLib; ApMySQL: PMYSQL;
      AOwningObj: TObject = nil);
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
{$ENDIF}
    procedure Init;
    procedure SSLInit(const Akey, Acert, Aca, Acapath, Acipher: String);
    procedure Connect(const host, user, passwd, db: String;
      port: Cardinal; clientflag: my_ulong);
    procedure Disconnect;
    procedure KillQuery;
    procedure Ping;
    function EscapeString(szTo: PFDAnsiString; const szFrom: PFDAnsiString;
      length: LongWord): LongWord; overload;
    procedure Query(const ACmd: String; AInitiator: TObject = nil);
    procedure QuerySB(const ACmd: TFDByteString; AInitiator: TObject = nil);
    procedure GetServerOutput;
    function StoreResult: TMySQLResult;
    function UseResult: TMySQLResult;
    function MoreResults: Boolean;
    function NextResult: Boolean;
    procedure GetCharacterSetInfo(var ACharset: MY_CHARSET_INFO);
    property Options[AOption: mysql_option]: PByte write SetOptions;
    property ServerInfo: String read GetServerInfo;
    property ServerVersion: TFDVersion read GetServerVersion;
    property ClientInfo: String read GetClientInfo;
    property ClientVersion: TFDVersion read GetClientVersion;
    property AffectedRows: my_ulonglong read GetAffectedRows;
    property WarningCount: Cardinal read GetWarningCount;
{$IFDEF FireDAC_MONITOR}
    property Tracing: Boolean read FTracing write FTracing;
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
{$ENDIF}
    property DB: String read GetDB write SetDB;
    property Lib: TMySQLLib read FLib;
    property OwningObj: TObject read FOwningObj;
    property Info: EMySQLNativeException read FInfo;
    property Buffer: TFDBuffer read FBuffer;
    property Encoder: TFDEncoder read FEncoder;
    property CharacterSetName: String read GetCharacterSetName
      write SetCharacterSetName;
    property HostInfo: String read GetHostInfo;
    property Insert_ID: my_ulonglong read GetInsert_ID;
    property MySQL: PMYSQL read FPMySQL;
    property Host: String read FHost;
    property User: String read FUser;
    property Pwd: String read FPwd;
    property Port: Cardinal read FPort;
    property Flags: my_ulong read FFlags;
    property HasMoreResults: Boolean read GetHasMoreResults;
    property SSLCipher: String read GetSSLCipher;
  end;

  TMySQLResult = class(TObject)
  private
    FSession: TMySQLSession;
    FCursor: PMYSQL_RES;
    FpRow: MYSQL_ROW;
    FpLengths: Pmy_ulong;
    FField: TMySQLField;
    function GetFieldCount: Cardinal;
    function GetFields(AIndex: Integer): TMySQLField;
{$IFDEF FireDAC_MONITOR}
    procedure DumpColumns(ARowIndex: Integer);
{$ENDIF}
  public
    constructor Create(ASession: TMySQLSession; AResult: PMYSQL_RES);
    destructor Destroy; override;
    function Fetch(ARowIndex: Integer): Boolean;
    function GetData(AIndex: Integer; var ApData: Pointer; var ALen: LongWord): Boolean;
    property FieldCount: Cardinal read GetFieldCount;
    property Fields[AIndex: Integer]: TMySQLField read GetFields;
  end;

  TMySQLField = class(TObject)
  private
    FResult: TMySQLResult;
    FpFld: PMYSQL_FIELD;
  public
    procedure GetInfo(var name, srcname, table, db: my_pchar; var type_: Byte;
      var length, flags, decimals, charsetnr: LongWord);
    constructor Create(AResult: TMySQLResult);
  end;

implementation

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Consts,
  FireDAC.Phys.Intf;

const
  smysql_get_client_info: String = 'mysql_get_client_info';
  smysql_num_fields: String = 'mysql_num_fields';
  smysql_fetch_field_direct: String = 'mysql_fetch_field_direct';
  smysql_affected_rows: String = 'mysql_affected_rows';
  smysql_insert_id: String = 'mysql_insert_id';
  smysql_errno: String = 'mysql_errno';
  smysql_error: String = 'mysql_error';
  smysql_sqlstate: String = 'mysql_sqlstate';
  smysql_warning_count: String = 'mysql_warning_count';
  smysql_info: String = 'mysql_info';
  smysql_character_set_name: String = 'mysql_character_set_name';
  smysql_get_character_set_info: String = 'mysql_get_character_set_info';
  smysql_set_character_set: String = 'mysql_set_character_set';
  smysql_init: String = 'mysql_init';
  smysql_connect: String = 'mysql_connect';
  smysql_ssl_set: String = 'mysql_ssl_set';
  smysql_get_ssl_cipher: String = 'mysql_get_ssl_cipher';
  smysql_real_connect: String = 'mysql_real_connect';
  smysql_close: String = 'mysql_close';
  smysql_select_db: String = 'mysql_select_db';
  smysql_real_query: String = 'mysql_real_query';
  smysql_kill: String = 'mysql_kill';
  smysql_ping: String = 'mysql_ping';
  smysql_stat: String = 'mysql_stat';
  smysql_get_server_info: String = 'mysql_get_server_info';
  smysql_get_host_info: String = 'mysql_get_host_info';
  smysql_get_proto_info: String = 'mysql_get_proto_info';
  smysql_list_processes: String = 'mysql_list_processes';
  smysql_store_result: String = 'mysql_store_result';
  smysql_use_result: String = 'mysql_use_result';
  smysql_options_: String = 'mysql_options';
  smysql_free_result: String = 'mysql_free_result';
  smysql_fetch_row: String = 'mysql_fetch_row';
  smysql_fetch_lengths: String = 'mysql_fetch_lengths';
  smysql_escape_string: String = 'mysql_escape_string';
  smysql_real_escape_string: String = 'mysql_real_escape_string';
  smysql_thread_safe: String = 'mysql_thread_safe';
  smysql_more_results: String = 'mysql_more_results';
  smysql_next_result: String = 'mysql_next_result';
  smysql_server_init: String = 'mysql_server_init';
  smysql_server_end: String = 'mysql_server_end';
  smysql_thread_init: String = 'mysql_thread_init';
  smysql_thread_end: String = 'mysql_thread_end';
  smysql_thread_id: String = 'mysql_thread_id';

{-------------------------------------------------------------------------------}
{ TMySQLLib                                                                     }
{-------------------------------------------------------------------------------}
constructor TMySQLLib.Create(AOwningObj: TObject = nil);
begin
  inherited Create(S_FD_MySQLId, AOwningObj);
  FLock := TCriticalSection.Create;
end;

{-------------------------------------------------------------------------------}
destructor TMySQLLib.Destroy;
begin
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.Load(const AVendorHome, AVendorLib, AEmbArgs, AEmbGrps: String);
const
  C_Libmysql: String = {$IFDEF MSWINDOWS} 'libmysql' {$ENDIF}
                       {$IFDEF POSIX} 'libmysqlclient' {$ENDIF} + C_FD_DLLExt;
  C_Libmysqld: String = 'libmysqld' + C_FD_DLLExt;
var
  sDLLName: String;
  aMySQLDllNames: array of String;
begin
  FMySQLEmbeddedInit := False;
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then begin
    SetLength(aMySQLDllNames, 1);
    aMySQLDllNames[0] := sDLLName + AVendorLib;
  end
  else begin
    SetLength(aMySQLDllNames, 2);
    aMySQLDllNames[0] := sDLLName + C_Libmysql;
    aMySQLDllNames[1] := sDLLName + C_Libmysqld;
  end;
  inherited Load(aMySQLDllNames, True);
  if FMySQLEmbedded then
    InitEmbedded(AEmbArgs, AEmbGrps);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.Unload;
begin
  if FMySQLEmbeddedInit then
    EndEmbedded;
  inherited Unload;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.GetLibraryInfo;
begin
  inherited GetLibraryInfo;
  FMySQLEmbedded := (DLLName <> '') and FDInSet(DLLName[Pos('.', DLLName) - 1], ['d', 'D']);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.LoadEntries;
begin
  @mysql_get_client_info := GetProc(smysql_get_client_info);
  FVersion := FDVerStr2Int(TFDEncoder.Deco(mysql_get_client_info(), -1, ecANSI));
  if (FVersion < mvMySQL032000) or (FVersion >= mvMySQL060200) then
    FDException(OwningObj, [S_FD_LPhys, S_FD_MySQLId], er_FD_MySQLBadVersion,
      [FVersion]);

  @mysql_num_fields := GetProc(smysql_num_fields);
  @mysql_fetch_field_direct := GetProc(smysql_fetch_field_direct);
  @mysql_affected_rows := GetProc(smysql_affected_rows);
  @mysql_insert_id := GetProc(smysql_insert_id);
  @mysql_errno := GetProc(smysql_errno);
  @mysql_error := GetProc(smysql_error);
  if FVersion >= mvMySQL040101 then begin
    @mysql_sqlstate := GetProc(smysql_sqlstate);
    @mysql_warning_count := GetProc(smysql_warning_count);
  end
  else begin
    @mysql_sqlstate := nil;
    @mysql_warning_count := nil;
  end;
  @mysql_info := GetProc(smysql_info);
  if FVersion >= mvMySQL032321 then
    @mysql_character_set_name := GetProc(smysql_character_set_name, False)
  else
    @mysql_character_set_name := nil;
  if FVersion >= mvMySQL050010 then
    @mysql_get_character_set_info := GetProc(smysql_get_character_set_info)
  else
    @mysql_get_character_set_info := nil;
  if FVersion >= mvMySQL050007 then
    @mysql_set_character_set := GetProc(smysql_set_character_set)
  else
    @mysql_set_character_set := nil;
  @mysql_init := GetProc(smysql_init);
  if not FMySQLEmbedded then begin
    if FVersion < mvMySQL040000 then begin
      @mysql_connect := GetProc(smysql_connect);
      @mysql_ssl_set := nil;
    end
    else begin
      @mysql_connect := nil;
      @mysql_ssl_set := GetProc(smysql_ssl_set);
    end;
    if FVersion >= mvMySQL050023 then
      @mysql_get_ssl_cipher := GetProc(smysql_get_ssl_cipher, False)
    else
      @mysql_get_ssl_cipher := nil;
  end;
  @mysql_real_connect := GetProc(smysql_real_connect);
  @mysql_close := GetProc(smysql_close);
  @mysql_select_db := GetProc(smysql_select_db);
  @mysql_real_query := GetProc(smysql_real_query);
  @mysql_kill := GetProc(smysql_kill);
  @mysql_ping := GetProc(smysql_ping);
  @mysql_stat := GetProc(smysql_stat);
  @mysql_get_server_info := GetProc(smysql_get_server_info);
  @mysql_get_host_info := GetProc(smysql_get_host_info);
  @mysql_get_proto_info := GetProc(smysql_get_proto_info);
  @mysql_list_processes := GetProc(smysql_list_processes);
  @mysql_store_result := GetProc(smysql_store_result);
  @mysql_use_result := GetProc(smysql_use_result);
  @mysql_options_ := GetProc(smysql_options_);
  @mysql_free_result := GetProc(smysql_free_result);
  @mysql_fetch_row := GetProc(smysql_fetch_row);
  @mysql_fetch_lengths := GetProc(smysql_fetch_lengths);
  @mysql_escape_string := GetProc(smysql_escape_string);
  if FVersion >= mvMySQL032314 then begin
    @mysql_real_escape_string := GetProc(smysql_real_escape_string, False);
    @mysql_thread_safe := GetProc(smysql_thread_safe, False);
  end
  else begin
    @mysql_real_escape_string := nil;
    @mysql_thread_safe := nil;
  end;
  if FVersion >= mvMySQL040101 then begin
    @mysql_more_results := GetProc(smysql_more_results);
    @mysql_next_result := GetProc(smysql_next_result);
  end
  else begin
    @mysql_more_results := nil;
    @mysql_next_result := nil;
  end;
  if FMySQLEmbedded then begin
    @mysql_server_init := GetProc(smysql_server_init);
    @mysql_server_end := GetProc(smysql_server_end);
  end;
  @mysql_thread_init := GetProc(smysql_thread_init, False);
  @mysql_thread_end := GetProc(smysql_thread_end, False);
  @mysql_thread_id := GetProc(smysql_thread_id);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.InitEmbedded(const AEmbArgs, AEmbGrps: String);
var
  aStrs: array of TFDByteString;
  aArgs, aGroups: array of PByte;
  pArgs, pGroups: my_ppchar;
  iArgCount, iGroupCount, i: Integer;
begin
  iArgCount := 0;
  i := 1;
  while i <= Length(AEmbArgs) do begin
    FDExtractFieldName(AEmbArgs, i);
    Inc(iArgCount);
  end;
  iGroupCount := 0;
  i := 1;
  while i <= Length(AEmbGrps) do begin
    FDExtractFieldName(AEmbGrps, i);
    Inc(iGroupCount);
  end;
  SetLength(aStrs, iArgCount + iGroupCount + 1);
  SetLength(aArgs, iArgCount + 2);

  aStrs[0] := TFDEncoder.Enco('server', ecANSI);
  aArgs[0] := PByte(aStrs[0]);
  iArgCount := 1;
  i := 1;
  while i <= Length(AEmbArgs) do begin
    aStrs[iArgCount] := TFDEncoder.Enco(FDExtractFieldName(AEmbArgs, i), ecANSI);
    aArgs[iArgCount] := PByte(aStrs[iArgCount]);
    Inc(iArgCount);
  end;
  aArgs[iArgCount] := nil;
  pArgs := @aArgs[0];

  if iGroupCount = 0 then
    pGroups := nil
  else begin
    SetLength(aGroups, iGroupCount + 1);
    iGroupCount := 0;
    i := 1;
    while i <= Length(AEmbGrps) do begin
      aStrs[iGroupCount + iArgCount] := TFDEncoder.Enco(FDExtractFieldName(AEmbGrps, i), ecANSI);
      aGroups[iGroupCount] := PByte(aStrs[iGroupCount + iArgCount]);
      Inc(iGroupCount);
    end;
    aGroups[iGroupCount] := nil;
    pGroups := @aGroups[0];
  end;

  if mysql_server_init(iArgCount, pArgs, pGroups) <> 0 then
    FDException(OwningObj, [S_FD_LPhys, S_FD_MySQLId],
      er_FD_MySQLCantInitEmbeddedServer, []);
  FMySQLEmbeddedInit := True;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLLib.EndEmbedded;
begin
  FMySQLEmbeddedInit := False;
  mysql_server_end();
end;

{-------------------------------------------------------------------------------}
{ TFDMySQLError                                                                 }
{-------------------------------------------------------------------------------}
procedure TFDMySQLError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDMySQLError then
    FSQLState := TFDMySQLError(ASrc).FSQLState;
end;

{-------------------------------------------------------------------------------}
procedure TFDMySQLError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FSQLState := AStorage.ReadString('SQLState', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDMySQLError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteString('SQLState', FSQLState, '');
end;

{-------------------------------------------------------------------------------}
function EMySQLNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDMySQLError;
end;

{-------------------------------------------------------------------------------}
{ TMySQLSession                                                                 }
{-------------------------------------------------------------------------------}
constructor TMySQLSession.Create(ALib: TMySQLLib; AOwningObj: TObject);
begin
  inherited Create;
  FOwningObj := AOwningObj;
  FLib := ALib;
  FOwnPMySQL := True;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
end;

{-------------------------------------------------------------------------------}
constructor TMySQLSession.CreateUsingHandle(ALib: TMySQLLib; ApMySQL: PMYSQL;
  AOwningObj: TObject);
begin
  inherited Create;
  FOwningObj := AOwningObj;
  FLib := ALib;
  FPMySQL := ApMySQL;
  FOwnPMySQL := FPMySQL = nil;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
end;

{-------------------------------------------------------------------------------}
destructor TMySQLSession.Destroy;
begin
  if FPMySQL <> nil then
    Disconnect;
  ClearInfo;
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}
  FOwningObj := nil;
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FBuffer);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TMySQLSession.Trace(const AMsg: String; const AArgs: array of const);
begin
  FMonitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  FMonitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TMySQLSession.ProcessError(AErrNo: Cardinal; AInitiator: TObject);
var
  pErrMsg: my_pchar;
  oEx: EMySQLNativeException;
  oErr: TFDMySQLError;
  sObj, sMsg, sSQL, sSQLState: String;
  eKind: TFDCommandExceptionKind;
  oCommand: IFDPhysCommand;
  iOff, i1, i2: Integer;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    i1 := Pos('''', sMsg);
    if i1 <> 0 then begin
      i2 := Pos('''', sMsg, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(sMsg, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  pErrMsg := FLib.mysql_error(FPMySQL);
  sMsg := Encoder.Decode(pErrMsg, -1, ecANSI);
  if Assigned(FLib.mysql_sqlstate) then begin
    pErrMsg := FLib.mysql_sqlstate(FPMySQL);
    sSQLState := Encoder.Decode(pErrMsg, -1, ecANSI);
  end
  else
    sSQLState := '';
  oEx := EMySQLNativeException.Create(er_FD_MySQLGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_MySQLId]) + ' ' + sMsg);
  sObj := '';
  eKind := ekOther;
  case AErrNo of
  ER_NO_SUCH_TABLE,
  ER_BAD_TABLE_ERROR,
  ER_SP_DOES_NOT_EXIST:   begin eKind := ekObjNotExists; ExtractObjName; end;
  ER_DUP_ENTRY:           eKind := ekUKViolated;
  ER_LOCK_WAIT_TIMEOUT:   eKind := ekRecordLocked;
  ER_NO_REFERENCED_ROW,
  ER_ROW_IS_REFERENCED:   eKind := ekFKViolated;
  ER_ACCESS_DENIED_ERROR: eKind := ekUserPwdInvalid;
  ER_MUST_CHANGE_PASSWORD,
  ER_MUST_CHANGE_PASSWORD_LOGIN:
                          eKind := ekUserPwdExpired;
  CR_CONN_HOST_ERROR,
  ER_SERVER_GONE_ERROR,
  ER_SERVER_LOST:         eKind := ekServerGone;
  ER_SP_WRONG_NO_OF_ARGS: eKind := ekInvalidParams;
  ER_QUERY_INTERRUPTED:   eKind := ekCmdAborted;
  // ekNoDataFound - nothing similar in MySQL
  // 1048 - NOT NULL violated
  end;
  iOff := -1;
  if (AErrNo = ER_PARSE_ERROR) and Supports(AInitiator, IFDPhysCommand, oCommand) then begin
    sSQL := oCommand.CommandText;
    i1 := Pos('to use near ''', sMsg);
    if i1 = 0 then
      i1 := Pos('syntax near ''', sMsg);
    if i1 <> 0 then begin
      if (i1 + 13 < Length(sMsg)) and (sMsg[i1 + 13] = '?') then
        eKind := ekInvalidParams;
      i1 := i1 + 13;
      i2 := Length(sMsg);
      while (i2 > i1) and (sMsg[i2] <> '''') do
        Dec(i2);
      iOff := Pos(AdjustLineBreaks(Copy(sMsg, i1, i2 - i1 - 1), tlbsCRLF), sSQL);
      if iOff = 0 then begin
        i1 := Pos('at line', sMsg);
        if i1 <> 0 then begin
          i1 := StrToIntDef(Copy(sMsg, i1 + 7, Length(sMsg)), 0);
          if i1 <> 0 then begin
            i2 := 1;
            while i2 <= Length(sSQL) do
              if sSQL[i2] = #13 then begin
                if sSQL[i2 + 1] = #10 then
                  Inc(i2);
                Inc(i2);
                Dec(i1);
                if i1 = 1 then begin
                  iOff := i2;
                  Break;
                end;
              end
              else
                Inc(i2);
          end;
        end;
      end;
    end;
  end;
  oErr := TFDMySQLError(oEx.AppendError(1, AErrNo, sMsg, sObj, eKind, iOff, -1));
  oErr.FSQLState := sSQLState;
{$IFDEF FireDAC_MONITOR}
  if Tracing then
    FMonitor.Notify(ekError, esProgress, OwningObj, sMsg, ['errno', AErrNo,
      'sqlstate', sSQLState]);
{$ENDIF}
  FDException(AInitiator, oEx {$IFDEF FireDAC_Monitor}, Tracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.ClearInfo;
begin
  FDFreeAndNil(FInfo);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.SetInfo(ApInfo, ApLevel: my_pchar; ACode: Integer);
begin
  if FInfo = nil then
    FInfo := EMySQLNativeException.Create(er_FD_MySQLGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_MySQLId]));
  FInfo.AppendError(FInfo.ErrorCount + 1, ACode,
    Encoder.Decode(ApInfo, -1, ecANSI),
    Encoder.Decode(ApLevel, -1, ecANSI),
    ekServerOutput, -1, -1);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Check(ACode: Integer = -1; AInitiator: TObject = nil);
var
  iErrNo: Cardinal;
begin
  if ACode <> 0 then begin
    iErrNo := FLib.mysql_errno(FPMySQL);
    if (ACode <> -1) or (iErrNo <> 0) then begin
      if AInitiator = nil then
        AInitiator := OwningObj;
      ProcessError(iErrNo, AInitiator);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Init;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_init, []);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  if FOwnPMySQL then begin
    FLib.FLock.Enter;
    try
      FPMySQL := FLib.mysql_init(nil);
    finally
      FLib.FLock.Leave;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.SSLInit(const Akey, Acert, Aca, Acapath, Acipher: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_ssl_set, ['key', Akey, 'cert', Acert, 'ca', Aca,
      'capath', Acapath, 'cipher', Acipher]);
  end;
{$ENDIF}

  function S2P(AStr: String; var AVar: TFDByteString): my_pchar;
  begin
    if AStr = '' then
      Result := nil
    else begin
      AVar := Encoder.Encode(AStr, ecANSI);
      Result := my_pchar(AVar);
    end;
  end;

var
  sKey, sCert, sCa, sCAPath, sCipher: TFDByteString;
begin
  if Assigned(FLib.mysql_ssl_set) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    FLib.mysql_ssl_set(FPMySQL, S2P(Akey, sKey), S2P(Acert, sCert), S2P(Aca, sCa),
      S2P(Acapath, sCAPath), S2P(Acipher, sCipher));
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetSSLCipher: String;
begin
  if Assigned(FLib.mysql_get_ssl_cipher) then
    Result := Encoder.Decode(FLib.mysql_get_ssl_cipher(FPMySQL), -1, ecANSI)
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Connect(const host, user, passwd, db: String;
  port: Cardinal; clientflag: my_ulong);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_real_connect, ['host', host, 'user', user, 'passwd', '***',
      'db', db, 'port', port, 'clientflag', clientflag]);
  end;

  procedure Trace2;
  begin
    Trace(smysql_connect, ['host', host, 'user', user, 'passwd', '***']);
  end;
{$ENDIF}

var
  sHost, sUser, sPwd, sDb: TFDByteString;
begin
  sHost := Encoder.Encode(host, ecANSI);
  sUser := Encoder.Encode(user, ecANSI);
  sPwd := Encoder.Encode(passwd, ecANSI);
  sDb := Encoder.Encode(db, ecANSI);
  if Assigned(FLib.mysql_real_connect) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    if FLib.mysql_real_connect(FPMySQL, my_pchar(PByte(sHost)),
        my_pchar(PByte(sUser)), my_pchar(PByte(sPwd)),
        my_pchar(PByte(sDb)), port, nil, clientflag) = nil then
      Check;
  end
  else begin
    if (port <> 0) and (port <> MYSQL_PORT) then
      FDException(OwningObj, [S_FD_LPhys, S_FD_MySQLId], er_FD_MySQLCantSetPort, []);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
    if FLib.mysql_connect(FPMySQL, my_pchar(PByte(sHost)),
        my_pchar(PByte(sUser)), my_pchar(PByte(sPwd))) = nil then
      Check;
    if db <> '' then
      Query('USE ' + db);
  end;
  FCurrDB := db;
  FHost := host;
  FUser := user;
  FPwd := passwd;
  FPort := port;
  FFlags := clientflag;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Disconnect;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_close, []);
  end;
{$ENDIF}

begin
  if FPMySQL = nil then
    Exit;
  ClearInfo;
  if FOwnPMySQL then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    FLib.mysql_close(FPMySQL);
  end;
  FPMySQL := nil;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.KillQuery;
var
  oSess: TMySQLSession;
begin
  oSess := TMySQLSession.Create(FLib, Self);
  try
{$IFDEF FireDAC_MONITOR}
    oSess.Tracing := FTracing;
    oSess.Monitor := FMonitor;
{$ENDIF}
    oSess.Init;
    oSess.Connect(FHost, FUser, FPwd, FCurrDB, FPort, FFlags);
    oSess.Query(Format('KILL QUERY %u', [FLib.mysql_thread_id(FPMySQL)]));
  finally
    FDFree(oSess);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Ping;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_ping, []);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  Check(FLib.mysql_ping(FPMySQL));
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.EscapeString(szTo: PFDAnsiString; const szFrom: PFDAnsiString;
  length: LongWord): LongWord;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
                                                                 
    Trace(smysql_real_escape_string, ['szFrom', Encoder.Decode(szFrom, length, ecANSI),
                                      'szTo', Encoder.Decode(szTo, Result, ecANSI)]);
  end;

  procedure Trace2;
  begin
                                                                 
    Trace(smysql_escape_string, ['szFrom', Encoder.Decode(szFrom, length, ecANSI),
                                 'szTo', Encoder.Decode(szTo, Result, ecANSI)]);
  end;
{$ENDIF}

begin
  if Assigned(FLib.mysql_real_escape_string) then begin
    Result := FLib.mysql_real_escape_string(FPMySQL, szTo, szFrom, length);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end
  else begin
    Result := FLib.mysql_escape_string(szTo, szFrom, length);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetAffectedRows: my_ulonglong;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_affected_rows, ['Rows', Result]);
  end;
{$ENDIF}

begin
  Result := FLib.mysql_affected_rows(FPMySQL);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetWarningCount: Cardinal;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_warning_count, ['res', Result]);
  end;
{$ENDIF}

begin
  if Assigned(FLib.mysql_warning_count) then begin
    Result := FLib.mysql_warning_count(FPMySQL);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetClientInfo: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_get_client_info, ['Ver', Result]);
  end;
{$ENDIF}

begin
  Result := Encoder.Decode(FLib.mysql_get_client_info(), -1, ecANSI);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetClientVersion: TFDVersion;
begin
  if FClientVersion = 0 then
    FClientVersion := FDVerStr2Int(ClientInfo);
  Result := FClientVersion;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetServerInfo: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_get_server_info, ['Ver', Result]);
  end;
{$ENDIF}

begin
  Result := Encoder.Decode(FLib.mysql_get_server_info(FPMySQL), -1, ecANSI);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetServerVersion: TFDVersion;
begin
  if FServerVersion = 0 then
    FServerVersion := FDVerStr2Int(ServerInfo);
  Result := FServerVersion;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.SetOptions(AOption: mysql_option; const AValue: PByte);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_options_, ['option', Integer(AOption), 'arg', NativeUInt(AValue)]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  FLib.mysql_options_(FPMySQL, AOption, AValue);
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.GetServerOutput;
const
  C_CMD = 'SHOW WARNINGS';
var
  oRes: TMySQLResult;
  pLevel, pMsg, pCode: Pointer;
  iLen: LongWord;
  sCmd: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_real_query, ['q', C_CMD]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sCmd := Encoder.Encode(C_CMD);
  Check(FLib.mysql_real_query(FPMySQL, my_pchar(PByte(sCmd)), Encoder.EncodedLength(sCmd)));
  oRes := StoreResult;
  try
    while oRes.Fetch(0) do begin
      oRes.GetData(0, pLevel, iLen);
      oRes.GetData(1, pCode, iLen);
      oRes.GetData(2, pMsg, iLen);
      SetInfo(my_pchar(pMsg), my_pchar(pLevel), StrToInt(Encoder.Decode(pCode, -1, ecANSI)));
    end;
  finally
    FDFree(oRes);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.QuerySB(const ACmd: TFDByteString; AInitiator: TObject = nil);
var
  iRes: Integer;
  pInfo: my_pchar;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_real_query, ['q', Encoder.Decode(ACmd)]);
  end;

  procedure Trace2;
  begin
    Trace(smysql_info, ['res', Encoder.Decode(pInfo, -1, ecANSI)]);
  end;
{$ENDIF}

begin
  ClearInfo;
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  iRes := FLib.mysql_real_query(FPMySQL, my_pchar(PByte(ACmd)),
    Encoder.EncodedLength(ACmd));
  Check(iRes, AInitiator);
  pInfo := FLib.mysql_info(FPMySQL);
  if pInfo <> nil then begin
    SetInfo(pInfo, my_pchar(Encoder.Encode('Info', ecANSI)), MYSQL_SUCCESS);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace2;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.Query(const ACmd: String; AInitiator: TObject = nil);
begin
  QuerySB(FEncoder.Encode(ACmd));
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.StoreResult: TMySQLResult;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_store_result, []);
  end;
{$ENDIF}

var
  pRes: PMYSQL_RES;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  pRes := FLib.mysql_store_result(FPMySQL);
  Check;
  if pRes = nil then
    Result := nil
  else
    Result := TMySQLResult.Create(Self, pRes);
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.UseResult: TMySQLResult;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_use_result, []);
  end;
{$ENDIF}

var
  pRes: PMYSQL_RES;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  pRes := FLib.mysql_use_result(FPMySQL);
  Check;
  if pRes = nil then
    Result := nil
  else
    Result := TMySQLResult.Create(Self, pRes);
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.MoreResults: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_more_results, []);
  end;
{$ENDIF}

begin
  ClearInfo;
  if not Assigned(FLib.mysql_more_results) then
    Result := False
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    Result := FLib.mysql_more_results(FPMySQL) = 1;
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.NextResult: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_next_result, []);
  end;
{$ENDIF}

begin
  ClearInfo;
  if not Assigned(FLib.mysql_next_result) then
    Result := False
  else begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    case FLib.mysql_next_result(FPMySQL) of
    my_bool(-1): Result := False;
    0:           Result := True;
    else         begin Result := False; Check; end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetDB: String;
var
  pDb: my_pchar;
begin
  Result := '';
  if FLib.FVersion >= mvMySQL050100 then
    pDb := PMYSQL0510(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL050006 then
    pDb := PMYSQL0506(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL050000 then
    pDb := PMYSQL0500(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL041000 then
    pDb := PMYSQL0410(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL040000 then
    pDb := PMYSQL0400(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL032300 then
    pDb := PMYSQL0323(FPMySQL)^.db
  else if FLib.FVersion >= mvMySQL032000 then
    pDb := PMYSQL0320(FPMySQL)^.db
  else
    pDb := nil;
  if pDb <> nil then
    Result := Encoder.Decode(pDb, -1, ecANSI);
  if Result = '' then
    Result := FCurrDB;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.SetDB(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_select_db, ['db', AValue]);
  end;
{$ENDIF}

var
  sDb: TFDByteString;
begin
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
  sDb := Encoder.Encode(AValue, ecANSI);
  Check(FLib.mysql_select_db(FPMySQL, my_pchar(PByte(sDb))));
  FCurrDB := AValue;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetHostInfo: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_get_host_info, ['res', Result]);
  end;
{$ENDIF}

var
  pInfo: my_pchar;
begin
  pInfo := FLib.mysql_get_host_info(FPMySQL);
  Result := Encoder.Decode(pInfo, -1, ecANSI);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetInsert_ID: my_ulonglong;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_insert_id, ['res', Result]);
  end;
{$ENDIF}

begin
  Result := FLib.mysql_insert_id(FPMySQL);
{$IFDEF FireDAC_MONITOR}
  if Tracing then Trace1;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TMySQLSession.GetCharacterSetInfo(var ACharset: MY_CHARSET_INFO);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_get_character_set_info, []);
  end;
{$ENDIF}

begin
  if Assigned(FLib.mysql_get_character_set_info) then begin
    FLib.mysql_get_character_set_info(FPMySQL, ACharset);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end
  else
    FillChar(ACharset, SizeOf(MY_CHARSET_INFO), 0);
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetCharacterSetName: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_character_set_name, ['res', Result]);
  end;
{$ENDIF}

begin
  if Assigned(FLib.mysql_character_set_name) and
     Assigned(FLib.mysql_set_character_set) then begin
    Result := Encoder.Decode(FLib.mysql_character_set_name(FPMySQL), -1, ecANSI);
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
  end
  else
    Result := FCharsetName;
end;


{-------------------------------------------------------------------------------}
procedure TMySQLSession.SetCharacterSetName(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(smysql_set_character_set, ['cs_name', AValue]);
  end;
{$ENDIF}

var
  iRes: Integer;
  sName: TFDByteString;
begin
  iRes := -1;
  if Assigned(FLib.mysql_set_character_set) then begin
{$IFDEF FireDAC_MONITOR}
    if Tracing then Trace1;
{$ENDIF}
    sName := Encoder.Encode(AValue, ecANSI);
    iRes := FLib.mysql_set_character_set(FPMySQL, my_pchar(PByte(sName)));
  end;
  if iRes <> 0 then
    try
      if ServerVersion >= mvMySQL040100 then
        Query('SET NAMES ''' + AValue + '''')
      else
        Query('SET CHARACTER SET ' + AValue);
      iRes := 0;
    except
      // hide exception
    end;
  if iRes = 0 then begin
    FCharsetName := AValue;
    if (Length(AValue) >= 4) and
       FDInSet(AValue[1], ['U', 'u']) and FDInSet(AValue[2], ['T', 't']) and
       FDInSet(AValue[3], ['F', 'f']) and FDInSet(AValue[4], ['8']) then
      FEncoder.Encoding := ecUTF8
    else
      FEncoder.Encoding := ecANSI;
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLSession.GetHasMoreResults: Boolean;
var
  iStatus: Cardinal;
begin
  if FLib.FVersion >= mvMySQL050100 then
    iStatus := PMYSQL0510(FPMySQL)^.server_status
  else if FLib.FVersion >= mvMySQL050006 then
    iStatus := PMYSQL0506(FPMySQL)^.server_status
  else if FLib.FVersion >= mvMySQL050000 then
    iStatus := PMYSQL0500(FPMySQL)^.server_status
  else if FLib.FVersion >= mvMySQL041000 then
    iStatus := PMYSQL0410(FPMySQL)^.server_status
  else
    iStatus := 0;
  Result := (iStatus and SERVER_MORE_RESULTS_EXISTS) <> 0;
end;

{-------------------------------------------------------------------------------}
{ TMySQLResult                                                                  }
{-------------------------------------------------------------------------------}
constructor TMySQLResult.Create(ASession: TMySQLSession; AResult: PMYSQL_RES);
begin
  inherited Create;
  FSession := ASession;
  FCursor := AResult;
end;

{-------------------------------------------------------------------------------}
destructor TMySQLResult.Destroy;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FSession.Trace(smysql_free_result, ['res', FCursor]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FSession.Tracing then Trace1;
{$ENDIF}
  FSession.FLib.mysql_free_result(FCursor);
  FCursor := nil;
  FDFreeAndNil(FField);
  FSession.Buffer.Release;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMySQLResult.GetFieldCount: Cardinal;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FSession.Trace(smysql_num_fields, ['res', FCursor]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FSession.Tracing then Trace1;
{$ENDIF}
  Result := FSession.FLib.mysql_num_fields(FCursor);
end;

{-------------------------------------------------------------------------------}
function TMySQLResult.GetFields(AIndex: Integer): TMySQLField;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FSession.Trace(smysql_fetch_field_direct, ['res', FCursor, 'fieldnr', AIndex]);
  end;
{$ENDIF}

begin
  if FField = nil then
    FField := TMySQLField.Create(Self);
{$IFDEF FireDAC_MONITOR}
  if FSession.Tracing then Trace1;
{$ENDIF}
  FField.FpFld := FSession.FLib.mysql_fetch_field_direct(FCursor, AIndex);
  Result := FField;
end;

{-------------------------------------------------------------------------------}
function TMySQLResult.Fetch(ARowIndex: Integer): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    FSession.Trace(smysql_fetch_row, ['res', FCursor]);
  end;

  procedure Trace2;
  begin
    FSession.Trace(smysql_fetch_lengths, ['res', FCursor]);
  end;

  procedure Trace3;
  begin
    FSession.Trace(ekCmdDataOut, esProgress, 'EOF', []);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if FSession.Tracing then Trace1;
{$ENDIF}
  FpRow := FSession.FLib.mysql_fetch_row(FCursor);
  Result := (FpRow <> nil);
  if Result then begin
{$IFDEF FireDAC_MONITOR}
    if FSession.Tracing then Trace2;
{$ENDIF}
    FpLengths := FSession.FLib.mysql_fetch_lengths(FCursor);
    if FpLengths = nil then
      FSession.Check;
{$IFDEF FireDAC_MONITOR}
    if FSession.Tracing then DumpColumns(ARowIndex);
{$ENDIF}
  end
  else begin
    FSession.Check;
{$IFDEF FireDAC_MONITOR}
    if FSession.Tracing then Trace3;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function TMySQLResult.GetData(AIndex: Integer; var ApData: Pointer;
  var ALen: LongWord): Boolean;
begin
  ALen := Pmy_ulong(NativeUInt(FpLengths) + NativeUInt(AIndex) * SizeOf(my_ulong))^;
  ApData := PPByte(NativeUInt(FpRow) + NativeUInt(AIndex) * SizeOf(PByte))^;
  Result := ApData <> nil;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TMySQLResult.DumpColumns(ARowIndex: Integer);
var
  i: Integer;
  pData: Pointer;
  iLen: LongWord;
  s: String;
begin
  if FSession.Tracing then begin
    FSession.Trace(ekCmdDataOut, esStart, 'Fetched', ['Row', ARowIndex]);
    for i := 0 to FSession.FLib.mysql_num_fields(FCursor) - 1 do begin
      pData := nil;
      iLen := 0;
      if not GetData(i, pData, iLen) then
        s := 'NULL'
      else if iLen > 1024 then
        s := '(truncated at 1024) ''' + FSession.Encoder.Decode(pData, 1024) + ' ...'''
      else
        s := '''' + FSession.Encoder.Decode(pData, iLen) + '''';
      FSession.Trace(ekCmdDataOut, esProgress, 'Column', [String('N'), i,
        'Len', iLen, '@Data', s]);
    end;
    FSession.Trace(ekCmdDataOut, esEnd, 'Fetched', ['Row', ARowIndex]);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TMySQLField                                                                   }
{-------------------------------------------------------------------------------}
constructor TMySQLField.Create(AResult: TMySQLResult);
begin
  inherited Create;
  FResult := AResult;
end;

{-------------------------------------------------------------------------------}
procedure TMySQLField.GetInfo(var name, srcname, table, db: my_pchar;
  var type_: Byte; var length, flags, decimals, charsetnr: LongWord);
var
  pFld0510: PMYSQL_FIELD0510;
  pFld0410: PMYSQL_FIELD0410;
  pFld0401: PMYSQL_FIELD0401;
  pFld0400: PMYSQL_FIELD0400;
  pFld0320: PMYSQL_FIELD0320;
begin
  if FResult.FSession.FLib.FVersion >= mvMySQL050100 then begin
    pFld0510 := PMYSQL_FIELD0510(FpFld);
    name := pFld0510^.name;
    srcname := pFld0510^.org_name;
    table := pFld0510^.org_table;
    db := pFld0510^.db;
    type_ := pFld0510^.type_;
    length := pFld0510^.length;
    if pFld0510^.max_length > length then
      length := pFld0510^.max_length;
    flags := pFld0510^.flags;
    decimals := pFld0510^.decimals;
    charsetnr := pFld0510^.charsetnr;
  end
  else if FResult.FSession.FLib.FVersion >= mvMySQL040101 then begin
    pFld0410 := PMYSQL_FIELD0410(FpFld);
    name := pFld0410^.name;
    srcname := pFld0410^.org_name;
    table := pFld0410^.org_table;
    db := pFld0410^.db;
    type_ := pFld0410^.type_;
    length := pFld0410^.length;
    if pFld0410^.max_length > length then
      length := pFld0410^.max_length;
    flags := pFld0410^.flags;
    decimals := pFld0410^.decimals;
    charsetnr := pFld0410^.charsetnr;
  end
  else if FResult.FSession.FLib.FVersion >= mvMySQL040100 then begin
    pFld0401 := PMYSQL_FIELD0401(FpFld);
    name := pFld0401^.name;
    srcname := pFld0401^.org_name;
    table := pFld0401^.org_table;
    db := pFld0401^.db;
    type_ := pFld0401^.type_;
    length := pFld0401^.length;
    if pFld0401^.max_length > length then
      length := pFld0401^.max_length;
    flags := pFld0401^.flags;
    decimals := pFld0401^.decimals;
    charsetnr := pFld0401^.charsetnr;
  end
  else if FResult.FSession.FLib.FVersion >= mvMySQL040000 then begin
    pFld0400 := PMYSQL_FIELD0400(FpFld);
    name := pFld0400^.name;
    srcname := name;
    table := pFld0400^.org_table;
    db := pFld0400^.db;
    type_ := pFld0400^.type_;
    length := pFld0400^.length;
    if pFld0400^.max_length > length then
      length := pFld0400^.max_length;
    flags := pFld0400^.flags;
    decimals := pFld0400^.decimals;
    charsetnr := 0;
  end
  else begin
    pFld0320 := PMYSQL_FIELD0320(FpFld);
    name := pFld0320^.name;
    srcname := name;
    table := pFld0320^.table;
    db := nil;
    type_ := pFld0320^.type_;
    length := pFld0320^.length;
    if pFld0320^.max_length > length then
      length := pFld0320^.max_length;
    flags := pFld0320^.flags;
    decimals := pFld0320^.decimals;
    charsetnr := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function MySQLNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EMySQLNativeException.Create;
  EMySQLNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EMySQLNativeException, 'MySQLNativeException',
    @MySQLNativeExceptionLoad, @FDExceptionSave);

end.
