{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Maps.iOS;

interface

{$SCOPEDENUMS ON}
procedure RegisterMapService;

implementation

uses
  System.Types, System.SysUtils, System.Generics.Collections, System.Classes, System.SyncObjs, System.Math,
  System.TypInfo, System.Messaging, Macapi.ObjectiveC, Macapi.ObjCRuntime, Macapi.Helpers, iOSapi.Foundation,
  iOSapi.CoreGraphics, iOSapi.UIKit, iOSapi.MapKit,  iOSapi.CoreLocation, FMX.Types, FMX.Platform, FMX.Maps, FMX.Forms,
  FMX.Graphics, FMX.Surfaces, FMX.Platform.iOS, FMX.Helpers.iOS, System.UITypes, FMX.MultiResBitmap, FMX.Utils,
  FMX.ZOrder.iOS;

type
  TMapKitMapView = class;

  TMapKitService = class(TInterfacedObject, IFMXMapService)
  private
    FMapViews: TList<TMapKitMapView>;
    procedure FormActivateHandler(const Sender: TObject; const M: TMessage);
  public
    constructor Create; overload;
    destructor Destroy; override;
    function CreateMapView: ICustomMapView;
    procedure DestroyMapView(const MapView: ICustomMapView);
    procedure RealignMapViews;
  end;

  MKMapViewDelegate = interface(IObjectiveC)
    ['{E6E6448F-DB78-48D4-B2EC-3C3B80E9AAE2}']
    [MethodName('mapView:regionDidChangeAnimated:')]
    procedure mapViewRegionDidChangeAnimated(mapView: MKMapView; regionDidChangeAnimated: Boolean); cdecl;
    procedure mapViewDidFinishLoadingMap(mapView: MKMapView); cdecl;
    [MethodName('mapView:viewForAnnotation:')]
    function mapViewViewForAnnotation(mapView: MKMapView; viewForAnnotation: Pointer): MKAnnotationView; cdecl;
    [MethodName('mapView:didSelectAnnotationView:')]
    procedure mapViewDidSelectAnnotationView(mapView: MKMapView; didSelectAnnotationView: MKAnnotationView); cdecl;
    [MethodName('mapView:didDeselectAnnotationView:')]
    procedure mapViewDidDeselectAnnotationView(mapView: MKMapView; didDeselectAnnotationView: MKAnnotationView); cdecl;
    [MethodName('mapView:annotationView:didChangeDragState:fromOldState:')]
    procedure mapViewAnnotationViewDidChangeDragStateFromOldState(mapView: MKMapView; annotationView: MKAnnotationView;
      didChangeDragState: MKAnnotationViewDragState; fromOldState: MKAnnotationViewDragState); cdecl;
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; rendererForOverlay: Pointer): MKOverlayRenderer; cdecl;
  end;

  TMapKitDelegate = class (TOCLocal, MKMapViewDelegate)
  private
    [Weak] FView: TMapKitMapView;
  public
    constructor Create(const View: TMapKitMapView);

    [MethodName('mapView:regionDidChangeAnimated:')]
    procedure mapViewRegionDidChangeAnimated(mapView: MKMapView; regionDidChangeAnimated: Boolean); cdecl;
    procedure mapViewDidFinishLoadingMap(mapView: MKMapView); cdecl;

    { Overlays & Views }
    [MethodName('mapView:rendererForOverlay:')]
    function mapViewRendererForOverlay(mapView: MKMapView; rendererForOverlay: Pointer): MKOverlayRenderer; cdecl;
    [MethodName('mapView:viewForAnnotation:')]
    function mapViewViewForAnnotation(mapView: MKMapView; viewForAnnotation: Pointer): MKAnnotationView; cdecl;

    { Annotations interaction }
    [MethodName('mapView:didSelectAnnotationView:')]
    procedure mapViewDidSelectAnnotationView(mapView: MKMapView; didSelectAnnotationView: MKAnnotationView); cdecl;
    [MethodName('mapView:didDeselectAnnotationView:')]
    procedure mapViewDidDeselectAnnotationView(mapView: MKMapView; didDeselectAnnotationView: MKAnnotationView); cdecl;
    [MethodName('mapView:annotationView:didChangeDragState:fromOldState:')]
    procedure mapViewAnnotationViewDidChangeDragStateFromOldState(mapView: MKMapView; annotationView: MKAnnotationView;
      didChangeDragState: MKAnnotationViewDragState; fromOldState: MKAnnotationViewDragState); cdecl;
  end;

  TMapEventKind = (CameraChanged, MarkerClick, MarkerDeselect, MarkerDragStart, MarkerDrag, MarkerDragEnd, MapClick,
    MapDoubleClick, MapLongClick);
  TMapEvent = record
    Kind: TMapEventKind;
    LatLng: TMapCoordinate;
    Marker: TMapMarker;

    class function CameraChanged(const LatLng: TMapCoordinate): TMapEvent; static;
    class function MapClick(const LatLng: TMapCoordinate): TMapEvent; static;
    class function MapLongClick(const LatLng: TMapCoordinate): TMapEvent; static;
    class function MapDoubleClick(const LatLng: TMapCoordinate): TMapEvent; static;
    class function MarkerClick(const Marker: TMapMarker): TMapEvent; static;
    class function MarkerDeselected(const Marker: TMapMarker): TMapEvent; static;
    class function MarkerDragStart(const Marker: TMapMarker): TMapEvent; static;
    class function MarkerDrag(const Marker: TMapMarker): TMapEvent; static;
    class function MarkerDragEnd(const Marker: TMapMarker): TMapEvent; static;
  end;

  IMapKitMapView = interface(UIView)
    ['{DA304D94-94C8-43D5-AEAA-532E68FBD492}']
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldReceiveTouch: UITouch): Boolean; overload; cdecl;
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean; overload; cdecl;
    function gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
    procedure HandleLongPress(gestureRecognizer: UILongPressGestureRecognizer); cdecl;
    procedure HandleTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
    procedure HandleDoubleTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
  end;

  TMapViewGestureDelegate = class(TOCLocal, UIGestureRecognizerDelegate)
  private
    [Weak] FMapView: TMapKitMapView;
  public
    constructor Create(const MapView: TMapKitMapView);
    function GetObjectiveCClass: PTypeInfo; override;
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldReceiveTouch: UITouch): Boolean; overload; cdecl;
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean; overload; cdecl;
    function gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
    procedure HandleLongPress(gestureRecognizer: UILongPressGestureRecognizer); cdecl;
    procedure HandleTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
    procedure HandleDoubleTap(gestureRecognizer: UITapGestureRecognizer); cdecl;
  end;

  TBitmapRecipientProxy = class
  private
    [Weak] FOwner: TMapKitMapView;
    FBitmap: TBitmap;
    FFinished: Boolean;
    FMaxSize: TSize;
    FCallback: TMapScreenshotRecipient;
  public
    constructor Create(const Owner: TMapKitMapView; const MaxSize: TSize; const Callback: TMapScreenshotRecipient);
    procedure CompletionHandler(snapshot: MKMapSnapshot; error: NSError);
    function ExpectBitmap: TBitmap;
  end;

  TMapKitMapView = class(TInterfacedObject, ICustomMapView)
  strict private
    FMapView: MKMapView;
    FDelegate: TMapKitDelegate;
    FGestureDelegate: TMapViewGestureDelegate;
    [Weak] FHostControl: TCustomMapView;
    FScale: Single;
    FLoaded: Boolean;
    FTilt: Single;
    FBearing: Single;
    FZoom: Single;
    FSetZoom: Single;
    FLocation: TMapCoordinate;
    FMapObjects: TDictionary<Pointer, TMapObjectBase>;
    FSelectedMarker: TMapMarker;
    FDragState: Integer;
    FRecipient: TBitmapRecipientProxy;
    FSnapshotInProgress: Boolean;
    [Weak] FZOrderManager: TiOSZOrderManager;
  protected
    procedure SetLayerOptions;
    procedure SetControlOptions;
    procedure SetGestureOptions;
    procedure SetDragState(const Marker: TMapMarker; NextState: Integer);
    procedure SetZoomArea;
    function GetMapObject<T: TMapObjectBase>(const Key: Pointer): T;
    procedure PutMapObject<T: TMapObjectBase>(const Key: Pointer; const MapObject: T);
    procedure RemoveMapObject(const Key: Pointer);
    property Scale: Single read FScale;
    property Loaded: Boolean read FLoaded write FLoaded;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetHostControl(const Host: TCustomMapView);
    procedure DestroyView;
    procedure UpdateContentFromControl;
    procedure Show;
    procedure Hide;
    procedure AnimateToCameraPosition;
    procedure SyncCameraPosition;
    procedure MapEvent(const Event: TMapEvent);
    procedure SetLocation(const ACoordinate: TMapCoordinate);
    function GetLocation: TMapCoordinate;
    procedure SetZoom(const Zoom: Single);
    function GetZoom: Single;
    procedure SetBearing(const Bearing: Single);
    function GetBearing: Single;
    procedure SetTilt(const Tilt: Single);
    function GetTilt: Single;
    procedure SetMapType(const AValue: TMapType);
    procedure OptionsChanged(const OptionSets: TMapOptionSets);
    function AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
    function AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
    function AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
    function AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
    function CaptureBitmap: TBitmap; 
    procedure Snapshot(const Recipient: TMapScreenshotRecipient);
    procedure SnapshotCompleted;
    procedure InitMapView;
    property MKView: MKMapView read FMapView;
  end;

  TMapKitMapMarker = class(TMapMarker)
  private
    FAnnotation: MKPointAnnotation;
    FVisible: Boolean;
    [Weak] FView: TMapKitMapView;
    FAnnotationView: MKAnnotationView;
  public
    constructor Create(const Descriptor: TMapMarkerDescriptor; const View: TMapKitMapView); reintroduce;
    function Id: Pointer;
    destructor Destroy; override;
    procedure Remove; override;
    procedure SetVisible(const Value: Boolean); override;
    function AnnotationView: MKAnnotationView;
    function ToString: string; override;
  end;

  TMapKitMapCircle = class(TMapCircle)
  private
    FCircle: MKCircle;
    FVisible: Boolean;
    [Weak] FView: TMapKitMapView;
  public
    constructor Create(const Descriptor: TMapCircleDescriptor; const View: TMapKitMapView); reintroduce;
    destructor Destroy; override;
    function Id: Pointer;
    procedure Remove; override;
    procedure SetVisible(const Value: Boolean); override;
    function Renderer: MKCircleRenderer;
    function ToString: string; override;
  end;

  TMapKitMapPolygon = class(TMapPolygon)
  private
    FPolygon: MKPolygon;
    FVisible: Boolean;
    [Weak] FView: TMapKitMapView;
  public
    constructor Create(const Descriptor: TMapPolygonDescriptor; const View: TMapKitMapView); reintroduce;
    destructor Destroy; override;
    function Id: Pointer;
    procedure Remove; override;
    procedure SetVisible(const Value: Boolean); override;
    function Renderer: MKPolygonRenderer;
    function ToString: string; override;
  end;

  TMapKitMapPolyline = class(TMapPolyline)
  private
    FPolyline: MKPolyline;
    FVisible: Boolean;
    [Weak] FView: TMapKitMapView;
  public
    constructor Create(const Descriptor: TMapPolylineDescriptor; const View: TMapKitMapView); reintroduce;
    destructor Destroy; override;
    function Id: Pointer;
    procedure Remove; override;
    procedure SetVisible(const Value: Boolean); override;
    function Renderer: MKPolylineRenderer;
    function ToString: string; override;
  end;

var
  MapService: TMapKitService;

procedure RegisterMapService;
begin
  MapService := TMapKitService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXMapService, MapService);
end;

{ TMapKitService }

constructor TMapKitService.Create;
begin
  inherited;
  FMapViews := TList<TMapKitMapView>.Create;
  TMessageManager.DefaultManager.SubscribeToMessage(TFormActivateMessage, FormActivateHandler);
end;

destructor TMapKitService.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TFormActivateMessage, FormActivateHandler);
  FMapViews.Free;
  inherited;
end;

function TMapKitService.CreateMapView: ICustomMapView;
var
  MapView: TMapKitMapView;
begin
  MapView := TMapKitMapView.Create;
  FMapViews.Add(MapView);
  Result := MapView;
end;

procedure TMapKitService.DestroyMapView(const MapView: ICustomMapView);
begin
  FMapViews.Remove(TMapKitMapView(MapView));
  TMapKitMapView(MapView).DestroyView;
end;

procedure TMapKitService.FormActivateHandler(const Sender: TObject; const M: TMessage);
begin
  RealignMapViews;
end;

procedure TMapKitService.RealignMapViews;
var
  Map: TMapKitMapView;
begin
  for Map in FMapViews do
  begin
    Map.InitMapView;
    Map.UpdateContentFromControl;
  end;
end;

{ TMapKitView }

constructor TMapKitMapView.Create;
var
  ScreenService: IFMXScreenService;
begin
  inherited;
  FZoom := 1;
  FSetZoom := 1;
  FTilt := 0;
  FBearing := 0;

  FMapObjects := TDictionary<Pointer, TMapObjectBase>.Create;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, ScreenService) then
    FScale := ScreenService.GetScreenScale
  else
    FScale := 1;
  InitMapView;
end;

destructor TMapKitMapView.Destroy;
begin
  FMapObjects.DisposeOf;
  DestroyView;
  inherited;
end;

procedure TMapKitMapView.InitMapView;
  procedure AddLongTapRecognizer(Delegate: TMapViewGestureDelegate);
  var
    Recognizer: UILongPressGestureRecognizer;
  begin
    Recognizer := TUILongPressGestureRecognizer.Wrap(TUILongPressGestureRecognizer.Alloc.initWithTarget(
      Delegate.GetObjectID, sel_getUid('HandleLongPress:')));
    try
      Recognizer.setDelegate(Delegate.GetObjectID);
      FMapView.addGestureRecognizer(Recognizer);
    finally
      Recognizer.release;
    end;
  end;

  procedure AddTapRecognizer(Delegate: TMapViewGestureDelegate);
  var
    SingleTap, DoubleTap: UITapGestureRecognizer;
  begin
    DoubleTap := TUITapGestureRecognizer.Wrap(TUITapGestureRecognizer.Alloc.initWithTarget(
      Delegate.GetObjectID, sel_getUid('HandleDoubleTap:')));
    SingleTap := TUITapGestureRecognizer.Wrap(TUITapGestureRecognizer.Alloc.initWithTarget(
      Delegate.GetObjectID, sel_getUid('HandleTap:')));
    try
      DoubleTap.setDelegate(Delegate.GetObjectID);
      DoubleTap.setNumberOfTapsRequired(2);
      FMapView.addGestureRecognizer(DoubleTap);

      SingleTap.setDelegate(Delegate.GetObjectID);
      SingleTap.setNumberOfTapsRequired(1);
      SingleTap.requireGestureRecognizerToFail(DoubleTap);
      FMapView.addGestureRecognizer(SingleTap);
    finally
      DoubleTap.release;
      SingleTap.release;
    end;
  end;

begin
  if FMapView = nil then
  begin
    FMapView := TMKMapView.Create;
    FMapView.setHidden(True);
    FDelegate := TMapKitDelegate.Create(Self);
    FGestureDelegate := TMapViewGestureDelegate.Create(Self);
    AddTapRecognizer(FGestureDelegate);
    AddLongTapRecognizer(FGestureDelegate);
  end;
  SetGestureOptions;
  SetControlOptions;
  SetLayerOptions;
end;

procedure TMapKitMapView.MapEvent(const Event: TMapEvent);
begin
  case Event.Kind of
    TMapEventKind.CameraChanged:
      begin
        SyncCameraPosition;
        FHostControl.DoCameraChanged;
      end;
    TMapEventKind.MarkerClick:
      begin
        // Marker has been selected
        FSelectedMarker := Event.Marker;
        FHostControl.DoMarkerClick(Event.Marker);
      end;
    TMapEventKind.MarkerDeselect:
        FSelectedMarker := nil;
    TMapEventKind.MarkerDragStart:
      FHostControl.DoMarkerDragStart(Event.Marker);
    TMapEventKind.MarkerDrag:
      FHostControl.DoMarkerDrag(Event.Marker);
    TMapEventKind.MarkerDragEnd:
      FHostControl.DoMarkerDragEnd(Event.Marker);
    TMapEventKind.MapClick:
      if FDragState = MKAnnotationViewDragStateNone then
        if FSelectedMarker = nil then
          FHostControl.DoMapClick(Event.LatLng)
        else
          FHostControl.DoMarkerClick(FSelectedMarker);
    TMapEventKind.MapLongClick:
      if FDragState = MKAnnotationViewDragStateNone then
        if FSelectedMarker = nil then
          FHostControl.DoMapLongClick(Event.LatLng);
    TMapEventKind.MapDoubleClick:
      if FSelectedMarker = nil then
        FHostControl.DoMapDoubleClick(Event.LatLng)
      else
        FHostControl.DoMarkerDoubleClick(FSelectedMarker);
  end;
end;

procedure TMapKitMapView.DestroyView;
begin
  if (FZOrderManager <> nil) and (FHostControl <> nil) then
  begin
    FZOrderManager.UpdateOrderAndBounds(FHostControl, FMapView);
    FZOrderManager.RemoveLink(FHostControl);
  end;
  FMapView := nil;
  FDelegate.DisposeOf;
end;

function TMapKitMapView.GetMapObject<T>(const Key: Pointer): T;
var
  TmpResult: TMapObjectBase;
begin
  if FMapObjects.TryGetValue(Key, TmpResult) then
    try
      Result := TmpResult as T;
    except
      on EInvalidCast do
        Result := nil;
    end;
end;

procedure TMapKitMapView.PutMapObject<T>(const Key: Pointer; const MapObject: T);
var
  MObject: TMapObjectBase;
begin
  if FMapObjects.TryGetValue(Key, MObject) then
    FMapObjects[Key] := MapObject
  else
    FMapObjects.Add(Key, MapObject);
end;

procedure TMapKitMapView.RemoveMapObject(const Key: Pointer);
begin
  FMapObjects.Remove(Key);
end;

procedure TMapKitMapView.SetHostControl(const Host: TCustomMapView);
begin
  FHostControl := Host;
end;

procedure TMapKitMapView.UpdateContentFromControl;
begin
  if FMapView <> nil then
  begin
    if (FHostControl <> nil) and not (csDesigning in FHostControl.ComponentState) and
      (FHostControl.Root is TCommonCustomForm) then
      FZOrderManager := WindowHandleToPlatform(TCommonCustomForm(FHostControl.Root).Handle).ZOrderManager;
    if FZOrderManager <> nil then
    begin
      FZOrderManager.UpdateOrderAndBounds(FHostControl, FMapView);
      if FMapView.isHidden then
        Hide
      else
        Show;
      if FHostControl.Parent = nil then
      begin
        FZOrderManager.RemoveLink(FHostControl);
        FZOrderManager := nil;
      end;
    end
  end;
end;

procedure TMapKitMapView.Show;
begin
  FMapView.setDelegate(FDelegate.GetObjectID);
  FMapView.setPitchEnabled(True);
  SetZoomArea;
end;

procedure TMapKitMapView.Hide;
begin
end;

procedure TMapKitMapView.SetDragState(const Marker: TMapMarker; NextState: Integer);
begin
  case NextState of
    MKAnnotationViewDragStateStarting:
      MapEvent(TMapEvent.MarkerDragStart(Marker));
    MKAnnotationViewDragStateDragging:
      MapEvent(TMapEvent.MarkerDrag(Marker));
    MKAnnotationViewDragStateNone:
      MapEvent(TMapEvent.MarkerDragEnd(Marker));
  end;
  FDragState := NextState;
end;

procedure TMapKitMapView.AnimateToCameraPosition;
begin
end;

constructor TBitmapRecipientProxy.Create(const Owner: TMapKitMapView; const MaxSize: TSize; const Callback: TMapScreenshotRecipient);
begin
  FMaxSize := MaxSize;
  FCallback := Callback;
  FOwner := Owner;
end;

procedure TBitmapRecipientProxy.CompletionHandler(snapshot: MKMapSnapshot; error: NSError);
begin
  if (error = nil) and (snapshot <> nil) and (snapshot.image <> nil) then
    FBitmap := UIImageToBitmap(snapshot.image, 0, FMaxSize);
  FFinished := True;
  if Assigned(FCallback) then
    TThread.Queue(nil, procedure begin
        if Assigned(FCallback) then
          FCallback(FBitmap);
        FBitmap.Free;
        FOwner.SnapshotCompleted;
      end);
end;

function TBitmapRecipientProxy.ExpectBitmap: TBitmap;
const
  RunLoopTimeout = 0.1;
  RunLoopCount = 100;
var
  RunLoop: NSRunLoop;
  Count: Integer;
begin
  Count := RunLoopCount;
  RunLoop := TNSRunLoop.Wrap(TNSRunLoop.OCClass.currentRunLoop);
  while (not FFinished) and RunLoop.runMode(NSDefaultRunLoopMode,
    TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceNow(RunLoopTimeout))) and (Count > 0) do
    Dec(Count);
  Result := FBitmap;
end;

function TMapKitMapView.CaptureBitmap: TBitmap;
var
  Proxy: TBitmapRecipientProxy;
begin
  Result := TNonReentrantHelper.Execute<TBitmap>(FSnapshotInProgress,
    function: TBitmap
    var
      Options: MKMapSnapshotOptions;
      Snapshotter: MKMapSnapshotter;
    begin
      Options := TMKMapSnapshotOptions.Wrap(TMKMapSnapshotOptions.Alloc.init);
      Options.setRegion(FMapView.region);
      Options.setScale(Scale);
      Options.setSize(FMapView.frame.size);
      Options.setCamera(FMapView.camera);
      Options.setMapType(FMapView.mapType);

      Snapshotter := TMKMapSnapshotter.Wrap(TMKMapSnapshotter.Alloc.initWithOptions(Options));
      Proxy := TBitmapRecipientProxy.Create(Self, TSize.Create(Ceil(FHostControl.Width * Scale),
        Ceil(FHostControl.Height * Scale)), nil);
      Snapshotter.startWithCompletionHandler(Proxy.CompletionHandler);
      Result := Proxy.ExpectBitmap;
    end, nil);
end;

procedure TMapKitMapView.Snapshot(const Recipient: TMapScreenshotRecipient);
var
  Options: MKMapSnapshotOptions;
  Snapshotter: MKMapSnapshotter;
begin
  TNonReentrantHelper.EnterSection(FSnapshotInProgress);
  Options := TMKMapSnapshotOptions.Wrap(TMKMapSnapshotOptions.Alloc.init);
  Options.setRegion(FMapView.region);
  Options.setScale(Scale);
  Options.setSize(FMapView.frame.size);
  Options.setCamera(FMapView.camera);
  Options.setMapType(FMapView.mapType);

  Snapshotter := TMKMapSnapshotter.Wrap(TMKMapSnapshotter.Alloc.initWithOptions(Options));
  FRecipient := TBitmapRecipientProxy.Create(Self, TSize.Create(Ceil(FHostControl.Width * Scale),
    Ceil(FHostControl.Height * Scale)), Recipient);
  Snapshotter.startWithCompletionHandler(FRecipient.CompletionHandler);
end;

procedure TMapKitMapView.SnapshotCompleted;
begin
  TNonReentrantHelper.LeaveSection(FSnapshotInProgress);
end;

procedure TMapKitMapView.SetBearing(const Bearing: Single);
begin
  if not SameValue(GetBearing, Bearing, TMapEpsilon.Bearing) then
    FMapView.camera.setHeading(Bearing);
end;

function TMapKitMapView.GetBearing: Single;
begin
  Result := FMapView.camera.heading;
end;

procedure TMapKitMapView.SetLocation(const ACoordinate: TMapCoordinate);
begin
  FMapView.setCenterCoordinate(CLLocationCoordinate2D(ACoordinate));
  // important while the view is not fully initalized: keep the set value, which is more precise than
  // what has been obtained in mapViewRegionDidChangeAnimated callback (see SyncCameraPosition)
  FLocation := ACoordinate;
end;

function TMapKitMapView.GetLocation: TMapCoordinate;
begin
  Result := FLocation;
end;

procedure TMapKitMapView.SetTilt(const Tilt: Single);
begin
  if not SameValue(GetTilt, Tilt, TMapEpsilon.Tilt) then
    FMapView.camera.setPitch(Tilt);
end;

function TMapKitMapView.GetTilt: Single;
begin
  Result := FMapView.camera.pitch;
end;

procedure TMapKitMapView.SetZoom(const Zoom: Single);
begin
  if SameValue(Zoom, GetZoom, TMapEpsilon.Zoom) then
    Exit;
  FSetZoom := Zoom;
  if not FMapView.isHidden then
    SetZoomArea;
end;

procedure TMapKitMapView.SetZoomArea;
var
  W, H: Double;
  Center: MKMapPoint;
  Rect: MKMapRect;
begin
  if not FMapView.isHidden then
  begin
    Center := MKMapPointForCoordinate(CLLocationCoordinate2D(FLocation));
    W := 2 * FMapView.bounds.size.width * Power(2, 20 - FSetZoom);
    H := 2 * FMapView.bounds.size.height * Power(2, 20 - FSetZoom);
    Rect.origin.x := Center.x - W / 2;
    Rect.origin.y := Center.y - H / 2;
    Rect.size.width := W;
    Rect.size.height := H;
    FMapView.setVisibleMapRectAnimated(Rect, False);
  end;
end;

function TMapKitMapView.GetZoom: Single;
const
  TileSize = 256;
  FullCircleDegrees = 360;
begin
  if FMapView.isHidden then
    Result := FSetZoom
  else
    Result := Log2(FullCircleDegrees * ((FMapView.frame.size.width/TileSize) / FMapView.region.span.longitudeDelta)) + 1;
end;

procedure TMapKitMapView.OptionsChanged(const OptionSets: TMapOptionSets);
begin
  if TMapOptionSet.Layer in OptionSets then
    SetLayerOptions;
  if TMapOptionSet.Control in OptionSets then
    SetControlOptions;
  if TMapOptionSet.Gesture in OptionSets then
    SetGestureOptions;
end;

procedure TMapKitMapView.SetControlOptions;
begin
end;

procedure TMapKitMapView.SetGestureOptions;
begin
  if (FMapView <> nil) and (FHostControl <> nil) then
  begin
    FMapView.setZoomEnabled(TMapGestureOption.Zoom in FHostControl.GestureOptions);
    FMapView.setScrollEnabled(TMapGestureOption.Scroll in FHostControl.GestureOptions);
    FMapView.setPitchEnabled(TMapGestureOption.Tilt in FHostControl.GestureOptions);
    FMapView.setRotateEnabled(TMapGestureOption.Rotate in FHostControl.GestureOptions);
  end;
end;

procedure TMapKitMapView.SetLayerOptions;
begin
  if (FMapView <> nil) and (FHostControl <> nil) then
  begin
    FMapView.setShowsBuildings(TMapLayerOption.Buildings in FHostControl.LayerOptions);
    FMapView.setShowsUserLocation(TMapLayerOption.UserLocation in FHostControl.LayerOptions);
    FMapView.setShowsPointsOfInterest(TMapLayerOption.PointsOfInterest in FHostControl.LayerOptions);
  end;
end;

procedure TMapKitMapView.SetMapType(const AValue: TMapType);
begin
  if FMapView <> nil then
    case AValue of
      TMapType.None:
        FMapView.setMapType(MKMapTypeStandard);
      TMapType.Normal:
        FMapView.setMapType(MKMapTypeStandard);
      TMapType.Satellite:
        FMapView.setMapType(MKMapTypeSatellite);
      TMapType.Hybrid:
        FMapView.setMapType(MKMapTypeHybrid);
      TMapType.Terrain:
        FMapView.setMapType(MKMapTypeStandard);
    end;
end;

procedure TMapKitMapView.SyncCameraPosition;
begin
  if FMapView <> nil then
  begin
    FTilt := FMapView.camera.pitch;
    FBearing := FMapView.camera.heading;
    FZoom := GetZoom;
    FLocation := TMapCoordinate(FMapView.centerCoordinate);
  end;
end;

function TMapKitMapView.AddMarker(const Descriptor: TMapMarkerDescriptor): TMapMarker;
begin
  Result := TMapKitMapMarker.Create(Descriptor, Self);
  PutMapObject<TMapMarker>(TMapKitMapMarker(Result).Id, Result);
  Result.SetVisible(True);
end;

function TMapKitMapView.AddCircle(const Descriptor: TMapCircleDescriptor): TMapCircle;
begin
  Result := TMapKitMapCircle.Create(Descriptor, Self);
  PutMapObject<TMapCircle>(TMapKitMapCircle(Result).Id, Result);
  Result.SetVisible(True);
end;

function TMapKitMapView.AddPolygon(const Descriptor: TMapPolygonDescriptor): TMapPolygon;
begin
  Result := TMapKitMapPolygon.Create(Descriptor, Self);
  PutMapObject<TMapPolygon>(TMapKitMapPolygon(Result).Id, Result);
  Result.SetVisible(True);
end;

function TMapKitMapView.AddPolyline(const Descriptor: TMapPolylineDescriptor): TMapPolyline;
begin
  Result := TMapKitMapPolyline.Create(Descriptor, Self);
  PutMapObject<TMapPolyline>(TMapKitMapPolyline(Result).Id, Result);
  Result.SetVisible(True);
end;

{ TMapKitDelegate }
constructor TMapKitDelegate.Create(const View: TMapKitMapView);
begin
  inherited Create;
  FView := View;
end;

procedure TMapKitDelegate.mapViewDidFinishLoadingMap(mapView: MKMapView);
begin
  if FView <> nil then
    FView.Loaded := True;
end;

procedure TMapKitDelegate.mapViewRegionDidChangeAnimated(mapView: MKMapView; regionDidChangeAnimated: Boolean); cdecl;
var
  Event: TMapEvent;
begin
  Event.Kind := TMapEventKind.CameraChanged;
  Event.LatLng := TMapCoordinate(mapView.centerCoordinate);
  FView.MapEvent(Event);
end;

function TMapKitDelegate.mapViewViewForAnnotation(mapView: MKMapView; viewForAnnotation: Pointer): MKAnnotationView;
var
  Marker: TMapKitMapMarker;
begin
  Result := nil;
  Marker := FView.GetMapObject<TMapKitMapMarker>((TMKPointAnnotation.Wrap(viewForAnnotation) as ILocalObject).GetObjectID);
  if Marker <> nil then
    Result := Marker.AnnotationView;
end;

function TMapKitDelegate.mapViewRendererForOverlay(mapView: MKMapView; rendererForOverlay: Pointer): MKOverlayRenderer;
  function CircleRenderer(O: NSObject): MKCircleRenderer;
  var
    C: TMapKitMapCircle;
  begin
    Result := nil;
    C := TMapKitMapCircle(FView.GetMapObject<TMapCircle>((O as ILocalObject).GetObjectID));
    if (C <> nil) and C.FVisible then
      Result := C.Renderer;
  end;

  function PolygonRenderer(O: NSObject): MKPolygonRenderer;
  var
    P: TMapKitMapPolygon;
  begin
    Result := nil;
    P := TMapKitMapPolygon(FView.GetMapObject<TMapPolygon>((O as ILocalObject).GetObjectID));
    if (P <> nil) and P.FVisible then
      Result := P.Renderer;
  end;

  function PolylineRenderer(O: NSObject): MKPolylineRenderer;
  var
    L: TMapKitMapPolyline;
  begin
    Result := nil;
    L := TMapKitMapPolyline(FView.GetMapObject<TMapPolyline>((O as ILocalObject).GetObjectID));
    if (L <> nil) and L.FVisible then
      Result := L.Renderer;
  end;

var
  Ovl: NSObject;
begin
  Result := nil;
  Ovl := TNSObject.Wrap(rendererForOverlay);
  if Ovl.isKindOfClass(objc_getClass('MKCircle')) then
    Result := CircleRenderer(Ovl)
  else if Ovl.isKindOfClass(objc_getClass('MKPolygon')) then
    Result := PolygonRenderer(Ovl)
  else if Ovl.isKindOfClass(objc_getClass('MKPolyline')) then
    Result := PolylineRenderer(Ovl);
end;

{ TMapKitDelegate Annotation interaction }

procedure TMapKitDelegate.mapViewDidSelectAnnotationView(mapView: MKMapView; didSelectAnnotationView: MKAnnotationView);
var
  Marker: TMapMarker;
begin
  Marker := FView.GetMapObject<TMapMarker>(
    (TMKPointAnnotation.Wrap(didSelectAnnotationView.annotation) as ILocalObject).GetObjectID);
  if Marker <> nil then
    FView.MapEvent(TMapEvent.MarkerClick(Marker));
end;

procedure TMapKitDelegate.mapViewDidDeselectAnnotationView(mapView: MKMapView; didDeselectAnnotationView: MKAnnotationView);
var
  Marker: TMapMarker;
begin
  Marker := FView.GetMapObject<TMapKitMapMarker>(
    (TMKPointAnnotation.Wrap(didDeselectAnnotationView.annotation) as ILocalObject).GetObjectID);
  FView.MapEvent(TMapEvent.MarkerDeselected(Marker));
end;

procedure TMapKitDelegate.mapViewAnnotationViewDidChangeDragStateFromOldState(mapView: MKMapView;
  annotationView: MKAnnotationView; didChangeDragState, fromOldState: MKAnnotationViewDragState);
var
  Marker: TMapMarker;
begin
  Marker := FView.GetMapObject<TMapKitMapMarker>(
    (TMKPointAnnotation.Wrap(annotationView.annotation) as ILocalObject).GetObjectID);
  FView.SetDragState(Marker, didChangeDragState);

  if not annotationView.isKindOfClass(objc_getClass('MKPinAnnotationView')) then
  begin
    if (didChangeDragState = MKAnnotationViewDragStateStarting) and
      (annotationView.dragState <> MKAnnotationViewDragStateDragging) then
      annotationView.setDragState(MKAnnotationViewDragStateDragging);
    if didChangeDragState in [MKAnnotationViewDragStateCanceling, MKAnnotationViewDragStateEnding] then
      annotationView.setDragState(MKAnnotationViewDragStateNone);
  end;
end;

{ TMapEvent }

class function TMapEvent.CameraChanged(const LatLng: TMapCoordinate): TMapEvent;
begin
  Result.Kind := TMapEventKind.CameraChanged;
  Result.LatLng := LatLng;
end;

class function TMapEvent.MapClick(const LatLng: TMapCoordinate): TMapEvent;
begin
  Result.Kind := TMapEventKind.MapClick;
  Result.LatLng := LatLng;
end;

class function TMapEvent.MapDoubleClick(const LatLng: TMapCoordinate): TMapEvent;
begin
  Result.Kind := TMapEventKind.MapDoubleClick;
  Result.LatLng := LatLng;
end;

class function TMapEvent.MapLongClick(const LatLng: TMapCoordinate): TMapEvent;
begin
  Result.Kind := TMapEventKind.MapLongClick;
  Result.LatLng := LatLng;
end;

class function TMapEvent.MarkerClick(const Marker: TMapMarker): TMapEvent;
begin
  Result.Kind := TMapEventKind.MarkerClick;
  Result.Marker := Marker;
end;

class function TMapEvent.MarkerDeselected(const Marker: TMapMarker): TMapEvent;
begin
  Result.Kind := TMapEventKind.MarkerDeselect;
  Result.Marker := Marker;
end;

class function TMapEvent.MarkerDragStart(const Marker: TMapMarker): TMapEvent;
begin
  Result.Kind := TMapEventKind.MarkerDragStart;
  Result.Marker := Marker;
end;

class function TMapEvent.MarkerDrag(const Marker: TMapMarker): TMapEvent;
begin
  Result.Kind := TMapEventKind.MarkerDrag;
  Result.Marker := Marker;
end;

class function TMapEvent.MarkerDragEnd(const Marker: TMapMarker): TMapEvent;
begin
  Result.Kind := TMapEventKind.MarkerDragEnd;
  Result.Marker := Marker;
end;

procedure StateSwitch(var State: Boolean; const NewValue: Boolean; SetProc: TProc; ResetProc: TProc);
var
  OldState: Boolean;
begin
  OldState := State;
  State := NewValue;
  if NewValue and not OldState then
    SetProc
  else if not NewValue and OldState then
    ResetProc;
end;

{ TMapKitMapMarker }

constructor TMapKitMapMarker.Create(const Descriptor: TMapMarkerDescriptor; const View: TMapKitMapView);
begin
  inherited Create(Descriptor);
  FView := View;
  FAnnotation := TMKPointAnnotation.Wrap(TMKPointAnnotation.Alloc.init);
  FAnnotation.setCoordinate(CLLocationCoordinate2D(Descriptor.Position));
  FAnnotation.setTitle(StrToNSStr(Descriptor.Title));
  FAnnotation.setSubtitle(StrToNSStr(Descriptor.Snippet));
end;

destructor TMapKitMapMarker.Destroy;
begin
  Remove;
  inherited;
end;

function TMapKitMapMarker.Id: Pointer;
begin
  Result := (FAnnotation as ILocalObject).GetObjectId;
end;

procedure TMapKitMapMarker.Remove;
begin
  if FAnnotation <> nil then
  begin
    SetVisible(False);
    FView.RemoveMapObject(Id);
    if FAnnotationView <> nil then
    begin
      FAnnotationView.prepareForReuse;
      FAnnotationView.release;
    end;
    FAnnotation.release;
    FAnnotation := nil;
  end;
  inherited;
end;

procedure TMapKitMapMarker.SetVisible(const Value: Boolean);
begin
  inherited;
  StateSwitch(FVisible, Value,
    procedure begin
      FView.MKView.addAnnotation((FAnnotation as ILocalObject).GetObjectID);
    end,
    procedure begin
      // MKView can be nil when TMapView is being destroyed
      if FView.MKView <> nil then
        FView.MKView.removeAnnotation((FAnnotation as ILocalObject).GetObjectID);
    end);
end;

function TMapKitMapMarker.AnnotationView: MKAnnotationView;
var
  Pin: MKPinAnnotationView;
  Image: UIImage;
begin
  if FAnnotationView <> nil then
    Exit(FAnnotationView);

  if Descriptor.Icon <> nil then
  begin
    Result := TMKAnnotationView.Wrap(TMKAnnotationView.Alloc.initWithAnnotation((FAnnotation as ILocalObject).GetObjectID,
      nil));
    Image := BitmapToUIImage(Descriptor.Icon);
    Result.setImage(Image);
    Result.setUserInteractionEnabled(Descriptor.Draggable);
    Result.setDraggable(Descriptor.Draggable);
    Result.setCanShowCallout(True);
    Result.setCenterOffset(CGPointMake(Image.size.width * (Descriptor.Origin.X - 0.5),
      - Image.size.height * (Descriptor.Origin.Y - 0.5)));
  end
  else
  begin
    Pin := TMKPinAnnotationView.Wrap(TMKPinAnnotationView.Alloc.initWithAnnotation((FAnnotation as ILocalObject).GetObjectID,
      nil));
    Pin.setUserInteractionEnabled(Descriptor.Draggable);
    Pin.setCanShowCallout(True);
    Pin.setDraggable(Descriptor.Draggable);
    Pin.setUserInteractionEnabled(Descriptor.Draggable);
    Result := Pin;
  end;
  FAnnotationView := Result;
end;

function TMapKitMapMarker.ToString: string;
begin
  Result := Format('%s[Pos:%s;Title:%s,Visible=%s]', [inherited, Descriptor.Position.ToString, Descriptor.Title,
    BoolToStr(Descriptor.Visible, True)]);
end;

{ TMapKitMapCircle }

constructor TMapKitMapCircle.Create(const Descriptor: TMapCircleDescriptor; const View: TMapKitMapView);
begin
  inherited Create(Descriptor);
  FView := View;
  FCircle := TMKCircle.OCClass.circleWithCenterCoordinate(CLLocationCoordinate2D(Descriptor.Center), Descriptor.Radius);
end;

destructor TMapKitMapCircle.Destroy;
begin
  Remove;
  FCircle.release;
  FCircle := nil;
  inherited;
end;

function TMapKitMapCircle.Id: Pointer;
begin
  Result := (FCircle as ILocalObject).GetObjectID;
end;

procedure TMapKitMapCircle.Remove;
begin
  inherited;
  SetVisible(False);
end;

function TMapKitMapCircle.Renderer: MKCircleRenderer;
begin
  Result := TMKCircleRenderer.Wrap(TMKCircleRenderer.Alloc.initWithCircle(FCircle));
  Result.setFillColor(AlphaColorToUIColor(Descriptor.FillColor));
  Result.setStrokeColor(AlphaColorToUIColor(Descriptor.StrokeColor));
  Result.setLineWidth(Descriptor.StrokeWidth / FView.Scale);
end;

procedure TMapKitMapCircle.SetVisible(const Value: Boolean);
begin
  inherited;
  StateSwitch(FVisible, Value,
    procedure begin
      FView.MKView.addOverlay((FCircle as ILocalObject).GetObjectID)
    end,
    procedure begin
      FView.MKView.removeOverlay((FCircle as ILocalObject).GetObjectID);
    end);
end;

function TMapKitMapCircle.ToString: string;
begin
  Result := Format('%s[Center:%3.4f;%3.4f;R:%3.4f]', [inherited, Descriptor.Center.Latitude, Descriptor.Center.Longitude,
    Descriptor.Radius]);
end;

{ TMapKitMapPolygon }

constructor TMapKitMapPolygon.Create(const Descriptor: TMapPolygonDescriptor; const View: TMapKitMapView);
var
  Holes: array of Pointer;
  I: Integer;
begin
  inherited Create(Descriptor);
  FView := View;
  SetLength(Holes, Length(Descriptor.Holes));
  for I := Low(Descriptor.Holes) to High(Descriptor.Holes) do
    Holes[I] := (TMKPolygon.OCClass.polygonWithCoordinatesCount(Descriptor.Holes[I].Points, Length(Descriptor.Holes[I].Points))
      as ILocalObject).GetObjectID;
  FPolygon := TMKPolygon.OCClass.polygonWithCoordinatesCountInteriorPolygons(Descriptor.Outline.Points,
    Length(Descriptor.Outline.Points), TNSArray.Wrap(TNSArray.OCClass.arrayWithObjects(@Holes[0], Length(Holes))));
end;

destructor TMapKitMapPolygon.Destroy;
begin
  Remove;
  FPolygon.release;
  FPolygon := nil;
  inherited;
end;

function TMapKitMapPolygon.Id: Pointer;
begin
  Result := (FPolygon as ILocalObject).GetObjectID;
end;

procedure TMapKitMapPolygon.Remove;
begin
  inherited;
  SetVisible(False);
end;

function TMapKitMapPolygon.Renderer: MKPolygonRenderer;
begin
  Result := TMKPolygonRenderer.Wrap(TMKPolygonRenderer.Alloc.initWithPolygon(FPolygon));
  Result.setFillColor(AlphaColorToUIColor(Descriptor.FillColor));
  Result.setStrokeColor(AlphaColorToUIColor(Descriptor.StrokeColor));
  Result.setLineWidth(Descriptor.StrokeWidth / FView.Scale);
end;

procedure TMapKitMapPolygon.SetVisible(const Value: Boolean);
begin
  inherited;
  StateSwitch(FVisible, Value,
    procedure begin
      FView.MKView.addOverlay((FPolygon as ILocalObject).GetObjectID)
    end,
    procedure begin
      FView.MKView.removeOverlay((FPolygon as ILocalObject).GetObjectID);
    end);
end;

function TMapKitMapPolygon.ToString: string;
begin
  Result := Format('%s[|Points|=%d;|Holes|=%d;Geo=%d]', [inherited, Length(Descriptor.Outline.Points),
    Length(Descriptor.Holes), BoolToStr(Descriptor.Geodesic, True)]);
end;

{ TMapKitMapPolyline }

constructor TMapKitMapPolyline.Create(const Descriptor: TMapPolylineDescriptor; const View: TMapKitMapView);
begin
  inherited Create(Descriptor);
  FView := View;
  FPolyline := TMKPolyline.Wrap(TMKPolyline.OCClass.polylineWithCoordinates(Descriptor.Points.Points,
    Length(Descriptor.Points.Points)));
end;

destructor TMapKitMapPolyline.Destroy;
begin
  Remove;
  FPolyline.release;
  FPolyline := nil;
  inherited;
end;

function TMapKitMapPolyline.Id: Pointer;
begin
  Result := (FPolyline as ILocalObject).GetObjectID;
end;

procedure TMapKitMapPolyline.Remove;
begin
  inherited;
  SetVisible(False);
end;

function TMapKitMapPolyline.Renderer: MKPolylineRenderer;
begin
  Result := TMKPolylineRenderer.Wrap(TMKPolylineRenderer.Alloc.initWithPolyline(FPolyline));
  Result.setStrokeColor(AlphaColorToUIColor(Descriptor.StrokeColor));
  Result.setLineWidth(Descriptor.StrokeWidth / FView.Scale);
end;

procedure TMapKitMapPolyline.SetVisible(const Value: Boolean);
begin
  inherited;
  StateSwitch(FVisible, Value,
    procedure begin
      FView.MKView.addOverlay((FPolyline as ILocalObject).GetObjectID)
    end,
    procedure begin
      FView.MKView.removeOverlay((FPolyline as ILocalObject).GetObjectID);
    end);
end;

function TMapKitMapPolyline.ToString: string;
begin
  Result := Format('%s[|Points|=%d;Geo=%d]', [inherited, Length(Descriptor.Points.Points),
    BoolToStr(Descriptor.Geodesic, True)]);
end;

{ TMapViewGestureDelegate }

constructor TMapViewGestureDelegate.Create(const MapView: TMapKitMapView);
begin
  inherited Create;
  FMapView := MapView;
end;

function TMapViewGestureDelegate.gestureRecognizer(gestureRecognizer: UIGestureRecognizer;
  shouldReceiveTouch: UITouch): Boolean;
begin
  Result := True;
end;

function TMapViewGestureDelegate.gestureRecognizer(gestureRecognizer,
  shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean;
begin
  Result := True;
end;

function TMapViewGestureDelegate.gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean;
begin
  Result := True;
end;

function TMapViewGestureDelegate.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IMapKitMapView);
end;

procedure TMapViewGestureDelegate.HandleTap(gestureRecognizer: UITapGestureRecognizer);
begin
  if gestureRecognizer.state = UIGestureRecognizerStateEnded then
    FMapView.MapEvent(TMapEvent.MapClick(TMapCoordinate(FMapView.MKView.convertPoint(
      gestureRecognizer.locationInView(FMapView.MKView), FMapView.MKView))));
end;

procedure TMapViewGestureDelegate.HandleDoubleTap(gestureRecognizer: UITapGestureRecognizer);
begin
  if gestureRecognizer.state = UIGestureRecognizerStateEnded then
    FMapView.MapEvent(TMapEvent.MapDoubleClick(TMapCoordinate(
      FMapView.MKView.convertPoint(gestureRecognizer.locationInView(FMapView.MKView), FMapView.MKView))));
end;

procedure TMapViewGestureDelegate.HandleLongPress(gestureRecognizer: UILongPressGestureRecognizer);
begin
  case gestureRecognizer.state of
    UIGestureRecognizerStateChanged:
      // cancel long presses that start dragging
      gestureRecognizer.setState(UIGestureRecognizerStateCancelled);
    UIGestureRecognizerStateEnded:
      FMapView.MapEvent(TMapEvent.MapLongClick(TMapCoordinate(FMapView.MKView.convertPoint(
        gestureRecognizer.locationInView(FMapView.MKView), FMapView.MKView))));
  end;
end;

end.
