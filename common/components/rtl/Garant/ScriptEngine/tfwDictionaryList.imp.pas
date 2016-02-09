{$IfNDef tfwDictionaryList_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryList.imp.pas"
// Стереотип: "Impurity"

{$Define tfwDictionaryList_imp}

{$If NOT Defined(NoScripts)}
 {$Define l3Items_NoSort}

 {$Include tfwDictionaryListPrim.imp.pas}
 _tfwDictionaryList_ = {abstract} class(_tfwDictionaryListPrim_)
 end;//_tfwDictionaryList_

{$Else NOT Defined(NoScripts)}

{$Include tfwDictionaryListPrim.imp.pas}
_tfwDictionaryList_ = _tfwDictionaryListPrim_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwDictionaryList_imp}

{$IfNDef tfwDictionaryList_imp_impl}

{$Define tfwDictionaryList_imp_impl}

{$If NOT Defined(NoScripts)}
function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55A63D8C00F0_var*
//#UC END# *47B99D4503A2_55A63D8C00F0_var*
begin
//#UC START# *47B99D4503A2_55A63D8C00F0_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_55A63D8C00F0_impl*
end;//CompareExistingItems

{$Include tfwDictionaryListPrim.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwDictionaryList_imp_impl}

{$EndIf tfwDictionaryList_imp}

