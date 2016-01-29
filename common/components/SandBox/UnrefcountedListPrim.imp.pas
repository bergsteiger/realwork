{$IfNDef UnrefcountedListPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "UnrefcountedListPrim.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::STLLike::UnrefcountedListPrim
//
// Список значений без какого то бы ни было подсчёта ссылок
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define UnrefcountedListPrim_imp}
 {$Define l3Items_IsUnrefcounted}

 _List_Parent_ = _UnrefcountedListPrim_Parent_;
 {$Include ..\SandBox\List.imp.pas}
 _UnrefcountedListPrim_ = {mixin} class(_List_)
  {* Список значений без какого то бы ни было подсчёта ссылок }
 end;//_UnrefcountedListPrim_

{$Else UnrefcountedListPrim_imp}

// start class _UnrefcountedListPrim_

function IsSame(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *51DECB820261_51DED02E0163_var*
//#UC END# *51DECB820261_51DED02E0163_var*
begin
//#UC START# *51DECB820261_51DED02E0163_impl*
 Result := (A = B);
//#UC END# *51DECB820261_51DED02E0163_impl*
end;//IsSame

{$Include ..\SandBox\List.imp.pas}


{$EndIf UnrefcountedListPrim_imp}
