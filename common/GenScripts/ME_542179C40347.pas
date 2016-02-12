{$IfNDef m3AutoAllocList_imp}

// Модуль: "w:\common\components\rtl\Garant\m3\m3AutoAllocList.imp.pas"
// Стереотип: "Impurity"

{$Define m3AutoAllocList_imp}

 {$Define l3Items_IsProto}

 {$Define l3Items_NoSort}

 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _m3AutoAllocList_ = class(_l3UncomparabeObjectRefList_)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure pm_SetCount(aValue: Integer); override; { can raise EListError }
 end;//_m3AutoAllocList_

{$Else m3AutoAllocList_imp}

{$IfNDef m3AutoAllocList_imp_impl}

{$Define m3AutoAllocList_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_542179C40347_var*
//#UC END# *47B2C42A0163_542179C40347_var*
begin
//#UC START# *47B2C42A0163_542179C40347_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_542179C40347_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_542179C40347_var*
//#UC END# *47B99D4503A2_542179C40347_var*
begin
//#UC START# *47B99D4503A2_542179C40347_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_542179C40347_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function _m3AutoAllocList_.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_542179C40347_var*
//#UC END# *47A6FEE600FC_542179C40347_var*
begin
//#UC START# *47A6FEE600FC_542179C40347_impl*
 Result := true;
//#UC END# *47A6FEE600FC_542179C40347_impl*
end;//_m3AutoAllocList_.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure _m3AutoAllocList_.pm_SetCount(aValue: Integer); { can raise EListError }
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

{$EndIf m3AutoAllocList_imp_impl}

{$EndIf m3AutoAllocList_imp}

