unit RedactionsUserTypes_utRedaction_UserType;
 {* Редакции }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes_utRedaction_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utRedaction" MUID: (4BD6BF000358)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utRedactionLocalConstants }
 str_utRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionCaption'; rValue : 'Редакции');
  {* Заголовок пользовательского типа "Редакции" }
 str_utRedactionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionSettingsCaption'; rValue : 'Документ: Редакции (вкладка)');
  {* Заголовок пользовательского типа "Редакции" для настройки панелей инструментов }
 {* Константы для типа формы utRedaction }
 utRedactionName = 'utRedaction';
  {* Строковый идентификатор пользовательского типа "Редакции" }
 utRedaction = TvcmUserType(0);
  {* Редакции }
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
 Tkw_FormUserType_utRedaction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utRedaction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utRedaction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRedaction.GetInteger: Integer;
begin
 Result := utRedaction;
end;//Tkw_FormUserType_utRedaction.GetInteger

class function Tkw_FormUserType_utRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utRedaction';
end;//Tkw_FormUserType_utRedaction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utRedactionCaption.Init;
 {* Инициализация str_utRedactionCaption }
 str_utRedactionSettingsCaption.Init;
 {* Инициализация str_utRedactionSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRedaction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utRedaction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
