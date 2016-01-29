{$IfNDef CellFormatInfoCommon_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/CellFormatInfoCommon.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Rendering::CellFormatInfoCommon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CellFormatInfoCommon_imp}
 _CellFormatInfoCommon_ = {mixin} class(_CellFormatInfoCommon_Parent_)
 protected
 // protected methods
   function GetVerticalAlignmentMargin: Integer;
 end;//_CellFormatInfoCommon_

{$Else CellFormatInfoCommon_imp}

// start class _CellFormatInfoCommon_

function _CellFormatInfoCommon_.GetVerticalAlignmentMargin: Integer;
//#UC START# *5209E00C0113_5209DFCE0116_var*
var
 l_VertAlign: TevVerticalAligment;
//#UC END# *5209E00C0113_5209DFCE0116_var*
begin
//#UC START# *5209E00C0113_5209DFCE0116_impl*
 Result := 0;
 if (Obj.OverlapType = otNone) then
 begin
  l_VertAlign := TevVerticalAligment(Obj.AsObject.IntA[k2_tiVerticalAligment]);
  case l_VertAlign of
   ev_valCenter:
    Result := (ParentInfo.DeltaHeight - Height) div 2;
   ev_valBottom:
    Result := (ParentInfo.DeltaHeight - Height);
  end; // case l_VertAlign of
 end; // if if (Obj.OverlapType = otNone) then
//#UC END# *5209E00C0113_5209DFCE0116_impl*
end;//_CellFormatInfoCommon_.GetVerticalAlignmentMargin

{$EndIf CellFormatInfoCommon_imp}
