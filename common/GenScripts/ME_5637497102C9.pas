unit daFieldList;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldList.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , daFieldListPrim
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaFieldListPrim;
 {$Include l3Searcher.imp.pas}
 TdaFieldList = class(_l3Searcher_)
 end;//TdaFieldList

implementation

uses
 l3ImplUses
 , SysUtils
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer; override;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_5637497102C9_var*
//#UC END# *47B9BAFD01F4_5637497102C9_var*
begin
//#UC START# *47B9BAFD01F4_5637497102C9_impl*
 Result := AnsiCompareText(anItem.Alias, aData);
//#UC END# *47B9BAFD01F4_5637497102C9_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaFieldList;

{$Include l3Searcher.imp.pas}

end.
