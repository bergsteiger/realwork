unit PrimTasksPanelMenu_Module;

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "PrimTasksPanelMenu" MUID: (4C8DD8C602D3)
// ��� ����: "TPrimTasksPanelMenuModule"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmPopupMenuPrim
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
    {* ���������... }
  protected
   function pm_GetPopupMenu: TvcmPopupMenuPrim;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure Loaded; override;
   class procedure GetEntityForms(aList: TvcmClassList); override;
  public
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
 , l3ProtoObject
 , VCMCustomization_Customization_Contracts
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmTaskPanelInterfaces
 , vcmInterfaces
 , SysUtils
 , vcmMenus
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 , CustomizeTasksPanel_Form
 //#UC START# *4C8DD8C602D3impl_uses*
 //#UC END# *4C8DD8C602D3impl_uses*
;

type
 TTaskPanelServiceImpl = {final} class(Tl3ProtoObject, ITaskPanelService)
  public
   procedure CustomizePanel(const aPanel: IvcmCustOps);
    {* ��������� ������ ����������� }
   function TasksPanelPopupMenu: TPopupMenu;
   class function Instance: TTaskPanelServiceImpl;
    {* ����� ��������� ���������� ���������� TTaskPanelServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TTaskPanelServiceImpl

var g_TTaskPanelServiceImpl: TTaskPanelServiceImpl = nil;
 {* ��������� ���������� TTaskPanelServiceImpl }
var g_dmTasksPanelMenu: TPrimTasksPanelMenuModule = nil;

procedure TTaskPanelServiceImplFree;
 {* ����� ������������ ���������� ���������� TTaskPanelServiceImpl }
begin
 l3Free(g_TTaskPanelServiceImpl);
end;//TTaskPanelServiceImplFree

procedure TTaskPanelServiceImpl.CustomizePanel(const aPanel: IvcmCustOps);
 {* ��������� ������ ����������� }
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
end;//TTaskPanelServiceImpl.CustomizePanel

function TTaskPanelServiceImpl.TasksPanelPopupMenu: TPopupMenu;
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
end;//TTaskPanelServiceImpl.TasksPanelPopupMenu

class function TTaskPanelServiceImpl.Instance: TTaskPanelServiceImpl;
 {* ����� ��������� ���������� ���������� TTaskPanelServiceImpl }
begin
 if (g_TTaskPanelServiceImpl = nil) then
 begin
  l3System.AddExitProc(TTaskPanelServiceImplFree);
  g_TTaskPanelServiceImpl := Create;
 end;
 Result := g_TTaskPanelServiceImpl;
end;//TTaskPanelServiceImpl.Instance

class function TTaskPanelServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TTaskPanelServiceImpl <> nil;
end;//TTaskPanelServiceImpl.Exists

function TPrimTasksPanelMenuModule.pm_GetPopupMenu: TvcmPopupMenuPrim;
//#UC START# *4C8F78BC0331_4C8DD8C602D3get_var*
//#UC END# *4C8F78BC0331_4C8DD8C602D3get_var*
begin
//#UC START# *4C8F78BC0331_4C8DD8C602D3get_impl*
 if not Assigned(f_PopupMenu) then
 begin
  f_PopupMenu := TvcmPopupMenuPrim.Create(Self);
  // ��� ����� ����� ��� ������ ������������ �������
  f_PopupMenu.Items.Caption := vcmStr(ModuleDef.ModuleDef.Caption);
  // ����������� �������� ������
  vcmMakeModuleMenu(f_PopupMenu.Items,
                    ModuleDef.ModuleDef,
                    [{vcm_ooShowInContextMenu}],
                    False);
 end;//if not Assigned(f_PopupMenu) then
 Result := f_PopupMenu;
//#UC END# *4C8F78BC0331_4C8DD8C602D3get_impl*
end;//TPrimTasksPanelMenuModule.pm_GetPopupMenu

procedure TPrimTasksPanelMenuModule.opCustomizeExecute(const aParams: IvcmExecuteParamsPrim);
 {* ���������... }
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

procedure TPrimTasksPanelMenuModule.Cleanup;
 {* ������� ������� ����� �������. }
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

initialization
 TTaskPanelService.Instance.Alien := TTaskPanelServiceImpl.Instance;
 {* ����������� TTaskPanelServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

end.
