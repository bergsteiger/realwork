unit pgParamList;

// Модуль: "w:\common\components\rtl\Garant\PG\pgParamList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgParamList" MUID: (560B866002FB)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daParamList
;

type
 TpgParamList = class(TdaParamList)
  protected
   function DoGetParamName(anIndex: Integer): AnsiString; override;
 end;//TpgParamList
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
;

function TpgParamList.DoGetParamName(anIndex: Integer): AnsiString;
//#UC START# *5608FE9002D6_560B866002FB_var*
//#UC END# *5608FE9002D6_560B866002FB_var*
begin
//#UC START# *5608FE9002D6_560B866002FB_impl*
 Result := '$' + IntToStr(anIndex + 1);
//#UC END# *5608FE9002D6_560B866002FB_impl*
end;//TpgParamList.DoGetParamName
{$IfEnd} // Defined(UsePostgres)

end.
