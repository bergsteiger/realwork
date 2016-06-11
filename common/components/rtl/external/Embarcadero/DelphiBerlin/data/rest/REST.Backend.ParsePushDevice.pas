{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.ParsePushDevice;

{$HPPEMIT LINKUNIT}
interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.PushNotification,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.ParseProvider,
  REST.Backend.ParseApi,
  REST.Backend.Exception,
  REST.Backend.MetaTypes;

type


{$IFDEF IOS}
{$DEFINE PUSH}
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE PUSH}
{$ENDIF}

  TParsePushDeviceAPI = class(TParseServiceAPIAuth, IBackendPushDeviceApi, IBackendPushDeviceApi2)
  private const
    sParse = 'Parse';
  private
    FGCMAppID: String;
    FInstallationID: string;
{$IFDEF PUSH}
    FInstallationObjectID: string;
{$ENDIF}
  protected
    { IBackendPushDeviceAPI }
    function GetPushService: TPushService; // May raise exception
    function HasPushService: Boolean;
    procedure RegisterDevice(AOnRegistered: TDeviceRegisteredAtProviderEvent); overload;
    procedure UnregisterDevice;
    { IBackendPushDeviceAPI2 }
    procedure RegisterDevice(const AProperties: TJSONObject; AOnRegistered: TDeviceRegisteredAtProviderEvent); overload;
    /// <summary>Get the identify of the installation object after a device has been registered.  True is returned if the identity
    /// is available.  Use the TBackendEntityValue.ObjectID property to retrieve the object id of the installation object.
    /// </summary>
    function TryGetInstallationValue(out AValue: TBackendEntityValue): Boolean;
  end;

  TParsePushDeviceService = class(TParseBackendService<TParsePushDeviceAPI>, IBackendService, IBackendPushDeviceService)
  protected
    function CreateBackendApi: TParsePushDeviceAPI; override;
    { IBackendPushDeviceService }
    function CreatePushDeviceApi: IBackendPushDeviceApi;
    function GetPushDeviceApi: IBackendPushDeviceApi;
  end;

  EParsePushNotificationError = class(EBackendServiceError); 

implementation

uses
  System.Generics.Collections,
  System.TypInfo,
  REST.Backend.Consts,
  REST.Backend.ServiceFactory,
  REST.Backend.ParseMetaTypes
{$IFDEF PUSH}
{$IFDEF IOS}
  ,FMX.PushNotification.IOS // inject IOS push provider
{$ENDIF}
{$IFDEF ANDROID}
  ,FMX.PushNotification.Android // inject GCM push provider
{$ENDIF}
{$ENDIF}
  ;

{ TParsePushDeviceService }

function TParsePushDeviceService.CreatePushDeviceApi: IBackendPushDeviceApi;
begin
  Result := CreateBackendApi;
end;

function TParsePushDeviceService.CreateBackendApi: TParsePushDeviceAPI;
begin
  Result := inherited;
  if ConnectionInfo <> nil then
  begin
    Result.FGCMAppID := ConnectionInfo.AndroidPush.GCMAppID;
    Result.FInstallationID := ConnectionInfo.AndroidPush.InstallationID
  end
  else
  begin
    Result.FGCMAppID := '';
    Result.FInstallationID := '';
  end;
end;

function TParsePushDeviceService.GetPushDeviceApi: IBackendPushDeviceApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParsePushDeviceAPI }

function GetDeviceID(const AService: TPushService): string;
begin
  Result := AService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID];
end;

function GetDeviceName: string;
begin
{$IFDEF IOS}
  Result := 'ios';
{$ENDIF}
{$IFDEF ANDROID}
  Result := 'android';
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := 'windows';
{$ENDIF}
end;

function GetServiceName: string;
begin
{$IFDEF PUSH}
{$IFDEF IOS}
  Result := TPushService.TServiceNames.APS;
{$ENDIF}
{$IFDEF ANDROID}
  Result := TPushService.TServiceNames.GCM;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := '';
{$ENDIF}
{$ENDIF}
end;

function GetService(const AServiceName: string): TPushService;
begin
  Result := TPushServiceManager.Instance.GetServiceByName(AServiceName);
end;

procedure GetRegistrationInfo(const APushService: TPushService;
  out ADeviceID, ADeviceToken: string);
begin
  ADeviceID := APushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID];
  ADeviceToken := APushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];

  if ADeviceID = ''  then
    raise EParsePushNotificationError.Create(sDeviceIDUnavailable); 

  if ADeviceToken = ''  then
    raise EParsePushNotificationError.Create(sDeviceTokenUnavailable);   
end;

function TParsePushDeviceAPI.GetPushService: TPushService;
var
  LServiceName: string;
  LDeviceName: string;
  LService: TPushService;
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EParsePushNotificationError.CreateFmt(sPushDeviceNoPushService, [sParse, LDeviceName]);

  LService := GetService(LServiceName);
  if LService = nil then
    raise EParsePushNotificationError.CreateFmt(sPushDevicePushServiceNotFound, [sParse, LServiceName]);
  if LService.ServiceName = TPushService.TServiceNames.GCM then
    if not (LService.Status in [TPushService.TStatus.Started]) then
    begin
      if FGCMAppID = '' then
        raise EParsePushNotificationError.Create(sPushDeviceGCMAppIDBlank);
      LService.AppProps[TPushService.TAppPropNames.GCMAppID] := FGCMAppID;
    end;
  Result := LService;
end;

function TParsePushDeviceAPI.HasPushService: Boolean;
var
  LServiceName: string;
begin
  LServiceName := GetServiceName;
  Result := (LServiceName <> '') and (GetService(LServiceName) <> nil);
end;

procedure TParsePushDeviceAPI.RegisterDevice(
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
begin
  RegisterDevice(nil, AOnRegistered);
end;

function TParsePushDeviceAPI.TryGetInstallationValue(
  out AValue: TBackendEntityValue): Boolean;
begin
{$IFDEF PUSH}
  Result := FInstallationObjectID <> '';
  if Result then
    AValue := TBackendEntityValue.Create(TMetaObjectID.Create(TParseAPI.TObjectID.Create('', FInstallationObjectID)));
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure TParsePushDeviceAPI.RegisterDevice(const AProperties: TJSONObject;
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
var
  LDeviceName: string;
  LServiceName: string;
{$IFDEF PUSH}
  LDeviceID: string;
  LDeviceToken: string;
  ANewObject: TParseAPI.TObjectID;
  AUpdateObject: TParseAPI.TUpdatedAt;
  LJSONObject: TJSONObject;
{$ENDIF}
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EParsePushNotificationError.CreateFmt(sPushDeviceNoPushService, [sParse, LDeviceName]);

// Badge and Channel properties
{$IFDEF PUSH}
  GetRegistrationInfo(GetPushService, LDeviceID, LDeviceToken);    // May raise exception
{$IFDEF IOS}
                                  
  LJSONObject := ParseApi.CreateIOSInstallationObject(LDeviceToken, AProperties);
{$ELSE}
  LJSONObject := ParseApi.CreateAndroidInstallationObject(FGCMAppId, FInstallationID, LDeviceToken, AProperties);
{$ENDIF}
  try
                                  
    if FInstallationObjectID <> '' then
    begin
      try
      ParseApi.UpdateInstallation(FInstallationObjectID, LJSONObject, AUpdateObject);
      except
        FInstallationObjectID := ''; // Could be invalid
        raise;
      end;
      if Assigned(AOnRegistered) then
        AOnRegistered(GetPushService);
    end
    else
    begin
      ParseApi.UploadInstallation(LJSONObject, ANewObject);
      FInstallationObjectID := ANewObject.ObjectID;
      if Assigned(AOnRegistered) then
        AOnRegistered(GetPushService);
    end;
  finally
    LJSONObject.Free;
  end;
{$ELSE}
  raise EParsePushNotificationError.CreateFmt(sPushDeviceNoPushService, [sParse, LDeviceName]);
{$ENDIF}
end;


procedure TParsePushDeviceAPI.UnregisterDevice;
var
  LDeviceName: string;
  LServiceName: string;
begin
  LServiceName := '';
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
{$IFDEF PUSH}
  if FInstallationObjectID = '' then
    raise EParsePushNotificationError.Create(sPushDeviceParseInstallationIDBlankDelete);
  ParseApi.DeleteInstallation(FInstallationObjectID);
  FInstallationObjectID := '';
{$ELSE}
  raise EParsePushNotificationError.CreateFmt(sPushDeviceNoPushService, [sParse, LDeviceName]);
{$ENDIF}
end;

type
  TParsePushDeviceServiceFactory = class(TProviderServiceFactory<IBackendPushDeviceService>)
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create;
  end;

constructor TParsePushDeviceServiceFactory.Create;
begin
  inherited Create(TCustomParseProvider.ProviderID, 'REST.Backend.ParsePushDevice');  // Do not localize
end;

function TParsePushDeviceServiceFactory.CreateService(const AProvider: IBackendProvider;
  const IID: TGUID): IBackendService;
begin
  Result := TParsePushDeviceService.Create(AProvider);
end;

var
  FFactory: TParsePushDeviceServiceFactory;

initialization
  FFactory := TParsePushDeviceServiceFactory.Create;
  FFactory.Register;
finalization
  FFactory.Unregister;
  FFactory.Free;

end.
