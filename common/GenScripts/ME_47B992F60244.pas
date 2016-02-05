{$IfNDef l3UnrefcountedList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas"
// ���������: "Impurity"

{$Define l3UnrefcountedList_imp}

 //#UC START# *47B992F60244ci*
 {$Define l3Items_IsUnrefcounted}
 //#UC END# *47B992F60244ci*
 _l3StandardTypedList_Parent_ = _l3UnrefcountedList_Parent_;
 {$Include l3StandardTypedList.imp.pas}
 //#UC START# *47B992F60244cit*
 //#UC END# *47B992F60244cit*
 _l3UnrefcountedList_ = {abstract} class(_l3StandardTypedList_)
  {* ������ ���������, ������� �� ����� ������� � �������� ������ }
 //#UC START# *47B992F60244publ*
 //#UC END# *47B992F60244publ*
 end;//_l3UnrefcountedList_

{$Else l3UnrefcountedList_imp}

{$IfNDef l3UnrefcountedList_imp_impl}

{$Define l3UnrefcountedList_imp_impl}

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

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_47B992F60244_var*
//#UC END# *47B07CF403D0_47B992F60244_var*
begin
//#UC START# *47B07CF403D0_47B992F60244_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B992F60244_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B992F60244_var*
//#UC END# *47B2C42A0163_47B992F60244_var*
begin
//#UC START# *47B2C42A0163_47B992F60244_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B992F60244_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* ��������� ������� ������. }
//#UC START# *47B935AF0066_47B992F60244_var*
//#UC END# *47B935AF0066_47B992F60244_var*
begin
//#UC START# *47B935AF0066_47B992F60244_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47B992F60244_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* ������� ������� ������ }
//#UC START# *47B94A5C006E_47B992F60244_var*
//#UC END# *47B94A5C006E_47B992F60244_var*
begin
//#UC START# *47B94A5C006E_47B992F60244_impl*
 // - ������ ����������� �� �����
 {$IfDef l3Items_IsAtomic}
 aPlace := 0;
 {$Else  l3Items_IsAtomic}
 Integer(aPlace) := 0;
 {$EndIf l3Items_IsAtomic}
//#UC END# *47B94A5C006E_47B992F60244_impl*
end;//FreeItem

{$Include l3StandardTypedList.imp.pas}

//#UC START# *47B992F60244impl*
//#UC END# *47B992F60244impl*

{$EndIf l3UnrefcountedList_imp_impl}

{$EndIf l3UnrefcountedList_imp}

