{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.IOS.Beacon;

interface

uses
  System.Beacon;

type
/// <summary>
///  Implements TBeaconManager for the iOS platform, for the Standard beacon types
/// </summary>
  TPlatformBeaconManager = class(TBeaconManager)
  public
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; override;
  end;

implementation

uses
  iOSapi.CoreLocation, System.iOS.Sensors, iOSapi.Foundation, Macapi.Helpers, Macapi.ObjectiveC, System.NetConsts, System.Bluetooth,
  Macapi.ObjCRuntime, Generics.Collections, System.SysUtils, System.Classes, System.DateUtils, System.Math, System.Beacon.Common;

const
  DistanceMeanItems = 10;
  ProximityMeanItems = 10;

type
  TBeaconErrorCallbabk = procedure(const AError: string) of object;
  TBeaconRegionCallback = procedure(const UUID: TGUID; Major: Integer; Minor : Integer) of object;
  TBeaconRangeCallback = procedure(const ACLBeacon: CLBeacon) of object;
  TAutorizationChangeCallback = procedure(ACode: NativeUInt) of object;

  TBeaconRegion = record
    Inside: Boolean;
    GUID: TGUID;
    Major: Integer;
    Minor: Integer;
    function GetRegion: CLBeaconRegion;
    procedure Initialilize(const AGUID: TGUID; AMajor: Integer; AMinor: Integer); overload;
    function BeaconBelongs(const ABeacon: IBeacon): Boolean; inline;
    function IsRegion(const AGUID: TGUID; AMajor: Integer; AMinor: Integer): Boolean; inline;
  end;

  TiOSBeaconManager = class(TBeaconManager)
  private
    FCoreLocationManager: TBeaconManager;
    FCommonManager: TBeaconManager;
    FCurrentBeaconList: TBeaconList;
  private
     FScanning: Boolean;
     procedure DoiOSBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
     procedure DoiOSBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
     procedure DoiOSBeaconChangedProximity(const Sender: TObject; const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
     procedure DoiOSRegionEnter(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
     procedure DoiOSBeaconsRegionEnter(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
     procedure DoiOSRegionExit(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
     procedure DoiOSBeaconsRegionExit(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
     procedure DoiOSBeaconCalcDistance(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Word;
       ATxPower: Integer; ARssi: Integer; var NewDistance: Double); overload;
     procedure DoiOSBeaconCalcDistance(const Sender: TObject; const ABeacon: IBeacon; ATxPower, ARssi: Integer; var NewDistance: Double); overload;
     procedure DoiOSParseManufacturerData(const Sender: TObject; const AData: TManufacturerRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
     procedure DoiOSParseServiceData(const Sender: TObject; const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
     procedure DoiOSNewEddystoneURL(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
     procedure DoiOSNewEddystoneTLM(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
     procedure DoiOSNewBLEScanFilter(const Sender: TObject; AKindofScanFilter: TKindofScanFilter;
       const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
     procedure CheckEvents;
  protected
    function DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; override;
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; override;
    function DoNearest: IBeacon; override;
    function DoStartScan: Boolean; override;
    function DoStopScan: Boolean; override;
    procedure SetBeaconDeathTime(AValue: Integer); override;
    procedure SetScanningSleepingTime(AValue: Integer); override;
    procedure SetScanningTime(AValue: Integer); override;
    procedure SetSPC(AValue: Single); override;
    procedure SetBeaconType(AValue: Word); override;
    function GetNumberofBeaconsRegistered: Integer; override;
    procedure DoSetKindofBeacons(AValue: TKindofBeacons); override;
    function GeTKindofBeacons: TKindofBeacons; override;
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; override;
  public
    constructor Create(AMode: TBeaconScanMode);
    property IsScanning: Boolean read FScanning;
  end;

  TiOSBeaconManagerCoreLocation = class(TBeaconManager)
  private
    class var DeathTime: Integer;
    class constructor Create;
  private
    FRssiAccumulatedDiff: Single;
    FLockObject: TObject;
    FCurrentBeaconList: TBeaconList;
    FLocationManager: CLLocationManager;
    FLocationDelegate: CLLocationManagerDelegate;
    FRegisteredRegions: TList<TBeaconRegion>;
    FCurrentBeaconCount: Integer;
    function IsMonitoringAvailable: Boolean;
    procedure RemoveBeaconsFromRegion(const ARegion: TBeaconRegion);
    procedure EnterRegion(const UUID: TGUID; Major: Integer; Minor : Integer);
    procedure ExitRegion(const UUID: TGUID; Major: Integer; Minor : Integer);
    procedure RangeBeacon(const ACLBeacon: CLBeacon);
    procedure AutorizationChange(ACode: NativeUInt);
    procedure UnRegisterBeacon(const AGUID: TGUID; Major, Minor: Integer; AKindofBeacon: TKindofBeacon);
    function RegisterBeacon(const AGUID: TGUID; Major: Integer; Minor: Integer; AKindofBeacon: TKindofBeacon): Boolean;
    procedure CheckBeaconListSanity;
    procedure DoEnterExitRegion(RegionIndex: Integer; Enter: Boolean);
    procedure CheckEnterRegion(const ANewBeacon: IBeacon);
    procedure CheckExitRegion(const AExitedBeacon: IBeacon);
    function AddRegionToList(const ARegion: TBeaconRegion): Boolean;
//    procedure SetAllowBackgroundUpdates;
  protected
    function DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; override;
    function DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; override;
    function DoNearest: IBeacon; override;
    function DoStartScan: Boolean; override;
    function DoStopScan: Boolean; override;
    procedure SetBeaconDeathTime(AValue: Integer); override;
    procedure SetScanningSleepingTime(AValue: Integer); override;
    procedure SetScanningTime(AValue: Integer); override;
    procedure SetSPC(AValue: Single); override;
    procedure SetBeaconType(AValue: Word); override;
    function GetNumberofBeaconsRegistered: Integer; override;
    procedure DoSetKindofBeacons(AValue: TKindofBeacons); override;
    function GeTKindofBeacons: TKindofBeacons; override;
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBeaconLocationManagerDelegate = class(TOCLocal, CLLocationManagerDelegate)
  private
    FRangeBeaconCallback: TBeaconRangeCallback;
    FEnterRegionCallback: TBeaconRegionCallback;
    FErrorCallback: TBeaconErrorCallbabk;
    FExitRegionCallback: TBeaconRegionCallback;
    FAutorizationChangeCallback: TAutorizationChangeCallback;
    function GetBeaconRegionFrom(const ARegion: CLRegion): CLBeaconRegion;
  public
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); overload; cdecl;
    function locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean; cdecl;
    [MethodName('locationManager:didUpdateLocations:')]
    procedure locationManagerDidUpdateLocations(manager: CLLocationManager; locations: NSArray); cdecl;
    [MethodName('locationManager:didFinishDeferredUpdatesWithError:')]
    procedure locationManagerDidFinishDeferredUpdatesWithError(manager: CLLocationManager; error: NSError); cdecl;
    procedure locationManagerDidPauseLocationUpdates(manager: CLLocationManager); cdecl;
    procedure locationManagerDidResumeLocationUpdates(manager: CLLocationManager); cdecl;
    [MethodName('locationManager:didEnterRegion:')]
    procedure locationManagerDidEnterRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didExitRegion:')]
    procedure locationManagerDidExitRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didDetermineState:forRegion:')]
    procedure locationManagerDidDetermineStateForRegion(manager: CLLocationManager; state: CLRegionState; region: CLRegion); cdecl;
    [MethodName('locationManager:didStartMonitoringForRegion:')]
    procedure locationManagerDidStartMonitoringForRegion(manager: CLLocationManager; region: CLRegion); cdecl;
    [MethodName('locationManager:didRangeBeacons:inRegion:')]
    procedure locationManagerDidRangeBeaconsInRegion(manager: CLLocationManager; beacons: NSArray; region: CLBeaconRegion); cdecl;
    [MethodName('locationManager:rangingBeaconsDidFailForRegion:withError:')]
    procedure locationManagerRangingBeaconsDidFailForRegionWithError(manager: CLLocationManager; region: CLBeaconRegion; error: NSError); cdecl;
  end;

  TiOSBeacon = class(TInterfacedObject, IiBeacon)
  private type
    TCalcDistanceEvent = function (const UUID: TGUID; AMajor, AMinor: Word; AtxPower: Integer;
      ARssi: Integer; var NewDistance: Double): Boolean of object;
    TCalcDistancesEvent = function (const Abeacon: IBeacon; ATxPower: Integer; ARssi: Integer;
      var NewDistance: Double): Boolean of object;
  private
    FLastUpdateTime: TDateTime;
    FKindofBeacon: TKindofBeacon;
    FEddystoneBeacon: TEddystoneBeaconInfo;
    FGUID: TGUID;
    FMinor: Word;
    FMajor: Word;
    FProximity: TMeanCalculator<Integer>;
    FDistance: TMeanCalculator<Double>;
    FRssi: Integer;
    FCalcDistance: TCalcDistanceEvent;
    FCalcDistances: TCalcDistancesEvent;
    FCalcMode: TBeaconCalcMode;
    FCalculatedDistance: Double;
  public
    function GetGUID: TGUID; inline;
    function GetMajor: Word; inline;
    function GetMinor: Word; inline;
    function GetRssi: Integer; inline;
    function GetDistance: Double; inline;
    function GetEddystoneBeacon: TEddystoneBeaconInfo;
    function GetDeviceIdentifier: string;
    function GetProximity: TBeaconProximity; inline;
    function GetAdditionalData: TBytes;
    function ItsAlive:Boolean; inline;
    function IsEqualTo(const AGUID: TGUID; AMajor, AMinor: Word): Boolean; overload;
    function IsEqualTo(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload;
    function IsEqualTo(const AIBeacon: IBeacon): Boolean; overload;
    procedure SetBeaconInfo(const ABeacon: CLBeacon; IsMoving: Boolean);
    function GetKindofBeacon: TKindofBeacon;
    constructor Create(AMode: TBeaconCalcMode);
  end;

function CheckOSVersion: Boolean;
begin
  Result := TOSVersion.Check(8);
end;

function CLProximityToTProximity(const AProximity: CLProximity): TBeaconProximity;
begin
  case AProximity of
    CLProximityUnknown: Result := TBeaconProximity.Away;
    CLProximityImmediate: Result := TBeaconProximity.Immediate;
    CLProximityNear: Result := TBeaconProximity.Near;
    CLProximityFar: Result := TBeaconProximity.Far;
    else
      Result := TBeaconProximity.Away;
  end;
end;

function GetOwnCalcProximity(ADistance: Double): Integer;
begin
  if ADistance < PROXIMITY_IMMEDIATE then
    Result := Integer(Immediate)
  else
    if ADistance < PROXIMITY_NEAR then
      Result := Integer(Near)
    else
      if ADistance < PROXIMITY_FAR then
        Result := Integer(Far)
      else
        Result := Integer(Away);
end;

{ TBeaconLocationManagerDelegate }

procedure TBeaconLocationManagerDelegate.locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion;
  withError: NSError);
begin
  if Assigned(FErrorCallback) then
    FErrorCallback(NSStrToStr(withError.localizedDescription));
end;

procedure TBeaconLocationManagerDelegate.locationManager(manager: CLLocationManager;
  didChangeAuthorizationStatus: CLAuthorizationStatus);
begin
  if Assigned(FAutorizationChangeCallback) then
    FAutorizationChangeCallback(didChangeAuthorizationStatus);
end;

procedure TBeaconLocationManagerDelegate.locationManager(manager: CLLocationManager; didUpdateToLocation, fromLocation: CLLocation);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManager(manager: CLLocationManager; didFailWithError: NSError);
begin
  if Assigned(FErrorCallback) then
    FErrorCallback(NSStrToStr(didFailWithError.localizedDescription));
end;

procedure TBeaconLocationManagerDelegate.locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidDetermineStateForRegion(manager: CLLocationManager; state: CLRegionState;
  region: CLRegion);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidEnterRegion(manager: CLLocationManager; region: CLRegion);
var
  LBeaconRegion: CLBeaconRegion;
  LUUID: string;
  LMajor: Integer;
  LMinor: Integer;
begin
  if Assigned(FEnterRegionCallback) then
  begin
    LBeaconRegion := GetBeaconRegionFrom(region);
    if LBeaconRegion <> nil then
    begin
      LUUID := NSStrToStr(LBeaconRegion.proximityUUID.UUIDString);
      if LBeaconRegion.major <> nil then
        LMajor := LBeaconRegion.major.unsignedShortValue
      else
        LMajor := -1;
      if LBeaconRegion.minor <> nil then
        LMinor := LBeaconRegion.minor.unsignedShortValue
      else
        LMinor := -1;
      FEnterRegionCallback(TGUID.Create('{' + LUUID + '}'), LMajor, LMinor);
    end;
  end;
end;

function TBeaconLocationManagerDelegate.GetBeaconRegionFrom(const ARegion: CLRegion): CLBeaconRegion;
begin
  Result := nil;
  if NSInheritsFrom(ARegion, TCLBeaconRegion.OCClass) then
  begin
    ARegion.retain;
    Result := TCLBeaconRegion.Wrap((ARegion as ILocalObject).GetObjectID);
    Result.retain;
  end;
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidExitRegion(manager: CLLocationManager; region: CLRegion);
var
  LBeaconRegion: CLBeaconRegion;
  LUUID: string;
  LMajor: Integer;
  LMinor: Integer;
begin
  if Assigned(FExitRegionCallback) then
  begin
    LBeaconRegion := GetBeaconRegionFrom(region);
    if LBeaconRegion <> nil then
    begin
      LUUID := NSStrToStr(LBeaconRegion.proximityUUID.UUIDString);
      if LBeaconRegion.major <> nil then
        LMajor := LBeaconRegion.major.unsignedShortValue
      else
        LMajor := -1;
      if LBeaconRegion.minor <> nil then
        LMinor := LBeaconRegion.minor.unsignedShortValue
      else
        LMinor := -1;
      FExitRegionCallback(TGUID.Create('{' + LUUID + '}'), LMajor, LMinor);
    end;
  end;
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidFinishDeferredUpdatesWithError(manager: CLLocationManager; error: NSError);
begin
  if Assigned(FErrorCallback) then
    FErrorCallback(NSStrToStr(error.localizedDescription));
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidPauseLocationUpdates(manager: CLLocationManager);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidResumeLocationUpdates(manager: CLLocationManager);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidStartMonitoringForRegion(manager: CLLocationManager; region: CLRegion);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidUpdateLocations(manager: CLLocationManager; locations: NSArray);
begin
  // For debug purposes
end;

procedure TBeaconLocationManagerDelegate.locationManagerDidRangeBeaconsInRegion(manager: CLLocationManager; beacons: NSArray; region: CLBeaconRegion);
var
  LBeacon: CLBeacon;
  I: Integer;
  LCount: Integer;
begin
  if Assigned(FRangeBeaconCallback) then
  begin
    LCount := beacons.count;
    if LCount > 0 then
    begin
      for I := 0 to LCount - 1 do
      begin
        Lbeacon := TCLBeacon.Wrap(beacons.objectAtIndex(I));
        if Assigned(FRangeBeaconCallback) then
          FRangeBeaconCallback(LBeacon);
      end;
    end
    else
      FRangeBeaconCallback(nil);
  end;
end;

procedure TBeaconLocationManagerDelegate.locationManagerRangingBeaconsDidFailForRegionWithError(manager: CLLocationManager;
  region: CLBeaconRegion; error: NSError);
begin
  if Assigned(FErrorCallback) then
    FErrorCallback(NSStrToStr(error.localizedDescription));
end;

function TBeaconLocationManagerDelegate.locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean;
begin
  // For debug purposes
  Result := False;
end;

{ TiOSBeaconManager }

procedure TiOSBeaconManager.DoiOSBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  TMonitor.Enter(Self);
  try
    SetLength(FCurrentBeaconList, Length(FCurrentBeaconList) + 1);
    FCurrentBeaconList[Length(FCurrentBeaconList) - 1] := ABeacon;
    DoBeaconEnter(ABeacon, FCurrentBeaconList);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
var
  I: Integer;
  LBLength: Integer;
  LTailElements: Integer;
begin
  TMonitor.Enter(Self);
  try
    LBLength := Length(FCurrentBeaconList);
    for I := 0 to LBLength - 1 do
      if FCurrentBeaconList[I].IsEqualTo(ABeacon) then
      begin
        LTailElements := LBLength - (I + 1);
        FCurrentBeaconList[I] := nil;
        if LTailElements > 0 then
          Move(FCurrentBeaconList[I + 1], FCurrentBeaconList[I], SizeOf(IBeacon) * LTailElements);
        Initialize(FCurrentBeaconList[LBLength - 1]);
        SetLength(FCurrentBeaconList, LBLength - 1);
        Break;
      end;

    DoBeaconExit(ABeacon, FCurrentBeaconList);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconChangedProximity(const Sender: TObject; const ABeacon: IBeacon; CurrentProximity: TBeaconProximity);
begin
  TMonitor.Enter(Self);
  try
    DoBeaconChangedProximity(ABeacon, CurrentProximity);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSRegionEnter(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
begin
  TMonitor.Enter(Self);
  try
    DoRegionEnter(UUID, AMajor, AMinor);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconsRegionEnter(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
begin
  TMonitor.Enter(Self);
  try
    DoBeaconsRegionEnter(ABeaconRegion);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSRegionExit(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Integer);
begin
  TMonitor.Enter(Self);
  try
    DoRegionExit(UUID, AMajor, AMinor);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconsRegionExit(const Sender: TObject; const ABeaconRegion: TBeaconsRegion);
begin
  TMonitor.Enter(Self);
  try
    DoBeaconsRegionExit(ABeaconRegion);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSNewBLEScanFilter(const Sender: TObject; AKindofScanFilter: TKindofScanFilter;
    const ABluetoothLEScanFilter: TBluetoothLEScanFilter);
begin
  TMonitor.Enter(Self);
  try
    DoNewBLEScanFilter(AKindofScanFilter, ABluetoothLEScanFilter);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconCalcDistance(const Sender: TObject; const UUID: TGUID; AMajor, AMinor: Word;
  ATxPower: Integer; ARssi: Integer; var NewDistance: Double);
begin
  TMonitor.Enter(Self);
  try
    DoBeaconCalcDistance(UUID, AMajor, AMinor, ATxPower,ARssi, NewDistance);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSBeaconCalcDistance(const Sender: TObject; const ABeacon: IBeacon; ATxPower, ARssi: Integer;
  var NewDistance: Double);
begin
  TMonitor.Enter(Self);
  try
    DoBeaconCalcDistance(ABeacon, ATxPower, ARssi, NewDistance);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSParseManufacturerData(const Sender: TObject; const AData: TManufacturerRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  TMonitor.Enter(Self);
  try
    DoParseManufacturerData(TBytes(AData), BeaconInfo, Handled);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSParseServiceData(const Sender: TObject; const AData: TServiceDataRawData; var BeaconInfo: TBeaconInfo; var Handled: Boolean);
begin
  TMonitor.Enter(Self);
  try
    DoParseServiceData(AData, BeaconInfo, Handled);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSNewEddystoneURL(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneURL: TEddystoneURL);
begin
  TMonitor.Enter(Self);
  try
    DoNewEddystoneURL(ABeacon, AEddystoneURL);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.DoiOSNewEddystoneTLM(const Sender: TObject; const ABeacon: IBeacon; const AEddystoneTLM: TEddystoneTLM);
begin
  TMonitor.Enter(Self);
  try
    DoNewEddystoneTLM(ABeacon, AEddystoneTLM);
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TiOSBeaconManager.CheckEvents;
begin
  if FCoreLocationManager <> nil then
  begin
    FCoreLocationManager.OnBeaconEnter := DoiOSBeaconEnter;
    FCoreLocationManager.OnBeaconExit := DoiOSBeaconExit;
    if Assigned(FOnBeaconProximity) then
      FCoreLocationManager.OnBeaconProximity := DoiOSBeaconChangedProximity
    else
      FCoreLocationManager.OnBeaconProximity := nil;

    FCoreLocationManager.OnEnterRegion := DoiOSRegionEnter;
    FCoreLocationManager.OnExitRegion := DoiOSRegionExit;
    FCoreLocationManager.OnBeaconsEnterRegion := DoiOSBeaconsRegionEnter;
    FCoreLocationManager.OnBeaconsExitRegion := DoiOSBeaconsRegionExit;

    if Assigned(FOnCalculateDistances) then
      FCoreLocationManager.OnCalculateDistances := DoiOSBeaconCalcDistance
    else
    begin
      FCoreLocationManager.OnCalculateDistances := nil;
      if Assigned(FOnCalcDistance) then
        FCoreLocationManager.OnCalcDistance := DoiOSBeaconCalcDistance
      else
        FCoreLocationManager.OnCalcDistance := nil;
    end;

    if Assigned(FOnParseManufacturerData) then
      FCoreLocationManager.OnParseManufacturerData := DoiOSParseManufacturerData
    else
      FCoreLocationManager.OnParseManufacturerData := nil;

    FCoreLocationManager.OnParseServiceData := nil;
    FCoreLocationManager.OnNewEddystoneTLM := nil;
    FCoreLocationManager.OnNewEddystoneURL := nil;
    FCoreLocationManager.OnNewBLEScanFilterEvent := nil;
  end;

  if FCommonManager <> nil then
  begin
    FCommonManager.OnBeaconEnter := DoiOSBeaconEnter;
    FCommonManager.OnBeaconExit := DoiOSBeaconExit;
    if Assigned(FOnBeaconProximity) then
      FCommonManager.OnBeaconProximity := DoiOSBeaconChangedProximity
    else
      FCommonManager.OnBeaconProximity := nil;

    FCommonManager.OnEnterRegion := DoiOSRegionEnter;
    FCommonManager.OnExitRegion := DoiOSRegionExit;
    FCommonManager.OnBeaconsEnterRegion := DoiOSBeaconsRegionEnter;
    FCommonManager.OnBeaconsExitRegion := DoiOSBeaconsRegionExit;
    FCommonManager.OnNewBLEScanFilterEvent := DoiOSNewBLEScanFilter;

    if Assigned(FOnCalculateDistances) then
      FCommonManager.OnCalculateDistances := DoiOSBeaconCalcDistance
    else
    begin
      FCommonManager.OnCalculateDistances := nil;
      if Assigned(FOnCalcDistance) then
        FCommonManager.OnCalcDistance := DoiOSBeaconCalcDistance
      else
        FCommonManager.OnCalcDistance := nil;
    end;

    if Assigned(FOnParseManufacturerData) then
      FCommonManager.OnParseManufacturerData := DoiOSParseManufacturerData
    else
      FCommonManager.OnParseManufacturerData := nil;

    if Assigned(FOnParseServiceData) then
      FCommonManager.OnParseServiceData := DoiOSParseServiceData
    else
      FCommonManager.OnParseServiceData := nil;

    FCommonManager.OnNewEddystoneTLM := DoiOSNewEddystoneTLM;
    FCommonManager.OnNewEddystoneURL := DoiOSNewEddystoneURL;
  end;
end;

constructor TiOSBeaconManager.Create(AMode: TBeaconScanMode);
begin
  FScanMode := AMode;
  FCoreLocationManager := TiOSBeaconManagerCoreLocation.GetInstance(AMode);
  FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(AMode);
  CheckEvents;
  FBeaconDeathTime := FCommonManager.BeaconDeathTime;
  FSPC := FCommonManager.SPC;
  FScanningTime := FCommonManager.ScanningTime;
  FScanningSleepingTime := FCommonManager.ScanningSleepingTime;
  FCalcMode := FCommonManager.CalcMode;
  FScanMode := FCommonManager.ScanMode;
  FBeaconType := FCommonManager.BeaconType;
end;

function TiOSBeaconManager.DoNearest: IBeacon;
var
  LIBeacon: IBeacon;
begin
  Result := nil;
  if FCoreLocationManager <> nil then
    LIBeacon := FCoreLocationManager.Nearest;
  if FCommonManager <> nil then
    Result := FCommonManager.Nearest;

  if (LIBeacon <> nil) then
    if (Result <> nil) then
    begin
      if LIBeacon.Distance < Result.Distance then
        Result := LIBeacon;
    end
    else
      Result := LIBeacon;
end;

function TiOSBeaconManager.DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := False;
  if (AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons) then
  begin
    if FCoreLocationManager = nil then
      FCoreLocationManager := TiOSBeaconManagerCoreLocation.GetInstance(FScanMode);
    Result := FCoreLocationManager.RegisterBeacon(AGUID, AKindofBeacon);
    if Result and IsScanning then
      DoStartScan;
  end;

  if AKindofBeacon <> TKindofBeacon.iBeacons then
  begin
    if FCommonManager = nil then
      FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(FScanMode);
    Result := FCommonManager.RegisterBeacon(AGUID, AKindofBeacon);
  end;
end;

function TiOSBeaconManager.DoRegisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon;
  AManufacturerId: Integer): Boolean;
begin
  Result := False;
  if (AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons) then
  begin
    if FCoreLocationManager = nil then
      FCoreLocationManager := TiOSBeaconManagerCoreLocation.GetInstance(FScanMode);
    Result := FCoreLocationManager.RegisterBeacon(AGUID, Major, AKindofBeacon);
    if Result and IsScanning then
      DoStartScan;
  end;

  if AKindofBeacon <> TKindofBeacon.iBeacons then
  begin
    if FCommonManager = nil then
      FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(FScanMode);
    Result := FCommonManager.RegisterBeacon(AGUID, Major, AKindofBeacon);
  end;
end;

function TiOSBeaconManager.DoRegisterBeacon(const AGUID: TGUID; Major, Minor: Word;
  const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := False;
  if (AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons) then
  begin
    if FCoreLocationManager = nil then
      FCoreLocationManager := TiOSBeaconManagerCoreLocation.GetInstance(FScanMode);
    Result := FCoreLocationManager.RegisterBeacon(AGUID, Major, Minor, AKindofBeacon);
    if Result and IsScanning then
      DoStartScan;
  end;

  if AKindofBeacon <> TKindofBeacon.iBeacons then
  begin
    if FCommonManager = nil then
      FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(FScanMode);
    Result := FCommonManager.RegisterBeacon(AGUID, Major, Minor, AKindofBeacon);
  end;
end;

function TiOSBeaconManager.DoRegisterEddyBeacon( const ANamespace: TNamespace): Boolean;
var
  LBeaconsRegion: TBeaconsRegion;
begin
  if FCommonManager = nil then
    FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(FScanMode);

  LBeaconsRegion.KindofBeacon := TKindofBeacon.Eddystones;
  LBeaconsRegion.EddysUIDRegion.Initialize(ANamespace);
  Result := FCommonManager.RegisterBeacons(LBeaconsRegion);
end;

function TiOSBeaconManager.DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
var
  LBeaconsRegion: TBeaconsRegion;
begin
  if FCommonManager = nil then
    FCommonManager := System.Beacon.Common.TPlatformBeaconManager.GetInstance(FScanMode);

  LBeaconsRegion.KindofBeacon := TKindofBeacon.Eddystones;
  LBeaconsRegion.EddysUIDRegion.Initialize(ANamespace, AInstance);
  Result := FCommonManager.RegisterBeacons(LBeaconsRegion);
end;

function TiOSBeaconManager.DoStartScan: Boolean;

  function BeaconInLocation: Boolean;
  begin
    Result := False;
    if FScanMode = TBeaconScanMode.Standard then
      Exit(True);
    if (FScanMode = TBeaconScanMode.Extended) and ((TKindofBeacon.iBeacons in KindofBeacons)
      or (TKindofBeacon.iBAltBeacons in KindofBeacons)) then
      Exit(True);
  end;

  function BeaconInCommon: Boolean;
  begin
    Result := False;
    if (FScanMode = TBeaconScanMode.Alternative) or (FScanMode = TBeaconScanMode.Eddystone) then
      Exit(True);
    if (FScanMode = TBeaconScanMode.Extended) and ((TKindofBeacon.AltBeacons in KindofBeacons) or
      (TKindofBeacon.Eddystones in KindofBeacons) or (TKindofBeacon.iBAltBeacons in KindofBeacons)) then
      Exit(True);
  end;

begin
  CheckEvents;
  Result := False;
  FScanning := False;

  if FCoreLocationManager <> nil then
    if BeaconInLocation then
    begin
      FCoreLocationManager.CalcMode := FCalcMode;
      FCoreLocationManager.KindofBeacons := FKindofBeacons;
      Result := FCoreLocationManager.StartScan
    end
    else
      if FCoreLocationManager.NumberofBeaconsRegistered = 0 then
        FCoreLocationManager := nil;

  if FCommonManager <> nil then
    if BeaconInCommon then
    begin
      FCommonManager.CalcMode := FCalcMode;
      FCommonManager.KindofBeacons := FKindofBeacons;
      Result := FCommonManager.StartScan;
    end
    else
      if FCommonManager.NumberofBeaconsRegistered = 0 then
        FCommonManager := nil;

  if (FScanMode = TBeaconScanMode.Extended) and (iBeacons in FKindofBeacons)
    and ((FCoreLocationManager = nil) or (FCoreLocationManager.NumberofBeaconsRegistered = 0)) then
    raise EBeaconManagerException.Create(SiOSiBeaconMustBeRegistered);

  if (FScanMode <> TBeaconScanMode.Extended)
    and ((FCommonManager = nil) or (FCommonManager.NumberofBeaconsRegistered = 0))
    and ((FCoreLocationManager = nil) or (FCoreLocationManager.NumberofBeaconsRegistered = 0)) then
    raise EBeaconManagerException.Create(SBeaconNoDeviceRegister);

  if not Result then
  begin
    if FCommonManager <> nil then
      FCommonManager.StopScan;
    if FCoreLocationManager <> nil then
      FCoreLocationManager.StopScan;
  end
  else
    FScanning := True;
end;

function TiOSBeaconManager.DoStopScan: Boolean;
begin
  Result := False;
  if FCoreLocationManager <> nil then
    Result := FCoreLocationManager.StopScan;
  if  FCommonManager <> nil then
    Result := Result or FCommonManager.StopScan;
  FScanning := False;
end;

function TiOSBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := False;
  if (FCoreLocationManager <> nil) and
    ((AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons)) then
    Result := FCoreLocationManager.UnRegisterBeacon(AGUID, AKindofBeacon);

  if (FCommonManager <> nil) and (AKindofBeacon <> TKindofBeacon.iBeacons) then
    Result := FCommonManager.UnRegisterBeacon(AGUID, AKindofBeacon);
end;

function TiOSBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := False;
  if (FCoreLocationManager <> nil) and
    ((AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons)) then
    Result := FCoreLocationManager.UnRegisterBeacon(AGUID, Major, AKindofBeacon);

  if (FCommonManager <> nil) and (AKindofBeacon <> TKindofBeacon.iBeacons) then
    Result := FCommonManager.UnRegisterBeacon(AGUID, Major, AKindofBeacon);
end;

function TiOSBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; Major, Minor: Word;
  const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := False;
  if (FCoreLocationManager <> nil) and
    ((AKindofBeacon = TKindofBeacon.iBeacons) or (AKindofBeacon = TKindofBeacon.iBAltBeacons)) then
    Result := FCoreLocationManager.UnRegisterBeacon(AGUID, Major, Minor, AKindofBeacon);

  if (FCommonManager <> nil) and (AKindofBeacon <> TKindofBeacon.iBeacons) then
    Result := FCommonManager.UnRegisterBeacon(AGUID, Major, Minor, AKindofBeacon);
end;

function TiOSBeaconManager.DoUnRegisterEddyBeacon( const ANamespace: TNamespace): Boolean;
var
  LBeaconsRegion: TBeaconsRegion;
begin
  if (FCommonManager <> nil) then
  begin
    LBeaconsRegion.KindofBeacon := TKindofBeacon.Eddystones;
    LBeaconsRegion.EddysUIDRegion.Initialize(ANamespace);
    Result := FCommonManager.UnRegisterBeacons(LBeaconsRegion);
  end
  else
    Result := False;
end;

function TiOSBeaconManager.DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
var
  LBeaconsRegion: TBeaconsRegion;
begin
  if (FCommonManager <> nil) then
  begin
    LBeaconsRegion.KindofBeacon := TKindofBeacon.Eddystones;
    LBeaconsRegion.EddysUIDRegion.Initialize(ANamespace, AInstance);
    Result := FCommonManager.UnRegisterBeacons(LBeaconsRegion);
  end
  else
    Result := False;
end;

class function TiOSBeaconManager.GetInstance(AMode: TBeaconScanMode): TBeaconManager;
begin
  Result := TiOSBeaconManager.Create(AMode);
end;

function TiOSBeaconManager.GeTKindofBeacons: TKindofBeacons;
begin
  Result := FKindofBeacons;
end;

function TiOSBeaconManager.GetNumberofBeaconsRegistered: Integer;
begin
  Result := 0;
  if FCoreLocationManager <> nil then
    Result := FCoreLocationManager.NumberofBeaconsRegistered;

  if FCommonManager <> nil then
    Result := Result + FCommonManager.NumberofBeaconsRegistered;
end;

procedure TiOSBeaconManager.SetBeaconDeathTime(AValue: Integer);
begin
  if (FCommonManager <> nil) then
    FCommonManager.BeaconDeathTime := AValue;
  if (FCoreLocationManager <> nil) then
    FCoreLocationManager.BeaconDeathTime := AValue;
  FBeaconDeathTime := AValue;
end;

procedure TiOSBeaconManager.SetBeaconType(AValue: Word);
begin
  if (FCommonManager <> nil) and (FCommonManager.BeaconType <> AValue) then
    FCommonManager.BeaconType := AValue;
  if (FCoreLocationManager <> nil) and (FCoreLocationManager.BeaconType <> AValue) then
    FCoreLocationManager.BeaconType := AValue;
  FBeaconType := AValue;
end;

procedure TiOSBeaconManager.DoSetKindofBeacons(AValue: TKindofBeacons);
begin
  FKindofBeacons := AValue;
end;

procedure TiOSBeaconManager.SetScanningSleepingTime(AValue: Integer);
begin
  if (FCommonManager <> nil) then
    FCommonManager.ScanningSleepingTime := AValue;
  if (FCoreLocationManager <> nil) then
    FCoreLocationManager.ScanningSleepingTime := AValue;
  FScanningSleepingTime := AValue;
end;

procedure TiOSBeaconManager.SetScanningTime(AValue: Integer);
begin
  if (FCommonManager <> nil) then
    FCommonManager.ScanningTime := AValue;
  if (FCoreLocationManager <> nil) then
    FCoreLocationManager.ScanningTime := AValue;
  FScanningTime := AValue;
end;

procedure TiOSBeaconManager.SetSPC(AValue: Single);
begin
  if (FCommonManager <> nil) then
    FCommonManager.SPC := AValue;
  if (FCoreLocationManager <> nil) then
    FCoreLocationManager.SPC := AValue;
  FSPC := AValue;
end;

{ TiOSBeaconManagerCoreLocation }

class constructor TiOSBeaconManagerCoreLocation.Create;
begin
  DeathTime := KBEACONDEATHTIME;
end;

procedure TiOSBeaconManagerCoreLocation.UnRegisterBeacon(const AGUID: TGUID; Major, Minor: Integer; AKindofBeacon: TKindofBeacon);
var
  LRegion: CLBeaconRegion;
  LBeaconRegion: TBeaconRegion;
  I: Integer;
begin
  LBeaconRegion.Initialilize(AGUID, Major, Minor);

  TMonitor.Enter(FRegisteredRegions);
  try
    I := FRegisteredRegions.Count - 1;
    while I >= 0 do
    begin
      if FRegisteredRegions[I].IsRegion(AGUID, Major, Minor) then
      begin
        FRegisteredRegions.Delete(I);
        Break;
      end;
      Dec(I);
    end;
  finally
    TMonitor.Exit(FRegisteredRegions);
  end;
  LRegion := LBeaconRegion.GetRegion;
  FLocationManager.stopMonitoringForRegion(LRegion);
  FLocationManager.stopRangingBeaconsInRegion(LRegion);
  RemoveBeaconsFromRegion(LBeaconRegion);
end;

function TiOSBeaconManagerCoreLocation.DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  UnregisterBeacon(AGUID, MAJOR_REGION_ALL, MINOR_REGION_ALL, AKindofBeacon);
  Result := True;
end;

function TiOSBeaconManagerCoreLocation.DoUnregisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  UnregisterBeacon(AGUID, Major, MINOR_REGION_ALL, AKindofBeacon);
  Result := True;
end;

function TiOSBeaconManagerCoreLocation.DoUnregisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  UnRegisterBeacon(AGUID, Major, Minor, AKindofBeacon);
  Result := True;
end;

function TiOSBeaconManagerCoreLocation.DoUnRegisterEddyBeacon(const ANamespace: TNamespace): Boolean;
begin
  Result := False;
end;

function TiOSBeaconManagerCoreLocation.DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
begin
  Result := False;
end;

class function TiOSBeaconManagerCoreLocation.GetInstance(AMode: TBeaconScanMode): TBeaconManager;
begin
  Result := TiOSBeaconManagerCoreLocation.Create;
end;

function TiOSBeaconManagerCoreLocation.GeTKindofBeacons: TKindofBeacons;
begin
  Result := FKindofBeacons;
end;

function TiOSBeaconManagerCoreLocation.GetNumberofBeaconsRegistered: Integer;
begin
  if FRegisteredRegions <> nil then
    Result := FRegisteredRegions.count
  else
    Result := 0;
end;

procedure TiOSBeaconManagerCoreLocation.CheckBeaconListSanity;
var
  I: Integer;
  LRemovedBeacon: IBeacon;
  J: Integer;
begin
  TMonitor.Enter(FLockObject);
  try
    I := FCurrentBeaconCount - 1;
    while I >= 0 do
    begin
      if not FCurrentBeaconList[I].ItsAlive then
      begin
        LRemovedBeacon := FCurrentBeaconList[I];
        for J := I to FCurrentBeaconCount - 2 do
          FCurrentBeaconList[J] := FCurrentBeaconList[J + 1];
        Dec(FCurrentBeaconCount);
        SetLength(FCurrentBeaconList, FCurrentBeaconCount);
        DoBeaconExit(LRemovedBeacon, FCurrentBeaconList);
        CheckExitRegion(LRemovedBeacon);
      end;
      Dec(I);
    end;
  finally
    TMonitor.Exit(FLockObject);
  end;
end;

procedure TiOSBeaconManagerCoreLocation.DoEnterExitRegion(RegionIndex: Integer; Enter: Boolean);
var
  LRegion: TBeaconRegion;
  LsRegion: TBeaconsRegion;
begin
  LRegion := FRegisteredRegions[RegionIndex];
  LRegion.Inside := Enter;
  FRegisteredRegions[RegionIndex] := LRegion;
  LsRegion.KindofBeacon := TKindofBeacon.iBeacons;
  LsRegion.iBAltBeaconRegion.Initialize(LRegion.GUID, LRegion.Major, LRegion.Minor, TKindofBeacon.iBeacons, APPLEINC);
  if Enter then
  begin
    DoBeaconsRegionEnter(LsRegion);
    DoRegionEnter(LRegion.GUID, LRegion.Major, LRegion.Minor)
  end
  else
  begin
    DoBeaconsRegionExit(LsRegion);
    DoRegionExit(LRegion.GUID, LRegion.Major, LRegion.Minor);
  end;
end;

procedure TiOSBeaconManagerCoreLocation.CheckEnterRegion(const ANewBeacon: IBeacon);
var
  I: Integer;
begin
  TMonitor.Enter(FRegisteredRegions);
  try
    if ANewBeacon <> nil then // check if we entered in a new region
    begin
      for I := 0 to FRegisteredRegions.Count - 1 do
        if FRegisteredRegions[I].BeaconBelongs(ANewBeacon) then
        begin
          if not FRegisteredRegions[I].Inside then
            DoEnterExitRegion(I, True);
          Break;
        end;
    end;
  finally
    TMonitor.Exit(FRegisteredRegions);
  end;
end;

procedure TiOSBeaconManagerCoreLocation.CheckExitRegion(const AExitedBeacon: IBeacon);
var
  I, J: Integer;
  LStillInside: Boolean;
begin
  TMonitor.Enter(FRegisteredRegions);
  try
    for I := 0 to FRegisteredRegions.Count - 1 do
    begin
      if FRegisteredRegions[I].Inside and FRegisteredRegions[I].BeaconBelongs(AExitedBeacon) then
      begin
        LStillInside := False;
        for J := 0 to FCurrentBeaconCount - 1 do
        begin
          if FCurrentBeaconList[J] <> AExitedBeacon then
            LStillInside := FRegisteredRegions[I].BeaconBelongs(FCurrentBeaconList[J]);
          if LStillInside then
            Break;
        end;
        if not LStillInside then
        begin
          DoEnterExitRegion(I, False);
          Break;
        end;
      end;
    end;
  finally
    TMonitor.Exit(FRegisteredRegions);
  end;
end;

constructor TiOSBeaconManagerCoreLocation.Create;
begin
  inherited;
  FLocationManager := TCLLocationManager.Create;
//  SetAllowBackgroundUpdates;
  FLocationDelegate := TBeaconLocationManagerDelegate.Create;
  FLocationManager.setDelegate((FLocationDelegate as ILocalObject).GetObjectID );
  if CheckOSVersion then
    FLocationManager.requestWhenInUseAuthorization;
  TBeaconLocationManagerDelegate(FLocationDelegate).FEnterRegionCallback := EnterRegion;
  TBeaconLocationManagerDelegate(FLocationDelegate).FExitRegionCallback := ExitRegion;
  TBeaconLocationManagerDelegate(FLocationDelegate).FRangeBeaconCallback := RangeBeacon;
  TBeaconLocationManagerDelegate(FLocationDelegate).FAutorizationChangeCallback := AutorizationChange;
  FRegisteredRegions := TList<TBeaconRegion>.Create;
  FLockObject := TObject.Create;
  FScanMode := TBeaconScanMode.Standard;
  FBeaconType := BEACON_ST_TYPE;
  FSPC := SIGNAL_PROPAGATION_CONSTANT;
  FScanningTime := SCANNING_TIME;
  FScanningSleepingTime := SCANNING_SLEEPINGTIME;
  CalcMode := TBeaconCalcMode.Stabilized;
  FRssiAccumulatedDiff := ACCUMMULATE_DIFF_START_VALUE;
  FBeaconDeathTime := KBEACONDEATHTIME;
end;

destructor TiOSBeaconManagerCoreLocation.Destroy;
begin
  FLocationManager.setDelegate(nil);
  FRegisteredRegions.Free;
  FLockObject.Free;
  inherited;
end;

function TiOSBeaconManagerCoreLocation.DoNearest: IBeacon;
var
  I: Integer;
  LNearestDistance: Double;
begin
  Result := nil;
  if FCurrentBeaconCount > 0 then
  begin
    LNearestDistance := FCurrentBeaconList[0].Distance;
    Result := FCurrentBeaconList[0];
    for I := 1 to FCurrentBeaconCount - 1 do
    begin
      if LNearestDistance > FCurrentBeaconList[I].Distance then
      begin
        LNearestDistance := FCurrentBeaconList[I].Distance;
        Result := FCurrentBeaconList[I];
      end;
    end;
  end;
end;

function TiOSBeaconManagerCoreLocation.IsMonitoringAvailable: Boolean;
var
  ACLClass: Pointer;
begin
  Result := True;
  ACLClass := objc_getClass('CLBeaconRegion'); // do not localize
  if ACLClass <> nil then
    Result := TCLLocationManager.OCClass.isMonitoringAvailableForClass(ACLClass);
end;

procedure TiOSBeaconManagerCoreLocation.AutorizationChange(ACode: NativeUInt);
begin
  if ACode in [kCLAuthorizationStatusRestricted, kCLAuthorizationStatusDenied] then
    raise EBeaconManagerException.Create(SNotAllowedLocationServices);
end;

procedure TiOSBeaconManagerCoreLocation.EnterRegion(const UUID: TGUID; Major, Minor: Integer);
var
  I: Integer;
begin
  TMonitor.Enter(FRegisteredRegions);
  try
    for I := 0 to FRegisteredRegions.Count - 1 do
      if not FRegisteredRegions[I].Inside and FRegisteredRegions[I].IsRegion(UUID, Major, Minor) then
      begin
        DoEnterExitRegion(I, True);
        Break;
      end;
  finally
    TMonitor.Exit(FRegisteredRegions);
  end;
end;

procedure TiOSBeaconManagerCoreLocation.RangeBeacon(const ACLBeacon: CLBeacon);
var
  LNewBeacon: TiOSBeacon;
  I: Integer;
  LFound: Boolean;
  LUUID: string;
  LMajor: Word;
  LMinor: Word;
  LOldProximity: TBeaconProximity;
  LRSSIDiff: Integer;
  LiIBeacon: IiBeacon;
begin
  LFound := False;
  if ACLBeacon <> nil then
  begin
    LUUID := '{' + NSStrToStr(ACLBeacon.proximityUUID.UUIDString) + '}';
    LMajor := ACLBeacon.major.unsignedShortValue;
    LMinor := ACLBeacon.minor.unsignedShortValue;
    TMonitor.Enter(FLockObject);
    try
      for I := 0 to FCurrentBeaconCount - 1 do
      begin
        if FCurrentBeaconList[I].IsEqualTo(TGUID.Create(LUUID), LMajor, LMinor) then
        begin
          LRSSIDiff := Abs(FCurrentBeaconList[I].Rssi - ACLBeacon.rssi);
          if (FCurrentBeaconCount > 0) then
            FRssiAccumulatedDiff := ((FRssiAccumulatedDiff / FCurrentBeaconCount) * (FCurrentBeaconCount - 1)) + LRSSIDiff / FCurrentBeaconCount;
          LOldProximity := TiOSBeacon(FCurrentBeaconList[I]).GetProximity;
          TiOSBeacon(FCurrentBeaconList[I]).SetBeaconInfo(ACLBeacon, FRssiAccumulatedDiff >= DIFFERENTIAL_FILTER_BOUNDARY);
          if FCurrentBeaconList[I].GetProximity <> LOldProximity then
            DoBeaconChangedProximity(FCurrentBeaconList[I], FCurrentBeaconList[I].GetProximity);
          LFound := True;
          Break;
        end;
      end;
      if (not LFound) and (ACLBeacon.rssi <> 0) then
      begin
        LNewBeacon := TiOSBeacon.Create(CalcMode);
        LNewBeacon.FCalcDistance := DoBeaconCalcDistance;
        LNewBeacon.FCalcDistances := DoBeaconCalcDistance;
        LNewBeacon.SetBeaconInfo(ACLBeacon, False);
        FCurrentBeaconCount := Length(FCurrentBeaconList) + 1;
        SetLength(FCurrentBeaconList, FCurrentBeaconCount);
        if Supports(LNewBeacon, IiBeacon, LiIBeacon) then
        begin
          FCurrentBeaconList[FCurrentBeaconCount - 1] := LiIBeacon;
          CheckEnterRegion(LiIBeacon);
          DoBeaconEnter(LiIBeacon, FCurrentBeaconList);
        end;
      end;
    finally
      TMonitor.Exit(FLockObject);
    end;
  end;
  CheckBeaconListSanity;
end;

procedure TiOSBeaconManagerCoreLocation.RemoveBeaconsFromRegion(const ARegion: TBeaconRegion);
var
  I,J: Integer;
  LRemovedBeacon: IBeacon;
begin
  TMonitor.Enter(FLockObject);
  try
    I := FCurrentBeaconCount - 1;
    while I >= 0 do
    begin
      if ARegion.BeaconBelongs(FCurrentBeaconList[I]) then
      begin
        LRemovedBeacon := FCurrentBeaconList[I];
        for J := I to FCurrentBeaconCount - 2 do
          FCurrentBeaconList[J] := FCurrentBeaconList[J + 1];
        Dec(FCurrentBeaconCount);
        SetLength(FCurrentBeaconList, FCurrentBeaconCount);
        DoBeaconExit(LRemovedBeacon, FCurrentBeaconList);
      end;
      Dec(I);
    end;
  finally
    TMonitor.Exit(FLockObject);
  end;
end;

procedure TiOSBeaconManagerCoreLocation.SetBeaconType(AValue: Word);
begin
  raise EBeaconManagerException.Create(SCannotChangeBeaconType);
end;

procedure TiOSBeaconManagerCoreLocation.DoSetKindofBeacons(AValue: TKindofBeacons);
begin
  FKindofBeacons := AValue;
end;

procedure TiOSBeaconManagerCoreLocation.ExitRegion(const UUID: TGUID; Major, Minor: Integer);
var
  LRegion: TBeaconRegion;
  I: Integer;
begin
  LRegion.Initialilize(UUID, Major, Minor);
  RemoveBeaconsFromRegion(LRegion);
  TMonitor.Enter(FRegisteredRegions);
  try
    for I := 0 to FRegisteredRegions.Count - 1 do
      if FRegisteredRegions[I].Inside and FRegisteredRegions[I].IsRegion(UUID, Major, Minor)  then
      begin
        DoEnterExitRegion(I, False);
        Break;
      end;
  finally
    TMonitor.Exit(FRegisteredRegions);
  end;
end;

function TiOSBeaconManagerCoreLocation.AddRegionToList(const ARegion: TBeaconRegion):Boolean;
var
  I: Integer;
begin
  TMonitor.Enter(FRegisteredRegions);
  try
    I := FRegisteredRegions.Count - 1;
    while I > 0 do
    begin
      if FRegisteredRegions[I].GUID = ARegion.GUID then
      begin
        FLocationManager.stopMonitoringForRegion(FRegisteredRegions[I].GetRegion);
        FLocationManager.stopRangingBeaconsInRegion(FRegisteredRegions[I].GetRegion);
        FRegisteredRegions.Delete(I);
        Break;
      end;
      Dec(I);
    end;
    FRegisteredRegions.Add(ARegion);
  finally
    TMonitor.Exit(FRegisteredRegions);
    Result := True;
  end;
end;

//procedure TiOSBeaconManagerCoreLocation.SetAllowBackgroundUpdates;
//var
//  LBundle: NSBundle;
//  LBackModes: Pointer;
//  LModes: NSArray;
//  I: Integer;
//begin
//  if (FLocationManager <> nil) and TOSVersion.Check(9) then
//  begin
//    LBundle := TNSBundle.Wrap(TNSBundle.OCClass.mainBundle);
//    LBackModes := LBundle.infoDictionary.valueForKey(StrToNSStr('UIBackgroundModes'));
//    if LBackModes <> nil then
//    begin
//      LModes := TNSArray.Wrap(LBackModes);
//      for I := 0 to LModes.count - 1 do
//        if NSStrToStr(TNSString.Wrap(LModes.objectAtIndex(I))) = 'location' then
//        begin
//          FLocationManager.setAllowsBackgroundLocationUpdates(True);
//          Break;
//        end;
//    end;
//  end;
//end;

function TiOSBeaconManagerCoreLocation.DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
begin
  Result := RegisterBeacon(AGUID, MAJOR_REGION_ALL, MINOR_REGION_ALL, AKindofBeacon);
end;

function TiOSBeaconManagerCoreLocation.DoRegisterBeacon(const AGUID: TGUID; Major: Word; const AKindofBeacon: TKindofBeacon;
  AManufacturerId: Integer): Boolean;
begin
  Result := RegisterBeacon(AGUID, Major, MINOR_REGION_ALL, AKindofBeacon);
end;

function TiOSBeaconManagerCoreLocation.DoRegisterBeacon(const AGUID: TGUID; Major, Minor: Word; const AKindofBeacon: TKindofBeacon;
  AManufacturerId: Integer): Boolean;
begin
  Result := RegisterBeacon(AGUID, Major, Minor, AKindofBeacon);
end;

function TiOSBeaconManagerCoreLocation.DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean;
begin
  Result := False;
end;

function TiOSBeaconManagerCoreLocation.DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
begin
  Result := False;
end;

function TiOSBeaconManagerCoreLocation.DoStartScan: Boolean;
var
  LBeaconIdentifier: TBeaconRegion;
begin
  if IsMonitoringAvailable then
  begin
    TMonitor.Enter(FRegisteredRegions);
    try
      for LBeaconIdentifier in FRegisteredRegions do
      begin
        FLocationManager.startMonitoringForRegion(LBeaconIdentifier.GetRegion);
        FLocationManager.startRangingBeaconsInRegion(LBeaconIdentifier.GetRegion);
      end;
      Result := True;
    finally
      TMonitor.Exit(FRegisteredRegions);
    end;
  end
  else
    raise EBeaconManagerException.Create(SMonitoringNotAvailable);
end;

function TiOSBeaconManagerCoreLocation.DoStopScan: Boolean;
var
  LBeaconRegion: TBeaconRegion;
  LRegion: CLBeaconRegion;
begin
  Result := False;
  if IsMonitoringAvailable then
  begin
    TMonitor.Enter(FRegisteredRegions);
    try
      if FLocationManager.monitoredRegions.count > 0 then
          Result := True;
      for LBeaconRegion in FRegisteredRegions do
      begin
        LRegion := LBeaconRegion.GetRegion;
        FLocationManager.stopMonitoringForRegion(LRegion);
        FLocationManager.stopRangingBeaconsInRegion(LRegion);
      end;
    finally
      TMonitor.Exit(FRegisteredRegions);
    end;
  end;
end;

procedure TiOSBeaconManagerCoreLocation.SetBeaconDeathTime(AValue: Integer);
begin
  FBeaconDeathTime := AValue;
  TiOSBeaconManagerCoreLocation.DeathTime := FBeaconDeathTime;
end;

procedure TiOSBeaconManagerCoreLocation.SetScanningSleepingTime(AValue: Integer);
begin
  FScanningSleepingTime := AValue;
end;

procedure TiOSBeaconManagerCoreLocation.SetScanningTime(AValue: Integer);
begin
  FScanningTime := AValue;
end;

procedure TiOSBeaconManagerCoreLocation.SetSPC(AValue: Single);
begin
  FSPC := AValue;
end;

{ TBeaconIdentifier }

function TBeaconRegion.GetRegion: CLBeaconRegion;
var
  LGUID: string;
  LNSUUID: NSUUID;
  LIniGUID: string;
begin
  LIniGUID := GUID.ToString;
  LGUID := Copy(LIniGUID, 2, Length(LIniGUID) - 2);
  LNSUUID := TNSUUID.Alloc.initWithUUIDString(StrToNSStr(LGUID));
  if (Major = MAJOR_REGION_ALL) and (Minor = MINOR_REGION_ALL) then
    Result := TCLBeaconRegion.Wrap(TCLBeaconRegion.Alloc.initWithProximityUUIDIdentifier(LNSUUID, StrToNSStr(LIniGUID)))
  else if (Major <> MAJOR_REGION_ALL) and (Minor = MINOR_REGION_ALL) then
    Result := TCLBeaconRegion.Wrap(TCLBeaconRegion.Alloc.initWithProximityUUIDMajorIdentifier(LNSUUID, Major, StrToNSStr(LIniGUID)))
  else
    Result := TCLBeaconRegion.Wrap(TCLBeaconRegion.Alloc.initWithProximityUUIDMajorMinorIdentifier(LNSUUID, Major, Minor, StrToNSStr(LIniGUID)))
end;

procedure TBeaconRegion.Initialilize(const AGUID: TGUID; AMajor, AMinor: Integer);
begin
  GUID := AGUID;
  Major := AMajor;
  Minor := AMinor;
  Inside := False;
end;

function TBeaconRegion.BeaconBelongs(const ABeacon: IBeacon): Boolean;
begin
  Result := (ABeacon.GUID = GUID) and ((ABeacon.Major = Major) or (Major = MAJOR_REGION_ALL))  and
           ((ABeacon.Minor = Minor) or (Minor = MINOR_REGION_ALL));
end;

function TBeaconRegion.IsRegion(const AGUID: TGUID; AMajor: Integer; AMinor: Integer): Boolean;
begin
  Result := (AGUID = GUID) and (AMajor = Major) and (AMinor = Minor);
end;

{ TIOsBeacon }

constructor TiOSBeacon.Create(AMode: TBeaconCalcMode);
begin
  inherited Create;
  FLastUpdateTime := Now;
  FProximity := TMeanCalculator<Integer>.Create(ProximityMeanItems);
  FDistance := TMeanCalculator<Double>.Create(DistanceMeanItems);
  FCalcMode := AMode;
end;

function TiOSBeacon.GetDeviceIdentifier: string;
begin
  Result := '';
end;

function TiOSBeacon.GetDistance: Double;
begin
  Result := System.Math.RoundTo(FCalculatedDistance, DISTANCE_DECIMALS);
end;

function TiOSBeacon.GetEddystoneBeacon: TEddystoneBeaconInfo;
begin
 Result := FEddystoneBeacon;
end;

function TiOSBeacon.GetGUID: TGUID;
begin
  Result := FGUID;
end;

function TiOSBeacon.GetKindofBeacon: TKindofBeacon;
begin
  Result := FKindofBeacon;
end;

function TiOSBeacon.GetMajor: Word;
begin
  Result := FMajor;
end;

function TiOSBeacon.GetMinor: Word;
begin
  Result := FMinor;
end;

function TiOSBeacon.GetProximity: TBeaconProximity;
begin
  if FCalcMode = TBeaconCalcMode.Raw then
    Result := TBeaconProximity(FProximity.GetLast)
  else
    Result := TBeaconProximity(FProximity.Get);
end;

function TiOSBeacon.GetAdditionalData: TBytes;
begin
  SetLength(Result, 0);
end;

function TiOSBeacon.GetRssi: Integer;
begin
  Result := FRssi;
end;

function TiOSBeacon.IsEqualTo(const AGUID: TGUID; AMajor,AMinor: Word): Boolean;
begin
  Result := (GetMinor = AMinor) and (GetMajor = AMajor) and (GetGUID = AGUID);
end;

function TiOSBeacon.IsEqualTo(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
begin  // iOS Core Location just plays iBeacon
    Result := False;
end;

function TiOSBeacon.IsEqualTo(const AIBeacon: IBeacon): Boolean;
begin
  if (AIBeacon.KindofBeacon = TKindofBeacon.iBeacons) then
    Result := IsEqualTo(AIBeacon.GUID, AIBeacon.Major, AIBeacon.Minor)
  else
    Result := False;
end;

function TiOSBeacon.ItsAlive: Boolean;
begin
  Result := SecondsBetween(now, FLastUpdateTime) < TiOSBeaconManagerCoreLocation.DeathTime;
end;

procedure TiOSBeacon.SetBeaconInfo(const ABeacon: CLBeacon; IsMoving: Boolean);
var
  LDistance: Double;
begin
  FKindofBeacon := TKindofBeacon.iBeacons;
  FGUID := TGUID.Create('{' + NSStrToStr(ABeacon.proximityUUID.UUIDString) + '}');
  if ABeacon.minor <> nil then
    FMinor := ABeacon.minor.unsignedShortValue;
  if ABeacon.major <> nil then
    FMajor := ABeacon.major.unsignedShortValue;
  if Abeacon.rssi <> 0 then
    FRssi := ShortInt(Abeacon.rssi);

  if (Assigned(FCalcDistances) and FCalcDistances(IiBeacon(Self), TXPOWER_IDETERMINATED, FRssi, LDistance))
    or (Assigned(FCalcDistance) and FCalcDistance(FGUID, FMajor, FMinor, TXPOWER_IDETERMINATED, FRssi, LDistance)) then
  begin
    FCalcMode := TBeaconCalcMode.Raw;
    FCalculatedDistance := LDistance;
    FProximity.AddGetValue(GetOwnCalcProximity(FCalculatedDistance), IsMoving);
  end
  else
  begin
    FProximity.AddGetValue(Integer(CLProximityToTProximity(ABeacon.proximity)), IsMoving);
    LDistance := ABeacon.accuracy;
    if FCalcMode = TBeaconCalcMode.Stabilized then
      LDistance := FDistance.AddGetValue(LDistance, IsMoving);
    FCalculatedDistance := LDistance;
  end;
  FLastUpdateTime := Now;
end;

function TiOSBeaconManagerCoreLocation.RegisterBeacon(const AGUID: TGUID; Major, Minor: Integer; AKindofBeacon: TKindofBeacon): Boolean;
var
  LBeaconRegion: TBeaconRegion;
begin
  Result := False;
  if IsMonitoringAvailable then
  begin
    LBeaconRegion.Initialilize(AGUID, Major, Minor);
    Result := AddRegionToList(LBeaconRegion);
  end;
end;

{ TPlatformBeaconManager }

class function TPlatformBeaconManager.GetInstance(AMode: TBeaconScanMode): TBeaconManager;
begin
  Result := TiOSBeaconManager.GetInstance(AMode);
end;

end.
