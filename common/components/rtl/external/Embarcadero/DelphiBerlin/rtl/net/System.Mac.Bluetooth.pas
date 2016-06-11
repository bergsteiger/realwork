{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Mac.Bluetooth;

interface

uses
  System.SysUtils, System.Bluetooth;

{$IF not defined(IOS)}
{$DEFINE BLUETOOTH_CLASSIC}
{$ENDIF !IOS}

{$DEFINE BLUETOOTH_LE}

type
{$IFDEF BLUETOOTH_CLASSIC}
  TPlatformBluetoothClassicManager = class(TBluetoothManager)
  protected
    class function GetBluetoothManager: TBluetoothManager; override;
  end;
{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
  TPlatformBluetoothLEManager = class(TBluetoothLEManager)
  protected
    class function GetBluetoothManager: TBluetoothLEManager; override;
  end;
{$ENDIF BLUETOOTH_LE}

implementation

uses
  System.Classes, System.SyncObjs, Macapi.ObjectiveC, Macapi.ObjCRuntime, Macapi.Helpers, System.Types,
  Macapi.Bluetooth, System.NetConsts, System.Generics.Defaults, System.Generics.Collections, Macapi.CoreFoundation,
{$IFDEF IOS}
  iOSapi.Foundation,
  iOSapi.CocoaTypes,
{$ELSE}
  Macapi.Foundation,
  Macapi.CocoaTypes,
{$ENDIF}
  System.TypInfo;

type
{$IF defined(BLUETOOTH_CLASSIC)}
  TInquiryCompleteEvent = procedure(Sender: TObject; Error: UInt32; Aborted: Boolean) of object;
  TDeviceFoundEvent = procedure(Sender: TObject; ADevice: IOBluetoothDevice) of object;
  TInquiryStartedEvent = procedure(Sender: TObject) of object;
  TDeviceNameUpdatedEvent = procedure(Sender: TObject; ADevice: IOBluetoothDevice; DevicesRemaining: UInt32) of object;

  TBluetoothDeviceInquiry = class(TOCLocal, IOBluetoothDeviceInquiryDelegate)
  private
    FInquirer: IOBluetoothDeviceInquiry;
    FOnInquiryComplete: TInquiryCompleteEvent;
    FOnDeviceFound: TDeviceFoundEvent;
    FOnInquiryStarted: TInquiryStartedEvent;
    FOnDeviceNameUpdated: TDeviceNameUpdatedEvent;
    FCanceled: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function FoundDevices: NSArray;
    // IOBluetoothDeviceInquiryDelegate
    procedure deviceInquiryComplete(sender: IOBluetoothDeviceInquiry; error: UInt32; aborted: Boolean); cdecl;
    procedure deviceInquiryDeviceFound(sender: IOBluetoothDeviceInquiry; device: IOBluetoothDevice); cdecl;
    procedure deviceInquiryDeviceNameUpdated(sender: IOBluetoothDeviceInquiry; device: IOBluetoothDevice; devicesRemaining: UInt32); cdecl;
    procedure deviceInquiryStarted(sender: IOBluetoothDeviceInquiry); cdecl;
    procedure deviceInquiryUpdatingDeviceNamesStarted(sender: IOBluetoothDeviceInquiry; devicesRemaining: UInt32); cdecl;
    // End IOBluetoothDeviceInquiryDelegate
    procedure StartDiscovery;
    procedure CancelDiscovery;
    property OnInquiryComplete: TInquiryCompleteEvent read FOnInquiryComplete write FOnInquiryComplete;
    property OnDeviceFound: TDeviceFoundEvent read FOnDeviceFound write FOnDeviceFound;
    property OnInquiryStarted: TInquiryStartedEvent read FOnInquiryStarted write FOnInquiryStarted;
    property OnDeviceNameUpdated: TDeviceNameUpdatedEvent read FOnDeviceNameUpdated write FOnDeviceNameUpdated;
  end;

  TDevicePairingStartedEvent = procedure(Sender: TObject) of object;
  TDevicePairingConnectingEvent = procedure(Sender: TObject) of object;
  TDevicePairingFinishedEvent = procedure(Sender: TObject; Error: UInt32) of object;
  TPINCodeRequestEvent = procedure(Sender: TObject) of object;
  TDevicePairingConfirmationRequestEvent = procedure(Sender: TObject; NumericValue: UInt32; var Reply: Boolean) of object;

  TBluetoothDevicePair = class(TOCLocal, IOBluetoothDevicePairDelegate)
  private
    FBluetoothPair: IOBluetoothDevicePair;
    FOnDevicePairingStarted: TDevicePairingStartedEvent;
    FOnDevicePairingConnecting: TDevicePairingConnectingEvent;
    FOnDevicePairingFinished: TDevicePairingFinishedEvent;
    FOnPINCodeRequest: TPINCodeRequestEvent;
    FOnDevicePairingConfirmationRequest: TDevicePairingConfirmationRequestEvent;
  public
    constructor Create;
    destructor Destroy; override;
    // IOBluetoothDevicePairDelegate
    procedure devicePairingStarted(sender: id); cdecl;
    procedure devicePairingConnecting(sender: id); cdecl;
    procedure devicePairingPINCodeRequest(sender: id); cdecl;
    procedure devicePairingUserConfirmationRequest(sender: id; numericValue: BluetoothNumericValue); cdecl;
    procedure devicePairingUserPasskeyNotification(sender: id; passkey: BluetoothPasskey); cdecl;
    procedure devicePairingFinished(sender: id; error: IOReturn); cdecl;
    procedure deviceSimplePairingFinished(sender: id; status: BluetoothHCIEventStatus); cdecl;
    // End IOBluetoothDevicePairDelegate
    function PairWith(ADevice: IOBluetoothDevice): Boolean;
    function CancelPairing: Boolean;

    property OnDevicePairingStarted: TDevicePairingStartedEvent read FOnDevicePairingStarted write FOnDevicePairingStarted;
    property OnDevicePairingConnecting: TDevicePairingConnectingEvent read FOnDevicePairingConnecting write FOnDevicePairingConnecting;
    property OnDevicePairingFinished: TDevicePairingFinishedEvent read FOnDevicePairingFinished write FOnDevicePairingFinished;
    property OnPINCodeRequest: TPINCodeRequestEvent read FOnPINCodeRequest write FOnPINCodeRequest;
    property OnConfirmationRequestEvent: TDevicePairingConfirmationRequestEvent read FOnDevicePairingConfirmationRequest
      write FOnDevicePairingConfirmationRequest;
  end;

  IQuerySDPDelegate = interface(IObjectiveC)
  ['{99985112-1B9E-42F0-8748-BE10993FC671}']
    procedure sdpQueryComplete(device: IOBluetoothDevice; status: IOReturn); cdecl;
  end;

  TBluetoothDeviceNotifier = class(TOCLocal, IQuerySDPDelegate)
  private
    FDone: Boolean;
  public
    procedure sdpQueryComplete(device: IOBluetoothDevice; status: IOReturn); cdecl;
    property Done: Boolean read FDone write FDone;
  end;

  TMacBluetoothSocket = class;
  TMacBluetoothSocketList = TList<TMacBluetoothSocket>;

  TBluetoothRFCOMMOpenChannelDelegate = class(TOCLocal, IBluetoothRFCOMMOpenChannelDelegate)
  private
    FIncomingList: TList<TMacBluetoothSocket>;
    FChannelID: BluetoothRFCOMMChannelID;
    FNotifierID: IOBluetoothUserNotification;
    FDone: Boolean;
    FAccepting: Boolean;
  public
    procedure newRFCOMMChannelOpened(inNotification: Pointer; newChannel: Pointer); cdecl;
    constructor Create(AChannelID: BluetoothRFCOMMChannelID; const AList: TMacBluetoothSocketList);
    destructor Destroy; override;
    property Done: Boolean read FDone write FDone;
    property Accepting: Boolean read FAccepting write FAccepting;
  end;

  TBluetoothData = record
    Data: TBytes;
    Channel: Pointer;
  end;
  TBluetoothDataList = TList<TBluetoothData>;

  TBluetoothRFCOMMChannelDelegate = class(TOCLocal, IBluetoothRFCOMMChannelDelegate)
  private
    FDataList: TBluetoothDataList;
    FRFChannelOpenComplete: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure rfcommChannelData(rfcommChannel: Pointer{IOBluetoothRFCOMMChannel}; data: Pointer; length: UInt32); cdecl;
    procedure rfcommChannelOpenComplete(rfcommChannel: Pointer; status: IOReturn); cdecl;
    procedure rfcommChannelClosed(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelControlSignalsChanged(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelFlowControlChanged(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelWriteComplete(rfcommChannel: Pointer; refcon: Pointer; status: IOReturn); cdecl;
    procedure rfcommChannelQueueSpaceAvailable(rfcommChannel: Pointer); cdecl;
    property RFChannelOpenComplete: Boolean read FRFChannelOpenComplete write FRFChannelOpenComplete;
  end;

  TMacBluetoothSocket = class(TBluetoothSocket)
  private
    const
      ConnectTimeout: Cardinal = 5;
  private
    FDestroying: Boolean;
  protected
    FRFCOMMChannel: IOBluetoothRFCOMMChannel;
    FServiceRecord: IOBluetoothSDPServiceRecord;
    FDelegate: TBluetoothRFCOMMChannelDelegate;
    FDevice: IOBluetoothDevice;
    function GetConnected: Boolean; override;
    function GetRemoteDevice: TBluetoothDevice;
    procedure DoClose; override;
    procedure DoConnect; override;
    function DoReceiveData(ATimeout: Cardinal): TBytes; override;
    procedure DoSendData(const AData: TBytes); override;
  public
    constructor Create(const AChannel: IOBluetoothRFCOMMChannel); overload;
    constructor Create(const ADevice: IOBluetoothDevice; const AServiceRecord: IOBluetoothSDPServiceRecord); overload;
    destructor Destroy; override;
  end;

  TMacBluetoothServerSocket = class(TBluetoothServerSocket)
  private
    FServiceRecord: IOBluetoothSDPServiceRecord;
    FOpenChannelNotifier: TBluetoothRFCOMMOpenChannelDelegate;
    FServiceName: string;
    FServiceUUID: TGUID;
    FChannelID: BluetoothRFCOMMChannelID;
    FIncomingList: TList<TMacBluetoothSocket>;
    FDestroying: Boolean;
    procedure InitServer;
    procedure StopServer;
    function CreateSDPServiceRecord(const AName: string; const AUUID: TGUID): IOBluetoothSDPServiceRecord;
  protected
    function DoAccept(Timeout: Cardinal): TBluetoothSocket; override;
    procedure DoClose; override;
  public
    constructor Create(const AName: string; const AUUID: TGUID);
    destructor Destroy; override;
  end;

  TMacBluetoothManager = class(TPlatformBluetoothClassicManager)
  private
    FAdapter: TBluetoothAdapter;
  protected
    function DoGetClassicAdapter: TBluetoothAdapter; override;
    function GetConnectionState: TBluetoothConnectionState; override;
    function DoEnableBluetooth: Boolean; override;
  end;

  TMacBluetoothAdapter = class(TBluetoothAdapter)
  private
    FAdapter: IOBluetoothHostController;
    FDevicePair: TBluetoothDevicePair;
    FDeviceDiscover: TBluetoothDeviceInquiry;
    FPairedDevices: TBluetoothDeviceList;
    FDiscoveredDevices: TBluetoothDeviceList;
    procedure InternalInquiryComplete(sender: TObject; error: UInt32; aborted: Boolean);
    function DoCreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket; override;
  protected
    function GetAdapterName: string; override;
    procedure SetAdapterName(const Value: string); override;
    function GetAddress: TBluetoothMacAddress; override;
    function GetPairedDevices: TBluetoothDeviceList; override;
    function GetScanMode: TBluetoothScanMode; override;
    function GetState: TBluetoothAdapterState; override;
    procedure DoStartDiscovery(Timeout: Cardinal); override;
    procedure DoCancelDiscovery; override;
    procedure DoStartDiscoverable(Timeout: Cardinal); override;
    function DoPair(const ADevice: TBluetoothDevice): Boolean; override;
    function DoUnPair(const ADevice: TBluetoothDevice): Boolean; override;
  public
    constructor Create(const AManager: TBluetoothManager; const AnAdapter: IOBluetoothHostController);
    destructor Destroy; override;
  end;

  TMacBluetoothDevice = class(TBluetoothDevice)
  const
    SDPTimeout = 4;
    ConnectTimeout = 5500;
  private
    FDevice: IOBluetoothDevice;
    FNotifier: TBluetoothDeviceNotifier;
  protected
    function GetAddress: TBluetoothMacAddress; override;
    function GetBluetoothType: TBluetoothType; override;
    function GetDeviceName: string; override;
    function GetPaired: Boolean; override;
    function GetState: TBluetoothDeviceState; override;
    function GetClassDevice: Integer; override;
    function GetClassDeviceMajor: Integer; override;
    function DoGetServices: TBluetoothServiceList; override;
    // Socket Management functions.
    function DoCreateClientSocket(const AUUID: TGUID; CreateSecure: Boolean): TBluetoothSocket; override;
  public
    constructor Create(const ABluetoothDevice: IOBluetoothDevice);
    destructor Destroy; override;
  end;
{$ENDIF !BLUETOOTH_CLASSIC}

{$IF defined(BLUETOOTH_LE)}
  TInternalBluetoothLEManager = class;

  TMacBluetoothLEManager = class(TPlatformBluetoothLEManager)
  private
    FAdapter: TBluetoothLEAdapter;
    function GetDeviceIdentifier(const ADevice: CBPeripheral): TGUID;
  protected
    function DoGetAdapter: TBluetoothLEAdapter; override;
    function GetConnectionState: TBluetoothConnectionState; override;
    procedure AddDiscoveredDevice(const ADevice: TBluetoothLEDevice);
    function DoGetGattServer: TBluetoothGattServer; override;
    function DoGetSupportsGattClient: Boolean; override;
    function DoGetSupportsGattServer: Boolean; override;
    function DoEnableBluetooth: Boolean; override;
  end;

  TMacBluetoothLEAdapter = class(TBluetoothLEAdapter)
  private
    FLEManager: TInternalBluetoothLEManager;
    FManager: TBluetoothLEManager;
    FBluetoothLEScanFilterList: TBluetoothLEScanFilterList;
    procedure DeviceDiscovered(Sender: TObject; const ADevice: CBPeripheral; const AData: NSDictionary; RSSI: Integer);
    procedure DeviceConnect(Sender: TObject; const ADevice: CBPeripheral);
    procedure DeviceDisconnect(Sender: TObject; const ADevice: CBPeripheral);
    procedure DeviceDiscoveryTimeout(Sender: TObject);
    function GetLEDevice(const ADevice: CBPeripheral): TBluetoothLEDevice;
  protected
    function GetAdapterName: string; override;
    procedure SetAdapterName(const Value: string); override;
    function GetAddress: TBluetoothMacAddress; override;
    function GetScanMode: TBluetoothScanMode; override;
    function GetState: TBluetoothAdapterState; override;
    function DoStartDiscovery(ATimeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil;
      const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil): Boolean; override;
    function DoStartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil; Refresh: Boolean = True): Boolean; override;
    procedure DoCancelDiscovery; override;
  public
    constructor Create(const AManager: TBluetoothLEManager);
    destructor Destroy; override;
  end;

  InternalTimer = interface(NSObject)
  ['{5972C643-A9BB-4E7E-8B8F-33D140AC5AD2}']
    procedure timerEvent; cdecl;
  end;

  TInternalTimer = class(TOCLocal)
  private
    FTimer: NSTimer;
    FEvent: TNotifyEvent;
  public
    procedure SetNotifyEvent(AnEvent: TNotifyEvent);
    function GetObjectiveCClass: PTypeInfo; override;
    procedure timerEvent; cdecl;
  end;

  TDeviceDiscoveredEvent = procedure(Sender: TObject; const ADevice: CBPeripheral; const AData: NSDictionary; RSSI: Integer) of object;
  TDeviceConnectionChangeEvent = procedure(Sender: TObject; const ADevice: CBPeripheral) of object;

  TInternalBluetoothLEManager = class(TOCLocal, CBCentralManagerDelegate)
  private
    FCentralManager: CBCentralManager;
    FOnDeviceDiscovered: TDeviceDiscoveredEvent;
    FWaitingToDiscover: Boolean;
    FIsDiscovering: Boolean;
    FTimer: TInternalTimer;
    FConnected: Boolean;
    FOnDeviceDiscoveryTimeout: TNotifyEvent;
    FLastError: Integer;
    FFilterUUIDList: NSMutableArray;
    FScanOptions: NSMutableDictionary;
    FOnDeviceConnect: TDeviceConnectionChangeEvent;
    FOnDeviceDisconnect: TDeviceConnectionChangeEvent;
    procedure CreateTimer(Interval: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure centralManagerDidUpdateState(central: CBCentralManager); cdecl;
    [MethodName('centralManager:willRestoreState:')]
    procedure centralManagerWillRestoreState(central: CBCentralManager; dict: NSDictionary); cdecl;
    [MethodName('centralManager:didRetrievePeripherals:')]
    procedure centralManagerDidRetrievePeripherals(central: CBCentralManager; peripherals: NSArray); cdecl;
    [MethodName('centralManager:didRetrieveConnectedPeripherals:')]
    procedure centralManagerDidRetrieveConnectedPeripherals(central: CBCentralManager; peripherals: NSArray); cdecl;
    [MethodName('centralManager:didDiscoverPeripheral:advertisementData:RSSI:')]
    procedure centralManagerDidDiscoverPeripheral(central: CBCentralManager; peripheral: CBPeripheral;
      advertisementData: NSDictionary; RSSI: NSNumber); cdecl;
    [MethodName('centralManager:didConnectPeripheral:')]
    procedure centralManagerDidConnectPeripheral(central: CBCentralManager; peripheral: CBPeripheral); cdecl;
    [MethodName('centralManager:didFailToConnectPeripheral:error:')]
    procedure centralManagerDidFailToConnectPeripheral(central: CBCentralManager; peripheral: CBPeripheral; error: NSError); cdecl;
    [MethodName('centralManager:didDisconnectPeripheral:error:')]
    procedure centralManagerdidDisconnectPeripheral(central: CBCentralManager; peripheral: CBPeripheral; error: NSError); cdecl;
    procedure StartDiscovery(Timeout: Cardinal; const FilterUUIDList: TBluetoothUUIDsList = nil);
    procedure StopDiscovery;
    function ConnectTo(const APeripheral: CBPeripheral): Boolean;
    function CancelConnectionTo(const APeripheral: CBPeripheral): Boolean;
    procedure OnDiscoveryTimeout(Sender: TObject);
    property OnDeviceDiscovered: TDeviceDiscoveredEvent read FOnDeviceDiscovered write FOnDeviceDiscovered;
    property OnDeviceDiscoveryTimeout: TNotifyEvent read FOnDeviceDiscoveryTimeout write FOnDeviceDiscoveryTimeout;
    property OnDeviceConnect: TDeviceConnectionChangeEvent read FOnDeviceConnect write FOnDeviceConnect;
    property OnDeviceDisconnect: TDeviceConnectionChangeEvent read FOnDeviceDisconnect write FOnDeviceDisconnect;
  end;

  TDiscoveredServicesEvent = procedure(Sender: TObject; Error: Integer) of object;
  TDidReadWriteCharacteristicValueEvent = procedure(Sender: TObject; ACharacteristic: CBCharacteristic; Error: Integer) of object;
  TReadWriteDescriptorValueEvent = procedure(const Sender: TObject; const ADescriptor: CBDescriptor; Error: Integer) of object;

  TMacBluetoothLEDevice = class;

  TMacBluetoothLEPeripheral = class(TOCLocal, CBPeripheralDelegate)
  private const
    DeviceTimeout: Cardinal = 5;
  private
    FLEDevice: TMacBluetoothLEDevice;
    FDevice: CBPeripheral;
    FDiscoveredServices: Boolean;
    FDiscoveredCharacteristics: Boolean;
    FLastError: Integer;
    FDiscoveredIncludedServices: Boolean;
    FDiscoveredDescriptors: Boolean;
    FUpdatedNotification: Boolean;
    FOnDiscoveredServices: TDiscoveredServicesEvent;
    FOnDidReadCharacteristicValue: TDidReadWriteCharacteristicValueEvent;
    FOnDidWriteCharacteristicValue: TDidReadWriteCharacteristicValueEvent;
    FOnReadDescriptorValue: TReadWriteDescriptorValueEvent;
    FOnWriteDescriptorValue: TReadWriteDescriptorValueEvent;
    FOnUpdatedRssiValue: TGattDeviceRSSIEvent;
    FAdvertiseGattServerName: string;
    function GetServices: NSArray;
    function GetName: string;
  public
    procedure peripheralDidUpdateName(peripheral: CBPeripheral); cdecl;
    procedure peripheralDidInvalidateServices(peripheral: CBPeripheral); cdecl; { deprecated;  iOS 6.0 }
    [MethodName('peripheral:didModifyServices:')]
    procedure peripheralDidModifyServices(peripheral: CBPeripheral; invalidatedServices: NSArray); cdecl; { OS X 10.9+, iOS 7+ }
    [MethodName('peripheralDidUpdateRSSI:error:')]
    procedure peripheralDidUpdateRSSI(peripheral: CBPeripheral; error: NSError); cdecl;
    [MethodName('peripheral:didDiscoverServices:')]
    procedure peripheralDidDiscoverServices(peripheral: CBPeripheral; error: NSError); cdecl;
    [MethodName('peripheral:didDiscoverIncludedServicesForService:error:')]
    procedure peripheralDidDiscoverIncludedServicesForService(peripheral: CBPeripheral; service: CBService; error: NSError); cdecl;
    [MethodName('peripheral:didDiscoverCharacteristicsForService:error:')]
    procedure peripheralDidDiscoverCharacteristicsForService(peripheral: CBPeripheral; service: CBService; error: NSError); cdecl;
    [MethodName('peripheral:didUpdateValueForCharacteristic:error:')]
    procedure peripheralDidUpdateValueForCharacteristic(peripheral: CBPeripheral; characteristic: CBCharacteristic; error: NSError); cdecl;
    [MethodName('peripheral:didWriteValueForCharacteristic:error:')]
    procedure peripheralDidWriteValueForCharacteristic(peripheral: CBPeripheral; characteristic: CBCharacteristic; error: NSError); cdecl;
    [MethodName('peripheral:didUpdateNotificationStateForCharacteristic:error:')]
    procedure peripheralDidUpdateNotificationStateForCharacteristic(peripheral: CBPeripheral; characteristic: CBCharacteristic; error: NSError); cdecl;
    [MethodName('peripheral:didDiscoverDescriptorsForCharacteristic:error:')]
    procedure peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: CBPeripheral; characteristic: CBCharacteristic; error: NSError); cdecl;
    [MethodName('peripheral:didUpdateValueForDescriptor:error:')]
    procedure peripheralDidUpdateValueForDescriptor(peripheral: CBPeripheral; descriptor: CBDescriptor; error: NSError); cdecl;
    [MethodName('peripheral:didWriteValueForDescriptor:error:')]
    procedure peripheralDidWriteValueForDescriptor(peripheral: CBPeripheral; descriptor: CBDescriptor; error: NSError); cdecl;
    constructor Create(const ADevice: CBPeripheral; const AGattServerName: string);
    destructor Destroy; override;
    procedure DiscoverServices(ASilent: Boolean = False);
    procedure InternalDiscoverCharacteristics(const AService: CBService; const UUIDS: NSArray);
    procedure DiscoverIncludedServicesForService(const AService: CBService);
    procedure ReadCharacteristicValue(const ACharacteristic: CBCharacteristic);
    procedure WriteCharacteristicValue(const ACharacteristic: CBCharacteristic; const AValue: TBytes; AWriteType: CBCharacteristicWriteType);
    procedure ReadRSSI; inline;
    function GetConnected: Boolean;
    procedure InternalDiscoverDescriptors(const ACharacteristic: CBCharacteristic);
    procedure SetNotifyValue(const ACharacteristic: CBCharacteristic; AValue: Boolean);
    procedure ReadDescriptorValue(const ADescriptor: CBDescriptor);
    procedure WriteDescriptorValue(const ADescriptor: CBDescriptor; const AValue: TBytes);
    property DiscoveredServices: Boolean read FDiscoveredServices write FDiscoveredServices;
    property DiscoveredCharacteristics: Boolean read FDiscoveredCharacteristics write FDiscoveredCharacteristics;
    property DiscoveredIncludedServices: Boolean read FDiscoveredIncludedServices write FDiscoveredIncludedServices;
    property OnUpdatedRssiValue: TGattDeviceRSSIEvent read FOnUpdatedRssiValue write FOnUpdatedRssiValue;
    property Services: NSArray read GetServices;
    property LastError: Integer read FLastError write FLastError;
    property Name: string read GetName;
    property OnDiscoveredServices: TDiscoveredServicesEvent read FOnDiscoveredServices write FOnDiscoveredServices;
    property OnDidReadCharacteristicValue: TDidReadWriteCharacteristicValueEvent read FOnDidReadCharacteristicValue write
      FOnDidReadCharacteristicValue;
    property OnDidWriteCharacteristicValue: TDidReadWriteCharacteristicValueEvent read FOnDidWriteCharacteristicValue write
      FOnDidWriteCharacteristicValue;
    property OnReadDescriptorValue: TReadWriteDescriptorValueEvent read FOnReadDescriptorValue write FOnReadDescriptorValue;
    property OnWriteDescriptorValue: TReadWriteDescriptorValueEvent read FOnWriteDescriptorValue write FOnWriteDescriptorValue;
  end;

  TServiceAddedEvent = procedure(Sender: TObject; const Peripheral: CBPeripheralManager; const Service: CBService; Error: Integer) of object;
  TReceiveReadRequestEvent = procedure(Sender: TObject; const Peripheral: CBPeripheralManager; const Request: CBATTRequest) of object;
  TReceiveWriteRequestsEvent = procedure(Sender: TObject; const Peripheral: CBPeripheralManager; const Requests: NSArray) of object;
  TSubscribeToCharacteristicEvent = procedure(Sender: TObject; const ClientId: string; const ACharacteristic: CBCharacteristic) of object;

  TMacBluetoothGattServer = class;

  TMacBluetoothLEGattServerManager = class(TOCLocal, CBPeripheralManagerDelegate)
  private
    FGattServer: CBPeripheralManager;
    FGattServerOn: Boolean;
    FGServ: TMacBluetoothGattServer;
    FOnReceiveReadRequest: TReceiveReadRequestEvent;
    FOnReceiveWriteRequest: TReceiveWriteRequestsEvent;
    FOnServiceAdded: TServiceAddedEvent;
    FOnSubscribeClient: TSubscribeToCharacteristicEvent;
    FOnUnsubscribeClient: TSubscribeToCharacteristicEvent;
    FPendingUpdate: Boolean;
    FPendingValue: NSData;
    FPendingChar: CBMutableCharacteristic;
  public
    procedure peripheralManagerDidUpdateState(peripheral: CBPeripheralManager); cdecl;
    [MethodName('peripheralManagerDidStartAdvertising:error:')]
    procedure peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager; error: NSError); cdecl;
    [MethodName('peripheralManager:didAddService:error:')]
    procedure peripheralManagerDidAddService(peripheral: CBPeripheral; service: CBService; error: NSError); cdecl;
    [MethodName('peripheralManager:central:didSubscribeToCharacteristic:')]
    procedure peripheralManagerDidSubscribetoCharacteristic(peripheral: CBPeripheral; central: CBCentral;
      characteristic: CBCharacteristic); cdecl;
    [MethodName('peripheralManager:central:didUnsubscribeFromCharacteristic:')]
    procedure peripheralManagerDidUnsubscribeFromCharacteristic(peripheral: CBPeripheralManager; central: CBCentral;
      characteristic: CBCharacteristic); cdecl;
    [MethodName('peripheralManager:didReceiveReadRequest:')]
    procedure peripheralManagerDidReceiveReadRequests(peripheral: CBPeripheralManager; request: CBATTRequest); cdecl;
    [MethodName('peripheralManager:didReceiveWriteRequests:')]
    procedure peripheralManagerDidReceiveWriteRequests(peripheral: CBPeripheralManager; requests: NSArray); cdecl;
    procedure peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager); cdecl;
    constructor Create(const AServer: TMacBluetoothGattServer);
    destructor Destroy; override;
    procedure RemoveAllServices;
    procedure UpdateCharacteristicValue(const ACharacteristic: CBMutableCharacteristic; const Value: TBytes);
    property GattServerOn: Boolean read FGattServerOn;
    property OnReceiveReadRequest: TReceiveReadRequestEvent read FOnReceiveReadRequest write FOnReceiveReadRequest;
    property OnReceiveWriteRequest: TReceiveWriteRequestsEvent read FOnReceiveWriteRequest write FOnReceiveWriteRequest;
    property OnSubscribeClient: TSubscribeToCharacteristicEvent read FOnSubscribeClient write FOnSubscribeClient;
    property OnUnsubscribeClient: TSubscribeToCharacteristicEvent read FOnUnsubscribeClient write FOnUnsubscribeClient;
    property OnServiceAdded: TServiceAddedEvent read FOnServiceAdded write FOnServiceAdded;
  end;

   TMacBluetoothLEAdvertiseData = class(TBluetoothLEAdvertiseData)
   protected
    function DoAddServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean; override;
    procedure DoRemoveServiceUUID(const AServiceUUID: TBluetoothUUID); override;
    procedure DoClearServiceUUIDs; override;
    function DoAddServiceData(const AServiceUUID: TBluetoothUUID; const AData: TBytes): Boolean; override;
    procedure DoRemoveServiceData(const AServiceUUID: TBluetoothUUID); override;
    procedure DoClearServiceData; override;
    function ContainsServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean; override;
    function GetServiceUUIDs: TArray<TBluetoothUUID>; override;
    function GetServiceData: TArray<TServiceDataRawData>; override;
    function GetDataForService(const AServiceUUID: TBluetoothUUID): TBytes; override;
    procedure SetLocalName(const ALocalName: string); override;
    function GetLocalName: string; override;
    procedure SetTxPowerLevel(ATxPowerLevel: Integer); override;
    function GetTxPowerLevel: Integer; override;
    procedure SetManufacturerSpecificData(const AManufacturerSpecificData: TBytes); override;
    function GetManufacturerSpecificData: TBytes; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TMacBluetoothGattServer = class(TBluetoothGattServer)
  private
    FGattServer: TMacBluetoothLEGattServerManager;
    procedure OnReceiveReadRequest(Sender: TObject; const Peripheral: CBPeripheralManager; const Request: CBATTRequest);
    procedure OnReceiveWriteRequests(Sender: TObject; const Peripheral: CBPeripheralManager; const Requests: NSArray);
    procedure OnSubscribeClient(Sender: TObject; const ClientId: string; const ACharacteristic: CBCharacteristic);
    procedure OnUnsubscribeClient(Sender: TObject; const ClientId: string; const ACharacteristic: CBCharacteristic);
    function FindCharacteristic(const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
    procedure GetServiceAdvertiseDictionary(var AServiceAdvertiseDictionary: NSMutableDictionary);
    function StartAdvertisingData(const ADict: NSMutableDictionary): Boolean;
  protected
    function DoCreateAdvertiseData: TBluetoothLEAdvertiseData; override;
    function DoCreateService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService; override;
    function DoCreateIncludedService(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      AType: TBluetoothServiceType): TBluetoothGattService; override;
    function DoCreateCharacteristic(const AService: TBluetoothGattService; const AnUUID: TBluetoothUUID;
      const AProps: TBluetoothPropertyFlags; const ADescription: string = ''): TBluetoothGattCharacteristic; override;
    function DoCreateDescriptor(const ACharacteristic: TBluetoothGattCharacteristic;
      const AnUUID: TBluetoothUUID): TBluetoothGattDescriptor; override;

    function DoAddService(const AService: TBluetoothGattService): Boolean; override;
    function DoAddCharacteristic(const AService: TBluetoothGattService;
      const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoGetServices: TBluetoothGattServiceList; override;
    procedure DoClose; override;
    procedure DoClearServices; override;

    procedure DoCharacteristicReadRequest(const ADevice: TBluetoothLEDevice; ARequestId: Integer; AnOffset: Integer;
      const AGattCharacteristic: TBluetoothGattCharacteristic); override;
    procedure DoCharacteristicWriteRequest(const ADevice: TBluetoothLEDevice; ARequestId: Integer;
      const AGattCharacteristic: TBluetoothGattCharacteristic; APreparedWrite: Boolean; AResponseNeeded: Boolean;
      AnOffset: Integer; const AValue: TBytes); override;
    procedure DoUpdateCharacteristicValue(const ACharacteristic: TBluetoothGattCharacteristic); override;

    procedure DoServiceAdded(AStatus: TBluetoothGattStatus; const AService: TBluetoothGattService); override;
    procedure DoStartAdvertising; override;
    procedure DoStopAdvertising; override;
    function DoIsAdvertising: Boolean; override;

  public
    constructor Create(const AManager: TBluetoothLEManager);
    destructor Destroy; override;
  end;

  TMacBluetoothLEDevice = class(TBluetoothLEDevice)
  private const
    DeviceTimeout: Cardinal = 5;
  private
    FDevice: TMacBluetoothLEPeripheral;
    FLEManager: TInternalBluetoothLEManager;
    FUpdateServices: Boolean;
    procedure DiscoveredSevices(Sender: TObject; Error: Integer);
    procedure DidReadCharacteristicValue(Sender: TObject; ACharacteristic: CBCharacteristic; Error: Integer);
    procedure DidWriteCharacteristicValue(Sender: TObject; ACharacteristic: CBCharacteristic; Error: Integer);
    procedure DidReadRssi(const Sender: TObject; ARssiValue: Integer; AGattStatus: TBluetoothGattStatus);
    procedure DidReadDescriptorValue(const Sender: TObject; const ADescriptor: CBDescriptor; Error: Integer);
    procedure DidWriteDescriptorValue(const Sender: TObject; const ADescriptor: CBDescriptor; Error: Integer);
    function CheckConnection: Boolean;
    function FindCharacteristic(const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
    function FindDescriptor(const ADescriptor: CBDescriptor): TBluetoothGattDescriptor;
    procedure UpdateServices;
  protected
    function DoCreateAdvertiseData: TBluetoothLEAdvertiseData; override;
    function GetAddress: TBluetoothMacAddress; override;
    function GetDeviceName: string; override;
    function GetBluetoothType: TBluetoothType; override;
    function GetIdentifier: string; override;
    function GetIsConnected: Boolean; override;
    procedure DoAbortReliableWrite; override;
    function DoBeginReliableWrite: Boolean; override;
    function DoExecuteReliableWrite: Boolean; override;
    function DoDiscoverServices: Boolean; override;
    function DoReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;
    function DoWriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoWriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;
    function DoReadRemoteRSSI: Boolean; override;
    function DoSetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
      Enable: Boolean): Boolean; override;
    function DoDisconnect: Boolean; override;
    function DoConnect: Boolean; override;
  public
    constructor Create(AutoConnect: Boolean; const APeripheral: CBPeripheral;
      const AManager: TInternalBluetoothLEManager; const AGattServerName: string);
    destructor Destroy; override;
  end;

  TMacBluetoothGattService = class(TBluetoothGattService)
  private const
    DeviceTimeout: Cardinal = 5;
  private
    FUUID: TBluetoothUUID;
    FService: CBService;
    FMutableService: CBMutableService;
    FDevice: TMacBluetoothLEPeripheral;
    FGattServer: TMacBluetoothLEGattServerManager;
    function FindCharacteristic(const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
    function FindDescriptor(const ADescriptor: CBDescriptor): TBluetoothGattDescriptor;
  protected
    function GetServiceType: TBluetoothServiceType; override;
    function GetServiceUUID: TBluetoothUUID; override;
    function DoGetCharacteristics: TBluetoothGattCharacteristicList; override;

    function DoAddCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoAddIncludedService(const AService: TBluetoothGattService): Boolean; override;

    function DoCreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService; override;
    function DoCreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
      const ADescription: string): TBluetoothGattCharacteristic; override;

    function DoGetIncludedServices: TBluetoothGattServiceList; override;
    procedure UpdateCharacteristics;
  public
    constructor Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType; const AService: CBService;
      const ADevice: TMacBluetoothLEPeripheral); overload;
    constructor Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType; const AService: CBMutableService;
      const AGattServer: TMacBluetoothLEGattServerManager); overload;
    destructor Destroy; override;
  end;

  TMacBluetoothGattCharacteristic = class(TBluetoothGattCharacteristic)
  private
    FUUID: TBluetoothUUID;
    FProperties: TBluetoothPropertyFlags;
    FCharacteristic: CBCharacteristic;
    FDevice: TMacBluetoothLEPeripheral;
    FValue: TBytes;
  protected
    function GetUUID: TBluetoothUUID; override;
    function GetProperties: TBluetoothPropertyFlags; override;
    function DoAddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;
    function DoCreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor; override;
    function DoGetDescriptors: TBluetoothGattDescriptorList; override;

    function DoGetValue: TBytes; override;
    procedure DoSetValue(const AValue: TBytes); override;
    procedure UpdateDescriptors;
    function InternalGetProperties: TBluetoothPropertyFlags;

  public
    constructor Create(const AService: TBluetoothGattService; const ACharacteristic: CBCharacteristic; const ADevice: TMacBluetoothLEPeripheral); overload;
    constructor Create(const AService: TBluetoothGattService; const ACharacteristic: CBMutableCharacteristic); overload;
    destructor Destroy; override;
  end;

  TMacBluetoothGattDescriptor = class(TBluetoothGattDescriptor)
  private
    FUUID: TBluetoothUUID;
    FDescriptor: CBDescriptor;
    FDevice: TMacBluetoothLEPeripheral;
    FCharacteristic: CBCharacteristic;
    FValue: TBytes;
    FNotification: Boolean;
    FIndication: Boolean;
    FBroadcast: Boolean;
  protected
    function DoGetValue: TBytes; override;
    procedure DoSetValue(const AValue: TBytes); override;
    function GetUUID: TBluetoothUUID; override;

    // Characteristic Extended Properties
    function DoGetReliableWrite: Boolean; override;
    function DoGetWritableAuxiliaries: Boolean; override;

    // Characteristic User Description
    function DoGetUserDescription: string; override;
    procedure DoSetUserDescription(const Value: string); override;

    // Client Characteristic Configuration
    procedure DoSetNotification(const Value: Boolean); override;
    function DoGetNotification: Boolean; override;
    procedure DoSetIndication(const Value: Boolean); override;
    function DoGetIndication: Boolean; override;

    // Server Characteristic Configuration
    function DoGetBroadcasts: Boolean; override;
    procedure DoSetBroadcasts(const Value: Boolean); override;

    //Characteristic Presentation Format
    function DoGetFormat: TBluetoothGattFormatType; override;
    function DoGetExponent: ShortInt; override;
    function DoGetFormatUnit: TBluetoothUUID; override;
  public
    constructor Create(const ADescriptor: CBDescriptor; const ADevice: TMacBluetoothLEPeripheral;
      const ACharacteristic: TBluetoothGattCharacteristic);
    destructor Destroy; override;
    property Notification: Boolean read FNotification write FNotification;
    property Indication: Boolean read FIndication write FIndication;
    property BroadCast: Boolean read FBroadcast write FBroadcast;
  end;
{$ENDIF !BLUETOOTH_LE}

{ Common / helper functions }

function CheckOSVersion: Boolean;
begin
{$IF defined(IOS)}
  if TOSVersion.Check(7) then
{$ELSE}
  if TOSVersion.Check(10, 9) then
{$ENDIF !IOS}
    Result := True
  else
    Result := False;
end;

function CheckOSVersionForGattClient: Boolean;
begin
{$IF defined(IOS)}
  if TOSVersion.Check(5) then
{$ELSE}
  if TOSVersion.Check(10, 7) then
{$ENDIF !IOS}
    Result := True
  else
    Result := False;
end;

function CheckOSVersionForGattServer: Boolean;
begin
{$IF defined(IOS)}
  if TOSVersion.Check(6) then
{$ELSE}
  if TOSVersion.Check(10, 9) then
{$ENDIF}
    Result := True
  else
    Result := False;
end;

function UUIDToGUID(const AUUID: Pointer): TGUID; inline;
begin
  Result := TGUID.Create(PByte(AUUID)^, TEndian.Big);
end;

function NSDataToGUID(const AData: NSData): TGUID;
begin
  if AData.length = 2 then
  begin
    Result := BLUETOOTH_BASE_UUID;
    Result.D1 := Cardinal(Swap(Word(AData.bytes^)));
  end
  else
    Result := UUIDToGUID(AData.bytes);
end;

procedure InternalWaitMessage(AInterval: Single);
var
  TimeoutDate: NSDate;
begin
  TimeoutDate := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(AInterval));
  TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop).runMode(NSDefaultRunLoopMode, TimeoutDate);
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    Sleep(Trunc(AInterval * 1000));
end;


{$If defined(BLUETOOTH_CLASSIC)}

function GUIDToUUID(const AUUID: TGUID): Pointer;
var
  LTmp: TBytes;
begin
  LTmp := AUUID.ToByteArray(TEndian.Big);
  Result := TIOBluetoothSDPUUID.Alloc.initWithBytes(@LTmp[0], 16);
end;

{ TPlatformBluetoothManager }

class function TPlatformBluetoothClassicManager.GetBluetoothManager: TBluetoothManager;
begin
  Result := TMacBluetoothManager.Create;
end;

{ TBluetoothDeviceInquiry }

procedure TBluetoothDeviceInquiry.CancelDiscovery;
begin
  FCanceled := True;
  FInquirer.stop;
end;

constructor TBluetoothDeviceInquiry.Create;
begin
  inherited Create;
  FInquirer := TIOBluetoothDeviceInquiry.OCClass.inquiryWithDelegate(GetObjectID);
  FInquirer.retain;
end;

destructor TBluetoothDeviceInquiry.Destroy;
begin
  FInquirer.release;
  inherited;
end;

procedure TBluetoothDeviceInquiry.deviceInquiryComplete(sender: IOBluetoothDeviceInquiry; error: UInt32;
  aborted: Boolean);
begin
  if not FCanceled and Assigned(FOnInquiryComplete) then
    FOnInquiryComplete(Self, error, aborted);
end;

procedure TBluetoothDeviceInquiry.deviceInquiryDeviceFound(sender: IOBluetoothDeviceInquiry; device: IOBluetoothDevice);
begin
  if Assigned(FOnDeviceFound) then
    FOnDeviceFound(Self, device);
end;

procedure TBluetoothDeviceInquiry.deviceInquiryDeviceNameUpdated(sender: IOBluetoothDeviceInquiry;
  device: IOBluetoothDevice; devicesRemaining: UInt32);
begin
  if Assigned(FOnDeviceNameUpdated) then
    FOnDeviceNameUpdated(Self, device, devicesRemaining);
end;

procedure TBluetoothDeviceInquiry.deviceInquiryStarted(sender: IOBluetoothDeviceInquiry);
begin
  if Assigned(FOnInquiryStarted) then
    FOnInquiryStarted(Self);
end;

procedure TBluetoothDeviceInquiry.deviceInquiryUpdatingDeviceNamesStarted(sender: IOBluetoothDeviceInquiry;
  devicesRemaining: UInt32);
begin

end;

function TBluetoothDeviceInquiry.FoundDevices: NSArray;
begin
  Result := FInquirer.foundDevices;
end;

procedure TBluetoothDeviceInquiry.startDiscovery;
begin
  FCanceled := False;
  FInquirer.start;
end;

{ TBluetoothDevicePair }

function TBluetoothDevicePair.CancelPairing: Boolean;
begin
  Result := (FBluetoothPair.stop = kIOReturnSuccess);
end;

constructor TBluetoothDevicePair.Create;
begin
  inherited;
  FBluetoothPair := TIOBluetoothDevicePair.Wrap(TIOBluetoothDevicePair.Alloc.init);
  FBluetoothPair.setDelegate(Self.GetObjectID);
end;

destructor TBluetoothDevicePair.Destroy;
begin
  FBluetoothPair.release;
  inherited;
end;

procedure TBluetoothDevicePair.devicePairingConnecting(sender: id);
begin
  if Assigned(FOnDevicePairingConnecting) then
    FOnDevicePairingConnecting(Self);
end;

procedure TBluetoothDevicePair.devicePairingFinished(sender: id; error: IOReturn);
begin
  if Assigned(FOnDevicePairingFinished) then
    FOnDevicePairingFinished(Self, error);
end;

procedure TBluetoothDevicePair.devicePairingPINCodeRequest(sender: id);
begin

end;

procedure TBluetoothDevicePair.devicePairingStarted(sender: id);
begin
  if Assigned(FOnDevicePairingStarted) then
    FOnDevicePairingStarted(Self);
end;

procedure TBluetoothDevicePair.devicePairingUserConfirmationRequest(sender: id; numericValue: BluetoothNumericValue);
var
  Reply: Boolean;
begin
  Reply := True;
  if Assigned(FOnDevicePairingConfirmationRequest) then
    FOnDevicePairingConfirmationRequest(Self, numericValue, Reply);

  TIOBluetoothDevicePair.Wrap(sender).replyUserConfirmation(Reply);
end;

procedure TBluetoothDevicePair.devicePairingUserPasskeyNotification(sender: id; passkey: BluetoothPasskey);
begin

end;

procedure TBluetoothDevicePair.deviceSimplePairingFinished(sender: id; status: BluetoothHCIEventStatus);
begin

end;

function TBluetoothDevicePair.PairWith(ADevice: IOBluetoothDevice): Boolean;
begin
  FBluetoothPair.setDevice(ADevice);
  Result := (FBluetoothPair.start = kIOReturnSuccess);
end;

{ TMacBluetoothManager }

function TMacBluetoothManager.DoGetClassicAdapter: TBluetoothAdapter;
begin
  if FAdapter = nil then
    FAdapter := TMacBluetoothAdapter.Create(Self, TIOBluetoothHostController.OCClass.defaultController);
  if TMacBluetoothAdapter(FAdapter).FAdapter.powerState = kBluetoothHCIPowerStateOff then
    FAdapter := nil;
  Result := FAdapter;
end;

function TMacBluetoothManager.GetConnectionState: TBluetoothConnectionState;
begin
  if TMacBluetoothAdapter(CurrentAdapter).FAdapter.powerState = kBluetoothHCIPowerStateOn then
    Result := TBluetoothConnectionState.Connected
  else
    Result := TBluetoothConnectionState.Disconnected;
end;

function TMacBluetoothManager.DoEnableBluetooth: Boolean;
begin
  Result := False;
end;

{ TMacBluetoothAdapter }

procedure TMacBluetoothAdapter.DoCancelDiscovery;
begin
  FDeviceDiscover.CancelDiscovery;
end;

constructor TMacBluetoothAdapter.Create(const AManager: TBluetoothManager; const AnAdapter: IOBluetoothHostController);
begin
  inherited Create(AManager);

  FAdapter := AnAdapter;
  FAdapter.retain;
  FPairedDevices := TBluetoothDeviceList.Create;
  FDiscoveredDevices := TBluetoothDeviceList.Create;
  FDevicePair := TBluetoothDevicePair.Create;
  FDeviceDiscover := TBluetoothDeviceInquiry.Create;
  FDeviceDiscover.OnInquiryComplete := InternalInquiryComplete;
end;

destructor TMacBluetoothAdapter.Destroy;
begin
  FAdapter.release;
  FPairedDevices.Free;
  FDiscoveredDevices.Free;
  FDeviceDiscover.Free;
  FDevicePair.Free;

  inherited;
end;

function TMacBluetoothAdapter.DoCreateServerSocket(const AName: string;
  const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket;
begin
  Result := TMacBluetoothServerSocket.Create(AName, AUUID);
end;

function TMacBluetoothAdapter.GetAdapterName: string;
begin
  Result := NSStrToStr(FAdapter.nameAsString);
end;

function TMacBluetoothAdapter.GetAddress: TBluetoothMacAddress;
begin
  Result := NSStrToStr(FAdapter.addressAsString).Replace('-', ':').ToUpper;
end;

function TMacBluetoothAdapter.GetPairedDevices: TBluetoothDeviceList;
var
  LPairedList: NSArray;
  I: Integer;
begin
  FPairedDevices.Clear;
  LPairedList := TIOBluetoothDevice.OCClass.pairedDevices;
  if LPairedList.count > 0 then
    for I := 0 to LPairedList.count - 1 do
      FPairedDevices.Add(TMacBluetoothDevice.Create(TIOBluetoothDevice.Wrap(LPairedList.objectAtIndex(I))));

  Result := FPairedDevices;
end;

function TMacBluetoothAdapter.GetScanMode: TBluetoothScanMode;
begin
  Result := TBluetoothScanMode.Connectable;
end;

function TMacBluetoothAdapter.GetState: TBluetoothAdapterState;
begin
  if FAdapter.powerState = kBluetoothHCIPowerStateOn then
    Result := TBluetoothAdapterState.&On
  else
    Result := TBluetoothAdapterState.Off;
end;

procedure TMacBluetoothAdapter.InternalInquiryComplete(sender: TObject; error: UInt32; aborted: Boolean);
var
  LDevices: NSArray;
  I: Integer;
begin
  FDiscoveredDevices.Clear;
  if (not aborted) then
  begin
    LDevices := FDeviceDiscover.FoundDevices;
    if LDevices.count > 0 then
      for I := 0 to LDevices.count - 1 do
        FDiscoveredDevices.Add(TMacBluetoothDevice.Create(TIOBluetoothDevice.Wrap(LDevices.objectAtIndex(I))));
  end;

  DoDiscoveryEnd(Self, FDiscoveredDevices);
end;

function TMacBluetoothAdapter.DoPair(const ADevice: TBluetoothDevice): Boolean;
begin
  Result := FDevicePair.PairWith(TMacBluetoothDevice(ADevice).FDevice);
end;

procedure TMacBluetoothAdapter.SetAdapterName(const Value: string);
begin
  { Not supported on Mac }
end;

procedure TMacBluetoothAdapter.DoStartDiscoverable(Timeout: Cardinal);
var
  LCurrentClass: BluetoothClassOfService;
begin
  { According to SetClassOfDevice Mac documentation, setting the bit 13 to 1 }
  { set the device to Limited Discoverable mode, but doesn't work. }
  LCurrentClass := FAdapter.classOfDevice;
  LCurrentClass := LCurrentClass or (1 shl 13);
  if FAdapter.setClassOfDevice(LCurrentClass, 60) <> kIOReturnSuccess then
    raise EBluetoothAdapterException.Create(SBluetoothNoDiscoverable);
end;

procedure TMacBluetoothAdapter.DoStartDiscovery(TimeOut: Cardinal);
begin
  FDeviceDiscover.StartDiscovery;
  inherited;
end;

function TMacBluetoothAdapter.DoUnPair(const ADevice: TBluetoothDevice): Boolean;
begin
  { Not supported on Mac }
  raise EBluetoothAdapterException.CreateFmt(SBluetoothNotSupported, ['Unpair', 'Mac']); // Do not translate
end;

{ TMacBluetoothDevice }

constructor TMacBluetoothDevice.Create(const ABluetoothDevice: IOBluetoothDevice);
begin
  inherited Create;

  FDevice := ABluetoothDevice;
  FDevice.retain;
  FNotifier := TBluetoothDeviceNotifier.Create;
end;

destructor TMacBluetoothDevice.Destroy;
begin
  FNotifier.Free;
  FDevice.release;
  inherited;
end;

function TMacBluetoothDevice.DoCreateClientSocket(const AUUID: TGUID; CreateSecure: Boolean): TBluetoothSocket;
var
  LServiceRecord: IOBluetoothSDPServiceRecord;
  LRFCOMMChannel: Byte;
  LUUID: IOBluetoothSDPUUID;
begin
  Result := nil;
  if FServiceList.Count = 0 then
    GetServices;
  if not FDevice.isConnected then
    if FDevice.openConnection(nil, ConnectTimeout, CreateSecure) <> kIOReturnSuccess then
      Exit(nil);

  LUUID := TIOBluetoothSDPUUID.Wrap(GUIDToUUID(AUUID));
  try
    LServiceRecord := FDevice.getServiceRecordForUUID(LUUID);
    if LServiceRecord = nil then
    begin
      GetServices;
      LServiceRecord := FDevice.getServiceRecordForUUID(LUUID);
    end;
    if LServiceRecord = nil then
      raise EBluetoothDeviceException.CreateFmt(SBluetoothNoService, [AUUID.ToString, GetDeviceName]);
    if LServiceRecord.getRFCOMMChannelID(LRFCOMMChannel) <> kIOReturnSuccess then
      raise EBluetoothDeviceException.CreateFmt(SBluetoothNoRFChannel, [GetDeviceName, AUUID.ToString]);
    Result := TMacBluetoothSocket.Create(FDevice, LServiceRecord);
  finally
    LUUID.release;
  end;
end;

function TMacBluetoothDevice.DoGetServices: TBluetoothServiceList;
var
  LServiceList: NSArray;
  I: Integer;
  LService: IOBluetoothSDPServiceRecord;
  LData: IOBluetoothSDPDataElement;
  LArray: NSArray;
  LRecord: IOBluetoothSDPDataElement;
  LTotal: Single;
  LNewService: TBluetoothService;
begin
  FServiceList.Clear;
  Result := FServiceList;
  FNotifier.Done := False;
  FDevice.performSDPQuery(FNotifier.GetObjectID);

  LTotal := 0;
  repeat
    InternalWaitMessage(0.05);
    LTotal := LTotal + 0.05;
  until (FNotifier.Done) or (LTotal >= SDPTimeout);

  LServiceList := FDevice.services;
  if (LServiceList <> nil) and (LServiceList.count > 0) then
  begin
    for I := 0 to LServiceList.count - 1 do
    begin
      LService := TIOBluetoothSDPServiceRecord.Wrap(LServiceList.objectAtIndex(I));
      LData := LService.getAttributeDataElement($0001);
      if LData <> nil then
      begin
        if LData.getTypeDescriptor = kBluetoothSDPDataElementTypeDataElementSequence then
        begin
          LArray := LData.getArrayValue;
          if (LArray <> nil) and (LArray.count > 0) then
          begin
            LRecord := TIOBluetoothSDPDataElement.Wrap(LArray.objectAtIndex(0));
            if LRecord.getTypeDescriptor = kBluetoothSDPDataElementTypeUUID then
              LNewService.UUID := NSDataToGUID(LRecord.getUUIDValue);
          end;
        end;
      end;
      LData := LService.getAttributeDataElement($0100);
      if LData <> nil then
      begin
        if LData.getTypeDescriptor = kBluetoothSDPDataElementTypeString then
          LNewService.Name := NSStrToStr(LData.getStringValue);
      end;
      if LNewService.Name = '' then
        LNewService.Name := TPlatformBluetoothClassicManager.GetKnownServiceName(LNewService.UUID);
      Result.Add(LNewService);
    end;
  end;
end;

function TMacBluetoothDevice.GetAddress: TBluetoothMacAddress;
begin
  Result := NSStrToStr(FDevice.addressString).Replace('-', ':').ToUpper;
end;

function TMacBluetoothDevice.GetBluetoothType: TBluetoothType;
begin
  Result := TBluetoothType.Classic;
end;

function TMacBluetoothDevice.GetClassDevice: Integer;
begin
  Result := FDevice.classOfDevice and $00000FFF;
end;

function TMacBluetoothDevice.GetClassDeviceMajor: Integer;
begin
  Result := 256 * FDevice.deviceClassMajor;
end;

function TMacBluetoothDevice.GetDeviceName: string;
begin
  Result := NSStrToStr(FDevice.name);
end;

function TMacBluetoothDevice.GetPaired: Boolean;
begin
  Result := FDevice.isPaired;
end;

function TMacBluetoothDevice.GetState: TBluetoothDeviceState;
begin
  if FDevice.isPaired then
    Result := TBluetoothDeviceState.Paired
  else
    if FDevice.isConnected then
      Result := TBluetoothDeviceState.Connected
    else
      Result := TBluetoothDeviceState.None;
end;

{ TBluetoothDeviceNotifier }

procedure TBluetoothDeviceNotifier.sdpQueryComplete(device: IOBluetoothDevice; status: IOReturn);
begin
  FDone := True;
end;

{ TMacBluetoothServerSocket }

constructor TMacBluetoothServerSocket.Create(const AName: string; const AUUID: TGUID);
begin
  inherited Create;
  FServiceName := AName;
  FServiceUUID := AUUID;
  FIncomingList := TList<TMacBluetoothSocket>.Create;
  InitServer;
end;

destructor TMacBluetoothServerSocket.Destroy;
begin
  FDestroying := True;
  StopServer;
  FIncomingList.Free;

  inherited;
end;

procedure TMacBluetoothServerSocket.InitServer;
var
  M: TMarshaller;
  LSelector: SEL;
begin
  { Create and publish the service }
  FServiceRecord := CreateSDPServiceRecord(FServiceName, FServiceUUID);
  FServiceRecord.retain;
  FServiceRecord.getRFCOMMChannelID(FChannelID);
  LSelector := sel_getUID(M.AsAnsi('newRFCOMMChannelOpened:newChannel:', CP_UTF8).ToPointer);
  FOpenChannelNotifier := TBluetoothRFCOMMOpenChannelDelegate.Create(FChannelID, FIncomingList);
  FOpenChannelNotifier.FNotifierID := TIOBluetoothRFCOMMChannel.OCClass.registerForChannelOpenNotifications(
     FOpenChannelNotifier.GetObjectID, LSelector, FChannelID, 1);
end;

procedure TMacBluetoothServerSocket.StopServer;
var
  I: Integer;
  ASocket: TBluetoothSocket;
begin
  if FOpenChannelNotifier <> nil then
  begin
    if FServiceRecord.removeServiceRecord <> kIOReturnSuccess then
      raise EBluetoothSocketException.CreateFmt(SBluetoothCanNotRemoveService, [FServiceUUID.ToString]);

    FOpenChannelNotifier.FNotifierID.unregister;
    FreeAndNil(FOpenChannelNotifier);
    for I := FIncomingList.Count - 1 downto 0 do
    begin
      ASocket := FIncomingList[I];
      ASocket.Free;
    end;
  end;
end;

function TMacBluetoothServerSocket.CreateSDPServiceRecord(const AName: string;
  const AUUID: TGUID): IOBluetoothSDPServiceRecord;
var
  LServiceDict: NSMutableDictionary;
  LNSString: NSString;
  LStringValue: NSString;
  LUUIDValue: Pointer;
  LArrayValue: NSMutableArray;
  LInnerArrayValue: NSMutableArray;
  LTmp: Pointer;
  LInitUUID: Pointer;
  LIndex: Pointer;
  LNewDict: NSMutableDictionary;
  LNewTmp: Pointer;
begin
  LServiceDict := TNSMutableDictionary.Create;

  try
    LNSString := StrToNSStr('0000 - ServiceRecordHandle*'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithUnsignedInteger(65540);
    LServiceDict.setValue(LTmp, LNSString);

    LNSString := StrToNSStr('0100 - ServiceName*'); // Do not translate
    LTmp := TNSString.OCClass.stringWithCharacters(PChar(AName), AName.Length);
    LServiceDict.setValue(LTmp, LNSString);

    LNSString := StrToNSStr('0001 - ServiceClassIDList'); // Do not translate
    LUUIDValue := GUIDToUUID(AUUID);

    LTmp := TNSMutableArray.Alloc.init;
    LArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LUUIDValue);
    LServiceDict.setValue(LTmp, LNSString);

    LNSString := StrToNSStr('0004 - ProtocolDescriptorList'); // Do not translate
    LIndex := TNSMutableArray.Alloc.init;
    LArrayValue := TNSMutableArray.Wrap(LIndex);
    LTmp := TNSMutableArray.Alloc.init;
    LInnerArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LTmp);
    LUUIDValue := TIOBluetoothSDPUUID.Alloc.initWithUUID16($0100);
    LInitUUID := LUUIDValue;
    LInnerArrayValue.addObject(LUUIDValue);

    LTmp := TNSMutableArray.Alloc.init;
    LInnerArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LTmp);
    LUUIDValue := TIOBluetoothSDPUUID.Alloc.initWithUUID16($0003);
    LInnerArrayValue.addObject(LUUIDValue);
    LNewTmp := TNSMutableDictionary.Alloc.init;
    LNewDict := TNSMutableDictionary.Wrap(LNewTmp);
    LInnerArrayValue.addObject(LNewTmp);
    LStringValue := StrToNSStr('DataElementSize'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(1);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementType'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(1);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementValue'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(3);
    LNewDict.setValue(LTmp, LStringValue);

    LTmp := TNSMutableArray.Alloc.init;
    LInnerArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LTmp);
    LUUIDValue := TIOBluetoothSDPUUID.Alloc.initWithUUID16($0008);
    LInnerArrayValue.addObject(LUUIDValue);
    LServiceDict.setValue(LIndex, LNSString);

    LNSString := StrToNSStr('0005 - BrowseGroupList'); // Do not translate
    LUUIDValue := TIOBluetoothSDPUUID.Alloc.initWithUUID16($1002);
    LTmp := TNSMutableArray.Alloc.init;
    LArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LUUIDValue);
    LServiceDict.setValue(LTmp, LNSString);

    LNSString := StrToNSStr('0009 - BluetoothProfileDescriptorList'); // Do not translate
    LIndex := TNSMutableArray.Alloc.init;
    LArrayValue := TNSMutableArray.Wrap(LIndex);
    LTmp := TNSMutableArray.Alloc.init;
    LInnerArrayValue := TNSMutableArray.Wrap(LTmp);
    LArrayValue.addObject(LTmp);
    LInnerArrayValue.addObject(LInitUUID);

    LNewTmp := TNSMutableDictionary.Alloc.init;
    LNewDict := TNSMutableDictionary.Wrap(LNewTmp);
    LInnerArrayValue.addObject(LNewTmp);
    LStringValue := StrToNSStr('DataElementSize'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(2);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementType'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(1);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementValue'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(256);
    LNewDict.setValue(LTmp, LStringValue);
    LServiceDict.setValue(LIndex, LNSString);

    LNSString := StrToNSStr('0303 - Supported Format List'); // Do not translate
    LIndex := TNSMutableArray.Alloc.init;
    LArrayValue := TNSMutableArray.Wrap(LIndex);

    LNewTmp := TNSMutableDictionary.Alloc.init;
    LNewDict := TNSMutableDictionary.Wrap(LNewTmp);
    LArrayValue.addObject(LNewTmp);

    LStringValue := StrToNSStr('DataElementSize'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(1);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementType'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(1);
    LNewDict.setValue(LTmp, LStringValue);

    LStringValue := StrToNSStr('DataElementValue'); // Do not translate
    LTmp := TNSNumber.Alloc.initWithInteger(255);
    LNewDict.setValue(LTmp, LStringValue);
    LServiceDict.setValue(LIndex, LNSString);

    Result := TIOBluetoothSDPServiceRecord.OCClass.publishedServiceRecordWithDictionary(LServiceDict);

  finally
    LServiceDict.release;
  end;
end;

function TMacBluetoothServerSocket.DoAccept(Timeout: Cardinal): TBluetoothSocket;
var
  LTotal: Single;
  LTimeout: Single;
  LDelta: Single;
begin
  if FOpenChannelNotifier = nil then
    raise EBluetoothSocketException.Create(SBluetoothAcceptError);

  FOpenChannelNotifier.Accepting := True;
  { We need to wait incoming connections, but without blocking current thread! }
  LTotal := 0;
  FOpenChannelNotifier.Done := False;
  if Timeout = INFINITE then
  begin
    LTimeout := 1000;
    LDelta := 0;
  end
  else
  begin
    LTimeout := Timeout / 1000;
    LDelta := 0.01;
  end;

  repeat
    LTotal := LTotal + LDelta;
    InternalWaitMessage(0.01);
  until (FDestroying) or (FOpenChannelNotifier.Done) or (LTotal >= LTimeout);
  FOpenChannelNotifier.Accepting := False;

  if (not FDestroying) and FOpenChannelNotifier.Done and (FIncomingList.Count > 0) then
  begin
    TMonitor.Enter(FIncomingList);
    try
      Result := FIncomingList[0];
      while not FIncomingList[0].FRFCOMMChannel.isOpen do
        InternalWaitMessage(0.01);
      FIncomingList.Delete(0);
    finally
      TMonitor.Exit(FIncomingList);
    end;
  end
  else
    Result := nil;
end;

procedure TMacBluetoothServerSocket.DoClose;
begin
  StopServer;
  inherited;
end;


{ TBluetoothRFCOMMOpenChannelDelegate }

constructor TBluetoothRFCOMMOpenChannelDelegate.Create(AChannelID: BluetoothRFCOMMChannelID;
  const AList: TMacBluetoothSocketList);
begin
  inherited Create;
  FChannelID := AChannelID;
  FIncomingList := AList;
end;

destructor TBluetoothRFCOMMOpenChannelDelegate.Destroy;
begin
  inherited;
end;

procedure TBluetoothRFCOMMOpenChannelDelegate.newRFCOMMChannelOpened(inNotification: Pointer;
  newChannel: Pointer);
var
  LNewChannel: IOBluetoothRFCOMMChannel;
begin
  LNewChannel := TIOBluetoothRFCOMMChannel.Wrap(newChannel);
  if (LNewChannel <> nil) and (LNewChannel.isIncoming) and (LNewChannel.getChannelID = FChannelID) then
  begin
    if FAccepting then
    begin
      TMonitor.Enter(FIncomingList);
      try
        LNewChannel.retain;
        FIncomingList.Add(TMacBluetoothSocket.Create(LNewChannel));

      finally
        TMonitor.Exit(FIncomingList);
      end;
      FDone := True;
    end
    else
    begin
      LNewChannel.closeChannel;
      LNewChannel.release;
    end;
  end;
end;

{ TBluetoothRFCOMMChannelDelegate }

constructor TBluetoothRFCOMMChannelDelegate.Create;
begin
  inherited;

  FDataList := TBluetoothDataList.Create;
end;

destructor TBluetoothRFCOMMChannelDelegate.Destroy;
begin
  FDataList.Free;

  inherited;
end;

procedure TBluetoothRFCOMMChannelDelegate.rfCOMMChannelClosed(rfcommChannel: Pointer);
begin
  { No need to implement, useful for debugging applications }
end;

procedure TBluetoothRFCOMMChannelDelegate.rfCOMMChannelControlSignalsChanged(rfCOMMChannel: Pointer);
begin
  { No need to implement, useful for debugging applications }
end;

procedure TBluetoothRFCOMMChannelDelegate.rfcommChannelData(rfcommChannel, data: Pointer; length: UInt32);
var
  LData: TBluetoothData;
begin
  SetLength(LData.Data, length);
  LData.Channel := rfcommChannel;
  Move(data^, LData.Data[0], length);
  TMonitor.Enter(FDataList);
  try
    FDataList.Add(LData);
  finally
    TMonitor.Exit(FDataList);
  end;
end;

procedure TBluetoothRFCOMMChannelDelegate.rfcommChannelFlowControlChanged(rfcommChannel: Pointer);
begin
  { No need to implement, useful for debugging applications }
end;

procedure TBluetoothRFCOMMChannelDelegate.rfcommChannelOpenComplete(rfcommChannel: Pointer; status: IOReturn);
begin
  FRFChannelOpenComplete := True;
end;

procedure TBluetoothRFCOMMChannelDelegate.rfcommChannelQueueSpaceAvailable(rfcommChannel: Pointer);
begin
  { No need to implement, useful for debugging applications }
end;

procedure TBluetoothRFCOMMChannelDelegate.rfcommChannelWriteComplete(rfcommChannel, refcon: Pointer; status: IOReturn);
begin
  { No need to implement, useful for debugging applications }
end;

{ TMacBluetoothSocket }

constructor TMacBluetoothSocket.Create(const AChannel: IOBluetoothRFCOMMChannel);
var
  FOCDelegate: NSObject;
begin
  inherited Create;
  FRFCOMMChannel := AChannel;
  FDelegate := TBluetoothRFCOMMChannelDelegate.Create;
  FRFCOMMChannel.setDelegate(FDelegate.GetObjectID);
  FOCDelegate := TNSObject.Wrap(FDelegate.GetObjectID);
  FOCDelegate.retain;
end;

constructor TMacBluetoothSocket.Create(const ADevice: IOBluetoothDevice; const AServiceRecord: IOBluetoothSDPServiceRecord);
begin
  inherited Create;
  FDelegate := TBluetoothRFCOMMChannelDelegate.Create;
  FServiceRecord := AServiceRecord;
  FDevice := ADevice;
end;

destructor TMacBluetoothSocket.Destroy;
begin
  FDestroying := True;
  if FRFCOMMChannel <> nil then
  begin
    FRFCOMMChannel.setDelegate(nil);
    FRFCOMMChannel.closeChannel;
    FRFCOMMChannel.release;
  end;
  FDelegate.Free;

  inherited;
end;

procedure TMacBluetoothSocket.DoClose;
begin
  inherited;
  FRFCOMMChannel.closeChannel;
end;

procedure TMacBluetoothSocket.DoConnect;
var
  LChannelID: Byte;
  LTmp: Pointer;
  LTotal: Single;
begin
  FServiceRecord.getRFCOMMChannelID(LChannelID);
  if FDevice.openRFCOMMChannelAsync(@LTmp, LChannelID, FDelegate.GetObjectID) <> kIOReturnSuccess then
    raise EBluetoothSocketException.CreateFmt(SBluetoothCanNotConnect, [NSStrToStr(FDevice.nameOrAddress)]);

  LTotal := 0;
  FDelegate.FRFChannelOpenComplete := False;
  repeat
    InternalWaitMessage(0.01);
    LTotal := LTotal + 0.01;
  until (FDelegate.RFChannelOpenComplete) or (LTotal >= ConnectTimeout);

  if not FDelegate.RFChannelOpenComplete then
    raise EBluetoothSocketException.CreateFmt(SBluetoothCanNotConnect, [NSStrToStr(FDevice.nameOrAddress)]);

  FRFCOMMChannel := TIOBluetoothRFCOMMChannel.Wrap(LTmp);
end;

function TMacBluetoothSocket.DoReceiveData(ATimeout: Cardinal): TBytes;
var
  LTotal: Single;
  I: Integer;
  LTotalBytes: Integer;
  LTmp: Integer;
  LDelta: Single;
  LTimeout: Single;
begin
  LTotal := 0;

  if ATimeout = INFINITE then
  begin
    LDelta := 0;
    LTimeout := 1000;
  end
  else
  begin
    LDelta := 0.01;
    LTimeout := ATimeout / 1000;
  end;

  while (FDelegate.FDataList.Count = 0) and (LTotal < LTimeout) do
  begin
    LTotal := LTotal + LDelta;
    InternalWaitMessage(0.01);
    if FDestroying or not FRFCOMMChannel.isOpen then
      raise EBluetoothSocketException.Create(SBluetoothRFChannelClosed);
   end;

  { Dump all pending data }
  TMonitor.Enter(FDelegate.FDataList);
  try
    if (not FDestroying) and (FDelegate.FDataList.Count > 0) then
    begin
      LTotalBytes := 0;
      for I := 0  to FDelegate.FDataList.Count - 1 do
        Inc(LTotalBytes, Length(FDelegate.FDataList[I].Data));
      SetLength(Result, LTotalBytes);
      LTotalBytes := 0;
      for I := 0  to FDelegate.FDataList.Count - 1 do
      begin
        LTmp := Length(FDelegate.FDataList[I].Data);
        Move(FDelegate.FDataList[I].Data[0], Result[LTotalBytes], LTmp);
        Inc(LTotalBytes, LTmp);
      end;
      { Clear the input buffer, all data is read }
      FDelegate.FDataList.Clear;
    end
    else
      SetLength(Result, 0);

  finally
    TMonitor.Exit(FDelegate.FDataList);
  end;
end;

procedure TMacBluetoothSocket.DoSendData(const AData: TBytes);
var
  LMTU: BluetoothRFCOMMMTU;
  LToSend: Integer;
  LResult: IOReturn;
  LToWrite: Integer;
  LDataPtr: PByte;
begin
  LMTU := FRFCOMMChannel.getMTU;
  LToSend := Length(AData);
  LResult := kIOReturnSuccess;
  LDataPtr := @AData[0];
  while (LResult = kIOReturnSuccess) and (LToSend > 0) do
  begin
    { check channel MTU to send up to MTU bytes }
    if LToSend > LMTU then
      LToWrite := LMTU
    else
      LToWrite := LToSend;

    LResult := FRFCOMMChannel.writeSync(LDataPtr, LToWrite);
    Inc(LDataPtr, LToWrite);
    Dec(LToSend, LToWrite);
  end;

  if (LResult <> kIOReturnSuccess) or (LToSend <> 0) then
    raise EBluetoothSocketException.Create(SBluetoothCanNotSendData);
end;

function TMacBluetoothSocket.GetConnected: Boolean;
begin
  if FRFCOMMChannel <> nil then
    Result := FRFCOMMChannel.isOpen
  else
    Result := False;
end;

function TMacBluetoothSocket.GetRemoteDevice: TBluetoothDevice;
begin
  Result := TMacBluetoothDevice.Create(FRFCOMMChannel.getDevice);
end;
{$ENDIF !BLUETOOTH_CLASSIC}

// ------------------------------------------------------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------------------------------ //

{$If defined(BLUETOOTH_LE)}

{ TInternalTimer }

function TInternalTimer.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(InternalTimer);
end;

procedure TInternalTimer.SetNotifyEvent(AnEvent: TNotifyEvent);
begin
  FEvent := AnEvent;
end;

procedure TInternalTimer.timerEvent;
begin
  if Assigned(FEvent) then
    FEvent(self);
end;

{ TPlatformBluetoothLEManager }

class function TPlatformBluetoothLEManager.GetBluetoothManager: TBluetoothLEManager;
begin
  Result := TMacBluetoothLEManager.Create;
end;

{ TMacBluetoothLEAdapter }

constructor TMacBluetoothLEAdapter.Create(const AManager: TBluetoothLEManager);
begin
  inherited;
  FLEManager := TInternalBluetoothLEManager.Create;
  FLEManager.OnDeviceDiscovered := DeviceDiscovered;
  FLEManager.OnDeviceDiscoveryTimeout := DeviceDiscoveryTimeout;
  FLEManager.OnDeviceConnect := DeviceConnect;
  FLEManager.OnDeviceDisconnect := DeviceDisconnect;
  FManager := AManager;
end;

destructor TMacBluetoothLEAdapter.Destroy;
begin
  FLEManager.Free;
  inherited;
end;

procedure TMacBluetoothLEAdapter.DeviceDiscovered(Sender: TObject; const ADevice: CBPeripheral;
  const AData: NSDictionary; RSSI: Integer);

  type
    TCBUUIDNSDataArray = array of NSData;
    TServicesData = TDictionary<CBUUID, TBytes>;

  procedure AdvertiseDataToTScanResponse(const AdvertiseData: NSDictionary; var AResponseData: TScanResponse;
    var AAdvertiseData: TBluetoothLEAdvertiseData);

    function GetBytesFromNsData(const LData: NSData; var AData: TBytes): Integer; inline;
    begin
      Result := LData.length;
      SetLength(AData, Result);
      LData.getBytes(@AData[0], Result);
    end;

    procedure AppendBytes(ALength: Integer; const ASource: TBytes; const ADestiny: TScanResponseKey);
    var
      LDataBytesExtra: TBytes;
    begin
      if AResponseData.ContainsKey(ADestiny) then
      begin
        LDataBytesExtra := AResponseData.Items[ADestiny];
        SetLength(LDataBytesExtra, Length(LDataBytesExtra) + ALength);
        Move(ASource[0], LDataBytesExtra[Length(LDataBytesExtra) - ALength], ALength);
        AResponseData.AddOrSetValue(ADestiny, LDataBytesExtra);
      end
      else
        AResponseData.AddOrSetValue(ADestiny, ASource);
    end;

    procedure GetBytesFromNSNumber(const LData: NSNumber; var AData: TBytes); inline;
    begin
      SetLength(AData, 1);
      AData[0] := Byte(LData.charValue);
    end;

    procedure AppendBytesToKeys(ASize: Integer; const AData: TBytes; const ACond1, ACond2, ACond3: TScanResponseKey);
    begin
      if ASize = 2 then
        AppendBytes(Length(AData), AData, ACond1)
      else if ASize = 4 then
        AppendBytes(Length(AData), AData, ACond2)
      else
        AppendBytes(Length(AData), AData, ACond3)
    end;

    procedure GetServicesData(const ADictionary: NSDictionary; var ServicesData: TServicesData);
    var
      I: Integer;
      LPointer: Pointer;
      LCBUUIDData: CBUUID;
      LDataBytes: TBytes;
    begin
      for I := 0 to ADictionary.count - 1 do
      begin
        LPointer := ADictionary.allKeys.objectAtIndex(I);
        if LPointer <> nil then
        begin
          LCBUUIDData := TCBUUID.Wrap(LPointer);
          LPointer := ADictionary.allValues.objectAtIndex(I);
          if LPointer <> nil then
            GetBytesFromNsData(TNSData.Wrap(LPointer), LDataBytes)
          else
            SetLength(LDataBytes, 0);
          ServicesData.Add(LCBUUIDData, LDataBytes);
        end;
      end;
    end;

    procedure AddDictionaryDataFor(const AServicesData: TServicesData; const ACond1, ACond2, ACond3: TScanResponseKey);
    var
      LDataBytes: TBytes;
      LSize: Integer;
      LPair: TPair<CBUUID, TBytes>;
    begin
      for LPair in AServicesData do
      begin
        LSize := GetBytesFromNsData(LPair.Key.data, LDataBytes);
        SetLength(LDataBytes, Length(LDataBytes) + Length(LPair.Value));
        Move(LPair.Value[0], LDataBytes[LSize], Length(LPair.Value));
        AppendBytesToKeys(LSize, LDataBytes, ACond1, ACond2, ACond3);
      end;
    end;

    function GetCBUUIDsBytes(const AArrayData: NSArray): TCBUUIDNSDataArray;
    var
      I: Integer;
      LArrayItem: Pointer;
      LCBUUIDData: CBUUID;
    begin
      SetLength(Result, 0);
      if AArrayData.count > 0 then
        for I := 0 to AArrayData.count - 1 do
        begin
          LArrayItem := AArrayData.objectAtIndex(I);
          if LArrayItem <> nil then
          begin
            SetLength(Result, Length(Result) + 1);
            LCBUUIDData := TCBUUID.Wrap(LArrayItem);
            Result[Length(Result)-1] := LCBUUIDData.data;
          end;
        end;
    end;

    procedure AddArrayDataFor(const AArrayData: TCBUUIDNSDataArray; const ACond1, ACond2, ACond3: TScanResponseKey);
    var
      LSize, I: Integer;
      LDataBytes: TBytes;
    begin
      for I := 0 to Length(AArrayData) - 1 do
      begin
        LSize := GetBytesFromNsData(AArrayData[I], LDataBytes);
        AppendBytesToKeys(LSize, LDataBytes, ACond1, ACond2, ACond3);
      end;
    end;

  var
    LPointer: Pointer;
    LDataBytes: TBytes;
    LLocalName: string;
    LNSTxValue: NSNumber;
    LCBUUIDsBytes: TCBUUIDNSDataArray;
    LServicesData: TServicesData;
    LPair: TPair<CBUUID, TBytes>;
    LGUID: TGUID;
    I: Integer;
  begin
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataManufacturerDataKey);
    if LPointer <> nil then
    begin
      if GetBytesFromNsData(TNSData.Wrap(LPointer), LDataBytes) > 0 then
      begin
        AResponseData.Add(TScanREsponseKey.ManufacturerSpecificData, LDataBytes);
        AAdvertiseData.ManufacturerSpecificData := LDataBytes;
      end;
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataLocalNameKey);
    if LPointer <> nil then
    begin
      LLocalName := NSStrToStr(TNSString.Wrap(LPointer));
      LDataBytes := TEncoding.UTF8.GetBytes(LLocalName);
      AResponseData.Add(TScanREsponseKey.CompleteLocalName, LDataBytes);
      AAdvertiseData.LocalName := LLocalName;
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataServiceDataKey);
    if LPointer <> nil then
    begin
      LServicesData := TServicesData.Create;
      try
        GetServicesData(TNSDictionary.Wrap(LPointer), LServicesData);
        AddDictionaryDataFor(LServicesData, TScanREsponseKey.ServiceData16b, TScanREsponseKey.ServiceData32b,
            TScanREsponseKey.ServiceData128b);
        for LPair in LServicesData do
        begin
          LGUID := NSDataToGUID(LPair.Key.data);
          AAdvertiseData.AddServiceData(LGUID, LPair.Value);
        end;
      finally
        LServicesData.Free;
      end;
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataServiceUUIDsKey);
    if LPointer <> nil then
    begin
      LCBUUIDsBytes := GetCBUUIDsBytes(TNSArray.Wrap(LPointer));
      AddArrayDataFor(LCBUUIDsBytes, TScanREsponseKey.CompleteList16SCUUID, TScanREsponseKey.CompleteList32SCUUID,
          TScanREsponseKey.CompleteList128SCUUID);

      for I := 0 to Length(LCBUUIDsBytes) - 1 do
        AAdvertiseData.AddServiceUUID(NSDataToGUID(LCBUUIDsBytes[I]));
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataOverflowServiceUUIDsKey);
    if LPointer <> nil then
    begin
      LCBUUIDsBytes := GetCBUUIDsBytes(TNSArray.Wrap(LPointer));
      AddArrayDataFor(LCBUUIDsBytes, TScanREsponseKey.IncompleteList16SCUUID, TScanREsponseKey.IncompleteList32SCUUID,
          TScanREsponseKey.IncompleteList128SCUUID);
      for I := 0 to Length(LCBUUIDsBytes) - 1 do
        AAdvertiseData.AddServiceUUID(NSDataToGUID(LCBUUIDsBytes[I]));
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataTxPowerLevelKey);
    if LPointer <> nil then
    begin
      LNSTxValue := TNSNumber.Wrap(LPointer);
      GetBytesFromNSNumber(LNSTxValue, LDataBytes);
      AResponseData.Add(TScanREsponseKey.TxPowerLevel, LDataBytes);
      AAdvertiseData.TxPowerLevel := LNSTxValue.intValue;
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataIsConnectable);
    if LPointer <> nil then
    begin
      GetBytesFromNSNumber(TNSNumber.Wrap(LPointer), LDataBytes);
      AResponseData.Add(TScanREsponseKey.Flags, LDataBytes); //Check if this corresponds to flags
    end;
    LPointer := AdvertiseData.valueForKey(CBAdvertisementDataSolicitedServiceUUIDsKey);
    if LPointer <> nil then
    begin
      LCBUUIDsBytes := GetCBUUIDsBytes(TNSArray.Wrap(LPointer));
      AddArrayDataFor(LCBUUIDsBytes, TScanREsponseKey.List16bServiceSolicitationUUIDs, TScanREsponseKey.List32bServiceSolicitationUUIDs,
          TScanREsponseKey.List128bServiceSolicitationUUIDs);
    end;
  end;

var
  LEDevice: TMacBluetoothLEDevice;
  LEManager: TMacBluetoothLEManager;
  UUID: TGUID;
  LResponseData: TScanResponse;
  LGattServerName: string;
  LNew: Boolean;
  LDiscovered: Boolean;
begin
  if AData.valueForKey(CBAdvertisementDataLocalNameKey) <> nil then
    LGattServerName := NSStrToStr(TNSString.wrap(AData.valueForKey(CBAdvertisementDataLocalNameKey)))
  else
    LGattServerName := '';

  LEManager := TMacBluetoothLEManager(FManager);
  LNew := False;
  UUID := LEManager.GetDeviceIdentifier(ADevice);
  if UUID <> GUID_NULL then
  begin
    LEDevice := TMacBluetoothLEDevice(TMAcBluetoothLEManager.GetDeviceInList(UUID.ToString, LEManager.FDiscoveredLEDevices));
    if LEDevice = nil then
    begin
      LEDevice := TMacBluetoothLEDevice.Create(False, ADevice, FLEManager, LGattServerName);
      LNew := True;
    end;

    LDiscovered := True;

      LResponseData := TScanResponse.Create;
      AdvertiseDataToTScanResponse(AData, LResponseData, LEDevice.FScannedAdvertiseData);
      LEDevice.FAdvertisedData := LResponseData;
      LEDevice.FLastRSSI := rssi;

      if LNew and (FBluetoothLEScanFilterList <> nil) then
        if not DoDeviceOvercomesFilters(LEDevice, FBluetoothLEScanFilterList) then
        begin
          LDiscovered := False;
          LNew := False;
        end;

      if LNew then
        LEManager.AddDiscoveredDevice(LEDevice);
      if LDiscovered then
        TMacBluetoothLEManager(FManager).DoDiscoverDevice(Self, LEDevice, rssi, LResponseData);
  end;
end;

function TMacBluetoothLEAdapter.GetLEDevice(const ADevice: CBPeripheral): TBluetoothLEDevice;
var
  I: Integer;
  LEDevice: TMacBluetoothLEDevice;
  UUID: TGUID;
begin
  Result := nil;
  UUID := TMacBluetoothLEManager(FManager).GetDeviceIdentifier(ADevice);
  if UUID <> GUID_NULL then
    for I := 0 to FManager.LastDiscoveredDevices.Count - 1 do
    begin
      LEDevice := TMacBluetoothLEDevice(FManager.LastDiscoveredDevices[I]);
      if UUID = TMacBluetoothLEManager(FManager).GetDeviceIdentifier(LEDevice.FDevice.FDevice) then
      begin
        Result := FManager.LastDiscoveredDevices[I];
        Break;
      end;
    end;
end;

procedure TMacBluetoothLEAdapter.DeviceConnect(Sender: TObject; const ADevice: CBPeripheral);
var
  LDevice: TBluetoothLEDevice;
begin
  LDevice := GetLEDevice(ADevice);
  if (LDevice <> nil) and Assigned(LDevice.OnConnect) then
    LDevice.OnConnect(LDevice);
end;

procedure TMacBluetoothLEAdapter.DeviceDisconnect(Sender: TObject; const ADevice: CBPeripheral);
var
  LDevice: TBluetoothLEDevice;
begin
  LDevice := GetLEDevice(ADevice);
  if (LDevice <> nil) then
  begin
    TMacBluetoothLEDevice(LDevice).FUpdateServices := True;
    if Assigned(LDevice.OnDisconnect) then
      LDevice.OnDisconnect(LDevice);
  end;
end;

procedure TMacBluetoothLEAdapter.DeviceDiscoveryTimeout(Sender: TObject);
begin
  TMacBluetoothLEManager(FManager).DoDiscoveryEnd(Self, TMacBluetoothLEManager(FManager).FDiscoveredLEDevices);
end;

procedure TMacBluetoothLEAdapter.DoCancelDiscovery;
begin
  FLEManager.StopDiscovery;
end;

function TMacBluetoothLEAdapter.GetAdapterName: string;
begin
  { Not supported on Mac / iOS }
  Result := '';
end;

function TMacBluetoothLEAdapter.GetAddress: TBluetoothMacAddress;
begin
  { Not supported on Mac / iOS }
  Result := '';
end;

function TMacBluetoothLEAdapter.GetScanMode: TBluetoothScanMode;
begin
  Result := Default(TBluetoothScanMode);
end;

function TMacBluetoothLEAdapter.GetState: TBluetoothAdapterState;
begin
  Result := Default(TBluetoothAdapterState);
end;

procedure TMacBluetoothLEAdapter.SetAdapterName(const Value: string);
begin
  { Not supported on Mac }
end;

function UUIDListToNsArray(const FilterUUIDList: TBluetoothUUIDsList): NSMutableArray;
var
  LItem: CBUUID;
  I: Integer;
  LStrGUID: string;
begin
  if FilterUUIDList <> nil then
  begin
    Result := TNSMutableArray.Wrap(TNSMutableArray.Alloc.init);
    for I:= 0 to FilterUUIDList.Count - 1 do
    begin
      LStrGUID := FilterUUIDList[I].ToString;
      LStrGUID := LStrGUID.Substring(1, LStrGUID.Length - 2);
      LItem := TCBUUID.OCClass.UUIDWithString(StrToNSStr(LStrGUID));
      Result.addObject((LItem as ILocalObject).GetObjectID );
    end;
  end
  else
    Result := nil;
end;

function TMacBluetoothLEAdapter.DoStartDiscovery(ATimeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList;
  const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;
var
  I: Integer;
  LFilterUUIDList: TBluetoothUUIDsList;
begin
  LFilterUUIDList := nil;
  if AFilterUUIDList <> nil then
  begin
    TMacBluetoothLEManager.ClearDevicesFromList(FManager.LastDiscoveredDevices);
    FLEManager.StartDiscovery(ATimeout, AFilterUUIDList);
    Result := True;
  end
  else
  begin
    if ABluetoothLEScanFilterList <> nil then
    begin
      for I := 0 to ABluetoothLEScanFilterList.Count - 1 do
      begin
        if ABluetoothLEScanFilterList[I].ServiceUUID <> TGUID.Empty then
        begin
          if LFilterUUIDList = nil then
            LFilterUUIDList := TBluetoothUUIDsList.Create;
          LFilterUUIDList.Add(ABluetoothLEScanFilterList[I].ServiceUUID);
        end;

        if ABluetoothLEScanFilterList[I].ManufacturerSpecificData <> nil then
        begin
          LFilterUUIDList := nil;
          Break;
        end;
        if (ABluetoothLEScanFilterList[I].ServiceData.key <> TGUID.Empty) and
          (ABluetoothLEScanFilterList[I].ServiceUUID <> ABluetoothLEScanFilterList[I].ServiceData.key) then
        begin
          LFilterUUIDList := nil;
          Break;
        end;
      end;
    end;
    TMacBluetoothLEManager.ClearDevicesFromList(FManager.LastDiscoveredDevices);
    FBluetoothLEScanFilterList := ABluetoothLEScanFilterList;
    FLEManager.StartDiscovery(ATimeout, LFilterUUIDList);
    Result := True;
  end;
end;

function TMacBluetoothLEAdapter.DoStartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList; Refresh: Boolean): Boolean;
var
  I: Integer;
  F: Integer;
  FilterUUIDList: TBluetoothUUIDsList;
  LNumber: NSNumber;
  LFound: Boolean;
begin
  FilterUUIDList := nil;
  if FLEManager.FScanOptions = nil then
  begin
    FLEManager.FScanOptions := TNSMutableDictionary.Create;
    LNumber := TNSNumber.Wrap(TNSNumber.OCClass.numberWithUnsignedChar(0));
    FLEManager.FScanOptions.setValue((LNumber as ILocalObject).GetObjectID, CBCentralManagerScanOptionAllowDuplicatesKey);
  end;

  if FLEManager.FCentralManager.state = CBCentralManagerStatePoweredOn then
  begin

   if Refresh and (ABluetoothLEScanFilterList <> nil) then
    begin
      for I := 0 to ABluetoothLEScanFilterList.Count - 1 do
      begin
        if ABluetoothLEScanFilterList[I].ServiceUUID <> TGUID.Empty then
        begin
          LFound := False;
          if FilterUUIDList = nil then
            FilterUUIDList := TBluetoothUUIDsList.Create;
          for F := 0 to FilterUUIDList.Count - 1 do
            if FilterUUIDList[F] = ABluetoothLEScanFilterList[I].ServiceUUID then
            begin
              LFound := True;
              Break;
            end;
          if Not LFound then
            FilterUUIDList.Add(ABluetoothLEScanFilterList[I].ServiceUUID);
        end;

        if ABluetoothLEScanFilterList[I].ManufacturerSpecificData <> nil then
        begin
          FilterUUIDList := nil;
          Break;
        end;

        if (ABluetoothLEScanFilterList[I].ServiceData.key <> TGUID.Empty) and
          (ABluetoothLEScanFilterList[I].ServiceUUID <> ABluetoothLEScanFilterList[I].ServiceData.key) then
        begin
          FilterUUIDList := nil;
          Break;
        end;

      end;
      FLEManager.FFilterUUIDList := UUIDListToNsArray(FilterUUIDList);
      FBluetoothLEScanFilterList := ABluetoothLEScanFilterList;
    end;

    FLEManager.FWaitingToDiscover := False;
    FLEManager.FCentralManager.scanForPeripheralsWithServices(FLEManager.FFilterUUIDList, FLEManager.FScanOptions);
    FLEManager.FIsDiscovering := True;
  end
  else
  begin
    FLEManager.FWaitingToDiscover := True;
  end;
  Result := True;
end;

{ TMacBluetoothGattServer }

function PropertiesToInteger(AProperties: TBluetoothPropertyFlags): Integer;
begin
  Result := 0;
  if TBluetoothProperty.Broadcast in AProperties then
    Result := Result or CBCharacteristicPropertyBroadcast;
  if TBluetoothProperty.ExtendedProps in AProperties then
    Result := Result or CBCharacteristicPropertyExtendedProperties;
  if TBluetoothProperty.Notify in AProperties then
    Result := Result or CBCharacteristicPropertyNotify;
  if TBluetoothProperty.Indicate in AProperties then
    Result := Result or CBCharacteristicPropertyIndicate;
  if TBluetoothProperty.Read in AProperties then
    Result := Result or CBCharacteristicPropertyRead;
  if TBluetoothProperty.Write in AProperties then
    Result := Result or CBCharacteristicPropertyWrite;
  if TBluetoothProperty.WriteNoResponse in AProperties then
    Result := Result or CBCharacteristicPropertyWriteWithoutResponse;
  if TBluetoothProperty.SignedWrite in AProperties then
    Result := Result or CBCharacteristicPropertyAuthenticatedSignedWrites;
end;

function TMacBluetoothGattServer.DoCreateCharacteristic(const AService: TBluetoothGattService;
  const AnUUID: TBluetoothUUID; const AProps: TBluetoothPropertyFlags;
  const ADescription: string): TBluetoothGattCharacteristic;
begin
  Result := TMacBluetoothGattService(AService).CreateCharacteristic(AnUUID, AProps, ADescription);
end;

function TMacBluetoothGattServer.DoCreateDescriptor(const ACharacteristic: TBluetoothGattCharacteristic;
  const AnUUID: TBluetoothUUID): TBluetoothGattDescriptor;
begin
  { On Mac/iOS this is useless since you can just create User Description and Characteristic Format string, }
  { and user description is managed. }
  Result := nil;
end;

function TMacBluetoothGattServer.DoCreateIncludedService(const AService: TBluetoothGattService;
  const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
begin
  Result := TMacBluetoothGattService(AService).CreateIncludedService(AnUUID, AType);
end;

function TMacBluetoothGattServer.DoCreateAdvertiseData: TBluetoothLEAdvertiseData;
begin
  Result := TMacBluetoothLEAdvertiseData.Create;
end;

function TMacBluetoothGattServer.DoCreateService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
var
  LMacService: CBMutableService;
  LUUID: CBUUID;
  LStrGUID: string;
begin
  LStrGUID := GUIDToString(AnUUID);
  LStrGUID := LStrGUID.Substring(1, LStrGUID.Length - 2);
  LUUID := TCBUUID.OCClass.UUIDWithString(StrToNSStr(LStrGUID));
  LMacService := TCBMutableService.Wrap(TCBMutableService.Alloc.initWithType(LUUID, AType = TBluetoothServiceType.Primary));
  Result := TMacBluetoothGattService.Create(AnUUID, TBluetoothServiceType.Primary, LMacService, FGattServer);
end;

constructor TMacBluetoothGattServer.Create(const AManager: TBluetoothLEManager);
begin
  inherited;
  FGattServer := TMacBluetoothLEGattServerManager.Create(Self);
  FGattServer.OnReceiveReadRequest := OnReceiveReadRequest;
  FGattServer.OnReceiveWriteRequest := OnReceiveWriteRequests;
  FGattServer.OnSubscribeClient := OnSubscribeClient;
  FGattServer.OnUnsubscribeClient := OnUnsubscribeClient;
end;

destructor TMacBluetoothGattServer.Destroy;
begin
  if IsAdvertising then
    StopAdvertising;
  FGattServer.Free;
  FGattServer := nil;
  inherited;
end;

function TMacBluetoothGattServer.DoAddCharacteristic(const AService: TBluetoothGattService;
  const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  Result := True;
end;

function TMacBluetoothGattServer.DoAddService(const AService: TBluetoothGattService): Boolean;
var
  LTotal: Single;
begin
  inherited;
  if FGattServer.FGattServer.state <> CBPeripheralManagerStatePoweredOn then
  begin
    LTotal := 0;
    repeat
      LTotal := LTotal + 0.05;
      InternalWaitMessage(0.05);
    until (FGattServer.GattServerOn) or (LTotal >= 5);
  end;

  FGattServer.FGattServer.addService((AService as TMacBluetoothGattService).FMutableService);
  if FGattServer.GattServerOn then
    Result := True
  else
    Result := False;
end;

procedure TMacBluetoothGattServer.DoCharacteristicReadRequest(const ADevice: TBluetoothLEDevice; ARequestId,
  AnOffset: Integer; const AGattCharacteristic: TBluetoothGattCharacteristic);
var
  LGattStatus: TBluetoothGattStatus;
begin
  DoOnCharacteristicRead(Self, AGattCharacteristic, LGattStatus);
end;

procedure TMacBluetoothGattServer.DoCharacteristicWriteRequest(const ADevice: TBluetoothLEDevice; ARequestId: Integer;
  const AGattCharacteristic: TBluetoothGattCharacteristic; APreparedWrite, AResponseNeeded: Boolean; AnOffset: Integer;
  const AValue: TBytes);
var
  LGattStatus: TBluetoothGattStatus;
begin
  DoOnCharacteristicWrite(ADevice, AGattCharacteristic, LGattStatus, AValue);
end;

procedure TMacBluetoothGattServer.DoClearServices;
begin
  inherited;
  FGattServer.RemoveAllServices;
  FServices.Clear;
end;

procedure TMacBluetoothGattServer.DoClose;
begin
  inherited;
  DoClearServices;
end;

function TMacBluetoothGattServer.DoGetServices: TBluetoothGattServiceList;
begin
  Result := FServices;
end;

procedure TMacBluetoothGattServer.DoServiceAdded(AStatus: TBluetoothGattStatus; const AService: TBluetoothGattService);
begin
  DoOnServiceAdded(Self, AService, AStatus);
end;

procedure TMacBluetoothGattServer.DoStopAdvertising;
begin
  if IsAdvertising then
    FGattServer.FGattServer.stopAdvertising;
end;

function TMacBluetoothGattServer.DoIsAdvertising: Boolean;
begin
  if FGattServer <> nil then
    Result := FGattServer.FGattServer.isAdvertising
  else
    Result := False;
end;

procedure TMacBluetoothGattServer.GetServiceAdvertiseDictionary(var AServiceAdvertiseDictionary: NSMutableDictionary);
  procedure GetServicesGUIDArray(const AServicesUUIDList: TArray<TBluetoothUUID>; var NSServicesGUIDArray: NSMutableArray);
  var
    LServUUID: TBluetoothUUID;
    LStrGUID: string;
    LUUID: CBUUID;
  begin
    // Service UUID's advertising limits: Up to 1 128bit + 4 16bit UUIDs service OR up to 13 16bit UUIDs service
    for LServUUID in AServicesUUIDList do
    begin
      if TBluetoothUUIDHelper.IsBluetoothBaseUUIDBased(LServUUID) then
        LStrGUID := TBluetoothUUIDHelper.GetBluetooth16bitsUUID(LServUUID).ToHexString
      else
        LStrGUID := GUIDToString(LServUUID).Substring(1, 36);
      LUUID := TCBUUID.OCClass.UUIDWithString(StrToNSStr(LStrGUID));
      NSServicesGUIDArray.addObject((LUUID as ILocalObject).GetObjectID);
    end;

  end;
var
  NSStringConst: NSString;
  NSStringConstName: NSString;
  LName: NSString;
  LAdvName: string;
  NSServicesGUIDArray: NSMutableArray;
begin
  NSStringConst := CBAdvertisementDataServiceUUIDsKey;
  NSStringConstName := CBAdvertisementDataLocalNameKey;
  NSServicesGUIDArray := TNSMutableArray.Create;
  try
    GetServicesGUIDArray(AdvertiseData.ServiceUUIDs, NSServicesGUIDArray);
    if NSServicesGUIDArray.count > 0 then
      AServiceAdvertiseDictionary.setValue(TNSArray.OCClass.arrayWithArray(NSServicesGUIDArray), NSStringConst);
  finally
    NSServicesGUIDArray.release;
  end;
  LAdvName := AdvertiseData.LocalName;
  if LAdvName = '' then
    LAdvName := 'Bluetooth LE Service' // Do not translate
  else
    // Maximum 29 bytes
    if Length(LAdvName) > 29 then
      LAdvName := LAdvName.Substring(0, 29);
  LName := StrToNSStr(LAdvName);
  AServiceAdvertiseDictionary.setValue((LName as ILocalObject).GetObjectID, NSStringConstName);
end;

procedure TMacBluetoothGattServer.DoStartAdvertising;
const
  BeaconKey = 'kCBAdvDataAppleBeaconKey';
  BEACON_PREFIX: TBytes = [$4C, $00, $02, $15];
  BEACON_ADV_LENGTH = 21;
  BEACON_ADV_MAJOR_POSITION = 16;
  BEACON_ADV_MINOR_POSITION = 18;

  function IsABeacon(AManufacturerData: TBytes): Boolean;
  begin
    Result := (Length(AManufacturerData) = BEACON_ADV_LENGTH + Length(BEACON_PREFIX)) and
      CompareMem(AManufacturerData, BEACON_PREFIX, Length(BEACON_PREFIX));
  end;

var
  LNSAdvertiseDictionary: NSMutableDictionary;
  LManData: TBytes;
  LBeaconAdvertiseData: TBytes;
  LNSBeaconKey: NSString;
  LNSBeaconData: NSData;
begin
  LNSAdvertiseDictionary := TNSMutableDictionary.Create;
  try
    LManData := AdvertiseData.ManufacturerSpecificData;
    if IsABeacon(LManData) then
    begin
      LNSBeaconKey := StrToNSStr(BeaconKey);
      SetLength(LBeaconAdvertiseData, BEACON_ADV_LENGTH);
      Move(LManData[Length(BEACON_PREFIX)], LBeaconAdvertiseData[0], BEACON_ADV_LENGTH);
      LNSBeaconData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@LBeaconAdvertiseData[0], Length(LBeaconAdvertiseData)));
      LNSAdvertiseDictionary.setValue((LNSBeaconData as ILocalObject).GetObjectID, LNSBeaconKey);
{$IFDEF IOS}
      if AdvertiseData.LocalName <> '' then
        GetServiceAdvertiseDictionary(LNSAdvertiseDictionary);
{$ENDIF}
    end
    else
      GetServiceAdvertiseDictionary(LNSAdvertiseDictionary);

    StartAdvertisingData(LNSAdvertiseDictionary);
  finally
    LNSAdvertiseDictionary.release;
  end;
end;

function TMacBluetoothGattServer.StartAdvertisingData(const ADict: NSMutableDictionary): Boolean;
var
  LTotal: Single;
begin
  if IsAdvertising then
    StopAdvertising;

  if FGattServer.FGattServer.state <> CBPeripheralManagerStatePoweredOn then
  begin
    LTotal := 0;
    repeat
      LTotal := LTotal + 0.05;
      InternalWaitMessage(0.05);
    until (FGattServer.GattServerOn) or (LTotal >= 5);
  end;

  FGattServer.FGattServer.startAdvertising(ADict);

  if FGattServer.GattServerOn then
    Result := True
  else
    Result := False;
end;

procedure TMacBluetoothGattServer.DoUpdateCharacteristicValue(const ACharacteristic: TBluetoothGattCharacteristic);
var
  LCharacteristic: CBMutableCharacteristic;
begin
  LCharacteristic := TCBMutableCharacteristic.Wrap(((ACharacteristic as TMacBluetoothGattCharacteristic).
    FCharacteristic as ILocalObject).GetObjectID);
//  LCharacteristic := TCBMutableCharacteristic.Wrap((ACharacteristic as TMacBluetoothGattCharacteristic).FCharacteristic);
  FGattServer.UpdateCharacteristicValue(LCharacteristic, ACharacteristic.Value);
end;

function TMacBluetoothGattServer.FindCharacteristic(
  const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
var
  I: Integer;
  LChar: TBluetoothGattCharacteristic;
  LGUID: TGUID;
begin
  LGUID := UUIDToGUID(ACharacteristic.UUID.data.bytes);
  for I := 0 to FServices.Count - 1 do
  begin
    LChar := FServices[I].GetCharacteristic(LGUID);
    if LChar <> nil then
      Exit(LChar);
  end;
  Result := nil;
end;

procedure TMacBluetoothGattServer.OnReceiveReadRequest(Sender: TObject; const Peripheral: CBPeripheralManager;
  const Request: CBATTRequest);
var
  LData: NSData;
  LCharacteristic: TBluetoothGattCharacteristic;
  LBytes: TBytes;
  LOffset: Integer;
  LTotal: Integer;
begin
  LCharacteristic := FindCharacteristic(Request.characteristic);
  LOffset := Request.offset;
  { Read event must be fired just one time }
  if LOffset = 0 then
    DoCharacteristicReadRequest(nil, 0, Request.offset, LCharacteristic);
  LBytes := LCharacteristic.Value;
  LTotal := Length(LBytes);
  if LOffset <= LTotal then
  begin
    if (LTotal = 0) or (LOffset = LTotal) then
      LData := TNSData.Wrap(TNSData.Alloc.initWithBytes(nil, 0))
    else
      LData := TNSData.Wrap(TNSData.Alloc.initWithBytes(@LBytes[LOffset], LTotal - LOffset));
    Request.setValue(LData);
    Peripheral.respondToRequest(Request, CBATTErrorSuccess);
  end
  else
    Peripheral.respondToRequest(Request, CBATTErrorInvalidOffset);
end;

procedure TMacBluetoothGattServer.OnReceiveWriteRequests(Sender: TObject; const Peripheral: CBPeripheralManager;
  const Requests: NSArray);
var
  LCharacteristic: TBluetoothGattCharacteristic;
  LMutableChar: CBMutableCharacteristic;
  I: Integer;
  LRequest: CBATTRequest;
  LNewValue: TBytes;
  LSource: Pointer;
  LTotal: Integer;
  LOffset: Integer;
  LValue: TBytes;
  LData: NSData;
begin
  LMutableChar := nil;
  LCharacteristic := nil;
  for I := 0 to Requests.count - 1 do
  begin
    LRequest := TCBATTRequest.Wrap(Requests.objectAtIndex(I));
    if I = 0 then
    begin
      LCharacteristic := FindCharacteristic(LRequest.characteristic);
      LMutableChar := TCBMutableCharacteristic.Wrap(((LCharacteristic as TMacBluetoothGattCharacteristic).
        FCharacteristic as ILocalObject).GetObjectID);
    end;
    LTotal := LRequest.value.length;
    SetLength(LNewValue, LTotal);
    LSource := LRequest.value.bytes;
    if LTotal > 0 then
      Move(LSource^, LNewValue[0], LTotal);
    LOffset := LRequest.offset;
    LValue := LCharacteristic.Value;
    SetLength(LValue, LOffset + LTotal);
    if LTotal > 0 then
      Move(LNewValue[0], LValue[LOffset], LTotal);
    LCharacteristic.Value := LValue;
  end;

  if LMutableChar <> nil then
  begin
    if Length(LValue) = 0 then
      LData := TNSData.Wrap(TNSData.Alloc.initWithBytes(nil, 0))
    else
      LData := TNSData.Wrap(TNSData.Alloc.initWithBytes(@LValue[0], Length(LValue)));
    LMutableChar.setValue(LData);
    DoCharacteristicWriteRequest(nil, 0, LCharacteristic, False, True, LRequest.offset, LValue);
    Peripheral.respondToRequest(TCBATTRequest.Wrap(Requests.objectAtIndex(0)), CBATTErrorSuccess);
  end
  else
    Peripheral.respondToRequest(TCBATTRequest.Wrap(Requests.objectAtIndex(0)), CBATTErrorRequestNotSupported);
end;

procedure TMacBluetoothGattServer.OnSubscribeClient(Sender: TObject; const ClientId: string; const ACharacteristic: CBCharacteristic);
begin
  DoOnClientSubscribed(Sender, ClientId, FindCharacteristic(ACharacteristic) );
end;

procedure TMacBluetoothGattServer.OnUnsubscribeClient(Sender: TObject; const ClientId: string; const ACharacteristic: CBCharacteristic);
begin
  DoOnClientUnsubscribed(Sender, ClientId, FindCharacteristic(ACharacteristic) );
end;

{ TMacBluetoothLEDevice }

function TMacBluetoothLEDevice.CheckConnection: Boolean;
begin
  if FDevice = nil then
    raise EBluetoothLEDeviceException.Create(SBluetoothLEGetDeviceError);
  if not FDevice.GetConnected then
  begin
    Result := FLEManager.ConnectTo(FDevice.FDevice);
  end
  else
    Result := True;

  if Result and UpdateOnReconnect and FUpdateServices then
    UpdateServices;
end;

constructor TMacBluetoothLEDevice.Create(AutoConnect: Boolean; const APeripheral: CBPeripheral;
  const AManager: TInternalBluetoothLEManager; const AGattServerName: string);
begin
  inherited Create(AutoConnect);
  FServices := TBluetoothGattServiceList.Create;
  FDevice := TMacBluetoothLEPeripheral.Create(APeripheral, AGattServerName);
  FDevice.FLEDevice := Self;
  FDevice.OnDiscoveredServices := DiscoveredSevices;
  FDevice.OnDidReadCharacteristicValue := DidReadCharacteristicValue;
  FDevice.OnDidWriteCharacteristicValue := DidWriteCharacteristicValue;
  FDevice.OnUpdatedRssiValue := DidReadRssi;
  FDevice.OnReadDescriptorValue := DidReadDescriptorValue;
  FDevice.OnWriteDescriptorValue := DidWriteDescriptorValue;
  FLEManager := AManager;
end;

destructor TMacBluetoothLEDevice.Destroy;
begin
  if GetIsConnected then
    DoDisconnect;
  FDevice.Free;
  inherited;
end;

procedure TMacBluetoothLEDevice.DidReadCharacteristicValue(Sender: TObject; ACharacteristic: CBCharacteristic;
  Error: Integer);
var
  LCharacteristic: TBluetoothGattCharacteristic;
  LValue: TBytes;
begin
  LCharacteristic := FindCharacteristic(ACharacteristic);
  if LCharacteristic = nil then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLECanNotFindCharacteristic,
       [UUIDToGUID(ACharacteristic.UUID.data.bytes).ToString]);

  if TBluetoothGattStatus(Error) = TBluetoothGattStatus.Success then
  begin
    if (ACharacteristic.value <> nil) and (ACharacteristic.value.length > 0) then
    begin
      SetLength(LValue, ACharacteristic.value.length);
      ACharacteristic.value.getBytes(@LValue[0]);
    end
    else
      SetLength(LValue, 0);
    LCharacteristic.SetValue(LValue);
  end;

  DoOnCharacteristicRead(LCharacteristic, TBluetoothGattStatus(Error));
end;

procedure TMacBluetoothLEDevice.DidReadDescriptorValue(const Sender: TObject; const ADescriptor: CBDescriptor;
  Error: Integer);
var
  LDescriptor: TBluetoothGattDescriptor;
begin
  LDescriptor := FindDescriptor(ADescriptor);
  if LDescriptor = nil then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLECanNotFindDescriptor,
       [UUIDToGUID(ADescriptor.UUID.data.bytes).ToString]);
  DoOnDescriptorRead(LDescriptor, TBluetoothGattStatus(Error));
end;

procedure TMacBluetoothLEDevice.DidReadRssi(const Sender: TObject; ARssiValue: Integer;
  AGattStatus: TBluetoothGattStatus);
begin
  FLastRSSI := ARssiValue;
  DoOnReadRssi(Sender, ARssiValue, AGattStatus);
end;

procedure TMacBluetoothLEDevice.DidWriteCharacteristicValue(Sender: TObject; ACharacteristic: CBCharacteristic;
  Error: Integer);
var
  LCharacteristic: TBluetoothGattCharacteristic;
begin
  LCharacteristic := FindCharacteristic(ACharacteristic);
  if LCharacteristic = nil then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLECanNotFindCharacteristic,
       [UUIDToGUID(ACharacteristic.UUID.data.bytes).ToString]);
  DoOnCharacteristicWrite(LCharacteristic, TBluetoothGattStatus(Error));
end;


procedure TMacBluetoothLEDevice.DidWriteDescriptorValue(const Sender: TObject; const ADescriptor: CBDescriptor;
  Error: Integer);
var
  LDescriptor: TBluetoothGattDescriptor;
begin
  LDescriptor := FindDescriptor(ADescriptor);
  if LDescriptor = nil then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLECanNotFindDescriptor,
       [UUIDToGUID(ADescriptor.UUID.data.bytes).ToString]);
  DoOnDescriptorWrite(LDescriptor, TBluetoothGattStatus(Error));
end;

procedure TMacBluetoothLEDevice.DiscoveredSevices(Sender: TObject; Error: Integer);
var
  LServices: NSArray;
  I: Integer;
  LService: CBService;
  LServiceType: TBluetoothServiceType;
begin
  if Error <> 0 then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLECanNotDiscoverServices, [GetDeviceName]);

  FServices.Clear;
  LServices := FDevice.Services;
  if LServices <> nil then
  begin
    for I := 0 to LServices.count - 1 do
    begin
      LService := TCBService.Wrap(LServices.objectAtIndex(I));
      if CheckOSVersion then
      begin
        if LService.isPrimary then
          LServiceType := TBluetoothServiceType.Primary
        else
          LServiceType := TBluetoothServiceType.Secondary;
      end
      else
        LServiceType := TBluetoothServiceType.Primary;
      FServices.Add(TMacBluetoothGattService.Create(NSDataToGUID(LService.UUID.data), LServiceType, LService, FDevice));
    end;
  end;
  DoOnServicesDiscovered(Self, FServices);
end;

procedure TMacBluetoothLEDevice.DoAbortReliableWrite;
begin
  { Not supported on Mac/iOS }
end;

function TMacBluetoothLEDevice.DoBeginReliableWrite: Boolean;
begin
  { Not supported on Mac/iOS }
  Result := False;
end;

function TMacBluetoothLEDevice.DoDiscoverServices: Boolean;
begin
  Result := CheckConnection;
  if Result then
    FDevice.DiscoverServices;
end;

function TMacBluetoothLEDevice.DoExecuteReliableWrite: Boolean;
begin
  { Not supported on Mac/iOS}
  Result := False;
end;

function TMacBluetoothLEDevice.DoReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  Result := CheckConnection and ((not UpdateOnReconnect) or (not FUpdateServices));
  if Result then
    FDevice.ReadCharacteristicValue((ACharacteristic as TMacBluetoothGattCharacteristic).FCharacteristic);
end;

function TMacBluetoothLEDevice.DoReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := CheckConnection and ((not UpdateOnReconnect) or (not FUpdateServices));
  if Result then
    FDevice.ReadDescriptorValue((ADescriptor as TMacBluetoothGattDescriptor).FDescriptor);
end;

function TMacBluetoothLEDevice.DoReadRemoteRSSI: Boolean;
begin
  if CheckConnection then
  begin
    FDevice.ReadRSSI;
    Result := True;
  end
  else
    Result := False;
end;

function TMacBluetoothLEDevice.DoSetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
  Enable: Boolean): Boolean;
var
  LTotal: Single;
begin
  Result := CheckConnection and ((not UpdateOnReconnect) or (not FUpdateServices));;
  if Result then
  begin
    FDevice.SetNotifyValue((ACharacteristic as TMacBluetoothGattCharacteristic).FCharacteristic, Enable);
    LTotal := 0;
    repeat
      LTotal := LTotal + 0.05;
      InternalWaitMessage(0.05);
    until (FDevice.FUpdatedNotification) or (LTotal >= DeviceTimeout);
    Result := (FDevice.FLastError = 0) and FDevice.FUpdatedNotification;
  end;
end;

function TMacBluetoothLEDevice.DoWriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
var
  LMacCharacteristic: TMacBluetoothGattCharacteristic;
  LWriteType: CBCharacteristicWriteType;
begin
  Result := CheckConnection and ((not UpdateOnReconnect) or (not FUpdateServices));;
  if Result then
  begin
    LMacCharacteristic := ACharacteristic as TMacBluetoothGattCharacteristic;
    if TBluetoothProperty.WriteNoResponse in ACharacteristic.Properties then
      LWriteType := CBCharacteristicWriteWithoutResponse
    else
      LWriteType := CBCharacteristicWriteWithResponse;

    FDevice.WriteCharacteristicValue(LMacCharacteristic.FCharacteristic, LMacCharacteristic.FValue, LWriteType);
  end;
end;

function TMacBluetoothLEDevice.DoWriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := CheckConnection and ((not UpdateOnReconnect) or (not FUpdateServices));;
  if Result then
    FDevice.WriteDescriptorValue((ADescriptor as TMacBluetoothGattDescriptor).FDescriptor,
      (ADescriptor as TMacBluetoothGattDescriptor).FValue);
end;

function TMacBluetoothLEDevice.FindCharacteristic(const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FServices.Count - 1 do
  begin
    Result := TMacBluetoothGattService(FServices[I]).FindCharacteristic(ACharacteristic);
    if Result <> nil then
      Break;
  end;
end;

function TMacBluetoothLEDevice.FindDescriptor(const ADescriptor: CBDescriptor): TBluetoothGattDescriptor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FServices.Count - 1 do
  begin
    Result := TMacBluetoothGattService(FServices[I]).FindDescriptor(ADescriptor);
    if Result <> nil then
      Break;
  end;
end;

function TMacBluetoothLEDevice.DoCreateAdvertiseData: TBluetoothLEAdvertiseData;
begin
  Result := TMacBluetoothLEAdvertiseData.Create;
end;

function TMacBluetoothLEDevice.GetAddress: TBluetoothMacAddress;
begin
  { Not supported on Mac / iOS }
  Result := '';
end;

function TMacBluetoothLEDevice.GetIdentifier: string;
begin
  Result := TMacBluetoothLEManager(FLEManager.FCentralManager).GetDeviceIdentifier(Self.FDevice.FDevice).ToString;
end;

function TMacBluetoothLEDevice.GetIsConnected: Boolean;
begin
  Result := FDevice.GetConnected;
end;

function TMacBluetoothLEDevice.GetBluetoothType: TBluetoothType;
begin
  Result := TBluetoothType.LE;
end;

function TMacBluetoothLEDevice.GetDeviceName: string;
begin
  if FDevice.FAdvertiseGattServerName <> '' then
    Result := FDevice.FAdvertiseGattServerName
  else
    Result := FDevice.Name;
end;

function TMacBluetoothLEDevice.DoDisconnect: Boolean;
begin
  Result := FLEManager.CancelConnectionTo(FDevice.FDevice);
end;

function TMacBluetoothLEDevice.DoConnect: Boolean;
begin
  Result := CheckConnection;
end;

procedure TMacBluetoothLEDevice.UpdateServices;
var
  I, J: Integer;
  LService: TMacBluetoothGattService;
  LCBService: CBService;
begin
  if (FDevice <> nil) then
  begin
    FUpdateServices := False;
    //Re-discover services
    FDevice.DiscoverServices(True);
    for I := 0 to Services.Count - 1 do
    begin
      LService := TMacBluetoothGattService(Services[I]);
      LService.FService := nil;
      if (FDevice.Services <> nil) and (FDevice.Services.count > 0) then
        for J := 0 to FDevice.Services.count - 1 do
        begin
          LCBService := TCBService.Wrap(FDevice.Services.objectAtIndex(J));
          if LService.FUUID = NSDataToGUID(LCBService.UUID.data) then
          begin
            LService.FService := LCBService;
            LService.UpdateCharacteristics;
            Break;
          end;
        end;

      if LService.FService = nil then
        FUpdateServices := True;
    end;
  end;
end;

{ TMacBluetoothGattService }

constructor TMacBluetoothGattService.Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType;
  const AService: CBService; const ADevice: TMacBluetoothLEPeripheral);
begin
  inherited Create(AnUUID, AType);
  FUUID := AnUUID;
  FService := AService;
  FDevice := ADevice;
  FCharacteristics := TBluetoothGattCharacteristicList.Create;
  FIncludedServices := TBluetoothGattServiceList.Create;
end;

constructor TMacBluetoothGattService.Create(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType;
  const AService: CBMutableService; const AGattServer: TMacBluetoothLEGattServerManager);
begin
  inherited Create(AnUUID, AType);
  FService := nil;
  FMutableService := AService;
  FDevice := nil;
  FGattServer := AGattServer;
end;

destructor TMacBluetoothGattService.Destroy;
begin
  inherited;
end;

function TMacBluetoothGattService.DoAddCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  { No need to do anything }
  Result := True;
end;

function TMacBluetoothGattService.DoCreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
  const ADescription: string): TBluetoothGattCharacteristic;
var
  LCharacteristic: CBMutableCharacteristic;
  LUUID: CBUUID;
  LStrUUID: string;
  I: Integer;
  LNewArray: NSMutableArray;
  NSStringConst: NSString;
  LMutableDes: CBMutableDescriptor;
begin
  LStrUUID := GUIDToString(AUUID);
  LStrUUID := LStrUUID.Substring(1, LStrUUID.Length - 2);
  LUUID := TCBUUID.OCClass.UUIDWithString(StrToNSStr(LStrUUID));
  LCharacteristic := TCBMutableCharacteristic.Wrap(TCBMutableCharacteristic.Alloc.initWithType(LUUID,
     PropertiesToInteger(APropertyFlags), nil, CBAttributePermissionsReadable or CBAttributePermissionsWriteable));
  LCharacteristic.retain;

  { Create descriptor with the user description if proceed }
  if ADescription <> '' then
  begin
    NSStringConst := CocoaNSStringConst(libCoreBluetooth, 'CBUUIDCharacteristicUserDescriptionString');
    LUUID := TCBUUID.OCClass.UUIDWithString(NSStringConst);
    LMutableDes := TCBMutableDescriptor.Wrap(TCBMutableDescriptor.Alloc.initWithType(LUUID,
       (StrToNSStr(ADescription) as ILocalObject).GetObjectID));
    LNewArray := TNSMutableArray.Wrap(TNSMutableArray.OCClass.arrayWithObject((LMutableDes as ILocalObject).GetObjectID));
    LCharacteristic.setDescriptors(LNewArray);
  end;

  { Update characteristics array }
  LNewArray := TNSMutableArray.Wrap(TNSMutableArray.Alloc.init);
  for I := 0 to FCharacteristics.Count - 1 do
    LNewArray.addObject(((FCharacteristics[I] as TMacBluetoothGattCharacteristic).FCharacteristic as ILocalObject).GetObjectID);
  LNewArray.addObject((LCharacteristic as ILocalObject).GetObjectID);
  FMutableService.setCharacteristics(LNewArray);

  Result := TMacBluetoothGattCharacteristic.Create(Self, LCharacteristic);
end;

function TMacBluetoothGattService.DoCreateIncludedService(const AnUUID: TBluetoothUUID;
  AType: TBluetoothServiceType): TBluetoothGattService;
var
  LMacService: CBMutableService;
  LUUID: CBUUID;
  LStrGUID: string;
  LArray: NSArray;
begin
  LStrGUID := GUIDToString(AnUUID);
  LStrGUID := LStrGUID.Substring(1, LStrGUID.Length - 2);
  LUUID := TCBUUID.OCClass.UUIDWithString(StrToNSStr(LStrGUID));
  LMacService := TCBMutableService.Wrap(TCBMutableService.Alloc.initWithType(LUUID, AType = TBluetoothServiceType.Primary));
  LArray := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject((LMacService as ILocalObject).GetObjectID));
  FMutableService.setIncludedServices(LArray);
  Result := TMacBluetoothGattService.Create(AnUUID, TBluetoothServiceType.Primary, LMacService, FGattServer);
end;

function TMacBluetoothGattService.DoAddIncludedService(const AService: TBluetoothGattService): Boolean;
var
  LTotal: Single;
begin
  inherited;
  if FGattServer.FGattServer.state <> CBPeripheralManagerStatePoweredOn then
  begin
    LTotal := 0;
    repeat
      LTotal := LTotal + 0.05;
      InternalWaitMessage(0.05);
    until (FGattServer.GattServerOn) or (LTotal >= 5);
  end;

  FGattServer.FGattServer.addService((AService as TMacBluetoothGattService).FMutableService);
  if FGattServer.GattServerOn then
    Result := True
  else
    Result := False;
end;

function TMacBluetoothGattService.DoGetCharacteristics: TBluetoothGattCharacteristicList;
var
  I: Integer;
  LCharacteristic: CBCharacteristic;
begin
  if FDevice <> nil then
  begin
    if FDevice.FLEDevice.FUpdateServices and FDevice.FLEDevice.UpdateOnReconnect and
    ((not FDevice.FLEDevice.CheckConnection) or FDevice.FLEDevice.FUpdateServices) then
        Exit(FCharacteristics);

    FDevice.InternalDiscoverCharacteristics(FService, nil);
    if FService.characteristics <> nil then
    begin
      for I := 0 to FService.characteristics.count - 1 do
      begin
        LCharacteristic := TCBCharacteristic.Wrap(FService.characteristics.objectAtIndex(I));
        FCharacteristics.Add(TMacBluetoothGattCharacteristic.Create(Self, LCharacteristic, FDevice));
      end;
    end;
  end;
  Result := FCharacteristics;
end;

function TMacBluetoothGattService.DoGetIncludedServices: TBluetoothGattServiceList;
var
  LTotal: Single;
  I: Integer;
  AService: CBService;
begin
  if (FIncludedServices.Count = 0) and (FDevice <> nil) then
  begin
    if FDevice.FLEDevice.FUpdateServices and FDevice.FLEDevice.UpdateOnReconnect and
    ((not FDevice.FLEDevice.CheckConnection) or FDevice.FLEDevice.FUpdateServices) then
        Exit(FIncludedServices);

    FDevice.DiscoverIncludedServicesForService(FService);
    LTotal := 0;
    repeat
      InternalWaitMessage(0.05);
      LTotal := LTotal + 0.05;
    until (FDevice.DiscoveredIncludedServices) or (LTotal >= DeviceTimeout);
    if FDevice.LastError <> 0 then
      raise EBluetoothLEServiceException.CreateFmt(SBluetoothLECanNotGetIncludedServices, [GetServiceUUID.ToString]);

    if (FService.includedServices <> nil) and (FService.includedServices.count > 0) then
      for I := 0 to FService.includedServices.count - 1 do
      begin
        AService := TCBService.Wrap(FService.includedServices.objectAtIndex(I));
        FIncludedServices.Add(TMacBluetoothGattService.Create(NSDataToGUID(AService.UUID.data),
          TBluetoothServiceType.Secondary, AService, FDevice));
      end;
  end;
  Result := FIncludedServices;
end;

function TMacBluetoothGattService.FindCharacteristic(
  const ACharacteristic: CBCharacteristic): TBluetoothGattCharacteristic;
var
  I: Integer;
  LObjectID: Pointer;
begin
  Result := nil;
  LObjectID := (ACharacteristic as ILocalObject).GetObjectID;
  for I := 0 to FCharacteristics.Count - 1 do
    if (TMacBluetoothGattCharacteristic(FCharacteristics[I]).FCharacteristic as ILocalObject).GetObjectID = LObjectID then
      Exit(FCharacteristics[I]);

  for I := 0 to FIncludedServices.Count - 1 do
    Result := TMacBluetoothGattService(FInCludedServices).FindCharacteristic(ACharacteristic);
end;

function TMacBluetoothGattService.FindDescriptor(const ADescriptor: CBDescriptor): TBluetoothGattDescriptor;
var
  I: Integer;
  J: Integer;
  LObjectID: Pointer;
  LCharacteristic: TBluetoothGattCharacteristic;
begin
  Result := nil;
  LObjectID := (ADescriptor as ILocalObject).GetObjectID;
  for I := 0 to FCharacteristics.Count - 1 do
  begin
    LCharacteristic := FCharacteristics[I];
    for J := 0 to LCharacteristic.Descriptors.Count - 1 do
      if (TMacBluetoothGattDescriptor(LCharacteristic.Descriptors[J]).FDescriptor as ILocalObject).GetObjectID = LObjectID then
        Exit(LCharacteristic.Descriptors[J]);
  end;

  for I := 0 to FIncludedServices.Count - 1 do
    Result := TMacBluetoothGattService(FInCludedServices).FindDescriptor(ADescriptor);
end;

function TMacBluetoothGattService.GetServiceType: TBluetoothServiceType;
var
  LIsPrimary: Boolean;
begin
  if CheckOSVersion then
  begin
    if FService <> nil then
      LIsPrimary := FService.isPrimary
    else
      LIsPrimary := FMutableService.isPrimary;
    if LIsPrimary then
      Result := TBluetoothServiceType.Primary
    else
      Result := TBluetoothServiceType.Secondary;
  end
  else
    Result := TBluetoothServiceType.Primary
end;

function TMacBluetoothGattService.GetServiceUUID: TBluetoothUUID;
begin
  if FService <> nil then
    Result := FUUID
  else
    if FMutableService <> nil then
      Result := NSDataToGUID(FMutableService.UUID.data)
    else
      Result := TGUID.Empty;
end;

procedure TMacBluetoothGattService.UpdateCharacteristics;
var
  I, J: Integer;
  LCharacteristic: TMacBluetoothGattCharacteristic;
  LCBCharacteristic: CBCharacteristic;
begin
  FDevice.InternalDiscoverCharacteristics(FService, nil);
  for I := 0 to FCharacteristics.Count - 1 do
  begin
    LCharacteristic := TMacBluetoothGattCharacteristic(FCharacteristics[I]);
    LCharacteristic.FCharacteristic := nil;
    if (FService.characteristics <> nil) and (FService.characteristics.count > 0)then
      for J := 0 to FService.characteristics.count - 1 do
      begin
        LCBCharacteristic := TCBCharacteristic.Wrap(FService.characteristics.objectAtIndex(J));
        if LCharacteristic.FUUID = NSDataToGUID(LCBCharacteristic.UUID.data) then
        begin
          LCharacteristic.FCharacteristic := LCBCharacteristic;
          LCharacteristic.UpdateDescriptors;
          Break;
        end;
      end;
  end;
end;

{ TMacBluetoothGattCharacteristic }

constructor TMacBluetoothGattCharacteristic.Create(const AService: TBluetoothGattService;
  const ACharacteristic: CBCharacteristic; const ADevice: TMacBluetoothLEPeripheral);
begin
  inherited Create(AService);
  FUUID := NSDataToGUID(ACharacteristic.UUID.data);
  FCharacteristic := ACharacteristic;
  FProperties := InternalGetProperties;
  FDevice := ADevice;
  FCharacteristic.retain;
end;

constructor TMacBluetoothGattCharacteristic.Create(const AService: TBluetoothGattService;
  const ACharacteristic: CBMutableCharacteristic);
begin
  inherited Create(AService);
  FUUID := NSDataToGUID(ACharacteristic.UUID.data);
  FCharacteristic := ACharacteristic;
  FProperties := InternalGetProperties;
  FCharacteristic.retain;
end;

destructor TMacBluetoothGattCharacteristic.Destroy;
begin
  if (FCharacteristic <> nil) and ((FDevice = nil) or (not FDevice.FLEDevice.FUpdateServices)) then
    FCharacteristic.release;
  inherited;
end;

function TMacBluetoothGattCharacteristic.DoAddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := False;
end;

function TMacBluetoothGattCharacteristic.DoCreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor;
begin
  Result := nil;
end;

function TMacBluetoothGattCharacteristic.DoGetDescriptors: TBluetoothGattDescriptorList;
var
  LDescriptor: CBDescriptor;
  I: Integer;
begin
  if FDevice.FLEDevice.FUpdateServices and FDevice.FLEDevice.UpdateOnReconnect and
  ((not FDevice.FLEDevice.CheckConnection) or FDevice.FLEDevice.FUpdateServices) then
    Exit(FDescriptors);

  FDevice.InternalDiscoverDescriptors(FCharacteristic);
  if (FCharacteristic.descriptors <> nil) and (FCharacteristic.descriptors.count > 0) then
  begin
    for I := 0 to FCharacteristic.descriptors.count - 1 do
    begin
      LDescriptor := TCBDescriptor.Wrap(FCharacteristic.descriptors.objectAtIndex(I));
      FDescriptors.Add(TMacBluetoothGattDescriptor.Create(LDescriptor, FDevice, Self));
    end;
  end;
  Result := FDescriptors;
end;

function TMacBluetoothGattCharacteristic.DoGetValue: TBytes;
begin
  Result := FValue;
end;

procedure TMacBluetoothGattCharacteristic.DoSetValue(const AValue: TBytes);
begin
  SetLength(FValue, Length(AValue));
  if Length(FValue) > 0 then
    Move(AValue[0], FValue[0], Length(FValue));
end;

function TMacBluetoothGattCharacteristic.GetProperties: TBluetoothPropertyFlags;
begin
  Result := FProperties;
end;

function TMacBluetoothGattCharacteristic.InternalGetProperties: TBluetoothPropertyFlags;
var
  LProperties: Integer;
begin
  Result := [];
  LProperties := FCharacteristic.properties;
  if LProperties and CBCharacteristicPropertyBroadcast <> 0 then
    Include(Result, TBluetoothProperty.Broadcast);
  if LProperties and CBCharacteristicPropertyExtendedProperties <> 0 then
    Include(Result, TBluetoothProperty.ExtendedProps);
  if LProperties and CBCharacteristicPropertyNotify <> 0 then
    Include(Result, TBluetoothProperty.Notify);
  if LProperties and CBCharacteristicPropertyIndicate <> 0 then
    Include(Result, TBluetoothProperty.Indicate);
  if LProperties and CBCharacteristicPropertyRead <> 0 then
    Include(Result, TBluetoothProperty.Read);
  if LProperties and CBCharacteristicPropertyWrite <> 0 then
    Include(Result, TBluetoothProperty.Write);
  if LProperties and CBCharacteristicPropertyWriteWithoutResponse <> 0 then
    Include(Result, TBluetoothProperty.WriteNoResponse);
  if LProperties and CBCharacteristicPropertyAuthenticatedSignedWrites <> 0 then
    Include(Result, TBluetoothProperty.SignedWrite);
end;

function TMacBluetoothGattCharacteristic.GetUUID: TBluetoothUUID;
begin
  Result := FUUID;
end;

procedure TMacBluetoothGattCharacteristic.UpdateDescriptors;
var
  I, J: Integer;
  LDescriptor: TMacBluetoothGattDescriptor;
  LCBDescriptor: CBDescriptor;
begin
  FDevice.InternalDiscoverDescriptors(FCharacteristic);
  for I := 0 to FDescriptors.Count - 1 do
  begin
    LDescriptor := TMacBluetoothGattDescriptor(FDescriptors[I]);
    LDescriptor.FDescriptor := nil;
    if (FCharacteristic.descriptors <> nil) and (FCharacteristic.descriptors.count > 0) then
      for J := 0 to FCharacteristic.descriptors.count - 1 do
      begin
        LCBDescriptor := TCBDescriptor.Wrap(FCharacteristic.descriptors.objectAtIndex(J));
        if LDescriptor.FUUID = NSDataToGUID(LCBDescriptor.UUID.data) then
        begin
          LDescriptor.FDescriptor := LCBDescriptor;
          Break;
        end;
      end;
  end;
end;

{ TMacBluetoothGattDescriptor }

constructor TMacBluetoothGattDescriptor.Create(const ADescriptor: CBDescriptor; const ADevice: TMacBluetoothLEPeripheral;
  const ACharacteristic: TBluetoothGattCharacteristic);
begin
  inherited Create(ACharacteristic);
  FDescriptor := ADescriptor;
  FUUID := NSDataToGUID(ADescriptor.UUID.data);
  FDevice := ADevice;
  FCharacteristic := (ACharacteristic as TMacBluetoothGattCharacteristic).FCharacteristic;
end;

destructor TMacBluetoothGattDescriptor.Destroy;
begin
  inherited;
end;

function TMacBluetoothGattDescriptor.DoGetBroadcasts: Boolean;
begin
  Result := FCharacteristic.isBroadcasted;
end;

function TMacBluetoothGattDescriptor.DoGetExponent: ShortInt;
begin
                                            
  Result := 0;
end;

function TMacBluetoothGattDescriptor.DoGetFormat: TBluetoothGattFormatType;
begin
                                            
  Result := TBluetoothGattFormatType.Reserved;
end;

function TMacBluetoothGattDescriptor.DoGetFormatUnit: TBluetoothUUID;
begin
                                            
  Result := TGUID.Empty;
end;

function TMacBluetoothGattDescriptor.DoGetIndication: Boolean;
begin
  Result := FCharacteristic.isNotifying;
end;

function TMacBluetoothGattDescriptor.DoGetNotification: Boolean;
begin
  Result := FCharacteristic.isNotifying;
end;

function TMacBluetoothGattDescriptor.DoGetReliableWrite: Boolean;
begin
  Result := False;
end;

function TMacBluetoothGattDescriptor.DoGetUserDescription: string;
var
  LSData: NSData;
  LString: NSString;
  LSObject: NSObject;
  P: Pointer;
begin
  P := FDescriptor.value;
  LSObject := TNSObject.Wrap(P);
  if NSInheritsFrom(LSObject, TNSData.OCClass) then
  begin
    LSData := TNSData.Wrap(P);
    Result := NSStrToStr(TNSString.Wrap(TNSString.OCClass.stringWithUTF8String(MarshaledAString(LSData.bytes))))
  end
  else
  begin
    LString := TNSString.Wrap(P);
    Result := NSStrToStr(LString);
  end;
end;

function TMacBluetoothGattDescriptor.DoGetValue: TBytes;
var
  LNumber: NSNumber;
  LUInt16: UInt16;
  LSData: NSData;
  LString: NSString;
  LSObject: NSObject;
  LMarshaled: MarshaledAString;
  P: Pointer;
begin
  SetLength(Result, 0);
  case Kind of
    TBluetoothDescriptorKind.PresentationFormat,
    TBluetoothDescriptorKind.UserDescription:
    begin
      P := FDescriptor.value;
      LSObject := TNSObject.Wrap(P);
      if NSInheritsFrom(LSObject, TNSData.OCClass) then
      begin
        LSData := TNSData.Wrap(P);
        LMarshaled := LSData.bytes;
      end
      else
      begin
        LString := TNSString.Wrap(P);
        LMarshaled := LString.UTF8String;
      end;
      if Length(LMarshaled) > 0 then
      begin
        SetLength(Result, Length(LMarshaled));
        Move(LMarshaled^, Result[0], Length(LMarshaled));
      end;
    end;
    TBluetoothDescriptorKind.AggregateFormat,
    TBluetoothDescriptorKind.ExtendedProperties,
    TBluetoothDescriptorKind.ClientConfiguration,
    TBluetoothDescriptorKind.ServerConfiguration:
    begin
      P := FDescriptor.value;
      LSObject := TNSObject.Wrap(P);
      /// Descriptor.value should be a TNSNumber as mac documentation states, however this seems not to be true
      /// seems that it is true for IOS, but not for OSX, on OSX we get a TNSData.
      /// We only copy the first byte since the used part of value is on that byte, for more information:
      /// https://developer.bluetooth.org/gatt/descriptors/Pages/DescriptorViewer.aspx?u=org.bluetooth.descriptor.gatt.client_characteristic_configuration.xml
      /// is for that that result length is set to 2 bytes.
      if NSInheritsFrom(LSObject, TNSData.OCClass) then
      begin
        LSData := TNSData.Wrap(P);
        LMarshaled := LSData.bytes;
        if Length(LMarshaled) > 0 then
        begin
          SetLength(Result, Length(LMarshaled));
          Move(LMarshaled^, Result[0], Length(LMarshaled))
        end;
        SetLength(Result, 2);
      end
      else if NSInheritsFrom(LSObject, TNSNumber.OCClass) then
      begin
        LNumber := TNSNumber.Wrap(FDescriptor.value);
        LUInt16 := LNumber.unsignedShortValue;
        SetLength(Result, SizeOf(LUInt16));
        Move(LUInt16, Result[0], SizeOf(LUInt16));
      end;
    end;
  end;
end;

function TMacBluetoothGattDescriptor.DoGetWritableAuxiliaries: Boolean;
begin
                                            
  Result := False;
end;

procedure TMacBluetoothGattDescriptor.DoSetBroadcasts(const Value: Boolean);
begin
  FBroadcast := Value;
end;

procedure TMacBluetoothGattDescriptor.DoSetIndication(const Value: Boolean);
begin
  FIndication := Value;
end;

procedure TMacBluetoothGattDescriptor.DoSetNotification(const Value: Boolean);
begin
  FNotification := Value;
end;

procedure TMacBluetoothGattDescriptor.DoSetUserDescription(const Value: string);
begin
  inherited;
  { On Mac/iOS User Description descriptor is created with the characteristic }
end;

procedure TMacBluetoothGattDescriptor.DoSetValue(const AValue: TBytes);
begin
  FValue := AValue;
end;

function TMacBluetoothGattDescriptor.GetUUID: TBluetoothUUID;
begin
  Result := FUUID;
end;

{ TInternalBluetoothLEManager }

procedure TInternalBluetoothLEManager.centralManagerDidConnectPeripheral(central: CBCentralManager; peripheral: CBPeripheral);
begin
  FLastError := 0;
  FConnected := True;
  if Assigned(FOnDeviceConnect) then
    FOnDeviceConnect(Self, peripheral);
end;

procedure TInternalBluetoothLEManager.centralManagerdidDisconnectPeripheral(central: CBCentralManager; peripheral: CBPeripheral;
  error: NSError);
begin
  FLastError := error.code;
  FConnected := True;
  if Assigned(FOnDeviceDisconnect) then
    FOnDeviceDisconnect(Self, peripheral);
end;

procedure TInternalBluetoothLEManager.centralManagerDidDiscoverPeripheral(central: CBCentralManager; peripheral: CBPeripheral;
  advertisementData: NSDictionary; RSSI: NSNumber);
begin
  if Assigned(FOnDeviceDiscovered) then
    FOnDeviceDiscovered(Self, peripheral, advertisementData, RSSI.intValue);
end;

procedure TInternalBluetoothLEManager.centralManagerDidFailToConnectPeripheral(central: CBCentralManager;
  peripheral: CBPeripheral; error: NSError);
begin
  FLastError := 1;
  FConnected := True;
end;

procedure TInternalBluetoothLEManager.centralManagerDidRetrieveConnectedPeripherals(central: CBCentralManager;
  peripherals: NSArray);
begin

end;

procedure TInternalBluetoothLEManager.centralManagerDidRetrievePeripherals(central: CBCentralManager; peripherals: NSArray);
begin

end;

procedure TInternalBluetoothLEManager.centralManagerDidUpdateState(central: CBCentralManager);
begin
  if (central.state = CBCentralManagerStatePoweredOn) and FWaitingToDiscover then
  begin
     FWaitingToDiscover := False;
     central.scanForPeripheralsWithServices(FFilterUUIDList, FScanOptions);
  end;
end;

procedure TInternalBluetoothLEManager.centralManagerWillRestoreState(central: CBCentralManager; dict: NSDictionary);
begin

end;

function TInternalBluetoothLEManager.ConnectTo(const APeripheral: CBPeripheral): Boolean;
const
  ConnectTimeout: Cardinal = 3;
var
  LTotal: Single;
begin
  FConnected := False;
  FCentralManager.connectPeripheral(APeripheral, nil);
  LTotal := 0;
  repeat
    LTotal := LTotal + 0.05;
    InternalWaitMessage(0.05);
  until (FConnected) or (LTotal >= ConnectTimeout);
  if FConnected and (FLastError = 0) then
    Result := True
  else
    Result := False;
end;

function TInternalBluetoothLEManager.CancelConnectionTo(const APeripheral: CBPeripheral): Boolean;
const
  ConnectTimeout: Cardinal = 5;
var
  LTotal: Single;
begin
  FConnected := False;
  FCentralManager.cancelPeripheralConnection(Aperipheral);
  LTotal := 0;
  repeat
    LTotal := LTotal + 0.05;
    InternalWaitMessage(0.05);
  until (FConnected) or (LTotal >= ConnectTimeout);
  Result := FConnected;
end;

constructor TInternalBluetoothLEManager.Create;
begin
  inherited;
  FCentralManager := TCBCentralManager.Wrap(TCBCentralManager.Alloc.initWithDelegate(GetObjectID, 0));
  FIsDiscovering := False;
end;

procedure TInternalBluetoothLEManager.CreateTimer(Interval: Integer);
var
  LInterval: NSTimeInterval;
begin
  if (Interval > 0) then
  begin
    FTimer := TInternalTimer.Create;
    try
      LInterval := Interval/1000;
      FTimer.SetNotifyEvent(OnDiscoveryTimeout);
      FTimer.FTimer := TNSTimer.Wrap(TNSTimer.OCClass.scheduledTimerWithTimeInterval(LInterval,
        FTimer.GetObjectID, sel_getUid('timerEvent'), FTimer.GetObjectID, False)); // Do not translate

    finally
      {user is retained (twice, because it's target), by the timer and }
      {released (twice) on timer invalidation}
      NSObject(FTimer.Super).release;
    end;
  end;
end;

destructor TInternalBluetoothLEManager.Destroy;
begin
  FCentralManager.release;
  inherited;
end;

procedure TInternalBluetoothLEManager.OnDiscoveryTimeout(Sender: TObject);
begin
  FreeAndNil(FTimer);
  StopDiscovery;
  if Assigned(FOnDeviceDiscoveryTimeout) then
    FOnDeviceDiscoveryTimeout(Self);
end;

procedure TInternalBluetoothLEManager.StartDiscovery(Timeout: Cardinal; const FilterUUIDList: TBluetoothUUIDsList);
var
  LNumber: NSNumber;
begin
  if FIsDiscovering then Exit;
  FFilterUUIDList := UUIDListToNsArray(FilterUUIDList);
  if FScanOptions = nil then
  begin
    FScanOptions := TNSMutableDictionary.Create;
    LNumber := TNSNumber.Wrap(TNSNumber.OCClass.numberWithUnsignedChar(0));
    FScanOptions.setValue((LNumber as ILocalObject).GetObjectID, CBCentralManagerScanOptionAllowDuplicatesKey);
  end;

  if FCentralManager.state = CBCentralManagerStatePoweredOn then
  begin
    FWaitingToDiscover := False;
    FCentralManager.scanForPeripheralsWithServices(FFilterUUIDList, FScanOptions);
    FIsDiscovering := True;
  end
  else
  begin
    FWaitingToDiscover := True;
    { Add some time to wait until CentralManager is powered on }
    Timeout := Timeout + 1500;
  end;
  CreateTimer(Timeout);
end;

procedure TInternalBluetoothLEManager.StopDiscovery;
begin
  FCentralManager.stopScan;
  FIsDiscovering := False;
end;

{ TMacBluetoothLEPeripheral }

constructor TMacBluetoothLEPeripheral.Create(const ADevice: CBPeripheral; const AGattServerName: string);
begin
  inherited Create;
  FAdvertiseGattServerName := AGattServerName;
  FDevice := ADevice;
  FDevice.retain;
  FDevice.setDelegate(GetObjectID);
end;

destructor TMacBluetoothLEPeripheral.Destroy;
begin
  FDevice.setDelegate(nil);
  FDevice.release;
  inherited;
end;

procedure TMacBluetoothLEPeripheral.DiscoverIncludedServicesForService(const AService: CBService);
begin
  FDiscoveredIncludedServices := False;
  FDevice.discoverIncludedServices(nil, AService);
end;

procedure TMacBluetoothLEPeripheral.DiscoverServices(ASilent: Boolean);
var
  LTotal: Single;
begin
  FDiscoveredServices := False;
  FDevice.discoverServices(nil);
  LTotal := 0;
  repeat
    InternalWaitMessage(0.05);
    LTotal := LTotal + 0.05;
  until FDiscoveredServices or (LTotal >= DeviceTimeout);
  if Assigned(FOnDiscoveredServices) and (not ASilent) then
    FOnDiscoveredServices(Self, FLastError);
end;

function TMacBluetoothLEPeripheral.GetName: string;
begin
  Result := NSStrToStr(FDevice.name);
end;

function TMacBluetoothLEPeripheral.GetServices: NSArray;
begin
  Result := FDevice.services;
end;

function TMacBluetoothLEPeripheral.GetConnected: Boolean;
begin
  if CheckOSVersion then
    Result := FDevice.state = CBPeripheralStateConnected
  else
    Result := FDevice.isConnected;
end;

procedure TMacBluetoothLEPeripheral.InternalDiscoverCharacteristics(const AService: CBService; const UUIDS: NSArray);
var
  LTotal: Single;
begin
  FDiscoveredCharacteristics := False;
  FDevice.discoverCharacteristics(UUIDS, AService);
  LTotal := 0;
  repeat
    InternalWaitMessage(0.05);
    LTotal := LTotal + 0.05;
  until (FDiscoveredCharacteristics) or (LTotal >= DeviceTimeout);
  if LastError <> 0 then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLENoCharacteristics,
       [UUIDToGUID(AService.UUID.data.bytes).ToString]);
end;

procedure TMacBluetoothLEPeripheral.InternalDiscoverDescriptors(const ACharacteristic: CBCharacteristic);
var
  LTotal: Single;
begin
  FDiscoveredDescriptors := False;
  FDevice.discoverDescriptorsForCharacteristic(ACharacteristic);
  LTotal := 0;
  repeat
    InternalWaitMessage(0.05);
    LTotal := LTotal + 0.05;
  until (FDiscoveredDescriptors) or (LTotal >= DeviceTimeout);
  if LastError <> 0 then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLENoDescriptors,
       [UUIDToGUID(ACharacteristic.UUID.data.bytes).ToString]);
end;

procedure TMacBluetoothLEPeripheral.peripheralDidDiscoverCharacteristicsForService(peripheral: CBPeripheral;
  service: CBService; error: NSError);
begin
  FDiscoveredCharacteristics := True;
  FLastError := error.Code;
end;

procedure TMacBluetoothLEPeripheral.peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: CBPeripheral;
  characteristic: CBCharacteristic; error: NSError);
begin
  FDiscoveredDescriptors := True;
  FLastError := error.code;
end;

procedure TMacBluetoothLEPeripheral.peripheralDidDiscoverIncludedServicesForService(peripheral: CBPeripheral;
  service: CBService; error: NSError);
begin
  FDiscoveredIncludedServices := True;
  FLastError := error.code;
end;

procedure TMacBluetoothLEPeripheral.peripheralDidDiscoverServices(peripheral: CBPeripheral; error: NSError);
begin
  FDiscoveredServices := True;
  FLastError := error.code;
end;

procedure TMacBluetoothLEPeripheral.peripheralDidInvalidateServices(peripheral: CBPeripheral);
begin
  { No need to implement, for debug purposes }
end;

procedure TMacBluetoothLEPeripheral.peripheralDidModifyServices(peripheral: CBPeripheral; invalidatedServices: NSArray);
begin
  { No need to implement, for debug purposes }
end;

procedure TMacBluetoothLEPeripheral.peripheralDidUpdateName(peripheral: CBPeripheral);
begin
  { No need to implement, for debug purposes }
end;

procedure TMacBluetoothLEPeripheral.peripheralDidUpdateNotificationStateForCharacteristic(peripheral: CBPeripheral;
  characteristic: CBCharacteristic; error: NSError);
begin
  FUpdatedNotification := True;
  FLastError := error.code;
end;

procedure TMacBluetoothLEPeripheral.peripheralDidUpdateRSSI(peripheral: CBPeripheral; error: NSError);
begin
  if Assigned(FOnUpdatedRssiValue) then
    FOnUpdatedRssiValue(Self, peripheral.RSSI.intValue, TBluetoothGattStatus(error.code));
end;

procedure TMacBluetoothLEPeripheral.peripheralDidUpdateValueForCharacteristic(peripheral: CBPeripheral;
  characteristic: CBCharacteristic; error: NSError);
begin
  if Assigned(FOnDidReadCharacteristicValue) then
    FOnDidReadCharacteristicValue(Self, characteristic, error.code);
end;

procedure TMacBluetoothLEPeripheral.peripheralDidUpdateValueForDescriptor(peripheral: CBPeripheral;
  descriptor: CBDescriptor; error: NSError);
begin
  if Assigned(FOnReadDescriptorValue) then
    FOnReadDescriptorValue(Self, descriptor, error.code);
end;

procedure TMacBluetoothLEPeripheral.peripheralDidWriteValueForCharacteristic(peripheral: CBPeripheral;
  characteristic: CBCharacteristic; error: NSError);
begin
  if Assigned(FOnDidWriteCharacteristicValue) then
    FOnDidWriteCharacteristicValue(Self, characteristic, error.code);
end;

procedure TMacBluetoothLEPeripheral.peripheralDidWriteValueForDescriptor(peripheral: CBPeripheral;
  descriptor: CBDescriptor; error: NSError);
begin
  if Assigned(FOnWriteDescriptorValue) then
    FOnWriteDescriptorValue(Self, descriptor, error.code);
end;

procedure TMacBluetoothLEPeripheral.ReadCharacteristicValue(const ACharacteristic: CBCharacteristic);
begin
  FDevice.readValueForCharacteristic(ACharacteristic);
end;

procedure TMacBluetoothLEPeripheral.ReadDescriptorValue(const ADescriptor: CBDescriptor);
begin
  FDevice.readValueForDescriptor(ADescriptor);
end;

procedure TMacBluetoothLEPeripheral.ReadRSSI;
begin
  FDevice.readRSSI;
end;

procedure TMacBluetoothLEPeripheral.SetNotifyValue(const ACharacteristic: CBCharacteristic; AValue: Boolean);
begin
  FUpdatedNotification := False;
  FDevice.setNotifyValue(AValue, ACharacteristic);
end;

procedure TMacBluetoothLEPeripheral.WriteCharacteristicValue(const ACharacteristic: CBCharacteristic;
  const AValue: TBytes; AWriteType: CBCharacteristicWriteType);
var
  LData: NSData;
begin
  if Length(AValue) > 0 then
    LData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@AValue[0], Length(AValue)))
  else
    LData := TNSData.Wrap(TNSData.OCClass.data);
  try
    LData.retain;
    FDevice.writeValue(LData, ACharacteristic, AWriteType);
  finally
    LData.release;
  end;
end;

procedure TMacBluetoothLEPeripheral.WriteDescriptorValue(const ADescriptor: CBDescriptor; const AValue: TBytes);
var
  LData: NSData;
begin
  if Length(AValue) > 0 then
    LData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@AValue[0], Length(AValue)))
  else
    LData := TNSData.Wrap(TNSData.OCClass.data);
  FDevice.writeValue(LData, ADescriptor);
end;

{ TMacBluetoothLEManager }

procedure TMacBluetoothLEManager.AddDiscoveredDevice(const ADevice: TBluetoothLEDevice);
begin
  FDiscoveredLEDevices.Add(ADevice);
end;

function TMacBluetoothLEManager.DoGetGattServer: TBluetoothGattServer;
begin
  if CheckOSVersionForGattServer then
    Result := TMacBluetoothGattServer.Create(Self)
  else
    raise EBluetoothException.Create(SBluetoothOSVersionError);
end;

function TMacBluetoothLEManager.DoGetSupportsGattClient: Boolean;
begin
  Result := CheckOSVersionForGattClient;
end;

function TMacBluetoothLEManager.DoGetSupportsGattServer: Boolean;
begin
  Result := CheckOSVersionForGattServer;
end;

function TMacBluetoothLEManager.DoGetAdapter: TBluetoothLEAdapter;
begin
  if GetConnectionState = TBluetoothConnectionState.Disconnected then
    FAdapter := nil;
  Result := FAdapter
end;

function TMacBluetoothLEManager.GetConnectionState: TBluetoothConnectionState;
var
  LTotal: Single;
  LMacBluetoothLEAdapter: TMacBluetoothLEAdapter;
begin
  if FAdapter = nil then
    FAdapter := TMacBluetoothLEAdapter.Create(Self);
  LMacBluetoothLEAdapter := TMacBluetoothLEAdapter(FAdapter);
  if LMacBluetoothLEAdapter.FLEManager.FCentralManager.state = CBCentralManagerStatePoweredOn then
     Result := TBluetoothConnectionState.Connected
  else
  begin
    LTotal := 0;
    repeat
      InternalWaitMessage(0.05);
      LTotal := LTotal + 0.05;
    until (LTotal >= 1) or (LMacBluetoothLEAdapter.FLEManager.FCentralManager.state = CBCentralManagerStatePoweredOn);
    if LMacBluetoothLEAdapter.FLEManager.FCentralManager.state = CBCentralManagerStatePoweredOn then
      Result := TBluetoothConnectionState.Connected
    else
      Result := TBluetoothConnectionState.Disconnected;
  end;
end;

function TMacBluetoothLEManager.GetDeviceIdentifier(const ADevice: CBPeripheral): TGUID;
var
  LBytes: TBytes;
  LUUID: PByte;
  LUUIDBytes: CFUUIDBytes;
  PLUUIDBytes: PCFUUIDBytes;
begin
  SetLength(LBytes, 16);
  LUUID := @LBytes[0];
  if CheckOSVersion then
  begin
    ADevice.identifier.getUUIDBytes(LUUID);
    Result := UUIDToGUID(LUUID);
  end
  else
  begin
    if ADevice.UUID <> nil then
    begin
      LUUIDBytes := CFUUIDGetUUIDBytes(ADevice.UUID);
      PLUUIDBytes := @LUUIDBytes;
      Result := UUIDToGUID(PLUUIDBytes);
    end
    else
      Result := GUID_NULL;
  end;
end;

function TMacBluetoothLEManager.DoEnableBluetooth: Boolean;
begin
  Result := False;
end;

{ TMacBluetoothLEGattServerManager }

constructor TMacBluetoothLEGattServerManager.Create(const AServer: TMacBluetoothGattServer);
begin
  inherited Create;
  FGServ := AServer;
  FGattServer := TCBPeripheralManager.Create;
  FGattServer.initWithDelegate(GetObjectID, 0);
end;

destructor TMacBluetoothLEGattServerManager.Destroy;
begin
  FGattServer.release;
  inherited;
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidAddService(peripheral: CBPeripheral; service: CBService;
  error: NSError);
var
  I: Integer;
  LService: TBluetoothGattService;
  LServiceGUID: TGUID;
begin
  LService := nil;
  LServiceGUID := UUIDToGUID(service.UUID.data.bytes);
  for I := 0 to FGServ.FServices.Count - 1 do
  begin
    if IsEqualGUID(FGServ.FServices.Items[I].UUID, LServiceGUID) then
    begin
      LService := FGServ.FServices.Items[I];
      Break;
    end;
  end;

  if LService <> nil then
    if (error = nil) or (error.code = 0) then
      FGServ.DoServiceAdded(TBluetoothGattStatus.Success, LService)
    else
      FGServ.DoServiceAdded(TBluetoothGattStatus.Failure, LService);
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidReceiveReadRequests(peripheral: CBPeripheralManager;
  request: CBATTRequest);
begin
  if Assigned(FOnReceiveReadRequest) then
    FOnReceiveReadRequest(Self, peripheral, request);
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidReceiveWriteRequests(peripheral: CBPeripheralManager;
  requests: NSArray);
begin
  if Assigned(FOnReceiveWriteRequest) then
    FOnReceiveWriteRequest(Self, peripheral, requests);
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager;
  error: NSError);
begin
  { No need to implement, for debug purposes }
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidSubscribetoCharacteristic(peripheral: CBPeripheral;
  central: CBCentral; characteristic: CBCharacteristic);
begin
  if Assigned(FOnSubscribeClient) then
    FOnSubscribeClient(FGServ, NSStrToStr(central.identifier.UUIDString), characteristic);
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidUnsubscribeFromCharacteristic(
  peripheral: CBPeripheralManager; central: CBCentral; characteristic: CBCharacteristic);
begin
  if Assigned(FOnUnsubscribeClient) then
    FOnUnsubscribeClient(FGServ, NSStrToStr(central.identifier.UUIDString), characteristic);
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerDidUpdateState(peripheral: CBPeripheralManager);
begin
  if peripheral.state = CBPeripheralManagerStatePoweredOn then
    FGattServerOn := True;
end;

procedure TMacBluetoothLEGattServerManager.peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager);
begin
  if FPendingUpdate then
  begin
    if FGattServer.updateValue(FPendingValue, FPendingChar, nil) then
    begin
      FPendingUpdate := False;
      FPendingValue := nil;
      FPendingChar := nil;
    end;
  end;
end;

procedure TMacBluetoothLEGattServerManager.RemoveAllServices;
begin
  FGattServer.removeAllServices;
end;

procedure TMacBluetoothLEGattServerManager.UpdateCharacteristicValue(const ACharacteristic: CBMutableCharacteristic;
  const Value: TBytes);
var
  LData: NSData;
begin
  if Length(Value) > 0 then
    LData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(@Value[0], Length(Value)))
  else
    LData := TNSData.Wrap(TNSData.OCClass.dataWithBytes(nil, 0));
  if not FGattServer.updateValue(LData, ACharacteristic, nil) then
  begin
    FPendingUpdate := True;
    FPendingValue := LData;
    FPendingChar := ACharacteristic;
  end;
end;

{ TMacBluetoothLEAdvertiseData }

function TMacBluetoothLEAdvertiseData.DoAddServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean;
begin
  Result := True;
end;

procedure TMacBluetoothLEAdvertiseData.DoRemoveServiceUUID(const AServiceUUID: TBluetoothUUID);
begin
  inherited;
end;

procedure TMacBluetoothLEAdvertiseData.DoClearServiceUUIDs;
begin
  inherited;
end;

function TMacBluetoothLEAdvertiseData.ContainsServiceUUID(const AServiceUUID: TBluetoothUUID): Boolean;
begin
  Result := FServiceUUIDs.Contains(AServiceUUID);
end;

function TMacBluetoothLEAdvertiseData.DoAddServiceData(const AServiceUUID: TBluetoothUUID; const AData: TBytes): Boolean;
begin
  Result := True;
end;

procedure TMacBluetoothLEAdvertiseData.DoRemoveServiceData(const AServiceUUID: TBluetoothUUID);
begin
  inherited;
end;

procedure TMacBluetoothLEAdvertiseData.DoClearServiceData;
begin
  inherited;
end;

function TMacBluetoothLEAdvertiseData.GetDataForService(const AServiceUUID: TBluetoothUUID): TBytes;
begin
  FServiceData.TryGetValue(AServiceUUID, Result);
end;

function TMacBluetoothLEAdvertiseData.GetServiceUUIDs: TArray<TBluetoothUUID>;
begin
  Result := FServiceUUIDs.ToArray;
end;

function TMacBluetoothLEAdvertiseData.GetServiceData: TArray<TServiceDataRawData>;
var
  I: Integer;
  LServiceData: TPair<TBluetoothUUID,TBytes>;
begin
  SetLength(Result, FServiceData.count);
  I := 0;
  for LServiceData in FServiceData do
  begin
    Result[I].create(LServiceData);
    Inc(I);
  end;
end;

constructor TMacBluetoothLEAdvertiseData.Create;
begin
  inherited;
end;

destructor TMacBluetoothLEAdvertiseData.Destroy;
begin
  inherited;
end;

procedure TMacBluetoothLEAdvertiseData.SetLocalName(const ALocalName: string);
begin
  if ALocalName <> FLocalName then
    FLocalName := ALocalName;
end;

function TMacBluetoothLEAdvertiseData.GetLocalName: string;
begin
  Result := FLocalName;
end;

procedure TMacBluetoothLEAdvertiseData.SetTxPowerLevel(ATxPowerLevel: Integer);
begin
  if ATxPowerLevel <> FTxPowerLevel then
    FTxPowerLevel := ATxPowerLevel;
end;

function TMacBluetoothLEAdvertiseData.GetTxPowerLevel: Integer;
begin
  Result := FTxPowerLevel;
end;

procedure TMacBluetoothLEAdvertiseData.SetManufacturerSpecificData(const AManufacturerSpecificData: TBytes);
begin
  FManufacturerSpecificData := AManufacturerSpecificData;
end;

function TMacBluetoothLEAdvertiseData.GetManufacturerSpecificData: TBytes;
begin
  Result := FManufacturerSpecificData;
end;

{$ENDIF !BLUETOOTH_LE}
end.
