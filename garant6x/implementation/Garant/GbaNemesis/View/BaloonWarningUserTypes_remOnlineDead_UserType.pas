unit BaloonWarningUserTypes_remOnlineDead_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remOnlineDead_UserType.pas"
// ���������: "UserType"
// ������� ������: "remOnlineDead" MUID: (4DBFF5D40211)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remUnreadConsultations_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ remOnlineDeadLocalConstants }
 str_remOnlineDeadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remOnlineDeadCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� remOnlineDead }
 remOnlineDeadName = 'remOnlineDead';
  {* ��������� ������������� ����������������� ���� "" }
 remOnlineDead = TvcmUserType(remUnreadConsultations + 1);
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
 Tkw_FormUserType_remOnlineDead = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� remOnlineDead }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remOnlineDead
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remOnlineDead.GetInteger: Integer;
begin
 Result := remOnlineDead;
end;//Tkw_FormUserType_remOnlineDead.GetInteger

class function Tkw_FormUserType_remOnlineDead.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::remOnlineDead';
end;//Tkw_FormUserType_remOnlineDead.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_remOnlineDeadCaption.Init;
 {* ������������� str_remOnlineDeadCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remOnlineDead.RegisterInEngine;
 {* ����������� Tkw_FormUserType_remOnlineDead }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
