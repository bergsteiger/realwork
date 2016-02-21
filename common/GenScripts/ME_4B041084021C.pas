unit DocumentUserTypes_dftMedicFirmSynchroView_UserType;
 {* �������� ����� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirmSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedicFirmSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedicFirmSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedicFirmSynchroView';
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger: Integer;
begin
 Result := dftMedicFirmSynchroView;
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirmSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedicFirmSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
