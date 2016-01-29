unit daFieldList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daFieldList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaFieldList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daFieldListPrim,
  l3Types
  ;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaFieldListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdaFieldList = class(_l3Searcher_)
 end;//TdaFieldList

implementation

uses
  SysUtils
  ;

// start class TdaFieldList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_5637497102C9_var*
//#UC END# *47B9BAFD01F4_5637497102C9_var*
begin
//#UC START# *47B9BAFD01F4_5637497102C9_impl*
 Result := AnsiCompareText(anItem.Alias, aData);
//#UC END# *47B9BAFD01F4_5637497102C9_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaFieldList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.