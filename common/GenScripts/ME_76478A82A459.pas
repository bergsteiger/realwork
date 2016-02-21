unit RememberPassword_ut_RememberPassword_UserType;
 {* ������ ������? }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_ut_RememberPassword_UserType.pas"
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
 {* ��������� ��� ���� ����� ut_RememberPassword }
 ut_RememberPasswordName = 'ut_RememberPassword';
  {* ��������� ������������� ����������������� ���� "������ ������?" }
 ut_RememberPassword = TvcmUserType(0);
  {* ������ ������? }
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
 Tkw_FormUserType_ut_RememberPassword = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_RememberPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_RememberPassword
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_RememberPassword';
end;//Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister

function Tkw_FormUserType_ut_RememberPassword.GetInteger: Integer;
begin
 Result := ut_RememberPassword;
end;//Tkw_FormUserType_ut_RememberPassword.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RememberPassword.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_RememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
