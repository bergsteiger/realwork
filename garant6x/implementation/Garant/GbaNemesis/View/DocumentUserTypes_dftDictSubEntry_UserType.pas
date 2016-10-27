unit DocumentUserTypes_dftDictSubEntry_UserType;
 {* Перевод словарной статьи }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDictSubEntry_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftDictSubEntry" MUID: (4B040ED4039A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDictEntry_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftDictSubEntryLocalConstants }
 str_dftDictSubEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntryCaption'; rValue : 'Перевод словарной статьи');
  {* Заголовок пользовательского типа "Перевод словарной статьи" }
 str_dftDictSubEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntrySettingsCaption'; rValue : 'Толковый словарь: Перевод словарной статьи');
  {* Заголовок пользовательского типа "Перевод словарной статьи" для настройки панелей инструментов }
 {* Константы для типа формы dftDictSubEntry }
 dftDictSubEntryName = 'dftDictSubEntry';
  {* Строковый идентификатор пользовательского типа "Перевод словарной статьи" }
 dftDictSubEntry = TvcmUserType(dftDictEntry + 1);
  {* Перевод словарной статьи }
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
 Tkw_FormUserType_dftDictSubEntry = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftDictSubEntry }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDictSubEntry
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDictSubEntry.GetInteger: Integer;
begin
 Result := dftDictSubEntry;
end;//Tkw_FormUserType_dftDictSubEntry.GetInteger

class function Tkw_FormUserType_dftDictSubEntry.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftDictSubEntry';
end;//Tkw_FormUserType_dftDictSubEntry.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftDictSubEntryCaption.Init;
 {* Инициализация str_dftDictSubEntryCaption }
 str_dftDictSubEntrySettingsCaption.Init;
 {* Инициализация str_dftDictSubEntrySettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDictSubEntry.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftDictSubEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
