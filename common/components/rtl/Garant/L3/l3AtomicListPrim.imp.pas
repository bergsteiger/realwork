{$IfNDef l3AtomicListPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3AtomicListPrim.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3AtomicListPrim
//
// ������ ��������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3AtomicListPrim_imp}
 {$Define l3Items_IsAtomic}
 { ����������, ��� �������� ������ - ��������� }

 _l3UnrefcountedList_Parent_ = _l3AtomicListPrim_Parent_;
 {$Include ..\L3\l3UnrefcountedList.imp.pas}
 _l3AtomicListPrim_ = {mixin} class(_l3UnrefcountedList_)
  {* ������ ��������� ��������� }
 end;//_l3AtomicListPrim_

{$Else l3AtomicListPrim_imp}


{$Include ..\L3\l3UnrefcountedList.imp.pas}


{$EndIf l3AtomicListPrim_imp}
