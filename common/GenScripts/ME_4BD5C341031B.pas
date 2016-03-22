unit PrimQueryCard_utqcAttributeSearch_UserType;
 {* Поиск по реквизитам }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcAttributeSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utqcAttributeSearch" MUID: (4BD5C341031B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utqcAttributeSearch }
 utqcAttributeSearchName = 'utqcAttributeSearch';
  {* Строковый идентификатор пользовательского типа "Поиск по реквизитам" }
 utqcAttributeSearch = TvcmUserType(0);
  {* Поиск по реквизитам }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcAttributeSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcAttributeSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcAttributeSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcAttributeSearch.GetInteger: Integer;
begin
 Result := utqcAttributeSearch;
end;//Tkw_FormUserType_utqcAttributeSearch.GetInteger

class function Tkw_FormUserType_utqcAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcAttributeSearch';
end;//Tkw_FormUserType_utqcAttributeSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcAttributeSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcAttributeSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
