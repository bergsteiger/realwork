unit vcmTabbedContainersService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
 , Controls
 , Forms
;

 (*
 MvcmTabbedContainersService = interface(Ml3TabbedContainersDispatcher)
  function GetCurrentMainForm: TWinControl;
 end;//MvcmTabbedContainersService
 *)
 
type
 TvcmTabbedContainersDispatcher = class(Tl3ProtoObject, Il3TabbedContainersDispatcher)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetTabIcon(const aTab: Il3FormTab): Integer;
  function IsInBF(aContainedForm: TForm): Boolean;
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
 end;//TvcmTabbedContainersDispatcher
 
 IvcmTabbedContainersService = interface
  {* Интерфейс сервиса TvcmTabbedContainersService }
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
 end;//IvcmTabbedContainersService
 
 TvcmTabbedContainersService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetTabIcon(const aTab: Il3FormTab): Integer;
  function IsInBF(aContainedForm: TForm): Boolean;
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
 end;//TvcmTabbedContainersService
 
implementation

uses
 l3ImplUses
 , vcmExternalInterfaces
 , SysUtils
 , vcmBase
 , vcmTabsWordsPack
;

end.
