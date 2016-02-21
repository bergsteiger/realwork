unit l3TabbedContainersDispatcher;

// Модуль: "w:\common\components\rtl\Garant\L3\l3TabbedContainersDispatcher.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
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
  ['{C3D77463-8146-48FA-9873-8AD832D9621A}']
  procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//Il3TabbedContainersListener

 Tl3TabUpdateOption = (
  tuo_UpdateHintText
  , tuo_UpdateTabText
  , tuo_UpdateTabImage
 );//Tl3TabUpdateOption

 Tl3TabUpdateOptions = set of Tl3TabUpdateOption;

 Il3TabParams = interface
  ['{FAD8E3D5-7261-41B0-9B86-3448C0613AC5}']
  function pm_GetHintText: WideString;
  function pm_GetText: WideString;
  function pm_GetImageIndex: Integer;
  function pm_GetUpdateOptions: Tl3TabUpdateOptions;
  property HintText: WideString
   read pm_GetHintText;
  property Text: WideString
   read pm_GetText;
  property ImageIndex: Integer
   read pm_GetImageIndex;
  property UpdateOptions: Tl3TabUpdateOptions
   read pm_GetUpdateOptions;
 end;//Il3TabParams

 Il3FormTab = interface;

 Il3TabbedContainer = interface
  ['{95F3B29D-71D9-4A91-A2A3-F7FA6DC75511}']
  function pm_GetAsForm: TForm;
  function pm_GetTabs(Index: Integer): Il3FormTab;
  function pm_GetTabCount: Integer;
  function pm_GetActiveTab: Il3FormTab;
  procedure pm_SetActiveTab(const aValue: Il3FormTab);
  function pm_GetCanOpenNewTab: Boolean;
  function Get_TabByVisibleIndex(Index: Integer): Il3FormTab;
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
  procedure OpenNewTab(aOpenLast: Boolean = True);
  procedure CloseSelectedTab;
  procedure CloseTab(const aTab: Il3FormTab);
  procedure UpdateCaption;
  function CanUndockFormFromTab(aTabIndex: Integer): Boolean;
  procedure UndockFormFromTab(aTabIndex: Integer);
  property AsForm: TForm
   read pm_GetAsForm;
  property Tabs[Index: Integer]: Il3FormTab
   read pm_GetTabs;
  property TabCount: Integer
   read pm_GetTabCount;
  property ActiveTab: Il3FormTab
   read pm_GetActiveTab
   write pm_SetActiveTab;
  property CanOpenNewTab: Boolean
   read pm_GetCanOpenNewTab;
  property TabByVisibleIndex[Index: Integer]: Il3FormTab
   read Get_TabByVisibleIndex;
 end;//Il3TabbedContainer

 Il3FormTabParams = interface
  ['{4701ABBE-D6D2-4BF5-80C1-12E6B7353EE7}']
  function pm_GetParams: Il3TabParams;
  function pm_GetForm: TForm;
  procedure Update(const aParams: Il3TabParams);
  property Params: Il3TabParams
   read pm_GetParams;
  property Form: TForm
   read pm_GetForm;
 end;//Il3FormTabParams

 Il3FormTab = interface
  ['{5B7152EE-BB8D-4CD2-8CD1-D33734DF059A}']
  function pm_GetTabbedForm: TForm;
  function pm_GetTabbedContainer: Il3TabbedContainer;
  function pm_GetVisibleIndex: Integer;
  function pm_GetCurrentParams: Il3TabParams;
  function MakeClone: Il3FormTab;
  procedure AssignParams(const aParams: Il3TabParams);
  property TabbedForm: TForm
   read pm_GetTabbedForm;
  property TabbedContainer: Il3TabbedContainer
   read pm_GetTabbedContainer;
  property VisibleIndex: Integer
   read pm_GetVisibleIndex;
  property CurrentParams: Il3TabParams
   read pm_GetCurrentParams;
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
  function GetTabCaption(const aTab: Il3FormTab): AnsiString;
 end;//Ml3TabbedContainersDispatcher
 *)

 Il3SelectedTabDependent = interface
  ['{0145B642-38E2-42CE-B9BA-D4B93ACA3FC0}']
  procedure TabBecomeActive;
  procedure TabBecomeInactive;
 end;//Il3SelectedTabDependent

 Il3TabbedContainersDispatcher = interface
  {* Интерфейс сервиса Tl3TabbedContainersDispatcher }
  ['{0A377448-A937-44E1-A27F-968EE0518432}']
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
 end;//Il3TabbedContainersDispatcher

 Tl3TabbedContainersDispatcher = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3TabbedContainersDispatcher;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3TabbedContainersDispatcher);
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
   class function Instance: Tl3TabbedContainersDispatcher;
    {* Метод получения экземпляра синглетона Tl3TabbedContainersDispatcher }
  public
   property Alien: Il3TabbedContainersDispatcher
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3TabbedContainersDispatcher }
 end;//Tl3TabbedContainersDispatcher

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3TabbedContainersDispatcher: Tl3TabbedContainersDispatcher = nil;
 {* Экземпляр синглетона Tl3TabbedContainersDispatcher }

procedure Tl3TabbedContainersDispatcherFree;
 {* Метод освобождения экземпляра синглетона Tl3TabbedContainersDispatcher }
begin
 l3Free(g_Tl3TabbedContainersDispatcher);
end;//Tl3TabbedContainersDispatcherFree

procedure Tl3TabbedContainersDispatcher.pm_SetAlien(const aValue: Il3TabbedContainersDispatcher);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3TabbedContainersDispatcher.pm_SetAlien

class function Tl3TabbedContainersDispatcher.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3TabbedContainersDispatcher <> nil;
end;//Tl3TabbedContainersDispatcher.Exists

function Tl3TabbedContainersDispatcher.GetTabIcon(const aTab: Il3FormTab): Integer;
//#UC START# *02157F96E465_553213D902E0_var*
//#UC END# *02157F96E465_553213D902E0_var*
begin
//#UC START# *02157F96E465_553213D902E0_impl*
 Result := f_Alien.GetTabIcon(aTab);
//#UC END# *02157F96E465_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.GetTabIcon

function Tl3TabbedContainersDispatcher.IsInBF(aContainedForm: TForm): Boolean;
//#UC START# *06D14140190A_553213D902E0_var*
//#UC END# *06D14140190A_553213D902E0_var*
begin
//#UC START# *06D14140190A_553213D902E0_impl*
 Result := f_Alien.IsInBF(aContainedForm);
//#UC END# *06D14140190A_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.IsInBF

function Tl3TabbedContainersDispatcher.GetTabCaption(const aTab: Il3FormTab): AnsiString;
//#UC START# *086A3DF2665B_553213D902E0_var*
//#UC END# *086A3DF2665B_553213D902E0_var*
begin
//#UC START# *086A3DF2665B_553213D902E0_impl*
 Result := f_Alien.GetTabCaption(aTab);
//#UC END# *086A3DF2665B_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.GetTabCaption

procedure Tl3TabbedContainersDispatcher.CloseTab(const aTab: Il3FormTab);
//#UC START# *0E111B36F193_553213D902E0_var*
//#UC END# *0E111B36F193_553213D902E0_var*
begin
//#UC START# *0E111B36F193_553213D902E0_impl*
 f_Alien.CloseTab(aTab);
//#UC END# *0E111B36F193_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CloseTab

procedure Tl3TabbedContainersDispatcher.Subscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *1561A6522B5C_553213D902E0_var*
//#UC END# *1561A6522B5C_553213D902E0_var*
begin
//#UC START# *1561A6522B5C_553213D902E0_impl*
 f_Alien.Subscribe(aListener);
//#UC END# *1561A6522B5C_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.Subscribe

procedure Tl3TabbedContainersDispatcher.Lock;
//#UC START# *185C64EF3184_553213D902E0_var*
//#UC END# *185C64EF3184_553213D902E0_var*
begin
//#UC START# *185C64EF3184_553213D902E0_impl*
 f_Alien.Lock;
//#UC END# *185C64EF3184_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.Lock

procedure Tl3TabbedContainersDispatcher.UnlockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *1BFA5AA0644C_553213D902E0_var*
//#UC END# *1BFA5AA0644C_553213D902E0_var*
begin
//#UC START# *1BFA5AA0644C_553213D902E0_impl*
 f_Alien.UnlockContainer(aContainer);
//#UC END# *1BFA5AA0644C_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.UnlockContainer

function Tl3TabbedContainersDispatcher.GetActiveTabbedContainer: Il3TabbedContainer;
//#UC START# *2774A286694A_553213D902E0_var*
//#UC END# *2774A286694A_553213D902E0_var*
begin
//#UC START# *2774A286694A_553213D902E0_impl*
 Result := f_Alien.GetActiveTabbedContainer;
//#UC END# *2774A286694A_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.GetActiveTabbedContainer

procedure Tl3TabbedContainersDispatcher.StopFlashing;
//#UC START# *2A43AA8AA799_553213D902E0_var*
//#UC END# *2A43AA8AA799_553213D902E0_var*
begin
//#UC START# *2A43AA8AA799_553213D902E0_impl*
 f_Alien.StopFlashing;
//#UC END# *2A43AA8AA799_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.StopFlashing

function Tl3TabbedContainersDispatcher.CanReopenClosedTab(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *2EC8C1E48517_553213D902E0_var*
//#UC END# *2EC8C1E48517_553213D902E0_var*
begin
//#UC START# *2EC8C1E48517_553213D902E0_impl*
 Result := f_Alien.CanReopenClosedTab(aContainer);
//#UC END# *2EC8C1E48517_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CanReopenClosedTab

procedure Tl3TabbedContainersDispatcher.CascadeWindows;
//#UC START# *3F5E73D5D2B0_553213D902E0_var*
//#UC END# *3F5E73D5D2B0_553213D902E0_var*
begin
//#UC START# *3F5E73D5D2B0_553213D902E0_impl*
 f_Alien.CascadeWindows;
//#UC END# *3F5E73D5D2B0_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CascadeWindows

procedure Tl3TabbedContainersDispatcher.ReopenClosedTab(const aContainer: Il3TabbedContainer);
//#UC START# *424D166E6D0C_553213D902E0_var*
//#UC END# *424D166E6D0C_553213D902E0_var*
begin
//#UC START# *424D166E6D0C_553213D902E0_impl*
 f_Alien.ReopenClosedTab(aContainer);
//#UC END# *424D166E6D0C_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.ReopenClosedTab

procedure Tl3TabbedContainersDispatcher.LockContainer(const aContainer: Il3TabbedContainer);
//#UC START# *44A2D9FC0500_553213D902E0_var*
//#UC END# *44A2D9FC0500_553213D902E0_var*
begin
//#UC START# *44A2D9FC0500_553213D902E0_impl*
 f_Alien.LockContainer(aContainer);
//#UC END# *44A2D9FC0500_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.LockContainer

procedure Tl3TabbedContainersDispatcher.Unsubscribe(const aListener: Il3TabbedContainersListener);
//#UC START# *4526B341C1C6_553213D902E0_var*
//#UC END# *4526B341C1C6_553213D902E0_var*
begin
//#UC START# *4526B341C1C6_553213D902E0_impl*
 if (f_Alien <> nil) then
  f_Alien.Unsubscribe(aListener);
//#UC END# *4526B341C1C6_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.Unsubscribe

function Tl3TabbedContainersDispatcher.IsFormInContainer(aForm: TForm;
 aContainer: TForm): Boolean;
//#UC START# *5E78F22AF1FF_553213D902E0_var*
//#UC END# *5E78F22AF1FF_553213D902E0_var*
begin
//#UC START# *5E78F22AF1FF_553213D902E0_impl*
 Result := f_Alien.IsFormInContainer(aForm, aContainer);
//#UC END# *5E78F22AF1FF_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.IsFormInContainer

procedure Tl3TabbedContainersDispatcher.TileWindowsHorizontal;
//#UC START# *651C515DADEE_553213D902E0_var*
//#UC END# *651C515DADEE_553213D902E0_var*
begin
//#UC START# *651C515DADEE_553213D902E0_impl*
 f_Alien.TileWindowsHorizontal;
//#UC END# *651C515DADEE_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.TileWindowsHorizontal

function Tl3TabbedContainersDispatcher.IsContainerLocked(const aContainer: Il3TabbedContainer): Boolean;
//#UC START# *89B204B9A81A_553213D902E0_var*
//#UC END# *89B204B9A81A_553213D902E0_var*
begin
//#UC START# *89B204B9A81A_553213D902E0_impl*
 Result := f_Alien.IsContainerLocked(aContainer);
//#UC END# *89B204B9A81A_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.IsContainerLocked

procedure Tl3TabbedContainersDispatcher.ActivateForm(aForm: TForm);
//#UC START# *94E9E4364244_553213D902E0_var*
//#UC END# *94E9E4364244_553213D902E0_var*
begin
//#UC START# *94E9E4364244_553213D902E0_impl*
 f_Alien.ActivateForm(aForm);
//#UC END# *94E9E4364244_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.ActivateForm

function Tl3TabbedContainersDispatcher.NeedUseTabs: Boolean;
//#UC START# *9584664239A7_553213D902E0_var*
//#UC END# *9584664239A7_553213D902E0_var*
begin
//#UC START# *9584664239A7_553213D902E0_impl*
 Result := f_Alien.NeedUseTabs;
//#UC END# *9584664239A7_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.NeedUseTabs

procedure Tl3TabbedContainersDispatcher.TileWindowsVertical;
//#UC START# *9D76EEC368A2_553213D902E0_var*
//#UC END# *9D76EEC368A2_553213D902E0_var*
begin
//#UC START# *9D76EEC368A2_553213D902E0_impl*
 f_Alien.TileWindowsVertical;
//#UC END# *9D76EEC368A2_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.TileWindowsVertical

procedure Tl3TabbedContainersDispatcher.ContainedFormBecomeActive(aForm: TForm);
//#UC START# *AEF0183D2054_553213D902E0_var*
//#UC END# *AEF0183D2054_553213D902E0_var*
begin
//#UC START# *AEF0183D2054_553213D902E0_impl*
 f_Alien.ContainedFormBecomeActive(aForm);
//#UC END# *AEF0183D2054_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.ContainedFormBecomeActive

function Tl3TabbedContainersDispatcher.IsTabEmpty(const aTab: Il3FormTab): Boolean;
//#UC START# *BFD6868132D2_553213D902E0_var*
//#UC END# *BFD6868132D2_553213D902E0_var*
begin
//#UC START# *BFD6868132D2_553213D902E0_impl*
 Result := f_Alien.IsTabEmpty(aTab);
//#UC END# *BFD6868132D2_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.IsTabEmpty

function Tl3TabbedContainersDispatcher.CloneTab(const aTab: Il3FormTab): Il3FormTab;
//#UC START# *CA81A004E69C_553213D902E0_var*
//#UC END# *CA81A004E69C_553213D902E0_var*
begin
//#UC START# *CA81A004E69C_553213D902E0_impl*
 f_Alien.CloneTab(aTab);
//#UC END# *CA81A004E69C_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CloneTab

function Tl3TabbedContainersDispatcher.GetFormTab(aForm: TForm): Il3FormTab;
//#UC START# *E6CFFF63C7BA_553213D902E0_var*
//#UC END# *E6CFFF63C7BA_553213D902E0_var*
begin
//#UC START# *E6CFFF63C7BA_553213D902E0_impl*
 Result := f_Alien.GetFormTab(aForm);
//#UC END# *E6CFFF63C7BA_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.GetFormTab

procedure Tl3TabbedContainersDispatcher.Unlock;
//#UC START# *E781A200DBB9_553213D902E0_var*
//#UC END# *E781A200DBB9_553213D902E0_var*
begin
//#UC START# *E781A200DBB9_553213D902E0_impl*
 f_Alien.Unlock;
//#UC END# *E781A200DBB9_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.Unlock

function Tl3TabbedContainersDispatcher.CanCloneTab(const aTab: Il3FormTab): Boolean;
//#UC START# *EE61E6DE4383_553213D902E0_var*
//#UC END# *EE61E6DE4383_553213D902E0_var*
begin
//#UC START# *EE61E6DE4383_553213D902E0_impl*
 Result := f_Alien.CanCloneTab(aTab);
//#UC END# *EE61E6DE4383_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CanCloneTab

procedure Tl3TabbedContainersDispatcher.StartFlashing;
//#UC START# *F09F327B084A_553213D902E0_var*
//#UC END# *F09F327B084A_553213D902E0_var*
begin
//#UC START# *F09F327B084A_553213D902E0_impl*
 f_Alien.StartFlashing;
//#UC END# *F09F327B084A_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.StartFlashing

procedure Tl3TabbedContainersDispatcher.SaveTabToHistory(const aTab: Il3FormTab);
//#UC START# *F2A394FBFE56_553213D902E0_var*
//#UC END# *F2A394FBFE56_553213D902E0_var*
begin
//#UC START# *F2A394FBFE56_553213D902E0_impl*
 f_Alien.SaveTabToHistory(aTab);
//#UC END# *F2A394FBFE56_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.SaveTabToHistory

procedure Tl3TabbedContainersDispatcher.CloseAll;
//#UC START# *F550802110EC_553213D902E0_var*
//#UC END# *F550802110EC_553213D902E0_var*
begin
//#UC START# *F550802110EC_553213D902E0_impl*
 f_Alien.CloseAll;
//#UC END# *F550802110EC_553213D902E0_impl*
end;//Tl3TabbedContainersDispatcher.CloseAll

class function Tl3TabbedContainersDispatcher.Instance: Tl3TabbedContainersDispatcher;
 {* Метод получения экземпляра синглетона Tl3TabbedContainersDispatcher }
begin
 if (g_Tl3TabbedContainersDispatcher = nil) then
 begin
  l3System.AddExitProc(Tl3TabbedContainersDispatcherFree);
  g_Tl3TabbedContainersDispatcher := Create;
 end;
 Result := g_Tl3TabbedContainersDispatcher;
end;//Tl3TabbedContainersDispatcher.Instance

procedure Tl3TabbedContainersDispatcher.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3TabbedContainersDispatcher.ClearFields

end.
