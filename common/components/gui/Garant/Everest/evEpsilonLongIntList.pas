unit evEpsilonLongIntList;

// Модуль: "w:\common\components\gui\Garant\Everest\evEpsilonLongIntList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEpsilonLongIntList" MUID: (49C217110141)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 _ItemType_ = Integer;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 TevEpsilonLongIntList = class(_l3AtomicListPrim_)
 end;//TevEpsilonLongIntList

implementation

uses
 l3ImplUses
 , evConst
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *49C217110141impl_uses*
 //#UC END# *49C217110141impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_49C217110141_var*
//#UC END# *47B99D4503A2_49C217110141_var*
begin
//#UC START# *47B99D4503A2_49C217110141_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if Abs(CI.rA^ - CI.rB^) <= evFindCellDelta then
  Result := 0
 else
  Result := CI.rA^ - CI.rB^;
//#UC END# *47B99D4503A2_49C217110141_impl*
end;//CompareExistingItems

type _Instance_R_ = TevEpsilonLongIntList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

end.
