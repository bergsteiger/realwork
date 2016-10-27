unit PrimDiction_utDiction_UserType;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_utDiction_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utDiction" MUID: (4BD71EBC00ED)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utDictionLocalConstants }
 str_utDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionCaption'; rValue : 'Толковый словарь');
  {* Заголовок пользовательского типа "Толковый словарь" }
 str_utDictionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionSettingsCaption'; rValue : 'Толковый словарь: Список терминов (вкладка)');
  {* Заголовок пользовательского типа "Толковый словарь" для настройки панелей инструментов }
 {* Константы для типа формы utDiction }
 utDictionName = 'utDiction';
  {* Строковый идентификатор пользовательского типа "Толковый словарь" }
 utDiction = TvcmUserType(0);
  {* Толковый словарь }
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
 Tkw_FormUserType_utDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utDiction.GetInteger: Integer;
begin
 Result := utDiction;
end;//Tkw_FormUserType_utDiction.GetInteger

class function Tkw_FormUserType_utDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utDiction';
end;//Tkw_FormUserType_utDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utDictionCaption.Init;
 {* Инициализация str_utDictionCaption }
 str_utDictionSettingsCaption.Init;
 {* Инициализация str_utDictionSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
