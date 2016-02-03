{$IfNDef l3InterfaceRefListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3InterfaceRefListPrim_imp}

 _l3RefList_Parent_ = _l3InterfaceRefListPrim_Parent_;
 {$Include l3RefList.imp.pas}
 _l3InterfaceRefListPrim_ = {abstract} class(_l3RefList_)
 end;//_l3InterfaceRefListPrim_

{$Else l3InterfaceRefListPrim_imp}

{$IfNDef l3InterfaceRefListPrim_imp_impl}

{$Define l3InterfaceRefListPrim_imp_impl}

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_); forward;

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_47B9AF6E0228_var*
//#UC END# *47B935AF0066_47B9AF6E0228_var*
begin
//#UC START# *47B935AF0066_47B9AF6E0228_impl*
 aPlace := anItem;
(* Pointer(aPlace) := Pointer(anItem);
 if (Pointer(anItem) <> nil) then
  IUnknown(anItem)._AddRef;*)
//#UC END# *47B935AF0066_47B9AF6E0228_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_47B9AF6E0228_var*
//#UC END# *47B94A5C006E_47B9AF6E0228_var*
begin
//#UC START# *47B94A5C006E_47B9AF6E0228_impl*
 //IUnknown(aPlace) := nil;
 aPlace := nil;
//#UC END# *47B94A5C006E_47B9AF6E0228_impl*
end;//FreeItem

{$Include l3RefList.imp.pas}

{$EndIf l3InterfaceRefListPrim_imp_impl}

{$EndIf l3InterfaceRefListPrim_imp}

