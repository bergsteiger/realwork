unit tfwSourcePointList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwSourcePointList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwSourcePoint;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TtfwSourcePointList = class(_l3RecordListPrim_)
 end;//TtfwSourcePointList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
//#UC START# *47B07CF403D0_55648E420189_var*
//#UC END# *47B07CF403D0_55648E420189_var*
begin
//#UC START# *47B07CF403D0_55648E420189_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_55648E420189_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55648E420189_var*
//#UC END# *47B2C42A0163_55648E420189_var*
begin
//#UC START# *47B2C42A0163_55648E420189_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_55648E420189_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55648E420189_var*
//#UC END# *47B99D4503A2_55648E420189_var*
begin
//#UC START# *47B99D4503A2_55648E420189_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_55648E420189_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwSourcePointList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
