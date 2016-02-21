unit ListUserTypes_lftSynchroView_UserType;
 {* ���������� �������� (������ �� ���������, ������ �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSynchroView_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftSynchroView }
 lftSynchroViewName = 'lftSynchroView';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" }
 lftSynchroView = TvcmUserType(lftCorrespondent + 1);
  {* ���������� �������� (������ �� ���������, ������ �� ��������) }
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
 Tkw_FormUserType_lftSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister

function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
