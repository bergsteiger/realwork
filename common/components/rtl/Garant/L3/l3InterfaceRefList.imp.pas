{$IfNDef l3InterfaceRefList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3InterfaceRefList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3InterfaceRefList
//
// ������ ������ �� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3InterfaceRefList_imp}
 _l3InterfaceRefListPrim_Parent_ = _l3InterfaceRefList_Parent_;
 {$Include ..\L3\l3InterfaceRefListPrim.imp.pas}
 _l3InterfaceRefList_ = {mixin} class(_l3InterfaceRefListPrim_)
  {* ������ ������ �� ����������. }
 end;//_l3InterfaceRefList_

{$Else l3InterfaceRefList_imp}

// start class _l3InterfaceRefList_

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_47B57D830369_var*
//#UC END# *47B07CF403D0_47B57D830369_var*
begin
//#UC START# *47B07CF403D0_47B57D830369_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B57D830369_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B57D830369_var*
//#UC END# *47B2C42A0163_47B57D830369_var*
begin
//#UC START# *47B2C42A0163_47B57D830369_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B57D830369_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
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


{$Include ..\L3\l3InterfaceRefListPrim.imp.pas}


{$EndIf l3InterfaceRefList_imp}
