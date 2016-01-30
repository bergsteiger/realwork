unit k2AtomicTagRefListPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\k2AtomicTagRefListPrim.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2AtomicTag
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2AtomicTag;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 Tk2AtomicTagRefListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tk2AtomicTagRefListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_526918890147_var*
//#UC END# *47B2C42A0163_526918890147_var*
begin
//#UC START# *47B2C42A0163_526918890147_impl*
 Assert(false);
//#UC END# *47B2C42A0163_526918890147_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_526918890147_var*
var
 l_A, l_B : Integer;
//#UC END# *47B99D4503A2_526918890147_var*
begin
//#UC START# *47B99D4503A2_526918890147_impl*
 l_A := CI.rA.AsLong;
 l_B := CI.rB.AsLong;
 if (l_A < l_B) then
  Result := -1
 else
 if (l_A > l_B) then
  Result := +1
 else
  Result := 0;
//#UC END# *47B99D4503A2_526918890147_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2AtomicTagRefListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}

end.
