unit l3BaseWithIDListPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3BaseWithIDListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3BaseWithIDListPrim" MUID: (47BD864F00D2)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3BaseWithID
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3BaseWithID;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3BaseWithIDListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tl3BaseWithIDListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47BD864F00D2impl_uses*
 //#UC END# *47BD864F00D2impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47BD864F00D2_var*
//#UC END# *47B2C42A0163_47BD864F00D2_var*
begin
//#UC START# *47B2C42A0163_47BD864F00D2_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47BD864F00D2_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47BD864F00D2_var*
//#UC END# *47B99D4503A2_47BD864F00D2_var*
begin
//#UC START# *47B99D4503A2_47BD864F00D2_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.ID - CI.rB.ID;
//#UC END# *47B99D4503A2_47BD864F00D2_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3BaseWithIDListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
