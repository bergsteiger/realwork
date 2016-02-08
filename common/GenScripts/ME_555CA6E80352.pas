unit daFromTableList;

// Модуль: "w:\common\components\rtl\Garant\DA\daFromTableList.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , daFromTableListPrim
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaFromTableListPrim;
 {$Include l3Searcher.imp.pas}
 TdaFromTableList = class(_l3Searcher_)
 end;//TdaFromTableList

implementation

uses
 l3ImplUses
 , SysUtils
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_555CA6E80352_var*
//#UC END# *47B9BAFD01F4_555CA6E80352_var*
begin
//#UC START# *47B9BAFD01F4_555CA6E80352_impl*
 Result := AnsiCompareText(anItem.TableAlias, aData);
//#UC END# *47B9BAFD01F4_555CA6E80352_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaFromTableList;

{$Include l3Searcher.imp.pas}

end.
