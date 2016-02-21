unit m3StorageHolderListPrim1;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim1.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3StorageHolderListPrim
 , l3Types
;

type
 _FindDataType_ = WideString;
 _l3Searcher_Parent_ = Tm3StorageHolderListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tm3StorageHolderListPrim1 = class(_l3Searcher_)
 end;//Tm3StorageHolderListPrim1

implementation

uses
 l3ImplUses
 , l3String
 , m3StorageHolder
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tm3StorageHolder;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_542E8D2902F1_var*
//#UC END# *47B9BAFD01F4_542E8D2902F1_var*
begin
//#UC START# *47B9BAFD01F4_542E8D2902F1_impl*
 Result := l3Compare(l3PCharLen(anItem.FileName), l3PCharLen(aData), l3_siCaseUnsensitive);
//#UC END# *47B9BAFD01F4_542E8D2902F1_impl*
end;//CompareItemWithData

type _Instance_R_ = Tm3StorageHolderListPrim1;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
