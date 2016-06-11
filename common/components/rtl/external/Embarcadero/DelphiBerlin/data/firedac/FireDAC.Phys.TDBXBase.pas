{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC DBX 4 driver base classes           }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.TDBXBase;

interface

uses
  System.Classes, System.SyncObjs, Data.DBXCommon, Data.DBCommonTypes,
  FireDAC.Stan.Error, FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Util,
  FireDAC.DatS,
  FireDAC.Phys;

type
  ETDBXNativeException = class;
  TFDPhysTDBXBaseDriverLink = class;
  TFDPhysTDBXLib = class;
  TFDPhysTDBXDriverBase = class;
  TFDPhysTDBXConnectionBase = class;
  TFDPhysTDBXTransaction = class;
  TFDPhysTDBXCommand = class;

  ETDBXNativeException = class(EFDDBEngineException)
  public
    constructor Create(ADBXError: TDBXError; const ADriverName: String = ''); overload;
  end;

  TFDPhysTDBXBaseDriverLink = class(TFDPhysDriverLink)
  end;

  TFDPhysTDBXLib = class(TObject)
  private
    [weak] FOwningObj: TObject;
    FLock: TCriticalSection;
    FCurrentConnection: TFDPhysTDBXConnectionBase;
    class function GetRegistryFile(const Setting, Default: string): string;
    procedure DoError(ADBXError: TDBXError);
  public
    constructor Create(AOwningObj: TObject = nil);
    destructor Destroy; override;
    property OwningObj: TObject read FOwningObj;
  end;

  TFDPhysTDBXDriverBase = class(TFDPhysDriver)
  private
    FCfgFile: String;
    FLib: TFDPhysTDBXLib;
  protected
    procedure InternalLoad; override;
    procedure InternalUnload; override;
    function GetCliObj: Pointer; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); override;
    destructor Destroy; override;
    property CfgFile: String read FCfgFile;
    property Lib: TFDPhysTDBXLib read FLib;
  end;

  TFDPhysTDBXConnectionBase = class(TFDPhysConnection)
  private
    FDbxConnection: TDBXConnection;
    FRdbmsKind: TFDRDBMSKind;
    FCurrentCommand: TFDPhysTDBXCommand;
    FDBX4: Boolean;
    FEncoder: TFDEncoder;
{$IFDEF FireDAC_MONITOR}
    function DoTrace(TraceInfo: TDBXTraceInfo): CBRType;
{$ENDIF}
    procedure GetConnInterfaces;
    procedure SetConnParams;
    procedure DoError(ADBXError: TDBXError);
    function GetIsDS: Boolean;
    function GetTDBXDriver: TFDPhysTDBXDriverBase;
  protected
    FDriverName: String;
    procedure InternalConnect; override;
    procedure InternalDisconnect; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateTransaction: TFDPhysTransaction; override;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; override;
{$ENDIF}
    procedure InternalExecuteDirect(const ASQL: String;
      ATransaction: TFDPhysTransaction); override;
    procedure GetItem(AIndex: Integer; out AName: String;
      out AValue: Variant; out AKind: TFDMoniAdapterItemKind); override;
    function GetItemCount: Integer; override;
    function GetCliObj: Pointer; override;
    function InternalGetCliHandle: Pointer; override;
    // other
    function GetRDBMSKindFromAlias: TFDRDBMSKind;
    function GetKeywords: String;
    // introduced
    procedure CheckDBXDriver; virtual;
    procedure BuildDBXConnParams(const AConnectionDef: IFDStanConnectionDef;
      AConnProps: TDBXProperties); virtual;
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
    destructor Destroy; override;
    property DbxConnection: TDBXConnection read FDbxConnection;
    property DriverName: String read FDriverName;
    property IsDS: Boolean read GetIsDS;
    property TDBXDriver: TFDPhysTDBXDriverBase read GetTDBXDriver;
  end;

  TFDPhysTDBXTransaction = class(TFDPhysTransaction)
  private
    FTransactions: TFDStringList;
    function GetIsolationLevel: TDBXIsolation;
    function GetTDBXConn: TFDPhysTDBXConnectionBase;
  protected
    procedure InternalStartTransaction(AID: LongWord); override;
    procedure InternalCommit(AID: LongWord); override;
    procedure InternalRollback(AID: LongWord); override;
  public
    constructor Create(AConnection: TFDPhysConnection); override;
    destructor Destroy; override;
    property TDBXConn: TFDPhysTDBXConnectionBase read GetTDBXConn;
  end;

  TFDPhysTDBXCommand = class(TFDPhysCommand)
  private
    FDBXCommand: TDBXCommand;
    FDBXReader: TDBXReader;
    FReadersList: TFDObjList;
    FColumnIndex: Word;
    FParamChildPos: array of Word;
    FMetaForPackage: Boolean;
    procedure FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
    procedure GetParamValues(AParams: TFDParams; AGetDataSets: Boolean);
    procedure SetParamValues(AParams: TFDParams; AValueIndex: Integer);
    procedure CalcUnits(const AParams: TFDParams; const AIndex: Integer;
      var AChildPos: array of Word; var ASubItems: Integer);
    procedure OpenMetaInfo;
    function FetchMetaRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowIndex: Integer): Boolean;
    procedure Dbx2ADColInfo(ADbxType, ADbxSubType: TDBXType; ADbxPrec: Integer;
      ADbxScale: SmallInt; var AType: TFDDataType; var AAtrs: TFDDataAttributes;
      var ALen: LongWord; var APrec, AScale: Integer);
    function GetTDBXConn: TFDPhysTDBXConnectionBase;
    procedure AddCursor(AReader: TDBXReader);
    procedure DeleteCursor(AReader: TDBXReader);
  protected
    procedure InternalClose; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; override;
    function InternalOpen: Boolean; override;
    function InternalNextRecordSet: Boolean; override;
    procedure InternalPrepare; override;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; override;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; override;
    procedure InternalUnprepare; override;
    function GetCliObj: Pointer; override;
  public
    constructor Create(AConnectionObj: TFDPhysConnection);
    destructor Destroy; override;
    property TDBXConn: TFDPhysTDBXConnectionBase read GetTDBXConn;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils,
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry,
{$ENDIF}
  System.Types,
{$IFNDEF NEXTGEN}
  System.WideStrings,
{$ENDIF}
  Data.DBCommon, System.Variants, Data.DB, Data.FmtBcd, Data.SqlTimSt, System.IniFiles,
    Data.SqlConst, Data.DBXMetaDataNames, Data.DBXPool, Data.DBXTrace,
  FireDAC.Stan.Consts, FireDAC.Stan.Option, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs,
    FireDAC.Stan.SQLTimeInt,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.Meta;

const
  txi2dbxi: array[TFDTxIsolation] of TDBXIsolation = (TDBXIsolations.ReadCommitted,
    TDBXIsolations.DirtyRead, TDBXIsolations.ReadCommitted, TDBXIsolations.RepeatableRead,
    TDBXIsolations.SnapShot, TDBXIsolations.Serializable);
  dbxi2txi: array[0 .. TDBXIsolations.SnapShot] of TFDTxIsolation = (
    xiReadCommitted, xiRepeatableRead, xiDirtyRead, xiSnapshot, xiSerializible);

{-------------------------------------------------------------------------------}
{ ETDBXNativeException                                                          }
{-------------------------------------------------------------------------------}
constructor ETDBXNativeException.Create(ADBXError: TDBXError; const ADriverName: String);
var
  eKind: TFDCommandExceptionKind;
  s: string;
begin
  // if ADBXError.ErrorCode = TDBXErrorCodes.Warning, then set FInfo and do not raise
  if ADriverName = '' then
    s := '<unknown>'
  else
    s := ADriverName;
  inherited Create(er_FD_DBXGeneral,
    FDExceptionLayers([S_FD_LPhys, S_FD_TDBXId, s]) + ' ' + ADBXError.Message);
  case ADBXError.ErrorCode of
    TDBXErrorCodes.InvalidUserOrPassword: eKind := ekUserPwdInvalid;
    TDBXErrorCodes.ConnectionFailed:      eKind := ekServerGone;
    TDBXErrorCodes.OptimisticLockFailed:  eKind := ekRecordLocked;
    TDBXErrorCodes.NoTable:               eKind := ekObjNotExists;
    TDBXErrorCodes.Eof:                   eKind := ekNoDataFound;
    TDBXErrorCodes.NoData:                eKind := ekNoDataFound;
    else                                  eKind := ekOther;
  end;
  if Pos('user credentials', ADBXError.Message) > 0 then
    eKind := ekUserPwdInvalid;
  AppendError(1, ADBXError.ErrorCode, ADBXError.Message, '', eKind, -1, -1);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXLib                                                                }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDBXLib.Create(AOwningObj: TObject);
begin
  inherited Create;
  FOwningObj := AOwningObj;
  FLock := TCriticalSection.Create;
  TDBXConnectionFactory.GetConnectionFactory.OnError := DoError;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTDBXLib.Destroy;
begin
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXLib.DoError(ADBXError: TDBXError);
var
  oObj: TObject;
  sDrv: String;
  oExc: ETDBXNativeException;
begin
  if FCurrentConnection <> nil then begin
    oObj := FCurrentConnection;
    sDrv := FCurrentConnection.FDriverName;
  end
  else begin
    oObj := nil;
    sDrv := '';
  end;
  oExc := ETDBXNativeException.Create(ADBXError, sDrv);
  FDFree(ADBXError);
  FDException(oObj, oExc {$IFDEF FireDAC_Monitor}, False {$ENDIF});
end;

{-------------------------------------------------------------------------------}
class function TFDPhysTDBXLib.GetRegistryFile(const Setting, Default: string): string;
{$IFDEF MSWINDOWS}
var
  Reg: TRegistry;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(TDBXRegistryKey) then
      Result := Reg.ReadString(Setting)
    else
      Result := '';
    Result := FDGetBestPath('', Result, TDBXDriverFile);
  finally
    FDFree(Reg);
  end;
{$ENDIF}
{$IFDEF POSIX}
  Result := ExtractFileDir(ParamStr(0)) + '/' + Default;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXDriverBase                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDBXDriverBase.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  FLib := TFDPhysTDBXLib.Create;
  FCfgFile := FLib.GetRegistryFile(TDBXRegistryDriverValue, TDBXDriverFile);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTDBXDriverBase.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLib);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXDriverBase.InternalLoad;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXDriverBase.InternalUnload;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriverBase.GetCliObj: Pointer;
begin
  Result := FLib;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXDriverBase.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
begin
  Result := inherited GetConnParams(AKeys, AParams);

  Result.Rows.Add([Unassigned, S_FD_ConnParam_TDBX_DBXAdvanced, '@S', '', S_FD_ConnParam_TDBX_DBXAdvanced, -1]);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXConnectionBase                                                     }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDBXConnectionBase.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  inherited Create(ADriverObj, AConnHost);
  FDBX4 := True;
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTDBXConnectionBase.Destroy;
begin
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetTDBXDriver: TFDPhysTDBXDriverBase;
begin
  Result := TFDPhysTDBXDriverBase(DriverObj);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetRDBMSKindFromAlias: TFDRDBMSKind;
var
  oManMeta: IFDPhysManagerMetadata;
begin
  Result := FRdbmsKind;
  if Result = TFDRDBMSKinds.Unknown then begin
    FDPhysManager.CreateMetadata(oManMeta);
    Result := oManMeta.GetRDBMSKind(GetConnectionDef.AsString[S_FD_ConnParam_Common_RDBMS]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetKeywords: String;
var
  oCmd: TDBXCommand;
  oRdr: TDBXReader;
begin
  Result := '';
  if (DbxConnection <> nil) and DbxConnection.IsOpen and
     not IsDS then begin
    oCmd := nil;
    oRdr := nil;
    try
      oCmd := DbxConnection.CreateCommand;
      oCmd.CommandType := TDBXCommandTypes.DbxMetaData;
      oCmd.Text := TDBXMetaDataCommands.GetReservedWords;
      oRdr := oCmd.ExecuteQuery;
      while oRdr.Next do begin
        if Result <> '' then
          Result := Result + ',';
        case oRdr.Value[0].ValueType.DataType of
        TDBXDataTypes.WideStringType:
          Result := Result + String(oRdr.Value[0].GetWideString);
        TDBXDataTypes.AnsiStringType:
          Result := Result + String(oRdr.Value[0]. {$IFDEF NEXTGEN} GetString {$ELSE} GetAnsiString {$ENDIF});
        end;
      end;
    finally
      FDFree(oRdr);
      FDFree(oCmd);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetIsDS: Boolean;
begin
  Result := CompareText(DriverName, 'DataSnap') = 0;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysTDBXCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.InternalCreateTransaction: TFDPhysTransaction;
begin
  Result := TFDPhysTDBXTransaction.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.CheckDBXDriver;
begin
  FDriverName := FDUnquote(GetConnectionDef.AsString[TDBXPropertyNames.DriverName]);
  if FDriverName = '' then
    FDException(Self, [S_FD_LPhys, S_FD_TDBXId], er_FD_DBXParMBNotEmpty,
      [TDBXPropertyNames.DriverName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.DoError(ADBXError: TDBXError);
var
  oObj: TObject;
  oExc: ETDBXNativeException;
begin
  if FCurrentCommand <> nil then
    oObj := FCurrentCommand
  else
    oObj := Self;
  oExc := ETDBXNativeException.Create(ADBXError, FDriverName);
  FDFree(ADBXError);
  FDException(oObj, oExc {$IFDEF FireDAC_MONITOR}, GetTracing {$ENDIF});
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDPhysTDBXConnectionBase.DoTrace(TraceInfo: TDBXTraceInfo): CBRType;
var
  oObj: TObject;
begin
  if FCurrentCommand <> nil then
    oObj := FCurrentCommand
  else
    oObj := Self;
  GetMonitor.Notify(ekVendor, esProgress, oObj, TraceInfo.Message, []);
  Result := cbrUSEDEF;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.InternalTracingChanged;
begin
  TDBXConnectionFactory.GetConnectionFactory.OnTrace := nil;
  if FDbxConnection <> nil then
    if FTracing then
      FDbxConnection.OnTrace := DoTrace
    else
      FDbxConnection.OnTrace := nil;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.BuildDBXConnParams(const AConnectionDef: IFDStanConnectionDef;
  AConnProps: TDBXProperties);
var
  oConnDef: IFDStanDefinition;
begin
  oConnDef := AConnectionDef;
  while oConnDef <> nil do begin
    AConnProps.Properties.AddStrings(oConnDef.Params);
    oConnDef := oConnDef.ParentDefinition;
  end;
  AConnProps.Values[TDBXPropertyNames.DriverName] := FDUnquote(AConnProps.Values[TDBXPropertyNames.DriverName]);
  AConnProps.Values[TDBXPropertyNames.Database] := AConnectionDef.Params.ExpandedDatabase;
  AConnProps.Values[TDBXPropertyNames.UserName] := AConnectionDef.Params.UserName;
  AConnProps.Values[TDBXPropertyNames.Password] := AConnectionDef.Params.Password;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.GetConnInterfaces;
var
  oConnProps: TDBXProperties;
  oConnMeta: IFDPhysConnectionMetadata;
  s: String;
  i: Integer;
begin
  CreateMetadata(oConnMeta);
  TDBXDriver.Lib.FLock.Enter;
  TDBXDriver.Lib.FCurrentConnection := Self;
  oConnProps := TDBXProperties.Create;
  try
{$IFDEF FireDAC_MONITOR}
    if GetTracing then begin
      oConnProps.Values[TDBXPropertyNames.DelegateConnection] := C_FD_SysNamePrefix + 'TRC';
      oConnProps.Values[C_FD_SysNamePrefix + 'TRC.' + TDBXPropertyNames.DriverName] := 'DBXTrace';
      TDBXConnectionFactory.GetConnectionFactory.OnTrace := DoTrace;
    end;
{$ENDIF}

    BuildDBXConnParams(GetConnectionDef, oConnProps);

    if GetConnectionDef.HasValue(S_FD_ConnParam_TDBX_DBXAdvanced) then begin
      s := GetConnectionDef.AsString[S_FD_ConnParam_TDBX_DBXAdvanced];
      i := 1;
      while i <= Length(s) do
        oConnProps.Properties.Add(FDExpandStr(FDExtractFieldName(s, i)));
    end;

    FDbxConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection(oConnProps);

    FDbxConnection.OnErrorEvent := DoError;
{$IFDEF FireDAC_MONITOR}
    InternalTracingChanged;
{$ENDIF}
  finally
    FDFree(oConnProps);
    TDBXDriver.Lib.FCurrentConnection := nil;
    TDBXDriver.Lib.FLock.Leave;
  end;
  FDBX4 := (FDbxConnection.DatabaseMetaData is TDBXDatabaseMetaData) and
    (TDBXDatabaseMetaData(FDbxConnection.DatabaseMetaData).MetaDataVersion >= DBXVersion40);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.SetConnParams;
var
  s: String;
  iLevel: TDBXIsolation;
begin
  if GetConnectionDef.HasValue(AUTOCOMMIT_KEY) then
    GetTransaction.Options.AutoCommit := GetConnectionDef.AsBoolean[AUTOCOMMIT_KEY];
  s := Format(TRANSISOLATION_KEY, [FDriverName]);
  if GetConnectionDef.HasValue(s) then
    s := LowerCase(GetConnectionDef.AsString[s])
  else if GetConnectionDef.HasValue(TDBXPropertyNames.IsolationLevel) then
    s := LowerCase(GetConnectionDef.AsString[TDBXPropertyNames.IsolationLevel])
  else
    s := '';
  if s <> '' then begin
    if s = SREPEATREAD then
      iLevel := TDBXIsolations.RepeatableRead
    else if s = SDIRTYREAD then
      iLevel := TDBXIsolations.DirtyRead
    else if s = SREADCOMMITTED then
      iLevel := TDBXIsolations.ReadCommitted
    else
      iLevel := TDBXIsolations.RepeatableRead;
    GetTransaction.Options.Isolation := dbxi2txi[iLevel];
  end;
  if GetConnectionDef.HasValue(TRIMCHAR) then
    GetOptions.FormatOptions.StrsTrim := GetConnectionDef.AsBoolean[TRIMCHAR];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.InternalConnect;
begin
  CheckDBXDriver;
  GetConnInterfaces;
  SetConnParams;
  FRdbmsKind := GetRDBMSKindFromAlias;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.InternalDisconnect;
begin
  FDFreeAndNil(FDbxConnection);
  FRdbmsKind := TFDRDBMSKinds.Unknown;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.InternalExecuteDirect(const ASQL: String;
  ATransaction: TFDPhysTransaction);
var
  oCmd: TDBXCommand;
begin
  oCmd := FDbxConnection.CreateCommand;
  try
    oCmd.CommandType := TDBXCommandTypes.DbxSQL;
    oCmd.Text := ASQL;
    FDFree(oCmd.ExecuteQuery);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetCliObj: Pointer;
begin
  Result := FDbxConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.InternalGetCliHandle: Pointer;
begin
  if FDbxConnection <> nil then
    Result := @FDbxConnection
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionBase.GetItemCount: Integer;
begin
  Result := inherited GetItemCount;
  if (FDbxConnection <> nil) and (FDbxConnection is TDBXConnection) then
    Inc(Result, 2);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionBase.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
begin
  if AIndex < inherited GetItemCount then
    inherited GetItem(AIndex, AName, AValue, AKind)
  else
    case AIndex - inherited GetItemCount of
    0:
      begin
        AName := 'DBX product name';
        AKind := ikClientInfo;
        AValue := TDBXConnection(FDbxConnection).ProductName;
      end;
    1:
      begin
        AName := 'DBX product version';
        AKind := ikClientInfo;
        AValue := TDBXConnection(FDbxConnection).ProductVersion;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXTransaction                                                        }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDBXTransaction.Create(AConnection: TFDPhysConnection);
begin
  inherited Create(AConnection);
  FTransactions := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTDBXTransaction.Destroy;
begin
  FDFreeAndNil(FTransactions);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXTransaction.GetTDBXConn: TFDPhysTDBXConnectionBase;
begin
  Result := TFDPhysTDBXConnectionBase(ConnectionObj);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXTransaction.GetIsolationLevel: TDBXIsolation;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  TDBXConn.CreateMetadata(oConnMeta);
  if oConnMeta.Kind = TFDRDBMSKinds.MSAccess then
    Result := TDBXIsolations.ReadCommitted
  else
    Result := txi2dbxi[GetOptions.Isolation];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXTransaction.InternalStartTransaction(AID: LongWord);
begin
  FTransactions.AddObject(IntToStr(AID),
    TDBXConn.FDbxConnection.BeginTransaction(GetIsolationLevel));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXTransaction.InternalCommit(AID: LongWord);
var
  oTX: TDBXTransaction;
  i: Integer;
begin
  if FTransactions.Find(IntToStr(AID), i) then begin
    oTX := TDBXTransaction(FTransactions.Objects[i]);
    FTransactions.Delete(i);
    TDBXConn.FDbxConnection.CommitFreeAndNil(oTX);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXTransaction.InternalRollback(AID: LongWord);
var
  oTX: TDBXTransaction;
  i: Integer;
begin
  if FTransactions.Find(IntToStr(AID), i) then begin
    oTX := TDBXTransaction(FTransactions.Objects[i]);
    FTransactions.Delete(i);
    TDBXConn.FDbxConnection.RollbackFreeAndNil(oTX);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysTDBXCommand                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysTDBXCommand.Create(AConnectionObj: TFDPhysConnection);
begin
  inherited Create(AConnectionObj);
  FReadersList := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysTDBXCommand.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FReadersList);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.GetCliObj: Pointer;
begin
  Result := FDBXCommand;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.GetTDBXConn: TFDPhysTDBXConnectionBase;
begin
  Result := TFDPhysTDBXConnectionBase(FConnectionObj);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.CalcUnits(const AParams: TFDParams;
  const AIndex: Integer; var AChildPos: array of Word; var ASubItems: Integer);
var
  i, tmpSubItems: Integer;
  oBasePar, oPar: TFDParam;
begin
  i := AIndex + 1;
  ASubItems := 0;
  oBasePar := AParams[AIndex];
  while i < AParams.Count do begin
    oPar := AParams[i];
    if oBasePar.Position <> oPar.Position then
      Break;
    Inc(ASubItems);
    AChildPos[i] := i - AIndex;
    if oPar.DataType = ftADT then begin
      CalcUnits(AParams, i, AChildPos, tmpSubItems);
      ASubItems := ASubItems + tmpSubItems;
      Inc(i, tmpSubItems);
    end
    else
      Inc(i);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.SetParamValues(AParams: TFDParams; AValueIndex: Integer);
const
  FldTypeMap: array [TFDDataType] of TDBXType = (TDBXDataTypes.UnknownType,
    TDBXDataTypes.BooleanType,
    TDBXDataTypes.Int8Type,
      TDBXDataTypes.Int16Type, TDBXDataTypes.Int32Type, TDBXDataTypes.Int64Type,
    TDBXDataTypes.UInt8Type,
      TDBXDataTypes.UInt16Type, TDBXDataTypes.Uint32Type, TDBXDataTypes.Uint64Type,
    TDBXDataTypes.SingleType,
      TDBXDataTypes.DoubleType, TDBXDataTypes.DoubleType,
    TDBXDataTypes.CurrencyType,
      TDBXDataTypes.BcdType, TDBXDataTypes.BcdType,
    TDBXDataTypes.TimeStampType, TDBXDataTypes.TimeType, TDBXDataTypes.DateType, TDBXDataTypes.TimeStampType,
    TDBXDataTypes.IntervalType, TDBXDataTypes.IntervalType, TDBXDataTypes.IntervalType,
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType, TDBXDataTypes.BytesType,
    TDBXDataTypes.BlobType, TDBXDataTypes.BlobType, TDBXDataTypes.BlobType, TDBXDataTypes.BlobType,
    TDBXDataTypes.BlobType, TDBXDataTypes.BlobType, TDBXDataTypes.BlobType,
    TDBXDataTypes.BlobType,
    TDBXDataTypes.TableType, TDBXDataTypes.CursorType, TDBXDataTypes.AdtType,
      TDBXDataTypes.ArrayType, TDBXDataTypes.UnknownType,
    TDBXDataTypes.AnsiStringType, TDBXDataTypes.UnknownType);
  FldSubTypeMap: array[TFDDataType] of TDBXType = (0,
    0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0,
    TDBXDataTypes.MoneySubType, 0, 0,
    0, 0, 0, 0,
    0, 0, 0,
    0, 0, 0,
    TDBXDataTypes.BinarySubType, TDBXDataTypes.MemoSubType, TDBXDataTypes.WideMemoSubType, TDBXDataTypes.WideMemoSubType,
    TDBXDataTypes.HBinarySubType, TDBXDataTypes.HMemoSubType, TDBXDataTypes.WideMemoSubType,
    TDBXDataTypes.HBinarySubType,
    0, 0, 0, 0, 0,
    0, 0);
var
  i: Integer;
  iParType, iSubType: TDBXType;
  iInd, iPrec, iScale, iMaxPrecision, iMaxScale: Integer;
  iSize, iSrcDataLen, iDestDataLen: LongWord;
  eFieldType: TFieldType;
  eSrcDataType, eDestDataType: TFDDataType;
  oParam: TFDParam;
  pNilPtr: Pointer;
  oFmtOpts: TFDFormatOptions;
  eParamType: TParamType;
  iDbxIndex: Integer;
  oDbxParam: TDBXParameter;
  aBytes: TBytes;
  s: String;
{$IFNDEF NEXTGEN}
  sa: AnsiString;
{$ENDIF}
  rBCD: TBcd;
  oStr: TStream;
begin
  if (AParams = nil) or (AParams.Count = 0) or (GetMetaInfoKind <> mkNone) then
    Exit;
  oFmtOpts := GetOptions.FormatOptions;
  for i := 0 to AParams.Count - 1 do begin
    oParam := AParams[i];
    eParamType := oParam.ParamType;
    if oParam.DataType = ftUnknown then
      ParTypeUnknownError(oParam);

    oFmtOpts.ResolveFieldType('', oParam.DataTypeName, oParam.DataType, oParam.FDDataType,
      oParam.Size, oParam.Precision, oParam.NumericScale, eFieldType, iSize, iPrec, iScale,
      eSrcDataType, eDestDataType, False);
    if (AValueIndex > 0) and (oParam.ArrayType = atScalar) or oParam.IsObjects[AValueIndex] then
      iSrcDataLen := 0
    else
      iSrcDataLen := oParam.GetDataLength(AValueIndex);
    iDestDataLen := 0;
    // approximating destination data size and allocate buffer
    FBuffer.Extend(iSrcDataLen, iDestDataLen, eSrcDataType, eDestDataType);
    // fill buffer with value, converting it, if required
    if (AValueIndex > 0) and (oParam.ArrayType = atScalar) or
       oParam.IsNulls[AValueIndex] and (eParamType in [ptUnknown, ptInput]) then
      iInd := 1
    else begin
      iInd := 0;
      if not oParam.IsObjects[AValueIndex] then begin
        if eParamType in [ptUnknown, ptInput, ptInputOutput] then begin
          oParam.GetData(FBuffer.Ptr, AValueIndex);
          if eSrcDataType <> eDestDataType then
            oFmtOpts.ConvertRawData(eSrcDataType, eDestDataType, FBuffer.Ptr,
              iSrcDataLen, FBuffer.FBuffer, FBuffer.Size, iDestDataLen, TDBXConn.FEncoder);
        end
        else begin
          pNilPtr := nil;
          oFmtOpts.ConvertRawData(eSrcDataType, eDestDataType, nil,
            iSrcDataLen, pNilPtr, FBuffer.Size, iDestDataLen, TDBXConn.FEncoder);
          if eDestDataType in [dtWideString, dtWideMemo, dtXML, dtWideHMemo] then
            FillChar(FBuffer.Ptr^, iDestDataLen * SizeOf(WideChar), 0)
          else
            FillChar(FBuffer.Ptr^, iDestDataLen, 0)
        end;
      end;
    end;
    FParamChildPos[i] := 0;
    iParType := FldTypeMap[eDestDataType];
    iSubType := FldSubTypeMap[eDestDataType];
    if iParType = TDBXDataTypes.UnknownType then
      ParTypeMapError(oParam);
    iMaxPrecision := iDestDataLen;
    iMaxScale := 0;
    case iParType of
    TDBXDataTypes.BlobType,
    TDBXDataTypes.AnsiStringType,
    TDBXDataTypes.WideStringType,
    TDBXDataTypes.BytesType,
    TDBXDataTypes.VarBytesType:
      begin
        if LongWord(oParam.Size) < iDestDataLen then
          oParam.Size := iDestDataLen;
        iMaxPrecision := oParam.Size;
        if (iParType = TDBXDataTypes.WideStringType) or
           (iParType = TDBXDataTypes.BlobType) and (iSubType = TDBXDataTypes.WideMemoSubType) then
          iDestDataLen := iDestDataLen * SizeOf(WideChar);
        if (iDestDataLen = 0) and (eParamType in [ptUnknown, ptInput]) and oFmtOpts.StrsEmpty2Null then
          iInd := 1;
      end;
    TDBXDataTypes.BcdType:
      begin
        if iInd = 0 then begin
          if oParam.Precision < PBcd(FBuffer.Ptr)^.Precision then
            oParam.Precision := PBcd(FBuffer.Ptr)^.Precision;
          if (oParam.NumericScale < PBcd(FBuffer.Ptr)^.SignSpecialPlaces AND $3F) and
             not FDBcdIsDecimalPartEmpty(PBcd(FBuffer.Ptr)^) then
            oParam.NumericScale := PBcd(FBuffer.Ptr)^.SignSpecialPlaces AND $3F;
        end;
        if oParam.Precision <> 0 then begin
          iMaxPrecision := oParam.Precision;
          iMaxScale := oParam.NumericScale;
        end;
      end;
    TDBXDataTypes.CurrencyType:
      if oParam.Precision <> 0 then begin
        iMaxPrecision := oParam.Precision;
        iMaxScale := oParam.NumericScale;
      end
      else begin
        iMaxPrecision := 19;
        iMaxScale := 4;
      end;
    TDBXDataTypes.AdtType,
    TDBXDataTypes.ArrayType:
      CalcUnits(AParams, i, FParamChildPos, iMaxScale);
    else
      iMaxPrecision := 0;
      iMaxScale := 0;
    end;

    iDbxIndex := i - FParamChildPos[i];
    oDbxParam := FDBXCommand.Parameters[iDbxIndex];
    if oDbxParam = nil then
    begin
      oDbxParam := FDBXCommand.CreateParameter;
      FDBXCommand.Parameters.SetParameter(iDbxIndex, oDbxParam);
    end;

    oDbxParam.ChildPosition      := FParamChildPos[i];
    oDbxParam.ParameterDirection := TDBXParameterDirection(eParamType);
    oDbxParam.DataType           := iParType;
    oDbxParam.SubType            := iSubType;
    oDbxParam.Size               := iDestDataLen;
    oDbxParam.Precision          := iMaxPrecision;
    oDbxParam.Scale              := iMaxScale;
    if eParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      if iInd <> 0 then
        oDbxParam.Value.SetNull
      else if oParam.IsStreams[AValueIndex] then begin
        oStr := oParam.AsStreams[AValueIndex];
        if oStr = nil then
          UnsupParamObjError(oParam);
        oDbxParam.Value.SetStream(oStr, False);
      end
      else
        case eDestDataType of
        dtBoolean:
          oDbxParam.Value.SetBoolean(PBoolean(FBuffer.Ptr)^);
        dtSByte:
          oDbxParam.Value.SetInt8(PShortInt(FBuffer.Ptr)^);
        dtInt16:
          oDbxParam.Value.SetInt16(PSmallInt(FBuffer.Ptr)^);
        dtInt32:
          oDbxParam.Value.SetInt32(PInteger(FBuffer.Ptr)^);
        dtInt64:
          oDbxParam.Value.SetInt64(PInt64(FBuffer.Ptr)^);
        dtByte:
          oDbxParam.Value.SetUInt8(PByte(FBuffer.Ptr)^);
        dtUInt16:
          oDbxParam.Value.SetUInt16(PWord(FBuffer.Ptr)^);
        dtUInt32:
          oDbxParam.Value.SetInt32(PCardinal(FBuffer.Ptr)^);
        dtUInt64:
          oDbxParam.Value.SetInt64(PUInt64(FBuffer.Ptr)^);
        dtSingle:
          oDbxParam.Value.SetSingle(PSingle(FBuffer.Ptr)^);
        dtDouble:
          oDbxParam.Value.SetDouble(PDouble(FBuffer.Ptr)^);
        dtCurrency:
          begin
            CurrToBCD(PCurrency(FBuffer.Ptr)^, rBCD, iMaxPrecision, iMaxScale);
            oDbxParam.Value.SetBcd(rBCD);
          end;
        dtBCD,
        dtFmtBCD:
          oDbxParam.Value.SetBcd(PBcd(FBuffer.Ptr)^);
        dtDateTime:
          oDbxParam.Value.SetTimestamp(DateTimeToSQLTimeStamp(TimeStampToDateTime(
            MSecsToTimeStamp(PDateTimeRec(FBuffer.Ptr)^.DateTime))));
        dtTime:
          oDbxParam.Value.SetTime(PDateTimeRec(FBuffer.Ptr)^.Time);
        dtDate:
          oDbxParam.Value.SetDate(PDateTimeRec(FBuffer.Ptr)^.Date);
        dtDateTimeStamp:
          oDbxParam.Value.SetTimestamp(PSQLTimeStamp(FBuffer.Ptr)^);
        dtTimeIntervalFull,
        dtTimeIntervalYM,
        dtTimeIntervalDS:
          begin
            s := FDSQLTimeInterval2Str(PFDSQLTimeInterval(FBuffer.Ptr)^);
            oDbxParam.Value.SetString(s);
          end;
        dtAnsiString,
        dtMemo,
        dtHMemo:
          begin
{$IFDEF NEXTGEN}
            s := TDBXConn.FEncoder.Decode(FBuffer.Ptr, iDestDataLen div SizeOf(TFDAnsiChar), ecANSI);
            oDbxParam.Value.SetString(s);
{$ELSE}
            SetString(sa, PAnsiChar(FBuffer.Ptr), iDestDataLen div SizeOf(AnsiChar));
            oDbxParam.Value.SetAnsiString(sa);
{$ENDIF}
          end;
        dtWideString,
        dtWideMemo,
        dtXML,
        dtWideHMemo:
          begin
            SetString(s, PWideChar(FBuffer.Ptr), iDestDataLen div SizeOf(WideChar));
            oDbxParam.Value.SetWideString(s);
          end;
        dtByteString,
        dtBlob,
        dtHBlob,
        dtHBFile:
          begin
            SetLength(aBytes, iDestDataLen);
            Move(FBuffer.Ptr^, aBytes[0], iDestDataLen);
            oDbxParam.Value.SetDynamicBytes(0, aBytes, 0, iDestDataLen);
          end;
        dtGUID:
{$IFDEF NEXTGEN}
          oDbxParam.Value.SetString(GUIDToString(PGUID(FBuffer.Ptr)^));
{$ELSE}
          oDbxParam.Value.SetAnsiString(AnsiString(GUIDToString(PGUID(FBuffer.Ptr)^)));
{$ENDIF}
        else
          { dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef, dtParentRowRef,
            dtObject - unsupported }
          ASSERT(False);
        end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.GetParamValues(AParams: TFDParams; AGetDataSets: Boolean);
var
  i, iActive: Integer;
  eFieldType: TFieldType;
  iSize, iLen, iPos: LongWord;
  iPrec, iScale: Integer;
  eSrcDataType, eDestDataType: TFDDataType;
  oParam: TFDParam;
  oDbxParam: TDBXParameter;
{$IFDEF NEXTGEN}
  sb: TFDByteString;
{$ELSE}
  sa: AnsiString;
{$ENDIF}
  s: String;
  aBytes: TBytes;
  oExtStr, oIntStr: TStream;
  lExtStream: Boolean;
begin
  if (AParams = nil) or (AParams.Count = 0) or (GetMetaInfoKind <> mkNone) or
     (FBuffer.Ptr = nil) then
    Exit;
  iActive := 0;
  for i := 0 to AParams.Count - 1 do begin
    oParam := AParams[i];
    if (oParam.ParamType in [ptOutput, ptResult, ptInputOutput]) and
       (oParam.DataType <> ftCursor) then begin
      oDbxParam := FDBXCommand.Parameters[iActive];

      if oDbxParam.Value.IsNull then
        oParam.Value := Null

      else if oParam.IsStream then begin
        oExtStr := oParam.AsStream;
        lExtStream := (oExtStr <> nil) and
          not ((oExtStr is TDBXStream) {and (TOCILobLocatorStream(oExtStr).OwningObj = Self)});
        if (oParam.DataType <> ftStream) and not lExtStream or
           not (oDbxParam.DataType in [TDBXDataTypes.BlobType, TDBXDataTypes.AnsiStringType,
            TDBXDataTypes.WideStringType, TDBXDataTypes.BytesType, TDBXDataTypes.VarBytesType]) then
          UnsupParamObjError(oParam);
        oIntStr := oDbxParam.Value.GetStream;
        try
          if lExtStream then
            oExtStr.CopyFrom(oIntStr, -1)
          else
            oParam.AsStream := oIntStr;
        finally
          if lExtStream then
            FDFree(oIntStr);
        end;
      end

      else begin
        iLen := 0;
        case oParam.DataType of
        ftString,
        ftFixedChar,
        ftMemo,
        ftAdt,
        ftOraClob,
        ftParadoxOle,
        ftOraInterval:
          begin
{$IFDEF NEXTGEN}
            s := oDbxParam.Value.GetString;
            iLen := Length(s);
            if iLen <> 0 then begin
              sb := TDBXConn.FEncoder.Encode(s, ecANSI);
              Move(PByte(sb)^, FBuffer.Ptr^, iLen * SizeOf(TFDAnsiChar));
            end;
{$ELSE}
            sa := oDbxParam.Value.GetAnsiString;
            iLen := Length(sa);
            if iLen <> 0 then
              Move(sa[1], FBuffer.Ptr^, iLen * SizeOf(AnsiChar));
{$ENDIF}
            (PFDAnsiString(FBuffer.Ptr) + iLen * SizeOf(TFDAnsiChar))^ := TFDAnsiChar(#0);
          end;
        ftWideString,
        ftFixedWideChar,
        ftWideMemo,
        ftFmtMemo,
        ftDBaseOle:
          begin
            s := oDbxParam.Value.GetWideString;
            iLen := Length(s);
            if iLen <> 0 then
              Move(s[1], FBuffer.Ptr^, iLen * SizeOf(WideChar));
            PWideChar(NativeUInt(FBuffer.Ptr) + iLen * SizeOf(WideChar))^ := #0;
          end;
        ftSmallInt,
        ftWord:
          PSmallInt(FBuffer.Ptr)^ := oDbxParam.Value.GetInt16;
        ftAutoInc,
        ftInteger:
          PInteger(FBuffer.Ptr)^ := oDbxParam.Value.GetInt32;
        ftTime:
          PDateTimeRec(FBuffer.Ptr)^.Time := oDbxParam.Value.GetTime;
        ftDate:
          PDateTimeRec(FBuffer.Ptr)^.Date := oDbxParam.Value.GetDate;
        ftTimeStamp:
          PSQLTimeStamp(FBuffer.Ptr)^ := oDbxParam.Value.GetTimeStamp;
        ftBCD,
        ftFMTBCD:
          PBcd(FBuffer.Ptr)^ := oDbxParam.Value.GetBcd;
        ftCurrency:
          PCurrency(FBuffer.Ptr)^ := oDbxParam.Value.GetDouble;
        ftFloat:
          PDouble(FBuffer.Ptr)^ := oDbxParam.Value.GetDouble;
        ftBoolean:
          PBoolean(FBuffer.Ptr)^ := oDbxParam.Value.GetBoolean;
        ftBytes,
        ftVarBytes,
        ftBlob,
        ftGraphic,
        ftTypedBinary,
        ftOraBlob:
          begin
            iLen := LongWord(oDbxParam.Value.GetValueSize);
            if iLen = LongWord(-1) then begin
              iPos := 0;
              repeat
                SetLength(aBytes, Length(aBytes) + C_FD_DefPieceBuffLen);
                iLen := oDbxParam.Value.GetBytes(iPos, aBytes, 0, C_FD_DefPieceBuffLen);
                Inc(iPos, iLen);
              until iLen <> C_FD_DefPieceBuffLen;
              iLen := iPos;
            end
            else begin
              SetLength(aBytes, iLen);
              oDbxParam.Value.GetBytes(0, aBytes, 0, iLen);
            end;
            FBuffer.Check(iLen);
            Move(aBytes[0], FBuffer.Ptr^, iLen);
          end;
        ftDataSet:
          if AGetDataSets then
            AddCursor(oDbxParam.Value.GetDBXReader(False));
        end;
        if oParam.DataType <> ftDataSet then begin
          GetOptions.FormatOptions.ResolveFieldType('', oParam.DataTypeName, oParam.DataType,
            oParam.FDDataType, oParam.Size, oParam.Precision, oParam.NumericScale,
            eFieldType, iSize, iPrec, iScale, eSrcDataType, eDestDataType, False);
          if eSrcDataType <> eDestDataType then begin
            FBuffer.Extend(iLen, iLen, eDestDataType, eSrcDataType);
            GetOptions.FormatOptions.ConvertRawData(eDestDataType, eSrcDataType,
              FBuffer.Ptr, iLen, FBuffer.FBuffer, FBuffer.Size, iLen, TDBXConn.FEncoder);
          end;
          if (eSrcDataType in C_FD_VarLenTypes) and (iLen = 0) and
             GetOptions.FormatOptions.StrsEmpty2Null then
            oParam.Clear
          else
            oParam.SetData(FBuffer.Ptr, iLen, -1);
        end;
      end;
    end;
    Inc(iActive);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.InternalPrepare;
var
  rName: TFDPhysParsedName;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  if GetMetaInfoKind = mkNone then begin
    if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
      GetConnection.CreateMetadata(oConnMeta);

      oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, []);
      FDbCommandText := '';
      if fiMeta in GetOptions.FetchOptions.Items then
        GenerateStoredProcParams(rName);

      if TDBXConn.IsDS then
        FDbCommandText := oConnMeta.EncodeObjName(rName, Self, [])
      else
        FDbCommandText := rName.FObject;
    end
    else begin
      // adjust SQL command
      GenerateLimitSelect();
      if GetCommandKind = skUnknown then
        SetCommandKind(skSelect);
    end;
    GenerateParamMarkers();
    FDBXCommand := TDBXConn.FDbxConnection.CreateCommand;
    if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then
      if TDBXConn.IsDS then
        FDBXCommand.CommandType := TDBXCommandTypes.DSServerMethod
      else
        FDBXCommand.CommandType := TDBXCommandTypes.DbxStoredProcedure
    else
      FDBXCommand.CommandType := TDBXCommandTypes.DbxSQL;
    FDBXCommand.Text := FDbCommandText;
    FDBXCommand.Parameters.SetCount(GetParams.Count);
    TDBXConn.FCurrentCommand := Self;
    try
      FDBXCommand.Prepare;
    finally
      TDBXConn.FCurrentCommand := nil;
    end;
  end
  else
    SetCommandKind(skSelect);
  SetLength(FParamChildPos, GetParams.Count);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.InternalUnprepare;
begin
  if FDBXCommand = nil then
    Exit;
  InternalClose;
  FDFreeAndNil(FDBXCommand);
  SetLength(FParamChildPos, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.Dbx2ADColInfo(ADbxType, ADbxSubType: TDBXType;
  ADbxPrec: Integer; ADbxScale: SmallInt; var AType: TFDDataType;
  var AAtrs: TFDDataAttributes; var ALen: LongWord; var APrec, AScale: Integer);
var
  oFmtOpts: TFDFormatOptions;
begin
  AType := dtUnknown;
  ALen := 0;
  APrec := 0;
  AScale := 0;
  AAtrs := [caSearchable];
  case ADbxType of
  TDBXDataTypes.AnsiStringType:
    begin
      AType := dtAnsiString;
      if ADbxPrec < 0 then
        ALen := 0
      else
        ALen := ADbxPrec;
      if ADbxSubType = TDBXDataTypes.FixedSubType then
        Include(AAtrs, caFixedLen);
    end;
  TDBXDataTypes.WideStringType:
    begin
      AType := dtWideString;
      if ADbxPrec < 0 then
        ALen := 0
      else
        ALen := ADbxPrec;
      if ADbxSubType = TDBXDataTypes.FixedSubType then
        Include(AAtrs, caFixedLen);
    end;
  TDBXDataTypes.DateType:
    AType := dtDate;
  TDBXDataTypes.BinaryBlobType,
  TDBXDataTypes.BlobType:
    begin
      case ADbxSubType of
      TDBXDataTypes.MemoSubType:     AType := dtMemo;
      TDBXDataTypes.WideMemoSubType: AType := dtWideMemo;
      TDBXDataTypes.HMemoSubType:    AType := dtHMemo;
      TDBXDataTypes.BinarySubType:   AType := dtBlob;
      TDBXDataTypes.HBinarySubType:  AType := dtHBlob;
      TDBXDataTypes.BFileSubType:    AType := dtHBFile;
      else                           AType := dtBlob;
      end;
      if ADbxPrec = -1 then
        ALen := $7FFFFFFF
      else
        ALen := ADbxPrec;
      Include(AAtrs, caBlobData);
      Exclude(AAtrs, caSearchable);
    end;
  TDBXDataTypes.BooleanType:
    AType := dtBoolean;
  TDBXDataTypes.Int8Type:
    AType := dtSByte;
  TDBXDataTypes.UInt8Type:
    AType := dtByte;
  TDBXDataTypes.Int16Type:
    AType := dtInt16;
  TDBXDataTypes.UInt16Type:
    AType := dtUInt16;
  TDBXDataTypes.Int32Type:
    begin
      AType := dtInt32;
      if ADbxSubType = TDBXDataTypes.AutoIncSubType then begin
        Include(AAtrs, caAutoInc);
        Include(AAtrs, caAllowNull);
      end;
    end;
  TDBXDataTypes.Uint32Type:
    AType := dtUInt32;
  TDBXDataTypes.Int64Type:
    AType := dtInt64;
  TDBXDataTypes.Uint64Type:
    AType := dtUInt64;
  TDBXDataTypes.SingleType:
    AType := dtSingle;
  TDBXDataTypes.DoubleType:
    begin
      if ADbxSubType = TDBXDataTypes.MoneySubType then
        AType := dtCurrency
      else
        AType := dtDouble;
    end;
  TDBXDataTypes.BcdType:
    begin
      AScale := Abs(ADbxScale);
      if ADbxPrec < AScale then
        APrec := AScale
      else
        APrec := ADbxPrec;
      oFmtOpts := GetOptions.FormatOptions;
      if (APrec <= oFmtOpts.MaxBcdPrecision) and (AScale <= oFmtOpts.MaxBcdScale) then
        AType := dtBCD
      else
        AType := dtFmtBCD;
    end;
  TDBXDataTypes.CurrencyType:
    begin
      AScale := Abs(ADbxScale);
      if ADbxPrec < AScale then
        APrec := AScale
      else
        APrec := ADbxPrec;
      AType := dtCurrency;
    end;
  TDBXDataTypes.BytesType,
  TDBXDataTypes.VarBytesType:
    begin
      AType := dtByteString;
      ALen := ADbxPrec;
      if ADbxType = TDBXDataTypes.BytesType then
        Include(AAtrs, caFixedLen);
    end;
  TDBXDataTypes.TimeType:
    AType := dtTime;
  TDBXDataTypes.DateTimeType,
  TDBXDataTypes.TimeStampType:
    AType := dtDateTimeStamp;
  TDBXDataTypes.IntervalType:
    AType := dtTimeIntervalDS;
  TDBXDataTypes.CursorType:
    begin
      AType := dtCursorRef;
      Include(AAtrs, caAllowNull);
      Exclude(AAtrs, caSearchable);
    end;
  TDBXDataTypes.AdtType:
    begin
      AType := dtRowRef;
      Exclude(AAtrs, caSearchable);
    end;
  TDBXDataTypes.ArrayType:
    begin
      AType := dtArrayRef;
      Exclude(AAtrs, caSearchable);
    end;
  TDBXDataTypes.RefType:
    begin
      AType := dtRowRef;
      Exclude(AAtrs, caSearchable);
    end;
  TDBXDataTypes.TableType:
    begin
      AType := dtRowSetRef;
      Exclude(AAtrs, caSearchable);
    end;
  // Types:
  //   ObjectType
  //   CharArrayType
  //   DBXConnectionType
  //   VariantType
  //   TimeStampOffsetType
  //   JsonValueType
  //   CallbackType
  // SubTypes:
  //   AdtNestedTableSubType
  //   AdtDateSubType
  //   OracleTimeStampSubType
  //   OracleIntervalSubType
  //   UserSubType
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean;
begin
  Result := OpenBlocked;
  if Result then
    if ATabInfo.FSourceID = -1 then begin
      ATabInfo.FSourceName := GetCommandText;
      ATabInfo.FSourceID := 1;
      FColumnIndex := 1;
    end
    else begin
      ATabInfo.FSourceName := FDBXReader.ValueType[ATabInfo.FSourceID - 1].Name;
      ATabInfo.FSourceID := ATabInfo.FSourceID;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean;
var
  iCount: Integer;
  wType, wSubType: TDBXType;
  iPrec, iScale: Integer;
  oValType: TDBXValueType;
  oFmtOpts: TFDFormatOptions;
begin
  if AColInfo.FParentTableSourceID <> -1 then begin
    oValType := FDBXReader.ValueType[AColInfo.FParentTableSourceID - 1];
    wType := oValType.DataType;
    if (wType = TDBXDataTypes.CursorType) or (wType = TDBXDataTypes.AdtType) or
       (wType = TDBXDataTypes.ArrayType) or (wType = TDBXDataTypes.RefType) or
       (wType = TDBXDataTypes.TableType) then begin
      iPrec := oValType.Precision;
      if FColumnIndex > AColInfo.FParentTableSourceID + Integer(iPrec) then begin
        Result := False;
        Exit;
      end;
    end
    else begin;
      Result := False;
      Exit;
    end;
  end
  else begin
    iCount := FDBXReader.ColumnCount;
    if FColumnIndex > iCount then begin
      Result := False;
      Exit;
    end;
  end;

  oFmtOpts := GetOptions.FormatOptions;
  oValType := FDBXReader.ValueType[FColumnIndex - 1];
  AColInfo.FSourceName := oValType.Name;
  AColInfo.FSourceID := FColumnIndex;
  wType := oValType.DataType;
  wSubType := oValType.SubType;

  iPrec := 0;
  iScale := 0;
  AColInfo.FSourceTypeName := '';
  case wType of
  TDBXDataTypes.AnsiStringType,
  TDBXDataTypes.WideStringType,
  TDBXDataTypes.BytesType,
  TDBXDataTypes.VarBytesType:
    begin
      iPrec := oValType.Size;
      if iPrec = 0 then
        iPrec := oValType.Precision;
      if ((wType = TDBXDataTypes.AnsiStringType) or (wType = TDBXDataTypes.WideStringType)) and
         GetOptions.FormatOptions.StrsDivLen2 then
        iPrec := iPrec div 2;
    end;
  TDBXDataTypes.CurrencyType,
  TDBXDataTypes.BcdType:
    begin
      iPrec := oValType.Precision;
      iScale := oValType.Scale;
    end;
  TDBXDataTypes.AdtType,
  TDBXDataTypes.ArrayType,
  TDBXDataTypes.RefType,
  TDBXDataTypes.TableType:
    begin
      iScale := oValType.Scale;
      AColInfo.FSourceTypeName := FDBXReader.GetObjectTypeName(FColumnIndex - 1);
    end;
  end;
  Dbx2ADColInfo(wType, wSubType, iPrec, iScale, AColInfo.FSourceType,
    AColInfo.FAttrs, AColInfo.FLen, AColInfo.FPrec, AColInfo.FScale);

  AColInfo.FForceRemOpts := [];
  AColInfo.FForceAddOpts := [];
  if oValType.Nullable then
    Include(AColInfo.FAttrs, caAllowNull);
  if oValType.ReadOnly then
    Include(AColInfo.FAttrs, caReadOnly);
  if oValType.Searchable then
    Include(AColInfo.FAttrs, caSearchable);
  if oValType.AutoIncrement then begin
    Include(AColInfo.FAttrs, caAutoInc);
    Include(AColInfo.FAttrs, caAllowNull);
    Include(AColInfo.FForceAddOpts, coAfterInsChanged);
  end;

  if GetMetaInfoKind = mkNone then
    oFmtOpts.ResolveDataType(AColInfo.FSourceName, AColInfo.FSourceTypeName, AColInfo.FSourceType,
      AColInfo.FLen, AColInfo.FPrec, AColInfo.FScale, AColInfo.FType, AColInfo.FLen, True)
  else
    AColInfo.FType := AColInfo.FSourceType;
  Inc(FColumnIndex);
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.AddCursor(AReader: TDBXReader);
begin
  if AReader = nil then
    Exit;
  if FReadersList.IndexOf(AReader) = -1 then
    if AReader.ColumnCount > 0 then begin
      FReadersList.Add(AReader);
      if FDBXReader = nil then
        FDBXReader := TDBXReader(FReadersList[0]);
    end
    else
      FDFree(AReader);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.DeleteCursor(AReader: TDBXReader);
begin
  if AReader = nil then
    Exit;
  FReadersList.Remove(AReader);
  if FDBXReader = AReader then
    FDBXReader := nil;
  FDFree(AReader);
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.InternalOpen: Boolean;
var
  i, wCols: Word;
  wType: TDBXType;
  siPrec: SmallInt;
  oValType: TDBXValueType;
begin
  if FDBXReader = nil then begin
    if GetMetaInfoKind = mkNone then begin
      SetParamValues(GetParams, 0);
      if TDBXConn.FDbxConnection.DatabaseMetaData.SupportsRowSetSize then
        FDBXCommand.RowSetSize := GetOptions.FetchOptions.ActualRowsetSize;
      TDBXConn.FCurrentCommand := Self;
      try
        AddCursor(FDBXCommand.ExecuteQuery);
      finally
        TDBXConn.FCurrentCommand := nil;
      end;
      if GetState = csAborting then
        InternalClose
      else
        GetParamValues(GetParams, True);
    end
    else
      OpenMetaInfo;
    if FDBXReader <> nil then
      if FDBXReader.Closed then
        InternalClose
      else begin
        // check buffer space
        wCols := FDBXReader.ColumnCount;
        for i := 0 to wCols - 1 do begin
          oValType := FDBXReader.ValueType[i];
          wType := oValType.DataType;
          case wType of
          TDBXDataTypes.AnsiStringType,
          TDBXDataTypes.WideStringType,
          TDBXDataTypes.BytesType,
          TDBXDataTypes.VarBytesType:
            begin
              siPrec := oValType.Precision;
              // used for AnsiStr -> WideStr conversion, otherwise
              // buffer will have enough size
              FBuffer.Check(siPrec * SizeOf(WideChar));
            end;
          end;
        end;
      end;
  end;
  Result := (FDBXReader <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.InternalClose;
var
  i: Integer;
begin
  GetParamValues(GetParams, False);
  if not GetNextRecordSet and (FReadersList.Count > 0) then
    try
      for i := 0 to FReadersList.Count - 1 do
        FDFree(TDBXReader(FReadersList[i]));
    finally
      FReadersList.Clear;
      FDBXReader := nil;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.InternalNextRecordSet: Boolean;
begin
  DeleteCursor(FDBXReader);
  if FReadersList.Count > 0 then
    FDBXReader := TDBXReader(FReadersList[0])
  else
    AddCursor(FDBXCommand.GetNextReader);
  Result := FDBXReader <> nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
var
  i: Integer;
  iAffected: Int64;
begin
  ACount := 0;
  if GetMetaInfoKind = mkNone then
    for i := AOffset to ATimes - 1 do begin
      SetParamValues(GetParams, i);
      TDBXConn.FCurrentCommand := Self;
      try
        try
          AddCursor(FDBXCommand.ExecuteQuery);
        except
          on E: ETDBXNativeException do begin
            E.Errors[0].RowIndex := i;
            raise;
          end;
        end;
      finally
        TDBXConn.FCurrentCommand := nil;
        DeleteCursor(FDBXReader);
      end;
      if GetState <> csAborting then begin
        GetParamValues(GetParams, False);
        iAffected := FDBXCommand.RowsAffected;
        if iAffected <= -1 then
          iAffected := 0;
        Inc(ACount, iAffected);
      end
      else
        Break;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXCommand.FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  oCol: TFDDatSColumn;
  oRow: TFDDatSRow;
  j: Integer;
  llIsBlank: LongBool;
  C: Currency;
  pData: Pointer;
  iLen: LongWord;
  liOffset, liBlobLen: Int64;
  oTab: TFDDatSTable;
  oFmtOpts: TFDFormatOptions;
  oVal: TDBXValue;
  aBuff: TBytes;
  rBCD: TBcd;
  s: String;
{$IFDEF NEXTGEN}
  sb: TFDByteString;
{$ELSE}
  sa: AnsiString;
{$ENDIF}

  procedure DoWideString(AFixedLen: Boolean);
  begin
    s := oVal.GetWideString;
    pData := PWideChar(s);
    iLen := Length(s);
    if AFixedLen and oFmtOpts.StrsTrim then
      while (iLen > 0) and (PWideChar(pData)[iLen - 1] = ' ') do
        Dec(iLen);
    if (iLen = 0) and oFmtOpts.StrsEmpty2Null then
      llIsBlank := True;
  end;

  procedure DoAnsiString(AFixedLen: Boolean);
  begin
{$IFDEF NEXTGEN}
    sb := TDBXConn.FEncoder.Encode(oVal.GetString, ecANSI);
    iLen := Length(sb);
    pData := PByte(sb);
{$ELSE}
    sa := oVal.GetAnsiString;
    iLen := Length(sa);
    pData := PAnsiChar(sa);
{$ENDIF}
    if AFixedLen and oFmtOpts.StrsTrim then
      while (iLen > 0) and (PFDAnsiString(pData)[iLen - 1] = TFDAnsiChar(' ')) do
        Dec(iLen);
    if (iLen = 0) and oFmtOpts.StrsEmpty2Null then
      llIsBlank := True;
  end;

  procedure DoByteString(AFixedLen: Boolean);
  begin
    SetLength(aBuff, oVal.GetValueSize);
    pData := @aBuff[0];
    iLen := FDBXReader.ByteReader.GetBytes(oCol.SourceID - 1, 0, aBuff, 0,
      oVal.GetValueSize, llIsBlank);
    if AFixedLen and oFmtOpts.StrsTrim then
      while (iLen > 0) and (PByte(pData)[iLen - 1] = 0) do
        Dec(iLen);
    if not llIsBlank and (iLen = 0) and oFmtOpts.StrsEmpty2Null then
      llIsBlank := True;
  end;

begin
  oRow := ATable.NewRow(True);
  oFmtOpts := GetOptions.FormatOptions;
  try
    for j := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[j];
      if (oCol.SourceID > 0) and CheckFetchColumn(oCol.SourceDataType, oCol.Attributes) then begin
        llIsBlank := not (oCol.SourceDataType in [dtMemo, dtBlob, dtHMemo, dtHBlob,
                                                  dtHBFile, dtWideMemo, dtXML, dtWideHMemo,
                                                  dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef]) and
          FDBXReader.Value[oCol.SourceID - 1].IsNull;
        if not llIsBlank then begin
          pData := FBuffer.Ptr;
          iLen := oCol.Size;
          oVal := FDBXReader.Value[oCol.SourceID - 1];
          case oCol.SourceDataType of
          dtWideString:
            DoWideString(caFixedLen in oCol.Attributes);
          dtAnsiString:
            DoAnsiString(caFixedLen in oCol.Attributes);
          dtByteString:
            DoByteString(caFixedLen in oCol.Attributes);
          dtDate:
            PDateTimeRec(pData)^.Date := oVal.GetDate;
          dtTime:
            PDateTimeRec(pData)^.Time := oVal.GetTime;
          dtDateTimeStamp:
            PSQLTimeStamp(pData)^ := oVal.GetTimeStamp;
          dtTimeIntervalFull,
          dtTimeIntervalYM,
          dtTimeIntervalDS:
            PFDSQLTimeInterval(pData)^ := FDStr2SQLTimeInterval(oVal.GetString);
          dtBoolean:
            PBoolean(pData)^ := oVal.GetBoolean;
          dtSByte:
            PShortInt(pData)^ := oVal.GetInt8;
          dtByte:
            PByte(pData)^ := oVal.GetUInt8;
          dtInt16:
            PSmallInt(pData)^ := oVal.GetInt16;
          dtUInt16:
            PSmallInt(pData)^ := oVal.GetUInt16;
          dtInt32:
            PInteger(pData)^ := oVal.GetInt32;
          dtUInt32:
            PCardinal(pData)^ := oVal.GetInt32;
          dtInt64:
            PInt64(pData)^ := oVal.GetInt64;
          dtUInt64:
            PUInt64(pData)^ := oVal.GetInt64;
          dtCurrency:
            begin
              rBCD := oVal.GetBcd;
              BCDToCurr(rBCD, C);
              pData := @C;
            end;
          dtSingle:
            PSingle(pData)^ := oVal.GetSingle;
          dtDouble:
            PDouble(pData)^ := oVal.GetDouble;
          dtBCD,
          dtFmtBCD:
            PBcd(pData)^ := oVal.GetBcd;
          dtMemo,
          dtBlob,
          dtHMemo,
          dtHBlob,
          dtHBFile,
          dtWideMemo,
          dtXML,
          dtWideHMemo:
            if fiBlobs in GetOptions.FetchOptions.Items then
              case FDBXReader.ValueType[oCol.SourceID - 1].DataType of
              TDBXDataTypes.AnsiStringType:
                DoAnsiString(caFixedLen in oCol.Attributes);
              TDBXDataTypes.WideStringType:
                DoWideString(caFixedLen in oCol.Attributes);
              else
                FDBXReader.ByteReader.GetByteLength(oCol.SourceID - 1, liBlobLen, llIsBlank);
                if not llIsBlank then begin
                  // For DataSnap connections, blob size can be -1 for large streams
                  if liBlobLen = -1 then begin
                    liOffset := 0;
                    repeat
                      SetLength(aBuff, liOffset + C_FD_DefPieceBuffLen);
                      iLen := FDBXReader.ByteReader.GetBytes(oCol.SourceID - 1, liOffset, aBuff, liOffset,
                        C_FD_DefPieceBuffLen, llIsBlank);
                      liOffset := liOffset + iLen;
                    until iLen < C_FD_DefPieceBuffLen;
                    iLen := liOffset;
                    SetLength(aBuff, liOffset);
                    pData := @aBuff[0];
                  end
                  else begin
                    SetLength(aBuff, liBlobLen);
                    pData := @aBuff[0];
                    iLen := FDBXReader.ByteReader.GetBytes(oCol.SourceID - 1, 0, aBuff, 0,
                      liBlobLen, llIsBlank);
                  end;
                  case FDBXReader.ValueType[oCol.SourceID - 1].SubType of
                  TDBXDataTypes.WideMemoSubType:
                    iLen := iLen div SizeOf(WideChar);
                  end;
                end;
              end
            else
              Continue;
          dtRowRef, dtArrayRef:
            begin
              oTab := oCol.NestedTable;
              FetchRow(oTab, oRow);
            end;
          dtRowSetRef, dtCursorRef:
            if fiDetails in GetOptions.FetchOptions.Items then begin
                                                      
              ASSERT(False);
            end;
          else
            ASSERT(False);
          end;
        end;
        if not (oCol.SourceDataType in [dtRowRef, dtArrayRef, dtRowSetRef, dtCursorRef]) then begin
          if llIsBlank then
            oRow.SetData(j, nil, 0)
          else begin
            oFmtOpts.ConvertRawData(oCol.SourceDataType, oCol.DataType, pData,
              iLen, pData, FBuffer.Size, iLen, TDBXConn.FEncoder);
            oRow.SetData(j, pData, iLen);
          end;
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
function TFDPhysTDBXCommand.InternalFetchRowSet(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowsetSize: LongWord): LongWord;
var
  i: LongWord;
begin
  Result := 0;
  if GetMetaInfoKind <> mkNone then
    ARowsetSize := MaxInt;
  for i := 1 to ARowsetSize do begin
    if not FDBXReader.Next then
      Break;
    if GetMetaInfoKind = mkNone then begin
      FetchRow(ATable, AParentRow);
      Inc(Result);
    end
    else
      if FetchMetaRow(ATable, AParentRow, i - 1) then
        Inc(Result);
  end;
end;

{-------------------------------------------------------------------------------}
// Meta data handling

procedure TFDPhysTDBXCommand.OpenMetaInfo;
const
  eSQLUnique      = $0002;
  eSQLPrimaryKey  = $0004;
var
  sCmd: String;
  rName: TFDPhysParsedName;
  sPKName, sUKName: String;
  oCmd: TDBXCommand;
  oRdr: TDBXReader;
  wDbxIndexKind: Word;

  function GetObjWildcard(ANoObject, AObjectSepBySpace, AWildcardAllowed: Boolean;
    const AObjectToUse: String): String;
  var
    oConnMeta: IFDPhysConnectionMetadata;
    sPrev: String;
    rObjName: TFDPhysParsedName;
  begin
    TDBXConn.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self, [doUnquote]);
    if rName.FCatalog = '' then
      rName.FCatalog := GetCatalogName;
    if rName.FSchema = '' then
      rName.FSchema := GetSchemaName;
    if ANoObject then
      rName.FObject := '';
    if AObjectToUse <> '' then begin
      if rName.FBaseObject = '' then
        rName.FBaseObject := rName.FObject;
      rName.FObject := AObjectToUse;
    end;
    if AObjectSepBySpace then begin
      sPrev := rName.FObject;
      rName.FObject := '';
    end;
    Result := oConnMeta.EncodeObjName(rName, Self, [eoQuote]);
    if AWildcardAllowed then begin
      if GetWildcard <> '' then
        Result := Result + '.' + GetWildcard
      else if Result = '' then
        Result := Result + '.%';
    end;
    if AObjectSepBySpace and (sPrev <> '') then begin
      rObjName.FObject := sPrev;
      Result := Result + ' ' + oConnMeta.EncodeObjName(rObjName, Self, [eoQuote]);
      rName.FObject := sPrev;
    end;
  end;

begin
  sCmd := '';
  case GetMetaInfoKind of
  mkCatalogs:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetCatalogs;
  mkSchemas:
    if TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetProcedures
    else begin
      sCmd := TDBXMetaDataCommands.GetSchemas;
      if GetCatalogName <> '' then
        sCmd := sCmd + ' ' + GetCatalogName;
    end;
  mkTables:
    if not TDBXConn.IsDS then begin
      sCmd := TDBXMetaDataCommands.GetTables + ' ' + GetObjWildcard(False, False, True, '') + ' ';
      if tkTable in GetTableKinds then
        sCmd := sCmd + TDBXMetaDataTableTypes.Table + ';';
      if tkView in GetTableKinds then
        sCmd := sCmd + TDBXMetaDataTableTypes.View + ';';
      if tkSynonym in GetTableKinds then
        sCmd := sCmd + TDBXMetaDataTableTypes.Synonym + ';';
      if (osSystem in GetObjectScopes) and (tkTable in GetTableKinds) then
        sCmd := sCmd + TDBXMetaDataTableTypes.SystemTable + ';';
      // TDBXTableTypeParser.ParseTableTypes does not support SystemView
{
      if (osSystem in GetObjectScopes) and (tkView in GetTableKinds) then
        sCmd := sCmd + TDBXMetaDataTableTypes.SystemView + ';';
}
    end;
  mkTableFields:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetColumns + ' ' + GetObjWildcard(False, False, True, '');
  mkIndexes:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetIndexes + ' ' + GetObjWildcard(False, False, False, '');
  mkIndexFields:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetIndexColumns + ' ' + GetObjWildcard(False, True, False, '');
  mkPrimaryKey:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetIndexes + ' ' + GetObjWildcard(False, False, False, '');
  mkPrimaryKeyFields:
    if not TDBXConn.IsDS then begin
      sPKName := '';
      sUKName := '';
      oCmd := nil;
      oRdr := nil;
      try
        oCmd := TDBXConn.FDbxConnection.CreateCommand;
        oCmd.CommandType := TDBXCommandTypes.DbxMetaData;
        oCmd.Text := TDBXMetaDataCommands.GetIndexes + ' ' + GetObjWildcard(True, False, False, '');
        TDBXConn.FCurrentCommand := Self;
        try
          oRdr := oCmd.ExecuteQuery;
        finally
          TDBXConn.FCurrentCommand := nil;
        end;
        if oRdr <> nil then
          while oRdr.Next and (sPKName = '') do
            if TDBXConn.FDBX4 then begin
              if oRdr.Value[TDBXIndexesIndex.IsPrimary].GetBoolean then
                sPKName := oRdr.Value[TDBXIndexesIndex.IndexName].GetWideString
              else if oRdr.Value[TDBXIndexesIndex.IsUnique].GetBoolean then
                sUKName := oRdr.Value[TDBXIndexesIndex.IndexName].GetWideString;
            end
            else begin
              wDbxIndexKind := oRdr.Value[8].GetInt32;
              if wDbxIndexKind and eSQLPrimaryKey <> 0 then
                sPKName := String(oRdr.Value[4].{$IFDEF NEXTGEN} GetString {$ELSE} GetAnsiString {$ENDIF})
              else if wDbxIndexKind and eSQLUnique <> 0 then
                sUKName := String(oRdr.Value[4].{$IFDEF NEXTGEN} GetString {$ELSE} GetAnsiString {$ENDIF});
            end;
      finally
        FDFree(oRdr);
        FDFree(oCmd);
      end;
      if sPKName <> '' then
        sCmd := TDBXMetaDataCommands.GetIndexColumns + ' ' + GetObjWildcard(False, True, False, sPKName)
      else if sUKName <> '' then
        sCmd := TDBXMetaDataCommands.GetIndexColumns + ' ' + GetObjWildcard(False, True, False, sUKName);
    end;
  mkForeignKeys:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetForeignKeys + ' ' + GetObjWildcard(False, False, False, '');
  mkForeignKeyFields:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetForeignKeyColumns + ' ' + GetObjWildcard(False, True, False, '');
  mkPackages:
    if not TDBXConn.IsDS then
      sCmd := TDBXMetaDataCommands.GetPackages + ' ' + GetObjWildcard(False, False, True, '');
  mkProcs:
    begin
      sCmd := GetObjWildcard(False, False, True, '');
      FMetaForPackage := rName.FBaseObject <> '';
      if FMetaForPackage then
        sCmd := TDBXMetaDataCommands.GetPackageProcedures + ' ' + sCmd
      else
        sCmd := TDBXMetaDataCommands.GetProcedures + ' ' + sCmd;
    end;
  mkProcArgs:
    begin
      sCmd := GetObjWildcard(False, False, False, '');
      FMetaForPackage := rName.FBaseObject <> '';
      if FMetaForPackage then
        sCmd := TDBXMetaDataCommands.GetPackageProcedureParameters + ' ' + sCmd
      else
        sCmd := TDBXMetaDataCommands.GetProcedureParameters + ' ' + sCmd;
    end;
  mkGenerators,
  mkResultSetFields,
  mkTableTypeFields:
    ;
  end;
  if sCmd <> '' then begin
    FDBXCommand := TDBXConn.FDbxConnection.CreateCommand;
    FDBXCommand.CommandType := TDBXCommandTypes.DbxMetaData;
    FDBXCommand.Text := sCmd;
    TDBXConn.FCurrentCommand := Self;
    try
      AddCursor(FDBXCommand.ExecuteQuery);
    finally
      TDBXConn.FCurrentCommand := nil;
    end;
  end
  else
    FDBXReader := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXCommand.FetchMetaRow(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowIndex: Integer): Boolean;
const
  C_Asc: String = 'ASC';
  C_Desc: String = 'DESC';
var
  oRow: TFDDatSRow;
  iDbxPrec: Integer;
  siDbxScale: SmallInt;
  wDbxDataType, wDbxSubType: Word;
  eType: TFDDataType;
  eAttrs: TFDDataAttributes;
  iLen: LongWord;
  iPrec, iScale: Integer;
  iRecNo: Integer;
  eProcType: TFDPhysProcedureKind;
  eTableKind: TFDPhysTableKind;
  eScope: TFDPhysObjectScope;
  eParamType: TParamType;
  eIndexKind: TFDPhysIndexKind;
  sSchema: String;
  lDeleteRow: Boolean;
  oConnMeta: IFDPhysConnectionMetadata;
  s: String;
  i: Integer;
  oVal: TDBXValue;

  procedure SetData(ACrsColIndex, ARowColIndex: Integer);
  var
    oVal: TDBXValue;
    s: String;
  begin
    oVal := FDBXReader.Value[ACrsColIndex];
    if oVal.IsNull then
      oRow.SetData(ARowColIndex, nil, 0)
    else
      case oRow.Table.Columns.ItemsI[ARowColIndex].DataType of
      dtInt16:
        begin
          case oVal.ValueType.DataType of
          TDBXDataTypes.Int16Type:  PSmallInt(FBuffer.Ptr)^ := oVal.GetInt16;
          TDBXDataTypes.UInt16Type: PSmallInt(FBuffer.Ptr)^ := Word(oVal.GetInt16);
          TDBXDataTypes.Int32Type:  PSmallInt(FBuffer.Ptr)^ := oVal.GetInt32;
          TDBXDataTypes.Uint32Type: PSmallInt(FBuffer.Ptr)^ := Cardinal(oVal.GetInt32);
          else ASSERT(False);
          end;
          oRow.SetData(ARowColIndex, FBuffer.Ptr, 0);
        end;
      dtInt32:
        begin
          case oVal.ValueType.DataType of
          TDBXDataTypes.Int16Type:  PInteger(FBuffer.Ptr)^ := oVal.GetInt16;
          TDBXDataTypes.UInt16Type: PInteger(FBuffer.Ptr)^ := Word(oVal.GetInt16);
          TDBXDataTypes.Int32Type:  PInteger(FBuffer.Ptr)^ := oVal.GetInt32;
          TDBXDataTypes.Uint32Type: PInteger(FBuffer.Ptr)^ := Cardinal(oVal.GetInt32);
          else ASSERT(False);
          end;
          oRow.SetData(ARowColIndex, FBuffer.Ptr, 0);
        end;
      dtWideString:
        begin
          case oVal.ValueType.DataType of
          TDBXDataTypes.WideStringType: s := oVal.GetWideString;
          TDBXDataTypes.AnsiStringType: s := String(oVal.
            {$IFDEF NEXTGEN} GetString {$ELSE} GetAnsiString {$ENDIF});
          else ASSERT(False);
          end;
          oRow.SetData(ARowColIndex, PWideChar(s), Length(s));
        end;
      else
        ASSERT(False);
      end;
  end;

  procedure GetScope(ARowColIndex: Integer; var AScope: TFDPhysObjectScope);
  var
    sSchema: String;
  begin
    sSchema := VarToStr(oRow.GetData(ARowColIndex, rvDefault));
    if TDBXConn.IsDS and
       ((CompareText(sSchema, 'DSAdmin') = 0) or
        (CompareText(sSchema, 'DSMetadata') = 0)) then
      AScope := osSystem
    else if not (npSchema in oConnMeta.NameParts) or TDBXConn.IsDS or
            (AnsiCompareText(sSchema, TDBXConn.GetCurrentSchema) = 0) then
      AScope := osMy
    else
      AScope := osOther;
  end;

  procedure SetObjectName(ACrs, ASchemaRow, AObjRow: Integer);
  var
    oConnMeta: IFDPhysConnectionMetadata;
    rName: TFDPhysParsedName;
    sObj: String;
  begin
    SetData(ACrs, AObjRow);
    if TDBXConn.IsDS then begin
      sObj := VarToStr(oRow.GetData(AObjRow));
      TDBXConn.CreateMetadata(oConnMeta);
      oConnMeta.DecodeObjName(sObj, rName, Self, [doUnquote]);
      if rName.FSchema <> '' then begin
        oRow.SetData(AObjRow, rName.FObject);
        oRow.SetData(ASchemaRow, rName.FSchema);
      end;
    end;
  end;

begin
  lDeleteRow := False;
  iRecNo := ATable.Rows.Count + 1;
  oRow := ATable.NewRow(True);
  try
    FConnection.CreateMetadata(oConnMeta);
    case GetMetaInfoKind of
    mkCatalogs:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXTablesIndex.CatalogName, 1);
      end;
    mkSchemas:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXTablesIndex.CatalogName, 1);
        SetData(TDBXTablesIndex.SchemaName, 2);
        if TDBXConn.IsDS then begin
          SetObjectName(TDBXProceduresIndex.ProcedureName, 2, 1);
          oRow.SetData(1, nil, 0);
          if (GetWildcard <> '') and
             not FDStrLike(VarToStr(oRow.GetData(2, rvDefault)), GetWildcard, True) then
            lDeleteRow := True
          else
            for i := 0 to ATable.Rows.Count - 1 do
              if VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault)) then begin
                lDeleteRow := True;
                Break;
              end;
        end;
      end;
    mkTables:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXTablesIndex.CatalogName, 1);
        SetData(TDBXTablesIndex.SchemaName, 2);
        SetObjectName(TDBXTablesIndex.TableName, 2, 3);
        GetScope(2, eScope);
        s := FDBXReader.Value[TDBXTablesIndex.TableType].GetWideString;
        if s = 'TABLE' then
          eTableKind := tkTable
        else if s = 'VIEW' then
          eTableKind := tkView
        else if s = 'SYNONYM' then
          eTableKind := tkSynonym
        else if s = 'SYSTEM_TABLE' then begin
          eTableKind := tkTable;
          eScope := osSystem;
        end
        else
          eTableKind := tkTable;
        oRow.SetData(4, SmallInt(eTableKind));
        oRow.SetData(5, SmallInt(eScope));
        lDeleteRow := not (eTableKind in GetTableKinds) or
                      not (eScope in GetObjectScopes);
      end;
    mkTableFields:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXColumnsIndex.CatalogName, 1);
        SetData(TDBXColumnsIndex.SchemaName, 2);
        SetObjectName(TDBXColumnsIndex.TableName, 2, 3);
        SetData(TDBXColumnsIndex.ColumnName, 4);
        SetData(TDBXColumnsIndex.Ordinal, 5);
        wDbxDataType := FDBXReader.Value[TDBXColumnsIndex.DbxDataType].GetInt32;
        iDbxPrec := FDBXReader.Value[TDBXColumnsIndex.Precision].GetInt32;
        siDbxScale := FDBXReader.Value[TDBXColumnsIndex.Scale].GetInt32;
        Dbx2ADColInfo(wDbxDataType, 0, iDbxPrec, siDbxScale,
          eType, eAttrs, iLen, iPrec, iScale);
        if FDBXReader.Value[TDBXColumnsIndex.IsNullable].GetBoolean then
          Include(eAttrs, caAllowNull);
        if FDBXReader.Value[TDBXColumnsIndex.IsAutoIncrement].GetBoolean then begin
          Include(eAttrs, caAutoInc);
          Include(eAttrs, caAllowNull);
        end;
        if FDBXReader.Value[TDBXColumnsIndex.IsFixedLength].GetBoolean then
          Include(eAttrs, caFixedLen);
        if not FDBXReader.Value[TDBXColumnsIndex.DefaultValue].IsNull then
          Include(eAttrs, caDefault);
        oRow.SetData(6, SmallInt(eType));
        oRow.SetData(8, PWord(@eAttrs)^);
        oRow.SetData(9, iPrec);
        oRow.SetData(10, iScale);
        oRow.SetData(11, iLen);
      end;
    mkPackages:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXPackagesIndex.CatalogName, 1);
        SetData(TDBXPackagesIndex.SchemaName, 2);
        SetObjectName(TDBXPackagesIndex.PackageName, 2, 3);
        sSchema := oRow.GetData(2, rvDefault);
        if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
            (sSchema, TDBXConn.GetConnectionDef.AsString[szUSERNAME]) = 0 then
          eScope := osMy
        else if (sSchema = 'SYS') or (sSchema = 'SYSTEM') then
          eScope := osSystem
        else
          eScope := osOther;
        oRow.SetData(4, Integer(eScope));
        lDeleteRow := not (eScope in GetObjectScopes);
      end;
    mkProcs:
      begin
        oRow.SetData(0, iRecNo);
        if FMetaForPackage then begin
          SetData(TDBXPackageProceduresIndex.CatalogName, 1);
          SetData(TDBXPackageProceduresIndex.SchemaName, 2);
          SetObjectName(TDBXPackageProceduresIndex.PackageName, 2, 3);
          SetData(TDBXPackageProceduresIndex.ProcedureName, 4);
          s := FDBXReader.Value[TDBXPackageProceduresIndex.ProcedureType].GetWideString;
        end
        else begin
          SetData(TDBXProceduresIndex.CatalogName, 1);
          SetData(TDBXProceduresIndex.SchemaName, 2);
          oRow.SetData(3, nil, 0);
          SetObjectName(TDBXProceduresIndex.ProcedureName, 2, 4);
          s := FDBXReader.Value[TDBXProceduresIndex.ProcedureType].GetWideString;
        end;
        oRow.SetData(5, nil, 0);
        GetScope(2, eScope);
        if s = 'PROCEDURE' then
          eProcType := pkProcedure
        else if s = 'FUNCTION' then
          eProcType := pkFunction
        else
          eProcType := pkProcedure;
        oRow.SetData(6, Integer(eProcType));
        oRow.SetData(7, SmallInt(eScope));
        oRow.SetData(8, nil, 0);
        oRow.SetData(9, nil, 0);
        lDeleteRow := not (eScope in GetObjectScopes);
      end;
    mkProcArgs:
      begin
        oRow.SetData(0, iRecNo);
        if FMetaForPackage then begin
          SetData(TDBXPackageProcedureParametersIndex.CatalogName, 1);
          SetData(TDBXPackageProcedureParametersIndex.SchemaName, 2);
          SetObjectName(TDBXPackageProcedureParametersIndex.PackageName, 2, 3);
          SetData(TDBXPackageProcedureParametersIndex.ProcedureName, 4);
          oRow.SetData(5, nil, 0);
          SetData(TDBXPackageProcedureParametersIndex.ParameterName, 6);
          SetData(TDBXPackageProcedureParametersIndex.Ordinal, 7);
          s := FDBXReader.Value[TDBXPackageProcedureParametersIndex.ParameterMode].GetWideString;
          if s = 'IN' then
            eParamType := ptInput
          else if s = 'OUT' then
            eParamType := ptOutput
          else if s = 'INOUT' then
            eParamType := ptInputOutput
          else if s = 'RESULT' then
            eParamType := ptResult
          else
            eParamType := ptUnknown;
          oRow.SetData(8, Integer(eParamType));
          SetData(TDBXPackageProcedureParametersIndex.TypeName, 10);
          wDbxDataType := FDBXReader.Value[TDBXPackageProcedureParametersIndex.DbxDataType].GetInt32;
          wDbxSubType := 0;
          iDbxPrec := FDBXReader.Value[TDBXPackageProcedureParametersIndex.Precision].GetInt32;
          siDbxScale := FDBXReader.Value[TDBXPackageProcedureParametersIndex.Scale].GetInt32;
          Dbx2ADColInfo(wDbxDataType, wDbxSubType, iDbxPrec, siDbxScale,
            eType, eAttrs, iLen, iPrec, iScale);
          if FDBXReader.Value[TDBXPackageProcedureParametersIndex.IsNullable].GetBoolean then
            Include(eAttrs, caAllowNull);
          if FDBXReader.Value[TDBXPackageProcedureParametersIndex.IsFixedLength].GetBoolean then
            Include(eAttrs, caFixedLen);
          oRow.SetData(9, SmallInt(eType));
          oRow.SetData(11, PWord(@eAttrs)^);
          oRow.SetData(12, iPrec);
          oRow.SetData(13, iScale);
          oRow.SetData(14, iLen);
        end
        else begin
          SetData(TDBXProcedureParametersIndex.CatalogName, 1);
          SetData(TDBXProcedureParametersIndex.SchemaName, 2);
          oRow.SetData(3, nil, 0);
          SetObjectName(TDBXProcedureParametersIndex.ProcedureName, 2, 4);
          oRow.SetData(5, nil, 0);
          SetData(TDBXProcedureParametersIndex.ParameterName, 6);
          SetData(TDBXProcedureParametersIndex.Ordinal, 7);
          s := FDBXReader.Value[TDBXProcedureParametersIndex.ParameterMode].GetWideString;
          if s = 'IN' then
            eParamType := ptInput
          else if s = 'OUT' then
            eParamType := ptOutput
          else if s = 'INOUT' then
            eParamType := ptInputOutput
          else if s = 'RESULT' then
            eParamType := ptResult
          else
            eParamType := ptUnknown;
          oRow.SetData(8, Integer(eParamType));
          SetData(TDBXProcedureParametersIndex.TypeName, 10);
          wDbxDataType := FDBXReader.Value[TDBXProcedureParametersIndex.DbxDataType].GetInt32;
          wDbxSubType := 0;
          oVal := FDBXReader.Value[TDBXProcedureParametersIndex.Precision];
          if oVal.ValueType.DataType = TDBXDataTypes.Int64Type then
            iDbxPrec := oVal.GetInt64
          else
            iDbxPrec := oVal.GetInt32;
          siDbxScale := FDBXReader.Value[TDBXProcedureParametersIndex.Scale].GetInt32;
          Dbx2ADColInfo(wDbxDataType, wDbxSubType, iDbxPrec, siDbxScale,
            eType, eAttrs, iLen, iPrec, iScale);
          if FDBXReader.Value[TDBXProcedureParametersIndex.IsNullable].GetBoolean then
            Include(eAttrs, caAllowNull);
          if FDBXReader.Value[TDBXProcedureParametersIndex.IsFixedLength].GetBoolean then
            Include(eAttrs, caFixedLen);
          oRow.SetData(9, SmallInt(eType));
          oRow.SetData(11, PWord(@eAttrs)^);
          oRow.SetData(12, iPrec);
          oRow.SetData(13, iScale);
          oRow.SetData(14, iLen);
        end;
        if TDBXConn.IsDS and
           (eParamType = ptOutput) and (CompareText(oRow.GetData(6), 'ReturnValue') = 0) then begin
          oRow.SetData(8, Integer(ptResult));
          if GetOptions.ResourceOptions.UnifyParams then
            oRow.SetData(6, 'Result');
        end;
      end;
    mkIndexes,
    mkPrimaryKey:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXIndexesIndex.CatalogName, 1);
        SetData(TDBXIndexesIndex.SchemaName, 2);
        SetObjectName(TDBXIndexesIndex.TableName, 2, 3);
        SetData(TDBXIndexesIndex.IndexName, 4);
        SetData(TDBXIndexesIndex.ConstraintName, 5);
        if FDBXReader.Value[TDBXIndexesIndex.IsPrimary].GetBoolean then
          eIndexKind := ikPrimaryKey
        else if FDBXReader.Value[TDBXIndexesIndex.IsUnique].GetBoolean then
          eIndexKind := ikUnique
        else
          eIndexKind := ikNonUnique;
        if GetMetaInfoKind = mkPrimaryKey then
          if TDBXConn.GetRDBMSKindFromAlias = TFDRDBMSKinds.MSAccess then begin
            if not (eIndexKind in [ikUnique, ikPrimaryKey]) then
              lDeleteRow := True
            else
              eIndexKind := ikPrimaryKey;
          end
          else if eIndexKind <> ikPrimaryKey then
            lDeleteRow := True;
        oRow.SetData(6, SmallInt(eIndexKind));
      end;
    mkPrimaryKeyFields,
    mkIndexFields:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXIndexColumnsIndex.CatalogName, 1);
        SetData(TDBXIndexColumnsIndex.SchemaName, 2);
        SetObjectName(TDBXIndexColumnsIndex.TableName, 2, 3);
        SetData(TDBXIndexColumnsIndex.IndexName, 4);
        SetData(TDBXIndexColumnsIndex.ColumnName, 5);
        SetData(TDBXIndexColumnsIndex.Ordinal, 6);
        if FDBXReader.Value[TDBXIndexColumnsIndex.IsAscending].GetBoolean then
          oRow.SetData(7, PWideChar(C_Asc), 3)
        else
          oRow.SetData(7, PWideChar(C_Desc), 4);
      end;
    mkForeignKeys:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXForeignKeysIndex.CatalogName, 1);
        SetData(TDBXForeignKeysIndex.SchemaName, 2);
        SetObjectName(TDBXForeignKeysIndex.TableName, 2, 3);
        SetData(TDBXForeignKeysIndex.ForeignKeyName, 4);
        oRow.SetData(5, nil, 0);
        oRow.SetData(6, nil, 0);
        oRow.SetData(7, nil, 0);
        oRow.SetData(8, Smallint(ckNone));
        oRow.SetData(9, Smallint(ckNone));
      end;
    mkForeignKeyFields:
      begin
        oRow.SetData(0, iRecNo);
        SetData(TDBXForeignKeyColumnsIndex.CatalogName, 1);
        SetData(TDBXForeignKeyColumnsIndex.SchemaName, 2);
        SetObjectName(TDBXForeignKeyColumnsIndex.TableName, 2, 3);
        SetData(TDBXForeignKeyColumnsIndex.ForeignKeyName, 4);
        SetData(TDBXForeignKeyColumnsIndex.ColumnName, 5);
        SetData(TDBXForeignKeyColumnsIndex.PrimaryColumnName, 6);
        SetData(TDBXForeignKeyColumnsIndex.Ordinal, 7);
      end;
    end;
    if lDeleteRow then begin
      FDFree(oRow);
      Result := False;
    end
    else begin
      if AParentRow <> nil then begin
        oRow.ParentRow := AParentRow;
        AParentRow.Fetched[ATable.Columns.ParentCol] := True;
      end;
      ATable.Rows.Add(oRow);
      Result := True;
    end;
  except
    FDFree(oRow);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TDBXNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := ETDBXNativeException.Create;
  ETDBXNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(ETDBXNativeException, 'TDBXNativeException',
    @TDBXNativeExceptionLoad, @FDExceptionSave);

end.
