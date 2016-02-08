unit afwSettingsImplPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas"
// Стереотип: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettingsImplPrimPrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Il3CString;
 _l3Searcher_Parent_ = TafwSettingsImplPrimPrim;
 {$Include l3Searcher.imp.pas}
 TafwSettingsImplPrim = {abstract} class(_l3Searcher_)
 end;//TafwSettingsImplPrim

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
//#UC START# *47B9BAFD01F4_4F6C7D5F00E6_var*
//#UC END# *47B9BAFD01F4_4F6C7D5F00E6_var*
begin
//#UC START# *47B9BAFD01F4_4F6C7D5F00E6_impl*
 Result := l3Compare(l3PCharLen(anItem.rKey), l3PCharLen(aData));
//#UC END# *47B9BAFD01F4_4F6C7D5F00E6_impl*
end;//CompareItemWithData

type _Instance_R_ = TafwSettingsImplPrim;

{$Include l3Searcher.imp.pas}

end.
