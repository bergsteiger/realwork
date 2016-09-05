unit daFieldList;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaFieldList" MUID: (5637497102C9)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daFieldListPrim
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaFieldListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdaFieldList = class(_l3Searcher_)
 end;//TdaFieldList

implementation

uses
 l3ImplUses
 , SysUtils
 , daInterfaces
 //#UC START# *5637497102C9impl_uses*
 //#UC END# *5637497102C9impl_uses*
;

{$If not Declared(_ItemType_)}type _ItemType_ = IdaField;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
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
