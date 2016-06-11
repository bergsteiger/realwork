{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC SQL Server driver                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Phys.MSSQL;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Error,
  FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCBase;

type
  TFDMSSQLError = class;
  EMSSQLNativeException = class;
  TFDPhysMSSQLDriverLink = class;

  TFDMSSQLError = class(TFDODBCNativeError)
  private
    FLine: Integer;
    FMessageState: Integer;
    FSeverity: Integer;
    FProcName: String;
    FServerName: String;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    property Line: Integer read FLine;
    property MessageState: Integer read FMessageState;
    property Severity: Integer read FSeverity;
    property ProcName: String read FProcName;
    property ServerName: String read FServerName;
  end;

  EMSSQLNativeException = class(EODBCNativeException)
  private
    function GetErrors(AIndex: Integer): TFDMSSQLError;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  public
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String;
      AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError; override;
    property Errors[Index: Integer]: TFDMSSQLError read GetErrors; default;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux64)]
  TFDPhysMSSQLDriverLink = class(TFDPhysODBCBaseDriverLink)
  private
    FListServers: Boolean;
  protected
    function GetBaseDriverID: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetServers(AList: TStrings; ARefresh: Boolean = False);
  published
    property ListServers: Boolean read FListServers write FListServers default True;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils,
{$IFDEF MSWINDOWS}
  System.Win.ComObj,
{$ENDIF}
  System.StrUtils, System.Variants, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs,
    FireDAC.Stan.Param, FireDAC.Stan.Option,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.MSSQLMeta,
    FireDAC.Phys.MSSQLCli, FireDAC.Phys.MSSQLWrapper, FireDAC.Phys.MSSQLDef;

const
  C_2012_ODBC = 'ODBC DRIVER 11 FOR SQL SERVER';
{$IFDEF POSIX}
  C_FreeTDS = 'FreeTDS';
  C_FreeTDSLib = 'libtdsodbc.so';
{$ENDIF}
{$IFDEF MSWINDOWS}
  C_2012_NC = 'SQL SERVER NATIVE CLIENT 11.0';
  C_2008 = 'SQL SERVER NATIVE CLIENT 10.0';
  C_2005 = 'SQL NATIVE CLIENT';
  C_2000 = 'SQL SERVER';
{$ENDIF}
  C_String = 'String';
  C_Binary = 'Binary';
  C_Choose = 'Choose';

type
  TFDPhysMSSQLDriver = class;
  TFDPhysMSSQLConnection = class;
  TFDPhysMSSQLEventAlerter = class;
  TFDPhysMSSQLCommand = class;

  IFDPhysMSSQLDriver = interface
    ['{A52C2247-E07C-4BEB-821B-6DF097828ED1}']
    // public
    procedure GetServers(AList: TStrings; ARefresh: Boolean);
  end;

  TFDPhysMSSQLDriver = class(TFDPhysODBCDriverBase, IFDPhysMSSQLDriver)
  private
    FServers: TFDStringList;
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
    // IFDPhysMSSQLDriver
    procedure GetServers(AList: TStrings; ARefresh: Boolean);
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); override;
    destructor Destroy; override;
    function BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String; override;
  end;

  TFDPhysMSSQLConnection = class(TFDPhysODBCConnectionBase)
  private
    FCatalogCaseSensitive: Boolean;
    FExtendedMetadata: Boolean;
    FToolLib: TMSSQLToolLib;
    FFileStreamSerialID: LongWord;
    FFileStreamTxContext: TFDByteString;
    procedure CheckPasswordChange;
  protected
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateCommandGenerator(const ACommand:
      IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateMetadata: TObject; override;
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); override;
    function GetExceptionClass: EODBCNativeExceptionClass; override;
    procedure InternalSetMeta; override;
    procedure InternalConnect; override;
    procedure InternalDisconnect; override;
    procedure SetupConnection; override;
    procedure InternalChangePassword(const AUserName, AOldPassword,
      ANewPassword: String); override;
    procedure InternalAnalyzeSession(AMessages: TStrings); override;
    function GetFileStream(const ABlobPath: String; AMode: TFDStreamMode;
      AOptions: LongWord; AOwningObj: TObject): TStream;
  end;

  TFDPhysMSSQLEventAlerter = class (TFDPhysEventAlerter)
  private
    FWaitConnection: IFDPhysConnection;
    FWaitCommand: IFDPhysCommand;
    FMessageTab: TFDDatSTable;
    FWaitThread: TThread;
    FServiceName, FQueueName, FEventTabName: String;
    FDropService, FDropQueue, FEventTab: Boolean;
    function ProcessNotifications: Boolean;
    procedure RegisterQuery(AStmt: TODBCCommandStatement; const AEventName: String);
    procedure RegisterNotifications;
  protected
    procedure InternalAllocHandle; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalUnregister; override;
    procedure InternalReleaseHandle; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
    procedure InternalChangeHandlerModified(const AHandler: IFDPhysChangeHandler;
      const AEventName: String; AOperation: TOperation); override;
  end;

  TFDPhysMSSQLCommand = class(TFDPhysODBCCommand)
  private
    FEventAlerter: TFDPhysMSSQLEventAlerter;
    FEventName: String;
  protected
    // TFDPhysCommand
    procedure InternalPrepare; override;
    // TFDPhysODBCCommand
    procedure CreateParamColumns(AParam: TFDParam); override;
    procedure CreateParamColumnInfos(ApInfo: PFDODBCParInfoRec; AParam: TFDParam); override;
    function GetIsCustomParam(ADataType: TFDDataType): Boolean; override;
    procedure SetCustomParamValue(ADataType: TFDDataType; AVar: TODBCVariable;
      AParam: TFDParam; AVarIndex, AParIndex: Integer); override;
    procedure GetCustomParamValue(ADataType: TFDDataType; AVar: TODBCVariable;
      AParam: TFDParam; AVarIndex, AParIndex: Integer); override;
  end;

{-------------------------------------------------------------------------------}
{ TFDMSSQLError                                                                 }
{-------------------------------------------------------------------------------}
procedure TFDMSSQLError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDMSSQLError then begin
    FLine := TFDMSSQLError(ASrc).FLine;
    FMessageState := TFDMSSQLError(ASrc).FMessageState;
    FSeverity := TFDMSSQLError(ASrc).FSeverity;
    FProcName := TFDMSSQLError(ASrc).FProcName;
    FServerName := TFDMSSQLError(ASrc).FServerName;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMSSQLError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FLine := AStorage.ReadInteger('Line', 0);
  FMessageState := AStorage.ReadInteger('MessageState', 0);
  FSeverity := AStorage.ReadInteger('Severity', 0);
  FProcName := AStorage.ReadString('ProcName', '');
  FServerName := AStorage.ReadString('ServerName', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDMSSQLError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteInteger('Line', Line, 0);
  AStorage.WriteInteger('MessageState', MessageState, 0);
  AStorage.WriteInteger('Severity', Severity, 0);
  AStorage.WriteString('ProcName', ProcName, '');
  AStorage.WriteString('ServerName', ServerName, '');
end;

{-------------------------------------------------------------------------------}
{ EMSSQLNativeException                                                         }
{-------------------------------------------------------------------------------}
function EMSSQLNativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  sObj, sUDiagMessage, sRes: String;
  i, j: Integer;
  oErr: TFDMSSQLError;
  oStmt: TODBCStatementBase;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    i1 := Pos('''', ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('''', ADiagMessage, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  // following is not supported by MSSQL:
  // ekNoDataFound
  // ekUserPwdWillExpire
  sObj := AObject;
  sRes := AResultMessage;
  case ANativeError of
  1204,
  1205,
  1222:
    AKind := ekRecordLocked;
  2601,
  2627:
    begin
      AKind := ekUKViolated;
      // first 'xxxx' - constraint name
      // second 'xxxx' - table name
      ExtractObjName;
    end;
  547:
    begin
      sUDiagMessage := UpperCase(ADiagMessage);
      if (Pos('COLUMN FOREIGN KEY', sUDiagMessage) <> 0) or
         (Pos('CONFLICTED', sUDiagMessage) <> 0) and
          (Pos('REFERENCE', sUDiagMessage) <> 0) and
          (Pos('CONSTRAINT', sUDiagMessage) <> 0) then begin
        AKind := ekFKViolated;
        // first 'xxxx' - constraint name
        // next 3 'xxxx' - full column name (database, table, column)
        ExtractObjName;
      end;
    end;
  208,
  3701:
    begin
      AKind := ekObjNotExists;
      // first 'xxxx' - object name
      ExtractObjName;
    end;
  18456,
  18463,
  18464,
  18465,
  18466,
  18467,
  18468:
    AKind := ekUserPwdInvalid;
  18487,
  18488:
    AKind := ekUserPwdExpired;
  170:
    // strange "incorrect syntax near '{'" at Array INSERT execute,
    // for example on PKSP_Merge DOCS_OUT table
    if (Pos('''{''', UpperCase(ADiagMessage)) <> 0) and (Pos('{', ACommandText) = 0) and
       (AHandle is TODBCCommandStatement) and (TODBCCommandStatement(AHandle).PARAMSET_SIZE > 1) then
      AKind := ekArrExecMalfunc;
  0:
    if ASQLState = '01000' then begin
      AKind := ekServerOutput;
      i := 0;
      for j := 1 to 3 do
        i := Pos(']', sRes, i + 1);
      if i <> 0 then
        sRes := Copy(sRes, i + 1, Length(sRes));
    end
    // strange errors at Array DML:
    // - "Invalid character value for cast specification", 22018.
    //   GS has provided the bug report for 22018.
    // - "Invalid cursor state", 24000.
    //   FDQA fails on Batch execute -> Error handling on MSSQL 2005 with 24000 state.
    // - "String data, length mismatch", 22026
    //   Insert into VARBINARY(MAX) on MSSQL 2008 may give 22026.
    else if ((ASQLState = '22018') or (ASQLState = '24000') or (ASQLState = '22026')) and
            (AHandle is TODBCCommandStatement) and (TODBCCommandStatement(AHandle).PARAMSET_SIZE > 1) then
      AKind := ekArrExecMalfunc;
  201,
  8144:
    AKind := ekInvalidParams;
  end;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, sRes, ACommandText, sObj, AKind, ACmdOffset, ARowIndex);
  if AHandle is TODBCStatementBase then begin
    oErr := TFDMSSQLError(Result);
    oStmt := TODBCStatementBase(AHandle);
    try
      oStmt.IgnoreErrors := True;
      oErr.FLine         := oStmt.DIAG_SS_LINE[ARecNum];
      oErr.FMessageState := oStmt.DIAG_SS_MSGSTATE[ARecNum];
      oErr.FSeverity     := oStmt.DIAG_SS_SEVERITY[ARecNum];
      oErr.FProcName     := oStmt.DIAG_SS_PROCNAME[ARecNum];
      if oErr.ObjName = '' then
        oErr.ObjName     := oErr.FProcName;
      oErr.FServerName   := oStmt.DIAG_SS_SRVNAME[ARecNum];
    finally
      oStmt.IgnoreErrors := False;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function EMSSQLNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDMSSQLError;
end;

{-------------------------------------------------------------------------------}
function EMSSQLNativeException.GetErrors(AIndex: Integer): TFDMSSQLError;
begin
  Result := inherited Errors[AIndex] as TFDMSSQLError;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLDriverLink                                                        }
{-------------------------------------------------------------------------------}
constructor TFDPhysMSSQLDriverLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListServers := True;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_MSSQLId;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLDriverLink.GetServers(AList: TStrings; ARefresh: Boolean = False);
var
  oDrv: IFDPhysMSSQLDriver;
begin
  if FDPhysManager.State = dmsInactive then
    FDPhysManager.Open;
  DriverIntf.Employ;
  try
    Supports(DriverIntf, IFDPhysMSSQLDriver, oDrv);
    oDrv.GetServers(AList, ARefresh);
  finally
    oDrv := nil;
    DriverIntf.Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLDriver                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysMSSQLDriver.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  FServers := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysMSSQLDriver.Destroy;
begin
  FDFreeAndNil(FServers);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSSQLDriver.GetBaseDriverID: String;
begin
  Result := S_FD_MSSQLId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSSQLDriver.GetBaseDriverDesc: String;
begin
  Result := 'Microsoft SQL Server';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSSQLDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.MSSQL;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysMSSQLDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysMSSQLConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLDriver.InternalLoad;
begin
  inherited InternalLoad;
  if ODBCDriver = '' then
    ODBCDriver := FindBestDriver({$IFDEF MSWINDOWS} [C_2012_NC, C_2012_ODBC, C_2008, C_2005, C_2000] {$ENDIF}
                                 {$IFDEF POSIX} [C_2012_ODBC, C_FreeTDS], C_FreeTDSLib {$ENDIF});
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysMSSQLConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLDriver.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  AKeywords.Values[S_FD_ConnParam_Common_Password] := 'PWD';
  AKeywords.Add(S_FD_ConnParam_Common_Server);
  AKeywords.Add(S_FD_ConnParam_Common_Database);
  AKeywords.Add(S_FD_ConnParam_MSSQL_Language);
  AKeywords.Add(S_FD_ConnParam_MSSQL_Address);
  AKeywords.Add(S_FD_ConnParam_MSSQL_Workstation + '=WSID');
{$IFDEF POSIX}
  AKeywords.Add(S_FD_ConnParam_Common_Port);
{$ENDIF}
{$IFDEF MSWINDOWS}
  AKeywords.Add(S_FD_ConnParam_MSSQL_Network);
  AKeywords.Add(S_FD_ConnParam_Common_OSAuthent + '=Trusted_Connection');
  AKeywords.Add(S_FD_ConnParam_MSSQL_MARS + '=MARS_Connection');
  AKeywords.Add(S_FD_ConnParam_MSSQL_Encrypt);
{$ENDIF}
  AKeywords.Add(S_FD_ConnParam_Common_ApplicationName + '=APP');
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLDriver.BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): string;
begin
  Result := inherited BuildODBCConnectString(AConnectionDef);
  if ((CompareText(ODBCDriver, C_2012_ODBC) = 0)
{$IFDEF MSWINDOWS}
      or (CompareText(ODBCDriver, C_2012_NC) = 0) or
      (CompareText(ODBCDriver, C_2005) = 0) or
      (CompareText(ODBCDriver, C_2008) = 0)
{$ENDIF}
     ) and
     not (AConnectionDef.HasValue('DSN') or AConnectionDef.HasValue('FIL')) and
     (Pos('MARS_CONNECTION=', UpperCase(Result)) = 0) then
    Result := Result + ';MARS_Connection=yes'
{$IFDEF POSIX}
  else if ((CompareText(ODBCDriver, C_FreeTDS) = 0) or
           (CompareText(ODBCDriver, C_FreeTDSLib) = 0)) and
          not (AConnectionDef.HasValue('DSN') or AConnectionDef.HasValue('FIL')) and
          (Pos('TDS_VERSION=', UpperCase(Result)) = 0) then
    Result := Result + ';TDS_VERSION=8.0';
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
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

  oList := TFDStringList.Create;
  try
    GetServers(oList, False);
    oList.QuoteChar := #0;
    oList.Delimiter := ';';
    s := oList.DelimitedText;
    if s = '' then
      s := '@S';
  finally
    FDFree(oList);
  end;
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, s, '', S_FD_ConnParam_Common_Server, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_Network, '@S', '', S_FD_ConnParam_MSSQL_Network, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_Address, '@S', '', S_FD_ConnParam_MSSQL_Address, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_OSAuthent, '@Y', '', S_FD_ConnParam_Common_OSAuthent, 2]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_MARS, '@Y', S_FD_Yes, S_FD_ConnParam_MSSQL_MARS, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_Workstation, '@S', '', S_FD_ConnParam_MSSQL_Workstation, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_Language, '@S', '', S_FD_ConnParam_MSSQL_Language, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_Encrypt, '@Y', '', S_FD_ConnParam_MSSQL_Encrypt, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_VariantFormat, C_String + ';' + C_Binary, C_String, S_FD_ConnParam_MSSQL_VariantFormat, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ExtendedMetadata, '@L', S_FD_False, S_FD_ConnParam_Common_ExtendedMetadata, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ApplicationName, '@S', '', S_FD_ConnParam_Common_ApplicationName, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCaseIns, '@L', S_FD_False, S_FD_ConnParam_Common_MetaCaseIns, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_MSSQL_MetaCaseInsCat, C_Choose + ';' + S_FD_False + ';' + S_FD_True, C_Choose, S_FD_ConnParam_MSSQL_MetaCaseInsCat, -1]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLDriver.GetServers(AList: TStrings; ARefresh: Boolean);
var
  oConn: TODBCConnection;
  oLnk: TFDPhysDriverLink;
begin
  oLnk := Manager.FindDriverLink(DriverID);
  if ((oLnk = nil) or not (oLnk is TFDPhysMSSQLDriverLink) or TFDPhysMSSQLDriverLink(oLnk).ListServers) and
     (FServers.Delimiter <> '*') or ARefresh then begin
    Employ;
    oConn := TODBCConnection.Create(ODBCEnvironment);
    try
      oConn.SS_BROWSE_CONNECT := SQL_MORE_INFO_YES;
      oConn.ListServers('DRIVER=' + TODBCLib.DecorateKeyValue(ODBCDriver), FServers);
      FServers.Delimiter := '*';
    finally
      FDFree(oConn);
      Vacate;
    end;
  end;
  AList.SetStrings(FServers);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLConnection                                                        }
{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  CreateMetadata(oConnMeta);
  if (oConnMeta.ServerVersion >= svMSSQL2005) and
     (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc]) and
     (CompareText(AEventKind, S_FD_EventKind_MSSQL_Events) = 0) then
    Result := TFDPhysMSSQLEventAlerter.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysMSSQLCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysMSSQLCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysMSSQLCommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
  iCase: SQLUSmallint;
begin
  if ODBCConnection <> nil then begin
    GetVersions(iSrvVer, iClntVer);
    iCase := ODBCConnection.IDENTIFIER_CASE;
    Result := TFDPhysMSSQLMetadata.Create(Self, FCatalogCaseSensitive,
      iCase in [SQL_IC_SENSITIVE, SQL_IC_MIXED], iCase in [SQL_IC_MIXED],
      ODBCConnection.IDENTIFIER_QUOTE_CHAR = '"',
      ODBCConnection.DriverKind in [dkSQLSrv, dkSQLNC, dkSQLOdbc], iSrvVer, iClntVer,
      FExtendedMetadata);
  end
  else
    Result := TFDPhysMSSQLMetadata.Create(Self, False, True, True, True, False,
      0, 0, FExtendedMetadata);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize, AByteSize: Integer);
begin
  AByteSize := 8000;
  ACharSize := AByteSize;
  case AStrDataType of
  SQL_C_CHAR, SQL_C_BINARY:
    ;
  SQL_C_WCHAR:
    ACharSize := AByteSize div SizeOf(SQLWChar);
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_MSSQLId]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := EMSSQLNativeException;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.CheckPasswordChange;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  CreateMetadata(oConnMeta);
  if not ((oConnMeta.ServerVersion >= svMSSQL2005) and
          (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc])) then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_MSSQLId]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.InternalConnect;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  inherited InternalConnect;
  CreateMetadata(oConnMeta);
  if (oConnMeta.ClientVersion >= svMSSQL2008) and
     (ODBCConnection.DriverKind in [dkSQLNC, dkSQLOdbc]) then begin
    FToolLib := TMSSQLToolLib.Create(Self);
    FToolLib.Load(ODBCConnection.DRIVER_NAME);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.SetupConnection;
var
  oPrevChanging: TNotifyEvent;
  oParams: TFDPhysMSSQLConnectionDefParams;
begin
  oParams := ConnectionDef.Params as TFDPhysMSSQLConnectionDefParams;
  if oParams.NewPassword <> '' then begin
    CheckPasswordChange;
    ODBCConnection.SS_OLDPWD := oParams.Password;
    oPrevChanging := ConnectionDef.OnChanging;
    ConnectionDef.OnChanging := nil;
    oParams.Password := oParams.NewPassword;
    oParams.NewPassword := '';
    ConnectionDef.OnChanging := oPrevChanging;
  end;
  inherited SetupConnection;
  ODBCConnection.MSSQLVariantBinary := oParams.VariantFormat = vfBinary;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.InternalDisconnect;
begin
  FDFreeAndNil(FToolLib);
  inherited InternalDisconnect;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.InternalSetMeta;
var
  oStmt: TODBCCommandStatement;
  oCol1, oCol2: TODBCColumn;
  oConnMeta: IFDPhysConnectionMetadata;
  iCount: SQLLen;
  sCollProp, sCurCatalog: String;
  oPars: TFDPhysMSSQLConnectionDefParams;
begin
  inherited InternalSetMeta;
  oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
  try
    CreateMetadata(oConnMeta);
    if FCurrentCatalog <> '' then
      sCurCatalog := FCurrentCatalog
    else
      sCurCatalog := InternalGetCurrentCatalog;
    if sCurCatalog <> '' then begin
      if oConnMeta.ServerVersion >= svMSSQL2005 then
        sCollProp := 'DATABASEPROPERTYEX('''
      else
        sCollProp := 'DATABASEPROPERTY(''';
      sCollProp := sCollProp + sCurCatalog + ''', ''COLLATION'')';
    end
    else
      sCollProp := 'SERVERPROPERTY(''COLLATION'')';
    if oConnMeta.ServerVersion >= svMSSQL2005 then
      oStmt.Open(1, 'SELECT SCHEMA_NAME(), ' + sCollProp)
    else
      oStmt.Open(1, 'SELECT USER_NAME(), ' + sCollProp);
    oCol1 := oStmt.AddCol(1, SQL_WVARCHAR, SQL_C_WCHAR, 128);
    oCol2 := oStmt.AddCol(2, SQL_WVARCHAR, SQL_C_WCHAR, 128);
    oStmt.Fetch(1);
    if FCurrentSchema = '' then begin
      FCurrentSchema := oCol1.AsStrings[0];
      // Under MSSQL 2005 the SCHEMA_NAME() may return NULL
      if FCurrentSchema = '' then
        FCurrentSchema := 'dbo';
    end;
    oPars := TFDPhysMSSQLConnectionDefParams(ConnectionDef.Params);
    if oPars.MetaCaseInsCat = mciChoose then
      FCatalogCaseSensitive := Pos('_CI_', UpperCase(oCol2.AsStrings[0])) = 0
    else
      FCatalogCaseSensitive := oPars.MetaCaseInsCat = mciFalse;
    FExtendedMetadata := oPars.ExtendedMetadata;
    if FExtendedMetadata then begin
      oStmt.Unprepare;
      oStmt.Execute(1, 0, iCount, False, 'SET NO_BROWSETABLE ON');
    end;
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.InternalChangePassword(const AUserName,
  AOldPassword, ANewPassword: String);
var
  oConnDef: IFDStanConnectionDef;
  oConn: TODBCConnection;
begin
  CheckPasswordChange;
  FDCreateInterface(IFDStanConnectionDef, oConnDef);
  oConnDef.ParentDefinition := ConnectionDef;
  oConnDef.Params.UserName := AUserName;
  oConnDef.Params.Password := ANewPassword;
  oConn := TODBCConnection.Create(ODBCEnvironment, Self);
  try
    oConn.SS_OLDPWD := AOldPassword;
    oConn.Connect(TFDPhysODBCDriverBase(DriverObj).BuildODBCConnectString(oConnDef));
  finally
    FDFree(oConn);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnection.InternalAnalyzeSession(AMessages: TStrings);
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  inherited InternalAnalyzeSession(AMessages);
  CreateMetadata(oConnMeta);

  // 2. SQLNC 2008 fails with SQL2000 at some tests
  if (oConnMeta.ServerVersion >= svMSSQL2000) and (oConnMeta.ServerVersion < svMSSQL2005) and
     (oConnMeta.ClientVersion >= svMSSQL2008) then
    AMessages.Add(S_FD_MSSQLWarnNC2008);

  // 3. MS ODBC 11 does not support SQL_VARIANT
  if CompareText(Copy(ODBCConnection.DRIVER_NAME, 1, 9), 'MSODBCSQL') = 0 then
    AMessages.Add(S_FD_MSSQLWarnODBC11);

  // 4. SQLNC 2012 and MS ODBC 11 raise "invalid precision value" for TVP
  if oConnMeta.ClientVersion >= svMSSQL2012 then
    AMessages.Add(S_FD_MSSQLWarnNC2012);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnection.GetFileStream(const ABlobPath: String;
  AMode: TFDStreamMode; AOptions: LongWord; AOwningObj: TObject): TStream;
var
  pData: SQLPointer;
  iLen: SQLLen;
  oStmt: TODBCCommandStatement;
begin
  if FToolLib = nil then
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_MSSQLId]);
  if ABlobPath = '' then
    FDException(Self, [S_FD_LPhys, S_FD_MSSQLId], er_FD_MSSQLFSNoPath, []);

  if (Length(FFileStreamTxContext) = 0) or
     (GetTransaction.SerialID <> FFileStreamSerialID) then begin
    oStmt := TODBCCommandStatement.Create(ODBCConnection, Self);
    try
      oStmt.Open(1, 'SELECT GET_FILESTREAM_TRANSACTION_CONTEXT()');
      oStmt.AddCol(1, SQL_VARBINARY, SQL_C_BINARY, MaxInt);
      oStmt.Fetch(1);

      if not oStmt.ColumnList[0].GetData(0, pData, iLen, True) or (iLen = 0) then
        FDException(Self, [S_FD_LPhys, S_FD_MSSQLId], er_FD_MSSQLFSNoTx, []);

      SetLength(FFileStreamTxContext, iLen);
      Move(pData^, PByte(FFileStreamTxContext)^, iLen);
    finally
      FDFree(oStmt);
    end;
    FFileStreamSerialID := GetTransaction.SerialID;
  end;

  Result := TMSSQLFileStream.Create(FToolLib, ABlobPath, FFileStreamTxContext,
    AMode, AOptions, AOwningObj);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLEventThread                                                       }
{-------------------------------------------------------------------------------}
type
  TFDPhysMSSQLEventThread = class(TThread)
  private
    [weak] FAlerter: TFDPhysMSSQLEventAlerter;
  protected
    procedure Execute; override;
  public
    constructor Create(AAlerter: TFDPhysMSSQLEventAlerter);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysMSSQLEventThread.Create(AAlerter: TFDPhysMSSQLEventAlerter);
begin
  inherited Create(False);
  FAlerter := AAlerter;
  FreeOnTerminate := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysMSSQLEventThread.Destroy;
begin
  FAlerter.FWaitThread := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventThread.Execute;
begin
  FAlerter.RegisterNotifications();
  while not Terminated and FAlerter.IsRunning do
    try
      if FAlerter.FMessageTab.Columns.Count = 0 then
        FAlerter.FWaitCommand.Define(FAlerter.FMessageTab);
      FAlerter.FWaitCommand.Open();
      if not Terminated then begin
        FAlerter.FWaitCommand.Fetch(FAlerter.FMessageTab, True);
        if (FAlerter.FMessageTab.Rows.Count > 0) and
           FAlerter.ProcessNotifications() then
          FAlerter.RegisterNotifications();
      end;
    except
      on E: EFDDBEngineException do
        if E.Kind <> ekCmdAborted then begin
          Terminate;
          FAlerter.AbortJob;
        end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLEventMessage                                                      }
{-------------------------------------------------------------------------------}
type
  TFDPhysMSSQLEventMessage = class(TFDPhysEventMessage)
  private
    FName,
    FType,
    FSource,
    FInfo: String;
  public
    constructor Create(const AName, AType, ASource, AInfo: String);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysMSSQLEventMessage.Create(const AName, AType, ASource, AInfo: String);
begin
  inherited Create;
  FName := AName;
  FType := AType;
  FSource := ASource;
  FInfo := AInfo;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLEventAlerter                                                      }
{-------------------------------------------------------------------------------}
// See:
// 1) http://msdn.microsoft.com/en-us/library/ms181122.aspx
// Creating a Query for Notification - supported SELECT's, connection settings, etc
// 2) http://msdn.microsoft.com/en-us/library/ms188323.aspx
// Understanding When Query Notifications Occur
// 3) http://www.code-magazine.com/article.aspx?quickid=0605061&page=1
// SQL Server 2005 Query Notifications Tell .NET 2.0 Apps When Critical Data Changes

// SERVICE=<service>
// QUEUE=<queue>
// CHANGE1=<message>;<SELECT>
// ...
// CHANGEn=<message>;<SELECT>
// <EV1>=<message>
// ...
// <EVn>=<message>

const
  C_Service = 'SERVICE';
  C_Queue = 'QUEUE';
  C_Change = 'CHANGE';
  C_Events = 'EVENTS';

{-------------------------------------------------------------------------------}
{$IFDEF POSIX}
function CreateClassID: String;
begin
  Format('%.4x%.4x-%.4x-%.4x-%.4x-%.4x%.4x%.4x', [
    Random($FFFF), Random($FFFF),                 // Generates a 64-bit Hex number
    Random($FFFF),                                // Generates a 32-bit Hex number
    ((Random($FFFF) and $0FFF) or $4000),         // Generates a 32-bit Hex number of the form 4xxx (4 indicates the UUID version)
    Random($FFFF) mod $3FFF + $8000,              // Generates a 32-bit Hex number in the range [0x8000, 0xbfff]
    Random($FFFF), Random($FFFF), Random($FFFF)]);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalAllocHandle;
var
  i: Integer;
  sName, sVal: String;
begin
                                                                         
  FWaitConnection := GetConnection.Clone;
  if FWaitConnection.State = csDisconnected then
    FWaitConnection.Open;
  FWaitConnection.CreateCommand(FWaitCommand);
  SetupCommand(FWaitCommand);
  FMessageTab := TFDDatSTable.Create;
  FServiceName := C_FD_SysNamePrefix + C_Service;
  FQueueName := C_FD_SysNamePrefix + C_Queue;
  FEventTabName := C_FD_SysNamePrefix + C_Events;
  FDropService := False;
  FDropQueue := False;
  FEventTab := False;
  for i := 0 to GetNames.Count - 1 do begin
    sName := GetNames().KeyNames[i];
    sVal := GetNames().ValueFromIndex[i];
    if CompareText(sName, C_Service) = 0 then
      if sVal = '?' then begin
        FServiceName := C_FD_SysNamePrefix + C_Service + CreateClassID;
        FDropService := True;
      end
      else
        FServiceName := sVal
    else if CompareText(sName, C_Queue) = 0 then
      if sVal = '?' then begin
        FQueueName := C_FD_SysNamePrefix + C_Queue + CreateClassID;
        FDropQueue := True;
      end
      else
        FQueueName := sVal
    else if StrLIComp(PChar(sName), PChar(C_Change), Length(C_Change)) <> 0 then
      FEventTab := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalRegister;
var
  sSQL: String;
begin
  sSQL :=
    'IF OBJECT_ID(''' + FQueueName + ''') IS NULL BEGIN ' +
    '  CREATE QUEUE [' + FQueueName + ']; ' +
    'END; ' +
    'IF (SELECT COUNT(*) FROM sys.services WHERE NAME = ''' + FServiceName + ''') = 0 BEGIN ' +
    '  CREATE SERVICE [' + FServiceName + '] ON QUEUE [' + FQueueName + '] ' +
    '    ([http://schemas.microsoft.com/SQL/Notifications/PostQueryNotification]); ' +
    '  IF (SELECT COUNT(*) FROM sys.database_principals WHERE name = ''sql_dependency_subscriber'' AND type = ''R'') <> 0 BEGIN ' +
    '    GRANT SEND ON SERVICE::[' + FServiceName + '] TO sql_dependency_subscriber; ' +
    '  END; ' +
    'END;';
  if FEventTab then
    sSQL := sSQL +
      'IF OBJECT_ID(''' + FEventTabName + ''') IS NULL BEGIN ' +
      '  CREATE TABLE [' + FEventTabName + '] (Name NVARCHAR(128) NOT NULL PRIMARY KEY CLUSTERED, Value BIGINT); ' +
      'END; ';
  FWaitCommand.Prepare(sSQL);
  FWaitCommand.Execute;
  FWaitThread := TFDPhysMSSQLEventThread.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.RegisterQuery(AStmt: TODBCCommandStatement;
  const AEventName: String);
begin
  if GetOptions.Timeout > 0 then
    AStmt.SS_QUERYNOTIFICATION_TIMEOUT := GetOptions.Timeout div MSecsPerSec;
  AStmt.SS_QUERYNOTIFICATION_MSGTEXT := AEventName;
  AStmt.SS_QUERYNOTIFICATION_OPTIONS := 'SERVICE=' + FServiceName +
    ';LOCAL DATABASE=' + GetConnection.ConnectionDef.Params.ExpandedDatabase;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.RegisterNotifications;
var
  i, j: Integer;
  oStmt: TODBCCommandStatement;
  sName, sVal: String;
  sMsg, sSQL: String;
begin
  for i := 0 to GetNames.Count - 1 do begin
    sName := GetNames().KeyNames[i];
    sVal := GetNames().ValueFromIndex[i];
    if not ((CompareText(sName, C_Service) = 0) or (CompareText(sName, C_Queue) = 0)) then begin
      if StrLIComp(PChar(sName), PChar(C_Change), Length(C_Change)) = 0 then begin
        j := Pos(';', sVal);
        sMsg := Copy(sVal, 1, j - 1);
        sSQL := Copy(sVal, j + 1, MAXINT);
      end
      else begin
        sName := QuotedStr(sName);
        try
          FWaitCommand.Prepare('INSERT INTO [' + FEventTabName + '] VALUES(' + sName + ', 0)');
          FWaitCommand.Execute();
        except
          on E: EMSSQLNativeException do
            if E.Kind <> ekUKViolated then
              raise;
        end;
        sSQL := 'SELECT Value FROM [' + FEventTabName + '] WHERE Name = ' + sName;
      end;
      FWaitCommand.Prepare(sSQL);
      oStmt := TODBCCommandStatement(FWaitCommand.CliObj);
      RegisterQuery(oStmt, sMsg);
      FWaitCommand.Define(FMessageTab);
      FWaitCommand.Open;
      FWaitCommand.Disconnect;
      FMessageTab.Reset;
    end;
  end;
  sSQL := 'WAITFOR (RECEIVE message_body FROM [' + FQueueName + '])';
  if GetOptions.Timeout > 0 then
    sSQL := sSQL + ', TIMEOUT ' + IntToStr(GetOptions.Timeout);
  FWaitCommand.Prepare(sSQL);
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLEventAlerter.ProcessNotifications: Boolean;
var
  i: Integer;
  sMsg, sType, sSrc, sInfo, sVal: String;

  function GetAttr(const AName: String): String;
  var
    i1, i2: Integer;
  begin
    Result := '';
    i1 := Pos(AName + '="', sMsg);
    if i1 > 0 then begin
      i2 := Pos('"', sMsg, i1 + Length(AName) + 2);
      if i2 > 0 then begin
        i1 := i1 + Length(AName) + 2;
        i2 := i2 - 1;
        Result := Copy(sMsg, i1, i2 - i1 + 1);
      end;
    end;
  end;

  function GetValue(const AName: String): String;
  var
    i1, i2: Integer;
  begin
    i1 := Pos('<' + AName + '>', sMsg);
    i2 := Pos('</' + AName + '>', sMsg);
    if (i1 > 0) and (i2 > 0) then begin
      i1 := i1 + Length(AName) + 2;
      i2 := i2 - 1;
      Result := Copy(sMsg, i1, i2 - i1 + 1);
    end
    else
      Result := '';
  end;

begin
  // http://technet.microsoft.com/en-us/library/ms189308(v=sql.105).aspx
  // Query Notification Messages format
  Result := True;
  for i := 0 to FMessageTab.Rows.Count - 1 do begin
    sMsg := FMessageTab.Rows[i].AsString['message_body'];
    sType := GetAttr('type');
    sSrc := GetAttr('source');
    Result := CompareText(sType, 'subscribe') <> 0;
    if (CompareText(sType, 'change') = 0) and (CompareText(sSrc, 'timeout') <> 0) or
       not Result then begin
      sInfo := GetAttr('info');
      sVal := GetValue('qn:Message');
      FMsgThread.EnqueueMsg(TFDPhysMSSQLEventMessage.Create(sVal, sType, sSrc, sInfo));
    end;
  end;
  FMessageTab.Clear;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalHandle(AEventMessage: TFDPhysEventMessage);
var
  oMsg: TFDPhysMSSQLEventMessage;
  i: Integer;
  oHnlr: IFDPhysChangeHandler;
  oCmd: TFDPhysMSSQLCommand;
begin
  oMsg := TFDPhysMSSQLEventMessage(AEventMessage);
  if CompareText(oMsg.FType, 'subscribe') = 0 then
    try
      FDException(Self, [S_FD_LPhys, S_FD_MSSQLId], er_FD_MSSQLQNSubError, [oMsg.FInfo])
    except
      ApplicationHandleException(nil);
    end
  else begin
    InternalHandleEvent(oMsg.FName, VarArrayOf([oMsg.FSource, oMsg.FInfo]));
    i := FChangeHandlerNames.IndexOf(oMsg.FName);
    if i >= 0 then begin
      oHnlr := FChangeHandlers[i] as IFDPhysChangeHandler;
      // If content is modified here, then Refresh was not performed.
      // So, reexecute query here to reregister change notification.
      // Otherwise, it is reregistered at Refresh call.
      if oHnlr.ContentModified then begin
        oCmd := oHnlr.TrackCommand as TFDPhysMSSQLCommand;
        if (oCmd.FEventAlerter = Self) and (oCmd.FEventName <> '') and
           (oCmd.ODBCStatement <> nil) and (oCmd.ODBCStatement is TODBCCommandStatement) then begin
          RegisterQuery(TODBCCommandStatement(oCmd.ODBCStatement), oCmd.FEventName);
          oCmd.CloseAll;
          oCmd.Open;
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalAbortJob;
begin
  FWaitThread.Terminate;
  FWaitCommand.AbortJob(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalUnregister;
var
  sSQL: String;
begin
  FWaitThread := nil;
  sSQL := '';
  if FDropService then
    sSQL := sSQL +
      'IF (SELECT COUNT(*) FROM sys.services WHERE NAME = ''' + FServiceName + ''') <> 0 BEGIN ' +
      '  DROP SERVICE [' + FServiceName + ']; ' +
      'END; ';
  if FDropQueue then
    sSQL := sSQL +
      'IF OBJECT_ID(''' + FQueueName + ''') IS NOT NULL BEGIN ' +
      '  DROP QUEUE [' + FQueueName + ']; ' +
      'END; ';
  if sSQL <> '' then begin
    FWaitCommand.Prepare(sSQL);
    FWaitCommand.Execute;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalReleaseHandle;
begin
  FWaitCommand := nil;
  FWaitConnection := nil;
  FDFreeAndNil(FMessageTab);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  oCmd: IFDPhysCommand;
begin
  if FEventTab then begin
    GetConnection.CreateCommand(oCmd);
    SetupCommand(oCmd);
    oCmd.Prepare('UPDATE [' + FEventTabName + '] SET Value = Value + 1 WHERE Name = ' + QuotedStr(AEvent));
    oCmd.Execute();
  end
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_MSSQLId]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLEventAlerter.InternalChangeHandlerModified(
  const AHandler: IFDPhysChangeHandler; const AEventName: String;
  AOperation: TOperation);
var
  oCmd: TFDPhysMSSQLCommand;
begin
  oCmd := AHandler.TrackCommand as TFDPhysMSSQLCommand;
  case AOperation of
  opInsert:
    begin
      oCmd.FEventAlerter := Self;
      oCmd.FEventName := AEventName;
    end;
  opRemove:
    begin
      oCmd.FEventAlerter := nil;
      oCmd.FEventName := '';
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysMSSQLCommand                                                           }
{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLCommand.InternalPrepare;
begin
  inherited InternalPrepare;
  if (FEventAlerter <> nil) and (FEventName <> '') and
     (ODBCStatement <> nil) and (ODBCStatement is TODBCCommandStatement) then
    FEventAlerter.RegisterQuery(TODBCCommandStatement(ODBCStatement), FEventName);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLCommand.CreateParamColumns(AParam: TFDParam);
var
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  oView: TFDDatSView;
  oTab: TFDDatSTable;
  i: Integer;
  ui: LongWord;
  oCol: TFDDatSColumn;
  oRow: TFDDatSRow;
begin
  GetConnection.CreateMetadata(oConnMeta);
  oConnMeta.DecodeObjName(AParam.DataTypeName, rName, nil, [doUnquote]);
  oView := oConnMeta.GetTableTypeFields(rName.FCatalog, rName.FSchema, rName.FObject, '');
  oTab := TFDDatSTable.Create;
  try
    oTab.Name := AParam.Name;
    for i := 0 to oView.Rows.Count - 1 do begin
      oCol := TFDDatSColumn.Create;
      oRow := oView.Rows[i];
      oCol.Name := oRow.GetData(4);
      oCol.DataType := TFDDataType(oRow.GetData(6));
      oCol.SourceDataTypeName := oRow.GetData(7);
      ui := oRow.GetData(8);
      oCol.Attributes := TFDDataAttributes(Pointer(@ui)^);
      oCol.Precision := oRow.GetData(9);
      oCol.Scale := oRow.GetData(10);
      oCol.Size := oRow.GetData(11);
      oTab.Columns.Add(oCol);
    end;
    AParam.SetObjectValue(oTab, ftDataSet, True, -1);
  except
    FDFree(oTab);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLCommand.CreateParamColumnInfos(ApInfo: PFDODBCParInfoRec;
  AParam: TFDParam);
var
  oDS: TDataSet;
  i: Integer;
  oFld: TField;
  pInfo: PFDODBCParInfoRec;
  oFmtOpts: TFDFormatOptions;
  iPrec: Integer;
  iScale: Integer;
  eDestFldType: TFieldType;
  iDestSize: LongWord;
  lFixedLen: Boolean;
  eAttrs: TFDDataAttributes;
  iLen: LongWord;
  oVar: TODBCParameter;
begin
  oFmtOpts := FOptions.FormatOptions;
  oDS := AParam.AsDataSet;
  SetLength(ApInfo.FSubInfos, oDS.FieldCount);

  for i := 0 to oDS.FieldCount - 1 do begin
    oFld := oDS.Fields[i];
    pInfo := @ApInfo.FSubInfos[i];
    pInfo^.FName := '';
    pInfo^.FPos := oFld.FieldNo;
    pInfo^.FParamIndex := oFld.Index;
    pInfo^.FParamType := AParam.ParamType;
    pInfo^.FDataType := oFld.DataType;

    if oFld is TBCDField then begin
      iPrec := TBCDField(oFld).Precision;
      iScale := TBCDField(oFld).Size;
    end
    else if oFld is TFMTBCDField then begin
      iPrec := TFMTBCDField(oFld).Precision;
      iScale := TBCDField(oFld).Size;
    end
    else begin
      iPrec := 0;
      iScale := 0;
    end;

    oFmtOpts.ResolveFieldType(oFld.FieldName, '', oFld.DataType, dtUnknown,
      oFld.Size, iPrec, iScale, eDestFldType, iDestSize, pInfo^.FColSize,
      pInfo^.FScale, pInfo^.FSrcDataType, pInfo^.FDestDataType, False);

    lFixedLen := pInfo^.FDataType in [ftFixedChar, ftBytes, ftFixedWideChar];
    pInfo^.FSrcSQLDataType := FD2SQLDataType(pInfo^.FSrcDataType, lFixedLen,
      iPrec, iScale);
    pInfo^.FOutSQLDataType := FD2SQLDataType(pInfo^.FDestDataType, lFixedLen,
      pInfo^.FColSize, pInfo^.FScale);
    if pInfo^.FOutSQLDataType = SQL_UNKNOWN_TYPE then
      ParTypeMapError(AParam);

    eAttrs := [];
    SQL2FDColInfo(pInfo^.FOutSQLDataType, False, '', pInfo^.FColSize, pInfo^.FScale,
      pInfo^.FOutDataType, eAttrs, iLen, iPrec, iScale);

    if (pInfo^.FDestDataType = dtBCD) and (pInfo^.FOutDataType = dtFmtBCD) then
      pInfo^.FOutDataType := dtBCD;

    pInfo^.FVar := TODBCParameter(ApInfo^.FVar).ColumnList.Add(TODBCParameter.Create);
    oVar := TODBCParameter(pInfo^.FVar);
    oVar.ParamType := FD2SQLParamType(pInfo^.FParamType);
    oVar.Position := SQLSmallint(pInfo^.FPos);
    oVar.Name := pInfo^.FName;
    oVar.ColumnSize := pInfo^.FColSize;
    oVar.Scale := pInfo^.FScale;
    oVar.SQLDataType := pInfo^.FOutSQLDataType;
    oVar.CDataType := FD2CDataType(pInfo^.FOutDataType, True);
    oVar.UpdateFlags;
    // Set Scale value to specified 0 instead of default scale, excluding date/time
    // data types. Otherwise exception is raised "Datetime field overflow. Fractional
    // second precision exceeds the scale specified in the parameter binding"
    if not ((oVar.CDataType = SQL_C_TYPE_TIMESTAMP) or (oVar.CDataType = SQL_C_TIMESTAMP) or
            (oVar.CDataType = SQL_C_TYPE_DATE) or
            (oVar.CDataType >= SQL_C_INTERVAL_YEAR) and (oVar.CDataType <= SQL_C_INTERVAL_MINUTE_TO_SECOND)) then
      oVar.Scale := pInfo^.FScale;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLCommand.GetIsCustomParam(ADataType: TFDDataType): Boolean;
begin
  Result := ADataType = dtHBFile;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLCommand.SetCustomParamValue(ADataType: TFDDataType;
  AVar: TODBCVariable; AParam: TFDParam; AVarIndex, AParIndex: Integer);
begin
  if ADataType = dtHBFile then
    AVar.SetData(AVarIndex, nil, 0)
  else
    inherited SetCustomParamValue(ADataType, AVar, AParam, AVarIndex, AParIndex);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLCommand.GetCustomParamValue(ADataType: TFDDataType;
  AVar: TODBCVariable; AParam: TFDParam; AVarIndex, AParIndex: Integer);
var
  sPath: String;
  oExtStr, oIntStr: TStream;
  pBuffer: PByte;
  iDataSize: LongWord;
  lFree: Boolean;
  lExtStream: Boolean;
begin
  if ADataType = dtHBFile then begin
    oExtStr := AParam.AsStreams[AParIndex];
    lExtStream := (oExtStr <> nil) and
      not ((oExtStr is TMSSQLFileStream) and (TMSSQLFileStream(oExtStr).OwningObj = Self));
    sPath := AVar.AsStrings[AVarIndex];

    if (AParam.StreamMode in [smOpenRead, smOpenReadWrite]) and (sPath = '') then begin
      if lExtStream then
        oExtStr.Size := 0;
      AParam.Clear(AParIndex);
      Exit;
    end;
    oIntStr := TFDPhysMSSQLConnection(ODBCConnection).GetFileStream(
      sPath, AParam.StreamMode, SQL_FILESTREAM_OPEN_NONE, Self);
    lFree := True;

    try
      try
        if (oExtStr = nil) and (AParam.DataType = ftStream) then begin
          AParam.AsStreams[AParIndex] := oIntStr;
          lFree := False;
        end

        // Write FD parameter into SQL Server stream
        else if AParam.StreamMode = smOpenWrite then
          if lExtStream then
            oIntStr.CopyFrom(oExtStr, -1)
          else if AParam.IsNulls[AParIndex] then
            oIntStr.Size := 0
          else begin
            AParam.GetBlobRawData(iDataSize, pBuffer, AParIndex);
            if AParam.IsUnicode then
              iDataSize := iDataSize * SizeOf(WideChar);
            oIntStr.WriteBuffer(pBuffer^, iDataSize);
          end

        // Read SQL Server stream into FD parameter
        else
          if lExtStream then begin
            oExtStr.Position := 0;
            oExtStr.CopyFrom(oIntStr, -1);
          end
          else begin
            iDataSize := oIntStr.Size;
            FBuffer.Check(iDataSize);
            oIntStr.ReadBuffer(FBuffer.FBuffer^, iDataSize);
            if AParam.IsUnicode then
              iDataSize := iDataSize div SizeOf(WideChar);
            AParam.SetBlobRawData(iDataSize, FBuffer.FBuffer, AParIndex);
          end;

      except
        on E: EStreamError do
          FDException(Self, [S_FD_LPhys, S_FD_MSSQLId], er_FD_MSSQLFSIOError,
            [FDLastSystemErrorMsg]);
      end;
    finally
      if lFree then
        FDFree(oIntStr);
    end;
  end
  else
    inherited GetCustomParamValue(ADataType, AVar, AParam, AVarIndex, AParIndex);
end;

{-------------------------------------------------------------------------------}
function MSSQLNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EMSSQLNativeException.Create;
  EMSSQLNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysMSSQLDriver);
  FDStorageManager().RegisterClass(EMSSQLNativeException, 'MSSQLNativeException',
    @MSSQLNativeExceptionLoad, @FDExceptionSave);

end.
