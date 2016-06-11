{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC IBM DB2 driver                 }
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
    {$HPPEMIT '#pragma link "FireDAC.Phys.DB2.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Phys.DB2.o"'}
  {$ENDIF}
{$ENDIF}

unit FireDAC.Phys.DB2;

interface

uses
  System.Classes,
  FireDAC.Stan.Error, 
  FireDAC.Phys, FireDAC.Phys.ODBCCli, FireDAC.Phys.ODBCWrapper, FireDAC.Phys.ODBCBase;

type
  EDB2NativeException = class;
  TFDPhysDB2DriverLink = class;

  EDB2NativeException = class(EODBCNativeException)
  public
    function AppendError(AHandle: TODBCHandle; ARecNum: SQLSmallint;
      const ASQLState: String; ANativeError: SQLInteger; const ADiagMessage,
      AResultMessage, ACommandText, AObject: String; AKind: TFDCommandExceptionKind;
      ACmdOffset, ARowIndex: Integer): TFDDBError; override;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidLinux64)]
  TFDPhysDB2DriverLink = class(TFDPhysODBCBaseDriverLink)
  protected
    function GetBaseDriverID: String; override;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.Variants, System.SysUtils, System.StrUtils, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLGenerator, FireDAC.Phys.DB2Meta,
    FireDAC.Phys.DB2Def;

type
  TFDPhysDB2Driver = class;
  TFDPhysDB2Connection = class;
  TFDPhysDB2EventAlerter = class;
  TFDPhysDB2EventAlerter_DBMS_ALERT = class;
  TFDPhysDB2EventAlerter_DBMS_PIPE = class;
  TFDPhysDB2Command = class;

  TFDPhysDB2Driver = class(TFDPhysODBCDriverBase)
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    procedure GetODBCConnectStringKeywords(AKeywords: TStrings); override;
    function BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  end;

  TFDPhysDB2Connection = class(TFDPhysODBCConnectionBase)
  private
    FExtendedMetadata: Boolean;
    procedure UpdateCurrentSchema;
  protected
    function InternalCreateCommandGenerator(const ACommand:
      IFDPhysCommand): TFDPhysCommandGenerator; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateMetadata: TObject; override;
    procedure GetStrsMaxSizes(AStrDataType: SQLSmallint; AFixedLen: Boolean;
      out ACharSize, AByteSize: Integer); override;
    procedure UpdateDecimalSep; override;
    procedure SetupConnection; override;
    function GetExceptionClass: EODBCNativeExceptionClass; override;
  end;

  TFDPhysDB2EventAlerter = class(TFDPhysEventAlerter)
  private
    FWaitConnection: IFDPhysConnection;
    FWaitCommand: IFDPhysCommand;
    FWaitThread: TThread;
    FSignalCommand: IFDPhysCommand;
  protected
    procedure DoFired; virtual; abstract;
    procedure InternalAllocHandle; override;
    procedure InternalReleaseHandle; override;
    procedure InternalRegister; override;
    procedure InternalUnregister; override;
  end;

  TFDPhysDB2EventAlerter_DBMS_ALERT = class(TFDPhysDB2EventAlerter)
  protected
    // TFDPhysEventAlerter
    procedure DoFired; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalUnregister; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  end;

  TFDPhysDB2EventAlerter_DBMS_PIPE = class(TFDPhysDB2EventAlerter)
  private
    FReadCommand,
    FWriteCommand: IFDPhysCommand;
  protected
    // TFDPhysEventAlerter
    procedure DoFired; override;
    procedure InternalAllocHandle; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalReleaseHandle; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  end;

  TFDPhysDB2Command = class(TFDPhysODBCCommand)
  protected
    function InternalOpen: Boolean; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
  end;

const
  S_FD_Choose = 'Choose';
  S_FD_Unicode = 'Unicode';

{-------------------------------------------------------------------------------}
{ EDB2NativeException                                                           }
{-------------------------------------------------------------------------------}
function EDB2NativeException.AppendError(AHandle: TODBCHandle;
  ARecNum: SQLSmallint; const ASQLState: String; ANativeError: SQLInteger;
  const ADiagMessage, AResultMessage, ACommandText, AObject: String;
  AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer): TFDDBError;
var
  sObj: String;

  procedure ExtractObjName;
  var
    i1, i2: Integer;
  begin
    i1 := Pos('"', ADiagMessage);
    if i1 <> 0 then begin
      i2 := Pos('"', ADiagMessage, i1 + 1);
      if i2 <> 0 then
        sObj := Copy(ADiagMessage, i1 + 1, i2 - i1 - 1);
    end;
  end;

begin
  // following is not supported by DB2:
  // ekUserPwdExpired
  // ekUserPwdWillExpire
  // ekRecordLocked
  sObj := AObject;
  case ANativeError of
   100:
    AKind := ekNoDataFound;
  -803:
    begin
      AKind := ekUKViolated;
      // first "xxxx" - constraint
      // second "xxxx" - table name
      ExtractObjName;
    end;
  -530:
    begin
      AKind := ekFKViolated;
      // first "xxxx" - constraint
      ExtractObjName;
    end;
  -204:
    begin
      AKind := ekObjNotExists;
      // first "xxxx" - table name
      ExtractObjName;
    end;
  -30082:
    AKind := ekUserPwdInvalid;
  end;
  if AKind = ekOther then
    if ASQLState = '40003' then
      AKind := ekServerGone;
  Result := inherited AppendError(AHandle, ARecNum, ASQLState, ANativeError,
    ADiagMessage, AResultMessage, ACommandText, sObj, AKind, ACmdOffset,
    ARowIndex);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2DriverLink                                                          }
{-------------------------------------------------------------------------------}
function TFDPhysDB2DriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_DB2Id;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2Driver                                                              }
{-------------------------------------------------------------------------------}
class function TFDPhysDB2Driver.GetBaseDriverID: String;
begin
  Result := S_FD_DB2Id;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDB2Driver.GetBaseDriverDesc: String;
begin
  Result := 'IBM DB2 Server';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDB2Driver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.DB2;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysDB2Driver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysDB2ConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Driver.InternalLoad;
begin
  ODBCAdvanced := 'IGNOREWARNINGS=1';
  inherited InternalLoad;
  if ODBCDriver = '' then
    ODBCDriver := FindBestDriver(['IBM DATA SERVER DRIVER for ODBC%',
      'IBM DB2 ODBC DRIVER%', 'IBM DB2 DRIVER FOR ODBC%']);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Driver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysDB2Connection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Driver.GetODBCConnectStringKeywords(AKeywords: TStrings);
begin
  inherited GetODBCConnectStringKeywords(AKeywords);
  AKeywords.Add(S_FD_ConnParam_DB2_Alias + '=DBALIAS');
  AKeywords.Add(S_FD_ConnParam_Common_Database);
  AKeywords.Add(S_FD_ConnParam_Common_Server + '=HOSTNAME');
  AKeywords.Add(S_FD_ConnParam_Common_Port);
  AKeywords.Add(S_FD_ConnParam_DB2_Protocol);
  AKeywords.Add(S_FD_ConnParam_Common_OSAuthent + '=Trusted_Connection');
  AKeywords.Add('=IGNOREWARNINGS');
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Driver.BuildODBCConnectString(const AConnectionDef: IFDStanConnectionDef): String;
var
  s: String;
begin
  Result := inherited BuildODBCConnectString(AConnectionDef);
  if TFDPhysDB2ConnectionDefParams(AConnectionDef.Params).ExtendedMetadata then
    s := '1'
  else
    s := '0';
  Result := Result + ';EXTCOLINFO=' + s;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Driver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
begin
  Result := inherited GetConnParams(AKeys, AParams);

  Result.Rows.Add([Unassigned, S_FD_ConnParam_DB2_Alias, '@S', '', S_FD_ConnParam_DB2_Alias, 3]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, '@S', '', S_FD_ConnParam_Common_Server, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Port, '@I', '', S_FD_ConnParam_Common_Port, -1]); // 50000
  Result.Rows.Add([Unassigned, S_FD_ConnParam_DB2_Protocol, '@S', '', S_FD_ConnParam_DB2_Protocol, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_OSAuthent, '@Y', '', S_FD_ConnParam_Common_OSAuthent, 2]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_DB2_StringFormat, S_FD_Choose + ';' + S_FD_Unicode, S_FD_Choose, S_FD_ConnParam_DB2_StringFormat, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_ExtendedMetadata, '@L', S_FD_False, S_FD_ConnParam_Common_ExtendedMetadata, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_DB2_TxSupported, S_FD_Yes + ';' + S_FD_No, S_FD_Yes, S_FD_ConnParam_DB2_TxSupported, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefSchema, '@S', '', S_FD_ConnParam_Common_MetaDefSchema, -1]);
  Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurSchema, '@S', '', S_FD_ConnParam_Common_MetaCurSchema, -1]);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2Connection                                                          }
{-------------------------------------------------------------------------------}
function TFDPhysDB2Connection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysDB2Command.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Connection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
begin
  if CompareText(AEventKind, S_FD_EventKind_DB2_DBMS_ALERT) = 0 then
    Result := TFDPhysDB2EventAlerter_DBMS_ALERT.Create(Self, AEventKind)
  else if CompareText(AEventKind, S_FD_EventKind_DB2_DBMS_PIPE) = 0 then
    Result := TFDPhysDB2EventAlerter_DBMS_PIPE.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Connection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysDb2CommandGenerator.Create(ACommand)
  else
    Result := TFDPhysDb2CommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Connection.InternalCreateMetadata: TObject;
var
  iSrvVer, iClntVer: TFDVersion;
begin
  GetVersions(iSrvVer, iClntVer);
  Result := TFDPhysDb2Metadata.Create(Self, iSrvVer, iClntVer, GetKeywords,
    FExtendedMetadata, TFDPhysDB2ConnectionDefParams(ConnectionDef.Params).TxSupported = tsYes);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Connection.GetStrsMaxSizes(AStrDataType: SQLSmallint;
  AFixedLen: Boolean; out ACharSize: Integer; out AByteSize: Integer);
begin
  // char - 254
  // varchar - 32672
  // long varchar - 32700
  // clob - 2147483647
  // graphic - 127 * 2
  // vargraphic - 16336 * 2
  // long vargraphic - 16350 * 2
  // dbclob - 1073741823 * 2
  // blob - 2147483647
  case AStrDataType of
  SQL_C_CHAR, SQL_C_BINARY:
    begin
      if AFixedLen then
        AByteSize := 254
      else
        AByteSize := 32672;
      ACharSize := AByteSize;
    end;
  SQL_C_WCHAR:
    begin
      if AFixedLen then
        AByteSize := 254
      else
        AByteSize := 32672;
      ACharSize := AByteSize div SizeOf(SQLWChar);
    end;
  else
    FDCapabilityNotSupported(Self, [S_FD_LPhys, S_FD_DB2Id]);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Connection.UpdateDecimalSep;
var
  oStmt: TODBCCommandStatement;
  oCol: TODBCVariable;
  pData: SQLPointer;
  iSize: SQLLen;
  sNum: String;
begin
  inherited UpdateDecimalSep;
  try
    oStmt := TODBCCommandStatement.Create(ODBCConnection);
    try
      oStmt.Open(1, 'SELECT 12.34 FROM SYSIBM.SYSDUMMY1');
      oCol := oStmt.AddCol(1, SQL_NUMERIC, SQL_C_CHAR);
      oStmt.Fetch(1);
      oCol.GetData(0, pData, iSize, True);
      sNum := ODBCConnection.Encoder.Decode(pData, iSize, ecANSI);
      ODBCConnection.DecimalSepCol := sNum[3];
    finally
      FDFree(oStmt);
    end;
  except
    // silent
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Connection.GetExceptionClass: EODBCNativeExceptionClass;
begin
  Result := EDB2NativeException;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Connection.SetupConnection;
var
  oParams: TFDPhysDB2ConnectionDefParams;
begin
  inherited SetupConnection;
  oParams := ConnectionDef.Params as TFDPhysDB2ConnectionDefParams;
  FExtendedMetadata := oParams.ExtendedMetadata;
  if oParams.StringFormat = sfUnicode then
    ODBCConnection.MAPCHAR := SQL_MAPCHAR_WCHAR;
  if FExtendedMetadata then
    ODBCConnection.DESCRIBE_OUTPUT_LEVEL := 3
  else
    ODBCConnection.DESCRIBE_OUTPUT_LEVEL := 2;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Connection.UpdateCurrentSchema;
var
  oStmt: TODBCCommandStatement;
  oCol: TODBCVariable;
  pData: SQLPointer;
  iSize: SQLLen;
begin
  oStmt := TODBCCommandStatement.Create(ODBCConnection);
  try
    oStmt.Open(1, 'SELECT CURRENT_SCHEMA FROM SYSIBM.SYSDUMMY1');
    oCol := oStmt.AddCol(1, SQL_VARCHAR, SQL_C_CHAR, 30);
    oStmt.Fetch(1);
    oCol.GetData(0, pData, iSize, True);
    FCurrentSchema := ODBCConnection.Encoder.Decode(pData, iSize, ecANSI);
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2EventThread                                                         }
{-------------------------------------------------------------------------------}
type
  TFDPhysDB2EventThread = class(TThread)
  private
    [weak] FAlerter: TFDPhysDB2EventAlerter;
  protected
    procedure Execute; override;
  public
    constructor Create(AAlerter: TFDPhysDB2EventAlerter);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysDB2EventThread.Create(AAlerter: TFDPhysDB2EventAlerter);
begin
  inherited Create(False);
  FAlerter := AAlerter;
  FreeOnTerminate := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysDB2EventThread.Destroy;
begin
  FAlerter.FWaitThread := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventThread.Execute;
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
{ TFDPhysDB2EventAlerter                                                        }
{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter.InternalAllocHandle;
begin
  FWaitConnection := GetConnection.Clone;
  if FWaitConnection.State = csDisconnected then
    FWaitConnection.Open;
  FWaitConnection.CreateCommand(FWaitCommand);
  SetupCommand(FWaitCommand);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter.InternalRegister;
begin
  FWaitThread := TFDPhysDB2EventThread.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter.InternalUnregister;
begin
  FWaitThread := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter.InternalReleaseHandle;
begin
  FSignalCommand := nil;
  FWaitCommand := nil;
  FWaitConnection := nil;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2EventMessage_DBMS_ALERT                                             }
{-------------------------------------------------------------------------------}
type
  TFDPhysDB2EventMessage_DBMS_ALERT = class(TFDPhysEventMessage)
  private
    FName,
    FMessage: String;
  public
    constructor Create(const AName, AMessage: String);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysDB2EventMessage_DBMS_ALERT.Create(const AName, AMessage: String);
begin
  inherited Create;
  FName := AName;
  FMessage := AMessage;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2EventAlerter_DBMS_ALERT                                             }
{-------------------------------------------------------------------------------}
const
  C_WakeUpEvent = C_FD_SysNamePrefix + 'WAKEUP';

procedure TFDPhysDB2EventAlerter_DBMS_ALERT.InternalRegister;
var
  sSQL: String;
  i: Integer;
  oPar: TFDParam;
begin
  sSQL := 'BEGIN' + C_FD_EOL + 'CALL DBMS_ALERT.REGISTER(''' + C_WakeUpEvent + ''');' + C_FD_EOL;
  for i := 0 to GetNames().Count - 1 do
    sSQL := sSQL + 'CALL DBMS_ALERT.REGISTER(' + QuotedStr(Trim(GetNames()[i])) + ');' + C_FD_EOL;
  sSQL := sSQL + 'END;';

  FWaitCommand.Prepare(sSQL);
  FWaitCommand.Execute();

  FWaitCommand.CommandText := 'BEGIN' + C_FD_EOL +
    'CALL DBMS_ALERT.WAITANY(:name, :message, :status, :timeout);' + C_FD_EOL +
    'END;';
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

  inherited InternalRegister;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_ALERT.DoFired;
begin
  if (FWaitCommand.Params[2].AsInteger = 0) and
     (CompareText(FWaitCommand.Params[0].AsString, C_WakeUpEvent) <> 0) then
    FMsgThread.EnqueueMsg(TFDPhysDB2EventMessage_DBMS_ALERT.Create(
      FWaitCommand.Params[0].AsString, FWaitCommand.Params[1].AsString));
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_ALERT.InternalHandle(AEventMessage: TFDPhysEventMessage);
var
  oMsg: TFDPhysDB2EventMessage_DBMS_ALERT;
begin
  oMsg := TFDPhysDB2EventMessage_DBMS_ALERT(AEventMessage);
  InternalHandleEvent(oMsg.FName, oMsg.FMessage);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_ALERT.InternalAbortJob;
begin
  FWaitThread.Terminate;
  InternalSignal(C_WakeUpEvent, Null);
  FWaitCommand.AbortJob(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_ALERT.InternalUnregister;
var
  sSQL: String;
  i: Integer;
begin
  inherited InternalUnregister;

  if FWaitCommand <> nil then
    try
      sSQL := 'BEGIN' + C_FD_EOL + 'CALL DBMS_ALERT.REMOVE(''' + C_WakeUpEvent + ''');' + C_FD_EOL;
      for i := 0 to GetNames().Count - 1 do
        sSQL := sSQL + 'CALL DBMS_ALERT.REMOVE(' + QuotedStr(Trim(GetNames()[i])) + ');' + C_FD_EOL;
      sSQL := sSQL + 'END;';

      FWaitCommand.Prepare(sSQL);
      FWaitCommand.Execute();
    except
      // hide exception
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_ALERT.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  oPar: TFDParam;
begin
  if FSignalCommand = nil then begin
    GetConnection.CreateCommand(FSignalCommand);
    SetupCommand(FSignalCommand);
    FSignalCommand.CommandText := 'BEGIN CALL DBMS_ALERT.SIGNAL(:name, :message); END;';

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
{ TFDPhysDB2EventMessage_DBMS_PIPE                                              }
{-------------------------------------------------------------------------------}
type
  TFDPhysDB2EventMessage_DBMS_PIPE = class(TFDPhysEventMessage)
  private
    FName: String;
    FValues: Variant;
  public
    constructor Create(const AName: String; const AValues: Variant);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysDB2EventMessage_DBMS_PIPE.Create(const AName: String;
  const AValues: Variant);
begin
  inherited Create;
  FName := AName;
  FValues := AValues;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2EventAlerter_DBMS_PIPE                                              }
{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalAllocHandle;
begin
  if GetNames().Count > 1 then
    FDException(Self, [S_FD_LPhys, S_FD_DB2Id], er_FD_OraPipeAlertToMany, []);
  inherited InternalAllocHandle;
  FWaitConnection.CreateCommand(FReadCommand);
  SetupCommand(FReadCommand);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalRegister;
var
  oPar: TFDParam;
begin
  FWaitCommand.CommandText := 'BEGIN' + C_FD_EOL +
      'SET :result = DBMS_PIPE.RECEIVE_MESSAGE(:name, :timeout);' + C_FD_EOL +
      'END;';
  oPar := FWaitCommand.Params[0];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftInteger;

  oPar := FWaitCommand.Params[1];
  oPar.ParamType := ptInput;
  oPar.DataType := ftString;
  oPar.Size := 128;

  oPar := FWaitCommand.Params[2];
  oPar.ParamType := ptInput;
  oPar.DataType := ftInteger;
  oPar.AsInteger := 86400;

  FWaitCommand.Prepare();
  FWaitCommand.Params[1].AsString := GetNames()[0];

  FReadCommand.CommandText := 'BEGIN' + C_FD_EOL +
    'SET :tp = DBMS_PIPE.NEXT_ITEM_TYPE();' + C_FD_EOL +
    'IF :tp = 6 THEN' + C_FD_EOL +
    '  CALL DBMS_PIPE.UNPACK_MESSAGE(:num);' + C_FD_EOL +
    'ELSEIF :tp = 9 THEN' + C_FD_EOL +
    '  CALL DBMS_PIPE.UNPACK_MESSAGE(:vc);' + C_FD_EOL +
    'ELSEIF :tp = 12 THEN' + C_FD_EOL +
    '  CALL DBMS_PIPE.UNPACK_MESSAGE(:dt);' + C_FD_EOL +
    'ELSEIF :tp = 23 THEN' + C_FD_EOL +
    '  CALL DBMS_PIPE.UNPACK_MESSAGE_RAW(:vc);' + C_FD_EOL +
    'END IF;' + C_FD_EOL +
    'END;';
  oPar := FReadCommand.Params[0];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftInteger;

  oPar := FReadCommand.Params[1];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftInteger;

  oPar := FReadCommand.Params[2];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftString;
  oPar.Size := 1024;

  oPar := FReadCommand.Params[3];
  oPar.ParamType := ptOutput;
  oPar.DataType := ftDateTime;

  FReadCommand.Prepare();

  inherited InternalRegister;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.DoFired;
var
  i: Integer;
  vVal: Variant;
  aValues: Variant;
begin
  case FWaitCommand.Params[0].AsInteger of
  0: {success}
    begin
      i := 0;
      aValues := Null;
      while True do begin
        FReadCommand.Execute();
        case FReadCommand.Params[0].AsInteger of
        0:
          Break;
        9 {vc}, 23 {raw}:
          vVal := FReadCommand.Params[2].AsString;
        6 {num}:
          vVal := FReadCommand.Params[1].AsInteger;
        12 {date}:
          vVal := FReadCommand.Params[3].AsDateTime;
        else
          vVal := Null;
        end;
        if i = 0 then
          aValues := VarArrayCreate([0, 0], varVariant)
        else
          VarArrayRedim(aValues, i);
        aValues[i] := vVal;
        Inc(i);
      end;
      FMsgThread.EnqueueMsg(TFDPhysDB2EventMessage_DBMS_PIPE.Create(
        FWaitCommand.Params[1].AsString, aValues));
    end;
  1: {timeout}
    ;
  else
    FWaitThread.Terminate;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalHandle(
  AEventMessage: TFDPhysEventMessage);
var
  oMsg: TFDPhysDB2EventMessage_DBMS_PIPE;
begin
  oMsg := TFDPhysDB2EventMessage_DBMS_PIPE(AEventMessage);
  InternalHandleEvent(oMsg.FName, oMsg.FValues);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalAbortJob;
begin
  FWaitThread.Terminate;
  InternalSignal(GetNames()[0], Null);
  FWaitCommand.AbortJob(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalReleaseHandle;
begin
  FReadCommand := nil;
  FWriteCommand := nil;
  inherited InternalReleaseHandle;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2EventAlerter_DBMS_PIPE.InternalSignal(
  const AEvent: String; const AArgument: Variant);
var
  i: Integer;
  oPar: TFDParam;
begin
  if FSignalCommand = nil then begin
    GetConnection.CreateCommand(FSignalCommand);
    SetupCommand(FSignalCommand);
    FSignalCommand.CommandText := 'BEGIN DECLARE i INTEGER; i := DBMS_PIPE.SEND_MESSAGE(:name); END;';

    oPar := FSignalCommand.Params[0];
    oPar.DataType := ftString;
    oPar.Size := 128;

    FSignalCommand.Prepare();

    GetConnection.CreateCommand(FWriteCommand);
    SetupCommand(FWriteCommand);
    FWriteCommand.CommandText := 'BEGIN CALL DBMS_PIPE.PACK_MESSAGE(:name); END;';
  end;

  if VarIsArray(AArgument) then
    for i := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do begin
      FWriteCommand.Disconnect;

      oPar := FWriteCommand.Params[0];
      oPar.Clear();
      oPar.DataType := ftUnknown;
      oPar.Value := AArgument[i];

      FWriteCommand.Execute();
    end
  else if not (VarIsNull(AArgument) or VarIsEmpty(AArgument)) then begin
    FWriteCommand.Disconnect;

    oPar := FWriteCommand.Params[0];
    oPar.Clear();
    oPar.DataType := ftUnknown;
    oPar.Value := AArgument;

    FWriteCommand.Execute();
  end;

  FSignalCommand.Params[0].AsString := AEvent;
  FSignalCommand.Execute();
end;

{-------------------------------------------------------------------------------}
{ TFDPhysDB2Command                                                             }
{-------------------------------------------------------------------------------}
procedure TFDPhysDB2Command.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
begin
  inherited InternalExecute(ATimes, AOffset, ACount);
  if GetCommandKind = skSetSchema then
    TFDPhysDB2Connection(FConnectionObj).UpdateCurrentSchema;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2Command.InternalOpen: Boolean;
begin
  Result := inherited InternalOpen;
  if GetCommandKind = skSetSchema then
    TFDPhysDB2Connection(FConnectionObj).UpdateCurrentSchema;
end;

{-------------------------------------------------------------------------------}
function DB2NativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EDB2NativeException.Create;
  EDB2NativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysDB2Driver);
  FDStorageManager().RegisterClass(EDB2NativeException, 'DB2NativeException',
    @DB2NativeExceptionLoad, @FDExceptionSave);

end.
