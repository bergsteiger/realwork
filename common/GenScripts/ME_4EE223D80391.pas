unit SynchroView_WarningBaloon_Form;
 {* ������ � ��������������� ��� ��������� � ���������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroView_WarningBaloon_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "SynchroView_WarningBaloon" MUID: (4EE223D80391)
// ��� ����: "TSynchroView_WarningBaloonForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningBaloonOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSynchroView_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, SynchroView_WarningBaloonFormDef)
  {* ������ � ��������������� ��� ��������� � ���������� ��������� }
   Entities : TvcmEntities;
 end;//TSynchroView_WarningBaloonForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SynchroView_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSynchroView_WarningBaloonForm);
 {* ����������� SynchroView_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_SynchroView_WarningBaloonForm.SetFactory(TSynchroView_WarningBaloonForm.Make);
 {* ����������� ������� ����� SynchroView_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
