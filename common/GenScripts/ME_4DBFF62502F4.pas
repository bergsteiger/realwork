unit BaloonWarningUserTypes_TrialModeWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_TrialModeWarning_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� TrialModeWarning }
 TrialModeWarningName = 'TrialModeWarning';
  {* ��������� ������������� ����������������� ���� "" }
 TrialModeWarning = TvcmUserType(remOnlineDead + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_TrialModeWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� TrialModeWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_TrialModeWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::TrialModeWarning';
end;//Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_TrialModeWarning.GetInteger: Integer;
begin
 Result := TrialModeWarning;
end;//Tkw_FormUserType_TrialModeWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_TrialModeWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_TrialModeWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
