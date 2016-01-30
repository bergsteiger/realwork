unit daParamList;

// Модуль: "w:\common\components\rtl\Garant\DA\daParamList.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , daParamListPrim
 , daInterfaces
 , l3Types
;

type
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = TdaParamListPrim;
 {$Include l3Searcher.imp.pas}
 TdaParamList = class(_l3Searcher_, IdaParamListHelper)
  protected
   function DoGetParamName(anIndex: Integer): AnsiString; virtual;
   function GetParamCode(const aParamName: AnsiString): AnsiString;
 end;//TdaParamList

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
//#UC START# *47B9BAFD01F4_5555C169038C_var*
//#UC END# *47B9BAFD01F4_5555C169038C_var*
begin
//#UC START# *47B9BAFD01F4_5555C169038C_impl*
 Result := AnsiCompareText(anItem.Name, aData);
//#UC END# *47B9BAFD01F4_5555C169038C_impl*
end;//CompareItemWithData

type _Instance_R_ = TdaParamList;

{$Include l3Searcher.imp.pas}

function TdaParamList.DoGetParamName(anIndex: Integer): AnsiString;
//#UC START# *5608FE9002D6_5555C169038C_var*
//#UC END# *5608FE9002D6_5555C169038C_var*
begin
//#UC START# *5608FE9002D6_5555C169038C_impl*
 Result := ':' + Items[anIndex].Name;
//#UC END# *5608FE9002D6_5555C169038C_impl*
end;//TdaParamList.DoGetParamName

function TdaParamList.GetParamCode(const aParamName: AnsiString): AnsiString;
//#UC START# *5608FDF0029C_5555C169038C_var*
var
 l_IDX: Integer;
//#UC END# *5608FDF0029C_5555C169038C_var*
begin
//#UC START# *5608FDF0029C_5555C169038C_impl*
 if FindData(aParamName, l_IDX) then
  Result := DoGetParamName(l_IDX)
 else
  Result := '';
//#UC END# *5608FDF0029C_5555C169038C_impl*
end;//TdaParamList.GetParamCode

end.
