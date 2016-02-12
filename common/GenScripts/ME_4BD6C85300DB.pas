unit PrimMedicListSynchroView_mlsfMedicFirm_UserType;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� mlsfMedicFirm }
 mlsfMedicFirmName = 'mlsfMedicFirm';
  {* ��������� ������������� ����������������� ���� "��������" }
 mlsfMedicFirm = TvcmUserType(mlsfDrugList + 1);
  {* �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� mlsfMedicFirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_mlsfMedicFirm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::mlsfMedicFirm';
end;//Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_mlsfMedicFirm.GetInteger: Integer;
begin
 Result := mlsfMedicFirm;
end;//Tkw_FormUserType_mlsfMedicFirm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_mlsfMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
