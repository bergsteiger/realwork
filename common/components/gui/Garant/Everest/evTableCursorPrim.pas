unit evTableCursorPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evTableCursorPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableCursorPrim" MUID: (4EF9B83D010D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursor
 , evInternalInterfaces
 , l3IID
 , nevTools
 , nevBase
 , l3Interfaces
 , l3Types
;

type
 TevTableCursorPrim = class(TevParaListCursor{$If Defined(evNeedHotSpot)}
 , IevChangeParamTool
 {$IfEnd} // Defined(evNeedHotSpot)
 )
  protected
   {$If Defined(evNeedHotSpot)}
   function ChangeParam(const aMarker: IevMarker;
    aValue: Integer;
    const anOpPack: InevOp;
    SeeByLevel: Boolean = False;
    aMinIndex: Tl3Index = l3Types.l3MinIndex;
    aMaxIndex: Tl3Index = l3Types.l3MaxIndex): Boolean;
    {* Изменить значение параметра }
   {$IfEnd} // Defined(evNeedHotSpot)
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); override;
   {$IfEnd} // Defined(evNeedMarkers)
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TevTableCursorPrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , SysUtils
 , evdTypes
 , l3Units
 , k2Interfaces
 , l3MinMax
 , evConst
 , nevInterfaces
 , evTableMarker
 , k2Tags
 , l3Variant
;

{$If Defined(evNeedHotSpot)}
function TevTableCursorPrim.ChangeParam(const aMarker: IevMarker;
 aValue: Integer;
 const anOpPack: InevOp;
 SeeByLevel: Boolean = False;
 aMinIndex: Tl3Index = l3Types.l3MinIndex;
 aMaxIndex: Tl3Index = l3Types.l3MaxIndex): Boolean;
 {* Изменить значение параметра }
//#UC START# *4A26260A00E6_4EF9B83D010D_var*
var
 l_OriginalValue       : Long;
 l_OriginalMarkerValue : Long;
 theMarker             : IevColumnBorderMarker;
 l_ChangePID           : Integer;
 l_MarkerRow           : InevParaList;
 l_MarkerCellPID       : Integer;
 l_MarkerCellWidth     : Integer;

  procedure lp_InitMarkerChldParams;
  var
   l_Pt : TnevPoint;
  begin
   if not theMarker.Para.AsObject.QT(InevParaList, l_MarkerRow) then
    Assert(False, Format('Интерфейс InevParaList не поддерживается [%s]',
                           [ClassName]));
   l_Pt := aMarker.View.FormatInfoByPara(l_MarkerRow).ParentToClient(l3PointX(l_OriginalValue), nev_plNearest);
   l_MarkerCellPID := (l_MarkerRow As InevTableRow).FindCell(l_Pt.X, 0);
   l_MarkerCellWidth := l_MarkerRow[l_MarkerCellPID].AsObject.IntA[k2_tiWidth];
  end;

  function lp_ChildFunc(aChild: Tl3Variant; anIndex: Long): Bool;
  var
   l_CellPID    : Long;
   l_LeftBorder : Long;
   l_PrevBorder : Long;       

   function lp_CellFunc(aChild: Tl3Variant; anIndex: Long): Bool;
   begin
    l_PrevBorder := l_LeftBorder;
    Result := anIndex < l_CellPID;
    l_LeftBorder := l_LeftBorder + aChild.IntA[k2_tiWidth];
   end;

   function lp_FindMergeCellFunc(aChild: Tl3Variant; anIndex: Long): Bool;
   var
    l_Head: InevTableCell;
   begin
    Result := True;
    if TevMergeStatus(aChild.IntA[k2_tiMergeStatus]) = ev_msContinue then
    begin
     aChild.QT(InevTableCell, l_Head);
     l_Head := l_Head.GetMergeHead;
     if l_Head = nil then
      l_ChangePID := High(Integer)
     else
      l_ChangePID := Min(l_ChangePID, l_Head.OwnerPara.PID);
    end; // if not Result then
   end;

  var
   l_Row    : InevParaList;
   l_Value  : Long;
   l_Marker : IevMarker;

   procedure lp_MakeMakrerCopy(aRecalcValue: Boolean);
   begin
    l_Marker := theMarker.MakeCopy(l_Row);
    (l_Marker as IevColumnBorderMarker).ColumnID := l_CellPID + 1;
    if aRecalcValue then
     l_Value := l_Marker.Value + l_Value - l_OriginalMarkerValue;
   end;

  var
   l_Pt        : TnevPoint;
   l_WasRecalc : Boolean;
   l_HasHead   : Boolean;
   l_OuterCell : Boolean;
  begin//ChildFunc
   Result := True;
   l_Marker := nil;
   try
    l_Value := aValue;
    l_WasRecalc := False;
    if theMarker.Para.AsObject.IsSame(aChild) then
    begin
     l_Marker := theMarker;
     l_CellPID := l_MarkerCellPID;
     l_Row := l_MarkerRow;
    end // if theMarker.Para.IsSame(aChild) then
    else
    begin
     if not aChild.QT(InevParaList, l_Row) then
      Assert(False, Format('Интерфейс InevParaList не поддерживается [%s]',
                           [ClassName]));
     begin
      l_Pt := aMarker.View.FormatInfoByPara(l_Row).ParentToClient(l3PointX(l_OriginalValue), nev_plNearest);
      l_CellPID := (l_Row As InevTableRow).FindCell(l_Pt.X, 0);
      l_LeftBorder := l_Row.AsObject.IntA[k2_tiLeftIndent];
      l_Row.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CellFunc));
      if (Abs(l_LeftBorder - l_OriginalValue) <= evFindCellDelta) then // Положение маркеров совпадают.
       lp_MakeMakrerCopy(False)
      else
       if (l_ChangePID <= l_Row.PID) then // Обработка объединенных ячеек
       begin
        lp_MakeMakrerCopy(True);
        l_WasRecalc := True;
       end // if (l_ChangePID <= l_Row.PID) then
       else
        begin
         l_OuterCell := (l_PrevBorder < l_OriginalValue) and (l_LeftBorder > l_OriginalValue);
         if l_OuterCell then // Охватывающая ячейка
         begin
          lp_MakeMakrerCopy(True);
          l_WasRecalc := True;
         end;//if l_OuterCell ...
        end;
     end; // if not aChild.QT(InevParaList, l_Row) then
    end;//theMarker.Para.IsSame(aChild)
    if not l_WasRecalc and (l_ChangePID >= l_Row.PID) then
    begin
     l_Row.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_FindMergeCellFunc), l_CellPID + 1);
     if (l_ChangePID < l_Row.PID) then
      lp_MakeMakrerCopy(True);
    end;//if l_ChangePID >= l_Row.PID then
    if (l_Marker <> nil) then
     l_Marker.SetValue(l_Value, anOpPack);
   finally
    l_Marker := nil;
   end;{try..finally}
  end;//ChildFunc

//#UC END# *4A26260A00E6_4EF9B83D010D_var*
begin
//#UC START# *4A26260A00E6_4EF9B83D010D_impl*
 // Работа идет не в "реальных" координатах. При расчетах используем информацию
 // из k2_tiWidth, т.е. координаты тут немного "псевдо".
 Result := False;
 if Supports(aMarker, IevColumnBorderMarker, theMarker) then
  try
   if SeeByLevel then
   begin
    if (theMarker.CompareLevel(GetRedirect) <> 1) then
     Exit;
    with theMarker do
    begin
     l_OriginalMarkerValue := Value;
     l_OriginalValue := aMarker.View.FormatInfoByPara(Para).ClientToParent(ClientValue, nev_plNearest);
    end;//with theMarker
   end//SeeByLevel
   else
   begin
    if not GetRedirect.IsSame(theMarker.Para.OwnerTag) then
     Exit;
    with theMarker do
    begin
     l_OriginalMarkerValue := Value;
     l_OriginalValue := aMarker.View.FormatInfoByPara(Para).ClientToParent(ClientValue, nev_plNearest);
    end;//with theMarker
   end;//SeeByLevel
   l_ChangePID := High(Integer);
   lp_InitMarkerChldParams;
   GetRedirect.IterateChildrenBackF(L2Mk2ChildrenIterateChildrenFAction(@lp_ChildFunc), aMaxIndex, aMinIndex);
   if (anOpPack <> nil) and anOpPack.SaveUndo then
    (anOpPack as IevCursorContext).RecordCursor(Self);
   Result := True;
  finally
   theMarker := nil;
  end;//try..finally
//#UC END# *4A26260A00E6_4EF9B83D010D_impl*
end;//TevTableCursorPrim.ChangeParam
{$IfEnd} // Defined(evNeedHotSpot)

function TevTableCursorPrim.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_4EF9B83D010D_var*
//#UC END# *4A29465701BC_4EF9B83D010D_var*
begin
//#UC START# *4A29465701BC_4EF9B83D010D_impl*
 if ChangeParam(aMarker, aValue, anOp) then
  Result := True
 else
  Result := inherited DoChangeParam(aView, aMarker, aValue, anOp);
//#UC END# *4A29465701BC_4EF9B83D010D_impl*
end;//TevTableCursorPrim.DoChangeParam

{$If Defined(evNeedMarkers)}
procedure TevTableCursorPrim.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_4EF9B83D010D_var*
//#UC END# *4A38AA5C019F_4EF9B83D010D_var*
begin
//#UC START# *4A38AA5C019F_4EF9B83D010D_impl*
 AddMarker(aView, aList, k2_tiLeftIndent, ev_pmsParaIndent,
  str_nevmhTableIndent.AsCStr, TevTableMarker);
//#UC END# *4A38AA5C019F_4EF9B83D010D_impl*
end;//TevTableCursorPrim.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

function TevTableCursorPrim.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4EF9B83D010D_var*
//#UC END# *4A60B23E00C3_4EF9B83D010D_var*
begin
//#UC START# *4A60B23E00C3_4EF9B83D010D_impl*
 Result.SetOk;                                        
 if IID.EQ(IevTable) then
 begin
  IevTable(Obj) := nil;
  Assert(false);
 end//IID.EQ(IevTable)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4EF9B83D010D_impl*
end;//TevTableCursorPrim.COMQueryInterface
{$IfEnd} // Defined(evUseVisibleCursors)

end.
