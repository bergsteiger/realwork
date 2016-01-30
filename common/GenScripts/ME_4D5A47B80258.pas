unit nevObjectList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevObjectList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevObject;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefListPrim.imp.pas}
 TnevObjectList = class(_l3InterfaceRefListPrim_)
 end;//TnevObjectList

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
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4D5A47B80258_var*
//#UC END# *47B07CF403D0_4D5A47B80258_var*
begin
//#UC START# *47B07CF403D0_4D5A47B80258_impl*
 Result := A.AsObject.Box.IsSame(B.AsObject.Box);
//#UC END# *47B07CF403D0_4D5A47B80258_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D5A47B80258_var*
//#UC END# *47B2C42A0163_4D5A47B80258_var*
begin
//#UC START# *47B2C42A0163_4D5A47B80258_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D5A47B80258_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4D5A47B80258_var*
//#UC END# *47B99D4503A2_4D5A47B80258_var*
begin
//#UC START# *47B99D4503A2_4D5A47B80258_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_4D5A47B80258_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevObjectList;

{$Include l3InterfaceRefListPrim.imp.pas}

end.
