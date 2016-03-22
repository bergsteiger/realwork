{$IfNDef RoundMarkerValue_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\RoundMarkerValue.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "RoundMarkerValue" MUID: (4E3A6520002C)
// Имя типа: "_RoundMarkerValue_"

{$Define RoundMarkerValue_imp}

{$If Defined(evUseVisibleCursors)}
 _RoundMarkerValue_ = class(_RoundMarkerValue_Parent_)
  protected
   function CalcDelta(aValue: Integer;
    aClientValue: Integer): Integer;
 end;//_RoundMarkerValue_

{$Else Defined(evUseVisibleCursors)}

_RoundMarkerValue_ = _RoundMarkerValue_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else RoundMarkerValue_imp}

{$IfNDef RoundMarkerValue_imp_impl}

{$Define RoundMarkerValue_imp_impl}

{$If Defined(evUseVisibleCursors)}
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
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf RoundMarkerValue_imp_impl}

{$EndIf RoundMarkerValue_imp}

