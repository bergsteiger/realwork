{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC ODBC driver base classes            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ODBCBase;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper;

type
  TFDPhysODBCBaseDriverLink = class(TFDPhysDriverLink)
  private
    FODBCAdvanced: String;
    FODBCDriver: String;
  protected
    function IsConfigured: Boolean; override;
    procedure ApplyTo(const AParams: IFDStanDefinition); override;
  public
    procedure GetDrivers(AList: TStrings);
    procedure GetDSNs(AList: TStrings; AWithDescription: Boolean = False);
  published
    property ODBCDriver: String read FODBCDriver write FODBCDriver;
    property ODBCAdvanced: String read FODBCAdvanced write FODBCAdvanced;
  end;

  TFDPhysODBCBaseService = class (TFDPhysDriverService)
  private
    function GetLib: TODBCLib;
  protected
    function GetEnv: TODBCEnvironment; virtual;
  public
    procedure ExecuteBase(ARequest: Word; ADriver: String; AAttributes: String);
    property Env: TODBCEnvironment read GetEnv;
    property Lib: TODBCLib read GetLib;
  end;

  TFDPhysODBCDriverBase = class;
  TFDPhysODBCConnectionBase = class;
  TFDPhysODBCTransaction = class;
  TFDPhysODBCCommand = class;

  TFDPhysODBCCliHandles = array [0..1] of SQLHandle;
  PFDPhysODBCCliHandles = ^TFDPhysODBCCliHandles;

  IFDPhysODBCDriver = interface
    ['{A52C2247-E07C-4BEB-821B-6DF097828ED0}']
    function GetODBCDriver: String;
    function GetODBCAdvanced: String;
    // public
    property ODBCDriver: String read GetODBCDriver;
    property ODBCAdvanced: String read GetODBCAdvanced;
  end;

  TFDPhysODBCDriverBase = class(TFDPhysDriver,
    IFDPhysDriverConnectionWizard, IFDPhysODBCDriver)
  private
    FODBCLib: TODBCLib;
    FODBCEnvironment: TODBCEnvironment;
    FODBCDriver: String;
    FODBCAdvanced: String;
    FKeywords: TFDStringList;
  protected
    // TFDPhysDriver
    procedure InternalLoad; override;
    procedure InternalUnload; override;
    function GetCliObj: Pointer; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
    // IFDPhysDriverConnectionWizard
    function RunConnectionWizard(const AConnectionDef: IFDStanConnectionDef;
      AParentWnd: THandle): Boolean;
      function IFDPhysDriverConnectionWizard.Run = RunConnectionWizard;
    // IFDPhysODBCDriver
    function GetODBCDriver: String;
    function GetODBCAdvanced: String;
    // introduced
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); virtual;
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); override;
    destructor Destroy; override;
    function BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): string; virtual;
    function FindBestDriver(const ADrivers: array of String;
      const ADefaultDriver: String = ''): String;
    property ODBCDriver: String read FODBCDriver write FODBCDriver;
    property ODBCAdvanced: String read FODBCAdvanced write FODBCAdvanced;
    property ODBCLib: TODBCLib read FODBCLib;
    property ODBCEnvironment: TODBCEnvironment read FODBCEnvironment;
  end;

  TFDPhysODBCSupportedOptions = set of (soPKFunction, soFKFunction, soParamSet,
    soRowSet, soMoney, soArrayBatch);
  TFDPhysODBCConnectionBase = class(TFDPhysConnection)
  private
    FODBCEnvironment: TODBCEnvironment;
    FODBCConnection: TODBCConnection;
    FCliHandles: TFDPhysODBCCliHandles;
    FSupportedOptions: TFDPhysODBCSupportedOptions;
    FTxnIsolations: array[TFDTxIsolation] of SQLUInteger;
    procedure MapTxIsolations;
    function GetDriverKind: TODBCDriverKind; inline;
  protected
    // TFDPhysConnection
    procedure InternalConnect; override;
    procedure InternalSetMeta; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateTransaction: TFDPhysTransaction; override;
    procedure InternalDisconnect; override;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; override;
{$ENDIF}
    procedure InternalExecuteDirect(const ASQL: String; ATransaction: TFDPhysTransaction); override;
    procedure GetItem(AIndex: Integer; out AName: String; out AValue: Variant;
      out AKind: TFDMoniAdapterItemKind); override;
    function GetItemCount: Integer; override;
    function GetMessages: EFDDBEngineException; override;
    function GetCliObj: Pointer; override;
    function InternalGetCliHandle: Pointer; override;
    function InternalGetCurrentCatalog: String; override;
    function InternalGetCurrentSchema: String; override;
    // introduced
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); virtual;
    function GetStrsType: TFDDataType; virtual;
    function GetNumType: TFDDataType; virtual;
    procedure UpdateDecimalSep; virtual;
    function GetExceptionClass: EODBCNativeExceptionClass; virtual;
    procedure SetupConnection; virtual;
    function GetODBCVersion: Integer; virtual;
    function GetKeywords: String;
    procedure GetVersions(out AServer, AClient: TFDVersion);
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
    destructor Destroy; override;
    property ODBCEnvironment: TODBCEnvironment read FODBCEnvironment;
    property ODBCConnection: TODBCConnection read FODBCConnection;
    property DriverKind: TODBCDriverKind read GetDriverKind;
  end;

  TFDPhysODBCTransaction = class(TFDPhysTransaction)
  private
    function GetODBCConnection: TODBCConnection;
    procedure DisconnectCommandsBeforeCommit;
    procedure DisconnectCommandsBeforeRollback;
  protected
    procedure InternalStartTransaction(ATxID: LongWord); override;
    procedure InternalChanged; override;
    procedure InternalCommit(ATxID: LongWord); override;
    procedure InternalRollback(ATxID: LongWord); override;
    procedure InternalReleaseHandle; override;
    procedure InternalNotify(ANotification: TFDPhysTxNotification; ACommandObj: TFDPhysCommand); override;
  public
    property ODBCConnection: TODBCConnection read GetODBCConnection;
  end;

  PFDODBCColInfoRec = ^TFDODBCVarInfoRec;
  PFDODBCParInfoRec = ^TFDODBCVarInfoRec;
  TFDODBCVarInfoRec = record
    FName: String;
    FExtName: String;
    FOriginCatalogName,
    FOriginSchemaName,
    FOriginTabName,
    FOriginColName: String;
    FPos: SQLSmallInt;
    FParamIndex: SQLSmallInt;
    FColSize: SQLInteger;
    FScale: SQLInteger;
    FSrcSQLDataType,
    FOutSQLDataType: SQLSmallInt;
    FSrcDataType,
    FOutDataType,
    FDestDataType: TFDDataType;
    FVar: TODBCVariable;
    FSubInfos: array of TFDODBCVarInfoRec;
    // FAttrs moved to here out of True case due to C++Builder incompatibility
    FAttrs: TFDDataAttributes;
    case Boolean of
    True: (
      FInKey: Boolean;
      FFDLen: LongWord;
      FFDScale: Integer;
    );
    False: (
      FIsNull: Boolean;
      FParamType: TParamType;
      FDataType: TFieldType;
    );
  end;

  TFDPhysODBCStatementProp = (cpParamSet, cpRowSet, cpLateBindedData, cpOutResParams,
    cpOutParams, cpDefaultCrs, cpOnNextResult, cpOnNextResultValue, cpNotFirstCursor,
    cpResetOnArrayOffset, cpUnifyParams);
  TFDPhysODBCStatementProps = set of TFDPhysODBCStatementProp;

  TFDPhysODBCCommand = class(TFDPhysCommand)
  private
    FColumnIndex: Integer;
    FStatement: TODBCStatementBase;
    [weak] FCommandStatement: TODBCCommandStatement;
    [weak] FMetainfoStatement: TODBCMetaInfoStatement;
    FMetainfoAddonView: TFDDatSView;
    FStatementProps: TFDPhysODBCStatementProps;
    function GetConnection: TFDPhysODBCConnectionBase;
    procedure DestroyDescribeInfos;
    procedure DestroyParamInfos;
    function FetchMetaRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowIndex, ARowNo: SQLUInteger): Boolean;
    procedure FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow; ARowIndex: SQLUInteger);
    procedure GetParamValues(ATimes, AOffset: Integer; AFromParIndex: Integer);
    function OpenMetaInfo: Boolean;
    procedure SetParamValues(ATimes, AOffset: Integer; AFromParIndex: Integer);
    procedure SetupStatementBeforePrepare(AStmt: TODBCStatementBase);
    procedure SetupStatementAfterDescribe(AStmt: TODBCStatementBase);
    procedure SetupStatementBeforeExecute(AStmt: TODBCStatementBase);
    function GetRowsetSize(ARowsetSize: Integer): Integer;
    function GetParamsetSize(AParamsetSize: Integer): Integer;
    function MatchParamsetSize(AParamsetSize1, AParamsetSize2: Integer): Boolean;
    function UseExecDirect: Boolean;
    function UseInformationSchema: Boolean;
    function UseStatement: Boolean;
    procedure CloseStatement(AIndex: Integer; AForceClose, AGetOutParams,
      AIgnoreErrors: Boolean);
    function GetCursor(var ARows: SQLLen): Boolean;
  protected
    FColInfos: array of TFDODBCVarInfoRec;
    FParInfos: array of TFDODBCVarInfoRec;
    function CheckFetchColumn(ADataType: TFDDataType; AAttributes: TFDDataAttributes;
      ASQLDataType: Smallint): Boolean; overload;
    function FD2SQLDataType(AFDType: TFDDataType; AFixedLen: Boolean;
      var AColSize, AScale: SQLInteger): SQLSmallint;
    function FD2CDataType(AFDType: TFDDataType; ANestedColumn: Boolean): SQLSmallint;
    procedure SQL2FDColInfo(ASQLDataType: SQLSmallint; AUnsigned: Boolean;
      const ASQLTypeName: String; var ASQLSize: SQLInteger; ASQLDecimals: SQLInteger;
      var AType: TFDDataType; var AAttrs: TFDDataAttributes; var ALen: LongWord;
      var APrec, AScale: Integer);
    function FD2SQLParamType(AParamType: TParamType): SQLSmallint;
    // TFDPhysCommand
    procedure InternalAbort; override;
    procedure InternalClose; override;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; override;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    procedure InternalCloseStreams; override;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; override;
    function InternalNextRecordSet: Boolean; override;
    function InternalOpen: Boolean; override;
    procedure InternalPrepare; override;
    procedure InternalUnprepare; override;
    function GetCliObj: Pointer; override;
    // introduced
    procedure CreateDescribeInfos; virtual;
    procedure CreateParamInfos; virtual;
    procedure CreateParamColumns(AParam: TFDParam); virtual;
    procedure CreateParamColumnInfos(ApInfo: PFDODBCParInfoRec; AParam: TFDParam); virtual;
    function GetIsCustomParam(ADataType: TFDDataType): Boolean; virtual;
    procedure SetCustomParamValue(ADataType: TFDDataType; AVar: TODBCVariable;
      AParam: TFDParam; AVarIndex, AParIndex: Integer); virtual;
    procedure GetCustomParamValue(ADataType: TFDDataType; AVar: TODBCVariable;
      AParam: TFDParam; AVarIndex, AParIndex: Integer); virtual;
  public
    property ODBCStatement: TODBCStatementBase read FStatement;
    property ODBCConnection: TFDPhysODBCConnectionBase read GetConnection;
  end;

implementation

uses
  System.Variants, Data.FmtBcd,
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not expanded"
  Winapi.Windows,
{$ENDIF}
  FireDAC.Stan.Consts, FireDAC.Stan.Factory, FireDAC.Stan.Util,
    FireDAC.Stan.SQLTimeInt, FireDAC.Stan.ResStrs;

const
  C_FD_TxI2ODBCTxI: array[TFDTxIsolation] of SQLUInteger = (
    SQL_TXN_READ_COMMITTED, SQL_TXN_READ_UNCOMMITTED, SQL_TXN_READ_COMMITTED,
    SQL_TXN_REPEATABLE_READ, SQL_TXN_SS_SNAPSHOT, SQL_TXN_SERIALIZABLE);

  C_FD_Type2SQLDataType: array [TFDDataType] of SQLSmallint = (
    SQL_UNKNOWN_TYPE,
    SQL_BIT,
    SQL_TINYINT, SQL_SMALLINT, SQL_INTEGER, SQL_BIGINT,
    SQL_SMALLINT, SQL_INTEGER, SQL_BIGINT, SQL_BIGINT,
    SQL_REAL, SQL_DOUBLE, SQL_DOUBLE,
    SQL_DECIMAL, SQL_DECIMAL, SQL_DECIMAL,
    SQL_TIMESTAMP, SQL_TYPE_TIME, SQL_TYPE_DATE, SQL_TIMESTAMP,
    SQL_UNKNOWN_TYPE, SQL_INTERVAL_YEAR_TO_MONTH, SQL_INTERVAL_DAY_TO_SECOND,
    SQL_VARCHAR, SQL_WVARCHAR, SQL_VARBINARY,
    SQL_LONGVARBINARY, SQL_LONGVARCHAR, SQL_WLONGVARCHAR, SQL_UNKNOWN_TYPE,
    SQL_LONGVARBINARY, SQL_LONGVARCHAR, SQL_WLONGVARCHAR,
    SQL_LONGVARBINARY,
    SQL_UNKNOWN_TYPE, SQL_REFCURSOR, SQL_UNKNOWN_TYPE,
    SQL_UNKNOWN_TYPE, SQL_UNKNOWN_TYPE,
    SQL_GUID, SQL_UNKNOWN_TYPE
  );

  C_FD_Type2CDataType: array [TFDDataType] of SQLSmallint = (
    SQL_TYPE_NULL,
    SQL_C_BIT,
    SQL_C_STINYINT, SQL_C_SSHORT, SQL_C_SLONG, SQL_C_SBIGINT,
    SQL_C_UTINYINT, SQL_C_USHORT, SQL_C_ULONG, SQL_C_UBIGINT,
    SQL_C_FLOAT, SQL_C_DOUBLE, SQL_C_DOUBLE,
    SQL_C_NUMERIC, SQL_C_NUMERIC, SQL_C_NUMERIC,
    SQL_C_TYPE_TIMESTAMP, SQL_C_TYPE_TIME, SQL_C_TYPE_DATE, SQL_C_TYPE_TIMESTAMP,
    SQL_TYPE_NULL, SQL_C_INTERVAL_YEAR_TO_MONTH, SQL_C_INTERVAL_DAY_TO_SECOND,
    SQL_C_CHAR, SQL_C_WCHAR, SQL_C_BINARY,
    SQL_C_BINARY, SQL_C_CHAR, SQL_C_WCHAR, SQL_C_WCHAR,
    SQL_C_BINARY, SQL_C_CHAR, SQL_C_WCHAR,
    SQL_C_BINARY,
    SQL_TYPE_NULL, SQL_TYPE_NULL, SQL_TYPE_NULL,
    SQL_TYPE_NULL, SQL_TYPE_NULL,
    SQL_C_GUID, SQL_TYPE_NULL
  );

  C_FD_ParType2SQLParType: array [TParamType] of SQLSmallint = (
    SQL_PARAM_INPUT,
    SQL_PARAM_INPUT,
    SQL_PARAM_OUTPUT,
    SQL_PARAM_INPUT_OUTPUT,
    SQL_PARAM_OUTPUT
  );

  C_FD_BestRowID: String = 'SQL_BEST_ROWID';

{-------------------------------------------------------------------------------}
{ TFDPhysODBCBaseDriverLink                                                     }
{-------------------------------------------------------------------------------}
function TFDPhysODBCBaseDriverLink.IsConfigured: Boolean;
begin
  Result := inherited IsConfigured or (FODBCDriver <> '') or (FODBCAdvanced <> '');
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCBaseDriverLink.ApplyTo(const AParams: IFDStanDefinition);
begin
  inherited ApplyTo(AParams);
  if FODBCDriver <> '' then
    AParams.AsString[S_FD_ConnParam_ODBC_ODBCDriver] := FODBCDriver;
  if FODBCAdvanced <> '' then
    AParams.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := FODBCAdvanced;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCBaseDriverLink.GetDrivers(AList: TStrings);
begin
  if FDPhysManager.State = dmsInactive then
    FDPhysManager.Open;
  DriverIntf.Employ;
  try
    TODBCEnvironment(DriverIntf.CliObj).GetDrivers(AList);
  finally
    DriverIntf.Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCBaseDriverLink.GetDSNs(AList: TStrings; AWithDescription: Boolean = False);
begin
  if FDPhysManager.State = dmsInactive then
    FDPhysManager.Open;
  DriverIntf.Employ;
  try
    TODBCEnvironment(DriverIntf.CliObj).GetDSNs(AList, AWithDescription);
  finally
    DriverIntf.Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCBaseService                                                        }
{-------------------------------------------------------------------------------}
function TFDPhysODBCBaseService.GetEnv: TODBCEnvironment;
begin
  Result := CliObj as TODBCEnvironment;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCBaseService.GetLib: TODBCLib;
begin
  Result := Env.Lib;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCBaseService.ExecuteBase(ARequest: Word; ADriver, AAttributes: String);
var
  i: Integer;
  iErrCode: UDword;
  iErrMsgLen: WORD;
  aErrMsg: array [0 .. SQL_MAX_MESSAGE_LENGTH - 1] of SQLChar;
  sErrMsg: String;
  oExc: EODBCNativeException;
  sDrvID: String;
begin
  if not Assigned(Lib.SQLConfigDataSource) then begin
    if DriverLink <> nil then
      sDrvID := DriverLink.ActualDriverID
    else
      sDrvID := S_FD_ODBCId;
    FDCapabilityNotSupported(Self, [S_FD_LPhys, sDrvID]);
  end;
  if not Lib.SQLConfigDataSource(0, ARequest, PSQLChar(ADriver), PSQLChar(AAttributes)) then begin
    oExc := EODBCNativeException.Create;
    for i := 1 to 8 do begin
      if Lib.SQLInstallerError(i, iErrCode, @aErrMsg[0], High(aErrMsg) - 1, iErrMsgLen) <> SQL_SUCCESS then
        Break;
      SetString(sErrMsg, aErrMsg, iErrMsgLen);
      if i = 1 then
        oExc.Message := sErrMsg;
      EFDDBEngineException(oExc).AppendError(i, iErrCode, sErrMsg, '', ekOther, -1, -1);
    end;
    FDException(Self, oExc {$IFDEF FireDAC_Monitor}, False {$ENDIF});
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCDriverBase                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPhysODBCDriverBase.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  FKeywords := TFDStringList.Create;
  GetODBCConnectStringKeywords(FKeywords);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysODBCDriverBase.Destroy;
begin
  FDFreeAndNil(FKeywords);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCDriverBase.InternalLoad;
var
  sHome, sLib, sMan: String;
begin
  GetVendorParams(sHome, sLib);
  if sLib = '' then
    sMan := C_ODBC
  else
    sMan := sLib;
  Messages.Msg(Format(S_FD_ODBCLoadingManager, [sMan]));
  FODBCLib := TODBCLib.Allocate(sHome, sLib, Self);
  Messages.Msg(S_FD_ODBCCreatingEnv);
  FODBCEnvironment := TODBCEnvironment.Create(FODBCLib, Self, SQL_OV_ODBC3);
  if Params <> nil then begin
    if Params.OwnValue(S_FD_ConnParam_ODBC_ODBCDriver) then begin
      ODBCDriver := Params.AsXString[S_FD_ConnParam_ODBC_ODBCDriver];
      if ODBCDriver <> '' then
        Messages.Value('ODBCDriver', ODBCDriver);
    end;
    if Params.OwnValue(S_FD_ConnParam_ODBC_ODBCAdvanced) then begin
      ODBCAdvanced := Params.AsXString[S_FD_ConnParam_ODBC_ODBCAdvanced];
      if ODBCAdvanced <> '' then
        Messages.Value('ODBCAdvanced', ODBCAdvanced);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCDriverBase.InternalUnload;
begin
  FDFreeAndNil(FODBCEnvironment);
  TODBCLib.Release(FODBCLib);
  FODBCLib := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.GetCliObj: Pointer;
begin
  Result := FODBCEnvironment;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
begin
  Result := inherited GetConnParams(AKeys, AParams);

  Result.Rows.Add([Unassigned, S_FD_ConnParam_ODBC_ODBCAdvanced, '@S', '', S_FD_ConnParam_ODBC_ODBCAdvanced, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_LoginTimeout, '@I', '', S_FD_ConnParam_Common_LoginTimeout, -1]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCDriverBase.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  AKeywords.Add('=DRIVER');
  AKeywords.Add(S_FD_ConnParam_Common_UserName + '=UID');
  AKeywords.Add(S_FD_ConnParam_Common_Password + '=PWD*');
  AKeywords.Add('DSN');
  AKeywords.Add('FIL');
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): string;
var
  sDB, sAdv: String;
  oTmpDef: IFDStanConnectionDef;
  lHasDSN: Boolean;
  i: Integer;
begin
  sDB := Trim(AConnectionDef.Params.ExpandedDatabase);
  if Pos('=', sDB) <> 0 then begin
    FDCreateInterface(IFDStanConnectionDef, oTmpDef);
    oTmpDef.Params.SetStrings(AConnectionDef.Params);
    i := oTmpDef.Params.IndexOfName(S_FD_ConnParam_Common_Database);
    if i >= 0 then
      oTmpDef.Params.Delete(i);
    oTmpDef.ParseString(oTmpDef.BuildString(FKeywords));
    oTmpDef.ParseString(sDB);
    Result := oTmpDef.BuildString(FKeywords);
    lHasDSN := oTmpDef.HasValue(S_FD_ConnParam_ODBC_DataSource) or
      oTmpDef.HasValue('DSN') or oTmpDef.HasValue('FIL');
  end
  else begin
    Result := AConnectionDef.BuildString(FKeywords);
    lHasDSN := AConnectionDef.HasValue(S_FD_ConnParam_ODBC_DataSource) or
      AConnectionDef.HasValue('DSN') or AConnectionDef.HasValue('FIL');
  end;
  sAdv := AConnectionDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
  if sAdv = '' then
    sAdv := ODBCAdvanced;
  if sAdv <> '' then begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + sAdv;
  end;
  if not lHasDSN and (ODBCDriver <> '') then begin
    if Result <> '' then
      Result := ';' + Result;
    Result := 'DRIVER=' + TODBCLib.DecorateKeyValue(ODBCDriver) + Result;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.RunConnectionWizard(const AConnectionDef: IFDStanConnectionDef;
  AParentWnd: THandle): Boolean;
var
  oODBCConn: TODBCConnection;
  sConn: String;
begin
  Employ;
  try
    Result := False;
    oODBCConn := TODBCConnection.Create(ODBCEnvironment, Self);
    try
      try
        sConn := oODBCConn.DriverConnect(BuildODBCConnectString(AConnectionDef),
          SQL_DRIVER_PROMPT, AParentWnd);
        oODBCConn.Disconnect;
        AConnectionDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] :=
          AConnectionDef.ParseString(sConn, FKeywords);
        Result := True;
      except
        on E: EODBCNativeException do
          if E.Kind <> ekNoDataFound then
            raise;
      end;
    finally
      FDFree(oODBCConn);
    end;
  finally
    Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.GetODBCDriver: String;
begin
  Result := ODBCDriver;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.GetODBCAdvanced: String;
begin
  Result := ODBCAdvanced;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCDriverBase.FindBestDriver(const ADrivers: array of String;
  const ADefaultDriver: String = ''): String;
var
  i: Integer;
  sDriver, sAttr: String;
begin
  Result := '';
  Messages.Start(S_FD_ODBCSearchingDrv);
  try
    for i := Low(ADrivers) to High(ADrivers) do begin
      Messages.Start(Format(S_FD_ODBCCheckingDrv, [ADrivers[i]]));
      try
        if ODBCEnvironment.DriverFirst(sDriver, sAttr) then
          repeat
            if FDStrLike(sDriver, ADrivers[i], True) then begin
              Messages.Msg(Format(S_FD_ODBCFound, [sDriver]));
              Result := sDriver;
              Exit;
            end;
          until not ODBCEnvironment.DriverNext(sDriver, sAttr);
      finally
        Messages.Stop;
      end;
    end;
  finally
    if Result = '' then begin
      Messages.Msg(S_FD_ODBCWarnDrvNotFound);
      Result := ADefaultDriver;
      if Result <> '' then
        Messages.Msg(Format(S_FD_ODBCWillBeUsed, [Result]));
    end;
    Messages.Stop;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCConnectionBase                                                     }
{-------------------------------------------------------------------------------}
constructor TFDPhysODBCConnectionBase.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  inherited Create(ADriverObj, AConnHost);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysODBCConnectionBase.Destroy;
begin
  FDHighRefCounter(FRefCount);
  ForceDisconnect;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetDriverKind: TODBCDriverKind;
begin
  Result := ODBCConnection.DriverKind;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysODBCCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.InternalCreateTransaction: TFDPhysTransaction;
begin
  Result := TFDPhysODBCTransaction.Create(Self);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.InternalTracingChanged;
var
  oLib: TODBCLib;
begin
  if (DriverObj <> nil) and (TFDPhysODBCDriverBase(DriverObj).FODBCLib <> nil) then begin
    oLib := TFDPhysODBCDriverBase(DriverObj).FODBCLib;
    if FTracing and (FMonitor <> nil) and FMonitor.Tracing then
      oLib.ActivateTracing(FMonitor, Self)
    else
      oLib.DeactivateTracing(Self);
  end;
  if ODBCConnection <> nil then
    ODBCConnection.Tracing := FTracing;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.InternalExecuteDirect(const ASQL: String;
  ATransaction: TFDPhysTransaction);
var
  oStmt: TODBCCommandStatement;
  iTmpCount: SQLLen;
begin
  oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
  try
    iTmpCount := 0;
    oStmt.Execute(1, 0, iTmpCount, False, ASQL);
    oStmt.Close;
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := EODBCNativeException;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.SetupConnection;
var
  lPrevIgnoreErrors: Boolean;
begin
  if ConnectionDef.HasValue(S_FD_ConnParam_Common_LoginTimeout) then begin
    // Old informix versions (at least 9.4 and less) do not support LOGIN_TIMEOUT
    lPrevIgnoreErrors := ODBCConnection.IgnoreErrors;
    ODBCConnection.IgnoreErrors := True;
    try
      ODBCConnection.LOGIN_TIMEOUT := ConnectionDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
    finally
      ODBCConnection.IgnoreErrors := lPrevIgnoreErrors;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.InternalConnect;
var
  oODBCLib: TODBCLib;
  oConnMeta: IFDPhysConnectionMetadata;
  pCliHandles: PFDPhysODBCCliHandles;
  oStmt: TODBCCommandStatement;
begin
  oODBCLib := TFDPhysODBCDriverBase(DriverObj).FODBCLib;
  if InternalGetSharedCliHandle() <> nil then begin
    pCliHandles := PFDPhysODBCCliHandles(InternalGetSharedCliHandle());
    FODBCEnvironment := TODBCEnvironment.CreateUsingHandle(oODBCLib, pCliHandles^[0], Self);
    FODBCConnection := TODBCConnection.CreateUsingHandle(FODBCEnvironment,
      pCliHandles^[1], Self);
  end
  else begin
    FODBCEnvironment := TODBCEnvironment.Create(oODBCLib, Self, GetODBCVersion());
    FODBCConnection := TODBCConnection.Create(FODBCEnvironment, Self);
  end;
  FODBCConnection.ExceptionClass := GetExceptionClass;
  FODBCConnection.OnGetMaxSizes := GetStrsMaxSizes;
{$IFDEF FireDAC_MONITOR}
  InternalTracingChanged;
{$ENDIF}

  if InternalGetSharedCliHandle() = nil then begin
    SetupConnection;
    ODBCConnection.Connect(TFDPhysODBCDriverBase(DriverObj).
      BuildODBCConnectString(ConnectionDef));
  end;

  CreateMetadata(oConnMeta);
  ODBCConnection.RdbmsKind := oConnMeta.Kind;
  FSupportedOptions := [];

  if InternalGetSharedCliHandle() = nil then
    // SQL_ATTR_LONGDATA_COMPAT is not supported by AS400 v 6 or earlier
    if (DriverKind = dkDB2) or
       (DriverKind = dkDB2_400) and (ODBCConnection.DriverVersion >= avDB2_400_7) then
      ODBCConnection.LONGDATA_COMPAT := SQL_LD_COMPAT_YES
    else if DriverKind = dkInformix then begin
      ODBCConnection.INFX_LO_AUTOMATIC := SQL_TRUE;
      ODBCConnection.INFX_ODBC_TYPES_ONLY := SQL_TRUE;
    end;

  if DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther, dkSQLAnywhere,
                    dkAdvantage, dkMSAccessJet, dkMSAccessACE, dkInformix, dkSybaseASE] then
    Include(FSupportedOptions, soMoney);
  if ODBCConnection.GetFunctions(SQL_API_SQLPRIMARYKEYS) = SQL_TRUE then
    Include(FSupportedOptions, soPKFunction);
  if ODBCConnection.GetFunctions(SQL_API_SQLFOREIGNKEYS) = SQL_TRUE then
    Include(FSupportedOptions, soFKFunction);
  if DriverKind <> dkSQLAnywhere then
    Include(FSupportedOptions, soArrayBatch);

  // tests for the rowsets and paramsets support
  oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
  try
    oStmt.IgnoreErrors := True;
    if ((ODBCConnection.GETDATA_EXTENSIONS and SQL_GD_BLOCK) = SQL_GD_BLOCK) and
       // Firebird ODBC driver returns first record blob values
       // for all other records in the rowset.
       (ODBCConnection.DriverKind <> dkFirebird) then begin
      oStmt.ROW_ARRAY_SIZE := 5;
      if oStmt.ROW_ARRAY_SIZE = 5 then
        Include(FSupportedOptions, soRowSet);
    end;
    if not (ODBCConnection.DriverKind in [dkSolidDB, dkDB2_400]) then begin
      oStmt.PARAMSET_SIZE := 5;
      if oStmt.PARAMSET_SIZE = 5 then
        Include(FSupportedOptions, soParamSet);
    end;
  finally
    FDFree(oStmt);
  end;

  UpdateDecimalSep;
  if ODBCConnection.TXN_CAPABLE <> SQL_TC_NONE then
    MapTxIsolations;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.InternalSetMeta;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  inherited InternalSetMeta;
  CreateMetadata(oConnMeta);
  if (oConnMeta.Kind = TFDRDBMSKinds.PostgreSQL) and (FCurrentSchema = '') then
    FCurrentSchema := 'public';
  // Avoid adding a path to a full object name when DSN has default path.
  // Otherwise MS Text Driver returns "Too few parameters. Expected 1"
  if (ODBCConnection.FILE_USAGE = SQL_FILE_TABLE) and
     DirectoryExists(ODBCConnection.DATABASE_NAME) then
    Include(FAvoidImplicitMeta, npCatalog);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize, AByteSize: Integer);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetStrsType: TFDDataType;
begin
  Result := dtUnknown;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetNumType: TFDDataType;
begin
  Result := dtBCD;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetODBCVersion: Integer;
begin
  Result := SQL_OV_ODBC3_80;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.MapTxIsolations;
var
  iSuppIsol: SQLUInteger;
  eIsol: TFDTxIsolation;
  iIsol: SQLUInteger;
begin
  iSuppIsol := ODBCConnection.TXN_ISOLATION_OPTION;
  for eIsol := Low(TFDTxIsolation) to High(TFDTxIsolation) do begin
    iIsol := C_FD_TxI2ODBCTxI[eIsol];
    while ((iSuppIsol and iIsol) = 0) and (iIsol <> 0) do
      iIsol := iIsol shr 1;
    if iIsol = 0 then begin
      iIsol := C_FD_TxI2ODBCTxI[eIsol];
      while ((iSuppIsol and iIsol) = 0) and (iIsol <> 0) do
        iIsol := iIsol shl 1;
    end;
    FTxnIsolations[eIsol] := iIsol;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.UpdateDecimalSep;
begin
  FODBCConnection.DecimalSepCol := '.';
  FODBCConnection.DecimalSepPar := '.';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.InternalDisconnect;
begin
  FDFreeAndNil(FODBCConnection);
  FDFreeAndNil(FODBCEnvironment);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetItemCount: Integer;
begin
  Result := inherited GetItemCount;
  if ODBCConnection <> nil then
    Inc(Result, 6);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
var
  lPrevIgnoreErrors: Boolean;
begin
  if AIndex < inherited GetItemCount then
    inherited GetItem(AIndex, AName, AValue, AKind)
  else begin
    case AIndex - inherited GetItemCount of
    0:
      begin
        AName := 'Driver Manager version';
        // ICLIT09B.DLL returns SQL_ERROR for SQL_DM_VER, when used
        // instead of ODBC32.DLL
        lPrevIgnoreErrors := ODBCConnection.IgnoreErrors;
        ODBCConnection.IgnoreErrors := True;
        try
          AValue := ODBCConnection.DM_VER;
        finally
          ODBCConnection.IgnoreErrors := lPrevIgnoreErrors;
        end;
        AKind := ikClientInfo;
      end;
    1:
      begin
        AName := 'Driver name';
        AValue := ODBCConnection.DRIVER_NAME;
        AKind := ikSessionInfo;
      end;
    2:
      begin
        AName := 'Driver version';
        AValue := ODBCConnection.DRIVER_VER;
        AKind := ikSessionInfo;
      end;
    3:
      begin
        AName := 'Driver conformance';
        if ODBCConnection.DriverODBCVersion >= ovODBC3 then
          AValue := IntToStr(ODBCConnection.INTERFACE_CONFORMANCE)
        else
          AValue := '<undefined>';
        AKind := ikSessionInfo;
      end;
    4:
      begin
        AName := 'DBMS name';
        AValue := ODBCConnection.DBMS_NAME;
        AKind := ikSessionInfo;
      end;
    5:
      begin
        AName := 'DBMS version';
        AValue := ODBCConnection.DBMS_VER;
        AKind := ikSessionInfo;
      end;
    end;
  end;
end;

{ ----------------------------------------------------------------------------- }
function TFDPhysODBCConnectionBase.GetMessages: EFDDBEngineException;
begin
  if ODBCConnection <> nil then
    Result := ODBCConnection.Info
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetCliObj: Pointer;
begin
  Result := ODBCConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.InternalGetCliHandle: Pointer;
begin
  if ODBCEnvironment <> nil then begin
    FCliHandles[0] := ODBCEnvironment.Handle;
    FCliHandles[1] := ODBCConnection.Handle;
    Result := @FCliHandles;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.GetKeywords: String;
begin
  if (ODBCConnection <> nil) and ODBCConnection.Connected then
    Result := ODBCConnection.KEYWORDS
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionBase.GetVersions(out AServer, AClient: TFDVersion);
begin
  if ODBCConnection <> nil then begin
    AServer := FDVerStr2Int(ODBCConnection.DBMS_VER);
    if ODBCConnection.FILE_USAGE = SQL_FILE_NOT_SUPPORTED then
      AClient := FDVerStr2Int(ODBCConnection.DRIVER_VER)
    else
      AClient := AServer;
  end
  else begin
    AServer := 0;
    AClient := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.InternalGetCurrentCatalog: String;
begin
  if (ODBCConnection <> nil) and ODBCConnection.Connected then
    Result := ODBCConnection.DATABASE_NAME
  else
    Result := inherited InternalGetCurrentCatalog;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionBase.InternalGetCurrentSchema: String;
begin
  if (ODBCConnection <> nil) and ODBCConnection.Connected then
    Result := ODBCConnection.USER_NAME
  else
    Result := inherited InternalGetCurrentSchema;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCTransaction                                                        }
{-------------------------------------------------------------------------------}
function TFDPhysODBCTransaction.GetODBCConnection: TODBCConnection;
begin
  Result := TFDPhysODBCConnectionBase(ConnectionObj).ODBCConnection;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalChanged;
begin
  if xoAutoCommit in GetOptions.Changed then
    if GetOptions.AutoCommit then
      ODBCConnection.AUTOCOMMIT := SQL_AUTOCOMMIT_ON
    else
      ODBCConnection.AUTOCOMMIT := SQL_AUTOCOMMIT_OFF;
  if xoReadOnly in GetOptions.Changed then
    if GetOptions.ReadOnly then
      ODBCConnection.ACCESS_MODE := SQL_MODE_READ_ONLY
    else
      ODBCConnection.ACCESS_MODE := SQL_MODE_READ_WRITE;
  if xoIsolation in GetOptions.Changed then
    ODBCConnection.TXN_ISOLATION := TFDPhysODBCConnectionBase(ConnectionObj).
      FTxnIsolations[GetOptions.Isolation];
end;

{-------------------------------------------------------------------------------}
function DisconnectionBeforeStart(ACmdObj: TObject): Boolean;
var
  oStmt: TODBCStatementBase;
begin
  oStmt := TODBCStatementBase(ACmdObj);
  Result := oStmt.Executed and (oStmt.SS_CURSOR_OPTIONS = SQL_CO_DEFAULT);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalStartTransaction(ATxID: LongWord);
begin
  // SQL Native Client and MS Access return SQL_ERROR without any additional
  // error description, if there is any active default cursor. No problems
  // with MS SQL 2000 client or other cursor kinds.
  if ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc] then
    DisconnectCommands(DisconnectionBeforeStart, dmRelease)
  else if ODBCConnection.RdbmsKind = TFDRDBMSKinds.MSAccess then
    DisconnectCommands(nil, dmRelease);
  ODBCConnection.TransID := ATxID;
  ODBCConnection.StartTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.DisconnectCommandsBeforeCommit;
begin
{$IFDEF POSIX}
  // MSSQL: SQL Server ODBC Driver 11 for Linux may return SQL_CURSOR_COMMIT_BEHAVIOR
  // = SQL_CB_PRESERVE at first time, although existing cursors will be invalidated.
  if ODBCConnection.DriverKind = dkSQLOdbc then
    DisconnectCommands(nil, dmRelease)
  else
{$ENDIF}
    case ODBCConnection.CURSOR_COMMIT_BEHAVIOR of
    SQL_CB_DELETE: DisconnectCommands(nil, dmOffline);
    SQL_CB_CLOSE:  DisconnectCommands(nil, dmRelease);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.DisconnectCommandsBeforeRollback;
begin
{$IFDEF POSIX}
  if ODBCConnection.DriverKind = dkSQLOdbc then
    DisconnectCommands(nil, dmRelease)
  else
{$ENDIF}
    case ODBCConnection.CURSOR_ROLLBACK_BEHAVIOR of
    SQL_CB_DELETE: DisconnectCommands(nil, dmOffline);
    SQL_CB_CLOSE:  DisconnectCommands(nil, dmRelease);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalCommit(ATxID: LongWord);
begin
  DisconnectCommandsBeforeCommit;
  ODBCConnection.Commit;
  if Retaining then
    InternalStartTransaction(ATxID)
  else if CLIAutoCommit then
    ODBCConnection.AUTOCOMMIT := SQL_AUTOCOMMIT_ON;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalRollback(ATxID: LongWord);
begin
  DisconnectCommandsBeforeRollback;
  ODBCConnection.Rollback;
  if Retaining then
    InternalStartTransaction(ATxID)
  else if CLIAutoCommit then
    ODBCConnection.AUTOCOMMIT := SQL_AUTOCOMMIT_ON;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalReleaseHandle;
var
  lPrevIgnoreErrors: Boolean;
begin
  if (ODBCConnection <> nil) and ODBCConnection.Connected then begin
    lPrevIgnoreErrors := ODBCConnection.IgnoreErrors;
    ODBCConnection.IgnoreErrors := True;
    try
      ODBCConnection.AUTOCOMMIT := SQL_AUTOCOMMIT_ON;
    finally
      ODBCConnection.IgnoreErrors := lPrevIgnoreErrors;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCTransaction.InternalNotify(ANotification: TFDPhysTxNotification;
  ACommandObj: TFDPhysCommand);
begin
  if ANotification = cpBeforeCmdExecute then
    case TFDPhysODBCCommand(ACommandObj).GetCommandKind of
    skCommit:   DisconnectCommandsBeforeCommit;
    skRollback: DisconnectCommandsBeforeRollback;
    end;
  inherited InternalNotify(ANotification, ACommandObj);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysODBCCommand                                                            }
{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetConnection: TFDPhysODBCConnectionBase;
begin
  Result := TFDPhysODBCConnectionBase(FConnectionObj);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetCliObj: Pointer;
begin
  Result := ODBCStatement;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.FD2SQLDataType(AFDType: TFDDataType; AFixedLen: Boolean;
  var AColSize, AScale: SQLInteger): SQLSmallint;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  ODBCConnection.CreateMetadata(oConnMeta);
  case AFDType of
  dtAnsiString:
    if AFixedLen then
      Result := SQL_CHAR
    else
      Result := SQL_VARCHAR;
  dtWideString:
    if AFixedLen then
      Result := SQL_WCHAR
    else
      Result := SQL_WVARCHAR;
  dtByteString:
    if AFixedLen then
      Result := SQL_BINARY
    else
      Result := SQL_VARBINARY;
  dtXML:
    case ODBCConnection.DriverKind of
    dkDB2,
    dkDB2_400:
      Result := SQL_XML;
    dkSQLNC,
    dkSQLOdbc,
    dkFreeTDS,
    dkSQLSrvOther:
      Result := SQL_SS_XML;
    dkTeradata:
      Result := SQL_TD_XML;
    else
      Result := SQL_UNKNOWN_TYPE;
    end;
  dtTime:
    if (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and
       (oConnMeta.ClientVersion >= svMSSQL2008) then begin
      Result := SQL_SS_TIME2;
      AColSize := 16;
      AScale := 7;
    end
    else
      Result := SQL_TYPE_TIME;
  dtHBFile:
    if (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and
       (oConnMeta.ClientVersion >= svMSSQL2008) then begin
      Result := SQL_WVARCHAR;
      AColSize := MaxInt;
    end
    else
      Result := SQL_LONGVARBINARY;
  dtRowSetRef:
    if (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and
       (oConnMeta.ClientVersion >= svMSSQL2008) then
      Result := SQL_SS_TABLE
    else
      Result := SQL_UNKNOWN_TYPE;
  else
    Result := C_FD_Type2SQLDataType[AFDType];
  end;
  if (soMoney in ODBCConnection.FSupportedOptions) and
     (Result <> SQL_UNKNOWN_TYPE) and (AFDType = dtCurrency) then begin
    // dtCurrency is strictly mapped to NUMBER(19,4)
    AColSize := 19;
    AScale := 4;
  end;
  case ODBCConnection.DriverKind of
  dkMSAccessJet,
  dkMSAccessACE:
    if Result = SQL_DECIMAL then
      Result := SQL_NUMERIC
    else if Result = SQL_BIGINT then
      Result := SQL_NUMERIC
    else if Result = SQL_BIT then
      Result := SQL_SMALLINT;
  dkDB2,
  dkDB2_400:
    if Result = SQL_BIT then
      Result := SQL_DECIMAL;
  dkOracleOra,
  dkOracleMS,
  dkOracleOther:
    // Oracle ODBC does not support Int64
    if Result = SQL_BIGINT then
      Result := SQL_INTEGER;
  dkSQLNC,
  dkSQLOdbc,
  dkFreeTDS,
  dkSQLSrvOther:
    // SQL Server 2005 ODBC not well supports SQL_LONGxxx data types.
    // Use VARxxx(MAX) instead.
    if (AColSize = 0) and (oConnMeta.ClientVersion >= svMSSQL2005) then
      case Result of
      SQL_LONGVARBINARY:
        begin
          Result := SQL_VARBINARY;
          AColSize := MaxInt;
        end;
      SQL_LONGVARCHAR:
        begin
          Result := SQL_VARCHAR;
          AColSize := MaxInt;
        end;
      SQL_WLONGVARCHAR:
        begin
          Result := SQL_WVARCHAR;
          AColSize := MaxInt;
        end;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.FD2CDataType(AFDType: TFDDataType; ANestedColumn: Boolean): SQLSmallint;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  ODBCConnection.CreateMetadata(oConnMeta);

  if AFDType = dtRowSetRef then
    if (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and
       (oConnMeta.ClientVersion >= svMSSQL2008) then
      Result := SQL_C_DEFAULT
    else
      Result := SQL_TYPE_NULL
  else
    Result := C_FD_Type2CDataType[AFDType];

  if ODBCConnection.ODBCConnection.DriverODBCVersion < ovODBC3 then
    case Result of
    SQL_C_TYPE_TIMESTAMP: Result := SQL_C_TIMESTAMP;
    SQL_C_TYPE_TIME:      Result := SQL_C_TIME;
    SQL_C_TYPE_DATE:      Result := SQL_C_DATE;
    SQL_C_NUMERIC:        Result := SQL_C_CHAR;
    end

  else if Result = SQL_C_NUMERIC then
    if ODBCConnection.GetNumType = dtAnsiString then
      Result := SQL_C_CHAR
    else
      case ODBCConnection.DriverKind of
      dkSQLNC,
      dkSQLOdbc,
      dkSQLSrvOther:
        // TVP columns have more strong req to SQL_C_NUMERIC
        if ANestedColumn then
          Result := SQL_C_CHAR;
      dkFreeTDS:
        // FreeTDS fails to transfer numerics with scale > 0
        Result := SQL_C_CHAR;
      dkDB2,
      dkDB2_400:
        // Use the character binding for the numerics in DB2, instead of the
        // binary binding, which:
        // - may return a garbage if CursorKind = ckDefault
        // - is about 20% slower than the character binding
        Result := SQL_C_CHAR;
      dkAdvantage:
        // ADS does not support SQL_C_NUMERIC, so it will always return NULL
        Result := SQL_C_CHAR;
      dkSQLAnywhere:
        if (ODBCConnection.ODBCConnection.DriverVersion >= cvSybaseASA8) and
           (ODBCConnection.ODBCConnection.DriverVersion < cvSybaseASA9) then
          Result := SQL_C_CHAR;
      dkInformix:
        // Informix fails to transfer several values
        Result := SQL_C_CHAR;
      dkPWMicroFocus,
      dkSybaseASE,
      dkCache,
      dkPervasive:
        // Following drivers have issues with SQL_C_NUMERIC, so map to char:
        // * Parkway Connectware Micro Focus
        // * Sybase ASE ODBC
        // * Intersystems Cache
        // * Pervasive SQL
        Result := SQL_C_CHAR;
      end

  else if Result = SQL_C_TYPE_TIME then
    if (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc, dkFreeTDS, dkSQLSrvOther]) and
       (oConnMeta.ClientVersion >= svMSSQL2008) then
      Result := SQL_C_BINARY;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SQL2FDColInfo(ASQLDataType: SQLSmallint;
  AUnsigned: Boolean; const ASQLTypeName: String; var ASQLSize: SQLInteger;
  ASQLDecimals: SQLInteger; var AType: TFDDataType; var AAttrs: TFDDataAttributes;
  var ALen: LongWord; var APrec, AScale: Integer);
var
  oConnMeta: IFDPhysConnectionMetadata;
  oFmt: TFDFormatOptions;
begin
  AType := dtUnknown;
  ALen := 0;
  APrec := 0;
  AScale := 0;
  Exclude(AAttrs, caFixedLen);
  Exclude(AAttrs, caBlobData);
  Include(AAttrs, caSearchable);
  FConnection.CreateMetadata(oConnMeta);
  case ASQLDataType of
  SQL_TINYINT:
    if AUnsigned or
       (oConnMeta.Kind in [TFDRDBMSKinds.SQLAnywhere, TFDRDBMSKinds.MSSQL]) and
       (CompareText(ASQLTypeName, 'TINYINT') = 0) then
      AType := dtByte
    else
      AType := dtSByte;
  SQL_SMALLINT:
    if AUnsigned then
      AType := dtUInt16
    else
      AType := dtInt16;
  SQL_INTEGER:
    if AUnsigned then
      AType := dtUInt32
    else
      AType := dtInt32;
  SQL_BIGINT,
  SQL_INFX_UDT_BIGINT:
    if AUnsigned then
      AType := dtUInt64
    else
      AType := dtInt64;
  SQL_NUMERIC,
  SQL_DECIMAL:
    begin
      APrec := ASQLSize;
      AScale := ASQLDecimals;
      oFmt := FOptions.FormatOptions;
      if (soMoney in ODBCConnection.FSupportedOptions) and
         ((ASQLSize = 19) or (ASQLSize = 10)) and (ASQLDecimals = 4) then
        AType := dtCurrency
      else if (ASQLSize <= oFmt.MaxBcdPrecision) and (ASQLDecimals <= oFmt.MaxBcdScale) then
        AType := dtBCD
      else
        AType := dtFmtBCD;
    end;
  SQL_DOUBLE,
  SQL_FLOAT,
  SQL_REAL:
    begin
      if ASQLSize = 53 then
        APrec := 16
      else if ASQLSize = 24 then
        APrec := 8
      else
        APrec := ASQLSize;
      ASQLSize := APrec;
      if (APrec = 0) or (APrec > 8) then
        AType := dtDouble
      else
        AType := dtSingle;
    end;
  SQL_GUID:
    AType := dtGUID;
  SQL_CHAR,
  SQL_VARCHAR:
    begin
      AType := dtAnsiString;
      ALen := ASQLSize;
      if ASQLDataType = SQL_CHAR then
        Include(AAttrs, caFixedLen);
      if ASQLSize = MAXINT then begin
        Include(AAttrs, caBlobData);
        Exclude(AAttrs, caSearchable);
      end;
    end;
  SQL_WCHAR,
  SQL_WVARCHAR,
  SQL_GRAPHIC,
  SQL_VARGRAPHIC,
  SQL_LONGVARGRAPHIC:
    begin
      AType := dtWideString;
      ALen := ASQLSize;
      if (ASQLDataType = SQL_WCHAR) or (ASQLDataType = SQL_GRAPHIC) then
        Include(AAttrs, caFixedLen);
      if ASQLSize = MAXINT then begin
        Include(AAttrs, caBlobData);
        Exclude(AAttrs, caSearchable);
      end;
    end;
  SQL_SS_VARIANT:
    if ODBCConnection.ODBCConnection.MSSQLVariantBinary then begin
      AType := dtByteString;
      ALen := ASQLSize;
    end
    else begin
      AType := dtWideString;
      ALen := 8000;
      Include(AAttrs, caBlobData);
    end;
  SQL_BINARY,
  SQL_VARBINARY:
    begin
      AType := dtByteString;
      ALen := ASQLSize;
      if ASQLDataType = SQL_BINARY then begin
        // In ASA BINARY is equivalent of VARBINARY
        if oConnMeta.Kind <> TFDRDBMSKinds.SQLAnywhere then
          Include(AAttrs, caFixedLen);
      end;
      if ASQLSize = MAXINT then begin
        Include(AAttrs, caBlobData);
        Exclude(AAttrs, caSearchable);
      end;
    end;
  SQL_TYPE_DATE:
    AType := dtDate;
  SQL_TYPE_TIME,
  SQL_TIME,
  SQL_SS_TIME2:
    begin
      AType := dtTime;
      if (ASQLDecimals >= 0) and (ASQLDecimals < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLDecimals];
    end;
  SQL_DATETIME:
    begin
      AType := dtDateTime;
      if (ASQLDecimals >= 0) and (ASQLDecimals < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLDecimals];
    end;
  SQL_TYPE_TIMESTAMP,
  SQL_TIMESTAMP,
  SQL_SS_TIMESTAMPOFFSET:
    begin
      AType := dtDateTimeStamp;
      if oConnMeta.Kind = TFDRDBMSKinds.MSSQL then begin
        if ASQLDecimals = 3 then
          AScale := 3
        else if ASQLDecimals = 0 then
          AScale := 60000;
      end
      else if (ASQLDecimals >= 0) and (ASQLDecimals < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLDecimals];
    end;
  SQL_BIT:
    AType := dtBoolean;
  SQL_CLOB,
  SQL_LONGVARCHAR,
  SQL_INFX_UDT_CLOB,
  SQL_TD_JSON:
    begin
      AType := dtMemo;
      Include(AAttrs, caBlobData);
      Exclude(AAttrs, caSearchable);
    end;
  SQL_WLONGVARCHAR,
  SQL_DBCLOB,
  SQL_TD_WJSON:
    begin
      AType := dtWideMemo;
      ALen := ASQLSize;
      Include(AAttrs, caBlobData);
      Exclude(AAttrs, caSearchable);
    end;
  SQL_XML,
  SQL_SS_XML,
  SQL_TD_XML:
    begin
      AType := dtXML;
      ALen := ASQLSize;
      Include(AAttrs, caBlobData);
      Exclude(AAttrs, caSearchable);
    end;
  SQL_BLOB,
  SQL_LONGVARBINARY,
  SQL_INFX_UDT_BLOB,
  SQL_SS_UDT:
    begin
      AType := dtBlob;
      ALen := ASQLSize;
      Include(AAttrs, caBlobData);
      Exclude(AAttrs, caSearchable);
    end;
  SQL_INTERVAL_YEAR,
  SQL_INTERVAL_MONTH,
  SQL_INTERVAL_YEAR_TO_MONTH:
    begin
      AType := dtTimeIntervalYM;
      APrec := ASQLSize;
    end;
  SQL_INTERVAL_DAY,
  SQL_INTERVAL_HOUR,
  SQL_INTERVAL_MINUTE,
  SQL_INTERVAL_DAY_TO_HOUR,
  SQL_INTERVAL_DAY_TO_MINUTE,
  SQL_INTERVAL_HOUR_TO_MINUTE:
    begin
      AType := dtTimeIntervalDS;
      APrec := ASQLSize;
    end;
  SQL_INTERVAL_SECOND,
  SQL_INTERVAL_DAY_TO_SECOND,
  SQL_INTERVAL_HOUR_TO_SECOND,
  SQL_INTERVAL_MINUTE_TO_SECOND:
    begin
      AType := dtTimeIntervalDS;
      if (ASQLDecimals >= 0) and (ASQLDecimals < 3) then
        AScale := C_FD_ScaleFactor[3 - ASQLDecimals];
      APrec := ASQLSize;
    end;
  SQL_REFCURSOR:
    AType := dtCursorRef;
  SQL_SS_TABLE:
    begin
      AType := dtRowSetRef;
      Exclude(AAttrs, caSearchable);
      Include(AAttrs, caReadOnly);
    end;
  else
{$IFDEF POSIX}
    // Linux / MacOS / Android drivers do not support all types
    // supported by Windows drivers. Eg, SQL_VARIANT.
    AType := dtByteString;
{$ELSE}
    AType := dtUnknown;
{$ENDIF}
  end;
  if (oConnMeta.Kind = TFDRDBMSKinds.MSAccess) and (CompareText(ASQLTypeName, 'COUNTER') = 0) or
     (oConnMeta.Kind = TFDRDBMSKinds.Advantage) and (CompareText(ASQLTypeName, 'AUTOINC') = 0) then begin
    Include(AAttrs, caAutoInc);
    Include(AAttrs, caReadOnly);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.FD2SQLParamType(AParamType: TParamType): SQLSmallint;
begin
  Result := C_FD_ParType2SQLParType[AParamType];
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.CheckFetchColumn(ADataType: TFDDataType;
  AAttributes: TFDDataAttributes; ASQLDataType: Smallint): Boolean;
begin
  Result := inherited CheckFetchColumn(ADataType, AAttributes);
  if Result and (ASQLDataType = SQL_SS_VARIANT) and
     ODBCConnection.ODBCConnection.MSSQLVariantBinary then
    Result := fiBlobs in FOptions.FetchOptions.Items;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.CreateDescribeInfos;
var
  oFmtOpts: TFDFormatOptions;
  i, iNumCols: SQLSmallint;
  oSelItem: TODBCSelectItem;
  iLen: LongWord;
  iPrec, iScale: Integer;
  oConnMeta: IFDPhysConnectionMetadata;
  iInitBuffSize: SQLUInteger;
  lMetadata, lInfxBigSer: Boolean;
  eStrsType: TFDDataType;
  rName: TFDPhysParsedName;
  pInfo: PFDODBCColInfoRec;
  oVar: TODBCVariable;
begin
  ODBCConnection.CreateMetadata(oConnMeta);
  oFmtOpts := FOptions.FormatOptions;
  Exclude(FStatementProps, cpLateBindedData);
  iNumCols := FStatement.NumResultCols;
  if (GetMetaInfoKind = mkProcArgs) and
     not (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc]) and (iNumCols > 13) then
    iNumCols := 13;
  iInitBuffSize := 0;
  lMetadata := GetMetaInfoKind <> FireDAC.Phys.Intf.mkNone;
  eStrsType := ODBCConnection.GetStrsType;

  SetLength(FColInfos, iNumCols);
  for i := 1 to iNumCols do begin
    oSelItem := TODBCSelectItem.Create(FStatement, i);
    pInfo := @FColInfos[i - 1];
    try
      pInfo^.FName := oSelItem.Name;

      if ODBCConnection.ODBCConnection.DriverODBCVersion >= ovODBC3 then begin
        pInfo^.FOriginTabName := oSelItem.BASE_TABLE_NAME;
        pInfo^.FOriginColName := oSelItem.BASE_COLUMN_NAME;
        if (pInfo^.FOriginTabName = '') or (pInfo^.FOriginColName = '') then begin
          pInfo^.FOriginTabName := '';
          pInfo^.FOriginColName := '';
        end
        else begin
          pInfo^.FOriginCatalogName := oSelItem.BASE_CATALOG_NAME;
          pInfo^.FOriginSchemaName := oSelItem.BASE_SCHEMA_NAME;
        end;
      end;

      pInfo^.FPos := oSelItem.Position;
      pInfo^.FSrcSQLDataType := oSelItem.SQLDataType;
      pInfo^.FColSize := oSelItem.ColumnSize;
      pInfo^.FScale := oSelItem.Scale;

      if lMetaData then
        // Some ODBC drivers return the textual metadata columns as
        // SQL_CHAR / SQL_WCHAR, but FireDAC expects a varlen string
        case pInfo^.FSrcSQLDataType of
        SQL_CHAR:  pInfo^.FSrcSQLDataType := SQL_VARCHAR;
        SQL_WCHAR: pInfo^.FSrcSQLDataType := SQL_WVARCHAR;
        end
      else if eStrsType <> dtUnknown then
        if eStrsType = dtWideString then
          case pInfo^.FSrcSQLDataType of
          SQL_CHAR:        pInfo^.FSrcSQLDataType := SQL_WCHAR;
          SQL_VARCHAR:     pInfo^.FSrcSQLDataType := SQL_WVARCHAR;
          SQL_LONGVARCHAR: pInfo^.FSrcSQLDataType := SQL_WLONGVARCHAR;
          end
        else if eStrsType = dtAnsiString then
          case pInfo^.FSrcSQLDataType of
          SQL_WCHAR,
          SQL_GRAPHIC:        pInfo^.FSrcSQLDataType := SQL_CHAR;
          SQL_WVARCHAR,
          SQL_VARGRAPHIC:     pInfo^.FSrcSQLDataType := SQL_VARCHAR;
          SQL_WLONGVARCHAR,
          SQL_LONGVARGRAPHIC: pInfo^.FSrcSQLDataType := SQL_LONGVARCHAR;
          end;

      if ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc] then
        if (pInfo^.FSrcSQLDataType = SQL_SS_XML) and (oSelItem.XML_SCHEMACOLLECTION_NAME <> '') then begin
          rName.FCatalog := oSelItem.XML_SCHEMACOLLECTION_CATALOG_NAME;
          rName.FSchema := oSelItem.XML_SCHEMACOLLECTION_SCHEMA_NAME;
          rName.FObject := oSelItem.XML_SCHEMACOLLECTION_NAME;
          pInfo^.FExtName := oConnMeta.EncodeObjName(rName, Self, [eoNormalize]);
        end
        else if (pInfo^.FSrcSQLDataType = SQL_SS_UDT) and (oSelItem.UDT_TYPE_NAME <> '') then begin
          rName.FCatalog := oSelItem.UDT_CATALOG_NAME;
          rName.FSchema := oSelItem.UDT_SCHEMA_NAME;
          rName.FObject := oSelItem.UDT_TYPE_NAME;
          pInfo^.FExtName := oConnMeta.EncodeObjName(rName, Self, [eoNormalize]);
                                                                      
        end
        else
          pInfo^.FExtName := oSelItem.TYPE_NAME
      else if not (lMetadata and (ODBCConnection.DriverKind = dkDB2_400)) then
        pInfo^.FExtName := oSelItem.TYPE_NAME;

      if oSelItem.NULLABLE = SQL_NULLABLE then
        Include(pInfo^.FAttrs, caAllowNull);
      if oSelItem.AUTO_UNIQUE_VALUE = SQL_TRUE then begin
        Include(pInfo^.FAttrs, caAutoInc);
        Include(pInfo^.FAttrs, caAllowNull);
      end;
      // Informix ODBC driver returns improper UPDATABLE and UNSIGNED
      // attributes for BIGSERIAL column
      lInfxBigSer := (ODBCConnection.DriverKind = dkInformix) and
        (oSelItem.SQLDataType = SQL_INFX_UDT_BIGINT) and (caAutoInc in pInfo^.FAttrs);
      if (oSelItem.UPDATABLE = SQL_ATTR_READONLY) or lInfxBigSer then
        Include(pInfo^.FAttrs, caReadOnly);
      if oSelItem.IsFixedLen then
        Include(pInfo^.FAttrs, caFixedLen);
      if oSelItem.SEARCHABLE <> SQL_PRED_NONE then
        Include(pInfo^.FAttrs, caSearchable);
      if oSelItem.ROWVER = SQL_TRUE then
        Include(pInfo^.FAttrs, caRowVersion);
      if CompareText(pInfo^.FName, 'rowid') = 0 then begin
        Include(pInfo^.FAttrs, caROWID);
        Include(pInfo^.FAttrs, caReadOnly);
      end;
      pInfo^.FInKey := False;

      SQL2FDColInfo(pInfo^.FSrcSQLDataType, (oSelItem.UNSIGNED = SQL_TRUE) or lInfxBigSer, '',
        pInfo^.FColSize, pInfo^.FScale, pInfo^.FSrcDataType, pInfo^.FAttrs, iLen, iPrec, iScale);

      if lMetaData then
        // Some ODBC drivers return the textual metadata columns as
        // SQL_VARCHAR, but FireDAC expects an Unicode strings
        if pInfo^.FSrcDataType = dtAnsiString then
          pInfo^.FDestDataType := dtWideString
        else
          pInfo^.FDestDataType := pInfo^.FSrcDataType
      else
        // mapping data types
        oFmtOpts.ResolveDataType(pInfo^.FName, pInfo^.FExtName, pInfo^.FSrcDataType,
          iLen, iPrec, iScale, pInfo^.FDestDataType, iLen, True);

      pInfo^.FOutSQLDataType := FD2SQLDataType(pInfo^.FDestDataType, caFixedLen in pInfo^.FAttrs,
        pInfo^.FColSize, pInfo^.FScale);
      if pInfo^.FOutSQLDataType <> SQL_UNKNOWN_TYPE then begin
        SQL2FDColInfo(pInfo^.FOutSQLDataType, False, '', pInfo^.FColSize, pInfo^.FScale,
          pInfo^.FOutDataType, pInfo^.FAttrs, iLen, iPrec, iScale);
        if pInfo^.FDestDataType = pInfo^.FSrcDataType then
          pInfo^.FOutSQLDataType := pInfo^.FSrcSQLDataType;
      end
      else begin
        SQL2FDColInfo(pInfo^.FSrcSQLDataType, False, '', pInfo^.FColSize, pInfo^.FScale,
          pInfo^.FOutDataType, pInfo^.FAttrs, iLen, iPrec, iScale);
        pInfo^.FOutSQLDataType := pInfo^.FSrcSQLDataType;
      end;
      pInfo^.FFDLen := iLen;
      pInfo^.FFDScale := iScale;

      if (pInfo^.FSrcDataType = dtBCD) and (pInfo^.FOutDataType = dtFmtBCD) then
        pInfo^.FOutDataType := dtBCD
      else if (pInfo^.FDestDataType in [dtSingle, dtDouble]) and
              (pInfo^.FOutDataType in [dtSingle, dtDouble]) then
        pInfo^.FOutDataType := pInfo^.FDestDataType;

      if CheckFetchColumn(pInfo^.FSrcDataType, pInfo^.FAttrs, pInfo^.FSrcSQLDataType) then begin
        pInfo^.FVar := FStatement.ColumnList.Add(TODBCColumn.Create);
        oVar := pInfo^.FVar;
        oVar.Position := pInfo^.FPos;
        oVar.ColumnSize := pInfo^.FColSize;
        oVar.Scale := pInfo^.FScale;
        oVar.SQLDataType := pInfo^.FOutSQLDataType;
        oVar.CDataType := FD2CDataType(pInfo^.FOutDataType, False);
        oVar.UpdateFlags;
        if oVar.LateBinding then
          Include(FStatementProps, cpLateBindedData)
        // 1) MSSQL fails to fetch result set, if a BLOB column is in the middle
        //    of a SELECT list and columns after BLOB are not late binded.
        // 2) ASA fails with "invalid cursor position" to fetch late binded
        //    columns, if they are non BLOB columns.
        else if ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc,
                                              dkFreeTDS, dkSQLSrvOther] then
          oVar.ForceLateBinding := cpLateBindedData in FStatementProps;
        if (pInfo^.FOutDataType = pInfo^.FDestDataType) and
           (lMetadata or not (pInfo^.FDestDataType in C_FD_VarLenTypes)) then
          if (iInitBuffSize < oVar.DataSize) and (oVar.DataSize <> MAXINT) then
            iInitBuffSize := oVar.DataSize;
      end
      else
        pInfo^.FVar := nil;

    finally
      FDFree(oSelItem);
    end;
  end;

  FBuffer.Check(iInitBuffSize);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.DestroyDescribeInfos;
begin
  if Length(FColInfos) = 0 then
    Exit;
  SetLength(FColInfos, 0);
  if FStatement <> nil then
    FStatement.UnbindColumns;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.CreateParamColumns(AParam: TFDParam);
begin
  FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.CreateParamColumnInfos(ApInfo: PFDODBCParInfoRec;
  AParam: TFDParam);
begin
  FDCapabilityNotSupported(Self, [S_FD_LPhys, DriverID]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.CreateParamInfos;
var
  n, i: SQLSmallInt;
  oParam: TFDParam;
  oParams: TFDParams;
  eDestFldType: TFieldType;
  iPrec, iScale: Integer;
  iLen: LongWord;
  eAttrs: TFDDataAttributes;
  oFmtOpts: TFDFormatOptions;
  oConnMeta: IFDPhysConnectionMetadata;
  lFixedLen: Boolean;
  pInfo: PFDODBCParInfoRec;
  oVar: TODBCParameter;
  rName: TFDPhysParsedName;
  iDestSize: LongWord;
begin
  oParams := GetParams;
  if (oParams.Count = 0) or (FCommandStatement = nil) then
    Exit;

  oFmtOpts := FOptions.FormatOptions;
  ODBCConnection.CreateMetadata(oConnMeta);
  n := oParams.Markers.Count;
  SetLength(FParInfos, n);

  for i := 0 to n - 1 do begin
    pInfo := @FParInfos[i];
    case GetParams.BindMode of
    pbByName:
      begin
        oParam := oParams.FindParam(oParams.Markers[i]);
        if oParam <> nil then begin
          pInfo^.FName := oParam.Name;
          if (cpUnifyParams in FStatementProps) and
             (pInfo^.FName <> '') and (pInfo^.FName[1] <> '@') then
            pInfo^.FName := '@' + pInfo^.FName;
          if Length(pInfo^.FName) > oConnMeta.ParamNameMaxLength then
            pInfo^.FName := Copy(pInfo^.FName, 1, oConnMeta.ParamNameMaxLength -
              1 - Length(IntToStr(i + 1))) + '_' + IntToStr(i + 1);
        end;
      end;
    pbByNumber:
      begin
        oParam := oParams.FindParam(i + 1);
        pInfo^.FName := '';
      end;
    else
      oParam := nil;
    end;
    if oParam = nil then begin
      pInfo^.FPos := -1;
      pInfo^.FParamIndex := -1;
      Continue;
    end;
    pInfo^.FPos := i;
    pInfo^.FParamIndex := oParam.Index;

    case oParam.ParamType of
    ptOutput,
    ptInputOutput:
      begin
        Include(FStatementProps, cpOutParams);
        Include(FStatementProps, cpOutResParams);
      end;
    ptResult:
      Include(FStatementProps, cpOutResParams);
    end;
    pInfo^.FParamType := oParam.ParamType;

    pInfo^.FDataType := oParam.DataType;
    if oParam.DataType = ftUnknown then
      ParTypeUnknownError(oParam);
    oFmtOpts.ResolveFieldType('', oParam.DataTypeName, oParam.DataType, oParam.FDDataType,
      oParam.Size, oParam.Precision, oParam.NumericScale, eDestFldType, iDestSize,
      pInfo^.FColSize, pInfo^.FScale, pInfo^.FSrcDataType, pInfo^.FDestDataType, False);
    if iDestSize > 0 then
      pInfo^.FColSize := iDestSize;

    // ASA: cannot correctly return blob out parameters, so map them to
    // appropriate types
    if (ODBCConnection.DriverKind = dkSQLAnywhere) and
       (oParam.ParamType in [ptOutput, ptInputOutput]) then
      case pInfo^.FDestDataType of
      dtBlob:     pInfo^.FDestDataType := dtByteString;
      dtMemo:     pInfo^.FDestDataType := dtAnsiString;
      dtWideMemo: pInfo^.FDestDataType := dtWideString;
      end;

    lFixedLen := pInfo^.FDataType in [ftFixedChar, ftBytes, ftFixedWideChar];
    pInfo^.FSrcSQLDataType := FD2SQLDataType(pInfo^.FSrcDataType, lFixedLen,
      iPrec, iScale);
    pInfo^.FOutSQLDataType := FD2SQLDataType(pInfo^.FDestDataType, lFixedLen,
      pInfo^.FColSize, pInfo^.FScale);
    if pInfo^.FOutSQLDataType = SQL_UNKNOWN_TYPE then
      ParTypeMapError(oParam);

    eAttrs := [];
    SQL2FDColInfo(pInfo^.FOutSQLDataType, False, '', pInfo^.FColSize, pInfo^.FScale,
      pInfo^.FOutDataType, eAttrs, iLen, iPrec, iScale);

    if (pInfo^.FDestDataType = dtBCD) and (pInfo^.FOutDataType = dtFmtBCD) then
      pInfo^.FOutDataType := dtBCD;

    if (pInfo^.FOutDataType = dtRowSetRef) and (oParam.AsDataSet = nil) and
       (oParam.DataTypeName <> '') and (fiMeta in FOptions.FetchOptions.Items) then
      CreateParamColumns(oParam);

    pInfo^.FVar := FCommandStatement.ParamList.Add(TODBCParameter.Create);
    oVar := TODBCParameter(pInfo^.FVar);
    oVar.ParamType := FD2SQLParamType(pInfo^.FParamType);
    oVar.Position := SQLSmallint(pInfo^.FPos + 1);
    oVar.Name := pInfo^.FName;
    oVar.ColumnSize := pInfo^.FColSize;
    oVar.Scale := pInfo^.FScale;
    oVar.SQLDataType := pInfo^.FOutSQLDataType;
    oVar.CDataType := FD2CDataType(pInfo^.FOutDataType, False);
    oVar.ForceLongData := oParam.IsObject;
    oVar.MSAccBoolean := (oConnMeta.Kind = TFDRDBMSKinds.MSAccess) and (pInfo^.FDestDataType = dtBoolean);
    if (oConnMeta.Kind = TFDRDBMSKinds.MSSQL) and (oVar.SQLDataType = SQL_SS_TABLE) then begin
      // MSSQL: TVP does not support catalog and schema in type name
      oConnMeta.DecodeObjName(oParam.DataTypeName, rName, nil, []);
      oVar.DataTypeName := rName.FObject;
    end
    else
      oVar.DataTypeName := oParam.DataTypeName;
    oVar.UpdateFlags;

    if (pInfo^.FOutDataType = dtRowSetRef) and (oParam.AsDataSet <> nil) then
      CreateParamColumnInfos(pInfo, oParam);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.DestroyParamInfos;
begin
  if (GetMetaInfoKind <> mkNone) or (Length(FParInfos) = 0) then
    Exit;
  SetLength(FParInfos, 0);
  if FCommandStatement <> nil then
    FCommandStatement.UnbindParameters;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SetupStatementBeforePrepare(AStmt: TODBCStatementBase);
var
  oFmtOpts: TFDFormatOptions;
  oFtchOpts: TFDFetchOptions;
  oResOpts: TFDResourceOptions;
  oConnMeta: IFDPhysConnectionMetadata;
  lUseRowSet: Boolean;
  oStmt: TODBCCommandStatement;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Trace(ekCmdPrepare, esProgress, 'MSSQL automatic cursor',
      ['ServerVersion', oConnMeta.ServerVersion, 'Mode', Integer(oFtchOpts.Mode),
       'GetMetainfoKind', Integer(GetMetainfoKind), 'UseExecDirect', UseExecDirect]);
  end;
{$ENDIF}  

begin
  oFmtOpts := FOptions.FormatOptions;
  oFtchOpts := FOptions.FetchOptions;
  oResOpts := FOptions.ResourceOptions;
  ODBCConnection.CreateMetadata(oConnMeta);
  lUseRowSet := soRowSet in ODBCConnection.FSupportedOptions;
  FStatementProps := [];

  if ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc] then
    Include(FStatementProps, cpResetOnArrayOffset);

  if oResOpts.UnifyParams and
     ((oConnMeta.Kind in [TFDRDBMSKinds.MSSQL, TFDRDBMSKinds.SQLAnywhere]) or
      (ODBCConnection.DriverKind = dkSybaseASE)) and
     ((GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs]) or
      (GetMetaInfoKind in [mkProcs, mkProcArgs])) then
    Include(FStatementProps, cpUnifyParams);

  if fiBlobs in oFtchOpts.Items then
    Include(FStatementProps, cpLateBindedData);
  AStmt.PieceBuffLen := C_FD_DefPieceBuffLen;
  AStmt.MaxStringSize := oFmtOpts.MaxStringSize;
  AStmt.StrsTrim := oFmtOpts.StrsTrim;
  AStmt.StrsEmpty2Null := oFmtOpts.StrsEmpty2Null;
  AStmt.MoneySupported := soMoney in ODBCConnection.FSupportedOptions;

  if (AStmt is TODBCCommandStatement) and (GetParams.Count > 0) then begin
    oStmt := TODBCCommandStatement(AStmt);
    if (ODBCConnection.DriverKind = dkDB2) and
       (GetCommandKind in [skDelete, skInsert, skMerge, skUpdate]) then
      oStmt.PARAMOPT_ATOMIC := SQL_ATOMIC_NO;
    if soParamSet in ODBCConnection.FSupportedOptions then begin
      if GetParams.ArraySize > 1 then
        oStmt.PARAMSET_SIZE := GetParams.ArraySize;
      Include(FStatementProps, cpParamSet);
      oStmt.ParamSetSupported := True;
    end;
  end;

  case TFDCursorKind(oFtchOpts.CursorKind) of
  ckDynamic:
    AStmt.CURSOR_TYPE := SQL_CURSOR_DYNAMIC;
  ckStatic:
    AStmt.CURSOR_TYPE := SQL_CURSOR_STATIC;
  ckForwardOnly:
    if ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc] then
      AStmt.SS_CURSOR_OPTIONS := SQL_CO_FFO
    else
      AStmt.CURSOR_TYPE := SQL_CURSOR_FORWARD_ONLY;
  ckDefault:
    if ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc] then begin
      AStmt.SS_CURSOR_OPTIONS := SQL_CO_DEFAULT;
      Include(FStatementProps, cpDefaultCrs);
    end;
  ckAutomatic:
    case ODBCConnection.DriverKind of
    dkSQLSrv,
    dkSQLNC,
    dkSQLOdbc,
    dkFreeTDS,
    dkSQLSrvOther:
      begin
{$IFDEF FireDAC_MONITOR}
        if ODBCConnection.GetTracing then
          Trace1;
{$ENDIF}
        if (ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc]) and (
             (oConnMeta.ServerVersion >= svMSSQL2005) or
             (oFtchOpts.Mode in [fmExactRecsMax, fmAll]) or
             UseExecDirect
           ) then begin
          AStmt.SS_CURSOR_OPTIONS := SQL_CO_DEFAULT;
          Include(FStatementProps, cpDefaultCrs);
        end
        else
          AStmt.CURSOR_TYPE := SQL_CURSOR_STATIC;
      end;
    dkDB2,
    dkDB2_400,
    dkTeradata:
      AStmt.CURSOR_TYPE := SQL_CURSOR_FORWARD_ONLY;
    else
      // 1) In most cases (Sybase SQL Anywhere, MS Access, etc) dynamic cursor
      // gives the best performance on result sets with late binded columns
      if cpLateBindedData in FStatementProps then
        AStmt.CURSOR_TYPE := SQL_CURSOR_DYNAMIC;
    end;
  end;

  if not (cpDefaultCrs in FStatementProps) then begin
    if not (GetCommandKind in [skSelectForLock, skSelectForUnLock]) then
      AStmt.CONCURRENCY := SQL_CONCUR_READ_ONLY;

    // 2) If a cursor kind is set by FireDAC or reset by driver to the FORWARD_ONLY
    // value, and a result set has the late binded columns, then ODBC returns
    // "invalid cursor position" if rowset size > 1 (FD-224, Informix)
    if lUseRowSet and (AStmt.CURSOR_TYPE = SQL_CURSOR_FORWARD_ONLY) then
      lUseRowSet := not (cpLateBindedData in FStatementProps);

    if lUseRowSet then begin
      AStmt.ROW_ARRAY_SIZE := oFtchOpts.ActualRowsetSize;
      Include(FStatementProps, cpRowSet);
    end;
  end;

  if (oConnMeta.Kind in [TFDRDBMSKinds.MSSQL, TFDRDBMSKinds.DB2]) and
     not (GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs]) and
     (GetParams.Count = 0) and
     oResOpts.MacroExpand and oResOpts.EscapeExpand then
    AStmt.NOSCAN := SQL_NOSCAN_ON;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SetupStatementAfterDescribe(AStmt: TODBCStatementBase);
var
  lUseRowSet: Boolean;
  oFtchOpts: TFDFetchOptions;
begin
  if not (cpDefaultCrs in FStatementProps) and not (cpRowSet in FStatementProps) then begin
    oFtchOpts := FOptions.FetchOptions;
    lUseRowSet := soRowSet in ODBCConnection.FSupportedOptions;

    // See (2) at SetupStatementBeforePrepare
    if lUseRowSet and (AStmt.CURSOR_TYPE = SQL_CURSOR_FORWARD_ONLY) then
      lUseRowSet := not (cpLateBindedData in FStatementProps);

    if lUseRowSet then begin
      AStmt.ROW_ARRAY_SIZE := oFtchOpts.ActualRowsetSize;
      Include(FStatementProps, cpRowSet);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SetupStatementBeforeExecute(AStmt: TODBCStatementBase);
var
  oResOpts: TFDResourceOptions;
  iTimeout: LongWord;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  // At moment native ODBC timeout (SQL_ATTR_QUERY_TIMEOUT) is supported at all
  // or correctly supported only by SQL Server and Informix ODBC driver.
  FConnection.CreateMetadata(oConnMeta);
  if oConnMeta.AsyncNativeTimeout then begin
    oResOpts := FOptions.ResourceOptions;
    iTimeout := oResOpts.CmdExecTimeout;
    if (oResOpts.CmdExecMode = amBlocking) and (iTimeout <> $FFFFFFFF) then
      AStmt.QUERY_TIMEOUT := (iTimeout + 999) div 1000
    else
      AStmt.QUERY_TIMEOUT := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetRowsetSize(ARowsetSize: Integer): Integer;
begin
  if [cpRowSet, cpDefaultCrs] * FStatementProps = [cpRowSet] then
    Result := ARowsetSize
  else
    Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetParamsetSize(AParamsetSize: Integer): Integer;
begin
  if cpParamSet in FStatementProps then
    Result := AParamsetSize
  else
    Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.MatchParamsetSize(AParamsetSize1, AParamsetSize2: Integer): Boolean;
begin
  if cpParamSet in FStatementProps then
    Result := AParamsetSize1 = AParamsetSize2
  else
    Result := ((AParamsetSize1 = 0) or (AParamsetSize1 = 1)) and
              ((AParamsetSize2 = 0) or (AParamsetSize2 = 1));
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.UseExecDirect: Boolean;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  Result := FOptions.ResourceOptions.DirectExecute;
  ODBCConnection.CreateMetadata(oConnMeta);
  if not Result then begin
    case GetCommandKind of
    skSet,
    skSetSchema,
    skCreate,
    skDrop,
    skAlter,
    skOther:             Result := True;
    // No need to prepare stored procedures. That will create temporary SP
    // around SP.
    skStoredProc,
    skStoredProcNoCrs:   Result := True; // not (cpOutParams in FStatementProps);
    skStoredProcWithCrs: Result := not (cpLateBindedData in FStatementProps);
    // Force BATCH (instead of RPC) for non-parameterized SELECT, when user
    // need to get all result set.
    skSelect,
    skSelectForLock,
    skSelectForUnLock:   Result := (GetParams.Count = 0) and
                                   (FOptions.FetchOptions.Mode in [fmAll, fmExactRecsMax]) and
                                   (oConnMeta.Kind <> TFDRDBMSKinds.SQLAnywhere);
    // See TFDQACompSTPTsHolder.TestStoredProcMSSQL3 test. Looks like if EXEC
    // will be prepared, then it will fail for many system routines.
    skExecute:           Result := GetParams.Count = 0;
    end;
    if Result then
      Result := oConnMeta.Kind in [TFDRDBMSKinds.MSSQL, TFDRDBMSKinds.SQLAnywhere];
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.UseInformationSchema: Boolean;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  ODBCConnection.CreateMetadata(oConnMeta);
  Result := not (soFKFunction in ODBCConnection.FSupportedOptions) and
    (GetMetaInfoKind in [mkForeignKeys, mkForeignKeyFields]) and
    not (oConnMeta.Kind in [TFDRDBMSKinds.MSAccess, TFDRDBMSKinds.DB2, TFDRDBMSKinds.Informix]) or
    (GetMetaInfoKind = mkResultSetFields);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.UseStatement: Boolean;
begin
  Result := (GetMetaInfoKind = mkNone) or UseInformationSchema;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalPrepare;
var
  rName: TFDPhysParsedName;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  if GetMetaInfoKind <> FireDAC.Phys.Intf.mkNone then begin
    if GetCommandKind = skUnknown then
      SetCommandKind(skSelect);
    if not UseInformationSchema then begin
      FStatement := TODBCMetaInfoStatement.Create(ODBCConnection.ODBCConnection, Self);
      FMetainfoStatement := TODBCMetaInfoStatement(FStatement);
      SetupStatementBeforePrepare(FStatement);
      Exit;
    end
    else begin
      GetSelectMetaInfoParams(rName);
      GenerateSelectMetaInfo(rName);
    end;
  end
  else begin
    ODBCConnection.CreateMetadata(oConnMeta);

    // generate stored proc call SQL command
    if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
      oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, []);
      FDbCommandText := '';
      if fiMeta in FOptions.FetchOptions.Items then
        GenerateStoredProcParams(rName);
      if FDbCommandText = '' then
        GenerateStoredProcCall(rName);
    end
    else begin
      if GetCommandKind = skUnknown then
        SetCommandKind(skSelect);
    end;
  end;

  // adjust SQL command
  GenerateLimitSelect();
  GenerateParamMarkers();

  FStatement := TODBCCommandStatement.Create(ODBCConnection.ODBCConnection, Self);;
  FCommandStatement := TODBCCommandStatement(FStatement);
  SetupStatementBeforePrepare(FStatement);

  if not UseExecDirect then
    FCommandStatement.Prepare(FDbCommandText);
  if GetParams.Count > 0 then begin
    CreateParamInfos;
    FCommandStatement.BindParameters(GetParamsetSize(GetParams.ArraySize), True);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalUnprepare;
begin
  if FStatement = nil then
    Exit;
  CloseStatement(-1, True, True, False);
  DestroyParamInfos;
  DestroyDescribeInfos;
  FCommandStatement := nil;
  FMetainfoStatement := nil;
  FMetainfoAddonView := nil;
  FDFreeAndNil(FStatement);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean;
begin
  Result := OpenBlocked;
  if Result and (ATabInfo.FSourceID = -1) then begin
    ATabInfo.FSourceName := GetCommandText;
    ATabInfo.FSourceID := 1;
    FColumnIndex := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean;
var
  pColInfo: PFDODBCColInfoRec;
begin
  if FColumnIndex < Length(FColInfos) then begin
    pColInfo := @FColInfos[FColumnIndex];
    AColInfo.FSourceName := pColInfo^.FName;
    AColInfo.FSourceID := FColumnIndex + 1;
    AColInfo.FSourceTypeName := pColInfo^.FExtName;
    AColInfo.FSourceType := pColInfo^.FSrcDataType;
    AColInfo.FOriginTabName.FCatalog := pColInfo^.FOriginCatalogName;
    AColInfo.FOriginTabName.FSchema := pColInfo^.FOriginSchemaName;
    AColInfo.FOriginTabName.FObject := pColInfo^.FOriginTabName;
    AColInfo.FOriginColName := pColInfo^.FOriginColName;
    AColInfo.FType := pColInfo^.FDestDataType;
    AColInfo.FLen := pColInfo^.FFDLen;
    AColInfo.FPrec := pColInfo^.FColSize;
    AColInfo.FScale := pColInfo^.FFDScale;
    AColInfo.FAttrs := pColInfo^.FAttrs;
    AColInfo.FForceAddOpts := [];
    if caAutoInc in AColInfo.FAttrs then
      Include(AColInfo.FForceAddOpts, coAfterInsChanged);
    if pColInfo^.FInKey then
      Include(AColInfo.FForceAddOpts, coInKey);
    Inc(FColumnIndex);
    Result := True;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetIsCustomParam(ADataType: TFDDataType): Boolean;
begin
  Result := False;
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SetCustomParamValue(ADataType: TFDDataType;
  AVar: TODBCVariable; AParam: TFDParam; AVarIndex, AParIndex: Integer);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.SetParamValues(ATimes, AOffset: Integer;
  AFromParIndex: Integer);
var
  oParams: TFDParams;
  oFmtOpts: TFDFormatOptions;
  oParam: TFDParam;
  iArraySize, i, j: Integer;
  iMaxNumBefDot, iMaxNumScale: SQLSmallint;
  iMaxStrSize: SQLInteger;
  pParInfo: PFDODBCParInfoRec;
  lRebind: Boolean;
  oVar: TODBCVariable;

  procedure ProcessArrayItem(AParam: TFDParam; ApInfo: PFDODBCParInfoRec;
    AVarIndex, AParIndex: Integer);
  var
    pBuffer: PByte;
    iDataSize, iSrcSize: LongWord;
    iPrec, iScale: Smallint;
    oExtStr, oIntStr: TStream;
    lExtStream: Boolean;
    eStreamMode: TFDStreamMode;
  begin
    iDataSize := 0;
    iSrcSize := 0;
    pBuffer := nil;

    if GetIsCustomParam(ApInfo^.FSrcDataType) then
      SetCustomParamValue(ApInfo^.FSrcDataType, ApInfo^.FVar, AParam, AVarIndex, AParIndex)

    else if AParam.IsDatasets[AParIndex] then begin
      if (ATimes - AOffset <> 1) or
         (AParam.AsDataSets[AParIndex] = nil) or (ApInfo^.FOutDataType <> dtRowSetRef) then
        UnsupParamObjError(AParam);
      AParam.GetDataReader(@pBuffer, AParIndex);
      ApInfo^.FVar.SetDataReader(AVarIndex, @pBuffer);
    end

    else if AParam.IsStreams[AParIndex] then begin
      oExtStr := AParam.AsStreams[AParIndex];
      lExtStream := (oExtStr <> nil) and
        not ((oExtStr is TODBCLongDataStream) and (TODBCLongDataStream(oExtStr).Param.Statement.OwningObj = Self));
      if (ATimes - AOffset <> 1) or
         (AParam.DataType <> ftStream) and not lExtStream or
         not (ApInfo^.FOutDataType in C_FD_VarLenTypes) then
        UnsupParamObjError(AParam);
      case AParam.ParamType of
        ptUnknown,
        ptInput:   eStreamMode := smOpenWrite;
        ptOutput,
        ptResult:  eStreamMode := smOpenRead;
        else       eStreamMode := smOpenReadWrite; // ptInputOutput
      end;
      if not lExtStream then begin
        oIntStr := TODBCLongDataStream.Create(TODBCParameter(ApInfo^.FVar), eStreamMode);
        AParam.AsStreams[AParIndex] := oIntStr;
        TODBCParameter(ApInfo^.FVar).Streamed := True;
      end;
      AParam.GetDataReader(@pBuffer, AParIndex);
      ApInfo^.FVar.SetDataReader(AVarIndex, @pBuffer);
    end

    else if AParam.IsNulls[AParIndex] then
      ApInfo^.FVar.SetData(AVarIndex, nil, 0)

    else begin
      if ApInfo^.FSrcDataType = ApInfo^.FOutDataType then
        if ApInfo^.FOutDataType in (C_FD_VarLenTypes - [dtByteString]
           {$IFDEF NEXTGEN} - C_FD_AnsiTypes {$ENDIF}) then begin
          AParam.GetBlobRawData(iDataSize, pBuffer, AParIndex);
          ApInfo^.FVar.SetData(AVarIndex, pBuffer, iDataSize);
        end
        else begin
          iSrcSize := AParam.GetDataLength(AParIndex);
          FBuffer.Check(iSrcSize);
          AParam.GetData(FBuffer.Ptr, AParIndex);
          ApInfo^.FVar.SetData(AVarIndex, FBuffer.Ptr, iSrcSize);
        end

      else begin
        iSrcSize := AParam.GetDataLength(AParIndex);
        FBuffer.Extend(iSrcSize, iDataSize, ApInfo^.FSrcDataType, ApInfo^.FOutDataType);

        AParam.GetData(FBuffer.Ptr, AParIndex);
        oFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ApInfo^.FOutDataType,
          FBuffer.Ptr, iSrcSize, FBuffer.FBuffer, FBuffer.Size, iDataSize,
          ODBCConnection.ODBCConnection.Encoder);
        ApInfo^.FVar.SetData(AVarIndex, FBuffer.Ptr, iDataSize);
      end;

      case ApInfo^.FOutDataType of
      dtBCD,
      dtFmtBCD:
        begin
          FDBcdGetMetrics(PBcd(FBuffer.Ptr)^, iPrec, iScale);
          if iMaxNumScale < iScale then
            iMaxNumScale := iScale;
          if iMaxNumBefDot < SQLSmallint(iPrec - iScale) then
            iMaxNumBefDot := SQLSmallint(iPrec - iScale);
        end;
      dtBlob,
      dtMemo,
      dtWideMemo,
      dtXML,
      dtHBlob,
      dtHBFile,
      dtHMemo,
      dtWideHMemo,
      dtAnsiString,
      dtWideString,
      dtByteString:
        begin
          if (iSrcSize <> 0) and (iDataSize = 0) then
            iDataSize := iSrcSize;
          if SQLInteger(iDataSize) < AParam.Size then
            iDataSize := AParam.Size;
          if iMaxStrSize < SQLInteger(iDataSize) then
            iMaxStrSize := iDataSize;
        end;
      end;
    end;
  end;

begin
  oParams := GetParams;
  if (FCommandStatement = nil) or (oParams.Count = 0) then
    Exit;

  oFmtOpts := GetOptions.FormatOptions;
  iArraySize := oParams.ArraySize;
  if ATimes < iArraySize then
    iArraySize := ATimes;

  ASSERT((AFromParIndex <> -1) or (iArraySize = 1) or (cpParamSet in FStatementProps));
                                                            
                                                                                 
  if not MatchParamsetSize(GetParamsetSize(iArraySize), FCommandStatement.PARAMSET_SIZE) then
    FCommandStatement.BindParameters(GetParamsetSize(iArraySize), True);

  for i := 0 to Length(FParInfos) - 1 do begin
    pParInfo := @FParInfos[i];
    if pParInfo^.FParamIndex <> -1 then begin
      oParam := oParams[pParInfo^.FParamIndex];
      oVar := pParInfo^.FVar;
      if oParam.DataType <> ftCursor then begin
        CheckParamMatching(oParam, pParInfo^.FDataType, pParInfo^.FParamType, 0);
        if oVar <> nil then begin
          iMaxNumBefDot := -1;
          iMaxNumScale := -1;
          iMaxStrSize := -1;
          if AFromParIndex = -1 then
            for j := AOffset to iArraySize - 1 do
              ProcessArrayItem(oParam, pParInfo, j, j)
          else
            ProcessArrayItem(oParam, pParInfo, 0, AFromParIndex);

          lRebind := False;
          if ((oVar.ParamType = SQL_PARAM_OUTPUT) or (oVar.ParamType = SQL_PARAM_OUTPUT_STREAM)) and
             not oVar.Binded then
            lRebind := True;

          if ((iMaxNumBefDot >= 0) or (iMaxNumScale >= 0)) and (
              // Without following 3 lines, MSSQL / DB2 may return "Numeric value
              // out of range" with ftBCD / ftFmtBCD parameters and the values with
              // a different precision and / or scale.
              (oVar.ColumnSize < iMaxNumBefDot + iMaxNumScale) or
              (oVar.Scale < iMaxNumScale) or
              (oVar.ColumnSize - oVar.Scale < iMaxNumBefDot)) then begin
            if oVar.ColumnSize < iMaxNumBefDot + iMaxNumScale then
              oVar.ColumnSize := iMaxNumBefDot + iMaxNumScale;
            if oVar.Scale < iMaxNumScale then
              oVar.Scale := iMaxNumScale;
            lRebind := True;
          end;

          if (iMaxStrSize >= 0) and (oVar.ColumnSize < iMaxStrSize) then begin
            if iMaxStrSize = 0 then
              iMaxStrSize := 1;
            oVar.ColumnSize := iMaxStrSize;
            lRebind := True;
          end;

          if lRebind then begin
            // If not reset the FFlagsUpdated to True, then the DataSize will be
            // recalculated according to the new ColumnSize. But the value buffers
            // are already allocated and initialized. So, this will lead to a
            // garbage will be sent to a server.
            oVar.ResetFlagsUpdated;
            oVar.Bind;
          end;
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.GetCustomParamValue(ADataType: TFDDataType;
  AVar: TODBCVariable; AParam: TFDParam; AVarIndex, AParIndex: Integer);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.GetParamValues(ATimes, AOffset: Integer;
  AFromParIndex: Integer);
var
  oParams: TFDParams;
  oFmtOpts: TFDFormatOptions;
  iArraySize, i, j: Integer;
  oParam: TFDParam;
  pParInfo: PFDODBCParInfoRec;

  procedure ProcessArrayItem(AParam: TFDParam; ApInfo: PFDODBCParInfoRec;
    AVarIndex, AParIndex: Integer);
  var
    iSize: SQLLen;
    pData: SQLPointer;
    iDestDataLen: LongWord;
  begin
    pData := nil;
    iSize := 0;

    if GetIsCustomParam(ApInfo^.FSrcDataType) then
      GetCustomParamValue(ApInfo^.FSrcDataType, ApInfo^.FVar, AParam, AVarIndex, AParIndex)

    else if AParam.IsObjects[AParIndex] then begin
      // nothing
    end

    else if not ApInfo^.FVar.GetData(AVarIndex, pData, iSize, True) then
      AParam.Clear(AParIndex)

    else if ApInfo^.FOutDataType = ApInfo^.FSrcDataType then
      if ApInfo^.FOutDataType in C_FD_VarLenTypes then
        AParam.SetData(PByte(pData), iSize, AParIndex)
      else begin
        FBuffer.Check(iSize);
        ApInfo^.FVar.GetData(AVarIndex, FBuffer.FBuffer, iSize, False);
        AParam.SetData(FBuffer.Ptr, iSize, AParIndex);
      end

    else begin
      FBuffer.Check(iSize);
      ApInfo^.FVar.GetData(AVarIndex, FBuffer.FBuffer, iSize, False);

      iDestDataLen := 0;
      FBuffer.Extend(iSize, iDestDataLen, ApInfo^.FOutDataType, ApInfo^.FSrcDataType);
      iDestDataLen := 0;
      oFmtOpts.ConvertRawData(ApInfo^.FOutDataType, ApInfo^.FSrcDataType,
        FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestDataLen,
        ODBCConnection.ODBCConnection.Encoder);
      AParam.SetData(FBuffer.Ptr, iDestDataLen, AParIndex);
    end;
  end;

begin
  oParams := GetParams;
  if (FCommandStatement = nil) or (oParams.Count = 0) then
    Exit;

  oFmtOpts := FOptions.FormatOptions;
  if ATimes = -1 then begin
    iArraySize := FCommandStatement.PARAMSET_SIZE;
    if iArraySize > oParams.ArraySize then
      iArraySize := oParams.ArraySize;
  end
  else begin
    iArraySize := oParams.ArraySize;
    if ATimes < iArraySize then
      iArraySize := ATimes;
  end;
  if (AFromParIndex = -1) and not (cpParamSet in FStatementProps) then
    AFromParIndex := 0;

  for i := 0 to Length(FParInfos) - 1 do begin
    pParInfo := @FParInfos[i];
    if pParInfo^.FParamIndex <> -1 then begin
      oParam := oParams[pParInfo^.FParamIndex];
      if (oParam.ParamType in [ptOutput, ptResult, ptInputOutput]) and
         not (oParam.DataType in [ftCursor, ftDataSet]) then begin
        CheckParamMatching(oParam, pParInfo^.FDataType, pParInfo^.FParamType, 0);
        if pParInfo^.FVar <> nil then
          if AFromParIndex = -1 then
            for j := AOffset to iArraySize - 1 do
              ProcessArrayItem(oParam, pParInfo, j, j)
          else
            ProcessArrayItem(oParam, pParInfo, 0, AFromParIndex);
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter);
var
  i: Integer;
  iTmpCount: SQLLen;
  oFO: TFDFetchOptions;
  sCmd: String;
begin
  CloseStatement(-1, True, False, False);
  SetupStatementBeforeExecute(FStatement);
  Exclude(FStatementProps, cpOnNextResult);
  ACount := 0;
  oFO := FOptions.FetchOptions;
  if UseExecDirect then
    sCmd := FDbCommandText
  else
    sCmd := '';
  try
    if (cpParamSet in FStatementProps) or (ATimes = 1) and (AOffset = 0) then begin
      // MSSQL 2005: FDQA fails on "Batch execute" -> "Error handling" with
      // 24000 state (invalid cursor state). Following code is workaround for that.
      if (ATimes - AOffset = 1) and (AOffset > 0) and (cpResetOnArrayOffset in FStatementProps) then begin
        InternalUnprepare;
        InternalPrepare;
      end;
      SetParamValues(ATimes, AOffset, -1);
      FCommandStatement.Execute(ATimes, AOffset, ACount, oFO.Mode = fmExactRecsMax, sCmd);
      if (GetState <> csAborting) and
         // ASA: After Array DML its execution restarts on SQLMoreResults
         ((soArrayBatch in ODBCConnection.FSupportedOptions) or (ATimes = 1) and (AOffset = 0)) then begin
        if not FCommandStatement.ResultColsExists and (FCommandStatement.FocusedParam = nil) then begin
          Include(FStatementProps, cpOnNextResult);
          if GetCursor(ACount) then
            Include(FStatementProps, cpOnNextResultValue)
          else
            Exclude(FStatementProps, cpOnNextResultValue);
        end;
        if cpOutResParams in FStatementProps then
          GetParamValues(ATimes, AOffset, -1);
      end;
    end
    else begin
      for i := AOffset to ATimes - 1 do begin
        SetParamValues(1, 0, i);
        iTmpCount := 0;
        try
          FCommandStatement.Execute(1, 0, iTmpCount, oFO.Mode = fmExactRecsMax, sCmd);
        except
          on E: EODBCNativeException do begin
            E[0].RowIndex := i;
            raise;
          end;
        end;
        if iTmpCount = -1 then
          ACount := -1
        else if ACount >= 0 then
          Inc(ACount, iTmpCount);
        if GetState <> csAborting then
          CloseStatement(i, True, True, False)
        else
          Break;
      end;
    end;
  except
    CloseStatement(-1, True, True, True);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalCloseStreams;
begin
  if FCommandStatement <> nil then
    FCommandStatement.FlushLongData;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalAbort;
begin
  FStatement.Cancel;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.GetCursor(var ARows: SQLLen): Boolean;
begin
  repeat
    // "rows affected" may be not in first result set of command result sets.
    // For example, if INSERT fires trigger, it calls PRINT, open cursors, etc.
    // See FDQA, TFDQAPhysCMDTsHolder.TestCommandInsRecCnt test.
    if (FCommandStatement <> nil) and (ARows < 0) then
      FCommandStatement.UpdateRowsAffected(ARows);
    Result := FStatement.ResultColsExists;
  until Result or not FStatement.MoreResults or (GetState = csAborting);
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.InternalOpen: Boolean;
var
  iTmpCount: SQLLen;
  sCmd: String;
begin
  CloseStatement(-1, True, False, False);
  if FStatement <> nil then
    SetupStatementBeforeExecute(FStatement);
  if cpNotFirstCursor in FStatementProps then begin
    DestroyDescribeInfos;
    Exclude(FStatementProps, cpNotFirstCursor);
  end;
  Exclude(FStatementProps, cpOnNextResult);
  sCmd := '';
  if UseStatement then begin
    SetParamValues(1, 0, -1);
    if UseExecDirect then
      sCmd := FDbCommandText;
  end;
  iTmpCount := 0;
  try
    if UseStatement then begin
      FCommandStatement.Execute(GetParams.ArraySize, 0, iTmpCount,
        FOptions.FetchOptions.Mode = fmExactRecsMax, sCmd);
      Result := True;
    end
    else
      Result := OpenMetaInfo;
    Result := Result and (GetState <> csAborting);

    if Result then begin
      Result := GetCursor(iTmpCount);
      if UseStatement and (cpOutResParams in FStatementProps) then
        GetParamValues(-1, 0, -1);
      if Result and (Length(FColInfos) = 0) then begin
        CreateDescribeInfos;
        SetupStatementAfterDescribe(FStatement);
        FStatement.BindColumns(GetRowsetSize(FOptions.FetchOptions.ActualRowsetSize));
      end;
    end;

    if not Result then
      CloseStatement(-1, True, True, False);
  except
    CloseStatement(-1, True, True, True);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.InternalClose;
begin
  CloseStatement(-1, False, True, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.CloseStatement(AIndex: Integer; AForceClose,
  AGetOutParams, AIgnoreErrors: Boolean);
var
  oConnMeta: IFDPhysConnectionMetadata;
  lPrevIgnoreErrors: Boolean;
begin
  if (AForceClose or not GetNextRecordSet) and
     (FStatement <> nil) and FStatement.Executed then begin
    if (cpOutResParams in FStatementProps) and not FStatement.NoMoreResults then begin
      ODBCConnection.CreateMetadata(oConnMeta);
      // If after SQLExecute & paramsetsize > 1 & failed row with index < paramsetsize - 1,
      // call SQLMoreResults, it will continue command execution on Sybase ASA driver
      if ODBCConnection.DriverKind <> dkSQLAnywhere then
        while FStatement.MoreResults do
          ;
      if AGetOutParams then
        GetParamValues(-1, 0, AIndex);
    end;
    // No Check call is required to fix the issue:
    // http://www.da-soft.com/forums/anydac-general-english/problem-executing-script-anydac-phys-odbc-sqlncli10.dll-sql-error.html#18816
    lPrevIgnoreErrors := FStatement.IgnoreErrors;
    if AIgnoreErrors then
      FStatement.IgnoreErrors := True;
    try
      FStatement.Close;
    finally
      FStatement.IgnoreErrors := lPrevIgnoreErrors;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCCommand.FetchRow(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowIndex: SQLUInteger);
var
  oRow: TFDDatSRow;
  pData: SQLPointer;
  iSize: SQLLen;
  oFmtOpts: TFDFormatOptions;
  j: Integer;
  iDestDataLen: LongWord;
  lIsVal: Boolean;
  oCol: TFDDatSColumn;
  pInfo: PFDODBCColInfoRec;
begin
  oFmtOpts := FOptions.FormatOptions;
  oRow := ATable.NewRow(False);
  try
    for j := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[j];
      if (oCol.SourceID > 0) and CheckFetchColumn(oCol.SourceDataType, oCol.Attributes) then begin
        pInfo := @FColInfos[oCol.SourceID - 1];
        if pInfo^.FVar <> nil then begin
          pData := nil;
          iSize := 0;
          if pInfo^.FOutDataType = pInfo^.FDestDataType then
            if pInfo^.FDestDataType in C_FD_VarLenTypes then begin
              lIsVal := pInfo^.FVar.GetData(ARowIndex, pData, iSize, True);
              if lIsVal then
                oRow.SetData(j, pData, iSize);
            end
            else begin
              lIsVal := pInfo^.FVar.GetData(ARowIndex, FBuffer.FBuffer, iSize, False);
              if lIsVal then
                oRow.SetData(j, FBuffer.Ptr, iSize);
            end
          else begin
            lIsVal := pInfo^.FVar.GetData(ARowIndex, pData, iSize, True);
            if lIsVal then begin
              FBuffer.Check(iSize);
              pInfo^.FVar.GetData(ARowIndex, FBuffer.FBuffer, iSize, False);
              iDestDataLen := 0;
              oFmtOpts.ConvertRawData(pInfo^.FOutDataType, pInfo^.FDestDataType,
                FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestDataLen,
                ODBCConnection.ODBCConnection.Encoder);
              oRow.SetData(j, FBuffer.Ptr, iDestDataLen);
            end;
          end;
          if not lIsVal then
            oRow.SetData(j, nil, 0);
        end;
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
function TFDPhysODBCCommand.InternalFetchRowSet(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowsetSize: LongWord): LongWord;
var
  i, iRowsetSize, iRowsFetched: Integer;
  oRow: TFDDatSRow;
  oResultRow: TFDDatSRow;

  procedure CheckResultArg;
  begin
    oRow := ATable.Rows[ATable.Rows.Count - 1];
    if (oRow.GetData(8, rvDefault) = Integer(ptResult)) and
       (oRow.GetData(7, rvDefault) <> 1) then
      oResultRow := oRow;
  end;

  procedure AdjustProcArgs;
  var
    i: Integer;
    oParRow: TFDDatSRow;
    lMoved: Boolean;
  begin
    lMoved := oResultRow.List.MoveTo(oResultRow.Index,
      ATable.Rows.Count - (FRecordsFetched + Integer(Result)));
    oResultRow.SetData(0, 1);
    oResultRow.SetData(7, 1);
    for i := oResultRow.Index + 1 to ATable.Rows.Count - 1 do begin
      oParRow := ATable.Rows[i];
      if (VarToStr(oParRow.GetData(1, rvDefault)) = VarToStr(oResultRow.GetData(1, rvDefault))) and
         (VarToStr(oParRow.GetData(2, rvDefault)) = VarToStr(oResultRow.GetData(2, rvDefault))) and
         (VarToStr(oParRow.GetData(3, rvDefault)) = VarToStr(oResultRow.GetData(3, rvDefault))) and
         (VarToStr(oParRow.GetData(4, rvDefault)) = VarToStr(oResultRow.GetData(4, rvDefault))) and
         (VarToStr(oParRow.GetData(5, rvDefault)) = VarToStr(oResultRow.GetData(5, rvDefault))) then begin
        oParRow.SetData(0, oParRow.GetData(0, rvDefault) + 1);
        oParRow.SetData(7, oParRow.GetData(7, rvDefault) + 1);
      end;
    end;
    if lMoved and (ATable.DataHandleMode = lmFetching) then
      ATable.Views.Rebuild;
  end;

  procedure AdjustIndCols;
  var
    i, iPos: Integer;
    oColRow: TFDDatSRow;
    lSorted, lMoved: Boolean;
  begin
    lMoved := False;
    repeat
      lSorted := True;
      for i := ATable.Rows.Count - 1 downto ATable.Rows.Count - Integer(Result) do begin
        oColRow := ATable.Rows[i];
        iPos := oColRow.GetData(6, rvDefault);
        if oColRow.GetData(0, rvDefault) <> iPos then begin
          oColRow.SetData(0, iPos);
          lMoved := lMoved or oColRow.List.MoveTo(oColRow.Index,
            ATable.Rows.Count - (FRecordsFetched + Integer(Result)) + iPos - 1);
          lSorted := False;
          Break;
        end;
      end;
    until lSorted;
    if lMoved and (ATable.DataHandleMode = lmFetching) then
      ATable.Views.Rebuild;
  end;

begin
  Result := 0;
  oResultRow := nil;
  if (GetMetaInfoKind <> mkNone) and not FStatement.Executed then
    Exit;
  iRowsetSize := GetRowsetSize(ARowsetSize);
  while (Result < ARowsetSize) and (GetState = csFetching) do begin
    iRowsFetched := FStatement.Fetch(iRowsetSize);
    // If FetchOptions.RecsMax > 0, then MAX_ROWS = RecsMax + 1 and
    // ActualRowsetSize = RecMax, so may be that iRowsFetched > iRowsetSize
    if iRowsFetched > iRowsetSize then
      iRowsFetched := iRowsetSize;
    if GetMetaInfoKind = mkNone then begin
      for i := 0 to iRowsFetched - 1 do
        FetchRow(ATable, AParentRow, i);
      Inc(Result, iRowsFetched);
    end
    else begin
      for i := 0 to iRowsFetched - 1 do
        if FetchMetaRow(ATable, AParentRow, i, Result + 1) then begin
          Inc(Result);
          if (GetMetaInfoKind = mkProcArgs) and (oResultRow = nil) then
            CheckResultArg;
        end;
    end;
    if iRowsFetched <> iRowsetSize then
      Break;
  end;
  case GetMetaInfoKind of
  mkProcArgs:
    if oResultRow <> nil then
      AdjustProcArgs;
  mkIndexFields,
  mkPrimaryKeyFields:
    AdjustIndCols;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.InternalNextRecordSet: Boolean;
var
  iTmpCount: SQLLen;
begin
  Result := False;
  iTmpCount := 0;
  if (GetMetaInfoKind = mkNone) and (FCommandStatement <> nil) then begin
    DestroyDescribeInfos;
    if cpOnNextResult in FStatementProps then begin
      Exclude(FStatementProps, cpOnNextResult);
      Result := cpOnNextResultValue in FStatementProps;
    end
    else
      Result := FStatement.MoreResults and GetCursor(iTmpCount);
    if not Result then
      CloseStatement(-1, True, True, False)
    else begin
      Include(FStatementProps, cpNotFirstCursor);
      CreateDescribeInfos;
      FStatement.BindColumns(GetRowsetSize(FOptions.FetchOptions.ActualRowsetSize));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.OpenMetaInfo: Boolean;
var
  sCatalog, sSchema, sName, sTableTypes: String;
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  lQuoteType: Boolean;

  procedure AddTableType(const AType: String);
  begin
    if sTableTypes <> '' then
      sTableTypes := sTableTypes + ',';
    if lQuoteType then
      sTableTypes := sTableTypes + QuotedStr(AType)
    else
      sTableTypes := sTableTypes + AType;
  end;

  procedure SetCatalogSchemaFromObj;
  begin
    sCatalog := rName.FCatalog;
    sSchema := rName.FSchema;
    if (sSchema = '') and not (npSchema in ODBCConnection.AvoidImplicitMeta) then
      sSchema := ODBCConnection.GetCurrentSchema;
  end;

  procedure SetCatalogSchema;
  begin
    sCatalog := GetCatalogName;
    sSchema := GetSchemaName;
    if (GetObjectScopes = [osMy]) and (sSchema = '') and
       not (npSchema in ODBCConnection.AvoidImplicitMeta) then
      sSchema := ODBCConnection.GetCurrentSchema;
  end;

  procedure GetObjName;
  begin
    ODBCConnection.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self, [doNormalize, doUnquote]);
    CheckMetaInfoParams(rName);
  end;

begin
  Result := FMetainfoStatement <> nil;
  if Result then
  try
    case GetMetaInfoKind of
    mkCatalogs:
      FMetainfoStatement.Catalogs;
    mkSchemas:
      FMetainfoStatement.Schemas;
    mkTables:
      begin
        SetCatalogSchema;
        // Sybase ASE 15 ODBC driver expects table types to be quoted
        lQuoteType := ODBCConnection.DriverKind = dkSybaseASE;
        if tkTable in GetTableKinds then
          AddTableType('TABLE');
        if tkView in GetTableKinds then
          AddTableType('VIEW');
        if tkSynonym in GetTableKinds then
          AddTableType('SYNONYM');
        if tkTempTable in GetTableKinds then
          AddTableType('GLOBAL TEMPORARY');
        if tkLocalTable in GetTableKinds then
          AddTableType('LOCAL TEMPORARY');
        if (osSystem in GetObjectScopes) and (tkTable in GetTableKinds) then
          AddTableType('SYSTEM TABLE');
        FMetainfoStatement.Tables(sCatalog, sSchema, GetWildcard, sTableTypes);
      end;
    mkTableFields:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
                                                                    
        FMetainfoStatement.Columns(sCatalog, sSchema, rName.FObject, GetWildcard);
      end;
    mkTableTypeFields:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        FMetainfoStatement.TypeColumns(sCatalog, sSchema, rName.FObject, GetWildcard);
      end;
    mkIndexes:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        ODBCConnection.CreateMetadata(oConnMeta);
        FMetainfoAddonView := oConnMeta.GetTablePrimaryKey(sCatalog, sSchema, GetCommandText);
        FMetainfoStatement.Statistics(sCatalog, sSchema, rName.FObject, SQL_INDEX_ALL);
      end;
    mkIndexFields:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        FMetainfoStatement.Statistics(sCatalog, sSchema, rName.FBaseObject, SQL_INDEX_ALL);
      end;
    mkPrimaryKey:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        if soPKFunction in ODBCConnection.FSupportedOptions then
          FMetainfoStatement.PrimaryKeys(sCatalog, sSchema, rName.FObject)
        else
          FMetainfoStatement.SpecialColumns(sCatalog, sSchema, rName.FObject, SQL_BEST_ROWID);
      end;
    mkPrimaryKeyFields:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        if soPKFunction in ODBCConnection.FSupportedOptions then
          FMetainfoStatement.PrimaryKeys(sCatalog, sSchema, rName.FBaseObject)
        else
          FMetainfoStatement.SpecialColumns(sCatalog, sSchema, rName.FBaseObject, SQL_BEST_ROWID);
      end;
    mkForeignKeys:
      if not (soFKFunction in ODBCConnection.FSupportedOptions) then
        Result := False
      else begin
        GetObjName;
        SetCatalogSchemaFromObj;
        FMetainfoStatement.ForeignKeys('', '', '', sCatalog, sSchema, rName.FObject);
      end;
    mkForeignKeyFields:
      if not (soFKFunction in ODBCConnection.FSupportedOptions) then
        Result := False
      else begin
        GetObjName;
        SetCatalogSchemaFromObj;
        FMetainfoStatement.ForeignKeys('', '', '', sCatalog, sSchema, rName.FBaseObject);
      end;
    mkPackages:
      Result := False;
    mkProcs:
      begin
        GetObjName;
        if rName.FBaseObject <> '' then
          SetCatalogSchemaFromObj
        else
          SetCatalogSchema;
        FMetainfoStatement.Procedures(sCatalog, sSchema, GetWildcard);
      end;
    mkProcArgs:
      begin
        GetObjName;
        SetCatalogSchemaFromObj;
        if rName.FBaseObject <> '' then
          sName := rName.FBaseObject + '.';
        FMetainfoStatement.ProcedureColumns(sCatalog, sSchema, sName + rName.FObject, GetWildcard);
      end;
    mkGenerators,
    mkResultSetFields:
      Result := False;
    end;
    if Result then
      FMetainfoStatement.Execute;
  except
    on E: EODBCNativeException do begin
      ODBCConnection.CreateMetadata(oConnMeta);
      if (ODBCConnection.DriverKind in [dkMSAccessJet, dkMSAccessACE]) and (E.Errors[0].ErrorCode = -1034) or
         // Optional feature not implemented
         (E.Errors[0].SQLState = 'HYC00') or
         // Driver does not support this function
         (E.Errors[0].SQLState = 'IM001') or
         // FreeTDS returns NO DATA FOUND
         (E.Kind = ekNoDataFound) then
        Result := False
      else
        raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCCommand.FetchMetaRow(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowIndex, ARowNo: SQLUInteger): Boolean;
var
  oRow: TFDDatSRow;
  pData: SQLPointer;
  iRecNo: Integer;
  iSize: SQLLen;
  eTableKind: TFDPhysTableKind;
  eScope: TFDPhysObjectScope;
  iLen: LongWord;
  iPrec, iScale: Integer;
  eType: TFDDataType;
  eAttrs: TFDDataAttributes;
  iODBCType: SQLSmallint;
  iODBCSize: SQLInteger;
  iODBCDec: SQLSmallint;
  eIndKind: TFDPhysIndexKind;
  rName: TFDPhysParsedName;
  lDeleteRow: Boolean;
  oConnMeta: IFDPhysConnectionMetadata;
  eProcKind: TFDPhysProcedureKind;
  eParType: TParamType;
  eCascade: TFDPhysCascadeRuleKind;
  i: Integer;
  pCh: PWideChar;
  sType: String;

  procedure GetScope(ACatalogColIndex, ASchemaColIndex, AObjColIndex: Integer;
    var AScope: TFDPhysObjectScope);
  var
    sCat, sSch, sObj: String;
  begin
    if not (npSchema in oConnMeta.NameParts) then
      AScope := osMy
    else begin
      sCat := VarToStr(oRow.GetData(ACatalogColIndex, rvDefault));
      sSch := VarToStr(oRow.GetData(ASchemaColIndex, rvDefault));
      sObj := VarToStr(oRow.GetData(AObjColIndex, rvDefault));
      if AnsiCompareText(sSch, ODBCConnection.GetCurrentSchema) = 0 then
        AScope := osMy
      else if (AnsiCompareText(sSch, 'SYS') = 0) or
              (AnsiCompareText(sSch, 'SYSTEM') = 0) or
              (AnsiCompareText(sSch, 'INFORMATION_SCHEMA') = 0) or
              (oConnMeta.Kind = TFDRDBMSKinds.DB2) and
                (AnsiCompareText(sSch, 'SYSPROC') = 0) or
              (oConnMeta.Kind = TFDRDBMSKinds.Informix) and
                ((AnsiCompareText(sCat, 'SYSMASTER') = 0) or
                 (AnsiCompareText(Copy(sObj, 1, 3), 'SYS') = 0)) then
        AScope := osSystem
      else
        AScope := osOther;
    end;
  end;

  procedure AdjustMaxVarLen(AODBCType: SQLSmallint; var AODBCSize: SQLInteger; AField: Boolean);
  begin
    case ODBCConnection.DriverKind of
    dkSQLNC,
    dkSQLOdbc,
    dkFreeTDS,
    dkSQLSrvOther:
      if (AODBCSize = SQL_SS_LENGTH_UNLIMITED) and
         ((AODBCType = SQL_VARCHAR) or (AODBCType = SQL_VARBINARY) or
          (AODBCType = SQL_WVARCHAR) or (AODBCType = SQL_SS_XML)) then
        AODBCSize := MAXINT;
    dkInformix:
      // Workaround for "p like tab.fld", where "fld CHAR(N)"
      if not AField and (AODBCType = SQL_CHAR) and (AODBCSize = 1) then
        AODBCSize := 0;
    end;
  end;

  // Workaround of some ODBC drivers, which return #0 instead of NULL
  // as a catalog or a schema name, when they are not supported. Eg,
  // IB/FB ODBC returns #0 as a catalog name.
  function TrimZeros(AColIndex: Integer): Boolean;
  begin
    case FStatement.ColumnList[AColIndex].CDataType of
    SQL_C_WCHAR:
      while (iSize > 0) and ((PWideChar(pData) + iSize - 1)^ = #0) do
        Dec(iSize);
    SQL_C_CHAR:
      while (iSize > 0) and ((PFDAnsiString(pData) + iSize - 1)^ = TFDAnsiChar(#0)) do
        Dec(iSize);
    else
      ASSERT(False);
    end;
    Result := iSize > 0;
  end;

begin
  lDeleteRow := False;
  iRecNo := FRecordsFetched + ARowNo;
  if not UseInformationSchema then begin
    oRow := ATable.NewRow(False);
    pData := FBuffer.Ptr;
  end
  else begin
    FetchRow(ATable, AParentRow, ARowIndex);
    ATable.Rows[ATable.Rows.Count - 1].SetData(0, iRecNo);
    Result := True;
    Exit;
  end;
  try
    FConnection.CreateMetadata(oConnMeta);
    case GetMetaInfoKind of
    mkCatalogs:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        if (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(1, rvDefault)), GetWildcard, True) then
          lDeleteRow := True
        else
          for i := 0 to ATable.Rows.Count - 1 do
            if VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault)) then begin
              lDeleteRow := True;
              Break;
            end;
      end;
    mkSchemas:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
          oRow.SetData(2, pData, iSize);
        if (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(2, rvDefault)), GetWildcard, True) then
          lDeleteRow := True
        else if (GetCatalogName <> '') and
           (CompareText(VarToStr(oRow.GetData(1, rvDefault)), GetCatalogName) <> 0) then
          lDeleteRow := True
        else
          for i := 0 to ATable.Rows.Count - 1 do
            if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) then begin
              lDeleteRow := True;
              Break;
            end;
      end;
    mkTables:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(3, pData, iSize);
        iSize := 0;
        eTableKind := tkTable;
        eScope := osOther;
        if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then begin
          GetScope(1, 2, 3, eScope);
          if StrLIComp(PWideChar(pData), 'TABLE', iSize) = 0 then
            eTableKind := tkTable
          else if StrLIComp(PWideChar(pData), 'VIEW', iSize) = 0 then
            eTableKind := tkView
          else if StrLIComp(PWideChar(pData), 'SYSTEM TABLE', iSize) = 0 then begin
            eTableKind := tkTable;
            eScope := osSystem;
          end
          else if StrLIComp(PWideChar(pData), 'GLOBAL TEMPORARY', iSize) = 0 then
            eTableKind := tkTempTable
          else if StrLIComp(PWideChar(pData), 'LOCAL TEMPORARY', iSize) = 0 then
            eTableKind := tkLocalTable
          else if StrLIComp(PWideChar(pData), 'ALIAS', iSize) = 0 then
            eTableKind := tkSynonym
          else if StrLIComp(PWideChar(pData), 'SYNONYM', iSize) = 0 then
            eTableKind := tkSynonym;
        end;
        oRow.SetData(4, Smallint(eTableKind));
        oRow.SetData(5, Smallint(eScope));
        lDeleteRow := not (eTableKind in GetTableKinds) or
                      not (eScope in GetObjectScopes);
      end;
    mkTableFields,
    mkTableTypeFields:
      begin
        eAttrs := [caBase];
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(3, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(4, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList.Count >= 17 then begin
          if FStatement.ColumnList[16].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(5, PSQLInteger(pData)^);
        end
        else
          oRow.SetData(5, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(7, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList.Count >= 13 then
          if FStatement.ColumnList[12].GetData(ARowIndex, pData, iSize) and (iSize > 0) then
            Include(eAttrs, caDefault);
        iSize := 0;
        if not FStatement.ColumnList[10].GetData(ARowIndex, pData, iSize) or
           (PSQLSmallint(pData)^ <> SQL_NO_NULLS) then
          Include(eAttrs, caAllowNull);
        iSize := 0;
        if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) then
          iODBCType := PSQLSmallint(pData)^
        else
          iODBCType := SQL_TYPE_NULL;
        iSize := 0;
        if FStatement.ColumnList[6].GetData(ARowIndex, pData, iSize) then begin
          iODBCSize := PSQLInteger(pData)^;
          AdjustMaxVarLen(iODBCType, iODBCSize, True);
        end
        else
          iODBCSize := 0;
        iSize := 0;
        if FStatement.ColumnList[8].GetData(ARowIndex, pData, iSize) then
          iODBCDec := PSQLSmallint(pData)^
        else
          iODBCDec := 0;
        SQL2FDColInfo(iODBCType, False, VarToStr(oRow.GetData(7, rvDefault)),
          iODBCSize, iODBCDec, eType, eAttrs, iLen, iPrec, iScale);
        oRow.SetData(6, Smallint(eType));
        oRow.SetData(8, PWord(@eAttrs)^);
        oRow.SetData(9, iPrec);
        oRow.SetData(10, iScale);
        oRow.SetData(11, iLen);
                                                    
  {
        if iDbxType and eSQLRowId <> 0 then
          Include(eAttrs, caROWID);
        if iDbxType and eSQLRowVersion <> 0 then
          Include(eAttrs, caRowVersion);
        if iDbxType and eSQLAutoIncr <> 0 then
          Include(eAttrs, caAutoInc);
  }
      end;
    mkIndexes:
      begin
        iSize := 0;
        if FStatement.ColumnList[6].GetData(ARowIndex, pData, iSize) and
           (PSQLSmallint(pData)^ = SQL_TABLE_STAT) then
          lDeleteRow := True
        else begin
          oRow.SetData(0, iRecNo);
          iSize := 0;
          if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
            oRow.SetData(1, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
            oRow.SetData(2, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(3, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(4, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) and
             (PSQLSmallint(pData)^ = SQL_FALSE) then
            eIndKind := ikUnique
          else
            eIndKind := ikNonUnique;
          FMetainfoAddonView.RowFilter := 'INDEX_NAME = ''' + VarToStr(oRow.GetData(4)) + '''';
          if FMetainfoAddonView.Rows.Count > 0 then begin
            eIndKind := ikPrimaryKey;
            oRow.SetData(5, FMetainfoAddonView.Rows[0].GetData(5));
          end;
          oRow.SetData(6, Smallint(eIndKind));
          FMetainfoAddonView.RowFilter := '';
          for i := 0 to ATable.Rows.Count - 1 do
            if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(4, rvDefault)) = VarToStr(oRow.GetData(4, rvDefault))) then begin
              lDeleteRow := True;
              Break;
            end;
        end;
      end;
    mkIndexFields:
      begin
        iSize := 0;
        if FStatement.ColumnList[6].GetData(ARowIndex, pData, iSize) and
           (PSQLSmallint(pData)^ = SQL_TABLE_STAT) then
          lDeleteRow := True
        else begin
          oRow.SetData(0, iRecNo);
          iSize := 0;
          if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
            oRow.SetData(1, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
            oRow.SetData(2, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(3, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(4, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[8].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(5, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[7].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(6, PSQLSmallint(pData)^);
          iSize := 0;
          if FStatement.ColumnList[9].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(7, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[12].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(8, pData, iSize);
          oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self,
            [doNormalize, doUnquote]);
          lDeleteRow := (AnsiCompareText(rName.FObject,
            Trim(VarToStr(oRow.GetData(4, rvDefault)))) <> 0);
        end;
      end;
    mkPrimaryKey:
      begin
        if soPKFunction in ODBCConnection.FSupportedOptions then begin
          oRow.SetData(0, iRecNo);
          iSize := 0;
          if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
            oRow.SetData(1, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
            oRow.SetData(2, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(3, pData, iSize);
          iSize := 0;
          if (FStatement.ColumnList.Count >= 6) and
             FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then begin
            oRow.SetData(4, pData, iSize);
            oRow.SetData(5, pData, iSize);
          end;
          oRow.SetData(6, Smallint(ikPrimaryKey));
          for i := 0 to ATable.Rows.Count - 1 do
            if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(5, rvDefault)) = VarToStr(oRow.GetData(5, rvDefault))) then begin
              lDeleteRow := True;
              Break;
            end;
        end
        else begin
          lDeleteRow := ARowIndex > 0;
          if not lDeleteRow then begin
            oRow.SetData(0, iRecNo);
            oConnMeta.DecodeObjName(Trim(GetCatalogName), rName, Self,
              [doNormalize, doUnquote]);
            oRow.SetData(1, rName.FObject);
            oConnMeta.DecodeObjName(Trim(GetSchemaName), rName, Self,
              [doNormalize, doUnquote]);
            oRow.SetData(2, rName.FObject);
            oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self,
              [doNormalize, doUnquote]);
            oRow.SetData(3, rName.FObject);
            oRow.SetData(4, C_FD_BestRowID);
            oRow.SetData(5, C_FD_BestRowID);
            oRow.SetData(6, Smallint(ikPrimaryKey));
          end;
        end;
      end;
    mkPrimaryKeyFields:
      begin
        oRow.SetData(0, iRecNo);
        if soPKFunction in ODBCConnection.FSupportedOptions then begin
          iSize := 0;
          if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
            oRow.SetData(1, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
            oRow.SetData(2, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(3, pData, iSize);
          iSize := 0;
          if (FStatement.ColumnList.Count >= 6) and
             FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(4, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(5, pData, iSize);
          iSize := 0;
          if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(6, PSQLSmallint(pData)^);
        end
        else begin
          oConnMeta.DecodeObjName(Trim(GetCatalogName), rName, Self,
              [doNormalize, doUnquote]);
          oRow.SetData(1, rName.FObject);
          oConnMeta.DecodeObjName(Trim(GetSchemaName), rName, Self,
              [doNormalize, doUnquote]);
          oRow.SetData(2, rName.FObject);
          oConnMeta.DecodeObjName(Trim(GetBaseObjectName), rName, Self,
              [doNormalize, doUnquote]);
          oRow.SetData(3, rName.FObject);
          oRow.SetData(4, C_FD_BestRowID);
          iSize := 0;
          if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(5, pData, iSize);
          oRow.SetData(6, iRecNo);
        end;
        oRow.SetData(7, 'A');
      end;
    mkForeignKeys:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) and TrimZeros(4) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) and TrimZeros(5) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[6].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(3, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[11].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(4, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(5, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(6, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(7, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[10].GetData(ARowIndex, pData, iSize) then begin
          eCascade := ckNone;
          case PSQLSmallInt(pData)^ of
          SQL_CASCADE:     eCascade := ckCascade;
          SQL_NO_ACTION,
          SQL_RESTRICT:    eCascade := ckRestrict;
          SQL_SET_NULL:    eCascade := ckSetNull;
          SQL_SET_DEFAULT: eCascade := ckSetDefault;
          end;
          oRow.SetData(8, SmallInt(eCascade));
        end;
        iSize := 0;
        if FStatement.ColumnList[9].GetData(ARowIndex, pData, iSize) then begin
          eCascade := ckNone;
          case PSQLSmallInt(pData)^ of
          SQL_CASCADE:     eCascade := ckCascade;
          SQL_NO_ACTION,
          SQL_RESTRICT:    eCascade := ckRestrict;
          SQL_SET_NULL:    eCascade := ckSetNull;
          SQL_SET_DEFAULT: eCascade := ckSetDefault;
          end;
          oRow.SetData(9, SmallInt(eCascade));
        end;
        for i := 0 to ATable.Rows.Count - 1 do
          if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(4, rvDefault)) = VarToStr(oRow.GetData(4, rvDefault))) then begin
            lDeleteRow := True;
            Break;
          end;
      end;
    mkForeignKeyFields:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) and TrimZeros(4) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) and TrimZeros(5) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[6].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(3, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[11].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(4, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[7].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(5, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(6, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[8].GetData(ARowIndex, pData, iSize) then begin
          PInteger(pData)^ := PWord(pData)^;
          oRow.SetData(7, pData, SizeOf(Integer));
        end;
        oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self,
          [doNormalize, doUnquote]);
        lDeleteRow := (AnsiCompareText(rName.FObject,
          Trim(VarToStr(oRow.GetData(4, rvDefault)))) <> 0);
      end;
    mkProcs:
      begin
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then begin
          if oConnMeta.Kind = TFDRDBMSKinds.MSSQL then begin
            pCh := PWideChar(pData) + iSize - 1;
            while (pCh >= pData) and (pCh^ <> ';') do
              Dec(pCh);
            if (pCh >= pData) and (pCh^ = ';') and ((pCh + 1)^ = '1') then
              Dec(iSize, 2);
          end;
          oRow.SetData(4, pData, iSize);
        end;
        iSize := 0;
        if FStatement.ColumnList[7].GetData(ARowIndex, pData, iSize) and
           (PSQLSmallint(pData)^ = SQL_PT_FUNCTION) then
          eProcKind := pkFunction
        else
          eProcKind := pkProcedure;
        oRow.SetData(6, Smallint(eProcKind));
        GetScope(1, 2, 4, eScope);
        oRow.SetData(7, Smallint(eScope));
        iSize := 0;
        if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then
          if PSmallint(pData)^ = -1 then
            oRow.SetData(8, 0)
          else
            oRow.SetData(8, PSmallint(pData)^);
        iSize := 0;
        if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) then
          if PSmallint(pData)^ = -1 then
            oRow.SetData(9, 0)
          else
            oRow.SetData(9, PSmallint(pData)^);
        lDeleteRow := not (eScope in GetObjectScopes);
      end;
    mkProcArgs:
      begin
        eAttrs := [];
        oRow.SetData(0, iRecNo);
        iSize := 0;
        if FStatement.ColumnList[0].GetData(ARowIndex, pData, iSize) and TrimZeros(0) then
          oRow.SetData(1, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[1].GetData(ARowIndex, pData, iSize) and TrimZeros(1) then
          oRow.SetData(2, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[2].GetData(ARowIndex, pData, iSize) then
          oRow.SetData(4, pData, iSize);
        iSize := 0;
        if FStatement.ColumnList[3].GetData(ARowIndex, pData, iSize) then begin
          if (cpUnifyParams in FStatementProps) and (PWideChar(pData)^ = '@') then begin
            pData := PWideChar(pData) + 1;
            Dec(iSize);
          end;
          oRow.SetData(6, pData, iSize);
        end;
        iSize := 0;
        if FStatement.ColumnList.Count >= 18 then begin
          if FStatement.ColumnList[17].GetData(ARowIndex, pData, iSize) then
            oRow.SetData(7, PSQLInteger(pData)^);
        end
        else
          oRow.SetData(7, iRecNo);
        eParType := ptUnknown;
        iSize := 0;
        if FStatement.ColumnList[4].GetData(ARowIndex, pData, iSize) then
          case PSQLSmallint(pData)^ of
          SQL_PARAM_INPUT:        eParType := ptInput;
          SQL_PARAM_INPUT_OUTPUT: eParType := ptInputOutput;
          SQL_PARAM_OUTPUT:       eParType := ptOutput;
          SQL_RETURN_VALUE:       eParType := ptResult;
          SQL_RESULT_COL:         lDeleteRow := True;
          end;
        oRow.SetData(8, Smallint(eParType));
        if (eParType = ptResult) and (cpUnifyParams in FStatementProps) then
          oRow.SetData(6, 'RESULT');
        iSize := 0;
        if FStatement.ColumnList.Count >= 14 then begin
          if FStatement.ColumnList[13].GetData(ARowIndex, pData, iSize) and (iSize > 0) then
            Include(eAttrs, caDefault);
        end;
        iSize := 0;
        if not FStatement.ColumnList[11].GetData(ARowIndex, pData, iSize) or
           (PSQLSmallint(pData)^ <> SQL_NO_NULLS) then
          Include(eAttrs, caAllowNull);
        iSize := 0;
        if FStatement.ColumnList[5].GetData(ARowIndex, pData, iSize) then
          iODBCType := PSQLSmallint(pData)^
        else
          iODBCType := SQL_TYPE_NULL;
        sType := FStatement.ColumnList[6].AsStrings[ARowIndex];
        if (sType <> '') and
           ((iODBCType = SQL_SS_TABLE) or (iODBCType = SQL_SS_UDT) or (iODBCType = SQL_SS_XML)) and
           (oConnMeta.Kind = TFDRDBMSKinds.MSSQL) and (FStatement.ColumnList.Count >= 21) then begin
          rName.FCatalog := FStatement.ColumnList[19].AsStrings[ARowIndex];
          rName.FSchema := FStatement.ColumnList[20].AsStrings[ARowIndex];
          rName.FObject := sType;
          sType := oConnMeta.EncodeObjName(rName, nil, [eoNormalize]);
        end;
        iSize := 0;
        if FStatement.ColumnList[7].GetData(ARowIndex, pData, iSize) then begin
          iODBCSize := PSQLInteger(pData)^;
          AdjustMaxVarLen(iODBCType, iODBCSize, False);
        end
        else
          iODBCSize := 0;
        iSize := 0;
        if FStatement.ColumnList[9].GetData(ARowIndex, pData, iSize) then
          iODBCDec := PSQLSmallint(pData)^
        else
          iODBCDec := 0;
        SQL2FDColInfo(iODBCType, False, sType, iODBCSize, iODBCDec, eType,
          eAttrs, iLen, iPrec, iScale);
        oRow.SetData(9, Smallint(eType));
        if sType <> '' then
          oRow.SetData(10, sType);
        oRow.SetData(11, PWord(@eAttrs)^);
        oRow.SetData(12, iPrec);
        oRow.SetData(13, iScale);
        oRow.SetData(14, iLen);
      end;
    end;
    if lDeleteRow then begin
      FDFree(oRow);
      Result := False;
    end
    else begin
      ATable.Rows.Add(oRow);
      Result := True;
    end;
  except
    FDFree(oRow);
    raise;
  end;
end;

end.
