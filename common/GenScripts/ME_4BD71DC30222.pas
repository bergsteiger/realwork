unit PrimGroupList_admGroupList_UserType;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupList_admGroupList_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
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
 {* Константы для типа формы admGroupList }
 admGroupListName = 'admGroupList';
  {* Строковый идентификатор пользовательского типа "Группы пользователей" }
 admGroupList = TvcmUserType(0);
  {* Группы пользователей }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admGroupList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admGroupList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admGroupList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admGroupList';
end;//Tkw_FormUserType_admGroupList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admGroupList.GetInteger: Integer;
begin
 Result := admGroupList;
end;//Tkw_FormUserType_admGroupList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admGroupList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admGroupList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
