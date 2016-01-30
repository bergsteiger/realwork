unit nsBaseChatHistoryList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsBaseChatHistoryList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , ChatInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IbsChatHistoryWindow;
 _l3InterfacePtrListPrim_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrListPrim.imp.pas}
 TnsBaseChatHistoryList = class(_l3InterfacePtrListPrim_)
 end;//TnsBaseChatHistoryList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
//#UC START# *47B07CF403D0_4A6EAA6901F5_var*
//#UC END# *47B07CF403D0_4A6EAA6901F5_var*
begin
//#UC START# *47B07CF403D0_4A6EAA6901F5_impl*
 Result := A.UserID = B.UserID;
//#UC END# *47B07CF403D0_4A6EAA6901F5_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A6EAA6901F5_var*
//#UC END# *47B2C42A0163_4A6EAA6901F5_var*
begin
//#UC START# *47B2C42A0163_4A6EAA6901F5_impl*
 Assert(False);
//#UC END# *47B2C42A0163_4A6EAA6901F5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4A6EAA6901F5_var*
//#UC END# *47B99D4503A2_4A6EAA6901F5_var*
begin
//#UC START# *47B99D4503A2_4A6EAA6901F5_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA.UserID) - Integer(CI.rB.UserID);
//#UC END# *47B99D4503A2_4A6EAA6901F5_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsBaseChatHistoryList;

{$Include l3InterfacePtrListPrim.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
