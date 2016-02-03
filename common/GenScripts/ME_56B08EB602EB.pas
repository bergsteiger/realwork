unit arBelaCountryList;

// Модуль: "w:\common\components\rtl\Garant\ar\arBelaCountryList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3Date
;

type
 TarBelaCountryRec = record
  rName: Il3CString;
  rSigned: TStDate;
  rRatify: TStDate;
 end;//TarBelaCountryRec

 _ItemType_ = TarBelaCountryRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TarBelaCountryList = class(_l3RecordListPrim_)
 end;//TarBelaCountryList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
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
//#UC START# *47B07CF403D0_56B08EB602EB_var*
//#UC END# *47B07CF403D0_56B08EB602EB_var*
begin
//#UC START# *47B07CF403D0_56B08EB602EB_impl*
 Result := l3Same(A.rName, B.rName) and (A.rSigned = B.rSigned) and (A.rRatify = B.rRatify);
//#UC END# *47B07CF403D0_56B08EB602EB_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_56B08EB602EB_var*
//#UC END# *47B2C42A0163_56B08EB602EB_var*
begin
//#UC START# *47B2C42A0163_56B08EB602EB_impl*
 Assert(False);
//#UC END# *47B2C42A0163_56B08EB602EB_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_56B08EB602EB_var*
//#UC END# *47B99D4503A2_56B08EB602EB_var*
begin
//#UC START# *47B99D4503A2_56B08EB602EB_impl*
 Result := l3Compare(CI.rA.rName.AsWStr, CI.rB.rName.AsWStr);
 if Result = 0 then
  Result := CI.rA.rSigned - CI.rB.rSigned;
 if Result = 0 then
  Result := CI.rA.rRatify - CI.rB.rRatify;
//#UC END# *47B99D4503A2_56B08EB602EB_impl*
end;//CompareExistingItems

type _Instance_R_ = TarBelaCountryList;

{$Include l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
