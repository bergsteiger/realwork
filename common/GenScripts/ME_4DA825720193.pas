unit BaloonWarningUserTypes_WarnJuror_UserType;
 {* ����������� �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnJuror_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� WarnJuror }
 WarnJurorName = 'WarnJuror';
  {* ��������� ������������� ����������������� ���� "����������� ��������������" }
 WarnJuror = TvcmUserType(Fake + 1);
  {* ����������� �������������� }
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
 Tkw_FormUserType_WarnJuror = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� WarnJuror }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_WarnJuror
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_WarnJuror.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::WarnJuror';
end;//Tkw_FormUserType_WarnJuror.GetWordNameForRegister

function Tkw_FormUserType_WarnJuror.GetInteger: Integer;
begin
 Result := WarnJuror;
end;//Tkw_FormUserType_WarnJuror.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnJuror.RegisterInEngine;
 {* ����������� Tkw_FormUserType_WarnJuror }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
