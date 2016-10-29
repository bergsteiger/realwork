unit PrimConfigurationList_utConfigurationList_UserType;
 {* Конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utConfigurationList" MUID: (4BD727D901FA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки utConfigurationListLocalConstants }
 str_utConfigurationListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListCaption'; rValue : 'Конфигурации');
  {* Заголовок пользовательского типа "Конфигурации" }
 str_utConfigurationListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListSettingsCaption'; rValue : 'Конфигурации (вкладка)');
  {* Заголовок пользовательского типа "Конфигурации" для настройки панелей инструментов }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utConfigurationList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utConfigurationList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utConfigurationList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utConfigurationList.GetInteger: Integer;
begin
 Result := utConfigurationList;
end;//Tkw_FormUserType_utConfigurationList.GetInteger

class function Tkw_FormUserType_utConfigurationList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utConfigurationList';
end;//Tkw_FormUserType_utConfigurationList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utConfigurationListCaption.Init;
 {* Инициализация str_utConfigurationListCaption }
 str_utConfigurationListSettingsCaption.Init;
 {* Инициализация str_utConfigurationListSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utConfigurationList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
