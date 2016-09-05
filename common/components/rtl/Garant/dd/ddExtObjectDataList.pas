unit ddExtObjectDataList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjectDataList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExtObjectDataList" MUID: (5798E3C30126)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddExtObjectData
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddExtObjectData;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddExtObjectDataList = class(_l3UncomparabeObjectRefList_)
 end;//TddExtObjectDataList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5798E3C30126impl_uses*
 //#UC END# *5798E3C30126impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5798E3C30126_var*
//#UC END# *47B2C42A0163_5798E3C30126_var*
begin
//#UC START# *47B2C42A0163_5798E3C30126_impl*
 Assert(false);
//#UC END# *47B2C42A0163_5798E3C30126_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5798E3C30126_var*
//#UC END# *47B99D4503A2_5798E3C30126_var*
begin
//#UC START# *47B99D4503A2_5798E3C30126_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5798E3C30126_impl*
end;//CompareExistingItems

type _Instance_R_ = TddExtObjectDataList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
