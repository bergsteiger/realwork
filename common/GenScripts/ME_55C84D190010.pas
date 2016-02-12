unit daSelectFieldList;

// Модуль: "w:\common\components\rtl\Garant\DA\daSelectFieldList.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , daSelectFieldListPrim
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaSelectFieldListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdaSelectFieldList = class(_l3Searcher_)
 end;//TdaSelectFieldList

implementation

uses
 l3ImplUses
 , SysUtils
 , daInterfaces
;

{$If not Declared(_ItemType_)}type _ItemType_ = IdaSelectField;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
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
