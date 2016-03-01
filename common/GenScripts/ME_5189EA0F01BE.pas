unit ddCellList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddCellList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddTableCell
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddTableCell;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddCellList = class(_l3UncomparabeObjectRefList_)
 end;//TddCellList

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
//#UC START# *47B2C42A0163_5189EA0F01BE_var*
//#UC END# *47B2C42A0163_5189EA0F01BE_var*
begin
//#UC START# *47B2C42A0163_5189EA0F01BE_impl*
 Assert(false);
//#UC END# *47B2C42A0163_5189EA0F01BE_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5189EA0F01BE_var*
//#UC END# *47B99D4503A2_5189EA0F01BE_var*
begin
//#UC START# *47B99D4503A2_5189EA0F01BE_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5189EA0F01BE_impl*
end;//CompareExistingItems

type _Instance_R_ = TddCellList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
