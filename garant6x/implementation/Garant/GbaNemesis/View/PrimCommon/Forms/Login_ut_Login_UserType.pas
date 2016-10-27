unit Login_ut_Login_UserType;
 {* ���� � ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_ut_Login_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_Login" MUID: (860E458F4C2C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_LoginLocalConstants }
 str_ut_LoginCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : '���� � ������� ������');
  {* ��������� ����������������� ���� "���� � ������� ������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_Login = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_Login }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_Login
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_Login.GetInteger: Integer;
begin
 Result := ut_Login;
end;//Tkw_FormUserType_ut_Login.GetInteger

class function Tkw_FormUserType_ut_Login.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_Login';
end;//Tkw_FormUserType_ut_Login.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_LoginCaption.Init;
 {* ������������� str_ut_LoginCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_Login.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_Login }
{$IfEnd} // NOT Defined(NoScripts)

end.
