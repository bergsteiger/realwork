{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Enumeration;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Enumeration Class Names
  // Windows.Devices.Enumeration.DeviceThumbnail
  // DualAPI
  SDeviceThumbnail = 'Windows.Devices.Enumeration.DeviceThumbnail';
  // Windows.Devices.Enumeration.EnclosureLocation
  // DualAPI
  SEnclosureLocation = 'Windows.Devices.Enumeration.EnclosureLocation';
  // Windows.Devices.Enumeration.DeviceInformationUpdate
  // DualAPI
  SDeviceInformationUpdate = 'Windows.Devices.Enumeration.DeviceInformationUpdate';
  // Windows.Devices.Enumeration.DeviceInformationCollection
  // DualAPI
  SDeviceInformationCollection = 'Windows.Devices.Enumeration.DeviceInformationCollection';
  // Windows.Devices.Enumeration.DeviceWatcher
  // DualAPI
  SDeviceWatcher = 'Windows.Devices.Enumeration.DeviceWatcher';
  // Windows.Devices.Enumeration.DeviceInformation
  // DualAPI
  SDeviceInformation = 'Windows.Devices.Enumeration.DeviceInformation';
  // Windows.Devices.Enumeration.DevicePickerAppearance
  // DualAPI
  SDevicePickerAppearance = 'Windows.Devices.Enumeration.DevicePickerAppearance';
  // Windows.Devices.Enumeration.DeviceSelectedEventArgs
  // DualAPI
  SDeviceSelectedEventArgs = 'Windows.Devices.Enumeration.DeviceSelectedEventArgs';
  // Windows.Devices.Enumeration.DeviceDisconnectButtonClickedEventArgs
  // DualAPI
  SDeviceDisconnectButtonClickedEventArgs = 'Windows.Devices.Enumeration.DeviceDisconnectButtonClickedEventArgs';
  // Windows.Devices.Enumeration.DevicePickerFilter
  // DualAPI
  SDevicePickerFilter = 'Windows.Devices.Enumeration.DevicePickerFilter';
  // Windows.Devices.Enumeration.DevicePicker
  // DualAPI
  SDevicePicker = 'Windows.Devices.Enumeration.DevicePicker';
  // Windows.Devices.Enumeration.Pnp.PnpObjectUpdate
  // DualAPI
  SPnp_PnpObjectUpdate = 'Windows.Devices.Enumeration.Pnp.PnpObjectUpdate';
  // Windows.Devices.Enumeration.Pnp.PnpObjectCollection
  // DualAPI
  SPnp_PnpObjectCollection = 'Windows.Devices.Enumeration.Pnp.PnpObjectCollection';
  // Windows.Devices.Enumeration.Pnp.PnpObjectWatcher
  // DualAPI
  SPnp_PnpObjectWatcher = 'Windows.Devices.Enumeration.Pnp.PnpObjectWatcher';
  // Windows.Devices.Enumeration.Pnp.PnpObject
  // DualAPI
  SPnp_PnpObject = 'Windows.Devices.Enumeration.Pnp.PnpObject';


type
  // Forward declare interfaces
  // Windows.Devices.Enumeration.IEnclosureLocation
  IEnclosureLocation = interface;
  PIEnclosureLocation = ^IEnclosureLocation;

  // Windows.Devices.Enumeration.IDeviceInformationUpdate
  IDeviceInformationUpdate = interface;
  PIDeviceInformationUpdate = ^IDeviceInformationUpdate;

  // Windows.Devices.Enumeration.IDeviceInformationUpdate2
  IDeviceInformationUpdate2 = interface;
  PIDeviceInformationUpdate2 = ^IDeviceInformationUpdate2;

  // Windows.Devices.Enumeration.IDeviceInformation
  IDeviceInformation = interface;
  PIDeviceInformation = ^IDeviceInformation;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformation>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformation = interface;
  PTypedEventHandler_2__IDeviceWatcher__IDeviceInformation = ^TypedEventHandler_2__IDeviceWatcher__IDeviceInformation;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformationUpdate>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate = interface;
  PTypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate = ^TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Object>
  TypedEventHandler_2__IDeviceWatcher__IInspectable = interface;
  PTypedEventHandler_2__IDeviceWatcher__IInspectable = ^TypedEventHandler_2__IDeviceWatcher__IInspectable;

  // Windows.Devices.Enumeration.IDeviceWatcher
  IDeviceWatcher = interface;
  PIDeviceWatcher = ^IDeviceWatcher;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.DeviceWatcherEventKind>
  IIterator_1__DeviceWatcherEventKind = interface;
  PIIterator_1__DeviceWatcherEventKind = ^IIterator_1__DeviceWatcherEventKind;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceWatcherEventKind>
  IIterable_1__DeviceWatcherEventKind = interface;
  PIIterable_1__DeviceWatcherEventKind = ^IIterable_1__DeviceWatcherEventKind;

  // Windows.Devices.Enumeration.IDeviceWatcher2
  IDeviceWatcher2 = interface;
  PIDeviceWatcher2 = ^IDeviceWatcher2;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDeviceInformation>
  AsyncOperationCompletedHandler_1__IDeviceInformation = interface;
  PAsyncOperationCompletedHandler_1__IDeviceInformation = ^AsyncOperationCompletedHandler_1__IDeviceInformation;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDeviceInformation>
  IAsyncOperation_1__IDeviceInformation = interface;
  PIAsyncOperation_1__IDeviceInformation = ^IAsyncOperation_1__IDeviceInformation;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.IDeviceInformation>
  IIterator_1__IDeviceInformation = interface;
  PIIterator_1__IDeviceInformation = ^IIterator_1__IDeviceInformation;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.IDeviceInformation>
  IIterable_1__IDeviceInformation = interface;
  PIIterable_1__IDeviceInformation = ^IIterable_1__IDeviceInformation;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>
  IVectorView_1__IDeviceInformation = interface;
  PIVectorView_1__IDeviceInformation = ^IVectorView_1__IDeviceInformation;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation = ^AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  IAsyncOperation_1__IVectorView_1__IDeviceInformation = interface;
  PIAsyncOperation_1__IVectorView_1__IDeviceInformation = ^IAsyncOperation_1__IVectorView_1__IDeviceInformation;

  // Windows.Devices.Enumeration.IDeviceInformationStatics
  IDeviceInformationStatics = interface;
  PIDeviceInformationStatics = ^IDeviceInformationStatics;

  // Windows.Devices.Enumeration.IDeviceInformationStatics2
  IDeviceInformationStatics2 = interface;
  PIDeviceInformationStatics2 = ^IDeviceInformationStatics2;

  // Windows.Devices.Enumeration.IDevicePairingResult
  IDevicePairingResult = interface;
  PIDevicePairingResult = ^IDevicePairingResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDevicePairingResult>
  AsyncOperationCompletedHandler_1__IDevicePairingResult = interface;
  PAsyncOperationCompletedHandler_1__IDevicePairingResult = ^AsyncOperationCompletedHandler_1__IDevicePairingResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDevicePairingResult>
  IAsyncOperation_1__IDevicePairingResult = interface;
  PIAsyncOperation_1__IDevicePairingResult = ^IAsyncOperation_1__IDevicePairingResult;

  // Windows.Devices.Enumeration.IDeviceInformationPairing
  IDeviceInformationPairing = interface;
  PIDeviceInformationPairing = ^IDeviceInformationPairing;

  // Windows.Devices.Enumeration.IDeviceInformation2
  IDeviceInformation2 = interface;
  PIDeviceInformation2 = ^IDeviceInformation2;

  // Windows.Devices.Enumeration.IDevicePickerAppearance
  IDevicePickerAppearance = interface;
  PIDevicePickerAppearance = ^IDevicePickerAppearance;

  // Windows.Devices.Enumeration.IDeviceSelectedEventArgs
  IDeviceSelectedEventArgs = interface;
  PIDeviceSelectedEventArgs = ^IDeviceSelectedEventArgs;

  // Windows.Devices.Enumeration.IDeviceDisconnectButtonClickedEventArgs
  IDeviceDisconnectButtonClickedEventArgs = interface;
  PIDeviceDisconnectButtonClickedEventArgs = ^IDeviceDisconnectButtonClickedEventArgs;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.DeviceClass>
  IIterator_1__DeviceClass = interface;
  PIIterator_1__DeviceClass = ^IIterator_1__DeviceClass;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceClass>
  IIterable_1__DeviceClass = interface;
  PIIterable_1__DeviceClass = ^IIterable_1__DeviceClass;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.DeviceClass>
  IVectorView_1__DeviceClass = interface;
  PIVectorView_1__DeviceClass = ^IVectorView_1__DeviceClass;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Enumeration.DeviceClass>
  IVector_1__DeviceClass = interface;
  PIVector_1__DeviceClass = ^IVector_1__DeviceClass;

  // Windows.Devices.Enumeration.IDevicePickerFilter
  IDevicePickerFilter = interface;
  PIDevicePickerFilter = ^IDevicePickerFilter;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceSelectedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs = interface;
  PTypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs = ^TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs = interface;
  PTypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs = ^TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Object>
  TypedEventHandler_2__IDevicePicker__IInspectable = interface;
  PTypedEventHandler_2__IDevicePicker__IInspectable = ^TypedEventHandler_2__IDevicePicker__IInspectable;

  // Windows.Devices.Enumeration.IDevicePicker
  IDevicePicker = interface;
  PIDevicePicker = ^IDevicePicker;

  // Windows.Devices.Enumeration.Pnp.IPnpObjectUpdate
  Pnp_IPnpObjectUpdate = interface;
  PPnp_IPnpObjectUpdate = ^Pnp_IPnpObjectUpdate;

  // Windows.Devices.Enumeration.Pnp.IPnpObject
  Pnp_IPnpObject = interface;
  PPnp_IPnpObject = ^Pnp_IPnpObject;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObject>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject = interface;
  PTypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject = ^TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObjectUpdate>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate = interface;
  PTypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate = ^TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Object>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable = interface;
  PTypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable = ^TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable;

  // Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher
  Pnp_IPnpObjectWatcher = interface;
  PPnp_IPnpObjectWatcher = ^Pnp_IPnpObjectWatcher;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  AsyncOperationCompletedHandler_1__Pnp_IPnpObject = interface;
  PAsyncOperationCompletedHandler_1__Pnp_IPnpObject = ^AsyncOperationCompletedHandler_1__Pnp_IPnpObject;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IAsyncOperation_1__Pnp_IPnpObject = interface;
  PIAsyncOperation_1__Pnp_IPnpObject = ^IAsyncOperation_1__Pnp_IPnpObject;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IIterator_1__Pnp_IPnpObject = interface;
  PIIterator_1__Pnp_IPnpObject = ^IIterator_1__Pnp_IPnpObject;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IIterable_1__Pnp_IPnpObject = interface;
  PIIterable_1__Pnp_IPnpObject = ^IIterable_1__Pnp_IPnpObject;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IVectorView_1__Pnp_IPnpObject = interface;
  PIVectorView_1__Pnp_IPnpObject = ^IVectorView_1__Pnp_IPnpObject;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject = ^AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject = interface;
  PIAsyncOperation_1__IVectorView_1__Pnp_IPnpObject = ^IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject;

  // Windows.Devices.Enumeration.Pnp.IPnpObjectStatics
  Pnp_IPnpObjectStatics = interface;
  PPnp_IPnpObjectStatics = ^Pnp_IPnpObjectStatics;


  // Emit Forwarded interfaces
  // Windows.Devices.Enumeration Interfaces
  // DualAPI Interface
  // Windows.Devices.Enumeration.IEnclosureLocation
  [WinRTClassNameAttribute(SEnclosureLocation)]
  IEnclosureLocation = interface(IInspectable)
  ['{42340A27-5810-459C-AABB-C65E1F813ECF}']
    function get_InDock: Boolean; safecall;
    function get_InLid: Boolean; safecall;
    function get_Panel: Panel; safecall;
    property InDock: Boolean read get_InDock;
    property InLid: Boolean read get_InLid;
    property Panel: Panel read get_Panel;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformationUpdate
  [WinRTClassNameAttribute(SDeviceInformationUpdate)]
  IDeviceInformationUpdate = interface(IInspectable)
  ['{8F315305-D972-44B7-A37E-9E822C78213B}']
    function get_Id: HSTRING; safecall;
    function get_Properties: IMapView_2__HSTRING__IInspectable; safecall;
    property Id: HSTRING read get_Id;
    property Properties: IMapView_2__HSTRING__IInspectable read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformationUpdate2
  IDeviceInformationUpdate2 = interface(IInspectable)
  ['{5D9D148C-A873-485E-BAA6-AA620788E3CC}']
    function get_Kind: DeviceInformationKind; safecall;
    property Kind: DeviceInformationKind read get_Kind;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformation
  [WinRTClassNameAttribute(SDeviceInformation)]
  IDeviceInformation = interface(IInspectable)
  ['{ABA0FB95-4398-489D-8E44-E6130927011F}']
    function get_Id: HSTRING; safecall;
    function get_Name: HSTRING; safecall;
    function get_IsEnabled: Boolean; safecall;
    function get_IsDefault: Boolean; safecall;
    function get_EnclosureLocation: IEnclosureLocation; safecall;
    function get_Properties: IMapView_2__HSTRING__IInspectable; safecall;
    procedure Update(updateInfo: IDeviceInformationUpdate); safecall;
    function GetThumbnailAsync: IAsyncOperation_1__IRandomAccessStreamWithContentType; safecall;
    function GetGlyphThumbnailAsync: IAsyncOperation_1__IRandomAccessStreamWithContentType; safecall;
    property EnclosureLocation: IEnclosureLocation read get_EnclosureLocation;
    property Id: HSTRING read get_Id;
    property IsDefault: Boolean read get_IsDefault;
    property IsEnabled: Boolean read get_IsEnabled;
    property Name: HSTRING read get_Name;
    property Properties: IMapView_2__HSTRING__IInspectable read get_Properties;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformation>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformation_Delegate_Base = interface(IUnknown)
  ['{03C5A07B-990C-5D09-B0B8-5734EAA38222}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformation>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformation = interface(TypedEventHandler_2__IDeviceWatcher__IDeviceInformation_Delegate_Base)
  ['{45B8F772-CDC9-5498-8951-1E65FB72796C}']
    procedure Invoke(sender: IDeviceWatcher; args: IDeviceInformation); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformationUpdate>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate_Delegate_Base = interface(IUnknown)
  ['{906F1254-79AD-54FC-93C4-CDB99B437899}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Windows.Devices.Enumeration.IDeviceInformationUpdate>
  TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate = interface(TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate_Delegate_Base)
  ['{E974B937-20D2-5428-86F4-7464244D7744}']
    procedure Invoke(sender: IDeviceWatcher; args: IDeviceInformationUpdate); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Object>
  TypedEventHandler_2__IDeviceWatcher__IInspectable_Delegate_Base = interface(IUnknown)
  ['{9234630F-1FF4-54F6-9E3F-AC20369B7725}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDeviceWatcher,Object>
  TypedEventHandler_2__IDeviceWatcher__IInspectable = interface(TypedEventHandler_2__IDeviceWatcher__IInspectable_Delegate_Base)
  ['{2E39B58C-3F86-5F12-B142-FABFA589D8FF}']
    procedure Invoke(sender: IDeviceWatcher; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceWatcher
  [WinRTClassNameAttribute(SDeviceWatcher)]
  IDeviceWatcher = interface(IInspectable)
  ['{C9EAB97D-8F6B-4F96-A9F4-ABC814E22271}']
    function add_Added(handler: TypedEventHandler_2__IDeviceWatcher__IDeviceInformation): EventRegistrationToken; safecall;
    procedure remove_Added(token: EventRegistrationToken); safecall;
    function add_Updated(handler: TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate): EventRegistrationToken; safecall;
    procedure remove_Updated(token: EventRegistrationToken); safecall;
    function add_Removed(handler: TypedEventHandler_2__IDeviceWatcher__IDeviceInformationUpdate): EventRegistrationToken; safecall;
    procedure remove_Removed(token: EventRegistrationToken); safecall;
    function add_EnumerationCompleted(handler: TypedEventHandler_2__IDeviceWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_EnumerationCompleted(token: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__IDeviceWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Stopped(token: EventRegistrationToken); safecall;
    function get_Status: DeviceWatcherStatus; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    property Status: DeviceWatcherStatus read get_Status;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.DeviceWatcherEventKind>
  IIterator_1__DeviceWatcherEventKind = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: DeviceWatcherEventKind; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PDeviceWatcherEventKind): Cardinal; safecall;
    property Current: DeviceWatcherEventKind read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceWatcherEventKind>
  IIterable_1__DeviceWatcherEventKind_Base = interface(IInspectable)
  ['{F04365AB-D3F3-5F85-A7DA-DC19CFF73D86}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceWatcherEventKind>
  IIterable_1__DeviceWatcherEventKind = interface(IIterable_1__DeviceWatcherEventKind_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__DeviceWatcherEventKind; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceWatcher2
  IDeviceWatcher2 = interface(IInspectable)
  ['{FF08456E-ED14-49E9-9A69-8117C54AE971}']
    function GetBackgroundTrigger(requestedEventKinds: IIterable_1__DeviceWatcherEventKind): IInspectable{IDeviceWatcherTrigger}; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDeviceInformation>
  AsyncOperationCompletedHandler_1__IDeviceInformation_Delegate_Base = interface(IUnknown)
  ['{BB483DF2-7BB6-5923-A28D-8342EC30046B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDeviceInformation>
  AsyncOperationCompletedHandler_1__IDeviceInformation = interface(AsyncOperationCompletedHandler_1__IDeviceInformation_Delegate_Base)
  ['{33A901B6-95BD-5152-B320-56644152046D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IDeviceInformation; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDeviceInformation>
  IAsyncOperation_1__IDeviceInformation_Base = interface(IInspectable)
  ['{07FAA053-EB2F-5CBA-B25B-D9D57BE6715F}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDeviceInformation>
  IAsyncOperation_1__IDeviceInformation = interface(IAsyncOperation_1__IDeviceInformation_Base)
  ['{F6CE39E7-E062-5F4E-9663-1883AB9707DA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IDeviceInformation); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IDeviceInformation; safecall;
    function GetResults: IDeviceInformation; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IDeviceInformation read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.IDeviceInformation>
  IIterator_1__IDeviceInformation = interface(IInspectable)
  ['{F06491A0-6D3D-5A38-B164-AEE6E5B0326C}']
    function get_Current: IDeviceInformation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIDeviceInformation): Cardinal; safecall;
    property Current: IDeviceInformation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.IDeviceInformation>
  IIterable_1__IDeviceInformation_Base = interface(IInspectable)
  ['{DD9F8A5D-EC98-5F4B-A3EA-9C8B5AD53C4B}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.IDeviceInformation>
  IIterable_1__IDeviceInformation = interface(IIterable_1__IDeviceInformation_Base)
  ['{180E4B06-9936-5D42-A5BF-1BDC08713DBD}']
    function First: IIterator_1__IDeviceInformation; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>
  [WinRTClassNameAttribute(SDeviceInformationCollection)]
  IVectorView_1__IDeviceInformation = interface(IInspectable)
  ['{717AA701-AB02-5C8D-AD35-EE564CF8BB0E}']
    function GetAt(index: Cardinal): IDeviceInformation; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IDeviceInformation; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIDeviceInformation): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation_Delegate_Base = interface(IUnknown)
  ['{4A458732-527E-5C73-9A68-A73DA370F782}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation_Delegate_Base)
  ['{E2375529-DAC5-52E8-B1DE-7AAE0A9202CC}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IDeviceInformation; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  IAsyncOperation_1__IVectorView_1__IDeviceInformation_Base = interface(IInspectable)
  ['{45180254-082E-5274-B2E7-AC0517F44D07}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.IDeviceInformation>>
  IAsyncOperation_1__IVectorView_1__IDeviceInformation = interface(IAsyncOperation_1__IVectorView_1__IDeviceInformation_Base)
  ['{42F4622B-7AB2-59F9-8C91-8235DC44E8F4}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation; safecall;
    function GetResults: IVectorView_1__IDeviceInformation; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IDeviceInformation read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformationStatics
  [WinRTClassNameAttribute(SDeviceInformation)]
  IDeviceInformationStatics = interface(IInspectable)
  ['{C17F100E-3A46-4A78-8013-769DC9B97390}']
    function CreateFromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IDeviceInformation; overload; safecall;
    function CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IDeviceInformation; overload; safecall;
    function FindAllAsync: IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; safecall;
    function FindAllAsync(deviceClass: DeviceClass): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; safecall;
    function FindAllAsync(aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; safecall;
    function FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; safecall;
    function CreateWatcher: IDeviceWatcher; overload; safecall;
    function CreateWatcher(deviceClass: DeviceClass): IDeviceWatcher; overload; safecall;
    function CreateWatcher(aqsFilter: HSTRING): IDeviceWatcher; overload; safecall;
    function CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IDeviceWatcher; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformationStatics2
  [WinRTClassNameAttribute(SDeviceInformation)]
  IDeviceInformationStatics2 = interface(IInspectable)
  ['{493B4F34-A84F-45FD-9167-15D1CB1BD1F9}']
    function GetAqsFilterFromDeviceClass(deviceClass: DeviceClass): HSTRING; safecall;
    function CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IDeviceInformation; safecall;
    function FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IVectorView_1__IDeviceInformation; safecall;
    function CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IDeviceWatcher; safecall;
  end;

  // Windows.Devices.Enumeration.IDevicePairingResult
  IDevicePairingResult = interface(IInspectable)
  ['{072B02BF-DD95-4025-9B37-DE51ADBA37B7}']
    function get_Status: DevicePairingResultStatus; safecall;
    function get_ProtectionLevelUsed: DevicePairingProtectionLevel; safecall;
    property ProtectionLevelUsed: DevicePairingProtectionLevel read get_ProtectionLevelUsed;
    property Status: DevicePairingResultStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDevicePairingResult>
  AsyncOperationCompletedHandler_1__IDevicePairingResult_Delegate_Base = interface(IUnknown)
  ['{7EE0247F-5F57-5CB2-B40E-18B5A211D6C3}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.IDevicePairingResult>
  AsyncOperationCompletedHandler_1__IDevicePairingResult = interface(AsyncOperationCompletedHandler_1__IDevicePairingResult_Delegate_Base)
  ['{FEE5AE5D-187F-56A3-AFD2-3C5ABCCCBE14}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IDevicePairingResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDevicePairingResult>
  IAsyncOperation_1__IDevicePairingResult_Base = interface(IInspectable)
  ['{1002DB74-8948-591E-815D-E40B667599A3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.IDevicePairingResult>
  IAsyncOperation_1__IDevicePairingResult = interface(IAsyncOperation_1__IDevicePairingResult_Base)
  ['{529C658D-8499-557A-A110-7634DDC46275}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IDevicePairingResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IDevicePairingResult; safecall;
    function GetResults: IDevicePairingResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IDevicePairingResult read get_Completed write put_Completed;
  end;

  // Windows.Devices.Enumeration.IDeviceInformationPairing
  IDeviceInformationPairing = interface(IInspectable)
  ['{2C4769F5-F684-40D5-8469-E8DBAAB70485}']
    function get_IsPaired: Boolean; safecall;
    function get_CanPair: Boolean; safecall;
    function PairAsync: IAsyncOperation_1__IDevicePairingResult; overload; safecall;
    function PairAsync(minProtectionLevel: DevicePairingProtectionLevel): IAsyncOperation_1__IDevicePairingResult; overload; safecall;
    property CanPair: Boolean read get_CanPair;
    property IsPaired: Boolean read get_IsPaired;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceInformation2
  IDeviceInformation2 = interface(IInspectable)
  ['{F156A638-7997-48D9-A10C-269D46533F48}']
    function get_Kind: DeviceInformationKind; safecall;
    function get_Pairing: IDeviceInformationPairing; safecall;
    property Kind: DeviceInformationKind read get_Kind;
    property Pairing: IDeviceInformationPairing read get_Pairing;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDevicePickerAppearance
  [WinRTClassNameAttribute(SDevicePickerAppearance)]
  IDevicePickerAppearance = interface(IInspectable)
  ['{E69A12C6-E627-4ED8-9B6C-460AF445E56D}']
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_ForegroundColor: Color; safecall;
    procedure put_ForegroundColor(value: Color); safecall;
    function get_BackgroundColor: Color; safecall;
    procedure put_BackgroundColor(value: Color); safecall;
    function get_AccentColor: Color; safecall;
    procedure put_AccentColor(value: Color); safecall;
    function get_SelectedForegroundColor: Color; safecall;
    procedure put_SelectedForegroundColor(value: Color); safecall;
    function get_SelectedBackgroundColor: Color; safecall;
    procedure put_SelectedBackgroundColor(value: Color); safecall;
    function get_SelectedAccentColor: Color; safecall;
    procedure put_SelectedAccentColor(value: Color); safecall;
    property AccentColor: Color read get_AccentColor write put_AccentColor;
    property BackgroundColor: Color read get_BackgroundColor write put_BackgroundColor;
    property ForegroundColor: Color read get_ForegroundColor write put_ForegroundColor;
    property SelectedAccentColor: Color read get_SelectedAccentColor write put_SelectedAccentColor;
    property SelectedBackgroundColor: Color read get_SelectedBackgroundColor write put_SelectedBackgroundColor;
    property SelectedForegroundColor: Color read get_SelectedForegroundColor write put_SelectedForegroundColor;
    property Title: HSTRING read get_Title write put_Title;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceSelectedEventArgs
  [WinRTClassNameAttribute(SDeviceSelectedEventArgs)]
  IDeviceSelectedEventArgs = interface(IInspectable)
  ['{269EDADE-1D2F-4940-8402-4156B81D3C77}']
    function get_SelectedDevice: IDeviceInformation; safecall;
    property SelectedDevice: IDeviceInformation read get_SelectedDevice;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDeviceDisconnectButtonClickedEventArgs
  [WinRTClassNameAttribute(SDeviceDisconnectButtonClickedEventArgs)]
  IDeviceDisconnectButtonClickedEventArgs = interface(IInspectable)
  ['{8E44B56D-F902-4A00-B536-F37992E6A2A7}']
    function get_Device: IDeviceInformation; safecall;
    property Device: IDeviceInformation read get_Device;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.DeviceClass>
  IIterator_1__DeviceClass = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: DeviceClass; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PDeviceClass): Cardinal; safecall;
    property Current: DeviceClass read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceClass>
  IIterable_1__DeviceClass_Base = interface(IInspectable)
  ['{47D4BE05-58F1-522E-81C6-975EB4131BB9}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.DeviceClass>
  IIterable_1__DeviceClass = interface(IIterable_1__DeviceClass_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__DeviceClass; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.DeviceClass>
  IVectorView_1__DeviceClass = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): DeviceClass; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: DeviceClass; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PDeviceClass): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Enumeration.DeviceClass>
  IVector_1__DeviceClass = interface(IInspectable)
  ['{A4739064-B54E-55D4-8012-317E2B6A807B}']
    function GetAt(index: Cardinal): DeviceClass; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__DeviceClass; safecall;
    function IndexOf(value: DeviceClass; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: DeviceClass); safecall;
    procedure InsertAt(index: Cardinal; value: DeviceClass); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: DeviceClass); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PDeviceClass): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PDeviceClass); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDevicePickerFilter
  [WinRTClassNameAttribute(SDevicePickerFilter)]
  IDevicePickerFilter = interface(IInspectable)
  ['{91DB92A2-57CB-48F1-9B59-A59B7A1F02A2}']
    function get_SupportedDeviceClasses: IVector_1__DeviceClass; safecall;
    function get_SupportedDeviceSelectors: IVector_1__HSTRING; safecall;
    property SupportedDeviceClasses: IVector_1__DeviceClass read get_SupportedDeviceClasses;
    property SupportedDeviceSelectors: IVector_1__HSTRING read get_SupportedDeviceSelectors;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceSelectedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs_Delegate_Base = interface(IUnknown)
  ['{47E48C88-1C56-5B58-96A2-8E813D25077A}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceSelectedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs = interface(TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs_Delegate_Base)
  ['{1E62D931-39AF-5E34-93A0-8500F98C53C8}']
    procedure Invoke(sender: IDevicePicker; args: IDeviceSelectedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs_Delegate_Base = interface(IUnknown)
  ['{35DD0319-5723-506C-8896-1A28B82BE798}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Windows.Devices.Enumeration.IDeviceDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs = interface(TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs_Delegate_Base)
  ['{9B11002B-6A57-54AD-91FB-2B572A19150C}']
    procedure Invoke(sender: IDevicePicker; args: IDeviceDisconnectButtonClickedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Object>
  TypedEventHandler_2__IDevicePicker__IInspectable_Delegate_Base = interface(IUnknown)
  ['{62C6D98C-57EE-5BB8-A41C-958D20C3F3E8}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.IDevicePicker,Object>
  TypedEventHandler_2__IDevicePicker__IInspectable = interface(TypedEventHandler_2__IDevicePicker__IInspectable_Delegate_Base)
  ['{461CF512-3561-51C5-9C98-2972FF59D0B7}']
    procedure Invoke(sender: IDevicePicker; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.IDevicePicker
  [WinRTClassNameAttribute(SDevicePicker)]
  IDevicePicker = interface(IInspectable)
  ['{84997AA2-034A-4440-8813-7D0BD479BF5A}']
    function get_Filter: IDevicePickerFilter; safecall;
    function get_Appearance: IDevicePickerAppearance; safecall;
    function get_RequestedProperties: IVector_1__HSTRING; safecall;
    function add_DeviceSelected(handler: TypedEventHandler_2__IDevicePicker__IDeviceSelectedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DeviceSelected(token: EventRegistrationToken); safecall;
    function add_DisconnectButtonClicked(handler: TypedEventHandler_2__IDevicePicker__IDeviceDisconnectButtonClickedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DisconnectButtonClicked(token: EventRegistrationToken); safecall;
    function add_DevicePickerDismissed(handler: TypedEventHandler_2__IDevicePicker__IInspectable): EventRegistrationToken; safecall;
    procedure remove_DevicePickerDismissed(token: EventRegistrationToken); safecall;
    procedure Show(selection: TRectF); overload; safecall;
    procedure Show(selection: TRectF; placement: Popups_Placement); overload; safecall;
    function PickSingleDeviceAsync(selection: TRectF): IAsyncOperation_1__IDeviceInformation; overload; safecall;
    function PickSingleDeviceAsync(selection: TRectF; placement: Popups_Placement): IAsyncOperation_1__IDeviceInformation; overload; safecall;
    procedure Hide; safecall;
    procedure SetDisplayStatus(device: IDeviceInformation; status: HSTRING; options: DevicePickerDisplayStatusOptions); safecall;
    property Appearance: IDevicePickerAppearance read get_Appearance;
    property Filter: IDevicePickerFilter read get_Filter;
    property RequestedProperties: IVector_1__HSTRING read get_RequestedProperties;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.Pnp.IPnpObjectUpdate
  [WinRTClassNameAttribute(SPnp_PnpObjectUpdate)]
  Pnp_IPnpObjectUpdate = interface(IInspectable)
  ['{6F59E812-001E-4844-BCC6-432886856A17}']
    function get_Type: Pnp_PnpObjectType; safecall;
    function get_Id: HSTRING; safecall;
    function get_Properties: IMapView_2__HSTRING__IInspectable; safecall;
    property Id: HSTRING read get_Id;
    property Properties: IMapView_2__HSTRING__IInspectable read get_Properties;
    property &Type: Pnp_PnpObjectType read get_Type;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.Pnp.IPnpObject
  [WinRTClassNameAttribute(SPnp_PnpObject)]
  Pnp_IPnpObject = interface(IInspectable)
  ['{95C66258-733B-4A8F-93A3-DB078AC870C1}']
    function get_Type: Pnp_PnpObjectType; safecall;
    function get_Id: HSTRING; safecall;
    function get_Properties: IMapView_2__HSTRING__IInspectable; safecall;
    procedure Update(updateInfo: Pnp_IPnpObjectUpdate); safecall;
    property Id: HSTRING read get_Id;
    property Properties: IMapView_2__HSTRING__IInspectable read get_Properties;
    property &Type: Pnp_PnpObjectType read get_Type;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObject>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject_Delegate_Base = interface(IUnknown)
  ['{D578EED2-58E5-5825-8AF2-12F89387B656}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObject>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject = interface(TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject_Delegate_Base)
  ['{22A619AD-2356-5234-B2AC-0D26B29D6915}']
    procedure Invoke(sender: Pnp_IPnpObjectWatcher; args: Pnp_IPnpObject); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObjectUpdate>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate_Delegate_Base = interface(IUnknown)
  ['{AF8F929D-8058-5C38-A3D8-30AA7A08B588}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Windows.Devices.Enumeration.Pnp.IPnpObjectUpdate>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate = interface(TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate_Delegate_Base)
  ['{6ED742E7-1453-5E28-97C5-73FD081CAEF3}']
    procedure Invoke(sender: Pnp_IPnpObjectWatcher; args: Pnp_IPnpObjectUpdate); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Object>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable_Delegate_Base = interface(IUnknown)
  ['{2EE2B4C9-B696-5ECC-B29B-F1E0EF5FE1F7}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher,Object>
  TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable = interface(TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable_Delegate_Base)
  ['{B3E4D6DF-3B83-5CEA-895C-5B2CA60321AC}']
    procedure Invoke(sender: Pnp_IPnpObjectWatcher; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.Pnp.IPnpObjectWatcher
  [WinRTClassNameAttribute(SPnp_PnpObjectWatcher)]
  Pnp_IPnpObjectWatcher = interface(IInspectable)
  ['{83C95CA8-4772-4A7A-ACA8-E48C42A89C44}']
    function add_Added(handler: TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObject): EventRegistrationToken; safecall;
    procedure remove_Added(token: EventRegistrationToken); safecall;
    function add_Updated(handler: TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate): EventRegistrationToken; safecall;
    procedure remove_Updated(token: EventRegistrationToken); safecall;
    function add_Removed(handler: TypedEventHandler_2__Pnp_IPnpObjectWatcher__Pnp_IPnpObjectUpdate): EventRegistrationToken; safecall;
    procedure remove_Removed(token: EventRegistrationToken); safecall;
    function add_EnumerationCompleted(handler: TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_EnumerationCompleted(token: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__Pnp_IPnpObjectWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Stopped(token: EventRegistrationToken); safecall;
    function get_Status: DeviceWatcherStatus; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    property Status: DeviceWatcherStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  AsyncOperationCompletedHandler_1__Pnp_IPnpObject_Delegate_Base = interface(IUnknown)
  ['{9D615463-6879-521F-8E97-E66D3DDBC95E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  AsyncOperationCompletedHandler_1__Pnp_IPnpObject = interface(AsyncOperationCompletedHandler_1__Pnp_IPnpObject_Delegate_Base)
  ['{863BDB04-0585-5767-A64A-B247CE04BE47}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Pnp_IPnpObject; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IAsyncOperation_1__Pnp_IPnpObject_Base = interface(IInspectable)
  ['{22B0FB93-30E6-501A-BD3B-9FA3063E9C16}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IAsyncOperation_1__Pnp_IPnpObject = interface(IAsyncOperation_1__Pnp_IPnpObject_Base)
  ['{DCC6CC16-85D7-5A00-8E63-9BC7075C0B08}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Pnp_IPnpObject); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Pnp_IPnpObject; safecall;
    function GetResults: Pnp_IPnpObject; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Pnp_IPnpObject read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IIterator_1__Pnp_IPnpObject = interface(IInspectable)
  ['{DEA7DBDA-BCCA-58DD-96FB-3FBEA7FAF5D8}']
    function get_Current: Pnp_IPnpObject; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PPnp_IPnpObject): Cardinal; safecall;
    property Current: Pnp_IPnpObject read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IIterable_1__Pnp_IPnpObject_Base = interface(IInspectable)
  ['{30B50092-36EE-53FF-9450-029004436C60}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  IIterable_1__Pnp_IPnpObject = interface(IIterable_1__Pnp_IPnpObject_Base)
  ['{17677D16-E3DB-51B9-AF2E-D4EDFB202D13}']
    function First: IIterator_1__Pnp_IPnpObject; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>
  [WinRTClassNameAttribute(SPnp_PnpObjectCollection)]
  IVectorView_1__Pnp_IPnpObject = interface(IInspectable)
  ['{5B091106-8910-5FE6-8C50-A27C65BD860C}']
    function GetAt(index: Cardinal): Pnp_IPnpObject; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Pnp_IPnpObject; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PPnp_IPnpObject): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject_Delegate_Base = interface(IUnknown)
  ['{811D834C-A15E-5522-B7F4-E53004FC58FF}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject = interface(AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject_Delegate_Base)
  ['{43B26CAC-1267-5096-A034-0C4142CDEDF6}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject_Base = interface(IInspectable)
  ['{F383C2CC-F326-5BBE-95D1-CBC24714EF86}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Enumeration.Pnp.IPnpObject>>
  IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject = interface(IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject_Base)
  ['{E4B7CC1B-E86A-53BF-9BD8-D0505EAA62A5}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject; safecall;
    function GetResults: IVectorView_1__Pnp_IPnpObject; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Pnp_IPnpObject read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Enumeration.Pnp.IPnpObjectStatics
  [WinRTClassNameAttribute(SPnp_PnpObject)]
  Pnp_IPnpObjectStatics = interface(IInspectable)
  ['{B3C32A3D-D168-4660-BBF3-A733B14B6E01}']
    function CreateFromIdAsync(&type: Pnp_PnpObjectType; id: HSTRING; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__Pnp_IPnpObject; safecall;
    function FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject; overload; safecall;
    function FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject; overload; safecall;
    function CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): Pnp_IPnpObjectWatcher; overload; safecall;
    function CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): Pnp_IPnpObjectWatcher; overload; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Enumeration.DeviceThumbnail
  // DualAPI

  // Windows.Devices.Enumeration.EnclosureLocation
  // DualAPI

  // Windows.Devices.Enumeration.DeviceInformationUpdate
  // DualAPI

  // Windows.Devices.Enumeration.DeviceInformationCollection
  // DualAPI

  // Windows.Devices.Enumeration.DeviceWatcher
  // DualAPI

  // Windows.Devices.Enumeration.DeviceInformation
  // DualAPI
  TDeviceInformation = class(TWinRTGenericImportS2<IDeviceInformationStatics, IDeviceInformationStatics2>)
  public
    // -> IDeviceInformationStatics2
    class function GetAqsFilterFromDeviceClass(deviceClass: DeviceClass): HSTRING; static; inline;
    class function CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IDeviceInformation; overload; static; inline;
    class function FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; static; inline;
    class function CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IDeviceWatcher; overload; static; inline;

    // -> IDeviceInformationStatics
    class function CreateFromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IDeviceInformation; overload; static; inline;
    class function CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IDeviceInformation; overload; static; inline;
    class function FindAllAsync: IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; static; inline;
    class function FindAllAsync(deviceClass: DeviceClass): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; static; inline;
    class function FindAllAsync(aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; static; inline;
    class function FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation; overload; static; inline;
    class function CreateWatcher: IDeviceWatcher; overload; static; inline;
    class function CreateWatcher(deviceClass: DeviceClass): IDeviceWatcher; overload; static; inline;
    class function CreateWatcher(aqsFilter: HSTRING): IDeviceWatcher; overload; static; inline;
    class function CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IDeviceWatcher; overload; static; inline;
  end;

  // Windows.Devices.Enumeration.DevicePickerAppearance
  // DualAPI

  // Windows.Devices.Enumeration.DeviceSelectedEventArgs
  // DualAPI

  // Windows.Devices.Enumeration.DeviceDisconnectButtonClickedEventArgs
  // DualAPI

  // Windows.Devices.Enumeration.DevicePickerFilter
  // DualAPI

  // Windows.Devices.Enumeration.DevicePicker
  // DualAPI
  TDevicePicker = class(TWinRTGenericImportI<IDevicePicker>) end;

  // Windows.Devices.Enumeration.Pnp.PnpObjectUpdate
  // DualAPI

  // Windows.Devices.Enumeration.Pnp.PnpObjectCollection
  // DualAPI

  // Windows.Devices.Enumeration.Pnp.PnpObjectWatcher
  // DualAPI

  // Windows.Devices.Enumeration.Pnp.PnpObject
  // DualAPI
  TPnp_PnpObject = class(TWinRTGenericImportS<Pnp_IPnpObjectStatics>)
  public
    // -> Pnp_IPnpObjectStatics
    class function CreateFromIdAsync(&type: Pnp_PnpObjectType; id: HSTRING; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__Pnp_IPnpObject; static; inline;
    class function FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject; overload; static; inline;
    class function FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject; overload; static; inline;
    class function CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): Pnp_IPnpObjectWatcher; overload; static; inline;
    class function CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): Pnp_IPnpObjectWatcher; overload; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TDeviceInformation }

class function TDeviceInformation.CreateFromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IDeviceInformation;
begin
  Result := Statics.CreateFromIdAsync(deviceId);
end;

class function TDeviceInformation.CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IDeviceInformation;
begin
  Result := Statics.CreateFromIdAsync(deviceId, additionalProperties);
end;

class function TDeviceInformation.FindAllAsync: IAsyncOperation_1__IVectorView_1__IDeviceInformation;
begin
  Result := Statics.FindAllAsync;
end;

class function TDeviceInformation.FindAllAsync(deviceClass: DeviceClass): IAsyncOperation_1__IVectorView_1__IDeviceInformation;
begin
  Result := Statics.FindAllAsync(deviceClass);
end;

class function TDeviceInformation.FindAllAsync(aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation;
begin
  Result := Statics.FindAllAsync(aqsFilter);
end;

class function TDeviceInformation.FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__IDeviceInformation;
begin
  Result := Statics.FindAllAsync(aqsFilter, additionalProperties);
end;

class function TDeviceInformation.CreateWatcher: IDeviceWatcher;
begin
  Result := Statics.CreateWatcher;
end;

class function TDeviceInformation.CreateWatcher(deviceClass: DeviceClass): IDeviceWatcher;
begin
  Result := Statics.CreateWatcher(deviceClass);
end;

class function TDeviceInformation.CreateWatcher(aqsFilter: HSTRING): IDeviceWatcher;
begin
  Result := Statics.CreateWatcher(aqsFilter);
end;

class function TDeviceInformation.CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING): IDeviceWatcher;
begin
  Result := Statics.CreateWatcher(aqsFilter, additionalProperties);
end;


class function TDeviceInformation.GetAqsFilterFromDeviceClass(deviceClass: DeviceClass): HSTRING;
begin
  Result := Statics2.GetAqsFilterFromDeviceClass(deviceClass);
end;

class function TDeviceInformation.CreateFromIdAsync(deviceId: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IDeviceInformation;
begin
  Result := Statics2.CreateFromIdAsync(deviceId, additionalProperties, kind);
end;

class function TDeviceInformation.FindAllAsync(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IAsyncOperation_1__IVectorView_1__IDeviceInformation;
begin
  Result := Statics2.FindAllAsync(aqsFilter, additionalProperties, kind);
end;

class function TDeviceInformation.CreateWatcher(aqsFilter: HSTRING; additionalProperties: IIterable_1__HSTRING; kind: DeviceInformationKind): IDeviceWatcher;
begin
  Result := Statics2.CreateWatcher(aqsFilter, additionalProperties, kind);
end;


 { TDevicePicker }

 { TPnp_PnpObject }

class function TPnp_PnpObject.CreateFromIdAsync(&type: Pnp_PnpObjectType; id: HSTRING; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__Pnp_IPnpObject;
begin
  Result := Statics.CreateFromIdAsync(&type, id, requestedProperties);
end;

class function TPnp_PnpObject.FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject;
begin
  Result := Statics.FindAllAsync(&type, requestedProperties);
end;

class function TPnp_PnpObject.FindAllAsync(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): IAsyncOperation_1__IVectorView_1__Pnp_IPnpObject;
begin
  Result := Statics.FindAllAsync(&type, requestedProperties, aqsFilter);
end;

class function TPnp_PnpObject.CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING): Pnp_IPnpObjectWatcher;
begin
  Result := Statics.CreateWatcher(&type, requestedProperties);
end;

class function TPnp_PnpObject.CreateWatcher(&type: Pnp_PnpObjectType; requestedProperties: IIterable_1__HSTRING; aqsFilter: HSTRING): Pnp_IPnpObjectWatcher;
begin
  Result := Statics.CreateWatcher(&type, requestedProperties, aqsFilter);
end;



end.
