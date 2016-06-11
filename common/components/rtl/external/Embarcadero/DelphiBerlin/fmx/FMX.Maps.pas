{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Maps;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, FMX.Types, FMX.Controls, FMX.Platform, FMX.Graphics;

type
  /// <summary>Tolerances for the map view used in equality
  /// comparisons.</summary>
  TMapEpsilon = record
  const
    /// <summary>Bearing tolerance</summary>
    Bearing = 0.001;
    /// <summary>Map tilt tolerance</summary>
    Tilt = 0.01;
    /// <summary>Map zoom tolerance</summary>
    Zoom = 0.1;
    /// <summary>Map rotation tolerance</summary>
    Rotate = 1;
  end;
  /// <summary>The type of the map.</summary>
  TMapType = (None = 0, Normal = 1, Satellite = 2, Hybrid = 3, Terrain = 4);

  /// <summary>Gestures that the map view handles.</summary>
  TMapGestureOption = (Zoom, Tilt, Scroll, Rotate);

  /// <summary>A set of TMapGestureOption.</summary>
  TMapGestureOptions = set of TMapGestureOption;

  /// <summary>Controls and gauges on the map overlay.</summary>
  TMapControlOption = (Zoom, Compass, MyLocation);

  /// <summary>A set of TMapControlOption.</summary>
  TMapControlOptions = set of TMapControlOption;

  /// <summary>Extra map layers.</summary>
  TMapLayerOption = (PointsOfInterest, Buildings, UserLocation, Traffic);

  /// <summary>A set of TMapLayerOption.</summary>
  TMapLayerOptions = set of TMapLayerOption;

  /// <summary>Map options.</summary>
  TMapOptionSet = (Gesture, Control, Layer);

  /// <summary>A set of TMapOptionSet.</summary>
  TMapOptionSets = set of TMapOptionSet;

  TCustomMapView = class;

  /// <summary>The appearance of the map marker.</summary>
  TMarkerAppearance = (Flat, Billboard);

  /// <summary>Record used to store information about a world map
  /// coordinate.</summary>
  TMapCoordinate = record
    /// <summary>Latitude in decimal degrees</summary>
    Latitude: Double;
    /// <summary>Longitude in decimal degrees</summary>
    Longitude: Double;

    /// <summary>Initialize a new TMapCoordinate with given Latitude and Longitude</summary>
    class function Create(const Latitude: Double; const Longitude: Double): TMapCoordinate; overload; static; inline;
    /// <summary>Initialize a new TMapCoordinate based on existing TPointF</summary>
    class function Create(const Point: TPointF): TMapCoordinate; overload; static; inline;
    /// <summary>Initialize a TMapCoordinate with Lat/Lng = 0, 0</summary>
    class function Zero: TMapCoordinate; static; inline;
    /// <summary>Return a readable representation of TMapCoordinate</summary>
    function ToString: string;
  end;

  /// <summary>Options that define a map marker.</summary>
  TMapMarkerDescriptor = record
    /// <summary>Marker Latitude/Longitude</summary>
    Position: TMapCoordinate;
    /// <summary>Marker graphics opacity. 1.0 = fully opaque.</summary>
    Opacity: Single;
    /// <summary>Graphics origin point in [0..1, 0..1]. Default is [0.5, 1]</summary>
    Origin: TPointF;
    /// <summary>Title text</summary>
    Title: string;
    /// <summary>Snippet text</summary>
    Snippet: string;
    /// <summary>Marker graphics. If Icon is not specified, default marker graphics are going to be used</summary>
    Icon: TBitmap;
    /// <summary>Marker can be dragged by user</summary>
    Draggable: Boolean;
    /// <summary>Marker is visible</summary>
    Visible: Boolean;
    /// <summary>Marker appearance: Flat or Billboard</summary>
    Appearance: TMarkerAppearance;
    /// <summary>Marker rotation in degrees clockwise about the Origin</summary>
    Rotation: Single;

    /// <summary>Initialize marker descriptor at given coordinate with a title</summary>
    class function Create(const Position: TMapCoordinate; const Title: string = 'Marker Title'): TMapMarkerDescriptor; static;
  end;


  /// <summary>Options that define a map circle.</summary>
  TMapCircleDescriptor = record
    /// <summary>Latitude/Longitude of circle center</summary>
    Center: TMapCoordinate;
    /// <summary>Fill color with alpha</summary>
    FillColor: TAlphaColor;
    /// <summary>Circle radius in metres</summary>
    Radius: Single;
    /// <summary>Stroke width in pixels, default = 10</summary>
    StrokeWidth: Single;
    /// <summary>Stroke color, default = TAlphaColorRec.Black</summary>
    StrokeColor: TAlphaColor;
    /// <summary>Z-order relative to other map objects, default = 0.0</summary>
    ZIndex: Single;
    /// <summary>Initialize circle descriptor with center Lat/Lng at Center, radius in meters</summary>
    class function Create(const Center: TMapCoordinate; const RadiusInMeters: Single): TMapCircleDescriptor; static;
  end;

  /// <summary>Array of vertices defining an outline.</summary>
  TMapPolygonPolyvertex = record
    /// <summary>Array of map points</summary>
    Points: TArray<TMapCoordinate>;
  end;

  /// <summary>Record that defines a map polygon.</summary>
  TMapPolygonDescriptor = record
    ///<summary>Array of Latitude/Longitude coordinates of polygon vertices</summary>
    Outline: TMapPolygonPolyvertex;
    ///<summary>Array of hole outlines</summary>
    Holes: TArray<TMapPolygonPolyvertex>;
    ///<summary>True if this is a geodesic object</summary>
    Geodesic: Boolean;
    ///<summary>Fill color with alpha</summary>
    FillColor: TAlphaColor;
    ///<summary>Stroke color with alpha</summary>
    StrokeColor: TAlphaColor;
    /// <summary>Stroke width in pixels, default = 10</summary>
    StrokeWidth: Single;
    /// <summary>Z-order relative to other map objects, default = 0.0</summary>
    ZIndex: Single;
    /// <summary>Initialize polygon descriptor with given outline</summary>
    class function Create(const Outline: TArray<TMapCoordinate>): TMapPolygonDescriptor; static;
    /// <summary>Add a hole to descriptor</summary>
    procedure AddHole(const Points: TArray<TMapCoordinate>);
  end;

  /// <summary>Record that defines a polyline.</summary>
  TMapPolylineDescriptor = record
    ///<summary>Array of Latitude/Longitude coordinates of polyline vertices</summary>
    Points: TMapPolygonPolyvertex;
    ///<summary>True if this is a geodesic object</summary>
    Geodesic: Boolean;
    ///<summary>Stroke color with alpha</summary>
    StrokeColor: TAlphaColor;
    /// <summary>Stroke width in pixels, default = 10</summary>
    StrokeWidth: Single;
    /// <summary>Z-order relative to other map objects, default = 0.0</summary>
    ZIndex: Single;
    /// <summary>Initialize polyline descriptor with given outline</summary>
    class function Create(const Points: TArray<TMapCoordinate>): TMapPolylineDescriptor; static;
  end;

  /// <summary>Base class for map objects.</summary>
  TMapObjectBase = class abstract
    /// <summary>Remove this map object from map</summary>
    procedure Remove; virtual; abstract;
    /// <summary>Set this object visibility</summary>
    procedure SetVisible(const Value: Boolean); virtual; abstract;
  end;

  /// <summary>Base class for descriptor-based map objects.</summary>
  TMapObject<D> = class abstract(TMapObjectBase)
  private
    FDescriptor: D;
  protected
    /// <summary>TMapObject constructor</summary>
    constructor Create(const Descriptor: D); virtual;
  public
    /// <summary>Descriptor</summary>
    property Descriptor: D read FDescriptor;
  end;

  /// <summary>Map marker.</summary>
  TMapMarker = class(TMapObject<TMapMarkerDescriptor>)
  end;

  /// <summary>Map circle.</summary>
  TMapCircle = class(TMapObject<TMapCircleDescriptor>)
  end;

  /// <summary>Map polygon.</summary>
  TMapPolygon = class(TMapObject<TMapPolygonDescriptor>)
  end;

  /// <summary>Map polyline.</summary>
  TMapPolyline = class(TMapObject<TMapPolylineDescriptor>)
  end;

  /// <summary>Marker event handler: Click, Drag Start, Drag, Drag End</summary>
  TMarkerEvent = procedure(Marker: TMapMarker) of object;

  /// <summary>Map click event handler</summary>
  TMapClickEvent = procedure(const Position: TMapCoordinate) of object;

  TMapScreenshotRecipient = procedure(const Bitmap: TBitmap) of object;

  /// <summary>Interface that represents the underlying map view, such as a map
  /// view drawn using Google Maps or a map view drawn using MapKit.</summary>
  ICustomMapView = interface
    ['{FC5B1D02-AF69-400B-A734-03E6100FC0B9}']
    /// <summary>Set host FireMonkey control</summary>
    procedure SetHostControl(const Host: TCustomMapView);
    /// <summary>Set map view bounds to match those of FireMonkey host control</summary>
    procedure UpdateContentFromControl;
    /// <summary>Show map view</summary>
    procedure Show;
    /// <summary>Hide map view</summary>
    procedure Hide;
    /// <summary>Animate map view to set camera position</summary>
    procedure AnimateToCameraPosition;
    /// <summary>Obtain current camera position from map</summary>
    procedure SyncCameraPosition;
    /// <summary>Move camera to given location</summary>
    procedure SetLocation(const ACoordinate: TMapCoordinate);
    /// <summary>Get current camera location, set by SetLocation or after SyncCameraPosition</summary>
    function GetLocation: TMapCoordinate;
    /// <summary>Set map zoom</summary>
    procedure SetZoom(const Zoom: Single);
    /// <summary>Get map zoom</summary>
    function GetZoom: Single;
    /// <summary>Set bearing in degrees clockwise (0 = North)</summary>
    procedure SetBearing(const Bearing: Single);
    /// <summary>Get bearing in degrees clockwise (0 = North)</summary>
    function GetBearing: Single;
    /// <summary>Set map tilt</summary>
    procedure SetTilt(const Tilt: Single);
    /// <summary>Get map tilt</summary>
    function GetTilt: Single;
    /// <summary>Set map type to one of None, Normal, Satellite, Hybrid, Terrain</summary>
    procedure SetMapType(const AValue: TMapType);
    /// <summary>Notify the view that options included in OptionSets were changed by user</summary>
    procedure OptionsChanged(const OptionSets: TMapOptionSets);
    /// <summary>Add marker specified by Descriptor and return new TMapMarker object</summary>
    function AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
    /// <summary>Add circle specified by Descriptor and return new TMapCircle object</summary>
    function AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
    /// <summary>Add polygon specified by Descriptor and return new TMapPolygon object</summary>
    function AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
    /// <summary>Add polyline specified by Descriptor and return new TMapPolyline object</summary>
    function AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
    /// <summary>Capture map screenshot and return TBitmap</summary>
    function CaptureBitmap: TBitmap;
    /// <summary>Initiate capture of screenshot</summary>
    ///  <remarks>The main thread must be able to process events in order for screenshot to finish successully
    ///  </remarks>
    procedure Snapshot(const Recipient: TMapScreenshotRecipient);
  end;

  /// <summary>Platform service that manages multiple map views.</summary>
  IFMXMapService = interface
    ['{8A1577FF-1C26-40F0-8358-390711E315EA}']
    /// <summary>Create a new map view</summary>
    function CreateMapView: ICustomMapView;
    /// <summary>Destroy previously created map view</summary>
    procedure DestroyMapView(const MapView: ICustomMapView);
    /// <summary>Position map views in accordance with host controls</summary>
    procedure RealignMapViews;
  end;

  /// <summary>Map view control</summary>
  TCustomMapView = class(TControl)
  public const
    /// <summary>Gestures enabled by default</summary>
    DefaultGestureOptions: TMapGestureOptions = [TMapGestureOption.Zoom, TMapGestureOption.Tilt, TMapGestureOption.Scroll,
      TMapGestureOption.Rotate];
    /// <summary>Overlay controls enabled by default</summary>
    DefaultControlOptions: TMapControlOptions = [TMapControlOption.Zoom, TMapControlOption.Compass,
      TMapControlOption.MyLocation];
    /// <summary>Extra layers enabled by default</summary>
    DefaultLayerOptions: TMapLayerOptions = [];
  private
    FMapView: ICustomMapView;
    FSavedVisible: Boolean;
    FMapType: TMapType;
    FGestureOptions: TMapGestureOptions;
    FControlOptions: TMapControlOptions;
    FLayerOptions: TMapLayerOptions;
    FOnCameraChanged: TNotifyEvent;
    FOnMarkerClick: TMarkerEvent;
    FOnMarkerDoubleClick: TMarkerEvent;
    FOnMarkerDragStart: TMarkerEvent;
    FOnMarkerDrag: TMarkerEvent;
    FOnMarkerDragEnd: TMarkerEvent;
    FOnMapClick: TMapClickEvent;
    FOnMapDoubleClick: TMapClickEvent;
    FOnMapLongClick: TMapClickEvent;
    procedure AdjustToControl;
  protected
    /// <summary>Set camera location</summary>
    procedure SetLocation(const ACoordinate: TMapCoordinate);
    /// <summary>Get camera location</summary>
    function GetLocation: TMapCoordinate;
    /// <summary>Set camera zoom</summary>
    procedure SetZoom(const Value: Single);
    /// <summary>Get camera zoom</summary>
    function GetZoom: Single;
    /// <summary>Set view tilt</summary>
    procedure SetTilt(const Degrees: Single);
    /// <summary>Get view tilt</summary>
    function GetTilt: Single;
    /// <summary>Set view bearing in degrees clockwise relative to North</summary>
    procedure SetBearing(const Bearing: Single);
    /// <summary>Get view bearing in degrees clockwise relative to North</summary>
    function GetBearing: Single;
    /// <summary>Set map type to one of None, Normal, Satellite, Hybrid, Terrain</summary>
    procedure SetMapType(const AValue: TMapType);
    /// <summary>Get map type</summary>
    function GetMapType: TMapType;
    /// <summary>Enable gestures specified by Options</summary>
    procedure SetGestureOptions(const Options: TMapGestureOptions);
    /// <summary>Get enabled gestures</summary>
    function GetGestureOptions: TMapGestureOptions;
    /// <summary>True if gesture options differ from defaults</summary>
    function GestureOptionsStored: Boolean;
    /// <summary>Enable overlay controls specified by Options</summary>
    procedure SetControlOptions(const Options: TMapControlOptions);
    /// <summary>Get status of enabled overlay controls</summary>
    function GetControlOptions: TMapControlOptions;
    /// <summary>True if control options differ from defaults</summary>
    function ControlOptionsStored: Boolean;
    /// <summary>Enable map layers specified by Options</summary>
    procedure SetLayerOptions(const Options: TMapLayerOptions);
    /// <summary>Get status of enabled layers</summary>
    function GetLayerOptions: TMapLayerOptions;
    /// <summary>True if options differ from defaults</summary>
    function LayerOptionsStored: Boolean;
  protected
    /// <summary>Update map view when control changes</summary>
    procedure DoAbsoluteChanged; override;
    /// <summary>Update map view when parent changes</summary>
    procedure ParentChanged; override;
    /// <summary>Paint the control. Used in design time and for taking screenshots.</summary>
    procedure Paint; override;
    procedure ChangeOrder; override;
    procedure AncestorVisibleChanged(const Visible: Boolean); override;
  public
    /// <summary>Create TMapView control</summary>
    constructor Create(Owner: TComponent); override;
    /// <summary>Destroy this TMapView</summary>
    destructor Destroy; override;
    /// <summary>Called when position changes</summary>
    procedure Move; override;
    /// <summary>Called when the control is being shown</summary>
    procedure Show; override;
    /// <summary>Called when the control is being hidden</summary>
    procedure Hide; override;
    /// <summary>Called after the size of the control had been changed</summary>
    procedure Resize; override;
    /// <summary>Make screenshot with bitmap recipient Recipient</summary>
    procedure Snapshot(const Recipient: TMapScreenshotRecipient);
    /// <summary>Add map marker defined by Descriptor and return a new TMapMarker object</summary>
    function AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
    /// <summary>Add map circle defined by Descriptor and return a new TMapCircle object</summary>
    function AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
    /// <summary>Add map polygon defined by Descriptor and return a new TMapPolygon object</summary>
    function AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
    /// <summary>Add map polyline defined by Descriptor and return a new TMapPolyline object</summary>
    function AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
    /// <summary>Camera location Latitude/Longitude</summary>
    property Location: TMapCoordinate read GetLocation write SetLocation;
    /// <summary>Camera zoom</summary>
    property Zoom: Single read GetZoom write SetZoom;
    /// <summary>Camera tilt</summary>
    property Tilt: Single read GetTilt write SetTilt;
    /// <summary>Camera bearing in degrees clockwise relative to North</summary>
    property Bearing: Single read GetBearing write SetBearing;
    /// <summary>Map type: None, Normal, Satellite, Terrain, Hybrid</summary>
    property MapType: TMapType read GetMapType write SetMapType default TMapType.Normal;
    /// <summary>Gesture options: Zoom, Pan, Tilt, Rotate</summary>
    property GestureOptions: TMapGestureOptions read GetGestureOptions write SetGestureOptions stored GestureOptionsStored nodefault;
    /// <summary>Overlay control options: Zoom, Compass, MyLocation</summary>
    property ControlOptions: TMapControlOptions read GetControlOptions write SetControlOptions stored ControlOptionsStored nodefault;
    /// <summary>Layer options: PointsOfInterest, Buildings, UserLocation, Traffic</summary>
    property LayerOptions: TMapLayerOptions read GetLayerOptions write SetLayerOptions stored LayerOptionsStored nodefault;
    /// <summary>Handle change in camera parameteres</summary>
    procedure DoCameraChanged;
    /// <summary>Handle marker click</summary>
    procedure DoMarkerClick(const Marker: TMapMarker);
    /// <summary>Handle marker click</summary>
    procedure DoMarkerDoubleClick(const Marker: TMapMarker);
    /// <summary>Handle marker drag start</summary>
    procedure DoMarkerDragStart(const Marker: TMapMarker);
    /// <summary>Handle marker drag</summary>
    procedure DoMarkerDrag(const Marker: TMapMarker);
    /// <summary>Handle marker drag end</summary>
    procedure DoMarkerDragEnd(const Marker: TMapMarker);
    /// <summary>Handle map click</summary>
    procedure DoMapClick(const Coordinate: TMapCoordinate);
    /// <summary>Handle map click</summary>
    procedure DoMapDoubleClick(const Coordinate: TMapCoordinate);
    /// <summary>Handle map long click</summary>
    procedure DoMapLongClick(const Coordinate: TMapCoordinate);
    /// <summary>Occurs when camera parameters are changed programmatically or
    /// by user interaction</summary>
    property OnCameraChanged: TNotifyEvent read FOnCameraChanged write FOnCameraChanged;
    /// <summary>Occurs when a marker is clicked</summary>
    property OnMarkerClick: TMarkerEvent read FOnMarkerClick write FOnMarkerClick;
    /// <summary>Occurs when a marker is double clicked</summary>
    property OnMarkerDoubleClick: TMarkerEvent read FOnMarkerDoubleClick write FOnMarkerDoubleClick;
    /// <summary>Occurs when a marker starts being dragged (after long-clicking a draggable marker)</summary>
    property OnMarkerDragStart: TMarkerEvent read FOnMarkerDragStart write FOnMarkerDragStart;
    /// <summary>Occurs when marker changes position while being dragged</summary>
    property OnMarkerDrag: TMarkerEvent read FOnMarkerDrag write FOnMarkerDrag;
    /// <summary>Occurs when a marker that has been dragged is released</summary>
    property OnMarkerDragEnd: TMarkerEvent read FOnMarkerDragEnd write FOnMarkerDragEnd;
    /// <summary>Occurs when map is clicked</summary>
    property OnMapClick: TMapClickEvent read FOnMapClick write FOnMapClick;
    /// <summary>Occurs when map is clicked</summary>
    property OnMapDoubleClick: TMapClickEvent read FOnMapDoubleClick write FOnMapDoubleClick;
    /// <summary>Occurs when map is long clicked</summary>
    property OnMapLongClick: TMapClickEvent read FOnMapLongClick write FOnMapLongClick;
  end;

  /// <summary>Map View component class.</summary>
  TMapView = class(TCustomMapView)
  published
    property Anchors;
    property Align;
    property Visible;
    property Position;
    property Margins;
    property Size;
    property Width;
    property Height;

    property Location;
    property Zoom;
    property Tilt;
    property Bearing;

    property MapType;
    property GestureOptions;
    property ControlOptions;
    property LayerOptions;

    property OnCameraChanged;
    property OnMarkerClick;
    property OnMarkerDoubleClick;
    property OnMarkerDragStart;
    property OnMarkerDrag;
    property OnMarkerDragEnd;
    property OnMapClick;
    property OnMapDoubleClick;
    property OnMapLongClick;
  end;

  /// <summary>Base class for classes that implement the ICustomMapView
  /// interface.</summary>
  TMapViewBase = class(TInterfacedObject)
  public
    /// <summary>Destructor</summary>
    destructor Destroy; override;
    /// <summary>Notify that options have been changed view needs to be updated</summary>
    procedure OptionsChanged(const OptionSets: TMapOptionSets); virtual;
    /// <summary>Add marker</summary>
    function AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker; virtual;
    /// <summary>Add circle</summary>
    function AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle; virtual;
    /// <summary>Add circle</summary>
    function AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon; virtual;
    /// <summary>Add circle</summary>
    function AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline; virtual;
    /// <summary>Make a screenshot</summary>
    function CaptureBitmap: TBitmap; virtual;
    /// <summary>Make a screenshot using callback recipient</summary>
    procedure Snapshot(const Recipient: TMapScreenshotRecipient); virtual;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections,
{$IF Defined(ANDROID)}
  FMX.Maps.Android
{$ELSEIF Defined(IOS)}
  FMX.Maps.iOS
{$ELSE}
  FMX.Maps.Dummy
{$ENDIF}
;

{ TMapCoordinate }

class function TMapCoordinate.Create(const Latitude, Longitude: Double): TMapCoordinate;
begin
  Result.Latitude := Latitude;
  Result.Longitude := Longitude;
end;

class function TMapCoordinate.Create(const Point: TPointF): TMapCoordinate;
begin
  Result.Latitude := Point.X;
  Result.Longitude := Point.Y;
end;

function TMapCoordinate.ToString: String;
begin
  Result := Format('%3.5f;%3.5f', [Latitude, Longitude]);
end;

class function TMapCoordinate.Zero: TMapCoordinate;
begin
  Result := TMapCoordinate.Create(0, 0);
end;

{ TCustomMapView }

constructor TCustomMapView.Create(Owner: TComponent);
var
  MapService: IFMXMapService;
begin
  inherited;
  FMapType := TMapType.Normal;

  if TPlatformServices.Current.SupportsPlatformService(IFmxMapService, MapService) then
  begin
    FMapView := MapService.CreateMapView;
    FMapView.SetHostControl(Self);
  end;

  FSavedVisible := True;
  CanFocus := True;
  GestureOptions := DefaultGestureOptions;
  ControlOptions := DefaultControlOptions;
end;

destructor TCustomMapView.Destroy;
var
  MapService: IFMXMapService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFmxMapService, MapService) then
    MapService.DestroyMapView(FMapView);
  FMapView := nil;
  inherited;
end;

procedure TCustomMapView.DoAbsoluteChanged;
begin
  inherited;
  AdjustToControl;
end;

procedure TCustomMapView.DoCameraChanged;
begin
  if Assigned(FOnCameraChanged) then
    FOnCameraChanged(Self);
end;

procedure TCustomMapView.DoMarkerClick(const Marker: TMapMarker);
begin
  if Assigned(FOnMarkerClick) then
    FOnMarkerClick(Marker);
end;

procedure TCustomMapView.DoMarkerDoubleClick(const Marker: TMapMarker);
begin
  if Assigned(FOnMarkerDoubleClick) then
    FOnMarkerDoubleClick(Marker);
end;

procedure TCustomMapView.DoMarkerDragStart(const Marker: TMapMarker);
begin
  if Assigned(FOnMarkerDragStart) then
    FOnMarkerDragStart(Marker);
end;

procedure TCustomMapView.DoMarkerDrag(const Marker: TMapMarker);
begin
  if Assigned(FOnMarkerDrag) then
    FOnMarkerDrag(Marker);
end;

procedure TCustomMapView.DoMarkerDragEnd(const Marker: TMapMarker);
begin
  if Assigned(FOnMarkerDragEnd) then
    FOnMarkerDragEnd(Marker);
end;

procedure TCustomMapView.DoMapClick(const Coordinate: TMapCoordinate);
begin
  if Assigned(FOnMapClick) then
    FOnMapClick(Coordinate);
end;

procedure TCustomMapView.DoMapDoubleClick(const Coordinate: TMapCoordinate);
begin
  if Assigned(FOnMapDoubleClick) then
    FOnMapDoubleClick(Coordinate);
end;

procedure TCustomMapView.DoMapLongClick(const Coordinate: TMapCoordinate);
begin
  if Assigned(FOnMapLongClick) then
    FOnMapLongClick(Coordinate);
end;

procedure TCustomMapView.Hide;
begin
  inherited;
  AdjustToControl;
end;

procedure TCustomMapView.Move;
begin
  inherited;
  AdjustToControl;
end;

procedure TCustomMapView.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    R.Inflate(-0.5, -0.5);
    Canvas.Stroke.Thickness := 1;
    Canvas.Stroke.Dash := TStrokeDash.Dash;
    Canvas.Stroke.Kind := TBrushKind.Solid;
    Canvas.Stroke.Color := $A0909090;
    Canvas.DrawRect(R, 0, 0, AllCorners, AbsoluteOpacity);
    Canvas.Stroke.Dash := TStrokeDash.Solid;
  end;
end;

procedure TCustomMapView.Snapshot(const Recipient: TMapScreenshotRecipient);
begin
  FMapView.Snapshot(Recipient);
end;

procedure TCustomMapView.ParentChanged;
begin
  inherited;
  if ([csLoading, csDesigning] * ComponentState) = [] then
  begin
    if HasParent then
      Visible := FSavedVisible
    else
    begin
      FSavedVisible := Visible;
      Visible := False;
    end;
    AdjustToControl;
  end;
end;

procedure TCustomMapView.Show;
begin
  inherited;
  AdjustToControl;
end;

procedure TCustomMapView.Resize;
begin
  inherited;
  AdjustToControl;
end;

function TCustomMapView.AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
begin
  if FMapView <> nil then
    Result := FMapView.AddMarker(Descriptor)
  else
    Result := nil;
end;

function TCustomMapView.AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
begin
  if FMapView <> nil then
    Result := FMapView.AddCircle(Descriptor)
  else
    Result := nil;
end;

function TCustomMapView.AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
begin
  if FMapView <> nil then
    Result := FMapView.AddPolygon(Descriptor)
  else
    Result := nil;
end;

function TCustomMapView.AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
begin
  if FMapView <> nil then
    Result := FMapView.AddPolyline(Descriptor)
  else
    Result := nil;
end;

procedure TCustomMapView.AdjustToControl;
begin
  if FMapView <> nil then
    FMapView.UpdateContentFromControl;
end;

procedure TCustomMapView.AncestorVisibleChanged(const Visible: Boolean);
begin
  inherited;
  AdjustToControl;
end;

procedure TCustomMapView.SetLocation(const ACoordinate: TMapCoordinate);
begin
  if FMapView <> nil then
  begin
    FMapView.SyncCameraPosition;
    FMapView.SetLocation(ACoordinate);
    FMapView.AnimateToCameraPosition;
  end;
end;

function TCustomMapView.GetLocation: TMapCoordinate;
begin
  Result := FMapView.GetLocation
end;

procedure TCustomMapView.SetBearing(const Bearing: Single);
begin
  FMapView.SyncCameraPosition;
  FMapView.SetBearing(Bearing);
  FMapView.AnimateToCameraPosition;
end;

function TCustomMapView.GetBearing: Single;
begin
  Result := FMapView.GetBearing;
end;

procedure TCustomMapView.SetControlOptions(const Options: TMapControlOptions);
begin
  FControlOptions := Options;
  FMapView.OptionsChanged([TMapOptionSet.Control]);
end;

procedure TCustomMapView.ChangeOrder;
begin
  inherited;
  AdjustToControl;
end;

function TCustomMapView.ControlOptionsStored: Boolean;
begin
  Result := GetControlOptions <> DefaultControlOptions;
end;

function TCustomMapView.GetControlOptions: TMapControlOptions;
begin
  Result := FControlOptions;
end;

procedure TCustomMapView.SetGestureOptions(const Options: TMapGestureOptions);
begin
  FGestureOptions := Options;
  FMapView.OptionsChanged([TMapOptionSet.Gesture]);
end;

function TCustomMapView.GetGestureOptions: TMapGestureOptions;
begin
  Result := FGestureOptions;
end;

function TCustomMapView.GestureOptionsStored: Boolean;
begin
  Result := GetGestureOptions <> DefaultGestureOptions;
end;

function TCustomMapView.GetLayerOptions: TMapLayerOptions;
begin
  Result := FLayerOptions;
end;

procedure TCustomMapView.SetLayerOptions(const Options: TMapLayerOptions);
begin
  FLayerOptions := Options;
  FMapView.OptionsChanged([TMapOptionSet.Layer]);
end;

function TCustomMapView.LayerOptionsStored: Boolean;
begin
  Result := GetLayerOptions <> DefaultLayerOptions;
end;

procedure TCustomMapView.SetTilt(const Degrees: Single);
begin
  FMapView.SyncCameraPosition;
  FMapView.SetTilt(Degrees);
  FMapView.AnimateToCameraPosition;
end;

function TCustomMapView.GetTilt: Single;
begin
  Result := FMapView.GetTilt;
end;

procedure TCustomMapView.SetZoom(const Value: Single);
begin
  FMapView.SetZoom(Value);
  FMapView.AnimateToCameraPosition;
end;

function TCustomMapView.GetZoom: Single;
begin
  Result := FMapView.GetZoom;
end;

function TCustomMapView.GetMapType: TMapType;
begin
  Result := FMapType;
end;

procedure TCustomMapView.SetMapType(const AValue: TMapType);
begin
  FMapType := AValue;
  FMapView.SetMapType(AValue);
end;

{ TMapMarkerDescriptor }

class function TMapMarkerDescriptor.Create(const Position: TMapCoordinate; const Title: string): TMapMarkerDescriptor;
begin
  Result.Position := Position;
  Result.Title := Title;
  Result.Opacity := 1;
  Result.Origin := TPointF.Create(0.5, 1);
  Result.Snippet := string.Empty;
  Result.Draggable := False;
  Result.Visible := True;
  Result.Appearance := TMarkerAppearance.Flat;
  Result.Rotation := 0;
  Result.Icon := nil;
end;

{ TMapCircleDescriptor }

class function TMapCircleDescriptor.Create(const Center: TMapCoordinate; const RadiusInMeters: Single): TMapCircleDescriptor;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.Center := Center;
  Result.Radius := RadiusInMeters;
  Result.StrokeColor := TAlphaColorRec.Black;
  Result.StrokeWidth := 10;
end;

{ TMapPolygonDescriptor }

class function TMapPolygonDescriptor.Create(const Outline: TArray<TMapCoordinate>): TMapPolygonDescriptor;
begin
//  SetLength(Result.Outline.Points, Length(Outline));
//  TArray.Copy<TMapCoordinate>(Outline, Result.Outline.Points, Length(Outline));
  Result.Outline.Points := Outline;
  SetLength(Result.Holes, 0);
  Result.Geodesic := False;
  Result.FillColor := 0;
  Result.StrokeColor := TAlphaColorRec.Black;
  Result.StrokeWidth := 10;
  Result.ZIndex := 0;
end;

procedure TMapPolygonDescriptor.AddHole(const Points: TArray<TMapCoordinate>);
begin
  SetLength(Holes, Length(Holes) + 1);
  Holes[Length(Holes) - 1].Points := Points;
end;

{ TMapPolylineDescriptor }

class function TMapPolylineDescriptor.Create(const Points: TArray<TMapCoordinate>): TMapPolylineDescriptor;
begin
  Result.Points.Points := Points;
  Result.Geodesic := False;
  Result.StrokeColor := TAlphaColorRec.Black;
  Result.StrokeWidth := 10;
  Result.ZIndex := 0;
end;

{ TMapObject<D> }

constructor TMapObject<D>.Create(const Descriptor: D);
begin
  FDescriptor := Descriptor;
end;

{ TMapViewBase }

function TMapViewBase.AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
begin
  Result := nil;
end;

function TMapViewBase.AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
begin
  Result := nil;
end;

function TMapViewBase.AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
begin
  Result := nil;
end;

function TMapViewBase.AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
begin
  Result := nil;
end;

function TMapViewBase.CaptureBitmap: TBitmap;
begin
  Result := nil;
end;

procedure TMapViewBase.Snapshot(const Recipient: TMapScreenshotRecipient);
begin
end;

destructor TMapViewBase.Destroy;
begin
  inherited;
end;

procedure TMapViewBase.OptionsChanged(const OptionSets: TMapOptionSets);
begin
end;

initialization
  RegisterMapService;

  RegisterFmxClasses([TMapView]);
end.

