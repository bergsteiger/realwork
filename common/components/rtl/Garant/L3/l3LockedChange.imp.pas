{$IfNDef l3LockedChange_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3LockedChange.imp.pas"
// �����: 24.11.2008 17:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::����������� �������::l3LockedChange
//
// ����������� �� ���������� �� ��������� ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3LockedChange_imp}
 _l3LockedChangePrim_Parent_ = _l3LockedChange_Parent_;
 {$Include ..\L3\l3LockedChangePrim.imp.pas}
 _l3LockedChange_ = {mixin} class(_l3LockedChangePrim_)
  {* ����������� �� ���������� �� ��������� ������ ��������� }
 end;//_l3LockedChange_

{$Else l3LockedChange_imp}

{$Include ..\L3\l3LockedChangePrim.imp.pas}


{$EndIf l3LockedChange_imp}
