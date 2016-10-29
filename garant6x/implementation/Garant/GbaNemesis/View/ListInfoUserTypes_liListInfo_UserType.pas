unit ListInfoUserTypes_liListInfo_UserType;
 {* Справка к списку }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes_liListInfo_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "liListInfo" MUID: (4BD6B6890245)

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
 {* Локализуемые строки liListInfoLocalConstants }
 str_liListInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : 'Справка к списку');
  {* Заголовок пользовательского типа "Справка к списку" }
 str_liListInfoSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : 'Список: Справка к списку');
  {* Заголовок пользовательского типа "Справка к списку" для настройки панелей инструментов }
 {* Константы для типа формы liListInfo }
 liListInfoName = 'liListInfo';
  {* Строковый идентификатор пользовательского типа "Справка к списку" }
 liListInfo = TvcmUserType(0);
  {* Справка к списку }
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
 Tkw_FormUserType_liListInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы liListInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_liListInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_liListInfo.GetInteger: Integer;
begin
 Result := liListInfo;
end;//Tkw_FormUserType_liListInfo.GetInteger

class function Tkw_FormUserType_liListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::liListInfo';
end;//Tkw_FormUserType_liListInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_liListInfoCaption.Init;
 {* Инициализация str_liListInfoCaption }
 str_liListInfoSettingsCaption.Init;
 {* Инициализация str_liListInfoSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_liListInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_liListInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
