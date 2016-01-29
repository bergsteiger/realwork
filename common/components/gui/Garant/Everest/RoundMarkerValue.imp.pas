{$IfNDef RoundMarkerValue_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/RoundMarkerValue.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::RoundMarkerValue
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RoundMarkerValue_imp}
{$If defined(evUseVisibleCursors)}
 _RoundMarkerValue_ = {mixin} class(_RoundMarkerValue_Parent_)
 protected
 // protected methods
   function CalcDelta(aValue: Integer;
     aClientValue: Integer): Integer;
 end;//_RoundMarkerValue_
{$Else}

 _RoundMarkerValue_ = _RoundMarkerValue_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else RoundMarkerValue_imp}

{$If defined(evUseVisibleCursors)}

// start class _RoundMarkerValue_

function _RoundMarkerValue_.CalcDelta(aValue: Integer;
  aClientValue: Integer): Integer;
//#UC START# *4E3A65530187_4E3A6520002C_var*
//#UC END# *4E3A65530187_4E3A6520002C_var*
begin
//#UC START# *4E3A65530187_4E3A6520002C_impl*
 Result := aValue - ClientValue;
 Result := evCheckCellWidth(Result);
//#UC END# *4E3A65530187_4E3A6520002C_impl*
end;//_RoundMarkerValue_.CalcDelta

{$IfEnd} //evUseVisibleCursors

{$EndIf RoundMarkerValue_imp}
