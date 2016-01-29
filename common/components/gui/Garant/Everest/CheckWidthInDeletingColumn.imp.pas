{$IfNDef CheckWidthInDeletingColumn_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/CheckWidthInDeletingColumn.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::ParaUtils::CheckWidthInDeletingColumn
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CheckWidthInDeletingColumn_imp}
{$If defined(k2ForEditor)}
 _CheckWidthInDeletingColumn_ = {mixin} class(_CheckWidthInDeletingColumn_Parent_)
 private
 // private fields
   f_Width : Integer;
   f_CheckWidth : Integer;
 protected
 // protected methods
   function Try2CorrectWidth(const anOpPack: InevOp;
     const aStart: InevBasePoint;
     const aFinish: InevBasePoint): Boolean;
   procedure SetWidth(aValue: Integer);
   function GetStartOffset: Integer; virtual;
 end;//_CheckWidthInDeletingColumn_
{$Else}

 _CheckWidthInDeletingColumn_ = _CheckWidthInDeletingColumn_Parent_;

{$IfEnd} //k2ForEditor

{$Else CheckWidthInDeletingColumn_imp}

{$If defined(k2ForEditor)}

// start class _CheckWidthInDeletingColumn_

function _CheckWidthInDeletingColumn_.Try2CorrectWidth(const anOpPack: InevOp;
  const aStart: InevBasePoint;
  const aFinish: InevBasePoint): Boolean;
//#UC START# *52B3FF0601C9_52B3FBE60105_var*
var
 l_CellWidth  : Integer;
 l_CorrectCell: InevBasePoint;

 function lp_FindCellWidth: Boolean;
 var
  l_StartOffset: Integer;
 begin
  Result := (aStart.Inner <> nil);
  if Result then
  begin
   Result := aStart.Inner.AsObject.IsSame(aFinish.Inner.AsObject);
   if Result then
   begin
    l_CellWidth := aStart.Inner.AsObject.IntA[k2_tiWidth];
    l_CorrectCell := aStart;
   end // if Result then
   else
   if aFinish.Inner <> nil then
   begin
    l_StartOffset := GetStartOffset;
    Result := evEqualOffset(l_StartOffset, aFinish.Inner.Obj^.OffsetX);
    l_CellWidth := aFinish.Inner.AsObject.IntA[k2_tiWidth];
    l_CorrectCell := aFinish;
   end; // if aFinish.Inner <> nil then
  end; // if Result then
 end;

//#UC END# *52B3FF0601C9_52B3FBE60105_var*
begin
//#UC START# *52B3FF0601C9_52B3FBE60105_impl*
  Result := False;
  if lp_FindCellWidth then
  begin
   if evMoreOrEqualOffset(l_CellWidth, f_CheckWidth) then
   begin
    l_CorrectCell.Inner.AsObject.IntW[k2_tiWidth, anOpPack] := l_CellWidth - f_Width;
    Result := True;
   end; // if evMoreOrEqualOffset(l_CellWidth, f_CheckWidth) then
  end; // if (l_Start.Inner <> nil) and l_Start.Inner.IsSame(aFinish.Inner) then
//#UC END# *52B3FF0601C9_52B3FBE60105_impl*
end;//_CheckWidthInDeletingColumn_.Try2CorrectWidth

procedure _CheckWidthInDeletingColumn_.SetWidth(aValue: Integer);
//#UC START# *52B404B300DC_52B3FBE60105_var*
//#UC END# *52B404B300DC_52B3FBE60105_var*
begin
//#UC START# *52B404B300DC_52B3FBE60105_impl*
 f_Width := aValue;
 if aValue = High(Integer) then
  f_CheckWidth := aValue
 else
  f_CheckWidth := f_Width * 2;
//#UC END# *52B404B300DC_52B3FBE60105_impl*
end;//_CheckWidthInDeletingColumn_.SetWidth

function _CheckWidthInDeletingColumn_.GetStartOffset: Integer;
//#UC START# *52D50EFA0317_52B3FBE60105_var*
//#UC END# *52D50EFA0317_52B3FBE60105_var*
begin
//#UC START# *52D50EFA0317_52B3FBE60105_impl*
 Result := 0;
//#UC END# *52D50EFA0317_52B3FBE60105_impl*
end;//_CheckWidthInDeletingColumn_.GetStartOffset

{$IfEnd} //k2ForEditor

{$EndIf CheckWidthInDeletingColumn_imp}
