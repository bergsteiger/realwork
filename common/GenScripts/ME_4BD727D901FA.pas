unit PrimConfigurationList_utConfigurationList_UserType;
 {* Конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas"
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
 {* Константы для типа формы utConfigurationList }
 utConfigurationListName = 'utConfigurationList';
  {* Строковый идентификатор пользовательского типа "Конфигурации" }
 utConfigurationList = TvcmUserType(0);
  {* Конфигурации }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utConfigurationList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utConfigurationList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utConfigurationList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utConfigurationList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utConfigurationList';
end;//Tkw_FormUserType_utConfigurationList.GetWordNameForRegister

function Tkw_FormUserType_utConfigurationList.GetInteger: Integer;
begin
 Result := utConfigurationList;
end;//Tkw_FormUserType_utConfigurationList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utConfigurationList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
