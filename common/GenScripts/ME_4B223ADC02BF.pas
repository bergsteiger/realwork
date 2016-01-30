{$IfNDef l3RecordListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3RecordListPrim_imp}

 _l3RecordListPrimPrim_Parent_ = _l3RecordListPrim_Parent_;
 {$Include l3RecordListPrimPrim.imp.pas}
 _l3RecordListPrim_ = class(_l3RecordListPrimPrim_)
  {* Список записей }
 end;//_l3RecordListPrim_

{$Else l3RecordListPrim_imp}

{$IfNDef l3RecordListPrim_imp_impl}

{$Define l3RecordListPrim_imp_impl}

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4B223ADC02BF_var*
//#UC END# *47B94A5C006E_4B223ADC02BF_var*
begin
//#UC START# *47B94A5C006E_4B223ADC02BF_impl*
 Finalize(aPlace);
//#UC END# *47B94A5C006E_4B223ADC02BF_impl*
end;//FreeItem

type _Instance_R_ = _l3RecordListPrim_;

{$Include l3RecordListPrimPrim.imp.pas}

{$EndIf l3RecordListPrim_imp_impl}

{$EndIf l3RecordListPrim_imp}

