unit vcmTabsHistoryService;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabsHistoryService.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmTabsHistoryService" MUID: (559BA3CE0056)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmHistoryService
 , vcmInterfaces
;

type
 TvcmTabsHistoryService = {final} class(Tl3ProtoObject, IvcmHistoryService)
  private
   f_OrgContainer: Pointer;
   f_CloneContainer: Pointer;
  public
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
   function Back(const aForm: IvcmEntityForm): Boolean;
   procedure MakingCloneStarted(const aContainer: IvcmContainer);
   procedure ContainerForCloneMade(const aOrgContainer: IvcmContainer;
    const aCloneContainer: IvcmContainer);
   procedure MakingCloneFinished(const aContainer: IvcmContainer);
   function IsClone(const aContainer: IvcmContainer): Boolean;
   class function Instance: TvcmTabsHistoryService;
    {* Метод получения экземпляра синглетона TvcmTabsHistoryService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmTabsHistoryService
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3TabbedContainersDispatcher
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , vcmBase
 , vcmFormSetHistory
 , l3Base
 //#UC START# *559BA3CE0056impl_uses*
 //#UC END# *559BA3CE0056impl_uses*
;

var g_TvcmTabsHistoryService: TvcmTabsHistoryService = nil;
 {* Экземпляр синглетона TvcmTabsHistoryService }

procedure TvcmTabsHistoryServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmTabsHistoryService }
begin
 l3Free(g_TvcmTabsHistoryService);
end;//TvcmTabsHistoryServiceFree

function TvcmTabsHistoryService.GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
//#UC START# *96E2DB43E67B_559BA3E6014C_var*
var
 l_Form: TForm;
 l_Tab: Il3FormTab;
 l_History: IvcmHistory;
 l_ContainedForm: IvcmContainedForm;
//#UC END# *96E2DB43E67B_559BA3E6014C_var*
begin
//#UC START# *96E2DB43E67B_559BA3E6014C_impl*
 Result := nil;
 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
 begin
  l_Form := TForm(aForm.VCLWinControl);
  l_Tab := Tl3TabbedContainersDispatcher.Instance.GetFormTab(l_Form);
  if (l_Tab <> nil) and
     Supports(l_Tab.TabbedForm, IvcmContainedForm, l_ContainedForm) then
   Result := l_ContainedForm.ContainedFormHistory;
 end;
 if (Result = nil) then
  Result := g_Dispatcher.History;
//#UC END# *96E2DB43E67B_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.GetFormHistory

procedure TvcmTabsHistoryService.SaveFormState(const aForm: IvcmEntityForm);
//#UC START# *975F702287E2_559BA3E6014C_var*
var
 l_History: IvcmHistory;
//#UC END# *975F702287E2_559BA3E6014C_var*
begin
//#UC START# *975F702287E2_559BA3E6014C_impl*
 l_History := GetFormHistory(aForm);
 Assert(l_History <> nil);
 l_History.ForceSaveState(aForm);
//#UC END# *975F702287E2_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.SaveFormState

function TvcmTabsHistoryService.GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
//#UC START# *27BEBF0EE9FD_559BA3E6014C_var*
//#UC END# *27BEBF0EE9FD_559BA3E6014C_var*
begin
//#UC START# *27BEBF0EE9FD_559BA3E6014C_impl*
 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
  Result := GetFormHistory(aContainer.AsForm)
 else
  Result := g_Dispatcher.History;
//#UC END# *27BEBF0EE9FD_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.GetContainerHistory

function TvcmTabsHistoryService.IsInBF(const aForm: IvcmEntityForm): Boolean;
//#UC START# *A872A2AAB575_559BA3E6014C_var*
//#UC END# *A872A2AAB575_559BA3E6014C_var*
begin
//#UC START# *A872A2AAB575_559BA3E6014C_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.IsInBF(aForm.VCLWinControl as TForm);
//#UC END# *A872A2AAB575_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.IsInBF

function TvcmTabsHistoryService.Back(const aForm: IvcmEntityForm): Boolean;
//#UC START# *18FC3BA729CF_559BA3E6014C_var*
var
 l_Tab: Il3FormTab;
 l_TabHistory: IvcmHistory;
//#UC END# *18FC3BA729CF_559BA3E6014C_var*
begin
//#UC START# *18FC3BA729CF_559BA3E6014C_impl*
 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
 begin
  // Если возвращаться некуда - закрываем вкладке
  l_Tab := Tl3TabbedContainersDispatcher.Instance.GetFormTab(TForm(aForm.VCLWinControl));
  Assert(l_Tab <> nil);
  l_TabHistory := GetFormHistory(aForm);
  Assert(l_TabHistory <> nil);
  if l_TabHistory.CanBack then
   l_TabHistory.Back
  else
   Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseTab(l_Tab);
 end
 else
   Result := g_Dispatcher.History.Back;
//#UC END# *18FC3BA729CF_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.Back

procedure TvcmTabsHistoryService.MakingCloneStarted(const aContainer: IvcmContainer);
//#UC START# *03988C3B417F_559BA3E6014C_var*
//#UC END# *03988C3B417F_559BA3E6014C_var*
begin
//#UC START# *03988C3B417F_559BA3E6014C_impl*
 f_OrgContainer := Pointer(aContainer);
 f_CloneContainer := nil;
//#UC END# *03988C3B417F_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.MakingCloneStarted

procedure TvcmTabsHistoryService.ContainerForCloneMade(const aOrgContainer: IvcmContainer;
 const aCloneContainer: IvcmContainer);
//#UC START# *94ACDF598B06_559BA3E6014C_var*
//#UC END# *94ACDF598B06_559BA3E6014C_var*
begin
//#UC START# *94ACDF598B06_559BA3E6014C_impl*
 f_CloneContainer := Pointer(aCloneContainer);
//#UC END# *94ACDF598B06_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.ContainerForCloneMade

procedure TvcmTabsHistoryService.MakingCloneFinished(const aContainer: IvcmContainer);
//#UC START# *19896856BA74_559BA3E6014C_var*
//#UC END# *19896856BA74_559BA3E6014C_var*
begin
//#UC START# *19896856BA74_559BA3E6014C_impl*
 f_OrgContainer := Pointer(aContainer);
 f_CloneContainer := nil;
//#UC END# *19896856BA74_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.MakingCloneFinished

function TvcmTabsHistoryService.IsClone(const aContainer: IvcmContainer): Boolean;
//#UC START# *BB06F1B944C6_559BA3E6014C_var*
//#UC END# *BB06F1B944C6_559BA3E6014C_var*
begin
//#UC START# *BB06F1B944C6_559BA3E6014C_impl*
 Result := f_CloneContainer = Pointer(aContainer);
//#UC END# *BB06F1B944C6_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.IsClone

class function TvcmTabsHistoryService.Instance: TvcmTabsHistoryService;
 {* Метод получения экземпляра синглетона TvcmTabsHistoryService }
begin
 if (g_TvcmTabsHistoryService = nil) then
 begin
  l3System.AddExitProc(TvcmTabsHistoryServiceFree);
  g_TvcmTabsHistoryService := Create;
 end;
 Result := g_TvcmTabsHistoryService;
end;//TvcmTabsHistoryService.Instance

class function TvcmTabsHistoryService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmTabsHistoryService <> nil;
end;//TvcmTabsHistoryService.Exists

initialization
 TvcmHistoryService.Instance.Alien := TvcmTabsHistoryService.Instance;
 {* Регистрация TvcmTabsHistoryService }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
