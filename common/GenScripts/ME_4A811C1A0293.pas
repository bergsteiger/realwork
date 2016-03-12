unit BaseWorkJournal_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\BaseWorkJournal_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkJournalInterfaces
;

type
 TBaseWorkJournalModule = class
  protected
   procedure BaseWorkJournal_OpenJournal_Test(const aParams: IvcmTestParamsPrim);
   procedure BaseWorkJournal_OpenJournal_Execute(const aParams: IvcmExecuteParamsPrim);
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

procedure TBaseWorkJournalModule.BaseWorkJournal_OpenJournal_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97C7C0019C_4A811C1A0293test_var*
//#UC END# *4A97C7C0019C_4A811C1A0293test_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293test_impl*
// Do nothing
//#UC END# *4A97C7C0019C_4A811C1A0293test_impl*
end;//TBaseWorkJournalModule.BaseWorkJournal_OpenJournal_Test

procedure TBaseWorkJournalModule.BaseWorkJournal_OpenJournal_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97C7C0019C_4A811C1A0293exec_var*
var
 l_Window: IvcmEntityForm;
//#UC END# *4A97C7C0019C_4A811C1A0293exec_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293exec_impl*
 l_Window := TWorkJournalForm.MakeSingleChild(DefaultContainer,
                               vcmMakeParams(nil, DefaultContainer),
                               vcm_ztNavigator,
                               Ord(utWorkJournal));
 l_Window.SetActiveInParent;
//#UC END# *4A97C7C0019C_4A811C1A0293exec_impl*
end;//TBaseWorkJournalModule.BaseWorkJournal_OpenJournal_Execute
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
