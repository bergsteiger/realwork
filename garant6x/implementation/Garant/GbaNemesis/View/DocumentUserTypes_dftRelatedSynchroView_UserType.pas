unit DocumentUserTypes_dftRelatedSynchroView_UserType;
 {* ������� � ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftRelatedSynchroView" MUID: (4B040E560333)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDocSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dftRelatedSynchroViewLocalConstants }
 str_dftRelatedSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewCaption'; rValue : '������� � ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "������� � ��������� (���������� ��������)" }
 str_dftRelatedSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewSettingsCaption'; rValue : '���������� ��������: ������� � ���������');
  {* ��������� ����������������� ���� "������� � ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftRelatedSynchroView }
 dftRelatedSynchroViewName = 'dftRelatedSynchroView';
  {* ��������� ������������� ����������������� ���� "������� � ��������� (���������� ��������)" }
 dftRelatedSynchroView = TvcmUserType(dftDocSynchroView + 1);
  {* ������� � ��������� (���������� ��������) }
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
 Tkw_FormUserType_dftRelatedSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftRelatedSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftRelatedSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftRelatedSynchroView.GetInteger: Integer;
begin
 Result := dftRelatedSynchroView;
end;//Tkw_FormUserType_dftRelatedSynchroView.GetInteger

class function Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftRelatedSynchroView';
end;//Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftRelatedSynchroViewCaption.Init;
 {* ������������� str_dftRelatedSynchroViewCaption }
 str_dftRelatedSynchroViewSettingsCaption.Init;
 {* ������������� str_dftRelatedSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftRelatedSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
