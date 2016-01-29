unit RegistrationForm_ut_RegistrationForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/RegistrationForm_ut_RegistrationForm_UserType.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::RegistrationForm::ut_RegistrationForm
//
// �����������
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
    { ��������� ��� ���� ����� ut_RegistrationForm }
   ut_RegistrationFormName = 'ut_RegistrationForm';
    { ��������� ������������� ����������������� ���� "�����������" }
   ut_RegistrationForm = TvcmUserType(0);
    { ����������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_RegistrationForm = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_RegistrationForm }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_RegistrationForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_RegistrationForm

class function Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_RegistrationForm';
end;//Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister

function Tkw_FormUserType_ut_RegistrationForm.GetInteger: Integer;
 {-}
begin
 Result := ut_RegistrationForm;
end;//Tkw_FormUserType_ut_RegistrationForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_RegistrationForm
 Tkw_FormUserType_ut_RegistrationForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.