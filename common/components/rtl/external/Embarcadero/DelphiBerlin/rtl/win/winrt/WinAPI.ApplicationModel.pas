{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.ApplicationModel;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Media,
  Winapi.DataRT,
  Winapi.ApplicationModel.DataTransfer,
  Winapi.SystemRT,
  Winapi.Devices,
  Winapi.Security,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.Storage,
  Winapi.Globalization,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.ApplicationModel Class Names
  // Windows.ApplicationModel.AppService.AppServiceRequest
  // DualAPI
  SAppService_AppServiceRequest = 'Windows.ApplicationModel.AppService.AppServiceRequest';
  // Windows.ApplicationModel.AppService.AppServiceDeferral
  // DualAPI
  SAppService_AppServiceDeferral = 'Windows.ApplicationModel.AppService.AppServiceDeferral';
  // Windows.ApplicationModel.AppService.AppServiceResponse
  // DualAPI
  SAppService_AppServiceResponse = 'Windows.ApplicationModel.AppService.AppServiceResponse';
  // Windows.ApplicationModel.AppService.AppServiceConnection
  // DualAPI
  SAppService_AppServiceConnection = 'Windows.ApplicationModel.AppService.AppServiceConnection';
  // Windows.ApplicationModel.AppService.AppServiceRequestReceivedEventArgs
  // DualAPI
  SAppService_AppServiceRequestReceivedEventArgs = 'Windows.ApplicationModel.AppService.AppServiceRequestReceivedEventArgs';
  // Windows.ApplicationModel.AppService.AppServiceClosedEventArgs
  // DualAPI
  SAppService_AppServiceClosedEventArgs = 'Windows.ApplicationModel.AppService.AppServiceClosedEventArgs';
  // Windows.ApplicationModel.AppService.AppServiceTriggerDetails
  // DualAPI
  SAppService_AppServiceTriggerDetails = 'Windows.ApplicationModel.AppService.AppServiceTriggerDetails';
  // Windows.ApplicationModel.Activation.LockScreenActivatedEventArgs
  // DualAPI
  SActivation_LockScreenActivatedEventArgs = 'Windows.ApplicationModel.Activation.LockScreenActivatedEventArgs';
  // Windows.ApplicationModel.AppDisplayInfo
  // DualAPI
  SAppDisplayInfo = 'Windows.ApplicationModel.AppDisplayInfo';
  // Windows.ApplicationModel.AppInfo
  // DualAPI
  SAppInfo = 'Windows.ApplicationModel.AppInfo';
  // Windows.ApplicationModel.LockScreen.LockScreenInfo
  // DualAPI
  SLockScreen_LockScreenInfo = 'Windows.ApplicationModel.LockScreen.LockScreenInfo';
  // Windows.ApplicationModel.LockScreen.LockScreenBadge
  // DualAPI
  SLockScreen_LockScreenBadge = 'Windows.ApplicationModel.LockScreen.LockScreenBadge';
  // Windows.ApplicationModel.LockScreen.LockScreenUnlockingDeferral
  // DualAPI
  SLockScreen_LockScreenUnlockingDeferral = 'Windows.ApplicationModel.LockScreen.LockScreenUnlockingDeferral';
  // Windows.ApplicationModel.LockScreen.LockApplicationHost
  // DualAPI
  SLockScreen_LockApplicationHost = 'Windows.ApplicationModel.LockScreen.LockApplicationHost';
  // Windows.ApplicationModel.LockScreen.LockScreenUnlockingEventArgs
  // DualAPI
  SLockScreen_LockScreenUnlockingEventArgs = 'Windows.ApplicationModel.LockScreen.LockScreenUnlockingEventArgs';
  // Windows.ApplicationModel.PackageStatus
  // DualAPI
  SPackageStatus = 'Windows.ApplicationModel.PackageStatus';
  // Windows.ApplicationModel.PackageId
  // DualAPI
  SPackageId = 'Windows.ApplicationModel.PackageId';
  // Windows.ApplicationModel.Package
  // DualAPI
  SPackageRT = 'Windows.ApplicationModel.Package';


type
  // Forward declare interfaces
  // Windows.ApplicationModel.AppService.IAppServiceDeferral
  AppService_IAppServiceDeferral = interface;
  PAppService_IAppServiceDeferral = ^AppService_IAppServiceDeferral;

  // Windows.ApplicationModel.AppService.IAppServiceClosedEventArgs
  AppService_IAppServiceClosedEventArgs = interface;
  PAppService_IAppServiceClosedEventArgs = ^AppService_IAppServiceClosedEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus = interface;
  PAsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus = ^AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  IAsyncOperation_1__AppService_AppServiceResponseStatus = interface;
  PIAsyncOperation_1__AppService_AppServiceResponseStatus = ^IAsyncOperation_1__AppService_AppServiceResponseStatus;

  // Windows.ApplicationModel.AppService.IAppServiceRequest
  AppService_IAppServiceRequest = interface;
  PAppService_IAppServiceRequest = ^AppService_IAppServiceRequest;

  // Windows.ApplicationModel.AppService.IAppServiceRequestReceivedEventArgs
  AppService_IAppServiceRequestReceivedEventArgs = interface;
  PAppService_IAppServiceRequestReceivedEventArgs = ^AppService_IAppServiceRequestReceivedEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus = interface;
  PAsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus = ^AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  IAsyncOperation_1__AppService_AppServiceConnectionStatus = interface;
  PIAsyncOperation_1__AppService_AppServiceConnectionStatus = ^IAsyncOperation_1__AppService_AppServiceConnectionStatus;

  // Windows.ApplicationModel.AppService.IAppServiceResponse
  AppService_IAppServiceResponse = interface;
  PAppService_IAppServiceResponse = ^AppService_IAppServiceResponse;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse = interface;
  PAsyncOperationCompletedHandler_1__AppService_IAppServiceResponse = ^AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  IAsyncOperation_1__AppService_IAppServiceResponse = interface;
  PIAsyncOperation_1__AppService_IAppServiceResponse = ^IAsyncOperation_1__AppService_IAppServiceResponse;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceRequestReceivedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs = interface;
  PTypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs = ^TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceClosedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs = interface;
  PTypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs = ^TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs;

  // Windows.ApplicationModel.AppService.IAppServiceConnection
  AppService_IAppServiceConnection = interface;
  PAppService_IAppServiceConnection = ^AppService_IAppServiceConnection;

  // Windows.ApplicationModel.AppService.IAppServiceTriggerDetails
  AppService_IAppServiceTriggerDetails = interface;
  PAppService_IAppServiceTriggerDetails = ^AppService_IAppServiceTriggerDetails;

  // Windows.ApplicationModel.IAppDisplayInfo
  IAppDisplayInfo = interface;
  PIAppDisplayInfo = ^IAppDisplayInfo;

  // Windows.ApplicationModel.IAppInfo
  IAppInfo = interface;
  PIAppInfo = ^IAppInfo;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.IAppInfo>
  IIterator_1__IAppInfo = interface;
  PIIterator_1__IAppInfo = ^IIterator_1__IAppInfo;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.IAppInfo>
  IIterable_1__IAppInfo = interface;
  PIIterable_1__IAppInfo = ^IIterable_1__IAppInfo;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>
  IVectorView_1__IAppInfo = interface;
  PIVectorView_1__IAppInfo = ^IVectorView_1__IAppInfo;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo = ^AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>>
  IAsyncOperation_1__IVectorView_1__IAppInfo = interface;
  PIAsyncOperation_1__IVectorView_1__IAppInfo = ^IAsyncOperation_1__IVectorView_1__IAppInfo;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>
  IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface;
  PIKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = ^IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>>
  IIterator_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = ^IIterator_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>>
  IIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = ^IIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>
  IMapView_2__HSTRING__Chat_ChatMessageStatus = interface;
  PIMapView_2__HSTRING__Chat_ChatMessageStatus = ^IMapView_2__HSTRING__Chat_ChatMessageStatus;

  // Windows.ApplicationModel.Chat.IChatItem
  Chat_IChatItem = interface;
  PChat_IChatItem = ^Chat_IChatItem;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Chat.IChatItem>
  IIterator_1__Chat_IChatItem = interface;
  PIIterator_1__Chat_IChatItem = ^IIterator_1__Chat_IChatItem;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Chat.IChatItem>
  IIterable_1__Chat_IChatItem = interface;
  PIIterable_1__Chat_IChatItem = ^IIterable_1__Chat_IChatItem;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>
  IVectorView_1__Chat_IChatItem = interface;
  PIVectorView_1__Chat_IChatItem = ^IVectorView_1__Chat_IChatItem;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem = ^AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>>
  IAsyncOperation_1__IVectorView_1__Chat_IChatItem = interface;
  PIAsyncOperation_1__IVectorView_1__Chat_IChatItem = ^IAsyncOperation_1__IVectorView_1__Chat_IChatItem;

  // Windows.Foundation.IReference`1<Windows.ApplicationModel.Email.EmailMailboxSmimeEncryptionAlgorithm>
  IReference_1__Email_EmailMailboxSmimeEncryptionAlgorithm = interface;
  PIReference_1__Email_EmailMailboxSmimeEncryptionAlgorithm = ^IReference_1__Email_EmailMailboxSmimeEncryptionAlgorithm;

  // Windows.Foundation.IReference`1<Windows.ApplicationModel.Email.EmailMailboxSmimeSigningAlgorithm>
  IReference_1__Email_EmailMailboxSmimeSigningAlgorithm = interface;
  PIReference_1__Email_EmailMailboxSmimeSigningAlgorithm = ^IReference_1__Email_EmailMailboxSmimeSigningAlgorithm;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.Activation.ISplashScreen,Object>
  TypedEventHandler_2__Activation_ISplashScreen__IInspectable = interface;
  PTypedEventHandler_2__Activation_ISplashScreen__IInspectable = ^TypedEventHandler_2__Activation_ISplashScreen__IInspectable;

  // Windows.ApplicationModel.Activation.ISplashScreen
  Activation_ISplashScreen = interface;
  PActivation_ISplashScreen = ^Activation_ISplashScreen;

  // Windows.ApplicationModel.Activation.IActivatedEventArgs
  Activation_IActivatedEventArgs = interface;
  PActivation_IActivatedEventArgs = ^Activation_IActivatedEventArgs;

  // Windows.ApplicationModel.Activation.ILockScreenActivatedEventArgs
  Activation_ILockScreenActivatedEventArgs = interface;
  PActivation_ILockScreenActivatedEventArgs = ^Activation_ILockScreenActivatedEventArgs;

  // Windows.ApplicationModel.LockScreen.ILockScreenBadge
  LockScreen_ILockScreenBadge = interface;
  PLockScreen_ILockScreenBadge = ^LockScreen_ILockScreenBadge;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockScreenInfo,Object>
  TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable = interface;
  PTypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable = ^TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IIterator_1__LockScreen_ILockScreenBadge = interface;
  PIIterator_1__LockScreen_ILockScreenBadge = ^IIterator_1__LockScreen_ILockScreenBadge;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IIterable_1__LockScreen_ILockScreenBadge = interface;
  PIIterable_1__LockScreen_ILockScreenBadge = ^IIterable_1__LockScreen_ILockScreenBadge;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IVectorView_1__LockScreen_ILockScreenBadge = interface;
  PIVectorView_1__LockScreen_ILockScreenBadge = ^IVectorView_1__LockScreen_ILockScreenBadge;

  // Windows.ApplicationModel.LockScreen.ILockScreenInfo
  LockScreen_ILockScreenInfo = interface;
  PLockScreen_ILockScreenInfo = ^LockScreen_ILockScreenInfo;

  // Windows.ApplicationModel.LockScreen.ILockScreenUnlockingDeferral
  LockScreen_ILockScreenUnlockingDeferral = interface;
  PLockScreen_ILockScreenUnlockingDeferral = ^LockScreen_ILockScreenUnlockingDeferral;

  // Windows.ApplicationModel.LockScreen.ILockScreenUnlockingEventArgs
  LockScreen_ILockScreenUnlockingEventArgs = interface;
  PLockScreen_ILockScreenUnlockingEventArgs = ^LockScreen_ILockScreenUnlockingEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockApplicationHost,Windows.ApplicationModel.LockScreen.ILockScreenUnlockingEventArgs>
  TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs = interface;
  PTypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs = ^TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs;

  // Windows.ApplicationModel.LockScreen.ILockApplicationHost
  LockScreen_ILockApplicationHost = interface;
  PLockScreen_ILockApplicationHost = ^LockScreen_ILockApplicationHost;

  // Windows.ApplicationModel.LockScreen.ILockApplicationHostStatics
  LockScreen_ILockApplicationHostStatics = interface;
  PLockScreen_ILockApplicationHostStatics = ^LockScreen_ILockApplicationHostStatics;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IIterator_1__Store_Preview_StoreSystemFeature = interface;
  PIIterator_1__Store_Preview_StoreSystemFeature = ^IIterator_1__Store_Preview_StoreSystemFeature;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IIterable_1__Store_Preview_StoreSystemFeature = interface;
  PIIterable_1__Store_Preview_StoreSystemFeature = ^IIterable_1__Store_Preview_StoreSystemFeature;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IVectorView_1__Store_Preview_StoreSystemFeature = interface;
  PIVectorView_1__Store_Preview_StoreSystemFeature = ^IVectorView_1__Store_Preview_StoreSystemFeature;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature = ^AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>>
  IAsyncOperation_1__IVectorView_1__Store_Preview_StoreSystemFeature = interface;
  PIAsyncOperation_1__IVectorView_1__Store_Preview_StoreSystemFeature = ^IAsyncOperation_1__IVectorView_1__Store_Preview_StoreSystemFeature;

  // Windows.ApplicationModel.Store.LicenseChangedEventHandler
  Store_LicenseChangedEventHandler = interface;
  PStore_LicenseChangedEventHandler = ^Store_LicenseChangedEventHandler;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Store.FulfillmentResult>
  AsyncOperationCompletedHandler_1__Store_FulfillmentResult = interface;
  PAsyncOperationCompletedHandler_1__Store_FulfillmentResult = ^AsyncOperationCompletedHandler_1__Store_FulfillmentResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Store.FulfillmentResult>
  IAsyncOperation_1__Store_FulfillmentResult = interface;
  PIAsyncOperation_1__Store_FulfillmentResult = ^IAsyncOperation_1__Store_FulfillmentResult;

  // Windows.ApplicationModel.Store.IProductListingWithConsumables
  Store_IProductListingWithConsumables = interface;
  PStore_IProductListingWithConsumables = ^Store_IProductListingWithConsumables;

  // Windows.ApplicationModel.IPackageIdWithMetadata
  IPackageIdWithMetadata = interface;
  PIPackageIdWithMetadata = ^IPackageIdWithMetadata;

  // Windows.ApplicationModel.IPackageWithMetadata
  IPackageWithMetadata = interface;
  PIPackageWithMetadata = ^IPackageWithMetadata;

  // Windows.ApplicationModel.IPackageStatus
  IPackageStatus = interface;
  PIPackageStatus = ^IPackageStatus;

  // Windows.ApplicationModel.IPackageId
  IPackageId = interface;
  PIPackageId = ^IPackageId;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.IPackage>
  IIterator_1__IPackage = interface;
  PIIterator_1__IPackage = ^IIterator_1__IPackage;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.IPackage>
  IIterable_1__IPackage = interface;
  PIIterable_1__IPackage = ^IIterable_1__IPackage;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IPackage>
  IVectorView_1__IPackage = interface;
  PIVectorView_1__IPackage = ^IVectorView_1__IPackage;

  // Windows.ApplicationModel.IPackage
  IPackage = interface;
  PIPackage = ^IPackage;

  // Windows.ApplicationModel.IPackage2
  IPackage2 = interface;
  PIPackage2 = ^IPackage2;

  // Windows.ApplicationModel.IPackage3
  IPackage3 = interface;
  PIPackage3 = ^IPackage3;

  // Windows.ApplicationModel.IPackageStatics
  IPackageStatics = interface;
  PIPackageStatics = ^IPackageStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult = interface;
  PAsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult = ^AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult = interface;
  PIAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult = ^IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundResult>
  AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = interface;
  PAsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = ^AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundResult>
  IAsyncOperation_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = interface;
  PIAsyncOperation_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = ^IAsyncOperation_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult;

  // Windows.ApplicationModel.Activation.IContactsProviderActivatedEventArgs
  Activation_IContactsProviderActivatedEventArgs = interface;
  PActivation_IContactsProviderActivatedEventArgs = ^Activation_IContactsProviderActivatedEventArgs;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.ApplicationModel.Search.Core.ISearchSuggestion>
  VectorChangedEventHandler_1__Search_Core_ISearchSuggestion = interface;
  PVectorChangedEventHandler_1__Search_Core_ISearchSuggestion = ^VectorChangedEventHandler_1__Search_Core_ISearchSuggestion;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.ApplicationModel.Search.Core.ISearchSuggestion>
  IObservableVector_1__Search_Core_ISearchSuggestion = interface;
  PIObservableVector_1__Search_Core_ISearchSuggestion = ^IObservableVector_1__Search_Core_ISearchSuggestion;

  // Windows.Foundation.Collections.IVector`1<Windows.ApplicationModel.IPackage>
  IVector_1__IPackage = interface;
  PIVector_1__IPackage = ^IVector_1__IPackage;


  // Emit Forwarded interfaces
  // Windows.ApplicationModel Interfaces
  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceDeferral
  [WinRTClassNameAttribute(SAppService_AppServiceDeferral)]
  AppService_IAppServiceDeferral = interface(IInspectable)
  ['{7E1B5322-EAB0-4248-AE04-FDF93838E472}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceClosedEventArgs
  [WinRTClassNameAttribute(SAppService_AppServiceClosedEventArgs)]
  AppService_IAppServiceClosedEventArgs = interface(IInspectable)
  ['{DE6016F6-CB03-4D35-AC8D-CC6303239731}']
    function get_Status: AppService_AppServiceClosedStatus; safecall;
    property Status: AppService_AppServiceClosedStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus_Delegate_Base = interface(IUnknown)
  ['{B824383D-32E0-5579-8670-A06A61457F20}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus = interface(AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__AppService_AppServiceResponseStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  IAsyncOperation_1__AppService_AppServiceResponseStatus_Base = interface(IInspectable)
  ['{98FDB842-5A0B-539A-A35C-55AC5F228612}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceResponseStatus>
  IAsyncOperation_1__AppService_AppServiceResponseStatus = interface(IAsyncOperation_1__AppService_AppServiceResponseStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus; safecall;
    function GetResults: AppService_AppServiceResponseStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__AppService_AppServiceResponseStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceRequest
  [WinRTClassNameAttribute(SAppService_AppServiceRequest)]
  AppService_IAppServiceRequest = interface(IInspectable)
  ['{20E58D9D-18DE-4B01-80BA-90A76204E3C8}']
    function get_Message: IPropertySet; safecall;
    function SendResponseAsync(message: IPropertySet): IAsyncOperation_1__AppService_AppServiceResponseStatus; safecall;
    property Message: IPropertySet read get_Message;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceRequestReceivedEventArgs
  [WinRTClassNameAttribute(SAppService_AppServiceRequestReceivedEventArgs)]
  AppService_IAppServiceRequestReceivedEventArgs = interface(IInspectable)
  ['{6E122360-FF65-44AE-9E45-857FE4180681}']
    function get_Request: AppService_IAppServiceRequest; safecall;
    function GetDeferral: AppService_IAppServiceDeferral; safecall;
    property Request: AppService_IAppServiceRequest read get_Request;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus_Delegate_Base = interface(IUnknown)
  ['{B6C6BBF2-72CA-5799-A651-D1990670097B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus = interface(AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__AppService_AppServiceConnectionStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  IAsyncOperation_1__AppService_AppServiceConnectionStatus_Base = interface(IInspectable)
  ['{0D0E6663-2639-5A9A-9CBC-30D7D4CE533B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.AppServiceConnectionStatus>
  IAsyncOperation_1__AppService_AppServiceConnectionStatus = interface(IAsyncOperation_1__AppService_AppServiceConnectionStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus; safecall;
    function GetResults: AppService_AppServiceConnectionStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__AppService_AppServiceConnectionStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceResponse
  [WinRTClassNameAttribute(SAppService_AppServiceResponse)]
  AppService_IAppServiceResponse = interface(IInspectable)
  ['{8D503CEC-9AA3-4E68-9559-9DE63E372CE4}']
    function get_Message: IPropertySet; safecall;
    function get_Status: AppService_AppServiceResponseStatus; safecall;
    property Message: IPropertySet read get_Message;
    property Status: AppService_AppServiceResponseStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse_Delegate_Base = interface(IUnknown)
  ['{7EA7D7EC-E164-52C3-8E32-BBA7126D9028}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse = interface(AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse_Delegate_Base)
  ['{5A4BFBFF-4CE1-5E2F-B758-8FADCC08AA8C}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__AppService_IAppServiceResponse; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  IAsyncOperation_1__AppService_IAppServiceResponse_Base = interface(IInspectable)
  ['{48755A7C-C88F-5EF0-9B4C-876FCC2610B4}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.AppService.IAppServiceResponse>
  IAsyncOperation_1__AppService_IAppServiceResponse = interface(IAsyncOperation_1__AppService_IAppServiceResponse_Base)
  ['{D75C9CFD-0669-5A8E-AE3C-6DAEF08F6377}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse; safecall;
    function GetResults: AppService_IAppServiceResponse; safecall;
    property Completed: AsyncOperationCompletedHandler_1__AppService_IAppServiceResponse read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceRequestReceivedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{18C67D61-4176-5553-B18D-D8F57FE79552}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceRequestReceivedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs = interface(TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs_Delegate_Base)
  ['{6AE5027F-820F-553A-9187-32660AA33A35}']
    procedure Invoke(sender: AppService_IAppServiceConnection; args: AppService_IAppServiceRequestReceivedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceClosedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs_Delegate_Base = interface(IUnknown)
  ['{E4EFA98D-4BFC-5E61-A233-688F5F06521F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.AppService.IAppServiceConnection,Windows.ApplicationModel.AppService.IAppServiceClosedEventArgs>
  TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs = interface(TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs_Delegate_Base)
  ['{71776122-4988-5F38-8637-D8876D35AD61}']
    procedure Invoke(sender: AppService_IAppServiceConnection; args: AppService_IAppServiceClosedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceConnection
  [WinRTClassNameAttribute(SAppService_AppServiceConnection)]
  AppService_IAppServiceConnection = interface(IInspectable)
  ['{9DD474A2-871F-4D52-89A9-9E090531BD27}']
    function get_AppServiceName: HSTRING; safecall;
    procedure put_AppServiceName(value: HSTRING); safecall;
    function get_PackageFamilyName: HSTRING; safecall;
    procedure put_PackageFamilyName(value: HSTRING); safecall;
    function OpenAsync: IAsyncOperation_1__AppService_AppServiceConnectionStatus; safecall;
    function SendMessageAsync(message: IPropertySet): IAsyncOperation_1__AppService_IAppServiceResponse; safecall;
    function add_RequestReceived(handler: TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceRequestReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_RequestReceived(token: EventRegistrationToken); safecall;
    function add_ServiceClosed(handler: TypedEventHandler_2__AppService_IAppServiceConnection__AppService_IAppServiceClosedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ServiceClosed(token: EventRegistrationToken); safecall;
    property AppServiceName: HSTRING read get_AppServiceName write put_AppServiceName;
    property PackageFamilyName: HSTRING read get_PackageFamilyName write put_PackageFamilyName;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.AppService.IAppServiceTriggerDetails
  [WinRTClassNameAttribute(SAppService_AppServiceTriggerDetails)]
  AppService_IAppServiceTriggerDetails = interface(IInspectable)
  ['{88A2DCAC-AD28-41B8-80BB-BDF1B2169E19}']
    function get_Name: HSTRING; safecall;
    function get_CallerPackageFamilyName: HSTRING; safecall;
    function get_AppServiceConnection: AppService_IAppServiceConnection; safecall;
    property AppServiceConnection: AppService_IAppServiceConnection read get_AppServiceConnection;
    property CallerPackageFamilyName: HSTRING read get_CallerPackageFamilyName;
    property Name: HSTRING read get_Name;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IAppDisplayInfo
  [WinRTClassNameAttribute(SAppDisplayInfo)]
  IAppDisplayInfo = interface(IInspectable)
  ['{1AEB1103-E4D4-41AA-A4F6-C4A276E79EAC}']
    function get_DisplayName: HSTRING; safecall;
    function get_Description: HSTRING; safecall;
    function GetLogo(size: TSizeF): IRandomAccessStreamReference; safecall;
    property Description: HSTRING read get_Description;
    property DisplayName: HSTRING read get_DisplayName;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IAppInfo
  [WinRTClassNameAttribute(SAppInfo)]
  IAppInfo = interface(IInspectable)
  ['{CF7F59B3-6A09-4DE8-A6C0-5792D56880D1}']
    function get_Id: HSTRING; safecall;
    function get_AppUserModelId: HSTRING; safecall;
    function get_DisplayInfo: IAppDisplayInfo; safecall;
    function get_PackageFamilyName: HSTRING; safecall;
    property AppUserModelId: HSTRING read get_AppUserModelId;
    property DisplayInfo: IAppDisplayInfo read get_DisplayInfo;
    property Id: HSTRING read get_Id;
    property PackageFamilyName: HSTRING read get_PackageFamilyName;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.IAppInfo>
  IIterator_1__IAppInfo = interface(IInspectable)
  ['{9CA3E755-877F-5FA6-9C68-CEB20FF87804}']
    function get_Current: IAppInfo; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIAppInfo): Cardinal; safecall;
    property Current: IAppInfo read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.IAppInfo>
  IIterable_1__IAppInfo = interface(IInspectable)
  ['{F5021AB5-F6AC-59C9-9632-6E82797B6196}']
    function First: IIterator_1__IAppInfo; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>
  IVectorView_1__IAppInfo = interface(IInspectable)
  ['{A7320DC1-90CE-5568-98B9-707AC47E5C33}']
    function GetAt(index: Cardinal): IAppInfo; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IAppInfo; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIAppInfo): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo = interface(IUnknown)
  ['{3FA954FE-6B27-52B7-A97F-E691E1BC3B53}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IAppInfo; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IAppInfo>>
  IAsyncOperation_1__IVectorView_1__IAppInfo = interface(IInspectable)
  ['{74E17AC2-5438-594C-9B2B-4D85BB307A73}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo; safecall;
    function GetResults: IVectorView_1__IAppInfo; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IAppInfo read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>
  IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface(IInspectable)
  ['{3E882181-FFAB-529C-B56F-3704D4E76A37}']
    function get_Key: HSTRING; safecall;
    function get_Value: Chat_ChatMessageStatus; safecall;
    property Key: HSTRING read get_Key;
    property Value: Chat_ChatMessageStatus read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>>
  IIterator_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface(IInspectable)
  ['{223DA751-0A6C-55A6-A771-0400E1D0C302}']
    function get_Current: IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__Chat_ChatMessageStatus): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>>
  IIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus_Base = interface(IInspectable)
  ['{57D87C13-48E9-546F-9B4E-A3906E1E7C24}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>>
  IIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus = interface(IIterable_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus_Base)
  ['{AEA35BCF-2498-50FE-9FB2-6CEF59B30B2E}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__Chat_ChatMessageStatus; safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IMapView`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>
  IMapView_2__HSTRING__Chat_ChatMessageStatus_Base = interface(IInspectable)
  ['{6A44FF0F-A172-5285-9BA5-B9FDD699A0FE}']
  end;
  // Windows.Foundation.Collections.IMapView`2<String,Windows.ApplicationModel.Chat.ChatMessageStatus>
  IMapView_2__HSTRING__Chat_ChatMessageStatus = interface(IMapView_2__HSTRING__Chat_ChatMessageStatus_Base)
  ['{8A182EDF-78BB-553A-B6B7-9112F3CC65BF}']
    function Lookup(key: HSTRING): Chat_ChatMessageStatus; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__Chat_ChatMessageStatus; out second: IMapView_2__HSTRING__Chat_ChatMessageStatus); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.ApplicationModel.Chat.IChatItem
  Chat_IChatItem = interface(IInspectable)
  ['{8751D000-CEB1-4243-B803-15D45A1DD428}']
    function get_ItemKind: Chat_ChatItemKind; safecall;
    property ItemKind: Chat_ChatItemKind read get_ItemKind;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Chat.IChatItem>
  IIterator_1__Chat_IChatItem = interface(IInspectable)
  ['{5D2C1B3F-9BC7-5126-93CD-F52326494DE1}']
    function get_Current: Chat_IChatItem; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PChat_IChatItem): Cardinal; safecall;
    property Current: Chat_IChatItem read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Chat.IChatItem>
  IIterable_1__Chat_IChatItem = interface(IInspectable)
  ['{EA8E3309-099A-592E-9E28-441B151FE061}']
    function First: IIterator_1__Chat_IChatItem; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>
  IVectorView_1__Chat_IChatItem = interface(IInspectable)
  ['{4E46B3DB-F003-5BFC-9EEB-F702F0801949}']
    function GetAt(index: Cardinal): Chat_IChatItem; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Chat_IChatItem; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PChat_IChatItem): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem = interface(IUnknown)
  ['{53DAAD1E-44E7-5A96-8688-2DB7C00D8143}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Chat_IChatItem; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Chat.IChatItem>>
  IAsyncOperation_1__IVectorView_1__Chat_IChatItem = interface(IInspectable)
  ['{65B3EEA1-7B6F-51A0-A2EB-7FB1DC473022}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem; safecall;
    function GetResults: IVectorView_1__Chat_IChatItem; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Chat_IChatItem read get_Completed write put_Completed;
  end;

  // Windows.Foundation.IReference`1<Windows.ApplicationModel.Email.EmailMailboxSmimeEncryptionAlgorithm>
  IReference_1__Email_EmailMailboxSmimeEncryptionAlgorithm = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Email_EmailMailboxSmimeEncryptionAlgorithm; safecall;
    property Value: Email_EmailMailboxSmimeEncryptionAlgorithm read get_Value;
  end;

  // Windows.Foundation.IReference`1<Windows.ApplicationModel.Email.EmailMailboxSmimeSigningAlgorithm>
  IReference_1__Email_EmailMailboxSmimeSigningAlgorithm = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Email_EmailMailboxSmimeSigningAlgorithm; safecall;
    property Value: Email_EmailMailboxSmimeSigningAlgorithm read get_Value;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.Activation.ISplashScreen,Object>
  TypedEventHandler_2__Activation_ISplashScreen__IInspectable_Delegate_Base = interface(IUnknown)
  ['{7725B2A5-287D-5ED2-A789-2A6A2673C7FE}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.Activation.ISplashScreen,Object>
  TypedEventHandler_2__Activation_ISplashScreen__IInspectable = interface(TypedEventHandler_2__Activation_ISplashScreen__IInspectable_Delegate_Base)
  ['{359B8887-2FA6-5405-A4AF-642C9FDACC93}']
    procedure Invoke(sender: Activation_ISplashScreen; args: IInspectable); safecall;
  end;

  // Windows.ApplicationModel.Activation.ISplashScreen
  Activation_ISplashScreen = interface(IInspectable)
  ['{CA4D975C-D4D6-43F0-97C0-0833C6391C24}']
    function get_ImageLocation: TRectF; safecall;
    function add_Dismissed(handler: TypedEventHandler_2__Activation_ISplashScreen__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Dismissed(cookie: EventRegistrationToken); safecall;
    property ImageLocation: TRectF read get_ImageLocation;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.Activation.IActivatedEventArgs
  Activation_IActivatedEventArgs = interface(IInspectable)
  ['{CF651713-CD08-4FD8-B697-A281B6544E2E}']
    function get_Kind: Activation_ActivationKind; safecall;
    function get_PreviousExecutionState: Activation_ApplicationExecutionState; safecall;
    function get_SplashScreen: Activation_ISplashScreen; safecall;
    property Kind: Activation_ActivationKind read get_Kind;
    property PreviousExecutionState: Activation_ApplicationExecutionState read get_PreviousExecutionState;
    property SplashScreen: Activation_ISplashScreen read get_SplashScreen;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.Activation.ILockScreenActivatedEventArgs
  [WinRTClassNameAttribute(SActivation_LockScreenActivatedEventArgs)]
  Activation_ILockScreenActivatedEventArgs = interface(IInspectable)
  ['{3CA77966-6108-4A41-8220-EE7D133C8532}']
    function get_Info: IInspectable; safecall;
    property Info: IInspectable read get_Info;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockScreenBadge
  [WinRTClassNameAttribute(SLockScreen_LockScreenBadge)]
  LockScreen_ILockScreenBadge = interface(IInspectable)
  ['{E95105D9-2BFF-4DB0-9B4F-3824778B9C9A}']
    function get_Logo: IRandomAccessStream; safecall;
    function get_Glyph: IRandomAccessStream; safecall;
    function get_Number: IReference_1__Cardinal; safecall;
    function get_AutomationName: HSTRING; safecall;
    procedure LaunchApp; safecall;
    property AutomationName: HSTRING read get_AutomationName;
    property Glyph: IRandomAccessStream read get_Glyph;
    property Logo: IRandomAccessStream read get_Logo;
    property Number: IReference_1__Cardinal read get_Number;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockScreenInfo,Object>
  TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable_Delegate_Base = interface(IUnknown)
  ['{8BE9E6A3-F88A-5429-8DA3-676B7D4F1A5B}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockScreenInfo,Object>
  TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable = interface(TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable_Delegate_Base)
  ['{A7F4A3EF-0F52-51A1-B9B9-05A40776EA01}']
    procedure Invoke(sender: LockScreen_ILockScreenInfo; args: IInspectable); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IIterator_1__LockScreen_ILockScreenBadge = interface(IInspectable)
  ['{088B8AF0-7137-5D3F-ACD7-2294E05A4237}']
    function get_Current: LockScreen_ILockScreenBadge; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PLockScreen_ILockScreenBadge): Cardinal; safecall;
    property Current: LockScreen_ILockScreenBadge read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IIterable_1__LockScreen_ILockScreenBadge_Base = interface(IInspectable)
  ['{6E82DEDC-B74E-503A-B00B-9C6F47F12A0F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IIterable_1__LockScreen_ILockScreenBadge = interface(IIterable_1__LockScreen_ILockScreenBadge_Base)
  ['{3BDF34B0-B187-5268-990D-9D6BF3AE507A}']
    function First: IIterator_1__LockScreen_ILockScreenBadge; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.LockScreen.ILockScreenBadge>
  IVectorView_1__LockScreen_ILockScreenBadge = interface(IInspectable)
  ['{AEFD5B55-DB8D-5E08-93F9-8AD48C511F09}']
    function GetAt(index: Cardinal): LockScreen_ILockScreenBadge; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: LockScreen_ILockScreenBadge; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PLockScreen_ILockScreenBadge): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockScreenInfo
  [WinRTClassNameAttribute(SLockScreen_LockScreenInfo)]
  LockScreen_ILockScreenInfo = interface(IInspectable)
  ['{F59AA65C-9711-4DC9-A630-95B6CB8CDAD0}']
    function add_LockScreenImageChanged(handler: TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable): EventRegistrationToken; safecall;
    procedure remove_LockScreenImageChanged(token: EventRegistrationToken); safecall;
    function get_LockScreenImage: IRandomAccessStream; safecall;
    function add_BadgesChanged(handler: TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable): EventRegistrationToken; safecall;
    procedure remove_BadgesChanged(token: EventRegistrationToken); safecall;
    function get_Badges: IVectorView_1__LockScreen_ILockScreenBadge; safecall;
    function add_DetailTextChanged(handler: TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable): EventRegistrationToken; safecall;
    procedure remove_DetailTextChanged(token: EventRegistrationToken); safecall;
    function get_DetailText: IVectorView_1__HSTRING; safecall;
    function add_AlarmIconChanged(handler: TypedEventHandler_2__LockScreen_ILockScreenInfo__IInspectable): EventRegistrationToken; safecall;
    procedure remove_AlarmIconChanged(token: EventRegistrationToken); safecall;
    function get_AlarmIcon: IRandomAccessStream; safecall;
    property AlarmIcon: IRandomAccessStream read get_AlarmIcon;
    property Badges: IVectorView_1__LockScreen_ILockScreenBadge read get_Badges;
    property DetailText: IVectorView_1__HSTRING read get_DetailText;
    property LockScreenImage: IRandomAccessStream read get_LockScreenImage;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockScreenUnlockingDeferral
  [WinRTClassNameAttribute(SLockScreen_LockScreenUnlockingDeferral)]
  LockScreen_ILockScreenUnlockingDeferral = interface(IInspectable)
  ['{7E7D1AD6-5203-43E7-9BD6-7C3947D1E3FE}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockScreenUnlockingEventArgs
  [WinRTClassNameAttribute(SLockScreen_LockScreenUnlockingEventArgs)]
  LockScreen_ILockScreenUnlockingEventArgs = interface(IInspectable)
  ['{44E6C007-75FB-4ABB-9F8B-824748900C71}']
    function GetDeferral: LockScreen_ILockScreenUnlockingDeferral; safecall;
    function get_Deadline: DateTime; safecall;
    property Deadline: DateTime read get_Deadline;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockApplicationHost,Windows.ApplicationModel.LockScreen.ILockScreenUnlockingEventArgs>
  TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs_Delegate_Base = interface(IUnknown)
  ['{002E5776-8A5B-5B93-8C6C-9C4C8788F5B4}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.ApplicationModel.LockScreen.ILockApplicationHost,Windows.ApplicationModel.LockScreen.ILockScreenUnlockingEventArgs>
  TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs = interface(TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs_Delegate_Base)
  ['{08F45A4A-0029-5309-A6E5-B4554E404F8F}']
    procedure Invoke(sender: LockScreen_ILockApplicationHost; args: LockScreen_ILockScreenUnlockingEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockApplicationHost
  [WinRTClassNameAttribute(SLockScreen_LockApplicationHost)]
  LockScreen_ILockApplicationHost = interface(IInspectable)
  ['{38EE31AD-D94F-4E7C-81FA-4F4436506281}']
    procedure RequestUnlock; safecall;
    function add_Unlocking(handler: TypedEventHandler_2__LockScreen_ILockApplicationHost__LockScreen_ILockScreenUnlockingEventArgs): EventRegistrationToken; safecall;
    procedure remove_Unlocking(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.LockScreen.ILockApplicationHostStatics
  [WinRTClassNameAttribute(SLockScreen_LockApplicationHost)]
  LockScreen_ILockApplicationHostStatics = interface(IInspectable)
  ['{F48FAB8E-23D7-4E63-96A1-666FF52D3B2C}']
    function GetForCurrentView: LockScreen_ILockApplicationHost; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IIterator_1__Store_Preview_StoreSystemFeature = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: Store_Preview_StoreSystemFeature; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PStore_Preview_StoreSystemFeature): Cardinal; safecall;
    property Current: Store_Preview_StoreSystemFeature read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IIterable_1__Store_Preview_StoreSystemFeature = interface(IInspectable)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__Store_Preview_StoreSystemFeature; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>
  IVectorView_1__Store_Preview_StoreSystemFeature = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): Store_Preview_StoreSystemFeature; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Store_Preview_StoreSystemFeature; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PStore_Preview_StoreSystemFeature): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature = interface(IUnknown)
  ['{5A9F94D2-879A-565B-91C7-6CD2248BA109}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Store_Preview_StoreSystemFeature; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Store.Preview.StoreSystemFeature>>
  IAsyncOperation_1__IVectorView_1__Store_Preview_StoreSystemFeature = interface(IInspectable)
  ['{DF78340B-B47F-50E2-9EC5-530CB35D7BE7}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature; safecall;
    function GetResults: IVectorView_1__Store_Preview_StoreSystemFeature; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Store_Preview_StoreSystemFeature read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.Store.LicenseChangedEventHandler
  Store_LicenseChangedEventHandler = interface(IUnknown)
  ['{D4A50255-1369-4C36-832F-6F2D88E3659B}']
    procedure Invoke; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Store.FulfillmentResult>
  AsyncOperationCompletedHandler_1__Store_FulfillmentResult_Delegate_Base = interface(IUnknown)
  ['{8775ACC9-B9AE-5CCE-895C-971BF9270892}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.Store.FulfillmentResult>
  AsyncOperationCompletedHandler_1__Store_FulfillmentResult = interface(AsyncOperationCompletedHandler_1__Store_FulfillmentResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Store_FulfillmentResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Store.FulfillmentResult>
  IAsyncOperation_1__Store_FulfillmentResult_Base = interface(IInspectable)
  ['{5C8531AC-5D8D-5E07-B6EE-7CAB96930E8A}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.Store.FulfillmentResult>
  IAsyncOperation_1__Store_FulfillmentResult = interface(IAsyncOperation_1__Store_FulfillmentResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Store_FulfillmentResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Store_FulfillmentResult; safecall;
    function GetResults: Store_FulfillmentResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Store_FulfillmentResult read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.Store.IProductListingWithConsumables
  Store_IProductListingWithConsumables = interface(IInspectable)
  ['{EB9E9790-8F6B-481F-93A7-5C3A63068149}']
    function get_ProductType: Store_ProductType; safecall;
    property ProductType: Store_ProductType read get_ProductType;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackageIdWithMetadata
  IPackageIdWithMetadata = interface(IInspectable)
  ['{40577A7C-0C9E-443D-9074-855F5CE0A08D}']
    function get_ProductId: HSTRING; safecall;
    function get_Author: HSTRING; safecall;
    property Author: HSTRING read get_Author;
    property ProductId: HSTRING read get_ProductId;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackageWithMetadata
  IPackageWithMetadata = interface(IInspectable)
  ['{95949780-1DE9-40F2-B452-0DE9F1910012}']
    function get_InstallDate: DateTime; safecall;
    function GetThumbnailToken: HSTRING; safecall;
    procedure Launch(parameters: HSTRING); safecall;
    property InstallDate: DateTime read get_InstallDate;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackageStatus
  [WinRTClassNameAttribute(SPackageStatus)]
  IPackageStatus = interface(IInspectable)
  ['{5FE74F71-A365-4C09-A02D-046D525EA1DA}']
    function VerifyIsOK: Boolean; safecall;
    function get_NotAvailable: Boolean; safecall;
    function get_PackageOffline: Boolean; safecall;
    function get_DataOffline: Boolean; safecall;
    function get_Disabled: Boolean; safecall;
    function get_NeedsRemediation: Boolean; safecall;
    function get_LicenseIssue: Boolean; safecall;
    function get_Modified: Boolean; safecall;
    function get_Tampered: Boolean; safecall;
    function get_DependencyIssue: Boolean; safecall;
    function get_Servicing: Boolean; safecall;
    function get_DeploymentInProgress: Boolean; safecall;
    property DataOffline: Boolean read get_DataOffline;
    property DependencyIssue: Boolean read get_DependencyIssue;
    property DeploymentInProgress: Boolean read get_DeploymentInProgress;
    property Disabled: Boolean read get_Disabled;
    property LicenseIssue: Boolean read get_LicenseIssue;
    property Modified: Boolean read get_Modified;
    property NeedsRemediation: Boolean read get_NeedsRemediation;
    property NotAvailable: Boolean read get_NotAvailable;
    property PackageOffline: Boolean read get_PackageOffline;
    property Servicing: Boolean read get_Servicing;
    property Tampered: Boolean read get_Tampered;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackageId
  [WinRTClassNameAttribute(SPackageId)]
  IPackageId = interface(IInspectable)
  ['{1ADB665E-37C7-4790-9980-DD7AE74E8BB2}']
    function get_Name: HSTRING; safecall;
    function get_Version: PackageVersion; safecall;
    function get_Architecture: ProcessorArchitecture; safecall;
    function get_ResourceId: HSTRING; safecall;
    function get_Publisher: HSTRING; safecall;
    function get_PublisherId: HSTRING; safecall;
    function get_FullName: HSTRING; safecall;
    function get_FamilyName: HSTRING; safecall;
    property Architecture: ProcessorArchitecture read get_Architecture;
    property FamilyName: HSTRING read get_FamilyName;
    property FullName: HSTRING read get_FullName;
    property Name: HSTRING read get_Name;
    property Publisher: HSTRING read get_Publisher;
    property PublisherId: HSTRING read get_PublisherId;
    property ResourceId: HSTRING read get_ResourceId;
    property Version: PackageVersion read get_Version;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.IPackage>
  IIterator_1__IPackage = interface(IInspectable)
  ['{33045CC3-8892-5AAA-AB26-83F5614F6792}']
    function get_Current: IPackage; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIPackage): Cardinal; safecall;
    property Current: IPackage read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.IPackage>
  IIterable_1__IPackage_Base = interface(IInspectable)
  ['{69AD6AA7-0C49-5F27-A5EB-EF4D59467B6D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.IPackage>
  IIterable_1__IPackage = interface(IIterable_1__IPackage_Base)
  ['{9ECA5389-C150-5A23-98C4-E5A26309B5B3}']
    function First: IIterator_1__IPackage; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.IPackage>
  IVectorView_1__IPackage = interface(IInspectable)
  ['{77191FA5-6652-5BC7-82EB-CDDF0E2F7ECD}']
    function GetAt(index: Cardinal): IPackage; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IPackage; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPackage): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackage
  [WinRTClassNameAttribute(SPackageRT)]
  IPackage = interface(IInspectable)
  ['{163C792F-BD75-413C-BF23-B1FE7B95D825}']
    function get_Id: IPackageId; safecall;
    function get_InstalledLocation: IStorageFolder; safecall;
    function get_IsFramework: Boolean; safecall;
    function get_Dependencies: IVectorView_1__IPackage; safecall;
    property Dependencies: IVectorView_1__IPackage read get_Dependencies;
    property Id: IPackageId read get_Id;
    property InstalledLocation: IStorageFolder read get_InstalledLocation;
    property IsFramework: Boolean read get_IsFramework;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackage2
  IPackage2 = interface(IInspectable)
  ['{A6612FB6-7688-4ACE-95FB-359538E7AA01}']
    function get_DisplayName: HSTRING; safecall;
    function get_PublisherDisplayName: HSTRING; safecall;
    function get_Description: HSTRING; safecall;
    function get_Logo: IUriRuntimeClass; safecall;
    function get_IsResourcePackage: Boolean; safecall;
    function get_IsBundle: Boolean; safecall;
    function get_IsDevelopmentMode: Boolean; safecall;
    property Description: HSTRING read get_Description;
    property DisplayName: HSTRING read get_DisplayName;
    property IsBundle: Boolean read get_IsBundle;
    property IsDevelopmentMode: Boolean read get_IsDevelopmentMode;
    property IsResourcePackage: Boolean read get_IsResourcePackage;
    property Logo: IUriRuntimeClass read get_Logo;
    property PublisherDisplayName: HSTRING read get_PublisherDisplayName;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackage3
  IPackage3 = interface(IInspectable)
  ['{5F738B61-F86A-4917-93D1-F1EE9D3B35D9}']
    function get_Status: IPackageStatus; safecall;
    function get_InstalledDate: DateTime; safecall;
    function GetAppListEntriesAsync: IInspectable{IAsyncOperation_1__IVectorView_1__IAppListEntry}; safecall;
    property InstalledDate: DateTime read get_InstalledDate;
    property Status: IPackageStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.ApplicationModel.IPackageStatics
  [WinRTClassNameAttribute(SPackageRT)]
  IPackageStatics = interface(IInspectable)
  ['{4E534BDF-2960-4878-97A4-9624DEB72F2D}']
    function get_Current: IPackage; safecall;
    property Current: IPackage read get_Current;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult_Delegate_Base = interface(IUnknown)
  ['{873C5C7A-C638-5A33-9B03-215C72471663}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult = interface(AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult_Base = interface(IInspectable)
  ['{1DBB1BC9-6CD7-5947-8CD1-29632B5AA950}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult>
  IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult = interface(IAsyncOperation_1__ExtendedExecution_ExtendedExecutionResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult; safecall;
    function GetResults: ExtendedExecution_ExtendedExecutionResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ExtendedExecution_ExtendedExecutionResult read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundResult>
  AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = interface(IUnknown)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundResult>
  IAsyncOperation_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = interface(IInspectable)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult; safecall;
    function GetResults: ExtendedExecution_Foreground_ExtendedExecutionForegroundResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ExtendedExecution_Foreground_ExtendedExecutionForegroundResult read get_Completed write put_Completed;
  end;

  // Windows.ApplicationModel.Activation.IContactsProviderActivatedEventArgs
  Activation_IContactsProviderActivatedEventArgs = interface(IInspectable)
  ['{4580DCA8-5750-4916-AA52-C0829521EB94}']
    function get_Verb: HSTRING; safecall;
    property Verb: HSTRING read get_Verb;
  end;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.ApplicationModel.Search.Core.ISearchSuggestion>
  VectorChangedEventHandler_1__Search_Core_ISearchSuggestion = interface(IUnknown)
  ['{3528538E-1115-54FD-8943-A340AE8FEAB1}']
    procedure Invoke(sender: IObservableVector_1__Search_Core_ISearchSuggestion; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.ApplicationModel.Search.Core.ISearchSuggestion>
  IObservableVector_1__Search_Core_ISearchSuggestion = interface(IInspectable)
  ['{944A3DA2-8D2E-5EAE-8E5A-99D6B12F6043}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Search_Core_ISearchSuggestion): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.ApplicationModel.IPackage>
  IVector_1__IPackage = interface(IInspectable)
  ['{7704985F-8D81-5C7F-9B57-870C324DA741}']
    function GetAt(index: Cardinal): IPackage; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IPackage; safecall;
    function IndexOf(value: IPackage; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IPackage); safecall;
    procedure InsertAt(index: Cardinal; value: IPackage); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IPackage); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPackage): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIPackage); safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.ApplicationModel.AppService.AppServiceRequest
  // DualAPI

  // Windows.ApplicationModel.AppService.AppServiceDeferral
  // DualAPI

  // Windows.ApplicationModel.AppService.AppServiceResponse
  // DualAPI

  // Windows.ApplicationModel.AppService.AppServiceConnection
  // DualAPI
  TAppService_AppServiceConnection = class(TWinRTGenericImportI<AppService_IAppServiceConnection>) end;

  // Windows.ApplicationModel.AppService.AppServiceRequestReceivedEventArgs
  // DualAPI

  // Windows.ApplicationModel.AppService.AppServiceClosedEventArgs
  // DualAPI

  // Windows.ApplicationModel.AppService.AppServiceTriggerDetails
  // DualAPI

  // Windows.ApplicationModel.Activation.LockScreenActivatedEventArgs
  // DualAPI

  // Windows.ApplicationModel.AppDisplayInfo
  // DualAPI

  // Windows.ApplicationModel.AppInfo
  // DualAPI

  // Windows.ApplicationModel.LockScreen.LockScreenInfo
  // DualAPI

  // Windows.ApplicationModel.LockScreen.LockScreenBadge
  // DualAPI

  // Windows.ApplicationModel.LockScreen.LockScreenUnlockingDeferral
  // DualAPI

  // Windows.ApplicationModel.LockScreen.LockApplicationHost
  // DualAPI
  TLockScreen_LockApplicationHost = class(TWinRTGenericImportS<LockScreen_ILockApplicationHostStatics>)
  public
    // -> LockScreen_ILockApplicationHostStatics
    class function GetForCurrentView: LockScreen_ILockApplicationHost; static; inline;
  end;

  // Windows.ApplicationModel.LockScreen.LockScreenUnlockingEventArgs
  // DualAPI

  // Windows.ApplicationModel.PackageStatus
  // DualAPI

  // Windows.ApplicationModel.PackageId
  // DualAPI

  // Windows.ApplicationModel.Package
  // DualAPI
  TPackageRT = class(TWinRTGenericImportS<IPackageStatics>)
  public
    // -> IPackageStatics
    class function get_Current: IPackage; static; inline;
    class property Current: IPackage read get_Current;
  end;


implementation

  // Emit Classes Implementation
 { TAppService_AppServiceConnection }

 { TLockScreen_LockApplicationHost }

class function TLockScreen_LockApplicationHost.GetForCurrentView: LockScreen_ILockApplicationHost;
begin
  Result := Statics.GetForCurrentView;
end;


 { TPackageRT }

class function TPackageRT.get_Current: IPackage;
begin
  Result := Statics.get_Current;
end;



end.
