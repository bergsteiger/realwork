unit vcmTabbedContainerForm;

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  afwInterfaces,
  vcmExternalInterfaces,
  vcmInterfaces,
  Types,
  Messages,
  l3Bitmap,
  Graphics,
  Forms,
  Menus,
  l3TabbedContainersDispatcher,
  vcmEntityForm,
  vcmChromeLikeTabbedContainerForm,
  vcmChromeLikeTypes,
  ChromeLikeInterfaces,
  vcmMainMenuStripForChromeLike,
  vcmMessages,
  Controls,
  Classes,
  ChromeLikeTabSetControlPrim,
  ChromeLikeTabSetControl,
  vtPanel, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwTextControlPrim, afwTextControl, StdCtrls, ExtCtrls,
  vcmFormSetHistory
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}
type
 _vcmComponentDestroyer_Parent_ = TvcmChromeLikeTabbedContainerForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmComponentDestroyer.imp.pas}
 TvcmTabbedContainerForm = class(_vcmComponentDestroyer_ {$If defined(Nemesis) AND not defined(NoVCM)}, IvcmFlashingWindow{$IfEnd} //Nemesis AND not NoVCM
 , IafwMainFormContainer, IvcmMenuHolder)
   PnlMain: TvtPanel;
 private
 // private fields
   f_Flashing : Boolean;
   f_Menu : TvcmMainMenuStripForChromeLike;
   f_CurrentMainMenu : TMainMenu;
   f_BackgroundBitmap : Tl3Bitmap;
   f_ContainerIsClosing : Boolean;
    {* Поле для свойства ContainerIsClosing}
   f_WindowStateBeforeMinimizing : TWindowState;
    {* Поле для свойства WindowStateBeforeMinimizing}
   f_DisableLoadFromSettings: Boolean;
   f_FormSetHistory: IvcmFormSetHistory;
 private
 // private methods
   procedure DecoratorBackgroundChanged(aBitmap: Graphics.TBitmap;
     aNeedDrawBackground: Boolean);
   procedure UpdateContainedFormsActions;
     {* Сигнатура метода UpdateContainedFormsActions }
   procedure DisableOthers(aSelectedForm: TForm);
   procedure UpdateContainerCaption;
     {* Сигнатура метода UpdateContainerCaption }
   procedure SetFocusToSelectedForm;
     {* Сигнатура метода SetFocusToSelectedForm }
   procedure DoGiveFocusToContainedForm;
     {* Сигнатура метода DoGiveFocusToContainedForm }
   procedure LoadSettings;
   procedure NotifyComponentsMainFormChanged(aForm: TvcmEntityForm);
   procedure NotifyComponentsSelectionChanged(aNewSelectedForm: TvcmEntityForm);
   procedure NotifyContainedFormsOnClosing;
   procedure WMClose(var aMessage: TWMClose); message WM_CLOSE;
   procedure WMEnable(var aMessage: TWMEnable); message WM_ENABLE;
   procedure WMCopyData(var aMessage: TWMCopyData); message WM_COPYDATA;
   procedure WMWindowPosChanged(var aMessage: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
   procedure WMWindowPosChanging(var aMessage: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
   procedure WMSetFocus(var aMessage: TWMSetFocus); message WM_SETFOCUS;
   procedure WMSysCommand(var aMessage: TWMSysCommand); message WM_SYSCOMMAND;
   procedure WMActivate(var aMessage: TWMActivate); message WM_ACTIVATE;
   procedure CMShowingChanged(var aMessage: TMessage); message CM_SHOWINGCHANGED;
   procedure CMVisibleChanged(var aMessage: TMessage); message CM_VISIBLECHANGED;
   procedure vcmMsgCloseForm(var Message: TMessage); message vcm_msgCloseForm;
   procedure VcmTabbedContainerCloseQuery(Sender: TObject;
    var CanClose: Boolean);
 protected
 // property methods
   function pm_GetFormCount: Integer;
   function pm_GetForms(Index: Integer): TvcmEntityForm; virtual;
 protected
 // realized methods
    {$If defined(Nemesis) AND not defined(NoVCM)}
   procedure StartFlashing;
    {$IfEnd} //Nemesis AND not NoVCM
    {$If defined(Nemesis) AND not defined(NoVCM)}
   procedure StopFlashing;
    {$IfEnd} //Nemesis AND not NoVCM
   function Get_CurrentMainForm: TafwCustomForm;
   procedure UpdateFormCaption(aForm: TafwCustomForm);
   function Get_MainMenu: TMenuItem;
   function DoGetTabSetParent: TWinControl; override;
   function DoMakeClone: Il3TabbedContainer; override;
   procedure DockToAnother(const aMousePoint: TPoint;
     aForm: TForm); override;
   function DoGetCanOpenNewTab: Boolean; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure CreateParams(var Params: TCreateParams); override;
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure MakeControls; override;
   function GetClientControl: TWinControl; override;
   procedure DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
     aTab: TChromeLikeTab); override;
   procedure DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
     const aRect: TRect;
     aCanvas: TCanvas;
     var aDefaultPainting: Boolean); override;
   procedure DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
     aForm: TForm;
     var aCanUndock: Boolean); override;
   procedure DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
     aPrevSelected: TChromeLikeTab;
     aNewSelected: TChromeLikeTab); override;
   procedure DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
     aTab: TChromeLikeTab;
     var aCanClose: Boolean;
     aNewSelectedTab: TChromeLikeTab); override;
   procedure AfterInsertForm(aForm: TForm;
     const aParams: Il3TabParams;
     aNeedSelect: Boolean); override;
   procedure MakeTabSet; override;
   function MakeTabSetParams: TChromeLikeTabSetParams; override;
   function CanDockToAnother(const aPoint: TPoint): Boolean; override;
   function DoGetFormDockSite: TWinControl; override;
   function CheckFormTabParams(aForm: TForm; const aParams: Il3TabParams): Il3TabParams; override;
   procedure BeforeClosing; override;
   procedure ReleaseResources; override;
   procedure DoOpenNewTab; override;
   procedure DoUpdateCaption; override;
 public
 // overridden public methods
   {$If defined(l3HackedVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} //l3HackedVCL
   constructor Create(AOwner: TComponent; aNeedLoadFromSettings: Boolean = True); reintroduce; overload;
 public
 // public methods
   class function Make(aNeedLoadFromSettings: Boolean = True): TvcmTabbedContainerForm;
   class function MakeWithChild(aChild: TForm;
     const aTabParams: Il3TabParams = nil;
     aNeedLoadFromSettings: Boolean = True): TvcmTabbedContainerForm;
   procedure ResetClosing;
     {* Сигнатура метода ResetClosing }
   procedure UpdateMenu(aFormWithMenu: TForm = nil);
   procedure EnableRemindersActivity;
     {* Сигнатура метода EnableRemindersActivity }
   procedure DisableRemindersActivity;
     {* Сигнатура метода DisableRemindersActivity }
   function CanBeDocked(const aPoint: TPoint;
     aForm: TForm): Boolean;
   function GetInnerEntityForm: IvcmEntityForm;
   procedure NotifyNeedRefreshFormTab(aForm: TvcmEntityForm;
    aIconIndex: Integer);
   function MakeFormTabParams(aForm: TvcmEntityForm): Il3TabParams;
   procedure UpdateTabCaption(aForm: TafwCustomForm);
   procedure UpdateTabIcon(aForm: TvcmEntityForm; aIconIndex: Integer);
   procedure AddNewTab;
 public
 // public properties
   property ContainerIsClosing: Boolean
     read f_ContainerIsClosing;
   property FormCount: Integer
     read pm_GetFormCount;
   property Forms[Index: Integer]: TvcmEntityForm
     read pm_GetForms;
   property WindowStateBeforeMinimizing: TWindowState
     read f_WindowStateBeforeMinimizing;
   property FormSetHistory: IvcmFormSetHistory
     read f_FormSetHistory;
 end;//TvcmTabbedContainerForm
{$IfEnd} //not NoVCM AND not NoVGScene

implementation

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base,
  l3String,
  l3DwmApi,
  afwFacade,
  vcmTabbedContainerFormDispatcher,
  vcmTabbedContainerRes,
  ChromeLikeTabParams,
  vgRemindersLineManager,
  Windows,
  vcmMenuManager,
  vcmFormsUtils,
  vcmSettings,
  SysUtils,
  vcmForm,
  ChromeLikeTabSetTypes,
  ChromeLikeTabSetRes
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}

type _Instance_R_ = TvcmTabbedContainerForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmComponentDestroyer.imp.pas}

{$R *.dfm}

// start class TvcmTabbedContainerForm

procedure TvcmTabbedContainerForm.DecoratorBackgroundChanged(aBitmap: Graphics.TBitmap;
  aNeedDrawBackground: Boolean);
var
 l_SrcRect: TRect;
 l_DestRect: TRect;
begin
 l_SrcRect := Rect(0, 0, aBitmap.Width, aBitmap.Height);
 l_DestRect := l_SrcRect;
 f_BackgroundBitmap.Width := TabSet.ClientWidth;
 f_BackgroundBitmap.Height := TabSet.ClientHeight;
 if aNeedDrawBackground then
 begin
  f_BackgroundBitmap.Canvas.CopyRect(l_DestRect, aBitmap.Canvas, l_SrcRect);
  TabSet.Invalidate;
 end;
end;//TvcmTabbedContainerForm.DecoratorBackgroundChanged

type
 THackCustomForm = class(TCustomForm);

procedure TvcmTabbedContainerForm.UpdateContainedFormsActions;

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
begin
 for l_Index := 0 to Pred(TabSet.TabCount) do
  lp_UpdateActions(TabSet.Tabs[l_Index].Form);
end;//TvcmTabbedContainerForm.UpdateContainedFormsActions

procedure TvcmTabbedContainerForm.DisableOthers(aSelectedForm: TForm);
var
 l_Form: TForm;
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(TabSet.TabCount) do
 begin
  l_Form := TabSet.Tabs[l_Index].Form;
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
end;//TvcmTabbedContainerForm.DisableOthers

procedure TvcmTabbedContainerForm.UpdateContainerCaption;
var
 l_CurrentTabText: String;
 l_CurrentTabHint: String;
begin
 if (TabSet.SelectedTab <> nil) then
 begin
  // 1. В заголовке вкладки отображается короткое название (типа, "Список документов).
  // 2. Такое же название должно быть в таскбаре и меню Alt+Tab.
  // 3. Хинт вкладки остается полным(типа, "Список: <название списка>").
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=565271368
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=564736847
  l_CurrentTabText := TabSet.SelectedTab.Text;
  l_CurrentTabHint := TabSet.SelectedTab.HintText;
  CCaption := l3CStr(l_CurrentTabText);
  Application.Title := l_CurrentTabText;
  Application.Hint := l_CurrentTabHint;
  TvcmTabbedContainerFormDispatcher.Instance.ContainerChanged(Self);
 end;
end;//TvcmTabbedContainerForm.UpdateContainerCaption

procedure TvcmTabbedContainerForm.SetFocusToSelectedForm;
var
 l_SelectedForm: TCustomForm;
 l_Container: IvcmContainedForm;
begin
 l_SelectedForm := TabSet.SelectedForm;
 Assert(l_SelectedForm <> nil);
 if Supports(l_SelectedForm, IvcmContainedForm, l_Container) then
 try
  l_Container.RestoreFocusedControl;
 finally
  l_Container := nil;
 end;
end;//TvcmTabbedContainerForm.SetFocusToSelectedForm

procedure TvcmTabbedContainerForm.DoGiveFocusToContainedForm;
var
 l_Container: IvcmContainer;
begin
 if Supports(TabSet.SelectedForm, IvcmContainer, l_Container) then
 try
  l_Container.SetFocusToMainObjectForm;
 finally
  l_Container := nil;
 end;//try..finally
end;//TvcmTabbedContainerForm.DoGiveFocusToContainedForm

procedure TvcmTabbedContainerForm.LoadSettings;
const
 cMaximized: TvcmPathPair = (rName: 'Maximized');
var
 l_Path: TvcmPathPairs;
 l_PPath: TvcmPathPairs;
 l_Maximized: Boolean;
 l_SettingExists: Boolean;
begin
 if (not f_DisableLoadFromSettings) then
 begin
  l_Maximized := False;
  vcmGetFormPath(Self, l_Path);
  vcmCatPath(l_Path, cMaximized, l_PPath);
  if not vcmLoadBoolParam(l_PPath, l_Maximized) then
   WindowState := wsMaximized;
 end;
end;

procedure TvcmTabbedContainerForm.VcmTabbedContainerCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := TvcmTabbedContainerFormDispatcher.Instance.CallContainerCloseQuery(Self);
 if CanClose then
  NotifyContainedFormsOnClosing;
end;//TvcmTabbedContainerForm.VcmTabbedContainerCloseQuery

procedure TvcmTabbedContainerForm.NotifyComponentsMainFormChanged(aForm: TvcmEntityForm);

 procedure lp_NotifyComponent(const aComponent: TComponent);

  procedure lp_DoNotifyComponent(const aSubjectComponent: TComponent);
  var
   l_MainFormDependent: IvcmMainFormDependent;
  begin
   Assert(aSubjectComponent <> nil);
   if Supports(aSubjectComponent, IvcmMainFormDependent, l_MainFormDependent) then
   try
    l_MainFormDependent.MainFormChanged(Self);
   finally
    l_MainFormDependent := nil;
   end;
  end;//lp_SetPageActive

 var
  l_Index: Integer;
 begin
  lp_DoNotifyComponent(aComponent);
  for l_Index := 0 to Pred(aComponent.ComponentCount) do
   lp_NotifyComponent(aComponent.Components[l_Index]);
 end;//lp_NotifyComponent

begin
 lp_NotifyComponent(aForm);
end;//TvcmTabbedContainerForm.NotifyComponentsMainFormChanged

procedure TvcmTabbedContainerForm.NotifyComponentsSelectionChanged(aNewSelectedForm: TvcmEntityForm);

 procedure lp_NotifyComponent(const aComponent: TComponent; aIsActive: Boolean);

  procedure lp_SetPageActive(const aSubjectComponent: TComponent; aValue: Boolean);
  var
   l_Component: IvcmSelectedTabDependent;
  begin
   Assert(aSubjectComponent <> nil);
   if Supports(aSubjectComponent, IvcmSelectedTabDependent, l_Component) then
   try
    if aIsActive then
     l_Component.TabBecomeActive
    else
     l_Component.TabBecomeInActive;
   finally
    l_Component := nil;
   end;//try..finally
  end;//lp_SetPageActive

 var
  l_Index: Integer;
 begin
  lp_SetPageActive(aComponent, aIsActive);
  for l_Index := 0 to Pred(aComponent.ComponentCount) do
   lp_NotifyComponent(aComponent.Components[l_Index], aIsActive);
 end;//lp_NotifyComponent

var
 l_Index: Integer;
 l_Form: TForm;
begin
 for l_Index := 0 to Pred(TabSet.TabCount) do
 begin
  l_Form := TabSet.Tabs[l_Index].Form;
  Assert(l_Form <> nil);
  lp_NotifyComponent(l_Form, l_Form = aNewSelectedForm);
 end;
end;//TvcmTabbedContainerForm.NotifyComponentsSelectionChanged

procedure TvcmTabbedContainerForm.NotifyContainedFormsOnClosing;
var
 l_Index: Integer;
 l_Form: IvcmContainedForm;
begin
 for l_Index := 0 to Pred(TabSet.TabCount) do
  if Supports(TabSet.Tabs[l_Index].Form, IvcmContainedForm, l_Form) then
  try
   l_Form.NotifyContainerIsClosing;
  finally
   l_Form := nil;
  end;
end;//TvcmTabbedContainerForm.NotifyContainedFormsOnClosing

class function TvcmTabbedContainerForm.Make(aNeedLoadFromSettings: Boolean = True): TvcmTabbedContainerForm;
begin
 Result := Create(Application, aNeedLoadFromSettings);
 TvcmTabbedContainerFormDispatcher.Instance.NotifyContainerCreated(Result);
end;//TvcmTabbedContainerForm.Make

class function TvcmTabbedContainerForm.MakeWithChild(aChild: TForm;
  const aTabParams: Il3TabParams = nil;
  aNeedLoadFromSettings: Boolean = True): TvcmTabbedContainerForm;
begin
 Assert(not (aChild is TvcmTabbedContainerForm));
 Result := Make(aNeedLoadFromSettings);
 with Result do
 begin
  InsertForm(aChild, aTabParams, True);
  DisableOthers(aChild);
 end;
end;//TvcmTabbedContainerForm.MakeWithChild

procedure TvcmTabbedContainerForm.ResetClosing;
begin
 f_ContainerIsClosing := False;
end;//TvcmTabbedContainerForm.ResetClosing

procedure TvcmTabbedContainerForm.UpdateMenu(aFormWithMenu: TForm = nil);

 function lp_GetFormMenu(aForm: TForm): TMainMenu;
 var
  l_Index: Integer;
 begin
  Result := nil;
  for l_Index := 0 to Pred(aForm.ComponentCount) do
   if (aForm.Components[l_Index] is TMainMenu) then
   begin
    Result := TMainMenu(aForm.Components[l_Index]);
    Break;
   end;
 end;

var
 l_Form: TForm;
begin
 if (aFormWithMenu = nil) then
  l_Form := TabSet.SelectedForm
 else
  l_Form := aFormWithMenu;
 if (l_Form <> nil) then
 begin
  f_CurrentMainMenu := lp_GetFormMenu(l_Form);
  if (f_CurrentMainMenu <> nil) then
   f_Menu.MenuItem := f_CurrentMainMenu.Items;
 end;
end;//TvcmTabbedContainerForm.UpdateMenu

procedure TvcmTabbedContainerForm.EnableRemindersActivity;
begin
 Assert(False);
end;//TvcmTabbedContainerForm.EnableRemindersActivity

procedure TvcmTabbedContainerForm.DisableRemindersActivity;
begin
 Assert(False);
end;//TvcmTabbedContainerForm.DisableRemindersActivity

function TvcmTabbedContainerForm.CanBeDocked(const aPoint: TPoint;
  aForm: TForm): Boolean;
begin
 Result := TabSet.IsDockablePoint(aPoint) and IsDockOperationPossible;
end;//TvcmTabbedContainerForm.CanBeDocked

function TvcmTabbedContainerForm.GetInnerEntityForm: IvcmEntityForm;
begin
 if (TabSet.SelectedForm <> nil) and
    (not (csDestroying in ComponentState)) then
  Result := (TabSet.SelectedForm as TvcmEntityForm).As_IvcmEntityForm
 else
  Result := nil;
end;//TvcmTabbedContainerForm.GetInnerEntityForm

procedure TvcmTabbedContainerForm.NotifyNeedRefreshFormTab(aForm: TvcmEntityForm;
 aIconIndex: Integer);
begin
 UpdateTabCaption(aForm);
 UpdateTabIcon(aForm, aIconIndex);
end;

function TvcmTabbedContainerForm.MakeFormTabParams(aForm: TvcmEntityForm): Il3TabParams;
var
 l_Tab: TChromeLikeTab;
begin
 l_Tab := TabSet.FormTabs[aForm];
 Result := TabSet.MakeTabParams(l_Tab);
end;

procedure TvcmTabbedContainerForm.UpdateTabCaption(aForm: TafwCustomForm);
var
 l_Params: Il3TabParams;
 l_Form: TvcmEntityForm;
 l_Main: TCustomForm;
 l_MainForm: TvcmEntityForm;
begin
 l_Form := aForm As TvcmEntityForm;
 l_Main := afw.GetMainForm(aForm);
 if (l_Main <> nil) then
 begin
  l_MainForm := l_Main As TvcmEntityForm;
  if (not l_MainForm.VCMClosing) then
  begin
   l_Params := nil;
   l_Params := TvcmTabbedContainerFormDispatcher.Instance.MakeTabParams(l_Form);
   if (l_Params <> nil) then
   try
    TabSet.UpdateFormTab(l_MainForm, l_Params);
    UpdateContainerCaption;
   finally
    l_Params := nil;
   end;//try..finally
  end;
 end;
end;

procedure TvcmTabbedContainerForm.UpdateTabIcon(aForm: TvcmEntityForm; aIconIndex: Integer);
var
 l_Form: TvcmEntityForm;
begin
 if (TvcmTabbedContainerFormDispatcher.Instance.GetFormContainer(aForm) = Self) then
  l_Form := aForm
 else
  l_Form := aForm.NativeMainForm.AsForm.VCLWinControl as TvcmEntityForm;
 TabSet.FormTabs[l_Form].ImageIndex := aIconIndex;
end;

procedure TvcmTabbedContainerForm.AddNewTab;
begin
 DoOpenNewTab;
end;

function TvcmTabbedContainerForm.pm_GetFormCount: Integer;
begin
 Result := TabSet.TabCount;
end;//TvcmTabbedContainerForm.pm_GetFormCount

function TvcmTabbedContainerForm.pm_GetForms(Index: Integer): TvcmEntityForm;
begin
 Result := TvcmEntityForm(TabSet.Tabs[Index].Form);
end;//TvcmTabbedContainerForm.pm_GetForms

procedure TvcmTabbedContainerForm.WMClose(var aMessage: TWMClose);
begin
 if (not f_ContainerIsClosing) then
 begin
  f_ContainerIsClosing := True;
  inherited;
 end;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=603171685  
end;//TvcmTabbedContainerForm.WMClose

procedure TvcmTabbedContainerForm.WMEnable(var aMessage: TWMEnable);
begin
 inherited;
 if not aMessage.Enabled then
  TvgRemindersLineManager.LockActivateProcessing
 else
  TvgRemindersLineManager.UnlockActivateProcessing;
 // - это нужно для того, чтобы медалям не пришло в голову посылать
 // WM_ACTIVATE главной форме когда ее задизейблили
 // http://mdp.garant.ru/pages/viewpage.action?pageId=564993117
 UpdateMenu;
 UpdateWindow(Handle);
end;//TvcmTabbedContainerForm.WMEnable

procedure TvcmTabbedContainerForm.WMCopyData(var aMessage: TWMCopyData);
begin
 if (TabSet.SelectedForm <> nil) then
  aMessage.Result := SendMessage(TabSet.SelectedForm.Handle,
                                 WM_COPYDATA,
                                 TMessage(aMessage).WParam,
                                 TMessage(aMessage).LParam);
end;//TvcmTabbedContainerForm.WMCopyData

procedure TvcmTabbedContainerForm.WMWindowPosChanged(var aMessage: TWMWindowPosChanged);
begin
 inherited;
end;//TvcmTabbedContainerForm.WMWindowPosChanged

procedure TvcmTabbedContainerForm.WMWindowPosChanging(var aMessage: TWMWindowPosChanging);
begin
 if PositionLocked then
  aMessage.WindowPos^.flags := SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE
 else
  inherited;
end;

procedure TvcmTabbedContainerForm.WMSetFocus(var aMessage: TWMSetFocus);
begin
 inherited;
 DoGiveFocusToContainedForm;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=587165767
end;//TvcmTabbedContainerForm.WMSetFocus

procedure TvcmTabbedContainerForm.WMSysCommand(var aMessage: TWMSysCommand);
begin
 if (aMessage.CmdType = SC_KEYMENU) and (aMessage.Key = 0) then
 begin
  if f_Menu.IsMenuActive then
   f_Menu.DeactivateMenu
  else
   f_Menu.ActivateMenu(True);
  aMessage.Result := 1;
 end
 else
 begin
  if (aMessage.CmdType = SC_MINIMIZE) then
   f_WindowStateBeforeMinimizing := WindowState;
  inherited;
 end;
end;//TvcmTabbedContainerForm.WMSysCommand

procedure TvcmTabbedContainerForm.WMActivate(var aMessage: TWMActivate);
var
 l_IsActive: Boolean;
 l_SelectedForm: TForm;
begin
 l_IsActive := (aMessage.Active in [WA_ACTIVE, WA_CLICKACTIVE]);
 if (not (csDestroying in ComponentState)) and
    l_IsActive then
 begin
  l_SelectedForm := TabSet.SelectedForm;
  if (l_SelectedForm <> nil) then
   TvcmTabbedContainerFormDispatcher.Instance.ContainedFormBecomeActive(l_SelectedForm);
 end;
 // - Это нужно до inherited, чтобы успеть обновить информацию об активной
 // mainform'е, потому что из inherited могут позвать что-то, где эта информация
 // будет нужна
 // http://mdp.garant.ru/pages/viewpage.action?pageId=595458185
 inherited;
 if l_IsActive then
  TvcmTabbedContainerFormDispatcher.Instance.StopFlashing;
 if (f_Menu <> nil) then
  f_Menu.IsActive := l_IsActive;
end;


procedure TvcmTabbedContainerForm.CMShowingChanged(var aMessage: TMessage);
var
 l_WindowState: TWindowState;
begin
 l_WindowState := WindowState;
 inherited;
 afw.ProcessMessages;
 if (TabSet.SelectedForm <> nil) and Showing then
  DisableOthers(TabSet.SelectedForm);
 if Showing then
 begin
  UpdateWindowState;
  if (l_WindowState <> WindowState) then
   WindowState := l_WindowState;
 end;
end;

procedure TvcmTabbedContainerForm.CMVisibleChanged(var aMessage: TMessage);
begin
 inherited;
 TvcmTabbedContainerFormDispatcher.Instance.NotifyMainFormVisibleChanged(Visible);
end;

procedure TvcmTabbedContainerForm.vcmMsgCloseForm(var Message: TMessage);

  procedure lp_MakeFormsInvisible;
  var
   l_Index: Integer;
   l_Form: TForm;
  begin
   for l_Index := 0 to Pred(TabSet.TabCount) do
   begin
    l_Form := TabSet.Tabs[l_Index].Form;
    l_Form.Visible := False;
   end;
  end;

begin
 lp_MakeFormsInvisible;
 pnlMain.Visible := False;
 afw.ProcessMessages;
 TvcmTabbedContainerFormDispatcher.Instance.NotifyContainerClosed(Self);
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  if (TvcmTabbedContainerFormDispatcher.Instance.ContainerCount > 0) then
   inherited
  else
   Application.Terminate;
end;



{$If defined(Nemesis) AND not defined(NoVCM)}
procedure TvcmTabbedContainerForm.StartFlashing;
var
 l_Info: TFlashWInfo;
begin
 if not f_Flashing then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0);
  l_Info.cbSize := SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_ALL or FLASHW_TIMER;
  FlashWindowEx(l_Info);
  f_Flashing := True;
 end;//not f_Flashing
end;//TvcmTabbedContainerForm.StartFlashing
{$IfEnd} //Nemesis AND not NoVCM

{$If defined(Nemesis) AND not defined(NoVCM)}
procedure TvcmTabbedContainerForm.StopFlashing;
var
 l_Info: TFlashWInfo;
begin
 if f_Flashing then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0);
  l_Info.cbSize := SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_STOP;
  FlashWindowEx(l_Info);
  f_Flashing := False;
 end;//f_Flashing
end;//TvcmTabbedContainerForm.StopFlashing
{$IfEnd} //Nemesis AND not NoVCM

function TvcmTabbedContainerForm.Get_CurrentMainForm: TafwCustomForm;
begin
 if (TabSet <> nil) and
    (TabSet.TabCount > 0) and
    (TabSet.SelectedForm <> nil) and
    (not (csDestroying in TabSet.SelectedForm.ComponentState)) then
  Result := TabSet.SelectedForm
 else
  Result := nil;
end;//TvcmTabbedContainerForm.Get_CurrentMainForm

procedure TvcmTabbedContainerForm.UpdateFormCaption(aForm: TafwCustomForm);
var
 l_Params: Il3TabParams;
 l_Form: TvcmEntityForm;
 l_Main: TCustomForm;
 l_MainForm: TvcmEntityForm;
begin
 l_Form := aForm As TvcmEntityForm;
 l_Main := afw.GetMainForm(aForm);
 if (l_Main = nil) then
  if (TabSet.FormTabs[l_Form] <> nil) then
   l_Main := aForm;
 if (l_Main <> nil) then
 begin
  l_MainForm := l_Main As TvcmEntityForm;
  if (not l_MainForm.VCMClosing) then
  begin
   l_Params := nil;
   l_Params := TvcmTabbedContainerFormDispatcher.Instance.MakeTabParams(l_Form);
   if (l_Params <> nil) then
   try
    TabSet.UpdateFormTab(l_MainForm, l_Params);
    UpdateContainerCaption;
   finally
    l_Params := nil;
   end;//try..finally
  end;
 end;
end;//TvcmTabbedContainerForm.UpdateFormCaption

function TvcmTabbedContainerForm.Get_MainMenu: TMenuItem;
begin
 Result := f_Menu.MenuItem;
end;//TvcmTabbedContainerForm.Get_MainMenu

function TvcmTabbedContainerForm.DoGetTabSetParent: TWinControl;
begin
 Result := Decorator;
end;//TvcmTabbedContainerForm.DoGetTabSetParent

function TvcmTabbedContainerForm.DoMakeClone: Il3TabbedContainer;
var
 l_Inst: TvcmTabbedContainerForm;
begin
 l_Inst := Make;
 with l_Inst do
 begin
  Height := 600;
  Width := 800;
 end;
 Result := l_Inst;
end;//TvcmTabbedContainerForm.DoMakeClone

procedure TvcmTabbedContainerForm.DockToAnother(const aMousePoint: TPoint;
  aForm: TForm);
begin
 TvcmTabbedContainerFormDispatcher.Instance.TryDockToTabSet(aMousePoint,
  TvcmEntityForm(TabSet.Tabs[0].Form), Self);
end;//TvcmTabbedContainerForm.DockToAnother

function TvcmTabbedContainerForm.DoGetCanOpenNewTab: Boolean;
begin
 Result := TvcmTabbedContainerFormDispatcher.Instance.CanOpenNewTab(Self);
end;

procedure TvcmTabbedContainerForm.Cleanup;
begin
 TvcmSlayedEntityFormsList.Instance.Remove(Self);
// TvcmTabbedContainerFormDispatcher.Instance.NotifyContainerClosed(Self);
 FreeAndNil(f_Menu);
 FreeAndNil(f_BackgroundBitmap);
 f_FormSetHistory := nil;
 inherited;
end;//TvcmTabbedContainerForm.Cleanup

procedure TvcmTabbedContainerForm.CreateParams(var Params: TCreateParams);
begin
 inherited;
 Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;//TvcmTabbedContainerForm.CreateParams

procedure TvcmTabbedContainerForm.DoInit(aFromHistory: Boolean);
begin
 inherited;
 LoadSettings;
end;//TvcmTabbedContainerForm.DoInit

procedure TvcmTabbedContainerForm.InitControls;
var
 l_MenuHeight: Integer;
begin
 inherited;
 l_MenuHeight := GetSystemMetrics(SM_CYMENU);
 with f_Menu do
 begin
  Parent := Self;
  Height := l_MenuHeight + 4;
  Align := alTop;
 end;
 OnCloseQuery := VcmTabbedContainerCloseQuery;
 Decorator.OnClientControlBackgroundChanged := DecoratorBackgroundChanged;
 TabSet.Images := TvcmTabbedContainerFormDispatcher.Instance.TabImages;
end;//TvcmTabbedContainerForm.InitControls

{$If defined(l3HackedVCL)}
function TvcmTabbedContainerForm.NeedAutoScroll: Boolean;
begin
 Result := False;
end;//TvcmTabbedContainerForm.NeedAutoScroll
{$IfEnd} //l3HackedVCL

constructor TvcmTabbedContainerForm.Create(AOwner: TComponent; aNeedLoadFromSettings: Boolean = True);
begin
 f_BackgroundBitmap := Tl3Bitmap.Create;
 f_DisableLoadFromSettings := not aNeedLoadFromSettings;
 inherited Create(AOwner);
 f_FormSetHistory := TvcmFormSetHistory.Make;
 DoLoadFromSettings;
 LoadSettings;
end;//TvcmTabbedContainerForm.CreateNew

procedure TvcmTabbedContainerForm.MakeControls;
begin
 inherited;
 f_Menu := TvcmMainMenuStripForChromeLike.Create(Self);
end;//TvcmTabbedContainerForm.MakeControls

function TvcmTabbedContainerForm.GetClientControl: TWinControl;
begin
 Result := TabSet;
end;//TvcmTabbedContainerForm.GetClientControl

procedure TvcmTabbedContainerForm.DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
  aTab: TChromeLikeTab);
var
 l_Container: IvcmContainedForm;
begin
 Assert(aTab.Form <> nil);
 if Supports(aTab.Form, IvcmContainedForm, l_Container) then
 try
  l_Container.SaveFocusedControl;
 finally
  l_Container := nil;
 end;
end;//TvcmTabbedContainerForm.DoOnTabDeselected

procedure TvcmTabbedContainerForm.DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
  const aRect: TRect;
  aCanvas: TCanvas;
  var aDefaultPainting: Boolean);
var
 l_DwmEnabled: BOOL;
 l_SrcRect: TRect;
begin
 DwmIsCompositionEnabled(l_DwmEnabled);
 aDefaultPainting := l_DwmEnabled;
 if (not aDefaultPainting) then
 begin
  l3FillChar(l_SrcRect, SizeOf(l_SrcRect), 0);
  l_SrcRect.Right := f_BackgroundBitmap.Width;
  l_SrcRect.Bottom := f_BackgroundBitmap.Height;
  aCanvas.CopyRect(aRect, f_BackgroundBitmap.Canvas, l_SrcRect);
 end;
end;//TvcmTabbedContainerForm.DoOnPaintTabSetBackground

procedure TvcmTabbedContainerForm.DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
  aForm: TForm;
  var aCanUndock: Boolean);
begin
 aCanUndock := TvcmTabbedContainerFormDispatcher.Instance.CanOpenNewContainer;
end;//TvcmTabbedContainerForm.DoOnCanUndockFormEvent

procedure TvcmTabbedContainerForm.DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
  aPrevSelected: TChromeLikeTab;
  aNewSelected: TChromeLikeTab);
var
 l_Form: TForm;
begin
 Assert(aNewSelected.Form <> nil);
 l_Form := aNewSelected.Form;
 if (not l3SystemDown) and
    (l_Form <> nil) and
    (not l_Form.Floating) then
 begin
  DisableOthers(l_Form);
  NotifyComponentsSelectionChanged(l_Form as TvcmEntityForm);
  SetActiveWindow(l_Form.Handle);
  SetWindowPos(l_Form.Handle, HWND(0), l_Form.Left, l_Form.Top, l_Form.Width, l_Form.Height,
   SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER);
//  TvgRemindersLineManager.UpdateRemindersActions;
//  TvgRemindersLineManager.CheckZOrder;
  UpdateContainerCaption;
  UpdateMenu(l_Form);
  SetFocusToSelectedForm;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=578894988
 end;
 UpdateContainedFormsActions;
end;//TvcmTabbedContainerForm.DoOnTabSetSelectionChanged

procedure TvcmTabbedContainerForm.DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab;
 var aCanClose: Boolean;
 aNewSelectedTab: TChromeLikeTab);
var
 l_Form: TvcmEntityForm;
 l_ContainedForm: IvcmContainedForm;
 l_SelectedForm: TForm;
begin
 if (TabSet.TabCount > 1) then
 begin
  Assert((aTab.Form <> nil) and (aTab.Form is TvcmEntityForm));
  ActiveControl := nil;
  TvcmTabbedContainerFormDispatcher.Instance.CloseTab(aTab as Il3FormTab);
  l_Form := TvcmEntityForm(aTab.Form);
  Assert(l_Form <> nil);
  aCanClose := l_Form.VCMClosing;
  if aCanClose then
   l_SelectedForm := aNewSelectedTab.Form
  else
   l_SelectedForm := TabSet.SelectedTab.Form;
  UpdateMenu(l_SelectedForm);
 end
 else
 begin
  SafeClose;
  aCanClose := False;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=564264886
 end;
end;

procedure TvcmTabbedContainerForm.AfterInsertForm(aForm: TForm;
  const aParams: Il3TabParams;
  aNeedSelect: Boolean);
var
 l_Form: TvcmEntityForm;
begin
 inherited;
 if (not l3SystemDown) then
 begin
  UpdateWindow(f_Menu.Handle);
  UpdateWindow(Handle);

  l_Form := aForm as TvcmEntityForm;

  if (aParams <> nil) then
   TabSet.UpdateFormTab(aForm, aParams);

  if (TvcmTabbedContainerFormDispatcher.Instance.ContainerCount <= 1) and
     (TabSet.TabCount = 1) then
  begin
 //   Запил для хинта на первом окне с основным меню после запуска оболочки
 //   - http://mdp.garant.ru/pages/viewpage.action?pageId=569232339
 //   Задача на выпрямление всего хозяйства с заголовками, хинтами и иконками:
 //   http://mdp.garant.ru/pages/viewpage.action?pageId=570129497
   TabSet.FormTabs[aForm].HintText := l3Str(l_Form.CCaption);
   TabSet.FormTabs[aForm].Text := l3DStr(TvcmTabbedContainerFormDispatcher.Instance.GetContainedFormCaption(l_Form));
  end;

  NotifyComponentsMainFormChanged(l_Form);

  Decorator.EndUpdate;

  TvgRemindersLineManager.UpdateRemindersActions;

  if aNeedSelect then
  begin
   DisableOthers(aForm);
   NotifyComponentsSelectionChanged(l_Form);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=589883482
  end;
  TvgRemindersLineManager.CheckZOrder;
  TvcmTabbedContainerFormDispatcher.Instance.FormInsertedIntoContainer(l_Form, Self);
  UpdateContainerCaption;
  NotifyComponentsMainFormChanged(l_Form);
 end;
end;//TvcmTabbedContainerForm.AfterInsertForm

procedure TvcmTabbedContainerForm.MakeTabSet;
begin
 pnlMain.Caption := EmptyStr;
 inherited;
end;//TvcmTabbedContainerForm.MakeTabSet

function TvcmTabbedContainerForm.MakeTabSetParams: TChromeLikeTabSetParams;
begin
 Result := TChromeLikeTabSetParams_C(TvcmTabbedContainerFormDispatcher.Instance.TabImages,
  ChromeLikeTabSetResources.CloseButtonImages,
  ChromeLikeTabSetResources.CloseButtonImage[tsesNormal],
  ChromeLikeTabSetResources.CloseButtonImage[tsesHot]);
end;

function TvcmTabbedContainerForm.CanDockToAnother(const aPoint: TPoint): Boolean;
begin
 Result := inherited CanDockToAnother(aPoint);
end;//TvcmTabbedContainerForm.CanDockToAnother

function TvcmTabbedContainerForm.DoGetFormDockSite: TWinControl;
begin
 Result := PnlMain;
end;//TvcmTabbedContainerForm.DoGetFormDockSite

function TvcmTabbedContainerForm.CheckFormTabParams(aForm: TForm; const aParams: Il3TabParams): Il3TabParams;
begin
 if (aParams <> nil) then
  Result := aParams
 else
  Result := TvcmTabbedContainerFormDispatcher.Instance.MakeTabParams(aForm as TvcmEntityForm);
end;

procedure TvcmTabbedContainerForm.BeforeClosing;
begin
 TvcmTabbedContainerFormDispatcher.Instance.SignalContainerIsClosing(Self);
end;

procedure TvcmTabbedContainerForm.ReleaseResources;
begin
 if (f_Menu <> nil) then
 begin
  f_Menu.DeactivateMenu;
  f_Menu.Parent := nil;
 end;
 inherited;
end;

procedure TvcmTabbedContainerForm.DoOpenNewTab;
var
 l_ContainedForm: IvcmContainedForm;
begin
 if Supports(TabSet.SelectedForm, IvcmContainedForm, l_ContainedForm) then
 begin
  l_ContainedForm.OpenNew(vcm_okInNewTab)
 end
 else
  Assert(False);
end;

procedure TvcmTabbedContainerForm.DoUpdateCaption;
begin
 UpdateContainerCaption;
end;

{$IfEnd} //not NoVCM AND not NoVGScene

end.
