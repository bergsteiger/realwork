unit DocumentUserTypes_dftAutoreferatAfterSearch_UserType;
 {* ПРАЙМ. Обзор изменений законодательства }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferatAfterSearch_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferatAfterSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAutoreferatAfterSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAutoreferatAfterSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAutoreferatAfterSearch';
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger: Integer;
begin
 Result := dftAutoreferatAfterSearch;
end;//Tkw_FormUserType_dftAutoreferatAfterSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferatAfterSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAutoreferatAfterSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
