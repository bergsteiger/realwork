unit evTableCellCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evTableCellCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableCellCursor" MUID: (50DACE1F0334)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursor
 , nevTools
 , nevBase
;

type
 TevTableCellCursor = class(TevParaListCursor)
  protected
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); override;
   {$IfEnd} // Defined(evNeedMarkers)
  public
   procedure ChangePointByPara(const aView: InevView;
    const anOpPack: InevOp;
    const aPara: InevPara); override;
 end;//TevTableCellCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evdTypes
 , evOp
 {$If Defined(k2ForEditor)}
 , evTableImplementation
 {$IfEnd} // Defined(k2ForEditor)
 , evCursorConst
 , k2Tags
;

function TevTableCellCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_50DACE1F0334_var*
var
 l_Point      : InevBasePoint;
 l_RowPoint   : InevBasePoint;
 l_TablePoint : InevBasePoint;

 function lp_CheckMergeCell: Boolean;
 begin
  Result := True;
  if l_RowPoint <> nil then
  begin
   if l_TablePoint.HasInner and not l_TablePoint.Inner.AsObject.IsSame(l_RowPoint.AsObject) then
    l_RowPoint := l_TablePoint.Inner;
   if l_RowPoint <> nil then
   begin
    if l_RowPoint.HasInner then
    begin
     l_Point := l_RowPoint.Inner;
     Result := l_Point.AsObject.IntA[k2_tiMergeStatus] <> Ord(ev_msContinue);
    end;
   end; // if l_RowPoint.ParentPoint <> nil then
  end; // if l_RowPoint <> nil then
 end;

var
 l_Table : IevTable;
 l_Cell  : InevTableCell;
//#UC END# *49E31657038E_50DACE1F0334_var*
begin
//#UC START# *49E31657038E_50DACE1F0334_impl*
 case aCode of
  ev_ocColumnLeft :
  begin
   Move(aView, ev_ocListHome, anOp);
   Move(aView, ev_ocParaLeft, anOp);
   Result := ev_dcDoneOk;
  end;//ev_ocColumnLeft
  ev_ocColumnRight :
  begin
   l_RowPoint := Self.pm_GetParentPoint;
   l_Point := Self;
   repeat
    if (l_RowPoint <> nil) then
    begin
     if l_RowPoint <> nil then
      l_TablePoint := l_RowPoint.ParentPoint;           
     with l_RowPoint do
      if (l_TablePoint <> nil) AND (Position >= GetBlockLength) then
       if (l_TablePoint.Position >= l_TablePoint.GetBlockLength) then
       begin
        l_Table := TevTableImplementation.Make(aView, l_TablePoint, ParaX.DocumentContainer.Processor);
        if (l_Table <> nil) then
        begin
         l_Table.InsertRows(1, True);
         l_Table := nil;
         Result := ev_dcDoneOk;
         Exit;
        end; //if (Position >= GetBlockLength)
       end; //if (Position >= GetBlockLength)
     end; // if (l_RowPoint <> nil) then
     l_Point.Move(aView, ev_ocListEnd, anOp);
     l_Point.Move(aView, ev_ocParaRight, anOp);
   until lp_CheckMergeCell;
   if Self.IntA[k2_tiMergeStatus] = Ord(ev_msHead) then
    l_TablePoint.CorrectMoveRight(aView, l_Point, anOp);
   Result := ev_dcDoneOk;
  end;//ev_ocColumnLeft
  else
   Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 end;//case aCode
//#UC END# *49E31657038E_50DACE1F0334_impl*
end;//TevTableCellCursor.DoMovePrim

{$If Defined(evNeedMarkers)}
procedure TevTableCellCursor.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_50DACE1F0334_var*
//#UC END# *4A38AA5C019F_50DACE1F0334_var*
begin
//#UC START# *4A38AA5C019F_50DACE1F0334_impl*
//#UC END# *4A38AA5C019F_50DACE1F0334_impl*
end;//TevTableCellCursor.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

procedure TevTableCellCursor.ChangePointByPara(const aView: InevView;
 const anOpPack: InevOp;
 const aPara: InevPara);
//#UC START# *4D5D161A030C_50DACE1F0334_var*
var
 l_Table : InevBasePoint;
//#UC END# *4D5D161A030C_50DACE1F0334_var*
begin
//#UC START# *4D5D161A030C_50DACE1F0334_impl*
 inherited;
 if aPara = nil then
 begin
  if HasInner and (GetInner.AsObject.StrA[k2_tiText] <> '') then
   GetInner.SetAtStart(aView, True);
 end
 else
 begin
  l_Table := pm_GetParentPoint;
  if l_Table <> nil then
  begin
   l_Table := l_Table.ParentPoint;
   if l_Table <> nil then
   begin
    l_Table.SetEntryPoint(aPara.OwnerPara.PID + 1, anOpPack);
    if l_Table.HasInner then
    begin
     l_Table.Inner.SetEntryPoint(aPara.PID + 1, anOpPack);
     if l_Table.Inner.HasInner then
      l_Table.Inner.Inner.SetAtEnd(aView, True);
    end;// if l_Table.HasInner then
   end // if l_Table <> nil then
   else
    pm_GetParentPoint.SetEntryPoint(ev_cpNull, anOpPack)
  end // if l_Table <> nil then
  else
   SetEntryPoint(ev_cpNull, anOpPack);
 end; // if aPara = nil then
//#UC END# *4D5D161A030C_50DACE1F0334_impl*
end;//TevTableCellCursor.ChangePointByPara
{$IfEnd} // Defined(evUseVisibleCursors)

end.
