unit ListUserTypes_lftUserCRList2_SynchorForm_UserType;
 {* ���������� �������� (������������� ������� ��������� ���������� 2) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList2_SynchorForm_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftUserCRList2_SynchorForm }
 lftUserCRList2_SynchorFormName = 'lftUserCRList2_SynchorForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" }
 lftUserCRList2_SynchorForm = TvcmUserType(lftUserCRList1_SynchorForm + 1);
  {* ���������� �������� (������������� ������� ��������� ���������� 2) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList2_SynchorForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftUserCRList2_SynchorForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftUserCRList2_SynchorForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftUserCRList2_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister

function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger: Integer;
begin
 Result := lftUserCRList2_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList2_SynchorForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftUserCRList2_SynchorForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
