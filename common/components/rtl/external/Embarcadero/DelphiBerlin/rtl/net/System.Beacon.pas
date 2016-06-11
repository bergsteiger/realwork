{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Beacon;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Bluetooth, System.TimeSpan;

const
  BEACON_ST_TYPE: Word = $0215;
  BEACON_AL_TYPE: Word = $BEAC;
  BEACON_PREFIX: TBytes = [$4C, $00, $02, $15];
  APPLEINC = $004C;
  TXPOWER_IDETERMINATED = -63;
  DEFAULT_TXPOWER = $7F;
  DISTANCE_DECIMALS = -2;
  MAJOR_REGION_ALL = -1;
  MINOR_REGION_ALL = -1;
  KBEACONDEATHTIME = 20;
  SIGNAL_PROPAGATION_CONSTANT = 0.5;
  SCANNING_TIME = 500;
  SCANNING_SLEEPINGTIME = 250;
  DIFFERENTIAL_FILTER_BOUNDARY = 7;
  ACCUMMULATE_DIFF_START_VALUE = DIFFERENTIAL_FILTER_BOUNDARY / 2.0;
  BEACON_TYPE_POS = 2;
  GUID_LENGTH = 16;
  MARK_POSITION = 9;
  STANDARD_DATA_LENGTH = 25;
  ALTERNATIVE_DATA_LENGTH = 26;
  //TSCANRESPONSE POSITIONS
  BEACON_MANUFACTURER_ID_POSITION = 0;
  //BEACONS PROXIMITY in Meters
  PROXIMITY_IMMEDIATE = 0.5;
  PROXIMITY_NEAR = 3;
  PROXIMITY_FAR = 30;
  RSSI_MEAN_ITEMS = 10;
  MANUFATURER_ID_ALL = -1;

    /// <summary> Eddystone UID frame type </summary>
    EDDYSTONE_UID = $00;
    /// <summary> Eddystone URL frame type </summary>
    EDDYSTONE_URL = $10;
    /// <summary> Eddystone TLM frame type </summary>
    EDDYSTONE_TLM = $20;
EDDY_FRAMETYPE_POS = 0;
    EDDY_TX_POS = 1;
    EDDY_URL_SCHEME_POS = 2;
    EDDY_SIGNAL_LOSS_METER: byte = 41;
    EDDY_UID_LEN = 20;
    EDDY_UID_NAMESPACE_POS = 2;
    EDDY_UID_NAMESPACE_LEN = 10;
    EDDY_UID_INSTANCE_POS = 12;
    EDDY_UID_INSTANCE_LEN = 6;
    EDDY_TLM_LEN = 14;
    EDDY_TLM_VERSION_POS = 1;
    EDDY_TLM_BATTVOLTAGE_POS = 2;
    EDDY_TLM_BEACONTEMP_POS = 4;
    EDDY_TLM_ADVPDUCOUNT_POS = 6;
    EDDY_TLM_TIMESINCEPOWERON_POS = 10;
    EDDY_RFU_DATA_POS = 18;
    EDDY_RFU_DATA_LEN = 2;
    EDDY_MIN_URL_LEN = 3;
    EDDY_ENCODED_URL_LEN = 17;

type

  TAdvertiseDeviceFormat = (adBeacon, adEddystoneUID, adEddystoneURL);
  TNamespaceGeneratorMethod = (ngNone, ngHashFQDN, ngElidedUUID);
  /// <summary> Error types for beacon error events </summary>
  TBeaconError = (IncorrectTxPower, Indefinite);

  /// <summary>
  ///  Exception type for the beacons
  /// </summary>
  EBeaconException = class(Exception);
  /// <summary>
  ///  Exception type for the Beacon Device
  /// </summary>
  EBeaconAdvertiserException = class(EBeaconException);
  /// <summary>
  ///  Exception type for the Beacon Manager
  /// </summary>
  EBeaconManagerException = class(EBeaconException);
  /// <summary>
  ///  Indicates current proximity for a beacon
  ///  <para>� Immediate below 0.5 meters</para>
  ///  <para>� Near between 0.5 and 1.5 meters</para>
  ///  <para>� Far up to 1.5 meters</para>
  ///  <para>� Away we cannot determine the distance</para>
  /// </summary>
  TBeaconProximity = (Immediate = 1, Near, Far, Away);
  /// <summary>
  ///  Beacon Scan Mode indicates which kind of beacons are going to be monitorized
  /// </summary>
  TBeaconScanMode = (Standard, Alternative, Eddystone, Extended);
  /// <summary>
  ///  Kind of Beacon indicates the kind of beacons.
  /// </summary>
  TKindofBeacon = (iBeacons, AltBeacons, Eddystones, iBAltBeacons);
  /// <summary>
  ///  ScanFilterType indicates the type of filter to scan BLE devices.
  /// </summary>
  TKindofScanFilter = (ManufacturerData, ServiceData, Service, Name, Identifier);
  /// <summary>
  /// Set Type for TKindofBeacon.
  /// </summary>
  TKindofBeacons = set of TKindofBeacon;
  /// <summary>
  ///  Eddystone Beacon Types indicates the kind of Eddystone Beacon.
  /// </summary>
  TKindofEddystone = (UID, URL, TLM);
  /// <summary>
  /// Set Type for TKindofEddystone.
  /// </summary>
  TKindofEddystones = set of TKindofEddystone;
  /// <summary>
  ///  Beacon Calc Mode :
  ///  <para>� Raw indicates whether we are going to use the raw values for rssi and distance</para>
  ///  <para>� Stabilized means that we are going to make some calculations to provide stabilized values</para>
  /// </summary>
  TBeaconCalcMode = (Raw, Stabilized);
  /// <summary> Type for beacon manufacturer data</summary>
  TManufacturerRawData = array of Byte;
  /// <summary> Type for Eddystone-UID Namespace ID </summary>
  TNamespace = array[0..EDDY_UID_NAMESPACE_LEN - 1] of byte;
  /// <summary> Type for Eddystone-UID Instance ID </summary>
  TInstance = array[0..EDDY_UID_INSTANCE_LEN - 1] of byte;

  /// <summary> Record to store the UID-Eddystone inf. </summary>
  TEddystoneUID = record
    /// <summary> Eddystone UID namespace ID </summary>
    Namespace: TNamespace;
    /// <summary> Eddystone UID Instance ID </summary>
    Instance: TInstance;
    /// <summary> Reserved for future use </summary>
    RFU: Word;
    /// <summary> Tries to Set the Namespace with the given string </summary>
    function SetNamespace(const Value: string): boolean;
    /// <summary> Tries to Set the Instance with the given string </summary>
    function SetInstance(const Value: string): boolean;
    /// <summary>  Get Namespace as an string </summary>
    function GetNamespace: string;
    /// <summary>  Get Instance as an string </summary>
    function GetInstance: string;
  private
    function TBytesToHexString(const AValue: array of Byte): string;
  public
    /// <summary> Eddystone UID Namespace to string </summary>
    property NamespaceToString: string read GetNamespace;
    /// <summary> Eddystone UID Instance to string </summary>
    property InstanceToString: string read GetInstance;
  end;

  /// <summary> Record to set or/and store an UID-Eddystone Region </summary>
  TEddysUIDRegion = record
  const
    EDDY_UID_INSTANCE_ALL = '-1';
  private
    FEddystoneUID: TEddystoneUID;
    FAllInstances: Boolean;
    function GetNamespace: TNamespace;
    function GetInstance: TInstance;
    function GetNamespaceST: string;
    function GetInstanceST: string;
  public
    /// <summary> Creates a new Namespace-Eddystone region, passing in an array of bytes (TNamespace) </summary>
    procedure Initialize(const ANamespace: TNamespace); overload;
    /// <summary> Creates a new Namespace-Instance-Eddystone region, passing in a couple of arrays of bytes (TNamespace & TInstance) </summary>
    procedure Initialize(const ANamespace: TNamespace; const AInstance: TInstance); overload;
    /// <summary> Creates a new Namespace-Eddystone region, passing in a string </summary>
    procedure Initialize(const ANamespaceST: string); overload;
    /// <summary> Creates a new Namespace-Instance-Eddystone region, passing in a couple of strings </summary>
    procedure Initialize(const ANamespaceST: string; const AInstanceST: string); overload;
    /// <summary> AllInstances property, returns true if the reguion is set to allow all possible Instances </summary>
    property AllInstances: Boolean read FAllInstances;
    /// <summary> Namespace property returns the namespace set, array of bytes version </summary>
    property Namespace: TNamespace read GetNamespace;
    /// <summary> Instance property returns the instance set, array of bytes version </summary>
    property Instance: TInstance read GetInstance;
    /// <summary> Namespace property returns the namespace set, string version </summary>
    property NamespaceST: string read GetNamespaceST;
    /// <summary> Instance property returns the instance set, string version </summary>
    property InstanceST: string read GetInstanceST;
  end;

  /// <summary> Record to set or/and store a GUID-MAjor-Minor-Beacon Region </summary>
  TiBAltBeaconRegion = record
  private
    FGUID: TGUID;
    FMajor: Integer;
    FMinor: Integer;
    FManufacturerID: Integer;
    FKindofBeacon: TKindofBeacon;
    procedure SetManufacturerID(AManufacturerID: Integer);
  public
    /// <summary> Creates a new GUID region, passing in a TGUID </summary>
    procedure Initialize(const AGUID: TGUID; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer); overload;
    /// <summary> Creates a new GUID-Major region, passing in a TGUID and a Major Value between ($FFFF and $0).
    /// Set Major to -1 for all possible Values </summary>
    procedure Initialize(const AGUID: TGUID; AMajor: Integer; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer); overload;
    /// <summary> Creates a new GUID-Major region, passing in a TGUID and a Major-Minor Values between ($FFFF and $0).
    /// Set Major-Minor to -1 for all possible Values </summary>
    procedure Initialize(const AGUID: TGUID; AMajor, AMinor: Integer; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer); overload;
    /// <summary> GUID of the Beacon </summary>
    property GUID: TGUID read FGUID;
    /// <summary> Major ID of the Beacon, set to -1 for all possible Minors </summary>
    property Major: Integer read FMajor;
    /// <summary> Minor ID of the Beacon, set to -1 for all possible Minors </summary>
    property Minor: Integer read FMinor;
    /// <summary> Id of the Beacon Manufacturer (2 bytes), set to -1 for all possible Manufacturers </summary>
    property ManufacturerID: Integer read FManufacturerID;
    /// <summary> Kind of Beacon to be un/registered </summary>
    property KindofBeacon: TKindofBeacon read FKindofBeacon;
  end;

  /// <summary> Record to set or/and store a general Beacon Region </summary>
  TBeaconsRegion = record
    /// <summary> Kind of beacon set </summary>
    case KindofBeacon: TKindofBeacon of
      TKindofBeacon.Eddystones:
      /// <summary> UID-Eddystone Region </summary>
       (EddysUIDRegion: TEddysUIDRegion);
      TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
      /// <summary> GUID-MAjor-Minor-Beacon Region </summary>
       (iBAltBeaconRegion: TiBAltBeaconRegion);
    end;

  /// <summary> Record that store the URL-Eddystone inf. </summary>
  TEddystoneURL = record
    /// <summary> is used to designate Internet resources accessible using HTTP </summary>    ///
    EncodedURL:  TBytes;
    /// <summary> URL encoded </summary>
    URL:  string;
  public
    /// <summary> Eddystone URL to string </summary>
    function URLToString: string;
  end;

  /// <summary> Record that store the TLM-Eddystone inf. </summary>
  TEddystoneTLM = record
  const
    EDDY_TLM_LEN = 14;
    EDDY_TLM_VERSION_POS = 1;
  var
    /// <summary> The encoded TLM telemetry</summary>
    EncodedTLM: array[0..EDDY_TLM_LEN - (EDDY_TLM_VERSION_POS + 1)] of byte;
    /// <summary> The current battery charge in millivolts </summary>
    BattVoltage: Word;
    /// <summary> the temperature in degrees Celsius sensed by the beacon and expressed in a signed 8.8 fixed-point notation. </summary>
    BeaconTemp: Word;
    /// <summary> The running count of advertisement frames of all types emitted by the beacon since power-up or reboot. </summary>
    AdvPDUCount: Cardinal;
    /// <summary> A 0.1 second resolution counter that represents time since beacon power-up or reboot. </summary>
    TimeSincePowerOn: Cardinal;
    /// <summary> Eddystone TLM BattVoltage to string </summary>
    function BattVoltageToString: string; inline;
    /// <summary> Eddystone TLM BeaconTemp to string </summary>
    function BeaconTempToSingle: Single; inline;
    /// <summary> Eddystone TLM BeaconTemp to string </summary>
    function BeaconTempToString: string; inline;
    /// <summary> Eddystone TLM AdvPDUCount to string </summary>
    function AdvPDUCountToString: string; inline;
    /// <summary> Eddystone TLM AdvPDUCount to TTimeSpan </summary>
    function TimeSincePowerOnToTTimeSpan: TTimeSpan; inline;
    /// <summary> Eddystone TLM AdvPDUCount to string </summary>
    function TimeSincePowerOnToString: string; inline;
  end;

  /// <summary> Record that store the Eddystone beacon inf. </summary>
  TEddystoneBeaconInfo = record
    /// <summary> All kind of Eddystone advertised by the same device </summary>
    KindofEddystones: TKindofEddystones;
    /// <summary> Last Kind of Eddystone advertised by the device </summary>
    LastKindofEddystone: TKindofEddystone;
    /// <summary> Contains the identifier of the Eddyston beacon </summary>
    EddystoneUID: TEddystoneUID;
    /// <summary> The Eddystone-URL frame broadcasts a URL using a compressed encoding format
    ///  in order to fit more within the limited advertisement packet. </summary>
    EddystoneURL: TEddystoneURL;
    /// <summary> TLM: telemetry for monitoring the health and operation of a fleet of beacons </summary>
    EddystoneTLM: TEddystoneTLM;
    /// <summary> Possible Aditional data found (example RFU - Reserved for future use) </summary>
    AdditionalData: TBytes;
  end;

  /// <summary>
  ///  Structure used to indicate parsed beacon information
  /// </summary>
  TBeaconInfo = record
    /// <summary> Beacon GUID identifier</summary>
    GUID: TGUID;
    /// <summary> Beacon Major identifier</summary>
    Major: Word;
    /// <summary> Beacon Minor identifier</summary>
    Minor: Word;
    /// <summary>Beacon Type</summary>
    BeaconType: Word;
    /// <summary> Original transmission power</summary>
    TxPower: Integer;
    /// <summary> A byte with additional data</summary>
    AdditionalData: byte;
    /// <summary> Kind of Beacon to which the data belongs </summary>
    KindofBeacon: TKindofBeacon;
    /// <summary> Extra Eddystone Data </summary>
    EddystoneBeacon: TEddystoneBeaconInfo;
    /// <summary> Extra Eddystone Data </summary>
    DeviceIdentifier: string;
  end;

  /// <summary> Record used internally to get stabilized values for Rssi.</summary>
  TMeanCalculator<T> = record
  private
    /// <summary> Current size of the array used to hold values.</summary>
    FSize: Integer;
    /// <summary> Current center of the array used to hold values.</summary>
    FCenter: Integer;
    /// <summary> True if we do not have values.</summary>
    FIsEmpty: Boolean;
    /// <summary> Array holding current calues.</summary>
    ArrayRatio: array of T;
    /// <summary> Index were the new value is going to be added.</summary>
    Index: Integer;
    /// <summary> True when we have added values to fill the ArrayRatio array.</summary>
    IsFull: Boolean;
    /// <summary> Sets the size for the internal array.</summary>
    procedure SetSize(ASize: Integer);
    /// <summary> Adds a new value to the array.</summary>
    procedure AddValue(AValue: T);
  public
    /// <summary> Initializes the internal array with the new size and reset.</summary>
    constructor Create(const ASize: Integer);
    /// <summary> Empty all the values.</summary>
    procedure Reset;
    /// <summary> Gets the mean value with the current values as Double.</summary>
    function GetAsDouble: Double;
    /// <summary> Gets the mean value with the current values as Integer.</summary>
    function GetAsInteger: Integer;
    /// <summary> Gets the median for current values as Double.</summary>
    function GetMedianAsDouble: Double;
    /// <summary> Gets the median for current values as Integer.</summary>
    function GetMedianAsInteger: Integer;
    /// <summary> Get the last value.</summary>
    function GetLast: T;
    /// <summary> Get the calculated value.</summary>
    function Get: T;
    /// <summary> Adds a value getting the calculated value.</summary>
    function AddGetValue(AValue: T; IsMoving: Boolean): T;
    /// <summary> True if we do not have values.</summary>
    function IsEmpty: Boolean;
  end;

  /// <summary>
  ///  Base class to be inherited to create custom parsers
  /// </summary>
  TBeaconManufacturerDataParser = class
  public
    /// <summary>Try to parse the data on AData filling up BeaconInfo record</summary>
    class function Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean; virtual; abstract;
  end;

  /// <summary> Class for TBeaconManufacturerDataParser</summary>
  TBeaconManufacturerDataParserClass = class of TBeaconManufacturerDataParser;
  /// <summary> Class used to register and use several parsers</summary>
  TBeaconManufacturerParsers = class
  private
    FParsers: TDictionary<string, TBeaconManufacturerDataParserClass>;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary> Register a parser class with the given identifier</summary>
    procedure RegisterParser(const AParser: TBeaconManufacturerDataParserClass; const AParserIdentifier: string);
    /// <summary> Unregister the parser class for the given identifier</summary>
    procedure UnRegisterParser(const AParserIdentifier: string);
    /// <summary> Try to parse AData filling up BeaconInfo record with all the registered parsers</summary>
    function Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean;
  end;

  /// <summary>
  ///  Interface to hold the information regarding a detected beacon.
  /// </summary>
  IBeacon = interface
  ['{9E2515C0-C3DB-494C-BECB-61B05266C615}']
    /// <summary>
    ///  Getter for GUID property (deprecated).
    /// </summary>
    function GetGUID: TGUID;
    /// <summary>
    ///  Getter for Major property (deprecated).
    /// </summary>
    function GetMajor: Word;
    /// <summary>
    ///  Getter for Minor property (deprecated).
    /// </summary>
    function GetMinor: Word;
    /// <summary>
    ///  Getter for Rssi property.
    /// </summary>
    function GetRssi: Integer;
    /// <summary>
    ///  Getter for Distance property.
    /// </summary>
    function GetDistance: Double;
    /// <summary>
    ///  Getter for Proximity property.
    /// </summary>
    function GetProximity: TBeaconProximity;
    /// <summary>
    ///  Getter for AdditionalData property (deprecated).
    /// </summary>
    function GetAdditionalData: TBytes;
    /// <summary>
    /// True when the current beacon is equal to AGUID, AMajor and AMinor False otherwise.
    /// </summary>
    function IsEqualTo(const AGUID: TGUID; AMajor, AMinor: word): Boolean; overload;
    /// <summary>
    /// True when the current Eddystone UID beacon is equal to the
    /// Namespace and Instance passed False otherwise.
    /// </summary>
    function IsEqualTo(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload;
    /// <summary>
    /// True when the current Beacon is equal to the passed Beacon false otherwise.
    /// </summary>
    function IsEqualTo(const AIBeacon: IBeacon): Boolean; overload;
    /// <summary>
    ///  True indicates that the beacon information still valid False when we consider that the beacon is out of reach.
    /// </summary>
    function ItsAlive: Boolean;
    /// <summary>
    ///  Getter for KindofBeacon property.
    /// </summary>
    function GetKindofBeacon: TKindofBeacon;
    /// <summary>
    ///  Getter for DeviceIdentifier property.
    /// </summary>
    function GetDeviceIdentifier: string;
    /// <summary>
    ///  GUID of the beacon (deprecated).
    /// </summary>
    property GUID: TGUID read GetGUID;
    /// <summary>
    ///  Major value of the beacon (deprecated).
    /// </summary>
    property Major: Word read GetMajor;
    /// <summary>
    ///  Minor value of the beacon (deprecated).
    /// </summary>
    property Minor: Word read GetMinor;
    /// <summary>
    ///  Current received signal strength indicator (RSSI).
    /// </summary>
    property Rssi: Integer read GetRssi;
    /// <summary>
    ///  Last calculated distance.
    /// </summary>
    property Distance: Double read GetDistance;
    /// <summary>
    ///  Current proximity to the beacon.
    /// </summary>
    property Proximity: TBeaconProximity read GetProximity;
    /// <summary>
    ///  Additional data provided for the beacon, could be empty (deprecated).
    /// </summary>
    property AdditionalData: TBytes read GetAdditionalData;
    /// <summary>
    ///  Kind of Beacon of this device.
    /// </summary>
    property KindofBeacon: TKindofBeacon read GetKindofBeacon;
    /// <summary>
    ///  BLE device identifier.
    /// </summary>
    property DeviceIdentifier: string read GetDeviceIdentifier;
  end;

  /// <summary>
  ///  Base interface for beacons.
  /// </summary>
  IStandardBeacon = interface(IBeacon)
  ['{D0673EE7-3919-45D0-874F-40A8E939BD95}']
  end;

  /// <summary>
  ///  Interface for iBeacon beacon type.
  /// </summary>
  IiBeacon = interface(IStandardBeacon)
  ['{ABB5CEC4-459D-468C-B2A3-21C5B6FCF18B}']
  end;

  /// <summary>
  ///  Interface for Alternative beacon type.
  /// </summary>
  IAltBeacon = interface(IStandardBeacon)
  ['{15F6C736-B968-4E3D-8FD3-EDED99723D09}']
    /// <summary>
    ///  Getter for AdditionalData property.
    /// </summary>
    function GetAltAdditionalData: Byte;
    /// <summary>
    ///  A possible extra byte of data, of Alternative beacons.
    /// </summary>
    property AltAdditionalData: byte read GetAltAdditionalData;
  end;


  /// <summary>
  ///  Interface for Eddystone beacon type.
  /// </summary>
  IEddystoneBeacon = interface(IBeacon)
  ['{5E33BD48-D0C1-4C8E-B6CD-28586995981D}']
    /// <summary>
    ///  Getter for KindofEddystones property.
    /// </summary>
    function GetKindofEddystones: TKindofEddystones;
    /// <summary>
    ///  Getter for EddystoneUID property.
    /// </summary>
    function GetEddystoneUID: TEddystoneUID;
    /// <summary>
    ///  Getter for EddystoneURL property.
    /// </summary>
    function GetEddystoneURL: TEddystoneURL;
    /// <summary>
    ///  Getter for EddystoneTLM property.
    /// </summary>
    function GetEddystoneTLM: TEddystoneTLM;
    /// <summary>
    /// Set of All kind of Eddystones advertised by the same device.
    /// </summary>
    property KindofEddystones: TKindofEddystones read GetKindofEddystones;
    /// <summary>
    /// Contains the identifier of the Eddyston beacon.
    /// </summary>
    property EddystoneUID: TEddystoneUID read GetEddystoneUID;
    /// <summary> The Eddystone-URL frame broadcasts a URL using a compressed encoding format
    ///  in order to fit more within the limited advertisement packet.
    /// </summary>
    property EddystoneURL: TEddystoneURL read GetEddystoneURL;
    /// <summary>
    /// TLM: telemetry for monitoring the health and operation of a fleet of beacons.
    /// </summary>
    property EddystoneTLM: TEddystoneTLM read GetEddystoneTLM;
  end;

  /// <summary>
  ///  Is an array of <see cref="IBeacon"/>
  /// </summary>
  //  TBeaconList = TArray<IBeacon>;
  TBeaconList = array of IBeacon;
  /// <summary>
  ///  Event type used for enter/exit events for beacons.
  ///  <param name='ABeacon'>Contains the entered or exited beacon </param>
  ///  <param name='CurrentBeaconList'>Remaining beacons list </param>
  /// </summary>
  TBeaconEnterExitEvent = procedure (const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList) of object;
  /// <summary>
  ///  Event type used when a beacon proximity changes.
  ///  <param name='ABeacon'>Contains the beacon that is changing</param>
  ///  <param name='Proximity'>Is the new proximity</param>
  /// </summary>
  TBeaconProximityEvent = procedure (const Sender: TObject; const ABeacon: IBeacon; Proximity: TBeaconProximity) of object;
  /// <summary>
  ///  Event type used when a beacon distance is about to be calculated
  ///  <param name='UUID, Major, Minor'>Identifiers for the beacon</param>
  ///  <param name='ATXPower'>Reference power</param>
  ///  <param name='ARssi'>Received power</param>
  ///  <param name='NewDistance'>Variable to indicate the new distance</param>
  /// </summary>
  TBeaconCalcDistanceEvent =  procedure (const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Word;
    ATxPower: Integer; ARssi: Integer; var NewDistance: Double) of object;
  /// <summary>
  ///  Event type used when a beacon distance is about to be calculated, for all kind of Beacons
  ///  <param name='ABeacon'>the beacon</param>
  ///  <param name='ATXPower'>Reference power</param>
  ///  <param name='ARssi'>Received power</param>
  ///  <param name='NewDistance'>Variable to indicate the new distance</param>
  /// </summary>
  TBeaconsCalcDistancesEvent =  procedure (const Sender: TObject; const ABeacon: IBeacon;
      ATxPower: Integer; ARssi: Integer; var NewDistance: Double) of object;
  /// <summary>
  ///  This event is fired when we get a new registered zone
  ///  <param name='UUID, Major, Minor'>Identifiers for the beacon region</param>
  /// </summary>
  TBeaconRegionEvent = procedure (const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer) of object;
  /// <summary>
  ///  This event is fired when we get a new registered zone
  ///  <param name='Namespace, Instance'>Identifiers for the Eddystone beacon region</param>
  /// </summary>
  TBeaconsRegionEvent = procedure (const Sender: TObject; const ABeaconRegion: TBeaconsRegion) of object;
  /// <summary>
  ///  This event is fired when we get a new Eddystone URL
  /// </summary>
  TBeaconEddystoneURLEvent = procedure (const Sender: TObject; const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL) of object;
  /// <summary>
  ///  This event is fired when we get a new Eddystone URL
  /// </summary>
  TBeaconEddystoneTLMEvent = procedure (const Sender: TObject; const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM) of object;
  /// <summary>
  ///  This event is fired every time we have new information for a BLE device that has manufacturer data
  ///  You can use it to parse the data on your own specification. The event will not be raised in standard mode for iOS
  /// </summary>
  TParseManufacturerDataEvent = procedure (const Sender: TObject; const AData: TManufacturerRawData; var BeaconInfo: TBeaconInfo;
      var Handled: Boolean) of object;
  /// <summary>
  ///  This event is fired every time we have new information for a BLE device that has ServiceData
  ///  You can use it to parse the data on your own specification.
  /// </summary>
  TParseServiceDataEvent = procedure (const Sender: TObject; const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo;
      var Handled: Boolean) of object;
  /// <summary>
  ///  This event is fired every time a new scan filter is created and befor being added to FilterList wich will be past to
  ///  the BLE scanner. So to check the filter builded and change it if needed.
  /// </summary>
  TNewBLEScanFilterEvent = procedure (const Sender: TObject; AKindofScanFilter: TKindofScanFilter;
    const ABluetoothLEScanFilter: TBluetoothLEScanFilter) of object;
  /// <summary>
  ///  This event is fired every time an error is detected, check AError and ErrorMsg to get more
  ///  information about the error.
  /// </summary>
  TBeaconErrorEvent = procedure (const Sender: TObject; AError: TBeaconError; const ErrorMsg: string;
    const ABeacon: TBeaconInfo) of object;
  /// <summary>
  ///  Beacon Manager is the class used to manage the scanning of beacons. We can monitor beacons in two ways standard and alternative
  ///  Do not create instances of this class directly, instead use the class function, GetBeaconManager(AMode: TBeaconScanMode)
  ///  to retrieve an instance to the manager for the scanning mode you desire
  /// </summary>
  TBeaconManager = class
  const
    /// <summary> Eddystone service </summary>
    EDDYSTONE_SERVICE_UUID: TGUID = '{0000FEAA-0000-1000-8000-00805F9B34FB}';
  protected
    /// <summary>Variable for BeaconDeathTime property </summary>
    FBeaconDeathTime: integer;
    /// <summary>Variable for ScanningTime property </summary>
    FScanningTime: integer;
    /// <summary>Variable for ScanningSleepingTime property </summary>
    FScanningSleepingTime: integer;
    /// <summary>Variable for SPC property </summary>
    FSPC: Single;
    /// <summary> Variable for CalcMode property </summary>
    FCalcMode: TBeaconCalcMode;
    /// <summary>Variable for OnBeaconEnter property </summary>
    FOnBeaconEnter: TBeaconEnterExitEvent;
    /// <summary>Variable for OnBeaconExit property </summary>
    FOnBeaconExit: TBeaconEnterExitEvent;
    /// <summary>Variable for OnNewEddystoneURL property </summary>
    FOnNewEddystoneURL:  TBeaconEddystoneURLEvent;
    /// <summary>Variable for OnNewEddystoneTLM property </summary>
    FOnNewEddystoneTLM:  TBeaconEddystoneTLMEvent;
    /// <summary>Variable for OnBeaconProximity property </summary>
    FOnBeaconProximity: TBeaconProximityEvent;
    /// <summary>Variable for OnCalcDistance property, Deprecated</summary>
    FOnCalcDistance: TBeaconCalcDistanceEvent;
    /// <summary>Variable for OnCalculateDistances property </summary>
    FOnCalculateDistances: TBeaconsCalcDistancesEvent;
    /// <summary>Variable for OnParseManufacturerData property </summary>
    FOnParseManufacturerData: TParseManufacturerDataEvent;
    /// <summary>Variable for OnParseServiceData property </summary>
    FOnParseServiceData: TParseServiceDataEvent;
    /// <summary>Variable for OnEnterRegion property </summary>
    FOnEnterRegion: TBeaconRegionEvent;
    /// <summary>Variable for OnEnterRegion property </summary>
    FOnBeaconsEnterRegion: TBeaconsRegionEvent;
    /// <summary>Variable for OnExitRegion property </summary>
    FOnExitRegion: TBeaconRegionEvent;
    /// <summary>Variable for OnEnterRegion property </summary>
    FOnBeaconsExitRegion: TBeaconsRegionEvent;
    /// <summary>Variable for NewBLEScanFilterEvent property </summary>
    FOnNewBLEScanFilterEvent: TNewBLEScanFilterEvent;
    /// <summary>Variable for OnBeaconErrorEvent property </summary>
    FOnBeaconErrorEvent: TBeaconErrorEvent;
    /// <summary>Variable for BeaconType property </summary>
    FBeaconType: Word;
    /// <summary>Variable for ScanMode property </summary>
    FScanMode: TBeaconScanMode;
    /// <summary>variable which define the kind of beacon </summary>
    FKindofBeacons: TKindofBeacons;
    /// <summary>Variable for ManufacturerDataParsers property </summary>
    FManufacturerDataParsers: TBeaconManufacturerParsers;
    /// <summary>Implementation for RegisterBeacon function </summary>
    function DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for RegisterBeacon function </summary>
    function DoRegisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for RegisterBeacon function </summary>
    function DoRegisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; virtual; abstract;
    /// <summary> Register a region to monitor using a Eddystone-UID Namespace. </summary>
    function DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; virtual; abstract;
    /// <summary> Register a region to monitor using a Eddystone-UID Namespace and Instance. </summary>
    function DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for UnregisterBeacon function </summary>
    function DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for UnregisterBeacon function </summary>
    function DoUnregisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for UnregisterBeacon function </summary>
    function DoUnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; virtual; abstract;
    /// <summary> Unregister all regions using the Eddystone-UID Namespace passed. </summary>
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; virtual; abstract;
    /// <summary> Unregister all regions using the Eddystone-UID Namespace and AInstance passed. </summary>
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; virtual; abstract;
    /// <summary>Implementation for Nearest function</summary>
    function DoNearest: IBeacon; virtual; abstract;
    /// <summary>Implementation for StartScan function </summary>
    function DoStartScan: Boolean; virtual; abstract;
    /// <summary>Implementation for StopScan function</summary>
    function DoStopScan: Boolean; virtual; abstract;
    /// <summary>Setter for BeaconType property </summary>
    procedure SetBeaconType(AValue: Word); virtual; abstract;
    /// <summary>Setter for BeaconDeathTime property </summary>
    procedure SetBeaconDeathTime(AValue: Integer); virtual; abstract;
    /// <summary> Setter for Scanning Sleeping Time property</summary>
    procedure SetScanningSleepingTime(AValue: Integer); virtual; abstract;
    /// <summary>Setter for Scanning time property </summary>
    procedure SetScanningTime(AValue: Integer); virtual; abstract;
    /// <summary>Setter for SPC property </summary>
    procedure SetSPC(AValue: Single); virtual; abstract;
    /// <summary>Getter for KindofBeacons property </summary>
    function GeTKindofBeacons: TKindofBeacons; virtual; abstract;
    /// <summary>Getter for NumberofBeaconsRegistered property </summary>
    function GetNumberofBeaconsRegistered: Integer; virtual; abstract;
    /// <summary>DoSetKindofBeacons functionality of SetKindofBeacons </summary>
    procedure DoSetKindofBeacons(AValue: TKindofBeacons); virtual; abstract;
    /// <summary>Setter for KindofBeacons property </summary>
    procedure SetKindofBeacons(AValue: TKindofBeacons);
    /// <summary>Raises OnBeaconEnter Event </summary>
    procedure DoBeaconEnter(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    /// <summary> Raises OnBeaconChangedProximity event </summary>
    procedure DoBeaconChangedProximity(const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
    /// <summary> Raises OnBeaconExit event</summary>
    procedure DoBeaconExit(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    /// <summary> Raises OnNewEddystoneURL event</summary>
    procedure DoNewEddystoneURL(const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
    /// <summary> Raises OnNewEddystoneTLM event</summary>
    procedure DoNewEddystoneTLM(const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
    /// <summary> Raises OnRegionEnter Event</summary>
    procedure DoRegionEnter(const UUID: TGUID; AMajor, AMinor: Integer);
    /// <summary> Raises OnBeaconsRegionEnter Event</summary>
    procedure DoBeaconsRegionEnter(const ABeaconRegion: TBeaconsRegion);
    /// <summary> Raises OnRegionExit Event </summary>
    procedure DoRegionExit(UUID: TGUID; AMajor, AMinor: Integer);
    /// <summary> Raises OnBeaconsRegionExit Event </summary>
    procedure DoBeaconsRegionExit(const ABeaconRegion: TBeaconsRegion);
    /// <summary> Raises OnCalcDistance event</summary>
    function DoBeaconCalcDistance(const UUID: TGUID; AMajor, AMinor: Word; ATxPower: Integer;
      ARssi: Integer; var NewDistance: Double): Boolean; overload;
    /// <summary> Raises OnCalcDistance event for all types of Beacons</summary>
    function DoBeaconCalcDistance(const Abeacon: IBeacon; ATxPower: Integer; ARssi: Integer;
      var NewDistance: Double): Boolean; overload;
    /// <summary> Raises OnParseManufacturerData event</summary>
    procedure DoParseManufacturerData(const AData: TBytes; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
    /// <summary> Raises OnParseServiceData event</summary>
    procedure DoParseServiceData(const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
    /// <summary> Raises OnParseServiceData event</summary>
    procedure DoNewBLEScanFilter(AKindofScanFilter: TKindofScanFilter; const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
    /// <summary> Raises OnBeaconError event</summary>
    procedure DoBeaconError(AError: TBeaconError; const AMsg: string; const ABeacon: TBeaconInfo);
    /// <summary> Gets an instance of the Beacon Manager in the specified mode for the current platform</summary>
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; virtual; abstract;
  public
    /// <summary>
    ///  Register a region to monitor using a GUID, all Major and Minor beacons using the GUID will be monitored
    /// </summary>
    function RegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload;
    /// <summary>
    ///  Register a region to monitor using a GUID and a Major, all Minor beacons using the GUID will be monitored
    /// </summary>
    function RegisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload;
    /// <summary>
    ///  Register a region to monitor using a GUID, a Major and a Minor, meaning that the region will only contain a beacon
    /// </summary>
    function RegisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload;
    /// <summary>
    ///  Register a new region to monitor any kind of beacon.
    /// </summary>
    function RegisterBeacons(const ABeaconRegion: TBeaconsRegion): Boolean;
    /// <summary>
    ///   Unregister all regions using the GUID passed
    /// </summary>
    function UnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload;
    /// <summary>
    ///   Unregister all regions using the GUID and Major passed
    /// </summary>
    function UnregisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload;
    /// <summary>
    ///   Unregister all regions using the GUID, Major and Minor passed
    /// </summary>
    function UnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload;
    /// <summary>
    ///   Unregister Beacons Region.
    /// </summary>
    function UnRegisterBeacons(const ABeaconRegion: TBeaconsRegion): Boolean;
    /// <summary>
    ///  Returns the nearest beacon to our position, nil if we don't have
    /// </summary>
    function Nearest: IBeacon;
    /// <summary>
    ///  Starts to monitor beacons on the registered regions
    /// </summary>
    function StartScan: Boolean;
    /// <summary>
    ///  Stop to scan beacons
    /// </summary>
    function StopScan: Boolean;
    /// <summary>
    ///  Gets the proper Beacon Manager for the os/mode you are working on.
    /// </summary>
    class function GetBeaconManager(AMode: TBeaconScanMode): TBeaconManager;
    /// <summary>
    ///  read only property indicating the scan mode used by the Manager
    /// </summary>
    property ScanMode: TBeaconScanMode read FScanMode;
    /// <summary>
    ///  indicates the current beacon type used to scan beacons.
    ///  This value cannot be changed for iOS when scan mode is Standard.
    ///  The property has a default value depending on the Scan Mode we are using.
    /// </summary>
    property BeaconType: Word read FBeaconType write SetBeaconType;
    /// <summary>
    ///  Indicates the current beacon type used to provide Rssi and distance values.
    ///  By default we are working in Stabilized mode.
    /// </summary>
    property CalcMode: TBeaconCalcMode read FCalcMode write FCalcMode;
    /// <summary>
    ///  Indicates the time in ms to consider that the beacon signal has been lost
    /// </summary>
    property BeaconDeathTime: integer read FBeaconDeathTime write SetBeaconDeathTime;
    /// <summary>
    ///  Signal propagation constant value used to calculate the distance
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property SPC: Single read FSPC write SetSPC;
    /// <summary>
    ///  Time that we are going to scan each cicle in ms.
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property ScanningTime: integer read FScanningTime write SetScanningTime;
    /// <summary>
    ///  Paused time between scan cicles.
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property ScanningSleepingTime: integer read FScanningSleepingTime write SetScanningSleepingTime;
    /// <summary>
    ///  List of available parsers to parse the manufacturer data from a BLE device.
    /// </summary>
    property ManufacturerDataParsers: TBeaconManufacturerParsers read FManufacturerDataParsers;
    ///  <summary>
    ///  KindofBeacons is the list of the beacons specification to be set.
    ///  </summary>
    property KindofBeacons: TKindofBeacons read GetKindofBeacons write SeTKindofBeacons;
    ///  <summary>
    ///  Total number of beacons registered (kind of beacons are: iBeacons, AltBeacons and Eddystone).
    ///  </summary>
    property NumberofBeaconsRegistered: Integer read GetNumberofBeaconsRegistered;
    /// <summary>
    ///  OnBeaconEnter is fired each time a Beacon is reachable, this means that there is a new beacon on our list
    /// </summary>
    property OnBeaconEnter: TBeaconEnterExitEvent read FOnBeaconEnter write FOnBeaconEnter;
    /// <summary>
    ///  OnBeaconExit is fired each time a Beacon is not reachable.
    /// </summary>
    property OnBeaconExit: TBeaconEnterExitEvent read FOnBeaconExit write FOnBeaconExit;
    /// <summary>
    ///  OnNewEddystoneURL is fired each time a new Eddystone-URL is found, new or existing BLE device.
    /// </summary>
    property OnNewEddystoneURL: TBeaconEddystoneURLEvent read FOnNewEddystoneURL write FOnNewEddystoneURL;
    /// <summary>
    ///  OnNewEddystoneTLM is fired each time a new Eddystone-TLM is found, new or existing BLE device.
    /// </summary>
    property OnNewEddystoneTLM: TBeaconEddystoneTLMEvent read FOnNewEddystoneTLM write FOnNewEddystoneTLM;
    /// <summary>
    ///  OnBeaconProximity is fired when a beacon proximity value changes
    /// </summary>
    property OnBeaconProximity: TBeaconProximityEvent read FOnBeaconProximity write FOnBeaconProximity;
    /// <summary>
    ///  OnEnterRegion is fired first time a beacon from a region is reachable.
    /// </summary>
    property OnEnterRegion: TBeaconRegionEvent read FOnEnterRegion write FOnEnterRegion;
    /// <summary>
    ///  OnExitRegion is fired when all beacons for a region are out of reach.
    /// </summary>
    property OnExitRegion: TBeaconRegionEvent read FOnExitRegion write FOnExitRegion;
    /// <summary>
    ///  OnBeaconsEnterRegion is fired first time a beacon from a region is reachable.
    /// </summary>
    property OnBeaconsEnterRegion: TBeaconsRegionEvent read FOnBeaconsEnterRegion write FOnBeaconsEnterRegion;
    /// <summary>
    ///  OnBeaconsExitRegion is fired when all beacons for a region are out of reach.
    /// </summary>
    property OnBeaconsExitRegion: TBeaconsRegionEvent read FOnBeaconsExitRegion write FOnBeaconsExitRegion;
    /// <summary>
    ///  OnCalcDistance is fired when we are about to calculate the distance to a beacon. You can use it to provide
    ///  your own algorithm to calculate the distance (Deprecated).
    /// </summary>
    property OnCalcDistance: TBeaconCalcDistanceEvent read FOnCalcDistance write FOnCalcDistance;
    /// <summary>
    ///  OnEddySCalcDistance is fired when we are about to calculate the distance to a beacon. You can use it to provide
    ///  your own algorithm to calculate the distance.
    /// </summary>
    property OnCalculateDistances: TBeaconsCalcDistancesEvent read FOnCalculateDistances write FOnCalculateDistances;
    /// <summary>
    ///  OnParseManufacturerData is fired when we receive new information from a bluetooth LE device
    ///  You can add your own algorithm to parse the beacon data
    /// </summary>
    property OnParseManufacturerData: TParseManufacturerDataEvent read FOnParseManufacturerData write FOnParseManufacturerData;
    /// <summary>
    ///  OnParseserviceData is fired when we receive new information from a bluetooth LE device
    ///  You can add your own algorithm to parse the beacon data
    /// </summary>
    property OnParseServiceData: TParseServiceDataEvent read FOnParseServiceData write FOnParseServiceData;
    /// <summary>
    ///  OnNewBLEScanFilterEvent is fired every time a new scan filter is created
    ///  and befor being added to FilterList wich will be past to the BLE scanner
    /// </summary>
    property OnNewBLEScanFilterEvent: TNewBLEScanFilterEvent read FOnNewBLEScanFilterEvent write FOnNewBLEScanFilterEvent;
    /// <summary>
    ///  OnBeaconErrorEvent is fired every time we found a problem with a detected beacon.
    /// </summary>
    property OnBeaconError: TBeaconErrorEvent read FOnBeaconErrorEvent write FOnBeaconErrorEvent;

  end;

  /// <summary>
  ///  TBeaconAdvertiser is the class to create beacons devices that can advertise proximity data.
  /// </summary>
  TBeaconAdvertiser = class
  const
    EDDY_SCHEME_PREFIXES: array[0..3] of string = ('http://www.', 'https://www.', 'http://', 'https://');
    EDDY_URL_EXPANSIONS: array[0..13] of string = ('.com/', '.org/', '.edu/', '.net/', '.info/', '.biz/', '.gov/',
      '.com', '.org', '.edu', '.net', '.info', '.biz', '.gov');
  private
    FGUID: TGUID;
    FMajor: Word;
    FMinor: Word;
    FBeaconType: Word;
    FTxPower: ShortInt;
    FManufacturerId: Word;
    FMFGReserved: Byte;
    FEddystoneNamespace: string;
    FEddystoneInstance: string;
    FEddystoneURL: string;
    FDeviceType: TAdvertiseDeviceFormat;
    FNamespaceGenerator: TNamespaceGeneratorMethod;
    FOwnsGattServer: Boolean;
  protected
    /// <summary> Can store a GattServer that is advertising as this beacon </summary>
    FGattServer: TBluetoothGattServer;
    /// <summary> Variable for AdvertiseGattInfo property </summary>
    FAdvertiseGattInfo: Boolean;
    /// <summary> Getter implementation for IsAdvertising property </summary>
    function GetIsAdvertising: Boolean;
    /// <summary> Gets the manufacturer data bytes for beacon </summary>
    function GetManufacturerData: TBytes; virtual; abstract;
    /// <summary> Gets the service data bytes for eddystone </summary>
    function GetEddystoneServiceData(AFrameType: TAdvertiseDeviceFormat): TBytes;
    /// <summary> Encodes a given URL using eddystone compressed encoding </summary>
    function EncodeEddystoneURL(AURL: string): TBytes;
    /// <summary> Gets the eddystone namespace bytes </summary>
    function GetEddyNamespaceBytes: TBytes;
    /// <summary> Gets the eddystone instance bytes </summary>
    function GetEddyInstanceBytes: TBytes;
    /// <summary> Starts to advertise beacon/eddystone UID/eddystone URL according to AFrameType param  </summary>
    function StartAdvertisingFrames(AFrameType: TAdvertiseDeviceFormat): Boolean;
    /// <summary> Gets an instance of the Beacon Device for the current platform </summary>
    class function GetInstance(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser; virtual; abstract;
    /// <summary> Gets an instance of the Beacon Device as a purpose of help, without GattServer </summary>
    class function GetHelperInstance: TBeaconAdvertiser; virtual; abstract;
    /// <summary> Gets an instance of the Beacon Device as a purpose of help, without GattServer </summary>
    class function GetBeaconAdvertiserHelperInstance: TBeaconAdvertiser;    
  public
    /// <summary> Class constructor </summary>    
    constructor Create(const AGattServer: TBluetoothGattServer = nil; AHelper: Boolean = False);	
    /// <summary> Class destructor </summary>
    destructor Destroy; override;
    /// <summary> Starts to advertise beacon </summary>
    function StartAdvertising: Boolean;
    /// <summary> Stops advertising beacon </summary>
    function StopAdvertising: Boolean;
    /// <summary> Gets the proper Beacon Device for the current platform.
    /// We can specify an existing GattServer that will advertise the beacon information </summary>
    class function GetBeaconAdvertiser(const AGattServer: TBluetoothGattServer = nil): TBeaconAdvertiser;
    /// <summary> GUID of the beacon device </summary>
    property GUID: TGUID read FGUID write FGUID;
    /// <summary> Major value of the beacon device </summary>
    property Major: Word read FMajor write FMajor;
    /// <summary> Minor value of the beacon device </summary>
    property Minor: Word read FMinor write FMinor;
    /// <summary> TxPower value of the beacon device, i.e the expected RSSI at a distance of 1 meter to the beacon.
    /// Specify DEFAULT_TXPOWER (127) to use the default value for the device </summary>
    property TxPower: ShortInt read FTxPower write FTxPower;
    /// <summary> Indicates the current beacon company ID.
    /// This value is always APPLEINC for Mac and iOS platform. </summary>
    property ManufacturerId: Word read FManufacturerId write FManufacturerId;
    /// <summary> Indicates the current beacon device type.
    /// This value is always BEACON_ST_TYPE for Mac and iOS platform. </summary>
    property BeaconType: Word read FBeaconType write FBeaconType;
    /// <summary> When we have have created the beacon device based on an existing Gatt server,
    /// this property indicates if the Gatt server advertise data should be advertised too.
    /// In Mac, it's not possible to advertise beacon data and GattServices simultaneously. </summary>
    property AdvertiseGattInfo: Boolean read FAdvertiseGattInfo write FAdvertiseGattInfo;
    /// <summary> Just for AltBeacon, reserved for use by the manufacturer to implement special features. </summary>
    property MFGReserved: Byte read FMFGReserved write FMFGReserved;
    /// <summary> Indicates if beacon device is advertising. </summary>
    property IsAdvertising: Boolean read GetIsAdvertising;
    /// <summary> Namespace for the Eddystone-UID frame. It must be a string of 20 hexadecimal digits
    /// when NamespaceGenerator is set to ngNone </summary>
    property EddystoneNamespace: string read FEddystoneNamespace write FEddystoneNamespace;
    /// <summary> Instance for the Eddystone-UID frame. It must be a string of 12 hexadecimal digits representing 6 bytes </summary>
    property EddystoneInstance: string read FEddystoneInstance write FEddystoneInstance;
    /// <summary> URL broadcasted by the Eddystone-URL frame. </summary>
    property EddystoneURL: string read FEddystoneURL write FEddystoneURL;
    /// <summary> Type of device to advertise: Beacon, Eddystone-UID or Eddystone-URL </summary>
    property DeviceType: TAdvertiseDeviceFormat read FDeviceType write FDeviceType;
    /// <summary> Method used to generate the Eddystone-UID namespace:
    ///  <para>� ngNone indicates that EddystoneNamespace will be used as a 20 hex digits string representing the 10-bytes namespace value </para>
    ///  <para>� ngHashFQDN takes the first 10 bytes of an SHA-1 hash of the domain name specified in EddystoneNamespace </para>
    ///  <para>� ngElidedUUID uses GUID property removing bytes 5 - 10 (inclusive) to generate 10-bytes namespace </para>
    /// </summary>
    property NamespaceGenerator: TNamespaceGeneratorMethod read FNamespaceGenerator write FNamespaceGenerator;
  end;

  ///<summary> ManufacturerData Helper for creating a TBytes MData </summary>
  TBeaconManufacturerDataHelper = class
  const
    /// <summary> ManufacturereData filter mask for kind of beacon </summary>
    TYPE_OF_BEACON_MASK: TBytes = [$0,$0,$1,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0];
    /// <summary> ManufacturereData filter mask for beacon-GUID </summary>
    GUID_MASK: TBytes = [$0,$0,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$0,$0,$0,$0,$0];
    /// <summary> ManufacturereData filter mask for beacon-GUID-Major </summary>
    GUID_MAJOR_MASK: TBytes = [$0,$0,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$0,$0,$0];
    /// <summary> ManufacturereData filter mask for beacon-Guid-Major-Minor </summary>
    GUID_MINOR_MASK: TBytes = [$0,$0,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$0];
   //Eddystone
    /// <summary> ServiceData filter mask for Eddystone-Namespace </summary>
    EDDY_UID_NAMESPACE_MASK: TBytes = [$1,$0,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$0,$0,$0,$0,$0,$0,$0,$0];
    /// <summary> ServiceData filter mask for Eddystone-Namespace-Instance </summary>
    EDDY_UID_INSTANCE_MASK: TBytes = [$1,$0,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$1,$0,$0];
    /// <summary> ServiceData filter mask for UID-Eddystone </summary>
    EDDY_FRAME_UID_MASK: TBytes = [$1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0];
    /// <summary> ServiceData filter mask for TLM-Eddystone </summary>
    EDDY_FRAME_TLM_MASK: TBytes = [$1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0];
  private
      FBeaconAdvertiser: TBeaconAdvertiser;
      FMDataMask: TBytes;
      FScanMode: TBeaconScanMode;
      FManufacturerId: Integer;
  protected
    /// <summary> GUID of the beacon device </summary>
    procedure SetGUID(AUUID: TGUID);
    /// <summary> GUID of the beacon device </summary>
    function GetGUID: TGUID;
    /// <summary> Major value of the beacon device </summary>
    procedure SetMajor(AMajor: Word);
    /// <summary> Major value of the beacon device </summary>
    function GetMajor: Word;
    /// <summary> Minor value of the beacon device </summary>
    procedure SetMinor(AMinor: Word);
    /// <summary> Minor value of the beacon device </summary>
    function GetMinor: Word;
    /// <summary> TxPower value of the beacon device, i.e the expected RSSI at a distance of 1 meter to the beacon.
    /// Specify DEFAULT_TXPOWER (127) to use the default value for the device </summary>
    procedure SetTxPower(ATxPower: ShortInt);
    /// <summary> TxPower value of the beacon device, i.e the expected RSSI at a distance of 1 meter to the beacon.
    /// Specify DEFAULT_TXPOWER (127) to use the default value for the device </summary>
    function GetTxPower: ShortInt;
    /// <summary> Indicates the current beacon company ID.
    /// This value is always APPLEINC for Mac and iOS platform. </summary>
    procedure SetManufacturerId(AManufactureId: Integer);
    /// <summary> Indicates the current beacon company ID.
    /// This value is always APPLEINC for Mac and iOS platform. </summary>
    function GetManufacturerId: Integer;
    /// <summary> Indicates the current beacon device type.
    /// This value is always BEACON_ST_TYPE for Mac and iOS platform. </summary>
    procedure SetBeaconType(ABeaconType: TKindofBeacon);
    /// <summary> Indicates the current beacon device type.
    /// This value is always BEACON_ST_TYPE for Mac and iOS platform. </summary>
    function GetBeaconType: TKindofBeacon;
    /// <summary> Just for AltBeacon, reserved for use by the manufacturer to implement special features. </summary>
    procedure SetMFGReserved(AMFGReserved: Byte);
    /// <summary> Just for AltBeacon, reserved for use by the manufacturer to implement special features. </summary>
    function GetMFGReserved: Byte;
    ///<summary> MData Helper that converts to TBytes </summary>
    function GetToByteArray: TBytes;
    ///<summary> TBytes Mask for the MData generated </summary>
    function GetMDataMask: TBytes;
    ///<summary> Restarts BeaconManufacturerDataHelper to its initial values  </summary>
    function DoRestartHelper: Boolean;
    /// <summary> ScanMode property </summary>
    property ScanMode: TBeaconScanMode read FScanMode;
  public
    /// <summary> Class constructor </summary>
    constructor Create(AScanMode: TBeaconScanMode = TBeaconScanMode.Standard);
    destructor Destroy; override;
    /// <summary> GUID of the beacon device </summary>
    property GUID: TGUID read GetGUID write SetGUID;
    /// <summary> Major value of the beacon device </summary>
    property Major: Word read GetMajor write SetMajor;
    /// <summary> Minor value of the beacon device </summary>
    property Minor: Word read GetMinor write SetMinor;
    /// <summary> TxPower value of the beacon device, i.e the expected RSSI at a distance of 1 meter to the beacon.
    /// Specify DEFAULT_TXPOWER (127) to use the default value for the device </summary>
    property TxPower: ShortInt read GetTxPower write SetTxPower;
    /// <summary> Indicates the current beacon company ID.
    /// This value is always APPLEINC for Mac and iOS platform. </summary>
    property ManufacturerId: Integer read GetManufacturerId write SetManufacturerId;
    /// <summary> Indicates the current beacon device type.
    /// This value is always BEACON_ST_TYPE for Mac and iOS platform. </summary>
    property BeaconType: TKindofBeacon read GetBeaconType write SetBeaconType;
    /// <summary> Just for AltBeacon, reserved for use by the manufacturer to implement special features. </summary>
    property MFGReserved: Byte read GetMFGReserved write SetMFGReserved;
    ///<summary> MData Helper that converts to TBytes </summary>
    property ToByteArray: TBytes read GetToByteArray;
    ///<summary> TBytes Mask for the MData generated </summary>
    property MDataMask: TBytes read GetMDataMask;
    ///<summary> Restarts BeaconManufacturerDataHelper to its initial values  </summary>
    property RestartHelper: Boolean read DoRestartHelper;
  end;

implementation

uses
{$IFDEF IOS}
  System.IOS.Beacon,
{$ENDIF IOS}
  System.Beacon.Common,
{$IFDEF ANDROID}
  System.Android.Beacon,
{$ENDIF ANDROID}
{$IFDEF MACOS}
  System.Mac.Beacon,
{$ENDIF MACOS}
{$IFDEF MSWINDOWS}
  System.Win.Beacon,
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  System.Linux.Beacon,
{$ENDIF LINUX}
  System.NetConsts,
  System.Classes,
  System.Hash,
  System.Types;


{ TEddystoneUID }

function TEddystoneUID.SetNamespace(const Value: string): boolean;
var
  TB: TBytes;
begin
  Result := True;
  if Length(Value) div 2 = EDDY_UID_NAMESPACE_LEN then
    try
      SetLength(TB, EDDY_UID_NAMESPACE_LEN);
      if HexToBin(PChar(Value), 0, TB, 0, EDDY_UID_NAMESPACE_LEN) = EDDY_UID_NAMESPACE_LEN then
      begin
        Move(TB[0], Namespace[0], EDDY_UID_NAMESPACE_LEN);
      end
      else
        Result := False;
    except
      Result := False;
    end
  else
   Result := False;
end;

function TEddystoneUID.SetInstance(const Value: string): boolean;
var
 TB: TBytes;
begin
  Result := True;
  if Length(Value) div 2 = EDDY_UID_INSTANCE_LEN then
    try
      SetLength(TB, EDDY_UID_INSTANCE_LEN);
      if HexToBin(PChar(Value), 0, TB, 0, EDDY_UID_INSTANCE_LEN) = EDDY_UID_INSTANCE_LEN then
      begin
        Move(TB[0], Instance[0], EDDY_UID_INSTANCE_LEN);
      end
      else
        Result := False;
    except
      Result := False;
    end
  else
    Result := False;
end;

function TEddystoneUID.GetNamespace: string;
begin
  Result := TBytesToHexString(Namespace);
end;

function TEddystoneUID.GetInstance: string;
begin
  Result := TBytesToHexString(Instance);
end;

function TEddystoneUID.TBytesToHexString(const AValue: array of Byte): string;
var
  I:Integer;
begin
  Result := '';
  for I:= 0 to Length(AValue) - 1 do
    Result := Result + AValue[I].ToHexString(2);
end;

{ TEddysUIDRegion }

function TEddysUIDRegion.GetNamespace: TNamespace;
begin
  Result := FEddystoneUID.Namespace;
end;

function TEddysUIDRegion.GetInstance: TInstance;
begin
  Result := FEddystoneUID.Instance;
end;

function TEddysUIDRegion.GetNamespaceST: string;
begin
  Result := FEddystoneUID.GetNamespace;
end;

function TEddysUIDRegion.GetInstanceST: string;
begin
  if FAllInstances then
    Result := EDDY_UID_INSTANCE_ALL
  else
    Result := FEddystoneUID.GetInstance;
end;

procedure TEddysUIDRegion.Initialize(const ANamespace: TNamespace);
begin
  FEddystoneUID.Namespace := ANamespace;
  FAllInstances := True;
end;

procedure TEddysUIDRegion.Initialize(const ANamespace: TNamespace; const AInstance: TInstance);
begin
  FEddystoneUID.Namespace := ANamespace;
  FEddystoneUID.Instance := AInstance;
  FAllInstances := False;
end;

procedure TEddysUIDRegion.Initialize(const ANamespaceST: string);
begin
  FEddystoneUID.SetNamespace(ANamespaceST);
  FAllInstances := True;
end;

procedure TEddysUIDRegion.Initialize(const ANamespaceST: string; const AInstanceST: string);
begin
  FEddystoneUID.SetNamespace(ANamespaceST);
  if FEddystoneUID.SetInstance(AInstanceST) then
    FAllInstances := False
  else
    FAllInstances := True;
end;

{ TiBAltBeaconRegion }

procedure TiBAltBeaconRegion.Initialize(const AGUID: TGUID; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer);
begin
  FGUID := AGUID;
  FMajor := MAJOR_REGION_ALL;
  FMinor := MINOR_REGION_ALL;
  FKindofBeacon := AKindofBeacon;
  SetManufacturerID(AManufacturerID);
end;

procedure TiBAltBeaconRegion.Initialize(const AGUID: TGUID; AMajor: Integer; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer);
begin
  FGUID := AGUID;
  if (AMajor > MAJOR_REGION_ALL) and (AMajor <= Word.MaxValue) then
    FMajor := AMajor
  else
    FMajor := MAJOR_REGION_ALL;
  FMinor := MINOR_REGION_ALL;
  FKindofBeacon := AKindofBeacon;
  SetManufacturerID(AManufacturerID);
end;

procedure TiBAltBeaconRegion.Initialize(const AGUID: TGUID; AMajor, AMinor: Integer; AKindofBeacon: TKindofBeacon; AManufacturerID: Integer);
begin
  FGUID := AGUID;
  if (AMajor > MAJOR_REGION_ALL) and (AMajor <= Word.MaxValue) then
    FMajor := AMajor
  else
    FMajor := MAJOR_REGION_ALL;
  if (AMinor > MINOR_REGION_ALL) and (AMinor <= Word.MaxValue) then
    FMinor := AMinor
  else
    FMinor := MINOR_REGION_ALL;
  FKindofBeacon := AKindofBeacon;
  SetManufacturerID(AManufacturerID);
end;

procedure TiBAltBeaconRegion.SetManufacturerID(AManufacturerID: Integer);
begin
  if (AManufacturerID > MANUFATURER_ID_ALL) and (AManufacturerID <= Word.MaxValue) then
    FManufacturerID := Word(AManufacturerID)
  else
    FManufacturerID := MANUFATURER_ID_ALL;
end;

{ TEddystoneURL }

function TEddystoneURL.URLToString: string;
const
  L_EDDY_URL_SCHEME_POS = 0;
  L_EDDY_MIN_URL_LEN = 1;
var
  LURL: string;
  I: Integer;
begin
  LURL := '';
  if Length(Self.EncodedURL) > L_EDDY_URL_SCHEME_POS then
  begin
    if Self.EncodedURL[L_EDDY_URL_SCHEME_POS] < Length(TBeaconAdvertiser.EDDY_SCHEME_PREFIXES) then
      LURL := TBeaconAdvertiser.EDDY_SCHEME_PREFIXES[Self.EncodedURL[L_EDDY_URL_SCHEME_POS]];

    if (Length(Self.EncodedURL) > L_EDDY_MIN_URL_LEN) then
      for I := 1 to Length(Self.EncodedURL) - 1 do
        if Self.EncodedURL[I] < Length(TBeaconAdvertiser.EDDY_URL_EXPANSIONS) then
          LURL := LURL + TBeaconAdvertiser.EDDY_URL_EXPANSIONS[Self.EncodedURL[I]]
        else
          if (Self.EncodedURL[I] > $20) and (Self.EncodedURL[I] < $7F) then
            LURL := LURL + char(Self.EncodedURL[I]);
  end;
  Result := LURL;
end;

{ TEddystoneTLM }

function TEddystoneTLM.AdvPDUCountToString: string;
begin
  Result := Self.AdvPDUCount.ToString;
end;

function TEddystoneTLM.BattVoltageToString: string;
begin
  Result := Self.BattVoltage.ToString+' mV';
end;

function TEddystoneTLM.BeaconTempToSingle: Single;
const
  Fixedpoint = 256;
begin
  Result := (WordRec(Self.BeaconTemp).Lo / Fixedpoint) + (WordRec(Self.BeaconTemp).Hi);
end;

function TEddystoneTLM.BeaconTempToString: string;
begin
  Result := BeaconTempToSingle.ToString(TFloatFormat.ffFixed, 5, 2)+'튏';
end;

function TEddystoneTLM.TimeSincePowerOnToTTimeSpan: TTimeSpan;
begin
  Result := TTimeSpan.FromSeconds(Self.TimeSincePowerOn / 10);
end;

function TEddystoneTLM.TimeSincePowerOnToString: string;
var
  LTimeSpan: TTimeSpan;
begin
  LTimeSpan := TimeSincePowerOnToTTimeSpan;
  Result :=  LTimeSpan.Days.ToString+' days + '+Format('%.2d:%.2d:%.2d.%.3d',
    [LTimeSpan.Hours, LTimeSpan.Minutes, LTimeSpan.Seconds, LTimeSpan.Milliseconds]);
end;

{ TMeanCalculator }

function TMeanCalculator<T>.AddGetValue(AValue: T; IsMoving: Boolean): T;
begin
  AddValue(AValue);
  if not IsMoving then
    Result := Get// Median Noise Filter
  else
    if IsFull then
    begin
      Reset;
      AddValue(AValue);
      Result := AValue;
    end
    else
      Result := Get;
end;

procedure TMeanCalculator<T>.AddValue(AValue: T);
begin
  ArrayRatio[Index] := AValue;
  Inc(Index);
  FIsEmpty := False;

  if Index = FSize then
  begin
    Index := 0;
    IsFull := True;
  end;
end;

function TMeanCalculator<T>.GetAsDouble: Double;
var
  I: Integer;
  LValue: Double;
begin
  if not IsFull then
  begin
    Result := 0;
    for I := 0 to Index - 1 do
    begin
      Move(ArrayRatio[I], LValue, SizeOf(Double));
      Result := Result + LValue;
    end;
    Result := Result / Index;
  end
  else
    Result := GetMedianAsDouble;
end;

function TMeanCalculator<T>.GetAsInteger: Integer;
var
  I: Integer;
  LValue: Integer;
begin
  if not IsFull then
  begin
    Result := 0;
    for I := 0 to Index - 1 do
    begin
      Move(ArrayRatio[I], LValue, SizeOf(Integer));
      Result := Result + LValue;
    end;
    Result := Round(Result / Index);
  end
  else
    Result := GetMedianAsInteger;
end;

function TMeanCalculator<T>.GetMedianAsDouble: Double;
var
  LArrayRatio: TArray<T>;
begin
  SetLength(LArrayRatio, FSize);
  TArray.Copy<T>(ArrayRatio, LArrayRatio, FSize);
  TArray.Sort<T>(LArrayRatio);
  Result := (PDouble(@LArrayRatio[FCenter])^ + PDouble(@LArrayRatio[FCenter + 1])^) / 2;
  SetLength(LArrayRatio, 0);
end;

function TMeanCalculator<T>.GetMedianAsInteger: Integer;
var
  LArrayRatio: TArray<T>;
begin
  SetLength(LArrayRatio, FSize);
  TArray.Copy<T>(ArrayRatio, LArrayRatio, FSize);
  TArray.Sort<T>(LArrayRatio);
  Result := (PInteger(@LArrayRatio[FCenter])^ + PInteger(@LArrayRatio[FCenter + 1])^) div 2;
  SetLength(LArrayRatio, 0);
end;

function TMeanCalculator<T>.IsEmpty: Boolean;
begin
  Result := FIsEmpty;
end;

function TMeanCalculator<T>.GetLast: T;
begin
  if Index = 0 then
    Result := ArrayRatio[FSize - 1]
  else
    Result := ArrayRatio[Index - 1];
end;

function TMeanCalculator<T>.Get: T;
begin
  case GetTypeKind(T) of
    tkInteger:
      PInteger(@Result)^ := GetAsInteger;
    tkFloat:
      PDouble(@Result)^ := GetAsDouble;
  end;
end;

constructor TMeanCalculator<T>.Create(const ASize: Integer);
begin
  SetSize(ASize);
  Reset;
end;

procedure TMeanCalculator<T>.Reset;
var
  I: Integer;
begin
  FillChar(ArrayRatio[0], Length(ArrayRatio) * SizeOf(T), 0);
  Index := 0;
  IsFull := False;
  FIsEmpty := True;
end;

procedure TMeanCalculator<T>.SetSize(ASize: Integer);
begin
  if ASize <> FSize then
  begin
    SetLength(ArrayRatio, ASize);
    FSize := ASize;
    FCenter := FSize shr 1;
  end;
end;

{ TBeaconManufacturerParsers }

constructor TBeaconManufacturerParsers.Create;
begin
  FParsers := TDictionary<string, TBeaconManufacturerDataParserClass>.Create;
end;

destructor TBeaconManufacturerParsers.Destroy;
begin
  FParsers.Free;
  inherited;
end;

procedure TBeaconManufacturerParsers.RegisterParser(const AParser: TBeaconManufacturerDataParserClass; const AParserIdentifier: string);
begin
  FParsers.Add(AParserIdentifier, AParser);
end;

procedure TBeaconManufacturerParsers.UnRegisterParser(const AParserIdentifier: string);
begin
  FParsers.Remove(AParserIdentifier);
end;

function TBeaconManufacturerParsers.Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FParsers.Values.Count - 1 do
  begin
    Result := FParsers.Values.ToArray[I].Parse(AData, BeaconInfo);
    if Result then
      Break;
  end;
end;

{ TBeaconManager }

function TBeaconManager.UnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := DoUnregisterBeacon(AGUID, AKindofBeacon);
end;

function TBeaconManager.UnregisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := DoUnregisterBeacon(AGUID, AMajor, AKindofBeacon);
end;

function TBeaconManager.UnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := DoUnregisterBeacon(AGUID, AMajor, AMinor, AKindofBeacon);
end;

function TBeaconManager.UnRegisterBeacons(const ABeaconRegion: TBeaconsRegion): Boolean;
begin
begin
  case ABeaconRegion.KindofBeacon of
    TKindofBeacon.Eddystones:
    begin
      if ABeaconRegion.EddysUIDRegion.AllInstances then
        Result := DoUnRegisterEddyBeacon(ABeaconRegion.EddysUIDRegion.Namespace)
      else
        Result := DoUnRegisterEddyBeacon(ABeaconRegion.EddysUIDRegion.Namespace, ABeaconRegion.EddysUIDRegion.Instance);
    end;
    TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
    begin
      if ABeaconRegion.iBAltBeaconRegion.Minor <> MINOR_REGION_ALL then
        Result := DoUnRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.iBAltBeaconRegion.Major,
          ABeaconRegion.iBAltBeaconRegion.Minor, ABeaconRegion.KindofBeacon)
      else
        if ABeaconRegion.iBAltBeaconRegion.Major <> MAJOR_REGION_ALL then
          Result := DoUnRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.iBAltBeaconRegion.Major,
            ABeaconRegion.KindofBeacon)
        else
          Result := DoUnRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.KindofBeacon)
    end;
    else
      Result := False;
  end;
end;
end;

procedure TBeaconManager.DoBeaconChangedProximity(const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
begin
  if Assigned(FOnBeaconProximity) then
    try
      FOnBeaconProximity(Self, ABeacon, CurrentProximity);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

function TBeaconManager.DoBeaconCalcDistance(const UUID: TGUID; AMajor, AMinor: Word;
  ATxPower: Integer; ARssi: Integer; var NewDistance: Double): Boolean;
begin
  Result := False;
  if Assigned(FOnCalcDistance) then
    try
      FOnCalcDistance(Self, UUID, AMajor, AMinor, ATxPower, ARssi, NewDistance);
      Result := True;
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

function TBeaconManager.DoBeaconCalcDistance(const Abeacon: IBeacon; ATxPower: Integer; ARssi: Integer;
  var NewDistance: Double): Boolean;
begin
  Result := False;
  if Assigned(FOnCalculateDistances) then
    try
      FOnCalculateDistances(Self, Abeacon, ATxPower, ARssi, NewDistance);
      Result := True;
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoParseManufacturerData(const AData: TBytes; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  Handled := False;
  if Assigned(FOnParseManufacturerData) then
    FOnParseManufacturerData(Self, TManufacturerRawData(AData), BeaconInfo, Handled);
end;

procedure TBeaconManager.DoParseServiceData(const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  Handled := False;
  if Assigned(FOnParseServiceData) then
    FOnParseServiceData(Self, AData, BeaconInfo, Handled);
end;

procedure TBeaconManager.SetKindofBeacons(AValue: TKindofBeacons);
begin
  if TKindofBeacon.iBAltBeacons in AValue then
  begin
    Exclude(AValue, TKindofBeacon.iBAltBeacons);
    AVaLue := Avalue + [TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons];
  end;
  DoSetKindofBeacons(AValue);
end;

procedure TBeaconManager.DoBeaconEnter(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  if Assigned(FOnBeaconEnter) then
    try
      FOnBeaconEnter(Self, ABeacon, CurrentBeaconList);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoBeaconExit(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  if Assigned(FOnBeaconExit) then
    try
      FOnBeaconExit(Self, aBeacon, CurrentBeaconList);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoNewEddystoneURL(const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
begin
  if Assigned(FOnNewEddystoneURL) then
    try
      FOnNewEddystoneURL(Self, ABeacon, AEddystoneURL);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoNewEddystoneTLM(const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
begin
  if Assigned(FOnNewEddystoneTLM) then
    try
      FOnNewEddystoneTLM(Self, ABeacon, AEddystoneTLM);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoBeaconsRegionEnter(const ABeaconRegion: TBeaconsRegion);
begin
  if Assigned(FOnBeaconsEnterRegion) then
    try
      FOnBeaconsEnterRegion(Self, ABeaconRegion);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoRegionEnter(const UUID: TGUID; AMajor, AMinor: Integer);
begin
  if Assigned(FOnEnterRegion) then
    try
      FOnEnterRegion(Self, UUID, AMajor, AMinor);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoBeaconsRegionExit(const ABeaconRegion: TBeaconsRegion);
begin
  if Assigned(FOnBeaconsExitRegion) then
    try
      FOnBeaconsExitRegion(Self, ABeaconRegion);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoRegionExit(UUID: TGUID; AMajor, AMinor: Integer);
begin
  if Assigned(FOnExitRegion) then
    try
      FOnExitRegion(Self, UUID, AMajor, AMinor);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoNewBLEScanFilter(AKindofScanFilter: TKindofScanFilter;
  const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
begin
  if Assigned(FOnNewBLEScanFilterEvent) then
    try
      FOnNewBLEScanFilterEvent(Self, AKindofScanFilter, ABluetoothLEScanFilter);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

procedure TBeaconManager.DoBeaconError(AError: TBeaconError; const AMsg: string; const ABeacon: TBeaconInfo);
begin
  if Assigned(FOnBeaconErrorEvent) then
    try
      FOnBeaconErrorEvent(Self, AError, AMsg, ABeacon);
    except
      if Assigned(ApplicationHandleException) then
        ApplicationHandleException(Self)
      else
        raise;
    end;
end;

class function TBeaconManager.GetBeaconManager(AMode: TBeaconScanMode): TBeaconManager;
begin
{$IFDEF MSWINDOWS}
  if TOSVersion.Check(10) then
    Result := System.Beacon.Common.TPlatformBeaconManager.GetInstance(AMode)
  else
    raise ENotImplemented.Create(SAPINotAvailable);
{$ENDIF}
{$IF defined(ANDROID) or (defined(MACOS) and NOT defined(IOS))}
  Result := System.Beacon.Common.TPlatformBeaconManager.GetInstance(AMode);
{$ENDIF}
{$IFDEF IOS}
    Result := System.IOS.Beacon.TPlatformBeaconManager.GetInstance(AMode)
{$ENDIF}
end;

function TBeaconManager.Nearest: IBeacon;
begin
  Result := DoNearest;
end;

function TBeaconManager.RegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := DoRegisterBeacon(AGUID, AKindofBeacon, AManufacturerId);
end;

function TBeaconManager.RegisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := DoRegisterBeacon(AGUID, AMajor, AKindofBeacon, AManufacturerId);
end;

function TBeaconManager.RegisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := DoRegisterBeacon(AGUID, AMajor, AMinor, AKindofBeacon, AManufacturerId);
end;

function TBeaconManager.RegisterBeacons(const ABeaconRegion: TBeaconsRegion): Boolean;
begin
  case ABeaconRegion.KindofBeacon of
    TKindofBeacon.Eddystones:
    begin
      if ABeaconRegion.EddysUIDRegion.AllInstances then
        Result := DoRegisterEddyBeacon(ABeaconRegion.EddysUIDRegion.Namespace)
      else
        Result := DoRegisterEddyBeacon(ABeaconRegion.EddysUIDRegion.Namespace, ABeaconRegion.EddysUIDRegion.Instance);
    end;
    TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
    begin
      if ABeaconRegion.iBAltBeaconRegion.Minor <> MINOR_REGION_ALL then
        Result := DoRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.iBAltBeaconRegion.Major,
          ABeaconRegion.iBAltBeaconRegion.Minor, ABeaconRegion.KindofBeacon, ABeaconRegion.iBAltBeaconRegion.ManufacturerId)
      else
        if ABeaconRegion.iBAltBeaconRegion.Major <> MAJOR_REGION_ALL then
          Result := DoRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.iBAltBeaconRegion.Major,
            ABeaconRegion.KindofBeacon, ABeaconRegion.iBAltBeaconRegion.ManufacturerId)
        else
          Result := DoRegisterBeacon(ABeaconRegion.iBAltBeaconRegion.GUID, ABeaconRegion.KindofBeacon,
            ABeaconRegion.iBAltBeaconRegion.ManufacturerId)
    end;
    else
      Result := False;
  end;
end;

function TBeaconManager.StartScan: Boolean;
begin
  Result := DoStartScan;
end;

function TBeaconManager.StopScan: Boolean;
begin
  Result := DoStopScan;
end;

{ TBeaconAdvertiser }

constructor TBeaconAdvertiser.Create(const AGattServer: TBluetoothGattServer; AHelper: Boolean);
begin
  inherited Create;
  FBeaconType := BEACON_ST_TYPE;
  FTxPower := DEFAULT_TXPOWER;
  FMFGReserved := 0;
  FDeviceType := TAdvertiseDeviceFormat.adBeacon;
  FNamespaceGenerator := ngHashFQDN;
  FEddystoneNamespace := 'example.com';
  FEddystoneInstance := '000000000001';

  if not AHelper then  
    if AGattServer <> nil then
	  FGattServer := AGattServer
	else
	begin
	  FGattServer := TBluetoothLEManager.Current.GetGattServer;
 	  FOwnsGattServer := True;
	end;
end;

destructor TBeaconAdvertiser.Destroy;
begin
  if FOwnsGattServer then
    FGattServer.Free
  else
    StopAdvertising;
  inherited;
end;

function TBeaconAdvertiser.EncodeEddystoneURL(AURL: string): TBytes;
var
  I: Integer;
begin
  // Ensure http scheme
  if (not AURL.StartsWith('http://', True)) and (not AURL.StartsWith('https://', True)) then
    AURL := 'http://' + AURL;
  // Replace scheme prefix
  for I := Low(EDDY_SCHEME_PREFIXES) to High(EDDY_SCHEME_PREFIXES) do
    if AURL.StartsWith(EDDY_SCHEME_PREFIXES[I], True) then
    begin
      AURL := StringReplace(AURL, EDDY_SCHEME_PREFIXES[I], Chr(I), [rfIgnoreCase]);
      Break;
    end;
  // Replace URL expansions
  for I := Low(EDDY_URL_EXPANSIONS) to High(EDDY_URL_EXPANSIONS) do
    AURL := StringReplace(AURL, EDDY_URL_EXPANSIONS[I], Chr(I), [rfIgnoreCase]);
  Result := TEncoding.UTF8.GetBytes(AURL);
end;

class function TBeaconAdvertiser.GetBeaconAdvertiser(const AGattServer: TBluetoothGattServer): TBeaconAdvertiser;
begin
  Result := TPlatformBeaconAdvertiser.GetInstance(AGattServer);
end;

class function TBeaconAdvertiser.GetBeaconAdvertiserHelperInstance: TBeaconAdvertiser;
begin
  Result := TPlatformBeaconAdvertiser.GetHelperInstance;
end;

function TBeaconAdvertiser.GetEddyInstanceBytes: TBytes;
begin
  SetLength(Result, EDDY_UID_INSTANCE_LEN);
  if (Length(FEddystoneInstance) <> (EDDY_UID_INSTANCE_LEN * 2)) or
    (HexToBin(PChar(FEddystoneInstance), 0, Result, 0, EDDY_UID_INSTANCE_LEN) <> EDDY_UID_INSTANCE_LEN) then
    raise EBeaconAdvertiserException.CreateFmt(SInvalidEddystoneInstance, [FEddystoneInstance]);
end;

function TBeaconAdvertiser.GetEddyNamespaceBytes: TBytes;
begin
  SetLength(Result, EDDY_UID_NAMESPACE_LEN);
  case FNamespaceGenerator of
    ngNone:
      if (Length(FEddystoneNamespace) <> (EDDY_UID_NAMESPACE_LEN * 2)) or
        (HexToBin(PChar(FEddystoneNamespace), 0, Result, 0, EDDY_UID_NAMESPACE_LEN) <> EDDY_UID_NAMESPACE_LEN) then
        raise EBeaconAdvertiserException.CreateFmt(SInvalidEddystoneNamespace, [FEddystoneNamespace]);
    ngHashFQDN:
      begin
        if FEddystoneNamespace = '' then
          raise EBeaconAdvertiserException.CreateFmt(SInvalidEddystoneNamespace, [FEddystoneNamespace]);
        Move(THashSHA1.GetHashBytes(FEddystoneNamespace)[0], Result[0], EDDY_UID_NAMESPACE_LEN);
      end;
    ngElidedUUID:
      begin
        if FGUID = TGUID.Empty then
          raise EBeaconAdvertiserException.Create(SBeaconDeviceNoUUID);
        Move(FGUID.ToByteArray(TEndian.Big)[0], Result[0], 4);
        Move(FGUID.ToByteArray(TEndian.Big)[10], Result[4], 6);
      end;
  end;
end;

function TBeaconAdvertiser.GetEddystoneServiceData(AFrameType: TAdvertiseDeviceFormat): TBytes;
var
  LNamespaceBytes, LInstanceBytes, LURLBytes: TBytes;
begin
  case AFrameType of
    adEddystoneUID:
      begin
        LNamespaceBytes := GetEddyNamespaceBytes;
        LInstanceBytes := GetEddyInstanceBytes;
        SetLength(Result, EDDY_UID_LEN);
        Result[EDDY_FRAMETYPE_POS] := EDDYSTONE_UID;
        Result[EDDY_TX_POS] := Byte(TxPower + EDDY_SIGNAL_LOSS_METER);
        Move(LNamespaceBytes[0], Result[EDDY_UID_NAMESPACE_POS], EDDY_UID_NAMESPACE_LEN);
        Move(LInstanceBytes[0], Result[EDDY_UID_INSTANCE_POS], EDDY_UID_INSTANCE_LEN);
      end;
    TAdvertiseDeviceFormat.adEddystoneURL:
      begin
        LURLBytes := EncodeEddystoneURL(EddystoneURL);
        if Length(LURLBytes) > 17  then
          SetLength(LURLBytes, 17);
        SetLength(Result, Length(LURLBytes) + 2);
        Result[EDDY_FRAMETYPE_POS] := EDDYSTONE_URL;
        Result[EDDY_TX_POS] := Byte(TxPower + EDDY_SIGNAL_LOSS_METER);
        Move(LURLBytes[0], Result[EDDY_URL_SCHEME_POS], Length(LURLBytes));
      end;
  end;
end;

function TBeaconAdvertiser.GetIsAdvertising: Boolean;
begin
  if FGattServer <> nil then
    Result := FGattServer.IsAdvertising
  else
    Result := False;
end;

function TBeaconAdvertiser.StartAdvertising: Boolean;
begin
  if DeviceType = adBeacon then
  begin
    if FGUID = TGUID.Empty then
      raise EBeaconAdvertiserException.Create(SBeaconDeviceNoUUID);
  end;
{$IFNDEF ANDROID}
  if DeviceType <> adBeacon then
    raise EBeaconAdvertiserException.Create(SEddystoneAdvertiseNotSupported);
{$ENDIF}
  Result := StartAdvertisingFrames(DeviceType);
end;

function TBeaconAdvertiser.StartAdvertisingFrames(AFrameType: TAdvertiseDeviceFormat): Boolean;
begin
  if FGattServer <> nil then
  begin
    StopAdvertising;
    case AFrameType of
      adBeacon:
        FGattServer.AdvertiseData.ManufacturerSpecificData := GetManufacturerData;
      adEddystoneUID, TAdvertiseDeviceFormat.adEddystoneURL:
        begin
          FGattServer.AdvertiseData.AddServiceUUID(TBeaconManager.EDDYSTONE_SERVICE_UUID);
          FGattServer.AdvertiseData.AddServiceData(TBeaconManager.EDDYSTONE_SERVICE_UUID, GetEddystoneServiceData(AFrameType));
        end;
    end;
    FGattServer.StartAdvertising;
    Result := True;
  end
  else
    Result := False;
end;

function TBeaconAdvertiser.StopAdvertising: Boolean;
begin
  if FGattServer <> nil then
  begin
    FGattServer.StopAdvertising;
    case DeviceType of
      adBeacon:
        FGattServer.AdvertiseData.ManufacturerSpecificData := [];
      adEddystoneUID, adEddystoneURL:
        begin
          FGattServer.AdvertiseData.ClearServiceUUIDs;
          FGattServer.AdvertiseData.ClearServiceData;
        end;
    end;
    Result := True;
  end
  else
    Result := False;
end;

{ TBeaconManufacturerDataHelper }

constructor TBeaconManufacturerDataHelper.Create(AScanMode: TBeaconScanMode);
begin
  FBeaconAdvertiser := TBeaconAdvertiser.GetBeaconAdvertiserHelperInstance;
  DoRestartHelper;
  FScanMode := AScanMode;
end;

destructor TBeaconManufacturerDataHelper.Destroy;
begin
  FBeaconAdvertiser.Free;
  inherited;
end;

function TBeaconManufacturerDataHelper.DoRestartHelper: Boolean;
begin
  FBeaconAdvertiser.GUID := TGUID.Empty;
  FBeaconAdvertiser.FMajor := $0;
  FBeaconAdvertiser.Minor := $0;
  FBeaconAdvertiser.ManufacturerId := APPLEINC;
  FBeaconAdvertiser.BeaconType := BEACON_ST_TYPE;
  FBeaconAdvertiser.TxPower := DEFAULT_TXPOWER;
  FBeaconAdvertiser.MFGReserved := 0;
  FMDataMask := nil;
  FManufacturerId := MANUFATURER_ID_ALL;
  Result := True;
end;

function TBeaconManufacturerDataHelper.GetBeaconType: TKindofBeacon;
begin
  if FBeaconAdvertiser.BeaconType = BEACON_ST_TYPE then
    Result := TKindofBeacon.iBeacons
  else
    Result := TKindofBeacon.AltBeacons;
end;

function TBeaconManufacturerDataHelper.GetGUID: TGUID;
begin
  Result := FBeaconAdvertiser.GUID;
end;

function TBeaconManufacturerDataHelper.GetMajor: Word;
begin
  Result := FBeaconAdvertiser.Major;
end;

function TBeaconManufacturerDataHelper.GetMFGReserved: Byte;
begin
  Result := FBeaconAdvertiser.MFGReserved;
end;

function TBeaconManufacturerDataHelper.GetMinor: Word;
begin
  Result := FBeaconAdvertiser.Minor;
end;

function TBeaconManufacturerDataHelper.GetToByteArray: TBytes;
begin
  Result := FBeaconAdvertiser.GetManufacturerData;
  if (BeaconType = TKindofBeacon.AltBeacons) and (PWord(@Result[BEACON_TYPE_POS])^ <> BEACON_AL_TYPE) then
    begin
      SetLength(Result, ALTERNATIVE_DATA_LENGTH);
      PWord(@Result[BEACON_MANUFACTURER_ID_POSITION])^ := Word(ManufacturerId);
      PWord(@Result[BEACON_TYPE_POS])^ := Swap(BEACON_AL_TYPE);
      Result[ALTERNATIVE_DATA_LENGTH - 1] := MFGReserved;
    end;
end;

function TBeaconManufacturerDataHelper.GetMDataMask: TBytes;
const
  MANUFACTURER_IDMASK: Word = $0101;
begin
  if FMDataMask <> nil then
  begin
    if (BeaconType = TKindofBeacon.AltBeacons) then
    begin
      SetLength(FMDataMask, Length(FMDataMask) + 1);
      if MFGReserved <> 0 then
        FMDataMask[Length(FMDataMask) - 1] := &1
      else
        FMDataMask[Length(FMDataMask) - 1] := &0;
    end;
    if FManufacturerId > MANUFATURER_ID_ALL then
    begin
      PWord(@FMDataMask[BEACON_MANUFACTURER_ID_POSITION])^ := MANUFACTURER_IDMASK;
    end;
  end;

  Result := FMDataMask;
end;

function TBeaconManufacturerDataHelper.GetTxPower: ShortInt;
begin
  Result := FBeaconAdvertiser.TxPower;
end;

procedure TBeaconManufacturerDataHelper.SetBeaconType(ABeaconType: TKindofBeacon);
begin
  if ABeaconType = TKindofBeacon.iBAltBeacons then
  begin
    if ScanMode = TBeaconScanMode.Standard then
      ABeaconType := TKindofBeacon.iBeacons
    else
      ABeaconType := TKindofBeacon.AltBeacons;
  end;

  if ABeaconType = TKindofBeacon.iBeacons then
    FBeaconAdvertiser.BeaconType := BEACON_ST_TYPE
  else
    FBeaconAdvertiser.BeaconType := BEACON_AL_TYPE;
end;

procedure TBeaconManufacturerDataHelper.SetGUID(AUUID: TGUID);
begin
  FBeaconAdvertiser.GUID := AUUID;
  FMDataMask := GUID_MASK;
end;

procedure TBeaconManufacturerDataHelper.SetMajor(AMajor: Word);
begin
  FBeaconAdvertiser.Major := AMajor;
  FMDataMask := GUID_MAJOR_MASK;
end;

procedure TBeaconManufacturerDataHelper.SetMinor(AMinor: Word);
begin
  FBeaconAdvertiser.Minor := AMinor;
  FMDataMask := GUID_MINOR_MASK;
end;

procedure TBeaconManufacturerDataHelper.SetManufacturerId(AManufactureId: Integer);
begin
  if (AManufactureId >= MANUFATURER_ID_ALL) and (AManufactureId <= $FFFF) then
  begin
    if (AManufactureId > MANUFATURER_ID_ALL) then
      FBeaconAdvertiser.ManufacturerId := Word(AManufactureId);
    FManufacturerId := AManufactureId;
  end;
end;

function TBeaconManufacturerDataHelper.GetManufacturerId: Integer;
begin
  Result := FManufacturerId;
end;

procedure TBeaconManufacturerDataHelper.SetMFGReserved(AMFGReserved: Byte);
begin
  FBeaconAdvertiser.MFGReserved := AMFGReserved;
end;

procedure TBeaconManufacturerDataHelper.SetTxPower(ATxPower: ShortInt);
begin
  FBeaconAdvertiser.TxPower := ATxPower;
end;

end.
