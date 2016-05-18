unit WorkJournal_Form;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\WorkJournal_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "WorkJournal" MUID: (4A811C620210)
// ��� ����: "TWorkJournalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWorkJournalOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_WorkJournalForm: TvcmFormDescriptor = (rFormID : (rName : 'WorkJournalForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TWorkJournalForm }

type
 TWorkJournalForm = class;

 WorkJournalFormDef = interface
  {* ������������� ����� WorkJournal }
  ['{D0739331-5959-49D1-A117-74FAFA0E0939}']
 end;//WorkJournalFormDef

 TWorkJournalForm = {final} class(TPrimWorkJournalOptionsForm, WorkJournalFormDef)
  {* ������ ������ }
 end;//TWorkJournalForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , WorkJournalKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWorkJournalForm);
 {* ����������� WorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WorkJournalForm.SetFactory(TWorkJournalForm.Make);
 {* ����������� ������� ����� WorkJournal }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
