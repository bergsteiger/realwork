unit PrimMedicListSynchroView_mlsfMedicFirm_UserType;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas"
// ���������: "UserType"
// ������� ������: "mlsfMedicFirm" MUID: (4BD6C85300DB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ mlsfMedicFirmLocalConstants }
 str_mlsfMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfMedicFirmCaption'; rValue : '��������');
  {* ��������� ����������������� ���� "��������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_mlsfMedicFirm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� mlsfMedicFirm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_mlsfMedicFirm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mlsfMedicFirm.GetInteger: Integer;
begin
 Result := mlsfMedicFirm;
end;//Tkw_FormUserType_mlsfMedicFirm.GetInteger

class function Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::mlsfMedicFirm';
end;//Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_mlsfMedicFirmCaption.Init;
 {* ������������� str_mlsfMedicFirmCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_mlsfMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
