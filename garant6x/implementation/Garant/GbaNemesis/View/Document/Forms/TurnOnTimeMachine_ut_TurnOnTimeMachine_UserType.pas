unit TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType;
 {* �������� ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_TurnOnTimeMachine" MUID: (6E555D981AA9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ ut_TurnOnTimeMachineLocalConstants }
 str_ut_TurnOnTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOnTimeMachineCaption'; rValue : '�������� ������ �������');
  {* ��������� ����������������� ���� "�������� ������ �������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_TurnOnTimeMachine = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_TurnOnTimeMachine }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_TurnOnTimeMachine
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOnTimeMachine;
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger

class function Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_TurnOnTimeMachine';
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_TurnOnTimeMachineCaption.Init;
 {* ������������� str_ut_TurnOnTimeMachineCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
