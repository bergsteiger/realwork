unit m3EndingReplaceListPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3EndingReplaceListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 Tm3EndingReplaceItem = object
  public
   rEndingFind: AnsiString;
   rEndingReplace: AnsiString;
   rExcessChars: Byte;
 end;//Tm3EndingReplaceItem

 _ItemType_ = Tm3EndingReplaceItem;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 Tm3EndingReplaceListPrim = class(_l3RecordListPrim_)
  public
   class function CompareStrings(const aStr1: Tl3WString;
    const aStr2: Tl3WString): Integer;
 end;//Tm3EndingReplaceListPrim

function Tm3EndingReplaceItem_C(const anEndingFind: AnsiString;
 const anEndingReplace: AnsiString;
 anExcessChars: Byte): Tm3EndingReplaceItem;

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function Tm3EndingReplaceItem_C(const anEndingFind: AnsiString;
 const anEndingReplace: AnsiString;
 anExcessChars: Byte): Tm3EndingReplaceItem;
//#UC START# *4F4CB697008D_4F4CB52A039F_var*
//#UC END# *4F4CB697008D_4F4CB52A039F_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F4CB697008D_4F4CB52A039F_impl*
 Result.rEndingFind := anEndingFind;
 Result.rEndingReplace := anEndingReplace;
 Result.rExcessChars := anExcessChars;
//#UC END# *4F4CB697008D_4F4CB52A039F_impl*
end;//Tm3EndingReplaceItem_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4F4CB5140310_var*
//#UC END# *47B07CF403D0_4F4CB5140310_var*
begin
//#UC START# *47B07CF403D0_4F4CB5140310_impl*
 assert(false,'Tm3EndingReplaceListPrim .IsSame');
 //Result := Tm3EndingReplaceListPrim.CompareStrings(l3PCharLen(A.rEndingFind), l3PCharLen(B.rEndingFind)) = 0;
//#UC END# *47B07CF403D0_4F4CB5140310_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F4CB5140310_var*
//#UC END# *47B2C42A0163_4F4CB5140310_var*
begin
//#UC START# *47B2C42A0163_4F4CB5140310_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F4CB5140310_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F4CB5140310_var*
//#UC END# *47B99D4503A2_4F4CB5140310_var*
begin
//#UC START# *47B99D4503A2_4F4CB5140310_impl*
 Result := Tm3EndingReplaceListPrim.CompareStrings(l3PCharLen(CI.rA.rEndingFind), l3PCharLen(CI.rB.rEndingFind));
 if Result = 0 then
  Result := Length(CI.rB.rEndingFind) - Length(CI.rA.rEndingFind);
//#UC END# *47B99D4503A2_4F4CB5140310_impl*
end;//CompareExistingItems

type _Instance_R_ = Tm3EndingReplaceListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

class function Tm3EndingReplaceListPrim.CompareStrings(const aStr1: Tl3WString;
 const aStr2: Tl3WString): Integer;
//#UC START# *4F4CB73B0187_4F4CB5140310_var*
var
 I : Integer;
//#UC END# *4F4CB73B0187_4F4CB5140310_var*
begin
//#UC START# *4F4CB73B0187_4F4CB5140310_impl*
 Result := 0;
 for I := 1 to Min(aStr1.SLen, aStr2.SLen) do
 begin
  Result := Long(aStr1.S[aStr1.SLen - I]) - Long(aStr2.S[aStr2.SLen - I]);
  if (Result <> 0) then
   break;
 end;
//#UC END# *4F4CB73B0187_4F4CB5140310_impl*
end;//Tm3EndingReplaceListPrim.CompareStrings

end.
