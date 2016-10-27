unit ContentsUserTypes_utContents_UserType;
 {* Структура документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utContents_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utContents" MUID: (4BD71CAC000C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utContentsLocalConstants }
 str_utContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsCaption'; rValue : 'Структура документа');
  {* Заголовок пользовательского типа "Структура документа" }
 str_utContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsSettingsCaption'; rValue : 'Документ: Структура (вкладка)');
  {* Заголовок пользовательского типа "Структура документа" для настройки панелей инструментов }
 {* Константы для типа формы utContents }
 utContentsName = 'utContents';
  {* Строковый идентификатор пользовательского типа "Структура документа" }
 utContents = TvcmUserType(0);
  {* Структура документа }
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
 Tkw_FormUserType_utContents = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utContents }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utContents
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utContents.GetInteger: Integer;
begin
 Result := utContents;
end;//Tkw_FormUserType_utContents.GetInteger

class function Tkw_FormUserType_utContents.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utContents';
end;//Tkw_FormUserType_utContents.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utContentsCaption.Init;
 {* Инициализация str_utContentsCaption }
 str_utContentsSettingsCaption.Init;
 {* Инициализация str_utContentsSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utContents.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
