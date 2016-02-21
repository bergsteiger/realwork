unit BaloonWarningUserTypes_remListModified_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remListModified_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� remListModified }
 remListModifiedName = 'remListModified';
  {* ��������� ������������� ����������������� ���� "" }
 remListModified = TvcmUserType(WarnTimeMachineException + 1);
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
 Tkw_FormUserType_remListModified = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� remListModified }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_remListModified
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_remListModified.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::remListModified';
end;//Tkw_FormUserType_remListModified.GetWordNameForRegister

function Tkw_FormUserType_remListModified.GetInteger: Integer;
begin
 Result := remListModified;
end;//Tkw_FormUserType_remListModified.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remListModified.RegisterInEngine;
 {* ����������� Tkw_FormUserType_remListModified }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
