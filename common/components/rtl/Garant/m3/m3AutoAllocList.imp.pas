{$IfNDef m3AutoAllocList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3AutoAllocList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::m3::m3CoreObjects::m3AutoAllocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define m3AutoAllocList_imp}
 {$Define l3Items_IsProto}

 {$Define l3Items_NoSort}

 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _m3AutoAllocList_ = {mixin} class(_l3UncomparabeObjectRefList_)
 protected
 // overridden property methods
   procedure pm_SetCount(aValue: Integer); override;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//_m3AutoAllocList_

{$Else m3AutoAllocList_imp}

// start class _m3AutoAllocList_

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_542179C40347_var*
//#UC END# *47B2C42A0163_542179C40347_var*
begin
//#UC START# *47B2C42A0163_542179C40347_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_542179C40347_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_542179C40347_var*
//#UC END# *47B99D4503A2_542179C40347_var*
begin
//#UC START# *47B99D4503A2_542179C40347_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_542179C40347_impl*
end;//CompareExistingItems


{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class _m3AutoAllocList_

{$If not defined(DesignTimeLibrary)}
class function _m3AutoAllocList_.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_542179C40347_var*
//#UC END# *47A6FEE600FC_542179C40347_var*
begin
//#UC START# *47A6FEE600FC_542179C40347_impl*
 Result := true;
//#UC END# *47A6FEE600FC_542179C40347_impl*
end;//_m3AutoAllocList_.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure _m3AutoAllocList_.pm_SetCount(aValue: Integer);
//#UC START# *47BEE088001A_542179C40347set_var*

  function __Forward(anItemPtr: PItemType; anIndex: LongInt): Boolean;
  begin//__Forward
   Result := true;
   anItemPtr^ := _ItemType_.Create;
  end;//__Forward

var
 LCount : LongInt;
//#UC END# *47BEE088001A_542179C40347set_var*
begin
//#UC START# *47BEE088001A_542179C40347set_impl*
 lCount := Count;
 inherited;
 if (LCount < aValue) then
  IterateF(LCount,Pred(aValue),l3L2IA(@__Forward));
//#UC END# *47BEE088001A_542179C40347set_impl*
end;//_m3AutoAllocList_.pm_SetCount

{$EndIf m3AutoAllocList_imp}
