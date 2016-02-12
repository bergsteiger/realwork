unit FiltersUserTypes_utFilters_UserType;
 {* Фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes_utFilters_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utFilters }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFilters
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister

function Tkw_FormUserType_utFilters.GetInteger: Integer;
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFilters.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
