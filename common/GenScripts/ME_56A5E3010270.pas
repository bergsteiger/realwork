unit arBelaDateNumList;

// Модуль: "w:\common\components\rtl\Garant\ar\arBelaDateNumList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\l3Define.inc}

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
 TarBelaDateNumRec = record
  rNum: Il3CString;
  rDate: TStDate;
 end;//TarBelaDateNumRec

 _ItemType_ = TarBelaDateNumRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TarBelaDateNumList = class(_l3RecordListPrim_)
 end;//TarBelaDateNumList
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
//#UC START# *47B07CF403D0_56A5E3010270_var*
//#UC END# *47B07CF403D0_56A5E3010270_var*
begin
//#UC START# *47B07CF403D0_56A5E3010270_impl*
 Result := (A.rDate = B.rDate) and l3Same(A.rNum, B.rNum);
//#UC END# *47B07CF403D0_56A5E3010270_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_56A5E3010270_var*
//#UC END# *47B2C42A0163_56A5E3010270_var*
begin
//#UC START# *47B2C42A0163_56A5E3010270_impl*
 Assert(False);
//#UC END# *47B2C42A0163_56A5E3010270_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_56A5E3010270_var*
//#UC END# *47B99D4503A2_56A5E3010270_var*
begin
//#UC START# *47B99D4503A2_56A5E3010270_impl*
 Result := CI.rA.rDate - CI.rB.rDate;
 if Result = 0 then
  Result := l3Compare(CI.rA.rNum.AsWStr, CI.rB.rNum.AsWStr);
//#UC END# *47B99D4503A2_56A5E3010270_impl*
end;//CompareExistingItems

type _Instance_R_ = TarBelaDateNumList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
