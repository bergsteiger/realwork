{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Macapi.Bluetooth;

interface

{$MINENUMSIZE 1}

uses
  Macapi.ObjectiveC, Macapi.ObjCRuntime, Macapi.Consts, Macapi.Dispatch,
{$IFDEF IOS}
  iOSapi.CocoaTypes, iOSapi.Foundation,
{$ELSE}
  Macapi.CocoaTypes, Macapi.Foundation,
{$ENDIF}
  System.SysUtils;

const
  kIOBluetoothDeviceSearchClassic = 1;
  {$EXTERNALSYM kIOBluetoothDeviceSearchClassic}
  kBluetoothSDPDataElementTypeNil = 0;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeNil}
  kBluetoothSDPDataElementTypeUnsignedInt = 1;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeUnsignedInt}
  kBluetoothSDPDataElementTypeSignedInt = 2;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeSignedInt}
  kBluetoothSDPDataElementTypeUUID = 3;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeUUID}
  kBluetoothSDPDataElementTypeString = 4;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeString}
  kBluetoothSDPDataElementTypeBoolean = 5;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeBoolean}
  kBluetoothSDPDataElementTypeDataElementSequence = 6;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeDataElementSequence}
  kBluetoothSDPDataElementTypeDataElementAlternative = 7;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeDataElementAlternative}
  kBluetoothSDPDataElementTypeURL = 8;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeURL}
  kBluetoothSDPDataElementTypeReservedStart = 9;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeReservedStart}
  kBluetoothSDPDataElementTypeReservedEnd = 31;
  {$EXTERNALSYM kBluetoothSDPDataElementTypeReservedEnd}
  BASEGUID = '-0000-1000-8000-00805F9B34FB'; // 00000000-0000-1000-8000-00805F9B34FB;
  {$EXTERNALSYM BASEGUID}
  kIOReturnSuccess = 0;
  {$EXTERNALSYM kIOReturnSuccess}

  libBluetooth = '/System/Library/Frameworks/IOBluetooth.framework/IOBluetooth';
  {$EXTERNALSYM libBluetooth}
{$IFDEF IOS}
  libCoreBluetooth = '/System/Library/Frameworks/CoreBluetooth.framework/CoreBluetooth';
{$ELSE}
  libCoreBluetooth = '/System/Library/Frameworks/IOBluetooth.framework/Frameworks/CoreBluetooth.framework/CoreBluetooth';
{$ENDIF}
  {$EXTERNALSYM libCoreBluetooth}

type
{$M+}
  id = Pointer;
{$If defined(MACOS) and NOT defined(IOS)}
  IOBluetoothDeviceInquiry = interface;
  IOBluetoothDevice = interface;
  IOBluetoothDeviceInquiryDelegate = interface;
  IOBluetoothDevicePair = interface;
  IOBluetoothHostController = interface;
  IOBluetoothSDPServiceRecord = interface;
  IOBluetoothSDPUUID = interface;
  IOBluetoothSDPDataElement = interface;
  IOBluetoothL2CAPChannel = interface;
  IOBluetoothRFCOMMChannel = interface;
  IOBluetoothPairingController = interface;
  IOBluetoothDeviceSelectorController = interface;
  IOBluetoothServiceBrowserController = interface;

  BluetoothDeviceAddress = record
    data: array[0..5] of Byte;
  end;
  PBluetoothDeviceAddress = ^BluetoothDeviceAddress;

  BluetoothPINCode = record
    data: array[0..15] of Byte;
  end;
  PBluetoothPINCode = ^BluetoothPINCode;

  BluetoothClassOfService = UInt32;
  BluetoothDeviceClassMajor = UInt32;
  BluetoothDeviceClassMinor = UInt32;
  BluetoothClassOfDevice = UInt32;
  BluetoothServiceClassMajor = UInt32;
  BluetoothClockOffset = UInt16;
  ByteCount = UInt32;
  BluetoothConnectionHandle = UInt16;
  IOReturn = Int32;
  BluetoothNumericValue = UInt32;
  BluetoothPasskey = UInt32;
  BluetoothSDPUUID16 = UInt16;
  BluetoothSDPUUID32 = UInt32;
  BluetoothSDPServiceRecordHandle = UInt32;
  BluetoothSDPTransactionID = UInt16;
  BluetoothRFCOMMChannelID = UInt8;
  BluetoothSDPServiceAttributeID = UInt16;
  BluetoothL2CAPPSM = UInt16;
  BluetoothHCIPageTimeout = UInt16;
  BluetoothHCIEventStatus = UInt8;
  BluetoothSDPDataElementTypeDescriptor = UInt8;
  BluetoothSDPDataElementSizeDescriptor = UInt8;
  BluetoothHCIRSSIValue = ShortInt; { Valid Range: -127 to 20 }
  BluetoothL2CAPChannelID = UInt16;
  IOBluetoothObjectID = NativeUInt;
  BluetoothL2CAPMTU = UInt16;
  BluetoothRFCOMMMTU = UInt16;

  BluetoothHCIPowerState = (kBluetoothHCIPowerStateOn = 1, kBluetoothHCIPowerStateOff = 0,
    kBluetoothHCIPowerStateUninitialized = $FF);

  BluetoothHCIEncryptionMode = (kEncryptionDisabled = 0, kEncryptionOnlyForPointToPointPackets = 1,
    kEncryptionForBothPointToPointAndBroadcastPackets = 2);

  BluetoothLinkType = (kBluetoothSCOConnection = 0, kBluetoothACLConnection = 1, kBluetoothESCOConnection = 2,
    kBluetoothLinkTypeNone = 255);

  BluetoothPageScanMode = (kBluetoothPageScanModeMandatory = 0, kBluetoothPageScanModeOptional1 = 1,
    kBluetoothPageScanModeOptional2 = 2, kBluetoothPageScanModeOptional3 = 3);

  BluetoothPageScanPeriodMode = (kBluetoothPageScanPeriodMode0 = 0, kBluetoothPageScanPeriodMode1 = 1,
    kBluetoothPageScanPeriodMode2 = 2);

  BluetoothPageScanRepetitionMode = (kBluetoothPageScanRepetitionMode0 = 0, kBluetoothPageScanRepetitionMode1 = 1,
    kBluetoothPageScanRepetitionMode2 = 2);

  IOBluetoothUserNotificationChannelDirection = (IOBluetoothUserNotificationChannelDirectionAny = 0,
    IOBluetoothUserNotificationChannelDirectionIncoming = 1, IOBluetoothUserNotificationChannelDirectionOutgoing = 2);

  BluetoothRFCOMMLineStatus = (BluetoothRFCOMMLineStatusNoError = 0, BluetoothRFCOMMLineStatusOverrunError,
    BluetoothRFCOMMLineStatusParityError, BluetoothRFCOMMLineStatusFramingError);

  BluetoothRFCOMMParityType = (kBluetoothRFCOMMParityTypeNoParity = 0, kBluetoothRFCOMMParityTypeOddParity,
    kBluetoothRFCOMMParityTypeEvenParity, kBluetoothRFCOMMParityTypeMaxParity);

  IOBluetoothHostControllerClass = interface(NSObjectClass)
  ['{BDF675E9-1AAC-4F19-AFAE-C6C559ED1624}']
    {class} function defaultController: IOBluetoothHostController; cdecl;
  end;

  IOBluetoothHostController = interface(NSObject)
  ['{3EFA67D6-2B1C-4FC0-A05C-5D1C2555EE1C}']
    function powerState: BluetoothHCIPowerState; cdecl;
    function addressAsString: NSString; cdecl;
    function classOfDevice: BluetoothClassOfDevice; cdecl;
    function nameAsString: NSString; cdecl;
    function setClassOfDevice(classOfDevice: BluetoothClassOfDevice; forTimeInterval: NSTimeInterval): IOReturn; cdecl;
  end;
  TIOBluetoothHostController = class(TOCGenericImport<IOBluetoothHostControllerClass, IOBluetoothHostController>)  end;

  IOBluetoothUserNotificationClass = interface(NSObjectClass)
  ['{80A3FFC4-241D-4025-BFEA-EA6BC558FED1}']
  end;

  IOBluetoothUserNotification = interface(NSObject)
  ['{9FF7BCC7-CCE6-45A6-B032-29868265F68D}']
    procedure unregister; cdecl;
  end;
  TIOBluetoothUserNotification = class(TOCGenericImport<IOBluetoothUserNotificationClass, IOBluetoothUserNotification>)  end;

  IOBluetoothSDPDataElementRef = ^IOBluetoothSDPDataElement;
  IOBluetoothSDPDataElementClass = interface(NSObjectClass)
    ['{73C9B94D-CB55-4FF9-8A6C-481A8410C349}']
    {class} function withElementValue(element: NSObject): IOBluetoothSDPDataElement; cdecl;
    {class} function withSDPDataElementRef(sdpDataElementRef: IOBluetoothSDPDataElementRef): IOBluetoothSDPDataElement; cdecl;
    {class} function withType(typeDescriptor: BluetoothSDPDataElementTypeDescriptor;
      sizeDescriptor: BluetoothSDPDataElementSizeDescriptor; size: UInt32; value: NSObject): IOBluetoothSDPDataElement; cdecl;
  end;

  IOBluetoothSDPDataElement = interface(NSObject)
    ['{77FDB971-C3B8-4DC7-B7AE-F8A63D35C44D}']
    function containsDataElement(dataElement: IOBluetoothSDPDataElement): Boolean; cdecl;
    function containsValue(cmpValue: NSObject): Boolean; cdecl;
    function getArrayValue: NSArray; cdecl;
    function getDataValue: NSData; cdecl;
    function getNumberValue: NSNumber; cdecl;
    function getSDPDataElementRef: IOBluetoothSDPDataElementRef; cdecl;
    function getSize: UInt32; cdecl;
    function getSizeDescriptor: BluetoothSDPDataElementSizeDescriptor; cdecl;
    function getStringValue: NSString; cdecl;
    function getTypeDescriptor: BluetoothSDPDataElementTypeDescriptor; cdecl;
    function getUUIDValue: IOBluetoothSDPUUID; cdecl;
    function getValue: NSObject; cdecl;
    function initWithElementValue(element: NSObject): id; cdecl;
    function initWithType(typeDescriptor: BluetoothSDPDataElementTypeDescriptor;
      sizeDescriptor: BluetoothSDPDataElementSizeDescriptor; size: UInt32; value: NSObject): id; cdecl;
  end;
  TIOBluetoothSDPDataElement = class(TOCGenericImport<IOBluetoothSDPDataElementClass, IOBluetoothSDPDataElement>)  end;

  IOBluetoothSDPUUIDClass = interface(NSDataClass)
  ['{865A68A2-69D8-41AD-A458-A6A0838A136C}']
    {class} function uuid16(uuid16: BluetoothSDPUUID16): IOBluetoothSDPUUID; cdecl;
    {class} function uuid32(uuid32: BluetoothSDPUUID32): IOBluetoothSDPUUID; cdecl;
    {class} function uuidWithBytes(bytes: Pointer; length: UInt32): IOBluetoothSDPUUID; cdecl;
    {class} function uuidWithData(data: NSData): IOBluetoothSDPUUID; cdecl;
  end;

  IOBluetoothSDPUUID = interface(NSData)
  ['{530DADF7-4FAD-4576-8A74-F9B274E3D67A}']
    function getUUIDWithLength(newLength: UInt32): IOBluetoothSDPUUID; cdecl;
    function initWithUUID16(uuid16: BluetoothSDPUUID16): id; cdecl;
    function initWithUUID32(uuid32: BluetoothSDPUUID32): id; cdecl;
    function isEqualToUUID(otherUUID: IOBluetoothSDPUUID): Boolean; cdecl;
  end;
  TIOBluetoothSDPUUID = class(TOCGenericImport<IOBluetoothSDPUUIDClass, IOBluetoothSDPUUID>)  end;

  IOBluetoothSDPServiceRecordRef = ^IOBluetoothSDPServiceRecord;
  IOBluetoothSDPServiceRecordClass = interface(NSObjectClass)
  ['{84377C25-C46C-4A42-B3B9-CDE355362023}']
    function publishedServiceRecordWithDictionary(serviceDict: NSDictionary): IOBluetoothSDPServiceRecord; cdecl;
    function withSDPServiceRecordRef(sdpServiceRecordRef: IOBluetoothSDPServiceRecordRef): IOBluetoothSDPServiceRecord; cdecl;
    function withServiceDictionary(serviceDict: NSDictionary; device: IOBluetoothDevice): IOBluetoothSDPServiceRecord; cdecl;
  end;

  IOBluetoothSDPServiceRecord = interface(NSObject)
  ['{9DD46713-7933-4BC9-9F61-4388C0E0604F}']
    function attributes: NSDictionary; cdecl;
    function sortedAttributtes: NSArray; cdecl;
    function getAttributeDataElement(attributeID: BluetoothSDPServiceAttributeID): IOBluetoothSDPDataElement; cdecl;
    function getL2CAPPSM(var outPSM: BluetoothL2CAPPSM): IOReturn; cdecl;
    function getRFCOMMChannelID(var rfcommChannelID: BluetoothRFCOMMChannelID): IOReturn; cdecl;
    function getSDPServiceRecordRef: IOBluetoothSDPServiceRecordRef; cdecl;
    function getServiceName: NSString; cdecl;
    function getServiceRecordHandle(var outServiceRecordHandle: BluetoothSDPServiceRecordHandle): IOReturn; cdecl;
    function hasServiceFromArray(&array: NSArray): Boolean; cdecl;
    function initWithServiceDictionary(serviceDict: NSDictionary; device: IOBluetoothDevice): id; cdecl;
    function matchesSearchArray(searchArray: NSArray): Boolean; cdecl;
    function matchesUUID16(uuid16: BluetoothSDPUUID16): Boolean; cdecl;
    function matchesUUIDArray(uuidArray: NSArray): Boolean; cdecl;
    function removeServiceRecord: IOReturn; cdecl;
  end;
  TIOBluetoothSDPServiceRecord = class(TOCGenericImport<IOBluetoothSDPServiceRecordClass, IOBluetoothSDPServiceRecord>)  end;

  IOBluetoothL2CAPChannelClass = interface(NSObjectClass)
  ['{B5AF0B85-8C17-4A35-90A1-030AAE80D21A}']
    {class} function registerForChannelOpenNotifications(&object: id; selector: SEL): IOBluetoothUserNotification; cdecl; overload;
    {class} function registerForChannelOpenNotifications(&object: id; selector: SEL; psm: BluetoothL2CAPPSM;
      inDirection: IOBluetoothUserNotificationChannelDirection): IOBluetoothUserNotification; cdecl; overload;
    {class} function withObjectID(objectID: IOBluetoothObjectID): IOBluetoothL2CAPChannel; cdecl;
  end;

  IOBluetoothL2CAPChannel = interface(NSObject)
  ['{F041F214-BBB6-47AD-89CE-CF10D766616C}']
    function device: IOBluetoothDevice; cdecl;
    function incomingMTU: BluetoothL2CAPMTU; cdecl;
    function localChannelID: BluetoothL2CAPChannelID; cdecl;
    function objectID: IOBluetoothObjectID; cdecl;
    function outgoingMTU: BluetoothL2CAPMTU; cdecl;
    function PSM: BluetoothL2CAPPSM; cdecl;
    function remoteChannelID: BluetoothL2CAPChannelID; cdecl;

    function closeChannel: IOReturn; cdecl;
    function delegate: id; cdecl;
    function isIncoming: Boolean; cdecl;
    function registerForChannelCloseNotification(observer: id; inSelector: SEL): IOBluetoothUserNotification; cdecl;
    function requestRemoteMTU(remoteMTU: BluetoothL2CAPMTU): IOReturn; cdecl;
    function setDelegate(channelDelegate: id): IOReturn; cdecl; overload;
    function setDelegate(channelDelegate: id; channelConfiguration: NSDictionary): IOReturn; cdecl; overload;
    function writeAsync(data: Pointer; length: UInt16; refcon: Pointer): IOReturn; cdecl;
    function writeSync(data: Pointer; length: UInt16): IOReturn; cdecl;
  end;
  TIOBluetoothL2CAPChannel = class(TOCGenericImport<IOBluetoothL2CAPChannelClass, IOBluetoothL2CAPChannel>)  end;
  PIOBluetoothL2CAPChannel = ^IOBluetoothL2CAPChannel;

  IOBluetoothRFCOMMChannelRef = ^IOBluetoothRFCOMMChannel;
  IOBluetoothRFCOMMChannelClass = interface(NSObjectClass)
  ['{534DEFCF-C8F8-4D2C-8F2B-500EFF06C1FB}']
    {class} function registerForChannelOpenNotifications(aobject: id; selector: SEL;
      withChannelID: BluetoothRFCOMMChannelID; direction: UInt8 {IOBluetoothUserNotificationChannelDirection}): IOBluetoothUserNotification; cdecl; overload;
    {class} function registerForChannelOpenNotifications(aobject: id; selector: SEL): IOBluetoothUserNotification; cdecl; overload;
    {class} function withObjectID(objectID: IOBluetoothObjectID): IOBluetoothRFCOMMChannel; cdecl;
    {class} function withRFCOMMChannelRef(rfcommChannelRef: IOBluetoothRFCOMMChannelRef): IOBluetoothRFCOMMChannel; cdecl;
  end;

  IOBluetoothRFCOMMChannel = interface(NSObject)
  ['{69D6FE8A-5D97-4CF6-B48C-06A98B2B7051}']
    function closeChannel: IOReturn; cdecl;
    function delegate: id; cdecl;
    function getChannelID: BluetoothRFCOMMChannelID; cdecl;
    function getDevice: IOBluetoothDevice; cdecl;
    function getMTU: BluetoothRFCOMMMTU; cdecl;
    function getObjectID: IOBluetoothObjectID; cdecl;
    function getRFCOMMChannelRef: IOBluetoothRFCOMMChannelRef; cdecl;
    function isIncoming: Boolean; cdecl;
    function isOpen: Boolean; cdecl;
    function isTransmissionPaused: Boolean; cdecl;
    function registerForChannelCloseNotification(observer: id; selector: SEL): IOBluetoothUserNotification; cdecl;
    function sendRemoteLineStatus(lineStatus: BluetoothRFCOMMLineStatus): IOReturn; cdecl;
    function setDelegate(delegate: id): IOReturn; cdecl;
    function setSerialParameters(speed: UInt32; nBits: UInt8; parity: BluetoothRFCOMMParityType; bitStop: UInt8): IOReturn; cdecl;
    function writeAsync(data: Pointer; length: UInt16; refcon: Pointer): IOReturn; cdecl;
    function writeSync(data: Pointer; length: UInt16): IOReturn; cdecl;
  end;
  TIOBluetoothRFCOMMChannel = class(TOCGenericImport<IOBluetoothRFCOMMChannelClass, IOBluetoothRFCOMMChannel>)  end;
  PIOBluetoothRFCOMMChannel = ^IOBluetoothRFCOMMChannel;

  IBluetoothRFCOMMOpenChannelDelegate = interface(IObjectiveC)
  ['{673A6EEF-3D7F-4CE5-B9D3-4E919AF28F49}']
    procedure newRFCOMMChannelOpened(inNotification: Pointer; newChannel: Pointer); cdecl;
  end;

  IBluetoothRFCOMMChannelDelegate = interface(IObjectiveC)
  ['{148E7F96-111D-4B34-AF4D-260032AF66E1}']
    procedure rfcommChannelData(rfcommChannel: Pointer{IOBluetoothRFCOMMChannel}; data: Pointer; length: UInt32); cdecl;
    procedure rfcommChannelOpenComplete(rfcommChannel: Pointer; status: IOReturn); cdecl;
    procedure rfcommChannelClosed(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelControlSignalsChanged(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelFlowControlChanged(rfcommChannel: Pointer); cdecl;
    procedure rfcommChannelWriteComplete(rfcommChannel: Pointer; refcon: Pointer; status: IOReturn); cdecl;
    procedure rfcommChannelQueueSpaceAvailable(rfcommChannel: Pointer); cdecl;
  end;

  IOBluetoothDeviceInquiryClass = interface(NSObjectClass)
  ['{B2F60B82-67D6-43F4-84EA-532487466656}']
    {class} function inquiryWithDelegate(delegate: Pointer): IOBluetoothDeviceInquiry; cdecl;
  end;

  IOBluetoothDeviceInquiry = interface(NSObject)
  ['{28891585-44B5-4A92-AE51-6084F8BF917D}']
    function inquiryLength: Byte; cdecl;
    function searchTypes: UInt32; {IOBluetoothDeviceSearchTypes;} cdecl;
    function updateNewDeviceNames: Boolean; cdecl;
    procedure clearFoundDevices; cdecl;
    function foundDevices: NSArray; cdecl;
    procedure setSearchCriteria(majorDeviceClass: BluetoothServiceClassMajor; minorDeviceClass: BluetoothDeviceClassMinor); cdecl;
    function start: IOReturn; cdecl;
    function stop: IOReturn; cdecl;
    procedure setInquiryLength(inquiryLength: Byte); cdecl;
    procedure setSearchTypes(searchTypes: UInt32); cdecl;
    procedure setUpdateNewDeviceNames(updateNewDevicenames: Boolean); cdecl;
  end;
  TIOBluetoothDeviceInquiry = class(TOCGenericImport<IOBluetoothDeviceInquiryClass, IOBluetoothDeviceInquiry>)  end;

  IOBluetoothDeviceClass = interface(NSObjectClass)
  ['{EFEF185F-BB4D-4E3D-AF20-36979154F962}']
    {class} function deviceWithAddress(address: BluetoothDeviceAddress): IOBluetoothDevice; cdecl;
    {class} function deviceWithAddressString(address: NSString): IOBluetoothDevice; cdecl;
    {class} function favoriteDevices: NSArray; cdecl;
    {class} function pairedDevices: NSArray; cdecl;
    {class} function recentDevices(numDevices: NativeUInt): NSArray; cdecl;
    {class} function registerForConnectNotifications(observer: id; inSelector: SEL): IOBluetoothUserNotification; cdecl;
  end;

  IOBluetoothDevice = interface(NSObject)
  ['{83D7173C-B323-4F80-ABB6-226D406D796D}']
    function addressString: NSString; cdecl;
    function classOfDevice: BluetoothClassOfDevice; cdecl;
    function connectionHandle: BluetoothConnectionHandle; cdecl;
    function deviceClassMajor: BluetoothDeviceClassMajor; cdecl;
    function deviceClassMinor: BluetoothDeviceClassMinor; cdecl;
    function lastNameUpdate: NSDate; cdecl;
    function name: NSString; cdecl;
    function nameOrAddress: NSString; cdecl;
    function serviceClassMajor: BluetoothServiceClassMajor; cdecl;
    function services: NSArray; cdecl;

    function addToFavorites: UInt32; cdecl;
    function closeConnection: UInt32; cdecl;
    function getAddress: BluetoothDeviceAddress; cdecl;
    function getClockOffset: BluetoothClockOffset; cdecl;
    function getEncryptionMode: BluetoothHCIEncryptionMode; cdecl;
    function getLastInquiryUpdate: NSDate; cdecl;
    function getLastServicesUpdate: NSDate; cdecl;
    function getLinkType: BluetoothLinkType; cdecl;
    function getPageScanMode: BluetoothPageScanMode; cdecl;
    function getPageScanPeriodMode: BluetoothPageScanPeriodMode; cdecl;
    function getPageScanRepetitionMode: BluetoothPageScanRepetitionMode; cdecl;
    function getServiceRecordForUUID(sdpUUID: IOBluetoothSDPUUID): IOBluetoothSDPServiceRecord; cdecl;
    function isConnected: Boolean; cdecl;
    function isFavorite: Boolean; cdecl;
    function isIncoming: Boolean; cdecl;
    function isPaired: Boolean; cdecl;
    function openConnection: UInt32; cdecl; overload;
    function openConnection(target: id): UInt32; cdecl; overload;
    function openConnection(target: id; withPageTimeout: BluetoothHCIPageTimeout; authenticationRequired: Boolean): IOReturn; cdecl; overload;
    function openL2CAPChannelAsync(newChannel: PIOBluetoothL2CAPChannel; psm: BluetoothL2CAPPSM; channelDelegate: id): IOReturn; cdecl; overload;
    function openL2CAPChannelAsync(newChannel: PIOBluetoothL2CAPChannel; psm: BluetoothL2CAPPSM;
      channelConfiguration: NSDictionary; delegate: id): IOReturn; cdecl; overload;
    function openL2CAPChannelSync(newChannel: PIOBluetoothL2CAPChannel; psm: BluetoothL2CAPPSM; delegate: id): IOReturn; cdecl; overload;
    function openL2CAPChannelSync(newChannel: PIOBluetoothL2CAPChannel; psm: BluetoothL2CAPPSM;
      channelConfiguration: NSDictionary; delegate: id): IOReturn; cdecl; overload;
    function openRFCOMMChannelAsync(rfcommChannel: Pointer{PIOBluetoothRFCOMMChannel}; withChannelID: BluetoothRFCOMMChannelID;
      delegate: id): IOReturn; cdecl;
    function openRFCOMMChannelSync(rfcommChannel: Pointer{PIOBluetoothRFCOMMChannel}; withChannelID: BluetoothRFCOMMChannelID;
      delegate: id): IOReturn; cdecl;
    function performSDPQuery(target: id): IOReturn; cdecl; overload;
    function performSDPQuery(target: id; uuidArray: NSArray): IOReturn; cdecl; overload;
    function rawRSSI: BluetoothHCIRSSIValue; cdecl;
    function recentAccessDate: NSDate; cdecl;
    function registerForDisconnectNotification(observer: id; inSelector: SEL): IOBluetoothUserNotification; cdecl;
    function remoteNameRequest(target: id): IOReturn; cdecl; overload;
    function remoteNameRequest(target: id; pageTimeoutValue: BluetoothHCIPageTimeout): IOReturn; cdecl; overload;
    function removeFromFavorites: IOReturn; cdecl;
    function requestAuthentication: IOReturn; cdecl;
    function RSSI: BluetoothHCIRSSIValue; cdecl;
    function sendL2CAPEchoRequest(data: Pointer; length: UInt16): IOReturn; cdecl;
    function setSupervisionTimeout(timeout: UInt16): IOReturn; cdecl;
  end;
  TIOBluetoothDevice = class(TOCGenericImport<IOBluetoothDeviceClass, IOBluetoothDevice>)  end;

  IOBluetoothDeviceInquiryDelegate = interface(IObjectiveC)
  ['{DA17DA7E-4ED9-42E5-AEE0-C30A78D17EA0}']
    procedure deviceInquiryComplete(sender: IOBluetoothDeviceInquiry; error: UInt32; aborted: Boolean); cdecl;
    procedure deviceInquiryDeviceFound(sender: IOBluetoothDeviceInquiry; device: IOBluetoothDevice); cdecl;
    procedure deviceInquiryDeviceNameUpdated(sender: IOBluetoothDeviceInquiry; device: IOBluetoothDevice; devicesRemaining: UInt32); cdecl;
    procedure deviceInquiryStarted(sender: IOBluetoothDeviceInquiry); cdecl;
    procedure deviceInquiryUpdatingDeviceNamesStarted(sender: IOBluetoothDeviceInquiry; devicesRemaining: UInt32); cdecl;
  end;

  IOBluetoothDevicePairClass = interface(NSObjectClass)
  ['{D1AD8DB8-9E7C-4FDC-835B-A40D4AAC3265}']
    {class} function pairWithDevice(device: IOBluetoothDevice): IOBluetoothDevicePair; cdecl;
  end;

  IOBluetoothDevicePair = interface(NSObject)
  ['{AF90E375-D4FC-4C45-B5B3-AB06E85ECACE}']
    function device: IOBluetoothDevice; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure replyPINCode(PINCodeSize: ByteCount; PINCode: PBluetoothPINCode); cdecl;
    procedure replyUserConfirmation(reply: Boolean); cdecl;
    procedure setDevice(inDevice: IOBluetoothDevice); cdecl;
    function start: Integer; cdecl;
    function stop: Integer; cdecl;
  end;
  TIOBluetoothDevicePair = class(TOCGenericImport<IOBluetoothDevicePairClass, IOBluetoothDevicePair>)  end;

  IOBluetoothDevicePairDelegate = interface(IObjectiveC)
  ['{C98CA892-DDE3-4B23-8363-D8DA0BA71CCB}']
    procedure devicePairingStarted(sender: id); cdecl;
    procedure devicePairingConnecting(sender: id); cdecl;
    procedure devicePairingPINCodeRequest(sender: id); cdecl;
    procedure devicePairingUserConfirmationRequest(sender: id; numericValue: BluetoothNumericValue); cdecl;
    procedure devicePairingUserPasskeyNotification(sender: id; passkey: BluetoothPasskey); cdecl;
    procedure devicePairingFinished(sender: id; error: IOReturn); cdecl;
    procedure deviceSimplePairingFinished(sender: id; status: BluetoothHCIEventStatus); cdecl;
  end;

  IOBluetoothPairingControllerClass = interface(NSObjectClass)
  ['{085AD3A4-2EC9-4EC9-BCCD-6EDFE5FF6EFF}']
    {class} function pairingController: IOBluetoothPairingController; cdecl;
  end;

  IOBluetoothPairingController = interface(NSObject)
  ['{8DA8BDF7-2882-4F54-8A8F-4CFB5A190591}']
    function runModal: Integer; cdecl;
  end;
  TIOBluetoothPairingController = class(TOCGenericImport<IOBluetoothPairingControllerClass, IOBluetoothPairingController>)  end;

  IOBluetoothDeviceSelectorControllerClass = interface(NSObjectClass)
  ['{380D6E70-2311-463A-A656-3C2EE0C722DF}']
    {class} function deviceSelector: IOBluetoothDeviceSelectorController; cdecl;
  end;

  IOBluetoothDeviceSelectorController = interface(NSObject)
  ['{C09341DF-0EF4-4532-B4AC-A780016F11EE}']
    function runModal: Integer; cdecl;
  end;
  TIOBluetoothDeviceSelectorController = class(TOCGenericImport<IOBluetoothDeviceSelectorControllerClass, IOBluetoothDeviceSelectorController>)  end;

  IOBluetoothServiceBrowserControllerClass = interface(NSObjectClass)
  ['{380D6E70-2311-463A-A656-3C2EE0C722DF}']
    {class} function serviceBrowserController(inOptions: UInt32): IOBluetoothServiceBrowserController; cdecl;
  end;

  IOBluetoothServiceBrowserController = interface(NSObject)
  ['{C09341DF-0EF4-4532-B4AC-A780016F11EE}']
    function runModal: Integer; cdecl;
  end;
  TIOBluetoothServiceBrowserController = class(TOCGenericImport<IOBluetoothServiceBrowserControllerClass, IOBluetoothServiceBrowserController>)  end;

{$ENDIF defined(MACOS) and NOT defined(IOS)}

  { Bluetooth LE API }

  CBCentralManagerState = (CBCentralManagerStateUnknown = 0, CBCentralManagerStateResetting, CBCentralManagerStateUnsupported,
    CBCentralManagerStateUnauthorized, CBCentralManagerStatePoweredOff, CBCentralManagerStatePoweredOn);

  CBCharacteristicWriteType = (CBCharacteristicWriteWithResponse = 0, CBCharacteristicWriteWithoutResponse);

  CBPeripheralState = (CBPeripheralStateDisconnected = 0, CBPeripheralStateConnecting, CBPeripheralStateConnected);

  CBCharacteristicProperties = UInt16;
  CBAttributePermissions = UInt8;

const
  CBCharacteristicPropertyBroadcast = $01;
  CBCharacteristicPropertyRead = $02;
  CBCharacteristicPropertyWriteWithoutResponse = $04;
  CBCharacteristicPropertyWrite = $08;
  CBCharacteristicPropertyNotify = $10;
  CBCharacteristicPropertyIndicate = $20;
  CBCharacteristicPropertyAuthenticatedSignedWrites = $40;
  CBCharacteristicPropertyExtendedProperties = $80;
  CBCharacteristicPropertyNotifyEncryptionRequired = $100;
  CBCharacteristicPropertyIndicateEncryptionRequired = $200;

  CBAttributePermissionsReadable = $01;
  CBAttributePermissionsWriteable = $02;
  CBAttributePermissionsReadEncryptionRequired = $04;
  CBAttributePermissionsWriteEncryptionRequired = $08;

type
  CFUUIDRef = Pointer;
  CBUUID = interface(NSObject)
  ['{995CEAD8-892B-4EA7-B627-638C5EF1F4B2}']
    function data: NSData; cdecl;
  end;
  CBUUIDClass = interface(NSObjectClass)
  ['{56E591FF-4BC1-4FC6-9FB7-2DC4E6DA8D9C}']
    {class} function UUIDWithCFUUID(theUUID: CFUUIDRef): CBUUID; cdecl;
    {class} function UUIDWithData(theData: NSData): CBUUID; cdecl;
    {class} function UUIDWithNSUUID(theUUID: NSUUID): CBUUID; cdecl;
    {class} function UUIDWithString(theString: NSString): CBUUID; cdecl;
  end;

  TCBUUID = class(TOCGenericImport<CBUUIDClass, CBUUID>)  end;

  CBServiceClass = interface(NSObjectClass)
  ['{772D1637-D6A7-469C-A455-D4573849F7EE}']
  end;

  CBService = interface(NSObject)
  ['{5D492AFB-27B2-4156-BAA6-83239A623667}']
    function characteristics: NSArray; cdecl;
    function includedServices: NSArray; cdecl;
    function isPrimary: Boolean; cdecl;
    function peripheral: Pointer;{CBPeripheral;} cdecl;
    function UUID: CBUUID; cdecl;
  end;
  TCBService = class(TOCGenericImport<CBServiceClass, CBService>)  end;

  CBCharacteristicClass = interface(NSObjectClass)
  ['{5057C68A-39B5-4F35-AD42-7CA63E8F5A72}']
  end;

  CBCharacteristic = interface(NSObject)
  ['{189857D0-0AF7-4559-819F-EF98355180FD}']
    function descriptors: NSArray; cdecl;
    function isBroadcasted: Boolean; cdecl;
    function isNotifying: Boolean; cdecl;
    function properties: CBCharacteristicProperties; cdecl;
    function service: CBService; cdecl;
    function UUID: CBUUID; cdecl;
    function value: NSData; cdecl;
  end;
  TCBCharacteristic = class(TOCGenericImport<CBCharacteristicClass, CBCharacteristic>)  end;

  CBMutableCharacteristicClass = interface(CBCharacteristicClass)
  ['{0CFB069D-5DC7-46C9-9844-7424D4B36A4D}']
  end;

  CBMutableCharacteristic = interface(CBCharacteristic)
  ['{73C19465-F2D8-439F-AC5F-BC0AA205E867}']
    procedure setValue(value: NSData); cdecl;
    function permissions: CBAttributePermissions; cdecl;
    procedure setPermissions(permissions: CBAttributePermissions); cdecl;
    function subscribedCentrals: NSArray; cdecl;
    procedure setSubscribedCentrals(subscribedCentrals: NSArray); cdecl;
    procedure setDescriptors(descriptors: NSArray); cdecl;
    function initWithType(UUID: CBUUID; properties: CBCharacteristicProperties; value: NSData; permissions: CBAttributePermissions): id; cdecl;
  end;
  TCBMutableCharacteristic = class(TOCGenericImport<CBMutableCharacteristicClass, CBMutableCharacteristic>)  end;

  CBDescriptorClass = interface(NSObjectClass)
  ['{3C40361F-B981-4F30-A060-42EDFCE97E56}']
  end;

  CBDescriptor = interface(NSObject)
  ['{34CE2617-A15D-4EF3-A97E-299A4E7F80EA}']
    function characteristic: CBCharacteristic; cdecl;
    function UUID: CBUUID; cdecl;
    function value: id; cdecl;
  end;
  TCBDescriptor = class(TOCGenericImport<CBDescriptorClass, CBDescriptor>)  end;

  CBMutableDescriptorClass = interface(CBDescriptorClass)
  ['{D7B6A773-A601-4629-9FF8-9702D49F6988}']
  end;

  CBMutableDescriptor = interface(CBDescriptor)
  ['{BA0E8A73-5673-4AE0-86C0-86DF97BF1D36}']
    function initWithType(UUID: CBUUID; value: id): id; cdecl;
  end;
  TCBMutableDescriptor = class(TOCGenericImport<CBMutableDescriptorClass, CBMutableDescriptor>)  end;

  CBMutableServiceClass = interface(CBServiceClass)
  ['{772D1637-D6A7-469C-A455-D4573849F7EE}']
  end;

  CBMutableService = interface(CBService)
  ['{40180826-45F8-47AF-940C-17A1FD3391A7}']
    function initWithType(UUID: CBUUID; primary: Boolean): id; cdecl;
    procedure setCharacteristics(characteristics: NSArray); cdecl;
    procedure setIncludedServices(services: NSArray); cdecl;
  end;
  TCBMutableService = class(TOCGenericImport<CBMutableServiceClass, CBMutableService>)  end;

  CBPeripheralClass = interface(NSObjectClass)
  ['{B1B5C4C9-84A7-4ABE-A82E-66DB0A50392B}']
  end;

  CBPeripheral = interface(NSObject)
  ['{C51D2286-153F-4156-AF4C-F57A029CDD1D}']
    function delegate: id; cdecl;
    procedure setDelegate(delegate: id); cdecl;
    function identifier: NSUUID; cdecl;
    function isConnected: Boolean; cdecl; { deprecated on MacOS 10.9 / iOS 7.0 }
    function name: NSString; cdecl;
    function RSSI: NSNumber; cdecl;
    function services: NSArray; cdecl;
    function state: CBPeripheralState; cdecl;
    function UUID: CFUUIDRef; cdecl; { deprecated on MacOS 10.9 / iOS 7.0 }
    procedure discoverCharacteristics(characteristicUUIDs: NSArray; forService: CBService); cdecl;
    procedure discoverDescriptorsForCharacteristic(characteristic: CBCharacteristic); cdecl;
    procedure discoverIncludedServices(includedServiceUUIDs: NSArray; forService: CBService); cdecl;
    procedure discoverServices(serviceUUIDs: NSArray); cdecl;
    procedure readRSSI; cdecl;
    procedure readValueForCharacteristic(characteristic: CBCharacteristic); cdecl;
    procedure readValueForDescriptor(descriptor: CBDescriptor); cdecl;
    procedure setNotifyValue(enabled: Boolean; forCharacteristic: CBCharacteristic); cdecl;
    [MethodName('writeValue:forCharacteristic:type:')]
    procedure writeValue(data: NSData; characteristic: CBCharacteristic; &type: CBCharacteristicWriteType); cdecl; overload;
    procedure writeValue(data: NSData; forDescriptor: CBDescriptor); cdecl; overload;
  end;
  TCBPeripheral = class(TOCGenericImport<CBPeripheralClass, CBPeripheral>)  end;

  CBCentralManagerClass = interface(NSObjectClass)
  ['{BC305559-F794-4C69-977C-A6F04D5F012B}']
  end;

  CBCentralManager = interface(NSObject)
  ['{587D1855-5B53-43DA-91AF-AF9D93FFDB9F}']
    function delegate: id; cdecl;
    procedure setDelegate(delegate: id); cdecl;
    function state: CBCentralManagerState; cdecl;
    procedure cancelPeripheralConnection(peripheral: CBPeripheral); cdecl;
    procedure connectPeripheral(peripheral: CBPeripheral; options: NSDictionary); cdecl;
    function initWithDelegate(delegate: id; queue: dispatch_queue_t): id; cdecl; overload;
    function initWithDelegate(delegate: id; queue: dispatch_queue_t; options: NSDictionary): id; cdecl; overload;
    function retrieveConnectedPeripheralsWithServices(identifiers: NSArray): NSArray; cdecl;
    function retrievePeripheralsWithServices(identifiers: NSArray): NSArray; cdecl;
    procedure scanForPeripheralsWithServices(serviceUUIDs: NSArray; options: NSDictionary); cdecl;
    procedure stopScan; cdecl;
  end;
  TCBCentralManager = class(TOCGenericImport<CBCentralManagerClass, CBCentralManager>)  end;

  CBCentralManagerDelegate = interface(IObjectiveC)
  ['{1337817E-92DE-4FA9-8CF2-E00E89125A0F}']
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
  end;

  CBPeripheralDelegate = interface(IObjectiveC)
  ['{FD44C8F8-C555-4916-B07C-C0E9ED5033D3}']
    procedure peripheralDidUpdateName(peripheral: CBPeripheral); cdecl;
    procedure peripheralDidInvalidateServices(peripheral: CBPeripheral); cdecl; deprecated; { iOS 6.0 }
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
  end;

  TTimerProc = procedure of object;

  CBPeripheralAutorizationStatus = (CBPeripheralManagerAutorizathionStatusNotDetermined = 0,
     CBPeripheralManagerAutorizathionStatusRestricted, CBPeripheralManagerAutorizathionStatusDenied,
     CBPeripheralManagerAutorizathionStatusAuthorized);

  CBPeripheralManagerState = (CBPeripheralManagerStateUnknown = 0, CBPeripheralManagerStateResetting,
     CBPeripheralManagerStateUnsupported, CBPeripheralManagerStateUnauthorized, CBPeripheralManagerStatePoweredOff,
     CBPeripheralManagerStatePoweredOn);

  CBPeripheralManagerConnectionLatency = (CBPeripheralManagerConnectionLatencyLow = 0,
     CBPeripheralManagerConnectionLatencyMedium, CBPeripheralManagerConnectionLatencyHigh);

  CBATTError = (CBATTErrorSuccess = $00, CBATTErrorInvalidHandle = $01, CBATTErrorReadNotPermitted = $02,
    CBATTErrorWriteNotPermitted = $03, CBATTErrorInvalidPdu = $04, CBATTErrorInsufficientAuthentication = $05,
    CBATTErrorRequestNotSupported = $06, CBATTErrorInvalidOffset = $07, CBATTErrorInsufficientAuthorization = $08,
    CBATTErrorPrepareQueueFull = $09, CBATTErrorAttributeNotFound = $0A, CBATTErrorAttributeNotLong = $0B,
    CBATTErrorInsufficientEncryptionKeySize = $0C, CBATTErrorInvalidAttributeValueLength = $0D,
    CBATTErrorUnlikelyError = $0E, CBATTErrorInsufficientEncryption = $0F, CBATTErrorUnsupportedGroupType = $10,
    CBATTErrorInsufficientResources = $11);

  CBCentralClass = interface(NSObjectClass)
  ['{2E8DBDBB-F0E9-4796-A9E6-5AF890623465}']
  end;

  CBCentral = interface(NSObject)
  ['{28941F23-99FA-4F69-B310-6035E2FA01C2}']
    function identifier: NSUUID; cdecl;
    function maximumUpdateValueLength: NSUInteger; cdecl;
  end;
  TCBCentralt = class(TOCGenericImport<CBCentralClass, CBCentral>)  end;

  CBATTRequestClass = interface(NSObjectClass)
  ['{2B959DF5-D8E3-4768-BBC8-0B3351E96CFA}']
  end;

  CBATTRequest = interface(NSObject)
  ['{B385F534-A595-4457-80E3-15B707C29527}']
    function central: CBCentral; cdecl;
    function characteristic: CBCharacteristic; cdecl;
    function offset: NSUInteger; cdecl;
    function value: NSData; cdecl;
    procedure setValue(value: NSData); cdecl;
  end;
  TCBATTRequest = class(TOCGenericImport<CBATTRequestClass, CBATTRequest>)  end;

  CBPeripheralManagerDelegate = interface;
  CBPeripheralManagerClass = interface(NSObjectClass)
  ['{5BDDE7FC-DA35-41A5-98E6-DEEFD2332E89}']
    {class} function autorizathionStatus: CBPeripheralAutorizationStatus; cdecl;
  end;

  CBPeripheralManager = interface(NSObject)
  ['{94F24B28-0AB0-4DC3-8158-D7A22CEA81D2}']
    function delegate: CBPeripheralManagerDelegate; cdecl;
    procedure setDelegate(delegate: id); cdecl;
    function isAdvertising: Boolean; cdecl;
    function state: CBPeripheralManagerState; cdecl;
    procedure addService(service: CBMutableService); cdecl;
    function initWithDelegate(delegate: id; queue: dispatch_queue_t): id; cdecl; overload;
    function initWithDelegate(delegate: id; queue: dispatch_queue_t; options: NSDictionary): id; cdecl; overload;
    procedure removeAllServices; cdecl;
    procedure removeService(service: CBMutableService); cdecl;
    procedure respondToRequest(request: CBATTRequest; withResult: CBATTError); cdecl;
    procedure setDesiredConnectionLatency(latency: CBPeripheralManagerConnectionLatency; central: CBCentral); cdecl;
    procedure startAdvertising(advertisementData: NSDictionary); cdecl;
    procedure stopAdvertising; cdecl;
    function updateValue(value: NSData; forCharacteristic: CBMutableCharacteristic; onSubscribedCentrals: NSArray): Boolean; cdecl;
  end;
  TCBPeripheralManager = class(TOCGenericImport<CBPeripheralManagerClass, CBPeripheralManager>)  end;

  CBPeripheralManagerDelegate = interface(IObjectiveC)
  ['{B5D47032-6E56-42AC-BE69-FE5A6E735A94}']
    procedure peripheralManagerDidUpdateState(peripheral: CBPeripheralManager); cdecl;
    {[MethodName('peripheralManager:willRestoreState:')]
    procedure peripheralManagerWillRestoreState(peripheral: CBPeripheralManager; dict: NSDictionary); cdecl;}
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
  end;

function CBCentralManagerScanOptionSolicitedServiceUUIDsKey: NSString; inline;
function CBCentralManagerScanOptionAllowDuplicatesKey: NSString; inline;
function CBAdvertisementDataManufacturerDataKey: NSString; inline;
function CBAdvertisementDataLocalNameKey: NSString; inline;
function CBAdvertisementDataServiceUUIDsKey: NSString; inline;
function CBAdvertisementDataServiceDataKey: NSString; inline;
function CBAdvertisementDataOverflowServiceUUIDsKey: NSString; inline;
function CBAdvertisementDataTxPowerLevelKey: NSString; inline;
function CBAdvertisementDataIsConnectable: NSString; inline;
function CBAdvertisementDataSolicitedServiceUUIDsKey: NSString; inline;

implementation

uses
  Posix.Dlfcn;

var
  BTModule: THandle;
  CBModule: THandle;



function CBCentralManagerScanOptionSolicitedServiceUUIDsKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBCentralManagerScanOptionSolicitedServiceUUIDsKey');
end;

function CBCentralManagerScanOptionAllowDuplicatesKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBCentralManagerScanOptionAllowDuplicatesKey');
end;

function CBAdvertisementDataManufacturerDataKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataManufacturerDataKey');
end;

function CBAdvertisementDataLocalNameKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataLocalNameKey');
end;

function CBAdvertisementDataServiceUUIDsKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataServiceUUIDsKey');
end;

function CBAdvertisementDataServiceDataKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataServiceDataKey');
end;

function CBAdvertisementDataOverflowServiceUUIDsKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataOverflowServiceUUIDsKey');
end;

function CBAdvertisementDataTxPowerLevelKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataTxPowerLevelKey');
end;

function CBAdvertisementDataIsConnectable: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataIsConnectable');
end;

function CBAdvertisementDataSolicitedServiceUUIDsKey: NSString;
begin
  Result := CocoaNSStringConst(libCoreBluetooth, 'CBAdvertisementDataSolicitedServiceUUIDsKey');
end;

initialization
  BTModule := dlopen(MarshaledAString(libBluetooth), RTLD_LAZY);
  CBModule := dlopen(MarshaledAString(libCoreBluetooth), RTLD_LAZY);

finalization
  dlclose(BTModule);
  dlclose(CBModule);

end.
