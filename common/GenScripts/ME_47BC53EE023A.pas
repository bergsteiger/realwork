unit dtDictItemsPrim;
 {* Базовый список элементов словаря. }

// Модуль: "w:\common\components\rtl\Garant\DT\dtDictItemsPrim.pas"
// Стереотип: "SimpleClass"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , dtCustomDictItem
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TdtCustomDictItem;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TdtDictItemsPrim = class(_l3UncomparabeObjectRefList_)
  {* Базовый список элементов словаря. }
 end;//TdtDictItemsPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47BC53EE023A_var*
//#UC END# *47B2C42A0163_47BC53EE023A_var*
begin
//#UC START# *47B2C42A0163_47BC53EE023A_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47BC53EE023A_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47BC53EE023A_var*
//#UC END# *47B99D4503A2_47BC53EE023A_var*
begin
//#UC START# *47B99D4503A2_47BC53EE023A_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if CI.rA.Handle > CI.rB.Handle then
   Result := 1
 else
   if CI.rA.Handle < CI.rB.Handle then
     Result := -1
   else
     Result := 0;
//#UC END# *47B99D4503A2_47BC53EE023A_impl*
end;//CompareExistingItems

type _Instance_R_ = TdtDictItemsPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
