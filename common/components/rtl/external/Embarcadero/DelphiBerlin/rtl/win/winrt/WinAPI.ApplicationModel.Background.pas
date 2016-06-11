{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.ApplicationModel.Background;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Devices,
  Winapi.Devices.Bluetooth,
  Winapi.Networking,
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.Storage,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  AsyncOperationCompletedHandler_1__BackgroundAccessStatus = interface;
  PAsyncOperationCompletedHandler_1__BackgroundAccessStatus = ^AsyncOperationCompletedHandler_1__BackgroundAccessStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  IAsyncOperation_1__BackgroundAccessStatus = interface;
  PIAsyncOperation_1__BackgroundAccessStatus = ^IAsyncOperation_1__BackgroundAccessStatus;

  // Windows.ApplicationModel.Background.IBackgroundTaskInstance2
  IBackgroundTaskInstance2 = interface;
  PIBackgroundTaskInstance2 = ^IBackgroundTaskInstance2;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  AsyncOperationCompletedHandler_1__ApplicationTriggerResult = interface;
  PAsyncOperationCompletedHandler_1__ApplicationTriggerResult = ^AsyncOperationCompletedHandler_1__ApplicationTriggerResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  IAsyncOperation_1__ApplicationTriggerResult = interface;
  PIAsyncOperation_1__ApplicationTriggerResult = ^IAsyncOperation_1__ApplicationTriggerResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult = interface;
  PAsyncOperationCompletedHandler_1__MediaProcessingTriggerResult = ^AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  IAsyncOperation_1__MediaProcessingTriggerResult = interface;
  PIAsyncOperation_1__MediaProcessingTriggerResult = ^IAsyncOperation_1__MediaProcessingTriggerResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  AsyncOperationCompletedHandler_1__DeviceTriggerResult = interface;
  PAsyncOperationCompletedHandler_1__DeviceTriggerResult = ^AsyncOperationCompletedHandler_1__DeviceTriggerResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  IAsyncOperation_1__DeviceTriggerResult = interface;
  PIAsyncOperation_1__DeviceTriggerResult = ^IAsyncOperation_1__DeviceTriggerResult;

  // Windows.ApplicationModel.Background.IDeviceWatcherTrigger
  IDeviceWatcherTrigger = interface;
  PIDeviceWatcherTrigger = ^IDeviceWatcherTrigger;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  AsyncOperationCompletedHandler_1__AlarmAccessStatus = interface;
  PAsyncOperationCompletedHandler_1__AlarmAccessStatus = ^AsyncOperationCompletedHandler_1__AlarmAccessStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  IAsyncOperation_1__AlarmAccessStatus = interface;
  PIAsyncOperation_1__AlarmAccessStatus = ^IAsyncOperation_1__AlarmAccessStatus;


  // Emit Forwarded interfaces
  // Windows.ApplicationModel.Background Interfaces
  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  AsyncOperationCompletedHandler_1__BackgroundAccessStatus_Delegate_Base = interface(IUnknown)
  ['{26DD26E3-3F47-5709-B2F2-D6D0AD3288F0}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  AsyncOperationCompletedHandler_1__BackgroundAccessStatus = interface(AsyncOperationCompletedHandler_1__BackgroundAccessStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__BackgroundAccessStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  IAsyncOperation_1__BackgroundAccessStatus_Base = interface(IInspectable)
  ['{7B44E581-CFA9-5763-BED7-6A65739F0DBF}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.BackgroundAccessStatus>
  IAsyncOperation_1__BackgroundAccessStatus = interface(IAsyncOperation_1__BackgroundAccessStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__BackgroundAccessStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__BackgroundAccessStatus; safecall;
    function GetResults: BackgroundAccessStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__BackgroundAccessStatus read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.Background.IBackgroundTaskInstance2
  IBackgroundTaskInstance2 = interface(IInspectable)
  ['{4F7D0176-0C76-4FB4-896D-5DE1864122F6}']
    function GetThrottleCount(counter: BackgroundTaskThrottleCounter): Cardinal; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  AsyncOperationCompletedHandler_1__ApplicationTriggerResult_Delegate_Base = interface(IUnknown)
  ['{D0065EF6-EE9D-55F8-AC2B-53A91FF96D2E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  AsyncOperationCompletedHandler_1__ApplicationTriggerResult = interface(AsyncOperationCompletedHandler_1__ApplicationTriggerResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ApplicationTriggerResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  IAsyncOperation_1__ApplicationTriggerResult_Base = interface(IInspectable)
  ['{47CBD985-0F08-5A3D-92CF-B27960506ED6}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.ApplicationTriggerResult>
  IAsyncOperation_1__ApplicationTriggerResult = interface(IAsyncOperation_1__ApplicationTriggerResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ApplicationTriggerResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ApplicationTriggerResult; safecall;
    function GetResults: ApplicationTriggerResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ApplicationTriggerResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult_Delegate_Base = interface(IUnknown)
  ['{3814C6A5-2AD1-5875-BED5-5031CD1F50A2}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult = interface(AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__MediaProcessingTriggerResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  IAsyncOperation_1__MediaProcessingTriggerResult_Base = interface(IInspectable)
  ['{2595482C-1CBF-5691-A30D-2164909C6712}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.MediaProcessingTriggerResult>
  IAsyncOperation_1__MediaProcessingTriggerResult = interface(IAsyncOperation_1__MediaProcessingTriggerResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult; safecall;
    function GetResults: MediaProcessingTriggerResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__MediaProcessingTriggerResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  AsyncOperationCompletedHandler_1__DeviceTriggerResult_Delegate_Base = interface(IUnknown)
  ['{D5AA9506-1464-57D4-859D-7EE9B26CB1F9}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  AsyncOperationCompletedHandler_1__DeviceTriggerResult = interface(AsyncOperationCompletedHandler_1__DeviceTriggerResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DeviceTriggerResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  IAsyncOperation_1__DeviceTriggerResult_Base = interface(IInspectable)
  ['{B5136C46-2F2E-511D-9E8E-5EF4DECB1DA7}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.DeviceTriggerResult>
  IAsyncOperation_1__DeviceTriggerResult = interface(IAsyncOperation_1__DeviceTriggerResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DeviceTriggerResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DeviceTriggerResult; safecall;
    function GetResults: DeviceTriggerResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DeviceTriggerResult read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.Background.IDeviceWatcherTrigger
  IDeviceWatcherTrigger = interface(IInspectable)
  ['{A4617FDD-8573-4260-BEFC-5BEC89CB693D}']
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  AsyncOperationCompletedHandler_1__AlarmAccessStatus_Delegate_Base = interface(IUnknown)
  ['{84108017-A8E7-5449-B713-DF48503A953E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  AsyncOperationCompletedHandler_1__AlarmAccessStatus = interface(AsyncOperationCompletedHandler_1__AlarmAccessStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__AlarmAccessStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  IAsyncOperation_1__AlarmAccessStatus_Base = interface(IInspectable)
  ['{A55A747D-59F6-5CB6-B439-C8AAD670905C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Background.AlarmAccessStatus>
  IAsyncOperation_1__AlarmAccessStatus = interface(IAsyncOperation_1__AlarmAccessStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__AlarmAccessStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__AlarmAccessStatus; safecall;
    function GetResults: AlarmAccessStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__AlarmAccessStatus read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
