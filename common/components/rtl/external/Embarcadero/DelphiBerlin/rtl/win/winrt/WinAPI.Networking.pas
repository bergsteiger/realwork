{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Networking;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Security.Credentials,
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.Storage,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Networking Class Names
  // Windows.Networking.HostName
  // DualAPI
  SHostName = 'Windows.Networking.HostName';
  // Windows.Networking.EndpointPair
  // DualAPI
  SEndpointPair = 'Windows.Networking.EndpointPair';
  // Windows.Networking.XboxLive.XboxLiveDeviceAddress
  // DualAPI
  SXboxLive_XboxLiveDeviceAddress = 'Windows.Networking.XboxLive.XboxLiveDeviceAddress';
  // Windows.Networking.XboxLive.XboxLiveEndpointPair
  // DualAPI
  SXboxLive_XboxLiveEndpointPair = 'Windows.Networking.XboxLive.XboxLiveEndpointPair';
  // Windows.Networking.XboxLive.XboxLiveEndpointPairTemplate
  // DualAPI
  SXboxLive_XboxLiveEndpointPairTemplate = 'Windows.Networking.XboxLive.XboxLiveEndpointPairTemplate';
  // Windows.Networking.XboxLive.XboxLiveInboundEndpointPairCreatedEventArgs
  // DualAPI
  SXboxLive_XboxLiveInboundEndpointPairCreatedEventArgs = 'Windows.Networking.XboxLive.XboxLiveInboundEndpointPairCreatedEventArgs';
  // Windows.Networking.XboxLive.XboxLiveEndpointPairCreationResult
  // DualAPI
  SXboxLive_XboxLiveEndpointPairCreationResult = 'Windows.Networking.XboxLive.XboxLiveEndpointPairCreationResult';
  // Windows.Networking.XboxLive.XboxLiveEndpointPairStateChangedEventArgs
  // DualAPI
  SXboxLive_XboxLiveEndpointPairStateChangedEventArgs = 'Windows.Networking.XboxLive.XboxLiveEndpointPairStateChangedEventArgs';
  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetricResult
  // DualAPI
  SXboxLive_XboxLiveQualityOfServiceMetricResult = 'Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetricResult';
  // Windows.Networking.XboxLive.XboxLiveQualityOfServicePrivatePayloadResult
  // DualAPI
  SXboxLive_XboxLiveQualityOfServicePrivatePayloadResult = 'Windows.Networking.XboxLive.XboxLiveQualityOfServicePrivatePayloadResult';
  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMeasurement
  // DualAPI
  SXboxLive_XboxLiveQualityOfServiceMeasurement = 'Windows.Networking.XboxLive.XboxLiveQualityOfServiceMeasurement';


type
  // Forward declare interfaces
  // Windows.Networking.IHostName
  IHostName = interface;
  PIHostName = ^IHostName;

  // Windows.Networking.IEndpointPair
  IEndpointPair = interface;
  PIEndpointPair = ^IEndpointPair;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.IEndpointPair>
  IIterator_1__IEndpointPair = interface;
  PIIterator_1__IEndpointPair = ^IIterator_1__IEndpointPair;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IEndpointPair>
  IIterable_1__IEndpointPair = interface;
  PIIterable_1__IEndpointPair = ^IIterable_1__IEndpointPair;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>
  IVectorView_1__IEndpointPair = interface;
  PIVectorView_1__IEndpointPair = ^IVectorView_1__IEndpointPair;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.IHostName>
  IIterator_1__IHostName = interface;
  PIIterator_1__IHostName = ^IIterator_1__IHostName;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IHostName>
  IIterable_1__IHostName = interface;
  PIIterable_1__IHostName = ^IIterable_1__IHostName;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IHostName>
  IVectorView_1__IHostName = interface;
  PIVectorView_1__IHostName = ^IVectorView_1__IHostName;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair = ^AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  IAsyncOperation_1__IVectorView_1__IEndpointPair = interface;
  PIAsyncOperation_1__IVectorView_1__IEndpointPair = ^IAsyncOperation_1__IVectorView_1__IEndpointPair;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.IHostName>
  IVector_1__IHostName = interface;
  PIVector_1__IHostName = ^IVector_1__IHostName;

  // Windows.Networking.IHostNameStatics
  IHostNameStatics = interface;
  PIHostNameStatics = ^IHostNameStatics;

  // Windows.Networking.IHostNameFactory
  IHostNameFactory = interface;
  PIHostNameFactory = ^IHostNameFactory;

  // Windows.Networking.IEndpointPairFactory
  IEndpointPairFactory = interface;
  PIEndpointPairFactory = ^IEndpointPairFactory;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveDeviceAddress,Object>
  TypedEventHandler_2__XboxLive_IXboxLiveDeviceAddress__IInspectable = interface;
  PTypedEventHandler_2__XboxLive_IXboxLiveDeviceAddress__IInspectable = ^TypedEventHandler_2__XboxLive_IXboxLiveDeviceAddress__IInspectable;

  // Windows.Networking.XboxLive.IXboxLiveDeviceAddress
  XboxLive_IXboxLiveDeviceAddress = interface;
  PXboxLive_IXboxLiveDeviceAddress = ^XboxLive_IXboxLiveDeviceAddress;

  // Windows.Networking.XboxLive.IXboxLiveDeviceAddressStatics
  XboxLive_IXboxLiveDeviceAddressStatics = interface;
  PXboxLive_IXboxLiveDeviceAddressStatics = ^XboxLive_IXboxLiveDeviceAddressStatics;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPairStateChangedEventArgs
  XboxLive_IXboxLiveEndpointPairStateChangedEventArgs = interface;
  PXboxLive_IXboxLiveEndpointPairStateChangedEventArgs = ^XboxLive_IXboxLiveEndpointPairStateChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveEndpointPair,Windows.Networking.XboxLive.IXboxLiveEndpointPairStateChangedEventArgs>
  TypedEventHandler_2__XboxLive_IXboxLiveEndpointPair__XboxLive_IXboxLiveEndpointPairStateChangedEventArgs = interface;
  PTypedEventHandler_2__XboxLive_IXboxLiveEndpointPair__XboxLive_IXboxLiveEndpointPairStateChangedEventArgs = ^TypedEventHandler_2__XboxLive_IXboxLiveEndpointPair__XboxLive_IXboxLiveEndpointPairStateChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate,Windows.Networking.XboxLive.IXboxLiveInboundEndpointPairCreatedEventArgs>
  TypedEventHandler_2__XboxLive_IXboxLiveEndpointPairTemplate__XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = interface;
  PTypedEventHandler_2__XboxLive_IXboxLiveEndpointPairTemplate__XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = ^TypedEventHandler_2__XboxLive_IXboxLiveEndpointPairTemplate__XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult
  XboxLive_IXboxLiveEndpointPairCreationResult = interface;
  PXboxLive_IXboxLiveEndpointPairCreationResult = ^XboxLive_IXboxLiveEndpointPairCreationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult>
  AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult = ^AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult>
  IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult = interface;
  PIAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult = ^IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IIterator_1__XboxLive_IXboxLiveEndpointPair = interface;
  PIIterator_1__XboxLive_IXboxLiveEndpointPair = ^IIterator_1__XboxLive_IXboxLiveEndpointPair;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IIterable_1__XboxLive_IXboxLiveEndpointPair = interface;
  PIIterable_1__XboxLive_IXboxLiveEndpointPair = ^IIterable_1__XboxLive_IXboxLiveEndpointPair;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IVectorView_1__XboxLive_IXboxLiveEndpointPair = interface;
  PIVectorView_1__XboxLive_IXboxLiveEndpointPair = ^IVectorView_1__XboxLive_IXboxLiveEndpointPair;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate
  XboxLive_IXboxLiveEndpointPairTemplate = interface;
  PXboxLive_IXboxLiveEndpointPairTemplate = ^XboxLive_IXboxLiveEndpointPairTemplate;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPair
  XboxLive_IXboxLiveEndpointPair = interface;
  PXboxLive_IXboxLiveEndpointPair = ^XboxLive_IXboxLiveEndpointPair;

  // Windows.Networking.XboxLive.IXboxLiveInboundEndpointPairCreatedEventArgs
  XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = interface;
  PXboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = ^XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IIterator_1__XboxLive_IXboxLiveEndpointPairTemplate = interface;
  PIIterator_1__XboxLive_IXboxLiveEndpointPairTemplate = ^IIterator_1__XboxLive_IXboxLiveEndpointPairTemplate;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IIterable_1__XboxLive_IXboxLiveEndpointPairTemplate = interface;
  PIIterable_1__XboxLive_IXboxLiveEndpointPairTemplate = ^IIterable_1__XboxLive_IXboxLiveEndpointPairTemplate;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate = interface;
  PIVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate = ^IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplateStatics
  XboxLive_IXboxLiveEndpointPairTemplateStatics = interface;
  PXboxLive_IXboxLiveEndpointPairTemplateStatics = ^XboxLive_IXboxLiveEndpointPairTemplateStatics;

  // Windows.Networking.XboxLive.IXboxLiveEndpointPairStatics
  XboxLive_IXboxLiveEndpointPairStatics = interface;
  PXboxLive_IXboxLiveEndpointPairStatics = ^XboxLive_IXboxLiveEndpointPairStatics;

  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult
  XboxLive_IXboxLiveQualityOfServiceMetricResult = interface;
  PXboxLive_IXboxLiveQualityOfServiceMetricResult = ^XboxLive_IXboxLiveQualityOfServiceMetricResult;

  // Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult
  XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface;
  PXboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = ^XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult;

  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMeasurementStatics
  XboxLive_IXboxLiveQualityOfServiceMeasurementStatics = interface;
  PXboxLive_IXboxLiveQualityOfServiceMeasurementStatics = ^XboxLive_IXboxLiveQualityOfServiceMeasurementStatics;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IIterator_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface;
  PIIterator_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = ^IIterator_1__XboxLive_IXboxLiveQualityOfServiceMetricResult;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IIterable_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface;
  PIIterable_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = ^IIterable_1__XboxLive_IXboxLiveQualityOfServiceMetricResult;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface;
  PIVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = ^IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IIterator_1__XboxLive_XboxLiveQualityOfServiceMetric = interface;
  PIIterator_1__XboxLive_XboxLiveQualityOfServiceMetric = ^IIterator_1__XboxLive_XboxLiveQualityOfServiceMetric;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IIterable_1__XboxLive_XboxLiveQualityOfServiceMetric = interface;
  PIIterable_1__XboxLive_XboxLiveQualityOfServiceMetric = ^IIterable_1__XboxLive_XboxLiveQualityOfServiceMetric;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IVectorView_1__XboxLive_XboxLiveQualityOfServiceMetric = interface;
  PIVectorView_1__XboxLive_XboxLiveQualityOfServiceMetric = ^IVectorView_1__XboxLive_XboxLiveQualityOfServiceMetric;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IVector_1__XboxLive_XboxLiveQualityOfServiceMetric = interface;
  PIVector_1__XboxLive_XboxLiveQualityOfServiceMetric = ^IVector_1__XboxLive_XboxLiveQualityOfServiceMetric;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IIterator_1__XboxLive_IXboxLiveDeviceAddress = interface;
  PIIterator_1__XboxLive_IXboxLiveDeviceAddress = ^IIterator_1__XboxLive_IXboxLiveDeviceAddress;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IIterable_1__XboxLive_IXboxLiveDeviceAddress = interface;
  PIIterable_1__XboxLive_IXboxLiveDeviceAddress = ^IIterable_1__XboxLive_IXboxLiveDeviceAddress;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IVectorView_1__XboxLive_IXboxLiveDeviceAddress = interface;
  PIVectorView_1__XboxLive_IXboxLiveDeviceAddress = ^IVectorView_1__XboxLive_IXboxLiveDeviceAddress;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IVector_1__XboxLive_IXboxLiveDeviceAddress = interface;
  PIVector_1__XboxLive_IXboxLiveDeviceAddress = ^IVector_1__XboxLive_IXboxLiveDeviceAddress;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IIterator_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface;
  PIIterator_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = ^IIterator_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IIterable_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface;
  PIIterable_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = ^IIterable_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface;
  PIVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = ^IVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult;

  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMeasurement
  XboxLive_IXboxLiveQualityOfServiceMeasurement = interface;
  PXboxLive_IXboxLiveQualityOfServiceMeasurement = ^XboxLive_IXboxLiveQualityOfServiceMeasurement;


  // Emit Forwarded interfaces
  // Windows.Networking Interfaces
  // DualAPI Interface
  // Windows.Networking.IHostName
  [WinRTClassNameAttribute(SHostName)]
  IHostName = interface(IInspectable)
  ['{BF8ECAAD-ED96-49A7-9084-D416CAE88DCB}']
    function get_IPInformation: IInspectable{IIPInformation}; safecall;
    function get_RawName: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_CanonicalName: HSTRING; safecall;
    function get_Type: HostNameType; safecall;
    function IsEqual(hostName: IHostName): Boolean; safecall;
    property CanonicalName: HSTRING read get_CanonicalName;
    property DisplayName: HSTRING read get_DisplayName;
    property IPInformation: IInspectable{IIPInformation} read get_IPInformation;
    property RawName: HSTRING read get_RawName;
    property &Type: HostNameType read get_Type;
  end;

  // DualAPI Interface
  // Windows.Networking.IEndpointPair
  [WinRTClassNameAttribute(SEndpointPair)]
  IEndpointPair = interface(IInspectable)
  ['{33A0AA36-F8FA-4B30-B856-76517C3BD06D}']
    function get_LocalHostName: IHostName; safecall;
    procedure put_LocalHostName(value: IHostName); safecall;
    function get_LocalServiceName: HSTRING; safecall;
    procedure put_LocalServiceName(value: HSTRING); safecall;
    function get_RemoteHostName: IHostName; safecall;
    procedure put_RemoteHostName(value: IHostName); safecall;
    function get_RemoteServiceName: HSTRING; safecall;
    procedure put_RemoteServiceName(value: HSTRING); safecall;
    property LocalHostName: IHostName read get_LocalHostName write put_LocalHostName;
    property LocalServiceName: HSTRING read get_LocalServiceName write put_LocalServiceName;
    property RemoteHostName: IHostName read get_RemoteHostName write put_RemoteHostName;
    property RemoteServiceName: HSTRING read get_RemoteServiceName write put_RemoteServiceName;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.IEndpointPair>
  IIterator_1__IEndpointPair = interface(IInspectable)
  ['{485A4E12-55E5-5021-9EF2-C641FC5DD7AA}']
    function get_Current: IEndpointPair; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIEndpointPair): Cardinal; safecall;
    property Current: IEndpointPair read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IEndpointPair>
  IIterable_1__IEndpointPair_Base = interface(IInspectable)
  ['{D7EC83C4-A17B-51BF-8997-AA33B9102DC9}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IEndpointPair>
  IIterable_1__IEndpointPair = interface(IIterable_1__IEndpointPair_Base)
  ['{4DC02A52-9EF2-50EB-85BC-412FE0370355}']
    function First: IIterator_1__IEndpointPair; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>
  IVectorView_1__IEndpointPair = interface(IInspectable)
  ['{C1DD3EA0-5F59-5BA6-B7B2-58413F0FAA36}']
    function GetAt(index: Cardinal): IEndpointPair; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IEndpointPair; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIEndpointPair): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.IHostName>
  IIterator_1__IHostName = interface(IInspectable)
  ['{9AFF90FF-F758-5D63-A5D5-DC7C9F7C0179}']
    function get_Current: IHostName; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIHostName): Cardinal; safecall;
    property Current: IHostName read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IHostName>
  IIterable_1__IHostName_Base = interface(IInspectable)
  ['{9E5F3ED0-CF1C-5D38-832C-ACEA6164BF5C}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.IHostName>
  IIterable_1__IHostName = interface(IIterable_1__IHostName_Base)
  ['{74DEE455-E95C-5DEC-92A4-97C33B8A2AD1}']
    function First: IIterator_1__IHostName; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IHostName>
  IVectorView_1__IHostName = interface(IInspectable)
  ['{FB26F077-BEFF-523E-81C2-5A710F18359D}']
    function GetAt(index: Cardinal): IHostName; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IHostName; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIHostName): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair_Delegate_Base = interface(IUnknown)
  ['{20D6FAAB-3B8E-5A1F-8397-B01CB219A18D}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair_Delegate_Base)
  ['{69395ED9-F36A-524C-8937-BFECF69B2C9E}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IEndpointPair; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  IAsyncOperation_1__IVectorView_1__IEndpointPair_Base = interface(IInspectable)
  ['{AFC2FF8E-E393-566A-89C4-D043E940050D}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Networking.IEndpointPair>>
  IAsyncOperation_1__IVectorView_1__IEndpointPair = interface(IAsyncOperation_1__IVectorView_1__IEndpointPair_Base)
  ['{8E5932D3-2F98-5261-9A31-A5B09CB2B0E2}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair; safecall;
    function GetResults: IVectorView_1__IEndpointPair; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IEndpointPair read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.IHostName>
  IVector_1__IHostName = interface(IInspectable)
  ['{BDBBDC0E-445B-5239-A7A4-DBB889EDE179}']
    function GetAt(index: Cardinal): IHostName; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IHostName; safecall;
    function IndexOf(value: IHostName; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IHostName); safecall;
    procedure InsertAt(index: Cardinal; value: IHostName); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IHostName); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIHostName): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIHostName); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.IHostNameStatics
  [WinRTClassNameAttribute(SHostName)]
  IHostNameStatics = interface(IInspectable)
  ['{F68CD4BF-A388-4E8B-91EA-54DD6DD901C0}']
    function Compare(value1: HSTRING; value2: HSTRING): Integer; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.IHostNameFactory
  [WinRTClassNameAttribute(SHostName)]
  IHostNameFactory = interface(IInspectable)
  ['{458C23ED-712F-4576-ADF1-C20B2C643558}']
    function CreateHostName(hostName: HSTRING): IHostName; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.IEndpointPairFactory
  [WinRTClassNameAttribute(SEndpointPair)]
  IEndpointPairFactory = interface(IInspectable)
  ['{B609D971-64E0-442B-AA6F-CC8C8F181F78}']
    function CreateEndpointPair(localHostName: IHostName; localServiceName: HSTRING; remoteHostName: IHostName; remoteServiceName: HSTRING): IEndpointPair; safecall;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveDeviceAddress,Object>
  TypedEventHandler_2__XboxLive_IXboxLiveDeviceAddress__IInspectable = interface(IUnknown)
  ['{92EA8704-9C9B-54FB-985D-886447BE838F}']
    procedure Invoke(sender: XboxLive_IXboxLiveDeviceAddress; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveDeviceAddress
  [WinRTClassNameAttribute(SXboxLive_XboxLiveDeviceAddress)]
  XboxLive_IXboxLiveDeviceAddress = interface(IInspectable)
  ['{F5BBD279-3C86-4B57-A31A-B9462408FD01}']
    function add_SnapshotChanged(handler: TypedEventHandler_2__XboxLive_IXboxLiveDeviceAddress__IInspectable): EventRegistrationToken; safecall;
    procedure remove_SnapshotChanged(token: EventRegistrationToken); safecall;
    function GetSnapshotAsBase64: HSTRING; safecall;
    function GetSnapshotAsBuffer: IBuffer; safecall;
    procedure GetSnapshotAsBytes(bufferSize: Cardinal; buffer: PByte; out bytesWritten: Cardinal); safecall;
    function Compare(otherDeviceAddress: XboxLive_IXboxLiveDeviceAddress): Integer; safecall;
    function get_IsValid: Boolean; safecall;
    function get_IsLocal: Boolean; safecall;
    function get_NetworkAccessKind: XboxLive_XboxLiveNetworkAccessKind; safecall;
    property IsLocal: Boolean read get_IsLocal;
    property IsValid: Boolean read get_IsValid;
    property NetworkAccessKind: XboxLive_XboxLiveNetworkAccessKind read get_NetworkAccessKind;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveDeviceAddressStatics
  [WinRTClassNameAttribute(SXboxLive_XboxLiveDeviceAddress)]
  XboxLive_IXboxLiveDeviceAddressStatics = interface(IInspectable)
  ['{5954A819-4A79-4931-827C-7F503E963263}']
    function CreateFromSnapshotBase64(base64: HSTRING): XboxLive_IXboxLiveDeviceAddress; safecall;
    function CreateFromSnapshotBuffer(buffer: IBuffer): XboxLive_IXboxLiveDeviceAddress; safecall;
    function CreateFromSnapshotBytes(bufferSize: Cardinal; buffer: PByte): XboxLive_IXboxLiveDeviceAddress; safecall;
    function GetLocal: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_MaxSnapshotBytesSize: Cardinal; safecall;
    property MaxSnapshotBytesSize: Cardinal read get_MaxSnapshotBytesSize;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPairStateChangedEventArgs
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPairStateChangedEventArgs)]
  XboxLive_IXboxLiveEndpointPairStateChangedEventArgs = interface(IInspectable)
  ['{592E3B55-DE08-44E7-AC3B-B9B9A169583A}']
    function get_OldState: XboxLive_XboxLiveEndpointPairState; safecall;
    function get_NewState: XboxLive_XboxLiveEndpointPairState; safecall;
    property NewState: XboxLive_XboxLiveEndpointPairState read get_NewState;
    property OldState: XboxLive_XboxLiveEndpointPairState read get_OldState;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveEndpointPair,Windows.Networking.XboxLive.IXboxLiveEndpointPairStateChangedEventArgs>
  TypedEventHandler_2__XboxLive_IXboxLiveEndpointPair__XboxLive_IXboxLiveEndpointPairStateChangedEventArgs = interface(IUnknown)
  ['{9FD6BED1-AAC6-53F0-98AF-DA7301D08A60}']
    procedure Invoke(sender: XboxLive_IXboxLiveEndpointPair; args: XboxLive_IXboxLiveEndpointPairStateChangedEventArgs); safecall;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate,Windows.Networking.XboxLive.IXboxLiveInboundEndpointPairCreatedEventArgs>
  TypedEventHandler_2__XboxLive_IXboxLiveEndpointPairTemplate__XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = interface(IUnknown)
  ['{51B4BE05-E802-5722-AECE-A3E01AA14D97}']
    procedure Invoke(sender: XboxLive_IXboxLiveEndpointPairTemplate; args: XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPairCreationResult)]
  XboxLive_IXboxLiveEndpointPairCreationResult = interface(IInspectable)
  ['{D9A8BB95-2AAB-4D1E-9794-33ECC0DCF0FE}']
    function get_DeviceAddress: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_Status: XboxLive_XboxLiveEndpointPairCreationStatus; safecall;
    function get_IsExistingPathEvaluation: Boolean; safecall;
    function get_EndpointPair: XboxLive_IXboxLiveEndpointPair; safecall;
    property DeviceAddress: XboxLive_IXboxLiveDeviceAddress read get_DeviceAddress;
    property EndpointPair: XboxLive_IXboxLiveEndpointPair read get_EndpointPair;
    property IsExistingPathEvaluation: Boolean read get_IsExistingPathEvaluation;
    property Status: XboxLive_XboxLiveEndpointPairCreationStatus read get_Status;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult>
  AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult = interface(IUnknown)
  ['{7DD008DD-A716-53C2-964D-C878CFA95EAB}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairCreationResult>
  IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult = interface(IInspectable)
  ['{CE32A8C2-B160-5985-90A9-C9B298647E7F}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult; safecall;
    function GetResults: XboxLive_IXboxLiveEndpointPairCreationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_IXboxLiveEndpointPairCreationResult read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IIterator_1__XboxLive_IXboxLiveEndpointPair = interface(IInspectable)
  ['{59B4F20B-B3F0-531F-B6BF-3B42EF1643C9}']
    function get_Current: XboxLive_IXboxLiveEndpointPair; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_IXboxLiveEndpointPair): Cardinal; safecall;
    property Current: XboxLive_IXboxLiveEndpointPair read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IIterable_1__XboxLive_IXboxLiveEndpointPair = interface(IInspectable)
  ['{CA2C55D1-F577-541E-ADF2-01F89AF0AC18}']
    function First: IIterator_1__XboxLive_IXboxLiveEndpointPair; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveEndpointPair>
  IVectorView_1__XboxLive_IXboxLiveEndpointPair = interface(IInspectable)
  ['{76EE6AB6-3DB4-5C04-9548-46CA05FA4E3A}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveEndpointPair; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_IXboxLiveEndpointPair; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveEndpointPair): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPairTemplate)]
  XboxLive_IXboxLiveEndpointPairTemplate = interface(IInspectable)
  ['{6B286ECF-3457-40CE-B9A1-C0CFE0213EA7}']
    function add_InboundEndpointPairCreated(handler: TypedEventHandler_2__XboxLive_IXboxLiveEndpointPairTemplate__XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs): EventRegistrationToken; safecall;
    procedure remove_InboundEndpointPairCreated(token: EventRegistrationToken); safecall;
    function CreateEndpointPairAsync(deviceAddress: XboxLive_IXboxLiveDeviceAddress): IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult; overload; safecall;
    function CreateEndpointPairAsync(deviceAddress: XboxLive_IXboxLiveDeviceAddress; behaviors: XboxLive_XboxLiveEndpointPairCreationBehaviors): IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult; overload; safecall;
    function CreateEndpointPairForPortsAsync(deviceAddress: XboxLive_IXboxLiveDeviceAddress; initiatorPort: HSTRING; acceptorPort: HSTRING): IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult; overload; safecall;
    function CreateEndpointPairForPortsAsync(deviceAddress: XboxLive_IXboxLiveDeviceAddress; initiatorPort: HSTRING; acceptorPort: HSTRING; behaviors: XboxLive_XboxLiveEndpointPairCreationBehaviors): IAsyncOperation_1__XboxLive_IXboxLiveEndpointPairCreationResult; overload; safecall;
    function get_Name: HSTRING; safecall;
    function get_SocketKind: XboxLive_XboxLiveSocketKind; safecall;
    function get_InitiatorBoundPortRangeLower: Word; safecall;
    function get_InitiatorBoundPortRangeUpper: Word; safecall;
    function get_AcceptorBoundPortRangeLower: Word; safecall;
    function get_AcceptorBoundPortRangeUpper: Word; safecall;
    function get_EndpointPairs: IVectorView_1__XboxLive_IXboxLiveEndpointPair; safecall;
    property AcceptorBoundPortRangeLower: Word read get_AcceptorBoundPortRangeLower;
    property AcceptorBoundPortRangeUpper: Word read get_AcceptorBoundPortRangeUpper;
    property EndpointPairs: IVectorView_1__XboxLive_IXboxLiveEndpointPair read get_EndpointPairs;
    property InitiatorBoundPortRangeLower: Word read get_InitiatorBoundPortRangeLower;
    property InitiatorBoundPortRangeUpper: Word read get_InitiatorBoundPortRangeUpper;
    property Name: HSTRING read get_Name;
    property SocketKind: XboxLive_XboxLiveSocketKind read get_SocketKind;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPair
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPair)]
  XboxLive_IXboxLiveEndpointPair = interface(IInspectable)
  ['{1E9A839B-813E-44E0-B87F-C87A093475E4}']
    function add_StateChanged(handler: TypedEventHandler_2__XboxLive_IXboxLiveEndpointPair__XboxLive_IXboxLiveEndpointPairStateChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StateChanged(token: EventRegistrationToken); safecall;
    function DeleteAsync: IAsyncAction; safecall;
    procedure GetRemoteSocketAddressBytes(socketAddressSize: Cardinal; socketAddress: PByte); safecall;
    procedure GetLocalSocketAddressBytes(socketAddressSize: Cardinal; socketAddress: PByte); safecall;
    function get_State: XboxLive_XboxLiveEndpointPairState; safecall;
    function get_Template: XboxLive_IXboxLiveEndpointPairTemplate; safecall;
    function get_RemoteDeviceAddress: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_RemoteHostName: IHostName; safecall;
    function get_RemotePort: HSTRING; safecall;
    function get_LocalHostName: IHostName; safecall;
    function get_LocalPort: HSTRING; safecall;
    property LocalHostName: IHostName read get_LocalHostName;
    property LocalPort: HSTRING read get_LocalPort;
    property RemoteDeviceAddress: XboxLive_IXboxLiveDeviceAddress read get_RemoteDeviceAddress;
    property RemoteHostName: IHostName read get_RemoteHostName;
    property RemotePort: HSTRING read get_RemotePort;
    property State: XboxLive_XboxLiveEndpointPairState read get_State;
    property Template: XboxLive_IXboxLiveEndpointPairTemplate read get_Template;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveInboundEndpointPairCreatedEventArgs
  [WinRTClassNameAttribute(SXboxLive_XboxLiveInboundEndpointPairCreatedEventArgs)]
  XboxLive_IXboxLiveInboundEndpointPairCreatedEventArgs = interface(IInspectable)
  ['{DC183B62-22BA-48D2-80DE-C23968BD198B}']
    function get_EndpointPair: XboxLive_IXboxLiveEndpointPair; safecall;
    property EndpointPair: XboxLive_IXboxLiveEndpointPair read get_EndpointPair;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IIterator_1__XboxLive_IXboxLiveEndpointPairTemplate = interface(IInspectable)
  ['{E2620202-4E6F-5CBA-8550-59CC5F79737B}']
    function get_Current: XboxLive_IXboxLiveEndpointPairTemplate; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_IXboxLiveEndpointPairTemplate): Cardinal; safecall;
    property Current: XboxLive_IXboxLiveEndpointPairTemplate read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IIterable_1__XboxLive_IXboxLiveEndpointPairTemplate = interface(IInspectable)
  ['{348BD365-326D-5535-A7A3-FE5A9DF3885C}']
    function First: IIterator_1__XboxLive_IXboxLiveEndpointPairTemplate; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplate>
  IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate = interface(IInspectable)
  ['{E83B97D1-36E3-5AD7-9919-7D25D4A44E7A}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveEndpointPairTemplate; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_IXboxLiveEndpointPairTemplate; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveEndpointPairTemplate): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPairTemplateStatics
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPairTemplate)]
  XboxLive_IXboxLiveEndpointPairTemplateStatics = interface(IInspectable)
  ['{1E13137B-737B-4A23-BC64-0870F75655BA}']
    function GetTemplateByName(name: HSTRING): XboxLive_IXboxLiveEndpointPairTemplate; safecall;
    function get_Templates: IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate; safecall;
    property Templates: IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate read get_Templates;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveEndpointPairStatics
  [WinRTClassNameAttribute(SXboxLive_XboxLiveEndpointPair)]
  XboxLive_IXboxLiveEndpointPairStatics = interface(IInspectable)
  ['{64316B30-217A-4243-8EE1-6729281D27DB}']
    function FindEndpointPairBySocketAddressBytes(localSocketAddressSize: Cardinal; localSocketAddress: PByte; remoteSocketAddress: Byte): XboxLive_IXboxLiveEndpointPair; safecall;
    function FindEndpointPairByHostNamesAndPorts(localHostName: IHostName; localPort: HSTRING; remoteHostName: IHostName; remotePort: HSTRING): XboxLive_IXboxLiveEndpointPair; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult
  [WinRTClassNameAttribute(SXboxLive_XboxLiveQualityOfServiceMetricResult)]
  XboxLive_IXboxLiveQualityOfServiceMetricResult = interface(IInspectable)
  ['{AEEC53D1-3561-4782-B0CF-D3AE29D9FA87}']
    function get_Status: XboxLive_XboxLiveQualityOfServiceMeasurementStatus; safecall;
    function get_DeviceAddress: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_Metric: XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function get_Value: UInt64; safecall;
    property DeviceAddress: XboxLive_IXboxLiveDeviceAddress read get_DeviceAddress;
    property Metric: XboxLive_XboxLiveQualityOfServiceMetric read get_Metric;
    property Status: XboxLive_XboxLiveQualityOfServiceMeasurementStatus read get_Status;
    property Value: UInt64 read get_Value;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult
  [WinRTClassNameAttribute(SXboxLive_XboxLiveQualityOfServicePrivatePayloadResult)]
  XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface(IInspectable)
  ['{5A6302AE-6F38-41C0-9FCC-EA6CB978CAFC}']
    function get_Status: XboxLive_XboxLiveQualityOfServiceMeasurementStatus; safecall;
    function get_DeviceAddress: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_Value: IBuffer; safecall;
    property DeviceAddress: XboxLive_IXboxLiveDeviceAddress read get_DeviceAddress;
    property Status: XboxLive_XboxLiveQualityOfServiceMeasurementStatus read get_Status;
    property Value: IBuffer read get_Value;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMeasurementStatics
  [WinRTClassNameAttribute(SXboxLive_XboxLiveQualityOfServiceMeasurement)]
  XboxLive_IXboxLiveQualityOfServiceMeasurementStatics = interface(IInspectable)
  ['{6E352DCA-23CF-440A-B077-5E30857A8234}']
    procedure PublishPrivatePayloadBytes(payloadSize: Cardinal; payload: PByte); safecall;
    procedure ClearPrivatePayload; safecall;
    function get_MaxSimultaneousProbeConnections: Cardinal; safecall;
    procedure put_MaxSimultaneousProbeConnections(value: Cardinal); safecall;
    function get_IsSystemOutboundBandwidthConstrained: Boolean; safecall;
    procedure put_IsSystemOutboundBandwidthConstrained(value: Boolean); safecall;
    function get_IsSystemInboundBandwidthConstrained: Boolean; safecall;
    procedure put_IsSystemInboundBandwidthConstrained(value: Boolean); safecall;
    function get_PublishedPrivatePayload: IBuffer; safecall;
    procedure put_PublishedPrivatePayload(value: IBuffer); safecall;
    function get_MaxPrivatePayloadSize: Cardinal; safecall;
    property IsSystemInboundBandwidthConstrained: Boolean read get_IsSystemInboundBandwidthConstrained write put_IsSystemInboundBandwidthConstrained;
    property IsSystemOutboundBandwidthConstrained: Boolean read get_IsSystemOutboundBandwidthConstrained write put_IsSystemOutboundBandwidthConstrained;
    property MaxPrivatePayloadSize: Cardinal read get_MaxPrivatePayloadSize;
    property MaxSimultaneousProbeConnections: Cardinal read get_MaxSimultaneousProbeConnections write put_MaxSimultaneousProbeConnections;
    property PublishedPrivatePayload: IBuffer read get_PublishedPrivatePayload write put_PublishedPrivatePayload;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IIterator_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface(IInspectable)
  ['{1950D722-133A-5C7E-A0B3-E99224EBCF4B}']
    function get_Current: XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_IXboxLiveQualityOfServiceMetricResult): Cardinal; safecall;
    property Current: XboxLive_IXboxLiveQualityOfServiceMetricResult read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IIterable_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface(IInspectable)
  ['{2D6643AF-8545-5FC5-A84E-1D7CDFA8E366}']
    function First: IIterator_1__XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMetricResult>
  IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult = interface(IInspectable)
  ['{2280991F-95D7-5E86-80F1-AD73F0B8D66D}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_IXboxLiveQualityOfServiceMetricResult; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveQualityOfServiceMetricResult): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IIterator_1__XboxLive_XboxLiveQualityOfServiceMetric = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_XboxLiveQualityOfServiceMetric): Cardinal; safecall;
    property Current: XboxLive_XboxLiveQualityOfServiceMetric read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IIterable_1__XboxLive_XboxLiveQualityOfServiceMetric = interface(IInspectable)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__XboxLive_XboxLiveQualityOfServiceMetric; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IVectorView_1__XboxLive_XboxLiveQualityOfServiceMetric = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_XboxLiveQualityOfServiceMetric; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_XboxLiveQualityOfServiceMetric): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric>
  IVector_1__XboxLive_XboxLiveQualityOfServiceMetric = interface(IInspectable)
  ['{A4739064-B54E-55D4-8012-317E2B6A807B}']
    function GetAt(index: Cardinal): XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function IndexOf(value: XboxLive_XboxLiveQualityOfServiceMetric; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: XboxLive_XboxLiveQualityOfServiceMetric); safecall;
    procedure InsertAt(index: Cardinal; value: XboxLive_XboxLiveQualityOfServiceMetric); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: XboxLive_XboxLiveQualityOfServiceMetric); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_XboxLiveQualityOfServiceMetric): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PXboxLive_XboxLiveQualityOfServiceMetric); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IIterator_1__XboxLive_IXboxLiveDeviceAddress = interface(IInspectable)
  ['{CCDA928E-16EE-56F4-83D1-D5923B4355DD}']
    function get_Current: XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_IXboxLiveDeviceAddress): Cardinal; safecall;
    property Current: XboxLive_IXboxLiveDeviceAddress read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IIterable_1__XboxLive_IXboxLiveDeviceAddress = interface(IInspectable)
  ['{31FC949A-2812-5F04-96C1-5711B1746910}']
    function First: IIterator_1__XboxLive_IXboxLiveDeviceAddress; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IVectorView_1__XboxLive_IXboxLiveDeviceAddress = interface(IInspectable)
  ['{B231854B-6A72-57A1-AB6A-5ABDBEE96096}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_IXboxLiveDeviceAddress; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveDeviceAddress): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Networking.XboxLive.IXboxLiveDeviceAddress>
  IVector_1__XboxLive_IXboxLiveDeviceAddress = interface(IInspectable)
  ['{992D83EE-D73D-56AA-A1B1-FF3074FEE1EE}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__XboxLive_IXboxLiveDeviceAddress; safecall;
    function IndexOf(value: XboxLive_IXboxLiveDeviceAddress; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: XboxLive_IXboxLiveDeviceAddress); safecall;
    procedure InsertAt(index: Cardinal; value: XboxLive_IXboxLiveDeviceAddress); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: XboxLive_IXboxLiveDeviceAddress); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveDeviceAddress): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PXboxLive_IXboxLiveDeviceAddress); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IIterator_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface(IInspectable)
  ['{54F63A7B-E356-533A-9EE3-62E3D823F770}']
    function get_Current: XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_IXboxLiveQualityOfServicePrivatePayloadResult): Cardinal; safecall;
    property Current: XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IIterable_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface(IInspectable)
  ['{E1FCF7AC-BFC5-5B75-8929-1E575A6B4121}']
    function First: IIterator_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Networking.XboxLive.IXboxLiveQualityOfServicePrivatePayloadResult>
  IVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult = interface(IInspectable)
  ['{45013733-5353-518D-8658-21A4961795A4}']
    function GetAt(index: Cardinal): XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_IXboxLiveQualityOfServicePrivatePayloadResult): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Networking.XboxLive.IXboxLiveQualityOfServiceMeasurement
  [WinRTClassNameAttribute(SXboxLive_XboxLiveQualityOfServiceMeasurement)]
  XboxLive_IXboxLiveQualityOfServiceMeasurement = interface(IInspectable)
  ['{4D682BCE-A5D6-47E6-A236-CFDE5FBDF2ED}']
    function MeasureAsync: IAsyncAction; safecall;
    function GetMetricResultsForDevice(deviceAddress: XboxLive_IXboxLiveDeviceAddress): IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function GetMetricResultsForMetric(metric: XboxLive_XboxLiveQualityOfServiceMetric): IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function GetMetricResult(deviceAddress: XboxLive_IXboxLiveDeviceAddress; metric: XboxLive_XboxLiveQualityOfServiceMetric): XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function GetPrivatePayloadResult(deviceAddress: XboxLive_IXboxLiveDeviceAddress): XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; safecall;
    function get_Metrics: IVector_1__XboxLive_XboxLiveQualityOfServiceMetric; safecall;
    function get_DeviceAddresses: IVector_1__XboxLive_IXboxLiveDeviceAddress; safecall;
    function get_ShouldRequestPrivatePayloads: Boolean; safecall;
    procedure put_ShouldRequestPrivatePayloads(value: Boolean); safecall;
    function get_TimeoutInMilliseconds: Cardinal; safecall;
    procedure put_TimeoutInMilliseconds(value: Cardinal); safecall;
    function get_NumberOfProbesToAttempt: Cardinal; safecall;
    procedure put_NumberOfProbesToAttempt(value: Cardinal); safecall;
    function get_NumberOfResultsPending: Cardinal; safecall;
    function get_MetricResults: IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult; safecall;
    function get_PrivatePayloadResults: IVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult; safecall;
    property DeviceAddresses: IVector_1__XboxLive_IXboxLiveDeviceAddress read get_DeviceAddresses;
    property MetricResults: IVectorView_1__XboxLive_IXboxLiveQualityOfServiceMetricResult read get_MetricResults;
    property Metrics: IVector_1__XboxLive_XboxLiveQualityOfServiceMetric read get_Metrics;
    property NumberOfProbesToAttempt: Cardinal read get_NumberOfProbesToAttempt write put_NumberOfProbesToAttempt;
    property NumberOfResultsPending: Cardinal read get_NumberOfResultsPending;
    property PrivatePayloadResults: IVectorView_1__XboxLive_IXboxLiveQualityOfServicePrivatePayloadResult read get_PrivatePayloadResults;
    property ShouldRequestPrivatePayloads: Boolean read get_ShouldRequestPrivatePayloads write put_ShouldRequestPrivatePayloads;
    property TimeoutInMilliseconds: Cardinal read get_TimeoutInMilliseconds write put_TimeoutInMilliseconds;
  end;


  // Emit Forwarded classes
  // Windows.Networking.HostName
  // DualAPI
  THostName = class(TWinRTGenericImportFS<IHostNameFactory, IHostNameStatics>)
  public
    // -> IHostNameStatics
    class function Compare(value1: HSTRING; value2: HSTRING): Integer; static; inline;

    // -> IHostNameFactory
    class function CreateHostName(hostName: HSTRING): IHostName; static; inline;
  end;

  // Windows.Networking.EndpointPair
  // DualAPI
  TEndpointPair = class(TWinRTGenericImportF<IEndpointPairFactory>)
  public
    // -> IEndpointPairFactory
    class function CreateEndpointPair(localHostName: IHostName; localServiceName: HSTRING; remoteHostName: IHostName; remoteServiceName: HSTRING): IEndpointPair; static; inline;
  end;

  // Windows.Networking.XboxLive.XboxLiveDeviceAddress
  // DualAPI
  TXboxLive_XboxLiveDeviceAddress = class(TWinRTGenericImportS<XboxLive_IXboxLiveDeviceAddressStatics>)
  public
    // -> XboxLive_IXboxLiveDeviceAddressStatics
    class function CreateFromSnapshotBase64(base64: HSTRING): XboxLive_IXboxLiveDeviceAddress; static; inline;
    class function CreateFromSnapshotBuffer(buffer: IBuffer): XboxLive_IXboxLiveDeviceAddress; static; inline;
    class function CreateFromSnapshotBytes(bufferSize: Cardinal; buffer: PByte): XboxLive_IXboxLiveDeviceAddress; static; inline;
    class function GetLocal: XboxLive_IXboxLiveDeviceAddress; static; inline;
    class function get_MaxSnapshotBytesSize: Cardinal; static; inline;
    class property MaxSnapshotBytesSize: Cardinal read get_MaxSnapshotBytesSize;
  end;

  // Windows.Networking.XboxLive.XboxLiveEndpointPair
  // DualAPI
  TXboxLive_XboxLiveEndpointPair = class(TWinRTGenericImportS<XboxLive_IXboxLiveEndpointPairStatics>)
  public
    // -> XboxLive_IXboxLiveEndpointPairStatics
    class function FindEndpointPairBySocketAddressBytes(localSocketAddressSize: Cardinal; localSocketAddress: PByte; remoteSocketAddress: Byte): XboxLive_IXboxLiveEndpointPair; static; inline;
    class function FindEndpointPairByHostNamesAndPorts(localHostName: IHostName; localPort: HSTRING; remoteHostName: IHostName; remotePort: HSTRING): XboxLive_IXboxLiveEndpointPair; static; inline;
  end;

  // Windows.Networking.XboxLive.XboxLiveEndpointPairTemplate
  // DualAPI
  TXboxLive_XboxLiveEndpointPairTemplate = class(TWinRTGenericImportS<XboxLive_IXboxLiveEndpointPairTemplateStatics>)
  public
    // -> XboxLive_IXboxLiveEndpointPairTemplateStatics
    class function GetTemplateByName(name: HSTRING): XboxLive_IXboxLiveEndpointPairTemplate; static; inline;
    class function get_Templates: IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate; static; inline;
    class property Templates: IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate read get_Templates;
  end;

  // Windows.Networking.XboxLive.XboxLiveInboundEndpointPairCreatedEventArgs
  // DualAPI

  // Windows.Networking.XboxLive.XboxLiveEndpointPairCreationResult
  // DualAPI

  // Windows.Networking.XboxLive.XboxLiveEndpointPairStateChangedEventArgs
  // DualAPI

  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetricResult
  // DualAPI

  // Windows.Networking.XboxLive.XboxLiveQualityOfServicePrivatePayloadResult
  // DualAPI

  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMeasurement
  // DualAPI
  TXboxLive_XboxLiveQualityOfServiceMeasurement = class(TWinRTGenericImportSI<XboxLive_IXboxLiveQualityOfServiceMeasurementStatics, XboxLive_IXboxLiveQualityOfServiceMeasurement>)
  public
    // -> XboxLive_IXboxLiveQualityOfServiceMeasurementStatics
    class procedure PublishPrivatePayloadBytes(payloadSize: Cardinal; payload: PByte); static; inline;
    class procedure ClearPrivatePayload; static; inline;
    class function get_MaxSimultaneousProbeConnections: Cardinal; static; inline;
    class procedure put_MaxSimultaneousProbeConnections(value: Cardinal); static; inline;
    class function get_IsSystemOutboundBandwidthConstrained: Boolean; static; inline;
    class procedure put_IsSystemOutboundBandwidthConstrained(value: Boolean); static; inline;
    class function get_IsSystemInboundBandwidthConstrained: Boolean; static; inline;
    class procedure put_IsSystemInboundBandwidthConstrained(value: Boolean); static; inline;
    class function get_PublishedPrivatePayload: IBuffer; static; inline;
    class procedure put_PublishedPrivatePayload(value: IBuffer); static; inline;
    class function get_MaxPrivatePayloadSize: Cardinal; static; inline;
    class property IsSystemInboundBandwidthConstrained: Boolean read get_IsSystemInboundBandwidthConstrained write put_IsSystemInboundBandwidthConstrained;
    class property IsSystemOutboundBandwidthConstrained: Boolean read get_IsSystemOutboundBandwidthConstrained write put_IsSystemOutboundBandwidthConstrained;
    class property MaxPrivatePayloadSize: Cardinal read get_MaxPrivatePayloadSize;
    class property MaxSimultaneousProbeConnections: Cardinal read get_MaxSimultaneousProbeConnections write put_MaxSimultaneousProbeConnections;
    class property PublishedPrivatePayload: IBuffer read get_PublishedPrivatePayload write put_PublishedPrivatePayload;
  end;


implementation

  // Emit Classes Implementation
 { THostName }

class function THostName.Compare(value1: HSTRING; value2: HSTRING): Integer;
begin
  Result := Statics.Compare(value1, value2);
end;

// Factories for : "HostName"
// Factory: "Windows.Networking.IHostNameFactory"
// -> IHostNameFactory

class function THostName.CreateHostName(hostName: HSTRING): IHostName;
begin
  Result := Factory.CreateHostName(hostName);
end;


 { TEndpointPair }
// Factories for : "EndpointPair"
// Factory: "Windows.Networking.IEndpointPairFactory"
// -> IEndpointPairFactory

class function TEndpointPair.CreateEndpointPair(localHostName: IHostName; localServiceName: HSTRING; remoteHostName: IHostName; remoteServiceName: HSTRING): IEndpointPair;
begin
  Result := Factory.CreateEndpointPair(localHostName, localServiceName, remoteHostName, remoteServiceName);
end;


 { TXboxLive_XboxLiveDeviceAddress }

class function TXboxLive_XboxLiveDeviceAddress.CreateFromSnapshotBase64(base64: HSTRING): XboxLive_IXboxLiveDeviceAddress;
begin
  Result := Statics.CreateFromSnapshotBase64(base64);
end;

class function TXboxLive_XboxLiveDeviceAddress.CreateFromSnapshotBuffer(buffer: IBuffer): XboxLive_IXboxLiveDeviceAddress;
begin
  Result := Statics.CreateFromSnapshotBuffer(buffer);
end;

class function TXboxLive_XboxLiveDeviceAddress.CreateFromSnapshotBytes(bufferSize: Cardinal; buffer: PByte): XboxLive_IXboxLiveDeviceAddress;
begin
  Result := Statics.CreateFromSnapshotBytes(bufferSize, buffer);
end;

class function TXboxLive_XboxLiveDeviceAddress.GetLocal: XboxLive_IXboxLiveDeviceAddress;
begin
  Result := Statics.GetLocal;
end;

class function TXboxLive_XboxLiveDeviceAddress.get_MaxSnapshotBytesSize: Cardinal;
begin
  Result := Statics.get_MaxSnapshotBytesSize;
end;


 { TXboxLive_XboxLiveEndpointPair }

class function TXboxLive_XboxLiveEndpointPair.FindEndpointPairBySocketAddressBytes(localSocketAddressSize: Cardinal; localSocketAddress: PByte; remoteSocketAddress: Byte): XboxLive_IXboxLiveEndpointPair;
begin
  Result := Statics.FindEndpointPairBySocketAddressBytes(localSocketAddressSize, localSocketAddress, remoteSocketAddress);
end;

class function TXboxLive_XboxLiveEndpointPair.FindEndpointPairByHostNamesAndPorts(localHostName: IHostName; localPort: HSTRING; remoteHostName: IHostName; remotePort: HSTRING): XboxLive_IXboxLiveEndpointPair;
begin
  Result := Statics.FindEndpointPairByHostNamesAndPorts(localHostName, localPort, remoteHostName, remotePort);
end;


 { TXboxLive_XboxLiveEndpointPairTemplate }

class function TXboxLive_XboxLiveEndpointPairTemplate.GetTemplateByName(name: HSTRING): XboxLive_IXboxLiveEndpointPairTemplate;
begin
  Result := Statics.GetTemplateByName(name);
end;

class function TXboxLive_XboxLiveEndpointPairTemplate.get_Templates: IVectorView_1__XboxLive_IXboxLiveEndpointPairTemplate;
begin
  Result := Statics.get_Templates;
end;


 { TXboxLive_XboxLiveQualityOfServiceMeasurement }

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.PublishPrivatePayloadBytes(payloadSize: Cardinal; payload: PByte);
begin
  Statics.PublishPrivatePayloadBytes(payloadSize, payload);
end;

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.ClearPrivatePayload;
begin
  Statics.ClearPrivatePayload;
end;

class function TXboxLive_XboxLiveQualityOfServiceMeasurement.get_MaxSimultaneousProbeConnections: Cardinal;
begin
  Result := Statics.get_MaxSimultaneousProbeConnections;
end;

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.put_MaxSimultaneousProbeConnections(value: Cardinal);
begin
  Statics.put_MaxSimultaneousProbeConnections(value);
end;

class function TXboxLive_XboxLiveQualityOfServiceMeasurement.get_IsSystemOutboundBandwidthConstrained: Boolean;
begin
  Result := Statics.get_IsSystemOutboundBandwidthConstrained;
end;

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.put_IsSystemOutboundBandwidthConstrained(value: Boolean);
begin
  Statics.put_IsSystemOutboundBandwidthConstrained(value);
end;

class function TXboxLive_XboxLiveQualityOfServiceMeasurement.get_IsSystemInboundBandwidthConstrained: Boolean;
begin
  Result := Statics.get_IsSystemInboundBandwidthConstrained;
end;

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.put_IsSystemInboundBandwidthConstrained(value: Boolean);
begin
  Statics.put_IsSystemInboundBandwidthConstrained(value);
end;

class function TXboxLive_XboxLiveQualityOfServiceMeasurement.get_PublishedPrivatePayload: IBuffer;
begin
  Result := Statics.get_PublishedPrivatePayload;
end;

class procedure TXboxLive_XboxLiveQualityOfServiceMeasurement.put_PublishedPrivatePayload(value: IBuffer);
begin
  Statics.put_PublishedPrivatePayload(value);
end;

class function TXboxLive_XboxLiveQualityOfServiceMeasurement.get_MaxPrivatePayloadSize: Cardinal;
begin
  Result := Statics.get_MaxPrivatePayloadSize;
end;



end.
