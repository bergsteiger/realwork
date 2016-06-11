{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.PushNotification.iOS;

interface

implementation

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Messaging, System.PushNotification, System.JSON,
  FMX.Platform, FMX.Platform.iOS, FMX.Helpers.iOS, FMX.Forms,
  Macapi.Helpers, iOSAPI.CocoaTypes, iOSAPI.UIKit;

type

  TAPSPushServiceNotification = class(TPushServiceNotification)
  private
    FJSONObject: TJSONObject;
  protected
    function GetDataKey: string; override;
    function GetJson: TJSONObject; override;
    function GetDataObject: TJSONObject; override;
  public
    constructor Create(const AText: string);
  end;

  TAPSPushService = class(TPushService)
  private
    FStatus: TPushService.TStatus;
    FDeviceToken: string;
    FDeviceID: string;
    FStartupNotification: TPushServiceNotification;
    FStartupError: string;
    procedure Register;
    procedure Unregister;
    procedure MessageListener(const Sender: TObject; const M: TMessage);
  protected
    constructor Create; reintroduce; overload;
    constructor Create(const AOwner: TPushServiceManager; const AServiceName: string); overload; override;
    destructor Destroy; override;
    function GetStatus: TPushService.TStatus; override;
    procedure StartService; override;
    procedure StopService; override;
    function GetDeviceToken: TPushService.TPropArray; override;
    function GetDeviceID: TPushService.TPropArray; override;
    function GetStartupNotifications: TArray<TPushServiceNotification>; override;
    function GetStartupError: string; override;

  end;

var
  APSPushService: TAPSPushService;

procedure RegisterPushServices;
begin
  if APSPushService = nil then
    TAPSPushService.Create;
end;

                                                   
function IOSGetDeviceID: string;
var
  LDevice: UIDevice;
begin
  Result := '';
  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  if LDevice <> nil then
    Result := NSStrToStr(LDevice.identifierForVendor.UUIDString);
end;

{ TAPSPushServiceNotification }

constructor TAPSPushServiceNotification.Create(const AText: string);
begin
  // {"aps":{"alert":"some message","sound":"somesound.mp3","badge":0},"action":"do something","title":"Message"}
  // only alert, sound and badge are part of Apples default "aps" structure.
  // The other values are optional and depend on the actual provider
  FJSONObject := TJSONObject.ParseJSONValue(AText) as TJSONObject;
end;

function TAPSPushServiceNotification.GetDataObject: TJSONObject;
var
  LValue: TJSONValue;
begin
  Result := nil;
  if FJSONObject <> nil then
  begin
    LValue := FJSONObject.Values[GetDataKey];
    if LValue <> nil then
      Result := LValue as TJSONObject;
  end;
end;

function TAPSPushServiceNotification.GetDataKey: string;
begin
  Result := 'aps'; // Do not localize
end;

function TAPSPushServiceNotification.GetJson: TJSONObject;
begin
  Result := FJSONObject;
end;

{ TAPSPushService }

constructor TAPSPushService.Create;
begin
  APSPushService := Self;
  Create(TPushServiceManager.Instance, TPushService.TServiceNames.APS);
end;

constructor TAPSPushService.Create(const AOwner: TPushServiceManager; const AServiceName: string);
begin
  inherited;
  TMessageManager.DefaultManager.SubscribeToMessage(TPushStartupNotificationMessage, MessageListener);
  TMessageManager.DefaultManager.SubscribeToMessage(TPushRemoteNotificationMessage, MessageListener);
  TMessageManager.DefaultManager.SubscribeToMessage(TPushDeviceTokenMessage, MessageListener);
  TMessageManager.DefaultManager.SubscribeToMessage(TPushFailToRegisterMessage, MessageListener);
end;

destructor TAPSPushService.Destroy;
begin
  if APSPushService = Self then
    APSPushService := nil;
  if TMessageManager.DefaultManager <> nil then
  begin
    TMessageManager.DefaultManager.Unsubscribe(TPushStartupNotificationMessage, MessageListener);
    TMessageManager.DefaultManager.Unsubscribe(TPushRemoteNotificationMessage, MessageListener);
    TMessageManager.DefaultManager.Unsubscribe(TPushDeviceTokenMessage, MessageListener);
    TMessageManager.DefaultManager.Unsubscribe(TPushFailToRegisterMessage, MessageListener);
  end;
  inherited;
end;

procedure TAPSPushService.MessageListener(const Sender: TObject; const M: TMessage);
begin
  // Receive messages from FMX.Platform.IOS
  try
    if M is TPushStartupNotificationMessage then
    begin
      FStartupNotification := TAPSPushServiceNotification.Create(TPushStartupNotificationMessage(M).Value.Notification);
      DoChange([TPushService.TChange.StartupNotifications]);
    end
    else if M is TPushRemoteNotificationMessage then
      DoReceiveNotification(TAPSPushServiceNotification.Create(TPushRemoteNotificationMessage(M).Value.Notification))
    else if M is TPushFailToRegisterMessage then
    begin
      FDeviceToken := '';
      FStartupError := TPushFailToRegisterMessage(M).Value.ErrorMessage;
      FStatus := TPushService.TStatus.StartupError;
      DoChange([TPushService.TChange.Status, TPushService.TChange.DeviceToken]);
    end
    else if M is TPushDeviceTokenMessage then
    begin
      FDeviceToken := TPushDeviceTokenMessage(M).Value.Token;
      FStatus := TPushService.TStatus.Started;
      DoChange([TPushService.TChange.Status, TPushService.TChange.DeviceToken]);
    end;
  except
    Application.HandleException(Self);
  end;
end;

function TAPSPushService.GetDeviceID: TPushService.TPropArray;
begin
  if FDeviceID = '' then
    FDeviceID := IOSGetDeviceID;
  Result := TPushService.TPropArray.Create(TPushService.TPropPair.Create(
    TPushService.TDeviceIDNames.DeviceID, FDeviceID));
end;

function TAPSPushService.GetDeviceToken: TPushService.TPropArray;
begin
  Result := TPushService.TPropArray.Create(TPushService.TPropPair.Create(
    TPushService.TDeviceTokenNames.DeviceToken, FDeviceToken));
end;

function TAPSPushService.GetStartupError: string;
begin
  Result := FStartupError;
end;

function TAPSPushService.GetStartupNotifications: TArray<TPushServiceNotification>;
begin
  if FStartupNotification <> nil then
    Result := TArray<TPushServiceNotification>.Create(FStartupNotification);
end;

function TAPSPushService.GetStatus: TPushService.TStatus;
begin
  Result := FStatus;
end;

procedure TAPSPushService.StartService;
begin
  FStatus := TPushService.TStatus.Starting;
  DoChange([TPushService.TChange.Status]);
  Register;
end;

procedure TAPSPushService.StopService;
begin
  if FDeviceToken <> '' then
  begin
    Unregister;
    FDeviceToken := '';
    FStatus := TPushService.TStatus.Stopped;
    FStartupNotification := nil;
    FStartupError := '';
    DoChange([TPushService.TChange.Status]);
  end;
end;

procedure TAPSPushService.Register;
var
  NTypes: NSUInteger;
  NotificationSettings: UIUserNotificationSettings;
begin
  NTypes := UIUserNotificationTypeBadge or UIUserNotificationTypeSound or UIUserNotificationTypeAlert;
  if TOSVersion.Check(8) then
  begin
    NotificationSettings := TUIUserNotificationSettings.Wrap(TUIUserNotificationSettings.OCClass.settingsForTypes(NTypes,nil));
    SharedApplication.registerUserNotificationSettings(NotificationSettings);
    SharedApplication.registerForRemoteNotifications;
  end
  else
  SharedApplication.registerForRemoteNotificationTypes(Addr(NTypes));
end;

procedure TAPSPushService.Unregister;
begin
  SharedApplication.unregisterForRemoteNotifications;
end;

initialization
  RegisterPushServices;
end.
