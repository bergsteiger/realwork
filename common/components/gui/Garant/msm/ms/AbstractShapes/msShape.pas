﻿unit msShape;

interface

uses
 FMX.Graphics,
 System.Types,
 FMX.Types,
 System.UITypes,
 msCoreObjects,
 msSerializeInterfaces,
 msInterfacedRefcounted,
 msInterfaces,
 System.Classes,
 msDiagrammsList,
 Data.DBXJSONReflect
 ;

type
 TmsShape = class abstract(TmsDiagrammsList, ImsShape)
 strict private
  [JSONMarshalled(False)]
  f_ShapeClass : ImsShapeClass;
  f_ShapeClassName : String;
  // - тут дублирование данных, но исключительно из-за кривизны маршалинга
  f_Name : String;
  f_UID: TmsShapeUID;
 private
  function DrawOptionsContext(const aCtx: TmsDrawContext): TmsDrawOptionsContext;
 strict protected
  function pm_GetStartPoint: TPointF; virtual;
  function pm_GetFinishPoint: TPointF; virtual;
 public
  class function AngleBetween(const aStart: TPointF; const aFinish: TPointF): Single;
 strict protected
  function TransformFinishPoint(anAngle: Single): TPointF; virtual;
  function pm_GetShapeClass: ImsShapeClass; virtual;
  property ShapeClass: ImsShapeClass
   read pm_GetShapeClass;
  constructor CreateInner(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext); virtual;
  procedure SetStartPoint(const aStartPoint: TPointF); virtual;
 protected
  procedure DoDrawTo(const aCtx: TmsDrawContext); virtual;
  function IsNeedsSecondClick : Boolean; virtual;
  function EndTo(const aCtx: TmsEndShapeContext): Boolean; virtual;
  procedure MoveBy(const aCtx: TmsMoveContext); virtual;
  function HitTest(const aPoint: TPointF; out theShape: ImsShape): Boolean; virtual;
  function ContainsPt(const aPoint: TPointF): Boolean; virtual;
  procedure SaveTo(const aFileName: String); override;
  procedure LoadFrom(const aFileName: String); override;
  function MouseUp(const aClickContext: TmsEndShapeContext): Boolean; virtual;
  procedure MouseMove(const aClickContext: TmsEndShapeContext); virtual;
  // - действие при MouseMove
  function UID: TmsShapeUID;
  function Name: String;
  function Stereotype: String;
  function Polygon: TPolygon;
  function GetPolygon: TPolygon; virtual;
 protected
  class function Create(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext): ImsShape; overload; virtual;
 public
  class function Create(const aShapeClass : ImsShapeClass; const aStartPoint: TPointF): ImsShape; overload;
  // - фабричный метод, который создаёт экземпляр класса как интерфейс
  //   про "фабричный метод вообще" - написано тут:
  //   - http://icoder.ucoz.ru/blog/factory_method/2013-04-30-24
  //   - http://ru.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B1%D1%80%D0%B8%D1%87%D0%BD%D1%8B%D0%B9_%D0%BC%D0%B5%D1%82%D0%BE%D0%B4_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
  //   - http://sergeyteplyakov.blogspot.ru/2014/07/blog-post.html
  //
  // Зачем НУЖЕН "наш конкретный" фабричный метод?
  // Во-первых - чтобы ПЕРЕОПРЕДЕЛИТЬ бизнес-логику. Как например в TmsMover.Make.
  // И это - ГЛАВНОЕ.
  // А во-вторых потому что:
  // - http://18delphi.blogspot.ru/2013/04/blog-post_7483.html
  // - http://www.gunsmoker.ru/2013/04/plugins-9.html
  //
  // И это "не так важно" как ВО_ПЕРВЫХ, но тоже - ОЧЕНЬ ВАЖНО.
  class function Create(const aStartPoint: TPointF): ImsShape; overload;
  class function Create: ImsShape; overload;
 public
  class function DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean; virtual;
  function NullClick(const aHolder: ImsDiagrammsHolder): Boolean; virtual;
  // - обрабатывает "нулевой клик"
 protected
  function ClickInDiagramm: Boolean; virtual;
  // - ткнули в примитив внутри диаграммы
  function GetDrawBounds: TRectF; virtual;
  function DrawBounds: TRectF;
  procedure GetStereotypeRect(var aRect: TRectF);
  procedure Cleanup; override;
 public
  class function IsLineLike: Boolean; virtual;
  class function IsConnectorLike: Boolean; virtual;
  procedure DrawTo(const aCtx: TmsDrawContext); virtual;
  property StartPoint : TPointF
   read pm_GetStartPoint;
  property FinishPoint : TPointF
   read pm_GetFinishPoint;
  class function IsTool: Boolean; virtual;
  class function IsNullClick: Boolean; virtual;
  //- примитив НЕ ТРЕБУЕТ кликов. ВООБЩЕ. Как TmsSwapParents или TmsUpToParent
  procedure Assign(anOther : TmsShape);
  class function ButtonShape: ImsShape; virtual;
  class function NRTMC: ImsShapeClassTuner;
  class function MC: ImsShapeClass;
  class function TMC: ImsShapeClassTuner;
  class function Specify(const aName: String): ImsShapeClassTuner;
 end;//TmsShape

 RmsShape = class of TmsShape;

 MCmsShape = ImsShapeClass;

implementation

uses
 System.SysUtils,
 msShapeMarshal,
 System.Math.Vectors,
 msRegisteredShapes,
 msNotRegisteredShapes,
 FMX.DUnit.msAppLog,

 msShapeClass,
 msProxyShapeClass,
 msTotalShapesList,
 Math
 ;

// TmsShape

procedure TmsShape.Cleanup;
begin
 TmsTotalShapesList.ShapeDestroyed(Self);
 inherited;
end;

class function TmsShape.Create(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext): ImsShape;
begin
 Result := CreateInner(aShapeClass, aCtx);
 //TmsAppLog.Instance.ToLog('Create object ' + self.ClassName);
end;

class function TmsShape.Create(const aShapeClass : ImsShapeClass; const aStartPoint: TPointF): ImsShape;
begin
 Result := CreateInner(aShapeClass, TmsMakeShapeContext.Create(aStartPoint, nil, nil));
end;

class function TmsShape.Create(const aStartPoint: TPointF): ImsShape;
begin
 Result := Create(Self.MC, aStartPoint);
end;

class function TmsShape.Create: ImsShape;
begin
 Result := Create(TPointF.Create(0, 0));
end;

function TmsShape.HitTest(const aPoint: TPointF; out theShape: ImsShape): Boolean;
begin
 Result := ContainsPt(aPoint);
 if Result then
  theShape := Self;
end;

function TmsShape.ContainsPt(const aPoint: TPointF): Boolean;
var
 l_V : ImsShapeView;
begin
 l_V := ShapeClass.ShapeView;
 if (l_V <> nil) then
  Result := l_V.ShapeContainsPt(Self, aPoint)
 else
  Result := DrawBounds.Contains(aPoint);
end;

constructor TmsShape.CreateInner(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext);
begin
 Assert(aShapeClass <> nil);
 f_ShapeClass := aShapeClass;
 f_ShapeClassName := f_ShapeClass.Name;
 Assert(f_ShapeClassName <> '');
 f_Name := f_ShapeClassName;
 f_UID := 0;
 if (aCtx.rShapesController <> nil) then
  f_Name := f_Name + IntToStr(aCtx.rShapesController.ShapeCount + 1);
 if (aCtx.rDiagrammsHolder <> nil) then
  f_UID := aCtx.rDiagrammsHolder.GenerateUID(Self);
 inherited Create;
 SetStartPoint(aCtx.rStartPoint);
end;

function TmsShape.EndTo(const aCtx: TmsEndShapeContext): Boolean;
begin
 Result := true;
 Assert(false, 'Примитив ' + ClassName + ' не может быть завершён');
end;

procedure TmsShape.MouseMove(const aClickContext: TmsEndShapeContext);
begin
 // Ничего не делаем, специально
end;

function TmsShape.UID: TmsShapeUID;
begin
 Result := f_UID;
end;

function TmsShape.Name: String;
begin
 Result := f_Name;
end;

function TmsShape.Stereotype: String;
begin
 Result := Self.ShapeClass.Stereotype;
 Result := '<< ' + Result + ' >>';
end;

function TmsShape.Polygon: TPolygon;
begin
 Result := GetPolygon;
 Assert(Length(Result) >= 3);
end;

function TmsShape.GetPolygon: TPolygon;
var
 l_R : TRectF;
begin
 l_R := Self.DrawBounds;
 SetLength(Result, 5);
 Result[0] := l_R.TopLeft;
 Result[1] := TPointF.Create(l_R.Left + l_R.Width, l_R.Top);
 Result[2] := l_R.BottomRight;
 Result[3] := TPointF.Create(l_R.Left, l_R.Bottom);
 Result[4] := Result[0];
end;

procedure TmsShape.MoveBy(const aCtx: TmsMoveContext);
begin
 SetStartPoint(StartPoint + aCtx.rDelta);
end;

function TmsShape.MouseUp(const aClickContext: TmsEndShapeContext): Boolean;
begin
 Result := false;
 // - специально ничего не делаем
end;

procedure TmsShape.DoDrawTo(const aCtx: TmsDrawContext);
var
 l_V : ImsShapeView;
begin
 l_V := ShapeClass.ShapeView;
 if (l_V <> nil) then
  l_V.DrawShape(aCtx, Self);
end;

function TmsShape.IsNeedsSecondClick : Boolean;
begin
 Result := false;
end;

function TmsShape.pm_GetStartPoint: TPointF;
begin
 Result := TPointF.Create(0, 0);
 Assert(false, 'Abstract method');
end;

function TmsShape.pm_GetFinishPoint: TPointF;
begin
 Result := Self.StartPoint;
end;

class function TmsShape.AngleBetween(const aStart: TPointF; const aFinish: TPointF): Single;
var
 l_ALength, l_CLength,
 l_AlphaAngle,
 l_X, l_Y, l_RotationAngle : Single;
 l_PointC : TPointF;
 l_Invert : SmallInt;
begin
 // Формула расчета растояний между двумя точками
 l_X := (aFinish.X - aStart.X) * (aFinish.X - aStart.X);
 l_Y := (aFinish.Y - aStart.Y) * (aFinish.Y - aStart.Y);

 l_CLength := sqrt( l_X + l_Y);

 l_PointC := TPointF.Create(aFinish.X, aStart.Y);

 // Формула расчета растояний между двумя точками
 l_X := (l_PointC.X - aStart.X) * (l_PointC.X - aStart.X);
 l_Y := (l_PointC.Y - aStart.Y) * (l_PointC.Y - aStart.Y);

 l_ALength := sqrt(l_X + l_Y);

 // In Radian
 l_AlphaAngle := ArcSin(l_ALength / l_CLength);

 l_Invert := 1;

  if (aFinish.X > aStart.X) then
  begin
   l_RotationAngle := Pi / 2 * 3;
   if (aFinish.Y > aStart.Y) then
    l_Invert := -1;
  end//aFinish.X > aStart.X
  else
  begin
   l_RotationAngle := Pi / 2;
   if (aFinish.Y < aStart.Y) then
    l_Invert := -1;
  end;//aFinish.X > aStart.X

 Result := l_Invert * (l_AlphaAngle + l_RotationAngle);
end;

function TmsShape.TransformFinishPoint(anAngle: Single): TPointF;
begin
 Result := Self.StartPoint;
end;

function TmsShape.pm_GetShapeClass: ImsShapeClass;
begin
 if (f_ShapeClass = nil) then
  f_ShapeClass := TmsRegisteredShapes.Instance.ByName(f_ShapeClassName);
 Result := f_ShapeClass;
 Assert(Result <> nil);
end;

procedure TmsShape.SetStartPoint(const aStartPoint: TPointF);
begin
 Assert(false, 'Abstract method');
end;

function TmsShape.DrawOptionsContext(const aCtx: TmsDrawContext): TmsDrawOptionsContext;
begin
 Result := TmsDrawOptionsContext.Create(aCtx);
 Self.ShapeClass.TransformDrawOptionsContext(Result);
end;

class function TmsShape.IsTool: Boolean;
begin
 Result := false;
end;

class function TmsShape.IsLineLike: Boolean;
begin
 Result := false;
end;

class function TmsShape.IsConnectorLike: Boolean;
begin
 Result := false;
end;

class function TmsShape.IsNullClick: Boolean;
begin
 Result := false;
end;

class function TmsShape.DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean;
// - обрабатывает "нулевой клик"
begin
 Result := false;
end;

function TmsShape.NullClick(const aHolder: ImsDiagrammsHolder): Boolean;
begin
 Result := DoNullClick(aHolder);
end;

function TmsShape.ClickInDiagramm: Boolean;
begin
 Result := false;
end;

function TmsShape.GetDrawBounds: TRectF;
begin
 Result := TRectF.Create(TPointF.Create(StartPoint.X - ShapeClass.InitialWidth / 2, StartPoint.Y - ShapeClass.InitialHeight / 2),
                         TPointF.Create(StartPoint.X + ShapeClass.InitialWidth / 2, StartPoint.Y + ShapeClass.InitialHeight / 2));
end;

function TmsShape.DrawBounds: TRectF;
var
 l_Tmp : Single;
begin
 Result := GetDrawBounds;
 if (Self.ShapeClass.ArrowHeadShapeMC <> nil) then
 begin
  if SameValue(Result.Left, Result.Right) then
  begin
   Result.Right := Result.Left + Self.ShapeClass.ArrowHeadShapeMC.InitialHeight;
   Result.Left := Result.Left - Self.ShapeClass.ArrowHeadShapeMC.InitialHeight;
  end;//SameValue(Result.Left, Result.Right)
  if SameValue(Result.Top, Result.Bottom) then
  begin
   Result.Bottom := Result.Top + Self.ShapeClass.ArrowHeadShapeMC.InitialHeight;
   Result.Top := Result.Top - Self.ShapeClass.ArrowHeadShapeMC.InitialHeight;
  end;//SameValue(Result.Top, Result.Bottom)
 end;//Self.ShapeClass.ArrowHeadShapeMC <> nil
 if (Result.Top > Result.Bottom) then
 begin
  l_Tmp := Result.Bottom;
  Result.Bottom := Result.Top;
  Result.Top := l_Tmp;
 end;//Result.Top > Result.Bottom
 if (Result.Left > Result.Right) then
 begin
  l_Tmp := Result.Right;
  Result.Right := Result.Left;
  Result.Left := l_Tmp;
 end;//Result.Left > Result.Right
end;

procedure TmsShape.GetStereotypeRect(var aRect: TRectF);
var
 l_StereotypePlace: TmsStereotypePlace;
begin
 l_StereotypePlace := Self.ShapeClass.StereotypePlace;
 if (l_StereotypePlace = TmsStereotypePlace.None) then
  Exit;
 aRect := Self.DrawBounds;
 case l_StereotypePlace of
  TmsStereotypePlace.Center:
   ;
  TmsStereotypePlace.Bottom:
   aRect := TRectF.Create(aRect.Left - 20, aRect.Bottom, aRect.Right + 20, aRect.Bottom + 20);
  TmsStereotypePlace.OneThirty:
   aRect := TRectF.Create(aRect.Left, aRect.Top, aRect.Right, aRect.Top + aRect.Height / 3);
  else
   Assert(false);
 end;//case l_StereotypePlace
end;

procedure TmsShape.DrawTo(const aCtx: TmsDrawContext);
const
 cNameDelta = 20;
var
 l_Ctx : TmsDrawOptionsContext;
 l_DrawContext : TmsDrawContext;
 l_StereotypeRect : TRectF;
var
 l_R: TRectF;
 l_AL : TmsAdditionalLineCoeff;
 l_C : Single;
var
 l_Proxy : ImsShape;
 l_OriginalMatrix: TMatrix;
 l_Matrix: TMatrix;
 l_Angle : Single;
 l_CenterPoint,
 l_LineFinishPoint : TPointF;
begin
 l_Ctx := DrawOptionsContext(aCtx);
 aCtx.rCanvas.Fill.Color := l_Ctx.rFillColor;
 aCtx.rCanvas.Stroke.Dash := l_Ctx.rStrokeDash;
 aCtx.rCanvas.Stroke.Color := l_Ctx.rStrokeColor;
 aCtx.rCanvas.Stroke.Thickness := l_Ctx.rStrokeThickness;

  // for Android Lines
 aCtx.rCanvas.Stroke.Kind := TBrushKind.Solid;
 aCtx.rCanvas.Fill.Kind := TBrushKind.Solid;

 l_DrawContext := aCtx;
 l_DrawContext.rOpacity := l_Ctx.rOpacity;
 l_DrawContext.rLineOpacity := l_Ctx.rLineOpacity;

 DoDrawTo(l_DrawContext);

 if (Self.ShapeClass.ArrowHeadShapeMC <> nil) then
 begin
  if (Self.StartPoint <> Self.FinishPoint) then
  begin
   l_OriginalMatrix := aCtx.rCanvas.Matrix;
   try
    l_LineFinishPoint := TPointF.Create(Self.FinishPoint.X - Self.ShapeClass.ArrowHeadShapeMC.InitialHeight / 2,
                                        Self.FinishPoint.Y);
    l_Proxy := Self.ShapeClass.ArrowHeadShapeMC.CreateShape(l_LineFinishPoint);
    try
     // in Radian
     l_Angle := TmsShape.AngleBetween(Self.StartPoint, Self.FinishPoint);

     l_CenterPoint := Self.FinishPoint;

     l_Matrix := TMatrix.Identity;
     // - СНИМАЕМ оригинальную матрицу, точнее берём ЕДИНИЧНУЮ матрицу
     // https://ru.wikipedia.org/wiki/%D0%95%D0%B4%D0%B8%D0%BD%D0%B8%D1%87%D0%BD%D0%B0%D1%8F_%D0%BC%D0%B0%D1%82%D1%80%D0%B8%D1%86%D0%B0
     l_Matrix := l_Matrix * TMatrix.CreateTranslation(-l_CenterPoint.X, -l_CenterPoint.Y);

     // - задаём точку, вокруг которой вертим
     l_Matrix := l_Matrix * TMatrix.CreateRotation(l_Angle);

     // - задаём угол поворота
     l_Matrix := l_Matrix * TMatrix.CreateTranslation(l_CenterPoint.X, l_CenterPoint.Y);

     // - задаём начало координат
     l_Matrix := l_Matrix * l_OriginalMatrix;

     // - ПРИМЕНЯЕМ оригинальную матрицу
     // Иначе например ОРИГИНАЛЬНЫЙ параллельный перенос - не будет работать.
     // https://ru.wikipedia.org/wiki/%D0%9F%D0%B0%D1%80%D0%B0%D0%BB%D0%BB%D0%B5%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9_%D0%BF%D0%B5%D1%80%D0%B5%D0%BD%D0%BE%D1%81

     aCtx.rCanvas.SetMatrix(l_Matrix);
     // - применяем нашу "комплексную" матрицу

     l_Proxy.DrawTo(aCtx);
     // - отрисовываем примитив с учётом матрицы преобразований
    finally
     l_Proxy := nil;
    end;//try..finally
   finally
     aCtx.rCanvas.SetMatrix(l_OriginalMatrix);
   // - восстанавливаем ОРИГИНАЛЬНУЮ матрицу
   end;//try..finally
  end;//Self.StartPoint <> Self.FinishPoint
 end;//Self.ShapeClass.ArrowHeadShapeMC <> nil

 l_AL := ShapeClass.AdditionalLinesH;
 if (Length(l_AL) > 0) then
 begin
  l_R := DrawBounds;
  for l_C in l_AL do
   aCtx.rCanvas.DrawLine(TPointF.Create(l_R.Left, l_R.Top + l_R.Height * l_C),
                         TPointF.Create(l_R.Right, l_R.Top + l_R.Height * l_C), aCtx.rLineOpacity);
 end;//Length(l_AL) > 0

 l_StereotypeRect := TRectF.Create(0, 0, 0, 0);
 GetStereotypeRect(l_StereotypeRect);
 if (l_StereotypeRect.TopLeft <> l_StereotypeRect.BottomRight) then
 begin
  if (l_StereotypeRect.Height < 10) then
  begin
   l_StereotypeRect.Top := l_StereotypeRect.Top - 10;
   l_StereotypeRect.Bottom := l_StereotypeRect.Bottom + 10;
  end;//l_StereotypeRect.Height < 10
  l_StereotypeRect.Left := l_StereotypeRect.Left - 100;
  l_StereotypeRect.Right := l_StereotypeRect.Right + 100;
  aCtx.rCanvas.Fill.Color := aCtx.rCanvas.Stroke.Color;
  aCtx.rCanvas.FillText(l_StereotypeRect,
                        Self.Stereotype,
                        false,
                        aCtx.rLineOpacity,
                        [],
                        TTextAlign.Center,
                        TTextAlign.Center);

  if (Self.Name <> '') then
  begin
   l_StereotypeRect.Top := l_StereotypeRect.Top + cNameDelta;
   l_StereotypeRect.Bottom := l_StereotypeRect.Bottom + cNameDelta;
   aCtx.rCanvas.FillText(l_StereotypeRect,
                         Self.Name,
                         false,
                         aCtx.rLineOpacity,
                         [],
                         TTextAlign.Center,
                         TTextAlign.Center);
  end;//Self.Name <> ''
 end;//l_StereotypeRect.TopLeft <> l_StereotypeRect.BottomRight
end;

procedure TmsShape.SaveTo(const aFileName: String);
begin
 TmsShapeMarshal.Serialize(aFileName, Self);
end;

procedure TmsShape.LoadFrom(const aFileName: String);
begin
 TmsShapeMarshal.DeSerialize(aFileName, Self);
end;

procedure TmsShape.Assign(anOther : TmsShape);
begin
 inherited Assign(anOther);
 Assert(false, 'Не реализовано');
end;

class function TmsShape.ButtonShape: ImsShape;
begin
 Result := nil;
 Assert(false, 'Не реализовано');
end;

class function TmsShape.NRTMC: ImsShapeClassTuner;
var
 l_R : ImsShapeClass;
begin
 l_R := TmsRegisteredShapes.Instance.ByName(Self.ClassName);
 if (l_R = nil) then
  l_R := TmsNotRegisteredShapes.Instance.ByName(Self.ClassName);
 if (l_R <> nil) then
 begin
  Result := l_R.AsTuner;
 end//l_R <> nil
 else
 begin
  Result := TmsShapeClass.Create(Self);
  TmsNotRegisteredShapes.Instance.RegisterMC(Result.AsMC);
 end;//Result = nil
end;

class function TmsShape.MC: ImsShapeClass;
begin
 Result := NRTMC.AsMC;
end;

class function TmsShape.TMC: ImsShapeClassTuner;
var
 l_MC : ImsShapeClass;
begin
 l_MC := TmsRegisteredShapes.Instance.ByName(Self.ClassName);
 if (l_MC <> nil) then
  Result := l_MC.AsTuner
 else
 begin
  Result := TmsShapeClass.Create(Self);
  TmsRegisteredShapes.Instance.RegisterMC(Result.AsMC);
 end;//l_MC <> nil
end;

class function TmsShape.Specify(const aName: String): ImsShapeClassTuner;
begin
 Result := Self.MC.Specify(aName);
end;

end.
