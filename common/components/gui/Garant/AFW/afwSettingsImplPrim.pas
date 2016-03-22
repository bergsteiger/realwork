unit afwSettingsImplPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\afwSettingsImplPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TafwSettingsImplPrim" MUID: (4F6C7D5F00E6)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

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
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TafwSettingsImplPrim = {abstract} class(_l3Searcher_)
 end;//TafwSettingsImplPrim

implementation

uses
 l3ImplUses
 , l3String
 , l3Memory
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

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
