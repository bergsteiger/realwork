unit k2OperationContainerRefList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2OperationContainerRefList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , k2OperationContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2OperationContainer;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tk2OperationContainerRefList = class(_l3UncomparabeObjectRefList_)
 end;//Tk2OperationContainerRefList

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
//#UC START# *47B2C42A0163_47E3D0820267_var*
//#UC END# *47B2C42A0163_47E3D0820267_var*
begin
//#UC START# *47B2C42A0163_47E3D0820267_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47E3D0820267_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47E3D0820267_var*
//#UC END# *47B99D4503A2_47E3D0820267_var*
begin
//#UC START# *47B99D4503A2_47E3D0820267_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_47E3D0820267_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2OperationContainerRefList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
