{$IfNDef InterfaceList_imp}

// Модуль: "w:\common\components\SandBox\InterfaceList.imp.pas"
// Стереотип: "Impurity"

{$Define InterfaceList_imp}

 _List_Parent_ = _InterfaceList_Parent_;
 {$Include List.imp.pas}
 _InterfaceList_ = class(_List_)
 end;//_InterfaceList_

{$Else InterfaceList_imp}

{$IfNDef InterfaceList_imp_impl}

{$Define InterfaceList_imp_impl}

function IsSame(const A: _ItemType_;
 const B: _ItemType_): Boolean;
//#UC START# *51DECB820261_51E81D74001D_var*
//#UC END# *51DECB820261_51E81D74001D_var*
begin
//#UC START# *51DECB820261_51E81D74001D_impl*
 Result := (A = B);
//#UC END# *51DECB820261_51E81D74001D_impl*
end;//IsSame

{$Include List.imp.pas}

{$EndIf InterfaceList_imp_impl}

{$EndIf InterfaceList_imp}

