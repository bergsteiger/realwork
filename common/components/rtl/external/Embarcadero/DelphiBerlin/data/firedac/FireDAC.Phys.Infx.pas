{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC Informix driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.Infx;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Option,
  FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCBase;

type
  TFDInfxError = class;
  EInfxNativeException = class;
  TFDPhysInfxDriverLink = class;

  /// <summary> The TFDInfxError object is a container for the information
  ///  pertaining to one Informix database error, warning, or message. One
  ///  or more TFDInfxError objects are included in the Errors property of
  ///  the EInfxNativeException object. Compared to TFDODBCNativeError, the
  ///  TFDInfxError class also comprises error attributes specific to the Informix. </summary>
  TFDInfxError = class(TFDODBCNativeError)
  private
    FISAMError: Integer;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    /// <summary> Returns a secondary error number called the ISAM error, which
    ///  may be generated in addition to the normal SQL error number. The ISAM
    ///  error gives additional information about why the SQL error occurred. </summary>
    property ISAMError: Integer read FISAMError;
  end;

  /// <summary> EInfxNativeException class representing a Informix driver exception.
  ///  Use this class to handle Informix driver specific exception. </summary>
  EInfxNativeException = class(EODBCNativeException)
  private
    function GetErrors(AIndex: Integer): TFDInfxError;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  public
    constructor Create(AStatus: SQLReturn; AOwner: TODBCHandle); override;
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String;
      AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError; override;
    /// <summary> Use the Errors property to get access to an error item from
    ///  the collection of errors, associated with this exception object. </summary>
    property Errors[Index: Integer]: TFDInfxError read GetErrors; default;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TFDPhysInfxDriverLink = class(TFDPhysODBCBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  public
    procedure GetServers(AList: TStrings);
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.Variants, Data.DB,
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry,
{$ENDIF}
{$IFDEF POSIX}
  System.IniFiles,
{$ENDIF}
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.InfxMeta,
    FireDAC.Phys.InfxDef;

type
  TFDPhysInfxDriver = class;
  TFDPhysInfxConnection = class;
  TFDPhysInfxCommand = class;
  TFDPhysInfxEventAlerter_DBMS_ALERT = class;

  IFDPhysInfxDriver = interface
    ['{A52C2247-E07C-4BEB-821B-6DF097828ED2}']
    // public
    procedure GetServers(AList: TStrings);
  end;

  TFDPhysInfxDriver = class(TFDPhysODBCDriverBase, IFDPhysInfxDriver)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
    // IFDPhysInfxDriver
    procedure GetServers(AList: TStrings);
  public
    function BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String; override;
  end;

  TFDPhysInfxConnection = class(TFDPhysODBCConnectionBase)
  private
    FServerVersion: TFDVersion;
    FTxSupported: Boolean;
    FWaitLock: Boolean;
  protected
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommandGenerator(const ACommand:
      IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); override;
    function GetExceptionClass: EODBCNativeExceptionClass; override;
    procedure InternalConnect; override;
  end;

  TFDPhysInfxCommand = class(TFDPhysODBCCommand)
  private
    procedure UpdateWaitLock;
  protected
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalOpen: Boolean; override;
  end;

  TFDPhysInfxEventAlerter_DBMS_ALERT = class(TFDPhysEventAlerter)
  private
    FWaitConnection: IFDPhysConnection;
    FWaitCommand: IFDPhysCommand;
    FWaitThread: TThread;
    FSignalCommand: IFDPhysCommand;
  protected
    // TFDPhysEventAlerter
    procedure DoFired;
    procedure InternalAllocHandle; override;
    procedure InternalReleaseHandle; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalUnregister; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  end;

{-------------------------------------------------------------------------------}
{ TFDInfxError                                                                  }
{-------------------------------------------------------------------------------}
procedure TFDInfxError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDInfxError then
    FISAMError := TFDInfxError(ASrc).FISAMError;
end;

{-------------------------------------------------------------------------------}
procedure TFDInfxError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FISAMError := AStorage.ReadInteger('ISAMError', 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDInfxError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteInteger('ISAMError', ISAMError, 0);
end;

{-------------------------------------------------------------------------------}
{ EInfxNativeException                                                          }
{-------------------------------------------------------------------------------}
constructor EInfxNativeException.Create(AStatus: SQLReturn;
  AOwner: TODBCHandle);
begin
  inherited Create(AStatus, AOwner);
  if (ErrorCode = SQL_ERROR) and (Kind = ekOther) then
    Errors[0].Kind := ekServerGone;
end;

{-------------------------------------------------------------------------------}
function EInfxNativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  sObj: String;
  oStmt: TODBCStatementBase;
  iISAMError: SQLInteger;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    // first (xxxx) - object name
    i1 := Pos('(', ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos(')', ADiagMessage, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  // ekUserPwdExpired
  // ekUserPwdWillExpire
  // ekNoDataFound
  // ekTooManyRows
  // ekArrExecMalfunc
  // ekInvalidParams
  // ekServerOutput

  sObj := AObject;
  // many Informix errors have object names
  ExtractObjName;

  iISAMError := 0;
  if AHandle is TODBCStatementBase then begin
    oStmt := TODBCStatementBase(AHandle);
    try
      oStmt.IgnoreErrors := True;
      iISAMError := oStmt.DIAG_INFX_ISAM_ERROR[ARecNum];
    finally
      oStmt.IgnoreErrors := False;
    end;
  end;

  case ANativeError of
  -951,
  -952,
  -11302,
  -11033:
    AKind := ekUserPwdInvalid;
  -206,
  -8300,
  -674,
  -9404,
  -319,
  -19804,
  -9992,
  -218,
  -634,
  -9628,
  -329:
    AKind := ekObjNotExists;
  -268:
    AKind := ekUKViolated;
  -691,
  -692:
    AKind := ekFKViolated;
  -233,
  -244,
  -245,
  -246,
  -263,
  -378:
    AKind := ekRecordLocked;
  -271:
    if iISAMError = -113 then
      AKind := ekRecordLocked;
  -908,
  -11020,
  -25580:
    AKind := ekServerGone;
  -11010:
    AKind := ekCmdAborted;
  end;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, AResultMessage, ACommandText, sObj, AKind, ACmdOffset, ARowIndex);
  TFDInfxError(Result).FISAMError := iISAMError;
end;

{-------------------------------------------------------------------------------}
function EInfxNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDInfxError;
end;

{-------------------------------------------------------------------------------}
function EInfxNativeException.GetErrors(AIndex: Integer): TFDInfxError;
begin
  Result := inherited Errors[AIndex] as TFDInfxError;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxDriverLink                                                         }
{-------------------------------------------------------------------------------}
function TFDPhysInfxDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_InfxId;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxDriverLink.GetServers(AList: TStrings);
var
  oDrv: IFDPhysInfxDriver;
begin
  if FDPhysManager.State = dmsInactive then
    FDPhysManager.Open;
  DriverIntf.Employ;
  try
    Supports(DriverIntf, IFDPhysInfxDriver, oDrv);
    oDrv.GetServers(AList);
  finally
    oDrv := nil;
    DriverIntf.Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxDriver                                                             }
{-------------------------------------------------------------------------------}
class function TFDPhysInfxDriver.GetBaseDriverID: String;
begin
  Result := S_FD_InfxId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysInfxDriver.GetBaseDriverDesc: String;
begin
  Result := 'Informix';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysInfxDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Informix;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysInfxDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysInfxConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxDriver.InternalLoad;
begin
  ODBCAdvanced := 'CURB=1;DLMT=y';
  inherited InternalLoad;
  if ODBCDriver = '' then
    ODBCDriver := FindBestDriver(
      [{$IF DEFINED(POSIX) OR DEFINED(FireDAC_32)} 'IBM INFORMIX ODBC DRIVER' {$ENDIF}
      {$IF DEFINED(MSWINDOWS) AND DEFINED(FireDAC_64)} 'IBM INFORMIX ODBC DRIVER (64-bit)' {$ENDIF}]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysInfxConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxDriver.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  AKeywords.Add(S_FD_ConnParam_Common_Server + '=SRVR');
  AKeywords.Add(S_FD_ConnParam_Common_Database);
  AKeywords.Add(S_FD_ConnParam_Common_CharacterSet + '=CLOC');
  AKeywords.Add(S_FD_ConnParam_Infx_DBCharacterSet + '=DLOC');
  AKeywords.Add(S_FD_ConnParam_Infx_ReadTimeout + '=RECVTIMEOUT');
  AKeywords.Add(S_FD_ConnParam_Infx_WriteTimeout + '=SENDTIMEOUT');
  AKeywords.Add('=CURB');
  AKeywords.Add('=HOST');
  AKeywords.Add('=SERV');
  AKeywords.Add('=PRO');
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxDriver.BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String;
var
  s: String;
begin
  Result := inherited BuildODBCConnectString(AConnectionDef);
  if AConnectionDef.HasValue(S_FD_ConnParam_Infx_StringFormat) then begin
    s := AConnectionDef.AsString[S_FD_ConnParam_Infx_StringFormat];
    if CompareText(s, S_FD_ANSI) = 0 then
      Result := Result + ';RCWC=0'
    else if CompareText(s, S_FD_Unicode) = 0 then
      Result := Result + ';RCWC=1';
  end;
  if not AConnectionDef.HasValue(S_FD_ConnParam_Infx_DBCharacterSet) then
    Result := Result + ';SDLOC=1';
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
  oList: TFDStringList;
  s: String;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('LoginIndex', 4);
    oView.Rows[0].EndEdit;
  end;

  oList := TFDStringList.Create(#0, ';');
  try
    GetServers(oList);
    s := oList.DelimitedText;
    if s = '' then
      s := '@S';
  finally
    FDFree(oList);
  end;
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, s, '', S_FD_ConnParam_Common_Server, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_CharacterSet, '@S', '', S_FD_ConnParam_Common_CharacterSet, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_DBCharacterSet, '@S', '', S_FD_ConnParam_Infx_DBCharacterSet, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_StringFormat, S_FD_Unicode + ';' + S_FD_ANSI, S_FD_ANSI, S_FD_ConnParam_Infx_StringFormat, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_ReadTimeout, '@I', '', S_FD_ConnParam_Infx_ReadTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_WriteTimeout, '@I', '', S_FD_ConnParam_Infx_WriteTimeout, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_TxSupported, S_FD_Yes + ';' + S_FD_No + ';' + S_FD_Choose, S_FD_Yes, S_FD_ConnParam_Infx_TxSupported, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_TxRetainLocks, '@Y', S_FD_Yes, S_FD_ConnParam_Infx_TxRetainLocks, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Infx_TxLastCommitted, '@Y', S_FD_Yes, S_FD_ConnParam_Infx_TxLastCommitted, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxDriver.GetServers(AList: TStrings);
{$IFDEF MSWINDOWS}
var
  oReg: TRegistry;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  oReg := TRegistry.Create;
  AList.BeginUpdate;
  try
    oReg.RootKey := HKEY_LOCAL_MACHINE;
    if oReg.OpenKey('SOFTWARE\Informix\SqlHosts', False) then
      oReg.GetKeyNames(AList)
    else
      AList.Clear;
  finally
    AList.EndUpdate;
    FDFree(oReg);
  end;
{$ENDIF}
{$IFDEF POSIX}
  AList.Clear;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxConnection                                                         }
{-------------------------------------------------------------------------------}
function TFDPhysInfxConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysInfxCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  if CompareText(AEventKind, S_FD_EventKind_Infx_DBMS_ALERT) = 0 then
    Result := TFDPhysInfxEventAlerter_DBMS_ALERT.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysInfxCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysInfxCommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
  oParams: TFDPhysInfxConnectionDefParams;
begin
  GetVersions(iSrvVer, iClntVer);
  oParams := ConnectionDef.Params as TFDPhysInfxConnectionDefParams;
  Result := TFDPhysInfxMetadata.Create(Self, FServerVersion, iClntVer, GetKeywords,
    oParams.StringFormat = sfUnicode, FTxSupported);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnection.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize, AByteSize: Integer);
begin
  // char - 32767
  // varchar - 255
  // nchar - 32767
  // nvarchar - 255
  // lvarchar - 32739
  case AStrDataType of
  SQL_C_CHAR,
  SQL_C_BINARY:
    begin
      if AFixedLen then
        AByteSize := 254
      else
        AByteSize := 32738;
      ACharSize := AByteSize;
    end;
  SQL_C_WCHAR:
    begin
      if AFixedLen then
        AByteSize := 254
      else
        AByteSize := 32738;
      ACharSize := AByteSize div SizeOf(SQLWChar);
    end;
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_InfxId]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxConnection.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := EInfxNativeException;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxConnection.InternalConnect;
var
  oPars: TFDPhysInfxConnectionDefParams;
  oStmt: TODBCCommandStatement;
  oCol: TODBCColumn;
  pData: SQLPointer;
  iSize: SQLLen;
begin
  inherited InternalConnect;
  oPars := TFDPhysInfxConnectionDefParams(ConnectionDef.Params);

  // Informix ODBC return wrong info by SQL_DBMS_VER
  oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
  try
    oStmt.Open(1, 'SELECT FIRST 1 dbinfo(''version'', ''full'') FROM systables');
    oCol := oStmt.AddCol(1, SQL_VARCHAR, SQL_C_WCHAR, 255);
    oStmt.Fetch(1);
    FServerVersion := FDVerStr2Int(oCol.AsStrings[0]);
  finally
    FDFree(oStmt);
  end;

  FTxSupported := True;
  if oPars.TxSupported = tsChoose then begin
    oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
    try
      oStmt.Open(1, 'SELECT a.is_logging FROM sysmaster:sysdatabases a ' +
        'WHERE LOWER(a.name) = ''' + LowerCase(oPars.Database) + '''');
      oCol := oStmt.AddCol(1, SQL_INTEGER, SQL_C_SLONG);
      oStmt.Fetch(1);
      if oCol.GetData(0, pData, iSize, True) then
        FTxSupported := PSQLInteger(pData)^ <> 0;
    finally
      FDFree(oStmt);
    end;
  end
  else
    FTxSupported := oPars.TxSupported = tsYes;

  if (InternalGetSharedCliHandle() = nil) and FTxSupported then begin
    if oPars.TxRetainLocks then
      InternalExecuteDirect('SET ENVIRONMENT RETAINUPDATELOCKS ''ALL''', nil);
    if (FServerVersion >= ivInfx1110) and oPars.TxLastCommitted then
      InternalExecuteDirect('SET ENVIRONMENT USELASTCOMMITTED ''ALL''', nil);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxCommand                                                            }
{-------------------------------------------------------------------------------}
procedure TFDPhysInfxCommand.UpdateWaitLock;
var
  s: String;
begin
  TFDPhysInfxConnection(ODBCConnection).FWaitLock := FOptions.UpdateOptions.LockWait;
  if TFDPhysInfxConnection(ODBCConnection).FWaitLock then
    s := 'SET LOCK MODE TO WAIT 60'
  else
    s := 'SET LOCK MODE TO NOT WAIT';
  TFDPhysInfxConnection(ODBCConnection).InternalExecuteDirect(s, nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  if FOptions.UpdateOptions.LockWait <> TFDPhysInfxConnection(ODBCConnection).FWaitLock then
    UpdateWaitLock;
  inherited InternalExecute(ATimes, AOffset, ACount);
end;

{-------------------------------------------------------------------------------}
function TFDPhysInfxCommand.InternalOpen: Boolean;
begin
  if FOptions.UpdateOptions.LockWait <> TFDPhysInfxConnection(ODBCConnection).FWaitLock then
    UpdateWaitLock;
  Result := inherited InternalOpen;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxEventThread                                                        }
{-------------------------------------------------------------------------------}
type
  TFDPhysInfxEventThread = class(TThread)
  private
    [weak] FAlerter: TFDPhysInfxEventAlerter_DBMS_ALERT;
  protected
    procedure Execute; override;
  public
    constructor Create(AAlerter: TFDPhysInfxEventAlerter_DBMS_ALERT);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysInfxEventThread.Create(AAlerter: TFDPhysInfxEventAlerter_DBMS_ALERT);
begin
  inherited Create(False);
  FAlerter := AAlerter;
  FreeOnTerminate := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysInfxEventThread.Destroy;
begin
  FAlerter.FWaitThread := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventThread.Execute;
begin
  while not Terminated and FAlerter.IsRunning do
    try
      FAlerter.FWaitCommand.Execute();
      if not Terminated then
        FAlerter.DoFired;
    except
      on E: EFDDBEngineException do
        if E.Kind <> ekCmdAborted then begin
          Terminate;
          FAlerter.AbortJob;
        end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxEventMessage_DBMS_ALERT                                            }
{-------------------------------------------------------------------------------}
type
  TFDPhysInfxEventMessage_DBMS_ALERT = class(TFDPhysEventMessage)
  private
    FName,
    FMessage: String;
  public
    constructor Create(const AName, AMessage: String);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysInfxEventMessage_DBMS_ALERT.Create(const AName, AMessage: String);
begin
  inherited Create;
  FName := AName;
  FMessage := AMessage;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysInfxEventAlerter_DBMS_ALERT                                            }
{-------------------------------------------------------------------------------}
const
  C_WakeUpEvent = C_FD_SysNamePrefix + 'WAKEUP';

procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalAllocHandle;
begin
  FWaitConnection := GetConnection.Clone;
  if FWaitConnection.State = csDisconnected then
    FWaitConnection.Open;
  FWaitConnection.CreateCommand(FWaitCommand);
  SetupCommand(FWaitCommand);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalReleaseHandle;
begin
  FSignalCommand := nil;
  FWaitCommand := nil;
  FWaitConnection := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalRegister;
var
  i: Integer;
  oPar: TFDParam;
begin
  FWaitCommand.CommandText := 'EXECUTE PROCEDURE DBMS_ALERT_REGISTER(:name)';

  oPar := FWaitCommand.Params[0];
  oPar.ParamType := ptInput;
  oPar.DataType := ftString;
  oPar.Size := 128;

  FWaitCommand.Prepare();

  FWaitCommand.Params[0].AsString := C_WakeUpEvent;
  FWaitCommand.Execute();
  for i := 0 to GetNames().Count - 1 do begin
    FWaitCommand.Params[0].AsString := Trim(GetNames()[i]);
    FWaitCommand.Execute();
  end;

  FWaitCommand.CommandText := 'EXECUTE PROCEDURE DBMS_ALERT_WAITANY(:name, :message, :status, :timeout)';

  oPar := FWaitCommand.Params[0];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftString;
  oPar.Size := 128;

  oPar := FWaitCommand.Params[1];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftString;
  oPar.Size := 32672;

  oPar := FWaitCommand.Params[2];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftInteger;

  oPar := FWaitCommand.Params[3];
  oPar.ParamType := ptInput;
  oPar.DataType := ftInteger;
  oPar.AsInteger := 86400;

  FWaitCommand.Prepare();

  FWaitThread := TFDPhysInfxEventThread.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.DoFired;
begin
  if (FWaitCommand.Params[2].AsInteger = 0) and
     (CompareText(FWaitCommand.Params[0].AsString, C_WakeUpEvent) <> 0) then
    FMsgThread.EnqueueMsg(TFDPhysInfxEventMessage_DBMS_ALERT.Create(
      FWaitCommand.Params[0].AsString, FWaitCommand.Params[1].AsString));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalHandle(AEventMessage: TFDPhysEventMessage);
var
  oMsg: TFDPhysInfxEventMessage_DBMS_ALERT;
begin
  oMsg := TFDPhysInfxEventMessage_DBMS_ALERT(AEventMessage);
  InternalHandleEvent(oMsg.FName, oMsg.FMessage);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalAbortJob;
begin
  FWaitThread.Terminate;
  InternalSignal(C_WakeUpEvent, Null);
  FWaitCommand.AbortJob(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalUnregister;
var
  i: Integer;
  oPar: TFDParam;
begin
  FWaitThread := nil;

  if FWaitCommand <> nil then
    try
      FWaitCommand.CommandText := 'EXECUTE PROCEDURE DBMS_ALERT_REMOVE(:name)';

      oPar := FWaitCommand.Params[0];
      oPar.ParamType := ptInput;
      oPar.DataType := ftString;
      oPar.Size := 128;

      FWaitCommand.Prepare();

      FWaitCommand.Params[0].AsString := C_WakeUpEvent;
      FWaitCommand.Execute();
      for i := 0 to GetNames().Count - 1 do begin
        FWaitCommand.Params[0].AsString := Trim(GetNames()[i]);
        FWaitCommand.Execute();
      end;
    except
      // hide exception
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysInfxEventAlerter_DBMS_ALERT.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  oPar: TFDParam;
begin
  if FSignalCommand = nil then begin
    GetConnection.CreateCommand(FSignalCommand);
    SetupCommand(FSignalCommand);
    FSignalCommand.CommandText := 'EXECUTE PROCEDURE DBMS_ALERT_SIGNAL(:name, :message)';

    oPar := FSignalCommand.Params[0];
    oPar.DataType := ftString;
    oPar.Size := 128;

    oPar := FSignalCommand.Params[1];
    oPar.DataType := ftString;
    oPar.Size := 32672;

    FSignalCommand.Prepare();
  end;

  FSignalCommand.Params[0].AsString := AEvent;
  FSignalCommand.Params[1].AsString := VarToStr(AArgument);
  FSignalCommand.Execute();
end;

{-------------------------------------------------------------------------------}
function InfxNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EInfxNativeException.Create;
  EInfxNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysInfxDriver);
  FDStorageManager().RegisterClass(EInfxNativeException, 'InfxNativeException',
    @InfxNativeExceptionLoad, @FDExceptionSave);

end.
