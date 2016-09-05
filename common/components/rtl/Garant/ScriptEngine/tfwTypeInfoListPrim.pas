unit tfwTypeInfoListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeInfoListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTypeInfoListPrim" MUID: (55BF2A400180)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwTypeInfo
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_Uncomparable}

type
 _ItemType_ = TtfwTypeInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TtfwTypeInfoListPrim = {abstract} class(_l3RecordListPrim_)
 end;//TtfwTypeInfoListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55BF2A400180impl_uses*
 //#UC END# *55BF2A400180impl_uses*
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
//#UC START# *47B07CF403D0_55BF2A400180_var*
//#UC END# *47B07CF403D0_55BF2A400180_var*
begin
//#UC START# *47B07CF403D0_55BF2A400180_impl*
 Result := A.Compare(B) = 0;
//#UC END# *47B07CF403D0_55BF2A400180_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55BF2A400180_var*
//#UC END# *47B2C42A0163_55BF2A400180_var*
begin
//#UC START# *47B2C42A0163_55BF2A400180_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_55BF2A400180_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55BF2A400180_var*
//#UC END# *47B99D4503A2_55BF2A400180_var*
begin
//#UC START# *47B99D4503A2_55BF2A400180_impl*
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_55BF2A400180_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwTypeInfoListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
