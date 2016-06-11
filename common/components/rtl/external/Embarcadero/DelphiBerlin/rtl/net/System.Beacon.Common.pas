{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Beacon.Common;

interface

uses
  System.Beacon;

type
/// <summary>
///  Implements TBeaconManager for the android and OSX platforms, and for the alternative beacons mode in iOS
/// </summary>
  TPlatformBeaconManager = class(TBeaconManager)
  public
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; override;
  end;

implementation

uses
  System.SysUtils,
  System.Bluetooth,
  System.NetConsts,
  System.TypInfo,
  System.Math,
  System.Generics.Collections,
  System.Classes,
  System.SyncObjs,
  System.DateUtils,
  System.Types;

const
  CHECKING_ALIVE_TIME = 2000;

type

  TBeaconIDToRegister = record
    BeaconsInRegion: Word;
    case KindofBeacon: TKindofBeacon of
      TKindofBeacon.Eddystones:
       (Namespace: TNamespace; Instance: TInstance; AllInstances: Boolean;);
      TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
       (GUID: TGUID; Major, Minor: Integer; ManufacturerId: Integer);
    end;

  TBeaconIDToRegisterList = TList<TBeaconIDToRegister>;

  TRcCommonBeacon = record
    BeaconInfo: TBeaconInfo;
    Rssi: Integer;
    Distance: Double;
    Proximity: TBeaconProximity;
    RssiMean: TMeanCalculator<Integer>;
    LastMRSSI: Integer;
  end;

  TCommonBeacon = class(TInterfacedObject, IBeacon)
  private
    FRBeacon: TRcCommonBeacon;
    FTimeAlive: TDateTime;
    FIsAlive: Boolean;
    FregionID: Integer;
  public
    constructor create(const ARcCommonBeacon: TRcCommonBeacon);
    /// <summary> deprecated use IStandardBeacon.GUID <summary>
    function GetGUID: TGUID;
    /// <summary> deprecated use IStandardBeacon.Major <summary>
    function GetMajor: Word;
    /// <summary> deprecated use IStandardBeacon.Minor <summary>
    function GetMinor: Word;
    function GetRssi: Integer;
    function GetDistance: Double;
    function GetDeviceIdentifier: string;
    function IsEqualTo(const AGUID: TGUID; AMajor, AMinor: Word): Boolean; overload;
    function IsEqualTo(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload;
    function IsEqualTo(const AIBeacon: IBeacon): Boolean;  overload;
    function ItsAlive:Boolean;
    function GettxPower: Integer; inline;
    function GetProximity: TBeaconProximity;
    /// <summary> deprecated use IStandardBeacon.AltAdditionalData <summary>
    function GetAdditionalData: TBytes;
    function GetKindofBeacon: TKindofBeacon;
    procedure SetProximity(AProximity: TBeaconProximity); inline;
    procedure SetRssi(ARssi: Integer); inline;
    procedure SetDistance(ADistance: Double); inline;
    property txPower: Integer read GettxPower;
    property Rssi: Integer write SetRssi;
    property Distance: Double write SetDistance;
    property TimeAlive: TDateTime read FTimeAlive write FTimeAlive;
    property RegionID: Integer read FRegionID write FRegionID;
    property Proximity: TBeaconProximity read GetProximity write SetProximity;
    /// <summary> deprecated use IStandardBeacon.AltAdditionalData <summary>
    property AdditionalData: TBytes read GetAdditionalData;
  end;

  TStandardBeacon = class(TCommonBeacon, IStandardBeacon)
  end;

  TiBeacon = class(TStandardBeacon, IiBeacon)
  end;

  TAltBeacon = class(TStandardBeacon, IAltBeacon)
  public
    function GetAltAdditionalData: byte;
  end;

  TEddystoneBeacon = class(TCommonBeacon, IEddystoneBeacon)
  protected
    function GetEddystoneBeacon: TEddystoneBeaconInfo;
    procedure SetEddystoneBeacon(const AValue: TEddystoneBeaconInfo);
  public
    function GetKindofEddystones: TKindofEddystones;
    function GetEddystoneUID: TEddystoneUID;
    function GetEddystoneURL: TEddystoneURL;
    function GetEddystoneTLM: TEddystoneTLM;
  end;

  TBeAlive = procedure(const Sender: TObject) of object;

  TCommonBeaconManager = class(TBeaconManager)
  const
    /// <summary> Eddystone UID frame type </summary>
    EDDYSTONE_UID = $00;
    /// <summary> Eddystone URL frame type </summary>
    EDDYSTONE_URL = $10;
    /// <summary> Eddystone TLM frame type </summary>
    EDDYSTONE_TLM = $20;
    EDDY_NAMESPACE_MASK: TNamespace = ($0,$0,$0,$0,$0,$0,$0,$0,$0,$0);
    EDDY_INSTANCE_MASK: TInstance = ($0,$0,$0,$0,$0,$0);
    EDDY_FRAMETYPE_POS = 0;
    EDDY_TX_POS = 1;
    EDDY_URL_SCHEME_POS = 2;
    EDDY_SIGNAL_LOSS_METER: Byte = 41;
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
  private type
    TThreadScanner = class(TThread)
    private
      [Weak]FTManager: TBluetoothLEManager;
      FEvent: TEvent;
      FAliveEvent: TEvent;
      FTimeScanning: Integer;
  	  FTimeSleeping: Integer;
      FBluetoothLEScanFilterList: TBluetoothLEScanFilterList;
    public
      constructor Create(const ATManager: TBluetoothLEManager);
      destructor Destroy; override;
      procedure Execute; override;
    end;
    TThreadIsAlive = class(TThread)
    const
      FChekingTime = CHECKING_ALIVE_TIME;
    private
      FBeAlive: TBeAlive;
      FEvent: TEvent;
      FScannerEvent: TEvent;
    public
      constructor Create(ABeAlive: TBeAlive);
      destructor Destroy; override;
      procedure Execute; override;
    end;
  protected
    function DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons;
      AManufacturerId: Integer = MANUFATURER_ID_ALL): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean; overload; override;
    function DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
    function DoUnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon = TKindofBeacon.iBAltBeacons): Boolean; overload; override;
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
    function CreateScanFilters: TBluetoothLEScanFilterList;
    function GetNumberofBeaconsRegistered: Integer; override;
    procedure DoSetKindofBeacons(AValue: TKindofBeacons); override;
    function GeTKindofBeacons: TKindofBeacons; override;
    class function GetInstance(AMode: TBeaconScanMode): TBeaconManager; override;
  private
    FBeaconIDToRegisterList: TBeaconIDToRegisterList;
    FRssiAccumulatedDiff: Single;
    FThreadScanner: TThreadScanner;
    FThreadIsAlive: TThreadIsAlive;
    FManager: TBluetoothLEManager;
    FBeaconList: TBeaconList;
    FBeaconListLock: TObject;
    FCommonBeaconDeathTime: TDateTime;
    FCommonCalcMode: TBeaconCalcMode;
    FScanning: Boolean;
    procedure DiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice; Rssi: Integer; const ScanResponse: TScanResponse);
    procedure BeAlive(const Sender: TObject);
    function FRegisterBeacon(const ABeaconIDToRegister: TBeaconIDToRegister): Boolean;
    function FUnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Integer; const AKindofBeacon: TKindofBeacon;
      const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
  public
    constructor Create(AMode: TBeaconScanMode);
    destructor Destroy; override;
    property IsScanning: Boolean read FScanning;
  end;

  TStandardBeaconParser = class(TBeaconManufacturerDataParser)
  const
    BEACON_GUID_POSITION = 4;
    BEACON_TYPE_POSITION = 2;
    BEACON_MAJOR_POSITION = 20;
    BEACON_MINOR_POSITION = 22;
  public
    class function Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean; override;
  end;

  TAlternativeBeaconParser = class(TBeaconManufacturerDataParser)
  const
    BEACON_GUID_POSITION = 4;
    BEACON_TYPE_POSITION = 2;
    BEACON_MAJOR_POSITION = 20;
    BEACON_MINOR_POSITION = 22;
  public
    class function Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean; override;
  end;

{ TCommonBeacon }

constructor TCommonBeacon.create(const ARcCommonBeacon: TRcCommonBeacon);
begin
  FRBeacon := ARcCommonBeacon;
  FTimeAlive := Now;
end;

function TCommonBeacon.GetRssi: Integer;
begin
  TMonitor.Enter(Self);
  try
    Result := FRBeacon.Rssi;
  finally
    TMonitor.Exit(Self);
  end;
end;

function TCommonBeacon.GetDistance: Double;
begin
  TMonitor.Enter(Self);
  try
    Result := FRBeacon.Distance;
  finally
    TMonitor.Exit(Self);
  end;
end;

function TCommonBeacon.GetKindofBeacon: TKindofBeacon;
begin
  Result := FRBeacon.BeaconInfo.KindofBeacon;
end;

function TCommonBeacon.GetDeviceIdentifier: string;
begin
  Result := FRBeacon.BeaconInfo.DeviceIdentifier;
end;

function TCommonBeacon.IsEqualTo(const AGUID: TGUID; AMajor, AMinor: word): Boolean;
begin
  Result := ((FRBeacon.BeaconInfo.GUID = AGUID) and (FRBeacon.BeaconInfo.Major = AMajor) and (FRBeacon.BeaconInfo.Minor = AMinor));
end;

function TCommonBeacon.IsEqualTo(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
begin
  Result := CompareMem(@FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Namespace, @ANamespace, TCommonBeaconManager.EDDY_UID_NAMESPACE_LEN) and
     CompareMem(@FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Instance, @AInstance, TCommonBeaconManager.EDDY_UID_INSTANCE_LEN);
end;

function TCommonBeacon.IsEqualTo(const AIBeacon: IBeacon): Boolean;
var
  LIStandardBeacon: IStandardBeacon;
begin
  case AIBeacon.KindofBeacon of
    TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons:
     if (Supports(AIBeacon, IStandardBeacon, LIStandardBeacon)) then
       Result := IsEqualTo(LIStandardBeacon.GUID, LIStandardBeacon.Major, LIStandardBeacon.Minor)
     else
       Result := False;
    TKindofBeacon.Eddystones:  Result := (AIBeacon.DeviceIdentifier = FRBeacon.BeaconInfo.DeviceIdentifier);
    else
      Result := False;
  end;
end;

function TCommonBeacon.ItsAlive:Boolean;
begin
  TMonitor.Enter(Self);
  try
    Result := FIsAlive;
  finally
    TMonitor.Exit(Self);
  end;
end;

function TCommonBeacon.GetTxPower: Integer;
begin
  Result := FRBeacon.BeaconInfo.TxPower;
end;

function TCommonBeacon.GetProximity: TBeaconProximity;
begin
  TMonitor.Enter(Self);
  try
    Result := FRBeacon.Proximity;
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure TCommonBeacon.SetProximity(AProximity: TBeaconProximity);
begin
  FRBeacon.Proximity := AProximity;
end;

procedure TCommonBeacon.SetRssi(ARssi: Integer);
begin
   FRBeacon.Rssi := ARssi;
end;

procedure TCommonBeacon.SetDistance(ADistance: Double);
begin
  FRBeacon.Distance := ADistance;
end;

function TCommonBeacon.GetAdditionalData: TBytes;
begin
  TMonitor.Enter(Self);
  try
    SetLength(Result, 1);
    Result[0] := FRBeacon.BeaconInfo.AdditionalData;
  finally
    TMonitor.Exit(Self);
  end;
end;

function TCommonBeacon.GetGUID: TGUID;
begin
  Result := FRBeacon.BeaconInfo.GUID;
end;

function TCommonBeacon.GetMinor: Word;
begin
  Result := FRBeacon.BeaconInfo.Minor;
end;

function TCommonBeacon.GetMajor: Word;
begin
  Result := FRBeacon.BeaconInfo.Major;
end;

{ TAltBeacon }

function TAltBeacon.GetAltAdditionalData: Byte;
begin
  TMonitor.Enter(Self);
  try
    Result := FRBeacon.BeaconInfo.AdditionalData;
  finally
    TMonitor.Exit(Self);
  end;
end;

{ TCommonBeaconManager }

class function TCommonBeaconManager.GetInstance(AMode: TBeaconScanMode): TBeaconManager;
begin
  Result := TCommonBeaconManager.Create(AMode);
end;

function TCommonBeaconManager.GeTKindofBeacons: TKindofBeacons;
begin
  Result := FKindofBeacons;
end;

function TCommonBeaconManager.GetNumberofBeaconsRegistered: Integer;
begin
  if FBeaconIDToRegisterList <> nil then
    Result := FBeaconIDToRegisterList.Count
  else
    Result := 0;
end;

function TCommonBeaconManager.DoRegisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
var
  LBeaconIDToRegister: TBeaconIDToRegister;
begin
  if AKindofBeacon <> TKindofBeacon.Eddystones then
  begin
    LBeaconIDToRegister.BeaconsInRegion := 0;
    LBeaconIDToRegister.KindofBeacon := AKindofBeacon;
    LBeaconIDToRegister.GUID := AGUID;
    LBeaconIDToRegister.Major := MAJOR_REGION_ALL;
    LBeaconIDToRegister.Minor :=  MINOR_REGION_ALL;
    LBeaconIDToRegister.ManufacturerId := AManufacturerId;
    Result := FRegisterBeacon(LBeaconIDToRegister);
  end
  else
    Result := False;
end;

function TCommonBeaconManager.DoRegisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
var
  LBeaconIDToRegister: TBeaconIDToRegister;
begin
  if AKindofBeacon <> TKindofBeacon.Eddystones then
  begin
    LBeaconIDToRegister.BeaconsInRegion := 0;
    LBeaconIDToRegister.KindofBeacon := AKindofBeacon;
    LBeaconIDToRegister.GUID := AGUID;
    LBeaconIDToRegister.Major := AMajor;
    LBeaconIDToRegister.Minor :=  MINOR_REGION_ALL;
    LBeaconIDToRegister.ManufacturerId := AManufacturerId;
    Result := FRegisterBeacon(LBeaconIDToRegister);
  end
  else
    Result := False;
end;

function TCommonBeaconManager.DoRegisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon; AManufacturerId: Integer): Boolean;
var
  LBeaconIDToRegister: TBeaconIDToRegister;
begin
  if AKindofBeacon <> TKindofBeacon.Eddystones then
  begin
    LBeaconIDToRegister.BeaconsInRegion := 0;
    LBeaconIDToRegister.KindofBeacon := AKindofBeacon;
    LBeaconIDToRegister.GUID := AGUID;
    LBeaconIDToRegister.Major := AMajor;
    LBeaconIDToRegister.Minor :=  AMinor;
    LBeaconIDToRegister.ManufacturerId := AManufacturerId;
    Result := FRegisterBeacon(LBeaconIDToRegister);
  end
  else
    Result := False;
end;

function TCommonBeaconManager.DoRegisterEddyBeacon(const ANamespace: TNamespace): Boolean;
var
  LBeaconIDToRegister: TBeaconIDToRegister;
begin
  LBeaconIDToRegister.BeaconsInRegion := 0;
  LBeaconIDToRegister.KindofBeacon := TKindofBeacon.Eddystones;
  LBeaconIDToRegister.Namespace := ANamespace;
  LBeaconIDToRegister.Instance := EDDY_INSTANCE_MASK;
  LBeaconIDToRegister.AllInstances := True;
  Result := FRegisterBeacon(LBeaconIDToRegister);
end;

function TCommonBeaconManager.DoRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
var
  LBeaconIDToRegister: TBeaconIDToRegister;
begin
  LBeaconIDToRegister.BeaconsInRegion := 0;
  LBeaconIDToRegister.KindofBeacon := TKindofBeacon.Eddystones;
  LBeaconIDToRegister.Namespace := ANamespace;
  LBeaconIDToRegister.Instance := AInstance;
  LBeaconIDToRegister.AllInstances := False;
  Result := FRegisterBeacon(LBeaconIDToRegister);
end;

function TCommonBeaconManager.FRegisterBeacon(const ABeaconIDToRegister: TBeaconIDToRegister): Boolean;
var
  I: Integer;
  LDiscovering: Boolean;
  LNamespace: TNamespace;
  LInstance: TInstance;
begin
  Result := True;

  if FBeaconIDToRegisterList = nil then
    FBeaconIDToRegisterList := TBeaconIDToRegisterList.create;

  if FManager <> nil then
  begin
    LDiscovering := isScanning;
    if LDiscovering then
      DoStopScan;
  end
  else
    LDiscovering := False;

  I := 0;
  while I < FBeaconIDToRegisterList.Count do
  begin
    if FBeaconIDToRegisterList[I].KindofBeacon = ABeaconIDToRegister.KindofBeacon then
      if (ABeaconIDToRegister.KindofBeacon = TKindofBeacon.Eddystones)then
      begin
        LNamespace := FBeaconIDToRegisterList[I].Namespace;
        if CompareMem(@LNamespace, @ABeaconIDToRegister.Namespace, EDDY_UID_NAMESPACE_LEN) then
        begin
          LInstance := FBeaconIDToRegisterList[I].Instance;
          if CompareMem(@LInstance, @ABeaconIDToRegister.Instance, EDDY_UID_INSTANCE_LEN) then
            Result := False
          else
            FUnregisterBeacon(TGUID.Empty, 0, 0, ABeaconIDToRegister.KindofBeacon, ABeaconIDToRegister.Namespace, ABeaconIDToRegister.Instance);
          Break;
        end;
      end
      else
      begin
        if FBeaconIDToRegisterList[I].GUID = ABeaconIDToRegister.GUID then
        begin
          if (FBeaconIDToRegisterList[I].Major = ABeaconIDToRegister.Major) and (FBeaconIDToRegisterList[I].Minor = ABeaconIDToRegister.Minor) then
            Result := False
          else
            FUnregisterBeacon(ABeaconIDToRegister.GUID, MAJOR_REGION_ALL, MINOR_REGION_ALL, ABeaconIDToRegister.KindofBeacon, EDDY_NAMESPACE_MASK, EDDY_INSTANCE_MASK);
          Break;
        end;
      end;
    Inc(I);
  end;

  if Result then
    FBeaconIDToRegisterList.Add(ABeaconIDToRegister);

  if LDiscovering then
    DoStartScan;
end;

function TCommonBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := FUnregisterBeacon(AGUID, MAJOR_REGION_ALL, MINOR_REGION_ALL, AKindofBeacon, EDDY_NAMESPACE_MASK, EDDY_INSTANCE_MASK);
end;

function TCommonBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; AMajor: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := FUnregisterBeacon(AGUID, AMajor, MINOR_REGION_ALL, AKindofBeacon, EDDY_NAMESPACE_MASK, EDDY_INSTANCE_MASK);
end;

function TCommonBeaconManager.DoUnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Word; const AKindofBeacon: TKindofBeacon): Boolean;
begin
  Result := FUnregisterBeacon(AGUID, AMajor, AMinor, AKindofBeacon, EDDY_NAMESPACE_MASK, EDDY_INSTANCE_MASK);
end;

function TCommonBeaconManager.DoUnRegisterEddyBeacon(const ANamespace: TNamespace): Boolean;
begin
  Result := FUnregisterBeacon(TGUID.Empty, 0, 0, TKindofBeacon.Eddystones, ANamespace, EDDY_INSTANCE_MASK);
end;

function TCommonBeaconManager.DoUnRegisterEddyBeacon(const ANamespace: TNamespace; const AInstance: TInstance): Boolean;
begin
  Result := FUnregisterBeacon(TGUID.Empty, 0, 0, TKindofBeacon.Eddystones, ANamespace, AInstance);
end;

function TCommonBeaconManager.FUnregisterBeacon(const AGUID: TGUID; AMajor, AMinor: Integer; const AKindofBeacon: TKindofBeacon;
  const ANamespace: TNamespace; const AInstance: TInstance): Boolean;

  procedure BeaconListChecking;
  var
    I: Integer;
    LBLength: Integer;
    LTailElements: Integer;
    LIBeacon: IBeacon;
  begin
    if FBeaconList <> nil then
    begin
      LBLength := Length(FBeaconList);
      for I := LBLength - 1 downto 0 do
      begin
        if ((FBeaconList[I].KindofBeacon  = AKindofBeacon) or
          ((AKindofBeacon = TKindofBeacon.iBAltBeacons) and ((FBeaconList[I].KindofBeacon = TKindofBeacon.iBeacons) or
          (FBeaconList[I].KindofBeacon = TKindofBeacon.AltBeacons))))
          and (FBeaconList[I].GUID = AGUID) then
        begin
          LIBeacon := FBeaconList[I];
          (LIBeacon as TCommonBeacon).FIsAlive := False;
          LTailElements := LBLength - (I + 1);
          FBeaconList[I] := nil;
          if LTailElements > 0 then
            Move(FBeaconList[I + 1], FBeaconList[I], SizeOf(IBeacon) * LTailElements);
          Initialize(FBeaconList[LBLength - 1]);
          SetLength(FBeaconList, LBLength - 1);
          LBLength := Length(FBeaconList);
        end;
      end;
    end;
  end;

var
  I: Integer;
  LDiscovering: Boolean;
  LNamespace: TNamespace;
  LInstance: TInstance;
begin
  Result := False;
  I := 0;
  if FBeaconIDToRegisterList <> nil then
  begin
    if FManager <> nil then
    begin
      LDiscovering := (FManager.CurrentAdapter.State = TBluetoothAdapterState.Discovering);
      if LDiscovering then
        DoStopScan;
    end
    else
      LDiscovering := False;

    while I < FBeaconIDToRegisterList.Count do
    begin
      if (FBeaconIDToRegisterList[I].KindofBeacon  = AKindofBeacon) then
      begin
        if (AKindofBeacon = TKindofBeacon.Eddystones) then
        begin
           LNamespace := FBeaconIDToRegisterList[I].Namespace;
           LInstance := FBeaconIDToRegisterList[I].Instance;
          if CompareMem(@LNamespace, @ANamespace, EDDY_UID_NAMESPACE_LEN) then
          begin
            Result := True;
            FBeaconIDToRegisterList.Delete(I);
            BeaconListChecking;
            Break;
          end;
        end
        else
          if (FBeaconIDToRegisterList[I].Guid = AGuid) and ((AMajor = MAJOR_REGION_ALL) or ((FBeaconIDToRegisterList[I].Major = AMajor) and
             (AMinor = MINOR_REGION_ALL)) or ((FBeaconIDToRegisterList[I].Major = AMajor) and (FBeaconIDToRegisterList[I].Minor = AMinor))) then
          begin
            Result := True;
            FBeaconIDToRegisterList.Delete(I);
            BeaconListChecking;
            Break;
          end;
      end;
      Inc(I);
    end;

    if LDiscovering then
      DoStartScan;
  end;
end;

function TCommonBeaconManager.DoNearest: IBeacon;
var
  I: Word;
  LBLength: Word;
  LDistance: Double;
  LBeaconNum: Word;
begin
  if FBeaconList <> nil then
  begin
    I := 0;
    LBeaconNum := 0;
    LDistance := LDistance.MaxValue;
    TMonitor.Enter(FBeaconListLock);
    try
      LBLength := Length(FBeaconList);
      while I < LBLength do
      begin
        if FBeaconList[I].Distance < LDistance then
        begin
          LDistance := FBeaconList[I].Distance;
          LBeaconNum := I;
        end;
        Inc(I);
      end;
      Result := FBeaconList[LBeaconNum];
    finally
      TMonitor.Exit(FBeaconListLock);
    end;
  end;
end;

function TCommonBeaconManager.CreateScanFilters: TBluetoothLEScanFilterList;
var
  LBeaconManufacturerDataHelper: TBeaconManufacturerDataHelper;
  LBluetoothLEScanFilter: TBluetoothLEScanFilter;  
  LiBeaconFiltered: Boolean;
  LAltBeaconFiltered: Boolean;
  LBeaconIDToRegister: TBeaconIDToRegister;
  LTB: TBytes;
  I: Integer;

  function CreateMnfDataBeaconsFilter(const AGUIDToRegister: TBeaconIDToRegister): TBluetoothLEScanFilter;
  begin
    Result := TBluetoothLEScanFilter.Create;
    LBeaconManufacturerDataHelper.GUID := AGUIDToRegister.GUID;
    if AGUIDToRegister.Major > -1 then
      LBeaconManufacturerDataHelper.Major := AGUIDToRegister.Major;
    if AGUIDToRegister.Minor > -1 then
      LBeaconManufacturerDataHelper.Minor := AGUIDToRegister.Minor;
    LBeaconManufacturerDataHelper.BeaconType := AGUIDToRegister.KindofBeacon;
    LBeaconManufacturerDataHelper.ManufacturerId := AGUIDToRegister.ManufacturerId;
    Result.ManufacturerSpecificData := LBeaconManufacturerDataHelper.ToByteArray;
    Result.ManufacturerSpecificDataMask := LBeaconManufacturerDataHelper.MDataMask;
    DoNewBLEScanFilter(TKindofScanFilter.ManufacturerData, Result);
  end;

  function CreateServDataBeaconsFilter(const AGUIDToRegister: TBeaconIDToRegister; ARFU: Boolean): TBluetoothLEScanFilter;
  var
    LServiceDataRawData: TServiceDataRawData;
  begin
   Result := TBluetoothLEScanFilter.Create;
    Result.ServiceUUID := EDDYSTONE_SERVICE_UUID;
    LServiceDataRawData.Key := EDDYSTONE_SERVICE_UUID;
    LServiceDataRawData.Value := TBeaconManufacturerDataHelper.EDDY_UID_NAMESPACE_MASK;
    if not ARFU then
      SetLength(LServiceDataRawData.Value, Length(TBeaconManufacturerDataHelper.EDDY_UID_NAMESPACE_MASK) - EDDY_RFU_DATA_LEN);
    LServiceDataRawData.Value[EDDY_FRAMETYPE_POS] := EDDYSTONE_UID;
    Move(AGUIDToRegister.Namespace, LServiceDataRawData.Value[EDDY_UID_NAMESPACE_POS], EDDY_UID_NAMESPACE_LEN);
    if CompareMem(@AGUIDToRegister.Instance, @EDDY_INSTANCE_MASK, EDDY_UID_INSTANCE_LEN) then
    begin
      if ARFU then
        Result.ServiceDataMask := TBeaconManufacturerDataHelper.EDDY_UID_NAMESPACE_MASK
      else
      begin
        LTB := TBeaconManufacturerDataHelper.EDDY_UID_NAMESPACE_MASK;
        SetLength(LTB, Length(TBeaconManufacturerDataHelper.EDDY_UID_NAMESPACE_MASK) - EDDY_RFU_DATA_LEN);
        Result.ServiceDataMask := LTB;
      end;
    end
    else
    begin
      Move(AGUIDToRegister.Instance, LServiceDataRawData.Value[EDDY_UID_INSTANCE_POS], EDDY_UID_INSTANCE_LEN);
      if ARFU then
        Result.ServiceDataMask := TBeaconManufacturerDataHelper.EDDY_UID_INSTANCE_MASK
      else
      begin
        LTB := TBeaconManufacturerDataHelper.EDDY_UID_INSTANCE_MASK;
        SetLength(LTB, Length(TBeaconManufacturerDataHelper.EDDY_UID_INSTANCE_MASK) - EDDY_RFU_DATA_LEN);
        Result.ServiceDataMask := LTB;
      end;
    end;
    Result.ServiceData := LServiceDataRawData;
    DoNewBLEScanFilter(TKindofScanFilter.ServiceData, Result);
  end;

begin
  LiBeaconFiltered := False;
  LAltBeaconFiltered := False;
  Result := TBluetoothLEScanFilterList.Create;
  LBeaconManufacturerDataHelper := TBeaconManufacturerDataHelper.Create(ScanMode);
  try
    if FBeaconIDToRegisterList <> nil then
      for I := 0 to FBeaconIDToRegisterList.Count - 1 do
      begin
        case FScanMode  of
          TBeaconScanMode.Standard:
            if (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBeacons) or
              (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBAltBeacons) then
            begin
              LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(FBeaconIDToRegisterList[I]);
              Result.Add(LBluetoothLEScanFilter);
            end;

          TBeaconScanMode.Alternative:
            if (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.AltBeacons) or
              (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBAltBeacons) then
            begin
              LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(FBeaconIDToRegisterList[I]);
              Result.Add(LBluetoothLEScanFilter);
            end;

          TBeaconScanMode.Eddystone:
            if FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.Eddystones  then
            begin
              LBluetoothLEScanFilter := CreateServDataBeaconsFilter(FBeaconIDToRegisterList[I], True);
              Result.Add(LBluetoothLEScanFilter);
              LBluetoothLEScanFilter := CreateServDataBeaconsFilter(FBeaconIDToRegisterList[I], False);
              Result.Add(LBluetoothLEScanFilter);
            end;

          TBeaconScanMode.Extended:
            begin
              case FBeaconIDToRegisterList[I].KindofBeacon of
                TKindofBeacon.iBeacons:
                  if (TKindofBeacon.iBeacons in FKindofBeacons) then
                  begin
                    LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(FBeaconIDToRegisterList[I]);
                    LiBeaconFiltered := True;
                    Result.Add(LBluetoothLEScanFilter);
                  end;

                TKindofBeacon.AltBeacons:
                  if (TKindofBeacon.AltBeacons in FKindofBeacons) then
                  begin
                    LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(FBeaconIDToRegisterList[I]);
                    LAltBeaconFiltered := True;
                    Result.Add(LBluetoothLEScanFilter);
                  end;

                TKindofBeacon.iBAltBeacons:
                begin
                  if (TKindofBeacon.iBeacons in FKindofBeacons) then
                  begin
                    LBeaconIDToRegister := FBeaconIDToRegisterList[I];
                    LBeaconIDToRegister.KindofBeacon := TKindofBeacon.iBeacons;
                    LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(LBeaconIDToRegister);
                    LAltBeaconFiltered := True;
                    Result.Add(LBluetoothLEScanFilter);
                  end;
                  if (TKindofBeacon.AltBeacons in FKindofBeacons) then
                  begin
                    LBeaconIDToRegister := FBeaconIDToRegisterList[I];
                    LBeaconIDToRegister.KindofBeacon := TKindofBeacon.AltBeacons;
                    LBluetoothLEScanFilter := CreateMnfDataBeaconsFilter(LBeaconIDToRegister);
                    LAltBeaconFiltered := True;
                    Result.Add(LBluetoothLEScanFilter);
                  end;
                end;

                TKindofBeacon.Eddystones:
                  if (TKindofBeacon.Eddystones in FKindofBeacons) then
                  begin
                    LBluetoothLEScanFilter := CreateServDataBeaconsFilter(FBeaconIDToRegisterList[I], True);
                    Result.Add(LBluetoothLEScanFilter);
                    LBluetoothLEScanFilter := CreateServDataBeaconsFilter(FBeaconIDToRegisterList[I], False);
                    Result.Add(LBluetoothLEScanFilter);
                  end;
              end;
            end;
        end;

        LBeaconManufacturerDataHelper.RestartHelper;
      end;


    if (FScanMode = TBeaconScanMode.Extended) then
    begin
      if (TKindofBeacon.iBeacons in FKindofBeacons) and (not LiBeaconFiltered) then
      begin
        LBluetoothLEScanFilter := TBluetoothLEScanFilter.Create;
        LBluetoothLEScanFilter.ManufacturerSpecificData := TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK;
        LBluetoothLEScanFilter.ManufacturerSpecificData[BEACON_TYPE_POS] := WordRec(BEACON_ST_TYPE).Hi;
        LBluetoothLEScanFilter.ManufacturerSpecificData[BEACON_TYPE_POS + 1] := WordRec(BEACON_ST_TYPE).Lo;
        LBluetoothLEScanFilter.ManufacturerSpecificDataMask := TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK;
        DoNewBLEScanFilter(TKindofScanFilter.ManufacturerData, LBluetoothLEScanFilter);
        Result.Add(LBluetoothLEScanFilter);
      end;

      if (TKindofBeacon.AltBeacons in FKindofBeacons) and (not LAltBeaconFiltered) then
      begin
        LBluetoothLEScanFilter := TBluetoothLEScanFilter.Create;
        LTB := TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK;
        SetLength(LTB, Length(TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK) + 1);
        LBluetoothLEScanFilter.ManufacturerSpecificData := LTB;
        LBluetoothLEScanFilter.ManufacturerSpecificData[BEACON_TYPE_POS] := WordRec(BEACON_Al_TYPE).Hi;
        LBluetoothLEScanFilter.ManufacturerSpecificData[BEACON_TYPE_POS + 1] := WordRec(BEACON_Al_TYPE).Lo;
        LTB := TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK;
        SetLength(LTB, Length(TBeaconManufacturerDataHelper.TYPE_OF_BEACON_MASK) + 1);
        LBluetoothLEScanFilter.ManufacturerSpecificDataMask := LTB;
        DoNewBLEScanFilter(TKindofScanFilter.ManufacturerData, LBluetoothLEScanFilter);
        Result.Add(LBluetoothLEScanFilter);
      end;

  // ******** General Eddystone-UID Filter ********************
  //      if (TKindofBeacon.Eddystones in FKindofBeacons) then
  //      begin
  //        LBluetoothLEScanFilter := TBluetoothLEScanFilter.Create;
  //        LBluetoothLEScanFilter.ServiceUUID := EDDYSTONE_SERVICE_UUID;
  //        LServiceDataRawData.Key := EDDYSTONE_SERVICE_UUID;
  //        LServiceDataRawData.Value := EDDY_FRAME_UID_MASK;
  //        LServiceDataRawData.Value[EDDY_FRAMETYPE_POS] := EDDYSTONE_UID;
  //        LBluetoothLEScanFilter.ServiceData := LServiceDataRawData;
  //        LBluetoothLEScanFilter.ServiceDataMask := EDDY_FRAME_UID_MASK;
                                                                                  
  //        Result.Add(LBluetoothLEScanFilter);
  //      end;
    end;

    if (FScanMode = TBeaconScanMode.Eddystone) or
      ((FScanMode = TBeaconScanMode.Extended) and (TKindofBeacon.Eddystones in FKindofBeacons)) then
    begin
  // ******** Eddystone-Service Filter ********************
        LBluetoothLEScanFilter := TBluetoothLEScanFilter.Create;
        LBluetoothLEScanFilter.ServiceUUID := EDDYSTONE_SERVICE_UUID;
        DoNewBLEScanFilter(TKindofScanFilter.Service, LBluetoothLEScanFilter);
        Result.Add(LBluetoothLEScanFilter);

  // ******** General Eddystone-TLM Filter ********************
  //    if not Assigned(FOnNewEddystoneURL) then
  //    begin
  //      LBluetoothLEScanFilter := TBluetoothLEScanFilter.Create;
  //      LBluetoothLEScanFilter.ServiceUUID := EDDYSTONE_SERVICE_UUID;
  //      LServiceDataRawData.Key := EDDYSTONE_SERVICE_UUID;
  //      LServiceDataRawData.Value := EDDY_FRAME_TLM_MASK;
  //      LServiceDataRawData.Value[EDDY_FRAMETYPE_POS] := EDDYSTONE_TLM;
  //      LBluetoothLEScanFilter.ServiceData := LServiceDataRawData;
  //      LBluetoothLEScanFilter.ServiceDataMask := EDDY_FRAME_TLM_MASK;
                                                                                
  //      Result.Add(LBluetoothLEScanFilter);
  //     end;
    end;
  finally
    LBeaconManufacturerDataHelper.Free;
  end;
end;

function TCommonBeaconManager.DoStartScan: Boolean;
var
  LBluetoothLEScanFilterList: TBluetoothLEScanFilterList;
  I: Integer;
begin
  Result := False;
  if FManager = nil then
  begin
    FManager :=  TBluetoothLEManager.Current;
    FBeaconListLock := TObject.Create;
  end;
  DoStopScan;
  FManager.OnDiscoverLeDevice := DiscoverLEDevice;
  FCommonCalcMode := CalcMode;

  if (FScanMode = TBeaconScanMode.Extended) then
    Result := True
  else
    if((FBeaconIDToRegisterList <> nil) and (FBeaconIDToRegisterList.Count > 0)) then
      for I := 0 to FBeaconIDToRegisterList.Count - 1 do
        case FScanMode of
          TBeaconScanMode.Standard:
            if (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBeacons) or
               (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBAltBeacons) then
              begin
                Result := True;
                Break;
              end;
          TBeaconScanMode.Alternative:
            if (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.AltBeacons) or
               (FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.iBAltBeacons) then
              begin
                Result := True;
                Break;
              end;
          TBeaconScanMode.Eddystone:
            if FBeaconIDToRegisterList[I].KindofBeacon = TKindofBeacon.Eddystones then
              begin
                Result := True;
                Break;
              end;
        end;

  if not Result then
    raise EBeaconManagerException.Create(SBeaconNoDeviceRegister);

  FThreadIsAlive := TThreadIsAlive.Create(BeAlive);
  FCommonBeaconDeathTime := FBeaconDeathTime;

  FThreadScanner := TThreadScanner.Create(FManager);
  FThreadScanner.FTimeScanning := FScanningTime;
  FThreadScanner.FTimeSleeping := FScanningSleepingTime;

  FThreadScanner.FAliveEvent := FThreadIsAlive.FEvent;
  FThreadIsAlive.FScannerEvent := FThreadScanner.FEvent;

  LBluetoothLEScanFilterList := CreateScanFilters;
  FThreadScanner.FBluetoothLEScanFilterList := LBluetoothLEScanFilterList;

  FThreadIsAlive.Start;
  FThreadScanner.Start;

  Result := True;
  FScanning := Result;
end;

function TCommonBeaconManager.DoStopScan: Boolean;
begin
  Result := False;
  if (FManager <> nil) then
  begin
    FManager.OnDiscoverLeDevice := nil;
    if (FThreadScanner <> nil) then
    begin
      FThreadScanner.DisposeOf;
      FThreadScanner := nil;
      Result := True;
    end;

    if (FThreadIsAlive <> nil) then
    begin
      FThreadIsAlive.DisposeOf;
      FThreadIsAlive := nil;
    end;

    FManager.CancelDiscovery;
  end;
  FScanning := False;
end;

procedure TCommonBeaconManager.SetBeaconType(AValue: Word);
begin
  if AValue <> FBeaconType then
    FBeaconType := AValue;
end;

procedure TCommonBeaconManager.DoSetKindofBeacons(AValue: TKindofBeacons);
begin
  if AValue <> FKindofBeacons then
    FBeaconList := nil;
  FKindofBeacons := AValue;
end;

procedure TCommonBeaconManager.SetBeaconDeathTime(AValue: Integer);
begin
  FBeaconDeathTime := AValue;
end;

procedure TCommonBeaconManager.SetScanningSleepingTime(AValue: Integer);
begin
  FScanningSleepingTime := AValue;
end;

procedure TCommonBeaconManager.SetScanningTime(AValue: Integer);
begin
  FScanningTime := AValue;
end;

procedure TCommonBeaconManager.SetSPC(AValue: Single);
begin
  FSPC := AValue;
end;

destructor TCommonBeaconManager.Destroy;
begin
  DoStopScan;
  FBeaconIDToRegisterList.Free;
  FBeaconListLock.Free;
  FManufacturerDataParsers.Free;
  inherited;
end;

function BeaconIDToBeaconRegion(const AValue: TBeaconIDToRegister): TBeaconsRegion;
begin
  Result.KindofBeacon := AValue.KindofBeacon;
  case Result.KindofBeacon of
    TKindofBeacon.Eddystones:
      if AValue.AllInstances then
        Result.EddysUIDRegion.Initialize(AValue.Namespace)
      else
        Result.EddysUIDRegion.Initialize(AValue.Namespace, AValue.Instance);
    TKindofBeacon.iBeacons, TKindofBeacon.AltBeacons, TKindofBeacon.iBAltBeacons:
      Result.iBAltBeaconRegion.Initialize(AValue.GUID, AValue.Major, AValue.Minor, AValue.KindofBeacon, AValue.ManufacturerId);
  end;
end;

procedure TCommonBeaconManager.DiscoverLEDevice(const Sender: TObject; const ADevice: TBluetoothLEDevice;
          Rssi: Integer; const ScanResponse: TScanResponse);

  function RssiToProximity(const ABeacon: TCommonBeacon; ARssiValue: Integer; var AProximity: TBeaconProximity): Double;
  var
    LDistance: Double;
    LBeaconListLength: Integer;
    LRSSIDiff: Integer;
    LDistanceCalculated: Boolean;
  begin
    if ABeacon.FRBeacon.BeaconInfo.EddystoneBeacon.LastKindofEddystone <> TKindofEddystone.TLM then
    begin
      LDistanceCalculated := DoBeaconCalcDistance(ABeacon, ABeacon.txPower, ARssiValue, LDistance);
      if Not LDistanceCalculated then
        LDistanceCalculated := DoBeaconCalcDistance(ABeacon.GetGUID, ABeacon.GetMajor, ABeacon.GetMinor, ABeacon.txPower,
          ARssiValue, LDistance);

      if Not LDistanceCalculated then
      begin
        if FCommonCalcMode = TBeaconCalcMode.Stabilized then
        begin
          if not ABeacon.FRBeacon.RssiMean.IsEmpty then
          begin // "Differential Filter", it detects when we are in movement.
            LRSSIDiff := Abs(ABeacon.FRBeacon.LastMRSSI - ARssiValue);
            LBeaconListLength := Length(FBeaconList);
            if LBeaconListLength > 0 then
              FRssiAccumulatedDiff := ((FRssiAccumulatedDiff / LBeaconListLength) * (LBeaconListLength - 1)) + LRSSIDiff / LBeaconListLength;
          end;
         ARssiValue := ABeacon.FRBeacon.RssiMean.AddGetValue(ARssiValue, FRssiAccumulatedDiff >= DIFFERENTIAL_FILTER_BOUNDARY);
        end;

        ABeacon.FRBeacon.LastMRSSI := ARssiValue;
        LDistance := System.Math.RoundTo(FManager.RssiToDistance(ARssiValue, ABeacon.GettxPower, SPC), DISTANCE_DECIMALS);
      end;

      Result  := LDistance;

      if Result < PROXIMITY_IMMEDIATE then
        AProximity := TBeaconProximity(Immediate)
      else
        if Result < PROXIMITY_NEAR then
          AProximity := TBeaconProximity(Near)
        else
          if Result < PROXIMITY_FAR then
            AProximity := TBeaconProximity(Far)
          else
            AProximity := TBeaconProximity(Away);
    end
    else
      Result := ABeacon.FRBeacon.Distance;
  end;

  function BelongsToRegion(const ARcCommonBeacon: TRcCommonBeacon; var LRegionID: Integer): Boolean;
  var
    LNamespace: TNamespace;
    LInstance: TInstance;
    LScannable: Boolean;
    LKindofBeaconInRegisterList: Boolean;
  begin
    LRegionID := 0;
    Result := False;
    LKindofBeaconInRegisterList := False;

    if FBeaconIDToRegisterList <> nil then
      while LRegionID < FBeaconIDToRegisterList.Count do
      begin
         LScannable := False;
         case FBeaconIDToRegisterList[LRegionID].KindofBeacon of
           TKindofBeacon.iBeacons:
             begin
               if (TKindofBeacon.iBeacons = ARcCommonBeacon.BeaconInfo.KindofBeacon) then
                 if (ScanMode = TBeaconScanMode.Standard) or ((ScanMode = TBeaconScanMode.Extended) and
                    ((TKindofBeacon.iBeacons in FKindofBeacons) or (TKindofBeacon.iBAltBeacons in FKindofBeacons))) then
                 begin
                   LKindofBeaconInRegisterList := True;
                   LScannable := True;
                 end;
             end;
           TKindofBeacon.AltBeacons:
             begin
               if (TKindofBeacon.AltBeacons = ARcCommonBeacon.BeaconInfo.KindofBeacon) then
                 if (ScanMode = TBeaconScanMode.Alternative) or ((ScanMode = TBeaconScanMode.Extended) and
                    ((TKindofBeacon.AltBeacons in FKindofBeacons) or (TKindofBeacon.iBAltBeacons in FKindofBeacons))) then
                 begin
                   LKindofBeaconInRegisterList := True;
                   LScannable := True;
                 end;
             end;
           TKindofBeacon.iBAltBeacons:
               case ScanMode of
                 Standard:
                   if ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.iBeacons then
                   begin
                     LKindofBeaconInRegisterList := True;
                     LScannable := True;
                   end;
                 Alternative:
                   if ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.AltBeacons then
                   begin
                     LKindofBeaconInRegisterList := True;
                     LScannable := True;
                   end;
                 Extended:
                   if ((ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.iBeacons) and
                     (TKindofBeacon.iBeacons in FKindofBeacons))
                     or ((ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.AltBeacons) and
                     (TKindofBeacon.AltBeacons in FKindofBeacons)) then
                   begin
                     LKindofBeaconInRegisterList := True;
                     LScannable := True;
                   end;
               end;
           TKindofBeacon.Eddystones:
             begin
               if (TKindofBeacon.Eddystones = ARcCommonBeacon.BeaconInfo.KindofBeacon) and
                 (TKindofEddystone.UID in ARcCommonBeacon.BeaconInfo.EddystoneBeacon.KindofEddystones) then
                 if (ScanMode = TBeaconScanMode.Eddystone) or ((ScanMode = TBeaconScanMode.Extended) and
                    (TKindofBeacon.Eddystones in FKindofBeacons)) then
                 begin
                   LKindofBeaconInRegisterList := True;
                   LScannable := True;
                 end;
             end;
         end;

        if LScannable then
          if ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.Eddystones  then
          begin
            LNamespace := FBeaconIDToRegisterList[LRegionID].Namespace;
            LInstance := FBeaconIDToRegisterList[LRegionID].Instance;
            if CompareMem(@ARcCommonBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Namespace, @LNamespace, EDDY_UID_NAMESPACE_LEN) then
              if FBeaconIDToRegisterList[LRegionID].AllInstances or                                                                                           
                CompareMem(@ARcCommonBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Instance, @LInstance, EDDY_UID_INSTANCE_LEN) then
              begin
                Result := True;
                Break;
              end;
          end
          else
            if FBeaconIDToRegisterList[LRegionID].Guid = ARcCommonBeacon.BeaconInfo.Guid then
            begin
              if (FBeaconIDToRegisterList[LRegionID].Major = MAJOR_REGION_ALL) then                                                                                          
                Result := True
              else
                if (FBeaconIDToRegisterList[LRegionID].Major = ARcCommonBeacon.BeaconInfo.Major) then
                  if (FBeaconIDToRegisterList[LRegionID].Minor = MINOR_REGION_ALL) then
                    Result := True
                  else
                    if (FBeaconIDToRegisterList[LRegionID].Minor = ARcCommonBeacon.BeaconInfo.Minor) then
                      Result := True;
              break;
            end;

        Inc(LRegionID);
      end;

    if (not Result) and (not LKindofBeaconInRegisterList) and ((FScanMode = TBeaconScanMode.Eddystone) or
      (FScanMode = TBeaconScanMode.Extended) and (ARcCommonBeacon.BeaconInfo.KindofBeacon in FKindofBeacons)) then
    begin
      LRegionID := -1;
      Result := True;
    end;
  end;

  function BeaconInList(const ARcCommonBeacon: TRcCommonBeacon; var ListID: Word): Boolean;
  var
    Handler: IEddystoneBeacon;
  begin
     Result := False;
     ListID := 0;
     while ListID < Length(FBeaconList) do
     begin
       if FBeaconList[ListID].KindofBeacon = ARcCommonBeacon.BeaconInfo.KindofBeacon then
         if ARcCommonBeacon.BeaconInfo.KindofBeacon = TKindofBeacon.Eddystones then
         begin
           if (ARcCommonBeacon.BeaconInfo.EddystoneBeacon.LastKindofEddystone = TKindofEddystone.UID) and
             (Supports(FBeaconList[ListID], IEddystoneBeacon, Handler)) and
             (TKindofEddystone.UID in Handler.KindofEddystones) then
           begin
             if FBeaconList[ListID].IsEqualTo(ARcCommonBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Namespace,
               ARcCommonBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID.Instance) then
             begin
               Result := True;
               Break;
             end;
           end
           else
             if FBeaconList[ListID].DeviceIdentifier = ARcCommonBeacon.BeaconInfo.DeviceIdentifier then
             begin
               Result := True;
               Break;
             end;

         end
         else
           if FBeaconList[ListID].IsEqualTo(ARcCommonBeacon.BeaconInfo.GUID,
             ARcCommonBeacon.BeaconInfo.Major, ARcCommonBeacon.BeaconInfo.Minor) then
           begin
             Result := True;
             Break;
           end;
       Inc(ListID);
     end;
  end;

  function InitBeacon(const ABeacon: TBeaconInfo): TRcCommonBeacon;
  begin
    Result.BeaconInfo.GUID := ABeacon.GUID;
    Result.BeaconInfo.Major := ABeacon.Major;
    Result.BeaconInfo.Minor := ABeacon.Minor;
    Result.BeaconInfo.TxPower := ABeacon.TxPower;
    Result.BeaconInfo.AdditionalData := ABeacon.AdditionalData;
    Result.RssiMean := TMeanCalculator<Integer>.Create(RSSI_MEAN_ITEMS);
    Result.BeaconInfo.KindofBeacon := ABeacon.KindofBeacon;
    Result.BeaconInfo.EddystoneBeacon := ABeacon.EddystoneBeacon;
    Result.BeaconInfo.DeviceIdentifier := ABeacon.DeviceIdentifier;
  end;

  function GetBeaconData(var ABeaconData: TRcCommonBeacon): Boolean;
  var
    LBeaconInfo: TBeaconInfo;
    LMData: TBytes;
    LSData: TServiceDataRawData;
    LBeaconType: Word;
    I: Integer;
    LEddystoneBeacon: TEddystoneBeaconInfo;
  begin
    Result := False;
    LMData := ADevice.ScannedAdvertiseData.ManufacturerSpecificData;
    LSData.Key := TGUID.Empty;

    if (FScanMode <> TBeaconScanMode.Eddystone) then
    begin
      if Length(LMData) > 0 then
      begin
        LBeaconInfo.EddystoneBeacon.EddystoneUID.Namespace := EDDY_NAMESPACE_MASK;
        LBeaconInfo.EddystoneBeacon.EddystoneUID.Instance := EDDY_INSTANCE_MASK;
        DoParseManufacturerData(LMData, LBeaconInfo, Result);
        if (not Result) and (ManufacturerDataParsers <> nil) and (ManufacturerDataParsers.Parse(LMData, LBeaconInfo)) then
          Result := True;
      end;

      if (not Result) and (Length(LMData) >= STANDARD_DATA_LENGTH) then
      begin
          LBeaconType := Swap(PWord(@LMData[TStandardBeaconParser.BEACON_TYPE_POSITION])^);

          if (FScanMode = TBeaconScanMode.Extended) then
          begin
            if (LBeaconType = BEACON_ST_TYPE) then
              Result := TStandardBeaconParser.Parse(LMData, LBeaconInfo)
             else
               if (LBeaconType = BEACON_AL_TYPE) then
                 Result := TAlternativeBeaconParser.Parse(LMdata, LBeaconInfo);
          end
          else
            if (LBeaconType = FBeaconType) then
              if (FScanMode = TBeaconScanMode.Standard) then
                Result := TStandardBeaconParser.Parse(LMData, LBeaconInfo)
               else
                 if (FScanMode = TBeaconScanMode.Alternative) then
                   Result := TAlternativeBeaconParser.Parse(LMdata, LBeaconInfo);
      end;
    end;

    if (not Result) and ((FScanMode = TBeaconScanMode.Eddystone) or
       ((FScanMode = TBeaconScanMode.Extended) and (TKindofBeacon.Eddystones in FKindofBeacons))) then
    begin
      if (Length(ADevice.ScannedAdvertiseData.ServiceData) > 0) then
      begin
        LSData := ADevice.ScannedAdvertiseData.ServiceData[0];
        DoParseServiceData(LSData, LBeaconInfo, Result);
                                              
        //      if (not Result) and (ServicesDataParsers <> nil) and (ServicesDataParsers.Parse(LSData, LBeaconInfo)) then
        //        Result := True;
      end;

      if (not Result) and (LSData.key = EDDYSTONE_SERVICE_UUID) then
      begin
        LBeaconInfo.GUID := TGUID.Empty;
        LBeaconInfo.Major := 0;
        LBeaconInfo.Minor := 0;
        LBeaconInfo.BeaconType := 0;
        LBeaconInfo.KindofBeacon := TKindofBeacon.Eddystones;

        if (Length(LSData.Value) > 0) then
          case LSData.Value[EDDY_FRAMETYPE_POS] of

            EDDYSTONE_UID:
              begin
                if Length(LSData.Value) >= (EDDY_UID_LEN - EDDY_RFU_DATA_LEN) then
                begin
                  LBeaconInfo.TxPower :=  ShortInt(LSData.Value[EDDY_TX_POS] - EDDY_SIGNAL_LOSS_METER);
                  Move(LSData.Value[EDDY_UID_NAMESPACE_POS], LEddystoneBeacon.EddystoneUID.Namespace[0], EDDY_UID_NAMESPACE_LEN);
                  Move(LSData.Value[EDDY_UID_INSTANCE_POS], LEddystoneBeacon.EddystoneUID.Instance[0], EDDY_UID_INSTANCE_LEN);
                  if Length(LSData.Value) = (EDDY_UID_LEN) then
                  begin
                    SetLength(LEddystoneBeacon.AdditionalData,word.Size);
                    LEddystoneBeacon.AdditionalData[0] := Swap(PWord(@LSData.Value[EDDY_RFU_DATA_POS])^);
                  end;
                  LEddystoneBeacon.KindofEddystones := [TKindofEddystone.UID];
                  LEddystoneBeacon.LastKindofEddystone := TKindofEddystone.UID;
                  LBeaconInfo.EddystoneBeacon := LEddystoneBeacon;
                  Result := True;
                end;
              end;

            EDDYSTONE_URL:
              begin
                if Length(LSData.Value) >= EDDY_MIN_URL_LEN then
                begin
                  LBeaconInfo.TxPower :=  ShortInt(LSData.Value[EDDY_TX_POS] - EDDY_SIGNAL_LOSS_METER);
                  if (Length(LSData.Value) - EDDY_MIN_URL_LEN) > 0 then
                  begin
                    I := Length(LSData.Value) - EDDY_URL_SCHEME_POS;
                    SetLength(LEddystoneBeacon.EddystoneURL.EncodedURL, I);
                    Move(LSData.Value[EDDY_URL_SCHEME_POS], LEddystoneBeacon.EddystoneURL.EncodedURL[0], I);
                  end;
                end;
                LEddystoneBeacon.EddystoneURL.URL := LEddystoneBeacon.EddystoneURL.URLToString;
                LEddystoneBeacon.KindofEddystones := [TKindofEddystone.URL];
                LEddystoneBeacon.LastKindofEddystone := TKindofEddystone.URL;
                LBeaconInfo.EddystoneBeacon := LEddystoneBeacon;
                Result := True;
              end;

            EDDYSTONE_TLM:
              begin
                if Length(LSData.Value) = (EDDY_TLM_LEN) then
                begin
                  Move(LSData.Value[EDDY_TLM_VERSION_POS], LEddystoneBeacon.EddystoneTLM.EncodedTLM[0], EDDY_TLM_LEN - EDDY_TLM_VERSION_POS);
                  LEddystoneBeacon.EddystoneTLM.BattVoltage := Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_BATTVOLTAGE_POS - EDDY_TLM_VERSION_POS])^);
                  LEddystoneBeacon.EddystoneTLM.BeaconTemp := Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_BEACONTEMP_POS - EDDY_TLM_VERSION_POS])^);
                  LEddystoneBeacon.EddystoneTLM.AdvPDUCount := (Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_ADVPDUCOUNT_POS - EDDY_TLM_VERSION_POS])^) shl 16) or
                    (Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_ADVPDUCOUNT_POS + (2 - EDDY_TLM_VERSION_POS)])^));
                  LEddystoneBeacon.EddystoneTLM.TimeSincePowerOn := (Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_TIMESINCEPOWERON_POS - EDDY_TLM_VERSION_POS])^) shl 16) or
                    (Swap(PWord(@LEddystoneBeacon.EddystoneTLM.EncodedTLM[EDDY_TLM_TIMESINCEPOWERON_POS + (2 - EDDY_TLM_VERSION_POS)])^));
                  LEddystoneBeacon.KindofEddystones := [TKindofEddystone.TLM];
                  LEddystoneBeacon.LastKindofEddystone := TKindofEddystone.TLM;
                  LBeaconInfo.EddystoneBeacon := LEddystoneBeacon;
                  Result := True;
                end;
              end;
          end;

      end;
    end;

    if Result then
    begin
      LBeaconInfo.DeviceIdentifier := ADevice.Identifier;
      ABeaconData := InitBeacon(LBeaconInfo);
    end;
  end;

  procedure CheckBeaconData(var ABeaconData: TRcCommonBeacon);
  var
    LTXPower: ShortInt;
    LCheckTxPower: Boolean;
  begin
    case ABeaconData.BeaconInfo.KindofBeacon of
      Eddystones:
       LCheckTxPower := (UID in ABeaconData.BeaconInfo.EddystoneBeacon.KindofEddystones)
          or (URL in ABeaconData.BeaconInfo.EddystoneBeacon.KindofEddystones);
      else
        LCheckTxPower := True;
    end;

    if LCheckTxPower then
    begin
      if ABeaconData.BeaconInfo.TxPower > -EDDY_SIGNAL_LOSS_METER then
      begin
        LTXPower := ABeaconData.BeaconInfo.TxPower;
        ABeaconData.BeaconInfo.TxPower := -EDDY_SIGNAL_LOSS_METER;
        DoBeaconError(TBeaconError.IncorrectTxPower, Format(SIncorrectTxPower,[LTXPower]), ABeaconData.BeaconInfo);
      end;
    end;

  end;

var
  ListID: Word;
  LRcCommonBeacon: TRcCommonBeacon;
  LEddystoneBeaconInfo: TEddystoneBeaconInfo;
  LNewEddystoneBeaconInfo: TEddystoneBeaconInfo;
  LRegion: TBeaconIDToRegister;
  LBeacon: TCommonBeacon;
  LIBeacon: IBeacon;
  LRaiseProximityEvent: Boolean;
  LRssi: Integer;
  LDistance: Double;
  LProximity: TBeaconProximity;
  LRegionID: Integer;
  LMData: TBytes;
  LNewEddyURL: Boolean;
  LNewEddyTLM: Boolean;
  Handler: IEddystoneBeacon;
begin
  LNewEddyURL := False;
  LNewEddyTLM := False;
  LBeacon := nil;

  LMData := ADevice.ScannedAdvertiseData.ManufacturerSpecificData;

  if GetBeaconData(LRcCommonBeacon) then
  begin
    CheckBeaconData(LRcCommonBeacon);
    TMonitor.Enter(FBeaconListLock);
    try
      if BelongsToRegion(LRcCommonBeacon, LRegionID) then
        if BeaconInList(LRcCommonBeacon, ListID) then
        begin
          LBeacon := (FBeaconList[ListID] as TCommonBeacon);
          LRssi := Rssi;
          LDistance := RssiToProximity(LBeacon, LRssi, LProximity);

          if LProximity = LBeacon.Proximity then
            LRaiseProximityEvent := False
          else
            LRaiseProximityEvent:= True;

          TMonitor.Enter(LBeacon);
          try
            LBeacon.Rssi := LRssi;
            LBeacon.Distance := LDistance;
            LBeacon.Proximity := LProximity;
            LBeacon.TimeAlive := Now;

            if (LBeacon.GetKindofBeacon = TKindofBeacon.Eddystones) and (Supports(LBeacon, IEddystoneBeacon, Handler)) then
            begin
              LEddystoneBeaconInfo := TEddystoneBeacon(Handler).GetEddystoneBeacon;
              LNewEddystoneBeaconInfo := LRcCommonBeacon.BeaconInfo.EddystoneBeacon;
              case LNewEddystoneBeaconInfo.LastKindofEddystone of
                TKindofEddystone.URL:
                  if LEddystoneBeaconInfo.EddystoneURL.URL <> LNewEddystoneBeaconInfo.EddystoneURL.URL then
                  begin
                    LEddystoneBeaconInfo.EddystoneURL := LNewEddystoneBeaconInfo.EddystoneURL;
                    LNewEddyURL := True
                  end;
                TKindofEddystone.UID: LEddystoneBeaconInfo.EddystoneUID := LNewEddystoneBeaconInfo.EddystoneUID;
                TKindofEddystone.TLM:
                begin
                   LEddystoneBeaconInfo.EddystoneTLM := LNewEddystoneBeaconInfo.EddystoneTLM;
                   LNewEddyTLM := True;
                end;
              end;
             LEddystoneBeaconInfo.KindofEddystones := LEddystoneBeaconInfo.KindofEddystones +
               [LNewEddystoneBeaconInfo.LastKindofEddystone];
              TEddystoneBeacon(Handler).SetEddystoneBeacon(LEddystoneBeaconInfo);
            end;

          finally
            TMonitor.Exit(LBeacon);
          end;
          if LRaiseProximityEvent then
            DoBeaconChangedProximity(LBeacon, TBeaconProximity(LProximity));
        end
        else
        begin
          LRcCommonBeacon.Rssi := Rssi;
          case LRcCommonBeacon.BeaconInfo.KindofBeacon of
            TKindofBeacon.iBeacons: LIBeacon :=  TiBeacon.create(LRcCommonBeacon);
            TKindofBeacon.AltBeacons: LIBeacon :=  TAltBeacon.create(LRcCommonBeacon);
            TKindofBeacon.Eddystones:
              begin
                LIBeacon :=  TEddystoneBeacon.create(LRcCommonBeacon);
                if LRcCommonBeacon.BeaconInfo.EddystoneBeacon.LastKindofEddystone = TKindofEddystone.URL then
                  LNewEddyURL := True
                else
                  if LRcCommonBeacon.BeaconInfo.EddystoneBeacon.LastKindofEddystone = TKindofEddystone.TLM then
                    LNewEddyTLM := True;
              end;
          end;
          LBeacon := LIBeacon as TCommonBeacon;
          LBeacon.FregionID := LRegionID;
          LBeacon.FIsAlive := True;
          setLength(FBeaconList, length(FBeaconList) + 1);
          FBeaconList[length(FBeaconList) - 1] := LIBeacon;
          LBeacon.Distance := RssiToProximity(LBeacon, Rssi, LBeacon.FRBeacon.Proximity);

          if LRegionID > -1 then
          begin
            LRegion := FBeaconIDToRegisterList[LRegionID];
            if LRegion.BeaconsInRegion = 0 then
            begin
              DoBeaconsRegionEnter(BeaconIDToBeaconRegion(LRegion));
              case LRegion.KindofBeacon of
                iBeacons, AltBeacons, iBAltBeacons:
                  DoRegionEnter(LRegion.GUID, LRegion.Major, LRegion.Minor);
              end;
            end;

            Inc(LRegion.BeaconsInRegion);
            FBeaconIDToRegisterList[LRegionID] := LRegion;
          end;

          DoBeaconEnter(LIBeacon, FBeaconList);
        end;

      if LNewEddyURL and (LBeacon <> nil) then
        DoNewEddystoneURL(LBeacon, LBeacon.FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneURL);
      if LNewEddyTLM and (LBeacon <> nil) then
        DoNewEddystoneTLM(LBeacon, LBeacon.FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneTLM);
    finally
      TMonitor.Exit(FBeaconListLock);
    end;
  end;
end;

procedure TCommonBeaconManager.BeAlive(const Sender: TObject);
var
  ListId: Word;
  LBLength: Word;
  LTailElements: Word;
  LBeacon: TCommonBeacon;
  LIBeacon: IBeacon;
  LBeaconIDToRegister: TBeaconIDToRegister;
  SEC: Integer;
begin
  ListId := 0;
  if FBeaconList <> nil then
  begin
    TMonitor.Enter(FBeaconListLock);
    try
      LBLength := Length(FBeaconList);

      while ListId < LBLength do
      begin
        LIBeacon := FBeaconList[ListId];
        LBeacon := LiBeacon as TCommonBeacon;
        SEC := SecondsBetween(now, LBeacon.TimeAlive);
        if SEC > FCommonBeaconDeathTime  then
        begin
          TMonitor.Enter(LBeacon);
          try
            LTailElements := LBLength - (ListId + 1);
            FBeaconList[ListId] := nil;
            if LTailElements > 0 then
              Move(FBeaconList[ListId + 1], FBeaconList[ListId], SizeOf(IBeacon) * LTailElements);
            Initialize(FBeaconList[LBLength - 1]);
            SetLength(FBeaconList, LBLength - 1);
            LBLength := Length(FBeaconList);
            if LBeacon.RegionID > -1 then
            begin
              LBeaconIDToRegister := FBeaconIDToRegisterList[LBeacon.RegionID];
              Dec(LBeaconIDToRegister.BeaconsInRegion);
              if LBeaconIDToRegister.BeaconsInRegion = 0 then
              begin
                DoBeaconsRegionExit(BeaconIDToBeaconRegion(LBeaconIDToRegister));
                case LBeaconIDToRegister.KindofBeacon of
                  iBeacons, AltBeacons, iBAltBeacons:
                    DoRegionExit(LBeaconIDToRegister.GUID, LBeaconIDToRegister.Major, LBeaconIDToRegister.Minor);
                end;
              end;
              FBeaconIDToRegisterList[LBeacon.RegionID] := LBeaconIDToRegister;
            end;
            LBeacon.FIsAlive := False;
          finally
            TMonitor.Exit(LBeacon);
          end;
          DoBeaconExit(LIBeacon, FBeaconList);
        end;
        Inc(ListId);
      end;

    finally
      TMonitor.Exit(FBeaconListLock);
    end;
  end;

end;

constructor TCommonBeaconManager.Create(AMode: TBeaconScanMode);
begin
  if FScanMode <> AMode then
    FBeaconList := nil;
  FScanMode := AMode;
  case AMode of
    TBeaconScanMode.Standard: FBeaconType := BEACON_ST_TYPE;
    TBeaconScanMode.Alternative: FBeaconType := BEACON_AL_TYPE;
  end;
  FRssiAccumulatedDiff := ACCUMMULATE_DIFF_START_VALUE;
  FBeaconDeathTime := KBEACONDEATHTIME;
  FScanningTime := SCANNING_TIME;
  FScanningSleepingTime := SCANNING_SLEEPINGTIME;
  FSPC := SIGNAL_PROPAGATION_CONSTANT;
  FCalcMode := TBeaconCalcMode.Stabilized;
  FManufacturerDataParsers := TBeaconManufacturerParsers.Create;
end;

{TCommonBeaconManager.TThreadScanner}

constructor TCommonBeaconManager.TThreadScanner.Create(const ATManager: TBluetoothLEManager);
begin
  inherited Create(True);
  FTmanager := ATManager;
  FEvent := TEvent.Create;
end;

destructor TCommonBeaconManager.TThreadScanner.Destroy;
var
  I: Integer;
begin
  Terminate;
  FEvent.SetEvent;
  inherited;
  FEvent.Free;
  for I := 0 to FBluetoothLEScanFilterList.Count - 1 do
    FBluetoothLEScanFilterList[I].DisposeOf;
  FBluetoothLEScanFilterList.Free;
  FAliveEvent := nil;
end;

procedure TCommonBeaconManager.TThreadScanner.Execute;
var
  LRefresh: Boolean;
begin
  LRefresh := True;
  while not Terminated do
  begin
    if FEvent.WaitFor(FTimeSleeping) = TWaitResult.wrTimeout then
    begin
      try
        FTManager.StartDiscoveryRaw(FBluetoothLEScanFilterList, LRefresh);
        LRefresh := False;
      except
        FAliveEvent.SetEvent;
        if Assigned(System.Classes.ApplicationHandleException) then
          System.Classes.ApplicationHandleException(Self)
        else
          raise;
        Terminate
      end;
    end
    else
    begin
      FTManager.CancelDiscovery;
      Terminate;
    end;

    if not Terminated then
      if FEvent.WaitFor(FTimeScanning) = TWaitResult.wrTimeout then
      begin
        try
          FTManager.CancelDiscovery;
        except
          FAliveEvent.SetEvent;
          if Assigned(System.Classes.ApplicationHandleException) then
            System.Classes.ApplicationHandleException(Self)
          else
            raise;
          Terminate
        end;
      end
      else
      begin
        FTManager.CancelDiscovery;
        Terminate;
      end;
  end;
end;

{TCommonBeaconManager.TThreadIsAlive}

constructor TCommonBeaconManager.TThreadIsAlive.Create(ABeAlive: TBeAlive);
begin
  inherited Create(True);
  FBeAlive := ABeAlive;
  FEvent := TEvent.Create;
end;

destructor TCommonBeaconManager.TThreadIsAlive.Destroy;
begin
  Terminate;
  FEvent.SetEvent;
  inherited;
  FEvent.Free;
  FScannerEvent := nil;
end;

procedure TCommonBeaconManager.TThreadIsAlive.Execute;
begin
  while not Terminated do
  	if FEvent.WaitFor(FChekingTime) = TWaitResult.wrTimeout then
    begin
      try
        FBeAlive(nil);
      except
        FScannerEvent.SetEvent;
        if Assigned(System.Classes.ApplicationHandleException) then
          System.Classes.ApplicationHandleException(Self)
        else
          raise;
        Terminate;
      end;
    end
    else
      Terminate;
end;

{ TStandardBeaconParser }

class function TStandardBeaconParser.Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean;
begin
  Result := False;
  if Length(AData) = STANDARD_DATA_LENGTH then
  begin
    BeaconInfo.KindofBeacon := TKindofBeacon.iBeacons;
    BeaconInfo.GUID := TGUID.Create(AData[BEACON_GUID_POSITION], TEndian.Big);
    WordRec(BeaconInfo.BeaconType).Hi := Adata[BEACON_TYPE_POSITION];
    WordRec(BeaconInfo.BeaconType).Lo := Adata[BEACON_TYPE_POSITION + 1];
    WordRec(BeaconInfo.Major).Hi := Adata[BEACON_MAJOR_POSITION];
    WordRec(BeaconInfo.Major).Lo := Adata[BEACON_MAJOR_POSITION + 1];
    WordRec(BeaconInfo.Minor).Hi := Adata[BEACON_MINOR_POSITION];
    WordRec(BeaconInfo.Minor).Lo := Adata[BEACON_MINOR_POSITION + 1];
    BeaconInfo.TxPower := ShortInt(AData[Length(AData) - 1]);
    Result := True;
  end;
end;

{ TAlternativeBeaconParser }

class function TAlternativeBeaconParser.Parse(const AData: TBytes; var BeaconInfo: TBeaconInfo): Boolean;
begin
  Result := False;
  if Length(AData) = ALTERNATIVE_DATA_LENGTH then
  begin
    BeaconInfo.KindofBeacon := TKindofBeacon.AltBeacons;
    BeaconInfo.GUID := TGUID.Create(AData[BEACON_GUID_POSITION], TEndian.Big);
    WordRec(BeaconInfo.BeaconType).Hi := Adata[BEACON_TYPE_POSITION];
    WordRec(BeaconInfo.BeaconType).Lo := Adata[BEACON_TYPE_POSITION + 1];
    WordRec(BeaconInfo.Major).Hi := Adata[BEACON_MAJOR_POSITION];
    WordRec(BeaconInfo.Major).Lo := Adata[BEACON_MAJOR_POSITION + 1];
    WordRec(BeaconInfo.Minor).Hi := Adata[BEACON_MINOR_POSITION];
    WordRec(BeaconInfo.Minor).Lo := Adata[BEACON_MINOR_POSITION + 1];
    BeaconInfo.TxPower := ShortInt(AData[Length(AData) - 2]);
    BeaconInfo.AdditionalData := AData[Length(AData) - 1];
    Result := True;
  end;
end;

{ TPlatformBeaconManager }

class function TPlatformBeaconManager.GetInstance(AMode: TBeaconScanMode): TBeaconManager;
begin
  Result := TCommonBeaconManager.GetInstance(AMode);
end;

{ TEddystoneBeacon }

function TEddystoneBeacon.GetEddystoneBeacon: TEddystoneBeaconInfo;
begin
  Result := FRBeacon.BeaconInfo.EddystoneBeacon;
end;

procedure TEddystoneBeacon.SetEddystoneBeacon(const AValue: TEddystoneBeaconInfo);
begin
  FRBeacon.BeaconInfo.EddystoneBeacon := AValue;
end;

function TEddystoneBeacon.GetEddystoneTLM: TEddystoneTLM;
begin
  Result := FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneTLM;
end;

function TEddystoneBeacon.GetEddystoneUID: TEddystoneUID;
begin
  Result := FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneUID;
end;

function TEddystoneBeacon.GetEddystoneURL: TEddystoneURL;
begin
  Result := FRBeacon.BeaconInfo.EddystoneBeacon.EddystoneURL;
end;

function TEddystoneBeacon.GetKindofEddystones: TKindofEddystones;
begin
  Result := FRBeacon.BeaconInfo.EddystoneBeacon.KindofEddystones;
end;

end.
