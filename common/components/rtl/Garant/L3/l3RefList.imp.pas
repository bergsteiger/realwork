{$IfNDef l3RefList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3RefList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3RefList
//
// ������� ��� ������ ������. ������ ������� ���������� � ��������� �� �������� �����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3RefList_imp}
 _l3StandardTypedList_Parent_ = _l3RefList_Parent_;
 {$Include ..\L3\l3StandardTypedList.imp.pas}
 _l3RefList_ = {abstract mixin} class(_l3StandardTypedList_)
  {* ������� ��� ������ ������. ������ ������� ���������� � ��������� �� �������� �����. }
 end;//_l3RefList_

{$Else l3RefList_imp}


{$Include ..\L3\l3StandardTypedList.imp.pas}


{$EndIf l3RefList_imp}
