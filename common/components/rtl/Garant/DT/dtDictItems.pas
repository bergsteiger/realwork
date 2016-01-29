unit dtDictItems;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/dtDictItems.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Dictionary::TdtDictItems
//
// Список элементов словаря.
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
  dt_Types,
  dtDictItemsPrim,
  l3Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _FindDataType_ = TDictID;
 _l3Searcher_Parent_ = TdtDictItemsPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdtDictItems = class(_l3Searcher_)
  {* Список элементов словаря. }
 end;//TdtDictItems
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}

// start class TdtDictItems

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_47BC55C00240_var*
//#UC END# *47B9BAFD01F4_47BC55C00240_var*
begin
//#UC START# *47B9BAFD01F4_47BC55C00240_impl*
 Assert(aSortIndex = l3_siNative);
 if (anItem.Handle < aData) then
  Result := -1
 else
 if (anItem.Handle > aData) then
  Result := +1
 else
  Result := 0;
//#UC END# *47B9BAFD01F4_47BC55C00240_impl*
end;//CompareItemWithData

type _Instance_R_ = TdtDictItems;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}


{$IfEnd} //not Nemesis
end.