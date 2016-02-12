unit ddTableList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTableList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddTable
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddTable;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddTableList = class(_l3UncomparabeObjectRefList_)
 end;//TddTableList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_528C86F001F5_var*
//#UC END# *47B2C42A0163_528C86F001F5_var*
begin
//#UC START# *47B2C42A0163_528C86F001F5_impl*
 Assert(False);
//#UC END# *47B2C42A0163_528C86F001F5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_528C86F001F5_var*
//#UC END# *47B99D4503A2_528C86F001F5_var*
begin
//#UC START# *47B99D4503A2_528C86F001F5_impl*
 Assert(False);
 Result := -1;
//#UC END# *47B99D4503A2_528C86F001F5_impl*
end;//CompareExistingItems

type _Instance_R_ = TddTableList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
