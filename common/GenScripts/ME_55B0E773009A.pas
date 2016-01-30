{$IfNDef tfwSortedDictionaryList_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwSortedDictionaryList.imp.pas"
// Стереотип: "Impurity"

{$Define tfwSortedDictionaryList_imp}

{$If NOT Defined(NoScripts)}
 {$Include tfwDictionaryListPrim.imp.pas}
 _tfwSortedDictionaryList_ = {abstract} class(_tfwDictionaryListPrim_)
  protected
   procedure InitFields; override;
 end;//_tfwSortedDictionaryList_

{$Else NOT Defined(NoScripts)}

{$Include tfwDictionaryListPrim.imp.pas}
_tfwSortedDictionaryList_ = _tfwDictionaryListPrim_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwSortedDictionaryList_imp}

{$IfNDef tfwSortedDictionaryList_imp_impl}

{$Define tfwSortedDictionaryList_imp_impl}

{$If NOT Defined(NoScripts)}
function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55B0E773009A_var*
//#UC END# *47B99D4503A2_55B0E773009A_var*
begin
//#UC START# *47B99D4503A2_55B0E773009A_impl*
 Result := l3Compare(l3PCharLen(CI.rA.FileName), l3PCharLen(CI.rB.FileName), l3_siCaseUnsensitive);
//#UC END# *47B99D4503A2_55B0E773009A_impl*
end;//CompareExistingItems

type _Instance_R_ = _tfwSortedDictionaryList_;

{$Include tfwDictionaryListPrim.imp.pas}

procedure _tfwSortedDictionaryList_.InitFields;
//#UC START# *47A042E100E2_55B0E773009A_var*
//#UC END# *47A042E100E2_55B0E773009A_var*
begin
//#UC START# *47A042E100E2_55B0E773009A_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_55B0E773009A_impl*
end;//_tfwSortedDictionaryList_.InitFields
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwSortedDictionaryList_imp_impl}

{$EndIf tfwSortedDictionaryList_imp}

