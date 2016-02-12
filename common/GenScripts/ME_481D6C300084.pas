{$IfNDef evParaListPainter_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListPainter.imp.pas"
// Стереотип: "Impurity"

{$Define evParaListPainter_imp}

{$If Defined(evNeedPainters)}
 {$Include w:\common\components\gui\Garant\Everest\evParaPainter.imp.pas}
 _evParaListPainter_ = class(_evParaPainter_)
  {* Рисователь списка параграфов }
  protected
   procedure AfterDrawChild(const aChild: InevPara;
    const aChildPainter: IevPainter;
    const aChildInfo: TnevShapeInfo); virtual;
   procedure MakeBottomAnchorInnerAfterEnd(const anInner: InevBasePoint);
    {* Метод сделан, чтобы не тащить связь от Cursors в ParaListPainters }
   procedure CheckNeedLaterFilling(const aPainterHolder: InevPaintersHolder;
    const aChildMap: InevMap); virtual;
   function BeforeDrawChild(const ChildPainter: IevPainter): Boolean; virtual;
    {* Вызывается перед рисованием каждого дочернего параграфа. }
   function ChildInSelection(const aPara: InevPara): Boolean; virtual;
   function NeedCheckTopAnchor: Boolean; virtual;
   function CheckCompleate: Boolean; virtual;
    {* [$114950787] }
   procedure CheckChild(const aPara: InevPara); virtual;
   function Check4Printing(aHeight: Integer): Boolean;
   function UseSelRange(const aSelRange: InevRange): Boolean; virtual;
   procedure InitInnerBottom(const aChildInfo: TnevShapeInfo); virtual;
   function NeedPrintingChild(const aChild: InevPara): Boolean; virtual;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function DoDraw: Boolean; override;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure InitBottom(var theBottom: InevBasePoint;
    var theCellBottom: InevBasePoint); override;
 end;//_evParaListPainter_

{$Else Defined(evNeedPainters)}

{$Include w:\common\components\gui\Garant\Everest\evParaPainter.imp.pas}
_evParaListPainter_ = _evParaPainter_;

{$IfEnd} // Defined(evNeedPainters)
{$Else evParaListPainter_imp}

{$IfNDef evParaListPainter_imp_impl}

{$Define evParaListPainter_imp_impl}

{$If Defined(evNeedPainters)}
{$Include w:\common\components\gui\Garant\Everest\evParaPainter.imp.pas}

procedure _evParaListPainter_.AfterDrawChild(const aChild: InevPara;
 const aChildPainter: IevPainter;
 const aChildInfo: TnevShapeInfo);
//#UC START# *4D63E3490015_481D6C300084_var*
//#UC END# *4D63E3490015_481D6C300084_var*
begin
//#UC START# *4D63E3490015_481D6C300084_impl*
 // ничего не делаем
//#UC END# *4D63E3490015_481D6C300084_impl*
end;//_evParaListPainter_.AfterDrawChild

procedure _evParaListPainter_.MakeBottomAnchorInnerAfterEnd(const anInner: InevBasePoint);
 {* Метод сделан, чтобы не тащить связь от Cursors в ParaListPainters }
//#UC START# *4E82C51501A9_481D6C300084_var*
//#UC END# *4E82C51501A9_481D6C300084_var*
begin
//#UC START# *4E82C51501A9_481D6C300084_impl*
 BottomAnchor.Inner := TnevAfterEndPoint.Make(Area.rView.As_InevView, anInner);
//#UC END# *4E82C51501A9_481D6C300084_impl*
end;//_evParaListPainter_.MakeBottomAnchorInnerAfterEnd

procedure _evParaListPainter_.CheckNeedLaterFilling(const aPainterHolder: InevPaintersHolder;
 const aChildMap: InevMap);
//#UC START# *4FD97F890377_481D6C300084_var*
//#UC END# *4FD97F890377_481D6C300084_var*
begin
//#UC START# *4FD97F890377_481D6C300084_impl*
 
//#UC END# *4FD97F890377_481D6C300084_impl*
end;//_evParaListPainter_.CheckNeedLaterFilling

function _evParaListPainter_.BeforeDrawChild(const ChildPainter: IevPainter): Boolean;
 {* Вызывается перед рисованием каждого дочернего параграфа. }
//#UC START# *481D6C56033A_481D6C300084_var*
//#UC END# *481D6C56033A_481D6C300084_var*
begin
//#UC START# *481D6C56033A_481D6C300084_impl*
 Result := True;
//#UC END# *481D6C56033A_481D6C300084_impl*
end;//_evParaListPainter_.BeforeDrawChild

function _evParaListPainter_.ChildInSelection(const aPara: InevPara): Boolean;
//#UC START# *481D6CB00337_481D6C300084_var*
//#UC END# *481D6CB00337_481D6C300084_var*
begin
//#UC START# *481D6CB00337_481D6C300084_impl*
 Result := false;
//#UC END# *481D6CB00337_481D6C300084_impl*
end;//_evParaListPainter_.ChildInSelection

function _evParaListPainter_.NeedCheckTopAnchor: Boolean;
//#UC START# *481D6CCF016D_481D6C300084_var*
//#UC END# *481D6CCF016D_481D6C300084_var*
begin
//#UC START# *481D6CCF016D_481D6C300084_impl*
 Result := True;
//#UC END# *481D6CCF016D_481D6C300084_impl*
end;//_evParaListPainter_.NeedCheckTopAnchor

function _evParaListPainter_.CheckCompleate: Boolean;
 {* [$114950787] }
//#UC START# *481D6CFA0047_481D6C300084_var*
//#UC END# *481D6CFA0047_481D6C300084_var*
begin
//#UC START# *481D6CFA0047_481D6C300084_impl*
 Result := False;
//#UC END# *481D6CFA0047_481D6C300084_impl*
end;//_evParaListPainter_.CheckCompleate

procedure _evParaListPainter_.CheckChild(const aPara: InevPara);
//#UC START# *49D30810030E_481D6C300084_var*
//#UC END# *49D30810030E_481D6C300084_var*
begin
//#UC START# *49D30810030E_481D6C300084_impl*
//#UC END# *49D30810030E_481D6C300084_impl*
end;//_evParaListPainter_.CheckChild

function _evParaListPainter_.Check4Printing(aHeight: Integer): Boolean;
//#UC START# *4A8122600201_481D6C300084_var*
var
 l_Height : Integer;
 l_Bounds : TnevRect;
 
 procedure lp_CorrectBottom;
 begin
  l_Bounds := Map.Bounds;
  l_Bounds.Bottom := l_Height;
  if Area.rCanvas.Printing then
   l_Bounds.Bottom := Min(l_Bounds.Bottom, Area.rCanvas.GlobalClipRect.Bottom);
  Map.SetDrawnBottom(l_Bounds.BottomRight);
 end;

var
 l_View    : InevView;
 l_Canvas  : Il3Canvas;
 l_Map     : InevMap;
 l_Area    : TnevShapeAreaEx;
 l_Result  : TnevShapeInfo;
 l_Point   : InevBasePoint;
 l_MostInn : InevBasePoint;
 l_Para    : InevParaList;
 l_CheckTop: Boolean;
//#UC END# *4A8122600201_481D6C300084_var*
begin
//#UC START# *4A8122600201_481D6C300084_impl*
 Result := False;
 if WasInit and (BottomAnchor <> nil) and TopAnchor.HasBaseLine then
  if not TopAnchor.AfterEnd and BottomAnchor.Obj^.AsObject.IsSame(TopAnchor.Obj^.AsObject) then
  begin
   l_Para := TopAnchor.Obj^.AsPara.AsList;
   l_Point := TopAnchor.InnerForChildThatNotAfterEnd(FormatInfo, nev_itNone);
   if l_Point <> nil then
   begin
    l_MostInn := l_Point.MostInner;
    if l_MostInn <> nil then
    begin
     l_CheckTop := not l_Point.Obj.OwnerObj.AsObject.IsSame(l_Para.AsObject);
     if f_PrevHeight = 0 then
     begin
      l_Canvas := Tl3VirtualCanvas.Make(l3Point(Max(ViewMetrics.LimitWidth, FormatInfo.Width), MaxInt));
      try
       l_View := TnevVirtualDrawView.Make(l_Para, FormatInfo.ParentInfo, l_Canvas, ViewMetrics);
       try
        l_Area.Init(l_View, l_Canvas, false);
        try
         l_Result := evDrawPara(l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}, l_Para, TopAnchor, nil, 0);
        finally
         l_Area.Free;
        end;//try..finally
        l_Map := l_View.MapByPoint(l_MostInn, l_CheckTop);
        if l_Map <> nil then
        begin
         l_Height := l_Result.rMap.Bounds.Bottom{ - l_Map.Bounds.Top};
         Inc(l_Height, Map.GetMaxTop);
         f_PrevHeight := l_Height;
         lp_CorrectBottom;
         Result := True;
        end; // if l_Map <> nil then
       finally
        l_View := nil;
       end;//try..finally
      finally
       l_Canvas := nil;
      end;//try..finally
     end // if f_PrevHeight = 0 then
     else
     begin
      l_Height := f_PrevHeight;
      f_PrevHeight := 0;
      lp_CorrectBottom;
      Result := True;
     end;
    end; // if l_MostInn <> nil then
   end; // if l_Point <> nil then
  end; // if BottomAnchor.AfterEnd and BottomAnchor.Obj^.IsSame(TopAnchor.Obj^) then
//#UC END# *4A8122600201_481D6C300084_impl*
end;//_evParaListPainter_.Check4Printing

function _evParaListPainter_.UseSelRange(const aSelRange: InevRange): Boolean;
//#UC START# *4BC5CECF025B_481D6C300084_var*
//#UC END# *4BC5CECF025B_481D6C300084_var*
begin
//#UC START# *4BC5CECF025B_481D6C300084_impl*
 Result := True;
//#UC END# *4BC5CECF025B_481D6C300084_impl*
end;//_evParaListPainter_.UseSelRange

procedure _evParaListPainter_.InitInnerBottom(const aChildInfo: TnevShapeInfo);
//#UC START# *4C4570AE0113_481D6C300084_var*
//#UC END# *4C4570AE0113_481D6C300084_var*
begin
//#UC START# *4C4570AE0113_481D6C300084_impl*
 if Area.rNeedBottom then
 begin
  BottomAnchor.Inner := aChildInfo.rBottom;
  f_PrevHeight := aChildInfo.rCalculatedHeight;
 end; // if Area.rNeedBottom then
//#UC END# *4C4570AE0113_481D6C300084_impl*
end;//_evParaListPainter_.InitInnerBottom

function _evParaListPainter_.NeedPrintingChild(const aChild: InevPara): Boolean;
//#UC START# *4CB4024B010A_481D6C300084_var*
//#UC END# *4CB4024B010A_481D6C300084_var*
begin
//#UC START# *4CB4024B010A_481D6C300084_impl*
 Result := False;
//#UC END# *4CB4024B010A_481D6C300084_impl*
end;//_evParaListPainter_.NeedPrintingChild

{$If NOT Defined(DesignTimeLibrary)}
class function _evParaListPainter_.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_481D6C300084_var*
//#UC END# *47A6FEE600FC_481D6C300084_var*
begin
//#UC START# *47A6FEE600FC_481D6C300084_impl*
 Result := True;
//#UC END# *47A6FEE600FC_481D6C300084_impl*
end;//_evParaListPainter_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function _evParaListPainter_.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_481D6C300084_var*

var
 l_DrawCompleted : Boolean absolute Result;
 l_Para          : InevParaList;
 l_RealPara      : InevParaList;
 l_Space         : TnevRect;
 l_FirstPara     : Integer;

 procedure DrawPara;
 var
  l_Vertical       : Boolean;
  l_CheckCompleat  : Boolean;
  l_ChildCaret     : InevBasePoint;
  l_LastParaIndex  : Integer;
  l_Limit          : Integer;
  l_ChildInfo      : TnevShapeInfo;
  l_PaintersHolder : InevPaintersHolder;
  l_Selected       : Boolean;
  l_SelectedToo    : Boolean;
  l_DrawFakeChild  : Boolean;

  function DrawChild(const aChild: InevPara; anIndex: Integer): Boolean;
  var
   l_ChildBlock         : InevRange;
   l_CheckChildBlock    : InevRange;
   l_ChildPainter       : IevPainter;
   l_ContinueDraw       : Boolean;
   l_ChildDrawCompleted : Boolean;
   l_RealTop            : InevBasePoint;
   l_Top                : InevBasePoint;

    procedure DrawChild;

     procedure InitMargin;
     begin//InitMargin
      if (l_FirstPara = anIndex) and (l_Vertical or IsTopAnchorAtStart) then
      // - Рисуем первый видимый параграф
      begin
       with Tl3Rect(l_Space).TopLeft do
       // - Здесь сдвигаем курсор отрисовки на отступы листа
       begin
        if NeedCheckTopAnchor then
        begin
         if IsTopAnchorAtStart and (RealTopAnchor = nil) then
         //if (l_FirstPara = nev_piFirst) then
          Area.rCanvas.MoveWindowOrg(Neg.e(l_Vertical));
        end//NeedCheckTopAnchor
        else
         if (l_FirstPara = 0) then
          Area.rCanvas.MoveWindowOrg(Neg.e(l_Vertical));
        Area.rCanvas.MoveWindowOrg(Neg.e(not l_Vertical));
       end;//with l_Space.TopLeft
       if not Area.rCanvas.IsVirtual then
        Area.rCanvas.MoveWindowOrg(l3PointY(VerticalAlignmentMargin).Neg);
      end;//l_FirstPara = anIndex
     end;//InitMargin

    var
     l_Points : TnevShapePoints;
    begin//DrawChild
     l_Points.rCheckCaret := nil;
     l_Points.rCheckSelection := nil;
     if (l_ChildCaret = nil) OR not l_ChildCaret.AsObject.IsSame(aChild.AsObject) then
      // - Позиция каретки находится не в текущем ребенке
     begin
      if l_ChildCaret = nil then
       l_Points.rCaret := nil
      else
       if l_FirstPara = anIndex then
        l_Points.rCheckCaret := l_ChildCaret;               
     end
     else
      l_Points.rCaret := l_ChildCaret;
     Push;
     try
      if BeforeDrawChild(l_ChildPainter) then
      begin
       if (l_ChildPainter = nil) then
       // - Параграф не умеет себя рисовать
        l_ChildDrawCompleted := True
       else
       begin
        l_ChildPainter.ParentPainter := Self;
        InitMargin;
        if l_SelectedToo then
         Area.rCanvas.BeginInvert;
        l_Points.rFake := False;
        if (l_FirstPara = anIndex) and (l_CheckChildBlock <> nil) then
         l_Points.rCheckSelection := l_CheckChildBlock;
        if (RealTopAnchor <> nil) then // Ячейку мы рисуем объединенную, а её начало не видно...
        begin
         l_Points.rTop := l_Top;
         l_Points.rFake := True;
         if (l_ChildCaret <> nil) and l_ChildCaret.AsObject.IsSame(RealTopAnchor.Obj^.AsObject) then
          l_Points.rCaret := l_ChildCaret;
        end
        else
         l_Points.rTop := l_Top;
        if l_DrawFakeChild then
        begin
         l_Points.rRealTop := l_RealTop; // Это начало ячейки, которую надо рисовать (объединенная, но начало не видно на экране)...
         if (l_CheckChildBlock <> nil) then
          l_Points.rCheckSelection := l_CheckChildBlock;
         if (l_Points.rCaret = nil) and (l_ChildCaret <> nil) then
          l_Points.rCheckCaret := l_ChildCaret;
        end
        else
         l_Points.rRealTop := nil;
        l_Points.rSelection := l_ChildBlock;
        if Area.rNeedBottom then
         l_Points.rPrevHeight := f_PrevHeight
        else
         l_Points.rPrevHeight := 0;
        if (l_ChildPainter.TableRowPainter <> nil) and not l_ChildPainter.TableRowPainter.CheckChildren(FormatInfo, Area.rCanvas.As_Il3Canvas) then
         l_ChildDrawCompleted := False
        else
         l_ChildDrawCompleted := l_ChildPainter.Draw(Area^, l_Points, l_ChildInfo);
        // - Рисуем ребенка
        if not Area.rCanvas.IsVirtual then
        begin
         if not Area.rCanvas.Printing and (l_PaintersHolder <> nil) then
         begin
          if (l_SelectedToo or l_Selected) then
           l_PaintersHolder.RemeberSelPart(l_ChildInfo.rMap, True);
          CheckNeedLaterFilling(l_PaintersHolder, l_ChildInfo.rMap);
         end; // if not Area.rCanvas.Printing and (l_PaintersHolder <> nil) then
         if l_SelectedToo then
          Area.rCanvas.EndInvert;
        end; // if not Area.rCanvas.IsVirtual then
       end;//l_ChildPainter = nil
       AfterDrawChild(aChild, l_ChildPainter, l_ChildInfo);
      end//BeforeDrawChild..
      else
      begin
       InitMargin;
       l_ChildDrawCompleted := True;
       l_ContinueDraw := False;
       l_Limit := anIndex;
      end;//BeforeDrawChild...
      InitInnerBottom(l_ChildInfo);
     finally
      Pop;
     end;//try..finally
    end;//DrawChild

  begin//DrawChild
   DrawingLastChild := (anIndex = l_LastParaIndex);
   Result := False;
   // - По умолчанию - выход из итератора
   l_ContinueDraw := True;
   with Area.rCanvas do
   begin
    if (SelRange = nil) or not UseSelRange(SelRange) then
     l_ChildBlock := nil
    else
     l_ChildBlock := SelRange.GetChildSel(Area.rView.As_InevView, anIndex, True);
    // - Получаем выделение текущего параграфа
    try
     if aChild.AsObject.QT(IevPainter, l_ChildPainter) then
     // - Получаем интерфейс к парню, который умеет рисовать текущий параграф
      try
       l_ChildPainter.ParentPainter := Self;
       CheckChild(aChild);
       l_DrawFakeChild := (ParentPainter <> nil) and (ParentPainter.TablePainter <> nil) and not ParentPainter.TablePainter.WasPainted(aChild.AsObject, aChild.PID, False);
       if RealTopAnchor <> nil then // Ячейку мы рисуем объединенную, а её начало не видно...
       begin
        l_Top := RealTopAnchor.InnerFor(aChild, l_RealTop);
        if (CheckSelRange <> nil) then
        begin
         l_ChildBlock := CheckSelRange.GetChildSel(Area.rView.As_InevView, RealTopAnchor.Obj^.PID, True);
         if l_ChildBlock <> nil then
          l_ChildBlock := l_ChildBlock.GetChildSel(Area.rView.As_InevView, anIndex, True);
        end;
       end // if RealTopAnchor <> nil then
       else
        if Area.rCanvas.Printing and TopAnchor.HasHeadPart and TopAnchor.AfterEnd then
        begin
         l_Top := nil;
         if NeedPrintingChild(aChild) then
          l_RealTop := TopAnchor.InnerHead(aChild.PID)
         else
          l_RealTop := nil;
        end // if Area.rCanvas.Printing and TopAnchor.AfterEnd then
        else
         l_Top := TopAnchor.InnerFor(aChild, l_RealTop);
       l_Selected := (l_ChildBlock <> nil) AND l_ChildBlock.Solid(Area.rView.As_InevView);
       if l_DrawFakeChild and (l_RealTop <> nil) and (CheckSelRange <> nil) then
       begin
        l_CheckChildBlock := CheckSelRange.GetChildSel(Area.rView.As_InevView, l_RealTop.Obj^.OwnerObj.PID, True);
        l_Selected := (l_CheckChildBlock <> nil) AND l_CheckChildBlock.Solid(Area.rView.As_InevView);
       end // if l_DrawFakeChild then
       else
        if (SelRange <> nil) then
         l_CheckChildBlock := SelRange
        else
         l_CheckChildBlock := nil;
       if not IsVirtual and not l_Selected then
        l_SelectedToo := ChildInSelection(aChild)
       else
        l_SelectedToo := False;
       if l_Selected then
       begin
        // - Текущий параграф внутри выделения
        BeginInvert;
        try
         DrawChild;
         // - Рисуем текущий параграф
        finally
         EndInvert;
        end;//try..finally
       end//l_ChildBlock <> nil
       else
        DrawChild;
        // - Рисуем текущий параграф
      finally
       l_ChildPainter := nil;
      end;//try..finally
    finally
     l_ChildBlock := nil;
    end;//try..finally
    if HasToDraw AND l_ContinueDraw then
    begin
     if not l_ChildDrawCompleted then
      l_DrawCompleted := False;     
     if (l_ChildInfo.rMap <> nil) then
      WindowOrg := l3PointD0(-Tl3Rect(l_ChildInfo.rMap.Bounds).BottomRight.P.bPt[l_Vertical],
                             WindowOrg.P.bPt[not l_Vertical],
                             l_Vertical);
      // - Смещаем курсор отрисовки к следующему параграфу
      //   на высоту/ширину текущего рисуемого ребёнка
     if (ClipRect.R.BottomRight.P.bPt[l_Vertical] <= 0) then
     // - Если уперлись в конец экрана (области отсечения) то ВЫХОД
      if l_Vertical then
      // - рисуем по вертикали и рисовать похоже уже нечего
       Exit
      else
      if (Caret = nil) OR
         // - нас не просили рисовать курсор
         not ShowCursor
         // - курсор мы уже нарисовали где-то выше
         then
      // - рисуем по горизонтали и рисовать похоже уже нечего
       Exit;
     if not l_ChildDrawCompleted AND l_Vertical then
     // - абзац или картинка нарисованы не полностью -
     //   видимо упёрлись в край листа бумаги
      Exit;
     Result := True;
     // - Иначе - продолжаем рисование
    end;//HasToDraw
   end;//with Area.rCanvas
   DrawingTopmostChild := False;
  end;//DrawChild

 var
  l_RealFI: TnevFormatInfoPrim;
 begin//DrawPara
  l_Space := Spaces;
  // - здесь была заплатка: http://mdp.garant.ru/pages/viewpage.action?pageId=77237790
  if not Area.rCanvas.IsVirtual and (ParentPainter <> nil) then
   l_PaintersHolder := ParentPainter.PaintersHolder;
  l_Vertical := l_Para.IsVertical;
  l_CheckCompleat := CheckCompleate;
  PushWO;
  try
   if l_RealPara <> nil then
    l_LastParaIndex := Pred(l_RealPara.ParaCount)
   else
    l_LastParaIndex := Pred(l_Para.ParaCount);
   if (l_LastParaIndex < 0) then
    Exit
   else
   if RealTopAnchor <> nil then
   begin
    l_RealFI := FormatInfo.ParentInfo;
    l_RealFI := l_RealFI.ParentInfo;
    l_RealFI := l_RealFI.InfoForChild(RealTopAnchor.Obj^.OwnerObj);
    l_RealFI := l_RealFI.InfoForChild(RealTopAnchor.Obj^);
    l_FirstPara := Max(0, RealTopAnchor.VertPosition(Area.rView.As_InevView, l_RealFI));
   end // if RealTopAnchor <> nil then
   else
    l_FirstPara := Max(0, TopAnchor.VertPosition(Area.rView.As_InevView, FormatInfo));
   if (Caret = nil) then
   begin
    l_ChildCaret := nil;
    if CheckCaret <> nil then
     l_ChildCaret := CheckCaret.Inner;
   end
   else
    l_ChildCaret := Caret.Inner;
   l_Limit := l_LastParaIndex;
   Push;
   try
    DrawingTopmostChild := True;
    if l_Para.AsObject.IsSame(TopAnchor.Obj^.AsObject) or (RealTopAnchor <> nil) then // В случае объединенной ячейки условие выполняться не будет...
    begin
     if l_RealPara <> nil then // Может быть нужно инициализировать раньше...
      l_Para := l_RealPara;
     if TopAnchor.BeforeStart and l_Vertical then
      Area.rCanvas.MoveWindowOrg(l3PointY(-l3Epsilon))
     else
      if (l_Para.IterateParaF(nevL2PIA(@DrawChild), l_FirstPara) < l_Limit) then
       if l_Vertical and not l_CheckCompleat then
        if TopAnchor.AfterEnd then // Это тоже нужно проверить...
         // - курсор стоит за всеми параграфами
         Area.rCanvas.MoveWindowOrg(l3PointY(-l3Epsilon))
         // - это надо чтобы высота параграфа отличалась от нуля
        else
         l_DrawCompleted := False;
     end//l_Para.IsSame(TopAnchor.Obj)
    else
    begin
     {$IFDEF Nemesis}
     Assert(false, 'А может ли такое быть?');
     {$ELSE}
     l3System.Msg2Log('Параграф: %s PID = %d TopAnchor.Obj: %s PID = %d', [l_Para.TagType.AsString, l_Para.PID, TopAnchor.Obj^.TagType.AsString, TopAnchor.Obj.PID]);
     l3System.Msg2Log('Родительский параграф: %s PID = %d родительский TopAnchor.Obj: %s PID = %d', [l_Para.OwnerPara.TagType.AsString, l_Para.OwnerPara.PID, TopAnchor.Obj^.OwnerObj.TagType.AsString, TopAnchor.Obj^.OwnerObj.PID]);
     {$ENDIF Nemesis}
     Area.rCanvas.MoveWindowOrg(l3PointY(FormatInfo.Height - l_Space.Top));
    end;//l_Para.IsSame(TopAnchor.Obj)
   finally
    Pop;
   end;//try..finally
  finally
   PopWO;
  end;//try..finally
 end;//DrawPara

//#UC END# *4804BC2401C2_481D6C300084_var*
begin
//#UC START# *4804BC2401C2_481D6C300084_impl*
 l_Para := ParaX;
 if RealTopAnchor <> nil then
  l_RealPara := RealTopAnchor.Obj^.AsPara.AsList
 else
  l_RealPara := nil;
 l_DrawCompleted := True;
 if (SelRange <> nil) AND SelRange.Solid(Area.rView.As_InevView) then
 begin
  Area.rCanvas.BeginInvert;
  try
   DrawPara;
  finally
   Area.rCanvas.EndInvert;
  end;//try..finally
 end//SelRange <> nil
 else
  DrawPara;
//#UC END# *4804BC2401C2_481D6C300084_impl*
end;//_evParaListPainter_.DoDraw

procedure _evParaListPainter_.InitBottom(var theBottom: InevBasePoint;
 var theCellBottom: InevBasePoint);
//#UC START# *4804BC800172_481D6C300084_var*
var
 l_Inn : InevBasePoint;
 l_Pos : Integer;
//#UC END# *4804BC800172_481D6C300084_var*
begin
//#UC START# *4804BC800172_481D6C300084_impl*
 theCellBottom := nil;
 l_Inn := theBottom.Inner;
 if (l_Inn <> nil) AND l_Inn.AfterEnd then
 begin
  l_Pos := theBottom.Position;
  if (l_Pos = theBottom.Obj.AsObject.ChildrenCount) then
   theBottom := TnevAfterEndPoint.DoMake(theBottom)
  else
   theBottom.PositionW := l_Pos + 1;
 end;//l_Inn <> nil
//#UC END# *4804BC800172_481D6C300084_impl*
end;//_evParaListPainter_.InitBottom
{$IfEnd} // Defined(evNeedPainters)

{$EndIf evParaListPainter_imp_impl}

{$EndIf evParaListPainter_imp}

