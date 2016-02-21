unit daFieldDescriptionList;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldDescriptionList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daFieldDescriptionListPrim
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaFieldDescriptionListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TdaFieldDescriptionList = class(_l3Searcher_)
 end;//TdaFieldDescriptionList

implementation

uses
 l3ImplUses
 , SysUtils
 , daInterfaces
;

{$If not Declared(_ItemType_)}type _ItemType_ = IdaFieldDescription;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_5538E9E500EE_var*
//#UC END# *47B9BAFD01F4_5538E9E500EE_var*
begin
//#UC START# *47B9BAFD01F4_5538E9E500EE_impl*
 Result := AnsiCompareText(anItem.Name, aData);
//#UC END# *47B9BAFD01F4_5538E9E500EE_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaFieldDescriptionList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
