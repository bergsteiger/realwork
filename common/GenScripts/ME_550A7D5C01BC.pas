unit ChromeLikeTabbedContainerForm.imp;

interface

uses
 l3IntfUses
 , l3TabbedContainersDispatcher
 , ChromeLikeTabSetControl
 , Controls
 , Types
 , Messages
 , ChromeLikeTabSetControlPrim
 , Graphics
 , Forms
 , ChromeLikeInterfaces
 , Classes
 , Windows
;

type
 _ChromeLikeTabbedContainerForm_ = class(MForm, Il3TabbedContainer)
  procedure DoOnTabSelected(aTabSet: TChromeLikeTabSetControlPrim;
   aTab: TChromeLikeTab);
  procedure DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
   aTab: TChromeLikeTab);
  procedure DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
   const aRect: TRect;
   aCanvas: TCanvas;
   var aDefaultPainting: Boolean);
  procedure DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
   aForm: TForm;
   var aCanUndock: Boolean);
  procedure DoOnAfterFormAdded(aTabSet: TChromeLikeTabSetControlPrim;
   aForm: TForm;
   aNeedSelect: Boolean);
  procedure DoOnCanDockForm(aTabSet: TChromeLikeTabSetControlPrim;
   aForm: TForm;
   aNeedSelect: Boolean;
   var aCanDock: Boolean);
  procedure DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
   aTab: TChromeLikeTab;
   var aCanClose: Boolean;
   aNewSelectedTab: TChromeLikeTab);
  procedure DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
   aPrevSelected: TChromeLikeTab;
   aNewSelected: TChromeLikeTab);
  function DoGetTabSetParent: TWinControl;
  procedure ActivateTabByIndex(aIndex: Integer);
  procedure ActivateNextTab;
  procedure ActivatePrevTab;
  procedure InsertForm(aForm: TForm;
   const aTabParams: Il3TabParams;
   aNeedSelect: Boolean;
   aInsertLast: Boolean;
   aInsertAfter: TForm); overload;
  procedure InsertForm(aForm: TForm;
   const aMousePoint: TPoint;
   const aTabParams: Il3TabParams;
   aNeedSelect: Boolean); overload;
  procedure CloseSelectedForm;
  procedure SetSelected(aForm: TForm);
  procedure RedrawTabSet;
  procedure BeforeInsertForm(aForm: TForm);
  procedure AfterInsertForm(aForm: TForm;
   const aParams: Il3TabParams;
   aNeedSelect: Boolean);
  procedure InsertFormAfterSelected(aForm: TForm;
   const aParams: Il3TabParams;
   aNeedSelect: Boolean);
  procedure InsertFormAtPoint(aForm: TForm;
   const aParams: Il3TabParams;
   const aPoint: TPoint;
   aNeedSelect: Boolean);
  function DoMakeClone: Il3TabbedContainer;
  function GetTabsHeight: Integer;
  procedure MakeTabSet;
  function CanDockToAnother(const aPoint: TPoint): Boolean;
  procedure DockToAnother(const aMousePoint: TPoint;
   aForm: TForm);
  procedure UpdateContainedFormsActions;
  procedure ResetMouseControl;
  function DoGetFormDockSite: TWinControl;
  function IsDockOperationPossible: Boolean;
  procedure DisableOthers(aSelectedForm: TForm);
  procedure RemoveForm(aForm: TForm;
   aNoClose: Boolean);
  function CheckFormTabParams(aForm: TForm;
   const aParams: Il3TabParams): Il3TabParams;
  function MakeTabSetParams: TChromeLikeTabSetParams;
  procedure DoOpenNewTab;
  procedure DoOnNewTabRequested(aTabSet: TChromeLikeTabSetControlPrim);
  function DoGetCanOpenNewTab: Boolean;
  procedure InsertFormAfterSpecified(aForm: TForm;
   const aParams: Il3TabParams;
   aInsertAfter: TForm;
   aNeedSelect: Boolean);
  procedure DoUpdateCaption;
  procedure WMMove(var aMessage: TMessage);
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
  function AsForm: TForm;
  function GetFormTab(aForm: TForm): Il3FormTab;
  function Tabs: Il3FormTab;
  function TabCount: Integer;
  function ActiveTab: Il3FormTab;
  procedure CloseAllButActiveTab;
  procedure OpenNewTab;
  function CanOpenNewTab: Boolean;
  procedure CloseSelectedTab;
  procedure CloseTab(const aTab: Il3FormTab);
  procedure UpdateCaption;
 end;//_ChromeLikeTabbedContainerForm_
 
implementation

uses
 l3ImplUses
 , ChromeLikeTabSetTypes
 , afwFacade
;

type
 THackApplication = class(TComponent)
 end;//THackApplication
 
 THackCustomForm = class(TCustomForm)
 end;//THackCustomForm
 
end.
