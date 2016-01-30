unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;
 {* СМИ по медицине и здравоохранению }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы astPharmPublishSearch }
 astPharmPublishSearchName = 'astPharmPublishSearch';
  {* Строковый идентификатор пользовательского типа "СМИ по медицине и здравоохранению" }
 astPharmPublishSearch = TvcmUserType(astTaxesPublishSearch + 1);
  {* СМИ по медицине и здравоохранению }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astPharmPublishSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astPharmPublishSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astPharmPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
