{**********************************************************}
{                                                          }
{             CodeGear Delphi Runtime Library              }
{                                                          }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.         }
{              All rights reserved                         }
{                                                          }
{**********************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework MapKit
//

unit iOSapi.MapKit;

interface

uses
  Macapi.Dispatch,
  Macapi.ObjectiveC,
  iOSapi.CocoaTypes,
  iOSapi.CoreGraphics,
  iOSapi.CoreLocation,
  iOSapi.Foundation,
  iOSapi.UIKit;

const
  MKAnnotationViewDragStateNone = 0;
  MKAnnotationViewDragStateStarting = 1;
  MKAnnotationViewDragStateDragging = 2;
  MKAnnotationViewDragStateCanceling = 3;
  MKAnnotationViewDragStateEnding = 4;
  MKDistanceFormatterUnitsDefault = 0;
  MKDistanceFormatterUnitsMetric = 1;
  MKDistanceFormatterUnitsImperial = 2;
  MKDistanceFormatterUnitsImperialWithYards = 3;
  MKDistanceFormatterUnitStyleDefault = 0;
  MKDistanceFormatterUnitStyleAbbreviated = 1;
  MKDistanceFormatterUnitStyleFull = 2;
  MKMapTypeStandard = 0;
  MKMapTypeSatellite = 1;
  MKMapTypeHybrid = 2;
  MKErrorUnknown = 1;
  MKErrorServerFailure = 2;
  MKErrorLoadingThrottled = 3;
  MKErrorPlacemarkNotFound = 4;
  MKErrorDirectionsNotFound = 5;
  MKUserTrackingModeNone = 0;
  MKUserTrackingModeFollow = 1;
  MKUserTrackingModeFollowWithHeading = 2;
  MKOverlayLevelAboveRoads = 0;
  MKOverlayLevelAboveLabels = 1;
  MKPinAnnotationColorRed = 0;
  MKPinAnnotationColorGreen = 1;
  MKPinAnnotationColorPurple = 2;
  MKDirectionsTransportTypeAutomobile = 1 shl 0;
  MKDirectionsTransportTypeWalking = 1 shl 1;
  MKDirectionsTransportTypeAny = 268435455;

type

  // ===== Forward declarations =====
{$M+}
  MKAnnotation = interface;
  MKAnnotationView = interface;
  MKDistanceFormatter = interface;
  MKPlacemark = interface;
  MKMapItem = interface;
  MKOverlay = interface;
  MKOverlayRenderer = interface;
  MKOverlayView = interface;
  MKUserLocation = interface;
  MKMapCamera = interface;
  MKMapViewDelegate = interface;
  MKMapView = interface;
  MKPinAnnotationView = interface;
  MKShape = interface;
  MKPointAnnotation = interface;
  MKMultiPoint = interface;
  MKPolyline = interface;
  MKPolygon = interface;
  MKCircle = interface;
  MKGeodesicPolyline = interface;
  MKOverlayPathRenderer = interface;
  MKPolygonRenderer = interface;
  MKPolylineRenderer = interface;
  MKCircleRenderer = interface;
  MKLocalSearchRequest = interface;
  MKLocalSearchResponse = interface;
  MKLocalSearch = interface;
  MKDirectionsRequest = interface;
  MKDirectionsResponse = interface;
  MKETAResponse = interface;
  MKDirections = interface;
  MKRoute = interface;
  MKRouteStep = interface;
  MKMapSnapshotOptions = interface;
  MKMapSnapshot = interface;
  MKMapSnapshotter = interface;
  MKTileOverlay = interface;
  MKTileOverlayRenderer = interface;
  MKReverseGeocoderDelegate = interface;
  MKReverseGeocoder = interface;
  MKOverlayPathView = interface;
  MKPolygonView = interface;
  MKPolylineView = interface;
  MKCircleView = interface;
  MKUserTrackingBarButtonItem = interface;

  // ===== Framework typedefs =====
{$M+}
  MKAnnotationViewDragState = NSUInteger;
  MKDistanceFormatterUnits = NSUInteger;
  MKDistanceFormatterUnitStyle = NSUInteger;

  MKCoordinateSpan = record
    latitudeDelta: CLLocationDegrees;
    longitudeDelta: CLLocationDegrees;
  end;

  PMKCoordinateSpan = ^MKCoordinateSpan;

  MKCoordinateRegion = record
    center: CLLocationCoordinate2D;
    span: MKCoordinateSpan;
  end;

  PMKCoordinateRegion = ^MKCoordinateRegion;

  MKMapPoint = record
    x: Double;
    y: Double;
  end;

  PMKMapPoint = ^MKMapPoint;

  MKMapSize = record
    width: Double;
    height: Double;
  end;

  PMKMapSize = ^MKMapSize;

  MKMapRect = record
    origin: MKMapPoint;
    size: MKMapSize;
  end;

  PMKMapRect = ^MKMapRect;

  MKZoomScale = CGFloat;
  MKMapType = NSUInteger;
  MKErrorCode = NSUInteger;
  MKUserTrackingMode = NSInteger;
  MKOverlayLevel = NSInteger;
  MKPinAnnotationColor = NSUInteger;
  MKLocalSearchCompletionHandler = procedure(param1: MKLocalSearchResponse; param2: NSError) of object;
  MKDirectionsTransportType = NSUInteger;
  MKDirectionsHandler = procedure(param1: MKDirectionsResponse; param2: NSError) of object;
  MKETAHandler = procedure(param1: MKETAResponse; param2: NSError) of object;
  MKMapSnapshotCompletionHandler = procedure(snapshot: MKMapSnapshot; error: NSError) of object;

  MKTileOverlayPath = record
    x: NSInteger;
    y: NSInteger;
    z: NSInteger;
    contentScaleFactor: CGFloat;
  end;

  PMKTileOverlayPath = ^MKTileOverlayPath;

  TMapKitResult = procedure(param1: NSData; param2: NSError) of object;
  // ===== Interface declarations =====

  MKAnnotationViewClass = interface(UIViewClass)
    ['{A99E7F86-1548-47C0-B153-9F7191CD6B13}']
  end;

  MKAnnotationView = interface(UIView)
    ['{FA6EE792-31E2-4E88-8B32-7D74F047DCC8}']
    function initWithAnnotation(annotation: Pointer; reuseIdentifier: NSString): Pointer; cdecl;
    function reuseIdentifier: NSString; cdecl;
    procedure prepareForReuse; cdecl;
    procedure setAnnotation(annotation: Pointer); cdecl;
    function annotation: Pointer; cdecl;
    procedure setImage(image: UIImage); cdecl;
    function image: UIImage; cdecl;
    procedure setCenterOffset(centerOffset: CGPoint); cdecl;
    function centerOffset: CGPoint; cdecl;
    procedure setCalloutOffset(calloutOffset: CGPoint); cdecl;
    function calloutOffset: CGPoint; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    function isEnabled: Boolean; cdecl;
    procedure setHighlighted(highlighted: Boolean); cdecl;
    function isHighlighted: Boolean; cdecl;
    [MethodName('setSelected:')]
    procedure setSelected(selected: Boolean); cdecl;
    function isSelected: Boolean; cdecl;
    [MethodName('setSelected:animated:')]
    procedure setSelectedAnimated(selected: Boolean; animated: Boolean); cdecl;
    procedure setCanShowCallout(canShowCallout: Boolean); cdecl;
    function canShowCallout: Boolean; cdecl;
    procedure setLeftCalloutAccessoryView(leftCalloutAccessoryView: UIView); cdecl;
    function leftCalloutAccessoryView: UIView; cdecl;
    procedure setRightCalloutAccessoryView(rightCalloutAccessoryView: UIView); cdecl;
    function rightCalloutAccessoryView: UIView; cdecl;
    procedure setDraggable(draggable: Boolean); cdecl;
    function isDraggable: Boolean; cdecl;
    [MethodName('setDragState:')]
    procedure setDragState(dragState: MKAnnotationViewDragState); cdecl;
    function dragState: MKAnnotationViewDragState; cdecl;
    [MethodName('setDragState:animated:')]
    procedure setDragStateAnimated(newDragState: MKAnnotationViewDragState; animated: Boolean); cdecl;
  end;

  TMKAnnotationView = class(TOCGenericImport<MKAnnotationViewClass, MKAnnotationView>)
  end;

  MKDistanceFormatterClass = interface(NSFormatterClass)
    ['{B45509B8-532D-41AA-AAF6-67BBAFB713CD}']
  end;

  MKDistanceFormatter = interface(NSFormatter)
    ['{2D7F9109-D75B-4929-BF81-151E51688F72}']
    function stringFromDistance(distance: CLLocationDistance): NSString; cdecl;
    function distanceFromString(distance: NSString): CLLocationDistance; cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    function locale: NSLocale; cdecl;
    procedure setUnits(units: MKDistanceFormatterUnits); cdecl;
    function units: MKDistanceFormatterUnits; cdecl;
    procedure setUnitStyle(unitStyle: MKDistanceFormatterUnitStyle); cdecl;
    function unitStyle: MKDistanceFormatterUnitStyle; cdecl;
  end;

  TMKDistanceFormatter = class(TOCGenericImport<MKDistanceFormatterClass, MKDistanceFormatter>)
  end;

  MKPlacemarkClass = interface(CLPlacemarkClass)
    ['{979793F2-6ECA-4B35-89F4-6F0538A7EA99}']
  end;

  MKPlacemark = interface(CLPlacemark)
    ['{9F645657-2063-4553-9E48-46001C318F08}']
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; addressDictionary: NSDictionary): Pointer; cdecl;
    function countryCode: NSString; cdecl;
  end;

  TMKPlacemark = class(TOCGenericImport<MKPlacemarkClass, MKPlacemark>)
  end;

  MKMapItemClass = interface(NSObjectClass)
    ['{557E6EB9-2FE9-461E-B5A6-7E18E0237A2B}']
    {class} function mapItemForCurrentLocation: MKMapItem; cdecl;
    {class} function openMapsWithItems(mapItems: NSArray; launchOptions: NSDictionary): Boolean; cdecl;
  end;

  MKMapItem = interface(NSObject)
    ['{281F38CB-2702-4145-A689-1E87B259E4CF}']
    function placemark: MKPlacemark; cdecl;
    function isCurrentLocation: Boolean; cdecl;
    procedure setName(name: NSString); cdecl;
    function name: NSString; cdecl;
    procedure setPhoneNumber(phoneNumber: NSString); cdecl;
    function phoneNumber: NSString; cdecl;
    procedure setUrl(url: NSURL); cdecl;
    function url: NSURL; cdecl;
    function initWithPlacemark(placemark: MKPlacemark): Pointer; cdecl;
    function openInMapsWithLaunchOptions(launchOptions: NSDictionary): Boolean; cdecl;
  end;

  TMKMapItem = class(TOCGenericImport<MKMapItemClass, MKMapItem>)
  end;

  MKOverlayRendererClass = interface(NSObjectClass)
    ['{CCE87C23-BBB6-4DAA-B4F5-92EB6B5B48C8}']
  end;

  MKOverlayRenderer = interface(NSObject)
    ['{395ACCE8-4980-4D1C-9039-C6A945A77628}']
    function initWithOverlay(overlay: Pointer): Pointer; cdecl;
    function overlay: Pointer; cdecl;
    function pointForMapPoint(mapPoint: MKMapPoint): CGPoint; cdecl;
    function mapPointForPoint(point: CGPoint): MKMapPoint; cdecl;
    function rectForMapRect(mapRect: MKMapRect): CGRect; cdecl;
    function mapRectForRect(rect: CGRect): MKMapRect; cdecl;
    function canDrawMapRect(mapRect: MKMapRect; zoomScale: MKZoomScale): Boolean; cdecl;
    procedure drawMapRect(mapRect: MKMapRect; zoomScale: MKZoomScale; inContext: CGContextRef); cdecl;
    procedure setNeedsDisplay; cdecl;
    [MethodName('setNeedsDisplayInMapRect:')]
    procedure setNeedsDisplayInMapRect(mapRect: MKMapRect); cdecl;
    [MethodName('setNeedsDisplayInMapRect:zoomScale:')]
    procedure setNeedsDisplayInMapRectZoomScale(mapRect: MKMapRect; zoomScale: MKZoomScale); cdecl;
    procedure setAlpha(alpha: CGFloat); cdecl;
    function alpha: CGFloat; cdecl;
    function contentScaleFactor: CGFloat; cdecl;
  end;

  TMKOverlayRenderer = class(TOCGenericImport<MKOverlayRendererClass, MKOverlayRenderer>)
  end;

  MKOverlayViewClass = interface(UIViewClass)
    ['{72917955-824D-4D99-A43A-B96ED45FE055}']
  end;

  MKOverlayView = interface(UIView)
    ['{99276C14-DCCF-4B0B-A542-54205872D68F}']
    function initWithOverlay(overlay: Pointer): Pointer; cdecl;
    function overlay: Pointer; cdecl;
    function pointForMapPoint(mapPoint: MKMapPoint): CGPoint; cdecl;
    function mapPointForPoint(point: CGPoint): MKMapPoint; cdecl;
    function rectForMapRect(mapRect: MKMapRect): CGRect; cdecl;
    function mapRectForRect(rect: CGRect): MKMapRect; cdecl;
    function canDrawMapRect(mapRect: MKMapRect; zoomScale: MKZoomScale): Boolean; cdecl;
    procedure drawMapRect(mapRect: MKMapRect; zoomScale: MKZoomScale; inContext: CGContextRef); cdecl;
    [MethodName('setNeedsDisplayInMapRect:')]
    procedure setNeedsDisplayInMapRect(mapRect: MKMapRect); cdecl;
    [MethodName('setNeedsDisplayInMapRect:zoomScale:')]
    procedure setNeedsDisplayInMapRectZoomScale(mapRect: MKMapRect; zoomScale: MKZoomScale); cdecl;
  end;

  TMKOverlayView = class(TOCGenericImport<MKOverlayViewClass, MKOverlayView>)
  end;

  MKUserLocationClass = interface(NSObjectClass)
    ['{12FC32D7-0C10-445F-8934-322EB5A29E4C}']
  end;

  MKUserLocation = interface(NSObject)
    ['{655D6A38-F0CC-46E2-84FF-BFAE4AE1B707}']
    function isUpdating: Boolean; cdecl;
    function location: CLLocation; cdecl;
    function heading: CLHeading; cdecl;
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
    procedure setSubtitle(subtitle: NSString); cdecl;
    function subtitle: NSString; cdecl;
  end;

  TMKUserLocation = class(TOCGenericImport<MKUserLocationClass, MKUserLocation>)
  end;

  MKMapCameraClass = interface(NSObjectClass)
    ['{0957DE81-1791-455B-989D-57D72E47A111}']
    {class} function camera: Pointer{instancetype}; cdecl;
    {class} function cameraLookingAtCenterCoordinate(centerCoordinate: CLLocationCoordinate2D;
      fromEyeCoordinate: CLLocationCoordinate2D; eyeAltitude: CLLocationDistance): Pointer{instancetype}; cdecl;
  end;

  MKMapCamera = interface(NSObject)
    ['{8F128711-4D1E-4DA4-8A69-5A8DEA356E2F}']
    procedure setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D); cdecl;
    function centerCoordinate: CLLocationCoordinate2D; cdecl;
    procedure setHeading(heading: CLLocationDirection); cdecl;
    function heading: CLLocationDirection; cdecl;
    procedure setPitch(pitch: CGFloat); cdecl;
    function pitch: CGFloat; cdecl;
    procedure setAltitude(altitude: CLLocationDistance); cdecl;
    function altitude: CLLocationDistance; cdecl;
  end;

  TMKMapCamera = class(TOCGenericImport<MKMapCameraClass, MKMapCamera>)
  end;

  MKMapViewClass = interface(UIViewClass)
    ['{EA188A7C-CA50-4C61-AE70-C595F93EA358}']
  end;

  MKMapView = interface(UIView)
    ['{BBB29AD7-7E9C-4232-8816-1CA83BBEDA75}']
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure setMapType(mapType: MKMapType); cdecl;
    function mapType: MKMapType; cdecl;
    [MethodName('setRegion:')]
    procedure setRegion(region: MKCoordinateRegion); cdecl;
    function region: MKCoordinateRegion; cdecl;
    [MethodName('setRegion:animated:')]
    procedure setRegionAnimated(region: MKCoordinateRegion; animated: Boolean); cdecl;
    [MethodName('setCenterCoordinate:')]
    procedure setCenterCoordinate(centerCoordinate: CLLocationCoordinate2D); cdecl;
    function centerCoordinate: CLLocationCoordinate2D; cdecl;
    [MethodName('setCenterCoordinate:animated:')]
    procedure setCenterCoordinateAnimated(coordinate: CLLocationCoordinate2D; animated: Boolean); cdecl;
    function regionThatFits(region: MKCoordinateRegion): MKCoordinateRegion; cdecl;
    [MethodName('setVisibleMapRect:')]
    procedure setVisibleMapRect(visibleMapRect: MKMapRect); cdecl;
    function visibleMapRect: MKMapRect; cdecl;
    [MethodName('setVisibleMapRect:animated:')]
    procedure setVisibleMapRectAnimated(mapRect: MKMapRect; animated: Boolean); cdecl;
    [MethodName('mapRectThatFits:')]
    function mapRectThatFits(mapRect: MKMapRect): MKMapRect; cdecl;
    [MethodName('setVisibleMapRect:edgePadding:animated:')]
    procedure setVisibleMapRectEdgePaddingAnimated(mapRect: MKMapRect; edgePadding: UIEdgeInsets;
      animated: Boolean); cdecl;
    [MethodName('mapRectThatFits:edgePadding:')]
    function mapRectThatFitsEdgePadding(mapRect: MKMapRect; edgePadding: UIEdgeInsets): MKMapRect; cdecl;
    [MethodName('setCamera:')]
    procedure setCamera(camera: MKMapCamera); cdecl;
    function camera: MKMapCamera; cdecl;
    [MethodName('setCamera:animated:')]
    procedure setCameraAnimated(camera: MKMapCamera; animated: Boolean); cdecl;
    function convertCoordinate(coordinate: CLLocationCoordinate2D; toPointToView: UIView): CGPoint; cdecl;
    function convertPoint(point: CGPoint; toCoordinateFromView: UIView): CLLocationCoordinate2D; cdecl;
    function convertRegion(region: MKCoordinateRegion; toRectToView: UIView): CGRect; cdecl;
    function convertRect(rect: CGRect; toRegionFromView: UIView): MKCoordinateRegion; cdecl;
    procedure setZoomEnabled(zoomEnabled: Boolean); cdecl;
    function isZoomEnabled: Boolean; cdecl;
    procedure setScrollEnabled(scrollEnabled: Boolean); cdecl;
    function isScrollEnabled: Boolean; cdecl;
    procedure setRotateEnabled(rotateEnabled: Boolean); cdecl;
    function isRotateEnabled: Boolean; cdecl;
    procedure setPitchEnabled(pitchEnabled: Boolean); cdecl;
    function isPitchEnabled: Boolean; cdecl;
    procedure setShowsPointsOfInterest(showsPointsOfInterest: Boolean); cdecl;
    function showsPointsOfInterest: Boolean; cdecl;
    procedure setShowsBuildings(showsBuildings: Boolean); cdecl;
    function showsBuildings: Boolean; cdecl;
    procedure setShowsUserLocation(showsUserLocation: Boolean); cdecl;
    function showsUserLocation: Boolean; cdecl;
    function userLocation: MKUserLocation; cdecl;
    [MethodName('setUserTrackingMode:')]
    procedure setUserTrackingMode(userTrackingMode: MKUserTrackingMode); cdecl;
    function userTrackingMode: MKUserTrackingMode; cdecl;
    [MethodName('setUserTrackingMode:animated:')]
    procedure setUserTrackingModeAnimated(mode: MKUserTrackingMode; animated: Boolean); cdecl;
    function isUserLocationVisible: Boolean; cdecl;
    procedure addAnnotation(annotation: Pointer); cdecl;
    procedure addAnnotations(annotations: NSArray); cdecl;
    procedure removeAnnotation(annotation: Pointer); cdecl;
    procedure removeAnnotations(annotations: NSArray); cdecl;
    function annotations: NSArray; cdecl;
    function annotationsInMapRect(mapRect: MKMapRect): NSSet; cdecl;
    function viewForAnnotation(annotation: Pointer): MKAnnotationView; cdecl;
    function dequeueReusableAnnotationViewWithIdentifier(identifier: NSString): MKAnnotationView; cdecl;
    procedure selectAnnotation(annotation: Pointer; animated: Boolean); cdecl;
    procedure deselectAnnotation(annotation: Pointer; animated: Boolean); cdecl;
    procedure setSelectedAnnotations(selectedAnnotations: NSArray); cdecl;
    function selectedAnnotations: NSArray; cdecl;
    function annotationVisibleRect: CGRect; cdecl;
    procedure showAnnotations(annotations: NSArray; animated: Boolean); cdecl;
    [MethodName('addOverlay:level:')]
    procedure addOverlayLevel(overlay: Pointer; level: MKOverlayLevel); cdecl;
    [MethodName('addOverlays:level:')]
    procedure addOverlaysLevel(overlays: NSArray; level: MKOverlayLevel); cdecl;
    procedure removeOverlay(overlay: Pointer); cdecl;
    procedure removeOverlays(overlays: NSArray); cdecl;
    [MethodName('insertOverlay:atIndex:level:')]
    procedure insertOverlayAtIndexLevel(overlay: Pointer; atIndex: NSUInteger; level: MKOverlayLevel); cdecl;
    [MethodName('insertOverlay:aboveOverlay:')]
    procedure insertOverlayAboveOverlay(overlay: Pointer; aboveOverlay: Pointer); cdecl;
    [MethodName('insertOverlay:belowOverlay:')]
    procedure insertOverlayBelowOverlay(overlay: Pointer; belowOverlay: Pointer); cdecl;
    procedure exchangeOverlay(overlay1: Pointer; withOverlay: Pointer); cdecl;
    function overlays: NSArray; cdecl;
    function overlaysInLevel(level: MKOverlayLevel): NSArray; cdecl;
    function rendererForOverlay(overlay: Pointer): MKOverlayRenderer; cdecl;
    function viewForOverlay(overlay: Pointer): MKOverlayView; cdecl;
    [MethodName('addOverlay:')]
    procedure addOverlay(overlay: Pointer); cdecl;
    [MethodName('addOverlays:')]
    procedure addOverlays(overlays: NSArray); cdecl;
    [MethodName('insertOverlay:atIndex:')]
    procedure insertOverlayAtIndex(overlay: Pointer; atIndex: NSUInteger); cdecl;
    procedure exchangeOverlayAtIndex(index1: NSUInteger; withOverlayAtIndex: NSUInteger); cdecl;
  end;

  TMKMapView = class(TOCGenericImport<MKMapViewClass, MKMapView>)
  end;

  MKPinAnnotationViewClass = interface(MKAnnotationViewClass)
    ['{340EB683-30F5-4757-94A5-2408523E5721}']
  end;

  MKPinAnnotationView = interface(MKAnnotationView)
    ['{B6BC09AB-5844-42C8-91FB-5AAACC6BD697}']
    procedure setPinColor(pinColor: MKPinAnnotationColor); cdecl;
    function pinColor: MKPinAnnotationColor; cdecl;
    procedure setAnimatesDrop(animatesDrop: Boolean); cdecl;
    function animatesDrop: Boolean; cdecl;
  end;

  TMKPinAnnotationView = class(TOCGenericImport<MKPinAnnotationViewClass, MKPinAnnotationView>)
  end;

  MKShapeClass = interface(NSObjectClass)
    ['{D04DB8A4-6819-494D-80A1-DA3B27F3BA22}']
  end;

  MKShape = interface(NSObject)
    ['{4EFF3193-D141-48E1-8A2B-DE20CEB8DB20}']
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
    procedure setSubtitle(subtitle: NSString); cdecl;
    function subtitle: NSString; cdecl;
  end;

  TMKShape = class(TOCGenericImport<MKShapeClass, MKShape>)
  end;

  MKPointAnnotationClass = interface(MKShapeClass)
    ['{4B451E3F-9281-4314-A795-7AD9F1B01864}']
  end;

  MKPointAnnotation = interface(MKShape)
    ['{7DC2AB99-C4B9-474E-AC7B-6A1509F7BA19}']
    procedure setCoordinate(coordinate: CLLocationCoordinate2D); cdecl;
    function coordinate: CLLocationCoordinate2D; cdecl;
  end;

  TMKPointAnnotation = class(TOCGenericImport<MKPointAnnotationClass, MKPointAnnotation>)
  end;

  MKMultiPointClass = interface(MKShapeClass)
    ['{1A21860D-8841-4C0B-8F77-0CEC970A65BB}']
  end;

  MKMultiPoint = interface(MKShape)
    ['{F5F0ACC8-81EB-4F66-957A-092A071873D9}']
    function points: Pointer; cdecl;
    function pointCount: NSUInteger; cdecl;
    procedure getCoordinates(coords: Pointer; range: NSRange); cdecl;
  end;

  TMKMultiPoint = class(TOCGenericImport<MKMultiPointClass, MKMultiPoint>)
  end;

  MKPolylineClass = interface(MKMultiPointClass)
    ['{8A42CEDB-7387-4233-9F62-4B567CBD5AB7}']
    {class} function polylineWithPoints(points: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
    {class} function polylineWithCoordinates(coords: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
  end;

  MKPolyline = interface(MKMultiPoint)
    ['{60400075-21CD-4A8A-9E4E-017EA72DD03A}']
  end;

  TMKPolyline = class(TOCGenericImport<MKPolylineClass, MKPolyline>)
  end;

  MKPolygonClass = interface(MKMultiPointClass)
    ['{B1893076-2F05-4DFC-B321-88E956BE3A3B}']
    {class} [MethodName('polygonWithPoints:count:')]
    function polygonWithPointsCount(points: Pointer; count: NSUInteger): MKPolygon; cdecl;
    {class} [MethodName('polygonWithPoints:count:interiorPolygons:')]
    function polygonWithPointsCountInteriorPolygons(points: Pointer; count: NSUInteger; interiorPolygons: NSArray)
      : MKPolygon; cdecl;
    {class} [MethodName('polygonWithCoordinates:count:')]
    function polygonWithCoordinatesCount(coords: Pointer; count: NSUInteger): MKPolygon; cdecl;
    {class} [MethodName('polygonWithCoordinates:count:interiorPolygons:')]
    function polygonWithCoordinatesCountInteriorPolygons(coords: Pointer; count: NSUInteger; interiorPolygons: NSArray)
      : MKPolygon; cdecl;
  end;

  MKPolygon = interface(MKMultiPoint)
    ['{91945217-38D3-4ACD-9934-7ABA6A545D28}']
    function interiorPolygons: NSArray; cdecl;
  end;

  TMKPolygon = class(TOCGenericImport<MKPolygonClass, MKPolygon>)
  end;

  MKCircleClass = interface(MKShapeClass)
    ['{3E936ABD-AA5B-4158-86A2-6E76F32C8E77}']
    {class} function circleWithCenterCoordinate(coord: CLLocationCoordinate2D; radius: CLLocationDistance)
      : MKCircle; cdecl;
    {class} function circleWithMapRect(mapRect: MKMapRect): MKCircle; cdecl;
  end;

  MKCircle = interface(MKShape)
    ['{55394BD6-6F61-432A-B352-5AD9457670BB}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function radius: CLLocationDistance; cdecl;
    function boundingMapRect: MKMapRect; cdecl;
  end;

  TMKCircle = class(TOCGenericImport<MKCircleClass, MKCircle>)
  end;

  MKGeodesicPolylineClass = interface(MKPolylineClass)
    ['{CA818F6E-BE43-4654-A151-E17ACF38D1F8}']
    {class} function polylineWithPoints(points: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
    {class} function polylineWithCoordinates(coords: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
  end;

  MKGeodesicPolyline = interface(MKPolyline)
    ['{D08E6CAC-A1A5-4204-A621-7C05AA86E453}']
  end;

  TMKGeodesicPolyline = class(TOCGenericImport<MKGeodesicPolylineClass, MKGeodesicPolyline>)
  end;

  MKOverlayPathRendererClass = interface(MKOverlayRendererClass)
    ['{05AA904B-9E32-47EE-BD3C-3D361FBA30E4}']
  end;

  MKOverlayPathRenderer = interface(MKOverlayRenderer)
    ['{00D39B47-094C-495C-9FF0-3A8C7A065344}']
    procedure setFillColor(fillColor: UIColor); cdecl;
    function fillColor: UIColor; cdecl;
    procedure setStrokeColor(strokeColor: UIColor); cdecl;
    function strokeColor: UIColor; cdecl;
    procedure setLineWidth(lineWidth: CGFloat); cdecl;
    function lineWidth: CGFloat; cdecl;
    procedure setLineJoin(lineJoin: CGLineJoin); cdecl;
    function lineJoin: CGLineJoin; cdecl;
    procedure setLineCap(lineCap: CGLineCap); cdecl;
    function lineCap: CGLineCap; cdecl;
    procedure setMiterLimit(miterLimit: CGFloat); cdecl;
    function miterLimit: CGFloat; cdecl;
    procedure setLineDashPhase(lineDashPhase: CGFloat); cdecl;
    function lineDashPhase: CGFloat; cdecl;
    procedure setLineDashPattern(lineDashPattern: NSArray); cdecl;
    function lineDashPattern: NSArray; cdecl;
    procedure createPath; cdecl;
    procedure setPath(path: CGPathRef); cdecl;
    function path: CGPathRef; cdecl;
    procedure invalidatePath; cdecl;
    procedure applyStrokePropertiesToContext(context: CGContextRef; atZoomScale: MKZoomScale); cdecl;
    procedure applyFillPropertiesToContext(context: CGContextRef; atZoomScale: MKZoomScale); cdecl;
    procedure strokePath(path: CGPathRef; inContext: CGContextRef); cdecl;
    procedure fillPath(path: CGPathRef; inContext: CGContextRef); cdecl;
  end;

  TMKOverlayPathRenderer = class(TOCGenericImport<MKOverlayPathRendererClass, MKOverlayPathRenderer>)
  end;

  MKPolygonRendererClass = interface(MKOverlayPathRendererClass)
    ['{222DCC22-AAFD-4B0E-9CB9-82E6CD2054BC}']
  end;

  MKPolygonRenderer = interface(MKOverlayPathRenderer)
    ['{E95619DE-45EA-4A4B-8DA1-12AEDE420F69}']
    function initWithPolygon(polygon: MKPolygon): Pointer; cdecl;
    function polygon: MKPolygon; cdecl;
  end;

  TMKPolygonRenderer = class(TOCGenericImport<MKPolygonRendererClass, MKPolygonRenderer>)
  end;

  MKPolylineRendererClass = interface(MKOverlayPathRendererClass)
    ['{695068D9-5314-45D4-B8FC-2E9F9BF106E3}']
  end;

  MKPolylineRenderer = interface(MKOverlayPathRenderer)
    ['{602EABE3-C17F-4DD1-B3CD-D98E4C03DCDC}']
    function initWithPolyline(polyline: MKPolyline): Pointer; cdecl;
    function polyline: MKPolyline; cdecl;
  end;

  TMKPolylineRenderer = class(TOCGenericImport<MKPolylineRendererClass, MKPolylineRenderer>)
  end;

  MKCircleRendererClass = interface(MKOverlayPathRendererClass)
    ['{0C597FCC-50D0-44EA-AB41-29BA5BA76052}']
  end;

  MKCircleRenderer = interface(MKOverlayPathRenderer)
    ['{EC9D4A89-F291-4E5C-BF2A-D11263CC6931}']
    function initWithCircle(circle: MKCircle): Pointer; cdecl;
    function circle: MKCircle; cdecl;
  end;

  TMKCircleRenderer = class(TOCGenericImport<MKCircleRendererClass, MKCircleRenderer>)
  end;

  MKLocalSearchRequestClass = interface(NSObjectClass)
    ['{065F0486-31C8-4D45-94D8-E97D36DCC780}']
  end;

  MKLocalSearchRequest = interface(NSObject)
    ['{EF610BE8-CB1D-49DE-ADBE-3A8A91245CC4}']
    procedure setNaturalLanguageQuery(naturalLanguageQuery: NSString); cdecl;
    function naturalLanguageQuery: NSString; cdecl;
    procedure setRegion(region: MKCoordinateRegion); cdecl;
    function region: MKCoordinateRegion; cdecl;
  end;

  TMKLocalSearchRequest = class(TOCGenericImport<MKLocalSearchRequestClass, MKLocalSearchRequest>)
  end;

  MKLocalSearchResponseClass = interface(NSObjectClass)
    ['{13A1778A-DEE7-4B2A-828C-14C8C1C8F01D}']
  end;

  MKLocalSearchResponse = interface(NSObject)
    ['{89DAE669-9FE2-4233-BE00-76C66507750F}']
    function mapItems: NSArray; cdecl;
    function boundingRegion: MKCoordinateRegion; cdecl;
  end;

  TMKLocalSearchResponse = class(TOCGenericImport<MKLocalSearchResponseClass, MKLocalSearchResponse>)
  end;

  MKLocalSearchClass = interface(NSObjectClass)
    ['{E7E7D54A-4769-4763-988B-86AE610CA5AE}']
  end;

  MKLocalSearch = interface(NSObject)
    ['{CBDDC2B7-8779-4E5C-BA6B-C69C8EA874E3}']
    function initWithRequest(request: MKLocalSearchRequest): Pointer; cdecl;
    procedure startWithCompletionHandler(completionHandler: MKLocalSearchCompletionHandler); cdecl;
    procedure cancel; cdecl;
    function isSearching: Boolean; cdecl;
  end;

  TMKLocalSearch = class(TOCGenericImport<MKLocalSearchClass, MKLocalSearch>)
  end;

  MKDirectionsRequestClass = interface(NSObjectClass)
    ['{62610AD5-B092-4FF7-ACC8-F42CBA00087D}']
    {class} function isDirectionsRequestURL(url: NSURL): Boolean; cdecl;
  end;

  MKDirectionsRequest = interface(NSObject)
    ['{B0E4EF63-4A4E-40E4-818B-6F6666C34744}']
    function source: MKMapItem; cdecl;
    procedure setSource(source: MKMapItem); cdecl;
    function destination: MKMapItem; cdecl;
    procedure setDestination(destination: MKMapItem); cdecl;
    procedure setTransportType(transportType: MKDirectionsTransportType); cdecl;
    function transportType: MKDirectionsTransportType; cdecl;
    procedure setRequestsAlternateRoutes(requestsAlternateRoutes: Boolean); cdecl;
    function requestsAlternateRoutes: Boolean; cdecl;
    procedure setDepartureDate(departureDate: NSDate); cdecl;
    function departureDate: NSDate; cdecl;
    procedure setArrivalDate(arrivalDate: NSDate); cdecl;
    function arrivalDate: NSDate; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
  end;

  TMKDirectionsRequest = class(TOCGenericImport<MKDirectionsRequestClass, MKDirectionsRequest>)
  end;

  MKDirectionsResponseClass = interface(NSObjectClass)
    ['{32D4BA64-EB6F-4592-BB63-386D013B305F}']
  end;

  MKDirectionsResponse = interface(NSObject)
    ['{1FC095CB-3E8F-4812-BD4D-3664C8A4414A}']
    function source: MKMapItem; cdecl;
    function destination: MKMapItem; cdecl;
    function routes: NSArray; cdecl;
  end;

  TMKDirectionsResponse = class(TOCGenericImport<MKDirectionsResponseClass, MKDirectionsResponse>)
  end;

  MKETAResponseClass = interface(NSObjectClass)
    ['{21F769B3-014E-426A-B8C0-D319C774E8F9}']
  end;

  MKETAResponse = interface(NSObject)
    ['{9B616C27-0F54-475D-BD27-0419659F39EF}']
    function source: MKMapItem; cdecl;
    function destination: MKMapItem; cdecl;
    function expectedTravelTime: NSTimeInterval; cdecl;
  end;

  TMKETAResponse = class(TOCGenericImport<MKETAResponseClass, MKETAResponse>)
  end;

  MKDirectionsClass = interface(NSObjectClass)
    ['{656A3495-C84E-4DBC-8736-6ACE3F560386}']
  end;

  MKDirections = interface(NSObject)
    ['{09C72312-0CE7-43E4-82E3-7A621E95834D}']
    function initWithRequest(request: MKDirectionsRequest): Pointer{instancetype}; cdecl;
    procedure calculateDirectionsWithCompletionHandler(completionHandler: MKDirectionsHandler); cdecl;
    procedure calculateETAWithCompletionHandler(completionHandler: MKETAHandler); cdecl;
    procedure cancel; cdecl;
    function isCalculating: Boolean; cdecl;
  end;

  TMKDirections = class(TOCGenericImport<MKDirectionsClass, MKDirections>)
  end;

  MKRouteClass = interface(NSObjectClass)
    ['{29F2C187-6A02-4596-B994-AE812985C688}']
  end;

  MKRoute = interface(NSObject)
    ['{6EB6BB0D-BDF1-455C-BECB-99732F92CB7C}']
    function name: NSString; cdecl;
    function advisoryNotices: NSArray; cdecl;
    function distance: CLLocationDistance; cdecl;
    function expectedTravelTime: NSTimeInterval; cdecl;
    function transportType: MKDirectionsTransportType; cdecl;
    function polyline: MKPolyline; cdecl;
    function steps: NSArray; cdecl;
  end;

  TMKRoute = class(TOCGenericImport<MKRouteClass, MKRoute>)
  end;

  MKRouteStepClass = interface(NSObjectClass)
    ['{E1023629-9A30-4719-9E45-B9824D38FCA6}']
  end;

  MKRouteStep = interface(NSObject)
    ['{7519DCED-725A-43F3-8EEA-A458FDDC7EA5}']
    function instructions: NSString; cdecl;
    function notice: NSString; cdecl;
    function polyline: MKPolyline; cdecl;
    function distance: CLLocationDistance; cdecl;
    function transportType: MKDirectionsTransportType; cdecl;
  end;

  TMKRouteStep = class(TOCGenericImport<MKRouteStepClass, MKRouteStep>)
  end;

  MKMapSnapshotOptionsClass = interface(NSObjectClass)
    ['{8E2DB13B-F515-40BB-87D0-07480D79F795}']
  end;

  MKMapSnapshotOptions = interface(NSObject)
    ['{1D394667-FECF-40C2-AF75-772A8DD8FE1A}']
    procedure setCamera(camera: MKMapCamera); cdecl;
    function camera: MKMapCamera; cdecl;
    procedure setMapRect(mapRect: MKMapRect); cdecl;
    function mapRect: MKMapRect; cdecl;
    procedure setRegion(region: MKCoordinateRegion); cdecl;
    function region: MKCoordinateRegion; cdecl;
    procedure setMapType(mapType: MKMapType); cdecl;
    function mapType: MKMapType; cdecl;
    procedure setShowsPointsOfInterest(showsPointsOfInterest: Boolean); cdecl;
    function showsPointsOfInterest: Boolean; cdecl;
    procedure setShowsBuildings(showsBuildings: Boolean); cdecl;
    function showsBuildings: Boolean; cdecl;
    procedure setSize(size: CGSize); cdecl;
    function size: CGSize; cdecl;
    procedure setScale(scale: CGFloat); cdecl;
    function scale: CGFloat; cdecl;
  end;

  TMKMapSnapshotOptions = class(TOCGenericImport<MKMapSnapshotOptionsClass, MKMapSnapshotOptions>)
  end;

  MKMapSnapshotClass = interface(NSObjectClass)
    ['{8FFC7DDE-8FC8-4E3F-AC51-2B2E664F6590}']
  end;

  MKMapSnapshot = interface(NSObject)
    ['{FA4AB708-02E4-4DB6-9B8B-1C45A23E9706}']
    function image: UIImage; cdecl;
    function pointForCoordinate(coordinate: CLLocationCoordinate2D): CGPoint; cdecl;
  end;

  TMKMapSnapshot = class(TOCGenericImport<MKMapSnapshotClass, MKMapSnapshot>)
  end;

  MKMapSnapshotterClass = interface(NSObjectClass)
    ['{EC7C63DC-5FB5-48B8-83B7-D08C9CF95339}']
  end;

  MKMapSnapshotter = interface(NSObject)
    ['{75CE29DA-AF22-4A45-8EE9-00576371C4EA}']
    function initWithOptions(options: MKMapSnapshotOptions): Pointer{instancetype}; cdecl;
    procedure startWithCompletionHandler(completionHandler: MKMapSnapshotCompletionHandler); cdecl;
    procedure startWithQueue(queue: dispatch_queue_t; completionHandler: MKMapSnapshotCompletionHandler); cdecl;
    procedure cancel; cdecl;
    function isLoading: Boolean; cdecl;
  end;

  TMKMapSnapshotter = class(TOCGenericImport<MKMapSnapshotterClass, MKMapSnapshotter>)
  end;

  MKTileOverlayClass = interface(NSObjectClass)
    ['{2EFDD9BD-69D0-427E-80B2-67AE15671C20}']
  end;

  MKTileOverlay = interface(NSObject)
    ['{022FFEB7-8072-4E6B-BB65-C01C7349FC37}']
    function initWithURLTemplate(URLTemplate: NSString): Pointer; cdecl;
    procedure setTileSize(tileSize: CGSize); cdecl;
    function tileSize: CGSize; cdecl;
    procedure setGeometryFlipped(geometryFlipped: Boolean); cdecl;
    function isGeometryFlipped: Boolean; cdecl;
    procedure setMinimumZ(minimumZ: NSInteger); cdecl;
    function minimumZ: NSInteger; cdecl;
    procedure setMaximumZ(maximumZ: NSInteger); cdecl;
    function maximumZ: NSInteger; cdecl;
    function URLTemplate: NSString; cdecl;
    procedure setCanReplaceMapContent(canReplaceMapContent: Boolean); cdecl;
    function canReplaceMapContent: Boolean; cdecl;
    function URLForTilePath(path: MKTileOverlayPath): NSURL; cdecl;
    procedure loadTileAtPath(path: MKTileOverlayPath; result: TMapKitResult); cdecl;
  end;

  TMKTileOverlay = class(TOCGenericImport<MKTileOverlayClass, MKTileOverlay>)
  end;

  MKTileOverlayRendererClass = interface(MKOverlayRendererClass)
    ['{FFCC8271-8C1C-43D1-A7A3-A0DBC9B3457C}']
  end;

  MKTileOverlayRenderer = interface(MKOverlayRenderer)
    ['{0EDD7D15-065A-4CD8-A5B4-5DD18613E801}']
    function initWithTileOverlay(overlay: MKTileOverlay): Pointer; cdecl;
    procedure reloadData; cdecl;
  end;

  TMKTileOverlayRenderer = class(TOCGenericImport<MKTileOverlayRendererClass, MKTileOverlayRenderer>)
  end;

  MKReverseGeocoderClass = interface(NSObjectClass)
    ['{5F800717-BA22-4F94-9813-1CB747FA0328}']
  end;

  MKReverseGeocoder = interface(NSObject)
    ['{94B98967-0208-4048-BC69-C74D757A8EF8}']
    function initWithCoordinate(coordinate: CLLocationCoordinate2D): Pointer; cdecl;
    procedure start; cdecl;
    procedure cancel; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function coordinate: CLLocationCoordinate2D; cdecl;
    function placemark: MKPlacemark; cdecl;
    function isQuerying: Boolean; cdecl;
  end;

  TMKReverseGeocoder = class(TOCGenericImport<MKReverseGeocoderClass, MKReverseGeocoder>)
  end;

  MKOverlayPathViewClass = interface(MKOverlayViewClass)
    ['{F6B36F0A-E74E-467C-B50D-A2D3E1E641CF}']
  end;

  MKOverlayPathView = interface(MKOverlayView)
    ['{9B775774-6E6C-44F4-BF7E-33A388ED7BCC}']
    procedure setFillColor(fillColor: UIColor); cdecl;
    function fillColor: UIColor; cdecl;
    procedure setStrokeColor(strokeColor: UIColor); cdecl;
    function strokeColor: UIColor; cdecl;
    procedure setLineWidth(lineWidth: CGFloat); cdecl;
    function lineWidth: CGFloat; cdecl;
    procedure setLineJoin(lineJoin: CGLineJoin); cdecl;
    function lineJoin: CGLineJoin; cdecl;
    procedure setLineCap(lineCap: CGLineCap); cdecl;
    function lineCap: CGLineCap; cdecl;
    procedure setMiterLimit(miterLimit: CGFloat); cdecl;
    function miterLimit: CGFloat; cdecl;
    procedure setLineDashPhase(lineDashPhase: CGFloat); cdecl;
    function lineDashPhase: CGFloat; cdecl;
    procedure setLineDashPattern(lineDashPattern: NSArray); cdecl;
    function lineDashPattern: NSArray; cdecl;
    procedure createPath; cdecl;
    procedure setPath(path: CGPathRef); cdecl;
    function path: CGPathRef; cdecl;
    procedure invalidatePath; cdecl;
    procedure applyStrokePropertiesToContext(context: CGContextRef; atZoomScale: MKZoomScale); cdecl;
    procedure applyFillPropertiesToContext(context: CGContextRef; atZoomScale: MKZoomScale); cdecl;
    procedure strokePath(path: CGPathRef; inContext: CGContextRef); cdecl;
    procedure fillPath(path: CGPathRef; inContext: CGContextRef); cdecl;
  end;

  TMKOverlayPathView = class(TOCGenericImport<MKOverlayPathViewClass, MKOverlayPathView>)
  end;

  MKPolygonViewClass = interface(MKOverlayPathViewClass)
    ['{2DB82DAB-D352-48EE-B33E-B63789BFD80E}']
  end;

  MKPolygonView = interface(MKOverlayPathView)
    ['{6D7A5EC8-11D4-4363-AED1-A95B1F851279}']
    function initWithPolygon(polygon: MKPolygon): Pointer; cdecl;
    function polygon: MKPolygon; cdecl;
  end;

  TMKPolygonView = class(TOCGenericImport<MKPolygonViewClass, MKPolygonView>)
  end;

  MKPolylineViewClass = interface(MKOverlayPathViewClass)
    ['{A8ED75B7-A805-4F49-BEE4-217D72860377}']
  end;

  MKPolylineView = interface(MKOverlayPathView)
    ['{93F65EE8-F8A2-4408-AECD-6116B24ECB5F}']
    function initWithPolyline(polyline: MKPolyline): Pointer; cdecl;
    function polyline: MKPolyline; cdecl;
  end;

  TMKPolylineView = class(TOCGenericImport<MKPolylineViewClass, MKPolylineView>)
  end;

  MKCircleViewClass = interface(MKOverlayPathViewClass)
    ['{6B1583A9-EB00-4DB5-B35F-7B7CC646DADC}']
  end;

  MKCircleView = interface(MKOverlayPathView)
    ['{45432614-C9CB-4CA2-8A00-7B65E68B8689}']
    function initWithCircle(circle: MKCircle): Pointer; cdecl;
    function circle: MKCircle; cdecl;
  end;

  TMKCircleView = class(TOCGenericImport<MKCircleViewClass, MKCircleView>)
  end;

  MKUserTrackingBarButtonItemClass = interface(UIBarButtonItemClass)
    ['{166C34AA-CD78-4FA1-A28E-1437AC058476}']
  end;

  MKUserTrackingBarButtonItem = interface(UIBarButtonItem)
    ['{9ED89AF6-019C-4B0A-9275-2D83568F3C70}']
    function initWithMapView(mapView: MKMapView): Pointer; cdecl;
    procedure setMapView(mapView: MKMapView); cdecl;
    function mapView: MKMapView; cdecl;
  end;

  TMKUserTrackingBarButtonItem = class(TOCGenericImport<MKUserTrackingBarButtonItemClass, MKUserTrackingBarButtonItem>)
  end;

  // ===== Protocol declarations =====

  MKAnnotation = interface(IObjectiveC)
    ['{C50B8AB5-B79A-499F-99C3-71DE8E7DA2B1}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function title: NSString; cdecl;
    function subtitle: NSString; cdecl;
    procedure setCoordinate(newCoordinate: CLLocationCoordinate2D); cdecl;
  end;

  MKOverlay = interface(IObjectiveC)
    ['{0520D101-B198-463B-AD46-6199FCD6FDD8}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function boundingMapRect: MKMapRect; cdecl;
    function intersectsMapRect(mapRect: MKMapRect): Boolean; cdecl;
    function canReplaceMapContent: Boolean; cdecl;
  end;

  MKMapViewDelegate = interface(IObjectiveC)
    ['{29CC14DB-9E65-4332-9B2C-5A54DC28D163}']
    [MethodName('mapView:regionWillChangeAnimated:')]
    procedure mapViewRegionWillChangeAnimated(mapView: MKMapView; regionWillChangeAnimated: Boolean); cdecl;
    [MethodName('mapView:regionDidChangeAnimated:')]
    procedure mapViewRegionDidChangeAnimated(mapView: MKMapView; regionDidChangeAnimated: Boolean); cdecl;
    procedure mapViewWillStartLoadingMap(mapView: MKMapView); cdecl;
    procedure mapViewDidFinishLoadingMap(mapView: MKMapView); cdecl;
    procedure mapViewDidFailLoadingMap(mapView: MKMapView; withError: NSError); cdecl;
    procedure mapViewWillStartRenderingMap(mapView: MKMapView); cdecl;
    procedure mapViewDidFinishRenderingMap(mapView: MKMapView; fullyRendered: Boolean); cdecl;
    [MethodName('mapView:viewForAnnotation:')]
    function mapViewViewForAnnotation(mapView: MKMapView; viewForAnnotation: Pointer): MKAnnotationView; cdecl;
    [MethodName('mapView:didAddAnnotationViews:')]
    procedure mapViewDidAddAnnotationViews(mapView: MKMapView; didAddAnnotationViews: NSArray); cdecl;
    [MethodName('mapView:annotationView:calloutAccessoryControlTapped:')]
    procedure mapViewAnnotationViewCalloutAccessoryControlTapped(mapView: MKMapView; annotationView: MKAnnotationView;
      calloutAccessoryControlTapped: UIControl); cdecl;
    [MethodName('mapView:didSelectAnnotationView:')]
    procedure mapViewDidSelectAnnotationView(mapView: MKMapView; didSelectAnnotationView: MKAnnotationView); cdecl;
    [MethodName('mapView:didDeselectAnnotationView:')]
    procedure mapViewDidDeselectAnnotationView(mapView: MKMapView; didDeselectAnnotationView: MKAnnotationView); cdecl;
    procedure mapViewWillStartLocatingUser(mapView: MKMapView); cdecl;
    procedure mapViewDidStopLocatingUser(mapView: MKMapView); cdecl;
    [MethodName('mapView:didUpdateUserLocation:')]
    procedure mapViewDidUpdateUserLocation(mapView: MKMapView; didUpdateUserLocation: MKUserLocation); cdecl;
    [MethodName('mapView:didFailToLocateUserWithError:')]
    procedure mapViewDidFailToLocateUserWithError(mapView: MKMapView; didFailToLocateUserWithError: NSError); cdecl;
    [MethodName('mapView:annotationView:didChangeDragState:fromOldState:')]
    procedure mapViewAnnotationViewDidChangeDragStateFromOldState(mapView: MKMapView; annotationView: MKAnnotationView;
      didChangeDragState: MKAnnotationViewDragState; fromOldState: MKAnnotationViewDragState); cdecl;
    [MethodName('mapView:didChangeUserTrackingMode:animated:')]
    procedure mapViewDidChangeUserTrackingModeAnimated(mapView: MKMapView;
      didChangeUserTrackingMode: MKUserTrackingMode; animated: Boolean); cdecl;
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; rendererForOverlay: Pointer): MKOverlayRenderer; cdecl;
    [MethodName('mapView:didAddOverlayRenderers:')]
    procedure mapViewDidAddOverlayRenderers(mapView: MKMapView; didAddOverlayRenderers: NSArray); cdecl;
    [MethodName('mapView:viewForOverlay:')]
    function mapViewViewForOverlay(mapView: MKMapView; viewForOverlay: Pointer): MKOverlayView; cdecl;
    [MethodName('mapView:didAddOverlayViews:')]
    procedure mapViewDidAddOverlayViews(mapView: MKMapView; didAddOverlayViews: NSArray); cdecl;
  end;

  MKReverseGeocoderDelegate = interface(IObjectiveC)
    ['{55B8B010-E213-476F-A656-1A023035697C}']
    [MethodName('reverseGeocoder:didFindPlacemark:')]
    procedure reverseGeocoderDidFindPlacemark(geocoder: MKReverseGeocoder; didFindPlacemark: MKPlacemark); cdecl;
    [MethodName('reverseGeocoder:didFailWithError:')]
    procedure reverseGeocoderDidFailWithError(geocoder: MKReverseGeocoder; didFailWithError: NSError); cdecl;
  end;

  // ===== Exported string consts =====

function MKAnnotationCalloutInfoDidChangeNotification: NSString;
function MKLaunchOptionsDirectionsModeKey: NSString;
function MKLaunchOptionsMapTypeKey: NSString;
function MKLaunchOptionsShowsTrafficKey: NSString;
function MKLaunchOptionsDirectionsModeDriving: NSString;
function MKLaunchOptionsDirectionsModeWalking: NSString;
function MKLaunchOptionsMapCenterKey: NSString;
function MKLaunchOptionsMapSpanKey: NSString;
function MKLaunchOptionsCameraKey: NSString;
function MKErrorDomain: NSString;


// ===== External functions =====

const
  libMapKit = '/System/Library/Frameworks/MapKit.framework/MapKit';

function MKCoordinateSpanMake(latitudeDelta: CLLocationDegrees; longitudeDelta: CLLocationDegrees): MKCoordinateSpan;
  cdecl; external libMapKit name _PU + 'MKCoordinateSpanMake';
function MKCoordinateRegionMake(centerCoordinate: CLLocationCoordinate2D; span: MKCoordinateSpan): MKCoordinateRegion;
  cdecl; external libMapKit name _PU + 'MKCoordinateRegionMake';
function MKCoordinateRegionMakeWithDistance(centerCoordinate: CLLocationCoordinate2D;
  latitudinalMeters: CLLocationDistance; longitudinalMeters: CLLocationDistance): MKCoordinateRegion; cdecl;
  external libMapKit name _PU + 'MKCoordinateRegionMakeWithDistance';
function MKMapPointForCoordinate(coordinate: CLLocationCoordinate2D): MKMapPoint; cdecl;
  external libMapKit name _PU + 'MKMapPointForCoordinate';
function MKCoordinateForMapPoint(mapPoint: MKMapPoint): CLLocationCoordinate2D; cdecl;
  external libMapKit name _PU + 'MKCoordinateForMapPoint';
function MKMetersPerMapPointAtLatitude(latitude: CLLocationDegrees): CLLocationDistance; cdecl;
  external libMapKit name _PU + 'MKMetersPerMapPointAtLatitude';
function MKMapPointsPerMeterAtLatitude(latitude: CLLocationDegrees): Double; cdecl;
  external libMapKit name _PU + 'MKMapPointsPerMeterAtLatitude';
function MKMetersBetweenMapPoints(a: MKMapPoint; b: MKMapPoint): CLLocationDistance; cdecl;
  external libMapKit name _PU + 'MKMetersBetweenMapPoints';
function MKMapPointMake(x: Double; y: Double): MKMapPoint; cdecl; external libMapKit name _PU + 'MKMapPointMake';
function MKMapSizeMake(width: Double; height: Double): MKMapSize; cdecl; external libMapKit name _PU + 'MKMapSizeMake';
function MKMapRectMake(x: Double; y: Double; width: Double; height: Double): MKMapRect; cdecl;
  external libMapKit name _PU + 'MKMapRectMake';
function MKMapRectGetMinX(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMinX';
function MKMapRectGetMinY(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMinY';
function MKMapRectGetMidX(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMidX';
function MKMapRectGetMidY(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMidY';
function MKMapRectGetMaxX(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMaxX';
function MKMapRectGetMaxY(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetMaxY';
function MKMapRectGetWidth(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetWidth';
function MKMapRectGetHeight(rect: MKMapRect): Double; cdecl; external libMapKit name _PU + 'MKMapRectGetHeight';
function MKMapPointEqualToPoint(point1: MKMapPoint; point2: MKMapPoint): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapPointEqualToPoint';
function MKMapSizeEqualToSize(size1: MKMapSize; size2: MKMapSize): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapSizeEqualToSize';
function MKMapRectEqualToRect(rect1: MKMapRect; rect2: MKMapRect): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapRectEqualToRect';
function MKMapRectIsNull(rect: MKMapRect): Boolean; cdecl; external libMapKit name _PU + 'MKMapRectIsNull';
function MKMapRectIsEmpty(rect: MKMapRect): Boolean; cdecl; external libMapKit name _PU + 'MKMapRectIsEmpty';
function MKStringFromMapPoint(point: MKMapPoint): NSString; cdecl; external libMapKit name _PU + 'MKStringFromMapPoint';
function MKStringFromMapSize(size: MKMapSize): NSString; cdecl; external libMapKit name _PU + 'MKStringFromMapSize';
function MKStringFromMapRect(rect: MKMapRect): NSString; cdecl; external libMapKit name _PU + 'MKStringFromMapRect';
function MKMapRectUnion(rect1: MKMapRect; rect2: MKMapRect): MKMapRect; cdecl;
  external libMapKit name _PU + 'MKMapRectUnion';
function MKMapRectIntersection(rect1: MKMapRect; rect2: MKMapRect): MKMapRect; cdecl;
  external libMapKit name _PU + 'MKMapRectIntersection';
function MKMapRectInset(rect: MKMapRect; dx: Double; dy: Double): MKMapRect; cdecl;
  external libMapKit name _PU + 'MKMapRectInset';
function MKMapRectOffset(rect: MKMapRect; dx: Double; dy: Double): MKMapRect; cdecl;
  external libMapKit name _PU + 'MKMapRectOffset';
procedure MKMapRectDivide(rect: MKMapRect; slice: Pointer; remainder: Pointer; amount: Double; edge: CGRectEdge); cdecl;
  external libMapKit name _PU + 'MKMapRectDivide';
function MKMapRectContainsPoint(rect: MKMapRect; point: MKMapPoint): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapRectContainsPoint';
function MKMapRectContainsRect(rect1: MKMapRect; rect2: MKMapRect): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapRectContainsRect';
function MKMapRectIntersectsRect(rect1: MKMapRect; rect2: MKMapRect): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapRectIntersectsRect';
function MKCoordinateRegionForMapRect(rect: MKMapRect): MKCoordinateRegion; cdecl;
  external libMapKit name _PU + 'MKCoordinateRegionForMapRect';
function MKMapRectSpans180thMeridian(rect: MKMapRect): Boolean; cdecl;
  external libMapKit name _PU + 'MKMapRectSpans180thMeridian';
function MKMapRectRemainder(rect: MKMapRect): MKMapRect; cdecl; external libMapKit name _PU + 'MKMapRectRemainder';
function MKRoadWidthAtZoomScale(zoomScale: MKZoomScale): CGFloat; cdecl;
  external libMapKit name _PU + 'MKRoadWidthAtZoomScale';

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}

uses
  Posix.Dlfcn;

var
  MapKitModule: THandle;

{$ENDIF IOS}

function MKAnnotationCalloutInfoDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKAnnotationCalloutInfoDidChangeNotification');
end;

function MKLaunchOptionsDirectionsModeKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsDirectionsModeKey');
end;

function MKLaunchOptionsMapTypeKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsMapTypeKey');
end;

function MKLaunchOptionsShowsTrafficKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsShowsTrafficKey');
end;

function MKLaunchOptionsDirectionsModeDriving: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsDirectionsModeDriving');
end;

function MKLaunchOptionsDirectionsModeWalking: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsDirectionsModeWalking');
end;

function MKLaunchOptionsMapCenterKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsMapCenterKey');
end;

function MKLaunchOptionsMapSpanKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsMapSpanKey');
end;

function MKLaunchOptionsCameraKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsCameraKey');
end;

function MKErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKErrorDomain');
end;

{$IF defined(IOS) and NOT defined(CPUARM)}

initialization

MapKitModule := dlopen(MarshaledAString(libMapKit), RTLD_LAZY);

finalization

dlclose(MapKitModule);
{$ENDIF IOS}

end.
