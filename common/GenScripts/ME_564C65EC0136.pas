unit ddAnnoKindStatisticListPrim;

// Модуль: "w:\common\components\rtl\Garant\dd\PipeOut\ddAnnoKindStatisticListPrim.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddPipeOutInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

const
 dd_siByName = 1;

 {$Define l3Items_HasCustomSort}

type
 _ItemType_ = IddAnnoKindSortItem;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefListPrim.imp.pas}
 TddAnnoKindStatisticListPrim = class(_l3InterfaceRefListPrim_)
 end;//TddAnnoKindStatisticListPrim

implementation

uses
 l3ImplUses
 , l3String
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
//#UC START# *47B07CF403D0_564C65EC0136_var*
//#UC END# *47B07CF403D0_564C65EC0136_var*
begin
//#UC START# *47B07CF403D0_564C65EC0136_impl*
 Result := (A.ID = B.ID);
//#UC END# *47B07CF403D0_564C65EC0136_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_564C65EC0136_var*
//#UC END# *47B2C42A0163_564C65EC0136_var*
begin
//#UC START# *47B2C42A0163_564C65EC0136_impl*
 Assert(False, 'TddAnnoKindStatisticListPrim.AssignItem');
//#UC END# *47B2C42A0163_564C65EC0136_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_564C65EC0136_var*
//#UC END# *47B99D4503A2_564C65EC0136_var*
begin
//#UC START# *47B99D4503A2_564C65EC0136_impl*
 if CI.rSortIndex = l3_siNative then
  Result := CI.rA.ID - CI.rB.ID
 else
  Result := l3Compare(CI.rA.Name.AsWStr, CI.rB.Name.AsWStr, l3_siCaseUnsensitive)
//#UC END# *47B99D4503A2_564C65EC0136_impl*
end;//CompareExistingItems

type _Instance_R_ = TddAnnoKindStatisticListPrim;

{$Include l3InterfaceRefListPrim.imp.pas}

end.
