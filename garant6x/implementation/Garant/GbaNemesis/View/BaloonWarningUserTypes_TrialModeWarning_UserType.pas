unit BaloonWarningUserTypes_TrialModeWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_TrialModeWarning_UserType.pas"
// ���������: "UserType"
// ������� ������: "TrialModeWarning" MUID: (4DBFF62502F4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remOnlineDead_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ TrialModeWarningLocalConstants }
 str_TrialModeWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TrialModeWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� TrialModeWarning }
 TrialModeWarningName = 'TrialModeWarning';
  {* ��������� ������������� ����������������� ���� "" }
 TrialModeWarning = TvcmUserType(remOnlineDead + 1);
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
 Tkw_FormUserType_TrialModeWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� TrialModeWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_TrialModeWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_TrialModeWarning.GetInteger: Integer;
begin
 Result := TrialModeWarning;
end;//Tkw_FormUserType_TrialModeWarning.GetInteger

class function Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::TrialModeWarning';
end;//Tkw_FormUserType_TrialModeWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_TrialModeWarningCaption.Init;
 {* ������������� str_TrialModeWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_TrialModeWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_TrialModeWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
