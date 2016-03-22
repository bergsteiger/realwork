{$IfNDef l3RevertedAtomicList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3RevertedAtomicList.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3RevertedAtomicList" MUID: (5423BE6002AA)
// Имя типа: "_l3RevertedAtomicList_"

{$Define l3RevertedAtomicList_imp}

 _l3AtomicListPrim_Parent_ = _l3RevertedAtomicList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 _l3RevertedAtomicList_ = class(_l3AtomicListPrim_)
 end;//_l3RevertedAtomicList_

{$Else l3RevertedAtomicList_imp}

{$IfNDef l3RevertedAtomicList_imp_impl}

{$Define l3RevertedAtomicList_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5423BE6002AA_var*
//#UC END# *47B99D4503A2_5423BE6002AA_var*
begin
//#UC START# *47B99D4503A2_5423BE6002AA_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if CI.rA^ > CI.rB^ then
   Result := -1
 else
   if CI.rA^ < CI.rB^ then
     Result := 1
   else
     Result := 0;
//#UC END# *47B99D4503A2_5423BE6002AA_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

{$EndIf l3RevertedAtomicList_imp_impl}

{$EndIf l3RevertedAtomicList_imp}

