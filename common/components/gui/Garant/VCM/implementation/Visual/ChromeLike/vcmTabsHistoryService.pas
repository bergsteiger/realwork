unit vcmTabsHistoryService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmTabsHistoryService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmTabsHistoryService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3ProtoObject,
  vcmHistoryService,
  vcmInterfaces
  ;

type
 TvcmTabsHistoryService = {final} class(Tl3ProtoObject, IvcmHistoryService)
 public
 // realized methods
   function GetContainerHistory(const aContainer: IvcmContainer): IvcmHistory;
   function GetFormHistory(const aForm: IvcmEntityForm): IvcmHistory;
   procedure SaveFormState(const aForm: IvcmEntityForm);
   function IsInBF(const aForm: IvcmEntityForm): Boolean;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmTabsHistoryService;
    {- возвращает экземпляр синглетона. }
 end;//TvcmTabsHistoryService
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base {a},
  l3TabbedContainersDispatcher
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  vcmBase,
  vcmFormSetHistory
  ;


// start class TvcmTabsHistoryService

var g_TvcmTabsHistoryService : TvcmTabsHistoryService = nil;

procedure TvcmTabsHistoryServiceFree;
begin
 l3Free(g_TvcmTabsHistoryService);
end;

class function TvcmTabsHistoryService.Instance: TvcmTabsHistoryService;
begin
 if (g_TvcmTabsHistoryService = nil) then
 begin
  l3System.AddExitProc(TvcmTabsHistoryServiceFree);
  g_TvcmTabsHistoryService := Create;
 end;
 Result := g_TvcmTabsHistoryService;
end;


class function TvcmTabsHistoryService.Exists: Boolean;
 {-}
begin
 Result := g_TvcmTabsHistoryService <> nil;
end;//TvcmTabsHistoryService.Exists

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

function TvcmTabsHistoryService.IsInBF(const aForm: IvcmEntityForm): Boolean;
//#UC START# *A872A2AAB575_559BA3E6014C_var*
//#UC END# *A872A2AAB575_559BA3E6014C_var*
begin
//#UC START# *A872A2AAB575_559BA3E6014C_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.IsInBF(aForm.VCLWinControl as TForm);
//#UC END# *A872A2AAB575_559BA3E6014C_impl*
end;//TvcmTabsHistoryService.IsInBF
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmTabsHistoryService
 {$If not defined(NoVCM)}
 TvcmHistoryService.Instance.Alien := TvcmTabsHistoryService.Instance;
 {$IfEnd} //not NoVCM

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.