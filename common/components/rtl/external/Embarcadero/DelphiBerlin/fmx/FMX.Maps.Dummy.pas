{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Maps.Dummy;

interface

{$SCOPEDENUMS ON}

uses
  FMX.Maps;

type
  TDummyMapService = class(TInterfacedObject, IFMXMapService)
    function CreateMapView: ICustomMapView;
    procedure DestroyMapView(const MapView: ICustomMapView);
    procedure RealignMapViews;
  end;

  TDummyMapView = class(TMapViewBase, ICustomMapView)
  private
    { Camera }
    FTilt: Single;
    FBearing: Single;
    FZoom: Single;
    FLocation: TMapCoordinate;
  public
    constructor Create;
    procedure SetHostControl(const Host: TCustomMapView);
    procedure UpdateContentFromControl;

    procedure DestroyView;
    procedure UpdateNativeBounds;
    procedure Hide;
    procedure Show;

    procedure AnimateToCameraPosition;
    procedure SyncCameraPosition;

    procedure SetLocation(const ACoordinate: TMapCoordinate);
    function GetLocation: TMapCoordinate;

    procedure SetZoom(const Zoom: Single);
    function GetZoom: Single;
    procedure SetBearing(const Bearing: Single);
    function GetBearing: Single;
    procedure SetTilt(const Tilt: Single);
    function GetTilt: Single;
    procedure SetMapType(const AValue: TMapType);
  end;

procedure RegisterMapService;

implementation

uses
  FMX.Platform;

var
  MapService: TDummyMapService;

procedure RegisterMapService;
begin
  MapService := TDummyMapService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXMapService, MapService);
end;


{ TDummyMapService }

function TDummyMapService.CreateMapView: ICustomMapView;
begin
  Result := TDummyMapView.Create;
end;

procedure TDummyMapService.DestroyMapView(const MapView: ICustomMapView);
begin
end;

procedure TDummyMapService.RealignMapViews;
begin
end;

{ TDummyMapView }

procedure TDummyMapView.AnimateToCameraPosition;
begin
end;

constructor TDummyMapView.Create;
begin
end;

procedure TDummyMapView.DestroyView;
begin
end;

function TDummyMapView.GetBearing: Single;
begin
  Result := FBearing;
end;

function TDummyMapView.GetLocation: TMapCoordinate;
begin
  Result := FLocation;
end;

function TDummyMapView.GetTilt: Single;
begin
  Result := FTilt;
end;

function TDummyMapView.GetZoom: Single;
begin
  Result := FZoom;
end;

procedure TDummyMapView.Hide;
begin
end;

procedure TDummyMapView.SetBearing(const Bearing: Single);
begin
  FBearing := Bearing;
end;

procedure TDummyMapView.SetHostControl(const Host: TCustomMapView);
begin
end;

procedure TDummyMapView.SetLocation(const ACoordinate: TMapCoordinate);
begin
  FLocation := ACoordinate;
end;

procedure TDummyMapView.SetMapType(const AValue: TMapType);
begin
end;

procedure TDummyMapView.SetTilt(const Tilt: Single);
begin
  FTilt := Tilt;
end;

procedure TDummyMapView.SetZoom(const Zoom: Single);
begin
  FZoom := Zoom;
end;

procedure TDummyMapView.Show;
begin
end;

procedure TDummyMapView.SyncCameraPosition;
begin
end;

procedure TDummyMapView.UpdateContentFromControl;
begin
end;

procedure TDummyMapView.UpdateNativeBounds;
begin
end;

end.
