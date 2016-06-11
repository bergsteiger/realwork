{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Bluetooth;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Types,
  System.Classes;

{$SCOPEDENUMS ON}


// We have Bluetooth Classic in all platforms except iOS
{$IF defined(MSWINDOWS) or (defined(MACOS) and not defined(IOS)) or defined(ANDROID) or defined(LINUX)}
  {$DEFINE BLUETOOTH_CLASSIC}
{$ENDIF}

// We have Bluetooth LE in all platforms
{$IF defined(MSWINDOWS) or defined(MACOS) or defined(ANDROID) or defined(LINUX)}
  {$DEFINE BLUETOOTH_LE}
{$ENDIF}


type
  EBluetoothException = class(Exception);
  EBluetoothManagerException = class(EBluetoothException);
  EBluetoothAdapterException = class(EBluetoothException);
  EBluetoothDeviceException = class(EBluetoothException);
  EBluetoothServiceException = class(EBluetoothException);
  EBluetoothFormatException = class(EBluetoothException);

  TBluetoothMacAddress = string;
  TBluetoothAdapterState = (Off, &On, Discovering);
  TBluetoothScanMode = (None, Connectable, Discoverable);

  TBluetoothConnectionState = (Disconnected, Connected);

  TBluetoothType = (Unknown, Classic, LE, Dual);
  TBluetoothDeviceState = (None, Paired, Connected);

  TBluetoothUUID = TGUID;
  /// <summary> Class for Bluetooth UUID in 16 bits format </summary>
  TBluetooth16bitsUUID = Word;
  /// <summary> Type for beacon manufacturer data</summary>
  TServiceDataRawData = record
    /// <summary> Contain the Service UUID of the BLE Service Data </summary>
    Key: TBluetoothUUID;
    /// <summary> The Data of the service </summary>
    Value: TBytes;
    constructor create(const AKey: TBluetoothUUID; const AValue: TBytes); overload;
    constructor create(const AServiceData: TPair<TBluetoothUUID,TBytes>); overload;
  end;

  /// <summary> Helper class for easy conversion of 128 bits Bluetooth UUIDs to 16 bits format, and back </summary>
  TBluetoothUUIDHelper = class
  public
    /// <summary> Returns the 16 bits representation (D1 low word) of a given Bluetooth UUID </summary>
    class function GetBluetooth16bitsUUID(const AUUID: TBluetoothUUID): TBluetooth16bitsUUID;
    /// <summary> Returns TBluetoothUUID for a 16 bits fromat UUID </summary>
    class function GetBluetoothUUID(const A16bitsUUID: TBluetooth16bitsUUID): TBluetoothUUID;
    /// <summary> Checks if a given UUID is based on Bluetooth Base UUID </summary>
    class function IsBluetoothBaseUUIDBased(const AUUID: TBluetoothUUID): Boolean;
  end;
  /// <summary> Class for TList<TBluetoothUUID></summary>
  TBluetoothUUIDsList = class(TList<TBluetoothUUID>);

  TBluetoothServiceType = (Primary, Secondary);

  TBluetoothService = record
    Name: string;
    UUID: TBluetoothUUID;
  end;

  TIdentifyUUIDEvent = function(const Sender: TObject; const AUUID: TBluetoothUUID): string of object;

  // --------------------------------------------------------------------- //
  // Common Classes
  // --------------------------------------------------------------------- //

  TBluetoothCustomAdapter = class
  protected
    function GetAddress: TBluetoothMacAddress; virtual; abstract;
    function GetAdapterName: string; virtual; abstract;
    procedure SetAdapterName(const Value: string); virtual; abstract;
    function GetState: TBluetoothAdapterState; virtual; abstract;
  public
    property Address: TBluetoothMacAddress read GetAddress;
    property AdapterName: string read GetAdapterName write SetAdapterName;

    property State: TBluetoothAdapterState read GetState;
  end;

  TBluetoothCustomDevice = class
  protected
    function GetAddress: TBluetoothMacAddress; virtual; abstract;
    function GetDeviceName: string; virtual; abstract;
    function GetBluetoothType: TBluetoothType; virtual; abstract;
  public
    property Address: TBluetoothMacAddress read GetAddress;
    property DeviceName: string read GetDeviceName;
    property BluetoothType: TBluetoothType read GetBluetoothType;
  end;

{$IFDEF BLUETOOTH_CLASSIC}
  ////////////////////////////////////////
  //                                    //
  //         Bluetooth Classic          //
  //                                    //
  ////////////////////////////////////////

type
  EBluetoothSocketException = class(EBluetoothException);

  // --------------------------------------------------------------------- //
  // Forwarded classes
  // --------------------------------------------------------------------- //

  TBluetoothAdapter = class;
  TBluetoothDevice = class;
  TBluetoothServerSocket = class;
  TBluetoothSocket = class;

{$HPPEMIT OPENNAMESPACE}
{$HPPEMIT 'class DELPHICLASS TBluetoothAdapter;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothDevice;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothServerSocket;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothSocket;'}
{$HPPEMIT CLOSENAMESPACE}


  // --------------------------------------------------------------------- //
  // List aliases classes
  // --------------------------------------------------------------------- //
  TBluetoothDeviceList = class(TObjectList<TBluetoothDevice>);
  TBluetoothServiceList = class(TList<TBluetoothService>);

  // --------------------------------------------------------------------- //
  // Event types
  // --------------------------------------------------------------------- //
  TDiscoverableEndEvent = procedure(const Sender: TObject) of object;
  TDiscoveryEndEvent = procedure(const Sender: TObject; const ADeviceList: TBluetoothDeviceList) of object;
  TRemoteRequestPairEvent = procedure(const ADevice: TBluetoothDevice) of object;

  // --------------------------------------------------------------------- //
  // Classes
  // --------------------------------------------------------------------- //
  TBluetoothManager = class
  private class var
    FCurrentManager: TBluetoothManager;
    class function InternalGetBluetoothManager: TBluetoothManager; static;
    class constructor Create;
    class destructor Destroy;
  protected
    class function AddDeviceToList(const ADevice: TBluetoothDevice;
      const ADeviceList: TBluetoothDeviceList): TBluetoothDevice; overload; static;
    class function GetKnownServiceName(const AServiceUUID: TGUID): string; static;
  protected type
    TBluetoothManagerClass = class of TBluetoothManager;
  protected class var
    FBluetoothManagerClass: TBluetoothManagerClass;
    class var FSocketTimeout: Cardinal;
    class var FOnIdentifyCustomUUID: TIdentifyUUIDEvent;
  private
    function GetCurrentAdapter: TBluetoothAdapter;
    function GetLastPairedDevices: TBluetoothDeviceList;
  protected
    FPairedDevices: TBluetoothDeviceList;

    FDiscoveredDevices: TBluetoothDeviceList;
    FLastDiscoveredTimeStamp: TDateTime;

    FOnDiscoverableEnd: TDiscoverableEndEvent;
    FOnDiscoveryEnd: TDiscoveryEndEvent;
    FOnRemoteRequestPair: TRemoteRequestPairEvent;

    function GetConnectionState: TBluetoothConnectionState; virtual; abstract;
    function DoGetClassicAdapter: TBluetoothAdapter; virtual; abstract;
    procedure DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList); virtual;
    procedure DoDiscoverableEnd(const Sender: TObject); virtual;
    procedure DoRemoteRequestPair(const ADevice: TBluetoothDevice); virtual;
    ///  <summary>
    ///  DoEnableBluetooth functionality of EnableBluetooth
    ///  </summary>
    function DoEnableBluetooth: Boolean; virtual; abstract;

    // Platform getter
    class function GetBluetoothManager: TBluetoothManager; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;

    procedure StartDiscovery(Timeout: Cardinal);
    procedure CancelDiscovery;
    procedure StartDiscoverable(Timeout: Cardinal);

    function GetPairedDevices(const AnAdapter: TBluetoothAdapter): TBluetoothDeviceList; overload;
    function GetPairedDevices: TBluetoothDeviceList; overload;
    function CreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket;

    property LastPairedDevices: TBluetoothDeviceList read GetLastPairedDevices;
    property ConnectionState: TBluetoothConnectionState read GetConnectionState;
    property CurrentAdapter: TBluetoothAdapter read GetCurrentAdapter;
    property LastDiscoveredDevices: TBluetoothDeviceList read FDiscoveredDevices;
    property LastDiscoveredTimeStamp: TDateTime read FLastDiscoveredTimeStamp;
    ///  <summary>
    ///  EnableBluetooth shows a system activity that allows the user to turn on Bluetooth
    ///  </summary>
    property EnableBluetooth: Boolean read DoEnableBluetooth;
    { Events }
    property OnDiscoverableEnd: TDiscoverableEndEvent read FOnDiscoverableEnd write FOnDiscoverableEnd;
    property OnDiscoveryEnd: TDiscoveryEndEvent read FOnDiscoveryEnd write FOnDiscoveryEnd;
    property OnRemoteRequestPair: TRemoteRequestPairEvent read FOnRemoteRequestPair write FOnRemoteRequestPair;
    { Class properties }
    class property Current: TBluetoothManager read InternalGetBluetoothManager;
    class property SocketTimeout: Cardinal read FSocketTimeout write FSocketTimeout default 5000;
    class property OnIdentifyCustomUUID: TIdentifyUUIDEvent read FOnIdentifyCustomUUID write FOnIdentifyCustomUUID;
  end;

  // --------------------------------------------------------------------- //
  // --------------------------------------------------------------------- //

  TBluetoothAdapter = class(TBluetoothCustomAdapter)
  protected
    [Weak] FManager: TBluetoothManager;

    function GetPairedDevices: TBluetoothDeviceList; virtual; abstract;
    function GetScanMode: TBluetoothScanMode; virtual; abstract;
    function DoCreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket; virtual; abstract;
    function DoPair(const ADevice: TBluetoothDevice): Boolean; virtual; abstract;
    function DoUnPair(const ADevice: TBluetoothDevice): Boolean; virtual; abstract;
    { Discovery process }
    procedure DoStartDiscovery(Timeout: Cardinal); virtual; abstract;
    procedure DoCancelDiscovery; virtual; abstract;
    procedure DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList); virtual;
    procedure DoStartDiscoverable(Timeout: Cardinal); virtual; abstract;
    procedure DoDiscoverableEnd(const Sender: TObject); virtual;
    procedure DoRemoteRequestPair(const ADevice: TBluetoothDevice); virtual;
    { Discovery process }
    procedure StartDiscovery(Timeout: Cardinal);
    procedure CancelDiscovery;
    procedure StartDiscoverable(Timeout: Cardinal);
  public
    constructor Create(const AManager: TBluetoothManager);
    destructor Destroy; override;
    { Pairing }
    function Pair(const ADevice: TBluetoothDevice): Boolean;
    function UnPair(const ADevice: TBluetoothDevice): Boolean;

    { Socket management function }
    function CreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket;

    property PairedDevices: TBluetoothDeviceList read GetPairedDevices;
    property ScanMode: TBluetoothScanMode read GetScanMode;
  end;


  TBluetoothDevice = class(TBluetoothCustomDevice)
  private
    function GetServiceList: TBluetoothServiceList;
  protected
    FServiceList: TBluetoothServiceList;

    function GetPaired: Boolean; virtual; abstract;
    function GetState: TBluetoothDeviceState; virtual; abstract;
    function GetClassDevice: Integer; virtual; abstract;
    function GetClassDeviceMajor: Integer; virtual; abstract;
    function DoGetServices: TBluetoothServiceList; virtual; abstract;
    function DoCreateClientSocket(const AUUID: TGUID; Secure: Boolean): TBluetoothSocket; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
    class function ClassDeviceMajorString(AMajor: Integer): string; static;
    class function ClassDeviceString(ADevice: Integer): string; static;
    property IsPaired: Boolean read GetPaired;
    property State: TBluetoothDeviceState read GetState;
    function GetServices: TBluetoothServiceList;
    function CreateClientSocket(const AUUID: TGUID; Secure: Boolean): TBluetoothSocket;
    property ClassDeviceMajor: Integer read GetClassDeviceMajor;
    property ClassDevice: Integer read GetClassDevice;
    property LastServiceList: TBluetoothServiceList read GetServiceList;
  end;


  TBluetoothSocket = class
  protected
    function GetConnected: Boolean; virtual; abstract;
    procedure DoClose; virtual; abstract;
    procedure DoConnect; virtual; abstract;
    /// <summary>Function to receive data from the socket</summary>
    /// <remarks>Must be implemented in platform.</remarks>
    function DoReceiveData(ATimeout: Cardinal): TBytes; virtual; abstract;
    /// <summary>Function to send data to the socket</summary>
    /// <remarks>Must be implemented in platform.</remarks>
    procedure DoSendData(const AData: TBytes); virtual; abstract;
  public
    procedure Close;
    procedure Connect;
    function ReadData: TBytes; overload; inline; deprecated 'Use ReceiveData';
    function ReadData(ATimeout: Cardinal): TBytes; overload; inline; deprecated 'Use ReceiveData';
    /// <summary>Function to receive data from the socket</summary>
    /// <remarks>If a timeout is not specified, it uses the timeout specified in the manager</remarks>
    function ReceiveData: TBytes; overload; inline;
    function ReceiveData(ATimeout: Cardinal): TBytes; overload;
    procedure SendData(const AData: TBytes);

    property Connected: Boolean read GetConnected;
  end;


  TBluetoothServerSocket = class
  protected
    function DoAccept(Timeout: Cardinal): TBluetoothSocket; virtual; abstract;
    procedure DoClose; virtual; abstract;
  public
    function Accept(Timeout: Cardinal = 0): TBluetoothSocket;
    procedure Close;
  end;

{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
  ////////////////////////////////////////
  //                                    //
  //       Bluetooth Low Energy         //
  //                                    //
  ////////////////////////////////////////

type
  TBluetoothProperty = (Broadcast, ExtendedProps, Notify, Indicate, Read, Write, WriteNoResponse, SignedWrite);
  TBluetoothPropertyFlags = set of TBluetoothProperty;

  TBluetoothGattStatus = (Success = 0, ReadNotPermitted = 2, WriteNotPermitted = 3, InsufficientAutentication = 5,
    RequestNotSupported = 6, InvalidOffset = 7, InvalidAttributeLength = 13, InsufficientEncryption = 15, Failure = 257);

  TBluetoothDescriptorKind = (Unknown, ExtendedProperties, UserDescription, ClientConfiguration, ServerConfiguration,
    PresentationFormat, AggregateFormat, ValidRange, ExternalReportReference, ReportReference, //);
    EnvironmentalSensingConfiguration, EnvironmentalSensingMeasurement, EnvironmentalSensingTriggerSetting);  // New Descriptors.

  TBluetoothGattFormatType = (Reserved, Boolean, Unsigned2bitInteger, Unsigned4bitInteger, Unsigned8bitInteger,
    Unsigned12bitInteger, Unsigned16bitInteger, Unsigned24bitInteger, Unsigned32bitInteger, Unsigned48bitInteger,
    Unsigned64bitInteger, Unsigned128bitInteger, Signed8bitInteger, Signed12bitInteger, Signed16bitInteger,
    Signed24bitInteger, Signed32bitInteger, Signed48bitInteger, Signed64bitInteger, Signed128bitInteger,
    IEEE754_32bit_floating_point, IEEE754_64bit_floating_point, IEEE11073_16bitSFLOAT, IEEE11073_32bitFLOAT,
    IEEE20601Format, UTF8String, UTF16String, OpaqueStructure);

  // --------------------------------------------------------------------- //
  // Exceptions
  // --------------------------------------------------------------------- //
  EBluetoothLEAdapterException = class(EBluetoothException);
  EBluetoothLEDeviceException = class(EBluetoothException);
  EBluetoothLECharacteristicException = class(EBluetoothException);
  EBluetoothLEDescriptorException = class(EBluetoothException);
  EBluetoothLEServiceException = class(EBluetoothException);
  /// <summary> Class for Advertise Data related exceptions </summary>
  EBluetoothLEAdvertiseDataException = class(EBluetoothException);

  // --------------------------------------------------------------------- //
  // Forwarded classes
  // --------------------------------------------------------------------- //
  TBluetoothLEAdapter = class;
  TBluetoothLEDevice = class;
  TBluetoothGattService = class;
  TBluetoothGattCharacteristic = class;
  TBluetoothGattDescriptor = class;
  TBluetoothGattServer = class;

{$HPPEMIT OPENNAMESPACE}
{$HPPEMIT 'class DELPHICLASS TBluetoothLEAdapter;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothLEDevice;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothGattService;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothGattCharacteristic;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothGattDescriptor;'}
{$HPPEMIT 'class DELPHICLASS TBluetoothGattServer;'}
{$HPPEMIT CLOSENAMESPACE}


  // --------------------------------------------------------------------- //
  // List aliases classes
  // --------------------------------------------------------------------- //
  TBluetoothLEDeviceList = class(TObjectList<TBluetoothLEDevice>);
  TBluetoothLEDeviceDictionary = class(TObjectDictionary<string, TBluetoothLEDevice>);
  TBluetoothLEAdapterList = class(TObjectList<TBluetoothLEAdapter>);
  TBluetoothGattDeviceList = class(TObjectList<TBluetoothLEDevice>);
  TBluetoothGattServiceList = class(TObjectList<TBluetoothGattService>);
  TBluetoothGattCharacteristicList = class(TObjectList<TBluetoothGattCharacteristic>);
  TBluetoothGattDescriptorList = class(TObjectList<TBluetoothGattDescriptor>);


  TScanResponseKey = (Flags=$01, IncompleteList16SCUUID=$02, CompleteList16SCUUID=$03, IncompleteList32SCUUID=$04, CompleteList32SCUUID=$05,
                      IncompleteList128SCUUID=$06, CompleteList128SCUUID=$07, ShortenedLocalName=$08, CompleteLocalName=$09,
                      TxPowerLevel=$0A, ClassOfDevice=$0D, SimplePairingHashC=$0E, SimplePairingRAndomizerR=$0F,
                      DeviceID=$10, SecurityManagerOutOfBandFlags=$11, SlaveConnectionIntervalRange=$12, List16bServiceSolicitationUUIDs=$14,
                      List32bServiceSolicitationUUIDs=$1F, List128bServiceSolicitationUUIDs=$15, ServiceData=$16, ServiceData16b=$16,
                      ServiceData32b=$20, ServiceData128b=$21, PublicTargetAddress=$17, RandomTargetAddress=$18, Appearance=$19,
                      AdvertisingInterval=$1A, LEBluetoothDeviceAddress=$1B, LERole=$1C, SimplePairingHashc256=$1D, SimplePairingRAndomizerR256=$1E,
                      _3DInformationData=$3D, ManufacturerSpecificData=$FF);
  ///  <summary> TScanResponse is the class of TDictionary<TScanResponseKey, TBytes> </summary>
  TScanResponse = class(TDictionary<TScanResponseKey, TBytes>);

  // --------------------------------------------------------------------- //
  // Event types
  // --------------------------------------------------------------------- //
  TConnectLEDeviceEvent = procedure(const Sender: TObject; const ADevice: TBluetoothLEDevice) of object;
  TDiscoveryLEEndEvent = procedure(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList) of object;
  TDiscoverLEDeviceEvent = procedure(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse) of object;
  TGattOperationResultEvent = procedure(const Sender: TObject; AGattStatus: TBluetoothGattStatus) of object;
  TDiscoverServiceEvent = procedure(const Sender: TObject; const AService: TBluetoothGattService) of object;
  TDiscoverServicesEvent = procedure(const Sender: TObject; const AServiceList: TBluetoothGattServiceList) of object;
  TGattCharacteristicEvent = procedure(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic; AGattStatus: TBluetoothGattStatus) of object;
  TGattDescriptorEvent = procedure(const Sender: TObject; const ADescriptor: TBluetoothGattDescriptor; AGattStatus: TBluetoothGattStatus) of object;
  TGattDeviceRSSIEvent = procedure(const Sender: TObject; ARssiValue: Integer; AGattStatus: TBluetoothGattStatus) of object;

  TGattCharacteristicReadEvent = procedure(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
    var AGattStatus: TBluetoothGattStatus) of object;
  TGattCharacteristicWriteEvent = procedure(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
    var AGattStatus: TBluetoothGattStatus; const AValue: TByteDynArray) of object;
  TGattCharacteristicSubscriptionEvent = procedure(const Sender: TObject; const AClientId: string;
    const ACharacteristic: TBluetoothGattCharacteristic) of object;

  TGattServiceEvent = procedure(const Sender: TObject; const AService: TBluetoothGattService;
    const AGattStatus: TBluetoothGattStatus) of object;
  // --------------------------------------------------------------------- //
  // --------------------------------------------------------------------- //

  ///  <summary> TBluetoothLEServiceData is the class of TDictionary<TBluetoothUUID, TBytes> </summary>
  TBluetoothLEServiceData = class(TDictionary<TBluetoothUUID, TBytes>);

  ///  <summary> Class to store and retrieve the advertise data information </summary>
  TBluetoothLEAdvertiseData = class
  protected
    ///  <summary> Variable for LocalName property </summary>
    FLocalName: string;
    ///  <summary> Variable for TxPowerLevel property </summary>
    FTxPowerLevel: Integer;
    ///  <summary> Variable for ManufacturerSpecificData property </summary>
    FManufacturerSpecificData: TBytes;
    ///  <summary> List to store Service UUIDs to advertise </summary>
    FServiceUUIDs: TBluetoothUUIDsList;
    ///  <summary> Dictionary to store Service Data to advertise </summary>
    FServiceData: TBluetoothLEServiceData;
    ///  <summary> Getter for ServiceUUIDs property </summary>
    function GetServiceUUIDs: TArray<TBluetoothUUID>; virtual; abstract;
    ///  <summary> Getter for ServiceData property </summary>
    function GetServiceData: TArray<TServiceDataRawData>; virtual; abstract;
     ///  <summary> Function that Set the advertised local name </summary>
    procedure SetLocalName(const ALocalName: string); virtual; abstract;
    ///  <summary> Function that Get the advertised local name </summary>
    function GetLocalName: string; virtual; abstract;
    ///  <summary> Function that Set the advertised transmission power level </summary>
    procedure SetTxPowerLevel(ATxPowerLevel: Integer); virtual; abstract;
    ///  <summary> Function that Get the advertised transmission power level </summary>
    function GetTxPowerLevel: Integer; virtual; abstract;
    ///  <summary> Function that Set the advertised manufacturer specific data </summary>
    procedure SetManufacturerSpecificData(const AManufacturerSpecificData: TBytes); virtual; abstract;
    ///  <summary> Function that Get the advertised manufacturer specific data </summary>
    function GetManufacturerSpecificData: TBytes; virtual; abstract;
    ///  <summary> functionality of AddServiceUUID </summary>
    function DoAddServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean; virtual; abstract;
    ///  <summary> functionality of ClearServiceUUIDs </summary>
    procedure DoClearServiceUUIDs; virtual; abstract;
    ///  <summary> functionality of RemoveServiceUUID </summary>
    procedure DoRemoveServiceUUID(const AServiceUUID: TBluetoothUUID); virtual; abstract;
    ///  <summary> functionality of RemoveServiceData </summary>
    procedure DoRemoveServiceData(const AServiceUUID: TBluetoothUUID); virtual; abstract;
    ///  <summary> functionality of ClearServiceData </summary>
    procedure DoClearServiceData; virtual; abstract;
    ///  <summary> functionality of AddServiceData </summary>
    function DoAddServiceData(const AServiceUUID: TBluetoothUUID; const AData: TBytes): Boolean; virtual; abstract;
  public
    ///  <summary> Constructor </summary>
    constructor Create;
    ///  <summary> Destructor </summary>
    destructor Destroy; override;
    ///  <summary> Adds a service UUID to the advertise data information </summary>
    procedure AddServiceUUID(const AServiceUUID: TBluetoothUUID);
    ///  <summary> Removes a service UUID from the advertise data information </summary>
    procedure RemoveServiceUUID(const AServiceUUID: TBluetoothUUID);
    ///  <summary> Removes all service UUIDs from the advertise data information </summary>
    procedure ClearServiceUUIDs;
    ///  <summary> Check if a given service UUID is in the advertise data information </summary>
    function ContainsServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean; virtual; abstract;
    ///  <summary> Adds a service data pair to the advertise data information </summary>
    procedure AddServiceData(const AServiceUUID: TBluetoothUUID; const AData: TBytes);
    ///  <summary> Removes the service data for a given service UUID </summary>
    procedure RemoveServiceData(const AServiceUUID: TBluetoothUUID);
    ///  <summary> Retuns the service data for a given service UUID </summary>
    function GetDataForService(const AServiceUUID: TBluetoothUUID): TBytes; virtual; abstract;
    ///  <summary> Removes all service data from the advertise data information </summary>
    procedure ClearServiceData;
    ///  <summary> Get/Set the advertised local name </summary>
    property LocalName: string read GetLocalName write SetLocalName;
    ///  <summary> Get/Set the advertised transmission power level </summary>
    property TxPowerLevel: Integer read GetTxPowerLevel write SetTxPowerLevel;
    ///  <summary> Get/Set the advertised manufacturer specific data </summary>
    property ManufacturerSpecificData: TBytes read GetManufacturerSpecificData write SetManufacturerSpecificData;
    ///  <summary> Get the advertised services UUIDs </summary>
    property ServiceUUIDs: TArray<TBluetoothUUID> read GetServiceUUIDs;
    ///  <summary> Get the advertised service data </summary>
    property ServiceData: TArray<TServiceDataRawData> read GetServiceData;
  end;

  ///  <summary> Class to store and retrieve the BLE scan filters </summary>
  TBluetoothLEScanFilter = class
  private
    FLocalName: string;
    FDeviceAddress: string;
    FManufacturerSpecificData: TBytes;
    FManufacturerSpecificDataMask: TBytes;
    FServiceUUID: TBluetoothUUID;
    FServiceUUIDMask: TBluetoothUUID;
    FServiceData: TServiceDataRawData;
    FServiceDataMask: TBytes;
  protected
    ///  <summary> Setter for ManufacturerSpecificData property </summary>
    procedure SetManufacturerSpecificData(const AManufacturerSpecificData: TBytes);
    ///  <summary> Setter for ManufacturerSpecificDataMask property </summary>
    procedure SetManufacturerSpecificDataMask(const AManufacturerSpecificDataMask: TBytes);
    ///  <summary> Setter for ServiceData property </summary>
    procedure SetServiceData(const AServiceData: TServiceDataRawData);
    ///  <summary> Setter for ServiceDataMask property </summary>
    procedure SetServiceDataMask(const AServiceDataMask: TBytes);
   public
    ///  <summary> Constructor </summary>
    constructor Create;
    ///  <summary> Property advertised manufacturer specific data to use as a filter </summary>
    property ManufacturerSpecificData: TBytes read FManufacturerSpecificData write SetManufacturerSpecificData;
    ///  <summary> Mask property for the advertised manufacturer specific data filter Set filter on partial manufacture data.
    /// For any bit in the mask, set it the 1 if it needs to match the one in manufacturer data, otherwise set it to 0.</summary>
    property ManufacturerSpecificDataMask: TBytes read FManufacturerSpecificDataMask write SetManufacturerSpecificDataMask;
    ///  <summary> Property for service UUID to use as a filter </summary>
    property ServiceUUID: TBluetoothUUID read FServiceUUID write FServiceUUID;
    ///  <summary> Mask property for the service UUID filter
    /// For any bit in the mask, set it the 1 if it needs to match the one in Services UUID data, otherwise set it to 0.</summary>
    property ServiceUUIDMask: TBluetoothUUID read FServiceUUIDMask write FServiceUUIDMask;
    ///  <summary> Property for ServiceData to use as a filter </summary>
    property ServiceData: TServiceDataRawData read FServiceData write SetServiceData;
    ///  <summary> Property for ServiceData to use as a filter
    /// For any bit in the mask, set it the 1 if it needs to match the one in service data(TBytes), otherwise set it to 0.</summary>
    property ServiceDataMask: TBytes read FServiceDataMask write SetServiceDataMask;
    ///  <summary> Property for LocalName to use as a filter </summary>
    property LocalName: string read FLocalName write FLocalName;
    ///  <summary> Property for DeviceAddress to use as a filter </summary>
    property DeviceAddress: string read FDeviceAddress write FDeviceAddress;
   end;

  /// <summary> Class for TList<TBluetoothLEScanFilter></summary>
  TBluetoothLEScanFilterList = class(TList<TBluetoothLEScanFilter>);


  TBluetoothLEManager = class(TInterfacedObject)
  private class var
    FCurrentManager: TBluetoothLEManager;
    class function InternalGetBluetoothManager: TBluetoothLEManager; static;
    class constructor Create;
    class destructor Destroy;
  protected
    class function AddDeviceToList(const ADevice: TBluetoothLEDevice;
      const ADeviceList: TBluetoothLEDeviceList): TBluetoothLEDevice; static;
    /// <summary> Checks if the device with the identifier is in the list and gets it </summary>
    class function GetDeviceInList(const AIdentifier: TBluetoothMacAddress;
      const ADeviceList: TBluetoothLEDeviceList): TBluetoothLEDevice; static;
    /// <summary> Clear the devices inside the list</summary>
    class procedure ClearDevicesFromList(const ADeviceList: TBluetoothLEDeviceList); static;
    class function GetKnownServiceName(const AServiceUUID: TGUID): string; static;
  protected type
    TBluetoothManagerClass = class of TBluetoothLEManager;
  protected class var
    FBluetoothManagerClass: TBluetoothManagerClass;
    class var FOnIdentifyCustomUUID: TIdentifyUUIDEvent;
  private
    function GetCurrentLEAdapter: TBluetoothLEAdapter;
  protected
    FOnDiscoveryLEEnd: TDiscoveryLEEndEvent;
    /// <summary>Variable for OnDiscoverLEDevice property </summary>
    FOnDiscoverLEDevice: TDiscoverLEDeviceEvent;
    FDiscoveredLEDevices: TBluetoothLEDeviceList;
    FLastDiscoveredLETimeStamp: TDateTime;
    /// <summary> TBluetoothUUID List for services filtering of StartDiscovery </summary>
    FFilterUUIDList: TBluetoothUUIDsList;
    /// <summary> FServicesFilterScan checks when StartDiscovery is services filtered </summary>
    FServicesFilterScan: Boolean;
    /// <summary> Setting to True, discovery process attemps to retrieve services from the actual device
    /// instead of use the cached ones. This property only has effect in Android </summary>
    FForceRefreshCachedDevices: Boolean;

    function GetConnectionState: TBluetoothConnectionState; virtual; abstract;
    function DoGetLEAdapter: TBluetoothLEAdapter; virtual; deprecated 'Use DoGetAdapter';
    /// <summary> Returns the adapter of your manager.</summary>
    function DoGetAdapter: TBluetoothLEAdapter; virtual; abstract;
    function DoGetGattServer: TBluetoothGattServer; virtual; abstract;
    procedure DoDiscoveryLEEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList); virtual; deprecated 'Use DoDiscoveryEnd';
    /// <summary> Dispatcher of the OnDiscoveryEnd event.</summary>
    procedure DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList); virtual;
    /// <summary> Raises OnDiscoverLEDevice event </summary>
    procedure DoDiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse); virtual; deprecated 'Use DoDiscoverDevice';
    /// <summary> Raises OnDiscoverLEDevice event </summary>
    procedure DoDiscoverDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse); virtual;
    class function GetBluetoothManager: TBluetoothLEManager; virtual; abstract;
    function DoGetSupportsGattClient: Boolean; virtual; abstract;
    function DoGetSupportsGattServer: Boolean; virtual; abstract;
    ///  <summary> DoEnableBluetooth functionality of EnableBluetooth</summary>
    function DoEnableBluetooth: Boolean; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary> Starts a scan for Bluetooth LE devices. If AFilterUUIDList is provided, only peripherals that advertise the services
    /// you specify will be discovered. If you set ForceConnect to True, the scan process will connect with all discovered devices to search for
    /// AFilterUUIDList services if they are not in the advertise data.
    /// ABluetoothLEScanFilterList is a List of Filters to perform scan related operations for specific devices.
    /// Refresh create a new filter list or use last created </summary>
    function StartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil; ForceConnect: Boolean = False): Boolean; overload;
    /// <summary> Starts a scan for Bluetooth LE devices that advertise data. ABluetoothLEScanFilterList is a List of Filters to perform scan
    /// related operations for specific devices. </summary>
    function StartDiscovery(Timeout: Cardinal; const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean; overload;
    /// <summary> Starts a scan for Bluetooth LE devices </summary>
    function StartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil; Refresh: Boolean = True): Boolean;
    procedure CancelDiscovery;
    /// <summary> Implementation of the algorithm that transform the RSSI to Distance </summary>
    function RssiToDistance(ARssi, ATxPower: Integer; ASignalPropagationConst: Single): Double;
    {  Open a GATT Server The callback is used to deliver results to Caller, such as connection status as well as the }
    { results of any other GATT server operations. }
    function GetGattServer: TBluetoothGattServer;
    function GetSupportsGattClient: Boolean;
    function GetSupportsGattServer: Boolean;
    { Properties }
    property SupportsGattClient: Boolean read GetSupportsGattClient;
    property SupportsGattServer: Boolean read GetSupportsGattServer;
    property ConnectionState: TBluetoothConnectionState read GetConnectionState;
    property CurrentAdapter: TBluetoothLEAdapter read GetCurrentLEAdapter;
    property LastDiscoveredDevices: TBluetoothLEDeviceList read FDiscoveredLEDevices;
    property LastDiscoveredTimeStamp: TDateTime read FLastDiscoveredLETimeStamp;
    ///  <summary> EnableBluetooth shows a system activity that allows the user to turn on Bluetooth </summary>
    property EnableBluetooth: Boolean read DoEnableBluetooth;
    { Events }
    property OnDiscoveryEnd: TDiscoveryLEEndEvent read FOnDiscoveryLEEnd write FOnDiscoveryLEEnd;
    /// <summary>Fired each time a new Bluetooth LE device is found </summary>
    property OnDiscoverLEDevice: TDiscoverLEDeviceEvent read FOnDiscoverLEDevice write FOnDiscoverLEDevice;
    /// <summary> Setting to True, discovery process attemps to retrieve services from the actual device
    /// instead of use the cached ones. This property only has effect in Android </summary>
    property ForceRefreshCachedDevices: Boolean read FForceRefreshCachedDevices write FForceRefreshCachedDevices;

    { Class function}
    /// <summary>Creates a new instance of the TBluetoothLEManager class </summary>
    class function CreateInstance: TBluetoothLEManager;
    { Class properties }
    class property Current: TBluetoothLEManager read InternalGetBluetoothManager;
    class property OnIdentifyCustomUUID: TIdentifyUUIDEvent read FOnIdentifyCustomUUID write FOnIdentifyCustomUUID;
  end;


  TBluetoothLEAdapter = class(TBluetoothCustomAdapter)
  protected
    [Weak] FManager: TBluetoothLEManager;

    function GetScanMode: TBluetoothScanMode; virtual; abstract;
    { LE Discovery }
    function DoStartLeDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil): Boolean; virtual; deprecated 'Use DoStartDiscovery';
    /// <summary>Starts a discovery operation to find remote devices using Bluetooth Low Energy.</summary>
    function DoStartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil;
      const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil): Boolean; virtual; abstract;
    /// <summary>Implementation for StartDiscoveryRaw function </summary>
    function DoStartLeDiscoveryRaw: Boolean; virtual; deprecated 'Use DoStartDiscoveryRaw';
    /// <summary>Implementation for StartDiscoveryRaw function </summary>
    function DoStartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil; Refresh: Boolean = True): Boolean; virtual; abstract;
    procedure DoCancelLeDiscovery; virtual; deprecated 'Use DoCancelDiscovery';
    /// <summary>Cancels a discovery previously started by DoStartLeDiscovery.</summary>
    procedure DoCancelDiscovery; virtual; abstract;
    { Events }
    procedure DoDiscoveryLEEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList); virtual; deprecated 'Use DoDiscoveryEnd';
    /// <summary>Called when a remote device discovery operation started by DoStartLeDiscovery ends successfully.</summary>
    procedure DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList); virtual;
    /// <summary> Raises OnDiscoverLEDevice event </summary>
    procedure DoDiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse); virtual; deprecated 'Use DoDiscoverDevice';
    /// <summary> Raises OnDiscoverLEDevice event </summary>
    procedure DoDiscoverDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse); virtual;

    { Discovery process }
    /// <summary> Starts a scan for Bluetooth LE devices. If AFilterUUIDList is provided, only peripherals that advertise the services
    /// you specify will be discovered. If you set ForceConnect to True, the scan process will connect with all discovered devices to search for
    /// AFilterUUIDList services if they are not in the advertise data </summary>
    function StartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil; ForceConnect: Boolean = False;
      const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil): Boolean;
    /// <summary> Starts a scan for Bluetooth LE devices </summary>
    function StartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil; Refresh: Boolean = True): Boolean;
    procedure CancelDiscovery;
    /// <summary> True if the device overcomes the filters false otherwise </summary>
    function DoDeviceOvercomesFilters(const ADevice: TBluetoothLEDevice; const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;
  public
    constructor Create(const AManager: TBluetoothLEManager);
    destructor Destroy; override;
    property ScanMode: TBluetoothScanMode read GetScanMode;
  end;


  TBluetoothLEDevice = class(TBluetoothCustomDevice)
  private
    FOnCharacteristicRead: TGattCharacteristicEvent;
    FOnDescriptorRead: TGattDescriptorEvent;
    FOnCharacteristicWrite: TGattCharacteristicEvent;
    FOnDescriptorWrite: TGattDescriptorEvent;
    FOnServicesDiscovered: TDiscoverServicesEvent;
    FOnReadRSSI: TGattDeviceRSSIEvent;
    FOnReliableWriteCompleted: TGattOperationResultEvent;
    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    FUpdateOnReconnect: Boolean;
  protected
    FAutoConnect: Boolean;
    FServices: TBluetoothGattServiceList;
    /// <summary> FAdvertisedData is a var that holds the data advertised by a device </summary>
    FAdvertisedData: TScanResponse;
    /// <summary> FScannedAdvertiseData is a var that holds the data advertised by a device in a TBluetoothLEAdvertiseData object</summary>
    FScannedAdvertiseData: TBluetoothLEAdvertiseData;
    /// <summary> FLastRSSI is a var that holds the last scanned RSSI value </summary>
    FLastRSSI: Integer;
    /// <summary> Setting to True, clears the internal cache and forces a refresh of the services from the
    /// remote device on service discovery process. This property only has effect in Android </summary>
    FForceRefreshCachedServices: Boolean;
    /// <summary> Creates the TBluetoothLEAdvertiseData for this device </summary>
    function DoCreateAdvertiseData: TBluetoothLEAdvertiseData; virtual; abstract;

    procedure DoAbortReliableWrite; virtual; abstract;
    function DoBeginReliableWrite: Boolean; virtual; abstract;
    function DoExecuteReliableWrite: Boolean; virtual; abstract;

    function DoDiscoverServices: Boolean; virtual; abstract;
    procedure DoOnServicesDiscovered(const Sender: TObject; const AServiceList: TBluetoothGattServiceList); virtual;

    function DoReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; virtual; abstract;
    function DoReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; virtual; abstract;
    function DoWriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; virtual; abstract;
    function DoWriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; virtual; abstract;

    function DoReadRemoteRSSI: Boolean; virtual; abstract;
    function DoSetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
      Enable: Boolean): Boolean; virtual; abstract;
    /// <summary>Implementation for Identifier function </summary>
    function GetIdentifier: string; virtual; abstract;
    /// <summary>Implementation for IsConnected function </summary>
    function GetIsConnected: Boolean; virtual; abstract;
    /// <summary>Implementation for Disconnect function </summary>
    function DoDisconnect: Boolean; virtual; abstract;
    /// <summary>Implementation for Connect function </summary>
    function DoConnect: Boolean; virtual; abstract;

    { Events }
    procedure DoOnCharacteristicRead(const ACharacteristic: TBluetoothGattCharacteristic; AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoOnDescriptorRead(const ADescriptor: TBluetoothGattDescriptor; AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoOnCharacteristicWrite(const ACharacteristic: TBluetoothGattCharacteristic; AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoOnDescriptorWrite(const ADescriptor: TBluetoothGattDescriptor; AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoOnReadRssi(const Sender: TObject; ARssiValue: Integer; AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoOnReliableWriteCompleted(AStatus: TBluetoothGattStatus); virtual;
  public
    constructor Create(AutoConnect: Boolean);
    destructor Destroy; override;
    property Services: TBluetoothGattServiceList read FServices;
    procedure AbortReliableWrite;
    function BeginReliableWrite: Boolean;
    function ExecuteReliableWrite: Boolean;
    property OnReliableWriteCompleted: TGattOperationResultEvent read FOnReliableWriteCompleted write FOnReliableWriteCompleted;
    function DiscoverServices: Boolean;
    property OnServicesDiscovered: TDiscoverServicesEvent read FOnServicesDiscovered write FOnServicesDiscovered;
    { You have to DiscoverServices before use this function }
    function GetService(const AServiceID: TBluetoothUUID): TBluetoothGattService;
    { Helper methods }
    function GetDescription(const ACharacteristic: TBluetoothGattCharacteristic): string;
    { Read/write Methods }
    function ReadRemoteRSSI: Boolean;
    property OnReadRSSI: TGattDeviceRSSIEvent read FOnReadRSSI write FOnReadRSSI;
    function SetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic; Enable: Boolean): Boolean;
    function ReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
    property OnCharacteristicRead: TGattCharacteristicEvent read FOnCharacteristicRead write FOnCharacteristicRead;
    function WriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
    property OnCharacteristicWrite: TGattCharacteristicEvent read FOnCharacteristicWrite write FOnCharacteristicWrite;
    function ReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
    property OnDescriptorRead: TGattDescriptorEvent read FOnDescriptorRead write FOnDescriptorRead;
    function WriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
    property OnDescriptorWrite: TGattDescriptorEvent read FOnDescriptorWrite write FOnDescriptorWrite;
    /// <summary> Identifier returns a string identifying a bluetooth device unequivocally </summary>
    function Identifier: string;
    /// <summary> AdvertisedData returns the data advertised by a device </summary>
    property AdvertisedData: TScanResponse read FAdvertisedData;
    /// <summary> ScannedAdvertiseData returns the data advertised by a device in a TBluetoothLEAdvertiseData object</summary>
    property ScannedAdvertiseData: TBluetoothLEAdvertiseData read FScannedAdvertiseData write FScannedAdvertiseData;
    /// <summary>
    /// A Boolean value indicating whether the current adapter is connected to a profile of the current remote device
    /// </summary>
    function IsConnected: Boolean;
    ///  <summary> Connects the current remote device to the current adapter </summary>
    function Connect: Boolean;
    ///  <summary> Disconnects the current remote device from the current adapter </summary>
    function Disconnect: Boolean;
    /// <summary> LastRSSI last scanned RSSI value </summary>
    property LastRSSI: Integer read FLastRSSI;
    /// <summary> Setting to True, clears the internal cache and forces a refresh of the services from the
    /// remote device on service discovery process. This property only has effect in Android </summary>
    property ForceRefreshCachedServices: Boolean read FForceRefreshCachedServices write FForceRefreshCachedServices;
    /// <summary>
    ///  OnConnect is fired each time TBluetoothLEDevice is connected
    /// </summary>
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    /// <summary>
    ///  OnDisconnect is fired each time TBluetoothLEDevice is disconnected
    /// </summary>
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
    /// <summary>This property only has effect in iOS/MacOS.
    /// Setting to True, updates the services tree when a previously connected device is re-connected.
    /// If is set to False, it is mandatory to redo a discovering services process again after reconnecting and
    /// previous obtained TBluetoothGattService, TBluetoothGattCharacteristic and TBluetoothGattDescriptor
    /// are no longer valid.  </summary>
    property UpdateOnReconnect: Boolean read FUpdateOnReconnect write FUpdateOnReconnect;
  end;

  TBluetoothGattService = class
  private
    function GetCharacteristics: TBluetoothGattCharacteristicList;
    function GetIncludedServices: TBluetoothGattServiceList;
  protected
    FCharacteristics: TBluetoothGattCharacteristicList;
    FIncludedServices: TBluetoothGattServiceList;

    function GetServiceType: TBluetoothServiceType; virtual; abstract;
    function GetServiceUUID: TBluetoothUUID; virtual; abstract;
    function GetServiceUUIDName: string; virtual;

    function DoGetCharacteristics: TBluetoothGattCharacteristicList; virtual; abstract;
    function DoGetIncludedServices: TBluetoothGattServiceList; virtual; abstract;

    function DoCreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService; virtual; abstract;
    function DoCreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
      const ADescription: string): TBluetoothGattCharacteristic; virtual; abstract;

    { Add the previously created Services and characteristics... }
    function DoAddIncludedService(const AService: TBluetoothGattService): Boolean; virtual; abstract;
    function DoAddCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; virtual; abstract;

  public
    { Service Management }
    function CreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
    function CreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
      const ADescription: string): TBluetoothGattCharacteristic;

    constructor Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType);
    destructor Destroy; override;
    function GetCharacteristic(const AUUID: TBluetoothUUID): TBluetoothGattCharacteristic;
    property UUID: TBluetoothUUID read GetServiceUUID;
    property UUIDName: string read GetServiceUUIDName;
    property ServiceType: TBluetoothServiceType read GetServiceType;
    property Characteristics: TBluetoothGattCharacteristicList read GetCharacteristics;
    property IncludedServices: TBluetoothGattServiceList read GetIncludedServices;
  end;


  TBluetoothGattCharacteristic = class
  private
    function GetUUIDName: string;
    function GetDescriptors: TBluetoothGattDescriptorList;

  protected
    [Weak] FService: TBluetoothGattService;
    FDescriptors: TBluetoothGattDescriptorList;

    function GetUUID: TBluetoothUUID; virtual; abstract;

    function GetProperties: TBluetoothPropertyFlags; virtual; abstract;

    function DoAddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; virtual; abstract;
    function DoGetDescriptors: TBluetoothGattDescriptorList; virtual; abstract;

    function DoGetValue: TBytes; virtual; abstract;
    procedure DoSetValue(const AValue: TBytes); virtual; abstract;

    function AddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
    function DoCreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor; virtual; abstract;
    function CreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor;

  public
    constructor Create(const AService: TBluetoothGattService); overload;
    constructor Create(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags); overload;
    destructor Destroy; override;

    function GetService: TBluetoothGattService;

    function GetDescriptor(const AUuid: TBluetoothUUID): TBluetoothGattDescriptor;

    function GetValue: TBytes;
    procedure SetValue(const AValue: TBytes);

    function GetValueAs<T>(Offset: Integer = 0): T;
    procedure SetValueAs<T>(AValue: T; Offset: Integer = 0);
    function GetValueAsInt8(Offset: Integer = 0): Int8;
    function GetValueAsInt16(Offset: Integer = 0): Int16;
    function GetValueAsInt32(Offset: Integer = 0): Int32;
    function GetValueAsInt64(Offset: Integer = 0): Int64;
    function GetValueAsUInt8(Offset: Integer = 0): UInt8;
    function GetValueAsUInt16(Offset: Integer = 0): UInt16;
    function GetValueAsUInt32(Offset: Integer = 0): UInt32;
    function GetValueAsUInt64(Offset: Integer = 0): UInt64;
    function GetValueAsDouble(Offset: Integer = 0): Double;

    procedure SetValueAsInt8(AValue: Int8; Offset: Integer = 0);
    procedure SetValueAsInt16(AValue: Int16; Offset: Integer = 0);
    procedure SetValueAsInt32(AValue: Int32; Offset: Integer = 0);
    procedure SetValueAsInt64(AValue: Int64; Offset: Integer = 0);
    procedure SetValueAsUInt8(AValue: UInt8; Offset: Integer = 0);
    procedure SetValueAsUInt16(AValue: UInt16; Offset: Integer = 0);
    procedure SetValueAsUInt32(AValue: UInt32; Offset: Integer = 0);
    procedure SetValueAsUInt64(AValue: UInt64; Offset: Integer = 0);
    procedure SetValueAsDouble(AValue: Double; Offset: Integer = 0);

    function GetValueAsInteger(Offset: Integer = 0;
      AFormatType: TBluetoothGattFormatType = TBluetoothGattFormatType.Signed32bitInteger): Integer;
    function GetValueAsSingle(Offset: Integer = 0;
      AFormatType: TBluetoothGattFormatType = TBluetoothGattFormatType.IEEE754_32bit_floating_point): Single;


    function GetValueAsString(Offset: Integer = 0; IsUTF8: Boolean = True): string;

    procedure SetValueAsInteger(AValue: Integer; Offset: Integer = 0;
      AFormatType: TBluetoothGattFormatType = TBluetoothGattFormatType.Signed32bitInteger);
    procedure SetValueAsSingle(AValue: Single; Offset: Integer = 0;
      AFormatType: TBluetoothGattFormatType = TBluetoothGattFormatType.IEEE754_32bit_floating_point);
    procedure SetValueAsString(const AValue: string; IsUTF8: Boolean = True);

    property UUID: TBluetoothUUID read GetUUID;
    property UUIDName: string read GetUUIDName;
    property Properties: TBluetoothPropertyFlags read GetProperties;
    property Descriptors: TBluetoothGattDescriptorList read GetDescriptors;
    property Value: TBytes read GetValue write SetValue;
  end;


  TBluetoothGattDescriptor = class
  private
    function GetUUIDName: string;
    function GetDescriptorKind: TBluetoothDescriptorKind;
    procedure SetNotification(const AValue: Boolean);
    function GetNotification: Boolean;
    function GetIndication: Boolean;
    procedure SetIndication(const AValue: Boolean);
    function GetReliableWrite: Boolean;
    function GetWritableAuxiliaries: Boolean;
    function GetUserDescription: string;
    procedure SetUserDescription(const AValue: string);
    function GetBroadcasts: Boolean;
    procedure SetBroadcasts(const AValue: Boolean);
    function GetFormat: TBluetoothGattFormatType;
    function GetExponent: ShortInt;
    function GetFormatUnit: TBluetoothUUID;
  protected
    [Weak] FCharacteristic: TBluetoothGattCharacteristic;

    function DoGetValue: TBytes; virtual; abstract;
    procedure DoSetValue(const AValue: TBytes); virtual; abstract;

    function GetUUID: TBluetoothUUID; virtual; abstract;

    { Characteristic Extended Properties }
    function DoGetReliableWrite: Boolean; virtual; abstract;
    function DoGetWritableAuxiliaries: Boolean; virtual; abstract;

    { Characteristic User Description }
    function DoGetUserDescription: string; virtual; abstract;
    procedure DoSetUserDescription(const Value: string); virtual; abstract;

    { Client Characteristic Configuration }
    procedure DoSetNotification(const AValue: Boolean); virtual; abstract;
    function DoGetNotification: Boolean; virtual; abstract;
    procedure DoSetIndication(const AValue: Boolean); virtual; abstract;
    function DoGetIndication: Boolean; virtual; abstract;

    { Server Characteristic Configuration }
    function DoGetBroadcasts: Boolean; virtual; abstract;
    procedure DoSetBroadcasts(const AValue: Boolean); virtual; abstract;

    { Characteristic Presentation Format }
    function DoGetFormat: TBluetoothGattFormatType; virtual; abstract;
    function DoGetExponent: ShortInt; virtual; abstract;
    function DoGetFormatUnit: TBluetoothUUID; virtual; abstract;
  public
    constructor Create(const ACharacteristic: TBluetoothGattCharacteristic); overload;
    constructor Create(const ACharacteristic: TBluetoothGattCharacteristic; const AUUID: TBluetoothUUID); overload;
    destructor Destroy; override;

    class function GetKnownUnitName(const AnUnit: TBluetoothUUID): string;

    { Functions that get/set cached values for the descriptor. }
    { Real/actual values are updated by the TBluetoothLEDevice (ReadDescriptor/WriteDescriptor) }
    function GetValue: TBytes;
    procedure SetValue(const AValue: TBytes);

    { Descriptor's basic information }
    property UUID: TBluetoothUUID read GetUUID;
    property UUIDName: string read GetUUIDName;
    property Kind: TBluetoothDescriptorKind read GetDescriptorKind;
    function GetCharacteristic: TBluetoothGattCharacteristic;

    { Characteristic Extended Properties }
    property ReliableWrite: Boolean read GetReliableWrite;
    property WritableAuxiliaries: Boolean read GetWritableAuxiliaries;

    { Characteristic User Description }
    property UserDescription: string read GetUserDescription write SetUserDescription;

    { Client Characteristic Configuration }
    property Notification: Boolean read GetNotification write SetNotification;
    property Indication: Boolean read GetIndication write SetIndication;

    { Server Characteristic Configuration }
    property Broadcasts: Boolean read GetBroadcasts write SetBroadcasts;

    { Characteristic Presentation Format }
    property Format: TBluetoothGattFormatType read GetFormat;
    property Exponent: ShortInt read GetExponent;
    property FormatUnit: TBluetoothUUID read GetFormatUnit;
    property Value: TBytes read GetValue write SetValue;
  end;


  TBluetoothGattServer = class
  private
    FOnConnectedDevice: TConnectLEDeviceEvent;
    FOnDisconnectDevice: TConnectLEDeviceEvent;
    FOnCharacteristicRead: TGattCharacteristicReadEvent;
    FOnCharacteristicWrite: TGattCharacteristicWriteEvent;
    FOnGattServiceAdded: TGattServiceEvent;
    FOnClientSubscribed: TGattCharacteristicSubscriptionEvent;
    FOnClientUnsubscribed: TGattCharacteristicSubscriptionEvent;
    FGattServerName: string;
    FAdvertiseService: Boolean;
    FAdvertiseData: TBluetoothLEAdvertiseData;
  protected
    /// <summary> Manager for this Gatt server </summary>
    [Weak] FManager: TBluetoothLEManager;
    FServices: TBluetoothGattServiceList;

    { Service Management }
    function DoCreateService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService; virtual; abstract;
    function DoCreateIncludedService(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      AType: TBluetoothServiceType): TBluetoothGattService; virtual; abstract;

    { Characteristic Management }
    function DoCreateCharacteristic(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      const AProps: TBluetoothPropertyFlags; const ADescription: string = ''): TBluetoothGattCharacteristic; virtual; abstract;

    { Descriptor Management }
    function DoCreateDescriptor(const ACharacteristic: TBluetoothGattCharacteristic;
      const AnUUID: TBluetoothUUID): TBluetoothGattDescriptor; virtual; abstract;
    /// <summary> Creates the TBluetoothLEAdvertiseData for this Gatt server </summary>
    function DoCreateAdvertiseData: TBluetoothLEAdvertiseData; virtual; abstract;

    { Add the previously created Services and characteristics... }
    function DoAddService(const AService: TBluetoothGattService): Boolean; virtual; abstract;
    function DoAddCharacteristic(const AService: TBluetoothGattService;
      const ACharacteristic: TBluetoothGattCharacteristic): Boolean; virtual; abstract;

    function DoGetServices: TBluetoothGattServiceList; virtual; abstract;
    procedure DoClose; virtual; abstract;
    procedure DoClearServices; virtual; abstract;
    procedure DoOnConnectedDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice); virtual;
    procedure DoOnDisconnectDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice); virtual;
    procedure DoOnServiceAdded(const Sender: TObject; const AService: TBluetoothGattService;
      const AGattStatus: TBluetoothGattStatus); virtual;
    procedure DoCharacteristicReadRequest(const ADevice: TBluetoothLEDevice; ARequestId: Integer; AnOffset: Integer;
      const AGattCharacteristic: TBluetoothGattCharacteristic); virtual; abstract;
    procedure DoCharacteristicWriteRequest(const ADevice: TBluetoothLEDevice; ARequestId: Integer;
      const AGattCharacteristic: TBluetoothGattCharacteristic; APreparedWrite: Boolean; AResponseNeeded: Boolean;
      AnOffset: Integer; const AValue: TBytes); virtual; abstract;

    procedure DoUpdateCharacteristicValue(const ACharacteristic: TBluetoothGattCharacteristic); virtual; abstract;
    procedure DoServiceAdded(AStatus: TBluetoothGattStatus; const AService: TBluetoothGattService); virtual; abstract;
    procedure DoOnCharacteristicRead(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
      var AGattStatus: TBluetoothGattStatus);
    procedure DoOnCharacteristicWrite(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
      var AGattStatus: TBluetoothGattStatus; const Value: TBytes);
    procedure DoOnClientSubscribed(const Sender: TObject; const AClientId: string;
      const ACharacteristic: TBluetoothGattCharacteristic); virtual;
    procedure DoOnClientUnsubscribed(const Sender: TObject; const AClientId: string;
      const ACharacteristic: TBluetoothGattCharacteristic); virtual;
    /// <summary> Advertises peripheral manager data </summary>
    procedure DoStartAdvertising; virtual; abstract;
    /// <summary> Stops advertising peripheral manager data </summary>
    procedure DoStopAdvertising; virtual; abstract;
    /// <summary> A Boolean value indicating whether the peripheral is currently advertising data </summary>
    function DoIsAdvertising: Boolean; virtual; abstract;
    /// <summary> A Boolean value indicating whether the peripheral is currently advertising data </summary>
    function GetIsAdvertising: Boolean;
    /// <summary> Setter for GattServerName property </summary>
    procedure SetGattServerName(AName: string);
  public
    constructor Create(const AManager: TBluetoothLEManager);
    destructor Destroy; override;
    { Service Management }
    /// <summary> Adds a service to the Gatt server. If ShouldAdvertise is set to true, this service will be in the advertise data
    /// automatically </summary>
    function AddService(const AService: TBluetoothGattService; ShouldAdvertise: Boolean = True): Boolean;
    function FindService(const AUUID: TGuid): TBluetoothGattService;
    function CreateService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
    function CreateIncludedService(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      AType: TBluetoothServiceType): TBluetoothGattService;
    { Characteristic Management }
    function AddCharacteristic(const AService: TBluetoothGattService;
      const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
    function CreateCharacteristic(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      const AProps: TBluetoothPropertyFlags; const ADescription: string = ''): TBluetoothGattCharacteristic;
    { Descriptor Management }
    function CreateDescriptor(const ACharacteristic: TBluetoothGattCharacteristic;
      const AnUUID: TBluetoothUUID): TBluetoothGattDescriptor;
    function GetServices: TBluetoothGattServiceList;
    procedure ClearServices;
    procedure Close;
    /// <summary> Advertises peripheral manager data </summary>
    procedure StartAdvertising;
    /// <summary> Stops advertising peripheral manager data </summary>
    procedure StopAdvertising;
    /// <summary> The Gatt Server Name to be advertised </summary>
    property GattServerName: string read FGattServerName write SetGattServerName;
    /// <summary> A Boolean value indicating whether the peripheral is currently advertising data </summary>
    property IsAdvertising: Boolean read GetIsAdvertising;
    /// <summary> Set to true, advertises data automatically each time we add new service to AddService </summary>
    property AdvertiseService: Boolean read FAdvertiseService write FAdvertiseService;
    property OnConnectedDevice: TConnectLEDeviceEvent read FOnConnectedDevice write FOnConnectedDevice;
    property OnDisconnectDevice: TConnectLEDeviceEvent read FOnDisconnectDevice write FOnDisconnectDevice;
    property OnCharacteristicRead: TGattCharacteristicReadEvent read FOnCharacteristicRead write FOnCharacteristicRead;
    property OnCharacteristicWrite: TGattCharacteristicWriteEvent read FOnCharacteristicWrite write FOnCharacteristicWrite;
    property OnServiceAdded: TGattServiceEvent read FOnGattServiceAdded write FOnGattServiceAdded;
    property OnClientSubscribed: TGattCharacteristicSubscriptionEvent read FOnClientSubscribed write FOnClientSubscribed;
    property OnClientUnsubscribed: TGattCharacteristicSubscriptionEvent read FOnClientUnsubscribed write FOnClientUnsubscribed;
    /// <summary> A TBluetoothLEAdvertiseData object representing this Gatt Server advertising data </summary>
    property AdvertiseData: TBluetoothLEAdvertiseData read FAdvertiseData;
    procedure UpdateCharacteristicValue(const ACharacteristic: TBluetoothGattCharacteristic);
  end;

{$ENDIF BLUETOOTH_LE}

const
  BLUETOOTH_BASE_UUID: TGUID = '{00000000-0000-1000-8000-00805F9B34FB}';

implementation

uses
  System.NetConsts,
  System.TypInfo,
  System.Math,
{$IFDEF ANDROID}
  System.Android.Bluetooth;
{$ENDIF ANDROID}
{$IFDEF MACOS}
  System.Mac.Bluetooth;
{$ENDIF MACOS}
{$IFDEF MSWINDOWS}
  System.Win.Bluetooth;
{$ENDIF}
{$IFDEF LINUX}
  System.Linux.Bluetooth;
{$ENDIF LINUX}


{$IFDEF BLUETOOTH_CLASSIC}
////////////////////////////////////////
//         Bluetooth Clasic          //
////////////////////////////////////////
{ TBluetoothClassicManager }

class function TBluetoothManager.AddDeviceToList(const ADevice: TBluetoothDevice;
      const ADeviceList: TBluetoothDeviceList): TBluetoothDevice;
var
  LAddress: TBluetoothMacAddress;
  LDevice: TBluetoothDevice;
  LFound: Boolean;
begin
  Result := ADevice;
  LFound := False;
  LAddress := ADevice.Address;
  for LDevice in ADeviceList do
  begin
    if LDevice.Address = LAddress then
    begin
      LFound := True;
      Result := LDevice;
      Break;
    end;
  end;
  if not LFound then
    ADeviceList.Add(ADevice);
end;

procedure TBluetoothManager.CancelDiscovery;
begin
  CurrentAdapter.CancelDiscovery;
end;

class constructor TBluetoothManager.Create;
begin
  FBluetoothManagerClass := TPlatformBluetoothClassicManager;
  FSocketTimeout := 5000;
end;

constructor TBluetoothManager.Create;
begin
  inherited;
  FDiscoveredDevices := TBluetoothDeviceList.Create(False);                             
  FPairedDevices := TBluetoothDeviceList.Create(False);
end;

destructor TBluetoothManager.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LDevice: TBluetoothDevice;
{$ENDIF AUTOREFCOUNT}
begin
{$IFNDEF AUTOREFCOUNT}
  for LDevice in FDiscoveredDevices do
    LDevice.Free;
{$ENDIF AUTOREFCOUNT}
  FDiscoveredDevices.Free;
  FPairedDevices.Free;
  inherited;
end;

function TBluetoothManager.CreateServerSocket(const AName: string; const AUUID: TGUID;
  Secure: Boolean): TBluetoothServerSocket;
var
  LAdapter: TBluetoothAdapter;
begin
  Result := nil;
  if AName = '' then
    raise EBluetoothSocketException.Create(SBluetoothInvalidServiceName);

  LAdapter := CurrentAdapter;
  if LAdapter <> nil then
    Result := LAdapter.DoCreateServerSocket(AName, AUUID, Secure);
end;

procedure TBluetoothManager.DoDiscoverableEnd(const Sender: TObject);
begin
  try
    if Assigned(FOnDiscoverableEnd) then
      FOnDiscoverableEnd(Sender);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothManager.DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
begin
  FLastDiscoveredTimeStamp := Now;
  try
    if Assigned(FOnDiscoveryEnd) then
      FOnDiscoveryEnd(Sender, ADeviceList);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothManager.DoRemoteRequestPair(const ADevice: TBluetoothDevice);
begin
  try
    if Assigned(FOnRemoteRequestPair) then
      FOnRemoteRequestPair(ADevice);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

class destructor TBluetoothManager.Destroy;
begin
  FCurrentManager.Free;
end;

function TBluetoothManager.GetCurrentAdapter: TBluetoothAdapter;
begin
  Result := DoGetClassicAdapter;
  if Result = nil then
    raise EBluetoothAdapterException.Create(SBluetoothDeviceNotFound);
end;

function TBluetoothManager.GetLastPairedDevices: TBluetoothDeviceList;
begin
  Result := FPairedDevices;
  if FPairedDevices.Count = 0 then
    GetPairedDevices;
end;

class function TBluetoothManager.GetKnownServiceName(const AServiceUUID: TGUID): string;
type
  TServiceNames = array [0..103] of TBluetoothService;

const
  ServiceNames: TServiceNames = (
    (Name: 'Base GUID'; UUID:'{00000000-0000-1000-8000-00805F9B34FB}'),
    // PROTOCOLS
    (Name: 'SDP - Service Discovery Protocol'; UUID:'{00000001-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UDP - User Datagram Protocol'; UUID:'{00000002-0000-1000-8000-00805F9B34FB}'),
    (Name: 'RFCOMM - Radio Frequency Communication Protocol'; UUID:'{00000003-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TCP - Transmission Control Protocol'; UUID:'{00000004-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TCSBIN'; UUID:'{00000005-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TCSAT'; UUID:'{00000006-0000-1000-8000-00805F9B34FB}'),
    (Name: 'OBEX - Object Exchange Protocol'; UUID:'{00000008-0000-1000-8000-00805F9B34FB}'),
    (Name: 'IP'; UUID:'{00000009-0000-1000-8000-00805F9B34FB}'),
    (Name: 'FTP'; UUID:'{0000000A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HTTP'; UUID:'{0000000C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'WSP'; UUID:'{0000000E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'BNEP'; UUID:'{0000000F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UPNP'; UUID:'{00000010-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HIDP'; UUID:'{00000011-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Control Channel Protocol'; UUID:'{00000012-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Data Channel Protocol'; UUID:'{00000014-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Notification Protocol'; UUID:'{00000016-0000-1000-8000-00805F9B34FB}'),
    (Name: 'VCTP Protocol'; UUID:'{00000017-0000-1000-8000-00805F9B34FB}'),
    (Name: 'VDTP Protocol'; UUID:'{00000019-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CMPT Protocol'; UUID:'{0000001B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UDI C Plane Protocol'; UUID:'{0000001D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'MCAP Control Channel'; UUID:'{0000001E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'MCAP Data Channel'; UUID:'{0000001F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'L2CAP'; UUID:'{00000100-0000-1000-8000-00805F9B34FB}'),
    // SERVICES
    (Name: 'Service Discovery Server'; UUID:'{00001000-0000-1000-8000-00805F9B34FB}'),
    (Name: 'BrowseGroupDescriptor'; UUID:'{00001001-0000-1000-8000-00805F9B34FB}'),
    (Name: 'PublicBrowseGroup'; UUID:'{00001002-0000-1000-8000-00805F9B34FB}'),
    (Name: 'SerialPort'; UUID:'{00001101-0000-1000-8000-00805F9B34FB}'),
    (Name: 'LAN Access Using PPP'; UUID:'{00001102-0000-1000-8000-00805F9B34FB}'),
    (Name: 'DialupNetworking'; UUID:'{00001103-0000-1000-8000-00805F9B34FB}'),
    (Name: 'IrMCSync'; UUID:'{00001104-0000-1000-8000-00805F9B34FB}'),
    (Name: 'OBEXObjectPush'; UUID:'{00001105-0000-1000-8000-00805F9B34FB}'),
    (Name: 'OBEXFileTransfer'; UUID:'{00001106-0000-1000-8000-00805F9B34FB}'),
    (Name: 'IrMCSyncCommand'; UUID:'{00001107-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HSP (Headset Profile)'; UUID:'{00001108-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Cordless Telephony'; UUID:'{00001109-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Audio Source'; UUID:'{0000110A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Audio Sink'; UUID:'{0000110B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'AV Remote Control Target'; UUID:'{0000110C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Advanced Audio Distribution'; UUID:'{0000110D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'AV Remote Control'; UUID:'{0000110E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Video Conferencing'; UUID:'{0000110F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Intercom'; UUID:'{00001110-0000-1000-8000-00805F9B34FB}'),
    (Name: 'FAX'; UUID:'{00001111-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Headset Audio Gateway'; UUID:'{00001112-0000-1000-8000-00805F9B34FB}'),
    (Name: 'WAP'; UUID:'{00001113-0000-1000-8000-00805F9B34FB}'),
    (Name: 'WAP Client'; UUID:'{00001114-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Personal Area Network User (PANU)'; UUID:'{00001115-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Network Access Point (NAP)'; UUID:'{00001116-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Group Ad-hoc Network (GN)'; UUID:'{00001117-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Direct Printing'; UUID:'{00001118-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Reference Printing'; UUID:'{00001119-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Imaging'; UUID:'{0000111A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Imaging Responder'; UUID:'{0000111B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Imaging Automatic Archive'; UUID:'{0000111C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Imaging Referenced Objects'; UUID:'{0000111D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Handsfree'; UUID:'{0000111E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Handsfree Audio Gateway'; UUID:'{0000111F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Direct Printing Reference Objects'; UUID:'{00001120-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Reflected UI'; UUID:'{00001121-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Basic Printing'; UUID:'{00001122-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Printing Status'; UUID:'{00001123-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Human Interface Device'; UUID:'{00001124-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Cable Replacement'; UUID:'{00001125-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Cable Replacement Print'; UUID:'{00001126-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardcopy Cable Replacement Scan'; UUID:'{00001127-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Common ISDN Access Service Class'; UUID:'{00001128-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Video Conferencing Gateway'; UUID:'{00001129-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UDI MT'; UUID:'{0000112A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UDI TA'; UUID:'{0000112B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Audio Video'; UUID:'{0000112C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'SIM Access'; UUID:'{0000112D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Phonebook Access - PCE'; UUID:'{0000112E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Phonebook Access - PSE'; UUID:'{0000112F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Phonebook Access'; UUID:'{00001130-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Headset headset'; UUID:'{00001131-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Message Access Server'; UUID:'{00001132-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Message Notification Server'; UUID:'{00001133-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Message Access Profile'; UUID:'{00001134-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Global Navigation Satellite System Profile (GNSS)'; UUID:'{00001135-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Global Navigation Satellite System Profile (GNSS Server)'; UUID:'{00001136-0000-1000-8000-00805F9B34FB}'),
    (Name: '3D Display - 3D Synchronization Profile (3DSP)'; UUID:'{00001137-0000-1000-8000-00805F9B34FB}'),
    (Name: '3D Glasses - 3D Synchronization Profile (3DSP)'; UUID:'{00001138-0000-1000-8000-00805F9B34FB}'),
    (Name: '3D Synchronization - 3D Synchronization Profile (3DSP)'; UUID:'{00001139-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Multi-Profile Specification Profile (MPS)'; UUID:'{0000113A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Multi-Profile Specification Service Class (MPS)'; UUID:'{0000113B-0000-1000-8000-00805F9B34FB}'),

    (Name: 'PnP Information'; UUID:'{00001200-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Generic Networking'; UUID:'{00001201-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Generic File Transfer'; UUID:'{00001202-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Generic Audio'; UUID:'{00001203-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Generic Telephony'; UUID:'{00001204-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UPnP'; UUID:'{00001205-0000-1000-8000-00805F9B34FB}'),
    (Name: 'UPnP IP'; UUID:'{00001206-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Esdp UPnP IP PAN'; UUID:'{00001300-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Esdp UPnP IP LAP'; UUID:'{00001301-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Edp Upnp L2CAP'; UUID:'{00001302-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Video Distribution Profile - Source'; UUID:'{00001303-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Video Distribution Profile - Sink'; UUID:'{00001304-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Video Distribution Profile'; UUID:'{00001305-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Health Device Profile (HDP)'; UUID:'{00001400-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Health Device Profile (HDP) - Source'; UUID:'{00001401-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Health Device Profile (HDP) - Sink'; UUID:'{00001402-0000-1000-8000-00805F9B34FB}'),
    (Name: 'ActiveSync'; UUID:'{831C4071-7BC8-4A9C-A01C-15DF25A4ADBC}')
  );
var
  I: Integer;
begin
  Result := '';
  for I := Low(ServiceNames) to High(ServiceNames) do
    if ServiceNames[I].UUID = AServiceUUID then
      Exit(ServiceNames[I].Name);

  if Assigned(FOnIdentifyCustomUUID) then
    Result := FOnIdentifyCustomUUID(nil, AServiceUUID);
end;

function TBluetoothManager.GetPairedDevices: TBluetoothDeviceList;
var
  LDevice: TBluetoothDevice;
begin
  Result := FPairedDevices;
  TMonitor.Enter(FPairedDevices);
  try
    Result.Clear;
    for LDevice in CurrentAdapter.GetPairedDevices do
      TBluetoothManager.AddDeviceToList(LDevice, Result);
  finally
    TMonitor.Exit(FPairedDevices);
  end;
end;

function TBluetoothManager.GetPairedDevices(const AnAdapter: TBluetoothAdapter): TBluetoothDeviceList;
begin
  Result := AnAdapter.GetPairedDevices;
end;

class function TBluetoothManager.InternalGetBluetoothManager: TBluetoothManager;
begin
  if FCurrentManager = nil then
    if FBluetoothManagerClass <> nil then
      FCurrentManager := FBluetoothManagerClass.GetBlueToothManager
    else
      raise EBluetoothManagerException.Create(SBluetoothMissingImplementation);
  Result := FCurrentManager;
end;

procedure TBluetoothManager.StartDiscoverable(Timeout: Cardinal);
begin
  CurrentAdapter.StartDiscoverable(Timeout);
end;

procedure TBluetoothManager.StartDiscovery(Timeout: Cardinal);
begin
  FDiscoveredDevices.Clear;
  CurrentAdapter.StartDiscovery(Timeout);
end;


{ TBluetoothDevice }

class function TBluetoothDevice.ClassDeviceString(ADevice: Integer): string;
begin
  case ADevice of
    1076: Result := 'AUDIO_VIDEO_CAMCORDER';
    1056: Result := 'AUDIO_VIDEO_CAR_AUDIO';
    1032: Result := 'AUDIO_VIDEO_HANDSFREE';
    1048: Result := 'AUDIO_VIDEO_HEADPHONES';
    1064: Result := 'AUDIO_VIDEO_HIFI_AUDIO';
    1044: Result := 'AUDIO_VIDEO_LOUDSPEAKER';
    1040: Result := 'AUDIO_VIDEO_MICROPHONE';
    1052: Result := 'AUDIO_VIDEO_PORTABLE_AUDIO';
    1060: Result := 'AUDIO_VIDEO_SET_TOP_BOX';
    1024: Result := 'AUDIO_VIDEO_UNCATEGORIZED';
    1068: Result := 'AUDIO_VIDEO_VCR';
    1072: Result := 'AUDIO_VIDEO_VIDEO_CAMERA';
    1088: Result := 'AUDIO_VIDEO_VIDEO_CONFERENCING';
    1084: Result := 'AUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER';
    1096: Result := 'AUDIO_VIDEO_VIDEO_GAMING_TOY';
    1080: Result := 'AUDIO_VIDEO_VIDEO_MONITOR';
    1028: Result := 'AUDIO_VIDEO_WEARABLE_HEADSET';
    260: Result := 'COMPUTER_DESKTOP';
    272: Result := 'COMPUTER_HANDHELD_PC_PDA';
    268: Result := 'COMPUTER_LAPTOP';
    276: Result := 'COMPUTER_PALM_SIZE_PC_PDA';
    264: Result := 'COMPUTER_SERVER';
    256: Result := 'COMPUTER_UNCATEGORIZED';
    280: Result := 'COMPUTER_WEARABLE';
    2308: Result := 'HEALTH_BLOOD_PRESSURE';
    2332: Result := 'HEALTH_DATA_DISPLAY';
    2320: Result := 'HEALTH_GLUCOSE';
    2324: Result := 'HEALTH_PULSE_OXIMETER';
    2328: Result := 'HEALTH_PULSE_RATE';
    2312: Result := 'HEALTH_THERMOMETER';
    2304: Result := 'HEALTH_UNCATEGORIZED';
    2316: Result := 'HEALTH_WEIGHING';
    516: Result := 'PHONE_CELLULAR';
    520: Result := 'PHONE_CORDLESS';
    532: Result := 'PHONE_ISDN';
    528: Result := 'PHONE_MODEM_OR_GATEWAY';
    524: Result := 'PHONE_SMART';
    512: Result := 'PHONE_UNCATEGORIZED';
    2064: Result := 'TOY_CONTROLLER';
    2060: Result := 'TOY_DOLL_ACTION_FIGURE';
    2068: Result := 'TOY_GAME';
    2052: Result := 'TOY_ROBOT';
    2048: Result := 'TOY_UNCATEGORIZED';
    2056: Result := 'TOY_VEHICLE';
    1812: Result := 'WEARABLE_GLASSES';
    1808: Result := 'WEARABLE_HELMET';
    1804: Result := 'WEARABLE_JACKET';
    1800: Result := 'WEARABLE_PAGER';
    1792: Result := 'WEARABLE_UNCATEGORIZED';
    1796: Result := 'WEARABLE_WRIST_WATCH';
  else
    Result := ADevice.ToString + ' - UNKNOWN DEVICE!!';
  end;
end;

class function TBluetoothDevice.ClassDeviceMajorString(AMajor: Integer): string;
begin
  case AMajor of
       0: Result := 'MISC';
     256: Result := 'COMPUTER';
     512: Result := 'PHONE';
     768: Result := 'NETWORKING';
    1024: Result := 'AUDIO_VIDEO';
    1280: Result := 'PERIPHERAL';
    1536: Result := 'IMAGING';
    1792: Result := 'WEARABLE';
    2048: Result := 'TOY';
    2304: Result := 'HEALTH';
    7936: Result := 'UNCATEGORIZED';
  else
    Result := AMajor.ToString + ' - UNKNOWN MAJOR!!';
  end;
end;

constructor TBluetoothDevice.Create;
begin
  FServiceList := TBluetoothServiceList.Create;
end;

function TBluetoothDevice.CreateClientSocket(const AUUID: TGUID; Secure: Boolean): TBluetoothSocket;
begin
  Result := DoCreateClientSocket(AUUID, Secure);
end;

destructor TBluetoothDevice.Destroy;
begin
  FServiceList.Free;
  inherited;
end;

function TBluetoothDevice.GetServiceList: TBluetoothServiceList;
begin
  Result := FServiceList;
  if FServiceList.Count = 0 then
    GetServices;
end;

function TBluetoothDevice.GetServices: TBluetoothServiceList;
begin
  TMonitor.Enter(FServiceList);
  try
    Result := DoGetServices;
  finally
    TMonitor.Exit(FServiceList);
  end;
end;

{ TBluetoothClassicAdapter }

procedure TBluetoothAdapter.CancelDiscovery;
begin
  DoCancelDiscovery;
end;

constructor TBluetoothAdapter.Create(const AManager: TBluetoothManager);
begin
  inherited Create;
  FManager := AManager;
end;

function TBluetoothAdapter.CreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket;
begin
  Result := DoCreateServerSocket(AName, AUUID, Secure);
end;

destructor TBluetoothAdapter.Destroy;
begin
  FManager := nil;
  inherited;
end;

procedure TBluetoothAdapter.DoDiscoverableEnd(const Sender: TObject);
begin
  FManager.DoDiscoverableEnd(Sender);
end;

procedure TBluetoothAdapter.DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothDeviceList);
begin
  FManager.DoDiscoveryEnd(Sender, ADeviceList);
end;

procedure TBluetoothAdapter.DoRemoteRequestPair(const ADevice: TBluetoothDevice);
begin
  FManager.DoRemoteRequestPair(ADevice);
end;

function TBluetoothAdapter.Pair(const ADevice: TBluetoothDevice): Boolean;
begin
  Result := DoPair(ADevice);
end;

procedure TBluetoothAdapter.StartDiscoverable(Timeout: Cardinal);
begin
  DoStartDiscoverable(Timeout);
end;

procedure TBluetoothAdapter.StartDiscovery(Timeout: Cardinal);
begin
  DoStartDiscovery(Timeout);
end;

function TBluetoothAdapter.UnPair(const ADevice: TBluetoothDevice): Boolean;
begin
  Result := DoUnPair(ADevice);
end;

{ TBluetoothSocket }

procedure TBluetoothSocket.Close;
begin
  DoClose;
end;

procedure TBluetoothSocket.Connect;
begin
  DoConnect;
end;

function TBluetoothSocket.ReadData: TBytes;
begin
  Result := ReceiveData(TBluetoothManager.FSocketTimeout);
end;

function TBluetoothSocket.ReadData(ATimeout: Cardinal): TBytes;
begin
  Result := ReceiveData(ATimeout);
end;

function TBluetoothSocket.ReceiveData: TBytes;
begin
  Result := ReceiveData(TBluetoothManager.FSocketTimeout);
end;

function TBluetoothSocket.ReceiveData(ATimeout: Cardinal): TBytes;
begin
  Result := DoReceiveData(ATimeout);
end;

procedure TBluetoothSocket.SendData(const AData: TBytes);
begin
  DoSendData(AData);
end;

{ TBluetoothServerSocket }

function TBluetoothServerSocket.Accept(Timeout: Cardinal): TBluetoothSocket;
begin
  Result := DoAccept(Timeout);
end;

procedure TBluetoothServerSocket.Close;
begin
  DoClose;
end;
{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
////////////////////////////////////////
//       Bluetooth Low Energy         //
////////////////////////////////////////
{ TBluetoothLEManager }

function TBluetoothLEManager.GetCurrentLEAdapter: TBluetoothLEAdapter;
begin
  Result := DoGetAdapter;
  if Result = nil then
    raise EBluetoothAdapterException.Create(SBluetoothDeviceNotFound);
end;

function TBluetoothLEManager.GetGattServer: TBluetoothGattServer;
begin
  Result := DoGetGattServer;
end;

function TBluetoothLEManager.GetSupportsGattClient: Boolean;
begin
  Result := DoGetSupportsGattClient;
end;

function TBluetoothLEManager.GetSupportsGattServer: Boolean;
begin
  Result := DoGetSupportsGattServer;
end;

class function TBluetoothLEManager.AddDeviceToList(const ADevice: TBluetoothLEDevice;
      const ADeviceList: TBluetoothLEDeviceList): TBluetoothLEDevice;
begin
  Result := GetDeviceInList(ADevice.Identifier, ADeviceList);
  if Result = nil then
  begin
    TMonitor.Enter(ADeviceList);
    try
      ADeviceList.Add(ADevice);
      Result := ADevice;
    finally
      TMonitor.Exit(ADeviceList);
    end;
  end;
end;

class function TBluetoothLEManager.GetDeviceInList(const AIdentifier: TBluetoothMacAddress;
  const ADeviceList: TBluetoothLEDeviceList): TBluetoothLEDevice;
var
  LDevice: TBluetoothLEDevice;
begin
  Result := nil;
  TMonitor.Enter(ADeviceList);
  try
    for LDevice in ADeviceList do
    begin
      if LDevice.Identifier = AIdentifier then
      begin
        Result := LDevice;
        Break;
      end;
    end;
  finally
    TMonitor.Exit(ADeviceList);
  end;
end;

class procedure TBluetoothLEManager.ClearDevicesFromList(const ADeviceList: TBluetoothLEDeviceList);
begin
  TMonitor.Enter(ADeviceList);
  try
    ADeviceList.Clear;
  finally
    TMonitor.Exit(ADeviceList);
  end;
end;

procedure TBluetoothLEManager.CancelDiscovery;
begin
  CurrentAdapter.CancelDiscovery;
end;

function TBluetoothLEManager.RssiToDistance(ARssi, ATxPower: Integer; ASignalPropagationConst: Single): Double;
begin
//  Distance formula taken From: IEEE Xplore library paper:
//   " Enhanced RSSI-Based Real-Time User Location Tracking System for Indoor and Outdoor Environments "
//  http://ieeexplore.ieee.org/xpl/articleDetails.jsp?reload=true&tp=&arnumber=4420422&queryText%3Drssi-based+location+tracking+system
//  DOI: 10.1109/ICCIT.2007.253 Pages: 1213 - 1218
//  RSSI = -(10*n*log10(d) + A)
   Result := Power(10, (ARssi - ATxPower) / -10 * ASignalPropagationConst);
end;

function TBluetoothLEManager.DoGetLEAdapter: TBluetoothLEAdapter;
begin
  Result := DoGetAdapter;
end;

class constructor TBluetoothLEManager.Create;
begin
  FBluetoothManagerClass := TPlatformBluetoothLEManager;
end;

constructor TBluetoothLEManager.Create;
begin
  inherited;
  FDiscoveredLEDevices := TBluetoothLEDeviceList.Create;
  FServicesFilterScan := False;
  FForceRefreshCachedDevices := False;
end;

destructor TBluetoothLEManager.Destroy;
begin
  FFilterUUIDList := nil;
  FDiscoveredLEDevices.Free;
  inherited;
end;

class destructor TBluetoothLEManager.Destroy;
begin
  FCurrentManager.Free;
end;

procedure TBluetoothLEManager.DoDiscoveryLEEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
begin
  DoDiscoveryEnd(Sender, ADeviceList);
end;

procedure TBluetoothLEManager.DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
  function MatchAnyService(const ADevice: TBluetoothLEDevice): Boolean;
  var
    LServiceUUID: TBluetoothUUID;
  begin
    Result := False;
    for LServiceUUID in FFilterUUIDList do
      if ADevice.ScannedAdvertiseData.ContainsServiceUUID(LServiceUUID) then
        Exit(True);
    if ADevice.DiscoverServices and (FFilterUUIDList <> nil) then
      for LServiceUUID in FFilterUUIDList do
        if ADevice.GetService(LServiceUUID) <> nil then
          Exit(True);
  end;

  function FilterDiscoveredDevices(Filter: Boolean): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if (FFilterUUIDList <> nil) and (FFilterUUIDList.Count > 0) and Filter then
      for I := ADeviceList.Count - 1 downto 0 do
        if (ADeviceList <> nil) and MatchAnyService(ADeviceList[I]) then
        begin
          DoDiscoverDevice(CurrentAdapter, ADeviceList[I], ADeviceList[I].LastRSSI, ADeviceList[I].AdvertisedData);
          ADeviceList[I].DoOnServicesDiscovered(ADeviceList[I], ADeviceList[I].Services);
        end
        else
          if FFilterUUIDList <> nil then
            ADeviceList.Delete(I)
          else
            Exit(False); //Due to TBluetoothLE.Enable = False
  end;

var
  LFilter: Boolean;
begin
  FLastDiscoveredLETimeStamp := Now;
  LFilter := FServicesFilterScan;
  FServicesFilterScan := False;
  try
    if FilterDiscoveredDevices(LFilter) and Assigned(FOnDiscoveryLEEnd) then
      FOnDiscoveryLEEnd(Sender, ADeviceList);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEManager.DoDiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse);
begin
  DoDiscoverDevice(Sender, ADevice, Rssi, ScanResponse);
end;

procedure TBluetoothLEManager.DoDiscoverDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse);
begin
  if not FServicesFilterScan then
    try
      if Assigned(FOnDiscoverLEDevice) then
        FOnDiscoverLEDevice(Sender, ADevice, Rssi, ScanResponse);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

class function TBluetoothLEManager.GetKnownServiceName(const AServiceUUID: TGUID): string;
type
  TServiceNames = array [0..186] of TBluetoothService;

const
  ServiceNames: TServiceNames = (
    (Name: 'Base GUID'; UUID:'{00000000-0000-1000-8000-00805F9B34FB}'),
    // GATT PROFILES
    (Name: 'GAP'; UUID:'{00001800-0000-1000-8000-00805F9B34FB}'),
    (Name: 'GATT'; UUID:'{00001801-0000-1000-8000-00805F9B34FB}'),
    (Name: 'IMMEDIATE ALERT'; UUID:'{00001802-0000-1000-8000-00805F9B34FB}'),
    (Name: 'LINK LOSS'; UUID:'{00001803-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TX POWER'; UUID:'{00001804-0000-1000-8000-00805F9B34FB}'),

    // GAP Services ???
    (Name: 'HEALTH THERMOMETER'; UUID:'{00001809-0000-1000-8000-00805F9B34FB}'),
    (Name: 'DEVICE INFORMATION'; UUID:'{0000180A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HEART RATE'; UUID:'{0000180D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Phone Alert Status Service'; UUID:'{0000180E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Battery Service'; UUID:'{0000180F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Blood Pressure'; UUID:'{00001810-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Human Interface Device'; UUID:'{00001812-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Scan Parameters'; UUID:'{00001813-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Running Speed and Cadence'; UUID:'{00001814-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Automation IO'; UUID:'{00001815-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CYCLING Speed and Cadence'; UUID:'{00001816-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Pulse Oximeter'; UUID:'{00001817-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CYCLING Power'; UUID:'{00001818-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Location and Navigation Service'; UUID:'{00001819-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Continous Glucose Measurement Service'; UUID:'{0000181A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'USER DATA'; UUID:'{0000181C-0000-1000-8000-00805F9B34FB}'),

    //
    (Name: 'TEMPERATURE MEASUREMENT'; UUID:'{00002A1C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TEMPERATURE TYPE'; UUID:'{00002A1D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'INTERMEDIATE TEMPERATURE'; UUID:'{00002A1E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TEMPERATURE in Celsius'; UUID:'{00002A1F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'TEMPERATURE in Fahrenheit'; UUID:'{00002A20-0000-1000-8000-00805F9B34FB}'),
    (Name: 'MEASUREMENT INTERVAL'; UUID:'{00002A21-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Boot Keyboard Input Report'; UUID:'{00002A22-0000-1000-8000-00805F9B34FB}'),
    (Name: 'System ID'; UUID:'{00002A23-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Model Number String'; UUID:'{00002A24-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Serial Number String'; UUID:'{00002A25-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Firmware Revision String'; UUID:'{00002A26-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Hardware Revision String'; UUID:'{00002A27-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Software Revision String'; UUID:'{00002A28-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Manufacturer Name String'; UUID:'{00002A29-0000-1000-8000-00805F9B34FB}'),
    (Name: 'IEEE 11073-20601 Regulatory'; UUID:'{00002A2A-0000-1000-8000-00805F9B34FB}'),

    (Name: 'Current Time'; UUID:'{00002A2B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Elevation'; UUID:'{00002A2C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Latitude'; UUID:'{00002A2D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Longitude'; UUID:'{00002A2E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Position 2D'; UUID:'{00002A2F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Position 3D'; UUID:'{00002A30-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Scan Refresh'; UUID:'{00002A31-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Boot Keyboard Output Report'; UUID:'{00002A32-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Boot Mouse Input Report'; UUID:'{00002A33-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Glucose Measurement Context'; UUID:'{00002A34-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Blood Pressure Measurement'; UUID:'{00002A35-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Intermediate Cuff Pressure'; UUID:'{00002A36-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HEART RATE MEASUREMENT'; UUID:'{00002A37-0000-1000-8000-00805F9B34FB}'),
    (Name: 'BODY SENSOR LOCATION'; UUID:'{00002A38-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HEART RATE CONTROL POINT'; UUID:'{00002A39-0000-1000-8000-00805F9B34FB}'),

    (Name: 'Removable'; UUID:'{00002A3A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Service Required'; UUID:'{00002A3B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Scientific Temperature in Celsius'; UUID:'{00002A3C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'String'; UUID:'{00002A3D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Network Availability'; UUID:'{00002A3E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Alert Status'; UUID:'{00002A3F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Ringer Control Point'; UUID:'{00002A40-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Ringer Setting'; UUID:'{00002A41-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Alert Category ID Bit Mask'; UUID:'{00002A42-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Alert Category ID'; UUID:'{00002A43-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Alert Notification Control Point'; UUID:'{00002A44-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Unread Alert Status'; UUID:'{00002A45-0000-1000-8000-00805F9B34FB}'),
    (Name: 'New Alert'; UUID:'{00002A46-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Supported New Alert Category'; UUID:'{00002A47-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Supported Unread Alert Category'; UUID:'{00002A48-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Blood Pressure Feature'; UUID:'{00002A49-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HID Information'; UUID:'{00002A4A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Report Map'; UUID:'{00002A4B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'HID Control Point'; UUID:'{00002A4C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Report'; UUID:'{00002A4D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Protocol Mode'; UUID:'{00002A4E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Scan Interval Window'; UUID:'{00002A4F-0000-1000-8000-00805F9B34FB}'),

    (Name: 'PnP ID'; UUID:'{00002A50-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Glucose Features'; UUID:'{00002A51-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Record Access Control Point'; UUID:'{00002A52-0000-1000-8000-00805F9B34FB}'),
    (Name: 'RSC Measurement'; UUID:'{00002A53-0000-1000-8000-00805F9B34FB}'),
    (Name: 'RSC Feature'; UUID:'{00002A54-0000-1000-8000-00805F9B34FB}'),
    (Name: 'SC CONTROL POINT'; UUID:'{00002A55-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Digital Input'; UUID:'{00002A56-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Digital Output'; UUID:'{00002A57-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Analog Input'; UUID:'{00002A58-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Analog Output'; UUID:'{00002A59-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Aggregate Input'; UUID:'{00002A5A-0000-1000-8000-00805F9B34FB}'),

    (Name: 'CSC MEASUREMENT'; UUID:'{00002A5B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CSC FEATURE'; UUID:'{00002A5C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'SENSOR LOCATION'; UUID:'{00002A5D-0000-1000-8000-00805F9B34FB}'),

    (Name: 'Pulse Oximetry Spot-check Measurement'; UUID:'{00002A5E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Pulse Oximetry Continuous Measurement'; UUID:'{00002A5F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Pulse Oximetry Pulsatile Event'; UUID:'{00002A60-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Pulse Oximetry Features'; UUID:'{00002A61-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Pulse Oximetry Control Point'; UUID:'{00002A62-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Cycling Power Measurement Characteristic'; UUID:'{00002A63-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Cycling Power Vector Characteristic'; UUID:'{00002A64-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Cycling Power Feature Characteristic'; UUID:'{00002A65-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Cycling Power Control Point Characteristic'; UUID:'{00002A66-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Location and Speed Characteristic'; UUID:'{00002A67-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Navigation Characteristic'; UUID:'{00002A68-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Position Quality Characteristic'; UUID:'{00002A69-0000-1000-8000-00805F9B34FB}'),
    (Name: 'LN Feature Characteristic'; UUID:'{00002A6A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'LN Control Point Characteristic'; UUID:'{00002A6B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CGM Measurement Characteristic'; UUID:'{00002A6C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CGM Features Characteristic'; UUID:'{00002A6D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CGM Status Characteristic'; UUID:'{00002A6E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CGM Session Start Time Characteristic'; UUID:'{00002A6F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Application Security Point Characteristic'; UUID:'{00002A70-0000-1000-8000-00805F9B34FB}'),
    (Name: 'CGM Specific Ops Control Point Characteristic'; UUID:'{00002A71-0000-1000-8000-00805F9B34FB}'),

    (Name: 'Glass Identity'; UUID:'{F96647CF-7F25-4277-843D-F407B4192F8B}'),
    //(Name: ''; UUID:'{-0000-1000-8000-00805F9B34FB}'),

    // GATT ATTRIBUTE TYPES
    (Name: 'Primary Service'; UUID:'{00002800-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Secondary Service'; UUID:'{00002801-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Include'; UUID:'{00002802-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Characteristic'; UUID:'{00002803-0000-1000-8000-00805F9B34FB}'),

    // GATT CHARACTERISTIC Descriptors
    (Name: 'Characteristic Extended Properties'; UUID:'{00002900-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Characteristic User Description'; UUID:'{00002901-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Client Characteristic Configuration'; UUID:'{00002902-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Server Characteristic Configuration'; UUID:'{00002903-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Characteristic Format'; UUID:'{00002904-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Characteristic Aggregate Format'; UUID:'{00002905-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Valid Range'; UUID:'{00002906-0000-1000-8000-00805F9B34FB}'),
    (Name: 'External Report Reference'; UUID:'{00002907-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Report Reference'; UUID:'{00002908-0000-1000-8000-00805F9B34FB}'),

    // GATT CHARACTERISTIC TYPES
    (Name: 'Device Name'; UUID:'{00002A00-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Appearance'; UUID:'{00002A01-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Peripheral Privacy Flag'; UUID:'{00002A02-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Reconnection Address'; UUID:'{00002A03-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Peripheral Preferred Connection Parameters'; UUID:'{00002A04-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Service Changed'; UUID:'{00002A05-0000-1000-8000-00805F9B34FB}'),

    (Name: 'Alert Level'; UUID:'{00002A06-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Tx Power Level'; UUID:'{00002A07-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Date Time'; UUID:'{00002A08-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Day of Week'; UUID:'{00002A09-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Day Date Time'; UUID:'{00002A0A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Exact Time 100'; UUID:'{00002A0B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Exact Time 256'; UUID:'{00002A0C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'DST Offset'; UUID:'{00002A0D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Zone'; UUID:'{00002A0E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Local Time Information'; UUID:'{00002A0F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Secondary Time Zone'; UUID:'{00002A10-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time with DST'; UUID:'{00002A11-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Accuracy'; UUID:'{00002A12-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Source'; UUID:'{00002A13-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Reference Time Information'; UUID:'{00002A14-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Broadcast'; UUID:'{00002A15-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Update Control Point'; UUID:'{00002A16-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Time Update State'; UUID:'{00002A17-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Glucose Measurement'; UUID:'{00002A18-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Battery Level'; UUID:'{00002A19-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Battery Power State'; UUID:'{00002A1A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Battery Level State'; UUID:'{00002A1B-0000-1000-8000-00805F9B34FB}'),

    // ???
    (Name: 'Key Service'; UUID:'{0000FFE0-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Key Service Characteristic'; UUID:'{0000FFE1-0000-1000-8000-00805F9B34FB}'),

    // TI Sensor TAG Device
    (Name: 'UUID_IRT_SERV'; UUID:'{F000AA00-0451-4000-B000-000000000000}'),
    (Name: 'UUID_IRT_DATA'; UUID:'{F000AA01-0451-4000-B000-000000000000}'), // ObjectLSB:ObjectMSB:AmbientLSB:AmbientMSB
    (Name: 'UUID_IRT_CONF'; UUID:'{F000AA02-0451-4000-B000-000000000000}'), // 0: disable, 1: enable
    (Name: 'UUID_IRT_PERI'; UUID:'{F000AA03-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'UUID_ACC_SERV'; UUID:'{F000AA10-0451-4000-B000-000000000000}'),
    (Name: 'UUID_ACC_DATA'; UUID:'{F000AA11-0451-4000-B000-000000000000}'),
    (Name: 'UUID_ACC_CONF'; UUID:'{F000AA12-0451-4000-B000-000000000000}'), // 0: disable, 1: enable
    (Name: 'UUID_ACC_PERI'; UUID:'{F000AA13-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'UUID_HUM_SERV'; UUID:'{F000AA20-0451-4000-B000-000000000000}'),
    (Name: 'UUID_HUM_DATA'; UUID:'{F000AA21-0451-4000-B000-000000000000}'),
    (Name: 'UUID_HUM_CONF'; UUID:'{F000AA22-0451-4000-B000-000000000000}'), // 0: disable, 1: enable
    (Name: 'UUID_HUM_PERI'; UUID:'{F000AA23-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'UUID_MAG_SERV'; UUID:'{F000AA30-0451-4000-B000-000000000000}'),
    (Name: 'UUID_MAG_DATA'; UUID:'{F000AA31-0451-4000-B000-000000000000}'),
    (Name: 'UUID_MAG_CONF'; UUID:'{F000AA32-0451-4000-B000-000000000000}'), // 0: disable, 1: enable
    (Name: 'UUID_MAG_PERI'; UUID:'{F000AA33-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'UUID_BAR_SERV'; UUID:'{F000AA40-0451-4000-B000-000000000000}'),
    (Name: 'UUID_BAR_DATA'; UUID:'{F000AA41-0451-4000-B000-000000000000}'),
    (Name: 'UUID_BAR_CONF'; UUID:'{F000AA42-0451-4000-B000-000000000000}'), // 0: disable, 1: enable
    (Name: 'UUID_BAR_CALI'; UUID:'{F000AA43-0451-4000-B000-000000000000}'), // Calibration characteristic
    (Name: 'UUID_BAR_PERI'; UUID:'{F000AA44-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'UUID_GYR_SERV'; UUID:'{F000AA50-0451-4000-B000-000000000000}'),
    (Name: 'UUID_GYR_DATA'; UUID:'{F000AA51-0451-4000-B000-000000000000}'),
    (Name: 'UUID_GYR_CONF'; UUID:'{F000AA52-0451-4000-B000-000000000000}'), // 0: disable, bit 0: enable x, bit 1: enable y, bit 2: enable z
    (Name: 'UUID_GYR_PERI'; UUID:'{F000AA53-0451-4000-B000-000000000000}'), // Period in tens of milliseconds

    (Name: 'TEST_SERVICE'; UUID:'{F000AA60-0451-4000-B000-000000000000}'),
    (Name: 'TEST_DATA'; UUID:'{F000AA61-0451-4000-B000-000000000000}'),
    (Name: 'TEST_CONFIG'; UUID:'{F000AA62-0451-4000-B000-000000000000}'), // Bit 7: Enable Test Mode; Bit 0-1 LED BitMask

    (Name: 'Connection Control Service'; UUID:'{F000CCC0-0451-4000-B000-000000000000}'),
    (Name: 'Connection Parameters'; UUID:'{F000CCC1-0451-4000-B000-000000000000}'),
    (Name: 'Request Connection Parameters'; UUID:'{F000CCC2-0451-4000-B000-000000000000}'),
    (Name: 'Disconnect Request'; UUID:'{F000CCC3-0451-4000-B000-000000000000}'),

    (Name: 'OAD Service'; UUID:'{F000FFC0-0451-4000-B000-000000000000}'),
    (Name: 'OAD Image Identify'; UUID:'{F000FFC1-0451-4000-B000-000000000000}'),
    (Name: 'OAD Image Block'; UUID:'{F000FFC2-0451-4000-B000-000000000000}')
  );
var
  I: Integer;
begin
  Result := '';
  for I := Low(ServiceNames) to High(ServiceNames) do
    if ServiceNames[I].UUID = AServiceUUID then
      Exit(ServiceNames[I].Name);

  if Assigned(FOnIdentifyCustomUUID) then
    Result := FOnIdentifyCustomUUID(nil, AServiceUUID);
end;

class function TBluetoothLEManager.InternalGetBluetoothManager: TBluetoothLEManager;
begin
  if FCurrentManager = nil then
    FCurrentManager := CreateInstance;
  Result := FCurrentManager;
end;

class function TBluetoothLEManager.CreateInstance: TBluetoothLEManager;
begin
  if FBluetoothManagerClass <> nil then
    Result := FBluetoothManagerClass.GetBlueToothManager
  else
    raise EBluetoothManagerException.Create(SBluetoothMissingImplementation);
end;

function TBluetoothLEManager.StartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList; ForceConnect: Boolean): Boolean;
begin
  FFilterUUIDList := AFilterUUIDList;
  FServicesFilterScan := ((FFilterUUIDList <> nil) and (FFilterUUIDList.Count > 0) and ForceConnect);
  Result := CurrentAdapter.StartDiscovery(Timeout, FFilterUUIDList, ForceConnect);
end;

function TBluetoothLEManager.StartDiscovery(Timeout: Cardinal; const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;
begin
  Result := CurrentAdapter.StartDiscovery(Timeout, nil, False, ABluetoothLEScanFilterList);
end;

function TBluetoothLEManager.StartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList; Refresh: Boolean): Boolean;
begin
  Result := CurrentAdapter.StartDiscoveryRaw(ABluetoothLEScanFilterList, Refresh);
end;

{ TBluetoothLEAdapter }

procedure TBluetoothLEAdapter.CancelDiscovery;
begin
  DoCancelDiscovery;
  FManager.FServicesFilterScan := False;
end;

constructor TBluetoothLEAdapter.Create(const AManager: TBluetoothLEManager);
begin
  inherited Create;
  FManager := AManager;
end;

destructor TBluetoothLEAdapter.Destroy;
begin
  FManager := nil;
  inherited;
end;

function TBluetoothLEAdapter.DoStartLeDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil): Boolean;
begin
  Result := DoStartDiscovery(Timeout, AFilterUUIDList);
end;

function TBluetoothLEAdapter.DoStartLeDiscoveryRaw: Boolean; //deprecated 'Use DoStartDiscoveryRaw';
begin
  Result := DoStartDiscoveryRaw;
end;

procedure TBluetoothLEAdapter.DoCancelLeDiscovery;
begin
  DoCancelDiscovery;
end;

procedure TBluetoothLEAdapter.DoDiscoveryLEEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
begin
  DoDiscoveryEnd(Sender, ADeviceList);
end;

procedure TBluetoothLEAdapter.DoDiscoveryEnd(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
begin
  FManager.DoDiscoveryEnd(Sender, ADeviceList);
end;

procedure TBluetoothLEAdapter.DoDiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer;
  const ScanResponse: TScanResponse);
begin
  DoDiscoverDevice(Sender, ADevice, Rssi, ScanResponse);
end;

procedure TBluetoothLEAdapter.DoDiscoverDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer;
  const ScanResponse: TScanResponse);
begin
  FManager.DoDiscoverDevice(Sender, ADevice, Rssi, ScanResponse);
end;

function TBluetoothLEAdapter.StartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList; ForceConnect: Boolean;
      const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;
begin
  if ForceConnect then
    Result := DoStartDiscovery(Timeout)
  else
    Result := DoStartDiscovery(Timeout, AFilterUUIDList, ABluetoothLEScanFilterList);
end;

function TBluetoothLEAdapter.StartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList; Refresh: Boolean): Boolean;
begin
  Result := DoStartDiscoveryRaw(ABluetoothLEScanFilterList, Refresh);
end;

function TBluetoothLEAdapter.DoDeviceOvercomesFilters(const ADevice: TBluetoothLEDevice;
  const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;

  function CompareTbytes(const TB1: TBytes; const TB2: TBytes; const TBMask: TBytes): Boolean;
  var
    I: Integer;
  begin
    if (Length(TB1) > 0) and (Length(TB1) = Length(TB2)) and ((TBMask = nil) or (Length(TB1) = Length(TBMask))) then
    begin
      Result := True;
      for I := 0 to Length(TB1) - 1 do
        if (TBMask = nil) or (TBMask[I] = $1) then
          if TB1[I] <> TB2[I] then
          begin
            Result := False;
            Break;
          end;
    end
    else
      Result := False;
  end;

var
  I,C: Integer;
  LBlUUIDArray: TArray<TBluetoothUUID>;
begin
  Result := False;

  for I := 0 to ABluetoothLEScanFilterList.count - 1 do
  begin
    if (ABluetoothLEScanFilterList[I].LocalName <> '') and  (ABluetoothLEScanFilterList[I].LocalName = ADevice.DeviceName) then
    begin
      Result := True;
      Break;
    end;

    if (ABluetoothLEScanFilterList[I].DeviceAddress <> '') and (ABluetoothLEScanFilterList[I].DeviceAddress = ADevice.Address) then
    begin
      Result := True;
      Break;
    end;

    if CompareTbytes(ADevice.ScannedAdvertiseData.ManufacturerSpecificData, ABluetoothLEScanFilterList[I].ManufacturerSpecificData,
      ABluetoothLEScanFilterList[I].ManufacturerSpecificDataMask) then
    begin
      Result := True;
      Break;
    end;

    if ABluetoothLEScanFilterList[I].ServiceUUIDMask = TGUID.Empty then
    begin
      LBlUUIDArray := ADevice.ScannedAdvertiseData.ServiceUUIDs;
      for C := 0 to Length(LBlUUIDArray) - 1 do
        if LBlUUIDArray[C] = ABluetoothLEScanFilterList[I].ServiceUUID then
        begin
          Result := True;
          Break;
        end
    end
    else
    begin
      for C := 0 to Length(ADevice.ScannedAdvertiseData.ServiceUUIDs) - 1 do
        if CompareTbytes(ADevice.ScannedAdvertiseData.ServiceUUIDs[C].ToByteArray, ABluetoothLEScanFilterList[I].ServiceUUID.ToByteArray,
          ABluetoothLEScanFilterList[I].ServiceUUIDMask.ToByteArray) then
        begin
          Result := True;
          Break;
        end
    end;
    if Result then
      Break;

    if ABluetoothLEScanFilterList[I].ServiceData.Key <>  TGUID.Empty then
      for C := 0 to Length(ADevice.ScannedAdvertiseData.ServiceData) - 1 do
        if ADevice.ScannedAdvertiseData.ServiceData[C].Key = ABluetoothLEScanFilterList[I].ServiceData.Key then
        begin
          if CompareTbytes(ADevice.ScannedAdvertiseData.ServiceData[C].Value, ABluetoothLEScanFilterList[I].ServiceData.Value,
            ABluetoothLEScanFilterList[I].ServiceDataMask) then
          begin
            Result := True;
            Break;
          end
        end;
    if Result then
      Break;
  end;
end;

{ TBluetoothGattServer }

function TBluetoothGattServer.CreateIncludedService(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
  AType: TBluetoothServiceType): TBluetoothGattService;
begin
  Result := DoCreateIncludedService(AService, AnUUID, AType);
end;

function TBluetoothGattServer.CreateCharacteristic(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
  const AProps: TBluetoothPropertyFlags; const ADescription: string = ''): TBluetoothGattCharacteristic;
begin
  Result := DoCreateCharacteristic(AService, AnUUID, AProps, ADescription);
end;

function TBluetoothGattServer.CreateDescriptor(const ACharacteristic: TBluetoothGattCharacteristic;
  const AnUUID: TBluetoothUUID): TBluetoothGattDescriptor;
begin
  Result := DoCreateDescriptor(ACharacteristic, AnUUID);
end;

procedure TBluetoothGattServer.UpdateCharacteristicValue(const ACharacteristic: TBluetoothGattCharacteristic);
begin
  DoUpdateCharacteristicValue(ACharacteristic);
end;

function TBluetoothGattServer.CreateService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
begin
  Result := DoCreateService(AnUUID, AType);
end;

procedure TBluetoothGattServer.ClearServices;
var
  LService: TBluetoothGattService;
begin
  for LService in FServices do
    AdvertiseData.RemoveServiceUUID(LService.UUID);
  DoClearServices;
end;

procedure TBluetoothGattServer.Close;
begin
  DoClose;
end;

constructor TBluetoothGattServer.Create(const AManager: TBluetoothLEManager);
begin
  inherited Create;
  FManager := AManager;
  FServices := TBluetoothGattServiceList.Create;
  FAdvertiseService := True;
  FAdvertiseData := DoCreateAdvertiseData;
end;

destructor TBluetoothGattServer.Destroy;
begin
  StopAdvertising;
  FAdvertiseData.Free;
  FServices.Free;
  FManager := nil;
  inherited;
end;

function TBluetoothGattServer.FindService(const AUUID: TGuid): TBluetoothGattService;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FServices.Count - 1 do
    if FServices[I].UUID = AUUID then
      Exit(FServices[I]);
end;

function TBluetoothGattServer.AddService(const AService: TBluetoothGattService; ShouldAdvertise: Boolean): Boolean;
var
  LPos: Integer;
begin
  if FindService(AService.UUID) <> nil then
      raise EBluetoothServiceException.CreateFmt(SBluetoothServiceAlreadyExists, [AService.UUID.ToString]);

  LPos := FServices.Add(AService);
  Result := DoAddService(AService);
  if not Result then
    FServices.Delete(LPos)
  else
    if ShouldAdvertise then
    begin
      AdvertiseData.AddServiceUUID(AService.UUID);
      if AdvertiseService then
        DoStartAdvertising;
    end;
end;

function TBluetoothGattServer.AddCharacteristic(const AService: TBluetoothGattService;
  const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  Result := True;
                                        
  //Result := AService.FindCharacteristic(ACharacteristic) <> nil;
  if Result then
    Result := DoAddCharacteristic(AService, ACharacteristic);
end;

procedure TBluetoothGattServer.DoOnConnectedDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice);
begin
  try
    if Assigned(FOnConnectedDevice) then
      FOnConnectedDevice(Sender, ADevice);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothGattServer.DoOnDisconnectDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice);
begin
  try
    if Assigned(FOnDisconnectDevice) then
      FOnDisconnectDevice(Sender, ADevice);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothGattServer.DoOnServiceAdded(const Sender: TObject; const AService: TBluetoothGattService;
  const AGattStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnGattServiceAdded) then
      FOnGattServiceAdded(Sender, AService, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothGattServer.DoOnCharacteristicRead(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
  var AGattStatus: TBluetoothGattStatus);
var
  LStatus: TBluetoothGattStatus;
begin
  if Assigned(FOnCharacteristicRead) then
    FOnCharacteristicRead(Self, ACharacteristic, LStatus);
end;

procedure TBluetoothGattServer.DoOnCharacteristicWrite(const Sender: TObject; const ACharacteristic: TBluetoothGattCharacteristic;
      var AGattStatus: TBluetoothGattStatus; const Value: TBytes);
begin
  if Assigned(FOnCharacteristicWrite) then
    FOnCharacteristicWrite(Self, ACharacteristic, AGattStatus, TByteDynArray(Value));
end;

procedure TBluetoothGattServer.DoOnClientSubscribed(const Sender: TObject; const AClientId: string;
  const ACharacteristic: TBluetoothGattCharacteristic);
begin
  if Assigned(FOnClientSubscribed) then
    FOnClientSubscribed(Self, AClientId, ACharacteristic);
end;

procedure TBluetoothGattServer.DoOnClientUnsubscribed(const Sender: TObject; const AClientId: string;
  const ACharacteristic: TBluetoothGattCharacteristic);
begin
  if Assigned(FOnClientUnsubscribed) then
    FOnClientUnsubscribed(Self, AClientId, ACharacteristic);
end;


function TBluetoothGattServer.GetIsAdvertising: Boolean;
begin
  Result := DoIsAdvertising;
end;

procedure TBluetoothGattServer.SetGattServerName(AName: string);
begin
  if FGattServerName <> AName then
  begin
    FGattServerName := AName;
    AdvertiseData.LocalName := AName;
  end;
end;

procedure TBluetoothGattServer.StartAdvertising;
begin
  DoStartAdvertising;
end;

procedure TBluetoothGattServer.StopAdvertising;
begin
  DoStopAdvertising;
end;

function TBluetoothGattServer.GetServices: TBluetoothGattServiceList;
begin
  Result := DoGetServices;
end;

{ TBluetoothGattService }

constructor TBluetoothGattService.Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType);
begin
  inherited Create;
  FCharacteristics := TBluetoothGattCharacteristicList.Create;
  FIncludedServices := TBluetoothGattServiceList.Create;
end;

destructor TBluetoothGattService.Destroy;
begin
  FIncludedServices.Free;
  FCharacteristics.Free;
  inherited;
end;

function TBluetoothGattService.CreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
begin
  { Search the Service Before creating }
  Result := DoCreateIncludedService(AnUUID, AType);
  if Result <> nil then
  begin
    if DoAddIncludedService(Result) then // Publish or add to the internal of the platform framework.
      { Add to service list }
      FIncludedServices.Add(Result);
  end;
end;

function TBluetoothGattService.CreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
  const ADescription: string): TBluetoothGattCharacteristic;
begin
  if GetCharacteristic(AUUID) = nil then
  begin
    Result := DoCreateCharacteristic(Auuid, APropertyFlags, ADescription);
    if Result <> nil then
    begin
      if DoAddCharacteristic(Result) then // Publish or add to the internal of the platform framework.
      begin
        Result.FService := Self;
        FCharacteristics.Add(Result);
      end
      else
        Result := nil;
    end;
  end
  else
    raise Exception.CreateFmt(SBluetoothLECharacteristicExists, [AUUid.ToString]);
end;

function TBluetoothGattService.GetCharacteristic(const AUUID: TBluetoothUUID): TBluetoothGattCharacteristic;
var
  LCharacteristic: TBluetoothGattCharacteristic;
begin
  Result := nil;
  for LCharacteristic in FCharacteristics do
    if LCharacteristic.UUID = AUUID then
    begin
      Result := LCharacteristic;
      Break;
    end;
end;

function TBluetoothGattService.GetCharacteristics: TBluetoothGattCharacteristicList;
begin
  if FCharacteristics.Count = 0 then
    Result := DoGetCharacteristics
  else
    Result := FCharacteristics;
end;

function TBluetoothGattService.GetIncludedServices: TBluetoothGattServiceList;
begin
  if FIncludedServices.Count = 0 then
    Result := DoGetIncludedServices
  else
    Result := FIncludedServices;
end;

function TBluetoothGattService.GetServiceUUIDName: string;
begin
  Result := TBluetoothLEManager.GetKnownServiceName(GetServiceUUID);
end;

{ TBluetoothCharacteristic }

constructor TBluetoothGattCharacteristic.Create(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags);
begin
  inherited Create;
  FDescriptors := TBluetoothGattDescriptorList.Create;
end;

constructor TBluetoothGattCharacteristic.Create(const AService: TBluetoothGattService);
begin
  inherited Create;
  FService := AService;
  FDescriptors := TBluetoothGattDescriptorList.Create;
end;

destructor TBluetoothGattCharacteristic.Destroy;
begin
  FService := nil;
  FDescriptors.Free;
  inherited;
end;

function TBluetoothGattCharacteristic.AddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := DoAddDescriptor(ADescriptor);
  if Result then
    FDescriptors.Add(ADescriptor);
end;

function TBluetoothGattCharacteristic.CreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor;
begin
  Result := DoCreateDescriptor(AUUID);
end;

function TBluetoothGattCharacteristic.GetDescriptor(const AUuid: TBluetoothUUID): TBluetoothGattDescriptor;
var
  LDescriptor: TBluetoothGattDescriptor;
begin
  Result := nil;

  for LDescriptor in FDescriptors do
    if LDescriptor.UUID = AUuid then
    begin
      Result := LDescriptor;
      Break;
    end;
end;

function TBluetoothGattCharacteristic.GetDescriptors: TBluetoothGattDescriptorList;
begin
  if FDescriptors.Count = 0 then
    Result := DoGetDescriptors
  else
    Result := FDescriptors;
end;

function TBluetoothGattCharacteristic.GetService: TBluetoothGattService;
begin
  Result := FService;
end;

function TBluetoothGattCharacteristic.GetUUIDName: string;
begin
  Result := TBluetoothLEManager.GetKnownServiceName(GetUUID);
end;

function TBluetoothGattCharacteristic.GetValue: TBytes;
begin
  Result := DoGetValue;
end;

procedure TBluetoothGattCharacteristic.SetValue(const AValue: TBytes);
begin
  DoSetValue(AValue);
end;

function TBluetoothGattCharacteristic.GetValueAs<T>(Offset: Integer): T;
begin
  Move(Value[Offset], Result, SizeOf(T));
end;

procedure TBluetoothGattCharacteristic.SetValueAs<T>(AValue: T; Offset: Integer);
var
  LBytes: TBytes;
begin
  LBytes := Value;
  if (Length(LBytes) < Offset + SizeOf(AValue)) then
      SetLength(LBytes, Offset + SizeOf(AValue));
  Move(AValue, LBytes[Offset], SizeOf(AValue));
  SetValue(LBytes);
end;

function TBluetoothGattCharacteristic.GetValueAsInt16(Offset: Integer): Int16;
begin
  Result := GetValueAs<Int16>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsInt32(Offset: Integer): Int32;
begin
  Result := GetValueAs<Int32>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsInt64(Offset: Integer): Int64;
begin
  Result := GetValueAs<Int64>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsInt8(Offset: Integer): Int8;
begin
  Result := GetValueAs<Int8>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsUInt16(Offset: Integer): UInt16;
begin
  Result := GetValueAs<UInt16>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsUInt32(Offset: Integer): UInt32;
begin
  Result := GetValueAs<UInt32>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsUInt64(Offset: Integer): UInt64;
begin
  Result := GetValueAs<UInt64>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsDouble(Offset: Integer = 0): Double;
begin
  Result := GetValueAs<Double>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsUInt8(Offset: Integer): UInt8;
begin
  Result := GetValueAs<UInt8>(Offset);
end;

function TBluetoothGattCharacteristic.GetValueAsInteger(Offset: Integer;
  AFormatType: TBluetoothGattFormatType): Integer;
begin
  case AFormatType of
    TBluetoothGattFormatType.Unsigned8bitInteger:
      Result := GetValueAsUInt8(Offset);

    TBluetoothGattFormatType.Unsigned16bitInteger:
      Result := GetValueAsUInt16(Offset);

    TBluetoothGattFormatType.Unsigned32bitInteger:
      Result := GetValueAsUInt32(Offset);

    TBluetoothGattFormatType.Signed8bitInteger:
      Result := GetValueAsInt8(Offset);

    TBluetoothGattFormatType.Signed16bitInteger:
      Result := GetValueAsInt16(Offset);

    TBluetoothGattFormatType.Signed32bitInteger:
      Result := GetValueAsInt32(Offset);
  else
    raise EBluetoothFormatException.CreateFmt(SBluetoothIntegerFormatType,
      [GetEnumName(TypeInfo(TBluetoothGattFormatType), Integer(AFormatType))]);
  end;
end;

function TBluetoothGattCharacteristic.GetValueAsSingle(Offset: Integer;
  AFormatType: TBluetoothGattFormatType): Single;
begin
  case AFormatType of
    TBluetoothGattFormatType.IEEE754_32bit_floating_point:
      Result := GetValueAs<Single>(Offset);
  else
    raise EBluetoothFormatException.CreateFmt(SBluetoothSingleFormatType,
      [GetEnumName(TypeInfo(TBluetoothGattFormatType), Integer(AFormatType))]);
  end;
end;

function TBluetoothGattCharacteristic.GetValueAsString(Offset: Integer; IsUTF8: Boolean): string;
var
  LLength: Integer;
  LBytes: TBytes;
begin
  LBytes := Value;
  LLength := Length(LBytes);
  if (LLength > 0) and (LBytes[LLEngth - 1] = 0) then
    Dec(LLength);
  if IsUTF8 then
    Result := TEncoding.UTF8.GetString(LBytes, Offset, LLength - Offset)
  else
    Result := TEncoding.Unicode.GetString(LBytes, Offset, LLength - Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsInt16(AValue: Int16; Offset: Integer);
begin
  SetValueAs<Int16>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsInt32(AValue: Int32; Offset: Integer);
begin
  SetValueAs<Int32>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsInt64(AValue: Int64; Offset: Integer);
begin
  SetValueAs<Int64>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsInt8(AValue: Int8; Offset: Integer);
begin
  SetValueAs<Int8>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsUInt16(AValue: UInt16; Offset: Integer);
begin
  SetValueAs<UInt16>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsUInt32(AValue: UInt32; Offset: Integer);
begin
  SetValueAs<UInt32>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsUInt64(AValue: UInt64; Offset: Integer);
begin
  SetValueAs<UInt64>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsDouble(AValue: Double; Offset: Integer = 0);
begin
  SetValueAs<Double>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsUInt8(AValue: UInt8; Offset: Integer);
begin
  SetValueAs<UInt8>(AValue, Offset);
end;

procedure TBluetoothGattCharacteristic.SetValueAsInteger(AValue: Integer; Offset: Integer;
  AFormatType: TBluetoothGattFormatType);
begin
  case AFormatType of
    TBluetoothGattFormatType.Unsigned8bitInteger:
      SetValueAs<UInt8>(AValue, Offset);

    TBluetoothGattFormatType.Unsigned16bitInteger:
      SetValueAs<UInt16>(AValue, Offset);

    TBluetoothGattFormatType.Unsigned32bitInteger:
      SetValueAs<UInt32>(AValue, Offset);

    TBluetoothGattFormatType.Signed8bitInteger:
      SetValueAs<Int8>(AValue, Offset);

    TBluetoothGattFormatType.Signed16bitInteger:
      SetValueAs<Int16>(AValue, Offset);

    TBluetoothGattFormatType.Signed32bitInteger:
      SetValueAs<Int32>(AValue, Offset);
  else
    raise EBluetoothFormatException.CreateFmt(SBluetoothIntegerFormatType,
      [GetEnumName(TypeInfo(TBluetoothGattFormatType), Integer(AFormatType))]);
  end;
end;

procedure TBluetoothGattCharacteristic.SetValueAsSingle(AValue: Single; Offset: Integer;
  AFormatType: TBluetoothGattFormatType);
begin
  case AFormatType of
    TBluetoothGattFormatType.IEEE754_32bit_floating_point:
      SetValueAs<Single>(AValue, Offset);
  else
    raise EBluetoothFormatException.CreateFmt(SBluetoothSingleFormatType,
      [GetEnumName(TypeInfo(TBluetoothGattFormatType), Integer(AFormatType))]);
  end;
end;

procedure TBluetoothGattCharacteristic.SetValueAsString(const AValue: string; IsUTF8: Boolean);
begin
  if IsUTF8 then
    Value := TEncoding.UTF8.GetBytes(AValue)
  else
    Value := TEncoding.Unicode.GetBytes(AValue);
end;

{ TBluetoothLEDevice }

constructor TBluetoothLEDevice.Create(AutoConnect: Boolean);
begin
  inherited Create;
  FAutoConnect := AutoConnect;
  FServices := TBluetoothGattServiceList.Create;
  FScannedAdvertiseData := DoCreateAdvertiseData;
end;

destructor TBluetoothLEDevice.Destroy;
begin
  FScannedAdvertiseData.Free;
  FServices.Free;
  if FAdvertisedData <> nil then
    FAdvertisedData.Free;
  inherited;
end;

procedure TBluetoothLEDevice.AbortReliableWrite;
begin
  DoAbortReliableWrite;
end;

function TBluetoothLEDevice.BeginReliableWrite: Boolean;
begin
  Result := DoBeginReliableWrite;
end;

function TBluetoothLEDevice.DiscoverServices: Boolean;
begin
  Result := DoDiscoverServices;
end;

procedure TBluetoothLEDevice.DoOnCharacteristicRead(const ACharacteristic: TBluetoothGattCharacteristic; AGattStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnCharacteristicRead) then
      FOnCharacteristicRead(Self, ACharacteristic, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnCharacteristicWrite(const ACharacteristic: TBluetoothGattCharacteristic; AGattStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnCharacteristicWrite) then
      FOnCharacteristicWrite(Self, ACharacteristic, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnDescriptorRead(const ADescriptor: TBluetoothGattDescriptor; AGattStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnDescriptorRead) then
      FOnDescriptorRead(Self, ADescriptor, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnDescriptorWrite(const ADescriptor: TBluetoothGattDescriptor; AGattStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnDescriptorWrite) then
      FOnDescriptorWrite(Self, ADescriptor, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnReadRssi(const Sender: TObject; ARssiValue: Integer; AGattStatus: TBluetoothGattStatus);
begin
  FLastRSSI := ARssiValue;
  try
    if Assigned(FOnReadRSSI) then
      FOnReadRSSI(Self, ARssiValue, AGattStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnReliableWriteCompleted(AStatus: TBluetoothGattStatus);
begin
  try
    if Assigned(FOnReliableWriteCompleted) then
      FOnReliableWriteCompleted(Self, AStatus);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

procedure TBluetoothLEDevice.DoOnServicesDiscovered(const Sender: TObject; const AServiceList: TBluetoothGattServiceList);
begin
  try
    if Assigned(FOnServicesDiscovered) then
      FOnServicesDiscovered(Self, AServiceList);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

function TBluetoothLEDevice.ExecuteReliableWrite: Boolean;
begin
  Result := DoExecuteReliableWrite;
end;

function TBluetoothLEDevice.GetDescription(const ACharacteristic: TBluetoothGattCharacteristic): string;
begin
                                              
  // Get the description value from the characteristic's descriptor.
  Result := '';
end;

function TBluetoothLEDevice.GetService(const AServiceID: TBluetoothUUID): TBluetoothGattService;
var
  LService: TBluetoothGattService;
begin
  Result := nil;
  for LService in FServices do
    if LService.UUID = AServiceID then
    begin
      Result := LService;
      Break;
    end;
end;

function TBluetoothLEDevice.ReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  Result := DoReadCharacteristic(ACharacteristic);
end;

function TBluetoothLEDevice.ReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := DoReadDescriptor(ADescriptor);
end;

function TBluetoothLEDevice.ReadRemoteRSSI: Boolean;
begin
  Result := DoReadRemoteRSSI;
end;

function TBluetoothLEDevice.SetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
  Enable: Boolean): Boolean;
const
  Desc_Configuration: TBluetoothUUID = '{00002902-0000-1000-8000-00805F9B34FB}';
var
  LDesc: TBluetoothGattDescriptor;
begin
  Result := False;
  if [TBluetoothProperty.Notify, TBluetoothProperty.Indicate] * ACharacteristic.GetProperties <> [] then
  begin
    // This is to ensure that we have read the descriptors before querying.
    ACharacteristic.Descriptors;
    // We check that we have the Configurarion descriptor, and then we set the notification accordingly.
    LDesc := ACharacteristic.GetDescriptor(Desc_Configuration);
    if LDesc <> nil then
      Result := DoSetCharacteristicNotification(ACharacteristic, Enable);
  end;
end;

function TBluetoothLEDevice.WriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  Result := DoWriteCharacteristic(ACharacteristic);
end;

function TBluetoothLEDevice.WriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := DoWriteDescriptor(ADescriptor);
end;

function TBluetoothLEDevice.Identifier: string;
begin
  Result := GetIdentifier;
end;
function TBluetoothLEDevice.IsConnected: Boolean;
begin
  Result := GetIsConnected;
end;

function TBluetoothLEDevice.Connect: Boolean;
begin
  Result := DoConnect;
end;

function TBluetoothLEDevice.Disconnect: Boolean;
begin
  Result := DoDisconnect;
end;

{ TBluetoothGattDescriptor }

constructor TBluetoothGattDescriptor.Create(const ACharacteristic: TBluetoothGattCharacteristic);
begin
  inherited Create;
  FCharacteristic := ACharacteristic;
end;

constructor TBluetoothGattDescriptor.Create(const ACharacteristic: TBluetoothGattCharacteristic; const AUUID: TBluetoothUUID);
begin
  inherited Create;
  FCharacteristic := ACharacteristic;
end;

destructor TBluetoothGattDescriptor.Destroy;
begin
  FCharacteristic := nil;
  inherited;
end;

function TBluetoothGattDescriptor.GetBroadcasts: Boolean;
begin
  if Kind <> TBluetoothDescriptorKind.ServerConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetBroadcasts;
end;

function TBluetoothGattDescriptor.GetCharacteristic: TBluetoothGattCharacteristic;
begin
  Result := FCharacteristic;
end;

function TBluetoothGattDescriptor.GetDescriptorKind: TBluetoothDescriptorKind;
begin
  case GetUUID.D1 of
    $2900:
      Result := TBluetoothDescriptorKind.ExtendedProperties;
    $2901:
      Result := TBluetoothDescriptorKind.UserDescription;
    $2902:
      Result := TBluetoothDescriptorKind.ClientConfiguration;
    $2903:
      Result := TBluetoothDescriptorKind.ServerConfiguration;
    $2904:
      Result := TBluetoothDescriptorKind.PresentationFormat;
    $2905:
      Result := TBluetoothDescriptorKind.AggregateFormat;
    $2906:
      Result := TBluetoothDescriptorKind.ValidRange;
    $2907:
      Result := TBluetoothDescriptorKind.ExternalReportReference;
    $2908:
      Result := TBluetoothDescriptorKind.ReportReference;
  else
    Result := TBluetoothDescriptorKind.Unknown;
  end;
end;

function TBluetoothGattDescriptor.GetExponent: ShortInt;
begin
  if Kind <> TBluetoothDescriptorKind.PresentationFormat then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetExponent;
end;

function TBluetoothGattDescriptor.GetFormat: TBluetoothGattFormatType;
begin
  if Kind <> TBluetoothDescriptorKind.PresentationFormat then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetFormat;
end;

function TBluetoothGattDescriptor.GetFormatUnit: TBluetoothUUID;
begin
  if Kind <> TBluetoothDescriptorKind.PresentationFormat then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetFormatUnit;
end;

function TBluetoothGattDescriptor.GetIndication: Boolean;
begin
  if Kind <> TBluetoothDescriptorKind.ClientConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetIndication;
end;

class function TBluetoothGattDescriptor.GetKnownUnitName(const AnUnit: TBluetoothUUID): string;
type
  TUnitNames = array [0..110] of TBluetoothService;
const
  UnitNames: TUnitNames = (
    (Name: 'unitless'; UUID: '{00002700-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (metre)'; UUID: '{00002701-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass (kilogram)'; UUID: '{00002702-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (second)'; UUID: '{00002703-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric current (ampere)'; UUID: '{00002704-0000-1000-8000-00805F9B34FB}'),
    (Name: 'thermodynamic temperature (kelvin)'; UUID: '{00002705-0000-1000-8000-00805F9B34FB}'),
    (Name: 'amount of substance (mole)'; UUID: '{00002706-0000-1000-8000-00805F9B34FB}'),
    (Name: 'luminous intensity (candela)'; UUID: '{00002707-0000-1000-8000-00805F9B34FB}'),
    (Name: 'area (square metres)'; UUID: '{00002710-0000-1000-8000-00805F9B34FB}'),
    (Name: 'volume (cubic metres)'; UUID: '{00002711-0000-1000-8000-00805F9B34FB}'),
    (Name: 'velocity (metres per second)'; UUID: '{00002712-0000-1000-8000-00805F9B34FB}'),
    (Name: 'acceleration (metres per second squared)'; UUID: '{00002713-0000-1000-8000-00805F9B34FB}'),
    (Name: 'wavenumber (reciprocal metre)'; UUID: '{00002714-0000-1000-8000-00805F9B34FB}'),
    (Name: 'density (kilogram per cubic metre)'; UUID: '{00002715-0000-1000-8000-00805F9B34FB}'),
    (Name: 'surface density (kilogram per square metre)'; UUID: '{00002716-0000-1000-8000-00805F9B34FB}'),
    (Name: 'specific volume (cubic metre per kilogram)'; UUID: '{00002717-0000-1000-8000-00805F9B34FB}'),
    (Name: 'current density (ampere per square metre)'; UUID: '{00002718-0000-1000-8000-00805F9B34FB}'),
    (Name: 'magnetic field strength (ampere per metre)'; UUID: '{00002719-0000-1000-8000-00805F9B34FB}'),
    (Name: 'amount concentration (mole per cubic metre)'; UUID: '{0000271A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass concentration (kilogram per cubic metre)'; UUID: '{0000271B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'luminance (candela per square metre)'; UUID: '{0000271C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'refractive index'; UUID: '{0000271D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'relative permeability'; UUID: '{0000271E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'plane angle (radian)'; UUID: '{00002720-0000-1000-8000-00805F9B34FB}'),
    (Name: 'solid angle (steradian)'; UUID: '{00002721-0000-1000-8000-00805F9B34FB}'),
    (Name: 'frequency (hertz)'; UUID: '{00002722-0000-1000-8000-00805F9B34FB}'),
    (Name: 'force (newton)'; UUID: '{00002723-0000-1000-8000-00805F9B34FB}'),
    (Name: 'pressure (pascal)'; UUID: '{00002724-0000-1000-8000-00805F9B34FB}'),
    (Name: 'energy (joule)'; UUID: '{00002725-0000-1000-8000-00805F9B34FB}'),
    (Name: 'power (watt)'; UUID: '{00002726-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric charge (coulomb)'; UUID: '{00002727-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric potential difference (volt)'; UUID: '{00002728-0000-1000-8000-00805F9B34FB}'),
    (Name: 'capacitance (farad)'; UUID: '{00002729-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric resistance (ohm)'; UUID: '{0000272A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric conductance (siemens)'; UUID: '{0000272B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'magnetic flux (weber)'; UUID: '{0000272C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'magnetic flux density (tesla)'; UUID: '{0000272D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'inductance (henry)'; UUID: '{0000272E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'Celsius temperature (degree Celsius)'; UUID: '{0000272F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'luminous flux (lumen)'; UUID: '{00002730-0000-1000-8000-00805F9B34FB}'),
    (Name: 'illuminance (lux)'; UUID: '{00002731-0000-1000-8000-00805F9B34FB}'),
    (Name: 'activity referred to a radionuclide (becquerel)'; UUID: '{00002732-0000-1000-8000-00805F9B34FB}'),
    (Name: 'absorbed dose (gray)'; UUID: '{00002733-0000-1000-8000-00805F9B34FB}'),
    (Name: 'dose equivalent (sievert)'; UUID: '{00002734-0000-1000-8000-00805F9B34FB}'),
    (Name: 'catalytic activity (katal)'; UUID: '{00002735-0000-1000-8000-00805F9B34FB}'),
    (Name: 'dynamic viscosity (pascal second)'; UUID: '{00002740-0000-1000-8000-00805F9B34FB}'),
    (Name: 'moment of force (newton metre)'; UUID: '{00002741-0000-1000-8000-00805F9B34FB}'),
    (Name: 'surface tension (newton per metre)'; UUID: '{00002742-0000-1000-8000-00805F9B34FB}'),
    (Name: 'angular velocity (radian per second)'; UUID: '{00002743-0000-1000-8000-00805F9B34FB}'),
    (Name: 'angular acceleration (radian per second squared)'; UUID: '{00002744-0000-1000-8000-00805F9B34FB}'),
    (Name: 'heat flux density (watt per square metre)'; UUID: '{00002745-0000-1000-8000-00805F9B34FB}'),
    (Name: 'heat capacity (joule per kelvin)'; UUID: '{00002746-0000-1000-8000-00805F9B34FB}'),
    (Name: 'specific heat capacity (joule per kilogram kelvin)'; UUID: '{00002747-0000-1000-8000-00805F9B34FB}'),
    (Name: 'specific energy (joule per kilogram)'; UUID: '{00002748-0000-1000-8000-00805F9B34FB}'),
    (Name: 'thermal conductivity (watt per metre kelvin)'; UUID: '{00002749-0000-1000-8000-00805F9B34FB}'),
    (Name: 'energy density (joule per cubic metre)'; UUID: '{0000274A-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric field strength (volt per metre)'; UUID: '{0000274B-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric charge density (coulomb per cubic metre)'; UUID: '{0000274C-0000-1000-8000-00805F9B34FB}'),
    (Name: 'surface charge density (coulomb per square metre)'; UUID: '{0000274D-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric flux density (coulomb per square metre)'; UUID: '{0000274E-0000-1000-8000-00805F9B34FB}'),
    (Name: 'permittivity (farad per metre)'; UUID: '{0000274F-0000-1000-8000-00805F9B34FB}'),
    (Name: 'permeability (henry per metre)'; UUID: '{00002750-0000-1000-8000-00805F9B34FB}'),
    (Name: 'molar energy (joule per mole)'; UUID: '{00002751-0000-1000-8000-00805F9B34FB}'),
    (Name: 'molar entropy (joule per mole kelvin)'; UUID: '{00002752-0000-1000-8000-00805F9B34FB}'),
    (Name: 'exposure (coulomb per kilogram)'; UUID: '{00002753-0000-1000-8000-00805F9B34FB}'),
    (Name: 'absorbed dose rate (gray per second)'; UUID: '{00002754-0000-1000-8000-00805F9B34FB}'),
    (Name: 'radiant intensity (watt per steradian)'; UUID: '{00002755-0000-1000-8000-00805F9B34FB}'),
    (Name: 'radiance (watt per square metre steradian)'; UUID: '{00002756-0000-1000-8000-00805F9B34FB}'),
    (Name: 'catalytic activity concentration (katal per cubic metre)'; UUID: '{00002757-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (minute)'; UUID: '{00002760-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (hour)'; UUID: '{00002761-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (day)'; UUID: '{00002762-0000-1000-8000-00805F9B34FB}'),
    (Name: 'plane angle (degree)'; UUID: '{00002763-0000-1000-8000-00805F9B34FB}'),
    (Name: 'plane angle (minute)'; UUID: '{00002764-0000-1000-8000-00805F9B34FB}'),
    (Name: 'plane angle (second)'; UUID: '{00002765-0000-1000-8000-00805F9B34FB}'),
    (Name: 'area (hectare)'; UUID: '{00002766-0000-1000-8000-00805F9B34FB}'),
    (Name: 'volume (litre)'; UUID: '{00002767-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass (tonne)'; UUID: '{00002768-0000-1000-8000-00805F9B34FB}'),
    (Name: 'pressure (bar)'; UUID: '{00002780-0000-1000-8000-00805F9B34FB}'),
    (Name: 'pressure (millimetre of mercury)'; UUID: '{00002781-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (ångström)'; UUID: '{00002782-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (nautical mile)'; UUID: '{00002783-0000-1000-8000-00805F9B34FB}'),
    (Name: 'area (barn)'; UUID: '{00002784-0000-1000-8000-00805F9B34FB}'),
    (Name: 'velocity (knot)'; UUID: '{00002785-0000-1000-8000-00805F9B34FB}'),
    (Name: 'logarithmic radio quantity (neper)'; UUID: '{00002786-0000-1000-8000-00805F9B34FB}'),
    (Name: 'logarithmic radio quantity (bel)'; UUID: '{00002787-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (yard)'; UUID: '{000027A0-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (parsec)'; UUID: '{000027A1-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (inch)'; UUID: '{000027A2-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (foot)'; UUID: '{000027A3-0000-1000-8000-00805F9B34FB}'),
    (Name: 'length (mile)'; UUID: '{000027A4-0000-1000-8000-00805F9B34FB}'),
    (Name: 'pressure (pound-force per square inch)'; UUID: '{000027A5-0000-1000-8000-00805F9B34FB}'),
    (Name: 'velocity (kilometre per hour)'; UUID: '{000027A6-0000-1000-8000-00805F9B34FB}'),
    (Name: 'velocity (mile per hour)'; UUID: '{000027A7-0000-1000-8000-00805F9B34FB}'),
    (Name: 'angular velocity (revolution per minute)'; UUID: '{000027A8-0000-1000-8000-00805F9B34FB}'),
    (Name: 'energy (gram calorie)'; UUID: '{000027A9-0000-1000-8000-00805F9B34FB}'),
    (Name: 'energy (kilogram calorie)'; UUID: '{000027AA-0000-1000-8000-00805F9B34FB}'),
    (Name: 'energy (kilowatt hour)'; UUID: '{000027AB-0000-1000-8000-00805F9B34FB}'),
    (Name: 'thermodynamic temperature (degree Fahrenheit)'; UUID: '{000027AC-0000-1000-8000-00805F9B34FB}'),
    (Name: 'percentage'; UUID: '{000027AD-0000-1000-8000-00805F9B34FB}'),
    (Name: 'per mille'; UUID: '{000027AE-0000-1000-8000-00805F9B34FB}'),
    (Name: 'period (beats per minute)'; UUID: '{000027AF-0000-1000-8000-00805F9B34FB}'),
    (Name: 'electric charge (ampere hours)'; UUID: '{000027B0-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass density (milligram per decilitre)'; UUID: '{000027B1-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass density (millimole per litre)'; UUID: '{000027B2-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (year)'; UUID: '{000027B3-0000-1000-8000-00805F9B34FB}'),
    (Name: 'time (month)'; UUID: '{000027B4-0000-1000-8000-00805F9B34FB}'),
    (Name: 'concentration (count per cubic metre)'; UUID: '{000027B5-0000-1000-8000-00805F9B34FB}'),
    (Name: 'irradiance (watt per square metre)'; UUID: '{000027B6-0000-1000-8000-00805F9B34FB}'),
    (Name: 'milliliter (per kilogram per minute)'; UUID: '{000027B7-0000-1000-8000-00805F9B34FB}'),
    (Name: 'mass (pound)'; UUID: '{000027B8-0000-1000-8000-00805F9B34FB}')
  );
var
  I: Integer;
begin
  Result := '';
  for I := Low(UnitNames) to High(UnitNames) do
    if UnitNames[I].UUID = AnUnit then
      Exit(UnitNames[I].Name);
end;

function TBluetoothGattDescriptor.GetNotification: Boolean;
begin
  if Kind <> TBluetoothDescriptorKind.ClientConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetNotification;
end;

function TBluetoothGattDescriptor.GetReliableWrite: Boolean;
begin
  if Kind <> TBluetoothDescriptorKind.ExtendedProperties then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetReliableWrite;
end;

function TBluetoothGattDescriptor.GetUserDescription: string;
begin
  if Kind <> TBluetoothDescriptorKind.UserDescription then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetUserDescription;
end;

function TBluetoothGattDescriptor.GetUUIDName: string;
begin
  Result := TBluetoothLEManager.GetKnownServiceName(GetUUID);
end;

function TBluetoothGattDescriptor.GetValue: TBytes;
begin
  Result := DoGetValue;
end;

function TBluetoothGattDescriptor.GetWritableAuxiliaries: Boolean;
begin
  if Kind <> TBluetoothDescriptorKind.ExtendedProperties then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  Result := DoGetWritableAuxiliaries;
end;

procedure TBluetoothGattDescriptor.SetBroadcasts(const AValue: Boolean);
begin
  if Kind <> TBluetoothDescriptorKind.ServerConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  DoSetBroadcasts(AValue);
end;

procedure TBluetoothGattDescriptor.SetIndication(const AValue: Boolean);
begin
  if Kind <> TBluetoothDescriptorKind.ClientConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  DoSetIndication(AValue);
end;

procedure TBluetoothGattDescriptor.SetNotification(const AValue: Boolean);
begin
  if Kind <> TBluetoothDescriptorKind.ClientConfiguration then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  DoSetNotification(AValue);
end;

procedure TBluetoothGattDescriptor.SetUserDescription(const AValue: string);
begin
  if Kind <> TBluetoothDescriptorKind.UserDescription then
    raise EBluetoothLEDescriptorException.CreateFmt(SBluetoothOperationNotSupported,
      [GetEnumName(TypeInfo(TBluetoothDescriptorKind), Ord(Kind))]);

  DoSetUserDescription(AValue);
end;

procedure TBluetoothGattDescriptor.SetValue(const AValue: TBytes);
begin
  DoSetValue(AValue);
end;

{ TBluetoothLEAdvertiseData }
procedure TBluetoothLEAdvertiseData.AddServiceData(const AServiceUUID: TBluetoothUUID; const AData: TBytes);
begin
  if DoAddServiceData(AServiceUUID, AData) then
    FServiceData.AddOrSetValue(AServiceUUID, AData);
end;

procedure TBluetoothLEAdvertiseData.RemoveServiceData(const AServiceUUID: TBluetoothUUID);
begin
  DoRemoveServiceData(AServiceUUID);
  FServiceData.Remove(AServiceUUID);
end;

procedure TBluetoothLEAdvertiseData.ClearServiceData;
begin
  DoClearServiceData;
  FServiceData.Clear;
end;

procedure TBluetoothLEAdvertiseData.AddServiceUUID(const AServiceUUID: TBluetoothUUID);
begin
  if not FServiceUUIDs.Contains(AServiceUUID) then
  begin
    if DoAddServiceUUID(AServiceUUID) then
      FServiceUUIDs.Add(AServiceUUID);
  end;
end;

procedure TBluetoothLEAdvertiseData.RemoveServiceUUID(const AServiceUUID: TBluetoothUUID);
begin
  DoRemoveServiceUUID(AServiceUUID);
  FServiceUUIDs.Remove(AServiceUUID);
end;

procedure TBluetoothLEAdvertiseData.ClearServiceUUIDs;
begin
  DoClearServiceUUIDs;
  FServiceUUIDs.Clear
end;

constructor TBluetoothLEAdvertiseData.Create;
begin
  inherited;
  FServiceUUIDs := TBluetoothUUIDsList.Create;
  FServiceData := TBluetoothLEServiceData.Create;
end;

destructor TBluetoothLEAdvertiseData.Destroy;
begin
  FServiceUUIDs.Free;
  FServiceData.Free;
  inherited;
end;

{$ENDIF BLUETOOTH_LE}

{ TServiceDataRawData }

constructor TServiceDataRawData.create(const AKey: TBluetoothUUID; const AValue: TBytes);
begin
  Key := AKey;
  Value := AValue;
end;

constructor TServiceDataRawData.create(const AServiceData: TPair<TBluetoothUUID,TBytes>);
begin
  Key := AServiceData.Key;
  Value := AServiceData.Value;
end;

{ TBluetoothUUIDHelper }

class function TBluetoothUUIDHelper.GetBluetooth16bitsUUID(const AUUID: TBluetoothUUID): TBluetooth16bitsUUID;
begin
  if IsBluetoothBaseUUIDBased(AUUID) then
    Result := LongRec(AUUID.D1).Lo
  else
    Result := 0;
end;

class function TBluetoothUUIDHelper.GetBluetoothUUID(const A16bitsUUID: TBluetooth16bitsUUID): TBluetoothUUID;
begin
  Result := BLUETOOTH_BASE_UUID;
  Result.D1 := A16bitsUUID;
end;

class function TBluetoothUUIDHelper.IsBluetoothBaseUUIDBased(const AUUID: TBluetoothUUID): Boolean;
begin
  Result := (AUUID.D2 = BLUETOOTH_BASE_UUID.D2) and (AUUID.D3 = BLUETOOTH_BASE_UUID.D3) and
    CompareMem(@AUUID.D4, @BLUETOOTH_BASE_UUID.D4, Length(AUUID.D4));
end;

{ TBluetoothLEScanFilter }

procedure TBluetoothLEScanFilter.SetManufacturerSpecificData(const AManufacturerSpecificData: TBytes);
begin                                        
  FManufacturerSpecificData := AManufacturerSpecificData;
end;

procedure TBluetoothLEScanFilter.SetManufacturerSpecificDataMask(const AManufacturerSpecificDataMask: TBytes);
begin                                        
  FManufacturerSpecificDataMask := AManufacturerSpecificDataMask;
end;

procedure TBluetoothLEScanFilter.SetServiceData(const AServiceData: TServiceDataRawData);
begin                                        
  FServiceData := AServiceData;
end;

procedure TBluetoothLEScanFilter.SetServiceDataMask(const AServiceDataMask: TBytes);
begin                                        
  FServiceDataMask := AServiceDataMask;
end;

constructor TBluetoothLEScanFilter.Create;
begin
  inherited;
  FLocalName := '';
  FDeviceAddress := '';
  FServiceUUID := TGUID.Empty;
  FServiceUUIDMask := TGUID.Empty;
  FServiceData.Key := TGUID.Empty;
end;

end.
