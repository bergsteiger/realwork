unit Redactions_Form;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Redactions_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Redactions" MUID: (4A8EE2890012)
// ��� ����: "TRedactionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRedactionsOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TRedactionsForm = {final} class(TPrimRedactionsOptionsForm, RedactionsFormDef)
  {* �������� }
 end;//TRedactionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RedactionsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRedactionsForm);
 {* ����������� Redactions }
{$IfEnd} // NOT Defined(NoScripts)
 fm_RedactionsForm.SetFactory(TRedactionsForm.Make);
 {* ����������� ������� ����� Redactions }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
