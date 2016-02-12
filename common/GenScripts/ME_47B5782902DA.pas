{$IfNDef l3PtrList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas"
// Стереотип: "Impurity"

{$Define l3PtrList_imp}

 _l3PtrListPrim_Parent_ = _l3PtrList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3PtrListPrim.imp.pas}
 _l3PtrList_ = class(_l3PtrListPrim_)
  {* Примесь для списков указателей. Список НЕ УПРАВЛЯЕТ временем жизни элементов. }
 end;//_l3PtrList_

{$Else l3PtrList_imp}

{$IfNDef l3PtrList_imp_impl}

{$Define l3PtrList_imp_impl}

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_47B5782902DA_var*
//#UC END# *47B935AF0066_47B5782902DA_var*
begin
//#UC START# *47B935AF0066_47B5782902DA_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47B5782902DA_impl*
end;//FillItem

{$Include w:\common\components\rtl\Garant\L3\l3PtrListPrim.imp.pas}

{$EndIf l3PtrList_imp_impl}

{$EndIf l3PtrList_imp}

