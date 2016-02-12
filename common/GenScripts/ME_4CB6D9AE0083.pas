unit PrimCreateFilter_cfCreate_UserType;
 {* Создать фильтр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* Константы для типа формы cfCreate }
 cfCreateName = 'cfCreate';
  {* Строковый идентификатор пользовательского типа "Создать фильтр" }
 cfCreate = TvcmUserType(0);
  {* Создать фильтр }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cfCreate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cfCreate
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cfCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cfCreate';
end;//Tkw_FormUserType_cfCreate.GetWordNameForRegister

function Tkw_FormUserType_cfCreate.GetInteger: Integer;
begin
 Result := cfCreate;
end;//Tkw_FormUserType_cfCreate.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cfCreate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
