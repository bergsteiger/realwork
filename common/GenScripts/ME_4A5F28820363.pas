{$IfNDef k2SimpleTagListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define k2SimpleTagListPrim_imp}

 {$Define l3Items_NoChanging}

 {$Define l3Items_NoOwner}

 _l3VariantListPrim_Parent_ = _k2SimpleTagListPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}
 _k2SimpleTagListPrim_ = class(_l3VariantListPrim_)
  {* Список параграфов }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//_k2SimpleTagListPrim_

{$Else k2SimpleTagListPrim_imp}

{$IfNDef k2SimpleTagListPrim_imp_impl}

{$Define k2SimpleTagListPrim_imp_impl}

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A5F28820363_var*
//#UC END# *47B2C42A0163_4A5F28820363_var*
begin
//#UC START# *47B2C42A0163_4A5F28820363_impl*
 aTo.AssignTag(aFrom, k2_amAll - [k2_amNull]);
//#UC END# *47B2C42A0163_4A5F28820363_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4A5F28820363_var*
//#UC END# *47B99D4503A2_4A5F28820363_var*
begin
//#UC START# *47B99D4503A2_4A5F28820363_impl*
 {$IfDef l3Items_HasCustomSort}
 Result := CI.rA^.AsObject.CompareWithTag(CI.rB^.AsObject, CI.rSortIndex);
 {$Else  l3Items_HasCustomSort}
 Result := -1;
 Assert(false);
 {$EndIf l3Items_HasCustomSort}
//#UC END# *47B99D4503A2_4A5F28820363_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function _k2SimpleTagListPrim_.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4A5F28820363_var*
//#UC END# *47A6FEE600FC_4A5F28820363_var*
begin
//#UC START# *47A6FEE600FC_4A5F28820363_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4A5F28820363_impl*
end;//_k2SimpleTagListPrim_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf k2SimpleTagListPrim_imp_impl}

{$EndIf k2SimpleTagListPrim_imp}

