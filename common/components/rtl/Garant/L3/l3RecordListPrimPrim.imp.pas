{$IfNDef l3RecordListPrimPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3RecordListPrimPrim.imp.pas"
// �����: 24.08.2011 18:13
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3RecordListPrimPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3RecordListPrimPrim_imp}
 _l3StandardMemTypedList_Parent_ = _l3RecordListPrimPrim_Parent_;
 {$Include ..\L3\l3StandardMemTypedList.imp.pas}
 _l3RecordListPrimPrim_ = {mixin} class(_l3StandardMemTypedList_)
 end;//_l3RecordListPrimPrim_

{$Else l3RecordListPrimPrim_imp}

// start class _l3RecordListPrimPrim_

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  ); forward;

procedure DoExchange(var A: _ItemType_;
  var B: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B5C4080270_4E5506F6007E_var*
//#UC END# *47B5C4080270_4E5506F6007E_var*
begin
//#UC START# *47B5C4080270_4E5506F6007E_impl*
 l3Swap(A, B, SizeOf(A));
//#UC END# *47B5C4080270_4E5506F6007E_impl*
end;//DoExchange

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_4E5506F6007E_var*
//#UC END# *47B935AF0066_4E5506F6007E_var*
begin
//#UC START# *47B935AF0066_4E5506F6007E_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_4E5506F6007E_impl*
end;//FillItem


{$Include ..\L3\l3StandardMemTypedList.imp.pas}


{$EndIf l3RecordListPrimPrim_imp}
