unit TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::TurnOnTimeMachine::ut_TurnOnTimeMachine
//
// �������� ������ �������
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
    { ��������� ��� ���� ����� ut_TurnOnTimeMachine }
   ut_TurnOnTimeMachineName = 'ut_TurnOnTimeMachine';
    { ��������� ������������� ����������������� ���� "�������� ������ �������" }
   ut_TurnOnTimeMachine = TvcmUserType(0);
    { �������� ������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_TurnOnTimeMachine = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_TurnOnTimeMachine }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_TurnOnTimeMachine
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_TurnOnTimeMachine

class function Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_TurnOnTimeMachine';
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger: Integer;
 {-}
begin
 Result := ut_TurnOnTimeMachine;
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_TurnOnTimeMachine
 Tkw_FormUserType_ut_TurnOnTimeMachine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.