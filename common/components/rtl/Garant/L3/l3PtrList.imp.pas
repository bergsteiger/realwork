{$IfNDef l3PtrList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3PtrList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3PtrList
//
// ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3PtrList_imp}
 _l3PtrListPrim_Parent_ = _l3PtrList_Parent_;
 {$Include ..\L3\l3PtrListPrim.imp.pas}
 _l3PtrList_ = {mixin} class(_l3PtrListPrim_)
  {* ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������. }
 end;//_l3PtrList_

{$Else l3PtrList_imp}

// start class _l3PtrList_

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_47B5782902DA_var*
//#UC END# *47B935AF0066_47B5782902DA_var*
begin
//#UC START# *47B935AF0066_47B5782902DA_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47B5782902DA_impl*
end;//FillItem


{$Include ..\L3\l3PtrListPrim.imp.pas}


{$EndIf l3PtrList_imp}
