unit msmWordByNameList;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordByNameList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordByNameList" MUID: (57B2D8A80322)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmWordByNameListPrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Il3CString;
 _l3Searcher_Parent_ = TmsmWordByNameListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TmsmWordByNameList = class(_l3Searcher_)
 end;//TmsmWordByNameList

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B2D8A80322impl_uses*
 , l3String
 //#UC END# *57B2D8A80322impl_uses*
;

{$If not Declared(_ItemType_)}type _ItemType_ = TtfwWord;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_57B2D8A80322_var*
//#UC END# *47B9BAFD01F4_57B2D8A80322_var*
begin
//#UC START# *47B9BAFD01F4_57B2D8A80322_impl*
 Result := l3Compare(anItem.Key.AsWStr, l3PCharLen(aData));
//#UC END# *47B9BAFD01F4_57B2D8A80322_impl*
end;//CompareItemWithData

type _Instance_R_ = TmsmWordByNameList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
