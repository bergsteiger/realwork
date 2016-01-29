{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Win.Sensors;

interface

uses
  System.Sensors,
  Winapi.ActiveX,
  Winapi.Windows,
  System.RTLConsts;

type
  TPlatformSensorManager = class(TSensorManager)
  protected
    class function GetSensorManager: TSensorManager; override;
  end;

  TPlatformGeocoder = class(TGeocoder)
  protected
    class function GetGeocoderImplementer: TGeocoderClass; override;
  end;

  TPlatformGpsStatus = class(TGpsStatus)
  protected
    class function GetGpsStatusImplementer: TGpsStatusClass; override;
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.Math,
  System.Win.ComObj,
  Winapi.Portabledevicetypes,
  Winapi.Sensors,
  Winapi.Sensorsapi,
  Winapi.Locationapi;

// initializes the thread in a single threaded apartment
procedure ComInit;
var
  HR: HRESULT;
begin
  HR := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
  if (HR <> S_OK) and (HR <> S_FALSE) and (HR <> RPC_E_CHANGED_MODE) then
    OleCheck(HR);
end;

// frees resources allocated at the STA initialization
procedure ComDone;
begin
  CoUninitialize;
end;

type
  TDataUpdatedEvent = procedure (Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport) of object;
  TSensorEvent = procedure (Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues) of object;
  TLeaveEvent = procedure (Sender: TObject; const ID: TGUID) of object;
  TStateChangeEvent = procedure (Sender: TObject; const Sensor: ISensor; State: SensorState) of object;

  TSensorEventSink = class(TInterfacedObject, ISensorEvents)
  private
    FDataUpdated: TDataUpdatedEvent;
    FEvent: TSensorEvent;
    FLeave: TLeaveEvent;
    FStateChange: TStateChangeEvent;
  protected
    function OnDataUpdated(const pSensor: ISensor; const pNewData: ISensorDataReport): HRESULT; stdcall;
    function OnEvent(const pSensor: ISensor; const eventID: TGUID; const pEventData: IPortableDeviceValues): HRESULT; stdcall;
    function OnLeave(const ID: TGUID): HRESULT; stdcall;
    function OnStateChanged(const pSensor: ISensor; state: SensorState): HRESULT; stdcall;
  public
    constructor Create(ADataUpdated: TDataUpdatedEvent; AEvent: TSensorEvent; ALeave: TLeaveEvent; AStateChange: TStateChangeEvent);
  end;

  TLocationChangedEvent = procedure (Sender: TObject; const Report: ILocationReport; const ReportType: TGUID) of object;

  TLocationEventSink = class(TInterfacedObject, ILocationEvents)
  private
    FLocationChanged: TLocationChangedEvent;
  protected
    function OnLocationChanged(const reportType: TIID; const pLocationReport: ILocationReport): HRESULT; stdcall;
    function OnStatusChanged(const reportType: TIID; newStatus: LOCATION_REPORT_STATUS): HRESULT; stdcall;
  public
    constructor Create(LocationChanged: TLocationChangedEvent);
  end;

  TWindowsLocationSensor = class(TCustomLocationSensor)
  private
    FSensor: ISensor;
    FSensorReport: ISensorDataReport; // data report from sensor
    FSensorEventSink: ISensorEvents;
    FLocation: ILocation; // used for optimization of location reports
    FLocationReport: ILocationReport;
    FLocationEventSink: ILocationEvents;
    FLastCoords: TLocationCoord2D; // the last coordinates
    { ISensorEvents - indirect handlers }
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);

    { ILocationEvents - indirect handlers }
    procedure LocationChangedEvent(Sender: TObject; const Report: ILocationReport; const ReportType: TGUID);

    // updates the sensor report; useful when not using location optimization
    function UpdateSensorReport: Boolean;
    // updates the data report when using location optimization
    function UpdateLocationReport(const ReportType: TGUID): Boolean;

    // these routines return the value of the given property extracted from
    // the specified data report;
    // the following routines implicitly use FSensor
    function GetReportDoubleProperty(const Report: ISensorDataReport;
      Prop: TCustomLocationSensor.TProperty): Double; overload;
    function GetReportStringProperty(const Report: ISensorDataReport;
      Prop: TCustomLocationSensor.TProperty): String; overload;
    // the following routines implicitly use FLocation
    function GetReportDoubleProperty(const Report: ILatLongReport;
      Prop: TCustomLocationSensor.TProperty): Double; overload;
    function GetReportStringProperty(const Report: ICivicAddressReport;
      Prop: TCustomLocationSensor.TProperty): String; overload;
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetLocationSensorType: TLocationSensorType; override;
    function GetAvailableProperties: TCustomLocationSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double; override;
    function GetStringProperty(Prop: TCustomLocationSensor.TProperty): string; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;

    function GetAuthorized: TAuthorizationType; override;
    function GetAccuracy: TLocationAccuracy; override;
    function GetDistance: TLocationDistance; override;
    function GetPowerConsumption: TPowerConsumption; override;
    procedure SetAccuracy(const Value: TLocationAccuracy); override;
    procedure SetDistance(const Value: TLocationDistance); override;

    procedure DoLocationChangeType; override;
    procedure DoOptimize; override;

    function DoStart: Boolean; override;
    procedure DoStop; override;

    procedure RegionAdded(const Item: TLocationRegion); override;
    procedure RegionRemoved(const Item: TLocationRegion); override;
  end;

  TWindowsEnvironmentalSensor = class(TCustomEnvironmentalSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetEnvironmentalSensorType: TEnvironmentalSensorType; override;
    function GetAvailableProperties: TCustomEnvironmentalSensor.TProperties; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetDoubleProperty(Prop: TCustomEnvironmentalSensor.TProperty): Double; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsMotionSensor = class(TCustomMotionSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetMotionSensorType: TMotionSensorType; override;
    function GetAvailableProperties: TCustomMotionSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomMotionSensor.TProperty): Double; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
    function GetUpdateInterval: Double; override;
    procedure SetUpdateInterval(AInterval: Double); override;
    function DoStart: Boolean; override;
    procedure DoStop; override;
  end;

  TWindowsOrientationSensor = class(TCustomOrientationSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    FUpdateInterval: Double;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetOrientationSensorType: TOrientationSensorType; override;
    function GetAvailableProperties: TCustomOrientationSensor.TProperties; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetDoubleProperty(Prop: TCustomOrientationSensor.TProperty): Double; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
    function GetUpdateInterval: Double; override;
    procedure SetUpdateInterval(AInterval: Double); override;
  end;

  TWindowsElectricalSensor = class(TCustomElectricalSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetElectricalSensorType: TElectricalSensorType; override;
    function GetAvailableProperties: TCustomElectricalSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomElectricalSensor.TProperty): Double; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsMechanicalSensor = class(TCustomMechanicalSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetMechanicalSensorType: TMechanicalSensorType; override;
    function GetAvailableProperties: TCustomMechanicalSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomMechanicalSensor.TProperty): Double; override;
    function GetBooleanProperty(Prop: TCustomMechanicalSensor.TProperty): Boolean; override;
    function GetStateProperty(Prop: TCustomMechanicalSensor.TProperty): Cardinal; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsBiometricSensor = class(TCustomBiometricSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetBiometricSensorType: TBiometricSensorType; override;
    function GetAvailableProperties: TCustomBiometricSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomBiometricSensor.TProperty): Double; override;
    function GetBooleanProperty(Prop: TCustomBiometricSensor.TProperty): Boolean; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsLightSensor = class(TCustomLightSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetLightSensorType: TLightSensorType; override;
    function GetAvailableProperties: TCustomLightSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomLightSensor.TProperty): Double; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsScannerSensor = class(TCustomScannerSensor)
  private
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    procedure DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
    procedure SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
    procedure LeaveEvent(Sender: TObject; const ID: TGUID);
    procedure StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
  protected
    constructor Create(AManager: TSensorManager; const ASensor: ISensor); reintroduce;
    function GetScannerSensorType: TScannerSensorType; override;
    function GetAvailableProperties: TCustomScannerSensor.TProperties; override;
    function GetUInt64Property(Prop: TCustomScannerSensor.TProperty): UInt64; override;
    function GetCustomData(const Data): Variant; override;
    function GetCustomProperty(const Prop): Variant; override;
    function GetHasCustomProperty(const Prop): Boolean; override;
    function GetHasCustomData(const Data): Boolean; override;
    function GetSensorProperty(Prop: TCustomSensor.TProperty): string; override;
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    procedure SetCustomProperty(const Prop; const Value: Variant); override;
  end;

  TWindowsSensorManager = class(TPlatformSensorManager)
  private type
    TSensorManagerEvents = class(TInterfacedObject, ISensorManagerEvents)
    private
      FManager: TWindowsSensorManager;
    protected
      function OnSensorEnter(const pSensor: ISensor; state: SensorState): HRESULT; stdcall;
    public
      constructor Create(AManager: TWindowsSensorManager);
    end;
  private
    FManager: ISensorManager;
    FSensors: ISensorCollection;
    FAuthorizationStatus: TAuthorizationType;
    function GetSensorObject(const Sensor: ISensor): TCustomSensor;
  protected
    function GetCanActivate: Boolean; override;
    function GetActive: Boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Activate; override;
    procedure Deactivate; override;
    class procedure GetAvailableProperties(const Sensor: ISensor; const Proc: TProc<TPropertyKey>); static;
    class function GetSensorProperty(const Sensor: ISensor; Prop: TCustomSensor.TProperty): string; static;
    class function GetSensorState(const Sensor: ISensor): TSensorState; static;
    class function GetTimeStamp(const Sensor: ISensor; const Data: ISensorDataReport): TDateTime; static;
    class function GetCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey): Variant; static;
    class function GetCustomSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Variant; static;
    class function GetHasCustomSensorData(const Sensor: ISensor; const Prop: TPropertyKey): Boolean; static;
    class function GetHasCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey): Boolean; static;
    class procedure SetCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey; const Value: Variant); static;
    property AuthorizationStatus: TAuthorizationType read FAuthorizationStatus;
  end;

  // event for sensor ranking; if a sensor fits in better for the needs, return
  // a higher rank, otherwise return a lower rank;
  // selection of best-fit sensor is done by selecting the sensor with the highest rank
  TRankSensorEvent = procedure (const Sensor: ISensor; var Rank: Integer) of object;

  // incorporates a manager and a few routines to select the best suited sensor;
  // can be used with other classes that have to encapsulate, select and delegate
  // functionality to one sensor
  TSensorSelector = class(TObject)
  private
    FManager: ISensorManager;
    FSensor: ISensor;
    FDataReport: ISensorDataReport;
    FOnRankSensor: TRankSensorEvent;
  public
    constructor Create(const Manager: ISensorManager);

    // tries to find a Gps sensor that supports satellite information
    procedure ObtainSensor;
    function UpdateDataReport: Boolean;

    // determines if the given sensor supports the specified data field
    class function SupportsDataField(const Sensor: ISensor; const Field: TPropertyKey): Boolean;

    // triggered when sensor ranking is needed
    property OnRankSensor: TRankSensorEvent read FOnRankSensor write FOnRankSensor;
  end;

  // geocoding is not supported through this class because the location sensor
  // doesn't provide geographical information for locations other than the one
  // in which it is located;
  // that said, the user must use a location sensor to obtain geocoding information
  // related only to the location where the sensor is located
  TWindowsGeocoder = class(TGeocoder)
  protected
    class function GetGeocoderImplementer: TGeocoderClass; override;

    class procedure GeocodeRequest(const Address: TCivicAddress); override;
    class procedure GeocodeReverseRequest(const Coords: TLocationCoord2D); override;
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class procedure Cancel; override;
  end;

  TWindowsGpsStatus = class(TGpsStatus)
  private type
    // sensor manager events handler
    TManagerEvents = class(TInterfacedObject, ISensorManagerEvents)
    protected
      function OnSensorEnter(const pSensor: ISensor; state : SensorState): HRESULT; stdcall;
    end;
  private class var
    FManager: ISensorManager;
    FSelector: TSensorSelector;
  private
    // raises an expcetion if the index is not in bounds
    class procedure CheckIndex(Index: Integer);
    // event handler for sensor ranking
    class procedure RankSensorHandler(const Sensor: ISensor; var Rank: Integer);

    class constructor Create;
    class destructor Destroy;
  protected
    class function GetGpsStatusImplementer: TGpsStatusClass; override;

    // returns True if a sensor is assigned, supported, authorized for use and
    // if it is ready for querying
    class function IsReady: Boolean;

    class procedure Initialize; override;
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class function Satellites(Index: Integer): TGpsSatellite; override;
    class function SatelliteCount: Integer; override;
    class function SatelliteFirstFixTime: Integer; override;
  end;

function PropVarToDouble(const Value: TPropVariant): Double;
begin
  case Value.vt of
    VT_I1: Result := Value.cVal;
    VT_UI1: Result := Value.bVal;
    VT_I2: Result := Value.iVal;
    VT_UI2: Result := Value.uiVal;
    VT_I4: Result := Value.lVal;
    VT_UI4: Result := Value.ulVal;
    VT_I8: Result := Value.hVal.QuadPart;
    VT_UI8: Result := Value.uhVal.QuadPart;
    VT_R4: Result := Value.fltVal;
    VT_R8: Result := Value.dblVal;
  else
    Result := NaN;
  end;
end;

function PropVarToInteger(const Value: TPropVariant): Integer;
begin
  case Value.vt of
    VT_I1: Result := Value.cVal;
    VT_UI1: Result := Value.bVal;
    VT_I2: Result := Value.iVal;
    VT_UI2: Result := Value.uiVal;
    VT_I4: Result := Value.lVal;
    VT_UI4: Result := Value.ulVal;
    VT_I8: Result := Value.hVal.QuadPart;
    VT_UI8: Result := Value.uhVal.QuadPart;
  else
    Result := 0;
  end;
end;

function GetSensorProp(const Sensor: ISensor; const Prop: TPropertyKey): TPropVariant; inline;
begin
 if Failed(Sensor.GetProperty(Prop, Result)) then
   PropVariantInit(Result);
end;

function GetSensorData(const Sensor: ISensor; Data: ISensorDataReport; const Prop: TPropertyKey): TPropVariant; //inline;
begin
  if Data = nil then
    OleCheck(Sensor.GetData(Data));
  if Failed(Data.GetSensorValue(Prop, Result)) then
    PropVariantInit(Result);
end;

function GetIntegerSensorProp(const Sensor: ISensor; const Prop: TPropertyKey): Integer; 
var
  Value: TPropVariant;
begin
  Value := GetSensorProp(Sensor, Prop);
  if IsVarTypeNumber(Value.vt) then
    Result := PropVarToInteger(Value)
  else
    Result := 0;
  PropVariantClear(Value);
end;

procedure SetIntegerSensorProp(const Sensor: ISensor; const Prop: TPropertyKey; Value: Integer);
var
  PropsToSet: IPortableDeviceValues;
  PropsReturn: IPortableDeviceValues;
  HR: HRESULT;
begin
  HR := CoCreateInstance(CLSID_PortableDeviceValues, nil, CLSCTX_INPROC_SERVER,
    IID_IPortableDeviceValues, PropsToSet);
  if Succeeded(HR) and
     Succeeded(PropsToSet.SetUnsignedIntegerValue(SENSOR_PROPERTY_LOCATION_DESIRED_ACCURACY, Value)) then
    Succeeded(Sensor.SetProperties(PropsToSet, PropsReturn));
end;

function GetIntegerSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Integer; //inline;
var
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  if IsVarTypeNumber(Value.vt) then
    Result := PropVarToInteger(Value)
  else
    Result := 0;
  PropVariantClear(Value);
end;

function GetDoubleSensorProp(const Sensor: ISensor; const Prop: TPropertyKey): Double; 
var
  Value: TPropVariant;
begin
  Value := GetSensorProp(Sensor, Prop);
  if IsVarTypeNumber(Value.vt) then
    Result := PropVarToDouble(Value)
  else
    Result := NaN;
  PropVariantClear(Value);
end;

function GetDoubleSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Double; //inline;
var
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  if IsVarTypeNumber(Value.vt) then
    Result := PropVarToDouble(Value)
  else
    Result := NaN;
  PropVariantClear(Value);
end;

function GetStringSensorProp(const Sensor: ISensor; const Prop: TPropertyKey): string; inline;
var
  Value: TPropVariant;
begin
  Value := GetSensorProp(Sensor, Prop);
  Result := PropVariantToStringWithDefault(Value, '<no value>');
  PropVariantClear(Value);
end;

function GetStringSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): string; //inline;
var
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  Result := PropVariantToStringWithDefault(Value, '<no value>');
  PropVariantClear(Value);
end;

function GetBooleanSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Boolean;
var
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  Result := PropVariantToBooleanWithDefault(Value, False);
  PropVariantClear(Value);
end;

function GetOrdinalSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Cardinal;
var
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  case Value.vt of
    VT_I1: Result := Value.cVal;
    VT_UI1: Result := Value.bVal;
    VT_I2: Result := Value.iVal;
    VT_UI2: Result := Value.uiVal;
    VT_I4: Result := Value.lVal;
    VT_UI4: Result := Value.ulVal;
    VT_I8: Result := Value.hVal.LowPart;
    VT_UI8: Result := Value.uhVal.LowPart;
    VT_R4: Result := Trunc(Value.fltVal);
    VT_R8: Result := Trunc(Value.dblVal);
  else
    Result := 0;
  end;
  PropVariantClear(Value);
end;

// returns the number of elements in the array and a reference to the array of integers in Elems;
// ArrayData must be freed when the work on the array is done
function GetIntegerArraySensorData(const Sensor: ISensor; const Data: ISensorDataReport;
  const ArrayProp: TPropertyKey; out ArrayData: TPropVariant; out Elems: PUINT): Integer;
begin
  ArrayData := GetSensorData(Sensor, Data, ArrayProp);
  if VT_VECTOR or VT_UI1 = ArrayData.vt then
  begin
    Result := ArrayData.caub.cElems div SizeOf(UINT);
    Elems := PUINT(ArrayData.caub.pElems);
  end
  else
  begin
    Result := 0;
    Elems := nil;
  end;
end;

function GetIntegerArrayValueSensorData(const Sensor: ISensor; const Data: ISensorDataReport;
  const Field: TPropertyKey; Index: Integer): Integer;
var
  ArrayData: TPropVariant;
  Elems: PUINT;
  Count: Integer;
begin
  Count := GetIntegerArraySensorData(Sensor, Data, Field, ArrayData, Elems);
  if Count > 0 then
  begin
    Inc(Elems, Index);
    Result := Elems^;
  end
  else
    Result := 0;

  PropVariantClear(ArrayData);
end;

{ TPlatformSensorManager }

class function TPlatformSensorManager.GetSensorManager: TSensorManager;
begin
  Result := TWindowsSensorManager.Create;
end;

{ TWindowsSensorManager }

procedure TWindowsSensorManager.Activate;
var
  HR: HRESULT;
  Sensor: ISensor;
  I, Count: DWORD;
begin
  if CanActivate then
  begin
    HR := CoCreateInstance(CLSID_SensorManager, nil, CLSCTX_INPROC_SERVER, IID_ISensorManager, FManager);
    if Succeeded(HR) then
    begin
      FManager.SetEventSink(TSensorManagerEvents.Create(Self));

      // obtain permissions for all the sensors on the system and then
      // regrab the collection of sensors;
      // not regrabbing the collection of sensors will cause sensor event-sink
      // registration errors afterwards for some sensors only when the
      // permissions dialog appears to the user and gets acceptance for
      // system-wide sensor enabling;
      // regrabbing the sensor collection seems to update the sensors permissions
      // for each sensor and makes everything work nicely after that

                                                                                      
      // Sensor components should register with the sensor manager and only those should
      // be authorized.
      if Succeeded(FManager.GetSensorsByCategory(SENSOR_CATEGORY_ALL, FSensors)) then
      begin
        FAuthorizationStatus := TAuthorizationType.atUnauthorized;
        OleCheck(FManager.RequestPermissions(0, FSensors, True));
        FAuthorizationStatus := TAuthorizationType.atAuthorized;

        // now grab again the list of sensors again to assure user specified permissions
        // have been correctly assigned to the sensors in the collection
        FSensors := nil;
        if Succeeded(FManager.GetSensorsByCategory(SENSOR_CATEGORY_ALL, FSensors)) then
        begin
          OleCheck(FSensors.GetCount(Count));
          for I := 0 to Count - 1 do
          begin
            OleCheck(FSensors.GetAt(I, Sensor));
            GetSensorObject(Sensor);
          end;
        end;
      end;
    end;
  end;
end;

constructor TWindowsSensorManager.Create;
begin
  inherited Create;
  FAuthorizationStatus := TAuthorizationType.atNotSpecified;
  ComInit;
end;

procedure TWindowsSensorManager.Deactivate;
begin
  if Active then
  begin
    FSensors := nil;
    FManager := nil;
  end;
end;

destructor TWindowsSensorManager.Destroy;
begin
  ComDone;

  inherited;
end;

function TWindowsSensorManager.GetActive: Boolean;
begin
  Result := FManager <> nil;
end;

class procedure TWindowsSensorManager.GetAvailableProperties(const Sensor: ISensor; const Proc: TProc<TPropertyKey>);
var
  I, Count: DWORD;
  Key: TPropertyKey;
  Props: IPortableDeviceKeyCollection;
begin
  OleCheck(Sensor.GetSupportedDataFields(Props));
  OleCheck(Props.GetCount(Count));
  for I := 0 to Count - 1 do
  begin
    OleCheck(Props.GetAt(I, Key));
    Proc(Key);
  end;
end;

function TWindowsSensorManager.GetCanActivate: Boolean;
begin
  Result := CheckWin32Version(6, 1);
end;

class function TWindowsSensorManager.GetCustomSensorData(const Sensor: ISensor; const Data: ISensorDataReport; const Prop: TPropertyKey): Variant;
var
  Res: OleVariant;
  Value: TPropVariant;
begin
  Value := GetSensorData(Sensor, Data, Prop);
  PropVariantToVariant(Value, Res);
  Result := Res;
  PropVariantClear(Value);
end;

class function TWindowsSensorManager.GetCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey): Variant;
var
  Res: OleVariant;
  Value: TPropVariant;
begin
  Value := GetSensorProp(Sensor, Prop);
  PropVariantToVariant(Value, Res);
  Result := Res;
  PropVariantClear(Value);
end;

class function TWindowsSensorManager.GetHasCustomSensorData(const Sensor: ISensor; const Prop: TPropertyKey): Boolean;
var
  Res: VARIANT_BOOL;
begin
  OleCheck(Sensor.SupportsDataField(Prop, Res));
  Result := Res <> 0;
end;

class function TWindowsSensorManager.GetHasCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey): Boolean;
var
  Value: TPropVariant;
begin
  Result := Succeeded(Sensor.GetProperty(Prop, Value));
end;

function TWindowsSensorManager.GetSensorObject(const Sensor: ISensor): TCustomSensor;
var
  ID, Category: TGuid;
  UniqueID: string;
  I: Integer;
begin
  OleCheck(Sensor.GetID(ID));
  UniqueID := GuidToString(ID);
  for I := 0 to Count - 1 do
  begin
    Result := Sensors[I];
    if SameText(Result.UniqueID, UniqueID) then
      Exit;
  end;
  OleCheck(Sensor.GetCategory(Category));
  Result := nil;
  if Category = SENSOR_CATEGORY_MOTION then
    Result := TWindowsMotionSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_LOCATION then
    Result := TWindowsLocationSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_LIGHT then
    Result := TWindowsLightSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_ENVIRONMENTAL then
    Result := TWindowsEnvironmentalSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_ORIENTATION then
    Result := TWindowsOrientationSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_MECHANICAL then
    Result := TWindowsMechanicalSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_BIOMETRIC then
    Result := TWindowsBiometricSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_SCANNER then
    Result := TWindowsScannerSensor.Create(Self, Sensor)
  else if Category = SENSOR_CATEGORY_ELECTRICAL then
    Result := TWindowsElectricalSensor.Create(Self, Sensor)
end;

class function TWindowsSensorManager.GetSensorProperty(const Sensor: ISensor; Prop: TCustomSensor.TProperty): string;
var
  ID: TGuid;
begin
  case Prop of
    TCustomSensor.TProperty.UniqueID:
      begin
        OleCheck(Sensor.GetID(ID));
        Result := GuidToString(ID);
      end;
    TCustomSensor.TProperty.Manufacturer: Result := GetStringSensorProp(Sensor, SENSOR_PROPERTY_MANUFACTURER);
    TCustomSensor.TProperty.Model: Result := GetStringSensorProp(Sensor, SENSOR_PROPERTY_MODEL);
    TCustomSensor.TProperty.SerialNo: Result := GetStringSensorProp(Sensor, SENSOR_PROPERTY_SERIAL_NUMBER);
    TCustomSensor.TProperty.Name: Result := GetStringSensorProp(Sensor, SENSOR_PROPERTY_FRIENDLY_NAME);
    TCustomSensor.TProperty.Description: Result := GetStringSensorProp(Sensor, SENSOR_PROPERTY_DESCRIPTION);
  else
    Result := '';
  end;
end;

class function TWindowsSensorManager.GetSensorState(const Sensor: ISensor): TSensorState;
var
  State: SensorState;
begin
  OleCheck(Sensor.GetState(State));
  case State of
    SENSOR_STATE_READY: Result := TSensorState.Ready;
    SENSOR_STATE_NOT_AVAILABLE: Result := TSensorState.Removed;
    SENSOR_STATE_NO_DATA: Result := TSensorState.NoData;
    SENSOR_STATE_INITIALIZING: Result := TSensorState.Initializing;
    SENSOR_STATE_ACCESS_DENIED: Result := TSensorState.AccessDenied;
    SENSOR_STATE_ERROR: Result := TSensorState.Error;
  else
    Result := TSensorState(-1);
  end;
end;

class function TWindowsSensorManager.GetTimeStamp(const Sensor: ISensor; const Data: ISensorDataReport): TDateTime;
var
  Value: TPropVariant;
  FT: TFileTime;
  ST: TSystemTime;
begin
  Value := GetSensorData(Sensor, Data, SENSOR_DATA_TYPE_TIMESTAMP);
  if Succeeded(PropVariantToFileTime(Value, PSTF_LOCAL, FT)) and FileTimeToSystemTime(FT, ST) then
    Result := SystemTimeToDateTime(ST)
  else
    Result := Now;
end;

class procedure TWindowsSensorManager.SetCustomSensorProperty(const Sensor: ISensor; const Prop: TPropertyKey;
  const Value: Variant);
var
  PropValue: TPropVariant;
  Values: IPortableDeviceValues;
begin
  VariantToPropVariant(Value, PropValue);
  try
    OleCheck(CoCreateInstance(CLSID_PortableDeviceValues, nil, CLSCTX_INPROC_SERVER, IID_IPortableDeviceValues, Values));
    OleCheck(Values.SetValue(Prop, PropValue));
    OleCheck(Sensor.SetProperties(Values, Values));
    PropVariantClear(PropValue);
    OleCheck(Values.GetValue(Prop, PropValue));
    OleCheck(HRESULT(PropValue.scode));
  finally
    PropVariantClear(PropValue);
  end;
end;

{ TWindowsSensorManager.TSensorManagerEvents }

constructor TWindowsSensorManager.TSensorManagerEvents.Create(AManager: TWindowsSensorManager);
begin
  inherited Create;
  FManager := AManager;
end;

function TWindowsSensorManager.TSensorManagerEvents.OnSensorEnter(const pSensor: ISensor; state: SensorState): HRESULT;
begin
  try
    if (FManager <> nil) and (state = SENSOR_STATE_READY) then
      FManager.GetSensorObject(pSensor);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ TSensorEventSink }

constructor TSensorEventSink.Create(ADataUpdated: TDataUpdatedEvent; AEvent: TSensorEvent; ALeave: TLeaveEvent; AStateChange: TStateChangeEvent);
begin
  inherited Create;
  FDataUpdated := ADataUpdated;
  FEvent := AEvent;
  FLeave := ALeave;
  FStateChange := AStateChange;
end;

function TSensorEventSink.OnDataUpdated(const pSensor: ISensor; const pNewData: ISensorDataReport): HRESULT;
begin
  try
    if Assigned(FDataUpdated) then
      FDataUpdated(Self, pSensor, pNewData);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TSensorEventSink.OnEvent(const pSensor: ISensor; const eventID: TGUID; const pEventData: IPortableDeviceValues): HRESULT;
begin
  try
    if Assigned(FEvent) then
      FEvent(Self, pSensor, eventID, pEventData);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TSensorEventSink.OnLeave(const ID: TGUID): HRESULT;
begin
  try
    if Assigned(FLeave) then
      FLeave(Self, ID);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TSensorEventSink.OnStateChanged(const pSensor: ISensor; state: SensorState): HRESULT;
begin
  try
    if Assigned(FStateChange) then
      FStateChange(Self, pSensor, state);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ TWindowsMotionSensor }

constructor TWindowsMotionSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsMotionSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsMotionSensor.DoStart: Boolean;
begin
                                                    
  Result := True;
end;

procedure TWindowsMotionSensor.DoStop;
begin
                                                    
end;

function TWindowsMotionSensor.GetAvailableProperties: TCustomMotionSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_ACCELERATION_X_G then
        Include(Res, TProperty.AccelerationX)
      else if Key = SENSOR_DATA_TYPE_ACCELERATION_Y_G then
        Include(Res, TProperty.AccelerationY)
      else if Key = SENSOR_DATA_TYPE_ACCELERATION_Z_G then
        Include(Res, TProperty.AccelerationZ)
      else if Key = SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_X_DEGREES_PER_SECOND_SQUARED then
        Include(Res, TProperty.AngleAccelX)
      else if Key = SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Y_DEGREES_PER_SECOND_SQUARED then
        Include(Res, TProperty.AngleAccelY)
      else if Key = SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Z_DEGREES_PER_SECOND_SQUARED then
        Include(Res, TProperty.AngleAccelZ)
      else if Key = SENSOR_DATA_TYPE_MOTION_STATE then
        Include(Res, TProperty.Motion)
      else if Key = SENSOR_DATA_TYPE_SPEED_METERS_PER_SECOND then
        Include(Res, TProperty.Speed);
    end);
  Result := Res;
end;

function TWindowsMotionSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsMotionSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsMotionSensor.GetDoubleProperty(Prop: TCustomMotionSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.AccelerationX: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ACCELERATION_X_G);
      TProperty.AccelerationY: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ACCELERATION_Y_G);
      TProperty.AccelerationZ: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ACCELERATION_Z_G);
      TProperty.AngleAccelX: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_X_DEGREES_PER_SECOND_SQUARED);
      TProperty.AngleAccelY: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Y_DEGREES_PER_SECOND_SQUARED);
      TProperty.AngleAccelZ: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ANGULAR_ACCELERATION_Z_DEGREES_PER_SECOND_SQUARED);
      TProperty.Motion: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MOTION_STATE);
      TProperty.Speed: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_SPEED_METERS_PER_SECOND);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsMotionSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsMotionSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsMotionSensor.GetMotionSensorType: TMotionSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_ACCELEROMETER_1D then
    Result := TMotionSensorType.Accelerometer1D
  else if SensType = SENSOR_TYPE_ACCELEROMETER_2D then
    Result := TMotionSensorType.Accelerometer2D
  else if SensType = SENSOR_TYPE_ACCELEROMETER_3D then
    Result := TMotionSensorType.Accelerometer3D
  else if SensType = SENSOR_TYPE_GYROMETER_1D then
    Result := TMotionSensorType.Gyrometer1D
  else if SensType = SENSOR_TYPE_GYROMETER_2D then
    Result := TMotionSensorType.Gyrometer2D
  else if SensType = SENSOR_TYPE_GYROMETER_3D then
    Result := TMotionSensorType.Gyrometer3D
  else if SensType = SENSOR_TYPE_MOTION_DETECTOR then
    Result := TMotionSensorType.MotionDetector
  else if SensType = SENSOR_TYPE_SPEEDOMETER then
    Result := TMotionSensorType.Speedometer
  else
    Result := TMotionSensorType(-1);
end;

function TWindowsMotionSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsMotionSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsMotionSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

function TWindowsMotionSensor.GetUpdateInterval: Double;
begin
                                                              
  Result := 0;
end;

procedure TWindowsMotionSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsMotionSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsMotionSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsMotionSensor.SetUpdateInterval(AInterval: Double);
begin
                                                              
end;

procedure TWindowsMotionSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsLightSensor }

constructor TWindowsLightSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsLightSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsLightSensor.GetAvailableProperties: TCustomLightSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_LIGHT_LEVEL_LUX then
        Include(Res, TProperty.Lux)
      else if Key = SENSOR_DATA_TYPE_LIGHT_TEMPERATURE_KELVIN then
        Include(Res, TProperty.Temperature)
      else if Key = SENSOR_DATA_TYPE_LIGHT_CHROMACITY then
        Include(Res, TProperty.Chromacity);
    end);
  Result := Res;
end;

function TWindowsLightSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsLightSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsLightSensor.GetDoubleProperty(Prop: TCustomLightSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.Lux: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_LIGHT_LEVEL_LUX);
      TProperty.Temperature: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_LIGHT_TEMPERATURE_KELVIN);
      TProperty.Chromacity: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_LIGHT_CHROMACITY);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsLightSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsLightSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsLightSensor.GetLightSensorType: TLightSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_AMBIENT_LIGHT then
    Result := TLightSensorType.AmbientLight
  else
    Result := TLightSensorType(-1);
end;

function TWindowsLightSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsLightSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsLightSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

procedure TWindowsLightSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsLightSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsLightSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsLightSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsMechanicalSensor }

constructor TWindowsMechanicalSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsMechanicalSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsMechanicalSensor.GetAvailableProperties: TCustomMechanicalSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_BOOLEAN_SWITCH_STATE then
        Include(Res, TProperty.SwitchState)
      else if Key = SENSOR_DATA_TYPE_BOOLEAN_SWITCH_ARRAY_STATE then
        Include(Res, TProperty.SwitchArrayState)
      else if Key = SENSOR_DATA_TYPE_MULTIVALUE_SWITCH_STATE then
        Include(Res, TProperty.MultiValueState)
      else if Key = SENSOR_DATA_TYPE_FORCE_NEWTONS then
        Include(Res, TProperty.Force)
      else if Key = SENSOR_DATA_TYPE_ABSOLUTE_PRESSURE_PASCAL then
        Include(Res, TProperty.AbsPressure)
      else if Key = SENSOR_DATA_TYPE_GAUGE_PRESSURE_PASCAL then
        Include(Res, TProperty.GaugePressure)
      else if Key = SENSOR_DATA_TYPE_STRAIN then
        Include(Res, TProperty.Strain)
      else if Key = SENSOR_DATA_TYPE_WEIGHT_KILOGRAMS then
        Include(Res, TProperty.Weight);
    end);
  Result := Res;
end;

function TWindowsMechanicalSensor.GetBooleanProperty(Prop: TCustomMechanicalSensor.TProperty): Boolean;
begin
  if (FSensor <> nil) and (Prop = TProperty.SwitchState) then
    Result := GetBooleanSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_BOOLEAN_SWITCH_STATE)
  else
    Result := inherited GetBooleanProperty(Prop);
end;

function TWindowsMechanicalSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsMechanicalSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsMechanicalSensor.GetDoubleProperty(Prop: TCustomMechanicalSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.MultiValueState: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MULTIVALUE_SWITCH_STATE);
      TProperty.Force: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_FORCE_NEWTONS);
      TProperty.AbsPressure: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ABSOLUTE_PRESSURE_PASCAL);
      TProperty.GaugePressure: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_GAUGE_PRESSURE_PASCAL);
      TProperty.Strain: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_STRAIN);
      TProperty.Weight: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_WEIGHT_KILOGRAMS);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsMechanicalSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsMechanicalSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsMechanicalSensor.GetMechanicalSensorType: TMechanicalSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_BOOLEAN_SWITCH then
    Result := TMechanicalSensorType.BooleanSwitch
  else if SensType = SENSOR_TYPE_BOOLEAN_SWITCH_ARRAY then
    Result := TMechanicalSensorType.BooleanSwitchArray
  else if SensType = SENSOR_TYPE_MULTIVALUE_SWITCH then
    Result := TMechanicalSensorType.MultiValueSwitch
  else if SensType = SENSOR_TYPE_FORCE then
    Result := TMechanicalSensorType.Force
  else if SensType = SENSOR_TYPE_STRAIN then
    Result := TMechanicalSensorType.Strain
  else if SensType = SENSOR_TYPE_SCALE then
    Result := TMechanicalSensorType.Scale
  else if SensType = SENSOR_TYPE_PRESSURE then
    Result := TMechanicalSensorType.Pressure
  else
    Result := TMechanicalSensorType(-1);
end;

function TWindowsMechanicalSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsMechanicalSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsMechanicalSensor.GetStateProperty(Prop: TCustomMechanicalSensor.TProperty): Cardinal;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.SwitchArrayState: Result := GetOrdinalSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_BOOLEAN_SWITCH_ARRAY_STATE);
    else
      Result := inherited GetStateProperty(Prop);
    end;
  end else
    Result := inherited GetStateProperty(Prop);
end;

function TWindowsMechanicalSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

procedure TWindowsMechanicalSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsMechanicalSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsMechanicalSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsMechanicalSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsLocationSensor }

constructor TWindowsLocationSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
  begin
    FSensorEventSink := TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent);
    FLocationEventSink := TLocationEventSink.Create(LocationChangedEvent);
  end;
end;

procedure TWindowsLocationSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
var
  NewLocation: TLocationCoord2D;
begin
  FSensorReport := NewData;

  // trigger OnDataChanged
  DataChanged;

  // trigger OnLocationChanged
  NewLocation.Latitude := GetReportDoubleProperty(FSensorReport, TProperty.Latitude);
  NewLocation.Longitude := GetReportDoubleProperty(FSensorReport, TProperty.Longitude);
  DoLocationChanged(FLastCoords, NewLocation);
  FLastCoords.Latitude := NewLocation.Latitude;
  FLastCoords.Longitude := NewLocation.Longitude;
end;

procedure TWindowsLocationSensor.DoLocationChangeType;
begin
                                               
  if LocationChange = TLocationChangeType.lctSmall then
    SetIntegerSensorProp(FSensor, SENSOR_PROPERTY_LOCATION_DESIRED_ACCURACY, LOCATION_DESIRED_ACCURACY_HIGH)
  else
    SetIntegerSensorProp(FSensor, SENSOR_PROPERTY_LOCATION_DESIRED_ACCURACY, LOCATION_DESIRED_ACCURACY_DEFAULT);
end;

procedure TWindowsLocationSensor.DoOptimize;
var
  ReportTypes: TArray<TGUID>;
  HR: HRESULT;
begin
                                                      
   if Optimize then
   begin
     HR := CoCreateInstance(CLSID_Location, nil, CLSCTX_INPROC_SERVER, IID_ILocation, FLocation);

     if Succeeded(HR) then
     begin
       // request permissions to use location
       ReportTypes := TArray<TGUID>.Create(IID_ILatLongReport, IID_ICivicAddressReport);
       OleCheck(FLocation.RequestPermissions(0, PGUID(ReportTypes), Length(ReportTypes), True));

       // stop receiving location information using the sensor
       OleCheck(FSensor.SetEventSink(nil));
     end;
   end
   else
     FLocation := nil;
end;

function TWindowsLocationSensor.DoStart: Boolean;
begin
                                                                                 
  if Optimize then
    FLocation.RegisterForReport(FLocationEventSink, IID_ILatLongReport, 0)
  else
    OleCheck(FSensor.SetEventSink(FSensorEventSink));
  Result := True;
end;

procedure TWindowsLocationSensor.DoStop;
begin
  inherited;

  if Optimize then
    OleCheck(FLocation.UnregisterForReport(IID_ILatLongReport))
  else
    OleCheck(FSensor.SetEventSink(nil));
end;

function TWindowsLocationSensor.GetAccuracy: TLocationAccuracy;
begin
                                                                         
  Result := 0;
end;

function TWindowsLocationSensor.GetAuthorized: TAuthorizationType;
begin
  Result := TWindowsSensorManager(Manager).AuthorizationStatus;
end;

function TWindowsLocationSensor.GetAvailableProperties: TCustomLocationSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_LATITUDE_DEGREES then
        Include(Res, TProperty.Latitude)
      else if Key = SENSOR_DATA_TYPE_LONGITUDE_DEGREES then
        Include(Res, TProperty.Longitude)
      else if Key = SENSOR_DATA_TYPE_ERROR_RADIUS_METERS then
        Include(Res, TProperty.ErrorRadius)
      else if Key = SENSOR_DATA_TYPE_ALTITUDE_SEALEVEL_METERS then
        Include(Res, TProperty.Altitude)
      else if Key = SENSOR_DATA_TYPE_SPEED_METERS_PER_SECOND then
        Include(Res, TProperty.Speed)
      else if Key = SENSOR_DATA_TYPE_TRUE_HEADING_DEGREES then
        Include(Res, TProperty.TrueHeading)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_DEGREES then
        Include(Res, TProperty.MagneticHeading)
      else if Key = SENSOR_DATA_TYPE_ADDRESS1 then
        Include(Res, TProperty.Address1)
      else if Key = SENSOR_DATA_TYPE_ADDRESS2 then
        Include(Res, TProperty.Address2)
      else if Key = SENSOR_DATA_TYPE_CITY then
        Include(Res, TProperty.City)
      else if Key = SENSOR_DATA_TYPE_POSTALCODE then
        Include(Res, TProperty.PostalCode)
      else if Key = SENSOR_DATA_TYPE_COUNTRY_REGION then
        Include(Res, TProperty.CountryRegion);
    end);
  Result := Res;
end;

function TWindowsLocationSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FSensorReport, TPropertyKey(Data));
end;

function TWindowsLocationSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsLocationSensor.GetDistance: TLocationDistance;
begin
                                                                                
  Result := 0;
end;

function TWindowsLocationSensor.GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double;
var
  Success: Boolean;
begin
  Result := 0;
  Success := FSensor <> nil;
  if Success then
    if Optimize then
    begin
      // update the location LocReport
      Success := UpdateLocationReport(IID_ILatLongReport);
      if Success then
        Result := GetReportDoubleProperty(FLocationReport as ILatLongReport, Prop);
    end
    else
    begin
      Success := UpdateSensorReport;
      if Success then
        Result := GetReportDoubleProperty(FSensorReport, Prop);
    end;

  if not Success then
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsLocationSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsLocationSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsLocationSensor.UpdateLocationReport(
  const ReportType: TGUID): Boolean;
var
  Status: LOCATION_REPORT_STATUS;
begin
  Result := Succeeded(FLocation.GetReportStatus(ReportType, Status)) and (Status = REPORT_RUNNING);
  Result := Result or Succeeded(FLocation.GetReport(ReportType, FLocationReport));
end;

function TWindowsLocationSensor.GetLocationSensorType: TLocationSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_LOCATION_GPS then
    Result := TLocationSensorType.GPS
  else if SensType = SENSOR_TYPE_LOCATION_STATIC then
    Result := TLocationSensorType.Static
  else if SensType = SENSOR_TYPE_LOCATION_LOOKUP then
    Result := TLocationSensorType.Lookup
  else if SensType = SENSOR_TYPE_LOCATION_TRIANGULATION then
    Result := TLocationSensorType.Triangulation
  else if SensType = SENSOR_TYPE_LOCATION_BROADCAST then
    Result := TLocationSensorType.Broadcast
  else if SensType = SENSOR_TYPE_LOCATION_DEAD_RECKONING then
    Result := TLocationSensorType.DeadReckoning
  else if SensType = SENSOR_TYPE_LOCATION_OTHER then
    Result := TLocationSensorType.Other
  else
    Result := TLocationSensorType(-1);
end;

function TWindowsLocationSensor.GetPowerConsumption: TPowerConsumption;
begin
                                                                           
  Result := TPowerConsumption.pcNotSpecified;
end;

function TWindowsLocationSensor.GetReportDoubleProperty(
  const Report: ILatLongReport; Prop: TCustomLocationSensor.TProperty): Double;
var
  Success: Boolean;
begin
  case Prop of
    TProperty.Latitude: Success := Succeeded(Report.GetLatitude(Result));
    TProperty.Longitude: Success := Succeeded(Report.GetLongitude(Result));
    TProperty.ErrorRadius: Success := Succeeded(Report.GetErrorRadius(Result));
    TProperty.Altitude: Success := Succeeded(Report.GetAltitude(Result));
                                                                                                                        
    TProperty.Speed,
    TProperty.TrueHeading,
    TProperty.MagneticHeading:
      Success := True;
  else
    Success := False;
  end;

  if not Success then
    Result := 0;
end;

function TWindowsLocationSensor.GetReportDoubleProperty(
  const Report: ISensorDataReport;
  Prop: TCustomLocationSensor.TProperty): Double;
begin
  case Prop of
    TProperty.Latitude: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_LATITUDE_DEGREES);
    TProperty.Longitude: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_LONGITUDE_DEGREES);
    TProperty.ErrorRadius: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_ERROR_RADIUS_METERS);
    TProperty.Altitude: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_ALTITUDE_SEALEVEL_METERS);
    TProperty.Speed: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_SPEED_METERS_PER_SECOND);
    TProperty.TrueHeading: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_TRUE_HEADING_DEGREES);
    TProperty.MagneticHeading: Result := GetDoubleSensorData(FSensor, Report, SENSOR_DATA_TYPE_MAGNETIC_HEADING_DEGREES);
  else
    Result := 0;
  end;
end;

function TWindowsLocationSensor.GetReportStringProperty(
  const Report: ICivicAddressReport; Prop: TCustomLocationSensor.TProperty): String;
var
  Success: Boolean;
  Value: WideString;
begin
  case Prop of
    TProperty.Address1: Success := Succeeded(Report.GetAddressLine1(Value));
    TProperty.Address2: Success := Succeeded(Report.GetAddressLine2(Value));
    TProperty.City: Success := Succeeded(Report.GetCity(Value));
    TProperty.StateProvince: Success := Succeeded(Report.GetStateProvince(Value));
    TProperty.PostalCode: Success := Succeeded(Report.GetPostalCode(Value));
    TProperty.CountryRegion: Success := Succeeded(Report.GetCountryRegion(Value));
  else
    Success := False;
  end;

  if not Success then
    Value := '';

  Result := Value;
end;

function TWindowsLocationSensor.GetReportStringProperty(
  const Report: ISensorDataReport;
  Prop: TCustomLocationSensor.TProperty): String;
begin
  case Prop of
    TProperty.Address1: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_ADDRESS1);
    TProperty.Address2: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_ADDRESS2);
    TProperty.City: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_CITY);
    TProperty.StateProvince: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_STATE_PROVINCE);
    TProperty.PostalCode: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_POSTALCODE);
    TProperty.CountryRegion: Result := GetStringSensorData(FSensor, Report, SENSOR_DATA_TYPE_COUNTRY_REGION);
  else
    Result := '';
  end;
end;

function TWindowsLocationSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsLocationSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsLocationSensor.GetStringProperty(Prop: TCustomLocationSensor.TProperty): string;
var
  Success: Boolean;
begin
  Success := FSensor <> nil;
  if Success then
    if Optimize then
    begin
      // update the location CivReport
      Success := UpdateLocationReport(IID_ICivicAddressReport);
      if Success then
        Result := GetReportStringProperty(FLocationReport as ICivicAddressReport, Prop);
    end
    else
    begin
      Success := UpdateSensorReport;
      if Success then
        Result := GetReportStringProperty(FSensorReport, Prop);
    end;

  if not Success then
    Result := inherited GetStringProperty(Prop);
end;

function TWindowsLocationSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FSensorReport);
end;

procedure TWindowsLocationSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsLocationSensor.LocationChangedEvent(Sender: TObject;
  const Report: ILocationReport; const ReportType: TGUID);
var
  LocReport: ILatLongReport;
  NewLocation: TLocationCoord2D;
begin
  // trigger the location changed event
  if ReportType = IID_ILatLongReport then
  begin
    LocReport := Report as ILatLongReport;
    NewLocation.Latitude := GetReportDoubleProperty(LocReport, TProperty.Latitude);
    NewLocation.Longitude := GetReportDoubleProperty(LocReport, TProperty.Longitude);

    DoLocationChanged(FLastCoords, NewLocation);
  end;

  FLocationReport := Report;
end;

procedure TWindowsLocationSensor.RegionAdded(const Item: TLocationRegion);
begin
  // do nothing; no region support
end;

procedure TWindowsLocationSensor.RegionRemoved(const Item: TLocationRegion);
begin
  // do nothing; no region support
end;

procedure TWindowsLocationSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsLocationSensor.SetAccuracy(const Value: TLocationAccuracy);
begin
                                                                         
  // do nothing; the so called sensor accuracy can be changed using the
  // LocationChange property
end;

procedure TWindowsLocationSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsLocationSensor.SetDistance(const Value: TLocationDistance);
begin
                                                                             
  // do nothing; sensor information doesn't contain distance filter details
end;

procedure TWindowsLocationSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

function TWindowsLocationSensor.UpdateSensorReport: Boolean;
begin
  Result := Succeeded(FSensor.GetData(FSensorReport));
end;

{ TWindowsEnvironmentalSensor }

constructor TWindowsEnvironmentalSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsEnvironmentalSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsEnvironmentalSensor.GetAvailableProperties: TCustomEnvironmentalSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_ATMOSPHERIC_PRESSURE_BAR then
        Include(Res, TProperty.Pressure)
      else if Key = SENSOR_DATA_TYPE_TEMPERATURE_CELSIUS then
        Include(Res, TProperty.Temperature)
      else if Key = SENSOR_DATA_TYPE_RELATIVE_HUMIDITY_PERCENT then
        Include(Res, TProperty.Humidity)
      else if Key = SENSOR_DATA_TYPE_WIND_DIRECTION_DEGREES_ANTICLOCKWISE then
        Include(Res, TProperty.WindDirection)
      else if Key = SENSOR_DATA_TYPE_WIND_SPEED_METERS_PER_SECOND then
        Include(Res, TProperty.WindSpeed);
    end);
  Result := Res;
end;

function TWindowsEnvironmentalSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsEnvironmentalSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsEnvironmentalSensor.GetDoubleProperty(Prop: TCustomEnvironmentalSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.Temperature: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_TEMPERATURE_CELSIUS);
      TProperty.Pressure: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ATMOSPHERIC_PRESSURE_BAR);
      TProperty.Humidity: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_RELATIVE_HUMIDITY_PERCENT);
      TProperty.WindDirection: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_WIND_DIRECTION_DEGREES_ANTICLOCKWISE);
      TProperty.WindSpeed: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_WIND_SPEED_METERS_PER_SECOND);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsEnvironmentalSensor.GetEnvironmentalSensorType: TEnvironmentalSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_ENVIRONMENTAL_TEMPERATURE then
    Result := TEnvironmentalSensorType.Temperature
  else if SensType = SENSOR_TYPE_ENVIRONMENTAL_ATMOSPHERIC_PRESSURE then
    Result := TEnvironmentalSensorType.AtmosphericPressure
  else if SensType = SENSOR_TYPE_ENVIRONMENTAL_HUMIDITY then
    Result := TEnvironmentalSensorType.Humidity
  else if SensType = SENSOR_TYPE_ENVIRONMENTAL_WIND_SPEED then
    Result := TEnvironmentalSensorType.WindSpeed
  else if SensType = SENSOR_TYPE_ENVIRONMENTAL_WIND_DIRECTION then
    Result := TEnvironmentalSensorType.WindDirection
  else
    Result := TEnvironmentalSensorType(-1);
end;

function TWindowsEnvironmentalSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsEnvironmentalSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsEnvironmentalSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsEnvironmentalSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsEnvironmentalSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

procedure TWindowsEnvironmentalSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsEnvironmentalSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsEnvironmentalSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsEnvironmentalSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsOrientationSensor }

constructor TWindowsOrientationSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsOrientationSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsOrientationSensor.GetAvailableProperties: TCustomOrientationSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_TILT_X_DEGREES then
        Include(Res, TProperty.TiltX)
      else if Key = SENSOR_DATA_TYPE_TILT_Y_DEGREES then
        Include(Res, TProperty.TiltY)
      else if Key = SENSOR_DATA_TYPE_TILT_Z_DEGREES then
        Include(Res, TProperty.TiltZ)
      else if Key = SENSOR_DATA_TYPE_DISTANCE_X_METERS then
        Include(Res, TProperty.DistanceX)
      else if Key = SENSOR_DATA_TYPE_DISTANCE_Y_METERS then
        Include(Res, TProperty.DistanceY)
      else if Key = SENSOR_DATA_TYPE_DISTANCE_Z_METERS then
        Include(Res, TProperty.DistanceZ)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_X_DEGREES then
        Include(Res, TProperty.HeadingX)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_Y_DEGREES then
        Include(Res, TProperty.HeadingY)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_Z_DEGREES then
        Include(Res, TProperty.HeadingZ)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_MAGNETIC_NORTH_DEGREES then
        Include(Res, TProperty.MagHeading)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_TRUE_NORTH_DEGREES then
        Include(Res, TProperty.TrueHeading)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_MAGNETIC_NORTH_DEGREES then
        Include(Res, TProperty.CompMagHeading)
      else if Key = SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_TRUE_NORTH_DEGREES then
        Include(Res, TProperty.CompTrueHeading);
    end);
  Result := Res;
end;

function TWindowsOrientationSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsOrientationSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsOrientationSensor.GetDoubleProperty(Prop: TCustomOrientationSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.TiltX: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_TILT_X_DEGREES);
      TProperty.TiltY: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_TILT_Y_DEGREES);
      TProperty.TiltZ: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_TILT_Z_DEGREES);
      TProperty.DistanceX: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_DISTANCE_X_METERS);
      TProperty.DistanceY: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_DISTANCE_Y_METERS);
      TProperty.DistanceZ: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_DISTANCE_Z_METERS);
      TProperty.HeadingX: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_X_DEGREES);
      TProperty.HeadingY: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_Y_DEGREES);
      TProperty.HeadingZ: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_Z_DEGREES);
      TProperty.MagHeading: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_MAGNETIC_NORTH_DEGREES);
      TProperty.TrueHeading: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_TRUE_NORTH_DEGREES);
      TProperty.CompMagHeading: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_MAGNETIC_NORTH_DEGREES);
      TProperty.CompTrueHeading: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_MAGNETIC_HEADING_COMPENSATED_TRUE_NORTH_DEGREES);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsOrientationSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsOrientationSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsOrientationSensor.GetOrientationSensorType: TOrientationSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_COMPASS_1D then
    Result := TOrientationSensorType.Compass1D
  else if SensType = SENSOR_TYPE_COMPASS_2D then
    Result := TOrientationSensorType.Compass2D
  else if SensType = SENSOR_TYPE_COMPASS_3D then
    Result := TOrientationSensorType.Compass3D
  else if SensType = SENSOR_TYPE_INCLINOMETER_1D then
    Result := TOrientationSensorType.Inclinometer1D
  else if SensType = SENSOR_TYPE_INCLINOMETER_2D then
    Result := TOrientationSensorType.Inclinometer2D
  else if SensType = SENSOR_TYPE_INCLINOMETER_3D then
    Result := TOrientationSensorType.Inclinometer3D
  else if SensType = SENSOR_TYPE_DISTANCE_1D then
    Result := TOrientationSensorType.Distance1D
  else if SensType = SENSOR_TYPE_DISTANCE_2D then
    Result := TOrientationSensorType.Distance2D
  else if SensType = SENSOR_TYPE_DISTANCE_3D then
    Result := TOrientationSensorType.Distance3D
  else
    Result := TOrientationSensorType(-1);
end;

function TWindowsOrientationSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsOrientationSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsOrientationSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

function TWindowsOrientationSensor.GetUpdateInterval: Double;
begin
  Result := FUpdateInterval;
end;

procedure TWindowsOrientationSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsOrientationSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsOrientationSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsOrientationSensor.SetUpdateInterval(AInterval: Double);
begin
  FUpdateInterval := AInterval;
end;

procedure TWindowsOrientationSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsElectricalSensor }

constructor TWindowsElectricalSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsElectricalSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsElectricalSensor.GetAvailableProperties: TCustomElectricalSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_VOLTAGE_VOLTS then
        Include(Res, TProperty.Voltage)
      else if Key = SENSOR_DATA_TYPE_CURRENT_AMPS then
        Include(Res, TProperty.Current)
      else if Key = SENSOR_DATA_TYPE_ELECTRICAL_POWER_WATTS then
        Include(Res, TProperty.Power)
      else if Key = SENSOR_DATA_TYPE_RESISTANCE_OHMS then
        Include(Res, TProperty.Resistance)
      else if Key = SENSOR_DATA_TYPE_CAPACITANCE_FARAD then
        Include(Res, TProperty.Capacitance)
      else if Key = SENSOR_DATA_TYPE_INDUCTANCE_HENRY then
        Include(Res, TProperty.Inductance);
    end);
  Result := Res;
end;

function TWindowsElectricalSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsElectricalSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsElectricalSensor.GetDoubleProperty(Prop: TCustomElectricalSensor.TProperty): Double;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TProperty.Capacitance: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_CAPACITANCE_FARAD);
      TProperty.Current: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_CURRENT_AMPS);
      TProperty.Resistance: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_RESISTANCE_OHMS);
      TProperty.Inductance: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_INDUCTANCE_HENRY);
      TProperty.Voltage: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_VOLTAGE_VOLTS);
      TProperty.Power: Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_ELECTRICAL_POWER_WATTS);
    else
      Result := inherited GetDoubleProperty(Prop);
    end;
  end else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsElectricalSensor.GetElectricalSensorType: TElectricalSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_VOLTAGE then
    Result := TElectricalSensorType.Voltage
  else if SensType = SENSOR_TYPE_CURRENT then
    Result := TElectricalSensorType.Current
  else if SensType = SENSOR_TYPE_RESISTANCE then
    Result := TElectricalSensorType.Resistance
  else if SensType = SENSOR_TYPE_ELECTRICAL_POWER then
    Result := TElectricalSensorType.ElectricalPower
  else if SensType = SENSOR_TYPE_CAPACITANCE then
    Result := TElectricalSensorType.Capacitance
  else if SensType = SENSOR_TYPE_INDUCTANCE then
    Result := TElectricalSensorType.Inductance
  else if SensType = SENSOR_TYPE_POTENTIOMETER then
    Result := TElectricalSensorType.Potentiometer
  else
    Result := TElectricalSensorType(-1);
end;

function TWindowsElectricalSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsElectricalSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsElectricalSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsElectricalSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsElectricalSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

procedure TWindowsElectricalSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsElectricalSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsElectricalSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsElectricalSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsBiometricSensor }

constructor TWindowsBiometricSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsBiometricSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsBiometricSensor.GetAvailableProperties: TCustomBiometricSensor.TProperties;
var
  Res: TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_HUMAN_PRESENCE then
        Include(Res, TProperty.HumanPresence)
      else if Key = SENSOR_DATA_TYPE_HUMAN_PROXIMITY_METERS then
        Include(Res, TProperty.HumanProximity)
      else if Key = SENSOR_DATA_TYPE_TOUCH_STATE then
        Include(Res, TProperty.Touch);
    end);
  Result := Res;
end;

function TWindowsBiometricSensor.GetBiometricSensorType: TBiometricSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_HUMAN_PRESENCE then
    Result := TBiometricSensorType.HumanPresence
  else if SensType = SENSOR_TYPE_HUMAN_PROXIMITY then
    Result := TBiometricSensorType.HumanProximity
  else if SensType = SENSOR_TYPE_TOUCH then
    Result := TBiometricSensorType.Touch
  else
    Result := TBiometricSensorType(-1);
end;

function TWindowsBiometricSensor.GetBooleanProperty(Prop: TCustomBiometricSensor.TProperty): Boolean;
begin
  if FSensor <> nil then
  begin
    case Prop of
      TCustomBiometricSensor.TProperty.HumanPresence: Result := GetBooleanSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_HUMAN_PRESENCE);
      TCustomBiometricSensor.TProperty.Touch: Result := GetBooleanSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_TOUCH_STATE);
    else
      Result := inherited GetBooleanProperty(Prop);
    end;
  end else
    Result := inherited GetBooleanProperty(Prop);
end;

function TWindowsBiometricSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsBiometricSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsBiometricSensor.GetDoubleProperty(Prop: TCustomBiometricSensor.TProperty): Double;
begin
  if (FSensor <> nil) and (Prop = TProperty.HumanProximity) then
    Result := GetDoubleSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_HUMAN_PROXIMITY_METERS)
  else
    Result := inherited GetDoubleProperty(Prop);
end;

function TWindowsBiometricSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsBiometricSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsBiometricSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsBiometricSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsBiometricSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

procedure TWindowsBiometricSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsBiometricSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsBiometricSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsBiometricSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TWindowsScannerSensor }

constructor TWindowsScannerSensor.Create(AManager: TSensorManager; const ASensor: ISensor);
begin
  inherited Create(AManager);
  FSensor := ASensor;
  if FSensor <> nil then
    OleCheck(FSensor.SetEventSink(TSensorEventSink.Create(DataUpdatedEvent, SensorEvent, LeaveEvent, StateChangeEvent)));
end;

procedure TWindowsScannerSensor.DataUpdatedEvent(Sender: TObject; const Sensor: ISensor; const NewData: ISensorDataReport);
begin
  FDataReport := NewData;
  try
    DataChanged;
  finally
    FDataReport := nil;
  end;
end;

function TWindowsScannerSensor.GetAvailableProperties: TCustomScannerSensor.TProperties;
var
  Res: TCustomScannerSensor.TProperties;
begin
  Res := [];
  TWindowsSensorManager.GetAvailableProperties(FSensor, procedure (Key: TPropertyKey)
    begin
      if Key = SENSOR_DATA_TYPE_RFID_TAG_40_BIT then
        Include(Res, TProperty.RFIDTag);
    end);
  Result := Res;
end;

function TWindowsScannerSensor.GetCustomData(const Data): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorData(FSensor, FDataReport, TPropertyKey(Data));
end;

function TWindowsScannerSensor.GetCustomProperty(const Prop): Variant;
begin
  Result := TWindowsSensorManager.GetCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsScannerSensor.GetHasCustomData(const Data): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorData(FSensor, TPropertyKey(Data));
end;

function TWindowsScannerSensor.GetHasCustomProperty(const Prop): Boolean;
begin
  Result := TWindowsSensorManager.GetHasCustomSensorProperty(FSensor, TPropertyKey(Prop));
end;

function TWindowsScannerSensor.GetScannerSensorType: TScannerSensorType;
var
  SensType: TGuid;
begin
  OleCheck(FSensor.GetType(SensType));
  if SensType = SENSOR_TYPE_RFID_SCANNER then
    Result := TScannerSensorType.RFID
  else
    Result := TScannerSensorType(-1);
end;

function TWindowsScannerSensor.GetSensorProperty(Prop: TCustomSensor.TProperty): string;
begin
  Result := TWindowsSensorManager.GetSensorProperty(FSensor, Prop);
end;

function TWindowsScannerSensor.GetState: TSensorState;
begin
  Result := TWindowsSensorManager.GetSensorState(FSensor);
end;

function TWindowsScannerSensor.GetTimeStamp: TDateTime;
begin
  Result := TWindowsSensorManager.GetTimeStamp(FSensor, FDataReport);
end;

function TWindowsScannerSensor.GetUInt64Property(Prop: TCustomScannerSensor.TProperty): UInt64;
var
  Value: TPropVariant;
begin
  if Prop = TProperty.RFIDTag then
  begin
    Value := GetSensorData(FSensor, FDataReport, SENSOR_DATA_TYPE_RFID_TAG_40_BIT);
    Result := Value.uhVal.QuadPart;
  end else
    Result := inherited GetUInt64Property(Prop);
end;

procedure TWindowsScannerSensor.LeaveEvent(Sender: TObject; const ID: TGUID);
var
  ThisID: TGuid;
begin
  OleCheck(FSensor.GetID(ThisID));
  if ThisID = ID then
    RemoveSensor;
end;

procedure TWindowsScannerSensor.SensorEvent(Sender: TObject; const Sensor: ISensor; const EventID: TGUID; const EventData: IPortableDeviceValues);
begin

end;

procedure TWindowsScannerSensor.SetCustomProperty(const Prop; const Value: Variant);
begin
  TWindowsSensorManager.SetCustomSensorProperty(FSensor, TPropertyKey(Prop), Value);
end;

procedure TWindowsScannerSensor.StateChangeEvent(Sender: TObject; const Sensor: ISensor; State: SensorState);
begin
  StateChanged;
end;

{ TPlatformGeocoder }

class function TPlatformGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := TWindowsGeocoder;
end;

{ TWinGeocoder }

class function TWindowsGeocoder.Authorized: TAuthorizationType;
begin
  Result := TAuthorizationType.atNotSpecified;
end;

class procedure TWindowsGeocoder.Cancel;
begin
  // do nothing; requests are done synchronous
end;

class function TWindowsGeocoder.Supported: Boolean;
begin
  Result := False;
end;

class procedure TWindowsGeocoder.GeocodeRequest(const Address: TCivicAddress);
begin
  // do nothing
end;

class procedure TWindowsGeocoder.GeocodeReverseRequest(const Coords: TLocationCoord2D);
begin
  // do nothing
end;

class function TWindowsGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := Self;
end;

{ TWinGpsStatus }

class function TWindowsGpsStatus.Authorized: TAuthorizationType;
begin
                                                                                    
// system dialog, which isn't quite proper for a framework
  Result := TAuthorizationType.atNotSpecified;
end;

class procedure TWindowsGpsStatus.CheckIndex(Index: Integer);
begin
  if (Index < 0) or (Index > SatelliteCount) then
    GpsStatusError(Format(SListIndexError, [Index]));
end;

class constructor TWindowsGpsStatus.Create;
begin
  ComInit;
end;

class destructor TWindowsGpsStatus.Destroy;
begin
  FSelector.Free;
  ComDone;
end;

class function TWindowsGpsStatus.GetGpsStatusImplementer: TGpsStatusClass;
begin
  Result := Self;
end;

class procedure TWindowsGpsStatus.Initialize;
var
  HR: HRESULT;
begin
  inherited;

  HR := CoCreateInstance(CLSID_SensorManager, nil, CLSCTX_INPROC_SERVER, IID_ISensorManager, FManager);
  if Succeeded(HR) then
  begin
    FSelector := TSensorSelector.Create(FManager);
    FSelector.OnRankSensor := RankSensorHandler;
    FManager.SetEventSink(TManagerEvents.Create);

    FSelector.ObtainSensor;
  end;
end;

class function TWindowsGpsStatus.IsReady: Boolean;
var
  State: SensorState;
begin
  Result := Supported
       and (Authorized <> TAuthorizationType.atUnauthorized)
       and  Assigned(FSelector)
       and  Assigned(FSelector.FSensor)
       and  Succeeded(FSelector.FSensor.GetState(State))
       and (State = SENSOR_STATE_READY);
end;

class procedure TWindowsGpsStatus.RankSensorHandler(const Sensor: ISensor;
  var Rank: Integer);
begin
  Rank :=
    Ord(TSensorSelector.SupportsDataField(Sensor, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW)) +
    Ord(TSensorSelector.SupportsDataField(Sensor, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_AZIMUTH)) +
    Ord(TSensorSelector.SupportsDataField(Sensor, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_ELEVATION)) +
    Ord(TSensorSelector.SupportsDataField(Sensor, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_PRNS)) +
    Ord(TSensorSelector.SupportsDataField(Sensor, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_STN_RATIO));
end;

constructor TSensorSelector.Create(const Manager: ISensorManager);
begin

end;

procedure TSensorSelector.ObtainSensor;
var
  Sensors: ISensorCollection;
  Current: ISensor;
  State: SensorState;
  Rank: Integer;
  MaxRank: Integer;
  MaxRankSensor: ISensor;
  Count: Cardinal;
  i: Integer;
begin
  FSensor := nil;
  if Assigned(FOnRankSensor) and
     Succeeded(FManager.GetSensorsByCategory(SENSOR_CATEGORY_LOCATION, Sensors)) and
     Succeeded(Sensors.GetCount(Count)) then
    if Count > 0 then
    begin
      // determine the sensor that can give the most complete set of Gps status details
      MaxRank := -1;
      for i := 0 to Count - 1 do
        if Succeeded(Sensors.GetAt(i, Current)) and
           Succeeded(Current.GetState(State)) and
          (State = SENSOR_STATE_READY) then
        begin
          OnRankSensor(Current, Rank);
          if MaxRank < Rank then
          begin
            MaxRank := Rank;
            MaxRankSensor := Current;
          end;
        end;

      FSensor := MaxRankSensor;
    end;
end;

class function TWindowsGpsStatus.SatelliteCount: Integer;
begin
                                                      
  if IsReady and FSelector.UpdateDataReport then
    Result := GetIntegerSensorData(FSelector.FSensor, FSelector.FDataReport, SENSOR_DATA_TYPE_SATELLITES_IN_VIEW)
  else
    Result := 0;
end;

class function TWindowsGpsStatus.SatelliteFirstFixTime: Integer;
begin
                                                                                
  Result := 0;
end;

class function TWindowsGpsStatus.Satellites(Index: Integer): TGpsSatellite;
var
  Azimuth: Integer;
  Elevation: Integer;
  Prns: Integer;
  Snr: Integer;
begin
                                                      
  Azimuth := 0;
  Elevation := 0;
  Prns := 0;
  Snr := 0;
  if IsReady and FSelector.UpdateDataReport then
  begin
    CheckIndex(Index);

    // get the values for the Index-th satellite
    Azimuth := GetIntegerArrayValueSensorData(FSelector.FSensor, FSelector.FDataReport,
      SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_AZIMUTH, Index);
    Elevation := GetIntegerArrayValueSensorData(FSelector.FSensor, FSelector.FDataReport,
      SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_ELEVATION, Index);
    Prns := GetIntegerArrayValueSensorData(FSelector.FSensor, FSelector.FDataReport,
      SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_PRNS, Index);
    Snr := GetIntegerArrayValueSensorData(FSelector.FSensor, FSelector.FDataReport,
      SENSOR_DATA_TYPE_SATELLITES_IN_VIEW_STN_RATIO, Index);
  end;

  Result := TGpsSatellite.Create(Azimuth, Elevation, Prns, Snr, False, False, False);
end;

class function TWindowsGpsStatus.Supported: Boolean;
begin
  Result := CheckWin32Version(6, 1);
end;

class function TSensorSelector.SupportsDataField(const Sensor: ISensor;
  const Field: TPropertyKey): Boolean;
var
  Supported: VARIANT_BOOL;
begin
  Result := Succeeded(Sensor.SupportsDataField(Field, Supported)) and
            WordBool(Supported);
end;

function TSensorSelector.UpdateDataReport: Boolean;
begin
  Result := Succeeded(FSensor.GetData(FDataReport));
end;

{ TPlatformGpsStatus }

class function TPlatformGpsStatus.GetGpsStatusImplementer: TGpsStatusClass;
begin
  Result := TWindowsGpsStatus;
end;

{ TWindowsGpsStatus.TManagerEvents }

function TWindowsGpsStatus.TManagerEvents.OnSensorEnter(const pSensor: ISensor;
  state: SensorState): HRESULT;
begin
                                                                                
// and now a sensor has been added, check if it's a GPS sensor and if it supports
// satellite information; if so, use it

                                                                                  
  Result := E_NOINTERFACE;
  if (TWindowsGpsStatus.Supported) and
     (TWindowsGpsStatus.Authorized <> TAuthorizationType.atUnauthorized) and
      Assigned(TWindowsGpsStatus.FSelector) then
  begin
    TWindowsGpsStatus.FSelector.ObtainSensor;

    if Assigned(TWindowsGpsStatus.FSelector.FSensor) then
      Result := S_OK;
  end;
                                                                             
end;

{ TLocationEventSink }

constructor TLocationEventSink.Create(LocationChanged: TLocationChangedEvent);
begin
  inherited Create;

  FLocationChanged := LocationChanged;
end;

function TLocationEventSink.OnLocationChanged(const reportType: TIID;
  const pLocationReport: ILocationReport): HRESULT;
begin
  try
    if Assigned(FLocationChanged) then
      FLocationChanged(Self, pLocationReport, reportType);
    Result := S_OK;
                                                                             
  except
    Result := E_UNEXPECTED;
  end;
end;

function TLocationEventSink.OnStatusChanged(const reportType: TIID;
  newStatus: LOCATION_REPORT_STATUS): HRESULT;
begin
                                                                           
  Result := S_OK;
end;

end.
