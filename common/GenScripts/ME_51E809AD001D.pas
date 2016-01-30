{$IfNDef InterfaceRefList_imp}

// Модуль: "w:\common\components\SandBox\InterfaceRefList.imp.pas"
// Стереотип: "Impurity"

{$Define InterfaceRefList_imp}

 _InterfaceList_Parent_ = _InterfaceRefList_Parent_;
 {$Include InterfaceList.imp.pas}
 _InterfaceRefList_ = class(_InterfaceList_)
  {* Список Ссылок на интерфейсы. Владеет своими элементами }
 end;//_InterfaceRefList_

{$Else InterfaceRefList_imp}

{$IfNDef InterfaceRefList_imp_impl}

{$Define InterfaceRefList_imp_impl}

procedure FillItem(var thePlace: _ItemType_;
 const aFrom: _ItemType_); forward;

procedure FreeItem(var thePlace: _ItemType_);
//#UC START# *51DEC20B01D7_51E809AD001D_var*
//#UC END# *51DEC20B01D7_51E809AD001D_var*
begin
//#UC START# *51DEC20B01D7_51E809AD001D_impl*
 thePlace := nil;
//#UC END# *51DEC20B01D7_51E809AD001D_impl*
end;//FreeItem

procedure FillItem(var thePlace: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *51DECB440087_51E809AD001D_var*
//#UC END# *51DECB440087_51E809AD001D_var*
begin
//#UC START# *51DECB440087_51E809AD001D_impl*
 thePlace := afrom;
//#UC END# *51DECB440087_51E809AD001D_impl*
end;//FillItem

{$Include InterfaceList.imp.pas}

{$EndIf InterfaceRefList_imp_impl}

{$EndIf InterfaceRefList_imp}

