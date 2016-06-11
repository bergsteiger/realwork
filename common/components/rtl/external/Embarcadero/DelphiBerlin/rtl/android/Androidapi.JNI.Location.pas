{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Location;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util;

type
// ===== Forward declarations =====

  JAddress = interface;//android.location.Address
  JCriteria = interface;//android.location.Criteria
  JGeocoder = interface;//android.location.Geocoder
  JGpsSatellite = interface;//android.location.GpsSatellite
  JGpsStatus = interface;//android.location.GpsStatus
  JGpsStatus_Listener = interface;//android.location.GpsStatus$Listener
  JGpsStatus_NmeaListener = interface;//android.location.GpsStatus$NmeaListener
  JLocation = interface;//android.location.Location
  JLocationListener = interface;//android.location.LocationListener
  JLocationManager = interface;//android.location.LocationManager
  JLocationProvider = interface;//android.location.LocationProvider
  JSettingInjectorService = interface;//android.location.SettingInjectorService

// ===== Interface declarations =====

  JAddressClass = interface(JObjectClass)
    ['{11E2A62D-94CD-4C84-9BAB-651BDB8AD89F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(locale: JLocale): JAddress; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/location/Address')]
  JAddress = interface(JObject)
    ['{BEDE6B0A-3FCA-4A73-BC74-0FB86CE8E02F}']
    procedure clearLatitude; cdecl;
    procedure clearLongitude; cdecl;
    function describeContents: Integer; cdecl;
    function getAddressLine(index: Integer): JString; cdecl;
    function getAdminArea: JString; cdecl;
    function getCountryCode: JString; cdecl;
    function getCountryName: JString; cdecl;
    function getExtras: JBundle; cdecl;
    function getFeatureName: JString; cdecl;
    function getLatitude: Double; cdecl;
    function getLocale: JLocale; cdecl;
    function getLocality: JString; cdecl;
    function getLongitude: Double; cdecl;
    function getMaxAddressLineIndex: Integer; cdecl;
    function getPhone: JString; cdecl;
    function getPostalCode: JString; cdecl;
    function getPremises: JString; cdecl;
    function getSubAdminArea: JString; cdecl;
    function getSubLocality: JString; cdecl;
    function getSubThoroughfare: JString; cdecl;
    function getThoroughfare: JString; cdecl;
    function getUrl: JString; cdecl;
    function hasLatitude: Boolean; cdecl;
    function hasLongitude: Boolean; cdecl;
    procedure setAddressLine(index: Integer; line: JString); cdecl;
    procedure setAdminArea(adminArea: JString); cdecl;
    procedure setCountryCode(countryCode: JString); cdecl;
    procedure setCountryName(countryName: JString); cdecl;
    procedure setExtras(extras: JBundle); cdecl;
    procedure setFeatureName(featureName: JString); cdecl;
    procedure setLatitude(latitude: Double); cdecl;
    procedure setLocality(locality: JString); cdecl;
    procedure setLongitude(longitude: Double); cdecl;
    procedure setPhone(phone: JString); cdecl;
    procedure setPostalCode(postalCode: JString); cdecl;
    procedure setPremises(premises: JString); cdecl;
    procedure setSubAdminArea(subAdminArea: JString); cdecl;
    procedure setSubLocality(sublocality: JString); cdecl;
    procedure setSubThoroughfare(subthoroughfare: JString); cdecl;
    procedure setThoroughfare(thoroughfare: JString); cdecl;
    procedure setUrl(Url: JString); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJAddress = class(TJavaGenericImport<JAddressClass, JAddress>) end;

  JCriteriaClass = interface(JObjectClass)
    ['{5A00B9BC-1915-4D8F-A077-CED7234A64D1}']
    {class} function _GetACCURACY_COARSE: Integer; cdecl;
    {class} function _GetACCURACY_FINE: Integer; cdecl;
    {class} function _GetACCURACY_HIGH: Integer; cdecl;
    {class} function _GetACCURACY_LOW: Integer; cdecl;
    {class} function _GetACCURACY_MEDIUM: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetNO_REQUIREMENT: Integer; cdecl;
    {class} function _GetPOWER_HIGH: Integer; cdecl;
    {class} function _GetPOWER_LOW: Integer; cdecl;
    {class} function _GetPOWER_MEDIUM: Integer; cdecl;
    {class} function init: JCriteria; cdecl; overload;
    {class} function init(criteria: JCriteria): JCriteria; cdecl; overload;
    {class} property ACCURACY_COARSE: Integer read _GetACCURACY_COARSE;
    {class} property ACCURACY_FINE: Integer read _GetACCURACY_FINE;
    {class} property ACCURACY_HIGH: Integer read _GetACCURACY_HIGH;
    {class} property ACCURACY_LOW: Integer read _GetACCURACY_LOW;
    {class} property ACCURACY_MEDIUM: Integer read _GetACCURACY_MEDIUM;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property NO_REQUIREMENT: Integer read _GetNO_REQUIREMENT;
    {class} property POWER_HIGH: Integer read _GetPOWER_HIGH;
    {class} property POWER_LOW: Integer read _GetPOWER_LOW;
    {class} property POWER_MEDIUM: Integer read _GetPOWER_MEDIUM;
  end;

  [JavaSignature('android/location/Criteria')]
  JCriteria = interface(JObject)
    ['{105327BB-E655-4565-BCB8-796CB73B811C}']
    function describeContents: Integer; cdecl;
    function getAccuracy: Integer; cdecl;
    function getBearingAccuracy: Integer; cdecl;
    function getHorizontalAccuracy: Integer; cdecl;
    function getPowerRequirement: Integer; cdecl;
    function getSpeedAccuracy: Integer; cdecl;
    function getVerticalAccuracy: Integer; cdecl;
    function isAltitudeRequired: Boolean; cdecl;
    function isBearingRequired: Boolean; cdecl;
    function isCostAllowed: Boolean; cdecl;
    function isSpeedRequired: Boolean; cdecl;
    procedure setAccuracy(accuracy: Integer); cdecl;
    procedure setAltitudeRequired(altitudeRequired: Boolean); cdecl;
    procedure setBearingAccuracy(accuracy: Integer); cdecl;
    procedure setBearingRequired(bearingRequired: Boolean); cdecl;
    procedure setCostAllowed(costAllowed: Boolean); cdecl;
    procedure setHorizontalAccuracy(accuracy: Integer); cdecl;
    procedure setPowerRequirement(level: Integer); cdecl;
    procedure setSpeedAccuracy(accuracy: Integer); cdecl;
    procedure setSpeedRequired(speedRequired: Boolean); cdecl;
    procedure setVerticalAccuracy(accuracy: Integer); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJCriteria = class(TJavaGenericImport<JCriteriaClass, JCriteria>) end;

  JGeocoderClass = interface(JObjectClass)
    ['{A21F3CB7-F053-464B-B59B-EDD0E4C784F2}']
    {class} function init(context: JContext; locale: JLocale): JGeocoder; cdecl; overload;
    {class} function init(context: JContext): JGeocoder; cdecl; overload;
    {class} function isPresent: Boolean; cdecl;
  end;

  [JavaSignature('android/location/Geocoder')]
  JGeocoder = interface(JObject)
    ['{32343023-DA3D-41DE-9A9A-69935156D5B7}']
    function getFromLocation(latitude: Double; longitude: Double; maxResults: Integer): JList; cdecl;
    function getFromLocationName(locationName: JString; maxResults: Integer): JList; cdecl; overload;
    function getFromLocationName(locationName: JString; maxResults: Integer; lowerLeftLatitude: Double; lowerLeftLongitude: Double; upperRightLatitude: Double; upperRightLongitude: Double): JList; cdecl; overload;
  end;
  TJGeocoder = class(TJavaGenericImport<JGeocoderClass, JGeocoder>) end;

  JGpsSatelliteClass = interface(JObjectClass)
    ['{8B2B813E-3F20-40F5-AAFF-CA38016DBF99}']
  end;

  [JavaSignature('android/location/GpsSatellite')]
  JGpsSatellite = interface(JObject)
    ['{23BDBF98-46F8-46EE-93FB-07D1EB30C7F7}']
    function getAzimuth: Single; cdecl;
    function getElevation: Single; cdecl;
    function getPrn: Integer; cdecl;
    function getSnr: Single; cdecl;
    function hasAlmanac: Boolean; cdecl;
    function hasEphemeris: Boolean; cdecl;
    function usedInFix: Boolean; cdecl;
  end;
  TJGpsSatellite = class(TJavaGenericImport<JGpsSatelliteClass, JGpsSatellite>) end;

  JGpsStatusClass = interface(JObjectClass)
    ['{875EC1CA-A26D-41DD-83C3-4C361DE1EA50}']
    {class} function _GetGPS_EVENT_FIRST_FIX: Integer; cdecl;
    {class} function _GetGPS_EVENT_SATELLITE_STATUS: Integer; cdecl;
    {class} function _GetGPS_EVENT_STARTED: Integer; cdecl;
    {class} function _GetGPS_EVENT_STOPPED: Integer; cdecl;
    {class} property GPS_EVENT_FIRST_FIX: Integer read _GetGPS_EVENT_FIRST_FIX;
    {class} property GPS_EVENT_SATELLITE_STATUS: Integer read _GetGPS_EVENT_SATELLITE_STATUS;
    {class} property GPS_EVENT_STARTED: Integer read _GetGPS_EVENT_STARTED;
    {class} property GPS_EVENT_STOPPED: Integer read _GetGPS_EVENT_STOPPED;
  end;

  [JavaSignature('android/location/GpsStatus')]
  JGpsStatus = interface(JObject)
    ['{6ED3905E-5FBC-4E7C-A363-10A07297FF5E}']
    function getMaxSatellites: Integer; cdecl;
    function getSatellites: JIterable; cdecl;
    function getTimeToFirstFix: Integer; cdecl;
  end;
  TJGpsStatus = class(TJavaGenericImport<JGpsStatusClass, JGpsStatus>) end;

  JGpsStatus_ListenerClass = interface(IJavaClass)
    ['{1B4E4734-00D1-4DD8-856F-5B15E4BA31F3}']
  end;

  [JavaSignature('android/location/GpsStatus$Listener')]
  JGpsStatus_Listener = interface(IJavaInstance)
    ['{12C48E82-7BEA-4E6E-973D-95CD0B42B3FE}']
    procedure onGpsStatusChanged(event: Integer); cdecl;
  end;
  TJGpsStatus_Listener = class(TJavaGenericImport<JGpsStatus_ListenerClass, JGpsStatus_Listener>) end;

  JGpsStatus_NmeaListenerClass = interface(IJavaClass)
    ['{19E69909-A8B8-4723-866A-49435EC8D942}']
  end;

  [JavaSignature('android/location/GpsStatus$NmeaListener')]
  JGpsStatus_NmeaListener = interface(IJavaInstance)
    ['{7CEBB6D7-85A9-40EA-9360-BE3E6124336B}']
    procedure onNmeaReceived(timestamp: Int64; nmea: JString); cdecl;
  end;
  TJGpsStatus_NmeaListener = class(TJavaGenericImport<JGpsStatus_NmeaListenerClass, JGpsStatus_NmeaListener>) end;

  JLocationClass = interface(JObjectClass)
    ['{A0BF1527-8922-4124-94AC-D2361F1EF984}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFORMAT_DEGREES: Integer; cdecl;
    {class} function _GetFORMAT_MINUTES: Integer; cdecl;
    {class} function _GetFORMAT_SECONDS: Integer; cdecl;
    {class} function init(provider: JString): JLocation; cdecl; overload;
    {class} function init(l: JLocation): JLocation; cdecl; overload;
    {class} function convert(coordinate: Double; outputType: Integer): JString; cdecl; overload;
    {class} function convert(coordinate: JString): Double; cdecl; overload;
    {class} procedure distanceBetween(startLatitude: Double; startLongitude: Double; endLatitude: Double; endLongitude: Double; results: TJavaArray<Single>); cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FORMAT_DEGREES: Integer read _GetFORMAT_DEGREES;
    {class} property FORMAT_MINUTES: Integer read _GetFORMAT_MINUTES;
    {class} property FORMAT_SECONDS: Integer read _GetFORMAT_SECONDS;
  end;

  [JavaSignature('android/location/Location')]
  JLocation = interface(JObject)
    ['{B6A7FB34-312C-41BC-B02D-0107E6F39395}']
    function bearingTo(dest: JLocation): Single; cdecl;
    function describeContents: Integer; cdecl;
    function distanceTo(dest: JLocation): Single; cdecl;
    procedure dump(pw: JPrinter; prefix: JString); cdecl;
    function getAccuracy: Single; cdecl;
    function getAltitude: Double; cdecl;
    function getBearing: Single; cdecl;
    function getElapsedRealtimeNanos: Int64; cdecl;
    function getExtras: JBundle; cdecl;
    function getLatitude: Double; cdecl;
    function getLongitude: Double; cdecl;
    function getProvider: JString; cdecl;
    function getSpeed: Single; cdecl;
    function getTime: Int64; cdecl;
    function hasAccuracy: Boolean; cdecl;
    function hasAltitude: Boolean; cdecl;
    function hasBearing: Boolean; cdecl;
    function hasSpeed: Boolean; cdecl;
    function isFromMockProvider: Boolean; cdecl;
    procedure removeAccuracy; cdecl;
    procedure removeAltitude; cdecl;
    procedure removeBearing; cdecl;
    procedure removeSpeed; cdecl;
    procedure reset; cdecl;
    procedure &set(l: JLocation); cdecl;
    procedure setAccuracy(accuracy: Single); cdecl;
    procedure setAltitude(altitude: Double); cdecl;
    procedure setBearing(bearing: Single); cdecl;
    procedure setElapsedRealtimeNanos(time: Int64); cdecl;
    procedure setExtras(extras: JBundle); cdecl;
    procedure setLatitude(latitude: Double); cdecl;
    procedure setLongitude(longitude: Double); cdecl;
    procedure setProvider(provider: JString); cdecl;
    procedure setSpeed(speed: Single); cdecl;
    procedure setTime(time: Int64); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJLocation = class(TJavaGenericImport<JLocationClass, JLocation>) end;

  JLocationListenerClass = interface(IJavaClass)
    ['{C0D51209-3DC1-46D5-91C1-CC77097564DB}']
  end;

  [JavaSignature('android/location/LocationListener')]
  JLocationListener = interface(IJavaInstance)
    ['{D1CF3FB5-3BCB-4959-98D7-BD4D8F93D839}']
    procedure onLocationChanged(location: JLocation); cdecl;
    procedure onProviderDisabled(provider: JString); cdecl;
    procedure onProviderEnabled(provider: JString); cdecl;
    procedure onStatusChanged(provider: JString; status: Integer; extras: JBundle); cdecl;
  end;
  TJLocationListener = class(TJavaGenericImport<JLocationListenerClass, JLocationListener>) end;

  JLocationManagerClass = interface(JObjectClass)
    ['{031AE82C-2EEE-41E4-94F8-24C4D7059246}']
    {class} function _GetGPS_PROVIDER: JString; cdecl;
    {class} function _GetKEY_LOCATION_CHANGED: JString; cdecl;
    {class} function _GetKEY_PROVIDER_ENABLED: JString; cdecl;
    {class} function _GetKEY_PROXIMITY_ENTERING: JString; cdecl;
    {class} function _GetKEY_STATUS_CHANGED: JString; cdecl;
    {class} function _GetMODE_CHANGED_ACTION: JString; cdecl;
    {class} function _GetNETWORK_PROVIDER: JString; cdecl;
    {class} function _GetPASSIVE_PROVIDER: JString; cdecl;
    {class} function _GetPROVIDERS_CHANGED_ACTION: JString; cdecl;
    {class} property GPS_PROVIDER: JString read _GetGPS_PROVIDER;
    {class} property KEY_LOCATION_CHANGED: JString read _GetKEY_LOCATION_CHANGED;
    {class} property KEY_PROVIDER_ENABLED: JString read _GetKEY_PROVIDER_ENABLED;
    {class} property KEY_PROXIMITY_ENTERING: JString read _GetKEY_PROXIMITY_ENTERING;
    {class} property KEY_STATUS_CHANGED: JString read _GetKEY_STATUS_CHANGED;
    {class} property MODE_CHANGED_ACTION: JString read _GetMODE_CHANGED_ACTION;
    {class} property NETWORK_PROVIDER: JString read _GetNETWORK_PROVIDER;
    {class} property PASSIVE_PROVIDER: JString read _GetPASSIVE_PROVIDER;
    {class} property PROVIDERS_CHANGED_ACTION: JString read _GetPROVIDERS_CHANGED_ACTION;
  end;

  [JavaSignature('android/location/LocationManager')]
  JLocationManager = interface(JObject)
    ['{42C3E256-9370-43B5-93E3-EDF5CE51FB28}']
    function addGpsStatusListener(listener: JGpsStatus_Listener): Boolean; cdecl;
    function addNmeaListener(listener: JGpsStatus_NmeaListener): Boolean; cdecl;
    procedure addProximityAlert(latitude: Double; longitude: Double; radius: Single; expiration: Int64; intent: JPendingIntent); cdecl;
    procedure addTestProvider(name: JString; requiresNetwork: Boolean; requiresSatellite: Boolean; requiresCell: Boolean; hasMonetaryCost: Boolean; supportsAltitude: Boolean; supportsSpeed: Boolean; supportsBearing: Boolean; powerRequirement: Integer; accuracy: Integer); cdecl;
    procedure clearTestProviderEnabled(provider: JString); cdecl;
    procedure clearTestProviderLocation(provider: JString); cdecl;
    procedure clearTestProviderStatus(provider: JString); cdecl;
    function getAllProviders: JList; cdecl;
    function getBestProvider(criteria: JCriteria; enabledOnly: Boolean): JString; cdecl;
    function getGpsStatus(status: JGpsStatus): JGpsStatus; cdecl;
    function getLastKnownLocation(provider: JString): JLocation; cdecl;
    function getProvider(name: JString): JLocationProvider; cdecl;
    function getProviders(enabledOnly: Boolean): JList; cdecl; overload;
    function getProviders(criteria: JCriteria; enabledOnly: Boolean): JList; cdecl; overload;
    function isProviderEnabled(provider: JString): Boolean; cdecl;
    procedure removeGpsStatusListener(listener: JGpsStatus_Listener); cdecl;
    procedure removeNmeaListener(listener: JGpsStatus_NmeaListener); cdecl;
    procedure removeProximityAlert(intent: JPendingIntent); cdecl;
    procedure removeTestProvider(provider: JString); cdecl;
    procedure removeUpdates(listener: JLocationListener); cdecl; overload;
    procedure removeUpdates(intent: JPendingIntent); cdecl; overload;
    procedure requestLocationUpdates(provider: JString; minTime: Int64; minDistance: Single; listener: JLocationListener); cdecl; overload;
    procedure requestLocationUpdates(provider: JString; minTime: Int64; minDistance: Single; listener: JLocationListener; looper: JLooper); cdecl; overload;
    procedure requestLocationUpdates(minTime: Int64; minDistance: Single; criteria: JCriteria; listener: JLocationListener; looper: JLooper); cdecl; overload;
    procedure requestLocationUpdates(provider: JString; minTime: Int64; minDistance: Single; intent: JPendingIntent); cdecl; overload;
    procedure requestLocationUpdates(minTime: Int64; minDistance: Single; criteria: JCriteria; intent: JPendingIntent); cdecl; overload;
    procedure requestSingleUpdate(provider: JString; listener: JLocationListener; looper: JLooper); cdecl; overload;
    procedure requestSingleUpdate(criteria: JCriteria; listener: JLocationListener; looper: JLooper); cdecl; overload;
    procedure requestSingleUpdate(provider: JString; intent: JPendingIntent); cdecl; overload;
    procedure requestSingleUpdate(criteria: JCriteria; intent: JPendingIntent); cdecl; overload;
    function sendExtraCommand(provider: JString; command: JString; extras: JBundle): Boolean; cdecl;
    procedure setTestProviderEnabled(provider: JString; enabled: Boolean); cdecl;
    procedure setTestProviderLocation(provider: JString; loc: JLocation); cdecl;
    procedure setTestProviderStatus(provider: JString; status: Integer; extras: JBundle; updateTime: Int64); cdecl;
  end;
  TJLocationManager = class(TJavaGenericImport<JLocationManagerClass, JLocationManager>) end;

  JLocationProviderClass = interface(JObjectClass)
    ['{45951F9E-53D1-428F-9B17-954C136F0DAA}']
    {class} function _GetAVAILABLE: Integer; cdecl;
    {class} function _GetOUT_OF_SERVICE: Integer; cdecl;
    {class} function _GetTEMPORARILY_UNAVAILABLE: Integer; cdecl;
    {class} property AVAILABLE: Integer read _GetAVAILABLE;
    {class} property OUT_OF_SERVICE: Integer read _GetOUT_OF_SERVICE;
    {class} property TEMPORARILY_UNAVAILABLE: Integer read _GetTEMPORARILY_UNAVAILABLE;
  end;

  [JavaSignature('android/location/LocationProvider')]
  JLocationProvider = interface(JObject)
    ['{1A055914-E219-4691-A746-CBA8DB4BA34F}']
    function getAccuracy: Integer; cdecl;
    function getName: JString; cdecl;
    function getPowerRequirement: Integer; cdecl;
    function hasMonetaryCost: Boolean; cdecl;
    function meetsCriteria(criteria: JCriteria): Boolean; cdecl;
    function requiresCell: Boolean; cdecl;
    function requiresNetwork: Boolean; cdecl;
    function requiresSatellite: Boolean; cdecl;
    function supportsAltitude: Boolean; cdecl;
    function supportsBearing: Boolean; cdecl;
    function supportsSpeed: Boolean; cdecl;
  end;
  TJLocationProvider = class(TJavaGenericImport<JLocationProviderClass, JLocationProvider>) end;

  JSettingInjectorServiceClass = interface(JServiceClass)
    ['{20191F52-1C01-4EBD-9587-C4D13416FD3A}']
    {class} function _GetACTION_INJECTED_SETTING_CHANGED: JString; cdecl;
    {class} function _GetACTION_SERVICE_INTENT: JString; cdecl;
    {class} function _GetATTRIBUTES_NAME: JString; cdecl;
    {class} function _GetMETA_DATA_NAME: JString; cdecl;
    {class} function init(name: JString): JSettingInjectorService; cdecl;
    {class} property ACTION_INJECTED_SETTING_CHANGED: JString read _GetACTION_INJECTED_SETTING_CHANGED;
    {class} property ACTION_SERVICE_INTENT: JString read _GetACTION_SERVICE_INTENT;
    {class} property ATTRIBUTES_NAME: JString read _GetATTRIBUTES_NAME;
    {class} property META_DATA_NAME: JString read _GetMETA_DATA_NAME;
  end;

  [JavaSignature('android/location/SettingInjectorService')]
  JSettingInjectorService = interface(JService)
    ['{739CA798-301B-4FC1-A08A-39CE41189EEA}']
    function onBind(intent: JIntent): JIBinder; cdecl;
    procedure onStart(intent: JIntent; startId: Integer); cdecl;
    function onStartCommand(intent: JIntent; flags: Integer; startId: Integer): Integer; cdecl;
  end;
  TJSettingInjectorService = class(TJavaGenericImport<JSettingInjectorServiceClass, JSettingInjectorService>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Location.JAddress', TypeInfo(Androidapi.JNI.Location.JAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JCriteria', TypeInfo(Androidapi.JNI.Location.JCriteria));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JGeocoder', TypeInfo(Androidapi.JNI.Location.JGeocoder));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JGpsSatellite', TypeInfo(Androidapi.JNI.Location.JGpsSatellite));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JGpsStatus', TypeInfo(Androidapi.JNI.Location.JGpsStatus));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JGpsStatus_Listener', TypeInfo(Androidapi.JNI.Location.JGpsStatus_Listener));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JGpsStatus_NmeaListener', TypeInfo(Androidapi.JNI.Location.JGpsStatus_NmeaListener));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JLocation', TypeInfo(Androidapi.JNI.Location.JLocation));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JLocationListener', TypeInfo(Androidapi.JNI.Location.JLocationListener));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JLocationManager', TypeInfo(Androidapi.JNI.Location.JLocationManager));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JLocationProvider', TypeInfo(Androidapi.JNI.Location.JLocationProvider));
  TRegTypes.RegisterType('Androidapi.JNI.Location.JSettingInjectorService', TypeInfo(Androidapi.JNI.Location.JSettingInjectorService));
end;

initialization
  RegisterTypes;
end.


