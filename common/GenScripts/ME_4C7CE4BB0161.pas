unit PrimUserList_admUserList_UserType;
 {* Список пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserList_admUserList_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы admUserList }
 admUserListName = 'admUserList';
  {* Строковый идентификатор пользовательского типа "Список пользователей" }
 admUserList = TvcmUserType(0);
  {* Список пользователей }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUserList = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admUserList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admUserList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admUserList.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admUserList';
end;//Tkw_FormUserType_admUserList.GetWordNameForRegister

function Tkw_FormUserType_admUserList.GetInteger: Integer;
begin
 Result := admUserList;
end;//Tkw_FormUserType_admUserList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUserList.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admUserList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
