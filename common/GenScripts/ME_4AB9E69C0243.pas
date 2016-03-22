unit MedicFirmList_Form;
 {* ���������������� ����� (������ ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicFirmList_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "MedicFirmList" MUID: (4AB9E69C0243)
// ��� ����: "Ten_MedicFirmList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicFirmListOptions_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_MedicFirmList = {final} class(TPrimMedicFirmListOptionsForm, MedicFirmListFormDef)
  {* ���������������� ����� (������ ������) }
 end;//Ten_MedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicFirmListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicFirmList);
 {* ����������� MedicFirmList$Form }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicFirmList.SetFactory(Ten_MedicFirmList.Make);
 {* ����������� ������� ����� MedicFirmList$Form }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
