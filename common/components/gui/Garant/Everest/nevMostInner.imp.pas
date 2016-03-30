{$IfNDef nevMostInner_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevMostInner.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevMostInner" MUID: (49DE14FB022B)
// Имя типа: "_nevMostInner_"

{$Define nevMostInner_imp}

{$If Defined(evUseVisibleCursors)}
 _nevMostInner_ = class(_nevMostInner_Parent_)
  {* Самая внутренняя точка объекта }
  protected
   function pm_GetMostInner: InevBasePoint;
 end;//_nevMostInner_

{$Else Defined(evUseVisibleCursors)}

_nevMostInner_ = _nevMostInner_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevMostInner_imp}

{$IfNDef nevMostInner_imp_impl}

{$Define nevMostInner_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevMostInner_.pm_GetMostInner: InevBasePoint;
//#UC START# *49DE123A031F_49DE14FB022Bget_var*
//#UC END# *49DE123A031F_49DE14FB022Bget_var*
begin
//#UC START# *49DE123A031F_49DE14FB022Bget_impl*
 Result := _Instance_R_(Self);
 while Result.HasInner do
  Result := Result.Inner;
//#UC END# *49DE123A031F_49DE14FB022Bget_impl*
end;//_nevMostInner_.pm_GetMostInner
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevMostInner_imp_impl}

{$EndIf nevMostInner_imp}

