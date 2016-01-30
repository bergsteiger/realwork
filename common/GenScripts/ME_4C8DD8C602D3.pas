unit PrimTasksPanelMenu_Module;

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\PrimTasksPanelMenu_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmPopupMenuPrim
 , vcmTaskPanelInterfaces
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , PrimCustomizeTasksPanel_Form
 , l3StringIDEx
;

type
 TCustomizeTasksPanelForm = {final} class(TPrimCustomizeTasksPanelForm)
  {* Редактор панели задач }
 end;//TCustomizeTasksPanelForm

 TPrimTasksPanelMenuModule = {abstract} class
  private
   f_PopupMenu: TvcmPopupMenuPrim;
    {* Поле для свойства PopupMenu }
  private
   procedure Customize;
    {* Настройка... }
  protected
   function pm_GetPopupMenu: TvcmPopupMenuPrim;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure CustomizePanel(const aPanel: IvcmCustOps);
    {* Настроить панель иструментов }
   function TasksPanelPopupMenu: TPopupMenu;
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
 , vcmBase
 , SysUtils
 , vcmMenus
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmCustOpsRepGroupList
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , CustomizeTasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

var g_dmTasksPanelMenu: TPrimTasksPanelMenuModule = nil;

const
 {* Локализуемые строки ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : 'Редактор панели задач');
  {* Заголовок пользовательского типа "Редактор панели задач" }

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

procedure TPrimTasksPanelMenuModule.Customize;
 {* Настройка... }
//#UC START# *4C8DD91901C8_4C8DD8C602D3_var*
//#UC END# *4C8DD91901C8_4C8DD8C602D3_var*
begin
//#UC START# *4C8DD91901C8_4C8DD8C602D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8DD91901C8_4C8DD8C602D3_impl*
end;//TPrimTasksPanelMenuModule.Customize

procedure TPrimTasksPanelMenuModule.CustomizePanel(const aPanel: IvcmCustOps);
 {* Настроить панель иструментов }
//#UC START# *4C8E59B80380_4C8DD8C602D3_var*
//#UC END# *4C8E59B80380_4C8DD8C602D3_var*
begin
//#UC START# *4C8E59B80380_4C8DD8C602D3_impl*
  (TCustomizeTasksPanelForm.Make(aPanel, vcmMakeParams, vcm_ztAny).
    VCLWinControl As TCustomForm).ShowModal;
//#UC END# *4C8E59B80380_4C8DD8C602D3_impl*
end;//TPrimTasksPanelMenuModule.CustomizePanel

function TPrimTasksPanelMenuModule.TasksPanelPopupMenu: TPopupMenu;
//#UC START# *4C8F777E02AD_4C8DD8C602D3_var*
//#UC END# *4C8F777E02AD_4C8DD8C602D3_var*
begin
//#UC START# *4C8F777E02AD_4C8DD8C602D3_impl*
 Result := g_dmTasksPanelMenu.PopupMenu;
//#UC END# *4C8F777E02AD_4C8DD8C602D3_impl*
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
 {* Регистрация CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_CustomizeTasksPanelCaption.Init;
 {* Инициализация str_ut_CustomizeTasksPanelCaption }
{$IfEnd} // NOT Defined(NoVCM)

end.
