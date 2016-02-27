{$IfNDef vcmContainedForm_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas"
// Стереотип: "Impurity"

{$Define vcmContainedForm_imp}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 _vcmContainedForm_ = class(_vcmContainedForm_Parent_, IvcmFormSetIconProvider, IvcmSizeableForm, IvcmContainedForm)
  private
   f_InsertedFormsCount: Integer;
   f_LastFocus: THandle;
   f_TabHistoryOpCount: Integer;
  private
   procedure ResetFocusedControl;
  protected
   function pm_GetMainFormContainer: TvcmTabbedContainerForm; virtual;
   function NeedMakeContainer: Boolean; virtual;
   function NeedUseTabs: Boolean; virtual;
   function MakeVCMContainer(aOpenKind: TvcmMainFormOpenKind): IvcmContainer;
   procedure DoOnContainerIsClosing; virtual;
   procedure DoInitContainedForm(aForm: TvcmMainForm); virtual;
   function DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean;
    const aOpenAfter: IvcmEntityForm = nil): IvcmContainedForm; virtual;
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetCanChangeSize: Boolean;
   function pm_GetCanBeMaximized: Boolean;
   procedure NotifyContainerIsClosing;
   function pm_GetIsEmpty: Boolean;
   function pm_GetCanDefineFormSetIcon: Boolean;
   procedure InitContainedForm;
   procedure SaveFocusedControl;
   procedure RestoreFocusedControl;
   function OpenNew(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean): IvcmContainedForm;
   function Get_AsForm: IvcmEntityForm;
   procedure CloseContainedForm;
   function pm_GetContainedFormHistory: IvcmHistory;
   procedure StartTabHistoryOperation;
   procedure FinishTabHistoryOperation;
   function pm_GetIsInHistoryOperation: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BecomeActive; override;
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
   function DoMakeClone(aNeedShow: Boolean): TvcmMainForm; override;
   procedure BecomeMainForm; override;
   procedure BeforeClosing; override;
   procedure ChildDataSourceChanged(const aChild: IvcmEntityForm;
    const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
    {* вызывается при изменении источника данных вложенной формы. }
   procedure UpdateMainCaption; override;
   procedure DoExitApplication; override;
  protected
   property MainFormContainer: TvcmTabbedContainerForm
    read pm_GetMainFormContainer;
 end;//_vcmContainedForm_

{$Else NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}

_vcmContainedForm_ = _vcmContainedForm_Parent_;

{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
{$Else vcmContainedForm_imp}

{$IfNDef vcmContainedForm_imp_impl}

{$Define vcmContainedForm_imp_impl}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
type
 THackCustomForm = class(TScrollingWinControl)
  private
   FActiveControl: TWinControl;
   FFocusedControl: TWinControl;
 end;//THackCustomForm

function _vcmContainedForm_.pm_GetMainFormContainer: TvcmTabbedContainerForm;
//#UC START# *537DB054011A_537D9BD30297get_var*
//#UC END# *537DB054011A_537D9BD30297get_var*
begin
//#UC START# *537DB054011A_537D9BD30297get_impl*
 Result := TvcmTabbedContainerFormDispatcher.Instance.GetFormContainer(Self);
//#UC END# *537DB054011A_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetMainFormContainer

function _vcmContainedForm_.NeedMakeContainer: Boolean;
//#UC START# *537DAFE702B7_537D9BD30297_var*
//#UC END# *537DAFE702B7_537D9BD30297_var*
begin
//#UC START# *537DAFE702B7_537D9BD30297_impl*
 Result := NeedUseTabs;
//#UC END# *537DAFE702B7_537D9BD30297_impl*
end;//_vcmContainedForm_.NeedMakeContainer

function _vcmContainedForm_.NeedUseTabs: Boolean;
//#UC START# *537DB22C0249_537D9BD30297_var*
//#UC END# *537DB22C0249_537D9BD30297_var*
begin
//#UC START# *537DB22C0249_537D9BD30297_impl*
 Result := TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs;
//#UC END# *537DB22C0249_537D9BD30297_impl*
end;//_vcmContainedForm_.NeedUseTabs

function _vcmContainedForm_.MakeVCMContainer(aOpenKind: TvcmMainFormOpenKind): IvcmContainer;
//#UC START# *53C783EB0182_537D9BD30297_var*
var
 l_Maker: IvcmContainerMaker;
//#UC END# *53C783EB0182_537D9BD30297_var*
begin
//#UC START# *53C783EB0182_537D9BD30297_impl*
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
 begin
  l_Maker := Self As IvcmContainerMaker;
  try
   Result := TvcmTabbedContainerFormDispatcher.Instance.MakeAndPlaceVCMContainer(l_Maker,
    As_IvcmEntityForm.AsContainer, aOpenKind, True);
  finally
   l_Maker := nil;
  end;//try..finally
 end
 else
  Result := Self.As_IvcmEntityForm.AsContainer;
//#UC END# *53C783EB0182_537D9BD30297_impl*
end;//_vcmContainedForm_.MakeVCMContainer

procedure _vcmContainedForm_.ResetFocusedControl;
//#UC START# *53EC851F0251_537D9BD30297_var*
//#UC END# *53EC851F0251_537D9BD30297_var*
begin
//#UC START# *53EC851F0251_537D9BD30297_impl*
 f_LastFocus := 0;
 THackCustomForm(Self).FFocusedControl := nil;
//#UC END# *53EC851F0251_537D9BD30297_impl*
end;//_vcmContainedForm_.ResetFocusedControl

procedure _vcmContainedForm_.DoOnContainerIsClosing;
//#UC START# *54363DD90183_537D9BD30297_var*
//#UC END# *54363DD90183_537D9BD30297_var*
begin
//#UC START# *54363DD90183_537D9BD30297_impl*
 // Ничего не делаем
//#UC END# *54363DD90183_537D9BD30297_impl*
end;//_vcmContainedForm_.DoOnContainerIsClosing

procedure _vcmContainedForm_.DoInitContainedForm(aForm: TvcmMainForm);
//#UC START# *546464260137_537D9BD30297_var*
//#UC END# *546464260137_537D9BD30297_var*
begin
//#UC START# *546464260137_537D9BD30297_impl*
 // Ничего не делаем
//#UC END# *546464260137_537D9BD30297_impl*
end;//_vcmContainedForm_.DoInitContainedForm

function _vcmContainedForm_.DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean;
 const aOpenAfter: IvcmEntityForm = nil): IvcmContainedForm;
//#UC START# *5566C7BD037F_537D9BD30297_var*
//#UC END# *5566C7BD037F_537D9BD30297_var*
begin
//#UC START# *5566C7BD037F_537D9BD30297_impl*
 Assert(False);
//#UC END# *5566C7BD037F_537D9BD30297_impl*
end;//_vcmContainedForm_.DoOpenNew

function _vcmContainedForm_.pm_GetFormSetImageIndex: Integer;
//#UC START# *53B649240001_537D9BD30297get_var*

 function lp_GetIconProvider(aControl: TControl): IvcmFormSetIconProvider;
 var
  l_Index: Integer;
 begin
  Result := nil;
  if Supports(aControl, IvcmFormSetIconProvider, Result) AND (aControl <> Self) then
   Exit
  else
  if (aControl is TWinControl) then
   for l_Index := 0 to Pred(TWinControl(aControl).ControlCount) do
   begin
    Result := lp_GetIconProvider(TWinControl(aControl).Controls[l_Index]);
    if (Result <> nil) then
     Exit;
   end;
 end;//lp_GetIconProvider

 function lp_GetIconViaProvider: Integer;
 var
  l_IconProvider: IvcmFormSetIconProvider;
 begin
  lp_GetIconViaProvider := -1;
  l_IconProvider := lp_GetIconProvider(Self);
  if (l_IconProvider <> nil) then
  try
   lp_GetIconViaProvider := l_IconProvider.FormSetImageIndex;
  finally
   l_IconProvider := nil;
  end;//try..finally
 end;//lp_GetIconViaProvider

var
 l_Form: IvcmEntityForm;
//#UC END# *53B649240001_537D9BD30297get_var*
begin
//#UC START# *53B649240001_537D9BD30297get_impl*
 Result := -1;
 l_Form := nil;
 if HasForm(vcm_ztMainObjectForm, true, @l_Form) then
 try
  if (l_Form.DataSource = nil) OR (l_Form.DataSource.UseCaseController = nil) then
   Result := lp_GetIconViaProvider
  else
   Result := l_Form.DataSource.UseCaseController.FormSetImageIndex;
 finally
  l_Form := nil;
 end;
//#UC END# *53B649240001_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetFormSetImageIndex

function _vcmContainedForm_.pm_GetCanChangeSize: Boolean;
//#UC START# *53C65D8F0393_537D9BD30297get_var*
//#UC END# *53C65D8F0393_537D9BD30297get_var*
begin
//#UC START# *53C65D8F0393_537D9BD30297get_impl*
 Result := True;
//#UC END# *53C65D8F0393_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetCanChangeSize

function _vcmContainedForm_.pm_GetCanBeMaximized: Boolean;
//#UC START# *53C65E120031_537D9BD30297get_var*
//#UC END# *53C65E120031_537D9BD30297get_var*
begin
//#UC START# *53C65E120031_537D9BD30297get_impl*
 Result := True;
//#UC END# *53C65E120031_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetCanBeMaximized

procedure _vcmContainedForm_.NotifyContainerIsClosing;
//#UC START# *54363D9C002A_537D9BD30297_var*
//#UC END# *54363D9C002A_537D9BD30297_var*
begin
//#UC START# *54363D9C002A_537D9BD30297_impl*
 DoOnContainerIsClosing;
//#UC END# *54363D9C002A_537D9BD30297_impl*
end;//_vcmContainedForm_.NotifyContainerIsClosing

function _vcmContainedForm_.pm_GetIsEmpty: Boolean;
//#UC START# *5444FA280090_537D9BD30297get_var*
//#UC END# *5444FA280090_537D9BD30297get_var*
begin
//#UC START# *5444FA280090_537D9BD30297get_impl*
 Result := f_InsertedFormsCount = 0;
//#UC END# *5444FA280090_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetIsEmpty

function _vcmContainedForm_.pm_GetCanDefineFormSetIcon: Boolean;
//#UC START# *54460951001B_537D9BD30297get_var*
//#UC END# *54460951001B_537D9BD30297get_var*
begin
//#UC START# *54460951001B_537D9BD30297get_impl*
 Result := True;
//#UC END# *54460951001B_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetCanDefineFormSetIcon

procedure _vcmContainedForm_.InitContainedForm;
//#UC START# *54645F3E019D_537D9BD30297_var*
//#UC END# *54645F3E019D_537D9BD30297_var*
begin
//#UC START# *54645F3E019D_537D9BD30297_impl*
 if NeedUseTabs then
  DoInitContainedForm(Self);
//#UC END# *54645F3E019D_537D9BD30297_impl*
end;//_vcmContainedForm_.InitContainedForm

procedure _vcmContainedForm_.SaveFocusedControl;
//#UC START# *54B90DB80019_537D9BD30297_var*
var
 l_H: THandle;
 l_C: TWinControl;
//#UC END# *54B90DB80019_537D9BD30297_var*
begin
//#UC START# *54B90DB80019_537D9BD30297_impl*
 l_H := Windows.GetFocus;
 l_C := FindControl(l_H);
 while Assigned(l_C) and (l_C <> Self) do
  l_C := l_C.Parent;
 if (l_C = Self) then
  f_LastFocus := l_H
 else
  f_LastFocus := 0;
//#UC END# *54B90DB80019_537D9BD30297_impl*
end;//_vcmContainedForm_.SaveFocusedControl

procedure _vcmContainedForm_.RestoreFocusedControl;
//#UC START# *54B90DDB026E_537D9BD30297_var*
var
 l_C: TWinControl;
//#UC END# *54B90DDB026E_537D9BD30297_var*
begin
//#UC START# *54B90DDB026E_537D9BD30297_impl*
 if (f_LastFocus <> 0) and
  IsWindow(f_LastFocus) then
 begin
  l_C := FindControl(f_LastFocus);
  if Assigned(l_C) and l_C.CanFocus then
  begin
   l_C.SetFocus;
   Exit;
  end;
 end;
 SetFocusToMainObjectForm;
//#UC END# *54B90DDB026E_537D9BD30297_impl*
end;//_vcmContainedForm_.RestoreFocusedControl

function _vcmContainedForm_.OpenNew(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean): IvcmContainedForm;
//#UC START# *5566B69D025F_537D9BD30297_var*
//#UC END# *5566B69D025F_537D9BD30297_var*
begin
//#UC START# *5566B69D025F_537D9BD30297_impl*
 Result := DoOpenNew(aOpenKind);
//#UC END# *5566B69D025F_537D9BD30297_impl*
end;//_vcmContainedForm_.OpenNew

function _vcmContainedForm_.Get_AsForm: IvcmEntityForm;
//#UC START# *5566B6C20183_537D9BD30297get_var*
//#UC END# *5566B6C20183_537D9BD30297get_var*
begin
//#UC START# *5566B6C20183_537D9BD30297get_impl*
 Result := Self as IvcmEntityForm;
//#UC END# *5566B6C20183_537D9BD30297get_impl*
end;//_vcmContainedForm_.Get_AsForm

procedure _vcmContainedForm_.CloseContainedForm;
//#UC START# *558BB88C039B_537D9BD30297_var*
//#UC END# *558BB88C039B_537D9BD30297_var*
begin
//#UC START# *558BB88C039B_537D9BD30297_impl*
 SafeClose;
//#UC END# *558BB88C039B_537D9BD30297_impl*
end;//_vcmContainedForm_.CloseContainedForm

function _vcmContainedForm_.pm_GetContainedFormHistory: IvcmHistory;
//#UC START# *559CD32C001E_537D9BD30297get_var*
//#UC END# *559CD32C001E_537D9BD30297get_var*
begin
//#UC START# *559CD32C001E_537D9BD30297get_impl*
 Result := History;
//#UC END# *559CD32C001E_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetContainedFormHistory

procedure _vcmContainedForm_.StartTabHistoryOperation;
//#UC START# *55D7043300C2_537D9BD30297_var*
//#UC END# *55D7043300C2_537D9BD30297_var*
begin
//#UC START# *55D7043300C2_537D9BD30297_impl*
 Inc(f_TabHistoryOpCount);
//#UC END# *55D7043300C2_537D9BD30297_impl*
end;//_vcmContainedForm_.StartTabHistoryOperation

procedure _vcmContainedForm_.FinishTabHistoryOperation;
//#UC START# *55D7043C01CF_537D9BD30297_var*
//#UC END# *55D7043C01CF_537D9BD30297_var*
begin
//#UC START# *55D7043C01CF_537D9BD30297_impl*
 Dec(f_TabHistoryOpCount);
//#UC END# *55D7043C01CF_537D9BD30297_impl*
end;//_vcmContainedForm_.FinishTabHistoryOperation

function _vcmContainedForm_.pm_GetIsInHistoryOperation: Boolean;
//#UC START# *55D7101400A6_537D9BD30297get_var*
//#UC END# *55D7101400A6_537D9BD30297get_var*
begin
//#UC START# *55D7101400A6_537D9BD30297get_impl*
 Result := (f_TabHistoryOpCount > 0);
//#UC END# *55D7101400A6_537D9BD30297get_impl*
end;//_vcmContainedForm_.pm_GetIsInHistoryOperation

procedure _vcmContainedForm_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_537D9BD30297_var*
//#UC END# *479731C50290_537D9BD30297_var*
begin
//#UC START# *479731C50290_537D9BD30297_impl*
 inherited;
//#UC END# *479731C50290_537D9BD30297_impl*
end;//_vcmContainedForm_.Cleanup

procedure _vcmContainedForm_.BecomeActive;
//#UC START# *4A8AE0FA03B2_537D9BD30297_var*
//#UC END# *4A8AE0FA03B2_537D9BD30297_var*
begin
//#UC START# *4A8AE0FA03B2_537D9BD30297_impl*
 TvcmTabbedContainerFormDispatcher.Instance.ContainedFormBecomeActive(Self);
//#UC END# *4A8AE0FA03B2_537D9BD30297_impl*
end;//_vcmContainedForm_.BecomeActive

function _vcmContainedForm_.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_537D9BD30297_var*
//#UC END# *4AD44CA20001_537D9BD30297_var*
begin
//#UC START# *4AD44CA20001_537D9BD30297_impl*
 Result := inherited InsertForm(aForm);
 if Result and (not (aForm.ZoneType in [vcm_ztFloating, vcm_ztReminder, vcm_ztForToolbarsInfo])) then
  Inc(f_InsertedFormsCount);
 if NeedUseTabs then
 begin
  ResetFocusedControl;
  if Supports(aForm, IvcmFormSetIconProvider) then
   TvcmTabbedContainerFormDispatcher.Instance.UpdateTab(aForm);
 end;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=561548074,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=561957726
//#UC END# *4AD44CA20001_537D9BD30297_impl*
end;//_vcmContainedForm_.InsertForm

function _vcmContainedForm_.DoMakeClone(aNeedShow: Boolean): TvcmMainForm;
//#UC START# *537DB1C100A8_537D9BD30297_var*
var
 l_Container: TvcmTabbedContainerForm;
//#UC END# *537DB1C100A8_537D9BD30297_var*
begin
//#UC START# *537DB1C100A8_537D9BD30297_impl*
 if NeedUseTabs then
 begin
  l_Container := pm_GetMainFormContainer;
  TvcmTabbedContainerFormDispatcher.Instance.StartMakingClone(l_Container);
  try
   Result := inherited DoMakeClone(aNeedShow);
   if (Result <> nil) then
   begin
    if aNeedShow AND (l_Container <> nil) AND (not l_Container.Visible) then
     l_Container.Show;
   end;
  finally
   TvcmTabbedContainerFormDispatcher.Instance.EndMakingClone;
  end;//try..finally
 end
 else
  Result := inherited DoMakeClone(aNeedShow);
 if (Result <> nil) AND aNeedShow then
  Result.Show;
//#UC END# *537DB1C100A8_537D9BD30297_impl*
end;//_vcmContainedForm_.DoMakeClone

procedure _vcmContainedForm_.BecomeMainForm;
//#UC START# *5385908301A7_537D9BD30297_var*
//#UC END# *5385908301A7_537D9BD30297_var*
begin
//#UC START# *5385908301A7_537D9BD30297_impl*
 TvcmTabbedContainerFormDispatcher.Instance.ContainedFormBecomeActive(Self)
//#UC END# *5385908301A7_537D9BD30297_impl*
end;//_vcmContainedForm_.BecomeMainForm

procedure _vcmContainedForm_.BeforeClosing;
//#UC START# *53A0288600CE_537D9BD30297_var*
//#UC END# *53A0288600CE_537D9BD30297_var*
begin
//#UC START# *53A0288600CE_537D9BD30297_impl*
 TvcmTabbedContainerFormDispatcher.Instance.SignalClosingForm(Self);
//#UC END# *53A0288600CE_537D9BD30297_impl*
end;//_vcmContainedForm_.BeforeClosing

procedure _vcmContainedForm_.ChildDataSourceChanged(const aChild: IvcmEntityForm;
 const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
 {* вызывается при изменении источника данных вложенной формы. }
//#UC START# *53B38B73003D_537D9BD30297_var*
var
 l_DS: IvcmFormDataSource;
//#UC END# *53B38B73003D_537D9BD30297_var*
begin
//#UC START# *53B38B73003D_537D9BD30297_impl*
 inherited;
 if (not VCMClosing) then
 begin
(*  if (anOld <> nil) then
   l_DS := anOld
  else*)
  if (aNew <> nil) then
   l_DS := aNew;
  if (l_DS <> nil) then
  try
   if l_DS.IsMainInFormSet(aChild) then
    TvcmTabbedContainerFormDispatcher.Instance.NotifyFormDataSourceChanged(As_IvcmEntityForm,
     aChild, l_DS);
  finally
   l_DS := nil;
  end;//try..finally
 end;//not VCMClosing
//#UC END# *53B38B73003D_537D9BD30297_impl*
end;//_vcmContainedForm_.ChildDataSourceChanged

procedure _vcmContainedForm_.UpdateMainCaption;
//#UC START# *53BCE11B01BB_537D9BD30297_var*
var
 l_Main : IvcmCString;
//#UC END# *53BCE11B01BB_537D9BD30297_var*
begin
//#UC START# *53BCE11B01BB_537D9BD30297_impl*
 if (not NeedUseTabs)then
  inherited
 else
 begin
  l_Main := MainCaption;
  CCaption := l_Main;
  TvcmTabbedContainerFormDispatcher.Instance.UpdateTabCaption(As_IvcmEntityForm,
   l_Main);
 end;
//#UC END# *53BCE11B01BB_537D9BD30297_impl*
end;//_vcmContainedForm_.UpdateMainCaption

procedure _vcmContainedForm_.DoExitApplication;
//#UC START# *53C6123F0050_537D9BD30297_var*
//#UC END# *53C6123F0050_537D9BD30297_var*
begin
//#UC START# *53C6123F0050_537D9BD30297_impl*
 TvcmTabbedContainerFormDispatcher.Instance.CloseAll;
//#UC END# *53C6123F0050_537D9BD30297_impl*
end;//_vcmContainedForm_.DoExitApplication
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$EndIf vcmContainedForm_imp_impl}

{$EndIf vcmContainedForm_imp}

