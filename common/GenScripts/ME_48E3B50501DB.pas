unit evMultiSelection;

// Модуль: "w:\common\components\gui\Garant\Everest\evMultiSelection.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevSelection
 , nevRangeList
 , nevTools
 , l3Variant
 , evTypes
;

type
 TevMultiSelection = class(TnevSelection)
  private
   f_Selected: TnevRangeList;
   f_SelectedCopy: TnevRangeList;
   f_NeedUnselect: Boolean;
   f_WasProcess: Boolean;
   f_HeadPoint: InevBasePoint;
  private
   procedure DoAssignSelByRecursion(const aView: InevView;
    const aSource: InevRange);
    {* Рекурсивно разобрать выделение на мультиблоки }
  protected
   function pm_GetAllowMultiSelect: Boolean;
   function MakeSelectionCopy(aSelection: TnevRangeList): TnevRangeList;
   procedure CheckSelectedList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetBlock(const aDocument: InevObject): InevRange; override;
   function GetIsMulti: Boolean; override;
   function DoAddBlock(const aStart: InevBasePoint;
    const aFinish: InevBasePoint): Boolean; override;
   function GetContains(const C: InevBasePoint): Boolean; override;
   procedure DoAssignSel(const aView: InevView;
    const aSource: InevRange;
    AllowAddToMulti: Boolean); override;
   procedure DoSetDocument(aValue: Tl3Tag); override;
   function DoUnselect: Boolean; override;
    {* Снять выделение }
   function pm_GetCollapsed: Boolean; override;
  public
   procedure SelectionStart(aNeedUnselect: Boolean);
   procedure SelectionProcess(const aStart: InevPoint;
    const aFinish: InevPoint);
   procedure SelectionFinish(const aStart: InevPoint;
    const aFinish: InevPoint;
    var aNeedUnselect: Boolean);
   procedure Select(aTarget: TevSelectTarget;
    const aCursor: InevPoint = nil;
    Start: Boolean = True); override;
    {* выделить часть документа (выделить текущее слово, строку, параграф etc) }
   procedure ForceStore; override;
  protected
   property AllowMultiSelect: Boolean
    read pm_GetAllowMultiSelect;
 end;//TevMultiSelection

implementation

uses
 l3ImplUses
 , l3Base
 , evMultiSelectionBlock
 , l3Types
 , l3MinMax
 , evMsgCode
 , nevRangeListTools
 , nevFacade
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
;

function TevMultiSelection.pm_GetAllowMultiSelect: Boolean;
//#UC START# *48E3B7C70192_48E3B50501DBget_var*
//#UC END# *48E3B7C70192_48E3B50501DBget_var*
begin
//#UC START# *48E3B7C70192_48E3B50501DBget_impl*
 if (View = nil) then
  Result := false
 else
  Result := View.AllowMultiSelect;
//#UC END# *48E3B7C70192_48E3B50501DBget_impl*
end;//TevMultiSelection.pm_GetAllowMultiSelect

function TevMultiSelection.MakeSelectionCopy(aSelection: TnevRangeList): TnevRangeList;
//#UC START# *48E3B5A602F3_48E3B50501DB_var*
var
 l_Result : TnevRangeList absolute Result;

 function l_MakeSelectionCopy(pBlock: PIUnknown; anIndex: Long): Boolean;
 begin//l_MakeSelectionCopy
  Result := true;
  l_Result.Add(InevRange(pBlock^).CloneSel(View));
 end;//l_MakeSelectionCopy

//#UC END# *48E3B5A602F3_48E3B50501DB_var*
begin
//#UC START# *48E3B5A602F3_48E3B50501DB_impl*
 Result := TnevRangeList.Make;
 if (aSelection <> nil) then
  aSelection.IterateAllF(l3L2IA(@l_MakeSelectionCopy));
//#UC END# *48E3B5A602F3_48E3B50501DB_impl*
end;//TevMultiSelection.MakeSelectionCopy

procedure TevMultiSelection.CheckSelectedList;
//#UC START# *48E3B5B3009C_48E3B50501DB_var*
//#UC END# *48E3B5B3009C_48E3B50501DB_var*
begin
//#UC START# *48E3B5B3009C_48E3B50501DB_impl*
 if (f_Selected = nil) then
  f_Selected := TnevRangeList.Make;
//#UC END# *48E3B5B3009C_48E3B50501DB_impl*
end;//TevMultiSelection.CheckSelectedList

procedure TevMultiSelection.SelectionStart(aNeedUnselect: Boolean);
//#UC START# *48E3B5CE0397_48E3B50501DB_var*
//#UC END# *48E3B5CE0397_48E3B50501DB_var*
begin
//#UC START# *48E3B5CE0397_48E3B50501DB_impl*
 l3Free(f_SelectedCopy);
 f_WasProcess := False;
 f_HeadPoint := nil;
 if Contains(Cursor) then //in selection
  f_NeedUnselect := aNeedUnselect
 else
 begin
  if aNeedUnselect then
   DoUnselect;
  f_SelectedCopy := MakeSelectionCopy(f_Selected);
 end;//Contains(Cursor)
//#UC END# *48E3B5CE0397_48E3B50501DB_impl*
end;//TevMultiSelection.SelectionStart

procedure TevMultiSelection.SelectionProcess(const aStart: InevPoint;
 const aFinish: InevPoint);
//#UC START# *48E3B5DA031E_48E3B50501DB_var*
//#UC END# *48E3B5DA031E_48E3B50501DB_var*
begin
//#UC START# *48E3B5DA031E_48E3B50501DB_impl*
 if (f_SelectedCopy = nil) then
 begin
  if f_NeedUnselect then
   DoUnselect;
  f_SelectedCopy := MakeSelectionCopy(f_Selected);
 end;//f_SelectedCopy = nil
 l3Free(f_Selected);
 f_Selected := MakeSelectionCopy(f_SelectedCopy);
 f_WasProcess := True;
 AddBlock(aStart, aFinish);
//#UC END# *48E3B5DA031E_48E3B50501DB_impl*
end;//TevMultiSelection.SelectionProcess

procedure TevMultiSelection.SelectionFinish(const aStart: InevPoint;
 const aFinish: InevPoint;
 var aNeedUnselect: Boolean);
//#UC START# *48E3B5F4039A_48E3B50501DB_var*
//#UC END# *48E3B5F4039A_48E3B50501DB_var*
begin
//#UC START# *48E3B5F4039A_48E3B50501DB_impl*
 if Assigned(f_SelectedCopy) then
 begin
  l3Free(f_Selected);
  f_Selected := MakeSelectionCopy(f_SelectedCopy);
  AddBlock(aStart, aFinish);
  l3Free(f_SelectedCopy);
 end//Assigned(f_SelectedCopy)
 else
  aNeedUnselect := true;
  // - ткнули в выделение, но не было изменений - значит надо снять выделение
 f_WasProcess := False;
 f_HeadPoint := nil;
//#UC END# *48E3B5F4039A_48E3B50501DB_impl*
end;//TevMultiSelection.SelectionFinish

procedure TevMultiSelection.DoAssignSelByRecursion(const aView: InevView;
 const aSource: InevRange);
 {* Рекурсивно разобрать выделение на мультиблоки }
//#UC START# *4A2617E5004E_48E3B50501DB_var*

 procedure lp_DoAdd(const aStart, aFinish: InevBasePoint);
 var
  l_Start: InevBasePoint;
  l_Finish: InevBasePoint;
 begin
  if (aStart = nil) then
   l_Start := nil
  else
  begin
   l_Start := aStart.ClonePoint(aView);
   l_Start := l_Start.MostInner;
   l_Start := l_Start.PointToParentByLevel(MaxInt);
  end;//aStart = nil
  if (aFinish = nil) then
   l_Finish := nil
  else
  begin
   l_Finish := aFinish.ClonePoint(aView);
   l_Finish := l_Finish.MostInner;
   l_Finish := l_Finish.PointToParentByLevel(MaxInt);
  end;//aFinish = nil
  AddBlock(l_Start, l_Finish);
 end;//lp_DoAdd

 function lp_AssignSel(const aSel: InevRange; anIndex: Integer): Boolean;
 begin
  Result := True;
  DoAssignSelByRecursion(aView, aSel);
 end;

var
 l_Start: InevBasePoint;
 l_Finish: InevBasePoint;
//#UC END# *4A2617E5004E_48E3B50501DB_var*
begin
//#UC START# *4A2617E5004E_48E3B50501DB_impl*
 if aSource.Solid(aView) then
 begin
  aSource.GetBorderPoints(l_Start, l_Finish);
  lp_DoAdd(l_Start, l_Finish);
 end
 else
 begin
  aSource.GetBorderPoints(l_Start, l_Finish);
  if not l_Start.HasInner then
   lp_DoAdd(l_Start, l_Finish)
  else
   aSource.IterateF(evL2TSA(@lp_AssignSel));
 end;
//#UC END# *4A2617E5004E_48E3B50501DB_impl*
end;//TevMultiSelection.DoAssignSelByRecursion

procedure TevMultiSelection.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48E3B50501DB_var*
//#UC END# *479731C50290_48E3B50501DB_var*
begin
//#UC START# *479731C50290_48E3B50501DB_impl*
 f_HeadPoint := nil;
 l3Free(f_Selected);
 l3Free(f_SelectedCopy);
 inherited;
//#UC END# *479731C50290_48E3B50501DB_impl*
end;//TevMultiSelection.Cleanup

function TevMultiSelection.DoGetBlock(const aDocument: InevObject): InevRange;
//#UC START# *48E252D40298_48E3B50501DB_var*
//#UC END# *48E252D40298_48E3B50501DB_var*
begin
//#UC START# *48E252D40298_48E3B50501DB_impl*
 if Assigned(FoundBlock) then
  Result := inherited DoGetBlock(aDocument)
 else
 if AllowMultiSelect then
 begin
  if (f_Selected <> nil) AND not f_Selected.Empty then
   Result := TevMultiSelectionBlock.Make(aDocument.AsObject, f_Selected)
  else
   Result := inherited DoGetBlock(aDocument);
 end//AllowMultiSelect
 else
  Result := inherited DoGetBlock(aDocument);
//#UC END# *48E252D40298_48E3B50501DB_impl*
end;//TevMultiSelection.DoGetBlock

function TevMultiSelection.GetIsMulti: Boolean;
//#UC START# *48E271320180_48E3B50501DB_var*
//#UC END# *48E271320180_48E3B50501DB_var*
begin
//#UC START# *48E271320180_48E3B50501DB_impl*
 Result := AllowMultiSelect AND (f_Selected <> nil) AND (f_Selected.Count > 1);
//#UC END# *48E271320180_48E3B50501DB_impl*
end;//TevMultiSelection.GetIsMulti

function TevMultiSelection.DoAddBlock(const aStart: InevBasePoint;
 const aFinish: InevBasePoint): Boolean;
//#UC START# *48E2719C019C_48E3B50501DB_var*
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;

 function lp_Start: Boolean;
 begin
  if not f_WasProcess and AllowMultiSelect then
   Result := False
  else
   Result := evInEmptyTableCell(l_Start, l_Finish);
 end;

 procedure lp_Correct(atStart: Boolean);
 begin
  if atStart then
   EvCorrectTablePoint(atStart,View, l_Start, aStart, f_HeadPoint)
  else
   EvCorrectTablePoint(atStart, View, l_Finish, aFinish, f_HeadPoint);
 end;

var
 l_Block : InevRange;
 l_Empty : Boolean;
 l_C     : Integer;
//#UC END# *48E2719C019C_48E3B50501DB_var*
begin
//#UC START# *48E2719C019C_48E3B50501DB_impl*
 Result := false;
 if (not (Assigned(aStart) and Assigned(aFinish))) then
  Exit;
 l_Block := nil;
 l_Empty := (f_Selected = nil) OR f_Selected.Empty;
 if not AllowMultiSelect then f_HeadPoint := nil;
 try
  l_Start := aStart.ClonePoint(View);
  try
   l_Finish := aFinish.ClonePoint(View);
   try
    l_C := l_Start.Compare(l_Finish);
    if (l_C = 0) then
    begin
     f_HeadPoint := nil;  
     if lp_Start then
      l_Block := DocumentPara.Range(l_Start, l_Finish)
    end // if (l_C = 0) then
    else
    begin
     if (l_C > 0) then
     begin
      if f_HeadPoint <> nil then lp_Correct(False);
      l_Block := DocumentPara.Range(l_Finish, l_Start);
      if f_HeadPoint = nil then
       f_HeadPoint := evIsPointHeadCell(View, l_Finish);
     end // if (l_C > 0) then
     else
     begin
      if f_HeadPoint <> nil then lp_Correct(True);
      l_Block := DocumentPara.Range(l_Start, l_Finish);
      if f_HeadPoint = nil then
       f_HeadPoint := evIsPointHeadCell(View, l_Start);
     end;
    end;//l_C <> 0
   finally
    l_Finish := nil;
   end;//try..finally
  finally
   l_Start := nil;
  end;//try..finally
  if (l_Block <> nil) then
  begin
   if l_Empty then
    CheckSelectedList;
   if NevAddRangeToList(f_Selected, l_Block) then
    Result := inherited DoAddBlock(aStart, aFinish);
  end;//(l_Block <> nil)
 finally
  l_Block := nil;
 end;//try..finally
//#UC END# *48E2719C019C_48E3B50501DB_impl*
end;//TevMultiSelection.DoAddBlock

function TevMultiSelection.GetContains(const C: InevBasePoint): Boolean;
//#UC START# *48E271FC0130_48E3B50501DB_var*

 function l_CheckBlock(pBlock: PIUnknown; anIndex: Integer): Boolean;
 var
  l_S : InevBasePoint;
  l_F : InevBasePoint;
 begin//l_CheckBlock
  Result := true;
  InevRange(pBlock^).GetBorderPoints(l_S, l_F);
  if ((l_F = nil) OR (l_F.Compare(l_S) > 0) OR evInEmptyTableCell(l_S, l_F)) AND
     (C.Compare(l_S) >= 0) AND (C.Compare(l_F) <= 0) then
  begin
   Result := false;
   GetContains := true;
  end;//C.Compare(l_S) >= 0
 end;//l_CheckBlock

//#UC END# *48E271FC0130_48E3B50501DB_var*
begin
//#UC START# *48E271FC0130_48E3B50501DB_impl*
 if (C = nil) then
  Result := false
 else
 if Assigned(FoundBlock) or (f_Selected = nil) OR f_Selected.Empty then
  Result := inherited GetContains(C)
 else
 begin
  Result := false;
  f_Selected.IterateAllF(l3L2IA(@l_CheckBlock));
 end;//f_Selected = nil
//#UC END# *48E271FC0130_48E3B50501DB_impl*
end;//TevMultiSelection.GetContains

procedure TevMultiSelection.DoAssignSel(const aView: InevView;
 const aSource: InevRange;
 AllowAddToMulti: Boolean);
//#UC START# *48E274CF007B_48E3B50501DB_var*
var
 l_Pack: InevOp;
 l_Fake: InevBasePoint;
 l_Finish: InevBasePoint;
//#UC END# *48E274CF007B_48E3B50501DB_var*
begin
//#UC START# *48E274CF007B_48E3B50501DB_impl*
 if AllowAddToMulti AND AllowMultiSelect then
 begin
  if Assigned(f_Selected) then
   f_Selected.Clear;
  l_Pack := Processor.StartOp(ev_msgMove);
  try
   DoAssignSelByRecursion(aView, aSource);
   aSource.GetBorderPoints(l_Fake, l_Finish);
   if (l_Finish = nil) then
    l_Finish := aSource.Obj.MakePoint
   else
    l_Finish := l_Finish.ClonePoint(aView);
   l_Finish := l_Finish.MostInner;
   l_Finish := l_Finish.PointToParentByLevel(MaxInt);
   (l_Pack as IevCursorContext).RecordCursor(Cursor);
   with CheckCursor do
   begin
    AssignPoint(View,  l_Finish);
    Refresh;
   end;//with CheckCursor
  finally
   l_Pack := nil;
  end;//try..finally
 end//AllowMultiSelect
 else
 begin
  if AllowMultiSelect then
   DoUnselect;
  inherited;
 end;//AllowMultiSelect
//#UC END# *48E274CF007B_48E3B50501DB_impl*
end;//TevMultiSelection.DoAssignSel

procedure TevMultiSelection.DoSetDocument(aValue: Tl3Tag);
//#UC START# *48E276B10286_48E3B50501DB_var*
//#UC END# *48E276B10286_48E3B50501DB_var*
begin
//#UC START# *48E276B10286_48E3B50501DB_impl*
 if (f_Selected <> nil) then
  f_Selected.Clear;
 if (f_SelectedCopy <> nil) then
  f_SelectedCopy.Clear;
 inherited;
//#UC END# *48E276B10286_48E3B50501DB_impl*
end;//TevMultiSelection.DoSetDocument

function TevMultiSelection.DoUnselect: Boolean;
 {* Снять выделение }
//#UC START# *48E2771B024F_48E3B50501DB_var*
//#UC END# *48E2771B024F_48E3B50501DB_var*
begin
//#UC START# *48E2771B024F_48E3B50501DB_impl*
 if (f_Selected <> nil) AND not f_Selected.Empty then
 begin
  Result := true;
  f_Selected.Clear;
  inherited DoUnselect;
  UpdateBlock;
  f_HeadPoint := nil;
 end//f_Selected <> nil..
 else
  Result := inherited DoUnselect;
//#UC END# *48E2771B024F_48E3B50501DB_impl*
end;//TevMultiSelection.DoUnselect

function TevMultiSelection.pm_GetCollapsed: Boolean;
//#UC START# *48E3723E0107_48E3B50501DBget_var*
//#UC END# *48E3723E0107_48E3B50501DBget_var*
begin
//#UC START# *48E3723E0107_48E3B50501DBget_impl*
 if ((f_Selected <> nil) AND (not f_Selected.Empty)) then
 begin
  if (f_Selected.Count = 1) then
  begin
   if f_Selected[0].Collapsed(View) then
    Result := true
   else
    Result := false;
  end//f_Selected.Count = 1
  else
   Result := false;
 end//f_Selected <> nil
 else
 if Assigned(FoundBlock) then
  Result := false
 else
  Result := inherited pm_GetCollapsed;
//#UC END# *48E3723E0107_48E3B50501DBget_impl*
end;//TevMultiSelection.pm_GetCollapsed

procedure TevMultiSelection.Select(aTarget: TevSelectTarget;
 const aCursor: InevPoint = nil;
 Start: Boolean = True);
 {* выделить часть документа (выделить текущее слово, строку, параграф etc) }
//#UC START# *48E3A6260063_48E3B50501DB_var*
var
 l_Pack : InevOp;
//#UC END# *48E3A6260063_48E3B50501DB_var*
begin
//#UC START# *48E3A6260063_48E3B50501DB_impl*
 if AllowMultiSelect then
 begin
  l_Pack := Processor.StartOp(ev_msgMove);
  try
   f_WasProcess := True;
   inherited;
   AddBlock(StartMark, FinishMark);
  finally
   f_WasProcess := False;
   l_Pack := nil;
  end;//try..finally
 end//AllowMultiSelect
 else
  inherited;
//#UC END# *48E3A6260063_48E3B50501DB_impl*
end;//TevMultiSelection.Select

procedure TevMultiSelection.ForceStore;
//#UC START# *4D9476CA029F_48E3B50501DB_var*
var
 l_Index : Integer;
//#UC END# *4D9476CA029F_48E3B50501DB_var*
begin
//#UC START# *4D9476CA029F_48E3B50501DB_impl*
 inherited;
 if (f_Selected <> nil) then
  for l_Index := 0 to f_Selected.Count - 1 do
   f_Selected[l_Index].AsObject.ForceStore;
//#UC END# *4D9476CA029F_48E3B50501DB_impl*
end;//TevMultiSelection.ForceStore

end.
