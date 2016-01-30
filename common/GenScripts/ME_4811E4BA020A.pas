unit nevBaseDrawView;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevBaseDrawView.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBaseView
 , nevTools
 , nevBase
 , nevObjectList
 , l3Variant
;

type
 _nevDocumentContainerDecorationRules_Parent_ = TnevBaseView;
 {$Include nevDocumentContainerDecorationRules.imp.pas}
 TnevBaseDrawView = class(_nevDocumentContainerDecorationRules_, InevScrollListener, InevControlView, InevDrawView, InevViewMetrics)
  private
   f_Control: Pointer;
   {$If Defined(evNeedCollapsedVersionComments)}
   f_CollapsedObjects: TnevObjectList;
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   f_PrevTop: InevBasePoint;
    {* Поле для свойства PrevTop }
   f_Top: InevAnchor;
    {* Поле для свойства Top }
   f_Canvas: InevCanvas;
    {* Поле для свойства Canvas }
   f_ControlLMargin: Integer;
    {* Поле для свойства ControlLMargin }
  private
   function CorrectFoundPoint(const aPoint: InevBasePoint;
    aMode: TnevPointByPtMode): InevBasePoint;
   function MoveCursor(const aPoint: InevBasePoint;
    var aLine: Integer;
    aMode: TnevPointByPtMode): InevBasePoint;
  protected
   function pm_GetViewExtent: TnevPoint;
   function NeedScrollShapes: Boolean;
   procedure DoSignalScroll(aTopDiff: Integer;
    aDeltaY: Integer); virtual;
   function PointByPtPrim(const aPt: TnevPoint;
    aMode: TnevPointByPtMode): InevBasePoint;
    {* возвращает курсор указывающий на данную точку, в системе координат View. }
   function DiffToLine(const aPt: TnevPoint): Integer;
   function GetCanvas(const anExtent: TnevPoint): InevCanvas; virtual;
   function LMargin: Integer; virtual;
   function CaretCursor: InevBasePoint; virtual;
   function DoDraw(const aBlock: InevRange;
    var theMap: InevMap): Boolean; virtual;
   procedure LinkControl(const aControl: InevControl); virtual;
   procedure DoUnlinkControl(const aControl: InevControl); virtual;
   procedure Signal;
    {* Позиция скроллера изменилась. }
   function pm_GetLimitWidth: TnevInch;
   function pm_GetInfoCanvas: InevInfoCanvas;
   function pm_GetIsWebStyle: Boolean;
   function pm_GetShowDocumentParts: Boolean;
   function pm_GetShowSpecial: Boolean;
   function pm_GetHiddenStyles: TnevStandardStyles;
   function pm_GetControl: InevControl;
   procedure UnlinkControl(const aControl: InevControl);
    {* отсоединяет контрол от области вывода. }
   function IsDocumentTailVisible: Boolean;
   function Draw(const aBlock: InevRange;
    var theMap: InevMap): Boolean;
   function pm_GetTopAnchor: InevAnchor;
   function PointByPt(const aPt: TnevPoint;
    aForSetCursor: Boolean = False): InevBasePoint;
    {* Возвращает курсор указывающий на данную точку, в системе координат View. }
   function pm_GetExtent: TnevPoint;
   function Get_ExcludeSuper: TevNormalSegLayerHandleSet;
   function Get_FormatCanvas: InevInfoCanvas;
   function Get_AllowRubberTables: TnevRubberTablesMode;
   function IsTagCollapsed(aTag: Tl3Variant): Boolean;
   function Get_Data: InevObjectPrim;
   function BottomAnchor(aSimple: Boolean): InevAnchor;
   function Get_AACLike: TnevAACLikeMode;
   function NeedTotalRecalc: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetShape: InevObject; override;
   function DoGetMetrics: InevViewMetrics; override;
   function DoGetProcessor: InevProcessor; override;
   function GetRootFormatInfo: TnevFormatInfoPrim; override;
   function pm_GetActiveElementPrim: InevActiveElement; override;
   function pm_GetForceDrawFocusRectPrim: Boolean; override;
   function pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean; override;
   procedure pm_SetIsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean); override;
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure DoVersionInfoVisabilityChanged(aValue: Boolean); override;
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   procedure ClearFields; override;
  protected
   property PrevTop: InevBasePoint
    read f_PrevTop;
   property Top: InevAnchor
    read f_Top
    write f_Top;
   property Canvas: InevCanvas
    read f_Canvas;
   property ControlLMargin: Integer
    read f_ControlLMargin;
  public
   property ViewExtent: TnevPoint
    read pm_GetViewExtent;
 end;//TnevBaseDrawView

implementation

uses
 l3ImplUses
 , l3Const
 , nevFacade
 , SysUtils
 , l3Units
 , l3PrinterIC
 , nevRealTools
 , k2Tags
 , evdStyles
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

{$Include nevDocumentContainerDecorationRules.imp.pas}

function TnevBaseDrawView.pm_GetViewExtent: TnevPoint;
//#UC START# *48C7F58C03E0_4811E4BA020Aget_var*
//#UC END# *48C7F58C03E0_4811E4BA020Aget_var*
begin
//#UC START# *48C7F58C03E0_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := nevPt0
 else
  Result := InevControl(f_Control).Metrics.Extent;
//#UC END# *48C7F58C03E0_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetViewExtent

function TnevBaseDrawView.CorrectFoundPoint(const aPoint: InevBasePoint;
 aMode: TnevPointByPtMode): InevBasePoint;
//#UC START# *5011297D01AA_4811E4BA020A_var*

 function lp_MostInner(const aValue: InevBasePoint): InevBasePoint;
 begin
  Result := aValue;
  while Result.HasInner and not Result.AsObject.BoolA[k2_tiCollapsed] do
   Result := Result.Inner;
 end;

var
 l_Line : Integer;
 l_MI   : InevBasePoint;
 l_Inn  : InevBasePoint;
 l_Map  : InevMap;
 l_Prev : InevBasePoint;
//#UC END# *5011297D01AA_4811E4BA020A_var*
begin
//#UC START# *5011297D01AA_4811E4BA020A_impl*
 Result := aPoint;
 if aMode = nev_ppmNeedAnchor then
  l_MI := lp_MostInner(Result)
 else
  l_MI := Result.MostInner;
 l_Prev := nil;
 if l_MI.HasBaseLine then
 begin
  l_Inn := l_MI.InnerForChildThatNotAfterEnd(FormatInfoByPoint(l_MI), nev_itNone);
  if l_Inn <> nil then
  begin
   l_Prev := l_MI;
   l_MI := l_Inn.MostInner;
  end; // if l_Inn <> nil then
 end; // if l_MI.HasBaseLine then
 l_Map := MapByPoint(l_MI);
 if (l_Map = nil) then
  l_Map := MapByPoint(l_Prev)
 // ^ - запил для решения [$207006496].
 else
  l_Prev := nil; // Мы нашли ячейку и знания о строке нам не нужны (для задачи [$219124086])...
 if (l_Prev = nil) AND (l_Map = nil) AND (aMode = nev_ppmNeedAnchor) then
  l_Map := MapByPoint(Result.Obj.MakePoint);
  // - это чтобы неправильно инициализированный якорь вел себя по аналогии с неинициализированным курсором
 Assert(l_Map <> nil);
 if (l_Map.Bounds.Bottom > ViewExtent.Y) then
 begin
  if (l_Prev = nil) and (aMode = nev_ppmNeedAnchor) then // [$219124086]
  begin
   l_Line := -1;
   Result := MoveCursor(Result, l_Line, aMode);
  end; // if (l_Prev <> nil) then
 end;//l_Rect.Bottom > ViewExtent.Y
//#UC END# *5011297D01AA_4811E4BA020A_impl*
end;//TnevBaseDrawView.CorrectFoundPoint

function TnevBaseDrawView.MoveCursor(const aPoint: InevBasePoint;
 var aLine: Integer;
 aMode: TnevPointByPtMode): InevBasePoint;
//#UC START# *501131010369_4811E4BA020A_var*
var
 l_Cursor : InevBaseLine4Anchor;
//#UC END# *501131010369_4811E4BA020A_var*
begin
//#UC START# *501131010369_4811E4BA020A_impl*
 if aMode = nev_ppmNeedAnchor then
  l_Cursor := aPoint.Obj.MakeAnchor
 else
  l_Cursor := aPoint.Obj.MakePoint;
 l_Cursor.AssignPoint(Self, aPoint);
 l_Cursor.IncLine(Self, aLine, true);
 Result := l_Cursor;
//#UC END# *501131010369_4811E4BA020A_impl*
end;//TnevBaseDrawView.MoveCursor

function TnevBaseDrawView.NeedScrollShapes: Boolean;
//#UC START# *4811E93C0182_4811E4BA020A_var*
//#UC END# *4811E93C0182_4811E4BA020A_var*
begin
//#UC START# *4811E93C0182_4811E4BA020A_impl*
 if (f_Control = nil) then
  Result := True
 else
  Result := InevControl(f_Control).CanScroll;
//#UC END# *4811E93C0182_4811E4BA020A_impl*
end;//TnevBaseDrawView.NeedScrollShapes

procedure TnevBaseDrawView.DoSignalScroll(aTopDiff: Integer;
 aDeltaY: Integer);
//#UC START# *4811EAEB030F_4811E4BA020A_var*
//#UC END# *4811EAEB030F_4811E4BA020A_var*
begin
//#UC START# *4811EAEB030F_4811E4BA020A_impl*
 // ничего не делаем
//#UC END# *4811EAEB030F_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoSignalScroll

function TnevBaseDrawView.PointByPtPrim(const aPt: TnevPoint;
 aMode: TnevPointByPtMode): InevBasePoint;
 {* возвращает курсор указывающий на данную точку, в системе координат View. }
//#UC START# *4811EEA90061_4811E4BA020A_var*
var
 l_Diff : Integer;
 l_Line : Integer;
//#UC END# *4811EEA90061_4811E4BA020A_var*
begin
//#UC START# *4811EEA90061_4811E4BA020A_impl*
 Result := ShapesPainted.PointByPt(Self, aPt, aMode);
 if (Result <> nil) then
 begin
  if (aPt.Y < 0) then
  // - тянем курсор за верх экрана
  begin
   l_Diff := aPt.Y;
   l_Line := (l_Diff div (l3Inch div 8)) - 1;
   Result := MoveCursor(Result, l_Line, aMode);
  end//aPt.Y < 0
  else
  begin
   l_Line := DiffToLine(aPt);                         
   if (l_Line > 0) then
    Result := MoveCursor(Result, l_Line, aMode)
   else
   if not (aMode in [nev_ppmCheckHidden, nev_ppmSetCursor]) then
    Result := CorrectFoundPoint(Result, aMode);
  end;//..aPt.Y > aControl.Extent.Y
 end;//Result <> nil
//#UC END# *4811EEA90061_4811E4BA020A_impl*
end;//TnevBaseDrawView.PointByPtPrim

function TnevBaseDrawView.DiffToLine(const aPt: TnevPoint): Integer;
//#UC START# *4811EED60141_4811E4BA020A_var*
var
 l_Diff : Integer;
//#UC END# *4811EED60141_4811E4BA020A_var*
begin
//#UC START# *4811EED60141_4811E4BA020A_impl*
 l_Diff := (aPt.Y - ViewExtent.Y);
 if (l_Diff > 4*l3Epsilon) then
  Result := (l_Diff div (l3Inch div 8)) + 1
 else
  Result := 0;
//#UC END# *4811EED60141_4811E4BA020A_impl*
end;//TnevBaseDrawView.DiffToLine

function TnevBaseDrawView.GetCanvas(const anExtent: TnevPoint): InevCanvas;
//#UC START# *4811F0AC0140_4811E4BA020A_var*
//#UC END# *4811F0AC0140_4811E4BA020A_var*
begin
//#UC START# *4811F0AC0140_4811E4BA020A_impl*
 Result := nil;
//#UC END# *4811F0AC0140_4811E4BA020A_impl*
end;//TnevBaseDrawView.GetCanvas

function TnevBaseDrawView.LMargin: Integer;
//#UC START# *4811F13B004B_4811E4BA020A_var*
//#UC END# *4811F13B004B_4811E4BA020A_var*
begin
//#UC START# *4811F13B004B_4811E4BA020A_impl*
 Result := 0;
//#UC END# *4811F13B004B_4811E4BA020A_impl*
end;//TnevBaseDrawView.LMargin

function TnevBaseDrawView.CaretCursor: InevBasePoint;
//#UC START# *4811F158015E_4811E4BA020A_var*
//#UC END# *4811F158015E_4811E4BA020A_var*
begin
//#UC START# *4811F158015E_4811E4BA020A_impl*
 Result := nil;
//#UC END# *4811F158015E_4811E4BA020A_impl*
end;//TnevBaseDrawView.CaretCursor

function TnevBaseDrawView.DoDraw(const aBlock: InevRange;
 var theMap: InevMap): Boolean;
//#UC START# *4811F3980250_4811E4BA020A_var*
var
 l_DrawShape   : InevDrawingShape;
 l_Shape       : InevObject;
 l_ClearCanvas : Boolean;
 l_CEx         : TnevPoint;
 l_Points      : TnevShapePoints;
 l_Area        : TnevShapeAreaEx;
 l_Info        : TnevShapeInfo;
 l_ClipRect    : Tl3Rect;
//#UC END# *4811F3980250_4811E4BA020A_var*
begin
//#UC START# *4811F3980250_4811E4BA020A_impl*
 Result := False;
 l_Shape := Shape;
 if (l_Shape <> nil) then
 begin
  l_CEx := ViewExtent;
  if (Canvas = nil) then
  // - надо взять канву, если не находимся в процессе рисования
  begin
   f_Canvas := GetCanvas(l_CEx);
   l_ClearCanvas := True;
  end//Canvas = nil
  else
   l_ClearCanvas := False;
  try
   if (Canvas <> nil) then
   begin
    l_ClipRect := Canvas.ClipRect;
    // K-159369004 - рисовать нечего.
    // По уму надо для CHeckScrollers убеждаться, что в SHapesPainted
    // точно попадает низ ClientRect от редактора..
    if l_ClipRect.Bottom - l_ClipRect.Top = 0 then 
     Exit;
    if (f_Control <> nil) AND
       l_Shape.AsObject.QT(InevDrawingShape, l_DrawShape, Processor) then
    try
     with Canvas do
     begin
      f_ControlLMargin := DP2LP(PointX(-InevControl(f_Control).LMargin)).X;
      MoveWindowOrg(l3PointX(f_ControlLMargin));
     end;//with Canvas
     Canvas.BeginPaint;
     try
      Canvas.MoveWindowOrg(l3PointX(LMargin));
      l_Points.rTop := pm_GetTopAnchor;
      l_Points.rCaret := CaretCursor;
      l_Points.rSelection := aBlock;
      l_Points.rPrevHeight := 0;
      l_Points.rRealTop := nil;
      l_Points.rFake := False;
      l_Points.rCheckCaret := nil;
      l_Points.rCheckSelection := nil;
      l_Area.Init(Self, Canvas, false);
      try
       l_DrawShape.Draw(l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}, l_Points, l_Info);
      finally
       l_Area.Free;
      end;//try..finally
      theMap := l_Info.rMap;
      Result := True;
     finally
      Canvas.EndPaint;
     end;//try..finally
    finally
     l_DrawShape := nil;
    end;//try..finally
   end;
  finally
   if l_ClearCanvas then
    f_Canvas := nil;
  end;//try..finally
 end;//l_Shape <> nil
//#UC END# *4811F3980250_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoDraw

procedure TnevBaseDrawView.LinkControl(const aControl: InevControl);
//#UC START# *4811F4A502F6_4811E4BA020A_var*
//#UC END# *4811F4A502F6_4811E4BA020A_var*
begin
//#UC START# *4811F4A502F6_4811E4BA020A_impl*
 Assert(aControl <> nil);
 Assert((f_Control = nil) OR (InevControl(f_Control) = aControl),
        Format('Попытка привязать второй контрол к области вывода [%s]', [ClassName]));
 f_Control := Pointer(aControl);
//#UC END# *4811F4A502F6_4811E4BA020A_impl*
end;//TnevBaseDrawView.LinkControl

procedure TnevBaseDrawView.DoUnlinkControl(const aControl: InevControl);
//#UC START# *4811F4B801DC_4811E4BA020A_var*
//#UC END# *4811F4B801DC_4811E4BA020A_var*
begin
//#UC START# *4811F4B801DC_4811E4BA020A_impl*
 Assert((f_Control = nil) OR (InevControl(f_Control) = aControl),
        Format('Попытка отвязать неправильный контрол от области вывода [%s]', [ClassName]));
 f_Holder := nil;       
 f_Control := nil;
 if (f_Top <> nil) then
  f_Top.UnlinkListener(Self);
 f_Top := nil;
 f_PrevTop := nil;
 ClearShapes;
 { TODO -oЛюлин А. В. -cцикл_ссылок : Временная мера - пока не придумаю как быть с циклическими ссылками. Т.к. View держит rTop и rBottom, а они держат документ, а документ держит View. }
//#UC END# *4811F4B801DC_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoUnlinkControl

procedure TnevBaseDrawView.Signal;
 {* Позиция скроллера изменилась. }
//#UC START# *467FAE0C02F3_4811E4BA020A_var*
var
 l_Delta   : Integer;
 l_TopDiff : Integer;
 l_Map     : TnevFormatInfoPrim;
//#UC END# *467FAE0C02F3_4811E4BA020A_var*
begin
//#UC START# *467FAE0C02F3_4811E4BA020A_impl*
 if (f_PrevTop = nil) then
  l_TopDiff := High(l_TopDiff)
 else
 begin
  l_Map := RootFormatInfo;
  Assert(l_Map <> nil);
  if f_PrevTop.Obj.AsObject.Owner.IsValid then
   // - параграф не удалили
   l_TopDiff := f_PrevTop.Diff(Self, f_Top, l_Map)
  else
  begin
   l_TopDiff := -1;
   f_PrevTop := nil;
  end;//f_PrevTop.Obj.Owner.IsValid
 end;//f_PrevTop = nil
 if (l_TopDiff <> 0) then
 begin
  l_Delta := 0;
  if (f_Top = nil) then
   f_PrevTop := nil
  else
  begin
   if NeedScrollShapes then
   begin
    if (f_PrevTop <> nil) then
     l_Delta := ShapesPainted.VertScroll(Self,
                                         f_PrevTop,
                                         f_Top,
                                         ViewExtent);
   end;//NeedScrollShapes
   f_PrevTop := f_Top.ClonePoint(Self);
  end;//f_Top = nil
  if (Abs(l_Delta) < l3Epsilon) then
  begin
   ClearShapes;
  end;
  DoSignalScroll(l_TopDiff, l_Delta);
  // вообще-то l_TopDiff нужен только для TnevVScroller.ResetPos
  // в котором код закомментировали - http://mdp.garant.ru/pages/viewpage.action?pageId=171968601&focusedCommentId=171969512#comment-171969512
  // так что может стоит подумать - убрать эти макароны.
 end;//l_TopDiff <> 0
//#UC END# *467FAE0C02F3_4811E4BA020A_impl*
end;//TnevBaseDrawView.Signal

function TnevBaseDrawView.pm_GetLimitWidth: TnevInch;
//#UC START# *476BFB3C007A_4811E4BA020Aget_var*
//#UC END# *476BFB3C007A_4811E4BA020Aget_var*
begin
//#UC START# *476BFB3C007A_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := l3NilLong
 else
  Result := InevControl(f_Control).Metrics.LimitWidth;
//#UC END# *476BFB3C007A_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetLimitWidth

function TnevBaseDrawView.pm_GetInfoCanvas: InevInfoCanvas;
//#UC START# *476BFBE10164_4811E4BA020Aget_var*
//#UC END# *476BFBE10164_4811E4BA020Aget_var*
begin
//#UC START# *476BFBE10164_4811E4BA020Aget_impl*
//{$IFDEF Nemesis}
 if (f_Control = nil) then
  Result := nev.CrtIC
 else
  Result := InevControl(f_Control).Metrics.InfoCanvas;
(*{$ELSE}
 Result := L3PrnIC;
 // УБРАНО! http://mdp.garant.ru/pages/viewpage.action?pageId=142610892
{$ENDIF Nemsis}*)
//#UC END# *476BFBE10164_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetInfoCanvas

function TnevBaseDrawView.pm_GetIsWebStyle: Boolean;
//#UC START# *476BFC120188_4811E4BA020Aget_var*
//#UC END# *476BFC120188_4811E4BA020Aget_var*
begin
//#UC START# *476BFC120188_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := false
 else
  Result := InevControl(f_Control).Metrics.IsWebStyle;
//#UC END# *476BFC120188_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetIsWebStyle

function TnevBaseDrawView.pm_GetShowDocumentParts: Boolean;
//#UC START# *476BFC2101FB_4811E4BA020Aget_var*
//#UC END# *476BFC2101FB_4811E4BA020Aget_var*
begin
//#UC START# *476BFC2101FB_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := false
 else
  Result := InevControl(f_Control).Metrics.ShowDocumentParts;
//#UC END# *476BFC2101FB_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetShowDocumentParts

function TnevBaseDrawView.pm_GetShowSpecial: Boolean;
//#UC START# *476BFC34010B_4811E4BA020Aget_var*
//#UC END# *476BFC34010B_4811E4BA020Aget_var*
begin
//#UC START# *476BFC34010B_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := false
 else
  Result := InevControl(f_Control).Metrics.ShowSpecial;
//#UC END# *476BFC34010B_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetShowSpecial

function TnevBaseDrawView.pm_GetHiddenStyles: TnevStandardStyles;
//#UC START# *476BFC420000_4811E4BA020Aget_var*
//#UC END# *476BFC420000_4811E4BA020Aget_var*
begin
//#UC START# *476BFC420000_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := []
 else
  Result := InevControl(f_Control).Metrics.HiddenStyles;
//#UC END# *476BFC420000_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetHiddenStyles

function TnevBaseDrawView.pm_GetControl: InevControl;
//#UC START# *47C5C1C501D9_4811E4BA020Aget_var*
//#UC END# *47C5C1C501D9_4811E4BA020Aget_var*
begin
//#UC START# *47C5C1C501D9_4811E4BA020Aget_impl*
 Result := InevControl(f_Control);
//#UC END# *47C5C1C501D9_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetControl

procedure TnevBaseDrawView.UnlinkControl(const aControl: InevControl);
 {* отсоединяет контрол от области вывода. }
//#UC START# *47C5C1F300FC_4811E4BA020A_var*
//#UC END# *47C5C1F300FC_4811E4BA020A_var*
begin
//#UC START# *47C5C1F300FC_4811E4BA020A_impl*
 DoUnlinkControl(aControl);
//#UC END# *47C5C1F300FC_4811E4BA020A_impl*
end;//TnevBaseDrawView.UnlinkControl

function TnevBaseDrawView.IsDocumentTailVisible: Boolean;
//#UC START# *47C5C3C2019E_4811E4BA020A_var*
var
 l_A : InevAnchor;
//#UC END# *47C5C3C2019E_4811E4BA020A_var*
begin
//#UC START# *47C5C3C2019E_4811E4BA020A_impl*
 if (f_Control = nil) OR (Shape = nil) then
  Result := False
 else
 begin
  l_A := BottomAnchor(True);
  if (l_A = nil) then
   Result := False
  else
   Result := l_A.AtEnd(Self);
 end;//f_Control = nil..
//#UC END# *47C5C3C2019E_4811E4BA020A_impl*
end;//TnevBaseDrawView.IsDocumentTailVisible

function TnevBaseDrawView.Draw(const aBlock: InevRange;
 var theMap: InevMap): Boolean;
//#UC START# *47C5C3DC0361_4811E4BA020A_var*
//#UC END# *47C5C3DC0361_4811E4BA020A_var*
begin
//#UC START# *47C5C3DC0361_4811E4BA020A_impl*
 Result := DoDraw(aBlock, theMap);
//#UC END# *47C5C3DC0361_4811E4BA020A_impl*
end;//TnevBaseDrawView.Draw

function TnevBaseDrawView.pm_GetTopAnchor: InevAnchor;
//#UC START# *47C5C40002AD_4811E4BA020Aget_var*
var
 l_Shape : InevObject;
//#UC END# *47C5C40002AD_4811E4BA020Aget_var*
begin
//#UC START# *47C5C40002AD_4811E4BA020Aget_impl*
 {$IfNDef DesignTimeLibrary}
 if (f_Top <> nil) AND not f_Top.Obj.AsObject.Owner.IsValid then
 begin
  // - удалили параграф на который указывал якорь
  f_Top.UnlinkListener(Self);
  f_Top := nil;
 end;//(f_Top <> nil) AND not f_Top.Obj.Owner.IsValid
 {$EndIf  DesignTimeLibrary}
 if (f_Top = nil) then
 begin
  l_Shape := Shape;
  if (l_Shape <> nil) AND l_Shape.AsObject.IsValid then
  begin
   f_Top := l_Shape.MakeAnchor;
   f_Top.LinkListener(Self);
  end;//l_Shape <> nil..
 end;//f_Top = nil
 Result := f_Top;
//#UC END# *47C5C40002AD_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetTopAnchor

function TnevBaseDrawView.PointByPt(const aPt: TnevPoint;
 aForSetCursor: Boolean = False): InevBasePoint;
 {* Возвращает курсор указывающий на данную точку, в системе координат View. }
//#UC START# *47F64B1F03AD_4811E4BA020A_var*
//#UC END# *47F64B1F03AD_4811E4BA020A_var*
begin
//#UC START# *47F64B1F03AD_4811E4BA020A_impl*
 if aForSetCursor then
  Result := PointByPtPrim(aPt, nev_ppmSetCursor)
 else
  Result := PointByPtPrim(aPt, nev_ppmCheckHidden);
//#UC END# *47F64B1F03AD_4811E4BA020A_impl*
end;//TnevBaseDrawView.PointByPt

function TnevBaseDrawView.pm_GetExtent: TnevPoint;
//#UC START# *486D2C6702FA_4811E4BA020Aget_var*
//#UC END# *486D2C6702FA_4811E4BA020Aget_var*
begin
//#UC START# *486D2C6702FA_4811E4BA020Aget_impl*
 Result := ViewExtent;
//#UC END# *486D2C6702FA_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetExtent

function TnevBaseDrawView.Get_ExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4AEAE49B024D_4811E4BA020Aget_var*
//#UC END# *4AEAE49B024D_4811E4BA020Aget_var*
begin
//#UC START# *4AEAE49B024D_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := []
 else
  Result := InevControl(f_Control).Metrics.ExcludeSuper;
//#UC END# *4AEAE49B024D_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.Get_ExcludeSuper

function TnevBaseDrawView.Get_FormatCanvas: InevInfoCanvas;
//#UC START# *4B7E744702C0_4811E4BA020Aget_var*
//#UC END# *4B7E744702C0_4811E4BA020Aget_var*
begin
//#UC START# *4B7E744702C0_4811E4BA020Aget_impl*
 {$IFnDEF Nemesis}
 if pm_GetIsWebStyle then
 {$EndIF  Nemesis}
 begin
  if (f_Control = nil) then
   Result := nev.CrtIC
  else
   Result := InevControl(f_Control).Metrics.InfoCanvas;
 end//pm_GetIsWebStyle
 {$IFnDEF Nemesis}
 else
  Result := L3PrnIC;
 {$ENDIF Nemsis}
//#UC END# *4B7E744702C0_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.Get_FormatCanvas

function TnevBaseDrawView.Get_AllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6E9300FD_4811E4BA020Aget_var*
//#UC END# *4BED6E9300FD_4811E4BA020Aget_var*
begin
//#UC START# *4BED6E9300FD_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := nev_rtmNone
 else
  Result := InevControl(f_Control).Metrics.AllowRubberTables;
//#UC END# *4BED6E9300FD_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.Get_AllowRubberTables

function TnevBaseDrawView.IsTagCollapsed(aTag: Tl3Variant): Boolean;
//#UC START# *4D5A80DC029D_4811E4BA020A_var*
var
 l_Obj : InevObject;
//#UC END# *4D5A80DC029D_4811E4BA020A_var*
begin
//#UC START# *4D5A80DC029D_4811E4BA020A_impl*
 if not aTag.QT(InevObject, l_Obj) then
  Assert(false);
 Result := Self.IsObjectCollapsed[l_Obj];
//#UC END# *4D5A80DC029D_4811E4BA020A_impl*
end;//TnevBaseDrawView.IsTagCollapsed

function TnevBaseDrawView.Get_Data: InevObjectPrim;
//#UC START# *4E5E285C0166_4811E4BA020Aget_var*
//#UC END# *4E5E285C0166_4811E4BA020Aget_var*
begin
//#UC START# *4E5E285C0166_4811E4BA020Aget_impl*
 Result := pm_GetShape;
//#UC END# *4E5E285C0166_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.Get_Data

function TnevBaseDrawView.BottomAnchor(aSimple: Boolean): InevAnchor;
//#UC START# *50123B01029B_4811E4BA020A_var*
var
 l_Line  : Integer;
 l_Move  : Boolean;
 l_Point : InevBasePoint;
//#UC END# *50123B01029B_4811E4BA020A_var*
begin
//#UC START# *50123B01029B_4811E4BA020A_impl*
 l_Move := False;
 l_Point := ShapesPainted.GetBottomAnchor(Self, aSimple, l_Move);
 if (l_Point = nil) then
  Result := nil
 else
 begin
  if not l_Point.AtEnd(Self) and l_Move then
  begin
   l_Line := 1;
   l_Point.IncLine(Self, l_Line, true);
  end // if l_Move then
  else
   l_Point := CorrectFoundPoint(l_Point, nev_ppmNeedAnchor);
  Result := l_Point as InevAnchor;
 end;//l_Point = nil
//#UC END# *50123B01029B_4811E4BA020A_impl*
end;//TnevBaseDrawView.BottomAnchor

function TnevBaseDrawView.Get_AACLike: TnevAACLikeMode;
//#UC START# *501F96A80050_4811E4BA020Aget_var*
//#UC END# *501F96A80050_4811E4BA020Aget_var*
begin
//#UC START# *501F96A80050_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := nev_aacNone
 else
  Result := InevControl(f_Control).Metrics.AACLike;
//#UC END# *501F96A80050_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.Get_AACLike

function TnevBaseDrawView.NeedTotalRecalc: Boolean;
//#UC START# *565F03C80029_4811E4BA020A_var*
//#UC END# *565F03C80029_4811E4BA020A_var*
begin
//#UC START# *565F03C80029_4811E4BA020A_impl*
 Result := false; 
//#UC END# *565F03C80029_4811E4BA020A_impl*
end;//TnevBaseDrawView.NeedTotalRecalc

procedure TnevBaseDrawView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4811E4BA020A_var*
//#UC END# *479731C50290_4811E4BA020A_var*
begin
//#UC START# *479731C50290_4811E4BA020A_impl*
 {$IfDef evNeedCollapsedVersionComments}
 FreeAndNil(f_CollapsedObjects);
 {$EndIf evNeedCollapsedVersionComments}
 inherited;
 if (f_Top <> nil) then
  f_Top.UnlinkListener(Self);
 f_Top := nil;
 f_PrevTop := nil;
 f_Control := nil;
//#UC END# *479731C50290_4811E4BA020A_impl*
end;//TnevBaseDrawView.Cleanup

function TnevBaseDrawView.pm_GetShape: InevObject;
//#UC START# *4811D60B0043_4811E4BA020Aget_var*
//#UC END# *4811D60B0043_4811E4BA020Aget_var*
begin
//#UC START# *4811D60B0043_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := nil
 else
  Result := InevControl(f_Control).Data;
//#UC END# *4811D60B0043_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetShape

function TnevBaseDrawView.DoGetMetrics: InevViewMetrics;
//#UC START# *4811D7DC0254_4811E4BA020A_var*
//#UC END# *4811D7DC0254_4811E4BA020A_var*
begin
//#UC START# *4811D7DC0254_4811E4BA020A_impl*
 Result := Self;
//#UC END# *4811D7DC0254_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoGetMetrics

function TnevBaseDrawView.DoGetProcessor: InevProcessor;
//#UC START# *4811D8210302_4811E4BA020A_var*
//#UC END# *4811D8210302_4811E4BA020A_var*
begin
//#UC START# *4811D8210302_4811E4BA020A_impl*
 if (f_Control = nil) then
  Result := nil
 else
  Result := InevControl(f_Control).Processor;
//#UC END# *4811D8210302_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoGetProcessor

function TnevBaseDrawView.GetRootFormatInfo: TnevFormatInfoPrim;
//#UC START# *481DA04D0324_4811E4BA020A_var*
//#UC END# *481DA04D0324_4811E4BA020A_var*
begin
//#UC START# *481DA04D0324_4811E4BA020A_impl*
 if (f_Control <> nil) and InevControl(f_Control).InClose then
  Result := nil
 else
  Result := inherited GetRootFormatInfo;
//#UC END# *481DA04D0324_4811E4BA020A_impl*
end;//TnevBaseDrawView.GetRootFormatInfo

function TnevBaseDrawView.pm_GetActiveElementPrim: InevActiveElement;
//#UC START# *4A27CFD20374_4811E4BA020Aget_var*
//#UC END# *4A27CFD20374_4811E4BA020Aget_var*
begin
//#UC START# *4A27CFD20374_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := nil
 else
  Result := InevControl(f_Control).ActiveElement;
//#UC END# *4A27CFD20374_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetActiveElementPrim

function TnevBaseDrawView.pm_GetForceDrawFocusRectPrim: Boolean;
//#UC START# *4B59AC930100_4811E4BA020Aget_var*
//#UC END# *4B59AC930100_4811E4BA020Aget_var*
begin
//#UC START# *4B59AC930100_4811E4BA020Aget_impl*
 if (f_Control = nil) then
  Result := false
 else
  Result := InevControl(f_Control).ForceDrawFocusRect;
//#UC END# *4B59AC930100_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetForceDrawFocusRectPrim

function TnevBaseDrawView.pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A46930182_4811E4BA020Aget_var*
var
 l_Index : Integer;
//#UC END# *4D5A46930182_4811E4BA020Aget_var*
begin
//#UC START# *4D5A46930182_4811E4BA020Aget_impl*
 {$IfDef evNeedCollapsedVersionComments}
 if (anObject.IntA[k2_tiStyle] <> ev_saVersionInfo) then
  Result := false
 else
 if (f_CollapsedObjects = nil) then
  Result := (-ev_saVersionInfo in pm_GetHiddenStyles)
 else
 begin
  l_Index := f_CollapsedObjects.IndexOf(anObject);
  if (l_Index < 0) then
   Result := (-ev_saVersionInfo in pm_GetHiddenStyles)
  else
   Result := inherited pm_GetIsObjectCollapsed(anObject);
 end;//f_CollapsedObjects = nil
 {$Else  evNeedCollapsedVersionComments}
 Result := inherited pm_GetIsObjectCollapsed(anObject);
 evCheckCollapsed(anObject.AsObject, Result);
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4D5A46930182_4811E4BA020Aget_impl*
end;//TnevBaseDrawView.pm_GetIsObjectCollapsed

procedure TnevBaseDrawView.pm_SetIsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A46930182_4811E4BA020Aset_var*
{$IfDef evNeedCollapsedVersionComments}
var
 l_Index : Integer;
{$EndIf evNeedCollapsedVersionComments} 
//#UC END# *4D5A46930182_4811E4BA020Aset_var*
begin
//#UC START# *4D5A46930182_4811E4BA020Aset_impl*
 {$IfDef evNeedCollapsedVersionComments}
 if (anObject.IntA[k2_tiStyle] = ev_saVersionInfo) then
 begin
  {$IfDef evCollapseAllVersionComments}
  (pm_GetControl As InevCommentSwitcher).ShowVersionComments := not aValue;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=254354849
  {$Else evCollapseAllVersionComments}
  inherited pm_SetIsObjectCollapsed(anObject, aValue);
  if (f_CollapsedObjects = nil) then
   f_CollapsedObjects := TnevObjectList.Create;
  l_Index := f_CollapsedObjects.IndexOf(anObject);
  if (l_Index < 0) then
   f_CollapsedObjects.Add(anObject);
  {$EndIf evCollapseAllVersionComments}
 end;//anObject.IntA[k2_tiStyle] = ev_saVersionInfo
 {$Else evNeedCollapsedVersionComments}
 inherited pm_SetIsObjectCollapsed(anObject, aValue);
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4D5A46930182_4811E4BA020Aset_impl*
end;//TnevBaseDrawView.pm_SetIsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure TnevBaseDrawView.DoVersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A4707033B_4811E4BA020A_var*
var
 l_Index : Integer;
//#UC END# *4D5A4707033B_4811E4BA020A_var*
begin
//#UC START# *4D5A4707033B_4811E4BA020A_impl*
 if (f_CollapsedObjects <> nil) then
  for l_Index := 0 to Pred(f_CollapsedObjects.Count) do
   with f_CollapsedObjects[l_Index] do
   begin
    BoolA[k2_tiCollapsed] := not aValue;
    Invalidate([nev_spExtent]);
   end;//with f_CollapsedObjects[l_Index]
//#UC END# *4D5A4707033B_4811E4BA020A_impl*
end;//TnevBaseDrawView.DoVersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

procedure TnevBaseDrawView.ClearFields;
begin
 f_PrevTop := nil;
 Top := nil;
 f_Canvas := nil;
 inherited;
end;//TnevBaseDrawView.ClearFields

end.
