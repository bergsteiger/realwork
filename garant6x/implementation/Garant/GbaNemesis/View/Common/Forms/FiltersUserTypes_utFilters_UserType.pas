unit FiltersUserTypes_utFilters_UserType;
 {* Фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utFilters" MUID: (4BD729B70260)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utFiltersLocalConstants }
 str_utFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersCaption'; rValue : 'Фильтры');
  {* Заголовок пользовательского типа "Фильтры" }
 str_utFiltersSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersSettingsCaption'; rValue : 'Фильтры (вкладка)');
  {* Заголовок пользовательского типа "Фильтры" для настройки панелей инструментов }
 {* Константы для типа формы utFilters }
 utFiltersName = 'utFilters';
  {* Строковый идентификатор пользовательского типа "Фильтры" }
 utFilters = TvcmUserType(0);
  {* Фильтры }
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
 Tkw_FormUserType_utFilters = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFilters }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFilters
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFilters.GetInteger: Integer;
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger

class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFiltersCaption.Init;
 {* Инициализация str_utFiltersCaption }
 str_utFiltersSettingsCaption.Init;
 {* Инициализация str_utFiltersSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
