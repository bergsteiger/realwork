{$IfNDef l3StandardMemTypedList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3StandardMemTypedList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3StandardMemTypedList
//
// �������������� ������ �� ����������� �������� ������������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3StandardMemTypedList_imp}
 _DataType_ = Tl3Ptr;
 _l3TypedList_Parent_ = _l3StandardMemTypedList_Parent_;
 {$Include ..\L3\l3TypedList.imp.pas}
 _l3StandardMemTypedList_ = {mixin} class(_l3TypedList_)
  {* �������������� ������ �� ����������� �������� ������������� ������ }
 end;//_l3StandardMemTypedList_

{$Else l3StandardMemTypedList_imp}


{$Include ..\L3\l3TypedList.imp.pas}


{$EndIf l3StandardMemTypedList_imp}
