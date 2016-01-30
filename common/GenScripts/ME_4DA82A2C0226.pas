unit BaloonWarningUserTypes_WarnTimeMachineException_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineException_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� WarnTimeMachineException }
 WarnTimeMachineExceptionName = 'WarnTimeMachineException';
  {* ��������� ������������� ����������������� ���� "" }
 WarnTimeMachineException = TvcmUserType(WarnTimeMachineWarning + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineException = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnTimeMachineException }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnTimeMachineException
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnTimeMachineException';
end;//Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnTimeMachineException.GetInteger: Integer;
begin
 Result := WarnTimeMachineException;
end;//Tkw_FormUserType_WarnTimeMachineException.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineException.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnTimeMachineException }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
