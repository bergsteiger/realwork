{$IfNDef l3StandardMemTypedList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3StandardMemTypedList.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3StandardMemTypedList" MUID: (4914299C020A)
// ��� ����: "_l3StandardMemTypedList_"

{$Define l3StandardMemTypedList_imp}

 _DataType_ = Tl3Ptr;
 _l3TypedList_Parent_ = _l3StandardMemTypedList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3TypedList.imp.pas}
 _l3StandardMemTypedList_ = class(_l3TypedList_)
  {* �������������� ������ �� ����������� �������� ������������� ������ }
 end;//_l3StandardMemTypedList_

{$Else l3StandardMemTypedList_imp}

{$IfNDef l3StandardMemTypedList_imp_impl}

{$Define l3StandardMemTypedList_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3TypedList.imp.pas}

{$EndIf l3StandardMemTypedList_imp_impl}

{$EndIf l3StandardMemTypedList_imp}

