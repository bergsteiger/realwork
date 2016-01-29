unit ddHyperlinkTargetList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddHyperlinkTargetList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddHyperlinkTargetList
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
  ddHyperlinkTarget,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TddHyperlinkTarget;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddHyperlinkTargetList = class(_l3UncomparabeObjectRefList_)
 end;//TddHyperlinkTargetList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TddHyperlinkTargetList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_525D27430046_var*
//#UC END# *47B2C42A0163_525D27430046_var*
begin
//#UC START# *47B2C42A0163_525D27430046_impl*
 Assert(false);
//#UC END# *47B2C42A0163_525D27430046_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_525D27430046_var*
//#UC END# *47B99D4503A2_525D27430046_var*
begin
//#UC START# *47B99D4503A2_525D27430046_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
 Assert(false);
//#UC END# *47B99D4503A2_525D27430046_impl*
end;//CompareExistingItems

type _Instance_R_ = TddHyperlinkTargetList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.