{$IfNDef l3AtomicListPrim_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas"
// ���������: "Impurity"

{$Define l3AtomicListPrim_imp}

 {$Define l3Items_IsAtomic}

 _l3UnrefcountedList_Parent_ = _l3AtomicListPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
 _l3AtomicListPrim_ = class(_l3UnrefcountedList_)
  {* ������ ��������� ��������� }
 end;//_l3AtomicListPrim_

{$Else l3AtomicListPrim_imp}

{$IfNDef l3AtomicListPrim_imp_impl}

{$Define l3AtomicListPrim_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}

{$EndIf l3AtomicListPrim_imp_impl}

{$EndIf l3AtomicListPrim_imp}

