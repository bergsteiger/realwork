unit BaseWorkJournal_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\BaseWorkJournal_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "BaseWorkJournal" MUID: (4A811C1A0293)
// Имя типа: "TBaseWorkJournalModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkJournalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TBaseWorkJournalModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure opOpenJournalTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenJournalExecute(const aParams: IvcmExecuteParamsPrim);
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeWorkJournal: IbsWorkJournal;
 end;//TBaseWorkJournalModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimWorkJournal_utWorkJournal_UserType
 , bsWorkJournal
 , WorkJournal_Form
 //#UC START# *4A811C1A0293impl_uses*
 , vcmInterfaces
 //#UC END# *4A811C1A0293impl_uses*
;

{$If NOT Defined(NoVCM)}
class function TBaseWorkJournalModule.MakeWorkJournal: IbsWorkJournal;
var
 __WasEnter : Boolean;
//#UC START# *4A827E40004E_4A811C1A0293_var*
//#UC END# *4A827E40004E_4A811C1A0293_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A827E40004E_4A811C1A0293_impl*
 Result := TbsWorkJournal.Make;
//#UC END# *4A827E40004E_4A811C1A0293_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TBaseWorkJournalModule.MakeWorkJournal

procedure TBaseWorkJournalModule.opOpenJournalTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97C7C0019C_4A811C1A0293test_var*
//#UC END# *4A97C7C0019C_4A811C1A0293test_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293test_impl*
// Do nothing
//#UC END# *4A97C7C0019C_4A811C1A0293test_impl*
end;//TBaseWorkJournalModule.opOpenJournalTest

procedure TBaseWorkJournalModule.opOpenJournalExecute(const aParams: IvcmExecuteParamsPrim);
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
end;//TBaseWorkJournalModule.opOpenJournalExecute

procedure TBaseWorkJournalModule.Loaded;
begin
 inherited;
 PublishOp('opOpenJournal', opOpenJournalExecute, opOpenJournalTest);
end;//TBaseWorkJournalModule.Loaded

class procedure TBaseWorkJournalModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TWorkJournalForm);
end;//TBaseWorkJournalModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
