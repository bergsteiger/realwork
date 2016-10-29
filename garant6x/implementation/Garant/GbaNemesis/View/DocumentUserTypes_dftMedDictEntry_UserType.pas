unit DocumentUserTypes_dftMedDictEntry_UserType;
 {* Описание медицинского термина }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedDictEntry_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftMedDictEntry" MUID: (4B04100D0197)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftMedDictEntryLocalConstants }
 str_dftMedDictEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntryCaption'; rValue : 'Описание медицинского термина');
  {* Заголовок пользовательского типа "Описание медицинского термина" }
 str_dftMedDictEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntrySettingsCaption'; rValue : 'Словарь медицинских терминов: Описание медицинского термина');
  {* Заголовок пользовательского типа "Описание медицинского термина" для настройки панелей инструментов }
 {* Константы для типа формы dftMedDictEntry }
 dftMedDictEntryName = 'dftMedDictEntry';
  {* Строковый идентификатор пользовательского типа "Описание медицинского термина" }
 dftMedDictEntry = TvcmUserType(dftTips + 1);
  {* Описание медицинского термина }
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
 Tkw_FormUserType_dftMedDictEntry = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftMedDictEntry }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftMedDictEntry
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftMedDictEntry.GetInteger: Integer;
begin
 Result := dftMedDictEntry;
end;//Tkw_FormUserType_dftMedDictEntry.GetInteger

class function Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftMedDictEntry';
end;//Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftMedDictEntryCaption.Init;
 {* Инициализация str_dftMedDictEntryCaption }
 str_dftMedDictEntrySettingsCaption.Init;
 {* Инициализация str_dftMedDictEntrySettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftMedDictEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
