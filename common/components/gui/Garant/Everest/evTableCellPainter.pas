unit evTableCellPainter;
 {* Реализация интерфейса IevPainter для ячеек }

// Модуль: "w:\common\components\gui\Garant\Everest\evTableCellPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableCellPainter" MUID: (481D6D3F003F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , nevTools
 , nevRealTools
 , l3Variant
 , l3Interfaces
 , nevBase
 , l3InternalInterfaces
 , l3Units
 , l3ProtoObject
;

type
 _X_ = InevTableCell;
 {$Include w:\common\components\gui\Garant\Everest\evParaListPainter.imp.pas}
 TevTableCellPainter = class(_evParaListPainter_)
  {* Реализация интерфейса IevPainter для ячеек }
  private
   function GetTablePainter: IevTablePainter;
  protected
   function pm_GetVerticalAlignmentMargin: Integer; override;
   procedure DoFillSelection; override;
   procedure GetFramePartPrim(aFrame: Tl3Variant;
    anIndex: Tl3FramePartIndex;
    var thePart: TnevFramePart); override;
   function DoDraw: Boolean; override;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure InitBottom(var theBottom: InevBasePoint;
    var theCellBottom: InevBasePoint); override;
   function BeforeDrawChild(const ChildPainter: IevPainter): Boolean; override;
    {* Вызывается перед рисованием каждого дочернего параграфа. }
   function CheckCompleate: Boolean; override;
    {* [$114950787] }
   procedure DoDrawFramePrim(const aFrame: Tl3Frame); override;
   function UseSelRange(const aSelRange: InevRange): Boolean; override;
   function NeedsHackK235870994: Boolean; override;
   function IsTopAnchorAtStart: Boolean; override;
 end;//TevTableCellPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , SysUtils
 , l3VirtualCanvas
 , nevVirtualDrawView
 , evParaDrawTools
 {$If Defined(evUseVisibleCursors)}
 , nevAfterEndPoint
 {$IfEnd} // Defined(evUseVisibleCursors)
 , l3MinMax
 , nevFacade
 , l3Const
 , Graphics
 , l3SmartCanvas
 , l3Base
 , l3Tree
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , TableCell_Const
 , DocumentSub_Const
 , Mark_Const
 , LeafPara_Const
 , CommentPara_Const
 , Block_Const
 , TextPara_Const
 , k2Base
 , Table_Const
 , Windows
 //#UC START# *481D6D3F003Fimpl_uses*
 //#UC END# *481D6D3F003Fimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\evParaListPainter.imp.pas}

function TevTableCellPainter.GetTablePainter: IevTablePainter;
//#UC START# *52B3CE5501D4_481D6D3F003F_var*
//#UC END# *52B3CE5501D4_481D6D3F003F_var*
begin
//#UC START# *52B3CE5501D4_481D6D3F003F_impl*
 Result := nil;
 if (ParentPainter <> nil) and (ParentPainter.ParentPainter <> nil) then
  Result := ParentPainter.ParentPainter.TablePainter;
//#UC END# *52B3CE5501D4_481D6D3F003F_impl*
end;//TevTableCellPainter.GetTablePainter

function TevTableCellPainter.pm_GetVerticalAlignmentMargin: Integer;
//#UC START# *4804AA7A003A_481D6D3F003Fget_var*

 function lp_CheckTopHead: Boolean;
 var
  l_Para      : InevPara;
  l_Cell      : InevTableCell;
  l_DrawView  : InevDrawView;
  l_HeadCell  : InevTableCell;
  l_MaxIndex  : Integer;
  l_TopAnchor : InevBasePoint;
 begin
  Result := False;
  if not Area.rCanvas.Printing then
  begin
   l_MaxIndex := FormatInfo.ParentInfo.GreatestObjPID;
   l_Para := ParaX.OwnerPara[l_MaxIndex];
   if (l_Para.OverlapType = otLower) then
   begin
    l_TopAnchor := ParentPainter.TableRowPainter.GetTopAnchor4Row;
    if (l_TopAnchor <> nil) then
    begin
     if not l_Para.AsObject.QT(InevTableCell, l_Cell) then
      Assert(false);
     l_HeadCell := l_Cell.GetMergeHead;
     if (l_HeadCell <> nil) then
      Result := l_TopAnchor.Obj^.PID > l_HeadCell.OwnerPara.PID;
    end; // if (l_TopAnchor <> nil) then
   end; // if (l_Para.OverlapType = otLower) then
  end; // if not Area.rCanvas.Printing then
 end;

var
 l_OuterMap  : TnevFormatInfoPrim;
 l_VertAlign : TevVerticalAligment;
//#UC END# *4804AA7A003A_481D6D3F003Fget_var*
begin
//#UC START# *4804AA7A003A_481D6D3F003Fget_impl*
 Result := inherited pm_GetVerticalAlignmentMargin;
 if (TevMergeStatus(ParaX.AsObject.IntA[k2_tiMergeStatus]) <> ev_msNone) then
  Exit;
 l_VertAlign := TevVerticalAligment(ParaX.AsObject.IntA[k2_tiVerticalAligment]);
 if (l_VertAlign <> ev_valTop) then
 begin
  Assert(FormatInfo <> nil);
  l_OuterMap := FormatInfo.ParentInfo;
  Assert(l_OuterMap <> nil);
  Assert(l_OuterMap.DeltaHeight > 0);
  if (FormatInfo.ParentInfo.GreatestObjPID = ParaX.PID) then
   Result := 0
  else
  begin
   Result := FormatInfo.VerticalAlignmentMargin;
   if not ParentPainter.TableRowPainter.IsTopAnchorAtStart or lp_CheckTopHead then
    if TopAnchor.AtStart then
     ParentPainter.TableRowPainter.CorrectTopDelta(Result)
    else
     Result := 0;
  end; // if Area.rCanvas.Printing then
 end;//(l_VertAlign <> ev_valTop)
 // - это всё закоментированно в предверии перехода на TnevFormatInfoPrim и Formatter'ы.
//#UC END# *4804AA7A003A_481D6D3F003Fget_impl*
end;//TevTableCellPainter.pm_GetVerticalAlignmentMargin

procedure TevTableCellPainter.DoFillSelection;
//#UC START# *4804B86403BE_481D6D3F003F_var*

 procedure lp_CheckAndFillStyledCell;
 var
  l_Rect: Tl3Rect;
 begin
  l_Rect := Tl3Rect(Map.Bounds);
  if (TevMergeStatus(ParaX.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue) then
   l_Rect.Bottom := l_Rect.Bottom + f_FormatInfo.ParentInfo.Height + 1;
  with l_Rect do
   with Area.rCanvas do
    FillUnfilled(l3RectBnd(Tl3Point(nevPt0), BottomRight.Add(WindowOrg)));
 end;

var
 l_TablePainter: IevTablePainter;
//#UC END# *4804B86403BE_481D6D3F003F_var*
begin
//#UC START# *4804B86403BE_481D6D3F003F_impl*
 l_TablePainter := GetTablePainter;
 if (ParentPainter = nil) OR (ParentPainter.ParentPainter = nil) OR
    (ParentPainter.ParentPainter.PaintersHolder = nil) then
  inherited
 else
  if (l_TablePainter <> nil) and l_TablePainter.HasOwnStyle then
   lp_CheckAndFillStyledCell;
  // Ничего не заливаем для ячейки - это задача отложенной заливки.
 if (l_TablePainter <> nil) then
  l_TablePainter.CalcOffset;
//#UC END# *4804B86403BE_481D6D3F003F_impl*
end;//TevTableCellPainter.DoFillSelection

procedure TevTableCellPainter.GetFramePartPrim(aFrame: Tl3Variant;
 anIndex: Tl3FramePartIndex;
 var thePart: TnevFramePart);
//#UC START# *4804B9BB0383_481D6D3F003F_var*
//#UC END# *4804B9BB0383_481D6D3F003F_var*
begin
//#UC START# *4804B9BB0383_481D6D3F003F_impl*
 inherited;
 if thePart.rDrawType = lpdHidden then
  thePart.rDrawType := lpdSpecialDraw;
 if (thePart.rDrawType = lpdSpecialDraw) AND Area.rCanvas.DrawSpecial then
  thePart.rWidth := 1;
 if Area.rCanvas.Printing and (anIndex = l3_fpiUp) then
  if TopAnchor.HasInner and (TopAnchor.Inner.Obj.PID > 0) then
   thePart.rDrawType := lpdHidden
  else
   if TopAnchor.AfterEnd then
    thePart.rDrawType := lpdHidden;
//#UC END# *4804B9BB0383_481D6D3F003F_impl*
end;//TevTableCellPainter.GetFramePartPrim

function TevTableCellPainter.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_481D6D3F003F_var*
//#UC END# *4804BC2401C2_481D6D3F003F_var*
begin
//#UC START# *4804BC2401C2_481D6D3F003F_impl*
 Result := inherited DoDraw;
 if Area.rCanvas.Printing and not Result then
  Result := CheckCompleate;
//#UC END# *4804BC2401C2_481D6D3F003F_impl*
end;//TevTableCellPainter.DoDraw

procedure TevTableCellPainter.InitBottom(var theBottom: InevBasePoint;
 var theCellBottom: InevBasePoint);
//#UC START# *4804BC800172_481D6D3F003F_var*
//#UC END# *4804BC800172_481D6D3F003F_var*
begin
//#UC START# *4804BC800172_481D6D3F003F_impl*
 theCellBottom := nil;
 if (TevMergeStatus(ParaX.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue) then
 begin
  if theBottom.HasInner and (RealTopAnchor <> nil) and not RealTopAnchor.AfterEnd then
   if theBottom.Inner.AfterEnd then
    theCellBottom := TnevAfterEndPoint.DoMake(theBottom)
   else
   begin
    theCellBottom := RealTopAnchor.ClonePoint(Area.rView.As_InevView);
    theCellBottom.Inner := theBottom.Inner;
   end;
  theBottom := TnevAfterEndPoint.DoMake(theBottom);
 end
 else
  if TopAnchor.Obj^.AsObject.IsSame(ParaX.AsObject) and TopAnchor.AfterEnd then
   theBottom := TnevAfterEndPoint.DoMake(theBottom)
  else
   inherited;
//#UC END# *4804BC800172_481D6D3F003F_impl*
end;//TevTableCellPainter.InitBottom

function TevTableCellPainter.BeforeDrawChild(const ChildPainter: IevPainter): Boolean;
 {* Вызывается перед рисованием каждого дочернего параграфа. }
//#UC START# *481D6C56033A_481D6D3F003F_var*
//#UC END# *481D6C56033A_481D6D3F003F_var*
begin
//#UC START# *481D6C56033A_481D6D3F003F_impl*
 Result := inherited BeforeDrawChild(ChildPainter);
 if DrawingLastChild AND (ChildPainter <> nil) then
  ChildPainter.ParaMarkStyle := ev_pmCell;
//#UC END# *481D6C56033A_481D6D3F003F_impl*
end;//TevTableCellPainter.BeforeDrawChild

function TevTableCellPainter.CheckCompleate: Boolean;
 {* [$114950787] }
//#UC START# *481D6CFA0047_481D6D3F003F_var*
//#UC END# *481D6CFA0047_481D6D3F003F_var*
begin
//#UC START# *481D6CFA0047_481D6D3F003F_impl*
 // [$114950787]
 Result := (TevMergeStatus(ParaX.AsObject.IntA[k2_tiMergeStatus]) <> ev_msNone);
//#UC END# *481D6CFA0047_481D6D3F003F_impl*
end;//TevTableCellPainter.CheckCompleate

procedure TevTableCellPainter.DoDrawFramePrim(const aFrame: Tl3Frame);
//#UC START# *49182FE60081_481D6D3F003F_var*

 procedure CopyFrameData(var aFrame: Tl3Frame;
   aFrameTag: Tl3Variant);                              
 var
  l_Index : Tl3FramePartIndex;
 begin
  for l_Index := Low(l_Index) to High(l_Index) do
  begin
   GetFramePart(aFrameTag, l_Index, aFrame.rP[l_Index]);
   if (l_Index = l3_fpiDown) then
    if Area.rCanvas.Printing or (aFrame.rP[l_Index].rDrawType = lpdDraw) then
     aFrame.rP[l_Index].rDrawType := lpdDraw;
   if l_Index = l3_fpiUp then
    aFrame.rP[l_Index].rDrawType := lpdHidden;
  end; // for l_Index := Low(l_Index) to High(l_Index) do
 end;//CopyFrameData

var
 l_Frame       : Tl3Frame;
 l_AnalizeType : Tl3FrameAnalizeType;
 l_TablePainter: IevTablePainter;            

 procedure lp_ApplyHeadData(const aHeadCell: InevObject);
 begin
  if aHeadCell <> nil then 
   CopyFrameData(l_Frame, aHeadCell.AsObject.Attr[k2_tiFrame]);
  if (ParaX.GetContinueCell(True, fc_Down) = nil) then
   l_AnalizeType := laAddOnly
  else
  begin
   l_AnalizeType := laDelayAlignLowLine;
   l_TablePainter.CheckCell(ParaX.AsObject, nev_NeedAdd);
  end;
 end;

var
 l_MergeS   : TevMergeStatus;
 l_Visible  : Boolean;
 l_Index    : Tl3FramePartIndex;
 l_Head     : InevTableCell;
 l_Continue : InevPara;
 l_FrameTag : Tl3Variant;
//#UC END# *49182FE60081_481D6D3F003F_var*
begin
//#UC START# *49182FE60081_481D6D3F003F_impl*
 l_Visible := False;
 l_TablePainter := GetTablePainter;
 l_AnalizeType := laAddOnly;
 for l_Index := Low(l_Index) to High(l_Index) do
  if (aFrame.rP[l_Index].rDrawType <> lpdHidden) then
   l_Visible := True;
 if not Area.rCanvas.IsVirtual and l_Visible then
 begin
  l_Frame := aFrame;
  l_MergeS := TevMergeStatus(ParaX.AsObject.IntA[k2_tiMergeStatus]);
  if l_MergeS = ev_msContinue then
  begin
   if (l_TablePainter <> nil) and not l_TablePainter.WasPainted(ParaX.AsObject, ParaX.PID, True) then
   begin
    l_Head := ParaX.GetMergeHead;
    lp_ApplyHeadData(l_Head);
   end // if (ParentPainter <> nil) and (ParentPainter.ParentPainter <> nil) and
   else
    if Area.rCanvas.Printing and (RealTopAnchor <> nil) then
     lp_ApplyHeadData(RealTopAnchor.Obj^)
    else
     if (l_TablePainter <> nil) and (ParaX.GetContinueCell(True, fc_Down) = nil) then
     begin
      l_AnalizeType := laCheckOnly;
      l_TablePainter.CheckCell(ParaX.AsObject, nev_CheckOnly);
     end // if (ParaX.GetContinueCell(True, fc_Down) = nil) then
     else
      l_AnalizeType := laDoNothing
  end // if l_MergeS = ev_msContinue then
  else
   if (l_MergeS = ev_msHead) then
   begin
    if (ParaX.GetContinueCell(True, fc_Down) <> nil) then
     l_AnalizeType := laDelayAlignLowLine
    else
     l_AnalizeType := laAddOnly;
    if Area.rCanvas.Printing then
    begin
     l_Continue := ParaX.GetContinueCell(True, fc_Up);
     if (l_Continue <> nil) then
     begin
      l_FrameTag := l_Continue.AsObject.Attr[k2_tiFrame];
      if l_FrameTag.IsValid and l_FrameTag.Attr[k2_tiFrameDown].IsValid then
       l_Frame.rP[l3_fpiUp].rDrawType := lpdDraw;
     end; // if (l_Continue <> nil) then
    end; // if Area.rCanvas.Printing then
   end; // if (l_MergeS = ev_msHead) then
  Area.rCanvas.FrameLines.AddFrame(Area.rCanvas.As_Il3Canvas, Integer(ParaX.OwnerPara.OwnerPara.AsObject.Box), l_Frame, l_AnalizeType);
 end // if not Area.rCanvas.IsVirtual and l_Visible then
 else
  inherited;
//#UC END# *49182FE60081_481D6D3F003F_impl*
end;//TevTableCellPainter.DoDrawFramePrim

function TevTableCellPainter.UseSelRange(const aSelRange: InevRange): Boolean;
//#UC START# *4BC5CECF025B_481D6D3F003F_var*
//#UC END# *4BC5CECF025B_481D6D3F003F_var*
begin
//#UC START# *4BC5CECF025B_481D6D3F003F_impl*
 Result := TevMergeStatus(aSelRange.AsObject.IntA[k2_tiMergeStatus]) <> ev_msContinue;
//#UC END# *4BC5CECF025B_481D6D3F003F_impl*
end;//TevTableCellPainter.UseSelRange

function TevTableCellPainter.NeedsHackK235870994: Boolean;
//#UC START# *4CAF3D530327_481D6D3F003F_var*
//#UC END# *4CAF3D530327_481D6D3F003F_var*
begin
//#UC START# *4CAF3D530327_481D6D3F003F_impl*
 Result := false{true};
//#UC END# *4CAF3D530327_481D6D3F003F_impl*
end;//TevTableCellPainter.NeedsHackK235870994

function TevTableCellPainter.IsTopAnchorAtStart: Boolean;
//#UC START# *4D9AF3680146_481D6D3F003F_var*
//#UC END# *4D9AF3680146_481D6D3F003F_var*
begin
//#UC START# *4D9AF3680146_481D6D3F003F_impl*
 Result := inherited IsTopAnchorAtStart;
 Assert((ParentPainter.TableRowPainter <> nil) and (ParentPainter.TablePainter = nil), 'Ошибка в данных! Ячейка должна быть дочерней к строке таблицы, а не к самой таблице!');
 if Result and (TevVerticalAligment(ParaX.AsObject.IntA[k2_tiVerticalAligment]) > ev_valTop) then
  Result := ParentPainter.TableRowPainter.IsTopAnchorAtStart;
//#UC END# *4D9AF3680146_481D6D3F003F_impl*
end;//TevTableCellPainter.IsTopAnchorAtStart
{$IfEnd} // Defined(evNeedPainters)

end.
