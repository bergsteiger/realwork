{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Bluetooth.Advertisement;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Devices.Bluetooth,
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Bluetooth.Advertisement Class Names
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEManufacturerData
  // DualAPI
  SBluetoothLEManufacturerData = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEManufacturerData';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataSection
  // DualAPI
  SBluetoothLEAdvertisementDataSection = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataSection';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisement
  // DualAPI
  SBluetoothLEAdvertisement = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisement';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementBytePattern
  // DualAPI
  SBluetoothLEAdvertisementBytePattern = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementBytePattern';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFilter
  // DualAPI
  SBluetoothLEAdvertisementFilter = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFilter';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcherStoppedEventArgs
  // DualAPI
  SBluetoothLEAdvertisementWatcherStoppedEventArgs = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcherStoppedEventArgs';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcher
  // DualAPI
  SBluetoothLEAdvertisementWatcher = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcher';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementReceivedEventArgs
  // DualAPI
  SBluetoothLEAdvertisementReceivedEventArgs = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementReceivedEventArgs';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataTypes
  // DualAPI
  SBluetoothLEAdvertisementDataTypes = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataTypes';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisherStatusChangedEventArgs
  // DualAPI
  SBluetoothLEAdvertisementPublisherStatusChangedEventArgs = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisherStatusChangedEventArgs';
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisher
  // DualAPI
  SBluetoothLEAdvertisementPublisher = 'Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisher';


type
  // Forward declare interfaces
  // Windows.Foundation.IReference`1<Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFlags>
  IReference_1__BluetoothLEAdvertisementFlags = interface;
  PIReference_1__BluetoothLEAdvertisementFlags = ^IReference_1__BluetoothLEAdvertisementFlags;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData
  IBluetoothLEManufacturerData = interface;
  PIBluetoothLEManufacturerData = ^IBluetoothLEManufacturerData;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IIterator_1__IBluetoothLEManufacturerData = interface;
  PIIterator_1__IBluetoothLEManufacturerData = ^IIterator_1__IBluetoothLEManufacturerData;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IIterable_1__IBluetoothLEManufacturerData = interface;
  PIIterable_1__IBluetoothLEManufacturerData = ^IIterable_1__IBluetoothLEManufacturerData;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IVectorView_1__IBluetoothLEManufacturerData = interface;
  PIVectorView_1__IBluetoothLEManufacturerData = ^IVectorView_1__IBluetoothLEManufacturerData;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IVector_1__IBluetoothLEManufacturerData = interface;
  PIVector_1__IBluetoothLEManufacturerData = ^IVector_1__IBluetoothLEManufacturerData;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection
  IBluetoothLEAdvertisementDataSection = interface;
  PIBluetoothLEAdvertisementDataSection = ^IBluetoothLEAdvertisementDataSection;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IIterator_1__IBluetoothLEAdvertisementDataSection = interface;
  PIIterator_1__IBluetoothLEAdvertisementDataSection = ^IIterator_1__IBluetoothLEAdvertisementDataSection;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IIterable_1__IBluetoothLEAdvertisementDataSection = interface;
  PIIterable_1__IBluetoothLEAdvertisementDataSection = ^IIterable_1__IBluetoothLEAdvertisementDataSection;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IVectorView_1__IBluetoothLEAdvertisementDataSection = interface;
  PIVectorView_1__IBluetoothLEAdvertisementDataSection = ^IVectorView_1__IBluetoothLEAdvertisementDataSection;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IVector_1__IBluetoothLEAdvertisementDataSection = interface;
  PIVector_1__IBluetoothLEAdvertisementDataSection = ^IVector_1__IBluetoothLEAdvertisementDataSection;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisement
  IBluetoothLEAdvertisement = interface;
  PIBluetoothLEAdvertisement = ^IBluetoothLEAdvertisement;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern
  IBluetoothLEAdvertisementBytePattern = interface;
  PIBluetoothLEAdvertisementBytePattern = ^IBluetoothLEAdvertisementBytePattern;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IIterator_1__IBluetoothLEAdvertisementBytePattern = interface;
  PIIterator_1__IBluetoothLEAdvertisementBytePattern = ^IIterator_1__IBluetoothLEAdvertisementBytePattern;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IIterable_1__IBluetoothLEAdvertisementBytePattern = interface;
  PIIterable_1__IBluetoothLEAdvertisementBytePattern = ^IIterable_1__IBluetoothLEAdvertisementBytePattern;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IVectorView_1__IBluetoothLEAdvertisementBytePattern = interface;
  PIVectorView_1__IBluetoothLEAdvertisementBytePattern = ^IVectorView_1__IBluetoothLEAdvertisementBytePattern;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IVector_1__IBluetoothLEAdvertisementBytePattern = interface;
  PIVector_1__IBluetoothLEAdvertisementBytePattern = ^IVector_1__IBluetoothLEAdvertisementBytePattern;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementFilter
  IBluetoothLEAdvertisementFilter = interface;
  PIBluetoothLEAdvertisementFilter = ^IBluetoothLEAdvertisementFilter;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherStoppedEventArgs
  IBluetoothLEAdvertisementWatcherStoppedEventArgs = interface;
  PIBluetoothLEAdvertisementWatcherStoppedEventArgs = ^IBluetoothLEAdvertisementWatcherStoppedEventArgs;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs
  IBluetoothLEAdvertisementReceivedEventArgs = interface;
  PIBluetoothLEAdvertisementReceivedEventArgs = ^IBluetoothLEAdvertisementReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs = interface;
  PTypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs = ^TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherStoppedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs = interface;
  PTypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs = ^TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher
  IBluetoothLEAdvertisementWatcher = interface;
  PIBluetoothLEAdvertisementWatcher = ^IBluetoothLEAdvertisementWatcher;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherFactory
  IBluetoothLEAdvertisementWatcherFactory = interface;
  PIBluetoothLEAdvertisementWatcherFactory = ^IBluetoothLEAdvertisementWatcherFactory;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSectionFactory
  IBluetoothLEAdvertisementDataSectionFactory = interface;
  PIBluetoothLEAdvertisementDataSectionFactory = ^IBluetoothLEAdvertisementDataSectionFactory;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerDataFactory
  IBluetoothLEManufacturerDataFactory = interface;
  PIBluetoothLEManufacturerDataFactory = ^IBluetoothLEManufacturerDataFactory;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePatternFactory
  IBluetoothLEAdvertisementBytePatternFactory = interface;
  PIBluetoothLEAdvertisementBytePatternFactory = ^IBluetoothLEAdvertisementBytePatternFactory;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataTypesStatics
  IBluetoothLEAdvertisementDataTypesStatics = interface;
  PIBluetoothLEAdvertisementDataTypesStatics = ^IBluetoothLEAdvertisementDataTypesStatics;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherStatusChangedEventArgs
  IBluetoothLEAdvertisementPublisherStatusChangedEventArgs = interface;
  PIBluetoothLEAdvertisementPublisherStatusChangedEventArgs = ^IBluetoothLEAdvertisementPublisherStatusChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherStatusChangedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs = interface;
  PTypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs = ^TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisher
  IBluetoothLEAdvertisementPublisher = interface;
  PIBluetoothLEAdvertisementPublisher = ^IBluetoothLEAdvertisementPublisher;

  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherFactory
  IBluetoothLEAdvertisementPublisherFactory = interface;
  PIBluetoothLEAdvertisementPublisherFactory = ^IBluetoothLEAdvertisementPublisherFactory;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IIterator_1__IBluetoothLEAdvertisementReceivedEventArgs = interface;
  PIIterator_1__IBluetoothLEAdvertisementReceivedEventArgs = ^IIterator_1__IBluetoothLEAdvertisementReceivedEventArgs;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IIterable_1__IBluetoothLEAdvertisementReceivedEventArgs = interface;
  PIIterable_1__IBluetoothLEAdvertisementReceivedEventArgs = ^IIterable_1__IBluetoothLEAdvertisementReceivedEventArgs;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IVectorView_1__IBluetoothLEAdvertisementReceivedEventArgs = interface;
  PIVectorView_1__IBluetoothLEAdvertisementReceivedEventArgs = ^IVectorView_1__IBluetoothLEAdvertisementReceivedEventArgs;


  // Emit Forwarded interfaces
  // Windows.Devices.Bluetooth.Advertisement Interfaces
  // Windows.Foundation.IReference`1<Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFlags>
  IReference_1__BluetoothLEAdvertisementFlags = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: BluetoothLEAdvertisementFlags; safecall;
    property Value: BluetoothLEAdvertisementFlags read get_Value;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData
  [WinRTClassNameAttribute(SBluetoothLEManufacturerData)]
  IBluetoothLEManufacturerData = interface(IInspectable)
  ['{912DBA18-6963-4533-B061-4694DAFB34E5}']
    function get_CompanyId: Word; safecall;
    procedure put_CompanyId(value: Word); safecall;
    function get_Data: IBuffer; safecall;
    procedure put_Data(value: IBuffer); safecall;
    property CompanyId: Word read get_CompanyId write put_CompanyId;
    property Data: IBuffer read get_Data write put_Data;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IIterator_1__IBluetoothLEManufacturerData = interface(IInspectable)
  ['{1AFC1F61-BE0F-5D68-A1B5-002CA2D6339F}']
    function get_Current: IBluetoothLEManufacturerData; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIBluetoothLEManufacturerData): Cardinal; safecall;
    property Current: IBluetoothLEManufacturerData read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IIterable_1__IBluetoothLEManufacturerData_Base = interface(IInspectable)
  ['{834A4CAC-BB8B-5F0F-9F28-4DBC98C17907}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IIterable_1__IBluetoothLEManufacturerData = interface(IIterable_1__IBluetoothLEManufacturerData_Base)
  ['{BB452D0A-A575-5A1A-B77F-4938C6FF9A09}']
    function First: IIterator_1__IBluetoothLEManufacturerData; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IVectorView_1__IBluetoothLEManufacturerData = interface(IInspectable)
  ['{362D1A87-BBD6-5B43-A0B8-139A1F132948}']
    function GetAt(index: Cardinal): IBluetoothLEManufacturerData; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IBluetoothLEManufacturerData; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEManufacturerData): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerData>
  IVector_1__IBluetoothLEManufacturerData = interface(IInspectable)
  ['{A18B4E27-ABEE-502A-B326-87787C366F13}']
    function GetAt(index: Cardinal): IBluetoothLEManufacturerData; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IBluetoothLEManufacturerData; safecall;
    function IndexOf(value: IBluetoothLEManufacturerData; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IBluetoothLEManufacturerData); safecall;
    procedure InsertAt(index: Cardinal; value: IBluetoothLEManufacturerData); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IBluetoothLEManufacturerData); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEManufacturerData): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIBluetoothLEManufacturerData); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementDataSection)]
  IBluetoothLEAdvertisementDataSection = interface(IInspectable)
  ['{D7213314-3A43-40F9-B6F0-92BFEFC34AE3}']
    function get_DataType: Byte; safecall;
    procedure put_DataType(value: Byte); safecall;
    function get_Data: IBuffer; safecall;
    procedure put_Data(value: IBuffer); safecall;
    property Data: IBuffer read get_Data write put_Data;
    property DataType: Byte read get_DataType write put_DataType;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IIterator_1__IBluetoothLEAdvertisementDataSection = interface(IInspectable)
  ['{28C6C337-33E6-5B6B-A8C0-CB101A838EFE}']
    function get_Current: IBluetoothLEAdvertisementDataSection; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIBluetoothLEAdvertisementDataSection): Cardinal; safecall;
    property Current: IBluetoothLEAdvertisementDataSection read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IIterable_1__IBluetoothLEAdvertisementDataSection_Base = interface(IInspectable)
  ['{DB98B5D1-897E-59CC-B86A-7B8855AC98AF}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IIterable_1__IBluetoothLEAdvertisementDataSection = interface(IIterable_1__IBluetoothLEAdvertisementDataSection_Base)
  ['{F68192BA-2B18-58A5-A3BA-1F874813B0B2}']
    function First: IIterator_1__IBluetoothLEAdvertisementDataSection; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IVectorView_1__IBluetoothLEAdvertisementDataSection = interface(IInspectable)
  ['{6619200D-D012-530E-A769-1B060E574B9A}']
    function GetAt(index: Cardinal): IBluetoothLEAdvertisementDataSection; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IBluetoothLEAdvertisementDataSection; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEAdvertisementDataSection): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSection>
  IVector_1__IBluetoothLEAdvertisementDataSection = interface(IInspectable)
  ['{27485048-DEEF-57A1-8FF9-90B75BF5E3BD}']
    function GetAt(index: Cardinal): IBluetoothLEAdvertisementDataSection; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IBluetoothLEAdvertisementDataSection; safecall;
    function IndexOf(value: IBluetoothLEAdvertisementDataSection; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IBluetoothLEAdvertisementDataSection); safecall;
    procedure InsertAt(index: Cardinal; value: IBluetoothLEAdvertisementDataSection); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IBluetoothLEAdvertisementDataSection); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEAdvertisementDataSection): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIBluetoothLEAdvertisementDataSection); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisement
  [WinRTClassNameAttribute(SBluetoothLEAdvertisement)]
  IBluetoothLEAdvertisement = interface(IInspectable)
  ['{066FB2B7-33D1-4E7D-8367-CF81D0F79653}']
    function get_Flags: IReference_1__BluetoothLEAdvertisementFlags; safecall;
    procedure put_Flags(value: IReference_1__BluetoothLEAdvertisementFlags); safecall;
    function get_LocalName: HSTRING; safecall;
    procedure put_LocalName(value: HSTRING); safecall;
    function get_ServiceUuids: IVector_1__TGuid; safecall;
    function get_ManufacturerData: IVector_1__IBluetoothLEManufacturerData; safecall;
    function get_DataSections: IVector_1__IBluetoothLEAdvertisementDataSection; safecall;
    function GetManufacturerDataByCompanyId(companyId: Word): IVectorView_1__IBluetoothLEManufacturerData; safecall;
    function GetSectionsByType(&type: Byte): IVectorView_1__IBluetoothLEAdvertisementDataSection; safecall;
    property DataSections: IVector_1__IBluetoothLEAdvertisementDataSection read get_DataSections;
    property Flags: IReference_1__BluetoothLEAdvertisementFlags read get_Flags write put_Flags;
    property LocalName: HSTRING read get_LocalName write put_LocalName;
    property ManufacturerData: IVector_1__IBluetoothLEManufacturerData read get_ManufacturerData;
    property ServiceUuids: IVector_1__TGuid read get_ServiceUuids;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementBytePattern)]
  IBluetoothLEAdvertisementBytePattern = interface(IInspectable)
  ['{FBFAD7F2-B9C5-4A08-BC51-502F8EF68A79}']
    function get_DataType: Byte; safecall;
    procedure put_DataType(value: Byte); safecall;
    function get_Offset: SmallInt; safecall;
    procedure put_Offset(value: SmallInt); safecall;
    function get_Data: IBuffer; safecall;
    procedure put_Data(value: IBuffer); safecall;
    property Data: IBuffer read get_Data write put_Data;
    property DataType: Byte read get_DataType write put_DataType;
    property Offset: SmallInt read get_Offset write put_Offset;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IIterator_1__IBluetoothLEAdvertisementBytePattern = interface(IInspectable)
  ['{780018BB-FD2E-5FC9-AB41-844D7405DB8A}']
    function get_Current: IBluetoothLEAdvertisementBytePattern; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIBluetoothLEAdvertisementBytePattern): Cardinal; safecall;
    property Current: IBluetoothLEAdvertisementBytePattern read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IIterable_1__IBluetoothLEAdvertisementBytePattern_Base = interface(IInspectable)
  ['{1E3FADEE-54AC-538B-8777-351AFB78CB74}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IIterable_1__IBluetoothLEAdvertisementBytePattern = interface(IIterable_1__IBluetoothLEAdvertisementBytePattern_Base)
  ['{EB205564-A2C2-591F-AAB5-82EAEBFBC6DA}']
    function First: IIterator_1__IBluetoothLEAdvertisementBytePattern; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IVectorView_1__IBluetoothLEAdvertisementBytePattern = interface(IInspectable)
  ['{D57CF71B-0B53-5F7B-A0D9-4690FB2588C7}']
    function GetAt(index: Cardinal): IBluetoothLEAdvertisementBytePattern; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IBluetoothLEAdvertisementBytePattern; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEAdvertisementBytePattern): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePattern>
  IVector_1__IBluetoothLEAdvertisementBytePattern = interface(IInspectable)
  ['{3E74F04D-A6C9-5DC1-85B1-CE32D80C638A}']
    function GetAt(index: Cardinal): IBluetoothLEAdvertisementBytePattern; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IBluetoothLEAdvertisementBytePattern; safecall;
    function IndexOf(value: IBluetoothLEAdvertisementBytePattern; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IBluetoothLEAdvertisementBytePattern); safecall;
    procedure InsertAt(index: Cardinal; value: IBluetoothLEAdvertisementBytePattern); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IBluetoothLEAdvertisementBytePattern); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEAdvertisementBytePattern): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIBluetoothLEAdvertisementBytePattern); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementFilter
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementFilter)]
  IBluetoothLEAdvertisementFilter = interface(IInspectable)
  ['{131EB0D3-D04E-47B1-837E-49405BF6F80F}']
    function get_Advertisement: IBluetoothLEAdvertisement; safecall;
    procedure put_Advertisement(value: IBluetoothLEAdvertisement); safecall;
    function get_BytePatterns: IVector_1__IBluetoothLEAdvertisementBytePattern; safecall;
    property Advertisement: IBluetoothLEAdvertisement read get_Advertisement write put_Advertisement;
    property BytePatterns: IVector_1__IBluetoothLEAdvertisementBytePattern read get_BytePatterns;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherStoppedEventArgs
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementWatcherStoppedEventArgs)]
  IBluetoothLEAdvertisementWatcherStoppedEventArgs = interface(IInspectable)
  ['{DD40F84D-E7B9-43E3-9C04-0685D085FD8C}']
    function get_Error: BluetoothError; safecall;
    property Error: BluetoothError read get_Error;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementReceivedEventArgs)]
  IBluetoothLEAdvertisementReceivedEventArgs = interface(IInspectable)
  ['{27987DDF-E596-41BE-8D43-9E6731D4A913}']
    function get_RawSignalStrengthInDBm: SmallInt; safecall;
    function get_BluetoothAddress: UInt64; safecall;
    function get_AdvertisementType: BluetoothLEAdvertisementType; safecall;
    function get_Timestamp: DateTime; safecall;
    function get_Advertisement: IBluetoothLEAdvertisement; safecall;
    property Advertisement: IBluetoothLEAdvertisement read get_Advertisement;
    property AdvertisementType: BluetoothLEAdvertisementType read get_AdvertisementType;
    property BluetoothAddress: UInt64 read get_BluetoothAddress;
    property RawSignalStrengthInDBm: SmallInt read get_RawSignalStrengthInDBm;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{90EB4ECA-D465-5EA0-A61C-033C8C5ECEF2}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs = interface(TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs_Delegate_Base)
  ['{FD2452E0-5167-53D2-BADA-405DDF441262}']
    procedure Invoke(sender: IBluetoothLEAdvertisementWatcher; args: IBluetoothLEAdvertisementReceivedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherStoppedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs_Delegate_Base = interface(IUnknown)
  ['{9936A4DB-DC99-55C3-9E9B-BF4854BD9EAB}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherStoppedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs = interface(TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs_Delegate_Base)
  ['{859B97EB-2DFE-59AD-AD1B-3C93C7512179}']
    procedure Invoke(sender: IBluetoothLEAdvertisementWatcher; args: IBluetoothLEAdvertisementWatcherStoppedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcher
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementWatcher)]
  IBluetoothLEAdvertisementWatcher = interface(IInspectable)
  ['{A6AC336F-F3D3-4297-8D6C-C81EA6623F40}']
    function get_MinSamplingInterval: TimeSpan; safecall;
    function get_MaxSamplingInterval: TimeSpan; safecall;
    function get_MinOutOfRangeTimeout: TimeSpan; safecall;
    function get_MaxOutOfRangeTimeout: TimeSpan; safecall;
    function get_Status: BluetoothLEAdvertisementWatcherStatus; safecall;
    function get_ScanningMode: BluetoothLEScanningMode; safecall;
    procedure put_ScanningMode(value: BluetoothLEScanningMode); safecall;
    function get_SignalStrengthFilter: IBluetoothSignalStrengthFilter; safecall;
    procedure put_SignalStrengthFilter(value: IBluetoothSignalStrengthFilter); safecall;
    function get_AdvertisementFilter: IBluetoothLEAdvertisementFilter; safecall;
    procedure put_AdvertisementFilter(value: IBluetoothLEAdvertisementFilter); safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    function add_Received(handler: TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Received(token: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__IBluetoothLEAdvertisementWatcher__IBluetoothLEAdvertisementWatcherStoppedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Stopped(token: EventRegistrationToken); safecall;
    property AdvertisementFilter: IBluetoothLEAdvertisementFilter read get_AdvertisementFilter write put_AdvertisementFilter;
    property MaxOutOfRangeTimeout: TimeSpan read get_MaxOutOfRangeTimeout;
    property MaxSamplingInterval: TimeSpan read get_MaxSamplingInterval;
    property MinOutOfRangeTimeout: TimeSpan read get_MinOutOfRangeTimeout;
    property MinSamplingInterval: TimeSpan read get_MinSamplingInterval;
    property ScanningMode: BluetoothLEScanningMode read get_ScanningMode write put_ScanningMode;
    property SignalStrengthFilter: IBluetoothSignalStrengthFilter read get_SignalStrengthFilter write put_SignalStrengthFilter;
    property Status: BluetoothLEAdvertisementWatcherStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherFactory
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementWatcher)]
  IBluetoothLEAdvertisementWatcherFactory = interface(IInspectable)
  ['{9AAF2D56-39AC-453E-B32A-85C657E017F1}']
    function Create(advertisementFilter: IBluetoothLEAdvertisementFilter): IBluetoothLEAdvertisementWatcher; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSectionFactory
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementDataSection)]
  IBluetoothLEAdvertisementDataSectionFactory = interface(IInspectable)
  ['{E7A40942-A845-4045-BF7E-3E9971DB8A6B}']
    function Create(dataType: Byte; data: IBuffer): IBluetoothLEAdvertisementDataSection; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerDataFactory
  [WinRTClassNameAttribute(SBluetoothLEManufacturerData)]
  IBluetoothLEManufacturerDataFactory = interface(IInspectable)
  ['{C09B39F8-319A-441E-8DE5-66A81E877A6C}']
    function Create(companyId: Word; data: IBuffer): IBluetoothLEManufacturerData; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePatternFactory
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementBytePattern)]
  IBluetoothLEAdvertisementBytePatternFactory = interface(IInspectable)
  ['{C2E24D73-FD5C-4EC3-BE2A-9CA6FA11B7BD}']
    function Create(dataType: Byte; offset: SmallInt; data: IBuffer): IBluetoothLEAdvertisementBytePattern; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataTypesStatics
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementDataTypes)]
  IBluetoothLEAdvertisementDataTypesStatics = interface(IInspectable)
  ['{3BB6472F-0606-434B-A76E-74159F0684D3}']
    function get_Flags: Byte; safecall;
    function get_IncompleteService16BitUuids: Byte; safecall;
    function get_CompleteService16BitUuids: Byte; safecall;
    function get_IncompleteService32BitUuids: Byte; safecall;
    function get_CompleteService32BitUuids: Byte; safecall;
    function get_IncompleteService128BitUuids: Byte; safecall;
    function get_CompleteService128BitUuids: Byte; safecall;
    function get_ShortenedLocalName: Byte; safecall;
    function get_CompleteLocalName: Byte; safecall;
    function get_TxPowerLevel: Byte; safecall;
    function get_SlaveConnectionIntervalRange: Byte; safecall;
    function get_ServiceSolicitation16BitUuids: Byte; safecall;
    function get_ServiceSolicitation32BitUuids: Byte; safecall;
    function get_ServiceSolicitation128BitUuids: Byte; safecall;
    function get_ServiceData16BitUuids: Byte; safecall;
    function get_ServiceData32BitUuids: Byte; safecall;
    function get_ServiceData128BitUuids: Byte; safecall;
    function get_PublicTargetAddress: Byte; safecall;
    function get_RandomTargetAddress: Byte; safecall;
    function get_Appearance: Byte; safecall;
    function get_AdvertisingInterval: Byte; safecall;
    function get_ManufacturerSpecificData: Byte; safecall;
    property AdvertisingInterval: Byte read get_AdvertisingInterval;
    property Appearance: Byte read get_Appearance;
    property CompleteLocalName: Byte read get_CompleteLocalName;
    property CompleteService128BitUuids: Byte read get_CompleteService128BitUuids;
    property CompleteService16BitUuids: Byte read get_CompleteService16BitUuids;
    property CompleteService32BitUuids: Byte read get_CompleteService32BitUuids;
    property Flags: Byte read get_Flags;
    property IncompleteService128BitUuids: Byte read get_IncompleteService128BitUuids;
    property IncompleteService16BitUuids: Byte read get_IncompleteService16BitUuids;
    property IncompleteService32BitUuids: Byte read get_IncompleteService32BitUuids;
    property ManufacturerSpecificData: Byte read get_ManufacturerSpecificData;
    property PublicTargetAddress: Byte read get_PublicTargetAddress;
    property RandomTargetAddress: Byte read get_RandomTargetAddress;
    property ServiceData128BitUuids: Byte read get_ServiceData128BitUuids;
    property ServiceData16BitUuids: Byte read get_ServiceData16BitUuids;
    property ServiceData32BitUuids: Byte read get_ServiceData32BitUuids;
    property ServiceSolicitation128BitUuids: Byte read get_ServiceSolicitation128BitUuids;
    property ServiceSolicitation16BitUuids: Byte read get_ServiceSolicitation16BitUuids;
    property ServiceSolicitation32BitUuids: Byte read get_ServiceSolicitation32BitUuids;
    property ShortenedLocalName: Byte read get_ShortenedLocalName;
    property SlaveConnectionIntervalRange: Byte read get_SlaveConnectionIntervalRange;
    property TxPowerLevel: Byte read get_TxPowerLevel;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherStatusChangedEventArgs
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementPublisherStatusChangedEventArgs)]
  IBluetoothLEAdvertisementPublisherStatusChangedEventArgs = interface(IInspectable)
  ['{09C2BD9F-2DFF-4B23-86EE-0D14FB94AEAE}']
    function get_Status: BluetoothLEAdvertisementPublisherStatus; safecall;
    function get_Error: BluetoothError; safecall;
    property Error: BluetoothError read get_Error;
    property Status: BluetoothLEAdvertisementPublisherStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherStatusChangedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{C2FFA4F1-5893-54A8-BD94-AA1198B05D07}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisher,Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherStatusChangedEventArgs>
  TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs = interface(TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs_Delegate_Base)
  ['{06B838A8-7B0F-536E-8726-131A41D9D97E}']
    procedure Invoke(sender: IBluetoothLEAdvertisementPublisher; args: IBluetoothLEAdvertisementPublisherStatusChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisher
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementPublisher)]
  IBluetoothLEAdvertisementPublisher = interface(IInspectable)
  ['{CDE820F9-D9FA-43D6-A264-DDD8B7DA8B78}']
    function get_Status: BluetoothLEAdvertisementPublisherStatus; safecall;
    function get_Advertisement: IBluetoothLEAdvertisement; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    function add_StatusChanged(handler: TypedEventHandler_2__IBluetoothLEAdvertisementPublisher__IBluetoothLEAdvertisementPublisherStatusChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StatusChanged(token: EventRegistrationToken); safecall;
    property Advertisement: IBluetoothLEAdvertisement read get_Advertisement;
    property Status: BluetoothLEAdvertisementPublisherStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherFactory
  [WinRTClassNameAttribute(SBluetoothLEAdvertisementPublisher)]
  IBluetoothLEAdvertisementPublisherFactory = interface(IInspectable)
  ['{5C5F065E-B863-4981-A1AF-1C544D8B0C0D}']
    function Create(advertisement: IBluetoothLEAdvertisement): IBluetoothLEAdvertisementPublisher; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IIterator_1__IBluetoothLEAdvertisementReceivedEventArgs = interface(IInspectable)
  ['{F0FFB2E4-7E87-598B-9639-93EEEC8D41C6}']
    function get_Current: IBluetoothLEAdvertisementReceivedEventArgs; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIBluetoothLEAdvertisementReceivedEventArgs): Cardinal; safecall;
    property Current: IBluetoothLEAdvertisementReceivedEventArgs read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IIterable_1__IBluetoothLEAdvertisementReceivedEventArgs_Base = interface(IInspectable)
  ['{34F6412F-8314-5205-967C-DB357C9A42A7}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IIterable_1__IBluetoothLEAdvertisementReceivedEventArgs = interface(IIterable_1__IBluetoothLEAdvertisementReceivedEventArgs_Base)
  ['{DCC7A122-E1B2-5805-8D67-9AF550BC5824}']
    function First: IIterator_1__IBluetoothLEAdvertisementReceivedEventArgs; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementReceivedEventArgs>
  IVectorView_1__IBluetoothLEAdvertisementReceivedEventArgs = interface(IInspectable)
  ['{DAAAEAA7-D307-5BF1-A0DB-0A811F07970B}']
    function GetAt(index: Cardinal): IBluetoothLEAdvertisementReceivedEventArgs; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IBluetoothLEAdvertisementReceivedEventArgs; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBluetoothLEAdvertisementReceivedEventArgs): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEManufacturerData
  // DualAPI
  TBluetoothLEManufacturerData = class(TWinRTGenericImportFI<IBluetoothLEManufacturerDataFactory, IBluetoothLEManufacturerData>)
  public
    // -> IBluetoothLEManufacturerDataFactory
    class function Create(companyId: Word; data: IBuffer): IBluetoothLEManufacturerData; overload; static; inline;
  end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataSection
  // DualAPI
  TBluetoothLEAdvertisementDataSection = class(TWinRTGenericImportFI<IBluetoothLEAdvertisementDataSectionFactory, IBluetoothLEAdvertisementDataSection>)
  public
    // -> IBluetoothLEAdvertisementDataSectionFactory
    class function Create(dataType: Byte; data: IBuffer): IBluetoothLEAdvertisementDataSection; overload; static; inline;
  end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisement
  // DualAPI
  TBluetoothLEAdvertisement = class(TWinRTGenericImportI<IBluetoothLEAdvertisement>) end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementBytePattern
  // DualAPI
  TBluetoothLEAdvertisementBytePattern = class(TWinRTGenericImportFI<IBluetoothLEAdvertisementBytePatternFactory, IBluetoothLEAdvertisementBytePattern>)
  public
    // -> IBluetoothLEAdvertisementBytePatternFactory
    class function Create(dataType: Byte; offset: SmallInt; data: IBuffer): IBluetoothLEAdvertisementBytePattern; overload; static; inline;
  end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFilter
  // DualAPI
  TBluetoothLEAdvertisementFilter = class(TWinRTGenericImportI<IBluetoothLEAdvertisementFilter>) end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcherStoppedEventArgs
  // DualAPI

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcher
  // DualAPI
  TBluetoothLEAdvertisementWatcher = class(TWinRTGenericImportFI<IBluetoothLEAdvertisementWatcherFactory, IBluetoothLEAdvertisementWatcher>)
  public
    // -> IBluetoothLEAdvertisementWatcherFactory
    class function Create(advertisementFilter: IBluetoothLEAdvertisementFilter): IBluetoothLEAdvertisementWatcher; overload; static; inline;
  end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementReceivedEventArgs
  // DualAPI

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementDataTypes
  // DualAPI
  TBluetoothLEAdvertisementDataTypes = class(TWinRTGenericImportS<IBluetoothLEAdvertisementDataTypesStatics>)
  public
    // -> IBluetoothLEAdvertisementDataTypesStatics
    class function get_Flags: Byte; static; inline;
    class function get_IncompleteService16BitUuids: Byte; static; inline;
    class function get_CompleteService16BitUuids: Byte; static; inline;
    class function get_IncompleteService32BitUuids: Byte; static; inline;
    class function get_CompleteService32BitUuids: Byte; static; inline;
    class function get_IncompleteService128BitUuids: Byte; static; inline;
    class function get_CompleteService128BitUuids: Byte; static; inline;
    class function get_ShortenedLocalName: Byte; static; inline;
    class function get_CompleteLocalName: Byte; static; inline;
    class function get_TxPowerLevel: Byte; static; inline;
    class function get_SlaveConnectionIntervalRange: Byte; static; inline;
    class function get_ServiceSolicitation16BitUuids: Byte; static; inline;
    class function get_ServiceSolicitation32BitUuids: Byte; static; inline;
    class function get_ServiceSolicitation128BitUuids: Byte; static; inline;
    class function get_ServiceData16BitUuids: Byte; static; inline;
    class function get_ServiceData32BitUuids: Byte; static; inline;
    class function get_ServiceData128BitUuids: Byte; static; inline;
    class function get_PublicTargetAddress: Byte; static; inline;
    class function get_RandomTargetAddress: Byte; static; inline;
    class function get_Appearance: Byte; static; inline;
    class function get_AdvertisingInterval: Byte; static; inline;
    class function get_ManufacturerSpecificData: Byte; static; inline;
    class property AdvertisingInterval: Byte read get_AdvertisingInterval;
    class property Appearance: Byte read get_Appearance;
    class property CompleteLocalName: Byte read get_CompleteLocalName;
    class property CompleteService128BitUuids: Byte read get_CompleteService128BitUuids;
    class property CompleteService16BitUuids: Byte read get_CompleteService16BitUuids;
    class property CompleteService32BitUuids: Byte read get_CompleteService32BitUuids;
    class property Flags: Byte read get_Flags;
    class property IncompleteService128BitUuids: Byte read get_IncompleteService128BitUuids;
    class property IncompleteService16BitUuids: Byte read get_IncompleteService16BitUuids;
    class property IncompleteService32BitUuids: Byte read get_IncompleteService32BitUuids;
    class property ManufacturerSpecificData: Byte read get_ManufacturerSpecificData;
    class property PublicTargetAddress: Byte read get_PublicTargetAddress;
    class property RandomTargetAddress: Byte read get_RandomTargetAddress;
    class property ServiceData128BitUuids: Byte read get_ServiceData128BitUuids;
    class property ServiceData16BitUuids: Byte read get_ServiceData16BitUuids;
    class property ServiceData32BitUuids: Byte read get_ServiceData32BitUuids;
    class property ServiceSolicitation128BitUuids: Byte read get_ServiceSolicitation128BitUuids;
    class property ServiceSolicitation16BitUuids: Byte read get_ServiceSolicitation16BitUuids;
    class property ServiceSolicitation32BitUuids: Byte read get_ServiceSolicitation32BitUuids;
    class property ShortenedLocalName: Byte read get_ShortenedLocalName;
    class property SlaveConnectionIntervalRange: Byte read get_SlaveConnectionIntervalRange;
    class property TxPowerLevel: Byte read get_TxPowerLevel;
  end;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisherStatusChangedEventArgs
  // DualAPI

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisher
  // DualAPI
  TBluetoothLEAdvertisementPublisher = class(TWinRTGenericImportFI<IBluetoothLEAdvertisementPublisherFactory, IBluetoothLEAdvertisementPublisher>)
  public
    // -> IBluetoothLEAdvertisementPublisherFactory
    class function Create(advertisement: IBluetoothLEAdvertisement): IBluetoothLEAdvertisementPublisher; overload; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TBluetoothLEManufacturerData }
// Factories for : "BluetoothLEManufacturerData"
// Factory: "Windows.Devices.Bluetooth.Advertisement.IBluetoothLEManufacturerDataFactory"
// -> IBluetoothLEManufacturerDataFactory

class function TBluetoothLEManufacturerData.Create(companyId: Word; data: IBuffer): IBluetoothLEManufacturerData;
begin
  Result := Factory.Create(companyId, data);
end;


 { TBluetoothLEAdvertisementDataSection }
// Factories for : "BluetoothLEAdvertisementDataSection"
// Factory: "Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementDataSectionFactory"
// -> IBluetoothLEAdvertisementDataSectionFactory

class function TBluetoothLEAdvertisementDataSection.Create(dataType: Byte; data: IBuffer): IBluetoothLEAdvertisementDataSection;
begin
  Result := Factory.Create(dataType, data);
end;


 { TBluetoothLEAdvertisement }

 { TBluetoothLEAdvertisementBytePattern }
// Factories for : "BluetoothLEAdvertisementBytePattern"
// Factory: "Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementBytePatternFactory"
// -> IBluetoothLEAdvertisementBytePatternFactory

class function TBluetoothLEAdvertisementBytePattern.Create(dataType: Byte; offset: SmallInt; data: IBuffer): IBluetoothLEAdvertisementBytePattern;
begin
  Result := Factory.Create(dataType, offset, data);
end;


 { TBluetoothLEAdvertisementFilter }

 { TBluetoothLEAdvertisementWatcher }
// Factories for : "BluetoothLEAdvertisementWatcher"
// Factory: "Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementWatcherFactory"
// -> IBluetoothLEAdvertisementWatcherFactory

class function TBluetoothLEAdvertisementWatcher.Create(advertisementFilter: IBluetoothLEAdvertisementFilter): IBluetoothLEAdvertisementWatcher;
begin
  Result := Factory.Create(advertisementFilter);
end;


 { TBluetoothLEAdvertisementDataTypes }

class function TBluetoothLEAdvertisementDataTypes.get_Flags: Byte;
begin
  Result := Statics.get_Flags;
end;

class function TBluetoothLEAdvertisementDataTypes.get_IncompleteService16BitUuids: Byte;
begin
  Result := Statics.get_IncompleteService16BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_CompleteService16BitUuids: Byte;
begin
  Result := Statics.get_CompleteService16BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_IncompleteService32BitUuids: Byte;
begin
  Result := Statics.get_IncompleteService32BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_CompleteService32BitUuids: Byte;
begin
  Result := Statics.get_CompleteService32BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_IncompleteService128BitUuids: Byte;
begin
  Result := Statics.get_IncompleteService128BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_CompleteService128BitUuids: Byte;
begin
  Result := Statics.get_CompleteService128BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ShortenedLocalName: Byte;
begin
  Result := Statics.get_ShortenedLocalName;
end;

class function TBluetoothLEAdvertisementDataTypes.get_CompleteLocalName: Byte;
begin
  Result := Statics.get_CompleteLocalName;
end;

class function TBluetoothLEAdvertisementDataTypes.get_TxPowerLevel: Byte;
begin
  Result := Statics.get_TxPowerLevel;
end;

class function TBluetoothLEAdvertisementDataTypes.get_SlaveConnectionIntervalRange: Byte;
begin
  Result := Statics.get_SlaveConnectionIntervalRange;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceSolicitation16BitUuids: Byte;
begin
  Result := Statics.get_ServiceSolicitation16BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceSolicitation32BitUuids: Byte;
begin
  Result := Statics.get_ServiceSolicitation32BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceSolicitation128BitUuids: Byte;
begin
  Result := Statics.get_ServiceSolicitation128BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceData16BitUuids: Byte;
begin
  Result := Statics.get_ServiceData16BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceData32BitUuids: Byte;
begin
  Result := Statics.get_ServiceData32BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ServiceData128BitUuids: Byte;
begin
  Result := Statics.get_ServiceData128BitUuids;
end;

class function TBluetoothLEAdvertisementDataTypes.get_PublicTargetAddress: Byte;
begin
  Result := Statics.get_PublicTargetAddress;
end;

class function TBluetoothLEAdvertisementDataTypes.get_RandomTargetAddress: Byte;
begin
  Result := Statics.get_RandomTargetAddress;
end;

class function TBluetoothLEAdvertisementDataTypes.get_Appearance: Byte;
begin
  Result := Statics.get_Appearance;
end;

class function TBluetoothLEAdvertisementDataTypes.get_AdvertisingInterval: Byte;
begin
  Result := Statics.get_AdvertisingInterval;
end;

class function TBluetoothLEAdvertisementDataTypes.get_ManufacturerSpecificData: Byte;
begin
  Result := Statics.get_ManufacturerSpecificData;
end;


 { TBluetoothLEAdvertisementPublisher }
// Factories for : "BluetoothLEAdvertisementPublisher"
// Factory: "Windows.Devices.Bluetooth.Advertisement.IBluetoothLEAdvertisementPublisherFactory"
// -> IBluetoothLEAdvertisementPublisherFactory

class function TBluetoothLEAdvertisementPublisher.Create(advertisement: IBluetoothLEAdvertisement): IBluetoothLEAdvertisementPublisher;
begin
  Result := Factory.Create(advertisement);
end;



end.
