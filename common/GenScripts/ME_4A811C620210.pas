unit WorkJournal_Form;
 {* Журнал работы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\WorkJournal_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "WorkJournal" MUID: (4A811C620210)
// Имя типа: "TWorkJournalForm"

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
  {* Идентификатор формы TWorkJournalForm }

type
 TWorkJournalForm = class;

 WorkJournalFormDef = interface
  {* Идентификатор формы WorkJournal }
  ['{D0739331-5959-49D1-A117-74FAFA0E0939}']
 end;//WorkJournalFormDef

 TWorkJournalForm = {final} class(TPrimWorkJournalOptionsForm, WorkJournalFormDef)
  {* Журнал работы }
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
 {* Регистрация WorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WorkJournalForm.SetFactory(TWorkJournalForm.Make);
 {* Регистрация фабрики формы WorkJournal }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
