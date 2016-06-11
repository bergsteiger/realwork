{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC PostgreSQL driver               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$IF DEFINED(IOS) OR DEFINED(ANDROID)}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$IFDEF WIN32}
    {$HPPEMIT '#pragma link "FireDAC.Phys.PG.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Phys.PG.o"'}
  {$ENDIF}
{$ENDIF}

unit FireDAC.Phys.PG;

interface

uses
  System.Classes,
  FireDAC.Phys;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux64)]
  TFDPhysPgDriverLink = class(TFDPhysDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.Variants, System.SysUtils, System.Math, Data.DB, Data.SqlTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Stan.Option,
    FireDAC.Stan.Util, FireDAC.Stan.Consts, FireDAC.Stan.Factory,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.PGMeta, FireDAC.Phys.SQLGenerator,
    FireDAC.Phys.PGCli, FireDAC.Phys.PGWrapper, FireDAC.Phys.PgDef;

type
  TFDPhysPgDriver = class;
  TFDPhysPgConnection = class;
  TFDPhysPgTransaction = class;
  TFDPhysPgEventAlerter = class;
  TFDPhysPgCommand = class;

  TFDPhysPGCliHandles = array [0..1] of Pointer;
  PFDPhysPGCliHandles = ^TFDPhysPGCliHandles;

  TFDPhysPgDriver = class(TFDPhysDriver)
  private
    FLib: TPgLib;
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

  TFDPhysPgConnection = class(TFDPhysConnection)
  private
    FEnv: TPgEnv;
    FConnection: TPgConnection;
    FServerVersion: TFDVersion;
    FOidAsBlob: TFDPGOidAsBlob;
    FExtendedMetadata: Boolean;
    FCliHandles: TFDPhysPGCliHandles;
    FUseMonthsBetween: Boolean;
    FMetaCatalog: String;
    FBackslashEscape: Boolean;
    FArrayScanSample: Integer;
    FArrayDefSize: Integer;
    function BuildPgConnectString(const AConnectionDef: IFDStanConnectionDef): String;
    procedure UpdateCurrentMeta;
    function AdjustOIDasBLOB(const ATypeName, ANameSpace: String;
      var ADataType: TFDDataType; var AAttrs: TFDDataAttributes): Boolean;
  protected
    procedure InternalConnect; override;
    procedure InternalSetMeta; override;
    procedure InternalDisconnect; override;
    procedure InternalChangePassword(const AUserName, AOldPassword,
      ANewPassword: String); override;
    function InternalCreateTransaction: TFDPhysTransaction; override;
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateMetadata: TObject; override;
    function InternalCreateCommandGenerator(const ACommand: IFDPhysCommand): TFDPhysCommandGenerator; override;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; override;
{$ENDIF}
    procedure InternalExecuteDirect(const ASQL: String; ATransaction: TFDPhysTransaction); override;
    procedure GetItem(AIndex: Integer; out AName: String;
      out AValue: Variant; out AKind: TFDMoniAdapterItemKind); override;
    function GetItemCount: Integer; override;
    function GetMessages: EFDDBEngineException; override;
    function GetCliObj: Pointer; override;
    function InternalGetCliHandle: Pointer; override;
    function GetLastAutoGenValue(const AName: String): Variant; override;
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
    destructor Destroy; override;
    property PgConnection: TPgConnection read FConnection;
  end;

  TFDPhysPgTransaction = class(TFDPhysTransaction)
  protected
    procedure InternalStartTransaction(ATxID: LongWord); override;
    procedure InternalCommit(ATxID: LongWord); override;
    procedure InternalRollback(ATxID: LongWord); override;
    procedure InternalChanged; override;
    procedure InternalCheckState(ACommandObj: TFDPhysCommand; ASuccess: Boolean); override;
    procedure InternalNotify(ANotification: TFDPhysTxNotification; ACommandObj: TFDPhysCommand); override;
  end;

  TFDPhysPgEventAlerter = class(TFDPhysEventAlerter)
  private
    FWaitConnection: IFDPhysConnection;
    FWaitThread: TThread;
  protected
    // TFDPhysEventAlerter
    procedure InternalAllocHandle; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalUnregister; override;
    procedure InternalReleaseHandle; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  end;

  PFDPgParInfoRec = ^TFDPgParInfoRec;
  PFDPgVecInfoRec = ^TFDPgVecInfoRec;
  PFDPgColInfoRec = ^TFDPgColInfoRec;
  PFDPgRecInfoRec = ^TFDPgRecInfoRec;
  PFDProcArgRec = ^TFDProcArgRec;

  TFDPgParInfoRec = record
    FPgParamIndex: Integer;
    FParamIndex: Integer;
    FOutSQLDataType: OID;
    FDestDataType: TFDDataType;
    FSrcDataType: TFDDataType;
    FOutDataType: TFDDataType;
    FSrcFieldType: TFieldType;
    FSrcSize: LongWord;
    FSrcPrec: Integer;
    FSrcScale: Integer;
    FParamType: TParamType;
    FVecInfo: PFDPgVecInfoRec;
  end;

  TFDPgVecInfoRec = record
    FParInfos: array of TFDPgParInfoRec;
  end;

  TFDPgColInfoRec = record
    FName: String;
    FPos: Integer;
    FLen: LongWord;
    FPrec,
    FScale: Integer;
    FSrcSQLDataType: Oid;
    FSrcDataType,
    FDestDataType: TFDDataType;
    FAttrs: TFDDataAttributes;
    FField: TPgField;
    FOriginSchemaName,
    FOriginTabName,
    FOriginColName: String;
    FTableCol: Integer;
    FTableOid: Oid;
    FInPK: WordBool;
    FRecInfo: PFDPgRecInfoRec;
  end;

  TFDPgRecInfoRec = record
    FColInfos: array of TFDPgColInfoRec;
    // next members are actually temporary variables
    FColIndex: Integer;
    FFixedLength: Integer;
    FParentColName: String;
  end;

  TFDProcArgRec = record
    FName: String;
    FParamType: TParamType;
    FTypeOid: Oid;
  end;
  TFDProcArgRecs = array of TFDProcArgRec;

  TFDPhysPgSPDescriber = class(TObject)
  private
    FCommand: TFDPhysPgCommand;
    FName: TFDPhysParsedName;
    procedure CreateParam(AName: String; AParamType: TParamType; ATypeOid: Oid);
  public
    constructor Create(ACommand: TFDPhysPgCommand; const AName: TFDPhysParsedName);
    procedure CreateParams;
    procedure ReadProcArgs(var AProcArgs: TFDProcArgRecs);
  end;

  TFDPhysPgCommand = class(TFDPhysCommand)
  private
    FStmt: TPgStatement;
    FBaseStmt: TPgStatement;
    FBaseVecInfo: TFDPgVecInfoRec;
    FBaseRecInfo: TFDPgRecInfoRec;
    FCurrentRecInfo: PFDPgRecInfoRec;
    FInfoStack: TFDPtrList;
    FCursorCanceled: Boolean;
    FCursors: array of String;
    FActiveCrs: Integer;
    FMetaProcName: String;
    FMetaProcOverload: Word;
    FOidAsBlob: Boolean;
    FStmtParamsCount: Integer;
    FPreparedBatchSize: Integer;
    FResultSetMode: Integer;

    function GetConnection: TFDPhysPgConnection;

    function FDType2SQL(AType: TFDDataType; const ATypeName: String; AArray: Boolean): Oid;
    procedure SQL2FDColInfo(ASQLTypeOid: Oid; ASQLLen: LongWord; ASQLPrec,
      ASQLScale: Integer; out AType: TFDDataType; var AAttrs: TFDDataAttributes;
      out ALen: LongWord; out APrec, AScale: Integer; AFmtOpts: TFDFormatOptions);

    function CreateStmt: TPgStatement;
    function UseExecDirect: Boolean;

    procedure CreateParamInfos;
    procedure DestroyParamInfos;
    function CheckFixedArray(AField: TPgField; var ALen: Integer): Boolean;
    procedure CreateColInfos;
    procedure DestroyColInfos;
    procedure CheckColInfos;
    function BuildColumnName(ApRecInfo: PFDPgRecInfoRec; ApColInfo: PFDPgColInfoRec): String;

    procedure SetParamValue(AFmtOpts: TFDFormatOptions; AParam: TFDParam;
      APgParam: TPgParam; ApInfo: PFDPgParInfoRec; AParIndex: Integer);
    procedure SetParamValues(AParIndex: Integer = 0);
    procedure GetParamValues(AParIndex: Integer);
    procedure ExecuteBatchInsert(ATimes, AOffset: Integer; var ACount: TFDCounter);
    procedure DoExecute(ATimes, AOffset: Integer; var ACount: TFDCounter);
    function CheckArray(ASize: Integer): Boolean;

    procedure FetchRow(ApRecInfo: PFDPgRecInfoRec; ATable: TFDDatSTable;
      AParentRow: TFDDatSRow);
    procedure FetchTableFieldsRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
    procedure FetchProcsRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
    function FetchSPParamRows(ATable: TFDDatSTable; AParentRow: TFDDatSRow): Integer;
  protected
    procedure InternalPrepare; override;
    function InternalUseStandardMetadata: Boolean; override;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; override;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalOpen: Boolean; override;
    function InternalNextRecordSet: Boolean; override;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; override;
    procedure InternalAbort; override;
    procedure InternalClose; override;
    procedure InternalUnprepare; override;
    function GetCliObj: Pointer; override;
  public
    constructor Create(AConnectionObj: TFDPhysConnection);
    destructor Destroy; override;
    property PgConnection: TFDPhysPgConnection read GetConnection;
    property PgStatement: TPgStatement read FStmt;
  end;

const
  S_FD_CharacterSets = 'BIG5;EUC_CN;EUC_JP;EUC_KR;EUC_TW;GB18030;GBK;ISO_8859_5;' +
    'ISO_8859_6;ISO_8859_7;ISO_8859_8;JOHAB;KOI8;LATIN1;LATIN2;LATIN3;LATIN4;LATIN5;' +
    'LATIN6;LATIN7;LATIN8;LATIN9;LATIN10;MULE_INTERNAL;SJIS;SQL_ASCII;UHC;UTF8;' +
    'WIN866;WIN874;WIN1250;WIN1251;WIN1252;WIN1256;WIN1258';
  S_FD_Choose = 'Choose';
  S_FD_Error = 'Error';
  S_FD_BYTEA = 'BYTEA';

{-------------------------------------------------------------------------------}
{ TFDPhysIBDriverLink                                                           }
{-------------------------------------------------------------------------------}
function TFDPhysPgDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_PgId;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysIBDriver                                                               }
{-------------------------------------------------------------------------------}
constructor TFDPhysPgDriver.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  FLib := TPgLib.Create(FDPhysManagerObj);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysPgDriver.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLib);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgDriver.InternalLoad;
var
  sHome, sLib: String;
begin
  sHome := '';
  sLib := '';
  GetVendorParams(sHome, sLib);
  FLib.Load(sHome, sLib);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgDriver.InternalUnload;
begin
  FLib.Unload;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysPgConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
class function TFDPhysPgDriver.GetBaseDriverID: String;
begin
  Result := S_FD_PgId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysPgDriver.GetBaseDriverDesc: String;
begin
  Result := 'PostgreSQL';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysPgDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.PostgreSQL;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysPgDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysPGConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgDriver.GetCliObj: Pointer;
begin
  Result := FLib;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
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
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Port, '@I', '5432', S_FD_ConnParam_Common_Port, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_LoginTimeout, '@I', '0', S_FD_ConnParam_Common_LoginTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_CharacterSet, S_FD_CharacterSets, '', S_FD_ConnParam_Common_CharacterSet, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ExtendedMetadata, '@L', S_FD_False, S_FD_ConnParam_Common_ExtendedMetadata, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_PG_OidAsBlob, S_FD_No + ';' + S_FD_Yes + ';' + S_FD_Choose, S_FD_Choose, S_FD_ConnParam_PG_OidAsBlob, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_PG_UnknownFormat, S_FD_Error + ';' + S_FD_BYTEA, S_FD_Error, S_FD_ConnParam_PG_UnknownFormat, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_PG_ArrayScanSample, '@S', '0;5', S_FD_ConnParam_PG_ArrayScanSample, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ApplicationName, '@S', '', S_FD_ConnParam_Common_ApplicationName, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_PG_PGAdvanced, '@S', '', S_FD_ConnParam_PG_PGAdvanced, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', 'public', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgConnection                                                           }
{-------------------------------------------------------------------------------}
constructor TFDPhysPgConnection.Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost);
begin
  inherited Create(ADriverObj, AConnHost);
  FEnv := TPgEnv.Create(TFDPhysPgDriver(DriverObj).FLib, Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysPgConnection.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FEnv);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalCreateTransaction: TFDPhysTransaction;
begin
  Result := TFDPhysPgTransaction.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  if CompareText(AEventKind, S_FD_EventKind_PG_Events) = 0 then
    Result := TFDPhysPgEventAlerter.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysPgCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalCreateMetadata: TObject;
begin
  Result := TFDPhysPgMetadata.Create(Self, FServerVersion,
    TFDPhysPgDriver(DriverObj).FLib.Version,
    (FConnection <> nil) and (FConnection.Encoder.Encoding in [ecUTF8, ecUTF16]),
    FExtendedMetadata, FUseMonthsBetween, FBackslashEscape);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysPgCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysPgCommandGenerator.Create(Self);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalTracingChanged;
begin
  if FEnv <> nil then begin
    FEnv.Monitor := FMonitor;
    FEnv.Tracing := FTracing;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.BuildPgConnectString(const AConnectionDef: IFDStanConnectionDef): String;

  function IsIpAddress(const AAddr: String): Boolean;
  var
    i, iVal, iCode, iCnt: Integer;
    aStr: TArray<String>;
  begin
    iCnt := 0;
    aStr := AAddr.Split(['.'], ExcludeEmpty);
    for i := 0 to Length(aStr) - 1 do begin
      Val(aStr[i], iVal, iCode);
      if (iCode = 0) and (iVal <= 255) then
        Inc(iCnt)
      else
        Break;
    end;
    Result := (iCnt = 4);
  end;

  procedure Add(const AParam: String);
  begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + AParam;
  end;

var
  oParams: TFDPhysPGConnectionDefParams;
  i: Integer;
  sAdv: String;
begin
  oParams := AConnectionDef.Params as TFDPhysPGConnectionDefParams;
  Result := '';
  i := 1;
  sAdv := oParams.PGAdvanced;
  while i <= Length(sAdv) do
    Add(FDExtractFieldName(sAdv, i));
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_Server) then
    if IsIpAddress(oParams.Server) then
      Add('hostaddr=' + oParams.Server)
    else
      Add('host=' + oParams.Server);
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_Port) then
    Add('port=' + IntToStr(oParams.Port));
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_Database) then
    Add('dbname=' + oParams.Database);
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_UserName) then
    Add('user=' + oParams.UserName);
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_Password) then
    Add('password=' + oParams.Password);
  if AConnectionDef.HasValue(S_FD_ConnParam_Common_LoginTimeout) then
    Add('connect_timeout=' + IntToStr(oParams.LoginTimeout));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalConnect;
var
  oParams: TFDPhysPGConnectionDefParams;
  pCliHandles: PFDPhysPGCliHandles;
  sEncoding: String;
  sSample: String;
  i: Integer;
begin
  oParams := ConnectionDef.Params as TFDPhysPGConnectionDefParams;
  if InternalGetSharedCliHandle() <> nil then begin
    pCliHandles := PFDPhysPGCliHandles(InternalGetSharedCliHandle());
    FConnection := TPgConnection.CreateUsingHandle(FEnv, pCliHandles^[0],
      pCliHandles^[1], Self);
  end
  else
    FConnection := TPgConnection.Create(FEnv, Self);
{$IFDEF FireDAC_MONITOR}
  InternalTracingChanged;
{$ENDIF}

  if InternalGetSharedCliHandle() = nil then begin
    FConnection.Connect(BuildPgConnectString(ConnectionDef));

    if ConnectionDef.HasValue(S_FD_ConnParam_Common_CharacterSet) then
      FConnection.ClientEncoding := ConnectionDef.AsString[S_FD_ConnParam_Common_CharacterSet];

    if oParams.NewPassword <> '' then
      InternalExecuteDirect('ALTER USER ' + oParams.UserName +
        ' PASSWORD ''' + oParams.NewPassword + '''', nil);
  end;

  FServerVersion := FConnection.ServerVersion;
  sEncoding := FConnection.ClientEncoding;
  if SameText(sEncoding, 'UTF8') or SameText(sEncoding, 'UNICODE') then
    FConnection.Encoder.Encoding := ecUTF8
  else
    FConnection.Encoder.Encoding := ecANSI;
  FExtendedMetadata := oParams.ExtendedMetadata;
  FOidAsBlob := oParams.OidAsBlob;
  if oParams.UnknownFormat = ufBYTEA then
    FConnection.UnknownFormat := SQL_BYTEA
  else
    FConnection.UnknownFormat := 0;
  sSample := oParams.ArrayScanSample;
  if sSample <> '' then begin
    i := 1;
    FArrayScanSample := StrToIntDef(FDExtractFieldName(sSample, i), 0);
    FArrayDefSize := StrToIntDef(FDExtractFieldName(sSample, i), 5);
  end
  else begin
    FArrayScanSample := 0;
    FArrayDefSize := 0;
  end;

  if (FServerVersion >= svPGSQL090000) and
     ConnectionDef.HasValue(S_FD_ConnParam_Common_ApplicationName) then
    InternalExecuteDirect('SET APPLICATION_NAME TO ''' + oParams.ApplicationName + '''', nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalSetMeta;
begin
  inherited InternalSetMeta;
  if FCurrentSchema = '' then
    UpdateCurrentMeta;
  if FDefaultSchema = '' then
    FDefaultSchema := 'public';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalDisconnect;
begin
  FDFreeAndNil(FConnection);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalChangePassword(const AUserName,
  AOldPassword, ANewPassword: String);
var
  oConnDef: IFDStanConnectionDef;
  oConn: TPgConnection;
begin
  FDCreateInterface(IFDStanConnectionDef, oConnDef);
  oConnDef.ParentDefinition := ConnectionDef;
  oConnDef.Params.UserName := AUserName;
  oConnDef.Params.Password := AOldPassword;
  oConn := TPgConnection.Create(FEnv, Self);
  try
    oConn.Connect(BuildPgConnectString(oConnDef));
    oConn.ExecuteQuery('ALTER USER ' + oConnDef.Params.UserName +
      ' PASSWORD ''' + ANewPassword + '''');
  finally
    FDFree(oConn);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.InternalExecuteDirect(const ASQL: String;
  ATransaction: TFDPhysTransaction);
begin
  FConnection.ExecuteQuery(ASQL);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.GetLastAutoGenValue(const AName: String): Variant;
begin
  if (FConnection <> nil) and (AName = '') then
    if FConnection.LastInsertOid = InvalidOid then
      Result := Null
    else
      Result := FConnection.LastInsertOid
  else
    Result := inherited GetLastAutoGenValue(AName);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.GetItemCount: Integer;
begin
  Result := inherited GetItemCount;
  if FEnv <> nil then begin
    Inc(Result, 3);
    if FConnection <> nil then
      Inc(Result, 9);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
begin
  if AIndex < inherited GetItemCount then
    inherited GetItem(AIndex, AName, AValue, AKind)
  else
    case AIndex - inherited GetItemCount of
    0:
      begin
        AName := 'Client brand';
        if FEnv.Lib.Brand = pbRegular then
          AValue := 'PostgreSQL regular'
        else
          AValue := 'Enterprise DB';
        AKind := ikClientInfo;
      end;
    1:
      begin
        AName := 'Client version';
        AValue := Integer(FEnv.Lib.Version);
        AKind := ikClientInfo;
      end;
    2:
      begin
        AName := 'Client DLL name';
        AValue := FEnv.Lib.DLLName;
        AKind := ikClientInfo;
      end;
    3:
      begin
        AName := 'Server version';
        AValue := FConnection.SERVER_VERSION;
        AKind := ikSessionInfo;
      end;
    4:
      begin
        AName := 'Server encoding';
        AValue := FConnection.SERVER_ENCODING;
        AKind := ikSessionInfo;
      end;
    5:
      begin
        AName := 'Client encoding';
        AValue := FConnection.CLIENT_ENCODING;
        AKind := ikSessionInfo;
      end;
    6:
      begin
        AName := 'Is superuser';
        AValue := FConnection.IS_SUPERUSER;
        AKind := ikSessionInfo;
      end;
    7:
      begin
        AName := 'Session authorization';
        AValue := FConnection.SESSION_AUTHORIZATION;
        AKind := ikSessionInfo;
      end;
    8:
      begin
        AName := 'Date style';
        AValue := FConnection.DATESTYLE;
        AKind := ikSessionInfo;
      end;
    9:
      begin
        AName := 'Integer date/times';
        AValue := FConnection.INTEGER_DATETIMES;
        AKind := ikSessionInfo;
      end;
    10:
      begin
        AName := 'Time zone';
        AValue := FConnection.TIMEZONE;
        AKind := ikSessionInfo;
      end;
    11:
      begin
        AName := 'Standard conforming strings';
        AValue := FConnection.STANDARD_CONFORMING_STRINGS;
        AKind := ikSessionInfo;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.GetMessages: EFDDBEngineException;
begin
  if FConnection <> nil then
    Result := FConnection.Notices
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.GetCliObj: Pointer;
begin
  Result := FConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.InternalGetCliHandle: Pointer;
begin
  if FConnection <> nil then begin
    FCliHandles[0] := FConnection.FHandle;
    FCliHandles[1] := @FConnection.FStmtIDCounter;
    Result := @FCliHandles;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgConnection.UpdateCurrentMeta;
var
  oStmt: TPgStatement;
  dt: TDateTime;
  sTS: String;
  iLen: LongWord;
  iUseMonths: Integer;
  rTS: TSQLTimeStamp;
begin
  FUseMonthsBetween := False;
  dt := Now();
  sTS := FormatDateTime('yyyy''-''mm''-''dd hh'':''nn'':''ss', dt);
  oStmt := TPgStatement.Create(FConnection, Self);
  try
    oStmt.PrepareSQL('SELECT CURRENT_DATABASE(), CURRENT_SCHEMA(), ''' + sTS + '''::TIMESTAMPTZ, ' +
      '(SELECT MIN(1) FROM PG_CATALOG.PG_PROC WHERE PRONAME = ''months_between''), ' +
      '(SELECT SETTING FROM PG_CATALOG.PG_SETTINGS WHERE NAME = ''standard_conforming_strings'')');
    oStmt.Execute;
    oStmt.DescribeFields;
    oStmt.Fetch;
    FMetaCatalog := oStmt.Fields[0].GetAsString;
    FCurrentSchema := oStmt.Fields[1].GetAsString;
    if oStmt.ResultFormat = 1 then
      if oStmt.Fields[2].GetData(@rTS, iLen) then begin
        FConnection.TimeZoneOffset :=
          Trunc((dt - SQLTimeStampToDateTime(rTS) + 1 / (24 * 60 * 60)) / (1 / 24));
        FUseMonthsBetween := (oStmt.Fields[3].GetData(@iUseMonths, iLen) and (iUseMonths = 1));
      end;
    FBackslashEscape := SameText(oStmt.Fields[4].GetAsString, 'off');
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgConnection.AdjustOIDasBLOB(const ATypeName, ANameSpace: String;
  var ADataType: TFDDataType; var AAttrs: TFDDataAttributes): Boolean;
begin
  Result :=
    (FOidAsBlob = oabYes) or (FOidAsBlob = oabChoose) and (
       // large object column must have a specially named domain
       (CompareText(ATypeName, 'LO') = 0) or
       (CompareText(ATypeName, 'LARGEOBJECT') = 0) or
       (CompareText(ATypeName, 'BLOB') = 0)
     ) and not (
       // large object column cannot be in the dictionary
       (CompareText(ANameSpace, 'information_schema') = 0) or
       (CompareText(ANameSpace, 'pg_catalog') = 0)
     );
  if Result then begin
    AAttrs := AAttrs - [caSearchable] + [caBlobData];
    ADataType := dtHBlob;
  end
  else begin
    AAttrs := AAttrs + [caSearchable] - [caBlobData];
    ADataType := dtUInt32;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgTransaction                                                          }
{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalStartTransaction(ATxID: LongWord);
begin
  TFDPhysPgConnection(ConnectionObj).InternalExecuteDirect('BEGIN', nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalCommit(ATxID: LongWord);
begin
  DisconnectCommands(nil, dmRelease);
  TFDPhysPgConnection(ConnectionObj).InternalExecuteDirect('COMMIT', nil);
  if Retaining then
    InternalStartTransaction(ATxID);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalRollback(ATxID: LongWord);
begin
  DisconnectCommands(nil, dmRelease);
  TFDPhysPgConnection(ConnectionObj).InternalExecuteDirect('ROLLBACK', nil);
  if Retaining then
    InternalStartTransaction(ATxID);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalChanged;
var
  sSQL: String;
begin
  sSQL := '';
  if GetOptions.Isolation <> xiUnspecified then begin
    sSQL := sSQL + ' ISOLATION LEVEL ';
    case GetOptions.Isolation of
    xiDirtyRead:
      sSQL := sSQL + 'READ UNCOMMITTED';
    xiReadCommitted:
      sSQL := sSQL + 'READ COMMITTED';
    xiRepeatableRead,
    xiSnapshot:
      sSQL := sSQL + 'REPEATABLE READ';
    xiSerializible:
      sSQL := sSQL + 'SERIALIZABLE';
    end;
  end;
  if GetOptions.ReadOnly then
    sSQL := sSQL + ' READ ONLY';
  if sSQL <> '' then
    TFDPhysPgConnection(ConnectionObj).InternalExecuteDirect(
      'SET SESSION CHARACTERISTICS AS TRANSACTION' + sSQL, nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalCheckState(ACommandObj: TFDPhysCommand;
  ASuccess: Boolean);
var
  oCmd: TFDPhysPgCommand;
begin
  oCmd := TFDPhysPgCommand(ACommandObj);
  if (oCmd.PgConnection.PgConnection <> nil) and
     (GetActive <> (oCmd.PgConnection.PgConnection.TransactionStatus = PQTRANS_INTRANS)) then
    case oCmd.PgConnection.PgConnection.TransactionStatus of
    PQTRANS_IDLE:
      TransactionFinished;
    PQTRANS_INTRANS:
      TransactionStarted;
    PQTRANS_INERROR:
      if GetNestingLevel = 1 then begin
        // Seting FState to csRecovering is needed to avoid fetching by
        // datasets. They will set FSourceEOF to True without fetching.
        oCmd.PgConnection.Lock;
        try
          oCmd.PgConnection.FState := csRecovering;
          DisconnectCommands(nil, dmOffline);
        finally
          if oCmd.PgConnection.FState = csRecovering then
            oCmd.PgConnection.FState := csConnected;
          oCmd.PgConnection.UnLock;
        end;
        // Now application must explicitly Commit / Rollback failed transaction
        // TransactionFinished;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgTransaction.InternalNotify(ANotification: TFDPhysTxNotification;
  ACommandObj: TFDPhysCommand);
var
  lInherited: Boolean;
begin
  lInherited := False;
  case ANotification of
    cpBeforeCmdExecute:
      if TFDPhysPgCommand(ACommandObj).GetCommandKind in [skCommit, skRollback] then
        DisconnectCommands(nil, dmRelease)
      else if (TFDPhysPgCommand(ACommandObj).GetCommandKind = skStoredProcWithCrs) and
              (TFDPhysPgCommand(ACommandObj).PgStatement.RowsetSize >= 0) then begin
        if GetOptions.AutoStart and not GetActive then begin
          StartTransaction;
          FIDAutoCommit := GetSerialID;
        end
      end
      else
        lInherited := True;
    cpAfterCmdExecuteSuccess,
    cpAfterCmdExecuteFailure:
      if (TFDPhysPgCommand(ACommandObj).GetCommandKind = skStoredProcWithCrs) and
         (TFDPhysPgCommand(ACommandObj).PgStatement.RowsetSize >= 0) then begin
        if GetOptions.AutoStop and GetActive and
           (not (xoIfAutoStarted in GetOptions.StopOptions) or
            (FIDAutoCommit <> 0) and (FIDAutoCommit = GetSerialID)) then
          // allowunprepare, force, success
          CheckStoping(not (ANotification in [cpAfterCmdUnprepare, cpAfterCmdPrepareFailure]),
                       not (xoIfCmdsInactive in GetOptions.StopOptions),
                       not (ANotification in [cpAfterCmdPrepareFailure, cpAfterCmdExecuteFailure]));
      end
      else
        lInherited := True;
    else
      lInherited := True;
  end;
  if lInherited then
    inherited InternalNotify(ANotification, ACommandObj);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgEventMessage                                                         }
{-------------------------------------------------------------------------------}
type
  TFDPhysPgEventMessage = class(TFDPhysEventMessage)
  private
    FName: String;
    FProcID: Integer;
    FParam: String;
  public
    constructor Create(const AName: String; AProcID: Integer; const AParam: String);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysPgEventMessage.Create(const AName: String; AProcID: Integer;
  const AParam: String);
begin
  inherited Create;
  FName := AName;
  FProcID := AProcID;
  FParam := AParam;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgEventThread                                                          }
{-------------------------------------------------------------------------------}
type
  TFDPhysPgEventThread = class(TThread)
  private
    [weak] FAlerter: TFDPhysPgEventAlerter;
  protected
    procedure Execute; override;
  public
    constructor Create(AAlerter: TFDPhysPgEventAlerter);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysPgEventThread.Create(AAlerter: TFDPhysPgEventAlerter);
begin
  inherited Create(False);
  FAlerter := AAlerter;
  FreeOnTerminate := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysPgEventThread.Destroy;
begin
  FAlerter.FWaitThread := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventThread.Execute;
var
  oConn: TPgConnection;
  sName, sParam: String;
  iProcID: Integer;
begin
  while not Terminated and FAlerter.IsRunning do
    try
      oConn := TPgConnection(FAlerter.FWaitConnection.CliObj);
      if oConn.CheckForInput() then
        while oConn.ReadNotifies(sName, iProcID, sParam) do
          FAlerter.FMsgThread.EnqueueMsg(TFDPhysPgEventMessage.Create(
            sName, iProcID, sParam));
    except
      on E: EFDDBEngineException do
        if E.Kind <> ekCmdAborted then begin
          Terminate;
          FAlerter.AbortJob;
        end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgEventAlerter                                                         }
{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalAllocHandle;
begin
  FWaitConnection := GetConnection.Clone;
  if FWaitConnection.State = csDisconnected then
    FWaitConnection.Open;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalRegister;
var
  i: Integer;
  oCmd: IFDPhysCommand;
begin
  FWaitConnection.CreateCommand(oCmd);
  SetupCommand(oCmd);
  for i := 0 to GetNames.Count - 1 do begin
    oCmd.Prepare('LISTEN ' + GetNames[i]);
    oCmd.Execute();
  end;
  FWaitThread := TFDPhysPgEventThread.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalHandle(AEventMessage: TFDPhysEventMessage);
var
  oMsg: TFDPhysPgEventMessage;
begin
  oMsg := TFDPhysPgEventMessage(AEventMessage);
  InternalHandleEvent(oMsg.FName, VarArrayOf([oMsg.FProcID, oMsg.FParam]));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalAbortJob;
begin
  if FWaitThread <> nil then
    FWaitThread.Terminate;
  TPgConnection(FWaitConnection.CliObj).Abort;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalUnregister;
var
  i: Integer;
  oCmd: IFDPhysCommand;
begin
  FWaitConnection.CreateCommand(oCmd);
  SetupCommand(oCmd);
  for i := 0 to GetNames.Count - 1 do begin
    oCmd.Prepare('UNLISTEN ' + GetNames[i]);
    oCmd.Execute();
  end;
  FWaitThread := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalReleaseHandle;
begin
  FWaitConnection := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgEventAlerter.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  oCmd: IFDPhysCommand;
  sCmd: String;
begin
  FWaitConnection.CreateCommand(oCmd);
  SetupCommand(oCmd);
  sCmd := 'NOTIFY ' + AEvent;
  if not VarIsEmpty(AArgument) then
    if TFDPhysPgConnection(ConnectionObj).FServerVersion >= svPGSQL090000 then
      sCmd := sCmd + ', ' + QuotedStr(VarToStr(AArgument))
    else
      FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_PGId]);
  oCmd.Prepare(sCmd);
  oCmd.Execute();
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgSPDesriber                                                           }
{-------------------------------------------------------------------------------}
constructor TFDPhysPgSPDescriber.Create(ACommand: TFDPhysPgCommand;
  const AName: TFDPhysParsedName);
begin
  inherited Create;
  FCommand := ACommand;
  FName := AName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgSPDescriber.CreateParams;
var
  i: Integer;
  oProcArgs: TFDProcArgRecs;
  pArg: PFDProcArgRec;
begin
  ReadProcArgs(oProcArgs);
  for i := 0 to Length(oProcArgs) - 1 do begin
    pArg := @oProcArgs[i];
    CreateParam(pArg^.FName, pArg^.FParamType, pArg^.FTypeOid);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgSPDescriber.CreateParam(AName: String; AParamType: TParamType; ATypeOid: Oid);
var
  uiSize: LongWord;
  iPrec, iScale: Integer;
  eSrcFDDataType, eDestFDDataType: TFDDataType;
  eDestDataType: TFieldType;
  eSrcAttrs: TFDDataAttributes;
  uiDestSize: LongWord;
  iDestPrec, iDestScale: Integer;
  oType: TPgType;
  i: Integer;
  oParam: TFDParam;
  oFmt: TFDFormatOptions;
  oMbr: TPgMember;
begin
  uiSize := 0;
  iPrec := 0;
  iScale := 0;
  eSrcAttrs := [];
  FCommand.SQL2FDColInfo(ATypeOid, 0, 0, 0, eSrcFDDataType, eSrcAttrs,
    uiSize, iPrec, iScale, FCommand.FOptions.FormatOptions);
  if eSrcFDDataType <> dtUnknown then begin
    oParam := FCommand.GetParams.Add;
    try
      oParam.Name := AName;
      oParam.Position := oParam.Index + 1;
      oParam.ParamType := AParamType;

      oFmt := FCommand.FOptions.FormatOptions;
      eDestFDDataType := dtUnknown;
      eDestDataType := ftUnknown;
      uiDestSize := 0;
      iDestPrec := 0;
      iDestScale := 0;
      oFmt.ResolveDataType(AName, FCommand.PgConnection.FConnection.TypesManager.Types[ATypeOid].Name,
        eSrcFDDataType, uiSize, iPrec, iScale, eDestFDDataType, uiSize, True);
      oFmt.ColumnDef2FieldDef(eDestFDDataType, uiSize, iPrec, iScale, eSrcAttrs,
        eDestDataType, uiDestSize, iDestPrec, iDestScale);
    except
      FDFree(oParam);
      raise;
    end;
    oParam.DataType := eDestDataType;
    oParam.FDDataType := eDestFDDataType;
    oParam.Size := uiDestSize;
    oParam.Precision := iDestPrec;
    oParam.NumericScale := iDestScale;
  end
  else
    if AParamType = ptResult then begin
      oType := FCommand.PgConnection.FConnection.TypesManager.Types[ATypeOid];
      for i := 0 to Length(oType.Members) - 1 do begin
        oMbr := oType.Members[i];
        CreateParam(oMbr.Name, AParamType, oMbr.TypeOid);
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgSPDescriber.ReadProcArgs(var AProcArgs: TFDProcArgRecs);

  function SplitTextArray(const AStr: String): TFDStringArray;
  var
    i: Integer;
    iPrevPos: Integer;
    iIndex: Integer;
    iLen: Integer;
  begin
    iIndex := 0;
    iPrevPos := 1;
    iLen := Length(AStr);
    if iLen = 0 then
      Exit;
    SetLength(Result, iLen shr 1 + 1);
    for i := 1 to iLen do
      if AStr[i] = ';' then begin
        Result[iIndex] := Copy(AStr, iPrevPos, i - iPrevPos);
        iPrevPos := i + 1;
        Inc(iIndex);
      end;
    Result[iIndex] := Copy(AStr, iPrevPos, Length(AStr));
    SetLength(Result, iIndex + 1);
  end;
  
var
  i: Integer;
  iIndex, iOverload: Integer;
  sParamName, sParamType: String;
  sParamTypes, sDataTypes, sParamNames: TFDStringArray;
  bHasOutParams: Boolean;
  iResTypeOid: Oid;
  oPgStmt: TPgStatement;
  oPgPar: TPgParam;
  oGen: IFDPhysCommandGenerator;
begin
  sParamNames := nil;
  sDataTypes := nil;
  sParamTypes := nil;
  oPgStmt := TPgStatement.Create(FCommand.PgConnection.FConnection, Self);
  try
    FCommand.CreateCommandGenerator(oGen);
    oPgStmt.Params.Count := 2;

    oPgPar := oPgStmt.Params[0];
    oPgPar.TypeOid := SQL_NAME;
    oPgPar.Size := 70;
    oPgPar.Encoding := ecUTF16;
    oPgPar.SetData(PChar(FName.FObject), Length(FName.FObject));

    oPgPar := oPgStmt.Params[1];
    oPgPar.TypeOID := SQL_INT4;
    oPgPar.Size := SizeOf(Integer);
    iOverload := FCommand.GetOverload();
    oPgPar.SetData(@iOverload, SizeOf(iOverload));

    oPgStmt.PrepareSQL(oGen.GenerateSelectMetaInfo(mkProcArgs,
      FName.FCatalog, FName.FSchema, FName.FBaseObject, FName.FObject,
      FCommand.GetWildcard(), FCommand.GetObjectScopes(), FCommand.GetTableKinds(),
      FCommand.GetOverload()));
    oPgStmt.Execute;
    oPgStmt.DescribeFields;

    if not oPgStmt.Fetch then
      FDException(Self, [S_FD_LPhys, S_FD_PGId], er_FD_PgProcNotFound,
        [Trim(FCommand.GetCommandText)]);

    iIndex := 0;
    bHasOutParams := False;

    sParamNames := SplitTextArray(oPgStmt.Fields[5].GetAsString);
    sDataTypes := SplitTextArray(oPgStmt.Fields[3].GetAsString);
    if Length(sDataTypes) = 0 then
      sDataTypes := SplitTextArray(oPgStmt.Fields[2].GetAsString);
    sParamTypes := SplitTextArray(oPgStmt.Fields[4].GetAsString);

    for i := 0 to Length(sDataTypes) - 1 do begin
      if Length(sParamTypes) > i then
        sParamType := sParamTypes[i]
      else
        sParamType := 'i';
      if Length(sParamNames) > i then
        sParamName := sParamNames[i]
      else
        sParamName := '';

      SetLength(AProcArgs, iIndex + 1);

      AProcArgs[iIndex].FName := sParamName;
      AProcArgs[iIndex].FTypeOid := StrToIntDef(sDataTypes[i], 0);
      if sParamType = 'i' then
        AProcArgs[iIndex].FParamType := ptInput
      else
      if sParamType = 'b' then
        AProcArgs[iIndex].FParamType := ptInputOutput
      else
      if (sParamType = 'o') or (sParamType = 't') then
        AProcArgs[iIndex].FParamType := ptOutput
      else
        ASSERT(False);

      if AProcArgs[iIndex].FParamType = ptOutput then
        bHasOutParams := True;
      Inc(iIndex);
    end;

    if not bHasOutParams and oPgStmt.Fields[1].GetData(@iResTypeOid) then
      if iResTypeOid <> SQL_VOID then begin
        SetLength(AProcArgs, iIndex + 1);
        AProcArgs[iIndex].FName := 'result';
        AProcArgs[iIndex].FParamType := ptResult;
        AProcArgs[iIndex].FTypeOid := iResTypeOid;
      end;
  finally
    FDFree(oPgStmt);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysPgCommand                                                              }
{-------------------------------------------------------------------------------}
constructor TFDPhysPgCommand.Create(AConnectionObj: TFDPhysConnection);
begin
  inherited Create(AConnectionObj);
  FInfoStack := TFDPtrList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysPgCommand.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FInfoStack);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.GetCliObj: Pointer;
begin
  Result := FStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.GetConnection: TFDPhysPgConnection;
begin
  Result := TFDPhysPgConnection(FConnectionObj);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.UseExecDirect: Boolean;
begin
  // FPQexec is used for direct execution of SQL without parameters.
  // FPQexec returns ResultFormat = 0, which is not supported.
  // So do not use direct execute for SELECT's without parameters.
  Result := (FOptions.ResourceOptions.DirectExecute) and
    not ((GetCommandKind in [skSelect, skSelectForLock, skSelectForUnLock,
                             skStoredProcWithCrs]) and (GetParams.Count = 0)) or
    (GetCommandKind in [skSet, skSetSchema, skCreate, skDrop, skAlter, skOther,
                        skStartTransaction, skCommit, skRollback]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.InternalPrepare;
var
  rName: TFDPhysParsedName;
  oConnMeta: IFDPhysConnectionMetadata;
  oDesc: TFDPhysPgSPDescriber;
begin
  FInfoStack.Clear;
  FActiveCrs := -1;
  GetConnection.CreateMetadata(oConnMeta);

  // generate metadata SQL command
  if GetMetaInfoKind <> mkNone then begin
    if GetMetaInfoKind = mkProcArgs then
      // A select meta info command will be executed right in InternalFetchRowSet,
      // inside of FetchSPParamRows
      FDbCommandText := ''
    else begin
      GetSelectMetaInfoParams(rName);
      // To restrict schema in GetSelectMetaInfo to an explicitly specified one,
      // clear implicitly specified 'public'.
      if (GetMetaInfoKind in [mkTables, mkPackages, mkProcs, mkGenerators]) and
         (GetSchemaName = '') and (CompareText(rName.FSchema, 'public') = 0) then
        rName.FSchema := '';
      GenerateSelectMetaInfo(rName);
    end;
    if FDbCommandText = '' then
      Exit;
  end

  // generate stored proc call SQL command
  else if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
    FDbCommandText := '';
    if fiMeta in FOptions.FetchOptions.Items then begin
      oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, [doNormalize, doUnquote]);
      GetParams.Clear;
      oDesc := TFDPhysPgSPDescriber.Create(Self, rName);
      try
        oDesc.CreateParams;
      finally
        FDFree(oDesc);
      end;
    end;
    if FDbCommandText = '' then begin
      oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, []);
      GenerateStoredProcCall(rName);
    end;
  end;

  // adjust SQL command
  GenerateLimitSelect();
  GenerateParamMarkers();

  FOidAsBlob := False;
  case PgConnection.FOidAsBlob of
  oabYes:
    FOidAsBlob := True;
  oabChoose:
    if (GetMetaInfoKind = mkNone) and
       oConnMeta.DecodeObjName(GetSourceObjectName, rName, Self,
                               [doNormalize, doUnquote, doNotRaise]) then
      FOidAsBlob := not ((CompareText(rName.FSchema, 'pg_catalog') = 0) or
                         (CompareText(rName.FSchema, 'information_schema') = 0) or
                         (CompareText(Copy(rName.FObject, 1, 3), 'pg_') = 0));
  end;

  FStmt := CreateStmt;
  FBaseStmt := FStmt;

  // describe params
  if GetParams.Count > 0 then
    CreateParamInfos;

  if not UseExecDirect then
    FStmt.PrepareSQL(FDbCommandText);
  FCursorCanceled := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.FDType2SQL(AType: TFDDataType; const ATypeName: String;
  AArray: Boolean): Oid;
begin
  if ATypeName <> '' then
    Result := PgConnection.FConnection.TypesManager.TypeByName(ATypeName).Id
  else
    case AType of
    dtSByte,
    dtByte,
    dtInt16,
    dtUInt16:
      Result := SQL_INT2;
    dtInt32,
    dtUInt32:
      Result := SQL_INT4;
    dtInt64,
    dtUInt64:
      Result := SQL_INT8;
    dtSingle:
      Result := SQL_FLOAT4;
    dtDouble,
    dtExtended:
      Result := SQL_FLOAT8;
    dtCurrency:
      Result := SQL_CASH;
    dtBCD,
    dtFmtBcd:
      Result := SQL_NUMERIC;
    dtAnsiString,
    dtWideString:
      Result := SQL_VARCHAR;
    dtMemo,
    dtWideMemo,
    dtHMemo,
    dtWideHMemo:
      Result := SQL_TEXT;
    dtXML:
      Result := SQL_XML;
    dtByteString,
    dtBlob,
    dtHBFile:
      Result := SQL_BYTEA;
    dtHBlob:
      Result := SQL_OID;
    dtDate:
      Result := SQL_DATE;
    dtTime:
      Result := SQL_TIME;
    dtDateTime,
    dtDateTimeStamp:
      Result := SQL_TIMESTAMP;
    dtTimeIntervalFull,
    dtTimeIntervalYM,
    dtTimeIntervalDS:
      Result := SQL_INTERVAL;
    dtBoolean:
      Result := SQL_BOOL;
    dtCursorRef:
      Result := SQL_REFCURSOR;
    dtGUID:
      Result := SQL_UUID;
    else
      Result := SQL_UNKNOWN;
    end;
  if AArray and (Result <> SQL_UNKNOWN) and
     not (paArray in PgConnection.FConnection.TypesManager.Types[Result].Attrs) then
    Result := PgConnection.FConnection.TypesManager.Arrays[Result].Id;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.SQL2FDColInfo(ASQLTypeOID: Oid; ASQLLen: LongWord;
  ASQLPrec, ASQLScale: Integer; out AType: TFDDataType; var AAttrs: TFDDataAttributes;
  out ALen: LongWord; out APrec, AScale: Integer; AFmtOpts: TFDFormatOptions);
var
  oType: TPgType;
begin
  AType := dtUnknown;
  ALen := 0;
  APrec := 0;
  AScale := 0;
  Exclude(AAttrs, caFixedLen);
  Exclude(AAttrs, caBlobData);
  Include(AAttrs, caSearchable);

  case ASQLTypeOid of
  SQL_INT2,
  SQL_SMGR:
    AType := dtInt16;
  SQL_INT4:
    AType := dtInt32;
  SQL_INT8:
    AType := dtInt64;
  SQL_FLOAT4:
    AType := dtSingle;
  SQL_FLOAT8:
    AType := dtDouble;
  SQL_CASH:
    begin
      APrec := 19;
      AScale := 4;
      AType := dtCurrency;
    end;
  SQL_NUMERIC:
    begin
      APrec := ASQLPrec;
      AScale := ASQLScale;
      if (APrec > AFmtOpts.MaxBcdPrecision) or (AScale > AFmtOpts.MaxBcdScale) or
         // this information is not provided for SP
         ((APrec = 0) and (AScale = 0)) then
        AType := dtFmtBCD
      else
        AType := dtBCD;
    end;
  SQL_CHAR,
  SQL_BPCHAR,
  SQL_VARCHAR,
  SQL_NAME,
  SQL_ACLITEM,
  SQL_VOID:
    if ASQLLen <= AFmtOpts.MaxStringSize then begin
      ALen := ASQLLen;
      if PgConnection.FConnection.Encoder.Encoding = ecUTF8 then
        AType := dtWideString
      else
        AType := dtAnsiString;
      if paFixed in PgConnection.FConnection.TypesManager.Types[ASQLTypeOID].Attrs then
        Include(AAttrs, caFixedLen);
    end
    else begin
      if PgConnection.FConnection.Encoder.Encoding = ecUTF8 then
        AType := dtWideMemo
      else
        AType := dtMemo;
      Include(AAttrs, caBlobData);
    end;
  SQL_MACADDR,
  SQL_CIDR,
  SQL_INET,
  SQL_BIT:
    begin
      AType := dtByteString;
      ALen := ASQLLen;
      Include(AAttrs, caFixedLen);
    end;
  SQL_VARBIT:
    begin
      AType := dtByteString;
      ALen := ASQLLen;
    end;
  SQL_UNKNOWN:
    begin
      ALen := AFmtOpts.MaxStringSize;
      if PgConnection.FConnection.Encoder.Encoding = ecUTF8 then
        AType := dtWideString
      else
        AType := dtAnsiString;
    end;
  SQL_TEXT,
  SQL_JSON,
  SQL_JSONB:
    begin
      if PgConnection.FConnection.Encoder.Encoding = ecUTF8 then
        AType := dtWideMemo
      else
        AType := dtMemo;
      Include(AAttrs, caBlobData);
    end;
  SQL_XML:
    begin
      AType := dtXML;
      Include(AAttrs, caBlobData);
    end;
  SQL_BYTEA:
    begin
      AType := dtBlob;
      Include(AAttrs, caBlobData);
    end;
  SQL_ANY:
    begin
      AType := dtByteString;
      ALen := ASQLLen;
    end;
  SQL_DATE:
    AType := dtDate;
  SQL_TIME,
  SQL_TIMETZ:
    begin
      AType := dtTime;
      if (ASQLScale >= 0) and (ASQLScale < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLScale];
    end;
  SQL_TIMESTAMP,
  SQL_TIMESTAMPTZ,
  SQL_RELTIME,
  SQL_ABSTIME:
    begin
      AType := dtDateTimeStamp;
      if (ASQLScale >= 0) and (ASQLScale < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLScale];
    end;
  SQL_INTERVAL:
    begin
      AType := dtTimeIntervalFull;
      if (ASQLScale >= 0) and (ASQLScale < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLScale];
    end;
  SQL_BOOL:
    AType := dtBoolean;
  SQL_OID:
    if FOidAsBlob and (FResultSetMode <> 2) and ([caROWID, caReadOnly] * AAttrs = []) then begin
      AType := dtHBlob;
      Include(AAttrs, caBlobData);
    end
    else
      AType := dtUInt32;
  SQL_XID,
  SQL_CID,
  SQL_REGPROC,
  SQL_REGPROCEDURE,
  SQL_REGOPER,
  SQL_REGOPERATOR,
  SQL_REGCLASS,
  SQL_REGTYPE:
    AType := dtUInt32;
  SQL_TID:
    begin
      AType := dtByteString;
      ALen := SizeOf(Tid);
      Include(AAttrs, caFixedLen);
    end;
  SQL_REFCURSOR:
    AType := dtCursorRef;
  SQL_UUID:
    AType := dtGUID;
  else
    oType := PgConnection.FConnection.TypesManager.Types[ASQLTypeOID];
    if paArray in oType.Attrs then
      SQL2FDColInfo(oType.Members[0].TypeOid, ASQLLen, ASQLPrec, ASQLScale,
        AType, AAttrs, ALen, APrec, AScale, AFmtOpts)
    else if paEnum in oType.Attrs then begin
      if PgConnection.FConnection.Encoder.Encoding = ecUTF8 then
        AType := dtWideString
      else
        AType := dtAnsiString;
      ALen := NAMEMAXLEN;
    end
    else
      AType := dtUnknown;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.CreateStmt: TPgStatement;
var
  oFmt: TFDFormatOptions;
  oFtch: TFDFetchOptions;
begin
  Result := TPgStatement.Create(PgConnection.FConnection, Self);
  oFmt := FOptions.FormatOptions;
  oFtch := FOptions.FetchOptions;

  Result.StrsTrim := oFmt.StrsTrim;
  Result.StrsEmpty2Null := oFmt.StrsEmpty2Null;

  if (oFtch.Mode in [fmManual, fmOnDemand]) and (oFtch.CursorKind <> ckDefault) and
     (GetCommandKind <> skStoredProcNoCrs) and not FOptions.ResourceOptions.DirectExecute then
    Result.RowsetSize := oFtch.ActualRowsetSize
  else
    Result.RowsetSize := -1;
  Result.WithHold := (GetCommandKind <> skSelectForLock) and
    not PgConnection.GetTransaction.Active or (oFtch.CursorKind = ckStatic);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.CreateParamInfos;
var
  i: Integer;
  oFmtOpts: TFDFormatOptions;
  oParams: TFDParams;
  oParam: TFDParam;
  iPgParIndex, iPgParRef: Integer;
  oPgParam: TPgParam;
  eDestFldType: TFieldType;
  eAttrs: TFDDataAttributes;
  iPrec, iScale: Integer;
  iLen: LongWord;
  pInfo: PFDPgParInfoRec;
begin
  oFmtOpts := FOptions.FormatOptions;
  oParams := GetParams;

  iPgParIndex := 0;
  for i := 0 to oParams.Count - 1 do
    if oParams[i].ParamType in [ptUnknown, ptInput, ptInputOutput] then
      Inc(iPgParIndex);

  FStmt.Params.Count := iPgParIndex;
  SetLength(FBaseVecInfo.FParInfos, iPgParIndex);

  iPgParIndex := 0;
  for i := 0 to oParams.Count - 1 do begin
    oParam := oParams[i];
    if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      pInfo := @FBaseVecInfo.FParInfos[iPgParIndex];
      case GetParams.BindMode of
      pbByName:   iPgParRef := iPgParIndex;
      pbByNumber: iPgParRef := oParam.Position - 1;
      else        iPgParRef := -1;
      end;
      if (iPgParRef >= 0) and (iPgParRef < FStmt.Params.Count) then begin
        oPgParam := FStmt.Params[iPgParRef];
        pInfo^.FPgParamIndex := iPgParRef;
        pInfo^.FParamIndex := i;

        if oParam.DataType = ftUnknown then
          ParTypeUnknownError(oParam);

        pInfo^.FSrcFieldType := oParam.DataType;
        oFmtOpts.ResolveFieldType('', oParam.DataTypeName, oParam.DataType,
          oParam.FDDataType, oParam.Size, oParam.Precision, oParam.NumericScale,
          eDestFldType, pInfo^.FSrcSize, pInfo^.FSrcPrec, pInfo^.FSrcScale,
          pInfo^.FSrcDataType, pInfo^.FDestDataType, False);

        pInfo^.FOutSQLDataType := FDType2SQL(pInfo^.FDestDataType,
          oParam.DataTypeName, oParam.ArrayType = atTable);
        eAttrs := [];
        SQL2FDColInfo(pInfo^.FOutSQLDataType, pInfo^.FSrcSize, pInfo^.FSrcPrec,
          pInfo^.FSrcScale, pInfo^.FOutDataType, eAttrs, iLen, iPrec, iScale, oFmtOpts);

        if oPgParam.DumpLabel = '' then
          oPgParam.DumpLabel := oParam.DisplayName;
        oPgParam.TypeOID := pInfo^.FOutSQLDataType;
        oPgParam.Size := pInfo^.FSrcSize;
        if pInfo^.FOutDataType in [dtWideString, dtWideMemo, dtXML, dtWideHMemo] then
          oPgParam.Encoding := ecUTF16
        else
          oPgParam.Encoding := ecANSI;
        pInfo^.FParamType := oParam.ParamType;
      end;
      Inc(iPgParIndex);
    end;
    FStmtParamsCount := iPgParIndex;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.DestroyParamInfos;
begin
  SetLength(FBaseVecInfo.FParInfos, 0);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.CheckFixedArray(AField: TPgField; var ALen: Integer): Boolean;
var
  i, iLBound, iHBound: Integer;
  lClosed: Boolean;
  iPrevRow: Int64;
begin
  ALen := 0;
  Result := False;
  if not ((paArray in AField.TypeRef.Attrs) and (PgConnection.FArrayScanSample > 0) and
          (Length(AField.TypeRef.Members) > 0) and not (paArray in AField.TypeRef.Members[0].TypeRef.Attrs)) then
    Exit;
  iPrevRow := FStmt.CurrentRow;
  try
    for i := 0 to Min(FStmt.RowsSelected, PgConnection.FArrayScanSample) - 1 do begin
      FStmt.CurrentRow := i;
      if AField.GetArrayBounds(iLBound, iHBound, lClosed) then
        ALen := Max(ALen, iHBound - iLBound + 1);
    end;
    if ALen > 0 then
      Result := True
    else if PgConnection.FArrayDefSize > 0 then begin
      ALen := PgConnection.FArrayDefSize;
      Result := True;
    end;
  finally
    FStmt.CurrentRow := iPrevRow;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.CreateColInfos;
var
  lGetDSInfo: Boolean;
  i: Integer;
  oFmtOpts: TFDFormatOptions;
  oFetchOpts: TFDFetchOptions;
  oField: TPgField;
  sTableOid, sTablesOids: String;
  iAttrs: Integer;
  oConnMeta: IFDPhysConnectionMetadata;
  oView: TFDDatSView;
  j: Integer;
  V: Variant;
  iBaseTableOid: Oid;
  pInfo: PFDPgColInfoRec;
  oRow: TFDDatSRow;
  iLen: Integer;

  procedure CreateRecInfo(ADsField: TPgField; AType: TPgType;
    var ARecInfo: TFDPgRecInfoRec);

    function Def(AVal, ADef: Integer): Integer;
    begin
      if AVal <= 0 then
        Result := ADef
      else
        Result := AVal;
    end;

  var
    i, nFields: Integer;
    pInfo: PFDPgColInfoRec;
    oMember: TPgMember;
    oField: TPgField;
    iLen: Integer;
  begin
    ARecInfo.FColIndex := 0;
    nFields := Length(AType.Members);
    SetLength(ARecInfo.FColInfos, nFields);

    for i := 0 to nFields - 1 do begin
      pInfo := @ARecInfo.FColInfos[i];
      oMember := AType.Members[i];
      oField := ADsField.Fields[i];

      pInfo^.FField := oField;
      pInfo^.FName := oMember.Name;
      pInfo^.FPos := i + 1;
      pInfo^.FSrcSQLDataType := oMember.TypeOid;
      pInfo^.FAttrs := oMember.Attrs;

      if [paArray, paRecord, paRange] * oMember.TypeRef.Attrs <> [] then begin
        if paRecord in oField.TypeRef.Attrs then
          pInfo^.FSrcDataType := dtRowRef
        else if paRange in oField.TypeRef.Attrs then begin
          Include(pInfo^.FAttrs, caReadOnly);
          pInfo^.FSrcDataType := dtRowRef;
        end
        else begin
          Include(pInfo^.FAttrs, caReadOnly);
          if oMember.TypeRef.IsFlatFixedArray then begin
            pInfo^.FSrcDataType := dtArrayRef;
            pInfo^.FLen := oMember.TypeRef.FixedLen;
          end
          else if CheckFixedArray(oField, iLen) then begin
            pInfo^.FSrcDataType := dtArrayRef;
            pInfo^.FLen := iLen;
          end
          else
            pInfo^.FSrcDataType := dtRowSetRef;
        end;

        GetMem(pInfo^.FRecInfo, SizeOf(TFDPgRecInfoRec));
        FillChar(pInfo^.FRecInfo^, SizeOf(TFDPgRecInfoRec), 0);
        CreateRecInfo(oField, oMember.TypeRef, pInfo^.FRecInfo^);
      end
      else
        SQL2FDColInfo(oMember.TypeOid, Def(oMember.Len, oField.Len),
          Def(oMember.Prec, oField.Prec), Def(oMember.Scale, oField.Scale),
          pInfo^.FSrcDataType, pInfo^.FAttrs, pInfo^.FLen, pInfo^.FPrec,
          pInfo^.FScale, oFmtOpts);
    end;
  end;

  procedure MapRecInfoTypes(var ARecInfo: TFDPgRecInfoRec);
  var
    i: Integer;
    pInfo: PFDPgColInfoRec;
  begin
    for i := 0 to Length(ARecInfo.FColInfos) - 1 do begin
      pInfo := @ARecInfo.FColInfos[i];
      // mapping data types
      if GetMetaInfoKind = mkNone then
        oFmtOpts.ResolveDataType(pInfo^.FName,
          PgConnection.FConnection.TypesManager.Types[pInfo^.FSrcSQLDataType].Name,
          pInfo^.FSrcDataType, pInfo^.FLen, pInfo^.FPrec, pInfo^.FScale,
          pInfo^.FDestDataType, pInfo^.FLen, True)
      else
        pInfo^.FDestDataType := pInfo^.FSrcDataType;

      if not CheckFetchColumn(pInfo^.FSrcDataType, pInfo^.FAttrs) then
        pInfo^.FField := nil;

      if pInfo^.FRecInfo <> nil then
        MapRecInfoTypes(pInfo^.FRecInfo^);
    end;
  end;

begin
  oFmtOpts := FOptions.FormatOptions;
  oFetchOpts := FOptions.FetchOptions;
  sTablesOids := '';
  iBaseTableOid := InvalidOid;
  lGetDSInfo := (GetMetaInfoKind = mkNone) and (fiMeta in oFetchOpts.Items) and
    PgConnection.FExtendedMetadata and (FResultSetMode = 0);

  SetLength(FBaseRecInfo.FColInfos, FStmt.Fields.Count);
  FBaseRecInfo.FColIndex := 0;
  for i := 0 to Length(FBaseRecInfo.FColInfos) - 1 do begin
    oField := FStmt.Fields[i];
    pInfo := @FBaseRecInfo.FColInfos[i];

    pInfo^.FField := oField;
    pInfo^.FName := oField.Name;
    pInfo^.FPos := i + 1;

    pInfo^.FTableOid := oField.TableOid;
    pInfo^.FTableCol := oField.TableCol;
    pInfo^.FSrcSQLDataType := oField.TypeOid;
    pInfo^.FInPK := False;
    pInfo^.FAttrs := [caAllowNull];
    if lGetDSInfo then begin
      if (pInfo^.FTableOid <> InvalidOid) and (pInfo^.FTableCol >= 0) then begin
        sTableOid := IntToStr(pInfo^.FTableOid);
        if Pos(sTableOid, sTablesOids) = 0 then begin
          if sTablesOids <> '' then
            sTablesOids := sTablesOids + ', ';
          sTablesOids := sTablesOids + sTableOid;
        end;
      end;
    end
    else begin
      if iBaseTableOid = InvalidOid then
        iBaseTableOid := pInfo^.FTableOid;
      if pInfo^.FTableCol = 0 then begin
        Include(pInfo^.FAttrs, caExpr);
        Include(pInfo^.FAttrs, caReadOnly);
      end
      else if (pInfo^.FTableCol > 0) and (iBaseTableOid = pInfo^.FTableOid) then
        Include(pInfo^.FAttrs, caBase);
    end;

    // system columns
    if pInfo^.FTableCol < 0 then begin
      Include(pInfo^.FAttrs, caReadOnly);
      case oField.TableCol of
      SelfItemPointerAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caVolatile);
          pInfo^.FOriginColName := 'ctid';
        end;
      ObjectIdAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caROWID);
          pInfo^.FOriginColName := 'oid';
        end;
      MinTransactionIdAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caVolatile);
          pInfo^.FOriginColName := 'xmin';
        end;
      MinCommandIdAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caVolatile);
          pInfo^.FOriginColName := 'cmin';
        end;
      MaxTransactionIdAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caVolatile);
          pInfo^.FOriginColName := 'xmax';
        end;
      MaxCommandIdAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caVolatile);
          pInfo^.FOriginColName := 'cmax';
        end;
      TableOidAttributeNumber:
        begin
          Include(pInfo^.FAttrs, caDefault);
          pInfo^.FOriginColName := 'tableoid';
        end;
      else
        ASSERT(False);
      end;
    end;

    if [paArray, paRecord, paRange] * oField.TypeRef.Attrs <> [] then begin
      if paRecord in oField.TypeRef.Attrs then
        pInfo^.FSrcDataType := dtRowRef
      else if paRange in oField.TypeRef.Attrs then begin
        Include(pInfo^.FAttrs, caReadOnly);
        pInfo^.FSrcDataType := dtRowRef;
      end
      else begin
        Include(pInfo^.FAttrs, caReadOnly);
        if oField.TypeRef.IsFlatFixedArray then begin
          pInfo^.FSrcDataType := dtArrayRef;
          pInfo^.FLen := oField.TypeRef.FixedLen;
        end
        else if CheckFixedArray(oField, iLen) then begin
          pInfo^.FSrcDataType := dtArrayRef;
          pInfo^.FLen := iLen;
        end
        else
          pInfo^.FSrcDataType := dtRowSetRef;
      end;

      GetMem(pInfo^.FRecInfo, SizeOf(TFDPgRecInfoRec));
      FillChar(pInfo^.FRecInfo^, SizeOf(TFDPgRecInfoRec), 0);
      CreateRecInfo(oField, oField.TypeRef, pInfo^.FRecInfo^);
    end
    else
      SQL2FDColInfo(pInfo^.FSrcSQLDataType, oField.Len, oField.Prec, oField.Scale,
        pInfo^.FSrcDataType, pInfo^.FAttrs, pInfo^.FLen, pInfo^.FPrec, pInfo^.FScale,
        oFmtOpts);
  end;

  // There are possible optimizations:
  // - if any non-system OID, then ask for domain -> LO
  // - if no system OID, then ask for PK
  if lGetDSInfo and (sTablesOids <> '') then begin
    GetConnection.CreateMetadata(oConnMeta);
    oView := oConnMeta.GetResultSetFields(sTablesOids);
    try
      for i := 0 to Length(FBaseRecInfo.FColInfos) - 1 do begin
        pInfo := @FBaseRecInfo.FColInfos[i];
        if (pInfo^.FTableOid <> InvalidOid) and (pInfo^.FTableCol >= 0) then begin
          j := oView.Find([pInfo^.FTableOid,
                           pInfo^.FTableCol], 'ATTRELID;ATTNUM', []);
          if j <> -1 then begin
            oRow := oView.Rows[j];
            pInfo^.FOriginSchemaName := oRow.AsString['NSPNAME'];
            pInfo^.FOriginTabName := oRow.AsString['RELNAME'];
            pInfo^.FOriginColName := oRow.AsString['ATTNAME'];
            V := oRow.ValueS['ATTRS'];
            if not VarIsNull(V) then begin
              iAttrs := V;
              pInfo^.FAttrs := pInfo^.FAttrs - [caAllowNull, caReadOnly, caROWID] +
                TFDDataAttributes(Pointer(@iAttrs)^);
            end;
            if not VarIsNull(oRow.ValueS['INDISPRIMARY']) then
              pInfo^.FInPK := True;
            if paOID in PgConnection.FConnection.TypesManager.Types[pInfo^.FSrcSQLDataType].Attrs then
              PgConnection.AdjustOIDasBLOB(oRow.AsString['TYPNAME'], pInfo^.FOriginSchemaName,
                pInfo^.FSrcDataType, pInfo^.FAttrs);
          end;
        end;
      end;
    finally
      FDClearMetaView(oView, oFetchOpts);
    end;
  end;

  MapRecInfoTypes(FBaseRecInfo);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.DestroyColInfos;

  procedure DestroyRecInfo(var ARecInfo: TFDPgRecInfoRec);
  var
    i: Integer;
    pInfo: PFDPgColInfoRec;
  begin
    ARecInfo.FParentColName := '';
    for i := 0 to Length(ARecInfo.FColInfos) - 1 do begin
      pInfo := @ARecInfo.FColInfos[i];
      if pInfo^.FRecInfo <> nil then begin
        DestroyRecInfo(pInfo^.FRecInfo^);
        FreeMem(pInfo^.FRecInfo, SizeOf(TFDPgRecInfoRec));
        pInfo^.FRecInfo := nil;
      end;
    end;
    SetLength(ARecInfo.FColInfos, 0);
  end;

begin
  DestroyRecInfo(FBaseRecInfo);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.CheckColInfos;
begin
  if (FStmt.Fields.Count > 0) and (Length(FBaseRecInfo.FColInfos) = 0) then
    CreateColInfos;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.SetParamValue(AFmtOpts: TFDFormatOptions; AParam: TFDParam;
  APgParam: TPgParam; ApInfo: PFDPgParInfoRec; AParIndex: Integer);
var
  pData: PByte;
  iSize, iSrcSize: LongWord;
  oBlob: TPgLargeObject;
  oExtStr, oIntStr: TStream;
  eStreamMode: TFDStreamMode;
  lExtStream: Boolean;
  i: Integer;

  function CreateBlob(AMode: TFDStreamMode): TPgLargeObject;
  begin
    Result := TPgLargeObject.Create(GetConnection.FConnection, AMode, Self);
    Result.CreateObj;
    Result.Open;
  end;

begin
  pData := nil;
  iSize := 0;

  // null
  if (AParam.DataType <> ftStream) and AParam.IsNulls[AParIndex] then
    APgParam.SetData(nil, 0)

  // assign BLOB stream
  else if AParam.IsStreams[AParIndex] then begin
    oExtStr := AParam.AsStreams[AParIndex];
    lExtStream := (oExtStr <> nil) and
      not ((oExtStr is TPgLargeObjectStream) and (TPgLargeObjectStream(oExtStr).LargeObject.OwningObj = Self));
    if (AParam.DataType <> ftStream) and not lExtStream or
       (ApInfo^.FOutDataType <> dtHBlob) then
      UnsupParamObjError(AParam);
    if lExtStream then
      eStreamMode := smOpenWrite
    else
      eStreamMode := AParam.StreamMode;
    oBlob := CreateBlob(eStreamMode);
    oIntStr := TPgLargeObjectStream.Create(oBlob);
    try
      if lExtStream then
        oIntStr.CopyFrom(oExtStr, -1)
      else
        AParam.AsStreams[AParIndex] := oIntStr;
      APgParam.SetData(@oBlob.FObjOid, SizeOf(oBlob.FObjOid), True);
    finally
      if lExtStream then
        FDFree(oIntStr);
    end;
  end

  // assign array
  else if (AParam.ArrayType = atTable) and (APgParam.ArrayIndex = -1) then begin
    APgParam.SetArrayBounds(0, AParam.ArraySize - 1);
    try
      for i := 0 to AParam.ArraySize - 1 do begin
        APgParam.ArrayIndex := i;
        SetParamValue(AFmtOpts, AParam, APgParam, ApInfo, i);
      end;
    finally
      APgParam.ArrayIndex := -1;
    end;
  end

  // conversion is not required
  else if ApInfo^.FSrcDataType = ApInfo^.FOutDataType then begin

    if ApInfo^.FOutDataType = dtHBlob then begin
      oBlob := CreateBlob(smOpenWrite);
      try
        AParam.GetBlobRawData(iSize, pData, AParIndex);
        oBlob.Write(pData, iSize);
        APgParam.SetData(@oBlob.FObjOid, SizeOf(oBlob.FObjOid), True);
      finally
        FDFree(oBlob);
      end;
    end
    // byte string data, then optimizing - get data directly
    else if ApInfo^.FOutDataType in [dtAnsiString, dtWideString, dtMemo, dtWideMemo,
                                     dtXML, dtBlob, dtByteString] then begin
      AParam.GetBlobRawData(iSize, pData, AParIndex);
      APgParam.SetData(pData, iSize, True);
    end
    else begin
      iSize := AParam.GetDataLength(AParIndex);
      FBuffer.Check(iSize);
      AParam.GetData(FBuffer.Ptr, AParIndex);
      APgParam.SetData(FBuffer.Ptr, iSize);
    end;
  end

  // conversion is required
  else begin
    // calculate buffer size to move param values
    iSrcSize := AParam.GetDataLength(AParIndex);
    FBuffer.Extend(iSrcSize, iSize, ApInfo^.FSrcDataType, ApInfo^.FOutDataType);

    // get, convert and set parameter value
    AParam.GetData(FBuffer.Ptr, AParIndex);
    AFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ApInfo^.FOutDataType,
      FBuffer.Ptr, iSrcSize, FBuffer.FBuffer, FBuffer.Size, iSize,
      PgConnection.FConnection.Encoder);

    if ApInfo^.FOutDataType = dtHBlob then begin
      oBlob := CreateBlob(smOpenWrite);
      try
        oBlob.Write(FBuffer.Ptr, iSize);
        APgParam.SetData(@oBlob.FObjOid, SizeOf(oBlob.FObjOid), True);
      finally
        FDFree(oBlob);
      end;
    end
    else
      APgParam.SetData(FBuffer.Ptr, iSize);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.SetParamValues(AParIndex: Integer = 0);
var
  oFmtOpts: TFDFormatOptions;
  oParams: TFDParams;
  oParam: TFDParam;
  oPgParam: TPgParam;
  i: Integer;
  pParInfo: PFDPgParInfoRec;
begin
  oParams := GetParams;
  if oParams.Count = 0 then
    Exit;

  oFmtOpts := GetOptions.FormatOptions;
  for i := 0 to Length(FBaseVecInfo.FParInfos) - 1 do begin
    pParInfo := @FBaseVecInfo.FParInfos[i];
    oParam := oParams[pParInfo^.FParamIndex];
    if (pParInfo^.FPgParamIndex <> -1) and
       (oParam.DataType <> ftCursor) and
       (oParam.ParamType in [ptInput, ptInputOutput, ptUnknown]) then begin
      oPgParam := FStmt.Params[pParInfo^.FPgParamIndex];
      CheckParamMatching(oParam, pParInfo^.FSrcFieldType, pParInfo^.FParamType, 0);
      SetParamValue(oFmtOpts, oParam, oPgParam, pParInfo, AParIndex);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.GetParamValues(AParIndex: Integer);
var
  oTab: TFDDatSTable;
  i, iParBase, iPar, iCrs: Integer;
  oParams: TFDParams;
  oPar: TFDParam;
  ePrevState: TFDPhysCommandState;
  rState: TFDDatSLoadState;
  iArrIndex: Integer;

  procedure AssignParamValue(AParam: TFDParam; AParIndex: Integer;
    ARow: TFDDatSRow; AColIndex: Integer);
  var
    v: Variant;
    eStreamMode: TFDStreamMode;
    oBlob: TPgLargeObject;
    lExtStream: Boolean;
    oExtStr, oIntStr: TStream;
  begin
    v := ARow.GetData(AColIndex);
    if AParam.IsStreams[AParIndex] and not VarIsNull(v) then begin
      oExtStr := AParam.AsStreams[AParIndex];
      lExtStream := (oExtStr <> nil) and
        not ((oExtStr is TPgLargeObjectStream) and (TPgLargeObjectStream(oExtStr).LargeObject.OwningObj = Self));
      if (AParam.DataType <> ftStream) and not lExtStream or
         (ARow.Table.Columns[AColIndex].DataType <> dtUInt32) then
        UnsupParamObjError(AParam);
      if lExtStream then
        eStreamMode := smOpenWrite
      else
        eStreamMode := AParam.StreamMode;
      oBlob := TPgLargeObject.Create(GetConnection.FConnection, eStreamMode, Self, v);
      oIntStr := TPgLargeObjectStream.Create(oBlob);
      try
        oBlob.Open;
        if lExtStream then
          oExtStr.CopyFrom(oIntStr, -1)
        else
          AParam.AsStreams[AParIndex] := oIntStr;
      finally
        if lExtStream then
          FDFree(oIntStr);
      end;
    end
    else
      AParam.Values[AParIndex] := v;
  end;

  function CheckParamStreams: Boolean;
  var
    i: Integer;
    oPar: TFDParam;
  begin
    Result := False;
    for i := 0 to oParams.Count - 1 do begin
      oPar := oParams[i];
      if (oPar.ParamType in [ptOutput, ptInputOutput, ptResult]) and
         oPar.IsStreams[AParIndex] then begin
        Result := True;
        Break;
      end;
    end;
  end;

begin
  FStmt.DescribeFields;
  if (FStmt.Fields.Count = 0) or (FStmt.Fields[0].TypeOID = SQL_UNKNOWN) then
    Exit;

  oParams := GetParams;
  oTab := TFDDatSTable.Create;
                                                                                                
                                                                                  
  if CheckParamStreams then
    FResultSetMode := 2
  else
    FResultSetMode := 1;
  ePrevState := GetState;
  SetState(csOpen);
  try
    CheckColInfos;
    oTab.Setup(FOptions);
    FStmt.Fetch;
    Define(oTab);
    if oTab.Columns.Count > 0 then begin
      oTab.BeginLoadData(rState, lmHavyFetching);
      try
        FetchRow(@FBaseRecInfo, oTab, nil);
        if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
          // SP parameters are binded by name
          for i := 0 to oTab.Columns.Count - 1 do begin
            oPar := oParams.FindParam(oTab.Columns[i].Name);
            if (oPar <> nil) and (oPar.ParamType in [ptOutput, ptInputOutput, ptResult]) then
              AssignParamValue(oPar, AParIndex, oTab.Rows[0], i);
          end;
        end

        else begin
          // RETURNING ... {INTO ...} parameters are binded by position
          iArrIndex := AParIndex - 1;
          iParBase := -2;
          repeat
            Inc(iArrIndex);
            if iParBase <> -2 then
              FetchRow(@FBaseRecInfo, oTab, nil)
            else begin
              iParBase := -1;
              for i := 0 to oParams.Count - 1 do
                if oParams[i].ParamType in [ptOutput, ptInputOutput, ptResult] then begin
                  iParBase := i;
                  Break;
                end;
            end;
            iPar := iParBase;
            if iPar <> -1 then
              for i := 0 to oTab.Columns.Count - 1 do begin
                while iPar < oParams.Count do begin
                  oPar := oParams[iPar];
                  Inc(iPar);
                  if oPar.ParamType in [ptOutput, ptInputOutput] then begin
                    AssignParamValue(oPar, iArrIndex, oTab.Rows[iArrIndex - AParIndex], i);
                    Break;
                  end;
                end;
                if iPar >= oParams.Count then
                  Break;
              end;
          until not FStmt.Fetch;
        end;
      finally
        oTab.EndLoadData(rState);
      end;
    end;

    if GetCommandKind = skStoredProcWithCrs then begin
      // grab cursor names
      iCrs := 0;
      for i := 0 to FStmt.Fields.Count - 1 do
        if FStmt.Fields[i].TypeOid = SQL_REFCURSOR then
          Inc(iCrs);
      SetLength(FCursors, iCrs);
      iCrs := 0;
      for i := 0 to FStmt.Fields.Count - 1 do
        if FStmt.Fields[i].TypeOid = SQL_REFCURSOR then begin
          FCursors[iCrs] := FStmt.Fields[i].GetAsString;
          Inc(iCrs);
        end;
    end;

  finally
    DestroyColInfos;
    SetState(ePrevState);
    FResultSetMode := 0;
    FDFree(oTab);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalUseStandardMetadata: Boolean;
begin
  Result := not PgConnection.FExtendedMetadata;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.BuildColumnName(ApRecInfo: PFDPgRecInfoRec; ApColInfo: PFDPgColInfoRec): String;
begin
  if (ApRecInfo^.FParentColName <> '') and
     (ApColInfo^.FField <> nil) and (ApColInfo^.FField.ParentField <> nil) and
     (paArray in ApColInfo^.FField.ParentField.TypeRef.Attrs) then
    if ApRecInfo^.FFixedLength > 0 then
      Result := ApRecInfo^.FParentColName + '[' + IntToStr(ApRecInfo^.FColIndex) + ']'
    else
      Result := ApRecInfo^.FParentColName + '[]'
  else
    Result := ApColInfo^.FName;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean;
var
  pColInfo: PFDPgColInfoRec;
  sParName: String;
begin
  Result := OpenBlocked;
  if ATabInfo.FSourceID = -1 then begin
    ATabInfo.FSourceName := GetCommandText;
    ATabInfo.FSourceID := 1;

    FCurrentRecInfo := @FBaseRecInfo;
    FCurrentRecInfo^.FColIndex := 0;
    FCurrentRecInfo^.FFixedLength := 0;
    FCurrentRecInfo^.FParentColName := '';
  end

  else begin
    pColInfo := @FCurrentRecInfo^.FColInfos[ATabInfo.FSourceID - 1];
    ATabInfo.FSourceName := pColInfo^.FName;
    ATabInfo.FSourceID := ATabInfo.FSourceID;
    sParName := BuildColumnName(FCurrentRecInfo, pColInfo);

    FInfoStack.Add(FCurrentRecInfo);
    FCurrentRecInfo := pColInfo^.FRecInfo;
    FCurrentRecInfo^.FColIndex := 0;
    FCurrentRecInfo^.FFixedLength := pColInfo^.FLen;
    FCurrentRecInfo^.FParentColName := sParName;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean;
var
  iCol: Integer;
  pColInfo: PFDPgColInfoRec;
begin
  if (FCurrentRecInfo^.FFixedLength > 0) and
       (FCurrentRecInfo^.FColIndex < FCurrentRecInfo^.FFixedLength * Length(FCurrentRecInfo^.FColInfos)) or
     (FCurrentRecInfo^.FFixedLength = 0) and
       (FCurrentRecInfo^.FColIndex < Length(FCurrentRecInfo^.FColInfos)) then begin
    iCol := FCurrentRecInfo^.FColIndex mod Length(FCurrentRecInfo^.FColInfos);
    pColInfo := @FCurrentRecInfo^.FColInfos[iCol];

    AColInfo.FSourceName := BuildColumnName(FCurrentRecInfo, pColInfo);
    AColInfo.FSourceID := pColInfo^.FPos;
    AColInfo.FSourceType := pColInfo^.FSrcDataType;
    if (pColInfo^.FField <> nil) and
       ([paRecord, paRange, paEnum, paCast] * pColInfo^.FField.TypeRef.Attrs <> []) then
      AColInfo.FSourceTypeName := pColInfo^.FField.TypeRef.Name
    else
      AColInfo.FSourceTypeName := '';
    AColInfo.FOriginTabName.FSchema := pColInfo^.FOriginSchemaName;
    AColInfo.FOriginTabName.FObject := pColInfo^.FOriginTabName;
    AColInfo.FOriginColName := pColInfo^.FOriginColName;
    AColInfo.FType := pColInfo^.FDestDataType;
    AColInfo.FLen := pColInfo^.FLen;
    AColInfo.FPrec := pColInfo^.FPrec;
    AColInfo.FScale := pColInfo^.FScale;
    AColInfo.FAttrs := pColInfo^.FAttrs;
    AColInfo.FForceAddOpts := [];
    if pColInfo^.FInPK then
      Include(AColInfo.FForceAddOpts, coInKey);

    Inc(FCurrentRecInfo^.FColIndex);
    Result := True;
  end
  else begin
    if FInfoStack.Count > 0 then begin
      FCurrentRecInfo := PFDPgRecInfoRec(FInfoStack.Last);
      FInfoStack.Delete(FInfoStack.Count - 1);
    end;
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.ExecuteBatchInsert(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
var
  sBatchSQL: String;
  iBatchSQLPos: Integer;
  pParInfo: PFDPgParInfoRec;

  procedure W(const AStr: String);
  var
    iLen: Integer;
  begin
    iLen := Length(AStr);
    if iBatchSQLPos + iLen > Length(sBatchSQL) then
      SetLength(sBatchSQL, Length(sBatchSQL) * 2);
    Move(PChar(AStr)^, (PChar(sBatchSQL) + iBatchSQLPos)^, iLen * SizeOf(Char));
    Inc(iBatchSQLPos, iLen);
  end;

  procedure C(AIndex, ACount: Integer);
  begin
    if iBatchSQLPos + ACount > Length(sBatchSQL) then
      SetLength(sBatchSQL, Length(sBatchSQL) * 2);
    Move((PChar(FDBCommandText) + AIndex)^, (PChar(sBatchSQL) + iBatchSQLPos)^, ACount * SizeOf(Char));
    Inc(iBatchSQLPos, ACount);
  end;

var
  oFmtOpts: TFDFormatOptions;
  oParams: TFDParams;
  oParam: TFDParam;
  oPgParam: TPgParam;
  oSrcPgParam: TPgParam;

  i, j, iParamCnt: Integer;
  lIsDollar: Boolean;
  lIsParam: Boolean;
  iDollarPos: Integer;
  aParamsPos: array of Integer;

  iBatchParamInd: Integer;
  iBatchSize: Integer;
begin
  oParams := GetParams;
  iBatchSize := ATimes - AOffset;

  if not CheckArray(iBatchSize) then begin
    if GetCommandKind in [skDelete, skInsert, skUpdate, skMerge] then begin
      iParamCnt := 0;
      for i := 0 to oParams.Count - 1 do
        if oParams[i].ParamType in [ptUnknown, ptInput, ptInputOutput] then
          Inc(iParamCnt);
    end
    else
      iParamCnt := oParams.Count;
    lIsDollar := False;
    lIsParam := False;
    iDollarPos := 1;
    i := FSQLValuesPos;
    j := 1;
    SetLength(aParamsPos, iParamCnt * 2 + 2);
    aParamsPos[0] := FSQLValuesPos + 5;
    while i <= FSQLValuesPosEnd do begin
      case FDBCommandText[i] of
      '$':
        begin
          lIsDollar := not lIsDollar;
          if lIsDollar then
            iDollarPos := i;
        end;
      '0'..'9':
        lIsParam := lIsDollar;
      else
        if lIsParam then begin
          aParamsPos[j] := iDollarPos - 2;
          aParamsPos[j + 1] := i - 1;
          Inc(j, 2);
        end;
        lIsDollar := False;
        lIsParam := False;
      end;
      Inc(i);
    end;
    ASSERT(j = Length(aParamsPos) - 1);
    aParamsPos[j] := FSQLValuesPosEnd - 1;

    iBatchSQLPos := 0;
    iBatchParamInd := 1;
    SetLength(sBatchSQL, 16384);
    C(0, FSQLValuesPos + 5);
    for j := 0 to iBatchSize - 1 do begin
      if j > 0 then
        W(',');
      C(aParamsPos[0], aParamsPos[1] - aParamsPos[0] + 1);
      for i := 1 to Length(aParamsPos) div 2 - 1 do begin
        W('$');
        W(IntToStr(iBatchParamInd));
        C(aParamsPos[i * 2], aParamsPos[i * 2 + 1] - aParamsPos[i * 2] + 1);
        Inc(iBatchParamInd);
      end;
    end;
    C(FSQLValuesPosEnd, Length(FDBCommandText) - FSQLValuesPosEnd);
    SetLength(sBatchSQL, iBatchSQLPos);

    FStmt.Params.Count := FStmtParamsCount * iBatchSize;
    for i := 0 to iBatchSize - 1 do
      for j := 0 to FStmtParamsCount - 1 do begin
        oSrcPgParam := FStmt.Params[j];
        oPgParam := FStmt.Params[i * iParamCnt + j];

        oPgParam.TypeOid := oSrcPgParam.TypeOid;
        oPgParam.Encoding := oSrcPgParam.Encoding;
        oPgParam.Size := oSrcPgParam.Size;
        oPgParam.DumpLabel := Format('%s [%d]', [oSrcPgParam.DumpLabel, j]);
      end;
    FStmt.PrepareSQL(sBatchSQL);
  end;

  oFmtOpts := GetOptions.FormatOptions;
  for i := 0 to iBatchSize - 1 do
    for j := 0 to Length(FBaseVecInfo.FParInfos) - 1 do begin
      oParam := oParams[j];
      pParInfo := @FBaseVecInfo.FParInfos[j];
      oPgParam := FStmt.Params[i * FStmtParamsCount + pParInfo^.FPgParamIndex];
      SetParamValue(oFmtOpts, oParam, oPgParam, pParInfo, i + AOffset);
    end;
  FStmt.Execute;
  Inc(ACount, iBatchSize);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.CheckArray(ASize: Integer): Boolean;
begin
  Result := (ASize = 1) and (FPreparedBatchSize <= 1) or
            (ASize = FPreparedBatchSize);
  if not Result then begin
    FStmt.Unprepare;
    FPreparedBatchSize := ASize;
    if ASize = 1 then begin
      FStmt.Params.Count := FStmtParamsCount;
      FStmt.PrepareSQL(FDBCommandText);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.DoExecute(ATimes, AOffset: Integer; var ACount: TFDCounter);
var
  i: Integer;
  iTimes: Integer;
  iCount: TFDCounter;
begin
  if ATimes - AOffset > 1 then begin
    if (PgConnection.FServerVersion >= svPGSQL080100) and
       (GetCommandKind in [skInsert, skMerge]) and (FSQLValuesPos > 0) then begin
      ExecuteBatchInsert(ATimes, AOffset, ACount);
      GetParamValues(AOffset);
    end

    else begin
      if ATimes > GetParams.ArraySize then
        iTimes := GetParams.ArraySize
      else
        iTimes := ATimes;
      for i := AOffset to iTimes - 1 do begin
        iCount := 0;
        try
          DoExecute(i + 1, i, iCount);
        finally
          Inc(ACount, iCount);
        end;
        CheckExact(ATimes = 1, 1, 0, iCount, False);
      end;
    end;
  end

  else begin
    CheckArray(1);
    SetParamValues(AOffset);
    try
      try
        if UseExecDirect then
          FStmt.ExecuteDirect(FDbCommandText)
        else
          FStmt.Execute;
      except
        on E: EPgNativeException do begin
          E.Errors[0].RowIndex := AOffset;
          raise;
        end;
      end;
    finally
      Inc(ACount, FStmt.RowsAffected);
    end;
    GetParamValues(AOffset);
    FStmt.Close;

    if GetCommandKind = skSetSchema then
      PgConnection.UpdateCurrentMeta;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  ACount := 0;
  DoExecute(ATimes, AOffset, ACount);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalOpen: Boolean;
begin
  if not GetNextRecordSet then
    FActiveCrs := -1;

  if GetMetaInfoKind = mkProcArgs then begin
    Result := True;
    Exit;
  end
  else if (GetMetaInfoKind <> mkNone) and (FDbCommandText = '') then begin
    Result := False;
    Exit;
  end
  else if not FCursorCanceled then begin
    Result := True;
    Exit;
  end;

  if GetMetaInfoKind = mkProcs then begin
    FMetaProcName := '';
    FMetaProcOverload := 0;
  end;

  SetParamValues;
  if GetCommandKind = skStoredProcWithCrs then begin
    if FActiveCrs = - 1 then begin
      FActiveCrs := 0;
      if UseExecDirect then
        FStmt.ExecuteDirect(FDbCommandText)
      else
        FStmt.Execute;
      GetParamValues(0);
    end;
    ASSERT(FActiveCrs < Length(FCursors));
    FStmt := CreateStmt;
    try
      FStmt.PrepareCursor(FCursors[FActiveCrs]);
    except
      FDFreeAndNil(FStmt);
      raise;
    end;
  end;

  try
    if UseExecDirect then
      FStmt.ExecuteDirect(FDbCommandText)
    else
      FStmt.Execute;
    FStmt.DescribeFields;
    CheckColInfos;
    Result := Length(FBaseRecInfo.FColInfos) > 0;
    FCursorCanceled := False;
  except
    FCursorCanceled := True;
    InternalClose;
    raise;
  end;

  if GetCommandKind = skSetSchema then
    PgConnection.UpdateCurrentMeta;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalNextRecordSet: Boolean;
begin
  if FActiveCrs < 0 then begin
    Result := False;
    Exit;
  end;
  if FActiveCrs < Length(FCursors) then
    Inc(FActiveCrs);
  if FActiveCrs < Length(FCursors) then
    Result := InternalOpen
  else begin
    InternalClose;
    Result := False;
    FCursorCanceled := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.FetchRow(ApRecInfo: PFDPgRecInfoRec;
  ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  oRow: TFDDatSRow;
  oCol: TFDDatSColumn;
  oFmtOpts: TFDFormatOptions;
  pColInfo: PFDPgColInfoRec;
  j: Integer;
  lMetadata: Boolean;

  procedure ProcessColumn(AColIndex: Integer; ARow: TFDDatSRow;
    ApInfo: PFDPgColInfoRec);
  var
    pData: Pointer;
    iSize, iDestSize: LongWord;
    iOid: Integer;
    oBlob: TPgLargeObject;
    iLBound, iHBound, i: Integer;
    oNestedTable: TFDDatSTable;
    oNestedRow: TFDDatSRow;
    lClosed: Boolean;
  begin
    pData := nil;
    iSize := 0;
    if (ApInfo^.FField = nil) or not CheckFetchColumn(ApInfo^.FSrcDataType, ApInfo^.FAttrs) then
      Exit

    // null
    else if not ApInfo^.FField.GetData(pData, iSize, True) then
      ARow.SetData(AColIndex, nil, 0)

    // composite type
    else if ApInfo^.FDestDataType = dtRowRef then begin
      oNestedTable := ARow.Table.Columns[AColIndex].NestedTable;
      FetchRow(ApInfo^.FRecInfo, oNestedTable, ARow);
    end

    // unbound array
    else if ApInfo^.FDestDataType = dtRowSetRef then begin
      ApInfo^.FField.GetArrayBounds(iLBound, iHBound, lClosed);
      if iHBound - iLBound >= 0 then begin
        oNestedTable := ARow.Table.Columns[AColIndex].NestedTable;
        try
          for i := iLBound to iHBound do begin
            ApInfo^.FField.ArrayIndex := i;
            FetchRow(ApInfo^.FRecInfo, oNestedTable, ARow);
          end;
          if lClosed then begin
            ApInfo^.FField.ArrayIndex := 0;
            FetchRow(ApInfo^.FRecInfo, oNestedTable, ARow);
          end;
        finally
          ApInfo^.FField.ArrayIndex := -1;
        end;
      end;
      ARow.Fetched[AColIndex] := True;
    end

    // constrained array
    else if ApInfo^.FDestDataType = dtArrayRef then begin
      ApInfo^.FField.GetArrayBounds(iLBound, iHBound, lClosed);
      if iHBound - iLBound >= 0 then begin
        oNestedTable := ARow.Table.Columns[AColIndex].NestedTable;
        oNestedRow := oNestedTable.NewRow(False);
        try
          for i := iLBound to Min(iLBound + oNestedTable.Columns.Count - 2, iHBound) do begin
            ApInfo^.FField.ArrayIndex := i;
            ProcessColumn(i - iLBound, oNestedRow, @ApInfo^.FRecInfo.FColInfos[0]);
          end;
          ApInfo^.FField.ArrayIndex := -1;
          oNestedRow.ParentRow := ARow;
          oNestedTable.Rows.Add(oNestedRow);
        except
          ApInfo^.FField.ArrayIndex := -1;
          FDFree(oNestedRow);
          raise;
        end;
      end;
      ARow.Fetched[AColIndex] := True;
    end

    // conversion is not required
    else if ApInfo^.FSrcDataType = ApInfo^.FDestDataType then
      if ApInfo^.FDestDataType = dtHBlob then begin
        if ApInfo^.FField.GetData(@iOid, iSize) then begin
          oBlob := TPgLargeObject.Create(GetConnection.FConnection, smOpenRead, Self, iOid);
          try
            oBlob.Open;
            iSize := oBlob.Len;
            pData := ARow.BeginDirectWriteBlob(AColIndex, iSize);
            try
              if iSize > 0 then
                oBlob.Read(pData, iSize);
            finally
              ARow.EndDirectWriteBlob(AColIndex, iSize);
            end;
          finally
            FDFree(oBlob);
          end;
        end
      end
      else if ApInfo^.FDestDataType in [dtAnsiString, dtWideString, dtMemo, dtWideMemo,
                                        dtXML, dtBlob, dtByteString] then
        ARow.SetData(AColIndex, pData, iSize)
      else begin
        FBuffer.Check(iSize);
        ApInfo^.FField.GetData(FBuffer.FBuffer, iSize);
        ARow.SetData(AColIndex, FBuffer.Ptr, iSize);
      end

    // conversion is required
    else begin
      FBuffer.Check((iSize + 1) * SizeOf(WideChar));
      ApInfo^.FField.GetData(FBuffer.FBuffer, iSize);
      iDestSize := 0;
      oFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ApInfo^.FDestDataType,
        FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestSize,
        PgConnection.FConnection.Encoder);
      ARow.SetData(AColIndex, FBuffer.Ptr, iDestSize);
    end;
  end;

  procedure ProcessMetaColumn(AColIndex: Integer; ARow: TFDDatSRow;
    ApInfo: PFDPgColInfoRec);
  var
    pData: Pointer;
    iSize, iDestSize: Longword;
  begin
    pData := nil;
    iSize := 0;

    if AColIndex = 0 then
      ARow.SetData(0, ATable.Rows.Count + 1)

    else if not ApInfo^.FField.GetData(pData, iSize, True) then
      ARow.SetData(AColIndex, nil, 0)

    else if ApInfo^.FDestDataType in [dtAnsiString, dtWideString, dtMemo, dtWideMemo,
                                      dtXML, dtBlob, dtByteString] then begin
      if iSize > ATable.Columns[AColIndex].Size then
        iSize := ATable.Columns[AColIndex].Size;
      if ApInfo^.FDestDatatype in C_FD_AnsiTypes then begin
        FBuffer.Check(iSize * SizeOf(WideChar));
        oFmtOpts.ConvertRawData(dtAnsiString, dtWideString,
          pData, iSize, FBuffer.FBuffer, FBuffer.Size, iDestSize,
          PgConnection.FConnection.Encoder);
        ARow.SetData(AColIndex, FBuffer.Ptr, iDestSize);
      end
      else
        ARow.SetData(AColIndex, pData, iSize);
    end
    else begin
      FBuffer.Check(iSize);
      ApInfo^.FField.GetData(FBuffer.FBuffer, iSize, False);
      iDestSize := 0;
      if ApInfo^.FDestDataType in [dtUInt16, dtUInt32, dtInt16, dtInt32,
                                   dtSingle, dtDouble, dtBCD, dtFmtBCD] then
        oFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ATable.Columns[AColIndex].DataType,
          FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestSize,
          PgConnection.FConnection.Encoder);
      ARow.SetData(AColIndex, FBuffer.Ptr, iDestSize);
    end;
  end;

begin
  oFmtOpts := FOptions.FormatOptions;
  oRow := ATable.NewRow(False);
  lMetadata := GetMetaInfoKind <> mkNone;
  try
    for j := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[j];
      if oCol.SourceID > 0 then begin
        pColInfo := @ApRecInfo^.FColInfos[oCol.SourceID - 1];
        if lMetadata then
          ProcessMetaColumn(j, oRow, pColInfo)
        else
          ProcessColumn(j, oRow, pColInfo);
      end;
    end;
    if AParentRow <> nil then begin
      oRow.ParentRow := AParentRow;
      AParentRow.Fetched[ATable.Columns.ParentCol] := True;
    end;
    ATable.Rows.Add(oRow);
  except
    FDFree(oRow);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.FetchTableFieldsRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  oRow: TFDDatSRow;
  eType: TFDDataType;
  eAttrs: TFDDataAttributes;
  iTypeOid: Oid;
  iAttrs: Word;
  iLen: LongWord;
  iPrec: Integer;
  iScale: Integer;
begin
  FetchRow(@FBaseRecInfo, ATable, AParentRow);
  oRow := ATable.Rows[ATable.Rows.Count - 1];
  iAttrs := oRow.GetData(8);
  eAttrs := TFDDataAttributes(Pointer(@iAttrs)^);
  iTypeOid := LongWord(oRow.GetData(6));
  SQL2FDColInfo(iTypeOid, oRow.GetData(11), oRow.GetData(9),
    oRow.GetData(10), eType, eAttrs, iLen, iPrec, iScale, FOptions.FormatOptions);
  if paOID in PgConnection.FConnection.TypesManager.Types[iTypeOid].Attrs then
    PgConnection.AdjustOIDasBLOB(oRow.GetData(7), oRow.GetData(2), eType, eAttrs);
  oRow.SetData(6, Integer(eType));
  oRow.SetData(8, PWord(@eAttrs)^);
  oRow.SetData(9, iPrec);
  oRow.SetData(10, iScale);
  oRow.SetData(11, Integer(iLen));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.FetchProcsRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  sProcName: String;
  oRow: TFDDatSRow;
begin
  FetchRow(@FBaseRecInfo, ATable, AParentRow);
  oRow := ATable.Rows[ATable.Rows.Count - 1];
  sProcName := oRow.GetData(4);
  if sProcName = FMetaProcName then
    Inc(FMetaProcOverload)
  else begin
    FMetaProcName := sProcName;
    FMetaProcOverload := 0;
  end;
  if FMetaProcOverload > 0 then
    oRow.SetData(5, FMetaProcOverload);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.FetchSPParamRows(ATable: TFDDatSTable; AParentRow: TFDDatSRow): Integer;
var
  iRecNo: Integer;
  i: Integer;
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  oProcArgs: TFDProcArgRecs;
  oDesc: TFDPhysPgSPDescriber;
  pArg: PFDProcArgRec;

  procedure AddParam(const AParamName: String; ATypeOID: Integer; AParamType: TParamType);
  var
    oRow: TFDDatSRow;
    eType: TFDDataType;
    eAttrs: TFDDataAttributes;
    iPrec: Integer;
    iScale: Integer;
    uiLen: LongWord;
    oType: TPgType;
  begin
    eType := dtUnknown;
    iPrec := 0;
    iScale := 0;
    eAttrs := [caAllowNull];

    SQL2FDColInfo(ATypeOID, 0, 0, 0, eType, eAttrs, uiLen, iPrec,
      iScale, FOptions.FormatOptions);
    try
      oType := PgConnection.FConnection.TypesManager.Types[ATypeOID];
    except
      oType := nil;
    end;

    oRow := ATable.NewRow(False);
    oRow.SetData(0, iRecNo);
    if rName.FCatalog = '' then
      oRow.SetData(1, PgConnection.FMetaCatalog)
    else
      oRow.SetData(1, rName.FCatalog);
    oRow.SetData(2, rName.FSchema);
    oRow.SetData(3, nil, 0);
    oRow.SetData(4, rName.FObject);
    oRow.SetData(5, GetOverload);
    oRow.SetData(6, AParamName);
    oRow.SetData(7, Smallint(iRecNo));
    oRow.SetData(8, Smallint(AParamType));
    oRow.SetData(9, Smallint(eType));
    if oType <> nil then
      oRow.SetData(10, oType.Name)
    else
      oRow.SetData(10, nil, 0);
    oRow.SetData(11, PWord(@eAttrs)^);
    oRow.SetData(12, 0);
    oRow.SetData(13, 0);
    oRow.SetData(14, uiLen);
    ATable.Rows.Add(oRow);
    Inc(iRecNo);
  end;

begin
  FConnection.CreateMetadata(oConnMeta);
  oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self, [doNormalize, doUnquote]);
  CheckMetaInfoParams(rName);
  oDesc := TFDPhysPgSPDescriber.Create(Self, rName);
  try
    oDesc.ReadProcArgs(oProcArgs);
  finally
    FDFree(oDesc);
  end;
  iRecNo := 1;
  for i := 0 to Length(oProcArgs) - 1 do begin
    pArg := @oProcArgs[i];
    AddParam(pArg^.FName, pArg^.FTypeOid, pArg^.FParamType);
  end;
  Result := Length(oProcArgs);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPgCommand.InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
  ARowsetSize: LongWord): LongWord;
var
  i: LongWord;
begin
  Result := 0;
  if GetMetaInfoKind = mkProcArgs then
    Result := FetchSPParamRows(ATable, AParentRow)
  else
    for i := 1 to ARowsetSize do begin
      if not FStmt.Fetch then
        Break;
      case GetMetaInfoKind of
      mkTableFields: FetchTableFieldsRow(ATable, AParentRow);
      mkProcs:       FetchProcsRow(ATable, AParentRow);
      else           FetchRow(@FBaseRecInfo, ATable, AParentRow);
      end;
      Inc(Result);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.InternalAbort;
begin
  TFDPhysPgConnection(FConnectionObj).FConnection.Abort;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.InternalClose;
begin
  if (FStmt <> nil) and not FCursorCanceled then begin
    FCursorCanceled := True;
    DestroyColInfos;
    FStmt.Close;
  end;
  if FStmt <> FBaseStmt then begin
    FDFree(FStmt);
    FStmt := FBaseStmt;
  end;
  if not GetNextRecordSet then begin
    if FBaseStmt <> nil then
      FBaseStmt.Close;
    FActiveCrs := -1;
  end;
  FInfoStack.Clear;
  FCurrentRecInfo := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPgCommand.InternalUnprepare;
begin
  FPreparedBatchSize := 0;
  if FStmt = nil then
    Exit;
  FBaseStmt := nil;
  FStmt.Unprepare;
  DestroyParamInfos;
  DestroyColInfos;
  FDFreeAndNil(FStmt);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysPgDriver);

end.
