unit BaloonWarningUserTypes_WarnIsAbolished_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� WarnIsAbolished }
 WarnIsAbolishedName = 'WarnIsAbolished';
  {* ��������� ������������� ����������������� ���� "" }
 WarnIsAbolished = TvcmUserType(WarnPreActive + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnIsAbolished }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnIsAbolished
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnIsAbolished';
end;//Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister

function Tkw_FormUserType_WarnIsAbolished.GetInteger: Integer;
begin
 Result := WarnIsAbolished;
end;//Tkw_FormUserType_WarnIsAbolished.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnIsAbolished }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
