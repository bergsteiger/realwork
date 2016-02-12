unit BaloonWarningUserTypes_WarnTimeMachineWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� WarnTimeMachineWarning }
 WarnTimeMachineWarningName = 'WarnTimeMachineWarning';
  {* ��������� ������������� ����������������� ���� "" }
 WarnTimeMachineWarning = TvcmUserType(WarnRedaction + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnTimeMachineWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnTimeMachineWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnTimeMachineWarning';
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineWarning.GetInteger: Integer;
begin
 Result := WarnTimeMachineWarning;
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
