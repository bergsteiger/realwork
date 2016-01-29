unit evTableColumnHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableColumnHotSpot.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevTableColumnHotSpot
//
// реализует интерфейс IevHotSpot для колонки таблицы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  l3Interfaces,
  nevBase,
  nevTools,
  nevGUIInterfaces,
  evColumnBorderMarker,
  l3Variant,
  afwInterfaces
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 RevTableColumnHotSpot = class of TevTableColumnHotSpot;

 TevTableColumnHotSpot = class(TevColumnBorderMarker, IevAdvancedHotSpot, IevHotSpotDelta)
  {* реализует интерфейс IevHotSpot для колонки таблицы. }
 private
 // private fields
   f_Delta : Integer;
   f_CanChangeTable : Boolean;
 protected
 // realized methods
   function MouseAction(const aView: InevControlView;
    aButton: Tl3MouseButton;
    anAction: Tl3MouseAction;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
   function Delta: Integer;
     {* точность }
   function CanDrag: Boolean;
 public
 // realized methods
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
 protected
 // protected methods
   function ProportionalChangeWidth(aTable: Tl3Variant;
     aDelta: Integer;
     const anOpPack: InevOp): Boolean;
   procedure ChangeCellWidth(const aView: InevControlView;
     const aProcessor: InevProcessor;
     const anOpPack: InevOp;
     const Keys: TevMouseState;
     const aRow: InevParaList;
     aDelta: Integer);
 public
 // public methods
   function CanChangeTable(const aView: InevControlView;
     aPara: Tl3Variant): Boolean;
   constructor Create(const aView: InevControlView;
     aPara: Tl3Variant;
     aColumnID: Integer;
     const aHint: Il3CString;
     aDelta: Integer); reintroduce;
   class function Make(const aView: InevControlView;
     aPara: Tl3Variant;
     aColumnID: Integer;
     const aHint: Il3CString = nil;
     aDelta: Integer = 0): IevAdvancedHotSpot;
 end;//TevTableColumnHotSpot
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Tags,
  l3Math,
  evdTypes,
  Classes,
  SysUtils,
  evInternalInterfaces
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  CommentPara_Const,
  l3Base,
  evEditorInterfaces,
  l3InterfacesMisc,
  nevInterfaces
  {$If defined(k2ForEditor)}
  ,
  evTableCellUtils
  {$IfEnd} //k2ForEditor
  ,
  k2OpMisc,
  evMsgCode,
  l3IID
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevTableColumnHotSpot

function TevTableColumnHotSpot.ProportionalChangeWidth(aTable: Tl3Variant;
  aDelta: Integer;
  const anOpPack: InevOp): Boolean;
//#UC START# *4ED321A40385_4ED31E9500E7_var*
var
 l_Width    : Integer;
 l_NewWidth : Integer;

 function ModifyRow(aRow: Tl3Variant; Index: Integer): Boolean; far;  
 var
  l_PrevOldDelta : Integer;
  l_PrevNewDelta : Integer;

  function ModifyCell(aCell: Tl3Variant; Index: Integer): Boolean; far;
  var
   l_NewCellWidth : Integer;
  begin//ModifyCell
   Result := true;
   with aCell do 
   begin
    with Attr[k2_tiWidth] do
     if IsValid then 
     begin
      Inc(l_PrevOldDelta, AsLong);
      l_NewCellWidth := l3MulDiv(l_PrevOldDelta, l_NewWidth, l_Width) - l_PrevNewDelta;
      Inc(l_PrevNewDelta, l_NewCellWidth);
     end 
     else
      l_NewCellWidth := 0;
    IntW[k2_tiWidth, anOpPack] := l_NewCellWidth;
   end;//with aCell
  end;//ModifyCell

 begin//ModifyRow
  l_PrevOldDelta := 0;
  l_PrevNewDelta := 0;
  Result := True;
  aRow.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ModifyCell));
 end;//ModifyRow

 function GetTableWidth: Integer;
 var
  l_Width: Integer absolute Result;

  function CalcWidth(aCell: Tl3Variant; Index: Integer): Boolean; far;
  begin
   Inc(l_Width, aCell.IntA[k2_tiWidth]);
   Result := True;
  end;

 begin
  l_Width := 0;
  aTable.Child[0].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CalcWidth));
 end;
//#UC END# *4ED321A40385_4ED31E9500E7_var*
begin
//#UC START# *4ED321A40385_4ED31E9500E7_impl*
 Result := False;
 l_Width := GetTableWidth;
 l_NewWidth := l_Width + aDelta;
 if (l_NewWidth > 0) AND (l_Width > 0) then
 begin
  aTable.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ModifyRow));
  Result := True;
 end;//l_NewWidth > 0..
//#UC END# *4ED321A40385_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.ProportionalChangeWidth

procedure TevTableColumnHotSpot.ChangeCellWidth(const aView: InevControlView;
  const aProcessor: InevProcessor;
  const anOpPack: InevOp;
  const Keys: TevMouseState;
  const aRow: InevParaList;
  aDelta: Integer);
//#UC START# *4ED3220102EE_4ED31E9500E7_var*
var
 l_Width: Integer;

 procedure lp_ChangeHeadWidth(const aPara: InevPara; aCheckPrev: Boolean);
 var
  l_Cell     : InevTableCell;
  l_PrevPart : InevTableCell;
  l_NexCell  : InevPara;
  l_PrevPara : InevPara;
 begin
  with aPara do
  begin
   QT(InevTableCell, l_Cell);
   if TevMergeStatus(IntA[k2_tiMergeStatus]) = ev_msContinue then
    l_Cell := l_Cell.GetMergeHead;
   while l_Cell <> nil do
   begin
    l_PrevPart := l_Cell;
    l_Cell := l_Cell.GetContinueCell(True, fc_Down);
    if aCheckPrev then
    begin
     l_PrevPara := l_PrevPart.Prev;
     l_PrevPara.AsObject.IntW[k2_tiWidth, anOpPack] := l_PrevPara.AsObject.IntA[k2_tiWidth] + aDelta;
    end // if aCheckPrev then
    else
     l_PrevPart.AsObject.IntW[k2_tiWidth, anOpPack] := l_Width;
    if (ssShift in Keys.rKeys) then
    begin
     l_NexCell := l_PrevPart.Next;
     if l_NexCell.AsObject.IsValid then
      l_NexCell.AsObject.IntW[k2_tiWidth, anOpPack] := l_NexCell.AsObject.IntA[k2_tiWidth] - aDelta;
    end; // if l_WasShift then
   end; // while l_Cell <> nil do
  end; // with aPara do
 end;

 function lp_HasRowMergedCell(const aNext: InevPara): Boolean;
 var
  l_Next: InevPara;
 begin
  Result := False;
  l_Next := aNext;
  while l_Next.AsObject.IsValid do
  begin
   if (TevMergeStatus(l_Next.AsObject.IntA[k2_tiMergeStatus]) <> ev_msNone) then
   begin
    Result := True;
    Break;
   end; // if (TevMergeStatus(l_Next.IntA[k2_tiMergeStatus]) <> ev_msNone) then
   l_Next := l_Next.Next;
  end; // while l_Next.IsValid and (TevMergeStatus(l_Next.IntA[k2_tiMergeStatus]) = ev_msNone) do
  if Result and l_Next.AsObject.IsValid then
   lp_ChangeHeadWidth(l_Next, True);
 end;

 procedure lp_CorrectNextCell(const aPara, aNext: InevPara);
 begin
  aNext.AsObject.IntW[k2_tiWidth, anOpPack] := aNext.AsObject.IntA[k2_tiWidth] - aDelta;
  aPara.AsObject.IntW[k2_tiWidth, anOpPack] := aPara.AsObject.IntA[k2_tiWidth] + aDelta;
 end;

var
 l_Next      : InevPara;
 l_Para      : InevPara;
 l_WasMerged : Boolean;
//#UC END# *4ED3220102EE_4ED31E9500E7_var*
begin
//#UC START# *4ED3220102EE_4ED31E9500E7_impl*
 l_Para := aRow[ColumnID - 1];
 with l_Para do
 begin
  l_Width := IntA[k2_tiWidth];
  Inc(l_Width, aDelta);
  if (l_Width > 100) then
  begin
   if TevMergeStatus(IntA[k2_tiMergeStatus]) = ev_msNone then
   begin
    l_Next := l_Para.Next;
    if l_Next.AsObject.IsValid and (TevMergeStatus(l_Next.AsObject.IntA[k2_tiMergeStatus]) <> ev_msNone) then
     lp_ChangeHeadWidth(l_Next, True)
    else
    begin
     if lp_HasRowMergedCell(l_Next) then
      lp_CorrectNextCell(l_Para, l_Next)
     else
      IntW[k2_tiWidth, anOpPack] := l_Width;
    end;
   end // if TevMergeStatus(l_Para.IntA[k2_tiMergeStatus]) = ev_msNone then
   else
    lp_ChangeHeadWidth(l_Para, False);
  end; // if (l_Delta > 100) then
 end; // with l_Para do
 aProcessor.Lock;
 try
  aView.Control.SetFlag(ev_uwfRuler);
 finally
  aProcessor.Unlock;
 end;//#UC END# *4ED3220102EE_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.ChangeCellWidth

function TevTableColumnHotSpot.CanChangeTable(const aView: InevControlView;
  aPara: Tl3Variant): Boolean;
//#UC START# *4ED3227A01E5_4ED31E9500E7_var*
//#UC END# *4ED3227A01E5_4ED31E9500E7_var*
begin
//#UC START# *4ED3227A01E5_4ED31E9500E7_impl*
 if (aView.Control = nil) OR not Supports(aView.Control, IevF1LikeEditor) then
  Result := true
 else
  Result := evInPara(aPara, k2_typCommentPara);
//#UC END# *4ED3227A01E5_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.CanChangeTable

constructor TevTableColumnHotSpot.Create(const aView: InevControlView;
  aPara: Tl3Variant;
  aColumnID: Integer;
  const aHint: Il3CString;
  aDelta: Integer);
//#UC START# *4ED322C700D3_4ED31E9500E7_var*
//#UC END# *4ED322C700D3_4ED31E9500E7_var*
begin
//#UC START# *4ED322C700D3_4ED31E9500E7_impl*
 inherited Create(aView, aPara, aColumnID, aHint);
 f_Delta := aDelta;
 f_CanChangeTable := CanChangeTable(aView, aPara); 
//#UC END# *4ED322C700D3_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.Create

class function TevTableColumnHotSpot.Make(const aView: InevControlView;
  aPara: Tl3Variant;
  aColumnID: Integer;
  const aHint: Il3CString = nil;
  aDelta: Integer = 0): IevAdvancedHotSpot;
//#UC START# *4ED3231B03D7_4ED31E9500E7_var*
var
 l_Spot : TevTableColumnHotSpot;
//#UC END# *4ED3231B03D7_4ED31E9500E7_var*
begin
//#UC START# *4ED3231B03D7_4ED31E9500E7_impl*
 l_Spot := Create(aView, aPara, aColumnID, aHint, aDelta);
 try
  Result := l_Spot;
 finally
  l3Free(l_Spot);
 end;//try..finally
//#UC END# *4ED3231B03D7_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.Make

procedure TevTableColumnHotSpot.HitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4ED31E9500E7_var*
//#UC END# *48E2622A03C4_4ED31E9500E7_var*
begin
//#UC START# *48E2622A03C4_4ED31E9500E7_impl*
 {$IfDef evChangeTableByMouse}
 if f_CanChangeTable then
 begin
  theInfo.rCursor := ev_csHSplit;
  if (ssCtrl in aState.rKeys) then
   theInfo.rHint := Hint
  else
  begin
   if (ssShift in aState.rKeys) AND
      (ColumnID = Para.AsObject.ChildrenCount) then
    theInfo.rHint := str_nevmhhTableSize.AsCStr
   else
    theInfo.rHint := str_nevmhhColumnSize.AsCStr;
  end;//ssCtrl in aState.rKeys
 end;//f_CanChangeTable
 {$EndIf evChangeTableByMouse}
//#UC END# *48E2622A03C4_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.HitTest

function TevTableColumnHotSpot.MouseAction(const aView: InevControlView;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E263CD01BD_4ED31E9500E7_var*
var
 l_Processor : InevProcessor;
 l_OpPack    : InevOp;
 l_Delta     : Integer;
 l_Column    : IedColumn;
 l_Row       : InevParaList;
 l_Table     : InevParaList;
//#UC END# *48E263CD01BD_4ED31E9500E7_var*
begin
//#UC START# *48E263CD01BD_4ED31E9500E7_impl*
 {$IfDef evChangeTableByMouse}
 if f_CanChangeTable then
 begin
  case aButton of
   ev_mbLeft :
   begin
    case anAction of
     ev_maDown :
     begin
      Effect.rStrob := afw_stVert;
      Result := True;
     end;//ev_maDown
     ev_maUp :
     begin
      l_Delta := Keys.rPoint.X - Keys.rInitialPoint.X;
      l_Delta := evCheckCellWidth(l_Delta);
      if (ClientValue + l_Delta > 100) AND
         (aView <> nil) then
       try
        l_Processor := aView.Processor; //Processor; 
        l_OpPack := k2StartOp(l_Processor, ev_msgChangeParam);
        try
         l_Row := Para.AsList;
         if not (ssCtrl in Keys.rKeys) then
         begin
          l_Table := l_Row.OwnerPara;
          if (ssShift in Keys.rKeys) then
          begin
           if (ColumnID = l_Row.AsObject.ChildrenCount) then
           begin
            Result := ProportionalChangeWidth(l_Table.AsObject, l_Delta, l_OpPack);
            l_Table.Invalidate([nev_spExtent]);
            //aView._InvalidateShape(l_Table.Shape, True);
            // - так как написано срочкой выше, так правильнее
            Exit;
           end//Column = l_Row.ChildrenCount
           else
           begin
            if l3IOk(evQueryParaInterface(aView, l_Processor, l_Row[ColumnID],
                                          Tl3GUID_C(IedColumn), l_Column)) then
             try
              l_Column.Width := l_Column.Width - l_Delta;
             finally
              l_Column := nil;
             end;//try..finally
           end;//Column = l_Row.ChildrenCount
          end;//Keys.rKeys AND MK_Shift <> 0
          l_Table.MakePoint.Formatting.Modify(aView).ChangeParam(aView, Self, Value + l_Delta, l_OpPack);
         end//not (ssCtrl in Keys.rKeys)
         else
          ChangeCellWidth(aView, l_Processor, l_OpPack, Keys, l_Row, l_Delta);
        finally
         l_OpPack := nil;
        end;//try..finally
       finally
        l_Processor := nil;
       end;//try..finally
      Result := True;
     end;//ev_maUp
     ev_maMove : begin
      Result := (ClientValue + Keys.rPoint.X - Keys.rInitialPoint.X) > 100;
     end;//ev_maMove
     else
      Result := False;
    end;//case anAction
   end;//ev_mbLeft
   else
    Result := False;
  end;//case aButton
 end//f_CanChangeTable
 else
  Result := false;
 {$Else  evChangeTableByMouse}
 Result := False;
 {$EndIf evChangeTableByMouse}//#UC END# *48E263CD01BD_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.MouseAction

function TevTableColumnHotSpot.Delta: Integer;
//#UC START# *4A23A71A02CC_4ED31E9500E7_var*
//#UC END# *4A23A71A02CC_4ED31E9500E7_var*
begin
//#UC START# *4A23A71A02CC_4ED31E9500E7_impl*
  Result := f_Delta;
//#UC END# *4A23A71A02CC_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.Delta

function TevTableColumnHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4ED31E9500E7_var*
//#UC END# *4ECCD6840014_4ED31E9500E7_var*
begin
//#UC START# *4ECCD6840014_4ED31E9500E7_impl*
 Result := False;
//#UC END# *4ECCD6840014_4ED31E9500E7_impl*
end;//TevTableColumnHotSpot.CanDrag

{$IfEnd} //evUseVisibleCursors

end.