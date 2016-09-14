unit msmImageNames;

// Модуль: "w:\common\components\gui\Garant\msm\msmImageNames.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmImageNames" MUID: (57D968320359)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TmsmImageName = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rName: Il3CString;
   rIsValid: Boolean;
 end;//TmsmImageName

 _ItemType_ = TmsmImageName;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TmsmImageNames = class(_l3RecordListPrim_)
 end;//TmsmImageNames

function TmsmImageName_C(const aName: Il3CString;
 aIsValid: Boolean): TmsmImageName;

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57D968320359impl_uses*
 , l3String
 //#UC END# *57D968320359impl_uses*
;

function TmsmImageName_C(const aName: Il3CString;
 aIsValid: Boolean): TmsmImageName;
//#UC START# *57D968D90347_57D9686C0258_var*
//#UC END# *57D968D90347_57D9686C0258_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57D968D90347_57D9686C0258_impl*
 Result.rName := aName;
 Result.rIsValid := aIsValid;
//#UC END# *57D968D90347_57D9686C0258_impl*
end;//TmsmImageName_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57D968320359_var*
//#UC END# *47B07CF403D0_57D968320359_var*
begin
//#UC START# *47B07CF403D0_57D968320359_impl*
 Result := l3Same(A.rName, B.rName, true);
//#UC END# *47B07CF403D0_57D968320359_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57D968320359_var*
//#UC END# *47B2C42A0163_57D968320359_var*
begin
//#UC START# *47B2C42A0163_57D968320359_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57D968320359_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57D968320359_var*
//#UC END# *47B99D4503A2_57D968320359_var*
begin
//#UC START# *47B99D4503A2_57D968320359_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57D968320359_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmImageNames;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

end.
