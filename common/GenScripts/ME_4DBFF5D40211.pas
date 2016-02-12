unit BaloonWarningUserTypes_remOnlineDead_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remOnlineDead_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� remOnlineDead }
 remOnlineDeadName = 'remOnlineDead';
  {* ��������� ������������� ����������������� ���� "" }
 remOnlineDead = TvcmUserType(remUnreadConsultations + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� remOnlineDead }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_remOnlineDead
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_remOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::remOnlineDead';
end;//Tkw_FormUserType_remOnlineDead.GetWordNameForRegister

function Tkw_FormUserType_remOnlineDead.GetInteger: Integer;
begin
 Result := remOnlineDead;
end;//Tkw_FormUserType_remOnlineDead.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead.RegisterInEngine;
 {* ����������� Tkw_FormUserType_remOnlineDead }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
