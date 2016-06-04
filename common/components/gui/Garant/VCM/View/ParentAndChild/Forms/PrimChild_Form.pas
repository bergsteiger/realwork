unit PrimChild_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimChild" MUID: (4F6B6646037F)
// Имя типа: "TPrimChildForm"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , F1Like_InternalOperations_Controls
 {$If Defined(Nemesis)}
 , nscFormsPageControl
 {$IfEnd} // Defined(Nemesis)
 , ElPgCtl
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimChildForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_ParentHeight: Integer;
   f_ParentParentHeight: Integer;
   f_ParentMinHeight: Integer;
   f_CalcHeightFlag: Boolean;
   f_ChildZone: TnscFormsPageControl;
   f_MainPageTab: TElTabSheet;
    {* MainDataCaption }
  private
   procedure UpdateMainTab(const aForm: IvcmEntityForm);
   procedure OnParentCanResize(Sender: TObject;
    var ANewWidth: Integer;
    var ANewHeight: Integer;
    var CanResize: Boolean);
    {* при восстановлении всех настроек и активной первой закладке не даём менять размер и запоминаем ANewHeight }
   procedure ChildZoneChange(Sender: TObject);
   procedure vcmContainerFormAfterRemoveForm(const aForm: IvcmEntityForm);
   procedure vcmContainerFormAfterInsertForm(const aForm: IvcmEntityForm);
   procedure vcmContainerFormNeedUpdateTab(aSender: TObject;
    const aForm: IvcmEntityForm);
   procedure ChildZoneTabSheetClick(Sender: TObject;
    Page: TElTabSheet);
  protected
   function ChildZoneMinHeight: Integer;
   function ActivePageHasOnlyEntityForm: Boolean;
   function GrandParentProportional: Boolean;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure BecomeInactive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoLoadFromSettings; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure AdjustSizeToFixed;
   procedure Switcher_BecomeActive_Execute(const aForm: IvcmEntityForm);
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParams);
   procedure Switcher_SetFirstPageActive_Execute;
   procedure Switcher_SetFirstPageActive(const aParams: IvcmExecuteParams);
  public
   property ChildZone: TnscFormsPageControl
    read f_ChildZone;
   property MainPageTab: TElTabSheet
    read f_MainPageTab;
    {* MainDataCaption }
 end;//TPrimChildForm

implementation

uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , Windows
 , l3MinMax
 , nsFormUtils
 , Messages
 , PresentationInterfaces
 , vtProportionalPanel
 , afwFacade
 , l3String
 , l3Interfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimChild_cutUsual_UserType
 , PrimChild_cutForDiction_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4F6B6646037Fimpl_uses*
 //#UC END# *4F6B6646037Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 THackControl = {abstract} class({$If NOT Defined(NoVCL)}
 TControl
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//THackControl

procedure TPrimChildForm.AdjustSizeToFixed;
//#UC START# *4F71E05E036B_4F6B6646037F_var*
{$IfNDef F1LikeButNotF1}
var
 l_C : IvcmContainer;
 l_H : Integer;
{$EndIf F1LikeButNotF1}
//#UC END# *4F71E05E036B_4F6B6646037F_var*
begin
//#UC START# *4F71E05E036B_4F6B6646037F_impl*
 {$IfNDef F1LikeButNotF1}
 l_C := NativemainForm;
 if (l_C <> nil) then
 begin
  l_H := l_C.AsForm.VCLWinControl.Height div 3;
  l_H := Max(ChildZoneMinHeight, l_H);
  if (Parent <> nil) then
   if (ChildZone.ActivePageIndex > 0) then
   begin
     //http://mdp.garant.ru/pages/viewpage.action?pageId=476808814
     Height := l_H;
     Parent.Height := l_H;
   end;
 end;//l_C <> nil
 {$EndIf F1LikeButNotF1}
//#UC END# *4F71E05E036B_4F6B6646037F_impl*
end;//TPrimChildForm.AdjustSizeToFixed

function TPrimChildForm.ChildZoneMinHeight: Integer;
//#UC START# *4F71E078021D_4F6B6646037F_var*
//#UC END# *4F71E078021D_4F6B6646037F_var*
begin
//#UC START# *4F71E078021D_4F6B6646037F_impl*
 Result := Max(ChildZone.TabHeight + 3, ChildZone.Constraints.MinHeight);
//#UC END# *4F71E078021D_4F6B6646037F_impl*
end;//TPrimChildForm.ChildZoneMinHeight

function TPrimChildForm.ActivePageHasOnlyEntityForm: Boolean;
//#UC START# *4F71E0B601D4_4F6B6646037F_var*
//#UC END# *4F71E0B601D4_4F6B6646037F_var*
begin
//#UC START# *4F71E0B601D4_4F6B6646037F_impl*
 Result := Assigned(ChildZone.ActivePage) and
   (ChildZone.ActivePage.ControlCount = 1) and
   (ChildZone.ActivePage.Controls[0] is TCustomForm) and
   Supports(ChildZone.ActivePage.Controls[0], IvcmEntityForm);
//#UC END# *4F71E0B601D4_4F6B6646037F_impl*
end;//TPrimChildForm.ActivePageHasOnlyEntityForm

function TPrimChildForm.GrandParentProportional: Boolean;
//#UC START# *4F71E0D10182_4F6B6646037F_var*
//#UC END# *4F71E0D10182_4F6B6646037F_var*
begin
//#UC START# *4F71E0D10182_4F6B6646037F_impl*
 Result := Assigned(Parent) and Assigned(Parent.Parent) and
  (Parent.Parent is TvtProportionalCustomPanel);
//#UC END# *4F71E0D10182_4F6B6646037F_impl*
end;//TPrimChildForm.GrandParentProportional

procedure TPrimChildForm.UpdateMainTab(const aForm: IvcmEntityForm);
//#UC START# *4F71E1C9011F_4F6B6646037F_var*
var
 l_Loop: Integer;
//#UC END# *4F71E1C9011F_4F6B6646037F_var*
begin
//#UC START# *4F71E1C9011F_4F6B6646037F_impl*
 // Иконка и название для фиктивной закладки
 with aForm do
  if Assigned(DataSource) and Assigned(DataSource.UseCaseController) then
   with DataSource.UseCaseController do
   begin
    MainPageTab.CCaption := MainCaption;
    MainPageTab.ImageIndex := MainImageIndex;
   end;//with DataSource.UseCaseController do
//#UC END# *4F71E1C9011F_4F6B6646037F_impl*
end;//TPrimChildForm.UpdateMainTab

procedure TPrimChildForm.OnParentCanResize(Sender: TObject;
 var ANewWidth: Integer;
 var ANewHeight: Integer;
 var CanResize: Boolean);
 {* при восстановлении всех настроек и активной первой закладке не даём менять размер и запоминаем ANewHeight }
//#UC START# *4F71E2050390_4F6B6646037F_var*
//#UC END# *4F71E2050390_4F6B6646037F_var*
begin
//#UC START# *4F71E2050390_4F6B6646037F_impl*
 if (Align = alClient) and
    Self.Dispatcher.IsRestoringAllSettings and
    (((ChildZone.ActivePageIndex = 0) and
     (ANewHeight > f_ParentMinHeight)) or
     //http://mdp.garant.ru/pages/viewpage.action?pageId=499491248
     ((ChildZone.ActivePageIndex <> 0) and
     (ANewHeight < (Parent.Parent.Height div 3)))) then
 begin
  f_ParentHeight := ANewHeight;
  CanResize := False;
 end;//Align = alClient..
//#UC END# *4F71E2050390_4F6B6646037F_impl*
end;//TPrimChildForm.OnParentCanResize

procedure TPrimChildForm.ChildZoneChange(Sender: TObject);
//#UC START# *4F71E25E0127_4F6B6646037F_var*

  {$If not defined(Admin) AND not defined(Monitorings)}
  function lp_ParentHeight: Integer;
  var
   l_ChildZoneManager: InsMainFormChildZoneManager;
   l_Height: Integer;
  begin
   if GrandParentProportional and (Parent.Parent.Height <> f_ParentParentHeight) then
    l_Height := (f_ParentHeight * Parent.Parent.Height) div f_ParentParentHeight
   else
    l_Height := f_ParentHeight;
   if Supports(afw.GetMainForm(Self),
               InsMainFormChildZoneManager,
               l_ChildZoneManager) then
    try
     l_ChildZoneManager.CorrectHeight(l_Height);
     f_ParentHeight := l_Height;
     f_ParentParentHeight := Parent.Parent.Height;
    finally
     l_ChildZoneManager := nil;
    end//try..finally
   else
   begin
    {$IfNDef F1LikeButNotF1}
    Assert(False);
    {$EndIf  F1LikeButNotF1}
   end;//Supports(afw.GetMainForm(Self)..
   Result := l_Height;
  end;//lp_ParentHeight
  {$IfEnd} //not Admin AND not Monitorings

  procedure lp_MoveFocusToParentZone;
   {* - перемещаем фокус в основную область, только если до этого он находился
        в области вкладок (CQ: OIT5-26688). }
  var
   l_Control: TControl;
  begin
   if (f_ParentMinHeight = Parent.Height) then
   begin
    l_Control := FindControl(Windows.GetFocus);
    if Assigned(l_Control) and (l_Control is TElTabSheet) then
     if (l_Control = MainPageTab) then
      NativeMainForm.SetFocusToMainObjectForm;
   end;//if (f_ParentMinHeight = Parent.Height) then
  end;//lp_MoveFocusToParentZone

//#UC END# *4F71E25E0127_4F6B6646037F_var*
begin
//#UC START# *4F71E25E0127_4F6B6646037F_impl*
 if (Parent <> nil) then
 begin
  if (f_ParentHeight <= 0) then
  begin
   if (Parent.Height = 0) then
   begin
    if GrandParentProportional then
     TvtProportionalCustomPanel(Parent.Parent).SmartSizing :=
      (ChildZone.ActivePage = MainPageTab);
    f_ParentParentHeight := Parent.Parent.Height;
    Parent.Height := Max(ChildZoneMinHeight, Parent.Parent.Height div 3);
   end//Parent.Height = 0
   else
    Height := Parent.Height;
  end;//f_ParentHeight <= 0
  //
  if (ChildZone.ActivePage = MainPageTab) then
  begin
   if f_CalcHeightFlag then
   begin
    f_ParentHeight := Parent.Height;
    f_ParentParentHeight := Parent.Parent.Height;
    f_CalcHeightFlag := false;
   end;//f_CalcHeightFlag
   if GrandParentProportional then
    TvtProportionalCustomPanel(Parent.Parent).SmartSizing := False;
   Parent.Height := ChildZoneMinHeight;
   (* Нижеследующий If - это заплатка. В этом месте Align д.б. уже не alNone *)
   if (Align = alNone) then
   begin
    Align := alClient;
    Height := Parent.Height;
   end;//Align = alNone
   Op_Common_ShowSplitter.Call(Container, false);
   f_ParentMinHeight := Parent.Height;
  end//ChildZone.ActivePage = MainPageTab
  else
  begin
   f_CalcHeightFlag := true;
   if (Parent.Height = 0) OR (Parent.Height <= f_ParentMinHeight) then
   begin
    {$If not defined(Admin) AND not defined(Monitorings)}
    Parent.Height := lp_ParentHeight;
    {$Else}
    Assert(false);
    {$IfEnd} //not Admin AND not Monitorings
    (* Нижеследующий If - это заплатка. В этом месте Align д.б. уже не alNone *)
    if (Align = alNone) then
    begin
     Align := alClient;
     if GrandParentProportional then
      Height := (f_ParentHeight * Parent.Parent.Height) div f_ParentParentHeight
     else
      Height := f_ParentHeight;
    end;//Align = alNone
   end;//Parent.Height = 0
   if GrandParentProportional then
    TvtProportionalCustomPanel(Parent.Parent).SmartSizing := True;
   Op_Common_ShowSplitter.Call(Container, true);
  end;//ChildZone.ActivePage = TabSheet1
  lp_MoveFocusToParentZone;
 end;//Parent <> nil
 AdjustSizeToFixed;
//#UC END# *4F71E25E0127_4F6B6646037F_impl*
end;//TPrimChildForm.ChildZoneChange

procedure TPrimChildForm.vcmContainerFormAfterRemoveForm(const aForm: IvcmEntityForm);
//#UC START# *4F71E27F0180_4F6B6646037F_var*
//#UC END# *4F71E27F0180_4F6B6646037F_var*
begin
//#UC START# *4F71E27F0180_4F6B6646037F_impl*
 Op_Common_CheckChildZone.Call(Container, true);
//#UC END# *4F71E27F0180_4F6B6646037F_impl*
end;//TPrimChildForm.vcmContainerFormAfterRemoveForm

procedure TPrimChildForm.vcmContainerFormAfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F71E2AE02D3_4F6B6646037F_var*
//#UC END# *4F71E2AE02D3_4F6B6646037F_var*
begin
//#UC START# *4F71E2AE02D3_4F6B6646037F_impl*
 Op_Common_CheckChildZone.Call(Container, false);
//#UC END# *4F71E2AE02D3_4F6B6646037F_impl*
end;//TPrimChildForm.vcmContainerFormAfterInsertForm

procedure TPrimChildForm.vcmContainerFormNeedUpdateTab(aSender: TObject;
 const aForm: IvcmEntityForm);
//#UC START# *4F71E2D500D1_4F6B6646037F_var*
var
 l_Tab : TElTabSheet;
 l_Cap : Il3CString;
 l_Img : Integer;
//#UC END# *4F71E2D500D1_4F6B6646037F_var*
begin
//#UC START# *4F71E2D500D1_4F6B6646037F_impl*
 UpdateMainTab(aForm);
 // Управлять иконкой может только форма лежащая непосредственно в закладке
 // иначе будет ситуация описанная в (CQ: 19057)
 if not (aForm.VCLWinControl.Parent is TElTabSheet) then
  Exit;
 if aForm.GetTabInfo(l_Cap, l_Img) then
 begin
  l_Tab := (aForm.VCLWinControl.Parent As TElTabSheet);
  if Assigned(l_Tab) then
  begin
   if (l_Img <> -1) then
    l_Tab.ImageIndex := l_Img;
   if not l3IsNil(l_Cap) then
    l_Tab.CCaption := l_Cap;
  end;//Assigned(l_Tab)
 end//aForm.GetTabInfo(l_Cap, l_Img)
 else
  nsSetPageIcon(aForm);
//#UC END# *4F71E2D500D1_4F6B6646037F_impl*
end;//TPrimChildForm.vcmContainerFormNeedUpdateTab

procedure TPrimChildForm.ChildZoneTabSheetClick(Sender: TObject;
 Page: TElTabSheet);
//#UC START# *4F71E3020328_4F6B6646037F_var*
//#UC END# *4F71E3020328_4F6B6646037F_var*
begin
//#UC START# *4F71E3020328_4F6B6646037F_impl*
 // Переносим фокус, если пользователь явно переключился на фиктивную вкладку
 // (CQ: OIT5-25327):
 if (ChildZone.ActivePage <> Page) and (Page = MainPageTab) then
  NativeMainForm.SetFocusToMainObjectForm;
//#UC END# *4F71E3020328_4F6B6646037F_impl*
end;//TPrimChildForm.ChildZoneTabSheetClick

procedure TPrimChildForm.Switcher_BecomeActive_Execute(const aForm: IvcmEntityForm);
//#UC START# *4AEF3E8C02F5_4F6B6646037Fexec_var*
//#UC END# *4AEF3E8C02F5_4F6B6646037Fexec_var*
begin
//#UC START# *4AEF3E8C02F5_4F6B6646037Fexec_impl*
 if (aForm.VCLWinControl.Parent <> nil) then
  ChildZone.ActivePage := aForm.VCLWinControl.Parent as TElTabSheet;
//#UC END# *4AEF3E8C02F5_4F6B6646037Fexec_impl*
end;//TPrimChildForm.Switcher_BecomeActive_Execute

procedure TPrimChildForm.Switcher_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with ISwitcher_BecomeActive_Params(aParams.Data) do
  Self.Switcher_BecomeActive_Execute(Form);
end;//TPrimChildForm.Switcher_BecomeActive

procedure TPrimChildForm.Switcher_SetFirstPageActive_Execute;
//#UC START# *4AF832C401A1_4F6B6646037Fexec_var*
//#UC END# *4AF832C401A1_4F6B6646037Fexec_var*
begin
//#UC START# *4AF832C401A1_4F6B6646037Fexec_impl*
 if (ChildZone.PageCount > 0) then
  ChildZone.ActivePageIndex := 0;
//#UC END# *4AF832C401A1_4F6B6646037Fexec_impl*
end;//TPrimChildForm.Switcher_SetFirstPageActive_Execute

procedure TPrimChildForm.Switcher_SetFirstPageActive(const aParams: IvcmExecuteParams);
begin
 Self.Switcher_SetFirstPageActive_Execute;
end;//TPrimChildForm.Switcher_SetFirstPageActive

procedure TPrimChildForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4F6B6646037F_var*
//#UC END# *49803F5503AA_4F6B6646037F_var*
begin
//#UC START# *49803F5503AA_4F6B6646037F_impl*
 inherited;
 Self.OnAfterInsertForm := vcmContainerFormAfterInsertForm;
 Self.OnAfterRemoveForm := vcmContainerFormAfterRemoveForm;
 Self.OnNeedUpdateTab := vcmContainerFormNeedUpdateTab;
 Dispatcher.History.AddForm(Self.As_IvcmEntityForm);
//#UC END# *49803F5503AA_4F6B6646037F_impl*
end;//TPrimChildForm.DoInit

procedure TPrimChildForm.BecomeActive;
//#UC START# *4A8AE0FA03B2_4F6B6646037F_var*
//#UC END# *4A8AE0FA03B2_4F6B6646037F_var*
begin
//#UC START# *4A8AE0FA03B2_4F6B6646037F_impl*
 if ActivePageHasOnlyEntityForm then
  ChildZone.ActivePage.Controls[0].Perform(CM_ACTIVATE,0,0)
 else
  Inherited BecomeActive;
//#UC END# *4A8AE0FA03B2_4F6B6646037F_impl*
end;//TPrimChildForm.BecomeActive

procedure TPrimChildForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4F6B6646037F_var*
//#UC END# *4A8E8F2E0195_4F6B6646037F_var*
begin
//#UC START# *4A8E8F2E0195_4F6B6646037F_impl*
 inherited;
 ActiveControl := MainPageTab;
 (* Сразу уменьшаем до размера закладки чтобы при открытии списка и создании
    формы не была видна серая рамка *)
 Height := ChildZoneMinHeight;
 with ChildZone do
 begin
   Left := 0;
   Top := 0;
   Width := 483;
   Height := 259;
   ActiveTabAfterDelete := 0;
   TabPosition := etpBottom;
   Images := dmStdRes.SmallImageList;
   TabIndex := 0;
   ActivePage := MainPageTab;
   Align := alClient;
   TabOrder := 0;
   TabStop := True;
   ParentColor := False;
   Constraints.MinHeight := 24;
   DockOrientation := doNoOrient;
 end;//with ChildZone
 ChildZone.OnTabSheetClick := ChildZoneTabSheetClick;
 ChildZone.OnChange := ChildZoneChange;
 with MainPageTab do
 begin
   Width := 479;
   Height := 235;
   PageControl := ChildZone;
   Caption := 'MainDataCaption';
 end;//with MainPageTab
 ChildZone.TabHeight := 28;
 ChildZone.Style := {etsFlatButtons}etsButtons;
 f_CalcHeightFlag := true;
 //Dispatcher.History.AddForm(self.As_IvcmEntityForm);
 ChildZoneChange(ChildZone);
//#UC END# *4A8E8F2E0195_4F6B6646037F_impl*
end;//TPrimChildForm.InitControls

procedure TPrimChildForm.BecomeInactive;
//#UC START# *4AD5FA8E03DD_4F6B6646037F_var*
//#UC END# *4AD5FA8E03DD_4F6B6646037F_var*
begin
//#UC START# *4AD5FA8E03DD_4F6B6646037F_impl*
 if ActivePageHasOnlyEntityForm then
  ChildZone.ActivePage.Controls[0].Perform(CM_DEACTIVATE,0,0)
 else
  Inherited BecomeInactive;
//#UC END# *4AD5FA8E03DD_4F6B6646037F_impl*
end;//TPrimChildForm.BecomeInactive

procedure TPrimChildForm.DoLoadFromSettings;
//#UC START# *4E7C2AA3037E_4F6B6646037F_var*
//#UC END# *4E7C2AA3037E_4F6B6646037F_var*
begin
//#UC START# *4E7C2AA3037E_4F6B6646037F_impl*
 inherited;
 AdjustSizeToFixed;
//#UC END# *4E7C2AA3037E_4F6B6646037F_impl*
end;//TPrimChildForm.DoLoadFromSettings

{$If NOT Defined(NoVCL)}
procedure TPrimChildForm.SetParent(AParent: TWinControl);
//#UC START# *4F71E1460089_4F6B6646037F_var*
//#UC END# *4F71E1460089_4F6B6646037F_var*
begin
//#UC START# *4F71E1460089_4F6B6646037F_impl*
 inherited;
 if Assigned(AParent) then
 begin
  if not Assigned(THackControl(AParent).OnCanResize) then
   THackControl(AParent).OnCanResize := Self.OnParentCanResize;
  ChildZoneChange(ChildZone);  
 end;//Assigned(AParent)
//#UC END# *4F71E1460089_4F6B6646037F_impl*
end;//TPrimChildForm.SetParent
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimChildForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Switcher, nil);
  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, nil, nil);
  PublishOpWithResult(en_Switcher, op_SetFirstPageActive, Switcher_SetFirstPageActive, nil, nil);
 end;//with Entities.Entities
end;//TPrimChildForm.InitEntities

procedure TPrimChildForm.MakeControls;
begin
 inherited;
 with AddUsertype(cutUsualName,
  str_cutUsualCaption,
  str_cutUsualCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cutUsualName
 with AddUsertype(cutForDictionName,
  str_cutForDictionCaption,
  str_cutForDictionCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cutForDictionName
 f_ChildZone := TnscFormsPageControl.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := Self;
 with DefineZone(vcm_ztChild, ChildZone) do
 begin
  CanClose := vcm_ccEnable;
 end;//with DefineZone(vcm_ztChild
 f_MainPageTab := TElTabSheet.Create(Self);
 f_MainPageTab.Name := 'MainPageTab';
 f_MainPageTab.Parent := ChildZone;
 f_MainPageTab.Caption := 'MainDataCaption';
end;//TPrimChildForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimChildForm);
 {* Регистрация PrimChild }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
