unit PrimBaseSearch_BaseSearch_UserType;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearch_BaseSearch_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "BaseSearch" MUID: (4D7A37D90398)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы BaseSearch }
 BaseSearchName = 'BaseSearch';
  {* Строковый идентификатор пользовательского типа "Базовый поиск" }
 BaseSearch = TvcmUserType(0);
  {* Базовый поиск }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_BaseSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы BaseSearch }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_BaseSearch
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_BaseSearch.GetInteger: Integer;
begin
 Result := BaseSearch;
end;//Tkw_FormUserType_BaseSearch.GetInteger

class function Tkw_FormUserType_BaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::BaseSearch';
end;//Tkw_FormUserType_BaseSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_BaseSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_BaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
