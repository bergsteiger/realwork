unit Login_ut_Login_UserType;
 {* ���� � ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_ut_Login_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ut_Login }
 ut_LoginName = 'ut_Login';
  {* ��������� ������������� ����������������� ���� "���� � ������� ������" }
 ut_Login = TvcmUserType(0);
  {* ���� � ������� ������ }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Login = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_Login }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_Login
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_Login.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_Login';
end;//Tkw_FormUserType_ut_Login.GetWordNameForRegister

function Tkw_FormUserType_ut_Login.GetInteger: Integer;
begin
 Result := ut_Login;
end;//Tkw_FormUserType_ut_Login.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Login.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_Login }
{$IfEnd} // NOT Defined(NoScripts)

end.
