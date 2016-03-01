{$IfNDef l3DataPtrList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3DataPtrList.imp.pas"
// Стереотип: "Impurity"

{$Define l3DataPtrList_imp}

 _l3PtrList_Parent_ = _l3DataPtrList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 _l3DataPtrList_ = class(_l3PtrList_)
  {* Список указателей на данные. Не управляет жизненным циклом данных. }
 end;//_l3DataPtrList_

{$Else l3DataPtrList_imp}

{$IfNDef l3DataPtrList_imp_impl}

{$Define l3DataPtrList_imp_impl}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_47B587AA00C9_var*
//#UC END# *47B07CF403D0_47B587AA00C9_var*
begin
//#UC START# *47B07CF403D0_47B587AA00C9_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B587AA00C9_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B587AA00C9_var*
//#UC END# *47B2C42A0163_47B587AA00C9_var*
begin
//#UC START# *47B2C42A0163_47B587AA00C9_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B587AA00C9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B587AA00C9_var*
//#UC END# *47B99D4503A2_47B587AA00C9_var*
begin
//#UC START# *47B99D4503A2_47B587AA00C9_impl*
 Assert(false, 'На самом деле непонятно - каков критерий сравнения нетипизированных указателей');
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_47B587AA00C9_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}

{$EndIf l3DataPtrList_imp_impl}

{$EndIf l3DataPtrList_imp}

