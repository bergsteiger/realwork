{$IfNDef ChromeLikeTabbedContainerForm_imp}

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabbedContainerForm.imp.pas"
// Стереотип: "GUIControlMixIn"

{$Define ChromeLikeTabbedContainerForm_imp}

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 _ChromeLikeTabbedContainerForm_ = class(_ChromeLikeTabbedContainerForm_Parent_, Il3TabbedContainer)
  private
   f_LastMovingPoint: TPoint;
   f_ShowingChangedTickCount: Cardinal;
   f_LastDockOperationTickCount: Cardinal;
   f_PositionLockCount: Integer;
   f_TabSet: TChromeLikeTabSetControl;
    {* Поле для свойства TabSet }
  private
   procedure InsertFormAfterSelected(aForm: TForm;
    const aParams: Il3TabParams;
    aNeedSelect: Boolean);
   procedure InsertFormAtPoint(aForm: TForm;
    const aParams: Il3TabParams;
    const aPoint: TPoint;
    aNeedSelect: Boolean);
   procedure DisableOthers(aSelectedForm: TForm);
   procedure DoOnNewTabRequested(aTabSet: TChromeLikeTabSetControlPrim;
    aOpenLast: Boolean);
   procedure InsertFormAfterSpecified(aForm: TForm;
    const aParams: Il3TabParams;
    aInsertAfter: TForm;
    aNeedSelect: Boolean);
   procedure WMMove(var aMessage: TMessage); message WM_MOVE;
  protected
   function pm_GetTabSetParent: TWinControl;
   function pm_GetFormDockSite: TWinControl;
   function pm_GetPositionLocked: Boolean; virtual;
   procedure DoOnTabSelected(aTabSet: TChromeLikeTabSetControlPrim;
    aTab: TChromeLikeTab); virtual;
   procedure DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
    aTab: TChromeLikeTab); virtual;
   procedure DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
    const aRect: TRect;
    aCanvas: TCanvas;
    var aDefaultPainting: Boolean); virtual;
   procedure DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
    aForm: TForm;
    var aCanUndock: Boolean); virtual;
   procedure DoOnAfterFormAdded(aTabSet: TChromeLikeTabSetControlPrim;
    aForm: TForm;
    aNeedSelect: Boolean); virtual;
   procedure DoOnCanDockForm(aTabSet: TChromeLikeTabSetControlPrim;
    aForm: TForm;
    aNeedSelect: Boolean;
    var aCanDock: Boolean); virtual;
   procedure DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
    aTab: TChromeLikeTab;
    var aCanClose: Boolean;
    aNewSelectedTab: TChromeLikeTab); virtual;
   procedure DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
    aPrevSelected: TChromeLikeTab;
    aNewSelected: TChromeLikeTab); virtual;
   function DoGetTabSetParent: TWinControl; virtual; abstract;
   procedure RedrawTabSet;
   procedure BeforeInsertForm(aForm: TForm); virtual;
   procedure AfterInsertForm(aForm: TForm;
    const aParams: Il3TabParams;
    aNeedSelect: Boolean); virtual;
   function DoMakeClone: Il3TabbedContainer; virtual; abstract;
   function GetTabsHeight: Integer; virtual;
   procedure MakeTabSet; virtual;
   function CanDockToAnother(const aPoint: TPoint): Boolean; virtual;
   procedure DockToAnother(const aMousePoint: TPoint;
    aForm: TForm); virtual; abstract;
   procedure UpdateContainedFormsActions;
   procedure ResetMouseControl;
   function DoGetFormDockSite: TWinControl; virtual;
   function IsDockOperationPossible: Boolean;
   function CheckFormTabParams(aForm: TForm;
    const aParams: Il3TabParams): Il3TabParams; virtual;
   function MakeTabSetParams: TChromeLikeTabSetParams; virtual;
   procedure DoOpenNewTab(aOpenLast: Boolean); virtual;
   function DoGetCanOpenNewTab: Boolean; virtual;
   procedure DoUpdateCaption; virtual;
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
   function pm_GetAsForm: TForm;
   function GetFormTab(aForm: TForm): Il3FormTab;
   function pm_GetTabs(Index: Integer): Il3FormTab;
   function pm_GetTabCount: Integer;
   function pm_GetActiveTab: Il3FormTab;
   procedure pm_SetActiveTab(const aValue: Il3FormTab);
   procedure CloseAllButActiveTab;
   procedure OpenNewTab(aOpenLast: Boolean = True);
   function pm_GetCanOpenNewTab: Boolean;
   procedure CloseSelectedTab;
   procedure CloseTab(const aTab: Il3FormTab);
   procedure UpdateCaption;
   function Get_TabByVisibleIndex(Index: Integer): Il3FormTab;
   function CanUndockFormFromTab(aTabIndex: Integer): Boolean;
   procedure UndockFormFromTab(aTabIndex: Integer);
  public
   procedure ActivateTabByIndex(aIndex: Integer);
   procedure ActivateNextTab; virtual;
   procedure ActivatePrevTab;
   procedure InsertForm(aForm: TForm;
    const aTabParams: Il3TabParams = nil;
    aNeedSelect: Boolean = True;
    aInsertLast: Boolean = False;
    aInsertAfter: TForm = nil); overload;
   procedure InsertForm(aForm: TForm;
    const aMousePoint: TPoint;
    const aTabParams: Il3TabParams = nil;
    aNeedSelect: Boolean = True); overload;
   procedure CloseSelectedForm;
   procedure SetSelected(aForm: TForm);
   procedure RemoveForm(aForm: TForm;
    aNoClose: Boolean = True);
  protected
   property TabSet: TChromeLikeTabSetControl
    read f_TabSet;
   property TabSetParent: TWinControl
    read pm_GetTabSetParent;
   property FormDockSite: TWinControl
    read pm_GetFormDockSite;
   property PositionLocked: Boolean
    read pm_GetPositionLocked;
 end;//_ChromeLikeTabbedContainerForm_

{$Else NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}

_ChromeLikeTabbedContainerForm_ = _ChromeLikeTabbedContainerForm_Parent_;

{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
{$Else ChromeLikeTabbedContainerForm_imp}

{$IfNDef ChromeLikeTabbedContainerForm_imp_impl}

{$Define ChromeLikeTabbedContainerForm_imp_impl}

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
type
 THackApplication = class(TComponent)
  private
   FHandle: hWnd;
   FBiDiMode: TBiDiMode;
   FBiDiKeyboard: AnsiString;
   FNonBiDiKeyboard: AnsiString;
   FObjectInstance: Pointer;
   FMainForm: TForm;
   FMouseControl: TControl;
 end;//THackApplication

 THackCustomForm = {final} class(TCustomForm)
 end;//THackCustomForm

const
 cMinimalIntervalBetweenDockOperations = 300;
 cDockAfterShowingChangedInterval = 200;
 cDefaultTabsHeight = 25;

function _ChromeLikeTabbedContainerForm_.pm_GetTabSetParent: TWinControl;
//#UC START# *550A7FCB0021_550A7D5C01BCget_var*
//#UC END# *550A7FCB0021_550A7D5C01BCget_var*
begin
//#UC START# *550A7FCB0021_550A7D5C01BCget_impl*
 Result := DoGetTabSetParent;
//#UC END# *550A7FCB0021_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetTabSetParent

function _ChromeLikeTabbedContainerForm_.pm_GetFormDockSite: TWinControl;
//#UC START# *550A9811026A_550A7D5C01BCget_var*
//#UC END# *550A9811026A_550A7D5C01BCget_var*
begin
//#UC START# *550A9811026A_550A7D5C01BCget_impl*
 Result := DoGetFormDockSite;
//#UC END# *550A9811026A_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetFormDockSite

function _ChromeLikeTabbedContainerForm_.pm_GetPositionLocked: Boolean;
//#UC START# *552CEB4B00B5_550A7D5C01BCget_var*
//#UC END# *552CEB4B00B5_550A7D5C01BCget_var*
begin
//#UC START# *552CEB4B00B5_550A7D5C01BCget_impl*
 Result := f_PositionLockCount > 0;
//#UC END# *552CEB4B00B5_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetPositionLocked

procedure _ChromeLikeTabbedContainerForm_.DoOnTabSelected(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab);
//#UC START# *550A7E0F01BF_550A7D5C01BC_var*
//#UC END# *550A7E0F01BF_550A7D5C01BC_var*
begin
//#UC START# *550A7E0F01BF_550A7D5C01BC_impl*
 // Ничего не делаем
//#UC END# *550A7E0F01BF_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnTabSelected

procedure _ChromeLikeTabbedContainerForm_.DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab);
//#UC START# *550A7E2502F7_550A7D5C01BC_var*
//#UC END# *550A7E2502F7_550A7D5C01BC_var*
begin
//#UC START# *550A7E2502F7_550A7D5C01BC_impl*
 // Ничего не делаем
//#UC END# *550A7E2502F7_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnTabDeselected

procedure _ChromeLikeTabbedContainerForm_.DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
 const aRect: TRect;
 aCanvas: TCanvas;
 var aDefaultPainting: Boolean);
//#UC START# *550A7E46032C_550A7D5C01BC_var*
//#UC END# *550A7E46032C_550A7D5C01BC_var*
begin
//#UC START# *550A7E46032C_550A7D5C01BC_impl*
 // Ничего не делаем
//#UC END# *550A7E46032C_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnPaintTabSetBackground

procedure _ChromeLikeTabbedContainerForm_.DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
 aForm: TForm;
 var aCanUndock: Boolean);
//#UC START# *550A7E690247_550A7D5C01BC_var*
//#UC END# *550A7E690247_550A7D5C01BC_var*
begin
//#UC START# *550A7E690247_550A7D5C01BC_impl*
 aCanUndock := f_TabSet.TabCount > 1;
//#UC END# *550A7E690247_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnCanUndockFormEvent

procedure _ChromeLikeTabbedContainerForm_.DoOnAfterFormAdded(aTabSet: TChromeLikeTabSetControlPrim;
 aForm: TForm;
 aNeedSelect: Boolean);
//#UC START# *550A7E840108_550A7D5C01BC_var*
//#UC END# *550A7E840108_550A7D5C01BC_var*
begin
//#UC START# *550A7E840108_550A7D5C01BC_impl*
 if aNeedSelect then
  DisableOthers(aForm);
//#UC END# *550A7E840108_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnAfterFormAdded

procedure _ChromeLikeTabbedContainerForm_.DoOnCanDockForm(aTabSet: TChromeLikeTabSetControlPrim;
 aForm: TForm;
 aNeedSelect: Boolean;
 var aCanDock: Boolean);
//#UC START# *550A7E9701A5_550A7D5C01BC_var*
//#UC END# *550A7E9701A5_550A7D5C01BC_var*
begin
//#UC START# *550A7E9701A5_550A7D5C01BC_impl*
 aCanDock := f_TabSet.TabCount < 10;
//#UC END# *550A7E9701A5_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnCanDockForm

procedure _ChromeLikeTabbedContainerForm_.DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab;
 var aCanClose: Boolean;
 aNewSelectedTab: TChromeLikeTab);
//#UC START# *550A7EAB00D2_550A7D5C01BC_var*
//#UC END# *550A7EAB00D2_550A7D5C01BC_var*
begin
//#UC START# *550A7EAB00D2_550A7D5C01BC_impl*
 Assert(False);
//#UC END# *550A7EAB00D2_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnCloseTabForm

procedure _ChromeLikeTabbedContainerForm_.DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
 aPrevSelected: TChromeLikeTab;
 aNewSelected: TChromeLikeTab);
//#UC START# *550A7EC00274_550A7D5C01BC_var*
//#UC END# *550A7EC00274_550A7D5C01BC_var*
begin
//#UC START# *550A7EC00274_550A7D5C01BC_impl*
 // Ничего не делаем
//#UC END# *550A7EC00274_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnTabSetSelectionChanged

procedure _ChromeLikeTabbedContainerForm_.ActivateTabByIndex(aIndex: Integer);
//#UC START# *550A80D70372_550A7D5C01BC_var*
//#UC END# *550A80D70372_550A7D5C01BC_var*
begin
//#UC START# *550A80D70372_550A7D5C01BC_impl*
 f_TabSet.SelectedSlotIndex := aIndex;
//#UC END# *550A80D70372_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.ActivateTabByIndex

procedure _ChromeLikeTabbedContainerForm_.ActivateNextTab;
//#UC START# *550A810F0262_550A7D5C01BC_var*
//#UC END# *550A810F0262_550A7D5C01BC_var*
begin
//#UC START# *550A810F0262_550A7D5C01BC_impl*
 f_TabSet.SelectNext;
//#UC END# *550A810F0262_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.ActivateNextTab

procedure _ChromeLikeTabbedContainerForm_.ActivatePrevTab;
//#UC START# *550A8122032A_550A7D5C01BC_var*
//#UC END# *550A8122032A_550A7D5C01BC_var*
begin
//#UC START# *550A8122032A_550A7D5C01BC_impl*
 f_TabSet.SelectPrev;
//#UC END# *550A8122032A_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.ActivatePrevTab

procedure _ChromeLikeTabbedContainerForm_.InsertForm(aForm: TForm;
 const aTabParams: Il3TabParams = nil;
 aNeedSelect: Boolean = True;
 aInsertLast: Boolean = False;
 aInsertAfter: TForm = nil);
//#UC START# *550A813B0022_550A7D5C01BC_var*
var
 l_TabParams: Il3TabParams;
//#UC END# *550A813B0022_550A7D5C01BC_var*
begin
//#UC START# *550A813B0022_550A7D5C01BC_impl*
 l_TabParams := CheckFormTabParams(aForm, aTabParams);
 BeforeInsertForm(aForm);
 if (not aInsertLast) then
 begin
  if (aInsertAfter = nil) then
   InsertFormAfterSelected(aForm, l_TabParams, aNeedSelect)
  else
   InsertFormAfterSpecified(aForm, l_TabParams, aInsertAfter, aNeedSelect);
 end 
 else
  f_TabSet.DockForm(aForm, l_TabParams, aNeedSelect);
 AfterInsertForm(aForm, l_TabParams, aNeedSelect);
//#UC END# *550A813B0022_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.InsertForm

procedure _ChromeLikeTabbedContainerForm_.InsertForm(aForm: TForm;
 const aMousePoint: TPoint;
 const aTabParams: Il3TabParams = nil;
 aNeedSelect: Boolean = True);
//#UC START# *550A817F01CE_550A7D5C01BC_var*
var
 l_TabParams: Il3TabParams;
//#UC END# *550A817F01CE_550A7D5C01BC_var*
begin
//#UC START# *550A817F01CE_550A7D5C01BC_impl*
 l_TabParams := CheckFormTabParams(aForm, aTabParams);
 BeforeInsertForm(aForm);
 InsertFormAtPoint(aForm, l_TabParams, aMousePoint, aNeedSelect);
 AfterInsertForm(aForm, l_TabParams, aNeedSelect);
//#UC END# *550A817F01CE_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.InsertForm

procedure _ChromeLikeTabbedContainerForm_.CloseSelectedForm;
//#UC START# *550A81B40201_550A7D5C01BC_var*
//#UC END# *550A81B40201_550A7D5C01BC_var*
begin
//#UC START# *550A81B40201_550A7D5C01BC_impl*
 f_TabSet.CloseTab(f_TabSet.SelectedTab, True);
//#UC END# *550A81B40201_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CloseSelectedForm

procedure _ChromeLikeTabbedContainerForm_.SetSelected(aForm: TForm);
//#UC START# *550A81D3028A_550A7D5C01BC_var*
//#UC END# *550A81D3028A_550A7D5C01BC_var*
begin
//#UC START# *550A81D3028A_550A7D5C01BC_impl*
 f_TabSet.SelectedForm := aForm;
//#UC END# *550A81D3028A_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.SetSelected

procedure _ChromeLikeTabbedContainerForm_.RedrawTabSet;
//#UC START# *550A849402AD_550A7D5C01BC_var*
//#UC END# *550A849402AD_550A7D5C01BC_var*
begin
//#UC START# *550A849402AD_550A7D5C01BC_impl*
 f_TabSet.Invalidate;
//#UC END# *550A849402AD_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.RedrawTabSet

procedure _ChromeLikeTabbedContainerForm_.BeforeInsertForm(aForm: TForm);
//#UC START# *550A84AA0114_550A7D5C01BC_var*
//#UC END# *550A84AA0114_550A7D5C01BC_var*
begin
//#UC START# *550A84AA0114_550A7D5C01BC_impl*
 Assert(aForm <> nil);
 Assert(not (csDestroying in aForm.ComponentState));

// Decorator.BeginUpdate;

 with aForm.Constraints do
 begin
  MaxHeight := 0;
  MaxWidth := 0;
  MinHeight := 0;
  MinWidth := 0;
 end;//with aForm.Constraints
//#UC END# *550A84AA0114_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.BeforeInsertForm

procedure _ChromeLikeTabbedContainerForm_.AfterInsertForm(aForm: TForm;
 const aParams: Il3TabParams;
 aNeedSelect: Boolean);
//#UC START# *550A84C1035F_550A7D5C01BC_var*
//#UC END# *550A84C1035F_550A7D5C01BC_var*
begin
//#UC START# *550A84C1035F_550A7D5C01BC_impl*
 f_LastDockOperationTickCount := GetTickCount;
//#UC END# *550A84C1035F_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.AfterInsertForm

procedure _ChromeLikeTabbedContainerForm_.InsertFormAfterSelected(aForm: TForm;
 const aParams: Il3TabParams;
 aNeedSelect: Boolean);
//#UC START# *550A850801D5_550A7D5C01BC_var*
//#UC END# *550A850801D5_550A7D5C01BC_var*
begin
//#UC START# *550A850801D5_550A7D5C01BC_impl*
 f_TabSet.DockFormAfterSelected(aForm, CheckFormTabParams(aForm, aParams), aNeedSelect);
//#UC END# *550A850801D5_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.InsertFormAfterSelected

procedure _ChromeLikeTabbedContainerForm_.InsertFormAtPoint(aForm: TForm;
 const aParams: Il3TabParams;
 const aPoint: TPoint;
 aNeedSelect: Boolean);
//#UC START# *550A85200145_550A7D5C01BC_var*
//#UC END# *550A85200145_550A7D5C01BC_var*
begin
//#UC START# *550A85200145_550A7D5C01BC_impl*
 f_TabSet.DockFormAtPoint(aForm, CheckFormTabParams(aForm, aParams), aPoint, aNeedSelect);
//#UC END# *550A85200145_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.InsertFormAtPoint

function _ChromeLikeTabbedContainerForm_.GetTabsHeight: Integer;
//#UC START# *550A870B008D_550A7D5C01BC_var*
//#UC END# *550A870B008D_550A7D5C01BC_var*
begin
//#UC START# *550A870B008D_550A7D5C01BC_impl*
 Result := 21;
//#UC END# *550A870B008D_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.GetTabsHeight

procedure _ChromeLikeTabbedContainerForm_.MakeTabSet;
//#UC START# *550A873B0298_550A7D5C01BC_var*
//#UC END# *550A873B0298_550A7D5C01BC_var*
begin
//#UC START# *550A873B0298_550A7D5C01BC_impl*
 f_TabSet := TChromeLikeTabSetControl.Create(Self, Self as Il3TabbedContainer);
 with f_TabSet do
 begin
  OnPaintBackground := DoOnPaintTabSetBackground;
  OnAfterFormAdded := DoOnAfterFormAdded;
  OnCanDockForm := DoOnCanDockForm;
  OnCanUndockTabForm := DoOnCanUndockFormEvent;
  OnSelectionChanged := DoOnTabSetSelectionChanged;
  OnTabSelected := DoOnTabSelected;
  OnTabDeselected := DoOnTabDeselected;
  OnCloseTabForm := DoOnCloseTabForm;
  OnAfterFormAdded := DoOnAfterFormAdded;
  OnNewTabRequested := DoOnNewTabRequested;
  Height := 25;
  TabHeight := 25;
  SetParams(MakeTabSetParams);
 end;
// Decorator.ClientControl := f_TabSet;
// pnlMain.Align := alClient;
//#UC END# *550A873B0298_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.MakeTabSet

function _ChromeLikeTabbedContainerForm_.CanDockToAnother(const aPoint: TPoint): Boolean;
//#UC START# *550A877701F5_550A7D5C01BC_var*
var
 l_HitTestResult: TChromeLikeTabSetHitTestResult;
//#UC END# *550A877701F5_550A7D5C01BC_var*
begin
//#UC START# *550A877701F5_550A7D5C01BC_impl*
 Result := (aPoint.Y <> f_LastMovingPoint.Y) or (aPoint.X <> f_LastMovingPoint.Y);
 if Result then
 begin
  l_HitTestResult := f_TabSet.HitTest(aPoint);

  Result := (f_TabSet.TabCount = 1) AND
            (l_HitTestResult = htrInTab) AND
            ((GetTickCount - f_ShowingChangedTickCount) > cDockAfterShowingChangedInterval);
 end;
//#UC END# *550A877701F5_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CanDockToAnother

procedure _ChromeLikeTabbedContainerForm_.UpdateContainedFormsActions;
//#UC START# *550A98F20312_550A7D5C01BC_var*

 procedure lp_UpdateActions(aControl: TWinControl);
 var
  l_Form: THackCustomForm;
  l_Index: Integer;
 begin
  if (aControl is TCustomForm) then
  begin
   l_Form := THackCustomForm(aControl);
   l_Form.UpdateActions;
  end;
  for l_Index := 0 to Pred(aControl.ControlCount) do
   if (aControl.Controls[l_Index] is TWinControl) then
    lp_UpdateActions(TWinControl(aControl.Controls[l_Index]));
 end;//lp_UpdateActions

var
 l_Index: Integer;
//#UC END# *550A98F20312_550A7D5C01BC_var*
begin
//#UC START# *550A98F20312_550A7D5C01BC_impl*
 for l_Index := 0 to Pred(f_TabSet.TabCount) do
  lp_UpdateActions(f_TabSet.Tabs[l_Index].Form);
//#UC END# *550A98F20312_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.UpdateContainedFormsActions

procedure _ChromeLikeTabbedContainerForm_.ResetMouseControl;
//#UC START# *550A98FD01E9_550A7D5C01BC_var*
//#UC END# *550A98FD01E9_550A7D5C01BC_var*
begin
//#UC START# *550A98FD01E9_550A7D5C01BC_impl*
 THackApplication(Application).FMouseControl := nil;
//#UC END# *550A98FD01E9_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.ResetMouseControl

function _ChromeLikeTabbedContainerForm_.DoGetFormDockSite: TWinControl;
//#UC START# *550AAF6F03A1_550A7D5C01BC_var*
//#UC END# *550AAF6F03A1_550A7D5C01BC_var*
begin
//#UC START# *550AAF6F03A1_550A7D5C01BC_impl*
 Result := nil;
//#UC END# *550AAF6F03A1_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoGetFormDockSite

function _ChromeLikeTabbedContainerForm_.IsDockOperationPossible: Boolean;
//#UC START# *550BBFAA0295_550A7D5C01BC_var*
//#UC END# *550BBFAA0295_550A7D5C01BC_var*
begin
//#UC START# *550BBFAA0295_550A7D5C01BC_impl*
 Result := ((GetTickCount - f_LastDockOperationTickCount) > cMinimalIntervalBetweenDockOperations) and
  (not (fsShowing in FFormState));
//#UC END# *550BBFAA0295_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.IsDockOperationPossible

procedure _ChromeLikeTabbedContainerForm_.DisableOthers(aSelectedForm: TForm);
//#UC START# *5510075F02EA_550A7D5C01BC_var*
var
 l_Form: TForm;
 l_Index: Integer;
//#UC END# *5510075F02EA_550A7D5C01BC_var*
begin
//#UC START# *5510075F02EA_550A7D5C01BC_impl*
 for l_Index := 0 to Pred(f_TabSet.TabCount) do
 begin
  l_Form := f_TabSet.Tabs[l_Index].Form;
  if (l_Form <> aSelectedForm) then
  begin
   l_Form.Visible := False;
   l_Form.SendToBack;
   l_Form.Enabled := False;
  end;
 end;
 aSelectedForm.Enabled := True;
 if (not aSelectedForm.Visible) and Visible and Showing then
  aSelectedForm.Show;
 aSelectedForm.BringToFront;
//#UC END# *5510075F02EA_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DisableOthers

procedure _ChromeLikeTabbedContainerForm_.RemoveForm(aForm: TForm;
 aNoClose: Boolean = True);
//#UC START# *551138EC01AA_550A7D5C01BC_var*
var
 l_Tab: TChromeLikeTab;
//#UC END# *551138EC01AA_550A7D5C01BC_var*
begin
//#UC START# *551138EC01AA_550A7D5C01BC_impl*
 l_Tab := f_TabSet.FormTabs[aForm];
 f_TabSet.RemoveTab(l_Tab);
 aForm.Enabled := True;
 f_LastDockOperationTickCount := GetTickCount;
 if (not aNoClose) and (f_TabSet.TabCount = 0) then
  SafeClose;
//#UC END# *551138EC01AA_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.RemoveForm

function _ChromeLikeTabbedContainerForm_.CheckFormTabParams(aForm: TForm;
 const aParams: Il3TabParams): Il3TabParams;
//#UC START# *55128BE1012F_550A7D5C01BC_var*
//#UC END# *55128BE1012F_550A7D5C01BC_var*
begin
//#UC START# *55128BE1012F_550A7D5C01BC_impl*
 Result := aParams; 
//#UC END# *55128BE1012F_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CheckFormTabParams

function _ChromeLikeTabbedContainerForm_.MakeTabSetParams: TChromeLikeTabSetParams;
//#UC START# *5518E1700367_550A7D5C01BC_var*
//#UC END# *5518E1700367_550A7D5C01BC_var*
begin
//#UC START# *5518E1700367_550A7D5C01BC_impl*
 Assert(False);
//#UC END# *5518E1700367_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.MakeTabSetParams

procedure _ChromeLikeTabbedContainerForm_.DoOpenNewTab(aOpenLast: Boolean);
//#UC START# *5566D7A300E6_550A7D5C01BC_var*
//#UC END# *5566D7A300E6_550A7D5C01BC_var*
begin
//#UC START# *5566D7A300E6_550A7D5C01BC_impl*
 Assert(False);
//#UC END# *5566D7A300E6_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOpenNewTab

procedure _ChromeLikeTabbedContainerForm_.DoOnNewTabRequested(aTabSet: TChromeLikeTabSetControlPrim;
 aOpenLast: Boolean);
//#UC START# *558119BD02BE_550A7D5C01BC_var*
//#UC END# *558119BD02BE_550A7D5C01BC_var*
begin
//#UC START# *558119BD02BE_550A7D5C01BC_impl*
 OpenNewTab;
//#UC END# *558119BD02BE_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoOnNewTabRequested

function _ChromeLikeTabbedContainerForm_.DoGetCanOpenNewTab: Boolean;
//#UC START# *55B5F22B0315_550A7D5C01BC_var*
//#UC END# *55B5F22B0315_550A7D5C01BC_var*
begin
//#UC START# *55B5F22B0315_550A7D5C01BC_impl*
 Result := DoGetCanOpenNewTab;
//#UC END# *55B5F22B0315_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoGetCanOpenNewTab

procedure _ChromeLikeTabbedContainerForm_.InsertFormAfterSpecified(aForm: TForm;
 const aParams: Il3TabParams;
 aInsertAfter: TForm;
 aNeedSelect: Boolean);
//#UC START# *55CB09250081_550A7D5C01BC_var*
//#UC END# *55CB09250081_550A7D5C01BC_var*
begin
//#UC START# *55CB09250081_550A7D5C01BC_impl*
 TabSet.DockFormAfterSpecified(aForm, aParams, aInsertAfter, aNeedSelect);
//#UC END# *55CB09250081_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.InsertFormAfterSpecified

procedure _ChromeLikeTabbedContainerForm_.DoUpdateCaption;
//#UC START# *55FFECF00390_550A7D5C01BC_var*
//#UC END# *55FFECF00390_550A7D5C01BC_var*
begin
//#UC START# *55FFECF00390_550A7D5C01BC_impl*
 // Ничего не делаем
//#UC END# *55FFECF00390_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DoUpdateCaption

procedure _ChromeLikeTabbedContainerForm_.WMMove(var aMessage: TMessage);
//#UC START# *550A82B90140_550A7D5C01BC_var*
var
 l_Pt: TPoint;
//#UC END# *550A82B90140_550A7D5C01BC_var*
begin
//#UC START# *550A82B90140_550A7D5C01BC_impl*
 inherited;
 Application.CancelHint;
 if (f_TabSet <> nil) AND
  (not (csLoading in ComponentState)) AND
  (not (csDestroying in ComponentState)) AND
  (GetAsyncKeyState(VK_LBUTTON) < 0) then
 begin
  Windows.GetCursorPos(l_Pt);
  if CanDockToAnother(l_Pt) then
   DockToAnother(l_Pt, f_TabSet.Tabs[0].Form);
 end;
 f_LastMovingPoint := l_Pt;
//#UC END# *550A82B90140_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.WMMove

function _ChromeLikeTabbedContainerForm_.DockForm(aForm: TForm;
 aNeedShow: Boolean): Boolean;
//#UC START# *5500204D0269_550A7D5C01BC_var*
//#UC END# *5500204D0269_550A7D5C01BC_var*
begin
//#UC START# *5500204D0269_550A7D5C01BC_impl*
 aForm.Visible := False;
 ResetMouseControl;
 aForm.Left := High(SmallInt) - aForm.Width;
 Result := aForm.ManualDock(FormDockSite, nil, alClient);
 aForm.BoundsRect := Rect(0, 0, FormDockSite.Width, FormDockSite.Height);
 ResetMouseControl;
 aForm.Align := alClient;
 if aNeedShow then
 begin
  aForm.Visible := True;
  aForm.BringToFront;
 end;
//#UC END# *5500204D0269_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DockForm

function _ChromeLikeTabbedContainerForm_.UndockForm(aForm: TForm): Boolean;
//#UC START# *5500205C0308_550A7D5C01BC_var*
//#UC END# *5500205C0308_550A7D5C01BC_var*
begin
//#UC START# *5500205C0308_550A7D5C01BC_impl*
 with aForm do
 begin
  ResetMouseControl;
  Visible := False;
  Align := alNone;
  ManualFloat(aForm.BoundsRect);
  ResetMouseControl;
 end;
//#UC END# *5500205C0308_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.UndockForm

function _ChromeLikeTabbedContainerForm_.MakeFormParams(aForm: TForm): Il3TabParams;
//#UC START# *550020700383_550A7D5C01BC_var*
//#UC END# *550020700383_550A7D5C01BC_var*
begin
//#UC START# *550020700383_550A7D5C01BC_impl*
 Result := nil;
//#UC END# *550020700383_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.MakeFormParams

function _ChromeLikeTabbedContainerForm_.MakeClone: Il3TabbedContainer;
//#UC START# *5500208201D7_550A7D5C01BC_var*
//#UC END# *5500208201D7_550A7D5C01BC_var*
begin
//#UC START# *5500208201D7_550A7D5C01BC_impl*
 Result := DoMakeClone;
//#UC END# *5500208201D7_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.MakeClone

procedure _ChromeLikeTabbedContainerForm_.MakeVisible(const aTopLeftPosition: TPoint);
//#UC START# *55003806026E_550A7D5C01BC_var*
//#UC END# *55003806026E_550A7D5C01BC_var*
begin
//#UC START# *55003806026E_550A7D5C01BC_impl*
 Left := aTopLeftPosition.X;
 Top := aTopLeftPosition.Y;
 Show;
//#UC END# *55003806026E_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.MakeVisible

procedure _ChromeLikeTabbedContainerForm_.DockForeignForm(aForm: TForm;
 const aTabParams: Il3TabParams);
//#UC START# *550685560112_550A7D5C01BC_var*
//#UC END# *550685560112_550A7D5C01BC_var*
begin
//#UC START# *550685560112_550A7D5C01BC_impl*
 InsertForm(aForm, aTabParams);
 afw.ProcessMessages;
//#UC END# *550685560112_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.DockForeignForm

procedure _ChromeLikeTabbedContainerForm_.LockPosition;
//#UC START# *552CEB1F00F0_550A7D5C01BC_var*
//#UC END# *552CEB1F00F0_550A7D5C01BC_var*
begin
//#UC START# *552CEB1F00F0_550A7D5C01BC_impl*
 Inc(f_PositionLockCount);
//#UC END# *552CEB1F00F0_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.LockPosition

procedure _ChromeLikeTabbedContainerForm_.UnlockPosition;
//#UC START# *552CEB2700ED_550A7D5C01BC_var*
//#UC END# *552CEB2700ED_550A7D5C01BC_var*
begin
//#UC START# *552CEB2700ED_550A7D5C01BC_impl*
 Dec(f_PositionLockCount);
//#UC END# *552CEB2700ED_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.UnlockPosition

function _ChromeLikeTabbedContainerForm_.pm_GetAsForm: TForm;
//#UC START# *5568358501A0_550A7D5C01BCget_var*
//#UC END# *5568358501A0_550A7D5C01BCget_var*
begin
//#UC START# *5568358501A0_550A7D5C01BCget_impl*
 Result := Self;
//#UC END# *5568358501A0_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetAsForm

function _ChromeLikeTabbedContainerForm_.GetFormTab(aForm: TForm): Il3FormTab;
//#UC START# *558BD3AD01A5_550A7D5C01BC_var*
//#UC END# *558BD3AD01A5_550A7D5C01BC_var*
begin
//#UC START# *558BD3AD01A5_550A7D5C01BC_impl*
 Result := f_TabSet.GetFormTab(aForm);
//#UC END# *558BD3AD01A5_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.GetFormTab

function _ChromeLikeTabbedContainerForm_.pm_GetTabs(Index: Integer): Il3FormTab;
//#UC START# *55B5D8F00327_550A7D5C01BCget_var*
//#UC END# *55B5D8F00327_550A7D5C01BCget_var*
begin
//#UC START# *55B5D8F00327_550A7D5C01BCget_impl*
 Result := f_TabSet.Tabs[Index] as Il3FormTab;
//#UC END# *55B5D8F00327_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetTabs

function _ChromeLikeTabbedContainerForm_.pm_GetTabCount: Integer;
//#UC START# *55B5D9330329_550A7D5C01BCget_var*
//#UC END# *55B5D9330329_550A7D5C01BCget_var*
begin
//#UC START# *55B5D9330329_550A7D5C01BCget_impl*
 Result := f_TabSet.TabCount;
//#UC END# *55B5D9330329_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetTabCount

function _ChromeLikeTabbedContainerForm_.pm_GetActiveTab: Il3FormTab;
//#UC START# *55B5D9750166_550A7D5C01BCget_var*
//#UC END# *55B5D9750166_550A7D5C01BCget_var*
begin
//#UC START# *55B5D9750166_550A7D5C01BCget_impl*
 if (f_TabSet.SelectedTab <> nil) then
  Result := f_TabSet.SelectedTab as Il3FormTab
 else
  Result := nil;
//#UC END# *55B5D9750166_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetActiveTab

procedure _ChromeLikeTabbedContainerForm_.pm_SetActiveTab(const aValue: Il3FormTab);
//#UC START# *55B5D9750166_550A7D5C01BCset_var*
//#UC END# *55B5D9750166_550A7D5C01BCset_var*
begin
//#UC START# *55B5D9750166_550A7D5C01BCset_impl*
 f_TabSet.SelectedTab := f_TabSet.Tabs[aValue.VisibleIndex];
//#UC END# *55B5D9750166_550A7D5C01BCset_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_SetActiveTab

procedure _ChromeLikeTabbedContainerForm_.CloseAllButActiveTab;
//#UC START# *55B5D9AC03D5_550A7D5C01BC_var*
//#UC END# *55B5D9AC03D5_550A7D5C01BC_var*
begin
//#UC START# *55B5D9AC03D5_550A7D5C01BC_impl*
 f_TabSet.CloseAllExceptOne(f_TabSet.SelectedTab);
//#UC END# *55B5D9AC03D5_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CloseAllButActiveTab

procedure _ChromeLikeTabbedContainerForm_.OpenNewTab(aOpenLast: Boolean = True);
//#UC START# *55B5DA3B02AC_550A7D5C01BC_var*
//#UC END# *55B5DA3B02AC_550A7D5C01BC_var*
begin
//#UC START# *55B5DA3B02AC_550A7D5C01BC_impl*
 DoOpenNewTab;
//#UC END# *55B5DA3B02AC_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.OpenNewTab

function _ChromeLikeTabbedContainerForm_.pm_GetCanOpenNewTab: Boolean;
//#UC START# *55B5E26901DB_550A7D5C01BCget_var*
//#UC END# *55B5E26901DB_550A7D5C01BCget_var*
begin
//#UC START# *55B5E26901DB_550A7D5C01BCget_impl*
 Result := DoGetCanOpenNewTab;
//#UC END# *55B5E26901DB_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.pm_GetCanOpenNewTab

procedure _ChromeLikeTabbedContainerForm_.CloseSelectedTab;
//#UC START# *55B60AA90117_550A7D5C01BC_var*
//#UC END# *55B60AA90117_550A7D5C01BC_var*
begin
//#UC START# *55B60AA90117_550A7D5C01BC_impl*
 f_TabSet.CloseTab(f_TabSet.SelectedTab);
//#UC END# *55B60AA90117_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CloseSelectedTab

procedure _ChromeLikeTabbedContainerForm_.CloseTab(const aTab: Il3FormTab);
//#UC START# *55B6104A00A6_550A7D5C01BC_var*
//#UC END# *55B6104A00A6_550A7D5C01BC_var*
begin
//#UC START# *55B6104A00A6_550A7D5C01BC_impl*
 f_TabSet.CloseTab(f_TabSet.Tabs[aTab.VisibleIndex]);
//#UC END# *55B6104A00A6_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CloseTab

procedure _ChromeLikeTabbedContainerForm_.UpdateCaption;
//#UC START# *55FFE5140379_550A7D5C01BC_var*
//#UC END# *55FFE5140379_550A7D5C01BC_var*
begin
//#UC START# *55FFE5140379_550A7D5C01BC_impl*
 DoUpdateCaption;
//#UC END# *55FFE5140379_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.UpdateCaption

function _ChromeLikeTabbedContainerForm_.Get_TabByVisibleIndex(Index: Integer): Il3FormTab;
//#UC START# *569611530032_550A7D5C01BCget_var*
var
 I: Integer;
//#UC END# *569611530032_550A7D5C01BCget_var*
begin
//#UC START# *569611530032_550A7D5C01BCget_impl*
 for I := 0 to f_TabSet.TabCount - 1 do
 begin
  Result := f_TabSet.Tabs[I] as Il3FormTab;
  if Result.VisibleIndex = Index then
   Exit;
 end;
 Result := nil;
//#UC END# *569611530032_550A7D5C01BCget_impl*
end;//_ChromeLikeTabbedContainerForm_.Get_TabByVisibleIndex

function _ChromeLikeTabbedContainerForm_.CanUndockFormFromTab(aTabIndex: Integer): Boolean;
//#UC START# *56990DDF014B_550A7D5C01BC_var*
//#UC END# *56990DDF014B_550A7D5C01BC_var*
begin
//#UC START# *56990DDF014B_550A7D5C01BC_impl*
 DoOnCanUndockFormEvent(TabSet, Il3FormTab(TabSet.Tabs[aTabIndex]).TabbedForm, Result);
//#UC END# *56990DDF014B_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.CanUndockFormFromTab

procedure _ChromeLikeTabbedContainerForm_.UndockFormFromTab(aTabIndex: Integer);
//#UC START# *56990E360344_550A7D5C01BC_var*
//#UC END# *56990E360344_550A7D5C01BC_var*
begin
//#UC START# *56990E360344_550A7D5C01BC_impl*
 TabSet.UndockTabbedForm(TabSet.Tabs[aTabIndex]);
//#UC END# *56990E360344_550A7D5C01BC_impl*
end;//_ChromeLikeTabbedContainerForm_.UndockFormFromTab
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

{$EndIf ChromeLikeTabbedContainerForm_imp_impl}

{$EndIf ChromeLikeTabbedContainerForm_imp}

