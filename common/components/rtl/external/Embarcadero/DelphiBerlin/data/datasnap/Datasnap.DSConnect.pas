{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

/// <summary> DBX DataSnap Connection Support </summary>
/// <remarks>
///  This unit contains the TDSProviderConnection component which provides
///  connectivity to a DataSnap server using DBX.
///  <para>
///
///  To Use:
///   - Add TDSProviderConnection to a DataSnap client application along
///     with a TClientDataSet and a TSQLConnection.
///
///   - Configure the TSQLConnection with the appropriate connection settings.
///
///   - Connect the TDSProviderConnection to the TSQLConnection.
///
///   - Set the ServerClassName property to the name of the TRemoteDataModule.
///
///   - Connect the TDSProviderConnection to the TSQLConnection.
///
///
///  At this point the DataSnap client should be configured and ready to use
///  just like any other DataSnap client.  See the documentation for DataSnap
///  for additional information.
///  </para>
///
/// </remarks>

unit Datasnap.DSConnect;

interface

uses
{$IF DEFINED(MSWINDOWS) and NOT DEFINED(NEXTGEN)}
  Winapi.ActiveX,
{$ENDIF}
  System.Types,
  System.Classes,
  Datasnap.DBClient,
  Data.DBXCommon,
  Datasnap.Midas,
  Data.SqlExpr;

type

{ TDSProviderConnection }

  /// <summary>Provide connectivity to DataSnap server using
  /// dbExpress.</summary>
  TDSProviderConnection = class(TCustomRemoteServer, IAppServer{$IFDEF MSWINDOWS}{$IFNDEF NEXTGEN}, ISupportErrorInfo{$ENDIF}{$ENDIF})
  private
    FAppServer: IAppServer;
    FServerClassName: string;
    [Weak]FSQLConnection: TSQLConnection;
    FApplyUpdatesCommand:     TDBXCommand;
    FGetRecordsCommand:       TDBXCommand;
    FDataRequestCommand:      TDBXCommand;
    FGetProviderNamesCommand: TDBXCommand;
    FGetParamsCommand:        TDBXCommand;
    FRowRequestCommand:       TDBXCommand;
    FExecuteCommand:          TDBXCommand;
    FRowRequest:              TDBXCommand;
    procedure SetSQLConnection(const Value: TSQLConnection);
    procedure SetServerClassName(const Value: string);
    function GetDBXConnection: TDBXConnection;
    procedure FreeCommands;
    procedure ConnectChange(Sender: TObject; Connecting: Boolean);
  protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;
    function GetConnected: Boolean; override;
    procedure SetConnected(Value: Boolean); override;
    function GetCommandObject(const ProcedureName: string): TDBXCommand;
    property Connection: TDBXConnection read GetDBXConnection;
  protected
    { IAppServer }
    function AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
      MaxErrors: Integer; out ErrorCount: Integer;
      var OwnerData: OleVariant): OleVariant; safecall;
    function AS_GetRecords(const ProviderName: OleStr; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: OleStr;
      var Params, OwnerData: OleVariant): OleVariant; safecall;
    function AS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; safecall;
    function AS_GetProviderNames: OleVariant; safecall;
    function AS_GetParams(const ProviderName: OleStr;
      var OwnerData: OleVariant): OleVariant; safecall;
    function AS_RowRequest(const ProviderName: OleStr; Row: OleVariant;
      RequestType: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
    var Params, OwnerData: OleVariant); safecall;
    { ISupportErrorInfo }
    function InterfaceSupportsErrorInfo(const iid: TGUID): HResult; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    ///<summary>
    ///  Get the IAppServer interface implemented by this component.
    ///</summary>
    property AppServer: IAppServer read FAppServer;
    function GetServer: IAppServer; override;
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    ///<summary>
    ///  The class name of the Remote DataModule class on the server (excludes leading "T").
    ///</summary>
    property ServerClassName: string read FServerClassName write SetServerClassName;
    ///<summary>
    ///  The state of the connection.
    ///</summary>
    property Connected;
    ///<summary>
    ///  Associated TSQLConnection used to connect to the server.
    ///</summary>
    property SQLConnection: TSQLConnection read FSQLConnection write SetSQLConnection;
  end;

implementation

uses
{$IF DEFINED(MSWINDOWS) and not DEFINED(NEXTGEN)}
  System.Win.ComObj,
{$ENDIF MSWINDOWS and not NEXTGEN}
  Data.DBXClientResStrs,
  Data.DSUtil,
  System.SysUtils,
  System.Variants;

const
  // IAppServer method names
  SAS_ApplyUpdates = 'AS_ApplyUpdates';
  SAS_GetRecords = 'AS_GetRecords';
  SAS_DataRequest = 'AS_DataRequest';
  SAS_GetProviderNames = 'AS_GetProviderNames:';
  SAS_GetParams = 'AS_GetParams';
  SAS_RowRequest = 'AS_RowRequest';
  SAS_Execute = 'AS_Execute';

{ TDSProviderConnection }

procedure TDSProviderConnection.ConnectChange(Sender: TObject;
  Connecting: Boolean);
begin
  if Sender = FSQLConnection then
  begin
    if Connecting then
      DoConnect
    else
      DoDisconnect;
  end;
end;

constructor TDSProviderConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAppServer := Self as IAppServer;
end;

destructor TDSProviderConnection.Destroy;
begin
  FAppServer := nil;
  FreeCommands;
  if Assigned(FSQLConnection) then
  begin
    FSQLConnection.RemoveFreeNotification(Self);
    FSQLConnection.RemoveConnectNotification(Self);
  end;
  inherited;
end;


procedure TDSProviderConnection.DoConnect;
begin
  // Missing FSQLConnection check is in SetConnected.  Nil check below is "just in case".
  if FSQLConnection <> nil then
    FSQLConnection.Connected := True;
  SetAppServer(FAppServer);
end;


procedure TDSProviderConnection.DoDisconnect;
begin
  SetAppServer(NULL);
  FreeCommands;
  // Multiple TDSProviderConnections can share this...
//  if FSQLConnection <> nil then
//    FSQLConnection.Connected := False;
end;

procedure TDSProviderConnection.FreeCommands;
begin
  FreeAndNil(FApplyUpdatesCommand);
  FreeAndNil(FGetRecordsCommand);
  FreeAndNil(FDataRequestCommand);
  FreeAndNil(FGetProviderNamesCommand);
  FreeAndNil(FGetParamsCommand);
  FreeAndNil(FRowRequestCommand);
  FreeAndNil(FExecuteCommand);
  FreeAndNil(FRowRequest);
end;

function TDSProviderConnection.GetCommandObject(const ProcedureName: string): TDBXCommand;
begin
  SetConnected(True);
  Result := Connection.CreateCommand;
  Result.CommandType := TDBXCommandTypes.DSServerMethod;
  Result.Text := Format('%s.%s', [ServerClassName, ProcedureName]);
  Result.Prepare;
end;


function TDSProviderConnection.GetConnected: Boolean;
begin
  Result := Assigned(FSQLConnection) and FSQLConnection.Connected;
end;

function TDSProviderConnection.GetDBXConnection: TDBXConnection;
begin
  if FSQLConnection <> nil then
    Result := FSQLConnection.DBXConnection
  else
    Result := nil;
end;

function TDSProviderConnection.GetServer: IAppServer;
begin
  Connected := True;
  Result := FAppServer;
  SetAppServer(Result);
end;

function TDSProviderConnection.AS_ApplyUpdates(const ProviderName: OleStr;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
var
  Command: TDBXCommand;
begin
  if FApplyUpdatesCommand = nil then
    FApplyUpdatesCommand := GetCommandObject(SAS_ApplyUpdates);
  Command := FApplyUpdatesCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.AsVariant := Delta;
  Command.Parameters[2].Value.SetInt32(MaxErrors);
  Command.Parameters[3].Value.SetInt32(ErrorCount);
  Command.Parameters[4].Value.AsVariant := OwnerData;
  Command.Parameters[5].Value.SetNull; // Result

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output and result parameters
  ErrorCount := Command.Parameters[3].Value.GetInt32;
  OwnerData := Command.Parameters[4].Value.AsVariant;
  Result := Command.Parameters[5].Value.AsVariant;
end;

function TDSProviderConnection.AS_DataRequest(const ProviderName: OleStr;
  Data: OleVariant): OleVariant;
var
  Command: TDBXCommand;
begin
  if FDataRequestCommand = nil then
    FDataRequestCommand := GetCommandObject(SAS_DataRequest);
  Command := FDataRequestCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.AsVariant := Data;
  Command.Parameters[2].Value.SetNull; // Result

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output and result parameters
  Result := Command.Parameters[2].Value.AsVariant;
end;

procedure TDSProviderConnection.AS_Execute(const ProviderName, CommandText: OleStr;
  var Params, OwnerData: OleVariant);
var
  Command: TDBXCommand;
begin
  if FExecuteCommand = nil then
    FExecuteCommand := GetCommandObject(SAS_Execute);
  Command := FExecuteCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.SetWideString(CommandText);
  Command.Parameters[2].Value.AsVariant := Params;
  Command.Parameters[3].Value.AsVariant := OwnerData;

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output parameters
  Params := Command.Parameters[2].Value.AsVariant;
  OwnerData := Command.Parameters[3].Value.AsVariant;
end;

function TDSProviderConnection.AS_GetParams(const ProviderName: OleStr;
  var OwnerData: OleVariant): OleVariant;
var
  Command: TDBXCommand;
begin
  if FGetParamsCommand = nil then
    FGetParamsCommand := GetCommandObject(SAS_GetParams);
  Command := FGetParamsCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.AsVariant := OwnerData;
  Command.Parameters[2].Value.SetNull; // Result

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output parameters
  OwnerData := Command.Parameters[1].Value.AsVariant;
  Result := Command.Parameters[2].Value.AsVariant;
end;

function TDSProviderConnection.AS_GetProviderNames: OleVariant;
var
  Command: TDBXCommand;
begin
  if FGetProviderNamesCommand = nil then
    FGetProviderNamesCommand := GetCommandObject(SAS_GetProviderNames);
  Command := FGetProviderNamesCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetNull;

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign the result parameter
  StrListToVarArray(Command.Parameters[0].Value.GetWideString, Result);
end;

function TDSProviderConnection.AS_GetRecords(const ProviderName: OleStr;
  Count: Integer; out RecsOut: Integer; Options: Integer;
  const CommandText: OleStr; var Params, OwnerData: OleVariant): OleVariant;
var
  Command: TDBXCommand;
begin
  if FGetRecordsCommand = nil then
    FGetRecordsCommand := GetCommandObject(SAS_GetRecords);
  Command := FGetRecordsCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.SetInt32(Count);
  Command.Parameters[2].Value.SetInt32(RecsOut);
  Command.Parameters[3].Value.SetInt32(Options);
  Command.Parameters[4].Value.SetWideString(CommandText);
  Command.Parameters[5].Value.AsVariant := Params;
  Command.Parameters[6].Value.AsVariant := OwnerData;
  Command.Parameters[7].Value.SetNull; // Result

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output and result parameters
  RecsOut := Command.Parameters[2].Value.GetInt32;
  Params := Command.Parameters[5].Value.AsVariant;
  OwnerData := Command.Parameters[6].Value.AsVariant;
  Result := Command.Parameters[7].Value.AsVariant;
end;

function TDSProviderConnection.AS_RowRequest(const ProviderName: OleStr;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
var
  Command: TDBXCommand;
begin
  if FRowRequestCommand = nil then
    FRowRequestCommand := GetCommandObject(SAS_RowRequest);
  Command := FRowRequestCommand;

  // Setup input parameters
  Command.Parameters[0].Value.SetWideString(ProviderName);
  Command.Parameters[1].Value.AsVariant := Row;
  Command.Parameters[2].Value.SetInt32(RequestType);
  Command.Parameters[3].Value.AsVariant := OwnerData;
  Command.Parameters[4].Value.SetNull; // Result

  // Invoke the server method
  Command.ExecuteUpdate;

  // Assign output and result parameters
  OwnerData := Command.Parameters[3].Value.AsVariant;
  Result := Command.Parameters[4].Value.AsVariant;
end;

function TDSProviderConnection.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
begin
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IAppServer, '', '');
end;

function TDSProviderConnection.InterfaceSupportsErrorInfo(const iid: TGUID): HResult;
begin
  if IsEqualGUID(IAppServer, iid) then
    Result := S_OK else
    Result := S_FALSE;
end;

procedure TDSProviderConnection.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSQLConnection) then
    FSQLConnection := nil;
end;

procedure TDSProviderConnection.SetConnected(Value: Boolean);
begin
  if (not (csReading in ComponentState)) and
     (Value and not Connected) and
     ((FServerClassName = '') or
     (FSQLConnection = nil)) then
    raise Exception.CreateResFmt(@SMissingServerSettings, [Name]);
  inherited;
end;


procedure TDSProviderConnection.SetServerClassName(const Value: string);
begin
  if Value <> FServerClassName then
  begin
    FreeCommands;
    FServerClassName := Value;
  end;
end;

procedure TDSProviderConnection.SetSQLConnection(const Value: TSQLConnection);
begin
  if Assigned(FSQLConnection) then
  begin
    FSQLConnection.RemoveFreeNotification(Self);
    FSQLConnection.RemoveConnectNotification(Self);
  end;
  FSQLConnection := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self);
    Value.AddConnectNotification(Self, ConnectChange);
  end;
end;

end.
