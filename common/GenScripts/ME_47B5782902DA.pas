{$IfNDef l3PtrList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas"
// ���������: "Impurity"

{$Define l3PtrList_imp}

 _l3PtrListPrim_Parent_ = _l3PtrList_Parent_;
 {$Include l3PtrListPrim.imp.pas}
 _l3PtrList_ = class(_l3PtrListPrim_)
  {* ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������. }
 end;//_l3PtrList_

{$Else l3PtrList_imp}

{$IfNDef l3PtrList_imp_impl}

{$Define l3PtrList_imp_impl}

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* ��������� ������� ������. }
//#UC START# *47B935AF0066_47B5782902DA_var*
//#UC END# *47B935AF0066_47B5782902DA_var*
begin
//#UC START# *47B935AF0066_47B5782902DA_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47B5782902DA_impl*
end;//FillItem

type _Instance_R_ = _l3PtrList_;

{$Include l3PtrListPrim.imp.pas}

{$EndIf l3PtrList_imp_impl}

{$EndIf l3PtrList_imp}

