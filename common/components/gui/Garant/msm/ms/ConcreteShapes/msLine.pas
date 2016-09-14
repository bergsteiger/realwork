unit msLine;

interface

uses
 msShape,
 FMX.Graphics,
 System.Types,
 SysUtils,
 msInterfaces,
 msPointedShape
 ;

type
 TmsLine = class(TmsPointedShape)
 private
  f_FinishPoint: TPointF;
 protected
  constructor CreateInner(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext); override;
  class function IsLineLike: Boolean; override;
  function GetDrawBounds: TRectF; override;
  function ContainsPt(const aPoint: TPointF): Boolean; override;
  class function SamePoint(const A: TPointF; const B: TPointF): Boolean;
  function pm_GetFinishPoint: TPointF; override;
  property FinishPoint : TPointF
   read pm_GetFinishPoint
   write f_FinishPoint;
  procedure MoveBy(const aCtx: TmsMoveContext); override;
 public
  function IsNeedsSecondClick : Boolean; override;
  function EndTo(const aCtx: TmsEndShapeContext): Boolean; override;
  class function CreateCompleted(const aStartPoint: TPointF;
                                 const aFinishPoint: TPointF;
                                 const aShapesController: ImsShapesController;
                                 const aDiagrammsHolder: ImsDiagrammsHolder): ImsShape;
 end;//TmsLine

implementation

uses
 msShapeClass
 ;

constructor TmsLine.CreateInner(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext);
begin
 inherited;
 FinishPoint := aCtx.rStartPoint;
end;

class function TmsLine.IsLineLike: Boolean;
begin
 Result := true;
end;

function TmsLine.GetDrawBounds: TRectF;
begin
 Result := TRectF.Create(StartPoint, FinishPoint);
end;

class function TmsLine.SamePoint(const A: TPointF; const B: TPointF): Boolean;
const
 cEpsilon = 5;
begin
 Result := (Abs(A.X - B.X) <= cEpsilon) AND (Abs(A.Y - B.Y) <= cEpsilon);
end;

function TmsLine.pm_GetFinishPoint: TPointF;
begin
 Result := f_FinishPoint;
end;

function TmsLine.ContainsPt(const aPoint: TPointF): Boolean;
// https://bitbucket.org/ingword/mindstream/issue/3/tmsline-tmsmover
(*
http://algolist.manual.ru/maths/geom/datastruct.php

enum {LEFT,  RIGHT,  BEYOND,  BEHIND, BETWEEN, ORIGIN, DESTINATION};
//    �����, ������, �������, ������, �����,   ������, �����

int Point::classify(Point &p0, Point &pl)
{
  Point p2 = *this;
  Point a = p1 - pO;
  Point b = p2 - pO;
  double sa = a. x * b.y - b.x * a.y;
  if (sa > 0.0)
    return LEFT;
  if (sa < 0.0)
    return RIGHT;
  if ((a.x * b.x < 0.0) || (a.y * b.y < 0.0))
    return BEHIND;
  if (a.length() < b.length())
    return BEYOND;
  if (pO == p2)
    return ORIGIN;
  if (p1 == p2)
    return DESTINATION;
  return BETWEEN;
}
*)
begin
 //Result := inherited;
 Result := SamePoint(Self.StartPoint, aPoint) OR SamePoint(Self.FinishPoint, aPoint);
end;

function TmsLine.EndTo(const aCtx: TmsEndShapeContext): Boolean;
begin
 Result := true;
 FinishPoint := aCtx.rStartPoint;
end;

procedure TmsLine.MoveBy(const aCtx: TmsMoveContext);
begin
 if SamePoint(Self.StartPoint, aCtx.rStartPoint) then
  Self.SetStartPoint(Self.StartPoint + aCtx.rDelta)
 else
 if SamePoint(Self.FinishPoint, aCtx.rStartPoint) then
  Self.FinishPoint := Self.FinishPoint + aCtx.rDelta
end;

class function TmsLine.CreateCompleted(const aStartPoint: TPointF;
                                       const aFinishPoint: TPointF;
                                       const aShapesController: ImsShapesController;
                                       const aDiagrammsHolder: ImsDiagrammsHolder): ImsShape;
begin
 Result := Self.Create(Self.MC, TmsMakeShapeContext.Create(aStartPoint, aShapesController, aDiagrammsHolder));
 Result.EndTo(TmsEndShapeContext.Create(aFinishPoint, aShapesController, aDiagrammsHolder));
end;

function TmsLine.IsNeedsSecondClick: Boolean;
begin
 Result := true;
end;

end.
