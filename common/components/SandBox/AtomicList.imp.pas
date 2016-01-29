{$IfNDef AtomicList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "AtomicList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::STLLike::AtomicList
//
// Список атомарных значений
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define AtomicList_imp}
 {$Define l3Items_IsAtomic}

 _UnrefcountedListPrim_Parent_ = _AtomicList_Parent_;
 {$Include ..\SandBox\UnrefcountedListPrim.imp.pas}
 _AtomicList_ = {mixin} class(_UnrefcountedListPrim_)
  {* Список атомарных значений }
 end;//_AtomicList_

{$Else AtomicList_imp}

// start class _AtomicList_

procedure FillItem(var thePlace: _ItemType_;
  const aFrom: _ItemType_); forward;

procedure FreeItem(var thePlace: _ItemType_);
//#UC START# *51DEC20B01D7_51DED48301D9_var*
//#UC END# *51DEC20B01D7_51DED48301D9_var*
begin
//#UC START# *51DEC20B01D7_51DED48301D9_impl*
 thePlace := _ItemType_(0);
//#UC END# *51DEC20B01D7_51DED48301D9_impl*
end;//FreeItem

procedure FillItem(var thePlace: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *51DECB440087_51DED48301D9_var*
//#UC END# *51DECB440087_51DED48301D9_var*
begin
//#UC START# *51DECB440087_51DED48301D9_impl*
 thePlace := aFrom;
//#UC END# *51DECB440087_51DED48301D9_impl*
end;//FillItem

{$Include ..\SandBox\UnrefcountedListPrim.imp.pas}


{$EndIf AtomicList_imp}
