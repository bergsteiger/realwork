unit BaloonWarningUserTypes_Fake_UserType;
 {* �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_Fake_UserType.pas"
// ���������: "UserType"
// ������� ������: "Fake" MUID: (4F5E13160332)

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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_Fake = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Fake }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_Fake
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Fake.GetInteger: Integer;
begin
 Result := Fake;
end;//Tkw_FormUserType_Fake.GetInteger

class function Tkw_FormUserType_Fake.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Fake';
end;//Tkw_FormUserType_Fake.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Fake.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Fake }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
