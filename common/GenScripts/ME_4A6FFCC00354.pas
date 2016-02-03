{$IfNDef l3InterfacePtrListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacePtrListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3InterfacePtrListPrim_imp}

 _l3PtrListPrim_Parent_ = _l3InterfacePtrListPrim_Parent_;
 {$Include l3PtrListPrim.imp.pas}
 _l3InterfacePtrListPrim_ = class(_l3PtrListPrim_)
 end;//_l3InterfacePtrListPrim_

{$Else l3InterfacePtrListPrim_imp}

{$IfNDef l3InterfacePtrListPrim_imp_impl}

{$Define l3InterfacePtrListPrim_imp_impl}

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_4A6FFCC00354_var*
//#UC END# *47B935AF0066_4A6FFCC00354_var*
begin
//#UC START# *47B935AF0066_4A6FFCC00354_impl*
 Pointer(aPlace) := Pointer(anItem);
//#UC END# *47B935AF0066_4A6FFCC00354_impl*
end;//FillItem

{$Include l3PtrListPrim.imp.pas}

{$EndIf l3InterfacePtrListPrim_imp_impl}

{$EndIf l3InterfacePtrListPrim_imp}

