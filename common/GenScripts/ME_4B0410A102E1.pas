unit DocumentUserTypes_dftDrugSynchroView_UserType;
 {* �������� ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrugSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftDrugSynchroView" MUID: (4B0410A102E1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dftDrugSynchroViewLocalConstants }
 str_dftDrugSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewCaption'; rValue : '�������� ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "�������� ��������� (���������� ��������)" }
 str_dftDrugSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� ���������');
  {* ��������� ����������������� ���� "�������� ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftDrugSynchroView }
 dftDrugSynchroViewName = 'dftDrugSynchroView';
  {* ��������� ������������� ����������������� ���� "�������� ��������� (���������� ��������)" }
 dftDrugSynchroView = TvcmUserType(dftMedicFirmSynchroView + 1);
  {* �������� ��������� (���������� ��������) }
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
 Tkw_FormUserType_dftDrugSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDrugSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDrugSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDrugSynchroView.GetInteger: Integer;
begin
 Result := dftDrugSynchroView;
end;//Tkw_FormUserType_dftDrugSynchroView.GetInteger

class function Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDrugSynchroView';
end;//Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftDrugSynchroViewCaption.Init;
 {* ������������� str_dftDrugSynchroViewCaption }
 str_dftDrugSynchroViewSettingsCaption.Init;
 {* ������������� str_dftDrugSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDrugSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
