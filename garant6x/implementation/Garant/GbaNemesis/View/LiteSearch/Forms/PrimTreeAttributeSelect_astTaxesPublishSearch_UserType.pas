unit PrimTreeAttributeSelect_astTaxesPublishSearch_UserType;
 {* СМИ по налогам и бухучету }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astTaxesPublishSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "astTaxesPublishSearch" MUID: (4BD6F992021A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки astTaxesPublishSearchLocalConstants }
 str_astTaxesPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astTaxesPublishSearchCaption'; rValue : 'СМИ по налогам и бухучету');
  {* Заголовок пользовательского типа "СМИ по налогам и бухучету" }
 {* Константы для типа формы astTaxesPublishSearch }
 astTaxesPublishSearchName = 'astTaxesPublishSearch';
  {* Строковый идентификатор пользовательского типа "СМИ по налогам и бухучету" }
 astTaxesPublishSearch = TvcmUserType(astFirstLevel + 1);
  {* СМИ по налогам и бухучету }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astTaxesPublishSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astTaxesPublishSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astTaxesPublishSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astTaxesPublishSearch.GetInteger: Integer;
begin
 Result := astTaxesPublishSearch;
end;//Tkw_FormUserType_astTaxesPublishSearch.GetInteger

class function Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astTaxesPublishSearch';
end;//Tkw_FormUserType_astTaxesPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astTaxesPublishSearchCaption.Init;
 {* Инициализация str_astTaxesPublishSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astTaxesPublishSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astTaxesPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
