unit BaloonWarningUserTypes_OldBaseWarning_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_OldBaseWarning_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::OldBaseWarning
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
  BaloonWarningUserTypes_TrialModeWarning_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� OldBaseWarning }
  OldBaseWarningName = 'OldBaseWarning';
   { ��������� ������������� ����������������� ���� "" }
  OldBaseWarning = TvcmUserType(TrialModeWarning + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_OldBaseWarning = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� OldBaseWarning }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_OldBaseWarning
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_OldBaseWarning

class function Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::OldBaseWarning';
end;//Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister

function Tkw_FormUserType_OldBaseWarning.GetInteger: Integer;
 {-}
begin
 Result := OldBaseWarning;
end;//Tkw_FormUserType_OldBaseWarning.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_OldBaseWarning
 Tkw_FormUserType_OldBaseWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.