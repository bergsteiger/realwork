unit ChromeLikeTabSetControl;

interface

uses
 l3IntfUses
 , ChromeLikeTabSetControlPrim
 , ChromeLikeInterfaces
 , Forms
 , ChromeLikeTabSetTypes
 , Types
 , ImgList
 , Menus
 , ChromeLikeBaseVisualObjectPrim
 , l3TabbedContainersDispatcher
 , ChromeLikeBaseVisualObject
 , Classes
 , Controls
 , Graphics
 , GDIPOBJ
 , l3ProtoDataContainer
 , ActnList
;

type
 TChromeLikeTabCloseButton = class(TChromeLikeBaseVisualObject)
 end;//TChromeLikeTabCloseButton
 
 TChromeLikeTabIcon = class(TChromeLikeBaseVisualObject)
  function GetImage: TGPImage;
 end;//TChromeLikeTabIcon
 
 TChromeLikeTabText = class(TChromeLikeBaseVisualObject)
 end;//TChromeLikeTabText
 
 TChromeLikeTabSide = (
  cltsLeft
  , cltsRight
 );//TChromeLikeTabSide
 
 TChromeLikeTabNeedCloseEvent = procedure(aTabToClose: TChromeLikeBaseVisualObject) of object;
 
 TChromeLikeTab = class(TChromeLikeBaseVisualObject, IChromeLikeTabSetAnimable, Il3FormTab)
  procedure DoOnCloseButtonClick(Sender: TObject);
  procedure SelectionChanged;
  procedure MakePaths;
  function GetTabSide(const aPoint: TPoint): TChromeLikeTabSide;
  function NeedSelectByClickAtPoint(const aPoint: TPoint): Boolean;
  procedure Create(aTabSet: TChromeLikeTabSetControlPrim);
  procedure CloseTab;
  function CanBeCloned: Boolean;
  function MakeClone: Il3FormTab;
  function TabbedForm: TForm;
  function TabbedContainer: Il3TabbedContainer;
  function VisibleIndex: Integer;
  procedure AssignParams(const aParams: Il3TabParams);
  function CurrentParams: Il3TabParams;
 end;//TChromeLikeTab
 
 TChromeLikeTabList = class(_l3ObjectPtrList_)
 end;//TChromeLikeTabList
 
 TChromeLikeTabSetPaintBackground = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  const aRect: TRect;
  aCanvas: TCanvas;
  var aDefaultPainting: Boolean) of object;
 
 TChromeLikeTabSetSelectionChangedEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aPrevSelected: TChromeLikeTab;
  aNewSelected: TChromeLikeTab) of object;
 
 TChromeLikeTabSetTabEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aTab: TChromeLikeTab) of object;
 
 TChromeLikeTabSetCloseTabFormEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aTab: TChromeLikeTab;
  var aCanClose: Boolean;
  aNewSelectedTab: TChromeLikeTab) of object;
 
 TChromeLikeTabSetAfterFormAddedEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aForm: TForm;
  aNeedSelect: Boolean) of object;
 
 TChromeLikeTabSetCanDockFormEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aForm: TForm;
  aNeedSelect: Boolean;
  var aCanDock: Boolean) of object;
 
 TChromeLikeTabSetCanUndockFormEvent = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aForm: TForm;
  var aCanUndock: Boolean) of object;
 
 TChromeLikeTabAction = class(TAction)
 end;//TChromeLikeTabAction
 
 TChromeLikeNewTabButton = class(TChromeLikeBaseVisualObject)
  procedure MakePaths;
  procedure Create(aTabSet: TChromeLikeTabSetControlPrim);
 end;//TChromeLikeNewTabButton
 
 TChromeLikeTabSetNewTabRequested = procedure(aTabSet: TChromeLikeTabSetControlPrim) of object;
 
 TChromeLikeTabSetControl = class(TChromeLikeTabSetControlPrim, IChromeLikeCaptionControl)
  procedure InvalidateWidthPerSlot;
  function GetWidthPerSlot: Single;
  function GetSlotRect(aSlotIndex: Integer): TRect;
  procedure ResizeTabs(aAnimated: Boolean);
  procedure ShiftTabsLeft(aStartingWith: Integer);
  procedure DeleteSlot(aSlotIndex: Integer);
  function InsertSlot(aInsertAfter: Integer): Integer;
  function AddSlot: Integer;
  function GetSlotIndexAtPoint(const aPoint: TPoint): Integer;
  function GetSelectedSlotIndex: Integer;
  procedure FinishMoving;
  procedure PlaceTab(aTab: TChromeLikeTab;
   aSlotIndex: Integer);
  procedure SetTabPosition(aTab: TChromeLikeTab);
  procedure SetInitialTabPosition(aTab: TChromeLikeTab);
  function GetTabAtPoint(const aPoint: TPoint): TChromeLikeTab;
  function GetTabInSlot(aSlotIndex: Integer): TChromeLikeTab;
  function NeedMoveTab(aTab: TChromeLikeTab): Boolean;
  function CanRemoveTab(aTab: TChromeLikeTab): Boolean;
  function DockFormIntoSlot(aForm: TForm;
   const aTabParams: Il3TabParams;
   aSlotIndex: Integer;
   aNeedSelect: Boolean): Boolean;
  procedure SelectNext;
   {* Сделать активной вкладку, предшествующую активной }
  procedure SelectPrev;
   {* Сделать активной вкладку, следующую за активной }
  function CanCloseAllButSelected: Boolean;
  procedure CloseAllExceptOne(aTab: TChromeLikeTab);
   {* Закрыть все, кроме определенной }
  function CanCloseAllRightToSelected: Boolean;
  procedure CloseAllRightToTab(aTab: TChromeLikeTab);
   {* Закрыть все вкладки справа от активной }
  procedure AddTab(aTab: TChromeLikeTab); overload;
  procedure AddTab(aTab: TChromeLikeTab;
   const aPoint: TPoint); overload;
  procedure AddTab(aTab: TChromeLikeTab;
   aSlotIndex: Integer); overload;
  procedure AddTabAfterSelected(aTab: TChromeLikeTab);
  procedure CloseTab(aTab: TChromeLikeTab;
   aForce: Boolean);
  function CanCloseTab(aTab: TChromeLikeTab): Boolean;
  procedure RemoveTab(aTab: TChromeLikeTab);
  function DockForm(aForm: TForm;
   const aTabParams: Il3TabParams;
   aNeedSelect: Boolean): Boolean;
  function DockFormAfterSelected(aForm: TForm;
   const aTabParams: Il3TabParams;
   aNeedSelect: Boolean): Boolean;
  function CanDockFormAtPoint(aForm: TForm;
   const aScreenPoint: TPoint): Boolean;
  procedure UndockTabbedForm(aTab: TChromeLikeTab);
  function IsDockablePoint(const aPoint: TPoint): Boolean;
  function HitTest(const aPoint: TPoint): TChromeLikeTabSetHitTestResult;
  procedure UpdateFormTab(aForm: TForm;
   const aParams: Il3TabParams);
  procedure SetFormTabImageIndex(aForm: TForm;
   aImageIndex: Integer);
  function DockFormAtPoint(aForm: TForm;
   const aTabParams: Il3TabParams;
   const aPoint: TPoint;
   aNeedSelect: Boolean): Boolean;
  procedure DoOnNeedCloseTab(aTabToClose: TChromeLikeBaseVisualObject);
  function GetSelectedTabAfterClosing(aTab: TChromeLikeTab): TChromeLikeTab;
  procedure DestroyTabs;
  function FindFormTab(aForm: TForm): TChromeLikeTab;
  function MakeTabParams(aTab: TChromeLikeTab): Il3TabParams;
  procedure SetParams(const aParams: TChromeLikeTabSetParams);
  procedure PopulatePopupMenu;
  procedure actNewTabExecute(Sender: TObject);
  procedure actMakeCloneExecute(Sender: TObject);
  procedure actCloseTabExecute(Sender: TObject);
  procedure actCloseOtherTabsExecute(Sender: TObject);
  procedure actCloseRightTabsExecute(Sender: TObject);
  procedure actReopenClosedTabExecute(Sender: TObject);
  procedure MakeActions;
  procedure UpdateMenuActions(aMenuTab: TChromeLikeTab);
  procedure UpdateNewTabButtonPosition;
  function GetTotalTabsRect: TRect;
  procedure StartMoving;
  procedure HideNewTabButton;
  procedure ShowNewTabButton;
  function IsLastTab(aTab: TChromeLikeTab): Boolean;
  procedure DoOnNewTabButtonClick(Sender: TObject);
  function GetFormTab(aForm: TForm): Il3FormTab;
  procedure Create(aOwner: TComponent;
   const aContainer: Il3TabbedContainer);
  function StartProcessClick: Boolean;
  procedure FinishProcessClick;
  function DockFormAfterSpecified(aForm: TForm;
   const aTabParams: Il3TabParams;
   aInsertAfter: TForm;
   aNeedSelect: Boolean): Boolean;
  function IsTransparentPoint(const aPoint: TPoint): Boolean;
  function GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams;
  procedure Paint(const aContext: IChromeLkeTabSetDrawingContext);
  procedure PaintBackground(aCanvas: TCanvas);
  procedure DoOnResize;
  function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
  function VCLWinControl: TWinControl;
  procedure ShowContextMenu(const aPoint: TPoint);
 end;//TChromeLikeTabSetControl
 
implementation

uses
 l3ImplUses
 , ChromeLikeTabSetStyles
 , ChromeLikeTabSetAnimationManager
 , Math
 , ChromeLikeTabSetUtils
 , GDIPAPI
 , Windows
 , ChromeLikeTabParams
 , l3String
 , l3Base
 , ChromeLikeTabSetControlRes
 , l3StringIDEx
 , TtfwClassRef_Proxy
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
