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
  private
   procedure opOpenJournalTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenJournalExecute(const aParams: IvcmExecuteParamsPrim);
  protected
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TBaseWorkJournalModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , WorkJournalInterfaces
 , PrimWorkJournal_utWorkJournal_UserType
 , bsWorkJournal
 , SysUtils
 , l3Base
 , WorkJournal_Form
 //#UC START# *4A811C1A0293impl_uses*
 , vcmInterfaces
 //#UC END# *4A811C1A0293impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TWorkJournalServiceImpl = {final} class(TvcmModuleContractImplementation, IWorkJournalService)
  public
   function MakeWorkJournal: IbsWorkJournal;
   class function Instance: TWorkJournalServiceImpl;
    {* Метод получения экземпляра синглетона TWorkJournalServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TWorkJournalServiceImpl

var g_TWorkJournalServiceImpl: TWorkJournalServiceImpl = nil;
 {* Экземпляр синглетона TWorkJournalServiceImpl }

procedure TWorkJournalServiceImplFree;
 {* Метод освобождения экземпляра синглетона TWorkJournalServiceImpl }
begin
 l3Free(g_TWorkJournalServiceImpl);
end;//TWorkJournalServiceImplFree

function TWorkJournalServiceImpl.MakeWorkJournal: IbsWorkJournal;
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
end;//TWorkJournalServiceImpl.MakeWorkJournal

class function TWorkJournalServiceImpl.Instance: TWorkJournalServiceImpl;
 {* Метод получения экземпляра синглетона TWorkJournalServiceImpl }
begin
 if (g_TWorkJournalServiceImpl = nil) then
 begin
  l3System.AddExitProc(TWorkJournalServiceImplFree);
  g_TWorkJournalServiceImpl := Create;
 end;
 Result := g_TWorkJournalServiceImpl;
end;//TWorkJournalServiceImpl.Instance

class function TWorkJournalServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TWorkJournalServiceImpl <> nil;
end;//TWorkJournalServiceImpl.Exists

procedure TBaseWorkJournalModule.opOpenJournalTest(const aParams: IvcmTestParamsPrim);
//#UC START# *579F752900CF_4A811C1A0293test_var*
//#UC END# *579F752900CF_4A811C1A0293test_var*
begin
//#UC START# *579F752900CF_4A811C1A0293test_impl*
// Do nothing
//#UC END# *579F752900CF_4A811C1A0293test_impl*
end;//TBaseWorkJournalModule.opOpenJournalTest

procedure TBaseWorkJournalModule.opOpenJournalExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *579F752900CF_4A811C1A0293exec_var*
var
 l_Window: IvcmEntityForm;
//#UC END# *579F752900CF_4A811C1A0293exec_var*
begin
//#UC START# *579F752900CF_4A811C1A0293exec_impl*
 l_Window := TWorkJournalForm.MakeSingleChild(DefaultContainer,
                               vcmMakeParams(nil, DefaultContainer),
                               vcm_ztNavigator,
                               Ord(utWorkJournal));
 l_Window.SetActiveInParent;
//#UC END# *579F752900CF_4A811C1A0293exec_impl*
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

initialization
 TWorkJournalService.Instance.Alien := TWorkJournalServiceImpl.Instance;
 {* Регистрация TWorkJournalServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
