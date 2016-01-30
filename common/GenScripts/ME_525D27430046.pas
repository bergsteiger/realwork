unit ddHyperlinkTargetList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddHyperlinkTargetList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddHyperlinkTarget
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddHyperlinkTarget;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TddHyperlinkTargetList = class(_l3UncomparabeObjectRefList_)
 end;//TddHyperlinkTargetList

implementation

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
//#UC START# *47B2C42A0163_525D27430046_var*
//#UC END# *47B2C42A0163_525D27430046_var*
begin
//#UC START# *47B2C42A0163_525D27430046_impl*
 Assert(false);
//#UC END# *47B2C42A0163_525D27430046_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_525D27430046_var*
//#UC END# *47B99D4503A2_525D27430046_var*
begin
//#UC START# *47B99D4503A2_525D27430046_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
 Assert(false);
//#UC END# *47B99D4503A2_525D27430046_impl*
end;//CompareExistingItems

type _Instance_R_ = TddHyperlinkTargetList;

{$Include l3UncomparabeObjectRefList.imp.pas}

end.
