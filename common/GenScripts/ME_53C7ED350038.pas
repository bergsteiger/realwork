unit tfwRTTITypeInfoList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwRTTITypeInfoList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , TypInfo
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = PTypeInfo;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TtfwRTTITypeInfoList = class(_l3PtrList_)
 end;//TtfwRTTITypeInfoList
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
//#UC START# *47B07CF403D0_53C7ED350038_var*
//#UC END# *47B07CF403D0_53C7ED350038_var*
begin
//#UC START# *47B07CF403D0_53C7ED350038_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_53C7ED350038_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53C7ED350038_var*
//#UC END# *47B2C42A0163_53C7ED350038_var*
begin
//#UC START# *47B2C42A0163_53C7ED350038_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53C7ED350038_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53C7ED350038_var*
//#UC END# *47B99D4503A2_53C7ED350038_var*
begin
//#UC START# *47B99D4503A2_53C7ED350038_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53C7ED350038_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwRTTITypeInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
