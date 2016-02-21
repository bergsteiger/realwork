unit vcmTabbedContainersService;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmTabbedContainersService.pas"
// Стереотип: "Service"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

 (*
 MvcmTabbedContainersService = interface(Ml3TabbedContainersDispatcher)
  function GetCurrentMainForm: TWinControl;
 end;//MvcmTabbedContainersService
 *)

type
 TvcmTabbedContainersDispatcher = {final} class(Tl3ProtoObject, Il3TabbedContainersDispatcher)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function GetTabIcon(const aTab: Il3FormTab): Integer;
   function IsInBF(aContainedForm: TForm): Boolean;
   function GetTabCaption(const aTab: Il3FormTab): AnsiString;
   procedure CloseTab(const aTab: Il3FormTab);
   procedure Subscribe(const aListener: Il3TabbedContainersListener);
   procedure Lock;
   procedure UnlockContainer(const aContainer: Il3TabbedContainer);
   function GetActiveTabbedContainer: Il3TabbedContainer;
   procedure StopFlashing;
   function CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
   procedure CascadeWindows;
   procedure ReopenClosedTab(const aContainer: Il3TabbedContainer);
   procedure LockContainer(const aContainer: Il3TabbedContainer);
   procedure Unsubscribe(const aListener: Il3TabbedContainersListener);
   function IsFormInContainer(aForm: TForm;
    aContainer: TForm): Boolean;
   procedure TileWindowsHorizontal;
   function IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
   procedure ActivateForm(aForm: TForm);
   function NeedUseTabs: Boolean;
   procedure TileWindowsVertical;
   procedure ContainedFormBecomeActive(aForm: TForm);
   function IsTabEmpty(const aTab: Il3FormTab): Boolean;
   function CloneTab(const aTab: Il3FormTab): Il3FormTab;
   function GetFormTab(aForm: TForm): Il3FormTab;
   procedure Unlock;
   function CanCloneTab(const aTab: Il3FormTab): Boolean;
   procedure StartFlashing;
   procedure SaveTabToHistory(const aTab: Il3FormTab);
   procedure CloseAll;
   class function Instance: TvcmTabbedContainersDispatcher;
    {* Метод получения экземпляра синглетона TvcmTabbedContainersDispatcher }
 end;//TvcmTabbedContainersDispatcher

 IvcmTabbedContainersService = interface
  {* Интерфейс сервиса TvcmTabbedContainersService }
  ['{6167A81B-B284-49FD-A747-69B65256A05C}']
  function GetCurrentMainForm: TWinControl;
  procedure Subscribe(const aListener: Il3TabbedContainersListener);
  procedure Unsubscribe(const aListener: Il3TabbedContainersListener);
  function NeedUseTabs: Boolean;
  procedure StartFlashing;
  procedure StopFlashing;
  procedure CloseAll;
  procedure CascadeWindows;
  procedure TileWindowsHorizontal;
  procedure TileWindowsVertical;
  function IsFormInContainer(aForm: TForm;
   aContainer: TForm): Boolean;
  procedure Lock;
  procedure Unlock;
  procedure ActivateForm(aForm: TForm);
  function CloneTab(const aTab: Il3FormTab): Il3FormTab;
  function CanCloneTab(const aTab: Il3FormTab): Boolean;
  procedure ReopenClosedTab(const aContainer: Il3TabbedContainer);
  function CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
  procedure SaveTabToHistory(const aTab: Il3FormTab);
  procedure LockContainer(const aContainer: Il3TabbedContainer);
  procedure UnlockContainer(const aContainer: Il3TabbedContainer);
  function IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
  procedure CloseTab(const aTab: Il3FormTab);
  function GetFormTab(aForm: TForm): Il3FormTab;
  function IsTabEmpty(const aTab: Il3FormTab): Boolean;
  function GetActiveTabbedContainer: Il3TabbedContainer;
  function IsInBF(aContainedForm: TForm): Boolean;
  function GetTabIcon(const aTab: Il3FormTab): Integer;
  procedure ContainedFormBecomeActive(aForm: TForm);
  function GetTabCaption(const aTab: Il3FormTab): AnsiString;
 end;//IvcmTabbedContainersService

 TvcmTabbedContainersService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmTabbedContainersService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: IvcmTabbedContainersService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function GetTabIcon(const aTab: Il3FormTab): Integer;
   function IsInBF(aContainedForm: TForm): Boolean;
   function GetTabCaption(const aTab: Il3FormTab): AnsiString;
   procedure CloseTab(const aTab: Il3FormTab);
   procedure Subscribe(const aListener: Il3TabbedContainersListener);
   procedure Lock;
   procedure UnlockContainer(const aContainer: Il3TabbedContainer);
   function GetActiveTabbedContainer: Il3TabbedContainer;
   procedure StopFlashing;
   function CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
   procedure CascadeWindows;
   procedure ReopenClosedTab(const aContainer: Il3TabbedContainer);
   procedure LockContainer(const aContainer: Il3TabbedContainer);
   procedure Unsubscribe(const aListener: Il3TabbedContainersListener);
   function GetCurrentMainForm: TWinControl;
   function IsFormInContainer(aForm: TForm;
    aContainer: TForm): Boolean;
   procedure TileWindowsHorizontal;
   function IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
   procedure ActivateForm(aForm: TForm);
   function NeedUseTabs: Boolean;
   procedure TileWindowsVertical;
   procedure ContainedFormBecomeActive(aForm: TForm);
   function IsTabEmpty(const aTab: Il3FormTab): Boolean;
   function CloneTab(const aTab: Il3FormTab): Il3FormTab;
   function GetFormTab(aForm: TForm): Il3FormTab;
   procedure Unlock;
   function CanCloneTab(const aTab: Il3FormTab): Boolean;
   procedure StartFlashing;
   procedure SaveTabToHistory(const aTab: Il3FormTab);
   procedure CloseAll;
   class function Instance: TvcmTabbedContainersService;
    {* Метод получения экземпляра синглетона TvcmTabbedContainersService }
  public
   property Alien: IvcmTabbedContainersService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmTabbedContainersService }
 end;//TvcmTabbedContainersService
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmExternalInterfaces
 , SysUtils
 , vcmBase
 {$If NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
 , vcmTabsWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoTabs)
 , l3Base
;

var g_TvcmTabbedContainersDispatcher: TvcmTabbedContainersDispatcher = nil;
 {* Экземпляр синглетона TvcmTabbedContainersDispatcher }
var g_TvcmTabbedContainersService: TvcmTabbedContainersService = nil;
 {* Экземпляр синглетона TvcmTabbedContainersService }

procedure TvcmTabbedContainersDispatcherFree;
 {* Метод освобождения экземпляра синглетона TvcmTabbedContainersDispatcher }
begin
 l3Free(g_TvcmTabbedContainersDispatcher);
end;//TvcmTabbedContainersDispatcherFree

procedure TvcmTabbedContainersServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmTabbedContainersService }
begin
 l3Free(g_TvcmTabbedContainersService);
end;//TvcmTabbedContainersServiceFree

class function TvcmTabbedContainersDispatcher.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmTabbedContainersDispatcher <> nil;
end;//TvcmTabbedContainersDispatcher.Exists

function TvcmTabbedContainersDispatcher.GetTabIcon(const aTab: Il3FormTab): Integer;
//#UC START# *02157F96E465_5539E9010272_var*
//#UC END# *02157F96E465_5539E9010272_var*
begin
//#UC START# *02157F96E465_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.GetTabIcon(aTab);
//#UC END# *02157F96E465_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.GetTabIcon

function TvcmTabbedContainersDispatcher.IsInBF(aContainedForm: TForm): Boolean;
//#UC START# *06D14140190A_5539E9010272_var*
//#UC END# *06D14140190A_5539E9010272_var*
begin
//#UC START# *06D14140190A_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.IsInBF(aContainedForm);
//#UC END# *06D14140190A_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.IsInBF

function TvcmTabbedContainersDispatcher.GetTabCaption(const aTab: Il3FormTab): AnsiString;
//#UC START# *086A3DF2665B_5539E9010272_var*
//#UC END# *086A3DF2665B_5539E9010272_var*
begin
//#UC START# *086A3DF2665B_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.GetTabCaption(aTab);
//#UC END# *086A3DF2665B_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.GetTabCaption

procedure TvcmTabbedContainersDispatcher.CloseTab(const aTab: Il3FormTab);
//#UC START# *0E111B36F193_5539E9010272_var*
//#UC END# *0E111B36F193_5539E9010272_var*
begin
//#UC START# *0E111B36F193_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.CloseTab(aTab);
//#UC END# *0E111B36F193_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CloseTab

procedure TvcmTabbedContainersDispatcher.Subscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *1561A6522B5C_5539E9010272_var*
//#UC END# *1561A6522B5C_5539E9010272_var*
begin
//#UC START# *1561A6522B5C_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.Subscribe(aListener);
//#UC END# *1561A6522B5C_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.Subscribe

procedure TvcmTabbedContainersDispatcher.Lock;
//#UC START# *185C64EF3184_5539E9010272_var*
//#UC END# *185C64EF3184_5539E9010272_var*
begin
//#UC START# *185C64EF3184_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.Lock;
//#UC END# *185C64EF3184_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.Lock

procedure TvcmTabbedContainersDispatcher.UnlockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *1BFA5AA0644C_5539E9010272_var*
//#UC END# *1BFA5AA0644C_5539E9010272_var*
begin
//#UC START# *1BFA5AA0644C_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.UnlockContainer(aContainer);
//#UC END# *1BFA5AA0644C_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.UnlockContainer

function TvcmTabbedContainersDispatcher.GetActiveTabbedContainer: Il3TabbedContainer;
//#UC START# *2774A286694A_5539E9010272_var*
//#UC END# *2774A286694A_5539E9010272_var*
begin
//#UC START# *2774A286694A_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.GetActiveTabbedContainer;
//#UC END# *2774A286694A_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.GetActiveTabbedContainer

procedure TvcmTabbedContainersDispatcher.StopFlashing;
//#UC START# *2A43AA8AA799_5539E9010272_var*
//#UC END# *2A43AA8AA799_5539E9010272_var*
begin
//#UC START# *2A43AA8AA799_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.StopFlashing;
//#UC END# *2A43AA8AA799_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.StopFlashing

function TvcmTabbedContainersDispatcher.CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *2EC8C1E48517_5539E9010272_var*
//#UC END# *2EC8C1E48517_5539E9010272_var*
begin
//#UC START# *2EC8C1E48517_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.CanReopenClosedTab(aContainer);
//#UC END# *2EC8C1E48517_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CanReopenClosedTab

procedure TvcmTabbedContainersDispatcher.CascadeWindows;
//#UC START# *3F5E73D5D2B0_5539E9010272_var*
//#UC END# *3F5E73D5D2B0_5539E9010272_var*
begin
//#UC START# *3F5E73D5D2B0_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.CascadeWindows;
//#UC END# *3F5E73D5D2B0_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CascadeWindows

procedure TvcmTabbedContainersDispatcher.ReopenClosedTab(const aContainer: Il3TabbedContainer);
//#UC START# *424D166E6D0C_5539E9010272_var*
//#UC END# *424D166E6D0C_5539E9010272_var*
begin
//#UC START# *424D166E6D0C_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.ReopenClosedTab(aContainer);
//#UC END# *424D166E6D0C_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.ReopenClosedTab

procedure TvcmTabbedContainersDispatcher.LockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *44A2D9FC0500_5539E9010272_var*
//#UC END# *44A2D9FC0500_5539E9010272_var*
begin
//#UC START# *44A2D9FC0500_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.LockContainer(aContainer);
//#UC END# *44A2D9FC0500_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.LockContainer

procedure TvcmTabbedContainersDispatcher.Unsubscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *4526B341C1C6_5539E9010272_var*
//#UC END# *4526B341C1C6_5539E9010272_var*
begin
//#UC START# *4526B341C1C6_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.Unsubscribe(aListener);
//#UC END# *4526B341C1C6_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.Unsubscribe

function TvcmTabbedContainersDispatcher.IsFormInContainer(aForm: TForm;
 aContainer: TForm): Boolean;
//#UC START# *5E78F22AF1FF_5539E9010272_var*
//#UC END# *5E78F22AF1FF_5539E9010272_var*
begin
//#UC START# *5E78F22AF1FF_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.IsFormInContainer(aForm, aContainer);
//#UC END# *5E78F22AF1FF_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.IsFormInContainer

procedure TvcmTabbedContainersDispatcher.TileWindowsHorizontal;
//#UC START# *651C515DADEE_5539E9010272_var*
//#UC END# *651C515DADEE_5539E9010272_var*
begin
//#UC START# *651C515DADEE_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.TileWindowsHorizontal;
//#UC END# *651C515DADEE_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.TileWindowsHorizontal

function TvcmTabbedContainersDispatcher.IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *89B204B9A81A_5539E9010272_var*
//#UC END# *89B204B9A81A_5539E9010272_var*
begin
//#UC START# *89B204B9A81A_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.IsContainerLocked(aContainer);
//#UC END# *89B204B9A81A_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.IsContainerLocked

procedure TvcmTabbedContainersDispatcher.ActivateForm(aForm: TForm);
//#UC START# *94E9E4364244_5539E9010272_var*
//#UC END# *94E9E4364244_5539E9010272_var*
begin
//#UC START# *94E9E4364244_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.ActivateForm(aForm);
//#UC END# *94E9E4364244_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.ActivateForm

function TvcmTabbedContainersDispatcher.NeedUseTabs: Boolean;
//#UC START# *9584664239A7_5539E9010272_var*
//#UC END# *9584664239A7_5539E9010272_var*
begin
//#UC START# *9584664239A7_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.NeedUseTabs;
//#UC END# *9584664239A7_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.NeedUseTabs

procedure TvcmTabbedContainersDispatcher.TileWindowsVertical;
//#UC START# *9D76EEC368A2_5539E9010272_var*
//#UC END# *9D76EEC368A2_5539E9010272_var*
begin
//#UC START# *9D76EEC368A2_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.TileWindowsVertical;
//#UC END# *9D76EEC368A2_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.TileWindowsVertical

procedure TvcmTabbedContainersDispatcher.ContainedFormBecomeActive(aForm: TForm);
//#UC START# *AEF0183D2054_5539E9010272_var*
//#UC END# *AEF0183D2054_5539E9010272_var*
begin
//#UC START# *AEF0183D2054_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.ContainedFormBecomeActive(aForm);
//#UC END# *AEF0183D2054_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.ContainedFormBecomeActive

function TvcmTabbedContainersDispatcher.IsTabEmpty(const aTab: Il3FormTab): Boolean;
//#UC START# *BFD6868132D2_5539E9010272_var*
//#UC END# *BFD6868132D2_5539E9010272_var*
begin
//#UC START# *BFD6868132D2_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.IsTabEmpty(aTab);
//#UC END# *BFD6868132D2_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.IsTabEmpty

function TvcmTabbedContainersDispatcher.CloneTab(const aTab: Il3FormTab): Il3FormTab;
//#UC START# *CA81A004E69C_5539E9010272_var*
//#UC END# *CA81A004E69C_5539E9010272_var*
begin
//#UC START# *CA81A004E69C_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.CloneTab(aTab);
//#UC END# *CA81A004E69C_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CloneTab

function TvcmTabbedContainersDispatcher.GetFormTab(aForm: TForm): Il3FormTab;
//#UC START# *E6CFFF63C7BA_5539E9010272_var*
//#UC END# *E6CFFF63C7BA_5539E9010272_var*
begin
//#UC START# *E6CFFF63C7BA_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.GetFormTab(aForm);
//#UC END# *E6CFFF63C7BA_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.GetFormTab

procedure TvcmTabbedContainersDispatcher.Unlock;
//#UC START# *E781A200DBB9_5539E9010272_var*
//#UC END# *E781A200DBB9_5539E9010272_var*
begin
//#UC START# *E781A200DBB9_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.Unlock;
//#UC END# *E781A200DBB9_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.Unlock

function TvcmTabbedContainersDispatcher.CanCloneTab(const aTab: Il3FormTab): Boolean;
//#UC START# *EE61E6DE4383_5539E9010272_var*
//#UC END# *EE61E6DE4383_5539E9010272_var*
begin
//#UC START# *EE61E6DE4383_5539E9010272_impl*
 Result := TvcmTabbedContainersService.Instance.CanCloneTab(aTab);
//#UC END# *EE61E6DE4383_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CanCloneTab

procedure TvcmTabbedContainersDispatcher.StartFlashing;
//#UC START# *F09F327B084A_5539E9010272_var*
//#UC END# *F09F327B084A_5539E9010272_var*
begin
//#UC START# *F09F327B084A_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.StartFlashing;
//#UC END# *F09F327B084A_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.StartFlashing

procedure TvcmTabbedContainersDispatcher.SaveTabToHistory(const aTab: Il3FormTab);
//#UC START# *F2A394FBFE56_5539E9010272_var*
//#UC END# *F2A394FBFE56_5539E9010272_var*
begin
//#UC START# *F2A394FBFE56_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.SaveTabToHistory(aTab);
//#UC END# *F2A394FBFE56_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.SaveTabToHistory

procedure TvcmTabbedContainersDispatcher.CloseAll;
//#UC START# *F550802110EC_5539E9010272_var*
//#UC END# *F550802110EC_5539E9010272_var*
begin
//#UC START# *F550802110EC_5539E9010272_impl*
 TvcmTabbedContainersService.Instance.CloseAll;
//#UC END# *F550802110EC_5539E9010272_impl*
end;//TvcmTabbedContainersDispatcher.CloseAll

class function TvcmTabbedContainersDispatcher.Instance: TvcmTabbedContainersDispatcher;
 {* Метод получения экземпляра синглетона TvcmTabbedContainersDispatcher }
begin
 if (g_TvcmTabbedContainersDispatcher = nil) then
 begin
  l3System.AddExitProc(TvcmTabbedContainersDispatcherFree);
  g_TvcmTabbedContainersDispatcher := Create;
 end;
 Result := g_TvcmTabbedContainersDispatcher;
end;//TvcmTabbedContainersDispatcher.Instance

procedure TvcmTabbedContainersService.pm_SetAlien(const aValue: IvcmTabbedContainersService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmTabbedContainersService.pm_SetAlien

class function TvcmTabbedContainersService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmTabbedContainersService <> nil;
end;//TvcmTabbedContainersService.Exists

function TvcmTabbedContainersService.GetTabIcon(const aTab: Il3FormTab): Integer;
//#UC START# *02157F96E465_5538940C00DD_var*
//#UC END# *02157F96E465_5538940C00DD_var*
begin
//#UC START# *02157F96E465_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetTabIcon(aTab)
 else
  Result := -1;
//#UC END# *02157F96E465_5538940C00DD_impl*
end;//TvcmTabbedContainersService.GetTabIcon

function TvcmTabbedContainersService.IsInBF(aContainedForm: TForm): Boolean;
//#UC START# *06D14140190A_5538940C00DD_var*
//#UC END# *06D14140190A_5538940C00DD_var*
begin
//#UC START# *06D14140190A_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsInBF(aContainedForm)
 else
  Result := False;
//#UC END# *06D14140190A_5538940C00DD_impl*
end;//TvcmTabbedContainersService.IsInBF

function TvcmTabbedContainersService.GetTabCaption(const aTab: Il3FormTab): AnsiString;
//#UC START# *086A3DF2665B_5538940C00DD_var*
//#UC END# *086A3DF2665B_5538940C00DD_var*
begin
//#UC START# *086A3DF2665B_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetTabCaption(aTab)
 else
  Result := '<заголовок вкладки>';
//#UC END# *086A3DF2665B_5538940C00DD_impl*
end;//TvcmTabbedContainersService.GetTabCaption

procedure TvcmTabbedContainersService.CloseTab(const aTab: Il3FormTab);
//#UC START# *0E111B36F193_5538940C00DD_var*
//#UC END# *0E111B36F193_5538940C00DD_var*
begin
//#UC START# *0E111B36F193_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.CloseTab(aTab);
//#UC END# *0E111B36F193_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CloseTab

procedure TvcmTabbedContainersService.Subscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *1561A6522B5C_5538940C00DD_var*
//#UC END# *1561A6522B5C_5538940C00DD_var*
begin
//#UC START# *1561A6522B5C_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.Subscribe(aListener);
//#UC END# *1561A6522B5C_5538940C00DD_impl*
end;//TvcmTabbedContainersService.Subscribe

procedure TvcmTabbedContainersService.Lock;
//#UC START# *185C64EF3184_5538940C00DD_var*
//#UC END# *185C64EF3184_5538940C00DD_var*
begin
//#UC START# *185C64EF3184_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.Lock;
//#UC END# *185C64EF3184_5538940C00DD_impl*
end;//TvcmTabbedContainersService.Lock

procedure TvcmTabbedContainersService.UnlockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *1BFA5AA0644C_5538940C00DD_var*
//#UC END# *1BFA5AA0644C_5538940C00DD_var*
begin
//#UC START# *1BFA5AA0644C_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.UnlockContainer(aContainer);
//#UC END# *1BFA5AA0644C_5538940C00DD_impl*
end;//TvcmTabbedContainersService.UnlockContainer

function TvcmTabbedContainersService.GetActiveTabbedContainer: Il3TabbedContainer;
//#UC START# *2774A286694A_5538940C00DD_var*
//#UC END# *2774A286694A_5538940C00DD_var*
begin
//#UC START# *2774A286694A_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetActiveTabbedContainer;
//#UC END# *2774A286694A_5538940C00DD_impl*
end;//TvcmTabbedContainersService.GetActiveTabbedContainer

procedure TvcmTabbedContainersService.StopFlashing;
//#UC START# *2A43AA8AA799_5538940C00DD_var*
var
 l_FlashingForm: IvcmFlashingWindow;
//#UC END# *2A43AA8AA799_5538940C00DD_var*
begin
//#UC START# *2A43AA8AA799_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.StopFlashing
 else
 begin
  if Supports(GetCurrentMainForm, IvcmFlashingWindow, l_FlashingForm) then
   l_FlashingForm.StopFlashing;
 end;
//#UC END# *2A43AA8AA799_5538940C00DD_impl*
end;//TvcmTabbedContainersService.StopFlashing

function TvcmTabbedContainersService.CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *2EC8C1E48517_5538940C00DD_var*
//#UC END# *2EC8C1E48517_5538940C00DD_var*
begin
//#UC START# *2EC8C1E48517_5538940C00DD_impl*
 Result := f_Alien.CanReopenClosedTab(aContainer);
//#UC END# *2EC8C1E48517_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CanReopenClosedTab

procedure TvcmTabbedContainersService.CascadeWindows;
//#UC START# *3F5E73D5D2B0_5538940C00DD_var*
//#UC END# *3F5E73D5D2B0_5538940C00DD_var*
begin
//#UC START# *3F5E73D5D2B0_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.CascadeWindows
 else
  vcmDispatcher.CascadeWindows;
//#UC END# *3F5E73D5D2B0_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CascadeWindows

procedure TvcmTabbedContainersService.ReopenClosedTab(const aContainer: Il3TabbedContainer);
//#UC START# *424D166E6D0C_5538940C00DD_var*
//#UC END# *424D166E6D0C_5538940C00DD_var*
begin
//#UC START# *424D166E6D0C_5538940C00DD_impl*
 f_Alien.ReopenClosedTab(aContainer);
//#UC END# *424D166E6D0C_5538940C00DD_impl*
end;//TvcmTabbedContainersService.ReopenClosedTab

procedure TvcmTabbedContainersService.LockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *44A2D9FC0500_5538940C00DD_var*
//#UC END# *44A2D9FC0500_5538940C00DD_var*
begin
//#UC START# *44A2D9FC0500_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.LockContainer(aContainer);
//#UC END# *44A2D9FC0500_5538940C00DD_impl*
end;//TvcmTabbedContainersService.LockContainer

procedure TvcmTabbedContainersService.Unsubscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *4526B341C1C6_5538940C00DD_var*
//#UC END# *4526B341C1C6_5538940C00DD_var*
begin
//#UC START# *4526B341C1C6_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.Unsubscribe(aListener);
//#UC END# *4526B341C1C6_5538940C00DD_impl*
end;//TvcmTabbedContainersService.Unsubscribe

function TvcmTabbedContainersService.GetCurrentMainForm: TWinControl;
//#UC START# *5538B77B0192_5538940C00DD_var*
//#UC END# *5538B77B0192_5538940C00DD_var*
begin
//#UC START# *5538B77B0192_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetCurrentMainForm
 else
  Result := Screen.ActiveForm;
//#UC END# *5538B77B0192_5538940C00DD_impl*
end;//TvcmTabbedContainersService.GetCurrentMainForm

function TvcmTabbedContainersService.IsFormInContainer(aForm: TForm;
 aContainer: TForm): Boolean;
//#UC START# *5E78F22AF1FF_5538940C00DD_var*
//#UC END# *5E78F22AF1FF_5538940C00DD_var*
begin
//#UC START# *5E78F22AF1FF_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsFormInContainer(aForm, aContainer)
 else
  Result := False;
//#UC END# *5E78F22AF1FF_5538940C00DD_impl*
end;//TvcmTabbedContainersService.IsFormInContainer

procedure TvcmTabbedContainersService.TileWindowsHorizontal;
//#UC START# *651C515DADEE_5538940C00DD_var*
//#UC END# *651C515DADEE_5538940C00DD_var*
begin
//#UC START# *651C515DADEE_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.TileWindowsHorizontal
 else
  vcmDispatcher.TileWindowsHorizontal;
//#UC END# *651C515DADEE_5538940C00DD_impl*
end;//TvcmTabbedContainersService.TileWindowsHorizontal

function TvcmTabbedContainersService.IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *89B204B9A81A_5538940C00DD_var*
//#UC END# *89B204B9A81A_5538940C00DD_var*
begin
//#UC START# *89B204B9A81A_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsContainerLocked(aContainer)
 else
  Result := False;
//#UC END# *89B204B9A81A_5538940C00DD_impl*
end;//TvcmTabbedContainersService.IsContainerLocked

procedure TvcmTabbedContainersService.ActivateForm(aForm: TForm);
//#UC START# *94E9E4364244_5538940C00DD_var*
//#UC END# *94E9E4364244_5538940C00DD_var*
begin
//#UC START# *94E9E4364244_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.ActivateForm(aForm);
//#UC END# *94E9E4364244_5538940C00DD_impl*
end;//TvcmTabbedContainersService.ActivateForm

function TvcmTabbedContainersService.NeedUseTabs: Boolean;
//#UC START# *9584664239A7_5538940C00DD_var*
//#UC END# *9584664239A7_5538940C00DD_var*
begin
//#UC START# *9584664239A7_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.NeedUseTabs
 else
  Result := False;
//#UC END# *9584664239A7_5538940C00DD_impl*
end;//TvcmTabbedContainersService.NeedUseTabs

procedure TvcmTabbedContainersService.TileWindowsVertical;
//#UC START# *9D76EEC368A2_5538940C00DD_var*
//#UC END# *9D76EEC368A2_5538940C00DD_var*
begin
//#UC START# *9D76EEC368A2_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.TileWindowsVertical
 else
  vcmDispatcher.TileWindowsVertical;
//#UC END# *9D76EEC368A2_5538940C00DD_impl*
end;//TvcmTabbedContainersService.TileWindowsVertical

procedure TvcmTabbedContainersService.ContainedFormBecomeActive(aForm: TForm);
//#UC START# *AEF0183D2054_5538940C00DD_var*
//#UC END# *AEF0183D2054_5538940C00DD_var*
begin
//#UC START# *AEF0183D2054_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.ContainedFormBecomeActive(aForm);
//#UC END# *AEF0183D2054_5538940C00DD_impl*
end;//TvcmTabbedContainersService.ContainedFormBecomeActive

function TvcmTabbedContainersService.IsTabEmpty(const aTab: Il3FormTab): Boolean;
//#UC START# *BFD6868132D2_5538940C00DD_var*
//#UC END# *BFD6868132D2_5538940C00DD_var*
begin
//#UC START# *BFD6868132D2_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsTabEmpty(aTab);
//#UC END# *BFD6868132D2_5538940C00DD_impl*
end;//TvcmTabbedContainersService.IsTabEmpty

function TvcmTabbedContainersService.CloneTab(const aTab: Il3FormTab): Il3FormTab;
//#UC START# *CA81A004E69C_5538940C00DD_var*
//#UC END# *CA81A004E69C_5538940C00DD_var*
begin
//#UC START# *CA81A004E69C_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.CloneTab(aTab);
//#UC END# *CA81A004E69C_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CloneTab

function TvcmTabbedContainersService.GetFormTab(aForm: TForm): Il3FormTab;
//#UC START# *E6CFFF63C7BA_5538940C00DD_var*
//#UC END# *E6CFFF63C7BA_5538940C00DD_var*
begin
//#UC START# *E6CFFF63C7BA_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetFormTab(aForm);
//#UC END# *E6CFFF63C7BA_5538940C00DD_impl*
end;//TvcmTabbedContainersService.GetFormTab

procedure TvcmTabbedContainersService.Unlock;
//#UC START# *E781A200DBB9_5538940C00DD_var*
//#UC END# *E781A200DBB9_5538940C00DD_var*
begin
//#UC START# *E781A200DBB9_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.Unlock;
//#UC END# *E781A200DBB9_5538940C00DD_impl*
end;//TvcmTabbedContainersService.Unlock

function TvcmTabbedContainersService.CanCloneTab(const aTab: Il3FormTab): Boolean;
//#UC START# *EE61E6DE4383_5538940C00DD_var*
//#UC END# *EE61E6DE4383_5538940C00DD_var*
begin
//#UC START# *EE61E6DE4383_5538940C00DD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.CanCloneTab(aTab)
 else
  Result := False;
//#UC END# *EE61E6DE4383_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CanCloneTab

procedure TvcmTabbedContainersService.StartFlashing;
//#UC START# *F09F327B084A_5538940C00DD_var*
var
 l_FlashingForm: IvcmFlashingWindow;
//#UC END# *F09F327B084A_5538940C00DD_var*
begin
//#UC START# *F09F327B084A_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.StopFlashing
 else
 begin
  if Supports(GetCurrentMainForm, IvcmFlashingWindow, l_FlashingForm) then
   l_FlashingForm.StopFlashing;
 end;
//#UC END# *F09F327B084A_5538940C00DD_impl*
end;//TvcmTabbedContainersService.StartFlashing

procedure TvcmTabbedContainersService.SaveTabToHistory(const aTab: Il3FormTab);
//#UC START# *F2A394FBFE56_5538940C00DD_var*
//#UC END# *F2A394FBFE56_5538940C00DD_var*
begin
//#UC START# *F2A394FBFE56_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.SaveTabToHistory(aTab);
//#UC END# *F2A394FBFE56_5538940C00DD_impl*
end;//TvcmTabbedContainersService.SaveTabToHistory

procedure TvcmTabbedContainersService.CloseAll;
//#UC START# *F550802110EC_5538940C00DD_var*
//#UC END# *F550802110EC_5538940C00DD_var*
begin
//#UC START# *F550802110EC_5538940C00DD_impl*
 if (f_Alien <> nil) then
  f_Alien.CloseAll
 else
  vcmDispatcher.CloseAllWindows;
//#UC END# *F550802110EC_5538940C00DD_impl*
end;//TvcmTabbedContainersService.CloseAll

class function TvcmTabbedContainersService.Instance: TvcmTabbedContainersService;
 {* Метод получения экземпляра синглетона TvcmTabbedContainersService }
begin
 if (g_TvcmTabbedContainersService = nil) then
 begin
  l3System.AddExitProc(TvcmTabbedContainersServiceFree);
  g_TvcmTabbedContainersService := Create;
 end;
 Result := g_TvcmTabbedContainersService;
end;//TvcmTabbedContainersService.Instance

procedure TvcmTabbedContainersService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmTabbedContainersService.ClearFields

initialization
 Tl3TabbedContainersDispatcher.Instance.Alien := TvcmTabbedContainersDispatcher.Instance;
 {* Регистрация TvcmTabbedContainersDispatcher }
{$IfEnd} // NOT Defined(NoVCM)

end.
