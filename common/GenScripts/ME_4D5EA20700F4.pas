unit vgObjectList;
 {* Списсок указателей на объект. НИЧЕГО не освобождает }

// Модуль: "w:\common\components\rtl\external\VGScene\vgObjectList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvgObject;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TvgObjectList = class(_l3PtrList_)
  {* Списсок указателей на объект. НИЧЕГО не освобождает }
 end;//TvgObjectList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
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
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4D5EA20700F4_var*
//#UC END# *47B07CF403D0_4D5EA20700F4_var*
begin
//#UC START# *47B07CF403D0_4D5EA20700F4_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_4D5EA20700F4_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D5EA20700F4_var*
//#UC END# *47B2C42A0163_4D5EA20700F4_var*
begin
//#UC START# *47B2C42A0163_4D5EA20700F4_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D5EA20700F4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4D5EA20700F4_var*
//#UC END# *47B99D4503A2_4D5EA20700F4_var*
begin
//#UC START# *47B99D4503A2_4D5EA20700F4_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4D5EA20700F4_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVGScene)

end.
