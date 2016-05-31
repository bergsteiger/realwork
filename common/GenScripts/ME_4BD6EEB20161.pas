unit DocumentWithFlashUserTypes_dwftSynchro_UserType;
 {* Схема (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftSynchro_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dwftSynchro" MUID: (4BD6EEB20161)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentWithFlashUserTypes_dwftMain_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dwftSynchroLocalConstants }
 str_dwftSynchroCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroCaption'; rValue : 'Схема (синхронный просмотр)');
  {* Заголовок пользовательского типа "Схема (синхронный просмотр)" }
 str_dwftSynchroSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroSettingsCaption'; rValue : 'Синхронный просмотр: Схема');
  {* Заголовок пользовательского типа "Схема (синхронный просмотр)" для настройки панелей инструментов }
 {* Константы для типа формы dwftSynchro }
 dwftSynchroName = 'dwftSynchro';
  {* Строковый идентификатор пользовательского типа "Схема (синхронный просмотр)" }
 dwftSynchro = TvcmUserType(dwftMain + 1);
  {* Схема (синхронный просмотр) }
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
 Tkw_FormUserType_dwftSynchro = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dwftSynchro }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dwftSynchro
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dwftSynchro.GetInteger: Integer;
begin
 Result := dwftSynchro;
end;//Tkw_FormUserType_dwftSynchro.GetInteger

class function Tkw_FormUserType_dwftSynchro.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dwftSynchro';
end;//Tkw_FormUserType_dwftSynchro.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dwftSynchroCaption.Init;
 {* Инициализация str_dwftSynchroCaption }
 str_dwftSynchroSettingsCaption.Init;
 {* Инициализация str_dwftSynchroSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftSynchro.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dwftSynchro }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
