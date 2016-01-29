unit pathdatafrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_extctrls, vg_controls;

type
  TForm15 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    PaintRect: TvgRectangle;
    CompoundTrackBar1: TvgCompoundTrackBar;
    Label1: TvgLabel;
    procedure PaintRectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PaintRectMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PaintRectMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y, Dx, Dy: Single);
    procedure PaintRectPaint(Sender: TObject; const Canvas: TvgCanvas;
      const ARect: TvgRect);
  private
    { Private declarations }
    FPress: boolean;
    FSegment: TvgPolygon;
    FLastPoint: TvgPoint;
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

{$R *.dfm}

procedure CurveFromPoint(P0, P1, P2, P3: TvgPoint; var CP1, CP2: TvgPoint);
const
  smooth_value = 1.0;
var
  xc1, yc1, xc2, yc2, xc3, yc3: single;
  len1, len2, len3: single;
  k1, k2: single;
  xm1, ym1, xm2, ym2: single;
begin
  xc1 := (P0.x + P1.x) / 2.0;
  yc1 := (P0.y + P1.y) / 2.0;
  xc2 := (P1.x + P2.x) / 2.0;
  yc2 := (P1.y + P2.y) / 2.0;
  xc3 := (P2.x + P3.x) / 2.0;
  yc3 := (P2.y + P3.y) / 2.0;

  len1 := sqrt((P1.x - P0.x) * (P1.x - P0.x) + (P1.Y - P0.y) * (P1.y - P0.y));
  len2 := sqrt((P2.x - P1.x) * (P2.X - P1.x) + (P2.Y - P1.y) * (P2.y - P1.y));
  len3 := sqrt((P3.x - P2.x) * (P3.x - P2.x) + (P3.Y - P2.y) * (P3.y - P2.y));

  k1 := len1 / (len1 + len2);
  k2 := len2 / (len2 + len3);

  xm1 := xc1 + (xc2 - xc1) * k1;
  ym1 := yc1 + (yc2 - yc1) * k1;

  xm2 := xc2 + (xc3 - xc2) * k2;
  ym2 := yc2 + (yc3 - yc2) * k2;

  // Resulting control points. Here smooth_value is mentioned
  // above coefficient K whose value should be in range [0...1].
  CP1.x := xm1 + (xc2 - xm1) * smooth_value + P1.x - xm1;
  CP1.y := ym1 + (yc2 - ym1) * smooth_value + P1.y - ym1;
  CP2.x := xm2 + (xc2 - xm2) * smooth_value + P2.x - xm2;
  CP2.y := ym2 + (yc2 - ym2) * smooth_value + P2.y - ym2;
end;

procedure TForm15.PaintRectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FPress := true;
  PaintRect.AutoCapture := true;
  SetLength(FSegment, 0);
  FLastPoint := vgPoint(X, Y);
end;

procedure TForm15.PaintRectMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  P: TvgPath;
  CP1, CP2, Pt: TvgPoint;
  i: integer;
begin
  if FPress and (Length(FSegment) > 3) then
  begin
    P := TvgPath.Create(Self);
    P.Parent := PaintRect;
    P.WrapMode := vgPathOriginal;
    P.Align := vaClient;
    P.StrokeThickness := CompoundTrackBar1.Value;
    P.StrokeCap := vgCapRound;
    P.StrokeJoin := vgJoinRound;
    P.Stroke.SolidColor := $FF000000 or random($FFFFFF);
    P.Fill.Style := vgBrushNone;
    P.HitTest := false;
    // add LastPoint
    SetLength(FSegment, Length(FSegment) + 1);
    FSegment[High(FSegment)] := FLAstPoint;
    // correct points to StrokeThickness
    for i := 0 to High(FSegment) do
    begin
      FSegment[i].X := FSegment[i].X - (CompoundTrackBar1.Value / 2);
      FSegment[i].Y := FSegment[i].Y - (CompoundTrackBar1.Value / 2);
    end;
    // add first
    P.Data.MoveTo(FSegment[0]);
    P.Data.LineTo(FSegment[1]);
    // create Path
    i := 2;
    while i < High(FSegment) - 1 do
    begin
      // interpolate Curve
      CurveFromPoint(FSegment[i - 1], FSegment[i], FSegment[i + 1], FSegment[i + 2], CP1, CP2);
      P.Data.CurveTo(CP1, CP2, FSegment[i + 1]);
      Inc(i, 2);
    end;
    // add last
    P.Data.LineTo(FSegment[High(FSegment) - 1]);
//    P.Data.LineTo(FSegment[High(FSegment)]);

    SetLength(FSegment, 0);
  end;
  FPress := false;
end;

procedure TForm15.PaintRectMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y, Dx, Dy: Single);
begin
  if FPress then
  begin
    if (Length(FSegment) > 0) and (vgVectorLength(vgVectorSubtract(vgVector(X, Y), vgVector(FSegment[High(FSegment)]))) < 10) then
    begin
      FLastPoint := vgPoint(X, Y);
    end
    else
    begin
      SetLength(FSegment, Length(FSegment) + 1);
      FSegment[High(FSegment)] := vgPoint(X, Y);
    end;
    // Forece Update
    PaintRect.Repaint;
    // Force Repaint
    Application.ProcessMessages;
  end;
end;

procedure TForm15.PaintRectPaint(Sender: TObject; const Canvas: TvgCanvas;
  const ARect: TvgRect);
var
  S: integer;
begin
  if Length(FSegment) = 0 then Exit;
  { Edit polygon drawing }
  S := Canvas.SaveCanvas;
  Canvas.IntersectClipRect(vgRect(1, 1, PaintRect.Width - 1, PaintRect.Height - 1));

  Canvas.StrokeThickness := 1;
  Canvas.Stroke.Style := vgBrushSolid;
  Canvas.Stroke.Color := '#FF1d7e96';
  Canvas.StrokeCap := vgCapRound;
  Canvas.StrokeJoin := vgJoinRound;
  Canvas.DrawPolygon(FSegment, 1);

  Canvas.RestoreCanvas(S);
end;

end.
