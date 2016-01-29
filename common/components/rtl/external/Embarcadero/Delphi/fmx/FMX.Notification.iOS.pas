{*******************************************************}
{                                                       }
{         Delphi FireMonkey Notification Service        }
{                                                       }
{       Implementation Notification Center for iOS      }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// Reference on programm guide in Apple developer center:
// https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Introduction/Introduction.html

unit FMX.Notification.iOS;

interface

procedure RegisterNotificationService;
procedure UnregisterNotificationService;

implementation

uses
  FMX.Notification, FMX.Platform,
  System.SysUtils, System.Generics.Collections,
  Macapi.ObjectiveC,
  iOSapi.Foundation, iOSapi.CocoaTypes, iOSapi.UIKit;

type

{ TNotificationCenterCocoa }

  TNotificationCenterCocoa = class (TInterfacedObject, IFMXNotificationCenter)
  strict private
    function CreateNativeNotification(const ANotification: TNotification): UILocalNotification;
    function FindNativeNotification(const AID: string): UILocalNotification;
  public
    { IFMXNotificationCenter }
    procedure ScheduleNotification(const ANotification: TNotification);
    procedure PresentNotification(const ANotification: TNotification);
    procedure CancelNotification(const AName: string); overload;
    procedure CancelNotification(const ANotification: TNotification); overload;
    procedure CancelAllNotifications;
    procedure SetIconBadgeNumber(const ACount: Integer);
    procedure ResetIconBadgeNumber;
  end;

var
  NotificationCenter: TNotificationCenterCocoa;

procedure RegisterNotificationService;
begin
  NotificationCenter := TNotificationCenterCocoa.Create;
  TPlatformServices.Current.AddPlatformService(IFMXNotificationCenter, NotificationCenter);
end;

procedure UnregisterNotificationService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXNotificationCenter);
  NotificationCenter := nil;
end;

{$REGION 'Objective C - Delphi Helpers'}

function GetTimeZone: Integer;
begin
  Result := TNSTimeZone.Wrap(TNSTimeZone.OCClass.localTimeZone).secondsFromGMT div SecsPerHour;
end;

function DateTimeToNSDate(const ADateTime: TDateTime): NSDate;
var
  IntervalInterval: NSTimeInterval;
begin
  IntervalInterval := (ADateTime  - EncodeDate(2001, 1, 1)) * SecsPerDay;
  Result := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceReferenceDate(IntervalInterval));
end;

function NSDateToDateTime(const ADateTime: NSDate): TDateTime;
begin
  Result := (ADateTime.TimeIntervalSince1970 + GetTimeZone) / SecsPerDay + EncodeDate(1970, 1, 1);
end;

function GetGMTDateTime(const ADateTime: TDateTime): TDateTime;
begin
  if GetTimeZone > 0 then
    Result := ADateTime - EncodeTime(GetTimeZone, 0, 0, 0)
  else
    Result := ADateTime + EncodeTime(Abs(GetTimeZone), 0, 0, 0);
end;

function SharedApplication: UIApplication;
begin
  Result := TUIApplication.Wrap(TUIApplication.OCClass.sharedApplication);
end;

{$ENDREGION}

{$REGION 'TNotificationCenterCocoa'}

procedure TNotificationCenterCocoa.CancelAllNotifications;
begin
  SharedApplication.cancelAllLocalNotifications;
end;

function TNotificationCenterCocoa.FindNativeNotification(const AID: string): UILocalNotification;
var
  Notifications: NSArray;
  NativeNotification: UILocalNotification;
  Found: Boolean;
  I: NSUInteger;
  UserInfo: NSDictionary;
begin
  Notifications := SharedApplication.scheduledLocalNotifications;
  Found := False;
  I := 0;
  while (I < Notifications.count) and not Found do
  begin
    NativeNotification := TUILocalNotification.Wrap(Notifications.objectAtIndex(I));
    UserInfo := NativeNotification.userInfo;
    if (UserInfo <> nil) and (UTF8ToString(TNSString.Wrap(UserInfo.valueForKey(NSSTR('id'))).UTF8String) = AID) then
      Found := True
    else
      Inc(I);
  end;
  if Found then
    Result := TUILocalNotification.Wrap(Notifications.objectAtIndex(I))
  else
    Result := nil;
end;

procedure TNotificationCenterCocoa.CancelNotification(const AName: string);
var
  NativeNotification: UILocalNotification;
begin
  NativeNotification := FindNativeNotification(AName);
  if NativeNotification <> nil then
     SharedApplication.cancelLocalNotification(NativeNotification);
end;

procedure TNotificationCenterCocoa.CancelNotification(const ANotification: TNotification);
var
  NativeNotification: UILocalNotification;
begin
  if not Assigned(ANotification) then
    Exit;
  NativeNotification := FindNativeNotification(ANotification.Name);
  if NativeNotification <> nil then
     SharedApplication.cancelLocalNotification(NativeNotification);
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
      (NSSTR(ANotification.Name) as ILocalObject).GetObjectID,
      (NSSTR('id') as ILocalObject).GetObjectID));
    NativeNotification.setUserInfo(UserInfo);
  end;
  // Get GMT time and set notification fired date
  GMTDateTime := GetGMTDateTime(ANotification.FireDate);
  NativeNotification.setTimeZone(TNSTimeZone.Wrap(TNSTimeZone.OCClass.defaultTimeZone));
  NativeNotification.setFireDate(DateTimeToNSDate(GMTDateTime));
  NativeNotification.setApplicationIconBadgeNumber(ANotification.ApplicationIconBadgeNumber);
  NativeNotification.setAlertBody(NSSTR(ANotification.AlertBody));
  NativeNotification.setAlertAction(NSSTR(ANotification.AlertAction));
  NativeNotification.setHasAction(ANotification.HasAction);
  if ANotification.EnableSound then
    NativeNotification.setSoundName(UILocalNotificationDefaultSoundName)
  else
    NativeNotification.setSoundName(nil);
  Result := NativeNotification;
end;

procedure TNotificationCenterCocoa.PresentNotification(const ANotification: TNotification);
var
  NativeNatification: UILocalNotification;
begin
  NativeNatification := FindNativeNotification(ANotification.Name);
  if NativeNatification = nil then
    NativeNatification := CreateNativeNotification(ANotification);
  SharedApplication.presentLocalNotificationNow(NativeNatification);
end;

procedure TNotificationCenterCocoa.ScheduleNotification(const ANotification: TNotification);
var
  NativeNatification: UILocalNotification;
begin
  NativeNatification := FindNativeNotification(ANotification.Name);
  if NativeNatification = nil then
    NativeNatification := CreateNativeNotification(ANotification);
  SharedApplication.scheduleLocalNotification(NativeNatification);
end;

procedure TNotificationCenterCocoa.SetIconBadgeNumber(const ACount: Integer);
begin
  SharedApplication.setApplicationIconBadgeNumber(ACount);
end;

procedure TNotificationCenterCocoa.ResetIconBadgeNumber;
begin
  SharedApplication.setApplicationIconBadgeNumber(0);
end;

{$ENDREGION}

end.