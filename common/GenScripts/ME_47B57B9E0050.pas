{$IfNDef l3ObjectRefList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectRefList.imp.pas"
// Стереотип: "Impurity"

{$Define l3ObjectRefList_imp}

 _l3UncomparabeObjectRefList_Parent_ = _l3ObjectRefList_Parent_;
 {$Include l3UncomparabeObjectRefList.imp.pas}
 _l3ObjectRefList_ = class(_l3UncomparabeObjectRefList_)
  {* Список ссылок на объекты. }
 end;//_l3ObjectRefList_

{$Else l3ObjectRefList_imp}

{$IfNDef l3ObjectRefList_imp_impl}

{$Define l3ObjectRefList_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B57B9E0050_var*
//#UC END# *47B2C42A0163_47B57B9E0050_var*
begin
//#UC START# *47B2C42A0163_47B57B9E0050_impl*
 //aTo.Assign(aFrom);
 Assert(false);
//#UC END# *47B2C42A0163_47B57B9E0050_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B57B9E0050_var*
//#UC END# *47B99D4503A2_47B57B9E0050_var*
begin
//#UC START# *47B99D4503A2_47B57B9E0050_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA^.OCompare(CI.rB^);
//#UC END# *47B99D4503A2_47B57B9E0050_impl*
end;//CompareExistingItems

type _Instance_R_ = _l3ObjectRefList_;

{$Include l3UncomparabeObjectRefList.imp.pas}

{$EndIf l3ObjectRefList_imp_impl}

{$EndIf l3ObjectRefList_imp}

