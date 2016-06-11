{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                 FireDAC MySQL driver                  }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.MySQL;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Phys;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux64)]
  TFDPhysMySQLDriverLink = class(TFDPhysDriverLink)
  private
    FEmbeddedArgs: TStrings;
    FEmbeddedGroups: TStrings;
    procedure SetEmbeddedArgs(const AValue: TStrings);
    procedure SetEmbeddedGroups(const AValue: TStrings);
  protected
    function GetBaseDriverID: String; override;
    function IsConfigured: Boolean; override;
    procedure ApplyTo(const AParams: IFDStanDefinition); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property EmbeddedArgs: TStrings read FEmbeddedArgs write SetEmbeddedArgs;
    property EmbeddedGroups: TStrings read FEmbeddedGroups write SetEmbeddedGroups;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not expanded"
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, Data.DB, System.SyncObjs, System.Variants, Data.FmtBCD, 
    Data.SqlTimSt, System.DateUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Stan.Util,
    FireDAC.Stan.Consts, FireDAC.Stan.ResStrs,
  FireDAC.UI.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.MySQLCli,
    FireDAC.Phys.MySQLWrapper, FireDAC.Phys.MySQLMeta, FireDAC.Phys.MySQLDef;

type
  TFDPhysMySQLDriver = class;
  TFDPhysMySQLConnection = class;
  TFDPhysMySQLTransaction = class;
  TFDPhysMySQLCommand = class;

  TFDPhysMySQLDriver = class(TFDPhysDriver)
  private
    FLib: TMySQLLib;
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    procedure InternalUnload; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    function GetCliObj: Pointer; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); override;
    destructor Destroy; override;
  end;

  TFDPhysMySQLConnection = class(TFDPhysConnection)
  private
    FSession: TMySQLSession;
    FServerVersion, FClientVersion: TFDVersion;
    FLock: TCriticalSection;
    FResultMode: TFDMySQLResultMode;
    FNameModes: TFDPhysMySQLNameModes;
    FTinyIntFormat: TFDDataType;
    FLastInsertID: my_ulonglong;
    procedure GetServerOutput;
    procedure UpdateInsertId(AForce: Boolean);
  protected
    procedure InternalConnect; override;
    procedure InternalDisconnect; override;
    procedure InternalPing; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateTransaction: TFDPhysTransaction; override;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; override;
{$ENDIF}
    function GetItemCount: Integer; override;
    procedure GetItem(AIndex: Integer; out AName: String;
      out AValue: Variant; out AKind: TFDMoniAdapterItemKind); override;
    procedure InternalChangePassword(const AUserName, AOldPassword, ANewPassword: String); override;
    function InternalCreateMetadata: TObject; override;
    function InternalCreateCommandGenerator(const ACommand: IFDPhysCommand): TFDPhysCommandGenerator; override;
    procedure InternalExecuteDirect(const ASQL: String; ATransaction: TFDPhysTransaction); override;
    function GetMessages: EFDDBEngineException; override;
    function GetCliObj: Pointer; override;
    function InternalGetCliHandle: Pointer; override;
    function GetLastAutoGenValue(const AName: String): Variant; override;
    function QueryValue(const ACmd: String; AColIndex: Integer): String;
    function InternalGetCurrentCatalog: String; override;
    procedure InternalAnalyzeSession(AMessages: TStrings); override;
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
    destructor Destroy; override;
  end;

  TFDPhysMySQLTransaction = class(TFDPhysTransaction)
  protected
    procedure InternalStartTransaction(ATxID: LongWord); override;
    procedure InternalCommit(ATxID: LongWord); override;
    procedure InternalRollback(ATxID: LongWord); override;
    procedure InternalChanged; override;
    procedure InternalNotify(ANotification: TFDPhysTxNotification;
      ACommandObj: TFDPhysCommand); override;
  end;

  TFDPhysMySQLCommand = class(TFDPhysCommand)
  private
    FMetaInfoSQLs: array of String;
    FColIndex: LongWord;
    FCursor: TMySQLResult;
    function GetExpandedSQL(ATimes, AOffset: Integer): TFDByteString;
    function DataValue2MySQL(AData: Pointer; ALen: LongWord; AType: TFDDataType;
      out ATypeSupported: Boolean): TFDByteString;
    function MySQL2DataValue(ASrcData: PByte; ASrcLen: LongWord;
      var ADestData: Pointer; var ADestLen: LongWord; AType: TFDDataType;
      AAttributes: TFDDataAttributes; out ATypeSupported: Boolean): Boolean;
    procedure FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
    procedure FetchMetaRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowIndex: Integer);
    procedure MySQLType2ADType(var AStr: String; var AType: TFDDataType;
      var AAttrs: TFDDataAttributes; var ALen: LongWord; var APrec, AScale: Integer);
    function GetResultMode: TFDMySQLResultMode;
    function FetchFKRows(ATable: TFDDatSTable; AParentRow: TFDDatSRow): Integer;
    function GetCrsData(ACrsCol: Integer; var AData: Pointer;
      var ALen: LongWord; AType: TFDDataType): Boolean; overload;
    function GetCrsData(ACrsCol: Integer; AData: Pointer): String; overload;
    function FetchSPParamRows(ATable: TFDDatSTable;
      AParentRow: TFDDatSRow): Integer;
    procedure GetParamValues(AIndex: Integer);
    procedure GetCursor;
    procedure CloseStatement(AForceClose: Boolean; AIndex: Integer);
    function GetMetaCatalog: String;
  protected
    procedure InternalClose; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; override;
    procedure InternalAbort; override;
    function InternalOpen: Boolean; override;
    function InternalNextRecordSet: Boolean; override;
    procedure InternalPrepare; override;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; override;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; override;
    procedure InternalUnprepare; override;
    function GetCliObj: Pointer; override;
  end;

const
  S_FD_CharacterSets = 'big5;dec8;cp850;hp8;koi8r;latin1;latin2;swe7;ascii;ujis;' +
    'sjis;cp1251;hebrew;tis620;euckr;koi8u;gb2312;greek;cp1250;gbk;latin5;armscii8;' +
    'cp866;keybcs2;macce;macroman;cp852;latin7;cp1256;cp1257;binary;utf8';

  S_FD_StoreResult = 'Store';
  S_FD_UseResult = 'Use';
  S_FD_ChooseResult = 'Choose';

  S_FD_Boolean = 'Boolean';
  S_FD_Integer = 'Integer';

var
  GLock: TCriticalSection;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLDriverLink                                                        }
{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLDriverLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEmbeddedArgs := TFDStringList.Create(#0, ';');
  FEmbeddedGroups := TFDStringList.Create(#0, ';');
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysMySQLDriverLink.Destroy;
begin
  FDFreeAndNil(FEmbeddedArgs);
  FDFreeAndNil(FEmbeddedGroups);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_MySQLId;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLDriverLink.ApplyTo(const AParams: IFDStanDefinition);
begin
  inherited ApplyTo(AParams);
  if FEmbeddedArgs.Count > 0 then
    AParams.AsString[S_FD_ConnParam_MySQL_EmbeddedArgs] := FEmbeddedArgs.DelimitedText;
  if FEmbeddedGroups.Count > 0 then
    AParams.AsString[S_FD_ConnParam_MySQL_EmbeddedGroups] := FEmbeddedGroups.DelimitedText;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLDriverLink.IsConfigured: Boolean;
begin
  Result := inherited IsConfigured or (FEmbeddedArgs.Count > 0) or
    (FEmbeddedGroups.Count > 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLDriverLink.SetEmbeddedArgs(const AValue: TStrings);
begin
  FEmbeddedArgs.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLDriverLink.SetEmbeddedGroups(const AValue: TStrings);
begin
  FEmbeddedGroups.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLDriver                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLDriver.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  GLock := TCriticalSection.Create;
  FLib := TMySQLLib.Create(FDPhysManagerObj);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysMySQLDriver.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLib);
  FDFreeAndNil(GLock);
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMySQLDriver.GetBaseDriverID: String;
begin
  Result := S_FD_MySQLId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMySQLDriver.GetBaseDriverDesc: String;
begin
  Result := 'MySQL Server';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMySQLDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MySQL;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMySQLDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysMySQLConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLDriver.InternalLoad;
var
  sHome, sLib, sEmbArgs, sEmbGrps: String;
begin
  sHome := '';
  sLib := '';
  sEmbArgs := '';
  sEmbGrps := '';
  if Params <> nil then begin
    GetVendorParams(sHome, sLib);
    sEmbArgs := Params.AsString[S_FD_ConnParam_MySQL_EmbeddedArgs];
    sEmbGrps := Params.AsString[S_FD_ConnParam_MySQL_EmbeddedGroups];
  end;
  FLib.Load(sHome, sLib, sEmbArgs, sEmbGrps);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLDriver.InternalUnload;
begin
  FLib.Unload;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysMySQLConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLDriver.GetCliObj: Pointer;
begin
  Result := FLib;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('LoginIndex', 4);
    oView.Rows[0].EndEdit;
  end;

  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, S_FD_Local, S_FD_Local, S_FD_ConnParam_Common_Server, 2]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Port, '@I', IntToStr(MYSQL_PORT), S_FD_ConnParam_Common_Port, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_Compress, '@L', S_FD_True, S_FD_ConnParam_MySQL_Compress, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_UseSSL, '@L', S_FD_False, S_FD_ConnParam_MySQL_UseSSL, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_LoginTimeout, '@I', '', S_FD_ConnParam_Common_LoginTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_ReadTimeout, '@I', '', S_FD_ConnParam_MySQL_ReadTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_WriteTimeout, '@I', '', S_FD_ConnParam_MySQL_WriteTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_ResultMode, S_FD_StoreResult + ';' + S_FD_UseResult + ';' + S_FD_ChooseResult, S_FD_StoreResult, S_FD_ConnParam_MySQL_ResultMode, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_CharacterSet, S_FD_CharacterSets, '', S_FD_ConnParam_Common_CharacterSet, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_TinyIntFormat, S_FD_Boolean + ';' + S_FD_Integer, S_FD_Boolean, S_FD_ConnParam_MySQL_TinyIntFormat, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);

  if (AKeys <> nil) and
     (CompareText(AKeys.Values[S_FD_ConnParam_MySQL_UseSSL], S_FD_True) = 0) then begin
    Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_SSL_key, '@S', '', S_FD_ConnParam_MySQL_SSL_key, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_SSL_cert, '@S', '', S_FD_ConnParam_MySQL_SSL_cert, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_SSL_ca, '@S', '', S_FD_ConnParam_MySQL_SSL_ca, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_SSL_capath, '@S', '', S_FD_ConnParam_MySQL_SSL_capath, -1]);
    Result.Rows.Add([Unassigned, S_FD_ConnParam_MySQL_SSL_cipher, '@S', '', S_FD_ConnParam_MySQL_SSL_cipher, -1]);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLConnection                                                        }
{-------------------------------------------------------------------------------}
constructor TFDPhysMySQLConnection.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  FLock := TCriticalSection.Create;
  inherited Create(ADriverObj, AConnHost);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysMySQLConnection.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLock);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysMySQLCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalCreateTransaction: TFDPhysTransaction;
begin
  Result := TFDPhysMySQLTransaction.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalCreateMetadata: TObject;
begin
  Result := TFDPhysMySQLMetadata.Create(Self, False, FServerVersion,
    FClientVersion, FNameModes,
    (FSession <> nil) and (FSession.Encoder.Encoding in [ecUTF8, ecUTF16]));
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysMySQLCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysMySQLCommandGenerator.Create(Self);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalTracingChanged;
begin
  if FSession <> nil then begin
    FSession.Monitor := FMonitor;
    FSession.Tracing := FTracing;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalConnect;
var
  oParams: TFDPhysMySQLConnectionDefParams;
  sDatabase: String;
  uiClientFlag: LongWord;

  procedure SetTimeout(const AParamName: String; AOption: mysql_option);
  var
    uiTimeout: LongWord;
  begin
    if ConnectionDef.HasValue(AParamName) then begin
      uiTimeout := ConnectionDef.AsInteger[AParamName];
      FSession.Options[AOption] := @uiTimeout;
    end;
  end;

begin
  oParams := ConnectionDef.Params as TFDPhysMySQLConnectionDefParams;

  if InternalGetSharedCliHandle() <> nil then
    FSession := TMySQLSession.CreateUsingHandle(TFDPhysMySQLDriver(DriverObj).FLib,
      PMYSQL(InternalGetSharedCliHandle()), Self)
  else
    FSession := TMySQLSession.Create(TFDPhysMySQLDriver(DriverObj).FLib, Self);
{$IFDEF FireDAC_MONITOR}
  InternalTracingChanged;
{$ENDIF}
  FClientVersion := FSession.ClientVersion;
  if InternalGetSharedCliHandle() = nil then
    FSession.Init;

  FResultMode := oParams.ResultMode;
  if oParams.TinyIntFormat = tifInteger then
    FTinyIntFormat := dtSByte
  else
    FTinyIntFormat := dtBoolean;

  if InternalGetSharedCliHandle() = nil then begin
    if oParams.Compress then
      FSession.Options[MYSQL_OPT_COMPRESS] := nil;
    SetTimeout(S_FD_ConnParam_Common_LoginTimeout, MYSQL_OPT_CONNECT_TIMEOUT);
    SetTimeout(S_FD_ConnParam_MySQL_ReadTimeout, MYSQL_OPT_READ_TIMEOUT);
    SetTimeout(S_FD_ConnParam_MySQL_WriteTimeout, MYSQL_OPT_WRITE_TIMEOUT);

    uiClientFlag := CLIENT_FOUND_ROWS or CLIENT_LONG_FLAG;
    if not IsConsole then
      uiClientFlag := uiClientFlag or CLIENT_INTERACTIVE;
    sDatabase := oParams.ExpandedDatabase;
    if sDatabase <> '' then
      uiClientFlag := uiClientFlag or CLIENT_CONNECT_WITH_DB;
    if oParams.UseSSL then begin
      uiClientFlag := uiClientFlag or CLIENT_SSL;
      FSession.SSLInit(oParams.SSL_key, oParams.SSL_cert, oParams.SSL_ca,
                       oParams.SSL_capath, oParams.SSL_cipher);
    end;
    if FClientVersion >= mvMySQL050000 then
      uiClientFlag := uiClientFlag or FD_50_CLIENT_PROTOCOL_41 or CLIENT_MULTI_QUERIES or
        CLIENT_MULTI_RESULTS
    else if FClientVersion >= mvMySQL040100 then
      uiClientFlag := uiClientFlag or CLIENT_PROTOCOL_41 or CLIENT_MULTI_STATEMENTS;
    if (FClientVersion >= mvMySQL050600) and ConnectionDef.IsSpecified(S_FD_ConnParam_Common_NewPassword) then
      uiClientFlag := uiClientFlag or CLIENT_CAN_HANDLE_EXPIRED_PASSWORDS;

    GLock.Enter;
    try
      FSession.Connect(oParams.Server, oParams.UserName, oParams.Password, sDatabase, oParams.Port, uiClientFlag);
      if (FClientVersion >= mvMySQL050600) and ConnectionDef.IsSpecified(S_FD_ConnParam_Common_NewPassword) then
        InternalExecuteDirect('SET PASSWORD = PASSWORD("' + oParams.NewPassword + '")', nil);
    finally
      GLock.Leave;
    end;
  end;

  FServerVersion := FSession.ServerVersion;
  if FServerVersion < mvMySQL032000 then
    FDException(Self, [S_FD_LPhys, S_FD_MySQLId], er_FD_MySQLBadVersion, [FServerVersion]);

  if InternalGetSharedCliHandle() = nil then begin
    if ConnectionDef.HasValue(S_FD_ConnParam_Common_CharacterSet) then
      FSession.CharacterSetName := ConnectionDef.AsString[S_FD_ConnParam_Common_CharacterSet];
    InternalExecuteDirect('SET SQL_AUTO_IS_NULL = 0', nil);
  end;

  FNameModes := [nmCaseSens, nmDBApply];
  if FServerVersion >= mvMySQL032306 then begin
    case StrToIntDef(QueryValue('SHOW VARIABLES LIKE ''lower_case_table_names''', 1), 0) of
    0: FNameModes := [nmCaseSens];
    1: FNameModes := [nmDefLowerCase];
    2: FNameModes := [];
    end;
    if FServerVersion >= mvMySQL040002 then
      Include(FNameModes, nmDBApply);
  end;
  FLastInsertID := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalDisconnect;
begin
  if FSession <> nil then begin
    GLock.Enter;
    try
      FSession.Disconnect;
    finally
      GLock.Leave;
      FDFreeAndNil(FSession);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalPing;
begin
  FLock.Enter;
  try
    FSession.Ping;
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalExecuteDirect(const ASQL: String;
  ATransaction: TFDPhysTransaction);
begin
  FLock.Enter;
  try
    FSession.Query(ASQL, Self);
    UpdateInsertId(False);
    GetServerOutput;
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.QueryValue(const ACmd: String; AColIndex: Integer): String;
var
  oRes: TMySQLResult;
  pData: Pointer;
  iLen: LongWord;
begin
  FLock.Enter;
  try
    FSession.Query(ACmd, Self);
    oRes := FSession.StoreResult;
    try
      oRes.Fetch(1);
      pData := nil;
      iLen := 0;
      oRes.GetData(AColIndex, pData, iLen);
      Result := FSession.Encoder.Decode(PByte(pData), iLen);
    finally
      FDFree(oRes);
    end;
    GetServerOutput;
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalChangePassword(const AUserName, AOldPassword,
  ANewPassword: String);
var
  s: String;
begin
  FLock.Enter;
  try
    s := QueryValue('SELECT CONCAT(SUBSTRING_INDEX(USER(), ''@'', 1), ''@"'', SUBSTRING_INDEX(USER(), ''@'', -1), ''"'')', 0);
    InternalExecuteDirect('SET PASSWORD FOR ' + s + ' = PASSWORD("' + ANewPassword + '")', nil);
  finally
    FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.UpdateInsertId(AForce: Boolean);
begin
  if (FSession <> nil) and (AForce or (FSession.Insert_ID <> 0)) then
    FLastInsertID := FSession.Insert_ID;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.GetLastAutoGenValue(const AName: String): Variant;
begin
  if FLastInsertID <> 0 then
    Result := FLastInsertID
  else
    Result := Null;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.GetItemCount: Integer;
begin
  Result := inherited GetItemCount;
  if DriverObj.State in [drsLoaded, drsActive] then begin
    Inc(Result, 2);
    if FSession <> nil then
      Inc(Result, 6);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
var
  s: String;
begin
  if AIndex < inherited GetItemCount then
    inherited GetItem(AIndex, AName, AValue, AKind)
  else
    case AIndex - inherited GetItemCount of
    0:
      begin
        AName := 'DLL';
        AValue := TFDPhysMySQLDriver(DriverObj).FLib.DLLName;
        AKind := ikClientInfo;
      end;
    1:
      begin
        AName := 'Client version';
        AValue := IntToStr(TFDPhysMySQLDriver(DriverObj).FLib.Version);
        AKind := ikClientInfo;
      end;
    2:
      begin
        AName := 'Server info';
        AValue := FSession.ServerInfo;
        AKind := ikSessionInfo;
      end;
    3:
      begin
        AName := 'Client info';
        AValue := FSession.ClientInfo;
        AKind := ikSessionInfo;
      end;
    4:
      begin
        AName := 'Characterset name';
        AValue := FSession.CharacterSetName;
        AKind := ikSessionInfo;
      end;
    5:
      begin
        AName := 'Host info';
        AValue := FSession.HostInfo;
        AKind := ikSessionInfo;
      end;
    6:
      begin
        AName := 'Name modes';
        s := '';
        if nmCaseSens in FNameModes then
          s := s + 'CS'
        else
          s := s + 'CI';
        if nmDefLowerCase in FNameModes then
          s := s + 'LC'
        else
          s := s + 'AI';
        if nmDBApply in FNameModes then
          s := s + 'TD'
        else
          s := s + 'T';
        AValue := s;
        AKind := ikSessionInfo;
      end;
    7:
      begin
        AName := 'SSL Cipher';
        AValue := FSession.SSLCipher;
        AKind := ikSessionInfo;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.GetMessages: EFDDBEngineException;
begin
  if FSession <> nil then
    Result := FSession.Info
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.GetCliObj: Pointer;
begin
  Result := FSession;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalGetCliHandle: Pointer;
begin
  if FSession <> nil then
    Result := FSession.MySQL
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnection.InternalGetCurrentCatalog: String;
begin
  if FSession <> nil then
    Result := FSession.DB
  else
    Result := inherited InternalGetCurrentCatalog;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.InternalAnalyzeSession(AMessages: TStrings);
begin
  inherited InternalAnalyzeSession(AMessages);
  if (FServerVersion >= mvMySQL050000) and (FServerVersion < mvMySQL050100) then
    AMessages.Add(Format(S_FD_MySQLWarnNoFK, [FDVerInt2Str(FServerVersion)]));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnection.GetServerOutput;
begin
  if TFDTopResourceOptions(FOptions.ResourceOptions).ServerOutput and
     (FSession.WarningCount > 0) then
    FSession.GetServerOutput;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLTransaction                                                       }
{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLTransaction.InternalChanged;
var
  s: String;
begin
  if xoAutoCommit in GetOptions.Changed then
    TFDPhysMySQLConnection(ConnectionObj).InternalExecuteDirect(
      'SET AUTOCOMMIT = ' + IntToStr(Integer(GetOptions.AutoCommit)), nil);
  if xoIsolation in GetOptions.Changed then begin
    case GetOptions.Isolation of
    xiUnspecified:    Exit;
    xiDirtyRead:      s := 'READ UNCOMMITTED';
    xiReadCommitted:  s := 'READ COMMITTED';
    xiRepeatableRead: s := 'REPEATABLE READ';
    xiSnapshot:       s := 'REPEATABLE READ';
    xiSerializible:   s := 'SERIALIZABLE';
    end;
    TFDPhysMySQLConnection(ConnectionObj).InternalExecuteDirect(
      'SET SESSION TRANSACTION ISOLATION LEVEL ' + s, nil);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLTransaction.InternalStartTransaction(ATxID: LongWord);
begin
  DisconnectCommands(nil, dmRelease);
  TFDPhysMySQLConnection(ConnectionObj).InternalExecuteDirect('BEGIN', nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLTransaction.InternalCommit(ATxID: LongWord);
begin
  DisconnectCommands(nil, dmRelease);
  TFDPhysMySQLConnection(ConnectionObj).InternalExecuteDirect('COMMIT', nil);
  if Retaining then
    InternalStartTransaction(ATxID);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLTransaction.InternalRollback(ATxID: LongWord);
begin
  DisconnectCommands(nil, dmRelease);
  TFDPhysMySQLConnection(ConnectionObj).InternalExecuteDirect('ROLLBACK', nil);
  if Retaining then
    InternalStartTransaction(ATxID);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLTransaction.InternalNotify(ANotification: TFDPhysTxNotification;
  ACommandObj: TFDPhysCommand);
begin
  if (ANotification = cpBeforeCmdExecute) and (
        // When server may have more results, eg in case of CALL <sp>, then
        // next mysql_real_query will give "Commands out of sync" error. See
        // http://dev.mysql.com/doc/refman/5.0/en/c-api-multiple-queries.html
        TFDPhysMySQLConnection(ConnectionObj).FSession.HasMoreResults or
        (TFDPhysMySQLCommand(ACommandObj).GetCommandKind in [skCommit, skRollback])
     ) then
    DisconnectCommands(nil, dmRelease);
  inherited InternalNotify(ANotification, ACommandObj);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMySQLCommand                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetCliObj: Pointer;
begin
  Result := FCursor;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.InternalPrepare;
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  i: Integer;
begin
  // generate metadata SQL command
  if GetMetaInfoKind <> FireDAC.Phys.Intf.mkNone then begin
    GetSelectMetaInfoParams(rName);
    GenerateSelectMetaInfo(rName);
    i := 1;
    while i <= Length(FDbCommandText) do begin
      SetLength(FMetaInfoSQLs, Length(FMetaInfoSQLs) + 1);
      FMetaInfoSQLs[Length(FMetaInfoSQLs) - 1] := FDExtractFieldName(FDbCommandText, i);
    end;
  end

  // generate metadata SQL command
  else if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
    GetConnection.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, []);
    FDbCommandText := '';
    if fiMeta in FOptions.FetchOptions.Items then
      GenerateStoredProcParams(rName);
    if FDbCommandText = '' then
      GenerateStoredProcCall(rName);
  end;

  // adjust SQL command
  GenerateLimitSelect();
  GenerateParamMarkers();
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.InternalUnprepare;
begin
  CloseStatement(True, -1);
  SetLength(FMetaInfoSQLs, 0);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean;
begin
  ASSERT(ATabInfo.FSourceID = -1);
  Result := OpenBlocked;
  if Result then
    if ATabInfo.FSourceID = -1 then begin
      ATabInfo.FSourceName := GetCommandText;
      ATabInfo.FSourceID := 1;
      ATabInfo.FOriginName := '';
      FColIndex := 0;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean;
var
  oFld:     TMySQLField;
  name:     PFDAnsiString;
  srcname:  PFDAnsiString;
  db:       PFDAnsiString;
  table:    PFDAnsiString;
  type_:    Byte;
  length:   LongWord;
  flags:    LongWord;
  decimals: LongWord;
  charset:  LongWord;
  oFmtOpts: TFDFormatOptions;
  eType:    TFDDataType;
  oEnc:     TFDEncoder;

  function IsBinary: Boolean;
  begin
    Result := ((charset = 63) or (charset = 0)) and ((flags and BINARY_FLAG) <> 0);
  end;

begin
  if FColIndex >= FCursor.FieldCount then begin
    Result := False;
    Exit;
  end;
  oFmtOpts := FOptions.FormatOptions;
  oFld := FCursor.Fields[FColIndex];
  name := nil;
  srcname := nil;
  db := nil;
  table := nil;
  type_ := 0;
  length := 0;
  flags := 0;
  decimals := 0;
  charset := 0;
  oFld.GetInfo(name, srcname, table, db, type_, length, flags, decimals, charset);

  // MySQL returns BINARY_FLAG for non-DBMS column based SELECT items,
  // like a DAYNAME(SYSDATE()). So, just workaround this issue.
  if ((srcname = nil) or (srcname^ = TFDAnsiChar(#0))) and
     (type_ = FIELD_TYPE_VAR_STRING) and (flags and BINARY_FLAG <> 0) then begin
    flags := flags and not BINARY_FLAG;
    if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
      length := length * C_FD_MaxUTF8Len;
  end;

  AColInfo.FSourceID := FColIndex + 1;
  oEnc := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder;
  AColInfo.FSourceName := oEnc.Decode(name, -1);
  AColInfo.FOriginColName := oEnc.Decode(srcname, -1);
  AColInfo.FOriginTabName.FCatalog := oEnc.Decode(db, -1);
  AColInfo.FOriginTabName.FObject := oEnc.Decode(table, -1);

  AColInfo.FAttrs := [];
  AColInfo.FForceAddOpts := [];
  if (flags and NOT_NULL_FLAG) = 0 then
    Include(AColInfo.FAttrs, caAllowNull);
  if not (type_ in [FIELD_TYPE_TINY_BLOB, FIELD_TYPE_MEDIUM_BLOB,
                    FIELD_TYPE_LONG_BLOB, FIELD_TYPE_BLOB]) then
    Include(AColInfo.FAttrs, caSearchable);
  if (flags and AUTO_INCREMENT_FLAG) <> 0 then begin
    Include(AColInfo.FAttrs, caAutoInc);
    Include(AColInfo.FAttrs, caAllowNull);
    Include(AColInfo.FForceAddOpts, coAfterInsChanged);
  end;
  if (TFDPhysMySQLConnection(FConnectionObj).FServerVersion >= mvMySQL050200) and
     not (caAutoInc in AColInfo.FAttrs) and
     ((flags and NO_DEFAULT_VALUE_FLAG) = 0) then
    Include(AColInfo.FAttrs, caDefault);

  eType := dtUnknown;
  AColInfo.FLen := 0;
  AColInfo.FPrec := 0;
  AColInfo.FScale := 0;

  case type_ of
  FIELD_TYPE_BIT:
    if length = 1 then
      eType := dtBoolean
    else begin
      eType := dtByteString;
      AColInfo.FLen := (length + 7) div 8;
      Include(AColInfo.FAttrs, caFixedLen);
    end;
  FIELD_TYPE_TINY:
    begin
      if (length = 1) and (TFDPhysMySQLConnection(FConnectionObj).FTinyIntFormat = dtBoolean) then
        eType := dtBoolean
      else if (flags and UNSIGNED_FLAG) <> 0 then
        eType := dtByte
      else
        eType := dtSByte;
      AColInfo.FPrec := length;
    end;
  FIELD_TYPE_SHORT:
    begin
      if (flags and UNSIGNED_FLAG) <> 0 then
        eType := dtUInt16
      else
        eType := dtInt16;
      AColInfo.FPrec := length;
    end;
  FIELD_TYPE_LONG,
  FIELD_TYPE_INT24:
    begin
      if (flags and UNSIGNED_FLAG) <> 0 then
        eType := dtUInt32
      else
        eType := dtInt32;
      AColInfo.FPrec := length;
    end;
  FIELD_TYPE_LONGLONG:
    begin
      if (flags and UNSIGNED_FLAG) <> 0 then
        eType := dtUInt64
      else
        eType := dtInt64;
      AColInfo.FPrec := length;
    end;
  FIELD_TYPE_FLOAT,
  FIELD_TYPE_DOUBLE:
    begin
      if length = 12 then
        eType := dtSingle
      else
        eType := dtDouble;
      AColInfo.FPrec := length;
      AColInfo.FScale := decimals;
    end;
  FIELD_TYPE_DECIMAL,
  FIELD_TYPE_NEWDECIMAL:
    begin
      if decimals = 0 then
        if (flags and UNSIGNED_FLAG) <> 0 then begin
          if length <= 3 then
            eType := dtByte
          else if length <= 5 then
            eType := dtUInt16
          else if length <= 10 then
            eType := dtUInt32
          else if length <= 21 then
            eType := dtUInt64;
        end
        else begin
          if length <= 2 then
            eType := dtSByte
          else if length <= 4 then
            eType := dtInt16
          else if length <= 9 then
            eType := dtInt32
          else if length <= 20 then
            eType := dtInt64;
        end;
      AColInfo.FPrec := length;
      if decimals > 0 then
        Dec(AColInfo.FPrec);
      if (flags and UNSIGNED_FLAG) = 0 then
        Dec(AColInfo.FPrec);
      AColInfo.FScale := decimals;
      if eType = dtUnknown then
        if (AColInfo.FScale <= oFmtOpts.MaxBcdScale) and
           (AColInfo.FPrec <= oFmtOpts.MaxBcdPrecision) then
          eType := dtBCD
        else
          eType := dtFmtBCD;
    end;
  FIELD_TYPE_DATE,
  FIELD_TYPE_NEWDATE:
    eType := dtDate;
  FIELD_TYPE_TIME:
    eType := dtTime;
  FIELD_TYPE_DATETIME:
    eType := dtDateTime;
  FIELD_TYPE_YEAR:
    eType := dtUInt16;
  FIELD_TYPE_TIMESTAMP:
    begin
      eType := dtDateTimeStamp;
      Include(AColInfo.FAttrs, caRowVersion);
      Include(AColInfo.FAttrs, caAllowNull);
    end;
  FIELD_TYPE_ENUM,
  FIELD_TYPE_SET,
  FIELD_TYPE_VAR_STRING,
  FIELD_TYPE_STRING,
  FIELD_TYPE_VARCHAR:
    if length <= oFmtOpts.MaxStringSize then begin
      AColInfo.FLen := length;
      if IsBinary then
        eType := dtByteString
      else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then begin
        eType := dtWideString;
        // MySQL multiplies character length by 3 for UTF8 client character set
        AColInfo.FLen := length div 3;
      end
      else
        eType := dtAnsiString;
      if type_ = FIELD_TYPE_STRING then
        Include(AColInfo.FAttrs, caFixedLen);
    end
    else begin
      if IsBinary then
        eType := dtBlob
      else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
        eType := dtWideMemo
      else
        eType := dtMemo;
      Include(AColInfo.FAttrs, caBlobData);
    end;
  FIELD_TYPE_TINY_BLOB,
  FIELD_TYPE_MEDIUM_BLOB,
  FIELD_TYPE_LONG_BLOB,
  FIELD_TYPE_BLOB:
    if length <= oFmtOpts.MaxStringSize then begin
      AColInfo.FLen := length;
      if IsBinary then
        eType := dtByteString
      else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
        eType := dtWideString
      else
        eType := dtAnsiString;
    end
    else begin
      if IsBinary then
        eType := dtBlob
      else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
        eType := dtWideMemo
      else
        eType := dtMemo;
      Include(AColInfo.FAttrs, caBlobData);
    end;
  FIELD_TYPE_NULL:
    if (flags and NUM_FLAG) <> 0 then
      eType := dtInt32
    else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
      eType := dtWideString
    else
      eType := dtAnsiString;
  end;
  AColInfo.FSourceType := eType;
  if GetMetaInfoKind = mkNone then
    oFmtOpts.ResolveDataType(AColInfo.FSourceName, AColInfo.FSourceTypeName, eType,
      AColInfo.FLen, AColInfo.FPrec, AColInfo.FScale, AColInfo.FType, AColInfo.FLen, True)
  else
    AColInfo.FType := eType;
  Inc(FColIndex);
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.DataValue2MySQL(AData: Pointer; ALen: LongWord;
  AType: TFDDataType; out ATypeSupported: Boolean): TFDByteString;
const
  SDateFmt: String = '''%.4d-%.2d-%.2d''';
  STimeFmt: String = '''%s%.2d:%.2d:%.2d.%.6d''';
  SDateTimeFmt1: String = '''%.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.6d''';
  SDateTimeFmt2: String = '''%.4d%.2d%.2d%.2d%.2d%.2d''';
  SGUIDFmt: String = '''%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x''';
var
  iSz: Integer;
  aBuff: array [0..65] of Char;
  pBuff: PChar;
  s: String;
  dt: TDateTime;
  y, mo, d, h, mi, se, ms: Word;
  sFmt: String;
  rTS: TSQLTimeStamp;

  procedure RetStr(const AStr: String);
  begin
    s := AStr;
    pBuff := PChar(s);
    iSz := Length(s);
  end;

  function EncodeUTF8(AData: Pointer; ALen: LongWord; AEncoding: TFDEncoding): TFDByteString;
  var
    pUTF8: Pointer;
    iSz: Integer;
  begin
    pUTF8 := nil;
    iSz := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.
      Encode(AData, ALen, pUTF8, AEncoding, ecUTF8);
    SetLength(Result, (iSz * 2 + 9) * SizeOf(TFDAnsiChar));
    iSz := TFDPhysMySQLConnection(FConnectionObj).FSession.EscapeString(
      PFDAnsiString(Result) + 6 * SizeOf(TFDAnsiChar), PFDAnsiString(pUTF8), iSz);
    PFDAnsiString(Result)^ := TFDAnsiChar('_');
    (PFDAnsiString(Result) + 1)^ := TFDAnsiChar('u');
    (PFDAnsiString(Result) + 2)^ := TFDAnsiChar('t');
    (PFDAnsiString(Result) + 3)^ := TFDAnsiChar('f');
    (PFDAnsiString(Result) + 4)^ := TFDAnsiChar('8');
    (PFDAnsiString(Result) + 5)^ := TFDAnsiChar('''');
    (PFDAnsiString(Result) + iSz + 6)^ := TFDAnsiChar('''');
    (PFDAnsiString(Result) + iSz + 7)^ := TFDAnsiChar(#0);
    SetLength(Result, iSz + 8);
  end;

begin
  SetLength(Result, 0);
  ATypeSupported := True;
  pBuff := aBuff;
  iSz := SizeOf(aBuff) div SizeOf(Char);
  case AType of
  dtBoolean:
    if TFDPhysMySQLConnection(FConnectionObj).FServerVersion >= mvMySQL050000 then
      if PWordBool(AData)^ then
        RetStr('TRUE')
      else
        RetStr('FALSE')
    else
      if PWordBool(AData)^ then
        RetStr('1')
      else
        RetStr('0');
  dtSByte:
    FDInt2Str(AData, SizeOf(ShortInt), pBuff, iSz, False, 0);
  dtInt16:
    FDInt2Str(AData, SizeOf(SmallInt), pBuff, iSz, False, 0);
  dtInt32:
    FDInt2Str(AData, SizeOf(Integer), pBuff, iSz, False, 0);
  dtInt64:
    FDInt2Str(AData, SizeOf(Int64), pBuff, iSz, False, 0);
  dtByte:
    FDInt2Str(AData, SizeOf(Byte), pBuff, iSz, True, 0);
  dtUInt16:
    FDInt2Str(AData, SizeOf(Word), pBuff, iSz, True, 0);
  dtUInt32:
    FDInt2Str(AData, SizeOf(Cardinal), pBuff, iSz, True, 0);
  dtUInt64:
    FDInt2Str(AData, SizeOf(UInt64), pBuff, iSz, True, 0);
  dtCurrency:
    FDCurr2Str(pBuff, iSz, PCurrency(AData)^, '.');
  dtSingle:
    RetStr(FDFloat2Str(PSingle(AData)^, '.', 8));
  dtDouble:
    RetStr(FDFloat2Str(PDouble(AData)^, '.', 16));
  dtExtended:
    RetStr(FDFloat2Str(PExtended(AData)^, '.', 20));
  dtBCD,
  dtFmtBCD:
    FDBCD2Str(pBuff, iSz, PBcd(AData)^, '.');
  dtDate:
    begin
      rTS := FDDate2SQLTimeStamp(PInteger(AData)^);
      iSz := WideFormatBuf(aBuff[0], iSz, PChar(SDateFmt)^, Length(SDateFmt),
        [rTS.Year, rTS.Month, rTS.Day]);
    end;
  dtTime:
    begin
      rTS := FDTime2SQLTimeStamp(PInteger(AData)^);
      // Delphi does not support negative time value, but MySQL does
      if PInteger(AData)^ < 0 then
        s := '-'
      else
        s := '';
      iSz := WideFormatBuf(aBuff[0], iSz, PChar(STimeFmt)^, Length(STimeFmt),
        [s, rTS.Hour, rTS.Minute, rTS.Second, rTS.Fractions]);
    end;
  dtDateTime:
    begin
      dt := FDMSecs2DateTime(PDateTimeRec(AData)^.DateTime);
      DecodeDate(dt, y, mo, d);
      DecodeTime(dt, h, mi, se, ms);
      iSz := WideFormatBuf(aBuff[0], iSz, PChar(SDateTimeFmt1)^, Length(SDateTimeFmt1),
        [y, mo, d, h, mi, se, ms]);
    end;
  dtDateTimeStamp:
    begin
      rTS := PSQLTimeStamp(AData)^;
      if TFDPhysMySQLConnection(FConnectionObj).FServerVersion >= mvMySQL040100 then
        sFmt := SDateTimeFmt1
      else
        sFmt := SDateTimeFmt2;
      iSz := WideFormatBuf(aBuff[0], iSz, PChar(sFmt)^, Length(sFmt),
        [rTS.Year, rTS.Month, rTS.Day, rTS.Hour, rTS.Minute, rTS.Second, rTS.Fractions]);
    end;
  dtByteString,
  dtBlob:
    if (ALen = 0) and FOptions.FormatOptions.StrsEmpty2Null then
      RetStr('NULL')
    else begin
      SetLength(Result, (ALen * 2 + 4) * SizeOf(TFDAnsiChar));
      FDBin2HexBS(AData, ALen, PByte(Result) + 2 * SizeOf(TFDAnsiChar));
      PFDAnsiString(Result)^ := TFDAnsiChar('x');
      (PFDAnsiString(Result) + 1)^ := TFDAnsiChar('''');
      (PFDAnsiString(Result) + ALen * 2 + 2)^ := TFDAnsiChar('''');
      (PFDAnsiString(Result) + ALen * 2 + 3)^ := TFDAnsiChar(#0);
    end;
  dtAnsiString,
  dtMemo:
    if (ALen = 0) and FOptions.FormatOptions.StrsEmpty2Null then
      RetStr('NULL')
    else if TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encoding = ecUTF8 then
      Result := EncodeUTF8(AData, ALen, ecANSI)
    else begin
      SetLength(Result, (ALen * 2 + 4) * SizeOf(TFDAnsiChar));
      iSz := TFDPhysMySQLConnection(FConnectionObj).FSession.EscapeString(
        PFDAnsiString(PByte(Result)) + 1 * SizeOf(TFDAnsiChar),
        PFDAnsiString(AData), ALen);
      PFDAnsiString(Result)^ := TFDAnsiChar('''');
      (PFDAnsiString(Result) + iSz + 1)^ := TFDAnsiChar('''');
      (PFDAnsiString(Result) + iSz + 2)^ := TFDAnsiChar(#0);
      SetLength(Result, iSz + 3);
    end;
  dtWideString,
  dtWideMemo,
  dtXML:
    if (ALen = 0) and FOptions.FormatOptions.StrsEmpty2Null then
      RetStr('NULL')
    else
      Result := EncodeUTF8(AData, ALen, ecUTF16);
  dtGUID:
    iSz := WideFormatBuf(aBuff[0], iSz, PChar(SGUIDFmt)^, Length(SGUIDFmt),
      [PGUID(AData)^.D1, PGUID(AData)^.D2, PGUID(AData)^.D3, PGUID(AData)^.D4[0],
       PGUID(AData)^.D4[1], PGUID(AData)^.D4[2], PGUID(AData)^.D4[3],
       PGUID(AData)^.D4[4], PGUID(AData)^.D4[5], PGUID(AData)^.D4[6],
       PGUID(AData)^.D4[7]]);
  else
    ATypeSupported := False;
  end;
  if Length(Result) = 0 then
    Result := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Encode(pBuff, iSz);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.MySQL2DataValue(ASrcData: PByte; ASrcLen: LongWord;
  var ADestData: Pointer; var ADestLen: LongWord; AType: TFDDataType;
  AAttributes: TFDDataAttributes; out ATypeSupported: Boolean): Boolean;
var
  wYear, wMonth, wDay, wHour, wMin, wSec, wMSec: Word;
  lwFrac: Cardinal;
  iBase: Integer;
  lNeg: Boolean;
  iSz: Integer;
  aBuff: array [0..65] of Char;
  pBuff: PChar;
begin
  Result := True;
  ADestLen := 0;
  ATypeSupported := True;
  if not (AType in [dtAnsiString, dtMemo, dtWideString, dtWideMemo, dtByteString, dtBlob]) then begin
    pBuff := aBuff;
    iSz := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Decode(
      ASrcData, ASrcLen, Pointer(pBuff));
  end
  else begin
    iSz := 0;
    pBuff := nil;
  end;
  case AType of
  dtBoolean:
    PWordBool(ADestData)^ := (pBuff^ <> '0') and (pBuff^ <> #0);
  dtSByte:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(ShortInt), False);
  dtInt16:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(SmallInt), False);
  dtInt32:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(Integer), False);
  dtInt64:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(Int64), False);
  dtByte:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(Byte), True);
  dtUInt16:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(Word), True);
  dtUInt32:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(Cardinal), True);
  dtUInt64:
    FDStr2Int(pBuff, iSz, ADestData, SizeOf(UInt64), True);
  dtSingle:
    FDStr2Float(pBuff, iSz, ADestData, SizeOf(Single), '.');
  dtDouble:
    FDStr2Float(pBuff, iSz, ADestData, SizeOf(Double), '.');
  dtExtended:
    FDStr2Float(pBuff, iSz, ADestData, SizeOf(Extended), '.');
  dtCurrency:
    FDStr2Curr(pBuff, iSz, PCurrency(ADestData)^, '.');
  dtBCD,
  dtFmtBCD:
    FDStr2BCD(pBuff, iSz, PBcd(ADestData)^, '.');
  dtDate:
    begin
      FDStr2Int(pBuff,     4, @wYear, SizeOf(Word), True);
      FDStr2Int(pBuff + 5, 2, @wMonth, SizeOf(Word), True);
      FDStr2Int(pBuff + 8, 2, @wDay, SizeOf(Word), True);
      if (wYear = 0) and (wMonth = 0) and (wDay = 0) then begin
        PInteger(ADestData)^ := 0;
        Result := False;
      end
      else
        PInteger(ADestData)^ := FDDateTime2Date(EncodeDate(wYear, wMonth, wDay));
    end;
  dtTime:
    begin
      if pBuff^ = '-' then begin
        lNeg := True;
        Inc(pBuff);
      end
      else
        lNeg := False;
      FDStr2Int(pBuff,     2, @wHour, SizeOf(Word), True);
      FDStr2Int(pBuff + 3, 2, @wMin, SizeOf(Word), True);
      FDStr2Int(pBuff + 6, 2, @wSec, SizeOf(Word), True);
      if pBuff[8] = '.' then begin
        FDStr2Int(pBuff + 9, 6, @lwFrac, SizeOf(Cardinal), True);
        wMSec := lwFrac div 1000;
      end
      else
        wMSec := 0;
      PInteger(ADestData)^ := FDDateTime2Time(EncodeTime(wHour, wMin, wSec, wMSec));
      // Delphi does not support negative time value, and
      // TimeToStr for -0.123 returns the same value as for 0.123
      if lNeg then
        PInteger(ADestData)^ := - PInteger(ADestData)^;
    end;
  dtDateTime:
    begin
      FDStr2Int(pBuff,     4, @wYear, SizeOf(Word), True);
      FDStr2Int(pBuff + 5, 2, @wMonth, SizeOf(Word), True);
      FDStr2Int(pBuff + 8, 2, @wDay, SizeOf(Word), True);
      if (wYear = 0) and (wMonth = 0) and (wDay = 0) then begin
        PDateTimeRec(ADestData)^.DateTime := 0;
        Result := False;
      end
      else begin
        if pBuff[10] = #0 then begin
          wHour := 0;
          wMin := 0;
          wSec := 0;
          wMSec := 0;
        end
        else begin
          FDStr2Int(pBuff + 11, 2, @wHour, SizeOf(Word), True);
          FDStr2Int(pBuff + 14, 2, @wMin, SizeOf(Word), True);
          FDStr2Int(pBuff + 17, 2, @wSec, SizeOf(Word), True);
          if pBuff[19] = '.' then begin
            FDStr2Int(pBuff + 20, 6, @lwFrac, SizeOf(Cardinal), True);
            wMSec := lwFrac div 1000;
          end
          else
            wMSec := 0;
        end;
        PDateTimeRec(ADestData)^.DateTime := FDDateTime2MSecs(
          EncodeDateTime(wYear, wMonth, wDay, wHour, wMin, wSec, wMSec));
      end;
    end;
  dtDateTimeStamp:
    begin
      if iSz >= 19 then begin
        FDStr2Int(pBuff,     4, @wYear, SizeOf(Word), True);
        FDStr2Int(pBuff + 5, 2, @wMonth, SizeOf(Word), True);
        FDStr2Int(pBuff + 8, 2, @wDay, SizeOf(Word), True);
        FDStr2Int(pBuff + 11,2, @wHour, SizeOf(Word), True);
        FDStr2Int(pBuff + 14,2, @wMin, SizeOf(Word), True);
        FDStr2Int(pBuff + 17,2, @wSec, SizeOf(Word), True);
        if pBuff[19] = '.' then begin
          FDStr2Int(pBuff + 20, 6, @lwFrac, SizeOf(Cardinal), True);
          wMSec := lwFrac div 1000;
        end
        else
          wMSec := 0;
      end
      else begin
        wYear := 0;
        wMonth := 0;
        wDay := 0;
        wHour := 0;
        wMin := 0;
        wSec := 0;
        wMSec := 0;
        if (iSz = 14) or (iSz = 8) then begin
          FDStr2Int(pBuff, 4, @wYear, SizeOf(Word), True);
          iBase := 4;
        end
        else begin
          FDStr2Int(pBuff, 2, @wYear, SizeOf(Word), True);
          iBase := 2;
        end;
        if iSz > 2 then begin
          FDStr2Int(pBuff + iBase, 2, @wMonth, SizeOf(Word), True);
          if iSz > 4 then begin
            FDStr2Int(pBuff + iBase + 2, 2, @wDay, SizeOf(Word), True);
            if iSz >= 10 then begin
              FDStr2Int(pBuff + iBase + 4, 2, @wHour, SizeOf(Word), True);
              FDStr2Int(pBuff + iBase + 6, 2, @wMin, SizeOf(Word), True);
              if iSz > 10 then
                FDStr2Int(pBuff + iBase + 8, 2, @wSec, SizeOf(Word), True);
            end;
          end;
        end;
      end;
      if (wYear = 0) and (wMonth = 0) and (wDay = 0) then begin
        FillChar(PSQLTimeStamp(ADestData)^, SizeOf(TSQLTimeStamp), 0);
        Result := False;
      end
      else begin
        PSQLTimeStamp(ADestData)^.Year := wYear;
        PSQLTimeStamp(ADestData)^.Month := wMonth;
        PSQLTimeStamp(ADestData)^.Day := wDay;
        PSQLTimeStamp(ADestData)^.Hour := wHour;
        PSQLTimeStamp(ADestData)^.Minute := wMin;
        PSQLTimeStamp(ADestData)^.Second := wSec;
        PSQLTimeStamp(ADestData)^.Fractions := wMSec;
      end;
    end;
  dtAnsiString,
  dtMemo:
    begin
      ADestData := ASrcData;
      ADestLen := ASrcLen;
      if (caFixedLen in AAttributes) and GetOptions.FormatOptions.StrsTrim then
        while (ADestLen > 0) and (PFDAnsiString(ADestData)[ADestLen - 1] = TFDAnsiChar(' ')) do
          Dec(ADestLen);
      if (ADestLen = 0) and GetOptions.FormatOptions.StrsEmpty2Null then
        Result := False;
    end;
  dtWideString,
  dtWideMemo:
    begin
      ADestLen := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Decode(
        ASrcData, ASrcLen, ADestData, ecUTF16);
      if (caFixedLen in AAttributes) and GetOptions.FormatOptions.StrsTrim then
        while (ADestLen > 0) and (PWideChar(ADestData)[ADestLen - 1] = ' ') do
          Dec(ADestLen);
      if (ADestLen = 0) and GetOptions.FormatOptions.StrsEmpty2Null then
        Result := False;
    end;
  dtByteString,
  dtBlob:
    begin
      ADestData := ASrcData;
      ADestLen := ASrcLen;
      if (caFixedLen in AAttributes) and GetOptions.FormatOptions.StrsTrim then
        while (ADestLen > 0) and (PByte(ADestData)[ADestLen - 1] = 0) do
          Dec(ADestLen);
      if (ADestLen = 0) and GetOptions.FormatOptions.StrsEmpty2Null then
        Result := False;
    end;
  else
    Result := False;
    ATypeSupported := False;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetExpandedSQL(ATimes, AOffset: Integer): TFDByteString;
var
  pSrcCh, pDestCh, pDestEnd: PByte;
  i, iOrigLen, iFullLen, iPar, iRow: Integer;
  sSQL, sValues: String;
  sSubst, sEncSQL, sNULL, sQMark: TFDByteString;
  oParam: TFDParam;
  iSize, iSrcDataLen, iDestDataLen: LongWord;
  iPrec, iScale: Integer;
  iFieldType: TFieldType;
  iSrcDataType, iDestDataType: TFDDataType;
  oFmtOpts: TFDFormatOptions;
  lTypeSupported: Boolean;
  oParams: TFDParams;
  oStr: TStream;
  oEnc: TFDEncoder;

  procedure ErrorParamType(const AReason: String);
  begin
    FDException(Self, [S_FD_LPhys, S_FD_MySQLId], er_FD_MySQLBadParams,
      [oParam.Name, AReason]);
  end;

  procedure ExtendDest(AMinLen: Integer);
  var
    iPos: Integer;
  begin
    if AMinLen < 1024 then
      AMinLen := 1024;
    if pDestCh = nil then
      iPos := 0
    else
      iPos := pDestCh - PByte(Result);
    SetLength(Result, oEnc.EncodedLength(Result) + AMinLen);
    pDestCh := PByte(Result) + iPos;
    pDestEnd := PByte(Result) + oEnc.EncodedLength(Result);
  end;

  procedure WriteDest(const AStr: TFDByteString);
  var
    iLen: Integer;
  begin
    iLen := oEnc.EncodedLength(AStr);
    if pDestCh + iLen >= pDestEnd then
      ExtendDest(iLen);
    Move(PByte(AStr)^, pDestCh^, iLen * SizeOf(TFDAnsiChar));
    Inc(pDestCh, iLen);
  end;

begin
  oEnc := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder;
  sSQL := FDbCommandText;
  if (GetCommandKind in [skInsert, skMerge]) and (FSQLValuesPos > 0) and (ATimes - AOffset > 1) then begin
    if FSQLValuesPosEnd = 0 then
      FSQLValuesPosEnd := Length(sSQL);
    sValues := ',' + Copy(sSQL, FSQLValuesPos + 6, FSQLValuesPosEnd - (FSQLValuesPos + 6) + 1);
    iOrigLen := Length(sSQL);
    iFullLen := iOrigLen + (ATimes - 2 - AOffset + 1) * Length(sValues);
    SetLength(sSQL, iFullLen);
    if FSQLValuesPosEnd < Length(FDbCommandText) then
      Move(sSQL[FSQLValuesPosEnd + 1], sSQL[iFullLen - (iOrigLen - FSQLValuesPosEnd) + 1],
        (iOrigLen - FSQLValuesPosEnd) * SizeOf(Char));
    for i := AOffset to ATimes - 2 do
      Move(sValues[1], sSQL[FSQLValuesPosEnd + 1 + (i - AOffset) * Length(sValues)],
        Length(sValues) * SizeOf(Char));
  end;
  sEncSQL := oEnc.Encode(sSQL);
  oParams := GetParams();
  if oParams.Count = 0 then
    Result := sEncSQL
  else begin
    oFmtOpts := GetOptions.FormatOptions;
    pSrcCh := PByte(sEncSQL);
    pDestCh := nil;
    ExtendDest(0);
    iPar := 0;
    iRow := AOffset;
    SetLength(sNULL, 0);
    SetLength(sQMark, 0);
    while True do begin
                                                                                                       
      while (PFDAnsiString(pSrcCh)^ <> TFDAnsiChar(#0)) and
            (PFDAnsiString(pSrcCh)^ <> TFDAnsiChar('?')) do begin
        if pDestCh = pDestEnd then
          ExtendDest(0);
        pDestCh^ := pSrcCh^;
        Inc(pDestCh);
        Inc(pSrcCh);
      end;
      if PFDAnsiString(pSrcCh)^ = TFDAnsiChar(#0) then
        Break
      else if PFDAnsiString(pSrcCh)^ = TFDAnsiChar('?') then begin
        oParam := nil;
        while True do begin
          case GetParams.BindMode of
          pbByName:   oParam := oParams.FindParam(oParams.Markers[iPar]);
          pbByNumber: oParam := oParams.FindParam(iPar + 1);
          end;
          if (oParam = nil) or (oParam.ParamType in [ptUnknown, ptInput, ptInputOutput]) then
            Break;
          if iPar = oParams.Markers.Count - 1 then begin
            oParam := nil;
            Break;
          end;
          Inc(iPar);
        end;
        if oParam <> nil then begin
          // check parameter definition
          if oParam.ParamType in [ptOutput, ptResult] then
            ErrorParamType('Output parameters are not supported');
          if oParam.DataType = ftUnknown then
            ParTypeUnknownError(oParam);
          lTypeSupported := True;
          iFieldType := ftUnknown;
          iSize := 0;
          iPrec := 0;
          iSrcDataType := dtUnknown;
          iDestDataType := dtUnknown;
          iDestDataLen := 0;
          oFmtOpts.ResolveFieldType('', oParam.DataTypeName, oParam.DataType, oParam.FDDataType,
            oParam.Size, oParam.Precision, oParam.NumericScale, iFieldType, iSize, iPrec, iScale,
            iSrcDataType, iDestDataType, False);

          // null
          if oParam.IsNulls[iRow] then begin
            if Length(sNULL) = 0 then
              sNULL := oEnc.Encode('NULL');
            sSubst := sNULL;
          end

          // assign BLOB stream
          else if oParam.IsStreams[iRow] then begin
            oStr := oParam.AsStreams[iRow];
            if (oStr = nil) or (oStr.Size < 0) then
              UnsupParamObjError(oParam);
            iSize := oStr.Size;
            FBuffer.Check(iSize);
            oStr.Position := 0;
            oStr.Read(FBuffer.Ptr^, iSize);
            sSubst := DataValue2MySQL(FBuffer.Ptr, iSize, iDestDataType,
              lTypeSupported);
          end

          // scalar value
          else begin
            iSrcDataLen := oParam.GetDataLength(iRow);
            // approximating destination data size and allocate buffer
            FBuffer.Extend(iSrcDataLen, iDestDataLen, iSrcDataType, iDestDataType);
            // fill buffer with value, converting it, if required
            oParam.GetData(FBuffer.Ptr, iRow);
            oFmtOpts.ConvertRawData(iSrcDataType, iDestDataType, FBuffer.Ptr,
              iSrcDataLen, FBuffer.FBuffer, FBuffer.Size, iDestDataLen, oEnc);
            sSubst := DataValue2MySQL(FBuffer.Ptr, iDestDataLen, iDestDataType,
              lTypeSupported);
          end;

          if not lTypeSupported then
            ParTypeMapError(oParam);
          WriteDest(sSubst);
          Inc(iPar);
          if iPar >= oParams.Markers.Count then begin
            iPar := 0;
            Inc(iRow);
          end;
        end
        else begin
          if Length(sQMark) = 0 then
            sQMark := oEnc.Encode('?');
          WriteDest(sQMark);
        end;
      end;
      Inc(pSrcCh);
    end;
    iFullLen := pDestCh - PByte(Result);
    SetLength(Result, iFullLen + 1);
    (PFDAnsiString(Result) + iFullLen)^ := TFDAnsiChar(#0);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetResultMode: TFDMySQLResultMode;
var
  oCon: TFDPhysMySQLConnection;
begin
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  case oCon.FResultMode of
  rmStore:
    Result := rmStore;
  rmUse:
    Result := rmUse;
  rmChoose:
    if FOptions.FetchOptions.Mode in [fmAll, fmExactRecsMax] then
      Result := rmStore
    else
      Result := rmUse;
  else
    Result := rmStore;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.GetCursor;
var
  oCon: TFDPhysMySQLConnection;
begin
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  repeat
    FDFreeAndNil(FCursor);
    if GetResultMode = rmStore then
      FCursor := oCon.FSession.StoreResult
    else
      FCursor := oCon.FSession.UseResult;
  until (FCursor <> nil) or
        not oCon.FSession.MoreResults or
        not oCon.FSession.NextResult;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
var
  sSQL: TFDByteString;
  oCon: TFDPhysMySQLConnection;
  i: Integer;
  iCount: TFDCounter;
  iRows: Int64;
begin
  ACount := 0;
  // For a while driver can create batch only for INSERT INTO statement.
  // Probably, may be used similar to FB EXECUTE BLOCK technique.
  if (GetCommandKind in [skInsert, skMerge]) and (FSQLValuesPos > 0) and (ATimes - AOffset > 1) then
    sSQL := GetExpandedSQL(ATimes, AOffset)
  // otherwise just emulate batch
  else if ATimes - AOffset > 1 then begin
    for i := AOffset to ATimes - 1 do begin
      iCount := 0;
      try
        InternalExecute(i + 1, i, iCount);
      finally
        Inc(ACount, iCount);
      end;
      CheckExact(False, 1, 0, iCount, False);
    end;
    Exit;
  end
  else
    sSQL := GetExpandedSQL(ATimes, AOffset);
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  oCon.FLock.Enter;
  try
    try
      try
        oCon.FSession.QuerySB(sSQL, Self);
      except
        on E: EMySQLNativeException do begin
          if ATimes - AOffset = 1 then
            E.Errors[0].RowIndex := AOffset;
          raise;
        end;
      end;
    finally
      if FCursor = nil then begin
        iRows := oCon.FSession.AffectedRows;
        if iRows > 0 then
          Inc(ACount, iRows);
      end;
    end;
    CloseStatement(True, AOffset);
    oCon.GetServerOutput;
    if not (GetCommandKind in [skSelect, skSelectForLock, skSelectForUnLock]) then
      oCon.UpdateInsertId(True);
  finally
    oCon.FLock.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.InternalAbort;
var
  oCon: TFDPhysMySQLConnection;
begin
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  if oCon.FServerVersion >= mvMySQL050000 then
    oCon.FSession.KillQuery
  else
    inherited InternalAbort;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.InternalOpen: Boolean;
var
  sSQL: TFDByteString;
  iSQL: Integer;
  oCon: TFDPhysMySQLConnection;
  oEnc: TFDEncoder;
begin
  if FCursor = nil then begin
    oCon := TFDPhysMySQLConnection(FConnectionObj);
    oEnc := oCon.FSession.Encoder;
    iSQL := 0;
    if not (GetMetaInfoKind in [mkNone, mkForeignKeys, mkForeignKeyFields]) then
      if Length(FMetaInfoSQLs) = 0 then
        SetLength(sSQL, 0)
      else
        sSQL := oEnc.Encode(FMetaInfoSQLs[0])
    else
      sSQL := GetExpandedSQL(1, 0);
    while oEnc.EncodedLength(sSQL) <> 0 do begin
      oCon.FLock.Enter;
      try
        try
          oCon.FSession.QuerySB(sSQL, Self);
          SetLength(sSQL, 0);
          GetCursor;
          if GetMetaInfoKind = mkNone then
            GetParamValues(-1);
          if FCursor = nil then begin
            oCon.GetServerOutput;
            if not (GetCommandKind in [skSelect, skSelectForLock, skSelectForUnLock]) then
              oCon.UpdateInsertId(True);
          end;
        except
          on E: EMySQLNativeException do
            if GetMetaInfoKind <> mkNone then begin
              Inc(iSQL);
              if iSQL = Length(FMetaInfoSQLs) then
                if E.Kind = ekObjNotExists then
                  SetLength(sSQL, 0)
                else
                  raise
              else
                sSQL := oEnc.Encode(FMetaInfoSQLs[iSQL]);
            end
            else
              raise;
        end;
      finally
        oCon.FLock.Leave;
      end;
    end;
  end;
  Result := (FCursor <> nil);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.InternalNextRecordSet: Boolean;
var
  oCon: TFDPhysMySQLConnection;
begin
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  oCon.FLock.Enter;
  try
    InternalClose;
    Result := oCon.FSession.MoreResults;
    if Result then begin
      Result := oCon.FSession.NextResult;
      if Result then begin
        GetCursor;
        if GetMetaInfoKind = mkNone then
          GetParamValues(-1);
      end;
    end;
    if FCursor = nil then
      oCon.GetServerOutput;
  finally
    oCon.FLock.Leave;
  end;
  Result := (FCursor <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.GetParamValues(AIndex: Integer);
var
  oTab: TFDDatSTable;
  i, j: Integer;
  s: String;
  v: Variant;
  oParams: TFDParams;
  oPar: TFDParam;
  ePrevState: TFDPhysCommandState;
  rState: TFDDatSLoadState;
begin
  if (FCursor <> nil) and not TFDPhysMySQLConnection(FConnectionObj).FSession.MoreResults and
     (GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs]) then begin
    if AIndex < 0 then
      AIndex := 0;
    oParams := GetParams();
    oTab := TFDDatSTable.Create;
    oTab.Setup(FOptions);
    ePrevState := GetState;
    SetState(csOpen);
    try
      Define(oTab);
      oTab.BeginLoadData(rState, lmHavyFetching);
      try
        FCursor.Fetch(1);
        FetchRow(oTab, nil);
        for i := 0 to oTab.Columns.Count - 1 do begin
          oPar := oParams.FindParam(oTab.Columns[i].Name);
          if (oPar <> nil) and (oPar.ParamType in [ptOutput, ptInputOutput, ptResult]) then begin
            v := oTab.Rows[0].GetData(i);
            case oPar.DataType of
            ftSingle,
            ftFloat,
            ftExtended,
            ftCurrency,
            ftBCD, ftFMTBcd:
              if FormatSettings.DecimalSeparator <> '.' then begin
                s := v;
                j := Pos('.', s);
                if j <> 0 then
                  s[j] := FormatSettings.DecimalSeparator;
                oPar.Values[AIndex] := s;
              end
              else
                oPar.Values[AIndex] := v;
            ftBoolean:
              begin
                s := Trim(UpperCase(v));
                oPar.Values[AIndex] := (s = '1') or (s = 'TRUE');
              end;
            else
              oPar.Values[AIndex] := v;
            end;
          end;
        end;
        GetCursor;
      finally
        oTab.EndLoadData(rState);
      end;
    finally
      SetState(ePrevState);
      FDFree(oTab);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.InternalClose;
begin
  CloseStatement(False, -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.CloseStatement(AForceClose: Boolean; AIndex: Integer);
var
  oCon: TFDPhysMySQLConnection;
begin
  oCon := TFDPhysMySQLConnection(FConnectionObj);
  if AForceClose or not GetNextRecordSet then begin
    while oCon.FSession.MoreResults and oCon.FSession.NextResult do begin
      GetCursor;
      if GetMetaInfoKind = mkNone then
        GetParamValues(AIndex);
    end;
  end;
  FDFreeAndNil(FCursor);
  if not GetNextRecordSet then
    oCon.GetServerOutput;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  oRow: TFDDatSRow;
  oCol: TFDDatSColumn;
  j: Integer;
  iSrcLen, iDestLen: LongWord;
  pSrcData: PByte;
  pDestData: Pointer;
  lHasValue, lTypeSupported: Boolean;
begin
  oRow := ATable.NewRow(False);
  try
    for j := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[j];
      if (oCol.SourceID > 0) and CheckFetchColumn(oCol.SourceDataType, oCol.Attributes) then begin
        lTypeSupported := True;
        // if need conversion
        if oCol.SourceDataType <> oCol.DataType then begin
          pSrcData := nil;
          iSrcLen := 0;
          lHasValue := FCursor.GetData(ocol.SourceID - 1, Pointer(pSrcData), iSrcLen);
          if lHasValue then begin
            pDestData := FBuffer.Check((iSrcLen + 1) * SizeOf(WideChar));
            iDestLen := 0;
            lHasValue := MySQL2DataValue(pSrcData, iSrcLen, pDestData, iDestLen,
              oCol.SourceDataType, oCol.Attributes, lTypeSupported);
          end;
          if lHasValue then
            FOptions.FormatOptions.ConvertRawData(oCol.SourceDataType, oCol.DataType,
              pDestData, iDestLen, pDestData, FBuffer.Size, iDestLen,
              TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder);
        end
        // if dont need conversion
        else begin
          lHasValue := FCursor.GetData(oCol.SourceID - 1, Pointer(pSrcData), iSrcLen);
          if lHasValue then begin
            pDestData := FBuffer.Check((iSrcLen + 1) * SizeOf(WideChar));
            lHasValue := MySQL2DataValue(pSrcData, iSrcLen, pDestData, iDestLen,
              oCol.SourceDataType, oCol.Attributes, lTypeSupported);
          end;
        end;
        if not lTypeSupported then
          ColTypeMapError(oCol);
        // set data
        if lHasValue then
          oRow.SetData(j, pDestData, iDestLen)
        else
          oRow.SetData(j, nil, 0);
      end;
    end;
    ATable.Rows.Add(oRow);
  except
    FDFree(oRow);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.MySQLType2ADType(var AStr: String; var AType: TFDDataType;
  var AAttrs: TFDDataAttributes; var ALen: LongWord; var APrec, AScale: Integer);
var
  i1, i2: Integer;
  iLen: LongWord;
  sType, sArgs, sMod: String;
  lUnsigned: Boolean;
  oFmt: TFDFormatOptions;

  procedure SetPrecScale(ADefPrec, ADefScale: Integer);
  var
    sPrec, sScale: String;
    i: Integer;
  begin
    i := Pos(',', sArgs);
    if i = 0 then
      sPrec := sArgs
    else begin
      sPrec := Copy(sArgs, 1, i - 1);
      sScale := Copy(sArgs, i + 1, Length(sArgs));
    end;
    APrec := StrToIntDef(sPrec, ADefPrec);
    AScale := StrToIntDef(sScale, ADefScale);
  end;

  procedure SetLen(ADefLen: Integer);
  begin
    ALen := StrToIntDef(sArgs, ADefLen);
  end;

begin
  i1 := Pos('(', AStr);
  i2 := Pos(')', AStr);
  if i1 = 0 then begin
    i1 := Pos(' ', AStr);
    if i1 = 0 then begin
      sType := UpperCase(AStr);
      sArgs := '';
      sMod := '';
    end
    else begin
      sType := UpperCase(Copy(AStr, 1, i1 - 1));
      sArgs := '';
      sMod := UpperCase(Copy(AStr, i1 + 1, Length(AStr)));
    end;
  end
  else begin
    sType := UpperCase(Copy(AStr, 1, i1 - 1));
    sArgs := Copy(AStr, i1 + 1, i2 - i1 - 1);
    sMod := UpperCase(Copy(AStr, i2 + 1, Length(AStr)));
  end;
  lUnsigned := Pos(' UNSIGNED', sMod) <> 0;
  AType := dtUnknown;
  AAttrs := [caSearchable];
  ALen := 0;
  APrec := 0;
  AScale := 0;
  if sType = 'ENUM' then begin
    AType := dtAnsiString;
    AAttrs := [caSearchable];
    i1 := 1;
    repeat
      i2 := Pos(',', sArgs, i1);
      if i2 = 0 then
        i2 := Length(sArgs) + 1;
      iLen := i2 - i1;
      if sArgs[i1] = '''' then
        Dec(iLen, 2);
      if ALen < iLen then
        ALen := iLen;
      i1 := i2 + 1;
    until i2 > Length(sArgs);
  end
  else if sType = 'SET' then begin
    AType := dtAnsiString;
    AAttrs := [caSearchable];
    i1 := 1;
    repeat
      i2 := Pos(',', sArgs, i1);
      if i2 = 0 then
        i2 := Length(sArgs) + 1;
      iLen := i2 - i1;
      if sArgs[i1] = '''' then
        Dec(iLen, 2);
      Inc(ALen, Longword(iLen + 1));
      i1 := i2 + 1;
    until i2 > Length(sArgs);
  end
  else if sType = 'TINYINT' then begin
    SetPrecScale(0, 0);
    if (APrec = 1) and (TFDPhysMySQLConnection(FConnectionObj).FTinyIntFormat = dtBoolean) then
      AType := dtBoolean
    else if lUnsigned then
      AType := dtByte
    else
      AType := dtSByte;
  end
  else if sType = 'BIT' then begin
    AType := dtByteString;
    SetLen(1);
    ALen := (ALen + 7) div 8;
    Include(AAttrs, caFixedLen);
  end
  else if sType = 'BOOL' then
    AType := dtBoolean
  else if sType = 'SMALLINT' then begin
    SetPrecScale(0, 0);
    if lUnsigned then
      AType := dtUInt16
    else
      AType := dtInt16;
  end
  else if (sType = 'MEDIUMINT') or (sType = 'INTEGER') or (sType = 'INT') then begin
    SetPrecScale(0, 0);
    if lUnsigned then
      AType := dtUInt32
    else
      AType := dtInt32;
  end
  else if sType = 'BIGINT' then begin
    SetPrecScale(0, 0);
    if lUnsigned then
      AType := dtUInt64
    else
      AType := dtInt64
  end
  else if (sType = 'FLOAT') or (sType = 'DOUBLE') or (sType = 'REAL') then begin
    SetPrecScale(0, 0);
    if APrec > 16 then begin
      oFmt := FOptions.FormatOptions;
      if (APrec <= oFmt.MaxBcdPrecision) and (AScale <= oFmt.MaxBcdScale) then
        AType := dtBCD
      else
        AType := dtFmtBCD;
    end
    else if sType = 'FLOAT' then
      AType := dtSingle
    else
      AType := dtDouble;
  end
  else if (sType = 'DECIMAL') or (sType = 'DEC') or (sType = 'NUMERIC') then begin
    SetPrecScale(10, 0);
    if AScale = 0 then
      if lUnsigned then begin
        if APrec <= 3 then
          AType := dtByte
        else if APrec <= 5 then
          AType := dtUInt16
        else if APrec <= 10 then
          AType := dtUInt32
        else if APrec <= 21 then
          AType := dtUInt64;
      end
      else begin
        if APrec <= 2 then
          AType := dtSByte
        else if APrec <= 4 then
          AType := dtInt16
        else if APrec <= 9 then
          AType := dtInt32
        else if APrec <= 20 then
          AType := dtInt64;
      end;
    if AType = dtUnknown then begin
      oFmt := FOptions.FormatOptions;
      if (APrec <= oFmt.MaxBcdPrecision) and (AScale <= oFmt.MaxBcdScale) then
        AType := dtBCD
      else
        AType := dtFmtBCD;
    end;
  end
  else if sType = 'DATE' then
    AType := dtDate
  else if sType = 'DATETIME' then
    AType := dtDateTime
  else if sType = 'TIMESTAMP' then begin
    AType := dtDateTimeStamp;
    Include(AAttrs, caRowVersion);
  end
  else if sType = 'TIME' then
    AType := dtTime
  else if sType = 'YEAR' then
    AType := dtUInt16
  else if sType = 'CHAR' then begin
    SetLen(1);
    AType := dtAnsiString;
    Include(AAttrs, caFixedLen);
  end
  else if sType = 'VARCHAR' then begin
    SetLen(255);
    AType := dtAnsiString;
  end
  else if sType = 'BINARY' then begin
    SetLen(1);
    AType := dtByteString;
    Include(AAttrs, caFixedLen);
  end
  else if sType = 'VARBINARY' then begin
    SetLen(255);
    AType := dtByteString;
  end
  else if sType = 'TINYBLOB' then begin
    AType := dtByteString;
    ALen := 255;
  end
  else if sType = 'TINYTEXT' then begin
    AType := dtAnsiString;
    ALen := 255;
  end
  else if (sType = 'BLOB') or (sType = 'MEDIUMBLOB') or (sType = 'LONGBLOB') then begin
    Exclude(AAttrs, caSearchable);
    Include(AAttrs, caBlobData);
    AType := dtBlob;
  end
  else if (sType = 'TEXT') or (sType = 'MEDIUMTEXT') or (sType = 'LONGTEXT') then begin
    Exclude(AAttrs, caSearchable);
    Include(AAttrs, caBlobData);
    AType := dtMemo;
  end;
  AStr := sType;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetCrsData(ACrsCol: Integer; var AData: Pointer;
  var ALen: LongWord; AType: TFDDataType): Boolean;
var
  pSrcData: Pointer;
  iSrcLen: LongWord;
  lTypeSupported: Boolean;
begin
  pSrcData := nil;
  iSrcLen := 0;
  Result := FCursor.GetData(ACrsCol, pSrcData, iSrcLen) and
    MySQL2DataValue(pSrcData, iSrcLen, AData, ALen, AType, [], lTypeSupported) and
    lTypeSupported;
  if not Result then
    ALen := 0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetCrsData(ACrsCol: Integer; AData: Pointer): String;
var
  iLen: LongWord;
begin
  GetCrsData(ACrsCol, AData, iLen, dtAnsiString);
  Result := TFDPhysMySQLConnection(FConnectionObj).FSession.Encoder.Decode(AData, iLen);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.GetMetaCatalog: String;
var
  rName: TFDPhysParsedName;
begin
  GetSelectMetaInfoParams(rName);
  if rName.FCatalog = '' then
    Result := TFDPhysMySQLConnection(FConnectionObj).InternalGetCurrentCatalog
  else
    Result := rName.FCatalog;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLCommand.FetchMetaRow(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowIndex: Integer);
const
  C_Primary: String = 'PRIMARY';
var
  pData: Pointer;
  uiLen: LongWord;
  oRow: TFDDatSRow;
  lDeleteRow: Boolean;
  s: String;
  eType: TFDDataType;
  eAttrs: TFDDataAttributes;
  iPrec, iScale: Integer;
  iRecNo: Integer;
  eIndKind: TFDPhysIndexKind;
  i: Integer;
  rName: TFDPhysParsedName;
  oConnMeta: IFDPhysConnectionMetadata;
  eTabKind: TFDPhysTableKind;
  eScope: TFDPhysObjectScope;
begin
  lDeleteRow := False;
  iRecNo := FRecordsFetched + ARowIndex + 1;
  oRow := ATable.NewRow(False);
  pData := FBuffer.Check(1024);
  case GetMetaInfoKind of
  mkCatalogs:
    begin
      oRow.SetData(0, iRecNo);
      uiLen := 0;
      GetCrsData(0, pData, uiLen, dtWideString);
      oRow.SetData(1, pData, uiLen);
    end;
  mkTables:
    begin
      s := GetMetaCatalog;
      oRow.SetData(0, iRecNo);
      oRow.SetData(1, s);
      oRow.SetData(2, nil, 0);
      uiLen := 0;
      GetCrsData(0, pData, uiLen, dtWideString);
      oRow.SetData(3, pData, uiLen);
      eTabKind := tkTable;
      if TFDPhysMySQLConnection(FConnectionObj).FServerVersion >= mvMySQL050002 then begin
        GetCrsData(1, pData, uiLen, dtWideString);
        if StrLComp('VIEW', PWideChar(pData), uiLen) = 0 then
          eTabKind := tkView;
      end;
      oRow.SetData(4, SmallInt(eTabKind));
      if (CompareText(s, 'MYSQL') = 0) or (CompareText(s, 'INFORMATION_SCHEMA') = 0) then
        eScope := osSystem
      else if CompareText(s, TFDPhysMySQLConnection(FConnectionObj).InternalGetCurrentCatalog) = 0 then
        eScope := osMy
      else
        eScope := osOther;
      oRow.SetData(5, SmallInt(eScope));
      lDeleteRow := not (eTabKind in GetTableKinds) or not (eScope in GetObjectScopes);
    end;
  mkTableFields:
    begin
      oRow.SetData(0, iRecNo);
      oRow.SetData(1, GetMetaCatalog);
      oRow.SetData(2, nil, 0);
      FConnection.CreateMetadata(oConnMeta);
      oConnMeta.DecodeObjName(GetCommandText, rName, Self, [doUnquote, doNormalize]);
      oRow.SetData(3, rName.FObject);
      GetCrsData(0, pData, uiLen, dtWideString);
      oRow.SetData(4, pData, uiLen);
      oRow.SetData(5, iRecNo);
      s := GetCrsData(1, pData);
      eType := dtUnknown;
      eAttrs := [];
      uiLen := 0;
      iPrec := 0;
      iScale := 0;
      MySQLType2ADType(s, eType, eAttrs, uiLen, iPrec, iScale);
      oRow.SetData(6, LongWord(eType));
      oRow.SetData(7, s);
      oRow.SetData(9, iPrec);
      oRow.SetData(10, iScale);
      oRow.SetData(11, uiLen);
      Include(eAttrs, caBase);
      if CompareText(GetCrsData(2, pData), 'YES') = 0 then
        Include(eAttrs, caAllowNull);
      if GetCrsData(4, pData) <> '' then
        Include(eAttrs, caDefault);
      if CompareText(GetCrsData(5, pData), 'AUTO_INCREMENT') = 0 then begin
        Include(eAttrs, caAutoInc);
        Include(eAttrs, caAllowNull);
      end;
      oRow.SetData(8, PWord(@eAttrs)^);
    end;
  mkIndexes,
  mkPrimaryKey:
    begin
      oRow.SetData(0, iRecNo);
      oRow.SetData(1, GetMetaCatalog);
      oRow.SetData(2, nil, 0);
      GetCrsData(0, pData, uiLen, dtWideString);
      oRow.SetData(3, pData, uiLen);
      GetCrsData(1, pData, uiLen, dtUInt16);
      if PWord(pData)^ = 0 then
        eIndKind := ikUnique
      else
        eIndKind := ikNonUnique;
      GetCrsData(2, pData, uiLen, dtWideString);
      if (eIndKind = ikUnique) and (StrLIComp(PWideChar(pData), PWideChar(C_Primary), 7) = 0) then
        eIndKind := ikPrimaryKey;
      oRow.SetData(4, pData, uiLen);
      if eIndKind in [ikUnique, ikPrimaryKey] then
        oRow.SetData(5, pData, uiLen)
      else
        oRow.SetData(5, nil, 0);
      oRow.SetData(6, Integer(eIndKind));
      if (GetMetaInfoKind = mkPrimaryKey) and (iRecNo > 1) then
        lDeleteRow := True;
      if not lDeleteRow then
        for i := 0 to ATable.Rows.Count - 1 do begin
          if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(4, rvDefault)) = VarToStr(oRow.GetData(4, rvDefault))) then begin
            lDeleteRow := True;
            Break;
          end;
        end;
    end;
  mkIndexFields,
  mkPrimaryKeyFields:
    begin
      oRow.SetData(0, iRecNo);
      oRow.SetData(1, GetMetaCatalog);
      oRow.SetData(2, nil, 0);
      GetCrsData(0, pData, uiLen, dtWideString);
      oRow.SetData(3, pData, uiLen);
      GetCrsData(1, pData, uiLen, dtInt32);
      if PSmallInt(pData)^ = 0 then
        eIndKind := ikUnique
      else
        eIndKind := ikNonUnique;
      GetCrsData(2, pData, uiLen, dtWideString);
      if (eIndKind = ikUnique) and (StrLIComp(PWideChar(pData), PWideChar(C_Primary), 7) = 0) then
        eIndKind := ikPrimaryKey;
      oRow.SetData(4, pData, uiLen);
      GetCrsData(4, pData, uiLen, dtWideString);
      oRow.SetData(5, pData, uiLen);
      GetCrsData(3, pData, uiLen, dtInt32);
      oRow.SetData(6, pData, uiLen);
      GetCrsData(5, pData, uiLen, dtWideString);
      oRow.SetData(7, pData, uiLen);
      oRow.SetData(8, nil, 0);
      FConnection.CreateMetadata(oConnMeta);
      oConnMeta.DecodeObjName(GetCommandText, rName, Self, [doUnquote, doNormalize]);
      if not lDeleteRow then
        if (GetMetaInfoKind = mkPrimaryKeyFields) and
             ((eIndKind <> ikPrimaryKey) or
              (iRecNo > 1) and
              (AnsiCompareText(VarToStr(ATable.Rows[0].GetData(4, rvDefault)), VarToStr(oRow.GetData(4, rvDefault))) <> 0)
             ) or
           (GetMetaInfoKind = mkIndexFields) and
             (AnsiCompareText(VarToStr(oRow.GetData(4, rvDefault)), rName.FObject) <> 0) then
          lDeleteRow := True;
    end;
  mkForeignKeys:
    begin
      oRow.SetData(0, iRecNo);
      GetCrsData(1, pData, uiLen, dtWideString);
      oRow.SetData(1, pData, uiLen);
      oRow.SetData(2, nil, 0);
      GetCrsData(3, pData, uiLen, dtWideString);
      oRow.SetData(3, pData, uiLen);
      GetCrsData(4, pData, uiLen, dtWideString);
      oRow.SetData(4, pData, uiLen);
      GetCrsData(5, pData, uiLen, dtWideString);
      oRow.SetData(5, pData, uiLen);
      oRow.SetData(6, nil, 0);
      GetCrsData(7, pData, uiLen, dtWideString);
      oRow.SetData(7, pData, uiLen);
      GetCrsData(8, pData, uiLen, dtInt32);
      oRow.SetData(8, pData, uiLen);
      GetCrsData(9, pData, uiLen, dtInt32);
      oRow.SetData(9, pData, uiLen);
    end;
  mkForeignKeyFields:
    begin
      oRow.SetData(0, iRecNo);
      GetCrsData(1, pData, uiLen, dtWideString);
      oRow.SetData(1, pData, uiLen);
      oRow.SetData(2, nil, 0);
      GetCrsData(3, pData, uiLen, dtWideString);
      oRow.SetData(3, pData, uiLen);
      GetCrsData(4, pData, uiLen, dtWideString);
      oRow.SetData(4, pData, uiLen);
      GetCrsData(5, pData, uiLen, dtWideString);
      oRow.SetData(5, pData, uiLen);
      GetCrsData(6, pData, uiLen, dtWideString);
      oRow.SetData(6, pData, uiLen);
      GetCrsData(7, pData, uiLen, dtInt32);
      oRow.SetData(7, pData, uiLen);
    end;
  mkProcs:
    begin
      oRow.SetData(0, iRecNo);
      if GetCrsData(1, pData, uiLen, dtWideString) then
        oRow.SetData(1, pData, uiLen);
      if GetCrsData(2, pData, uiLen, dtWideString) then
        oRow.SetData(2, pData, uiLen);
      if GetCrsData(3, pData, uiLen, dtWideString) then
        oRow.SetData(3, pData, uiLen);
      if GetCrsData(4, pData, uiLen, dtWideString) then
        oRow.SetData(4, pData, uiLen);
      if GetCrsData(5, pData, uiLen, dtInt32) then
        oRow.SetData(5, pData, uiLen);
      if GetCrsData(6, pData, uiLen, dtInt32) then
        oRow.SetData(6, pData, uiLen);
      if GetCrsData(7, pData, uiLen, dtInt32) then
        oRow.SetData(7, pData, uiLen);
      if GetCrsData(8, pData, uiLen, dtInt32) then
        oRow.SetData(8, pData, uiLen);
      if GetCrsData(9, pData, uiLen, dtInt32) then
        oRow.SetData(9, pData, uiLen);
    end;
  mkProcArgs:
    ASSERT(False);
  else
    lDeleteRow := True;
  end;
  if lDeleteRow then
    FDFree(oRow)
  else
    ATable.Rows.Add(oRow);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.FetchSPParamRows(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow): Integer;
var
  sMode, sSQL: String;
  lAnsiQuotes, {lNoBackslash,} lInQuote1, lInQuote2: Boolean;
  i, iBraces, iPrev, iRecNo: Integer;
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;

  procedure AddParam(const ASQL: String; AFrom, ATo: Integer);
  var
    iPrev: Integer;
    sType, sName: String;
    eDir: TParamType;
    eType: TFDDataType;
    eAttrs: TFDDataAttributes;
    iPrec, iScale: Integer;
    uiLen: LongWord;
    oRow: TFDDatSRow;
  begin
    while (AFrom <= ATo) and FDInSet(ASQL[AFrom], [' ', #9, #13, #10]) do
      Inc(AFrom);
    if StrLIComp(PChar(ASQL) + AFrom - 1, PChar('RETURNS'), 7) = 0 then begin
      eDir := ptResult;
      Inc(AFrom, 7);
    end
    else if StrLIComp(PChar(ASQL) + AFrom - 1, PChar('INOUT'), 5) = 0 then begin
      eDir := ptInputOutput;
      Inc(AFrom, 5);
    end
    else if StrLIComp(PChar(ASQL) + AFrom - 1, PChar('IN'), 2) = 0 then begin
      eDir := ptInput;
      Inc(AFrom, 2);
    end
    else if StrLIComp(PChar(ASQL) + AFrom - 1, PChar('OUT'), 3) = 0 then begin
      eDir := ptOutput;
      Inc(AFrom, 3);
    end
    else
      eDir := ptInput;
    if eDir = ptResult then
      sName := 'result'
    else begin
      while (AFrom <= ATo) and FDInSet(ASQL[AFrom], [' ', #9, #13, #10]) do
        Inc(AFrom);
      if ASQL[AFrom] = '`' then begin
        iPrev := AFrom;
        repeat
          Inc(AFrom);
        until (AFrom > ATo) or (ASQL[AFrom] = '`');
        sName := Copy(ASQL, iPrev + 1, AFrom - iPrev - 1);
      end
      else begin
        iPrev := AFrom;
        repeat
          Inc(AFrom);
        until (AFrom > ATo) or FDInSet(ASQL[AFrom], [')', '(', ',', ' ', #9, #13, #10]);
        sName := Copy(ASQL, iPrev, AFrom - iPrev);
      end;
      Inc(AFrom);
    end;

    if (GetWildcard <> '') and not FDStrLike(sName, GetWildcard) then
      Exit;

    while (AFrom <= ATo) and FDInSet(ASQL[AFrom], [' ', #9, #13, #10]) do
      Inc(AFrom);
    eType := dtUnknown;
    eAttrs := [];
    uiLen := 0;
    iPrec := 0;
    iScale := 0;
    sType := Copy(ASQL, AFrom, ATo - AFrom + 1);
    MySQLType2ADType(sType, eType, eAttrs, uiLen, iPrec, iScale);

    oRow := ATable.NewRow(False);
    oRow.SetData(0, iRecNo);
    oRow.SetData(1, rName.FCatalog);
    oRow.SetData(2, rName.FSchema);
    oRow.SetData(3, nil, 0);
    oRow.SetData(4, rName.FObject);
    oRow.SetData(5, 0);
    oRow.SetData(6, sName);
    oRow.SetData(7, Smallint(iRecNo));
    oRow.SetData(8, Smallint(eDir));
    oRow.SetData(9, Smallint(eType));
    oRow.SetData(10, nil, 0);
    oRow.SetData(11, PWord(@eAttrs)^);
    oRow.SetData(12, iPrec);
    oRow.SetData(13, iScale);
    oRow.SetData(14, uiLen);
    ATable.Rows.Add(oRow);
    Inc(iRecNo);
  end;

begin
  Result := 0;
  iRecNo := 1;
  sMode := GetCrsData(1, FBuffer.Ptr);
  sSQL := GetCrsData(2, FBuffer.Ptr);
  FConnection.CreateMetadata(oConnMeta);
  oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self, [doNormalize, doUnquote]);

  lAnsiQuotes := Pos('ANSI_QUOTES', sMode) <> 0;
  // lNoBackslash := Pos('NO_BACKSLASH_ESCAPES', sMode) <> 0;

                                                                             
  i := Pos('(', sSQL) + 1;
  lInQuote1 := False;
  lInQuote2 := False;
  iBraces := 0;
  iPrev := i;
  while i < Length(sSQL) do begin
    case sSQL[i] of
    '`':
      if not lInQuote2 then
        lInQuote1 := not lInQuote1;
    '"':
      if lAnsiQuotes and not lInQuote1 then
        lInQuote2 := not lInQuote2;
    '(':
      if not lInQuote2 and not lInQuote1 then
        Inc(iBraces);
    ')':
      if not lInQuote2 and not lInQuote1 then
        if iBraces = 0 then begin
          if iPrev <= i - 1 then begin
            AddParam(sSQL, iPrev, i - 1);
            Inc(Result);
          end;
          Inc(i);
          Break;
        end
        else
          Dec(iBraces);
    ',':
      if not lInQuote2 and not lInQuote1 and (iBraces = 0) then begin
        AddParam(sSQL, iPrev, i - 1);
        Inc(Result);
        iPrev := i + 1;
      end;
    end;
    Inc(i);
  end;

  while (i < Length(sSQL)) and FDInSet(sSQL[i], [' ', #9, #13, #10]) do
    Inc(i);
  if StrLIComp(PChar(sSQL) + i - 1, PChar('RETURNS'), 7) = 0 then begin
    AddParam(sSQL, i, Length(sSQL));
    Inc(Result);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.FetchFKRows(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow): Integer;

  function TrimQuotes(const AStr: String): String;
  begin
    Result := FDUnquote(Trim(AStr), '`');
  end;

var
  sFKCat, sFKTab, sFKName, sComment, sTabName, sFKey, sFKFields, sFields: String;
  iCommentField, i, i1, i2, i3, i4, i5, j1, j2, iRecNo: Integer;
  oRow: TFDDatSRow;
begin
  Result := 0;
  iRecNo := 1;
  if TFDPhysMySQLConnection(FConnectionObj).FServerVersion < mvMySQL040100 then
    iCommentField := 14
  else
    iCommentField := 15;
  sComment := GetCrsData(iCommentField, FBuffer.Ptr);
  sTabName := GetCrsData(0, FBuffer.Ptr);
  if Pos('InnoDB', sComment) = 1 then begin
    i := 1;
    FDExtractFieldName(sComment, i, GSemicolonFmtSettings);
    while i <= Length(sComment) do begin
      sFKey := FDExtractFieldName(sComment, i, GSemicolonFmtSettings);
      i1 := Pos('(', sFKey, 1);
      i2 := Pos(')', sFKey, i1);
      i3 := Pos('/', sFKey, i2);
      i4 := Pos('(', sFKey, i3);
      i5 := Pos(')', sFKey, i4);
      if (i1 <> -1) and (i2 <> -1) and (i3 <> -1) and (i4 <> -1) and (i5 <> -1) then begin
        sFKCat := TrimQuotes(Copy(sFKey, i2 + 8, i3 - i2 - 8));
        sFKTab := TrimQuotes(Copy(sFKey, i3 + 1, i4 - i3 - 1));
        sFKName := sTabName + '_to_' + sFKTab;
        sFields := Copy(sFKey, i1 + 1, i2 - i1 - 1);
        sFKFields := Copy(sFKey, i4 + 1, i5 - i4 - 1);
        if GetMetaInfoKind = mkForeignKeys then begin
          oRow := ATable.NewRow(False);
          oRow.SetData(0, iRecNo);
          oRow.SetData(1, GetMetaCatalog);
          oRow.SetData(2, nil, 0);
          oRow.SetData(3, sTabName);
          oRow.SetData(4, sFKName);
          oRow.SetData(5, sFKCat);
          oRow.SetData(6, nil, 0);
          oRow.SetData(7, sFKTab);
          oRow.SetData(8, IntToStr(Integer(ckCascade)));
          oRow.SetData(9, IntToStr(Integer(ckCascade)));
          ATable.Rows.Add(oRow);
          Inc(iRecNo);
          Inc(Result);
        end
        else if AnsiCompareText(sFKName, TrimQuotes(GetCommandText)) = 0 then begin
          j1 := 1;
          j2 := 1;
          while (j1 <= Length(sFields)) and (j2 <= Length(sFKFields)) do begin
            oRow := ATable.NewRow(False);
            oRow.SetData(0, iRecNo);
            oRow.SetData(1, GetMetaCatalog);
            oRow.SetData(2, nil, 0);
            oRow.SetData(3, sTabName);
            oRow.SetData(4, sFKName);
            oRow.SetData(5, TrimQuotes(FDExtractFieldName(sFields, j1, GSpaceFmtSettings)));
            oRow.SetData(6, TrimQuotes(FDExtractFieldName(sFKFields, j2, GSpaceFmtSettings)));
            oRow.SetData(7, Result + 1);
            ATable.Rows.Add(oRow);
            Inc(iRecNo);
            Inc(Result);
          end;
          Break;
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLCommand.InternalFetchRowSet(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowsetSize: LongWord): LongWord;
var
  i: LongWord;
begin
  Result := 0;
  if GetMetaInfoKind = mkProcArgs then begin
    if FCursor.Fetch(1) then
      Result := FetchSPParamRows(ATable, AParentRow);
  end
  else if (GetMetaInfoKind in [mkForeignKeys, mkForeignKeyFields]) and
          (TFDPhysMySQLConnection(FConnectionObj).FServerVersion < mvMySQL050100) then begin
    if FCursor.Fetch(1) then
      Result := FetchFKRows(ATable, AParentRow);
  end
  else
    for i := 1 to ARowsetSize do begin
      if not FCursor.Fetch(i) then
        Break;
      if GetMetaInfoKind = mkNone then
        FetchRow(ATable, AParentRow)
      else
        FetchMetaRow(ATable, AParentRow, i - 1);
      Inc(Result);
    end;
end;

{-----------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysMySQLDriver);

end.
