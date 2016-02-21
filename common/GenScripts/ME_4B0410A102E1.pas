unit DocumentUserTypes_dftDrugSynchroView_UserType;
 {* �������� ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrugSynchroView_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDrugSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftDrugSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDrugSynchroView';
end;//Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftDrugSynchroView.GetInteger: Integer;
begin
 Result := dftDrugSynchroView;
end;//Tkw_FormUserType_dftDrugSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDrugSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
