unit PrimGroupProperty_admRenameGroup_UserType;
 {* ������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_admRenameGroup_UserType.pas"
// ���������: "UserType"

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
 {* ��������� ��� ���� ����� admRenameGroup }
 admRenameGroupName = 'admRenameGroup';
  {* ��������� ������������� ����������������� ���� "������������� ������" }
 admRenameGroup = TvcmUserType(admCreateGroup + 1);
  {* ������������� ������ }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admRenameGroup = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admRenameGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admRenameGroup
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admRenameGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admRenameGroup';
end;//Tkw_FormUserType_admRenameGroup.GetWordNameForRegister

function Tkw_FormUserType_admRenameGroup.GetInteger: Integer;
begin
 Result := admRenameGroup;
end;//Tkw_FormUserType_admRenameGroup.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admRenameGroup.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admRenameGroup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
