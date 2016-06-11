{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit FMX.PushNotification.Android;

interface

{$SCOPEDENUMS ON}

implementation

uses
  System.SysUtils, System.Classes,   System.JSON, System.PushNotification,
  Androidapi.Helpers, Androidapi.JNIBridge, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.PlayServices.GCM,
  FMX.Platform.Android, FMX.Types,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Telephony, Androidapi.JNI.PlayServices,
  Androidapi.JNI.App, Androidapi.NativeActivity,  Androidapi.JNI.Os, System.Messaging;
type

  TGCMPushServiceNotification = class(TPushServiceNotification)
  private
    FJSONObject: TJSONObject;
  protected
    function GetDataKey: string; override;
    function GetJson: TJSONObject; override;
    function GetDataObject: TJSONObject; override;
  public
    constructor Create(const ABundle: JBundle); overload;
  end;

  TGCMPushServiceNativeListener = class(TJavaLocal, JGCMNativeListener)
  public
    procedure OnNotificationReceived(notification: JBundle); cdecl;
  end;

  TGCMPushService = class(TPushService)
  private
    FDeviceToken: string;
    FDeviceID: string;
    FStatus: TPushService.TStatus;
    FStartupError: string;
    procedure Register(const LGCMAppId: string);
    procedure Unregister;
    procedure MessageListener(const Sender: TObject; const M: TMessage);
  protected
    constructor Create; reintroduce;
    function GetStatus: TPushService.TStatus; override;
    procedure StartService; override;
    procedure StopService; override;
    function GetDeviceToken: TPushService.TPropArray; override;
    function GetDeviceID: TPushService.TPropArray; override;
    function GetStartupNotifications: TArray<TPushServiceNotification>; override;
    function GetStartupError: string; override;
  public
    destructor Destroy; override;
  end;

  EGCMPushServiceError = class(EPushServiceError);
var

  GCMPushService: TGCMPushService;

procedure RegisterPushServices;
begin
  if GCMPushService = nil then
    TGCMPushService.Create;
end;

function SharedActivityContext: JContext;
begin
  Result := TJNativeActivity.Wrap(PANativeActivity(System.DelphiActivity)^.clazz);
end;

function GetAndroidDeviceID: string;
begin
  Result := JStringToString(MainActivity.getDeviceID);
end;

{ TFMXGCMNativeListener }

procedure TGCMPushServiceNativeListener.OnNotificationReceived(notification: JBundle);
begin
  // Activity is responsible for either processing the notification immediately (by sending TMessageReceivedNotification) or
  // putting notification in notification center
  MainActivity.receiveGCM(notification);
end;

{ TGCMPushService }

procedure TGCMPushService.Register(const LGCMAppId: string);
var
  LGCM: JGoogleCloudMessaging;
  LSenderIds: TJavaObjectArray<JString>;
  LToken: JString;
begin
  /// prepare sender-ids (this is usually your app-id)
  LSenderIds := TJavaObjectArray<JString>.Create(1);
  LSenderIds.SetRawItem(0, (StringToJString(LGCMAppId) as ILocalObject).GetObjectID);

  FDeviceToken := '';
  LGCM := TJGoogleCloudMessaging.JavaClass.getInstance(SharedActivityContext);
  try
    LToken := LGCM.Register(LSenderIds);
    FDeviceToken := (JStringToString(LToken));
    FStatus := TPushService.TStatus.Started;
    GCMPushService.DoChange([TPushService.TChange.Status, TPushService.TChange.DeviceToken]);
  except
    on E: Exception do
    begin
      FStatus := TPushService.TStatus.StartupError;
      GCMPushService.FStartupError := E.Message;
      GCMPushService.DoChange([TPushService.TChange.Status]);
    end;
  end;
end;

procedure TGCMPushService.StartService;
var
  LAppID: string;
begin
  if FDeviceToken = '' then
  begin
    LAppID := AppProps[TPushService.TAppPropNames.GCMAppID];
    if LAppID = '' then
      raise EGCMPushServiceError.Create('AppID is blank.  An AppID is required for Google Cloud Messaging');
    Register(LAppID);
  end;
end;

procedure TGCMPushService.StopService;
begin
  if FDeviceToken <> '' then
  begin
    Unregister;
    FDeviceToken := '';
    FStatus := TPushService.TStatus.Stopped;
    //FStartupNotification := nil;
    FStartupError := '';
    FStatus := TStatus.Stopped;
    DoChange([TChange.Status]);
  end;
end;

constructor TGCMPushService.Create;
begin
  GCMPushService := Self;
  inherited Create(TPushServiceManager.Instance, TPushService.TServiceNames.GCM);
  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, MessageListener);
end;

destructor TGCMPushService.Destroy;
begin
                            
  if GCMPushService = Self then
    GCMPushService := nil;
  inherited;
end;

function TGCMPushService.GetDeviceID: TPushService.TPropArray;
begin
  if FDeviceID = '' then
    FDeviceID := GetAndroidDeviceID;
  Result := TPushService.TPropArray.Create(TPushService.TPropPair.Create(
    TPushService.TDeviceIDNames.DeviceID, FDeviceID));
end;

function TGCMPushService.GetDeviceToken: TPushService.TPropArray;
begin
  Result := TPushService.TPropArray.Create(TPushService.TPropPair.Create(
    TPushService.TDeviceTokenNames.DeviceToken, FDeviceToken));
end;

function TGCMPushService.GetStartupError: string;
begin
  Result := FStartupError;
end;

function TGCMPushService.GetStartupNotifications: TArray<TPushServiceNotification>;
var
  LBundle: JBundle;
begin
  LBundle := MainActivity.getStartupGCM;
  if LBundle <> nil then
    Result := TArray<TPushServiceNotification>.Create(TGCMPushServiceNotification.Create(LBundle))
  else
    Result := nil;
end;

function TGCMPushService.GetStatus: TPushService.TStatus;
begin
  Result := FStatus;
end;

procedure TGCMPushService.Unregister;
var
  LGCM: JGoogleCloudMessaging;
begin
  LGCM := TJGoogleCloudMessaging.JavaClass.getInstance(SharedActivityContext);
  try
    FDeviceToken := '';
    LGCM.Unregister;
  finally
    FreeAndNil(LGCM);
  end;
end;

procedure TGCMPushService.MessageListener(const Sender: TObject; const M: TMessage);
  function IsIntentWithNotification(Intent: JIntent): Boolean;
  begin
    Result := (Intent <> nil) and (Intent.getAction <> nil) and Intent.getAction.equals(StringToJString('GCMNotification'));
  end;

  procedure ProcessBundle(const ANotification: JBundle);
  var
    LNotificationObject: TGCMPushServiceNotification;
  begin
    if GCMPushService <> nil then
    begin
      LNotificationObject := TGCMPushServiceNotification.Create(ANotification);
      // Notifications come in on secondary thread
      TThread.Queue(nil,
      procedure
      begin
        // Handle notifications on firemonkey thread
        if GCMPushService <> nil then
          GCMPushService.DoReceiveNotification(LNotificationObject);
      end);
    end;
  end;

  procedure ProcessIntent(const AIntent: JIntent);
  var
    LBundle: JBundle;
  begin
    if AIntent <> nil then
    begin
      LBundle := AIntent.getBundleExtra(StringToJString('gcm'));
      if LBundle <> nil then
        ProcessBundle(LBundle);
    end;
  end;

var
  InputIntent: JIntent;
begin
  if M is TMessageReceivedNotification then
  begin
    InputIntent := (M as TMessageReceivedNotification).Value;
    if IsIntentWithNotification(InputIntent) then
      ProcessIntent(InputIntent);
  end;
end;


{ TFMXPushNotificationAndroid }

function TGCMPushServiceNotification.GetDataObject: TJSONObject;
var
  LValue: TJSONValue;
begin
  // The message /can/ be prefaced with "gcm", but this is not required
  Result := FJSONObject;  // take raw JSON as default
  if (GetDataKey <> '') and (FJSONObject <> nil) then
  begin
    LValue := FJSONObject.Values[GetDataKey];
    if LValue <> nil then
      Result := LValue as TJSONObject;
  end;
end;

constructor TGCMPushServiceNotification.Create(const ABundle: JBundle);
var
  LJSONObject: TJSONObject;
  LIterator: JIterator;
  LValue: JString;
  LKey: JString;
begin
  LJSONObject := TJSONObject.Create;
  LIterator := ABundle.KeySet.iterator;
  while LIterator.hasNext do
  begin
    LKey := LIterator.next.toString;
    LValue := ABundle.&get(LKey).ToString;
    LJSONObject.AddPair(JStringToString(LKey), JStringToString(LValue));
  end;
  Assert(LJSONObject.Count = ABundle.keySet.size);
  FJSONObject := LJSONObject;
end;

function TGCMPushServiceNotification.GetDataKey: string;
begin
  Result := 'gcm'; // Do not localize
end;

function TGCMPushServiceNotification.GetJson: TJSONObject;
begin
  Result := FJSONObject;
end;

var

  NotificationManager: JGCMNotification;
  NativeListener: JGCMNativeListener;

initialization

  NativeListener := TGCMPushServiceNativeListener.Create;
  NotificationManager := TJGCMNotification.JavaClass.init;
  NotificationManager.setNativeListener(NativeListener); // Set static callback variable
  RegisterPushServices;

finalization
  // Note.  Finalization not called on Android

  NotificationManager.setNativeListener(nil);

  FreeAndNil(NativeListener);
  FreeAndNil(NotificationManager);

end.
