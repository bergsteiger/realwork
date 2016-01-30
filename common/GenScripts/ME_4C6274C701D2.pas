unit PrimInternetAgent_utInternetAgent_UserType;
 {* Новости онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\PrimInternetAgent_utInternetAgent_UserType.pas"
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
 {* Константы для типа формы utInternetAgent }
 utInternetAgentName = 'utInternetAgent';
  {* Строковый идентификатор пользовательского типа "Новости онлайн" }
 utInternetAgent = TvcmUserType(0);
  {* Новости онлайн }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utInternetAgent = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utInternetAgent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utInternetAgent
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utInternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utInternetAgent';
end;//Tkw_FormUserType_utInternetAgent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utInternetAgent.GetInteger: Integer;
begin
 Result := utInternetAgent;
end;//Tkw_FormUserType_utInternetAgent.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utInternetAgent.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utInternetAgent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
