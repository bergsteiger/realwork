unit evSelectedParts;
 {* Коллекция выделенных прямоугольников }

// Модуль: "w:\common\components\gui\Garant\Everest\evSelectedParts.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , nevBase
;

type
 TevSelectedPart = record
  rRowIndex: Integer;
  rWidth: Integer;
  rSelection: Boolean;
  rWindowOrg: TnevPoint;
 end;//TevSelectedPart

 _ItemType_ = TevSelectedPart;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TevSelectedParts = class(_l3RecordListPrim_)
  {* Коллекция выделенных прямоугольников }
 end;//TevSelectedParts
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
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
//#UC START# *47B07CF403D0_48C911C702A4_var*
//#UC END# *47B07CF403D0_48C911C702A4_var*
begin
//#UC START# *47B07CF403D0_48C911C702A4_impl*
 Result := CompareMem(@A, @B, SizeOf(A));
//#UC END# *47B07CF403D0_48C911C702A4_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_48C911C702A4_var*
//#UC END# *47B2C42A0163_48C911C702A4_var*
begin
//#UC START# *47B2C42A0163_48C911C702A4_impl*
 Assert(false);
//#UC END# *47B2C42A0163_48C911C702A4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_48C911C702A4_var*
//#UC END# *47B99D4503A2_48C911C702A4_var*
begin
//#UC START# *47B99D4503A2_48C911C702A4_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_48C911C702A4_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSelectedParts;

{$Include l3RecordListPrim.imp.pas}
{$IfEnd} // Defined(evNeedPainters)

end.
