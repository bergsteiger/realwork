unit ChromeLikeTabSetControl;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TChromeLikeTabSetControl" MUID: (5507EFFD01FE)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , ChromeLikeTabSetControlPrim
 , ChromeLikeInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeTabSetTypes
 , Types
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeBaseVisualObjectPrim
 , l3TabbedContainersDispatcher
 , Classes
 , ChromeLikeBaseVisualObject
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , GDIPOBJ
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 cCloseButtonSize = 8;
 cDefaultTabHeight = 32;
 cMinSlotWidth = 30;
 cDefaultSlotWidth = 180;
 cMovingAnimationDuration = 220;

type
 TChromeLikeTabCloseButton = class(TChromeLikeBaseVisualObject)
  private
   f_ShowOnlyHovered: Boolean;
   f_ButtonImages: TCustomImageList;
   f_ImageIndex: TImageIndex;
   f_HotImageIndex: TImageIndex;
   f_Image: TGPBitmap;
   f_HotImage: TGPBitmap;
  protected
   procedure pm_SetShowOnlyHovered(aValue: Boolean);
   procedure pm_SetButtonImages(aValue: TCustomImageList); virtual;
   procedure pm_SetImageIndex(aValue: TImageIndex);
   procedure pm_SetHotImageIndex(aValue: TImageIndex);
   function pm_GetImage: TGPBitmap;
   function pm_GetHotImage: TGPBitmap;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); override;
   function MeasureSize: TSize; override;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; override;
   procedure DoMouseLeave; override;
  public
   constructor Create(aParent: TChromeLikeBaseVisualObjectPrim); override;
  protected
   property Image: TGPBitmap
    read pm_GetImage;
   property HotImage: TGPBitmap
    read pm_GetHotImage;
  public
   property ShowOnlyHovered: Boolean
    read f_ShowOnlyHovered
    write pm_SetShowOnlyHovered;
   property ButtonImages: TCustomImageList
    read f_ButtonImages
    write pm_SetButtonImages;
   property ImageIndex: TImageIndex
    read f_ImageIndex
    write pm_SetImageIndex;
   property HotImageIndex: TImageIndex
    read f_HotImageIndex
    write pm_SetHotImageIndex;
 end;//TChromeLikeTabCloseButton

 TChromeLikeTabIcon = class(TChromeLikeBaseVisualObject)
  private
   f_Image: TGPImage;
   f_ImageList: TCustomImageList;
   f_ImageIndex: TImageIndex;
  private
   function GetImage: TGPImage;
  protected
   procedure pm_SetImageList(aValue: TCustomImageList);
   procedure pm_SetImageIndex(aValue: TImageIndex);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); override;
   function MeasureSize: TSize; override;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; override;
  public
   property ImageList: TCustomImageList
    read f_ImageList
    write pm_SetImageList;
   property ImageIndex: TImageIndex
    read f_ImageIndex
    write pm_SetImageIndex;
 end;//TChromeLikeTabIcon

 TChromeLikeTabText = class(TChromeLikeBaseVisualObject)
  private
   f_Text: WideString;
  protected
   procedure pm_SetText(const aValue: WideString);
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); override;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; override;
   procedure ClearFields; override;
  public
   property Text: WideString
    read f_Text
    write pm_SetText;
 end;//TChromeLikeTabText

 TChromeLikeTabSide = (
  cltsLeft
  , cltsRight
 );//TChromeLikeTabSide

 TChromeLikeTabNeedCloseEvent = procedure(aTabToClose: TChromeLikeBaseVisualObject) of object;

 TChromeLikeTab = class(TChromeLikeBaseVisualObject, Il3FormTab)
  private
   f_CloseButton: TChromeLikeTabCloseButton;
   f_TextControl: TChromeLikeTabText;
   f_Icon: TChromeLikeTabIcon;
   f_BodyPath: TGPGraphicsPath;
   f_LeftTopEdgePath: TGPGraphicsPath;
   f_RightEdgePath: TGPGraphicsPath;
   f_BottomEdgePath: TGPGraphicsPath;
   f_RoundingRadius: Single;
   f_Text: WideString;
   f_Selected: Boolean;
   f_Form: TForm;
   f_ImageIndex: TImageIndex;
   f_ImageList: TCustomImageList;
   f_SlotIndex: Integer;
   f_OnNeedCloseTab: TChromeLikeTabNeedCloseEvent;
   f_TabSet: TChromeLikeTabSetControlPrim;
   f_CloseButtonImages: TCustomImageList;
   f_CloseButtonImageIndex: TImageIndex;
   f_CloseButtonHotImageIndex: TImageIndex;
  private
   procedure DoOnCloseButtonClick(Sender: TObject);
   procedure SelectionChanged;
   procedure MakePaths;
   procedure CloseTab;
  protected
   function pm_GetText: WideString;
   procedure pm_SetText(const aValue: WideString);
   function pm_GetSelected: Boolean; virtual;
   procedure pm_SetSelected(aValue: Boolean); virtual;
   procedure pm_SetForm(aValue: TForm); virtual;
   function pm_GetImageIndex: TImageIndex; virtual;
   procedure pm_SetImageIndex(aValue: TImageIndex); virtual;
   procedure pm_SetImageList(aValue: TCustomImageList); virtual;
   procedure pm_SetSlotIndex(aValue: Integer);
   procedure pm_SetCloseButtonImages(aValue: TCustomImageList);
   procedure pm_SetCloseButtonImageIndex(aValue: TImageIndex);
   procedure pm_SetCloseButtonHotImageIndex(aValue: TImageIndex);
   function MakeClone: Il3FormTab;
   function pm_GetTabbedForm: TForm;
   function pm_GetTabbedContainer: Il3TabbedContainer;
   function pm_GetVisibleIndex: Integer;
   procedure AssignParams(const aParams: Il3TabParams);
   function pm_GetCurrentParams: Il3TabParams;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Invalidate; override;
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); override;
   procedure DoMouseMove(const aPoint: TPoint); override;
   procedure DoClick(const aPoint: TPoint); override;
   procedure PositionChanged; override;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; override;
   procedure MakeChildControls; override;
   function DoGetCanMove(const aPoint: TPoint): Boolean; override;
   procedure DoMiddleButtonClick(const aPoint: TPoint); override;
   procedure ClearFields; override;
  public
   function GetTabSide(const aPoint: TPoint): TChromeLikeTabSide;
   function NeedSelectByClickAtPoint(const aPoint: TPoint): Boolean;
   constructor Create(aTabSet: TChromeLikeTabSetControlPrim); reintroduce;
   function CanBeCloned: Boolean;
  public
   property Text: WideString
    read pm_GetText
    write pm_SetText;
   property Selected: Boolean
    read pm_GetSelected
    write pm_SetSelected;
   property Form: TForm
    read f_Form
    write pm_SetForm;
   property ImageIndex: TImageIndex
    read pm_GetImageIndex
    write pm_SetImageIndex;
   property ImageList: TCustomImageList
    read f_ImageList
    write pm_SetImageList;
   property SlotIndex: Integer
    read f_SlotIndex
    write pm_SetSlotIndex;
   property OnNeedCloseTab: TChromeLikeTabNeedCloseEvent
    read f_OnNeedCloseTab
    write f_OnNeedCloseTab;
   property TabSet: TChromeLikeTabSetControlPrim
    read f_TabSet
    write f_TabSet;
   property CloseButtonImages: TCustomImageList
    read f_CloseButtonImages
    write pm_SetCloseButtonImages;
   property CloseButtonImageIndex: TImageIndex
    read f_CloseButtonImageIndex
    write pm_SetCloseButtonImageIndex;
   property CloseButtonHotImageIndex: TImageIndex
    read f_CloseButtonHotImageIndex
    write pm_SetCloseButtonHotImageIndex;
 end;//TChromeLikeTab

 _ItemType_ = TChromeLikeTab;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
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

 TChromeLikeTabAction = {final} class({$If NOT Defined(NoVCL)}
 TAction
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   f_Tab: TChromeLikeTab;
  protected
   function pm_GetTab: TChromeLikeTab; virtual;
   procedure pm_SetTab(aValue: TChromeLikeTab); virtual;
  public
   property Tab: TChromeLikeTab
    read pm_GetTab
    write pm_SetTab;
 end;//TChromeLikeTabAction

 TChromeLikeNewTabButton = class(TChromeLikeBaseVisualObject)
  private
   f_BackgroundPath: TGPGraphicsPath;
   f_PlusPath: TGPGraphicsPath;
   f_RoundingRadius: Single;
   f_TabSet: TChromeLikeTabSetControlPrim;
   f_PlusEdgePath: TGPGraphicsPath;
  private
   procedure MakePaths;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Invalidate; override;
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); override;
   procedure DoClick(const aPoint: TPoint); override;
   procedure PositionChanged; override;
   function MeasureSize: TSize; override;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; override;
   procedure DoMouseLeave; override;
  public
   constructor Create(aTabSet: TChromeLikeTabSetControlPrim); reintroduce;
 end;//TChromeLikeNewTabButton

 TChromeLikeTabSetNewTabRequested = procedure(aTabSet: TChromeLikeTabSetControlPrim;
  aMenuTab: TChromeLikeTab;
  aOpenLast: Boolean) of object;

 TChromeLikeTabSetControl = class(TChromeLikeTabSetControlPrim, IChromeLikeCaptionControl)
  private
   f_Container: Pointer;
   f_Tabs: TChromeLikeTabList;
   f_WidthPerSlotValid: Boolean;
   f_SlotCount: Integer;
   f_WidthPerSlot: Single;
   f_MovingTab: TChromeLikeTab;
   f_WasMouseLDown: Boolean;
   f_HintTab: TChromeLikeTab;
   f_LastMovingPoint: TPoint;
   f_BeginMovingPoint: TPoint;
   f_actNewTab: TChromeLikeTabAction;
   f_actMakeClone: TChromeLikeTabAction;
   f_actCloseOtherTabs: TChromeLikeTabAction;
   f_actCloseRightTabs: TChromeLikeTabAction;
   f_actReopenClosedTab: TChromeLikeTabAction;
   f_actCloseTab: TChromeLikeTabAction;
   f_TabsPopupMenu: TPopupMenu;
   f_NewTabButton: TChromeLikeNewTabButton;
   f_LClickedObject: TChromeLikeBaseVisualObjectPrim;
   f_ProcessingClick: Boolean;
   f_TabHeight: Integer;
   f_SelectedTab: TChromeLikeTab;
   f_OnPaintBackground: TChromeLikeTabSetPaintBackground;
   f_OnTabSelected: TChromeLikeTabSetTabEvent;
   f_OnTabDeselected: TChromeLikeTabSetTabEvent;
   f_OnAfterFormAdded: TChromeLikeTabSetAfterFormAddedEvent;
   f_OnCloseTabForm: TChromeLikeTabSetCloseTabFormEvent;
   f_OnCanDockForm: TChromeLikeTabSetCanDockFormEvent;
   f_OnCanUndockTabForm: TChromeLikeTabSetCanUndockFormEvent;
   f_OnSelectionChanged: TChromeLikeTabSetSelectionChangedEvent;
   f_MovingEaseType: TChromeLikeTabEaseType;
   f_OnTabClosed: TChromeLikeTabSetTabEvent;
   f_CloseButtonImages: TCustomImageList;
   f_CloseButtonImageIndex: TImageIndex;
   f_CloseButtonHotImageIndex: TImageIndex;
   f_OnNewTabRequested: TChromeLikeTabSetNewTabRequested;
  private
   procedure InvalidateWidthPerSlot;
   function GetWidthPerSlot: Single;
   function GetSlotRect(aSlotIndex: Integer): TRect;
   procedure ResizeTabs(aAnimated: Boolean = False);
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
    aSlotIndex: Integer = -1;
    aNeedSelect: Boolean = True): Boolean;
   procedure DoOnNeedCloseTab(aTabToClose: TChromeLikeBaseVisualObject);
   function GetSelectedTabAfterClosing(aTab: TChromeLikeTab): TChromeLikeTab;
   procedure DestroyTabs;
   function FindFormTab(aForm: TForm): TChromeLikeTab;
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
   function StartProcessClick: Boolean;
   procedure FinishProcessClick;
  protected
   function pm_GetTabHeight: Integer;
   procedure pm_SetTabHeight(aValue: Integer);
   function pm_GetTabCount: Integer;
   function pm_GetTabs(Index: Integer): TChromeLikeTab;
   function pm_GetFormTabs(Form: TForm): TChromeLikeTab;
   procedure pm_SetSelectedTab(aValue: TChromeLikeTab);
   function pm_GetSelectedForm: TForm;
   procedure pm_SetSelectedForm(aValue: TForm);
   function pm_GetSelectedSlotIndex: Integer;
   procedure pm_SetSelectedSlotIndex(aValue: Integer);
   function pm_GetMovingEaseType: TChromeLikeTabEaseType; virtual;
   procedure pm_SetMovingEaseType(aValue: TChromeLikeTabEaseType); virtual;
   procedure pm_SetCloseButtonImages(aValue: TCustomImageList);
   procedure pm_SetCloseButtonImageIndex(aValue: TImageIndex);
   procedure pm_SetCloseButtonHotImageIndex(aValue: TImageIndex);
   function pm_GetContainer: Il3TabbedContainer; virtual;
   function IsTransparentPoint(const aPoint: TPoint): Boolean; override;
   function GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams; override;
   procedure Paint(const aContext: IChromeLkeTabSetDrawingContext); override;
   procedure PaintBackground(aCanvas: TCanvas); override;
   procedure DoOnResize; override;
   function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
   function pm_GetVCLWinControl: TWinControl;
   procedure ShowContextMenu(const aPoint: TPoint);
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoOnMouseLeave; override;
  public
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
    aForce: Boolean = False);
   function CanCloseTab(aTab: TChromeLikeTab): Boolean;
   procedure RemoveTab(aTab: TChromeLikeTab);
   function DockForm(aForm: TForm;
    const aTabParams: Il3TabParams;
    aNeedSelect: Boolean = True): Boolean;
   function DockFormAfterSelected(aForm: TForm;
    const aTabParams: Il3TabParams;
    aNeedSelect: Boolean = True): Boolean;
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
    aNeedSelect: Boolean = True): Boolean;
   function MakeTabParams(aTab: TChromeLikeTab): Il3TabParams;
   procedure SetParams(const aParams: TChromeLikeTabSetParams);
   function GetFormTab(aForm: TForm): Il3FormTab;
   constructor Create(aOwner: TComponent;
    const aContainer: Il3TabbedContainer); reintroduce;
   function DockFormAfterSpecified(aForm: TForm;
    const aTabParams: Il3TabParams;
    aInsertAfter: TForm;
    aNeedSelect: Boolean = True): Boolean;
   destructor Destroy; override;
  public
   property TabHeight: Integer
    read pm_GetTabHeight
    write pm_SetTabHeight;
   property TabCount: Integer
    read pm_GetTabCount;
   property Tabs[Index: Integer]: TChromeLikeTab
    read pm_GetTabs;
   property FormTabs[Form: TForm]: TChromeLikeTab
    read pm_GetFormTabs;
   property SelectedTab: TChromeLikeTab
    read f_SelectedTab
    write pm_SetSelectedTab;
   property SelectedForm: TForm
    read pm_GetSelectedForm
    write pm_SetSelectedForm;
   property SelectedSlotIndex: Integer
    read pm_GetSelectedSlotIndex
    write pm_SetSelectedSlotIndex;
   property OnPaintBackground: TChromeLikeTabSetPaintBackground
    read f_OnPaintBackground
    write f_OnPaintBackground;
   property OnTabSelected: TChromeLikeTabSetTabEvent
    read f_OnTabSelected
    write f_OnTabSelected;
   property OnTabDeselected: TChromeLikeTabSetTabEvent
    read f_OnTabDeselected
    write f_OnTabDeselected;
   property OnAfterFormAdded: TChromeLikeTabSetAfterFormAddedEvent
    read f_OnAfterFormAdded
    write f_OnAfterFormAdded;
   property OnCloseTabForm: TChromeLikeTabSetCloseTabFormEvent
    read f_OnCloseTabForm
    write f_OnCloseTabForm;
   property OnCanDockForm: TChromeLikeTabSetCanDockFormEvent
    read f_OnCanDockForm
    write f_OnCanDockForm;
   property OnCanUndockTabForm: TChromeLikeTabSetCanUndockFormEvent
    read f_OnCanUndockTabForm
    write f_OnCanUndockTabForm;
   property OnSelectionChanged: TChromeLikeTabSetSelectionChangedEvent
    read f_OnSelectionChanged
    write f_OnSelectionChanged;
   property MovingEaseType: TChromeLikeTabEaseType
    read pm_GetMovingEaseType
    write pm_SetMovingEaseType;
   property OnTabClosed: TChromeLikeTabSetTabEvent
    read f_OnTabClosed
    write f_OnTabClosed;
   property CloseButtonImages: TCustomImageList
    read f_CloseButtonImages
    write pm_SetCloseButtonImages;
   property CloseButtonImageIndex: TImageIndex
    read f_CloseButtonImageIndex
    write pm_SetCloseButtonImageIndex;
   property CloseButtonHotImageIndex: TImageIndex
    read f_CloseButtonHotImageIndex
    write pm_SetCloseButtonHotImageIndex;
   property OnNewTabRequested: TChromeLikeTabSetNewTabRequested
    read f_OnNewTabRequested
    write f_OnNewTabRequested;
   property Container: Il3TabbedContainer
    read pm_GetContainer;
 end;//TChromeLikeTabSetControl
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5507EFFD01FEimpl_uses*
 //#UC END# *5507EFFD01FEimpl_uses*
;

procedure TChromeLikeTabCloseButton.pm_SetShowOnlyHovered(aValue: Boolean);
//#UC START# *550912BF02BC_5507F2380319set_var*
//#UC END# *550912BF02BC_5507F2380319set_var*
begin
//#UC START# *550912BF02BC_5507F2380319set_impl*
 if (aValue <> f_ShowOnlyHovered) then
 begin
  f_ShowOnlyHovered := aValue;
  Invalidate;
 end;
//#UC END# *550912BF02BC_5507F2380319set_impl*
end;//TChromeLikeTabCloseButton.pm_SetShowOnlyHovered

procedure TChromeLikeTabCloseButton.pm_SetButtonImages(aValue: TCustomImageList);
//#UC START# *5515355203C1_5507F2380319set_var*
//#UC END# *5515355203C1_5507F2380319set_var*
begin
//#UC START# *5515355203C1_5507F2380319set_impl*
 if (aValue <> f_ButtonImages) then
 begin
  f_ButtonImages := aValue;
  FreeAndNil(f_Image);
  FreeAndNil(f_HotImage);
  if (Parent <> nil) then
   RequestLayoutChildren;
 end;
//#UC END# *5515355203C1_5507F2380319set_impl*
end;//TChromeLikeTabCloseButton.pm_SetButtonImages

procedure TChromeLikeTabCloseButton.pm_SetImageIndex(aValue: TImageIndex);
//#UC START# *5515357403D9_5507F2380319set_var*
//#UC END# *5515357403D9_5507F2380319set_var*
begin
//#UC START# *5515357403D9_5507F2380319set_impl*
 if (aValue <> f_ImageIndex) then
 begin
  f_ImageIndex := aValue;
  FreeAndNil(f_Image);
  if (Parent <> nil) then
   RequestLayoutChildren;
 end;
//#UC END# *5515357403D9_5507F2380319set_impl*
end;//TChromeLikeTabCloseButton.pm_SetImageIndex

procedure TChromeLikeTabCloseButton.pm_SetHotImageIndex(aValue: TImageIndex);
//#UC START# *5515358D0359_5507F2380319set_var*
//#UC END# *5515358D0359_5507F2380319set_var*
begin
//#UC START# *5515358D0359_5507F2380319set_impl*
 if (aValue <> f_HotImageIndex) then
 begin
  f_HotImageIndex := aValue;
  FreeAndNil(f_HotImage);
  if (Parent <> nil) then
   RequestLayoutChildren;
 end;
//#UC END# *5515358D0359_5507F2380319set_impl*
end;//TChromeLikeTabCloseButton.pm_SetHotImageIndex

function TChromeLikeTabCloseButton.pm_GetImage: TGPBitmap;
//#UC START# *551536010170_5507F2380319get_var*
//#UC END# *551536010170_5507F2380319get_var*
begin
//#UC START# *551536010170_5507F2380319get_impl*
 if (f_ButtonImages <> nil) and (f_ImageIndex <> -1) then
 begin
  if (f_Image = nil) then
   f_Image := TGPBitmap(ImageListToTGPImage(f_ButtonImages, f_ImageIndex));
  Result := f_Image;
 end
 else
  Result := nil;
//#UC END# *551536010170_5507F2380319get_impl*
end;//TChromeLikeTabCloseButton.pm_GetImage

function TChromeLikeTabCloseButton.pm_GetHotImage: TGPBitmap;
//#UC START# *5515361300D9_5507F2380319get_var*
//#UC END# *5515361300D9_5507F2380319get_var*
begin
//#UC START# *5515361300D9_5507F2380319get_impl*
 if (f_ButtonImages <> nil) and (f_HotImageIndex <> -1) then
 begin
  if (f_HotImage = nil) then
   f_HotImage := TGPBitmap(ImageListToTGPImage(f_ButtonImages, f_HotImageIndex));
  Result := f_HotImage;
 end
 else
  Result := nil;
//#UC END# *5515361300D9_5507F2380319get_impl*
end;//TChromeLikeTabCloseButton.pm_GetHotImage

procedure TChromeLikeTabCloseButton.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5507F2380319_var*
//#UC END# *479731C50290_5507F2380319_var*
begin
//#UC START# *479731C50290_5507F2380319_impl*
 FreeAndNil(f_Image);
 FreeAndNil(f_HotImage);
 inherited;
//#UC END# *479731C50290_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.Cleanup

procedure TChromeLikeTabCloseButton.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5507F2380319_var*
const
 cStateArr: array[Boolean] of TChromeLikeTabSetElementState = (tsesNormal, tsesHot);
var
 l_Image: TGPImage;
 l_CenterPt: TGPPointF;
 l_LayoutRect: TGPRectF;
 l_Rect: TGPRectF;
 l_Width: Single;
 l_Height: Single;
 l_HalfWidth: Single;
 l_HalfHeight: Single;
//#UC END# *5506AE35023A_5507F2380319_var*
begin
//#UC START# *5506AE35023A_5507F2380319_impl*
 if (State = cltcsHovered) or
    (not ShowOnlyHovered) then
 begin
  if (State = cltcsHovered) then
   l_Image := HotImage
  else
   l_Image := Image;
  Assert(l_Image <> nil);
  l_Width := l_Image.GetWidth;
  l_Height := l_Image.GetHeight;
  l_HalfWidth := l_Width / 2;
  l_HalfHeight := l_Height / 2;

  l_LayoutRect := RectToGPRectF(PositionRect);

  l_CenterPt := MakePoint(l_LayoutRect.X + l_LayoutRect.Width / 2, l_LayoutRect.Y + l_LayoutRect.Height / 2);
  l_Rect := MakeRect(l_CenterPt.X - l_HalfWidth, l_CenterPt.Y - l_HalfHeight, l_Width, l_Height);

  aContext.Graphics.DrawImage(l_Image, l_Rect, 0, 0, l_Width, l_Height, UnitPixel);
  // - Рисовать битмап нужно именно так, иначе на XP ничего не нарисуется. Почему-то.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=595441920
 end;
//#UC END# *5506AE35023A_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.DoPaint

function TChromeLikeTabCloseButton.MeasureSize: TSize;
//#UC START# *5506B04102C9_5507F2380319_var*
//#UC END# *5506B04102C9_5507F2380319_var*
begin
//#UC START# *5506B04102C9_5507F2380319_impl*
 Result := MakeTSize(17, 17);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=609429741
//#UC END# *5506B04102C9_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.MeasureSize

function TChromeLikeTabCloseButton.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5507F2380319_var*
//#UC END# *5506B0630312_5507F2380319_var*
begin
//#UC START# *5506B0630312_5507F2380319_impl*
 Result := [cltcbClickable, cltcbHoverable];
//#UC END# *5506B0630312_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.MakeBehaviourParams

constructor TChromeLikeTabCloseButton.Create(aParent: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506B7960083_5507F2380319_var*
//#UC END# *5506B7960083_5507F2380319_var*
begin
//#UC START# *5506B7960083_5507F2380319_impl*
 inherited;
 f_ShowOnlyHovered := True;
//#UC END# *5506B7960083_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.Create

procedure TChromeLikeTabCloseButton.DoMouseLeave;
//#UC START# *552638BD00A3_5507F2380319_var*
//#UC END# *552638BD00A3_5507F2380319_var*
begin
//#UC START# *552638BD00A3_5507F2380319_impl*
 State := cltcsNormal;
//#UC END# *552638BD00A3_5507F2380319_impl*
end;//TChromeLikeTabCloseButton.DoMouseLeave

procedure TChromeLikeTabIcon.pm_SetImageList(aValue: TCustomImageList);
//#UC START# *550910B6003C_5507F24D0307set_var*
//#UC END# *550910B6003C_5507F24D0307set_var*
begin
//#UC START# *550910B6003C_5507F24D0307set_impl*
 if (aValue <> f_ImageList) then
 begin
  f_ImageList := aValue;
  FreeAndNil(f_Image);
  Invalidate;
 end;
//#UC END# *550910B6003C_5507F24D0307set_impl*
end;//TChromeLikeTabIcon.pm_SetImageList

procedure TChromeLikeTabIcon.pm_SetImageIndex(aValue: TImageIndex);
//#UC START# *550910DC0394_5507F24D0307set_var*
//#UC END# *550910DC0394_5507F24D0307set_var*
begin
//#UC START# *550910DC0394_5507F24D0307set_impl*
 if (aValue <> f_ImageIndex) then
 begin
  f_ImageIndex := aValue;
  FreeAndNil(f_Image);
  Invalidate;
 end;
//#UC END# *550910DC0394_5507F24D0307set_impl*
end;//TChromeLikeTabIcon.pm_SetImageIndex

function TChromeLikeTabIcon.GetImage: TGPImage;
//#UC START# *5509113E00A2_5507F24D0307_var*
//#UC END# *5509113E00A2_5507F24D0307_var*
begin
//#UC START# *5509113E00A2_5507F24D0307_impl*
 if (f_ImageList <> nil) and (f_ImageIndex <> -1) then
 begin
  if (f_Image = nil) then
   f_Image := ImageListToTGPImage(f_ImageList, f_ImageIndex);
  Result := f_Image;
 end
 else
  Result := nil;
//#UC END# *5509113E00A2_5507F24D0307_impl*
end;//TChromeLikeTabIcon.GetImage

procedure TChromeLikeTabIcon.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5507F24D0307_var*
//#UC END# *479731C50290_5507F24D0307_var*
begin
//#UC START# *479731C50290_5507F24D0307_impl*
 FreeAndNil(f_Image);
 inherited;
//#UC END# *479731C50290_5507F24D0307_impl*
end;//TChromeLikeTabIcon.Cleanup

procedure TChromeLikeTabIcon.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5507F24D0307_var*
var
 l_Image: TGPImage;
//#UC END# *5506AE35023A_5507F24D0307_var*
begin
//#UC START# *5506AE35023A_5507F24D0307_impl*
 l_Image := GetImage;
 if (l_Image <> nil) then
  aContext.Graphics.DrawImage(GetImage, RectToGPRectF(PositionRect));
//#UC END# *5506AE35023A_5507F24D0307_impl*
end;//TChromeLikeTabIcon.DoPaint

function TChromeLikeTabIcon.MeasureSize: TSize;
//#UC START# *5506B04102C9_5507F24D0307_var*
//#UC END# *5506B04102C9_5507F24D0307_var*
begin
//#UC START# *5506B04102C9_5507F24D0307_impl*
 if (f_ImageList <> nil) then
  Result := MakeTSize(f_ImageList.Width, f_ImageList.Height)
 else
  Result := MakeTSize(16, 16);
//#UC END# *5506B04102C9_5507F24D0307_impl*
end;//TChromeLikeTabIcon.MeasureSize

function TChromeLikeTabIcon.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5507F24D0307_var*
//#UC END# *5506B0630312_5507F24D0307_var*
begin
//#UC START# *5506B0630312_5507F24D0307_impl*
 Result := [];
//#UC END# *5506B0630312_5507F24D0307_impl*
end;//TChromeLikeTabIcon.MakeBehaviourParams

procedure TChromeLikeTabText.pm_SetText(const aValue: WideString);
//#UC START# *550911EC016C_5507F2580281set_var*
//#UC END# *550911EC016C_5507F2580281set_var*
begin
//#UC START# *550911EC016C_5507F2580281set_impl*
 if (aValue <> f_Text) then
 begin
  f_Text := aValue;
  Invalidate;
 end;
//#UC END# *550911EC016C_5507F2580281set_impl*
end;//TChromeLikeTabText.pm_SetText

procedure TChromeLikeTabText.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5507F2580281_var*
var
 l_Font: TGPFont;
 l_Rect: TGPRectF;
 l_Format: TGPStringFormat;
 l_Brush: TGPBrush;
//#UC END# *5506AE35023A_5507F2580281_var*
begin
//#UC START# *5506AE35023A_5507F2580281_impl*
 l_Rect   := RectToGPRectF(PositionRect);
 l_Font   := TChromeLikeTabSetStyles.MakeFont(tsseTabText, tsesNormal);
 try
  l_Format := TGPStringFormat.Create(StringFormatFlagsNoWrap);
  try
   with l_Format do
   begin
    SetTrimming(StringTrimmingEllipsisCharacter);
    SetAlignment(StringAlignmentNear);
    SetLineAlignment(StringAlignmentCenter);
   end;//with l_Format
   aContext.Graphics.SetTextRenderingHint(TextRenderingHintAntiAliasGridFit);
   // - Иначе вместо текста будет "мазня" при включенном Aero
   l_Brush :=  TGPLinearGradientBrush.Create(l_Rect,
    MakeGDIPColor(clBlack),
    MakeGDIPColor(clBlack),
    LinearGradientModeHorizontal);
   // - текст на Aeroglass нормально можно вывести только TGPLinearGradientBrush
   try
    aContext.Graphics.DrawString(Text, Length(Text), l_Font, l_Rect, l_Format, l_Brush);
   finally
    FreeAndNil(l_Brush);
   end;//try..finally
  finally
   FreeAndNil(l_Format);
  end;//try..finally
 finally
  FreeAndNil(l_Font);
 end;
//#UC END# *5506AE35023A_5507F2580281_impl*
end;//TChromeLikeTabText.DoPaint

function TChromeLikeTabText.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5507F2580281_var*
//#UC END# *5506B0630312_5507F2580281_var*
begin
//#UC START# *5506B0630312_5507F2580281_impl*
 Result := [];
//#UC END# *5506B0630312_5507F2580281_impl*
end;//TChromeLikeTabText.MakeBehaviourParams

procedure TChromeLikeTabText.ClearFields;
begin
 f_Text := '';
 inherited;
end;//TChromeLikeTabText.ClearFields

function TChromeLikeTab.pm_GetText: WideString;
//#UC START# *550913480304_5507F22E0057get_var*
//#UC END# *550913480304_5507F22E0057get_var*
begin
//#UC START# *550913480304_5507F22E0057get_impl*
 Result := f_Text;
//#UC END# *550913480304_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetText

procedure TChromeLikeTab.pm_SetText(const aValue: WideString);
//#UC START# *550913480304_5507F22E0057set_var*
//#UC END# *550913480304_5507F22E0057set_var*
begin
//#UC START# *550913480304_5507F22E0057set_impl*
 if (aValue <> f_Text) then
 begin
  f_Text := aValue;
  f_TextControl.Text := f_Text;
  Invalidate;
 end;
//#UC END# *550913480304_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetText

function TChromeLikeTab.pm_GetSelected: Boolean;
//#UC START# *550913720354_5507F22E0057get_var*
//#UC END# *550913720354_5507F22E0057get_var*
begin
//#UC START# *550913720354_5507F22E0057get_impl*
 Result := f_Selected;
//#UC END# *550913720354_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetSelected

procedure TChromeLikeTab.pm_SetSelected(aValue: Boolean);
//#UC START# *550913720354_5507F22E0057set_var*
//#UC END# *550913720354_5507F22E0057set_var*
begin
//#UC START# *550913720354_5507F22E0057set_impl*
 if (aValue <> f_Selected) then
 begin
  f_Selected := aValue;
  SelectionChanged;
  Invalidate;
 end;
//#UC END# *550913720354_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetSelected

procedure TChromeLikeTab.pm_SetForm(aValue: TForm);
//#UC START# *550914C601E3_5507F22E0057set_var*
//#UC END# *550914C601E3_5507F22E0057set_var*
begin
//#UC START# *550914C601E3_5507F22E0057set_impl*
 f_Form := aValue;
//#UC END# *550914C601E3_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetForm

function TChromeLikeTab.pm_GetImageIndex: TImageIndex;
//#UC START# *5509151603D4_5507F22E0057get_var*
//#UC END# *5509151603D4_5507F22E0057get_var*
begin
//#UC START# *5509151603D4_5507F22E0057get_impl*
 Result := f_ImageIndex;
//#UC END# *5509151603D4_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetImageIndex

procedure TChromeLikeTab.pm_SetImageIndex(aValue: TImageIndex);
//#UC START# *5509151603D4_5507F22E0057set_var*
//#UC END# *5509151603D4_5507F22E0057set_var*
begin
//#UC START# *5509151603D4_5507F22E0057set_impl*
 if (aValue <> f_ImageIndex) then
 begin
  f_ImageIndex := aValue;
  f_Icon.ImageIndex := f_ImageIndex;
 end;
//#UC END# *5509151603D4_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetImageIndex

procedure TChromeLikeTab.pm_SetImageList(aValue: TCustomImageList);
//#UC START# *55091549034D_5507F22E0057set_var*
//#UC END# *55091549034D_5507F22E0057set_var*
begin
//#UC START# *55091549034D_5507F22E0057set_impl*
 if (aValue <> f_ImageList) then
 begin
  f_ImageList := aValue;
  f_Icon.ImageList := f_ImageList;
 end;
//#UC END# *55091549034D_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetImageList

procedure TChromeLikeTab.pm_SetSlotIndex(aValue: Integer);
//#UC START# *550915840304_5507F22E0057set_var*
//#UC END# *550915840304_5507F22E0057set_var*
begin
//#UC START# *550915840304_5507F22E0057set_impl*
 if (aValue <> f_SlotIndex) then
 begin
  f_SlotIndex := aValue;
 end; 
//#UC END# *550915840304_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetSlotIndex

procedure TChromeLikeTab.pm_SetCloseButtonImages(aValue: TCustomImageList);
//#UC START# *5515476502F2_5507F22E0057set_var*
//#UC END# *5515476502F2_5507F22E0057set_var*
begin
//#UC START# *5515476502F2_5507F22E0057set_impl*
 if (f_CloseButtonImages <> aValue) then
 begin
  f_CloseButtonImages := aValue;
  if (f_CloseButton <> nil) then
   f_CloseButton.ButtonImages := f_CloseButtonImages;
 end;
//#UC END# *5515476502F2_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetCloseButtonImages

procedure TChromeLikeTab.pm_SetCloseButtonImageIndex(aValue: TImageIndex);
//#UC START# *55154DE60112_5507F22E0057set_var*
//#UC END# *55154DE60112_5507F22E0057set_var*
begin
//#UC START# *55154DE60112_5507F22E0057set_impl*
 if (aValue <> f_CloseButtonImageIndex) then
 begin
  f_CloseButtonImageIndex := aValue;
  if (f_CloseButton <> nil) then
   f_CloseButton.ImageIndex := f_CloseButtonImageIndex;
 end;
//#UC END# *55154DE60112_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetCloseButtonImageIndex

procedure TChromeLikeTab.pm_SetCloseButtonHotImageIndex(aValue: TImageIndex);
//#UC START# *55154E010152_5507F22E0057set_var*
//#UC END# *55154E010152_5507F22E0057set_var*
begin
//#UC START# *55154E010152_5507F22E0057set_impl*
 if (aValue <> f_CloseButtonHotImageIndex) then
 begin
  f_CloseButtonHotImageIndex := aValue;
  if (f_CloseButton <> nil) then
   f_CloseButton.HotImageIndex := f_CloseButtonHotImageIndex;
 end;
//#UC END# *55154E010152_5507F22E0057set_impl*
end;//TChromeLikeTab.pm_SetCloseButtonHotImageIndex

procedure TChromeLikeTab.DoOnCloseButtonClick(Sender: TObject);
//#UC START# *550915DC024B_5507F22E0057_var*
//#UC END# *550915DC024B_5507F22E0057_var*
begin
//#UC START# *550915DC024B_5507F22E0057_impl*
 CloseTab;
//#UC END# *550915DC024B_5507F22E0057_impl*
end;//TChromeLikeTab.DoOnCloseButtonClick

procedure TChromeLikeTab.SelectionChanged;
//#UC START# *550915FA0072_5507F22E0057_var*
//#UC END# *550915FA0072_5507F22E0057_var*
begin
//#UC START# *550915FA0072_5507F22E0057_impl*
 f_CloseButton.ShowOnlyHovered := (not pm_GetSelected);
//#UC END# *550915FA0072_5507F22E0057_impl*
end;//TChromeLikeTab.SelectionChanged

procedure TChromeLikeTab.MakePaths;
//#UC START# *5509160503A9_5507F22E0057_var*
var
 l_RectF: TGPRectF;
 l_EllipseDiameter: Single;
 l_LeftCornerRect: TGPRectF;
 l_RightCornerRect: TGPRectF;
 l_ArcBottom: Single;
 l_Bottom: Single;
 l_Right: Single;
//#UC END# *5509160503A9_5507F22E0057_var*
begin
//#UC START# *5509160503A9_5507F22E0057_impl*
 FreeAndNil(f_BodyPath);
 FreeAndNil(f_LeftTopEdgePath);
 FreeAndNil(f_RightEdgePath);
 FreeAndNil(f_BottomEdgePath);

 f_BodyPath := TGPGraphicsPath.Create;
 f_LeftTopEdgePath := TGPGraphicsPath.Create;
 f_RightEdgePath := TGPGraphicsPath.Create;
 f_BottomEdgePath := TGPGraphicsPath.Create;

 l_RectF := RectToGPRectF(PositionRect);
 l_EllipseDiameter := f_RoundingRadius * 2;

 with l_LeftCornerRect do
 begin
  X := l_RectF.X;
  Y := l_RectF.Y;
  Width := l_EllipseDiameter;
  Height := l_EllipseDiameter;
 end;

 with l_RightCornerRect do
 begin
  X := (l_RectF.X + l_RectF.Width) - l_EllipseDiameter;
  Y := l_RectF.Y;
  Width := l_EllipseDiameter;
  Height := l_EllipseDiameter;
 end;

 l_ArcBottom := l_RightCornerRect.Y + l_EllipseDiameter;
 l_Bottom := l_RectF.Y + l_RectF.Height;
 l_Right := l_RectF.X + l_RectF.Width;

 with f_BodyPath do
 // Заливка
 begin
  AddLine(l_RectF.X,
          l_Bottom,
          l_RectF.X,
          l_ArcBottom);

  AddArc(l_LeftCornerRect,
         180,
         90);

  AddArc(l_RightCornerRect,
         270,
         90);

  AddLine(l_Right,
          l_ArcBottom,
          l_Right,
          l_Bottom);
 end;//with f_BodyPath

 with f_LeftTopEdgePath do
 // Левая и верхняя окантовка
 begin
  AddLine(l_RectF.X,
          l_Bottom,
          l_RectF.X,
          l_ArcBottom);
  // - левая граница
  AddArc(l_LeftCornerRect,
         180,
         90);
  // - левое закругление
  AddLine(l_LeftCornerRect.X + l_LeftCornerRect.Width,
          l_RectF.Y,
          l_RightCornerRect.X,
          l_RectF.Y);
  // - Верхняя граница
  AddArc(l_RightCornerRect, 270, 45);
  // - Половина правого закругления
 end;

 with f_RightEdgePath do
 // Правая окантовка
 begin
  AddArc(l_RightCornerRect,
         315,
         45);
  // - Вторая половина правого закругления
  AddLine(l_Right,
          l_ArcBottom,
          l_Right,
          l_Bottom);
 end;

 with f_BottomEdgePath do
 // Нижняя граница
 begin
  AddLine(l_RectF.X,
          l_RectF.Y + l_RectF.Height,
          l_RectF.X + l_RectF.Width,
          l_RectF.Y + l_RectF.Height);
 end;
//#UC END# *5509160503A9_5507F22E0057_impl*
end;//TChromeLikeTab.MakePaths

function TChromeLikeTab.GetTabSide(const aPoint: TPoint): TChromeLikeTabSide;
//#UC START# *550919550287_5507F22E0057_var*
var
 l_CenterPoint: TPoint;
//#UC END# *550919550287_5507F22E0057_var*
begin
//#UC START# *550919550287_5507F22E0057_impl*
 l_CenterPoint := CenterPoint(PositionRect);
 if InRange(aPoint.X, PositionRect.Left, l_CenterPoint.X) then
  Result := cltsLeft
 else
  Result := cltsRight;
//#UC END# *550919550287_5507F22E0057_impl*
end;//TChromeLikeTab.GetTabSide

function TChromeLikeTab.NeedSelectByClickAtPoint(const aPoint: TPoint): Boolean;
//#UC START# *5509197902D2_5507F22E0057_var*
//#UC END# *5509197902D2_5507F22E0057_var*
begin
//#UC START# *5509197902D2_5507F22E0057_impl*
 Result := Intersects(aPoint) and
           (not (f_CloseButton.Visible and f_CloseButton.Intersects(aPoint)));
//#UC END# *5509197902D2_5507F22E0057_impl*
end;//TChromeLikeTab.NeedSelectByClickAtPoint

constructor TChromeLikeTab.Create(aTabSet: TChromeLikeTabSetControlPrim);
//#UC START# *55111E87034D_5507F22E0057_var*
//#UC END# *55111E87034D_5507F22E0057_var*
begin
//#UC START# *55111E87034D_5507F22E0057_impl*
 f_TabSet := aTabSet;
 f_ImageList := aTabSet.Images;
 inherited Create(nil);
 f_RoundingRadius := 3.0;
//#UC END# *55111E87034D_5507F22E0057_impl*
end;//TChromeLikeTab.Create

procedure TChromeLikeTab.CloseTab;
//#UC START# *5541CFB50145_5507F22E0057_var*
//#UC END# *5541CFB50145_5507F22E0057_var*
begin
//#UC START# *5541CFB50145_5507F22E0057_impl*
 if (not InAnimation) then
  if Assigned(f_OnNeedCloseTab) then
   f_OnNeedCloseTab(Self);
//#UC END# *5541CFB50145_5507F22E0057_impl*
end;//TChromeLikeTab.CloseTab

function TChromeLikeTab.CanBeCloned: Boolean;
//#UC START# *555DB9420006_5507F22E0057_var*
//#UC END# *555DB9420006_5507F22E0057_var*
begin
//#UC START# *555DB9420006_5507F22E0057_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.CanCloneTab(Self);
//#UC END# *555DB9420006_5507F22E0057_impl*
end;//TChromeLikeTab.CanBeCloned

function TChromeLikeTab.MakeClone: Il3FormTab;
//#UC START# *5555A18701F0_5507F22E0057_var*
//#UC END# *5555A18701F0_5507F22E0057_var*
begin
//#UC START# *5555A18701F0_5507F22E0057_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.CloneTab(Self);
//#UC END# *5555A18701F0_5507F22E0057_impl*
end;//TChromeLikeTab.MakeClone

function TChromeLikeTab.pm_GetTabbedForm: TForm;
//#UC START# *555C5E4B0048_5507F22E0057get_var*
//#UC END# *555C5E4B0048_5507F22E0057get_var*
begin
//#UC START# *555C5E4B0048_5507F22E0057get_impl*
 Result := Form;
//#UC END# *555C5E4B0048_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetTabbedForm

function TChromeLikeTab.pm_GetTabbedContainer: Il3TabbedContainer;
//#UC START# *556835BC03E1_5507F22E0057get_var*
var
 l_Form: TCustomForm;
 l_Container: Il3TabbedContainer;
//#UC END# *556835BC03E1_5507F22E0057get_var*
begin
//#UC START# *556835BC03E1_5507F22E0057get_impl*
 l_Form := GetParentForm(TabSet);
 if Supports(l_Form, Il3TabbedContainer, l_Container) then
  Result := l_Container
 else
  Assert(False);
//#UC END# *556835BC03E1_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetTabbedContainer

function TChromeLikeTab.pm_GetVisibleIndex: Integer;
//#UC START# *5583FC49016F_5507F22E0057get_var*
//#UC END# *5583FC49016F_5507F22E0057get_var*
begin
//#UC START# *5583FC49016F_5507F22E0057get_impl*
 Result := SlotIndex;
//#UC END# *5583FC49016F_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetVisibleIndex

procedure TChromeLikeTab.AssignParams(const aParams: Il3TabParams);
//#UC START# *55ED2AC800E4_5507F22E0057_var*
//#UC END# *55ED2AC800E4_5507F22E0057_var*
begin
//#UC START# *55ED2AC800E4_5507F22E0057_impl*
 Assert(aParams <> nil);
 Text := aParams.Text;
 HintText := aParams.HintText;
 ImageIndex := aParams.ImageIndex;
//#UC END# *55ED2AC800E4_5507F22E0057_impl*
end;//TChromeLikeTab.AssignParams

function TChromeLikeTab.pm_GetCurrentParams: Il3TabParams;
//#UC START# *55ED2AE10007_5507F22E0057get_var*
//#UC END# *55ED2AE10007_5507F22E0057get_var*
begin
//#UC START# *55ED2AE10007_5507F22E0057get_impl*
 Result := TChromeLikeTabParams.Make(l3CStr(Text), l3CStr(HintText),
  ImageIndex, [tuo_UpdateHintText, tuo_UpdateTabText, tuo_UpdateTabImage]);
//#UC END# *55ED2AE10007_5507F22E0057get_impl*
end;//TChromeLikeTab.pm_GetCurrentParams

procedure TChromeLikeTab.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5507F22E0057_var*
//#UC END# *479731C50290_5507F22E0057_var*
begin
//#UC START# *479731C50290_5507F22E0057_impl*
 FreeAndNil(f_LeftTopEdgePath);
 FreeAndNil(f_BodyPath);
 FreeAndNil(f_RightEdgePath);
 FreeAndNil(f_BottomEdgePath);
 inherited;
//#UC END# *479731C50290_5507F22E0057_impl*
end;//TChromeLikeTab.Cleanup

procedure TChromeLikeTab.Invalidate;
//#UC START# *5506AE050362_5507F22E0057_var*
//#UC END# *5506AE050362_5507F22E0057_var*
begin
//#UC START# *5506AE050362_5507F22E0057_impl*
 TabSet.Invalidate;
//#UC END# *5506AE050362_5507F22E0057_impl*
end;//TChromeLikeTab.Invalidate

procedure TChromeLikeTab.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5507F22E0057_var*
const
 cStateArr: array[Boolean] of TChromeLikeTabSetElementState = (tsesNormal, tsesActive);
var
 l_State: TChromeLikeTabSetElementState;
 l_Brush: TGPBrush;
 l_LightPen: TGPPen;
 l_DarkPen: TGPPen;
 l_BottomPen: TGPPen;
 l_StringFormat: TGPStringFormat;
 l_Font: TGPFont;
 l_Str: WideString;
//#UC END# *5506AE35023A_5507F22E0057_var*
begin
//#UC START# *5506AE35023A_5507F22E0057_impl*
 l_State := cStateArr[pm_GetSelected];
 l_Brush := TChromeLikeTabSetStyles.MakeBrush(tsseTabBackground, l_State);
 try
  aContext.Graphics.FillPath(l_Brush, f_BodyPath);
 finally
  FreeAndNil(l_Brush);
 end;//try..finally

 l_LightPen := TChromeLikeTabSetStyles.MakePen(tsseTabBorderLeft, l_State);
 try
  aContext.Graphics.DrawPath(l_LightPen, f_LeftTopEdgePath);
 finally
  FreeAndNil(l_LightPen);
 end;//try..finally

 l_DarkPen := TChromeLikeTabSetStyles.MakePen(tsseTabBorderRight, l_State);
 try
  aContext.Graphics.DrawPath(l_DarkPen, f_RightEdgePath);
 finally
  FreeAndNil(l_DarkPen);
 end;//try..finally

 l_BottomPen := TChromeLikeTabSetStyles.MakePen(tsseTabBorderBottom, l_State);
 try
  aContext.Graphics.DrawPath(l_BottomPen, f_BottomEdgePath);
 finally
  FreeAndNil(l_BottomPen);
 end;//try..finally
//#UC END# *5506AE35023A_5507F22E0057_impl*
end;//TChromeLikeTab.DoPaint

procedure TChromeLikeTab.DoMouseMove(const aPoint: TPoint);
//#UC START# *5506AE54016E_5507F22E0057_var*
//#UC END# *5506AE54016E_5507F22E0057_var*
begin
//#UC START# *5506AE54016E_5507F22E0057_impl*
 inherited;
//#UC END# *5506AE54016E_5507F22E0057_impl*
end;//TChromeLikeTab.DoMouseMove

procedure TChromeLikeTab.DoClick(const aPoint: TPoint);
//#UC START# *5506AE90023B_5507F22E0057_var*
//#UC END# *5506AE90023B_5507F22E0057_var*
begin
//#UC START# *5506AE90023B_5507F22E0057_impl*
 inherited;
//#UC END# *5506AE90023B_5507F22E0057_impl*
end;//TChromeLikeTab.DoClick

procedure TChromeLikeTab.PositionChanged;
//#UC START# *5506AEB502A2_5507F22E0057_var*
//#UC END# *5506AEB502A2_5507F22E0057_var*
begin
//#UC START# *5506AEB502A2_5507F22E0057_impl*
 inherited;
 MakePaths;
//#UC END# *5506AEB502A2_5507F22E0057_impl*
end;//TChromeLikeTab.PositionChanged

function TChromeLikeTab.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5507F22E0057_var*
//#UC END# *5506B0630312_5507F22E0057_var*
begin
//#UC START# *5506B0630312_5507F22E0057_impl*
 Result := Result + [cltcbMovable, cltcbClickable, cltcbUndockable, cltcbAnimable,
  cltcbMiddleButtonClickable];
//#UC END# *5506B0630312_5507F22E0057_impl*
end;//TChromeLikeTab.MakeBehaviourParams

procedure TChromeLikeTab.MakeChildControls;
//#UC START# *5506B0910208_5507F22E0057_var*
//#UC END# *5506B0910208_5507F22E0057_var*
begin
//#UC START# *5506B0910208_5507F22E0057_impl*
 f_CloseButton := TChromeLikeTabCloseButton.Create(Self);
 with f_CloseButton do
 begin
  Margins.Top := 8;
  Margins.Bottom := 8;
  Margins.Right := 4;
  Parent := Self;
  f_CloseButton.ButtonImages := f_CloseButtonImages;
  f_CloseButton.ImageIndex := f_CloseButtonImageIndex;
  f_CloseButton.HotImageIndex := f_CloseButtonImageIndex;
  f_CloseButton.Align := alRight;
  f_CloseButton.OnClick := DoOnCloseButtonClick;
 end;//with f_CloseButton
 f_Icon := TChromeLikeTabIcon.Create(Self);
 with f_Icon do
 begin
  ImageList := Self.f_ImageList;
  ImageIndex := 0;
  Parent := Self;
  Margins.Left := 5;
  Margins.Right := 5;
  Align := alLeft;
 end;//with f_Icon
 f_TextControl := TChromeLikeTabText.Create(Self);
 with f_TextControl do
 begin
  Align := alClient;
  Parent := Self;
  Text := Self.Text;
 end;//with f_Text
//#UC END# *5506B0910208_5507F22E0057_impl*
end;//TChromeLikeTab.MakeChildControls

function TChromeLikeTab.DoGetCanMove(const aPoint: TPoint): Boolean;
//#UC START# *5506B0A5038A_5507F22E0057_var*
var
 l_ControlAtPoint: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5506B0A5038A_5507F22E0057_var*
begin
//#UC START# *5506B0A5038A_5507F22E0057_impl*
 l_ControlAtPoint := HitTest(aPoint);
 Result := (l_ControlAtPoint <> f_CloseButton) and
            inherited DoGetCanMove(aPoint);
//#UC END# *5506B0A5038A_5507F22E0057_impl*
end;//TChromeLikeTab.DoGetCanMove

procedure TChromeLikeTab.DoMiddleButtonClick(const aPoint: TPoint);
//#UC START# *5541B8C900EE_5507F22E0057_var*
//#UC END# *5541B8C900EE_5507F22E0057_var*
begin
//#UC START# *5541B8C900EE_5507F22E0057_impl*
 CloseTab;
//#UC END# *5541B8C900EE_5507F22E0057_impl*
end;//TChromeLikeTab.DoMiddleButtonClick

procedure TChromeLikeTab.ClearFields;
begin
 f_Text := '';
 inherited;
end;//TChromeLikeTab.ClearFields

type _Instance_R_ = TChromeLikeTabList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

function TChromeLikeTabAction.pm_GetTab: TChromeLikeTab;
//#UC START# *553F56960377_553F55FD034Aget_var*
//#UC END# *553F56960377_553F55FD034Aget_var*
begin
//#UC START# *553F56960377_553F55FD034Aget_impl*
 Result := f_Tab;
//#UC END# *553F56960377_553F55FD034Aget_impl*
end;//TChromeLikeTabAction.pm_GetTab

procedure TChromeLikeTabAction.pm_SetTab(aValue: TChromeLikeTab);
//#UC START# *553F56960377_553F55FD034Aset_var*
//#UC END# *553F56960377_553F55FD034Aset_var*
begin
//#UC START# *553F56960377_553F55FD034Aset_impl*
 f_Tab := aValue;
//#UC END# *553F56960377_553F55FD034Aset_impl*
end;//TChromeLikeTabAction.pm_SetTab

procedure TChromeLikeNewTabButton.MakePaths;
//#UC START# *5540B9B602F0_5540B1BC0019_var*
const
 cCrossPoly: packed array[0..12] of TGPPoint = (
   (X: 0; Y: 4),
   (X: 4; Y: 4),
   (X: 4; Y: 0),
   (X: 7; Y: 0),
   (X: 7; Y: 4),
   (X: 11; Y: 4),
   (X: 11; Y: 7),
   (X: 7; Y: 7),
   (X: 7; Y: 11),
   (X: 4; Y: 11),
   (X: 4; Y: 7),
   (X: 0; Y: 7),
   (X: 0; Y: 4)
 );
 cCrossInner: packed array[0..12] of TGPPoint = (
   (X: 1; Y: 5),
   (X: 5; Y: 5),
   (X: 5; Y: 1),
   (X: 7; Y: 1),
   (X: 7; Y: 5),
   (X: 11; Y: 5),
   (X: 11; Y: 7),
   (X: 7; Y: 7),
   (X: 7; Y: 11),
   (X: 5; Y: 11),
   (X: 5; Y: 7),
   (X: 1; Y: 7),
   (X: 1; Y: 5)
 );

var
 l_RectF: TGPRectF;
 l_EllipseDiameter: Single;
 l_RightCornerRect: TGPRectF;
 l_ArcBottom: Single;
 l_Bottom: Single;
 l_Right: Single;
//#UC END# *5540B9B602F0_5540B1BC0019_var*
begin
//#UC START# *5540B9B602F0_5540B1BC0019_impl*
 FreeAndNil(f_BackgroundPath);
 FreeAndNil(f_PlusPath);
 FreeAndNil(f_PlusEdgePath);
 
 f_BackgroundPath := TGPGraphicsPath.Create;
 f_PlusPath := TGPGraphicsPath.Create;
 f_PlusEdgePath := TGPGraphicsPath.Create;

 l_RectF := RectToGPRectF(PositionRect);
 l_EllipseDiameter := (f_RoundingRadius * 2) + 1;

 with l_RightCornerRect do
 begin
  X := (l_RectF.X + l_RectF.Width) - l_EllipseDiameter;
  Y := l_RectF.Y;
  Width := l_EllipseDiameter;
  Height := l_EllipseDiameter;
 end;//with l_RightCornerRect

 l_ArcBottom := l_RightCornerRect.Y + l_EllipseDiameter;
 l_Bottom := l_RectF.Y + l_RectF.Height;
 l_Right := l_RectF.X + l_RectF.Width;

 f_BackgroundPath.AddArc(l_RightCornerRect,
        270,
        90);

 with f_BackgroundPath do
 begin
  AddLine(l_Right, l_ArcBottom, l_Right, l_Bottom);
  AddLine(l_Right, l_Bottom, l_RectF.X, l_Bottom);
  AddLine(l_RectF.X, l_Bottom, l_RectF.X, l_RectF.Y);
 end;//with f_BackgroundPath

 f_PlusPath.AddPolygon(PGPPoint(@cCrossInner[0]), Length(cCrossInner));
 f_PlusEdgePath.AddPolygon(PGPPoint(@cCrossPoly[0]), Length(cCrossPoly));
//#UC END# *5540B9B602F0_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.MakePaths

constructor TChromeLikeNewTabButton.Create(aTabSet: TChromeLikeTabSetControlPrim);
//#UC START# *5541FEB4000B_5540B1BC0019_var*
//#UC END# *5541FEB4000B_5540B1BC0019_var*
begin
//#UC START# *5541FEB4000B_5540B1BC0019_impl*
 f_TabSet := aTabSet;
 f_RoundingRadius := 3.0; 
 inherited Create(nil);
//#UC END# *5541FEB4000B_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.Create

procedure TChromeLikeNewTabButton.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5540B1BC0019_var*
//#UC END# *479731C50290_5540B1BC0019_var*
begin
//#UC START# *479731C50290_5540B1BC0019_impl*
 FreeAndNil(f_BackgroundPath);
 FreeAndNil(f_PlusPath);
 FreeAndNil(f_PlusEdgePath);
 inherited;
//#UC END# *479731C50290_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.Cleanup

procedure TChromeLikeNewTabButton.Invalidate;
//#UC START# *5506AE050362_5540B1BC0019_var*
//#UC END# *5506AE050362_5540B1BC0019_var*
begin
//#UC START# *5506AE050362_5540B1BC0019_impl*
 f_TabSet.Invalidate;
//#UC END# *5506AE050362_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.Invalidate

procedure TChromeLikeNewTabButton.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5540B1BC0019_var*
const
 cStateArr: array[Boolean] of TChromeLikeTabSetElementState = (tsesNormal, tsesHot);
var
 l_Pen: TGPPen;
 l_Brush: TGPBrush;
 l_Rect: TGPRect;
 l_PlusPathBounds: TGPRect;
 l_PlusSize: TSize;
//#UC END# *5506AE35023A_5540B1BC0019_var*
begin
//#UC START# *5506AE35023A_5540B1BC0019_impl*
 l_Brush := TChromeLikeTabSetStyles.MakeBrush(tsseNewTabButtonBackground,
  cStateArr[State = cltcsHovered]);
 try
  aContext.Graphics.FillPath(l_Brush, f_BackgroundPath);
 finally
  FreeAndNil(l_Brush);
 end;//try..finally

 l_Rect := RectToGPRect(PositionRect);
 f_PlusPath.GetBounds(l_PlusPathBounds);
 l_PlusSize.cx := l_PlusPathBounds.Width;
 l_PlusSize.cy := l_PlusPathBounds.Height;
 aContext.Graphics.TranslateTransform(l_Rect.X + 12, l_Rect.Y + 6);
 try
  l_Brush := TChromeLikeTabSetStyles.MakeBrush(tsseNewTabButtonPlusSignBody, tsesNormal);
  try
   aContext.Graphics.FillPath(l_Brush, f_PlusPath);
  finally
   FreeAndNil(l_Brush);
  end;//try..finally
  l_Pen := TChromeLikeTabSetStyles.MakePen(tsseNewTabButtonPlusSignOutline, tsesNormal);
  try
   aContext.Graphics.DrawPath(l_Pen, f_PlusEdgePath);
  finally
   FreeAndNil(l_Pen);
  end;//try..finally
 finally
  aContext.Graphics.ResetTransform;
 end;
//#UC END# *5506AE35023A_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.DoPaint

procedure TChromeLikeNewTabButton.DoClick(const aPoint: TPoint);
//#UC START# *5506AE90023B_5540B1BC0019_var*

 procedure lp_CheckState;
 var
  l_MousePt: TPoint;
 begin
  GetCursorPos(l_MousePt);
  l_MousePt := f_TabSet.ScreenToClient(l_MousePt);
  if PtInRect(PositionRect, l_MousePt) then
   State := cltcsHovered
  else
   State := cltcsNormal;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=600654517
 end;

//#UC END# *5506AE90023B_5540B1BC0019_var*
begin
//#UC START# *5506AE90023B_5540B1BC0019_impl*
 lp_CheckState;
 inherited;
 lp_CheckState;
//#UC END# *5506AE90023B_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.DoClick

procedure TChromeLikeNewTabButton.PositionChanged;
//#UC START# *5506AEB502A2_5540B1BC0019_var*
//#UC END# *5506AEB502A2_5540B1BC0019_var*
begin
//#UC START# *5506AEB502A2_5540B1BC0019_impl*
 inherited;
 MakePaths;
//#UC END# *5506AEB502A2_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.PositionChanged

function TChromeLikeNewTabButton.MeasureSize: TSize;
//#UC START# *5506B04102C9_5540B1BC0019_var*
//#UC END# *5506B04102C9_5540B1BC0019_var*
begin
//#UC START# *5506B04102C9_5540B1BC0019_impl*
 Result.cx := 36;
 Result.cy := cDefaultTabHeight;
//#UC END# *5506B04102C9_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.MeasureSize

function TChromeLikeNewTabButton.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5540B1BC0019_var*
//#UC END# *5506B0630312_5540B1BC0019_var*
begin
//#UC START# *5506B0630312_5540B1BC0019_impl*
 Result := [cltcbClickable, cltcbHoverable];
//#UC END# *5506B0630312_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.MakeBehaviourParams

procedure TChromeLikeNewTabButton.DoMouseLeave;
//#UC START# *552638BD00A3_5540B1BC0019_var*
//#UC END# *552638BD00A3_5540B1BC0019_var*
begin
//#UC START# *552638BD00A3_5540B1BC0019_impl*
 State := cltcsNormal;
//#UC END# *552638BD00A3_5540B1BC0019_impl*
end;//TChromeLikeNewTabButton.DoMouseLeave

function TChromeLikeTabSetControl.pm_GetTabHeight: Integer;
//#UC START# *5507F75A00D0_5507EFFD01FEget_var*
//#UC END# *5507F75A00D0_5507EFFD01FEget_var*
begin
//#UC START# *5507F75A00D0_5507EFFD01FEget_impl*
 Result := f_TabHeight;
//#UC END# *5507F75A00D0_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetTabHeight

procedure TChromeLikeTabSetControl.pm_SetTabHeight(aValue: Integer);
//#UC START# *5507F75A00D0_5507EFFD01FEset_var*
//#UC END# *5507F75A00D0_5507EFFD01FEset_var*
begin
//#UC START# *5507F75A00D0_5507EFFD01FEset_impl*
 if (f_TabHeight <> aValue) then
 begin
  f_TabHeight := aValue;
 end; 
//#UC END# *5507F75A00D0_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetTabHeight

function TChromeLikeTabSetControl.pm_GetTabCount: Integer;
//#UC START# *5507F7710150_5507EFFD01FEget_var*
//#UC END# *5507F7710150_5507EFFD01FEget_var*
begin
//#UC START# *5507F7710150_5507EFFD01FEget_impl*
 Result := f_Tabs.Count;
//#UC END# *5507F7710150_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetTabCount

function TChromeLikeTabSetControl.pm_GetTabs(Index: Integer): TChromeLikeTab;
//#UC START# *5507F78D00C0_5507EFFD01FEget_var*
//#UC END# *5507F78D00C0_5507EFFD01FEget_var*
begin
//#UC START# *5507F78D00C0_5507EFFD01FEget_impl*
 Result := f_Tabs[Index];
//#UC END# *5507F78D00C0_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetTabs

function TChromeLikeTabSetControl.pm_GetFormTabs(Form: TForm): TChromeLikeTab;
//#UC START# *5507F7C60231_5507EFFD01FEget_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
//#UC END# *5507F7C60231_5507EFFD01FEget_var*
begin
//#UC START# *5507F7C60231_5507EFFD01FEget_impl*
 Result := nil;
 for l_Index := 0 to Pred(f_Tabs.Count) do
 begin
  l_Tab := f_Tabs[l_Index];
  if (l_Tab.Form = Form) then
  begin
   Result := l_Tab;
   Break;
  end;
 end;
//#UC END# *5507F7C60231_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetFormTabs

procedure TChromeLikeTabSetControl.pm_SetSelectedTab(aValue: TChromeLikeTab);
//#UC START# *5507F8200188_5507EFFD01FEset_var*
var
 l_PrevSelected: TChromeLikeTab;
//#UC END# *5507F8200188_5507EFFD01FEset_var*
begin
//#UC START# *5507F8200188_5507EFFD01FEset_impl*
 if (aValue <> f_SelectedTab) then
 begin
  l_PrevSelected := f_SelectedTab;
  f_SelectedTab := aValue;
  if Assigned(f_OnSelectionChanged) then
   f_OnSelectionChanged(Self, l_PrevSelected, f_SelectedTab);
  if (l_PrevSelected <> nil) then
   l_PrevSelected.pm_SetSelected(False);
  f_SelectedTab.pm_SetSelected(True);
  Invalidate;
 end;
//#UC END# *5507F8200188_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetSelectedTab

function TChromeLikeTabSetControl.pm_GetSelectedForm: TForm;
//#UC START# *5507F84B03A8_5507EFFD01FEget_var*
//#UC END# *5507F84B03A8_5507EFFD01FEget_var*
begin
//#UC START# *5507F84B03A8_5507EFFD01FEget_impl*
 if (SelectedTab <> nil) then
  Result := SelectedTab.Form
 else
  Result := nil;
//#UC END# *5507F84B03A8_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetSelectedForm

procedure TChromeLikeTabSetControl.pm_SetSelectedForm(aValue: TForm);
//#UC START# *5507F84B03A8_5507EFFD01FEset_var*
var
 l_FormTab: TChromeLikeTab;
//#UC END# *5507F84B03A8_5507EFFD01FEset_var*
begin
//#UC START# *5507F84B03A8_5507EFFD01FEset_impl*
 l_FormTab := FormTabs[aValue];
 Assert(l_FormTab <> nil);
 SelectedTab := l_FormTab;
//#UC END# *5507F84B03A8_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetSelectedForm

function TChromeLikeTabSetControl.pm_GetSelectedSlotIndex: Integer;
//#UC START# *5507F8780321_5507EFFD01FEget_var*
//#UC END# *5507F8780321_5507EFFD01FEget_var*
begin
//#UC START# *5507F8780321_5507EFFD01FEget_impl*
 Assert(SelectedTab <> nil);
 Result := SelectedTab.SlotIndex;
//#UC END# *5507F8780321_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetSelectedSlotIndex

procedure TChromeLikeTabSetControl.pm_SetSelectedSlotIndex(aValue: Integer);
//#UC START# *5507F8780321_5507EFFD01FEset_var*
//#UC END# *5507F8780321_5507EFFD01FEset_var*
begin
//#UC START# *5507F8780321_5507EFFD01FEset_impl*
 if ((SelectedTab = nil) or (SelectedTab.SlotIndex <> aValue)) and
    (InRange(aValue, 0, Pred(f_SlotCount))) then
  SelectedTab := GetTabInSlot(aValue);
//#UC END# *5507F8780321_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetSelectedSlotIndex

function TChromeLikeTabSetControl.pm_GetMovingEaseType: TChromeLikeTabEaseType;
//#UC START# *550FE5BC02EE_5507EFFD01FEget_var*
//#UC END# *550FE5BC02EE_5507EFFD01FEget_var*
begin
//#UC START# *550FE5BC02EE_5507EFFD01FEget_impl*
 Result := f_MovingEaseType;
//#UC END# *550FE5BC02EE_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetMovingEaseType

procedure TChromeLikeTabSetControl.pm_SetMovingEaseType(aValue: TChromeLikeTabEaseType);
//#UC START# *550FE5BC02EE_5507EFFD01FEset_var*
//#UC END# *550FE5BC02EE_5507EFFD01FEset_var*
begin
//#UC START# *550FE5BC02EE_5507EFFD01FEset_impl*
 if (aValue <> f_MovingEaseType) then
  f_MovingEaseType := aValue;
//#UC END# *550FE5BC02EE_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetMovingEaseType

procedure TChromeLikeTabSetControl.pm_SetCloseButtonImages(aValue: TCustomImageList);
//#UC START# *551534B70094_5507EFFD01FEset_var*
//#UC END# *551534B70094_5507EFFD01FEset_var*
begin
//#UC START# *551534B70094_5507EFFD01FEset_impl*
 if (aValue <> f_CloseButtonImages) then
  f_CloseButtonImages := aValue;
//#UC END# *551534B70094_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetCloseButtonImages

procedure TChromeLikeTabSetControl.pm_SetCloseButtonImageIndex(aValue: TImageIndex);
//#UC START# *551534D90158_5507EFFD01FEset_var*
//#UC END# *551534D90158_5507EFFD01FEset_var*
begin
//#UC START# *551534D90158_5507EFFD01FEset_impl*
 f_CloseButtonImageIndex := aValue;
//#UC END# *551534D90158_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetCloseButtonImageIndex

procedure TChromeLikeTabSetControl.pm_SetCloseButtonHotImageIndex(aValue: TImageIndex);
//#UC START# *551534E80381_5507EFFD01FEset_var*
//#UC END# *551534E80381_5507EFFD01FEset_var*
begin
//#UC START# *551534E80381_5507EFFD01FEset_impl*
 f_CloseButtonHotImageIndex := aValue;
//#UC END# *551534E80381_5507EFFD01FEset_impl*
end;//TChromeLikeTabSetControl.pm_SetCloseButtonHotImageIndex

function TChromeLikeTabSetControl.pm_GetContainer: Il3TabbedContainer;
//#UC START# *5593BAC40325_5507EFFD01FEget_var*
//#UC END# *5593BAC40325_5507EFFD01FEget_var*
begin
//#UC START# *5593BAC40325_5507EFFD01FEget_impl*
 Result := Il3TabbedContainer(f_Container);
//#UC END# *5593BAC40325_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetContainer

procedure TChromeLikeTabSetControl.InvalidateWidthPerSlot;
//#UC START# *5507F039021B_5507EFFD01FE_var*
//#UC END# *5507F039021B_5507EFFD01FE_var*
begin
//#UC START# *5507F039021B_5507EFFD01FE_impl*
 f_WidthPerSlotValid := False;
//#UC END# *5507F039021B_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.InvalidateWidthPerSlot

function TChromeLikeTabSetControl.GetWidthPerSlot: Single;
//#UC START# *5507F0460114_5507EFFD01FE_var*
var
 l_CalculatedSlotWidth: Single;
 l_WidthForSlots: Single;
//#UC END# *5507F0460114_5507EFFD01FE_var*
begin
//#UC START# *5507F0460114_5507EFFD01FE_impl*
 if Visible then
 begin
  if (not f_WidthPerSlotValid) then
  begin
   l_WidthForSlots := Width - f_NewTabButton.MeasureSize.cx;
   if (f_SlotCount > 0) then
    l_CalculatedSlotWidth := l_WidthForSlots / f_SlotCount
   else
    l_CalculatedSlotWidth := cDefaultSlotWidth;
   if (l_CalculatedSlotWidth > cDefaultSlotWidth) then
    f_WidthPerSlot := cDefaultSlotWidth
   else
   if (l_CalculatedSlotWidth < cMinSlotWidth) then
    f_WidthPerSlot := cMinSlotWidth
   else
    f_WidthPerSlot := l_CalculatedSlotWidth;
   f_WidthPerSlotValid := True;
  end;
  Result := f_WidthPerSlot;
 end
 else
  Result := cDefaultSlotWidth;
//#UC END# *5507F0460114_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetWidthPerSlot

function TChromeLikeTabSetControl.GetSlotRect(aSlotIndex: Integer): TRect;
//#UC START# *5507F05002F2_5507EFFD01FE_var*
var
 l_WidthPerSlot: Single;
 l_Left: Single;
 l_Top: Integer;
//#UC END# *5507F05002F2_5507EFFD01FE_var*
begin
//#UC START# *5507F05002F2_5507EFFD01FE_impl*
 l_Top := ClientRect.Bottom - f_TabHeight;
 l_WidthPerSlot := GetWidthPerSlot;
 l_Left := l_WidthPerSlot * aSlotIndex;
 Result := Rect(Trunc(l_Left), l_Top, Trunc(l_Left + l_WidthPerSlot), l_Top + f_TabHeight);
 if (aSlotIndex > 0) then
  Dec(Result.Left, 1);
//#UC END# *5507F05002F2_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetSlotRect

procedure TChromeLikeTabSetControl.ResizeTabs(aAnimated: Boolean = False);
//#UC START# *5507F05C02DC_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
 l_EaseType: TChromeLikeTabEaseType;
//#UC END# *5507F05C02DC_5507EFFD01FE_var*
begin
//#UC START# *5507F05C02DC_5507EFFD01FE_impl*
 for l_Index := 0 to Pred(f_SlotCount) do
 begin
  l_Tab := GetTabInSlot(l_Index);
  if (l_Tab <> nil) then
  begin
   if aAnimated then
    l_EaseType := f_MovingEaseType
   else
    l_EaseType := ttNone;

   l_Tab.PositionRect := GetSlotRect(l_Tab.SlotIndex);
  end;
 end;
 UpdateNewTabButtonPosition; 
//#UC END# *5507F05C02DC_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.ResizeTabs

procedure TChromeLikeTabSetControl.ShiftTabsLeft(aStartingWith: Integer);
//#UC START# *5507F0680074_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
//#UC END# *5507F0680074_5507EFFD01FE_var*
begin
//#UC START# *5507F0680074_5507EFFD01FE_impl*
 InvalidateWidthPerSlot;
 for l_Index := aStartingWith to Pred(f_SlotCount) do
 begin
  l_Tab := GetTabInSlot(l_Index);
  if (l_Tab <> nil) then
  begin
   l_Tab.SlotIndex := Pred(l_Index);
   l_Tab.SetPosition(GetSlotRect(l_Tab.SlotIndex),
                                 cMovingAnimationDuration,
                                 MovingEaseType);
  end;
 end;
//#UC END# *5507F0680074_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.ShiftTabsLeft

procedure TChromeLikeTabSetControl.DeleteSlot(aSlotIndex: Integer);
//#UC START# *5507F0720386_5507EFFD01FE_var*
var
 l_SlotCount: Integer;
 l_TabInSlot: TChromeLikeTab;
 l_Index: Integer;
 l_NewTabSlotIndex: Integer;
//#UC END# *5507F0720386_5507EFFD01FE_var*
begin
//#UC START# *5507F0720386_5507EFFD01FE_impl*
 if (GetTabInSlot(aSlotIndex) <> nil) then
 begin
  Assert(False, 'Таб в слоте должен быть уже удален');
 end;
 l_SlotCount := f_SlotCount;
 Dec(f_SlotCount);
 if (aSlotIndex < Pred(l_SlotCount)) then
 begin
  for l_Index := Succ(aSlotIndex) to Pred(l_SlotCount) do
  begin
   l_TabInSlot := GetTabInSlot(l_Index);
   if (l_TabInSlot <> nil) then
   begin
    l_NewTabSlotIndex := Pred(l_Index);
    l_TabInSlot.SlotIndex := l_NewTabSlotIndex;
    SetTabPosition(l_TabInSlot);
   end;
  end;
 end;
 ResizeTabs(True);
//#UC END# *5507F0720386_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DeleteSlot

function TChromeLikeTabSetControl.InsertSlot(aInsertAfter: Integer): Integer;
//#UC START# *5507F07D01E4_5507EFFD01FE_var*
var
 l_SlotCount: Integer;
 l_TabInSlot: TChromeLikeTab;
 l_Index: Integer;
 l_TabsToShift: TChromeLikeTabList;
//#UC END# *5507F07D01E4_5507EFFD01FE_var*
begin
//#UC START# *5507F07D01E4_5507EFFD01FE_impl*
 if (aInsertAfter = Pred(f_SlotCount)) then
  Result := AddSlot
 else
 begin
  l_SlotCount := f_SlotCount;
  AddSlot;
  l_TabsToShift := TChromeLikeTabList.Create;
  try
   for l_Index := Pred(l_SlotCount) downto Succ(aInsertAfter) do
   begin
    l_TabInSlot := GetTabInSlot(l_Index);
    Assert(l_TabInSlot <> nil);
    l_TabsToShift.Add(l_TabInSlot);
   end;//for l_Index := Pred(l_SlotCount...
   for l_Index := 0 to Pred(l_TabsToShift.Count) do
   begin
    l_TabInSlot := l_TabsToShift[l_Index];
    l_TabInSlot.SlotIndex := Succ(l_TabInSlot.SlotIndex);
    SetTabPosition(l_TabInSlot);
   end;//for l_Index := 0...
  finally
   FreeAndNil(l_TabsToShift);
  end;//try..finally
  Result := Succ(aInsertAfter);
 end;//if (aInsertAfter...
//#UC END# *5507F07D01E4_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.InsertSlot

function TChromeLikeTabSetControl.AddSlot: Integer;
//#UC START# *5507F08C031E_5507EFFD01FE_var*
//#UC END# *5507F08C031E_5507EFFD01FE_var*
begin
//#UC START# *5507F08C031E_5507EFFD01FE_impl*
 Inc(f_SlotCount);
 InvalidateWidthPerSlot;
 ResizeTabs(True);
 Result := Pred(f_SlotCount);
//#UC END# *5507F08C031E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.AddSlot

function TChromeLikeTabSetControl.GetSlotIndexAtPoint(const aPoint: TPoint): Integer;
//#UC START# *5507F0AA0325_5507EFFD01FE_var*
var
 l_WidthPerSlot: Single;
 l_Pos: Integer;
//#UC END# *5507F0AA0325_5507EFFD01FE_var*
begin
//#UC START# *5507F0AA0325_5507EFFD01FE_impl*
 l_WidthPerSlot := GetWidthPerSlot;
 l_Pos := aPoint.X - ClientRect.Left;
 Result := Trunc(l_Pos / l_WidthPerSlot);
 if (Result > Pred(f_Tabs.Count)) then
  Result := Pred(f_Tabs.Count)
 else
 if (Result < 0) then
  Result := 0;
//#UC END# *5507F0AA0325_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetSlotIndexAtPoint

function TChromeLikeTabSetControl.GetSelectedSlotIndex: Integer;
//#UC START# *5507F0CD0156_5507EFFD01FE_var*
//#UC END# *5507F0CD0156_5507EFFD01FE_var*
begin
//#UC START# *5507F0CD0156_5507EFFD01FE_impl*
 Assert(SelectedTab <> nil);
 Result := SelectedTab.SlotIndex;
//#UC END# *5507F0CD0156_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetSelectedSlotIndex

procedure TChromeLikeTabSetControl.FinishMoving;
//#UC START# *5507F0DE02A0_5507EFFD01FE_var*
var
 l_RectForPositioning: TRect;
//#UC END# *5507F0DE02A0_5507EFFD01FE_var*
begin
//#UC START# *5507F0DE02A0_5507EFFD01FE_impl*
 if (f_MovingTab <> nil) then
 begin
  f_WasMouseLDown := False;
  l_RectForPositioning := GetSlotRect(f_MovingTab.SlotIndex);
  f_MovingTab.SetPosition(l_RectForPositioning, cMovingAnimationDuration, MovingEaseType);
  f_MovingTab := nil;
  ResizeTabs;
  ShowNewTabButton;
  Invalidate;
 end;
//#UC END# *5507F0DE02A0_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.FinishMoving

procedure TChromeLikeTabSetControl.PlaceTab(aTab: TChromeLikeTab;
 aSlotIndex: Integer);
//#UC START# *5507F1090227_5507EFFD01FE_var*
var
 l_Rect: TRect;
 l_SlotIndex: Integer;
//#UC END# *5507F1090227_5507EFFD01FE_var*
begin
//#UC START# *5507F1090227_5507EFFD01FE_impl*
 if (aSlotIndex = -1) then
  l_SlotIndex := Pred(f_SlotCount)
 else
  l_SlotIndex := aSlotIndex;

 l_Rect := GetSlotRect(l_SlotIndex);
 with aTab do
 begin
  PositionRect := l_Rect;
  f_Tabs.Add(aTab);
  SlotIndex := l_SlotIndex;
 end;
 ResizeTabs;
 Invalidate;
//#UC END# *5507F1090227_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.PlaceTab

procedure TChromeLikeTabSetControl.SetTabPosition(aTab: TChromeLikeTab);
//#UC START# *5507F11502F1_5507EFFD01FE_var*
//#UC END# *5507F11502F1_5507EFFD01FE_var*
begin
//#UC START# *5507F11502F1_5507EFFD01FE_impl*
 Assert(aTab <> nil);
 aTab.SetPosition(GetSlotRect(aTab.SlotIndex),
                              cMovingAnimationDuration,
                              MovingEaseType);
//#UC END# *5507F11502F1_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SetTabPosition

procedure TChromeLikeTabSetControl.SetInitialTabPosition(aTab: TChromeLikeTab);
//#UC START# *5507F14102CE_5507EFFD01FE_var*
var
 l_SlotIndex: Integer;
 l_Rect: TRect;
//#UC END# *5507F14102CE_5507EFFD01FE_var*
begin
//#UC START# *5507F14102CE_5507EFFD01FE_impl*
 l_SlotIndex := aTab.SlotIndex;
 if (l_SlotIndex > 0) and
    (TabCount > 0) then
 begin
  l_Rect := GetSlotRect(Pred(l_SlotIndex));
  l_Rect.Left := l_Rect.Right + cMinSlotWidth;
 end
 else
 begin
  l_Rect := GetSlotRect(0);
  l_Rect.Left := l_Rect.Right + cMinSlotWidth;
 end;
 aTab.PositionRect := l_Rect;
//#UC END# *5507F14102CE_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SetInitialTabPosition

function TChromeLikeTabSetControl.GetTabAtPoint(const aPoint: TPoint): TChromeLikeTab;
//#UC START# *5507F09A0097_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_TabRect: TRect;
//#UC END# *5507F09A0097_5507EFFD01FE_var*
begin
//#UC START# *5507F09A0097_5507EFFD01FE_impl*
 Result := nil;
 for l_Index := 0 to Pred(f_Tabs.Count) do
 begin
  l_TabRect := f_Tabs[l_Index].PositionRect;
  if IsPtInRect(aPoint, l_TabRect) then
  begin
   Result := f_Tabs[l_Index];
   Break;
  end;
 end;
//#UC END# *5507F09A0097_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetTabAtPoint

function TChromeLikeTabSetControl.GetTabInSlot(aSlotIndex: Integer): TChromeLikeTab;
//#UC START# *5507F0BA0186_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
//#UC END# *5507F0BA0186_5507EFFD01FE_var*
begin
//#UC START# *5507F0BA0186_5507EFFD01FE_impl*
 Result := nil;
 for l_Index := 0 to Pred(TabCount) do
 begin
  l_Tab := Tabs[l_Index];
  if (l_Tab.SlotIndex = aSlotIndex) then
  begin
   Result := l_Tab;
   Break;
  end;
 end;
//#UC END# *5507F0BA0186_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetTabInSlot

function TChromeLikeTabSetControl.NeedMoveTab(aTab: TChromeLikeTab): Boolean;
//#UC START# *5507F0EE007D_5507EFFD01FE_var*
//#UC END# *5507F0EE007D_5507EFFD01FE_var*
begin
//#UC START# *5507F0EE007D_5507EFFD01FE_impl*
 Result := (TabCount > 1);
//#UC END# *5507F0EE007D_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.NeedMoveTab

function TChromeLikeTabSetControl.CanRemoveTab(aTab: TChromeLikeTab): Boolean;
//#UC START# *5507F0F90394_5507EFFD01FE_var*
//#UC END# *5507F0F90394_5507EFFD01FE_var*
begin
//#UC START# *5507F0F90394_5507EFFD01FE_impl*
 Result := (TabCount > 1);
 if Assigned(f_OnCanUndockTabForm) then
  f_OnCanUndockTabForm(Self, aTab.Form, Result);
//#UC END# *5507F0F90394_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CanRemoveTab

function TChromeLikeTabSetControl.DockFormIntoSlot(aForm: TForm;
 const aTabParams: Il3TabParams;
 aSlotIndex: Integer = -1;
 aNeedSelect: Boolean = True): Boolean;
//#UC START# *5507F32B02D6_5507EFFD01FE_var*
var
 l_FormTab: TChromeLikeTab;
 l_CanDockForm: Boolean;
//#UC END# *5507F32B02D6_5507EFFD01FE_var*
begin
//#UC START# *5507F32B02D6_5507EFFD01FE_impl*
 Assert(aForm <> nil);

 Result := False;

 if Assigned(f_OnCanDockForm) then
  f_OnCanDockForm(Self, aForm, aNeedSelect, l_CanDockForm)
 else
  l_CanDockForm := True;

 if l_CanDockForm then
 begin
  l_FormTab := TChromeLikeTab.Create(Self);
  l_FormTab.CloseButtonImages := CloseButtonImages;
  l_FormTab.CloseButtonImageIndex := f_CloseButtonImageIndex;
  l_FormTab.CloseButtonHotImageIndex := f_CloseButtonHotImageIndex;
  with l_FormTab do
  begin
   OnNeedCloseTab := DoOnNeedCloseTab;
   pm_SetForm(aForm);
   if (aTabParams <> nil) then
   begin
    Text := aTabParams.Text;
    HintText := aTabParams.HintText;
    f_Icon.ImageList := Images;
    f_Icon.ImageIndex := aTabParams.ImageIndex;
   end;
  end;

  Container.DockForm(aForm, False);

  AddTab(l_FormTab, aSlotIndex);


  if Assigned(f_OnAfterFormAdded) then
   f_OnAfterFormAdded(Self, aForm, aNeedSelect);

  if aNeedSelect then
   SelectedTab := l_FormTab;
 end;
//#UC END# *5507F32B02D6_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DockFormIntoSlot

procedure TChromeLikeTabSetControl.SelectNext;
 {* Сделать активной вкладку, предшествующую активной }
//#UC START# *5507F39000F4_5507EFFD01FE_var*
var
 l_SelectedTabSlotIndex: Integer;
//#UC END# *5507F39000F4_5507EFFD01FE_var*
begin
//#UC START# *5507F39000F4_5507EFFD01FE_impl*
 l_SelectedTabSlotIndex := SelectedSlotIndex;
 Inc(l_SelectedTabSlotIndex);

 if (l_SelectedTabSlotIndex > Pred(f_SlotCount)) then
  l_SelectedTabSlotIndex := 0;

 SelectedTab := GetTabInSlot(l_SelectedTabSlotIndex);
//#UC END# *5507F39000F4_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SelectNext

procedure TChromeLikeTabSetControl.SelectPrev;
 {* Сделать активной вкладку, следующую за активной }
//#UC START# *5507F39C0053_5507EFFD01FE_var*
var
 l_SelectedTabSlotIndex: Integer;
//#UC END# *5507F39C0053_5507EFFD01FE_var*
begin
//#UC START# *5507F39C0053_5507EFFD01FE_impl*
 l_SelectedTabSlotIndex := SelectedSlotIndex;
 Dec(l_SelectedTabSlotIndex);

 if (l_SelectedTabSlotIndex < 0) then
  l_SelectedTabSlotIndex := Pred(f_SlotCount);

 SelectedTab := GetTabInSlot(l_SelectedTabSlotIndex);
//#UC END# *5507F39C0053_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SelectPrev

function TChromeLikeTabSetControl.CanCloseAllButSelected: Boolean;
//#UC START# *5507F3AF0311_5507EFFD01FE_var*
//#UC END# *5507F3AF0311_5507EFFD01FE_var*
begin
//#UC START# *5507F3AF0311_5507EFFD01FE_impl*
 Result := (SelectedTab <> nil) and
           (TabCount > 1);
//#UC END# *5507F3AF0311_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CanCloseAllButSelected

procedure TChromeLikeTabSetControl.CloseAllExceptOne(aTab: TChromeLikeTab);
 {* Закрыть все, кроме определенной }
//#UC START# *5507F3C003B6_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_TabToClose: TChromeLikeTab;
 l_SlotCount: Integer;
//#UC END# *5507F3C003B6_5507EFFD01FE_var*
begin
//#UC START# *5507F3C003B6_5507EFFD01FE_impl*
 Assert(aTab <> nil);
 for l_Index := Pred(TabCount) downto 0 do
 begin
  l_TabToClose := Tabs[l_Index];
  if (l_TabToClose <> aTab) then
   CloseTab(l_TabToClose);
 end;
//#UC END# *5507F3C003B6_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CloseAllExceptOne

function TChromeLikeTabSetControl.CanCloseAllRightToSelected: Boolean;
//#UC START# *5507F3FC0116_5507EFFD01FE_var*
//#UC END# *5507F3FC0116_5507EFFD01FE_var*
begin
//#UC START# *5507F3FC0116_5507EFFD01FE_impl*
 Result := (SelectedTab <> nil) and
           (SelectedTab.SlotIndex < Pred(f_SlotCount));
//#UC END# *5507F3FC0116_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CanCloseAllRightToSelected

procedure TChromeLikeTabSetControl.CloseAllRightToTab(aTab: TChromeLikeTab);
 {* Закрыть все вкладки справа от активной }
//#UC START# *5507F4170123_5507EFFD01FE_var*
var
 l_SelectedTabSlot: Integer;
 l_TabToClose: TChromeLikeTab;
 l_Index: Integer;
//#UC END# *5507F4170123_5507EFFD01FE_var*
begin
//#UC START# *5507F4170123_5507EFFD01FE_impl*
 Assert(aTab <> nil);
 l_SelectedTabSlot := aTab.SlotIndex;
 if (l_SelectedTabSlot < Pred(f_SlotCount)) then
 begin
  for l_Index := Pred(TabCount) downto 0 do
  begin
   l_TabToClose := Tabs[l_Index];
   if (l_TabToClose.SlotIndex > l_SelectedTabSlot) then
    CloseTab(l_TabToClose);
  end;
 end;
//#UC END# *5507F4170123_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CloseAllRightToTab

procedure TChromeLikeTabSetControl.AddTab(aTab: TChromeLikeTab);
//#UC START# *5507F43A012E_5507EFFD01FE_var*
//#UC END# *5507F43A012E_5507EFFD01FE_var*
begin
//#UC START# *5507F43A012E_5507EFFD01FE_impl*
 AddTab(aTab, -1);
//#UC END# *5507F43A012E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.AddTab

procedure TChromeLikeTabSetControl.AddTab(aTab: TChromeLikeTab;
 const aPoint: TPoint);
//#UC START# *5507F45D00D2_5507EFFD01FE_var*
var
 l_SlotIndex: Integer;
//#UC END# *5507F45D00D2_5507EFFD01FE_var*
begin
//#UC START# *5507F45D00D2_5507EFFD01FE_impl*
 l_SlotIndex := GetSlotIndexAtPoint(aPoint);
 AddTab(aTab, l_SlotIndex);
//#UC END# *5507F45D00D2_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.AddTab

procedure TChromeLikeTabSetControl.AddTab(aTab: TChromeLikeTab;
 aSlotIndex: Integer);
//#UC START# *5507F47E0301_5507EFFD01FE_var*
var
 l_LastSlot: Integer;
 l_SlotIndex: Integer;
//#UC END# *5507F47E0301_5507EFFD01FE_var*
begin
//#UC START# *5507F47E0301_5507EFFD01FE_impl*
 TChromeLikeTabSetAnimationManager.Instance.FinishAllImmediately;

 InvalidateWidthPerSlot;

 l_LastSlot := Pred(f_SlotCount);

 if (aSlotIndex = -1) then
  l_SlotIndex := l_LastSlot
 else
  l_SlotIndex := aSlotIndex;

 aTab.SlotIndex := InsertSlot(l_SlotIndex);
 SetInitialTabPosition(aTab);
 f_Tabs.Add(aTab);
 ResizeTabs;
 SetTabPosition(aTab);
 Invalidate;
 ShowNewTabButton;
 UpdateNewTabButtonPosition;
//#UC END# *5507F47E0301_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.AddTab

procedure TChromeLikeTabSetControl.AddTabAfterSelected(aTab: TChromeLikeTab);
//#UC START# *5507F4AA00B0_5507EFFD01FE_var*
var
 l_SlotIndex: Integer;
//#UC END# *5507F4AA00B0_5507EFFD01FE_var*
begin
//#UC START# *5507F4AA00B0_5507EFFD01FE_impl*
 if (SelectedTab <> nil) then
  l_SlotIndex := SelectedTab.SlotIndex
 else
  l_SlotIndex := Pred(f_SlotCount);
 AddTab(aTab, l_SlotIndex);
//#UC END# *5507F4AA00B0_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.AddTabAfterSelected

procedure TChromeLikeTabSetControl.CloseTab(aTab: TChromeLikeTab;
 aForce: Boolean = False);
//#UC START# *5507F4C7007D_5507EFFD01FE_var*
var
 l_CanClose: Boolean;
//#UC END# *5507F4C7007D_5507EFFD01FE_var*
begin
//#UC START# *5507F4C7007D_5507EFFD01FE_impl*
 l_CanClose := aForce or CanCloseTab(aTab);
 if l_CanClose and
    Assigned(f_OnCloseTabForm) then
   f_OnCloseTabForm(Self, aTab, l_CanClose, GetSelectedTabAfterClosing(aTab));
 if l_CanClose then
 begin
  if Assigned(f_OnTabClosed) then
   f_OnTabClosed(Self, aTab);
  RemoveTab(aTab);
 end;
//#UC END# *5507F4C7007D_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CloseTab

function TChromeLikeTabSetControl.CanCloseTab(aTab: TChromeLikeTab): Boolean;
//#UC START# *5507F4F001EF_5507EFFD01FE_var*
//#UC END# *5507F4F001EF_5507EFFD01FE_var*
begin
//#UC START# *5507F4F001EF_5507EFFD01FE_impl*
 Result := True;
//#UC END# *5507F4F001EF_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CanCloseTab

procedure TChromeLikeTabSetControl.RemoveTab(aTab: TChromeLikeTab);
//#UC START# *5507F51200EA_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
 l_TabSlot: Integer;
 l_NewSelectedTab: TChromeLikeTab;
//#UC END# *5507F51200EA_5507EFFD01FE_var*
begin
//#UC START# *5507F51200EA_5507EFFD01FE_impl*
 if (aTab = f_HintTab) then
  f_HintTab := nil;

 f_WasMouseLDown := False;

 l_Tab := aTab;
 l_TabSlot := aTab.SlotIndex;

 if (f_SelectedTab = l_Tab) then
 begin
  l_NewSelectedTab := GetSelectedTabAfterClosing(l_Tab);
  if (l_NewSelectedTab <> nil) then
   SelectedTab := l_NewSelectedTab
  else
   f_SelectedTab := nil;
 end;
 if (f_MovingTab = l_Tab) then
  f_MovingTab := nil;

 Assert(f_Tabs.IndexOf(l_Tab) <> -1);
 f_Tabs.Remove(l_Tab);

 FreeAndNil(aTab);

 InvalidateWidthPerSlot;

 DeleteSlot(l_TabSlot);

 InvalidateWidthPerSlot;
 ResizeTabs;
 UpdateNewTabButtonPosition;
 ShowNewTabButton;
 Invalidate;
//#UC END# *5507F51200EA_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.RemoveTab

function TChromeLikeTabSetControl.DockForm(aForm: TForm;
 const aTabParams: Il3TabParams;
 aNeedSelect: Boolean = True): Boolean;
//#UC START# *5507F53801F2_5507EFFD01FE_var*
//#UC END# *5507F53801F2_5507EFFD01FE_var*
begin
//#UC START# *5507F53801F2_5507EFFD01FE_impl*
 Result := DockFormIntoSlot(aForm, aTabParams, -1, aNeedSelect);
//#UC END# *5507F53801F2_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DockForm

function TChromeLikeTabSetControl.DockFormAfterSelected(aForm: TForm;
 const aTabParams: Il3TabParams;
 aNeedSelect: Boolean = True): Boolean;
//#UC START# *5507F546000A_5507EFFD01FE_var*
var
 l_SlotIndex: Integer;
//#UC END# *5507F546000A_5507EFFD01FE_var*
begin
//#UC START# *5507F546000A_5507EFFD01FE_impl*
 if (SelectedTab <> nil) and
    (SelectedTab.SlotIndex < Pred(f_SlotCount)) then
  l_SlotIndex := SelectedTab.SlotIndex
 else
  l_SlotIndex := -1;
 Result := DockFormIntoSlot(aForm, aTabParams, l_SlotIndex, aNeedSelect);
//#UC END# *5507F546000A_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DockFormAfterSelected

function TChromeLikeTabSetControl.CanDockFormAtPoint(aForm: TForm;
 const aScreenPoint: TPoint): Boolean;
//#UC START# *5507F556002B_5507EFFD01FE_var*
var
 l_cPt: TPoint;
//#UC END# *5507F556002B_5507EFFD01FE_var*
begin
//#UC START# *5507F556002B_5507EFFD01FE_impl*
 l_cPt := ScreenToClient(aScreenPoint);
 Result := PtInRect(ClientRect, l_cPt);
 if Result then
  if Assigned(f_OnCanDockForm) then
   f_OnCanDockForm(Self, aForm, True, Result);
//#UC END# *5507F556002B_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.CanDockFormAtPoint

procedure TChromeLikeTabSetControl.UndockTabbedForm(aTab: TChromeLikeTab);
//#UC START# *5507F5620368_5507EFFD01FE_var*
var
 l_Form: TForm;
 l_Container: Il3TabbedContainer;
 l_ContainerLeftTopPt: TPoint;
 l_TabParams: Il3TabParams;
 l_FocusedControl: TWinControl;
//#UC END# *5507F5620368_5507EFFD01FE_var*
begin
//#UC START# *5507F5620368_5507EFFD01FE_impl*
 Assert(aTab <> nil);
 Assert(aTab.Form <> nil);

 aTab.Visible := False;
 l_TabParams := MakeTabParams(aTab);
 try
  UpdateWindow(Handle);

  l_Form := aTab.Form;

  l_FocusedControl := FindControl(Windows.GetFocus);

  l_ContainerLeftTopPt := ClientToScreen(Point(aTab.PositionRect.Left, ClientHeight));

  Container.LockPosition;
  // - пока создается другой контейнер, изначальный контейнер не должен
  // поддаваться на WM_WINDOWPOSCHANGING.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=595456773
  try
   l_Container := Container.MakeClone;
   Assert(l_Container <> nil);

   if Assigned(f_OnTabClosed) then
    f_OnTabClosed(Self, aTab);

   RemoveTab(aTab);
   Invalidate;

   l_Container.DockForeignForm(l_Form, l_TabParams);
  finally
   Container.UnlockPosition;
  end;
  l_Container.MakeVisible(l_ContainerLeftTopPt);
  l_Form.Visible := True;
  if ((l_FocusedControl <> nil) and l_FocusedControl.CanFocus) then
   l_FocusedControl.SetFocus;
 finally
  l_TabParams := nil;
 end;
//#UC END# *5507F5620368_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.UndockTabbedForm

function TChromeLikeTabSetControl.IsDockablePoint(const aPoint: TPoint): Boolean;
//#UC START# *5507F67A0238_5507EFFD01FE_var*
var
 l_cPt: TPoint;
 l_InRect: Boolean;
 l_Bounds: TRect;
//#UC END# *5507F67A0238_5507EFFD01FE_var*
begin
//#UC START# *5507F67A0238_5507EFFD01FE_impl*
 Result := False;
 l_Bounds := ClientRect;
 l_cPt := ScreenToClient(aPoint);;
 l_InRect := PtInRect(l_Bounds, l_cPt);
 if l_InRect then
  Result := l_cPt.Y >= (((l_Bounds.Bottom - l_Bounds.Top) div 2) + l_Bounds.Top);
//#UC END# *5507F67A0238_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.IsDockablePoint

function TChromeLikeTabSetControl.HitTest(const aPoint: TPoint): TChromeLikeTabSetHitTestResult;
//#UC START# *5507F69A01CF_5507EFFD01FE_var*
var
 l_pPt: TPoint;
 l_cPt: TPoint;
//#UC END# *5507F69A01CF_5507EFFD01FE_var*
begin
//#UC START# *5507F69A01CF_5507EFFD01FE_impl*
 l_cPt := ScreenToClient(aPoint);
 l_pPt := Parent.ScreenToClient(aPoint);
 if not PtInRect(BoundsRect, l_pPt) then
 begin
  Result := htrNowhere;
  Exit;
 end
 else
 if (GetTabAtPoint(l_cPt) <> nil) then
  Result := htrInTab
 else
  Result := htrClient;
//#UC END# *5507F69A01CF_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.HitTest

procedure TChromeLikeTabSetControl.UpdateFormTab(aForm: TForm;
 const aParams: Il3TabParams);
//#UC START# *5507F6D001C1_5507EFFD01FE_var*
var
 l_FormTab: TChromeLikeTab;
//#UC END# *5507F6D001C1_5507EFFD01FE_var*
begin
//#UC START# *5507F6D001C1_5507EFFD01FE_impl*
 l_FormTab := FindFormTab(aForm);
 if (aParams <> nil) then
 begin
  if (tuo_UpdateHintText in aParams.UpdateOptions) then
   l_FormTab.HintText := aParams.HintText;
  if (tuo_UpdateTabText in aParams.UpdateOptions) then
   l_FormTab.Text := aParams.Text;
  if (tuo_UpdateTabImage in aParams.UpdateOptions) then
   l_FormTab.ImageIndex := aParams.ImageIndex;
  Invalidate;
 end;
//#UC END# *5507F6D001C1_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.UpdateFormTab

procedure TChromeLikeTabSetControl.SetFormTabImageIndex(aForm: TForm;
 aImageIndex: Integer);
//#UC START# *5507F6FE0373_5507EFFD01FE_var*
var
 l_FormTab: TChromeLikeTab;
//#UC END# *5507F6FE0373_5507EFFD01FE_var*
begin
//#UC START# *5507F6FE0373_5507EFFD01FE_impl*
 l_FormTab := FindFormTab(aForm);
 if (l_FormTab <> nil) then
  l_FormTab.ImageIndex := aImageIndex;
//#UC END# *5507F6FE0373_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SetFormTabImageIndex

function TChromeLikeTabSetControl.DockFormAtPoint(aForm: TForm;
 const aTabParams: Il3TabParams;
 const aPoint: TPoint;
 aNeedSelect: Boolean = True): Boolean;
//#UC START# *550806D7020E_5507EFFD01FE_var*
const
 cSideDelta: array[TChromeLikeTabSide] of Integer = (-1, 0);
var
 l_cPt: TPoint;
 l_TabAtPoint: TChromeLikeTab;
 l_TabSlotIndex: Integer;
//#UC END# *550806D7020E_5507EFFD01FE_var*
begin
//#UC START# *550806D7020E_5507EFFD01FE_impl*
 l_cPt := ScreenToClient(aPoint);
 l_TabAtPoint := GetTabAtPoint(l_cPt);
 if (l_TabAtPoint <> nil) then
 begin
  l_TabSlotIndex := l_TabAtPoint.SlotIndex;
  Inc(l_TabSlotIndex, cSideDelta[l_TabAtPoint.GetTabSide(aPoint)]);
  Result := DockFormIntoSlot(aForm, aTabParams, Max(0, l_TabSlotIndex), aNeedSelect);
 end
 else
  Result := DockForm(aForm, aTabParams, aNeedSelect);
//#UC END# *550806D7020E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DockFormAtPoint

procedure TChromeLikeTabSetControl.DoOnNeedCloseTab(aTabToClose: TChromeLikeBaseVisualObject);
//#UC START# *550FEE240297_5507EFFD01FE_var*
//#UC END# *550FEE240297_5507EFFD01FE_var*
begin
//#UC START# *550FEE240297_5507EFFD01FE_impl*
 CloseTab(TChromeLikeTab(aTabToClose));
//#UC END# *550FEE240297_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DoOnNeedCloseTab

function TChromeLikeTabSetControl.GetSelectedTabAfterClosing(aTab: TChromeLikeTab): TChromeLikeTab;
//#UC START# *550FFBF00385_5507EFFD01FE_var*
//#UC END# *550FFBF00385_5507EFFD01FE_var*
begin
//#UC START# *550FFBF00385_5507EFFD01FE_impl*
 if (aTab.SlotIndex > 0) then
  Result := GetTabInSlot(Pred(aTab.SlotIndex))
 else
 if (TabCount > 1) then
  Result := GetTabInSlot(Succ(aTab.SlotIndex))
 else
  Result := nil;
//#UC END# *550FFBF00385_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetSelectedTabAfterClosing

procedure TChromeLikeTabSetControl.DestroyTabs;
//#UC START# *550FFCD502DA_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
//#UC END# *550FFCD502DA_5507EFFD01FE_var*
begin
//#UC START# *550FFCD502DA_5507EFFD01FE_impl*
 for l_Index := Pred(TabCount) downto 0 do
 begin
  l_Tab := Tabs[l_Index];
  f_Tabs.Delete(l_Index);
  FreeAndNil(l_Tab);
 end;
//#UC END# *550FFCD502DA_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DestroyTabs

function TChromeLikeTabSetControl.FindFormTab(aForm: TForm): TChromeLikeTab;
//#UC START# *550FFCE3014B_5507EFFD01FE_var*
var
 l_Index: Integer;
 l_Tab: TChromeLikeTab;
//#UC END# *550FFCE3014B_5507EFFD01FE_var*
begin
//#UC START# *550FFCE3014B_5507EFFD01FE_impl*
 Result := nil;
 for l_Index := 0 to Pred(TabCount) do
 begin
  l_Tab := Tabs[l_Index];
  if (l_Tab.Form = aForm) then
  begin
   Result := l_Tab;
   Break;
  end;
 end;
//#UC END# *550FFCE3014B_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.FindFormTab

function TChromeLikeTabSetControl.MakeTabParams(aTab: TChromeLikeTab): Il3TabParams;
//#UC START# *551285860003_5507EFFD01FE_var*
var
 l_Text: Il3CString;
 l_HintText: Il3CString;
 l_ImageIndex: Integer;
//#UC END# *551285860003_5507EFFD01FE_var*
begin
//#UC START# *551285860003_5507EFFD01FE_impl*
 Assert(aTab <> nil);
 l_Text := l3CStr(aTab.Text);
 l_HintText := l3CStr(aTab.HintText);
 l_ImageIndex := aTab.ImageIndex;
 Result := TChromeLikeTabParams.Make(l_Text, l_HintText, l_ImageIndex, [tuo_UpdateHintText,
  tuo_UpdateTabText, tuo_UpdateTabImage]);
//#UC END# *551285860003_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.MakeTabParams

procedure TChromeLikeTabSetControl.SetParams(const aParams: TChromeLikeTabSetParams);
//#UC START# *551554BB0334_5507EFFD01FE_var*
//#UC END# *551554BB0334_5507EFFD01FE_var*
begin
//#UC START# *551554BB0334_5507EFFD01FE_impl*
 f_CloseButtonImages := aParams.rCloseButtonImages;
 f_CloseButtonImageIndex := aParams.rCloseButtonImageIndex;
 f_CloseButtonHotImageIndex := aParams.rCloseButtonHotImageIndex;
 Images := aParams.rTabImages;
//#UC END# *551554BB0334_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.SetParams

procedure TChromeLikeTabSetControl.PopulatePopupMenu;
//#UC START# *553F0DAB01F7_5507EFFD01FE_var*

 function lp_MakeMenuItem(anAction: TContainedAction): TMenuItem;
 begin
  Result := TMenuItem.Create(f_TabsPopupMenu.Items);
  Result.Action := anAction;
 end;//lp_MakeMenuItem

var
 l_Index: Integer;
//#UC END# *553F0DAB01F7_5507EFFD01FE_var*
begin
//#UC START# *553F0DAB01F7_5507EFFD01FE_impl*
 if (f_TabsPopupMenu.Items.Count = 0) then
  with f_TabsPopupMenu.Items do
  begin
   Add(lp_MakeMenuItem(f_actNewTab));
   Add(lp_MakeMenuItem(f_actMakeClone));
   Add(lp_MakeMenuItem(f_actCloseTab));
   Add(lp_MakeMenuItem(f_actCloseOtherTabs));
   Add(lp_MakeMenuItem(f_actCloseRightTabs));
   Add(lp_MakeMenuItem(f_actReopenClosedTab));
  end;
//#UC END# *553F0DAB01F7_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.PopulatePopupMenu

procedure TChromeLikeTabSetControl.actNewTabExecute(Sender: TObject);
//#UC START# *553F1FF80348_5507EFFD01FE_var*
//#UC END# *553F1FF80348_5507EFFD01FE_var*
begin
//#UC START# *553F1FF80348_5507EFFD01FE_impl*
 if Assigned(f_OnNewTabRequested) then
  f_OnNewTabRequested(Self, (Sender as TChromeLikeTabAction).Tab, False);
//#UC END# *553F1FF80348_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actNewTabExecute

procedure TChromeLikeTabSetControl.actMakeCloneExecute(Sender: TObject);
//#UC START# *553F20210329_5507EFFD01FE_var*
var
 l_Tab: Il3FormTab;
//#UC END# *553F20210329_5507EFFD01FE_var*
begin
//#UC START# *553F20210329_5507EFFD01FE_impl*
 Supports(f_actMakeClone.Tab, Il3FormTab, l_Tab);
 Assert(l_Tab <> nil);
 Tl3TabbedContainersDispatcher.Instance.CloneTab(l_Tab);
//#UC END# *553F20210329_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actMakeCloneExecute

procedure TChromeLikeTabSetControl.actCloseTabExecute(Sender: TObject);
//#UC START# *553F20470333_5507EFFD01FE_var*
//#UC END# *553F20470333_5507EFFD01FE_var*
begin
//#UC START# *553F20470333_5507EFFD01FE_impl*
 CloseTab(f_actCloseTab.Tab);
//#UC END# *553F20470333_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actCloseTabExecute

procedure TChromeLikeTabSetControl.actCloseOtherTabsExecute(Sender: TObject);
//#UC START# *553F206C017F_5507EFFD01FE_var*
//#UC END# *553F206C017F_5507EFFD01FE_var*
begin
//#UC START# *553F206C017F_5507EFFD01FE_impl*
 CloseAllExceptOne(f_actCloseOtherTabs.Tab);
//#UC END# *553F206C017F_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actCloseOtherTabsExecute

procedure TChromeLikeTabSetControl.actCloseRightTabsExecute(Sender: TObject);
//#UC START# *553F208C0095_5507EFFD01FE_var*
//#UC END# *553F208C0095_5507EFFD01FE_var*
begin
//#UC START# *553F208C0095_5507EFFD01FE_impl*
 CloseAllRightToTab(f_actCloseRightTabs.Tab);
//#UC END# *553F208C0095_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actCloseRightTabsExecute

procedure TChromeLikeTabSetControl.actReopenClosedTabExecute(Sender: TObject);
//#UC START# *553F20A603B7_5507EFFD01FE_var*
//#UC END# *553F20A603B7_5507EFFD01FE_var*
begin
//#UC START# *553F20A603B7_5507EFFD01FE_impl*
 Tl3TabbedContainersDispatcher.Instance.ReopenClosedTab(Container);
//#UC END# *553F20A603B7_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.actReopenClosedTabExecute

procedure TChromeLikeTabSetControl.MakeActions;
//#UC START# *553F21AF0289_5507EFFD01FE_var*

 function lp_MakeAction(const aCaption: Tl3StringIDEx; aOnExecute: TNotifyEvent;
  const aShortCut: String = ''): TChromeLikeTabAction;
 begin
  Result := TChromeLikeTabAction.Create(Self);
  with Result do
  begin
   Caption := l3Str(aCaption.AsCStr);
   OnExecute := aOnExecute;
   if (Length(aShortCut) > 0) then
    ShortCut := TextToShortCut(aShortCut);
  end;//with Result
 end;//lp_AddAction

//#UC END# *553F21AF0289_5507EFFD01FE_var*
begin
//#UC START# *553F21AF0289_5507EFFD01FE_impl*
 f_actNewTab := lp_MakeAction(str_NewTab, actNewTabExecute, 'Ctrl+T');
 f_actMakeClone := lp_MakeAction(str_MakeClone, actMakeCloneExecute);
 f_actCloseTab := lp_MakeAction(str_CloseTab, actCloseTabExecute, 'Ctrl+W');
 f_actCloseOtherTabs := lp_MakeAction(str_CloseOtherTabs, actCloseOtherTabsExecute);
 f_actCloseRightTabs := lp_MakeAction(str_CloseRightTabs, actCloseRightTabsExecute);
 f_actReopenClosedTab := lp_MakeAction(str_ReopenClosedTab, actReopenClosedTabExecute, 'Ctrl+Shift+T');
//#UC END# *553F21AF0289_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.MakeActions

procedure TChromeLikeTabSetControl.UpdateMenuActions(aMenuTab: TChromeLikeTab);
//#UC START# *553F42BE0387_5507EFFD01FE_var*
//#UC END# *553F42BE0387_5507EFFD01FE_var*
begin
//#UC START# *553F42BE0387_5507EFFD01FE_impl*
 f_actNewTab.Tab := aMenuTab;
 f_actMakeClone.Tab := aMenuTab;
 f_actCloseOtherTabs.Tab := aMenuTab;
 f_actCloseRightTabs.Tab := aMenuTab;
 f_actReopenClosedTab.Tab := aMenuTab;
 f_actCloseTab.Tab := aMenuTab;

 f_actCloseOtherTabs.Enabled := (TabCount > 1);
 f_actCloseRightTabs.Enabled := (aMenuTab <> nil) and (aMenuTab.SlotIndex < Pred(f_SlotCount));
 f_actMakeClone.Enabled := (aMenuTab <> nil) and aMenuTab.CanBeCloned;
 f_actReopenClosedTab.Enabled :=  Tl3TabbedContainersDispatcher.Instance.CanReopenClosedTab(Container); 
//#UC END# *553F42BE0387_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.UpdateMenuActions

procedure TChromeLikeTabSetControl.UpdateNewTabButtonPosition;
//#UC START# *5541DC5E03A4_5507EFFD01FE_var*
var
 l_TabRight: Integer;
//#UC END# *5541DC5E03A4_5507EFFD01FE_var*
begin
//#UC START# *5541DC5E03A4_5507EFFD01FE_impl*
 l_TabRight := GetTotalTabsRect.Right;
 f_NewTabButton.PositionRect := Rect(l_TabRight, ClientRect.Bottom - f_TabHeight,
  l_TabRight + f_NewTabButton.MeasureSize.cx, f_NewTabButton.MeasureSize.cy);
//#UC END# *5541DC5E03A4_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.UpdateNewTabButtonPosition

function TChromeLikeTabSetControl.GetTotalTabsRect: TRect;
//#UC START# *5541E0860318_5507EFFD01FE_var*
var
 l_FirstSlotRect: TRect;
 l_LastSlotRect: TRect;
//#UC END# *5541E0860318_5507EFFD01FE_var*
begin
//#UC START# *5541E0860318_5507EFFD01FE_impl*
 l_FirstSlotRect := GetSlotRect(0);
 l_LastSlotRect := GetSlotRect(Pred(f_SlotCount));
 Result.TopLeft := l_FirstSlotRect.TopLeft;
 Result.BottomRight := l_LastSlotRect.BottomRight;
//#UC END# *5541E0860318_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetTotalTabsRect

procedure TChromeLikeTabSetControl.StartMoving;
//#UC START# *556551BB00E1_5507EFFD01FE_var*
//#UC END# *556551BB00E1_5507EFFD01FE_var*
begin
//#UC START# *556551BB00E1_5507EFFD01FE_impl*
//#UC END# *556551BB00E1_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.StartMoving

procedure TChromeLikeTabSetControl.HideNewTabButton;
//#UC START# *55656DCA033E_5507EFFD01FE_var*
//#UC END# *55656DCA033E_5507EFFD01FE_var*
begin
//#UC START# *55656DCA033E_5507EFFD01FE_impl*
 f_NewTabButton.Visible := False;
//#UC END# *55656DCA033E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.HideNewTabButton

procedure TChromeLikeTabSetControl.ShowNewTabButton;
//#UC START# *55656DDA01D4_5507EFFD01FE_var*
//#UC END# *55656DDA01D4_5507EFFD01FE_var*
begin
//#UC START# *55656DDA01D4_5507EFFD01FE_impl*
 f_NewTabButton.Visible := True;
 UpdateNewTabButtonPosition; 
//#UC END# *55656DDA01D4_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.ShowNewTabButton

function TChromeLikeTabSetControl.IsLastTab(aTab: TChromeLikeTab): Boolean;
//#UC START# *55656DF602DE_5507EFFD01FE_var*
//#UC END# *55656DF602DE_5507EFFD01FE_var*
begin
//#UC START# *55656DF602DE_5507EFFD01FE_impl*
 Result := (aTab.SlotIndex = Pred(f_SlotCount));
//#UC END# *55656DF602DE_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.IsLastTab

procedure TChromeLikeTabSetControl.DoOnNewTabButtonClick(Sender: TObject);
//#UC START# *55669D6C03B4_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
//#UC END# *55669D6C03B4_5507EFFD01FE_var*
begin
//#UC START# *55669D6C03B4_5507EFFD01FE_impl*
 if Assigned(f_OnNewTabRequested) then
 begin
  if (Sender is TChromeLikeTabAction) then
   l_Tab := TChromeLikeTabAction(Sender).Tab
  else
   l_Tab := nil;
  f_OnNewTabRequested(Self, l_Tab, True);
 end;
//#UC END# *55669D6C03B4_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DoOnNewTabButtonClick

function TChromeLikeTabSetControl.GetFormTab(aForm: TForm): Il3FormTab;
//#UC START# *558BF6CA016C_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
//#UC END# *558BF6CA016C_5507EFFD01FE_var*
begin
//#UC START# *558BF6CA016C_5507EFFD01FE_impl*
 l_Tab := FindFormTab(aForm);
 if (l_Tab <> nil) then
  Result := l_Tab as Il3FormTab
 else
  Result := nil;
//#UC END# *558BF6CA016C_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetFormTab

constructor TChromeLikeTabSetControl.Create(aOwner: TComponent;
 const aContainer: Il3TabbedContainer);
//#UC START# *5593BEF1025E_5507EFFD01FE_var*
//#UC END# *5593BEF1025E_5507EFFD01FE_var*
begin
//#UC START# *5593BEF1025E_5507EFFD01FE_impl*
 inherited Create(aOwner);
 f_MovingEaseType := ttEaseOutQuad;
 f_TabHeight := cDefaultTabHeight;
 f_Tabs := TChromeLikeTabList.Create;
 f_SelectedTab := nil;
 ShowHint := True;
 MakeActions;
 f_TabsPopupMenu := TPopupMenu.Create(Self);
 f_NewTabButton := TChromeLikeNewTabButton.Create(Self);
 f_NewTabButton.OnClick := DoOnNewTabButtonClick;
 f_Container := Pointer(aContainer);
//#UC END# *5593BEF1025E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.Create

function TChromeLikeTabSetControl.StartProcessClick: Boolean;
//#UC START# *55BF16950082_5507EFFD01FE_var*
//#UC END# *55BF16950082_5507EFFD01FE_var*
begin
//#UC START# *55BF16950082_5507EFFD01FE_impl*
 Result := (not f_ProcessingClick);
 if Result then
  f_ProcessingClick := True;
//#UC END# *55BF16950082_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.StartProcessClick

procedure TChromeLikeTabSetControl.FinishProcessClick;
//#UC START# *55BF16A200EE_5507EFFD01FE_var*
//#UC END# *55BF16A200EE_5507EFFD01FE_var*
begin
//#UC START# *55BF16A200EE_5507EFFD01FE_impl*
 f_ProcessingClick := False;
//#UC END# *55BF16A200EE_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.FinishProcessClick

function TChromeLikeTabSetControl.DockFormAfterSpecified(aForm: TForm;
 const aTabParams: Il3TabParams;
 aInsertAfter: TForm;
 aNeedSelect: Boolean = True): Boolean;
//#UC START# *55CB0DE70292_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
 l_SlotIndex: Integer;
//#UC END# *55CB0DE70292_5507EFFD01FE_var*
begin
//#UC START# *55CB0DE70292_5507EFFD01FE_impl*
 l_Tab := FindFormTab(aInsertAfter);
 Assert(l_Tab <> nil);
 l_SlotIndex := l_Tab.SlotIndex;
 Result := DockFormIntoSlot(aForm, aTabParams, l_SlotIndex, aNeedSelect);
//#UC END# *55CB0DE70292_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DockFormAfterSpecified

function TChromeLikeTabSetControl.IsTransparentPoint(const aPoint: TPoint): Boolean;
//#UC START# *5507C5090199_5507EFFD01FE_var*
var
 l_TabAtPoint: TChromeLikeTab;
 l_ObjAtPoint: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5507C5090199_5507EFFD01FE_var*
begin
//#UC START# *5507C5090199_5507EFFD01FE_impl*
 l_TabAtPoint := GetTabAtPoint(aPoint);
 if (l_TabAtPoint = nil) then
  Result := (f_NewTabButton.HitTest(aPoint) = nil)
 else
 begin
  l_ObjAtPoint := l_TabAtPoint.HitTest(aPoint);
  Result := (TabCount = 1) and (not (cltcbClickable in l_ObjAtPoint.Behaviours));
 end;
//#UC END# *5507C5090199_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.IsTransparentPoint

function TChromeLikeTabSetControl.GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams;
//#UC START# *5507C54801DB_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
 l_NeedShowTabHint: Boolean;
 l_NeedShowNewTabButtonHint: Boolean;
 l_HintText: String;
 l_Rect: TRect;
//#UC END# *5507C54801DB_5507EFFD01FE_var*
begin
//#UC START# *5507C54801DB_5507EFFD01FE_impl*
 l_Tab := GetTabAtPoint(aPoint);
 l_NeedShowTabHint := (l_Tab <> nil);
 l_NeedShowNewTabButtonHint := (f_NewTabButton.HitTest(aPoint) <> nil);
 if l_NeedShowTabHint then
 begin
  l_HintText := l_Tab.HintText;
  l_Rect := l_Tab.PositionRect;
 end
 else
 if l_NeedShowNewTabButtonHint then
 begin
  l_HintText := l3Str(str_NewTab.AsCStr);
  l_Rect := f_NewTabButton.PositionRect;
 end
 else
 begin
  l_HintText := '';
  SetRectEmpty(l_Rect);
 end;
 Result := TChromeLikeTabHintParams_C(l_NeedShowTabHint or l_NeedShowNewTabButtonHint, l_HintText, l_Rect);
//#UC END# *5507C54801DB_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetHintParams

procedure TChromeLikeTabSetControl.Paint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5507C601033E_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
 l_Index: Integer;
//#UC END# *5507C601033E_5507EFFD01FE_var*
begin
//#UC START# *5507C601033E_5507EFFD01FE_impl*
 for l_Index := Pred(f_Tabs.Count) downto 0 do
 begin
  l_Tab := f_Tabs[l_Index];
  if (l_Tab <> f_SelectedTab) then
   l_Tab.Paint(aContext);
 end;
 if (f_SelectedTab <> nil) then
  f_SelectedTab.Paint(aContext);
 if (f_NewTabButton <> nil) then
  f_NewTabButton.Paint(aContext);
//#UC END# *5507C601033E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.Paint

procedure TChromeLikeTabSetControl.PaintBackground(aCanvas: TCanvas);
//#UC START# *5507C63E02AD_5507EFFD01FE_var*
var
 l_DefaultPainting: Boolean;
//#UC END# *5507C63E02AD_5507EFFD01FE_var*
begin
//#UC START# *5507C63E02AD_5507EFFD01FE_impl*
 l_DefaultPainting := True;
 if Assigned(f_OnPaintBackground) then
  f_OnPaintBackground(Self, ClientRect, aCanvas, l_DefaultPainting);
 if l_DefaultPainting then
 begin
  SelectObject(aCanvas.Handle, GetStockObject(BLACK_BRUSH));
  Rectangle(aCanvas.Handle,
            ClientRect.Left,
            ClientRect.Top,
            ClientRect.Right,
            ClientRect.Bottom);
 end;
//#UC END# *5507C63E02AD_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.PaintBackground

procedure TChromeLikeTabSetControl.DoOnResize;
//#UC START# *551133AE010A_5507EFFD01FE_var*
//#UC END# *551133AE010A_5507EFFD01FE_var*
begin
//#UC START# *551133AE010A_5507EFFD01FE_impl*
 InvalidateWidthPerSlot;
 ResizeTabs;
//#UC END# *551133AE010A_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DoOnResize

function TChromeLikeTabSetControl.GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
//#UC START# *551CF43B027E_5507EFFD01FE_var*
const
 cAreaMenuKindMap: array[TChromeLikeTabSetHitTestResult] of TChromeLikeCaptionMenuKind =
  (cl_cmkCustom,
   cl_cmkSystem,
   cl_cmkSystem);
var
 l_HitTestResult: TChromeLikeTabSetHitTestResult;
//#UC END# *551CF43B027E_5507EFFD01FE_var*
begin
//#UC START# *551CF43B027E_5507EFFD01FE_impl*
 l_HitTestResult := HitTest(aPoint);
 Result := cAreaMenuKindMap[l_HitTestResult];
//#UC END# *551CF43B027E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.GetMenuKindAtPoint

function TChromeLikeTabSetControl.pm_GetVCLWinControl: TWinControl;
//#UC START# *551CFF5B003E_5507EFFD01FEget_var*
//#UC END# *551CFF5B003E_5507EFFD01FEget_var*
begin
//#UC START# *551CFF5B003E_5507EFFD01FEget_impl*
 Result := Self;
//#UC END# *551CFF5B003E_5507EFFD01FEget_impl*
end;//TChromeLikeTabSetControl.pm_GetVCLWinControl

procedure TChromeLikeTabSetControl.ShowContextMenu(const aPoint: TPoint);
//#UC START# *553E5CB602FF_5507EFFD01FE_var*
var
 l_Tab: TChromeLikeTab;
//#UC END# *553E5CB602FF_5507EFFD01FE_var*
begin
//#UC START# *553E5CB602FF_5507EFFD01FE_impl*
 if (f_TabsPopupMenu <> nil) then
 begin
  PopulatePopupMenu;
  l_Tab := GetTabAtPoint(ScreenToClient(aPoint));
  UpdateMenuActions(l_Tab);
  f_TabsPopupMenu.Popup(aPoint.X, aPoint.Y);
 end;
//#UC END# *553E5CB602FF_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.ShowContextMenu

destructor TChromeLikeTabSetControl.Destroy;
//#UC START# *48077504027E_5507EFFD01FE_var*
//#UC END# *48077504027E_5507EFFD01FE_var*
begin
//#UC START# *48077504027E_5507EFFD01FE_impl*
 FreeAndNil(f_NewTabButton);
 DestroyTabs;
 FreeAndNil(f_Tabs);
 FreeAndNil(f_TabsPopupMenu);
 inherited;
//#UC END# *48077504027E_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.Destroy

{$If NOT Defined(NoVCL)}
procedure TChromeLikeTabSetControl.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_5507EFFD01FE_var*

 function lp_MakeMovedRect(const aRect: TRect; const aDelta: TSize): TRect;
 var
  l_Bounds: TRect;
  l_Left: Integer;
  l_Right: Integer;
 begin
  Result := aRect;
  l_Bounds := ClientRect;
  l_Left := Result.Left + aDelta.cx;
  l_Right := Result.Right + aDelta.cx;
  if (l_Left < l_Bounds.Left) then
  begin
   l_Left := l_Bounds.Left;
   l_Right := l_Left + RectWidth(aRect);
  end
  else
  if (l_Right > l_Bounds.Right) then
  begin
   l_Right := l_Bounds.Right;
   l_Left := l_Right - RectWidth(aRect);
  end;
  Result.Left := l_Left;
  Result.Right := l_Right;
 end;//lp_MakeMovedRect

type
 TChromeTabDirection = (drNone, drLeft, drRight);
const
 cDirectionArr: array[Boolean] of TChromeTabDirection = (drLeft, drRight);
 cNonClientMouseDragCommand   = 61458;

var
 l_MousePt: TPoint;
 l_MovingDelta: TSize;
 l_DisplayDelta: TSize;
 l_TabUnderPoint: TChromeLikeTab;
 l_SlotAtPoint: Integer;
 l_MovingTabSlot: Integer;
 l_HotPoint: TPoint;
 l_Index: Integer;
//#UC END# *48E22B250241_5507EFFD01FE_var*
begin
//#UC START# *48E22B250241_5507EFFD01FE_impl*
 inherited;
 l_MousePt := Point(X, Y);

 l_TabUnderPoint := GetTabAtPoint(l_MousePt);

 f_NewtabButton.MouseMove(l_MousePt);

 if (f_HintTab <> nil) and
    (f_HintTab <> l_TabUnderPoint) then
 begin
  Application.CancelHint;
  f_HintTab := l_TabUnderPoint;
 end;

 if (TabCount > 1) then
 begin
  if (ssLeft in Shift) and f_WasMouseLDown then
  begin
   if (f_MovingTab <> nil) and
      IsLastTab(f_MovingTab) then
    HideNewTabButton;
    
   l_MovingDelta := MakeTSize(l_MousePt.X - f_LastMovingPoint.X,
                             l_MousePt.Y - f_LastMovingPoint.Y);

   l_DisplayDelta := MakeTSize(0, 0);

   if (f_MovingTab = nil) then
   begin
    // Только начали движение
    if (SelectedTab <> nil) and
        not(SelectedTab.CanMove(l_MousePt) and
           NeedMoveTab(SelectedTab) and
           PtInRect(SelectedTab.PositionRect, l_MousePt)) then
     Exit;
    f_MovingTab := SelectedTab;
    if (f_MovingTab = nil) then
     Exit;
    StartMoving;     
    f_BeginMovingPoint := l_MousePt;
   end
   else
   begin
    // Продолжаем движение
    if (not IsPtInRect(l_MousePt, ClientRect)) then
    begin
     FinishMoving;
     UpdateNewTabButtonPosition;     
     Exit;
    end;
    // Перемещать будем только по горизонтали
    l_DisplayDelta.cx := l_MovingDelta.cx;
    // Смещаем прямоугольник на дельту
    f_MovingTab.PositionRect := lp_MakeMovedRect(f_MovingTab.PositionRect,
                                                 l_DisplayDelta);

    l_HotPoint := CenterPoint(f_MovingTab.PositionRect);
    // Находим слот под центром перемещаемой вкладки
    l_SlotAtPoint := GetSlotIndexAtPoint(l_HotPoint);

    l_TabUnderPoint := GetTabInSlot(l_SlotAtPoint);

    if (l_TabUnderPoint <> f_MovingTab) then
    begin
     // Нужно поменять слоты у перемещаемой вкладки и вкладки, на которую
     // "наехала" перемещаемая
     l_MovingTabSlot := f_MovingTab.SlotIndex;

     l_TabUnderPoint.SlotIndex := l_MovingTabSlot;
     f_MovingTab.SlotIndex     := l_SlotAtPoint;

     // Меняем местами
     f_Tabs.Exchange(l_MovingTabSlot, l_SlotAtPoint);

     // Обновляем позицию
     SetTabPosition(l_TabUnderPoint);
     UpdateNewTabButtonPosition;     
    end
    else
    if (l_TabUnderPoint = nil) and (l_SlotAtPoint <> f_MovingTab.SlotIndex) then
    begin
     f_MovingTab.SlotIndex := l_SlotAtPoint;
     f_MovingTab.SetPosition(GetSlotRect(l_SlotAtPoint),
                             cMovingAnimationDuration,
                             MovingEaseType);
     UpdateNewTabButtonPosition;                             
    end;

    // Если вкладку таскали и перетащили вниз на указанное расстояние -
    // значит ее хотят отдочить
    if {(l_MousePt.Y > Self.ClientHeight - 5) and}
      ((l_MousePt.Y - f_BeginMovingPoint.Y) > (Height div 2)) and
      CanRemoveTab(f_MovingTab) then
     UndockTabbedForm(f_MovingTab);
   end;//if (f_MovingTab = nil)
   f_LastMovingPoint := l_MousePt;
   Exit;
  end;//if (ssLeft in Shift) and f_WasMouseLDown
 end;//if (TabCount > 1)
 //  Никого не двигаем - просто сообщаем, что было движение мышью
 f_MovingTab := nil;
 for l_Index := 0 to Pred(TabCount) do
  Tabs[l_Index].MouseMove(l_MousePt);
//#UC END# *48E22B250241_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TChromeLikeTabSetControl.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_5507EFFD01FE_var*
var
 l_Pt: TPoint;
 l_ObjAtPoint: TChromeLikeBaseVisualObjectPrim;
 l_Index: Integer;
//#UC END# *4E7896270076_5507EFFD01FE_var*
begin
//#UC START# *4E7896270076_5507EFFD01FE_impl*
 FinishMoving;
 l_Pt := Point(X, Y);
 l_ObjAtPoint := GetTabAtPoint(l_Pt);
 if (l_ObjAtPoint = nil) then
  l_ObjAtPoint := f_NewTabButton.HitTest(l_Pt);
 if f_WasMouseLDown and
    (f_LClickedObject <> nil) and
    (f_LClickedObject = l_ObjAtPoint) then
 begin
  if StartProcessClick then
  try
   f_LClickedObject.Click(l_Pt);
  finally
   FinishProcessClick;
  end;
 end
 else
 if (Button = mbMiddle) and
    (l_ObjAtPoint <> nil) then
  l_ObjAtPoint.MiddleButtonClick(l_Pt);
//#UC END# *4E7896270076_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TChromeLikeTabSetControl.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_5507EFFD01FE_var*
var
 l_Pt: TPoint;
 l_Tab: TChromeLikeTab;
//#UC END# *4F88473B03CD_5507EFFD01FE_var*
begin
//#UC START# *4F88473B03CD_5507EFFD01FE_impl*
 inherited;
 if (Button = mbLeft) then
 begin
  l_Pt := Point(X, Y);
  f_WasMouseLDown := True;
  l_Tab := GetTabAtPoint(l_Pt);
  if (l_Tab <> nil) then
   f_LClickedObject := l_Tab
  else
   f_LClickedObject := f_NewTabButton.HitTest(l_Pt);
  if (l_Tab <> nil) and
     (l_Tab.NeedSelectByClickAtPoint(l_Pt)) then
   SelectedTab := l_Tab;
 end;
//#UC END# *4F88473B03CD_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

procedure TChromeLikeTabSetControl.DoOnMouseLeave;
//#UC START# *5507DE800105_5507EFFD01FE_var*
var
 l_Index: Integer;
//#UC END# *5507DE800105_5507EFFD01FE_var*
begin
//#UC START# *5507DE800105_5507EFFD01FE_impl*
 inherited;
 for l_Index := 0 to Pred(TabCount) do
  Tabs[l_Index].MouseLeave;
 f_NewTabButton.MouseLeave;
//#UC END# *5507DE800105_5507EFFD01FE_impl*
end;//TChromeLikeTabSetControl.DoOnMouseLeave

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeTabAction);
 {* Регистрация TChromeLikeTabAction }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeTabSetControl);
 {* Регистрация TChromeLikeTabSetControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
