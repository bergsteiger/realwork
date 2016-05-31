unit BaloonWarningUserTypes_OldBaseWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_OldBaseWarning_UserType.pas"
// ���������: "UserType"
// ������� ������: "OldBaseWarning" MUID: (4DBFF6CD00D0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_TrialModeWarning_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ OldBaseWarningLocalConstants }
 str_OldBaseWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldBaseWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� OldBaseWarning }
 OldBaseWarningName = 'OldBaseWarning';
  {* ��������� ������������� ����������������� ���� "" }
 OldBaseWarning = TvcmUserType(TrialModeWarning + 1);
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
 Tkw_FormUserType_OldBaseWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� OldBaseWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_OldBaseWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_OldBaseWarning.GetInteger: Integer;
begin
 Result := OldBaseWarning;
end;//Tkw_FormUserType_OldBaseWarning.GetInteger

class function Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::OldBaseWarning';
end;//Tkw_FormUserType_OldBaseWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_OldBaseWarningCaption.Init;
 {* ������������� str_OldBaseWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_OldBaseWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_OldBaseWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
