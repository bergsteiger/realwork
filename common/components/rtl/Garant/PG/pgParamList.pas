unit pgParamList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgParamList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgParamList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  daParamList
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgParamList = class(TdaParamList)
 protected
 // overridden protected methods
   function DoGetParamName(anIndex: Integer): AnsiString; override;
 end;//TpgParamList
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  SysUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgParamList

function TpgParamList.DoGetParamName(anIndex: Integer): AnsiString;
//#UC START# *5608FE9002D6_560B866002FB_var*
//#UC END# *5608FE9002D6_560B866002FB_var*
begin
//#UC START# *5608FE9002D6_560B866002FB_impl*
 Result := '$' + IntToStr(anIndex + 1);
//#UC END# *5608FE9002D6_560B866002FB_impl*
end;//TpgParamList.DoGetParamName

{$IfEnd} //UsePostgres

end.