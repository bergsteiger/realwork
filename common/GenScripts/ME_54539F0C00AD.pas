unit ncsMessageClassList;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessageClassList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessage
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TncsMessageClass;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TncsMessageClassList = class(_l3PtrList_)
 end;//TncsMessageClassList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
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
//#UC START# *47B07CF403D0_54539F0C00AD_var*
//#UC END# *47B07CF403D0_54539F0C00AD_var*
begin
//#UC START# *47B07CF403D0_54539F0C00AD_impl*
 Result := AnsiSameText(A.GetTaggedDataType.AsString, B.GetTaggedDataType.AsString);
//#UC END# *47B07CF403D0_54539F0C00AD_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_54539F0C00AD_var*
//#UC END# *47B2C42A0163_54539F0C00AD_var*
begin
//#UC START# *47B2C42A0163_54539F0C00AD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_54539F0C00AD_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_54539F0C00AD_var*
//#UC END# *47B99D4503A2_54539F0C00AD_var*
begin
//#UC START# *47B99D4503A2_54539F0C00AD_impl*
 Result := AnsiCompareText(CI.rA.GetTaggedDataType.AsString, CI.rB.GetTaggedDataType.AsString);
//#UC END# *47B99D4503A2_54539F0C00AD_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsMessageClassList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
