{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Networking.NetworkOperators;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Networking,
  Winapi.Networking.Connectivity,
  Winapi.Devices,
  Winapi.Devices.Sms,
  Winapi.DataRT,
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.Storage.Streams,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Networking.NetworkOperators Class Names
  // Windows.Networking.NetworkOperators.MobileBroadbandAccount
  // DualAPI
  SMobileBroadbandAccount = 'Windows.Networking.NetworkOperators.MobileBroadbandAccount';
  // Windows.Networking.NetworkOperators.MobileBroadbandNetwork
  // DualAPI
  SMobileBroadbandNetwork = 'Windows.Networking.NetworkOperators.MobileBroadbandNetwork';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceInformation
  // DualAPI
  SMobileBroadbandDeviceInformation = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceInformation';
  // Windows.Networking.NetworkOperators.MobileBroadbandPinManager
  // DualAPI
  SMobileBroadbandPinManager = 'Windows.Networking.NetworkOperators.MobileBroadbandPinManager';
  // Windows.Networking.NetworkOperators.MobileBroadbandUiccApp
  // DualAPI
  SMobileBroadbandUiccApp = 'Windows.Networking.NetworkOperators.MobileBroadbandUiccApp';
  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringAccessPointConfiguration
  // DualAPI
  SNetworkOperatorTetheringAccessPointConfiguration = 'Windows.Networking.NetworkOperators.NetworkOperatorTetheringAccessPointConfiguration';
  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult
  // DualAPI
  SNetworkOperatorTetheringOperationResult = 'Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult';
  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager
  // DualAPI
  SNetworkOperatorTetheringManager = 'Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager';
  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringClient
  // DualAPI
  SNetworkOperatorTetheringClient = 'Windows.Networking.NetworkOperators.NetworkOperatorTetheringClient';
  // Windows.Networking.NetworkOperators.MobileBroadbandAccountEventArgs
  // DualAPI
  SMobileBroadbandAccountEventArgs = 'Windows.Networking.NetworkOperators.MobileBroadbandAccountEventArgs';
  // Windows.Networking.NetworkOperators.MobileBroadbandAccountUpdatedEventArgs
  // DualAPI
  SMobileBroadbandAccountUpdatedEventArgs = 'Windows.Networking.NetworkOperators.MobileBroadbandAccountUpdatedEventArgs';
  // Windows.Networking.NetworkOperators.MobileBroadbandAccountWatcher
  // DualAPI
  SMobileBroadbandAccountWatcher = 'Windows.Networking.NetworkOperators.MobileBroadbandAccountWatcher';
  // Windows.Networking.NetworkOperators.MobileBroadbandModem
  // DualAPI
  SMobileBroadbandModem = 'Windows.Networking.NetworkOperators.MobileBroadbandModem';
  // Windows.Networking.NetworkOperators.MobileBroadbandUicc
  // DualAPI
  SMobileBroadbandUicc = 'Windows.Networking.NetworkOperators.MobileBroadbandUicc';
  // Windows.Networking.NetworkOperators.MobileBroadbandModemConfiguration
  // DualAPI
  SMobileBroadbandModemConfiguration = 'Windows.Networking.NetworkOperators.MobileBroadbandModemConfiguration';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceInformation
  // DualAPI
  SMobileBroadbandDeviceServiceInformation = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceInformation';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceService
  // DualAPI
  SMobileBroadbandDeviceService = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceService';
  // Windows.Networking.NetworkOperators.MobileBroadbandPin
  // DualAPI
  SMobileBroadbandPin = 'Windows.Networking.NetworkOperators.MobileBroadbandPin';
  // Windows.Networking.NetworkOperators.MobileBroadbandPinOperationResult
  // DualAPI
  SMobileBroadbandPinOperationResult = 'Windows.Networking.NetworkOperators.MobileBroadbandPinOperationResult';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceDataSession
  // DualAPI
  SMobileBroadbandDeviceServiceDataSession = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceDataSession';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandSession
  // DualAPI
  SMobileBroadbandDeviceServiceCommandSession = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandSession';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandResult
  // DualAPI
  SMobileBroadbandDeviceServiceCommandResult = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandResult';
  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppsResult
  // DualAPI
  SMobileBroadbandUiccAppsResult = 'Windows.Networking.NetworkOperators.MobileBroadbandUiccAppsResult';
  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppRecordDetailsResult
  // DualAPI
  SMobileBroadbandUiccAppRecordDetailsResult = 'Windows.Networking.NetworkOperators.MobileBroadbandUiccAppRecordDetailsResult';
  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppReadRecordResult
  // DualAPI
  SMobileBroadbandUiccAppReadRecordResult = 'Windows.Networking.NetworkOperators.MobileBroadbandUiccAppReadRecordResult';
  // Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChange
  // DualAPI
  SMobileBroadbandNetworkRegistrationStateChange = 'Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChange';
  // Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChangeTriggerDetails
  // DualAPI
  SMobileBroadbandNetworkRegistrationStateChangeTriggerDetails = 'Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChangeTriggerDetails';
  // Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChange
  // DualAPI
  SMobileBroadbandRadioStateChange = 'Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChange';
  // Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChangeTriggerDetails
  // DualAPI
  SMobileBroadbandRadioStateChangeTriggerDetails = 'Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChangeTriggerDetails';
  // Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChange
  // DualAPI
  SMobileBroadbandPinLockStateChange = 'Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChange';
  // Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChangeTriggerDetails
  // DualAPI
  SMobileBroadbandPinLockStateChangeTriggerDetails = 'Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChangeTriggerDetails';
  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceTriggerDetails
  // DualAPI
  SMobileBroadbandDeviceServiceTriggerDetails = 'Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceTriggerDetails';
  // Windows.Networking.NetworkOperators.KnownCSimFilePaths
  // DualAPI
  SKnownCSimFilePaths = 'Windows.Networking.NetworkOperators.KnownCSimFilePaths';
  // Windows.Networking.NetworkOperators.KnownRuimFilePaths
  // DualAPI
  SKnownRuimFilePaths = 'Windows.Networking.NetworkOperators.KnownRuimFilePaths';
  // Windows.Networking.NetworkOperators.KnownSimFilePaths
  // DualAPI
  SKnownSimFilePaths = 'Windows.Networking.NetworkOperators.KnownSimFilePaths';
  // Windows.Networking.NetworkOperators.KnownUSimFilePaths
  // DualAPI
  SKnownUSimFilePaths = 'Windows.Networking.NetworkOperators.KnownUSimFilePaths';
  // Windows.Networking.NetworkOperators.HotspotCredentialsAuthenticationResult
  // DualAPI
  SHotspotCredentialsAuthenticationResult = 'Windows.Networking.NetworkOperators.HotspotCredentialsAuthenticationResult';
  // Windows.Networking.NetworkOperators.ProvisionFromXmlDocumentResults
  // DualAPI
  SProvisionFromXmlDocumentResults = 'Windows.Networking.NetworkOperators.ProvisionFromXmlDocumentResults';
  // Windows.Networking.NetworkOperators.ProvisionedProfile
  // DualAPI
  SProvisionedProfile = 'Windows.Networking.NetworkOperators.ProvisionedProfile';
  // Windows.Networking.NetworkOperators.ProvisioningAgent
  // DualAPI
  SProvisioningAgent = 'Windows.Networking.NetworkOperators.ProvisioningAgent';
  // Windows.Networking.NetworkOperators.UssdMessage
  // DualAPI
  SUssdMessage = 'Windows.Networking.NetworkOperators.UssdMessage';
  // Windows.Networking.NetworkOperators.UssdReply
  // DualAPI
  SUssdReply = 'Windows.Networking.NetworkOperators.UssdReply';
  // Windows.Networking.NetworkOperators.UssdSession
  // DualAPI
  SUssdSession = 'Windows.Networking.NetworkOperators.UssdSession';
  // Windows.Networking.NetworkOperators.NetworkOperatorNotificationEventDetails
  // DualAPI
  SNetworkOperatorNotificationEventDetails = 'Windows.Networking.NetworkOperators.NetworkOperatorNotificationEventDetails';


type
  // Forward declare interfaces
  // Windows.Networking.NetworkOperators.IMobileBroadbandNetwork
  IMobileBroadbandNetwork = interface;
  PIMobileBroadbandNetwork = ^IMobileBroadbandNetwork;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceInformation
  IMobileBroadbandDeviceInformation = interface;
  PIMobileBroadbandDeviceInformation = ^IMobileBroadbandDeviceInformation;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccount
  IMobileBroadbandAccount = interface;
  PIMobileBroadbandAccount = ^IMobileBroadbandAccount;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountStatics
  IMobileBroadbandAccountStatics = interface;
  PIMobileBroadbandAccountStatics = ^IMobileBroadbandAccountStatics;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccount2
  IMobileBroadbandAccount2 = interface;
  PIMobileBroadbandAccount2 = ^IMobileBroadbandAccount2;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IIterator_1__MobileBroadbandPinType = interface;
  PIIterator_1__MobileBroadbandPinType = ^IIterator_1__MobileBroadbandPinType;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IIterable_1__MobileBroadbandPinType = interface;
  PIIterable_1__MobileBroadbandPinType = ^IIterable_1__MobileBroadbandPinType;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IVectorView_1__MobileBroadbandPinType = interface;
  PIVectorView_1__MobileBroadbandPinType = ^IVectorView_1__MobileBroadbandPinType;

  // Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult
  IMobileBroadbandPinOperationResult = interface;
  PIMobileBroadbandPinOperationResult = ^IMobileBroadbandPinOperationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult = ^AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  IAsyncOperation_1__IMobileBroadbandPinOperationResult = interface;
  PIAsyncOperation_1__IMobileBroadbandPinOperationResult = ^IAsyncOperation_1__IMobileBroadbandPinOperationResult;

  // Windows.Networking.NetworkOperators.IMobileBroadbandPin
  IMobileBroadbandPin = interface;
  PIMobileBroadbandPin = ^IMobileBroadbandPin;

  // Windows.Networking.NetworkOperators.IMobileBroadbandPinManager
  IMobileBroadbandPinManager = interface;
  PIMobileBroadbandPinManager = ^IMobileBroadbandPinManager;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceInformation2
  IMobileBroadbandDeviceInformation2 = interface;
  PIMobileBroadbandDeviceInformation2 = ^IMobileBroadbandDeviceInformation2;

  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult
  IMobileBroadbandUiccAppRecordDetailsResult = interface;
  PIMobileBroadbandUiccAppRecordDetailsResult = ^IMobileBroadbandUiccAppRecordDetailsResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult = ^AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult = interface;
  PIAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult = ^IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult;

  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult
  IMobileBroadbandUiccAppReadRecordResult = interface;
  PIMobileBroadbandUiccAppReadRecordResult = ^IMobileBroadbandUiccAppReadRecordResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult = ^AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult = interface;
  PIAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult = ^IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult;

  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp
  IMobileBroadbandUiccApp = interface;
  PIMobileBroadbandUiccApp = ^IMobileBroadbandUiccApp;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IIterator_1__IMobileBroadbandUiccApp = interface;
  PIIterator_1__IMobileBroadbandUiccApp = ^IIterator_1__IMobileBroadbandUiccApp;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IIterable_1__IMobileBroadbandUiccApp = interface;
  PIIterable_1__IMobileBroadbandUiccApp = ^IIterable_1__IMobileBroadbandUiccApp;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IVectorView_1__IMobileBroadbandUiccApp = interface;
  PIVectorView_1__IMobileBroadbandUiccApp = ^IVectorView_1__IMobileBroadbandUiccApp;

  // Windows.Networking.NetworkOperators.IMobileBroadbandNetwork2
  IMobileBroadbandNetwork2 = interface;
  PIMobileBroadbandNetwork2 = ^IMobileBroadbandNetwork2;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringAccessPointConfiguration
  INetworkOperatorTetheringAccessPointConfiguration = interface;
  PINetworkOperatorTetheringAccessPointConfiguration = ^INetworkOperatorTetheringAccessPointConfiguration;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult
  INetworkOperatorTetheringOperationResult = interface;
  PINetworkOperatorTetheringOperationResult = ^INetworkOperatorTetheringOperationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult = interface;
  PAsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult = ^AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  IAsyncOperation_1__INetworkOperatorTetheringOperationResult = interface;
  PIAsyncOperation_1__INetworkOperatorTetheringOperationResult = ^IAsyncOperation_1__INetworkOperatorTetheringOperationResult;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManager
  INetworkOperatorTetheringManager = interface;
  PINetworkOperatorTetheringManager = ^INetworkOperatorTetheringManager;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManagerStatics
  INetworkOperatorTetheringManagerStatics = interface;
  PINetworkOperatorTetheringManagerStatics = ^INetworkOperatorTetheringManagerStatics;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManagerStatics2
  INetworkOperatorTetheringManagerStatics2 = interface;
  PINetworkOperatorTetheringManagerStatics2 = ^INetworkOperatorTetheringManagerStatics2;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient
  INetworkOperatorTetheringClient = interface;
  PINetworkOperatorTetheringClient = ^INetworkOperatorTetheringClient;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IIterator_1__INetworkOperatorTetheringClient = interface;
  PIIterator_1__INetworkOperatorTetheringClient = ^IIterator_1__INetworkOperatorTetheringClient;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IIterable_1__INetworkOperatorTetheringClient = interface;
  PIIterable_1__INetworkOperatorTetheringClient = ^IIterable_1__INetworkOperatorTetheringClient;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IVectorView_1__INetworkOperatorTetheringClient = interface;
  PIVectorView_1__INetworkOperatorTetheringClient = ^IVectorView_1__INetworkOperatorTetheringClient;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringClientManager
  INetworkOperatorTetheringClientManager = interface;
  PINetworkOperatorTetheringClientManager = ^INetworkOperatorTetheringClientManager;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountEventArgs
  IMobileBroadbandAccountEventArgs = interface;
  PIMobileBroadbandAccountEventArgs = ^IMobileBroadbandAccountEventArgs;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountUpdatedEventArgs
  IMobileBroadbandAccountUpdatedEventArgs = interface;
  PIMobileBroadbandAccountUpdatedEventArgs = ^IMobileBroadbandAccountUpdatedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs = interface;
  PTypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs = ^TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountUpdatedEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs = interface;
  PTypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs = ^TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Object>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable = interface;
  PTypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable = ^TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable;

  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher
  IMobileBroadbandAccountWatcher = interface;
  PIMobileBroadbandAccountWatcher = ^IMobileBroadbandAccountWatcher;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation
  IMobileBroadbandDeviceServiceInformation = interface;
  PIMobileBroadbandDeviceServiceInformation = ^IMobileBroadbandDeviceServiceInformation;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IIterator_1__IMobileBroadbandDeviceServiceInformation = interface;
  PIIterator_1__IMobileBroadbandDeviceServiceInformation = ^IIterator_1__IMobileBroadbandDeviceServiceInformation;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IIterable_1__IMobileBroadbandDeviceServiceInformation = interface;
  PIIterable_1__IMobileBroadbandDeviceServiceInformation = ^IIterable_1__IMobileBroadbandDeviceServiceInformation;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IVectorView_1__IMobileBroadbandDeviceServiceInformation = interface;
  PIVectorView_1__IMobileBroadbandDeviceServiceInformation = ^IVectorView_1__IMobileBroadbandDeviceServiceInformation;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataReceivedEventArgs
  IMobileBroadbandDeviceServiceDataReceivedEventArgs = interface;
  PIMobileBroadbandDeviceServiceDataReceivedEventArgs = ^IMobileBroadbandDeviceServiceDataReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataSession,Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataReceivedEventArgs>
  TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs = interface;
  PTypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs = ^TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataSession
  IMobileBroadbandDeviceServiceDataSession = interface;
  PIMobileBroadbandDeviceServiceDataSession = ^IMobileBroadbandDeviceServiceDataSession;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult
  IMobileBroadbandDeviceServiceCommandResult = interface;
  PIMobileBroadbandDeviceServiceCommandResult = ^IMobileBroadbandDeviceServiceCommandResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult = ^AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult = interface;
  PIAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult = ^IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandSession
  IMobileBroadbandDeviceServiceCommandSession = interface;
  PIMobileBroadbandDeviceServiceCommandSession = ^IMobileBroadbandDeviceServiceCommandSession;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceService
  IMobileBroadbandDeviceService = interface;
  PIMobileBroadbandDeviceService = ^IMobileBroadbandDeviceService;

  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult
  IMobileBroadbandUiccAppsResult = interface;
  PIMobileBroadbandUiccAppsResult = ^IMobileBroadbandUiccAppsResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult = ^AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppsResult = interface;
  PIAsyncOperation_1__IMobileBroadbandUiccAppsResult = ^IAsyncOperation_1__IMobileBroadbandUiccAppsResult;

  // Windows.Networking.NetworkOperators.IMobileBroadbandUicc
  IMobileBroadbandUicc = interface;
  PIMobileBroadbandUicc = ^IMobileBroadbandUicc;

  // Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration
  IMobileBroadbandModemConfiguration = interface;
  PIMobileBroadbandModemConfiguration = ^IMobileBroadbandModemConfiguration;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration = interface;
  PAsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration = ^AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  IAsyncOperation_1__IMobileBroadbandModemConfiguration = interface;
  PIAsyncOperation_1__IMobileBroadbandModemConfiguration = ^IAsyncOperation_1__IMobileBroadbandModemConfiguration;

  // Windows.Networking.NetworkOperators.IMobileBroadbandModem
  IMobileBroadbandModem = interface;
  PIMobileBroadbandModem = ^IMobileBroadbandModem;

  // Windows.Networking.NetworkOperators.IMobileBroadbandModemStatics
  IMobileBroadbandModemStatics = interface;
  PIMobileBroadbandModemStatics = ^IMobileBroadbandModemStatics;

  // Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange
  IMobileBroadbandNetworkRegistrationStateChange = interface;
  PIMobileBroadbandNetworkRegistrationStateChange = ^IMobileBroadbandNetworkRegistrationStateChange;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IIterator_1__IMobileBroadbandNetworkRegistrationStateChange = interface;
  PIIterator_1__IMobileBroadbandNetworkRegistrationStateChange = ^IIterator_1__IMobileBroadbandNetworkRegistrationStateChange;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IIterable_1__IMobileBroadbandNetworkRegistrationStateChange = interface;
  PIIterable_1__IMobileBroadbandNetworkRegistrationStateChange = ^IIterable_1__IMobileBroadbandNetworkRegistrationStateChange;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IVectorView_1__IMobileBroadbandNetworkRegistrationStateChange = interface;
  PIVectorView_1__IMobileBroadbandNetworkRegistrationStateChange = ^IVectorView_1__IMobileBroadbandNetworkRegistrationStateChange;

  // Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChangeTriggerDetails
  IMobileBroadbandNetworkRegistrationStateChangeTriggerDetails = interface;
  PIMobileBroadbandNetworkRegistrationStateChangeTriggerDetails = ^IMobileBroadbandNetworkRegistrationStateChangeTriggerDetails;

  // Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange
  IMobileBroadbandRadioStateChange = interface;
  PIMobileBroadbandRadioStateChange = ^IMobileBroadbandRadioStateChange;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IIterator_1__IMobileBroadbandRadioStateChange = interface;
  PIIterator_1__IMobileBroadbandRadioStateChange = ^IIterator_1__IMobileBroadbandRadioStateChange;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IIterable_1__IMobileBroadbandRadioStateChange = interface;
  PIIterable_1__IMobileBroadbandRadioStateChange = ^IIterable_1__IMobileBroadbandRadioStateChange;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IVectorView_1__IMobileBroadbandRadioStateChange = interface;
  PIVectorView_1__IMobileBroadbandRadioStateChange = ^IVectorView_1__IMobileBroadbandRadioStateChange;

  // Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChangeTriggerDetails
  IMobileBroadbandRadioStateChangeTriggerDetails = interface;
  PIMobileBroadbandRadioStateChangeTriggerDetails = ^IMobileBroadbandRadioStateChangeTriggerDetails;

  // Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange
  IMobileBroadbandPinLockStateChange = interface;
  PIMobileBroadbandPinLockStateChange = ^IMobileBroadbandPinLockStateChange;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IIterator_1__IMobileBroadbandPinLockStateChange = interface;
  PIIterator_1__IMobileBroadbandPinLockStateChange = ^IIterator_1__IMobileBroadbandPinLockStateChange;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IIterable_1__IMobileBroadbandPinLockStateChange = interface;
  PIIterable_1__IMobileBroadbandPinLockStateChange = ^IIterable_1__IMobileBroadbandPinLockStateChange;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IVectorView_1__IMobileBroadbandPinLockStateChange = interface;
  PIVectorView_1__IMobileBroadbandPinLockStateChange = ^IVectorView_1__IMobileBroadbandPinLockStateChange;

  // Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChangeTriggerDetails
  IMobileBroadbandPinLockStateChangeTriggerDetails = interface;
  PIMobileBroadbandPinLockStateChangeTriggerDetails = ^IMobileBroadbandPinLockStateChangeTriggerDetails;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceTriggerDetails
  IMobileBroadbandDeviceServiceTriggerDetails = interface;
  PIMobileBroadbandDeviceServiceTriggerDetails = ^IMobileBroadbandDeviceServiceTriggerDetails;

  // Windows.Networking.NetworkOperators.IKnownCSimFilePathsStatics
  IKnownCSimFilePathsStatics = interface;
  PIKnownCSimFilePathsStatics = ^IKnownCSimFilePathsStatics;

  // Windows.Networking.NetworkOperators.IKnownRuimFilePathsStatics
  IKnownRuimFilePathsStatics = interface;
  PIKnownRuimFilePathsStatics = ^IKnownRuimFilePathsStatics;

  // Windows.Networking.NetworkOperators.IKnownSimFilePathsStatics
  IKnownSimFilePathsStatics = interface;
  PIKnownSimFilePathsStatics = ^IKnownSimFilePathsStatics;

  // Windows.Networking.NetworkOperators.IKnownUSimFilePathsStatics
  IKnownUSimFilePathsStatics = interface;
  PIKnownUSimFilePathsStatics = ^IKnownUSimFilePathsStatics;

  // Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult
  IHotspotCredentialsAuthenticationResult = interface;
  PIHotspotCredentialsAuthenticationResult = ^IHotspotCredentialsAuthenticationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult = interface;
  PAsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult = ^AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  IAsyncOperation_1__IHotspotCredentialsAuthenticationResult = interface;
  PIAsyncOperation_1__IHotspotCredentialsAuthenticationResult = ^IAsyncOperation_1__IHotspotCredentialsAuthenticationResult;

  // Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults
  IProvisionFromXmlDocumentResults = interface;
  PIProvisionFromXmlDocumentResults = ^IProvisionFromXmlDocumentResults;

  // Windows.Networking.NetworkOperators.IProvisionedProfile
  IProvisionedProfile = interface;
  PIProvisionedProfile = ^IProvisionedProfile;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults = interface;
  PAsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults = ^AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  IAsyncOperation_1__IProvisionFromXmlDocumentResults = interface;
  PIAsyncOperation_1__IProvisionFromXmlDocumentResults = ^IAsyncOperation_1__IProvisionFromXmlDocumentResults;

  // Windows.Networking.NetworkOperators.IProvisioningAgent
  IProvisioningAgent = interface;
  PIProvisioningAgent = ^IProvisioningAgent;

  // Windows.Networking.NetworkOperators.IProvisioningAgentStaticMethods
  IProvisioningAgentStaticMethods = interface;
  PIProvisioningAgentStaticMethods = ^IProvisioningAgentStaticMethods;

  // Windows.Networking.NetworkOperators.IUssdMessage
  IUssdMessage = interface;
  PIUssdMessage = ^IUssdMessage;

  // Windows.Networking.NetworkOperators.IUssdMessageFactory
  IUssdMessageFactory = interface;
  PIUssdMessageFactory = ^IUssdMessageFactory;

  // Windows.Networking.NetworkOperators.IUssdReply
  IUssdReply = interface;
  PIUssdReply = ^IUssdReply;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IUssdReply>
  AsyncOperationCompletedHandler_1__IUssdReply = interface;
  PAsyncOperationCompletedHandler_1__IUssdReply = ^AsyncOperationCompletedHandler_1__IUssdReply;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IUssdReply>
  IAsyncOperation_1__IUssdReply = interface;
  PIAsyncOperation_1__IUssdReply = ^IAsyncOperation_1__IUssdReply;

  // Windows.Networking.NetworkOperators.IUssdSession
  IUssdSession = interface;
  PIUssdSession = ^IUssdSession;

  // Windows.Networking.NetworkOperators.IUssdSessionStatics
  IUssdSessionStatics = interface;
  PIUssdSessionStatics = ^IUssdSessionStatics;

  // Windows.Networking.NetworkOperators.INetworkOperatorNotificationEventDetails
  INetworkOperatorNotificationEventDetails = interface;
  PINetworkOperatorNotificationEventDetails = ^INetworkOperatorNotificationEventDetails;

  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringEntitlementCheck
  INetworkOperatorTetheringEntitlementCheck = interface;
  PINetworkOperatorTetheringEntitlementCheck = ^INetworkOperatorTetheringEntitlementCheck;


  // Emit Forwarded interfaces
  // Windows.Networking.NetworkOperators Interfaces
  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandNetwork
  [WinRTClassNameAttribute(SMobileBroadbandNetwork)]
  IMobileBroadbandNetwork = interface(IInspectable)
  ['{CB63928C-0309-4CB6-A8C1-6A5A3C8E1FF6}']
    function get_NetworkAdapter: INetworkAdapter; safecall;
    function get_NetworkRegistrationState: NetworkRegistrationState; safecall;
    function get_RegistrationNetworkError: Cardinal; safecall;
    function get_PacketAttachNetworkError: Cardinal; safecall;
    function get_ActivationNetworkError: Cardinal; safecall;
    function get_AccessPointName: HSTRING; safecall;
    function get_RegisteredDataClass: DataClasses; safecall;
    function get_RegisteredProviderId: HSTRING; safecall;
    function get_RegisteredProviderName: HSTRING; safecall;
    procedure ShowConnectionUI; safecall;
    property AccessPointName: HSTRING read get_AccessPointName;
    property ActivationNetworkError: Cardinal read get_ActivationNetworkError;
    property NetworkAdapter: INetworkAdapter read get_NetworkAdapter;
    property NetworkRegistrationState: NetworkRegistrationState read get_NetworkRegistrationState;
    property PacketAttachNetworkError: Cardinal read get_PacketAttachNetworkError;
    property RegisteredDataClass: DataClasses read get_RegisteredDataClass;
    property RegisteredProviderId: HSTRING read get_RegisteredProviderId;
    property RegisteredProviderName: HSTRING read get_RegisteredProviderName;
    property RegistrationNetworkError: Cardinal read get_RegistrationNetworkError;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceInformation
  [WinRTClassNameAttribute(SMobileBroadbandDeviceInformation)]
  IMobileBroadbandDeviceInformation = interface(IInspectable)
  ['{E6D08168-E381-4C6E-9BE8-FE156969A446}']
    function get_NetworkDeviceStatus: NetworkDeviceStatus; safecall;
    function get_Manufacturer: HSTRING; safecall;
    function get_Model: HSTRING; safecall;
    function get_FirmwareInformation: HSTRING; safecall;
    function get_CellularClass: CellularClass; safecall;
    function get_DataClasses: DataClasses; safecall;
    function get_CustomDataClass: HSTRING; safecall;
    function get_MobileEquipmentId: HSTRING; safecall;
    function get_TelephoneNumbers: IVectorView_1__HSTRING; safecall;
    function get_SubscriberId: HSTRING; safecall;
    function get_SimIccId: HSTRING; safecall;
    function get_DeviceType: MobileBroadbandDeviceType; safecall;
    function get_DeviceId: HSTRING; safecall;
    function get_CurrentRadioState: MobileBroadbandRadioState; safecall;
    property CellularClass: CellularClass read get_CellularClass;
    property CurrentRadioState: MobileBroadbandRadioState read get_CurrentRadioState;
    property CustomDataClass: HSTRING read get_CustomDataClass;
    property DataClasses: DataClasses read get_DataClasses;
    property DeviceId: HSTRING read get_DeviceId;
    property DeviceType: MobileBroadbandDeviceType read get_DeviceType;
    property FirmwareInformation: HSTRING read get_FirmwareInformation;
    property Manufacturer: HSTRING read get_Manufacturer;
    property MobileEquipmentId: HSTRING read get_MobileEquipmentId;
    property Model: HSTRING read get_Model;
    property NetworkDeviceStatus: NetworkDeviceStatus read get_NetworkDeviceStatus;
    property SimIccId: HSTRING read get_SimIccId;
    property SubscriberId: HSTRING read get_SubscriberId;
    property TelephoneNumbers: IVectorView_1__HSTRING read get_TelephoneNumbers;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccount
  [WinRTClassNameAttribute(SMobileBroadbandAccount)]
  IMobileBroadbandAccount = interface(IInspectable)
  ['{36C24CCD-CEE2-43E0-A603-EE86A36D6570}']
    function get_NetworkAccountId: HSTRING; safecall;
    function get_ServiceProviderGuid: TGuid; safecall;
    function get_ServiceProviderName: HSTRING; safecall;
    function get_CurrentNetwork: IMobileBroadbandNetwork; safecall;
    function get_CurrentDeviceInformation: IMobileBroadbandDeviceInformation; safecall;
    property CurrentDeviceInformation: IMobileBroadbandDeviceInformation read get_CurrentDeviceInformation;
    property CurrentNetwork: IMobileBroadbandNetwork read get_CurrentNetwork;
    property NetworkAccountId: HSTRING read get_NetworkAccountId;
    property ServiceProviderGuid: TGuid read get_ServiceProviderGuid;
    property ServiceProviderName: HSTRING read get_ServiceProviderName;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountStatics
  [WinRTClassNameAttribute(SMobileBroadbandAccount)]
  IMobileBroadbandAccountStatics = interface(IInspectable)
  ['{AA7F4D24-AFC1-4FC8-AE9A-A9175310FAAD}']
    function get_AvailableNetworkAccountIds: IVectorView_1__HSTRING; safecall;
    function CreateFromNetworkAccountId(networkAccountId: HSTRING): IMobileBroadbandAccount; safecall;
    property AvailableNetworkAccountIds: IVectorView_1__HSTRING read get_AvailableNetworkAccountIds;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccount2
  IMobileBroadbandAccount2 = interface(IInspectable)
  ['{38F52F1C-1136-4257-959F-B658A352B6D4}']
    function GetConnectionProfiles: IVectorView_1__IConnectionProfile; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IIterator_1__MobileBroadbandPinType = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: MobileBroadbandPinType; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PMobileBroadbandPinType): Cardinal; safecall;
    property Current: MobileBroadbandPinType read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IIterable_1__MobileBroadbandPinType_Base = interface(IInspectable)
  ['{9D55726D-813E-50FB-9498-87AA872DD6CA}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IIterable_1__MobileBroadbandPinType = interface(IIterable_1__MobileBroadbandPinType_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__MobileBroadbandPinType; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.MobileBroadbandPinType>
  IVectorView_1__MobileBroadbandPinType = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): MobileBroadbandPinType; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: MobileBroadbandPinType; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PMobileBroadbandPinType): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult
  [WinRTClassNameAttribute(SMobileBroadbandPinOperationResult)]
  IMobileBroadbandPinOperationResult = interface(IInspectable)
  ['{11DDDC32-31E7-49F5-B663-123D3BEF0362}']
    function get_IsSuccessful: Boolean; safecall;
    function get_AttemptsRemaining: Cardinal; safecall;
    property AttemptsRemaining: Cardinal read get_AttemptsRemaining;
    property IsSuccessful: Boolean read get_IsSuccessful;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult_Delegate_Base = interface(IUnknown)
  ['{595AD094-60E3-5349-8FE6-EA8ECBBB2541}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult_Delegate_Base)
  ['{5376FE24-4843-598E-9423-B7A8FDE0AF79}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandPinOperationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  IAsyncOperation_1__IMobileBroadbandPinOperationResult_Base = interface(IInspectable)
  ['{2F76661C-2F74-5CE2-99F9-47D1A3A13633}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinOperationResult>
  IAsyncOperation_1__IMobileBroadbandPinOperationResult = interface(IAsyncOperation_1__IMobileBroadbandPinOperationResult_Base)
  ['{251B212E-0F07-5D6C-8BE4-C75257773102}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult; safecall;
    function GetResults: IMobileBroadbandPinOperationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandPinOperationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandPin
  [WinRTClassNameAttribute(SMobileBroadbandPin)]
  IMobileBroadbandPin = interface(IInspectable)
  ['{E661D709-E779-45BF-8281-75323DF9E321}']
    function get_Type: MobileBroadbandPinType; safecall;
    function get_LockState: MobileBroadbandPinLockState; safecall;
    function get_Format: MobileBroadbandPinFormat; safecall;
    function get_Enabled: Boolean; safecall;
    function get_MaxLength: Cardinal; safecall;
    function get_MinLength: Cardinal; safecall;
    function get_AttemptsRemaining: Cardinal; safecall;
    function EnableAsync(currentPin: HSTRING): IAsyncOperation_1__IMobileBroadbandPinOperationResult; safecall;
    function DisableAsync(currentPin: HSTRING): IAsyncOperation_1__IMobileBroadbandPinOperationResult; safecall;
    function EnterAsync(currentPin: HSTRING): IAsyncOperation_1__IMobileBroadbandPinOperationResult; safecall;
    function ChangeAsync(currentPin: HSTRING; newPin: HSTRING): IAsyncOperation_1__IMobileBroadbandPinOperationResult; safecall;
    function UnblockAsync(pinUnblockKey: HSTRING; newPin: HSTRING): IAsyncOperation_1__IMobileBroadbandPinOperationResult; safecall;
    property AttemptsRemaining: Cardinal read get_AttemptsRemaining;
    property Enabled: Boolean read get_Enabled;
    property Format: MobileBroadbandPinFormat read get_Format;
    property LockState: MobileBroadbandPinLockState read get_LockState;
    property MaxLength: Cardinal read get_MaxLength;
    property MinLength: Cardinal read get_MinLength;
    property &Type: MobileBroadbandPinType read get_Type;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandPinManager
  [WinRTClassNameAttribute(SMobileBroadbandPinManager)]
  IMobileBroadbandPinManager = interface(IInspectable)
  ['{83567EDD-6E1F-4B9B-A413-2B1F50CC36DF}']
    function get_SupportedPins: IVectorView_1__MobileBroadbandPinType; safecall;
    function GetPin(pinType: MobileBroadbandPinType): IMobileBroadbandPin; safecall;
    property SupportedPins: IVectorView_1__MobileBroadbandPinType read get_SupportedPins;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceInformation2
  IMobileBroadbandDeviceInformation2 = interface(IInspectable)
  ['{2E467AF1-F932-4737-A722-03BA72370CB8}']
    function get_PinManager: IMobileBroadbandPinManager; safecall;
    function get_Revision: HSTRING; safecall;
    function get_SerialNumber: HSTRING; safecall;
    property PinManager: IMobileBroadbandPinManager read get_PinManager;
    property Revision: HSTRING read get_Revision;
    property SerialNumber: HSTRING read get_SerialNumber;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult
  [WinRTClassNameAttribute(SMobileBroadbandUiccAppRecordDetailsResult)]
  IMobileBroadbandUiccAppRecordDetailsResult = interface(IInspectable)
  ['{D919682F-BE14-4934-981D-2F57B9ED83E6}']
    function get_Status: MobileBroadbandUiccAppOperationStatus; safecall;
    function get_Kind: UiccAppRecordKind; safecall;
    function get_RecordCount: Integer; safecall;
    function get_RecordSize: Integer; safecall;
    function get_ReadAccessCondition: UiccAccessCondition; safecall;
    function get_WriteAccessCondition: UiccAccessCondition; safecall;
    property Kind: UiccAppRecordKind read get_Kind;
    property ReadAccessCondition: UiccAccessCondition read get_ReadAccessCondition;
    property RecordCount: Integer read get_RecordCount;
    property RecordSize: Integer read get_RecordSize;
    property Status: MobileBroadbandUiccAppOperationStatus read get_Status;
    property WriteAccessCondition: UiccAccessCondition read get_WriteAccessCondition;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult_Delegate_Base = interface(IUnknown)
  ['{D0B53858-0E54-5791-82ED-3313DC75DA45}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult_Delegate_Base)
  ['{27D58B7A-136A-5311-9339-3EFA8B4C4673}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult_Base = interface(IInspectable)
  ['{0774F4A6-BDBE-59FF-AA1C-A62E3C6F9D37}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppRecordDetailsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult = interface(IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult_Base)
  ['{A82D52D6-E249-502B-B158-1C5B47B33840}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult; safecall;
    function GetResults: IMobileBroadbandUiccAppRecordDetailsResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppRecordDetailsResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult
  [WinRTClassNameAttribute(SMobileBroadbandUiccAppReadRecordResult)]
  IMobileBroadbandUiccAppReadRecordResult = interface(IInspectable)
  ['{64C95285-358E-47C5-8249-695F383B2BDB}']
    function get_Status: MobileBroadbandUiccAppOperationStatus; safecall;
    function get_Data: IBuffer; safecall;
    property Data: IBuffer read get_Data;
    property Status: MobileBroadbandUiccAppOperationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult_Delegate_Base = interface(IUnknown)
  ['{B81892B3-4CA9-5EC4-8971-2FBC19B56CA9}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult_Delegate_Base)
  ['{8A6A0DF5-24F6-50DA-87A6-9460D7A5603B}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult_Base = interface(IInspectable)
  ['{27FC8483-30D8-5BE3-BC1E-8CCA0B241DF3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppReadRecordResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult = interface(IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult_Base)
  ['{04D99A02-299A-56ED-B6EA-18C5DC2DE9EC}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult; safecall;
    function GetResults: IMobileBroadbandUiccAppReadRecordResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppReadRecordResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp
  [WinRTClassNameAttribute(SMobileBroadbandUiccApp)]
  IMobileBroadbandUiccApp = interface(IInspectable)
  ['{4D170556-98A1-43DD-B2EC-50C90CF248DF}']
    function get_Id: IBuffer; safecall;
    function get_Kind: UiccAppKind; safecall;
    function GetRecordDetailsAsync(uiccFilePath: IIterable_1__Cardinal): IAsyncOperation_1__IMobileBroadbandUiccAppRecordDetailsResult; safecall;
    function ReadRecordAsync(uiccFilePath: IIterable_1__Cardinal; recordIndex: Integer): IAsyncOperation_1__IMobileBroadbandUiccAppReadRecordResult; safecall;
    property Id: IBuffer read get_Id;
    property Kind: UiccAppKind read get_Kind;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IIterator_1__IMobileBroadbandUiccApp = interface(IInspectable)
  ['{776CC781-A67D-5518-A04C-F787677835C1}']
    function get_Current: IMobileBroadbandUiccApp; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMobileBroadbandUiccApp): Cardinal; safecall;
    property Current: IMobileBroadbandUiccApp read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IIterable_1__IMobileBroadbandUiccApp_Base = interface(IInspectable)
  ['{AF538114-BD14-53B0-B1D1-841DCAA451AD}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IIterable_1__IMobileBroadbandUiccApp = interface(IIterable_1__IMobileBroadbandUiccApp_Base)
  ['{1E7B803F-BB49-5260-B98C-719667953BA7}']
    function First: IIterator_1__IMobileBroadbandUiccApp; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccApp>
  IVectorView_1__IMobileBroadbandUiccApp = interface(IInspectable)
  ['{61E0715E-E1F9-522E-8BD9-B1D946F964AE}']
    function GetAt(index: Cardinal): IMobileBroadbandUiccApp; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMobileBroadbandUiccApp; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMobileBroadbandUiccApp): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandNetwork2
  IMobileBroadbandNetwork2 = interface(IInspectable)
  ['{5A55DB22-62F7-4BDD-BA1D-477441960BA0}']
    function GetVoiceCallSupportAsync: IAsyncOperation_1__Boolean; safecall;
    function get_RegistrationUiccApps: IVectorView_1__IMobileBroadbandUiccApp; safecall;
    property RegistrationUiccApps: IVectorView_1__IMobileBroadbandUiccApp read get_RegistrationUiccApps;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringAccessPointConfiguration
  [WinRTClassNameAttribute(SNetworkOperatorTetheringAccessPointConfiguration)]
  INetworkOperatorTetheringAccessPointConfiguration = interface(IInspectable)
  ['{0BCC0284-412E-403D-ACC6-B757E34774A4}']
    function get_Ssid: HSTRING; safecall;
    procedure put_Ssid(value: HSTRING); safecall;
    function get_Passphrase: HSTRING; safecall;
    procedure put_Passphrase(value: HSTRING); safecall;
    property Passphrase: HSTRING read get_Passphrase write put_Passphrase;
    property Ssid: HSTRING read get_Ssid write put_Ssid;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult
  [WinRTClassNameAttribute(SNetworkOperatorTetheringOperationResult)]
  INetworkOperatorTetheringOperationResult = interface(IInspectable)
  ['{EBD203A1-01BA-476D-B4B3-BF3D12C8F80C}']
    function get_Status: TetheringOperationStatus; safecall;
    function get_AdditionalErrorMessage: HSTRING; safecall;
    property AdditionalErrorMessage: HSTRING read get_AdditionalErrorMessage;
    property Status: TetheringOperationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult_Delegate_Base = interface(IUnknown)
  ['{A936B927-7537-59C6-89DE-33F36A9725AB}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult = interface(AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult_Delegate_Base)
  ['{E8DB81F2-A338-5D47-89B0-F26A42FEE582}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__INetworkOperatorTetheringOperationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  IAsyncOperation_1__INetworkOperatorTetheringOperationResult_Base = interface(IInspectable)
  ['{601B30ED-9B7F-54B6-B61B-24A09BC56304}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringOperationResult>
  IAsyncOperation_1__INetworkOperatorTetheringOperationResult = interface(IAsyncOperation_1__INetworkOperatorTetheringOperationResult_Base)
  ['{3112BC41-BE86-53A8-81C0-D0BA85CB5CE2}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult; safecall;
    function GetResults: INetworkOperatorTetheringOperationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__INetworkOperatorTetheringOperationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManager
  [WinRTClassNameAttribute(SNetworkOperatorTetheringManager)]
  INetworkOperatorTetheringManager = interface(IInspectable)
  ['{D45A8DA0-0E86-4D98-8BA4-DD70D4B764D3}']
    function get_MaxClientCount: Cardinal; safecall;
    function get_ClientCount: Cardinal; safecall;
    function get_TetheringOperationalState: TetheringOperationalState; safecall;
    function GetCurrentAccessPointConfiguration: INetworkOperatorTetheringAccessPointConfiguration; safecall;
    function ConfigureAccessPointAsync(configuration: INetworkOperatorTetheringAccessPointConfiguration): IAsyncAction; safecall;
    function StartTetheringAsync: IAsyncOperation_1__INetworkOperatorTetheringOperationResult; safecall;
    function StopTetheringAsync: IAsyncOperation_1__INetworkOperatorTetheringOperationResult; safecall;
    property ClientCount: Cardinal read get_ClientCount;
    property MaxClientCount: Cardinal read get_MaxClientCount;
    property TetheringOperationalState: TetheringOperationalState read get_TetheringOperationalState;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManagerStatics
  [WinRTClassNameAttribute(SNetworkOperatorTetheringManager)]
  INetworkOperatorTetheringManagerStatics = interface(IInspectable)
  ['{3EBCBACC-F8C3-405C-9964-70A1EEABE194}']
    function GetTetheringCapability(networkAccountId: HSTRING): TetheringCapability; safecall;
    function CreateFromNetworkAccountId(networkAccountId: HSTRING): INetworkOperatorTetheringManager; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringManagerStatics2
  [WinRTClassNameAttribute(SNetworkOperatorTetheringManager)]
  INetworkOperatorTetheringManagerStatics2 = interface(IInspectable)
  ['{5B235412-35F0-49E7-9B08-16D278FBAA42}']
    function GetTetheringCapabilityFromConnectionProfile(profile: IConnectionProfile): TetheringCapability; safecall;
    function CreateFromConnectionProfile(profile: IConnectionProfile): INetworkOperatorTetheringManager; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient
  [WinRTClassNameAttribute(SNetworkOperatorTetheringClient)]
  INetworkOperatorTetheringClient = interface(IInspectable)
  ['{709D254C-595F-4847-BB30-646935542918}']
    function get_MacAddress: HSTRING; safecall;
    function get_HostNames: IVectorView_1__IHostName; safecall;
    property HostNames: IVectorView_1__IHostName read get_HostNames;
    property MacAddress: HSTRING read get_MacAddress;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IIterator_1__INetworkOperatorTetheringClient = interface(IInspectable)
  ['{52FC26D5-75EF-527D-AB08-C10685F93A66}']
    function get_Current: INetworkOperatorTetheringClient; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PINetworkOperatorTetheringClient): Cardinal; safecall;
    property Current: INetworkOperatorTetheringClient read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IIterable_1__INetworkOperatorTetheringClient_Base = interface(IInspectable)
  ['{4762ECB3-AF48-5B63-89B7-78A42056549F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IIterable_1__INetworkOperatorTetheringClient = interface(IIterable_1__INetworkOperatorTetheringClient_Base)
  ['{443E479B-46B8-5D56-B4EA-13101020B6A6}']
    function First: IIterator_1__INetworkOperatorTetheringClient; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.INetworkOperatorTetheringClient>
  IVectorView_1__INetworkOperatorTetheringClient = interface(IInspectable)
  ['{23AA5A28-AD35-5C47-976A-53269CDC5293}']
    function GetAt(index: Cardinal): INetworkOperatorTetheringClient; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: INetworkOperatorTetheringClient; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PINetworkOperatorTetheringClient): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringClientManager
  INetworkOperatorTetheringClientManager = interface(IInspectable)
  ['{91B14016-8DCA-4225-BBED-EEF8B8D718D7}']
    function GetTetheringClients: IVectorView_1__INetworkOperatorTetheringClient; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountEventArgs
  [WinRTClassNameAttribute(SMobileBroadbandAccountEventArgs)]
  IMobileBroadbandAccountEventArgs = interface(IInspectable)
  ['{3853C880-77DE-4C04-BEAD-A123B08C9F59}']
    function get_NetworkAccountId: HSTRING; safecall;
    property NetworkAccountId: HSTRING read get_NetworkAccountId;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountUpdatedEventArgs
  [WinRTClassNameAttribute(SMobileBroadbandAccountUpdatedEventArgs)]
  IMobileBroadbandAccountUpdatedEventArgs = interface(IInspectable)
  ['{7BC31D88-A6BD-49E1-80AB-6B91354A57D4}']
    function get_NetworkAccountId: HSTRING; safecall;
    function get_HasDeviceInformationChanged: Boolean; safecall;
    function get_HasNetworkChanged: Boolean; safecall;
    property HasDeviceInformationChanged: Boolean read get_HasDeviceInformationChanged;
    property HasNetworkChanged: Boolean read get_HasNetworkChanged;
    property NetworkAccountId: HSTRING read get_NetworkAccountId;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs_Delegate_Base = interface(IUnknown)
  ['{423CC41E-FE8C-5A7D-9FEE-AAE04EF85700}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs = interface(TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs_Delegate_Base)
  ['{5475B308-13DA-55FA-A4E6-32B15DCD409C}']
    procedure Invoke(sender: IMobileBroadbandAccountWatcher; args: IMobileBroadbandAccountEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountUpdatedEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs_Delegate_Base = interface(IUnknown)
  ['{0E865096-1FFA-5792-8D4F-8623E3C77F56}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Windows.Networking.NetworkOperators.IMobileBroadbandAccountUpdatedEventArgs>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs = interface(TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs_Delegate_Base)
  ['{732723B5-733F-57AE-BAB8-65EFC90209EC}']
    procedure Invoke(sender: IMobileBroadbandAccountWatcher; args: IMobileBroadbandAccountUpdatedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Object>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable_Delegate_Base = interface(IUnknown)
  ['{E4DC9CFC-F462-5AFD-856D-04ACE229D00E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher,Object>
  TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable = interface(TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable_Delegate_Base)
  ['{86F13482-3275-5928-80CD-6A6B72B82CCD}']
    procedure Invoke(sender: IMobileBroadbandAccountWatcher; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandAccountWatcher
  [WinRTClassNameAttribute(SMobileBroadbandAccountWatcher)]
  IMobileBroadbandAccountWatcher = interface(IInspectable)
  ['{6BF3335E-23B5-449F-928D-5E0D3E04471D}']
    function add_AccountAdded(handler: TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs): EventRegistrationToken; safecall;
    procedure remove_AccountAdded(cookie: EventRegistrationToken); safecall;
    function add_AccountUpdated(handler: TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountUpdatedEventArgs): EventRegistrationToken; safecall;
    procedure remove_AccountUpdated(cookie: EventRegistrationToken); safecall;
    function add_AccountRemoved(handler: TypedEventHandler_2__IMobileBroadbandAccountWatcher__IMobileBroadbandAccountEventArgs): EventRegistrationToken; safecall;
    procedure remove_AccountRemoved(cookie: EventRegistrationToken); safecall;
    function add_EnumerationCompleted(handler: TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_EnumerationCompleted(cookie: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__IMobileBroadbandAccountWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Stopped(cookie: EventRegistrationToken); safecall;
    function get_Status: MobileBroadbandAccountWatcherStatus; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    property Status: MobileBroadbandAccountWatcherStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation
  [WinRTClassNameAttribute(SMobileBroadbandDeviceServiceInformation)]
  IMobileBroadbandDeviceServiceInformation = interface(IInspectable)
  ['{53D69B5B-C4ED-45F0-803A-D9417A6D9846}']
    function get_DeviceServiceId: TGuid; safecall;
    function get_IsDataReadSupported: Boolean; safecall;
    function get_IsDataWriteSupported: Boolean; safecall;
    property DeviceServiceId: TGuid read get_DeviceServiceId;
    property IsDataReadSupported: Boolean read get_IsDataReadSupported;
    property IsDataWriteSupported: Boolean read get_IsDataWriteSupported;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IIterator_1__IMobileBroadbandDeviceServiceInformation = interface(IInspectable)
  ['{05415FF7-5FDE-51DC-A0D5-4F704E3651A3}']
    function get_Current: IMobileBroadbandDeviceServiceInformation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMobileBroadbandDeviceServiceInformation): Cardinal; safecall;
    property Current: IMobileBroadbandDeviceServiceInformation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IIterable_1__IMobileBroadbandDeviceServiceInformation_Base = interface(IInspectable)
  ['{88511855-6FE6-5694-83A7-991E29033DE5}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IIterable_1__IMobileBroadbandDeviceServiceInformation = interface(IIterable_1__IMobileBroadbandDeviceServiceInformation_Base)
  ['{C06A2C8F-A6D4-5C58-937B-A9DDBB8FBBD1}']
    function First: IIterator_1__IMobileBroadbandDeviceServiceInformation; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceInformation>
  IVectorView_1__IMobileBroadbandDeviceServiceInformation = interface(IInspectable)
  ['{52C008C3-0273-53EC-80FE-EAF6B34CE03F}']
    function GetAt(index: Cardinal): IMobileBroadbandDeviceServiceInformation; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMobileBroadbandDeviceServiceInformation; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMobileBroadbandDeviceServiceInformation): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataReceivedEventArgs
  IMobileBroadbandDeviceServiceDataReceivedEventArgs = interface(IInspectable)
  ['{B6AA13DE-1380-40E3-8618-73CBCA48138C}']
    function get_ReceivedData: IBuffer; safecall;
    property ReceivedData: IBuffer read get_ReceivedData;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataSession,Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataReceivedEventArgs>
  TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{31F89CA6-DD7F-5325-9020-627D8B47EA02}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataSession,Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataReceivedEventArgs>
  TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs = interface(TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs_Delegate_Base)
  ['{1A79C740-7A77-57DA-BBE8-9C068B8E0853}']
    procedure Invoke(sender: IMobileBroadbandDeviceServiceDataSession; args: IMobileBroadbandDeviceServiceDataReceivedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceDataSession
  [WinRTClassNameAttribute(SMobileBroadbandDeviceServiceDataSession)]
  IMobileBroadbandDeviceServiceDataSession = interface(IInspectable)
  ['{DAD62333-8BCF-4289-8A37-045C2169486A}']
    function WriteDataAsync(value: IBuffer): IAsyncAction; safecall;
    procedure CloseSession; safecall;
    function add_DataReceived(eventHandler: TypedEventHandler_2__IMobileBroadbandDeviceServiceDataSession__IMobileBroadbandDeviceServiceDataReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DataReceived(eventCookie: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult
  [WinRTClassNameAttribute(SMobileBroadbandDeviceServiceCommandResult)]
  IMobileBroadbandDeviceServiceCommandResult = interface(IInspectable)
  ['{B0F46ABB-94D6-44B9-A538-F0810B645389}']
    function get_StatusCode: Cardinal; safecall;
    function get_ResponseData: IBuffer; safecall;
    property ResponseData: IBuffer read get_ResponseData;
    property StatusCode: Cardinal read get_StatusCode;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult_Delegate_Base = interface(IUnknown)
  ['{21F0CE4F-8F33-5E71-A457-DDA553B0D6BB}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult_Delegate_Base)
  ['{D7D3031C-A595-52C3-9179-7C74B197645D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult_Base = interface(IInspectable)
  ['{2C673AA8-6A35-50FD-9422-3615A1C28CCB}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandResult>
  IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult = interface(IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult_Base)
  ['{0943E466-3D80-5767-827C-BEADC11B3BC9}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult; safecall;
    function GetResults: IMobileBroadbandDeviceServiceCommandResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandDeviceServiceCommandResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceCommandSession
  [WinRTClassNameAttribute(SMobileBroadbandDeviceServiceCommandSession)]
  IMobileBroadbandDeviceServiceCommandSession = interface(IInspectable)
  ['{FC098A45-913B-4914-B6C3-AE6304593E75}']
    function SendQueryCommandAsync(commandId: Cardinal; data: IBuffer): IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult; safecall;
    function SendSetCommandAsync(commandId: Cardinal; data: IBuffer): IAsyncOperation_1__IMobileBroadbandDeviceServiceCommandResult; safecall;
    procedure CloseSession; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceService
  [WinRTClassNameAttribute(SMobileBroadbandDeviceService)]
  IMobileBroadbandDeviceService = interface(IInspectable)
  ['{22BE1A52-BD80-40AC-8E1F-2E07836A3DBD}']
    function get_DeviceServiceId: TGuid; safecall;
    function get_SupportedCommands: IVectorView_1__Cardinal; safecall;
    function OpenDataSession: IMobileBroadbandDeviceServiceDataSession; safecall;
    function OpenCommandSession: IMobileBroadbandDeviceServiceCommandSession; safecall;
    property DeviceServiceId: TGuid read get_DeviceServiceId;
    property SupportedCommands: IVectorView_1__Cardinal read get_SupportedCommands;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult
  [WinRTClassNameAttribute(SMobileBroadbandUiccAppsResult)]
  IMobileBroadbandUiccAppsResult = interface(IInspectable)
  ['{744930EB-8157-4A41-8494-6BF54C9B1D2B}']
    function get_Status: MobileBroadbandUiccAppOperationStatus; safecall;
    function get_UiccApps: IVectorView_1__IMobileBroadbandUiccApp; safecall;
    property Status: MobileBroadbandUiccAppOperationStatus read get_Status;
    property UiccApps: IVectorView_1__IMobileBroadbandUiccApp read get_UiccApps;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult_Delegate_Base = interface(IUnknown)
  ['{A12BED56-C672-595E-A67B-49ABC285ADDC}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult_Delegate_Base)
  ['{A9553FA4-EEEC-5CF5-8791-3743312C16E1}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandUiccAppsResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppsResult_Base = interface(IInspectable)
  ['{CF1CE97F-1A81-5CE6-8AD5-55FF8B0E8D1B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandUiccAppsResult>
  IAsyncOperation_1__IMobileBroadbandUiccAppsResult = interface(IAsyncOperation_1__IMobileBroadbandUiccAppsResult_Base)
  ['{FC71A253-3C12-51B6-93E0-A6E61C50A26E}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult; safecall;
    function GetResults: IMobileBroadbandUiccAppsResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandUiccAppsResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandUicc
  [WinRTClassNameAttribute(SMobileBroadbandUicc)]
  IMobileBroadbandUicc = interface(IInspectable)
  ['{E634F691-525A-4CE2-8FCE-AA4162579154}']
    function get_SimIccId: HSTRING; safecall;
    function GetUiccAppsAsync: IAsyncOperation_1__IMobileBroadbandUiccAppsResult; safecall;
    property SimIccId: HSTRING read get_SimIccId;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration
  [WinRTClassNameAttribute(SMobileBroadbandModemConfiguration)]
  IMobileBroadbandModemConfiguration = interface(IInspectable)
  ['{FCE035A3-D6CD-4320-B982-BE9D3EC7890F}']
    function get_Uicc: IMobileBroadbandUicc; safecall;
    function get_HomeProviderId: HSTRING; safecall;
    function get_HomeProviderName: HSTRING; safecall;
    property HomeProviderId: HSTRING read get_HomeProviderId;
    property HomeProviderName: HSTRING read get_HomeProviderName;
    property Uicc: IMobileBroadbandUicc read get_Uicc;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration_Delegate_Base = interface(IUnknown)
  ['{C11E0649-8237-5C93-BBDB-2EDA5216FD3F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration = interface(AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration_Delegate_Base)
  ['{C6FCAF27-08E3-52FF-B470-BFF281F7EB51}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMobileBroadbandModemConfiguration; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  IAsyncOperation_1__IMobileBroadbandModemConfiguration_Base = interface(IInspectable)
  ['{CDBE0003-DAAA-5C89-92E6-A47FFC2418A2}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IMobileBroadbandModemConfiguration>
  IAsyncOperation_1__IMobileBroadbandModemConfiguration = interface(IAsyncOperation_1__IMobileBroadbandModemConfiguration_Base)
  ['{A1DA01E4-C772-5CCB-9C5E-F67D9EDAA903}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration; safecall;
    function GetResults: IMobileBroadbandModemConfiguration; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMobileBroadbandModemConfiguration read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandModem
  [WinRTClassNameAttribute(SMobileBroadbandModem)]
  IMobileBroadbandModem = interface(IInspectable)
  ['{D0356912-E9F9-4F67-A03D-43189A316BF1}']
    function get_CurrentAccount: IMobileBroadbandAccount; safecall;
    function get_DeviceInformation: IMobileBroadbandDeviceInformation; safecall;
    function get_MaxDeviceServiceCommandSizeInBytes: Cardinal; safecall;
    function get_MaxDeviceServiceDataSizeInBytes: Cardinal; safecall;
    function get_DeviceServices: IVectorView_1__IMobileBroadbandDeviceServiceInformation; safecall;
    function GetDeviceService(deviceServiceId: TGuid): IMobileBroadbandDeviceService; safecall;
    function get_IsResetSupported: Boolean; safecall;
    function ResetAsync: IAsyncAction; safecall;
    function GetCurrentConfigurationAsync: IAsyncOperation_1__IMobileBroadbandModemConfiguration; safecall;
    function get_CurrentNetwork: IMobileBroadbandNetwork; safecall;
    property CurrentAccount: IMobileBroadbandAccount read get_CurrentAccount;
    property CurrentNetwork: IMobileBroadbandNetwork read get_CurrentNetwork;
    property DeviceInformation: IMobileBroadbandDeviceInformation read get_DeviceInformation;
    property DeviceServices: IVectorView_1__IMobileBroadbandDeviceServiceInformation read get_DeviceServices;
    property IsResetSupported: Boolean read get_IsResetSupported;
    property MaxDeviceServiceCommandSizeInBytes: Cardinal read get_MaxDeviceServiceCommandSizeInBytes;
    property MaxDeviceServiceDataSizeInBytes: Cardinal read get_MaxDeviceServiceDataSizeInBytes;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandModemStatics
  [WinRTClassNameAttribute(SMobileBroadbandModem)]
  IMobileBroadbandModemStatics = interface(IInspectable)
  ['{F99ED637-D6F1-4A78-8CBC-6421A65063C8}']
    function GetDeviceSelector: HSTRING; safecall;
    function FromId(deviceId: HSTRING): IMobileBroadbandModem; safecall;
    function GetDefault: IMobileBroadbandModem; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange
  [WinRTClassNameAttribute(SMobileBroadbandNetworkRegistrationStateChange)]
  IMobileBroadbandNetworkRegistrationStateChange = interface(IInspectable)
  ['{BEAF94E1-960F-49B4-A08D-7D85E968C7EC}']
    function get_DeviceId: HSTRING; safecall;
    function get_Network: IMobileBroadbandNetwork; safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property Network: IMobileBroadbandNetwork read get_Network;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IIterator_1__IMobileBroadbandNetworkRegistrationStateChange = interface(IInspectable)
  ['{3D7E7450-0C2A-537D-9F77-937B4856757A}']
    function get_Current: IMobileBroadbandNetworkRegistrationStateChange; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMobileBroadbandNetworkRegistrationStateChange): Cardinal; safecall;
    property Current: IMobileBroadbandNetworkRegistrationStateChange read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IIterable_1__IMobileBroadbandNetworkRegistrationStateChange_Base = interface(IInspectable)
  ['{0B90BB30-660C-51C6-9B8C-31DD8486E10E}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IIterable_1__IMobileBroadbandNetworkRegistrationStateChange = interface(IIterable_1__IMobileBroadbandNetworkRegistrationStateChange_Base)
  ['{E0E40C22-CFC9-5DF3-8EBE-C551D691287E}']
    function First: IIterator_1__IMobileBroadbandNetworkRegistrationStateChange; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChange>
  IVectorView_1__IMobileBroadbandNetworkRegistrationStateChange = interface(IInspectable)
  ['{BD95AB62-44B2-5ADD-B16E-03D48253F162}']
    function GetAt(index: Cardinal): IMobileBroadbandNetworkRegistrationStateChange; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMobileBroadbandNetworkRegistrationStateChange; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMobileBroadbandNetworkRegistrationStateChange): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandNetworkRegistrationStateChangeTriggerDetails
  [WinRTClassNameAttribute(SMobileBroadbandNetworkRegistrationStateChangeTriggerDetails)]
  IMobileBroadbandNetworkRegistrationStateChangeTriggerDetails = interface(IInspectable)
  ['{89135CFF-28B8-46AA-B137-1C4B0F21EDFE}']
    function get_NetworkRegistrationStateChanges: IVectorView_1__IMobileBroadbandNetworkRegistrationStateChange; safecall;
    property NetworkRegistrationStateChanges: IVectorView_1__IMobileBroadbandNetworkRegistrationStateChange read get_NetworkRegistrationStateChanges;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange
  [WinRTClassNameAttribute(SMobileBroadbandRadioStateChange)]
  IMobileBroadbandRadioStateChange = interface(IInspectable)
  ['{B054A561-9833-4AED-9717-4348B21A24B3}']
    function get_DeviceId: HSTRING; safecall;
    function get_RadioState: MobileBroadbandRadioState; safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property RadioState: MobileBroadbandRadioState read get_RadioState;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IIterator_1__IMobileBroadbandRadioStateChange = interface(IInspectable)
  ['{C47426E0-8EBF-523A-BD9A-E23C0C7E5D7F}']
    function get_Current: IMobileBroadbandRadioStateChange; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMobileBroadbandRadioStateChange): Cardinal; safecall;
    property Current: IMobileBroadbandRadioStateChange read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IIterable_1__IMobileBroadbandRadioStateChange_Base = interface(IInspectable)
  ['{C385ADAA-574C-5AD8-98C2-61309525132D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IIterable_1__IMobileBroadbandRadioStateChange = interface(IIterable_1__IMobileBroadbandRadioStateChange_Base)
  ['{E4E62A7B-F718-58A8-9FFA-062BD7E51E20}']
    function First: IIterator_1__IMobileBroadbandRadioStateChange; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChange>
  IVectorView_1__IMobileBroadbandRadioStateChange = interface(IInspectable)
  ['{D1CB8E13-2478-5488-A9F6-863309D9DF35}']
    function GetAt(index: Cardinal): IMobileBroadbandRadioStateChange; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMobileBroadbandRadioStateChange; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMobileBroadbandRadioStateChange): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandRadioStateChangeTriggerDetails
  [WinRTClassNameAttribute(SMobileBroadbandRadioStateChangeTriggerDetails)]
  IMobileBroadbandRadioStateChangeTriggerDetails = interface(IInspectable)
  ['{71301ACE-093C-42C6-B0DB-AD1F75A65445}']
    function get_RadioStateChanges: IVectorView_1__IMobileBroadbandRadioStateChange; safecall;
    property RadioStateChanges: IVectorView_1__IMobileBroadbandRadioStateChange read get_RadioStateChanges;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange
  [WinRTClassNameAttribute(SMobileBroadbandPinLockStateChange)]
  IMobileBroadbandPinLockStateChange = interface(IInspectable)
  ['{BE16673E-1F04-4F95-8B90-E7F559DDE7E5}']
    function get_DeviceId: HSTRING; safecall;
    function get_PinType: MobileBroadbandPinType; safecall;
    function get_PinLockState: MobileBroadbandPinLockState; safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property PinLockState: MobileBroadbandPinLockState read get_PinLockState;
    property PinType: MobileBroadbandPinType read get_PinType;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IIterator_1__IMobileBroadbandPinLockStateChange = interface(IInspectable)
  ['{9F6CDEEA-0EF0-5BCE-BEBA-F8667FEFEC97}']
    function get_Current: IMobileBroadbandPinLockStateChange; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMobileBroadbandPinLockStateChange): Cardinal; safecall;
    property Current: IMobileBroadbandPinLockStateChange read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IIterable_1__IMobileBroadbandPinLockStateChange_Base = interface(IInspectable)
  ['{AA4A8700-9943-59A3-8647-D373FD5E0E2B}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IIterable_1__IMobileBroadbandPinLockStateChange = interface(IIterable_1__IMobileBroadbandPinLockStateChange_Base)
  ['{3876476B-DF73-551E-A695-2F70A4292032}']
    function First: IIterator_1__IMobileBroadbandPinLockStateChange; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChange>
  IVectorView_1__IMobileBroadbandPinLockStateChange = interface(IInspectable)
  ['{8AAE04EC-BB01-53AD-A97D-612EEE2A0D2A}']
    function GetAt(index: Cardinal): IMobileBroadbandPinLockStateChange; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMobileBroadbandPinLockStateChange; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMobileBroadbandPinLockStateChange): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandPinLockStateChangeTriggerDetails
  [WinRTClassNameAttribute(SMobileBroadbandPinLockStateChangeTriggerDetails)]
  IMobileBroadbandPinLockStateChangeTriggerDetails = interface(IInspectable)
  ['{D338C091-3E91-4D38-9036-AEE83A6E79AD}']
    function get_PinLockStateChanges: IVectorView_1__IMobileBroadbandPinLockStateChange; safecall;
    property PinLockStateChanges: IVectorView_1__IMobileBroadbandPinLockStateChange read get_PinLockStateChanges;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IMobileBroadbandDeviceServiceTriggerDetails
  [WinRTClassNameAttribute(SMobileBroadbandDeviceServiceTriggerDetails)]
  IMobileBroadbandDeviceServiceTriggerDetails = interface(IInspectable)
  ['{4A055B70-B9AE-4458-9241-A6A5FBF18A0C}']
    function get_DeviceId: HSTRING; safecall;
    function get_DeviceServiceId: TGuid; safecall;
    function get_ReceivedData: IBuffer; safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property DeviceServiceId: TGuid read get_DeviceServiceId;
    property ReceivedData: IBuffer read get_ReceivedData;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IKnownCSimFilePathsStatics
  [WinRTClassNameAttribute(SKnownCSimFilePaths)]
  IKnownCSimFilePathsStatics = interface(IInspectable)
  ['{B458AEED-49F1-4C22-B073-96D511BF9C35}']
    function get_EFSpn: IVectorView_1__Cardinal; safecall;
    function get_Gid1: IVectorView_1__Cardinal; safecall;
    function get_Gid2: IVectorView_1__Cardinal; safecall;
    property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    property Gid1: IVectorView_1__Cardinal read get_Gid1;
    property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IKnownRuimFilePathsStatics
  [WinRTClassNameAttribute(SKnownRuimFilePaths)]
  IKnownRuimFilePathsStatics = interface(IInspectable)
  ['{3883C8B9-FF24-4571-A867-09F960426E14}']
    function get_EFSpn: IVectorView_1__Cardinal; safecall;
    function get_Gid1: IVectorView_1__Cardinal; safecall;
    function get_Gid2: IVectorView_1__Cardinal; safecall;
    property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    property Gid1: IVectorView_1__Cardinal read get_Gid1;
    property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IKnownSimFilePathsStatics
  [WinRTClassNameAttribute(SKnownSimFilePaths)]
  IKnownSimFilePathsStatics = interface(IInspectable)
  ['{80CD1A63-37A5-43D3-80A3-CCD23E8FECEE}']
    function get_EFOns: IVectorView_1__Cardinal; safecall;
    function get_EFSpn: IVectorView_1__Cardinal; safecall;
    function get_Gid1: IVectorView_1__Cardinal; safecall;
    function get_Gid2: IVectorView_1__Cardinal; safecall;
    property EFOns: IVectorView_1__Cardinal read get_EFOns;
    property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    property Gid1: IVectorView_1__Cardinal read get_Gid1;
    property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IKnownUSimFilePathsStatics
  [WinRTClassNameAttribute(SKnownUSimFilePaths)]
  IKnownUSimFilePathsStatics = interface(IInspectable)
  ['{7C34E581-1F1B-43F4-9530-8B092D32D71F}']
    function get_EFSpn: IVectorView_1__Cardinal; safecall;
    function get_EFOpl: IVectorView_1__Cardinal; safecall;
    function get_EFPnn: IVectorView_1__Cardinal; safecall;
    function get_Gid1: IVectorView_1__Cardinal; safecall;
    function get_Gid2: IVectorView_1__Cardinal; safecall;
    property EFOpl: IVectorView_1__Cardinal read get_EFOpl;
    property EFPnn: IVectorView_1__Cardinal read get_EFPnn;
    property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    property Gid1: IVectorView_1__Cardinal read get_Gid1;
    property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult
  [WinRTClassNameAttribute(SHotspotCredentialsAuthenticationResult)]
  IHotspotCredentialsAuthenticationResult = interface(IInspectable)
  ['{E756C791-1005-4DE5-83C7-DE61D88831D0}']
    function get_HasNetworkErrorOccurred: Boolean; safecall;
    function get_ResponseCode: HotspotAuthenticationResponseCode; safecall;
    function get_LogoffUrl: IUriRuntimeClass; safecall;
    function get_AuthenticationReplyXml: Xml_Dom_IXmlDocument; safecall;
    property AuthenticationReplyXml: Xml_Dom_IXmlDocument read get_AuthenticationReplyXml;
    property HasNetworkErrorOccurred: Boolean read get_HasNetworkErrorOccurred;
    property LogoffUrl: IUriRuntimeClass read get_LogoffUrl;
    property ResponseCode: HotspotAuthenticationResponseCode read get_ResponseCode;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult_Delegate_Base = interface(IUnknown)
  ['{7F254BEB-471F-5000-94CE-102CC333055F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult = interface(AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult_Delegate_Base)
  ['{100A520E-981A-57A0-91FC-3F0B8D5D6ADB}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IHotspotCredentialsAuthenticationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  IAsyncOperation_1__IHotspotCredentialsAuthenticationResult_Base = interface(IInspectable)
  ['{522781D8-29C8-5D89-8937-1D1C2032F0C8}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IHotspotCredentialsAuthenticationResult>
  IAsyncOperation_1__IHotspotCredentialsAuthenticationResult = interface(IAsyncOperation_1__IHotspotCredentialsAuthenticationResult_Base)
  ['{19D48783-66B3-54E3-A880-38E143C588FA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult; safecall;
    function GetResults: IHotspotCredentialsAuthenticationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IHotspotCredentialsAuthenticationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults
  [WinRTClassNameAttribute(SProvisionFromXmlDocumentResults)]
  IProvisionFromXmlDocumentResults = interface(IInspectable)
  ['{217700E0-8203-11DF-ADB9-F4CE462D9137}']
    function get_AllElementsProvisioned: Boolean; safecall;
    function get_ProvisionResultsXml: HSTRING; safecall;
    property AllElementsProvisioned: Boolean read get_AllElementsProvisioned;
    property ProvisionResultsXml: HSTRING read get_ProvisionResultsXml;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IProvisionedProfile
  [WinRTClassNameAttribute(SProvisionedProfile)]
  IProvisionedProfile = interface(IInspectable)
  ['{217700E0-8202-11DF-ADB9-F4CE462D9137}']
    procedure UpdateCost(value: NetworkCostType); safecall;
    procedure UpdateUsage(value: ProfileUsage); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults_Delegate_Base = interface(IUnknown)
  ['{7A7EEE1B-17F9-5A41-861B-C30EA127D0F1}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults = interface(AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults_Delegate_Base)
  ['{77FF2BE3-9CFD-5034-89B9-FF78EFAFCB68}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IProvisionFromXmlDocumentResults; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  IAsyncOperation_1__IProvisionFromXmlDocumentResults_Base = interface(IInspectable)
  ['{9F8FE338-C6B1-5614-A14F-8977A77E17F2}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IProvisionFromXmlDocumentResults>
  IAsyncOperation_1__IProvisionFromXmlDocumentResults = interface(IAsyncOperation_1__IProvisionFromXmlDocumentResults_Base)
  ['{68AFF662-59AD-5B99-81EE-9AA2C780B858}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults; safecall;
    function GetResults: IProvisionFromXmlDocumentResults; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IProvisionFromXmlDocumentResults read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IProvisioningAgent
  [WinRTClassNameAttribute(SProvisioningAgent)]
  IProvisioningAgent = interface(IInspectable)
  ['{217700E0-8201-11DF-ADB9-F4CE462D9137}']
    function ProvisionFromXmlDocumentAsync(provisioningXmlDocument: HSTRING): IAsyncOperation_1__IProvisionFromXmlDocumentResults; safecall;
    function GetProvisionedProfile(mediaType: ProfileMediaType; profileName: HSTRING): IProvisionedProfile; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IProvisioningAgentStaticMethods
  [WinRTClassNameAttribute(SProvisioningAgent)]
  IProvisioningAgentStaticMethods = interface(IInspectable)
  ['{217700E0-8101-11DF-ADB9-F4CE462D9137}']
    function CreateFromNetworkAccountId(networkAccountId: HSTRING): IProvisioningAgent; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IUssdMessage
  [WinRTClassNameAttribute(SUssdMessage)]
  IUssdMessage = interface(IInspectable)
  ['{2F9ACF82-2004-4D5D-BF81-2ABA1B4BE4A8}']
    function get_DataCodingScheme: Byte; safecall;
    procedure put_DataCodingScheme(value: Byte); safecall;
    function GetPayload(resultSize: Cardinal; resultValue: PByte): HRESULT; stdcall;
    procedure SetPayload(valueSize: Cardinal; value: PByte); safecall;
    function get_PayloadAsText: HSTRING; safecall;
    procedure put_PayloadAsText(value: HSTRING); safecall;
    property DataCodingScheme: Byte read get_DataCodingScheme write put_DataCodingScheme;
    property PayloadAsText: HSTRING read get_PayloadAsText write put_PayloadAsText;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IUssdMessageFactory
  [WinRTClassNameAttribute(SUssdMessage)]
  IUssdMessageFactory = interface(IInspectable)
  ['{2F9ACF82-1003-4D5D-BF81-2ABA1B4BE4A8}']
    function CreateMessage(messageText: HSTRING): IUssdMessage; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IUssdReply
  [WinRTClassNameAttribute(SUssdReply)]
  IUssdReply = interface(IInspectable)
  ['{2F9ACF82-2005-4D5D-BF81-2ABA1B4BE4A8}']
    function get_ResultCode: UssdResultCode; safecall;
    function get_Message: IUssdMessage; safecall;
    property Message: IUssdMessage read get_Message;
    property ResultCode: UssdResultCode read get_ResultCode;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IUssdReply>
  AsyncOperationCompletedHandler_1__IUssdReply_Delegate_Base = interface(IUnknown)
  ['{9385BD8F-5E14-557A-A7F1-63F33D9ECACF}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.NetworkOperators.IUssdReply>
  AsyncOperationCompletedHandler_1__IUssdReply = interface(AsyncOperationCompletedHandler_1__IUssdReply_Delegate_Base)
  ['{354DAF3D-8EB1-5BEE-8710-2DF30BF322A0}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IUssdReply; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IUssdReply>
  IAsyncOperation_1__IUssdReply_Base = interface(IInspectable)
  ['{9DD0A063-6153-5AFD-8288-8770DDCFF2DB}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.NetworkOperators.IUssdReply>
  IAsyncOperation_1__IUssdReply = interface(IAsyncOperation_1__IUssdReply_Base)
  ['{032A3426-9808-53E4-8012-2C0A747442DA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IUssdReply); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IUssdReply; safecall;
    function GetResults: IUssdReply; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IUssdReply read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IUssdSession
  [WinRTClassNameAttribute(SUssdSession)]
  IUssdSession = interface(IInspectable)
  ['{2F9ACF82-2002-4D5D-BF81-2ABA1B4BE4A8}']
    function SendMessageAndGetReplyAsync(message: IUssdMessage): IAsyncOperation_1__IUssdReply; safecall;
    procedure Close; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.IUssdSessionStatics
  [WinRTClassNameAttribute(SUssdSession)]
  IUssdSessionStatics = interface(IInspectable)
  ['{2F9ACF82-1001-4D5D-BF81-2ABA1B4BE4A8}']
    function CreateFromNetworkAccountId(networkAccountId: HSTRING): IUssdSession; safecall;
    function CreateFromNetworkInterfaceId(networkInterfaceId: HSTRING): IUssdSession; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorNotificationEventDetails
  [WinRTClassNameAttribute(SNetworkOperatorNotificationEventDetails)]
  INetworkOperatorNotificationEventDetails = interface(IInspectable)
  ['{BC68A9D1-82E1-4488-9F2C-1276C2468FAC}']
    function get_NotificationType: NetworkOperatorEventMessageType; safecall;
    function get_NetworkAccountId: HSTRING; safecall;
    function get_EncodingType: Byte; safecall;
    function get_Message: HSTRING; safecall;
    function get_RuleId: HSTRING; safecall;
    function get_SmsMessage: ISmsMessage; safecall;
    property EncodingType: Byte read get_EncodingType;
    property Message: HSTRING read get_Message;
    property NetworkAccountId: HSTRING read get_NetworkAccountId;
    property NotificationType: NetworkOperatorEventMessageType read get_NotificationType;
    property RuleId: HSTRING read get_RuleId;
    property SmsMessage: ISmsMessage read get_SmsMessage;
  end;

  // DualAPI Interface
  // Windows.Networking.NetworkOperators.INetworkOperatorTetheringEntitlementCheck
  INetworkOperatorTetheringEntitlementCheck = interface(IInspectable)
  ['{0108916D-9E9A-4AF6-8DA3-60493B19C204}']
    procedure AuthorizeTethering(allow: Boolean; entitlementFailureReason: HSTRING); safecall;
  end;


  // Emit Forwarded classes
  // Windows.Networking.NetworkOperators.MobileBroadbandAccount
  // DualAPI
  TMobileBroadbandAccount = class(TWinRTGenericImportS<IMobileBroadbandAccountStatics>)
  public
    // -> IMobileBroadbandAccountStatics
    class function get_AvailableNetworkAccountIds: IVectorView_1__HSTRING; static; inline;
    class function CreateFromNetworkAccountId(networkAccountId: HSTRING): IMobileBroadbandAccount; static; inline;
    class property AvailableNetworkAccountIds: IVectorView_1__HSTRING read get_AvailableNetworkAccountIds;
  end;

  // Windows.Networking.NetworkOperators.MobileBroadbandNetwork
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceInformation
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandPinManager
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandUiccApp
  // DualAPI

  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringAccessPointConfiguration
  // DualAPI
  TNetworkOperatorTetheringAccessPointConfiguration = class(TWinRTGenericImportI<INetworkOperatorTetheringAccessPointConfiguration>) end;

  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult
  // DualAPI

  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager
  // DualAPI
  TNetworkOperatorTetheringManager = class(TWinRTGenericImportS2<INetworkOperatorTetheringManagerStatics, INetworkOperatorTetheringManagerStatics2>)
  public
    // -> INetworkOperatorTetheringManagerStatics
    class function GetTetheringCapability(networkAccountId: HSTRING): TetheringCapability; static; inline;
    class function CreateFromNetworkAccountId(networkAccountId: HSTRING): INetworkOperatorTetheringManager; static; inline;

    // -> INetworkOperatorTetheringManagerStatics2
    class function GetTetheringCapabilityFromConnectionProfile(profile: IConnectionProfile): TetheringCapability; static; inline;
    class function CreateFromConnectionProfile(profile: IConnectionProfile): INetworkOperatorTetheringManager; static; inline;
  end;

  // Windows.Networking.NetworkOperators.NetworkOperatorTetheringClient
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandAccountEventArgs
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandAccountUpdatedEventArgs
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandAccountWatcher
  // DualAPI
  TMobileBroadbandAccountWatcher = class(TWinRTGenericImportI<IMobileBroadbandAccountWatcher>) end;

  // Windows.Networking.NetworkOperators.MobileBroadbandModem
  // DualAPI
  TMobileBroadbandModem = class(TWinRTGenericImportS<IMobileBroadbandModemStatics>)
  public
    // -> IMobileBroadbandModemStatics
    class function GetDeviceSelector: HSTRING; static; inline;
    class function FromId(deviceId: HSTRING): IMobileBroadbandModem; static; inline;
    class function GetDefault: IMobileBroadbandModem; static; inline;
  end;

  // Windows.Networking.NetworkOperators.MobileBroadbandUicc
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandModemConfiguration
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceInformation
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceService
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandPin
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandPinOperationResult
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceDataSession
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandSession
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceCommandResult
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppsResult
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppRecordDetailsResult
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppReadRecordResult
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChange
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandNetworkRegistrationStateChangeTriggerDetails
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChange
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandRadioStateChangeTriggerDetails
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChange
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandPinLockStateChangeTriggerDetails
  // DualAPI

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceServiceTriggerDetails
  // DualAPI

  // Windows.Networking.NetworkOperators.KnownCSimFilePaths
  // DualAPI
  TKnownCSimFilePaths = class(TWinRTGenericImportS<IKnownCSimFilePathsStatics>)
  public
    // -> IKnownCSimFilePathsStatics
    class function get_EFSpn: IVectorView_1__Cardinal; static; inline;
    class function get_Gid1: IVectorView_1__Cardinal; static; inline;
    class function get_Gid2: IVectorView_1__Cardinal; static; inline;
    class property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    class property Gid1: IVectorView_1__Cardinal read get_Gid1;
    class property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // Windows.Networking.NetworkOperators.KnownRuimFilePaths
  // DualAPI
  TKnownRuimFilePaths = class(TWinRTGenericImportS<IKnownRuimFilePathsStatics>)
  public
    // -> IKnownRuimFilePathsStatics
    class function get_EFSpn: IVectorView_1__Cardinal; static; inline;
    class function get_Gid1: IVectorView_1__Cardinal; static; inline;
    class function get_Gid2: IVectorView_1__Cardinal; static; inline;
    class property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    class property Gid1: IVectorView_1__Cardinal read get_Gid1;
    class property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // Windows.Networking.NetworkOperators.KnownSimFilePaths
  // DualAPI
  TKnownSimFilePaths = class(TWinRTGenericImportS<IKnownSimFilePathsStatics>)
  public
    // -> IKnownSimFilePathsStatics
    class function get_EFOns: IVectorView_1__Cardinal; static; inline;
    class function get_EFSpn: IVectorView_1__Cardinal; static; inline;
    class function get_Gid1: IVectorView_1__Cardinal; static; inline;
    class function get_Gid2: IVectorView_1__Cardinal; static; inline;
    class property EFOns: IVectorView_1__Cardinal read get_EFOns;
    class property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    class property Gid1: IVectorView_1__Cardinal read get_Gid1;
    class property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // Windows.Networking.NetworkOperators.KnownUSimFilePaths
  // DualAPI
  TKnownUSimFilePaths = class(TWinRTGenericImportS<IKnownUSimFilePathsStatics>)
  public
    // -> IKnownUSimFilePathsStatics
    class function get_EFSpn: IVectorView_1__Cardinal; static; inline;
    class function get_EFOpl: IVectorView_1__Cardinal; static; inline;
    class function get_EFPnn: IVectorView_1__Cardinal; static; inline;
    class function get_Gid1: IVectorView_1__Cardinal; static; inline;
    class function get_Gid2: IVectorView_1__Cardinal; static; inline;
    class property EFOpl: IVectorView_1__Cardinal read get_EFOpl;
    class property EFPnn: IVectorView_1__Cardinal read get_EFPnn;
    class property EFSpn: IVectorView_1__Cardinal read get_EFSpn;
    class property Gid1: IVectorView_1__Cardinal read get_Gid1;
    class property Gid2: IVectorView_1__Cardinal read get_Gid2;
  end;

  // Windows.Networking.NetworkOperators.HotspotCredentialsAuthenticationResult
  // DualAPI

  // Windows.Networking.NetworkOperators.ProvisionFromXmlDocumentResults
  // DualAPI

  // Windows.Networking.NetworkOperators.ProvisionedProfile
  // DualAPI

  // Windows.Networking.NetworkOperators.ProvisioningAgent
  // DualAPI
  TProvisioningAgent = class(TWinRTGenericImportSI<IProvisioningAgentStaticMethods, IProvisioningAgent>)
  public
    // -> IProvisioningAgentStaticMethods
    class function CreateFromNetworkAccountId(networkAccountId: HSTRING): IProvisioningAgent; static; inline;
  end;

  // Windows.Networking.NetworkOperators.UssdMessage
  // DualAPI
  TUssdMessage = class(TWinRTGenericImportF<IUssdMessageFactory>)
  public
    // -> IUssdMessageFactory
    class function CreateMessage(messageText: HSTRING): IUssdMessage; static; inline;
  end;

  // Windows.Networking.NetworkOperators.UssdReply
  // DualAPI

  // Windows.Networking.NetworkOperators.UssdSession
  // DualAPI
  TUssdSession = class(TWinRTGenericImportS<IUssdSessionStatics>)
  public
    // -> IUssdSessionStatics
    class function CreateFromNetworkAccountId(networkAccountId: HSTRING): IUssdSession; static; inline;
    class function CreateFromNetworkInterfaceId(networkInterfaceId: HSTRING): IUssdSession; static; inline;
  end;

  // Windows.Networking.NetworkOperators.NetworkOperatorNotificationEventDetails
  // DualAPI


implementation

  // Emit Classes Implementation
 { TMobileBroadbandAccount }

class function TMobileBroadbandAccount.get_AvailableNetworkAccountIds: IVectorView_1__HSTRING;
begin
  Result := Statics.get_AvailableNetworkAccountIds;
end;

class function TMobileBroadbandAccount.CreateFromNetworkAccountId(networkAccountId: HSTRING): IMobileBroadbandAccount;
begin
  Result := Statics.CreateFromNetworkAccountId(networkAccountId);
end;


 { TNetworkOperatorTetheringAccessPointConfiguration }

 { TNetworkOperatorTetheringManager }

class function TNetworkOperatorTetheringManager.GetTetheringCapability(networkAccountId: HSTRING): TetheringCapability;
begin
  Result := Statics.GetTetheringCapability(networkAccountId);
end;

class function TNetworkOperatorTetheringManager.CreateFromNetworkAccountId(networkAccountId: HSTRING): INetworkOperatorTetheringManager;
begin
  Result := Statics.CreateFromNetworkAccountId(networkAccountId);
end;


class function TNetworkOperatorTetheringManager.GetTetheringCapabilityFromConnectionProfile(profile: IConnectionProfile): TetheringCapability;
begin
  Result := Statics2.GetTetheringCapabilityFromConnectionProfile(profile);
end;

class function TNetworkOperatorTetheringManager.CreateFromConnectionProfile(profile: IConnectionProfile): INetworkOperatorTetheringManager;
begin
  Result := Statics2.CreateFromConnectionProfile(profile);
end;


 { TMobileBroadbandAccountWatcher }

 { TMobileBroadbandModem }

class function TMobileBroadbandModem.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;

class function TMobileBroadbandModem.FromId(deviceId: HSTRING): IMobileBroadbandModem;
begin
  Result := Statics.FromId(deviceId);
end;

class function TMobileBroadbandModem.GetDefault: IMobileBroadbandModem;
begin
  Result := Statics.GetDefault;
end;


 { TKnownCSimFilePaths }

class function TKnownCSimFilePaths.get_EFSpn: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFSpn;
end;

class function TKnownCSimFilePaths.get_Gid1: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid1;
end;

class function TKnownCSimFilePaths.get_Gid2: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid2;
end;


 { TKnownRuimFilePaths }

class function TKnownRuimFilePaths.get_EFSpn: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFSpn;
end;

class function TKnownRuimFilePaths.get_Gid1: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid1;
end;

class function TKnownRuimFilePaths.get_Gid2: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid2;
end;


 { TKnownSimFilePaths }

class function TKnownSimFilePaths.get_EFOns: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFOns;
end;

class function TKnownSimFilePaths.get_EFSpn: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFSpn;
end;

class function TKnownSimFilePaths.get_Gid1: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid1;
end;

class function TKnownSimFilePaths.get_Gid2: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid2;
end;


 { TKnownUSimFilePaths }

class function TKnownUSimFilePaths.get_EFSpn: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFSpn;
end;

class function TKnownUSimFilePaths.get_EFOpl: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFOpl;
end;

class function TKnownUSimFilePaths.get_EFPnn: IVectorView_1__Cardinal;
begin
  Result := Statics.get_EFPnn;
end;

class function TKnownUSimFilePaths.get_Gid1: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid1;
end;

class function TKnownUSimFilePaths.get_Gid2: IVectorView_1__Cardinal;
begin
  Result := Statics.get_Gid2;
end;


 { TProvisioningAgent }

class function TProvisioningAgent.CreateFromNetworkAccountId(networkAccountId: HSTRING): IProvisioningAgent;
begin
  Result := Statics.CreateFromNetworkAccountId(networkAccountId);
end;


 { TUssdMessage }
// Factories for : "UssdMessage"
// Factory: "Windows.Networking.NetworkOperators.IUssdMessageFactory"
// -> IUssdMessageFactory

class function TUssdMessage.CreateMessage(messageText: HSTRING): IUssdMessage;
begin
  Result := Factory.CreateMessage(messageText);
end;


 { TUssdSession }

class function TUssdSession.CreateFromNetworkAccountId(networkAccountId: HSTRING): IUssdSession;
begin
  Result := Statics.CreateFromNetworkAccountId(networkAccountId);
end;

class function TUssdSession.CreateFromNetworkInterfaceId(networkInterfaceId: HSTRING): IUssdSession;
begin
  Result := Statics.CreateFromNetworkInterfaceId(networkInterfaceId);
end;



end.
