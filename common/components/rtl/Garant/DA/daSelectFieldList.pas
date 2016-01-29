unit daSelectFieldList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daSelectFieldList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaSelectFieldList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daSelectFieldListPrim,
  l3Types
  ;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaSelectFieldListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdaSelectFieldList = class(_l3Searcher_)
 end;//TdaSelectFieldList

implementation

uses
  SysUtils
  ;

// start class TdaSelectFieldList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_55C84D190010_var*
//#UC END# *47B9BAFD01F4_55C84D190010_var*
begin
//#UC START# *47B9BAFD01F4_55C84D190010_impl*
 Result := AnsiCompareText(anItem.Alias, aData);
//#UC END# *47B9BAFD01F4_55C84D190010_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaSelectFieldList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.