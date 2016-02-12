unit l3ProcedureList;
 {* Список процедур. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProcedureList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , SysUtils
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_Uncomparable}

type
 _ItemType_ = TProcedure;
 _l3StandardMemTypedList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StandardMemTypedList.imp.pas}
 Tl3ProcedureList = class(_l3StandardMemTypedList_)
  {* Список процедур. }
 end;//Tl3ProcedureList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
procedure DoExchange(var A: _ItemType_;
 var B: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)}
;
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
); forward;

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
//#UC START# *47B07CF403D0_47BB38C40154_var*
//#UC END# *47B07CF403D0_47BB38C40154_var*
begin
//#UC START# *47B07CF403D0_47BB38C40154_impl*
 Result := (PPointer(@A)^ = PPointer(@B)^);
//#UC END# *47B07CF403D0_47BB38C40154_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47BB38C40154_var*
//#UC END# *47B2C42A0163_47BB38C40154_var*
begin
//#UC START# *47B2C42A0163_47BB38C40154_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47BB38C40154_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure DoExchange(var A: _ItemType_;
 var B: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Меняет элементы списка местами. Без всяких проверок. }
//#UC START# *47B5C4080270_47BB38C40154_var*
var
 l_Tmp : _ItemType_;
//#UC END# *47B5C4080270_47BB38C40154_var*
begin
//#UC START# *47B5C4080270_47BB38C40154_impl*
 l_Tmp := A;
 A := B;
 B := l_Tmp;
//#UC END# *47B5C4080270_47BB38C40154_impl*
end;//DoExchange

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_47BB38C40154_var*
//#UC END# *47B935AF0066_47BB38C40154_var*
begin
//#UC START# *47B935AF0066_47BB38C40154_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_47BB38C40154_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_47BB38C40154_var*
//#UC END# *47B94A5C006E_47BB38C40154_var*
begin
//#UC START# *47B94A5C006E_47BB38C40154_impl*
 aPlace := nil;
//#UC END# *47B94A5C006E_47BB38C40154_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47BB38C40154_var*
//#UC END# *47B99D4503A2_47BB38C40154_var*
begin
//#UC START# *47B99D4503A2_47BB38C40154_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_47BB38C40154_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ProcedureList;

{$Include w:\common\components\rtl\Garant\L3\l3StandardMemTypedList.imp.pas}

end.
