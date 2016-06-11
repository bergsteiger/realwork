{***********************************************************}
{                                                           }
{             CodeGear Delphi Runtime Library               }
{                                                           }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.          }
{              All rights reserved                          }
{                                                           }
{***********************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework MapKit
//

unit Macapi.MapKit;

interface

uses
  Macapi.AppKit,
  Macapi.CocoaTypes,
  Macapi.CoreGraphics,
  Macapi.CoreLocation,
  Macapi.Dispatch,
  Macapi.Foundation,
  Macapi.ObjectiveC;

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
  MKLocalSearchCompletionHandler = procedure(response: MKLocalSearchResponse; error: NSError) of object;
  MKDirectionsTransportType = NSUInteger;
  MKDirectionsHandler = procedure(response: MKDirectionsResponse; error: NSError) of object;
  MKETAHandler = procedure(response: MKETAResponse; error: NSError) of object;
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

  MKAnnotationViewClass = interface(NSViewClass)
    ['{FE61B5DA-06D2-4E71-A2FC-2AFD9AAE05D8}']
  end;

  MKAnnotationView = interface(NSView)
    ['{DA6F4401-06F9-4CD2-8AC7-01F243DB2F8D}']
    function initWithAnnotation(annotation: Pointer; reuseIdentifier: NSString): Pointer; cdecl;
    function reuseIdentifier: NSString; cdecl;
    procedure prepareForReuse; cdecl;
    procedure setAnnotation(annotation: Pointer); cdecl;
    function annotation: Pointer; cdecl;
    procedure setImage(image: NSImage); cdecl;
    function image: NSImage; cdecl;
    procedure setCenterOffset(centerOffset: CGPoint); cdecl;
    function centerOffset: CGPoint; cdecl;
    procedure setCalloutOffset(calloutOffset: CGPoint); cdecl;
    function calloutOffset: CGPoint; cdecl;
    procedure setLeftCalloutOffset(leftCalloutOffset: CGPoint); cdecl;
    function leftCalloutOffset: CGPoint; cdecl;
    procedure setRightCalloutOffset(rightCalloutOffset: CGPoint); cdecl;
    function rightCalloutOffset: CGPoint; cdecl;
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
    procedure setLeftCalloutAccessoryView(leftCalloutAccessoryView: NSView); cdecl;
    function leftCalloutAccessoryView: NSView; cdecl;
    procedure setRightCalloutAccessoryView(rightCalloutAccessoryView: NSView); cdecl;
    function rightCalloutAccessoryView: NSView; cdecl;
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
    ['{05747BAE-F0C7-4F80-9AE9-A805A0F5E54A}']
  end;

  MKDistanceFormatter = interface(NSFormatter)
    ['{134CB9B6-EFA3-48C4-86A9-719D78965930}']
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
    ['{02293A55-332E-4B96-A73F-5E613B62C90B}']
  end;

  MKPlacemark = interface(CLPlacemark)
    ['{66196EB2-084F-4B3C-8309-C1093B965EB8}']
    function initWithCoordinate(coordinate: CLLocationCoordinate2D; addressDictionary: NSDictionary): Pointer; cdecl;
    function countryCode: NSString; cdecl;
  end;

  TMKPlacemark = class(TOCGenericImport<MKPlacemarkClass, MKPlacemark>)
  end;

  MKMapItemClass = interface(NSObjectClass)
    ['{F666C87F-766D-4273-B422-6DB2FB14292B}']
    {class} function mapItemForCurrentLocation: MKMapItem; cdecl;
    {class} function openMapsWithItems(mapItems: NSArray; launchOptions: NSDictionary): Boolean; cdecl;
  end;

  MKMapItem = interface(NSObject)
    ['{A8D3C068-1E77-4925-B059-10AB67F30172}']
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
    ['{691A9E6B-21C5-4F6B-BF9F-988B38233031}']
  end;

  MKOverlayRenderer = interface(NSObject)
    ['{174FCAE8-6395-4095-BD3E-35CD015939E8}']
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

  MKUserLocationClass = interface(NSObjectClass)
    ['{1A57706C-3507-4278-B78A-FB61E36DA813}']
  end;

  MKUserLocation = interface(NSObject)
    ['{B7F16A1E-57A7-4CF6-BA68-7443ACF2F28F}']
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
    ['{A6EC891E-1692-4199-8F68-5225E95DAFDF}']
    {class} function camera: Pointer{instancetype}; cdecl;
    {class} function cameraLookingAtCenterCoordinate(centerCoordinate: CLLocationCoordinate2D;
      fromEyeCoordinate: CLLocationCoordinate2D; eyeAltitude: CLLocationDistance): Pointer{instancetype}; cdecl;
  end;

  MKMapCamera = interface(NSObject)
    ['{6D32541C-8915-47ED-B272-051571F77798}']
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

  MKMapViewClass = interface(NSViewClass)
    ['{A8CCD5A4-0EA6-499F-A8B1-919C85805E74}']
  end;

  MKMapView = interface(NSView)
    ['{157A0245-0B52-4B92-B4C8-F09800ED9D00}']
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
    procedure setVisibleMapRectEdgePaddingAnimated(mapRect: MKMapRect; edgePadding: NSEdgeInsets;
      animated: Boolean); cdecl;
    [MethodName('mapRectThatFits:edgePadding:')]
    function mapRectThatFitsEdgePadding(mapRect: MKMapRect; edgePadding: NSEdgeInsets): MKMapRect; cdecl;
    [MethodName('setCamera:')]
    procedure setCamera(camera: MKMapCamera); cdecl;
    function camera: MKMapCamera; cdecl;
    [MethodName('setCamera:animated:')]
    procedure setCameraAnimated(camera: MKMapCamera; animated: Boolean); cdecl;
    function convertCoordinate(coordinate: CLLocationCoordinate2D; toPointToView: NSView): CGPoint; cdecl;
    function convertPoint(point: CGPoint; toCoordinateFromView: NSView): CLLocationCoordinate2D; cdecl;
    function convertRegion(region: MKCoordinateRegion; toRectToView: NSView): CGRect; cdecl;
    function convertRect(rect: CGRect; toRegionFromView: NSView): MKCoordinateRegion; cdecl;
    procedure setZoomEnabled(zoomEnabled: Boolean); cdecl;
    function isZoomEnabled: Boolean; cdecl;
    procedure setScrollEnabled(scrollEnabled: Boolean); cdecl;
    function isScrollEnabled: Boolean; cdecl;
    procedure setRotateEnabled(rotateEnabled: Boolean); cdecl;
    function isRotateEnabled: Boolean; cdecl;
    procedure setPitchEnabled(pitchEnabled: Boolean); cdecl;
    function isPitchEnabled: Boolean; cdecl;
    procedure setShowsCompass(showsCompass: Boolean); cdecl;
    function showsCompass: Boolean; cdecl;
    procedure setShowsZoomControls(showsZoomControls: Boolean); cdecl;
    function showsZoomControls: Boolean; cdecl;
    procedure setShowsPointsOfInterest(showsPointsOfInterest: Boolean); cdecl;
    function showsPointsOfInterest: Boolean; cdecl;
    procedure setShowsBuildings(showsBuildings: Boolean); cdecl;
    function showsBuildings: Boolean; cdecl;
    procedure setShowsUserLocation(showsUserLocation: Boolean); cdecl;
    function showsUserLocation: Boolean; cdecl;
    function userLocation: MKUserLocation; cdecl;
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
    ['{12353B2E-74BC-44E9-BECC-DC4AEF003CA0}']
  end;

  MKPinAnnotationView = interface(MKAnnotationView)
    ['{C0C4AF75-DCB7-4443-9882-512A311FA7E7}']
    procedure setPinColor(pinColor: MKPinAnnotationColor); cdecl;
    function pinColor: MKPinAnnotationColor; cdecl;
    procedure setAnimatesDrop(animatesDrop: Boolean); cdecl;
    function animatesDrop: Boolean; cdecl;
  end;

  TMKPinAnnotationView = class(TOCGenericImport<MKPinAnnotationViewClass, MKPinAnnotationView>)
  end;

  MKShapeClass = interface(NSObjectClass)
    ['{32307567-4624-49D1-AD15-C1260EC5B6A4}']
  end;

  MKShape = interface(NSObject)
    ['{296F3F94-AC8C-403D-A665-4D48DAD191BC}']
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
    procedure setSubtitle(subtitle: NSString); cdecl;
    function subtitle: NSString; cdecl;
  end;

  TMKShape = class(TOCGenericImport<MKShapeClass, MKShape>)
  end;

  MKPointAnnotationClass = interface(MKShapeClass)
    ['{B10563C4-1958-4DEC-8CFD-27BC8C63473D}']
  end;

  MKPointAnnotation = interface(MKShape)
    ['{B90D650E-EA63-4094-B414-CFDB5A8561B1}']
    procedure setCoordinate(coordinate: CLLocationCoordinate2D); cdecl;
    function coordinate: CLLocationCoordinate2D; cdecl;
  end;

  TMKPointAnnotation = class(TOCGenericImport<MKPointAnnotationClass, MKPointAnnotation>)
  end;

  MKMultiPointClass = interface(MKShapeClass)
    ['{28750BD4-8FEA-4503-A33E-4291DBEEE464}']
  end;

  MKMultiPoint = interface(MKShape)
    ['{9BA3EC17-9D03-469F-B805-7C5B9C4155F3}']
    function points: Pointer; cdecl;
    function pointCount: NSUInteger; cdecl;
    procedure getCoordinates(coords: Pointer; range: NSRange); cdecl;
  end;

  TMKMultiPoint = class(TOCGenericImport<MKMultiPointClass, MKMultiPoint>)
  end;

  MKPolylineClass = interface(MKMultiPointClass)
    ['{2D102B0D-B960-46B1-B329-631349370EB7}']
    {class} function polylineWithPoints(points: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
    {class} function polylineWithCoordinates(coords: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
  end;

  MKPolyline = interface(MKMultiPoint)
    ['{827CE5A8-C31C-40E7-9C1A-B6C91F685278}']
  end;

  TMKPolyline = class(TOCGenericImport<MKPolylineClass, MKPolyline>)
  end;

  MKPolygonClass = interface(MKMultiPointClass)
    ['{34D2A2E6-92D7-4F21-BDF9-10527DE79467}']
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
    ['{EF5386D0-4C7C-45E7-9E6F-7F907258E485}']
    function interiorPolygons: NSArray; cdecl;
  end;

  TMKPolygon = class(TOCGenericImport<MKPolygonClass, MKPolygon>)
  end;

  MKCircleClass = interface(MKShapeClass)
    ['{0C177114-4CEA-41DB-B577-2F03C75E4565}']
    {class} function circleWithCenterCoordinate(coord: CLLocationCoordinate2D; radius: CLLocationDistance)
      : MKCircle; cdecl;
    {class} function circleWithMapRect(mapRect: MKMapRect): MKCircle; cdecl;
  end;

  MKCircle = interface(MKShape)
    ['{5E70C130-F14B-45C8-9BCE-D49D8E334C22}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function radius: CLLocationDistance; cdecl;
    function boundingMapRect: MKMapRect; cdecl;
  end;

  TMKCircle = class(TOCGenericImport<MKCircleClass, MKCircle>)
  end;

  MKGeodesicPolylineClass = interface(MKPolylineClass)
    ['{E01F2090-505D-46FE-8D8B-4016783D1A5A}']
    {class} function polylineWithPoints(points: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
    {class} function polylineWithCoordinates(coords: Pointer; count: NSUInteger): Pointer{instancetype}; cdecl;
  end;

  MKGeodesicPolyline = interface(MKPolyline)
    ['{AAF38E66-2FBB-428A-A9CA-7D4171A9EB96}']
  end;

  TMKGeodesicPolyline = class(TOCGenericImport<MKGeodesicPolylineClass, MKGeodesicPolyline>)
  end;

  MKOverlayPathRendererClass = interface(MKOverlayRendererClass)
    ['{58774C66-CD13-4396-AD21-6ECBFEF6B842}']
  end;

  MKOverlayPathRenderer = interface(MKOverlayRenderer)
    ['{42D9BB3E-D314-42EE-BDDD-1DC8F7977A27}']
    procedure setFillColor(fillColor: NSColor); cdecl;
    function fillColor: NSColor; cdecl;
    procedure setStrokeColor(strokeColor: NSColor); cdecl;
    function strokeColor: NSColor; cdecl;
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
    ['{159C5AD0-A78B-45CA-BED0-9360213781DC}']
  end;

  MKPolygonRenderer = interface(MKOverlayPathRenderer)
    ['{B9B4C706-D660-4B09-9BB8-622E106D54FA}']
    function initWithPolygon(polygon: MKPolygon): Pointer; cdecl;
    function polygon: MKPolygon; cdecl;
  end;

  TMKPolygonRenderer = class(TOCGenericImport<MKPolygonRendererClass, MKPolygonRenderer>)
  end;

  MKPolylineRendererClass = interface(MKOverlayPathRendererClass)
    ['{DB22C66C-5BDD-4908-BA7D-F20DB43D1F05}']
  end;

  MKPolylineRenderer = interface(MKOverlayPathRenderer)
    ['{AADD3CA5-12B4-412A-95B0-4475851C1EE4}']
    function initWithPolyline(polyline: MKPolyline): Pointer; cdecl;
    function polyline: MKPolyline; cdecl;
  end;

  TMKPolylineRenderer = class(TOCGenericImport<MKPolylineRendererClass, MKPolylineRenderer>)
  end;

  MKCircleRendererClass = interface(MKOverlayPathRendererClass)
    ['{3A390FFD-7583-4C14-B421-26A16E6079D1}']
  end;

  MKCircleRenderer = interface(MKOverlayPathRenderer)
    ['{72587647-F2BF-4804-97F2-6B830EA3C9A1}']
    function initWithCircle(circle: MKCircle): Pointer; cdecl;
    function circle: MKCircle; cdecl;
  end;

  TMKCircleRenderer = class(TOCGenericImport<MKCircleRendererClass, MKCircleRenderer>)
  end;

  MKLocalSearchRequestClass = interface(NSObjectClass)
    ['{3A3CCC41-BF3C-42BF-9014-41CDDDC7C26A}']
  end;

  MKLocalSearchRequest = interface(NSObject)
    ['{216BB4FD-8CC4-4B5A-8BAF-EA972AD3E663}']
    procedure setNaturalLanguageQuery(naturalLanguageQuery: NSString); cdecl;
    function naturalLanguageQuery: NSString; cdecl;
    procedure setRegion(region: MKCoordinateRegion); cdecl;
    function region: MKCoordinateRegion; cdecl;
  end;

  TMKLocalSearchRequest = class(TOCGenericImport<MKLocalSearchRequestClass, MKLocalSearchRequest>)
  end;

  MKLocalSearchResponseClass = interface(NSObjectClass)
    ['{F029A816-424E-46E0-A3BE-BCBD6C221619}']
  end;

  MKLocalSearchResponse = interface(NSObject)
    ['{6DD176E4-7A2D-4528-96BC-5871F19D2678}']
    function mapItems: NSArray; cdecl;
    function boundingRegion: MKCoordinateRegion; cdecl;
  end;

  TMKLocalSearchResponse = class(TOCGenericImport<MKLocalSearchResponseClass, MKLocalSearchResponse>)
  end;

  MKLocalSearchClass = interface(NSObjectClass)
    ['{D404F955-3F3F-4745-A502-A97CAD64B323}']
  end;

  MKLocalSearch = interface(NSObject)
    ['{89DFCB55-8E45-40D6-9F84-A8E345BE2517}']
    function initWithRequest(request: MKLocalSearchRequest): Pointer; cdecl;
    procedure startWithCompletionHandler(completionHandler: MKLocalSearchCompletionHandler); cdecl;
    procedure cancel; cdecl;
    function isSearching: Boolean; cdecl;
  end;

  TMKLocalSearch = class(TOCGenericImport<MKLocalSearchClass, MKLocalSearch>)
  end;

  MKDirectionsRequestClass = interface(NSObjectClass)
    ['{E45E9DA6-3DB4-47F7-90FE-32E05E9ECF42}']
    {class} function isDirectionsRequestURL(url: NSURL): Boolean; cdecl;
  end;

  MKDirectionsRequest = interface(NSObject)
    ['{557AD897-F1BC-4906-A545-718CC2F2C532}']
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
    ['{152B23E5-B9B9-4794-BC8D-599049AB75BA}']
  end;

  MKDirectionsResponse = interface(NSObject)
    ['{E74C17CD-5A29-45E9-8B6A-013837C6AB8F}']
    function source: MKMapItem; cdecl;
    function destination: MKMapItem; cdecl;
    function routes: NSArray; cdecl;
  end;

  TMKDirectionsResponse = class(TOCGenericImport<MKDirectionsResponseClass, MKDirectionsResponse>)
  end;

  MKETAResponseClass = interface(NSObjectClass)
    ['{F3D8037E-CAE7-42B4-A1FD-CB30233FC0D6}']
  end;

  MKETAResponse = interface(NSObject)
    ['{480E0F96-B059-462A-A395-888EEED84FAE}']
    function source: MKMapItem; cdecl;
    function destination: MKMapItem; cdecl;
    function expectedTravelTime: NSTimeInterval; cdecl;
  end;

  TMKETAResponse = class(TOCGenericImport<MKETAResponseClass, MKETAResponse>)
  end;

  MKDirectionsClass = interface(NSObjectClass)
    ['{33AB49D8-04FD-4530-9154-0AD42EB6B889}']
  end;

  MKDirections = interface(NSObject)
    ['{7EF58C18-4361-4D86-B9DF-5BE9AF9E20B7}']
    function initWithRequest(request: MKDirectionsRequest): Pointer{instancetype}; cdecl;
    procedure calculateDirectionsWithCompletionHandler(completionHandler: MKDirectionsHandler); cdecl;
    procedure calculateETAWithCompletionHandler(completionHandler: MKETAHandler); cdecl;
    procedure cancel; cdecl;
    function isCalculating: Boolean; cdecl;
  end;

  TMKDirections = class(TOCGenericImport<MKDirectionsClass, MKDirections>)
  end;

  MKRouteClass = interface(NSObjectClass)
    ['{814E3F0F-791F-45C6-8477-8F1F9CF29870}']
  end;

  MKRoute = interface(NSObject)
    ['{A17EB9C5-4BA5-4A79-A84C-9553A9F5AF64}']
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
    ['{80C3CC3D-145E-4D23-9C0C-416A80EF3C09}']
  end;

  MKRouteStep = interface(NSObject)
    ['{00A2E3A6-E173-4BE7-99EB-C0E39FB2DF90}']
    function instructions: NSString; cdecl;
    function notice: NSString; cdecl;
    function polyline: MKPolyline; cdecl;
    function distance: CLLocationDistance; cdecl;
    function transportType: MKDirectionsTransportType; cdecl;
  end;

  TMKRouteStep = class(TOCGenericImport<MKRouteStepClass, MKRouteStep>)
  end;

  MKMapSnapshotOptionsClass = interface(NSObjectClass)
    ['{1CDE6446-E900-4F21-9313-CAB8D7453FB5}']
  end;

  MKMapSnapshotOptions = interface(NSObject)
    ['{085DB608-442B-4214-B3C0-1EC5F2BA5040}']
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
    procedure setSize(size: NSSize); cdecl;
    function size: NSSize; cdecl;
  end;

  TMKMapSnapshotOptions = class(TOCGenericImport<MKMapSnapshotOptionsClass, MKMapSnapshotOptions>)
  end;

  MKMapSnapshotClass = interface(NSObjectClass)
    ['{3C72D752-C8A4-4792-A28B-2ABA23C11C59}']
  end;

  MKMapSnapshot = interface(NSObject)
    ['{C574A696-AE55-4A74-B7D9-1387A7BC1468}']
    function image: NSImage; cdecl;
    function pointForCoordinate(coordinate: CLLocationCoordinate2D): NSPoint; cdecl;
  end;

  TMKMapSnapshot = class(TOCGenericImport<MKMapSnapshotClass, MKMapSnapshot>)
  end;

  MKMapSnapshotterClass = interface(NSObjectClass)
    ['{29A0A8FE-4509-4F8C-AEE0-0F654D17936F}']
  end;

  MKMapSnapshotter = interface(NSObject)
    ['{D97C610D-E008-41D0-A714-CD7457BBCB69}']
    function initWithOptions(options: MKMapSnapshotOptions): Pointer{instancetype}; cdecl;
    procedure startWithCompletionHandler(completionHandler: MKMapSnapshotCompletionHandler); cdecl;
    procedure startWithQueue(queue: dispatch_queue_t; completionHandler: MKMapSnapshotCompletionHandler); cdecl;
    procedure cancel; cdecl;
    function isLoading: Boolean; cdecl;
  end;

  TMKMapSnapshotter = class(TOCGenericImport<MKMapSnapshotterClass, MKMapSnapshotter>)
  end;

  MKTileOverlayClass = interface(NSObjectClass)
    ['{B5837155-D81E-40C8-99EF-532C4C5BB1C5}']
  end;

  MKTileOverlay = interface(NSObject)
    ['{AB332870-FD4D-4037-AD93-27BC90DA354E}']
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
    ['{663198F1-3AE7-432A-B3C8-83919D51F8CB}']
  end;

  MKTileOverlayRenderer = interface(MKOverlayRenderer)
    ['{770BA957-D9EE-4837-B5D5-89B121B75E02}']
    function initWithTileOverlay(overlay: MKTileOverlay): Pointer; cdecl;
    procedure reloadData; cdecl;
  end;

  TMKTileOverlayRenderer = class(TOCGenericImport<MKTileOverlayRendererClass, MKTileOverlayRenderer>)
  end;

  // ===== Protocol declarations =====

  MKAnnotation = interface(IObjectiveC)
    ['{FC399CD6-714C-4F05-A582-111F1D23FD6C}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function title: NSString; cdecl;
    function subtitle: NSString; cdecl;
    procedure setCoordinate(newCoordinate: CLLocationCoordinate2D); cdecl;
  end;

  MKOverlay = interface(IObjectiveC)
    ['{733E2A35-59AF-4CD5-BDC3-9F7921AB3238}']
    function coordinate: CLLocationCoordinate2D; cdecl;
    function boundingMapRect: MKMapRect; cdecl;
    function intersectsMapRect(mapRect: MKMapRect): Boolean; cdecl;
    function canReplaceMapContent: Boolean; cdecl;
  end;

  MKMapViewDelegate = interface(IObjectiveC)
    ['{855F2A1B-0B44-4358-95A0-EAA4B8652F52}']
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
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; rendererForOverlay: Pointer): MKOverlayRenderer; cdecl;
    [MethodName('mapView:didAddOverlayRenderers:')]
    procedure mapViewDidAddOverlayRenderers(mapView: MKMapView; didAddOverlayRenderers: NSArray); cdecl;
  end;

  // ===== Exported string consts =====

function MKAnnotationCalloutInfoDidChangeNotification: NSString;
function MKLaunchOptionsDirectionsModeKey: NSString;
function MKLaunchOptionsMapTypeKey: NSString;
function MKLaunchOptionsMapCenterKey: NSString;
function MKLaunchOptionsMapSpanKey: NSString;
function MKLaunchOptionsShowsTrafficKey: NSString;
function MKLaunchOptionsDirectionsModeDriving: NSString;
function MKLaunchOptionsDirectionsModeWalking: NSString;
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

function MKLaunchOptionsMapCenterKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsMapCenterKey');
end;

function MKLaunchOptionsMapSpanKey: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKLaunchOptionsMapSpanKey');
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

function MKErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libMapKit, 'MKErrorDomain');
end;

end.
