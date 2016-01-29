unit k2OperationContainerRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2OperationContainerRefList.pas"
// Начат: 21.03.2008 18:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::Operations::Tk2OperationContainerRefList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3SimpleDataContainer,
  k2OperationContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
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
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tk2OperationContainerRefList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47E3D0820267_var*
//#UC END# *47B2C42A0163_47E3D0820267_var*
begin
//#UC START# *47B2C42A0163_47E3D0820267_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47E3D0820267_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
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