unit PrimSaveLoadUserTypes_slqtFilters_UserType;
 {* Карточка Фильтров }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtFilters_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы slqtFilters }
 slqtFiltersName = 'slqtFilters';
  {* Строковый идентификатор пользовательского типа "Карточка Фильтров" }
 slqtFilters = TvcmUserType(slqtPublishSource + 1);
  {* Карточка Фильтров }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtFilters = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtFilters }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtFilters
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtFilters.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtFilters';
end;//Tkw_FormUserType_slqtFilters.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtFilters.GetInteger: Integer;
begin
 Result := slqtFilters;
end;//Tkw_FormUserType_slqtFilters.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtFilters.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
