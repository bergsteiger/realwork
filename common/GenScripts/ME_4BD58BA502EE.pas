unit ListUserTypes_lftProducedDrugsSynchroForm_UserType;
 {* ���������� �������� (����������� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugsSynchroForm_UserType.pas"
// ���������: "UserType"

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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftProducedDrugsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftProducedDrugsSynchroForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftProducedDrugsSynchroForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftProducedDrugsSynchroForm';
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger: Integer;
begin
 Result := lftProducedDrugsSynchroForm;
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftProducedDrugsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftProducedDrugsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
