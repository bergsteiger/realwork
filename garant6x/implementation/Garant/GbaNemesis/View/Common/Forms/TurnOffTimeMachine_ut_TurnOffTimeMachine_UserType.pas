unit TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::TurnOffTimeMachine::ut_TurnOffTimeMachine
//
// ��������� ������ ������� / �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { ��������� ��� ���� ����� ut_TurnOffTimeMachine }
   ut_TurnOffTimeMachineName = 'ut_TurnOffTimeMachine';
    { ��������� ������������� ����������������� ���� "��������� ������ ������� / �������� ����" }
   ut_TurnOffTimeMachine = TvcmUserType(0);
    { ��������� ������ ������� / �������� ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_TurnOffTimeMachine = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_TurnOffTimeMachine }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_TurnOffTimeMachine
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_TurnOffTimeMachine

class function Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_TurnOffTimeMachine';
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger: Integer;
 {-}
begin
 Result := ut_TurnOffTimeMachine;
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_TurnOffTimeMachine
 Tkw_FormUserType_ut_TurnOffTimeMachine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.