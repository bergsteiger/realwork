{$IfNDef l3DataRefList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3DataRefList.imp.pas"
// ���������: "Impurity"

{$Define l3DataRefList_imp}

 _l3RefList_Parent_ = _l3DataRefList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}
 _l3DataRefList_ = class(_l3RefList_)
  {* ������ ������ �� ������. ��������� ��������� ������ ����������. }
 end;//_l3DataRefList_

{$Else l3DataRefList_imp}

{$IfNDef l3DataRefList_imp_impl}

{$Define l3DataRefList_imp_impl}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)}
;
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
); forward;

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)}
;
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_47B5877A02EE_var*
//#UC END# *47B07CF403D0_47B5877A02EE_var*
begin
//#UC START# *47B07CF403D0_47B5877A02EE_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B5877A02EE_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B5877A02EE_var*
//#UC END# *47B2C42A0163_47B5877A02EE_var*
begin
//#UC START# *47B2C42A0163_47B5877A02EE_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B5877A02EE_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* ��������� ������� ������. }
//#UC START# *47B935AF0066_47B5877A02EE_var*
//#UC END# *47B935AF0066_47B5877A02EE_var*
begin
//#UC START# *47B935AF0066_47B5877A02EE_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47B5877A02EE_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* ������� ������� ������ }
//#UC START# *47B94A5C006E_47B5877A02EE_var*
//#UC END# *47B94A5C006E_47B5877A02EE_var*
begin
//#UC START# *47B94A5C006E_47B5877A02EE_impl*
 l3System.FreeLocalMem(aPlace);
//#UC END# *47B94A5C006E_47B5877A02EE_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_47B5877A02EE_var*
//#UC END# *47B99D4503A2_47B5877A02EE_var*
begin
//#UC START# *47B99D4503A2_47B5877A02EE_impl*
 Assert(false, '��������� ��� ���������� ���������������� ���������');
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_47B5877A02EE_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}

{$EndIf l3DataRefList_imp_impl}

{$EndIf l3DataRefList_imp}

