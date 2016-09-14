unit msProxyShape;

interface

uses
 System.Types,
 Generics.Collections,
 msInterfaces,
 msShape,
 msPointlessShape
 ;

type
 TmsProxyShapePrim = class abstract(TmsPointlessShape)
 // [��������� (������ ��������������)|https://ru.wikipedia.org/wiki/%D0%94%D0%B5%D0%BA%D0%BE%D1%80%D0%B0%D1%82%D0%BE%D1%80_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)]
 protected
  procedure DoDrawTo(const aCtx: TmsDrawContext); override;
  function GetDrawBounds: TRectF; override;
  function pm_GetStartPoint: TPointF; override;
  function HitTest(const aPoint: TPointF; out theShape: ImsShape): Boolean; override;
  procedure MoveBy(const aCtx: TmsMoveContext); override;
  function ShapeToShow: ImsShape; virtual; abstract;
 end;//TmsProxyShapePrim

 TmsProxyShape = class(TmsProxyShapePrim)
 private
  f_Shape : ImsShape;
 protected
  function ShapeToShow: ImsShape; override;
  constructor CreateInner(const aShapeClass : ImsShapeClass; const aShape: ImsShape); reintroduce;
 public
  class function Create(const aShape: ImsShape): ImsShape;
  procedure Cleanup; override;
 end;//TmsProxyShape

 TmsWeakProxyShape = class(TmsProxyShapePrim)
 private
  f_Shape : TmsWeakShapeRef;
 protected
  function ShapeToShow: ImsShape; override;
  constructor CreateInner(const aShapeClass : ImsShapeClass; const aShape: ImsShape); reintroduce;
 public
  class function Create(const aShape: ImsShape): ImsShape;
  procedure Cleanup; override;
 end;//TmsWeakProxyShape

implementation

uses
 System.SysUtils,
 System.Math,

 msShapeClass
 ;

// TmsProxyShape

class function TmsProxyShape.Create(const aShape: ImsShape): ImsShape;
begin
 Result := CreateInner(Self.MC, aShape);
end;

constructor TmsProxyShape.CreateInner(const aShapeClass : ImsShapeClass; const aShape: ImsShape);
begin
 Assert(aShape <> nil, '������ ������ ���������� ����� ���������');
 inherited CreateInner(aShapeClass, TmsMakeShapeContext.Create(TPointF.Create(0, 0), nil, nil));
 f_Shape := aShape;
end;

function TmsProxyShape.ShapeToShow: ImsShape;
begin
 Result := f_Shape;
end;

procedure TmsProxyShape.Cleanup;
begin
 f_Shape := nil;
 inherited;
end;

// TmsWeakProxyShape

class function TmsWeakProxyShape.Create(const aShape: ImsShape): ImsShape;
begin
 Result := CreateInner(Self.MC, aShape);
end;

constructor TmsWeakProxyShape.CreateInner(const aShapeClass : ImsShapeClass; const aShape: ImsShape);
begin
 Assert(aShape <> nil, '������ ������ ���������� ����� ���������');
 inherited CreateInner(aShapeClass, TmsMakeShapeContext.Create(TPointF.Create(0, 0), nil, nil));
 f_Shape := aShape;
end;

function TmsWeakProxyShape.ShapeToShow: ImsShape;
begin
 Result := f_Shape;
end;

procedure TmsWeakProxyShape.Cleanup;
begin
 f_Shape := nil;
 inherited;
end;

// TmsProxyShapePrim

procedure TmsProxyShapePrim.DoDrawTo(const aCtx: TmsDrawContext);
begin
 Assert(ShapeToShow <> nil);
 ShapeToShow.DrawTo(aCtx);
end;

function TmsProxyShapePrim.GetDrawBounds: TRectF;
begin
 Assert(ShapeToShow <> nil);
 Result := ShapeToShow.DrawBounds;
end;

function TmsProxyShapePrim.pm_GetStartPoint: TPointF;
(*var
 l_R : TRectF;*)
begin
 Result := ShapeToShow.StartPoint;
(* l_R := Self.DrawBounds;
 Result := (l_R.TopLeft + l_R.BottomRight) / 2;*)
end;

function TmsProxyShapePrim.HitTest(const aPoint: TPointF; out theShape: ImsShape): Boolean;
begin
 Assert(ShapeToShow <> nil);
 Result := ShapeToShow.HitTest(aPoint, theShape);
 if Result then
  theShape := Self;
end;

procedure TmsProxyShapePrim.MoveBy(const aCtx: TmsMoveContext);
begin
 Assert(ShapeToShow <> nil);
 ShapeToShow.MoveBy(aCtx);
end;

end.
