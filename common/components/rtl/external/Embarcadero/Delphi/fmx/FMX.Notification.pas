{*******************************************************}
{                                                       }
{         Delphi FireMonkey Notification Service        }
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
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Notification;

interface

type

  /// <summary>
  ///   Discription of notification for Notification Center
  /// </summary>
  TNotification = class
  public
    // Unique identificator for determenation notification in Notification list
    Name: string;
    AlertBody: string;
    AlertAction: string;
    ApplicationIconBadgeNumber: Integer;
    FireDate: TDateTime;
    EnableSound: Boolean;
    HasAction: Boolean;
  end;

  /// <summary>
  ///   Interface for work with notification center in Apple's platforms
  /// </summary>
  IFMXNotificationCenter = interface
    ['{5C3C0232-26EF-45D9-A351-336ECE49EABA}']
    /// <summary>
    ///   Schedules a local notification for delivery at its
    ///   encapsulated date and time.
    /// </summary>
    procedure ScheduleNotification(const ANotification: TNotification);
    /// <summary>
    ///   Presents a local notification immediately.
    /// </summary>
    procedure PresentNotification(const ANotification: TNotification);
    /// <summary>
    ///   Cancels the delivery of the specified scheduled local notification.
    ///   <param name="AName">Unique identificator of notification</param>
    /// </summary>
    procedure CancelNotification(const AName: string); overload;
    /// <summary>
    ///   Cancels the delivery of the specified scheduled local notification.
    /// </summary>
    procedure CancelNotification(const ANotification: TNotification); overload;
    /// <summary>
    ///   Cancels the delivery of all scheduled local notifications.
    /// </summary>
    procedure CancelAllNotifications;
    /// <summary>
    ///   The number currently set as the badge of the application icon.
    /// </summary>
    procedure SetIconBadgeNumber(const ACount: Integer);
    /// <summary>
    ///   Reset the number of the application icon.
    /// </summary>
    procedure ResetIconBadgeNumber;
  end;

implementation

{$IFDEF IOS}
uses
  FMX.Notification.iOS;

initialization
  RegisterNotificationService;
{$ENDIF}

end.