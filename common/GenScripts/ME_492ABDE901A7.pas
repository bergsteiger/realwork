{$IfNDef l3LockedChange_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3LockedChange" MUID: (492ABDE901A7)
// ��� ����: "_l3LockedChange_"

{$Define l3LockedChange_imp}

 _l3LockedChangePrim_Parent_ = _l3LockedChange_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3LockedChangePrim.imp.pas}
 _l3LockedChange_ = class(_l3LockedChangePrim_)
  {* ����������� �� ���������� �� ��������� ������ ��������� }
 end;//_l3LockedChange_

{$Else l3LockedChange_imp}

{$IfNDef l3LockedChange_imp_impl}

{$Define l3LockedChange_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3LockedChangePrim.imp.pas}

{$EndIf l3LockedChange_imp_impl}

{$EndIf l3LockedChange_imp}

