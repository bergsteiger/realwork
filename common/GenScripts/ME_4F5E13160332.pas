unit BaloonWarningUserTypes_Fake_UserType;
 {* �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_Fake_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� Fake }
 FakeName = 'Fake';
  {* ��������� ������������� ����������������� ���� "��������������" }
 Fake = TvcmUserType(0);
  {* �������������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Fake = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Fake }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_Fake
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_Fake.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Fake';
end;//Tkw_FormUserType_Fake.GetWordNameForRegister

function Tkw_FormUserType_Fake.GetInteger: Integer;
begin
 Result := Fake;
end;//Tkw_FormUserType_Fake.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Fake.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Fake }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
