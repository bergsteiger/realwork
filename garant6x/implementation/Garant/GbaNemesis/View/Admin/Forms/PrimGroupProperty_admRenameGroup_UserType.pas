unit PrimGroupProperty_admRenameGroup_UserType;
 {* ������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_admRenameGroup_UserType.pas"
// ���������: "UserType"
// ������� ������: "admRenameGroup" MUID: (4BD6FFBA008E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupProperty_admCreateGroup_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ admRenameGroupLocalConstants }
 str_admRenameGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admRenameGroupCaption'; rValue : '������������� ������');
  {* ��������� ����������������� ���� "������������� ������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_admRenameGroup = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admRenameGroup }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_admRenameGroup
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admRenameGroup.GetInteger: Integer;
begin
 Result := admRenameGroup;
end;//Tkw_FormUserType_admRenameGroup.GetInteger

class function Tkw_FormUserType_admRenameGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admRenameGroup';
end;//Tkw_FormUserType_admRenameGroup.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_admRenameGroupCaption.Init;
 {* ������������� str_admRenameGroupCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admRenameGroup.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admRenameGroup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
