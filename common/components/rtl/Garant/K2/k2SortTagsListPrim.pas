unit k2SortTagsListPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\k2SortTagsListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Types
 , l3Memory
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TLongArray;
 _l3RefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}
 Tk2SortTagsListPrim = class(_l3RefList_)
 end;//Tk2SortTagsListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

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

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4DDA75CE02A8_var*
//#UC END# *47B07CF403D0_4DDA75CE02A8_var*
begin
//#UC START# *47B07CF403D0_4DDA75CE02A8_impl*
 Result := (l3LongArrayCompare(A, B) = 0);
//#UC END# *47B07CF403D0_4DDA75CE02A8_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4DDA75CE02A8_var*
//#UC END# *47B2C42A0163_4DDA75CE02A8_var*
begin
//#UC START# *47B2C42A0163_4DDA75CE02A8_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4DDA75CE02A8_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_4DDA75CE02A8_var*
//#UC END# *47B935AF0066_4DDA75CE02A8_var*
begin
//#UC START# *47B935AF0066_4DDA75CE02A8_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_4DDA75CE02A8_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4DDA75CE02A8_var*
//#UC END# *47B94A5C006E_4DDA75CE02A8_var*
begin
//#UC START# *47B94A5C006E_4DDA75CE02A8_impl*
 aPlace := nil;
//#UC END# *47B94A5C006E_4DDA75CE02A8_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4DDA75CE02A8_var*
//#UC END# *47B99D4503A2_4DDA75CE02A8_var*
begin
//#UC START# *47B99D4503A2_4DDA75CE02A8_impl*
 Result := l3LongArrayCompare(CI.rA^, CI.rB^);
//#UC END# *47B99D4503A2_4DDA75CE02A8_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2SortTagsListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}

end.
