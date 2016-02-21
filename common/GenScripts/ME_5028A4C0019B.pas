unit vcmToolbar;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmToolbar.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 {$If NOT Defined(NoTB97)}
 , TB97
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr
 {$IfEnd} // NOT Defined(NoTB97)
 , vcmUserControls
 , vcmControl
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , vcmExternalInterfaces
 , Types
 , vcmLocalInterfaces
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 vcm_DefaultToolbarOptions = [vcm_toModulesInMainToolbar, vcm_toEntitiesInMainToolbar];

type
 TvcmDockDefPrim = class(TDock97)
 end;//TvcmDockDefPrim

 //#UC START# *50289DB9036Fci*
 //#UC END# *50289DB9036Fci*
 //#UC START# *50289DB9036Fcit*
 //#UC END# *50289DB9036Fcit*
 TvcmToolbarDef = class(TToolbar97)
  private
   f_Pos: TvcmEffectiveToolBarPos;
    {* Поле для свойства Pos }
  protected
   function pm_GetButtonCount: Integer;
   procedure LockDock;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure VisibleChanging; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoTB97)}
   procedure ExecuteHandler(Sender: TObject); override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure ExecuteDefered; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure UpdateEmpty(aUpdateVisibility: Boolean); override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   procedure vcmDeleteLastIfSeparator;
   procedure DeleteControls;
  public
   property Pos: TvcmEffectiveToolBarPos
    read f_Pos;
   property ButtonCount: Integer
    read pm_GetButtonCount;
 //#UC START# *50289DB9036Fpubl*
   property DragKind;
   property DragMode;
 //#UC END# *50289DB9036Fpubl*
 end;//TvcmToolbarDef

 TvcmToolbarDockPanel = class;

 TvcmDockPanelButton = class;

 TvcmDockPanel = class(TvcmControl)
  private
   f_BtnClose: TvcmDockPanelButton;
   f_BtnOpen: TvcmDockPanelButton;
   f_BtnMaximized: TvcmDockPanelButton;
   f_ImageList: TImageList;
   f_pnlToolbar: TvcmToolbarDockPanel;
   f_pnlDock: TPanel;
   f_PrevHeight: Integer;
   f_PrevWidth: Integer;
   f_Toolbar: TToolbar;
    {* Поле для свойства Toolbar }
   f_ToolbarDock: TvcmDockDefPrim;
    {* Поле для свойства ToolbarDock }
  private
   procedure WMSize(var Message: TWMSize);
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  protected
   procedure pm_SetToolbar(aValue: TToolbar);
   procedure pm_SetToolbarDock(aValue: TvcmDockDefPrim);
   function CheckLink(const aLink: IvcmFormHandler): Boolean;
   function CreateBtn(aImageIndex: Integer;
    const aLink: IvcmFormHandler;
    const aName: AnsiString): TvcmDockPanelButton;
   procedure SetDockBounds(var ALeft: Integer;
    var ATop: Integer;
    var AWidth: Integer;
    var AHeight: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure Click; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AlignControls(AControl: TControl;
    var Rect: TRect); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   function CreateMaximizedBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
   function CreateCloseBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
   function CreateOpenBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
   procedure CreateToolbar;
   procedure UpdateToolbarSize;
   constructor Create(AOwner: TComponent); override;
  public
   property Toolbar: TToolbar
    read f_Toolbar
    write pm_SetToolbar;
   property ToolbarDock: TvcmDockDefPrim
    read f_ToolbarDock
    write pm_SetToolbarDock;
 end;//TvcmDockPanel

 TvcmDockDef = class(TvcmDockDefPrim, IvcmDock)
  private
   f_AllowGripSize: Boolean;
   f_Pos: TvcmEffectiveToolBarPos;
    {* Поле для свойства Pos }
   f_DockPanel: TvcmDockPanel;
    {* Поле для свойства DockPanel }
  private
   function SizeGripValid: Boolean;
   procedure WMSize(var Message: TWMSize);
   procedure WMNCCalcSize(var Message: TWMNCCalcSize);
   procedure WMNCPaint(var Message: TMessage);
   procedure WMNChitTest(var Msg: TWMNCHitTest);
  protected
   function pm_GetFullWidth: Integer;
   function pm_GetFullHeight: Integer;
   function pm_GetPos: TvcmEffectiveToolBarPos;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoTB97)}
   function SizeGripWidth: Integer; override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   procedure SetHandlers(const aMaximizedLink: IvcmFormHandler;
    const aOpenLink: IvcmFormHandler;
    const aCloseLink: IvcmFormHandler);
   procedure SetFasten(aFasten: Boolean);
   class function Make(anOwner: TComponent;
    const aName: AnsiString;
    aPos: TvcmEffectiveToolBarPos): TvcmDockDef;
  public
   property Pos: TvcmEffectiveToolBarPos
    read pm_GetPos;
   property DockPanel: TvcmDockPanel
    read f_DockPanel
    write f_DockPanel;
 end;//TvcmDockDef

 TvcmSeparatorDef = class(TToolbarSep97)
 end;//TvcmSeparatorDef

 TvcmToolbarDockPanel = class(TCustomPanel)
  private
   f_ToolbarDock: TvcmDockDef;
    {* Поле для свойства ToolbarDock }
  protected
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   class function Make(AOwner: TComponent;
    aDock: TvcmDockDef = nil): TvcmToolbarDockPanel;
  public
   property ToolbarDock: TvcmDockDef
    read f_ToolbarDock
    write f_ToolbarDock;
 end;//TvcmToolbarDockPanel

 TvcmDockPanelButton = class(TCustomToolbarButton97)
  private
   f_Form: TCustomForm;
   f_DockPanel: TvcmDockPanel;
    {* Поле для свойства DockPanel }
  protected
   procedure pm_SetLink(const aValue: IvcmFormHandler);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
  public
   class function Make(aOwner: TComponent;
    const aLink: IvcmFormHandler;
    aDockPanel: TvcmDockPanel;
    const aName: AnsiString): TvcmDockPanelButton;
  public
   property Link: IvcmFormHandler
    write pm_SetLink;
   property DockPanel: TvcmDockPanel
    read f_DockPanel
    write f_DockPanel;
 end;//TvcmDockPanelButton

 TvcmToolbarOption = (
  vcm_toModulesInMainToolbar
  , vcm_toEntitiesInMainToolbar
  , vcm_toEntitiesInChildToolbar
 );//TvcmToolbarOption

 TvcmToolbarOptions = set of TvcmToolbarOption;

 //#UC START# *5028A4C0019Bci*
 //#UC END# *5028A4C0019Bci*
 //#UC START# *5028A4C0019Bcit*
 //#UC END# *5028A4C0019Bcit*
 TvcmToolbar = class(TvcmToolbarDef)
  private
   f_DockDef: TvcmDockDef;
    {* Поле для свойства DockDef }
  protected
   {$If NOT Defined(NoVCL)}
   procedure RequestAlign; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoTB97)}
   function NeedActivateMainForm: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure ActivateMainForm; override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   constructor Create(anOwner: TComponent;
    aDock: TvcmDockDef); reintroduce;
   {$If NOT Defined(NoTB97)}
   procedure BeginUpdate; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure EndUpdate; override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   property DockDef: TvcmDockDef
    read f_DockDef;
 //#UC START# *5028A4C0019Bpubl*
   property BevelEdges;
 //#UC END# *5028A4C0019Bpubl*
 end;//TvcmToolbar
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Defaults
 {$If NOT Defined(NoVCL)}
 , ToolWin
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , vcmBase
 , Windows
 , vcmInternalConst
 , vcmInterfaces
 , afwDrawing
 , vcmToolbarUtils
 , afwInterfaces
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmBaseMenuManager
 , vcmMenuManager
;

function TvcmToolbarDef.pm_GetButtonCount: Integer;
//#UC START# *52A991A201C8_50289DB9036Fget_var*
//#UC END# *52A991A201C8_50289DB9036Fget_var*
begin
//#UC START# *52A991A201C8_50289DB9036Fget_impl*
 Result := ControlCount;
//#UC END# *52A991A201C8_50289DB9036Fget_impl*
end;//TvcmToolbarDef.pm_GetButtonCount

procedure TvcmToolbarDef.vcmDeleteLastIfSeparator;
//#UC START# *50289E6F021D_50289DB9036F_var*
//#UC END# *50289E6F021D_50289DB9036F_var*
begin
//#UC START# *50289E6F021D_50289DB9036F_impl*
 DeleteLastIfSeparator;
//#UC END# *50289E6F021D_50289DB9036F_impl*
end;//TvcmToolbarDef.vcmDeleteLastIfSeparator

procedure TvcmToolbarDef.DeleteControls;
//#UC START# *50289E7E0162_50289DB9036F_var*
//#UC END# *50289E7E0162_50289DB9036F_var*
begin
//#UC START# *50289E7E0162_50289DB9036F_impl*
 FreeControls;
//#UC END# *50289E7E0162_50289DB9036F_impl*
end;//TvcmToolbarDef.DeleteControls

procedure TvcmToolbarDef.LockDock;
//#UC START# *50289F8500B8_50289DB9036F_var*
//#UC END# *50289F8500B8_50289DB9036F_var*
begin
//#UC START# *50289F8500B8_50289DB9036F_impl*
 if g_MenuManager.GetOpLock and (DockedTo <> nil) and
    not (csDestroying in DockedTo.ComponentState) then
 begin
  g_MenuManager.BeginOp;
  try
   if TvcmToolbarDockListManager.Instance.DockList.IndexOf(DockedTo) < 0 then
   begin
    TvcmToolbarDockListManager.Instance.DockList.Add(DockedTo);
    DockedTo.BeginUpdate;
   end;
  finally
   g_MenuManager.EndOp;
  end;
 end;
//#UC END# *50289F8500B8_50289DB9036F_impl*
end;//TvcmToolbarDef.LockDock

procedure TvcmToolbarDef.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_50289DB9036F_var*
//#UC END# *479731C50290_50289DB9036F_var*
begin
//#UC START# *479731C50290_50289DB9036F_impl*
 LockDock;
 inherited;
//#UC END# *479731C50290_50289DB9036F_impl*
end;//TvcmToolbarDef.Cleanup

{$If NOT Defined(NoVCL)}
procedure TvcmToolbarDef.VisibleChanging;
//#UC START# *4CC8658C017B_50289DB9036F_var*
//#UC END# *4CC8658C017B_50289DB9036F_var*
begin
//#UC START# *4CC8658C017B_50289DB9036F_impl*
 LockDock;
 inherited;
//#UC END# *4CC8658C017B_50289DB9036F_impl*
end;//TvcmToolbarDef.VisibleChanging
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbarDef.ExecuteHandler(Sender: TObject);
//#UC START# *5028A00600B5_50289DB9036F_var*
var
 l_Action: IvcmAction;
//#UC END# *5028A00600B5_50289DB9036F_var*
begin
//#UC START# *5028A00600B5_50289DB9036F_impl*
 if Supports(Action, IvcmAction, l_Action) then
 try
  if not l_Action.IsExecuteLocked then
   inherited;
 finally
  l_Action := nil;
 end//try..finally
 else
  inherited;
//#UC END# *5028A00600B5_50289DB9036F_impl*
end;//TvcmToolbarDef.ExecuteHandler
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbarDef.ExecuteDefered;
//#UC START# *5028A09900D5_50289DB9036F_var*
var
 l_LockCount: Integer;
 l_Action: IvcmAction;

 procedure SaveLock;
 begin
  if l_Action <> nil then
  begin
   l_LockCount := 0;
   while l_Action.IsExecuteLocked do
   begin
    l_Action.UnlockExecute;
    inc(l_LockCount);
   end;//while l_Action.IsExecuteLocked do
  end;//if l_Action <> nil then
 end;//SaveLock

 procedure RestoreLock;
 begin
  if l_Action <> nil then
  begin
   while l_LockCount > 0 do
   begin
    l_Action.LockExecute;
    dec(l_LockCount);
   end;//while l_LockCount > 0 do
  end;//if l_Action <> nil then
 end;//RestoreLock
//#UC END# *5028A09900D5_50289DB9036F_var*
begin
//#UC START# *5028A09900D5_50289DB9036F_impl*
 if Assigned(FNeedExecution) then
 begin
  Supports(FCurrentAction, IvcmAction, l_Action);
  SaveLock;
  try
   FNeedExecution(FExecOwner);
  finally
   RestoreLock;
  end;//try..finally
 end;//if Assigned(FNeedExecution) then
//#UC END# *5028A09900D5_50289DB9036F_impl*
end;//TvcmToolbarDef.ExecuteDefered
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbarDef.UpdateEmpty(aUpdateVisibility: Boolean);
//#UC START# *5028A1220383_50289DB9036F_var*
var
 I: Integer;
//#UC END# *5028A1220383_50289DB9036F_var*
begin
//#UC START# *5028A1220383_50289DB9036F_impl*
 FEmpty := True;
 for I := 0 to Pred(ControlCount) do begin
  if Controls[I].Visible and not (Controls[I] is Ttb97MoreButton) and
  not (Controls[I] is TvcmSeparatorDef) then begin
   FEmpty := False;
   Break;
  end;
 end;
 inherited;
//#UC END# *5028A1220383_50289DB9036F_impl*
end;//TvcmToolbarDef.UpdateEmpty
{$IfEnd} // NOT Defined(NoTB97)

//#UC START# *50289DB9036Fimpl*
//#UC END# *50289DB9036Fimpl*

procedure TvcmDockPanel.pm_SetToolbar(aValue: TToolbar);
//#UC START# *52A991CE0016_5028DEDB021Dset_var*
//#UC END# *52A991CE0016_5028DEDB021Dset_var*
begin
//#UC START# *52A991CE0016_5028DEDB021Dset_impl*
 f_Toolbar := aValue;
 f_Toolbar.Parent := f_pnlToolbar;
//#UC END# *52A991CE0016_5028DEDB021Dset_impl*
end;//TvcmDockPanel.pm_SetToolbar

procedure TvcmDockPanel.pm_SetToolbarDock(aValue: TvcmDockDefPrim);
//#UC START# *52A99201025B_5028DEDB021Dset_var*
//#UC END# *52A99201025B_5028DEDB021Dset_var*
begin
//#UC START# *52A99201025B_5028DEDB021Dset_impl*
 f_ToolbarDock := aValue;
 f_ToolbarDock.Parent := f_pnlDock;
//#UC END# *52A99201025B_5028DEDB021Dset_impl*
end;//TvcmDockPanel.pm_SetToolbarDock

function TvcmDockPanel.CreateMaximizedBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
//#UC START# *5028E3DB0203_5028DEDB021D_var*
var
 l_ImageIndex: Integer;
//#UC END# *5028E3DB0203_5028DEDB021D_var*
begin
//#UC START# *5028E3DB0203_5028DEDB021D_impl*
 Result := nil;
 l_ImageIndex := -1;
 if not CheckLink(aLink) then
 begin
  if (f_BtnMaximized <> nil) then
   f_BtnMaximized.Visible := false;
  Exit;
 end;//not CheckLink(aLink)
 Assert(Assigned(g_MenuManager));
 if g_MenuManager is TvcmCustomMenuManager then
  l_ImageIndex := TvcmCustomMenuManager(g_MenuManager).BtnOpenNewWindowImageIndex;
 if not Assigned(f_BtnMaximized) then
  f_BtnMaximized := CreateBtn(l_ImageIndex, aLink, 'BtnMaximized')
 else
  f_BtnMaximized.Link := aLink;
 Result := f_BtnMaximized;
//#UC END# *5028E3DB0203_5028DEDB021D_impl*
end;//TvcmDockPanel.CreateMaximizedBtn

function TvcmDockPanel.CreateCloseBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
//#UC START# *5028E403004C_5028DEDB021D_var*
var
 l_ImageIndex: Integer;
//#UC END# *5028E403004C_5028DEDB021D_var*
begin
//#UC START# *5028E403004C_5028DEDB021D_impl*
 Result := nil;
 l_ImageIndex := -1;
 if not CheckLink(aLink) OR not aLink.CanHaveOwnCloseButtonInNavigator then
 begin
  if (f_BtnClose <> nil) then
   f_BtnClose.Visible := false;
  Exit;
 end;//not CheckLink(aLink)
 Assert(Assigned(g_MenuManager));
 if g_MenuManager is TvcmCustomMenuManager then
  l_ImageIndex := TvcmCustomMenuManager(g_MenuManager).BtnCloseImageIndex;
 if not Assigned(f_BtnClose) then
  f_BtnClose := CreateBtn(l_ImageIndex, aLink, 'BtnClose')
 else
  f_BtnClose.Link := aLink;
 Result := f_BtnClose;
//#UC END# *5028E403004C_5028DEDB021D_impl*
end;//TvcmDockPanel.CreateCloseBtn

function TvcmDockPanel.CreateOpenBtn(const aLink: IvcmFormHandler): TvcmDockPanelButton;
//#UC START# *5028E41E0384_5028DEDB021D_var*
var
 l_ImageIndex: Integer;
//#UC END# *5028E41E0384_5028DEDB021D_var*
begin
//#UC START# *5028E41E0384_5028DEDB021D_impl*
 Result := nil;
 l_ImageIndex := -1;
 if not CheckLink(aLink) then
 begin
  if (f_BtnOpen <> nil) then
   f_BtnOpen.Visible := false;
  Exit;
 end;//not CheckLink(aLink)
 Assert(Assigned(g_MenuManager));
 if g_MenuManager is TvcmCustomMenuManager then
  l_ImageIndex := TvcmCustomMenuManager(g_MenuManager).BtnOpenImageIndex;
 if not Assigned(f_BtnOpen) then
  f_BtnOpen := CreateBtn(l_ImageIndex, aLink, 'BtnOpen')
 else
  f_BtnOpen.Link := aLink;
 Result := f_BtnOpen;
//#UC END# *5028E41E0384_5028DEDB021D_impl*
end;//TvcmDockPanel.CreateOpenBtn

function TvcmDockPanel.CheckLink(const aLink: IvcmFormHandler): Boolean;
//#UC START# *5028E4BD038B_5028DEDB021D_var*
//#UC END# *5028E4BD038B_5028DEDB021D_var*
begin
//#UC START# *5028E4BD038B_5028DEDB021D_impl*
 Result := (aLink <> nil) and (aLink.Form <> nil) and Assigned(aLink.Handler);
//#UC END# *5028E4BD038B_5028DEDB021D_impl*
end;//TvcmDockPanel.CheckLink

function TvcmDockPanel.CreateBtn(aImageIndex: Integer;
 const aLink: IvcmFormHandler;
 const aName: AnsiString): TvcmDockPanelButton;
//#UC START# *5028E4DB0207_5028DEDB021D_var*
//#UC END# *5028E4DB0207_5028DEDB021D_var*
begin
//#UC START# *5028E4DB0207_5028DEDB021D_impl*
 // создадим toolbar для кнопок
 if not Assigned(f_ToolBar) then
  CreateToolBar;
 // создадим кнопку
 Result := TvcmDockPanelButton.Make(f_ToolBar, aLink, Self, aName);
 with Result do
 begin
  Name := aName;
  Parent := f_ToolBar;
  ImageIndex := aImageIndex;
  Assert(Assigned(g_MenuManager));
  if g_MenuManager is TvcmCustomMenuManager then
   Images := TvcmCustomMenuManager(g_MenuManager).DockButtonsImageList;
 end;//with Result
 // размер toolbar-а
 f_ToolBar.ButtonWidth := Result.Width;
 UpdateToolbarSize;
//#UC END# *5028E4DB0207_5028DEDB021D_impl*
end;//TvcmDockPanel.CreateBtn

procedure TvcmDockPanel.SetDockBounds(var ALeft: Integer;
 var ATop: Integer;
 var AWidth: Integer;
 var AHeight: Integer);
//#UC START# *5028E4FB030F_5028DEDB021D_var*
//#UC END# *5028E4FB030F_5028DEDB021D_var*
begin
//#UC START# *5028E4FB030F_5028DEDB021D_impl*
 { В TvcmDockDef может не быть ни одного toolbar-а, но если есть f_ToolBar, то
   не даём устанавливать высоту меньше f_ToolBar.ButtonHeight }
 if ToolbarDock <> nil then
 begin
  if (ToolbarDock.Position = dpTop) or (ToolbarDock.Position = dpBottom) then
  begin
   if Assigned(f_ToolBar) and (AHeight < f_ToolBar.ButtonHeight) then
    AHeight := f_ToolBar.ButtonHeight + 4;
   { Размеры основной панели }
   Self.Height := AHeight + Self.BorderWidth * 2;
   { Toolbar с кнопками }
   if Assigned(f_Toolbar) then
    f_Toolbar.Height := f_pnlToolbar.Height;
  end
  else
  begin
   if Assigned(f_ToolBar) and (AWidth < f_ToolBar.ButtonWidth) then
    AWidth := f_ToolBar.ButtonWidth + 4;
   { Размеры основной панели }
   Self.Width := AWidth + Self.BorderWidth * 2;
   { Toolbar с кнопками }
   if Assigned(f_Toolbar) then
    f_Toolbar.Width := f_pnlToolbar.Width;
  end;
 end;//if ToolbarDock <> nil then
//#UC END# *5028E4FB030F_5028DEDB021D_impl*
end;//TvcmDockPanel.SetDockBounds

procedure TvcmDockPanel.CreateToolbar;
//#UC START# *5028E59700E9_5028DEDB021D_var*
//#UC END# *5028E59700E9_5028DEDB021D_var*
begin
//#UC START# *5028E59700E9_5028DEDB021D_impl*
 if not Assigned(f_pnlToolbar) then
 begin
  f_pnlToolbar := TvcmToolbarDockPanel.Make(Self, TvcmDockDef(f_ToolbarDock));
  with f_pnlToolbar do
  begin
   Parent := Self;
   BevelOuter := bvNone;
   Align := alRight;
   BorderStyle := bsNone;
  {$IfDef Nemesis}
   Color := cGarant2011BackColor;
  {$EndIf}
  end;
 end;
 if not Assigned(f_ToolBar) then
 begin
  f_ToolBar := TToolBar.Create(Self);
  with f_ToolBar do
  begin
   Parent := f_pnlToolbar;
   Wrapable := False;
   AutoSize := True;
   Flat := True;
   EdgeInner := TEdgeStyle(esNone);
   EdgeOuter := TEdgeStyle(esNone);
   ShowHint := True;
  end;
 end;
//#UC END# *5028E59700E9_5028DEDB021D_impl*
end;//TvcmDockPanel.CreateToolbar

procedure TvcmDockPanel.UpdateToolbarSize;
//#UC START# *5028E59F005F_5028DEDB021D_var*
var
 l_AddWidth: Integer;
 l_ButtonWidth: Integer;
 l_Index: Integer;
//#UC END# *5028E59F005F_5028DEDB021D_var*
begin
//#UC START# *5028E59F005F_5028DEDB021D_impl*
 with f_Toolbar do
 begin
  l_ButtonWidth := 0;
  for l_Index := Pred(f_Toolbar.ControlCount) downto 0 do
   with Controls[l_Index] do
    if Visible then
    begin
     Left := l_ButtonWidth;
     Inc(l_ButtonWidth, ButtonWidth);
    end;
  l_AddWidth := 0;
  (* Левая граница *)
  if ebLeft in EdgeBorders then
   l_AddWidth := l_AddWidth + 1;
  (* Правая граница *)
  if ebRight in EdgeBorders then
   l_AddWidth := l_AddWidth + 1;
  (* У левой и у правой кнопки граница на 1 пиксель больше *)
  if ButtonCount > 1 then
   l_AddWidth := 2;
  f_pnlToolbar.Width := l_ButtonWidth + l_AddWidth;
 end;
//#UC END# *5028E59F005F_5028DEDB021D_impl*
end;//TvcmDockPanel.UpdateToolbarSize

procedure TvcmDockPanel.WMSize(var Message: TWMSize);
//#UC START# *5028E6C80331_5028DEDB021D_var*
var
 l_OldWidth,
 l_OldHeight: Integer;
//#UC END# *5028E6C80331_5028DEDB021D_var*
begin
//#UC START# *5028E6C80331_5028DEDB021D_impl*
 l_OldWidth := Width;
 l_OldHeight := Height;
 inherited;
 if Parent is TForm then
  case (Parent as TForm).BorderStyle of
   bsDialog,
   bsSingle:
    case Align of
     alTop,
     alBottom:
       if Height <> (*l_OldHeight*) f_PrevHeight then
       begin
        // При размере шрифтов в 125% l_OldHeight бывает равен Height
        // (http://mdp.garant.ru/pages/viewpage.action?pageId=446825181)
        (*Parent.Height := Parent.Height + (l_OldHeight - Height);*)
        Parent.Height := Parent.Height - (f_PrevHeight - Height);
        f_PrevHeight := Height;
       end;
     alLeft,
     alRight:
      if Width <> (*l_OldWidth*) f_PrevWidth then
      begin
       // http://mdp.garant.ru/pages/viewpage.action?pageId=446825181
       (*Parent.Width := Parent.Width + (l_OldWidth - Width);*)
       Parent.Width := Parent.Width - (f_PrevWidth - Width);
       f_PrevWidth := Width;
      end;
    end;
  end;
//#UC END# *5028E6C80331_5028DEDB021D_impl*
end;//TvcmDockPanel.WMSize

procedure TvcmDockPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *5028E6ED005E_5028DEDB021D_var*
var
 lR: TRect;
//#UC END# *5028E6ED005E_5028DEDB021D_var*
begin
//#UC START# *5028E6ED005E_5028DEDB021D_impl*
 Message.Result := 1;//не прочищаем фон
 if Assigned(ToolbarDock) then
 begin
  lR := ClientRect;
  with Canvas do
  begin
   Pen.Color := clBtnShadow;
   case ToolbarDock.Position of
    dpTop: 
     begin
      MoveTo(lR.Left, Pred(lR.Bottom));
      LineTo(lR.Right, Pred(lR.Bottom));
     end;
    dpBottom: 
     begin
      MoveTo(lR.Left, lR.Top);
      LineTo(lR.Right, lR.Top);
     end;
    dpRight: 
     begin
      MoveTo(lR.Left, lR.Top);
      LineTo(lR.Left, lR.Bottom);
     end;
    dpLeft: 
     begin
      MoveTo(Pred(lR.Right), lR.Top);
      LineTo(Pred(lR.Right), lR.Bottom);
     end;
   end;// case
  end;// with Canvas
 end;// if Assigned
//#UC END# *5028E6ED005E_5028DEDB021D_impl*
end;//TvcmDockPanel.WMEraseBkgnd

procedure TvcmDockPanel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5028DEDB021D_var*
//#UC END# *479731C50290_5028DEDB021D_var*
begin
//#UC START# *479731C50290_5028DEDB021D_impl*
 vcmFree(f_ImageList);
 inherited;
//#UC END# *479731C50290_5028DEDB021D_impl*
end;//TvcmDockPanel.Cleanup

constructor TvcmDockPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5028DEDB021D_var*
//#UC END# *47D1602000C6_5028DEDB021D_var*
begin
//#UC START# *47D1602000C6_5028DEDB021D_impl*
 inherited Create(AOwner);
 BevelOuter := bvNone;
 Width := 0;
 Height := 0;
 f_pnlDock := TPanel.Create(Self);
 with f_pnlDock do
 begin
  Parent := Self;
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *47D1602000C6_5028DEDB021D_impl*
end;//TvcmDockPanel.Create

{$If NOT Defined(NoVCL)}
procedure TvcmDockPanel.Click;
//#UC START# *4F88469E0021_5028DEDB021D_var*
//#UC END# *4F88469E0021_5028DEDB021D_var*
begin
//#UC START# *4F88469E0021_5028DEDB021D_impl*
 inherited;
//#UC END# *4F88469E0021_5028DEDB021D_impl*
end;//TvcmDockPanel.Click
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmDockPanel.AlignControls(AControl: TControl;
 var Rect: TRect);
//#UC START# *5028E66702B0_5028DEDB021D_var*
 // http: //mdp.garant.ru/pages/viewpage.action?pageId=319489610&focusedCommentId=326767566#comment-326767566
var
 l_Rect: TRect;
//#UC END# *5028E66702B0_5028DEDB021D_var*
begin
//#UC START# *5028E66702B0_5028DEDB021D_impl*
 CopyRect(l_Rect, Rect);
 if Assigned(ToolbarDock) then
  case ToolbarDock.Position of
   dpTop: Dec(Rect.Bottom);
   dpBottom: Inc(Rect.Top);
   dpLeft: Dec(Rect.Right);
   dpRight: Inc(Rect.Left);
  end;
 inherited AlignControls(AControl, Rect);
 CopyRect(Rect, l_Rect);
//#UC END# *5028E66702B0_5028DEDB021D_impl*
end;//TvcmDockPanel.AlignControls
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmDockDef.SetHandlers(const aMaximizedLink: IvcmFormHandler;
 const aOpenLink: IvcmFormHandler;
 const aCloseLink: IvcmFormHandler);
//#UC START# *5028DE76021E_5028DD5E0384_var*
//#UC END# *5028DE76021E_5028DD5E0384_var*
begin
//#UC START# *5028DE76021E_5028DD5E0384_impl*
 if (aMaximizedLink <> nil) or (aOpenLink <> nil) or (aCloseLink <> nil) then
 begin
  BeginUpdate;
  try
   with DockPanel do
   begin
    CreateCloseBtn(aCloseLink);
     // - обработчик для кнопки ЗАКРЫТЬ
    CreateMaximizedBtn(aMaximizedLink);
     // - обработчик для кнопки РАЗВЕРНУТЬ
    CreateOpenBtn(aOpenLink);
     // - обработчик для кнопки ОТКРЫТЬ
   end;//with DockPanel do
  finally
   EndUpdate;
  end;//try..finally
 end;//(aMaximizedLink <> nil) or (aOpenLink <> nil) or (aCloseLink <> nil)
//#UC END# *5028DE76021E_5028DD5E0384_impl*
end;//TvcmDockDef.SetHandlers

procedure TvcmDockDef.SetFasten(aFasten: Boolean);
//#UC START# *502912550218_5028DD5E0384_var*
//#UC END# *502912550218_5028DD5E0384_var*
begin
//#UC START# *502912550218_5028DD5E0384_impl*
 BeginUpdate;
 try
  AllowDrag := not aFasten;
 finally
  EndUpdate;
 end;
//#UC END# *502912550218_5028DD5E0384_impl*
end;//TvcmDockDef.SetFasten

class function TvcmDockDef.Make(anOwner: TComponent;
 const aName: AnsiString;
 aPos: TvcmEffectiveToolBarPos): TvcmDockDef;
//#UC START# *502912730225_5028DD5E0384_var*
const
 cAlign: array [TvcmEffectiveToolBarPos] of TAlign = (alTop, alBottom, alLeft, alRight);
 cTabOrder: array [TvcmEffectiveToolBarPos] of Integer = (0, 4, 1, 3);
var
 l_Owner: TWinControl;
 l_AllowGripSize: Boolean;
 l_DockPanel: TvcmDockPanel;
//#UC END# *502912730225_5028DD5E0384_var*
begin
//#UC START# *502912730225_5028DD5E0384_impl*
 l_Owner := anOwner As TWinControl;
 l_DockPanel := TvcmDockPanel.Create(l_Owner);
 with l_DockPanel do
 begin
  Parent := l_Owner;
  TabOrder := cTabOrder[aPos];
  Align := cAlign[aPos];
 end;//with l_DockPanel
 Result := Create(anOwner);
 Result.Name := aName;
 l_DockPanel.ToolbarDock := Result;
 Result.DockPanel := l_DockPanel;
 Result.DockGroup := Integer(l_Owner);
 Result.DockGroupEnable := true;
 l_Owner.DisableAlign;
 try
  with Result do
  begin
   Align := alNone;
   l_AllowGripSize := aPos = vcm_tbpBottom;
   if l_AllowGripSize then
   begin
    if anOwner is TCustomForm then
     l_AllowGripSize := TCustomForm(anOwner).BorderStyle in [bsSizeable, bsSizeToolWin];
//    if anOwner is TvcmEntityForm then
//     l_AllowGripSize := l_AllowGripSize and (TvcmEntityForm(anOwner).ZoneType in (vcm_NotContainedForm - [vcm_ztFloating]));
   end;
   f_AllowGripSize := l_AllowGripSize;
   Case aPos of
    vcm_tbpBottom: 
    begin
     Position := dpBottom;
     Height := 2;
    end;//vcm_tbpBottom
    vcm_tbpRight: 
    begin
     Position := dpRight;
     Width := 2;
    end;//vcm_tbpRight
    vcm_tbpTop: 
    begin
     Position := dpTop;
    end;
    vcm_tbpLeft: 
    begin
     Position := dpLeft;
    end;
   end;//Case l_Index
   Align := cAlign[aPos];
   f_Pos := aPos;
  end;//with Result
 finally
  l_Owner.EnableAlign;
 end;//try..finally
 Assert(Result.DockPanel <> nil);
  // - панель должная всегда создаваться, она увеличивает размеры модальных и
  //   диалоговых форм для размещения панели инструментов.
//#UC END# *502912730225_5028DD5E0384_impl*
end;//TvcmDockDef.Make

function TvcmDockDef.SizeGripValid: Boolean;
//#UC START# *502912E4004F_5028DD5E0384_var*
//#UC END# *502912E4004F_5028DD5E0384_var*
begin
//#UC START# *502912E4004F_5028DD5E0384_impl*
 Result := f_AllowGripSize;
//#UC END# *502912E4004F_5028DD5E0384_impl*
end;//TvcmDockDef.SizeGripValid

procedure TvcmDockDef.WMSize(var Message: TWMSize);
//#UC START# *502913210162_5028DD5E0384_var*
//#UC END# *502913210162_5028DD5E0384_var*
begin
//#UC START# *502913210162_5028DD5E0384_impl*
 inherited;
//#UC END# *502913210162_5028DD5E0384_impl*
end;//TvcmDockDef.WMSize

procedure TvcmDockDef.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *5029133D01B2_5028DD5E0384_var*
//#UC END# *5029133D01B2_5028DD5E0384_var*
begin
//#UC START# *5029133D01B2_5028DD5E0384_impl*
 inherited;
 if SizeGripValid then
  Dec(Message.CalcSize_Params^.rgrc[0].Right, SizeGripWidth);
//#UC END# *5029133D01B2_5028DD5E0384_impl*
end;//TvcmDockDef.WMNCCalcSize

procedure TvcmDockDef.WMNCPaint(var Message: TMessage);
//#UC START# *502913B0004C_5028DD5E0384_var*
var
  R: TRect;
  DC: HDC;
//#UC END# *502913B0004C_5028DD5E0384_var*
begin
//#UC START# *502913B0004C_5028DD5E0384_impl*
 inherited;
 if SizeGripValid then
 begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  R.Left := R.Right - SizeGripWidth;                   
  DC := GetWindowDC(Handle);
  try
   Inc(R.Top);
{$IfDef Nemesis}
   AwfDrawSizeGrip(DC, R, cGarant2011BackColor);
{$ENDIF Nemesis}
  finally
   ReleaseDC(Handle, DC);
  end;//try..finally
 end;//SizeGripValid
//#UC END# *502913B0004C_5028DD5E0384_impl*
end;//TvcmDockDef.WMNCPaint

procedure TvcmDockDef.WMNChitTest(var Msg: TWMNCHitTest);
//#UC START# *502913DA02DA_5028DD5E0384_var*
var
 R: TRect;
//#UC END# *502913DA02DA_5028DD5E0384_var*
begin
//#UC START# *502913DA02DA_5028DD5E0384_impl*
 inherited;
 if SizeGripValid then
 begin
  R := BoundsRect;
  OffsetRect(R, -Left, -Top);
  InflateRect(R, -1, 0);
  R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
  R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
  Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
  if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
   Msg.Result := HTBOTTOMRIGHT;
 end;
//#UC END# *502913DA02DA_5028DD5E0384_impl*
end;//TvcmDockDef.WMNChitTest

function TvcmDockDef.pm_GetFullWidth: Integer;
//#UC START# *49930330017B_5028DD5E0384get_var*
//#UC END# *49930330017B_5028DD5E0384get_var*
begin
//#UC START# *49930330017B_5028DD5E0384get_impl*
 if f_DockPanel <> nil then
  Result := f_DockPanel.Width
 else
  Result := Width;
//#UC END# *49930330017B_5028DD5E0384get_impl*
end;//TvcmDockDef.pm_GetFullWidth

function TvcmDockDef.pm_GetFullHeight: Integer;
//#UC START# *4993033E03CC_5028DD5E0384get_var*
//#UC END# *4993033E03CC_5028DD5E0384get_var*
begin
//#UC START# *4993033E03CC_5028DD5E0384get_impl*
 if f_DockPanel <> nil then
  Result := f_DockPanel.Height
 else
  Result := Height;
//#UC END# *4993033E03CC_5028DD5E0384get_impl*
end;//TvcmDockDef.pm_GetFullHeight

function TvcmDockDef.pm_GetPos: TvcmEffectiveToolBarPos;
//#UC START# *4993035101C9_5028DD5E0384get_var*
//#UC END# *4993035101C9_5028DD5E0384get_var*
begin
//#UC START# *4993035101C9_5028DD5E0384get_impl*
 Result := f_Pos;
//#UC END# *4993035101C9_5028DD5E0384get_impl*
end;//TvcmDockDef.pm_GetPos

procedure TvcmDockDef.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5028DD5E0384_var*
//#UC END# *479731C50290_5028DD5E0384_var*
begin
//#UC START# *479731C50290_5028DD5E0384_impl*
 if TvcmToolbarDockListManager.Exists then
  TvcmToolbarDockListManager.Instance.DockList.Remove(Self);
 if Assigned(g_MenuManager) and (g_MenuManager is TvcmCustomMenuManager) then
  TvcmCustomMenuManager(g_MenuManager).CleanupSaveDockList(Self);
 inherited;
//#UC END# *479731C50290_5028DD5E0384_impl*
end;//TvcmDockDef.Cleanup

{$If NOT Defined(NoVCL)}
procedure TvcmDockDef.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_5028DD5E0384_var*
//#UC END# *4F2A599E0283_5028DD5E0384_var*
begin
//#UC START# *4F2A599E0283_5028DD5E0384_impl*
 // Не двигаемся внутри панели:
 if DockPanel <> nil then
 begin
  ALeft:=0;
  ATop:=0;
  f_DockPanel.SetDockBounds(ALeft, ATop, AWidth, AHeight);
 end;//if Assigned(f_DockPanel) then begin
 inherited SetBounds(ALeft, ATop, AWidth, AHeight);
//#UC END# *4F2A599E0283_5028DD5E0384_impl*
end;//TvcmDockDef.SetBounds
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmDockDef.Paint;
//#UC START# *5028A60300AD_5028DD5E0384_var*
//#UC END# *5028A60300AD_5028DD5E0384_var*
begin
//#UC START# *5028A60300AD_5028DD5E0384_impl*
 inherited;
//#UC END# *5028A60300AD_5028DD5E0384_impl*
end;//TvcmDockDef.Paint
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
function TvcmDockDef.SizeGripWidth: Integer;
//#UC START# *5028DD25024B_5028DD5E0384_var*
//#UC END# *5028DD25024B_5028DD5E0384_var*
begin
//#UC START# *5028DD25024B_5028DD5E0384_impl*
 if SizeGripValid then
  Result := GetSystemMetrics(SM_CYHSCROLL)
 else
  Result := inherited SizeGripWidth;
//#UC END# *5028DD25024B_5028DD5E0384_impl*
end;//TvcmDockDef.SizeGripWidth
{$IfEnd} // NOT Defined(NoTB97)

class function TvcmToolbarDockPanel.Make(AOwner: TComponent;
 aDock: TvcmDockDef = nil): TvcmToolbarDockPanel;
//#UC START# *5028A6450052_5028A43300CE_var*
//#UC END# *5028A6450052_5028A43300CE_var*
begin
//#UC START# *5028A6450052_5028A43300CE_impl*
 Result := TvcmToolbarDockPanel.Create(AOwner);
 Result.ToolbarDock := aDock;
//#UC END# *5028A6450052_5028A43300CE_impl*
end;//TvcmToolbarDockPanel.Make

{$If NOT Defined(NoVCL)}
procedure TvcmToolbarDockPanel.Paint;
//#UC START# *5028A60300AD_5028A43300CE_var*
//#UC END# *5028A60300AD_5028A43300CE_var*
begin
//#UC START# *5028A60300AD_5028A43300CE_impl*
 inherited;
//#UC END# *5028A60300AD_5028A43300CE_impl*
end;//TvcmToolbarDockPanel.Paint
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmDockPanelButton.pm_SetLink(const aValue: IvcmFormHandler);
//#UC START# *52A9948401B1_5028E443024Eset_var*
//#UC END# *52A9948401B1_5028E443024Eset_var*
begin
//#UC START# *52A9948401B1_5028E443024Eset_impl*
 // проверим передана ли форма
 Assert(Assigned(aValue.Form), 'В IvcmFormHandler не установлена форма.');
 // форма уже разрушается
 if (csDestroying in ComponentState) or
   (csDestroying in aValue.Form.ComponentState) then
  Exit;
 // установим обработчики
 OnClick := aValue.Handler;
 f_Form := aValue.Form;
 Hint := vcmStr(aValue.Hint);
 // покажем кнопку
 Visible := True;
 // подпишемся на нотификацию
 f_Form.FreeNotification(Self);
 // установим размеры toolbar-а
 if Assigned(f_DockPanel) then
  f_DockPanel.UpdateToolbarSize;
//#UC END# *52A9948401B1_5028E443024Eset_impl*
end;//TvcmDockPanelButton.pm_SetLink

class function TvcmDockPanelButton.Make(aOwner: TComponent;
 const aLink: IvcmFormHandler;
 aDockPanel: TvcmDockPanel;
 const aName: AnsiString): TvcmDockPanelButton;
//#UC START# *5028EA1900C1_5028E443024E_var*
//#UC END# *5028EA1900C1_5028E443024E_var*
begin
//#UC START# *5028EA1900C1_5028E443024E_impl*
 Result := Create(aOwner);
 with Result do
 begin
  Name := aName;
  DockPanel := aDockPanel;
  Link := aLink;
  Alignment := taCenter;
 end;//with Result
//#UC END# *5028EA1900C1_5028E443024E_impl*
end;//TvcmDockPanelButton.Make

procedure TvcmDockPanelButton.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5028E443024E_var*
//#UC END# *479731C50290_5028E443024E_var*
begin
//#UC START# *479731C50290_5028E443024E_impl*
 if Assigned(f_Form) then
  f_Form.RemoveFreeNotification(Self);
 inherited;
//#UC END# *479731C50290_5028E443024E_impl*
end;//TvcmDockPanelButton.Cleanup

procedure TvcmDockPanelButton.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_5028E443024E_var*
//#UC END# *4F884378016A_5028E443024E_var*
begin
//#UC START# *4F884378016A_5028E443024E_impl*
 inherited Notification(AComponent, Operation);
 if (AComponent = f_Form) then
  case Operation of
   opRemove:
   begin
    if Assigned(f_Form) then
     f_Form.RemoveFreeNotification(Self);
    f_Form  := nil;
    OnClick := nil;
    Visible := False;
    if Assigned(f_DockPanel) then
     f_DockPanel.UpdateToolbarSize;
   end;
  end;
//#UC END# *4F884378016A_5028E443024E_impl*
end;//TvcmDockPanelButton.Notification

constructor TvcmToolbar.Create(anOwner: TComponent;
 aDock: TvcmDockDef);
//#UC START# *5028A7DE0329_5028A4C0019B_var*
//#UC END# *5028A7DE0329_5028A4C0019B_var*
begin
//#UC START# *5028A7DE0329_5028A4C0019B_impl*
 inherited Create(anOwner);
 f_DockDef := aDock;
 if (f_DockDef <> nil) then
  f_Pos := f_DockDef.Pos;
//#UC END# *5028A7DE0329_5028A4C0019B_impl*
end;//TvcmToolbar.Create

{$If NOT Defined(NoVCL)}
procedure TvcmToolbar.RequestAlign;
//#UC START# *5022104B03A6_5028A4C0019B_var*
//#UC END# *5022104B03A6_5028A4C0019B_var*
begin
//#UC START# *5022104B03A6_5028A4C0019B_impl*
 if {(Width = 0) AND }(DockDef <> nil) AND Docked then
 begin
  DockDef.FArrangeToolbarsClipPoses := true;
  DockDef.f_CheckInvisibleDockPoses := true;
 end;//Width = 0
 inherited;
//#UC END# *5022104B03A6_5028A4C0019B_impl*
end;//TvcmToolbar.RequestAlign
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbar.BeginUpdate;
//#UC START# *5028A78000B6_5028A4C0019B_var*
//#UC END# *5028A78000B6_5028A4C0019B_var*
begin
//#UC START# *5028A78000B6_5028A4C0019B_impl*
 inherited;
//#UC END# *5028A78000B6_5028A4C0019B_impl*
end;//TvcmToolbar.BeginUpdate
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbar.EndUpdate;
//#UC START# *5028A78B015A_5028A4C0019B_var*
//#UC END# *5028A78B015A_5028A4C0019B_var*
begin
//#UC START# *5028A78B015A_5028A4C0019B_impl*
 inherited;
//#UC END# *5028A78B015A_5028A4C0019B_impl*
end;//TvcmToolbar.EndUpdate
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
function TvcmToolbar.NeedActivateMainForm: Boolean;
//#UC START# *552E0FD5016D_5028A4C0019B_var*
//#UC END# *552E0FD5016D_5028A4C0019B_var*
begin
//#UC START# *552E0FD5016D_5028A4C0019B_impl*
 Result := inherited NeedActivateMainForm;
 if (afw.Application.TabInterfaceType = afw_titTabs) then
  Result := Result and (GetActiveWindow <> Application.MainForm.Handle);
//#UC END# *552E0FD5016D_5028A4C0019B_impl*
end;//TvcmToolbar.NeedActivateMainForm
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmToolbar.ActivateMainForm;
//#UC START# *552E10010067_5028A4C0019B_var*
//#UC END# *552E10010067_5028A4C0019B_var*
begin
//#UC START# *552E10010067_5028A4C0019B_impl*
 if (afw.Application.TabInterfaceType = afw_titTabs) then
  SetActiveWindow(Application.MainForm.Handle);
 inherited;
//#UC END# *552E10010067_5028A4C0019B_impl*
end;//TvcmToolbar.ActivateMainForm
{$IfEnd} // NOT Defined(NoTB97)

//#UC START# *5028A4C0019Bimpl*
//#UC END# *5028A4C0019Bimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDockDefPrim);
 {* Регистрация TvcmDockDefPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmToolbarDef);
 {* Регистрация TvcmToolbarDef }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDockPanel);
 {* Регистрация TvcmDockPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDockDef);
 {* Регистрация TvcmDockDef }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmSeparatorDef);
 {* Регистрация TvcmSeparatorDef }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmToolbarDockPanel);
 {* Регистрация TvcmToolbarDockPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDockPanelButton);
 {* Регистрация TvcmDockPanelButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmToolbar);
 {* Регистрация TvcmToolbar }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
