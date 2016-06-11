{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.EMSPushDevice;

{$HPPEMIT LINKUNIT}
interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.PushNotification,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.EMSProvider,
  REST.Backend.EMSApi,
  REST.Backend.Exception,
  REST.Backend.MetaTypes;

type


{$IFDEF IOS}
{$DEFINE PUSH}
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE PUSH}
{$ENDIF}
{$DEFINE PUSH}
  TEMSPushDeviceAPI = class(TEMSServiceAPIAuth, IBackendPushDeviceApi, IBackendPushDeviceApi2)
  private const
    sEMS = 'EMS';
  private
    FGCMAppID: String;
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
    function TryGetInstallationValue(out AValue: TBackendEntityValue): Boolean;
  end;

  TEMSPushDeviceService = class(TEMSBackendService<TEMSPushDeviceAPI>, IBackendService, IBackendPushDeviceService)
  protected
    procedure DoAfterConnectionChanged; override;
    function CreateBackendApi: TEMSPushDeviceAPI; override;
    { IBackendPushDeviceService }
    function CreatePushDeviceApi: IBackendPushDeviceApi;
    function GetPushDeviceApi: IBackendPushDeviceApi;
  end;

  EEMSClientPushNotificationError = class(EBackendServiceError);

implementation

uses
  System.Generics.Collections,
  System.TypInfo,
  REST.Backend.Consts,
  REST.Backend.EMSMetaTypes,
  REST.Backend.ServiceFactory
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

function TEMSPushDeviceService.CreatePushDeviceApi: IBackendPushDeviceApi;
begin
  Result := CreateBackendApi;
end;

function TEMSPushDeviceService.CreateBackendApi: TEMSPushDeviceAPI;
begin
  Result := inherited;
  if ConnectionInfo <> nil then
    Result.FGCMAppID := ConnectionInfo.AndroidPush.GCMAppID
  else
    Result.FGCMAppID := '';
end;

function TEMSPushDeviceService.GetPushDeviceApi: IBackendPushDeviceApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

procedure TEMSPushDeviceService.DoAfterConnectionChanged;
begin
  inherited;
  if BackendAPI <> nil then
  begin
    if ConnectionInfo <> nil then
      BackendAPI.FGCMAppID := ConnectionInfo.AndroidPush.GCMAppID
    else
      BackendAPI.FGCMAppID := '';
  end;
end;


{ TEMSPushDeviceAPI }

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
    raise EEMSClientPushNotificationError.Create(sDeviceIDUnavailable);

  if ADeviceToken = ''  then
    raise EEMSClientPushNotificationError.Create(sDeviceTokenUnavailable);
end;

function TEMSPushDeviceAPI.GetPushService: TPushService;
var
  LServiceName: string;
  LDeviceName: string;
  LService: TPushService;
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EEMSClientPushNotificationError.CreateFmt(sPushDeviceNoPushService, [sEMS, LDeviceName]);

  LService := GetService(LServiceName);
  if LService = nil then
    raise EEMSClientPushNotificationError.CreateFmt(sPushDevicePushServiceNotFound, [sEMS, LServiceName]);
  if LService.ServiceName = TPushService.TServiceNames.GCM then
    if not (LService.Status in [TPushService.TStatus.Started]) then
    begin
      if FGCMAppID = '' then
        raise EEMSClientPushNotificationError.Create(sPushDeviceGCMAppIDBlank);
      LService.AppProps[TPushService.TAppPropNames.GCMAppID] := FGCMAppID;
    end;
  Result := LService;
end;

function TEMSPushDeviceAPI.HasPushService: Boolean;
var
  LServiceName: string;
begin
  LServiceName := GetServiceName;
  Result := (LServiceName <> '') and (GetService(LServiceName) <> nil);
end;

procedure TEMSPushDeviceAPI.RegisterDevice(
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
begin
  RegisterDevice(nil, AOnRegistered);
end;


procedure TEMSPushDeviceAPI.RegisterDevice(
  const AProperties: TJSONObject;
  AOnRegistered: TDeviceRegisteredAtProviderEvent);
var
  LDeviceName: string;
  LServiceName: string;
{$IFDEF PUSH}
  LDeviceID: string;
  LDeviceToken: string;
  ANewObject: TEMSClientAPI.TInstallation;
  AUpdateObject: TEMSClientAPI.TUpdatedAt;
  LJSONObject: TJSONObject;
{$ENDIF}
begin
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
  LServiceName := GetServiceName;
  if LServiceName = '' then
    raise EEMSClientPushNotificationError.CreateFmt(sPushDeviceNoPushService, [sEMS, LDeviceName]);

// Badge and Channel properties
{$IFDEF PUSH}
  GetRegistrationInfo(GetPushService, LDeviceID, LDeviceToken);    // May raise exception
{$IFDEF IOS}
                                  
  LJSONObject := EMSApi.CreateIOSInstallationObject(LDeviceToken, AProperties);
{$ELSE}
  LJSONObject := EMSApi.CreateAndroidInstallationObject(LDeviceToken, AProperties);
{$ENDIF}
  try
                                  
    if FInstallationObjectID <> '' then
    begin
      try
        EMSApi.UpdateInstallation(FInstallationObjectID, LJSONObject, AUpdateObject);
      except
        FInstallationObjectID := ''; // Could be invalid
        raise;
      end;
      if Assigned(AOnRegistered) then
        AOnRegistered(GetPushService);
    end
    else
    begin
      EMSApi.UploadInstallation(LJSONObject, ANewObject);
      FInstallationObjectID := ANewObject.InstallationID;
      if Assigned(AOnRegistered) then
        AOnRegistered(GetPushService);
    end;
  finally
    LJSONObject.Free;
  end;
{$ELSE}
  raise EEMSClientPushNotificationError.CreateFmt(sPushDeviceNoPushService, [sEMS, LDeviceName]);
{$ENDIF}
end;


function TEMSPushDeviceAPI.TryGetInstallationValue(
  out AValue: TBackendEntityValue): Boolean;
begin
  Result := FInstallationObjectID <> '';
  if Result then
    AValue := TBackendEntityValue.Create(TMetaInstallationID.Create(TEMSClientAPI.TInstallation.Create(FInstallationObjectID)));
end;

procedure TEMSPushDeviceAPI.UnregisterDevice;
var
  LDeviceName: string;
  LServiceName: string;
begin
  LServiceName := '';
  LDeviceName := GetDeviceName;
  Assert(LDeviceName <> '');
{$IFDEF PUSH}
  if FInstallationObjectID = '' then
    raise EEMSClientPushNotificationError.Create(sPushDeviceParseInstallationIDBlankDelete);
  EMSApi.DeleteInstallation(FInstallationObjectID);
  FInstallationObjectID := '';
{$ELSE}
  raise EEMSClientPushNotificationError.CreateFmt(sPushDeviceNoPushService, [sEMS, LDeviceName]);
{$ENDIF}
end;

type
  TEMSPushDeviceServiceFactory = class(TProviderServiceFactory<IBackendPushDeviceService>)
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create;
  end;

constructor TEMSPushDeviceServiceFactory.Create;
begin
  inherited Create(TCustomEMSProvider.ProviderID, 'REST.Backend.EMSPushDevice');  // Do not localize
end;

function TEMSPushDeviceServiceFactory.CreateService(const AProvider: IBackendProvider;
  const IID: TGUID): IBackendService;
begin
  Result := TEMSPushDeviceService.Create(AProvider);
end;

var
  FFactory: TEMSPushDeviceServiceFactory;

initialization
  FFactory := TEMSPushDeviceServiceFactory.Create;
  FFactory.Register;
finalization
  FFactory.Unregister;
  FFactory.Free;

end.
