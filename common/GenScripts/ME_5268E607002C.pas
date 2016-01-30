unit ddSubsList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddSubsList.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddSub
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddSub;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TddSubsList = class(_l3UncomparabeObjectRefList_)
 end;//TddSubsList

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
//#UC START# *47B2C42A0163_5268E607002C_var*
//#UC END# *47B2C42A0163_5268E607002C_var*
begin
//#UC START# *47B2C42A0163_5268E607002C_impl*
 Assert(false);
//#UC END# *47B2C42A0163_5268E607002C_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5268E607002C_var*
//#UC END# *47B99D4503A2_5268E607002C_var*
begin
//#UC START# *47B99D4503A2_5268E607002C_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5268E607002C_impl*
end;//CompareExistingItems

type _Instance_R_ = TddSubsList;

{$Include l3UncomparabeObjectRefList.imp.pas}

end.
