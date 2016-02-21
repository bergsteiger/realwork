unit BaloonWarningUserTypes_WarnPreActive_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnPreActive_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� WarnPreActive }
 WarnPreActiveName = 'WarnPreActive';
  {* ��������� ������������� ����������������� ���� "" }
 WarnPreActive = TvcmUserType(WarnJuror + 1);
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
 Tkw_FormUserType_WarnPreActive = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnPreActive }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnPreActive
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnPreActive.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnPreActive';
end;//Tkw_FormUserType_WarnPreActive.GetWordNameForRegister

function Tkw_FormUserType_WarnPreActive.GetInteger: Integer;
begin
 Result := WarnPreActive;
end;//Tkw_FormUserType_WarnPreActive.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnPreActive.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnPreActive }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
