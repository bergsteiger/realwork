{$IfNDef l3RecordListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3RecordListPrim" MUID: (4B223ADC02BF)
// Имя типа: "_l3RecordListPrim_"

{$Define l3RecordListPrim_imp}

 _l3RecordListPrimPrim_Parent_ = _l3RecordListPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}
 _l3RecordListPrim_ = class(_l3RecordListPrimPrim_)
  {* Список записей }
 end;//_l3RecordListPrim_

{$Else l3RecordListPrim_imp}

{$IfNDef l3RecordListPrim_imp_impl}

{$Define l3RecordListPrim_imp_impl}

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4B223ADC02BF_var*
//#UC END# *47B94A5C006E_4B223ADC02BF_var*
begin
//#UC START# *47B94A5C006E_4B223ADC02BF_impl*
 Finalize(aPlace);
//#UC END# *47B94A5C006E_4B223ADC02BF_impl*
end;//FreeItem

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}

{$EndIf l3RecordListPrim_imp_impl}

{$EndIf l3RecordListPrim_imp}

