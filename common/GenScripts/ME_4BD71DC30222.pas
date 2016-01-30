unit PrimGroupList_admGroupList_UserType;
 {* ������ ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupList_admGroupList_UserType.pas"
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
 {* ��������� ��� ���� ����� admGroupList }
 admGroupListName = 'admGroupList';
  {* ��������� ������������� ����������������� ���� "������ �������������" }
 admGroupList = TvcmUserType(0);
  {* ������ ������������� }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admGroupList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admGroupList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admGroupList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admGroupList';
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
 {* ����������� Tkw_FormUserType_admGroupList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
