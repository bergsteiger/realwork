unit TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType;
 {* �������� ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* ��������� ��� ���� ����� ut_TurnOnTimeMachine }
 ut_TurnOnTimeMachineName = 'ut_TurnOnTimeMachine';
  {* ��������� ������������� ����������������� ���� "�������� ������ �������" }
 ut_TurnOnTimeMachine = TvcmUserType(0);
  {* �������� ������ ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TurnOnTimeMachine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_TurnOnTimeMachine
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_TurnOnTimeMachine';
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOnTimeMachine;
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
