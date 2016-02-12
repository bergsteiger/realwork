unit DocNumberQuery_ut_DocNumberQuery_UserType;
 {* Открыть документ по номеру }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_ut_DocNumberQuery_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы ut_DocNumberQuery }
 ut_DocNumberQueryName = 'ut_DocNumberQuery';
  {* Строковый идентификатор пользовательского типа "Открыть документ по номеру" }
 ut_DocNumberQuery = TvcmUserType(0);
  {* Открыть документ по номеру }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DocNumberQuery = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_DocNumberQuery }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_DocNumberQuery
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_DocNumberQuery';
end;//Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister

function Tkw_FormUserType_ut_DocNumberQuery.GetInteger: Integer;
begin
 Result := ut_DocNumberQuery;
end;//Tkw_FormUserType_ut_DocNumberQuery.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DocNumberQuery.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_DocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
