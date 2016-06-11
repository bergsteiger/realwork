{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{   Description of interface for notificatione center   }
{                                                       }
{   Local notifications are ways for an application     }
{   that isn’t running in the foreground to let its     }
{   users know it has information for them.             }
{   The information could be a message, an impending    }
{   calendar event. When presented by the operating     }
{   system, local notifications look and sound          }
{   the same. They can display an alert message or      }
{   they can badge the application icon. They can       }
{   also play a sound when the alert or badge number    }
{   is shown.                                           }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Notification;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Messaging;

type

{ TNotification }

  /// <summary>Specifies interval for repeating notification in case, when we use scheduled notification</summary>
  TRepeatInterval = (None, Second, Minute, Hour, Day, Week, Weekday, Month, Quarter, Year, Era);

  /// <summary>Discription of notification for Notification Center </summary>
  TNotification = class(TPersistent)
  protected
    /// <summary>Make a copy of data and save to Dest object</summary>
    procedure AssignTo(Dest: TPersistent); override;
  public
    /// <summary>Unique identificator for determenation notification in Notification Center. Specify id, if you would
    /// like to cancel or change this notification in future. The identifier shall be unique only within your
    /// application</summary>
    /// <remarks>if you identificator will not unique, and you will use it in TNotificationCenter, NotificationCenter
    /// will replace information of existing notification by this</remarks>
    Name: string;
    /// <summary>Title of notification. </summary>
    /// <remarks>Working of this property depends of target platform. It's supported only on OSX platform</remarks>
    Title: string;
    /// <summary>Text of notification message</summary>
    AlertBody: string;
    /// <summary>Caption of action button. Also see a value of <c>HasAction</c>.</summary>
    /// <remarks>Working of this property depends of target platform.</remarks>
    AlertAction: string;
    /// <summary>Number on label of application icon or notification in Notification Center.</summary>
    Number: Integer;
    /// <summary>Date and Time, when notification shall appears. Used only in Scheduled notifications.</summary>
    FireDate: TDateTime;
    /// <summary>Turns Off or Turns On a playing sound, when notification is appeared.</summary>
    /// <remarks>Playing sound depends on behavior of target platform.</remarks>
    EnableSound: Boolean;
    /// <summary>Sound's file name</summary>
    SoundName: string;
    /// <summary>True if notification should have action buttons. Returns False otherwise. </summary>
    /// <remarks>Working of this property depends of target platform. For example, on iOS user need to allow application
    /// to use it in General settings of devices.</remarks>
    HasAction: Boolean;
    /// <summary>Specifies interval for repeating notification in case, when we use scheduled notification</summary>
    /// <remarks>If you would like to specify custom interval (30 minutes, 4 hours and etc. For example, if you would
    /// like to show notification every 30 minutes, you need to create two notification, which will be shown every hour,
    /// but will have difference in <c>fireDate</c> in 30 minutes.</remarks>
    RepeatInterval: TRepeatInterval;
    /// <summary>Initializes of notification</summary>
    constructor Create;
  end;


{ TBaseNotificationCenter }

  /// <summary>Array holding Notifications.</summary>
  TNotifications = array of TNotification;
  /// <summary>Signature of ReceiveLocalNotification Event</summary>
  TOnReceiveLocalNotification = procedure (Sender: TObject; ANotification: TNotification) of object;

  /// <summary>Class to use the Notification Center as framework</summary>
  TBaseNotificationCenter = class
  private
    FOnReceiveLocalNotification: TOnReceiveLocalNotification;
    class function InternalGetInstance: TBaseNotificationCenter; static;
  protected
    /// <summary>Platform getter.</summary>
    class function GetInstance: TBaseNotificationCenter; virtual; abstract;
    /// <summary>Schedules a local notification for delivery at its encapsulated date and time.</summary>
    procedure DoScheduleNotification(const ANotification: TNotification); virtual; abstract;
    /// <summary>Presents a local notification immediately.</summary>
    procedure DoPresentNotification(const ANotification: TNotification); virtual; abstract;
    /// <summary>Cancels the delivery of the specified scheduled local notification. |AName| - Unique identificator of
    /// notification</summary>
    procedure DoCancelNotification(const AName: string); overload; virtual; abstract;
    /// <summary>Cancels the delivery of the specified scheduled local notification.</summary>
    procedure DoCancelNotification(const ANotification: TNotification); overload; virtual; abstract;
    /// <summary>Cancels the delivery of all scheduled local notifications.</summary>
    procedure DoCancelAllNotifications; virtual; abstract;
    /// <summary>The number currently set as the badge of the application icon.</summary>
    procedure DoSetIconBadgeNumber(const ACount: Integer); virtual; abstract;
    /// <summary>Getting The number currently set as the badge of the application icon.</summary>
    function DoGetIconBadgeNumber: Integer; virtual; abstract;
    /// <summary>Reset the number of the application icon.</summary>
    procedure DoResetIconBadgeNumber; virtual; abstract;
    /// <summary>Allows the user to write a response when the user clicks the notification message in the notification center.</summary>
    procedure DoReceiveLocalNotification(const Sender: TObject; const M: TMessage); virtual;
    /// <summary>Notify when the component is loaded in the form, so we can process a pending local notification.</summary>
    procedure DoLoaded; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    { Building }
    /// <summary>Create an empty Notification.</summary>
    function CreateNotification: TNotification; overload;
    /// <summary>Create a Notification with defined values.</summary>
    function CreateNotification(const AName, AAlertBody: string; const AFireDate: TDateTime): TNotification; overload;
    { Presentation }
    /// <summary>Fire a Notification.</summary>
    procedure PresentNotification(const ANotification: TNotification);
    /// <summary>Fire a Notification by its FireDate property.</summary>
    procedure ScheduleNotification(const ANotification: TNotification);
    /// <summary>Cancel all Notification.</summary>
    procedure CancelAll;
    /// <summary>Cancel a Notification by its name.</summary>
    procedure CancelNotification(const AName: string);
    { Properties }
    /// <summary>Property to access to the Icon Badge Number.</summary>
    property ApplicationIconBadgeNumber: Integer read DoGetIconBadgeNumber write DoSetIconBadgeNumber;
    /// <summary>Event to notify that we have received a local notification.</summary>
    property OnReceiveLocalNotification: TOnReceiveLocalNotification read FOnReceiveLocalNotification
      write FOnReceiveLocalNotification;
  end;


{ TNotificationCenter }
  /// <summary>Class to use the Notification Center as a component</summary>
  TCustomNotificationCenter = class(TComponent)
  private
    FPlatformNotificationCenter: TBaseNotificationCenter;
    FOnReceiveLocalNotification: TOnReceiveLocalNotification;
    class constructor Create;
  protected
    /// <summary>Schedules a local notification for delivery at its encapsulated date and time.</summary>
    procedure DoScheduleNotification(const ANotification: TNotification); virtual;
    /// <summary>Presents a local notification immediately.</summary>
    procedure DoPresentNotification(const ANotification: TNotification); virtual;
    /// <summary>Cancels the delivery of the specified scheduled local notification. |AName| - Unique identificator of
    /// notification</summary>
    procedure DoCancelNotification(const AName: string); overload; virtual;
    /// <summary>Cancels the delivery of the specified scheduled local notification.</summary>
    procedure DoCancelNotification(const ANotification: TNotification); overload; virtual;
    /// <summary>Cancels the delivery of all scheduled local notifications.</summary>
    procedure DoCancelAllNotifications; virtual;
    /// <summary>The number currently set as the badge of the application icon.</summary>
    procedure DoSetIconBadgeNumber(const ACount: Integer); virtual;
    /// <summary>Getting The number currently set as the badge of the application icon.</summary>
    function DoGetIconBadgeNumber: Integer; virtual;
    /// <summary>Reset the number of the application icon.</summary>
    procedure DoResetIconBadgeNumber; virtual;
    /// <summary>Allows the user to write a response when the user clicks the notification message in the notification center.</summary>
    procedure DoReceiveLocalNotification(const Sender: TObject; const M: TMessage); virtual;
    /// <summary>Event fired when the component is fully loaded, so we can check if we have a notification.</summary>
    procedure DoLoaded; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    /// <summary>Is notification center supported on current platform or not?</summary>
    function Supported: Boolean; inline;
    { Building }
    /// <summary>Create an empty Notification.</summary>
    function CreateNotification: TNotification; overload;
    /// <summary>Create a Notification with defined values.</summary>
    function CreateNotification(const AName, AAlertBody: string; const AFireDate: TDateTime): TNotification; overload;
    { Presentation }
    /// <summary>Fire a Notification.</summary>
    procedure PresentNotification(const ANotification: TNotification);
    /// <summary>Fire a Notification by its FireDate property.</summary>
    procedure ScheduleNotification(const ANotification: TNotification);
    /// <summary>Cancel all Notification.</summary>
    procedure CancelAll;
    /// <summary>Cancel a Notification by its name.</summary>
    procedure CancelNotification(const AName: string);
    { Properties }
    /// <summary>Property to access to the Icon Badge Number.</summary>
    property ApplicationIconBadgeNumber: Integer read DoGetIconBadgeNumber write DoSetIconBadgeNumber default 0;
    /// <summary>Event to notify that we have received a local notification.</summary>
    property OnReceiveLocalNotification: TOnReceiveLocalNotification read FOnReceiveLocalNotification
      write FOnReceiveLocalNotification;
  end;

  [ComponentPlatformsAttribute(pidOSX32 or pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or pidWin32 or pidWin64)]
  TNotificationCenter = class(TCustomNotificationCenter)
  published
    property ApplicationIconBadgeNumber;
    property OnReceiveLocalNotification;
  end;

implementation

uses
{$IFDEF IOS}
  System.iOS.Notification;
{$ENDIF IOS}
{$IFDEF OSX}
  System.Mac.Notification;
{$ENDIF OSX}
{$IFDEF ANDROID}
  System.Android.Notification;
{$ENDIF ANDROID}
{$IFDEF MSWINDOWS}
  System.Win.Notification;
{$ENDIF MSWINDOWS}


{ TNotificationCenter }

procedure TCustomNotificationCenter.CancelAll;
begin
  DoCancelAllNotifications;
end;

procedure TCustomNotificationCenter.CancelNotification(const AName: string);
begin
  DoCancelNotification(AName);
end;

constructor TCustomNotificationCenter.Create(AOwner: TComponent);
begin
  inherited;
  FPlatformNotificationCenter := TBaseNotificationCenter.InternalGetInstance;
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<TNotification>, DoReceiveLocalNotification);
end;

function TCustomNotificationCenter.CreateNotification: TNotification;
begin
  if Supported then
    Result := FPlatformNotificationCenter.CreateNotification
  else
    Result := nil;
end;

class constructor TCustomNotificationCenter.Create;
begin
{$IF defined(IOS) or defined(ANDROID)}
  // We need to create the NotificationCenter to register the external notification messages from the system in the app initialization
  TBaseNotificationCenter.InternalGetInstance;
{$ENDIF}
end;

function TCustomNotificationCenter.CreateNotification(const AName, AAlertBody: string; const AFireDate: TDateTime): TNotification;
begin
  if Supported then
    Result := FPlatformNotificationCenter.CreateNotification(AName, AAlertBody, AFireDate)
  else
    Result := nil;
end;

destructor TCustomNotificationCenter.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TMessage<TNotification>, DoReceiveLocalNotification);
  inherited;
end;

procedure TCustomNotificationCenter.DoCancelAllNotifications;
begin
  if Supported then
    FPlatformNotificationCenter.DoCancelAllNotifications;
end;

procedure TCustomNotificationCenter.DoCancelNotification(const AName: string);
begin
  if Supported then
    FPlatformNotificationCenter.DoCancelNotification(AName);
end;

procedure TCustomNotificationCenter.DoCancelNotification(const ANotification: TNotification);
begin
  if Supported then
    FPlatformNotificationCenter.DoCancelNotification(ANotification);
end;

function TCustomNotificationCenter.DoGetIconBadgeNumber: Integer;
begin
  if Supported then
    Result := FPlatformNotificationCenter.DoGetIconBadgeNumber
  else
    Result := 0;
end;

procedure TCustomNotificationCenter.DoLoaded;
begin
  if Supported then
    FPlatformNotificationCenter.DoLoaded;
end;

procedure TCustomNotificationCenter.DoPresentNotification(const ANotification: TNotification);
begin
  if Supported then
    FPlatformNotificationCenter.DoPresentNotification(ANotification);
end;

procedure TCustomNotificationCenter.DoReceiveLocalNotification(const Sender: TObject; const M: TMessage);
begin
  if Assigned(FOnReceiveLocalNotification) and (M is TMessage<TNotification>) then
    FOnReceiveLocalNotification(Self, TMessage<TNotification>(M).Value);
end;

procedure TCustomNotificationCenter.DoResetIconBadgeNumber;
begin
  if Supported then
    FPlatformNotificationCenter.DoResetIconBadgeNumber;
end;

procedure TCustomNotificationCenter.DoScheduleNotification(const ANotification: TNotification);
begin
  if Supported then
    FPlatformNotificationCenter.DoScheduleNotification(ANotification);
end;

procedure TCustomNotificationCenter.DoSetIconBadgeNumber(const ACount: Integer);
begin
  if Supported then
    FPlatformNotificationCenter.DoSetIconBadgeNumber(ACount);
end;

procedure TCustomNotificationCenter.Loaded;
begin
  inherited;
  DoLoaded;
end;

procedure TCustomNotificationCenter.PresentNotification(const ANotification: TNotification);
begin
  DoPresentNotification(ANotification);
end;

procedure TCustomNotificationCenter.ScheduleNotification(const ANotification: TNotification);
begin
  DoScheduleNotification(ANotification);
end;

function TCustomNotificationCenter.Supported: Boolean;
begin
  Result := FPlatformNotificationCenter <> nil;
end;

{ TNotification }

procedure TNotification.AssignTo(Dest: TPersistent);
var
  DestNotification: TNotification;
begin
  if Dest is TNotification then
  begin
    DestNotification := Dest as TNotification;
    DestNotification.Name := Name;
    DestNotification.Title := Title;
    DestNotification.AlertBody := AlertBody;
    DestNotification.AlertAction := AlertAction;
    DestNotification.Number := Number;
    DestNotification.FireDate := FireDate;
    DestNotification.EnableSound := EnableSound;
    DestNotification.SoundName := SoundName;
    DestNotification.HasAction := HasAction;
    DestNotification.RepeatInterval := RepeatInterval;
  end
  else
    inherited;
end;

constructor TNotification.Create;
begin
  inherited;
  EnableSound := True;
  HasAction := False;
  FireDate := Now;
  RepeatInterval := TRepeatInterval.None;
  Number := 0;
end;

{ TBaseNotificationCenter }

procedure TBaseNotificationCenter.CancelAll;
begin
  DoCancelAllNotifications;
end;

procedure TBaseNotificationCenter.CancelNotification(const AName: string);
begin
  DoCancelNotification(AName);
end;

constructor TBaseNotificationCenter.Create;
begin
  inherited;
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<TNotification>, DoReceiveLocalNotification);
end;

function TBaseNotificationCenter.CreateNotification: TNotification;
begin
  Result := TNotification.Create;
end;

function TBaseNotificationCenter.CreateNotification(const AName, AAlertBody: string;
  const AFireDate: TDateTime): TNotification;
begin
  Result := CreateNotification;
  Result.Name := AName;
  Result.AlertBody := AAlertBody;
  Result.FireDate := AFireDate;
end;

destructor TBaseNotificationCenter.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TMessage<TNotification>, DoReceiveLocalNotification);
  inherited;
end;

procedure TBaseNotificationCenter.DoLoaded;
begin
//
end;

procedure TBaseNotificationCenter.DoReceiveLocalNotification(const Sender: TObject; const M: TMessage);
begin
  if Assigned(FOnReceiveLocalNotification) and (M is TMessage<TNotification>) then
    FOnReceiveLocalNotification(Self, TMessage<TNotification>(M).Value);
end;

class function TBaseNotificationCenter.InternalGetInstance: TBaseNotificationCenter;
type
  TBaseNotificationCenterClass = class of TBaseNotificationCenter;
var
  LBaseNotificationCenterClass: TBaseNotificationCenterClass;
begin
  LBaseNotificationCenterClass := TPlatformNotificationCenter;
  Result := LBaseNotificationCenterClass.GetInstance;
end;

procedure TBaseNotificationCenter.PresentNotification(const ANotification: TNotification);
begin
  DoPresentNotification(ANotification);
end;

procedure TBaseNotificationCenter.ScheduleNotification(const ANotification: TNotification);
begin
  DoScheduleNotification(ANotification);
end;

end.
