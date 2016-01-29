{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework CoreLocation
//

unit Macapi.CoreLocation;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreFoundation,
  Macapi.Foundation,
  Macapi.CoreServices;


const
  CLDeviceOrientationFaceDown = 6;
  CLDeviceOrientationFaceUp = 5;
  CLDeviceOrientationLandscapeLeft = 3;
  CLDeviceOrientationLandscapeRight = 4;
  CLDeviceOrientationPortrait = 1;
  CLDeviceOrientationPortraitUpsideDown = 2;
  CLDeviceOrientationUnknown = 0;
  kCLAuthorizationStatusAuthorized = 3;
  kCLAuthorizationStatusDenied = 2;
  kCLAuthorizationStatusNotDetermined = 0;
  kCLAuthorizationStatusRestricted = 1;
  kCLErrorDenied = 1;
  kCLErrorGeocodeCanceled = 8;
  kCLErrorGeocodeFoundNoResult = 7;
  kCLErrorHeadingFailure = 3;
  kCLErrorLocationUnknown = 0;
  kCLErrorNetwork = 2;
  kCLErrorRegionMonitoringDenied = 4;
  kCLErrorRegionMonitoringFailure = 5;
  kCLErrorRegionMonitoringSetupDelayed = 6;
  kCLLocationAccuracyThreeKilometers: Double = 3000;
  kCLLocationAccuracyKilometer: Double = 1000;
  kCLLocationAccuracyHundredMeters: Double = 100;
  kCLLocationAccuracyNearestTenMeters: Double = 10;
  kCLLocationAccuracyBest: Double = -1;
  kCLLocationAccuracyBestForNavigation: Double = -1;

// ===== External functions =====

const
  libCoreLocation = '/System/Library/Frameworks/CoreLocation.framework/CoreLocation';

function CLLocationCoordinate2DIsValid(coord: CLLocationCoordinate2D): Boolean; cdecl; external libCoreLocation name _PU + 'CLLocationCoordinate2DIsValid';
function CLLocationCoordinate2DMake(latitude: CLLocationDegrees; longitude: CLLocationDegrees): CLLocationCoordinate2D; cdecl; external libCoreLocation name _PU + 'CLLocationCoordinate2DMake';

type
{$M+}
  CLGeocodeCompletionHandler = procedure (placemark: NSArray; error: NSError); cdecl;

// ===== Forward declarations =====

  CLLocationManagerDelegate = interface;
  CLRegion = interface;
  CLLocationManager = interface;
  CLHeading = interface;
  CLLocation = interface;

// ===== Protocol declarations =====

  CLLocationManagerDelegate = interface(IObjectiveC)
    ['{C1794A16-F4FB-46E1-839E-2AFBA43B420C}']
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didEnterRegion: CLRegion); cdecl; overload;
//    procedure locationManager(manager: CLLocationManager; didExitRegion: CLRegion); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); cdecl; overload;
  end;

// ===== Interface declarations =====

  CLRegionClass = interface(NSObjectClass)
    ['{62C51662-3A90-463A-9C31-5D45CDB004AC}']
  end;
  CLRegion = interface(NSObject)
    ['{50793CC2-978B-4644-B537-0196EAA64600}']
    function center: CLLocationCoordinate2D; cdecl;
    function containsCoordinate(coordinate: CLLocationCoordinate2D): Boolean; cdecl;
    function identifier: NSString; cdecl;
    function initCircularRegionWithCenter(center: CLLocationCoordinate2D; radius: CLLocationDistance; identifier: NSString): Pointer; cdecl;
    function radius: CLLocationDistance; cdecl;
  end;
  TCLRegion = class(TOCGenericImport<CLRegionClass, CLRegion>)  end;

  CLLocationManagerClass = interface(NSObjectClass)
    ['{3CC7BE63-B046-41DA-B978-35C936450EE6}']
    {class} function authorizationStatus: CLAuthorizationStatus; cdecl;
    {class} function headingAvailable: Boolean; cdecl; overload;
    {class} function locationServicesEnabled: Boolean; cdecl; overload;
    {class} function regionMonitoringAvailable: Boolean; cdecl;
    {class} function regionMonitoringEnabled: Boolean; cdecl;
    {class} function significantLocationChangeMonitoringAvailable: Boolean; cdecl;
  end;
  CLLocationManager = interface(NSObject)
    ['{18FCE1C9-75EA-4241-8B11-EE7001751A9A}']
    function delegate: Pointer; cdecl;
    function desiredAccuracy: CLLocationAccuracy; cdecl;
    function distanceFilter: CLLocationDistance; cdecl;
    function heading: CLHeading; cdecl;
    function headingAvailable: Boolean; cdecl; overload;
    function headingFilter: CLLocationDegrees; cdecl;
    function headingOrientation: CLDeviceOrientation; cdecl;
    function location: CLLocation; cdecl;
    function locationServicesEnabled: Boolean; cdecl; overload;
    function maximumRegionMonitoringDistance: CLLocationDistance; cdecl;
    function monitoredRegions: NSSet; cdecl;
    function purpose: NSString; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDesiredAccuracy(desiredAccuracy: CLLocationAccuracy); cdecl;
    procedure setDistanceFilter(distanceFilter: CLLocationDistance); cdecl;
    procedure setHeadingFilter(headingFilter: CLLocationDegrees); cdecl;
    procedure setHeadingOrientation(headingOrientation: CLDeviceOrientation); cdecl;
    procedure setPurpose(purpose: NSString); cdecl;
    procedure startMonitoringForRegion(region: CLRegion; desiredAccuracy: CLLocationAccuracy); cdecl;
    procedure startMonitoringSignificantLocationChanges; cdecl;
    procedure startUpdatingLocation; cdecl;
    procedure startUpdatingHeading; cdecl;
    procedure stopMonitoringForRegion(region: CLRegion); cdecl;
    procedure stopMonitoringSignificantLocationChanges; cdecl;
    procedure stopUpdatingLocation; cdecl;
    procedure stopUpdatingHeading; cdecl;
  end;
  TCLLocationManager = class(TOCGenericImport<CLLocationManagerClass, CLLocationManager>)  end;

  CLHeadingClass = interface(NSObjectClass)
    ['{E3201428-17D7-40D6-A2EF-9027EE805D0D}']
  end;
  CLHeading = interface(NSObject)
    ['{857892E6-B27F-41AF-8453-C5FC06749036}']
    function description: NSString; cdecl;
    function headingAccuracy: CLLocationDirection; cdecl;
    function magneticHeading: CLLocationDirection; cdecl;
    function timestamp: NSDate; cdecl;
    function trueHeading: CLLocationDirection; cdecl;
    function x: CLHeadingComponentValue; cdecl;
    function y: CLHeadingComponentValue; cdecl;
    function z: CLHeadingComponentValue; cdecl;
  end;
  TCLHeading = class(TOCGenericImport<CLHeadingClass, CLHeading>)  end;

  CLLocationClass = interface(NSObjectClass)
    ['{98A66CA8-FA11-4EC3-81E3-273133918EE8}']
  end;
  CLLocation = interface(NSObject)
    ['{8C03621F-A0B3-45CE-AE21-63055C6445AC}']
    function altitude: CLLocationDistance; cdecl;
    function coordinate: CLLocationCoordinate2D; cdecl;
    function course: CLLocationDirection; cdecl;
    function description: NSString; cdecl;
    function distanceFromLocation(location: CLLocation): CLLocationDistance; cdecl;
    function horizontalAccuracy: CLLocationAccuracy; cdecl;
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; horizontalAccuracy: CLLocationAccuracy; verticalAccuracy: CLLocationAccuracy; course: CLLocationDirection; speed: CLLocationSpeed; timestamp: NSDate): Pointer; cdecl; overload;
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; horizontalAccuracy: CLLocationAccuracy; verticalAccuracy: CLLocationAccuracy; timestamp: NSDate): Pointer; cdecl; overload;
    function initWithLatitude(latitude: CLLocationDegrees; longitude: CLLocationDegrees): Pointer; cdecl;
    function speed: CLLocationSpeed; cdecl;
    function timestamp: NSDate; cdecl;
    function verticalAccuracy: CLLocationAccuracy; cdecl;
  end;
  TCLLocation = class(TOCGenericImport<CLLocationClass, CLLocation>)  end;

  CLGeocoderClass = interface(NSObjectClass)
    ['{19EE31CF-EA10-4399-A750-5A257F02DC5F}']
  end;

  CLGeocoder = interface(NSObject)
    ['{1366DACD-DA00-4178-A843-FE2E15877F5D}']
    function isGeocoding: Boolean; cdecl;

    procedure cancelGeocode; cdecl;
    procedure geocodeAddressDictionary(addressDictionary: NSDictionary; completionHandler: CLGeocodeCompletionHandler); cdecl;
    procedure geocodeAddressString(addressString: NSString; completionHandler: CLGeocodeCompletionHandler); cdecl; overload;
    procedure geocodeAddressString(addressString: NSString; region: CLRegion; completionHandler: CLGeocodeCompletionHandler); cdecl; overload;
    procedure reverseGeocodeLocation(location: CLLocation; completionHandler: CLGeocodeCompletionHandler); cdecl;
  end;
  TCLGeocoder = class(TOCGenericImport<CLGeocoderClass, CLGeocoder>);

  CLPlacemarkClass = interface(NSObjectClass)
    ['{DE83AF77-3F31-4FFB-87D2-2B80AF5C8F38}']
    // no class methods
  end;

  CLPlacemark = interface(NSObject)
    ['{45348348-DFAE-4026-84A4-CEF1814974A3}']
    function addressDictionary: NSDictionary; cdecl;
    function administrativeArea: NSString; cdecl;
    function areasOfInterest: NSArray; cdecl;
    function country: NSString; cdecl;
    function inlandWater: NSString; cdecl;
    function ISOCountryCode: NSString; cdecl;
    function locality: NSString; cdecl;
    function location: CLLocation; cdecl;
    function name: NSString; cdecl;
    function ocean: NSString; cdecl;
    function postalCode: NSString; cdecl;
    function region: CLRegion; cdecl;
    function subAdministrativeArea: NSString; cdecl;
    function subLocality: NSString; cdecl;
    function subThoroughfare: NSString; cdecl;
    function thoroughfare: NSString; cdecl;

    function initWithPlacemark(placemark: CLPlacemark): Pointer; cdecl;
  end;
  TCLPlacemark = class(TOCGenericImport<CLPlacemarkClass, CLPlacemark>);

implementation

uses System.SysUtils;

var
  CoreLocationModule: HMODULE;

initialization
  CoreLocationModule := LoadLibrary(libCoreLocation);

finalization
  if CoreLocationModule <> 0 then
    FreeLibrary(CoreLocationModule);

end.
