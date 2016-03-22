unit Logo_ut_Logo_UserType;
 {* Logo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Logo_ut_Logo_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_Logo" MUID: (8D46F2A2464B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ut_Logo }
 ut_LogoName = 'ut_Logo';
  {* ��������� ������������� ����������������� ���� "Logo" }
 ut_Logo = TvcmUserType(0);
  {* Logo }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_Logo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_Logo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_Logo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_Logo.GetInteger: Integer;
begin
 Result := ut_Logo;
end;//Tkw_FormUserType_ut_Logo.GetInteger

class function Tkw_FormUserType_ut_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_Logo';
end;//Tkw_FormUserType_ut_Logo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Logo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
