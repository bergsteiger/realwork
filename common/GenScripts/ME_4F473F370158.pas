unit tfwCStringList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringListPrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = TtfwCStringListPrim;
 {$Include l3Searcher.imp.pas}
 TtfwCStringList = class(_l3Searcher_)
 end;//TtfwCStringList

implementation

uses
 l3ImplUses
 , l3String
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4F473F370158_var*
//#UC END# *47B9BAFD01F4_4F473F370158_var*
begin
//#UC START# *47B9BAFD01F4_4F473F370158_impl*
 Result := l3Compare(l3PCharLen(anItem), aData, aSortIndex);
//#UC END# *47B9BAFD01F4_4F473F370158_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwCStringList;

{$Include l3Searcher.imp.pas}

end.
