unit ListUserTypes_lftRespondent_UserType;
 {* Ссылки из документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondent_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftRespondent" MUID: (4BD587B60291)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftNone_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки lftRespondentLocalConstants }
 str_lftRespondentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentCaption'; rValue : 'Ссылки из документа');
  {* Заголовок пользовательского типа "Ссылки из документа" }
 str_lftRespondentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentSettingsCaption'; rValue : 'Список: Ссылки из документа (все)/Ссылки на документ (все)');
  {* Заголовок пользовательского типа "Ссылки из документа" для настройки панелей инструментов }
 {* Константы для типа формы lftRespondent }
 lftRespondentName = 'lftRespondent';
  {* Строковый идентификатор пользовательского типа "Ссылки из документа" }
 lftRespondent = TvcmUserType(lftNone + 1);
  {* Ссылки из документа }
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
 Tkw_FormUserType_lftRespondent = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftRespondent }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRespondent
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRespondent.GetInteger: Integer;
begin
 Result := lftRespondent;
end;//Tkw_FormUserType_lftRespondent.GetInteger

class function Tkw_FormUserType_lftRespondent.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftRespondent';
end;//Tkw_FormUserType_lftRespondent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftRespondentCaption.Init;
 {* Инициализация str_lftRespondentCaption }
 str_lftRespondentSettingsCaption.Init;
 {* Инициализация str_lftRespondentSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondent.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftRespondent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
