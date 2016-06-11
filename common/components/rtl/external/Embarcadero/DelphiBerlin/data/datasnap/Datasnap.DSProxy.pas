{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProxy;

interface

uses System.JSON, Data.DBXCommon, Data.DBXJSONReflect, Data.DbxCompressionFilter;

type
  /// <summary>Base class for generated proxies which implements the most
  /// important DSAdmin functions.</summary>
  TDSAdminClient = class
  protected
    FDBXConnection: TDBXConnection;
    FInstanceOwner: Boolean;
    FMarshal:   TJSONMarshal;
    FUnMarshal: TJSONUnMarshal;
  private
    FGetPlatformNameCommand: TDBXCommand;
    FClearResourcesCommand: TDBXCommand;
    FFindPackagesCommand: TDBXCommand;
    FFindClassesCommand: TDBXCommand;
    FFindMethodsCommand: TDBXCommand;
    FGetServerMethodsCommand: TDBXCommand;
    FGetServerMethodParametersCommand: TDBXCommand;
    FGetDatabaseConnectionPropertiesCommand: TDBXCommand;
    FBroadcastToChannelCommand: TDBXCommand;
    FBroadcastObjectToChannelCommand: TDBXCommand;
    FNotifyCallbackCommand: TDBXCommand;
    FNotifyObjectCommand: TDBXCommand;
    FListClassesCommand: TDBXCommand;
    FDescribeClassCommand: TDBXCommand;
    FListMethodsCommand: TDBXCommand;
    FDescribeMethodCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetPlatformName: string;
    function ClearResources: Boolean;
    function FindPackages: TDBXReader;
    function FindClasses(PackageName: string; ClassPattern: string): TDBXReader;
    function FindMethods(PackageName: string; ClassPattern: string; MethodPattern: string): TDBXReader;
    function GetServerMethods: TDBXReader;
    function GetServerMethodParameters: TDBXReader;
    function GetDatabaseConnectionProperties: TDBXReader;
    function BroadcastToChannel(ChannelName: string; Msg: TJSONValue): Boolean;
    function BroadcastObjectToChannel(ChannelName: string; Msg: TObject): Boolean;
    function NotifyCallback(ClientId: string; CallbackId: string; Msg: TJSONValue; out Response: TJSONValue): Boolean; overload;
    function NotifyObject(ClientId: string; CallbackId: string; Msg: TObject; out Response: TObject): Boolean; overload;
    function ListClasses: TJSONArray;
    function DescribeClass(ClassName: string): TJSONObject;
    function ListMethods(ClassName: string): TJSONArray;
    function DescribeMethod(ServerMethodName: string): TJSONObject;

{$IFNDEF NEXTGEN}
    /// <summary> Deprecated: Use NotifyCallback which takes no ChannelName, instead.</summary>
    function NotifyCallback(ChannelName: string; ClientId: string; CallbackId: string; Msg: TJSONValue; out Response: TJSONValue): Boolean; overload; deprecated 'ChannelName is no longer required';
    /// <summary> Deprecated: Use NotifyObject which takes no ChannelName, instead.</summary>
    function NotifyObject(ChannelName: string; ClientId: string; CallbackId: string; Msg: TObject; out Response: TObject): Boolean; overload; deprecated 'ChannelName is no longer required';
{$ENDIF !NEXTGEN}
    property InstanceOwner: Boolean read FInstanceOwner;
  end;

implementation

uses System.Classes, Data.DBXClient, System.SysUtils;

{ TDSAdminClient }

function TDSAdminClient.GetPlatformName: string;
begin
  if FGetPlatformNameCommand = nil then
  begin
    FGetPlatformNameCommand := FDBXConnection.CreateCommand;
    FGetPlatformNameCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetPlatformNameCommand.Text := 'DSAdmin.GetPlatformName';
    FGetPlatformNameCommand.Prepare;
  end;
  FGetPlatformNameCommand.ExecuteUpdate;
  Result := FGetPlatformNameCommand.Parameters[0].Value.GetWideString;
end;

function TDSAdminClient.ClearResources: Boolean;
begin
  if FClearResourcesCommand = nil then
  begin
    FClearResourcesCommand := FDBXConnection.CreateCommand;
    FClearResourcesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FClearResourcesCommand.Text := 'DSAdmin.ClearResources';
    FClearResourcesCommand.Prepare;
  end;
  FClearResourcesCommand.ExecuteUpdate;
  Result := FClearResourcesCommand.Parameters[0].Value.GetBoolean;
end;

function TDSAdminClient.FindPackages: TDBXReader;
begin
  if FFindPackagesCommand = nil then
  begin
    FFindPackagesCommand := FDBXConnection.CreateCommand;
    FFindPackagesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindPackagesCommand.Text := 'DSAdmin.FindPackages';
    FFindPackagesCommand.Prepare;
  end;
  FFindPackagesCommand.ExecuteUpdate;
  Result := FFindPackagesCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.FindClasses(PackageName: string; ClassPattern: string): TDBXReader;
begin
  if FFindClassesCommand = nil then
  begin
    FFindClassesCommand := FDBXConnection.CreateCommand;
    FFindClassesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindClassesCommand.Text := 'DSAdmin.FindClasses';
    FFindClassesCommand.Prepare;
  end;
  FFindClassesCommand.Parameters[0].Value.SetWideString(PackageName);
  FFindClassesCommand.Parameters[1].Value.SetWideString(ClassPattern);
  FFindClassesCommand.ExecuteUpdate;
  Result := FFindClassesCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.FindMethods(PackageName: string; ClassPattern: string; MethodPattern: string): TDBXReader;
begin
  if FFindMethodsCommand = nil then
  begin
    FFindMethodsCommand := FDBXConnection.CreateCommand;
    FFindMethodsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindMethodsCommand.Text := 'DSAdmin.FindMethods';
    FFindMethodsCommand.Prepare;
  end;
  FFindMethodsCommand.Parameters[0].Value.SetWideString(PackageName);
  FFindMethodsCommand.Parameters[1].Value.SetWideString(ClassPattern);
  FFindMethodsCommand.Parameters[2].Value.SetWideString(MethodPattern);
  FFindMethodsCommand.ExecuteUpdate;
  Result := FFindMethodsCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.GetServerMethods: TDBXReader;
begin
  if FGetServerMethodsCommand = nil then
  begin
    FGetServerMethodsCommand := FDBXConnection.CreateCommand;
    FGetServerMethodsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetServerMethodsCommand.Text := 'DSAdmin.GetServerMethods';
    FGetServerMethodsCommand.Prepare;
  end;
  FGetServerMethodsCommand.ExecuteUpdate;
  Result := FGetServerMethodsCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.GetServerMethodParameters: TDBXReader;
begin
  if FGetServerMethodParametersCommand = nil then
  begin
    FGetServerMethodParametersCommand := FDBXConnection.CreateCommand;
    FGetServerMethodParametersCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetServerMethodParametersCommand.Text := 'DSAdmin.GetServerMethodParameters';
    FGetServerMethodParametersCommand.Prepare;
  end;
  FGetServerMethodParametersCommand.ExecuteUpdate;
  Result := FGetServerMethodParametersCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.GetDatabaseConnectionProperties: TDBXReader;
begin
  if FGetDatabaseConnectionPropertiesCommand = nil then
  begin
    FGetDatabaseConnectionPropertiesCommand := FDBXConnection.CreateCommand;
    FGetDatabaseConnectionPropertiesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetDatabaseConnectionPropertiesCommand.Text := 'DSAdmin.GetDatabaseConnectionProperties';
    FGetDatabaseConnectionPropertiesCommand.Prepare;
  end;
  FGetDatabaseConnectionPropertiesCommand.ExecuteUpdate;
  Result := FGetDatabaseConnectionPropertiesCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminClient.BroadcastToChannel(ChannelName: string; Msg: TJSONValue): Boolean;
begin
  if FBroadcastToChannelCommand = nil then
  begin
    FBroadcastToChannelCommand := FDBXConnection.CreateCommand;
    FBroadcastToChannelCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FBroadcastToChannelCommand.Text := 'DSAdmin.BroadcastToChannel';
    FBroadcastToChannelCommand.Prepare;
  end;
  FBroadcastToChannelCommand.Parameters[0].Value.SetWideString(ChannelName);
  FBroadcastToChannelCommand.Parameters[1].Value.SetJSONValue(Msg, FInstanceOwner);
  FBroadcastToChannelCommand.ExecuteUpdate;
  Result := FBroadcastToChannelCommand.Parameters[2].Value.GetBoolean;
end;

function TDSAdminClient.BroadcastObjectToChannel(ChannelName: string; Msg: TObject): Boolean;
begin
  if FBroadcastObjectToChannelCommand = nil then
  begin
    FBroadcastObjectToChannelCommand := FDBXConnection.CreateCommand;
    FBroadcastObjectToChannelCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FBroadcastObjectToChannelCommand.Text := 'DSAdmin.BroadcastObjectToChannel';
    FBroadcastObjectToChannelCommand.Prepare;
  end;
  FBroadcastObjectToChannelCommand.Parameters[0].Value.SetWideString(ChannelName);
  if not Assigned(Msg) then
    FBroadcastObjectToChannelCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FBroadcastObjectToChannelCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FBroadcastObjectToChannelCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(Msg), True);
      if FInstanceOwner then
        Msg.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FBroadcastObjectToChannelCommand.ExecuteUpdate;
  Result := FBroadcastObjectToChannelCommand.Parameters[2].Value.GetBoolean;
end;

function TDSAdminClient.NotifyCallback(ClientId: string; CallbackId: string; Msg: TJSONValue; out Response: TJSONValue): Boolean;
begin
  if FNotifyCallbackCommand = nil then
  begin
    FNotifyCallbackCommand := FDBXConnection.CreateCommand;
    FNotifyCallbackCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNotifyCallbackCommand.Text := 'DSAdmin.NotifyCallback';
    FNotifyCallbackCommand.Prepare;
  end;
  FNotifyCallbackCommand.Parameters[0].Value.SetWideString(ClientId);
  FNotifyCallbackCommand.Parameters[1].Value.SetWideString(CallbackId);
  FNotifyCallbackCommand.Parameters[2].Value.SetJSONValue(Msg, FInstanceOwner);
  FNotifyCallbackCommand.ExecuteUpdate;
  Response := TJSONValue(FNotifyCallbackCommand.Parameters[3].Value.GetJSONValue(FInstanceOwner));
  Result := FNotifyCallbackCommand.Parameters[4].Value.GetBoolean;
end;

function TDSAdminClient.NotifyObject(ClientId: string; CallbackId: string; Msg: TObject; out Response: TObject): Boolean;
begin
  if FNotifyObjectCommand = nil then
  begin
    FNotifyObjectCommand := FDBXConnection.CreateCommand;
    FNotifyObjectCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNotifyObjectCommand.Text := 'DSAdmin.NotifyObject';
    FNotifyObjectCommand.Prepare;
  end;
  FNotifyObjectCommand.Parameters[0].Value.SetWideString(ClientId);
  FNotifyObjectCommand.Parameters[1].Value.SetWideString(CallbackId);
  if not Assigned(Msg) then
    FNotifyObjectCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FNotifyObjectCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FNotifyObjectCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(Msg), True);
      if FInstanceOwner then
        Msg.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FNotifyObjectCommand.ExecuteUpdate;
  if not FNotifyObjectCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FNotifyObjectCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Response := TObject(FUnMarshal.UnMarshal(FNotifyObjectCommand.Parameters[3].Value.GetJSONValue(True)));
    finally
      FreeAndNil(FUnMarshal)
    end;
  end
  else
    Response := nil;
  Result := FNotifyObjectCommand.Parameters[4].Value.GetBoolean;
end;

function TDSAdminClient.ListClasses: TJSONArray;
begin
  if FListClassesCommand = nil then
  begin
    FListClassesCommand := FDBXConnection.CreateCommand;
    FListClassesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListClassesCommand.Text := 'DSAdmin.ListClasses';
    FListClassesCommand.Prepare;
  end;
  FListClassesCommand.ExecuteUpdate;
  Result := TJSONArray(FListClassesCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminClient.DescribeClass(ClassName: string): TJSONObject;
begin
  if FDescribeClassCommand = nil then
  begin
    FDescribeClassCommand := FDBXConnection.CreateCommand;
    FDescribeClassCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDescribeClassCommand.Text := 'DSAdmin.DescribeClass';
    FDescribeClassCommand.Prepare;
  end;
  FDescribeClassCommand.Parameters[0].Value.SetWideString(ClassName);
  FDescribeClassCommand.ExecuteUpdate;
  Result := TJSONObject(FDescribeClassCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminClient.ListMethods(ClassName: string): TJSONArray;
begin
  if FListMethodsCommand = nil then
  begin
    FListMethodsCommand := FDBXConnection.CreateCommand;
    FListMethodsCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListMethodsCommand.Text := 'DSAdmin.ListMethods';
    FListMethodsCommand.Prepare;
  end;
  FListMethodsCommand.Parameters[0].Value.SetWideString(ClassName);
  FListMethodsCommand.ExecuteUpdate;
  Result := TJSONArray(FListMethodsCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminClient.DescribeMethod(ServerMethodName: string): TJSONObject;
begin
  if FDescribeMethodCommand = nil then
  begin
    FDescribeMethodCommand := FDBXConnection.CreateCommand;
    FDescribeMethodCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDescribeMethodCommand.Text := 'DSAdmin.DescribeMethod';
    FDescribeMethodCommand.Prepare;
  end;
  FDescribeMethodCommand.Parameters[0].Value.SetWideString(ServerMethodName);
  FDescribeMethodCommand.ExecuteUpdate;
  Result := TJSONObject(FDescribeMethodCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;


constructor TDSAdminClient.Create(ADBXConnection: TDBXConnection);
begin
  Create(ADBXConnection, True);
end;


constructor TDSAdminClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create;
  if ADBXConnection = nil then
    raise EInvalidOperation.Create('Connection cannot be nil.  Make sure the connection has been opened.');
  FDBXConnection := ADBXConnection;
  FInstanceOwner := AInstanceOwner;
end;


destructor TDSAdminClient.Destroy;
begin
  FreeAndNil(FGetPlatformNameCommand);
  FreeAndNil(FClearResourcesCommand);
  FreeAndNil(FFindPackagesCommand);
  FreeAndNil(FFindClassesCommand);
  FreeAndNil(FFindMethodsCommand);
  FreeAndNil(FGetServerMethodsCommand);
  FreeAndNil(FGetServerMethodParametersCommand);
  FreeAndNil(FGetDatabaseConnectionPropertiesCommand);
  FreeAndNil(FBroadcastToChannelCommand);
  FreeAndNil(FBroadcastObjectToChannelCommand);
  FreeAndNil(FNotifyCallbackCommand);
  FreeAndNil(FNotifyObjectCommand);
  FreeAndNil(FListClassesCommand);
  FreeAndNil(FDescribeClassCommand);
  FreeAndNil(FListMethodsCommand);
  FreeAndNil(FDescribeMethodCommand);
  inherited;
end;

{$IFNDEF NEXTGEN}
function TDSAdminClient.NotifyCallback(ChannelName, ClientId, CallbackId: string; Msg: TJSONValue;
  out Response: TJSONValue): Boolean;
begin
  Result := NotifyCallback(ClientId, CallbackId, Msg, Response);
end;

function TDSAdminClient.NotifyObject(ChannelName, ClientId, CallbackId: string; Msg: TObject;
  out Response: TObject): Boolean;
begin
  Result := NotifyObject(ClientId, CallbackId, Msg, Response);
end;
{$ENDIF !NEXTGEN}

end.
