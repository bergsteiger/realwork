{$IfNDef InterfacePtrList_imp}

// ������: "w:\common\components\SandBox\InterfacePtrList.imp.pas"
// ���������: "Impurity"
// ������� ������: "InterfacePtrList" MUID: (51E8098001DC)
// ��� ����: "_InterfacePtrList_"

{$Define InterfacePtrList_imp}

 _InterfaceList_Parent_ = _InterfacePtrList_Parent_;
 {$Include w:\common\components\SandBox\InterfaceList.imp.pas}
 _InterfacePtrList_ = class(_InterfaceList_)
  {* ������ ���������� �� ����������. �� ������� ������ ���������� }
 end;//_InterfacePtrList_

{$Else InterfacePtrList_imp}

{$IfNDef InterfacePtrList_imp_impl}

{$Define InterfacePtrList_imp_impl}

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

{$Include w:\common\components\SandBox\InterfaceList.imp.pas}

{$EndIf InterfacePtrList_imp_impl}

{$EndIf InterfacePtrList_imp}

