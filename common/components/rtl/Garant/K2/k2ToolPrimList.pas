unit k2ToolPrimList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2ToolPrimList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2ToolPrimList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ToolPrim,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tk2ToolPrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tk2ToolPrimList = class(_l3UncomparabeObjectRefList_)
 end;//Tk2ToolPrimList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tk2ToolPrimList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53231C5401CE_var*
//#UC END# *47B2C42A0163_53231C5401CE_var*
begin
//#UC START# *47B2C42A0163_53231C5401CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53231C5401CE_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_53231C5401CE_var*
//#UC END# *47B99D4503A2_53231C5401CE_var*
begin
//#UC START# *47B99D4503A2_53231C5401CE_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53231C5401CE_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2ToolPrimList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.