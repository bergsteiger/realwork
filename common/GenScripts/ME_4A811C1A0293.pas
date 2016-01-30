unit BaseWorkJournal_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\BaseWorkJournal_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkJournalInterfaces
 , PrimWorkJournalOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_WorkJournalForm: TvcmFormDescriptor = (rFormID : (rName : 'WorkJournalForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TWorkJournalForm }

type
 WorkJournalFormDef = interface
  {* Идентификатор формы WorkJournal }
  ['{D0739331-5959-49D1-A117-74FAFA0E0939}']
 end;//WorkJournalFormDef

 TWorkJournalForm = {final} class(TPrimWorkJournalOptionsForm, WorkJournalFormDef)
  {* Журнал работы }
 end;//TWorkJournalForm

 TBaseWorkJournalModule = class
  protected
   procedure OpenJournal;
  public
   function MakeWorkJournal: IbsWorkJournal;
 end;//TBaseWorkJournalModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimWorkJournal_utWorkJournal_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WorkJournalKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , bsWorkJournal
;

function TBaseWorkJournalModule.MakeWorkJournal: IbsWorkJournal;
//#UC START# *4A827E40004E_4A811C1A0293_var*
//#UC END# *4A827E40004E_4A811C1A0293_var*
begin
//#UC START# *4A827E40004E_4A811C1A0293_impl*
 Result := TbsWorkJournal.Make;
//#UC END# *4A827E40004E_4A811C1A0293_impl*
end;//TBaseWorkJournalModule.MakeWorkJournal

procedure TBaseWorkJournalModule.OpenJournal;
//#UC START# *4A97C7C0019C_4A811C1A0293_var*
//#UC END# *4A97C7C0019C_4A811C1A0293_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97C7C0019C_4A811C1A0293_impl*
end;//TBaseWorkJournalModule.OpenJournal

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWorkJournalForm);
 {* Регистрация WorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WorkJournalForm.SetFactory(TWorkJournalForm.Make);
 {* Регистрация фабрики формы WorkJournal }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
