unit WarningUserTypes_Warning_UserType;
 {* �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes_Warning_UserType.pas"
// ���������: "UserType"
// ������� ������: "Warning" MUID: (4BD6C31B03BC)

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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_Warning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Warning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_Warning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Warning.GetInteger: Integer;
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger

class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
