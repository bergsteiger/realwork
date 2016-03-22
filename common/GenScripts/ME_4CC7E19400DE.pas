unit PrimWorkJournalOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimWorkJournalOptions" MUID: (4CC7E19400DE)
// ��� ����: "TPrimWorkJournalOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWorkJournal_Form
;

type
 TPrimWorkJournalOptionsForm = class(TPrimWorkJournalForm)
 end;//TPrimWorkJournalOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalOptionsForm);
 {* ����������� PrimWorkJournalOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
