unit dtDictItemsPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/dtDictItemsPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Dictionary::TdtDictItemsPrim
//
// Базовый список элементов словаря.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3SimpleDataContainer,
  dtCustomDictItem,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _ItemType_ = TdtCustomDictItem;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TdtDictItemsPrim = class(_l3UncomparabeObjectRefList_)
  {* Базовый список элементов словаря. }
 end;//TdtDictItemsPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TdtDictItemsPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47BC53EE023A_var*
//#UC END# *47B2C42A0163_47BC53EE023A_var*
begin
//#UC START# *47B2C42A0163_47BC53EE023A_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47BC53EE023A_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_47BC53EE023A_var*
//#UC END# *47B99D4503A2_47BC53EE023A_var*
begin
//#UC START# *47B99D4503A2_47BC53EE023A_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if CI.rA.Handle > CI.rB.Handle then
   Result := 1
 else
   if CI.rA.Handle < CI.rB.Handle then
     Result := -1
   else
     Result := 0;
//#UC END# *47B99D4503A2_47BC53EE023A_impl*
end;//CompareExistingItems

type _Instance_R_ = TdtDictItemsPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //not Nemesis
end.