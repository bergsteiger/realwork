{$IfNDef l3RefList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3RefList.imp.pas"
// ���������: "Impurity"

{$Define l3RefList_imp}

 _l3StandardTypedList_Parent_ = _l3RefList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}
 _l3RefList_ = {abstract} class(_l3StandardTypedList_)
  {* ������� ��� ������ ������. ������ ������� ���������� � ��������� �� �������� �����. }
 end;//_l3RefList_

{$Else l3RefList_imp}

{$IfNDef l3RefList_imp_impl}

{$Define l3RefList_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}

{$EndIf l3RefList_imp_impl}

{$EndIf l3RefList_imp}

