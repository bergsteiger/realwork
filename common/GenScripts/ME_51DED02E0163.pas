{$IfNDef UnrefcountedListPrim_imp}

// Модуль: "w:\common\components\SandBox\UnrefcountedListPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "UnrefcountedListPrim" MUID: (51DED02E0163)
// Имя типа: "_UnrefcountedListPrim_"

{$Define UnrefcountedListPrim_imp}

 {$Define l3Items_IsUnrefcounted}

 _List_Parent_ = _UnrefcountedListPrim_Parent_;
 {$Include w:\common\components\SandBox\List.imp.pas}
 _UnrefcountedListPrim_ = class(_List_)
  {* Список значений без какого то бы ни было подсчёта ссылок }
 end;//_UnrefcountedListPrim_

{$Else UnrefcountedListPrim_imp}

{$IfNDef UnrefcountedListPrim_imp_impl}

{$Define UnrefcountedListPrim_imp_impl}

function IsSame(const A: _ItemType_;
 const B: _ItemType_): Boolean;
//#UC START# *51DECB820261_51DED02E0163_var*
//#UC END# *51DECB820261_51DED02E0163_var*
begin
//#UC START# *51DECB820261_51DED02E0163_impl*
 Result := (A = B);
//#UC END# *51DECB820261_51DED02E0163_impl*
end;//IsSame

{$Include w:\common\components\SandBox\List.imp.pas}

{$EndIf UnrefcountedListPrim_imp_impl}

{$EndIf UnrefcountedListPrim_imp}

