{*******************************************************}
{                                                       }
{            CodeGear Delphi Runtime Library            }
{                                                       }
{     Notification Center implementation for MacOS      }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Mac.Notification;

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
  System.SysUtils,
  System.Messaging,
  Macapi.Foundation,
  Macapi.ObjectiveC,
  Macapi.Helpers,
  Macapi.AppKit;

type

{ TNotificationCenterCocoa }

  TNotificationCenterDelegate = class;

  TNotificationCenterCocoa = class(TPlatformNotificationCenter)
  private
    class var FNotificationCenterSingleton: TNotificationCenterCocoa;
    FNotificationCenter: NSUserNotificationCenter;
    FNotificationCenterDelegate: TNotificationCenterDelegate;
    function CreateNativeNotification(const ANotification: TNotification): NSUserNotification;
    function ConvertNativeToDelphiNotification(const ANotification: NSUserNotification): TNotification;
    function FindNativeNotification(const AID: string; out ANotification: NSUserNotification): Boolean;
    class destructor Destroy;
    class function GetNotificationCenter: TNotificationCenterCocoa; static;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReceiveNotification(const ANotification: NSUserNotification);
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

    class property NotificationCenter: TNotificationCenterCocoa read GetNotificationCenter;
  end;

{ Notification Center Delegate }

  TNotificationCenterDelegate = class (TOCLocal, NSUserNotificationCenterDelegate)
  strict private
    FNotificationCenter: TNotificationCenterCocoa;
  public
    constructor Create(ANotificationCenter: TNotificationCenterCocoa);
    procedure userNotificationCenter(center: NSUserNotificationCenter; didActivateNotification: NSUserNotification); cdecl;
  end;

function RepeatIntervalToNSDateComponents(const AInterval: TRepeatInterval): NSDateComponents;
begin
  if AInterval = TRepeatInterval.None then
    Exit(nil);

  Result := TNSDateComponents.Create;
  case AInterval of
    TRepeatInterval.Second:
      Result.setSecond(1);
    TRepeatInterval.Minute:
      Result.setMinute(1);
    TRepeatInterval.Hour:
      Result.setHour(1);
    TRepeatInterval.Day:
      Result.setDay(1);
    TRepeatInterval.Weekday:
      Result.setWeekday(1);
    TRepeatInterval.Week:
      Result.setWeek(1);
    TRepeatInterval.Month:
      Result.setMonth(1);
    TRepeatInterval.Quarter:
      Result.setQuarter(1);
    TRepeatInterval.Year:
      Result.setYear(1);
    TRepeatInterval.Era:
      Result.setEra(1);
  end;
end;

function NSDateComponentsToRepeatInterval(const ADate: NSDateComponents): TRepeatInterval;
begin
  if ADate = nil then
    Result := TRepeatInterval.None
  else if ADate.era <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Era
  else if ADate.year <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Year
  else if ADate.quarter <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Quarter
  else if ADate.month <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Month
  else if ADate.week <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Week
  else if ADate.weekday <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Weekday
  else if ADate.day <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Day
  else if ADate.hour <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Hour
  else if ADate.minute <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Minute
  else if ADate.second <> NSUndefinedDateComponent then
    Result := TRepeatInterval.Second
  else
    Result := TRepeatInterval.None;
end;

{ TNotificationCenterCocoa }

procedure TNotificationCenterCocoa.DoCancelAllNotifications;
var
  Notifications: NSArray;
  NativeNotification: NSUserNotification;
  I: Integer;
  NotificationsCount: Integer;
begin
  Notifications := FNotificationCenter.scheduledNotifications;
  NotificationsCount := Integer(Notifications.count);
  for I := 0 to NotificationsCount - 1 do
  begin
    NativeNotification := TNSUserNotification.Wrap(Notifications.objectAtIndex(I));
    FNotificationCenter.removeScheduledNotification(NativeNotification);
  end;
  FNotificationCenter.removeAllDeliveredNotifications;
end;

procedure TNotificationCenterCocoa.DoCancelNotification(const AName: string);
var
  NativeNotification: NSUserNotification;
begin
  if not AName.IsEmpty and FindNativeNotification(AName, NativeNotification) then
  begin
    FNotificationCenter.removeScheduledNotification(NativeNotification);
    FNotificationCenter.removeDeliveredNotification(NativeNotification);
  end;
end;

procedure TNotificationCenterCocoa.DoCancelNotification(const ANotification: TNotification);
begin
  if ANotification <> nil then
    DoCancelNotification(ANotification.Name);
end;

constructor TNotificationCenterCocoa.Create;
begin
  inherited;
  FNotificationCenter := TNSUserNotificationCenter.Wrap(TNSUserNotificationCenter.OCClass.defaultUserNotificationCenter);
  FNotificationCenter.retain;
  FNotificationCenterDelegate := TNotificationCenterDelegate.Create(Self);
  FNotificationCenter.setDelegate(FNotificationCenterDelegate);
end;

function TNotificationCenterCocoa.CreateNativeNotification(const ANotification: TNotification): NSUserNotification;
var
  NativeNotification: NSUserNotification;
  UserInfo: NSDictionary;
  GMTDateTime: TDateTime;
begin
  NativeNotification := TNSUserNotification.Create;
  if not ANotification.Name.IsEmpty then
  begin
    // Set unique identificator
    UserInfo := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObject(
      (StrToNSStr(ANotification.Name) as ILocalObject).GetObjectID,
      (StrToNSStr('id') as ILocalObject).GetObjectID));
    NativeNotification.setUserInfo(UserInfo);
  end;
  // Get GMT time and set notification fired date
  GMTDateTime := GetGMTDateTime(ANotification.FireDate);
  NativeNotification.setDeliveryTimeZone(TNSTimeZone.Wrap(TNSTimeZone.OCClass.defaultTimeZone));
  NativeNotification.setDeliveryDate(DateTimeToNSDate(GMTDateTime));
  NativeNotification.setDeliveryRepeatInterval(RepeatIntervalToNSDateComponents(ANotification.RepeatInterval));
  if not ANotification.Title.IsEmpty then
    NativeNotification.setTitle(StrToNSStr(ANotification.Title));
  NativeNotification.setInformativeText(StrToNSStr(ANotification.AlertBody));
  NativeNotification.setHasActionButton(ANotification.HasAction);
  if ANotification.HasAction then
    NativeNotification.setActionButtonTitle(StrToNSStr(ANotification.AlertAction));
  if ANotification.EnableSound then
    if ANotification.SoundName.IsEmpty then
      NativeNotification.setSoundName(NSUserNotificationDefaultSoundName)
    else
      NativeNotification.setSoundName(StrToNSStr(ANotification.SoundName))
  else
    NativeNotification.setSoundName(nil);
  Result := NativeNotification;
end;

class destructor TNotificationCenterCocoa.Destroy;
begin
  FNotificationCenterSingleton.Free;
end;

function TNotificationCenterCocoa.ConvertNativeToDelphiNotification(const ANotification: NSUserNotification): TNotification;
var
  UserInfo: NSDictionary;
  NotificationTmp: TNotification;
begin
  NotificationTmp := TNotification.Create;
  UserInfo := ANotification.userInfo;
  if UserInfo <> nil then
    NotificationTmp.Name := UTF8ToString(TNSString.Wrap(UserInfo.valueForKey(StrToNSStr('id'))).UTF8String);
  if ANotification.informativeText <> nil then
    NotificationTmp.AlertBody := UTF8ToString(ANotification.informativeText.UTF8String);
  if ANotification.actionButtonTitle <> nil then
    NotificationTmp.AlertAction := UTF8ToString(ANotification.actionButtonTitle.UTF8String);;
  if ANotification.title <> nil then
    NotificationTmp.Title := NSStrToStr(ANotification.title);
  NotificationTmp.FireDate := NSDateToDateTime(ANotification.deliveryDate);
  NotificationTmp.EnableSound := ANotification.SoundName <> nil;
  if (ANotification.soundName.compare(NSUserNotificationDefaultSoundName) = NSOrderedSame) or (ANotification.soundName = nil) then
    NotificationTmp.SoundName := ''
  else
    NotificationTmp.SoundName := NSStrToStr(ANotification.soundName);
  NotificationTmp.HasAction := ANotification.hasActionButton;
  NotificationTmp.RepeatInterval := NSDateComponentsToRepeatInterval(ANotification.deliveryRepeatInterval);
  Result := NotificationTmp;
end;

destructor TNotificationCenterCocoa.Destroy;
begin
  FNotificationCenter.release;
  FNotificationCenterDelegate.Free;
  inherited Destroy;
end;

function TNotificationCenterCocoa.FindNativeNotification(const AID: string; out ANotification: NSUserNotification): Boolean;

  function FindNotificationInList(const ANotifications: NSArray; out ANotification: NSUserNotification): Boolean;
  var
    Found: Boolean;
    I: Integer;
    NotificationsCount: Integer;
    NativeNotification: NSUserNotification;
    UserInfo: NSDictionary;
  begin
    Assert(ANotifications <> nil);

    Found := False;
    I := 0;
    NotificationsCount := Integer(ANotifications.count);
    while (I < NotificationsCount) and not Found do
    begin
      NativeNotification := TNSUserNotification.Wrap(ANotifications.objectAtIndex(I));
      UserInfo := NativeNotification.userInfo;
      if (UserInfo <> nil) and (UTF8ToString(TNSString.Wrap(UserInfo.valueForKey(StrToNSStr('id'))).UTF8String) = AID) then
        Found := True
      else
        Inc(I);
    end;
    if Found then
      ANotification := NativeNotification
    else
      ANotification := nil;

    Result := Found;
  end;

var
  Found: Boolean;
begin
  { Search notificaition in scheduled notifications list }
  Found := FindNotificationInList(FNotificationCenter.scheduledNotifications, ANotification);
  { Search notificaition in delivered notifications list }
  if not Found then
    Found := FindNotificationInList(FNotificationCenter.deliveredNotifications, ANotification);
  Result := Found;
end;

function TNotificationCenterCocoa.FindNotification(const AName: string): TNotification;
var
  NativeNotification: NSUserNotification;
begin
  if FindNativeNotification(AName, NativeNotification) then
    Result := ConvertNativeToDelphiNotification(NativeNotification)
  else
    Result := nil;
end;

function TNotificationCenterCocoa.GetCurrentNotifications: TNotifications;
var
  Notifications: NSArray;
  NativeNotification: NSUserNotification;
  I: Integer;
begin
  Notifications := FNotificationCenter.scheduledNotifications;
  SetLength(Result, Notifications.count);
  for I := 0 to Integer(Notifications.count) - 1 do
  begin
    NativeNotification := TNSUserNotification.Wrap(Notifications.objectAtIndex(I));
    Result[I] := ConvertNativeToDelphiNotification(NativeNotification);
  end;
end;

procedure TNotificationCenterCocoa.DoPresentNotification(const ANotification: TNotification);
var
  NativeNotification: NSUserNotification;
begin
  DoCancelNotification(ANotification);
  NativeNotification := CreateNativeNotification(ANotification);
  FNotificationCenter.deliverNotification(NativeNotification);
end;

procedure TNotificationCenterCocoa.DoScheduleNotification(const ANotification: TNotification);
var
  NativeNotification: NSUserNotification;
begin
  DoCancelNotification(ANotification);
  NativeNotification := CreateNativeNotification(ANotification);
  FNotificationCenter.scheduleNotification(NativeNotification);
end;

procedure TNotificationCenterCocoa.ReceiveNotification(const ANotification: NSUserNotification);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TMessage<TNotification>.Create(ConvertNativeToDelphiNotification(ANotification)));
end;

procedure TNotificationCenterCocoa.DoSetIconBadgeNumber(const ACount: Integer);
var
  NSApp: NSApplication;
begin
  if ACount > 0 then
  begin
    NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
    NSApp.dockTile.setBadgeLabel(StrToNSStr(ACount.ToString));
  end
  else
    DoResetIconBadgeNumber;
end;

function TNotificationCenterCocoa.DoGetIconBadgeNumber: Integer;
var
  NSApp: NSApplication;
  BadgeLabel: string;
begin
  NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
  if NSApp.dockTile.badgeLabel <> nil then
  begin
    BadgeLabel := UTF8ToString(NSApp.dockTile.badgeLabel.UTF8String);
    if not TryStrToInt(BadgeLabel, Result) then
      Result := 0;
  end
  else
    Result := 0;
end;

class function TNotificationCenterCocoa.GetNotificationCenter: TNotificationCenterCocoa;
begin
  if FNotificationCenterSingleton = nil then
    FNotificationCenterSingleton := TNotificationCenterCocoa.Create;
  Result := FNotificationCenterSingleton;
end;

procedure TNotificationCenterCocoa.DoResetIconBadgeNumber;
var
  NSApp: NSApplication;
begin
  NSApp := TNSApplication.Wrap(TNSApplication.OCClass.sharedApplication);
  NSApp.dockTile.setBadgeLabel(nil);
end;

{ TNotificationCenterDelegate }

constructor TNotificationCenterDelegate.Create(ANotificationCenter: TNotificationCenterCocoa);
begin
  inherited Create;
  FNotificationCenter := ANotificationCenter;
end;

procedure TNotificationCenterDelegate.userNotificationCenter(center: NSUserNotificationCenter;
  didActivateNotification: NSUserNotification);
begin
  if FNotificationCenter <> nil then
    FNotificationCenter.ReceiveNotification(didActivateNotification);
end;

{ TPlatformNotificationCenter }

class function TPlatformNotificationCenter.GetInstance: TBaseNotificationCenter;
begin
  if TOSVersion.Check(10, 8) then
    Result := TBaseNotificationCenter(TNotificationCenterCocoa.NotificationCenter)
  else
    Result := nil;
end;

end.
