unit msmDrawArrow;

interface

uses
 Windows
 , Graphics
 , l3Units
 ;

procedure DrawArrow(const AFromPoint: Tl3SPoint; const AToPoint: Tl3SPoint; ACanvas: TCanvas; APolygon: Boolean);

implementation

uses
 Types,
 Math
 ;

procedure DrawArrow(const AFromPoint: Tl3SPoint; const AToPoint: Tl3SPoint; ACanvas: TCanvas; APolygon: Boolean);
const
  cArrowAngle: Single = 25.0;
  cArrowSize: Integer = 15;
var
  ArrowAngleRad: Single;
  LLineAngle: Single;
  RLineAngle: Single;
  LineAngle: Single;
  ArrowPoints: array[0..1] of TPoint;
  PolygonArr: array[0..2] of TPoint;
begin
  ArrowAngleRad := DegToRad(cArrowAngle);

  LineAngle := ArcTan2(AFromPoint.Y - AToPoint.Y, AToPoint.X - AFromPoint.X);

  LLineAngle := -(LineAngle + ArrowAngleRad);
  RLineAngle := -(LineAngle - ArrowAngleRad);

  //ACanvas.MoveTo(AFromPoint.X, AFromPoint.Y);
  //ACanvas.LineTo(AToPoint.X, AToPoint.Y);
  ACanvas.MoveTo(AToPoint.X, AToPoint.Y);

  ArrowPoints[0].X := Round(AToPoint.X - (cArrowSize * Cos(LLineAngle)));
  ArrowPoints[0].Y := Round(AToPoint.Y - (cArrowSize * Sin(LLineAngle)));

  ArrowPoints[1].X := Round(AToPoint.X - (cArrowSize * Cos(RLineAngle)));
  ArrowPoints[1].Y := Round(AToPoint.Y - (cArrowSize * Sin(RLineAngle)));

  if not APolygon then
  begin
    ACanvas.MoveTo(AToPoint.X, AToPoint.Y);
    ACanvas.LineTo(ArrowPoints[0].X, ArrowPoints[0].Y);
    ACanvas.MoveTo(AToPoint.X, AToPoint.Y);
    ACanvas.LineTo(ArrowPoints[1].X, ArrowPoints[1].Y);
  end
  else
  begin
    PolygonArr[0] := Point(AToPoint.X, AToPoint.Y);
    PolygonArr[1] := ArrowPoints[0];
    PolygonArr[2] := ArrowPoints[1];
    ACanvas.Polygon(PolygonArr);
  end;
end;

end.
