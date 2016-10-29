unit DocumentUserTypes_dftMedicFirmSynchroView_UserType;
 {* �������� ����� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftMedicFirmSynchroView" MUID: (4B041084021C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dftMedicFirmSynchroViewLocalConstants }
 str_dftMedicFirmSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewCaption'; rValue : '�������� ����� (���������� ��������)');
  {* ��������� ����������������� ���� "�������� ����� (���������� ��������)" }
 str_dftMedicFirmSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� �����');
  {* ��������� ����������������� ���� "�������� ����� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftMedicFirmSynchroView }
 dftMedicFirmSynchroViewName = 'dftMedicFirmSynchroView';
  {* ��������� ������������� ����������������� ���� "�������� ����� (���������� ��������)" }
 dftMedicFirmSynchroView = TvcmUserType(dftMedicFirm + 1);
  {* �������� ����� (���������� ��������) }
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
 Tkw_FormUserType_dftMedicFirmSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedicFirmSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftMedicFirmSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger: Integer;
begin
 Result := dftMedicFirmSynchroView;
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger

class function Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedicFirmSynchroView';
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftMedicFirmSynchroViewCaption.Init;
 {* ������������� str_dftMedicFirmSynchroViewCaption }
 str_dftMedicFirmSynchroViewSettingsCaption.Init;
 {* ������������� str_dftMedicFirmSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirmSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedicFirmSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
