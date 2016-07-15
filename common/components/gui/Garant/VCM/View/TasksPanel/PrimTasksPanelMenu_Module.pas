unit PrimTasksPanelMenu_Module;

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimTasksPanelMenu" MUID: (4C8DD8C602D3)
// Имя типа: "TPrimTasksPanelMenuModule"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmPopupMenuPrim
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmTaskPanelInterfaces
 , Classes
 , vcmBase
 , vcmExternalInterfaces
 , vcmModule
;

type
 TPrimTasksPanelMenuModule = {abstract} class(TvcmModule)
  private
   f_PopupMenu: TvcmPopupMenuPrim;
  private
   procedure opCustomizeExecute(const aParams: IvcmExecuteParamsPrim);
    {* Настройка... }
  protected
   function pm_GetPopupMenu: TvcmPopupMenuPrim;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Loaded; override;
   class procedure GetEntityForms(aList: TvcmClassList); override;
  public
   class procedure CustomizePanel(const aPanel: IvcmCustOps);
    {* Настроить панель иструментов }
   class function TasksPanelPopupMenu: TPopupMenu;
   constructor Create(AOwner: TComponent); override;
  protected
   property PopupMenu: TvcmPopupMenuPrim
    read pm_GetPopupMenu;
 end;//TPrimTasksPanelMenuModule
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmInterfaces
 , SysUtils
 , vcmMenus
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , CustomizeTasksPanel_Form
 //#UC START# *4C8DD8C602D3impl_uses*
 //#UC END# *4C8DD8C602D3impl_uses*
;

var g_dmTasksPanelMenu: TPrimTasksPanelMenuModule = nil;

function TPrimTasksPanelMenuModule.pm_GetPopupMenu: TvcmPopupMenuPrim;
//#UC START# *4C8F78BC0331_4C8DD8C602D3get_var*
//#UC END# *4C8F78BC0331_4C8DD8C602D3get_var*
begin
//#UC START# *4C8F78BC0331_4C8DD8C602D3get_impl*
 if not Assigned(f_PopupMenu) then
 begin
  f_PopupMenu := TvcmPopupMenuPrim.Create(Self);
  // Это нужно чтобы был найден группирующий элемент
  f_PopupMenu.Items.Caption := vcmStr(ModuleDef.ModuleDef.Caption);
  // Контекстные операции модуля
  vcmMakeModuleMenu(f_PopupMenu.Items,
                    ModuleDef.ModuleDef,
                    [{vcm_ooShowInContextMenu}],
                    False);
 end;//if not Assigned(f_PopupMenu) then
 Result := f_PopupMenu;
//#UC END# *4C8F78BC0331_4C8DD8C602D3get_impl*
end;//TPrimTasksPanelMenuModule.pm_GetPopupMenu

procedure TPrimTasksPanelMenuModule.opCustomizeExecute(const aParams: IvcmExecuteParamsPrim);
 {* Настройка... }
//#UC START# *4C8DD91901C8_4C8DD8C602D3exec_var*
var
 l_MainForm: IvcmMainForm;
//#UC END# *4C8DD91901C8_4C8DD8C602D3exec_var*
begin
//#UC START# *4C8DD91901C8_4C8DD8C602D3exec_impl*
 if Supports((aParams As IvcmExecuteParams).Container.NativeMainForm, IvcmMainForm, l_MainForm) then
  CustomizePanel(l_MainForm.TasksPanel)
 else
  Assert(False);
//#UC END# *4C8DD91901C8_4C8DD8C602D3exec_impl*
end;//TPrimTasksPanelMenuModule.opCustomizeExecute

class procedure TPrimTasksPanelMenuModule.CustomizePanel(const aPanel: IvcmCustOps);
 {* Настроить панель иструментов }
var
 __WasEnter : Boolean;
//#UC START# *4C8E59B80380_4C8DD8C602D3_var*
//#UC END# *4C8E59B80380_4C8DD8C602D3_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4C8E59B80380_4C8DD8C602D3_impl*
  (TCustomizeTasksPanelForm.Make(aPanel, vcmMakeParams, vcm_ztAny).
    VCLWinControl As TCustomForm).ShowModal;
//#UC END# *4C8E59B80380_4C8DD8C602D3_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimTasksPanelMenuModule.CustomizePanel

class function TPrimTasksPanelMenuModule.TasksPanelPopupMenu: TPopupMenu;
var
 __WasEnter : Boolean;
//#UC START# *4C8F777E02AD_4C8DD8C602D3_var*
//#UC END# *4C8F777E02AD_4C8DD8C602D3_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4C8F777E02AD_4C8DD8C602D3_impl*
 Result := g_dmTasksPanelMenu.PopupMenu;
//#UC END# *4C8F777E02AD_4C8DD8C602D3_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimTasksPanelMenuModule.TasksPanelPopupMenu

procedure TPrimTasksPanelMenuModule.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C8DD8C602D3_var*
//#UC END# *479731C50290_4C8DD8C602D3_var*
begin
//#UC START# *479731C50290_4C8DD8C602D3_impl*
 g_dmTasksPanelMenu := nil;
 inherited;
//#UC END# *479731C50290_4C8DD8C602D3_impl*
end;//TPrimTasksPanelMenuModule.Cleanup

constructor TPrimTasksPanelMenuModule.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4C8DD8C602D3_var*
//#UC END# *47D1602000C6_4C8DD8C602D3_var*
begin
//#UC START# *47D1602000C6_4C8DD8C602D3_impl*
 inherited;
 //Name := 'vcm_dmTasksPanelMenu';
 Assert(not Assigned(g_dmTasksPanelMenu));
 g_dmTasksPanelMenu := Self;
//#UC END# *47D1602000C6_4C8DD8C602D3_impl*
end;//TPrimTasksPanelMenuModule.Create

procedure TPrimTasksPanelMenuModule.Loaded;
begin
 inherited;
 PublishOp('opCustomize', opCustomizeExecute, nil);
 ShowInToolbar('opCustomize', False);
end;//TPrimTasksPanelMenuModule.Loaded

class procedure TPrimTasksPanelMenuModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TCustomizeTasksPanelForm);
end;//TPrimTasksPanelMenuModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

end.
