{$IfNDef nsNodeNotifierPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsNodeNotifierPrim.imp.pas"
// �����: 21.10.2008 11:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Tree::nsNodeNotifierPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsNodeNotifierPrim_imp}
 _l3ChangingChangedNotifier_Parent_ = _nsNodeNotifierPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}
 _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
 {$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}
 _nsNodeNotifierPrim_ = {mixin} class(_l3LockedChange_)
 end;//_nsNodeNotifierPrim_

{$Else nsNodeNotifierPrim_imp}

{$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}


{$EndIf nsNodeNotifierPrim_imp}
