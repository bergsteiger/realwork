{$IfNDef InterfaceList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "InterfaceList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::STLLike::InterfaceList
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define InterfaceList_imp}
 _List_Parent_ = _InterfaceList_Parent_;
 {$Include ..\SandBox\List.imp.pas}
 _InterfaceList_ = {mixin} class(_List_)
 end;//_InterfaceList_

{$Else InterfaceList_imp}

// start class _InterfaceList_

function IsSame(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *51DECB820261_51E81D74001D_var*
//#UC END# *51DECB820261_51E81D74001D_var*
begin
//#UC START# *51DECB820261_51E81D74001D_impl*
 Result := (A = B);
//#UC END# *51DECB820261_51E81D74001D_impl*
end;//IsSame

{$Include ..\SandBox\List.imp.pas}


{$EndIf InterfaceList_imp}
