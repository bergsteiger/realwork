unit k2FontNameList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2FontNameList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2FontNameListPrim
 , l3LogFont
 , l3Types
;

type
 _FindDataType_ = Tl3LogFont;
 _l3Searcher_Parent_ = Tk2FontNameListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2FontNameList = class(_l3Searcher_)
 end;//Tk2FontNameList

implementation

uses
 l3ImplUses
 , l3String
 , k2FontName
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tk2FontName;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_53189661025E_var*
//#UC END# *47B9BAFD01F4_53189661025E_var*
begin
//#UC START# *47B9BAFD01F4_53189661025E_impl*
 Result := l3Compare(anItem.AsWStr, aData.AsWStr, l3_siCaseUnsensitive);
// Result := Integer(anItem.LogFont) - Integer(aData);
//#UC END# *47B9BAFD01F4_53189661025E_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2FontNameList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
