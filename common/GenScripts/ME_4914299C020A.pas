{$IfNDef l3StandardMemTypedList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3StandardMemTypedList.imp.pas"
// Стереотип: "Impurity"

{$Define l3StandardMemTypedList_imp}

 _DataType_ = Tl3Ptr;
 _l3TypedList_Parent_ = _l3StandardMemTypedList_Parent_;
 {$Include l3TypedList.imp.pas}
 _l3StandardMemTypedList_ = class(_l3TypedList_)
  {* Типизированный список со стандартной функцией распределения памяти }
 end;//_l3StandardMemTypedList_

{$Else l3StandardMemTypedList_imp}

{$IfNDef l3StandardMemTypedList_imp_impl}

{$Define l3StandardMemTypedList_imp_impl}

{$Include l3TypedList.imp.pas}

{$EndIf l3StandardMemTypedList_imp_impl}

{$EndIf l3StandardMemTypedList_imp}

