unit l3ValueMapManagerPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ValueMapManagerPrim.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_HasCustomSort}

type
 _ItemType_ = Il3ValueMap;
 _l3InterfaceRefListPrim_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 Tl3ValueMapManagerPrim = class(_l3InterfaceRefListPrim_)
 end;//Tl3ValueMapManagerPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_47B9E6DF01DC_var*
//#UC END# *47B07CF403D0_47B9E6DF01DC_var*
begin
//#UC START# *47B07CF403D0_47B9E6DF01DC_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B9E6DF01DC_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B9E6DF01DC_var*
//#UC END# *47B2C42A0163_47B9E6DF01DC_var*
begin
//#UC START# *47B2C42A0163_47B9E6DF01DC_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B9E6DF01DC_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B9E6DF01DC_var*
//#UC END# *47B99D4503A2_47B9E6DF01DC_var*
begin
//#UC START# *47B99D4503A2_47B9E6DF01DC_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^); 
//#UC END# *47B99D4503A2_47B9E6DF01DC_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ValueMapManagerPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.
