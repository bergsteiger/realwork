unit BaloonWarningUserTypes_WarnTimeMachineOn_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnTimeMachineOn_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnTimeMachineOn
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
  ,
  BaloonWarningUserTypes_WarnInactualDocument_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnTimeMachineOn }
  WarnTimeMachineOnName = 'WarnTimeMachineOn';
   { ��������� ������������� ����������������� ���� "" }
  WarnTimeMachineOn = TvcmUserType(WarnInactualDocument + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnTimeMachineOn = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnTimeMachineOn }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnTimeMachineOn
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnTimeMachineOn

class function Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnTimeMachineOn';
end;//Tkw_FormUserType_WarnTimeMachineOn.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineOn.GetInteger: Integer;
 {-}
begin
 Result := WarnTimeMachineOn;
end;//Tkw_FormUserType_WarnTimeMachineOn.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnTimeMachineOn
 Tkw_FormUserType_WarnTimeMachineOn.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.