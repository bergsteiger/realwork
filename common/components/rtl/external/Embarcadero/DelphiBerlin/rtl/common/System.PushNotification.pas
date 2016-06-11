{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.PushNotification;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Sysutils, System.JSON, System.Messaging, System.Generics.Collections;

type
  TPushServiceNotification = class;
  TPushServiceManager = class;
  TPushService = class;
  TPushServiceConnection = class;

  TPushService = class abstract
  public
    type
      TPropPair = TPair<string, string>;
      TPropArray = TArray<TPropPair>;
      // commonly used names
      TServiceNames = record
      public const
        GCM = 'gcm';  // Google cloud messaging
        APS = 'aps';  // Apple
      end;
      TAppPropNames = record
      public const
        GCMAppID = 'gcmappid';  // Google cloud messaging
      end;
      TDeviceTokenNames = record
      public const
        DeviceToken = 'devicetoken';
      end;
      TDeviceIDNames = record
      public const
        DeviceID = 'deviceid';
      end;
  public type
    TStatus = (Stopped, Starting, Started, StartupError);
    TChange = (Status, DeviceToken, StartupNotifications);
    TChanges = set of TChange;
  private
    FAppProps: TDictionary<string, string>;
    FConnections: TList<TPushServiceConnection>;
    FServiceName: string;
    FManager: TPushServiceManager;
    function GetConnection(I: Integer): TPushServiceConnection;
    function GetConnectionCount: Integer;
    procedure AddConnection(const AConnection: TPushServiceConnection);
    procedure RemoveConnection(const AConnection: TPushServiceConnection);
    procedure ForConnections(AProc: TProc<TPushServiceConnection>);
    function GetAppProp(const AName: string): string;
    procedure SetAppProp(const AName, AValue: string);
    function GetDeviceIDValue(const AName: string): string;
    function GetDeviceTokenValue(const AName: string): string;
    function GetPropValue(const AName: string; APairs: TPropArray): string;
 protected
    procedure DoChange(AChanges: TChanges);
    procedure DoReceiveNotification(const ANotification: TPushServiceNotification);
    // abstract methods
    function GetStatus: TStatus; virtual; abstract;
    procedure StartService; virtual; abstract;
    procedure StopService; virtual; abstract;
    function GetDeviceToken: TPropArray; virtual; abstract;
    function GetDeviceID: TPropArray; virtual; abstract;
    function GetStartupNotifications: TArray<TPushServiceNotification>; virtual; abstract;
    function GetStartupError: string; virtual; abstract;
  public
    constructor Create(const AOwner: TPushServiceManager; const AServiceName: string); virtual;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    function CreateConnection: TPushServiceConnection;
    function IndexOfConnection(const AConnection: TPushServiceConnection): Integer;
    property ServiceName: string read FServiceName;
    property Manager: TPushServiceManager read FManager;
    property ConnectionCount: Integer read GetConnectionCount;
    property Connections[I: Integer]: TPushServiceConnection read GetConnection;
    property Status: TStatus read GetStatus;
    // Application can provide properties used to connect to service
    property AppProps[const AName: string]: string read GetAppProp write SetAppProp;
    property DeviceToken: TPropArray read GetDeviceToken;
    property DeviceTokenValue[const AName: string]: string read GetDeviceTokenValue;
    property DeviceID: TPropArray read GetDeviceID;
    property DeviceIDValue[const AName: string]: string read GetDeviceIDValue;
    property StartupNotifications: TArray<TPushServiceNotification> read GetStartupNotifications;
    property StartupError: string read GetStartupError;
  end;

  TPushServiceConnection = class sealed
  public type
    TReceiveNotificationEvent = procedure(Sender: TObject; const ANotification: TPushServiceNotification) of object;
    TChangeEvent = procedure(Sender: TObject; AChange: TPushService.TChanges) of object;
  strict private
    FService: TPushService;
    FActive: Boolean;
    FOnReceiveNotification: TReceiveNotificationEvent;
    FOnChange: TChangeEvent;
    procedure SetActive(const Value: Boolean);
  protected
    procedure DoChange(AChanges: TPushService.TChanges);
    procedure DoReceiveNotification(const ANotification: TPushServiceNotification);
  public
    constructor Create(const AService: TPushService); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    property Active: Boolean read FActive write SetActive;
    property Service: TPushService read FService;
    property OnReceiveNotification: TReceiveNotificationEvent read FOnReceiveNotification write FOnReceiveNotification;
    property OnChange: TChangeEvent read FOnChange write FOnChange;
  end;

  TPushServiceManager = class sealed
  private type
    TServicePair = TPair<TPushService, Boolean>; // Ownership
  private class var
    FInstance: TPushServiceManager;
  private
    FServices: TList<TServicePair>;
    function GetCount: Integer; inline;
    function GetService(Index: Integer): TPushService; overload; inline;
    constructor Create;
    class function GetInstance: TPushServiceManager; static;
  public
    destructor Destroy; override;
    procedure AddService(AService: TPushService; AOwnService: Boolean = True);
    procedure RemoveService(AService: TPushService);
    function GetServiceByName(const AServiceName: string): TPushService;
    function IndexOfService(const AService: TPushService): Integer;
    property Count: Integer read GetCount;
    property Services[Index: Integer]: TPushService read GetService; default;
    class property Instance: TPushServiceManager read GetInstance;
  end;

  /// <summary>
  /// Defines the content of a push notification
  /// </summary>
  TPushServiceNotification = class abstract
  protected
    function GetDataKey: string; virtual; abstract;
    function GetJson: TJSONObject; virtual; abstract;
    function GetDataObject: TJSONObject; virtual; abstract;
  public
    property DataKey: string read GetDataKey;
    property Json: TJSONObject read GetJson;
    property DataObject: TJSONObject read GetDataObject;
  end;

  EPushServiceError = class(Exception)
  end;


implementation

uses
  System.Generics.Defaults;

{ TPushServiceManager }

destructor TPushServiceManager.Destroy;
begin
  while Count > 0 do
    RemoveService(Services[0]);
  FreeAndNil(FServices);
  inherited;
end;

function TPushServiceManager.GetCount: Integer;
begin
  Result := FServices.Count;
end;

class function TPushServiceManager.GetInstance: TPushServiceManager;
begin
  if FInstance = nil then
    FInstance := TPushServiceManager.Create;
  Result := FInstance;
end;

function TPushServiceManager.GetService(Index: Integer): TPushService;
begin
  Result := FServices[Index].Key;
end;

function TPushServiceManager.GetServiceByName(
  const AServiceName: string): TPushService;
var
  LPair: TServicePair;
begin
  Result := nil;
  for LPair in FServices do
    if SameText(LPair.Key.ServiceName, AServiceName) then
    begin
      Result := LPair.Key;
      break;
    end;
end;

function TPushServiceManager.IndexOfService(
  const AService: TPushService): Integer;
var
  LPair: TServicePair;
  I: Integer;
begin
  Result := -1;
  I := 0;
  for LPair in FServices do
  begin
    if LPair.Key = AService then
    begin
      Result := I;
      break;
    end;
    Inc(I);
  end;
end;

procedure TPushServiceManager.AddService(AService: TPushService; AOwnService: Boolean);
begin
  Assert(IndexOfService(AService) < 0);
  if IndexOfService(AService) < 0 then
  begin
    AService.FManager := Self;
    FServices.Add(TServicePair.Create(AService, AOwnService));
  end;
end;

procedure TPushServiceManager.RemoveService(AService: TPushService);
var
  LIndex: Integer;
  LService: TPushService;
begin
  LIndex := IndexOfService(AService);
  Assert(LIndex >= 0);
  if LIndex >= 0 then
  begin
    AService.FManager := nil;
    if FServices[LIndex].Value then  // Owned
    begin
      LService := FServices[LIndex].Key;
      LService.FManager := nil;
      LService.DisposeOf;
    end;
    FServices.Delete(LIndex);
  end;
end;

constructor TPushServiceManager.Create;
begin
  inherited Create;
  FServices := TList<TServicePair>.Create;
end;

{ TPushService }

procedure TPushService.AddConnection(
  const AConnection: TPushServiceConnection);
begin
  Assert(not FConnections.Contains(AConnection));
  if not FConnections.Contains(AConnection) then
    FConnections.Add(AConnection);
end;

procedure TPushService.RemoveConnection(const AConnection: TPushServiceConnection);
begin
  Assert(IndexOfConnection(AConnection) >= 0);
  FConnections.Remove(AConnection);
end;

procedure TPushService.SetAppProp(const AName, AValue: string);
begin
  FAppProps.AddOrSetValue(AName, AValue);
end;

procedure TPushService.AfterConstruction;
begin
  inherited AfterConstruction;
  if FManager <> nil then
    FManager.AddService(Self, True);
end;

constructor TPushService.Create(const AOwner: TPushServiceManager; const AServiceName: string);
begin
  inherited Create;
  FAppProps := TDictionary<string, string>.Create(TOrdinalIStringComparer.Create);
  FManager := AOwner;
  FServiceName := AServiceName;
  FConnections := TList<TPushServiceConnection>.Create;
  // AfterConstruction add to FManager
end;

function TPushService.CreateConnection: TPushServiceConnection;
begin
  Result := TPushServiceConnection.Create(Self);
end;

destructor TPushService.Destroy;
begin
  FAppProps.Free;
{$IFDEF DEBUG}
  try
    Assert(FConnections.Count = 0); // All connections should have been removed
  except
  end;
{$ENDIF}
  FConnections.Free;
  if FManager <> nil then
    FManager.RemoveService(Self);
  inherited Destroy;
end;

procedure TPushService.ForConnections(AProc: TProc<TPushServiceConnection>);
var
  I: Integer;
begin
  for I := 0 to ConnectionCount - 1 do
    AProc(Connections[I]);
end;

procedure TPushService.DoReceiveNotification(
  const ANotification: TPushServiceNotification);
begin
  ForConnections(
    procedure(AConnection: TPushServiceConnection)
    begin
      AConnection.DoReceiveNotification(ANotification);
    end);
end;

procedure TPushService.DoChange(AChanges: TChanges);
begin
  ForConnections(
    procedure(AConnection: TPushServiceConnection)
    begin
      AConnection.DoChange(AChanges);
    end);
end;

function TPushService.GetAppProp(const AName: string): string;
begin
  if not FAppProps.TryGetValue(AName, Result) then
    Result := '';
end;

function TPushService.GetConnection(
  I: Integer): TPushServiceConnection;
begin
  Result := FConnections[I];
end;

function TPushService.GetConnectionCount: Integer;
begin
  Result := FConnections.Count;
end;

function TPushService.GetPropValue(const AName: string; APairs: TPropArray): string;
var
  LPair: TPair<string, string>;
begin
  for LPair in APairs do
    if SameText(AName, LPair.Key) then
    begin
      Result := LPair.Value;
      break;
    end;
end;

function TPushService.GetDeviceIDValue(const AName: string): string;
begin
  Result := GetPropValue(AName, DeviceID);
end;

function TPushService.GetDeviceTokenValue(const AName: string): string;
begin
  Result := GetPropValue(AName, DeviceToken);
end;

function TPushService.IndexOfConnection(
  const AConnection: TPushServiceConnection): Integer;
begin
  Result := FConnections.IndexOf(AConnection);
end;

{ TPushServiceConnection }

procedure TPushServiceConnection.AfterConstruction;
begin
  inherited AfterConstruction;
  if FService <> nil then
    FService.AddConnection(Self);
end;

constructor TPushServiceConnection.Create(
  const AService: TPushService);
begin
  FService := AService;
end;

destructor TPushServiceConnection.Destroy;
begin
  if FService <> nil then
    FService.RemoveConnection(Self);
  inherited Destroy;
end;

procedure TPushServiceConnection.DoReceiveNotification(
  const ANotification: TPushServiceNotification);
begin
  if FActive then
    if Assigned(FOnReceiveNotification) then
      FOnReceiveNotification(Self, ANotification);
end;

procedure TPushServiceConnection.DoChange(AChanges: TPushService.TChanges);
begin
  if FActive then
    if Assigned(FOnChange) then
      FOnChange(Self, AChanges);
end;

procedure TPushServiceConnection.SetActive(const Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if Value and (FService.Status in [TPushService.TStatus.Stopped, TPushService.TStatus.StartupError]) then
      FService.StartService
  end;
end;

initialization
finalization
  FreeAndNil(TPushServiceManager.FInstance);

end.


