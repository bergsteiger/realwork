unit ddRowList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddRowList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddRowList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoDataContainer,
  ddTableRow,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TddTableRow;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddRowList = class(_l3UncomparabeObjectRefList_)
 end;//TddRowList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TddRowList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5189EF6C00F4_var*
//#UC END# *47B2C42A0163_5189EF6C00F4_var*
begin
//#UC START# *47B2C42A0163_5189EF6C00F4_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5189EF6C00F4_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5189EF6C00F4_var*
//#UC END# *47B99D4503A2_5189EF6C00F4_var*
begin
//#UC START# *47B99D4503A2_5189EF6C00F4_impl*
 Result := -1;
 Assert(False);
//#UC END# *47B99D4503A2_5189EF6C00F4_impl*
end;//CompareExistingItems

type _Instance_R_ = TddRowList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.