{*******************************************************}
{                                                       }
{            CodeGear Delphi Runtime Library            }
{                                                       }
{      Notification Center implementation for iOS       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.iOS.Notification;

interface

{$SCOPEDENUMS ON}

uses
  System.Notification;

  /// <summary>Common ancestor used to instantiate platform implementation</summary>
  type TPlatformNotificationCenter = class(TBaseNotificationCenter)
  protected
    class function GetInstance: TBaseNotificationCenter; override;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  System.Messaging,
  Macapi.ObjectiveC,
  Macapi.Helpers,
  iOSapi.Foundation,
  iOSapi.CocoaTypes,
  iOSapi.UIKit;

type

{ TNotificationCenterCocoa }

  TNotificationCenterCocoa = class(TPlatformNotificationCenter)
  private
    class var FNotificationCenterSingleton: TNotificationCenterCocoa;
    FDelayedNotifications: TObjectList<TNotification>;
    FApplicationLoaded: Boolean;
    { Creation and manipulation with notifications }
    function CreateNativeNotification(const ANotification: TNotification): UILocalNotification;
    function ConvertNativeToDelphiNotification(const ANotification: UILocalNotification): TNotification;
    function FindNativeNotification(const AID: string; var ANotification: UILocalNotification): Boolean;
    { Global External event }
    procedure ReceiveLocalNotification(const Sender: TObject; const M: TMessage);
    { Delayed notifications }
    procedure SendDelayedNotifications;
    procedure ClearDelayedNotifications;

    procedure DidFormsLoad;
    function SharedApplication: UIApplication; inline;
    class destructor Destroy;
    class function GetNotificationCenter: TNotificationCenterCocoa; static;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXNotificationCenter }
    function GetCurrentNotifications: TNotifications; // Not accesible in base class because android doesn't have it
    function FindNotification(const AName: string): TNotification; // Not accesible in base class because android doesn't have it

    procedure DoScheduleNotification(const ANotification: TNotification); override;
    procedure DoPresentNotification(const ANotification: TNotification); override;
    procedure DoCancelNotification(const AName: string); overload; override;
    procedure DoCancelNotification(const ANotification: TNotification); overload; override;
    procedure DoCancelAllNotifications; override;
    procedure DoSetIconBadgeNumber(const ACount: Integer); override;
    function DoGetIconBadgeNumber: Integer; override;
    procedure DoResetIconBadgeNumber; override;

    procedure DoLoaded; override;

    class property NotificationCenter: TNotificationCenterCocoa read GetNotificationCenter;
  end;

function RepeatIntervalToNSCalendarUnit(const AInterval: TRepeatInterval): NSCalendarUnit;
begin
  case AInterval of
    TRepeatInterval.None:
      Result := 0;
    TRepeatInterval.Second:
      Result := NSSecondCalendarUnit;
    TRepeatInterval.Minute:
      Result := NSMinuteCalendarUnit;
    TRepeatInterval.Hour:
      Result := NSHourCalendarUnit;
    TRepeatInterval.Day:
      Result := NSDayCalendarUnit;
    TRepeatInterval.Weekday:
      Result := NSWeekdayCalendarUnit;
    TRepeatInterval.Week:
      Result := NSWeekCalendarUnit;
    TRepeatInterval.Month:
      Result := NSMonthCalendarUnit;
    TRepeatInterval.Quarter:
      Result := NSQuarterCalendarUnit;
    TRepeatInterval.Year:
      Result := NSYearCalendarUnit;
    TRepeatInterval.Era:
      Result := NSEraCalendarUnit;
  else
    Result := 0;
  end;
end;

function NSCalendarUnitToRepeatInterval(const AInterval: NSCalendarUnit): TRepeatInterval;
begin
  case AInterval of
    NSEraCalendarUnit:
      Result := TRepeatInterval.Era;
    NSYearCalendarUnit:
      Result := TRepeatInterval.Year;
    NSQuarterCalendarUnit:
      Result := TRepeatInterval.Quarter;
    NSMonthCalendarUnit:
      Result := TRepeatInterval.Month;
    NSWeekCalendarUnit:
      Result := TRepeatInterval.Week;
    NSWeekdayCalendarUnit:
      Result := TRepeatInterval.Weekday;
    NSDayCalendarUnit:
      Result := TRepeatInterval.Day;
    NSHourCalendarUnit:
      Result := TRepeatInterval.Hour;
    NSMinuteCalendarUnit:
      Result := TRepeatInterval.Minute;
    NSSecondCalendarUnit:
      Result := TRepeatInterval.Second;
  else
    Result := TRepeatInterval.None;
  end;
end;

{$REGION 'TNotificationCenterCocoa'}

procedure TNotificationCenterCocoa.DoCancelAllNotifications;
begin
  SharedApplication.cancelAllLocalNotifications;
end;

function TNotificationCenterCocoa.FindNativeNotification(const AID: string; var ANotification: UILocalNotification): Boolean;

  function FindInScheduledNotifications: UILocalNotification;
  var
    Notifications: NSArray;
    NativeNotification: UILocalNotification;
    Found: Boolean;
    I: NSUInteger;
    UserInfo: NSDictionary;
  begin
    Notifications := SharedApplication.scheduledLocalNotifications;
    Found := False;
    if Notifications <> nil then
    begin
      I := 0;
      while (I < Notifications.count) and not Found do
      begin
        NativeNotification := TUILocalNotification.Wrap(Notifications.objectAtIndex(I));
        UserInfo := NativeNotification.userInfo;
        if (UserInfo <> nil) and (UTF8ToString(TNSString.Wrap(UserInfo.valueForKey(StrToNSStr('id'))).UTF8String) = AID) then
          Found := True
        else
          Inc(I);
      end;
    end;
    if Found then
      Result := NativeNotification
    else
      Result := nil;
  end;

begin
  // We are searching notification in two list:
  //   1. Notifications, which have not displayed in Notification Center
  //   2. Notifications, which already displayed
  ANotification := FindInScheduledNotifications;
  Result := ANotification <> nil;
end;

function TNotificationCenterCocoa.FindNotification(const AName: string): TNotification;
var
  NativeNotification: UILocalNotification;
begin
  if FindNativeNotification(AName, NativeNotification) then
    Result := ConvertNativeToDelphiNotification(NativeNotification)
  else
    Result := nil;
end;

function TNotificationCenterCocoa.GetCurrentNotifications: TNotifications;
var
  Notifications: NSArray;
  NativeNotification: UILocalNotification;
  I: Integer;
begin
  Notifications := SharedApplication.scheduledLocalNotifications;
  SetLength(Result, Notifications.count);
  for I := 0 to Integer(Notifications.count) - 1 do
  begin
    NativeNotification := TUILocalNotification.Wrap(Notifications.objectAtIndex(I));
    Result[I] := ConvertNativeToDelphiNotification(NativeNotification)
  end;
end;

procedure TNotificationCenterCocoa.DoCancelNotification(const AName: string);
var
  NativeNotification: UILocalNotification;
begin
  if not AName.IsEmpty and FindNativeNotification(AName, NativeNotification) then
    SharedApplication.cancelLocalNotification(NativeNotification);
end;

procedure TNotificationCenterCocoa.DoCancelNotification(const ANotification: TNotification);
begin
  if ANotification <> nil then
    DoCancelNotification(ANotification.Name);
end;

procedure TNotificationCenterCocoa.ClearDelayedNotifications;
begin
  FDelayedNotifications.Clear;
end;

constructor TNotificationCenterCocoa.Create;
begin
  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, ReceiveLocalNotification);
  FDelayedNotifications := TObjectList<TNotification>.Create;
  FApplicationLoaded := False;
end;

function TNotificationCenterCocoa.SharedApplication: UIApplication;
var
  App: Pointer;
begin
  Result := nil;
  App := TUIApplication.OCClass.sharedApplication;
  if App <> nil then
    Result := TUIApplication.Wrap(App);
end;

function TNotificationCenterCocoa.CreateNativeNotification(const ANotification: TNotification): UILocalNotification;
var
  NativeNotification: UILocalNotification;
  UserInfo: NSDictionary;
  GMTDateTime: TDateTime;
begin
  NativeNotification := TUILocalNotification.Create;
  if not ANotification.Name.IsEmpty then
  begin
    // Set unique identificator
    UserInfo := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObject(
      (StrToNSStr(ANotification.Name) as ILocalObject).GetObjectID, (StrToNSStr('id') as ILocalObject).GetObjectID));
    NativeNotification.setUserInfo(UserInfo);
  end;
  // Get GMT time and set notification fired date
  GMTDateTime := GetGMTDateTime(ANotification.FireDate);
  NativeNotification.setTimeZone(TNSTimeZone.Wrap(TNSTimeZone.OCClass.defaultTimeZone));
  NativeNotification.setFireDate(DateTimeToNSDate(GMTDateTime));
  NativeNotification.setApplicationIconBadgeNumber(ANotification.Number);
  NativeNotification.setAlertBody(StrToNSStr(ANotification.AlertBody));
  NativeNotification.setAlertAction(StrToNSStr(ANotification.AlertAction));
  NativeNotification.setHasAction(ANotification.HasAction);
  NativeNotification.setRepeatInterval(RepeatIntervalToNSCalendarUnit(ANotification.RepeatInterval));
  if ANotification.EnableSound then
    if ANotification.SoundName.IsEmpty then
      NativeNotification.setSoundName(UILocalNotificationDefaultSoundName)
    else
      NativeNotification.setSoundName(StrToNSStr(ANotification.SoundName))
  else
    NativeNotification.setSoundName(nil);
  Result := NativeNotification;
end;

destructor TNotificationCenterCocoa.Destroy;
begin
  { Unsibscribe }
  TMessageManager.DefaultManager.Unsubscribe(TMessageReceivedNotification, ReceiveLocalNotification);
  { Destroying }
  ClearDelayedNotifications;
  FDelayedNotifications.Free;
  inherited Destroy;
end;

procedure TNotificationCenterCocoa.DidFormsLoad;
begin
  FApplicationLoaded := True;
  SendDelayedNotifications;
end;

class destructor TNotificationCenterCocoa.Destroy;
begin
  FNotificationCenterSingleton.Free;
end;

procedure TNotificationCenterCocoa.ReceiveLocalNotification(const Sender: TObject; const M: TMessage);

  procedure SendNotification(Notification: TNotification);
  begin
    TMessageManager.DefaultManager.SendMessage(Self, TMessage<TNotification>.Create(Notification));
    // Sending Delayed notifications
    if FDelayedNotifications.Count > 0 then
      SendDelayedNotifications;
  end;

var
  NativeNotification: UILocalNotification;
  Notification: TNotification;
begin
  if M is TMessageReceivedNotification then
  begin
    NativeNotification := (M as TMessageReceivedNotification).Value;
    // iOS doesn't provide list of presented notification. So we need to store it
    // in our list for cancelling in future with using ID
    Notification := ConvertNativeToDelphiNotification(NativeNotification);
    try
      if not FApplicationLoaded then
        FDelayedNotifications.Add(Notification)
      else
        SendNotification(Notification);
    finally
      Notification.Free;
    end;
  end;
end;

function TNotificationCenterCocoa.ConvertNativeToDelphiNotification(const ANotification: UILocalNotification): TNotification;
var
  UserInfo: NSDictionary;
  NotificationTmp: TNotification;
begin
  NotificationTmp := nil;
  if ANotification <> nil then
  begin
    NotificationTmp := TNotification.Create;
    UserInfo := ANotification.userInfo;
    if UserInfo <> nil then
      NotificationTmp.Name := UTF8ToString(TNSString.Wrap(UserInfo.valueForKey(StrToNSStr('id'))).UTF8String);
    if ANotification.AlertBody <> nil then
      NotificationTmp.AlertBody := UTF8ToString(ANotification.AlertBody.UTF8String);
    if ANotification.AlertAction <> nil then
      NotificationTmp.AlertAction := UTF8ToString(ANotification.AlertAction.UTF8String);;
    NotificationTmp.Number := ANotification.ApplicationIconBadgeNumber;
    NotificationTmp.FireDate := NSDateToDateTime(ANotification.FireDate);
    NotificationTmp.EnableSound := ANotification.SoundName <> nil;
    if (ANotification.soundName = nil) or (ANotification.soundName.compare(UILocalNotificationDefaultSoundName) = NSOrderedSame) then
      NotificationTmp.SoundName := ''
    else
      NotificationTmp.SoundName := NSStrToStr(ANotification.soundName);
    NotificationTmp.HasAction := ANotification.HasAction;
    NotificationTmp.RepeatInterval := NSCalendarUnitToRepeatInterval(ANotification.repeatInterval);
  end;
  Result := NotificationTmp;
end;

procedure TNotificationCenterCocoa.DoPresentNotification(const ANotification: TNotification);
var
  NativeNatification: UILocalNotification;
begin
  DoCancelNotification(ANotification);
  NativeNatification := CreateNativeNotification(ANotification);
  SharedApplication.presentLocalNotificationNow(NativeNatification);
end;

procedure TNotificationCenterCocoa.DoScheduleNotification(const ANotification: TNotification);
var
  NativeNatification: UILocalNotification;
begin
  DoCancelNotification(ANotification);
  NativeNatification := CreateNativeNotification(ANotification);
  SharedApplication.scheduleLocalNotification(NativeNatification);
end;

procedure TNotificationCenterCocoa.SendDelayedNotifications;
var
  Notification: TNotification;
begin
  for Notification in FDelayedNotifications do
    TMessageManager.DefaultManager.SendMessage(Self, TMessage<TNotification>.Create(Notification));
  ClearDelayedNotifications;
end;

function TNotificationCenterCocoa.DoGetIconBadgeNumber: Integer;
begin
  Result := SharedApplication.ApplicationIconBadgeNumber;
end;

procedure TNotificationCenterCocoa.DoLoaded;
begin
  inherited;
  DidFormsLoad;
end;

class function TNotificationCenterCocoa.GetNotificationCenter: TNotificationCenterCocoa;
begin
  if FNotificationCenterSingleton = nil then
    FNotificationCenterSingleton := TNotificationCenterCocoa.Create;
  Result := FNotificationCenterSingleton;
end;

procedure TNotificationCenterCocoa.DoSetIconBadgeNumber(const ACount: Integer);
begin
  SharedApplication.setApplicationIconBadgeNumber(ACount);
end;

procedure TNotificationCenterCocoa.DoResetIconBadgeNumber;
begin
  SharedApplication.setApplicationIconBadgeNumber(0);
end;

{$ENDREGION}

{ TPlatformNotificationCenter }

class function TPlatformNotificationCenter.GetInstance: TBaseNotificationCenter;
begin
  Result := TBaseNotificationCenter(TNotificationCenterCocoa.NotificationCenter)
end;

end.
