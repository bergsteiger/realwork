unit daSelectFieldListPrim;

// Модуль: "w:\common\components\rtl\Garant\DA\daSelectFieldListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaSelectField;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TdaSelectFieldListPrim = class(_l3InterfaceRefListPrim_)
 end;//TdaSelectFieldListPrim

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
//#UC START# *47B07CF403D0_5551E0B301DC_var*
//#UC END# *47B07CF403D0_5551E0B301DC_var*
begin
//#UC START# *47B07CF403D0_5551E0B301DC_impl*
 Assert(False);
//#UC END# *47B07CF403D0_5551E0B301DC_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5551E0B301DC_var*
//#UC END# *47B2C42A0163_5551E0B301DC_var*
begin
//#UC START# *47B2C42A0163_5551E0B301DC_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5551E0B301DC_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5551E0B301DC_var*
//#UC END# *47B99D4503A2_5551E0B301DC_var*
begin
//#UC START# *47B99D4503A2_5551E0B301DC_impl*
 Result := (Integer(CI.rA) - Integer(CI.rB));
//#UC END# *47B99D4503A2_5551E0B301DC_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaSelectFieldListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.
