unit graphfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_extctrls, vg_layouts,
  Menus;

type
  TForm14 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    TrackBar1: TvgTrackBar;
    PlotGrid1: TvgPlotGrid;
    Label1: TvgLabel;
    Rectangle1: TvgRectangle;
    procedure PlotGrid1Paint(Sender: TObject; const Canvas: TvgCanvas;
      const ARect: TvgRect);
    procedure TrackBar1Change(Sender: TObject);
    procedure PlotGrid1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TvgPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses Math;

{$R *.dfm}

procedure TForm14.PlotGrid1Paint(Sender: TObject; const Canvas: TvgCanvas;
  const ARect: TvgRect);
var
  i: integer;
  x, y: single;
  P: TvgPolygon;
  SaveIndex: cardinal;
begin
  SaveIndex := Canvas.SaveCanvas;
  Canvas.SetClipRects([ARect]);
  { Paint sin }
  SetLength(P, 200);
  for i := 0 to High(P) do
  begin
    // calc only in PlotGrid area
    x := -(PlotGrid1.Width / 2) + ((i / High(P)) * PlotGrid1.Width);
    x := x / PlotGrid1.Frequency;
    // formula here
    y := sin(x);
    P[i] := vgPoint(TvgVisualObject(Sender).Width / 2 + x*PlotGrid1.Frequency, TvgVisualObject(Sender).Height / 2 - y * PlotGrid1.Frequency);
  end;
  Canvas.Stroke.Style := vgBrushSolid;
  Canvas.StrokeThickness := 2;
  Canvas.Stroke.Color := '#FFFF0000';
  Canvas.DrawPolygon(P, 1);
  { Paint cos * x }
  SetLength(P, 500);
  for i := 0 to High(P) do
  begin
    // calc only in PlotGrid area
    x := -(PlotGrid1.Width / 2) + ((i / High(P)) * PlotGrid1.Width);
    x := x / PlotGrid1.Frequency;
    // formula here
    y := cos(x) * x;
    P[i] := vgPoint(TvgVisualObject(Sender).Width / 2 + x*PlotGrid1.Frequency, TvgVisualObject(Sender).Height / 2 - y * PlotGrid1.Frequency);
  end;
  Canvas.Stroke.Style := vgBrushSolid;
  Canvas.StrokeThickness := 2;
  Canvas.Stroke.Color := '#FF00FF00';
  Canvas.DrawPolygon(P, 1);
  { Paint x * x }
  SetLength(P, 100);
  for i := 0 to High(P) do
  begin
    // calc only in PlotGrid area
    x := -(PlotGrid1.Width / 2) + ((i / High(P)) * PlotGrid1.Width);
    x := x / PlotGrid1.Frequency;
    // formula here
    y := x * x;
    P[i] := vgPoint(TvgVisualObject(Sender).Width / 2 + x*PlotGrid1.Frequency, TvgVisualObject(Sender).Height / 2 - y * PlotGrid1.Frequency);
  end;
  Canvas.Stroke.Style := vgBrushSolid;
  Canvas.StrokeThickness := 2;
  Canvas.Stroke.Color := '#FF0000FF';
  Canvas.DrawPolygon(P, 1);
  { End Paint }
  Canvas.RestoreCanvas(SaveIndex);
end;

procedure TForm14.TrackBar1Change(Sender: TObject);
begin
  PlotGrid1.Frequency := Round(TrackBar1.Value);
end;

procedure TForm14.PlotGrid1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TvgPoint; var Handled: Boolean);
begin
  TrackBar1.Value := TrackBar1.Value + (WheelDelta / 120);
  Handled := true;
end;

end.
