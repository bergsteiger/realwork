unit nscTasksPanelView;

interface

uses
 l3IntfUses
 , afwControl
 , afwInterfaces
 , l3Interfaces
 , vcmTaskPanelInterfaces
 , ImgList
 , Graphics
 , Classes
 , nscInterfaces
 , Messages
 , Controls
 , l3InternalInterfaces
 , nscHideField
 , vg_scene
 , vg_objects
 , vg_layouts
 , vtPanel
 , vtSpeedButton
 , Types
 , nscTreeView
 , vcmPopupMenuPrim
 , ActnList
 , vtLister
;

type
 TnscTasksPanelHideField = class;
 
 TnscCustomTasksPanelView = class(TafwControl, IafwStyleTableSpy, Il3ItemNotifyRecipient, IvcmTaskPanelNotifyRecipient)
  procedure DoOperationExecute;
  procedure MakeTasksPanel;
  procedure RemoveGroup(aHideField: TControl);
  function SortGroups: Boolean;
  procedure DefineActiveControl;
  procedure MakeTabTable;
  procedure ArrangeGrid(aRecalc: Boolean);
  procedure AddGroup(const aGroup: IvcmCustOpsGroup);
  procedure GrideSizeChanged(aSender: TObject);
  procedure LockView;
  procedure UnlockView;
  procedure WMEraseBkGnd(var aMessage: TWMEraseBkGnd);
  procedure StyleTableChanged;
   {* таблица стилей изменилась. }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
  procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: TvcmTaskPanelOperation;
   const aInterface: IvcmCustOpsItem);
   {* прошла операция. }
 end;//TnscCustomTasksPanelView
 
 TnscTasksPanelHideField = class(TnscHideField, Il3ItemNotifyRecipient)
  procedure RefreshContent;
  procedure SetBitmapButton;
  procedure DoOnClick(aSender: TObject);
  function MakeSettingFromTasksPanel: TafwSettingId;
  procedure Subscribe(aSubscribe: Boolean);
  procedure UpdateCaption;
  procedure Create(AOwner: TComponent;
   const aGroup: IvcmCustOpsGroup);
  procedure AFWCMTextChanged(var aMsg: TMessage);
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
 end;//TnscTasksPanelHideField
 
 TnscTasksPanelTreeView = class(TnscTreeView, IvcmTaskPanelNotifyRecipient)
  procedure AddOp(const aOp: IvcmCustOpsGroupOperation);
  procedure AddOps;
  procedure SortChilds;
  function ItemAction(aItemIndex: Integer): TCustomAction;
  function DoOnGetCursor(aSender: TObject;
   aIndex: Integer): TCursor;
  procedure Create(AOwner: TComponent;
   const aGroup: IvcmCustOpsGroup);
  procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: TvcmTaskPanelOperation;
   const aInterface: IvcmCustOpsItem);
   {* прошла операция. }
 end;//TnscTasksPanelTreeView
 
 TnscTasksPanelView = class(TnscCustomTasksPanelView)
 end;//TnscTasksPanelView
 
implementation

uses
 l3ImplUses
 , nscTasksPanelRootNode
 , nscTasksPanelActionLink
 , nscTasksPanelOperationNode
 , SysUtils
 , vtHideField
 , nscArrangeGridCell
 , eeTreeView
 , nscTabTableCell
 , nscArrangeGrid
 , afwFacade
 , nscTabTable
 , evStyleTableSpy
 , l3Units
 , l3Region
 , Windows
 , tfwClassRef
 , TtfwClassRef_Proxy
 , TaskPanelWords
 , afwConsts
 , vgTypes
 , l3Base
 , vtF1InterfaceConst
 , evStyleTableTools
 , l3Tree_TLB
 , nscTaskPanelInterfaces
 , OvcConst
 , Menus
 , vcmAction
 , vcmMenus
 , vcmBase
 , vcmUserControls
 , vcmUtils
 , l3String
 , Forms
 , l3ControlsTypes
 , l3Nodes
 , vcmExternalInterfaces
 , vtOutliner
;

end.
