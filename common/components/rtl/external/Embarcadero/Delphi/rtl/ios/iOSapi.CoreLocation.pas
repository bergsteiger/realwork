{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework CoreLocation              }
{                                                          }
{ Copyright (c) 2008-2010, Apple Inc. All rights reserved. }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.CoreLocation;

interface

uses Macapi.ObjectiveC, Macapi.ObjCRuntime, iOSapi.CocoaTypes, iOSapi.Foundation;

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
  kCLErrorGeocodeCanceled = 10;
  kCLErrorGeocodeFoundNoResult = 8;
  kCLErrorGeocodeFoundPartialResult = 9;
  kCLErrorHeadingFailure = 3;
  kCLErrorLocationUnknown = 0;
  kCLErrorNetwork = 2;
  kCLErrorRegionMonitoringDenied = 4;
  kCLErrorRegionMonitoringFailure = 5;
  kCLErrorRegionMonitoringResponseDelayed = 7;
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

// ===== Typedefs and structs =====
type
{$M+}
  CLAuthorizationStatus = NSUInteger;
  CLDeviceOrientation = NSUInteger;
  CLHeadingComponentValue = Double;
  CLLocationAccuracy = Double;
  CLLocationDegrees = Double;
  CLLocationDirection = Double;
  CLLocationDistance = Double;
  CLLocationSpeed = Double;

  CLLocationCoordinate2D = record
    latitude: CLLocationDegrees;
    longitude: CLLocationDegrees;
  end;

function CLLocationCoordinate2DIsValid(coord: CLLocationCoordinate2D): Boolean; cdecl; external libCoreLocation name _PU + 'CLLocationCoordinate2DIsValid';
function CLLocationCoordinate2DMake(latitude: CLLocationDegrees; longitude: CLLocationDegrees): CLLocationCoordinate2D; cdecl; external libCoreLocation name _PU + 'CLLocationCoordinate2DMake';

type
{$M+}
  TCLGeocodeCompletionHandler = procedure (const placemark: NSArray;const error: NSError) of object;
// ===== Forward declarations =====

  CLLocationManagerDelegate = interface;

  CLPlacemark = interface;
  CLRegion = interface;
  CLLocationManager = interface;
  CLGeocoder = interface;
  CLHeading = interface;
  CLLocation = interface;

// ===== Protocol declarations =====

  CLLocationManagerDelegate = interface(IObjectiveC)
    ['{A1481CE0-8EE2-497A-9132-5309F0DCCA90}']
    procedure locationManager(manager: CLLocationManager; didChangeAuthorizationStatus: CLAuthorizationStatus); overload; cdecl;
    [MethodName('locationManager:didEnterRegion:')]
    procedure locationManagerDidEnterRegion(manager: CLLocationManager; didEnterRegion: CLRegion); cdecl;
    [MethodName('locationManager:didExitRegion:')]
    procedure locationManagerDidExitRegion(manager: CLLocationManager; didExitRegion: CLRegion); cdecl;
    procedure locationManager(manager: CLLocationManager; didFailWithError: NSError); overload; cdecl;
                                                             
    // procedure locationManager(manager: CLLocationManager; didStartMonitoringForRegion: CLRegion); cdecl; overload;
    procedure locationManager(manager: CLLocationManager; didUpdateHeading: CLHeading); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; didUpdateToLocation: CLLocation; fromLocation: CLLocation); overload; cdecl;
    procedure locationManager(manager: CLLocationManager; monitoringDidFailForRegion: CLRegion; withError: NSError); overload; cdecl;
    function locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean; cdecl;
  end;

// ===== Interface declarations =====

  CLPlacemarkClass = interface(NSObjectClass)
    ['{A0539851-6F72-4A85-A6DF-5ACDAD4DC09E}']
  end;
  CLPlacemark = interface(NSObject)
    ['{A33A0164-05D6-49DE-A8DB-DC984C948779}']
    function ISOcountryCode: NSString; cdecl;
    function addressDictionary: NSDictionary; cdecl;
    function administrativeArea: NSString; cdecl;
    function areasOfInterest: NSArray; cdecl;
    function country: NSString; cdecl;
    function initWithPlacemark(placemark: CLPlacemark): Pointer; cdecl;
    function inlandWater: NSString; cdecl;
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
  end;
  TCLPlacemark = class(TOCGenericImport<CLPlacemarkClass, CLPlacemark>)  end;

  CLRegionClass = interface(NSObjectClass)
    ['{92664E5E-D93F-4FD5-9A70-7EF649C7DF7E}']
  end;
  CLRegion = interface(NSObject)
    ['{DC764906-7A0D-429C-A4B4-C939254AC7C2}']
    function center: CLLocationCoordinate2D; cdecl;
    function containsCoordinate(coordinate: CLLocationCoordinate2D): Boolean; cdecl;
    function identifier: NSString; cdecl;
    function initCircularRegionWithCenter(center: CLLocationCoordinate2D; radius: CLLocationDistance; identifier: NSString): Pointer; cdecl;
    function radius: CLLocationDistance; cdecl;
  end;
  TCLRegion = class(TOCGenericImport<CLRegionClass, CLRegion>)  end;

  CLLocationManagerClass = interface(NSObjectClass)
    ['{4422C248-523F-4237-8966-2A322F58A77C}']
    {class} function authorizationStatus: CLAuthorizationStatus; cdecl;
    {class} function headingAvailable: Boolean; cdecl; overload;
    {class} function locationServicesEnabled: Boolean; cdecl; overload;
    {class} function regionMonitoringAvailable: Boolean; cdecl;
    {class} function regionMonitoringEnabled: Boolean; cdecl;
    {class} function significantLocationChangeMonitoringAvailable: Boolean; cdecl;
  end;
  CLLocationManager = interface(NSObject)
    ['{48C6C581-DA14-4444-A65D-896A0EF5E828}']
    function delegate: Pointer; cdecl;
    function desiredAccuracy: CLLocationAccuracy; cdecl;
    procedure dismissHeadingCalibrationDisplay; cdecl;
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
    procedure startMonitoringForRegion(region: CLRegion); cdecl; overload;
    procedure startMonitoringForRegion(region: CLRegion; desiredAccuracy: CLLocationAccuracy); cdecl; overload;
    procedure startMonitoringSignificantLocationChanges; cdecl;
    procedure startUpdatingHeading; cdecl;
    procedure startUpdatingLocation; cdecl;
    procedure stopMonitoringForRegion(region: CLRegion); cdecl;
    procedure stopMonitoringSignificantLocationChanges; cdecl;
    procedure stopUpdatingHeading; cdecl;
    procedure stopUpdatingLocation; cdecl;
  end;
  TCLLocationManager = class(TOCGenericImport<CLLocationManagerClass, CLLocationManager>)  end;

  CLGeocoderClass = interface(NSObjectClass)
    ['{995D14FC-7FFA-4523-947D-B7F94E2BBB5E}']
  end;
  CLGeocoder = interface(NSObject)
    ['{34147362-3DFB-4489-AD97-59BDF0AEE825}']
    procedure cancelGeocode; cdecl;
    function isGeocoding: Boolean; cdecl;
    procedure geocodeAddressDictionary(addressDictionary: NSDictionary; completionHandler: TCLGeocodeCompletionHandler); cdecl;
    procedure geocodeAddressString(addressString: NSString; completionHandler: TCLGeocodeCompletionHandler); cdecl; overload;
    procedure geocodeAddressString(addressString: NSString; region: CLRegion; completionHandler: TCLGeocodeCompletionHandler); cdecl; overload;
    procedure reverseGeocodeLocation(location: CLLocation; completionHandler: TCLGeocodeCompletionHandler); cdecl;
  end;
  TCLGeocoder = class(TOCGenericImport<CLGeocoderClass, CLGeocoder>)  end;

  CLHeadingClass = interface(NSObjectClass)
    ['{E160A766-8EB9-4D39-B830-94EF1119CA89}']
  end;
  CLHeading = interface(NSObject)
    ['{F1C59601-D23E-4D1E-B13B-D1F5AFD9ACE9}']
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
    ['{70F80709-7F9D-4427-A243-32B28792018C}']
  end;
  CLLocation = interface(NSObject)
    ['{3285343B-6FDA-4144-87ED-5CF72565212E}']
    function altitude: CLLocationDistance; cdecl;
    function coordinate: CLLocationCoordinate2D; cdecl;
    function course: CLLocationDirection; cdecl;
    function description: NSString; cdecl;
    function distanceFromLocation(location: CLLocation): CLLocationDistance; cdecl;
    function getDistanceFrom(location: CLLocation): CLLocationDistance; cdecl;
    function horizontalAccuracy: CLLocationAccuracy; cdecl;
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; horizontalAccuracy: CLLocationAccuracy; verticalAccuracy: CLLocationAccuracy; course: CLLocationDirection; speed: CLLocationSpeed; timestamp: NSDate): Pointer; cdecl; overload;
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; horizontalAccuracy: CLLocationAccuracy; verticalAccuracy: CLLocationAccuracy; timestamp: NSDate): Pointer; cdecl; overload;
    function initWithLatitude(latitude: CLLocationDegrees; longitude: CLLocationDegrees): Pointer; cdecl;
    function speed: CLLocationSpeed; cdecl;
    function timestamp: NSDate; cdecl;
    function verticalAccuracy: CLLocationAccuracy; cdecl;
  end;
  TCLLocation = class(TOCGenericImport<CLLocationClass, CLLocation>)  end;


implementation

{$IF defined(IOS) and NOT defined(CPUARM)}
uses
  Posix.Dlfcn;

var
  CLModule: THandle;

initialization
  CLModule := dlopen(MarshaledAString(libCoreLocation), RTLD_LAZY);

finalization
  dlclose(CLModule);
{$ENDIF IOS}

end.
