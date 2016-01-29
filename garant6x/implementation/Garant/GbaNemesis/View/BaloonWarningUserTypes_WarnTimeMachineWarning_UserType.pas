unit BaloonWarningUserTypes_WarnTimeMachineWarning_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnTimeMachineWarning
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
  BaloonWarningUserTypes_WarnRedaction_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnTimeMachineWarning }
  WarnTimeMachineWarningName = 'WarnTimeMachineWarning';
   { ��������� ������������� ����������������� ���� "" }
  WarnTimeMachineWarning = TvcmUserType(WarnRedaction + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnTimeMachineWarning = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnTimeMachineWarning }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnTimeMachineWarning
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnTimeMachineWarning

class function Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnTimeMachineWarning';
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineWarning.GetInteger: Integer;
 {-}
begin
 Result := WarnTimeMachineWarning;
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnTimeMachineWarning
 Tkw_FormUserType_WarnTimeMachineWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.