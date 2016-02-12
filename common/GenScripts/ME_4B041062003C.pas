unit DocumentUserTypes_dftMedicFirm_UserType;
 {* �������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirm_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrug_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftMedicFirm }
 dftMedicFirmName = 'dftMedicFirm';
  {* ��������� ������������� ����������������� ���� "�������� �����" }
 dftMedicFirm = TvcmUserType(dftDrug + 1);
  {* �������� ����� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedicFirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedicFirm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedicFirm';
end;//Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirm.GetInteger: Integer;
begin
 Result := dftMedicFirm;
end;//Tkw_FormUserType_dftMedicFirm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
