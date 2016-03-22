unit TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType;
 {* ��������� ������ ������� / �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_TurnOffTimeMachine" MUID: (B9684F81B84D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ut_TurnOffTimeMachine }
 ut_TurnOffTimeMachineName = 'ut_TurnOffTimeMachine';
  {* ��������� ������������� ����������������� ���� "��������� ������ ������� / �������� ����" }
 ut_TurnOffTimeMachine = TvcmUserType(0);
  {* ��������� ������ ������� / �������� ���� }
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
 Tkw_FormUserType_ut_TurnOffTimeMachine = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TurnOffTimeMachine }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_TurnOffTimeMachine
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOffTimeMachine;
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger

class function Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_TurnOffTimeMachine';
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOffTimeMachine.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_TurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
