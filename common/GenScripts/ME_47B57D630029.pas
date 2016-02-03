{$IfNDef l3InterfacePtrList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas"
// ���������: "Impurity"

{$Define l3InterfacePtrList_imp}

 _l3InterfacePtrListPrim_Parent_ = _l3InterfacePtrList_Parent_;
 {$Include l3InterfacePtrListPrim.imp.pas}
 _l3InterfacePtrList_ = class(_l3InterfacePtrListPrim_)
  {* ������ ���������� �� ����������. }
 end;//_l3InterfacePtrList_

{$Else l3InterfacePtrList_imp}

{$IfNDef l3InterfacePtrList_imp_impl}

{$Define l3InterfacePtrList_imp_impl}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_47B57D630029_var*
//#UC END# *47B07CF403D0_47B57D630029_var*
begin
//#UC START# *47B07CF403D0_47B57D630029_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B57D630029_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B57D630029_var*
//#UC END# *47B2C42A0163_47B57D630029_var*
begin
//#UC START# *47B2C42A0163_47B57D630029_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B57D630029_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_47B57D630029_var*
//#UC END# *47B99D4503A2_47B57D630029_var*
begin
//#UC START# *47B99D4503A2_47B57D630029_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_47B57D630029_impl*
end;//CompareExistingItems

{$Include l3InterfacePtrListPrim.imp.pas}

{$EndIf l3InterfacePtrList_imp_impl}

{$EndIf l3InterfacePtrList_imp}

