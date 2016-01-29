{$IfNDef InterfaceRefList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "InterfaceRefList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::STLLike::InterfaceRefList
//
// Список Ссылок на интерфейсы. Владеет своими элементами
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define InterfaceRefList_imp}
 _InterfaceList_Parent_ = _InterfaceRefList_Parent_;
 {$Include ..\SandBox\InterfaceList.imp.pas}
 _InterfaceRefList_ = {mixin} class(_InterfaceList_)
  {* Список Ссылок на интерфейсы. Владеет своими элементами }
 end;//_InterfaceRefList_

{$Else InterfaceRefList_imp}

// start class _InterfaceRefList_

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

{$Include ..\SandBox\InterfaceList.imp.pas}


{$EndIf InterfaceRefList_imp}
