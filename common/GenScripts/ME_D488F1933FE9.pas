unit RegistrationForm_ut_RegistrationForm_UserType;
 {* ����������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RegistrationForm_ut_RegistrationForm_UserType.pas"
// ���������: "UserType"

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
 {* ��������� ��� ���� ����� ut_RegistrationForm }
 ut_RegistrationFormName = 'ut_RegistrationForm';
  {* ��������� ������������� ����������������� ���� "�����������" }
 ut_RegistrationForm = TvcmUserType(0);
  {* ����������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RegistrationForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_RegistrationForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_RegistrationForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_RegistrationForm';
end;//Tkw_FormUserType_ut_RegistrationForm.GetWordNameForRegister

function Tkw_FormUserType_ut_RegistrationForm.GetInteger: Integer;
begin
 Result := ut_RegistrationForm;
end;//Tkw_FormUserType_ut_RegistrationForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RegistrationForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
