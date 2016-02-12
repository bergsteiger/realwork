unit PrimCreateFilter_cfRename_UserType;
 {* Переименовать фильтр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfRename_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCreateFilter_cfCreate_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы cfRename }
 cfRenameName = 'cfRename';
  {* Строковый идентификатор пользовательского типа "Переименовать фильтр" }
 cfRename = TvcmUserType(cfCreate + 1);
  {* Переименовать фильтр }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfRename = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cfRename }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cfRename
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cfRename.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cfRename';
end;//Tkw_FormUserType_cfRename.GetWordNameForRegister

function Tkw_FormUserType_cfRename.GetInteger: Integer;
begin
 Result := cfRename;
end;//Tkw_FormUserType_cfRename.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfRename.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cfRename }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
