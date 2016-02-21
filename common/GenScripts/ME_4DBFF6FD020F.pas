unit BaloonWarningUserTypes_ControlledChangingWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ControlledChangingWarning }
 ControlledChangingWarningName = 'ControlledChangingWarning';
  {* ��������� ������������� ����������������� ���� "" }
 ControlledChangingWarning = TvcmUserType(OldBaseWarning + 1);
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
 Tkw_FormUserType_ControlledChangingWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ControlledChangingWarning }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ControlledChangingWarning
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ControlledChangingWarning';
end;//Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister

function Tkw_FormUserType_ControlledChangingWarning.GetInteger: Integer;
begin
 Result := ControlledChangingWarning;
end;//Tkw_FormUserType_ControlledChangingWarning.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ControlledChangingWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ControlledChangingWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
