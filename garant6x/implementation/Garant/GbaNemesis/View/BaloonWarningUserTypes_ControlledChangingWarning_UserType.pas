unit BaloonWarningUserTypes_ControlledChangingWarning_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::ControlledChangingWarning
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
  BaloonWarningUserTypes_OldBaseWarning_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� ControlledChangingWarning }
  ControlledChangingWarningName = 'ControlledChangingWarning';
   { ��������� ������������� ����������������� ���� "" }
  ControlledChangingWarning = TvcmUserType(OldBaseWarning + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ControlledChangingWarning = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ControlledChangingWarning }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ControlledChangingWarning
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ControlledChangingWarning

class function Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ControlledChangingWarning';
end;//Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister

function Tkw_FormUserType_ControlledChangingWarning.GetInteger: Integer;
 {-}
begin
 Result := ControlledChangingWarning;
end;//Tkw_FormUserType_ControlledChangingWarning.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ControlledChangingWarning
 Tkw_FormUserType_ControlledChangingWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.