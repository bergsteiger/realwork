{$IfNDef l3PtrListPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3PtrListPrim.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3PtrListPrim
//
// ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3PtrListPrim_imp}
 _l3StandardTypedList_Parent_ = _l3PtrListPrim_Parent_;
 {$Include ..\L3\l3StandardTypedList.imp.pas}
 _l3PtrListPrim_ = {abstract mixin} class(_l3StandardTypedList_)
  {* ������� ��� ������� ����������. ������ �� ��������� �������� ����� ���������. }
 end;//_l3PtrListPrim_

{$Else l3PtrListPrim_imp}

// start class _l3PtrListPrim_

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_47B941FB0284_var*
//#UC END# *47B94A5C006E_47B941FB0284_var*
begin
//#UC START# *47B94A5C006E_47B941FB0284_impl*
 // - ������ ����������� �� �����
 Pointer(aPlace) := nil;
//#UC END# *47B94A5C006E_47B941FB0284_impl*
end;//FreeItem


{$Include ..\L3\l3StandardTypedList.imp.pas}


{$EndIf l3PtrListPrim_imp}
