unit WarningUserTypes_Warning_UserType;
 {* �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes_Warning_UserType.pas"
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
 {* ��������� ��� ���� ����� Warning }
 WarningName = 'Warning';
  {* ��������� ������������� ����������������� ���� "��������������" }
 Warning = TvcmUserType(0);
  {* �������������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Warning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_Warning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Warning.GetInteger: Integer;
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
