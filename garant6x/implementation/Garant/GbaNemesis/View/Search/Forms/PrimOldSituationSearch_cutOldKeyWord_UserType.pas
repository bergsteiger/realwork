unit PrimOldSituationSearch_cutOldKeyWord_UserType;
 {* Поиск по ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_cutOldKeyWord_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "cutOldKeyWord" MUID: (4BD7284F0127)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки cutOldKeyWordLocalConstants }
 str_cutOldKeyWordCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordCaption'; rValue : 'Поиск по ситуации');
  {* Заголовок пользовательского типа "Поиск по ситуации" }
 str_cutOldKeyWordSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
  {* Заголовок пользовательского типа "Поиск по ситуации" для настройки панелей инструментов }
 {* Константы для типа формы cutOldKeyWord }
 cutOldKeyWordName = 'cutOldKeyWord';
  {* Строковый идентификатор пользовательского типа "Поиск по ситуации" }
 cutOldKeyWord = TvcmUserType(0);
  {* Поиск по ситуации }
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
 Tkw_FormUserType_cutOldKeyWord = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cutOldKeyWord }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutOldKeyWord
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutOldKeyWord.GetInteger: Integer;
begin
 Result := cutOldKeyWord;
end;//Tkw_FormUserType_cutOldKeyWord.GetInteger

class function Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cutOldKeyWord';
end;//Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cutOldKeyWordCaption.Init;
 {* Инициализация str_cutOldKeyWordCaption }
 str_cutOldKeyWordSettingsCaption.Init;
 {* Инициализация str_cutOldKeyWordSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutOldKeyWord.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cutOldKeyWord }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
