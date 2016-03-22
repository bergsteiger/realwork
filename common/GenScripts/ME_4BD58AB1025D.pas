unit ListUserTypes_lftUserCRList1_SynchorForm_UserType;
 {* ���������� �������� (������������� ������� ��������� ���������� 1) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList1_SynchorForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftUserCRList1_SynchorForm" MUID: (4BD58AB1025D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftUserCRList1_SynchorForm }
 lftUserCRList1_SynchorFormName = 'lftUserCRList1_SynchorForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 1)" }
 lftUserCRList1_SynchorForm = TvcmUserType(lftRespondentsSynchroForm + 1);
  {* ���������� �������� (������������� ������� ��������� ���������� 1) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftUserCRList1_SynchorForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftUserCRList1_SynchorForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftUserCRList1_SynchorForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger: Integer;
begin
 Result := lftUserCRList1_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger

class function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftUserCRList1_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList1_SynchorForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftUserCRList1_SynchorForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
