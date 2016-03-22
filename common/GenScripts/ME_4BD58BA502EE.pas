unit ListUserTypes_lftProducedDrugsSynchroForm_UserType;
 {* ���������� �������� (����������� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugsSynchroForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftProducedDrugsSynchroForm" MUID: (4BD58BA502EE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftProducedDrugs_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftProducedDrugsSynchroForm }
 lftProducedDrugsSynchroFormName = 'lftProducedDrugsSynchroForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (����������� ���������)" }
 lftProducedDrugsSynchroForm = TvcmUserType(lftProducedDrugs + 1);
  {* ���������� �������� (����������� ���������) }
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
 Tkw_FormUserType_lftProducedDrugsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftProducedDrugsSynchroForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftProducedDrugsSynchroForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger: Integer;
begin
 Result := lftProducedDrugsSynchroForm;
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger

class function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftProducedDrugsSynchroForm';
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftProducedDrugsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftProducedDrugsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
