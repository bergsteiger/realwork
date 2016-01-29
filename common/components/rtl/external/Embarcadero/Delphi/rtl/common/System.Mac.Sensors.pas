{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Mac.Sensors;

interface

uses
  System.Sensors,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreLocation,
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
  System.SysUtils,
  System.Math,
  Macapi.Foundation;

function ConvNSStr(const Value: NSString): String;
begin
  if Assigned(Value) then
    Result := String(UTF8String(Value.UTF8String))
  else
    Result := '';
end;

function ConvCLLocationCoord(const Value: CLLocationCoordinate2D): TLocationCoord2D;
begin
  Result := TLocationCoord2D.Create(Value.latitude, Value.longitude);
end;

function ConvCLLocation(const Value: CLLocation): TLocationCoord2D;
begin
  if Assigned(Value) then
    Result := ConvCLLocationCoord(Value.coordinate)
  else
    Result := TLocationCoord2D.Create(0, 0);
end;

function ConvLocationRegion(const Region: TLocationRegion): CLRegion;
var
  Center: CLLocationCoordinate2D;
  UniqueID: NSString;
begin
  Center := CLLocationCoordinate2DMake(Region.Center.Latitude, Region.Center.Longitude);
  UniqueID := TNSString.Wrap(TNSString.OCClass.stringWithUTF8String(PAnsiChar(UTF8String(Region.ID))));

  // create the region object and add it for monitorization
  Result := TCLRegion.Wrap(TCLRegion.Create.initCircularRegionWithCenter(Center, Region.Radius , UniqueID));
end;

function ConvCLRegion(const Region: CLRegion): TLocationRegion;
begin
  Result := TLocationRegion.Create(
    ConvCLLocationCoord(Region.center),
    Region.radius,
    ConvNSStr(Region.identifier));
end;

type
  TMacLocationSensor = class;

  TMacLocationSensorNotifHandler = class(TOCLocal, CLLocationManagerDelegate)
  private
    FSensor: TMacLocationSensor;
  public
    { CLLocationManagerDelegate }
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didEnterRegion: CLRegion); overload; cdecl;
                                                                    
//      procedure locationManager(manager: CLLocationManager; didExitRegion: CLRegion); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); overload; cdecl;

    constructor Create(Sensor: TMacLocationSensor);
  end;

  TMacLocationSensor = class(TCustomLocationSensor)
  private var
    FLocater: CLLocationManager;
    FDelegate: CLLocationManagerDelegate;
    FLocation: CLLocation;
    FSensorState: TSensorState;
  protected
    function GetState: TSensorState; override;
    function GetTimeStamp: TDateTime; override;
    function GetLocationSensorType: TLocationSensorType; override;
    // the sensor doesn't support properties such as address, city, street name etc
    // because they can be easily obtain using the Geocoder class
    function GetAvailableProperties: TCustomLocationSensor.TProperties; override;
    function GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double; override;

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

    constructor Create(AManager: TSensorManager); override;
  public
    destructor Destroy; override;
  end;

  TMacSensorManager = class(TPlatformSensorManager)
  private
    FActive: Boolean;
  protected
    function GetCanActivate: Boolean; override;
    function GetActive: Boolean; override;
  public
    procedure Activate; override;
    procedure Deactivate; override;
  end;

  TMacGeocoder = class(TGeocoder)
  protected
    class function GetGeocoderImplementer: TGeocoderClass; override;

    class procedure GeocodeRequest(const Address: TCivicAddress); override;
    class procedure GeocodeReverseRequest(const Coords: TLocationCoord2D); override;
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class procedure Cancel; override;
  end;

  TMacGpsStatus = class(TGpsStatus)
  public
    class function Supported: Boolean; override;
    class function Authorized: TAuthorizationType; override;
    class function Satellites(Index: Integer): TGpsSatellite; override;
    class function SatelliteCount: Integer; override;
    class function SatelliteFirstFixTime: Integer; override;
  end;

{ TPlatformSensorManager }

class function TPlatformSensorManager.GetSensorManager: TSensorManager;
begin
  Result := TMacSensorManager.Create;
end;

{ TMacSensorManager }

procedure TMacSensorManager.Activate;
begin
                                                                              
// For now add only the location sensor
  if not Active then
  begin
    FActive := True;

    // automatically adds itself to the internal list of the manager
    TMacLocationSensor.Create(Self);
  end;
end;

procedure TMacSensorManager.Deactivate;
var
  i: Integer;
begin
                                                      
  FActive := False;

  for i := Count - 1 downto 0 do
    RemoveSensor(Sensors[i]);
end;

function TMacSensorManager.GetActive: Boolean;
begin
                                                      
  Result := FActive;
end;

function TMacSensorManager.GetCanActivate: Boolean;
begin
                                                                       
  Result := True;
end;

{ TMacLocationSensor }

constructor TMacLocationSensor.Create(AManager: TSensorManager);
var
  Handler: TMacLocationSensorNotifHandler;
begin
  inherited;

  // create and retain the delegate
  Handler := TMacLocationSensorNotifHandler.Create(Self);
  FDelegate := Handler;

  // create the location manager and attach the delegate
  FLocater := TCLLocationManager.Create;
  FLocater.retain;
                                                  
  FLocater.setDelegate(Handler.GetObjectID);

  FLocation := TCLLocation.Create;
end;

destructor TMacLocationSensor.Destroy;
begin
  FLocater.release;

  inherited;
end;

procedure TMacLocationSensor.DoLocationChangeType;
begin
  // do nothing; location change type values influence the way notifications
  // will be done the next time the sensor is started
end;

procedure TMacLocationSensor.DoOptimize;
begin
  // do nothing; the location services on iOS are already optimized
  // by selecting the appropriate sensor (GPS, Wifi, cell towers) to determine
  // the best location
end;

function TMacLocationSensor.DoStart: Boolean;
begin
  try
    // check authorization
    if Authorized = TAuthorizationType.atUnauthorized then
      SensorError(SLocationServiceUnauthorized);
    // check if location sensor is enabled
    if not FLocater.locationServicesEnabled then
      SensorError(SLocationServiceDisabled);

    // start location updates
    FLocater.startUpdatingLocation;
    Result := FLocater.locationServicesEnabled;
  except on Exception do
    begin
      Result := False;
      raise;
    end;
  end;
end;

procedure TMacLocationSensor.DoStop;
begin
  // stop the location update
  FLocater.stopUpdatingLocation;
end;

function TMacLocationSensor.GetAccuracy: TLocationAccuracy;
begin
                                                      
  Result := FLocater.desiredAccuracy
end;

function TMacLocationSensor.GetAuthorized: TAuthorizationType;
begin
                                                      
  case TCLLocationManager.OCClass.authorizationStatus of
    kCLAuthorizationStatusNotDetermined:
      Result := TAuthorizationType.atNotSpecified;
    kCLAuthorizationStatusDenied,
    kCLAuthorizationStatusRestricted:
      Result := TAuthorizationType.atUnauthorized;
    kCLAuthorizationStatusAuthorized:
      Result := TAuthorizationType.atAuthorized;
  else // avoids compiler warnings
    Result := TAuthorizationType.atNotSpecified;
  end;
end;

function TMacLocationSensor.GetAvailableProperties: TCustomLocationSensor.TProperties;
begin
  Result := [];
  if (Authorized <> TAuthorizationType.atUnauthorized) and
      FLocater.locationServicesEnabled then
    Result := [TProperty.Latitude, TProperty.Longitude, TProperty.Altitude, TProperty.Speed];
end;

function TMacLocationSensor.GetDistance: TLocationDistance;
begin
                                                      
  Result := FLocater.distanceFilter;
end;

function TMacLocationSensor.GetDoubleProperty(Prop: TCustomLocationSensor.TProperty): Double;
begin
  case Prop of
    TProperty.Latitude:
      Result := FLocation.coordinate.latitude;
    TProperty.Longitude:
      Result := FLocation.coordinate.longitude;
    TProperty.Speed:
      Result := FLocation.speed;
    TProperty.Altitude:
      Result := FLocation.altitude;
                                                                                          
    TProperty.ErrorRadius:
      Result := 0;
  else
    Result := NaN;
  end;
end;

function TMacLocationSensor.GetLocationSensorType: TLocationSensorType;
begin
                                                                           
// based on internal mechanisms of selection between GPS, Wifi, cell towers;
// there is no way to query from which of these the location information comes
  Result := TLocationSensorType.Other;
end;

function TMacLocationSensor.GetPowerConsumption: TPowerConsumption;
begin
  Result := TPowerConsumption.pcNotSpecified;
end;

function TMacLocationSensor.GetState: TSensorState;
begin
                                                      
  Result := FSensorState;
end;

function TMacLocationSensor.GetTimeStamp: TDateTime;
begin
                                                      
  Result := 0;
end;

procedure TMacLocationSensor.RegionAdded(const Item: TLocationRegion);
begin
  // no region support
end;

procedure TMacLocationSensor.RegionRemoved(const Item: TLocationRegion);
begin
  // no region support
end;

procedure TMacLocationSensor.SetAccuracy(const Value: TLocationAccuracy);
begin
                                                      
  FLocater.setDesiredAccuracy(Value);
end;

procedure TMacLocationSensor.SetDistance(const Value: TLocationDistance);
begin
                                                      
  FLocater.setDistanceFilter(Value);
end;

{ TMacGpsStatus }

class function TMacGpsStatus.Authorized: TAuthorizationType;
begin
                                                                                                         
  Result := TAuthorizationType.atUnauthorized;
end;

class function TMacGpsStatus.SatelliteCount: Integer;
begin
  Result := 0;
end;

class function TMacGpsStatus.SatelliteFirstFixTime: Integer;
begin
  Result := 0;
end;

class function TMacGpsStatus.Satellites(Index: Integer): TGpsSatellite;
begin
  Result := TGpsSatellite.Create(0, 0, 0, 0, False, False, False);
end;

class function TMacGpsStatus.Supported: Boolean;
begin
  Result := False;
end;

{ TMacGeocoder }

class function TMacGeocoder.Authorized: TAuthorizationType;
begin
  Result := TAuthorizationType.atNotSpecified;
end;

class procedure TMacGeocoder.Cancel;
begin
  // do nothing
end;

class function TMacGeocoder.Supported: Boolean;
begin
  // MacOS cannot obtain geocode information
  Result := False;
end;

class procedure TMacGeocoder.GeocodeRequest(const Address: TCivicAddress);
begin
  // do nothing
end;

class procedure TMacGeocoder.GeocodeReverseRequest(const Coords: TLocationCoord2D);
begin
  // do nothing
end;

class function TMacGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := Self;
end;

{ TMacLocationSensor.TNotifHandler }

constructor TMacLocationSensorNotifHandler.Create(Sensor: TMacLocationSensor);
begin
  inherited Create;

  FSensor := Sensor;
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager; didEnterRegion: CLRegion);
begin
  // no region support
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager;
  didChangeAuthorizationStatus: CLAuthorizationStatus);
begin
  if (didChangeAuthorizationStatus <> kCLAuthorizationStatusAuthorized) and FSensor.Started then
  begin
    FSensor.FSensorState := TSensorState.AccessDenied;
    FSensor.Stop;
  end
  else if didChangeAuthorizationStatus = kCLAuthorizationStatusAuthorized then
    FSensor.Start; // Start the sensor if it has now become authorized.
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager; didFailWithError: NSError);
begin
                                              
  case didFailWithError.code of
    kCLErrorLocationUnknown: // can't get a location right now; wait for a new event
      FSensor.FSensorState := TSensorState.Error;
    kCLErrorDenied: // user denied usage of location services
      begin
        FSensor.FSensorState := TSensorState.AccessDenied;
        FSensor.Stop;
      end;
    kCLErrorHeadingFailure: // strong interference from nearby magnetic fields
      FSensor.FSensorState := TSensorState.Error;
  end;
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager; monitoringDidFailForRegion: CLRegion;
  withError: NSError);
begin
  // no region support
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager; didUpdateHeading: CLHeading);
begin
  // no heading support
end;

procedure TMacLocationSensorNotifHandler.locationManager(
  manager: CLLocationManager; didUpdateToLocation, fromLocation: CLLocation);
begin
  FSensor.FSensorState := TSensorState.Ready;

  // store the new location internally and trigger the event
  FSensor.FLocation := didUpdateToLocation;
  FSensor.DoLocationChanged(
    ConvCLLocation(fromLocation),
    ConvCLLocation(FSensor.FLocation));

  FSensor.FSensorState := TSensorState.NoData;
end;

{ TPlatformGeocoder }

class function TPlatformGeocoder.GetGeocoderImplementer: TGeocoderClass;
begin
  Result := TMacGeocoder;
end;

{ TPlatformGpsStatus }

class function TPlatformGpsStatus.GetGpsStatusImplementer: TGpsStatusClass;
begin
  Result := TMacGpsStatus;
end;

end.
