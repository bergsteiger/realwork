{$IfNDef l3RecordWithEQList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas"
// Стереотип: "Impurity"

{$Define l3RecordWithEQList_imp}

 _l3RecordListPrim_Parent_ = _l3RecordWithEQList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 _l3RecordWithEQList_ = class(_l3RecordListPrim_)
  {* Список записей с операцией EQ }
 end;//_l3RecordWithEQList_

{$Else l3RecordWithEQList_imp}

{$IfNDef l3RecordWithEQList_imp_impl}

{$Define l3RecordWithEQList_imp_impl}

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4B223DB5024B_var*
//#UC END# *47B07CF403D0_4B223DB5024B_var*
begin
//#UC START# *47B07CF403D0_4B223DB5024B_impl*
 Result := A.EQ(B);
//#UC END# *47B07CF403D0_4B223DB5024B_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

{$EndIf l3RecordWithEQList_imp_impl}

{$EndIf l3RecordWithEQList_imp}

