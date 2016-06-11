{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Beacon.Components;

interface

uses
  System.Classes, System.SysUtils, System.Beacon, System.Bluetooth, System.NetConsts;

type

  /// <summary>
  ///  Exception type for the beacon Components
  /// </summary>
  EBeaconComponentException = class(EComponentError);

  ///<summary>TBeaconRegionItem is the class to hold the information about a registered region. </summary>
  TBeaconRegionItem = class(TCollectionItem)
  private
    FMinor: Integer;
    FMajor: Integer;
    FGUID: TGUID;
    FKindofBeacon: TKindofBeacon;
    FEddyUID: TEddystoneUID;
    FEddyStInstance: string;
    FManufacturerID: Integer;
    procedure SetGUID(const AValue: TGUID);
    procedure SetMajor(AValue: Integer);
    procedure SetMinor(AValue: Integer);
    procedure SetUUID(const AValue: string);
    function GetUUID: string;
    function GetEddyNamespace: string;
    procedure SetEddyNamespace(const AValue: string);
    function GetEddyInstance: string;
    procedure SetEddyInstance(const AValue: string);
    procedure SetManufacturerID(const AValue: string);
    function GetManufacturerID: string;
  public
    ///  <summary>
    ///  Creates a new TBeaconRegionItem object
    ///  </summary>
    constructor Create(Collection: TCollection); override;
    ///  <summary>
    ///  Overrides the base class assign method to copy the data from another TBeaconRegionItem
    ///  </summary>
    procedure Assign(Source: TPersistent); override;
    ///  <summary>
    ///  GUID used to monitor the region
    ///  </summary>
    property GUID: TGUID read FGUID write SetGUID;
    ///  <summary>
    ///  ManufacturerID to Integer.
    ///  </summary>
    property ManufacturerIdToInt: Integer read FManufacturerID default MANUFATURER_ID_ALL;
  published
    ///  <summary>
    ///  UUID is a GUID used to monitor the region
    ///  </summary>
    property UUID: string read GetUUID write SetUUID;
    ///  <summary>
    ///  Major is an identifier to filter the UUID region.
    ///  MAJOR_REGION_ALL constant as value indicates we are monitoring all major values in the region
    ///  </summary>
    property Major: Integer read FMajor write SetMajor default MAJOR_REGION_ALL;
    ///  <summary>
    ///  Minor is an identifier to filter the UUID region.
    ///  MINOR_REGION_ALL constant as value indicates we are monitoring all minor values in the region
    ///  </summary>
    property Minor: Integer read FMinor write SetMinor default MINOR_REGION_ALL;
    ///  <summary>
    ///  KindofBeacon is the beacon specification to be set.
    ///  </summary>
    property KindofBeacon: TKindofBeacon read FKindofBeacon write FKindofBeacon default TKindofBeacon.iBAltBeacons;
    ///  <summary>
    ///  EddyNamespace is the Namespace ID for the Eddystone-UID Beacon.
    ///  </summary>
    property EddyNamespace: string read GetEddyNamespace write SetEddyNamespace;
    ///  <summary>
    ///  EddyInstance is the Instance ID for the Eddystone-UID Beacon.
    ///  </summary>
    property EddyInstance: string read GetEddyInstance write SetEddyInstance;
    ///  <summary>
    ///  IDManufacturer is a unique numeric identifier for each Bluetooth SIG member company requesting one.
    ///  These are assigned by the Bluetooth SIG. Currently used in the manufacturer specific data (AdvertiseData) packet.
    ///  </summary>
    property IDManufacturer: string read GetManufacturerID write SetManufacturerID;
  end;

  ///  <summary>
  ///  TBeaconRegionCollection is a collection holding a list of beacon regions
  ///  </summary>
  TBeaconRegionCollection = class(TOwnedCollection)
  private
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TBeaconRegionItem;
    procedure SetItem(Index: Integer; const Value: TBeaconRegionItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    ///  <summary>
    ///  Items is the property to access created beacon region items.
    ///  </summary>
    property Items[Index: Integer]: TBeaconRegionItem read GetItem write SetItem; default;
    ///  <summary>
    ///  OnChangeEvent is fired each time a item changes.
    ///  </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  ///  <summary>
  ///  Beacon component is used to monitorize a list of beacon regions, getting events indicating when we enter/exit
  ///  from a region or beacon, and changes on the proximity of a beacon.
  ///  </summary>
  TCustomBeacon = class(TComponent)
  const
    EDDY_UID_INSTANCE_ALL = '-1';
  private
    FBeaconManager: TBeaconManager;
    FEnabled: Boolean;
    FOnBeaconEnter: TBeaconEnterExitEvent;
    FOnCalcDistance: TBeaconCalcDistanceEvent;
    FOnCalculateDistances: TBeaconsCalcDistancesEvent;
    FOnBeaconProximity: TBeaconProximityEvent;
    FOnBeaconExit: TBeaconEnterExitEvent;
    FOnEnterRegion: TBeaconRegionEvent;
    FOnBeaconsEnterRegion: TBeaconsRegionEvent;
    FMonitorizedRegions: TBeaconRegionCollection;
    FOldMonitorizedRegions: TBeaconRegionCollection;
    FOnExitRegion: TBeaconRegionEvent;
    FOnBeaconsExitRegion: TBeaconsRegionEvent;
    FOnParseManufacturerData: TParseManufacturerDataEvent;
    FOnParseServiceData: TParseServiceDataEvent;
    FOnNewBLEScanFilter: TNewBLEScanFilterEvent;
    FOnBeaconEddystoneURL: TBeaconEddystoneURLEvent;
    FOnBeaconEddystoneTLM: TBeaconEddystoneTLMEvent;
    FOnBeaconError: TBeaconErrorEvent;
    FLock: TObject;
    FMode: TBeaconScanMode;
    FKindofBeacons: TKindofBeacons;
    FCurrentList: TBeaconList;
    FBeaconDeathTime: integer;
    FScanningTime: integer;
    FScanningSleepingTime: integer;
    FSPC: Single;
    FCalcMode: TBeaconCalcMode;
    procedure SetEnabled(const Value: Boolean);
    procedure SetMonitorizedRegions(const Value: TBeaconRegionCollection);
    procedure OnListChange(Sender: TObject);
    procedure CheckEvents;
    procedure SetMode(const Value: TBeaconScanMode);
    procedure SetKindofBeacons(const Value: TKindofBeacons);
    procedure DoBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure DoBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure DoParseManufacturerData(const Sender:TObject; const AData: TManufacturerRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
    procedure DoParseServiceData(const Sender: TObject; const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
    procedure DoNewEddystoneURL(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
    procedure DoNewEddystoneTLM(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
    procedure DoBeaconCalcDistance(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Word; ATxPower, ARssi: Integer;
      var NewDistance: Double); overload;
    procedure DoBeaconCalcDistance(const Sender: TObject; const ABeacon: IBeacon; ATxPower, ARssi: Integer;
      var NewDistance: Double); overload;
    procedure DoBeaconChangedProximity(const Sender: TObject; const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
    procedure DoRegionEnter(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
    procedure DoBeaconsRegionEnter(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
    procedure DoRegionExit(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
    procedure DoBeaconsRegionExit(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
    procedure DoNewBLEScanFilter(const Sender: TObject; AKindofScanFilter: TKindofScanFilter;
      const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
    procedure DoBeaconError(const Sender: TObject; ABeaconError: TBeaconError;
      const AMsg: string; const ABeacon: TBeaconInfo);
    procedure SaveBeaconList(const CurrentBeaconList: TBeaconList);
    function GetBeaconList: TBeaconList;
    procedure SetBeaconDeathTime(const Value: integer);
    procedure SetScanningSleepingTime(const Value: integer);
    procedure SetScanningTime(const Value: integer);
    procedure SetSPC(const Value: Single);
    function GetCalcMode: TBeaconCalcMode;
    procedure SetCalcMode(const Value: TBeaconCalcMode);
  protected
    procedure Loaded; override;
  public
    ///  <summary>
    ///  Creates a new instance of the component
    ///  </summary>
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    ///  <summary>
    ///  StartScan starts to monitorize beacons in the regions indicated in Monitorized regions.
    ///  </summary>
    procedure StartScan;
    ///  <summary>
    ///  StopScan stops to monitorize beacons.
    ///  </summary>
    procedure StopScan;
    /// <summary>
    ///  Returns the nearest beacon to our position, nil if we don't have
    /// </summary>
    function Nearest: IBeacon;
    ///  <summary>
    ///  BeaconList grants access to a list of currently detected beacons
    ///  </summary>
    property BeaconList: TBeaconList read GetBeaconList;
    ///  <summary>
    ///  Enabled property, when true, the component starts to scan regions automatically
    ///  </summary>
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    ///  <summary>
    ///  Mode indicates which kind of beacons are going to be monitorized
    ///  TBeaconScanMode.Standard is the default
    ///  </summary>
    property Mode: TBeaconScanMode read FMode write SetMode default TBeaconScanMode.Extended;
    ///  <summary>
    ///  KindofBeacons indicates which kind of beacons are going to be monitorized
    ///  if we choose extended as a Mode. All kind of beacons together are the default.
    ///  </summary>
    property ModeExtended: TKindofBeacons read FKindofBeacons write SetKindofBeacons;
    ///  <summary>
    ///  MonitorizedRegions is the list of regions to be monitorized.
    ///  </summary>
    property MonitorizedRegions: TBeaconRegionCollection read FMonitorizedRegions write SetMonitorizedRegions;
    /// <summary>
    ///  Indicates the time in ms to consider that the beacon signal has been lost
    /// </summary>
    property BeaconDeathTime: integer read FBeaconDeathTime write SetBeaconDeathTime default KBEACONDEATHTIME;
    /// <summary>
    ///  Signal propagation constant value used to calculate the distance
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property SPC: Single read FSPC write SetSPC;
    /// <summary>
    ///  Time that we are going to scan each cicle in ms.
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property ScanningTime: integer read FScanningTime write SetScanningTime default SCANNING_TIME;
    /// <summary>
    ///  Paused time between scan cicles.
    ///  This value is ignored in iOS Standard mode.
    /// </summary>
    property ScanningSleepingTime: integer read FScanningSleepingTime write SetScanningSleepingTime default SCANNING_SLEEPINGTIME;
    /// <summary>
    ///  Indicates the current beacon type used to provide Rssi and distance values.
    ///  By default we are working in Stabilized mode.
    /// </summary>
    property CalcMode: TBeaconCalcMode read GetCalcMode write SetCalcMode default TBeaconCalcMode.Stabilized;
    ///  <summary>
    ///  OnBeaconEnter is fired each time a Beacon is reachable, this means that there is a new beacon on our list
    ///  </summary>
    property OnBeaconEnter: TBeaconEnterExitEvent read FOnBeaconEnter write FOnBeaconEnter;
    ///  <summary>
    ///  OnBeaconExit is fired each time a Beacon is not reachable.
    ///  </summary>
    property OnBeaconExit: TBeaconEnterExitEvent read FOnBeaconExit write FOnBeaconExit;
    ///  <summary>
    ///  OnBeaconProximity is fired when a beacon proximity value changes
    ///  </summary>
    property OnBeaconProximity: TBeaconProximityEvent read FOnBeaconProximity write FOnBeaconProximity;
    ///  <summary>
    ///  OnEnterRegion is fired first time a beacon from a region is reachable.
    ///  </summary>
    property OnEnterRegion: TBeaconRegionEvent read FOnEnterRegion write FOnEnterRegion;
    ///  <summary>
    ///  OnBeaconsEnterRegion is fired first time a beacon from a region is reachable.
    ///  </summary>
    property OnBeaconsEnterRegion: TBeaconsRegionEvent read FOnBeaconsEnterRegion write FOnBeaconsEnterRegion;
    ///  <summary>
    ///  OnExitRegion is fired when all beacons for a region are out of reach.
    ///  </summary>
    property OnExitRegion: TBeaconRegionEvent read FOnExitRegion write FOnExitRegion;
    ///  <summary>
    ///  OnBeaconsExitRegion is fired when all beacons for a region are out of reach.
    ///  </summary>
    property OnBeaconsExitRegion: TBeaconsRegionEvent read FOnBeaconsExitRegion write FOnBeaconsExitRegion;
    ///  <summary>
    ///  OnCalcDistance is fired when we are about to calculate the distance to a beacon. You can use it to provide
    ///  your own algorithm to calculate the distance.
    ///  </summary>
    property OnCalcDistance: TBeaconCalcDistanceEvent read FOnCalcDistance write FOnCalcDistance;
    ///  <summary>
    ///  OnCalculateDistances is fired when we are about to calculate the distance to a any kind beacon. You can use it to provide
    ///  your own algorithm to calculate the distance.
    ///  </summary>
    property OnCalculateDistances: TBeaconsCalcDistancesEvent read FOnCalculateDistances write FOnCalculateDistances;
    ///  <summary>
    ///  Allows to add your own parser to get the information from manufacturer data section inside the
    ///  device advertise data.
    ///  </summary>
    property OnParseManufacturerData: TParseManufacturerDataEvent read FOnParseManufacturerData write FOnParseManufacturerData;
    ///  <summary>
    ///  Allows to add your own parser to get the information from service data section inside the
    ///  device advertise data.
    ///  </summary>
    property OnParseServiceData: TParseServiceDataEvent read FOnParseServiceData write FOnParseServiceData;
    ///  <summary>
    ///  This event is fired every time a new scan filter is created and befor being added to FilterList wich will be past to
    ///  the BLE scanner. So to check the filter builded and change it if needed.
    ///  </summary>
    property OnNewBLEScanFilter: TNewBLEScanFilterEvent read FOnNewBLEScanFilter write FOnNewBLEScanFilter;
    ///  <summary>
    ///  OnNewEddystoneURL is fired each time a New Eddystone-URL is found.
    ///  It needs to be assigned to work, so if not assigned no Eddystone-URL will be add to the Beacon List.
    ///  </summary>
    property OnNewEddystoneURL: TBeaconEddystoneURLEvent read FOnBeaconEddystoneURL write FOnBeaconEddystoneURL;
    ///  <summary>
    ///  OnNewEddystoneTLM is fired each time a New Eddystone-TLM is found.
    ///  </summary>
    property OnNewEddystoneTLM: TBeaconEddystoneTLMEvent read FOnBeaconEddystoneTLM write FOnBeaconEddystoneTLM;
    ///  <summary>
    ///  OnBeaconError is fired each time we detect an error inside a beacon
    ///  </summary>
    property OnBeaconError: TBeaconErrorEvent read FOnBeaconError write FOnBeaconError;
  end;

  ///  <summary>
  ///  Beacon component is used to monitorize a list of beacon regions, getting events indicating when we enter/exit
  ///  from a region or beacon, and changes on the proximity of a beacon.
  ///  </summary>
  TBeacon = class(TCustomBeacon)
  published
    property Enabled;
    property Mode;
    property ModeExtended;
    property MonitorizedRegions;
    property BeaconDeathTime;
    property SPC;
    property ScanningTime;
    property ScanningSleepingTime;
    property CalcMode;
    property OnBeaconEnter;
    property OnBeaconExit;
    property OnBeaconProximity;
    property OnEnterRegion;
    property OnExitRegion;
    property OnBeaconsEnterRegion;
    property OnBeaconsExitRegion;
    property OnCalcDistance;
    property OnCalculateDistances;
    property OnParseManufacturerData;
    property OnParseServiceData;
    property OnNewBLEScanFilter;
    property OnNewEddystoneURL;
    property OnNewEddystoneTLM;
    property OnBeaconError;
  end;

  /// <summary>
  ///  Beacon Device Mode indicates which kind of beacon is going to be advertised.
  /// </summary>
  TBeaconDeviceMode = (Standard, Alternative, EddystoneUID, EddystoneURL);

  TCustomBeaconDevice = class(TComponent)
  private
    FBeaconAdvertiser: TBeaconAdvertiser;
    FEnabled: Boolean;
    FBeaconDeviceMode: TBeaconDeviceMode;
    FManufacturerId: Word;
    FBeaconType: Word;
    FGUID: TGUID;
    FMinor: Integer;
    FMajor: Integer;
    FTxPower: ShortInt;
    FMFGReserved: Byte;
    FEddystoneNamespace: string;
    FEddystoneInstance: string;
    FEddystoneURL: string;
    FDeviceType: TAdvertiseDeviceFormat;
    FNamespaceGenerator: TNamespaceGeneratorMethod;
    procedure SetEnabled(const Value: Boolean);
    procedure SetMID(const Value: string);
    function GetMID: string;
    procedure SetType(const Value: TBeaconDeviceMode);
    function GetType: TBeaconDeviceMode;
    procedure SetGUID(const Value: TGUID);
    procedure SetMajor(const Value: Integer);
    procedure SetMinor(const Value: Integer);
    procedure SetUUID(const Value: string);
    function GetUUID: string;
    procedure SetTxPower(const Value: ShortInt);
    procedure SetMFGReserved(const Value: Byte);
    function GetMFGReserved: Byte;
  protected
    ///  <summary> Method called after component is loaded </summary>
    procedure Loaded; override;
  public
    ///  <summary>
    ///  Creates a new instance of the component
    ///  </summary>
    constructor Create(AOwner: TComponent); override;
    ///  <summary>
    ///  Initializes this Beacon device with an existing GattServer
    ///  </summary>
    procedure InitWithGattServer(AGattServer: TBluetoothGattServer);
    ///  <summary>
    ///  Starts to asdvertise proximity data
    ///  </summary>
    procedure StartAdvertise;
    ///  <summary>
    ///  Stops asdvertising proximity data
    ///  </summary>
    procedure StopAdvertise;
    ///  <summary>
    ///  Enabled property, when true, the component starts advertise proximity data
    ///  </summary>
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    ///  <summary>
    ///  Manufacturer Id
    ///  </summary>
    property ManufacturerId: string read GetMID write SetMID;
    ///  <summary>
    ///  Beacon type
    ///  </summary>
    property BeaconType: TBeaconDeviceMode read GetType write SetType default TBeaconDeviceMode.Standard;
    ///  <summary>
    ///  GUID representing this beacon proximity UUID
    ///  </summary>
    property GUID: TGUID read FGUID write SetGUID;
    ///  <summary>
    ///  UUID is a GUID representing this beacon proximity UUID
    ///  </summary>
    property UUID: string read GetUUID write SetUUID;
    ///  <summary>
    ///  Major number for the region that this beacon is advertising
    ///  </summary>
    property Major: Integer read FMajor write SetMajor default 0;
    ///  <summary>
    ///  Minor number for the region that this beacon is advertising
    ///  </summary>
    property Minor: Integer read FMinor write SetMinor default 0;
    ///  <summary>
    ///  TxPower that this beacon is advertising
    ///  </summary>
    property TxPower: ShortInt read FTxPower write SetTxPower default TXPOWER_IDETERMINATED;
    ///  <summary>
    ///  Just for AltBeacon, reserved for use by the manufacturer to implement special features.
    ///  </summary>
    property MFGReserved: Byte read GetMFGReserved write SetMFGReserved default 0;
	/// <summary>
    /// Namespace for the Eddystone-UID frame. It must be a string of 20 hexadecimal digits when NamespaceGenerator is set to ngNone
    /// </summary>
    property EddystoneNamespace: string read FEddystoneNamespace write FEddystoneNamespace;
    /// <summary>
    /// Instance for the Eddystone-UID frame. It must be a string of 12 hexadecimal digits representing 6 bytes
    /// </summary>
    property EddystoneInstance: string read FEddystoneInstance write FEddystoneInstance;
    /// <summary>
    /// URL broadcasted by the Eddystone-URL frame.
    /// </summary>
    property EddystoneURL: string read FEddystoneURL write FEddystoneURL;
    /// <summary> Method used to generate the Eddystone-UID namespace:
    ///  <para>� ngNone indicates that EddystoneNamespace property will be used as a 20 hex digits string representing the 10-bytes namespace value </para>
    ///  <para>� ngHashFQDN takes the first 10 bytes of an SHA-1 hash of the domain name specified in EddystoneNamespace </para>
    ///  <para>� ngElidedUUID uses GUID property removing bytes 5 - 10 (inclusive) to generate 10-bytes namespace </para>
    /// </summary>
    property NamespaceGenerator: TNamespaceGeneratorMethod read FNamespaceGenerator write FNamespaceGenerator default ngHashFQDN;
  end;

  TBeaconDevice = class(TCustomBeaconDevice)
  published
    ///  <summary>
    ///  Enabled property, when true, the component starts advertise proximity data
    ///  </summary>
    property Enabled;
    ///  <summary>
    ///  Manufacturer Id
    ///  </summary>
    property ManufacturerId;
    ///  <summary>
    ///  Beacon type
    ///  </summary>
    property BeaconType;
    ///  <summary>
    ///  UUID is a GUID representing this beacon proximity UUID
    ///  </summary>
    property UUID;
    ///  <summary>
    ///  Major number for the region that this beacon is advertising
    ///  </summary>
    property Major;
    ///  <summary>
    ///  Minor number for the region that this beacon is advertising
    ///  </summary>
    property Minor;
    ///  <summary>
    ///  TxPower that this beacon is advertising
    ///  </summary>
    property TxPower;
    ///  <summary>
    ///  Just for AltBeacon, reserved for use by the manufacturer to implement special features.
    ///  </summary>
    property MFGReserved;
        /// <summary>
    /// Namespace for the Eddystone-UID frame. It must be a string of 20 hexadecimal digits when NamespaceGenerator is set to ngNone
    /// </summary>
    property EddystoneNamespace;
    /// <summary>
    /// Instance for the Eddystone-UID frame. It must be a string of 12 hexadecimal digits representing 6 bytes
    /// </summary>
    property EddystoneInstance;
    /// <summary>
    /// URL broadcasted by the Eddystone-URL frame.
    /// </summary>
    property EddystoneURL;
    /// <summary> Method used to generate the Eddystone-UID namespace:
    ///  <para>� ngNone indicates that EddystoneNamespace property will be used as a 20 hex digits string representing the 10-bytes namespace value </para>
    ///  <para>� ngHashFQDN takes the first 10 bytes of an SHA-1 hash of the domain name specified in EddystoneNamespace </para>
    ///  <para>� ngElidedUUID uses GUID property removing bytes 5 - 10 (inclusive) to generate 10-bytes namespace </para>
    /// </summary>
    property NamespaceGenerator;

  end;


implementation

{ TBeacon }

constructor TCustomBeacon.Create(AOwner: TComponent);
begin
  inherited;
  FLock := TObject.Create;
  FMode := TBeaconScanMode.Extended;
  FKindofBeacons := [TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.Eddystones];
  FCalcMode := TBeaconCalcMode.Stabilized;
  if not (csDesigning in ComponentState) then
  begin
    FBeaconManager := TBeaconManager.GetBeaconManager(FMode);
    FBeaconManager.KindofBeacons := FKindofBeacons;
    CheckEvents;
    TBluetoothLEManager.Current.EnableBluetooth;
  end;
  FOldMonitorizedRegions := TBeaconRegionCollection.Create(Self, TBeaconRegionItem);
  FMonitorizedRegions := TBeaconRegionCollection.Create(Self, TBeaconRegionItem);
  FMonitorizedRegions.OnChange := OnListChange;
  FBeaconDeathTime := KBEACONDEATHTIME;
  FSPC := SIGNAL_PROPAGATION_CONSTANT;
  FScanningTime := SCANNING_TIME;
  FScanningSleepingTime := SCANNING_SLEEPINGTIME;
end;

destructor TCustomBeacon.Destroy;
begin
  FBeaconManager.Free;
  FMonitorizedRegions.Free;
  FOldMonitorizedRegions.Free;
  inherited;
end;

procedure TCustomBeacon.SaveBeaconList(const CurrentBeaconList: TBeaconList);
begin
  TMonitor.Enter(FLock);
  try
    FCurrentList := CurrentBeaconList;
  finally
    TMonitor.Exit(FLock);
  end;
end;

procedure TCustomBeacon.DoBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  SaveBeaconList(CurrentBeaconList);
  if Assigned(FOnBeaconEnter) then
  begin
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnBeaconEnter) then
          FOnBeaconEnter(Self, ABeacon, CurrentBeaconList);
      end);
  end;
end;

procedure TCustomBeacon.DoBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  SaveBeaconList(CurrentBeaconList);
  if Assigned(FOnBeaconExit) then
    TThread.Synchronize(nil, procedure
    begin
      if Assigned(FOnBeaconExit) then
        FOnBeaconExit(Sender, ABeacon, CurrentBeaconList);
    end);
end;

procedure TCustomBeacon.DoParseManufacturerData(const Sender:TObject; const AData: TManufacturerRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  if Assigned(FOnParseManufacturerData) then
    FOnParseManufacturerData(Self, AData, BeaconInfo, Handled);
end;

procedure TCustomBeacon.DoParseServiceData(const Sender: TObject; const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  if Assigned(FOnParseServiceData) then
    FOnParseServiceData(Self, AData, BeaconInfo, Handled);
end;

procedure TCustomBeacon.DoNewEddystoneURL(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
var
  LEddystoneURL: TEddystoneURL;
begin
  LEddystoneURL := AEddystoneURL;
  if Assigned(FOnBeaconEddystoneURL) then
    TThread.Synchronize(nil, procedure
    begin
      if Assigned(FOnBeaconEddystoneURL) then
        FOnBeaconEddystoneURL(Self, ABeacon, LEddystoneURL);
    end);
end;

procedure TCustomBeacon.DoNewEddystoneTLM(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
var
  LEddystoneTLM: TEddystoneTLM;
begin
  LEddystoneTLM := AEddystoneTLM;
  if Assigned(FOnBeaconEddystoneTLM) then
    TThread.Synchronize(nil, procedure
    begin
      if Assigned(FOnBeaconEddystoneTLM) then
        FOnBeaconEddystoneTLM(Self, ABeacon, LEddystoneTLM);
    end);
end;

procedure TCustomBeacon.DoBeaconCalcDistance(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Word; ATxPower, ARssi: Integer;
  var NewDistance: Double);
begin
  if Assigned(FOnCalcDistance) then
    FOnCalcDistance(Self, UUID, AMajor, AMinor, ATxPower, ARssi, NewDistance);
end;

procedure TCustomBeacon.DoBeaconCalcDistance(const Sender: TObject; const ABeacon: IBeacon; ATxPower, ARssi: Integer;
  var NewDistance: Double);
begin
  if Assigned(FOnCalculateDistances) then
    FOnCalculateDistances(Self, ABeacon, ATxPower, ARssi, NewDistance);
end;

procedure TCustomBeacon.DoBeaconChangedProximity(const Sender: TObject; const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
begin
  if Assigned(FOnBeaconProximity) then
  begin
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnBeaconProximity) then
          FOnBeaconProximity(Self, ABeacon, CurrentProximity);
      end);
  end;
end;

procedure TCustomBeacon.DoRegionEnter(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
var
  LUUID: TGUID;
begin
  if Assigned(FOnEnterRegion) then
  begin
    LUUID := UUID;
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnEnterRegion) then
          FOnEnterRegion(Self, LUUID, AMajor, AMinor);
      end);
  end;
end;

procedure TCustomBeacon.DoBeaconsRegionEnter(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
var
  LBeaconRegion: TBeaconsRegion;
begin
  if Assigned(FOnBeaconsEnterRegion) then
  begin
    LBeaconRegion := ABeaconRegion;
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnBeaconsEnterRegion) then
          FOnBeaconsEnterRegion(Self, LBeaconRegion);
      end);
  end;
end;

procedure TCustomBeacon.DoRegionExit(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
var
  LUUID: TGUID;
begin
  if Assigned(FOnExitRegion) then
  begin
    LUUID := UUID;
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnExitRegion) then
          FOnExitRegion(Self, LUUID, AMajor, AMinor);
      end);
  end;
end;

procedure TCustomBeacon.DoBeaconsRegionExit(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
var
  LBeaconRegion: TBeaconsRegion;
begin
  if Assigned(FOnBeaconsExitRegion) then
  begin
    LBeaconRegion := ABeaconRegion;
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnBeaconsExitRegion) then
          FOnBeaconsExitRegion(Self, LBeaconRegion);
      end);
  end;
end;

procedure TCustomBeacon.DoNewBLEScanFilter(const Sender: TObject; AKindofScanFilter: TKindofScanFilter;
    const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
begin
  if Assigned(FOnNewBLEScanFilter) then
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnNewBLEScanFilter) then
          FOnNewBLEScanFilter(Self, AKindofScanFilter, ABluetoothLEScanFilter);
      end);
end;

procedure TCustomBeacon.DoBeaconError(const Sender: TObject; ABeaconError: TBeaconError;
  const AMsg: string; const ABeacon: TBeaconInfo);
var
  LBeacon: TBeaconInfo;
begin
  if Assigned(FOnBeaconError) then
  begin
    LBeacon := ABeacon;
    TThread.Synchronize(nil, procedure
      begin
        if Assigned(FOnBeaconError) then
          FOnBeaconError(Self, ABeaconError, AMsg, LBeacon);
      end);
  end;
end;

function TCustomBeacon.GetBeaconList: TBeaconList;
begin
  if Enabled then
  begin
    TMonitor.Enter(FLock);
    try
      Result := FCurrentList;
    finally
      TMonitor.Exit(FLock);
    end;
  end
  else
    Result := nil;
end;

function TCustomBeacon.GetCalcMode: TBeaconCalcMode;
begin
  Result := FCalcMode;
end;

procedure TCustomBeacon.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    StartScan;
end;

function TCustomBeacon.Nearest: IBeacon;
begin
  if Enabled then
    Result := FBeaconManager.Nearest
  else
    Result := nil;
end;

procedure TCustomBeacon.OnListChange(Sender: TObject);
var
  I: Integer;
  LBeaconsRegion: TBeaconsRegion;
begin
  if not (csDesigning in ComponentState) then
    for I := 0 to FOldMonitorizedRegions.Count - 1 do
    begin
     LBeaconsRegion := Default(TBeaconsRegion);
     LBeaconsRegion.KindofBeacon := FOldMonitorizedRegions[I].KindofBeacon;
     case LBeaconsRegion.KindofBeacon of
       TKindofBeacon.Eddystones:
       begin
         if (FOldMonitorizedRegions[I].FEddyStInstance = EDDY_UID_INSTANCE_ALL) then
           LBeaconsRegion.EddysUIDRegion.Initialize(FOldMonitorizedRegions[I].FEddyUID.Namespace)
         else
           LBeaconsRegion.EddysUIDRegion.Initialize(FOldMonitorizedRegions[I].FEddyUID.Namespace,
             FOldMonitorizedRegions[I].FEddyUID.Instance);
       end;
       TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
       begin
         LBeaconsRegion.iBAltBeaconRegion.Initialize(FOldMonitorizedRegions[I].GUID, FOldMonitorizedRegions[I].Major,
           FOldMonitorizedRegions[I].Minor, FOldMonitorizedRegions[I].KindofBeacon, MANUFATURER_ID_ALL);
       end;
     end;
     FBeaconManager.UnRegisterBeacons(LBeaconsRegion);
    end;

  FOldMonitorizedRegions.Clear;
  FOldMonitorizedRegions.Assign(FMonitorizedRegions);

  if not (csDesigning in ComponentState) then
  begin
    for I := 0 to FMonitorizedRegions.Count - 1 do
    begin
      LBeaconsRegion := Default(TBeaconsRegion);
      LBeaconsRegion.KindofBeacon := FMonitorizedRegions[I].KindofBeacon;

      case LBeaconsRegion.KindofBeacon of
        TKindofBeacon.Eddystones:
        begin
          if (FMonitorizedRegions[I].FEddyStInstance = EDDY_UID_INSTANCE_ALL) then
            LBeaconsRegion.EddysUIDRegion.Initialize(FMonitorizedRegions[I].FEddyUID.Namespace)
          else
            LBeaconsRegion.EddysUIDRegion.Initialize(FMonitorizedRegions[I].FEddyUID.Namespace,
            FMonitorizedRegions[I].FEddyUID.Instance);
        end;
        TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
        begin
          LBeaconsRegion.iBAltBeaconRegion.Initialize(FMonitorizedRegions[I].GUID, FMonitorizedRegions[I].Major,
            FMonitorizedRegions[I].Minor, FMonitorizedRegions[I].KindofBeacon, FMonitorizedRegions[I].ManufacturerIdToInt);
        end;
      end;
      FBeaconManager.RegisterBeacons(LBeaconsRegion);
    end;
    if FBeaconManager.NumberofBeaconsRegistered = 0 then
      StopScan;
  end;
end;

procedure TCustomBeacon.SetBeaconDeathTime(const Value: integer);
begin
  FBeaconDeathTime := Value;
  if not (csDesigning in ComponentState) then
    FBeaconManager.BeaconDeathTime := FBeaconDeathTime;
end;

procedure TCustomBeacon.SetCalcMode(const Value: TBeaconCalcMode);
begin
  FCalcMode := Value;
end;

procedure TCustomBeacon.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
      if Enabled then
        StartScan
      else
        StopScan;
  end;
end;

procedure TCustomBeacon.SetMode(const Value: TBeaconScanMode);
begin
  if FMode <> Value then
  begin
    FMode := Value;
    if not (csDesigning in ComponentState) then
    begin
      if FBeaconManager <> nil then
      begin
        FBeaconManager.StopScan;
        FBeaconManager.Free;
      end;
      SaveBeaconList(nil);
      FBeaconManager := TBeaconManager.GetBeaconManager(FMode);
      FBeaconManager.KindofBeacons := FKindofBeacons;
      if not (csLoading in ComponentState) then
        FEnabled := False;
    end;
  end;
end;

procedure TCustomBeacon.SetKindofBeacons(const Value: TKindofBeacons);
begin
  if FKindofBeacons <> Value then
  begin
    FKindofBeacons := Value;
    if not (csDesigning in ComponentState) and (FMode = TBeaconScanMode.Extended) then
    begin
      if FBeaconManager <> nil then
      begin
        FBeaconManager.StopScan;
        FBeaconManager.Free;
        SaveBeaconList(nil);
        FBeaconManager := TBeaconManager.GetBeaconManager(FMode);
        FBeaconManager.KindofBeacons := FKindofBeacons;
        FKindofBeacons:= FBeaconManager.KindofBeacons;
        if not (csLoading in ComponentState) then
          FEnabled := False;
      end;
    end
    else
      if TKindofBeacon.iBAltBeacons in FKindofBeacons then
      begin
        Exclude(FKindofBeacons, TKindofBeacon.iBAltBeacons);
        FKindofBeacons := FKindofBeacons + [TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons];
      end;
  end;
end;


procedure TCustomBeacon.SetMonitorizedRegions(const Value: TBeaconRegionCollection);
begin
  if FMonitorizedRegions <> Value then
    FMonitorizedRegions.Assign(Value);
end;

procedure TCustomBeacon.SetScanningSleepingTime(const Value: integer);
begin
  FScanningSleepingTime := Value;
  if not (csDesigning in ComponentState) then
    FBeaconManager.ScanningSleepingTime := FScanningSleepingTime;
end;

procedure TCustomBeacon.SetScanningTime(const Value: integer);
begin
  FScanningTime := Value;
  if not (csDesigning in ComponentState) then
    FBeaconManager.ScanningTime := FScanningTime;
end;

procedure TCustomBeacon.SetSPC(const Value: Single);
begin
  FSPC := Value;
  if not (csDesigning in ComponentState) then
    FBeaconManager.SPC := FSPC;
end;

procedure TCustomBeacon.StartScan;
begin
  if Enabled and (TBluetoothLEManager.Current.CurrentAdapter <> nil) then
  begin
    OnListChange(Self);
    CheckEvents;
    FBeaconManager.CalcMode := FCalcMode;
    FBeaconManager.StartScan;
  end;
end;

procedure TCustomBeacon.StopScan;
begin
  FBeaconManager.StopScan;
end;

procedure TCustomBeacon.CheckEvents;
begin
  FBeaconManager.OnBeaconEnter := DoBeaconEnter;
  FBeaconManager.OnBeaconExit := DoBeaconExit;
  if Assigned(FOnBeaconProximity) then
    FBeaconManager.OnBeaconProximity := DoBeaconChangedProximity
  else
    FBeaconManager.OnBeaconProximity := nil;

  FBeaconManager.OnEnterRegion := DoRegionEnter;
  FBeaconManager.OnBeaconsEnterRegion := DoBeaconsRegionEnter;
  FBeaconManager.OnExitRegion := DoRegionExit;
  FBeaconManager.OnBeaconsExitRegion := DoBeaconsRegionExit;
  FBeaconManager.OnNewBLEScanFilterEvent := DoNewBLEScanFilter;
  FBeaconManager.OnBeaconError := DoBeaconError;

  if Assigned(FOnCalculateDistances) then
    FBeaconManager.OnCalculateDistances := DoBeaconCalcDistance
  else
  begin
    FBeaconManager.OnCalculateDistances := nil;
    if Assigned(FOnCalcDistance) then
      FBeaconManager.OnCalcDistance := DoBeaconCalcDistance
    else
      FBeaconManager.OnCalcDistance := nil;
  end;

  if assigned(FOnParseServiceData) then
    FBeaconManager.OnParseServiceData := DoParseServiceData
  else
    FBeaconManager.OnParseServiceData := nil;

  if Assigned(FOnParseManufacturerData) then
    FBeaconManager.OnParseManufacturerData := DoParseManufacturerData
  else
    FBeaconManager.OnParseManufacturerData := nil;

  FBeaconManager.OnNewEddystoneTLM := DoNewEddystoneTLM;
  FBeaconManager.OnNewEddystoneURL := DoNewEddystoneURL
end;

{ TBeaconRegionItem }

procedure TBeaconRegionItem.Assign(Source: TPersistent);
begin
  if Source is TBeaconRegionItem then
  begin
    KindofBeacon := TBeaconRegionItem(Source).KindofBeacon;
    case KindofBeacon of
      TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons , TKindofBeacon.iBAltBeacons:
        begin
          FMinor := TBeaconRegionItem(Source).Minor;
          FMajor := TBeaconRegionItem(Source).Major;
          FGUID := TBeaconRegionItem(Source).FGUID;
          FManufacturerId := TBeaconRegionItem(Source).FManufacturerID;
        end;
      TKindofBeacon.Eddystones:
        begin
          FEddyUID.Namespace := TBeaconRegionItem(Source).FEddyUID.Namespace;
          FEddyUID.Instance := TBeaconRegionItem(Source).FEddyUID.Instance;
          FEddyStInstance := TBeaconRegionItem(Source).FEddyStInstance;
        end;
    end;
  end
  else
    inherited;
end;

constructor TBeaconRegionItem.Create(Collection: TCollection);
const
  EDDY_INSTANCE_MASK: TInstance = ($0,$0,$0,$0,$0,$0);
  EDDY_NAMESPACE_MASK: TNamespace = ($0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
begin
  inherited;
  FMinor := MINOR_REGION_ALL;
  FMajor := MAJOR_REGION_ALL;
  FKindofBeacon := TKindofBeacon.iBAltBeacons;
  FEddyUID.Namespace := EDDY_NAMESPACE_MASK;
  FEddyUID.Instance := EDDY_INSTANCE_MASK;
  FEddyStInstance := TCustomBeacon.EDDY_UID_INSTANCE_ALL;
  FManufacturerId := Integer(MANUFATURER_ID_ALL);
end;

function TBeaconRegionItem.GetEddyNamespace: string;
begin
  Result := FEddyUID.NamespaceToString;
end;

procedure TBeaconRegionItem.SetEddyNamespace(const AValue: string);
begin
  if FKindofBeacon = TKindofBeacon.Eddystones then
    if FEddyUID.SetNamespace(AValue) then
      Changed(False)
    else
      raise EBeaconComponentException.Create(SBeaconIncorrectEddyNamespace);
end;

function TBeaconRegionItem.GetEddyInstance: string;
begin
  Result := FEddyUID.InstanceToString;
end;

procedure TBeaconRegionItem.SetEddyInstance(const AValue: string);
begin
  if FKindofBeacon = TKindofBeacon.Eddystones then
    if AValue = TCustomBeacon.EDDY_UID_INSTANCE_ALL then
      FEddyStInstance := TCustomBeacon.EDDY_UID_INSTANCE_ALL
    else
      if FEddyUID.SetInstance(AValue) then
      begin
        FEddyStInstance := GetEddyInstance;
        Changed(False);
      end
      else
        raise EBeaconComponentException.Create(SBeaconIncorrectEddyInstance);
end;

function TBeaconRegionItem.GetUUID: string;
begin
  Result := FGUID.ToString;
end;

procedure TBeaconRegionItem.SetGUID(const AValue: TGUID);
begin
  FGUID := AValue;
  Changed(False);
end;

procedure TBeaconRegionItem.SetMajor(AValue: Integer);
begin
  FMajor := AValue;
  Changed(False);
end;

procedure TBeaconRegionItem.SetManufacturerID(const Avalue: string);
var
  LValue: Integer;
begin
  if FKindofBeacon = TKindofBeacon.iBeacons then
    FManufacturerId := APPLEINC
  else
  begin
    try
      if (AValue = MANUFATURER_ID_ALL.ToString) then
        FManufacturerId := MANUFATURER_ID_ALL
      else
      begin
        LValue := StrToInt('$' + AValue);
        if (LValue >= 0) and (LValue <= $FFFF) then
          FManufacturerId := LValue
        else
          raise EBeaconComponentException.Create(SBeaconIncorrectMID);
      end;
    except
      raise EBeaconComponentException.Create(SBeaconIncorrectMID);
    end;
  end;
end;

function TBeaconRegionItem.GetManufacturerID: string;
begin
  if FManufacturerId > MANUFATURER_ID_ALL then
    Result := FManufacturerId.ToHexString(4)
  else
    Result := MANUFATURER_ID_ALL.ToString;
end;

procedure TBeaconRegionItem.SetMinor(AValue: Integer);
begin
  FMinor := AValue;
  Changed(False);
end;

procedure TBeaconRegionItem.SetUUID(const AValue: string);
begin
  try
    GUID := TGUID.Create(AValue);
  except
    on E: Exception do
      raise EBeaconComponentException.Create(E.Message);
  end
end;

{ TBeaconRegionList }

function TBeaconRegionCollection.GetItem(Index: Integer): TBeaconRegionItem;
begin
  Result := TBeaconRegionItem(inherited GetItem(Index));
end;

procedure TBeaconRegionCollection.SetItem(Index: Integer; const Value: TBeaconRegionItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TBeaconRegionCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TCustomBeaconDevice }


constructor TCustomBeaconDevice.Create(AOwner: TComponent);
begin
  inherited;
  FBeaconType := BEACON_ST_TYPE;
  FBeaconDeviceMode := TBeaconDeviceMode.Standard;
  FTxPower := TXPOWER_IDETERMINATED;
  FManufacturerId := APPLEINC;
  FEddystoneNamespace := 'example.com';
  FEddystoneInstance := '000000000001';
  FDeviceType := adBeacon;
  FNamespaceGenerator := ngHashFQDN;
end;

function TCustomBeaconDevice.GetUUID: string;
begin
  Result := FGUID.ToString;
end;

procedure TCustomBeaconDevice.InitWithGattServer(AGattServer: TBluetoothGattServer);
begin
  if FBeaconAdvertiser <> nil then
    FBeaconAdvertiser.Free;
  FBeaconAdvertiser := TBeaconAdvertiser.GetBeaconAdvertiser(AGattServer);
end;

procedure TCustomBeaconDevice.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    StartAdvertise;
end;

procedure TCustomBeaconDevice.SetMFGReserved(const Value: Byte);
begin
  FMFGReserved := Value;
end;

procedure TCustomBeaconDevice.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
      if Value then
        try
          StartAdvertise
        except
          FEnabled := not FEnabled;
          raise;
        end
      else
        StopAdvertise;
  end;
end;

procedure TCustomBeaconDevice.SetGUID(const Value: TGUID);
begin
  FGUID := Value;
end;

procedure TCustomBeaconDevice.SetMajor(const Value: Integer);
begin
  FMajor := Value;
end;

procedure TCustomBeaconDevice.SetMID(const Value: string);
var
  LValue: Integer;
begin
  if not (csLoading in ComponentState) and (GetType = TBeaconDeviceMode.Standard) then
    FManufacturerId := APPLEINC
  else
  begin
    try
      LValue := StrToInt('$'+Value);
      if (LValue >= 0) and (LValue <= $FFFF) then
        FManufacturerId := LValue
      else
        raise EBeaconComponentException.Create(SBeaconIncorrectMID);
    except
      raise EBeaconComponentException.Create(SBeaconIncorrectMID);
    end;
  end;
end;

function TCustomBeaconDevice.GetMFGReserved: Byte;
begin
  Result := FMFGReserved;
end;

function TCustomBeaconDevice.GetMID: string;
begin
  Result := FManufacturerId.ToHexString(4);
end;

procedure TCustomBeaconDevice.SetMinor(const Value: Integer);
begin
  FMinor := Value;
end;

procedure TCustomBeaconDevice.SetTxPower(const Value: ShortInt);
begin
  FTxPower := Value;
end;

procedure TCustomBeaconDevice.SetType(const Value: TBeaconDeviceMode);
begin
  case Value of
  TBeaconDeviceMode.Standard:
  begin
    FBeaconType := BEACON_ST_TYPE;
    FManufacturerId := APPLEINC;
    FDeviceType := TAdvertiseDeviceFormat.adBeacon;
  end;
  TBeaconDeviceMode.Alternative:
  begin
    FBeaconType := BEACON_AL_TYPE;
    FDeviceType := TAdvertiseDeviceFormat.adBeacon;
  end;
  TBeaconDeviceMode.EddystoneUID: FDeviceType := TAdvertiseDeviceFormat.adEddystoneUID;
  TBeaconDeviceMode.EddystoneURL: FDeviceType := TAdvertiseDeviceFormat.adEddystoneURL;
  end;
  FBeaconDeviceMode := Value;
end;

function TCustomBeaconDevice.GetType: TBeaconDeviceMode;
begin
  Result := FBeaconDeviceMode;
end;

procedure TCustomBeaconDevice.SetUUID(const Value: string);
begin
  GUID := TGUID.Create(Value);
end;

procedure TCustomBeaconDevice.StartAdvertise;
begin
  if Enabled and (TBluetoothLEManager.Current.CurrentAdapter <> nil) then
  begin
    if FBeaconAdvertiser = nil then
      FBeaconAdvertiser := TBeaconAdvertiser.GetBeaconAdvertiser(nil);

    FBeaconAdvertiser.GUID := FGUID;
    FBeaconAdvertiser.Major := FMajor;
    FBeaconAdvertiser.Minor := FMinor;
    FBeaconAdvertiser.TxPower := FTxPower;
    FBeaconAdvertiser.ManufacturerId := FManufacturerId;
    FBeaconAdvertiser.BeaconType := FBeaconType;
    FBeaconAdvertiser.MFGReserved := FMFGReserved;
    FBeaconAdvertiser.EddystoneNamespace := FEddystoneNamespace;
    FBeaconAdvertiser.EddystoneInstance := FEddystoneInstance;
    FBeaconAdvertiser.EddystoneURL := FEddystoneURL;
    FBeaconAdvertiser.DeviceType := FDeviceType;
    FBeaconAdvertiser.NamespaceGenerator := FNamespaceGenerator;
    FBeaconAdvertiser.StartAdvertising;
  end;
end;

procedure TCustomBeaconDevice.StopAdvertise;
begin
  if FBeaconAdvertiser <> nil then
    FBeaconAdvertiser.StopAdvertising;
end;

end.
