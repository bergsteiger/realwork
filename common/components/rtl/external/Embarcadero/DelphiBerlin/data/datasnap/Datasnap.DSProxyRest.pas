{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProxyRest;

interface

uses Data.DBXCommon, System.JSON, Data.DBXJSONReflect, Datasnap.DSClientRest, Datasnap.DSCommonProxy;

type

  TDSRestClient = class
  protected
    FInstanceOwner: Boolean;
    [Weak]FConnection: TDSCustomRestConnection;
  public
    constructor Create(AConnection: TDSCustomRestConnection); overload;
    constructor Create(AConnection: TDSCustomRestConnection; AInstanceOwner: Boolean); overload;
    property InstanceOwner: Boolean read FInstanceOwner;
  end;

  TDSRestProxyMetaDataLoader = class(TInterfacedObject, IDSProxyMetaDataLoader)
  private
    FConnection: TDSCustomRestConnection;
    { IDSProxyMetaDataLoader }
    procedure Load(MetaData: TDSProxyMetadata);
    procedure LoadFromConnection(AConnection: TDSCustomRestConnection; AMetaData: TDSProxyMetadata);
  public
    constructor Create(AConnection: TDSCustomRestConnection);
  end;

 /// <summary>Base class for generated proxies that implements the most
 /// important DSAdmin functions.</summary>
 TDSAdminRestClient = class(TDSRestClient)
  protected
    FDConnection: TDSRestCommand;
    FMarshal:   TJSONMarshal;
    FUnMarshal: TJSONUnMarshal;
  private
    FGetPlatformNameCommand: TDSRestCommand;
    FClearResourcesCommand: TDSRestCommand;
    FFindPackagesCommand: TDSRestCommand;
    FFindClassesCommand: TDSRestCommand;
    FFindMethodsCommand: TDSRestCommand;
    FListClassesCommand: TDSRestCommand;
    FDescribeClassCommand: TDSRestCommand;
    FListMethodsCommand: TDSRestCommand;
    FDescribeMethodCommand: TDSRestCommand;
    FGetServerMethodsCommand: TDSRestCommand;
    FGetServerMethodParametersCommand: TDSRestCommand;
    FGetDatabaseConnectionPropertiesCommand: TDSRestCommand;
    FConsumeClientChannelCommand: TDSRestCommand;
    FConsumeClientChannelTimeoutCommand: TDSRestCommand;
    FCloseClientChannelCommand: TDSRestCommand;
    FRegisterClientCallbackServerCommand: TDSRestCommand;
    FUnregisterClientCallbackCommand: TDSRestCommand;
    FBroadcastToChannelCommand: TDSRestCommand;
    FBroadcastObjectToChannelCommand: TDSRestCommand;
    FNotifyCallbackCommand: TDSRestCommand;
    FNotifyObjectCommand: TDSRestCommand;
    FClearSessionCommand: TDSRestCommand;
  public
    constructor Create(AConnection: TDSCustomRestConnection); overload;
    constructor Create(AConnection: TDSCustomRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetPlatformName: string;
    function ClearResources: Boolean;
    function FindPackages: TDBXReader;
    function FindClasses(PackageName: string; ClassPattern: string): TDBXReader;
    function FindMethods(PackageName: string; ClassPattern: string; MethodPattern: string): TDBXReader;
    function ListClasses: TJSONArray;
    function DescribeClass(ClassName: string): TJSONObject;
    function ListMethods(ClassName: string): TJSONArray;
    function DescribeMethod(ServerMethodName: string): TJSONObject;
    function GetServerMethods: TDBXReader;
    function GetServerMethodParameters: TDBXReader;
    function GetDatabaseConnectionProperties: TDBXReader;
    function ConsumeClientChannel(ChannelName, ClientManagerId, CallbackId, ChannelNames: string;
                                  ResponseData: TJSONValue): TJSONValue;
    function ConsumeClientChannelTimeout(ChannelName, ClientManagerId, CallbackId, ChannelNames: string;
                                         Timeout: Integer; ResponseData: TJSONValue): TJSONValue;
    function CloseClientChannel(ChannelId: string): Boolean;
    function RegisterClientCallbackServer(ChannelId, CallbackId, ChannelNames: string): Boolean;
    function UnregisterClientCallback(ChannelId, CallbackId: string): Boolean;
    function BroadcastToChannel(ChannelName: string; Msg: TJSONValue): Boolean;
    function BroadcastObjectToChannel(ChannelName: string; Msg: TObject): Boolean;
    function NotifyCallback(ClientId: string; CallbackId: string; Msg: TJSONValue; out Response: TJSONValue): Boolean;
    function NotifyObject(ClientId: string; CallbackId: string; Msg: TObject; out Response: TObject): Boolean;
    procedure ClearSession;
  end;

var
  GDSProxyRestSecurityToken: string = ' ';

const
  DSAdmin_GetPlatformName: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  DSAdmin_ClearResources: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_FindPackages: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_FindClasses: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'PackageName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ClassPattern'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_FindMethods: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'PackageName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ClassPattern'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'MethodPattern'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_ListClasses: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  DSAdmin_DescribeClass: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClassName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  DSAdmin_ListMethods: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClassName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  DSAdmin_DescribeMethod: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ServerMethodName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  DSAdmin_GetServerMethods: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_GetServerMethodParameters: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_GetDatabaseConnectionProperties: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  DSAdmin_GetDSServerName: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  DSAdmin_CloseClientChannel: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_UnregisterClientCallback: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_BroadcastToChannel: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Msg'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_BroadcastObjectToChannel: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Msg'; Direction: 1; DBXType: 37; TypeName: 'TObject'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_NotifyCallback: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'ClientId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Msg'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: 'Response'; Direction: 2; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_NotifyObject: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'ClientId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Msg'; Direction: 1; DBXType: 37; TypeName: 'TObject'),
    (Name: 'Response'; Direction: 2; DBXType: 37; TypeName: 'TObject'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_ConsumeClientChannelSecure: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ClientManagerId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ChannelNames'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'SecurityToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ResponseData'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  DSAdmin_ConsumeClientChannelTimeoutSecure: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ClientManagerId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ChannelNames'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'SecurityToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Timeout'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'ResponseData'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  DSAdmin_CloseClientChannelSecure: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'SecurityToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_RegisterClientCallbackServerSecure: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ChannelNames'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'SecurityToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  DSAdmin_UnregisterClientCallbackSecure: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'ChannelId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CallbackId'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'SecurityToken'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

uses System.Classes, Data.DBXClientResStrs, Data.DBXCommonTable, System.SysUtils;

function GetSecurityToken: string;
begin
  if GDSProxyRestSecurityToken = ' ' then
    GDSProxyRestSecurityToken := IntToStr(Random(100000)) + '.' + IntToStr(Random(100000));
  Result := GDSProxyRestSecurityToken;
end;

{ TDSAdminRestClient }

function TDSAdminRestClient.GetPlatformName: string;
begin
  if FGetPlatformNameCommand = nil then
  begin
    FGetPlatformNameCommand := FConnection.CreateCommand;
    FGetPlatformNameCommand.RequestType := 'GET';
    FGetPlatformNameCommand.Text := 'DSAdmin.GetPlatformName';
    FGetPlatformNameCommand.Prepare(DSAdmin_GetPlatformName);
  end;
  FGetPlatformNameCommand.Execute;
  Result := FGetPlatformNameCommand.Parameters[0].Value.GetWideString;
end;

function TDSAdminRestClient.ClearResources: Boolean;
begin
  if FClearResourcesCommand = nil then
  begin
    FClearResourcesCommand := FConnection.CreateCommand;
    FClearResourcesCommand.RequestType := 'GET';
    FClearResourcesCommand.Text := 'DSAdmin.ClearResources';
    FClearResourcesCommand.Prepare(DSAdmin_ClearResources);
  end;
  FClearResourcesCommand.Execute;
  Result := FClearResourcesCommand.Parameters[0].Value.GetBoolean;
end;

function TDSAdminRestClient.FindPackages: TDBXReader;
begin
  if FFindPackagesCommand = nil then
  begin
    FFindPackagesCommand := FConnection.CreateCommand;
    FFindPackagesCommand.RequestType := 'GET';
    FFindPackagesCommand.Text := 'DSAdmin.FindPackages';
    FFindPackagesCommand.Prepare(DSAdmin_FindPackages);
  end;
  FFindPackagesCommand.Execute;
  Result := FFindPackagesCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.FindClasses(PackageName: string; ClassPattern: string): TDBXReader;
begin
  if FFindClassesCommand = nil then
  begin
    FFindClassesCommand := FConnection.CreateCommand;
    FFindClassesCommand.RequestType := 'GET';
    FFindClassesCommand.Text := 'DSAdmin.FindClasses';
    FFindClassesCommand.Prepare(DSAdmin_FindClasses);
  end;
  FFindClassesCommand.Parameters[0].Value.SetWideString(PackageName);
  FFindClassesCommand.Parameters[1].Value.SetWideString(ClassPattern);
  FFindClassesCommand.Execute;
  Result := FFindClassesCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.FindMethods(PackageName: string; ClassPattern: string; MethodPattern: string): TDBXReader;
begin
  if FFindMethodsCommand = nil then
  begin
    FFindMethodsCommand := FConnection.CreateCommand;
    FFindMethodsCommand.RequestType := 'GET';
    FFindMethodsCommand.Text := 'DSAdmin.FindMethods';
    FFindMethodsCommand.Prepare(DSAdmin_FindMethods);
  end;
  FFindMethodsCommand.Parameters[0].Value.SetWideString(PackageName);
  FFindMethodsCommand.Parameters[1].Value.SetWideString(ClassPattern);
  FFindMethodsCommand.Parameters[2].Value.SetWideString(MethodPattern);
  FFindMethodsCommand.Execute;
  Result := FFindMethodsCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.ListClasses: TJSONArray;
begin
  if FListClassesCommand = nil then
  begin
    FListClassesCommand := FConnection.CreateCommand;
    FListClassesCommand.RequestType := 'GET';
    FListClassesCommand.Text := 'DSAdmin.ListClasses';
    FListClassesCommand.Prepare(DSAdmin_ListClasses);
  end;
  FListClassesCommand.Execute;
  Result := TJSONArray(FListClassesCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.DescribeClass(ClassName: string): TJSONObject;
begin
  if FDescribeClassCommand = nil then
  begin
    FDescribeClassCommand := FConnection.CreateCommand;
    FDescribeClassCommand.RequestType := 'GET';
    FDescribeClassCommand.Text := 'DSAdmin.DescribeClass';
    FDescribeClassCommand.Prepare(DSAdmin_DescribeClass);
  end;
  FDescribeClassCommand.Parameters[0].Value.SetWideString(ClassName);
  FDescribeClassCommand.Execute;
  Result := TJSONObject(FDescribeClassCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.ListMethods(ClassName: string): TJSONArray;
begin
  if FListMethodsCommand = nil then
  begin
    FListMethodsCommand := FConnection.CreateCommand;
    FListMethodsCommand.RequestType := 'GET';
    FListMethodsCommand.Text := 'DSAdmin.ListMethods';
    FListMethodsCommand.Prepare(DSAdmin_ListMethods);
  end;
  FListMethodsCommand.Parameters[0].Value.SetWideString(ClassName);
  FListMethodsCommand.Execute;
  Result := TJSONArray(FListMethodsCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.DescribeMethod(ServerMethodName: string): TJSONObject;
begin
  if FDescribeMethodCommand = nil then
  begin
    FDescribeMethodCommand := FConnection.CreateCommand;
    FDescribeMethodCommand.RequestType := 'GET';
    FDescribeMethodCommand.Text := 'DSAdmin.DescribeMethod';
    FDescribeMethodCommand.Prepare(DSAdmin_DescribeMethod);
  end;
  FDescribeMethodCommand.Parameters[0].Value.SetWideString(ServerMethodName);
  FDescribeMethodCommand.Execute;
  Result := TJSONObject(FDescribeMethodCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.GetServerMethods: TDBXReader;
begin
  if FGetServerMethodsCommand = nil then
  begin
    FGetServerMethodsCommand := FConnection.CreateCommand;
    FGetServerMethodsCommand.RequestType := 'GET';
    FGetServerMethodsCommand.Text := 'DSAdmin.GetServerMethods';
    FGetServerMethodsCommand.Prepare(DSAdmin_GetServerMethods);
  end;
  FGetServerMethodsCommand.Execute;
  Result := FGetServerMethodsCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.GetServerMethodParameters: TDBXReader;
begin
  if FGetServerMethodParametersCommand = nil then
  begin
    FGetServerMethodParametersCommand := FConnection.CreateCommand;
    FGetServerMethodParametersCommand.RequestType := 'GET';
    FGetServerMethodParametersCommand.Text := 'DSAdmin.GetServerMethodParameters';
    FGetServerMethodParametersCommand.Prepare(DSAdmin_GetServerMethodParameters);
  end;
  FGetServerMethodParametersCommand.Execute;
  Result := FGetServerMethodParametersCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.GetDatabaseConnectionProperties: TDBXReader;
begin
  if FGetDatabaseConnectionPropertiesCommand = nil then
  begin
    FGetDatabaseConnectionPropertiesCommand := FConnection.CreateCommand;
    FGetDatabaseConnectionPropertiesCommand.RequestType := 'GET';
    FGetDatabaseConnectionPropertiesCommand.Text := 'DSAdmin.GetDatabaseConnectionProperties';
    FGetDatabaseConnectionPropertiesCommand.Prepare(DSAdmin_GetDatabaseConnectionProperties);
  end;
  FGetDatabaseConnectionPropertiesCommand.Execute;
  Result := FGetDatabaseConnectionPropertiesCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSAdminRestClient.ConsumeClientChannel(ChannelName, ClientManagerId, CallbackId, ChannelNames: string;
                                                 ResponseData: TJSONValue): TJSONValue;
begin
  if FConsumeClientChannelCommand = nil then
  begin
    FConsumeClientChannelCommand := FConnection.CreateCommand;
    FConsumeClientChannelCommand.RequestType := 'POST';
    FConsumeClientChannelCommand.Text := 'DSAdmin."ConsumeClientChannel"';
    FConsumeClientChannelCommand.Prepare(DSAdmin_ConsumeClientChannelSecure);
  end;
  FConsumeClientChannelCommand.Parameters[0].Value.SetWideString(ChannelName);
  FConsumeClientChannelCommand.Parameters[1].Value.SetWideString(ClientManagerId);
  FConsumeClientChannelCommand.Parameters[2].Value.SetWideString(CallbackId);
  FConsumeClientChannelCommand.Parameters[3].Value.SetWideString(ChannelNames);
  FConsumeClientChannelCommand.Parameters[4].Value.SetWideString(GetSecurityToken);
  FConsumeClientChannelCommand.Parameters[5].Value.SetJSONValue(ResponseData, FInstanceOwner);
  FConsumeClientChannelCommand.Execute;
  Result := TJSONValue(FConsumeClientChannelCommand.Parameters[6].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.ConsumeClientChannelTimeout(ChannelName, ClientManagerId, CallbackId, ChannelNames: string;
                                                        Timeout: Integer; ResponseData: TJSONValue): TJSONValue;
begin
  if FConsumeClientChannelTimeoutCommand = nil then
  begin
    FConsumeClientChannelTimeoutCommand := FConnection.CreateCommand;
    FConsumeClientChannelTimeoutCommand.RequestType := 'POST';
    FConsumeClientChannelTimeoutCommand.Text := 'DSAdmin."ConsumeClientChannelTimeout"';
    FConsumeClientChannelTimeoutCommand.Prepare(DSAdmin_ConsumeClientChannelTimeoutSecure);
  end;
  FConsumeClientChannelTimeoutCommand.Parameters[0].Value.SetWideString(ChannelName);
  FConsumeClientChannelTimeoutCommand.Parameters[1].Value.SetWideString(ClientManagerId);
  FConsumeClientChannelTimeoutCommand.Parameters[2].Value.SetWideString(CallbackId);
  FConsumeClientChannelTimeoutCommand.Parameters[3].Value.SetWideString(ChannelNames);
  FConsumeClientChannelTimeoutCommand.Parameters[4].Value.SetWideString(GetSecurityToken);
  FConsumeClientChannelTimeoutCommand.Parameters[5].Value.SetInt32(Timeout);
  FConsumeClientChannelTimeoutCommand.Parameters[6].Value.SetJSONValue(ResponseData, FInstanceOwner);
  FConsumeClientChannelTimeoutCommand.Execute;
  Result := TJSONValue(FConsumeClientChannelTimeoutCommand.Parameters[7].Value.GetJSONValue(FInstanceOwner));
end;

function TDSAdminRestClient.CloseClientChannel(ChannelId: string): Boolean;
begin
  if FCloseClientChannelCommand = nil then
  begin
    FCloseClientChannelCommand := FConnection.CreateCommand;
    FCloseClientChannelCommand.RequestType := 'GET';
    FCloseClientChannelCommand.Text := 'DSAdmin.CloseClientChannel';
    FCloseClientChannelCommand.Prepare(DSAdmin_CloseClientChannelSecure);
  end;
  FCloseClientChannelCommand.Parameters[0].Value.SetWideString(ChannelId);
  FCloseClientChannelCommand.Parameters[1].Value.SetWideString(GetSecurityToken);
  FCloseClientChannelCommand.Execute;
  Result := FCloseClientChannelCommand.Parameters[2].Value.GetBoolean;
end;

function TDSAdminRestClient.RegisterClientCallbackServer(ChannelId, CallbackId, ChannelNames: string): Boolean;
begin
  if FRegisterClientCallbackServerCommand = nil then
  begin
    FRegisterClientCallbackServerCommand := FConnection.CreateCommand;
    FRegisterClientCallbackServerCommand.RequestType := 'GET';
    FRegisterClientCallbackServerCommand.Text := 'DSAdmin.RegisterClientCallbackServer';
    FRegisterClientCallbackServerCommand.Prepare(DSAdmin_RegisterClientCallbackServerSecure);
  end;
  FRegisterClientCallbackServerCommand.Parameters[0].Value.SetWideString(ChannelId);
  FRegisterClientCallbackServerCommand.Parameters[1].Value.SetWideString(CallbackId);
  FRegisterClientCallbackServerCommand.Parameters[2].Value.SetWideString(ChannelNames);
  FRegisterClientCallbackServerCommand.Parameters[3].Value.SetWideString(GetSecurityToken);
  FRegisterClientCallbackServerCommand.Execute;
  Result := FRegisterClientCallbackServerCommand.Parameters[4].Value.GetBoolean;
end;

function TDSAdminRestClient.UnregisterClientCallback(ChannelId, CallbackId: string): Boolean;
begin
  if FUnregisterClientCallbackCommand = nil then
  begin
    FUnregisterClientCallbackCommand := FConnection.CreateCommand;
    FUnregisterClientCallbackCommand.RequestType := 'GET';
    FUnregisterClientCallbackCommand.Text := 'DSAdmin.UnregisterClientCallback';
    FUnregisterClientCallbackCommand.Prepare(DSAdmin_UnregisterClientCallbackSecure);
  end;
  FUnregisterClientCallbackCommand.Parameters[0].Value.SetWideString(ChannelId);
  FUnregisterClientCallbackCommand.Parameters[1].Value.SetWideString(CallbackId);
  FUnregisterClientCallbackCommand.Parameters[2].Value.SetWideString(GetSecurityToken);
  FUnregisterClientCallbackCommand.Execute;
  Result := FUnregisterClientCallbackCommand.Parameters[3].Value.GetBoolean;
end;

function TDSAdminRestClient.BroadcastToChannel(ChannelName: string; Msg: TJSONValue): Boolean;
begin
  if FBroadcastToChannelCommand = nil then
  begin
    FBroadcastToChannelCommand := FConnection.CreateCommand;
    FBroadcastToChannelCommand.RequestType := 'POST';
    FBroadcastToChannelCommand.Text := 'DSAdmin."BroadcastToChannel"';
    FBroadcastToChannelCommand.Prepare(DSAdmin_BroadcastToChannel);
  end;
  FBroadcastToChannelCommand.Parameters[0].Value.SetWideString(ChannelName);
  FBroadcastToChannelCommand.Parameters[1].Value.SetJSONValue(Msg, FInstanceOwner);
  FBroadcastToChannelCommand.Execute;
  Result := FBroadcastToChannelCommand.Parameters[2].Value.GetBoolean;
end;

function TDSAdminRestClient.BroadcastObjectToChannel(ChannelName: string; Msg: TObject): Boolean;
begin
  if FBroadcastObjectToChannelCommand = nil then
  begin
    FBroadcastObjectToChannelCommand := FConnection.CreateCommand;
    FBroadcastObjectToChannelCommand.RequestType := 'POST';
    FBroadcastObjectToChannelCommand.Text := 'DSAdmin."BroadcastObjectToChannel"';
    FBroadcastObjectToChannelCommand.Prepare(DSAdmin_BroadcastObjectToChannel);
  end;
  FBroadcastObjectToChannelCommand.Parameters[0].Value.SetWideString(ChannelName);
  if not Assigned(Msg) then
    FBroadcastObjectToChannelCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FBroadcastObjectToChannelCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FBroadcastObjectToChannelCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(Msg), True);
      if FInstanceOwner then
        Msg.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FBroadcastObjectToChannelCommand.Execute;
  Result := FBroadcastObjectToChannelCommand.Parameters[2].Value.GetBoolean;
end;

function TDSAdminRestClient.NotifyCallback(ClientId: string; CallbackId: string; Msg: TJSONValue; out Response: TJSONValue): Boolean;
begin
  if FNotifyCallbackCommand = nil then
  begin
    FNotifyCallbackCommand := FConnection.CreateCommand;
    FNotifyCallbackCommand.RequestType := 'POST';
    FNotifyCallbackCommand.Text := 'DSAdmin."NotifyCallback"';
    FNotifyCallbackCommand.Prepare(DSAdmin_NotifyCallback);
  end;
  FNotifyCallbackCommand.Parameters[0].Value.SetWideString(ClientId);
  FNotifyCallbackCommand.Parameters[1].Value.SetWideString(CallbackId);
  FNotifyCallbackCommand.Parameters[2].Value.SetJSONValue(Msg, FInstanceOwner);
  FNotifyCallbackCommand.Execute;
  Response := TJSONValue(FNotifyCallbackCommand.Parameters[3].Value.GetJSONValue(FInstanceOwner));
  Result := FNotifyCallbackCommand.Parameters[4].Value.GetBoolean;
end;

function TDSAdminRestClient.NotifyObject(ClientId: string; CallbackId: string; Msg: TObject; out Response: TObject): Boolean;
begin
  if FNotifyObjectCommand = nil then
  begin
    FNotifyObjectCommand := FConnection.CreateCommand;
    FNotifyObjectCommand.RequestType := 'POST';
    FNotifyObjectCommand.Text := 'DSAdmin."NotifyObject"';
    FNotifyObjectCommand.Prepare(DSAdmin_NotifyObject);
  end;
  FNotifyObjectCommand.Parameters[0].Value.SetWideString(ClientId);
  FNotifyObjectCommand.Parameters[1].Value.SetWideString(CallbackId);
  if not Assigned(Msg) then
    FNotifyObjectCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FNotifyObjectCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FNotifyObjectCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(Msg), True);
      if FInstanceOwner then
        Msg.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FNotifyObjectCommand.Execute;
  if not FNotifyObjectCommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FNotifyObjectCommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
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

procedure TDSAdminRestClient.ClearSession;
begin
  if FClearSessionCommand = nil then
  begin
    FClearSessionCommand := FConnection.CreateCommand;
    FClearSessionCommand.RequestType := 'GET';
    FClearSessionCommand.Text := 'DSAdmin.ClearSession';
  end;
  FClearSessionCommand.Execute;
end;

constructor TDSAdminRestClient.Create(AConnection: TDSCustomRestConnection);
begin
  inherited Create(AConnection);
end;

constructor TDSAdminRestClient.Create(AConnection: TDSCustomRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(AConnection, AInstanceOwner);
end;

destructor TDSAdminRestClient.Destroy;
begin
  FreeAndNil(FGetPlatformNameCommand);
  FreeAndNil(FClearResourcesCommand);
  FreeAndNil(FFindPackagesCommand);
  FreeAndNil(FFindClassesCommand);
  FreeAndNil(FFindMethodsCommand);
  FreeAndNil(FListClassesCommand);
  FreeAndNil(FDescribeClassCommand);
  FreeAndNil(FListMethodsCommand);
  FreeAndNil(FDescribeMethodCommand);
  FreeAndNil(FGetServerMethodsCommand);
  FreeAndNil(FGetServerMethodParametersCommand);
  FreeAndNil(FGetDatabaseConnectionPropertiesCommand);
  FreeAndNil(FConsumeClientChannelCommand);
  FreeAndNil(FConsumeClientChannelTimeoutCommand);
  FreeAndNil(FCloseClientChannelCommand);
  FreeAndNil(FRegisterClientCallbackServerCommand);
  FreeAndNil(FUnregisterClientCallbackCommand);
  FreeAndNil(FBroadcastToChannelCommand);
  FreeAndNil(FBroadcastObjectToChannelCommand);
  FreeAndNil(FNotifyCallbackCommand);
  FreeAndNil(FNotifyObjectCommand);
  FreeAndNil(FClearSessionCommand);
  inherited;
end;

{ TDSRestClient }

constructor TDSRestClient.Create(AConnection: TDSCustomRestConnection; AInstanceOwner: Boolean);
begin
  FConnection := AConnection;
  FInstanceOwner := AInstanceOwner;
end;

constructor TDSRestClient.Create(AConnection: TDSCustomRestConnection);
begin
  Create(AConnection, True);
end;

{ TDSProxyMetaDataLoader }

constructor TDSRestProxyMetaDataLoader.Create(AConnection: TDSCustomRestConnection);
begin
  FConnection := AConnection;
end;

procedure TDSRestProxyMetaDataLoader.Load(MetaData: TDSProxyMetadata);
var
  LConnection: TDSCustomRestConnection;
begin
  LConnection := FConnection;
  if LConnection <> nil then
    LoadFromConnection(LConnection, MetaData);
  if LConnection = nil then
    raise TDSProxyException.Create(SNoConnection);
end;

procedure TDSRestProxyMetaDataLoader.LoadFromConnection(AConnection: TDSCustomRestConnection; AMetaData: TDSProxyMetadata);
var
  LClient: TDSAdminRestClient;
  LReader: TDBXReader;
  LTable: TDBXTable;
  LMethodParameters:   TDSMethodParametersEntity;
begin
  LMethodParameters := nil;
  LClient := TDSAdminRestClient.Create(AConnection, True);
  try
    LReader := LClient.GetServerMethodParameters;
    try
      LTable := TDBXReaderTable.Create(LReader);
      LMethodParameters := TDSMethodParametersEntity.Create(LTable, True);
      AMetaData.LoadMetadata(LMethodParameters);
    finally
      //LTable.Free;
      LMethodParameters.Free;
      if csDesigning in AConnection.ComponentState then
        try
          AConnection.SessionId := '';
          AConnection.HTTP.Disconnect;
        except
        end;
    end;
  finally
    LClient.Free;
  end;
end;

end.
