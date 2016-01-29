unit DictEditQueryList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/DictEditQueryList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TDictEditQueryList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  csServerTaskTypes,
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
 _ItemType_ = TDictEditQuery;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TDictEditQueryList = class(_l3UncomparabeObjectRefList_)
 end;//TDictEditQueryList
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

// start class TDictEditQueryList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FA5956031F_var*
//#UC END# *47B2C42A0163_52FA5956031F_var*
begin
//#UC START# *47B2C42A0163_52FA5956031F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA5956031F_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_52FA5956031F_var*
//#UC END# *47B99D4503A2_52FA5956031F_var*
begin
//#UC START# *47B99D4503A2_52FA5956031F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_52FA5956031F_impl*
end;//CompareExistingItems

type _Instance_R_ = TDictEditQueryList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //not Nemesis
end.