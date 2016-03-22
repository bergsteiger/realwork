unit BaloonWarningUserTypes_WarnTimeMachineWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas"
// ���������: "UserType"
// ������� ������: "WarnTimeMachineWarning" MUID: (4DA82A170063)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnRedaction_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_WarnTimeMachineWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnTimeMachineWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnTimeMachineWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnTimeMachineWarning.GetInteger: Integer;
begin
 Result := WarnTimeMachineWarning;
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetInteger

class function Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnTimeMachineWarning';
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
