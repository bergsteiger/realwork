unit PrimAttributeSelect_utSingleSearch_UserType;
 {* Атомарный поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utSingleSearch_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimAttributeSelect_utAttributeSelect_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utSingleSearch }
 utSingleSearchName = 'utSingleSearch';
  {* Строковый идентификатор пользовательского типа "Атомарный поиск" }
 utSingleSearch = TvcmUserType(utAttributeSelect + 1);
  {* Атомарный поиск }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSingleSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utSingleSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utSingleSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utSingleSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utSingleSearch';
end;//Tkw_FormUserType_utSingleSearch.GetWordNameForRegister

function Tkw_FormUserType_utSingleSearch.GetInteger: Integer;
begin
 Result := utSingleSearch;
end;//Tkw_FormUserType_utSingleSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSingleSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utSingleSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
