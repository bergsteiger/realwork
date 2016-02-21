unit MedicListSynchroView_Form;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicListSynchroView_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_MedicListSynchroView = {final} class(TPrimMedicListSynchroViewForm, MedicListSynchroViewFormDef)
  {* ���������� �������� }
 end;//Ten_MedicListSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicListSynchroViewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicListSynchroView);
 {* ����������� MedicListSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicListSynchroView.SetFactory(Ten_MedicListSynchroView.Make);
 {* ����������� ������� ����� MedicListSynchroView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
