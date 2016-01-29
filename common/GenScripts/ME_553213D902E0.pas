unit l3TabbedContainersDispatcher;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Forms
 , Types
;

type
 Tl3TabbedContainerNotificationType = (
  tcnTabChanged
  , tcnMainFormBecomeVisible
  , tcnMainFormBecomeInvisible
  , tcnNewContainerMakingStarted
  , tcnNewContainerMakingFinished
  , tcnNewTabOrWindowOpeningStarted
  , tcnNewTabOrWindowOpeningFinished
  , tcnApplicationTerminating
 );//Tl3TabbedContainerNotificationType
 
 Il3TabbedContainersListener = interface
  procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//Il3TabbedContainersListener
 
 Tl3TabUpdateOption = (
  tuo_UpdateHintText
  , tuo_UpdateTabText
  , tuo_UpdateTabImage
 );//Tl3TabUpdateOption
 
 Tl3TabUpdateOptions = set of Tl3TabUpdateOption;
 
 Il3TabParams = interface
 end;//Il3TabParams
 
 Il3FormTab = interface;
 
 Il3TabbedContainer = interface
  function DockForm(aForm: TForm;
   aNeedShow: Boolean): Boolean;
  function UndockForm(aForm: TForm): Boolean;
  function MakeFormParams(aForm: TForm): Il3TabParams;
  function MakeClone: Il3TabbedContainer;
  procedure MakeVisible(const aTopLeftPosition: TPoint);
  procedure DockForeignForm(aForm: TForm;
   const aTabParams: Il3TabParams);
  procedure LockPosition;
  procedure UnlockPosition;
  function GetFormTab(aForm: TForm): Il3FormTab;
  procedure CloseAllButActiveTab;
  procedure OpenNewTab;
  procedure CloseSelectedTab;
  procedure CloseTab(const aTab: Il3FormTab);
  procedure UpdateCaption;
 end;//Il3TabbedContainer
 
 Il3FormTabParams = interface
  procedure Update(const aParams: Il3TabParams);
 end;//Il3FormTabParams
 
 Il3FormTab = interface
  function MakeClone: Il3FormTab;
  procedure AssignParams(const aParams: Il3TabParams);
 end;//Il3FormTab
 
 (*
 Ml3TabbedContainersDispatcher = interface
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
 end;//Ml3TabbedContainersDispatcher
 *)
 
 Il3SelectedTabDependent = interface
  procedure TabBecomeActive;
  procedure TabBecomeInactive;
 end;//Il3SelectedTabDependent
 
 Il3TabbedContainersDispatcher = interface
  {* Интерфейс сервиса Tl3TabbedContainersDispatcher }
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
 end;//Il3TabbedContainersDispatcher
 
 Tl3TabbedContainersDispatcher = class(Tl3ProtoObject)
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
 end;//Tl3TabbedContainersDispatcher
 
implementation

uses
 l3ImplUses
;

end.
