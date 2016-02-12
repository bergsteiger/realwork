{$IfNDef l3AtomicList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas"
// Стереотип: "Impurity"

{$Define l3AtomicList_imp}

 _l3AtomicListPrim_Parent_ = _l3AtomicList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 _l3AtomicList_ = class(_l3AtomicListPrim_)
  {* Список АТОМАРНЫХ элементов, без всякого подсчёта ссылок и управления временем жизни }
 end;//_l3AtomicList_

{$Else l3AtomicList_imp}

{$IfNDef l3AtomicList_imp_impl}

{$Define l3AtomicList_imp_impl}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47A1B04702C2_var*
//#UC END# *47B99D4503A2_47A1B04702C2_var*
begin
//#UC START# *47B99D4503A2_47A1B04702C2_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if CI.rA^ > CI.rB^ then
   Result := 1
 else
   if CI.rA^ < CI.rB^ then
     Result := -1
   else
     Result := 0;
//#UC END# *47B99D4503A2_47A1B04702C2_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

{$EndIf l3AtomicList_imp_impl}

{$EndIf l3AtomicList_imp}

