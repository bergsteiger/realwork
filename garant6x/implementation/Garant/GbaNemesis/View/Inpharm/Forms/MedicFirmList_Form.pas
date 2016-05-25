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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_MedicFirmList = {final} class(TPrimMedicFirmListOptionsForm, MedicFirmListFormDef)
  {* ���������������� ����� (������ ������) }
   Entities : TvcmEntities;
 end;//Ten_MedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MedicFirmListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_en_MedicFirmList.SetFactory(Ten_MedicFirmList.Make);
 {* ����������� ������� ����� MedicFirmList$Form }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicFirmList);
 {* ����������� MedicFirmList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
