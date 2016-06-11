{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Geolocation;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Geolocation Class Names
  // Windows.Devices.Geolocation.Geopoint
  // DualAPI
  SGeopoint = 'Windows.Devices.Geolocation.Geopoint';
  // Windows.Devices.Geolocation.Geopath
  // DualAPI
  SGeopath = 'Windows.Devices.Geolocation.Geopath';
  // Windows.Devices.Geolocation.GeoboundingBox
  // DualAPI
  SGeoboundingBox = 'Windows.Devices.Geolocation.GeoboundingBox';
  // Windows.Devices.Geolocation.GeocoordinateSatelliteData
  // DualAPI
  SGeocoordinateSatelliteData = 'Windows.Devices.Geolocation.GeocoordinateSatelliteData';
  // Windows.Devices.Geolocation.VenueData
  // DualAPI
  SVenueData = 'Windows.Devices.Geolocation.VenueData';
  // Windows.Devices.Geolocation.Geocoordinate
  // DualAPI
  SGeocoordinate = 'Windows.Devices.Geolocation.Geocoordinate';
  // Windows.Devices.Geolocation.CivicAddress
  // DualAPI
  SCivicAddress = 'Windows.Devices.Geolocation.CivicAddress';
  // Windows.Devices.Geolocation.Geoposition
  // DualAPI
  SGeoposition = 'Windows.Devices.Geolocation.Geoposition';
  // Windows.Devices.Geolocation.PositionChangedEventArgs
  // DualAPI
  SPositionChangedEventArgs = 'Windows.Devices.Geolocation.PositionChangedEventArgs';
  // Windows.Devices.Geolocation.StatusChangedEventArgs
  // DualAPI
  SStatusChangedEventArgs = 'Windows.Devices.Geolocation.StatusChangedEventArgs';
  // Windows.Devices.Geolocation.Geolocator
  // DualAPI
  SGeolocator = 'Windows.Devices.Geolocation.Geolocator';
  // Windows.Devices.Geolocation.Geocircle
  // DualAPI
  SGeocircle = 'Windows.Devices.Geolocation.Geocircle';


type
  // Forward declare interfaces
  // Windows.Devices.Geolocation.IGeoshape
  IGeoshape = interface;
  PIGeoshape = ^IGeoshape;

  // Windows.Devices.Geolocation.IGeocoordinate
  IGeocoordinate = interface;
  PIGeocoordinate = ^IGeocoordinate;

  // Windows.Devices.Geolocation.ICivicAddress
  ICivicAddress = interface;
  PICivicAddress = ^ICivicAddress;

  // Windows.Devices.Geolocation.IGeoposition
  IGeoposition = interface;
  PIGeoposition = ^IGeoposition;

  // Windows.Devices.Geolocation.IGeopoint
  IGeopoint = interface;
  PIGeopoint = ^IGeopoint;

  // Windows.Devices.Geolocation.IGeopointFactory
  IGeopointFactory = interface;
  PIGeopointFactory = ^IGeopointFactory;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.BasicGeoposition>
  IIterator_1__BasicGeoposition = interface;
  PIIterator_1__BasicGeoposition = ^IIterator_1__BasicGeoposition;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.BasicGeoposition>
  IIterable_1__BasicGeoposition = interface;
  PIIterable_1__BasicGeoposition = ^IIterable_1__BasicGeoposition;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.BasicGeoposition>
  IVectorView_1__BasicGeoposition = interface;
  PIVectorView_1__BasicGeoposition = ^IVectorView_1__BasicGeoposition;

  // Windows.Devices.Geolocation.IGeopath
  IGeopath = interface;
  PIGeopath = ^IGeopath;

  // Windows.Devices.Geolocation.IGeopathFactory
  IGeopathFactory = interface;
  PIGeopathFactory = ^IGeopathFactory;

  // Windows.Devices.Geolocation.IGeoboundingBox
  IGeoboundingBox = interface;
  PIGeoboundingBox = ^IGeoboundingBox;

  // Windows.Devices.Geolocation.IGeoboundingBoxFactory
  IGeoboundingBoxFactory = interface;
  PIGeoboundingBoxFactory = ^IGeoboundingBoxFactory;

  // Windows.Devices.Geolocation.IGeoboundingBoxStatics
  IGeoboundingBoxStatics = interface;
  PIGeoboundingBoxStatics = ^IGeoboundingBoxStatics;

  // Windows.Devices.Geolocation.IGeocoordinateSatelliteData
  IGeocoordinateSatelliteData = interface;
  PIGeocoordinateSatelliteData = ^IGeocoordinateSatelliteData;

  // Windows.Devices.Geolocation.IVenueData
  IVenueData = interface;
  PIVenueData = ^IVenueData;

  // Windows.Devices.Geolocation.IGeocoordinateWithPositionData
  IGeocoordinateWithPositionData = interface;
  PIGeocoordinateWithPositionData = ^IGeocoordinateWithPositionData;

  // Windows.Devices.Geolocation.IGeocoordinateWithPoint
  IGeocoordinateWithPoint = interface;
  PIGeocoordinateWithPoint = ^IGeocoordinateWithPoint;

  // Windows.Devices.Geolocation.IGeocoordinateWithPositionSourceTimestamp
  IGeocoordinateWithPositionSourceTimestamp = interface;
  PIGeocoordinateWithPositionSourceTimestamp = ^IGeocoordinateWithPositionSourceTimestamp;

  // Windows.Devices.Geolocation.IGeoposition2
  IGeoposition2 = interface;
  PIGeoposition2 = ^IGeoposition2;

  // Windows.Devices.Geolocation.IPositionChangedEventArgs
  IPositionChangedEventArgs = interface;
  PIPositionChangedEventArgs = ^IPositionChangedEventArgs;

  // Windows.Devices.Geolocation.IStatusChangedEventArgs
  IStatusChangedEventArgs = interface;
  PIStatusChangedEventArgs = ^IStatusChangedEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeoposition>
  AsyncOperationCompletedHandler_1__IGeoposition = interface;
  PAsyncOperationCompletedHandler_1__IGeoposition = ^AsyncOperationCompletedHandler_1__IGeoposition;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeoposition>
  IAsyncOperation_1__IGeoposition = interface;
  PIAsyncOperation_1__IGeoposition = ^IAsyncOperation_1__IGeoposition;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IPositionChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs = interface;
  PTypedEventHandler_2__IGeolocator__IPositionChangedEventArgs = ^TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IStatusChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs = interface;
  PTypedEventHandler_2__IGeolocator__IStatusChangedEventArgs = ^TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs;

  // Windows.Devices.Geolocation.IGeolocator
  IGeolocator = interface;
  PIGeolocator = ^IGeolocator;

  // Windows.Devices.Geolocation.IGeolocatorWithScalarAccuracy
  IGeolocatorWithScalarAccuracy = interface;
  PIGeolocatorWithScalarAccuracy = ^IGeolocatorWithScalarAccuracy;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  AsyncOperationCompletedHandler_1__GeolocationAccessStatus = interface;
  PAsyncOperationCompletedHandler_1__GeolocationAccessStatus = ^AsyncOperationCompletedHandler_1__GeolocationAccessStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  IAsyncOperation_1__GeolocationAccessStatus = interface;
  PIAsyncOperation_1__GeolocationAccessStatus = ^IAsyncOperation_1__GeolocationAccessStatus;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.IGeoposition>
  IIterator_1__IGeoposition = interface;
  PIIterator_1__IGeoposition = ^IIterator_1__IGeoposition;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeoposition>
  IIterable_1__IGeoposition = interface;
  PIIterable_1__IGeoposition = ^IIterable_1__IGeoposition;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>
  IVectorView_1__IGeoposition = interface;
  PIVectorView_1__IGeoposition = ^IVectorView_1__IGeoposition;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition = ^AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  IAsyncOperation_1__IVectorView_1__IGeoposition = interface;
  PIAsyncOperation_1__IVectorView_1__IGeoposition = ^IAsyncOperation_1__IVectorView_1__IGeoposition;

  // Windows.Devices.Geolocation.IGeolocatorStatics
  IGeolocatorStatics = interface;
  PIGeolocatorStatics = ^IGeolocatorStatics;

  // Windows.Devices.Geolocation.IGeocircle
  IGeocircle = interface;
  PIGeocircle = ^IGeocircle;

  // Windows.Devices.Geolocation.IGeocircleFactory
  IGeocircleFactory = interface;
  PIGeocircleFactory = ^IGeocircleFactory;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.IGeopoint>
  IIterator_1__IGeopoint = interface;
  PIIterator_1__IGeopoint = ^IIterator_1__IGeopoint;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeopoint>
  IIterable_1__IGeopoint = interface;
  PIIterable_1__IGeopoint = ^IIterable_1__IGeopoint;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeopoint>
  AsyncOperationCompletedHandler_1__IGeopoint = interface;
  PAsyncOperationCompletedHandler_1__IGeopoint = ^AsyncOperationCompletedHandler_1__IGeopoint;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeopoint>
  IAsyncOperation_1__IGeopoint = interface;
  PIAsyncOperation_1__IGeopoint = ^IAsyncOperation_1__IGeopoint;


  // Emit Forwarded interfaces
  // Windows.Devices.Geolocation Interfaces
  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoshape
  IGeoshape = interface(IInspectable)
  ['{C99CA2AF-C729-43C1-8FAB-D6DEC914DF7E}']
    function get_GeoshapeType: GeoshapeType; safecall;
    function get_SpatialReferenceId: Cardinal; safecall;
    function get_AltitudeReferenceSystem: AltitudeReferenceSystem; safecall;
    property AltitudeReferenceSystem: AltitudeReferenceSystem read get_AltitudeReferenceSystem;
    property GeoshapeType: GeoshapeType read get_GeoshapeType;
    property SpatialReferenceId: Cardinal read get_SpatialReferenceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocoordinate
  [WinRTClassNameAttribute(SGeocoordinate)]
  IGeocoordinate = interface(IInspectable)
  ['{EE21A3AA-976A-4C70-803D-083EA55BCBC4}']
    function get_Latitude: Double; safecall;
    function get_Longitude: Double; safecall;
    function get_Altitude: IReference_1__Double; safecall;
    function get_Accuracy: Double; safecall;
    function get_AltitudeAccuracy: IReference_1__Double; safecall;
    function get_Heading: IReference_1__Double; safecall;
    function get_Speed: IReference_1__Double; safecall;
    function get_Timestamp: DateTime; safecall;
    property Accuracy: Double read get_Accuracy;
    property Altitude: IReference_1__Double read get_Altitude;
    property AltitudeAccuracy: IReference_1__Double read get_AltitudeAccuracy;
    property Heading: IReference_1__Double read get_Heading;
    property Latitude: Double read get_Latitude;
    property Longitude: Double read get_Longitude;
    property Speed: IReference_1__Double read get_Speed;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.ICivicAddress
  [WinRTClassNameAttribute(SCivicAddress)]
  ICivicAddress = interface(IInspectable)
  ['{A8567A1A-64F4-4D48-BCEA-F6B008ECA34C}']
    function get_Country: HSTRING; safecall;
    function get_State: HSTRING; safecall;
    function get_City: HSTRING; safecall;
    function get_PostalCode: HSTRING; safecall;
    function get_Timestamp: DateTime; safecall;
    property City: HSTRING read get_City;
    property Country: HSTRING read get_Country;
    property PostalCode: HSTRING read get_PostalCode;
    property State: HSTRING read get_State;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoposition
  [WinRTClassNameAttribute(SGeoposition)]
  IGeoposition = interface(IInspectable)
  ['{C18D0454-7D41-4FF7-A957-9DFFB4EF7F5B}']
    function get_Coordinate: IGeocoordinate; safecall;
    function get_CivicAddress: ICivicAddress; safecall;
    property CivicAddress: ICivicAddress read get_CivicAddress;
    property Coordinate: IGeocoordinate read get_Coordinate;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeopoint
  [WinRTClassNameAttribute(SGeopoint)]
  IGeopoint = interface(IInspectable)
  ['{6BFA00EB-E56E-49BB-9CAF-CBAA78A8BCEF}']
    function get_Position: BasicGeoposition; safecall;
    property Position: BasicGeoposition read get_Position;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeopointFactory
  [WinRTClassNameAttribute(SGeopoint)]
  IGeopointFactory = interface(IInspectable)
  ['{DB6B8D33-76BD-4E30-8AF7-A844DC37B7A0}']
    function Create(position: BasicGeoposition): IGeopoint; safecall;
    function CreateWithAltitudeReferenceSystem(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopoint; safecall;
    function CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopoint; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.BasicGeoposition>
  IIterator_1__BasicGeoposition = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: BasicGeoposition; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PBasicGeoposition): Cardinal; safecall;
    property Current: BasicGeoposition read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.BasicGeoposition>
  IIterable_1__BasicGeoposition_Base = interface(IInspectable)
  ['{922399A8-0093-5009-A8D2-F87B0EAE75F5}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.BasicGeoposition>
  IIterable_1__BasicGeoposition = interface(IIterable_1__BasicGeoposition_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__BasicGeoposition; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.BasicGeoposition>
  IVectorView_1__BasicGeoposition = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): BasicGeoposition; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: BasicGeoposition; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PBasicGeoposition): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeopath
  [WinRTClassNameAttribute(SGeopath)]
  IGeopath = interface(IInspectable)
  ['{E53FD7B9-2DA4-4714-A652-DE8593289898}']
    function get_Positions: IVectorView_1__BasicGeoposition; safecall;
    property Positions: IVectorView_1__BasicGeoposition read get_Positions;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeopathFactory
  [WinRTClassNameAttribute(SGeopath)]
  IGeopathFactory = interface(IInspectable)
  ['{27BEA9C8-C7E7-4359-9B9B-FCA3E05EF593}']
    function Create(positions: IIterable_1__BasicGeoposition): IGeopath; safecall;
    function CreateWithAltitudeReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopath; safecall;
    function CreateWithAltitudeReferenceAndSpatialReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopath; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoboundingBox
  [WinRTClassNameAttribute(SGeoboundingBox)]
  IGeoboundingBox = interface(IInspectable)
  ['{0896C80B-274F-43DA-9A06-CBFCDAEB4EC2}']
    function get_NorthwestCorner: BasicGeoposition; safecall;
    function get_SoutheastCorner: BasicGeoposition; safecall;
    function get_Center: BasicGeoposition; safecall;
    function get_MinAltitude: Double; safecall;
    function get_MaxAltitude: Double; safecall;
    property Center: BasicGeoposition read get_Center;
    property MaxAltitude: Double read get_MaxAltitude;
    property MinAltitude: Double read get_MinAltitude;
    property NorthwestCorner: BasicGeoposition read get_NorthwestCorner;
    property SoutheastCorner: BasicGeoposition read get_SoutheastCorner;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoboundingBoxFactory
  [WinRTClassNameAttribute(SGeoboundingBox)]
  IGeoboundingBoxFactory = interface(IInspectable)
  ['{4DFBA589-0411-4ABC-B3B5-5BBCCB57D98C}']
    function Create(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition): IGeoboundingBox; safecall;
    function CreateWithAltitudeReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeoboundingBox; safecall;
    function CreateWithAltitudeReferenceAndSpatialReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoboundingBoxStatics
  [WinRTClassNameAttribute(SGeoboundingBox)]
  IGeoboundingBoxStatics = interface(IInspectable)
  ['{67B80708-E61A-4CD0-841B-93233792B5CA}']
    function TryCompute(positions: IIterable_1__BasicGeoposition): IGeoboundingBox; overload; safecall;
    function TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem): IGeoboundingBox; overload; safecall;
    function TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocoordinateSatelliteData
  [WinRTClassNameAttribute(SGeocoordinateSatelliteData)]
  IGeocoordinateSatelliteData = interface(IInspectable)
  ['{C32A74D9-2608-474C-912C-06DD490F4AF7}']
    function get_PositionDilutionOfPrecision: IReference_1__Double; safecall;
    function get_HorizontalDilutionOfPrecision: IReference_1__Double; safecall;
    function get_VerticalDilutionOfPrecision: IReference_1__Double; safecall;
    property HorizontalDilutionOfPrecision: IReference_1__Double read get_HorizontalDilutionOfPrecision;
    property PositionDilutionOfPrecision: IReference_1__Double read get_PositionDilutionOfPrecision;
    property VerticalDilutionOfPrecision: IReference_1__Double read get_VerticalDilutionOfPrecision;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IVenueData
  [WinRTClassNameAttribute(SVenueData)]
  IVenueData = interface(IInspectable)
  ['{66F39187-60E3-4B2F-B527-4F53F1C3C677}']
    function get_Id: HSTRING; safecall;
    function get_Level: HSTRING; safecall;
    property Id: HSTRING read get_Id;
    property Level: HSTRING read get_Level;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocoordinateWithPositionData
  IGeocoordinateWithPositionData = interface(IInspectable)
  ['{95E634BE-DBD6-40AC-B8F2-A65C0340D9A6}']
    function get_PositionSource: PositionSource; safecall;
    function get_SatelliteData: IGeocoordinateSatelliteData; safecall;
    property PositionSource: PositionSource read get_PositionSource;
    property SatelliteData: IGeocoordinateSatelliteData read get_SatelliteData;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocoordinateWithPoint
  IGeocoordinateWithPoint = interface(IInspectable)
  ['{FEEA0525-D22C-4D46-B527-0B96066FC7DB}']
    function get_Point: IGeopoint; safecall;
    property Point: IGeopoint read get_Point;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocoordinateWithPositionSourceTimestamp
  IGeocoordinateWithPositionSourceTimestamp = interface(IInspectable)
  ['{8543FC02-C9F1-4610-AFE0-8BC3A6A87036}']
    function get_PositionSourceTimestamp: IReference_1__DateTime; safecall;
    property PositionSourceTimestamp: IReference_1__DateTime read get_PositionSourceTimestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeoposition2
  IGeoposition2 = interface(IInspectable)
  ['{7F62F697-8671-4B0D-86F8-474A8496187C}']
    function get_VenueData: IVenueData; safecall;
    property VenueData: IVenueData read get_VenueData;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IPositionChangedEventArgs
  [WinRTClassNameAttribute(SPositionChangedEventArgs)]
  IPositionChangedEventArgs = interface(IInspectable)
  ['{37859CE5-9D1E-46C5-BF3B-6AD8CAC1A093}']
    function get_Position: IGeoposition; safecall;
    property Position: IGeoposition read get_Position;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IStatusChangedEventArgs
  [WinRTClassNameAttribute(SStatusChangedEventArgs)]
  IStatusChangedEventArgs = interface(IInspectable)
  ['{3453D2DA-8C93-4111-A205-9AECFC9BE5C0}']
    function get_Status: PositionStatus; safecall;
    property Status: PositionStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeoposition>
  AsyncOperationCompletedHandler_1__IGeoposition_Delegate_Base = interface(IUnknown)
  ['{7668A704-244E-5E12-8DCB-92A3299EBA26}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeoposition>
  AsyncOperationCompletedHandler_1__IGeoposition = interface(AsyncOperationCompletedHandler_1__IGeoposition_Delegate_Base)
  ['{7B8AE52A-070D-5658-B3CA-1B394091EA48}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IGeoposition; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeoposition>
  IAsyncOperation_1__IGeoposition_Base = interface(IInspectable)
  ['{EE73ECF0-099D-57E5-8407-5B32E5AF1CC4}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeoposition>
  IAsyncOperation_1__IGeoposition = interface(IAsyncOperation_1__IGeoposition_Base)
  ['{9223B88D-2C6D-50F5-BD0F-F2C9928EECD3}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IGeoposition); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IGeoposition; safecall;
    function GetResults: IGeoposition; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IGeoposition read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IPositionChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{DF3C6164-4E7B-5E8E-9A7E-13DA059DEC1E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IPositionChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs = interface(TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs_Delegate_Base)
  ['{04806A98-49FF-53B3-AF96-93269759D5C2}']
    procedure Invoke(sender: IGeolocator; args: IPositionChangedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IStatusChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{97FCF582-DE6B-5CD3-9690-E2ECBB66DA4D}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Geolocation.IGeolocator,Windows.Devices.Geolocation.IStatusChangedEventArgs>
  TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs = interface(TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs_Delegate_Base)
  ['{B9F039C6-759A-5E7D-BB48-6D1B1BBB9023}']
    procedure Invoke(sender: IGeolocator; args: IStatusChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeolocator
  [WinRTClassNameAttribute(SGeolocator)]
  IGeolocator = interface(IInspectable)
  ['{A9C3BF62-4524-4989-8AA9-DE019D2E551F}']
    function get_DesiredAccuracy: PositionAccuracy; safecall;
    procedure put_DesiredAccuracy(value: PositionAccuracy); safecall;
    function get_MovementThreshold: Double; safecall;
    procedure put_MovementThreshold(value: Double); safecall;
    function get_ReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_LocationStatus: PositionStatus; safecall;
    function GetGeopositionAsync: IAsyncOperation_1__IGeoposition; overload; safecall;
    function GetGeopositionAsync(maximumAge: TimeSpan; timeout: TimeSpan): IAsyncOperation_1__IGeoposition; overload; safecall;
    function add_PositionChanged(handler: TypedEventHandler_2__IGeolocator__IPositionChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PositionChanged(token: EventRegistrationToken); safecall;
    function add_StatusChanged(handler: TypedEventHandler_2__IGeolocator__IStatusChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StatusChanged(token: EventRegistrationToken); safecall;
    property DesiredAccuracy: PositionAccuracy read get_DesiredAccuracy write put_DesiredAccuracy;
    property LocationStatus: PositionStatus read get_LocationStatus;
    property MovementThreshold: Double read get_MovementThreshold write put_MovementThreshold;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeolocatorWithScalarAccuracy
  IGeolocatorWithScalarAccuracy = interface(IInspectable)
  ['{96F5D3C1-B80F-460A-994D-A96C47A51AA4}']
    function get_DesiredAccuracyInMeters: IReference_1__Cardinal; safecall;
    procedure put_DesiredAccuracyInMeters(value: IReference_1__Cardinal); safecall;
    property DesiredAccuracyInMeters: IReference_1__Cardinal read get_DesiredAccuracyInMeters write put_DesiredAccuracyInMeters;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  AsyncOperationCompletedHandler_1__GeolocationAccessStatus_Delegate_Base = interface(IUnknown)
  ['{F3524C93-E5C7-5B88-BEDB-D3E637CFF271}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  AsyncOperationCompletedHandler_1__GeolocationAccessStatus = interface(AsyncOperationCompletedHandler_1__GeolocationAccessStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__GeolocationAccessStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  IAsyncOperation_1__GeolocationAccessStatus_Base = interface(IInspectable)
  ['{DE2B24D0-B726-57B1-A7C5-E5A13932B7DE}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.GeolocationAccessStatus>
  IAsyncOperation_1__GeolocationAccessStatus = interface(IAsyncOperation_1__GeolocationAccessStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__GeolocationAccessStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__GeolocationAccessStatus; safecall;
    function GetResults: GeolocationAccessStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__GeolocationAccessStatus read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.IGeoposition>
  IIterator_1__IGeoposition = interface(IInspectable)
  ['{D414D676-75D3-52FB-AA22-5829AD9FC4FF}']
    function get_Current: IGeoposition; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIGeoposition): Cardinal; safecall;
    property Current: IGeoposition read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeoposition>
  IIterable_1__IGeoposition_Base = interface(IInspectable)
  ['{135ED72D-75B1-5881-BE41-6FFEAA202044}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeoposition>
  IIterable_1__IGeoposition = interface(IIterable_1__IGeoposition_Base)
  ['{FCB45D3B-0B5C-5C0D-82E9-4CFB295147B9}']
    function First: IIterator_1__IGeoposition; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>
  IVectorView_1__IGeoposition = interface(IInspectable)
  ['{C9FFE173-AC85-50AD-B262-90DCC4CA5165}']
    function GetAt(index: Cardinal): IGeoposition; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IGeoposition; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIGeoposition): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition_Delegate_Base = interface(IUnknown)
  ['{6C67A1D1-9441-5AEE-B625-E3C1B5676A6D}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition_Delegate_Base)
  ['{272FE546-D773-5C98-867B-B7084A054EC5}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IGeoposition; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  IAsyncOperation_1__IVectorView_1__IGeoposition_Base = interface(IInspectable)
  ['{9454B533-EFB4-5385-8D3A-437FABC32D91}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Geolocation.IGeoposition>>
  IAsyncOperation_1__IVectorView_1__IGeoposition = interface(IAsyncOperation_1__IVectorView_1__IGeoposition_Base)
  ['{4E4265BF-AAF7-5109-A9E3-0CEDD1D201D0}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition; safecall;
    function GetResults: IVectorView_1__IGeoposition; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IGeoposition read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeolocatorStatics
  [WinRTClassNameAttribute(SGeolocator)]
  IGeolocatorStatics = interface(IInspectable)
  ['{9A8E7571-2DF5-4591-9F87-EB5FD894E9B7}']
    function RequestAccessAsync: IAsyncOperation_1__GeolocationAccessStatus; safecall;
    function GetGeopositionHistoryAsync(startTime: DateTime): IAsyncOperation_1__IVectorView_1__IGeoposition; overload; safecall;
    function GetGeopositionHistoryAsync(startTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IGeoposition; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocircle
  [WinRTClassNameAttribute(SGeocircle)]
  IGeocircle = interface(IInspectable)
  ['{39E45843-A7F9-4E63-92A7-BA0C28D124B1}']
    function get_Center: BasicGeoposition; safecall;
    function get_Radius: Double; safecall;
    property Center: BasicGeoposition read get_Center;
    property Radius: Double read get_Radius;
  end;

  // DualAPI Interface
  // Windows.Devices.Geolocation.IGeocircleFactory
  [WinRTClassNameAttribute(SGeocircle)]
  IGeocircleFactory = interface(IInspectable)
  ['{AFD6531F-72B1-4F7D-87CC-4ED4C9849C05}']
    function Create(position: BasicGeoposition; radius: Double): IGeocircle; safecall;
    function CreateWithAltitudeReferenceSystem(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem): IGeocircle; safecall;
    function CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeocircle; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Geolocation.IGeopoint>
  IIterator_1__IGeopoint = interface(IInspectable)
  ['{A11ECDF0-F895-592E-992D-497BEAA6E362}']
    function get_Current: IGeopoint; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIGeopoint): Cardinal; safecall;
    property Current: IGeopoint read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeopoint>
  IIterable_1__IGeopoint_Base = interface(IInspectable)
  ['{E7617FC9-2CC7-5BD1-BC5A-F47260834ED8}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Geolocation.IGeopoint>
  IIterable_1__IGeopoint = interface(IIterable_1__IGeopoint_Base)
  ['{768FFCFF-2CDA-53B3-ABE6-39C5CCE15163}']
    function First: IIterator_1__IGeopoint; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeopoint>
  AsyncOperationCompletedHandler_1__IGeopoint_Delegate_Base = interface(IUnknown)
  ['{4B5F2F60-19B1-5566-9DF6-92A42235CBF9}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Geolocation.IGeopoint>
  AsyncOperationCompletedHandler_1__IGeopoint = interface(AsyncOperationCompletedHandler_1__IGeopoint_Delegate_Base)
  ['{7B608E60-1D1C-54F7-AC4C-21521D88B0D0}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IGeopoint; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeopoint>
  IAsyncOperation_1__IGeopoint_Base = interface(IInspectable)
  ['{3723E070-C2AE-538F-846E-0F9D280310C0}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Geolocation.IGeopoint>
  IAsyncOperation_1__IGeopoint = interface(IAsyncOperation_1__IGeopoint_Base)
  ['{791AAF1D-97B7-58A5-BC49-226231EE1F08}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IGeopoint); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IGeopoint; safecall;
    function GetResults: IGeopoint; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IGeopoint read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Geolocation.Geopoint
  // DualAPI
  TGeopoint = class(TWinRTGenericImportF<IGeopointFactory>)
  public
    // -> IGeopointFactory
    class function Create(position: BasicGeoposition): IGeopoint; static; inline;
    class function CreateWithAltitudeReferenceSystem(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopoint; static; inline;
    class function CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopoint; static; inline;
  end;

  // Windows.Devices.Geolocation.Geopath
  // DualAPI
  TGeopath = class(TWinRTGenericImportF<IGeopathFactory>)
  public
    // -> IGeopathFactory
    class function Create(positions: IIterable_1__BasicGeoposition): IGeopath; static; inline;
    class function CreateWithAltitudeReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopath; static; inline;
    class function CreateWithAltitudeReferenceAndSpatialReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopath; static; inline;
  end;

  // Windows.Devices.Geolocation.GeoboundingBox
  // DualAPI
  TGeoboundingBox = class(TWinRTGenericImportFS<IGeoboundingBoxFactory, IGeoboundingBoxStatics>)
  public
    // -> IGeoboundingBoxStatics
    class function TryCompute(positions: IIterable_1__BasicGeoposition): IGeoboundingBox; overload; static; inline;
    class function TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem): IGeoboundingBox; overload; static; inline;
    class function TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox; overload; static; inline;

    // -> IGeoboundingBoxFactory
    class function Create(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition): IGeoboundingBox; static; inline;
    class function CreateWithAltitudeReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeoboundingBox; static; inline;
    class function CreateWithAltitudeReferenceAndSpatialReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox; static; inline;
  end;

  // Windows.Devices.Geolocation.GeocoordinateSatelliteData
  // DualAPI

  // Windows.Devices.Geolocation.VenueData
  // DualAPI

  // Windows.Devices.Geolocation.Geocoordinate
  // DualAPI

  // Windows.Devices.Geolocation.CivicAddress
  // DualAPI

  // Windows.Devices.Geolocation.Geoposition
  // DualAPI

  // Windows.Devices.Geolocation.PositionChangedEventArgs
  // DualAPI

  // Windows.Devices.Geolocation.StatusChangedEventArgs
  // DualAPI

  // Windows.Devices.Geolocation.Geolocator
  // DualAPI
  TGeolocator = class(TWinRTGenericImportSI<IGeolocatorStatics, IGeolocator>)
  public
    // -> IGeolocatorStatics
    class function RequestAccessAsync: IAsyncOperation_1__GeolocationAccessStatus; static; inline;
    class function GetGeopositionHistoryAsync(startTime: DateTime): IAsyncOperation_1__IVectorView_1__IGeoposition; overload; static; inline;
    class function GetGeopositionHistoryAsync(startTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IGeoposition; overload; static; inline;
  end;

  // Windows.Devices.Geolocation.Geocircle
  // DualAPI
  TGeocircle = class(TWinRTGenericImportF<IGeocircleFactory>)
  public
    // -> IGeocircleFactory
    class function Create(position: BasicGeoposition; radius: Double): IGeocircle; static; inline;
    class function CreateWithAltitudeReferenceSystem(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem): IGeocircle; static; inline;
    class function CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeocircle; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TGeopoint }
// Factories for : "Geopoint"
// Factory: "Windows.Devices.Geolocation.IGeopointFactory"
// -> IGeopointFactory

class function TGeopoint.Create(position: BasicGeoposition): IGeopoint;
begin
  Result := Factory.Create(position);
end;

class function TGeopoint.CreateWithAltitudeReferenceSystem(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopoint;
begin
  Result := Factory.CreateWithAltitudeReferenceSystem(position, altitudeReferenceSystem);
end;

class function TGeopoint.CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopoint;
begin
  Result := Factory.CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position, altitudeReferenceSystem, spatialReferenceId);
end;


 { TGeopath }
// Factories for : "Geopath"
// Factory: "Windows.Devices.Geolocation.IGeopathFactory"
// -> IGeopathFactory

class function TGeopath.Create(positions: IIterable_1__BasicGeoposition): IGeopath;
begin
  Result := Factory.Create(positions);
end;

class function TGeopath.CreateWithAltitudeReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeopath;
begin
  Result := Factory.CreateWithAltitudeReference(positions, altitudeReferenceSystem);
end;

class function TGeopath.CreateWithAltitudeReferenceAndSpatialReference(positions: IIterable_1__BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeopath;
begin
  Result := Factory.CreateWithAltitudeReferenceAndSpatialReference(positions, altitudeReferenceSystem, spatialReferenceId);
end;


 { TGeoboundingBox }

class function TGeoboundingBox.TryCompute(positions: IIterable_1__BasicGeoposition): IGeoboundingBox;
begin
  Result := Statics.TryCompute(positions);
end;

class function TGeoboundingBox.TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem): IGeoboundingBox;
begin
  Result := Statics.TryCompute(positions, altitudeRefSystem);
end;

class function TGeoboundingBox.TryCompute(positions: IIterable_1__BasicGeoposition; altitudeRefSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox;
begin
  Result := Statics.TryCompute(positions, altitudeRefSystem, spatialReferenceId);
end;

// Factories for : "GeoboundingBox"
// Factory: "Windows.Devices.Geolocation.IGeoboundingBoxFactory"
// -> IGeoboundingBoxFactory

class function TGeoboundingBox.Create(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition): IGeoboundingBox;
begin
  Result := Factory.Create(northwestCorner, southeastCorner);
end;

class function TGeoboundingBox.CreateWithAltitudeReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem): IGeoboundingBox;
begin
  Result := Factory.CreateWithAltitudeReference(northwestCorner, southeastCorner, altitudeReferenceSystem);
end;

class function TGeoboundingBox.CreateWithAltitudeReferenceAndSpatialReference(northwestCorner: BasicGeoposition; southeastCorner: BasicGeoposition; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeoboundingBox;
begin
  Result := Factory.CreateWithAltitudeReferenceAndSpatialReference(northwestCorner, southeastCorner, altitudeReferenceSystem, spatialReferenceId);
end;


 { TGeolocator }

class function TGeolocator.RequestAccessAsync: IAsyncOperation_1__GeolocationAccessStatus;
begin
  Result := Statics.RequestAccessAsync;
end;

class function TGeolocator.GetGeopositionHistoryAsync(startTime: DateTime): IAsyncOperation_1__IVectorView_1__IGeoposition;
begin
  Result := Statics.GetGeopositionHistoryAsync(startTime);
end;

class function TGeolocator.GetGeopositionHistoryAsync(startTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IGeoposition;
begin
  Result := Statics.GetGeopositionHistoryAsync(startTime, duration);
end;


 { TGeocircle }
// Factories for : "Geocircle"
// Factory: "Windows.Devices.Geolocation.IGeocircleFactory"
// -> IGeocircleFactory

class function TGeocircle.Create(position: BasicGeoposition; radius: Double): IGeocircle;
begin
  Result := Factory.Create(position, radius);
end;

class function TGeocircle.CreateWithAltitudeReferenceSystem(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem): IGeocircle;
begin
  Result := Factory.CreateWithAltitudeReferenceSystem(position, radius, altitudeReferenceSystem);
end;

class function TGeocircle.CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position: BasicGeoposition; radius: Double; altitudeReferenceSystem: AltitudeReferenceSystem; spatialReferenceId: Cardinal): IGeocircle;
begin
  Result := Factory.CreateWithAltitudeReferenceSystemAndSpatialReferenceId(position, radius, altitudeReferenceSystem, spatialReferenceId);
end;



end.
