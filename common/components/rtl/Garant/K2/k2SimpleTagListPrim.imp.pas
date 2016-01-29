{$IfNDef k2SimpleTagListPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2SimpleTagListPrim.imp.pas"
// Начат: 16.07.2009 17:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2CoreObjects::k2SimpleTagListPrim
//
// Список параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2SimpleTagListPrim_imp}
 {$Define l3Items_NoChanging}

 {$Define l3Items_NoOwner}

 _l3VariantListPrim_Parent_ = _k2SimpleTagListPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}
 _k2SimpleTagListPrim_ = {mixin} class(_l3VariantListPrim_)
  {* Список параграфов }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//_k2SimpleTagListPrim_

{$Else k2SimpleTagListPrim_imp}

// start class _k2SimpleTagListPrim_

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A5F28820363_var*
//#UC END# *47B2C42A0163_4A5F28820363_var*
begin
//#UC START# *47B2C42A0163_4A5F28820363_impl*
 aTo.AssignTag(aFrom, k2_amAll - [k2_amNull]);
//#UC END# *47B2C42A0163_4A5F28820363_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
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

// start class _k2SimpleTagListPrim_

{$If not defined(DesignTimeLibrary)}
class function _k2SimpleTagListPrim_.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4A5F28820363_var*
//#UC END# *47A6FEE600FC_4A5F28820363_var*
begin
//#UC START# *47A6FEE600FC_4A5F28820363_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4A5F28820363_impl*
end;//_k2SimpleTagListPrim_.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$EndIf k2SimpleTagListPrim_imp}
