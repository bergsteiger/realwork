{$IfNDef l3RecordListPrimPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3RecordListPrimPrim_imp}

 _l3StandardMemTypedList_Parent_ = _l3RecordListPrimPrim_Parent_;
 {$Include l3StandardMemTypedList.imp.pas}
 _l3RecordListPrimPrim_ = class(_l3StandardMemTypedList_)
 end;//_l3RecordListPrimPrim_

{$Else l3RecordListPrimPrim_imp}

{$IfNDef l3RecordListPrimPrim_imp_impl}

{$Define l3RecordListPrimPrim_imp_impl}

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_); forward;

procedure DoExchange(var A: _ItemType_;
 var B: _ItemType_;
 anItems: _l3Items_);
 {* Меняет элементы списка местами. Без всяких проверок. }
//#UC START# *47B5C4080270_4E5506F6007E_var*
//#UC END# *47B5C4080270_4E5506F6007E_var*
begin
//#UC START# *47B5C4080270_4E5506F6007E_impl*
 l3Swap(A, B, SizeOf(A));
//#UC END# *47B5C4080270_4E5506F6007E_impl*
end;//DoExchange

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_4E5506F6007E_var*
//#UC END# *47B935AF0066_4E5506F6007E_var*
begin
//#UC START# *47B935AF0066_4E5506F6007E_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_4E5506F6007E_impl*
end;//FillItem

type _Instance_R_ = _l3RecordListPrimPrim_;

{$Include l3StandardMemTypedList.imp.pas}

{$EndIf l3RecordListPrimPrim_imp_impl}

{$EndIf l3RecordListPrimPrim_imp}

