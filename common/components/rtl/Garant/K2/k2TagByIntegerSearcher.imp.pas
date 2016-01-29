{$IfNDef k2TagByIntegerSearcher_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TagByIntegerSearcher.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2CoreObjects::k2TagByIntegerSearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2TagByIntegerSearcher_imp}
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = _k2TagByIntegerSearcher_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 _k2TagByIntegerSearcher_ = {abstract mixin} class(_l3Searcher_)
 end;//_k2TagByIntegerSearcher_

{$Else k2TagByIntegerSearcher_imp}

// start class _k2TagByIntegerSearcher_

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4B89152D0120_var*
//#UC END# *47B9BAFD01F4_4B89152D0120_var*
begin
//#UC START# *47B9BAFD01F4_4B89152D0120_impl*
 Result := anItem.CompareWithInt(aData, aSortIndex);
//#UC END# *47B9BAFD01F4_4B89152D0120_impl*
end;//CompareItemWithData


{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}


{$EndIf k2TagByIntegerSearcher_imp}
