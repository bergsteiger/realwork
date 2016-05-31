unit DocumentUserTypes_dftAutoreferatAfterSearch_UserType;
 {* ПРАЙМ. Обзор изменений законодательства }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAutoreferatAfterSearch" MUID: (4B040F34030A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftAutoreferatAfterSearchLocalConstants }
 str_dftAutoreferatAfterSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchCaption'; rValue : 'ПРАЙМ. Обзор изменений законодательства');
  {* Заголовок пользовательского типа "ПРАЙМ. Обзор изменений законодательства" }
 str_dftAutoreferatAfterSearchSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchSettingsCaption'; rValue : 'Документ: ПРАЙМ. Обзор изменений законодательства');
  {* Заголовок пользовательского типа "ПРАЙМ. Обзор изменений законодательства" для настройки панелей инструментов }
 {* Константы для типа формы dftAutoreferatAfterSearch }
 dftAutoreferatAfterSearchName = 'dftAutoreferatAfterSearch';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Обзор изменений законодательства" }
 dftAutoreferatAfterSearch = TvcmUserType(dftAnnotation + 1);
  {* ПРАЙМ. Обзор изменений законодательства }
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
 Tkw_FormUserType_dftAutoreferatAfterSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAutoreferatAfterSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAutoreferatAfterSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger: Integer;
begin
 Result := dftAutoreferatAfterSearch;
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger

class function Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAutoreferatAfterSearch';
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAutoreferatAfterSearchCaption.Init;
 {* Инициализация str_dftAutoreferatAfterSearchCaption }
 str_dftAutoreferatAfterSearchSettingsCaption.Init;
 {* Инициализация str_dftAutoreferatAfterSearchSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferatAfterSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAutoreferatAfterSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
