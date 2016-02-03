{$IfNDef l3NotSortedObjectRefList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas"
// Стереотип: "Impurity"

{$Define l3NotSortedObjectRefList_imp}

 {$Define l3Items_NoSort}

 _l3UncomparabeObjectRefList_Parent_ = _l3NotSortedObjectRefList_Parent_;
 {$Include l3UncomparabeObjectRefList.imp.pas}
 _l3NotSortedObjectRefList_ = {abstract} class(_l3UncomparabeObjectRefList_)
 end;//_l3NotSortedObjectRefList_

{$Else l3NotSortedObjectRefList_imp}

{$IfNDef l3NotSortedObjectRefList_imp_impl}

{$Define l3NotSortedObjectRefList_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55DEEA210182_var*
//#UC END# *47B2C42A0163_55DEEA210182_var*
begin
//#UC START# *47B2C42A0163_55DEEA210182_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_55DEEA210182_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55DEEA210182_var*
//#UC END# *47B99D4503A2_55DEEA210182_var*
begin
//#UC START# *47B99D4503A2_55DEEA210182_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_55DEEA210182_impl*
end;//CompareExistingItems

{$Include l3UncomparabeObjectRefList.imp.pas}

{$EndIf l3NotSortedObjectRefList_imp_impl}

{$EndIf l3NotSortedObjectRefList_imp}

