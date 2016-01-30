{$IfNDef l3PtrListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3PtrListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3PtrListPrim_imp}

 _l3StandardTypedList_Parent_ = _l3PtrListPrim_Parent_;
 {$Include l3StandardTypedList.imp.pas}
 _l3PtrListPrim_ = {abstract} class(_l3StandardTypedList_)
  {* Примесь для списков указателей. Список НЕ УПРАВЛЯЕТ временем жизни элементов. }
 end;//_l3PtrListPrim_

{$Else l3PtrListPrim_imp}

{$IfNDef l3PtrListPrim_imp_impl}

{$Define l3PtrListPrim_imp_impl}

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_47B941FB0284_var*
//#UC END# *47B94A5C006E_47B941FB0284_var*
begin
//#UC START# *47B94A5C006E_47B941FB0284_impl*
 // - ничего освобождать не нужно
 Pointer(aPlace) := nil;
//#UC END# *47B94A5C006E_47B941FB0284_impl*
end;//FreeItem

type _Instance_R_ = _l3PtrListPrim_;

{$Include l3StandardTypedList.imp.pas}

{$EndIf l3PtrListPrim_imp_impl}

{$EndIf l3PtrListPrim_imp}

