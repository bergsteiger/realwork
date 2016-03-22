unit BaloonWarningUserTypes_remListModified_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remListModified_UserType.pas"
// ���������: "UserType"
// ������� ������: "remListModified" MUID: (4DB97E660273)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_remListModified = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� remListModified }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remListModified
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remListModified.GetInteger: Integer;
begin
 Result := remListModified;
end;//Tkw_FormUserType_remListModified.GetInteger

class function Tkw_FormUserType_remListModified.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::remListModified';
end;//Tkw_FormUserType_remListModified.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remListModified.RegisterInEngine;
 {* ����������� Tkw_FormUserType_remListModified }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
