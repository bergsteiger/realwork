unit PrimGroupProperty_admRenameGroup_UserType;
 {* Переименовать группу }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_admRenameGroup_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupProperty_admCreateGroup_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы admRenameGroup }
 admRenameGroupName = 'admRenameGroup';
  {* Строковый идентификатор пользовательского типа "Переименовать группу" }
 admRenameGroup = TvcmUserType(admCreateGroup + 1);
  {* Переименовать группу }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admRenameGroup = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admRenameGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admRenameGroup
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admRenameGroup.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admRenameGroup';
end;//Tkw_FormUserType_admRenameGroup.GetWordNameForRegister

function Tkw_FormUserType_admRenameGroup.GetInteger: Integer;
begin
 Result := admRenameGroup;
end;//Tkw_FormUserType_admRenameGroup.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admRenameGroup.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admRenameGroup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
