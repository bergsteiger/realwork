unit PrimGroupProperty_admCreateGroup_UserType;
 {* ����� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_admCreateGroup_UserType.pas"
// ���������: "UserType"

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
 {* ��������� ��� ���� ����� admCreateGroup }
 admCreateGroupName = 'admCreateGroup';
  {* ��������� ������������� ����������������� ���� "����� ������" }
 admCreateGroup = TvcmUserType(0);
  {* ����� ������ }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admCreateGroup = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admCreateGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admCreateGroup
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admCreateGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admCreateGroup';
end;//Tkw_FormUserType_admCreateGroup.GetWordNameForRegister

function Tkw_FormUserType_admCreateGroup.GetInteger: Integer;
begin
 Result := admCreateGroup;
end;//Tkw_FormUserType_admCreateGroup.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admCreateGroup.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admCreateGroup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
