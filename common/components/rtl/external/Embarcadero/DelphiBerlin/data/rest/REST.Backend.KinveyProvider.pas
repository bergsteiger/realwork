{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Backend.KinveyProvider;

interface

uses System.Classes, System.Generics.Collections, REST.Backend.Providers,
  REST.Backend.KinveyAPI, REST.Client, REST.Backend.ServiceTypes, REST.Backend.MetaTypes;

type

  TCustomKinveyConnectionInfo = class(TComponent)
  public type
    TNotifyList = class
    private
      FList: TList<TNotifyEvent>;
      procedure Notify(Sender: TObject);
    public
      constructor Create;
      destructor Destroy; override;
      procedure Add(const ANotify: TNotifyEvent);
      procedure Remove(const ANotify: TNotifyEvent);
    end;
    TAndroidPush = class(TPersistent)
    private
      FOwner: TCustomKinveyConnectionInfo;
      FGCMAppID: string;
      procedure SetGCMAppID(const Value: string);
    protected
      procedure AssignTo(AValue: TPersistent); override;
    published
      property GCMAppID: string read FGCMAppID write SetGCMAppID;
    end;
  private
    FConnectionInfo: TKinveyApi.TConnectionInfo;
    FNotifyOnChange: TNotifyList;
    FAndroidPush: TAndroidPush;
    FPushEndpoint: string;
    procedure SetApiVersion(const Value: string);
    procedure SetAppSecret(const Value: string);
    procedure SetAppKey(const Value: string);
    procedure SetMasterSecret(const Value: string);
    function GetApiVersion: string;
    function GetAppKey: string;
    function GetAppSecret: string;
    function GetMasterSecret: string;
    procedure SetAndroidPush(const Value: TAndroidPush);
    function GetPassword: string;
    function GetUserName: string;
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetPushEndpoint(const Value: string);
    function GetProxyPassword: string;
    function GetProxyPort: integer;
    function GetProxyServer: string;
    function GetProxyUsername: string;
    procedure SetProxyPassword(const Value: string);
    procedure SetProxyPort(const Value: integer);
    procedure SetProxyServer(const Value: string);
    procedure SetProxyUsername(const Value: string);
  protected
    procedure DoChanged; virtual;
    property NotifyOnChange: TNotifyList read FNotifyOnChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateApi(const AApi: TKinveyApi);
                                  
    property ApiVersion: string read GetApiVersion write SetApiVersion;
    property AppSecret: string read GetAppSecret write SetAppSecret;
    property AppKey: string read GetAppKey write SetAppKey;
    property MasterSecret: string read GetMasterSecret write SetMasterSecret;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property AndroidPush: TAndroidPush read FAndroidPush write SetAndroidPush;
    property PushEndpoint: string read FPushEndpoint write SetPushEndpoint;
    property ProxyPassword: string read GetProxyPassword write SetProxyPassword;
    property ProxyPort: integer read GetProxyPort write SetProxyPort default 0;
    property ProxyServer: string read GetProxyServer write SetProxyServer;
    property ProxyUsername: string read GetProxyUsername write SetProxyUsername;
  end;

  TCustomKinveyProvider = class(TCustomKinveyConnectionInfo, IBackendProvider, IRESTIPComponent)
  public const
    ProviderID = 'Kinvey';
  protected
    { IBackendProvider }
    function GetProviderID: string;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TKinveyProvider = class(TCustomKinveyProvider)
  published
    property ApiVersion;
    property AppKey;
    property AppSecret;
    property MasterSecret;
    property UserName;
    property Password;
    property AndroidPush;
    property PushEndpoint;
    property ProxyPassword;
    property ProxyPort;
    property ProxyServer;
    property ProxyUsername;
  end;

  TKinveyBackendService = class(TInterfacedObject) // , IBackendService)
  private
    FConnectionInfo: TCustomKinveyConnectionInfo;
    procedure SetConnectionInfo(const Value: TCustomKinveyConnectionInfo);
    procedure OnConnectionChanged(Sender: TObject);
  protected
    procedure DoAfterConnectionChanged; virtual;
    property ConnectionInfo: TCustomKinveyConnectionInfo read FConnectionInfo write SetConnectionInfo;
  public
    constructor Create(const AProvider: IBackendProvider); virtual;
    destructor Destroy; override;
  end;

  IGetKinveyAPI = interface
    ['{ACEF8B21-82B8-4B61-B796-DB09CDCE962C}']
    function GetKinveyAPI: TKinveyAPI;
    property KinveyAPI: TKinveyAPI read GetKinveyAPI;
  end;

  TKinveyServiceAPI = class(TInterfacedObject, IBackendAPI, IGetKinveyAPI)
  private
    FKinveyAPI: TKinveyAPI;
    { IGetKinveyAPI }
    function GetKinveyAPI: TKinveyAPI;
  protected
    property KinveyAPI: TKinveyAPI read FKinveyAPI;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TKinveyServiceAPIAuth = class(TKinveyServiceAPI, IBackendAuthenticationApi)
  protected
    { IBackendAuthenticationApi }
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    procedure SetDefaultAuthentication(ADefaultAuthentication: TBackendDefaultAuthentication);
    function GetDefaultAuthentication: TBackendDefaultAuthentication;
    procedure SetAuthentication(AAuthentication: TBackendAuthentication);
    function GetAuthentication: TBackendAuthentication;
  end;

  TKinveyBackendService<TAPI: TKinveyServiceAPI, constructor> = class(TKinveyBackendService, IGetKinveyAPI)
  private
    FBackendAPI: TAPI;
    FBackendAPIIntf: IInterface;
    procedure ReleaseBackendApi;
    { IGetKinveyAPI }
    function GetKinveyAPI: TKinveyAPI;
  protected
    function CreateBackendApi: TAPI; virtual;
    procedure EnsureBackendApi;
    procedure DoAfterConnectionChanged; override;
    property BackendAPI: TAPI read FBackendAPI;
  end;

implementation

uses System.SysUtils, REST.Backend.KinveyMetaTypes, REST.Backend.Consts;

{ TCustomKinveyConnectionInfo }

constructor TCustomKinveyConnectionInfo.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionInfo := TKinveyApi.TConnectionInfo.Create(TKinveyApi.cDefaultApiVersion, '');
  FAndroidPush := TAndroidPush.Create;
  FAndroidPush.FOwner := Self;
  FNotifyOnChange := TNotifyList.Create;
end;

destructor TCustomKinveyConnectionInfo.Destroy;
begin
  FAndroidPush.Free;
  inherited;
  FNotifyOnChange.Free;
end;

procedure TCustomKinveyConnectionInfo.DoChanged;
begin
  FNotifyOnChange.Notify(Self);
end;

function TCustomKinveyConnectionInfo.GetApiVersion: string;
begin
  Result := FConnectionInfo.ApiVersion;
end;

function TCustomKinveyConnectionInfo.GetAppSecret: string;
begin
  Result := FConnectionInfo.AppSecret;
end;

function TCustomKinveyConnectionInfo.GetMasterSecret: string;
begin
  Result := FConnectionInfo.MasterSecret;
end;

function TCustomKinveyConnectionInfo.GetPassword: string;
begin
  Result := FConnectionInfo.Password;
end;

function TCustomKinveyConnectionInfo.GetProxyPassword: string;
begin
  Result := FConnectionInfo.ProxyPassword;
end;

function TCustomKinveyConnectionInfo.GetProxyPort: integer;
begin
  Result := FConnectionInfo.ProxyPort;
end;

function TCustomKinveyConnectionInfo.GetProxyServer: string;
begin
  Result := FConnectionInfo.ProxyServer;
end;

function TCustomKinveyConnectionInfo.GetProxyUsername: string;
begin
  Result := FConnectionInfo.ProxyUsername;
end;

function TCustomKinveyConnectionInfo.GetUserName: string;
begin
  Result := FConnectionInfo.UserName;
end;

function TCustomKinveyConnectionInfo.GetAppKey: string;
begin
  Result := FConnectionInfo.AppKey;
end;

procedure TCustomKinveyConnectionInfo.SetAndroidPush(
  const Value: TAndroidPush);
begin
  FAndroidPush.Assign(Value);
end;

procedure TCustomKinveyConnectionInfo.SetApiVersion(const Value: string);
begin
  if Value <> ApiVersion then
  begin
    FConnectionInfo.ApiVersion := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetAppSecret(const Value: string);
begin
  if Value <> AppSecret then
  begin
    FConnectionInfo.AppSecret := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetMasterSecret(const Value: string);
begin
  if Value <> MasterSecret then
  begin
    FConnectionInfo.MasterSecret := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetPassword(const Value: string);
begin
  if Value <> Password then
  begin
    FConnectionInfo.Password := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetProxyPassword(const Value: string);
begin
  if Value <> ProxyPassword then
  begin
    FConnectionInfo.ProxyPassword := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetProxyPort(const Value: integer);
begin
  if Value <> ProxyPort then
  begin
    FConnectionInfo.ProxyPort := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetProxyServer(const Value: string);
begin
  if Value <> ProxyServer then
  begin
    FConnectionInfo.ProxyServer := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetProxyUsername(const Value: string);
begin
  if Value <> ProxyUsername then
  begin
    FConnectionInfo.ProxyUsername := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetPushEndpoint(const Value: string);
begin
  if Value <> PushEndpoint then
  begin
    FPushEndpoint := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetUserName(const Value: string);
begin
  if Value <> UserName then
  begin
    FConnectionInfo.UserName := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.SetAppKey(const Value: string);
begin
  if Value <> AppKey then
  begin
    FConnectionInfo.AppKey := Value;
    DoChanged;
  end;
end;

procedure TCustomKinveyConnectionInfo.UpdateApi(const AApi: TKinveyApi);
begin
  AApi.ConnectionInfo := FConnectionInfo;
end;

{ TCustomKinveyConnectionInfo.TNotifyList }

procedure TCustomKinveyConnectionInfo.TNotifyList.Add(const ANotify: TNotifyEvent);
begin
  Assert(not FList.Contains(ANotify));
  if not FList.Contains(ANotify) then
    FList.Add(ANotify);
end;

constructor TCustomKinveyConnectionInfo.TNotifyList.Create;
begin
  FList := TList<TNotifyEvent>.Create;
end;

destructor TCustomKinveyConnectionInfo.TNotifyList.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TCustomKinveyConnectionInfo.TNotifyList.Notify(Sender: TObject);
var
  LProc: TNotifyEvent;
begin
  for LProc in FList do
    LProc(Sender);
end;

procedure TCustomKinveyConnectionInfo.TNotifyList.Remove(
  const ANotify: TNotifyEvent);
begin
  Assert(FList.Contains(ANotify));
  FList.Remove(ANotify);
end;

{ TCustomKinveyConnectionInfo.TAndroidProps }

procedure TCustomKinveyConnectionInfo.TAndroidPush.AssignTo(
  AValue: TPersistent);
begin
  if AValue is TAndroidPush then
  begin
    Self.FGCMAppID := TAndroidPush(AValue).FGCMAppID
  end
  else
    inherited;
end;

procedure TCustomKinveyConnectionInfo.TAndroidPush.SetGCMAppID(
  const Value: string);
begin
  if FGCMAppID <> Value then
  begin
    FGCMAppID := Value;
    FOwner.DoChanged;
  end;
end;


{ TCustomKinveyProvider }

function TCustomKinveyProvider.GetProviderID: string;
begin
  Result := ProviderID;
end;

{ TKinveyBackendService }

constructor TKinveyBackendService.Create(const AProvider: IBackendProvider);
begin
  if AProvider is TCustomKinveyConnectionInfo then
    ConnectionInfo := TCustomKinveyConnectionInfo(AProvider)
  else
    raise EArgumentException.Create('AProvider');  // Do not localize
end;

destructor TKinveyBackendService.Destroy;
begin
  if Assigned(FConnectionInfo) then
    FConnectionInfo.NotifyOnChange.Remove(OnConnectionChanged);
  inherited;
end;

procedure TKinveyBackendService.DoAfterConnectionChanged;
begin
//
end;

procedure TKinveyBackendService.OnConnectionChanged(Sender: TObject);
begin
  DoAfterConnectionChanged;
end;

procedure TKinveyBackendService.SetConnectionInfo(
  const Value: TCustomKinveyConnectionInfo);
begin
  if FConnectionInfo <> nil then
    FConnectionInfo.NotifyOnChange.Remove(OnConnectionChanged);
  FConnectionInfo := Value;
  if FConnectionInfo <> nil then
    FConnectionInfo.NotifyOnChange.Add(OnConnectionChanged);
  OnConnectionChanged(Self);
end;

{ TKinveyServiceAPI }

constructor TKinveyServiceAPI.Create;
begin
  FKinveyAPI := TKinveyAPI.Create(nil);
end;

destructor TKinveyServiceAPI.Destroy;
begin
  FKinveyAPI.Free;
  inherited;
end;

function TKinveyServiceAPI.GetKinveyAPI: TKinveyAPI;
begin
  Result := FKinveyAPI;
end;

{ TKinveyBackendService<TAPI> }

function TKinveyBackendService<TAPI>.CreateBackendApi: TAPI;
begin
  Result := TAPI.Create;
  if ConnectionInfo <> nil then
    ConnectionInfo.UpdateAPI(Result.FKinveyAPI)
  else
    Result.FKinveyAPI.ConnectionInfo := TKinveyAPI.EmptyConnectionInfo;
end;

procedure TKinveyBackendService<TAPI>.EnsureBackendApi;
begin
  if FBackendAPI = nil then
  begin
    FBackendAPI := CreateBackendApi;
    FBackendAPIIntf := FBackendAPI; // Reference
  end;
end;

function TKinveyBackendService<TAPI>.GetKinveyAPI: TKinveyAPI;
begin
  EnsureBackendApi;
  if FBackendAPI <> nil then
    Result := FBackendAPI.FKinveyAPI;
end;

procedure TKinveyBackendService<TAPI>.ReleaseBackendApi;
begin
  FBackendAPI := nil;
  FBackendAPIIntf := nil;
end;

procedure TKinveyBackendService<TAPI>.DoAfterConnectionChanged;
begin
  ReleaseBackendApi;
end;

{ TKinveyServiceAPIAuth }

function TKinveyServiceAPIAuth.GetAuthentication: TBackendAuthentication;
begin
  case KinveyApi.Authentication of
    TKinveyApi.TAuthentication.Default:
      Result := TBackendAuthentication.Default;
    TKinveyApi.TAuthentication.MasterSecret:
      Result := TBackendAuthentication.Root;
    TKinveyApi.TAuthentication.UserName:
      Result := TBackendAuthentication.User;
    TKinveyApi.TAuthentication.Session:
      Result := TBackendAuthentication.Session;
  else
    Assert(False);
    Result := TBackendAuthentication.Default;
  end;
end;

function TKinveyServiceAPIAuth.GetDefaultAuthentication: TBackendDefaultAuthentication;
begin
  case KinveyApi.DefaultAuthentication of
    TKinveyApi.TDefaultAuthentication.MasterSecret:
      Result := TBackendDefaultAuthentication.Root;
    TKinveyApi.TDefaultAuthentication.UserName:
      Result := TBackendDefaultAuthentication.User;
    TKinveyApi.TDefaultAuthentication.Session:
      Result := TBackendDefaultAuthentication.Session;
  else
    Assert(False);
    Result := TBackendDefaultAuthentication.Root;
  end;
end;

procedure TKinveyServiceAPIAuth.Login(const ALogin: TBackendEntityValue);
var
  LMetaLogin: TMetaLogin;
begin
  if ALogin.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(ALogin.Data);
    KinveyAPI.Login(LMetaLogin.Login);
  end
  else
    raise EArgumentException.Create(sParameterNotLogin);  
end;

procedure TKinveyServiceAPIAuth.Logout;
begin
  KinveyAPI.Logout;
end;

procedure TKinveyServiceAPIAuth.SetAuthentication(
  AAuthentication: TBackendAuthentication);
begin
  case AAuthentication of
    TBackendAuthentication.Default:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.Default;
    TBackendAuthentication.Root:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.MasterSecret;
    TBackendAuthentication.Application:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.AppSecret;
    TBackendAuthentication.User:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.UserName;
    TBackendAuthentication.Session:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.Session;
    TBackendAuthentication.None:
      FKinveyAPI.Authentication := TKinveyApi.TAuthentication.None;
  else
    Assert(False);
  end;
end;

procedure TKinveyServiceAPIAuth.SetDefaultAuthentication(
  ADefaultAuthentication: TBackendDefaultAuthentication);
begin
  case ADefaultAuthentication of
    TBackendDefaultAuthentication.Root:
      FKinveyAPI.DefaultAuthentication := TKinveyApi.TDefaultAuthentication.MasterSecret;
    TBackendDefaultAuthentication.Application:
      FKinveyAPI.DefaultAuthentication := TKinveyApi.TDefaultAuthentication.AppSecret;
    TBackendDefaultAuthentication.User:
      FKinveyAPI.DefaultAuthentication := TKinveyApi.TDefaultAuthentication.UserName;
    TBackendDefaultAuthentication.Session:
      FKinveyAPI.DefaultAuthentication := TKinveyApi.TDefaultAuthentication.Session;
    TBackendDefaultAuthentication.None:
      FKinveyAPI.DefaultAuthentication := TKinveyApi.TDefaultAuthentication.None;
  else
    Assert(False);
  end;
end;

const
  sDisplayName = 'Kinvey';
initialization
  TBackendProviders.Instance.Register(TCustomKinveyProvider.ProviderID, sDisplayName);
finalization
  TBackendProviders.Instance.UnRegister(TCustomKinveyProvider.ProviderID);
end.
