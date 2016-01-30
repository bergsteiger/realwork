{$IfNDef l3UncomparabeObjectRefList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas"
// Стереотип: "Impurity"

{$Define l3UncomparabeObjectRefList_imp}

 _l3ObjectRefListPrim_Parent_ = _l3UncomparabeObjectRefList_Parent_;
 {$Include l3ObjectRefListPrim.imp.pas}
 _l3UncomparabeObjectRefList_ = {abstract} class(_l3ObjectRefListPrim_)
 end;//_l3UncomparabeObjectRefList_

{$Else l3UncomparabeObjectRefList_imp}

{$IfNDef l3UncomparabeObjectRefList_imp_impl}

{$Define l3UncomparabeObjectRefList_imp_impl}

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_); forward;

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_47B99E920196_var*
//#UC END# *47B935AF0066_47B99E920196_var*
begin
//#UC START# *47B935AF0066_47B99E920196_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_47B99E920196_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_47B99E920196_var*
//#UC END# *47B94A5C006E_47B99E920196_var*
begin
//#UC START# *47B94A5C006E_47B99E920196_impl*
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_47B99E920196_impl*
end;//FreeItem

type _Instance_R_ = _l3UncomparabeObjectRefList_;

{$Include l3ObjectRefListPrim.imp.pas}

{$EndIf l3UncomparabeObjectRefList_imp_impl}

{$EndIf l3UncomparabeObjectRefList_imp}

