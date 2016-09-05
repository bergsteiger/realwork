unit NOT_FINISHED_vcmTabbedContainerForm;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\NOT_FINISHED_vcmTabbedContainerForm.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmTabbedContainerForm" MUID: (534F69E702D9)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmChromeLikeTabbedContainerForm
 , vcmExternalInterfaces
 , afwInterfaces
 , vcmChromeLikeTypes
 , vcmMainMenuStripForChromeLike
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmEntityForm
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Bitmap
 , vcmInterfaces
 , Messages
 , Graphics
 , l3TabbedContainersDispatcher
 , Types
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeInterfaces
 , Classes
 , ChromeLikeTabSetControlPrim
 , ChromeLikeTabSetControl
;

type
 _vcmComponentDestroyer_Parent_ = TvcmChromeLikeTabbedContainerForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmComponentDestroyer.imp.pas}
 TvcmTabbedContainerForm = class(_vcmComponentDestroyer_{$If Defined(Nemesis)}
 , IvcmFlashingWindow
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , IafwMainFormContainer
 {$IfEnd} // NOT Defined(NoVCL)
 , IvcmMenuHolder)
  private
   f_Flashing: Boolean;
   f_Menu: TvcmMainMenuStripForChromeLike;
   f_CurrentMainMenu: TMainMenu;
   f_BackgroundBitmap: Tl3Bitmap;
   f_ContainerIsClosing: Boolean;
   f_WindowStateBeforeMinimizing: TWindowState;
  private
   procedure DecoratorBackgroundChanged(aBitmap: TBitmap;
    aNeedDrawBackground: Boolean);
   procedure UpdateContainedFormsActions;
   procedure DisableOthers(aSelectedForm: TForm);
   procedure UpdateContainerCaption;
   procedure SetFocusToSelectedForm;
   procedure DoGiveFocusToContainedForm;
   procedure vcmTabbedContainerCloseQuery(Sender: TObject;
    var CanClose: Boolean);
   procedure NotifyComponentsMainFormChanged(aForm: TvcmEntityForm);
   procedure NotifyComponentsSelectionChanged(aNewSelectedForm: TvcmEntityForm);
   procedure NotifyContainedFormsOnClosing;
   procedure WMClose(var aMessage: TWMClose); message WM_CLOSE;
   procedure WMEnable(var aMessage: TWMEnable); message WM_ENABLE;
   procedure WMCopyData(var aMessage: TWMCopyData); message WM_COPYDATA;
   procedure WMWindowPosChanged(var aMessage: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
   procedure WMSetFocus(var aMessage: TWMSetFocus); message WM_SETFOCUS;
   procedure WMSysCommand(var aMessage: TWMSysCommand); message WM_SYSCOMMAND;
  protected
   function pm_GetFormCount: Integer;
   function pm_GetForms(Index: Integer): TvcmEntityForm; virtual;
   {$If Defined(Nemesis)}
   procedure StartFlashing;
   {$IfEnd} // Defined(Nemesis)
   {$If Defined(Nemesis)}
   procedure StopFlashing;
   {$IfEnd} // Defined(Nemesis)
   {$If NOT Defined(NoVCL)}
   function Get_CurrentMainForm: TafwCustomForm;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure UpdateFormCaption(aForm: TafwCustomForm);
   {$IfEnd} // NOT Defined(NoVCL)
   function Get_MainMenu: TMenuItem;
   function DoGetTabSetParent: TWinControl; override;
   function DoMakeClone: Il3TabbedContainer; override;
   procedure DockToAnother(const aMousePoint: TPoint;
    aForm: TForm); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
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
   procedure DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
    aTab: TChromeLikeTab;
    var aCanClose: Boolean;
    aNewSelectedTab: TChromeLikeTab); override;
   procedure DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
    aPrevSelected: TChromeLikeTab;
    aNewSelected: TChromeLikeTab); override;
   procedure AfterInsertForm(aForm: TForm;
    const aParams: Il3TabParams;
    aNeedSelect: Boolean); override;
   procedure MakeTabSet; override;
   function CanDockToAnother(const aPoint: TPoint): Boolean; override;
   function DoGetFormDockSite: TWinControl; override;
   function MakeTabSetParams: TChromeLikeTabSetParams; override;
  public
   class function Make: TvcmTabbedContainerForm;
   class function MakeWithChild(aChild: TForm;
    const aTabParams: Il3TabParams = nil): TvcmTabbedContainerForm;
   procedure ResetClosing;
   procedure UpdateMenu(aFormWithMenu: TForm = nil);
   procedure EnableRemindersActivity;
   procedure DisableRemindersActivity;
   function CanBeDocked(const aPoint: TPoint;
    aForm: TForm): Boolean;
   function GetInnerEntityForm: IvcmEntityForm;
   {$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function NeedShowSystemContextMenuOnPoint(const aPoint: TPoint): Boolean; override;
  public
   property ContainerIsClosing: Boolean
    read f_ContainerIsClosing;
   property FormCount: Integer
    read pm_GetFormCount;
   property Forms[Index: Integer]: TvcmEntityForm
    read pm_GetForms;
   property WindowStateBeforeMinimizing: TWindowState
    read f_WindowStateBeforeMinimizing;
 end;//TvcmTabbedContainerForm
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
 , vcmTabbedContainerRes
 , ChromeLikeTabParams
 , vcmFormSetHistory
 , vcmMainMenuBuilder
 , vcmMenuManager
 , vcmFormsUtils
 , SysUtils
 , vcmForm
 , vcmMessages
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *534F69E702D9impl_uses*
 //#UC END# *534F69E702D9impl_uses*
;

type _Instance_R_ = TvcmTabbedContainerForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmComponentDestroyer.imp.pas}

function TvcmTabbedContainerForm.pm_GetFormCount: Integer;
//#UC START# *550AB87B00B3_534F69E702D9get_var*
//#UC END# *550AB87B00B3_534F69E702D9get_var*
begin
//#UC START# *550AB87B00B3_534F69E702D9get_impl*
 Result := f_TabSet.TabCount;
//#UC END# *550AB87B00B3_534F69E702D9get_impl*
end;//TvcmTabbedContainerForm.pm_GetFormCount

function TvcmTabbedContainerForm.pm_GetForms(Index: Integer): TvcmEntityForm;
//#UC START# *550AB8A301BA_534F69E702D9get_var*
//#UC END# *550AB8A301BA_534F69E702D9get_var*
begin
//#UC START# *550AB8A301BA_534F69E702D9get_impl*
 Result := TvcmEntityForm(f_TabSet.Tabs[Index].Form);
//#UC END# *550AB8A301BA_534F69E702D9get_impl*
end;//TvcmTabbedContainerForm.pm_GetForms

procedure TvcmTabbedContainerForm.DecoratorBackgroundChanged(aBitmap: TBitmap;
 aNeedDrawBackground: Boolean);
//#UC START# *550AB82400FD_534F69E702D9_var*
//#UC END# *550AB82400FD_534F69E702D9_var*
begin
//#UC START# *550AB82400FD_534F69E702D9_impl*
 f_BackgroundBitmap.Assign(aBitmap);
//#UC END# *550AB82400FD_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DecoratorBackgroundChanged

class function TvcmTabbedContainerForm.Make: TvcmTabbedContainerForm;
//#UC START# *550BB564039B_534F69E702D9_var*
//#UC END# *550BB564039B_534F69E702D9_var*
begin
//#UC START# *550BB564039B_534F69E702D9_impl*
 Result := CreateNew(Application);
//#UC END# *550BB564039B_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.Make

class function TvcmTabbedContainerForm.MakeWithChild(aChild: TForm;
 const aTabParams: Il3TabParams = nil): TvcmTabbedContainerForm;
//#UC START# *550BB5850337_534F69E702D9_var*

//#UC END# *550BB5850337_534F69E702D9_var*
begin
//#UC START# *550BB5850337_534F69E702D9_impl*
 Assert(not (aChild is TvcmTabbedContainerForm));
 Result := Make;
 with Result do
 begin
  InsertForm(aChild, aTabParams, True);
  DisableOthers(aChild);
 end;
//#UC END# *550BB5850337_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.MakeWithChild

procedure TvcmTabbedContainerForm.ResetClosing;
//#UC START# *550BBECD016F_534F69E702D9_var*
//#UC END# *550BBECD016F_534F69E702D9_var*
begin
//#UC START# *550BBECD016F_534F69E702D9_impl*
 f_ContainerIsClosing := False;
//#UC END# *550BBECD016F_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.ResetClosing

procedure TvcmTabbedContainerForm.UpdateMenu(aFormWithMenu: TForm = nil);
//#UC START# *550BBEE402D5_534F69E702D9_var*

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
//#UC END# *550BBEE402D5_534F69E702D9_var*
begin
//#UC START# *550BBEE402D5_534F69E702D9_impl*
 if (aFormWithMenu = nil) then
  l_Form := f_TabSet.SelectedForm
 else
  l_Form := aFormWithMenu;
 if (l_Form <> nil) then
 begin
  f_CurrentMainMenu := lp_GetFormMenu(l_Form);
  if (f_CurrentMainMenu <> nil) then
   f_Menu.MenuItem := f_CurrentMainMenu.Items;
 end;
//#UC END# *550BBEE402D5_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.UpdateMenu

procedure TvcmTabbedContainerForm.EnableRemindersActivity;
//#UC START# *550BBF190077_534F69E702D9_var*
//#UC END# *550BBF190077_534F69E702D9_var*
begin
//#UC START# *550BBF190077_534F69E702D9_impl*
 Assert(False);
//#UC END# *550BBF190077_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.EnableRemindersActivity

procedure TvcmTabbedContainerForm.DisableRemindersActivity;
//#UC START# *550BBF280023_534F69E702D9_var*
//#UC END# *550BBF280023_534F69E702D9_var*
begin
//#UC START# *550BBF280023_534F69E702D9_impl*
 Assert(False);
//#UC END# *550BBF280023_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DisableRemindersActivity

function TvcmTabbedContainerForm.CanBeDocked(const aPoint: TPoint;
 aForm: TForm): Boolean;
//#UC START# *550BBF70002F_534F69E702D9_var*
//#UC END# *550BBF70002F_534F69E702D9_var*
begin
//#UC START# *550BBF70002F_534F69E702D9_impl*
 Result := TabSet.IsDockablePoint(aPoint) and IsDockOperationPossible;
//#UC END# *550BBF70002F_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.CanBeDocked

procedure TvcmTabbedContainerForm.UpdateContainedFormsActions;
//#UC START# *550BCFD00150_534F69E702D9_var*

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
//#UC END# *550BCFD00150_534F69E702D9_var*
begin
//#UC START# *550BCFD00150_534F69E702D9_impl*
 for l_Index := 0 to Pred(f_TabSet.TabCount) do
  lp_UpdateActions(f_TabSet.Tabs[l_Index].Form);
//#UC END# *550BCFD00150_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.UpdateContainedFormsActions

procedure TvcmTabbedContainerForm.DisableOthers(aSelectedForm: TForm);
//#UC START# *550BCFDF0357_534F69E702D9_var*
var
 l_Form: TForm;
 l_Index: Integer;
//#UC END# *550BCFDF0357_534F69E702D9_var*
begin
//#UC START# *550BCFDF0357_534F69E702D9_impl*
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
//#UC END# *550BCFDF0357_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DisableOthers

procedure TvcmTabbedContainerForm.UpdateContainerCaption;
//#UC START# *550BD0050137_534F69E702D9_var*
var
 l_Form: TForm;
 l_Caption: IvcmCString;
//#UC END# *550BD0050137_534F69E702D9_var*
begin
//#UC START# *550BD0050137_534F69E702D9_impl*
 l_Form := f_TabSet.SelectedTab.Form;
 if (l_Form <> nil) then
 begin
  // 1. В заголовке вкладки отображается короткое название (типа, "Список документов).
  // 2. Такое же название должно быть в таскбаре и меню Alt+Tab.
  // 3. Хинт вкладки остается полным(типа, "Список: <название списка>").
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=565271368
  l_Caption := l3CStr(f_TabSet.SelectedTab.Text);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=564736847
  CCaption := l_Caption;
  Application.Title := l3Str(l_Caption);
  TvcmTabbedContainerFormDispatcher.Instance.ContainerChanged(Self);
 end;
//#UC END# *550BD0050137_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.UpdateContainerCaption

procedure TvcmTabbedContainerForm.SetFocusToSelectedForm;
//#UC START# *550BD0180268_534F69E702D9_var*
var
 l_SelectedForm: TCustomForm;
 l_Container: IvcmContainedForm;
//#UC END# *550BD0180268_534F69E702D9_var*
begin
//#UC START# *550BD0180268_534F69E702D9_impl*
 l_SelectedForm := f_TabSet.SelectedForm;
 Assert(l_SelectedForm <> nil);
 if Supports(l_SelectedForm, IvcmContainedForm, l_Container) then
 try
  l_Container.RestoreFocusedControl;
 finally
  l_Container := nil;
 end;
//#UC END# *550BD0180268_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.SetFocusToSelectedForm

procedure TvcmTabbedContainerForm.DoGiveFocusToContainedForm;
//#UC START# *550BD03202AF_534F69E702D9_var*
var
 l_Container: IvcmContainer;
//#UC END# *550BD03202AF_534F69E702D9_var*
begin
//#UC START# *550BD03202AF_534F69E702D9_impl*
 if Supports(f_TabSet.SelectedForm, IvcmContainer, l_Container) then
 try
  l_Container.SetFocusToMainObjectForm;
 finally
  l_Container := nil;
 end;//try..finally
//#UC END# *550BD03202AF_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoGiveFocusToContainedForm

procedure TvcmTabbedContainerForm.vcmTabbedContainerCloseQuery(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *550BD68A034F_534F69E702D9_var*
//#UC END# *550BD68A034F_534F69E702D9_var*
begin
//#UC START# *550BD68A034F_534F69E702D9_impl*
 CanClose := TvcmTabbedContainerFormDispatcher.Instance.CallContainerCloseQuery(Self);
 if CanClose then
  NotifyContainedFormsOnClosing;
//#UC END# *550BD68A034F_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.vcmTabbedContainerCloseQuery

procedure TvcmTabbedContainerForm.NotifyComponentsMainFormChanged(aForm: TvcmEntityForm);
//#UC START# *550BD6D202AE_534F69E702D9_var*

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

//#UC END# *550BD6D202AE_534F69E702D9_var*
begin
//#UC START# *550BD6D202AE_534F69E702D9_impl*
 lp_NotifyComponent(aForm);
//#UC END# *550BD6D202AE_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.NotifyComponentsMainFormChanged

procedure TvcmTabbedContainerForm.NotifyComponentsSelectionChanged(aNewSelectedForm: TvcmEntityForm);
//#UC START# *550BD6F702D7_534F69E702D9_var*

 procedure lp_NotifyComponent(const aComponent: TComponent; aIsActive: Boolean);

  procedure lp_SetPageActive(const aSubjectComponent: TComponent; aValue: Boolean);
  var
   l_TabSheetControl: IafwTabSheetControl;
   l_Component: IvcmSelectedTabDependent;
  begin
   Assert(aSubjectComponent <> nil);
   if Supports(aSubjectComponent, IafwTabSheetControl, l_TabSheetControl) then
   try
    if aValue then
     l_TabSheetControl.PageActive
    else
     l_TabSheetControl.PageInactive;
   finally
    l_TabSheetControl := nil;
   end;//try..finally
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
//#UC END# *550BD6F702D7_534F69E702D9_var*
begin
//#UC START# *550BD6F702D7_534F69E702D9_impl*
 for l_Index := 0 to Pred(f_TabSet.TabCount) do
 begin
  l_Form := f_TabSet.Tabs[l_Index].Form;
  Assert(l_Form <> nil);
  lp_NotifyComponent(l_Form, l_Form = aNewSelectedForm);
 end;
//#UC END# *550BD6F702D7_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.NotifyComponentsSelectionChanged

procedure TvcmTabbedContainerForm.NotifyContainedFormsOnClosing;
//#UC START# *550BD7170264_534F69E702D9_var*
var
 l_Index: Integer;
 l_Form: IvcmContainedForm;
//#UC END# *550BD7170264_534F69E702D9_var*
begin
//#UC START# *550BD7170264_534F69E702D9_impl*
 for l_Index := 0 to Pred(f_TabSet.TabCount) do
  if Supports(f_TabSet.Tabs[l_Index].Form, IvcmContainedForm, l_Form) then
  try
   l_Form.NotifyContainerIsClosing;
  finally
   l_Form := nil;
  end;
//#UC END# *550BD7170264_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.NotifyContainedFormsOnClosing

function TvcmTabbedContainerForm.GetInnerEntityForm: IvcmEntityForm;
//#UC START# *5511053E013B_534F69E702D9_var*
//#UC END# *5511053E013B_534F69E702D9_var*
begin
//#UC START# *5511053E013B_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5511053E013B_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.GetInnerEntityForm

procedure TvcmTabbedContainerForm.WMClose(var aMessage: TWMClose);
//#UC START# *550AB9B3002C_534F69E702D9_var*
//#UC END# *550AB9B3002C_534F69E702D9_var*
begin
//#UC START# *550AB9B3002C_534F69E702D9_impl*
 f_ContainerIsClosing := True;
 inherited;
//#UC END# *550AB9B3002C_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMClose

procedure TvcmTabbedContainerForm.WMEnable(var aMessage: TWMEnable);
//#UC START# *550AB9CA03D4_534F69E702D9_var*
//#UC END# *550AB9CA03D4_534F69E702D9_var*
begin
//#UC START# *550AB9CA03D4_534F69E702D9_impl*
 inherited;
 if not Message.Enabled then
  TvgRemindersLineManager.LockActivateProcessing
 else
  TvgRemindersLineManager.UnlockActivateProcessing;
 // - это нужно для того, чтобы медалям не пришло в голову посылать
 // WM_ACTIVATE главной форме когда ее задизейблили
 // http://mdp.garant.ru/pages/viewpage.action?pageId=564993117
 UpdateMenu;
 UpdateWindow(Handle);
//#UC END# *550AB9CA03D4_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMEnable

procedure TvcmTabbedContainerForm.WMCopyData(var aMessage: TWMCopyData);
//#UC START# *550AB9EC0166_534F69E702D9_var*
//#UC END# *550AB9EC0166_534F69E702D9_var*
begin
//#UC START# *550AB9EC0166_534F69E702D9_impl*
 if (f_TabSet.SelectedForm <> nil) then
  aMessage.Result := SendMessage(TabSet.SelectedForm.Handle,
                                 WM_COPYDATA,
                                 TMessage(aMessage).WParam,
                                 TMessage(aMessage).LParam);
//#UC END# *550AB9EC0166_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMCopyData

procedure TvcmTabbedContainerForm.WMWindowPosChanged(var aMessage: TWMWindowPosChanged);
//#UC START# *550ABA050068_534F69E702D9_var*
//#UC END# *550ABA050068_534F69E702D9_var*
begin
//#UC START# *550ABA050068_534F69E702D9_impl*
 inherited;
//#UC END# *550ABA050068_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMWindowPosChanged

procedure TvcmTabbedContainerForm.WMSetFocus(var aMessage: TWMSetFocus);
//#UC START# *550ABA1E0398_534F69E702D9_var*
//#UC END# *550ABA1E0398_534F69E702D9_var*
begin
//#UC START# *550ABA1E0398_534F69E702D9_impl*
 inherited;
 DoGiveFocusToContainedForm;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=587165767
//#UC END# *550ABA1E0398_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMSetFocus

procedure TvcmTabbedContainerForm.WMSysCommand(var aMessage: TWMSysCommand);
//#UC START# *550BCDB500D7_534F69E702D9_var*
//#UC END# *550BCDB500D7_534F69E702D9_var*
begin
//#UC START# *550BCDB500D7_534F69E702D9_impl*
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
//#UC END# *550BCDB500D7_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.WMSysCommand

{$If Defined(Nemesis)}
procedure TvcmTabbedContainerForm.StartFlashing;
//#UC START# *4F7DCF74032D_534F69E702D9_var*
//#UC END# *4F7DCF74032D_534F69E702D9_var*
begin
//#UC START# *4F7DCF74032D_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCF74032D_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.StartFlashing
{$IfEnd} // Defined(Nemesis)

{$If Defined(Nemesis)}
procedure TvcmTabbedContainerForm.StopFlashing;
//#UC START# *4F7DCF8D03CC_534F69E702D9_var*
//#UC END# *4F7DCF8D03CC_534F69E702D9_var*
begin
//#UC START# *4F7DCF8D03CC_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7DCF8D03CC_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.StopFlashing
{$IfEnd} // Defined(Nemesis)

{$If NOT Defined(NoVCL)}
function TvcmTabbedContainerForm.Get_CurrentMainForm: TafwCustomForm;
//#UC START# *534F88D7028A_534F69E702D9get_var*
//#UC END# *534F88D7028A_534F69E702D9get_var*
begin
//#UC START# *534F88D7028A_534F69E702D9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *534F88D7028A_534F69E702D9get_impl*
end;//TvcmTabbedContainerForm.Get_CurrentMainForm
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmTabbedContainerForm.UpdateFormCaption(aForm: TafwCustomForm);
//#UC START# *537C731D00B3_534F69E702D9_var*
//#UC END# *537C731D00B3_534F69E702D9_var*
begin
//#UC START# *537C731D00B3_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *537C731D00B3_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.UpdateFormCaption
{$IfEnd} // NOT Defined(NoVCL)

function TvcmTabbedContainerForm.Get_MainMenu: TMenuItem;
//#UC START# *537D832600C0_534F69E702D9get_var*
//#UC END# *537D832600C0_534F69E702D9get_var*
begin
//#UC START# *537D832600C0_534F69E702D9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *537D832600C0_534F69E702D9get_impl*
end;//TvcmTabbedContainerForm.Get_MainMenu

function TvcmTabbedContainerForm.DoGetTabSetParent: TWinControl;
//#UC START# *550A7FE70244_534F69E702D9_var*
//#UC END# *550A7FE70244_534F69E702D9_var*
begin
//#UC START# *550A7FE70244_534F69E702D9_impl*
 Result := Decorator;
//#UC END# *550A7FE70244_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoGetTabSetParent

function TvcmTabbedContainerForm.DoMakeClone: Il3TabbedContainer;
//#UC START# *550A865102E6_534F69E702D9_var*
//#UC END# *550A865102E6_534F69E702D9_var*
begin
//#UC START# *550A865102E6_534F69E702D9_impl*
 Result := Make;
//#UC END# *550A865102E6_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoMakeClone

procedure TvcmTabbedContainerForm.DockToAnother(const aMousePoint: TPoint;
 aForm: TForm);
//#UC START# *550A879C02C9_534F69E702D9_var*
//#UC END# *550A879C02C9_534F69E702D9_var*
begin
//#UC START# *550A879C02C9_534F69E702D9_impl*
 TvcmTabbedContainerFormDispatcher.Instance.TryDockToTabSet(aMousePoint,
  TvcmEntityForm(TabSet.Tabs[0].Form), Self);
//#UC END# *550A879C02C9_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DockToAnother

procedure TvcmTabbedContainerForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_534F69E702D9_var*
//#UC END# *479731C50290_534F69E702D9_var*
begin
//#UC START# *479731C50290_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.Cleanup

{$If NOT Defined(NoVCL)}
procedure TvcmTabbedContainerForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_534F69E702D9_var*
//#UC END# *48C7925A02E5_534F69E702D9_var*
begin
//#UC START# *48C7925A02E5_534F69E702D9_impl*
 inherited;
 aParams.ExStyle := aParams.ExStyle or WS_EX_APPWINDOW;
//#UC END# *48C7925A02E5_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmTabbedContainerForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_534F69E702D9_var*
//#UC END# *49803F5503AA_534F69E702D9_var*
begin
//#UC START# *49803F5503AA_534F69E702D9_impl*
 inherited;
 LoadSettings;
//#UC END# *49803F5503AA_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoInit

procedure TvcmTabbedContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_534F69E702D9_var*
//#UC END# *4A8E8F2E0195_534F69E702D9_var*
begin
//#UC START# *4A8E8F2E0195_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E8F2E0195_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.InitControls

{$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
function TvcmTabbedContainerForm.NeedAutoScroll: Boolean;
//#UC START# *4B0E845502C1_534F69E702D9_var*
//#UC END# *4B0E845502C1_534F69E702D9_var*
begin
//#UC START# *4B0E845502C1_534F69E702D9_impl*
 Result := False;
//#UC END# *4B0E845502C1_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.NeedAutoScroll
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
constructor TvcmTabbedContainerForm.CreateNew(AOwner: TComponent;
 Dummy: Integer = 0);
//#UC START# *4F9007B20376_534F69E702D9_var*
//#UC END# *4F9007B20376_534F69E702D9_var*
begin
//#UC START# *4F9007B20376_534F69E702D9_impl*
 f_BackgroundBitmap := Tl3Bitmap.Create;
 inherited;
 DoLoadFromSettings;
 LoadSettings;
//#UC END# *4F9007B20376_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.CreateNew
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmTabbedContainerForm.MakeControls;
//#UC START# *500004A60200_534F69E702D9_var*
//#UC END# *500004A60200_534F69E702D9_var*
begin
//#UC START# *500004A60200_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *500004A60200_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.MakeControls

function TvcmTabbedContainerForm.NeedShowSystemContextMenuOnPoint(const aPoint: TPoint): Boolean;
//#UC START# *53EAF3250169_534F69E702D9_var*

 function lp_DoHitTest(const aHitPoint: TPoint): LongInt;
 var
  l_Msg: TWMNCHitTest;
 begin
  l3FillChar(l_Msg, SizeOf(l_Msg), 0);
  l_Msg.XPos := aPoint.X;
  l_Msg.YPos := aPoint.Y;
  Result := SendMessage(Handle, WM_NCHITTEST, TMessage(l_Msg).WParam,
   TMessage(l_Msg).LParam);
 end;//lp_DoHitTest

var
 l_HitTestResult: TChromeLikeTabSetHitTestResult;
 l_CaptionRect: TRect;
 l_sCaptionRect: TRect;
//#UC END# *53EAF3250169_534F69E702D9_var*
begin
//#UC START# *53EAF3250169_534F69E702D9_impl*
 l_CaptionRect := ClientRect;
 l_CaptionRect.Bottom := l_CaptionRect.Top + f_TabSet.Height;

 Result := (PtInRect(l_CaptionRect, ScreenToClient(aPoint))) AND
           (lp_DoHitTest(aPoint) in [HTCLIENT, HTCAPTION])  AND
           (f_TabSet.HitTest(aPoint) <> htrInTab);
//#UC END# *53EAF3250169_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.NeedShowSystemContextMenuOnPoint

function TvcmTabbedContainerForm.GetClientControl: TWinControl;
//#UC START# *54B4B94903C5_534F69E702D9_var*
//#UC END# *54B4B94903C5_534F69E702D9_var*
begin
//#UC START# *54B4B94903C5_534F69E702D9_impl*
 Result := TabSet;
//#UC END# *54B4B94903C5_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.GetClientControl

procedure TvcmTabbedContainerForm.DoOnTabDeselected(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab);
//#UC START# *550A7E2502F7_534F69E702D9_var*
var
 l_Container: IvcmContainedForm;
//#UC END# *550A7E2502F7_534F69E702D9_var*
begin
//#UC START# *550A7E2502F7_534F69E702D9_impl*
 Assert(aTab.Form <> nil);
 if Supports(aTab.Form, IvcmContainedForm, l_Container) then
 try
  l_Container.SaveFocusedControl;
 finally
  l_Container := nil;
 end;
//#UC END# *550A7E2502F7_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoOnTabDeselected

procedure TvcmTabbedContainerForm.DoOnPaintTabSetBackground(aTabSet: TChromeLikeTabSetControlPrim;
 const aRect: TRect;
 aCanvas: TCanvas;
 var aDefaultPainting: Boolean);
//#UC START# *550A7E46032C_534F69E702D9_var*
//#UC END# *550A7E46032C_534F69E702D9_var*
begin
//#UC START# *550A7E46032C_534F69E702D9_impl*
 Assert(False);
//#UC END# *550A7E46032C_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoOnPaintTabSetBackground

procedure TvcmTabbedContainerForm.DoOnCanUndockFormEvent(aTabSet: TChromeLikeTabSetControlPrim;
 aForm: TForm;
 var aCanUndock: Boolean);
//#UC START# *550A7E690247_534F69E702D9_var*
//#UC END# *550A7E690247_534F69E702D9_var*
begin
//#UC START# *550A7E690247_534F69E702D9_impl*
 aCanUndock := TvcmTabbedContainerFormDispatcher.Instance.CanOpenNewContainer;
//#UC END# *550A7E690247_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoOnCanUndockFormEvent

procedure TvcmTabbedContainerForm.DoOnCloseTabForm(aTabSet: TChromeLikeTabSetControlPrim;
 aTab: TChromeLikeTab;
 var aCanClose: Boolean;
 aNewSelectedTab: TChromeLikeTab);
//#UC START# *550A7EAB00D2_534F69E702D9_var*
//#UC END# *550A7EAB00D2_534F69E702D9_var*
begin
//#UC START# *550A7EAB00D2_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *550A7EAB00D2_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoOnCloseTabForm

procedure TvcmTabbedContainerForm.DoOnTabSetSelectionChanged(aTabSet: TChromeLikeTabSetControlPrim;
 aPrevSelected: TChromeLikeTab;
 aNewSelected: TChromeLikeTab);
//#UC START# *550A7EC00274_534F69E702D9_var*
var
 l_Form: TForm;
//#UC END# *550A7EC00274_534F69E702D9_var*
begin
//#UC START# *550A7EC00274_534F69E702D9_impl*
 Assert(aNewSelected.Form <> nil);
 l_Form := aNewSelected.Form;
 if (l_Form <> nil) and
    (not l_Form.Floating) then
 begin
  NotifyComponentsSelectionChanged(l_Form as TvcmEntityForm);
  DisableOthers(l_Form);
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
//#UC END# *550A7EC00274_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoOnTabSetSelectionChanged

procedure TvcmTabbedContainerForm.AfterInsertForm(aForm: TForm;
 const aParams: Il3TabParams;
 aNeedSelect: Boolean);
//#UC START# *550A84C1035F_534F69E702D9_var*
var
 l_Form: TvcmEntityForm;
//#UC END# *550A84C1035F_534F69E702D9_var*
begin
//#UC START# *550A84C1035F_534F69E702D9_impl*
 inherited;
 UpdateWindow(f_Menu.Handle);
 UpdateWindow(Handle);

 l_Form := aForm as TvcmEntityForm;

 TvcmTabbedContainerFormDispatcher.Instance.FormInsertedIntoContainer(l_Form, Self);

 if (aParams <> nil) then
  f_TabSet.UpdateFormTab(aForm, aParams);

 if (TvcmTabbedContainerFormDispatcher.Instance.ContainerCount = 0) and
    (f_TabSet.TabCount = 1) then
//   Запил для хинта на первом окне с основным меню после запуска оболочки
//   - http://mdp.garant.ru/pages/viewpage.action?pageId=569232339
//   Задача на выпрямление всего хозяйства с заголовками, хинтами и иконками:
//   http://mdp.garant.ru/pages/viewpage.action?pageId=570129497
  f_TabSet.FormTabs[aForm].HintText := l3Str(l_Form.CCaption);

 NotifyComponentsMainFormChanged(l_Form);

 Decorator.EndUpdate;
 f_LastDockOperationTickCount := GetTickCount;

 TvgRemindersLineManager.UpdateRemindersActions;

 if aNeedSelect then
  NotifyComponentsSelectionChanged(l_Form);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=589883482

 TvgRemindersLineManager.CheckZOrder;
//#UC END# *550A84C1035F_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.AfterInsertForm

procedure TvcmTabbedContainerForm.MakeTabSet;
//#UC START# *550A873B0298_534F69E702D9_var*
//#UC END# *550A873B0298_534F69E702D9_var*
begin
//#UC START# *550A873B0298_534F69E702D9_impl*
 pnlMain.Caption := EmptyStr;
 inherited;

//#UC END# *550A873B0298_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.MakeTabSet

function TvcmTabbedContainerForm.CanDockToAnother(const aPoint: TPoint): Boolean;
//#UC START# *550A877701F5_534F69E702D9_var*
//#UC END# *550A877701F5_534F69E702D9_var*
begin
//#UC START# *550A877701F5_534F69E702D9_impl*
 Result := inherited CanDockToAnother(aPoint);
//#UC END# *550A877701F5_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.CanDockToAnother

function TvcmTabbedContainerForm.DoGetFormDockSite: TWinControl;
//#UC START# *550AAF6F03A1_534F69E702D9_var*
//#UC END# *550AAF6F03A1_534F69E702D9_var*
begin
//#UC START# *550AAF6F03A1_534F69E702D9_impl*
 Result := PnlMain;
//#UC END# *550AAF6F03A1_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.DoGetFormDockSite

function TvcmTabbedContainerForm.MakeTabSetParams: TChromeLikeTabSetParams;
//#UC START# *5518E1700367_534F69E702D9_var*
//#UC END# *5518E1700367_534F69E702D9_var*
begin
//#UC START# *5518E1700367_534F69E702D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5518E1700367_534F69E702D9_impl*
end;//TvcmTabbedContainerForm.MakeTabSetParams

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmTabbedContainerForm);
 {* Регистрация TvcmTabbedContainerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
