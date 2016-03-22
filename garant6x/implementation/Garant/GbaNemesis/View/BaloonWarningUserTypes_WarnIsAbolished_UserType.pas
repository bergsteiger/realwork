unit BaloonWarningUserTypes_WarnIsAbolished_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas"
// ���������: "UserType"
// ������� ������: "WarnIsAbolished" MUID: (4DA8296501F2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnPreActive_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_WarnIsAbolished = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnIsAbolished }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnIsAbolished
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnIsAbolished.GetInteger: Integer;
begin
 Result := WarnIsAbolished;
end;//Tkw_FormUserType_WarnIsAbolished.GetInteger

class function Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnIsAbolished';
end;//Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnIsAbolished }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
