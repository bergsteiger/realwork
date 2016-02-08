unit tfwValueTypesList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesList.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwValueTypesListPrim
 , tfwTypeInfo
 , l3Types
;

type
 _FindDataType_ = TtfwTypeInfo;
 _l3Searcher_Parent_ = TtfwValueTypesListPrim;
 {$Include l3Searcher.imp.pas}
 TtfwValueTypesList = class(_l3Searcher_)
 end;//TtfwValueTypesList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_55BF43BA0204_var*
//#UC END# *47B9BAFD01F4_55BF43BA0204_var*
begin
//#UC START# *47B9BAFD01F4_55BF43BA0204_impl*
 Result := anItem.Compare(aData);
//#UC END# *47B9BAFD01F4_55BF43BA0204_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwValueTypesList;

{$Include l3Searcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
