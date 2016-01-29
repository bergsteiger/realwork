unit ChromeLikeTabSet;

interface
uses
  Controls,
  Classes,
  vg_scene,
  vg_objects,
  vg_controls,
  vgBounds,
  vg_ani,
  Windows,
  Types,
  l3Interfaces,
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Core,
  l3Types,
  l3Memory,
  l3Base,
  l3LongintList,
  Messages,
  vgRectList,
  Forms,
  Graphics,
  ImgList,
  ChromeLikeTabGlyph,
  ChromeLikeInterfaces;

type
 TChromeLikeTabSetPrim = class(Tl3ProtoObject)
 protected
  function pm_GetIsLocked: Boolean; virtual;
 public
  property IsLocked: Boolean
    read pm_GetIsLocked;
 end;

 TChromeLikeTabStyleElement = record
  rTabColor: ShortString;
  // - цвет фона вкладки
  rTabLeftEdgeColor: ShortString;
  // - цвет левой границы
  rTabTopEdgeColor: ShortString;
  // - цвет верхней границы
  rTabRightEdgeColor: ShortString;
  // - цвет правой границы
  rTabBottomEdgeColor: ShortString;
  // - цвет нижней границы
 end;

 TChromeLikeTabStyle = record
  rNormalStyle: TChromeLikeTabStyleElement;
  rSelectedStyle: TChromeLikeTabStyleElement;
 end;

 TvgChromeLikeTab = class;

 TvgChromeLikeTabItemState = (ctsNormal, ctsClosing, ctsMoving);
 TvgClosingTabMovingDirection = (mdNone, mdLeft, mdRight);

 TvgChromeLikeTabNotifyEvent = procedure(aSender: TvgChromeLikeTab) of object;

 TvgChromeLikeTabStartMovingEvent = procedure(aSender: TvgChromeLikeTab;
  const aPos: TvgPoint; var aCanBeMoved: Boolean) of object;

 TvgChromeLikeTabMoveEvent = procedure(aSender: TvgChromeLikeTab;
  aPos: TvgPoint) of object;

 TvgChromeLikeTabCheckMoveEvent = procedure(aSender: TvgChromeLikeTab;
  const aSuggestedRect: TvgRect; var aCanMove: Boolean) of object;

 TvgChromeLikeTabMovingEvent = procedure(aSender: TvgChromeLikeTab;
  aPos: TvgPoint; aMovingDirection: TvgClosingTabMovingDirection) of object;

 TvgChromeLikeTabDraggingOutEvent = procedure(aSender: TvgChromeLikeTab;
  aPos: TvgPoint; var aNeedClose: Boolean) of object;

 TvgChromeLikeTabSelectionChangedEvent = procedure(aSender: TvgChromeLikeTab;
  aSelected: Boolean) of object;

 TvgChromeLikeTabSelectedEvent = procedure(aSender: TvgChromeLikeTab) of object;

 TvgChromeLikeTabGetHintTextEvent = function(aTab: TvgChromeLikeTab): WideString of object;

 TvgChromeLikeTab = class(TvgTextControl)
 private
  f_RectAnimation: TvgRectAnimation;
  f_IsMoving: Boolean;
  f_IsManualMoving: Boolean;
  f_PositionBounds: TvgBounds;
  f_State: TvgChromeLikeTabItemState;
  f_OnCloseTab: TvgChromeLikeTabNotifyEvent;
  f_OnStartMove: TvgChromeLikeTabStartMovingEvent;
  f_OnMovingTab: TvgChromeLikeTabMovingEvent;
  f_OnMovingTabFinished: TvgChromeLikeTabMoveEvent;
  f_OnStartDraggingOut: TvgChromeLikeTabDraggingOutEvent;
  f_OnSelectionChanged: TvgChromeLikeTabSelectionChangedEvent;
  f_OnCheckCanMove: TvgChromeLikeTabCheckMoveEvent;
  f_WasMouseDown: Boolean;
  f_OnCloseButtonClick: TvgChromeLikeTabNotifyEvent;
  f_MouseDownPos: TvgPoint;
  f_RectForPositioning: TvgRect;
  f_UpdatingBounds: Boolean;
  f_InAnimation: Boolean;
  f_TabCloseButton: TvgBitmapStateButton;
  f_CloseButtonActiveBitmap: TvgBitmap;
  f_CloseButtonInactiveBitmap: TvgBitmap;
  f_TabTextHAlign: TvgTextAlign;
  f_NeedDestroy: Boolean;
  f_IconImage: TvgImage;
  f_Glyph: TChromeLikeTabGlyph;
  f_OnSelected: TvgChromeLikeTabSelectedEvent;
  f_OnDeselected: TvgChromeLikeTabSelectedEvent;
  f_OnGetHintText: TvgChromeLikeTabGetHintTextEvent;
  f_IsSelected: boolean;
  f_OnRequestAlignTabs: TNotifyEvent;
  f_OnTabClick: TNotifyEvent;
  f_TabSet: TChromeLikeTabSetPrim;
  procedure DoAnimationFinished(aSender: TObject);
  procedure DoPositionBoundsChanged(aSender: TObject);
  procedure DoCloseButtonClick(aSender: TObject);
  procedure DoGlyphChanged(aGlyph: TChromeLikeTabGlyph);
  procedure StartMoving(aX: Single; aY: Single);
  procedure ProcessMoving(aX: Single; aY: Single);
  procedure FinishMoving(aX: Single; aY: Single);
  function StartDraggingOut(aX: Single; aY: Single): Boolean;
  procedure CheckMovingFinished(aX: Single; aY: Single);
  procedure ApplyStyleElement(const aStyleElement: TChromeLikeTabStyleElement);
  procedure AssignCloseButtonBitmaps;
  procedure RequestAlignTabs;
  function GetSceneRect: TRect;
 protected
  function pm_GetPositionBounds: TvgBounds;
  procedure pm_SetPositionBounds(const aBounds: TvgBounds);
  function pm_GetLeftPath: TvgPath;
  function pm_GetRightPath: TvgPath;
  function pm_GetCenterRect: TvgSidesRectangle;
  function pm_GetTextObject: TvgText;
  function pm_GetTopLine: TvgLine;
  function pm_GetBottomLine: TvgLine;
  procedure pm_SetState(aState: TvgChromeLikeTabItemState);
  function pm_GetSelected: Boolean;
  procedure pm_SetSelected(aValue: Boolean);
  function pm_GetTextWidth: Single;
  function pm_GetCloseButtonFitsBounds: Boolean;
  function pm_GetCloseButton: TvgBitmapStateButton;
  procedure pm_SetCloseButtonInactiveBitmap(aBitmap: TvgBitmap);
  procedure pm_SetCloseButtonActiveBitmap(aBitmap: TvgBitmap);
  procedure pm_SetTabTextHAlign(aValue: TvgTextAlign);
  function pm_GetIconImage: TvgImage;
  function pm_GetGlyph: TChromeLikeTabGlyph;
  function pm_GetDrawTextWithEllipsis: Boolean;
  procedure pm_SetDrawTextWithEllipsis(aValue: Boolean);
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); override;
  procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  procedure MouseLeave; override;
  procedure MatrixChanged(Sender: TObject); override;
  procedure SetHeight(const Value: single); override;
  procedure SetWidth(const Value: single); override;
  procedure SetText(const Value: WideString); override;
  procedure PerformAnimation(const aCurrentRect: TvgRect; const aTargetRect: TvgRect;
   aDuration: Single); overload;
  function FindObjectByPoint(aX: Single; aY: Single; aForHint: Boolean = False): TvgVisualObject; override;
  procedure PerformAnimatedClosing;
  property LeftPath: TvgPath
   read pm_GetLeftPath;
  property RightPath: TvgPath
   read pm_GetRightPath;
  property CenterRect: TvgSidesRectangle
   read pm_GetCenterRect;
  property TextObject: TvgText
   read pm_GetTextObject;
  property TopLine: TvgLine
   read pm_GetTopLine;
  property BottomLine: TvgLine
   read pm_GetBottomLine;
  property IconImage: TvgImage
   read pm_GetIconImage;
 public
  constructor Create(aOwner: TComponent); override;
  procedure CleanUp; override;
  procedure CloseTab;
  function CheckNewWidth(aWidth: Single): Boolean;
  function GetVertDistance(const aPoint: TPoint): Integer;
  function NeedDragOut(const aPoint: TPoint): Boolean;
  procedure Select(aSelected: Boolean);
  property State: TvgChromeLikeTabItemState
   read f_State
   write pm_SetState;
  property OnCloseTab: TvgChromeLikeTabNotifyEvent
   read f_OnCloseTab
   write f_OnCloseTab;
  property OnMovingTab: TvgChromeLikeTabMovingEvent
   read f_OnMovingTab
   write f_OnMovingTab;
  property OnMovingTabFinished: TvgChromeLikeTabMoveEvent
   read f_OnMovingTabFinished
   write f_OnMovingTabFinished;
  property OnStartMove: TvgChromeLikeTabStartMovingEvent
   read f_OnStartMove
   write f_OnStartMove;
  property OnStartDraggingOut: TvgChromeLikeTabDraggingOutEvent
   read f_OnStartDraggingOut
   write f_OnStartDraggingOut;
  property OnSelectionChanged: TvgChromeLikeTabSelectionChangedEvent
   read f_OnSelectionChanged
   write f_OnSelectionChanged;
  property OnCheckCanMove: TvgChromeLikeTabCheckMoveEvent
   read f_OnCheckCanMove
   write f_OnCheckCanMove;
  property OnCloseButtonClick: TvgChromeLikeTabNotifyEvent
   read f_OnCloseButtonClick
   write f_OnCloseButtonClick;
  property OnSelected: TvgChromeLikeTabSelectedEvent
   read f_OnSelected
   write f_OnSelected;
  property OnDeselected: TvgChromeLikeTabSelectedEvent
   read f_OnDeselected
   write f_OnDeSelected;
  property OnGetHintText: TvgChromeLikeTabGetHintTextEvent
   read f_OnGetHintText
   write f_OnGetHintText;
  property RectForPositioning: TvgRect
   read f_RectForPositioning
   write f_RectForPositioning;
  property CloseButton: TvgBitmapStateButton
   read pm_GetCloseButton;
  property TextWidth: Single
   read pm_GetTextWidth;
  property CloseButtonFitsBounds: Boolean
   read pm_GetCloseButtonFitsBounds;
  property CloseButtonInactiveBitmap: TvgBitmap
   read f_CloseButtonInactiveBitmap
   write pm_SetCloseButtonInactiveBitmap;
  property CloseButtonActiveBitmap: TvgBitmap
   read f_CloseButtonActiveBitmap
   write pm_SetCloseButtonActiveBitmap;
  property TabTextHAlign: TvgTextAlign
   read f_TabTextHAlign
   write pm_SetTabTextHAlign;
  property NeedDestroy: Boolean
   read f_NeedDestroy
   write f_NeedDestroy;
 published
  property IsMoving: Boolean
   read f_IsMoving;
  property PositionBounds: TvgBounds
   read pm_GetPositionBounds
   write pm_SetPositionBounds;
  property Selected: Boolean
   read pm_GetSelected
   write pm_SetSelected;
  property Glyph: TChromeLikeTabGlyph
   read pm_GetGlyph;
  property DrawTextWithEllipsis: Boolean
   read pm_GetDrawTextWithEllipsis
   write pm_SetDrawTextWithEllipsis;
  property OnRequestAlignTabs: TNotifyEvent
   read f_OnRequestAlignTabs
   write f_OnRequestAlignTabs;
  property OnTabClick: TNotifyEvent
   read f_OnTabClick
   write f_OnTabClick;
  { trigger }
  property IsSelected: boolean read f_IsSelected;
  { props }
  property AutoTranslate default true;
  property Font;
  property TextAlign;
  property VertTextAlign;
  property Text;
  property Resource;
 end;

 PvgTabButtonItem = ^TvgTabButtonItem;
 TvgTabButtonItem = {$IfDef XE4}record{$Else}object{$EndIf}
 public
  rButton : TvgChromeLikeTab;
  rCaption: Tl3PCharLen;
  rForm: TForm;
  rSlotIndex: Integer;
 public
  function EQ(const anOther: TvgTabButtonItem): Boolean;
 end;//TvgTabButtonItem

 _ItemType_ = TvgTabButtonItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvgTabButtonArray = class(_l3RecordWithEQList_)
 end;//TvgTabButtonArray

 TChromeLikeTabSetHitTestResult = (htrInTab, htrClient, htrNowhere);

 TChromeLikeTabSet = class;

 TChromeLikeTabDetachEvent = procedure(aSender: TObject;
  const aTabItem: TvgTabButtonItem; const aPoint: TPoint; aNewSelectedIndex: Integer) of object;

 TChromeLikeTabSelectionChangedEvent = procedure(aSender: TObject;
  const aTabItem: TvgTabButtonItem; aSelected: Boolean) of object;

 TChromeLikeTabSetNeedResizeEvent = procedure(aSender: TObject;
  aNewWidth: Integer; var aCanResize: Boolean) of object;

 TChromeLikeTabSetAfterFormAddedEvent = procedure(anAddedForm: TForm;
  aTabSet: TChromeLikeTabSet; aNeedSelect: Boolean) of object;

 TChromeLikeTabSetCloseFormEvent = procedure(aTabSet: TChromeLikeTabSet; aForm: TForm;
  var aNeedClose: Boolean; aNewSelectedIndex: Integer) of object;

 TChromeLikeTabSetGetImageIndexEvent = procedure(aForm: TForm; var aImageIndex: Integer) of object;

 TChromeLikeTabSetTabSelectedEvent = procedure(aTabSet: TChromeLikeTabSet; aTabItem: TvgTabButtonItem) of object;

 TChromeLikeTabSetCanDragOutTabEvent = procedure(aTabSet: TChromeLikeTabSet; const aTabItem: TvgTabButtonItem;
  var aCanDragOutTab: Boolean) of object;

 TChromeLikeTabSetAfterTabClosed = procedure(aTabSet: TChromeLikeTabSet; const aNewTabItem: TvgTabButtonItem) of object;

 TChromeLikeTabSetOnGetTabFormCaptionFunc = function(aTabSet: TChromeLikeTabSet;
  aForm: TForm): Il3CString of object;

 TChromeLikeTabSetOnGetTabHintTextFunc = function(const aTabItem: TvgTabButtonItem): WideString of object;

 TChromeLikeTabSetNeedDestroyTabEvent = procedure(aTabSet: TChromeLikeTabSet; aTab: TvgChromeLikeTab) of object;

 TChromeLikeTabSet = class(TChromeLikeTabSetPrim)
 private
  f_Scene: TvgScene;
  f_Background: TvgBackground;
  f_Tabs: TvgTabButtonArray;
  f_TabParent: TvgVisualObject;
  f_RectList: TvgRectList;
  f_MovingControl: TvgChromeLikeTab;
  f_OnTabDetached: TChromeLikeTabDetachEvent;
  f_OnSelectionChanged: TChromeLikeTabSelectionChangedEvent;
  f_OnAfterFormAdded: TChromeLikeTabSetAfterFormAddedEvent;
  f_OnCloseForm: TChromeLikeTabSetCloseFormEvent;
  f_OnTabSelected: TChromeLikeTabSetTabSelectedEvent;
  f_OnTabDeselected: TChromeLikeTabSetTabSelectedEvent;
  f_OnCanDragOutTab: TChromeLikeTabSetCanDragOutTabEvent;
  f_OnAfterTabClosed: TChromeLikeTabSetAfterTabClosed;
  f_DockHostControl: TWinControl;
  {* - контрол, на который реально придочиваютс€ формы }
  f_FloatFormHeight: Integer;
  f_FloatFormWidth: Integer;
  f_TabResourceName: String;
  f_Form: TForm;
  f_Images: TCustomImageList;
  f_OnGetImageIndex: TChromeLikeTabSetGetImageIndexEvent;
  f_OnGetTabFormCaptionFunc: TChromeLikeTabSetOnGetTabFormCaptionFunc;
  f_OnGetTabHintTextFunc: TChromeLikeTabSetOnGetTabHintTextFunc;
  f_OnGetTabTextFunc: TChromeLikeTabSetOnGetTabHintTextFunc;
  f_OnNeedDestroyTab: TChromeLikeTabSetNeedDestroyTabEvent;
  f_LockCount: Integer;
  f_LastMovingPoint: TvgPoint;
  f_Maximizing: Boolean;
 private
  function pm_GetDockableFormClass: TFormClass;
  function GetItemForControl(aControl: TvgChromeLikeTab;
   out anItem: TvgTabButtonItem; out anItemIndex: Integer): Boolean;
  function GetTabUnderPoint(const aPoint: TvgPoint; out aTab: TvgChromeLikeTab;
   aExceptTab: TvgChromeLikeTab = nil): Boolean;
  function GetSlotIndexUnderPoint(const aPoint: TvgPoint;
   aExactly: Boolean = True): Integer;
  function CalcTabWidth: Single;
  function GetControlSlot(aControl: TvgChromeLikeTab): Integer;
  function GetControlInSlot(aSlotIndex: Integer): TvgChromeLikeTab;
  function GetItemIndexInSlot(aSlotIndex: Integer): Integer;
  function DoDragOutTab(aTab: TvgChromeLikeTab; aPoint: TvgPoint; aNeedCloseTab: Boolean): Boolean;
  procedure pm_SetForm(aForm: TForm);
  procedure AssignSlot(aControl: TvgChromeLikeTab; aSlotIndex: Integer);
  procedure DoTabClick(aSender: TObject);
  procedure DoTabCloseButtonClick(aTab: TvgChromeLikeTab);
  procedure DoCloseTab(anItem: TvgTabButtonItem; aNeedAnimation: Boolean = True);
  procedure DoCheckTabCanBeMoved(aSender: TvgChromeLikeTab;
   const aSuggestedRect: TvgRect; var aCanMove: Boolean);
  procedure DoTabSelected(aTab: TvgChromeLikeTab);
  procedure DoTabDeselected(aTab: TvgChromeLikeTab);
  function DoGetTabItemHintText(const aTabItem: TvgTabButtonItem): WideString;
  function DoGetTabItemText(const aTabItem: TvgTabButtonItem): WideString;
  function DoGetTabHintText(aTab: TvgChromeLikeTab): WideString;
  procedure DoOnRequestAlignTabs(aSender: TObject);
  procedure AlignTabs(aNeedAnimation: Boolean = True);
  procedure SignalCloseTabForm(aTab: TvgChromeLikeTab);
  procedure SignalCloseTab(aTab: TvgChromeLikeTab);
  procedure SignalStartMovingTab(aSender: TvgChromeLikeTab;
   const aPos: TvgPoint; var aCanBeMoved: Boolean);
  procedure SignalMovingTab(aSender: TvgChromeLikeTab;
   aPos: TvgPoint; aDirection: TvgClosingTabMovingDirection);
  procedure SignalMovingTabFinished(aSender: TvgChromeLikeTab; aPos: TvgPoint);
  procedure SignalStartTabDraggingOut(aSender: TvgChromeLikeTab; aPos: TvgPoint;
   var aNeedCloseTab: Boolean);
  procedure SignalSelectionChanged(aSender: TvgChromeLikeTab; aSelected: Boolean);
  procedure ShiftSlots(aFrom: Integer; aDirection: TvgClosingTabMovingDirection);
  procedure ShiftTabs(aFrom: Integer; aDirection: TvgClosingTabMovingDirection);
  procedure InsertSlot(aSlotIndex: Integer);
  procedure DeleteSlot(aSlotIndex: Integer);
  function AddSlot: Integer;
  procedure ResizeSlots;
  function DoAddTab(const aTabItem: TvgTabButtonItem; aSlotIndex: Integer = -1): Integer;
  procedure DoTabParentMouseDown(aSender: TObject; aButton: TMouseButton;
   aShift: TShiftState; aX: Single; aY: single);
  procedure DoTabParentMouseMove(aSender: TObject; aShift: TShiftState;
   aX: Single; aY: Single; aDx: Single; aDy: Single);
  procedure DoTabParentDblClick(aSender: TObject);
  function SceneToScreen(const aPoint: TvgPoint): TPoint; overload;
  function SceneToScreen(const aRect: TvgRect): TRect; overload;
  function ScreenToScene(const aPoint: TPoint): TvgPoint; overload;
  function ScreenToScene(const aRect: TRect): TvgRect; overload;
  procedure UndockTabForm(const aTabItem: TvgTabButtonItem;
   const aTabRect: TvgRect; aNeedProcessMouse: Boolean = True;
   aNeedMakeNewContainer: Boolean = False; const aParams: IChromeLikeTabParams = nil);
  procedure InitDockedForm(aForm: TForm; aNeedSelect: Boolean = True);
  procedure DoDockForm(aForm: TForm; const aPoint: TvgPoint); overload;
  procedure DoDockForm(aForm: TForm; aNeedSelect: Boolean = True; const aParams: IChromeLikeTabParams = nil); overload;
  procedure AddFormTab(aForm: TForm; aPos: TvgPoint); overload;
  procedure AddFormTab(aForm: TForm; const aParams: IChromeLikeTabParams = nil); overload;
  procedure UpdateSceneHitTest;
  procedure DoRemoveTab(aTab: TvgChromeLikeTab; const aPos: TvgPoint);
  procedure DoFormResize;
  procedure ClearSelection;
  procedure UpdateTabsZOrder;
  procedure CheckNeedSelect;
  procedure DeleteTabLater(aTab: TvgChromeLikeTab);
  procedure ClearSceneMessages;
  function CanDragOutTab(const aTab: TvgTabButtonItem): Boolean;
  function GetFormCaption(aForm: TForm): Il3CString;
  function GetNextSelectedTabIndexAfterClosing(const aClosingTab: TvgTabButtonItem): Integer;
  procedure Lock;
  procedure Unlock;
 public
  function GetFormTabIndex(aForm: TForm): Integer;
 protected
  function pm_GetScene: TvgScene;
  procedure pm_SetScene(const aValue: TvgScene);
  function pm_GetTabParent: TvgVisualObject;
  procedure pm_SetTabParent(const aValue: TvgVisualObject);
  function pm_GetContentWidth: Integer;
  function pm_GetTabCount: Integer;
  function pm_GetTab(aIndex: Integer): TvgTabButtonItem;
  function pm_GetSelected: TvgTabButtonItem;
  function pm_GetSelectedIndex: Integer;
  procedure pm_SetSelectedIndex(aValue: Integer);
  procedure pm_SetSelected(const aTabItem: TvgTabButtonItem);
  procedure pm_SetImages(aImageList: TCustomImageList);
  function pm_GetSelectedForm: TForm;
  procedure pm_SetSelectedForm(aForm: TForm);
  function pm_GetIsEmpty: Boolean;
  function pm_GetIsLocked: Boolean; override;
  function MakeTabItemControl(const aTabItem: TvgTabButtonItem): TvgChromeLikeTab;
  function CanDetachTab(aTab: TvgChromeLikeTab): Boolean;
 public
  procedure CloseSelected;
  procedure Assign(aTabSet: TChromeLikeTabSet);
  procedure DockForm(aForm: TForm; aNeedSelect: Boolean = True;
   const aTabParams: IChromeLikeTabParams = nil); overload;
  procedure DockForm(aForm: TForm; const aPoint: TPoint); overload;
  procedure SetFormImageIndex(aForm: TForm; aImageIndex: Integer);
  function IsDockablePoint(const aPoint: TPoint): Boolean;
  function HitTest(const aPoint: TPoint): TChromeLikeTabSetHitTestResult;
  procedure RearrangeTabs;
  procedure Resize;
  procedure AddForm(aForm: TForm);
  procedure SelectNext;
  function CanSelectNext: Boolean;
  procedure SelectPrev;
  function CanSelectPrev: Boolean;
  function CanSelectTabInSlot(aSlotIndex: Integer): Boolean;
  procedure SelectTabInSlot(aSlotIndex: Integer);
  constructor Create;
  procedure CleanUp; override;
  procedure RemoveForm(aForm: TForm; aNeedUndock: Boolean = True);
  procedure SetTabItemParams(const aTabItem: TvgTabButtonItem; const aParams: IChromeLikeTabParams);
  procedure UpdateFormTab(aForm: TForm; const aParams: IChromeLikeTabParams);
  function MakeFormTabParams(aForm: TForm): IChromeLikeTabParams;
  property Scene: TvgScene
   read pm_GetScene
   write pm_SetScene;
  property TabParent: TvgVisualObject
   read pm_GetTabParent
   write pm_SetTabParent;
  property OnTabDetached: TChromeLikeTabDetachEvent
   read f_OnTabDetached
   write f_OnTabDetached;
  property OnSelectionChanged: TChromeLikeTabSelectionChangedEvent
   read f_OnSelectionChanged
   write f_OnSelectionChanged;
  property OnAfterFormAdded: TChromeLikeTabSetAfterFormAddedEvent
   read f_OnAfterFormAdded
   write f_OnAfterFormAdded;
  property OnCloseForm: TChromeLikeTabSetCloseFormEvent
   read f_OnCloseForm
   write f_OnCloseForm;
  property OnGetImageIndex: TChromeLikeTabSetGetImageIndexEvent
   read f_OnGetImageIndex
   write f_OnGetImageIndex;
  property OnTabSelected: TChromeLikeTabSetTabSelectedEvent
   read f_OnTabSelected
   write f_OnTabSelected;
  property OnTabDeselected: TChromeLikeTabSetTabSelectedEvent
   read f_OnTabDeselected
   write f_OnTabDeselected;
  property OnCanDragOutTab: TChromeLikeTabSetCanDragOutTabEvent
   read f_OnCanDragOutTab
   write f_OnCanDragOutTab;
  property OnAfterTabClosed: TChromeLikeTabSetAfterTabClosed
   read f_OnAfterTabClosed
   write f_OnAfterTabClosed;
  property ContentWidth: Integer
   read pm_GetContentWidth;
  property DockHostControl: TWinControl
   read f_DockHostControl
   write f_DockHostControl;
  property FloatFormWidth: Integer
   read f_FloatFormWidth
   write f_FloatFormWidth;
  property FloatFormHeight: Integer
   read f_FloatFormHeight
   write f_FloatFormHeight;
  property TabResourceName: String
   read f_TabResourceName
   write f_TabResourceName;
  property TabCount: Integer
   read pm_GetTabCount;
  property Tabs[Index: Integer]: TvgTabButtonItem
   read pm_GetTab;
  property Selected: TvgTabButtonItem
   read pm_GetSelected
   write pm_SetSelected;
  property SelectedIndex: Integer
   read pm_GetSelectedIndex;
  property DockableFormClass: TFormClass
   read pm_GetDockableFormClass;
  property Form: TForm
   read f_Form
   write pm_SetForm;
  property Images: TCustomImageList
   read f_Images
   write pm_SetImages;
  property SelectedForm: TForm
   read pm_GetSelectedForm
   write pm_SetSelectedForm;
  property FormTabIndex[aForm: TForm]: Integer
   read GetFormTabIndex;
  property IsEmpty: Boolean
   read pm_GetIsEmpty;
  property OnGetTabFormCaptionFunc: TChromeLikeTabSetOnGetTabFormCaptionFunc
   read f_OnGetTabFormCaptionFunc
   write f_OnGetTabFormCaptionFunc;
  property OnGetTabHintTextFunc: TChromeLikeTabSetOnGetTabHintTextFunc
   read f_OnGetTabHintTextFunc
   write f_OnGetTabHintTextFunc;
  property OnGetTabTextFunc: TChromeLikeTabSetOnGetTabHintTextFunc
   read f_OnGetTabTextFunc
   write f_OnGetTabTextFunc;
  property OnNeedDestroyTab: TChromeLikeTabSetNeedDestroyTabEvent
   read f_OnNeedDestroyTab
   write f_OnNeedDestroyTab;
 end;

 RChromeLikeTabSetClass = class of TChromeLikeTabSet;

implementation
uses
 SysUtils,
 StrUtils,
 RTLConsts,
 Math,
 UxTheme,

 afwFacade,

 l3Except,
 l3DwmApi,
 l3String,

 vgTypes,
 vcmTabbedContainerFormDispatcher,
 vgBitmap,
 ChromeLikeTabSetRes,
 ChromeLikeTabParams
 ;

const
 cTabMovingAnimationDuration : Single  = 0.2;
 // - продолжительность анимации при перетаскивании таба
 cClosingAnimationDuration    : Single  = 0.2;
 // - продолжительность анимации при закрытии таба
 cOpeningAnimationDuration    : Single  = 0.2;
 // - продолжительность анимации пр открытии таба
 cTabItemTopOffset            : Single  = 0;
 // - отступ верхней границы вкладки от верхнего кра€ сцены
 cTabItemHeight               : Single  = 25;
 // - высота вкладки
 cDefaultTabWidth             : Single  = 180;
 // - умолчательна€ ширина таба
 cMinimalTabWidth             : Single  = 34;
 // - минимальна€ ширина таба (сумма ширин левого и правого треугольника)
 cCloseButtonWidth            : Integer = 16;
 // - ширина кнопки закрыти€ на вкладке
 cCloseButtonHeight           : Integer = 16;
 // - высота кнопки закрыти€ на вкладке
 cTabBorderWidth              : Integer = 20;
 // - пол€ на вкладке по бокам
 cContainterFormVerticalOffsetOnFloating : Integer = 5;
 // - отступ от центра вкладки по вертикали при отдочивании формы
 cMinMovingDelta              : Single  = 4;
 // - минимальное рассто€ние, на которое надо переместить мышь, чтобы
 // считалось, что окно нужно двигать

 cItemNotFound                = -1;

 cTransparentColor            = '#00000000';

 cNonClientMouseDragCommand   = 61458;

 cIsSelectedAnimationName     = 'IsSelected';
 cIsMovingTriggerName         = 'IsMoving';
 cPositionBoundsPropertyName  = 'PositionBounds';

 cDefaultTabStyle: TChromeLikeTabStyle =
  (rNormalStyle:
   (rTabColor:           '#99FAF8F7';
    rTabLeftEdgeColor:   '#99FFFFFF';
    rTabTopEdgeColor:    '#99FFFFFF';
    rTabRightEdgeColor:  '#99919191';
    rTabBottomEdgeColor: '#FFB2B2B2');
   rSelectedStyle:
   (rTabColor:           '#FFFAF8F9';
    rTabLeftEdgeColor:   '#FFFFFFFF';
    rTabTopEdgeColor:    '#FFFFFFFF';
    rTabRightEdgeColor:  '#FF919191';
    rTabBottomEdgeColor: '#FFFAF8F9')
  );

type
 THackApplication = class(TComponent)
 private
  FHandle: HWnd;
  FBiDiMode: TBiDiMode;
  FBiDiKeyboard: string;
  FNonBiDiKeyboard: string;
  FObjectInstance: Pointer;
  FMainForm: TForm;
  FMouseControl: TControl;
 end;

procedure ResetMouseControl;
begin
 THackApplication(Application).FMouseControl := nil;
end;


function IsEqual(aValue1: Single; aValue2: Single): Boolean;
begin
 Result := SameValue(aValue1, aValue2);
end;

function IsLess(aValue1: Single; aValue2: Single): Boolean;
begin
 Result := CompareValue(aValue1, aValue2) = LessThanValue;
end;

function IsGreater(aValue1: Single; aValue2: Single): Boolean;
begin
 Result := CompareValue(aValue1, aValue2) = GreaterThanValue;
end;

function IsLessOrEqual(aValue1: Single; aValue2: Single): Boolean;
var
 l_Result: TValueRelationship;
begin
 l_Result := CompareValue(aValue1, aValue2);
 Result := (l_Result = LessThanValue) or (l_Result = EqualsValue);
end;

function IsGreaterOrEqual(aValue1: Single; aValue2: Single): Boolean;
var
 l_Result: TValueRelationship;
begin
 l_Result := CompareValue(aValue1, aValue2);
 Result := (l_Result = GreaterThanValue) or (l_Result = EqualsValue);
end;

function TruncPt(const aPoint: TvgPoint): TPoint;
begin
 Result.X := Trunc(aPoint.X);
 Result.Y := Trunc(aPoint.Y);
end;

function TruncRect(const aRect: TvgRect): TRect;
begin
 Result.TopLeft := TruncPt(aRect.TopLeft);
 Result.BottomRight := TruncPt(aRect.BottomRight);
end;

function MakeVgRect(const aRect: TRect): TvgRect;
begin
 Result := vgRect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
end;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
begin
 Result := -1;
 Assert(false);
end;//CompareExistingItems

function TvgTabButtonItem.EQ(const anOther: TvgTabButtonItem): Boolean;
begin
 Result := (rButton = anOther.rButton) and
           (anOther.rSlotIndex = rSlotIndex) and
           l3Same(rCaption, anOther.rCaption) and
           (rForm = anOther.rForm);
end;

function TChromeLikeTabSetPrim.pm_GetIsLocked: Boolean;
begin
 Result := False;
end;

procedure TvgChromeLikeTab.DoAnimationFinished(aSender: TObject);
begin
 if not f_NeedDestroy then
 begin
  f_InAnimation := False;
  f_IsMoving := not f_IsMoving;
  case State of
   ctsClosing:
    CloseTab;
   ctsMoving:
    State := ctsNormal;
  end;//case State
 end;
end;//DoAnimationFinished

procedure TvgChromeLikeTab.DoPositionBoundsChanged(aSender: TObject);
var
 l_Width: Single;
begin
 if not f_UpdatingBounds then
 begin
  f_UpdatingBounds := True;
  Position.X := f_PositionBounds.Left;
  Position.Y := f_PositionBounds.Top;
  l_Width := f_PositionBounds.Width;
  Width := l_Width;
  Height := f_PositionBounds.Height;
 end;//if not f_UpdatingBounds
end;//DoPositionBoundsChanged

procedure TvgChromeLikeTab.DoCloseButtonClick(aSender: TObject);
begin
 if Assigned(f_OnCloseButtonClick) then
  f_OnCloseButtonClick(Self);
end;

procedure TvgChromeLikeTab.DoGlyphChanged(aGlyph: TChromeLikeTabGlyph);
begin
 Assert(aGlyph <> nil);
 IconImage.Bitmap := aGlyph.Bitmap;
 IconImage.Visible := not aGlyph.IsEmpty;
 Repaint;
end;

procedure TvgChromeLikeTab.StartMoving(aX: Single; aY: Single);
var
 l_CanBeMoved: Boolean;
 l_CurPt: TvgPoint;
 l_Pt: TPoint;
 l_mPt: TvgPoint;
begin
 if (not f_TabSet.IsLocked) then
 begin
  BringToFront;
  l_CurPt := LocalToAbsolute(vgPoint(aX, aY));
  if Assigned(f_OnStartMove) then
   f_OnStartMove(Self, l_CurPt, l_CanBeMoved);
  if l_CanBeMoved then
  begin
   f_MouseDownPos := l_CurPt;
   f_WasMouseDown := True;
   ProcessMoving(aX, aY);
  end;//if l_CanBeMoved
 end;
end;//StartMoving

procedure TvgChromeLikeTab.ProcessMoving(aX: Single; aY: Single);
var
 l_Rect: TvgRect;
 l_Dx: Single;
 l_iDx: Integer;
 l_Pt: TvgPoint;
 l_sPt: TPoint;
 l_Direction: TvgClosingTabMovingDirection;
 l_CanBeMoved: Boolean;
 l_PrevPt: TvgPoint;
 l_CurrentPt: TvgPoint;
 l_SceneRect: TRect;
begin
 if (not f_TabSet.IsLocked) then
 begin

 f_IsManualMoving := True;
 GetCursorPos(l_sPt);
 l_CurrentPt := Scene.ScreenToLocal(vgPoint(l_sPt.X, l_sPt.Y));
 l_PrevPt := l_CurrentPt;
 while (GetAsyncKeyState(VK_LBUTTON) < 0) and f_IsManualMoving do
 begin
  l_Dx := l_CurrentPt.X - l_PrevPt.X;
  l_iDx := Trunc(l_Dx);

  l_SceneRect := GetSceneRect;

  if (not PtInRect(l_SceneRect, l_sPt)) then
  begin
   if (not NeedDragOut(l_sPt)) or (not StartDraggingOut(l_sPt.X, l_sPt.Y)) then
   begin
    RequestAlignTabs;
    Break;
   end;
  end
  else
  begin
   l_CanBeMoved := False;
   l_Rect := ParentedRect;
   vgOffsetRect(l_Rect, l_Dx, 0);

   if Assigned(f_OnCheckCanMove) then
    f_OnCheckCanMove(Self, l_Rect, l_CanBeMoved);

   if (l_CanBeMoved) and (l_Rect.Left >= 0) then
   begin
    Position.X := Position.X + l_iDx;

    l_Direction := mdNone;
    if (l_iDx > 0) then
     l_Direction := mdRight
    else
    if (l_iDx < 0) then
     l_Direction := mdLeft;
    if (l_Direction <> mdNone) then
     if Assigned(f_OnMovingTab) then
      f_OnMovingTab(Self, l_CurrentPt, l_Direction);
    Repaint;
    afw.ProcessMessages;
   end;
  end;
  if f_IsManualMoving then
  begin
   l_PrevPt := l_CurrentPt;
   GetCursorPos(l_sPt);
   l_CurrentPt := Scene.ScreenToLocal(vgPoint(l_sPt.X, l_sPt.Y));
  end;
 end;
 FinishMoving(l_CurrentPt.X, l_CurrentPt.Y);
 f_IsManualMoving := False;
 end;
end;//ProcessMoving

procedure TvgChromeLikeTab.FinishMoving(aX: Single; aY: Single);
begin
 if (not f_TabSet.IsLocked) then
 begin
 if Assigned(f_OnMovingTabFinished) then
  f_OnMovingTabFinished(Self, vgPoint(aX, aY));
 f_WasMouseDown := False;
 f_IsManualMoving := False;
 end;
end;//FinishMoving

function TvgChromeLikeTab.StartDraggingOut(aX: Single; aY: Single): Boolean;
var
 l_NeedClose: Boolean;
begin
 if (not f_TabSet.IsLocked) then
 begin

 Result := False;
 f_IsManualMoving := False;
 if Assigned(f_OnStartDraggingOut) then
 begin
  l_NeedClose := False;
  f_OnStartDraggingOut(Self, vgPoint(aX, aY), l_NeedClose);
  Result := l_NeedClose;
 end;
 end;
end;//StartDraggingOut

procedure TvgChromeLikeTab.CheckMovingFinished(aX: Single; aY: Single);
var
 l_CurPt: TvgPoint;
 l_LeftButtonDown: Boolean;
begin
 if (State <> ctsClosing) and f_WasMouseDown and (not f_IsManualMoving) then
 begin
  l_LeftButtonDown := (GetAsyncKeyState(VK_LBUTTON) < 0);
  l_CurPt := LocalToAbsolute(vgPoint(aX, aY));
 end;
end;

procedure TvgChromeLikeTab.ApplyStyleElement(const aStyleElement: TChromeLikeTabStyleElement);
var
 l_LeftPath: TvgPath;
 l_RightPath: TvgPath;
 l_CenterRect: TvgRectangle;
 l_TopEdge: TvgLine;
 l_BottomEdge: TvgLine;
begin
 l_LeftPath := LeftPath;
 l_RightPath := RightPath;
 l_CenterRect := CenterRect;

 if (l_LeftPath <> nil) then
 begin
  l_LeftPath.Fill.Color := cTransparentColor;
  l_LeftPath.Stroke.Color := aStyleElement.rTabLeftEdgeColor;
 end;
 if (l_RightPath <> nil) then
 begin
  l_RightPath.Fill.Color := cTransparentColor;
  l_RightPath.Stroke.Color := aStyleElement.rTabRightEdgeColor;
 end;
 if (l_CenterRect <> nil) then
 begin
  l_CenterRect.Fill.Color := aStyleElement.rTabColor;
  l_CenterRect.Stroke.Color := aStyleElement.rTabColor;
 end;

 l_TopEdge := TopLine;
 if (l_TopEdge <> nil) then
  l_TopEdge.Stroke.Color := aStyleElement.rTabTopEdgeColor;

 l_BottomEdge := BottomLine;
 if (l_BottomEdge <> nil) then
  l_BottomEdge.Stroke.Color := aStyleElement.rTabBottomEdgeColor;
end;

procedure TvgChromeLikeTab.AssignCloseButtonBitmaps;
begin
 with CloseButton do
 begin
  if Selected then
   Bitmap.Assign(CloseButtonInactiveBitmap)
  else
   Bitmap.Clear;
  BitmapHot.Assign(CloseButtonActiveBitmap);
  BitmapDown.Assign(CloseButtonActiveBitmap);
 end;
end;

procedure TvgChromeLikeTab.RequestAlignTabs;
begin
 if Assigned(f_OnRequestAlignTabs) then
  f_OnRequestAlignTabs(Self);
end;

function TvgChromeLikeTab.GetSceneRect: TRect;
var
 l_Control: TControl;
begin
 l_Control := Scene.GetSceneControl;
 Result := l_Control.BoundsRect;
 Result.TopLeft := l_Control.Parent.ClientToScreen(Result.TopLeft);
 Result.BottomRight := l_Control.Parent.ClientToScreen(Result.BottomRight);
end;

function TvgChromeLikeTab.pm_GetPositionBounds: TvgBounds;
begin
 if (f_PositionBounds = nil) then
  f_PositionBounds := TvgBounds.Create(vgRect(0, 0, 0, 0));
 Result := f_PositionBounds;
end;//pm_GetPositionBounds

procedure TvgChromeLikeTab.pm_SetPositionBounds(const aBounds: TvgBounds);
begin
 pm_GetPositionBounds.Assign(aBounds);
end;//pm_SetPositionBounds

function TvgChromeLikeTab.pm_GetLeftPath: TvgPath;
var
 l_Obj: TvgObject;                                                                                                                    
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabLeftPathResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgPath) then
  Result := TvgPath(l_Obj);
end;//pm_GetLeftPath

function TvgChromeLikeTab.pm_GetRightPath: TvgPath;
var
 l_Obj: TvgObject;
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabRightPathResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgPath) then
  Result := TvgPath(l_Obj);
end;//pm_GetRightPath

function TvgChromeLikeTab.pm_GetCenterRect: TvgSidesRectangle;
var
 l_Obj: TvgObject;
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabCenterRectResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgSidesRectangle) then
  Result := TvgSidesRectangle(l_Obj);
end;//pm_GetCenterRect

function TvgChromeLikeTab.pm_GetTextObject: TvgText;
var
 l_Obj: TvgObject;
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabTextObjectResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgText) then
  Result := TvgText(l_Obj);
end;//.pm_GetTextObject

function TvgChromeLikeTab.pm_GetTopLine: TvgLine;
var
 l_Obj: TvgObject;
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabTopLineResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgLine) then
  Result := TvgLine(l_Obj);
end;//pm_GetTopLine

function TvgChromeLikeTab.pm_GetBottomLine: TvgLine;
var
 l_Obj: TvgObject;
begin
 l_Obj := FindResource(cChromeLikeTabBottomLineResourceName);
 if (l_Obj <> nil) and (l_Obj is TvgLine) then
  Result := TvgLine(l_Obj);
end;//pm_GetBottomLine

procedure TvgChromeLikeTab.pm_SetState(aState: TvgChromeLikeTabItemState);
begin
 if (f_State <> aState) then
  f_State := aState;
end;//pm_SetState

function TvgChromeLikeTab.pm_GetSelected: Boolean;
begin
 Result := IsSelected;
end;//pm_GetSelected

procedure TvgChromeLikeTab.pm_SetSelected(aValue: Boolean);
var
 l_Style: TChromeLikeTabStyleElement;
 l_IsSelected: Boolean;
begin
 l_IsSelected := f_IsSelected;
 Select(aValue);

 if aValue then
  l_Style := cDefaultTabStyle.rSelectedStyle
 else
  l_Style := cDefaultTabStyle.rNormalStyle;

 ApplyStyleElement(l_Style);
 AssignCloseButtonBitmaps;

 if aValue then
  BringToFront
 else
  SendToBack;

 if (l_IsSelected <> aValue) then
 begin
  if aValue then
   if Assigned(f_OnSelected) then
    f_OnSelected(Self);
  if not aValue then
   if Assigned(f_OnDeselected) then
    f_OnDeselected(Self);
  f_OnSelectionChanged(Self, aValue);
 end;
end;//pm_SetSelected

function TvgChromeLikeTab.pm_GetTextWidth: Single;
begin
 Result := TvgCanvas(Canvas).TextWidth(Text);
end;//pm_GetTextWidth

function TvgChromeLikeTab.pm_GetCloseButtonFitsBounds: Boolean;
begin
 Result := (f_TabCloseButton.Width * 2) < Self.Width;
 if (CenterRect <> nil) then
  Result := (f_TabCloseButton.Width * 2) < CenterRect.Width
 else
  Result := True;
end;//pm_GetCloseButtonFitsBounds

function TvgChromeLikeTab.pm_GetCloseButton: TvgBitmapStateButton;
begin
 Result := FindResource(cChromeLikeTabCloseButtonStyleName) as TvgBitmapStateButton;
 Result.OnClick := DoCloseButtonClick;
 Assert(Result <> nil);
end;

procedure TvgChromeLikeTab.pm_SetCloseButtonInactiveBitmap(aBitmap: TvgBitmap);
begin
 if (aBitmap <> f_CloseButtonInactiveBitmap) then
  f_CloseButtonInactiveBitmap := aBitmap;
end;

procedure TvgChromeLikeTab.pm_SetCloseButtonActiveBitmap(aBitmap: TvgBitmap);
begin
 if (aBitmap <> f_CloseButtonActiveBitmap) then
  f_CloseButtonActiveBitmap := aBitmap;
end;

procedure TvgChromeLikeTab.pm_SetTabTextHAlign(aValue: TvgTextAlign);
begin
 if (aValue <> f_TabTextHAlign) then
 begin
  f_TabTextHAlign := aValue;
  TextObject.HorzTextAlign := f_TabTextHAlign;
 end;
end;

function TvgChromeLikeTab.pm_GetIconImage: TvgImage;
var
 l_Obj: TvgObject;
begin
 Result := nil;
 l_Obj := FindResource(cChromeLikeTabIconImageName);
 if (l_Obj <> nil) and (l_Obj is TvgImage) then
  Result := TvgImage(l_Obj);
end;

function TvgChromeLikeTab.pm_GetGlyph: TChromeLikeTabGlyph;
begin
 if (f_Glyph = nil) then
  f_Glyph := TChromeLikeTabGlyph.Create(16, 16, DoGlyphChanged);
 Result := f_Glyph;
end;

function TvgChromeLikeTab.pm_GetDrawTextWithEllipsis: Boolean;
begin
 Result := TextObject.DrawWithEllipsis;
end;

procedure TvgChromeLikeTab.pm_SetDrawTextWithEllipsis(aValue: Boolean);
begin
 TextObject.DrawWithEllipsis := aValue;
end;

procedure TvgChromeLikeTab.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
 inherited;
 if (Button = mbLeft) then
 begin
  if Assigned(f_OnTabClick) then
   f_OnTabClick(Self);
  BringToFront;
  StartMoving(X, Y);
 end;//if (Button = mbLeft)
end;//MouseDown

procedure TvgChromeLikeTab.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
var
 l_CurPt: TvgPoint;
begin
 inherited;
 if (State <> ctsClosing) then
 begin
  l_CurPt := LocalToAbsolute(vgPoint(X, Y));
  if f_WasMouseDown and (ssLeft in Shift) and (not f_IsManualMoving)then
   ProcessMoving(l_CurPt.X, l_CurPt.Y)
  else
  if f_WasMouseDown and (not (ssLeft in Shift)) then
   FinishMoving(l_CurPt.X, l_CurPt.Y);
 end;
end;

procedure TvgChromeLikeTab.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
 inherited;
 if (Button = mbLeft) and f_WasMouseDown then
  FinishMoving(X, Y);
end;

procedure TvgChromeLikeTab.MouseLeave;
var
 l_Pt: TPoint;
 l_sPt: TvgPoint;
 l_NeedClose: Boolean;
begin
 inherited;
 if (not f_IsManualMoving) then
 begin
  GetCursorPos(l_Pt);
  l_sPt := Scene.ScreenToLocal(vgPoint(l_Pt.X, l_Pt.Y));
  if (State <> ctsClosing) then
   if (GetAsyncKeyState(VK_LBUTTON) < 0) then
   begin
    GetCursorPos(l_Pt);
     if not (StartDraggingOut(l_Pt.X, l_Pt.Y) and f_WasMouseDown) then
     RequestAlignTabs;
   end
   else
    CheckMovingFinished(l_sPt.X, l_sPt.Y);
 end;
end;

procedure TvgChromeLikeTab.MatrixChanged(Sender: TObject);
begin
 f_UpdatingBounds := True;
 try
  inherited;
  PositionBounds.Rect := ParentedRect;
 finally
  f_UpdatingBounds := False;
 end;
end;

procedure TvgChromeLikeTab.SetHeight(const Value: single);
begin
 f_UpdatingBounds := True;
 try
  inherited;
  PositionBounds.Rect := ParentedRect;
 finally
  f_UpdatingBounds := False;
 end;
end;

procedure TvgChromeLikeTab.SetWidth(const Value: single);
const
 cCloseButtonAlignArr: array[Boolean] of TvgAlign = (vaFitRight, vaRight);
var
 l_TextObject: TvgText;
 l_IsCloseButtonVisible: Boolean;
begin
 f_UpdatingBounds := True;
 try
  inherited;
  PositionBounds.Rect := ParentedRect;
  if Visible then
  begin
   if (f_TabCloseButton <> nil) then
   begin
    l_IsCloseButtonVisible := CloseButtonFitsBounds;
    f_TabCloseButton.Visible := l_IsCloseButtonVisible or Selected;
    l_TextObject := TextObject;
    if (l_TextObject <> nil) then
     l_TextObject.Visible := l_IsCloseButtonVisible;
   end;
  end;
 finally
  f_UpdatingBounds := False;
 end;
end;//SetWidth

procedure TvgChromeLikeTab.SetText(const Value: WideString);
begin
 inherited;
// Hint := Value;
end;

procedure TvgChromeLikeTab.CloseTab;
begin
 if Assigned(f_OnCloseTab) then
  f_OnCloseTab(Self);
end;

function TvgChromeLikeTab.CheckNewWidth(aWidth: Single): Boolean;
var
 l_LeftTriangleWidth: Single;
 l_CenterRectWidth: Single;
 l_RightTriangleWidth: Single;
begin
 l_LeftTriangleWidth := LeftPath.Width;
 l_CenterRectWidth := CenterRect.Width;
 l_RightTriangleWidth := RightPath.Width;
 Result := (aWidth > (l_LeftTriangleWidth + l_RightTriangleWidth + 2));
 Result := True;
end;

function TvgChromeLikeTab.GetVertDistance(const aPoint: TPoint): Integer;
var
 l_Bounds: TRect;
 l_VertCenter: Integer;
begin
 l_Bounds := GetSceneRect;
 l_VertCenter := ((l_Bounds.Bottom - l_Bounds.Top) div 2) + l_Bounds.Top;
 Result := aPoint.Y - l_VertCenter;
end;

function TvgChromeLikeTab.NeedDragOut(const aPoint: TPoint): Boolean;
var
 l_Distance: Integer;
begin
 l_Distance := GetVertDistance(aPoint);
 Result :=  (Abs(l_Distance) > (Scene.GetSceneControl.Height div 2));
end;

procedure TvgChromeLikeTab.Select(aSelected: Boolean);
begin
 if (aSelected <> f_IsSelected) then
 begin
  f_IsSelected := aSelected;
  StartTriggerAnimation(Self, cIsSelectedAnimationName);
  ApplyTriggerEffect(Self, cIsSelectedAnimationName);
 end;
end;

constructor TvgChromeLikeTab.Create(aOwner: TComponent);
begin
 inherited;
 AutoTranslate := true;
 Height := cTabItemHeight;
 Width  := cDefaultTabWidth;
 HitTest := true;
 f_PositionBounds.OnChange := DoPositionBoundsChanged;
 f_RectAnimation := TvgRectAnimation.Create(Self);
 f_RectAnimation.Parent := Self;
 f_RectAnimation.Interpolation := vgInterpolationBounce;
end;

procedure TvgChromeLikeTab.CleanUp;
begin
 f_RectAnimation.Parent := nil;
 f_OnCloseButtonClick := nil;
 f_OnTabClick := nil;
 f_OnCloseTab := nil;
 f_OnStartMove := nil;
 f_OnMovingTab := nil;
 f_OnMovingTabFinished := nil;
 f_OnStartDraggingOut := nil;
 f_OnSelectionChanged := nil;
 f_OnCheckCanMove := nil;
 f_OnCloseButtonClick := nil;
 f_OnSelected := nil;
 f_OnDeselected := nil;
 f_OnRequestAlignTabs := nil;
 FreeAndNil(f_RectAnimation);
 FreeAndNil(f_TabCloseButton);
 FreeAndNil(f_PositionBounds);
 FreeAndNil(f_Glyph);
 inherited;
end;

function TvgChromeLikeTab.FindObjectByPoint(aX: Single; aY: Single; aForHint: Boolean = False): TvgVisualObject;
begin
 if aForHint AND PointInObject(aX, aY) then
  Result := Self
 else
  Result := inherited FindObjectByPoint(aX, aY, aForHint);
end;

procedure TvgChromeLikeTab.PerformAnimation(const aCurrentRect: TvgRect;
 const aTargetRect: TvgRect; aDuration: Single);
begin
  with f_RectAnimation do
  begin
   f_InAnimation := True;
   Stop;
   StartFromCurrent := True;
   StartValue.Rect := aCurrentRect;
   StopValue.Rect := aTargetRect;
   Trigger := 'IsMoving';
   PropertyName := 'PositionBounds';
   Duration := aDuration;
   Enabled := True;
   Start;
   OnFinish := DoAnimationFinished;
  end;
end;

procedure TvgChromeLikeTab.PerformAnimatedClosing;
var
 l_CurrentRect: TvgRect;
 l_ClosedRect: TvgRect;
begin
 l_CurrentRect := PositionBounds.Rect;
 l_ClosedRect := l_CurrentRect;
 l_ClosedRect.Right := l_ClosedRect.Left;
 State := ctsClosing;
 PerformAnimation(l_CurrentRect, l_ClosedRect, cClosingAnimationDuration);
end;

function TvgChromeLikeTab_C(aForm: TForm): TvgTabButtonItem;
begin
 Assert(aForm <> nil);
 System.FillChar(Result, SizeOf(Result), 0);
 Result.rForm := aForm;
 Result.rSlotIndex := cItemNotFound;
end;

type _Instance_R_ = TvgTabButtonArray;
{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

{ TChromeLikeTabSet }

procedure TChromeLikeTabSet.Assign(aTabSet: TChromeLikeTabSet);
var
 l_Index: Integer;
 l_Form: TForm;
 l_Selected: Integer;
 l_ImageIndex: Integer;
begin
 Assert(aTabSet <> nil);
 l_Selected := aTabSet.SelectedIndex;
 for l_Index := 0 to Pred(aTabSet.TabCount) do
 begin
  l_ImageIndex := aTabSet.Tabs[l_Index].rButton.Glyph.ImageIndex;
  l_Form := aTabSet.Tabs[l_Index].rForm;
  l_Form.Visible := False;
  DockForm(l_Form);
  Tabs[l_Index].rButton.Glyph.ImageIndex := l_ImageIndex;
 end;
 ResizeSlots;
 AlignTabs(False);
 Selected := f_Tabs.Items[l_Selected];
end;

procedure TChromeLikeTabSet.CloseSelected;
var
 l_NewSelectedTabIndex: Integer;
 l_NewSelectedTab: TvgTabButtonItem;
begin
 if (SelectedIndex <> cItemNotFound) then
  DoCloseTab(Selected);
end;

procedure TChromeLikeTabSet.DockForm(aForm: TForm; aNeedSelect: Boolean = True;
 const aTabParams: IChromeLikeTabParams = nil);
begin
 if (f_DockHostControl <> nil) and (aForm is DockableFormClass) then
  DoDockForm(aForm, aNeedSelect, aTabParams)
 else
  Assert(False);
end;

procedure TChromeLikeTabSet.DockForm(aForm: TForm; const aPoint: TPoint);
var
 l_Pt: TvgPoint;
begin
 if (f_DockHostControl <> nil) and (aForm is DockableFormClass) then
 begin
  l_Pt := vgPoint(aPoint.X, aPoint.Y);
  DoDockForm(aForm, l_Pt);
 end
 else
  Assert(False);
end;

procedure TChromeLikeTabSet.SetFormImageIndex(aForm: TForm; aImageIndex: Integer);
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(f_Tabs.Count) do
  if (f_Tabs[l_Index].rForm = aForm) then
   f_Tabs[l_Index].rButton.Glyph.ImageIndex := aImageIndex;
end;

function TChromeLikeTabSet.IsDockablePoint(const aPoint: TPoint): Boolean;
var
 l_InRect: Boolean;
 l_Bounds: TRect;
begin
 Result := False;
 GetWindowRect(Scene.Handle, l_Bounds);
 l_InRect := PtInRect(l_Bounds, aPoint);
 if l_InRect then
  Result := aPoint.Y >= (((l_Bounds.Bottom - l_Bounds.Top) div 2) + l_Bounds.Top);
end;

function TChromeLikeTabSet.HitTest(const aPoint: TPoint): TChromeLikeTabSetHitTestResult;
var
 l_Bounds: TRect;
 l_Pos: TvgPoint;
 l_Tab: TvgChromeLikeTab;
begin
 GetWindowRect(Scene.Handle, l_Bounds);
 l_Pos := ScreenToScene(aPoint);
 if not PtInRect(l_Bounds, aPoint) then
 begin
  Result := htrNowhere;
  Exit;
 end
 else
 if GetTabUnderPoint(l_Pos, l_Tab) then
  Result := htrInTab
 else
  Result := htrClient;
end;//HitTest

procedure TChromeLikeTabSet.RearrangeTabs;
begin
 AlignTabs;
end;

procedure TChromeLikeTabSet.Resize;
begin
 ResizeSlots;
 AlignTabs;
 Scene.Repaint;
end;

procedure TChromeLikeTabSet.AddForm(aForm: TForm);
begin
 AddFormTab(aForm);
 ResetMouseControl;
 aForm.ManualDock(f_DockHostControl, nil, alClient);
 ResetMouseControl;
 aForm.Align := alClient;
 aForm.Visible := True;
 SelectedForm := aForm;
 if Assigned(f_OnAfterFormAdded) then
  f_OnAfterFormAdded(aForm, Self, True);
end;

procedure TChromeLikeTabSet.SelectNext;
var
 l_CurSelectedSlot: Integer;
begin
 l_CurSelectedSlot := Selected.rSlotIndex;
 if (l_CurSelectedSlot < Pred(f_RectList.Count)) then
  Inc(l_CurSelectedSlot)
 else
  l_CurSelectedSlot := 0;
 Selected := f_Tabs[GetItemIndexInSlot(l_CurSelectedSlot)];
end;

procedure TChromeLikeTabSet.SelectPrev;
var
 l_CurSelectedSlot: Integer;
begin
 l_CurSelectedSlot := Selected.rSlotIndex;
 if (l_CurSelectedSlot > 0) then
  Dec(l_CurSelectedSlot)
 else
  l_CurSelectedSlot := Pred(f_RectList.Count);
 Selected := f_Tabs[GetItemIndexInSlot(l_CurSelectedSlot)];
end;

function TChromeLikeTabSet.CanSelectNext: Boolean;
begin
 Result := CanSelectPrev;
end;

function TChromeLikeTabSet.CanSelectPrev: Boolean;
begin
 Result := (f_RectList.Count > 1);
end;

function TChromeLikeTabSet.CanSelectTabInSlot(aSlotIndex: Integer): Boolean;
begin
 Result := (f_RectList.Count > 0) AND
  (aSlotIndex >= 0) AND
  (aSlotIndex <= Pred(f_RectList.Count));
end;

procedure TChromeLikeTabSet.SelectTabInSlot(aSlotIndex: Integer);
var
 l_ItemIndex: Integer;
begin
 l_ItemIndex := GetItemIndexInSlot(aSlotIndex);
 Selected := f_Tabs.Items[l_ItemIndex];
end;

constructor TChromeLikeTabSet.Create;
begin
 inherited Create;
 f_Tabs := TvgTabButtonArray.Create;
 f_RectList := TvgRectList.Create;
 f_RectList.Sorted := False;
 f_RectList.Duplicates := l3_dupAccept;
end;

procedure TChromeLikeTabSet.CleanUp;

 procedure lp_ClearTabs;
 var
  l_Item: TvgTabButtonItem;
  l_Index: Integer;
 begin
  for l_Index := Pred(f_Tabs.Count) downto 0 do
  begin
   l_Item := f_Tabs[l_Index];
   FreeAndNil(l_Item);
   f_Tabs.Delete(l_Index);
  end;
 end;//lp_ClearTabs

begin
 ReleaseCapture;
 lp_ClearTabs;
 FreeAndNil(f_RectList);
 FreeAndNil(f_Tabs);
 f_TabParent.OnMouseDown := nil;
 f_TabParent.OnDblClick := nil;
 inherited;
end;

procedure TChromeLikeTabSet.AddFormTab(aForm: TForm; aPos: TvgPoint);
var
 l_SlotIndex: Integer;
 l_TabIndex: Integer;
begin
 l_SlotIndex := GetSlotIndexUnderPoint(aPos, False);
 l_TabIndex := DoAddTab(TvgChromeLikeTab_C(aForm), l_SlotIndex);
// Selected := f_Tabs[l_TabIndex];
end;

procedure TChromeLikeTabSet.AddFormTab(aForm: TForm; const aParams: IChromeLikeTabParams = nil);
var
 l_SlotIndex: Integer;
 l_TabIndex: Integer;
 l_TabItem: TvgTabButtonItem;
begin
 l_SlotIndex := cItemNotFound;
 l_TabIndex := DoAddTab(TvgChromeLikeTab_C(aForm), l_SlotIndex);
 SetTabItemParams(f_Tabs[l_TabIndex], aParams);
end;

procedure TChromeLikeTabSet.UpdateSceneHitTest;
var
 l_NeedSceneHitTest: Boolean;

 function lp_DoSwitchHitTest(anItem: PvgTabButtonItem; anIndex: Integer): Boolean;
 begin
  anItem.rButton.HitTest := l_NeedSceneHitTest;
  Result := True;
 end;//lp_DoSwitchHitTest

begin
 l_NeedSceneHitTest := (TabCount > 1);
 f_Tabs.IterateAllF(l3L2IA(@lp_DoSwitchHitTest));
end;

procedure TChromeLikeTabSet.RemoveForm(aForm: TForm; aNeedUndock: Boolean = True);
var
 l_ItemIndex: Integer;

 function lp_DoFindItem(aTabItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 begin
  Result := aTabItem^.rForm <> aForm;
  if not Result then
   l_ItemIndex := aIndex;
 end;//lp_DoFindItem

var
 l_Item: TvgTabButtonItem;
 l_NewSelectedIndex: Integer;
begin
 l_ItemIndex := cItemNotFound;
 f_Tabs.IterateAllF(l3L2IA(@lp_DoFindItem));
 if (l_ItemIndex <> cItemNotFound) then
 begin
  l_Item := f_Tabs.Items[l_ItemIndex];
  UndockTabForm(l_Item, l_Item.rButton.ParentedRect, False);
  SignalCloseTab(l_Item.rButton);
  l_NewSelectedIndex := cItemNotFound;
 end;//if (l_ItemIndex <> cItemNotFound)
end;//RemoveForm

procedure TChromeLikeTabSet.SetTabItemParams(const aTabItem: TvgTabButtonItem;
 const aParams: IChromeLikeTabParams);
begin
 if (aTabItem.rButton <> nil) and (aParams <> nil) then
 begin
  if (tuo_UpdateHintText in aParams.UpdateOptions) then
   aTabItem.rButton.Hint := aParams.HintText;
  if (tuo_UpdateTabText in aParams.UpdateOptions) then
   aTabItem.rButton.Text := aParams.Text;
  if (tuo_UpdateTabImage in aParams.UpdateOptions) then
   aTabItem.rButton.Glyph.ImageIndex := aParams.ImageIndex;
  Scene.Repaint;
 end;
end;

procedure TChromeLikeTabSet.UpdateFormTab(aForm: TForm; const aParams: IChromeLikeTabParams);
var
 l_ItemIndex: Integer;
 l_Item: TvgTabButtonItem;
begin
 Assert(aParams <> nil);
 l_ItemIndex := GetFormTabIndex(aForm);
 if (l_ItemIndex <> -1) then
 begin
  l_Item := f_Tabs[l_ItemIndex];
  SetTabItemParams(l_Item, aParams);
 end
 else
  Assert(False);
end;

function TChromeLikeTabSet.MakeFormTabParams(aForm: TForm): IChromeLikeTabParams;
var
 l_Caption: Il3CString;
 l_Hint: Il3CString;
 l_ImageIndex: Integer;
 l_FormTabIndex: Integer;
 l_FormTabItem: TvgTabButtonItem;
begin
 l_FormTabIndex := GetFormTabIndex(aForm);
 if (l_FormTabIndex <> cItemNotFound) then
 begin
  l_FormTabItem := f_Tabs[l_FormTabIndex];
  l_Caption := l3CStr(l_FormTabItem.rButton.Text);
  l_Hint    := l3CStr(l_FormTabItem.rButton.Hint);
  l_ImageIndex := l_FormTabItem.rButton.Glyph.ImageIndex;
  Result := TChromeLikeTabParams.Make(l_Caption, l_Hint, l_ImageIndex, [tuo_UpdateHintText,
   tuo_UpdateTabText, tuo_UpdateTabImage]);
 end
 else
  Result := nil;
end;

function TChromeLikeTabSet.pm_GetDockableFormClass: TFormClass;
begin
 Result := TvcmTabbedContainerFormDispatcher.Instance.DockableFormClass;
end;

function TChromeLikeTabSet.GetItemForControl(aControl: TvgChromeLikeTab;
 out anItem: TvgTabButtonItem;
 out anItemIndex: Integer): Boolean;
var
 l_Found: Boolean;

 function lp_DoFindControl(anTabItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 begin
  if (anTabItem^.rButton = aControl) then
  begin
   anItem := anTabItem^;
   anItemIndex := aIndex;
   l_Found := True;
   lp_DoFindControl := False;
  end
  else
   lp_DoFindControl := True;
 end;//lp_DoUpdateSynchroFormFlags

begin
 l_Found := False;
 l3FillChar(anItem, SizeOf(anItem), 0);
 f_Tabs.IterateAllF(l3L2IA(@lp_DoFindControl));
 Result := l_Found;
end;//GetItemForControl

function TChromeLikeTabSet.GetTabUnderPoint(const aPoint: TvgPoint;
 out aTab: TvgChromeLikeTab; aExceptTab: TvgChromeLikeTab = nil): Boolean;
var
 l_Found: Boolean;
 l_Tab: TvgChromeLikeTab;

 function lp_DoGetTabUnderPoint(anTabItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 var
  l_Rect: TvgRect;
 begin
  Assert(anTabItem^.rButton <> nil);
  l_Rect := anTabItem^.rButton.PositionBounds.Rect;
  if InRange(aPoint.X, l_Rect.Left, l_Rect.Right) AND
   ((aExceptTab = nil) or ((aExceptTab <> nil)
    and (anTabItem^.rButton <> aExceptTab))) then
  begin
   l_Found := True;
   l_Tab := anTabItem^.rButton;
   Result := False;
  end
  else
   Result := True;
 end;//lp_DoGetTabUnderPoint

begin
 l_Tab := nil;
 aTab := nil;
 l_Found := False;
 f_Tabs.IterateAllF(l3L2IA(@lp_DoGetTabUnderPoint));
 Result := l_Found;

 if not Result then
 begin
  aTab := GetControlInSlot(GetSlotIndexUnderPoint(aPoint));
  Result := (l_Tab <> nil) and ((l_Tab <> aExceptTab) or (aExceptTab = nil));
 end;
 aTab := l_Tab;
end;//GetTabUnderPoint

function TChromeLikeTabSet.GetSlotIndexUnderPoint(const aPoint: TvgPoint;
 aExactly: Boolean = True): Integer;
var
 l_SlotIndex: Integer;

 function lp_DoFindSlot(anItem: PvgRect; aIndex: Integer): Boolean;
 begin
  if aExactly then
   Result := not vgPtInRect(aPoint, anItem^)
  else
  begin
   Result := not (IsGreaterOrEqual(aPoint.X, anItem^.Left) AND
    IsLessOrEqual(aPoint.X, anItem^.Right));
  end;
  if not Result then
   l_SlotIndex := aIndex;
 end;//lp_DoFindSlot

begin
 l_SlotIndex := cItemNotFound;
 f_RectList.IterateAllF(l3L2IA(@lp_DoFindSlot));
 Result := l_SlotIndex;
end;//GetSlotIndexUnderPoint

function TChromeLikeTabSet.CalcTabWidth: Single;
begin
 if (f_Tabs.Count = 0) then
  Result := cDefaultTabWidth
 else
 if (TabParent.Width < (cDefaultTabWidth * f_RectList.Count)) then
  Result := TabParent.Width / f_RectList.Count
 else
  Result := cDefaultTabWidth;
 Result := Max(Result, cMinimalTabWidth);
end;//CalcTabWidth

function TChromeLikeTabSet.GetControlSlot(aControl: TvgChromeLikeTab): Integer;
var
 l_Item: TvgTabButtonItem;
 l_ItemIndex: Integer;
begin
 Result := cItemNotFound;
 if GetItemForControl(aControl, l_Item, l_ItemIndex) then
  Result := l_Item.rSlotIndex;
end;//GetControlSlot

function TChromeLikeTabSet.GetControlInSlot(aSlotIndex: Integer): TvgChromeLikeTab;
var
 l_Control: TvgChromeLikeTab;

 function lp_DoProcessItem(anTabItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 begin
  if (anTabItem^.rSlotIndex = aSlotIndex) then
   l_Control := anTabItem^.rButton;
  Result := l_Control = nil;
 end;//lp_DoProcessItem

begin
 l_Control := nil;
 if ((aSlotIndex >= 0) and (aSlotIndex < f_RectList.Count)) then
  f_Tabs.IterateAllF(l3L2IA(@lp_DoProcessItem));
 Result := l_Control;
end;//GetControlInSlot

function TChromeLikeTabSet.GetItemIndexInSlot(aSlotIndex: Integer): Integer;
var
 l_ItemIndex: Integer;

 function lp_DoFindItem(anItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 begin
  Result := (anItem^.rSlotIndex <> aSlotIndex);
  if not Result then
   l_ItemIndex := aIndex;
 end;//lp_DoFindItem

begin
 l_ItemIndex := 0;
 f_Tabs.IterateAllF(l3L2IA(@lp_DoFindItem));
 Result := l_ItemIndex;
end;

function TChromeLikeTabSet.DoDragOutTab(aTab: TvgChromeLikeTab;
 aPoint: TvgPoint; aNeedCloseTab: Boolean): Boolean;
var
 l_Pt: TPoint;
 l_StartPt: TPoint;
 l_Bounds: TRect;
 l_Distance: Integer;
 l_VertCenter: Integer;
 l_Item: TvgTabButtonItem;
 l_ItemIndex: Integer;
begin
 Result := False;
 if GetItemForControl(aTab, l_Item, l_ItemIndex) then
  if (TabCount > 1) and CanDragOutTab(l_Item) then
  begin
   l_Pt := SceneToScreen(aPoint);
   GetWindowRect(Scene.Handle, l_Bounds);
   l_VertCenter := ((l_Bounds.Bottom - l_Bounds.Top) div 2) + l_Bounds.Top;
   while (GetAsyncKeyState(VK_LBUTTON) < 0) do
   begin
     if aTab.NeedDragOut(l_Pt) and
      (not ((Form.WindowState = wsMaximized) and (aTab.GetVertDistance(l_Pt) < 0))) then
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=564993510
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=565492194
     begin
      DoRemoveTab(aTab, aPoint);
      aNeedCloseTab := True;
      Break;
     end;
   end;
  end;
end;

procedure TChromeLikeTabSet.pm_SetForm(aForm: TForm);
begin
 if (f_Form <> aForm) then
 begin
  if (f_Form <> nil) and (GetCapture = f_Form.Handle) then
   ReleaseCapture;
  f_Form := aForm;
 end;
end;

procedure TChromeLikeTabSet.AssignSlot(aControl: TvgChromeLikeTab; aSlotIndex: Integer);
var
 l_Item: TvgTabButtonItem;
 l_ItemIndex: Integer;
begin
 if GetItemForControl(aControl, l_Item, l_ItemIndex) then
 begin
  l_Item.rSlotIndex := aSlotIndex;
  f_Tabs.Items[l_ItemIndex] := l_Item;
 end;
end;

procedure TChromeLikeTabSet.DoTabClick(aSender: TObject);
var
 l_Tab: TvgChromeLikeTab;
 l_Item: TvgTabButtonItem;
 l_Index: Integer;
begin
 if (aSender is TvgChromeLikeTab) then
 begin
  l_Tab := TvgChromeLikeTab(aSender);
  if GetItemForControl(l_Tab, l_Item, l_Index) then
   Selected := l_Item;
 end;
 Scene.Repaint;
end;//DoTabClick

procedure TChromeLikeTabSet.DoTabCloseButtonClick(aTab: TvgChromeLikeTab);
var
 l_Item: TvgTabButtonItem;
 l_Index: Integer;
begin
 Assert(aTab <> nil);
 if GetItemForControl(aTab, l_Item, l_Index) then
  DoCloseTab(l_Item);
end;//DoTabCloseButtonClick

procedure TChromeLikeTabSet.AlignTabs(aNeedAnimation: Boolean = True);

 function lp_DoAlignTab(aTabItem: PvgTabButtonItem; aIndex: Integer): Boolean;
 var
  l_OrgSlotIndex: Integer;
  l_SlotIndex: Integer;
  l_CurrentRect: TvgRect;
  l_NewRect: TvgRect;
 begin
  l_CurrentRect := aTabItem^.rButton.ParentedRect;

  l_OrgSlotIndex := aTabItem^.rSlotIndex;
  l_SlotIndex := aTabItem^.rSlotIndex;
  if (l_SlotIndex = cItemNotFound) then
   l_SlotIndex := AddSlot;
  aTabItem^.rSlotIndex := l_SlotIndex;
  aTabItem^.rButton.Width := vgRectWidth(f_RectList.Items[l_SlotIndex]);
  l_NewRect := f_RectList.Items[l_SlotIndex];
  if aNeedAnimation then
   aTabItem^.rButton.PerformAnimation(l_CurrentRect, l_NewRect, cTabMovingAnimationDuration)
  else
   aTabItem^.rButton.PositionBounds.Rect := l_NewRect;
  aTabItem^.rButton.SendToBack;
  Result := True;
 end;//lp_DoALignTab

begin
 f_Tabs.IterateAllF(l3L2IA(@lp_DoAlignTab));
 UpdateTabsZOrder;
 TabParent.Repaint;
end;//AlignTabs

procedure TChromeLikeTabSet.DoCloseTab(anItem: TvgTabButtonItem;
 aNeedAnimation: Boolean = True);
begin
 Assert(anItem.rButton <> nil);
 anItem.rButton.SendToBack;
 anItem.rButton.CloseTab;
end;//DoCloseTab

procedure TChromeLikeTabSet.DoCheckTabCanBeMoved(aSender: TvgChromeLikeTab;
   const aSuggestedRect: TvgRect; var aCanMove: Boolean);

 function lp_PtInRectOrOnTheBorders(const aRect: TRect; const aPoint: TPoint): Boolean;
 begin
  Result := ((aPoint.X >= aRect.Left) and (aPoint.X <= aRect.Right));
 end;//lp_PtInRectOrOnTheBorders;

var
 l_Rect: TRect;
 l_TopLeft: TPoint;
 l_BottomRight: TPoint;
begin
 aCanMove := False;
 l_Rect := Scene.ClientRect;
 l_TopLeft := TruncPt(aSuggestedRect.TopLeft);
 l_BottomRight := TruncPt(aSuggestedRect.BottomRight);
 aCanMove := lp_PtInRectOrOnTheBorders(l_Rect, l_TopLeft) AND
  lp_PtInRectOrOnTheBorders(l_Rect, l_BottomRight);
// aCanMove := True;
end;//DoCheckTabCanBeMoved

procedure TChromeLikeTabSet.DoTabSelected(aTab: TvgChromeLikeTab);
var
 l_Item: TvgTabButtonItem;
 l_ItemIndex: Integer;
begin
 if Assigned(f_OnTabSelected) then
  if GetItemForControl(aTab, l_Item, l_ItemIndex) then
   f_OnTabSelected(Self, l_Item);
end;

procedure TChromeLikeTabSet.DoTabDeselected(aTab: TvgChromeLikeTab);
var
 l_Item: TvgTabButtonItem;
 l_ItemIndex: Integer;
begin
 if Assigned(f_OnTabDeselected) then
  if GetItemForControl(aTab, l_Item, l_ItemIndex) then
   f_OnTabDeselected(Self, l_Item);
end;

function TChromeLikeTabSet.DoGetTabItemHintText(const aTabItem: TvgTabButtonItem): WideString;
begin
 if Assigned(f_OnGetTabHintTextFunc) then
  Result := f_OnGetTabHintTextFunc(aTabItem)
 else
  Result := aTabItem.rButton.Text;
end;

function TChromeLikeTabSet.DoGetTabItemText(const aTabItem: TvgTabButtonItem): WideString;
begin
 if Assigned(f_OnGetTabTextFunc) then
  Result := f_OnGetTabTextFunc(aTabItem);
end;

function TChromeLikeTabSet.DoGetTabHintText(aTab: TvgChromeLikeTab): WideString;
var
 l_TabIndex: Integer;
 l_Item: TvgTabButtonItem;
begin
 if GetItemForControl(aTab, l_Item, l_TabIndex) then
  Result := DoGetTabItemHintText(l_Item);
end;

procedure TChromeLikeTabSet.DoOnRequestAlignTabs(aSender: TObject);
begin
 AlignTabs(False);
end;

procedure TChromeLikeTabSet.SignalCloseTabForm(aTab: TvgChromeLikeTab);
var
 l_TabIndex: Integer;
 l_Form: TForm;
 l_Item,
 l_NewItem: TvgTabButtonItem;
 l_NeedClose: Boolean;
 l_NewSelectedIndex: Integer;
begin
 Assert(aTab <> nil);
 if GetItemForControl(aTab, l_Item, l_TabIndex) then
 begin
  l_Form := l_Item.rForm;
  Assert(l_Form <> nil);

  l_NeedClose := True;
  if (Selected.rButton = aTab) then
   l_NewSelectedIndex := GetNextSelectedTabIndexAfterClosing(l_Item)
  else
   l_NewSelectedIndex := SelectedIndex;
  // - »наче получаетс€ дезинформаци€ - закрыли не выбранную вкладку
  // http://mdp.garant.ru/pages/viewpage.action?pageId=564992075
  if (l_NewSelectedIndex < 0) then
   l_NewSelectedIndex := 0;

  if Assigned(f_OnCloseForm) and (l_Form <> nil) then
   f_OnCloseForm(Self, l_Form, l_NeedClose, l_NewSelectedIndex);

  if l_NeedClose then
  begin
   if l_NewSelectedIndex >= 0 then
    l_NewItem := Tabs[l_NewSelectedIndex];
   SignalCloseTab(aTab);
   if (TabCount = 0) then
   begin
    l_Item.rButton.SendToBack;
   end;
   if (l_NewSelectedIndex >= 0) then
    if Assigned(f_OnAfterTabClosed) then
     f_OnAfterTabClosed(Self, l_NewItem);
  end;
 end;
end;

procedure TChromeLikeTabSet.SignalCloseTab(aTab: TvgChromeLikeTab);
var
 l_TabIndex: Integer;
 l_TabSlotIndex: Integer;
 l_ClosingSelected: Boolean;
 l_NewSelectedSlotIndex: Integer;
begin
 aTab.Visible := False;
 Scene.Repaint;
 aTab.NeedDestroy := True;
 l_ClosingSelected := False;

 l_TabSlotIndex := GetControlSlot(aTab);
 l_TabIndex := GetItemIndexInSlot(l_TabSlotIndex);
 l_ClosingSelected := (l_TabIndex = SelectedIndex);
 try
  DeleteSlot(l_TabSlotIndex);
  f_Tabs.Delete(l_TabIndex);
  ResizeSlots;
  AlignTabs;
 finally
  DeleteTabLater(aTab);
 end;

 if l_ClosingSelected AND (TabCount > 0) then
 begin
  if (l_TabSlotIndex > 0) then
   l_NewSelectedSlotIndex := Pred(l_TabSlotIndex)
  else
   l_NewSelectedSlotIndex := 0;
  Selected := Tabs[GetItemIndexInSlot(l_NewSelectedSlotIndex)];
 end;//if (TabCount > 0)

 UpdateSceneHitTest;
 CheckNeedSelect;
end;//SignalCloseTab

procedure TChromeLikeTabSet.SignalStartMovingTab(aSender: TvgChromeLikeTab;
 const aPos: TvgPoint; var aCanBeMoved: Boolean);
begin
 DoTabClick(aSender);
 aCanBeMoved := False;
 f_MovingControl := aSender;
 aCanBeMoved := TabCount > 1;
end;//SignalStartMovingTab

procedure TChromeLikeTabSet.SignalMovingTab(aSender: TvgChromeLikeTab;
 aPos: TvgPoint; aDirection: TvgClosingTabMovingDirection);

 function lp_GetMovingPoint(aControl: TvgChromeLikeTab): TvgPoint;
 var
  l_R: TvgRect;
  l_vCenter: Single;
 begin
  l_R := aSender.ParentedRect;
  l_vCenter := ((l_R.Bottom - l_R.Top) / 2) + l_R.Top;
  case aDirection of
   mdLeft:
    Result := vgPoint(l_R.Left, l_vCenter);
   mdRight:
    Result := vgPoint(l_R.Right, l_vCenter);
  end;
 end;//lp_GetMovingPoint

 function lp_NeedRearrange(const aPoint: TvgPoint; const aRect: TvgRect): Boolean;
 var
  l_SubjectRect: TvgRect;
  l_HalfWidth: Single;
 begin
  l_SubjectRect := aRect;
  l_HalfWidth := ((aRect.Right - aRect.Left) / 2) + aRect.Left;
  case aDirection of
   mdLeft:
    l_SubjectRect.Right := l_SubjectRect.Left + l_HalfWidth;
   mdRight:
    l_SubjectRect.Left := l_SubjectRect.Right - l_HalfWidth;
  end;
  Result := vgPtInRect(aPoint, l_SubjectRect);
 end;

var
 l_NewSlotIndex: Integer;
 l_OriginalSlotIndex: Integer;
 l_ControlInSlot: TvgChromeLikeTab;
 l_MovingPoint: TvgPoint;
begin
 l_MovingPoint := lp_GetMovingPoint(aSender);
 if GetTabUnderPoint(aPos, l_ControlInSlot, aSender) then
 begin
  if lp_NeedRearrange(l_MovingPoint, l_ControlInSlot.ParentedRect) then
  begin
   l_OriginalSlotIndex := GetControlSlot(aSender);
   l_NewSlotIndex := GetSlotIndexUnderPoint(aPos);
   if (l_OriginalSlotIndex <> cItemNotFound) AND
    (l_NewSlotIndex <> cItemNotFound) AND
    (l_OriginalSlotIndex <> l_NewSlotIndex) then
   begin
    AssignSlot(l_ControlInSlot, l_OriginalSlotIndex);
    l_ControlInSlot.PerformAnimation(f_RectList[l_NewSlotIndex],
     f_RectList[l_OriginalSlotIndex], cTabMovingAnimationDuration);
    AssignSlot(aSender, l_NewSlotIndex);
   end;//if if (l_OriginalSlot <> l_SlotIndex)
  end;//if lp_NeedRearrange(
 end;
end;//SignalMovingTab

procedure TChromeLikeTabSet.SignalMovingTabFinished(aSender: TvgChromeLikeTab;
 aPos: TvgPoint);
var
 l_SlotIndex: Integer;
begin
 l_SlotIndex := GetControlSlot(aSender);
 if (l_SlotIndex <> cItemNotFound) then
 begin
  aSender.PerformAnimation(aSender.ParentedRect, f_RectList.Items[l_SlotIndex],
   cTabMovingAnimationDuration);
  f_MovingControl := nil;
  UpdateTabsZOrder;
 end;//then
end;//SignalMovingTabFinished

procedure TChromeLikeTabSet.SignalStartTabDraggingOut(aSender: TvgChromeLikeTab;
 aPos: TvgPoint; var aNeedCloseTab: Boolean);
begin
  DoDragOutTab(aSender, aPos, aNeedCloseTab);
end;

procedure TChromeLikeTabSet.SignalSelectionChanged(aSender: TvgChromeLikeTab;
 aSelected: Boolean);
var
 l_Item: TvgTabButtonItem;
 l_Index: Integer;
begin
 if aSelected and GetItemForControl(aSender, l_Item, l_Index) then
 begin
  if Assigned(f_OnSelectionChanged) then
   f_OnSelectionChanged(Self, l_Item, True);
 end;
end;

procedure TChromeLikeTabSet.ShiftSlots(aFrom: Integer;
 aDirection: TvgClosingTabMovingDirection);
const
 cShiftSignArr : array[TvgClosingTabMovingDirection] of Integer = (0, -1, 1);

 function lp_DoShiftSlot(aSlotItem: PvgRect; aIndex: Integer): Boolean;
 var
  l_ShiftValue: Single;
  l_RectWidth: Single;
 begin
  l_RectWidth := vgRectWidth(aSlotItem^);
  l_ShiftValue := l_RectWidth * cShiftSignArr[aDirection];
  aSlotItem^.Left := aSlotItem^.Left + l_ShiftValue;
  aSlotItem^.Right := aSlotItem^.Right + l_RectWidth;
  Result := True;
 end;//lp_DoShiftSlot

begin
 f_RectList.IterateF(aFrom, Pred(f_RectList.Count), l3L2IA(@lp_DoShiftSlot));
end;//ShiftSlots

procedure TChromeLikeTabSet.ShiftTabs(aFrom: Integer; aDirection: TvgClosingTabMovingDirection);
const
 cShiftSignArr : array[TvgClosingTabMovingDirection] of Integer = (0, -1, 1);

 function lp_DoShift(aSlotItem: PvgRect; aIndex: Integer): Boolean;
 var
  l_ItemIndex: Integer;
  l_Item: TvgTabButtonItem;
 begin
  l_ItemIndex := GetItemIndexInSlot(aIndex);
  if (l_ItemIndex <> cItemNotFound) then
  begin
   l_Item := f_Tabs.Items[l_ItemIndex];
   l_Item.rSlotIndex := l_Item.rSlotIndex + cShiftSignArr[aDirection];
   f_Tabs.Items[l_ItemIndex] := l_Item;
  end;//if (l_ItemIndex <> cItemNotFound)
  Result := True;
 end;//lp_DoShiftTab

begin
 f_RectList.IterateF(aFrom, Pred(f_RectList.Count), @l3L2IA(@lp_DoShift));
end;//ShiftTabs

procedure TChromeLikeTabSet.InsertSlot(aSlotIndex: Integer);
var
 l_SlotRect: TvgRect;
begin
 if (aSlotIndex <= Pred(f_RectList.Count)) then
 begin
  l_SlotRect := f_RectList.Items[aSlotIndex];
  ShiftSlots(aSlotIndex, mdRight);
  ShiftTabs(aSlotIndex, mdRight);
  f_RectList.Insert(aSlotIndex, l_SlotRect);
  AlignTabs(True);
 end;
end;//InsertSlot

procedure TChromeLikeTabSet.DeleteSlot(aSlotIndex: Integer);
var
 l_NeedRearrange: Boolean;
 l_FirstShiftSlotIndex: Integer;
begin
 l_NeedRearrange := (aSlotIndex < Pred(f_RectList.Count));
 l_FirstShiftSlotIndex := Succ(aSlotIndex);
 if l_NeedRearrange then
  ShiftTabs(l_FirstShiftSlotIndex, mdLeft);
 f_RectList.Delete(aSlotIndex);
 if l_NeedRearrange then
  ShiftSlots(l_FirstShiftSlotIndex, mdLeft);
end;//DeleteSlot

function TChromeLikeTabSet.AddSlot: Integer;

 function lp_GetNewSlot: TvgRect;
 var
  l_MostRight: Single;

  function lp_DoGetMostRight(anItem: PvgRect; aIndex: Integer): Boolean;
  begin
   if (anItem.Right > l_MostRight) then
    l_MostRight := anItem.Right;
   Result := True;
  end;//lp_DoGetMostRight

 begin
  l3FillChar(Result, SizeOf(Result), 0);
  l_MostRight := 0;
  f_RectList.IterateAllF(l3L2IA(@lp_DoGetMostRight));
  Result := vgRect(l_MostRight, cTabItemTopOffset, l_MostRight + CalcTabWidth, cTabItemTopOffset + cTabItemHeight);
 end;//lp_GetNewSlot

var
 l_SelectedSlot: Integer;
begin
 l_SelectedSlot := Selected.rSlotIndex;
 if (l_SelectedSlot < Pred(f_RectList.Count)) then
 begin
  Result := l_SelectedSlot + 1;
  InsertSlot(Result);
 end
 else
  Result := f_RectList.Add(lp_GetNewSlot);
end;//AddSlot

procedure TChromeLikeTabSet.ResizeSlots;
var
 l_SlotWidth: Single;
 l_Left: Single;

 function lp_DoResizeSlot(anItem: PvgRect; aIndex: Integer): Boolean;
 begin
  anItem^.Left := l_Left;
  anItem^.Top := cTabItemTopOffset;
  anItem^.Bottom := cTabItemTopOffset + cTabItemHeight;
  anItem^.Right := anItem^.Left + l_SlotWidth;
  l_Left := l_Left + l_SlotWidth - 2;
  Result := True;
 end;//lp_DoResizeSlot

begin
 l_Left := 0;
 l_SlotWidth := CalcTabWidth;
 f_RectList.IterateAllF(l3L2IA(@lp_DoResizeSlot));
end;//ResizeSlots

function TChromeLikeTabSet.DoAddTab(const aTabItem: TvgTabButtonItem;
 aSlotIndex: Integer = -1): Integer;
var
 l_TabItem: TvgTabButtonItem;
 l_SlotIndex: Integer;
begin
 l_SlotIndex := cItemNotFound;
 l_TabItem := aTabItem;
 l_TabItem.rButton := MakeTabItemControl(l_TabItem);
 if (aSlotIndex <> cItemNotFound) then
 begin
  InsertSlot(aSlotIndex);
  l_SlotIndex := aSlotIndex;
 end
 else
  l_SlotIndex := AddSlot;
 ResizeSlots;
 AlignTabs(True);
 l_TabItem.rSlotIndex := l_SlotIndex;
 Result := f_Tabs.Add(l_TabItem);
 l_TabItem.rButton.PositionBounds.Rect := f_RectList.Items[l_SlotIndex];
 l_TabItem.rButton.Width := CalcTabWidth;
 ResizeSlots;
 AlignTabs;
 Scene.Repaint;
 UpdateSceneHitTest;
end;//DoAddTab

procedure TChromeLikeTabSet.DoTabParentMouseDown(aSender: TObject; aButton: TMouseButton;
 aShift: TShiftState; aX: Single; aY: single);
begin
 f_LastMovingPoint := vgPoint(aX, aY);
 f_Maximizing := False;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=590512155 
end;//DoTabParentMouseDown

procedure TChromeLikeTabSet.DoTabParentMouseMove(aSender: TObject; aShift: TShiftState;
   aX: Single; aY: Single; aDx: Single; aDy: Single);

 function lp_WasMoving(const aPointA: TvgPoint; const aPointB: TvgPoint; aMinDelta: Single): Boolean;
 begin
  Result := (Abs(aPointA.X - aPointB.Y) >= aMinDelta) or
            (Abs(aPointA.Y - aPointB.Y) >= aMinDelta);
 end;//lp_WasMoving

var
 l_Tab: TvgChromeLikeTab;
 l_Pt: TvgPoint;
 l_sPt: TPoint;
 l_IsTabUnderPoint: Boolean;
begin
 l_Pt := vgPoint(aX, aY);
 if (ssLeft in aShift) and
    (not (csDestroying in Scene.ComponentState)) and
    lp_WasMoving(f_LastMovingPoint, l_Pt, cMinMovingDelta) and
    (f_TabParent <> nil) then
 begin
  l_IsTabUnderPoint := GetTabUnderPoint(l_Pt, l_Tab);
  if (not l_IsTabUnderPoint) or (TabCount = 1) then
  begin
   l_sPt := SceneToScreen(l_Pt);

   ReleaseCapture;

   if (not f_Maximizing) and
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=590512155
      (IsAppThemed or ((Form.WindowState <> wsMaximized) or (Win32MajorVersion >= 6))) then
    SendMessage(Form.Handle, WM_SYSCOMMAND, cNonClientMouseDragCommand, 0);
   // - в классической теме до ¬исты не прин€то таскать развернутые окна
   f_LastMovingPoint := l_Pt;
  end;//not GetTabUnderPoint
 end;//if not (csDestroying...
end;//DoTabParentMouseMove

procedure TChromeLikeTabSet.DoTabParentDblClick(aSender: TObject);
var
 l_ParentForm: TCustomForm;
 l_wParam: WPARAM;
begin
 l_ParentForm := GetParentForm(Scene);
 if (l_ParentForm.WindowState <> wsMaximized) then
 begin
  l_wParam := SC_MAXIMIZE;
  f_Maximizing := True;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=590512155
 end
 else
 begin
  l_wParam := SC_RESTORE;
  f_Maximizing := False;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=590512155 
 end;
 SendMessage(l_ParentForm.Handle, WM_EXITSIZEMOVE, 0, 0);
 ReleaseCapture;
 SendMessage(l_ParentForm.Handle, WM_SYSCOMMAND, l_wParam, 0);
end;//DoTabParentDblClick

function TChromeLikeTabSet.SceneToScreen(const aPoint: TvgPoint): TPoint;
var
 l_Scene: IvgScene;
 l_Pt: TvgPoint;
begin
 if Supports(Scene, IvgScene, l_Scene) then
 try
  l_Pt := l_Scene.LocalToScreen(aPoint);
  Result := TruncPt(l_Pt);
 finally
  l_Scene := nil;
 end;//try..finally
end;//SceneToScreen

function TChromeLikeTabSet.SceneToScreen(const aRect: TvgRect): TRect;
var
 l_Scene: IvgScene;
 l_ScreenRect: TvgRect;
begin
 if Supports(Scene, IvgScene, l_Scene) then
 try
  l_ScreenRect.TopLeft := l_Scene.LocalToScreen(aRect.TopLeft);
  l_ScreenRect.BottomRight := l_Scene.LocalToScreen(aRect.BottomRight);
  Result := TruncRect(l_ScreenRect);
 finally
  l_Scene := nil;
 end;
end;//SceneToScreen

function TChromeLikeTabSet.ScreenToScene(const aRect: TRect): TvgRect;
var
 l_Scene: IvgScene;
 l_ScreenRect: TvgRect;
begin
 if Supports(Scene, IvgScene, l_Scene) then
 try
  l_ScreenRect := MakeVgRect(aRect);
  Result.TopLeft := l_Scene.ScreenToLocal(l_ScreenRect.TopLeft);
  Result.BottomRight := l_Scene.ScreenToLocal(l_ScreenRect.BottomRight);
 finally
  l_Scene := nil;
 end;
end;//ScreenToScene

function TChromeLikeTabSet.ScreenToScene(const aPoint: TPoint): TvgPoint;
var
 l_Scene: IvgScene;
begin
 if Supports(Scene, IvgScene, l_Scene) then
 try
  Result := l_Scene.ScreenToLocal(vgPoint(aPoint.X, aPoint.Y));
 finally
  l_Scene := nil;
 end;//try..finally
end;//ScreenToScene

procedure TChromeLikeTabSet.UndockTabForm(const aTabItem: TvgTabButtonItem;
 const aTabRect: TvgRect; aNeedProcessMouse: Boolean = True;
 aNeedMakeNewContainer: Boolean = False; const aParams: IChromeLikeTabParams = nil);

 procedure lp_DoUndockForm(aForm: TForm; const aRect: TRect);
 begin
  with aForm do
  begin
   ResetMouseControl;
   Visible := False;
   Align := alNone;
   ManualFloat(aRect);
   BoundsRect := aRect;
   ResetMouseControl;
  end;//with aForm
 end;//lp_DoUndockForm

var
 l_CurTabScreenRect: TRect;
 l_Bounds: TRect;
 l_Rect: TRect;
 l_MousePos: TPoint;
 l_SelfTopLeft: TPoint;
 l_SelfBottomRight: TPoint;
 l_FromLeft: Integer;
 l_WasLButtonDown: Boolean;
 l_NewContainer: TForm;
 l_FloatingTop: Integer;
 l_VertCenter: Integer;
 l_CurSlot: Integer;
 l_NewSelectedIndex: Integer;
begin
 Lock;
 try
  l_WasLButtonDown := False;
  l_NewContainer := nil;

  if aNeedProcessMouse then
  begin
   l_WasLButtonDown := (GetAsyncKeyState(VK_LBUTTON) < 0);
   Windows.GetCursorPos(l_MousePos);
  end
  else
   l_MousePos := SceneToScreen(aTabItem.rButton.Position.Point);

  l_CurTabScreenRect := SceneToScreen(aTabRect);
  GetWindowRect(Scene.Handle, l_Bounds);
  l_SelfTopLeft := l_Bounds.TopLeft;
  l_SelfBottomRight := l_Bounds.BottomRight;
  l_VertCenter := l_Bounds.Top + ((l_Bounds.Bottom - l_Bounds.Top) div 2);
  if (l_MousePos.Y > l_VertCenter) then
   l_FloatingTop := l_VertCenter
  else
   l_FloatingTop := l_MousePos.Y - ((l_Bounds.Bottom - l_Bounds.Top) div 2);

  with l_Rect do
  begin
   TopLeft.X := l_CurTabScreenRect.Left;
   TopLeft.Y := l_FloatingTop;
   BottomRight.X := l_Rect.Left + f_FloatFormWidth;
   BottomRight.Y := l_Rect.Top + f_FloatFormHeight;
  end;//with l_Rect

  aTabItem.rForm.Visible := false;

  l_NewSelectedIndex := 0;

  // ѕри закрытии вкладки открываетс€ предыдуща€ вкладка, т.е. та, котора€
  // находитс€ левее
  if (l_CurSlot > 0) then
   l_NewSelectedIndex := GetItemIndexInSlot(Pred(l_CurSlot))
  else
  if (f_RectList.Count > 1) and (l_CurSlot < Pred(f_RectList.Count)) then
   l_NewSelectedIndex := GetItemIndexInSlot(Succ(l_CurSlot));

  if Assigned(f_OnTabDetached) then
   f_OnTabDetached(Self, aTabItem, l_MousePos, l_NewSelectedIndex);

  l_CurSlot := aTabItem.rSlotIndex;

  if aNeedMakeNewContainer then
  begin  // Ќужно сразу положить форму в контейнер
   l_NewContainer := TvcmTabbedContainerFormDispatcher.Instance.InsertFormIntoANewContainer(aTabItem.rForm,
    l_Rect, aParams);
   f_Scene.Repaint;
   l_NewContainer.BoundsRect := l_Rect;
   l_NewContainer.Visible := True;
  end
  else // Ќужно просто отдочить форму
   lp_DoUndockForm(aTabItem.rForm, l_Rect);

  if (l_NewContainer <> nil) and (aNeedProcessMouse and l_WasLButtonDown) then
  begin
   afw.ProcessMessages;
   ReleaseCapture;
   // ѕри отдочивании форму нужно подн€ть
   l_NewContainer.BringToFront;
   SetActiveWindow(l_NewContainer.Handle);
   SendMessage(l_NewContainer.Handle, WM_SYSCOMMAND, cNonClientMouseDragCommand, 0);
  end;//if (aNeedProcessMouse and l_WasLButtonDown)
  RearrangeTabs;
  Scene.Repaint;
  ClearSceneMessages;
 finally
  Unlock;
 end;
end;//UndockTabForm

procedure TChromeLikeTabSet.InitDockedForm(aForm: TForm; aNeedSelect: Boolean = True);
var
 l_Index: Integer;
 l_Form: TForm;
begin
 Assert(aForm <> nil);
 ResetMouseControl;
 aForm.Visible := False;
 aForm.ManualDock(f_DockHostControl, nil, alClient);
 ResetMouseControl;
 aForm.Align := alClient;

 aForm.Visible := aNeedSelect;

 if Assigned(f_OnAfterFormAdded) then
  f_OnAfterFormAdded(aForm, Self, aNeedSelect);
 if aNeedSelect then
  SelectedForm := aForm;
end;

procedure TChromeLikeTabSet.DoDockForm(aForm: TForm; const aPoint: TvgPoint);
begin
 AddFormTab(aForm, aPoint);
 InitDockedForm(aForm);
end;//DoDockForm

procedure TChromeLikeTabSet.DoDockForm(aForm: TForm; aNeedSelect: Boolean = True; const aParams: IChromeLikeTabParams = nil);
begin
 AddFormTab(aForm, aParams);
 InitDockedForm(aForm, aNeedSelect);
end;

function TChromeLikeTabSet.MakeTabItemControl(
  const aTabItem: TvgTabButtonItem): TvgChromeLikeTab;
var
 l_TabButton : TvgChromeLikeTab;
begin
 l_TabButton := TvgChromeLikeTab.Create(Scene);
 with l_TabButton do
 begin
  Resource := cChromeLikeTabStyleName;
  Height := Self.Scene.Height;
  TextAlign := vgTextAlignCenter;
  Parent := TabParent;
  Text := l3DStr(GetFormCaption(aTabItem.rForm));
  ShowHint := True;
  l_TabButton.Width := Max(TvgCanvas(l_TabButton.Canvas).TextWidth(l_TabButton.Text) + (cTabBorderWidth  *2),
   cDefaultTabWidth);
  OnTabClick := DoTabClick;
  OnCloseTab := SignalCloseTabForm;
  OnStartMove := SignalStartMovingTab;
  OnMovingTab := SignalMovingTab;
  OnMovingTabFinished := SignalMovingTabFinished;
  OnStartDraggingOut := SignalStartTabDraggingOut;
  OnSelectionChanged := SignalSelectionChanged;
  OnCheckCanMove := DoCheckTabCanBeMoved;
  OnCloseButtonClick := DoTabCloseButtonClick;
  OnSelected := DoTabSelected;
  OnDeselected := DoTabDeselected;
  OnRequestAlignTabs := DoOnRequestAlignTabs;
  CloseButtonInactiveBitmap := (FindResource(cChromeLikeTabCloseButtonInactiveBitmap) as TvgBitmapObject).Bitmap;
  CloseButtonActiveBitmap := (FindResource(cChromeLikeTabCloseButtonActiveBitmap) as TvgBitmapObject).Bitmap;
  TabTextHAlign := vgTextAlignNear;

  IconImage.Visible := False;

  Glyph.Images := f_Images;
  Glyph.ImageIndex := 0;
  DrawTextWithEllipsis := True;
  ApplyStyleElement(cDefaultTabStyle.rNormalStyle);
  f_TabSet := Self;
 end;//with l_TabButton
 l_TabButton.CloseButton;
 Result := l_TabButton;
end;//MakeTabItemControl

procedure TChromeLikeTabSet.DoRemoveTab(aTab: TvgChromeLikeTab; const aPos: TvgPoint);
var
 l_Pt: TvgPoint;
 l_sPt: TPoint;
 l_cPt: TPoint;
 l_Scene: IvgScene;
 l_Item: TvgTabButtonItem;
 l_Index: Integer;
 l_TabRect: TvgRect;
 l_Params: IChromeLikeTabParams;
begin
 if (CanDetachTab(aTab) and Supports(Scene, IvgScene, l_Scene)) then
 begin
  Lock;
  try
   try
    l_Pt := l_Scene.LocalToScreen(aPos);
   finally
    l_Scene := nil;
   end;
   l_sPt := TruncPt(l_Pt);
   l_cPt := Scene.ScreenToClient(l_sPt);
   if (l_cPt.Y >= Scene.ClientRect.Bottom) or (l_cPt.Y <= Scene.ClientRect.Top) then
    if GetItemForControl(aTab, l_Item, l_Index) then
    begin
     if (aTab <> nil) then
     begin
      l_Params := MakeFormTabParams(l_Item.rForm);
      l_TabRect := aTab.ParentedRect;
      SignalCloseTab(aTab);
      ResizeSlots;
      AlignTabs(True);

      UndockTabForm(l_Item, l_TabRect, True, True, l_Params);
      if (l_Index < Pred(f_Tabs.Count)) then
       Selected := f_Tabs.Last;
     end;//if (aTab <> nil)
   end;
  finally
   Unlock;
  end;
 end;//if (CanDetachTab(aTab) ...
end;

procedure TChromeLikeTabSet.DoFormResize;
begin
 ResizeSlots;
 AlignTabs;
end;

procedure TChromeLikeTabSet.ClearSelection;

 function lp_DoUnselect(anItem: PvgTabButtonItem; anIndex: Integer): Boolean;
 begin
  anItem^.rButton.Selected := False;
  Result := True;
 end;//lp_DoUnselect

begin
 f_Tabs.IterateAllF(l3L2IA(@lp_DoUnselect));
end;

procedure TChromeLikeTabSet.UpdateTabsZOrder;
var
 l_SlotIndex: Integer;
 l_Control: TvgChromeLikeTab;
begin
 for l_SlotIndex := Pred(f_RectList.Count) downto 0 do
 begin
  l_Control := GetControlInSlot(l_SlotIndex);
  if (l_Control <> nil) then
   l_Control.BringToFront;
 end;
 if (Selected.rButton <> nil) then
  Selected.rButton.BringToFront;
end;//UpdateTabsZOrder

procedure TChromeLikeTabSet.CheckNeedSelect;
begin
 if (f_Tabs.Count = 1) then
  f_Tabs.Items[0].rButton.Selected := True;
end;

procedure TChromeLikeTabSet.DeleteTabLater(aTab: TvgChromeLikeTab);
begin
 with aTab do
 begin
  Visible := False;
  HitTest := False;
  CloseButton.Visible := False;
  CloseButton.HitTest := False;
  OnCloseButtonClick := nil;
  OnClick := nil;
  OnCloseTab := nil;
  OnStartMove := nil;
  OnMovingTab := nil;
  OnMovingTabFinished := nil;
  OnStartDraggingOut := nil;
  OnSelectionChanged := nil;
  OnCheckCanMove := nil;
  OnCloseButtonClick := nil;
  OnSelected := nil;
  OnDeselected := nil;
  OnRequestAlignTabs := nil;
 end;
 if Assigned(f_OnNeedDestroyTab) then
  f_OnNeedDestroyTab(Self, aTab)
  // http://mdp.garant.ru/pages/viewpage.action?pageId=586352222
 else
  FreeAndNil(aTab);
end;

procedure TChromeLikeTabSet.ClearSceneMessages;
var
 l_Msg: TMsg;
begin
 while PeekMessage(l_Msg, Scene.Handle, 0, 0, PM_REMOVE) do ; 
end;

function TChromeLikeTabSet.CanDragOutTab(const aTab: TvgTabButtonItem): Boolean;
var
 l_CanDragOut: Boolean;
begin
 l_CanDragOut := True;
 if Assigned(f_OnCanDragOutTab) then
  f_OnCanDragOutTab(Self, aTab, l_CanDragOut);
 Result := l_CanDragOut;
end;

function TChromeLikeTabSet.GetFormCaption(aForm: TForm): Il3CString;
begin
 Result := nil;
 if Assigned(f_OnGetTabFormCaptionFunc) then
  Result := f_OnGetTabFormCaptionFunc(Self, aForm)
 else
  Result := l3CStr(aForm.Caption);
end;

function TChromeLikeTabSet.GetNextSelectedTabIndexAfterClosing(const aClosingTab: TvgTabButtonItem): Integer;
var
 l_ClosingSelected: Boolean;
 l_TabSlotIndex: Integer;
 l_NewSelectedSlotIndex: Integer;
begin
 Result := SelectedIndex;
 l_ClosingSelected := (Selected.EQ(aClosingTab));
 l_TabSlotIndex := aClosingTab.rSlotIndex;
 if l_ClosingSelected AND (TabCount > 0) then
 begin
  if (l_TabSlotIndex > 0) then
   l_NewSelectedSlotIndex := Pred(l_TabSlotIndex)
  else
   l_NewSelectedSlotIndex := Succ(l_TabSlotIndex);
  Result := GetItemIndexInSlot(l_NewSelectedSlotIndex);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=564735899
 end;//if (TabCount > 0)
end;

procedure TChromeLikeTabSet.Lock;
begin
 Inc(f_LockCount);
end;

procedure TChromeLikeTabSet.Unlock;
begin
 Dec(f_LockCount);
 if (f_LockCount = 0) then
 begin
  ResizeSlots;
  AlignTabs;
 end;
end;

function TChromeLikeTabSet.GetFormTabIndex(aForm: TForm): Integer;
var
 l_Index: Integer;

 function lp_DoFindFormTab(anItem: PvgTabButtonItem; anIndex: Integer): Boolean;
 begin
  if (anItem^.rForm = aForm) then
  begin
   l_Index := anIndex;
   Result := False;
  end
  else
   Result := True;
 end;//lp_DoFindFormTab

begin
 l_Index := cItemNotFound;
 f_Tabs.IterateAllF(l3L2IA(@lp_DoFindFormTab));
 Result := l_Index;
end;

function TChromeLikeTabSet.CanDetachTab(aTab: TvgChromeLikeTab): Boolean;
begin
 Result := (f_Tabs.Count > 1);
end;

function TChromeLikeTabSet.pm_GetScene: TvgScene;
begin
 Result := f_Scene;
end;//pm_GetScene

function TChromeLikeTabSet.pm_GetTabParent: TvgVisualObject;
begin
 Result := f_TabParent;
end;//pm_GetTabParent

procedure TChromeLikeTabSet.pm_SetScene(const aValue: TvgScene);
var
 l_IsAeroEnabled: Windows.BOOL;
begin
 Assert(aValue <> nil);
 if (aValue <> f_Scene) then
 begin
  f_Scene := aValue;
  f_Scene.RecreateCanvas := True;
  f_Scene.Style := ChromeLikeTabSetResources.vgResources;
  DwmIsCompositionEnabled(l_IsAeroEnabled);
  f_Scene.ForceUseSystemDefaultTextRendering := l_IsAeroEnabled;
 end;//if (aValue <> f_Scene)
end;//pm_SetScene

procedure TChromeLikeTabSet.pm_SetTabParent(const aValue: TvgVisualObject);
begin
 Assert(aValue <> nil);
 if (aValue <> f_TabParent) then
 begin
  f_TabParent := aValue;
  with f_TabParent do
  begin
   HitTest := True;
   OnMouseDown := DoTabParentMouseDown;
   OnMouseMove := DoTabParentMouseMove;
   OnDblClick := DoTabParentDblClick;
  end;//with f_TabParent
 end;//if (aValue <> f_TabParent) 
end;//pm_SetTabParent

function TChromeLikeTabSet.pm_GetContentWidth: Integer;
var
 l_Width: Single;

 function lp_DoGetSlotWidth(aSlotItem: PvgRect; aIndex: Integer): Boolean;
 begin
  l_Width := l_Width + vgRectWidth(aSlotItem^);
  Result := True;
 end;//lp_DoGetSlotWidth

begin
 Result := 0;
 f_RectList.IterateAllF(l3L2IA(@lp_DoGetSlotWidth));
 Result := Trunc(l_Width);
end;//pm_GetContentWidth

function TChromeLikeTabSet.pm_GetTabCount: Integer;
begin
 Result := f_Tabs.Count;
end;//pm_GetTabCount

function TChromeLikeTabSet.pm_GetTab(aIndex: Integer): TvgTabButtonItem;
begin
 Result := f_Tabs.Items[aIndex];
end;//pm_GetTab

function TChromeLikeTabSet.pm_GetSelectedIndex: Integer;
var
 l_SelectedIndex: Integer;

 function lp_DoFindSelected(anItem: PvgTabButtonItem; anIndex: Integer): Boolean;
 begin
  if (anItem^.rButton <> nil) and (anItem^.rButton.Selected) then
  begin
   Result := False;
   l_SelectedIndex := anIndex;
  end
  else
   Result := True;
 end;//lp_DoFindSelected

begin
 l_SelectedIndex := -1;
 f_Tabs.IterateAllF(l3L2IA(@lp_DoFindSelected));
 Result := l_SelectedIndex;
end;

procedure TChromeLikeTabSet.pm_SetSelectedIndex(aValue: Integer);
var
 l_Item: TvgTabButtonItem;
begin
 if (aValue >= 0) and (aValue < f_Tabs.Count) then
 begin
  l_Item := f_Tabs[aValue];
  Selected := l_Item;
 end;
end;

function TChromeLikeTabSet.pm_GetSelected: TvgTabButtonItem;
var
 l_Item: TvgTabButtonItem;
 l_SelectedIndex: Integer;
begin
 l3FillChar(l_Item, SizeOf(l_Item), 0);
 l_SelectedIndex := pm_GetSelectedIndex;
 if (l_SelectedIndex <> -1) then
  l_Item := f_Tabs[l_SelectedIndex];
 Result := l_Item;
end;//pm_GetSelected

procedure TChromeLikeTabSet.pm_SetSelected(const aTabItem: TvgTabButtonItem);
var
 l_SelectedButton: TvgChromeLikeTab;

 function lp_DoSetSelected(anItem: PvgTabButtonItem; anIndex: Integer): Boolean;
 var
  l_B: TvgChromeLikeTab;
 begin
  l_B := anItem^.rButton;
  if (anItem^.rButton = aTabItem.rButton) then
   anItem^.rButton.Selected := (l_B = aTabItem.rButton);
  Result := True;
 end;//lp_DoSetSelected

begin
 if (not aTabItem.EQ(Selected)) then
 begin
  l_SelectedButton := Selected.rButton;
  if (l_SelectedButton <> nil) then
   l_SelectedButton.Selected := False;
  f_Tabs.IterateAllF(l3L2IA(@lp_DoSetSelected));
  Scene.Repaint;
 end;
end;//pm_SetSelected

procedure TChromeLikeTabSet.pm_SetImages(aImageList: TCustomImageList);
var
 l_Index: Integer;
begin
 if (aImageList <> f_Images) then
 begin
  f_Images := aImageList;
  for l_Index := 0 to Pred(f_Tabs.Count) do
   f_Tabs[l_Index].rButton.Glyph.Images := f_Images;
 end;
end;

function TChromeLikeTabSet.pm_GetSelectedForm: TForm;
begin
 Result := Selected.rForm;
end;

procedure TChromeLikeTabSet.pm_SetSelectedForm(aForm: TForm);
var
 l_Index: Integer;
begin
 l_Index := GetFormTabIndex(aForm);
 if (l_Index <> cItemNotFound) then
  Selected := f_Tabs[l_Index]
 else
  Assert(False);
end;

function TChromeLikeTabSet.pm_GetIsEmpty: Boolean;
begin
 Result := (f_Tabs.Count = 0);
end;

function TChromeLikeTabSet.pm_GetIsLocked: Boolean;
begin
 Result := (f_LockCount > 0);
end;

end.

