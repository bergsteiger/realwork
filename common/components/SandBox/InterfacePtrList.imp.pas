{$IfNDef InterfacePtrList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "InterfacePtrList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::STLLike::InterfacePtrList
//
// ������ ���������� �� ����������. �� ������� ������ ����������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define InterfacePtrList_imp}
 _InterfaceList_Parent_ = _InterfacePtrList_Parent_;
 {$Include ..\SandBox\InterfaceList.imp.pas}
 _InterfacePtrList_ = {mixin} class(_InterfaceList_)
  {* ������ ���������� �� ����������. �� ������� ������ ���������� }
 end;//_InterfacePtrList_

{$Else InterfacePtrList_imp}

// start class _InterfacePtrList_

procedure FillItem(var thePlace: _ItemType_;
  const aFrom: _ItemType_); forward;

procedure FreeItem(var thePlace: _ItemType_);
//#UC START# *51DEC20B01D7_51E8098001DC_var*
//#UC END# *51DEC20B01D7_51E8098001DC_var*
begin
//#UC START# *51DEC20B01D7_51E8098001DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *51DEC20B01D7_51E8098001DC_impl*
end;//FreeItem

procedure FillItem(var thePlace: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *51DECB440087_51E8098001DC_var*
//#UC END# *51DECB440087_51E8098001DC_var*
begin
//#UC START# *51DECB440087_51E8098001DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *51DECB440087_51E8098001DC_impl*
end;//FillItem

{$Include ..\SandBox\InterfaceList.imp.pas}


{$EndIf InterfacePtrList_imp}
