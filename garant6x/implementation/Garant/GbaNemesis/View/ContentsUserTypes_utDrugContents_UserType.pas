unit ContentsUserTypes_utDrugContents_UserType;
 {* Структура препарата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utDrugContents_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utDrugContents" MUID: (4BD71CDB00F5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ContentsUserTypes_utContents_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки utDrugContentsLocalConstants }
 str_utDrugContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsCaption'; rValue : 'Структура препарата');
  {* Заголовок пользовательского типа "Структура препарата" }
 str_utDrugContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsSettingsCaption'; rValue : 'Препарат: Структура (вкладка)');
  {* Заголовок пользовательского типа "Структура препарата" для настройки панелей инструментов }
 {* Константы для типа формы utDrugContents }
 utDrugContentsName = 'utDrugContents';
  {* Строковый идентификатор пользовательского типа "Структура препарата" }
 utDrugContents = TvcmUserType(utContents + 1);
  {* Структура препарата }
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
 Tkw_FormUserType_utDrugContents = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utDrugContents }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utDrugContents
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utDrugContents.GetInteger: Integer;
begin
 Result := utDrugContents;
end;//Tkw_FormUserType_utDrugContents.GetInteger

class function Tkw_FormUserType_utDrugContents.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utDrugContents';
end;//Tkw_FormUserType_utDrugContents.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utDrugContentsCaption.Init;
 {* Инициализация str_utDrugContentsCaption }
 str_utDrugContentsSettingsCaption.Init;
 {* Инициализация str_utDrugContentsSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDrugContents.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utDrugContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
