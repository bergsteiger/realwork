unit PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 {* Константы для типа формы slqtBaseSearch }
 slqtBaseSearchName = 'slqtBaseSearch';
  {* Строковый идентификатор пользовательского типа "Базовый поиск" }
 slqtBaseSearch = TvcmUserType(0);
  {* Базовый поиск }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtBaseSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtBaseSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtBaseSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtBaseSearch';
end;//Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister

function Tkw_FormUserType_slqtBaseSearch.GetInteger: Integer;
begin
 Result := slqtBaseSearch;
end;//Tkw_FormUserType_slqtBaseSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
