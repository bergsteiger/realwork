{$IfNDef l3ObjectPtrList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas"
// Стереотип: "Impurity"

{$Define l3ObjectPtrList_imp}

 _l3PtrList_Parent_ = _l3ObjectPtrList_Parent_;
 {$Include l3PtrList.imp.pas}
 _l3ObjectPtrList_ = class(_l3PtrList_)
  {* Список указателей на объекты. }
 end;//_l3ObjectPtrList_

{$Else l3ObjectPtrList_imp}

{$IfNDef l3ObjectPtrList_imp_impl}

{$Define l3ObjectPtrList_imp_impl}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_47B57B7800A7_var*
//#UC END# *47B07CF403D0_47B57B7800A7_var*
begin
//#UC START# *47B07CF403D0_47B57B7800A7_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B57B7800A7_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B57B7800A7_var*
//#UC END# *47B2C42A0163_47B57B7800A7_var*
begin
//#UC START# *47B2C42A0163_47B57B7800A7_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B57B7800A7_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B57B7800A7_var*
//#UC END# *47B99D4503A2_47B57B7800A7_var*
begin
//#UC START# *47B99D4503A2_47B57B7800A7_impl*
 Assert(false, 'Критерий сравнения двух нетипизированных объектов на самом деле непонятен');
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_47B57B7800A7_impl*
end;//CompareExistingItems

{$Include l3PtrList.imp.pas}

{$EndIf l3ObjectPtrList_imp_impl}

{$EndIf l3ObjectPtrList_imp}

