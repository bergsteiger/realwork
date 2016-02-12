{$IfNDef l3InterfaceRefList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas"
// Стереотип: "Impurity"

{$Define l3InterfaceRefList_imp}

 _l3InterfaceRefListPrim_Parent_ = _l3InterfaceRefList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 _l3InterfaceRefList_ = class(_l3InterfaceRefListPrim_)
  {* Список ссылок на интерфейсы. }
 end;//_l3InterfaceRefList_

{$Else l3InterfaceRefList_imp}

{$IfNDef l3InterfaceRefList_imp_impl}

{$Define l3InterfaceRefList_imp_impl}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_47B57D830369_var*
//#UC END# *47B07CF403D0_47B57D830369_var*
begin
//#UC START# *47B07CF403D0_47B57D830369_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B57D830369_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B57D830369_var*
//#UC END# *47B2C42A0163_47B57D830369_var*
begin
//#UC START# *47B2C42A0163_47B57D830369_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B57D830369_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B57D830369_var*
//#UC END# *47B99D4503A2_47B57D830369_var*
begin
//#UC START# *47B99D4503A2_47B57D830369_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_47B57D830369_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

{$EndIf l3InterfaceRefList_imp_impl}

{$EndIf l3InterfaceRefList_imp}

