unit PrimWorkJournalOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWorkJournal_Form
;

type
 TPrimWorkJournalOptionsForm = class(TPrimWorkJournalForm)
  public
   procedure OpenQuery; override;
   procedure ExecuteQuery; override;
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

procedure TPrimWorkJournalOptionsForm.OpenQuery;
//#UC START# *4C3F3421036A_4CC7E19400DE_var*
//#UC END# *4C3F3421036A_4CC7E19400DE_var*
begin
//#UC START# *4C3F3421036A_4CC7E19400DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F3421036A_4CC7E19400DE_impl*
end;//TPrimWorkJournalOptionsForm.OpenQuery

procedure TPrimWorkJournalOptionsForm.ExecuteQuery;
//#UC START# *4C3F342E02AF_4CC7E19400DE_var*
//#UC END# *4C3F342E02AF_4CC7E19400DE_var*
begin
//#UC START# *4C3F342E02AF_4CC7E19400DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F342E02AF_4CC7E19400DE_impl*
end;//TPrimWorkJournalOptionsForm.ExecuteQuery

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalOptionsForm);
 {* Регистрация PrimWorkJournalOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
