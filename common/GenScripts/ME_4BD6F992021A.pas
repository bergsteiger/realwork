unit PrimTreeAttributeSelect_astTaxesPublishSearch_UserType;
 {* СМИ по налогам и бухучету }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы astTaxesPublishSearch }
 astTaxesPublishSearchName = 'astTaxesPublishSearch';
  {* Строковый идентификатор пользовательского типа "СМИ по налогам и бухучету" }
 astTaxesPublishSearch = TvcmUserType(astFirstLevel + 1);
  {* СМИ по налогам и бухучету }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astTaxesPublishSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astTaxesPublishSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astTaxesPublishSearch';
end;//Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astTaxesPublishSearch.GetInteger: Integer;
begin
 Result := astTaxesPublishSearch;
end;//Tkw_FormUserType_astTaxesPublishSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astTaxesPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
