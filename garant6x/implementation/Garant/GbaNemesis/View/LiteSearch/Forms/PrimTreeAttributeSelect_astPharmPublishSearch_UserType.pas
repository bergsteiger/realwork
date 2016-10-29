unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;
 {* СМИ по медицине и здравоохранению }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "astPharmPublishSearch" MUID: (53A950A801A6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки astPharmPublishSearchLocalConstants }
 str_astPharmPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astPharmPublishSearchCaption'; rValue : 'СМИ по медицине и здравоохранению');
  {* Заголовок пользовательского типа "СМИ по медицине и здравоохранению" }
 {* Константы для типа формы astPharmPublishSearch }
 astPharmPublishSearchName = 'astPharmPublishSearch';
  {* Строковый идентификатор пользовательского типа "СМИ по медицине и здравоохранению" }
 astPharmPublishSearch = TvcmUserType(astTaxesPublishSearch + 1);
  {* СМИ по медицине и здравоохранению }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astPharmPublishSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astPharmPublishSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astPharmPublishSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger

class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astPharmPublishSearchCaption.Init;
 {* Инициализация str_astPharmPublishSearchCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astPharmPublishSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
