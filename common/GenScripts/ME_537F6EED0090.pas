unit dtNumRangeList;

// Модуль: "w:\common\components\rtl\Garant\DT\dtNumRangeList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , dtNumRange
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TdtNumRange;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TdtNumRangeList = class(_l3UncomparabeObjectRefList_)
 end;//TdtNumRangeList
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
//#UC START# *47B2C42A0163_537F6EED0090_var*
//#UC END# *47B2C42A0163_537F6EED0090_var*
begin
//#UC START# *47B2C42A0163_537F6EED0090_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_537F6EED0090_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_537F6EED0090_var*
//#UC END# *47B99D4503A2_537F6EED0090_var*
begin
//#UC START# *47B99D4503A2_537F6EED0090_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_537F6EED0090_impl*
end;//CompareExistingItems

type _Instance_R_ = TdtNumRangeList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
