unit ListUserTypes_lftSynchroView_UserType;
 {* ���������� �������� (������ �� ���������, ������ �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftSynchroView" MUID: (4BD5888802BA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ lftSynchroViewLocalConstants }
 str_lftSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewCaption'; rValue : '���������� �������� (������ �� ���������, ������ �� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" }
 str_lftSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSynchroViewSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������/�� ��������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������, ������ �� ��������)" ��� ��������� ������� ������������ }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger

class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftSynchroViewCaption.Init;
 {* ������������� str_lftSynchroViewCaption }
 str_lftSynchroViewSettingsCaption.Init;
 {* ������������� str_lftSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
