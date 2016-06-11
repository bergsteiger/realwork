{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Notifications;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.DataRT,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.UI.Notifications Class Names
  // Windows.UI.Notifications.ToastNotifier
  // DualAPI
  SToastNotifier = 'Windows.UI.Notifications.ToastNotifier';
  // Windows.UI.Notifications.ToastNotification
  // DualAPI
  SToastNotification = 'Windows.UI.Notifications.ToastNotification';
  // Windows.UI.Notifications.ToastDismissedEventArgs
  // DualAPI
  SToastDismissedEventArgs = 'Windows.UI.Notifications.ToastDismissedEventArgs';
  // Windows.UI.Notifications.ToastFailedEventArgs
  // DualAPI
  SToastFailedEventArgs = 'Windows.UI.Notifications.ToastFailedEventArgs';
  // Windows.UI.Notifications.ToastNotificationManager
  // DualAPI
  SToastNotificationManager = 'Windows.UI.Notifications.ToastNotificationManager';
  // Windows.UI.Notifications.ToastActivatedEventArgs
  // DualAPI
  SToastActivatedEventArgs = 'Windows.UI.Notifications.ToastActivatedEventArgs';


type
  // Forward declare interfaces
  // Windows.UI.Notifications.IToastDismissedEventArgs
  IToastDismissedEventArgs = interface;
  PIToastDismissedEventArgs = ^IToastDismissedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastDismissedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs = interface;
  PTypedEventHandler_2__IToastNotification__IToastDismissedEventArgs = ^TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Object>
  TypedEventHandler_2__IToastNotification__IInspectable = interface;
  PTypedEventHandler_2__IToastNotification__IInspectable = ^TypedEventHandler_2__IToastNotification__IInspectable;

  // Windows.UI.Notifications.IToastFailedEventArgs
  IToastFailedEventArgs = interface;
  PIToastFailedEventArgs = ^IToastFailedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastFailedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastFailedEventArgs = interface;
  PTypedEventHandler_2__IToastNotification__IToastFailedEventArgs = ^TypedEventHandler_2__IToastNotification__IToastFailedEventArgs;

  // Windows.UI.Notifications.IToastNotification
  IToastNotification = interface;
  PIToastNotification = ^IToastNotification;

  // Windows.UI.Notifications.IToastActivatedEventArgs
  IToastActivatedEventArgs = interface;
  PIToastActivatedEventArgs = ^IToastActivatedEventArgs;

  // Windows.UI.Notifications.IScheduledToastNotification
  IScheduledToastNotification = interface;
  PIScheduledToastNotification = ^IScheduledToastNotification;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Notifications.IScheduledToastNotification>
  IIterator_1__IScheduledToastNotification = interface;
  PIIterator_1__IScheduledToastNotification = ^IIterator_1__IScheduledToastNotification;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IScheduledToastNotification>
  IIterable_1__IScheduledToastNotification = interface;
  PIIterable_1__IScheduledToastNotification = ^IIterable_1__IScheduledToastNotification;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Notifications.IScheduledToastNotification>
  IVectorView_1__IScheduledToastNotification = interface;
  PIVectorView_1__IScheduledToastNotification = ^IVectorView_1__IScheduledToastNotification;

  // Windows.UI.Notifications.IToastNotifier
  IToastNotifier = interface;
  PIToastNotifier = ^IToastNotifier;

  // Windows.UI.Notifications.IToastNotificationManagerStatics
  IToastNotificationManagerStatics = interface;
  PIToastNotificationManagerStatics = ^IToastNotificationManagerStatics;

  // Windows.UI.Notifications.IToastNotificationFactory
  IToastNotificationFactory = interface;
  PIToastNotificationFactory = ^IToastNotificationFactory;

  // Windows.UI.Notifications.IToastNotification2
  IToastNotification2 = interface;
  PIToastNotification2 = ^IToastNotification2;

  // Windows.UI.Notifications.IToastNotificationHistory
  IToastNotificationHistory = interface;
  PIToastNotificationHistory = ^IToastNotificationHistory;

  // Windows.UI.Notifications.IToastNotificationManagerStatics2
  IToastNotificationManagerStatics2 = interface;
  PIToastNotificationManagerStatics2 = ^IToastNotificationManagerStatics2;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Notifications.IToastNotification>
  IIterator_1__IToastNotification = interface;
  PIIterator_1__IToastNotification = ^IIterator_1__IToastNotification;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IToastNotification>
  IIterable_1__IToastNotification = interface;
  PIIterable_1__IToastNotification = ^IIterable_1__IToastNotification;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Notifications.IToastNotification>
  IVectorView_1__IToastNotification = interface;
  PIVectorView_1__IToastNotification = ^IVectorView_1__IToastNotification;


  // Emit Forwarded interfaces
  // Windows.UI.Notifications Interfaces
  // DualAPI Interface
  // Windows.UI.Notifications.IToastDismissedEventArgs
  [WinRTClassNameAttribute(SToastDismissedEventArgs)]
  IToastDismissedEventArgs = interface(IInspectable)
  ['{3F89D935-D9CB-4538-A0F0-FFE7659938F8}']
    function get_Reason: ToastDismissalReason; safecall;
    property Reason: ToastDismissalReason read get_Reason;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastDismissedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs_Delegate_Base = interface(IUnknown)
  ['{61C2402F-0ED0-5A18-AB69-59F4AA99A368}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastDismissedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs = interface(TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs_Delegate_Base)
  ['{52B78A8E-3D0A-5C4D-BBBA-24FAF495B9D4}']
    procedure Invoke(sender: IToastNotification; args: IToastDismissedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Object>
  TypedEventHandler_2__IToastNotification__IInspectable_Delegate_Base = interface(IUnknown)
  ['{AB54DE2D-97D9-5528-B6AD-105AFE156530}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Object>
  TypedEventHandler_2__IToastNotification__IInspectable = interface(TypedEventHandler_2__IToastNotification__IInspectable_Delegate_Base)
  ['{93621AAC-6E87-5F7A-AA83-927B2D905518}']
    procedure Invoke(sender: IToastNotification; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastFailedEventArgs
  [WinRTClassNameAttribute(SToastFailedEventArgs)]
  IToastFailedEventArgs = interface(IInspectable)
  ['{35176862-CFD4-44F8-AD64-F500FD896C3B}']
    function get_ErrorCode: HRESULT; safecall;
    property ErrorCode: HRESULT read get_ErrorCode;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastFailedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastFailedEventArgs_Delegate_Base = interface(IUnknown)
  ['{95E3E803-C969-5E3A-9753-EA2AD22A9A33}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Notifications.IToastNotification,Windows.UI.Notifications.IToastFailedEventArgs>
  TypedEventHandler_2__IToastNotification__IToastFailedEventArgs = interface(TypedEventHandler_2__IToastNotification__IToastFailedEventArgs_Delegate_Base)
  ['{DB5E9BE6-9CDD-589F-96DA-A4A5D3697DFD}']
    procedure Invoke(sender: IToastNotification; args: IToastFailedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotification
  [WinRTClassNameAttribute(SToastNotification)]
  IToastNotification = interface(IInspectable)
  ['{997E2675-059E-4E60-8B06-1760917C8B80}']
    function get_Content: Xml_Dom_IXmlDocument; safecall;
    procedure put_ExpirationTime(value: IReference_1__DateTime); safecall;
    function get_ExpirationTime: IReference_1__DateTime; safecall;
    function add_Dismissed(handler: TypedEventHandler_2__IToastNotification__IToastDismissedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Dismissed(cookie: EventRegistrationToken); safecall;
    function add_Activated(handler: TypedEventHandler_2__IToastNotification__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Activated(cookie: EventRegistrationToken); safecall;
    function add_Failed(handler: TypedEventHandler_2__IToastNotification__IToastFailedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Failed(token: EventRegistrationToken); safecall;
    property Content: Xml_Dom_IXmlDocument read get_Content;
    property ExpirationTime: IReference_1__DateTime read get_ExpirationTime write put_ExpirationTime;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastActivatedEventArgs
  [WinRTClassNameAttribute(SToastActivatedEventArgs)]
  IToastActivatedEventArgs = interface(IInspectable)
  ['{E3BF92F3-C197-436F-8265-0625824F8DAC}']
    function get_Arguments: HSTRING; safecall;
    property Arguments: HSTRING read get_Arguments;
  end;

  // Windows.UI.Notifications.IScheduledToastNotification
  IScheduledToastNotification = interface(IInspectable)
  ['{79F577F8-0DE7-48CD-9740-9B370490C838}']
    function get_Content: Xml_Dom_IXmlDocument; safecall;
    function get_DeliveryTime: DateTime; safecall;
    function get_SnoozeInterval: IReference_1__TimeSpan; safecall;
    function get_MaximumSnoozeCount: Cardinal; safecall;
    procedure put_Id(value: HSTRING); safecall;
    function get_Id: HSTRING; safecall;
    property Content: Xml_Dom_IXmlDocument read get_Content;
    property DeliveryTime: DateTime read get_DeliveryTime;
    property Id: HSTRING read get_Id write put_Id;
    property MaximumSnoozeCount: Cardinal read get_MaximumSnoozeCount;
    property SnoozeInterval: IReference_1__TimeSpan read get_SnoozeInterval;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Notifications.IScheduledToastNotification>
  IIterator_1__IScheduledToastNotification = interface(IInspectable)
  ['{6C34AAF7-B3EF-5E61-ADA9-2024702696C6}']
    function get_Current: IScheduledToastNotification; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIScheduledToastNotification): Cardinal; safecall;
    property Current: IScheduledToastNotification read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IScheduledToastNotification>
  IIterable_1__IScheduledToastNotification_Base = interface(IInspectable)
  ['{7A7B2A51-C182-5846-A861-4F9C036F24AD}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IScheduledToastNotification>
  IIterable_1__IScheduledToastNotification = interface(IIterable_1__IScheduledToastNotification_Base)
  ['{92B73B0F-5001-54D8-B43C-AAB6D146FBC9}']
    function First: IIterator_1__IScheduledToastNotification; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Notifications.IScheduledToastNotification>
  IVectorView_1__IScheduledToastNotification = interface(IInspectable)
  ['{762EC9E6-C409-5C27-B61F-C480347C1816}']
    function GetAt(index: Cardinal): IScheduledToastNotification; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IScheduledToastNotification; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIScheduledToastNotification): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotifier
  [WinRTClassNameAttribute(SToastNotifier)]
  IToastNotifier = interface(IInspectable)
  ['{75927B93-03F3-41EC-91D3-6E5BAC1B38E7}']
    procedure Show(notification: IToastNotification); safecall;
    procedure Hide(notification: IToastNotification); safecall;
    function get_Setting: NotificationSetting; safecall;
    procedure AddToSchedule(scheduledToast: IScheduledToastNotification); safecall;
    procedure RemoveFromSchedule(scheduledToast: IScheduledToastNotification); safecall;
    function GetScheduledToastNotifications: IVectorView_1__IScheduledToastNotification; safecall;
    property Setting: NotificationSetting read get_Setting;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotificationManagerStatics
  [WinRTClassNameAttribute(SToastNotificationManager)]
  IToastNotificationManagerStatics = interface(IInspectable)
  ['{50AC103F-D235-4598-BBEF-98FE4D1A3AD4}']
    function CreateToastNotifier: IToastNotifier; overload; safecall;
    function CreateToastNotifier(applicationId: HSTRING): IToastNotifier; overload; safecall;
    function GetTemplateContent(&type: ToastTemplateType): Xml_Dom_IXmlDocument; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotificationFactory
  [WinRTClassNameAttribute(SToastNotification)]
  IToastNotificationFactory = interface(IInspectable)
  ['{04124B20-82C6-4229-B109-FD9ED4662B53}']
    function CreateToastNotification(content: Xml_Dom_IXmlDocument): IToastNotification; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotification2
  IToastNotification2 = interface(IInspectable)
  ['{9DFB9FD1-143A-490E-90BF-B9FBA7132DE7}']
    procedure put_Tag(value: HSTRING); safecall;
    function get_Tag: HSTRING; safecall;
    procedure put_Group(value: HSTRING); safecall;
    function get_Group: HSTRING; safecall;
    procedure put_SuppressPopup(value: Boolean); safecall;
    function get_SuppressPopup: Boolean; safecall;
    property Group: HSTRING read get_Group write put_Group;
    property SuppressPopup: Boolean read get_SuppressPopup write put_SuppressPopup;
    property Tag: HSTRING read get_Tag write put_Tag;
  end;

  // Windows.UI.Notifications.IToastNotificationHistory
  IToastNotificationHistory = interface(IInspectable)
  ['{5CADDC63-01D3-4C97-986F-0533483FEE14}']
    procedure RemoveGroup(group: HSTRING); overload; safecall;
    procedure RemoveGroup(group: HSTRING; applicationId: HSTRING); overload; safecall;
    procedure Remove(tag: HSTRING; group: HSTRING; applicationId: HSTRING); overload; safecall;
    procedure Remove(tag: HSTRING; group: HSTRING); overload; safecall;
    procedure Remove(tag: HSTRING); overload; safecall;
    procedure Clear; overload; safecall;
    procedure Clear(applicationId: HSTRING); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Notifications.IToastNotificationManagerStatics2
  [WinRTClassNameAttribute(SToastNotificationManager)]
  IToastNotificationManagerStatics2 = interface(IInspectable)
  ['{7AB93C52-0E48-4750-BA9D-1A4113981847}']
    function get_History: IToastNotificationHistory; safecall;
    property History: IToastNotificationHistory read get_History;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Notifications.IToastNotification>
  IIterator_1__IToastNotification = interface(IInspectable)
  ['{ABA5D40A-4EF1-5090-8A7E-B2B779BCCBB7}']
    function get_Current: IToastNotification; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIToastNotification): Cardinal; safecall;
    property Current: IToastNotification read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IToastNotification>
  IIterable_1__IToastNotification_Base = interface(IInspectable)
  ['{52C9428B-D37A-554D-BF55-B8685D5F552D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Notifications.IToastNotification>
  IIterable_1__IToastNotification = interface(IIterable_1__IToastNotification_Base)
  ['{DD43185C-C276-593B-B076-B598FCD176DB}']
    function First: IIterator_1__IToastNotification; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Notifications.IToastNotification>
  IVectorView_1__IToastNotification = interface(IInspectable)
  ['{82CB31B6-357F-581F-A6C9-CBCB308BAEC8}']
    function GetAt(index: Cardinal): IToastNotification; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IToastNotification; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIToastNotification): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.UI.Notifications.ToastNotifier
  // DualAPI

  // Windows.UI.Notifications.ToastNotification
  // DualAPI
  TToastNotification = class(TWinRTGenericImportF<IToastNotificationFactory>)
  public
    // -> IToastNotificationFactory
    class function CreateToastNotification(content: Xml_Dom_IXmlDocument): IToastNotification; static; inline;
  end;

  // Windows.UI.Notifications.ToastDismissedEventArgs
  // DualAPI

  // Windows.UI.Notifications.ToastFailedEventArgs
  // DualAPI

  // Windows.UI.Notifications.ToastNotificationManager
  // DualAPI
  TToastNotificationManager = class(TWinRTGenericImportS2<IToastNotificationManagerStatics, IToastNotificationManagerStatics2>)
  public
    // -> IToastNotificationManagerStatics
    class function CreateToastNotifier: IToastNotifier; overload; static; inline;
    class function CreateToastNotifier(applicationId: HSTRING): IToastNotifier; overload; static; inline;
    class function GetTemplateContent(&type: ToastTemplateType): Xml_Dom_IXmlDocument; static; inline;

    // -> IToastNotificationManagerStatics2
    class function get_History: IToastNotificationHistory; static; inline;
    class property History: IToastNotificationHistory read get_History;
  end;

  // Windows.UI.Notifications.ToastActivatedEventArgs
  // DualAPI


implementation

  // Emit Classes Implementation
 { TToastNotification }
// Factories for : "ToastNotification"
// Factory: "Windows.UI.Notifications.IToastNotificationFactory"
// -> IToastNotificationFactory

class function TToastNotification.CreateToastNotification(content: Xml_Dom_IXmlDocument): IToastNotification;
begin
  Result := Factory.CreateToastNotification(content);
end;


 { TToastNotificationManager }

class function TToastNotificationManager.CreateToastNotifier: IToastNotifier;
begin
  Result := Statics.CreateToastNotifier;
end;

class function TToastNotificationManager.CreateToastNotifier(applicationId: HSTRING): IToastNotifier;
begin
  Result := Statics.CreateToastNotifier(applicationId);
end;

class function TToastNotificationManager.GetTemplateContent(&type: ToastTemplateType): Xml_Dom_IXmlDocument;
begin
  Result := Statics.GetTemplateContent(&type);
end;


class function TToastNotificationManager.get_History: IToastNotificationHistory;
begin
  Result := Statics2.get_History;
end;



end.
