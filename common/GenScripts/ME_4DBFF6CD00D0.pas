unit BaloonWarningUserTypes_OldBaseWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_OldBaseWarning_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� OldBaseWarning }
 OldBaseWarningName = 'OldBaseWarning';
  {* ��������� ������������� ����������������� ���� "" }
 OldBaseWarning = TvcmUserType(TrialModeWarning + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_OldBaseWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� OldBaseWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_OldBaseWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::OldBaseWarning';
end;//Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister

function Tkw_FormUserType_OldBaseWarning.GetInteger: Integer;
begin
 Result := OldBaseWarning;
end;//Tkw_FormUserType_OldBaseWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_OldBaseWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_OldBaseWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
