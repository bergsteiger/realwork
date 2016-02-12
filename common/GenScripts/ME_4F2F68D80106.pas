unit evOneCharLongIntList;

// Модуль: "w:\common\components\gui\Garant\Everest\evOneCharLongIntList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
 TevOneCharLongIntList = class(_l3AtomicListPrim_)
 end;//TevOneCharLongIntList

implementation

uses
 l3ImplUses
 , l3UnitsTools
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F2F68D80106_var*
//#UC END# *47B99D4503A2_4F2F68D80106_var*
begin
//#UC START# *47B99D4503A2_4F2F68D80106_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if Abs(CI.rA^ - CI.rB^) <= evCellWidthEpsilon then
  Result := 0
 else
  Result := CI.rA^ - CI.rB^;
//#UC END# *47B99D4503A2_4F2F68D80106_impl*
end;//CompareExistingItems

type _Instance_R_ = TevOneCharLongIntList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

end.
