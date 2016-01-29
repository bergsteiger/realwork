unit vcmTabbedContainerFormDispatcher;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , vcmTabbedContainerForm
 , l3ProtoDataContainer
 , l3ProtoObject
 , vcmTabbedContainersService
 , ImgList
 , vcmInterfaces
 , l3LongintList
 , Types
 , ChromeLikeInterfaces
 , vcmTabbedContainerFormDispatcherUtils
 , l3TabbedContainersDispatcher
 , Forms
 , vcmExternalInterfaces
 , Controls
 , Classes
 , Windows
;

type
 TvcmContainedFormDescr = object
 end;//TvcmContainedFormDescr
 
 TvcmFormToContainerMap = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmFormToContainerMap
 
 TvcmTabbedContainerFormDispatcher = class(Tl3ProtoObject, IvcmTabbedContainersService)
  procedure StartMakingClone(aContainer: TvcmTabbedContainerForm);
  procedure EndMakingClone;
  function MakeNewTabbedContainer(aChildForm: TvcmEntityForm;
   aNeedPlace: Boolean;
   aNeedLoadFromSettings: Boolean;
   aNeedShow: Boolean;
   const aParams: Il3TabParams): TvcmTabbedContainerForm;
  function InsertFormIntoANewContainer(aForm: TForm;
   const aRect: TRect;
   const aParams: Il3TabParams): TvcmTabbedContainerForm;
  procedure FormInsertedIntoContainer(aForm: TForm;
   aContainer: TvcmTabbedContainerForm);
  function GetFormContainer(aForm: TForm): TvcmTabbedContainerForm;
  procedure FormRemovedFromContainer(aForm: TForm;
   aContainer: TvcmTabbedContainerForm);
  procedure MoveToAnotherContainer(aForm: TForm;
   aNewContainer: TvcmTabbedContainerForm;
   const aMousePoint: TPoint);
  function FindTabbedContainerUnderPoint(const aPoint: TPoint;
   aForm: TForm): TvcmTabbedContainerForm;
  function TryDockToTabset(const aPoint: TPoint;
   aDockClientForm: TvcmEntityForm;
   aContainerForm: TvcmTabbedContainerForm): Boolean;
  procedure SignalClosingForm(aForm: TForm);
  function GetContainedFormCount(aContainer: TvcmTabbedContainerForm): Integer;
  function CallContainerCloseQuery(aContainer: TvcmTabbedContainerForm): Boolean;
  function NeedAskMayExit(aForm: TForm): Boolean;
  procedure AddFormToContainer(aForm: TvcmEntityForm;
   aContainer: TvcmTabbedContainerForm;
   aNeedSwitchTab: Boolean;
   aAddLast: Boolean;
   aOpenAfter: TvcmEntityForm);
  procedure SignalContainerIsClosing(aContainer: TvcmTabbedContainerForm);
  function PlaceVcmContainer(const aPrevContainer: IvcmContainer;
   const aNewContainer: IvcmContainer;
   aOpenKind: TvcmMainFormOpenKind;
   aNeedSwitchTab: Boolean;
   aOpenLast: Boolean;
   aOpenAfter: TvcmEntityForm): IvcmContainer;
  function MakeAndPlaceVCMContainer(const aContainerMaker: IvcmContainerMaker;
   const aPrevContainer: IvcmContainer;
   aOpenKind: TvcmMainFormOpenKind;
   aNeedSwitchTab: Boolean;
   aOpenLast: Boolean;
   aOpenAfter: TvcmEntityForm): IvcmContainer;
  function CanOpenNewTab(aContainer: TvcmTabbedContainerForm): Boolean;
  function CanOpenNewContainer: Boolean;
  procedure ActivateTabByIndex(aContainer: TvcmTabbedContainerForm;
   aTabIndex: Integer);
  function GetCurrentActiveContainer: TvcmTabbedContainerForm;
  procedure Create;
  procedure NotifyFormDataSourceChanged(const aContainedForm: IvcmEntityForm;
   const aChildForm: IvcmEntityForm;
   const aFormDataSource: IvcmFormDataSource);
  procedure UpdateTab(const aChildForm: IvcmEntityForm);
  function GetTopMostContainer(const aForm: IvcmEntityForm): IvcmContainer;
  procedure UpdateTabCaption(const aForm: IvcmEntityForm;
   const aCaption: IvcmCString);
  procedure UpdateContainerList;
  function MakeContainersList: IvcmEntityFormsIterable;
  procedure CloseAllWindows(const aCurrent: IvcmEntityForm);
  function CanCloseAllWindows: Boolean;
  function GetNextMainForm(const aCurrent: IvcmEntityForm): IvcmEntityForm;
  procedure UpdateFormTabInContainer(aForm: TvcmEntityForm);
  function GetContainedFormCaption(aForm: TvcmEntityForm): IvcmCString;
  function GetFormCaptionViaProvider(aForm: TvcmEntityForm): IvcmCString;
  procedure NotifyListeners(aNotification: Tl3TabbedContainerNotificationType);
  procedure ContainerChanged(aContainer: TvcmTabbedContainerForm);
  function NeedTerminateAppOnClosingForm(aForm: TvcmEntityForm): Boolean;
  function GetContainedFormHint(aForm: TvcmEntityForm): IvcmCString;
  function MakeTabParams(aForm: TvcmEntityForm): Il3TabParams;
  procedure NotifyContainerClosed(aContainer: TvcmTabbedContainerForm);
  procedure NotifyMainFormVisibleChanged(aVisible: Boolean);
  procedure UpdateFormTabIcon(aForm: TvcmEntityForm);
  function IsAnyModalFormShowing: Boolean;
  procedure NotifyContainerCreated(aContainer: TvcmTabbedContainerForm);
  procedure UpdateFormTabParams(aForm: TForm;
   const aParams: Il3TabParams);
  procedure SaveTabHistory(const aContainer: IvcmContainer;
   const aTabHistoryState: IvcmHistoryState);
  function GetTabHistory(aForm: TForm): IvcmFormSetHistory;
  function GetFormTabIcon(aForm: TvcmEntityForm;
   out theIconIndex: Integer): Boolean;
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
 end;//TvcmTabbedContainerFormDispatcher
 
 PvcmContainedFormDescr = ^TvcmContainedFormDescr;
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Menus
 , ChromeLikeTabSetRes
 , ChromeLikeWinUtils
 , vcmBase
 , vcmMainForm
 , vcmTabbedContainerRes
 , vcmMessagesSupport
 , l3MessageID
 , Dialogs
 , vcmMainFormRes
 , OvcBase
 , l3String
 , ChromeLikeTypes
 , vcmBaseMenuManager
 , afwFacade
 , vcmUtils
 , vcmFormSetContainerRegistry
 , vcmHistory
 , vcmTabsHistoryService
 , l3Base
 , l3MinMax
 , RTLConsts
 , afwInterfaces
 , vcmContainerForm
 , vcmEntityFormsIterable
 , ChromeLikeTabParams
 , ChromeLikeFormTabParamsList
;

type
 THackApplication = class(TComponent)
 end;//THackApplication
 
 TvcmChromeLikeMainFormProvider = class(Tl3ProtoObject, IvcmMainFormProvider)
  procedure Make;
  function CurrentMainForm: IvcmEntityForm;
  function CurrentVCMContainer: IvcmContainer;
 end;//TvcmChromeLikeMainFormProvider
 
 TvcmContainerWithTabMaker = class(Tl3ProtoObject, IvcmContainerMaker)
  procedure Create(const aRealContainerMaker: IvcmContainerMaker);
  procedure Make(const aRealContainerMaker: IvcmContainerMaker);
  function MakeContainer: IvcmContainer;
 end;//TvcmContainerWithTabMaker
 
end.
